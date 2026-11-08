#include "ln_average.h"
#include "ln_complex.h"
#include <stdint.h>
#include <string.h>
#include <math.h>
#include <assert.h>
#include <stdio.h>
static double from_f64(const ln_array *a,size_t i){
    double result; memcpy(&result,a->data+i*8,8);return result;
}
int main(void){
    ln_error e={{0}};
    ln_array *a=ln_array_new(2,(ln_intp[]){2,3},ln_dtype_by_name("uint64"),0,0,&e);
    assert(a);
    /* These values are not representable by Lua's double numeric type. */
    uint64_t vals[6]={UINT64_MAX-6,UINT64_MAX-5,UINT64_MAX-4,UINT64_MAX-3,UINT64_MAX-2,UINT64_MAX-1};
    memcpy(a->data,vals,sizeof(vals));
    ln_array *w=ln_array_new(1,(ln_intp[]){3},ln_dtype_by_name("float64"),0,0,&e);
    assert(w);double weights[3]={1,2,1};memcpy(w->data,weights,sizeof(weights));
    uint8_t axis[2]={0,1};ln_array *sw=NULL;
    ln_array *avg=ln_average(a,w,axis,0,&sw,&e);
    assert(avg&&sw&&avg->nd==1&&avg->dimensions[0]==2&&sw->nd==1);
    assert(fabs(from_f64(avg,0)-(double)UINT64_MAX)<4096);
    assert(fabs(from_f64(avg,1)-(double)UINT64_MAX)<4096);
    assert(from_f64(sw,0)==4.0&&from_f64(sw,1)==4.0);
    ln_array_free(avg);ln_array_free(sw);
    /* Reverse both rows' order via the strides: average must read views. */
    ln_array *v=ln_array_view(a,2,(ln_intp[]){2,3},
        (ln_intp[]){3*(ln_intp)sizeof(uint64_t),-(ln_intp)sizeof(uint64_t)},
        a->data+2*sizeof(uint64_t),&e);
    assert(v);avg=ln_average(v,w,axis,0,NULL,&e);assert(avg);ln_array_free(avg);
    ln_array_free(v);ln_array_free(w);ln_array_free(a);
    /* Complex data and complex weights are divided as complex numbers. */
    a=ln_array_new(1,(ln_intp[]){2},ln_dtype_by_name("complex128"),0,0,&e);
    w=ln_array_new(1,(ln_intp[]){2},ln_dtype_by_name("complex128"),0,0,&e);
    assert(a&&w);
    ln_cdouble z[2]={{2,1},{4,3}},zw[2]={{1,1},{1,-1}};
    memcpy(a->data,z,sizeof(z));memcpy(w->data,zw,sizeof(zw));
    uint8_t ax[1]={1};avg=ln_average(a,w,ax,0,&sw,&e);
    assert(avg&&sw&&avg->nd==0&&sw->nd==0);
    ln_cdouble rz,ws;memcpy(&rz,avg->data,sizeof(rz));memcpy(&ws,sw->data,sizeof(ws));
    assert(fabs(rz.real-4)<1e-12&&fabs(rz.imag-1)<1e-12);
    assert(fabs(ws.real-2)<1e-12&&fabs(ws.imag)<1e-12);
    ln_array_free(avg);ln_array_free(sw);
    ln_array_free(a);ln_array_free(w);
    puts("average native core: ok");
    return 0;
}
