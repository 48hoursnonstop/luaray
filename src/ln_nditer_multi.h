#ifndef LUARAY_NDITER_MULTI_H
#define LUARAY_NDITER_MULTI_H

#include "ln_core.h"
#include "ln_ufunc_loops.h"

#ifdef __cplusplus
extern "C" {
#endif

#define LN_NDITER_MULTI_MAXARGS 8

typedef int (*ln_nditer_validate_fn)(
        char **args,
        const ln_intp *dimensions,
        const ln_intp *steps,
        const uint8_t *mask,
        ln_intp mask_step,
        void *data,
        ln_error *err);
/* Validation returns 0 on success or -1 for an atomic validation error.
 * Return 1 on success to preserve completed output if a later cast fails.
 * A return of -(prefix+2) requests execution/writeback of the valid prefix
 * before reporting an error, matching kernels that fail after partial writes.
 * prefix counts logical loop positions, including masked positions. */

/* General elementwise iterator used by the generic ufunc engine.
 *
 * Operand order follows NumPy's inner-loop ABI:
 *   inputs[0..nin-1], outputs[0..nout-1]
 *
 * `loop_dtypes` has nin+nout descriptors in the same order.  NULL output
 * entries are allocated and returned in-place.  Existing outputs are borrowed
 * and receive same_kind-cast writeback.  The iterator owns no host-language
 * objects and is deliberately independent of ufunc names/IDs.  Output allocation
 * follows NumPy NpyIter KEEPORDER axis ordering across all readable/writeable
 * operands and the optional mask.
 */
int ln_nditer_multi_execute(
        int nin, int nout,
        const ln_array *const *inputs,
        ln_array **outputs,
        const ln_array *where,
        const ln_dtype_descr *const *loop_dtypes,
        ln_strided_loop loop,
        void *loop_data,
        ln_nditer_validate_fn validate,
        void *validate_data,
        ln_error *err);

/* Uniform kernels whose observable behavior depends on buffered strides. */
int ln_nditer_multi_execute_uniform(
        int nin, int nout,
        const ln_array *const *inputs,
        ln_array **outputs,
        const ln_array *where,
        const ln_dtype_descr *const *loop_dtypes,
        ln_strided_loop loop,
        void *loop_data,
        ln_nditer_validate_fn validate,
        void *validate_data,
        ln_error *err);

#ifdef __cplusplus
}
#endif
#endif
