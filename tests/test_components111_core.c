#include "ln_components.h"
#include "ln_complex.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>
int main(void)
{
    ln_error err={{0}};
    assert(!ln_component_part(NULL,0,&err));
    ln_array *a=ln_array_new(1,(ln_intp[]){2},ln_dtype_by_name("complex64"),0,0,&err);assert(a);
    ln_cfloat values[]={{1,2},{3,4}};memcpy(a->data,values,sizeof values);
    ln_array *r=ln_component_part(a,0,&err),*i=ln_component_part(a,1,&err);assert(r&&i);
    assert(r->descr->type_num==LN_FLOAT&&i->descr==r->descr);
    assert(r->owner==a->owner&&i->owner==a->owner&&i->data==a->data+4);
    assert(r->strides[0]==8&&!(r->flags&LN_ARRAY_C_CONTIGUOUS));
    float seven=7;memcpy(i->data,&seven,4);memcpy(values,a->data,sizeof values);
    assert(values[0].real==1&&values[0].imag==7);
    ln_array_free(a);assert(*(float *)r->data==1&&*(float *)i->data==7);
    ln_array *zero=ln_component_part(r,1,&err);assert(zero&&zero->owner!=r->owner);
    assert(!(zero->flags&LN_ARRAY_WRITEABLE)&&*(float *)zero->data==0);
    ln_array_free(zero);ln_array_free(r);ln_array_free(i);
    puts("components111 native tests passed");return 0;
}
