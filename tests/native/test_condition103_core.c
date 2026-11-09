#include "ln_condition.h"
#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

int main(void)
{
    ln_error err={0};ln_intp shape[]={2,3};
    ln_array *a=ln_array_new(2,shape,ln_dtype_by_name("int32"),0,0,&err);assert(a);
    memcpy(a->data,(int32_t[]){0,2,0,3,0,4},24);
    ln_array *coords[LN_MAXDIMS];int nout=-1;
    assert(ln_array_condition_nonzero(a,0,coords,&nout,&err)==0&&nout==2);
    assert(coords[0]->owner==coords[1]->owner);
    assert(coords[0]->strides[0]==2*(ln_intp)sizeof(ln_intp));
    ln_intp value;memcpy(&value,coords[1]->data,sizeof(value));assert(value==2);
    ln_array_free(coords[0]);ln_array_free(coords[1]);
    assert(ln_array_condition_nonzero(a,1,coords,&nout,&err)==0&&nout==1);
    assert(memcmp(coords[0]->data,(ln_intp[]){2,4,6},3*sizeof(ln_intp))==0);
    ln_array_free(coords[0]);
    assert(ln_array_condition_nonzero(NULL,0,coords,&nout,&err)<0&&nout==0);
    assert(ln_array_condition_nonzero(a,0,NULL,&nout,&err)<0);
    assert(ln_array_condition_nonzero(a,0,coords,NULL,&err)<0);
    ln_array *scalar=ln_array_new(0,NULL,ln_dtype_by_name("bool"),0,1,&err);assert(scalar);
    assert(ln_array_condition_nonzero(scalar,0,coords,&nout,&err)<0);
    assert(ln_array_condition_nonzero(scalar,1,coords,&nout,&err)==0&&nout==1);
    assert(ln_array_size(coords[0])==0&&coords[0]->strides[0]==(ln_intp)sizeof(ln_intp));
    ln_array_free(coords[0]);
    assert(!ln_array_compress_condition(a,scalar,1,-1,NULL,&err));
    assert(!ln_array_compress_condition(NULL,scalar,0,-1,NULL,&err));
    assert(!ln_array_compress_condition(a,NULL,0,-1,NULL,&err));
    ln_intp three=3;ln_array *mask=ln_array_new(1,&three,ln_dtype_by_name("bool"),0,0,&err);assert(mask);
    memcpy(mask->data,(unsigned char[]){1,0,1},3);
    ln_array *r=ln_array_compress_condition(a,mask,1,1,NULL,&err);assert(r);
    assert(r->nd==2&&r->dimensions[0]==2&&r->dimensions[1]==2);
    assert(memcmp(r->data,(int32_t[]){0,0,3,4},16)==0);
    ln_array_free(r);ln_array_free(mask);ln_array_free(scalar);ln_array_free(a);
    puts("condition103 native core: passed");return 0;
}
