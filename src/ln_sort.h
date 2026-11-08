#ifndef LUARAY_SORT_H
#define LUARAY_SORT_H

#include "ln_core.h"

#ifdef __cplusplus
extern "C" {
#endif

/* Source-derived numeric sorting/selection subset of NumPy npysort. */
int ln_sort_inplace(ln_array *a, int axis, int descending, ln_error *err);
ln_array *ln_sort_copy(const ln_array *a, int axis, int descending, ln_error *err);
ln_array *ln_argsort(const ln_array *a, int axis, int descending, ln_error *err);

int ln_partition_inplace(ln_array *a, const ln_intp *kth, ln_intp nkth,
                         int axis, int descending, ln_error *err);
ln_array *ln_partition_copy(const ln_array *a, const ln_intp *kth, ln_intp nkth,
                            int axis, int descending, ln_error *err);
ln_array *ln_argpartition(const ln_array *a, const ln_intp *kth, ln_intp nkth,
                          int axis, int descending, ln_error *err);

/* Numeric searchsorted subset of PyArray_SearchSorted/binsearch.cpp.
 * `sorter` is optional and contains zero-based indices internally.  Returned
 * insertion positions are Lua-facing 1-based positions in [1, a.size + 1]. */
ln_array *ln_searchsorted(const ln_array *a, const ln_array *keys, int side_right,
                          const ln_intp *sorter, ln_intp sorter_len,
                          ln_error *err);

#ifdef __cplusplus
}
#endif
#endif
