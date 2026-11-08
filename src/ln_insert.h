#ifndef LUARAY_INSERT_H
#define LUARAY_INSERT_H
#include "ln_core.h"
#ifdef __cplusplus
extern "C" {
#endif
/* positions: zero-based insertion boundaries in [0, axis length].
 * scalar_index distinguishes a scalar obj from a length-one index array.
 * axis=-1: flatten input in C order. Output always owns its storage.
 */
ln_array *ln_insert(const ln_array *a, int axis, const ln_intp *positions,
                    ln_intp npositions, int scalar_index, const ln_array *values,
                    ln_error *err);
#ifdef __cplusplus
}
#endif
#endif
