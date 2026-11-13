#include "ln_ufunc.h"
#include "ln_nditer_multi.h"
#include "ln_complex.h"
#include "ln_datetime.h"
#include "ln_string.h"
#include "ln_unary_math.h"
#include "ln_binary_math.h"
#include "ln_clip.h"
#include "ln_dtype_transfer.h"
#include "ln_time_scale.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static void
ufunc_error(ln_error *err,const char *msg)
{
    if(err){snprintf(err->message,sizeof(err->message),"%s",msg?msg:"ufunc error");err->kind=LN_ERROR_TYPE;}
}

static int
can_cast_safe_numeric(const ln_dtype *from,const ln_dtype *to)
{
    if(!from||!to)return 0;
    if(from->type_num==to->type_num)return 1;
    const ln_dtype *p=ln_promote_dtype(from,to);
    return p&&p->type_num==to->type_num;
}

static int
is_integer_or_bool(const ln_dtype *dt)
{
    return dt && (dt->type_num==LN_BOOL || dt->kind=='i' || dt->kind=='u');
}

static int
is_mixed_signed_unsigned_64(const ln_dtype *a,const ln_dtype *b)
{
    if(!a||!b||a->elsize!=8||b->elsize!=8)return 0;
    return (a->kind=='i'&&b->kind=='u')||(a->kind=='u'&&b->kind=='i');
}

static const ln_dtype *
real_dtype_of_complex(const ln_dtype *dt)
{
    if(!dt||dt->kind!='c')return dt;
    switch(dt->type_num){
        case LN_CFLOAT:return ln_dtype_by_num(LN_FLOAT);
        case LN_CDOUBLE:return ln_dtype_by_num(LN_DOUBLE);
        case LN_CLONGDOUBLE:return ln_dtype_by_num(LN_LONGDOUBLE);
        default:return NULL;
    }
}

static const ln_ufunc_loop *
find_loop_1(const ln_ufunc *u,const ln_dtype *a)
{
    for(size_t i=0;i<u->nloops;++i)
        if(u->loops[i].classes[0]==a->cls)return &u->loops[i];
    return NULL;
}

static const ln_ufunc_loop *
find_loop_2(const ln_ufunc *u,const ln_dtype *a,const ln_dtype *b)
{
    for(size_t i=0;i<u->nloops;++i)
        if(u->loops[i].classes[0]==a->cls&&
           u->loops[i].classes[1]==b->cls)return &u->loops[i];
    return NULL;
}

static int
is_time_dtype(const ln_dtype *dt)
{
    return dt && (dt->type_num==LN_DATETIME || dt->type_num==LN_TIMEDELTA);
}

static int
resolve_time_binary_descrs(const ln_ufunc *u,const ln_ufunc_loop *method,
                           const ln_array *const *inputs,
                           const ln_dtype_descr **descrs,ln_error *err)
{
    (void)u;
    const ln_dtype_descr *a=inputs[0]->descr,*b=inputs[1]->descr;
    const ln_dtype_descr *common;
    if(is_time_dtype(a)&&(b->kind=='b'||b->kind=='i'||b->kind=='u'))common=a;
    else if(is_time_dtype(b)&&(a->kind=='b'||a->kind=='i'||a->kind=='u'))common=b;
    else common=ln_common_dtype_descr(a,b);
    if(!common){ufunc_error(err,"cannot resolve common datetime metadata");return -1;}
    const ln_datetime_meta *meta=ln_datetime_metadata(common);
    if(!meta){ufunc_error(err,"datetime ufunc resolved non-time metadata");return -1;}
    for(int i=0;i<3;++i){
        const ln_dtype_class *c=method->classes[i];
        if(c->legacy_type_num==LN_DATETIME)descrs[i]=ln_datetime_make_dtype(0,*meta,err);
        else if(c->legacy_type_num==LN_TIMEDELTA)descrs[i]=ln_datetime_make_dtype(1,*meta,err);
        else descrs[i]=ln_dtype_default_descr(c);
        if(!descrs[i])return -1;
    }
    return 0;
}

static int
resolve_time_unary_descrs(const ln_ufunc *u,const ln_ufunc_loop *method,
                          const ln_array *const *inputs,
                          const ln_dtype_descr **descrs,ln_error *err)
{
    (void)u;(void)err;
    descrs[0]=inputs[0]->descr;
    if(method->classes[1]==inputs[0]->descr->cls)descrs[1]=inputs[0]->descr;
    else descrs[1]=ln_dtype_default_descr(method->classes[1]);
    return descrs[1]?0:-1;
}

static int
validate_datetime_arithmetic(char **args,const ln_intp *dimensions,const ln_intp *steps,
                             const uint8_t *mask,ln_intp mask_step,void *data,ln_error *err)
{
    int subtract=*(const int*)data;
    for(ln_intp i=0;i<dimensions[0];++i){
        if(mask&&!*(const uint8_t*)((const char*)mask+i*mask_step))continue;
        int64_t a,b,r;memcpy(&a,args[0]+i*steps[0],8);memcpy(&b,args[1]+i*steps[1],8);
        if(a==LN_DATETIME_NAT||b==LN_DATETIME_NAT)continue;
#if defined(__GNUC__)
        int ov=subtract?__builtin_sub_overflow(a,b,&r):__builtin_add_overflow(a,b,&r);
#else
        int ov=0;
        if(subtract){if((b>0&&a<INT64_MIN+b)||(b<0&&a>INT64_MAX+b))ov=1;else r=a-b;}
        else{if((b>0&&a>INT64_MAX-b)||(b<0&&a<INT64_MIN-b))ov=1;else r=a+b;}
#endif
        if(ov||r==LN_DATETIME_NAT){
            ufunc_error(err,subtract?"Overflow in datetime64/timedelta64 subtraction":"Overflow in datetime64/timedelta64 addition");
            if(err)err->kind=LN_ERROR_OVERFLOW;
            return -(int)i-2;
        }
    }
    return 1;
}

static int
legacy_binary_op_for_name(const char *name, ln_binary_op *op)
{
    if(!name||!op)return 0;
    struct pair { const char *name; ln_binary_op op; };
    static const struct pair map[]={
        {"add",LN_OP_ADD},{"subtract",LN_OP_SUBTRACT},{"multiply",LN_OP_MULTIPLY},
        {"true_divide",LN_OP_TRUE_DIVIDE},
        {"equal",LN_OP_EQUAL},{"not_equal",LN_OP_NOT_EQUAL},{"less",LN_OP_LESS},
        {"less_equal",LN_OP_LESS_EQUAL},{"greater",LN_OP_GREATER},{"greater_equal",LN_OP_GREATER_EQUAL},
        {"logical_and",LN_OP_LOGICAL_AND},{"logical_or",LN_OP_LOGICAL_OR},{"logical_xor",LN_OP_LOGICAL_XOR},
        {"maximum",LN_OP_MAXIMUM},{"minimum",LN_OP_MINIMUM},
        {"floor_divide",LN_OP_FLOOR_DIVIDE},{"remainder",LN_OP_REMAINDER},{"fmod",LN_OP_REMAINDER},{"power",LN_OP_POWER},
        {"bitwise_and",LN_OP_BITWISE_AND},{"bitwise_or",LN_OP_BITWISE_OR},{"bitwise_xor",LN_OP_BITWISE_XOR},
        {"fmax",LN_OP_FMAX},{"fmin",LN_OP_FMIN},{"copysign",LN_OP_COPYSIGN},{"arctan2",LN_OP_ARCTAN2},{"hypot",LN_OP_HYPOT}
    };
    for(size_t i=0;i<sizeof(map)/sizeof(map[0]);++i){
        if(strcmp(name,map[i].name)==0){*op=map[i].op;return 1;}
    }
    return 0;
}

static int
resolve_legacy_binary(const ln_ufunc *u,const ln_array *const *inputs,
                      const ln_ufunc_loop **resolved,ln_error *err)
{
    ln_binary_op op;
    if(!legacy_binary_op_for_name(u->name,&op)){
        ufunc_error(err,"ufunc has no builtin promotion mapping");return -1;
    }
    const ln_dtype *a=inputs[0]->descr,*b=inputs[1]->descr;
    /* dispatching.cpp logical_ufunc_promoter overrides numeric/string inputs
     * to bool before computation. In particular a tiny weak float must not
     * underflow in the strong operand's narrower floating dtype first. */
    if(op==LN_OP_LOGICAL_AND||op==LN_OP_LOGICAL_OR||op==LN_OP_LOGICAL_XOR){
        const ln_dtype *bo=ln_dtype_by_num(LN_BOOL);
        const ln_ufunc_loop *m=find_loop_2(u,bo,bo);
        if(m){*resolved=m;return 0;}
        ufunc_error(err,"logical ufunc has no boolean signature");return -1;
    }
    if(ln_string_is_dtype(a)||ln_string_is_dtype(b)){
        if(!ln_string_is_dtype(a)||!ln_string_is_dtype(b)||a->cls!=b->cls){ufunc_error(err,"ufunc did not contain a loop for mixed bytes/unicode comparison");return -1;}
        const ln_ufunc_loop *sm=find_loop_2(u,a,b);if(sm){*resolved=sm;return 0;}
        ufunc_error(err,"string comparison loop resolution failed");return -1;
    }
    if(is_time_dtype(a)||is_time_dtype(b)){
        const ln_dtype *common=ln_common_dtype_descr(a,b);
        if(!(op==LN_OP_MAXIMUM||op==LN_OP_MINIMUM||op==LN_OP_FMAX||op==LN_OP_FMIN)||!common||
           !ln_dtype_can_cast(a,common,LN_SAME_KIND_CASTING)||
           !ln_dtype_can_cast(b,common,LN_SAME_KIND_CASTING)){
            ufunc_error(err,"ufunc has no matching datetime/timedelta signature");return -1;
        }
        const ln_ufunc_loop *tm=find_loop_2(u,common,common);
        if(tm){*resolved=tm;return 0;}
        ufunc_error(err,"datetime/timedelta minmax loop resolution failed");return -1;
    }
    if((op==LN_OP_EQUAL||op==LN_OP_NOT_EQUAL||op==LN_OP_LESS||op==LN_OP_LESS_EQUAL||
        op==LN_OP_GREATER||op==LN_OP_GREATER_EQUAL) && is_mixed_signed_unsigned_64(a,b)){
        const ln_ufunc_loop *m=find_loop_2(u,a,b);
        if(m){*resolved=m;return 0;}
    }
    const ln_dtype *dt=ln_resolve_binary_dtype(a,b,op,err);
    if(!dt)return -1;
    const ln_ufunc_loop *m=find_loop_2(u,dt,dt);
    if(m){*resolved=m;return 0;}
    char msg[256];snprintf(msg,sizeof(msg),"ufunc '%s' did not contain a loop with a matching signature",u->name);
    ufunc_error(err,msg);return -1;
}

static int
resolve_float_unary(const ln_ufunc *ufunc,const ln_array *const *inputs,
                    const ln_ufunc_loop **resolved,ln_error *err)
{
    const ln_dtype *src=inputs[0]->descr;
    if(src->kind=='c'){
        char msg[256];snprintf(msg,sizeof(msg),"ufunc '%s' not supported for complex input",ufunc->name);
        ufunc_error(err,msg);return -1;
    }
    for(size_t i=0;i<ufunc->nloops;++i){
        if(can_cast_safe_numeric(src,ln_dtype_default_descr(ufunc->loops[i].classes[0]))){
            *resolved=&ufunc->loops[i];return 0;
        }
    }
    ufunc_error(err,"ufunc did not contain a loop with a matching signature");return -1;
}

static int
resolve_safe_signature(const ln_ufunc *ufunc,const ln_array *const *inputs,
                       const ln_ufunc_loop **resolved,ln_error *err)
{
    for(size_t i=0;i<ufunc->nloops;++i){
        int ok=1;
        for(int j=0;j<ufunc->nin;++j){
            if(!can_cast_safe_numeric(inputs[j]->descr,ln_dtype_default_descr(ufunc->loops[i].classes[j]))){ok=0;break;}
        }
        if(ok){*resolved=&ufunc->loops[i];return 0;}
    }
    char msg[256];snprintf(msg,sizeof(msg),"ufunc '%s' did not contain a loop with a matching signature",ufunc->name);
    ufunc_error(err,msg);return -1;
}

static int
resolve_divmod(const ln_ufunc *ufunc,const ln_array *const *inputs,
               const ln_ufunc_loop **resolved,ln_error *err)
{
    if(inputs[0]->descr->kind=='c'||inputs[1]->descr->kind=='c'){
        ufunc_error(err,"ufunc 'divmod' not supported for complex input");return -1;
    }
    const ln_dtype *dt=ln_promote_dtype(inputs[0]->descr,inputs[1]->descr);
    if(!dt){ufunc_error(err,"no common dtype for divmod");return -1;}
    if(dt->type_num==LN_BOOL)dt=ln_dtype_by_num(LN_BYTE);
    const ln_ufunc_loop *m=find_loop_2(ufunc,dt,dt);
    if(m){*resolved=m;return 0;}
    ufunc_error(err,"ufunc 'divmod' did not contain a loop with a matching signature");return -1;
}

static int
resolve_uniform_binary_common(const ln_ufunc *u,const ln_array *const *inputs,
                              const ln_ufunc_loop **resolved,ln_error *err,
                              int subtract,int true_divide)
{
    const ln_dtype *a=inputs[0]->descr,*b=inputs[1]->descr;
    const ln_dtype *dt=NULL;
    if(true_divide && is_integer_or_bool(a) && is_integer_or_bool(b))dt=ln_dtype_by_num(LN_DOUBLE);
    else dt=ln_promote_dtype(a,b);
    if(!dt){ufunc_error(err,"dtype promotion failed");return -1;}
    if(subtract&&dt->type_num==LN_BOOL){
        ufunc_error(err,"numpy boolean subtract, the `-` operator, is not supported, use the bitwise_xor, the `^` operator, or the logical_xor function instead.");
        return -1;
    }
    if(true_divide&&dt->kind!='f'&&dt->kind!='c'){
        ufunc_error(err,"no true_divide loop for resolved dtype");return -1;
    }
    const ln_ufunc_loop *m=find_loop_2(u,dt,dt);
    if(!m){char msg[256];snprintf(msg,sizeof(msg),"ufunc '%s' did not contain a loop with a matching signature",u->name);ufunc_error(err,msg);return -1;}
    *resolved=m;return 0;
}

static int resolve_add(const ln_ufunc*u,const ln_array*const*i,const ln_ufunc_loop**r,ln_error*e){
    if(ln_string_is_dtype(i[0]->descr)||ln_string_is_dtype(i[1]->descr)){
        const ln_ufunc_loop *m=find_loop_2(u,i[0]->descr,i[1]->descr);
        if(!m){ufunc_error(e,"string addition requires matching string dtype classes");return -1;}
        *r=m;return 0;
    }
    if(is_time_dtype(i[0]->descr)||is_time_dtype(i[1]->descr)){
        const ln_dtype *a=i[0]->descr,*b=i[1]->descr;
        const ln_dtype *time=is_time_dtype(a)?a:b;
        const ln_dtype *integer=time==a?b:a;
        if(integer->kind=='b'||integer->kind=='i'||integer->kind=='u'){
            const ln_dtype *duration=ln_datetime_default_dtype(1);
            const ln_ufunc_loop *m=time==a?find_loop_2(u,time,duration):find_loop_2(u,duration,time);
            if(m){*r=m;return 0;}
        }
        if(!is_time_dtype(a)||!is_time_dtype(b)){ufunc_error(e,"datetime/timedelta addition requires time or integer operands");return -1;}
        const ln_ufunc_loop*m=find_loop_2(u,i[0]->descr,i[1]->descr);if(!m){ufunc_error(e,"ufunc 'add' has no matching datetime signature");return -1;}*r=m;return 0;
    }
    return resolve_uniform_binary_common(u,i,r,e,0,0);
}
static int resolve_subtract(const ln_ufunc*u,const ln_array*const*i,const ln_ufunc_loop**r,ln_error*e){
    if(is_time_dtype(i[0]->descr)||is_time_dtype(i[1]->descr)){
        const ln_dtype *a=i[0]->descr,*b=i[1]->descr;
        const ln_dtype *time=is_time_dtype(a)?a:b;
        const ln_dtype *integer=time==a?b:a;
        if((time==a||time->kind=='m')&&(integer->kind=='b'||integer->kind=='i'||integer->kind=='u')){
            const ln_dtype *duration=ln_datetime_default_dtype(1);
            const ln_ufunc_loop *m=time==a?find_loop_2(u,time,duration):find_loop_2(u,duration,time);
            if(m){*r=m;return 0;}
        }
        if(!is_time_dtype(a)||!is_time_dtype(b)){ufunc_error(e,"datetime/timedelta subtraction requires supported time or integer operands");return -1;}
        const ln_ufunc_loop*m=find_loop_2(u,i[0]->descr,i[1]->descr);if(!m){ufunc_error(e,"ufunc 'subtract' has no matching datetime signature");return -1;}*r=m;return 0;
    }
    return resolve_uniform_binary_common(u,i,r,e,1,0);
}
static int resolve_multiply(const ln_ufunc*u,const ln_array*const*i,const ln_ufunc_loop**r,ln_error*e){
    if(is_time_dtype(i[0]->descr)||is_time_dtype(i[1]->descr))return ln_time_scale_resolve(u,i,r,e);
    return resolve_uniform_binary_common(u,i,r,e,0,0);
}
static int resolve_true_divide(const ln_ufunc*u,const ln_array*const*i,const ln_ufunc_loop**r,ln_error*e){
    if(is_time_dtype(i[0]->descr)||is_time_dtype(i[1]->descr))return ln_time_scale_resolve(u,i,r,e);
    return resolve_uniform_binary_common(u,i,r,e,0,1);
}


typedef struct ln_string_compare_data {
    ln_binary_op op;
    const ln_dtype_descr *a;
    const ln_dtype_descr *b;
} ln_string_compare_data;

static int
resolve_string_compare_descrs(const ln_ufunc *u,const ln_ufunc_loop *method,
                              const ln_array *const *inputs,
                              const ln_dtype_descr **descrs,ln_error *err)
{
    (void)u;(void)method;(void)err;
    descrs[0]=inputs[0]->descr;descrs[1]=inputs[1]->descr;descrs[2]=ln_dtype_by_num(LN_BOOL);
    return 0;
}

static int
resolve_string_compare_data(const ln_ufunc_loop *method,
                            const ln_dtype_descr *const *descrs,
                            void **loop_data,ln_error *err)
{
    ln_string_compare_data *d=(ln_string_compare_data*)malloc(sizeof(*d));
    if(!d){ufunc_error(err,"out of memory");if(err)err->kind=LN_ERROR_MEMORY;return -1;}
    d->op=*(const ln_binary_op*)method->data;d->a=descrs[0];d->b=descrs[1];*loop_data=d;return 0;
}

static void
string_compare_loop(char **args,const ln_intp *dimensions,const ln_intp *steps,void *data)
{
    const ln_string_compare_data *d=(const ln_string_compare_data*)data;
    for(ln_intp i=0;i<dimensions[0];++i){
        int c=0;ln_error e={0};
        int rc=ln_string_compare_one(args[0]+i*steps[0],d->a,args[1]+i*steps[1],d->b,&c,&e);
        uint8_t r=0;
        if(rc==0){switch(d->op){
            case LN_OP_EQUAL:r=(c==0);break;case LN_OP_NOT_EQUAL:r=(c!=0);break;
            case LN_OP_LESS:r=(c<0);break;case LN_OP_LESS_EQUAL:r=(c<=0);break;
            case LN_OP_GREATER:r=(c>0);break;case LN_OP_GREATER_EQUAL:r=(c>=0);break;
            default:r=0;break;
        }}
        *(uint8_t*)(args[2]+i*steps[2])=r;
    }
}

static int
resolve_comparison(const ln_ufunc *u,const ln_array *const *inputs,
                   const ln_ufunc_loop **resolved,ln_error *err)
{
    const ln_dtype *a=inputs[0]->descr,*b=inputs[1]->descr;
    if(ln_string_is_dtype(a)||ln_string_is_dtype(b)){
        if(!ln_string_is_dtype(a)||!ln_string_is_dtype(b)||a->cls!=b->cls){ufunc_error(err,"ufunc did not contain a loop for mixed bytes/unicode comparison");return -1;}
        const ln_ufunc_loop *sm=find_loop_2(u,a,b);if(sm){*resolved=sm;return 0;}
        ufunc_error(err,"string comparison loop resolution failed");return -1;
    }
    if(is_time_dtype(a)||is_time_dtype(b)){
        const ln_dtype *time=a->kind=='m'?a:b->kind=='m'?b:NULL;
        const ln_dtype *integer=time==(a)?b:a;
        if(time&&(integer->kind=='b'||integer->kind=='i'||(integer->kind=='u'&&integer->elsize<8))){
            const ln_ufunc_loop *tm=find_loop_2(u,time,time);
            if(tm){*resolved=tm;return 0;}
        }
        if(!is_time_dtype(a)||!is_time_dtype(b)||a->cls!=b->cls){ufunc_error(err,"datetime and timedelta cannot be compared to each other");return -1;}
        const ln_ufunc_loop *tm=find_loop_2(u,a,b);if(!tm){ufunc_error(err,"comparison has no matching datetime signature");return -1;}*resolved=tm;return 0;
    }
    if(is_mixed_signed_unsigned_64(a,b)){
        const ln_ufunc_loop *m=find_loop_2(u,a,b);
        if(m){*resolved=m;return 0;}
    }
    const ln_dtype *dt=ln_promote_dtype(a,b);
    if(!dt){ufunc_error(err,"dtype promotion failed");return -1;}
    const ln_ufunc_loop *m=find_loop_2(u,dt,dt);
    if(m){*resolved=m;return 0;}
    char msg[256];snprintf(msg,sizeof(msg),"ufunc '%s' did not contain a loop with a matching signature",u->name);
    ufunc_error(err,msg);return -1;
}

static int
resolve_unary_exact(const ln_ufunc *u,const ln_array *const *inputs,
                    const ln_ufunc_loop **resolved,ln_error *err)
{
    const ln_dtype *dt=inputs[0]->descr;
    const ln_ufunc_loop *m=find_loop_1(u,dt);
    if(m){*resolved=m;return 0;}
    if(dt->type_num==LN_BOOL&&strcmp(u->name,"negative")==0){
        ufunc_error(err,"The numpy boolean negative, the `-` operator, is not supported, use the `~` operator or the logical_not function instead.");
        return -1;
    }
    if(dt->type_num==LN_BOOL&&(strcmp(u->name,"positive")==0||strcmp(u->name,"sign")==0)){
        ufunc_error(err,"ufunc did not contain a loop with signature matching bool input");return -1;
    }
    if(dt->kind=='c'&&strcmp(u->name,"signbit")==0){
        ufunc_error(err,"ufunc 'signbit' not supported for complex input");return -1;
    }
    char msg[256];snprintf(msg,sizeof(msg),"ufunc '%s' did not contain a loop with a matching signature",u->name);
    ufunc_error(err,msg);return -1;
}

static int
resolve_math_unary(const ln_ufunc *u,const ln_array *const *inputs,
                   const ln_ufunc_loop **resolved,ln_error *err)
{
    const ln_dtype *src=inputs[0]->descr;
    /* NumPy generate_umath registers inexact loops for these operations.
     * Legacy integer/bool inputs resolve by safe casting to the first
     * available floating loop; complex inputs require an actual complex
     * loop (cbrt intentionally has none). */
    for(size_t i=0;i<u->nloops;++i){
        if(can_cast_safe_numeric(src,ln_dtype_default_descr(u->loops[i].classes[0]))){
            *resolved=&u->loops[i];
            return 0;
        }
    }
    char msg[256];
    snprintf(msg,sizeof(msg),"ufunc '%s' did not contain a loop with a matching signature",u->name);
    ufunc_error(err,msg);
    return -1;
}

typedef struct ln_legacy_unary_adapter_data { ln_strided_loop inner; } ln_legacy_unary_adapter_data;

static void
legacy_unary_adapter(char **args,const ln_intp *dimensions,const ln_intp *steps,void *func)
{
    const ln_legacy_unary_adapter_data *d=(const ln_legacy_unary_adapter_data *)func;
    char *a3[3]={args[0],args[0],args[1]};
    ln_intp s3[3]={steps[0],steps[0],steps[1]};
    d->inner(a3,dimensions,s3,NULL);
}

static const ln_dtype_num ALL_NUMERIC[18]={
    LN_BOOL,LN_BYTE,LN_UBYTE,LN_SHORT,LN_USHORT,LN_INT,LN_UINT,LN_LONG,LN_ULONG,
    LN_LONGLONG,LN_ULONGLONG,LN_HALF,LN_FLOAT,LN_DOUBLE,LN_LONGDOUBLE,
    LN_CFLOAT,LN_CDOUBLE,LN_CLONGDOUBLE
};

static size_t
fill_binary_loops(ln_ufunc_loop *dst,ln_binary_op op,int output_bool)
{
    size_t n=0;
    for(size_t i=0;i<sizeof(ALL_NUMERIC)/sizeof(ALL_NUMERIC[0]);++i){
        ln_strided_loop loop=ln_get_binary_loop(op,ALL_NUMERIC[i]);
        if(!loop)continue;
        const ln_dtype *dt=ln_dtype_by_num(ALL_NUMERIC[i]);
        dst[n].classes[0]=dt->cls;dst[n].classes[1]=dt->cls;
        dst[n].classes[2]=(output_bool?ln_dtype_by_num(LN_BOOL):dt)->cls;
        dst[n].loop=loop;++n;
    }
    return n;
}

static size_t
fill_comparison_loops(ln_ufunc_loop *dst,ln_binary_op op)
{
    size_t n=fill_binary_loops(dst,op,1);
    const ln_dtype *i64=ln_dtype_by_name("int64"),*u64=ln_dtype_by_name("uint64"),*bo=ln_dtype_by_num(LN_BOOL);
    ln_strided_loop qQ=ln_get_mixed_comparison_loop(op,i64,u64);
    ln_strided_loop Qq=ln_get_mixed_comparison_loop(op,u64,i64);
    if(qQ){dst[n].classes[0]=i64->cls;dst[n].classes[1]=u64->cls;dst[n].classes[2]=bo->cls;dst[n].loop=qQ;++n;}
    if(Qq){dst[n].classes[0]=u64->cls;dst[n].classes[1]=i64->cls;dst[n].classes[2]=bo->cls;dst[n].loop=Qq;++n;}
    return n;
}

static size_t
fill_unary_loops(ln_ufunc_loop *dst,ln_legacy_unary_adapter_data *data,ln_binary_op op)
{
    size_t n=0;
    for(size_t i=0;i<sizeof(ALL_NUMERIC)/sizeof(ALL_NUMERIC[0]);++i){
        ln_strided_loop inner=ln_get_binary_loop(op,ALL_NUMERIC[i]);
        if(!inner)continue;
        const ln_dtype *in=ln_dtype_by_num(ALL_NUMERIC[i]);
        if(op==LN_OP_NEGATIVE&&in->type_num==LN_BOOL)continue;
        if((op==LN_OP_POSITIVE||op==LN_OP_SIGN)&&in->type_num==LN_BOOL)continue;
        if(op==LN_OP_SIGNBIT&&in->kind=='c')continue;
        const ln_dtype *out=in;
        if(op==LN_OP_ABSOLUTE&&in->kind=='c')out=real_dtype_of_complex(in);
        if(op==LN_OP_LOGICAL_NOT||op==LN_OP_ISNAN||op==LN_OP_ISINF||op==LN_OP_ISFINITE||op==LN_OP_SIGNBIT)
            out=ln_dtype_by_num(LN_BOOL);
        data[n].inner=inner;
        dst[n].classes[0]=in->cls;dst[n].classes[1]=out->cls;
        dst[n].loop=legacy_unary_adapter;dst[n].data=&data[n];++n;
    }
    return n;
}

static size_t
fill_math_unary_loops(ln_ufunc_loop *dst,ln_legacy_unary_adapter_data *data,ln_binary_op op)
{
    static const ln_dtype_num INEXACT[7]={
        LN_HALF,LN_FLOAT,LN_DOUBLE,LN_LONGDOUBLE,LN_CFLOAT,LN_CDOUBLE,LN_CLONGDOUBLE
    };
    size_t n=0;
    for(size_t i=0;i<sizeof(INEXACT)/sizeof(INEXACT[0]);++i){
        ln_strided_loop inner=ln_get_binary_loop(op,INEXACT[i]);
        if(!inner)continue;
        const ln_dtype *dt=ln_dtype_by_num(INEXACT[i]);
        data[n].inner=inner;
        dst[n].classes[0]=dt->cls;
        dst[n].classes[1]=dt->cls;
        dst[n].loop=legacy_unary_adapter;
        dst[n].data=&data[n];
        ++n;
    }
    return n;
}

static int
negative_signed_scalar(const char *p,const ln_dtype *dt)
{
    if(!p||!dt||dt->kind!='i')return 0;
    switch(dt->type_num){
        case LN_BYTE:{int8_t v;memcpy(&v,p,sizeof(v));return v<0;}
        case LN_SHORT:{int16_t v;memcpy(&v,p,sizeof(v));return v<0;}
        case LN_INT:{int32_t v;memcpy(&v,p,sizeof(v));return v<0;}
        case LN_LONG:{long v;memcpy(&v,p,sizeof(v));return v<0;}
        case LN_LONGLONG:{int64_t v;memcpy(&v,p,sizeof(v));return v<0;}
        default:return 0;
    }
}

static int
validate_integer_power(char **args,const ln_intp *dimensions,const ln_intp *steps,
                       const uint8_t *mask,ln_intp mask_step,void *data,ln_error *err)
{
    const ln_dtype *expdt=(const ln_dtype *)data;
    if(!expdt||expdt->kind!='i')return 0;
    for(ln_intp i=0;i<dimensions[0];++i){
        if(mask&&!*(const uint8_t *)((const char *)mask+i*mask_step))continue;
        if(negative_signed_scalar(args[1]+i*steps[1],expdt)){
            ufunc_error(err,"Integers to negative integer powers are not allowed.");return -1;
        }
    }
    return 0;
}

static ln_ufunc_loop frexp_loops[4],modf_loops[4],divmod_loops[14],ldexp_loops[8];
static ln_ufunc_loop arithmetic_loops[4][26];
static ln_ufunc_loop comparison_loops[6][24];
static ln_ufunc_loop unary_loops[9][22];
static ln_legacy_unary_adapter_data unary_data[9][22];
static ln_ufunc_loop math_unary_loops[21][7];
static ln_legacy_unary_adapter_data math_unary_data[21][7];
static ln_ufunc_loop migrated_binary_loops[16][24];
static ln_ufunc_loop isnat_loops[2];
static ln_binary_op time_cmp_ops[6];
static ln_binary_op time_minmax_ops[4]={LN_OP_MAXIMUM,LN_OP_MINIMUM,LN_OP_FMAX,LN_OP_FMIN};
static int time_add_validate_mode=0,time_sub_validate_mode=1;
static ln_ufunc ufuncs[80];
static size_t nufuncs=0;
static int registry_ready=0;

static void
append_ufunc(const char *name,int nin,int nout,const ln_ufunc_loop *loops,size_t nloops,ln_ufunc_resolve_fn resolve)
{
    ufuncs[nufuncs++]=(ln_ufunc){name,nin,nout,loops,nloops,resolve};
}

static void
init_registry(void)
{
    if(registry_ready)return;
    const ln_dtype_num floats[4]={LN_HALF,LN_FLOAT,LN_DOUBLE,LN_LONGDOUBLE};
    for(int i=0;i<4;++i){
        const ln_dtype *dt=ln_dtype_by_num(floats[i]);
        frexp_loops[i].classes[0]=dt->cls;frexp_loops[i].classes[1]=dt->cls;
        frexp_loops[i].classes[2]=ln_dtype_class_by_num(LN_INT);
        frexp_loops[i].loop=ln_get_frexp_loop(floats[i]);
        modf_loops[i].classes[0]=dt->cls;modf_loops[i].classes[1]=dt->cls;modf_loops[i].classes[2]=dt->cls;
        modf_loops[i].loop=ln_get_modf_loop(floats[i]);
    }
    const ln_dtype_num nums[14]={LN_BYTE,LN_UBYTE,LN_SHORT,LN_USHORT,LN_INT,LN_UINT,
        LN_LONG,LN_ULONG,LN_LONGLONG,LN_ULONGLONG,LN_HALF,LN_FLOAT,LN_DOUBLE,LN_LONGDOUBLE};
    for(int i=0;i<14;++i){
        const ln_dtype *dt=ln_dtype_by_num(nums[i]);
        for(int j=0;j<4;++j)divmod_loops[i].classes[j]=dt->cls;
        divmod_loops[i].loop=ln_get_divmod_loop(nums[i]);
    }
    const ln_dtype *i32=ln_dtype_by_num(LN_INT),*i64=ln_dtype_by_name("int64");
    for(int i=0;i<4;++i){
        const ln_dtype *dt=ln_dtype_by_num(floats[i]);int k=2*i;
        ldexp_loops[k].classes[0]=dt->cls;ldexp_loops[k].classes[1]=i32->cls;ldexp_loops[k].classes[2]=dt->cls;
        ldexp_loops[k].loop=ln_get_ldexp_loop(floats[i],i32->type_num);
        ldexp_loops[k+1].classes[0]=dt->cls;ldexp_loops[k+1].classes[1]=i64->cls;ldexp_loops[k+1].classes[2]=dt->cls;
        ldexp_loops[k+1].loop=ln_get_ldexp_loop(floats[i],i64->type_num);
    }
    append_ufunc("frexp",1,2,frexp_loops,4,resolve_float_unary);
    append_ufunc("modf",1,2,modf_loops,4,resolve_float_unary);
    append_ufunc("divmod",2,2,divmod_loops,14,resolve_divmod);
    append_ufunc("ldexp",2,1,ldexp_loops,8,resolve_safe_signature);

    const char *anames[4]={"add","subtract","multiply","true_divide"};
    const ln_binary_op aops[4]={LN_OP_ADD,LN_OP_SUBTRACT,LN_OP_MULTIPLY,LN_OP_TRUE_DIVIDE};
    ln_ufunc_resolve_fn ares[4]={resolve_add,resolve_subtract,resolve_multiply,resolve_true_divide};
    for(int i=0;i<4;++i){
        size_t n=fill_binary_loops(arithmetic_loops[i],aops[i],0);
        if(i==0||i==1){
            const ln_dtype_class *M=ln_datetime_dtype_class(0),*m=ln_datetime_dtype_class(1);
            const ln_dtype_class *sig[3][3];
            if(i==0){sig[0][0]=M;sig[0][1]=m;sig[0][2]=M;sig[1][0]=m;sig[1][1]=m;sig[1][2]=m;sig[2][0]=m;sig[2][1]=M;sig[2][2]=M;}
            else{sig[0][0]=M;sig[0][1]=m;sig[0][2]=M;sig[1][0]=m;sig[1][1]=m;sig[1][2]=m;sig[2][0]=M;sig[2][1]=M;sig[2][2]=m;}
            for(int k=0;k<3;++k){
                arithmetic_loops[i][n].classes[0]=sig[k][0];arithmetic_loops[i][n].classes[1]=sig[k][1];arithmetic_loops[i][n].classes[2]=sig[k][2];
                arithmetic_loops[i][n].loop=i==0?ln_datetime_add_loop:ln_datetime_subtract_loop;
                arithmetic_loops[i][n].validate=validate_datetime_arithmetic;
                arithmetic_loops[i][n].validate_data=i==0?(void*)&time_add_validate_mode:(void*)&time_sub_validate_mode;
                arithmetic_loops[i][n].resolve_descrs=resolve_time_binary_descrs;++n;
            }
        }
        if(i==0)for(int k=0;k<2;++k){
            ln_binary_math_string_add_method(&arithmetic_loops[i][n++],k);
        }
        if(i==2){ln_time_scale_method(&arithmetic_loops[i][n++],0,0);ln_time_scale_method(&arithmetic_loops[i][n++],1,0);
            ln_time_integer_multiply_method(&arithmetic_loops[i][n++],0);ln_time_integer_multiply_method(&arithmetic_loops[i][n++],1);}
        if(i==3){ln_time_scale_method(&arithmetic_loops[i][n++],0,1);
            ln_time_integer_divide_method(&arithmetic_loops[i][n++]);ln_time_ratio_method(&arithmetic_loops[i][n++]);}
        append_ufunc(anames[i],2,1,arithmetic_loops[i],n,ares[i]);
    }

    const char *cnames[6]={"equal","not_equal","less","less_equal","greater","greater_equal"};
    const ln_binary_op cops[6]={LN_OP_EQUAL,LN_OP_NOT_EQUAL,LN_OP_LESS,LN_OP_LESS_EQUAL,LN_OP_GREATER,LN_OP_GREATER_EQUAL};
    for(int i=0;i<6;++i){
        size_t n=fill_comparison_loops(comparison_loops[i],cops[i]);time_cmp_ops[i]=cops[i];
        const ln_dtype_class *M=ln_datetime_dtype_class(0),*m=ln_datetime_dtype_class(1),*bo=ln_dtype_class_by_num(LN_BOOL);
        const ln_dtype_class *tc[2]={M,m};
        for(int k=0;k<2;++k){comparison_loops[i][n].classes[0]=tc[k];comparison_loops[i][n].classes[1]=tc[k];comparison_loops[i][n].classes[2]=bo;comparison_loops[i][n].loop=ln_datetime_compare_loop;comparison_loops[i][n].data=&time_cmp_ops[i];comparison_loops[i][n].resolve_descrs=resolve_time_binary_descrs;++n;}
        const ln_dtype_class *sc[2]={ln_dtype_class_by_num(LN_STRING),ln_dtype_class_by_num(LN_UNICODE)};
        for(int k=0;k<2;++k){comparison_loops[i][n].classes[0]=sc[k];comparison_loops[i][n].classes[1]=sc[k];comparison_loops[i][n].classes[2]=bo;comparison_loops[i][n].loop=string_compare_loop;comparison_loops[i][n].data=&time_cmp_ops[i];comparison_loops[i][n].resolve_descrs=resolve_string_compare_descrs;comparison_loops[i][n].resolve_loop_data=resolve_string_compare_data;comparison_loops[i][n].free_loop_data=free;++n;}
        append_ufunc(cnames[i],2,1,comparison_loops[i],n,resolve_comparison);
    }

    const char *mnames[16]={"logical_and","logical_or","logical_xor","maximum","minimum",
        "floor_divide","remainder","power","bitwise_and","bitwise_or","bitwise_xor","fmax","fmin","copysign","arctan2","hypot"};
    const ln_binary_op mops[16]={LN_OP_LOGICAL_AND,LN_OP_LOGICAL_OR,LN_OP_LOGICAL_XOR,LN_OP_MAXIMUM,LN_OP_MINIMUM,
        LN_OP_FLOOR_DIVIDE,LN_OP_REMAINDER,LN_OP_POWER,LN_OP_BITWISE_AND,LN_OP_BITWISE_OR,LN_OP_BITWISE_XOR,LN_OP_FMAX,LN_OP_FMIN,LN_OP_COPYSIGN,LN_OP_ARCTAN2,LN_OP_HYPOT};
    for(int i=0;i<16;++i){
        int out_bool=(mops[i]==LN_OP_LOGICAL_AND||mops[i]==LN_OP_LOGICAL_OR||mops[i]==LN_OP_LOGICAL_XOR);
        size_t n=fill_binary_loops(migrated_binary_loops[i],mops[i],out_bool);
        if(mops[i]==LN_OP_MAXIMUM||mops[i]==LN_OP_MINIMUM||mops[i]==LN_OP_FMAX||mops[i]==LN_OP_FMIN){
            const ln_dtype_class *tc[2]={ln_datetime_dtype_class(0),ln_datetime_dtype_class(1)};
            for(int k=0;k<2;++k){
                migrated_binary_loops[i][n].classes[0]=tc[k];migrated_binary_loops[i][n].classes[1]=tc[k];migrated_binary_loops[i][n].classes[2]=tc[k];
                migrated_binary_loops[i][n].loop=ln_datetime_minmax_loop;
                int ti=(mops[i]==LN_OP_MAXIMUM)?0:(mops[i]==LN_OP_MINIMUM)?1:(mops[i]==LN_OP_FMAX)?2:3;
                migrated_binary_loops[i][n].data=&time_minmax_ops[ti];
                migrated_binary_loops[i][n].resolve_descrs=resolve_time_binary_descrs;++n;
            }
        }
        if(mops[i]==LN_OP_POWER){
            for(size_t j=0;j<n;++j){
                if(migrated_binary_loops[i][j].classes[1]->kind=='i'){
                    migrated_binary_loops[i][j].validate=validate_integer_power;
                    migrated_binary_loops[i][j].validate_data=(void *)ln_dtype_default_descr(migrated_binary_loops[i][j].classes[1]);
                }
            }
        }
        append_ufunc(mnames[i],2,1,migrated_binary_loops[i],n,resolve_legacy_binary);
    }

    const char *unames[9]={"negative","absolute","positive","sign","logical_not","isnan","isinf","isfinite","signbit"};
    const ln_binary_op uops[9]={LN_OP_NEGATIVE,LN_OP_ABSOLUTE,LN_OP_POSITIVE,LN_OP_SIGN,LN_OP_LOGICAL_NOT,LN_OP_ISNAN,LN_OP_ISINF,LN_OP_ISFINITE,LN_OP_SIGNBIT};
    for(int i=0;i<9;++i){
        size_t n=fill_unary_loops(unary_loops[i],unary_data[i],uops[i]);
        const ln_dtype_class *m=ln_datetime_dtype_class(1),*M=ln_datetime_dtype_class(0),*bo=ln_dtype_class_by_num(LN_BOOL),*d=ln_dtype_class_by_num(LN_DOUBLE);
        if(i==0||i==1||i==2||i==3){
            unary_loops[i][n].classes[0]=m;unary_loops[i][n].classes[1]=(i==3?d:m);
            unary_loops[i][n].loop=i==0?ln_timedelta_negative_loop:i==1?ln_timedelta_absolute_loop:i==2?ln_timedelta_positive_loop:ln_timedelta_sign_loop;
            unary_loops[i][n].resolve_descrs=resolve_time_unary_descrs;++n;
        }
        if(i==5||i==6||i==7){
            const ln_dtype_class *tc[2]={M,m};for(int k=0;k<2;++k){unary_loops[i][n].classes[0]=tc[k];unary_loops[i][n].classes[1]=bo;unary_loops[i][n].loop=i==5?ln_datetime_isnat_loop:i==6?ln_datetime_isinf_loop:ln_datetime_isfinite_loop;unary_loops[i][n].resolve_descrs=resolve_time_unary_descrs;++n;}
        }
        append_ufunc(unames[i],1,1,unary_loops[i],n,resolve_unary_exact);
    }
    {const ln_dtype_class *M=ln_datetime_dtype_class(0),*m=ln_datetime_dtype_class(1),*bo=ln_dtype_class_by_num(LN_BOOL),*tc[2]={M,m};for(int k=0;k<2;++k){isnat_loops[k].classes[0]=tc[k];isnat_loops[k].classes[1]=bo;isnat_loops[k].loop=ln_datetime_isnat_loop;isnat_loops[k].resolve_descrs=resolve_time_unary_descrs;}append_ufunc("isnat",1,1,isnat_loops,2,resolve_unary_exact);}

    const char *m_unames[21]={"sqrt","exp","log","sin","cos","tan","sinh","cosh","tanh",
        "exp2","log2","log10","expm1","log1p","cbrt","arcsin","arccos","arctan","arcsinh","arccosh","arctanh"};
    const ln_binary_op m_uops[21]={LN_OP_SQRT,LN_OP_EXP,LN_OP_LOG,LN_OP_SIN,LN_OP_COS,LN_OP_TAN,LN_OP_SINH,LN_OP_COSH,LN_OP_TANH,
        LN_OP_EXP2,LN_OP_LOG2,LN_OP_LOG10,LN_OP_EXPM1,LN_OP_LOG1P,LN_OP_CBRT,LN_OP_ARCSIN,LN_OP_ARCCOS,LN_OP_ARCTAN,LN_OP_ARCSINH,LN_OP_ARCCOSH,LN_OP_ARCTANH};
    for(int i=0;i<21;++i){
        size_t n=fill_math_unary_loops(math_unary_loops[i],math_unary_data[i],m_uops[i]);
        append_ufunc(m_unames[i],1,1,math_unary_loops[i],n,resolve_math_unary);
    }

    registry_ready=1;
}

const ln_ufunc *
ln_ufunc_by_name(const char *name)
{
    init_registry();if(!name)return NULL;
    for(size_t i=0;i<nufuncs;++i)if(strcmp(name,ufuncs[i].name)==0)return &ufuncs[i];
    const ln_ufunc *extra=ln_unary_math_by_name(name);
    if(extra)return extra;
    extra=ln_binary_math_by_name(name);
    return extra?extra:strcmp(name,"clip")==0?ln_clip_ufunc():NULL;
}

size_t
ln_ufunc_registry_count(void)
{
    init_registry();
    return nufuncs+ln_unary_math_count()+ln_binary_math_count()+1;
}

static int
materialize_weak_operand(const ln_ufunc *u,const ln_ufunc_operand *operand,
                         const ln_array *strong,ln_array *tmp,unsigned char *storage,
                         ln_error *err)
{
    if(!u||!operand||!strong||!strong->descr){ufunc_error(err,"invalid weak scalar operand");return -1;}
    ln_binary_op op=LN_OP_POWER;
    int float_power=strcmp(u->name,"float_power")==0;
    if(!float_power&&!legacy_binary_op_for_name(u->name,&op)){
        ufunc_error(err,"weak scalar resolution is not implemented for this ufunc");return -1;
    }
    const ln_dtype *dt=NULL;
    /* float_power registers double/longdouble loops even for small integers.
     * Preserve the scalar's full precision until that forced signature is
     * resolved, rather than overflowing or rounding in the strong input dtype. */
    if(op==LN_OP_LOGICAL_AND||op==LN_OP_LOGICAL_OR||op==LN_OP_LOGICAL_XOR){
        dt=ln_dtype_by_num(LN_BOOL);
    }else if(is_time_dtype(strong->descr)&&(op==LN_OP_ADD||op==LN_OP_SUBTRACT||(op>=LN_OP_EQUAL&&op<=LN_OP_GREATER_EQUAL))&&
            (operand->kind==LN_UFUNC_WEAK_INT||operand->kind==LN_UFUNC_WEAK_BOOL)){
        dt=ln_dtype_by_name("int64");
    }else if(strong->descr->kind=='m'&&op==LN_OP_TRUE_DIVIDE&&operand->kind==LN_UFUNC_WEAK_BOOL){
        dt=ln_dtype_by_num(LN_BOOL);
    }else if(strong->descr->kind=='m'&&(op==LN_OP_MULTIPLY||op==LN_OP_TRUE_DIVIDE)&&
            (operand->kind==LN_UFUNC_WEAK_INT||operand->kind==LN_UFUNC_WEAK_BOOL)){
        dt=ln_dtype_by_name("int64");
    }else if(float_power){
        switch(operand->kind){
        case LN_UFUNC_WEAK_BOOL:dt=ln_dtype_by_num(LN_BOOL);break;
        case LN_UFUNC_WEAK_INT:dt=ln_dtype_by_name("int64");break;
        case LN_UFUNC_WEAK_FLOAT:dt=ln_dtype_by_num(LN_DOUBLE);break;
        case LN_UFUNC_WEAK_COMPLEX:dt=ln_dtype_by_num(LN_CDOUBLE);break;
        default:break;
        }
    }else switch(operand->kind){
        case LN_UFUNC_WEAK_BOOL:
            dt=ln_resolve_weak_bool_dtype(strong,op,err);break;
        case LN_UFUNC_WEAK_INT:
            dt=ln_resolve_weak_scalar_dtype(strong,1,operand->integer,op,err);break;
        case LN_UFUNC_WEAK_FLOAT:
            dt=ln_resolve_weak_scalar_dtype(strong,0,0,op,err);break;
        case LN_UFUNC_WEAK_COMPLEX:
            dt=ln_resolve_weak_complex_dtype(strong,op,err);break;
        default:
            ufunc_error(err,"operand is not a weak scalar");return -1;
    }
    if(!dt)return -1;
    memset(tmp,0,sizeof(*tmp));
    memset(storage,0,sizeof(ln_clongdouble));
    tmp->data=(char *)storage;tmp->nd=0;tmp->descr=dt;
    tmp->flags=LN_ARRAY_WRITEABLE|LN_ARRAY_ALIGNED|LN_ARRAY_C_CONTIGUOUS|LN_ARRAY_F_CONTIGUOUS;
    if(operand->kind==LN_UFUNC_WEAK_COMPLEX&&dt->type_num==LN_BOOL){
        int truth=operand->real!=0.0L||operand->imag!=0.0L;
        return ln_array_pack_number(tmp,NULL,(double)truth,truth,1,err);
    }
    if(operand->kind==LN_UFUNC_WEAK_COMPLEX)
        return ln_array_pack_complex(tmp,NULL,operand->real,operand->imag,err);
    if(operand->kind==LN_UFUNC_WEAK_BOOL)
        return ln_array_pack_number(tmp,NULL,(double)operand->boolean,(int64_t)operand->boolean,1,err);
    if(operand->kind==LN_UFUNC_WEAK_INT)
        return ln_array_pack_number(tmp,NULL,(double)operand->integer,operand->integer,1,err);
    return ln_array_pack_number(tmp,NULL,operand->floating,0,0,err);
}

static int
resolve_loop_descriptors(const ln_ufunc *u, const ln_ufunc_loop *method,
                         const ln_array *const *inputs,
                         ln_ufunc_resolution *resolution, ln_error *err)
{
    if (!u || !method || !resolution) {
        ufunc_error(err, "invalid ufunc descriptor resolution");
        return -1;
    }
    memset(resolution, 0, sizeof(*resolution));
    resolution->method = method;
    if (method->resolve_descrs) {
        if (method->resolve_descrs(u,method,inputs,resolution->descrs,err)<0) return -1;
        return 0;
    }
    for (int i = 0; i < u->nin + u->nout; ++i) {
        const ln_dtype_class *cls = method->classes[i];
        if (!cls) {
            ufunc_error(err, "ufunc method has an incomplete DType-class signature");
            return -1;
        }
        /* Preserve a concrete input descriptor when it already belongs to the
         * selected class.  This is a no-op for today's singleton numerics, but
         * is the crucial distinction for future parametric descriptors. */
        if (i < u->nin && inputs[i] && inputs[i]->descr &&
                inputs[i]->descr->cls == cls) {
            resolution->descrs[i] = inputs[i]->descr;
        }
        else {
            resolution->descrs[i] = ln_dtype_default_descr(cls);
        }
        if (!resolution->descrs[i]) {
            ufunc_error(err, "DType class has no default descriptor");
            return -1;
        }
    }
    return 0;
}

int
ln_ufunc_execute_operands(const ln_ufunc *u,const ln_ufunc_operand *operands,
                          ln_array **outputs,const ln_array *where,ln_error *err)
{
    if(!u||!operands||!outputs||u->nin<1||u->nout<1||u->nin+u->nout>LN_UFUNC_MAXARGS){
        ufunc_error(err,"invalid ufunc call");return -1;
    }
    const ln_array *inputs[LN_UFUNC_MAXARGS]={0};
    ln_array temps[LN_UFUNC_MAXARGS];
    unsigned char storage[LN_UFUNC_MAXARGS][sizeof(ln_clongdouble)];
    char *dynamic_storage[LN_UFUNC_MAXARGS]={0};
    int weak_count=0,strong_count=0;
    for(int i=0;i<u->nin;++i){
        if(operands[i].kind==LN_UFUNC_OPERAND_ARRAY){
            if(!operands[i].array){ufunc_error(err,"invalid ndarray operand");return -1;}
            inputs[i]=operands[i].array;strong_count++;
        }else weak_count++;
    }
    if(weak_count){
        if(u->nin!=2||strong_count!=1||weak_count!=1){
            ufunc_error(err,"weak scalar execution currently requires one ndarray and one scalar");return -1;
        }
        int strong_i=(operands[0].kind==LN_UFUNC_OPERAND_ARRAY)?0:1;
        int weak_i=1-strong_i;
        if(operands[weak_i].kind==LN_UFUNC_WEAK_STRING){
            const ln_dtype_descr *sd=inputs[strong_i]->descr;
            if(!ln_string_is_dtype(sd)){
                int logical=strcmp(u->name,"logical_and")==0||strcmp(u->name,"logical_or")==0||strcmp(u->name,"logical_xor")==0;
                if(!logical){ufunc_error(err,"string scalar requires a string ndarray operand");return -1;}
                sd=ln_string_default_dtype(1);
            }
            size_t width=operands[weak_i].string_len;
            if(sd->type_num==LN_UNICODE && ln_string_utf8_codepoints(operands[weak_i].string,operands[weak_i].string_len,&width,err)<0)return -1;
            const ln_dtype_descr *dt=ln_string_make_dtype(sd->type_num==LN_UNICODE,width,sd->byteorder,err);if(!dt)return -1;
            size_t cap=dt->elsize?dt->elsize:1;dynamic_storage[weak_i]=(char*)calloc(1,cap);if(!dynamic_storage[weak_i]){ufunc_error(err,"out of memory");if(err)err->kind=LN_ERROR_MEMORY;return -1;}
            memset(&temps[weak_i],0,sizeof(temps[weak_i]));temps[weak_i].data=dynamic_storage[weak_i];temps[weak_i].nd=0;temps[weak_i].descr=dt;temps[weak_i].flags=LN_ARRAY_WRITEABLE|LN_ARRAY_ALIGNED|LN_ARRAY_C_CONTIGUOUS|LN_ARRAY_F_CONTIGUOUS;
            if(ln_string_pack_utf8(dt,dynamic_storage[weak_i],operands[weak_i].string,operands[weak_i].string_len,err)<0){free(dynamic_storage[weak_i]);return -1;}
        }else if(materialize_weak_operand(u,&operands[weak_i],inputs[strong_i],
                                   &temps[weak_i],storage[weak_i],err)<0)return -1;
        inputs[weak_i]=&temps[weak_i];
    }
    const ln_ufunc_loop *method=NULL;
    if(!u->resolve||u->resolve(u,inputs,&method,err)<0||!method||!method->loop){for(int j=0;j<LN_UFUNC_MAXARGS;++j)free(dynamic_storage[j]);return -1;}
    ln_ufunc_resolution resolution;
    if(resolve_loop_descriptors(u,method,inputs,&resolution,err)<0){for(int j=0;j<LN_UFUNC_MAXARGS;++j)free(dynamic_storage[j]);return -1;}
    void *loop_data=method->data;
    if(method->resolve_loop_data){
        loop_data=NULL;
        if(method->resolve_loop_data(method,resolution.descrs,&loop_data,err)<0){for(int j=0;j<LN_UFUNC_MAXARGS;++j)free(dynamic_storage[j]);return -1;}
    }
    /* NumPy's trivial single-output loop allocates a canonical C/F array
     * for exact equally shaped contiguous inputs and optional scalars. Singleton strides
     * follow NewLikeArray, rather than general iterator permutation strides. */
    ln_array *trivial_output=NULL;
    if(!where&&u->nout==1&&!outputs[0]&&(u->nin>=1&&u->nin<=3)) {
        int candidate=-1,eligible=1;
        unsigned common_order=LN_ARRAY_C_CONTIGUOUS|LN_ARRAY_F_CONTIGUOUS;
        for(int j=0;j<u->nin;++j)if(inputs[j]->nd) {
            const ln_array *input=inputs[j];
            if(input->descr!=resolution.descrs[j]){eligible=0;break;}
            common_order&=input->flags;
            if(candidate>=0){
                const ln_array *first=inputs[candidate];
                if(first->nd!=input->nd){eligible=0;break;}
                for(int d=0;d<input->nd;++d)if(first->dimensions[d]!=input->dimensions[d]){eligible=0;break;}
                if(!eligible)break;
            }else candidate=j;
        }
        if(eligible&&candidate>=0&&common_order) {
            const ln_array *input=inputs[candidate];
            if(input->descr==resolution.descrs[candidate]&&
                    (input->flags&(LN_ARRAY_C_CONTIGUOUS|LN_ARRAY_F_CONTIGUOUS))) {
                int fortran=!(common_order&LN_ARRAY_C_CONTIGUOUS);
                trivial_output=ln_array_new(input->nd,input->dimensions,
                        resolution.descrs[u->nin],fortran,0,err);
                if(!trivial_output){
                    if(method->resolve_loop_data&&method->free_loop_data)method->free_loop_data(loop_data);
                    for(int j=0;j<LN_UFUNC_MAXARGS;++j)free(dynamic_storage[j]);
                    return -1;
                }
                outputs[0]=trivial_output;
            }
        }
    }
    int uniform=strcmp(u->name,"clip")==0;
    int rc=(uniform?ln_nditer_multi_execute_uniform:ln_nditer_multi_execute)(u->nin,u->nout,inputs,outputs,where,
            resolution.descrs,method->loop,loop_data,method->validate,method->validate_data,err);
    if(rc<0&&trivial_output){ln_array_free(trivial_output);outputs[0]=NULL;}
    if(method->resolve_loop_data && method->free_loop_data)method->free_loop_data(loop_data);
    for(int j=0;j<LN_UFUNC_MAXARGS;++j)free(dynamic_storage[j]);
    return rc;
}

int
ln_ufunc_execute(const ln_ufunc *u,const ln_array *const *inputs,
                 ln_array **outputs,const ln_array *where,ln_error *err)
{
    if(!u||!inputs){ufunc_error(err,"invalid ufunc call");return -1;}
    ln_ufunc_operand operands[LN_UFUNC_MAXARGS];
    memset(operands,0,sizeof(operands));
    for(int i=0;i<u->nin;++i){operands[i].kind=LN_UFUNC_OPERAND_ARRAY;operands[i].array=inputs[i];}
    return ln_ufunc_execute_operands(u,operands,outputs,where,err);
}
