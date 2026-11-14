#ifndef LUARAY_TYPE_CHECK_H
#define LUARAY_TYPE_CHECK_H
#include "ln_core.h"
#ifdef __cplusplus
extern "C" {
#endif
/* Classification compares scalar classes, not storage-width equivalence. */
int ln_isdtype_class(const ln_dtype *dtype,const ln_dtype *kind,ln_error *err);
int ln_isdtype_kind(const ln_dtype *dtype,const char *kind,size_t length,ln_error *err);
const ln_dtype *ln_common_inexact_type(const ln_dtype *const *dtypes,size_t count,ln_error *err);
#ifdef __cplusplus
}
#endif
#endif
