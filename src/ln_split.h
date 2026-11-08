#ifndef LUARAY_SPLIT_H
#define LUARAY_SPLIT_H
#include "ln_core.h"
#ifdef __cplusplus
extern "C" {
#endif
/* NumPy's slicing semantics on an existing axis.  Coordinates are zero-based,
 * with negative and out-of-range boundaries normalized like slice(start, stop).
 * Returns a shared-buffer view, never a copy. */
ln_array *ln_split_view(const ln_array *base, int axis,
                        ln_intp start, ln_intp stop, ln_error *err);
#ifdef __cplusplus
}
#endif
#endif
