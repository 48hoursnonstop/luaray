#ifndef LUARAY_MATRIX_H
#define LUARAY_MATRIX_H
#include "ln_core.h"
/* Native axes are zero-based. Inputs are borrowed; results own their headers. */
ln_array *ln_matrix_diagonal(const ln_array *a,ln_intp offset,int axis1,int axis2,ln_error *err);
ln_array *ln_matrix_diag(const ln_array *a,ln_intp offset,int flatten,ln_error *err);
#endif
