#ifndef LUARAY_JOIN_H
#define LUARAY_JOIN_H

#include "ln_core.h"
#include "ln_dtype_transfer.h"

#ifdef __cplusplus
extern "C" {
#endif

/* Native equivalent of NumPy's concatenate and shape_base.stack kernels.
 * Axis is zero-based internally, or -1 for flattened concatenate.
 * Stack inserts an axis; concatenate combines an existing axis.
 * The optional out belongs to the caller; a returned newly allocated
 * ndarray belongs to the caller otherwise. */
ln_array *ln_join_arrays(const ln_array *const *arrays, size_t count,
                         int axis, int stack, const ln_dtype_descr *dtype,
                         ln_casting casting, ln_array *out, ln_error *err);

#ifdef __cplusplus
}
#endif
#endif
