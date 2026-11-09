#include "ln_sampling.h"
#include <assert.h>
#include <math.h>
#include <stdio.h>
#include <string.h>
int main(void)
{
    ln_error err={{0}};const ln_dtype *dtype=ln_dtype_by_name("float64");
    ln_array *a=ln_array_new(0,NULL,dtype,0,0,&err),*b=ln_array_new(0,NULL,dtype,0,0,&err);assert(a&&b);
    memcpy(a->data,(double[]){-1},8);memcpy(b->data,(double[]){1},8);
    ln_array *step=NULL,*out=ln_sampling_linspace(a,b,5,1,0,dtype,NULL,&step,&err);assert(out&&step);
    assert(memcmp(out->data,(double[]){-1,-.5,0,.5,1},40)==0&&*(double *)step->data==.5);
    ln_array_free(out);ln_array_free(step);
    out=ln_sampling_linspace(a,b,0,1,0,dtype,NULL,&step,&err);assert(out&&step&&isnan(*(double *)step->data)&&ln_array_size(out)==0);
    ln_array_free(out);ln_array_free(step);
    out=ln_sampling_linspace(a,b,1,1,0,dtype,NULL,&step,&err);assert(out&&step&&isnan(*(double *)step->data)&&*(double *)out->data==-1);
    ln_array_free(out);ln_array_free(step);
    assert(!ln_sampling_linspace(a,b,-1,1,0,dtype,NULL,&step,&err)&&!step);
    assert(!ln_sampling_linspace(a,b,5,1,1,dtype,NULL,NULL,&err));
    assert(!ln_sampling_linspace(a,b,5,1,0,NULL,NULL,NULL,&err));
    assert(!ln_sampling_linspace(NULL,b,5,1,0,dtype,NULL,NULL,&err));
    ln_ufunc_operand base={.kind=LN_UFUNC_WEAK_FLOAT,.floating=10.};
    memcpy(a->data,(double[]){0},8);memcpy(b->data,(double[]){2},8);
    out=ln_sampling_logspace(a,b,&base,3,1,0,dtype,NULL,&err);assert(out&&memcmp(out->data,(double[]){1,10,100},24)==0);ln_array_free(out);
    assert(!ln_sampling_logspace(a,b,NULL,3,1,0,dtype,NULL,&err));
    assert(!ln_sampling_geomspace(a,b,3,1,0,dtype,NULL,&err));
    memcpy(a->data,(double[]){-1},8);memcpy(b->data,(double[]){-16},8);
    out=ln_sampling_geomspace(a,b,5,1,0,dtype,NULL,&err);assert(out&&fabs(((double *)out->data)[2]+4)<1e-12&&((double *)out->data)[4]==-16);ln_array_free(out);
    assert(!ln_sampling_geomspace(a,b,3,1,1,dtype,NULL,&err));
    assert(!ln_sampling_geomspace(a,b,3,1,0,NULL,NULL,&err));
    assert(!ln_sampling_geomspace(NULL,b,3,1,0,dtype,NULL,&err));
    ln_array *matrix=ln_array_new(2,(ln_intp[]){2,3},ln_dtype_by_name("float32"),0,1,&err);assert(matrix);
    ln_array *broadcast=ln_array_view(matrix,2,(ln_intp[]){2,3},(ln_intp[]){0,4},matrix->data,&err);assert(broadcast);
    out=ln_array_new_keeporder(broadcast,dtype,&err);assert(out&&out->owner!=matrix->owner);
    assert(out->strides[0]==8&&out->strides[1]==16&&(out->flags&LN_ARRAY_WRITEABLE));
    ln_array_free(broadcast);ln_array_free(matrix);ln_array_free(out);
    assert(!ln_array_new_keeporder(NULL,dtype,&err));
    ln_array_free(a);ln_array_free(b);puts("sampling106 native core: passed");return 0;
}
