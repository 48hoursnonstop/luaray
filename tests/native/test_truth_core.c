#include "ln_truth.h"
#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <math.h>
int main(void){
    ln_error err={0};
    /* A number which is not exactly representable as double must remain
     * truthy. Both logical axes and counts operate on the original bytes. */
    ln_array *a=ln_array_new(2,(ln_intp[]){2,3},ln_dtype_by_name("uint64"),0,1,&err);
    assert(a);
    uint64_t v[]={0,UINT64_MAX,0,UINT64_MAX-1,0,7};
    memcpy(a->data,v,sizeof(v));
    uint8_t flags[]={1,0};
    ln_array *r=ln_truth_reduce(a,flags,0,NULL,2,NULL,&err);
    assert(r && r->nd==1 && r->dimensions[0]==3);
    int64_t c[3];memcpy(c,r->data,sizeof(c));
    assert(c[0]==1 && c[1]==1 && c[2]==1);
    ln_array_free(r);
    /* Negative strides must read logical elements without copying. */
    ln_array *rev=ln_array_view(a,2,(ln_intp[]){2,3},
       (ln_intp[]){3*(ln_intp)sizeof(uint64_t),-(ln_intp)sizeof(uint64_t)},
       a->data+2*sizeof(uint64_t),&err);
    assert(rev);
    r=ln_truth_reduce(rev,flags,0,NULL,0,NULL,&err);
    assert(r && r->data[0]==1 && r->data[1]==1 && r->data[2]==1);
    ln_array_free(r);
    ln_array_free(rev);
    /* Aliasing out to the input must not change a later input read. */
    uint8_t none[2]={0,0};
    r=ln_truth_reduce(a,none,0,NULL,0,NULL,&err);
    assert(r && r->nd==2 && r->data[0]==0 && r->data[1]==1);
    ln_array_free(r);
    /* Masked all over zero selected values retains its neutral true. */
    ln_array *mask=ln_array_new(0,NULL,ln_dtype_by_num(LN_BOOL),0,1,&err);
    assert(mask);
    uint8_t allaxes[]={1,1};
    r=ln_truth_reduce(a,allaxes,0,mask,1,NULL,&err);
    assert(r && r->nd==0 && r->data[0]==1);
    ln_array_free(r);ln_array_free(mask);
    /* NaN is truthy; +/-zero are falsy. */
    ln_array *f=ln_array_new(1,(ln_intp[]){3},ln_dtype_by_num(LN_DOUBLE),0,0,&err);
    assert(f);
    double vals[]={0,-0.,NAN};memcpy(f->data,vals,sizeof(vals));
    uint8_t ax[]={1};
    r=ln_truth_reduce(f,ax,0,NULL,2,NULL,&err);
    assert(r);int64_t count;memcpy(&count,r->data,8);assert(count==1);
    ln_array_free(r);ln_array_free(f);
    ln_array_free(a);
    /* Empty input with arbitrarily large Unicode itemsize must not read
     * past a scratch buffer just to identify its dtype. */
    const ln_dtype *wide=ln_dtype_by_name("U128");assert(wide);
    a=ln_array_new(1,(ln_intp[]){0},wide,0,0,&err);assert(a);
    r=ln_truth_reduce(a,(uint8_t[]){1},0,NULL,1,NULL,&err);
    assert(r && r->data[0]==1);
    ln_array_free(r);ln_array_free(a);
    puts("truth native core: ok");return 0;
}
