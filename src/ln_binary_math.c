#include "ln_binary_math.h"
#include "ln_half.h"
#include "ln_string.h"
#include <limits.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* NumPy 2.5.3 generate_umath.py signatures, loops_modulo.dispatch.c.src
 * integer fmod and loops.c.src half/real fmod. NumPy BSD attribution is
 * retained in THIRD_PARTY_NUMPY_LICENSE.txt. */
static ln_ufunc_loop fmod_methods[14],power_methods[4];
static const ln_dtype *fmod_types[14];
static ln_ufunc functions[2];
static int ready;

#define INT_MOD(NUM,T,SIGNED) \
case NUM:{T a,b,z;memcpy(&a,pa,sizeof a);memcpy(&b,pb,sizeof b); \
    z=b==0||((SIGNED)&&b==(T)-1)?0:(T)(a%b); \
    memcpy(dst,&z,sizeof z);break;}
#define REAL_MOD(NUM,T,FUNC) \
case NUM:{T a,b,z;memcpy(&a,pa,sizeof a);memcpy(&b,pb,sizeof b); \
    z=FUNC(a,b);memcpy(dst,&z,sizeof z);break;}
static void fmod_loop(char **args,const ln_intp *dims,const ln_intp *strides,void *data)
{
    const ln_dtype *dt=data;
    for(ln_intp i=0;i<dims[0];++i){
        const char *pa=args[0]+i*strides[0],*pb=args[1]+i*strides[1];
        char *dst=args[2]+i*strides[2];
        switch(dt->type_num){
        INT_MOD(LN_BYTE,int8_t,1)
        INT_MOD(LN_UBYTE,uint8_t,0)
        INT_MOD(LN_SHORT,int16_t,1)
        INT_MOD(LN_USHORT,uint16_t,0)
        INT_MOD(LN_INT,int32_t,1)
        INT_MOD(LN_UINT,uint32_t,0)
        INT_MOD(LN_LONG,long,1)
        INT_MOD(LN_ULONG,unsigned long,0)
        INT_MOD(LN_LONGLONG,long long,1)
        INT_MOD(LN_ULONGLONG,unsigned long long,0)
        REAL_MOD(LN_FLOAT,float,fmodf)
        REAL_MOD(LN_DOUBLE,double,fmod)
        REAL_MOD(LN_LONGDOUBLE,long double,fmodl)
        case LN_HALF:{ln_half a,b,z;memcpy(&a,pa,sizeof a);memcpy(&b,pb,sizeof b);
            z=ln_float_to_half(fmodf(ln_half_to_float(a),ln_half_to_float(b)));
            memcpy(dst,&z,sizeof z);break;}
        default:break;
        }
    }
}
#undef INT_MOD
#undef REAL_MOD

static int resolve(const ln_ufunc *u,const ln_array *const *inputs,
                   const ln_ufunc_loop **method,ln_error *err)
{
    for(size_t k=0;k<u->nloops;++k){
        const ln_dtype *dt=ln_dtype_default_descr(u->loops[k].classes[0]);
        int fits=1;
        for(int i=0;i<2;++i){
            const ln_dtype *p=ln_promote_dtype(inputs[i]->descr,dt);
            if(!p||p->cls!=dt->cls){fits=0;break;}
        }
        if(fits){*method=&u->loops[k];return 0;}
    }
    if(err)snprintf(err->message,sizeof err->message,
                   "ufunc '%s' has no safely castable numeric signature",u->name);
    return -1;
}

static void initialize(void)
{
    if(ready)return;
    const ln_dtype_num ints_reals[]={LN_BYTE,LN_UBYTE,LN_SHORT,LN_USHORT,
        LN_INT,LN_UINT,LN_LONG,LN_ULONG,LN_LONGLONG,LN_ULONGLONG,
        LN_HALF,LN_FLOAT,LN_DOUBLE,LN_LONGDOUBLE};
    const ln_dtype_num powers[]={LN_DOUBLE,LN_LONGDOUBLE,LN_CDOUBLE,LN_CLONGDOUBLE};
    for(int i=0;i<14;++i){
        const ln_dtype *dt=ln_dtype_by_num(ints_reals[i]);fmod_types[i]=dt;
        for(int j=0;j<3;++j)fmod_methods[i].classes[j]=dt->cls;
        fmod_methods[i].loop=fmod_loop;fmod_methods[i].data=(void *)fmod_types[i];
    }
    for(int i=0;i<4;++i){
        const ln_dtype *dt=ln_dtype_by_num(powers[i]);
        for(int j=0;j<3;++j)power_methods[i].classes[j]=dt->cls;
        power_methods[i].loop=ln_get_binary_loop(LN_OP_POWER,dt->type_num);
    }
    functions[0]=(ln_ufunc){"fmod",2,1,fmod_methods,14,resolve};
    functions[1]=(ln_ufunc){"float_power",2,1,power_methods,4,resolve};
    ready=1;
}
const ln_ufunc *ln_binary_math_by_name(const char *name)
{
    initialize();if(!name)return NULL;
    for(int i=0;i<2;++i)if(strcmp(name,functions[i].name)==0)return &functions[i];
    return NULL;
}
size_t ln_binary_math_count(void){return 2;}

typedef struct { const ln_dtype_descr *a,*b,*out; } string_add_context;
static int string_add_descrs(const ln_ufunc *u,const ln_ufunc_loop *method,
        const ln_array *const *inputs,const ln_dtype_descr **descrs,ln_error *err)
{
    (void)u;(void)method;
    const ln_dtype_descr *a=inputs[0]->descr,*b=inputs[1]->descr;
    if(b->elsize>(size_t)INT_MAX||a->elsize>(size_t)INT_MAX-b->elsize){
        if(err)snprintf(err->message,sizeof err->message,"addition result string is too large");
        return -1;
    }
    int unicode=a->type_num==LN_UNICODE;
    size_t na=ln_string_nchars(a),nb=ln_string_nchars(b);
    descrs[0]=ln_string_make_dtype(unicode,na,'=',err);
    descrs[1]=ln_string_make_dtype(unicode,nb,'=',err);
    descrs[2]=ln_string_make_dtype(unicode,na+nb,'=',err);
    return descrs[0]&&descrs[1]&&descrs[2]?0:-1;
}
static int string_add_data(const ln_ufunc_loop *method,
        const ln_dtype_descr *const *descrs,void **result,ln_error *err)
{
    (void)method;
    string_add_context *ctx=malloc(sizeof *ctx);
    if(!ctx){if(err)snprintf(err->message,sizeof err->message,"out of memory");return -1;}
    *ctx=(string_add_context){descrs[0],descrs[1],descrs[2]};*result=ctx;return 0;
}
static void string_add_loop(char **args,const ln_intp *dims,const ln_intp *strides,void *data)
{
    const string_add_context *ctx=data;
    for(ln_intp i=0;i<dims[0];++i)
        ln_string_add_one(args[0]+i*strides[0],ctx->a,args[1]+i*strides[1],ctx->b,
                          args[2]+i*strides[2],ctx->out,NULL);
}
void ln_binary_math_string_add_method(ln_ufunc_loop *method,int unicode_kind)
{
    const ln_dtype_descr *dt=ln_string_default_dtype(unicode_kind);
    for(int i=0;i<3;++i)method->classes[i]=dt->cls;
    method->loop=string_add_loop;method->resolve_descrs=string_add_descrs;
    method->resolve_loop_data=string_add_data;method->free_loop_data=free;
}
