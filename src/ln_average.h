#ifndef LUARAY_AVERAGE_H
#define LUARAY_AVERAGE_H
#include "ln_core.h"
#ifdef __cplusplus
extern "C" {
#endif
/* Weighted or unweighted average. Axes use internal zero-based flags.
 * Returned sum of weights has exactly the same shape and dtype as average.
 * weights: NULL; full-shape ndarray; or 1D weights for one reduced axis. */
ln_array *ln_average(const ln_array *a, const ln_array *weights,
    const uint8_t *axes, int keepdims, ln_array **sum_of_weights,
    ln_error *err);
#ifdef __cplusplus
}
#endif
#endif
