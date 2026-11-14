#include "ln_fromiter.h"
#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
int main(void){
 ln_error error={0};const ln_dtype *dtype=ln_dtype_by_name("int64");
 ln_array *a=ln_fromiter_new(dtype,-1,&error);assert(a&&a->dimensions[0]==0);
 ln_intp capacities[]={4,8,14,23,36,56,86};int boundary=0;
 for(ln_intp i=0;i<1000;++i){
  ln_intp old=a->dimensions[0];assert(!ln_fromiter_reserve(a,i,&error));
  if(old==i&&boundary<7)assert(a->dimensions[0]==capacities[boundary++]);
  int64_t value=(int64_t)i*11;memcpy(a->data+i*8,&value,8);
 }
 assert(!ln_fromiter_finish(a,1000,&error));assert(a->dimensions[0]==1000&&a->strides[0]==8);
 for(int i=0;i<1000;++i){int64_t value;memcpy(&value,a->data+i*8,8);assert(value==(int64_t)i*11);}
 assert(ln_fromiter_reserve(a,-1,&error)<0);assert(ln_fromiter_reserve(a,1001,&error)<0);
 assert(ln_fromiter_finish(a,1001,&error)<0);assert(ln_fromiter_finish(a,-1,&error)<0);
 ln_array_free(a);
 a=ln_fromiter_new(dtype,4,&error);assert(a);assert(!ln_fromiter_finish(a,0,&error));assert(a->dimensions[0]==0);ln_array_free(a);
 assert(!ln_fromiter_new(ln_dtype_by_name("S0"),0,&error));assert(!ln_fromiter_new(NULL,0,&error));
 assert(!ln_fromiter_new(ln_dtype_by_name("complex128"),INTPTR_MAX,&error));
 a=ln_fromiter_new(dtype,0,&error);assert(a);
 /* Synthetic metadata reaches overflow guards without requesting huge memory. */
 a->dimensions[0]=INTPTR_MAX;
 assert(ln_fromiter_reserve(a,INTPTR_MAX,&error)<0);a->dimensions[0]=0;ln_array_free(a);
 puts("fromiter159 native: growth, initialized prefixes, shrink, ownership and overflow passed");return 0;
}
