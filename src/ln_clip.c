#include "ln_clip.h"
#include "ln_dtype_transfer.h"
#include "ln_datetime.h"
#include "ln_half.h"
#include "ln_complex.h"
#include <math.h>
#include <stdio.h>
#include <string.h>

/* NumPy2.5.3 clip.cpp and _methods.py:_clip. In particular scalar real
 * bounds use strict comparisons preserving input signed zero, whereas the
 * generic real loop selects the second operand on ties. Half uses >=/<=. */
#define LOAD(T,N,J) T N;memcpy(&N,args[J]+i*steps[J],sizeof N)
#define STORE(Z) memcpy(args[3]+i*steps[3],&(Z),sizeof(Z))
#define INTEGER(NUM,T) case NUM:{LOAD(T,x,0);LOAD(T,lo,1);LOAD(T,hi,2); \
    T y=x>lo?x:lo,z=y<hi?y:hi;STORE(z);break;}
#define REAL(NUM,T) case NUM:{LOAD(T,x,0);LOAD(T,lo,1);LOAD(T,hi,2);T z; \
    if(!steps[1]&&!steps[2]){ \
        if(isnan(lo)||isnan(hi))z=isnan(lo)?lo:hi; \
        else{z=x;if(z<lo)z=lo;if(z>hi)z=hi;} \
    }else{T y=isnan(x)||x>lo?x:lo;z=isnan(y)||y<hi?y:hi;} \
    STORE(z);break;}
#define COMPLEX(NUM,T) case NUM:{LOAD(T,x,0);LOAD(T,lo,1);LOAD(T,hi,2); \
    int greater=x.real==lo.real?x.imag>lo.imag:x.real>lo.real; \
    T y=isnan(x.real)||isnan(x.imag)||greater?x:lo; \
    int less=y.real==hi.real?y.imag<hi.imag:y.real<hi.real; \
    T z=isnan(y.real)||isnan(y.imag)||less?y:hi;STORE(z);break;}
static void clip_loop(char **args,const ln_intp *dims,const ln_intp *steps,void *data)
{
    const ln_dtype *dt=data;
    for(ln_intp i=0;i<dims[0];++i)switch(dt->type_num){
        INTEGER(LN_BOOL,uint8_t)
        INTEGER(LN_BYTE,int8_t) INTEGER(LN_UBYTE,uint8_t)
        INTEGER(LN_SHORT,int16_t) INTEGER(LN_USHORT,uint16_t)
        INTEGER(LN_INT,int32_t) INTEGER(LN_UINT,uint32_t)
        INTEGER(LN_LONG,long) INTEGER(LN_ULONG,unsigned long)
        INTEGER(LN_LONGLONG,long long) INTEGER(LN_ULONGLONG,unsigned long long)
        REAL(LN_FLOAT,float) REAL(LN_DOUBLE,double) REAL(LN_LONGDOUBLE,long double)
        COMPLEX(LN_CFLOAT,ln_cfloat) COMPLEX(LN_CDOUBLE,ln_cdouble)
        COMPLEX(LN_CLONGDOUBLE,ln_clongdouble)
        case LN_HALF:{LOAD(ln_half,x,0);LOAD(ln_half,lo,1);LOAD(ln_half,hi,2);
            float a=ln_half_to_float(x),b=ln_half_to_float(lo),c=ln_half_to_float(hi);
            ln_half y=isnan(a)||a>=b?x:lo;float v=ln_half_to_float(y);
            ln_half z=isnan(v)||v<=c?y:hi;STORE(z);break;}
        case LN_DATETIME:case LN_TIMEDELTA:{
            LOAD(int64_t,x,0);LOAD(int64_t,lo,1);LOAD(int64_t,hi,2);
            int64_t y=x==LN_DATETIME_NAT?x:lo==LN_DATETIME_NAT?lo:x>lo?x:lo;
            int64_t z=y==LN_DATETIME_NAT?y:hi==LN_DATETIME_NAT?hi:y<hi?y:hi;
            STORE(z);break;}
        default:break;
    }
}
#undef LOAD
#undef STORE
#undef INTEGER
#undef REAL
#undef COMPLEX
static int failure(ln_error *err,const char *message)
{
    if(err){snprintf(err->message,sizeof err->message,"%s",message);err->kind=LN_ERROR_TYPE;}
    return -1;
}
static int kind_rank(char kind)
{
    switch(kind){case 'b':return 0;case 'i':case 'u':return 1;
        case 'f':return 2;case 'c':return 3;case 'm':return 4;case 'M':return 5;
        default:return -1;}
}
static const ln_dtype *common_inputs(int n,const ln_array *const *inputs)
{
    /* common_dtype.c:PyArray_PromoteDTypeSequence first finds the most
     * knowledgeable category. Promote each original against that category
     * before combining: (int8,uint8,float16) is float16, not float32 from an
     * intermediate int16. This covers this registry's builtin numeric/time
     * classes, without pretending to implement foreign DType protocols. */
    int main=0;
    for(int i=0;i<n;++i){
        if(kind_rank(inputs[i]->descr->kind)<0)return NULL;
        if(kind_rank(inputs[i]->descr->kind)>kind_rank(inputs[main]->descr->kind))main=i;
    }
    const ln_dtype *base=inputs[main]->descr,*dt=base;
    for(int i=0;i<n&&dt;++i){
        const ln_dtype *promotion=ln_common_dtype_descr(base,inputs[i]->descr);
        dt=promotion?ln_common_dtype_descr(dt,promotion):NULL;
    }
    return dt;
}
static int resolve(const ln_ufunc *u,const ln_array *const *inputs,
                   const ln_ufunc_loop **method,ln_error *err)
{
    const ln_dtype *dt=common_inputs(3,inputs);
    if(dt)for(int i=0;i<3;++i)if(!ln_dtype_can_cast(inputs[i]->descr,dt,LN_SAME_KIND_CASTING))
        return failure(err,"clip input cannot cast to common dtype with same_kind");
    if(dt)for(size_t i=0;i<u->nloops;++i)if(u->loops[i].classes[0]==dt->cls){*method=&u->loops[i];return 0;}
    return failure(err,"clip has no matching uniform dtype signature");
}
static int descriptors(const ln_ufunc *u,const ln_ufunc_loop *method,
        const ln_array *const *inputs,const ln_dtype_descr **descrs,ln_error *err)
{
    (void)u;(void)method;
    const ln_dtype *dt=common_inputs(3,inputs);
    if(!dt)return failure(err,"cannot resolve clip descriptors");
    for(int i=0;i<4;++i)descrs[i]=dt;
    return 0;
}
const ln_ufunc *ln_clip_ufunc(void)
{
    static ln_ufunc_loop methods[20];static ln_ufunc fn;static int ready;
    if(!ready){
        const ln_dtype_num nums[]={LN_BOOL,LN_BYTE,LN_UBYTE,LN_SHORT,LN_USHORT,
            LN_INT,LN_UINT,LN_LONG,LN_ULONG,LN_LONGLONG,LN_ULONGLONG,LN_HALF,
            LN_FLOAT,LN_DOUBLE,LN_LONGDOUBLE,LN_CFLOAT,LN_CDOUBLE,LN_CLONGDOUBLE,
            LN_TIMEDELTA,LN_DATETIME};
        for(int i=0;i<20;++i){
            const ln_dtype *dt=ln_dtype_by_num(nums[i]);
            for(int j=0;j<4;++j)methods[i].classes[j]=dt->cls;
            methods[i].loop=clip_loop;methods[i].data=(void *)dt;
            methods[i].resolve_descrs=descriptors;
        }
        fn=(ln_ufunc){"clip",3,1,methods,20,resolve};ready=1;
    }
    return &fn;
}
static int redundant_integer_bound(const ln_array *a,const ln_ufunc_operand *bound,int lower)
{
    if(!bound||bound->kind!=LN_UFUNC_WEAK_INT)return 0;
    const ln_dtype *dt=a->descr;
    if(dt->kind=='u'){
        if(lower)return bound->integer<=0;
        if(dt->elsize>=8)return 0; /* Lua signed integer cannot reach UINT64_MAX. */
        return bound->integer>=(int64_t)((UINT64_C(1)<<(8*dt->elsize))-1);
    }
    if(dt->kind=='i'){
        if(dt->elsize>=8)return lower?bound->integer==INT64_MIN:bound->integer==INT64_MAX;
        int64_t max=(INT64_C(1)<<(8*dt->elsize-1))-1;
        return lower?bound->integer<=-max-1:bound->integer>=max;
    }
    return 0;
}
/* Resolve all strong descriptors and weak kinds before converting ANY weak
 * value: an otherwise overflowing int can be rescued by another float bound.
 * A weak int does not pin an inexact strong dtype to int64 precision. */
static int materialize(int n,const ln_ufunc_operand *operands,
        const ln_array **inputs,ln_array *temps,unsigned char storage[][sizeof(ln_clongdouble)],ln_error *err)
{
    const ln_array *strong[3];int strong_count=0;
    for(int i=0;i<n;++i)if(operands[i].kind==LN_UFUNC_OPERAND_ARRAY){
        if(!operands[i].array)return failure(err,"invalid clip operand");
        inputs[i]=operands[i].array;strong[strong_count++]=inputs[i];
    }
    if(!strong_count)return failure(err,"clip requires a strong input");
    const ln_dtype *dt=common_inputs(strong_count,strong);
    if(!dt)return failure(err,"clip inputs have no common dtype");
    for(int i=0;i<n;++i)if(operands[i].kind!=LN_UFUNC_OPERAND_ARRAY){
        ln_array strength={0};strength.descr=dt;
        if(dt->kind=='m'){
            if(operands[i].kind!=LN_UFUNC_WEAK_INT&&operands[i].kind!=LN_UFUNC_WEAK_BOOL)
                return failure(err,"timedelta clip only accepts integer or timedelta bounds");
        }else if(dt->kind=='M'||dt->kind=='S'||dt->kind=='U')return failure(err,"unsupported weak clip bound dtype");
        else switch(operands[i].kind){
            case LN_UFUNC_WEAK_BOOL:dt=ln_resolve_weak_bool_dtype(&strength,LN_OP_MAXIMUM,err);break;
            case LN_UFUNC_WEAK_INT:dt=ln_resolve_weak_scalar_dtype(&strength,1,0,LN_OP_MAXIMUM,err);break;
            case LN_UFUNC_WEAK_FLOAT:dt=ln_resolve_weak_scalar_dtype(&strength,0,0,LN_OP_MAXIMUM,err);break;
            case LN_UFUNC_WEAK_COMPLEX:dt=ln_resolve_weak_complex_dtype(&strength,LN_OP_MAXIMUM,err);break;
            default:return failure(err,"clip has no string signature");
        }
        if(!dt)return -1;
    }
    for(int i=0;i<n;++i)if(operands[i].kind!=LN_UFUNC_OPERAND_ARRAY){
        ln_array *tmp=&temps[i];memset(tmp,0,sizeof *tmp);memset(storage[i],0,sizeof storage[i]);
        tmp->data=(char *)storage[i];tmp->descr=dt;
        tmp->flags=LN_ARRAY_WRITEABLE|LN_ARRAY_ALIGNED|LN_ARRAY_C_CONTIGUOUS|LN_ARRAY_F_CONTIGUOUS;
        const ln_ufunc_operand *op=&operands[i];int rc;
        if(op->kind==LN_UFUNC_WEAK_COMPLEX)rc=ln_array_pack_complex(tmp,NULL,op->real,op->imag,err);
        else if(op->kind==LN_UFUNC_WEAK_INT)rc=ln_array_pack_number(tmp,NULL,(double)op->integer,op->integer,1,err);
        else if(op->kind==LN_UFUNC_WEAK_BOOL)rc=ln_array_pack_number(tmp,NULL,op->boolean,op->boolean,1,err);
        else rc=ln_array_pack_number(tmp,NULL,op->floating,0,0,err);
        if(rc<0)return -1;
        inputs[i]=tmp;
    }
    return 0;
}
int ln_array_clip(const ln_array *a,const ln_ufunc_operand *minimum,
        const ln_ufunc_operand *maximum,ln_array **out,const ln_array *where,ln_error *err)
{
    if(!a||!out)return failure(err,"invalid clip call");
    if(redundant_integer_bound(a,minimum,1))minimum=NULL;
    if(redundant_integer_bound(a,maximum,0))maximum=NULL;
    ln_ufunc_operand operands[3]={{0}};operands[0].array=a;
    const char *name;
    int n=1;
    if(minimum)operands[n++]=*minimum;
    if(maximum)operands[n++]=*maximum;
    name=n==3?"clip":minimum?"maximum":maximum?"minimum":"positive";
    const ln_array *inputs[3]={0};ln_array temps[3];
    _Alignas(ln_clongdouble) unsigned char storage[3][sizeof(ln_clongdouble)];
    if(materialize(n,operands,inputs,temps,storage,err)<0)return -1;
    return ln_ufunc_execute(ln_ufunc_by_name(name),inputs,out,where,err);
}
