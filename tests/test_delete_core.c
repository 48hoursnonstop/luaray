#include "ln_core.h"
#include "ln_axis.h"
#include "ln_delete.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>

static int64_t num(const ln_array *a, ln_intp i, ln_intp j) {
    ln_intp idx[2]={i,j};double v=0;int64_t vi=0;int exact=0;ln_error e={0};
    assert(ln_array_get_number(a,idx,&v,&vi,&exact,&e)==0);
    return vi;
}
int main(void) {
    ln_error e={0};
    const ln_dtype_descr *d=ln_dtype_by_name("int32");
    ln_intp shape[2]={2,3};
    ln_array *a=ln_array_new(2,shape,d,0,0,&e);assert(a);
    for(ln_intp i=0;i<2;i++)for(ln_intp j=0;j<3;j++){
        ln_intp idx[2]={i,j};int64_t x=i*3+j;
        assert(ln_array_set_number(a,idx,(double)x,x,1,&e)==0);
    }
    unsigned char mask[]={0,1,0};
    ln_array *r=ln_delete(a,1,mask,3,&e); assert(r);
    assert(r->nd==2 && r->dimensions[0]==2 && r->dimensions[1]==2);
    assert(num(r,0,0)==0 && num(r,0,1)==2 && num(r,1,0)==3 && num(r,1,1)==5);
    ln_array *t=ln_axis_permute(a,(int[]){1,0},&e);assert(t);
    unsigned char rm[]={1,0};
    ln_array *v=ln_delete(t,1,rm,2,&e);assert(v);
    assert(v->dimensions[0]==3 && v->dimensions[1]==1 && num(v,0,0)==3 && num(v,2,0)==5);
    unsigned char flatmask[]={0,1,0,0,1,0};
    ln_array *f=ln_delete(t,-1,flatmask,6,&e);assert(f);
    assert(f->nd==1 && f->dimensions[0]==4 && num(f,0,0)==0 && num(f,3,0)==5);
    assert(!ln_delete(a,1,mask,2,&e));
    assert(!ln_delete(a,3,mask,3,&e));
    ln_array_free(a);ln_array_free(t);
    assert(num(r,0,1)==2 && num(v,2,0)==5); /* outputs own storage */
    ln_array_free(r);ln_array_free(v);ln_array_free(f);
    puts("delete native core: ok");
    return 0;
}
