#include "ln_choose.h"
#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

int main(void)
{
    ln_error err={{0}};ln_intp three=3;
    const ln_dtype *dtype=ln_dtype_by_name(sizeof(ln_intp)==8?"int64":"int32");
    ln_array *indices=ln_array_new(1,&three,dtype,0,0,&err);
    ln_array *a=ln_array_new(0,NULL,dtype,0,0,&err),*b=ln_array_new(0,NULL,dtype,0,0,&err);
    assert(indices&&a&&b);
    memcpy(indices->data,(ln_intp[]){1,2,1},3*sizeof(ln_intp));
    memcpy(a->data,(ln_intp[]){10},sizeof(ln_intp));memcpy(b->data,(ln_intp[]){20},sizeof(ln_intp));
    const ln_array *choices[]={a,b};
    ln_array *r=ln_array_choose(indices,choices,2,LN_TAKE_RAISE,NULL,&err);
    assert(r&&memcmp(r->data,(ln_intp[]){10,20,10},3*sizeof(ln_intp))==0);ln_array_free(r);
    assert(!ln_array_choose(NULL,choices,2,LN_TAKE_RAISE,NULL,&err));
    assert(!ln_array_choose(indices,NULL,2,LN_TAKE_RAISE,NULL,&err));
    assert(!ln_array_choose(indices,choices,0,LN_TAKE_RAISE,NULL,&err));
    assert(!ln_array_choose(indices,choices,64,LN_TAKE_RAISE,NULL,&err));
    assert(!ln_array_choose(indices,choices,2,(ln_take_mode)9,NULL,&err));
    ln_array *owner=ln_array_new(1,&three,dtype,0,1,&err);assert(owner);
    ln_intp stride=-(ln_intp)sizeof(ln_intp);
    ln_array *reversed=ln_array_view(owner,1,&three,&stride,owner->data+2*sizeof(ln_intp),&err);assert(reversed);
    assert(!ln_array_choose(indices,choices,2,LN_TAKE_WRAP,reversed,&err));
    assert(memcmp(owner->data,(ln_intp[]){0,0,0},3*sizeof(ln_intp))==0);
    assert(ln_array_choose(indices,choices,2,LN_TAKE_RAISE,reversed,&err)==reversed);
    assert(memcmp(owner->data,(ln_intp[]){10,20,10},3*sizeof(ln_intp))==0);
    ln_array_free(reversed);ln_array_free(owner);ln_array_free(indices);ln_array_free(a);ln_array_free(b);
    puts("choose102 native core: passed");return 0;
}
