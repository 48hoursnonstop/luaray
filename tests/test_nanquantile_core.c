/* Native NaN-filtered quantile tests, without Python or Lua numbers. */
#include "ln_quantile.h"
#include <assert.h>
#include <math.h>
#include <stdint.h>
#include <string.h>
#include <stdio.h>
int main(void){
    ln_error e={{0}};
    ln_intp dims[]={2,4};
    ln_array *a=ln_array_new(2,dims,ln_dtype_by_num(LN_DOUBLE),0,0,&e);
    assert(a);
    const double in[]={NAN,2,4,6,NAN,NAN,NAN,NAN};
    memcpy(a->data,in,sizeof in);
    uint8_t axis[]={0,1}; double q[]={0.5,1};
    ln_array *r=ln_quantile(a,axis,0,q,2,0,0,NULL,NULL,1,&e);
    assert(r && r->nd==2 && r->dimensions[0]==2 && r->dimensions[1]==2);
    double x;
    memcpy(&x,r->data,sizeof x); assert(x==4);
    memcpy(&x,r->data+r->strides[1],sizeof x); assert(isnan(x));
    memcpy(&x,r->data+r->strides[0],sizeof x); assert(x==6);
    ln_array_free(r);
    /* Transposed rows, including negative strides: no in-place sorting. */
    ln_intp vdims[]={2,4};ln_intp vstrides[]={a->strides[0],-a->strides[1]};
    ln_array *v=ln_array_view(a,2,vdims,vstrides,a->data+3*a->strides[1],&e);
    assert(v); r=ln_quantile(v,axis,0,q,1,1,6,NULL,NULL,1,&e);
    assert(r && r->nd==1 && r->dimensions[0]==2);
    memcpy(&x,r->data,sizeof x);assert(x==4);
    memcpy(&x,r->data+r->strides[0],sizeof x);assert(isnan(x));
    ln_array_free(r);ln_array_free(v);
    /* A scalar output aliases its input: compute before writing. */
    ln_array *out=ln_array_view(a,0,NULL,NULL,a->data,&e);
    assert(out);
    r=ln_quantile(a,NULL,0,q,1,1,6,NULL,out,1,&e);
    assert(r);ln_array_free(r);
    memcpy(&x,a->data,sizeof x);assert(x==4);ln_array_free(out);
    /* Original nonaliased cells preserved. */
    memcpy(&x,a->data+sizeof(double),sizeof x); assert(x==2);
    ln_array_free(a);
    /* Float32 all-NaN slices must retain the floating DType. */
    ln_intp fdim[]={3};ln_array *b=ln_array_new(1,fdim,ln_dtype_by_num(LN_FLOAT),0,0,&e);
    assert(b);float fs[]={NAN,NAN,NAN};memcpy(b->data,fs,sizeof fs);
    r=ln_quantile(b,NULL,0,q,2,0,0,ln_dtype_by_num(LN_DOUBLE),NULL,1,&e);
    assert(r && r->descr->type_num==LN_FLOAT && r->dimensions[0]==2);
    memcpy(&fs[0],r->data,sizeof(float));assert(isnan(fs[0]));
    ln_array_free(r);ln_array_free(b);
    /* Invalid q cannot allocate a partial result. */
    b=ln_array_new(1,fdim,ln_dtype_by_num(LN_FLOAT),0,0,&e); assert(b);
    q[0]=NAN;
    assert(!ln_quantile(b,NULL,0,q,1,1,0,NULL,NULL,1,&e));
    ln_array_free(b);
    puts("nanquantile native core: ok");
    return 0;
}
