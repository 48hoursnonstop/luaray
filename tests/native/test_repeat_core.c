#include "ln_core.h"
#include "ln_axis.h"
#include "ln_repeat.h"
#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <limits.h>

static int64_t number(const ln_array *a,ln_intp i,ln_intp j) {
    ln_error e={0};double v=0;int64_t n=0;int exact=0;
    ln_intp coord[2]={i,j};
    assert(ln_array_get_number(a,coord,&v,&n,&exact,&e)==0);
    return n;
}
int main(void) {
    ln_error e={0};ln_intp shape[2]={2,3};
    const ln_dtype_descr *dtype=ln_dtype_by_name("int32");
    ln_array *a=ln_array_new(2,shape,dtype,0,0,&e);assert(a);
    for(ln_intp i=0;i<2;i++)for(ln_intp j=0;j<3;j++){
        ln_intp idx[2]={i,j};int64_t x=i*3+j;
        assert(ln_array_set_number(a,idx,(double)x,x,1,&e)==0);
    }
    ln_intp reps[2]={2,3};
    ln_array *t=ln_tile(a,2,reps,&e);assert(t);
    assert(t->dimensions[0]==4 && t->dimensions[1]==9);
    assert(number(t,3,8)==5);
    unsigned char rev[2]={0,1};
    ln_array *flipped=ln_axis_reverse(a,rev,&e);assert(flipped);
    ln_intp one[1]={1};ln_array *f=ln_tile(flipped,1,one,&e);assert(f);
    assert(number(f,0,0)==2 && number(f,1,2)==3);
    ln_array *tran=ln_axis_permute(a,(int[]){1,0},&e);assert(tran);
    ln_array *copied=ln_tile(tran,0,NULL,&e);assert(copied);
    assert(copied->strides[0]==4 && copied->strides[1]==12);
    assert(number(copied,2,1)==5);
    ln_intp counts[3]={1,0,2};
    ln_array *r=ln_repeat(a,1,3,counts,&e);assert(r);
    assert(r->dimensions[1]==3);
    assert(number(r,0,0)==0 && number(r,0,1)==2 && number(r,0,2)==2);
    ln_array *flat=ln_repeat(flipped,-1,1,(ln_intp[]){2},&e);assert(flat);
    assert(flat->nd==1 && flat->dimensions[0]==12);
    int64_t vi=0;double d=0;int exact=0;ln_intp idx[1]={0};
    assert(ln_array_get_number(flat,idx,&d,&vi,&exact,&e)==0 && vi==2);
    ln_intp bad_reps[]={-1};assert(!ln_repeat(a,-1,1,bad_reps,&e));
    ln_intp big_reps[]={INTPTR_MAX};assert(!ln_tile(a,1,big_reps,&e));
    ln_array_free(a);
    assert(number(t,3,8)==5); /* independent copy, no dangling owner */
    ln_array_free(t);ln_array_free(f);ln_array_free(flipped);
    ln_array_free(tran);ln_array_free(copied);ln_array_free(r);ln_array_free(flat);
    puts("repeat/tile native core: ok");
    return 0;
}
