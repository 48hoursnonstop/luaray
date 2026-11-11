#include "ln_time_scale.h"
#include "ln_datetime.h"
#include <math.h>
#include <stdio.h>
#include <string.h>

/* Source: NumPy2.5.3 loops.c.src TIMEDELTA_md_m_{multiply,divide} and
 * TIMEDELTA_dm_m_multiply. Floating scaling is a required round dependency.
 * Integer multiplication uses its separate int64 signature and overflow rules.
 * Integer division and duration ratios use their own loops below.
 * NumPy BSD attribution is retained. */
typedef struct {int temporal,divide;} operation;
static operation operations[]={{0,0},{1,0},{0,1}};
static void scale_loop(char **args,const ln_intp *dims,const ln_intp *strides,void *data)
{
    const operation *op=data;int ti=op->temporal,ni=1-ti;
    for(ln_intp i=0;i<dims[0];++i){
        int64_t ticks,out;double factor;
        memcpy(&ticks,args[ti]+i*strides[ti],8);
        memcpy(&factor,args[ni]+i*strides[ni],8);
        if(ticks==LN_DATETIME_NAT)out=LN_DATETIME_NAT;
        else{
            double result=op->divide?(double)ticks/factor:(double)ticks*factor;
            /* Explicit x86 source cast result without float-to-int UB. */
            out=!isfinite(result)||result>=0x1p63||result< -0x1p63?LN_DATETIME_NAT:(int64_t)result;
        }
        memcpy(args[2]+i*strides[2],&out,8);
    }
}
static int descriptors(const ln_ufunc *u,const ln_ufunc_loop *method,
        const ln_array *const *inputs,const ln_dtype_descr **descrs,ln_error *err)
{
    (void)u;(void)err;const operation *op=method->data;int ti=op->temporal;
    descrs[ti]=inputs[ti]->descr;descrs[1-ti]=ln_dtype_by_num(LN_DOUBLE);
    descrs[2]=inputs[ti]->descr;return 0;
}
void ln_time_scale_method(ln_ufunc_loop *method,int temporal_index,int divide)
{
    int ti=temporal_index;
    method->classes[ti]=method->classes[2]=ln_datetime_dtype_class(1);
    method->classes[1-ti]=ln_dtype_class_by_num(LN_DOUBLE);
    method->loop=scale_loop;method->data=&operations[divide?2:ti];
    method->resolve_descrs=descriptors;
}
static int integer_axes[]={0,1};
static int validate_integer_multiply(char **args,const ln_intp *dims,const ln_intp *strides,
        const uint8_t *mask,ln_intp mask_step,void *data,ln_error *err)
{
    int ti=*(const int*)data;
    for(ln_intp i=0;i<dims[0];++i){
        if(mask&&!mask[i*mask_step])continue;
        int64_t ticks,factor,result=0;
        memcpy(&ticks,args[ti]+i*strides[ti],8);
        memcpy(&factor,args[1-ti]+i*strides[1-ti],8);
        if(ticks==LN_DATETIME_NAT)continue;
#if defined(__GNUC__)
        int overflow=__builtin_mul_overflow(ticks,factor,&result);
#else
        int overflow=ticks>0?(factor>0?ticks>INT64_MAX/factor:factor<INT64_MIN/ticks):
            ticks<0?(factor>0?ticks<INT64_MIN/factor:factor<0&&ticks<INT64_MAX/factor):0;
        if(!overflow)result=ticks*factor;
#endif
        if(overflow||result==LN_DATETIME_NAT){
            if(err){snprintf(err->message,sizeof err->message,"Overflow in timedelta64 * int64 multiplication");err->kind=LN_ERROR_OVERFLOW;}
            return -(int)i-2;
        }
    }
    return 1;
}
static void integer_multiply_loop(char **args,const ln_intp *dims,const ln_intp *strides,void *data)
{
    int ti=*(const int*)data;
    for(ln_intp i=0;i<dims[0];++i){
        int64_t ticks,factor;uint64_t bits;
        memcpy(&ticks,args[ti]+i*strides[ti],8);memcpy(&factor,args[1-ti]+i*strides[1-ti],8);
        bits=ticks==LN_DATETIME_NAT?(uint64_t)LN_DATETIME_NAT:(uint64_t)ticks*(uint64_t)factor;
        memcpy(args[2]+i*strides[2],&bits,8);
    }
}
static int integer_descriptors(const ln_ufunc *u,const ln_ufunc_loop *method,
        const ln_array *const *inputs,const ln_dtype_descr **descrs,ln_error *err)
{
    (void)u;(void)err;int ti=*(const int*)method->data;
    descrs[ti]=descrs[2]=inputs[ti]->descr;descrs[1-ti]=ln_dtype_by_name("int64");return 0;
}
void ln_time_integer_multiply_method(ln_ufunc_loop *method,int ti)
{
    method->classes[ti]=method->classes[2]=ln_datetime_dtype_class(1);
    method->classes[1-ti]=ln_dtype_by_name("int64")->cls;
    method->loop=integer_multiply_loop;method->data=&integer_axes[ti];
    method->validate=validate_integer_multiply;method->validate_data=&integer_axes[ti];
    method->resolve_descrs=integer_descriptors;
}
int ln_time_scale_resolve(const ln_ufunc *u,const ln_array *const *inputs,
                          const ln_ufunc_loop **method,ln_error *err)
{
    if(!strcmp(u->name,"true_divide")&&inputs[0]->descr->kind=='m'&&inputs[1]->descr->kind=='m'){
        for(size_t i=0;i<u->nloops;++i)if(u->loops[i].classes[0]==inputs[0]->descr->cls&&
                u->loops[i].classes[1]==inputs[1]->descr->cls&&u->loops[i].classes[2]==ln_dtype_class_by_num(LN_DOUBLE)){
            *method=&u->loops[i];return 0;
        }
    }
    int ti=inputs[0]->descr->kind=='m'?0:inputs[1]->descr->kind=='m'?1:-1;
    if(ti>=0&&!(ti==1&&strcmp(u->name,"true_divide")==0)){
        const ln_dtype *number=inputs[1-ti]->descr;
        const ln_dtype_class *coefficient=NULL;
        if(number->kind=='f')coefficient=ln_dtype_class_by_num(LN_DOUBLE);
        else if((number->kind=='i'||number->kind=='u'||(number->kind=='b'&&!strcmp(u->name,"multiply"))))
            coefficient=ln_dtype_by_name("int64")->cls;
        if(coefficient){
            for(size_t i=0;i<u->nloops;++i)if(u->loops[i].classes[ti]==inputs[ti]->descr->cls&&
                    u->loops[i].classes[1-ti]==coefficient){
                *method=&u->loops[i];return 0;
            }
        }
    }
    if(err){snprintf(err->message,sizeof err->message,"no matching temporal scaling signature");err->kind=LN_ERROR_TYPE;}
    return -1;
}

/* loops.c.src:TIMEDELTA_mq_m_divide: exact signed integer quotient,
 * truncating toward zero. The only int64 division overflow uses NaT ticks,
 * which are handled before division. */
static void integer_divide_loop(char **args,const ln_intp *dims,const ln_intp *strides,void *data)
{
    (void)data;
    for(ln_intp i=0;i<dims[0];++i){
        int64_t ticks,factor,result;
        memcpy(&ticks,args[0]+i*strides[0],8);memcpy(&factor,args[1]+i*strides[1],8);
        result=ticks==LN_DATETIME_NAT||factor==0?LN_DATETIME_NAT:ticks/factor;
        memcpy(args[2]+i*strides[2],&result,8);
    }
}
static int preserve_completed_casts(char **args,const ln_intp *dims,const ln_intp *strides,
        const uint8_t *mask,ln_intp mask_step,void *data,ln_error *err)
{
    (void)args;(void)dims;(void)strides;(void)mask;(void)mask_step;(void)data;(void)err;
    return 1;
}
void ln_time_integer_divide_method(ln_ufunc_loop *method)
{
    method->classes[0]=method->classes[2]=ln_datetime_dtype_class(1);
    method->classes[1]=ln_dtype_by_name("int64")->cls;
    method->data=&integer_axes[0];method->loop=integer_divide_loop;
    method->validate=preserve_completed_casts;method->resolve_descrs=integer_descriptors;
}
static void ratio_loop(char **args,const ln_intp *dims,const ln_intp *strides,void *data)
{
    (void)data;
    for(ln_intp i=0;i<dims[0];++i){
        int64_t numerator,denominator;double value;
        memcpy(&numerator,args[0]+i*strides[0],8);memcpy(&denominator,args[1]+i*strides[1],8);
        value=numerator==LN_DATETIME_NAT||denominator==LN_DATETIME_NAT?NAN:(double)numerator/(double)denominator;
        memcpy(args[2]+i*strides[2],&value,8);
    }
}
static int ratio_descriptors(const ln_ufunc *u,const ln_ufunc_loop *method,
        const ln_array *const *inputs,const ln_dtype_descr **descrs,ln_error *err)
{
    (void)u;(void)method;
    const ln_dtype *common=ln_common_dtype_descr(inputs[0]->descr,inputs[1]->descr);
    if(!common){if(err){snprintf(err->message,sizeof err->message,"duration ratio units are incompatible");err->kind=LN_ERROR_TYPE;}return -1;}
    descrs[0]=descrs[1]=common;descrs[2]=ln_dtype_by_num(LN_DOUBLE);return 0;
}
void ln_time_ratio_method(ln_ufunc_loop *method)
{
    method->classes[0]=method->classes[1]=ln_datetime_dtype_class(1);
    method->classes[2]=ln_dtype_class_by_num(LN_DOUBLE);
    method->loop=ratio_loop;method->resolve_descrs=ratio_descriptors;
}
