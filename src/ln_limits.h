#ifndef LUARAY_LIMITS_H
#define LUARAY_LIMITS_H
#include "ln_core.h"
#ifdef __cplusplus
extern "C" {
#endif
typedef struct ln_float_info {
 const ln_dtype *dtype;
 int bits,nmant,minexp,maxexp,precision,machep,negep,nexp,iexp;
 long double eps,epsneg,minimum,maximum,resolution,smallest_normal,smallest_subnormal;
} ln_float_info;
typedef struct ln_integer_info {
 const ln_dtype *dtype;
 int bits;
 char kind;
 int64_t minimum;
 uint64_t maximum;
} ln_integer_info;
int ln_finfo(const ln_dtype *dtype,ln_float_info *info,ln_error *err);
int ln_iinfo(const ln_dtype *dtype,ln_integer_info *info,ln_error *err);
#ifdef __cplusplus
}
#endif
#endif
