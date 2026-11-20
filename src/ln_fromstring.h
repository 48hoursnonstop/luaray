#ifndef LUARAY_FROMSTRING_H
#define LUARAY_FROMSTRING_H
#include "ln_core.h"
#ifdef __cplusplus
extern "C" {
#endif
/* Parse length-delimited text into owned one-dimensional native storage. */
ln_array *ln_array_fromstring(const char *text,size_t length,const ln_dtype *dtype,
                              ln_intp count,const char *separator,size_t sep_length,
                              ln_error *err);
#ifdef __cplusplus
}
#endif
#endif
