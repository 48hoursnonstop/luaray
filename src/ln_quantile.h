#ifndef LUARAY_QUANTILE_H
#define LUARAY_QUANTILE_H
#include "ln_core.h"
#ifdef __cplusplus
extern "C" {
#endif
/* Numeric quantile and median, with zero-based internal reduction axes.
 * q is a scalar/vector, nq >= 1. Scalar q omits the leading q dimension.
 * method: linear=0, lower=1, higher=2, nearest=3, midpoint=4,
 * inverted_cdf=5. omit_nan filters NaNs per reduced slice; 0 retains legacy
 * propagation behavior. Result owns its storage; out is optional. */
ln_array *ln_quantile(const ln_array *a, const uint8_t *axis_flags,
    int keepdims, const double *q, ln_intp nq, int scalar_q,
    int method, const ln_dtype *preferred_dtype, ln_array *out, int omit_nan, ln_error *err);
#ifdef __cplusplus
}
#endif
#endif
