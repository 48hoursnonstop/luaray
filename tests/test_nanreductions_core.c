/* Host-neutral tests of the shared NaN selection kernel, without Lua/Python. */
#include "ln_stats.h"
#include "ln_complex.h"
#include <assert.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

int main(void) {
    ln_error e={{0}};
    ln_intp d[]={2,3};
    ln_array *a=ln_array_new(2,d,ln_dtype_by_num(LN_DOUBLE),0,0,&e);
    assert(a);
    const double vals[]={NAN,1,4,2,NAN,8};
    memcpy(a->data,vals,sizeof vals);
    uint8_t wdata[]={1,1,0};
    ln_intp wd[]={3};ln_intp ws[]={1};
    ln_array where={0};
    where.data=(char *)wdata;where.nd=1;where.dimensions=wd;
    where.strides=ws;where.descr=ln_dtype_by_num(LN_BOOL);
    ln_array *mask=ln_stats_nan_where(a,&where,&e);
    assert(mask && mask->nd==2);
    const uint8_t want[]={0,1,0,1,0,0};
    assert(memcmp(mask->data,want,6)==0);
    uint8_t flags[]={0,1};
    ln_array *sum=ln_reduce_ex(a,flags,0,NULL,mask,LN_REDUCE_SUM,0,0,0,0,&e);
    assert(sum && sum->nd==1 && sum->dimensions[0]==2);
    double x,y;memcpy(&x,sum->data,sizeof x);memcpy(&y,sum->data+sum->strides[0],sizeof y);
    assert(x==1 && y==2);
    ln_array_free(sum);ln_array_free(mask);
    /* Negative strides: selection follows logical coordinates, not linear backing bytes. */
    ln_intp negative[]={a->strides[0],-a->strides[1]};
    ln_array *reverse=ln_array_view(a,2,d,negative,a->data+2*a->strides[1],&e);
    assert(reverse);
    mask=ln_stats_nan_where(reverse,NULL,&e);
    assert(mask);
    const uint8_t want_rev[]={1,1,0,1,0,1};
    assert(memcmp(mask->data,want_rev,6)==0);
    ln_array_free(mask);ln_array_free(reverse);ln_array_free(a);
    /* Both parts of a complex number must be finite to be selected. */
    ln_intp zdim[]={3};
    ln_array *z=ln_array_new(1,zdim,ln_dtype_by_num(LN_CDOUBLE),0,0,&e);
    assert(z);
    const ln_cdouble zv[]={{1,2},{3,NAN},{NAN,5}};
    memcpy(z->data,zv,sizeof zv);
    mask=ln_stats_nan_where(z,NULL,&e);
    assert(mask && (unsigned char)mask->data[0]==1 &&
        mask->data[1]==0 && mask->data[2]==0);
    ln_array_free(mask);ln_array_free(z);
    /* The mask cannot lose 64-bit integer precision or reinterpret its bits as floats. */
    ln_array *u=ln_array_new(1,zdim,ln_dtype_by_num(LN_ULONGLONG),0,0,&e);
    assert(u);
    const uint64_t ul[]={UINT64_MAX,(UINT64_C(1)<<63)+1,0};
    memcpy(u->data,ul,sizeof ul);
    mask=ln_stats_nan_where(u,NULL,&e);
    assert(mask && mask->data[0]==1 && mask->data[1]==1 && mask->data[2]==1);
    assert(memcmp(u->data,ul,sizeof ul)==0);
    ln_array_free(mask);ln_array_free(u);
    /* All-NaN sample counts: nanvar returns NaN, without a fabricated zero. */
    ln_array *f=ln_array_new(1,zdim,ln_dtype_by_num(LN_FLOAT),0,0,&e);
    assert(f);const float floats[]={NAN,1,3};memcpy(f->data,floats,sizeof floats);
    mask=ln_stats_nan_where(f,NULL,&e);assert(mask);
    ln_array *v=ln_stats_var_std(f,NULL,0,NULL,mask,2,0,1,NULL,&e);
    assert(v);float fv;memcpy(&fv,v->data,sizeof fv);assert(isnan(fv));
    ln_array_free(v);ln_array_free(mask);ln_array_free(f);
    puts("nanreductions native core: ok");return 0;
}
