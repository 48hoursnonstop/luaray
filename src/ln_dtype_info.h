#ifndef LUARAY_DTYPE_INFO_H
#define LUARAY_DTYPE_INFO_H
#include "ln_core.h"
#ifdef __cplusplus
extern "C" {
#endif
char ln_dtype_char(const ln_dtype *dtype);
char ln_dtype_byteorder(const ln_dtype *dtype);
int ln_dtype_equivalent(const ln_dtype *a,const ln_dtype *b);
int ln_dtype_name(const ln_dtype *dtype,char *out,size_t capacity,ln_error *err);
int ln_dtype_typestr(const ln_dtype *dtype,char *out,size_t capacity,ln_error *err);
#ifdef __cplusplus
}
#endif
#endif
