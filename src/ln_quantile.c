/* Native quantiles using strided input traversal and a per-slice ordering.
 * Only numeric real/bool dtypes; no Python runtime. Sorting never alters input. */
#include "ln_quantile.h"
#include "ln_dtype_transfer.h"
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <math.h>
#include <stdio.h>

typedef struct { long double v; const char *source; } qitem;
static void qerr(ln_error *e, const char *s){ if(e)snprintf(e->message,sizeof(e->message),"%s",s); }
static int qcompare(const void *a,const void *b){
    long double x=((const qitem*)a)->v, y=((const qitem*)b)->v;
    if(isnan(x))return isnan(y)?0:1;
    if(isnan(y))return -1;
    return (x>y)-(x<y);
}
static void advance(int nd,const ln_intp*dims,ln_intp *c){
    for(int i=nd-1;i>=0;i--){ if(++c[i]<dims[i])return; c[i]=0; }
}
static int shape_matches(const ln_array *a,int nd,const ln_intp *dims){
    if(!a || a->nd!=nd || !(a->flags&LN_ARRAY_WRITEABLE))return 0;
    for(int d=0;d<nd;d++)if(a->dimensions[d]!=dims[d])return 0;
    return 1;
}
ln_array *ln_quantile(const ln_array *a,const uint8_t *axis_flags,
    int keepdims,const double *q,ln_intp nq,int scalar_q,
    int method,const ln_dtype *preferred_dtype,ln_array *out,int omit_nan,ln_error *err){
    if(!a||!a->descr||!q || nq<1){qerr(err,"invalid quantile inputs");return NULL;}
    char kind=a->descr->kind;
    if(kind!='b'&&kind!='i'&&kind!='u'&&kind!='f'){
        qerr(err,"quantile currently supports real numeric arrays only");return NULL;
    }
    if(method<0 || method>7){qerr(err,"unsupported quantile method");return NULL;}
    if(kind=='b'&&(method==0||method==4) && (!omit_nan || ln_array_size(a)!=0)){
        qerr(err,"boolean quantiles require a discontinuous method");return NULL;
    }
    for(ln_intp k=0;k<nq;k++)if(!isfinite(q[k]) || q[k]<0 || q[k]>1){
        qerr(err,"quantiles must be within [0, 1] and finite");return NULL;
    }
    uint8_t red[LN_MAXDIMS]={0};
    int unred_nd=0,reduce_nd=0; ln_intp red_size=1,output_base=1;
    ln_intp odims[LN_MAXDIMS]={0};int ond=0;
    for(int d=0;d<a->nd;d++){
        red[d]=axis_flags?axis_flags[d]:1;
        if(red[d]){
            reduce_nd++;
            if(ln_mul_sizes_with_overflow(&red_size,red_size,a->dimensions[d])){qerr(err,"reduction too large");return NULL;}
            if(keepdims)odims[ond++]=1;
        }else{
            unred_nd++;
            odims[ond++]=a->dimensions[d];
            if(ln_mul_sizes_with_overflow(&output_base,output_base,a->dimensions[d])){qerr(err,"result too large");return NULL;}
        }
    }
    if(!omit_nan && reduce_nd>1 && ln_array_size(a)==0 && (method!=6 || output_base==0)){
        qerr(err,"empty multi-axis quantile reduction is unsupported by NumPy");return NULL;
    }
    if(!omit_nan && reduce_nd==0 && ln_array_size(a)==0){
        qerr(err,"cannot compute quantile with no reduced axes on empty input");return NULL;
    }
    if(!omit_nan && red_size==0 && output_base>0 && method!=6){qerr(err,"cannot compute quantile from empty reduction");return NULL;}
    if(red_size<0 || (uintmax_t)red_size > SIZE_MAX/sizeof(qitem)){
        qerr(err,"reduction too large");return NULL;
    }
    int emit_q_axis = !scalar_q && !(omit_nan && ln_array_size(a)==0);
    if(emit_q_axis){
        if(ond>=LN_MAXDIMS){qerr(err,"too many output dimensions");return NULL;}
        memmove(odims+1,odims,(size_t)ond*sizeof(*odims));odims[0]=nq;ond++;
    }
    if(out&&!shape_matches(out,ond,odims)){qerr(err,"out has wrong shape or is not writeable");return NULL;}
    int discrete=(method==1||method==2||method==3||method==5||method==7);
    const ln_dtype *dt=(omit_nan && ln_array_size(a)==0)
         ? (kind=='f'?a->descr:ln_dtype_by_num(LN_DOUBLE))
         : (discrete ? a->descr : (kind=='f'?a->descr:ln_dtype_by_num(LN_DOUBLE)));
    if(!discrete && preferred_dtype && !(omit_nan && ln_array_size(a)==0)){
        /* NumPy's nanquantile chooses the dtype of the first reduced slice:
           an all-NaN first slice uses the input floating type, even when
           vector q would ordinarily promote the result. */
        int first_all_nan=0;
        if(omit_nan && kind=='f' && output_base>0 && red_size>0){
            first_all_nan=1;
            ln_intp scan_coord[LN_MAXDIMS]={0};
            ln_intp scan_dims[LN_MAXDIMS]={0};int nr=0;
            for(int d=0;d<a->nd;d++)if(red[d])scan_dims[nr++]=a->dimensions[d];
            for(ln_intp k=0;k<red_size;k++){
                const char *at=a->data;int j=0;
                for(int d=0;d<a->nd;d++)if(red[d])at+=scan_coord[j++]*a->strides[d];
                long double v;
                if(ln_cast_strided_numeric(at,0,a->descr,(char*)&v,0,
                    ln_dtype_by_num(LN_LONGDOUBLE),1,err)<0)return NULL;
                if(!isnan(v)){first_all_nan=0;break;}
                advance(nr,scan_dims,scan_coord);
            }
        }
        if(!first_all_nan)dt=preferred_dtype;
    }
    ln_array *res=ln_array_new(ond,odims,dt,0,0,err);
    if(!res)return NULL;
    qitem *items=(qitem *)malloc((size_t)(red_size?red_size:1)*sizeof(*items));
    if(!items){qerr(err,"out of memory");ln_array_free(res);return NULL;}
    int keep_axes[LN_MAXDIMS]={0},nkeep=0,red_axes[LN_MAXDIMS]={0},nred=0;
    ln_intp outer_dims[LN_MAXDIMS]={0}, inner_dims[LN_MAXDIMS]={0};
    for(int d=0;d<a->nd;d++){
        if(red[d]){red_axes[nred]=d;inner_dims[nred++]=a->dimensions[d];}
        else{keep_axes[nkeep]=d;outer_dims[nkeep++]=a->dimensions[d];}
    }
    /* a scalar reduction (no selected axes) is a one-element slice. */
    ln_intp outer_coord[LN_MAXDIMS]={0};
    int failed=0;
    for(ln_intp row=0;row<output_base&&!failed;row++){
        const char *base=a->data;
        for(int d=0;d<nkeep;d++)base+=outer_coord[d]*a->strides[keep_axes[d]];
        ln_intp inner_coord[LN_MAXDIMS]={0};
        ln_intp valid_size=0;
        for(ln_intp i=0;i<red_size;i++){
            const char *p=base;
            for(int d=0;d<nred;d++)p+=inner_coord[d]*a->strides[red_axes[d]];
            items[valid_size].source=p;
            if(ln_cast_strided_numeric(p,0,a->descr,(char*)&items[valid_size].v,0,
                   ln_dtype_by_num(LN_LONGDOUBLE),1,err)<0){failed=1;break;}
            if(!omit_nan || !isnan(items[valid_size].v))valid_size++;
            advance(nred,inner_dims,inner_coord);
        }
        if(failed)break;
        qsort(items,(size_t)valid_size,sizeof(*items),qcompare);
        for(ln_intp qi=0;qi<(emit_q_axis?nq:1);qi++){
            /* Quantile scalar result is stored after the leading q axis, if any. */
            ln_intp coord[LN_MAXDIMS]={0};int j=0;
            if(emit_q_axis)coord[j++]=qi;
            for(int d=0;d<a->nd;d++){
                if(red[d]){if(keepdims)coord[j++]=0;}
                else{
                    int at=0;while(keep_axes[at]!=d)at++;
                    coord[j++]=outer_coord[at];
                }
            }
            char *dst=res->data;
            for(int d=0;d<ond;d++)dst+=coord[d]*res->strides[d];
            if(valid_size==0){
                long double nan_value=NAN;
                if(ln_cast_strided_numeric((const char*)&nan_value,0,
                      ln_dtype_by_num(LN_LONGDOUBLE),dst,0,dt,1,err)<0){failed=1;break;}
                continue;
            }
            double r=(double)(valid_size-1)*q[qi];
            ln_intp lo=(ln_intp)floor(r),hi=(ln_intp)ceil(r),pick=lo;
            if(method==2)pick=hi;
            if(method==3)pick=(ln_intp)nearbyint(r); /* ties to even */
            if(method==5){pick=(ln_intp)ceil(q[qi]*(double)valid_size)-1;if(pick<0)pick=0;}
            if(discrete){
                /* NumPy propagates NaN even for discontinuous methods. */
                if(isnan(items[valid_size-1].v))pick=valid_size-1;
                memcpy(dst,items[pick].source,dt->elsize);
            }else{
                long double a0=items[lo].v,a1=items[hi].v,value;
                if(isnan(items[valid_size-1].v))value=NAN;
                else if(method==4) value=(a0+a1)/2.0;
                else {
                    double t=r-(double)lo;
                    /* Preserve exact sampled values, including infinities. */
                    value=(lo==hi)?a0:(t<=0?a0:(t>=1?a1:(a0+(a1-a0)*t)));
                }
                if(ln_cast_strided_numeric((const char*)&value,0,ln_dtype_by_num(LN_LONGDOUBLE),
                         dst,0,dt,1,err)<0){failed=1;break;}
            }
        }
        advance(nkeep,outer_dims,outer_coord);
    }
    free(items);
    if(failed){ln_array_free(res);return NULL;}
    if(out){
        ln_intp coord[LN_MAXDIMS]={0};ln_intp total=ln_array_size(res);
        for(ln_intp i=0;i<total;i++){
            const char *src=res->data;char *dst=out->data;
            for(int d=0;d<ond;d++){
                src+=coord[d]*res->strides[d];dst+=coord[d]*out->strides[d];
            }
            if(ln_cast_strided_numeric(src,0,dt,dst,0,out->descr,1,err)<0){
                ln_array_free(res);return NULL;
            }
            advance(ond,odims,coord);
        }
    }
    return res;
}
