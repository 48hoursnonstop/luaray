#ifndef LUARAY_DELETE_H
#define LUARAY_DELETE_H
#include "ln_core.h"
#ifdef __cplusplus
extern "C" {
#endif
/* Delete selected positions along a zero-based axis, or -1 for flattened
 * C-order input. `remove` contains exactly one byte per source axis entry.
 * Output is an independent owned C-contiguous array, including empty output. */
ln_array *ln_delete(const ln_array *input, int axis,
                    const unsigned char *remove, ln_intp count, ln_error *err);
#ifdef __cplusplus
}
#endif
#endif
