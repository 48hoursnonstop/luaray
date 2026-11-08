#include "ln_join.h"

#include <inttypes.h>
#include <limits.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

static void join_error(ln_error *e, const char *message)
{
    if (e) snprintf(e->message, sizeof(e->message), "%s", message);
}

static char *join_at(const ln_array *a, const ln_intp *indices)
{
    char *p = a->data;
    for (int i = 0; i < a->nd; i++) p += indices[i] * a->strides[i];
    return p;
}

static void join_advance(int nd, const ln_intp *shape, ln_intp *indices)
{
    for (int i = nd - 1; i >= 0; i--) {
        if (++indices[i] < shape[i]) return;
        indices[i] = 0;
    }
}

ln_array *ln_join_arrays(const ln_array *const *arrays, size_t count,
                         int axis, int stack, const ln_dtype_descr *dtype,
                         ln_casting casting, ln_array *out, ln_error *err)
{
    if (!arrays || count == 0) {
        join_error(err, "need at least one array to concatenate/stack");
        return NULL;
    }
    if (out && dtype) {
        join_error(err, "only one of 'out' or 'dtype' may be supplied");
        return NULL;
    }
    if (!arrays[0]) { join_error(err, "null input array"); return NULL; }
    if (count > (size_t)INTPTR_MAX) {
        join_error(err, "too many arrays to stack"); return NULL;
    }
    int in_nd = arrays[0]->nd;
    if (stack && in_nd >= LN_MAXDIMS) {
        join_error(err, "stack exceeds maximum number of dimensions");
        return NULL;
    }
    if (!stack && axis != -1 && in_nd == 0) {
        join_error(err, "zero-dimensional arrays cannot be concatenated");
        return NULL;
    }
    if (stack ? (axis < 0 || axis > in_nd) : (axis < -1 || axis >= in_nd)) {
        join_error(err, "axis is out of bounds"); return NULL;
    }
    int flat = !stack && axis == -1;
    int nd = flat ? 1 : in_nd + (stack != 0);
    ln_intp shape[LN_MAXDIMS] = {0};
    if (flat) shape[0] = 0;
    else if (stack) {
        for (int d = 0; d < nd; ++d) {
            shape[d] = d == axis ? (ln_intp)count :
                arrays[0]->dimensions[d > axis ? d - 1 : d];
        }
    }
    else for (int d = 0; d < nd; ++d) shape[d] = arrays[0]->dimensions[d];

    const ln_dtype_descr *resolved = out ? out->descr : (dtype ? dtype : arrays[0]->descr);
    ln_intp cumulative = 0;
    for (size_t j = 0; j < count; ++j) {
        const ln_array *a = arrays[j];
        if (!a) { join_error(err, "null input array"); return NULL; }
        if (!flat && a->nd != in_nd) {
            join_error(err, "all input arrays must have the same number of dimensions");
            return NULL;
        }
        if (!flat) for (int d = 0; d < in_nd; ++d) {
            if (stack || d != axis) {
                if (a->dimensions[d] != arrays[0]->dimensions[d]) {
                    join_error(err, stack ? "all input arrays must have the same shape" :
                            "array dimensions must match except along the concatenation axis");
                    return NULL;
                }
            }
        }
        if (!out && !dtype && j != 0) {
            resolved = ln_promote_dtype(resolved, a->descr);
            if (!resolved) {
                join_error(err, "input DTypes have no common promotion");
                return NULL;
            }
        }
        if (!stack) {
            ln_intp n = flat ? ln_array_size(a) : a->dimensions[axis];
            if (n < 0 || (uintmax_t)n > (uintmax_t)INTPTR_MAX - (uintmax_t)cumulative) {
                join_error(err, "concatenated dimension exceeds maximum size");
                return NULL;
            }
            cumulative += n;
        }
    }
    if (!stack) shape[flat ? 0 : axis] = cumulative;
    if (out) {
        if (!(out->flags & LN_ARRAY_WRITEABLE)) {
            join_error(err, "output array is read-only"); return NULL;
        }
        if (out->nd != nd) {
            join_error(err, "output array has wrong dimensionality"); return NULL;
        }
        for (int d = 0; d < nd; ++d) {
            if (out->dimensions[d] != shape[d]) {
                join_error(err, "output array has wrong shape"); return NULL;
            }
        }
    }
    for (size_t j = 0; j < count; ++j) {
        if (!ln_dtype_can_cast(arrays[j]->descr, resolved, casting)) {
            if (err) snprintf(err->message, sizeof(err->message),
                "Cannot cast array data from dtype('%s') to dtype('%s') according to the rule '%s'",
                arrays[j]->descr->name, resolved->name, ln_casting_name(casting));
            return NULL;
        }
    }
    /* A destination sharing a buffer with an input requires a staging array.
     * This is deliberately conservative and handles transposed/sliced aliases. */
    int overlap = 0;
    if (out) for (size_t j = 0; j < count; ++j)
        if (arrays[j]->owner == out->owner) overlap = 1;
    ln_array *dst = overlap || !out ? ln_array_new(nd, shape, resolved, 0, 0, err) : out;
    if (!dst) return NULL;
    ln_intp offset = 0;
    for (size_t j = 0; j < count; ++j) {
        const ln_array *a = arrays[j];
        ln_intp total = ln_array_size(a);
        if (total < 0) { join_error(err, "array too large"); goto error; }
        ln_intp src_idx[LN_MAXDIMS] = {0};
        ln_intp dst_idx[LN_MAXDIMS] = {0};
        for (ln_intp k = 0; k < total; ++k) {
            if (flat) dst_idx[0] = offset + k;
            else if (stack) {
                for (int d = 0; d < nd; ++d)
                    dst_idx[d] = d == axis ? (ln_intp)j : src_idx[d > axis ? d-1 : d];
            }
            else {
                for (int d = 0; d < nd; ++d) dst_idx[d] = src_idx[d];
                dst_idx[axis] += offset;
            }
            char *sp = join_at(a, src_idx);
            char *dp = join_at(dst, dst_idx);
            if (a->descr == resolved) memcpy(dp, sp, resolved->elsize);
            else if (ln_cast_strided_numeric(sp, 0, a->descr, dp, 0, resolved, 1, err) < 0)
                goto error;
            join_advance(a->nd, a->dimensions, src_idx);
        }
        if (!stack) offset += flat ? total : a->dimensions[axis];
    }
    if (overlap) {
        ln_intp total = ln_array_size(dst);
        ln_intp idx[LN_MAXDIMS] = {0};
        for (ln_intp k = 0; k < total; ++k) {
            memcpy(join_at(out, idx), join_at(dst, idx), resolved->elsize);
            join_advance(nd, shape, idx);
        }
        ln_array_free(dst);
        return out;
    }
    return dst;
error:
    if (dst != out) ln_array_free(dst);
    return NULL;
}
