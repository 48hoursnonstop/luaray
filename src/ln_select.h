#ifndef LUARAY_SELECT_H
#define LUARAY_SELECT_H
#include "ln_core.h"
#ifdef __cplusplus
extern "C" {
#endif
/* Dtype and weak-scalar preparation are resolved at the Lua boundary.
 * Both operations always return a new owned ndarray, including 0-D results. */
ln_array *ln_array_where(const ln_array *condition,const ln_array *x,
                         const ln_array *y,const ln_dtype *dtype,ln_error *err);
ln_array *ln_array_select(const ln_array *const *conditions,
                          const ln_array *const *choices,int count,
                          const ln_array *default_value,const ln_dtype *dtype,
                          ln_error *err);
#ifdef __cplusplus
}
#endif
#endif
