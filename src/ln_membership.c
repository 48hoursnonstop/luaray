#include "ln_membership.h"
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Integer lookup method from NumPy 2.5.5 lib/_arraysetops_impl.py.
 * Magnitude and sign keep mixed signed/unsigned values exact. */
typedef struct integer_value {
    uint64_t magnitude;
    int negative;
} integer_value;

static int is_integer(const ln_dtype *dtype)
{
    return dtype->kind=='i'||dtype->kind=='u'||dtype->kind=='b';
}

static uint64_t load_u64(const char *data,size_t width)
{
    switch(width){
        case 1:{uint8_t value;memcpy(&value,data,1);return value;}
        case 2:{uint16_t value;memcpy(&value,data,2);return value;}
        case 4:{uint32_t value;memcpy(&value,data,4);return value;}
        default:{uint64_t value;memcpy(&value,data,8);return value;}
    }
}

static integer_value integer_at(const ln_array *a,ln_intp index)
{
    const ln_dtype *dt=a->descr;
    uint64_t word=load_u64(a->data+index*a->strides[0],dt->elsize);
    if(dt->kind=='b')return (integer_value){word!=0,0};
    if(dt->kind=='u')return (integer_value){word,0};
    unsigned bits=(unsigned)(dt->elsize*CHAR_BIT);
    uint64_t sign=UINT64_C(1)<<(bits-1);
    if(!(word&sign))return (integer_value){word,0};
    uint64_t mask=sign|(sign-1);
    return (integer_value){((~word)&mask)+1,1};
}

static int less(integer_value a,integer_value b)
{
    if(a.negative!=b.negative)return a.negative;
    return a.negative?a.magnitude>b.magnitude:a.magnitude<b.magnitude;
}

/* The caller establishes that both endpoints fit the key dtype's range. */
static uint64_t distance(integer_value a,integer_value lower)
{
    if(a.negative)return lower.magnitude-a.magnitude;
    if(lower.negative)return lower.magnitude+a.magnitude;
    return a.magnitude-lower.magnitude;
}

static ln_array *fail(ln_error *err,const char *message)
{
    if(err)snprintf(err->message,sizeof err->message,"%s",message);
    return NULL;
}

ln_array *ln_isin_table(const ln_array *values,const ln_array *keys,int invert,
                        int force,int *fallback,ln_error *err)
{
    *fallback=0;
    if(!values||!keys||values->nd!=1||keys->nd!=1)
        return fail(err,"integer membership requires flat inputs");
    if(!is_integer(values->descr)||!is_integer(keys->descr)){
        if(force)return fail(err,"table membership requires integer or boolean arrays");
        *fallback=1;
        return NULL;
    }

    ln_intp n=values->dimensions[0],m=keys->dimensions[0];
    if(!m){
        ln_array *out=ln_array_new(1,&n,ln_dtype_by_num(LN_BOOL),0,0,err);
        if(out&&n)memset(out->data,invert!=0,(size_t)n);
        return out;
    }
    integer_value min=integer_at(keys,0),max=min;
    for(ln_intp i=1;i<m;++i){
        integer_value value=integer_at(keys,i);
        if(less(value,min))min=value;
        if(less(max,value))max=value;
    }
    uint64_t range=distance(max,min);
    uint64_t span_max=UINT64_MAX;
    if(keys->descr->kind=='i')
        span_max=(UINT64_C(1)<<(keys->descr->elsize*CHAR_BIT-1))-1;

    uint64_t combined=(uint64_t)n+(uint64_t)m;
    uint64_t auto_limit=combined>UINT64_MAX/6?UINT64_MAX:6*combined;
    if(range>span_max||range>=SIZE_MAX||(!force&&range>auto_limit)){
        if(force)return fail(err,"key range exceeds native table membership limits");
        *fallback=1;
        return NULL;
    }

    unsigned char *present=calloc((size_t)range+1,1);
    if(!present)return fail(err,"cannot allocate integer membership table");
    for(ln_intp i=0;i<m;++i)present[distance(integer_at(keys,i),min)]=1;

    ln_array *out=ln_array_new(1,&n,ln_dtype_by_num(LN_BOOL),0,0,err);
    if(out){
        for(ln_intp i=0;i<n;++i){
            integer_value value=integer_at(values,i);
            int found=!less(value,min)&&!less(max,value)&&present[distance(value,min)];
            out->data[i]=(char)(found!=(invert!=0));
        }
    }
    free(present);
    return out;
}
