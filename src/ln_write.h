#ifndef LUARAY_WRITE_H
#define LUARAY_WRITE_H
#include "ln_core.h"
#include "ln_dtype_transfer.h"
#ifdef __cplusplus
extern "C" {
#endif

typedef enum { LN_PUT_RAISE, LN_PUT_WRAP, LN_PUT_CLIP } ln_put_mode;

/* Prepared operands are C-contiguous: signed pointer-width indices, boolean
 * masks, and values with exactly dst's descriptor. Positive indices are Lua
 * one-based, negative indices count from the end; zero is invalid in all modes.
 * Flattening, repetition, aliasing and writeback follow NumPy's native loops. */
int ln_array_put(ln_array *dst, const ln_array *indices, const ln_array *values,
                 ln_put_mode mode, ln_error *err);
int ln_array_place(ln_array *dst, const ln_array *mask, const ln_array *values,
                   ln_error *err);
int ln_array_putmask(ln_array *dst, const ln_array *mask, const ln_array *values,
                     ln_error *err);
/* Copy assignment preserves raw destination-stride iteration and live masks.
 * Scalars must already be materialized with the host's weak-scalar rules. */
int ln_array_copyto(ln_array *dst,const ln_array *src,const ln_array *where,
                    int scalar_where,ln_casting casting,ln_error *err);

#ifdef __cplusplus
}
#endif
#endif
