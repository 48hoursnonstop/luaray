/* Logical/count reductions, written for LuaRay's strided ndarray engine.
 * NumPy 2.5.3 np.any, np.all, np.count_nonzero semantics, no Python runtime. */
#include "ln_truth.h"
#include "ln_dtype_transfer.h"
#include "ln_complex.h"
#include "ln_half.h"
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <limits.h>

static void truth_error(ln_error *e, const char *msg) {
    if(e) snprintf(e->message,sizeof(e->message),"%s",msg);
}
/* Exact truthiness: integer/complex checks never round through double. */
static int truth_scalar(const char *src,const ln_dtype *dt,int *valid) {
#define TEST(T) do { T v; memcpy(&v,src,sizeof(v));return v!=0; }while(0)
    *valid=1;
    switch(dt->type_num) {
    case LN_BOOL: case LN_UBYTE: TEST(uint8_t);
    case LN_BYTE: TEST(int8_t);
    case LN_SHORT: TEST(int16_t);
    case LN_USHORT: TEST(uint16_t);
    case LN_INT: TEST(int32_t);
    case LN_UINT: TEST(uint32_t);
    case LN_LONG: TEST(long);
    case LN_ULONG: TEST(unsigned long);
    case LN_LONGLONG: TEST(long long);
    case LN_ULONGLONG: TEST(unsigned long long);
    case LN_HALF: {ln_half v;memcpy(&v,src,sizeof(v));return ln_half_to_float(v)!=0;}
    case LN_FLOAT: TEST(float);
    case LN_DOUBLE: TEST(double);
    case LN_LONGDOUBLE: TEST(long double);
    case LN_CFLOAT: {ln_cfloat v;memcpy(&v,src,sizeof(v));return v.real!=0||v.imag!=0;}
    case LN_CDOUBLE: {ln_cdouble v;memcpy(&v,src,sizeof(v));return v.real!=0||v.imag!=0;}
    case LN_CLONGDOUBLE: {ln_clongdouble v;memcpy(&v,src,sizeof(v));return v.real!=0||v.imag!=0;}
    case LN_STRING: {
        for(size_t k=0;k<dt->elsize;k++)if(src[k])return 1;
        return 0;
    }
    case LN_UNICODE: {
        for(size_t k=0;k+sizeof(uint32_t)<=dt->elsize;k+=sizeof(uint32_t)) {
            uint32_t cp;memcpy(&cp,src+k,sizeof(cp));if(cp)return 1;
        }
        return 0;
    }
    case LN_DATETIME: case LN_TIMEDELTA: TEST(int64_t);
    default:*valid=0;return 0;
    }
#undef TEST
}
static void advance_coords(int nd,const ln_intp *dims,ln_intp *pos) {
    for(int d=nd-1;d>=0;--d){if(++pos[d]<dims[d])return;pos[d]=0;}
}
ln_array *ln_truth_reduce(const ln_array *a,const uint8_t *axis_flags,
    int keepdims,const ln_array *where,int kind,ln_array *out,ln_error *err) {
    if(!a||!a->descr||kind<0||kind>2){truth_error(err,"invalid logical reduction");return NULL;}
    /* Do not inspect a->data to validate a dtype: zero-length inputs may
     * have no elements, and parametric strings can be arbitrarily wide. */
    if(!strchr("biufcSUMm",a->descr->kind)) {
        truth_error(err,"unsupported dtype for logical reduction");return NULL;
    }
    uint8_t flags[LN_MAXDIMS]={0};
    for(int d=0;d<a->nd;d++)flags[d]=axis_flags?axis_flags[d]:1;
    int ond=0;ln_intp odims[LN_MAXDIMS]={0};
    for(int d=0;d<a->nd;d++){
        if(flags[d]){if(keepdims)odims[ond++]=1;}
        else odims[ond++]=a->dimensions[d];
    }
    ln_intp nout=1;
    for(int d=0;d<ond;d++){
        if(ln_mul_sizes_with_overflow(&nout,nout,odims[d])){
            truth_error(err,"logical reduction output too large");return NULL;
        }
    }
    if(out){
        if(out->nd!=ond||!(out->flags&LN_ARRAY_WRITEABLE)){
            truth_error(err,"output must be writeable and have the correct shape");return NULL;
        }
        for(int d=0;d<ond;d++)if(out->dimensions[d]!=odims[d]){
            truth_error(err,"output has incorrect shape");return NULL;
        }
        if(kind==2){truth_error(err,"count_nonzero does not accept out");return NULL;}
    }
    ln_intp ws[LN_MAXDIMS]={0};
    if(where){
        if(!where->descr||where->descr->type_num!=LN_BOOL){
            truth_error(err,"where must have boolean dtype");return NULL;
        }
        if(ln_broadcast_strides(a->nd,a->dimensions,where->nd,
           where->dimensions,where->strides,"where",ws,err)<0)return NULL;
    }
    const ln_dtype *dt=(kind==2?ln_dtype_by_name("int64"):ln_dtype_by_num(LN_BOOL));
    ln_array *res=ln_array_new(ond,odims,dt,0,1,err);
    if(!res)return NULL;
    if(kind==1){for(ln_intp i=0;i<nout;i++)res->data[i]=1;}
    ln_intp n=ln_array_size(a);
    if(n<0){ln_array_free(res);truth_error(err,"input too large");return NULL;}
    ln_intp pos[LN_MAXDIMS]={0};
    for(ln_intp i=0;i<n;i++){
        const char *ip=a->data,*wp=where?where->data:NULL;
        ln_intp oi=0;
        for(int d=0;d<a->nd;d++){
            ip+=pos[d]*a->strides[d];
            if(where)wp+=pos[d]*ws[d];
            if(flags[d]){if(keepdims)oi*=1;}
            else oi=oi*a->dimensions[d]+pos[d];
        }
        if(!where||*(const uint8_t*)wp){
            int ok=0,b=truth_scalar(ip,a->descr,&ok);
            if(!ok){truth_error(err,"unsupported scalar dtype");ln_array_free(res);return NULL;}
            if(kind==0){if(b)res->data[oi]=1;}
            else if(kind==1){if(!b)res->data[oi]=0;}
            else if(b){
                int64_t c;memcpy(&c,res->data+(size_t)oi*8,8);
                if(c==INT64_MAX){truth_error(err,"count_nonzero overflow");ln_array_free(res);return NULL;}
                ++c;memcpy(res->data+(size_t)oi*8,&c,8);
            }
        }
        advance_coords(a->nd,a->dimensions,pos);
    }
    if(out){
        ln_intp coords[LN_MAXDIMS]={0};
        for(ln_intp i=0;i<nout;i++){
            char *dst=out->data;
            for(int d=0;d<ond;d++)dst+=coords[d]*out->strides[d];
            if(ln_cast_strided_numeric(res->data+(size_t)i*dt->elsize,0,
                dt,dst,0,out->descr,1,err)<0){ln_array_free(res);return NULL;}
            advance_coords(ond,odims,coords);
        }
    }
    return res;
}
