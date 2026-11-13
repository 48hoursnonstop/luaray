#ifndef LUARAY_ARANGE_H
#define LUARAY_ARANGE_H
#include "ln_ufunc.h"
#ifdef __cplusplus
extern "C" {
#endif
/* Native scalar range. Accepts weak Boolean/integer/real/complex operands.
 * A NULL dtype infers at least int64. Array/temporal protocols are separate. */
ln_array *ln_array_arange(const ln_ufunc_operand *start,
    const ln_ufunc_operand *stop,const ln_ufunc_operand *step,
    const ln_dtype *dtype,ln_error *err);
/* Historical LuaRay spelling: integer stop followed by a positional dtype.
 * Keeps the old per-index numeric conversion, including Boolean/temporal. */
ln_array *ln_array_arange_legacy(ln_intp stop,const ln_dtype *dtype,ln_error *err);
#ifdef __cplusplus
}
#endif
#endif
