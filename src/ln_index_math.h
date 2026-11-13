#ifndef LUARAY_INDEX_MATH_H
#define LUARAY_INDEX_MATH_H
#include "ln_core.h"
#ifdef __cplusplus
extern "C" {
#endif
typedef enum ln_index_mode { LN_INDEX_CLIP=0,LN_INDEX_WRAP=1,LN_INDEX_RAISE=2 } ln_index_mode;
/* Inputs/outputs use Lua locations: positive values are one-based, negative
 * inputs retain their sign, and zero is invalid when traversed. */
ln_array *ln_ravel_multi_index(int nd,const ln_intp *dimensions,
    const ln_array *const *coordinates,const ln_index_mode *modes,
    char order,ln_error *err);
/* Owned interleaved coordinate storage, indices.shape + {nd}; its last axis
 * contains one-based coordinates. Lua exposes views, or scalar coordinates. */
ln_array *ln_unravel_index_storage(const ln_array *indices,int nd,
    const ln_intp *dimensions,char order,ln_error *err);
#ifdef __cplusplus
}
#endif
#endif
