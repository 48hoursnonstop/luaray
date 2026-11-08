#ifndef LUARAY_TAKE_H
#define LUARAY_TAKE_H
#include "ln_core.h"
#ifdef __cplusplus
extern "C" {
#endif
typedef enum { LN_TAKE_RAISE, LN_TAKE_WRAP, LN_TAKE_CLIP } ln_take_mode;
/* axis=-1 flattens; otherwise use an internal zero-based axis. Prepared indices
 * are native signed pointer-width C-contiguous integers in Lua coordinates.
 * Return a new owned result, or the borrowed out pointer on success. */
ln_array *ln_array_take(const ln_array *input,const ln_array *indices,int axis,
                         ln_take_mode mode,ln_array *out,ln_error *err);
#ifdef __cplusplus
}
#endif
#endif
