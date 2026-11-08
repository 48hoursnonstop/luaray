#ifndef LUARAY_REPEAT_H
#define LUARAY_REPEAT_H
#include "ln_core.h"
#ifdef __cplusplus
extern "C" {
#endif
/* Host-neutral NumPy tile/repeat kernels.  The return value always owns new
 * independent C-contiguous storage.  Axis is zero based; -1 means flattened
 * C order.  A 0-D input with an explicit axis is treated as a length-one 1-D
 * array, as in NumPy's repeat. */
ln_array *ln_tile(const ln_array *a, int reps_nd, const ln_intp *reps,
                  ln_error *err);
ln_array *ln_repeat(const ln_array *a, int axis, size_t nreps,
                    const ln_intp *reps, ln_error *err);
#ifdef __cplusplus
}
#endif
#endif
