#include "ln_matrix.h"
#include "ln_linalg.h"
#include "ln_vector.h"
#include "ln_dtype_transfer.h"
#include "ln_complex.h"
#include "ln_dot.h"
#include "ln_matmul.h"
#include "ln_mapping.h"

#include <limits.h>
#include <float.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Debian/system LAPACK Fortran ABI. NumPy's linalg core ultimately dispatches
 * to the same GESV/GETRF/POTRF families through its lapack_lite wrappers. */
extern void dgesv_(const int *n, const int *nrhs, double *a, const int *lda,
                   int *ipiv, double *b, const int *ldb, int *info);
extern void zgesv_(const int *n, const int *nrhs, ln_cdouble *a, const int *lda,
                   int *ipiv, ln_cdouble *b, const int *ldb, int *info);
extern void dgetrf_(const int *m, const int *n, double *a, const int *lda,
                    int *ipiv, int *info);
extern void zgetrf_(const int *m, const int *n, ln_cdouble *a, const int *lda,
                    int *ipiv, int *info);
extern void dpotrf_(const char *uplo, const int *n, double *a, const int *lda,
                    int *info);
extern void zpotrf_(const char *uplo, const int *n, ln_cdouble *a, const int *lda,
                    int *info);
extern void dgeqrf_(const int *m, const int *n, double *a, const int *lda,
                    double *tau, double *work, const int *lwork, int *info);
extern void zgeqrf_(const int *m, const int *n, ln_cdouble *a, const int *lda,
                    ln_cdouble *tau, ln_cdouble *work, const int *lwork, int *info);
extern void dorgqr_(const int *m, const int *n, const int *k, double *a, const int *lda,
                    const double *tau, double *work, const int *lwork, int *info);
extern void zungqr_(const int *m, const int *n, const int *k, ln_cdouble *a, const int *lda,
                    const ln_cdouble *tau, ln_cdouble *work, const int *lwork, int *info);

extern void dgeev_(const char *jobvl, const char *jobvr, const int *n,
                   double *a, const int *lda, double *wr, double *wi,
                   double *vl, const int *ldvl, double *vr, const int *ldvr,
                   double *work, const int *lwork, int *info);
extern void zgeev_(const char *jobvl, const char *jobvr, const int *n,
                   ln_cdouble *a, const int *lda, ln_cdouble *w,
                   ln_cdouble *vl, const int *ldvl, ln_cdouble *vr, const int *ldvr,
                   ln_cdouble *work, const int *lwork, double *rwork, int *info);
extern void dsyevd_(const char *jobz, const char *uplo, const int *n,
                    double *a, const int *lda, double *w,
                    double *work, const int *lwork, int *iwork,
                    const int *liwork, int *info);
extern void zheevd_(const char *jobz, const char *uplo, const int *n,
                    ln_cdouble *a, const int *lda, double *w,
                    ln_cdouble *work, const int *lwork, double *rwork,
                    const int *lrwork, int *iwork, const int *liwork, int *info);
extern void dgesdd_(const char *jobz, const int *m, const int *n,
                    double *a, const int *lda, double *s,
                    double *u, const int *ldu, double *vt, const int *ldvt,
                    double *work, const int *lwork, int *iwork, int *info);
extern void zgesdd_(const char *jobz, const int *m, const int *n,
                    ln_cdouble *a, const int *lda, double *s,
                    ln_cdouble *u, const int *ldu, ln_cdouble *vt, const int *ldvt,
                    ln_cdouble *work, const int *lwork, double *rwork,
                    int *iwork, int *info);
extern void dgelsd_(const int *m, const int *n, const int *nrhs,
                    double *a, const int *lda, double *b, const int *ldb,
                    double *s, const double *rcond, int *rank,
                    double *work, const int *lwork, int *iwork, int *info);
extern void zgelsd_(const int *m, const int *n, const int *nrhs,
                    ln_cdouble *a, const int *lda, ln_cdouble *b, const int *ldb,
                    double *s, const double *rcond, int *rank,
                    ln_cdouble *work, const int *lwork, double *rwork,
                    int *iwork, int *info);

static void
seterr(ln_error *err, const char *msg)
{
    if (err) snprintf(err->message, sizeof(err->message), "%s", msg ? msg : "LuaRay linalg error");
}

static int
checked_count(ln_intp a, ln_intp b, size_t elem, size_t *out, ln_error *err)
{
    if (a < 0 || b < 0) { seterr(err, "invalid negative linalg dimension"); return -1; }
    if (a != 0 && (size_t)b > SIZE_MAX / (size_t)a) {
        seterr(err, "array is too big"); return -1;
    }
    size_t n = (size_t)a * (size_t)b;
    if (elem != 0 && n > SIZE_MAX / elem) { seterr(err, "array is too big"); return -1; }
    *out = n * elem;
    return 0;
}

static int
check_square(const ln_array *a, ln_error *err)
{
    if (!a || a->nd < 2) {
        char msg[160];
        snprintf(msg, sizeof(msg), "%d-dimensional array given. Array must be at least two-dimensional",
                 a ? a->nd : 0);
        seterr(err, msg);
        return -1;
    }
    if (a->dimensions[a->nd-2] != a->dimensions[a->nd-1]) {
        seterr(err, "Last 2 dimensions of the array must be square");
        return -1;
    }
    return 0;
}

typedef struct {
    const ln_dtype *compute;
    const ln_dtype *result;
    int complex;
} common_type;

/* Direct host-neutral translation of numpy/linalg/_linalg.py::_commonType. */
static int
common_type_for(const ln_array *const *arrs, int narr, common_type *out, ln_error *err)
{
    int result_double = 0;
    int is_complex = 0;
    for (int i = 0; i < narr; ++i) {
        const ln_dtype *dt = arrs[i]->descr;
        switch (dt->type_num) {
            case LN_FLOAT:
                break;
            case LN_DOUBLE:
                result_double = 1;
                break;
            case LN_CFLOAT:
                is_complex = 1;
                break;
            case LN_CDOUBLE:
                is_complex = 1;
                result_double = 1;
                break;
            case LN_HALF:
            case LN_LONGDOUBLE:
            case LN_CLONGDOUBLE: {
                char msg[160];
                snprintf(msg,sizeof(msg),"array type %s is unsupported in linalg",dt->name);
                seterr(err,msg);
                return -1;
            }
            default:
                /* Exact upstream lite behavior: non-inexact types force double. */
                result_double = 1;
                break;
        }
    }
    out->complex = is_complex;
    out->compute = ln_dtype_by_num(is_complex ? LN_CDOUBLE : LN_DOUBLE);
    if (is_complex) out->result = ln_dtype_by_num(result_double ? LN_CDOUBLE : LN_CFLOAT);
    else out->result = ln_dtype_by_num(result_double ? LN_DOUBLE : LN_FLOAT);
    return 0;
}

static void
advance_index(int nd, const ln_intp *shape, ln_intp *idx)
{
    for (int d = nd-1; d >= 0; --d) {
        idx[d]++;
        if (idx[d] < shape[d]) return;
        idx[d] = 0;
    }
}

static ln_intp
shape_product(int nd, const ln_intp *shape, ln_error *err)
{
    ln_intp n = 1;
    for (int i=0;i<nd;i++) {
        if (shape[i] == 0) return 0;
        if (ln_mul_sizes_with_overflow(&n,n,shape[i])) { seterr(err,"array is too big"); return -1; }
    }
    return n;
}

static const char *
batch_ptr_const(const ln_array *a, int outer_nd, const ln_intp *out_idx,
                int out_outer_nd)
{
    const char *p = a->data;
    int offset = out_outer_nd - outer_nd;
    for (int d=0; d<outer_nd; ++d) {
        ln_intp ix = a->dimensions[d] == 1 ? 0 : out_idx[d+offset];
        p += ix * a->strides[d];
    }
    return p;
}

static char *
batch_ptr_out(ln_array *a, const ln_intp *idx, int outer_nd)
{
    char *p=a->data;
    for(int d=0;d<outer_nd;d++) p += idx[d]*a->strides[d];
    return p;
}

static int
pack_matrix(const ln_array *src, const char *base, ln_intp rows, ln_intp cols,
            const ln_dtype *compute, void *dst, ln_error *err)
{
    ln_intp rs = src->strides[src->nd-2], cs = src->strides[src->nd-1];
    size_t es = compute->elsize;
    for (ln_intp i=0;i<rows;i++) {
        for (ln_intp j=0;j<cols;j++) {
            const char *sp = base + i*rs + j*cs;
            char *dp = (char *)dst + ((size_t)j*(size_t)rows + (size_t)i)*es;
            if (ln_cast_strided_numeric(sp,0,src->descr,dp,0,compute,1,err)<0) return -1;
        }
    }
    return 0;
}

static int
pack_rhs_vector(const ln_array *src, const char *base, ln_intp n,
                const ln_dtype *compute, void *dst, ln_error *err)
{
    ln_intp s = src->strides[src->nd-1];
    size_t es=compute->elsize;
    for(ln_intp i=0;i<n;i++) {
        if(ln_cast_strided_numeric(base+i*s,0,src->descr,
                                   (char*)dst+(size_t)i*es,0,compute,1,err)<0) return -1;
    }
    return 0;
}

static int
pack_rhs_matrix(const ln_array *src, const char *base, ln_intp n, ln_intp nrhs,
                const ln_dtype *compute, void *dst, ln_error *err)
{
    return pack_matrix(src,base,n,nrhs,compute,dst,err);
}

static int
unpack_matrix(const void *src, const ln_dtype *compute, ln_intp rows, ln_intp cols,
              ln_array *dst, char *base, int core_nd, ln_error *err)
{
    size_t es=compute->elsize;
    ln_intp rs = dst->strides[dst->nd-core_nd];
    ln_intp cs = core_nd==1 ? 0 : dst->strides[dst->nd-1];
    if (core_nd==1) {
        for(ln_intp i=0;i<rows;i++) {
            const char *sp=(const char*)src+(size_t)i*es;
            char *dp=base+i*rs;
            if(ln_cast_strided_numeric(sp,0,compute,dp,0,dst->descr,1,err)<0)return -1;
        }
        return 0;
    }
    for(ln_intp i=0;i<rows;i++) {
        for(ln_intp j=0;j<cols;j++) {
            const char *sp=(const char*)src+((size_t)j*(size_t)rows+(size_t)i)*es;
            char *dp=base+i*rs+j*cs;
            if(ln_cast_strided_numeric(sp,0,compute,dp,0,dst->descr,1,err)<0)return -1;
        }
    }
    return 0;
}

static int
broadcast_outer_shapes(const ln_array *a, int a_outer, const ln_array *b, int b_outer,
                       int *out_nd, ln_intp *out_shape, ln_error *err)
{
    int nd=a_outer>b_outer?a_outer:b_outer;
    for(int k=0;k<nd;k++) {
        int ai=a_outer-1-k, bi=b_outer-1-k, oi=nd-1-k;
        ln_intp ad=ai>=0?a->dimensions[ai]:1;
        ln_intp bd=bi>=0?b->dimensions[bi]:1;
        if(ad!=bd && ad!=1 && bd!=1) {
            seterr(err,"operands could not be broadcast together with remapped shapes");
            return -1;
        }
        out_shape[oi]=ad>bd?ad:bd;
    }
    *out_nd=nd;
    return 0;
}

static int
lapack_dim(ln_intp n, int *out, ln_error *err)
{
    if(n<0 || n>INT_MAX){seterr(err,"array dimensions are too large for LAPACK");return -1;}
    *out=(int)n; return 0;
}

ln_array *
ln_linalg_solve(const ln_array *a, const ln_array *b, ln_error *err)
{
    if(check_square(a,err)<0)return NULL;
    if(!b){seterr(err,"invalid right-hand side");return NULL;}
    ln_intp n=a->dimensions[a->nd-1];
    int vector=(b->nd==1);
    if(!vector && b->nd<2){
        seterr(err,"solve: Input operand 1 does not have enough dimensions");return NULL;
    }
    if((vector?b->dimensions[0]:b->dimensions[b->nd-2])!=n){
        seterr(err,"solve: Input operand 1 has a mismatch in its core dimension 0");return NULL;
    }
    ln_intp nrhs=vector?1:b->dimensions[b->nd-1];
    int a_outer=a->nd-2, b_outer=vector?0:b->nd-2;
    ln_intp outer[LN_MAXDIMS]; int outer_nd=0;
    if(broadcast_outer_shapes(a,a_outer,b,b_outer,&outer_nd,outer,err)<0)return NULL;

    const ln_array *arrs[2]={a,b}; common_type ct;
    if(common_type_for(arrs,2,&ct,err)<0)return NULL;

    int out_nd=outer_nd+(vector?1:2); ln_intp dims[LN_MAXDIMS];
    for(int i=0;i<outer_nd;i++)dims[i]=outer[i];
    dims[outer_nd]=n; if(!vector)dims[outer_nd+1]=nrhs;
    ln_array *out=ln_array_new(out_nd,dims,ct.result,0,0,err); if(!out)return NULL;

    ln_intp batches=shape_product(outer_nd,outer,err); if(batches<0){ln_array_free(out);return NULL;}
    if(batches==0 || n==0)return out;
    int ni,nri;if(lapack_dim(n,&ni,err)<0||lapack_dim(nrhs,&nri,err)<0){ln_array_free(out);return NULL;}
    int lda=ni>0?ni:1, ldb=ni>0?ni:1;
    size_t abytes,bbytes;
    if(checked_count(n,n,ct.compute->elsize,&abytes,err)<0||checked_count(n,nrhs,ct.compute->elsize,&bbytes,err)<0){ln_array_free(out);return NULL;}
    void *aw=malloc(abytes?abytes:1),*bw=malloc(bbytes?bbytes:1); int *ipiv=(int*)malloc((size_t)(ni?ni:1)*sizeof(int));
    if(!aw||!bw||!ipiv){free(aw);free(bw);free(ipiv);ln_array_free(out);seterr(err,"out of memory");return NULL;}
    ln_intp idx[LN_MAXDIMS]={0};
    for(ln_intp batch=0;batch<batches;batch++) {
        const char *ap=batch_ptr_const(a,a_outer,idx,outer_nd);
        const char *bp=vector?b->data:batch_ptr_const(b,b_outer,idx,outer_nd);
        if(pack_matrix(a,ap,n,n,ct.compute,aw,err)<0 ||
           (vector?pack_rhs_vector(b,bp,n,ct.compute,bw,err):pack_rhs_matrix(b,bp,n,nrhs,ct.compute,bw,err))<0) goto fail;
        int info=0;
        if(ct.complex)zgesv_(&ni,&nri,(ln_cdouble*)aw,&lda,ipiv,(ln_cdouble*)bw,&ldb,&info);
        else dgesv_(&ni,&nri,(double*)aw,&lda,ipiv,(double*)bw,&ldb,&info);
        if(info>0){seterr(err,"Singular matrix");goto fail;}
        if(info<0){seterr(err,"LAPACK GESV received an illegal argument");goto fail;}
        char *op=batch_ptr_out(out,idx,outer_nd);
        if(unpack_matrix(bw,ct.compute,n,nrhs,out,op,vector?1:2,err)<0)goto fail;
        advance_index(outer_nd,outer,idx);
    }
    free(aw);free(bw);free(ipiv);return out;
fail:
    free(aw);free(bw);free(ipiv);ln_array_free(out);return NULL;
}

ln_array *
ln_linalg_inv(const ln_array *a, ln_error *err)
{
    if(check_square(a,err)<0)return NULL;
    const ln_array *arrs[1]={a};common_type ct;if(common_type_for(arrs,1,&ct,err)<0)return NULL;
    ln_array *out=ln_array_new(a->nd,a->dimensions,ct.result,0,0,err);if(!out)return NULL;
    ln_intp n=a->dimensions[a->nd-1], batches=shape_product(a->nd-2,a->dimensions,err);
    if(batches<0){ln_array_free(out);return NULL;} if(batches==0||n==0)return out;
    int ni;if(lapack_dim(n,&ni,err)<0){ln_array_free(out);return NULL;} int nrhs=ni,lda=ni,ldb=ni;
    size_t bytes;if(checked_count(n,n,ct.compute->elsize,&bytes,err)<0){ln_array_free(out);return NULL;}
    void *aw=malloc(bytes?bytes:1),*bw=malloc(bytes?bytes:1);int*ipiv=(int*)malloc((size_t)ni*sizeof(int));
    if(!aw||!bw||!ipiv){free(aw);free(bw);free(ipiv);ln_array_free(out);seterr(err,"out of memory");return NULL;}
    ln_intp idx[LN_MAXDIMS]={0};
    for(ln_intp batch=0;batch<batches;batch++){
        const char *ap=batch_ptr_const(a,a->nd-2,idx,a->nd-2);
        if(pack_matrix(a,ap,n,n,ct.compute,aw,err)<0)goto fail;
        memset(bw,0,bytes);
        for(ln_intp i=0;i<n;i++){
            if(ct.complex){ln_cdouble one={1.0,0.0};memcpy((char*)bw+((size_t)i*(size_t)n+(size_t)i)*sizeof(one),&one,sizeof(one));}
            else ((double*)bw)[(size_t)i*(size_t)n+(size_t)i]=1.0;
        }
        int info=0;if(ct.complex)zgesv_(&ni,&nrhs,(ln_cdouble*)aw,&lda,ipiv,(ln_cdouble*)bw,&ldb,&info);else dgesv_(&ni,&nrhs,(double*)aw,&lda,ipiv,(double*)bw,&ldb,&info);
        if(info>0){seterr(err,"Singular matrix");goto fail;}if(info<0){seterr(err,"LAPACK GESV received an illegal argument");goto fail;}
        char *op=batch_ptr_out(out,idx,a->nd-2);if(unpack_matrix(bw,ct.compute,n,n,out,op,2,err)<0)goto fail;
        advance_index(a->nd-2,a->dimensions,idx);
    }
    free(aw);free(bw);free(ipiv);return out;
fail:free(aw);free(bw);free(ipiv);ln_array_free(out);return NULL;
}

static int
factor_for_det(const ln_array *a,const char *ap,ln_intp n,const common_type *ct,
               void *work,int *ipiv,ln_error *err)
{
    if(pack_matrix(a,ap,n,n,ct->compute,work,err)<0)return -1;
    int ni;if(lapack_dim(n,&ni,err)<0)return -1;int lda=ni?ni:1,info=0;
    if(ct->complex)zgetrf_(&ni,&ni,(ln_cdouble*)work,&lda,ipiv,&info);
    else dgetrf_(&ni,&ni,(double*)work,&lda,ipiv,&info);
    if(info<0){seterr(err,"LAPACK GETRF received an illegal argument");return -1;}
    return 0;
}

static void
slogdet_real(const double *lu,const int *ipiv,int n,double *sign,double *logabs)
{
    double s=1.0, l=0.0;
    for(int i=0;i<n;i++)if(ipiv[i]!=(i+1))s=-s;
    for(int i=0;i<n;i++){
        double d=lu[(size_t)i*(size_t)n+(size_t)i],ad=fabs(d);
        if(ad==0.0){*sign=0.0;*logabs=-INFINITY;return;}
        s*=d/ad;l+=log(ad);
    }
    *sign=s;*logabs=l;
}

static ln_cdouble
cmul(ln_cdouble a,ln_cdouble b){ln_cdouble z={a.real*b.real-a.imag*b.imag,a.real*b.imag+a.imag*b.real};return z;}

static void
slogdet_complex(const ln_cdouble *lu,const int *ipiv,int n,ln_cdouble *sign,double *logabs)
{
    ln_cdouble s={1.0,0.0};double l=0.0;
    for(int i=0;i<n;i++)if(ipiv[i]!=(i+1)){s.real=-s.real;s.imag=-s.imag;}
    for(int i=0;i<n;i++){
        ln_cdouble d=lu[(size_t)i*(size_t)n+(size_t)i];double ad=hypot(d.real,d.imag);
        if(ad==0.0){sign->real=0.0;sign->imag=0.0;*logabs=-INFINITY;return;}
        ln_cdouble u={d.real/ad,d.imag/ad};s=cmul(s,u);l+=log(ad);
    }
    *sign=s;*logabs=l;
}

int
ln_linalg_slogdet(const ln_array *a, ln_array **sign_out, ln_array **log_out, ln_error *err)
{
    if (sign_out) *sign_out=NULL;
    if (log_out) *log_out=NULL;
    if(check_square(a,err)<0)return -1;
    const ln_array *arrs[1]={a};common_type ct;if(common_type_for(arrs,1,&ct,err)<0)return -1;
    const ln_dtype *real_result=ln_dtype_by_num(ct.result->type_num==LN_CFLOAT?LN_FLOAT:LN_DOUBLE);
    if(ct.result->type_num==LN_FLOAT)real_result=ln_dtype_by_num(LN_FLOAT);
    int od=a->nd-2;ln_array *sign=ln_array_new(od,a->dimensions,ct.result,0,0,err);if(!sign)return -1;
    ln_array *logv=ln_array_new(od,a->dimensions,real_result,0,0,err);if(!logv){ln_array_free(sign);return -1;}
    ln_intp n=a->dimensions[a->nd-1],batches=shape_product(od,a->dimensions,err);if(batches<0)goto fail;
    if(batches==0){*sign_out=sign;*log_out=logv;return 0;}
    if(n==0){
        ln_intp idx[LN_MAXDIMS]={0};
        for(ln_intp q=0;q<batches;q++){
            char*sp=batch_ptr_out(sign,idx,od);char*lp=batch_ptr_out(logv,idx,od);
            double one=1.0,zero=0.0;ln_cdouble cone={1.0,0.0};
            if(ln_cast_strided_numeric(ct.complex?(char*)&cone:(char*)&one,0,ct.compute,sp,0,sign->descr,1,err)<0||ln_cast_strided_numeric((char*)&zero,0,ln_dtype_by_num(LN_DOUBLE),lp,0,logv->descr,1,err)<0)goto fail;
            advance_index(od,a->dimensions,idx);
        }
        *sign_out=sign;*log_out=logv;return 0;
    }
    int ni;if(lapack_dim(n,&ni,err)<0)goto fail;size_t bytes;if(checked_count(n,n,ct.compute->elsize,&bytes,err)<0)goto fail;
    void*work=malloc(bytes?bytes:1);int*ipiv=(int*)malloc((size_t)ni*sizeof(int));if(!work||!ipiv){free(work);free(ipiv);seterr(err,"out of memory");goto fail;}
    ln_intp idx[LN_MAXDIMS]={0};
    for(ln_intp q=0;q<batches;q++){
        const char*ap=batch_ptr_const(a,od,idx,od);if(factor_for_det(a,ap,n,&ct,work,ipiv,err)<0){free(work);free(ipiv);goto fail;}
        char*sp=batch_ptr_out(sign,idx,od);char*lp=batch_ptr_out(logv,idx,od);double l;
        if(ct.complex){ln_cdouble s;slogdet_complex((ln_cdouble*)work,ipiv,ni,&s,&l);if(ln_cast_strided_numeric((char*)&s,0,ct.compute,sp,0,sign->descr,1,err)<0){free(work);free(ipiv);goto fail;}}
        else{double s;slogdet_real((double*)work,ipiv,ni,&s,&l);if(ln_cast_strided_numeric((char*)&s,0,ct.compute,sp,0,sign->descr,1,err)<0){free(work);free(ipiv);goto fail;}}
        if(ln_cast_strided_numeric((char*)&l,0,ln_dtype_by_num(LN_DOUBLE),lp,0,logv->descr,1,err)<0){free(work);free(ipiv);goto fail;}
        advance_index(od,a->dimensions,idx);
    }
    free(work);free(ipiv);*sign_out=sign;*log_out=logv;return 0;
fail:ln_array_free(sign);ln_array_free(logv);return -1;
}

ln_array *
ln_linalg_det(const ln_array *a, ln_error *err)
{
    if (check_square(a,err)<0) return NULL;
    const ln_array *arrs[1]={a};
    common_type ct;
    if (common_type_for(arrs,1,&ct,err)<0) return NULL;

    int od=a->nd-2;
    ln_array *out=ln_array_new(od,a->dimensions,ct.result,0,0,err);
    if (!out) return NULL;
    ln_intp n=a->dimensions[a->nd-1];
    ln_intp batches=shape_product(od,a->dimensions,err);
    if (batches<0) { ln_array_free(out); return NULL; }
    if (batches==0) return out;

    if (n==0) {
        ln_intp idx[LN_MAXDIMS]={0};
        for (ln_intp q=0;q<batches;q++) {
            char *op=batch_ptr_out(out,idx,od);
            if (ct.complex) {
                ln_cdouble one={1.0,0.0};
                if (ln_cast_strided_numeric((char*)&one,0,ct.compute,op,0,out->descr,1,err)<0) goto fail_empty;
            }
            else {
                double one=1.0;
                if (ln_cast_strided_numeric((char*)&one,0,ct.compute,op,0,out->descr,1,err)<0) goto fail_empty;
            }
            advance_index(od,a->dimensions,idx);
        }
        return out;
    }

    int ni;
    if (lapack_dim(n,&ni,err)<0) { ln_array_free(out); return NULL; }
    size_t bytes;
    if (checked_count(n,n,ct.compute->elsize,&bytes,err)<0) { ln_array_free(out); return NULL; }
    void *work=malloc(bytes?bytes:1);
    int *ipiv=(int*)malloc((size_t)ni*sizeof(int));
    if (!work || !ipiv) {
        free(work); free(ipiv); ln_array_free(out); seterr(err,"out of memory"); return NULL;
    }

    ln_intp idx[LN_MAXDIMS]={0};
    for (ln_intp q=0;q<batches;q++) {
        const char *ap=batch_ptr_const(a,od,idx,od);
        if (factor_for_det(a,ap,n,&ct,work,ipiv,err)<0) goto fail;
        char *op=batch_ptr_out(out,idx,od);
        if (ct.complex) {
            ln_cdouble sign,z;
            double logabs,mag;
            slogdet_complex((ln_cdouble*)work,ipiv,ni,&sign,&logabs);
            mag=exp(logabs);
            z.real=sign.real*mag;
            z.imag=sign.imag*mag;
            if (ln_cast_strided_numeric((char*)&z,0,ct.compute,op,0,out->descr,1,err)<0) goto fail;
        }
        else {
            double sign,logabs,z;
            slogdet_real((double*)work,ipiv,ni,&sign,&logabs);
            z=sign*exp(logabs);
            if (ln_cast_strided_numeric((char*)&z,0,ct.compute,op,0,out->descr,1,err)<0) goto fail;
        }
        advance_index(od,a->dimensions,idx);
    }
    free(work); free(ipiv); return out;
fail:
    free(work); free(ipiv); ln_array_free(out); return NULL;
fail_empty:
    ln_array_free(out); return NULL;
}

ln_array *
ln_linalg_cholesky(const ln_array *a, int upper, ln_error *err)
{
    if (check_square(a,err)<0) return NULL;
    const ln_array *arrs[1]={a};
    common_type ct;
    if (common_type_for(arrs,1,&ct,err)<0) return NULL;
    ln_array*out=ln_array_new(a->nd,a->dimensions,ct.result,0,1,err);if(!out)return NULL;
    ln_intp n=a->dimensions[a->nd-1],batches=shape_product(a->nd-2,a->dimensions,err);if(batches<0){ln_array_free(out);return NULL;}if(batches==0||n==0)return out;
    int ni;if(lapack_dim(n,&ni,err)<0){ln_array_free(out);return NULL;}int lda=ni;size_t bytes;if(checked_count(n,n,ct.compute->elsize,&bytes,err)<0){ln_array_free(out);return NULL;}
    void*work=malloc(bytes?bytes:1);if(!work){ln_array_free(out);seterr(err,"out of memory");return NULL;}ln_intp idx[LN_MAXDIMS]={0};char uplo=upper?'U':'L';
    for(ln_intp q=0;q<batches;q++){
        const char*ap=batch_ptr_const(a,a->nd-2,idx,a->nd-2);if(pack_matrix(a,ap,n,n,ct.compute,work,err)<0)goto fail;int info=0;
        if(ct.complex)zpotrf_(&uplo,&ni,(ln_cdouble*)work,&lda,&info);else dpotrf_(&uplo,&ni,(double*)work,&lda,&info);
        if(info>0){seterr(err,"Matrix is not positive definite");goto fail;}if(info<0){seterr(err,"LAPACK POTRF received an illegal argument");goto fail;}
        char*op=batch_ptr_out(out,idx,a->nd-2);size_t es=ct.compute->elsize;
        for(ln_intp i=0;i<n;i++)for(ln_intp j=0;j<n;j++){
            int keep=upper?(j>=i):(j<=i);if(!keep)continue;
            const char*sp=(const char*)work+((size_t)j*(size_t)n+(size_t)i)*es;char*dp=op+i*out->strides[out->nd-2]+j*out->strides[out->nd-1];
            if(ln_cast_strided_numeric(sp,0,ct.compute,dp,0,out->descr,1,err)<0)goto fail;
        }
        advance_index(a->nd-2,a->dimensions,idx);
    }
    free(work);return out;
fail:free(work);ln_array_free(out);return NULL;
}


static int
lapack_qr_factor(int m, int n, int complex_mode, void *a, void *tau, ln_error *err)
{
    int lda=m>0?m:1, info=0, lwork=-1;
    if (complex_mode) {
        ln_cdouble query={0.0,0.0};
        zgeqrf_(&m,&n,(ln_cdouble*)a,&lda,(ln_cdouble*)tau,&query,&lwork,&info);
        if (info<0) { seterr(err,"LAPACK GEQRF workspace query failed"); return -1; }
        lwork=(int)query.real; if(lwork<1)lwork=1;
        ln_cdouble *work=(ln_cdouble*)malloc((size_t)lwork*sizeof(*work));
        if(!work){seterr(err,"out of memory");return -1;}
        zgeqrf_(&m,&n,(ln_cdouble*)a,&lda,(ln_cdouble*)tau,work,&lwork,&info);
        free(work);
    }
    else {
        double query=0.0;
        dgeqrf_(&m,&n,(double*)a,&lda,(double*)tau,&query,&lwork,&info);
        if (info<0) { seterr(err,"LAPACK GEQRF workspace query failed"); return -1; }
        lwork=(int)query; if(lwork<1)lwork=1;
        double *work=(double*)malloc((size_t)lwork*sizeof(*work));
        if(!work){seterr(err,"out of memory");return -1;}
        dgeqrf_(&m,&n,(double*)a,&lda,(double*)tau,work,&lwork,&info);
        free(work);
    }
    if(info!=0){seterr(err,"QR decomposition failed");return -1;}
    return 0;
}

static int
lapack_qr_generate_q(int m, int nq, int k, int complex_mode, void *a,
                     const void *tau, ln_error *err)
{
    int lda=m>0?m:1, info=0, lwork=-1;
    if (complex_mode) {
        ln_cdouble query={0.0,0.0};
        zungqr_(&m,&nq,&k,(ln_cdouble*)a,&lda,(const ln_cdouble*)tau,&query,&lwork,&info);
        if(info<0){seterr(err,"LAPACK UNGQR workspace query failed");return -1;}
        lwork=(int)query.real;if(lwork<1)lwork=1;
        ln_cdouble*work=(ln_cdouble*)malloc((size_t)lwork*sizeof(*work));if(!work){seterr(err,"out of memory");return -1;}
        zungqr_(&m,&nq,&k,(ln_cdouble*)a,&lda,(const ln_cdouble*)tau,work,&lwork,&info);free(work);
    }
    else {
        double query=0.0;
        dorgqr_(&m,&nq,&k,(double*)a,&lda,(const double*)tau,&query,&lwork,&info);
        if(info<0){seterr(err,"LAPACK ORGQR workspace query failed");return -1;}
        lwork=(int)query;if(lwork<1)lwork=1;
        double*work=(double*)malloc((size_t)lwork*sizeof(*work));if(!work){seterr(err,"out of memory");return -1;}
        dorgqr_(&m,&nq,&k,(double*)a,&lda,(const double*)tau,work,&lwork,&info);free(work);
    }
    if(info!=0){seterr(err,"QR decomposition failed");return -1;}
    return 0;
}

static int
copy_factor_logical(const void *fac, const ln_dtype *compute, ln_intp lda_rows,
                    ln_intp rows, ln_intp cols, ln_array *dst, char *base,
                    int transpose, int upper_only, ln_error *err)
{
    size_t es=compute->elsize;
    for(ln_intp i=0;i<rows;i++)for(ln_intp j=0;j<cols;j++){
        if(upper_only && j<i)continue;
        const char*sp=(const char*)fac+((size_t)j*(size_t)lda_rows+(size_t)i)*es;
        ln_intp oi=transpose?j:i, oj=transpose?i:j;
        char*dp=base+oi*dst->strides[dst->nd-2]+oj*dst->strides[dst->nd-1];
        if(ln_cast_strided_numeric(sp,0,compute,dp,0,dst->descr,1,err)<0)return -1;
    }
    return 0;
}

int
ln_linalg_qr(const ln_array *a, ln_qr_mode mode,
             ln_array **q_or_h, ln_array **r_or_tau, ln_error *err)
{
    if (q_or_h) *q_or_h=NULL;
    if (r_or_tau) *r_or_tau=NULL;
    if(!a || a->nd<2){
        char msg[160];snprintf(msg,sizeof(msg),"%d-dimensional array given. Array must be at least two-dimensional",a?a->nd:0);seterr(err,msg);return -1;
    }
    const ln_array*arrs[1]={a};common_type ct;if(common_type_for(arrs,1,&ct,err)<0)return -1;
    ln_intp m=a->dimensions[a->nd-2],n=a->dimensions[a->nd-1],k=m<n?m:n;
    int od=a->nd-2;ln_intp batches=shape_product(od,a->dimensions,err);if(batches<0)return -1;
    int mi,ni,ki;if(lapack_dim(m,&mi,err)<0||lapack_dim(n,&ni,err)<0||lapack_dim(k,&ki,err)<0)return -1;

    ln_array *first=NULL,*second=NULL;
    ln_intp d1[LN_MAXDIMS],d2[LN_MAXDIMS];for(int i=0;i<od;i++){d1[i]=a->dimensions[i];d2[i]=a->dimensions[i];}
    int mc=(mode==LN_QR_COMPLETE && m>n)?mi:ki;
    if(mode==LN_QR_R){d1[od]=k;d1[od+1]=n;first=ln_array_new(od+2,d1,ct.result,0,1,err);}
    else if(mode==LN_QR_RAW){d1[od]=n;d1[od+1]=m;d2[od]=k;first=ln_array_new(od+2,d1,ct.result,0,0,err);if(first)second=ln_array_new(od+1,d2,ct.result,0,0,err);}
    else if(mode==LN_QR_ECONOMIC){d1[od]=m;d1[od+1]=n;first=ln_array_new(od+2,d1,ct.result,0,0,err);}
    else {d1[od]=m;d1[od+1]=mc;d2[od]=mc;d2[od+1]=n;first=ln_array_new(od+2,d1,ct.result,0,0,err);if(first)second=ln_array_new(od+2,d2,ct.result,0,1,err);}
    if(!first || ((mode==LN_QR_RAW || mode==LN_QR_REDUCED || mode==LN_QR_COMPLETE)&&!second)){ln_array_free(first);ln_array_free(second);return -1;}
    if(batches==0){*q_or_h=first;if(r_or_tau)*r_or_tau=second;return 0;}

    size_t abytes,tbytes,qbytes;
    if(checked_count(m,n,ct.compute->elsize,&abytes,err)<0||checked_count(k,1,ct.compute->elsize,&tbytes,err)<0){goto fail;}
    if(checked_count(m,mc,ct.compute->elsize,&qbytes,err)<0)goto fail;
    void*fac=malloc(abytes?abytes:1);void*tau=malloc(tbytes?tbytes:1);void*qwork=NULL;
    if((mode==LN_QR_REDUCED||mode==LN_QR_COMPLETE)&&m>0&&mc>0)qwork=malloc(qbytes?qbytes:1);
    if(!fac||!tau||(((mode==LN_QR_REDUCED||mode==LN_QR_COMPLETE)&&m>0&&mc>0)&&!qwork)){free(fac);free(tau);free(qwork);seterr(err,"out of memory");goto fail;}
    ln_intp idx[LN_MAXDIMS]={0};
    for(ln_intp batch=0;batch<batches;batch++){
        const char*ap=batch_ptr_const(a,od,idx,od);
        if(m>0&&n>0){if(pack_matrix(a,ap,m,n,ct.compute,fac,err)<0)goto fail_work;if(lapack_qr_factor(mi,ni,ct.complex,fac,tau,err)<0)goto fail_work;}
        char*p1=batch_ptr_out(first,idx,od);char*p2=second?batch_ptr_out(second,idx,od):NULL;
        if(mode==LN_QR_R){if(m>0&&n>0&&copy_factor_logical(fac,ct.compute,m,k,n,first,p1,0,1,err)<0)goto fail_work;}
        else if(mode==LN_QR_RAW){
            if(m>0&&n>0&&copy_factor_logical(fac,ct.compute,m,m,n,first,p1,1,0,err)<0)goto fail_work;
            for(ln_intp i=0;i<k;i++){const char*sp=(const char*)tau+(size_t)i*ct.compute->elsize;char*dp=p2+i*second->strides[second->nd-1];if(ln_cast_strided_numeric(sp,0,ct.compute,dp,0,second->descr,1,err)<0)goto fail_work;}
        }
        else if(mode==LN_QR_ECONOMIC){if(m>0&&n>0&&copy_factor_logical(fac,ct.compute,m,m,n,first,p1,0,0,err)<0)goto fail_work;}
        else {
            /* R comes from the factorization before ORGQR overwrites it. */
            if(m>0&&n>0&&copy_factor_logical(fac,ct.compute,m,k,n,second,p2,0,1,err)<0)goto fail_work;
            if(m>0&&mc>0){
                memset(qwork,0,qbytes);size_t es=ct.compute->elsize;ln_intp copycols=n<mc?n:mc;
                for(ln_intp j=0;j<copycols;j++)memcpy((char*)qwork+(size_t)j*(size_t)m*es,(char*)fac+(size_t)j*(size_t)m*es,(size_t)m*es);
                if(lapack_qr_generate_q(mi,mc,ki,ct.complex,qwork,tau,err)<0)goto fail_work;
                if(unpack_matrix(qwork,ct.compute,m,mc,first,p1,2,err)<0)goto fail_work;
            }
            else if(mode==LN_QR_COMPLETE && m>0 && n==0){
                for(ln_intp i=0;i<m;i++)for(ln_intp j=0;j<m;j++)if(i==j){char*dp=p1+i*first->strides[first->nd-2]+j*first->strides[first->nd-1];if(ct.complex){ln_cdouble one={1,0};if(ln_cast_strided_numeric((char*)&one,0,ct.compute,dp,0,first->descr,1,err)<0)goto fail_work;}else{double one=1;if(ln_cast_strided_numeric((char*)&one,0,ct.compute,dp,0,first->descr,1,err)<0)goto fail_work;}}
            }
        }
        advance_index(od,a->dimensions,idx);
    }
    free(fac);free(tau);free(qwork);*q_or_h=first;if(r_or_tau)*r_or_tau=second;return 0;
fail_work:free(fac);free(tau);free(qwork);
fail:ln_array_free(first);ln_array_free(second);return -1;
}

/* ------------------------------------------------------------------------- */
/* Eigenvalue/SVD tranche.  The numerical split follows NumPy main's
 * numpy/linalg/umath_linalg.cpp: real general eig uses DGEEV and translates
 * LAPACK's real conjugate-pair representation to complex outputs; Hermitian
 * eig uses DSYEVD/ZHEEVD; SVD uses DGESDD/ZGESDD.  The CPython gufunc layer is
 * intentionally replaced by this host-neutral ndarray/stride boundary. */

static const ln_dtype *
real_result_type(const common_type *ct)
{
    return ln_dtype_by_num((ct->result->type_num == LN_FLOAT ||
                            ct->result->type_num == LN_CFLOAT) ? LN_FLOAT : LN_DOUBLE);
}

static const ln_dtype *
complex_result_type(const common_type *ct)
{
    return ln_dtype_by_num((ct->result->type_num == LN_FLOAT ||
                            ct->result->type_num == LN_CFLOAT) ? LN_CFLOAT : LN_CDOUBLE);
}

static int
packed_all_finite(const void *p, size_t n, int complex_mode)
{
    if (complex_mode) {
        const ln_cdouble *z=(const ln_cdouble*)p;
        for(size_t i=0;i<n;i++) if(!isfinite(z[i].real)||!isfinite(z[i].imag)) return 0;
    }
    else {
        const double *x=(const double*)p;
        for(size_t i=0;i<n;i++) if(!isfinite(x[i])) return 0;
    }
    return 1;
}

static int
workspace_from_double(double q, int *out, ln_error *err)
{
    if(!isfinite(q) || q < 1.0 || q > (double)INT_MAX){seterr(err,"LAPACK returned an invalid workspace size");return -1;}
    *out=(int)q; if(*out<1)*out=1; return 0;
}

static int
store_real_value(double x, const ln_dtype *srcdt, ln_array *dst, char *dp, ln_error *err)
{
    return ln_cast_strided_numeric((const char*)&x,0,srcdt,dp,0,dst->descr,1,err);
}

static int
store_complex_value(ln_cdouble z, ln_array *dst, char *dp, ln_error *err)
{
    const ln_dtype *srcdt=ln_dtype_by_num(LN_CDOUBLE);
    return ln_cast_strided_numeric((const char*)&z,0,srcdt,dp,0,dst->descr,1,err);
}

static int
lapack_geev(int n, int complex_mode, int want_vectors, void *a,
            ln_cdouble *wout, ln_cdouble *vout, ln_error *err)
{
    int lda=n>0?n:1, ldvl=1, ldvr=want_vectors?lda:1, info=0, lwork=-1;
    char jobvl='N', jobvr=want_vectors?'V':'N';
    if(complex_mode){
        ln_cdouble query={0,0}, dummy={0,0};
        double *rwork=(double*)malloc((size_t)(2*(n>0?n:1))*sizeof(double));
        if(!rwork){seterr(err,"out of memory");return -1;}
        zgeev_(&jobvl,&jobvr,&n,(ln_cdouble*)a,&lda,wout,&dummy,&ldvl,
               want_vectors?vout:&dummy,&ldvr,&query,&lwork,rwork,&info);
        if(info!=0){free(rwork);seterr(err,"LAPACK GEEV workspace query failed");return -1;}
        if(workspace_from_double(query.real,&lwork,err)<0){free(rwork);return -1;}
        ln_cdouble *work=(ln_cdouble*)malloc((size_t)lwork*sizeof(*work));
        if(!work){free(rwork);seterr(err,"out of memory");return -1;}
        zgeev_(&jobvl,&jobvr,&n,(ln_cdouble*)a,&lda,wout,&dummy,&ldvl,
               want_vectors?vout:&dummy,&ldvr,work,&lwork,rwork,&info);
        free(work);free(rwork);
    }
    else {
        double query=0.0,dummy=0.0;
        double *wr=(double*)malloc((size_t)(n>0?n:1)*sizeof(double));
        double *wi=(double*)malloc((size_t)(n>0?n:1)*sizeof(double));
        double *vr=want_vectors?(double*)malloc((size_t)(n>0?n:1)*(size_t)(n>0?n:1)*sizeof(double)):NULL;
        if(!wr||!wi||(want_vectors&&!vr)){free(wr);free(wi);free(vr);seterr(err,"out of memory");return -1;}
        dgeev_(&jobvl,&jobvr,&n,(double*)a,&lda,wr,wi,&dummy,&ldvl,
               want_vectors?vr:&dummy,&ldvr,&query,&lwork,&info);
        if(info!=0){free(wr);free(wi);free(vr);seterr(err,"LAPACK GEEV workspace query failed");return -1;}
        if(workspace_from_double(query,&lwork,err)<0){free(wr);free(wi);free(vr);return -1;}
        double *work=(double*)malloc((size_t)lwork*sizeof(double));
        if(!work){free(wr);free(wi);free(vr);seterr(err,"out of memory");return -1;}
        dgeev_(&jobvl,&jobvr,&n,(double*)a,&lda,wr,wi,&dummy,&ldvl,
               want_vectors?vr:&dummy,&ldvr,work,&lwork,&info);
        free(work);
        if(info==0){
            for(int j=0;j<n;j++){wout[j].real=wr[j];wout[j].imag=wi[j];}
            if(want_vectors){
                for(int j=0;j<n;){
                    if(wi[j]==0.0){
                        for(int i=0;i<n;i++){vout[(size_t)j*n+i].real=vr[(size_t)j*n+i];vout[(size_t)j*n+i].imag=0.0;}
                        j++;
                    }
                    else if(wi[j]>0.0 && j+1<n){
                        for(int i=0;i<n;i++){
                            double re=vr[(size_t)j*n+i], im=vr[(size_t)(j+1)*n+i];
                            vout[(size_t)j*n+i]=(ln_cdouble){re,im};
                            vout[(size_t)(j+1)*n+i]=(ln_cdouble){re,-im};
                        }
                        j+=2;
                    }
                    else {
                        /* Defensive fallback for an unexpected LAPACK ordering. */
                        for(int i=0;i<n;i++){vout[(size_t)j*n+i].real=vr[(size_t)j*n+i];vout[(size_t)j*n+i].imag=0.0;}
                        j++;
                    }
                }
            }
        }
        free(wr);free(wi);free(vr);
    }
    if(info>0){seterr(err,"Eigenvalues did not converge");return -1;}
    if(info<0){seterr(err,"LAPACK GEEV received an illegal argument");return -1;}
    return 0;
}

static int
linalg_eig_impl(const ln_array *a, int want_vectors,
                ln_array **w_out, ln_array **v_out, ln_error *err)
{
    if(w_out) *w_out=NULL;
    if(v_out) *v_out=NULL;
    if(check_square(a,err)<0)return -1;
    const ln_array *arrs[1]={a};common_type ct;if(common_type_for(arrs,1,&ct,err)<0)return -1;
    const ln_dtype *cdt=complex_result_type(&ct);
    int od=a->nd-2;ln_intp n=a->dimensions[a->nd-1],dimsw[LN_MAXDIMS],dimsv[LN_MAXDIMS];
    for(int i=0;i<od;i++){dimsw[i]=a->dimensions[i];dimsv[i]=a->dimensions[i];}
    dimsw[od]=n;dimsv[od]=n;dimsv[od+1]=n;
    ln_array *w=ln_array_new(od+1,dimsw,cdt,0,0,err);if(!w)return -1;
    ln_array *v=want_vectors?ln_array_new(od+2,dimsv,cdt,0,0,err):NULL;
    if(want_vectors&&!v){ln_array_free(w);return -1;}
    ln_intp batches=shape_product(od,a->dimensions,err);if(batches<0)goto fail;
    if(batches==0||n==0){if(w_out)*w_out=w;if(v_out)*v_out=v;return 0;}
    int ni;if(lapack_dim(n,&ni,err)<0)goto fail;
    size_t abytes,wbytes,vbytes;
    if(checked_count(n,n,ct.compute->elsize,&abytes,err)<0||
       checked_count(n,1,sizeof(ln_cdouble),&wbytes,err)<0||
       checked_count(n,n,sizeof(ln_cdouble),&vbytes,err)<0)goto fail;
    void *aw=malloc(abytes?abytes:1);ln_cdouble *ww=(ln_cdouble*)malloc(wbytes?wbytes:1);
    ln_cdouble *vw=want_vectors?(ln_cdouble*)malloc(vbytes?vbytes:1):NULL;
    if(!aw||!ww||(want_vectors&&!vw)){free(aw);free(ww);free(vw);seterr(err,"out of memory");goto fail;}
    ln_intp idx[LN_MAXDIMS]={0};
    for(ln_intp b=0;b<batches;b++){
        const char *ap=batch_ptr_const(a,od,idx,od);
        if(pack_matrix(a,ap,n,n,ct.compute,aw,err)<0)goto fail_work;
        if(!packed_all_finite(aw,(size_t)n*(size_t)n,ct.complex)){seterr(err,"Array must not contain infs or NaNs");goto fail_work;}
        if(lapack_geev(ni,ct.complex,want_vectors,aw,ww,vw,err)<0)goto fail_work;
        char *wp=batch_ptr_out(w,idx,od);
        for(ln_intp j=0;j<n;j++)if(store_complex_value(ww[j],w,wp+j*w->strides[w->nd-1],err)<0)goto fail_work;
        if(want_vectors){
            char *vp=batch_ptr_out(v,idx,od);
            for(ln_intp i=0;i<n;i++)for(ln_intp j=0;j<n;j++){
                ln_cdouble z=vw[(size_t)j*(size_t)n+(size_t)i];
                char *dp=vp+i*v->strides[v->nd-2]+j*v->strides[v->nd-1];
                if(store_complex_value(z,v,dp,err)<0)goto fail_work;
            }
        }
        advance_index(od,a->dimensions,idx);
    }
    free(aw);free(ww);free(vw);if(w_out)*w_out=w;if(v_out)*v_out=v;return 0;
fail_work:free(aw);free(ww);free(vw);
fail:ln_array_free(w);ln_array_free(v);return -1;
}

ln_array *
ln_linalg_eigvals(const ln_array *a, ln_error *err)
{
    ln_array *w=NULL;if(linalg_eig_impl(a,0,&w,NULL,err)<0)return NULL;return w;
}

int
ln_linalg_eig(const ln_array *a, ln_array **w, ln_array **v, ln_error *err)
{
    return linalg_eig_impl(a,1,w,v,err);
}

static int
lapack_evd(int n, int complex_mode, int want_vectors, int upper,
           void *a, double *w, ln_error *err)
{
    int lda=n>0?n:1, info=0;char jobz=want_vectors?'V':'N',uplo=upper?'U':'L';
    if(complex_mode){
        int lwork=-1,lrwork=-1,liwork=-1,iq=0;ln_cdouble wq={0,0};double rwq=0.0;
        zheevd_(&jobz,&uplo,&n,(ln_cdouble*)a,&lda,w,&wq,&lwork,&rwq,&lrwork,&iq,&liwork,&info);
        if(info!=0){seterr(err,"LAPACK HEEVD workspace query failed");return -1;}
        if(workspace_from_double(wq.real,&lwork,err)<0||workspace_from_double(rwq,&lrwork,err)<0)return -1;
        liwork=iq;if(liwork<1)liwork=1;
        ln_cdouble *work=(ln_cdouble*)malloc((size_t)lwork*sizeof(*work));
        double *rwork=(double*)malloc((size_t)lrwork*sizeof(*rwork));
        int *iwork=(int*)malloc((size_t)liwork*sizeof(*iwork));
        if(!work||!rwork||!iwork){free(work);free(rwork);free(iwork);seterr(err,"out of memory");return -1;}
        zheevd_(&jobz,&uplo,&n,(ln_cdouble*)a,&lda,w,work,&lwork,rwork,&lrwork,iwork,&liwork,&info);
        free(work);free(rwork);free(iwork);
    }
    else {
        int lwork=-1,liwork=-1,iq=0;double q=0.0;
        dsyevd_(&jobz,&uplo,&n,(double*)a,&lda,w,&q,&lwork,&iq,&liwork,&info);
        if(info!=0){seterr(err,"LAPACK SYEVD workspace query failed");return -1;}
        if(workspace_from_double(q,&lwork,err)<0)return -1;
        liwork=iq;
        if(liwork<1)liwork=1;
        double *work=(double*)malloc((size_t)lwork*sizeof(*work));int*iwork=(int*)malloc((size_t)liwork*sizeof(*iwork));
        if(!work||!iwork){free(work);free(iwork);seterr(err,"out of memory");return -1;}
        dsyevd_(&jobz,&uplo,&n,(double*)a,&lda,w,work,&lwork,iwork,&liwork,&info);
        free(work);free(iwork);
    }
    if(info>0){seterr(err,"Eigenvalues did not converge");return -1;}
    if(info<0){seterr(err,"LAPACK EVD received an illegal argument");return -1;}
    return 0;
}

static int
linalg_eigh_impl(const ln_array *a, int upper, int want_vectors,
                 ln_array **w_out, ln_array **v_out, ln_error *err)
{
    if(w_out) *w_out=NULL;
    if(v_out) *v_out=NULL;
    if(check_square(a,err)<0)return -1;
    const ln_array *arrs[1]={a};common_type ct;if(common_type_for(arrs,1,&ct,err)<0)return -1;
    const ln_dtype *rdt=real_result_type(&ct);
    int od=a->nd-2;ln_intp n=a->dimensions[a->nd-1],dimsw[LN_MAXDIMS],dimsv[LN_MAXDIMS];
    for(int i=0;i<od;i++){dimsw[i]=a->dimensions[i];dimsv[i]=a->dimensions[i];}
    dimsw[od]=n;dimsv[od]=n;dimsv[od+1]=n;
    ln_array *w=ln_array_new(od+1,dimsw,rdt,0,0,err);if(!w)return -1;
    ln_array *v=want_vectors?ln_array_new(od+2,dimsv,ct.result,0,0,err):NULL;
    if(want_vectors&&!v){ln_array_free(w);return -1;}
    ln_intp batches=shape_product(od,a->dimensions,err);if(batches<0)goto fail;
    if(batches==0||n==0){if(w_out)*w_out=w;if(v_out)*v_out=v;return 0;}
    int ni;if(lapack_dim(n,&ni,err)<0)goto fail;size_t abytes,wbytes;
    if(checked_count(n,n,ct.compute->elsize,&abytes,err)<0||checked_count(n,1,sizeof(double),&wbytes,err)<0)goto fail;
    void *aw=malloc(abytes?abytes:1);double *ww=(double*)malloc(wbytes?wbytes:1);if(!aw||!ww){free(aw);free(ww);seterr(err,"out of memory");goto fail;}
    const ln_dtype *ddt=ln_dtype_by_num(LN_DOUBLE);ln_intp idx[LN_MAXDIMS]={0};
    for(ln_intp b=0;b<batches;b++){
        const char*ap=batch_ptr_const(a,od,idx,od);if(pack_matrix(a,ap,n,n,ct.compute,aw,err)<0)goto fail_work;
        if(lapack_evd(ni,ct.complex,want_vectors,upper,aw,ww,err)<0)goto fail_work;
        char *wp=batch_ptr_out(w,idx,od);for(ln_intp j=0;j<n;j++)if(store_real_value(ww[j],ddt,w,wp+j*w->strides[w->nd-1],err)<0)goto fail_work;
        if(want_vectors){char*vp=batch_ptr_out(v,idx,od);if(unpack_matrix(aw,ct.compute,n,n,v,vp,2,err)<0)goto fail_work;}
        advance_index(od,a->dimensions,idx);
    }
    free(aw);free(ww);if(w_out)*w_out=w;if(v_out)*v_out=v;return 0;
fail_work:free(aw);free(ww);
fail:ln_array_free(w);ln_array_free(v);return -1;
}

ln_array *
ln_linalg_eigvalsh(const ln_array *a, int upper, ln_error *err)
{
    ln_array *w=NULL;if(linalg_eigh_impl(a,upper,0,&w,NULL,err)<0)return NULL;return w;
}

int
ln_linalg_eigh(const ln_array *a, int upper, ln_array **w, ln_array **v, ln_error *err)
{
    return linalg_eigh_impl(a,upper,1,w,v,err);
}

static int
fill_identity_batches(ln_array *a, int outer_nd, ln_intp n, ln_error *err)
{
    if(!a||n==0)return 0;
    ln_intp total=ln_array_size(a);
    if(total<0){seterr(err,"array is too big");return -1;}
    memset(a->data,0,(size_t)total*a->descr->elsize);
    ln_intp batches=shape_product(outer_nd,a->dimensions,err);if(batches<0)return -1;
    ln_intp idx[LN_MAXDIMS]={0};
    for(ln_intp b=0;b<batches;b++){
        char*base=batch_ptr_out(a,idx,outer_nd);
        for(ln_intp i=0;i<n;i++){
            char*dp=base+i*a->strides[a->nd-2]+i*a->strides[a->nd-1];
            if(a->descr->kind=='c'){ln_cdouble one={1,0};if(store_complex_value(one,a,dp,err)<0)return -1;}
            else {double one=1.0;if(store_real_value(one,ln_dtype_by_num(LN_DOUBLE),a,dp,err)<0)return -1;}
        }
        advance_index(outer_nd,a->dimensions,idx);
    }
    return 0;
}

static int
lapack_gesdd(int m,int n,int complex_mode,char jobz,void*a,double*s,void*u,void*vt,ln_error*err)
{
    int lda=m>0?m:1,k=m<n?m:n,ldu=m>0?m:1,vrows=(jobz=='A'?n:(jobz=='S'?k:0)),ldvt=vrows>0?vrows:1;
    int info=0,lwork=-1;int *iwork=(int*)malloc((size_t)(8*(k>0?k:1))*sizeof(int));if(!iwork){seterr(err,"out of memory");return -1;}
    if(complex_mode){
        ln_cdouble query={0,0};size_t rc=(jobz=='N'?(size_t)7*k:(size_t)5*k*k+(size_t)5*k);if(rc<1)rc=1;
        /* NumPy main allocates rwork_count*sizeof(complex), i.e. twice this many doubles. */
        double *rwork=(double*)malloc(2*rc*sizeof(double));if(!rwork){free(iwork);seterr(err,"out of memory");return -1;}
        zgesdd_(&jobz,&m,&n,(ln_cdouble*)a,&lda,s,(ln_cdouble*)u,&ldu,(ln_cdouble*)vt,&ldvt,&query,&lwork,rwork,iwork,&info);
        if(info!=0){free(rwork);free(iwork);seterr(err,"LAPACK GESDD workspace query failed");return -1;}
        if(workspace_from_double(query.real,&lwork,err)<0){free(rwork);free(iwork);return -1;}
        ln_cdouble*work=(ln_cdouble*)malloc((size_t)lwork*sizeof(*work));if(!work){free(rwork);free(iwork);seterr(err,"out of memory");return -1;}
        zgesdd_(&jobz,&m,&n,(ln_cdouble*)a,&lda,s,(ln_cdouble*)u,&ldu,(ln_cdouble*)vt,&ldvt,work,&lwork,rwork,iwork,&info);
        free(work);free(rwork);
    }
    else {
        double query=0.0;
        dgesdd_(&jobz,&m,&n,(double*)a,&lda,s,(double*)u,&ldu,(double*)vt,&ldvt,&query,&lwork,iwork,&info);
        if(info!=0){free(iwork);seterr(err,"LAPACK GESDD workspace query failed");return -1;}
        if(workspace_from_double(query,&lwork,err)<0){free(iwork);return -1;}
        double*work=(double*)malloc((size_t)lwork*sizeof(*work));if(!work){free(iwork);seterr(err,"out of memory");return -1;}
        dgesdd_(&jobz,&m,&n,(double*)a,&lda,s,(double*)u,&ldu,(double*)vt,&ldvt,work,&lwork,iwork,&info);free(work);
    }
    free(iwork);
    if(info>0){seterr(err,"SVD did not converge");return -1;}
    if(info<0){seterr(err,"LAPACK GESDD received an illegal argument");return -1;}
    return 0;
}

static int
read_real_at(const ln_array *a,const char*p,double*out,ln_error*err)
{
    return ln_cast_strided_numeric(p,0,a->descr,(char*)out,0,ln_dtype_by_num(LN_DOUBLE),1,err);
}

static int
read_complex_at(const ln_array *a,const char*p,ln_cdouble*out,ln_error*err)
{
    return ln_cast_strided_numeric(p,0,a->descr,(char*)out,0,ln_dtype_by_num(LN_CDOUBLE),1,err);
}

static int
svd_hermitian(const ln_array *a,int compute_uv,ln_array **u_out,ln_array **s_out,ln_array **vh_out,ln_error*err)
{
    if(u_out) *u_out=NULL;
    if(s_out) *s_out=NULL;
    if(vh_out) *vh_out=NULL;
    if(!compute_uv){
        ln_array*w=ln_linalg_eigvalsh(a,0,err);if(!w)return -1;
        int od=w->nd-1;ln_intp n=w->dimensions[w->nd-1],batches=shape_product(od,w->dimensions,err);if(batches<0){ln_array_free(w);return -1;}
        ln_array*s=ln_array_new(w->nd,w->dimensions,w->descr,0,0,err);if(!s){ln_array_free(w);return -1;}
        ln_intp idx[LN_MAXDIMS]={0};
        for(ln_intp b=0;b<batches;b++){
            const char*wp=batch_ptr_const(w,od,idx,od);char*sp=batch_ptr_out(s,idx,od);
            double *vals=(double*)malloc((size_t)(n?n:1)*sizeof(double));if(!vals){ln_array_free(w);ln_array_free(s);seterr(err,"out of memory");return -1;}
            for(ln_intp j=0;j<n;j++){if(read_real_at(w,wp+j*w->strides[w->nd-1],&vals[j],err)<0){free(vals);ln_array_free(w);ln_array_free(s);return -1;}vals[j]=fabs(vals[j]);}
            for(ln_intp i=0;i<n;i++){ln_intp best=i;for(ln_intp j=i+1;j<n;j++)if(vals[j]>vals[best])best=j;double t=vals[i];vals[i]=vals[best];vals[best]=t;}
            for(ln_intp j=0;j<n;j++)if(store_real_value(vals[j],ln_dtype_by_num(LN_DOUBLE),s,sp+j*s->strides[s->nd-1],err)<0){free(vals);ln_array_free(w);ln_array_free(s);return -1;}
            free(vals);advance_index(od,w->dimensions,idx);
        }
        ln_array_free(w);if(s_out)*s_out=s;return 0;
    }
    ln_array*w=NULL,*evec=NULL;if(ln_linalg_eigh(a,0,&w,&evec,err)<0)return -1;
    int od=a->nd-2;ln_intp n=a->dimensions[a->nd-1],batches=shape_product(od,a->dimensions,err);if(batches<0){ln_array_free(w);ln_array_free(evec);return -1;}
    ln_array*u=ln_array_new(evec->nd,evec->dimensions,evec->descr,0,0,err);
    ln_array*vh=u?ln_array_new(evec->nd,evec->dimensions,evec->descr,0,0,err):NULL;
    ln_array*s=vh?ln_array_new(w->nd,w->dimensions,w->descr,0,0,err):NULL;
    if(!u||!vh||!s){ln_array_free(w);ln_array_free(evec);ln_array_free(u);ln_array_free(vh);ln_array_free(s);return -1;}
    ln_intp idx[LN_MAXDIMS]={0};
    for(ln_intp b=0;b<batches;b++){
        const char*wp=batch_ptr_const(w,od,idx,od);const char*ep=batch_ptr_const(evec,od,idx,od);
        char*up=batch_ptr_out(u,idx,od);char*vhp=batch_ptr_out(vh,idx,od);char*sp=batch_ptr_out(s,idx,od);
        double*vals=(double*)malloc((size_t)(n?n:1)*sizeof(double));double*sgn=(double*)malloc((size_t)(n?n:1)*sizeof(double));ln_intp*ord=(ln_intp*)malloc((size_t)(n?n:1)*sizeof(ln_intp));
        if(!vals||!sgn||!ord){free(vals);free(sgn);free(ord);seterr(err,"out of memory");goto hfail;}
        for(ln_intp j=0;j<n;j++){double x;if(read_real_at(w,wp+j*w->strides[w->nd-1],&x,err)<0){free(vals);free(sgn);free(ord);goto hfail;}vals[j]=fabs(x);sgn[j]=copysign(1.0,x);ord[j]=j;}
        for(ln_intp i=0;i<n;i++){ln_intp best=i;for(ln_intp j=i+1;j<n;j++)if(vals[ord[j]]>vals[ord[best]])best=j;ln_intp t=ord[i];ord[i]=ord[best];ord[best]=t;}
        for(ln_intp dj=0;dj<n;dj++){
            ln_intp sj=ord[dj];double sval=vals[sj],sign=sgn[sj];
            if(store_real_value(sval,ln_dtype_by_num(LN_DOUBLE),s,sp+dj*s->strides[s->nd-1],err)<0){free(vals);free(sgn);free(ord);goto hfail;}
            for(ln_intp i=0;i<n;i++){
                const char*src=ep+i*evec->strides[evec->nd-2]+sj*evec->strides[evec->nd-1];
                char*udp=up+i*u->strides[u->nd-2]+dj*u->strides[u->nd-1];
                char*vdp=vhp+dj*vh->strides[vh->nd-2]+i*vh->strides[vh->nd-1];
                if(evec->descr->kind=='c'){
                    ln_cdouble z;if(read_complex_at(evec,src,&z,err)<0){free(vals);free(sgn);free(ord);goto hfail;}
                    if(store_complex_value(z,u,udp,err)<0){free(vals);free(sgn);free(ord);goto hfail;}
                    z.real*=sign;z.imag=-z.imag*sign;if(store_complex_value(z,vh,vdp,err)<0){free(vals);free(sgn);free(ord);goto hfail;}
                }else{
                    double x;if(read_real_at(evec,src,&x,err)<0){free(vals);free(sgn);free(ord);goto hfail;}
                    if(store_real_value(x,ln_dtype_by_num(LN_DOUBLE),u,udp,err)<0||store_real_value(sign*x,ln_dtype_by_num(LN_DOUBLE),vh,vdp,err)<0){free(vals);free(sgn);free(ord);goto hfail;}
                }
            }
        }
        free(vals);free(sgn);free(ord);advance_index(od,a->dimensions,idx);
    }
    ln_array_free(w);ln_array_free(evec);if(u_out)*u_out=u;if(s_out)*s_out=s;if(vh_out)*vh_out=vh;return 0;
hfail:ln_array_free(w);ln_array_free(evec);ln_array_free(u);ln_array_free(vh);ln_array_free(s);return -1;
}

int
ln_linalg_svd(const ln_array *a, int full_matrices, int compute_uv, int hermitian,
              ln_array **u_out, ln_array **s_out, ln_array **vh_out, ln_error *err)
{
    if(u_out) *u_out=NULL;
    if(s_out) *s_out=NULL;
    if(vh_out) *vh_out=NULL;
    if(hermitian)return svd_hermitian(a,compute_uv,u_out,s_out,vh_out,err);
    if(!a||a->nd<2){char msg[160];snprintf(msg,sizeof(msg),"%d-dimensional array given. Array must be at least two-dimensional",a?a->nd:0);seterr(err,msg);return -1;}
    const ln_array*arrs[1]={a};common_type ct;if(common_type_for(arrs,1,&ct,err)<0)return -1;const ln_dtype*rdt=real_result_type(&ct);
    int od=a->nd-2;ln_intp m=a->dimensions[a->nd-2],n=a->dimensions[a->nd-1],k=m<n?m:n;
    ln_intp sd[LN_MAXDIMS],ud[LN_MAXDIMS],vd[LN_MAXDIMS];for(int i=0;i<od;i++){sd[i]=ud[i]=vd[i]=a->dimensions[i];}
    sd[od]=k;ln_intp ucols=full_matrices?m:k,vrows=full_matrices?n:k;ud[od]=m;ud[od+1]=ucols;vd[od]=vrows;vd[od+1]=n;
    ln_array*s=ln_array_new(od+1,sd,rdt,0,0,err);if(!s)return -1;ln_array*u=NULL,*vh=NULL;
    if(compute_uv){u=ln_array_new(od+2,ud,ct.result,0,0,err);if(u)vh=ln_array_new(od+2,vd,ct.result,0,0,err);if(!u||!vh){ln_array_free(s);ln_array_free(u);ln_array_free(vh);return -1;}}
    ln_intp batches=shape_product(od,a->dimensions,err);if(batches<0)goto fail;
    if(batches==0){if(u_out)*u_out=u;if(s_out)*s_out=s;if(vh_out)*vh_out=vh;return 0;}
    if(k==0){if(compute_uv&&full_matrices){if(fill_identity_batches(u,od,m,err)<0||fill_identity_batches(vh,od,n,err)<0)goto fail;}if(u_out)*u_out=u;if(s_out)*s_out=s;if(vh_out)*vh_out=vh;return 0;}
    int mi,ni;if(lapack_dim(m,&mi,err)<0||lapack_dim(n,&ni,err)<0)goto fail;size_t abytes,sbytes,ubytes,vbytes;
    if(checked_count(m,n,ct.compute->elsize,&abytes,err)<0||checked_count(k,1,sizeof(double),&sbytes,err)<0||
       checked_count(m,ucols,ct.compute->elsize,&ubytes,err)<0||checked_count(vrows,n,ct.compute->elsize,&vbytes,err)<0)goto fail;
    void*aw=malloc(abytes?abytes:1);double*sw=(double*)malloc(sbytes?sbytes:1);void*uw=compute_uv?malloc(ubytes?ubytes:1):malloc(1);void*vw=compute_uv?malloc(vbytes?vbytes:1):malloc(1);
    if(!aw||!sw||!uw||!vw){free(aw);free(sw);free(uw);free(vw);seterr(err,"out of memory");goto fail;}
    char jobz=compute_uv?(full_matrices?'A':'S'):'N';const ln_dtype*ddt=ln_dtype_by_num(LN_DOUBLE);ln_intp idx[LN_MAXDIMS]={0};
    for(ln_intp b=0;b<batches;b++){
        const char*ap=batch_ptr_const(a,od,idx,od);if(pack_matrix(a,ap,m,n,ct.compute,aw,err)<0)goto fail_work;
        if(!packed_all_finite(aw,(size_t)m*(size_t)n,ct.complex)){seterr(err,"SVD did not converge");goto fail_work;}
        if(lapack_gesdd(mi,ni,ct.complex,jobz,aw,sw,uw,vw,err)<0)goto fail_work;
        char*sp=batch_ptr_out(s,idx,od);for(ln_intp j=0;j<k;j++)if(store_real_value(sw[j],ddt,s,sp+j*s->strides[s->nd-1],err)<0)goto fail_work;
        if(compute_uv){char*up=batch_ptr_out(u,idx,od);char*vp=batch_ptr_out(vh,idx,od);if(unpack_matrix(uw,ct.compute,m,ucols,u,up,2,err)<0||unpack_matrix(vw,ct.compute,vrows,n,vh,vp,2,err)<0)goto fail_work;}
        advance_index(od,a->dimensions,idx);
    }
    free(aw);free(sw);free(uw);free(vw);if(u_out)*u_out=u;if(s_out)*s_out=s;if(vh_out)*vh_out=vh;return 0;
fail_work:free(aw);free(sw);free(uw);free(vw);
fail:ln_array_free(u);ln_array_free(s);ln_array_free(vh);return -1;
}

ln_array *
ln_linalg_svdvals(const ln_array *a, ln_error *err)
{
    ln_array*s=NULL;if(ln_linalg_svd(a,0,0,0,NULL,&s,NULL,err)<0)return NULL;return s;
}


static int
lapack_gelsd(int m, int n, int nrhs, int complex_mode,
             void *a, void *b, double *sv, double rcond, int *rank,
             ln_error *err)
{
    int lda = m > 0 ? m : 1;
    int ldb = (m > n ? m : n); if (ldb < 1) ldb = 1;
    int info = 0, lwork = -1, iquery = 0;
    if (complex_mode) {
        ln_cdouble wq = {0,0}; double rwq = 0.0;
        zgelsd_(&m,&n,&nrhs,(ln_cdouble*)a,&lda,(ln_cdouble*)b,&ldb,sv,&rcond,rank,
                &wq,&lwork,&rwq,&iquery,&info);
        if (info != 0) { seterr(err,"LAPACK GELSD workspace query failed"); return -1; }
        if (workspace_from_double(wq.real,&lwork,err)<0) return -1;
        int lrwork=(int)rwq; if(lrwork<1)lrwork=1;
        int liwork=iquery; if(liwork<1)liwork=1;
        ln_cdouble *work=(ln_cdouble*)malloc((size_t)lwork*sizeof(*work));
        double *rwork=(double*)malloc((size_t)lrwork*sizeof(*rwork));
        int *iwork=(int*)malloc((size_t)liwork*sizeof(*iwork));
        if(!work||!rwork||!iwork){free(work);free(rwork);free(iwork);seterr(err,"out of memory");return -1;}
        zgelsd_(&m,&n,&nrhs,(ln_cdouble*)a,&lda,(ln_cdouble*)b,&ldb,sv,&rcond,rank,
                work,&lwork,rwork,iwork,&info);
        free(work);free(rwork);free(iwork);
    } else {
        double wq=0.0;
        dgelsd_(&m,&n,&nrhs,(double*)a,&lda,(double*)b,&ldb,sv,&rcond,rank,
                &wq,&lwork,&iquery,&info);
        if(info!=0){seterr(err,"LAPACK GELSD workspace query failed");return -1;}
        if(workspace_from_double(wq,&lwork,err)<0)return -1;
        int liwork=iquery;if(liwork<1)liwork=1;
        double *work=(double*)malloc((size_t)lwork*sizeof(*work));
        int *iwork=(int*)malloc((size_t)liwork*sizeof(*iwork));
        if(!work||!iwork){free(work);free(iwork);seterr(err,"out of memory");return -1;}
        dgelsd_(&m,&n,&nrhs,(double*)a,&lda,(double*)b,&ldb,sv,&rcond,rank,
                work,&lwork,iwork,&info);
        free(work);free(iwork);
    }
    if(info>0){seterr(err,"SVD did not converge in Linear Least Squares");return -1;}
    if(info<0){seterr(err,"LAPACK GELSD received an illegal argument");return -1;}
    return 0;
}

int
ln_linalg_lstsq(const ln_array *a, const ln_array *b, double rcond,
                 int rcond_is_default, ln_array **x_out, ln_array **res_out,
                 ln_intp *rank_out, ln_array **s_out, ln_error *err)
{
    if (x_out) *x_out=NULL;
    if (res_out) *res_out=NULL;
    if (s_out) *s_out=NULL;
    if (rank_out) *rank_out=0;
    if(!a||!b||a->nd!=2||(b->nd!=1&&b->nd!=2)){
        seterr(err,"lstsq requires a 2-D coefficient matrix and a 1-D or 2-D right-hand side");return -1;
    }
    ln_intp m=a->dimensions[0],n=a->dimensions[1],m2=b->dimensions[0];
    if(m!=m2){seterr(err,"Incompatible dimensions");return -1;}
    ln_intp nrhs0=b->nd==1?1:b->dimensions[1];
    const ln_array *arrs[2]={a,b};common_type ct;if(common_type_for(arrs,2,&ct,err)<0)return -1;
    const ln_dtype *rdt=real_result_type(&ct);ln_intp k=m<n?m:n;
    ln_intp xd[2]={n,nrhs0},sd[1]={k};
    ln_array *x=ln_array_new(b->nd,b->nd==1?xd:xd,ct.result,0,1,err); /* fixed below for vector */
    if(b->nd==1){ln_array_free(x);ln_intp xv[1]={n};x=ln_array_new(1,xv,ct.result,0,1,err);}
    ln_array *sv=x?ln_array_new(1,sd,rdt,0,0,err):NULL;
    if(!x||!sv){ln_array_free(x);ln_array_free(sv);return -1;}
    int mi,ni,nri;if(lapack_dim(m,&mi,err)<0||lapack_dim(n,&ni,err)<0)goto fail;
    ln_intp nrhs_call=nrhs0==0?1:nrhs0;if(lapack_dim(nrhs_call,&nri,err)<0)goto fail;
    ln_intp ldbp=m>n?m:n;if(ldbp<1)ldbp=1;
    size_t abytes,bbytes,sbytes;
    if(checked_count(m,n,ct.compute->elsize,&abytes,err)<0||
       checked_count(ldbp,nrhs_call,ct.compute->elsize,&bbytes,err)<0||
       checked_count(k,1,sizeof(double),&sbytes,err)<0)goto fail;
    void *aw=calloc(1,abytes?abytes:1),*bw=calloc(1,bbytes?bbytes:1);double *sw=(double*)malloc(sbytes?sbytes:1);
    if(!aw||!bw||!sw){free(aw);free(bw);free(sw);seterr(err,"out of memory");goto fail;}
    if(pack_matrix(a,a->data,m,n,ct.compute,aw,err)<0)goto fail_work;
    if(!packed_all_finite(aw,(size_t)m*(size_t)n,ct.complex)){seterr(err,"SVD did not converge in Linear Least Squares");goto fail_work;}
    size_t es=ct.compute->elsize;
    if(nrhs0>0){
        if(b->nd==1){for(ln_intp i=0;i<m;i++)if(ln_cast_strided_numeric(b->data+i*b->strides[0],0,b->descr,(char*)bw+(size_t)i*es,0,ct.compute,1,err)<0)goto fail_work;}
        else for(ln_intp j=0;j<nrhs0;j++)for(ln_intp i=0;i<m;i++)
            if(ln_cast_strided_numeric(b->data+i*b->strides[0]+j*b->strides[1],0,b->descr,(char*)bw+((size_t)j*(size_t)ldbp+(size_t)i)*es,0,ct.compute,1,err)<0)goto fail_work;
    }
    if(rcond_is_default)rcond=DBL_EPSILON*(double)(m>n?m:n);
    int rank=0;if(lapack_gelsd(mi,ni,nri,ct.complex,aw,bw,sw,rcond,&rank,err)<0)goto fail_work;
    if(m==0)memset(x->data,0,(size_t)ln_array_size(x)*x->descr->elsize);
    else if(nrhs0>0){
        if(b->nd==1){for(ln_intp i=0;i<n;i++)if(ln_cast_strided_numeric((char*)bw+(size_t)i*es,0,ct.compute,x->data+i*x->strides[0],0,x->descr,1,err)<0)goto fail_work;}
        else for(ln_intp j=0;j<nrhs0;j++)for(ln_intp i=0;i<n;i++)
            if(ln_cast_strided_numeric((char*)bw+((size_t)j*(size_t)ldbp+(size_t)i)*es,0,ct.compute,x->data+i*x->strides[0]+j*x->strides[1],0,x->descr,1,err)<0)goto fail_work;
    }
    for(ln_intp i=0;i<k;i++)if(store_real_value(sw[i],ln_dtype_by_num(LN_DOUBLE),sv,sv->data+i*sv->strides[0],err)<0)goto fail_work;
    ln_array *res=NULL;
    if(rank==ni&&m>n){ln_intp rd[1]={nrhs0};res=ln_array_new(1,rd,rdt,0,1,err);if(!res)goto fail_work;
        if(nrhs0>0){for(ln_intp j=0;j<nrhs0;j++){double rr=0.0;for(ln_intp i=n;i<m;i++){
            if(ct.complex){ln_cdouble z=((ln_cdouble*)bw)[(size_t)j*(size_t)ldbp+(size_t)i];rr+=z.real*z.real+z.imag*z.imag;}
            else {double z=((double*)bw)[(size_t)j*(size_t)ldbp+(size_t)i];rr+=z*z;}}
            if(store_real_value(rr,ln_dtype_by_num(LN_DOUBLE),res,res->data+j*res->strides[0],err)<0){ln_array_free(res);goto fail_work;}}}
    }else{ln_intp z[1]={0};res=ln_array_new(1,z,rdt,0,0,err);if(!res)goto fail_work;}
    free(aw);free(bw);free(sw);if(x_out)*x_out=x;if(res_out)*res_out=res;if(rank_out)*rank_out=rank;if(s_out)*s_out=sv;return 0;
fail_work:free(aw);free(bw);free(sw);
fail:ln_array_free(x);ln_array_free(sv);return -1;
}

static int
broadcast_batch_and_tolerance(int batch_nd, const ln_intp *batch_shape,
                              const ln_array *tol, int *out_nd,
                              ln_intp *out_shape, ln_error *err)
{
    int nd = batch_nd;
    if (tol && tol->nd > nd) nd = tol->nd;
    if (nd > LN_MAXDIMS) {
        seterr(err, "maximum supported dimension for an ndarray is 64");
        return -1;
    }
    for (int i = 0; i < nd; i++) {
        ln_intp ad = 1, td = 1;
        int ai = i + batch_nd - nd;
        int ti = tol ? i + tol->nd - nd : -1;
        if (ai >= 0) ad = batch_shape[ai];
        if (tol && ti >= 0) td = tol->dimensions[ti];
        if (ad != 1 && td != 1 && ad != td) {
            seterr(err, "operands could not be broadcast together for linalg tolerance");
            return -1;
        }
        out_shape[i] = ad == 1 ? td : ad;
    }
    *out_nd = nd;
    return 0;
}

static int
read_broadcast_scalar(const ln_array *a, const ln_intp *out_idx, int out_nd,
                      double *out, ln_error *err)
{
    const char *p = batch_ptr_const(a, a->nd, out_idx, out_nd);
    return read_real_at(a, p, out, err);
}

ln_array *
ln_linalg_pinv(const ln_array *a, double rcond, const ln_array *rcond_array,
                int hermitian, ln_error *err)
{
    if(!a||a->nd<2){seterr(err,"pinv requires an array of at least two dimensions");return NULL;}
    const ln_array *arrs[1]={a};common_type ct;if(common_type_for(arrs,1,&ct,err)<0)return NULL;
    int od=a->nd-2;ln_intp m=a->dimensions[a->nd-2],n=a->dimensions[a->nd-1],k=m<n?m:n;
    ln_intp rdims[LN_MAXDIMS];for(int i=0;i<od;i++)rdims[i]=a->dimensions[i];rdims[od]=n;rdims[od+1]=m;
    ln_array *res=ln_array_new(od+2,rdims,ct.result,0,0,err);if(!res)return NULL;
    if(m==0||n==0)return res;
    if (rcond_array) {
        ln_intp bs[LN_MAXDIMS];
        if (ln_broadcast_strides(od, a->dimensions, rcond_array->nd,
                                 rcond_array->dimensions, rcond_array->strides,
                                 "rcond", bs, err) < 0) {
            ln_array_free(res);
            return NULL;
        }
    }
    ln_array *u=NULL,*sv=NULL,*vh=NULL;
    if(ln_linalg_svd(a,0,1,hermitian,&u,&sv,&vh,err)<0){ln_array_free(res);return NULL;}
    ln_intp batches=shape_product(od,a->dimensions,err);if(batches<0){ln_array_free(res);ln_array_free(u);ln_array_free(sv);ln_array_free(vh);return NULL;}
    ln_intp idx[LN_MAXDIMS]={0};
    for(ln_intp b=0;b<batches;b++){
        const char *up=batch_ptr_const(u,od,idx,od),*sp=batch_ptr_const(sv,od,idx,od),*vp=batch_ptr_const(vh,od,idx,od);
        char *rp=batch_ptr_out(res,idx,od);double smax=0.0;
        for(ln_intp q=0;q<k;q++){double x;if(read_real_at(sv,sp+q*sv->strides[sv->nd-1],&x,err)<0)goto pfail;if(x>smax)smax=x;}
        double batch_rcond = rcond;
        if (rcond_array && read_broadcast_scalar(rcond_array, idx, od, &batch_rcond, err) < 0) goto pfail;
        double cutoff=batch_rcond*smax;
        for(ln_intp i=0;i<n;i++)for(ln_intp j=0;j<m;j++){
            ln_cdouble acc={0,0};
            for(ln_intp q=0;q<k;q++){
                double sval;if(read_real_at(sv,sp+q*sv->strides[sv->nd-1],&sval,err)<0)goto pfail;
                if(!(sval>cutoff))continue;
                if(ct.result->kind=='c'){
                    ln_cdouble vhqi,ujq;
                    if(read_complex_at(vh,vp+q*vh->strides[vh->nd-2]+i*vh->strides[vh->nd-1],&vhqi,err)<0||
                       read_complex_at(u,up+j*u->strides[u->nd-2]+q*u->strides[u->nd-1],&ujq,err)<0)goto pfail;
                    /* V[i,q] * conj(U[j,q]) == conj(Vh[q,i]) * conj(U[j,q]). */
                    ln_cdouble v={vhqi.real,-vhqi.imag},uc={ujq.real,-ujq.imag};
                    double inv=1.0/sval;
                    acc.real += (v.real*uc.real-v.imag*uc.imag)*inv;
                    acc.imag += (v.real*uc.imag+v.imag*uc.real)*inv;
                }else{
                    double v,uval;if(read_real_at(vh,vp+q*vh->strides[vh->nd-2]+i*vh->strides[vh->nd-1],&v,err)<0||
                        read_real_at(u,up+j*u->strides[u->nd-2]+q*u->strides[u->nd-1],&uval,err)<0)goto pfail;
                    acc.real += v*uval/sval;
                }
            }
            char *dp=rp+i*res->strides[res->nd-2]+j*res->strides[res->nd-1];
            if(ct.result->kind=='c'){if(store_complex_value(acc,res,dp,err)<0)goto pfail;}
            else if(store_real_value(acc.real,ln_dtype_by_num(LN_DOUBLE),res,dp,err)<0)goto pfail;
        }
        advance_index(od,a->dimensions,idx);
    }
    ln_array_free(u);ln_array_free(sv);ln_array_free(vh);return res;
pfail:
    ln_array_free(res);ln_array_free(u);ln_array_free(sv);ln_array_free(vh);return NULL;
}

int
ln_linalg_matrix_rank(const ln_array *a, int hermitian,
                      int has_tol, double tol, const ln_array *tol_array,
                      int has_rtol, double rtol, const ln_array *rtol_array,
                      ln_array **rank_array, ln_intp *scalar_rank,
                      int *is_scalar, ln_error *err)
{
    if (rank_array) *rank_array=NULL;
    if (scalar_rank) *scalar_rank=0;
    if (is_scalar) *is_scalar=0;
    if(has_tol&&has_rtol){seterr(err,"`tol` and `rtol` can't be both set.");return -1;}
    if(!a){seterr(err,"invalid array");return -1;}
    if (a->nd < 2) {
        ln_intp total = ln_array_size(a);
        int nz = 0;
        ln_intp idx[LN_MAXDIMS] = {0};
        for (ln_intp i = 0; i < total; i++) {
            const char *p = a->data;
            for (int d = 0; d < a->nd; d++) {
                p += idx[d] * a->strides[d];
            }
            ln_cdouble z;
            if (read_complex_at(a, p, &z, err) < 0) {
                return -1;
            }
            if (z.real != 0.0 || z.imag != 0.0) {
                nz = 1;
                break;
            }
            advance_index(a->nd, a->dimensions, idx);
        }
        if (scalar_rank) {
            *scalar_rank = nz;
        }
        if (is_scalar) {
            *is_scalar = 1;
        }
        return 0;
    }
    ln_array *sv=NULL;if(ln_linalg_svd(a,0,0,hermitian,NULL,&sv,NULL,err)<0)return -1;
    int od=a->nd-2;ln_intp m=a->dimensions[a->nd-2],n=a->dimensions[a->nd-1],k=m<n?m:n;
    const ln_array *tol_src = has_tol ? tol_array : (has_rtol ? rtol_array : NULL);
    int out_nd = od;
    ln_intp out_shape[LN_MAXDIMS] = {0};
    for (int d=0; d<od; d++) out_shape[d]=a->dimensions[d];
    if (tol_src && broadcast_batch_and_tolerance(od,a->dimensions,tol_src,&out_nd,out_shape,err)<0){ln_array_free(sv);return -1;}
    const ln_dtype *idt=ln_dtype_by_name("int64");ln_array *out=ln_array_new(out_nd,out_shape,idt,0,0,err);if(!out){ln_array_free(sv);return -1;}
    double eps=sv->descr->type_num==LN_FLOAT?1.1920928955078125e-7:DBL_EPSILON;
    ln_intp batches=shape_product(out_nd,out_shape,err);if(batches<0){ln_array_free(sv);ln_array_free(out);return -1;}
    ln_intp idx[LN_MAXDIMS]={0};
    for(ln_intp b=0;b<batches;b++){
        const char *sp=batch_ptr_const(sv,od,idx,out_nd);double smax=0.0;
        for(ln_intp q=0;q<k;q++){double v;if(read_real_at(sv,sp+q*sv->strides[sv->nd-1],&v,err)<0)goto rfail;if(v>smax)smax=v;}
        double tv;
        if (has_tol) {
            tv=tol;
            if(tol_array&&read_broadcast_scalar(tol_array,idx,out_nd,&tv,err)<0)goto rfail;
        } else {
            tv=has_rtol?rtol:(double)(m>n?m:n)*eps;
            if(rtol_array&&read_broadcast_scalar(rtol_array,idx,out_nd,&tv,err)<0)goto rfail;
            tv*=smax;
        }
        double threshold=tv;ln_intp rank=0;
        for(ln_intp q=0;q<k;q++){double v;if(read_real_at(sv,sp+q*sv->strides[sv->nd-1],&v,err)<0)goto rfail;if(v>threshold)rank++;}
        char *dp=batch_ptr_out(out,idx,out_nd);if(store_real_value((double)rank,ln_dtype_by_num(LN_DOUBLE),out,dp,err)<0)goto rfail;
        advance_index(out_nd,out_shape,idx);
    }
    ln_array_free(sv);if(rank_array)*rank_array=out;return 0;
rfail:ln_array_free(sv);ln_array_free(out);return -1;
}

static const ln_dtype *
norm_result_dtype(const ln_array *a, ln_error *err)
{
    (void)err;
    switch(a->descr->type_num){
        case LN_FLOAT:return ln_dtype_by_num(LN_FLOAT);
        case LN_DOUBLE:return ln_dtype_by_num(LN_DOUBLE);
        case LN_CFLOAT:return ln_dtype_by_num(LN_FLOAT);
        case LN_CDOUBLE:return ln_dtype_by_num(LN_DOUBLE);
        case LN_HALF:return ln_dtype_by_num(LN_HALF);
        case LN_LONGDOUBLE:case LN_CLONGDOUBLE:return ln_dtype_by_num(LN_LONGDOUBLE);
        default:return ln_dtype_by_num(LN_DOUBLE);
    }
}

static int
normalize_axis_c(int axis,int nd,int *out,ln_error*err)
{
    if(axis<0)axis+=nd;
    if(axis<0||axis>=nd){seterr(err,"axis is out of bounds for array");return -1;}
    *out=axis;return 0;
}

static ln_array *
new_reduced_output(const ln_array*a,const int*axes,int naxes,int keepdims,const ln_dtype*dt,ln_error*err)
{
    uint8_t red[LN_MAXDIMS]={0};for(int i=0;i<naxes;i++)red[axes[i]]=1;
    ln_intp dims[LN_MAXDIMS];int od=0;
    if(keepdims){od=a->nd;for(int d=0;d<a->nd;d++)dims[d]=red[d]?1:a->dimensions[d];}
    else for(int d=0;d<a->nd;d++)if(!red[d])dims[od++]=a->dimensions[d];
    return ln_array_new(od,dims,dt,0,0,err);
}

static const char *
base_for_reduced_index(const ln_array*a,const int*axes,int naxes,int keepdims,const ln_intp*outidx)
{
    uint8_t red[LN_MAXDIMS]={0};for(int i=0;i<naxes;i++)red[axes[i]]=1;
    const char*p=a->data;int oi=0;
    for(int d=0;d<a->nd;d++){
        if(red[d]){if(keepdims)oi++;continue;}
        p+=outidx[oi++]*a->strides[d];
    }
    return p;
}

static int
store_output_real(ln_array*out,const ln_intp*idx,long double v,ln_error*err)
{
    char*p=out->data;for(int d=0;d<out->nd;d++)p+=idx[d]*out->strides[d];
    return ln_cast_strided_numeric((const char*)&v,0,ln_dtype_by_num(LN_LONGDOUBLE),
                                   p,0,out->descr,1,err);
}

static int
read_abs_ptr(const ln_array*a,const char*p,long double*out,ln_error*err)
{
    ln_clongdouble z;
    if(ln_cast_strided_numeric(p,0,a->descr,(char*)&z,0,
                               ln_dtype_by_num(LN_CLONGDOUBLE),1,err)<0)return -1;
    *out=hypotl(z.real,z.imag);
    return 0;
}

static ln_array *
norm_vector(const ln_array*a,int axis,ln_norm_kind kind,double ord,int keepdims,ln_error*err)
{
    const ln_dtype*dt=norm_result_dtype(a,err);if(!dt)return NULL;
    ln_array*out=new_reduced_output(a,&axis,1,keepdims,dt,err);if(!out)return NULL;
    ln_intp osz=ln_array_size(out);if(osz<0){ln_array_free(out);seterr(err,"array is too big");return NULL;}
    ln_intp oi[LN_MAXDIMS]={0},n=a->dimensions[axis];
    for(ln_intp z=0;z<osz;z++){
        const char*base=base_for_reduced_index(a,&axis,1,keepdims,oi);
        long double acc=0.0L,val=0.0L;
        if(kind==LN_NORM_NEGINF&&n==0){ln_array_free(out);seterr(err,"zero-size array to reduction operation minimum which has no identity");return NULL;}
        if(kind==LN_NORM_NEGINF)acc=INFINITY;
        for(ln_intp q=0;q<n;q++){
            long double av;if(read_abs_ptr(a,base+q*a->strides[axis],&av,err)<0){ln_array_free(out);return NULL;}
            switch(kind){
                case LN_NORM_POSINF: if(av>acc)acc=av;break;
                case LN_NORM_NEGINF: if(av<acc)acc=av;break;
                case LN_NORM_NUMBER:
                    if(ord==0.0){if(av!=0.0L)acc+=1.0L;}
                    else if(ord==1.0)acc+=av;
                    else if(ord==2.0)acc+=av*av;
                    else acc+=powl(av,(long double)ord);
                    break;
                case LN_NORM_DEFAULT:acc+=av*av;break;
                default:ln_array_free(out);seterr(err,"Invalid norm order for vectors");return NULL;
            }
        }
        if(kind==LN_NORM_DEFAULT||(kind==LN_NORM_NUMBER&&ord==2.0))val=sqrtl(acc);
        else if(kind==LN_NORM_NUMBER&&ord!=0.0&&ord!=1.0)val=powl(acc,1.0L/(long double)ord);
        else val=acc;
        if(store_output_real(out,oi,val,err)<0){ln_array_free(out);return NULL;}
        advance_index(out->nd,out->dimensions,oi);
    }
    return out;
}

static ln_array *
permuted_matrix_view(const ln_array*a,int row_axis,int col_axis,ln_error*err)
{
    ln_intp dims[LN_MAXDIMS],strides[LN_MAXDIMS];int q=0;
    for(int d=0;d<a->nd;d++)if(d!=row_axis&&d!=col_axis){dims[q]=a->dimensions[d];strides[q]=a->strides[d];q++;}
    dims[q]=a->dimensions[row_axis];strides[q]=a->strides[row_axis];q++;
    dims[q]=a->dimensions[col_axis];strides[q]=a->strides[col_axis];q++;
    return ln_array_view(a,q,dims,strides,a->data,err);
}

static ln_array *
norm_matrix_svd(const ln_array*a,int row_axis,int col_axis,ln_norm_kind kind,double ord,int keepdims,ln_error*err)
{
    ln_array*view=permuted_matrix_view(a,row_axis,col_axis,err);if(!view)return NULL;
    ln_array*sv=NULL;if(ln_linalg_svd(view,0,0,0,NULL,&sv,NULL,err)<0){ln_array_free(view);return NULL;}
    const ln_dtype*dt=norm_result_dtype(a,err);if(!dt){ln_array_free(view);ln_array_free(sv);return NULL;}
    int ax[2]={row_axis,col_axis};ln_array*out=new_reduced_output(a,ax,2,keepdims,dt,err);if(!out){ln_array_free(view);ln_array_free(sv);return NULL;}
    int bod=a->nd-2;ln_intp batches=shape_product(bod,view->dimensions,err);if(batches<0){ln_array_free(view);ln_array_free(sv);ln_array_free(out);return NULL;}
    ln_intp bi[LN_MAXDIMS]={0},oi[LN_MAXDIMS]={0},k=sv->dimensions[sv->nd-1];
    for(ln_intp b=0;b<batches;b++){
        const char*sp=batch_ptr_const(sv,bod,bi,bod);double v=0.0;
        if(kind==LN_NORM_NEGINF|| (kind==LN_NORM_NUMBER&&ord==-2.0))v=INFINITY;
        for(ln_intp j=0;j<k;j++){double x;if(read_real_at(sv,sp+j*sv->strides[sv->nd-1],&x,err)<0)goto msfail;
            if(kind==LN_NORM_NUC)v+=x;
            else if(kind==LN_NORM_POSINF||(kind==LN_NORM_NUMBER&&ord==2.0)){if(j==0||x>v)v=x;}
            else if(kind==LN_NORM_NEGINF||(kind==LN_NORM_NUMBER&&ord==-2.0)){if(x<v)v=x;}
        }
        /* Map batch index (non-reduced axes in original order) into output. */
        if(keepdims){int q=0;for(int d=0;d<a->nd;d++){if(d==row_axis||d==col_axis)oi[d]=0;else oi[d]=bi[q++];}}
        else for(int d=0;d<bod;d++)oi[d]=bi[d];
        if(store_output_real(out,oi,v,err)<0)goto msfail;
        advance_index(bod,view->dimensions,bi);
    }
    ln_array_free(view);ln_array_free(sv);return out;
msfail:ln_array_free(view);ln_array_free(sv);ln_array_free(out);return NULL;
}

static ln_array *
norm_matrix_direct(const ln_array*a,int row_axis,int col_axis,ln_norm_kind kind,double ord,int keepdims,ln_error*err)
{
    const ln_dtype*dt=norm_result_dtype(a,err);if(!dt)return NULL;int ax[2]={row_axis,col_axis};
    ln_array*out=new_reduced_output(a,ax,2,keepdims,dt,err);if(!out)return NULL;
    ln_intp osz=ln_array_size(out);if(osz<0){ln_array_free(out);seterr(err,"array is too big");return NULL;}
    ln_intp oi[LN_MAXDIMS]={0},m=a->dimensions[row_axis],n=a->dimensions[col_axis];
    for(ln_intp z=0;z<osz;z++){
        const char*base=base_for_reduced_index(a,ax,2,keepdims,oi);long double result=0.0L;
        if(kind==LN_NORM_FRO||kind==LN_NORM_DEFAULT){long double ss=0;for(ln_intp i=0;i<m;i++)for(ln_intp j=0;j<n;j++){long double av;if(read_abs_ptr(a,base+i*a->strides[row_axis]+j*a->strides[col_axis],&av,err)<0)goto mdfail;ss+=av*av;}result=sqrtl(ss);}
        else if(kind==LN_NORM_POSINF||kind==LN_NORM_NEGINF){
            if(m==0&&kind==LN_NORM_NEGINF){ln_array_free(out);seterr(err,"zero-size array to reduction operation minimum which has no identity");return NULL;}
            result=kind==LN_NORM_NEGINF?INFINITY:0.0L;
            for(ln_intp i=0;i<m;i++){long double sum=0;for(ln_intp j=0;j<n;j++){long double av;if(read_abs_ptr(a,base+i*a->strides[row_axis]+j*a->strides[col_axis],&av,err)<0)goto mdfail;sum+=av;}if(kind==LN_NORM_POSINF){if(sum>result)result=sum;}else if(sum<result)result=sum;}
        }else if(kind==LN_NORM_NUMBER&&(ord==1.0||ord==-1.0)){
            if(n==0&&ord<0){ln_array_free(out);seterr(err,"zero-size array to reduction operation minimum which has no identity");return NULL;}
            result=ord<0?INFINITY:0.0L;
            for(ln_intp j=0;j<n;j++){long double sum=0;for(ln_intp i=0;i<m;i++){long double av;if(read_abs_ptr(a,base+i*a->strides[row_axis]+j*a->strides[col_axis],&av,err)<0)goto mdfail;sum+=av;}if(ord>0){if(sum>result)result=sum;}else if(sum<result)result=sum;}
        }else{ln_array_free(out);seterr(err,"Invalid norm order for matrices.");return NULL;}
        if(store_output_real(out,oi,result,err)<0)goto mdfail;
        advance_index(out->nd,out->dimensions,oi);
    }
    return out;
mdfail:ln_array_free(out);return NULL;
}

ln_array *
ln_linalg_norm(const ln_array *a, ln_norm_kind kind, double ord,
               const int *axes, int naxes, int axis_is_none,
               int keepdims, ln_error *err)
{
    if(!a){seterr(err,"invalid array");return NULL;}
    if(axis_is_none&&kind==LN_NORM_DEFAULT){
        const ln_dtype*dt=norm_result_dtype(a,err);if(!dt)return NULL;ln_intp dims[LN_MAXDIMS];int od=keepdims?a->nd:0;
        if(keepdims)for(int d=0;d<a->nd;d++)dims[d]=1;
        ln_array*out=ln_array_new(od,dims,dt,0,0,err);if(!out)return NULL;
        ln_intp total=ln_array_size(a),idx[LN_MAXDIMS]={0};long double ss=0.0L;for(ln_intp i=0;i<total;i++){const char*p=a->data;for(int d=0;d<a->nd;d++)p+=idx[d]*a->strides[d];long double av;if(read_abs_ptr(a,p,&av,err)<0){ln_array_free(out);return NULL;}ss+=av*av;advance_index(a->nd,a->dimensions,idx);}
        ln_intp zi[LN_MAXDIMS]={0};if(store_output_real(out,zi,sqrtl(ss),err)<0){ln_array_free(out);return NULL;}return out;
    }
    int ax[2]={0,0};
    if(axis_is_none){if(a->nd==1){naxes=1;ax[0]=0;}else if(a->nd==2){naxes=2;ax[0]=0;ax[1]=1;}else{seterr(err,"Improper number of dimensions to norm.");return NULL;}}
    else {if(naxes<1||naxes>2){seterr(err,"Improper number of dimensions to norm.");return NULL;}for(int i=0;i<naxes;i++)if(normalize_axis_c(axes[i],a->nd,&ax[i],err)<0)return NULL;}
    if(naxes==1){if(kind==LN_NORM_FRO||kind==LN_NORM_NUC){seterr(err,"Invalid norm order for vectors");return NULL;}return norm_vector(a,ax[0],kind,ord,keepdims,err);}
    if(ax[0]==ax[1]){seterr(err,"Duplicate axes given.");return NULL;}
    if(kind==LN_NORM_NUC||(kind==LN_NORM_NUMBER&&(ord==2.0||ord==-2.0)))return norm_matrix_svd(a,ax[0],ax[1],kind,ord,keepdims,err);
    return norm_matrix_direct(a,ax[0],ax[1],kind,ord,keepdims,err);
}

static int
packed_has_nan_or_inf(const void *p,size_t n,int complex_mode,int *has_nan,int *has_inf)
{
    *has_nan=0;*has_inf=0;
    if(complex_mode){const ln_cdouble*z=(const ln_cdouble*)p;for(size_t i=0;i<n;i++){if(isnan(z[i].real)||isnan(z[i].imag))*has_nan=1;if(isinf(z[i].real)||isinf(z[i].imag))*has_inf=1;}}
    else {const double*x=(const double*)p;for(size_t i=0;i<n;i++){if(isnan(x[i]))*has_nan=1;if(isinf(x[i]))*has_inf=1;}}
    return 0;
}

static double
packed_matrix_norm(const void *p,int n,int complex_mode,ln_norm_kind kind,double ord)
{
    if(kind==LN_NORM_FRO||kind==LN_NORM_DEFAULT){double ss=0;for(int j=0;j<n;j++)for(int i=0;i<n;i++){double a;if(complex_mode){ln_cdouble z=((const ln_cdouble*)p)[(size_t)j*n+i];a=hypot(z.real,z.imag);}else a=fabs(((const double*)p)[(size_t)j*n+i]);ss+=a*a;}return sqrt(ss);}
    if(kind==LN_NORM_NUMBER&&(ord==1.0||ord==-1.0)){double best=ord<0?INFINITY:0;for(int j=0;j<n;j++){double s=0;for(int i=0;i<n;i++){if(complex_mode){ln_cdouble z=((const ln_cdouble*)p)[(size_t)j*n+i];s+=hypot(z.real,z.imag);}else s+=fabs(((const double*)p)[(size_t)j*n+i]);}if(ord>0){if(s>best)best=s;}else if(s<best)best=s;}return best;}
    if(kind==LN_NORM_POSINF||kind==LN_NORM_NEGINF){double best=kind==LN_NORM_NEGINF?INFINITY:0;for(int i=0;i<n;i++){double s=0;for(int j=0;j<n;j++){if(complex_mode){ln_cdouble z=((const ln_cdouble*)p)[(size_t)j*n+i];s+=hypot(z.real,z.imag);}else s+=fabs(((const double*)p)[(size_t)j*n+i]);}if(kind==LN_NORM_POSINF){if(s>best)best=s;}else if(s<best)best=s;}return best;}
    return NAN;
}

ln_array *
ln_linalg_cond(const ln_array *a, ln_norm_kind kind, double ord, ln_error *err)
{
    if(!a||a->nd<2){seterr(err,"cond requires an array of at least two dimensions");return NULL;}
    ln_intp m=a->dimensions[a->nd-2],n=a->dimensions[a->nd-1];
    if(m==0||n==0){seterr(err,"cond is not defined on empty arrays");return NULL;}
    int svd_mode=(kind==LN_NORM_DEFAULT)||(kind==LN_NORM_NUMBER&&(ord==2.0||ord==-2.0));
    if(!svd_mode&&m!=n){seterr(err,"Last 2 dimensions of the array must be square");return NULL;}
    const ln_array*arrs[1]={a};common_type ct;if(common_type_for(arrs,1,&ct,err)<0)return NULL;const ln_dtype*rdt=real_result_type(&ct);
    int od=a->nd-2;ln_array*out=ln_array_new(od,a->dimensions,rdt,0,0,err);if(!out)return NULL;
    if(svd_mode||kind==LN_NORM_NUC||kind==LN_NORM_FRO){
        ln_intp batches=shape_product(od,a->dimensions,err);
        if(batches<0){ln_array_free(out);return NULL;}
        int mi,ni;
        if(lapack_dim(m,&mi,err)<0||lapack_dim(n,&ni,err)<0){ln_array_free(out);return NULL;}
        ln_intp k=m<n?m:n;
        size_t abytes,sbytes;
        if(checked_count(m,n,ct.compute->elsize,&abytes,err)<0||
           checked_count(k,1,sizeof(double),&sbytes,err)<0){ln_array_free(out);return NULL;}
        void *aw=malloc(abytes?abytes:1),*uw=malloc(1),*vw=malloc(1);
        double *sw=(double*)malloc(sbytes?sbytes:1);
        if(!aw||!uw||!vw||!sw){free(aw);free(uw);free(vw);free(sw);ln_array_free(out);seterr(err,"out of memory");return NULL;}
        ln_intp idx[LN_MAXDIMS]={0};
        for(ln_intp b=0;b<batches;b++){
            const char *ap=batch_ptr_const(a,od,idx,od);
            if(pack_matrix(a,ap,m,n,ct.compute,aw,err)<0)goto csvfail;
            int has_nan=0,has_inf=0;packed_has_nan_or_inf(aw,(size_t)m*(size_t)n,ct.complex,&has_nan,&has_inf);
            double r;
            if(has_nan) r=NAN;
            else if(has_inf) r=INFINITY;
            else {
                if(lapack_gesdd(mi,ni,ct.complex,'N',aw,sw,uw,vw,err)<0)goto csvfail;
                double smax=0,smin=INFINITY,sum=0,sum_inv=0,ss=0,ss_inv=0;
                for(ln_intp q=0;q<k;q++){
                    double v=sw[q];if(v>smax)smax=v;if(v<smin)smin=v;sum+=v;ss+=v*v;
                    if(v==0){sum_inv=INFINITY;ss_inv=INFINITY;}
                    else if(isfinite(sum_inv)){sum_inv+=1.0/v;ss_inv+=1.0/(v*v);}
                }
                if(kind==LN_NORM_NUMBER&&ord==-2.0)r=smin/smax;
                else if(kind==LN_NORM_NUC)r=sum*sum_inv;
                else if(kind==LN_NORM_FRO)r=sqrt(ss)*sqrt(ss_inv);
                else r=smax/smin;
                if(isnan(r))r=INFINITY;
            }
            if(store_output_real(out,idx,r,err)<0)goto csvfail;
            advance_index(od,a->dimensions,idx);
        }
        free(aw);free(uw);free(vw);free(sw);return out;
csvfail:
        free(aw);free(uw);free(vw);free(sw);ln_array_free(out);return NULL;
    }
    if(!(kind==LN_NORM_POSINF||kind==LN_NORM_NEGINF||(kind==LN_NORM_NUMBER&&(ord==1.0||ord==-1.0)))){ln_array_free(out);seterr(err,"Invalid norm order for matrices.");return NULL;}
    ln_intp batches=shape_product(od,a->dimensions,err);if(batches<0){ln_array_free(out);return NULL;}int ni;if(lapack_dim(n,&ni,err)<0){ln_array_free(out);return NULL;}size_t bytes;if(checked_count(n,n,ct.compute->elsize,&bytes,err)<0){ln_array_free(out);return NULL;}
    void*orig=malloc(bytes?bytes:1),*aw=malloc(bytes?bytes:1),*inv=malloc(bytes?bytes:1);int*ipiv=(int*)malloc((size_t)ni*sizeof(int));if(!orig||!aw||!inv||!ipiv){free(orig);free(aw);free(inv);free(ipiv);ln_array_free(out);seterr(err,"out of memory");return NULL;}
    ln_intp idx[LN_MAXDIMS]={0};int nrhs=ni,lda=ni,ldb=ni;
    for(ln_intp b=0;b<batches;b++){
        const char*ap=batch_ptr_const(a,od,idx,od);if(pack_matrix(a,ap,n,n,ct.compute,orig,err)<0)goto cifail;int has_nan=0,has_inf=0;packed_has_nan_or_inf(orig,(size_t)n*n,ct.complex,&has_nan,&has_inf);
        memcpy(aw,orig,bytes);memset(inv,0,bytes);if(ct.complex){for(int i=0;i<ni;i++)((ln_cdouble*)inv)[(size_t)i*ni+i]=(ln_cdouble){1,0};}else for(int i=0;i<ni;i++)((double*)inv)[(size_t)i*ni+i]=1;
        int info=0;if(ct.complex)zgesv_(&ni,&nrhs,(ln_cdouble*)aw,&lda,ipiv,(ln_cdouble*)inv,&ldb,&info);else dgesv_(&ni,&nrhs,(double*)aw,&lda,ipiv,(double*)inv,&ldb,&info);
        double r;if(has_nan)r=NAN;else if(info>0)r=INFINITY;else if(info<0){seterr(err,"LAPACK GESV received an illegal argument");goto cifail;}else if(has_inf){r=(kind==LN_NORM_POSINF||(kind==LN_NORM_NUMBER&&ord==1.0))?INFINITY:packed_matrix_norm(orig,ni,ct.complex,kind,ord)*packed_matrix_norm(inv,ni,ct.complex,kind,ord);}else r=packed_matrix_norm(orig,ni,ct.complex,kind,ord)*packed_matrix_norm(inv,ni,ct.complex,kind,ord);
        if(isnan(r)&&!has_nan)r=INFINITY;
        if(store_output_real(out,idx,r,err)<0)goto cifail;
        advance_index(od,a->dimensions,idx);
    }
    free(orig);free(aw);free(inv);free(ipiv);return out;
cifail:free(orig);free(aw);free(inv);free(ipiv);ln_array_free(out);return NULL;
}

/* ------------------------------------------------------------------------- */
/* High-level numpy.linalg compositions (0.19 tranche).                      */
/* ------------------------------------------------------------------------- */

static ln_array *
linalg_same_view(const ln_array *a, ln_error *err)
{
    return ln_array_view(a, a->nd, a->dimensions, a->strides, a->data, err);
}

static ln_array *
linalg_permute_view(const ln_array *a, const int *perm, ln_error *err)
{
    ln_intp dims[LN_MAXDIMS], strides[LN_MAXDIMS];
    uint8_t seen[LN_MAXDIMS] = {0};
    if (!a) { seterr(err, "invalid array"); return NULL; }
    for (int i=0; i<a->nd; ++i) {
        int p=perm[i];
        if (p<0 || p>=a->nd || seen[p]) { seterr(err,"invalid axis permutation"); return NULL; }
        seen[p]=1;
        dims[i]=a->dimensions[p];
        strides[i]=a->strides[p];
    }
    return ln_array_view(a,a->nd,dims,strides,a->data,err);
}

static ln_array *
linalg_move_axis_last_view(const ln_array *a, int axis, ln_error *err)
{
    if (!a || a->nd < 1) { seterr(err,"Input arrays must be at least 1-dimensional"); return NULL; }
    if (axis < 0 || axis >= a->nd) { seterr(err,"axis is out of bounds for array"); return NULL; }
    int perm[LN_MAXDIMS], q=0;
    for (int d=0; d<a->nd; ++d) if (d!=axis) perm[q++]=d;
    perm[q]=axis;
    return linalg_permute_view(a,perm,err);
}

static int
linalg_shape_product_range(const ln_array *a, int start, int stop,
                           ln_intp *out, ln_error *err)
{
    ln_intp p=1;
    if (!a || start<0 || stop<start || stop>a->nd) { seterr(err,"invalid shape range"); return -1; }
    for (int d=start; d<stop; ++d) {
        if (a->dimensions[d]==0) { p=0; break; }
        if (ln_mul_sizes_with_overflow(&p,p,a->dimensions[d])) { seterr(err,"array is too big"); return -1; }
    }
    *out=p;
    return 0;
}

ln_array *
ln_linalg_matrix_power(const ln_array *a, int64_t n, ln_error *err)
{
    if (check_square(a,err)<0) return NULL;
    if (n==0) {
        ln_array *out=ln_array_new(a->nd,a->dimensions,a->descr,0,1,err);
        if(!out)return NULL;
        int bod=a->nd-2;
        ln_intp batches=shape_product(bod,a->dimensions,err);
        if(batches<0){ln_array_free(out);return NULL;}
        ln_intp bi[LN_MAXDIMS]={0}, idx[LN_MAXDIMS]={0};
        ln_intp m=a->dimensions[a->nd-1];
        for(ln_intp b=0;b<batches;b++){
            for(int d=0;d<bod;d++)idx[d]=bi[d];
            for(ln_intp i=0;i<m;i++){
                idx[bod]=i;idx[bod+1]=i;
                if(ln_array_pack_number(out,idx,1.0,1,1,err)<0){ln_array_free(out);return NULL;}
            }
            advance_index(bod,a->dimensions,bi);
        }
        return out;
    }

    ln_array *base=NULL;
    uint64_t exp;
    if(n<0){
        base=ln_linalg_inv(a,err);if(!base)return NULL;
        exp=(uint64_t)(-(n+1));exp+=1u;
    }else{
        base=linalg_same_view(a,err);if(!base)return NULL;
        exp=(uint64_t)n;
    }
    if(exp==1) return base;
    if(exp==2){ln_array*r=ln_matmul(base,base,err);ln_array_free(base);return r;}
    if(exp==3){ln_array*t=ln_matmul(base,base,err);if(!t){ln_array_free(base);return NULL;}ln_array*r=ln_matmul(t,base,err);ln_array_free(t);ln_array_free(base);return r;}

    ln_array *z=NULL,*result=NULL;
    while(exp>0){
        if(!z) z=linalg_same_view(base,err);
        else {ln_array*t=ln_matmul(z,z,err);ln_array_free(z);z=t;}
        if(!z)goto fail;
        if(exp&1u){
            if(!result) result=linalg_same_view(z,err);
            else {ln_array*t=ln_matmul(result,z,err);ln_array_free(result);result=t;}
            if(!result)goto fail;
        }
        exp>>=1;
    }
    ln_array_free(z);ln_array_free(base);return result;
fail:
    ln_array_free(z);ln_array_free(result);ln_array_free(base);return NULL;
}

ln_array *
ln_linalg_tensorinv(const ln_array *a, int ind, ln_error *err)
{
    if(!a){seterr(err,"invalid array");return NULL;}
    if(ind<=0){seterr(err,"Invalid ind argument.");return NULL;}
    int split=ind<a->nd?ind:a->nd;
    ln_intp right=1,total=ln_array_size(a);
    if(total<0){seterr(err,"array is too big");return NULL;}
    if(linalg_shape_product_range(a,split,a->nd,&right,err)<0)return NULL;
    if(right==0){seterr(err,"cannot reshape array of size 0 into shape (0,newaxis)");return NULL;}
    ln_intp left;
    left=total/right;
    ln_intp mdims[2]={right,left};
    ln_array *m=ln_array_reshape_c(a,2,mdims,err);if(!m)return NULL;
    ln_array *iv=ln_linalg_inv(m,err);ln_array_free(m);if(!iv)return NULL;
    ln_intp odims[LN_MAXDIMS];int od=0;
    for(int d=split;d<a->nd;d++)odims[od++]=a->dimensions[d];
    for(int d=0;d<split;d++)odims[od++]=a->dimensions[d];
    ln_array *out=ln_array_reshape_c(iv,od,odims,err);ln_array_free(iv);return out;
}

ln_array *
ln_linalg_tensorsolve(const ln_array *a, const ln_array *b,
                      const int *axes, int naxes, ln_error *err)
{
    if(!a||!b){seterr(err,"invalid array");return NULL;}
    ln_array *av=NULL;
    if(naxes>0){
        int perm[LN_MAXDIMS];uint8_t moved[LN_MAXDIMS]={0};int q=0;
        for(int i=0;i<naxes;i++){
            int ax=axes[i];if(ax<0||ax>=a->nd||moved[ax]){seterr(err,"invalid or duplicate tensorsolve axis");return NULL;}moved[ax]=1;
        }
        for(int d=0;d<a->nd;d++)if(!moved[d])perm[q++]=d;
        for(int i=0;i<naxes;i++)perm[q++]=axes[i];
        av=linalg_permute_view(a,perm,err);
    }else av=linalg_same_view(a,err);
    if(!av)return NULL;

    int tail=av->nd-b->nd;
    if(tail<0){ln_array_free(av);seterr(err,"Input arrays must satisfy the requirement prod(a.shape[b.ndim:]) == prod(a.shape[:b.ndim])");return NULL;}
    ln_intp prod=1;
    /* NumPy uses a.shape[-(a.ndim - b.ndim):]: tail is a count, not
     * the starting axis.  The starting axis is therefore b.ndim. */
    if(linalg_shape_product_range(av,b->nd,av->nd,&prod,err)<0){ln_array_free(av);return NULL;}
    ln_intp asz=ln_array_size(av);
    if(asz<0){ln_array_free(av);seterr(err,"array is too big");return NULL;}
    ln_intp prod2;
    if(ln_mul_sizes_with_overflow(&prod2,prod,prod)||asz!=prod2){ln_array_free(av);seterr(err,"Input arrays must satisfy the requirement prod(a.shape[b.ndim:]) == prod(a.shape[:b.ndim])");return NULL;}
    ln_intp adims[2]={prod,prod};
    ln_array *am=ln_array_reshape_c(av,2,adims,err);ln_array_free(av);if(!am)return NULL;
    ln_intp bdims[1]={prod};
    ln_array *bv=ln_array_reshape_c(b,1,bdims,err);if(!bv){ln_array_free(am);return NULL;}
    ln_array *x=ln_linalg_solve(am,bv,err);ln_array_free(am);ln_array_free(bv);if(!x)return NULL;
    int out_nd=a->nd-b->nd;
    /* If axes were supplied, the solution shape is the rightmost tail of the
     * permuted coefficient tensor. Reconstruct that shape from the same
     * permutation rather than from the freed view. */
    ln_intp outdims[LN_MAXDIMS];
    if(naxes>0){
        int perm[LN_MAXDIMS];uint8_t moved[LN_MAXDIMS]={0};int q=0;
        for(int i=0;i<naxes;i++)moved[axes[i]]=1;
        for(int d=0;d<a->nd;d++)if(!moved[d])perm[q++]=d;
        for(int i=0;i<naxes;i++)perm[q++]=axes[i];
        for(int d=0;d<out_nd;d++)outdims[d]=a->dimensions[perm[b->nd+d]];
    }else for(int d=0;d<out_nd;d++)outdims[d]=a->dimensions[b->nd+d];
    ln_array *out=ln_array_reshape_c(x,out_nd,outdims,err);ln_array_free(x);return out;
}

ln_array *
ln_linalg_tensordot(const ln_array *a, const ln_array *b,
                    const int *axes_a, const int *axes_b,
                    int naxes, ln_error *err)
{
    if(!a||!b||naxes<0||naxes>LN_MAXDIMS||naxes>a->nd||naxes>b->nd||
            (naxes&&(!axes_a||!axes_b))){seterr(err,"invalid tensordot arguments");return NULL;}
    if(a->nd+b->nd-2*naxes>LN_MAXDIMS){seterr(err,"tensordot result exceeds the native dimension limit");return NULL;}
    uint8_t ca[LN_MAXDIMS]={0},cb[LN_MAXDIMS]={0};
    for(int i=0;i<naxes;i++){
        int aa=axes_a[i],bb=axes_b[i];
        if(aa<0||aa>=a->nd||bb<0||bb>=b->nd||ca[aa]||cb[bb]){seterr(err,"invalid or duplicate tensordot axes");return NULL;}
        ca[aa]=1;cb[bb]=1;
        if(a->dimensions[aa]!=b->dimensions[bb]){seterr(err,"shape-mismatch for sum");return NULL;}
    }
    int pa[LN_MAXDIMS],pb[LN_MAXDIMS],qa=0,qb=0;
    ln_intp outdims[LN_MAXDIMS];int outnd=0;
    for(int d=0;d<a->nd;d++)if(!ca[d]){pa[qa++]=d;outdims[outnd++]=a->dimensions[d];}
    for(int i=0;i<naxes;i++)pa[qa++]=axes_a[i];
    for(int i=0;i<naxes;i++)pb[qb++]=axes_b[i];
    for(int d=0;d<b->nd;d++)if(!cb[d]){pb[qb++]=d;outdims[outnd++]=b->dimensions[d];}
    ln_array *av=linalg_permute_view(a,pa,err);if(!av)return NULL;
    ln_array *bv=linalg_permute_view(b,pb,err);if(!bv){ln_array_free(av);return NULL;}
    ln_intp k=1,la=1,lb=1;
    for(int i=0;i<naxes;i++){if(ln_mul_sizes_with_overflow(&k,k,a->dimensions[axes_a[i]])){seterr(err,"array is too big");goto fail;}}
    for(int d=0;d<a->nd-naxes;d++){if(ln_mul_sizes_with_overflow(&la,la,av->dimensions[d])){seterr(err,"array is too big");goto fail;}}
    for(int d=naxes;d<b->nd;d++){if(ln_mul_sizes_with_overflow(&lb,lb,bv->dimensions[d])){seterr(err,"array is too big");goto fail;}}
    ln_intp ash[2]={la,k},bsh[2]={k,lb};
    ln_array *am=ln_array_reshape_c(av,2,ash,err);ln_array_free(av);av=NULL;if(!am)goto fail;
    ln_array *bm=ln_array_reshape_c(bv,2,bsh,err);ln_array_free(bv);bv=NULL;if(!bm){ln_array_free(am);return NULL;}
    ln_array *p=ln_dot(am,bm,err);ln_array_free(am);ln_array_free(bm);if(!p)return NULL;
    ln_array *out=ln_array_reshape_c(p,outnd,outdims,err);ln_array_free(p);return out;
fail:
    ln_array_free(av);ln_array_free(bv);return NULL;
}

static ln_array *
multi_dot_leaf_view(const ln_array *a, ln_error *err)
{
    return linalg_same_view(a,err);
}

static ln_array *
multi_dot_rec(const ln_array *const *a, const int *split,
              int n, int i, int j, ln_error *err)
{
    if(i==j)return multi_dot_leaf_view(a[i],err);
    int k=split[i*n+j];
    ln_array *l=multi_dot_rec(a,split,n,i,k,err);if(!l)return NULL;
    ln_array *r=multi_dot_rec(a,split,n,k+1,j,err);if(!r){ln_array_free(l);return NULL;}
    ln_array *o=ln_dot(l,r,err);ln_array_free(l);ln_array_free(r);return o;
}

ln_array *
ln_linalg_multi_dot(const ln_array *const *arrays, int narr, ln_error *err)
{
    if(narr<2){seterr(err,"Expecting at least two arrays.");return NULL;}
    if(narr==2)return ln_dot(arrays[0],arrays[1],err);
    ln_array **work=(ln_array**)calloc((size_t)narr,sizeof(*work));
    const ln_array **wa=(const ln_array**)calloc((size_t)narr,sizeof(*wa));
    if(!work||!wa){free(work);free(wa);seterr(err,"out of memory");return NULL;}
    int first1=arrays[0]->nd==1,last1=arrays[narr-1]->nd==1;
    for(int i=0;i<narr;i++){
        const ln_array *src=arrays[i];
        if((i==0&&src->nd==1)||(i==narr-1&&src->nd==1)){
            ln_intp d[2],s[2];
            if(i==0){d[0]=1;d[1]=src->dimensions[0];s[0]=src->dimensions[0]*(ln_intp)src->descr->elsize;s[1]=src->strides[0];}
            else {d[0]=src->dimensions[0];d[1]=1;s[0]=src->strides[0];s[1]=(ln_intp)src->descr->elsize;}
            work[i]=ln_array_view(src,2,d,s,src->data,err);if(!work[i])goto fail;
            wa[i]=work[i];
        }else{
            if(src->nd!=2){seterr(err,"multi_dot inputs must be 2-D except for the first and last arguments");goto fail;}
            wa[i]=src;
        }
    }
    for(int i=0;i<narr-1;i++)if(wa[i]->dimensions[1]!=wa[i+1]->dimensions[0]){seterr(err,"shapes are not aligned for multi_dot");goto fail;}
    int *split=(int*)calloc((size_t)narr*(size_t)narr,sizeof(int));
    long double *cost=(long double*)calloc((size_t)narr*(size_t)narr,sizeof(long double));
    if(!split||!cost){free(split);free(cost);seterr(err,"out of memory");goto fail;}
    for(int len=1;len<narr;len++)for(int i=0;i<narr-len;i++){
        int j=i+len;long double best=HUGE_VALL;int bestk=i;
        for(int k=i;k<j;k++){
            long double q=cost[i*narr+k]+cost[(k+1)*narr+j]
                +(long double)wa[i]->dimensions[0]*(long double)wa[k]->dimensions[1]*(long double)wa[j]->dimensions[1];
            if(q<best){best=q;bestk=k;}
        }
        cost[i*narr+j]=best;split[i*narr+j]=bestk;
    }
    ln_array *r=multi_dot_rec(wa,split,narr,0,narr-1,err);
    free(split);free(cost);
    if(!r)goto fail;
    for(int i=0;i<narr;i++) ln_array_free(work[i]);
    free(work);free(wa);
    if(first1||last1){
        ln_intp dims[1];int nd;
        if(first1&&last1)nd=0;
        else {nd=1;dims[0]=first1?r->dimensions[1]:r->dimensions[0];}
        ln_array *rr=ln_array_reshape_c(r,nd,dims,err);ln_array_free(r);return rr;
    }
    return r;
fail:
    if(work) for(int i=0;i<narr;i++) ln_array_free(work[i]);
    free(work);free(wa);return NULL;
}

ln_array *
ln_linalg_outer(const ln_array *a, const ln_array *b, ln_error *err)
{
    if(!a||!b){seterr(err,"invalid array");return NULL;}
    if(a->nd!=1||b->nd!=1){seterr(err,"Input arrays must be one-dimensional");return NULL;}
    return ln_outer(a,b,err);
}

ln_array *
ln_linalg_diagonal(const ln_array *a, ln_intp offset, ln_error *err)
{
    return ln_matrix_diagonal(a,offset,a?a->nd-2:0,a?a->nd-1:1,err);
}

ln_array *
ln_linalg_trace(const ln_array *a, ln_intp offset, const ln_dtype *dtype, ln_error *err)
{
    return ln_matrix_trace(a,offset,a?a->nd-2:0,a?a->nd-1:1,dtype,NULL,err);
}

ln_array *
ln_linalg_matrix_transpose(const ln_array *a, ln_error *err)
{
    if(!a||a->nd<2){char msg[128];snprintf(msg,sizeof(msg),"Input array must be at least 2-dimensional, but it is %d",a?a->nd:0);seterr(err,msg);return NULL;}
    ln_intp dims[LN_MAXDIMS],strides[LN_MAXDIMS];
    for(int d=0;d<a->nd;d++){dims[d]=a->dimensions[d];strides[d]=a->strides[d];}
    int x=a->nd-2,y=a->nd-1;ln_intp t=dims[x];dims[x]=dims[y];dims[y]=t;t=strides[x];strides[x]=strides[y];strides[y]=t;
    return ln_array_view(a,a->nd,dims,strides,a->data,err);
}

ln_array *
ln_linalg_cross(const ln_array *a,int axis_a,const ln_array *b,int axis_b,
                int axis_out,ln_error *err)
{return ln_vector_cross(a,axis_a,b,axis_b,axis_out,err);}


static int
linalg_conjugate_inplace(ln_array *a, ln_error *err)
{
    if(!a||a->descr->kind!='c')return 0;
    ln_intp n=ln_array_size(a);if(n<0){seterr(err,"array is too big");return -1;}
    if(!(a->flags&LN_ARRAY_C_CONTIGUOUS)){seterr(err,"internal conjugate buffer is not contiguous");return -1;}
    if(a->descr->type_num==LN_CFLOAT){ln_cfloat*p=(ln_cfloat*)a->data;for(ln_intp i=0;i<n;i++)p[i].imag=-p[i].imag;return 0;}
    if(a->descr->type_num==LN_CDOUBLE){ln_cdouble*p=(ln_cdouble*)a->data;for(ln_intp i=0;i<n;i++)p[i].imag=-p[i].imag;return 0;}
    if(a->descr->type_num==LN_CLONGDOUBLE){ln_clongdouble*p=(ln_clongdouble*)a->data;for(ln_intp i=0;i<n;i++)p[i].imag=-p[i].imag;return 0;}
    seterr(err,"unsupported complex dtype");return -1;
}

ln_array *
ln_linalg_vecdot(const ln_array *a, int axis_a, const ln_array *b, int axis_b,
                 ln_error *err)
{
    if(!a||!b||a->nd<1||b->nd<1){seterr(err,"vecdot inputs must be at least one-dimensional");return NULL;}
    ln_array *av=linalg_move_axis_last_view(a,axis_a,err);if(!av)return NULL;
    ln_array *bv=linalg_move_axis_last_view(b,axis_b,err);if(!bv){ln_array_free(av);return NULL;}
    if(av->dimensions[av->nd-1]!=bv->dimensions[bv->nd-1]){seterr(err,"vecdot core dimensions do not match");ln_array_free(av);ln_array_free(bv);return NULL;}
    ln_array *ac=ln_array_copy_c(av,err);if(!ac){ln_array_free(av);ln_array_free(bv);return NULL;}
    if(linalg_conjugate_inplace(ac,err)<0){ln_array_free(av);ln_array_free(bv);ln_array_free(ac);return NULL;}
    int nda=ac->nd+1,ndb=bv->nd+1;ln_intp ad[LN_MAXDIMS],bd[LN_MAXDIMS];
    int ba=ac->nd-1,bb=bv->nd-1;
    for(int d=0;d<ba;d++) ad[d]=ac->dimensions[d];
    ad[ba]=1;ad[ba+1]=ac->dimensions[ac->nd-1];
    for(int d=0;d<bb;d++) bd[d]=bv->dimensions[d];
    bd[bb]=bv->dimensions[bv->nd-1];bd[bb+1]=1;
    ln_array *am=ln_array_reshape_c(ac,nda,ad,err);ln_array_free(ac);ln_array_free(av);if(!am){ln_array_free(bv);return NULL;}
    ln_array *bm=ln_array_reshape_c(bv,ndb,bd,err);ln_array_free(bv);if(!bm){ln_array_free(am);return NULL;}
    ln_array *mm=ln_matmul(am,bm,err);ln_array_free(am);ln_array_free(bm);if(!mm)return NULL;
    int od=mm->nd-2;ln_intp odims[LN_MAXDIMS];for(int d=0;d<od;d++)odims[d]=mm->dimensions[d];
    ln_array *out=ln_array_reshape_c(mm,od,odims,err);ln_array_free(mm);return out;
}

ln_array *
ln_linalg_vector_norm(const ln_array *a, ln_norm_kind kind, double ord,
                      const int *axes, int naxes, int axis_is_none,
                      int keepdims, ln_error *err)
{
    if(!a){seterr(err,"invalid array");return NULL;}
    if(kind==LN_NORM_FRO||kind==LN_NORM_NUC){seterr(err,"Invalid norm order for vectors");return NULL;}
    int selected[LN_MAXDIMS],nsel=0;uint8_t mark[LN_MAXDIMS]={0};
    if(axis_is_none){for(int d=0;d<a->nd;d++){selected[nsel++]=d;mark[d]=1;}}
    else{
        if(naxes<0||naxes>a->nd){seterr(err,"invalid vector_norm axes");return NULL;}
        for(int i=0;i<naxes;i++){int ax=axes[i];if(ax<0||ax>=a->nd||mark[ax]){seterr(err,"duplicate or invalid axis");return NULL;}mark[ax]=1;selected[nsel++]=ax;}
    }
    int perm[LN_MAXDIMS],q=0;for(int i=0;i<nsel;i++)perm[q++]=selected[i];for(int d=0;d<a->nd;d++)if(!mark[d])perm[q++]=d;
    ln_array *pv;
    if(a->nd==0)pv=linalg_same_view(a,err);else pv=linalg_permute_view(a,perm,err);
    if(!pv)return NULL;
    ln_intp selected_size=1;
    for(int i=0;i<nsel;i++)if(ln_mul_sizes_with_overflow(&selected_size,selected_size,a->dimensions[selected[i]])){ln_array_free(pv);seterr(err,"array is too big");return NULL;}
    int rest=a->nd-nsel;ln_intp rdims[LN_MAXDIMS];rdims[0]=selected_size;for(int i=0;i<rest;i++)rdims[i+1]=pv->dimensions[nsel+i];
    ln_array *rv=ln_array_reshape_c(pv,rest+1,rdims,err);ln_array_free(pv);if(!rv)return NULL;
    int ax0=0;ln_array *r=ln_linalg_norm(rv,kind,ord,&ax0,1,0,0,err);ln_array_free(rv);if(!r)return NULL;
    if(!keepdims)return r;
    ln_intp kdims[LN_MAXDIMS];for(int d=0;d<a->nd;d++)kdims[d]=mark[d]?1:a->dimensions[d];
    ln_array *out=ln_array_reshape_c(r,a->nd,kdims,err);ln_array_free(r);return out;
}
