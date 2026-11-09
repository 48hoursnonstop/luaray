#include "ln_unary_math.h"
#include "ln_half.h"
#include "ln_complex.h"
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

/* Algorithms/signatures reference NumPy 2.5.3 generate_umath.py,
 * loops.c.src, loops_autovec.dispatch.c.src and npy_math_internal.h.src.
 * NumPy's copyright and BSD license are reproduced in THIRD_PARTY_NUMPY_LICENSE.txt. */
enum operation { FLOOR, CEIL, TRUNC, RINT, FABS, CONJ, SQUARE, RECIP,
                 DEGREES, RADIANS, NOPS };
typedef struct { enum operation op; const ln_dtype *dt; } context;
static context contexts[NOPS][18];
static ln_ufunc_loop methods[NOPS][18];
static ln_ufunc functions[NOPS];
static int ready;

/* The constants are rounded at the computation precision, before multiplying.
 * Half operations compute in float, matching NumPy's astype={'e':'f'}. */
#define PI_F 3.141592653589793238462643383279502884F
#define PI_D 3.141592653589793238462643383279502884
#define PI_L 3.141592653589793238462643383279502884L
#define REAL_EVAL(SUFFIX, T, PI) \
static T real_##SUFFIX(T x, enum operation op) { \
    switch(op) { \
    case FLOOR:return floor##SUFFIX(x); \
    case CEIL:return ceil##SUFFIX(x); \
    case TRUNC:return trunc##SUFFIX(x); \
    case RINT:return rint##SUFFIX(x); \
    case FABS:return fabs##SUFFIX(x); \
    case SQUARE:return x*x; \
    case RECIP:return (T)1/x; \
    case DEGREES:return x*((T)180/(PI)); \
    case RADIANS:return x*((PI)/(T)180); \
    default:return x; \
    } \
}
REAL_EVAL(f, float, PI_F)
REAL_EVAL(, double, PI_D)
REAL_EVAL(l, long double, PI_L)
#undef REAL_EVAL

#define COMPLEX_EVAL(NAME, CTYPE, T, SUFFIX) \
static void complex_##NAME(const char *src,char *dst,enum operation op) { \
    CTYPE z,w;memcpy(&z,src,sizeof z); \
    T a=z.real,b=z.imag; \
    if(op==CONJ){w.real=a;w.imag=-b;} \
    else if(op==RINT){w.real=rint##SUFFIX(a);w.imag=rint##SUFFIX(b);} \
    else if(op==SQUARE){w.real=a*a-b*b;w.imag=a*b+b*a;} \
    else if(fabs##SUFFIX(b)<=fabs##SUFFIX(a)){ \
        T r=b/a,d=a+b*r;w.real=(T)1/d;w.imag=-r/d; \
    } else {T r=a/b,d=a*r+b;w.real=r/d;w.imag=(T)-1/d;} \
    memcpy(dst,&w,sizeof w); \
}
COMPLEX_EVAL(f,ln_cfloat,float,f)
COMPLEX_EVAL(d,ln_cdouble,double,)
COMPLEX_EVAL(l,ln_clongdouble,long double,l)
#undef COMPLEX_EVAL

/* Integer square uses unsigned modular arithmetic so overflow never invokes
 * C signed-overflow UB. Reciprocal is exactly 0 except at +/-1. For zero,
 * preserve NumPy's x86 scalar-loop result explicitly rather than executing
 * its undefined floating-to-integer cast of infinity. Other ABI semantics
 * need an oracle audit before being claimed compatible. */
#define INTEGER_CASE(NUM,T,U,IS_SIGNED) \
case NUM:{T x,y;memcpy(&x,src,sizeof x); \
    if(op==SQUARE){U u=(U)x;u=(U)((uint64_t)u*(uint64_t)u);memcpy(&y,&u,sizeof y);} \
    else if(op==RECIP){ \
        if(x==(T)1)y=(T)1; \
        else if((IS_SIGNED)&&x==(T)-1)y=(T)-1; \
        else if(x==0&&(IS_SIGNED)&&sizeof(T)>=4){ \
            U u=(U)((uint64_t)1<<(sizeof(T)*8-1));memcpy(&y,&u,sizeof y); \
        }else y=0; \
    }else y=x; \
    memcpy(dst,&y,sizeof y);break;}

static int disjoint_span(char **args,const ln_intp *dims,const ln_intp *strides,
                         size_t itemsize)
{
    uintptr_t a=(uintptr_t)args[0],b=(uintptr_t)args[1];
    uintptr_t ae=(uintptr_t)(args[0]+(dims[0]-1)*strides[0]);
    uintptr_t be=(uintptr_t)(args[1]+(dims[0]-1)*strides[1]);
    uintptr_t amin=a<ae?a:ae,amax=a>ae?a:ae;
    uintptr_t bmin=b<be?b:be,bmax=b>be?b:be;
    return (a==b&&ae==be) || amax+itemsize<=bmin || bmax+itemsize<=amin;
}

static void inner(char **args,const ln_intp *dims,const ln_intp *strides,void *data)
{
    const context *ctx=data;
    enum operation op=ctx->op;
    /* NumPy's SIMD complex square uses the same FMA product ordering as
     * complex multiplication. Its scalar fallback uses separate products.
     * Exact in-place ranges are vector-eligible (loops_utils.h.src). Reuse
     * our established multiply kernel for eligible contiguous input/output. */
    ln_intp item=(ln_intp)ctx->dt->elsize;
    if(dims[0]>0 && op==SQUARE &&
       (ctx->dt->type_num==LN_CFLOAT||ctx->dt->type_num==LN_CDOUBLE) &&
       (strides[0]==item||strides[1]==item) && strides[1]!=0 &&
       strides[0]%(item/2)==0 && strides[1]%(item/2)==0 &&
       disjoint_span(args,dims,strides,ctx->dt->elsize)){
        char *binary_args[]={args[0],args[0],args[1]};
        ln_intp binary_strides[]={strides[0],strides[0],strides[1]};
        ln_get_multiply_loop(ctx->dt->type_num)(binary_args,dims,binary_strides,NULL);
        return;
    }
    for(ln_intp i=0;i<dims[0];++i){
        const char *src=args[0]+i*strides[0];char *dst=args[1]+i*strides[1];
        switch(ctx->dt->type_num){
        case LN_BOOL:memcpy(dst,src,1);break;
        INTEGER_CASE(LN_BYTE,int8_t,uint8_t,1)
        INTEGER_CASE(LN_UBYTE,uint8_t,uint8_t,0)
        INTEGER_CASE(LN_SHORT,int16_t,uint16_t,1)
        INTEGER_CASE(LN_USHORT,uint16_t,uint16_t,0)
        INTEGER_CASE(LN_INT,int32_t,uint32_t,1)
        INTEGER_CASE(LN_UINT,uint32_t,uint32_t,0)
        INTEGER_CASE(LN_LONG,long,unsigned long,1)
        INTEGER_CASE(LN_ULONG,unsigned long,unsigned long,0)
        INTEGER_CASE(LN_LONGLONG,long long,unsigned long long,1)
        INTEGER_CASE(LN_ULONGLONG,unsigned long long,unsigned long long,0)
        case LN_HALF:{ln_half h;memcpy(&h,src,sizeof h);
            if(op!=CONJ)h=ln_float_to_half(real_f(ln_half_to_float(h),op));
            memcpy(dst,&h,sizeof h);break;}
        case LN_FLOAT:{float x;memcpy(&x,src,sizeof x);x=real_f(x,op);memcpy(dst,&x,sizeof x);break;}
        case LN_DOUBLE:{double x;memcpy(&x,src,sizeof x);x=real_(x,op);memcpy(dst,&x,sizeof x);break;}
        case LN_LONGDOUBLE:{long double x;memcpy(&x,src,sizeof x);x=real_l(x,op);memcpy(dst,&x,sizeof x);break;}
        case LN_CFLOAT:complex_f(src,dst,op);break;
        case LN_CDOUBLE:complex_d(src,dst,op);break;
        case LN_CLONGDOUBLE:complex_l(src,dst,op);break;
        default:break; /* Never registered for nonnumeric types. */
        }
    }
}
#undef INTEGER_CASE

static int resolve(const ln_ufunc *u,const ln_array *const *inputs,
                   const ln_ufunc_loop **method,ln_error *err)
{
    const ln_dtype *src=inputs[0]->descr;
    for(size_t i=0;i<u->nloops;++i){
        const ln_dtype *dst=ln_dtype_default_descr(u->loops[i].classes[0]);
        const ln_dtype *promoted=ln_promote_dtype(src,dst);
        if(src->cls==dst->cls || (promoted&&promoted->cls==dst->cls)){
            *method=&u->loops[i];return 0;
        }
    }
    if(err)snprintf(err->message,sizeof err->message,
                   "ufunc '%s' has no safely castable numeric signature",u->name);
    return -1;
}

static void initialize(void)
{
    if(ready)return;
    const char *names[NOPS]={"floor","ceil","trunc","rint","fabs","conjugate",
                             "square","reciprocal","degrees","radians"};
    const ln_dtype_num types[]={LN_BOOL,LN_BYTE,LN_UBYTE,LN_SHORT,LN_USHORT,
        LN_INT,LN_UINT,LN_LONG,LN_ULONG,LN_LONGLONG,LN_ULONGLONG,
        LN_HALF,LN_FLOAT,LN_DOUBLE,LN_LONGDOUBLE,LN_CFLOAT,LN_CDOUBLE,LN_CLONGDOUBLE};
    for(int op=0;op<NOPS;++op){
        size_t n=0;
        for(size_t i=0;i<sizeof types/sizeof *types;++i){
            const ln_dtype *dt=ln_dtype_by_num(types[i]);
            int include;
            if(op<=TRUNC)include=dt->kind!='c';
            else if(op==RINT)include=dt->kind=='f'||dt->kind=='c';
            else if(op==FABS||op==DEGREES||op==RADIANS)include=dt->kind=='f';
            else include=dt->type_num!=LN_BOOL;
            if(!include)continue;
            contexts[op][n]=(context){op,dt};
            methods[op][n].classes[0]=methods[op][n].classes[1]=dt->cls;
            methods[op][n].loop=inner;methods[op][n].data=&contexts[op][n];
            ++n;
        }
        functions[op]=(ln_ufunc){names[op],1,1,methods[op],n,resolve};
    }
    ready=1;
}

const ln_ufunc *ln_unary_math_by_name(const char *name)
{
    initialize();
    if(!name)return NULL;
    if(strcmp(name,"conj")==0)name="conjugate";
    else if(strcmp(name,"rad2deg")==0)name="degrees";
    else if(strcmp(name,"deg2rad")==0)name="radians";
    for(int i=0;i<NOPS;++i)if(strcmp(name,functions[i].name)==0)return &functions[i];
    return NULL;
}
size_t ln_unary_math_count(void){return NOPS;}
