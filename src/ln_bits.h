#ifndef LUARAY_BITS_H
#define LUARAY_BITS_H
#include "ln_core.h"
#ifdef __cplusplus
extern "C" {
#endif
/* Native axes are zero-based; -1 selects logical C flattening. The little
 * flag is 0 for big bit order and 1 for little. All results own uint8 data. */
ln_array *ln_packbits(const ln_array *a,int axis,int little,ln_error *err);
ln_array *ln_unpackbits(const ln_array *a,int axis,const ln_intp *count,
                        int little,ln_error *err);
#ifdef __cplusplus
}
#endif
#endif
