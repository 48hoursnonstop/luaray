#ifndef LUARAY_MATMUL_H
#define LUARAY_MATMUL_H

#include "ln_core.h"

#ifdef __cplusplus
extern "C" {
#endif

/* Native real-numeric subset of NumPy's matmul gufunc
 *     (m?,n),(n,p?)->(m?,p?)
 * Positive/negative strides and broadcast batch dimensions are supported. */
typedef enum ln_matmul_kind {
    LN_MATMUL, LN_MATVEC, LN_VECMAT, LN_VECDOT
} ln_matmul_kind;

ln_array *ln_matmul_ex(const ln_array *a, const ln_array *b,
                       ln_matmul_kind kind, ln_error *err);
int ln_matmul_into_ex(const ln_array *a, const ln_array *b, ln_array *out,
                      ln_matmul_kind kind, ln_error *err);
ln_array *ln_vdot(const ln_array *a, const ln_array *b, ln_error *err);
ln_array *ln_matmul(const ln_array *a, const ln_array *b, ln_error *err);
int ln_matmul_into(const ln_array *a, const ln_array *b, ln_array *out,
                   ln_error *err);

#ifdef __cplusplus
}
#endif
#endif
