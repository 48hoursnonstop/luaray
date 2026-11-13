#include "ln_arange.h"
#include "ln_datetime_strings.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>
static ln_ufunc_operand number(int64_t n)
{ln_ufunc_operand a={.kind=LN_UFUNC_WEAK_INT,.integer=n};return a;}
static ln_ufunc_operand text(const char *s)
{ln_ufunc_operand a={.kind=LN_UFUNC_WEAK_STRING,.string=s,.string_len=strlen(s)};return a;}
static ln_array *point(const char *dtype,int64_t ticks,ln_error *err)
{
    ln_array *a=ln_array_new(0,NULL,ln_dtype_by_name(dtype),0,0,err);assert(a);memcpy(a->data,&ticks,8);return a;
}
static int64_t tick(const ln_array *a,int index)
{int64_t n;memcpy(&n,a->data+index*8,8);return n;}
int main(void)
{
    ln_error error={0};ln_ufunc_operand a=text("2020-02-28"),b=text("2020-03-02"),step=number(1);
    const ln_dtype *days=ln_dtype_by_name("datetime64[D]");
    ln_array *r=ln_array_arange_time(&a,&b,NULL,days,&error);assert(r&&r->dimensions[0]==3&&tick(r,1)==18321);
    ln_datetimestruct date;assert(!ln_datetime_value_to_struct(tick(r,1),ln_datetime_metadata(r->descr),&date,&error));
    assert(date.year==2020&&date.month==2&&date.day==29);ln_array_free(r);
    ln_array *start=point("datetime64[D]",100,&error);a=(ln_ufunc_operand){.kind=LN_UFUNC_OPERAND_ARRAY,.array=start};b=number(3);
    r=ln_array_arange_time(&a,&b,NULL,NULL,&error);assert(r&&r->dimensions[0]==3&&tick(r,0)==100&&tick(r,2)==102&&r->owner!=start->owner);ln_array_free(r);
    ln_array *nat=point("timedelta64[D]",LN_DATETIME_NAT,&error);b=(ln_ufunc_operand){.kind=LN_UFUNC_OPERAND_ARRAY,.array=nat};
    r=ln_array_arange_time(&a,&b,NULL,NULL,&error);assert(r&&r->dimensions[0]==0);ln_array_free(r);ln_array_free(nat);
    int64_t maximum=INT64_MAX;memcpy(start->data,&maximum,8);b=number(1);
    assert(!ln_array_arange_time(&a,&b,NULL,NULL,&error));ln_array_free(start);
    ln_array *end=point("timedelta64[h]",3,&error);b=(ln_ufunc_operand){.kind=LN_UFUNC_OPERAND_ARRAY,.array=end};
    end->flags&=~LN_ARRAY_WRITEABLE;
    r=ln_array_arange_time(NULL,&b,NULL,NULL,&error);assert(r&&r->dimensions[0]==3&&tick(r,2)==2&&!strcmp(r->descr->name,"timedelta64[h]"));
    assert((r->flags&LN_ARRAY_WRITEABLE)&&!(end->flags&LN_ARRAY_WRITEABLE));ln_array_free(r);
    step=number(0);assert(!ln_array_arange_time(NULL,&b,&step,NULL,&error));
    assert(!ln_array_arange_time(NULL,NULL,NULL,NULL,&error));
    a=(ln_ufunc_operand){.kind=LN_UFUNC_OPERAND_ARRAY,.array=end};
    assert(!ln_array_arange_time(&a,&b,NULL,days,&error));ln_array_free(end);
    start=point("datetime64[ns]",0,&error);end=point("datetime64[ns]",5,&error);
    a=(ln_ufunc_operand){.kind=LN_UFUNC_OPERAND_ARRAY,.array=start};b=(ln_ufunc_operand){.kind=LN_UFUNC_OPERAND_ARRAY,.array=end};step=number(2);
    r=ln_array_arange_time(&a,&b,&step,NULL,&error);assert(r&&r->dimensions[0]==3&&tick(r,2)==4);ln_array_free(r);
    r=ln_array_arange(&a,&b,&step,ln_dtype_by_name("int64"),&error);assert(r&&r->dimensions[0]==2&&tick(r,1)==2);ln_array_free(r);ln_array_free(start);ln_array_free(end);
    start=point("timedelta64",256,&error);end=point("timedelta64",257,&error);
    a=(ln_ufunc_operand){.kind=LN_UFUNC_OPERAND_ARRAY,.array=start};b=(ln_ufunc_operand){.kind=LN_UFUNC_OPERAND_ARRAY,.array=end};step=number(1);
    r=ln_array_arange(&a,&b,&step,ln_dtype_by_name("uint8"),&error);assert(r&&r->dimensions[0]==1&&r->data[0]==0);ln_array_free(r);
    a.scalar_object=1;assert(!ln_array_arange(&a,&b,&step,ln_dtype_by_name("uint8"),&error));ln_array_free(start);ln_array_free(end);
    ln_datetime_meta common;assert(!ln_datetime_metadata_gcd(&(ln_datetime_meta){LN_FR_Y,4},&(ln_datetime_meta){LN_FR_h,12},0,0,&common,&error));
    assert(common.base==LN_FR_h&&common.num==12);
    const ln_dtype *promoted=ln_promote_dtype(ln_dtype_by_name("datetime64[W]"),ln_dtype_by_name("timedelta64[Y]"));
    assert(promoted&&promoted->kind=='M'&&ln_datetime_metadata(promoted)->base==LN_FR_W);
    start=point("datetime64[D]",0,&error);end=point("timedelta64[Y]",1,&error);
    const ln_array *inputs[]={start,end};r=NULL;assert(ln_ufunc_execute(ln_ufunc_by_name("add"),inputs,&r,NULL,&error)<0&&!r);ln_array_free(start);ln_array_free(end);
    assert(ln_datetime_integer_item(3,ln_dtype_by_name("datetime64[ns]"),&error)==1);
    assert(ln_datetime_integer_item(3,days,&error)==0);
    assert(ln_datetime_integer_item(3,ln_dtype_by_name("timedelta64"),&error)==1);
    assert(ln_datetime_integer_item(3,ln_dtype_by_name("timedelta64[D]"),&error)==0);
    assert(ln_datetime_integer_item(1000000001,ln_dtype_by_name("timedelta64[D]"),&error)==1);
    assert(ln_datetime_integer_item(LN_DATETIME_NAT,days,&error)==0);
    start=point("timedelta64[D]",INT64_MIN+1,&error);end=point("timedelta64[D]",INT64_MAX,&error);
    a=(ln_ufunc_operand){.kind=LN_UFUNC_OPERAND_ARRAY,.array=start};b=(ln_ufunc_operand){.kind=LN_UFUNC_OPERAND_ARRAY,.array=end};
    assert(!ln_array_arange_time(&a,&b,NULL,NULL,&error));ln_array_free(start);ln_array_free(end);
    ln_datetime_meta zero_unit={LN_FR_Y,0};ln_dtype invalid=*days;invalid.metadata=&zero_unit;
    a=text("2020");b=text("2021");assert(!ln_array_arange_time(&a,&b,NULL,&invalid,&error));
    puts("arange144 native: calendars, unit inference, numeric dispatch, metadata and checked boundaries passed");return 0;
}
