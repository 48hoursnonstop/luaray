#ifndef LUARAY_UFUNC_LOOPS_H
#define LUARAY_UFUNC_LOOPS_H

#include "ln_core.h"

#ifdef __cplusplus
extern "C" {
#endif

/* Mirrors NumPy's legacy ufunc strided-loop calling convention closely: */
typedef void (*ln_strided_loop)(char **args,
        const ln_intp *dimensions, const ln_intp *steps, void *func);
/* Backward-compatible name used by the pre-0.20 binary executor. */
typedef ln_strided_loop ln_strided_binary_loop;

ln_strided_binary_loop ln_get_add_loop(ln_dtype_num type_num);
ln_strided_binary_loop ln_get_subtract_loop(ln_dtype_num type_num);
ln_strided_binary_loop ln_get_multiply_loop(ln_dtype_num type_num);
ln_strided_binary_loop ln_get_true_divide_loop(ln_dtype_num type_num);
ln_strided_binary_loop ln_get_binary_loop(ln_binary_op op, ln_dtype_num type_num);

/* Multi-output loops from NumPy generate_umath.py / loops.c.src. */
ln_strided_loop ln_get_frexp_loop(ln_dtype_num type_num);
ln_strided_loop ln_get_modf_loop(ln_dtype_num type_num);
ln_strided_loop ln_get_divmod_loop(ln_dtype_num type_num);
ln_strided_loop ln_get_ldexp_loop(ln_dtype_num float_type, ln_dtype_num exponent_type);
/* Exact mixed signed/unsigned 64-bit comparison loops from loops.c.src qQ/Qq. */
ln_strided_binary_loop ln_get_mixed_comparison_loop(ln_binary_op op,
                                                     const ln_dtype *a,
                                                     const ln_dtype *b);

#ifdef __cplusplus
}
#endif
#endif
