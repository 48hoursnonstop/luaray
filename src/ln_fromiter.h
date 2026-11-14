#ifndef LUARAY_FROMITER_H
#define LUARAY_FROMITER_H
#include "ln_core.h"
#ifdef __cplusplus
extern "C" {
#endif
/* Builder storage is owned by the caller. Callbacks are implemented at the
 * Lua boundary, never retained here. Reserve before packing each element. */
ln_array *ln_fromiter_new(const ln_dtype *dtype,ln_intp count,ln_error *err);
int ln_fromiter_reserve(ln_array *array,ln_intp index,ln_error *err);
int ln_fromiter_finish(ln_array *array,ln_intp written,ln_error *err);
#ifdef __cplusplus
}
#endif
#endif
