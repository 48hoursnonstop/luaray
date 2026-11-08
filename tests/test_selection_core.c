#include "ln_stats.h"
#include "ln_axis.h"
#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <math.h>

static int64_t at(const ln_array *a,ln_intp i){
    int64_t v=0;memcpy(&v,a->data+i*a->strides[0],sizeof(v));return v;
}
int main(void){
    ln_error e={{0}};
    ln_array *a=ln_array_new(2,(ln_intp[]){2,3},ln_dtype_by_num(LN_LONGLONG),0,0,&e);
    assert(a);
    int64_t v[]={3,1,9,-2,5,4};memcpy(a->data,v,sizeof(v));
    ln_array *mi=ln_stats_argextrema(a,-1,0,0,NULL,&e);
    ln_array *ma=ln_stats_argextrema(a,-1,0,1,NULL,&e);
    assert(mi&&ma&&mi->nd==0&&ma->nd==0);
    ln_intp j=0;memcpy(&j,mi->data,sizeof(j));assert(j==4);
    memcpy(&j,ma->data,sizeof(j));assert(j==3);
    ln_array_free(mi);ln_array_free(ma);
    /* Aliasing out uses a staging buffer: first row is an output view. */
    ln_array *view=ln_array_view(a,1,(ln_intp[]){3},
                       (ln_intp[]){a->strides[1]},a->data,&e);
    assert(view);
    ln_array *res=ln_stats_ptp(a,(uint8_t[]){1,0},0,view,&e);
    assert(res && at(view,0)==5 && at(view,1)==4 && at(view,2)==5);
    ln_array_free(res);ln_array_free(view);ln_array_free(a);
    ln_array *t=ln_array_new(1,(ln_intp[]){4},ln_dtype_by_num(LN_DOUBLE),0,0,&e);
    assert(t);
    double vals[]={NAN,20,-3,NAN};memcpy(t->data,vals,sizeof(vals));
    mi=ln_stats_argextrema(t,-1,0,0,NULL,&e);
    ma=ln_stats_argextrema(t,-1,0,1,NULL,&e);
    assert(mi&&ma);
    memcpy(&j,mi->data,sizeof(j));assert(j==1);
    memcpy(&j,ma->data,sizeof(j));assert(j==1);
    ln_array_free(mi);ln_array_free(ma);ln_array_free(t);
    /* Reducing length-one rows over an empty nonreduced dimension succeeds. */
    ln_array *empty=ln_array_new(2,(ln_intp[]){0,3},ln_dtype_by_num(LN_DOUBLE),0,0,&e);
    assert(empty);
    res=ln_stats_argextrema(empty,1,0,0,NULL,&e);
    assert(res&&res->nd==1&&res->dimensions[0]==0);
    ln_array_free(res);
    assert(!ln_stats_argextrema(empty,0,0,0,NULL,&e));
    ln_array_free(empty);
    puts("selection native core: ok");return 0;
}
