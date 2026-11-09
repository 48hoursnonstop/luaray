#include "ln_insert.h"
#include "ln_axis.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>

static int64_t item(const ln_array *a,ln_intp i,ln_intp j){
    ln_intp idx[2]={i,j};double dv=0;int64_t v=0;int isint=0;ln_error e={0};
    assert(ln_array_get_number(a,idx,&dv,&v,&isint,&e)==0);return v;
}
int main(void){
    ln_error e={0};
    const ln_dtype_descr *dtype=ln_dtype_by_name("int32");
    ln_intp shape[]={2,3};
    ln_array *a=ln_array_new(2,shape,dtype,0,0,&e);assert(a);
    for(ln_intp i=0;i<2;i++)for(ln_intp j=0;j<3;j++){
        ln_intp at[]={i,j};int64_t value=1+i*3+j;
        assert(ln_array_set_number(a,at,(double)value,value,1,&e)==0);
    }
    ln_intp scalar_shape[1]={0};
    ln_array *value=ln_array_new(0,scalar_shape,dtype,0,0,&e);assert(value);
    assert(ln_array_set_number(value,NULL,99,99,1,&e)==0);
    ln_intp duplicate[]={1,1};
    ln_array *out=ln_insert(a,1,duplicate,2,0,value,&e);assert(out);
    assert(out->nd==2 && out->dimensions[0]==2 && out->dimensions[1]==5);
    assert(item(out,0,0)==1 && item(out,0,1)==99 && item(out,0,2)==99);
    assert(item(out,0,3)==2 && item(out,1,4)==6);
    ln_intp reverse[]={2,0};
    ln_array *unordered=ln_insert(a,0,reverse,2,0,value,&e);assert(unordered);
    assert(item(unordered,0,0)==99 && item(unordered,1,0)==1);
    assert(item(unordered,3,0)==99);
    ln_array *transposed=ln_axis_permute(a,(int[]){1,0},&e);assert(transposed);
    ln_intp one[]={1};
    ln_array *v=ln_insert(transposed,-1,one,1,1,value,&e);assert(v);
    assert(v->nd==1 && v->dimensions[0]==7 && item(v,0,0)==1 && item(v,1,0)==99);
    ln_intp bad[]={4};
    assert(!ln_insert(a,1,bad,1,1,value,&e));
    ln_array_free(a);ln_array_free(transposed);ln_array_free(value);
    assert(item(out,1,4)==6 && item(v,6,0)==6);
    ln_array_free(out);ln_array_free(unordered);ln_array_free(v);
    puts("insert native core: ok");
    return 0;
}
