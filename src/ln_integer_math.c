#include "ln_integer_math.h"
#include "ln_dtype_transfer.h"
#include <limits.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

/* NumPy 2.5.3 generate_umath.py integer signatures,
 * loops_autovec.dispatch.c.src and npy_math_internal.h.src. */
enum bit_operation { BIT_INVERT, BIT_COUNT, BIT_LEFT, BIT_RIGHT, BIT_GCD, BIT_LCM };
typedef struct { const ln_dtype *dtype; enum bit_operation operation; } bit_context;
static ln_ufunc_loop methods[6][11];
static bit_context contexts[6][11];
static ln_ufunc functions[6];
static int ready;

static uint8_t population_count(uint64_t value)
{
#if defined(__GNUC__) || defined(__clang__)
    return (uint8_t)__builtin_popcountll((unsigned long long)value);
#else
    uint8_t count=0;
    while(value){value&=value-1;count++;}
    return count;
#endif
}

/* Arithmetic is done on unsigned representations, including abs(INT_MIN)
 * and signed left shifts. Bounds are checked before any C shift expression.
 * Right-shift sign extension is explicit rather than compiler dependent. */
static uint64_t greatest_common_divisor(uint64_t a,uint64_t b)
{
    while(a){uint64_t previous=a;a=b%a;b=previous;}
    return b;
}
#define INTEGER_ITEM(NUM,T,U,NEGATIVE,B_NEGATIVE) \
case NUM:{ \
    T a,b=0;memcpy(&a,source,sizeof a); \
    if(binary)memcpy(&b,other,sizeof b); \
    const unsigned width=(unsigned)(sizeof(T)*CHAR_BIT); \
    const uint64_t mask=UINT64_MAX>>(64-width); \
    uint64_t bits=(uint64_t)(U)a;int negative=(NEGATIVE); \
    if(ctx->operation==BIT_COUNT){ \
        if(negative)bits=(UINT64_C(0)-bits)&mask; \
        uint8_t result=population_count(bits);memcpy(target,&result,1); \
    }else{ \
        if(ctx->operation==BIT_GCD||ctx->operation==BIT_LCM){ \
            uint64_t left=negative?(UINT64_C(0)-bits)&mask:bits; \
            uint64_t right=(uint64_t)(U)b; \
            if(B_NEGATIVE)right=(UINT64_C(0)-right)&mask; \
            uint64_t gcd=greatest_common_divisor(left,right); \
            bits=ctx->operation==BIT_GCD?gcd:gcd?(left/gcd*right)&mask:0; \
        }else if(ctx->operation==BIT_INVERT)bits=(~bits)&mask; \
        else{ \
            uint64_t count=(uint64_t)(U)b; \
            if(count>=width)bits=ctx->operation==BIT_RIGHT&&negative?mask:0; \
            else if(ctx->operation==BIT_LEFT)bits=(bits<<count)&mask; \
            else{ \
                bits>>=count; \
                if(negative&&count)bits|=mask^(mask>>count); \
            } \
        } \
        U result=(U)bits;memcpy(target,&result,sizeof result); \
    } \
    break; \
}
static void integer_loop(char **args,const ln_intp *dimensions,
                         const ln_intp *steps,void *data)
{
    const bit_context *ctx=data;
    int binary=ctx->operation>=BIT_LEFT;
    for(ln_intp i=0;i<dimensions[0];i++){
        const char *source=args[0]+i*steps[0];
        const char *other=binary?args[1]+i*steps[1]:NULL;
        char *target=args[binary?2:1]+i*steps[binary?2:1];
        switch(ctx->dtype->type_num){
        case LN_BOOL:{uint8_t value,result;memcpy(&value,source,1);result=(uint8_t)!value;memcpy(target,&result,1);break;}
        INTEGER_ITEM(LN_BYTE,int8_t,uint8_t,a<0,b<0)
        INTEGER_ITEM(LN_UBYTE,uint8_t,uint8_t,0,0)
        INTEGER_ITEM(LN_SHORT,int16_t,uint16_t,a<0,b<0)
        INTEGER_ITEM(LN_USHORT,uint16_t,uint16_t,0,0)
        INTEGER_ITEM(LN_INT,int32_t,uint32_t,a<0,b<0)
        INTEGER_ITEM(LN_UINT,uint32_t,uint32_t,0,0)
        INTEGER_ITEM(LN_LONG,long,unsigned long,a<0,b<0)
        INTEGER_ITEM(LN_ULONG,unsigned long,unsigned long,0,0)
        INTEGER_ITEM(LN_LONGLONG,long long,unsigned long long,a<0,b<0)
        INTEGER_ITEM(LN_ULONGLONG,unsigned long long,unsigned long long,0,0)
        default:break;
        }
    }
}
#undef INTEGER_ITEM

static int resolve_integer(const ln_ufunc *u,const ln_array *const *inputs,
                           const ln_ufunc_loop **resolved,ln_error *error)
{
    if(strcmp(u->name,"gcd")==0||strcmp(u->name,"lcm")==0){
        /* Uniform-operation resolution uses common dtype, including aliases,
         * and has no all-Boolean signature. */
        const ln_dtype *dtype=ln_promote_dtype(inputs[0]->descr,inputs[1]->descr);
        if(dtype)for(size_t i=0;i<u->nloops;i++)if(u->loops[i].classes[0]==dtype->cls){
            *resolved=&u->loops[i];return 0;
        }
    }else{
        /* Default resolution first preserves an exact all-input signature,
         * then scans safely castable loops in source order. Equal-width
         * long/longlong aliases can cast safely without sharing a class. */
        for(size_t i=0;i<u->nloops;i++){
            int exact=1;
            for(int j=0;j<u->nin;j++)if(inputs[j]->descr->cls!=u->loops[i].classes[j])exact=0;
            if(exact){*resolved=&u->loops[i];return 0;}
        }
        for(size_t i=0;i<u->nloops;i++){
            int safe=1;
            for(int j=0;j<u->nin;j++)if(!ln_dtype_can_cast(inputs[j]->descr,
                    ln_dtype_default_descr(u->loops[i].classes[j]),LN_SAFE_CASTING))safe=0;
            if(safe){*resolved=&u->loops[i];return 0;}
        }
    }
    if(error){snprintf(error->message,sizeof error->message,"ufunc '%s' requires safely castable integer operands",u->name);error->kind=LN_ERROR_TYPE;}
    return -1;
}

static void initialize(void)
{
    if(ready)return;
    const ln_dtype_num types[]={LN_BOOL,LN_BYTE,LN_UBYTE,LN_SHORT,LN_USHORT,
        LN_INT,LN_UINT,LN_LONG,LN_ULONG,LN_LONGLONG,LN_ULONGLONG};
    const char *names[]={"invert","bitwise_count","left_shift","right_shift","gcd","lcm"};
    for(int op=0;op<6;op++){
        int nin=op<2?1:2,n=0;
        for(int i=op==BIT_INVERT?0:1;i<11;i++){
            const ln_dtype *dtype=ln_dtype_by_num(types[i]);
            contexts[op][n]=(bit_context){dtype,(enum bit_operation)op};
            ln_ufunc_loop *method=&methods[op][n];
            for(int j=0;j<nin;j++)method->classes[j]=dtype->cls;
            method->classes[nin]=op==BIT_COUNT?ln_dtype_by_num(LN_UBYTE)->cls:dtype->cls;
            method->loop=integer_loop;method->data=&contexts[op][n];n++;
        }
        functions[op]=(ln_ufunc){names[op],nin,1,methods[op],(size_t)n,resolve_integer};
    }
    ready=1;
}
const ln_ufunc *ln_integer_math_by_name(const char *name)
{
    initialize();if(!name)return NULL;
    for(int i=0;i<6;i++)if(strcmp(name,functions[i].name)==0)return &functions[i];
    return NULL;
}
size_t ln_integer_math_count(void){return 6;}
