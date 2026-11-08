#ifndef LUARAY_MAPPING_H
#define LUARAY_MAPPING_H

#include "ln_core.h"

#ifdef __cplusplus
extern "C" {
#endif

/*
 * Lua-native numerical port of NumPy multiarray/mapping.c and the MapIter
 * get/set loops from multiarray/lowlevel_strided_loops.c.src.
 *
 * Index arrays contain Lua indices: positive values are 1-based, negative
 * values count from the end, and zero is invalid. Boolean-derived nonzero
 * arrays are generated in this same convention.
 */

int ln_array_assign_array(ln_array *dst, const ln_array *src, ln_error *err);

ln_array *ln_array_boolean_get(const ln_array *src, const ln_array *mask,
                               ln_error *err);
int ln_array_boolean_assign_array(ln_array *dst, const ln_array *mask,
                                  const ln_array *values, ln_error *err);
int ln_array_boolean_assign_scalar(ln_array *dst, const ln_array *mask,
                                   double v, int64_t vi, int is_integer,
                                   ln_error *err);

/* Convert a non-scalar boolean array to one 1-D integer index array per axis,
 * equivalent to mapping.c:_nonzero_indices. Returned arrays are owned by the
 * caller and contain Lua-native 1-based positive coordinates. */
int ln_boolean_nonzero_indices(const ln_array *mask, ln_array **out_indices,
                               int *out_count, ln_error *err);

ln_array *ln_array_advanced_get(const ln_array *src, const ln_index *indices,
                                int index_num, ln_error *err);
int ln_array_advanced_assign_array(ln_array *dst, const ln_index *indices,
                                   int index_num, const ln_array *values,
                                   ln_error *err);
int ln_array_advanced_assign_scalar(ln_array *dst, const ln_index *indices,
                                    int index_num, double v, int64_t vi,
                                    int is_integer, ln_error *err);

/* C-order copy, used for scalar-array indexing semantics and overlap safety. */
ln_array *ln_array_copy_c(const ln_array *src, ln_error *err);

#ifdef __cplusplus
}
#endif
#endif
