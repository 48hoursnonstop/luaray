#include "ln_components.h"
#include "ln_complex.h"
#include <assert.h>
#include <float.h>
#include <math.h>
#include <stdio.h>
#include <string.h>
int main(void)
{
    ln_error err={{0}};int identity=-1;
    assert(!ln_component_reality(NULL,1,&err));
    assert(!ln_component_close(NULL,100,&identity,&err)&&identity==0);
    ln_array *a=ln_array_new(1,(ln_intp[]){3},ln_dtype_by_name("complex128"),0,0,&err);assert(a);
    ln_cdouble values[]={{1,0},{2,NAN},{3,4}};memcpy(a->data,values,sizeof values);
    ln_array *r=ln_component_reality(a,1,&err);assert(r&&r->descr->type_num==LN_BOOL);
    assert(r->data[0]==1&&r->data[1]==0&&r->data[2]==0);ln_array_free(r);
    r=ln_component_reality(a,0,&err);assert(r&&r->data[0]==0&&r->data[1]==1&&r->data[2]==1);ln_array_free(r);
    r=ln_component_close(a,100,&identity,&err);assert(r&&identity==1&&r->descr==a->descr);ln_array_free(r);
    double threshold=DBL_EPSILON*100;
    for(int i=0;i<3;++i)values[i].imag=threshold;
    memcpy(a->data,values,sizeof values);
    r=ln_component_close(a,100,&identity,&err);assert(r&&identity==1);ln_array_free(r);
    for(int i=0;i<3;++i)values[i].imag=nextafter(threshold,0);
    memcpy(a->data,values,sizeof values);
    r=ln_component_close(a,100,&identity,&err);assert(r&&identity==0&&r->owner==a->owner&&r->descr->type_num==LN_DOUBLE);
    ln_array_free(r);ln_array_free(a);
    a=ln_array_new(1,(ln_intp[]){0},ln_dtype_by_name("complex64"),0,0,&err);assert(a);
    r=ln_component_close(a,NAN,&identity,&err);assert(r&&identity==0&&r->descr->type_num==LN_FLOAT);
    ln_array_free(r);ln_array_free(a);
    puts("predicates112 native tests passed");return 0;
}
