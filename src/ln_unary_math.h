#ifndef LUARAY_UNARY_MATH_H
#define LUARAY_UNARY_MATH_H
#include "ln_ufunc.h"
/* Independent numeric registry. All iteration, casting, masks and overlapping
 * writeback continue through the shared ArrayMethod/NpyIter executor. */
const ln_ufunc *ln_unary_math_by_name(const char *name);
size_t ln_unary_math_count(void);
#endif
