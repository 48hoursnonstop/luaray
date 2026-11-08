#include "ln_write.h"
#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

int main(void)
{
    ln_error err={{0}};ln_intp n=5;
    ln_array *a=ln_array_new(1,&n,ln_dtype_by_name("int32"),0,0,&err);
    ln_array *b=ln_array_new(1,&n,ln_dtype_by_name("int32"),0,0,&err);
    ln_array *mask=ln_array_new(1,&n,ln_dtype_by_num(LN_BOOL),0,0,&err);
    assert(a&&b&&mask);
    memcpy(a->data,(int32_t[]){1,2,3,4,5},20);
    memcpy(b->data,(int32_t[]){10,20,30,40,50},20);
    memcpy(mask->data,(unsigned char[]){1,0,1,0,1},5);
    assert(ln_array_copyto(a,b,mask,1,LN_SAFE_CASTING,&err)==0);
    assert(memcmp(a->data,(int32_t[]){10,2,30,4,50},20)==0);
    a->flags&=~LN_ARRAY_WRITEABLE;
    assert(ln_array_copyto(a,a,mask,1,LN_NO_CASTING,&err)==0);
    assert(ln_array_copyto(a,b,mask,1,LN_SAFE_CASTING,&err)<0);
    a->flags|=LN_ARRAY_WRITEABLE;
    assert(ln_array_putmask(a,mask,b,&err)==0);
    assert(memcmp(a->data,(int32_t[]){10,2,30,4,50},20)==0);
    assert(ln_array_copyto(NULL,b,mask,1,LN_SAFE_CASTING,&err)<0);
    assert(ln_array_copyto(a,NULL,mask,1,LN_SAFE_CASTING,&err)<0);
    assert(ln_array_copyto(a,b,b,1,LN_SAFE_CASTING,&err)<0);
    ln_array_free(mask);ln_array_free(b);ln_array_free(a);
    puts("memory99 native core: passed");
    return 0;
}
