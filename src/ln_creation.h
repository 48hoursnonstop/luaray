#ifndef LUARAY_CREATION_H
#define LUARAY_CREATION_H
#include "ln_core.h"
#ifdef __cplusplus
extern "C" {
#endif
/* order is C/F/A/K. nd=-1 inherits shape; otherwise dims supplies new shape.
 * Unsized fixed strings adopt the constructor's minimum one-character width. */
ln_array *ln_creation_new_like(const ln_array *prototype,const ln_dtype *dtype,
    char order,int nd,const ln_intp *dims,ln_error *err);
/* copy: -1 if needed,0 never,1 always. Negative ndmin means no minimum.
 * Always returns an owned array header. identity=1 means its metadata and
 * data match the input exactly, so Lua may return the original userdata. */
ln_array *ln_creation_convert(const ln_array *input,const ln_dtype *dtype,
    char order,int copy,int ndmin,int *identity,ln_error *err);
int ln_creation_checkfinite(const ln_array *input,ln_error *err);
#ifdef __cplusplus
}
#endif
#endif
