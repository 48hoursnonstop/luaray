#include "ln_round.h"
#include "ln_complex.h"
#include "ln_half.h"
#include <assert.h>
#include <limits.h>
#include <math.h>
#include <stdio.h>
#include <string.h>
int main(void)
{
    ln_error err={0};ln_array *out=NULL;
    assert(ln_array_round(NULL,0,&out,&err)<0);
    ln_array *a=ln_array_new(1,(ln_intp[]){2},ln_dtype_by_name("int64"),0,0,&err);assert(a);
    int64_t integers[]={15,25};memcpy(a->data,integers,sizeof integers);
    assert(ln_array_round(a,-1,&out,&err)==0&&out->descr==a->descr&&out->owner!=a->owner);
    int64_t rounded[2];memcpy(rounded,out->data,sizeof rounded);assert(rounded[0]==20&&rounded[1]==20);
    ln_array_free(out);out=NULL;
    a->flags&=~LN_ARRAY_WRITEABLE;
    assert(ln_array_round(a,0,&out,&err)==0&&(out->flags&LN_ARRAY_WRITEABLE));ln_array_free(out);
    out=a;assert(ln_array_round(a,0,&out,&err)==0&&out==a);ln_array_free(a);
    a=ln_array_new(0,NULL,ln_dtype_by_name("bool"),0,0,&err);assert(a);a->data[0]=1;out=NULL;
    assert(ln_array_round(a,0,&out,&err)==0&&out->descr->type_num==LN_HALF);
    ln_half h;memcpy(&h,out->data,2);assert(ln_half_to_float(h)==1);ln_array_free(out);ln_array_free(a);
    a=ln_array_new(1,(ln_intp[]){1},ln_dtype_by_name("complex64"),0,0,&err);assert(a);
    ln_cfloat z={1.25f,2.5f};memcpy(a->data,&z,sizeof z);
    out=ln_array_new(1,(ln_intp[]){1},ln_dtype_by_name("float64"),0,1,&err);assert(out);
    assert(ln_array_round(a,0,&out,&err)<0&&err.kind==LN_ERROR_TYPE);
    double value;memcpy(&value,out->data,8);assert(value==1);ln_array_free(out);
    out=ln_array_new(1,(ln_intp[]){1},ln_dtype_by_name("complex128"),0,0,&err);assert(out);
    assert(ln_array_round(a,1,&out,&err)==0);
    ln_cdouble result;memcpy(&result,out->data,sizeof result);
    assert(result.real==(double)1.2f&&result.imag==2.5);ln_array_free(out);ln_array_free(a);
    a=ln_array_new(0,NULL,ln_dtype_by_name("float64"),0,0,&err);assert(a);value=1;memcpy(a->data,&value,8);
    /* Native bounds only: don't execute upstream's billion-step factor loop. */
    out=NULL;assert(ln_array_round(a,INT_MAX,&out,&err)==0);memcpy(&value,out->data,8);assert(isnan(value));ln_array_free(out);
    out=NULL;assert(ln_array_round(a,INT_MIN,&out,&err)==0);memcpy(&value,out->data,8);assert(isnan(value));ln_array_free(out);ln_array_free(a);
    puts("round113 native tests passed");return 0;
}
