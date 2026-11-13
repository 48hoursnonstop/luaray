#include "ln_creation.h"
#include "ln_dtype_transfer.h"
#include "ln_string.h"
#include "ln_datetime.h"
#include <assert.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
int main(void)
{
    ln_error err={0};const ln_dtype *i32=ln_dtype_by_name("int32"),*f32=ln_dtype_by_name("float32");
    ln_array *a=ln_array_new(2,(ln_intp[]){2,3},i32,0,0,&err);assert(a);
    memcpy(a->data,(int32_t[]){0,1,2,3,4,5},24);
    ln_array *f=ln_array_transpose(a,&err);assert(f);
    int identity=-1;
    ln_array *out=ln_creation_convert(f,NULL,'K',0,0,&identity,&err);assert(out&&identity==1&&out->owner==a->owner);ln_array_free(out);
    assert(!ln_creation_convert(f,NULL,'C',0,0,&identity,&err)&&identity==0);
    out=ln_creation_convert(f,NULL,'C',-1,0,&identity,&err);assert(out&&out->owner!=a->owner&&out->strides[0]==8&&out->strides[1]==4);ln_array_free(out);
    out=ln_creation_convert(f,NULL,'K',1,0,&identity,&err);assert(out&&out->owner!=a->owner&&out->strides[0]==4&&out->strides[1]==12);ln_array_free(out);
    out=ln_creation_convert(f,NULL,'K',0,3,&identity,&err);assert(out&&identity==0&&out->owner==a->owner&&out->nd==3);
    assert(out->dimensions[0]==1&&out->strides[0]==4&&out->strides[1]==4&&out->strides[2]==12);ln_array_free(out);
    out=ln_creation_convert(a,NULL,'K',0,3,&identity,&err);assert(out&&out->strides[0]==24);ln_array_free(out);
    assert(!ln_creation_convert(a,f32,'K',0,0,&identity,&err));
    out=ln_creation_convert(a,f32,'K',1,0,&identity,&err);assert(out&&out->descr==f32&&((float *)out->data)[5]==5);ln_array_free(out);
    f->flags&=~LN_ARRAY_WRITEABLE;
    out=ln_creation_convert(f,NULL,'K',0,0,&identity,&err);assert(out&&!(out->flags&LN_ARRAY_WRITEABLE));ln_array_free(out);
    out=ln_creation_convert(f,NULL,'K',1,0,&identity,&err);assert(out&&(out->flags&LN_ARRAY_WRITEABLE));ln_array_free(out);
    out=ln_creation_new_like(f,NULL,'K',2,(ln_intp[]){4,5},&err);assert(out&&out->strides[0]==4&&out->strides[1]==16);ln_array_free(out);
    out=ln_creation_new_like(f,NULL,'K',3,(ln_intp[]){2,3,4},&err);assert(out&&out->strides[0]==48&&out->strides[1]==16&&out->strides[2]==4);ln_array_free(out);
    out=ln_creation_new_like(a,ln_dtype_by_name("U"),'K',-1,NULL,&err);assert(out&&ln_string_nchars(out->descr)==1&&out->descr->elsize==4);ln_array_free(out);
    assert(!ln_creation_new_like(NULL,NULL,'K',-1,NULL,&err));
    assert(!ln_creation_new_like(a,NULL,'X',-1,NULL,&err));
    assert(!ln_creation_new_like(a,NULL,'K',2,NULL,&err));
    assert(!ln_creation_new_like(a,NULL,'K',-2,NULL,&err));
    assert(!ln_creation_new_like(a,NULL,'K',65,NULL,&err));
    assert(!ln_creation_new_like(a,NULL,'K',1,(ln_intp[]){-1},&err));
    assert(!ln_creation_convert(NULL,NULL,'K',0,0,NULL,&err));
    assert(!ln_creation_convert(a,NULL,'K',2,0,NULL,&err));
    assert(!ln_creation_convert(a,NULL,'X',0,0,NULL,&err));
    assert(!ln_creation_convert(a,NULL,'K',0,65,NULL,&err));
    assert(ln_creation_checkfinite(a,&err)==0);
    ln_array *finite=ln_array_new(1,(ln_intp[]){3},f32,0,0,&err);assert(finite);
    memcpy(finite->data,(float[]){1,INFINITY,2},12);assert(ln_creation_checkfinite(finite,&err)<0);
    memcpy(finite->data,(float[]){1,NAN,2},12);assert(ln_creation_checkfinite(finite,&err)<0);
    memcpy(finite->data,(float[]){1,0,2},12);assert(ln_creation_checkfinite(finite,&err)==0);
    ln_array_free(finite);assert(ln_creation_checkfinite(NULL,&err)<0);
    ln_array *date=ln_array_new(1,(ln_intp[]){6},ln_dtype_by_name("datetime64"),0,0,&err);assert(date);
    assert(ln_cast_strided_numeric(a->data,4,i32,date->data,8,date->descr,6,&err)==0);
    assert(((int64_t *)date->data)[5]==5);
    assert(ln_array_pack_number(date,(ln_intp[]){0},0,1,1,&err)<0);
    assert(ln_array_pack_number(date,(ln_intp[]){0},0,LN_DATETIME_NAT,1,&err)<0);
    int64_t nat=LN_DATETIME_NAT;
    assert(ln_cast_strided_numeric((char *)&nat,0,ln_dtype_by_name("int64"),date->data,0,date->descr,1,&err)==0);
    assert(((int64_t *)date->data)[0]==LN_DATETIME_NAT);
    ln_array *expanded=ln_array_view(a,2,(ln_intp[]){2,3},(ln_intp[]){0,4},a->data,&err);assert(expanded);
    out=ln_creation_convert(expanded,f32,'A',-1,0,&identity,&err);assert(out);
    assert(out->strides[0]==4&&out->strides[1]==8&&((float*)out->data)[5]==2);ln_array_free(out);
    out=ln_creation_convert(expanded,NULL,'A',1,0,&identity,&err);assert(out);
    assert(out->strides[0]==12&&out->strides[1]==4);ln_array_free(out);ln_array_free(expanded);
    ln_array_free(date);ln_array_free(f);ln_array_free(a);
    puts("creation107 native core: passed");return 0;
}
