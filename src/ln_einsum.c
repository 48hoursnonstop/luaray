#include "ln_einsum.h"
#include "ln_creation.h"
#include "ln_half.h"
#include "ln_order.h"
#include "ln_ufunc_loops.h"

#include <stdint.h>
#include <stdio.h>
#include <string.h>

/* Axis remapping follows NumPy 2.5.5 multiarray/einsum.cpp.
 * The contraction walks strided operands directly, with no tensor-sized
 * product temporary. Independent output storage makes aliasing safe. */

static ln_array *invalid(ln_error *err, const char *message)
{
    if (err) snprintf(err->message, sizeof(err->message), "%s", message);
    return NULL;
}

static int project(const ln_einsum_input *input, int nd, ln_intp *dims,
                   ln_intp *strides)
{
    const ln_array *array = input->array;
    for (int i = 0; i < nd; i++) dims[i] = -1;
    memset(strides, 0, (size_t)nd * sizeof(*strides));
    for (int i = 0; i < array->nd; i++) {
        int axis = input->axis[i];
        if (axis < 0 || axis >= nd) return -1;
        ln_intp n = array->dimensions[i];
        if (dims[axis] < 0) dims[axis] = n;
        else if (dims[axis] != n) return -1;
        if (__builtin_add_overflow(strides[axis], array->strides[i],
                                   &strides[axis])) return -1;
    }
    return 0;
}

static void next_index(ln_intp *coordinate, const ln_intp *shape,
                       const int *order, int nd)
{
    for (int i = 0; i < nd; i++) {
        int axis = order[i];
        if (++coordinate[axis] < shape[axis]) break;
        coordinate[axis] = 0;
    }
}

static char *coordinate_address(char *data, const ln_intp *strides,
                                const ln_intp *coordinate, int nd)
{
    ln_intp offset = 0;
    for (int d = 0; d < nd; d++) offset += coordinate[d] * strides[d];
    return data + offset;
}

static float read_half(const char *data)
{
    ln_half value;
    memcpy(&value,data,sizeof(value));
    return ln_half_to_float(value);
}

typedef union scalar_storage {
    long double alignment;
    char bytes[2 * sizeof(long double)];
} scalar_storage;

static void reduce_cell(char *output, char *const *data, int count,
                        const ln_intp *const *strides, const ln_intp *shape,
                        const int *order, int nd, ln_intp total,
                        ln_intp half_span, const ln_dtype *dtype, ln_strided_loop mul,
                        ln_strided_loop add)
{
    ln_intp coordinate[LN_MAXDIMS] = {0};
    const ln_intp one[1] = {1}, steps[3] = {0, 0, 0};
    scalar_storage accumulator = {0}, product, temporary;
    float half_accumulator = 0, half_partial = 0;
    ln_intp until_store = half_span;
    memset(accumulator.bytes, 0, dtype->elsize);
    for (ln_intp i = 0; i < total; i++) {
        char *first = coordinate_address(data[0], strides[0], coordinate, nd);
        if (dtype->type_num == LN_HALF) {
            float value = read_half(first);
            for (int k = 1; k < count; k++) {
                char *cell = coordinate_address(data[k], strides[k], coordinate, nd);
                value *= read_half(cell);
            }
            half_partial += value;
            if (--until_store == 0 || i == total-1) {
                half_accumulator = ln_half_to_float(ln_float_to_half(half_accumulator+half_partial));
                half_partial = 0;
                until_store = half_span;
            }
        }
        else {
            memcpy(product.bytes, first, dtype->elsize);
            for (int k = 1; k < count; k++) {
                char *cell = coordinate_address(data[k], strides[k], coordinate, nd);
                char *args[] = {product.bytes, cell, temporary.bytes};
                mul(args, one, steps, NULL);
                memcpy(product.bytes, temporary.bytes, dtype->elsize);
            }
            char *args[] = {accumulator.bytes, product.bytes, temporary.bytes};
            add(args, one, steps, NULL);
            memcpy(accumulator.bytes, temporary.bytes, dtype->elsize);
        }
        next_index(coordinate, shape, order, nd);
    }
    if (dtype->type_num == LN_HALF) {
        ln_half value=ln_float_to_half(half_accumulator);
        memcpy(output,&value,sizeof(value));
    }
    else
        memcpy(output, accumulator.bytes, dtype->elsize);
}

ln_array *ln_einsum(const ln_einsum_input *inputs, int count,
                    int nd, int output_nd,
                    const ln_dtype *requested, char order, ln_casting casting,
                    const ln_array *out, ln_error *err)
{
    if (!inputs || count < 1 || count > LN_EINSUM_MAX_INPUTS || nd > LN_MAXDIMS ||
            output_nd < 0 || output_nd > nd || !strchr("CAFK", order) || !order)
        return invalid(err, "invalid Einstein summation plan");

    ln_intp shape[LN_MAXDIMS];
    ln_intp strides[LN_EINSUM_MAX_INPUTS][LN_MAXDIMS];
    ln_intp dims[LN_MAXDIMS];
    for (int d = 0; d < nd; d++) shape[d] = 1;
    int fortran = 1;
    for (int k = 0; k < count; k++) {
        if (!inputs[k].array || project(&inputs[k], nd, dims, strides[k]) < 0)
            return invalid(err, "diagonal axes must have the same length");
        if (!(inputs[k].array->flags & LN_ARRAY_F_CONTIGUOUS)) fortran = 0;
        for (int d = 0; d < nd; d++) {
            if (dims[d] < 0 || dims[d] == 1) continue;
            if (shape[d] != 1 && shape[d] != dims[d])
                return invalid(err, "Einstein operands do not broadcast");
            shape[d] = dims[d];
        }
    }

    if (count == 1 && output_nd == nd && !out)
        return ln_array_view(inputs[0].array, nd, shape, strides[0],
                             inputs[0].array->data, err);

    if (out) {
        if (out->nd != output_nd || !(out->flags & LN_ARRAY_WRITEABLE))
            return invalid(err, "invalid Einstein output array");
        for (int d = 0; d < output_nd; d++) {
            if (out->dimensions[d] != shape[d])
                return invalid(err, "Einstein output shape differs from the result");
        }
    }

    const ln_dtype *dtype = requested;
    if (!dtype) {
        dtype = inputs[0].array->descr;
        for (int k = 1; k < count && dtype; k++)
            dtype = ln_promote_dtype(dtype, inputs[k].array->descr);
        if (out && dtype) dtype = ln_promote_dtype(dtype, out->descr);
    }
    if (!dtype || !strchr("biufc", dtype->kind))
        return invalid(err, "Einstein contraction requires a numeric dtype");
    const ln_dtype *result_dtype = dtype;
    dtype = ln_dtype_by_num(dtype->type_num);
    ln_strided_loop multiply = ln_get_multiply_loop(dtype->type_num);
    ln_strided_loop add = ln_get_add_loop(dtype->type_num);
    if (!multiply || !add || dtype->elsize > sizeof(((scalar_storage *)0)->bytes))
        return invalid(err, "Einstein contraction dtype has no arithmetic loops");
    if (out && (!ln_dtype_can_cast(dtype, out->descr, casting) ||
                !ln_dtype_can_cast(out->descr, dtype, casting)))
        return invalid(err, "Einstein result cannot be cast to output dtype");
    for (int k = 0; k < count; k++) {
        if (!ln_dtype_can_cast(inputs[k].array->descr, dtype, casting))
            return invalid(err, "Einstein operand violates the casting rule");
    }

    ln_array *converted[LN_EINSUM_MAX_INPUTS] = {0};
    ln_array *result = NULL;
    int order_axes[LN_MAXDIMS];
    const ln_intp *rows[LN_EINSUM_MAX_INPUTS + 1];
    ln_intp out_strides[LN_MAXDIMS] = {0};
    for (int k = 0; k < count; k++) {
        ln_einsum_input input = inputs[k];
        const ln_array *a = input.array;
        for (int d = 0; d < nd; d++) {
            /* Broadcast axes have zero stride. Actual unit axes keep their
             * stride for output ordering when the result also has length one. */
            if (shape[d] != 1) {
                int axis = 0;
                while (axis < a->nd && input.axis[axis] != d) axis++;
                if (axis == a->nd || a->dimensions[axis] == 1) strides[k][d] = 0;
            }
        }
        rows[k] = strides[k];
    }
    if (out) {
        if (output_nd) memcpy(out_strides, out->strides, (size_t)output_nd * sizeof(*out_strides));
        rows[count] = out_strides;
        if (!(out->flags & LN_ARRAY_F_CONTIGUOUS)) fortran = 0;
    }
    if (order == 'A') order = fortran ? 'F' : 'C';
    if (order == 'K') {
        if (ln_keeporder_axes(nd, count + (out != NULL), rows, order_axes, err) < 0) goto done;
    }
    else {
        for (int i = 0; i < nd; i++) order_axes[i] = order == 'F' ? i : nd-1-i;
    }
    ln_intp reductions = 1;
    for (int d = output_nd; d < nd; d++) {
        if (ln_mul_sizes_with_overflow(&reductions, reductions, shape[d])) {
            invalid(err, "Einstein contraction is too large");
            goto done;
        }
    }
    /* A half element is written at the end of each coalesced reduction
     * run. If the inner iterator dimension is an output dimension, each
     * product updates a separately rounded half element. */
    ln_intp half_span = 1;
    int previous = -1;
    for (int i = 0; dtype->type_num == LN_HALF && reductions && i < nd; i++) {
        int axis = order_axes[i];
        if (shape[axis] <= 1) continue;
        if (axis < output_nd) break;
        int combined = 1;
        for (int k = 0; previous >= 0 && k < count; k++) {
            ln_intp stride;
            if (__builtin_mul_overflow(strides[k][previous],shape[previous],&stride) ||
                    stride != strides[k][axis]) combined = 0;
        }
        if (!combined) break;
        half_span *= shape[axis];
        previous = axis;
    }
    result = ln_array_new(output_nd, shape, dtype, 0, 0, err);
    if (!result) goto done;
    ln_intp total = ln_array_size(result);
    int output_order[LN_MAXDIMS], contraction_order[LN_MAXDIMS];
    int o = 0, c = 0;
    for (int i = 0; i < nd; i++) {
        int axis = order_axes[i];
        if (axis < output_nd) output_order[o++] = axis;
        else contraction_order[c++] = axis-output_nd;
    }
    if (total > 0) {
        ln_intp stride = (ln_intp)dtype->elsize;
        for (int i = 0; i < output_nd; i++) {
            int axis = output_order[i];
            result->strides[axis] = stride;
            stride *= shape[axis];
        }
        ln_update_contiguous_flags(result);
    }

    for (int k = 0; k < count; k++) {
        ln_einsum_input input = inputs[k];
        if (input.array->descr != dtype || !(input.array->flags & LN_ARRAY_ALIGNED)) {
            converted[k] = ln_creation_convert(input.array, dtype, 'K', 1, -1, NULL, err);
            if (!converted[k]) goto fail_result;
            input.array = converted[k];
        }
        if (project(&input, nd, dims, strides[k]) < 0) {
            invalid(err, "invalid projected operand strides");
            goto fail_result;
        }
        for (int d = 0; d < nd; d++)
            if (dims[d] != shape[d]) strides[k][d] = 0;
    }

    ln_intp coordinate[LN_MAXDIMS] = {0};
    const ln_intp *reduced_strides[LN_EINSUM_MAX_INPUTS];
    for (int k = 0; k < count; k++) reduced_strides[k] = strides[k] + output_nd;
    for (ln_intp i = 0; i < total; i++) {
        char *cell[LN_EINSUM_MAX_INPUTS];
        for (int k = 0; k < count; k++) {
            const ln_array *a = converted[k] ? converted[k] : inputs[k].array;
            /* There is no legal address in an empty input. The reduction
             * identity requires no reads when the contracted shape is empty. */
            cell[k] = reductions ? coordinate_address(a->data, strides[k],
                                                       coordinate, output_nd) : a->data;
        }
        reduce_cell(result->data + i * (ln_intp)dtype->elsize, cell, count,
                    reduced_strides, shape + output_nd, contraction_order,
                    nd - output_nd, reductions, half_span, dtype, multiply, add);
        next_index(coordinate, shape, output_order, output_nd);
    }
    if (requested && result_dtype != dtype && !out) {
        ln_array *cast = ln_creation_convert(result, result_dtype, 'K', 1, -1, NULL, err);
        ln_array_free(result);
        result = cast;
    }
    goto done;

fail_result:
    ln_array_free(result);
    result = NULL;
done:
    for (int k = 0; k < count; k++) ln_array_free(converted[k]);
    return result;
}
