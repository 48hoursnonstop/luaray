#include "ln_quantile.h"
#include <assert.h>
#include <math.h>
#include <stdint.h>
#include <string.h>
#include <stdio.h>
int main(void){
    ln_error e={0};
    ln_intp dims[]={3};
    ln_array *a=ln_array_new(1,dims,ln_dtype_by_num(LN_ULONGLONG),0,0,&e);
    assert(a);
    const uint64_t values[]={UINT64_MAX-2,UINT64_C(9223372036854775812),UINT64_MAX-7};
    memcpy(a->data,values,sizeof values);
    double q[]={0,1};
    ln_array *r=ln_quantile(a,NULL,0,q,2,0,1,NULL,NULL,0,&e);
    assert(r && r->nd==1 && r->dimensions[0]==2 && r->descr->type_num==LN_ULONGLONG);
    uint64_t low,high;
    memcpy(&low,r->data,8);memcpy(&high,r->data+r->strides[0],8);
    assert(low==values[1] && high==values[0]);
    ln_array_free(r);
    /* Scalar quantile=1 selects exactly, without loss of 64-bit precision. */
    r=ln_quantile(a,NULL,0,q+1,1,1,7,NULL,NULL,0,&e);
    assert(r && r->descr->type_num==LN_ULONGLONG);
    memcpy(&high,r->data,8);assert(high==values[0]);ln_array_free(r);
    /* This source remains unchanged; select using a negative-stride view. */
    ln_array *v=ln_array_view(a,1,dims,(ln_intp[]){-8},a->data+16,&e);
    assert(v);
    q[0]=0.5;
    r=ln_quantile(v,NULL,0,q,1,1,6,NULL,NULL,0,&e);
    assert(r && r->descr->type_num==LN_DOUBLE);
    double mid;memcpy(&mid,r->data,sizeof mid);
    assert(mid>1.8e19);
    assert(memcmp(a->data,values,sizeof values)==0);
    ln_array_free(r);ln_array_free(v);
    /* No leak or partial allocation when quantile arguments are invalid. */
    q[0]=1.01;
    assert(!ln_quantile(a,NULL,0,q,1,1,0,NULL,NULL,0,&e));
    ln_array_free(a);
    puts("quantile native core: ok");
    return 0;
}
