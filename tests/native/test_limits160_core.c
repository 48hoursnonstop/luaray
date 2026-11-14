#include "ln_limits.h"
#include <assert.h>
#include <float.h>
#include <math.h>
#include <stdio.h>
int main(void){
 ln_error error={0};ln_float_info f;ln_integer_info i;
 const char *names[]={"float16","float32","float64","longdouble","complex64","complex128","clongdouble"};
 for(int n=0;n<7;++n){
  assert(!ln_finfo(ln_dtype_by_name(names[n]),&f,&error));assert(f.dtype->kind=='f');
  assert(f.epsneg*2==f.eps&&f.minimum==-f.maximum);
  assert(f.smallest_subnormal>0&&f.smallest_subnormal<f.smallest_normal);
  assert(f.nmant>0&&f.minexp<0&&f.maxexp>0&&f.bits==(int)f.dtype->elsize*8);
 }
 assert(!ln_finfo(ln_dtype_by_name("longdouble"),&f,&error));
 assert(f.eps==LDBL_EPSILON&&f.maximum==LDBL_MAX&&f.smallest_normal==LDBL_MIN);
 for(int type=LN_BYTE;type<=LN_ULONGLONG;++type){
  const ln_dtype *dtype=ln_dtype_by_num(type);assert(!ln_iinfo(dtype,&i,&error));
  assert(i.dtype==dtype&&i.bits==(int)dtype->elsize*8);
  if(dtype->kind=='u'){assert(i.minimum==0);if(i.bits==64)assert(i.maximum==UINT64_MAX);}
  else assert(i.minimum==-(int64_t)i.maximum-1);
 }
 assert(!ln_iinfo(ln_dtype_by_name("int64"),&i,&error));assert(i.minimum==INT64_MIN&&i.maximum==INT64_MAX);
 assert(ln_iinfo(ln_dtype_by_name("bool"),&i,&error)<0);
 assert(ln_finfo(ln_dtype_by_name("int64"),&f,&error)<0);
 assert(ln_iinfo(NULL,&i,&error)<0&&ln_finfo(NULL,&f,&error)<0);
 assert(ln_finfo(ln_dtype_by_name("float64"),NULL,&error)<0);
 assert(ln_iinfo(ln_dtype_by_name("int64"),NULL,&error)<0);
 puts("limits160 native: host float limits, complex mapping, integer endpoints and invalid types passed");return 0;
}
