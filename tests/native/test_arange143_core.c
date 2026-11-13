#include "ln_arange.h"
#include "ln_complex.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>
static ln_array *scalar(const char *dtype,int64_t value,ln_error *e)
{
    ln_array *a=ln_array_new(0,NULL,ln_dtype_by_name(dtype),0,0,e);assert(a);
    assert(!ln_array_pack_number(a,NULL,0,value,1,e));return a;
}
int main(void)
{
    ln_error error={0};ln_array *a=scalar("float32",3,&error);
    ln_ufunc_operand start={.kind=LN_UFUNC_WEAK_INT,.integer=0};
    ln_ufunc_operand stop={.kind=LN_UFUNC_OPERAND_ARRAY,.array=a};
    ln_ufunc_operand step={.kind=LN_UFUNC_WEAK_INT,.integer=1};
    a->flags&=~LN_ARRAY_WRITEABLE;
    ln_array *r=ln_array_arange(&start,&stop,&step,NULL,&error);
    assert(r&&r->dimensions[0]==3&&r->descr->type_num==LN_DOUBLE&&r->owner!=a->owner);
    double v;memcpy(&v,r->data+16,8);assert(v==2&&!(a->flags&LN_ARRAY_WRITEABLE));ln_array_free(r);ln_array_free(a);
    a=scalar("int64",256,&error);start=stop;start.array=a;stop.kind=LN_UFUNC_WEAK_INT;stop.integer=257;
    r=ln_array_arange(&start,&stop,&step,ln_dtype_by_name("uint8"),&error);assert(r&&r->data[0]==0);ln_array_free(r);
    stop.integer=258;assert(!ln_array_arange(&start,&stop,&step,ln_dtype_by_name("uint8"),&error));
    int64_t original;memcpy(&original,a->data,8);assert(original==256);ln_array_free(a);
    a=scalar("int64",INT64_C(9007199254740993),&error);start.array=a;stop.integer=INT64_C(9007199254740996);
    r=ln_array_arange(&start,&stop,&step,ln_dtype_by_name("longdouble"),&error);assert(r&&r->dimensions[0]==3);
    for(int i=0;i<3;++i){long double x;memcpy(&x,r->data+i*sizeof x,sizeof x);assert(x==9007199254740992.L+2*i);}
    ln_array_free(r);ln_array_free(a);
    a=scalar("complex64",3,&error);ln_cfloat z={3,-3};memcpy(a->data,&z,sizeof z);
    start.kind=LN_UFUNC_WEAK_INT;start.integer=0;stop.kind=LN_UFUNC_OPERAND_ARRAY;stop.array=a;
    r=ln_array_arange(&start,&stop,&step,NULL,&error);assert(r&&r->dimensions[0]==3);ln_array_free(r);
    ln_array_free(a);a=scalar("complex128",3,&error);ln_cdouble zz={3,-3};memcpy(a->data,&zz,sizeof zz);stop.array=a;
    r=ln_array_arange(&start,&stop,&step,NULL,&error);assert(r&&r->dimensions[0]==0);ln_array_free(r);
    r=ln_array_arange(&start,&stop,&step,ln_dtype_by_name("float64"),&error);assert(r&&r->dimensions[0]==3);ln_array_free(r);ln_array_free(a);
    _Alignas(int64_t) unsigned char unaligned[9];int64_t three=3;memcpy(unaligned+1,&three,8);
    a=ln_array_from_buffer(unaligned+1,8,ln_dtype_by_name("int64"),1,0,0,NULL,NULL,&error);assert(a);
    ln_array *view=ln_array_view(a,0,NULL,NULL,a->data,&error);assert(view&&!(view->flags&LN_ARRAY_ALIGNED));stop.array=view;
    r=ln_array_arange(&start,&stop,&step,NULL,&error);assert(r&&r->dimensions[0]==3);ln_array_free(r);ln_array_free(view);
    stop.array=a;assert(!ln_array_arange(&start,&stop,&step,NULL,&error));ln_array_free(a);
    a=ln_array_new(0,NULL,ln_dtype_by_name("S2"),0,1,&error);stop.array=a;
    assert(!ln_array_arange(&start,&stop,&step,NULL,&error));ln_array_free(a);
    puts("arange143 native: typed arithmetic, packing distinctions, readonly/unaligned sources and independence passed");return 0;
}
