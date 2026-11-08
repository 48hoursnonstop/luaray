#include "ln_stats.h"
#include "ln_complex.h"
#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <math.h>

int main(void) {
    ln_error err={{0}};
    /* uint64 must not round through double when preparing nan-aware input. */
    ln_array *a=ln_array_new(1,(ln_intp[]){3},ln_dtype_by_num(LN_ULONGLONG),0,0,&err);
    assert(a);
    uint64_t values[3]={UINT64_MAX-2,1,1};
    memcpy(a->data,values,sizeof(values));
    ln_array *clean=ln_stats_nan_replace(a,0,&err);
    assert(clean && memcmp(clean->data,values,sizeof(values))==0);
    ln_array *c=ln_accumulate_ex(clean,0,ln_dtype_by_num(LN_ULONGLONG),LN_REDUCE_SUM,&err);
    assert(c);
    uint64_t expect[3]={UINT64_MAX-2,UINT64_MAX-1,UINT64_MAX};
    assert(memcmp(c->data,expect,sizeof(expect))==0);
    ln_array_free(c);ln_array_free(clean);ln_array_free(a);

    a=ln_array_new(1,(ln_intp[]){4},ln_dtype_by_num(LN_DOUBLE),0,0,&err);
    assert(a);
    double in[4]={1.5,NAN,2.5,NAN};memcpy(a->data,in,sizeof(in));
    ln_array *reversed=ln_array_view(a,1,(ln_intp[]){4},
        (ln_intp[]){-(ln_intp)sizeof(double)},a->data+3*sizeof(double),&err);
    assert(reversed);
    clean=ln_stats_nan_replace(reversed,1,&err);assert(clean);
    double expected[4]={1,2.5,1,1.5};
    assert(memcmp(clean->data,expected,sizeof(expected))==0);
    c=ln_accumulate_ex(clean,0,NULL,LN_REDUCE_PROD,&err);assert(c);
    double prod[4]={1,2.5,2.5,3.75};
    assert(memcmp(c->data,prod,sizeof(prod))==0);
    assert(isnan(in[1])&&isnan(in[3]));
    ln_array_free(c);ln_array_free(clean);ln_array_free(reversed);ln_array_free(a);

    a=ln_array_new(1,(ln_intp[]){3},ln_dtype_by_num(LN_CDOUBLE),0,0,&err);
    assert(a);
    ln_cdouble zv[3]={{1,2},{3,NAN},{4,5}};memcpy(a->data,zv,sizeof(zv));
    clean=ln_stats_nan_replace(a,0,&err);assert(clean);
    ln_cdouble cc[3];memcpy(cc,clean->data,sizeof(cc));
    assert(cc[0].real==1 && cc[0].imag==2);
    assert(cc[1].real==0 && cc[1].imag==0);
    assert(cc[2].real==4 && cc[2].imag==5);
    ln_array_free(clean);ln_array_free(a);
    puts("cumulative native core: ok");
    return 0;
}
