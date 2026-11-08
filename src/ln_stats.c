/* LuaRay native statistical reductions. No Python dependency.
 * Numerical two-pass method based on NumPy's _core/_methods.py _var:
 * calculate mean on selected axes, accumulate squared centered deviations,
 * divide by max(count-ddof, 0), and take the square root for std. */
#include "ln_stats.h"
#include "ln_dtype_transfer.h"
#include "ln_complex.h"
#include <math.h>
#include <limits.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Build a contiguous mask. In contrast to replacing NaNs with neutral values,
 * this also carries correct selected sample counts into mean/var/std, while
 * retaining the original input's exact integer and complex representations. */
#include "ln_half.h"
static int stat_is_nan(const ln_dtype *dtype, const char *p) {
    switch (dtype->type_num) {
    case LN_HALF: { ln_half x; memcpy(&x,p,sizeof(x)); return isnan(ln_half_to_float(x)); }
    case LN_FLOAT: { float x; memcpy(&x,p,sizeof(x)); return isnan(x); }
    case LN_DOUBLE: { double x; memcpy(&x,p,sizeof(x)); return isnan(x); }
    case LN_LONGDOUBLE: { long double x; memcpy(&x,p,sizeof(x)); return isnan(x); }
    case LN_CFLOAT: { ln_cfloat x; memcpy(&x,p,sizeof(x)); return isnan(x.real)||isnan(x.imag); }
    case LN_CDOUBLE: { ln_cdouble x; memcpy(&x,p,sizeof(x)); return isnan(x.real)||isnan(x.imag); }
    case LN_CLONGDOUBLE: { ln_clongdouble x; memcpy(&x,p,sizeof(x)); return isnan(x.real)||isnan(x.imag); }
    default: return 0;
    }
}

ln_array *ln_stats_nan_replace(const ln_array *a,int product,ln_error *err) {
    if(!a || !a->descr || !(a->descr->kind=='b'||a->descr->kind=='i'||
        a->descr->kind=='u'||a->descr->kind=='f'||a->descr->kind=='c')) {
        if(err)snprintf(err->message,sizeof(err->message),"nan cumulative operations require numeric arrays");
        return NULL;
    }
    ln_array *result=ln_array_new(a->nd,a->dimensions,a->descr,0,0,err);
    if(!result)return NULL;
    ln_intp size=ln_array_size(a);
    if(size<0) {
        ln_array_free(result);
        if(err)snprintf(err->message,sizeof(err->message),"array too large");
        return NULL;
    }
    const double identity=product?1.0:0.0;
    ln_intp coord[LN_MAXDIMS]={0};
    for(ln_intp i=0;i<size;i++) {
        const char *src=a->data;
        for(int d=0;d<a->nd;d++)src+=coord[d]*a->strides[d];
        char *dst=result->data+(size_t)i*a->descr->elsize;
        if(stat_is_nan(a->descr,src)) {
            if(ln_cast_strided_numeric((const char*)&identity,0,
                ln_dtype_by_num(LN_DOUBLE),dst,0,a->descr,1,err)<0) {
                ln_array_free(result);return NULL;
            }
        } else memcpy(dst,src,a->descr->elsize);
        for(int d=a->nd-1;d>=0;d--) {
            if(++coord[d]<a->dimensions[d])break;
            coord[d]=0;
        }
    }
    return result;
}

ln_array *ln_stats_nan_where(const ln_array *a, const ln_array *where,
                             ln_error *err) {
    if (!a || !a->descr || !(a->descr->kind=='b' ||
          a->descr->kind=='i' || a->descr->kind=='u' ||
          a->descr->kind=='f' || a->descr->kind=='c')) {
        if(err)snprintf(err->message,sizeof(err->message),"nan reductions require numeric arrays");
        return NULL;
    }
    ln_intp ws[LN_MAXDIMS]={0};
    if(where) {
        if(!where->descr || where->descr->type_num!=LN_BOOL) {
            if(err)snprintf(err->message,sizeof(err->message),"where mask must have bool dtype");
            return NULL;
        }
        if(ln_broadcast_strides(a->nd,a->dimensions,where->nd,
             where->dimensions,where->strides,"where mask",ws,err)<0)return NULL;
    }
    ln_array *mask=ln_array_new(a->nd,a->dimensions,ln_dtype_by_num(LN_BOOL),0,0,err);
    if(!mask)return NULL;
    ln_intp total=ln_array_size(a);
    if(total<0){
        if(err)snprintf(err->message,sizeof(err->message),"array too large");
        ln_array_free(mask);return NULL;
    }
    ln_intp coord[LN_MAXDIMS]={0};
    for(ln_intp i=0;i<total;i++){
        const char *ip=a->data,*wp=where?where->data:NULL;
        for(int d=0;d<a->nd;d++) {
            ip+=coord[d]*a->strides[d];
            if(where)wp+=coord[d]*ws[d];
        }
        mask->data[i]= (char)((!where || *(const uint8_t *)wp) &&
                              !stat_is_nan(a->descr,ip));
        for(int d=a->nd-1;d>=0;d--) {
            if(++coord[d]<a->dimensions[d])break;
            coord[d]=0;
        }
    }
    return mask;
}

typedef struct ln_stat_accum {
    double re, im;
    double squares;
    uint64_t count;
} ln_stat_accum;

static void staterr(ln_error *err, const char *msg) {
    if (err) snprintf(err->message, sizeof(err->message), "%s", msg);
}
static int stat_output_shape(const ln_array *a, const uint8_t *flags,
                             int keepdims, int *nd, ln_intp *dims) {
    *nd = 0;
    for (int d=0; d<a->nd; ++d) {
        if (flags[d]) {
            if (keepdims) dims[(*nd)++] = 1;
        } else dims[(*nd)++] = a->dimensions[d];
    }
    return 0;
}
static const ln_dtype *stat_dtype(const ln_array *a, const ln_dtype *requested) {
    if (requested) return requested;
    if (a->descr->kind == 'f') return a->descr;
    if (a->descr->kind == 'c') {
        if (a->descr->type_num == LN_CFLOAT) return ln_dtype_by_num(LN_FLOAT);
        if (a->descr->type_num == LN_CLONGDOUBLE) return ln_dtype_by_num(LN_LONGDOUBLE);
        return ln_dtype_by_num(LN_DOUBLE);
    }
    return ln_dtype_by_num(LN_DOUBLE);
}
static int stat_read(const ln_array *a, const char *src, int complex_calc,
                     double *re, double *im, ln_error *err) {
    if (complex_calc) {
        ln_cdouble value = {0,0};
        if (ln_cast_strided_numeric(src,0,a->descr,(char *)&value,0,
              ln_dtype_by_num(LN_CDOUBLE),1,err)<0) return -1;
        *re=value.real; *im=value.imag;
    } else {
        if (ln_cast_strided_numeric(src,0,a->descr,(char *)re,0,
              ln_dtype_by_num(LN_DOUBLE),1,err)<0) return -1;
        *im=0;
    }
    return 0;
}
static int stat_store(char *dst, const ln_dtype *dst_dt, double value,
                      ln_error *err) {
    if (dst_dt->kind=='c') {
        ln_cdouble z = {value,!isfinite(value)?NAN:0};
        return ln_cast_strided_numeric((const char *)&z,0,
            ln_dtype_by_num(LN_CDOUBLE),dst,0,dst_dt,1,err);
    }
    return ln_cast_strided_numeric((const char *)&value,0,
        ln_dtype_by_num(LN_DOUBLE),dst,0,dst_dt,1,err);
}
static void stat_next(int nd, const ln_intp *dims, ln_intp *coord) {
    for (int d=nd-1; d>=0; --d) if (++coord[d] < dims[d]) return;
    else coord[d]=0;
}
static size_t stat_out_index(const ln_array *a, const uint8_t *flags,
         const ln_intp *coord, int keepdims, const ln_intp *outdims, int outnd) {
    size_t index=0; int oa=0;
    for (int d=0; d<a->nd; ++d) {
        if (flags[d]&&!keepdims) continue;
        index=index*(size_t)outdims[oa]+(size_t)(flags[d]?0:coord[d]);
        ++oa;
    }
    (void)outnd;
    return index;
}

ln_array *ln_stats_var_std(const ln_array *a, const uint8_t *axis_flags,
    int keepdims, const ln_dtype *requested, const ln_array *where,
    double ddof, int is_std, int nan_mode, ln_array *out, ln_error *err) {
    if (!a || !a->descr) {staterr(err,"invalid input array");return NULL;}
    if (a->descr->kind!='b' && a->descr->kind!='i' &&
        a->descr->kind!='u' && a->descr->kind!='f' &&
        a->descr->kind!='c') {
        staterr(err,"var/std require numeric arrays");return NULL;
    }
    if (!isfinite(ddof)) {staterr(err,"ddof must be finite");return NULL;}
    const ln_dtype *dt=stat_dtype(a,requested);
    /* NumPy supports explicit integer accumulator DTypes, but their
     * intermediate truncation/wrap behavior has not yet been ported.
     * Reject instead of silently returning a different integer result. */
    if (!dt || (dt->kind!='f' && dt->kind!='c')) {
        staterr(err,"var/std require a floating or complex calculation dtype");return NULL;
    }
    uint8_t flags[LN_MAXDIMS]={0};
    for (int d=0;d<a->nd;d++) flags[d]=axis_flags?axis_flags[d]:1;
    int ond=0; ln_intp odims[LN_MAXDIMS]={0};
    stat_output_shape(a,flags,keepdims,&ond,odims);
    ln_intp ntmp=1;
    for (int d=0;d<ond;d++) {
        if (ln_mul_sizes_with_overflow(&ntmp,ntmp,odims[d])) {
            staterr(err,"statistics result too large");return NULL;
        }
    }
    if (ntmp<0 || (uintmax_t)ntmp > SIZE_MAX/sizeof(ln_stat_accum)) {
        staterr(err,"statistics result too large");return NULL;
    }
    if (out) {
        if (out->nd!=ond || !(out->flags&LN_ARRAY_WRITEABLE)) {
            staterr(err,"output parameter has wrong shape or is not writeable");return NULL;
        }
        for(int d=0;d<ond;d++) if(out->dimensions[d]!=odims[d]) {
            staterr(err,"output parameter has wrong shape");return NULL;
        }
    }
    ln_intp wstrides[LN_MAXDIMS]={0};
    if (where) {
        if (where->descr->type_num!=LN_BOOL) {
            staterr(err,"where mask must have bool dtype");return NULL;
        }
        if (ln_broadcast_strides(a->nd,a->dimensions,where->nd,
                where->dimensions,where->strides,"where mask",wstrides,err)<0)
            return NULL;
    }
    ln_array *res=ln_array_new(ond,odims,dt,0,0,err);
    if(!res) return NULL;
    size_t cap=(size_t)(ntmp?ntmp:1);
    ln_stat_accum *acc=(ln_stat_accum *)calloc(cap,sizeof(*acc));
    if(!acc) {staterr(err,"out of memory");ln_array_free(res);return NULL;}
    ln_intp total=ln_array_size(a);
    if(total<0){staterr(err,"input array too large");goto fail;}
    int calc_complex=(a->descr->kind=='c' && dt->kind=='c') ||
                     (a->descr->kind=='c' && !requested);
    ln_intp coord[LN_MAXDIMS]={0};
    /* Read/cast source into the effective calculation family. */
    for(ln_intp i=0;i<total;i++) {
        const char *ptr=a->data;const char *wp=where?where->data:NULL;
        for(int d=0;d<a->nd;d++) {
            ptr+=coord[d]*a->strides[d];
            if(where) wp+=coord[d]*wstrides[d];
        }
        if(!where || *(const uint8_t *)wp) {
            size_t j=stat_out_index(a,flags,coord,keepdims,odims,ond);
            double re,im;
            if(stat_read(a,ptr,calc_complex,&re,&im,err)<0)goto fail;
            acc[j].re+=re;acc[j].im+=im;acc[j].count++;
        }
        stat_next(a->nd,a->dimensions,coord);
    }
    for(ln_intp i=0;i<total;i++) {
        const char *ptr=a->data;const char *wp=where?where->data:NULL;
        for(int d=0;d<a->nd;d++) {
            ptr+=coord[d]*a->strides[d];
            if(where) wp+=coord[d]*wstrides[d];
        }
        if(!where || *(const uint8_t *)wp) {
            size_t j=stat_out_index(a,flags,coord,keepdims,odims,ond);
            double re,im;
            /* Even with a real calculation dtype NumPy subtracts the real
             * mean from the original complex input, then squares its
             * magnitude.  It does not discard the original imaginary part. */
            if(stat_read(a,ptr,a->descr->kind=='c',&re,&im,err)<0)goto fail;
            if (acc[j].count) {
                re-=acc[j].re/(double)acc[j].count;
                im-=acc[j].im/(double)acc[j].count;
                acc[j].squares+=re*re+im*im;
            }
        }
        stat_next(a->nd,a->dimensions,coord);
    }
    for(ln_intp i=0;i<ntmp;i++) {
        double denom=fmax(0.0,(double)acc[i].count-ddof);
        double v=(nan_mode && (a->descr->kind=='f' || a->descr->kind=='c') && denom==0.0) ? NAN : acc[i].squares/denom;
        if(is_std) v=sqrt(v);
        ln_intp ix=i;char *rp=res->data;
        for(int d=ond-1;d>=0;d--){
            ln_intp c=odims[d]?ix%odims[d]:0;
            if(odims[d])ix/=odims[d];
            rp+=c*res->strides[d];
        }
        if(stat_store(rp,dt,v,err)<0)goto fail;
    }
    if(out) {
        ln_intp oc[LN_MAXDIMS]={0};
        for(ln_intp i=0;i<ntmp;i++) {
            char *src=res->data,*dst=out->data;
            for(int d=0;d<ond;d++){
                src+=oc[d]*res->strides[d];dst+=oc[d]*out->strides[d];
            }
            if(ln_cast_strided_numeric(src,0,dt,dst,0,out->descr,1,err)<0)
                goto fail;
            stat_next(ond,odims,oc);
        }
    }
    free(acc);
    return res;
fail:
    free(acc);ln_array_free(res);return NULL;
}

/* Elementwise extrema order: numeric exact integer comparison, IEEE NaN
 * propagation, lexicographic complex ordering. Retains source payload bits. */
#include "ln_half.h"
static int extrema_new_wins(const char *old, const char *cur,
                            const ln_dtype *dt, int maximum, int tie_last) {
#define SCALAR(T) do { T x,y; memcpy(&x,old,sizeof(x)); memcpy(&y,cur,sizeof(y)); return maximum ? y>x : y<x; } while(0)
#define FLOATING(T) do { T x,y; memcpy(&x,old,sizeof(x));memcpy(&y,cur,sizeof(y));if(isnan(x))return 0; if(isnan(y))return 1;return maximum?(y>x||(tie_last&&y==x)):(y<x||(tie_last&&y==x)); } while(0)
#define COMPLEX(T,F) do { T x,y;memcpy(&x,old,sizeof(x));memcpy(&y,cur,sizeof(y));if(isnan(x.real)||isnan(x.imag))return 0;if(isnan(y.real)||isnan(y.imag))return 1;return maximum? (y.real>x.real||(y.real==x.real && (y.imag>x.imag||(tie_last&&y.imag==x.imag)))):(y.real<x.real||(y.real==x.real&&(y.imag<x.imag||(tie_last&&y.imag==x.imag)))); }while(0)
    switch(dt->type_num) {
        case LN_BOOL: SCALAR(uint8_t);
        case LN_BYTE: SCALAR(int8_t);
        case LN_UBYTE: SCALAR(uint8_t);
        case LN_SHORT: SCALAR(int16_t);
        case LN_USHORT: SCALAR(uint16_t);
        case LN_INT: SCALAR(int32_t);
        case LN_UINT: SCALAR(uint32_t);
        case LN_LONG: SCALAR(long);
        case LN_ULONG: SCALAR(unsigned long);
        case LN_LONGLONG: SCALAR(long long);
        case LN_ULONGLONG: SCALAR(unsigned long long);
        case LN_HALF: {
            ln_half x,y;memcpy(&x,old,sizeof(x));memcpy(&y,cur,sizeof(y));
            if(ln_half_isnan(x))return 0;
            if(ln_half_isnan(y))return 1;
            return maximum?(ln_half_ge(y,x)&&(tie_last||!ln_half_ge(x,y))):(ln_half_le(y,x)&&(tie_last||!ln_half_le(x,y)));
        }
        case LN_FLOAT: FLOATING(float);
        case LN_DOUBLE: FLOATING(double);
        case LN_LONGDOUBLE: FLOATING(long double);
        case LN_CFLOAT: COMPLEX(ln_cfloat,float);
        case LN_CDOUBLE: COMPLEX(ln_cdouble,double);
        case LN_CLONGDOUBLE: COMPLEX(ln_clongdouble,long double);
        default: return 0;
    }
#undef SCALAR
#undef FLOATING
#undef COMPLEX
}

static ln_array *stats_extrema_impl(const ln_array *a, const uint8_t *axis_flags,
    int keepdims, const ln_array *where, int omit_nan, int has_initial,
    double initial_v, int64_t initial_i, int initial_is_integer,
    int maximum, ln_array *out, ln_error *err) {
    if (!a || !a->descr) {staterr(err,"invalid input array");return NULL;}
    const ln_dtype *dt=a->descr;
    if(where && !has_initial){
        staterr(err,"reduction operation minimum/maximum does not have an identity, so where requires initial");
        return NULL;
    }
    if(has_initial && initial_is_integer){
        int64_t lo=INT64_MIN,hi=INT64_MAX;
        switch(dt->type_num){
            case LN_BYTE: lo=INT8_MIN;hi=INT8_MAX;break;
            case LN_SHORT:lo=INT16_MIN;hi=INT16_MAX;break;
            case LN_INT:lo=INT32_MIN;hi=INT32_MAX;break;
            case LN_UBYTE:lo=0;hi=UINT8_MAX;break;
            case LN_USHORT:lo=0;hi=UINT16_MAX;break;
            case LN_UINT:lo=0;hi=UINT32_MAX;break;
            case LN_ULONG:case LN_ULONGLONG:if(initial_i<0){
                staterr(err,"initial value outside the unsigned dtype range");return NULL;
            }break;
            default:break;
        }
        if(dt->type_num!=LN_BOOL && (initial_i<lo || initial_i>hi)){
            staterr(err,"initial value outside the dtype range");return NULL;
        }
    }
    if(dt->kind!='b' && dt->kind!='i' && dt->kind!='u' &&
       dt->kind!='f' && dt->kind!='c') {
        staterr(err,"min/max currently require numeric arrays");return NULL;
    }
    uint8_t flags[LN_MAXDIMS]={0};
    for(int d=0;d<a->nd;d++)flags[d]=axis_flags?axis_flags[d]:1;
    int ond=0;ln_intp odims[LN_MAXDIMS]={0};
    stat_output_shape(a,flags,keepdims,&ond,odims);
    ln_intp nout=1;
    for(int d=0;d<ond;d++) if(ln_mul_sizes_with_overflow(&nout,nout,odims[d])) {
        staterr(err,"extrema result too large");return NULL;
    }
    if(nout<0 || (uintmax_t)nout > SIZE_MAX) {
        staterr(err,"extrema result too large");return NULL;
    }
    if(out) {
        if(out->nd!=ond || !(out->flags&LN_ARRAY_WRITEABLE)){
            staterr(err,"output parameter has wrong shape or is not writeable");return NULL;
        }
        for(int d=0;d<ond;d++)if(out->dimensions[d]!=odims[d]) {
            staterr(err,"output parameter has wrong shape");return NULL;
        }
    }
    ln_intp wstrides[LN_MAXDIMS]={0};
    if(where) {
        if(where->descr->type_num!=LN_BOOL){
            staterr(err,"where mask must have bool dtype");return NULL;
        }
        if(ln_broadcast_strides(a->nd,a->dimensions,where->nd,
          where->dimensions,where->strides,"where mask",wstrides,err)<0)
            return NULL;
    }
    ln_array *res=ln_array_new(ond,odims,dt,0,0,err);
    if(!res)return NULL;
    size_t count=(size_t)(nout?nout:1);
    uint8_t *seen=calloc(count,1);
    uint8_t *visited=omit_nan?calloc(count,1):NULL;
    if(!seen || (omit_nan&&!visited)){staterr(err,"out of memory");free(seen);free(visited);ln_array_free(res);return NULL;}
    if(has_initial) {
        const ln_dtype *srcdt=ln_dtype_by_num(initial_is_integer?LN_LONGLONG:LN_DOUBLE);
        const char *src=(const char *)(initial_is_integer?(const void *)&initial_i:(const void *)&initial_v);
        char *rp=res->data;
        for(ln_intp i=0;i<nout;i++) {
            if(ln_cast_strided_numeric(src,0,srcdt,rp+i*(ln_intp)dt->elsize,0,dt,1,err)<0)goto fail_extrema;
            seen[i]=1;
        }
    }
    ln_intp total=ln_array_size(a);
    if(total<0){staterr(err,"input array too large");goto fail_extrema;}
    ln_intp coord[LN_MAXDIMS]={0};
    for(ln_intp i=0;i<total;i++){
        const char *sp=a->data,*wp=where?where->data:NULL;
        for(int d=0;d<a->nd;d++){
            sp+=coord[d]*a->strides[d];
            if(where)wp+=coord[d]*wstrides[d];
        }
        if(!where || *(const uint8_t *)wp){
            size_t j=stat_out_index(a,flags,coord,keepdims,odims,ond);
            char *rp=res->data+j*dt->elsize;
            if(omit_nan){
                if(!visited[j]){
                    /* Preserve the first NaN's payload if the whole slice is NaN. */
                    if(!seen[j] && !has_initial)memcpy(rp,sp,dt->elsize);
                    visited[j]=1;
                }
                if(stat_is_nan(dt,sp)){
                    stat_next(a->nd,a->dimensions,coord);
                    continue;
                }
            }
            if(!seen[j] || extrema_new_wins(rp,sp,dt,maximum,1))memcpy(rp,sp,dt->elsize);
            seen[j]=1;
        }
        stat_next(a->nd,a->dimensions,coord);
    }
    for(ln_intp i=0;i<nout;i++)if(!seen[i]){
        if(omit_nan && visited[i] && !has_initial)continue;
        staterr(err,"zero-size array to reduction operation minimum/maximum which has no identity");
        goto fail_extrema;
    }
    if(out){
        ln_intp coord_out[LN_MAXDIMS]={0};
        for(ln_intp i=0;i<nout;i++){
            const char *sp=res->data;char *dp=out->data;
            for(int d=0;d<ond;d++){
                sp+=coord_out[d]*res->strides[d];
                dp+=coord_out[d]*out->strides[d];
            }
            if(ln_cast_strided_numeric(sp,0,dt,dp,0,out->descr,1,err)<0)goto fail_extrema;
            stat_next(ond,odims,coord_out);
        }
    }
    free(visited);free(seen);return res;
fail_extrema:
    free(visited);free(seen);ln_array_free(res);return NULL;
}


ln_array *ln_stats_extrema(const ln_array *a, const uint8_t *flags,
    int keepdims, const ln_array *where, int has_initial,
    double initial_v, int64_t initial_i, int initial_is_integer,
    int maximum, ln_array *out, ln_error *err) {
    return stats_extrema_impl(a,flags,keepdims,where,0,has_initial,
        initial_v,initial_i,initial_is_integer,maximum,out,err);
}

ln_array *ln_stats_nan_extrema(const ln_array *a, const uint8_t *flags,
    int keepdims, const ln_array *where, int has_initial,
    double initial_v, int64_t initial_i, int initial_is_integer,
    int maximum, ln_array *out, ln_error *err) {
    return stats_extrema_impl(a,flags,keepdims,where,1,has_initial,
        initial_v,initial_i,initial_is_integer,maximum,out,err);
}

/* Arg extrema keeps the first occurrence in logical C traversal order.
 * The values are compared without round-tripping through double, preserving
 * uint64/int64 order, NaNs and the native complex lexicographic order. */
static ln_array *stats_argextrema_impl(const ln_array *a, int axis, int keepdims,
    int maximum, int omit_nan, ln_array *out, ln_error *err) {
    if(!a||!a->descr){staterr(err,"invalid input array");return NULL;}
    const ln_dtype *dt=a->descr;
    if(dt->kind!='b'&&dt->kind!='i'&&dt->kind!='u'&&
       dt->kind!='f'&&dt->kind!='c'){
        staterr(err,"argmin/argmax require numeric arrays");return NULL;
    }
    if(axis < -1 || axis >= a->nd){staterr(err,"axis out of bounds");return NULL;}
    const ln_dtype *index_dt=ln_dtype_by_num(LN_LONG);
    if(!index_dt || index_dt->elsize!=sizeof(ln_intp)){
        staterr(err,"native index dtype unavailable");return NULL;
    }
    int ond=0;ln_intp odims[LN_MAXDIMS]={0};
    if(axis<0){
        if(keepdims){ond=a->nd;for(int d=0;d<a->nd;d++)odims[d]=1;}
    }else{
        for(int d=0;d<a->nd;d++){
            if(d==axis){if(keepdims)odims[ond++]=1;}
            else odims[ond++]=a->dimensions[d];
        }
    }
    ln_intp nout=1;
    for(int d=0;d<ond;d++)if(ln_mul_sizes_with_overflow(&nout,nout,odims[d])){
        staterr(err,"arg reduction output too large");return NULL;
    }
    if(out){
        if(out->nd!=ond || !(out->flags&LN_ARRAY_WRITEABLE)){
            staterr(err,"output parameter has wrong shape or is not writeable");return NULL;
        }
        for(int d=0;d<ond;d++)if(out->dimensions[d]!=odims[d]){
            staterr(err,"output parameter has wrong shape");return NULL;
        }
        if(out->descr->kind!='i'&&out->descr->kind!='u'&&out->descr->kind!='b'){
            staterr(err,"arg reduction out requires an integer dtype");return NULL;
        }
    }
    ln_intp total=ln_array_size(a);
    if(total<0){staterr(err,"input array too large");return NULL;}
    if(nout>0 && total==0){
        staterr(err,"attempt to get argmin/argmax of an empty sequence");return NULL;
    }
    ln_array *res=ln_array_new(ond,odims,index_dt,0,0,err);
    if(!res)return NULL;
    size_t cnt=nout?(size_t)nout:1;
    if(cnt>SIZE_MAX/(dt->elsize?dt->elsize:1)){
        staterr(err,"arg reduction output too large");ln_array_free(res);return NULL;
    }
    uint8_t *seen=calloc(cnt,1);
    char *best=malloc(cnt*(dt->elsize?dt->elsize:1));
    if(!seen||!best){staterr(err,"out of memory");free(seen);free(best);ln_array_free(res);return NULL;}
    ln_intp coord[LN_MAXDIMS]={0};
    for(ln_intp i=0;i<total;i++){
        const char *sp=a->data;
        for(int d=0;d<a->nd;d++)sp+=coord[d]*a->strides[d];
        size_t j=0;
        if(axis>=0){
            for(int d=0;d<a->nd;d++)if(d!=axis)
                j=j*(size_t)a->dimensions[d]+(size_t)coord[d];
        }
        char *bp=best+j*dt->elsize;
        if(omit_nan && stat_is_nan(dt,sp)){
            stat_next(a->nd,a->dimensions,coord);
            continue;
        }
        if(!seen[j] || extrema_new_wins(bp,sp,dt,maximum,0)){
            memcpy(bp,sp,dt->elsize);
            ln_intp pos=(axis<0?i:coord[axis])+1;
            memcpy(res->data+j*index_dt->elsize,&pos,sizeof(pos));
            seen[j]=1;
        }
        stat_next(a->nd,a->dimensions,coord);
    }
    if(omit_nan){
        for(ln_intp j=0;j<nout;j++)if(!seen[j]){
            staterr(err,"All-NaN slice encountered");
            free(seen);free(best);ln_array_free(res);return NULL;
        }
    }
    free(seen);free(best);
    if(out){
        ln_intp oc[LN_MAXDIMS]={0};
        for(ln_intp i=0;i<nout;i++){
            char *src=res->data,*dst=out->data;
            for(int d=0;d<ond;d++){
                src+=oc[d]*res->strides[d];dst+=oc[d]*out->strides[d];
            }
            if(ln_cast_strided_numeric(src,0,index_dt,dst,0,out->descr,1,err)<0){
                ln_array_free(res);return NULL;
            }
            stat_next(ond,odims,oc);
        }
    }
    return res;
}

ln_array *ln_stats_argextrema(const ln_array *a, int axis, int keepdims,
    int maximum, ln_array *out, ln_error *err){
    return stats_argextrema_impl(a,axis,keepdims,maximum,0,out,err);
}
ln_array *ln_stats_nan_argextrema(const ln_array *a, int axis, int keepdims,
    int maximum, ln_array *out, ln_error *err){
    return stats_argextrema_impl(a,axis,keepdims,maximum,1,out,err);
}

ln_array *ln_stats_ptp(const ln_array *a, const uint8_t *axis_flags,
    int keepdims, ln_array *out, ln_error *err) {
    if(!a||!a->descr){staterr(err,"invalid input array");return NULL;}
    if(a->descr->kind=='b'){
        staterr(err,"numpy boolean subtract is not supported for ptp");return NULL;
    }
    ln_array *mn=ln_stats_extrema(a,axis_flags,keepdims,NULL,0,0,0,0,0,NULL,err);
    if(!mn)return NULL;
    ln_array *mx=ln_stats_extrema(a,axis_flags,keepdims,NULL,0,0,0,0,1,NULL,err);
    if(!mx){ln_array_free(mn);return NULL;}
    ln_array *res=ln_binary_subtract(mx,mn,err);
    ln_array_free(mx);ln_array_free(mn);
    if(!res)return NULL;
    if(out){
        if(out->nd!=res->nd || !(out->flags&LN_ARRAY_WRITEABLE)){
            staterr(err,"output parameter has wrong shape or is not writeable");ln_array_free(res);return NULL;
        }
        for(int d=0;d<res->nd;d++)if(out->dimensions[d]!=res->dimensions[d]){
            staterr(err,"output parameter has wrong shape");ln_array_free(res);return NULL;
        }
        ln_intp count=ln_array_size(res),oc[LN_MAXDIMS]={0};
        for(ln_intp i=0;i<count;i++){
            char *src=res->data,*dst=out->data;
            for(int d=0;d<res->nd;d++){
                src+=oc[d]*res->strides[d];dst+=oc[d]*out->strides[d];
            }
            if(ln_cast_strided_numeric(src,0,res->descr,dst,0,out->descr,1,err)<0){
                ln_array_free(res);return NULL;
            }
            stat_next(res->nd,res->dimensions,oc);
        }
    }
    return res;
}
