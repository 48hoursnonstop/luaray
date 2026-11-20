#include "ln_busday.h"
#include "ln_datetime.h"

#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

int main(void)
{
    ln_error err={0};
    const ln_dtype *days=ln_datetime_parse_dtype("datetime64[D]",&err);
    const ln_intp seven=7,two=2,zero=0;
    assert(days);
    ln_array *mask=ln_array_new(1,&seven,ln_dtype_by_num(LN_BOOL),0,0,&err);
    ln_array *holidays=ln_array_new(1,&two,days,0,0,&err);
    ln_array *a=ln_array_new(0,NULL,days,0,0,&err);
    ln_array *b=ln_array_new(1,&two,days,0,0,&err);
    assert(mask && holidays && a && b);
    const unsigned char weekdays[]={1,1,1,1,1,0,0};
    const int64_t dates[]={1,4};
    int64_t first=0;
    const int64_t last[]={7,-7};
    memcpy(mask->data,weekdays,sizeof weekdays);
    memcpy(holidays->data,dates,sizeof dates);
    memcpy(a->data,&first,sizeof first);
    memcpy(b->data,last,sizeof last);
    ln_array *count=ln_busday_count(a,b,mask,holidays,&err);
    assert(count && ln_array_size(count)==2);
    ln_intp actual[2];
    memcpy(actual,count->data,sizeof actual);
    assert(actual[0]==3 && actual[1]==-5);
    ln_array_free(count);

    int64_t extreme[2]={INT64_MIN+1,INT64_MAX};
    memcpy(a->data,&extreme[0],sizeof first);
    memcpy(b->data,extreme,sizeof extreme);
    memset(mask->data,1,(size_t)seven);
    ln_array *none=ln_array_new(1,&zero,days,0,0,&err);
    assert(none);
    assert(!ln_busday_count(a,b,mask,none,&err));
    assert(strstr(err.message,"native integer range"));
    first=INT64_MIN;
    memcpy(a->data,&first,sizeof first);
    assert(!ln_busday_count(a,b,mask,none,&err));
    assert(strstr(err.message,"NaT"));

    ln_array_free(none);
    ln_array_free(b);
    ln_array_free(a);
    ln_array_free(holidays);
    ln_array_free(mask);
    puts("Native business day count regression passed");
    return 0;
}
