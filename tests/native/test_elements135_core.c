#include "ln_core.h"
#include "ln_datetime_strings.h"
#include "ln_dtype_transfer.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>
int main(void)
{
    ln_error error={0};int64_t years[]={-1,0,1},days[3]={0};
    const ln_dtype *year=ln_dtype_by_name("datetime64[Y]"),*day=ln_dtype_by_name("datetime64[D]");
    assert(ln_cast_strided_numeric((const char*)years,8,year,(char*)days,8,day,3,&error)==0);
    assert(days[0]==-365&&days[1]==0&&days[2]==365);
    int64_t extreme=INT64_MAX;ln_datetimestruct date;
    assert(ln_datetime_value_to_struct(extreme,ln_datetime_metadata(year),&date,&error)==0);
    uint64_t bits=(uint64_t)extreme+1970;int64_t wrapped;memcpy(&wrapped,&bits,8);
    assert(date.year==wrapped);
    int64_t source=INT64_MIN+1,third=0;
    assert(ln_cast_strided_numeric((const char*)&source,8,year,(char*)&third,8,ln_dtype_by_name("datetime64[3Y]"),1,&error)==0);
    assert(third==INT64_C(3074457345618258602));
    char text[80];const ln_dtype *unicode=ln_dtype_by_name("S80");
    assert(ln_cast_strided_numeric((const char*)&extreme,8,ln_dtype_by_name("timedelta64[Y]"),text,80,unicode,1,&error)==0);
    assert(!strcmp(text,"9223372036854775807 y"));
    source=INT64_MAX;
    assert(ln_datetime_value_to_struct(source,ln_datetime_metadata(ln_dtype_by_name("datetime64[2h]")),&date,&error)<0);
    assert(error.kind==LN_ERROR_OVERFLOW);
    source=0;
    assert(ln_cast_strided_numeric((const char*)&source,8,year,(char*)&third,8,ln_dtype_by_name("datetime64[ps]"),1,&error)<0);
    puts("elements135 native: calendar conversion, wrap and temporal text passed");
    return 0;
}
