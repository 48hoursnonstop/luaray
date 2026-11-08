#ifndef LUARAY_NDITER_H
#define LUARAY_NDITER_H

#include "ln_core.h"

#ifdef __cplusplus
extern "C" {
#endif

/*
 * Native numeric subset of NumPy's NpyIter machinery used by ufunc calls.
 *
 * The iterator currently supports two readable operands, one writable output,
 * and an optional boolean ARRAYMASK.  It preserves the upstream NpyIter
 * ordering/coalescing rules, buffered dtype transfers, COPY_IF_OVERLAP style
 * output temporaries, and masked writeback.  It is deliberately host-neutral:
 * there are no PyObject/CPython fields or callbacks here.
 */

/* Allocate a new output using NpyIter's keep-order axis permutation.  `where`
 * participates in broadcasting exactly like NumPy's masked ufunc iterator. */
ln_array *ln_nditer_binary_new_ex2(const ln_array *a, const ln_array *b,
                                   const ln_array *where,
                                   const ln_dtype *input_dtype_a,
                                   const ln_dtype *input_dtype_b,
                                   const ln_dtype *output_dtype,
                                   ln_binary_op op, ln_error *err);

ln_array *ln_nditer_binary_new_ex(const ln_array *a, const ln_array *b,
                                  const ln_array *where,
                                  const ln_dtype *input_dtype,
                                  const ln_dtype *output_dtype,
                                  ln_binary_op op, ln_error *err);

/* Uniform-input/output convenience wrapper used by arithmetic/minmax ufuncs. */
ln_array *ln_nditer_binary_new(const ln_array *a, const ln_array *b,
                               const ln_array *where,
                               const ln_dtype *loop_dtype,
                               ln_binary_op op, ln_error *err);

/* Execute into an existing output.  The output participates in broadcasting
 * but must itself have the final broadcast shape (a broadcasted output is not
 * writable as a ufunc output).  Result values are cast to out->descr using
 * NumPy's default same_kind output casting rule. */
int ln_nditer_binary_into_ex2(const ln_array *a, const ln_array *b,
                              ln_array *out, const ln_array *where,
                              const ln_dtype *input_dtype_a,
                              const ln_dtype *input_dtype_b,
                              const ln_dtype *output_dtype,
                              ln_binary_op op, ln_error *err);

int ln_nditer_binary_into_ex(const ln_array *a, const ln_array *b,
                             ln_array *out, const ln_array *where,
                             const ln_dtype *input_dtype,
                             const ln_dtype *output_dtype,
                             ln_binary_op op, ln_error *err);

int ln_nditer_binary_into(const ln_array *a, const ln_array *b,
                          ln_array *out, const ln_array *where,
                          const ln_dtype *loop_dtype,
                          ln_binary_op op, ln_error *err);

#ifdef __cplusplus
}
#endif
#endif
