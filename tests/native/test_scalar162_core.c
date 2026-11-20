#include "ln_core.h"
#include "ln_complex.h"
#include "ln_dtype_transfer.h"
#include <assert.h>
#include <float.h>
#include <stdio.h>
#include <string.h>
int main(void){
 ln_error error={0};const ln_dtype *complex=ln_dtype_by_name("clongdouble");
 ln_array *a=ln_array_new(0,NULL,complex,0,0,&error);assert(a);
 int64_t values[]={INT64_MAX,INT64_MIN,INT64_C(9007199254740993),-INT64_C(9007199254740993),1,0};
 for(size_t i=0;i<sizeof values/sizeof *values;i++){
  int64_t value=values[i];ln_clongdouble z;
  assert(!ln_array_pack_number(a,NULL,0,value,1,&error));memcpy(&z,a->data,sizeof z);
  assert(z.real==(long double)(double)value&&z.imag==0);
  /* Raw native array writes/casts have their own precision contract. */
  assert(!ln_array_set_number(a,NULL,0,value,1,&error));memcpy(&z,a->data,sizeof z);
  assert(z.real==(long double)value&&z.imag==0);
  assert(!ln_cast_strided_numeric((const char*)&value,0,ln_dtype_by_name("int64"),a->data,0,complex,1,&error));
  memcpy(&z,a->data,sizeof z);assert(z.real==(long double)value&&z.imag==0);
 }
 ln_array_free(a);
 a=ln_array_new(1,(ln_intp[]){3},complex,0,0,&error);assert(a);
 assert(!ln_array_assign_scalar(a,0,INT64_MAX,1,&error));
 for(int i=0;i<3;i++){ln_clongdouble z;memcpy(&z,a->data+i*sizeof z,sizeof z);assert(z.real==(long double)(double)INT64_MAX);}
 ln_array_free(a);
 puts("scalar162 native: strict complex packing, raw casting and repeated assignments passed");return 0;
}
