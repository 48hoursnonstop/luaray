#include "ln_dot.h"
#include "ln_half.h"
#include "ln_complex.h"
#include "ln_dtype_transfer.h"
#include "ln_ufunc_loops.h"

#include <cblas.h>
#include <limits.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*
 * Source-derived subset of:
 *   numpy/_core/src/multiarray/multiarraymodule.c
 *     PyArray_MatrixProduct2, PyArray_InnerProduct
 *   numpy/_core/src/multiarray/common.c
 *     new_array_for_sum (strict dot out validation)
 *   numpy/_core/src/multiarray/arraytypes.c.src
 *     *_dot / BOOL_dot
 *   numpy/_core/src/common/cblasfuncs.c
 *     cblas_matrixproduct (real float/double subset)
 *   numpy/_core/src/common/npy_cblas.h
 *     blas_stride / chunked CBLAS dot rules
 *   numpy/_core/numeric.py
 *     outer = multiply(a.ravel()[:,None], b.ravel()[None,:], out)
 *
 * CPython conversion/priority/subclass handling is replaced by LuaRay's
 * native ndarray/dtype model.  The numerical contraction axes and strict
 * non-scalar dot(out=) rules intentionally follow NumPy.
 */

static void
seterr(ln_error *err, const char *msg)
{
    if (err) snprintf(err->message, sizeof(err->message), "%s", msg);
}

static void
advance_coord(int nd, const ln_intp *shape, ln_intp *coord)
{
    for (int d = nd - 1; d >= 0; --d) {
        coord[d]++;
        if (coord[d] < shape[d]) return;
        coord[d] = 0;
    }
}

static const char *
flat_c_ptr_const(const ln_array *a, ln_intp flat)
{
    const char *p = a->data;
    for (int d = a->nd - 1; d >= 0; --d) {
        ln_intp dim = a->dimensions[d];
        ln_intp q = dim ? flat % dim : 0;
        flat = dim ? flat / dim : 0;
        p += q * a->strides[d];
    }
    return p;
}

typedef struct {
    int axis;
    ln_intp stride;
} dot_stride_axis;

static int
dot_stride_cmp_desc(const void *aa, const void *bb)
{
    const dot_stride_axis *a = (const dot_stride_axis *)aa;
    const dot_stride_axis *b = (const dot_stride_axis *)bb;
    ln_intp as = a->stride < 0 ? -a->stride : a->stride;
    ln_intp bs = b->stride < 0 ? -b->stride : b->stride;
    if (as == bs) {
        return a->axis < b->axis ? -1 : (a->axis > b->axis ? 1 : 0);
    }
    return as > bs ? -1 : 1;
}

/*
 * PyArray_FromAny(..., dtype, NPY_ARRAY_ALIGNED) preserves the input's
 * KEEPORDER layout when a dtype conversion requires a copy.  Dot performs
 * that conversion before its scalar-multiply fallback, so preserving the
 * converted operand's axis order is observable in result strides.
 */
static ln_array *
cast_keeporder(const ln_array *src, const ln_dtype *dt, ln_error *err)
{
    int fortran = src->nd > 1 &&
                  !(src->flags & LN_ARRAY_C_CONTIGUOUS) &&
                  (src->flags & LN_ARRAY_F_CONTIGUOUS);
    ln_array *dst = ln_array_new(src->nd, src->nd ? src->dimensions : NULL,
                                 dt, fortran, 0, err);
    if (!dst) return NULL;

    if (src->nd > 1 &&
        !(src->flags & LN_ARRAY_C_CONTIGUOUS) &&
        !(src->flags & LN_ARRAY_F_CONTIGUOUS) &&
        ln_array_size(src) > 0) {
        dot_stride_axis perm[LN_MAXDIMS];
        for (int d = 0; d < src->nd; ++d) {
            perm[d].axis = d;
            perm[d].stride = src->strides[d];
        }
        qsort(perm, (size_t)src->nd, sizeof(perm[0]), dot_stride_cmp_desc);
        ln_intp stride = (ln_intp)dt->elsize;
        for (int i = src->nd - 1; i >= 0; --i) {
            int d = perm[i].axis;
            dst->strides[d] = stride;
            stride *= src->dimensions[d];
        }
        ln_update_contiguous_flags(dst);
    }

    ln_intp total = ln_array_size(src);
    ln_intp coord[LN_MAXDIMS] = {0};
    for (ln_intp i = 0; i < total; ++i) {
        const char *sp = src->data;
        char *dp = dst->data;
        for (int d = 0; d < src->nd; ++d) {
            sp += coord[d] * src->strides[d];
            dp += coord[d] * dst->strides[d];
        }
        if (ln_cast_strided_numeric(sp, 0, src->descr,
                                    dp, 0, dst->descr, 1, err) < 0) {
            ln_array_free(dst);
            return NULL;
        }
        for (int d = src->nd - 1; d >= 0; --d) {
            if (++coord[d] < src->dimensions[d]) break;
            coord[d] = 0;
        }
    }
    return dst;
}

static const ln_array *
ensure_dtype(const ln_array *src, const ln_dtype *dt, ln_array **owned,
             ln_error *err)
{
    *owned = NULL;
    if (src->descr->type_num == dt->type_num) return src;
    ln_array *r = cast_keeporder(src, dt, err);
    if (!r) return NULL;
    *owned = r;
    return r;
}

static int
blas_stride(ln_intp stride, size_t itemsize, int *out)
{
    if (itemsize == 0 || stride <= 0 || stride % (ln_intp)itemsize != 0) return 0;
    ln_intp s = stride / (ln_intp)itemsize;
    if (s <= 0 || s > INT_MAX) return 0;
    *out = (int)s;
    return 1;
}

static int
scalar_dot(const char *ap, ln_intp as, const char *bp, ln_intp bs,
           char *op, ln_intp n, const ln_dtype *dt, ln_error *err)
{
    if (dt->type_num == LN_FLOAT) {
        int ia = 0, ib = 0;
        if (blas_stride(as, sizeof(float), &ia) &&
            blas_stride(bs, sizeof(float), &ib)) {
            double sum = 0.0;
            const ln_intp chunk_max = (ln_intp)INT_MAX / 2 + 1;
            while (n > 0) {
                int chunk = (int)(n < chunk_max ? n : chunk_max);
                sum += (double)cblas_sdot(chunk, (const float *)ap, ia,
                                         (const float *)bp, ib);
                ap += (ln_intp)chunk * as;
                bp += (ln_intp)chunk * bs;
                n -= chunk;
            }
            *(float *)op = (float)sum;
            return 0;
        }
    }
    else if (dt->type_num == LN_HALF) {
        float sum = 0.0f;
        for (ln_intp i = 0; i < n; ++i, ap += as, bp += bs) {
            ln_half ha, hb;
            memcpy(&ha, ap, sizeof(ha));
            memcpy(&hb, bp, sizeof(hb));
            sum += ln_half_to_float(ha) * ln_half_to_float(hb);
        }
        ln_half h = ln_float_to_half(sum);
        memcpy(op, &h, sizeof(h));
        return 0;
    }
    else if (dt->type_num == LN_DOUBLE) {
        int ia = 0, ib = 0;
        if (blas_stride(as, sizeof(double), &ia) &&
            blas_stride(bs, sizeof(double), &ib)) {
            double sum = 0.0;
            const ln_intp chunk_max = (ln_intp)INT_MAX / 2 + 1;
            while (n > 0) {
                int chunk = (int)(n < chunk_max ? n : chunk_max);
                sum += cblas_ddot(chunk, (const double *)ap, ia,
                                  (const double *)bp, ib);
                ap += (ln_intp)chunk * as;
                bp += (ln_intp)chunk * bs;
                n -= chunk;
            }
            *(double *)op = sum;
            return 0;
        }
    }
    else if (dt->type_num == LN_CFLOAT) {
        int ia = 0, ib = 0;
        if (n <= INT_MAX && blas_stride(as, sizeof(ln_cfloat), &ia) &&
            blas_stride(bs, sizeof(ln_cfloat), &ib)) {
            cblas_cdotu_sub((int)n, (const void *)ap, ia,
                            (const void *)bp, ib, (void *)op);
            return 0;
        }
    }
    else if (dt->type_num == LN_CDOUBLE) {
        int ia = 0, ib = 0;
        if (n <= INT_MAX && blas_stride(as, sizeof(ln_cdouble), &ia) &&
            blas_stride(bs, sizeof(ln_cdouble), &ib)) {
            cblas_zdotu_sub((int)n, (const void *)ap, ia,
                            (const void *)bp, ib, (void *)op);
            return 0;
        }
    }

    ln_strided_binary_loop mul = ln_get_multiply_loop(dt->type_num);
    ln_strided_binary_loop add = ln_get_add_loop(dt->type_num);
    if (!mul || !add || dt->elsize > 32) {
        seterr(err, "dot not available for this dtype");
        return -1;
    }
    memset(op, 0, dt->elsize);
    unsigned char prod[32];
    ln_intp one[1] = {1};
    ln_intp steps[3] = {0, 0, 0};
    for (ln_intp i = 0; i < n; ++i) {
        char *margs[3] = {(char *)ap, (char *)bp, (char *)prod};
        mul(margs, one, steps, NULL);
        char *aargs[3] = {op, (char *)prod, op};
        add(aargs, one, steps, NULL);
        if (dt->type_num == LN_BOOL && *(unsigned char *)op) break;
        ap += as;
        bp += bs;
    }
    return 0;
}

static int
is_matrix_contig(const ln_array *a, int *fortran)
{
    if (a->nd != 2) return 0;
    if (a->flags & LN_ARRAY_C_CONTIGUOUS) { *fortran = 0; return 1; }
    if (a->flags & LN_ARRAY_F_CONTIGUOUS) { *fortran = 1; return 1; }
    return 0;
}

/* Real-valued <=2-D subset of cblas_matrixproduct.  Returns 1 if handled. */
static int
try_small_blas(const ln_array *a, const ln_array *b, ln_array *out)
{
    if ((out->descr->type_num != LN_FLOAT && out->descr->type_num != LN_DOUBLE &&
         out->descr->type_num != LN_CFLOAT && out->descr->type_num != LN_CDOUBLE) ||
        a->descr->type_num != out->descr->type_num ||
        b->descr->type_num != out->descr->type_num ||
        a->nd == 0 || b->nd == 0 || a->nd > 2 || b->nd > 2) return 0;

    size_t es = out->descr->elsize;
    ln_intp k = a->dimensions[a->nd - 1];
    if (k == 0) return 0;
    if (a->nd == 1 && b->nd == 1) return 0; /* scalar_dot has exact dotfunc path */
    if (k > INT_MAX) return 0;

    if (a->nd == 2 && b->nd == 1) {
        ln_intp m = a->dimensions[0], n = a->dimensions[1];
        if (m <= 1 || n <= 1 || m > INT_MAX || n > INT_MAX) return 0;
        int af = 0, ix = 0;
        if (!is_matrix_contig(a, &af) || !blas_stride(b->strides[0], es, &ix)) return 0;
        int lda = (int)(af ? a->dimensions[0] : a->dimensions[1]);
        if (lda < 1) lda = 1;
        if (out->descr->type_num == LN_FLOAT)
            cblas_sgemv(af ? CblasColMajor : CblasRowMajor, CblasNoTrans,
                        (int)m, (int)n, 1.0f, (const float *)a->data, lda,
                        (const float *)b->data, ix, 0.0f, (float *)out->data, 1);
        else if (out->descr->type_num == LN_DOUBLE)
            cblas_dgemv(af ? CblasColMajor : CblasRowMajor, CblasNoTrans,
                        (int)m, (int)n, 1.0, (const double *)a->data, lda,
                        (const double *)b->data, ix, 0.0, (double *)out->data, 1);
        else if (out->descr->type_num == LN_CFLOAT) {
            const ln_cfloat one={1,0},zero={0,0};
            cblas_cgemv(af ? CblasColMajor : CblasRowMajor, CblasNoTrans,
                        (int)m,(int)n,&one,(const void*)a->data,lda,
                        (const void*)b->data,ix,&zero,(void*)out->data,1);
        } else {
            const ln_cdouble one={1,0},zero={0,0};
            cblas_zgemv(af ? CblasColMajor : CblasRowMajor, CblasNoTrans,
                        (int)m,(int)n,&one,(const void*)a->data,lda,
                        (const void*)b->data,ix,&zero,(void*)out->data,1);
        }
        return 1;
    }

    if (a->nd == 1 && b->nd == 2) {
        ln_intp n = b->dimensions[0], p = b->dimensions[1];
        if (n <= 1 || p <= 1 || n > INT_MAX || p > INT_MAX) return 0;
        int bf = 0, ix = 0;
        if (!is_matrix_contig(b, &bf) || !blas_stride(a->strides[0], es, &ix)) return 0;
        int lda = (int)(bf ? b->dimensions[0] : b->dimensions[1]);
        if (lda < 1) lda = 1;
        if (out->descr->type_num == LN_FLOAT)
            cblas_sgemv(bf ? CblasColMajor : CblasRowMajor, CblasTrans,
                        (int)n, (int)p, 1.0f, (const float *)b->data, lda,
                        (const float *)a->data, ix, 0.0f, (float *)out->data, 1);
        else if (out->descr->type_num == LN_DOUBLE)
            cblas_dgemv(bf ? CblasColMajor : CblasRowMajor, CblasTrans,
                        (int)n, (int)p, 1.0, (const double *)b->data, lda,
                        (const double *)a->data, ix, 0.0, (double *)out->data, 1);
        else if (out->descr->type_num == LN_CFLOAT) {
            const ln_cfloat one={1,0},zero={0,0};
            cblas_cgemv(bf ? CblasColMajor : CblasRowMajor, CblasTrans,
                        (int)n,(int)p,&one,(const void*)b->data,lda,
                        (const void*)a->data,ix,&zero,(void*)out->data,1);
        } else {
            const ln_cdouble one={1,0},zero={0,0};
            cblas_zgemv(bf ? CblasColMajor : CblasRowMajor, CblasTrans,
                        (int)n,(int)p,&one,(const void*)b->data,lda,
                        (const void*)a->data,ix,&zero,(void*)out->data,1);
        }
        return 1;
    }

    if (a->nd == 2 && b->nd == 2) {
        ln_intp m = a->dimensions[0], n = a->dimensions[1], p = b->dimensions[1];
        if (m <= 1 || n <= 1 || p <= 1 || m > INT_MAX || n > INT_MAX || p > INT_MAX) return 0;
        int af = 0, bf = 0;
        if (!is_matrix_contig(a, &af) || !is_matrix_contig(b, &bf)) return 0;
        int lda = (int)(af ? a->dimensions[0] : a->dimensions[1]);
        int ldb = (int)(bf ? b->dimensions[0] : b->dimensions[1]);
        int ldc = (int)(p > 1 ? p : 1);
        if (out->descr->type_num == LN_FLOAT)
            cblas_sgemm(CblasRowMajor, af ? CblasTrans : CblasNoTrans,
                        bf ? CblasTrans : CblasNoTrans,
                        (int)m, (int)p, (int)n, 1.0f,
                        (const float *)a->data, lda, (const float *)b->data, ldb,
                        0.0f, (float *)out->data, ldc);
        else if (out->descr->type_num == LN_DOUBLE)
            cblas_dgemm(CblasRowMajor, af ? CblasTrans : CblasNoTrans,
                        bf ? CblasTrans : CblasNoTrans,
                        (int)m, (int)p, (int)n, 1.0,
                        (const double *)a->data, lda, (const double *)b->data, ldb,
                        0.0, (double *)out->data, ldc);
        else if (out->descr->type_num == LN_CFLOAT) {
            const ln_cfloat one={1,0},zero={0,0};
            cblas_cgemm(CblasRowMajor,af?CblasTrans:CblasNoTrans,bf?CblasTrans:CblasNoTrans,
                        (int)m,(int)p,(int)n,&one,(const void*)a->data,lda,
                        (const void*)b->data,ldb,&zero,(void*)out->data,ldc);
        } else {
            const ln_cdouble one={1,0},zero={0,0};
            cblas_zgemm(CblasRowMajor,af?CblasTrans:CblasNoTrans,bf?CblasTrans:CblasNoTrans,
                        (int)m,(int)p,(int)n,&one,(const void*)a->data,lda,
                        (const void*)b->data,ldb,&zero,(void*)out->data,ldc);
        }
        return 1;
    }
    return 0;
}


static int
is_cblas_dtype(const ln_dtype *dt)
{
    return dt->type_num == LN_FLOAT || dt->type_num == LN_DOUBLE ||
           dt->type_num == LN_CFLOAT || dt->type_num == LN_CDOUBLE;
}

static ln_array *
small_blas_scalar_multiply(const ln_array *a, const ln_array *b,
                           const ln_dtype *dt, ln_error *err)
{
    const ln_array *other = a->nd == 0 ? b : a;
    const ln_array *scalar = a->nd == 0 ? a : b;
    ln_array *out = ln_array_new(other->nd,
                                 other->nd ? other->dimensions : NULL,
                                 dt, 0, 0, err);
    if (!out) return NULL;
    ln_strided_binary_loop mul = ln_get_multiply_loop(dt->type_num);
    if (!mul) { ln_array_free(out); seterr(err,"dot not available for this dtype"); return NULL; }
    ln_intp total = ln_array_size(other), one[1]={1}, steps[3]={0,0,0};
    for (ln_intp i=0;i<total;++i) {
        const char *optr=flat_c_ptr_const(other,i);
        char *dst=out->data+i*(ln_intp)dt->elsize;
        char *args[3];
        if (a->nd==0) { args[0]=scalar->data; args[1]=(char*)optr; }
        else { args[0]=(char*)optr; args[1]=scalar->data; }
        args[2]=dst; mul(args,one,steps,NULL);
    }
    return out;
}

static int
build_dot_shape(const ln_array *a, const ln_array *b, int *out_nd,
                ln_intp *shape, int *match_dim, ln_error *err)
{
    if (a->nd == 0 || b->nd == 0) {
        *out_nd = -1; /* scalar multiply path */
        *match_dim = -1;
        return 0;
    }
    ln_intp k = a->dimensions[a->nd - 1];
    int md = b->nd > 1 ? b->nd - 2 : 0;
    if (b->dimensions[md] != k) {
        seterr(err, "shapes are not aligned for dot product");
        return -1;
    }
    int nd = a->nd + b->nd - 2;
    if (nd > LN_MAXDIMS) {
        seterr(err, "dot: too many dimensions in result");
        return -1;
    }
    int j = 0;
    for (int i = 0; i < a->nd - 1; ++i) shape[j++] = a->dimensions[i];
    for (int i = 0; i < b->nd - 2; ++i) shape[j++] = b->dimensions[i];
    if (b->nd > 1) shape[j++] = b->dimensions[b->nd - 1];
    *out_nd = nd;
    *match_dim = md;
    return 0;
}

static int
execute_dot_same_dtype(const ln_array *a, const ln_array *b, int match_dim,
                       ln_array *out, ln_error *err)
{
    if (try_small_blas(a, b, out)) return 0;
    ln_intp k = a->dimensions[a->nd - 1];
    ln_intp total = ln_array_size(out);
    if (total == 0) return 0;
    ln_intp coord[LN_MAXDIMS] = {0};
    for (ln_intp oi = 0; oi < total; ++oi) {
        const char *ap = a->data;
        const char *bp = b->data;
        int q = 0;
        for (int d = 0; d < a->nd - 1; ++d) ap += coord[q++] * a->strides[d];
        for (int d = 0; d < b->nd - 2; ++d) bp += coord[q++] * b->strides[d];
        if (b->nd > 1) bp += coord[q++] * b->strides[b->nd - 1];
        char *op = out->data + oi * (ln_intp)out->descr->elsize;
        if (scalar_dot(ap, a->strides[a->nd - 1],
                       bp, b->strides[match_dim], op, k, out->descr, err) < 0) return -1;
        advance_coord(out->nd, out->dimensions, coord);
    }
    return 0;
}

static int
shape_equal(const ln_array *out, int nd, const ln_intp *shape);

ln_array *
ln_dot(const ln_array *a0, const ln_array *b0, ln_error *err)
{
    if (!a0 || !b0) { seterr(err, "invalid dot operand"); return NULL; }
    const ln_dtype *dt = ln_promote_dtype(a0->descr, b0->descr);
    if (!dt) { seterr(err, "dot dtype resolution failed"); return NULL; }

    if (a0->nd == 0 || b0->nd == 0) {
        /* MatrixProduct2 converts to the common dtype first.  For real
         * float/double operands with both ndims <= 2 it enters
         * cblas_matrixproduct even when one operand is scalar; that path
         * allocates a fresh C-order result.  Other dtypes/dimensions fall
         * through to multiply and therefore use ufunc KEEPORDER. */
        ln_array *oa=NULL,*ob=NULL;
        const ln_array *a=ensure_dtype(a0,dt,&oa,err);
        if(!a)return NULL;
        const ln_array *b=ensure_dtype(b0,dt,&ob,err);
        if(!b){ln_array_free(oa);return NULL;}
        ln_array *r;
        if(is_cblas_dtype(dt) && a->nd<=2 && b->nd<=2)
            r=small_blas_scalar_multiply(a,b,dt,err);
        else
            r=ln_binary_array_op_where(a,b,NULL,LN_OP_MULTIPLY,err);
        ln_array_free(oa);ln_array_free(ob);
        return r;
    }

    int nd = 0, md = 0;
    ln_intp shape[LN_MAXDIMS];
    if (build_dot_shape(a0, b0, &nd, shape, &md, err) < 0) return NULL;

    ln_array *oa = NULL, *ob = NULL;
    const ln_array *a = ensure_dtype(a0, dt, &oa, err);
    if (!a) return NULL;
    const ln_array *b = ensure_dtype(b0, dt, &ob, err);
    if (!b) { ln_array_free(oa); return NULL; }

    ln_array *out = ln_array_new(nd, nd ? shape : NULL, dt, 0, 0, err);
    if (!out) { ln_array_free(oa); ln_array_free(ob); return NULL; }
    if (execute_dot_same_dtype(a, b, md, out, err) < 0) {
        ln_array_free(out); out = NULL;
    }
    ln_array_free(oa);
    ln_array_free(ob);
    return out;
}

static int
shape_equal(const ln_array *out, int nd, const ln_intp *shape)
{
    if (!out || out->nd != nd) return 0;
    for (int d = 0; d < nd; ++d) if (out->dimensions[d] != shape[d]) return 0;
    return 1;
}

int
ln_dot_into(const ln_array *a, const ln_array *b, ln_array *out, ln_error *err)
{
    if (!out) { seterr(err, "invalid dot output"); return -1; }
    const ln_dtype *dt = ln_promote_dtype(a->descr, b->descr);
    if (!dt) { seterr(err, "dot dtype resolution failed"); return -1; }
    if (a->nd == 0 || b->nd == 0) {
        ln_array *oa=NULL,*ob=NULL;
        const ln_array *aa=ensure_dtype(a,dt,&oa,err);
        if(!aa)return -1;
        const ln_array *bb=ensure_dtype(b,dt,&ob,err);
        if(!bb){ln_array_free(oa);return -1;}
        int rc=0;
        if(is_cblas_dtype(dt) && aa->nd<=2 && bb->nd<=2) {
            const ln_array *other=aa->nd==0?bb:aa;
            if(!shape_equal(out,other->nd,other->dimensions) ||
               out->descr->type_num!=dt->type_num ||
               !(out->flags&LN_ARRAY_C_CONTIGUOUS) ||
               !(out->flags&LN_ARRAY_ALIGNED) || !(out->flags&LN_ARRAY_WRITEABLE)) {
                seterr(err,"output array is not acceptable (must have the right datatype, number of dimensions, and be a C-Array)");
                rc=-1;
            }
            else {
                ln_array *tmp=small_blas_scalar_multiply(aa,bb,dt,err);
                if(!tmp) rc=-1;
                else { size_t nbytes=(size_t)ln_array_size(tmp)*dt->elsize; if(nbytes)memcpy(out->data,tmp->data,nbytes); ln_array_free(tmp); }
            }
        }
        else rc=ln_binary_array_op_into(aa,bb,out,NULL,LN_OP_MULTIPLY,err);
        ln_array_free(oa);ln_array_free(ob);
        return rc;
    }
    int nd = 0, md = 0;
    ln_intp shape[LN_MAXDIMS];
    if (build_dot_shape(a, b, &nd, shape, &md, err) < 0) return -1;
    (void)md;
    if (!shape_equal(out, nd, shape) || out->descr->type_num != dt->type_num ||
        !(out->flags & LN_ARRAY_C_CONTIGUOUS) ||
        !(out->flags & LN_ARRAY_ALIGNED) || !(out->flags & LN_ARRAY_WRITEABLE)) {
        seterr(err, "output array is not acceptable (must have the right datatype, number of dimensions, and be a C-Array)");
        return -1;
    }
    ln_array *tmp = ln_dot(a, b, err);
    if (!tmp) return -1;
    size_t nbytes = (size_t)ln_array_size(tmp) * tmp->descr->elsize;
    if (nbytes) memcpy(out->data, tmp->data, nbytes);
    ln_array_free(tmp);
    return 0;
}

ln_array *
ln_inner(const ln_array *a, const ln_array *b, ln_error *err)
{
    if (!a || !b) { seterr(err, "invalid inner operand"); return NULL; }
    if (a->nd < 1 || b->nd < 2) return ln_dot(a, b, err);
    ln_intp dims[LN_MAXDIMS], strides[LN_MAXDIMS];
    for (int d = 0; d < b->nd; ++d) {
        dims[d] = b->dimensions[d];
        strides[d] = b->strides[d];
    }
    int x = b->nd - 2, y = b->nd - 1;
    ln_intp td = dims[x]; dims[x] = dims[y]; dims[y] = td;
    ln_intp ts = strides[x]; strides[x] = strides[y]; strides[y] = ts;
    ln_array *bt = ln_array_view(b, b->nd, dims, strides, b->data, err);
    if (!bt) return NULL;
    ln_array *r = ln_dot(a, bt, err);
    ln_array_free(bt);
    return r;
}

static ln_array *
flatten_c_copy(const ln_array *a, ln_error *err)
{
    ln_intp n = ln_array_size(a);
    ln_intp sh[1] = {n};
    ln_array *r = ln_array_new(1, sh, a->descr, 0, 0, err);
    if (!r) return NULL;
    for (ln_intp i = 0; i < n; ++i) {
        const char *sp = flat_c_ptr_const(a, i);
        memcpy(r->data + i * (ln_intp)a->descr->elsize, sp, a->descr->elsize);
    }
    return r;
}

static int
outer_views(const ln_array *a, const ln_array *b, ln_array **fa, ln_array **fb,
            ln_array **va, ln_array **vb, ln_error *err)
{
    *fa = flatten_c_copy(a, err); if (!*fa) return -1;
    *fb = flatten_c_copy(b, err); if (!*fb) { ln_array_free(*fa); *fa=NULL; return -1; }
    ln_intp ad[2] = {ln_array_size(a), 1};
    ln_intp as[2] = {(ln_intp)a->descr->elsize, 0};
    ln_intp bd[2] = {1, ln_array_size(b)};
    ln_intp bs[2] = {0, (ln_intp)b->descr->elsize};
    *va = ln_array_view(*fa, 2, ad, as, (*fa)->data, err);
    if (!*va) goto fail;
    *vb = ln_array_view(*fb, 2, bd, bs, (*fb)->data, err);
    if (!*vb) goto fail;
    return 0;
fail:
    ln_array_free(*va); *va=NULL;
    ln_array_free(*vb); *vb=NULL;
    ln_array_free(*fa); *fa=NULL;
    ln_array_free(*fb); *fb=NULL;
    return -1;
}

ln_array *
ln_outer(const ln_array *a, const ln_array *b, ln_error *err)
{
    ln_array *fa=NULL,*fb=NULL,*va=NULL,*vb=NULL;
    if (outer_views(a,b,&fa,&fb,&va,&vb,err)<0) return NULL;
    ln_array *r = ln_binary_array_op_where(va, vb, NULL, LN_OP_MULTIPLY, err);
    ln_array_free(va); ln_array_free(vb); ln_array_free(fa); ln_array_free(fb);
    return r;
}

int
ln_outer_into(const ln_array *a, const ln_array *b, ln_array *out, ln_error *err)
{
    ln_array *fa=NULL,*fb=NULL,*va=NULL,*vb=NULL;
    if (outer_views(a,b,&fa,&fb,&va,&vb,err)<0) return -1;
    int rc = ln_binary_array_op_into(va, vb, out, NULL, LN_OP_MULTIPLY, err);
    ln_array_free(va); ln_array_free(vb); ln_array_free(fa); ln_array_free(fb);
    return rc;
}
