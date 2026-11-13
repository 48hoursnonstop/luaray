/* NumPy 2.5.3 datetime.c:datetime_arange/convert_pyobjects_to_datetimes.
 * Resolve argument units first, then evaluate an integer tick timeline. */
#include "ln_arange.h"
#include "ln_datetime_strings.h"
#include <ctype.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
__extension__ typedef __int128 time_int;
static int bad(ln_error *err,const char *text)
{if(err)snprintf(err->message,sizeof err->message,"%s",text);return -1;}
static int temporal(const ln_ufunc_operand *arg)
{
    if(!arg||arg->kind!=LN_UFUNC_OPERAND_ARRAY||!arg->array)return 0;
    return arg->array->descr->kind=='M'?1:arg->array->descr->kind=='m'?2:0;
}
static int cast_tick(int64_t value,const ln_datetime_meta *source,
    const ln_datetime_meta *target,int duration,int64_t *out,ln_error *err)
{
    if(value==LN_DATETIME_NAT||(source->base==target->base&&source->num==target->num)){*out=value;return 0;}
    if(duration)return ln_datetime_cast_value(value,source,target,out,err);
    ln_datetimestruct date;
    if(ln_datetime_value_to_struct(value,source,&date,err)<0)return -1;
    return ln_datetime_struct_to_value(&date,target,out,err);
}
static int convert(const ln_ufunc_operand *arg,int duration,
    const ln_datetime_meta *requested,int64_t *value,ln_datetime_meta *meta,ln_error *err)
{
    *meta=requested?*requested:(ln_datetime_meta){LN_FR_GENERIC,1};
    if(!arg){*value=LN_DATETIME_NAT;return 0;}
    if(arg->kind==LN_UFUNC_WEAK_INT||arg->kind==LN_UFUNC_WEAK_BOOL){
        if(!duration&&(!requested||requested->base==LN_FR_GENERIC))return bad(err,"integer datetimes require a specified unit");
        *value=arg->kind==LN_UFUNC_WEAK_BOOL?!!arg->boolean:arg->integer;return 0;
    }
    if(arg->kind==LN_UFUNC_WEAK_STRING){
        if(arg->string_len==SIZE_MAX||!arg->string||memchr(arg->string,0,arg->string_len))return bad(err,"invalid temporal string");
        char *text=malloc(arg->string_len+1);if(!text)return bad(err,"out of memory");
        memcpy(text,arg->string,arg->string_len);text[arg->string_len]=0;
        int result=0;
        if(duration){
            if(!arg->string_len||(arg->string_len==3&&tolower((unsigned char)text[0])=='n'&&tolower((unsigned char)text[1])=='a'&&tolower((unsigned char)text[2])=='t'))*value=LN_DATETIME_NAT;
            else{
                char *end;long long parsed=strtoll(text,&end,10);
                if(end!=text+arg->string_len)result=bad(err,"timedelta strings must be complete decimal integers");
                else *value=(int64_t)parsed;
            }
        }else{
            const ln_dtype *dtype=requested?ln_datetime_make_dtype(0,*requested,err):NULL,*parsed=NULL;
            if(requested&&!dtype)result=-1;
            else{
                result=ln_datetime_parse_iso8601(text,dtype,&parsed,value,NULL,err);
                if(!result)*meta=*ln_datetime_metadata(parsed);
            }
        }
        free(text);return result;
    }
    if(arg->kind!=LN_UFUNC_OPERAND_ARRAY||!arg->array||arg->array->nd||temporal(arg)!=(duration?2:1))
        return bad(err,"range argument cannot be converted to the requested temporal kind");
    const ln_datetime_meta *source=ln_datetime_metadata(arg->array->descr);
    if(!source||source->num<=0)return bad(err,"temporal range units must have a positive multiplier");
    memcpy(value,arg->array->data,8);
    if(!requested){*meta=*source;return 0;}
    if(*value!=LN_DATETIME_NAT&&!ln_datetime_can_cast_same_kind(source,requested,duration))
        return bad(err,"temporal range units cannot be cast with same_kind");
    return cast_tick(*value,source,requested,duration,value,err);
}
ln_array *ln_array_arange_time(const ln_ufunc_operand *start,const ln_ufunc_operand *stop,
    const ln_ufunc_operand *step,const ln_dtype *dtype,ln_error *err)
{
    if(!stop){bad(err,"temporal arange requires a stopping value");return NULL;}
    if(temporal(step)==1){bad(err,"a datetime cannot be used as a range step");return NULL;}
    int duration;ln_datetime_meta common={LN_FR_GENERIC,1};const ln_datetime_meta *fixed=NULL;
    if(dtype){
        if(dtype->kind!='M'&&dtype->kind!='m'){bad(err,"temporal arange requires a datetime or timedelta dtype");return NULL;}
        duration=dtype->kind=='m';common=*ln_datetime_metadata(dtype);
        if(common.num<=0){bad(err,"temporal range units must have a positive multiplier");return NULL;}
        if(common.base!=LN_FR_GENERIC)fixed=&common;
    }else duration=temporal(start)!=1&&temporal(stop)!=1;
    if(!duration&&!start){bad(err,"datetime arange requires both start and stop");return NULL;}
    int relative=!duration&&(stop->kind==LN_UFUNC_WEAK_INT||stop->kind==LN_UFUNC_WEAK_BOOL||temporal(stop)==2);
    int kinds[]={duration,duration||relative,1};
    const ln_ufunc_operand *args[]={start,stop,step};int64_t ticks[3];ln_datetime_meta metas[3];
    for(int i=0;i<3;++i)if(convert(args[i],kinds[i],fixed,&ticks[i],&metas[i],err)<0)return NULL;
    if(!fixed){
        common=metas[0];int strict=kinds[0];
        for(int i=1;i<3;++i){
            ln_datetime_meta next;
            if(ln_datetime_metadata_gcd(&metas[i],&common,kinds[i],strict,&next,err)<0)return NULL;
            common=next;strict|=kinds[i];
        }
        for(int i=0;i<3;++i)if(cast_tick(ticks[i],&metas[i],&common,kinds[i],&ticks[i],err)<0)return NULL;
    }
    if(!start)ticks[0]=0;
    if(!step)ticks[2]=1;
    if(relative){
        time_int end=(time_int)ticks[0]+ticks[1];
        if(end<INT64_MIN||end>INT64_MAX){bad(err,"temporal range relative stop overflows int64");return NULL;}
        ticks[1]=(int64_t)end;
    }
    if(ticks[0]==LN_DATETIME_NAT||ticks[1]==LN_DATETIME_NAT||ticks[2]==LN_DATETIME_NAT){bad(err,"temporal arange cannot use NaT");return NULL;}
    if(!ticks[2]){bad(err,"temporal arange step cannot be zero");return NULL;}
    time_int length=0;
    if((ticks[2]>0&&ticks[1]>ticks[0])||(ticks[2]<0&&ticks[1]<ticks[0])){
        time_int numerator=(time_int)ticks[1]-ticks[0]+ticks[2]+(ticks[2]>0?-1:1);
        /* Upstream uses signed int64 intermediates here. Reject overflowing
         * source states instead of inheriting wrap-dependent lengths. */
        if(numerator<INT64_MIN||numerator>INT64_MAX){bad(err,"temporal range length arithmetic overflows int64");return NULL;}
        length=numerator/ticks[2];
    }
    if(length<0||length>INTPTR_MAX){bad(err,"temporal range is too large");return NULL;}
    const ln_dtype *result_dtype=fixed?dtype:ln_datetime_make_dtype(duration,common,err);
    if(!result_dtype)return NULL;
    ln_intp count=(ln_intp)length;ln_array *result=ln_array_new(1,&count,result_dtype,0,0,err);if(!result)return NULL;
    uint64_t current=(uint64_t)ticks[0],stride=(uint64_t)ticks[2];
    for(ln_intp i=0;i<count;++i){memcpy(result->data+8*i,&current,8);current+=stride;}
    return result;
}
