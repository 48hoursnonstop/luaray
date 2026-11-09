#ifndef LUARAY_SAMPLING_H
#define LUARAY_SAMPLING_H
#include "ln_ufunc.h"
#ifdef __cplusplus
extern "C" {
#endif
/* Native axes are zero based in the result (one added sample dimension).
 * compute_dtype is an inexact dtype resolved at the Lua array-converter
 * boundary. Outputs and optional step are newly owned; inputs are borrowed. */
ln_array *ln_sampling_linspace(const ln_array *start,const ln_array *stop,
    ln_intp count,int endpoint,int axis,const ln_dtype *compute_dtype,
    const ln_dtype *output_dtype,ln_array **step,ln_error *err);
ln_array *ln_sampling_logspace(const ln_array *start,const ln_array *stop,
    const ln_ufunc_operand *base,ln_intp count,int endpoint,int axis,
    const ln_dtype *compute_dtype,const ln_dtype *output_dtype,ln_error *err);
ln_array *ln_sampling_geomspace(const ln_array *start,const ln_array *stop,
    ln_intp count,int endpoint,int axis,const ln_dtype *compute_dtype,
    const ln_dtype *output_dtype,ln_error *err);
#ifdef __cplusplus
}
#endif
#endif
