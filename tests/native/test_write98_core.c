#include "ln_core.h"
#include "ln_write.h"
#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

static ln_error err;
static ln_array *integers(const int64_t *values, ln_intp n)
{
    ln_array *a=ln_array_new(1,&n,ln_dtype_by_name("int64"),0,0,&err);
    assert(a);if(n)memcpy(a->data,values,(size_t)n*sizeof(*values));return a;
}
static void equals(const ln_array *a,const int64_t *expected,ln_intp n)
{
    assert(ln_array_size(a)==n);
    assert(memcmp(a->data,expected,(size_t)n*sizeof(*expected))==0);
}
int main(void)
{
    const int64_t initial[]={0,1,2,3},raw[]={1,9},source[]={90,91};
    ln_array *a=integers(initial,4),*indices=integers(raw,2),*values=integers(source,2);
    assert(ln_array_put(a,indices,values,LN_PUT_RAISE,&err)<0);
    equals(a,(int64_t[]){90,1,2,3},4);
    memcpy(a->data,initial,sizeof(initial));
    ln_intp n=4,stride=-(ln_intp)sizeof(int64_t);
    ln_array *reverse=ln_array_view(a,1,&n,&stride,a->data+3*sizeof(int64_t),&err);
    assert(reverse);
    assert(ln_array_put(reverse,indices,values,LN_PUT_RAISE,&err)<0);
    equals(a,initial,4);
    ln_array_free(reverse);
    ln_array_free(a);
    a=integers((int64_t[]){4,3,2,1},4);
    ln_array *four_values=integers((int64_t[]){10,20,30,40},4);
    assert(ln_array_put(a,a,four_values,LN_PUT_RAISE,&err)==0);
    equals(a,(int64_t[]){40,30,20,10},4);
    a->flags&=~LN_ARRAY_WRITEABLE;
    assert(ln_array_put(a,indices,values,LN_PUT_WRAP,&err)<0);
    a->flags|=LN_ARRAY_WRITEABLE;
    assert(ln_array_put(NULL,indices,values,LN_PUT_RAISE,&err)<0);
    assert(ln_array_put(a,NULL,values,LN_PUT_RAISE,&err)<0);
    assert(ln_array_put(a,indices,NULL,LN_PUT_RAISE,&err)<0);
    assert(ln_array_put(a,indices,values,(ln_put_mode)99,&err)<0);
    assert(ln_array_place(a,NULL,values,&err)<0);
    ln_array_free(a);ln_array_free(four_values);
    ln_intp count=5;
    ln_array *mask=ln_array_new(1,&count,ln_dtype_by_num(LN_BOOL),0,0,&err);
    assert(mask);memcpy(mask->data,(unsigned char[]){1,0,1,1,1},5);
    a=integers((int64_t[]){1,0,1,1,1},5);
    assert(ln_array_place(a,mask,a,&err)==0);
    equals(a,(int64_t[]){1,0,0,0,0},5);
    ln_array *empty=integers(NULL,0);
    assert(ln_array_place(a,mask,empty,&err)<0);
    memset(mask->data,0,5);
    assert(ln_array_place(a,mask,empty,&err)==0);
    assert(ln_array_put(a,indices,empty,LN_PUT_RAISE,&err)==0);
    ln_array_free(empty);ln_array_free(mask);ln_array_free(a);
    ln_array_free(indices);ln_array_free(values);
    puts("write98 native core: passed");
    return 0;
}
