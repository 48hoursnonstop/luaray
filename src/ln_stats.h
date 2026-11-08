#ifndef LUARAY_STATS_H
#define LUARAY_STATS_H
#include "ln_core.h"
#ifdef __cplusplus
extern "C" {
#endif
/* Materialize a boolean mask combining a broadcastable user where= mask
 * with is-not-NaN for every input element. Caller owns the returned array.
 * Used by nan* statistics without replacing input values or losing dtype. */
/* Return an independent C-contiguous copy, replacing NaNs with the
 * neutral element (0 for sum, 1 for product) without rounding integers. */
ln_array *ln_stats_nan_replace(const ln_array *a, int product, ln_error *err);
ln_array *ln_stats_nan_where(const ln_array *a, const ln_array *where,
                             ln_error *err);
/* Two-pass native variance/standard deviation. Axis flags use zero-based
 * internal dimension positions; ddof is allowed to be non-integral. */
ln_array *ln_stats_var_std(const ln_array *a, const uint8_t *axis_flags,
    int keepdims, const ln_dtype *dtype, const ln_array *where,
    double ddof, int standard_deviation, int nan_mode, ln_array *out, ln_error *err);
/* DType-preserving extremum reduction (maximum/minimum), with optional
 * initial scalar, boolean where mask, multiple axes and strided output. */
ln_array *ln_stats_extrema(const ln_array *a, const uint8_t *axis_flags,
    int keepdims, const ln_array *where, int has_initial,
    double initial_v, int64_t initial_i, int initial_is_integer,
    int maximum, ln_array *out, ln_error *err);


/* NaN-omitting extrema: same strides, dtype and out semantics; all-NaN
 * floating slices preserve an encountered NaN, empty slices still error. */
ln_array *ln_stats_nan_extrema(const ln_array *a, const uint8_t *axis_flags,
    int keepdims, const ln_array *where, int has_initial,
    double initial_v, int64_t initial_i, int initial_is_integer,
    int maximum, ln_array *out, ln_error *err);
ln_array *ln_stats_nan_argextrema(const ln_array *a, int axis, int keepdims,
    int maximum, ln_array *out, ln_error *err);
/* Arg extrema: returns one-based positions, following LuaRay's public
 * indexing model. axis=-1 flattens in logical C order; other axes are
 * zero-based C core axes. Output uses native index-width signed integers. */
ln_array *ln_stats_argextrema(const ln_array *a, int axis, int keepdims,
    int maximum, ln_array *out, ln_error *err);
/* Peak-to-peak reduction retaining the source dtype. */
ln_array *ln_stats_ptp(const ln_array *a, const uint8_t *axis_flags,
    int keepdims, ln_array *out, ln_error *err);
#ifdef __cplusplus
}
#endif
#endif

