#include "ln_fft.h"
#include "ln_dtype_transfer.h"
#include "ln_complex.h"
#include "ln_half.h"

#define POCKETFFT_NO_MULTITHREADING
#include "third_party/pocketfft/pocketfft_hdronly.h"

#include <algorithm>
#include <cmath>
#include <complex>
#include <cstdio>
#include <cstring>
#include <exception>
#include <vector>

static void ferr(ln_error *err, const char *msg)
{
    if (err) {
        std::snprintf(err->message, sizeof(err->message), "%s", msg);
    }
}

static void ferrf(ln_error *err, const char *fmt, const char *a, const char *b)
{
    if (err) std::snprintf(err->message, sizeof(err->message), fmt, a, b);
}

static bool is_integral_or_bool(const ln_dtype *dt)
{
    return dt->kind == 'b' || dt->kind == 'i' || dt->kind == 'u';
}

static const ln_dtype *fft_complex_dtype(const ln_dtype *in)
{
    switch (in->type_num) {
        case LN_CFLOAT: return ln_dtype_by_num(LN_CFLOAT);
        case LN_CDOUBLE: return ln_dtype_by_num(LN_CDOUBLE);
        case LN_CLONGDOUBLE: return ln_dtype_by_num(LN_CLONGDOUBLE);
        case LN_HALF:
        case LN_FLOAT: return ln_dtype_by_num(LN_CFLOAT);
        case LN_LONGDOUBLE: return ln_dtype_by_num(LN_CLONGDOUBLE);
        case LN_DOUBLE: return ln_dtype_by_num(LN_CDOUBLE);
        default:
            if (is_integral_or_bool(in)) return ln_dtype_by_num(LN_CDOUBLE);
            return NULL;
    }
}

static const ln_dtype *rfft_real_compute_dtype(const ln_dtype *in)
{
    if (in->kind == 'c') return NULL;
    switch (in->type_num) {
        case LN_HALF:
        case LN_FLOAT: return ln_dtype_by_num(LN_FLOAT);
        case LN_LONGDOUBLE: return ln_dtype_by_num(LN_LONGDOUBLE);
        case LN_DOUBLE: return ln_dtype_by_num(LN_DOUBLE);
        default:
            if (is_integral_or_bool(in)) return ln_dtype_by_num(LN_DOUBLE);
            return NULL;
    }
}

static const ln_dtype *complex_for_real(const ln_dtype *real)
{
    switch (real->type_num) {
        case LN_FLOAT: return ln_dtype_by_num(LN_CFLOAT);
        case LN_DOUBLE: return ln_dtype_by_num(LN_CDOUBLE);
        case LN_LONGDOUBLE: return ln_dtype_by_num(LN_CLONGDOUBLE);
        default: return NULL;
    }
}

static int real_precision_rank(const ln_dtype *dt)
{
    if (!dt) return -1;
    switch (dt->type_num) {
        case LN_HALF: return 0;
        case LN_FLOAT: case LN_CFLOAT: return 1;
        case LN_DOUBLE: case LN_CDOUBLE: return 2;
        case LN_LONGDOUBLE: case LN_CLONGDOUBLE: return 3;
        default: return -1;
    }
}

static const ln_dtype *real_component_dtype(const ln_dtype *dt)
{
    if (!dt) return NULL;
    switch (dt->type_num) {
        case LN_HALF: return ln_dtype_by_num(LN_HALF);
        case LN_FLOAT: case LN_CFLOAT: return ln_dtype_by_num(LN_FLOAT);
        case LN_DOUBLE: case LN_CDOUBLE: return ln_dtype_by_num(LN_DOUBLE);
        case LN_LONGDOUBLE: case LN_CLONGDOUBLE: return ln_dtype_by_num(LN_LONGDOUBLE);
        default: return NULL;
    }
}

static const ln_dtype *promote_complex_compute_for_out(const ln_dtype *natural,
                                                        const ln_dtype *out)
{
    if (!out || out->kind!='c') return natural;
    return real_precision_rank(out)>real_precision_rank(natural) ? out : natural;
}

static const ln_dtype *irfft_public_real_dtype(const ln_dtype *in)
{
    switch (in->type_num) {
        case LN_CFLOAT: return ln_dtype_by_num(LN_FLOAT);
        case LN_CDOUBLE: return ln_dtype_by_num(LN_DOUBLE);
        case LN_CLONGDOUBLE: return ln_dtype_by_num(LN_LONGDOUBLE);
        case LN_HALF: return ln_dtype_by_num(LN_HALF);
        case LN_FLOAT: return ln_dtype_by_num(LN_FLOAT);
        case LN_DOUBLE: return ln_dtype_by_num(LN_DOUBLE);
        case LN_LONGDOUBLE: return ln_dtype_by_num(LN_LONGDOUBLE);
        default:
            if (is_integral_or_bool(in)) return ln_dtype_by_num(LN_DOUBLE);
            return NULL;
    }
}

static const ln_dtype *irfft_compute_real_dtype(const ln_dtype *in)
{
    const ln_dtype *pub = irfft_public_real_dtype(in);
    if (!pub) return NULL;
    return pub->type_num == LN_HALF ? ln_dtype_by_num(LN_FLOAT) : pub;
}

static const ln_dtype *fft_norm_real_dtype(const ln_dtype *in)
{
    switch (in->type_num) {
        case LN_HALF: return ln_dtype_by_num(LN_HALF);
        case LN_FLOAT: case LN_CFLOAT: return ln_dtype_by_num(LN_FLOAT);
        case LN_DOUBLE: case LN_CDOUBLE: return ln_dtype_by_num(LN_DOUBLE);
        case LN_LONGDOUBLE: case LN_CLONGDOUBLE: return ln_dtype_by_num(LN_LONGDOUBLE);
        default:
            if (is_integral_or_bool(in)) return ln_dtype_by_num(LN_DOUBLE);
            return NULL;
    }
}

static long double norm_reciprocal(ln_intp n, const ln_dtype *real_dt, bool ortho)
{
    /* _raw_fft computes sqrt/reciprocal with dtype=real_dtype.  In particular,
     * float16 rounds the normalization factor to half before the float32
     * PocketFFT loop consumes it. */
    switch (real_dt->type_num) {
        case LN_HALF: {
            ln_half hn=ln_double_to_half((double)n);
            float x=ln_half_to_float(hn);
            if (ortho) {
                ln_half hs=ln_float_to_half(std::sqrt(x));
                x=ln_half_to_float(hs);
            }
            return (long double)ln_half_to_float(ln_float_to_half(1.0f/x));
        }
        case LN_FLOAT: {
            float x=(float)n;
            if (ortho) x=std::sqrt(x);
            return (long double)(1.0f/x);
        }
        case LN_DOUBLE: {
            double x=(double)n;
            if (ortho) x=std::sqrt(x);
            return (long double)(1.0/x);
        }
        case LN_LONGDOUBLE: {
            long double x=(long double)n;
            if (ortho) x=std::sqrt(x);
            return 1.0L/x;
        }
        default: return 0.0L;
    }
}

static long double norm_factor(ln_intp n, bool inverse, ln_fft_norm norm,
                               const ln_dtype *real_dt)
{
    /* _raw_fft swaps forward/backward normalization for inverse transforms. */
    if (norm == LN_FFT_NORM_ORTHO) return norm_reciprocal(n,real_dt,true);
    bool scale = (!inverse && norm == LN_FFT_NORM_FORWARD) ||
                 ( inverse && norm == LN_FFT_NORM_BACKWARD);
    return scale ? norm_reciprocal(n,real_dt,false) : 1.0L;
}

static ln_array *new_like_axis(const ln_array *a, ln_intp axis_len,
                               const ln_dtype *dt, int axis, int zeroed,
                               ln_error *err)
{
    ln_intp dims[LN_MAXDIMS];
    if (a->nd < 1 || a->nd > LN_MAXDIMS) {
        ferr(err, "invalid FFT input dimensionality"); return NULL;
    }
    for (int i=0; i<a->nd; ++i) dims[i] = a->dimensions[i];
    dims[axis] = axis_len;
    /* Port of ctors.c:PyArray_NewLikeArrayWithShape(..., NPY_KEEPORDER).
     * C/F-contiguous prototypes stay C/F; otherwise preserve the prototype's
     * axis ordering by sorting descending absolute input strides and building
     * a packed output in that permutation. */
    if (a->nd <= 1 || (a->flags & LN_ARRAY_C_CONTIGUOUS)) {
        return ln_array_new(a->nd, dims, dt, 0, zeroed, err);
    }
    if (a->flags & LN_ARRAY_F_CONTIGUOUS) {
        return ln_array_new(a->nd, dims, dt, 1, zeroed, err);
    }
    ln_array *out = ln_array_new(a->nd, dims, dt, 0, zeroed, err);
    if (!out) return NULL;
    int perm[LN_MAXDIMS];
    for (int i=0;i<a->nd;++i) perm[i]=i;
    /* Equivalent to shape.c:_npy_stride_sort_item_comparator: descending
     * absolute stride, axis number as the stable tiebreaker. */
    for (int i=1;i<a->nd;++i) {
        int x=perm[i], j=i-1;
        ln_intp xs=a->strides[x] < 0 ? -a->strides[x] : a->strides[x];
        while (j>=0) {
            int y=perm[j];
            ln_intp ys=a->strides[y] < 0 ? -a->strides[y] : a->strides[y];
            if (ys > xs || (ys==xs && y < x)) break;
            perm[j+1]=perm[j];--j;
        }
        perm[j+1]=x;
    }
    ln_intp stride=(ln_intp)dt->elsize;
    for (int i=a->nd-1;i>=0;--i) {
        int d=perm[i];out->strides[d]=stride;stride*=dims[d];
    }
    ln_update_contiguous_flags(out);
    return out;
}

static char *ptr_at(const ln_array *a, const ln_intp *coords)
{
    char *p = a->data;
    for (int i=0; i<a->nd; ++i) p += coords[i] * a->strides[i];
    return p;
}

static int copy_crop_cast(const ln_array *src, ln_array *dst, int axis,
                          ln_error *err)
{
    ln_intp coords[LN_MAXDIMS] = {0};
    ln_intp outer = 1;
    for (int d=0; d<src->nd; ++d) {
        if (d == axis) continue;
        if (src->dimensions[d] == 0) return 0;
        if (outer > INTPTR_MAX / src->dimensions[d]) {
            ferr(err, "FFT copy size overflow"); return -1;
        }
        outer *= src->dimensions[d];
    }
    ln_intp ncopy = std::min(src->dimensions[axis], dst->dimensions[axis]);
    if (ncopy <= 0) return 0;

    for (ln_intp it=0; it<outer; ++it) {
        char *sp = ptr_at(src, coords);
        char *dp = ptr_at(dst, coords);
        if (ln_cast_strided_numeric(sp, src->strides[axis], src->descr,
                                    dp, dst->strides[axis], dst->descr,
                                    ncopy, err) < 0) return -1;
        /* Odometer over non-transform axes. */
        for (int d=src->nd-1; d>=0; --d) {
            if (d == axis) continue;
            if (++coords[d] < src->dimensions[d]) break;
            coords[d] = 0;
        }
    }
    return 0;
}

template<typename T>
static void do_c2c(const ln_array *in, ln_array *out, int axis,
                   bool inverse, T factor)
{
    pocketfft::shape_t shape((size_t)in->nd);
    pocketfft::stride_t si((size_t)in->nd), so((size_t)out->nd);
    for (int d=0; d<in->nd; ++d) {
        shape[(size_t)d] = (size_t)in->dimensions[d];
        si[(size_t)d] = (ptrdiff_t)in->strides[d];
        so[(size_t)d] = (ptrdiff_t)out->strides[d];
    }
    pocketfft::shape_t axes = {(size_t)axis};
    pocketfft::c2c(shape, si, so, axes,
                   inverse ? pocketfft::BACKWARD : pocketfft::FORWARD,
                   reinterpret_cast<const std::complex<T> *>(in->data),
                   reinterpret_cast<std::complex<T> *>(out->data),
                   factor, 1);
}

template<typename T>
static void do_r2c(const ln_array *in, ln_array *out, int axis, T factor)
{
    pocketfft::shape_t shape((size_t)in->nd);
    pocketfft::stride_t si((size_t)in->nd), so((size_t)out->nd);
    for (int d=0; d<in->nd; ++d) {
        shape[(size_t)d] = (size_t)in->dimensions[d];
        si[(size_t)d] = (ptrdiff_t)in->strides[d];
        so[(size_t)d] = (ptrdiff_t)out->strides[d];
    }
    pocketfft::r2c(shape, si, so, (size_t)axis, pocketfft::FORWARD,
                   reinterpret_cast<const T *>(in->data),
                   reinterpret_cast<std::complex<T> *>(out->data),
                   factor, 1);
}

template<typename T>
static void do_c2r(const ln_array *in, ln_array *out, int axis, T factor)
{
    pocketfft::shape_t shape((size_t)out->nd);
    pocketfft::stride_t si((size_t)in->nd), so((size_t)out->nd);
    for (int d=0; d<out->nd; ++d) {
        shape[(size_t)d] = (size_t)out->dimensions[d];
        si[(size_t)d] = (ptrdiff_t)in->strides[d];
        so[(size_t)d] = (ptrdiff_t)out->strides[d];
    }
    pocketfft::c2r(shape, si, so, (size_t)axis, pocketfft::BACKWARD,
                   reinterpret_cast<const std::complex<T> *>(in->data),
                   reinterpret_cast<T *>(out->data), factor, 1);
}

extern "C" ln_array *ln_fft_fft(const ln_array *a, ln_intp n, int axis,
                                  int inverse, ln_fft_norm norm,
                                  const ln_dtype *requested_out_dtype,
                                  ln_error *err)
{
    if (!a || a->nd < 1 || axis < 0 || axis >= a->nd || n < 1) {
        ferr(err, n < 1 ? "Invalid number of FFT data points specified" : "invalid FFT axis");
        return NULL;
    }
    const ln_dtype *cdt = fft_complex_dtype(a->descr);
    if (!cdt) { ferr(err, "unsupported FFT input dtype"); return NULL; }
    /* Exact complex-input loops retain their native computation precision. */
    if (a->descr->kind != 'c')
        cdt = promote_complex_compute_for_out(cdt, requested_out_dtype);
    if (!cdt) { ferr(err, "unsupported FFT input dtype"); return NULL; }
    ln_array *tmp = new_like_axis(a, n, cdt, axis, 1, err);
    if (!tmp) return NULL;
    if (copy_crop_cast(a, tmp, axis, err) < 0) { ln_array_free(tmp); return NULL; }
    ln_array *out = new_like_axis(a, n, cdt, axis, 0, err);
    if (!out) { ln_array_free(tmp); return NULL; }
    const ln_dtype *norm_dt=fft_norm_real_dtype(a->descr);
    long double f = norm_factor(n, inverse != 0, norm, norm_dt);
    try {
        switch (cdt->type_num) {
            case LN_CFLOAT: do_c2c<float>(tmp,out,axis,inverse!=0,(float)f); break;
            case LN_CDOUBLE: do_c2c<double>(tmp,out,axis,inverse!=0,(double)f); break;
            case LN_CLONGDOUBLE: do_c2c<long double>(tmp,out,axis,inverse!=0,(long double)f); break;
            default: ferr(err,"unsupported FFT complex dtype"); ln_array_free(tmp); ln_array_free(out); return NULL;
        }
    } catch (const std::exception &e) {
        ferr(err,e.what()); ln_array_free(tmp); ln_array_free(out); return NULL;
    }
    ln_array_free(tmp);
    return out;
}

extern "C" ln_array *ln_fft_rfft(const ln_array *a, ln_intp n, int axis,
                                   ln_fft_norm norm,
                                   const ln_dtype *requested_out_dtype,
                                   ln_error *err)
{
    if (!a || a->nd < 1 || axis < 0 || axis >= a->nd || n < 1) {
        ferr(err, n < 1 ? "Invalid number of FFT data points specified" : "invalid FFT axis"); return NULL;
    }
    const ln_dtype *rdt = rfft_real_compute_dtype(a->descr);
    if (!rdt) { ferr(err,"ufunc 'rfft' not supported for complex input"); return NULL; }
    const ln_dtype *cdt = complex_for_real(rdt);
    /* Exact real FFT input loops keep their computation precision even when
     * the output is wider. Half/integer inputs can select a wider loop. */
    const ln_dtype *promoted_cdt=(a->descr->type_num==LN_FLOAT ||
            a->descr->type_num==LN_DOUBLE || a->descr->type_num==LN_LONGDOUBLE)
        ? cdt : promote_complex_compute_for_out(cdt,requested_out_dtype);
    if (promoted_cdt!=cdt) { cdt=promoted_cdt; rdt=real_component_dtype(cdt); }
    ln_array *tmp = new_like_axis(a,n,rdt,axis,1,err);
    if (!tmp) return NULL;
    if (copy_crop_cast(a,tmp,axis,err)<0) { ln_array_free(tmp); return NULL; }
    ln_intp nout = n/2 + 1;
    ln_array *out = new_like_axis(a,nout,cdt,axis,0,err);
    if (!out) { ln_array_free(tmp); return NULL; }
    const ln_dtype *norm_dt=fft_norm_real_dtype(a->descr);
    long double f = norm_factor(n,false,norm,norm_dt);
    try {
        switch (rdt->type_num) {
            case LN_FLOAT: do_r2c<float>(tmp,out,axis,(float)f); break;
            case LN_DOUBLE: do_r2c<double>(tmp,out,axis,(double)f); break;
            case LN_LONGDOUBLE: do_r2c<long double>(tmp,out,axis,(long double)f); break;
            default: ferr(err,"unsupported rfft dtype"); ln_array_free(tmp); ln_array_free(out); return NULL;
        }
    } catch (const std::exception &e) {
        ferr(err,e.what()); ln_array_free(tmp); ln_array_free(out); return NULL;
    }
    ln_array_free(tmp);
    return out;
}

extern "C" ln_array *ln_fft_irfft(const ln_array *a, ln_intp n, int axis,
                                    ln_fft_norm norm,
                                    const ln_dtype *requested_out_dtype,
                                    ln_error *err)
{
    if (!a || a->nd < 1 || axis < 0 || axis >= a->nd || n < 1) {
        ferr(err, n < 1 ? "Invalid number of FFT data points specified" : "invalid FFT axis"); return NULL;
    }
    const ln_dtype *public_rdt = irfft_public_real_dtype(a->descr);
    const ln_dtype *compute_rdt = irfft_compute_real_dtype(a->descr);
    if (!public_rdt || !compute_rdt) { ferr(err,"unsupported irfft input dtype"); return NULL; }
    /* For real inputs there is no exact complex-input loop.  NumPy's ufunc
     * resolver may therefore choose a wider loop to match out=.  Exact
     * complex inputs retain their native F/D/G loop and cast on writeback. */
    if (a->descr->kind!='c' && requested_out_dtype) {
        const ln_dtype *want=real_component_dtype(requested_out_dtype);
        if (want && want->type_num==LN_HALF) want=ln_dtype_by_num(LN_FLOAT);
        if (want && real_precision_rank(want)>=real_precision_rank(compute_rdt)) {
            compute_rdt=want;public_rdt=want;
        }
    }
    const ln_dtype *cdt = complex_for_real(compute_rdt);
    ln_intp nin_needed = n/2 + 1;
    ln_array *tmp = new_like_axis(a,nin_needed,cdt,axis,1,err);
    if (!tmp) return NULL;
    if (copy_crop_cast(a,tmp,axis,err)<0) { ln_array_free(tmp); return NULL; }
    /* Transform into compute precision first. NumPy's gufunc then casts to the
     * public out dtype (notably float16 -> float32 compute -> float16 result). */
    ln_array *work = new_like_axis(a,n,compute_rdt,axis,0,err);
    if (!work) { ln_array_free(tmp); return NULL; }
    const ln_dtype *norm_dt=fft_norm_real_dtype(a->descr);
    long double f = norm_factor(n,true,norm,norm_dt);
    try {
        switch (compute_rdt->type_num) {
            case LN_FLOAT: do_c2r<float>(tmp,work,axis,(float)f); break;
            case LN_DOUBLE: do_c2r<double>(tmp,work,axis,(double)f); break;
            case LN_LONGDOUBLE: do_c2r<long double>(tmp,work,axis,(long double)f); break;
            default: ferr(err,"unsupported irfft compute dtype"); ln_array_free(tmp); ln_array_free(work); return NULL;
        }
    } catch (const std::exception &e) {
        ferr(err,e.what()); ln_array_free(tmp); ln_array_free(work); return NULL;
    }
    ln_array_free(tmp);
    if (public_rdt->type_num == compute_rdt->type_num) return work;
    ln_array *out = new_like_axis(a,n,public_rdt,axis,0,err);
    if (!out) { ln_array_free(work); return NULL; }
    if (ln_fft_copy_into(work,out,err)<0) { ln_array_free(work); ln_array_free(out); return NULL; }
    ln_array_free(work);
    return out;
}

static int kind_order(char k)
{
    switch (k) { case 'b': return 0; case 'i': case 'u': return 1; case 'f': return 2; case 'c': return 3; default: return 99; }
}

static int same_kind(const ln_dtype *from, const ln_dtype *to)
{
    int a=kind_order(from->kind), b=kind_order(to->kind);
    if (a==99 || b==99) return 0;
    return a <= b;
}

extern "C" int ln_fft_copy_into(const ln_array *src, ln_array *dst, ln_error *err)
{
    if (!src || !dst || src->nd != dst->nd) { ferr(err,"output array has wrong shape."); return -1; }
    if (!(dst->flags & LN_ARRAY_WRITEABLE)) { ferr(err,"FFT output array is read-only"); return -1; }
    for (int d=0; d<src->nd; ++d) if (src->dimensions[d] != dst->dimensions[d]) {
        ferr(err,"output array has wrong shape."); return -1;
    }
    if (!same_kind(src->descr,dst->descr)) {
        ferrf(err,"Cannot cast ufunc output from dtype('%s') to dtype('%s') with casting rule 'same_kind'",src->descr->name,dst->descr->name);
        return -1;
    }
    ln_intp coords[LN_MAXDIMS]={0};
    ln_intp total=ln_array_size(src);
    for (ln_intp i=0; i<total; ++i) {
        char *sp=ptr_at(src,coords), *dp=ptr_at(dst,coords);
        if (ln_cast_strided_numeric(sp,0,src->descr,dp,0,dst->descr,1,err)<0) return -1;
        for (int d=src->nd-1; d>=0; --d) {
            if (++coords[d] < src->dimensions[d]) break;
            coords[d]=0;
        }
    }
    return 0;
}
