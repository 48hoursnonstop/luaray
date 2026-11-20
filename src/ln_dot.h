#ifndef LUARAY_DOT_H
#define LUARAY_DOT_H

#include "ln_core.h"

#ifdef __cplusplus
extern "C" {
#endif

/* Source-derived native subset of PyArray_MatrixProduct2/PyArray_InnerProduct
 * and numpy._core.numeric.outer for the currently supported numeric dtypes. */
ln_array *ln_dot(const ln_array *a, const ln_array *b, ln_error *err);
int ln_dot_into(const ln_array *a, const ln_array *b, ln_array *out,
                ln_error *err);
ln_array *ln_inner(const ln_array *a, const ln_array *b, ln_error *err);
typedef enum ln_correlation_mode {
    LN_CORRELATE_VALID, LN_CORRELATE_SAME, LN_CORRELATE_FULL
} ln_correlation_mode;
ln_array *ln_correlate(const ln_array *a,const ln_array *b,
                       ln_correlation_mode mode,int convolution,ln_error *err);
ln_array *ln_outer(const ln_array *a, const ln_array *b, ln_error *err);
int ln_outer_into(const ln_array *a, const ln_array *b, ln_array *out,
                  ln_error *err);

#ifdef __cplusplus
}
#endif
#endif
