#ifndef LUARAY_CHOOSE_H
#define LUARAY_CHOOSE_H
#include "ln_take.h"
#ifdef __cplusplus
extern "C" {
#endif
/* Prepared choices share one dtype and are C-contiguous; indices are signed
 * native pointer-width integers. Positive Lua choice positions start at one;
 * negative positions are invalid in raise mode, matching NumPy choose. */
ln_array *ln_array_choose(const ln_array *indices,const ln_array *const *choices,
                          int count,ln_take_mode mode,ln_array *out,ln_error *err);
#ifdef __cplusplus
}
#endif
#endif
