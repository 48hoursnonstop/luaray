#ifndef LUARAY_ORDER_H
#define LUARAY_ORDER_H
#include "ln_core.h"
#ifdef __cplusplus
extern "C" {
#endif
/* Inner-to-outer stable NpyIter KEEPORDER axes. Stride rows are already
 * broadcast to nd dimensions; zero strides remain ambiguous. */
int ln_keeporder_axes(int nd,int nop,const ln_intp *const *strides,
                      int *order,ln_error *err);
#ifdef __cplusplus
}
#endif
#endif
