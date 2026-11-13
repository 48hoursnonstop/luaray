#include "ln_dtype_info.h"
#include "ln_dtype_transfer.h"
#include "ln_join.h"
#include "ln_datetime.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>
int main(void)
{
    ln_error error={0};const ln_dtype *d=ln_dtype_by_name("float");
    assert(d==ln_dtype_by_num(LN_DOUBLE)&&ln_dtype_by_name("f")==ln_dtype_by_num(LN_FLOAT));
    assert(ln_dtype_by_name("b1")==ln_dtype_by_num(LN_BOOL)&&ln_dtype_by_name("b")==ln_dtype_by_num(LN_BYTE));
    const ln_dtype *integer=ln_dtype_by_name("int64"),*alias=ln_dtype_by_name("longlong");
    assert(ln_dtype_equivalent(integer,alias)&&ln_dtype_can_cast(integer,alias,LN_NO_CASTING));
    assert(ln_dtype_char(alias)=='q'&&ln_dtype_byteorder(ln_dtype_by_name("int8"))=='|');
    char text[160];assert(ln_dtype_name(alias,text,sizeof text,&error)==0&&!strcmp(text,"int64"));
    assert(ln_dtype_typestr(alias,text,sizeof text,&error)==0&&strstr(text,"i8"));
    assert(ln_dtype_name(alias,text,3,&error)<0);
    const ln_dtype *unicode=ln_dtype_by_name("U3"),*unsized=ln_dtype_by_name("U0");
    assert(unicode->flags&LN_DTYPE_NEEDS_INIT);
    assert(!ln_dtype_equivalent(unicode,unsized));
    uint16_t one=1;const char *opposite=*(unsigned char*)&one?">U1":"<U1";
    assert(!ln_dtype_can_cast(ln_dtype_by_name(opposite),unsized,LN_NO_CASTING));
    assert(ln_dtype_can_cast(ln_dtype_by_name(opposite),unsized,LN_EQUIV_CASTING));
    ln_array *empty=ln_array_new(1,(ln_intp[]){4},unicode,0,0,&error);assert(empty);
    for(size_t i=0;i<4*unicode->elsize;++i)assert(empty->data[i]==0);
    ln_array_free(empty);
    assert(ln_dtype_name(unicode,text,sizeof text,&error)==0&&!strcmp(text,"str96"));
    const ln_dtype *date=ln_dtype_by_name("=M8[3ns]");assert(date);
    assert(ln_dtype_typestr(date,text,sizeof text,&error)==0&&strstr(text,"M8[3ns]"));
    assert(!ln_dtype_by_name("i184467440737095516150000"));
    ln_array *source=ln_array_new(1,(ln_intp[]){1},ln_dtype_by_name("int32"),0,0,&error);assert(source);
    *(int32_t*)source->data=1;const ln_array *inputs[]={source,source};
    ln_array *joined=ln_join_arrays(inputs,2,0,0,ln_dtype_by_name("S0"),LN_UNSAFE_CASTING,NULL,&error);assert(joined);
    assert(joined->descr->elsize==11&&joined->data[0]=='1'&&joined->data[11]=='1');
    ln_array_free(source);ln_array_free(joined);
    int64_t tick=0;assert(ln_datetime_add_checked(INT64_MAX,1,&tick,&error)<0&&error.kind==LN_ERROR_OVERFLOW);
    assert(ln_datetime_add_checked(LN_DATETIME_NAT,INT64_MAX,&tick,&error)==0&&tick==LN_DATETIME_NAT);
    ln_array *times=ln_array_new(1,(ln_intp[]){3},ln_dtype_by_name("timedelta64[D]"),0,0,&error);assert(times);
    memcpy(times->data,(int64_t[]){1,2,3},24);
    ln_array *total=ln_reduce_ex(times,(uint8_t[]){1},0,NULL,NULL,LN_REDUCE_SUM,0,0,0,0,&error);assert(total);
    assert(*(int64_t*)total->data==6&&total->descr==times->descr);ln_array_free(total);
    total=ln_accumulate_ex(times,0,NULL,LN_REDUCE_SUM,&error);assert(total&&((int64_t*)total->data)[2]==6);
    ln_array_free(times);ln_array_free(total);
    puts("dtype140 native: formats, alias equivalence, endian safety and Unicode initialization passed");return 0;
}
