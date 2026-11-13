#ifndef LUARAY_BYTES_H
#define LUARAY_BYTES_H
#include "ln_core.h"
#ifdef __cplusplus
extern "C" {
#endif
ln_array *ln_bytes_view(const ln_array *a,const ln_dtype *dtype,ln_error *err);
int ln_bytes_size(const ln_array *a,size_t *size,ln_error *err);
/* Owns the returned malloc buffer, including a valid allocation for empty. */
int ln_bytes_export(const ln_array *a,char order,char **bytes,size_t *length,ln_error *err);
/* Swaps payload bytes without changing the dtype descriptor. */
int ln_bytes_swap_inplace(ln_array *a,ln_error *err);
ln_array *ln_bytes_swap_copy(const ln_array *a,ln_error *err);
/* Per-item subfields: shape/strides retained; offset is measured in bytes. */
ln_array *ln_bytes_field(const ln_array *a,const ln_dtype *dtype,ln_intp offset,ln_error *err);
int ln_bytes_setfield(ln_array *a,const ln_array *value,const ln_dtype *dtype,ln_intp offset,ln_error *err);
#ifdef __cplusplus
}
#endif
#endif
