#ifndef LUARAY_HALF_H
#define LUARAY_HALF_H
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef uint16_t ln_half;

float ln_half_to_float(ln_half h);
double ln_half_to_double(ln_half h);
ln_half ln_float_to_half(float f);
ln_half ln_double_to_half(double d);
int ln_half_iszero(ln_half h);
int ln_half_isnan(ln_half h);
int ln_half_isinf(ln_half h);
int ln_half_isfinite(ln_half h);
int ln_half_signbit(ln_half h);
int ln_half_eq(ln_half a, ln_half b);
int ln_half_ne(ln_half a, ln_half b);
int ln_half_lt(ln_half a, ln_half b);
int ln_half_le(ln_half a, ln_half b);
int ln_half_gt(ln_half a, ln_half b);
int ln_half_ge(ln_half a, ln_half b);
ln_half ln_half_copysign(ln_half x, ln_half y);

#define LN_HALF_ZERO 0x0000u
#define LN_HALF_NZERO 0x8000u
#define LN_HALF_ONE 0x3c00u
#define LN_HALF_NEGONE 0xbc00u
#define LN_HALF_PINF 0x7c00u
#define LN_HALF_NINF 0xfc00u
#define LN_HALF_NAN 0x7e00u

#ifdef __cplusplus
}
#endif
#endif
