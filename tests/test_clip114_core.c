#include "ln_clip.h"
#include "ln_datetime.h"
#include "ln_half.h"
#include <assert.h>
#include <math.h>
#include <stdio.h>
#include <string.h>
int main(void)
{
    ln_error err={0};ln_intp dims[]={4};
    const ln_ufunc *uf=ln_clip_ufunc();assert(uf->nin==3&&uf->nout==1&&uf->nloops==20);
    ln_array *a=ln_array_new(1,dims,ln_dtype_by_name("float64"),0,1,&err);
    double v[]={-0.,0.,-1.,2.};memcpy(a->data,v,sizeof v);
    ln_ufunc_operand lo={0},hi={0};lo.kind=hi.kind=LN_UFUNC_WEAK_FLOAT;
    lo.floating=0.;hi.floating=-0.;ln_array *out=NULL;
    assert(ln_array_clip(a,&lo,&hi,&out,NULL,&err)==0);
    double *p=(double *)out->data;assert(signbit(p[0])&&!signbit(p[1])&&!signbit(p[2])&&signbit(p[3]));
    ln_array_free(out);out=NULL;
    a->flags&=~LN_ARRAY_WRITEABLE;
    out=a;assert(ln_array_clip(a,&lo,&hi,&out,NULL,&err)<0);assert(memcmp(v,a->data,sizeof v)==0);
    a->flags|=LN_ARRAY_WRITEABLE;
    lo.floating=NAN;hi.floating=1.;out=a;
    assert(ln_array_clip(a,&lo,&hi,&out,NULL,&err)==0);
    for(int i=0;i<4;++i)assert(isnan(((double *)a->data)[i]));
    ln_array_free(a);
    ln_intp zero[]={0};a=ln_array_new(1,zero,ln_dtype_by_name("int8"),0,0,&err);
    lo.kind=hi.kind=LN_UFUNC_WEAK_INT;lo.integer=300;hi.integer=400;out=NULL;
    assert(ln_array_clip(a,&lo,&hi,&out,NULL,&err)<0&&out==NULL); /* packing occurs even on empty arrays */
    lo.integer=-999;hi.integer=999;assert(ln_array_clip(a,&lo,&hi,&out,NULL,&err)==0);
    assert(out->descr->type_num==LN_BYTE&&ln_array_size(out)==0);
    ln_array_free(a);ln_array_free(out);
    assert(ln_array_clip(NULL,NULL,NULL,&out,NULL,&err)<0);
    puts("clip114 native: fused signatures, signed zero, readonly, NaN and empty weak overflow passed");
}
