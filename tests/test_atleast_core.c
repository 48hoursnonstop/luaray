/* Host-neutral NumPy atleast_1d/2d/3d view invariants. */
#include "ln_axis.h"
#include <assert.h>
#include <stdint.h>
#include <stdio.h>

int main(void) {
    ln_error e={{0}};
    const ln_dtype *d=ln_dtype_by_name("int32");
    ln_array *scalar=ln_array_new(0,NULL,d,0,0,&e);
    assert(scalar);
    for(int n=1;n<=3;n++) {
        ln_array *v=ln_axis_atleast(scalar,n,&e);
        assert(v && v->owner==scalar->owner && v->nd==n);
        for(int j=0;j<n;j++) assert(v->dimensions[j]==1 && v->strides[j]==4);
        ln_array_free(v);
    }
    ln_array_free(scalar);
    ln_array *a=ln_array_new(1,(ln_intp[]){3},d,0,0,&e);
    assert(a);
    ln_array *v=ln_axis_atleast(a,3,&e);
    assert(v && v->owner==a->owner && v->dimensions[0]==1 && v->dimensions[1]==3 && v->dimensions[2]==1);
    assert(v->strides[0]==0 && v->strides[1]==4 && v->strides[2]==0);
    ln_intp i0[]={1};ln_intp i1[]={0,1,0};
    assert(ln_array_set_number(a,i0,61.0,61,1,&e)==0);
    double f=0;int64_t iv=0;int is_int=0;
    assert(ln_array_get_number(v,i1,&f,&iv,&is_int,&e)==0 && iv==61);
    ln_array_free(a);
    assert(ln_array_get_number(v,i1,&f,&iv,&is_int,&e)==0 && iv==61);
    ln_array_free(v);
    ln_array *m=ln_array_new(2,(ln_intp[]){2,3},d,1,0,&e);
    assert(m);
    v=ln_axis_atleast(m,3,&e);
    assert(v && v->strides[0]==4 && v->strides[1]==8 && v->strides[2]==0);
    ln_array_free(v);ln_array_free(m);
    ln_array *z=ln_array_new(1,(ln_intp[]){0},ln_dtype_by_name("<U2"),0,0,&e);
    assert(z);
    v=ln_axis_atleast(z,3,&e);
    assert(v && v->descr==z->descr && ln_array_size(v)==0);
    ln_array_free(z);ln_array_free(v);
    puts("atleast native core: ok");
    return 0;
}
