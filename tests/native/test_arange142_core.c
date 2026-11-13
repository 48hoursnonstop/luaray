#include "ln_arange.h"
#include <assert.h>
#include <math.h>
#include <stdio.h>
#include <string.h>
static ln_ufunc_operand integer(int64_t n)
{ln_ufunc_operand value={.kind=LN_UFUNC_WEAK_INT,.integer=n};return value;}
static ln_ufunc_operand floating(double n)
{ln_ufunc_operand value={.kind=LN_UFUNC_WEAK_FLOAT,.floating=n};return value;}
int main(void)
{
    ln_error error={0};ln_ufunc_operand a=integer(120),b=integer(140),step=integer(3);
    ln_array *r=ln_array_arange(&a,&b,&step,ln_dtype_by_name("int8"),&error);assert(r&&r->dimensions[0]==7);
    int8_t expected[]={120,123,126,-127,-124,-121,-118};assert(!memcmp(r->data,expected,sizeof expected));ln_array_free(r);
    a=integer(INT64_MIN);b=integer(INT64_MAX);step=integer(INT64_MAX);
    r=ln_array_arange(&a,&b,&step,NULL,&error);assert(r&&r->dimensions[0]==2);
    int64_t x;memcpy(&x,r->data,8);assert(x==INT64_MIN);memcpy(&x,r->data+8,8);assert(x==-1);ln_array_free(r);
    a=integer(INT64_MAX);b=floating(0x1.1p64);step=integer(INT64_MAX);
    r=ln_array_arange(&a,&b,&step,ln_dtype_by_name("uint64"),&error);assert(r&&r->dimensions[0]==2);
    uint64_t u;memcpy(&u,r->data+8,8);assert(u==UINT64_MAX-1);ln_array_free(r);
    assert(!ln_array_arange(&a,&b,&step,ln_dtype_by_name("int64"),&error));
    a=floating(100000000);b=floating(100000005);step=integer(1);
    r=ln_array_arange(&a,&b,&step,ln_dtype_by_name("float32"),&error);assert(r&&r->dimensions[0]==5);
    for(int i=0;i<5;++i){float v;memcpy(&v,r->data+4*i,4);assert(v==100000000);}ln_array_free(r);
    a=integer(0);b=integer(3);step=floating(INFINITY);
    r=ln_array_arange(&a,&b,&step,NULL,&error);assert(r&&r->dimensions[0]==1);ln_array_free(r);
    step=floating(-INFINITY);r=ln_array_arange(&a,&b,&step,NULL,&error);assert(r&&r->dimensions[0]==0);ln_array_free(r);
    step=floating(0);assert(!ln_array_arange(&a,&b,&step,NULL,&error));
    step=floating(NAN);assert(!ln_array_arange(&a,&b,&step,NULL,&error));
    step=floating(0x1p-1074);assert(!ln_array_arange(&a,&b,&step,NULL,&error));
    step=integer(1);assert(!ln_array_arange(&a,&b,&step,ln_dtype_by_name("bool"),&error));
    b=integer(2);r=ln_array_arange(&a,&b,&step,ln_dtype_by_name("bool"),&error);
    assert(r&&!r->data[0]&&r->data[1]);ln_array_free(r);
    b=(ln_ufunc_operand){.kind=LN_UFUNC_WEAK_COMPLEX,.real=3,.imag=3};
    r=ln_array_arange(&a,&b,&step,NULL,&error);assert(r&&r->dimensions[0]==3&&r->descr->kind=='c');ln_array_free(r);
    step=(ln_ufunc_operand){.kind=LN_UFUNC_WEAK_COMPLEX,.real=INFINITY,.imag=INFINITY};
    r=ln_array_arange(&a,&b,&step,NULL,&error);assert(r&&r->dimensions[0]==0);ln_array_free(r);
    step=integer(1);assert(!ln_array_arange(&a,&b,&step,ln_dtype_by_name("float64"),&error));
    assert(!ln_array_arange(&a,&b,&step,ln_dtype_by_name("U0"),&error));
    assert(!ln_array_arange(NULL,&b,&step,NULL,&error));
    r=ln_array_arange_legacy(4,ln_dtype_by_name("bool"),&error);
    assert(r&&!r->data[0]&&r->data[1]&&r->data[2]&&r->data[3]);ln_array_free(r);
    puts("arange142 native: initial conversion, wrap, precision, complex lengths and size guards passed");return 0;
}
