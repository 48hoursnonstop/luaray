#include "ln_nditer.h"
#include "ln_dtype_transfer.h"
#include "ln_ufunc_loops.h"

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*
 * Source-derived native subset of:
 *   numpy/_core/src/multiarray/nditer_constr.c
 *     npyiter_find_best_axis_ordering
 *     npyiter_flip_negative_strides
 *     npyiter_find_buffering_setup
 *     COPY_IF_OVERLAP handling in npyiter_allocate_arrays
 *   numpy/_core/src/multiarray/nditer_api.c
 *     npyiter_coalesce_axes
 *     npyiter_copy_to_buffers / npyiter_copy_from_buffers
 *   numpy/_core/src/umath/ufunc_object.c:execute_ufunc_loop
 *
 * Only builtin real numeric dtypes are present in LuaRay today, so reference
 * ownership/PyAPI transfer flags are intentionally absent.  The data layout,
 * axis-ordering, coalescing, cast buffering, masked writeback, and overlap
 * decisions are kept separate from the Lua binding just as they are upstream.
 */

#define LN_NDITER_MAXOPS 4
#define LN_NDITER_BUFSIZE 8192  /* ndarraytypes.h:NPY_BUFSIZE */

typedef struct ln_iter_axis {
    ln_intp shape;
    ln_intp strides[LN_NDITER_MAXOPS];
    int original_axis;
    int flipped;
} ln_iter_axis;

typedef struct ln_binary_plan {
    int ndim;
    int nop;
    int has_where;
    ln_intp shape[LN_MAXDIMS];
    ln_intp bstrides[LN_NDITER_MAXOPS][LN_MAXDIMS];
    ln_iter_axis axes[LN_MAXDIMS];
    int naxes;
    char *base[LN_NDITER_MAXOPS];
} ln_binary_plan;

static void
iter_error(ln_error *err, const char *msg)
{
    if (err) {
        snprintf(err->message, sizeof(err->message), "%s", msg ? msg : "iterator error");
    }
}

static ln_intp
intp_abs(ln_intp x)
{
    return x < 0 ? -x : x;
}

static int
dtype_kind_order(char kind)
{
    /* Direct numeric subset of convert_datatype.c:dtype_kind_to_ordering. */
    switch (kind) {
        case 'b': return 0;
        case 'u': return 1;
        case 'i': return 2;
        case 'f': return 4;
        case 'c': return 5;
        default: return -1;
    }
}

static int
can_cast_same_kind(const ln_dtype *from, const ln_dtype *to)
{
    if (from->type_num == to->type_num) return 1;

    /* For builtin numerics, promotion to exactly `to` is the safe-cast half
     * of the upstream same_kind test. */
    const ln_dtype *promoted = ln_promote_dtype(from, to);
    if (promoted && promoted->type_num == to->type_num) return 1;

    int f = dtype_kind_order(from->kind);
    int t = dtype_kind_order(to->kind);
    return f >= 0 && t >= 0 && f <= t;
}

static int
same_shape(const ln_array *a, int nd, const ln_intp *shape)
{
    if (!a || a->nd != nd) return 0;
    for (int i = 0; i < nd; ++i) {
        if (a->dimensions[i] != shape[i]) return 0;
    }
    return 1;
}

static int
build_broadcast_shape(const ln_array *a, const ln_array *b,
                      const ln_array *out, const ln_array *where,
                      int *nd, ln_intp *shape, ln_error *err)
{
    const ln_array *arrs[4];
    int n = 0;
    arrs[n++] = a;
    arrs[n++] = b;
    if (out) arrs[n++] = out;
    if (where) arrs[n++] = where;
    if (ln_broadcast_shape(n, arrs, nd, shape, err) < 0) return -1;

    /* NpyIter may broadcast inputs to an output, but a write operand itself
     * cannot be broadcast to a larger iterator shape. */
    if (out && !same_shape(out, *nd, shape)) {
        char msg[256];
        snprintf(msg, sizeof(msg),
                 "non-broadcastable output operand does not match the broadcast shape");
        iter_error(err, msg);
        return -1;
    }
    return 0;
}

static int
fill_broadcast_strides(ln_binary_plan *p,
                       const ln_array *a, const ln_array *b,
                       const ln_array *out, const ln_array *where,
                       ln_error *err)
{
    const ln_array *ops[4] = {a, b, out, where};
    const char *names[4] = {"operand 0", "operand 1", "output operand", "where mask"};
    p->nop = where ? 4 : 3;
    for (int i = 0; i < p->nop; ++i) {
        if (i == 2 && out == NULL) {
            for (int d = 0; d < p->ndim; ++d) p->bstrides[i][d] = 0;
            continue;
        }
        const ln_array *op = ops[i];
        if (ln_broadcast_strides(p->ndim, p->shape,
                op->nd, op->dimensions, op->strides, names[i],
                p->bstrides[i], err) < 0) {
            return -1;
        }
    }
    return 0;
}

static void
init_axes(ln_binary_plan *p)
{
    p->naxes = p->ndim;
    /* NpyIter AXISDATA is initially reversed from C order: inner first. */
    for (int ia = 0; ia < p->ndim; ++ia) {
        int d = p->ndim - 1 - ia;
        p->axes[ia].shape = p->shape[d];
        p->axes[ia].original_axis = d;
        p->axes[ia].flipped = 0;
        for (int iop = 0; iop < p->nop; ++iop) {
            p->axes[ia].strides[iop] = p->bstrides[iop][d];
        }
    }
}

static int
axis_should_insert_before(const ln_iter_axis *candidate,
                          const ln_iter_axis *previous, int nop)
{
    int ambig = 1;
    int shouldswap = 0;
    for (int iop = 0; iop < nop; ++iop) {
        ln_intp s0 = candidate->strides[iop];
        ln_intp s1 = previous->strides[iop];
        if (s0 != 0 && s1 != 0) {
            if (intp_abs(s1) <= intp_abs(s0)) {
                shouldswap = 0;
            }
            else if (ambig) {
                shouldswap = 1;
            }
            ambig = 0;
        }
    }
    return !ambig && shouldswap;
}

static void
find_best_axis_ordering(ln_binary_plan *p)
{
    /* Stable insertion sort translated from npyiter_find_best_axis_ordering. */
    for (int i = 1; i < p->naxes; ++i) {
        ln_iter_axis candidate = p->axes[i];
        int pos = i;
        for (int j = i - 1; j >= 0; --j) {
            if (axis_should_insert_before(&candidate, &p->axes[j], p->nop)) {
                pos = j;
            }
            else {
                /* Upstream only stops on an unambiguous no-swap.  Re-run the
                 * ambiguity test so all-zero/broadcast ties remain stable. */
                int compared = 0;
                for (int iop = 0; iop < p->nop; ++iop) {
                    if (candidate.strides[iop] != 0 && p->axes[j].strides[iop] != 0) {
                        compared = 1;
                        break;
                    }
                }
                if (compared) break;
            }
        }
        if (pos != i) {
            for (int j = i; j > pos; --j) p->axes[j] = p->axes[j - 1];
            p->axes[pos] = candidate;
        }
    }
}

static void
flip_negative_strides(ln_binary_plan *p)
{
    /* npyiter_flip_negative_strides: flip an axis only when every nonzero
     * operand stride is negative. */
    for (int ia = 0; ia < p->naxes; ++ia) {
        int any_negative = 0;
        int all_nonpositive = 1;
        for (int iop = 0; iop < p->nop; ++iop) {
            ln_intp s = p->axes[ia].strides[iop];
            if (s < 0) any_negative = 1;
            else if (s > 0) { all_nonpositive = 0; break; }
        }
        if (!any_negative || !all_nonpositive) continue;
        ln_intp shapem1 = p->axes[ia].shape - 1;
        for (int iop = 0; iop < p->nop; ++iop) {
            p->base[iop] += shapem1 * p->axes[ia].strides[iop];
            p->axes[ia].strides[iop] = -p->axes[ia].strides[iop];
        }
        p->axes[ia].flipped = !p->axes[ia].flipped;
    }
}

static void
coalesce_axes(ln_binary_plan *p)
{
    if (p->naxes <= 1) return;
    int write = 0;
    for (int read = 0; read < p->naxes - 1; ++read) {
        ln_iter_axis *a0 = &p->axes[write];
        ln_iter_axis *a1 = &p->axes[read + 1];
        int can = 1;
        for (int iop = 0; iop < p->nop; ++iop) {
            ln_intp s0 = a0->strides[iop];
            ln_intp s1 = a1->strides[iop];
            if (!((a0->shape == 1 && s0 == 0) ||
                  (a1->shape == 1 && s1 == 0)) &&
                    s0 * a0->shape != s1) {
                can = 0;
                break;
            }
        }
        if (can) {
            a0->shape *= a1->shape;
            for (int iop = 0; iop < p->nop; ++iop) {
                if (a0->strides[iop] == 0) a0->strides[iop] = a1->strides[iop];
            }
        }
        else {
            ++write;
            if (write != read + 1) p->axes[write] = *a1;
        }
    }
    p->naxes = write + 1;
}

static int
plan_binary(ln_binary_plan *p,
            const ln_array *a, const ln_array *b,
            ln_array *out, const ln_array *where,
            int output_is_new, ln_error *err)
{
    memset(p, 0, sizeof(*p));
    p->has_where = where != NULL;
    if (where && where->descr->type_num != LN_BOOL) {
        iter_error(err, "where mask must have dtype bool");
        return -1;
    }
    if (build_broadcast_shape(a, b, out, where, &p->ndim, p->shape, err) < 0) return -1;
    if (fill_broadcast_strides(p, a, b, out, where, err) < 0) return -1;
    p->base[0] = a->data;
    p->base[1] = b->data;
    p->base[2] = out ? out->data : NULL;
    p->base[3] = where ? where->data : NULL;
    init_axes(p);
    if (p->naxes > 1) find_best_axis_ordering(p);
    /* Upstream does not negate strides when an output still has to be
     * allocated, because the allocation must preserve the chosen layout. */
    if (!output_is_new) flip_negative_strides(p);
    return 0;
}

static void
compatible_output_strides(const ln_binary_plan *p, size_t itemsize,
                          ln_intp *strides)
{
    ln_intp stride = (ln_intp)itemsize;
    for (int ia = 0; ia < p->naxes; ++ia) {
        int d = p->axes[ia].original_axis;
        strides[d] = stride;
        stride *= p->axes[ia].shape;
    }
}

static int
has_internal_overlap(const ln_array *a)
{
    for (int d = 0; d < a->nd; ++d) {
        if (a->dimensions[d] > 1 && a->strides[d] == 0) return 1;
    }
    return 0;
}

static int
exact_elementwise_alias(const ln_array *a, const ln_array *b)
{
    if (!a || !b || a->owner != b->owner || a->data != b->data ||
            a->descr->type_num != b->descr->type_num || a->nd != b->nd ||
            has_internal_overlap(a) || has_internal_overlap(b)) {
        return 0;
    }
    for (int d = 0; d < a->nd; ++d) {
        if (a->dimensions[d] != b->dimensions[d] || a->strides[d] != b->strides[d]) return 0;
    }
    return 1;
}

static void
byte_bounds(const ln_array *a, intptr_t *lo, intptr_t *hi)
{
    intptr_t base = (intptr_t)a->data;
    ln_intp minoff = 0, maxoff = 0;
    for (int d = 0; d < a->nd; ++d) {
        if (a->dimensions[d] <= 0) continue;
        ln_intp e = (a->dimensions[d] - 1) * a->strides[d];
        if (e < 0) minoff += e;
        else maxoff += e;
    }
    *lo = base + minoff;
    *hi = base + maxoff + (intptr_t)a->descr->elsize;
}

static int
may_overlap(const ln_array *a, const ln_array *b)
{
    if (!a || !b || a->owner != b->owner || ln_array_size(a) == 0 || ln_array_size(b) == 0) return 0;
    intptr_t alo, ahi, blo, bhi;
    byte_bounds(a, &alo, &ahi);
    byte_bounds(b, &blo, &bhi);
    return alo < bhi && blo < ahi;
}

static int
copy_same_shape(const ln_array *src, ln_array *dst, ln_error *err)
{
    if (!same_shape(src, dst->nd, dst->dimensions)) {
        iter_error(err, "writeback shape mismatch");
        return -1;
    }
    ln_intp total = ln_array_size(dst);
    if (total <= 0) return 0;
    if (dst->nd == 0) {
        return ln_cast_strided_numeric(src->data, 0, src->descr,
                dst->data, 0, dst->descr, 1, err);
    }
    ln_intp coord[LN_MAXDIMS] = {0};
    for (ln_intp i = 0; i < total; ++i) {
        const char *sp = src->data;
        char *dp = dst->data;
        for (int d = 0; d < dst->nd; ++d) {
            sp += coord[d] * src->strides[d];
            dp += coord[d] * dst->strides[d];
        }
        if (ln_cast_strided_numeric(sp, 0, src->descr, dp, 0, dst->descr, 1, err) < 0) return -1;
        for (int d = dst->nd - 1; d >= 0; --d) {
            if (++coord[d] < dst->dimensions[d]) break;
            coord[d] = 0;
        }
    }
    return 0;
}

static int
negative_signed_value(const char *p, const ln_dtype *dt)
{
    switch (dt->type_num) {
        case LN_BYTE: { int8_t v; memcpy(&v,p,sizeof(v)); return v < 0; }
        case LN_SHORT: { int16_t v; memcpy(&v,p,sizeof(v)); return v < 0; }
        case LN_INT: { int32_t v; memcpy(&v,p,sizeof(v)); return v < 0; }
        case LN_LONG: { long v; memcpy(&v,p,sizeof(v)); return v < 0; }
        case LN_LONGLONG: { long long v; memcpy(&v,p,sizeof(v)); return v < 0; }
        default: return 0;
    }
}

static int
execute_plan(ln_binary_plan *p,
             const ln_array *a, const ln_array *b,
             ln_array *out, const ln_array *where,
             const ln_dtype *input_dtype_a, const ln_dtype *input_dtype_b,
             const ln_dtype *output_dtype,
             ln_binary_op op, ln_error *err)
{
    ln_strided_binary_loop loop = NULL;
    if (input_dtype_a->type_num == input_dtype_b->type_num) {
        loop = ln_get_binary_loop(op, input_dtype_a->type_num);
    }
    else {
        loop = ln_get_mixed_comparison_loop(op, input_dtype_a, input_dtype_b);
    }
    if (!loop) {
        iter_error(err, "no ufunc inner loop for resolved dtype");
        return -1;
    }

    if (!can_cast_same_kind(output_dtype, out->descr)) {
        char msg[256];
        snprintf(msg, sizeof(msg),
                 "Cannot cast ufunc output from dtype('%s') to dtype('%s') with casting rule 'same_kind'",
                 output_dtype->name, out->descr->name);
        iter_error(err, msg);
        return -1;
    }

    ln_intp total = 1;
    if (p->ndim == 0) total = 1;
    else {
        for (int d = 0; d < p->ndim; ++d) {
            if (p->shape[d] == 0) return 0;
            total *= p->shape[d];
        }
    }
    if (total == 0) return 0;

    /* COPY_IF_OVERLAP: force a temporary write operand when overlap is not the
     * exact elementwise alias explicitly allowed by ufunc op flags. */
    int force_temp = 0;
    if (may_overlap(out, a) && !exact_elementwise_alias(out, a)) force_temp = 1;
    if (may_overlap(out, b) && !exact_elementwise_alias(out, b)) force_temp = 1;
    if (where && may_overlap(out, where)) force_temp = 1;

    ln_array *work_out = out;
    ln_array *temp = NULL;
    if (force_temp) {
        temp = ln_array_new(out->nd, out->dimensions, out->descr, 0, 0, err);
        if (!temp) return -1;
        /* Masked ufunc outputs are READWRITE upstream so false mask elements
         * survive a temporary/writeback cycle. */
        if (where && copy_same_shape(out, temp, err) < 0) {
            ln_array_free(temp);
            return -1;
        }
        work_out = temp;

        /* Re-plan strides with the temporary as the write operand, keeping the
         * already chosen logical broadcast shape. */
        if (ln_broadcast_strides(p->ndim, p->shape, work_out->nd,
                work_out->dimensions, work_out->strides, "output operand",
                p->bstrides[2], err) < 0) {
            ln_array_free(temp);
            return -1;
        }
        p->base[2] = work_out->data;
        /* npyiter_replace_axisdata keeps the already chosen iterator axis
         * order (including negative-axis flips).  Replace only this operand's
         * strides in that order. */
        for (int ia = 0; ia < p->naxes; ++ia) {
            int d = p->axes[ia].original_axis;
            ln_intp s = p->bstrides[2][d];
            if (p->axes[ia].flipped) {
                p->base[2] += (p->axes[ia].shape - 1) * s;
                s = -s;
            }
            p->axes[ia].strides[2] = s;
        }
    }

    coalesce_axes(p);

    const int cast_a = a->descr->type_num != input_dtype_a->type_num;
    const int cast_b = b->descr->type_num != input_dtype_b->type_num;
    const int buffer_out = (work_out->descr->type_num != output_dtype->type_num) || where != NULL;
    size_t input_a_isz = input_dtype_a->elsize;
    size_t input_b_isz = input_dtype_b->elsize;
    size_t output_isz = output_dtype->elsize;

    char *buf_a = cast_a ? (char *)malloc((size_t)LN_NDITER_BUFSIZE * input_a_isz) : NULL;
    char *buf_b = cast_b ? (char *)malloc((size_t)LN_NDITER_BUFSIZE * input_b_isz) : NULL;
    char *buf_out = buffer_out ? (char *)malloc((size_t)LN_NDITER_BUFSIZE * output_isz) : NULL;
    if ((cast_a && !buf_a) || (cast_b && !buf_b) || (buffer_out && !buf_out)) {
        free(buf_a); free(buf_b); free(buf_out); ln_array_free(temp);
        iter_error(err, "out of memory");
        return -1;
    }

    const char *prev_a = NULL, *prev_b = NULL;
    ln_intp prev_a_count = -1, prev_b_count = -1;

    int naxes = p->naxes;
    ln_intp inner = naxes == 0 ? 1 : p->axes[0].shape;
    ln_intp outer = inner == 0 ? 0 : total / inner;
    ln_intp coord[LN_MAXDIMS] = {0};

    for (ln_intp oi = 0; oi < outer; ++oi) {
        char *row[LN_NDITER_MAXOPS] = {p->base[0], p->base[1], p->base[2], p->base[3]};
        for (int ia = 1; ia < naxes; ++ia) {
            for (int iop = 0; iop < p->nop; ++iop) {
                row[iop] += coord[ia - 1] * p->axes[ia].strides[iop];
            }
        }
        ln_intp sa = naxes ? p->axes[0].strides[0] : 0;
        ln_intp sb = naxes ? p->axes[0].strides[1] : 0;
        ln_intp so = naxes ? p->axes[0].strides[2] : 0;
        ln_intp sm = (where && naxes) ? p->axes[0].strides[3] : 0;

        for (ln_intp off = 0; off < inner; off += LN_NDITER_BUFSIZE) {
            ln_intp count = inner - off;
            if (count > LN_NDITER_BUFSIZE) count = LN_NDITER_BUFSIZE;
            const char *pa0 = row[0] + off * sa;
            const char *pb0 = row[1] + off * sb;
            char *po0 = row[2] + off * so;
            const char *pm0 = where ? row[3] + off * sm : NULL;

            char *pa = (char *)pa0;
            char *pb = (char *)pb0;
            ln_intp step_a = sa, step_b = sb;
            if (cast_a) {
                /* Numeric form of NPY_OP_ITFLAG_BUF_REUSABLE. */
                if (pa0 != prev_a || count != prev_a_count) {
                    if (ln_cast_strided_numeric(pa0, sa, a->descr,
                            buf_a, (ln_intp)input_a_isz, input_dtype_a, count, err) < 0) goto fail;
                    prev_a = pa0; prev_a_count = count;
                }
                pa = buf_a; step_a = (ln_intp)input_a_isz;
            }
            if (cast_b) {
                if (pb0 != prev_b || count != prev_b_count) {
                    if (ln_cast_strided_numeric(pb0, sb, b->descr,
                            buf_b, (ln_intp)input_b_isz, input_dtype_b, count, err) < 0) goto fail;
                    prev_b = pb0; prev_b_count = count;
                }
                pb = buf_b; step_b = (ln_intp)input_b_isz;
            }

            /* NumPy's integer power loop raises only for elements actually
             * selected by the masked iterator.  LuaRay currently applies the
             * mask during buffered writeback, so reproduce that operation-time
             * validation here before invoking the unmasked inner loop. */
            if (op == LN_OP_POWER && input_dtype_b->kind == 'i') {
                for (ln_intp i = 0; i < count; ++i) {
                    int active = 1;
                    if (where) active = *(const uint8_t *)(pm0 + i * sm) != 0;
                    if (active && negative_signed_value(pb + i * step_b, input_dtype_b)) {
                        iter_error(err, "Integers to negative integer powers are not allowed.");
                        goto fail;
                    }
                }
            }

            char *loop_out = buffer_out ? buf_out : po0;
            ln_intp loop_out_step = buffer_out ? (ln_intp)output_isz : so;
            char *args[3] = {pa, pb, loop_out};
            ln_intp dimensions[1] = {count};
            ln_intp steps[3] = {step_a, step_b, loop_out_step};
            loop(args, dimensions, steps, NULL);

            if (buffer_out) {
                if (!where) {
                    if (ln_cast_strided_numeric(buf_out, (ln_intp)output_isz, output_dtype,
                            po0, so, work_out->descr, count, err) < 0) goto fail;
                }
                else {
                    for (ln_intp i = 0; i < count; ++i) {
                        uint8_t truth = *(const uint8_t *)(pm0 + i * sm);
                        if (truth) {
                            if (ln_cast_strided_numeric(buf_out + i * (ln_intp)output_isz, 0,
                                    output_dtype, po0 + i * so, 0,
                                    work_out->descr, 1, err) < 0) goto fail;
                        }
                    }
                }
            }
        }

        for (int ia = 1; ia < naxes; ++ia) {
            int ci = ia - 1;
            if (++coord[ci] < p->axes[ia].shape) break;
            coord[ci] = 0;
        }
    }

    free(buf_a); free(buf_b); free(buf_out);
    if (temp) {
        int rc = copy_same_shape(temp, out, err);
        ln_array_free(temp);
        return rc;
    }
    return 0;

fail:
    free(buf_a); free(buf_b); free(buf_out);
    ln_array_free(temp);
    return -1;
}

ln_array *
ln_nditer_binary_new_ex2(const ln_array *a, const ln_array *b,
                         const ln_array *where, const ln_dtype *input_dtype_a,
                         const ln_dtype *input_dtype_b, const ln_dtype *output_dtype,
                        ln_binary_op op, ln_error *err)
{
    ln_binary_plan p;
    if (plan_binary(&p, a, b, NULL, where, 1, err) < 0) return NULL;

    ln_array *out = ln_array_new(p.ndim, p.shape, output_dtype, 0, 0, err);
    if (!out) return NULL;
    if (ln_array_size(out) > 0 && p.ndim > 0) {
        ln_intp strides[LN_MAXDIMS] = {0};
        compatible_output_strides(&p, output_dtype->elsize, strides);
        memcpy(out->strides, strides, (size_t)p.ndim * sizeof(ln_intp));
        ln_update_contiguous_flags(out);
    }

    /* Add the allocated output to axis-data only after the keep-order
     * permutation has been chosen, matching NpyIter construction. */
    if (ln_broadcast_strides(p.ndim, p.shape, out->nd, out->dimensions,
            out->strides, "output operand", p.bstrides[2], err) < 0) {
        ln_array_free(out);
        return NULL;
    }
    p.base[2] = out->data;
    /* Keep the permutation selected while the output was still NULL.  This
     * is what npyiter_new_temp_array consumes when it creates compatible
     * output strides. */
    for (int ia = 0; ia < p.naxes; ++ia) {
        int d = p.axes[ia].original_axis;
        p.axes[ia].strides[2] = p.bstrides[2][d];
    }
    /* any_allocate was true upstream, so do not flip negative axes here. */

    if (execute_plan(&p, a, b, out, where, input_dtype_a, input_dtype_b, output_dtype, op, err) < 0) {
        ln_array_free(out);
        return NULL;
    }
    return out;
}

int
ln_nditer_binary_into_ex2(const ln_array *a, const ln_array *b,
                          ln_array *out, const ln_array *where,
                          const ln_dtype *input_dtype_a,
                          const ln_dtype *input_dtype_b,
                          const ln_dtype *output_dtype, ln_binary_op op,
                         ln_error *err)
{
    if (!out || !(out->flags & LN_ARRAY_WRITEABLE)) {
        iter_error(err, "output array is not writeable");
        return -1;
    }
    ln_binary_plan p;
    if (plan_binary(&p, a, b, out, where, 0, err) < 0) return -1;
    return execute_plan(&p, a, b, out, where, input_dtype_a, input_dtype_b, output_dtype, op, err);
}

ln_array *
ln_nditer_binary_new_ex(const ln_array *a, const ln_array *b,
                        const ln_array *where, const ln_dtype *input_dtype,
                        const ln_dtype *output_dtype, ln_binary_op op,
                        ln_error *err)
{
    return ln_nditer_binary_new_ex2(a,b,where,input_dtype,input_dtype,output_dtype,op,err);
}

int
ln_nditer_binary_into_ex(const ln_array *a, const ln_array *b,
                         ln_array *out, const ln_array *where,
                         const ln_dtype *input_dtype,
                         const ln_dtype *output_dtype, ln_binary_op op,
                         ln_error *err)
{
    return ln_nditer_binary_into_ex2(a,b,out,where,input_dtype,input_dtype,output_dtype,op,err);
}

ln_array *
ln_nditer_binary_new(const ln_array *a, const ln_array *b,
                     const ln_array *where, const ln_dtype *loop_dtype,
                     ln_binary_op op, ln_error *err)
{
    return ln_nditer_binary_new_ex(a, b, where, loop_dtype, loop_dtype, op, err);
}

int
ln_nditer_binary_into(const ln_array *a, const ln_array *b,
                      ln_array *out, const ln_array *where,
                      const ln_dtype *loop_dtype, ln_binary_op op,
                      ln_error *err)
{
    return ln_nditer_binary_into_ex(a, b, out, where, loop_dtype, loop_dtype, op, err);
}
