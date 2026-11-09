#include "ln_layout.h"
#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

int main(void)
{
    ln_error err={0};
    ln_array *a=ln_array_new(2,(ln_intp[]){2,3},ln_dtype_by_name("int64"),0,0,&err);assert(a);
    for(int64_t i=0;i<6;++i)memcpy(a->data+i*8,&i,8);
    ln_array *f=ln_layout_flatten(a,'F',&err);assert(f&&f->owner!=a->owner);
    int64_t expected[]={0,3,1,4,2,5};assert(memcmp(f->data,expected,48)==0);ln_array_free(f);
    ln_array *r=ln_layout_ravel(a,'C',&err);assert(r&&r->owner==a->owner&&r->strides[0]==8);ln_array_free(r);
    ln_array *t=ln_array_transpose(a,&err);assert(t);
    r=ln_layout_ravel(t,'K',&err);assert(r&&r->owner==a->owner);ln_array_free(r);
    r=ln_layout_ravel(t,'C',&err);assert(r&&r->owner!=a->owner);ln_array_free(r);
    assert(!ln_layout_reshape(t,1,(ln_intp[]){6},'C',0,&err));
    r=ln_layout_reshape(t,1,(ln_intp[]){6},'F',0,&err);assert(r&&r->owner==a->owner);ln_array_free(r);
    r=ln_layout_reshape(a,2,a->dimensions,'C',1,&err);assert(r&&r->owner!=a->owner);ln_array_free(r);
    ln_array *negative=ln_array_view(a,1,(ln_intp[]){6},(ln_intp[]){-8},a->data+40,&err);assert(negative);
    negative->flags&=~LN_ARRAY_WRITEABLE;
    r=ln_layout_reshape(negative,2,(ln_intp[]){2,3},'C',0,&err);
    assert(r&&r->owner==a->owner&&r->strides[0]==-24&&r->strides[1]==-8);
    assert(!(r->flags&LN_ARRAY_WRITEABLE));ln_array_free(r);
    r=ln_layout_ravel(negative,'K',&err);assert(r&&r->owner!=a->owner&&(r->flags&LN_ARRAY_WRITEABLE));
    assert(*(int64_t *)r->data==5);ln_array_free(r);
    assert(!ln_layout_reshape(a,2,(ln_intp[]){-1,-2},'C',-1,&err));
    assert(!ln_layout_reshape(a,1,(ln_intp[]){6},'K',-1,&err));
    assert(!ln_layout_flatten(a,'X',&err));
    assert(!ln_layout_ravel(NULL,'C',&err));
    r=ln_layout_reshape(a,1,(ln_intp[]){-100},'C',0,&err);assert(r&&r->dimensions[0]==6);
    ln_array_free(negative);ln_array_free(t);ln_array_free(a);
    /* Native views keep their backing allocation alive independently. */
    assert(*(int64_t *)(r->data+40)==5);ln_array_free(r);
    puts("layout110 native tests passed");return 0;
}
