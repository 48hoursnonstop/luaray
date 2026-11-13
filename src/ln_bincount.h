#ifndef LUARAY_BINCOUNT_H
#define LUARAY_BINCOUNT_H
#include "ln_core.h"
#ifdef __cplusplus
extern "C" {
#endif
/* Labels are nonnegative numeric category values, retaining zero origin.
 * Preflight permits bindings to defer weight conversion until labels validate. */
int ln_bincount_shape(const ln_array *labels,ln_intp minlength,
                      ln_intp *output_length,ln_error *err);
ln_array *ln_bincount(const ln_array *labels,const ln_array *weights,
                     ln_intp minlength,ln_error *err);
#ifdef __cplusplus
}
#endif
#endif
