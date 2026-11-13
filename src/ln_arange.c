/* NumPy 2.5.3 ctors.c:_calc_length/PyArray_ArangeObj and arraytypes fill loops.
 * Scalar initial packing precedes a native typed-delta fill, not repeated
 * addition of the original step. Integer fill wraps without signed C overflow. */
#include "ln_arange.h"
#include "ln_half.h"
#include "ln_complex.h"
#include "ln_datetime.h"
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
        default:return bad(err,"arange requires numeric scalars; temporal ranges need a temporal constructor");
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
static int fill(ln_array *result,ln_error *err)
{
    ln_intp count=result->dimensions[0];
    if(count<=2)return 0;
    const ln_dtype *dtype=result->descr;
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
        default:return bad(err,"unsupported arange fill loop");
    }
    return 0;
}
static ln_array *arange_arrays(const ln_ufunc_operand *,const ln_ufunc_operand *,const ln_ufunc_operand *,const ln_dtype *,ln_error *);
ln_array *ln_array_arange(const ln_ufunc_operand *from,const ln_ufunc_operand *to,
    const ln_ufunc_operand *by,const ln_dtype *dtype,ln_error *err)
{
    if(!from||!to||!by){bad(err,"arange requires start, stop and step");return NULL;}
    if(from->kind==LN_UFUNC_OPERAND_ARRAY||to->kind==LN_UFUNC_OPERAND_ARRAY||by->kind==LN_UFUNC_OPERAND_ARRAY)
        return arange_arrays(from,to,by,dtype,err);
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
    if(fill(result,err)<0){ln_array_free(result);return NULL;}
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
/* number.c:array_scalar_forward and arraytypes.c.src numeric setitem keep
 * original 0-D arrays distinct from the NumPy scalars produced by arithmetic. */
static int numeric(const ln_dtype *d)
{return d&&(d->kind=='b'||d->kind=='i'||d->kind=='u'||d->kind=='f'||d->kind=='c');}
#define READ_VALUE(TYPE,FIELD) do{TYPE range_loaded;memcpy(&range_loaded,a->data,sizeof range_loaded);*(FIELD)=range_loaded;}while(0)
static int read_array(const ln_array *a,scalar *value,long double *real,long double *imag,ln_error *err)
{
    if(!a||a->nd||(!numeric(a->descr)&&!ln_datetime_metadata(a->descr)))return bad(err,"arange array arguments must be rank-zero scalar arrays");
    memset(value,0,sizeof(*value));*imag=0;
    if(ln_datetime_metadata(a->descr)){
        int64_t ticks;memcpy(&ticks,a->data,8);value->integer=ticks;*real=ticks;
    }else if(a->descr->kind=='c'){
        value->kind=COMPLEX;
        if(ln_array_get_complex(a,NULL,real,imag,err)<0)return -1;
    }else if(a->descr->kind=='f'){
        value->kind=REAL;
        switch(a->descr->type_num){
            case LN_HALF:{ln_half v;memcpy(&v,a->data,2);*real=ln_half_to_float(v);break;}
            case LN_FLOAT:READ_VALUE(float,real);break;
            case LN_DOUBLE:READ_VALUE(double,real);break;
            case LN_LONGDOUBLE:READ_VALUE(long double,real);break;
            default:return bad(err,"unsupported arange real descriptor");
        }
    }else{
        range_int *v=&value->integer;
        switch(a->descr->type_num){
            case LN_BOOL:{uint8_t x;memcpy(&x,a->data,1);*v=!!x;break;}
            case LN_BYTE:READ_VALUE(int8_t,v);break;case LN_UBYTE:READ_VALUE(uint8_t,v);break;
            case LN_SHORT:READ_VALUE(int16_t,v);break;case LN_USHORT:READ_VALUE(uint16_t,v);break;
            case LN_INT:READ_VALUE(int,v);break;case LN_UINT:READ_VALUE(unsigned,v);break;
            case LN_LONG:READ_VALUE(long,v);break;case LN_ULONG:READ_VALUE(unsigned long,v);break;
            case LN_LONGLONG:READ_VALUE(long long,v);break;case LN_ULONGLONG:READ_VALUE(unsigned long long,v);break;
            default:return bad(err,"unsupported arange integer descriptor");
        }
        *real=(long double)*v;
    }
    value->real=(double)*real;value->imag=(double)*imag;return 0;
}
static int pack_typed(ln_array *result,ln_intp index,const ln_array *a,int original_array,ln_error *err)
{
    scalar value;long double real,imag;if(read_array(a,&value,&real,&imag,err)<0)return -1;
    const ln_dtype *out=result->descr;char *destination=result->data+index*(ln_intp)out->elsize;
    if(out->kind=='b'){*destination=(real!=0||imag!=0);return 0;}
    if(ln_datetime_metadata(a->descr)){
        int item=ln_datetime_integer_item((int64_t)value.integer,a->descr,err);
        if(item<0)return -1;
        if(!item)return bad(err,"temporal value does not have a numeric item representation");
    }
    if(out->kind=='i'||out->kind=='u'){
        if(original_array&&value.kind==COMPLEX&&a->descr->type_num!=LN_CLONGDOUBLE)
            return bad(err,"cannot convert a complex array to an integer scalar");
        if(value.kind!=INTEGER){
            long double truncated=truncl(real);
            if(!isfinite(truncated)||truncated< -0x1p63L||truncated>=0x1p64L)
                return bad(err,"arange initial scalar exceeds native integer bounds");
            value.integer=(range_int)truncated;value.kind=INTEGER;
        }
        if(!original_array)return pack(result,index,value,err);
        /* The original array path converts through native long/ulong and then
         * narrows; arithmetic NumPy scalars use the strict output bounds. */
        int unsigned_native=out->kind=='u'&&out->elsize>=sizeof(unsigned int);
        range_int upper=unsigned_native?(range_int)UINT64_MAX:(range_int)INT64_MAX;
        if(value.integer<INT64_MIN||value.integer>upper)return bad(err,"array scalar exceeds native conversion bounds");
        uint64_t raw=(uint64_t)value.integer;
        switch(out->elsize){
            case 1:{uint8_t v=(uint8_t)raw;memcpy(destination,&v,1);break;}
            case 2:{uint16_t v=(uint16_t)raw;memcpy(destination,&v,2);break;}
            case 4:{uint32_t v=(uint32_t)raw;memcpy(destination,&v,4);break;}
            case 8:memcpy(destination,&raw,8);break;
            default:return bad(err,"unsupported arange integer width");
        }
        return 0;
    }
    if(out->kind=='c'){
        if(a->descr->type_num==out->type_num){memcpy(destination,a->data,out->elsize);return 0;}
        return ln_array_pack_complex(result,&index,(double)real,(double)imag,err);
    }
    if(original_array&&value.kind==COMPLEX&&a->descr->type_num!=LN_CLONGDOUBLE&&out->type_num!=LN_LONGDOUBLE)
        return bad(err,"cannot convert a complex array to a real scalar");
    if(out->type_num==LN_LONGDOUBLE&&a->descr->type_num==LN_LONGDOUBLE){memcpy(destination,a->data,sizeof(long double));return 0;}
    value.kind=REAL;value.real=(double)real;value.imag=0;return pack(result,index,value,err);
}
static const ln_dtype *operand_dtype(const ln_ufunc_operand *op,ln_error *err)
{
    if(op->kind==LN_UFUNC_OPERAND_ARRAY){
        if(!op->array||op->array->nd||(!numeric(op->array->descr)&&!ln_datetime_metadata(op->array->descr))){bad(err,"arange requires rank-zero scalar arrays");return NULL;}
        const ln_datetime_meta *meta=ln_datetime_metadata(op->array->descr);
        if(meta&&meta->num<=0){bad(err,"arange requires positive temporal unit multipliers");return NULL;}
        return op->array->descr;
    }
    scalar value;if(unpack(op,&value,err)<0)return NULL;
    return ln_dtype_by_num(value.kind==INTEGER?LN_LONG:value.kind==REAL?LN_DOUBLE:LN_CDOUBLE);
}
static ln_array *calculate(const char *name,ln_ufunc_operand a,ln_ufunc_operand b,ln_error *err)
{
    ln_ufunc_operand inputs[]={a,b};ln_array *result=NULL;
    if(ln_ufunc_execute_operands(ln_ufunc_by_name(name),inputs,&result,NULL,err)<0)return NULL;
    return result;
}
static ln_array *arange_arrays(const ln_ufunc_operand *from,const ln_ufunc_operand *to,
    const ln_ufunc_operand *by,const ln_dtype *dtype,ln_error *err)
{
    const ln_ufunc_operand *all[]={from,to,by};const ln_dtype *inferred=ln_dtype_by_name("intp");
    for(int i=0;i<3;++i){
        const ln_dtype *d=operand_dtype(all[i],err);if(!d)return NULL;
        if(!dtype){inferred=ln_promote_dtype(inferred,d);if(!inferred){bad(err,"cannot infer arange dtype");return NULL;}}
    }
    if(!dtype)dtype=inferred;
    if(!numeric(dtype)){bad(err,"arange does not support this output dtype");return NULL;}
    ln_array *delta=NULL,*quotient=NULL,*next=NULL,*result=NULL;
    ln_ufunc_operand diff={0};scalar difference={0},first={0};
    long double dr=0,di=0,qr,qi;
    /* Python scalar subtraction remains unbounded before meeting a typed
     * step. A 65-bit positive difference can meet uint64 without narrowing. */
    uint64_t wide_storage=0;ln_array wide_array={.nd=0,.data=(char*)&wide_storage,
        .flags=LN_ARRAY_C_CONTIGUOUS|LN_ARRAY_F_CONTIGUOUS|LN_ARRAY_ALIGNED};
    if(from->kind==LN_UFUNC_OPERAND_ARRAY||to->kind==LN_UFUNC_OPERAND_ARRAY){
        delta=calculate("subtract",*to,*from,err);if(!delta)goto finish;
        scalar v;if(read_array(delta,&v,&dr,&di,err)<0)goto finish;
        diff.kind=LN_UFUNC_OPERAND_ARRAY;diff.array=delta;
    }else{
        scalar start,stop;
        if(unpack(from,&start,err)<0||unpack(to,&stop,err)<0)goto finish;
        difference=stop;
        if(start.kind==INTEGER&&stop.kind==INTEGER){
            difference.integer-=start.integer;difference.real=(double)difference.integer;
        }else{
            difference.kind=start.kind>stop.kind?start.kind:stop.kind;
            difference.real-=start.real;
            difference.imag=start.kind==COMPLEX&&stop.kind!=COMPLEX?-start.imag:stop.imag-start.imag;
        }
        dr=difference.kind==INTEGER?(long double)difference.integer:difference.real;di=difference.imag;
        if(difference.kind==COMPLEX){diff.kind=LN_UFUNC_WEAK_COMPLEX;diff.real=difference.real;diff.imag=difference.imag;}
        else if(difference.kind==REAL){diff.kind=LN_UFUNC_WEAK_FLOAT;diff.floating=difference.real;}
        else if(difference.integer>=INT64_MIN&&difference.integer<=INT64_MAX){diff.kind=LN_UFUNC_WEAK_INT;diff.integer=(int64_t)difference.integer;}
        else if(by->array->descr->kind=='f'||by->array->descr->kind=='c'){diff.kind=LN_UFUNC_WEAK_FLOAT;diff.floating=difference.real;}
        else if(by->array->descr->kind=='u'&&by->array->descr->elsize==8&&difference.integer>=0){
            wide_storage=(uint64_t)difference.integer;wide_array.descr=by->array->descr;
            diff.kind=LN_UFUNC_OPERAND_ARRAY;diff.array=&wide_array;
        }else{bad(err,"integer difference exceeds the typed step's scalar bounds");goto finish;}
    }
    quotient=calculate("true_divide",diff,*by,err);if(!quotient)goto finish;
    scalar q;if(read_array(quotient,&q,&qr,&qi,err)<0)goto finish;
    if(ln_datetime_metadata(quotient->descr)){
        int item=ln_datetime_integer_item((int64_t)q.integer,quotient->descr,err);
        if(item<0)goto finish;
        if(!item){bad(err,"temporal quotient cannot be converted to a numeric length");goto finish;}
    }
    ln_intp count;
    if(dtype->kind=='c'&&quotient->descr->type_num==LN_CDOUBLE){
        ln_intp real_count,imag_count;
        if(ceiling((double)qr,&real_count,err)<0||ceiling((double)qi,&imag_count,err)<0)goto finish;
        count=real_count<imag_count?real_count:imag_count;
    }else if(qr==0&&qi==0&&(dr!=0||di!=0))count=signbit((double)qr)?0:1;
    else if(ceiling((double)qr,&count,err)<0)goto finish;
    if(count>2&&dtype->kind=='b'){bad(err,"Boolean arange supports at most two elements");goto finish;}
    if(count){
        if(from->kind==LN_UFUNC_OPERAND_ARRAY||by->kind==LN_UFUNC_OPERAND_ARRAY){
            next=calculate("add",*from,*by,err);if(!next)goto finish;
        }else{
            scalar step;if(unpack(from,&first,err)<0||unpack(by,&step,err)<0)goto finish;
            first=add(first,step);
        }
    }
    result=ln_array_new(1,&count,dtype,0,0,err);if(!result||!count)goto finish;
    int rc;
    if(from->kind==LN_UFUNC_OPERAND_ARRAY)rc=pack_typed(result,0,from->array,!from->scalar_object,err);
    else{scalar start;rc=unpack(from,&start,err);if(!rc)rc=pack(result,0,start,err);}
    if(!rc&&count>1)rc=next?pack_typed(result,1,next,0,err):pack(result,1,first,err);
    if(!rc)rc=fill(result,err);
    if(rc<0){ln_array_free(result);result=NULL;}
finish:
    ln_array_free(delta);ln_array_free(quotient);ln_array_free(next);return result;
}
