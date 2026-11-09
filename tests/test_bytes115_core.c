#include "ln_bytes.h"
#include "ln_ufunc.h"
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(void)
{
    ln_error err={0};ln_intp n[]={33};
    ln_array *raw=ln_array_new(1,n,ln_dtype_by_name("uint8"),0,1,&err);assert(raw);
    ln_intp dims[]={32},stride[]={1};
    ln_array *offset=ln_array_view(raw,1,dims,stride,raw->data+1,&err);assert(offset);
    ln_array *a=ln_bytes_view(offset,ln_dtype_by_name("float64"),&err);assert(a);
    assert(a->dimensions[0]==4&&a->strides[0]==8&&!(a->flags&LN_ARRAY_ALIGNED));
    assert(a->flags&LN_ARRAY_C_CONTIGUOUS);
    ln_intp index[]={0};assert(ln_array_pack_number(a,index,1.25,0,0,&err)==0);
    double value;int64_t iv;int integer;
    assert(ln_array_get_number(a,index,&value,&iv,&integer,&err)==0&&value==1.25);
    ln_array *copy=NULL;const ln_array *inputs[]={a};
    assert(ln_ufunc_execute(ln_ufunc_by_name("square"),inputs,&copy,NULL,&err)==0);
    assert(ln_array_get_number(copy,index,&value,&iv,&integer,&err)==0&&value==1.5625);
    size_t length;char *bytes;assert(ln_bytes_export(a,'C',&bytes,&length,&err)==0&&length==32);
    assert(memcmp(bytes,a->data,length)==0);free(bytes);
    ln_array_free(raw);ln_array_free(offset); /* owner remains rooted by a */
    assert(ln_array_get_number(a,index,&value,&iv,&integer,&err)==0&&value==1.25);
    a->flags&=~LN_ARRAY_WRITEABLE;
    ln_array *readonly=ln_bytes_view(a,NULL,&err);assert(readonly&&!(readonly->flags&LN_ARRAY_WRITEABLE));
    ln_array_free(readonly);ln_array_free(copy);ln_array_free(a);
    ln_intp zero[]={0};raw=ln_array_new(1,zero,ln_dtype_by_name("uint8"),0,0,&err);
    assert(ln_bytes_export(raw,'F',&bytes,&length,&err)==0&&length==0);free(bytes);ln_array_free(raw);
    ln_array fake={0};ln_intp huge[]={INTPTR_MAX};ln_intp step[]={8};
    fake.nd=1;fake.dimensions=huge;fake.strides=step;fake.descr=ln_dtype_by_name("float64");
    assert(ln_bytes_view(&fake,ln_dtype_by_name("uint8"),&err)==NULL&&err.kind==LN_ERROR_OVERFLOW);
    assert(ln_bytes_size(&fake,&length,&err)<0&&err.kind==LN_ERROR_OVERFLOW);
    assert(ln_bytes_export(NULL,'A',&bytes,&length,&err)<0);
    puts("bytes115 native: alignment, typed reads/writes, ufunc, lifetime, readonly, empty and overflow passed");
}
