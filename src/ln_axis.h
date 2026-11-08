#ifndef LUARAY_AXIS_H
#define LUARAY_AXIS_H
#include "ln_core.h"
#ifdef __cplusplus
extern "C" {
#endif
/* All native axes are zero based, validated at the host-language boundary.
 * Every successful operation returns a view sharing the original owner. */
ln_array *ln_axis_permute(const ln_array *a, const int *order, ln_error *err);
ln_array *ln_axis_reverse(const ln_array *a, const unsigned char *axes, ln_error *err);
ln_array *ln_axis_expand(const ln_array *a, const unsigned char *positions,
                         int result_nd, ln_error *err);
ln_array *ln_axis_squeeze(const ln_array *a, const unsigned char *axes, ln_error *err);
ln_array *ln_axis_broadcast_to(const ln_array *a, int nd,
                                const ln_intp *shape, int readonly, ln_error *err);
/* NumPy atleast_{1,2,3}d: a view with newaxis-style zero strides. */
ln_array *ln_axis_atleast(const ln_array *a, int minimum_nd, ln_error *err);
ln_array *ln_axis_rot90(const ln_array *a, int k, int first, int second,
                        ln_error *err);
#ifdef __cplusplus
}
#endif
#endif
