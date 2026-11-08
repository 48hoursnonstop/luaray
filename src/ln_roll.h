#ifndef LUARAY_ROLL_H
#define LUARAY_ROLL_H
#include "ln_core.h"
#ifdef __cplusplus
extern "C" {
#endif
/* Immutable input, always independent output. Each nonnegative offset has
 * already been normalized modulo its corresponding axis length. */
ln_array *ln_roll(const ln_array *a, int flatten, const ln_intp *offsets,
                  ln_error *err);
#ifdef __cplusplus
}
#endif
#endif
