#include "ln_membership.h"
#include <assert.h>
#include <stdint.h>
#include <string.h>

int main(void)
{
    ln_intp n=3,m=2;
    ln_error err={0};
    int fallback=0;
    ln_array *values=ln_array_new(1,&n,ln_dtype_by_num(LN_ULONGLONG),0,0,&err);
    ln_array *keys=ln_array_new(1,&m,ln_dtype_by_num(LN_LONGLONG),0,0,&err);
    assert(values&&keys);
    uint64_t input[]={0,UINT64_C(1)<<63,UINT64_MAX};
    int64_t query[]={-1,0};
    memcpy(values->data,input,sizeof input);
    memcpy(keys->data,query,sizeof query);
    ln_array *result=ln_isin_table(values,keys,0,1,&fallback,&err);
    assert(result&&!fallback&&memcmp(result->data,"\1\0\0",3)==0);
    ln_array_free(result);

    query[0]=INT64_MIN;
    query[1]=INT64_MAX;
    memcpy(keys->data,query,sizeof query);
    assert(!ln_isin_table(values,keys,0,0,&fallback,&err)&&fallback);
    assert(!ln_isin_table(values,keys,0,1,&fallback,&err)&&!fallback);
    ln_array_free(values);
    ln_array_free(keys);
}
