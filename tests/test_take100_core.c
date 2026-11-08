#include "ln_take.h"
#include "ln_string.h"
#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

int main(void)
{
    ln_error err={{0}};ln_intp dims[]={3,2},two=2;
    const ln_dtype *dtype=ln_dtype_by_name("int64");
    ln_array *a=ln_array_new(2,dims,dtype,0,0,&err);
    ln_array *indices=ln_array_new(1,&two,dtype,0,0,&err);
    assert(a&&indices);
    memcpy(a->data,(int64_t[]){-1,-2,-3,-1,-2,-3},48);
    memcpy(indices->data,(int64_t[]){-1,-2},16);
    ln_array *r=ln_array_take(a,indices,0,LN_TAKE_RAISE,NULL,&err);
    assert(r&&r->nd==2&&r->dimensions[0]==2&&r->dimensions[1]==2);
    assert(memcmp(r->data,(int64_t[]){-2,-3,-3,-1},32)==0);
    ln_array_free(r);
    ln_intp outshape[]={2,2},stride=8;
    ln_array *out=ln_array_new(2,outshape,dtype,0,0,&err);assert(out);
    memcpy(out->data,(int64_t[]){-1,-2,-1,-2},32);
    ln_array *live=ln_array_view(out,1,&two,&stride,out->data,&err);assert(live);
    assert(ln_array_take(a,live,0,LN_TAKE_WRAP,out,&err)==out);
    assert(memcmp(out->data,(int64_t[]){-2,-3,-1,-2},32)==0);
    ln_array_free(live);
    out->flags&=~LN_ARRAY_WRITEABLE;
    assert(!ln_array_take(a,indices,0,LN_TAKE_WRAP,out,&err));
    assert(!ln_array_take(NULL,indices,0,LN_TAKE_RAISE,NULL,&err));
    assert(!ln_array_take(a,NULL,0,LN_TAKE_RAISE,NULL,&err));
    assert(!ln_array_take(a,indices,9,LN_TAKE_RAISE,NULL,&err));
    assert(!ln_array_take(a,indices,0,(ln_take_mode)9,NULL,&err));
    ln_intp emptyshape[]={3,0,0};
    ln_array *empty=ln_array_new(3,emptyshape,dtype,0,0,&err);assert(empty);
    assert(!ln_array_take(empty,indices,1,LN_TAKE_WRAP,NULL,&err));
    r=ln_array_take(empty,indices,1,LN_TAKE_CLIP,NULL,&err);assert(r&&ln_array_size(r)==0);
    ln_array_free(r);ln_array_free(empty);
    ln_intp ones[LN_MAXDIMS];for(int i=0;i<LN_MAXDIMS;++i)ones[i]=1;
    ln_array *rank=ln_array_new(LN_MAXDIMS,ones,dtype,0,0,&err);
    ln_intp oneone[]={1,1};ln_array *rankindices=ln_array_new(2,oneone,dtype,0,0,&err);
    assert(rank&&rankindices);assert(!ln_array_take(rank,rankindices,0,LN_TAKE_RAISE,NULL,&err));
    ln_array_free(rankindices);ln_array_free(rank);
    ln_array_free(out);ln_array_free(indices);ln_array_free(a);
    /* Full ASCII validation precedes truncation and mutation; embedded NUL
     * remains data. Golden bytes checked against NumPy 2.5.3 astype. */
    const ln_dtype *u8=ln_dtype_by_name("U8"),*u4=ln_dtype_by_name("U4"),*s4=ln_dtype_by_name("S4");
    char unicode[32],ascii[4]={'x','x','x','x'},expected[16],dest[16];
    assert(ln_string_pack_utf8(u8,unicode,"aaaa\xce\xb2",6,&err)==0);
    assert(ln_string_cast_one(unicode,u8,ascii,s4,&err)<0);
    assert(memcmp(ascii,"xxxx",4)==0);
    assert(ln_string_pack_utf8(u8,unicode,"a\0b",3,&err)==0);
    assert(ln_string_cast_one(unicode,u8,ascii,s4,&err)==0);
    assert(memcmp(ascii,(char[]){'a',0,'b',0},4)==0);
    memset(dest,0x55,sizeof(dest));memcpy(expected,dest,sizeof(dest));
    char invalid[]={'a',0,(char)0xff,0};
    assert(ln_string_cast_one(invalid,s4,dest,u4,&err)<0);
    assert(memcmp(dest,expected,sizeof(dest))==0);
    assert(ln_string_cast_one(ascii,s4,dest,u4,&err)==0);
    assert(ln_string_pack_utf8(u4,expected,"a\0b",3,&err)==0);
    assert(memcmp(dest,expected,sizeof(dest))==0);
    puts("take100 native core: passed");return 0;
}
