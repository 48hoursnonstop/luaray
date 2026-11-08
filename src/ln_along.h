#ifndef LUARAY_ALONG_H
#define LUARAY_ALONG_H
#include "ln_core.h"
#ifdef __cplusplus
extern "C" {
#endif
/* axis=-1 is the explicit flat-iterator path; otherwise zero-based.
 * Index values retain Lua's positive-one-based/negative-from-end convention. */
ln_array *ln_array_take_along_axis(const ln_array *input,const ln_array *indices,
                                  int axis,ln_error *err);
int ln_array_put_along_axis(ln_array *input,const ln_array *indices,
                           const ln_array *values,int axis,ln_error *err);
#ifdef __cplusplus
}
#endif
#endif
