#include "ln_busday.h"
#include "ln_order.h"

#include <stdint.h>
#include <stdio.h>
#include <string.h>

/* NumPy 2.5.5 datetime_busday.c. Wider intermediates keep signed date
 * differences and week products defined at the int64 boundaries. */
__extension__ typedef __int128 ln_day_span;

typedef struct ln_business_calendar {
    int weekmask[7];
    int workdays;
    const ln_array *holidays;
} ln_business_calendar;

static ln_array *day_error(ln_error *err,const char *message)
{
    if(err)snprintf(err->message,sizeof(err->message),"%s",message);
    return NULL;
}

static int64_t tick(const char *data)
{
    int64_t value;
    memcpy(&value,data,sizeof(value));
    return value;
}

static int weekday(int64_t day)
{
    return (int)((day%7+10)%7);
}

static ln_intp first_holiday(const ln_array *holiday,int64_t day)
{
    ln_intp lo=0,hi=holiday->dimensions[0];
    while(lo<hi) {
        ln_intp middle=lo+(hi-lo)/2;
        if(tick(holiday->data+middle*holiday->strides[0])<day)lo=middle+1;
        else hi=middle;
    }
    return lo;
}

static int business_day(const ln_business_calendar *cal,int64_t day)
{
    if(!cal->weekmask[weekday(day)])return 0;
    const ln_array *holidays=cal->holidays;
    ln_intp found=first_holiday(holidays,day);
    return found==holidays->dimensions[0] ||
        tick(holidays->data+found*holidays->strides[0])!=day;
}

static ln_day_span count_between(const ln_business_calendar *cal,int64_t start,int64_t end)
{
    int reversed=start>end;
    if(reversed) {
        int64_t swap=start;
        start=end;
        end=swap;
    }
    ln_day_span span=(ln_day_span)end-start;
    ln_day_span count=(span/7)*cal->workdays;
    int day=weekday(start);
    for(int i=0;i<(int)(span%7);i++)
        count+=cal->weekmask[(day+i)%7];
    const ln_array *holidays=cal->holidays;
    count-=first_holiday(holidays,end)-first_holiday(holidays,start);
    if(reversed)
        count=-count+business_day(cal,start)-business_day(cal,end);
    return count;
}

ln_array *ln_busday_count(const ln_array *start,const ln_array *end,
                          const ln_array *weekmask,const ln_array *holidays,
                          ln_error *err)
{
    if(!start||!end||!weekmask||!holidays||
            start->descr->type_num!=LN_DATETIME||end->descr->type_num!=LN_DATETIME||
            weekmask->descr->type_num!=LN_BOOL||weekmask->nd!=1||
            weekmask->dimensions[0]!=7||holidays->nd!=1||
            holidays->descr->type_num!=LN_DATETIME)
        return day_error(err,"invalid business day count operands");

    ln_business_calendar cal={.holidays=holidays};
    for(int i=0;i<7;i++) {
        cal.weekmask[i]=weekmask->data[i*weekmask->strides[0]]!=0;
        cal.workdays+=cal.weekmask[i];
    }
    if(!cal.workdays)return day_error(err,"weekmask has no business days");

    const ln_array *inputs[]={start,end};
    ln_intp shape[LN_MAXDIMS],strides[2][LN_MAXDIMS];
    int nd;
    if(ln_broadcast_shape(2,inputs,&nd,shape,err)<0)return NULL;
    for(int i=0;i<2;i++) {
        if(ln_broadcast_strides(nd,shape,inputs[i]->nd,inputs[i]->dimensions,
                inputs[i]->strides,"business day dates",strides[i],err)<0)return NULL;
    }
    const ln_intp *rows[]={strides[0],strides[1]};
    int order[LN_MAXDIMS];
    if(ln_keeporder_axes(nd,2,rows,order,err)<0)return NULL;
    const ln_dtype *dtype=ln_dtype_by_num(sizeof(ln_intp)==sizeof(long)?LN_LONG:LN_LONGLONG);
    ln_array *result=ln_array_new(nd,shape,dtype,0,0,err);
    if(!result)return NULL;
    ln_intp size=ln_array_size(result);
    if(size==0)return result;
    ln_intp stride=(ln_intp)dtype->elsize;
    for(int i=0;i<nd;i++) {
        int d=order[i];
        result->strides[d]=stride;
        stride*=shape[d];
    }
    ln_update_contiguous_flags(result);

    ln_intp coordinate[LN_MAXDIMS]={0};
    for(ln_intp i=0;i<size;i++) {
        ln_intp offset[2]={0,0};
        for(int d=0;d<nd;d++) {
            offset[0]+=coordinate[d]*strides[0][d];
            offset[1]+=coordinate[d]*strides[1][d];
        }
        int64_t a=tick(start->data+offset[0]),b=tick(end->data+offset[1]);
        if(a==INT64_MIN||b==INT64_MIN) {
            ln_array_free(result);
            return day_error(err,"cannot count business days with NaT");
        }
        ln_day_span count=count_between(&cal,a,b);
        if(count>INTPTR_MAX||count<INTPTR_MIN) {
            ln_array_free(result);
            return day_error(err,"business day count exceeds native integer range");
        }
        ln_intp value=(ln_intp)count;
        memcpy(result->data+i*(ln_intp)dtype->elsize,&value,sizeof(value));
        for(int j=0;j<nd;j++) {
            int axis=order[j];
            if(++coordinate[axis]<shape[axis])break;
            coordinate[axis]=0;
        }
    }
    return result;
}
