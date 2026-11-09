#ifndef LUARAY_BINARY_MATH_H
#define LUARAY_BINARY_MATH_H
#include "ln_ufunc.h"
const ln_ufunc *ln_binary_math_by_name(const char *name);
size_t ln_binary_math_count(void);
void ln_binary_math_string_add_method(ln_ufunc_loop *method,int unicode_kind);
#endif
