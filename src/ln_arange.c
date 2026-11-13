/* NumPy 2.5.3 ctors.c:_calc_length/PyArray_ArangeObj and arraytypes fill loops.
 * Scalar initial packing precedes a native typed-delta fill, not repeated
 * addition of the original step. Integer fill wraps without signed C overflow. */
#include "ln_arange.h"
#include "ln_half.h"
#include "ln_complex.h"
#include <limits.h>
#include <math.h>
#include <stdio.h>
#include <string.h>
__extension__ typedef __int128 range_int;
typedef struct {int kind;range_int integer;double real,imag;} scalar;
enum {INTEGER,REAL,COMPLEX};
static int bad(ln_error *err,const char *message)
{if(err)snprintf(err->message,sizeof err->message,"%s",message);return -1;}
static int unpack(const ln_ufunc_operand *input,scalar *value,ln_error *err)
{
    memset(value,0,sizeof(*value));
    switch(input->kind){
        case LN_UFUNC_WEAK_BOOL:value->integer=!!input->boolean;break;
        case LN_UFUNC_WEAK_INT:value->integer=input->integer;break;
        case LN_UFUNC_WEAK_FLOAT:value->kind=REAL;value->real=input->floating;break;
        case LN_UFUNC_WEAK_COMPLEX:value->kind=COMPLEX;value->real=(double)input->real;value->imag=(double)input->imag;break;
        default:return bad(err,"arange requires numeric Lua scalars; typed arrays and temporal ranges are not supported here");
    }
    if(value->kind==INTEGER)value->real=(double)value->integer;
    return 0;
}
static scalar add(scalar a,scalar b)
{
    if(a.kind==INTEGER&&b.kind==INTEGER){a.integer+=b.integer;a.real=(double)a.integer;return a;}
    if(a.kind!=COMPLEX&&b.kind==COMPLEX)a.imag=b.imag;
    else if(a.kind==b.kind)a.imag+=b.imag;
    a.kind=a.kind>b.kind?a.kind:b.kind;a.real+=b.real;return a;
}
static int ceiling(double value,ln_intp *count,ln_error *err)
{
    double rounded=ceil(value);
    if(!isfinite(rounded)||(long double)rounded>(long double)INTPTR_MAX||
       (long double)rounded<(long double)INTPTR_MIN)return bad(err,"arange cannot compute a finite native length");
    *count=rounded>0?(ln_intp)rounded:0;return 0;
}
static int length(scalar start,scalar stop,scalar step,int complex_dtype,ln_intp *count,ln_error *err)
{
    if(step.real==0&&step.imag==0)return bad(err,"arange step cannot be zero");
    if(start.kind!=COMPLEX&&stop.kind!=COMPLEX&&step.kind!=COMPLEX){
        double delta,quotient;
        if(start.kind==INTEGER&&stop.kind==INTEGER){
            range_int exact=stop.integer-start.integer;
            delta=(double)exact;
            quotient=step.kind==INTEGER?(double)((long double)exact/(long double)step.integer):delta/step.real;
        }else{delta=stop.real-start.real;quotient=delta/step.real;}
        if(quotient==0&&delta!=0){*count=signbit(quotient)?0:1;return 0;}
        return ceiling(quotient,count,err);
    }
    if(!complex_dtype)return bad(err,"complex arange arguments require a complex output dtype");
    double real=stop.real-start.real,imag;
    if(start.kind!=COMPLEX&&stop.kind==COMPLEX)imag=stop.imag;
    else if(start.kind==COMPLEX&&stop.kind!=COMPLEX)imag=-start.imag;
    else imag=stop.imag-start.imag;
    double qr,qi;
    if(step.kind!=COMPLEX){qr=real/step.real;qi=imag/step.real;}
    else if(fabs(step.real)>=fabs(step.imag)){
        double ratio=step.imag/step.real,denominator=step.real+step.imag*ratio;
        qr=(real+imag*ratio)/denominator;qi=(imag-real*ratio)/denominator;
    }else if(fabs(step.imag)>=fabs(step.real)){
        double ratio=step.real/step.imag,denominator=step.real*ratio+step.imag;
        qr=(real*ratio+imag)/denominator;qi=(imag*ratio-real)/denominator;
    }else qr=qi=NAN;
    /* Scalar complex division recovers signed zeros for finite numerators
     * and infinite denominators (C11 Annex G.5.2), including inf+inf*j. */
    if(isnan(qr)&&isnan(qi)&&isfinite(real)&&isfinite(imag)&&
       (isinf(step.real)||isinf(step.imag))){
        double x=copysign(isinf(step.real)?1:0,step.real);
        double y=copysign(isinf(step.imag)?1:0,step.imag);
        qr=0.0*(real*x+imag*y);qi=0.0*(imag*x-real*y);
    }
    ln_intp nr,ni;if(ceiling(qr,&nr,err)<0||ceiling(qi,&ni,err)<0)return -1;
    *count=nr<ni?nr:ni;return 0;
}
static int pack(ln_array *array,ln_intp index,scalar value,ln_error *err)
{
    char *destination=array->data+index*(ln_intp)array->descr->elsize;
    const ln_dtype *dtype=array->descr;
    if(value.kind==COMPLEX)return ln_array_pack_complex(array,&index,value.real,value.imag,err);
    if(dtype->kind=='c')return ln_array_pack_complex(array,&index,value.real,0,err);
    if(value.kind==REAL)return ln_array_pack_number(array,&index,value.real,0,0,err);
    if(dtype->kind=='b'){*destination=value.integer!=0;return 0;}
    if(dtype->kind=='i'||dtype->kind=='u'){
        int bits=(int)(dtype->elsize*CHAR_BIT);
        range_int lower=dtype->kind=='u'?0:-((range_int)1<<(bits-1));
        range_int upper=dtype->kind=='u'?((range_int)1<<bits)-1:((range_int)1<<(bits-1))-1;
        if(value.integer<lower||value.integer>upper)return bad(err,"arange initial scalar is outside output integer bounds");
        uint64_t raw=(uint64_t)value.integer;
        /* Native-endian stores without assuming that a short integer occupies
         * the first bytes of uint64 on a big-endian machine. */
        switch(dtype->elsize){
            case 1:{uint8_t v=(uint8_t)raw;memcpy(destination,&v,1);break;}
            case 2:{uint16_t v=(uint16_t)raw;memcpy(destination,&v,2);break;}
            case 4:{uint32_t v=(uint32_t)raw;memcpy(destination,&v,4);break;}
            case 8:memcpy(destination,&raw,8);break;
            default:return bad(err,"unsupported arange integer width");
        }
        return 0;
    }
    if(dtype->type_num==LN_LONGDOUBLE){long double v=(long double)value.integer;memcpy(destination,&v,sizeof v);return 0;}
    return ln_array_pack_number(array,&index,value.real,0,0,err);
}
#define FILL_INTEGER(TYPE) do { \
    TYPE first,second;memcpy(&first,data,sizeof first);memcpy(&second,data+sizeof first,sizeof second); \
    uint64_t delta=(uint64_t)second-(uint64_t)first; \
    for(ln_intp i=2;i<count;++i){TYPE value=(TYPE)((uint64_t)first+(uint64_t)i*delta);memcpy(data+i*sizeof value,&value,sizeof value);} \
}while(0)
#define FILL_REAL(TYPE) do { \
    TYPE first,second;memcpy(&first,data,sizeof first);memcpy(&second,data+sizeof first,sizeof second);TYPE delta=second-first; \
    for(ln_intp i=2;i<count;++i){TYPE value=first+i*delta;memcpy(data+i*sizeof value,&value,sizeof value);} \
}while(0)
#define FILL_COMPLEX(TYPE) do { \
    TYPE first,second;memcpy(&first,data,sizeof first);memcpy(&second,data+sizeof first,sizeof second);TYPE delta={second.real-first.real,second.imag-first.imag}; \
    for(ln_intp i=2;i<count;++i){TYPE value={first.real+i*delta.real,first.imag+i*delta.imag};memcpy(data+i*sizeof value,&value,sizeof value);} \
}while(0)
ln_array *ln_array_arange(const ln_ufunc_operand *from,const ln_ufunc_operand *to,
    const ln_ufunc_operand *by,const ln_dtype *dtype,ln_error *err)
{
    if(!from||!to||!by){bad(err,"arange requires start, stop and step");return NULL;}
    scalar start,stop,step;
    if(unpack(from,&start,err)<0||unpack(to,&stop,err)<0||unpack(by,&step,err)<0)return NULL;
    if(!dtype)dtype=ln_dtype_by_num(start.kind==COMPLEX||stop.kind==COMPLEX||step.kind==COMPLEX?LN_CDOUBLE:
                                  start.kind==REAL||stop.kind==REAL||step.kind==REAL?LN_DOUBLE:LN_LONG);
    if(dtype->kind!='b'&&dtype->kind!='i'&&dtype->kind!='u'&&dtype->kind!='f'&&dtype->kind!='c'){
        bad(err,"arange does not support this output dtype");return NULL;
    }
    ln_intp count;if(length(start,stop,step,dtype->kind=='c',&count,err)<0)return NULL;
    if(count>2&&dtype->kind=='b'){bad(err,"Boolean arange supports at most two elements");return NULL;}
    ln_array *result=ln_array_new(1,&count,dtype,0,0,err);if(!result||!count)return result;
    if(pack(result,0,start,err)<0||(count>1&&pack(result,1,add(start,step),err)<0)){
        ln_array_free(result);return NULL;
    }
    if(count<=2)return result;
    char *data=result->data;
    switch(dtype->type_num){
        case LN_BYTE:FILL_INTEGER(int8_t);break;case LN_UBYTE:FILL_INTEGER(uint8_t);break;
        case LN_SHORT:FILL_INTEGER(int16_t);break;case LN_USHORT:FILL_INTEGER(uint16_t);break;
        case LN_INT:FILL_INTEGER(int);break;case LN_UINT:FILL_INTEGER(unsigned);break;
        case LN_LONG:FILL_INTEGER(long);break;case LN_ULONG:FILL_INTEGER(unsigned long);break;
        case LN_LONGLONG:FILL_INTEGER(long long);break;case LN_ULONGLONG:FILL_INTEGER(unsigned long long);break;
        case LN_FLOAT:FILL_REAL(float);break;case LN_DOUBLE:FILL_REAL(double);break;
        case LN_LONGDOUBLE:FILL_REAL(long double);break;
        case LN_CFLOAT:FILL_COMPLEX(ln_cfloat);break;case LN_CDOUBLE:FILL_COMPLEX(ln_cdouble);break;
        case LN_CLONGDOUBLE:FILL_COMPLEX(ln_clongdouble);break;
        case LN_HALF:{
            ln_half a,b;memcpy(&a,data,2);memcpy(&b,data+2,2);
            float first=ln_half_to_float(a),delta=ln_half_to_float(b)-first;
            for(ln_intp i=2;i<count;++i){ln_half v=ln_float_to_half(first+i*delta);memcpy(data+2*i,&v,2);}break;
        }
        default:ln_array_free(result);bad(err,"unsupported arange fill loop");return NULL;
    }
    return result;
}
ln_array *ln_array_arange_legacy(ln_intp stop,const ln_dtype *dtype,ln_error *err)
{
    if(!dtype){bad(err,"legacy arange requires a dtype");return NULL;}
    if(stop<0)stop=0;
    if(stop&&(dtype->kind=='S'||dtype->kind=='U')){
        bad(err,"legacy arange does not convert numeric indices to strings");return NULL;
    }
    ln_array *result=ln_array_new(1,&stop,dtype,0,0,err);if(!result)return NULL;
    for(ln_intp i=0;i<stop;++i)if(ln_array_set_number(result,&i,(double)i,i,1,err)<0){ln_array_free(result);return NULL;}
    return result;
}
