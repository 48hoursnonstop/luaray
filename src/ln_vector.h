#ifndef LUARAY_VECTOR_H
#define LUARAY_VECTOR_H
#include "ln_core.h"
ln_array *ln_vector_cross(const ln_array *a,int axis_a,const ln_array *b,
        int axis_b,int axis_out,ln_error *err);
/* Caller provides NULL output slots; they are owned on success and released
 * on calculation failure. Inputs are borrowed. */
int ln_vector_meshgrid(int count,const ln_array *const *inputs,int copy,
        int sparse,int xy,ln_array **outputs,ln_error *err);
#endif
