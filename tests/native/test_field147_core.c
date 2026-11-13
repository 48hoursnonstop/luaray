#include "ln_bytes.h"
#include "ln_datetime_strings.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>
int main(void)
{
    ln_error e={0};const ln_dtype *u16=ln_dtype_by_name("uint16");
    assert(!ln_bytes_field(NULL,u16,0,&e));
    ln_array *a=ln_array_new(1,(ln_intp[]){2},ln_dtype_by_name("uint64"),0,1,&e);assert(a);
    for(int i=0;i<16;++i)a->data[i]=(char)i;
    assert(!ln_bytes_field(a,NULL,0,&e));assert(!ln_bytes_field(a,u16,-1,&e));
    assert(!ln_bytes_field(a,u16,7,&e));assert(!ln_bytes_field(a,ln_dtype_by_name("complex128"),0,&e));
    ln_array *f=ln_bytes_field(a,u16,1,&e);assert(f&&f->owner==a->owner&&f->data==a->data+1);
    assert(f->dimensions[0]==2&&f->strides[0]==8&&!(f->flags&LN_ARRAY_ALIGNED));
    assert(!(f->flags&(LN_ARRAY_C_CONTIGUOUS|LN_ARRAY_F_CONTIGUOUS|LN_ARRAY_OWNDATA)));
    ln_array *v=ln_array_new(1,(ln_intp[]){2},u16,0,1,&e);assert(v);
    uint16_t values[]={0x102,0x304};memcpy(v->data,values,sizeof values);
    assert(!ln_bytes_setfield(a,v,u16,1,&e));
    assert(!memcmp(a->data+1,&values[0],2)&&!memcmp(a->data+9,&values[1],2));
    for(int i=0;i<16;++i)if(i!=1&&i!=2&&i!=9&&i!=10)assert(a->data[i]==i);
    a->flags&=~LN_ARRAY_WRITEABLE;assert(ln_bytes_setfield(a,v,u16,0,&e)<0);
    ln_array *r=ln_bytes_field(a,u16,0,&e);assert(r&&!(r->flags&LN_ARRAY_WRITEABLE));ln_array_free(r);
    a->flags|=LN_ARRAY_WRITEABLE;assert(ln_bytes_setfield(a,NULL,u16,0,&e)<0);
    ln_array_free(a);assert(!ln_bytes_setfield(f,v,u16,0,&e)); /* Retained owner survives its original header. */
    ln_array_free(f);ln_array_free(v);
    a=ln_array_new(1,(ln_intp[]){0},ln_dtype_by_name("uint64"),0,1,&e);assert(a);
    f=ln_bytes_field(a,ln_dtype_by_name("uint8"),7,&e);assert(f&&ln_array_size(f)==0);ln_array_free(a);ln_array_free(f);
    a=ln_array_new(1,(ln_intp[]){2},ln_dtype_by_name("uint64"),0,1,&e);assert(a);
    f=ln_bytes_field(a,ln_dtype_by_name("S0"),8,&e);assert(f&&f->descr->elsize==0&&f->dimensions[0]==2);ln_array_free(a);ln_array_free(f);
    char text[192];assert(!ln_datetime_scalar_string(3,ln_dtype_by_name("datetime64[D]"),text,sizeof text,&e)&&!strcmp(text,"1970-01-04"));
    assert(!ln_datetime_scalar_string(3,ln_dtype_by_name("timedelta64[3h]"),text,sizeof text,&e)&&!strcmp(text,"9 hours"));
    assert(!ln_datetime_scalar_string(LN_DATETIME_NAT,ln_dtype_by_name("timedelta64"),text,sizeof text,&e)&&!strcmp(text,"NaT"));
    assert(!ln_datetime_scalar_string(INT64_MAX,ln_dtype_by_name("timedelta64[3h]"),text,sizeof text,&e)&&!strcmp(text,"9223372036854775805 hours"));
    assert(ln_datetime_scalar_string(3,ln_dtype_by_name("timedelta64[h]"),text,1,&e)<0);
    assert(ln_datetime_scalar_string(3,u16,text,sizeof text,&e)<0);
    puts("field147 native: field bounds, ownership, writes, empty offsets and temporal scalar strings passed");return 0;
}
