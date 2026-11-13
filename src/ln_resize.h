#ifndef LUARAY_RESIZE_H
#define LUARAY_RESIZE_H
#include "ln_core.h"
#ifdef __cplusplus
extern "C" {
#endif
/* Shape validation also bounds nonzero-axis products used to form strides. */
int ln_resize_shape(int nd,const ln_intp *shape,size_t itemsize,ln_intp *count,ln_error *err);
ln_array *ln_array_resize_copy(const ln_array *array,int nd,const ln_intp *shape,ln_error *err);
/* Reallocation requires unique, owned native storage. Shared views cannot
 * disable this safety check; same-byte-count shape changes retain storage. */
int ln_array_resize_inplace(ln_array *array,int nd,const ln_intp *shape,ln_error *err);
#ifdef __cplusplus
}
#endif
#endif
