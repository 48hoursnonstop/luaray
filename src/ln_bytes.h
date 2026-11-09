#ifndef LUARAY_BYTES_H
#define LUARAY_BYTES_H
#include "ln_core.h"
ln_array *ln_bytes_view(const ln_array *a,const ln_dtype *dtype,ln_error *err);
int ln_bytes_size(const ln_array *a,size_t *size,ln_error *err);
/* Owns the returned malloc buffer, including a valid allocation for empty. */
int ln_bytes_export(const ln_array *a,char order,char **bytes,size_t *length,ln_error *err);
#endif
