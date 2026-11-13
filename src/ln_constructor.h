#ifndef LUARAY_CONSTRUCTOR_H
#define LUARAY_CONSTRUCTOR_H
#include "ln_core.h"
#ifdef __cplusplus
extern "C" {
#endif
/* buffer is an optional retained contiguous storage window. Offset/strides
 * count bytes. A NULL buffer allocates owned storage and ignores offset. */
ln_array *ln_array_construct(int nd,const ln_intp *shape,const ln_dtype *dtype,
    const ln_array *buffer,ln_intp offset,const ln_intp *strides,int fortran,ln_error *err);
#ifdef __cplusplus
}
#endif
#endif
