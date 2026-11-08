#include "ln_matmul.h"
#include "ln_half.h"
#include "ln_complex.h"
#include "ln_dtype_transfer.h"
#include "ln_ufunc_loops.h"

#include <stdint.h>
#include <limits.h>
#include <cblas.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*
 * Source-derived subset of:
 *   numpy/_core/src/umath/matmul.c.src
 *     *_matmul_inner_noblas
 *     BOOL_matmul_inner_noblas
 *     gufunc signature (m?,n),(n,p?)->(m?,p?)
 *   numpy/_core/src/multiarray/nditer_constr.c
 *     npyiter_find_best_axis_ordering (KEEPORDER batch allocation)
 *   numpy/_core/tests/test_multiarray.py::MatmulCommon/TestMatmul
 *
 * CPython/PyArrayMethod dispatch is replaced with LuaRay's native dtype
 * resolver, transfer loops, and ndarray storage.  BLAS selection is layered
 * separately; this file intentionally keeps the exact strided no-BLAS kernel
 * available for every currently supported real numeric dtype.
 */

typedef struct ln_matmul_plan {
    int a_vec, b_vec;
    int batch_nd;
    ln_intp batch_shape[LN_MAXDIMS];
    ln_intp a_batch_strides[LN_MAXDIMS];
    ln_intp b_batch_strides[LN_MAXDIMS];
    int batch_order[LN_MAXDIMS]; /* inner -> outer */
    ln_intp m, n, p;
    ln_intp as_m, as_n;
    ln_intp bs_n, bs_p;
    int out_nd;
    ln_intp out_shape[LN_MAXDIMS];
} ln_matmul_plan;

static void
merr(ln_error *err, const char *msg)
{
    if (err) snprintf(err->message, sizeof(err->message), "%s", msg);
}

static ln_intp
absi(ln_intp x)
{
    return x < 0 ? -x : x;
}

static int
build_plan(const ln_array *a, const ln_array *b, ln_matmul_plan *p,
           ln_error *err)
{
    memset(p, 0, sizeof(*p));
    if (!a || !b) { merr(err, "invalid matmul operand"); return -1; }
    if (a->nd == 0 || b->nd == 0) {
        merr(err, "matmul: input operand does not have enough dimensions");
        return -1;
    }
    p->a_vec = a->nd == 1;
    p->b_vec = b->nd == 1;
    p->m = p->a_vec ? 1 : a->dimensions[a->nd - 2];
    p->n = a->dimensions[a->nd - 1];
    ln_intp bn = p->b_vec ? b->dimensions[0] : b->dimensions[b->nd - 2];
    p->p = p->b_vec ? 1 : b->dimensions[b->nd - 1];
    if (p->n != bn) {
        merr(err, "matmul: input operand core dimension mismatch");
        return -1;
    }
    p->as_m = p->a_vec ? 0 : a->strides[a->nd - 2];
    p->as_n = a->strides[a->nd - 1];
    p->bs_n = p->b_vec ? b->strides[0] : b->strides[b->nd - 2];
    p->bs_p = p->b_vec ? 0 : b->strides[b->nd - 1];

    int abd = p->a_vec ? 0 : a->nd - 2;
    int bbd = p->b_vec ? 0 : b->nd - 2;
    p->batch_nd = abd > bbd ? abd : bbd;
    if (p->batch_nd + (!p->a_vec) + (!p->b_vec) > LN_MAXDIMS) {
        merr(err, "maximum supported dimension exceeded in matmul");
        return -1;
    }
    for (int d = 0; d < p->batch_nd; ++d) {
        int ad = d - (p->batch_nd - abd);
        int bd = d - (p->batch_nd - bbd);
        ln_intp ash = ad < 0 ? 1 : a->dimensions[ad];
        ln_intp bsh = bd < 0 ? 1 : b->dimensions[bd];
        if (ash != bsh && ash != 1 && bsh != 1) {
            merr(err, "operands could not be broadcast together for matmul");
            return -1;
        }
        ln_intp sh = (ash == 1) ? bsh : ((bsh == 1) ? ash : ash);
        p->batch_shape[d] = sh;
        p->a_batch_strides[d] = (ad < 0 || ash == 1) ? 0 : a->strides[ad];
        p->b_batch_strides[d] = (bd < 0 || bsh == 1) ? 0 : b->strides[bd];
    }

    int od = 0;
    for (int d = 0; d < p->batch_nd; ++d) p->out_shape[od++] = p->batch_shape[d];
    if (!p->a_vec) p->out_shape[od++] = p->m;
    if (!p->b_vec) p->out_shape[od++] = p->p;
    p->out_nd = od;
    return 0;
}

static int
axis_before(const ln_matmul_plan *p, int cand, int prev)
{
    int ambig = 1, swap = 0;
    ln_intp cs[2] = {p->a_batch_strides[cand], p->b_batch_strides[cand]};
    ln_intp ps[2] = {p->a_batch_strides[prev], p->b_batch_strides[prev]};
    for (int op = 0; op < 2; ++op) {
        ln_intp s0 = cs[op], s1 = ps[op];
        if (s0 != 0 && s1 != 0) {
            if (absi(s1) <= absi(s0)) swap = 0;
            else if (ambig) swap = 1;
            ambig = 0;
        }
    }
    return !ambig && swap;
}

static int
axes_comparable(const ln_matmul_plan *p, int a, int b)
{
    return (p->a_batch_strides[a] != 0 && p->a_batch_strides[b] != 0) ||
           (p->b_batch_strides[a] != 0 && p->b_batch_strides[b] != 0);
}

static void
find_batch_order(ln_matmul_plan *p)
{
    for (int i = 0; i < p->batch_nd; ++i) p->batch_order[i] = p->batch_nd - 1 - i;
    for (int i = 1; i < p->batch_nd; ++i) {
        int cand = p->batch_order[i], pos = i;
        for (int j = i - 1; j >= 0; --j) {
            int prev = p->batch_order[j];
            if (axis_before(p, cand, prev)) pos = j;
            else if (axes_comparable(p, cand, prev)) break;
        }
        if (pos != i) {
            for (int j = i; j > pos; --j) p->batch_order[j] = p->batch_order[j - 1];
            p->batch_order[pos] = cand;
        }
    }
}

static void
set_output_strides(ln_array *out, ln_matmul_plan *p)
{
    /* ctors.c leaves every stride zero for zero-size arrays. */
    if (ln_array_size(out) == 0) return;
    find_batch_order(p);
    ln_intp stride = (ln_intp)out->descr->elsize;
    int core_base = p->batch_nd;
    if (!p->b_vec) {
        int pd = core_base + (!p->a_vec ? 1 : 0);
        out->strides[pd] = stride;
        stride *= p->p;
    }
    if (!p->a_vec) {
        int md = core_base;
        out->strides[md] = stride;
        stride *= p->m;
    }
    for (int i = 0; i < p->batch_nd; ++i) {
        int d = p->batch_order[i];
        out->strides[d] = stride;
        stride *= p->batch_shape[d];
    }
    ln_update_contiguous_flags(out);
}

static int
is_blasable2d(ln_intp byte_stride1, ln_intp byte_stride2,
              ln_intp d1, ln_intp d2, ln_intp itemsize)
{
    if (byte_stride1 < 0 || byte_stride2 != itemsize || itemsize <= 0) return 0;
    if (byte_stride1 % itemsize != 0) return 0;
    ln_intp u1 = byte_stride1 / itemsize;
    return u1 >= d2 && u1 <= (ln_intp)INT_MAX - 1 &&
           d1 <= (ln_intp)INT_MAX - 1 && d2 <= (ln_intp)INT_MAX - 1;
}

/* Direct real-valued subset of matmul.c.src:*_matmul_matrixmatrix.  NumPy
 * uses this CBLAS path for float/double core matrices when the strided views
 * are directly BLASable; otherwise the exact no-BLAS kernel remains active. */
static int
try_blas_matrixmatrix(const ln_array *a, const ln_array *b,
                      const ln_matmul_plan *p, const char *abase,
                      const char *bbase, char *obase, const ln_array *out)
{
    if (p->a_vec || p->b_vec || p->m <= 1 || p->n <= 1 || p->p <= 1) return 0;
    if (a->descr->type_num != out->descr->type_num ||
        b->descr->type_num != out->descr->type_num) return 0;
    if (out->descr->type_num != LN_FLOAT && out->descr->type_num != LN_DOUBLE &&
        out->descr->type_num != LN_CFLOAT && out->descr->type_num != LN_CDOUBLE) return 0;
    if (p->m > (ln_intp)INT_MAX-1 || p->n > (ln_intp)INT_MAX-1 ||
        p->p > (ln_intp)INT_MAX-1) return 0;
    ln_intp sz=(ln_intp)out->descr->elsize;
    int ac=is_blasable2d(p->as_m,p->as_n,p->m,p->n,sz);
    int af=is_blasable2d(p->as_n,p->as_m,p->n,p->m,sz);
    int bc=is_blasable2d(p->bs_n,p->bs_p,p->n,p->p,sz);
    int bf=is_blasable2d(p->bs_p,p->bs_n,p->p,p->n,sz);
    if ((!ac&&!af)||(!bc&&!bf)) return 0;
    int om_axis=p->batch_nd, op_axis=p->batch_nd+1;
    ln_intp os_m=out->strides[om_axis],os_p=out->strides[op_axis];
    if(!is_blasable2d(os_m,os_p,p->m,p->p,sz))return 0;
    enum CBLAS_TRANSPOSE ta=ac?CblasNoTrans:CblasTrans;
    enum CBLAS_TRANSPOSE tb=bc?CblasNoTrans:CblasTrans;
    int lda=(int)((ac?p->as_m:p->as_n)/sz);
    int ldb=(int)((bc?p->bs_n:p->bs_p)/sz);
    int ldc=(int)(os_m/sz);
    if(out->descr->type_num==LN_FLOAT){
        cblas_sgemm(CblasRowMajor,ta,tb,(int)p->m,(int)p->p,(int)p->n,
                    1.0f,(const float*)abase,lda,(const float*)bbase,ldb,
                    0.0f,(float*)obase,ldc);
        return 1;
    }
    if(out->descr->type_num==LN_DOUBLE){
        cblas_dgemm(CblasRowMajor,ta,tb,(int)p->m,(int)p->p,(int)p->n,
                    1.0,(const double*)abase,lda,(const double*)bbase,ldb,
                    0.0,(double*)obase,ldc);
        return 1;
    }
    if(out->descr->type_num==LN_CFLOAT){
        const ln_cfloat one={1.0f,0.0f}, zero={0.0f,0.0f};
        cblas_cgemm(CblasRowMajor,ta,tb,(int)p->m,(int)p->p,(int)p->n,
                    &one,(const void*)abase,lda,(const void*)bbase,ldb,
                    &zero,(void*)obase,ldc);
        return 1;
    }
    if(out->descr->type_num==LN_CDOUBLE){
        const ln_cdouble one={1.0,0.0}, zero={0.0,0.0};
        cblas_zgemm(CblasRowMajor,ta,tb,(int)p->m,(int)p->p,(int)p->n,
                    &one,(const void*)abase,lda,(const void*)bbase,ldb,
                    &zero,(void*)obase,ldc);
        return 1;
    }
    return 0;
}


static int
blas_vector_stride(ln_intp byte_stride, ln_intp itemsize, int *inc)
{
    if (itemsize <= 0 || byte_stride <= 0 || byte_stride % itemsize != 0) return 0;
    ln_intp q = byte_stride / itemsize;
    if (q <= 0 || q > (ln_intp)INT_MAX - 1) return 0;
    *inc = (int)q;
    return 1;
}

/* Special-case subset from matmul.c.src: scalar_out uses *_dot and
 * matrix-vector/vector-matrix use GEMV when all relevant strides are BLASable. */
static int
try_blas_vector_cases(const ln_array *a, const ln_array *b,
                      const ln_matmul_plan *p, const char *abase,
                      const char *bbase, char *obase, const ln_array *out)
{
    if ((out->descr->type_num != LN_FLOAT && out->descr->type_num != LN_DOUBLE &&
         out->descr->type_num != LN_CFLOAT && out->descr->type_num != LN_CDOUBLE) ||
        a->descr->type_num != out->descr->type_num ||
        b->descr->type_num != out->descr->type_num) return 0;
    if (p->n <= 0 || p->n > (ln_intp)INT_MAX - 1) return 0;
    ln_intp sz=(ln_intp)out->descr->elsize;

    if (p->a_vec && p->b_vec) {
        int ia=0,ib=0;
        if(!blas_vector_stride(p->as_n,sz,&ia) || !blas_vector_stride(p->bs_n,sz,&ib))return 0;
        if(out->descr->type_num==LN_FLOAT){
            double sum=0.0; ln_intp left=p->n; const char *ap=abase,*bp=bbase;
            const ln_intp chunkmax=(ln_intp)INT_MAX/2+1;
            while(left>0){int c=(int)(left<chunkmax?left:chunkmax);sum+=(double)cblas_sdot(c,(const float*)ap,ia,(const float*)bp,ib);ap+=(ln_intp)c*p->as_n;bp+=(ln_intp)c*p->bs_n;left-=c;}
            *(float*)obase=(float)sum;
        } else if(out->descr->type_num==LN_DOUBLE){
            double sum=0.0; ln_intp left=p->n; const char *ap=abase,*bp=bbase;
            const ln_intp chunkmax=(ln_intp)INT_MAX/2+1;
            while(left>0){int c=(int)(left<chunkmax?left:chunkmax);sum+=cblas_ddot(c,(const double*)ap,ia,(const double*)bp,ib);ap+=(ln_intp)c*p->as_n;bp+=(ln_intp)c*p->bs_n;left-=c;}
            *(double*)obase=sum;
        } else if(out->descr->type_num==LN_CFLOAT){
            cblas_cdotu_sub((int)p->n,(const void*)abase,ia,(const void*)bbase,ib,(void*)obase);
        } else {
            cblas_zdotu_sub((int)p->n,(const void*)abase,ia,(const void*)bbase,ib,(void*)obase);
        }
        return 1;
    }

    if(!p->a_vec && p->b_vec && p->m>1 && p->n>1 && p->m<=(ln_intp)INT_MAX-1){
        int ac=is_blasable2d(p->as_m,p->as_n,p->m,p->n,sz);
        int af=is_blasable2d(p->as_n,p->as_m,p->n,p->m,sz);
        int ix=0,iy=0; int om=p->batch_nd;
        if((!ac&&!af)||!blas_vector_stride(p->bs_n,sz,&ix)||!blas_vector_stride(out->strides[om],sz,&iy))return 0;
        enum CBLAS_ORDER order=ac?CblasRowMajor:CblasColMajor;
        int lda=(int)((ac?p->as_m:p->as_n)/sz);
        if(out->descr->type_num==LN_FLOAT)cblas_sgemv(order,CblasNoTrans,(int)p->m,(int)p->n,1.0f,(const float*)abase,lda,(const float*)bbase,ix,0.0f,(float*)obase,iy);
        else if(out->descr->type_num==LN_DOUBLE)cblas_dgemv(order,CblasNoTrans,(int)p->m,(int)p->n,1.0,(const double*)abase,lda,(const double*)bbase,ix,0.0,(double*)obase,iy);
        else if(out->descr->type_num==LN_CFLOAT){const ln_cfloat one={1,0},zero={0,0};cblas_cgemv(order,CblasNoTrans,(int)p->m,(int)p->n,&one,(const void*)abase,lda,(const void*)bbase,ix,&zero,(void*)obase,iy);}
        else {const ln_cdouble one={1,0},zero={0,0};cblas_zgemv(order,CblasNoTrans,(int)p->m,(int)p->n,&one,(const void*)abase,lda,(const void*)bbase,ix,&zero,(void*)obase,iy);}
        return 1;
    }

    if(p->a_vec && !p->b_vec && p->p>1 && p->n>1 && p->p<=(ln_intp)INT_MAX-1){
        int bc=is_blasable2d(p->bs_n,p->bs_p,p->n,p->p,sz);
        int bf=is_blasable2d(p->bs_p,p->bs_n,p->p,p->n,sz);
        int ix=0,iy=0; int op=p->batch_nd;
        if((!bc&&!bf)||!blas_vector_stride(p->as_n,sz,&ix)||!blas_vector_stride(out->strides[op],sz,&iy))return 0;
        enum CBLAS_ORDER order=bc?CblasRowMajor:CblasColMajor;
        int lda=(int)((bc?p->bs_n:p->bs_p)/sz);
        if(out->descr->type_num==LN_FLOAT)cblas_sgemv(order,CblasTrans,(int)p->n,(int)p->p,1.0f,(const float*)bbase,lda,(const float*)abase,ix,0.0f,(float*)obase,iy);
        else if(out->descr->type_num==LN_DOUBLE)cblas_dgemv(order,CblasTrans,(int)p->n,(int)p->p,1.0,(const double*)bbase,lda,(const double*)abase,ix,0.0,(double*)obase,iy);
        else if(out->descr->type_num==LN_CFLOAT){const ln_cfloat one={1,0},zero={0,0};cblas_cgemv(order,CblasTrans,(int)p->n,(int)p->p,&one,(const void*)bbase,lda,(const void*)abase,ix,&zero,(void*)obase,iy);}
        else {const ln_cdouble one={1,0},zero={0,0};cblas_zgemv(order,CblasTrans,(int)p->n,(int)p->p,&one,(const void*)bbase,lda,(const void*)abase,ix,&zero,(void*)obase,iy);}
        return 1;
    }
    return 0;
}

static void
advance_batch(int nd, const ln_intp *shape, ln_intp *coord)
{
    for (int d = nd - 1; d >= 0; --d) {
        coord[d]++;
        if (coord[d] < shape[d]) return;
        coord[d] = 0;
    }
}

static int
execute_matmul(const ln_array *a, const ln_array *b, const ln_matmul_plan *p,
               ln_array *out, ln_error *err)
{
    const ln_dtype *dt = out->descr;
    ln_strided_binary_loop mul = ln_get_multiply_loop(dt->type_num);
    ln_strided_binary_loop add = ln_get_add_loop(dt->type_num);
    if (!mul || !add) { merr(err, "no matmul loop for dtype"); return -1; }
    if (dt->elsize > 32) { merr(err, "matmul dtype too large for scalar buffer"); return -1; }

    ln_intp batches = 1;
    for (int d = 0; d < p->batch_nd; ++d) {
        if (ln_mul_sizes_with_overflow(&batches, batches, p->batch_shape[d])) {
            merr(err, "array is too big"); return -1;
        }
    }
    if (p->batch_nd == 0) batches = 1;
    if (ln_array_size(out) == 0) return 0;

    unsigned char av[32], bv[32], prod[32];
    ln_intp coord[LN_MAXDIMS] = {0};
    ln_intp one[1] = {1}, steps[3] = {0,0,0};
    int out_m_axis = p->batch_nd;
    int out_p_axis = p->batch_nd + (!p->a_vec ? 1 : 0);
    for (ln_intp bi = 0; bi < batches; ++bi) {
        const char *abase = a->data, *bbase = b->data;
        char *obase = out->data;
        for (int d = 0; d < p->batch_nd; ++d) {
            abase += coord[d] * p->a_batch_strides[d];
            bbase += coord[d] * p->b_batch_strides[d];
            obase += coord[d] * out->strides[d];
        }
        if (try_blas_vector_cases(a,b,p,abase,bbase,obase,out) ||
            try_blas_matrixmatrix(a,b,p,abase,bbase,obase,out)) {
            advance_batch(p->batch_nd,p->batch_shape,coord);
            continue;
        }
        for (ln_intp m = 0; m < p->m; ++m) {
            for (ln_intp q = 0; q < p->p; ++q) {
                char *op = obase;
                if (!p->a_vec) op += m * out->strides[out_m_axis];
                if (!p->b_vec) op += q * out->strides[out_p_axis];
                if (dt->type_num == LN_HALF) {
                    float sum = 0.0f;
                    for (ln_intp n = 0; n < p->n; ++n) {
                        const char *ap = abase + m * p->as_m + n * p->as_n;
                        const char *bp = bbase + n * p->bs_n + q * p->bs_p;
                        ln_half ha, hb;
                        if (a->descr->type_num == LN_HALF) memcpy(&ha, ap, sizeof(ha));
                        else if (ln_cast_strided_numeric(ap,0,a->descr,(char*)&ha,0,dt,1,err)<0) return -1;
                        if (b->descr->type_num == LN_HALF) memcpy(&hb, bp, sizeof(hb));
                        else if (ln_cast_strided_numeric(bp,0,b->descr,(char*)&hb,0,dt,1,err)<0) return -1;
                        sum += ln_half_to_float(ha) * ln_half_to_float(hb);
                    }
                    ln_half ho = ln_float_to_half(sum);
                    memcpy(op, &ho, sizeof(ho));
                    continue;
                }
                memset(op, 0, dt->elsize);
                for (ln_intp n = 0; n < p->n; ++n) {
                    const char *ap = abase + m * p->as_m + n * p->as_n;
                    const char *bp = bbase + n * p->bs_n + q * p->bs_p;
                    const char *aa = ap, *bb = bp;
                    if (a->descr->type_num != dt->type_num) {
                        if (ln_cast_strided_numeric(ap,0,a->descr,(char*)av,0,dt,1,err)<0) return -1;
                        aa=(char*)av;
                    }
                    if (b->descr->type_num != dt->type_num) {
                        if (ln_cast_strided_numeric(bp,0,b->descr,(char*)bv,0,dt,1,err)<0) return -1;
                        bb=(char*)bv;
                    }
                    char *margs[3]={(char*)aa,(char*)bb,(char*)prod};
                    mul(margs,one,steps,NULL);
                    char *aargs[3]={op,(char*)prod,op};
                    add(aargs,one,steps,NULL);
                }
            }
        }
        advance_batch(p->batch_nd,p->batch_shape,coord);
    }
    return 0;
}

static int
kind_order(char k)
{
    switch(k){case 'b':return 0;case 'u':return 1;case 'i':return 2;case 'f':return 4;case 'c':return 5;default:return -1;}
}

static int
can_cast_same_kind(const ln_dtype *from,const ln_dtype *to)
{
    if(from->type_num==to->type_num)return 1;
    const ln_dtype *pr=ln_promote_dtype(from,to);
    if(pr&&pr->type_num==to->type_num)return 1;
    int f=kind_order(from->kind),t=kind_order(to->kind);
    return f>=0&&t>=0&&f<=t;
}

static int
shape_matches(const ln_array *a,int nd,const ln_intp *shape)
{
    if(!a||a->nd!=nd)return 0;
    for(int d=0;d<nd;++d)if(a->dimensions[d]!=shape[d])return 0;
    return 1;
}

static int
copy_cast(const ln_array *src,ln_array *dst,ln_error *err)
{
    if(!can_cast_same_kind(src->descr,dst->descr)){
        merr(err,"Cannot cast matmul output to requested dtype with casting rule 'same_kind'");return -1;
    }
    if(!(dst->flags&LN_ARRAY_WRITEABLE)){merr(err,"output array is not writeable");return -1;}
    ln_intp total=ln_array_size(src);
    if(total==0)return 0;
    if(src->nd==0)return ln_cast_strided_numeric(src->data,0,src->descr,dst->data,0,dst->descr,1,err);
    ln_intp coord[LN_MAXDIMS]={0};
    for(ln_intp i=0;i<total;++i){
        const char *sp=src->data;char *dp=dst->data;
        for(int d=0;d<src->nd;++d){sp+=coord[d]*src->strides[d];dp+=coord[d]*dst->strides[d];}
        if(ln_cast_strided_numeric(sp,0,src->descr,dp,0,dst->descr,1,err)<0)return -1;
        advance_batch(src->nd,src->dimensions,coord);
    }
    return 0;
}

ln_array *
ln_matmul(const ln_array *a,const ln_array *b,ln_error *err)
{
    ln_matmul_plan p;
    if(build_plan(a,b,&p,err)<0)return NULL;
    const ln_dtype *dt=ln_promote_dtype(a->descr,b->descr);
    if(!dt){merr(err,"matmul dtype resolution failed");return NULL;}
    ln_array *out=ln_array_new(p.out_nd,p.out_nd?p.out_shape:NULL,dt,0,0,err);
    if(!out)return NULL;
    set_output_strides(out,&p);
    if(execute_matmul(a,b,&p,out,err)<0){ln_array_free(out);return NULL;}
    return out;
}

int
ln_matmul_into(const ln_array *a,const ln_array *b,ln_array *out,ln_error *err)
{
    if(!out){merr(err,"invalid matmul output");return -1;}
    ln_matmul_plan p;
    if(build_plan(a,b,&p,err)<0)return -1;
    if(!shape_matches(out,p.out_nd,p.out_shape)){
        merr(err,"non-broadcastable output operand does not match the matmul result shape");return -1;
    }
    /* COPY_IF_OVERLAP semantics: always form the resolved result separately,
     * then cast/write back into the exact output view. */
    ln_array *tmp=ln_matmul(a,b,err);
    if(!tmp)return -1;
    int rc=copy_cast(tmp,out,err);
    ln_array_free(tmp);
    return rc;
}
