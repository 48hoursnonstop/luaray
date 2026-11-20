#ifndef LUARAY_EINSUM_H
#define LUARAY_EINSUM_H

#include "ln_core.h"
#include "ln_dtype_transfer.h"

#define LN_EINSUM_MAX_INPUTS 63

typedef struct ln_einsum_input {
    const ln_array *array;
    int axis[LN_MAXDIMS];
} ln_einsum_input;

/* Operand axes map into one logical shape. Output axes come first and
 * remaining axes are contracted. An explicit output is validated before
 * calculation. The returned array header belongs to the caller. */
ln_array *ln_einsum(const ln_einsum_input *inputs, int count,
                    int ndim, int output_ndim, const ln_dtype *dtype,
                    char order, ln_casting casting, const ln_array *out,
                    ln_error *err);

#endif
