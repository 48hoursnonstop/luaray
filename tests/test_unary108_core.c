#include "ln_unary_math.h"
#include "ln_half.h"
#include <assert.h>
#include <math.h>
#include <stdio.h>
#include <string.h>

int main(void)
{
    ln_error e={0};ln_intp shape[]={4};
    const ln_ufunc *rint_u=ln_ufunc_by_name("rint");assert(rint_u);
    assert(ln_unary_math_count()==10);
    assert(ln_ufunc_by_name("conj")==ln_ufunc_by_name("conjugate"));
    assert(ln_ufunc_by_name("deg2rad")==ln_ufunc_by_name("radians"));
    assert(!ln_unary_math_by_name("no such ufunc"));
    assert(!ln_unary_math_by_name(NULL));
    ln_array *a=ln_array_new(1,shape,ln_dtype_by_name("float64"),0,0,&e);assert(a);
    double values[]={-0.5,0.5,1.5,2.5};memcpy(a->data,values,sizeof values);
    const ln_array *inputs[]={a};ln_array *out=NULL;
    assert(ln_ufunc_execute(rint_u,inputs,&out,NULL,&e)==0);
    double got[4];memcpy(got,out->data,sizeof got);
    assert(got[0]==0&&signbit(got[0])&&got[1]==0&&got[2]==2&&got[3]==2);
    ln_array_free(out);out=NULL;
    /* Real evaluation through the same descriptor resolution and executor. */
    assert(ln_ufunc_execute(ln_ufunc_by_name("square"),inputs,&out,NULL,&e)==0);
    memcpy(got,out->data,sizeof got);assert(got[0]==.25&&got[3]==6.25);
    ln_array_free(out);ln_array_free(a);
    a=ln_array_new(1,shape,ln_dtype_by_name("int64"),0,0,&e);assert(a);
    int64_t ints[]={INT64_MIN,INT64_MAX,0,-1};memcpy(a->data,ints,sizeof ints);
    inputs[0]=a;out=NULL;
    assert(ln_ufunc_execute(ln_ufunc_by_name("square"),inputs,&out,NULL,&e)==0);
    int64_t result[4];memcpy(result,out->data,sizeof result);
    assert(result[0]==0&&result[1]==1&&result[2]==0&&result[3]==1);
    ln_array_free(out);out=NULL;
    assert(ln_ufunc_execute(ln_ufunc_by_name("reciprocal"),inputs,&out,NULL,&e)==0);
    memcpy(result,out->data,sizeof result);
    assert(result[0]==0&&result[1]==0&&result[2]==INT64_MIN&&result[3]==-1);
    ln_array_free(out);ln_array_free(a);
    a=ln_array_new(1,shape,ln_dtype_by_name("complex64"),0,0,&e);assert(a);
    inputs[0]=a;out=NULL;
    assert(ln_ufunc_execute(ln_ufunc_by_name("floor"),inputs,&out,NULL,&e)<0&&out==NULL);
    ln_array_free(a);
    puts("unary108 native tests passed");return 0;
}
