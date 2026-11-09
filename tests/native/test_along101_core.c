#include "ln_along.h"
#include "ln_mapping.h"
#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

int main(void)
{
    ln_error err={0};ln_intp shape[]={2,3},ishape[]={2,1};
    const ln_dtype *intp=ln_dtype_by_name(sizeof(ln_intp)==8?"int64":"int32");
    ln_array *a=ln_array_new(2,shape,ln_dtype_by_name("int32"),0,0,&err);
    ln_array *indices=ln_array_new(2,ishape,intp,0,0,&err);
    ln_array *value=ln_array_new(0,NULL,ln_dtype_by_name("int32"),0,0,&err);
    assert(a&&indices&&value);
    memcpy(a->data,(int32_t[]){10,30,20,60,40,50},24);
    memcpy(indices->data,(ln_intp[]){2,1},2*sizeof(ln_intp));
    memcpy(value->data,(int32_t[]){99},4);
    ln_array *got=ln_array_take_along_axis(a,indices,1,&err);
    assert(got&&got->nd==2&&got->dimensions[0]==2&&got->dimensions[1]==1);
    assert(memcmp(got->data,(int32_t[]){30,60},8)==0);ln_array_free(got);
    assert(ln_array_put_along_axis(a,indices,value,1,&err)==0);
    assert(memcmp(a->data,(int32_t[]){10,99,20,99,40,50},24)==0);
    assert(!ln_array_take_along_axis(a,indices,2,&err));
    assert(!ln_array_take_along_axis(a,indices,-2,&err));
    assert(!ln_array_take_along_axis(a,indices,-1,&err));
    assert(!ln_array_take_along_axis(NULL,indices,0,&err));
    assert(!ln_array_take_along_axis(a,NULL,0,&err));
    assert(ln_array_put_along_axis(a,indices,NULL,1,&err)<0);
    ln_array *bad=ln_array_new(2,ishape,ln_dtype_by_name("bool"),0,1,&err);assert(bad);
    assert(!ln_array_take_along_axis(a,bad,1,&err));ln_array_free(bad);
    a->flags&=~LN_ARRAY_WRITEABLE;
    assert(ln_array_put_along_axis(a,indices,value,1,&err)<0);
    ln_array_free(value);ln_array_free(indices);ln_array_free(a);
    puts("along101 native core: passed");return 0;
}
