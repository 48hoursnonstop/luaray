#ifndef LUARAY_LAYOUT_H
#define LUARAY_LAYOUT_H
#include "ln_core.h"
/* C/F/A reshape: copy -1 if needed, 0 never, 1 always. */
ln_array *ln_layout_reshape(const ln_array *a,int nd,const ln_intp *shape,
                            char order,int copy,ln_error *err);
ln_array *ln_layout_ravel(const ln_array *a,char order,ln_error *err);
ln_array *ln_layout_flatten(const ln_array *a,char order,ln_error *err);
#endif
