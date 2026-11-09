#include "ln_time_scale.h"
#include "ln_datetime.h"
#include <math.h>
#include <stdio.h>
#include <string.h>

/* Source: NumPy2.5.3 loops.c.src TIMEDELTA_md_m_{multiply,divide} and
 * TIMEDELTA_dm_m_multiply. Floating scaling is a required round dependency.
 * Integer scaling and timedelta ratios have separate signatures, not emulated
 * through float conversion. NumPy BSD attribution is retained. */
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
int ln_time_scale_resolve(const ln_ufunc *u,const ln_array *const *inputs,
                          const ln_ufunc_loop **method,ln_error *err)
{
    int ti=inputs[0]->descr->kind=='m'?0:inputs[1]->descr->kind=='m'?1:-1;
    if(ti>=0&&!(ti==1&&strcmp(u->name,"true_divide")==0)){
        const ln_dtype *number=inputs[1-ti]->descr;
        if(number->kind=='f'){
            for(size_t i=0;i<u->nloops;++i)if(u->loops[i].classes[ti]==inputs[ti]->descr->cls&&
                    u->loops[i].classes[1-ti]==ln_dtype_class_by_num(LN_DOUBLE)){
                *method=&u->loops[i];return 0;
            }
        }
    }
    if(err){snprintf(err->message,sizeof err->message,"no matching temporal scaling signature (floating timedelta scaling only)");err->kind=LN_ERROR_TYPE;}
    return -1;
}
