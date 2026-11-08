#ifndef LUARAY_CONDITION_H
#define LUARAY_CONDITION_H
#include "ln_core.h"
#ifdef __cplusplus
extern "C" {
#endif
/* Nonzero returns one coordinate array per axis (or one C-flat array).
 * Coordinates are positive Lua one-based; caller owns every returned array.
 * Regular nonzero rejects 0-D input; flat nonzero accepts it. */
int ln_array_condition_nonzero(const ln_array *input,int flatten,
                                ln_array **outputs,int *nout,ln_error *err);
/* rank_one requires the compress condition rank; otherwise condition is flattened
 * as extract does. axis=-1 flattens the source; other axes are zero-based. */
ln_array *ln_array_compress_condition(const ln_array *input,const ln_array *condition,
                                     int rank_one,int axis,ln_array *out,ln_error *err);
#ifdef __cplusplus
}
#endif
#endif
