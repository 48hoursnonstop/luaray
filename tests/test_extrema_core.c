#include "ln_stats.h"
#include "ln_axis.h"
#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

static int64_t val(const ln_array *a,ln_intp i,ln_intp j){
    int64_t x=0;ln_intp c[]={i,j};
    memcpy(&x,a->data+c[0]*a->strides[0]+c[1]*a->strides[1],sizeof(x));
    return x;
}
int main(void){
    ln_error e={{0}};
    ln_intp dims[]={2,3};
    ln_array *a=ln_array_new(2,dims,ln_dtype_by_num(LN_LONGLONG),0,0,&e);
    assert(a);
    const int64_t values[]={5,-4,6,10,2,-3};
    memcpy(a->data,values,sizeof(values));
    uint8_t axis[]={1,0};
    ln_array *mn=ln_stats_extrema(a,axis,0,NULL,0,0,0,0,0,NULL,&e);
    assert(mn && mn->nd==1 && mn->dimensions[0]==3);
    int64_t want[]={5,-4,-3};
    assert(memcmp(mn->data,want,sizeof(want))==0);
    /* Overlapping out parameter: reduction must stage before writing. */
    ln_array *dest=ln_array_view(a,1,(ln_intp[]){3},
                       (ln_intp[]){a->strides[1]},a->data,&e);
    assert(dest);
    ln_array *mx=ln_stats_extrema(a,axis,0,NULL,0,0,0,0,1,dest,&e);
    assert(mx);
    assert(val(a,0,0)==10 && val(a,0,1)==2 && val(a,0,2)==6);
    /* Scalar initial and all-false where. */
    uint8_t z=0;
    ln_array mask={0};mask.data=(char *)&z;mask.descr=ln_dtype_by_num(LN_BOOL);
    ln_array *init=ln_stats_extrema(a,NULL,0,&mask,1,4,4,1,0,NULL,&e);
    assert(init && init->nd==0);
    int64_t iv=0;memcpy(&iv,init->data,sizeof(iv));assert(iv==4);
    ln_array *bad=ln_stats_extrema(a,NULL,0,&mask,0,0,0,0,0,NULL,&e);
    assert(!bad);
    ln_array_free(init);ln_array_free(mn);ln_array_free(mx);
    ln_array_free(dest);ln_array_free(a);
    puts("extrema native core: ok");return 0;
}
