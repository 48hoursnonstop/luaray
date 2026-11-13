#include "ln_core.h"
#include "ln_datetime.h"
#include "ln_ufunc.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>
int main(void)
{
    ln_error error={0};ln_intp size=4;
    ln_array *time=ln_array_new(1,&size,ln_dtype_by_name("timedelta64[h]"),0,0,&error);
    ln_array *integer=ln_array_new(0,NULL,ln_dtype_by_name("int64"),0,0,&error);
    assert(time&&integer);
    int64_t ticks[]={0,1,INT64_MAX,LN_DATETIME_NAT};memcpy(time->data,ticks,sizeof ticks);
    *(int64_t*)integer->data=1;
    const ln_array *unary[]={time};ln_array *out=NULL;
    for(int op=0;op<3;++op){
        const char *name=op==0?"isnan":op==1?"isinf":"isfinite";
        assert(ln_ufunc_execute(ln_ufunc_by_name(name),unary,&out,NULL,&error)==0);
        assert(out->descr->type_num==LN_BOOL&&out->owner!=time->owner);
        for(int i=0;i<4;++i)assert(((uint8_t*)out->data)[i]==(op==0?(i==3):op==1?0:(i!=3)));
        ln_array_free(out);out=NULL;
    }
    const ln_array *binary[]={time,integer};
    assert(ln_ufunc_execute(ln_ufunc_by_name("equal"),binary,&out,NULL,&error)==0);
    assert(!((uint8_t*)out->data)[0]&&((uint8_t*)out->data)[1]&&!((uint8_t*)out->data)[3]);
    ln_array_free(out);
    out=ln_array_new(1,&size,time->descr,0,0,&error);assert(out);
    for(int i=0;i<4;++i)((int64_t*)out->data)[i]=7;
    assert(ln_ufunc_execute(ln_ufunc_by_name("add"),binary,&out,NULL,&error)<0);
    assert(error.kind==LN_ERROR_OVERFLOW);
    assert(((int64_t*)out->data)[0]==1&&((int64_t*)out->data)[1]==2);
    assert(((int64_t*)out->data)[2]==7&&((int64_t*)out->data)[3]==7);
    ln_array_free(out);ln_array_free(time);
    time=ln_array_new(0,NULL,ln_dtype_by_name("datetime64[D]"),0,0,&error);assert(time);
    *(int64_t*)time->data=4;binary[0]=integer;binary[1]=time;out=NULL;
    assert(ln_ufunc_execute(ln_ufunc_by_name("add"),binary,&out,NULL,&error)==0);
    assert(out->descr==time->descr&&*(int64_t*)out->data==5);
    ln_array_free(out);out=NULL;
    assert(ln_ufunc_execute(ln_ufunc_by_name("subtract"),binary,&out,NULL,&error)<0);
    assert(out==NULL);
    ln_array_free(time);ln_array_free(integer);
    puts("comparison134 native: temporal predicates, integer dispatch and overflow prefix passed");
    return 0;
}
