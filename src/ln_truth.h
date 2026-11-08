#ifndef LUARAY_TRUTH_H
#define LUARAY_TRUTH_H
#include "ln_core.h"
#ifdef __cplusplus
extern "C" {
#endif
/* Native logical reductions: kind=0 any, 1 all, 2 count_nonzero.
 * Axis flags are zero-based internally; where is broadcast over the input.
 * Always compute into a fresh array before copying to out (alias-safe). */
ln_array *ln_truth_reduce(const ln_array *input, const uint8_t *axis_flags,
    int keepdims, const ln_array *where, int kind, ln_array *out, ln_error *err);
#ifdef __cplusplus
}
#endif
#endif
