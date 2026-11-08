/* Native weighted average, NumPy _core/_methods.py / _function_base_impl.py
 * semantics for numeric ndarrays. Weight handling is intentionally strict:
 * mismatched weights require exactly one specified axis. */
#include "ln_average.h"
#include "ln_dtype_transfer.h"
#include "ln_complex.h"
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

typedef struct {long double nre,nim, dre,dim;} average_acc;
static void avg_error(ln_error *e, const char *s) {
    if(e) snprintf(e->message,sizeof(e->message),"%s",s);
}
static void avg_next(int nd,const ln_intp *dim,ln_intp *pos){
    for(int j=nd-1;j>=0;j--){if(++pos[j]<dim[j])return;pos[j]=0;}
}
static int avg_read(const char *src,const ln_dtype *dt,ln_clongdouble *dst,ln_error *err){
    if(dt->kind=='c')
        return ln_cast_strided_numeric(src,0,dt,(char*)dst,0,ln_dtype_by_num(LN_CLONGDOUBLE),1,err);
    long double x=0;
    if(ln_cast_strided_numeric(src,0,dt,(char*)&x,0,ln_dtype_by_num(LN_LONGDOUBLE),1,err)<0)return -1;
    dst->real=x;dst->imag=0;return 0;
}
static int avg_write(char *dst,const ln_dtype *dt,ln_clongdouble value,ln_error *err){
    if(dt->kind=='c')return ln_cast_strided_numeric((const char*)&value,0,ln_dtype_by_num(LN_CLONGDOUBLE),dst,0,dt,1,err);
    return ln_cast_strided_numeric((const char*)&value.real,0,ln_dtype_by_num(LN_LONGDOUBLE),dst,0,dt,1,err);
}
ln_array *ln_average(const ln_array *a,const ln_array *weights,
    const uint8_t *axes,int keepdims,ln_array **sum_of_weights,ln_error *err){
    if(sum_of_weights)*sum_of_weights=NULL;
    if(!a||!a->descr){avg_error(err,"average requires an array");return NULL;}
    const char kind=a->descr->kind;
    if(kind!='b'&&kind!='i'&&kind!='u'&&kind!='f'&&kind!='c'){
        avg_error(err,"average requires numeric arrays");return NULL;
    }
    if(weights){char wk=weights->descr->kind;
        if(wk!='b'&&wk!='i'&&wk!='u'&&wk!='f'&&wk!='c'){
            avg_error(err,"weights must have numeric dtype");return NULL;
        }
    }
    int reduced=0,oneaxis=-1;int nd=0;ln_intp dims[LN_MAXDIMS];
    for(int d=0;d<a->nd;d++){
        if(axes[d]){reduced++;oneaxis=d;if(keepdims)dims[nd++]=1;}
        else dims[nd++]=a->dimensions[d];
    }
    /* NumPy rejects weights with another shape unless one axis is selected. */
    int matched=1,weight_1d=0,weight_scalar=0;
    if(weights){
        matched=(weights->nd==a->nd);
        if(matched)for(int d=0;d<a->nd;d++){
            if(weights->dimensions[d]!=a->dimensions[d]){matched=0;break;}
        }
        if(!matched && reduced==0 && weights->nd==0){matched=1;weight_scalar=1;}
        if(!matched){
            if(reduced!=1||weights->nd!=1||weights->dimensions[0]!=a->dimensions[oneaxis]){
                avg_error(err,"weights shape incompatible with data and selected axis");return NULL;
            }
            weight_1d=1;
        }
    }
    if(weight_scalar){
        ln_clongdouble scalar_weight={0,0};
        if(avg_read(weights->data,weights->descr,&scalar_weight,err)<0)return NULL;
        if(scalar_weight.real==0.0L&&scalar_weight.imag==0.0L){
            avg_error(err,"weights sum to zero");return NULL;
        }
    }
    const ln_dtype *dt;
    if(!weights){
        dt=(kind=='b'||kind=='i'||kind=='u')?ln_dtype_by_num(LN_DOUBLE):a->descr;
    }else{
        const ln_dtype *base=(kind=='b'||kind=='i'||kind=='u')?ln_dtype_by_num(LN_DOUBLE):a->descr;
        dt=ln_promote_dtype(base,weights->descr);
    }
    if(!dt||!(dt->kind=='f'||dt->kind=='c')){
        avg_error(err,"unsupported average result dtype");return NULL;
    }
    ln_array *result=ln_array_new(nd,dims,dt,0,0,err);
    if(!result)return NULL;
    ln_array *wsum=NULL;
    if(sum_of_weights){wsum=ln_array_new(nd,dims,dt,0,0,err);
        if(!wsum){ln_array_free(result);return NULL;}
    }
    ln_intp nout=ln_array_size(result),total=ln_array_size(a);
    /* np.average without weights computes a reduction count from the
     * resulting array size; an empty output raises division-by-zero. */
    if(!weights && nout==0){avg_error(err,"division by zero");goto fail;}
    if(nout<0||total<0||(uintmax_t)nout>SIZE_MAX/sizeof(average_acc)){
        avg_error(err,"average output too large");goto fail;
    }
    average_acc *slots=(average_acc*)calloc((size_t)(nout?nout:1),sizeof(*slots));
    if(!slots){avg_error(err,"average allocation failed");goto fail;}
    ln_intp coord[LN_MAXDIMS]={0};
    for(ln_intp i=0;i<total;i++){
        const char *ap=a->data,*wp=weights?weights->data:NULL;
        size_t out_i=0;int out_axis=0;
        for(int d=0;d<a->nd;d++){
            ap+=coord[d]*a->strides[d];
            if(weights){
                if(weight_scalar){ /* scalar weight: same at every position */ }
                else if(weight_1d){if(d==oneaxis)wp+=coord[d]*weights->strides[0];}
                else wp+=coord[d]*weights->strides[d];
            }
            if(!axes[d]){out_i=out_i*(size_t)dims[out_axis]+(size_t)coord[d];out_axis++;}
            else if(keepdims)out_i*= (size_t)dims[out_axis++];
        }
        ln_clongdouble av={0,0},w={1,0};
        if(avg_read(ap,a->descr,&av,err)<0 ||
            (weights&&avg_read(wp,weights->descr,&w,err)<0)){
            free(slots);goto fail;
        }
        average_acc *p=&slots[out_i];
        p->nre+=av.real*w.real-av.imag*w.imag;
        p->nim+=av.real*w.imag+av.imag*w.real;
        p->dre+=w.real;p->dim+=w.imag;
        avg_next(a->nd,a->dimensions,coord);
    }
    for(ln_intp i=0;i<nout;i++){
        average_acc *p=&slots[i];
        if(weights&&p->dre==0.0L&&p->dim==0.0L){
            avg_error(err,"weights sum to zero");free(slots);goto fail;
        }
        long double den=p->dre*p->dre+p->dim*p->dim;
        ln_clongdouble avg={0,0},sw={p->dre,p->dim};
        if(den==0){avg.real=NAN;avg.imag=dt->kind=='c'?NAN:0;}
        else{
            avg.real=(p->nre*p->dre+p->nim*p->dim)/den;
            avg.imag=(p->nim*p->dre-p->nre*p->dim)/den;
        }
        if(avg_write(result->data+(size_t)i*dt->elsize,dt,avg,err)<0||
           (wsum&&avg_write(wsum->data+(size_t)i*dt->elsize,dt,sw,err)<0)){
            free(slots);goto fail;
        }
    }
    free(slots);
    if(sum_of_weights)*sum_of_weights=wsum;
    return result;
fail:
    ln_array_free(wsum);ln_array_free(result);return NULL;
}
