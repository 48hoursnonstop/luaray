#include "ln_core.h"
#include "ln_string.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>
int main(void)
{
 ln_error e={0};uint8_t axis0[LN_MAXDIMS]={1},axis1[LN_MAXDIMS]={0,1};
 for(int unicode=0;unicode<2;unicode++){
  const ln_dtype *dt=ln_string_make_dtype(unicode,0,'=',&e);assert(dt);
  ln_array *a=ln_array_new(2,(ln_intp[]){2,3},dt,0,1,&e);assert(a);
  ln_array *r=ln_reduce_ex(a,axis0,1,NULL,NULL,LN_REDUCE_SUM,0,0,0,1,&e);
  assert(r&&r->nd==2&&r->dimensions[0]==1&&r->dimensions[1]==3);
  assert(r->descr->kind==dt->kind&&r->descr->elsize==(unicode?4u:1u));
  assert(r->strides[0]==0&&r->strides[1]==0);
  assert((r->flags&LN_ARRAY_OWNDATA)&&!(r->flags&(LN_ARRAY_C_CONTIGUOUS|LN_ARRAY_F_CONTIGUOUS)));
  for(size_t i=0;i<r->descr->elsize;i++)assert(r->data[i]==0);
  ln_array_free(r);
  ln_array *where=ln_array_new(0,NULL,ln_dtype_by_name("bool"),0,1,&e);assert(where);
  assert(!ln_reduce_ex(a,axis0,1,NULL,where,LN_REDUCE_SUM,0,0,0,1,&e));
  r=ln_reduce_ex(a,axis0,1,NULL,where,LN_REDUCE_SUM,1,7,7,1,&e);assert(r);ln_array_free(r);
  ln_array *out=ln_array_new(1,(ln_intp[]){3},dt,0,1,&e);assert(out);
  assert(!ln_reduce_into_ex(a,axis0,0,NULL,out,NULL,LN_REDUCE_SUM,0,0,0,1,&e));
  assert(out->descr->elsize==0&&out->strides[0]==0);ln_array_free(out);
  assert(!ln_reduce_ex(a,axis0,0,NULL,NULL,LN_REDUCE_PROD,0,0,0,1,&e));
  out=ln_array_new(1,(ln_intp[]){3},ln_dtype_by_name("int32"),0,1,&e);assert(out);
  int32_t initial[]={9,9,9};memcpy(out->data,initial,sizeof initial);
  assert(ln_reduce_into_ex(a,axis0,0,ln_dtype_by_name("int64"),out,NULL,LN_REDUCE_SUM,1,5,5,1,&e)<0);
  int32_t seeded[]={5,5,5};assert(!memcmp(out->data,seeded,sizeof seeded));ln_array_free(out);
  ln_array_free(a);ln_array_free(where);
  a=ln_array_new(2,(ln_intp[]){3,0},dt,0,1,&e);assert(a);
  assert(!ln_reduce_ex(a,axis1,0,NULL,NULL,LN_REDUCE_SUM,0,0,0,1,&e));
  r=ln_reduce_ex(a,axis1,0,NULL,NULL,LN_REDUCE_SUM,1,0,0,1,&e);assert(r&&ln_array_size(r)==3);ln_array_free(r);
  ln_array_free(a);
  a=ln_array_new(2,(ln_intp[]){0,3},dt,0,1,&e);assert(a);
  r=ln_reduce_ex(a,axis1,0,NULL,NULL,LN_REDUCE_SUM,0,0,0,1,&e);assert(r&&ln_array_size(r)==0);ln_array_free(r);ln_array_free(a);
 }
 puts("zero_string153 native: sum widths, strides, initialization, identity, masks and output passed");return 0;
}
