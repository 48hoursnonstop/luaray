#ifndef LUARAY_INTEGER_MATH_H
#define LUARAY_INTEGER_MATH_H
#include "ln_ufunc.h"
#ifdef __cplusplus
extern "C" {
#endif
/* Integer ArrayMethods use the shared iterator for casting, masks and aliasing. */
const ln_ufunc *ln_integer_math_by_name(const char *name);
size_t ln_integer_math_count(void);
#ifdef __cplusplus
}
#endif
#endif
