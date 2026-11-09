#include "ln_core.h"
#include "ln_axis.h"
#include "ln_roll.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>

static int64_t at(const ln_array *a, ln_intp i, ln_intp j) {
    double v=0;int64_t integer=0;int is_integer=0;
    ln_intp index[2]={i,j};ln_error err={0};
    assert(ln_array_get_number(a,index,&v,&integer,&is_integer,&err)==0);
    return integer;
}
int main(void) {
    ln_error e={0};
    ln_intp shape[2]={2,3};
    ln_array *a=ln_array_new(2,shape,ln_dtype_by_name("int32"),0,0,&e);
    assert(a);
    for(ln_intp i=0;i<2;i++)for(ln_intp j=0;j<3;j++){
        ln_intp idx[]={i,j};int64_t n=i*3+j;
        assert(!ln_array_set_number(a,idx,(double)n,n,1,&e));
    }
    ln_array *r=ln_roll(a,0,(ln_intp[]){1,2},&e);
    assert(r && r->owner!=a->owner);
    assert(at(r,0,0)==4 && at(r,1,2)==0);
    ln_array *f=ln_roll(a,1,(ln_intp[]){1},&e);
    assert(f && at(f,0,0)==5 && at(f,1,2)==4);
    ln_array *view=ln_axis_permute(a,(int[]){1,0},&e);
    assert(view && view->owner==a->owner);
    ln_array *rolled=ln_roll(view,0,(ln_intp[]){1,0},&e);
    assert(rolled && (rolled->flags&LN_ARRAY_F_CONTIGUOUS));
    assert(rolled->strides[0]==4 && rolled->strides[1]==12);
    assert(at(rolled,0,0)==2 && at(rolled,2,1)==4);
    ln_array_free(a);
    assert(at(f,0,0)==5 && at(view,2,1)==5);
    ln_array_free(view);ln_array_free(rolled);
    ln_array_free(r);ln_array_free(f);
    ln_array *z=ln_array_new(2,(ln_intp[]){0,3},ln_dtype_by_name("<U2"),0,0,&e);
    assert(z);
    ln_array *zero=ln_roll(z,0,(ln_intp[]){0,1},&e);
    assert(zero && ln_array_size(zero)==0 && zero->descr==z->descr);
    ln_array_free(z);ln_array_free(zero);
    puts("roll native core: ok");return 0;
}
