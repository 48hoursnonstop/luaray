#include "ln_bytes.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>
int main(void)
{
    ln_error e={0};assert(ln_bytes_swap_inplace(NULL,&e)<0&&!ln_bytes_swap_copy(NULL,&e));
    ln_array *a=ln_array_new(1,(ln_intp[]){3},ln_dtype_by_name("int32"),0,1,&e);assert(a);
    for(int i=0;i<12;++i)a->data[i]=(char)i;
    ln_array *b=ln_bytes_swap_copy(a,&e);assert(b&&b->descr==a->descr&&b->owner!=a->owner);
    const unsigned char reversed[]={3,2,1,0,7,6,5,4,11,10,9,8};assert(!memcmp(b->data,reversed,12));
    for(int i=0;i<12;++i)assert(a->data[i]==i);
    assert(!ln_bytes_swap_inplace(b,&e)&&!memcmp(b->data,a->data,12));ln_array_free(b);
    a->flags&=~LN_ARRAY_WRITEABLE;assert(ln_bytes_swap_inplace(a,&e)<0);
    b=ln_bytes_swap_copy(a,&e);assert(b&&(b->flags&LN_ARRAY_WRITEABLE));ln_array_free(a);ln_array_free(b);
    a=ln_array_new(1,(ln_intp[]){2},ln_dtype_by_name("complex64"),0,1,&e);assert(a);
    for(int i=0;i<16;++i)a->data[i]=(char)i;
    assert(!ln_bytes_swap_inplace(a,&e));
    for(int i=0;i<16;++i)assert(a->data[i]==(i/4)*4+3-i%4);
    ln_array_free(a);
    a=ln_array_new(1,(ln_intp[]){2},ln_dtype_by_name("longdouble"),0,1,&e);assert(a);
    size_t width=a->descr->elsize;for(size_t i=0;i<2*width;++i)a->data[i]=(char)i;
    assert(!ln_bytes_swap_inplace(a,&e));
    for(size_t i=0;i<2*width;++i)assert((unsigned char)a->data[i]==(i/width)*width+width-1-i%width);
    ln_array_free(a);
    a=ln_array_new(1,(ln_intp[]){2},ln_dtype_by_name("U2"),0,1,&e);assert(a);
    for(int i=0;i<16;++i)a->data[i]=(char)i;
    assert(!ln_bytes_swap_inplace(a,&e));
    for(int i=0;i<16;++i)assert(a->data[i]==(i/4)*4+3-i%4);
    ln_array_free(a);
    a=ln_array_new(1,(ln_intp[]){2},ln_dtype_by_name("S0"),0,1,&e);assert(a);
    assert(!ln_bytes_swap_inplace(a,&e));b=ln_bytes_swap_copy(a,&e);assert(b&&b->descr->elsize==1&&b->data[0]==0&&b->data[1]==0);
    ln_array_free(a);ln_array_free(b);
    unsigned char raw[24];for(int i=0;i<24;++i)raw[i]=(unsigned char)i;
    a=ln_array_from_buffer(raw,sizeof raw,ln_dtype_by_name("uint8"),24,0,1,NULL,NULL,&e);assert(a);
    b=ln_array_view(a,2,(ln_intp[]){2,3},(ln_intp[]){-1,2},a->data+4,&e);assert(b);
    b->descr=ln_dtype_by_name("int32");ln_update_contiguous_flags(b);
    assert(!ln_bytes_swap_inplace(b,&e));
    const unsigned char expected[]={0,1,2,5,6,4,8,3,10,11,9,7,12,13,14,15};
    assert(!memcmp(raw,expected,sizeof expected));ln_array_free(a);ln_array_free(b);
    a=ln_array_new(1,(ln_intp[]){0},ln_dtype_by_name("uint8"),0,1,&e);assert(a);
    a->flags&=~LN_ARRAY_WRITEABLE;assert(ln_bytes_swap_inplace(a,&e)<0);ln_array_free(a);
    puts("bytes146 native: exact payloads, longdouble padding, overlaps, read-only and copy ownership passed");return 0;
}
