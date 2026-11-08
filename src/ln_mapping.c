#include "ln_mapping.h"
#include "ln_dtype_transfer.h"

#include <inttypes.h>
#include <limits.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*
 * Source anchors in NumPy main (pinned by UPSTREAM.md):
 *   numpy/_core/src/multiarray/mapping.c
 *     prepare_index_noarray, get_view_from_index,
 *     array_boolean_subscript, array_assign_boolean_subscript,
 *     mapiter_fill_info, PyArray_MapIterCheckIndices, PyArray_MapIterNew
 *   numpy/_core/src/multiarray/lowlevel_strided_loops.c.src
 *     mapiter_trivial_get/set, mapiter_get/set
 *   numpy/_core/src/multiarray/array_assign_array.c
 *     PyArray_AssignArray broadcasting/overlap behavior
 *
 * This file replaces PyObject/NpyIter machinery with host-neutral ln_array
 * structures while retaining the numerical iteration and result-shape rules.
 */

static void
map_error(ln_error *err, const char *fmt, ...)
{
    if (!err) return;
    va_list ap;
    va_start(ap, fmt);
    vsnprintf(err->message, sizeof(err->message), fmt, ap);
    va_end(ap);
}

static int
is_integer_dtype(const ln_dtype *dt)
{
    return dt && (dt->kind == 'i' || dt->kind == 'u');
}

static int
same_shape(const ln_array *a, const ln_array *b)
{
    if (!a || !b || a->nd != b->nd) return 0;
    for (int i = 0; i < a->nd; ++i) {
        if (a->dimensions[i] != b->dimensions[i]) return 0;
    }
    return 1;
}

static void
advance_coord(int nd, const ln_intp *shape, ln_intp *coord)
{
    for (int i = nd - 1; i >= 0; --i) {
        coord[i]++;
        if (coord[i] < shape[i]) return;
        coord[i] = 0;
    }
}

static char *
coord_ptr(const ln_array *a, const ln_intp *coord)
{
    char *p = a->data;
    for (int i = 0; i < a->nd; ++i) p += coord[i] * a->strides[i];
    return p;
}

static int
shape_product(int nd, const ln_intp *shape, ln_intp *out, ln_error *err)
{
    ln_intp n = 1;
    for (int i = 0; i < nd; ++i) {
        if (shape[i] < 0 || ln_mul_sizes_with_overflow(&n, n, shape[i]) < 0) {
            map_error(err, "advanced indexing operation result is too large");
            return -1;
        }
    }
    *out = n;
    return 0;
}

ln_array *
ln_array_copy_c(const ln_array *src, ln_error *err)
{
    if (!src) {
        map_error(err, "invalid source array");
        return NULL;
    }
    ln_array *ret = ln_array_new(src->nd, src->dimensions, src->descr, 0, 0, err);
    if (!ret) return NULL;

    ln_intp n = ln_array_size(src);
    if (n < 0) {
        ln_array_free(ret);
        map_error(err, "array is too large");
        return NULL;
    }
    ln_intp coord[LN_MAXDIMS] = {0};
    for (ln_intp i = 0; i < n; ++i) {
        char *sp = coord_ptr(src, coord);
        char *dp = ret->data + i * (ln_intp)ret->descr->elsize;
        memcpy(dp, sp, ret->descr->elsize);
        advance_coord(src->nd, src->dimensions, coord);
    }
    return ret;
}

static int
broadcast_source_strides(const ln_array *src, int dst_nd, const ln_intp *dst_shape,
                         ln_intp *out, ln_error *err)
{
    int src_nd = src->nd;
    const ln_intp *src_shape = src->dimensions;
    const ln_intp *src_strides = src->strides;

    /* array_assign_array.c backwards compatibility: drop leading unit dims. */
    while (src_nd > dst_nd && src_shape[0] == 1) {
        --src_nd;
        ++src_shape;
        ++src_strides;
    }
    return ln_broadcast_strides(dst_nd, dst_shape, src_nd, src_shape,
                                src_strides, "input array", out, err);
}

int
ln_array_assign_array(ln_array *dst, const ln_array *src_in, ln_error *err)
{
    if (!dst || !src_in) {
        map_error(err, "invalid array assignment");
        return -1;
    }
    if (!(dst->flags & LN_ARRAY_WRITEABLE)) {
        map_error(err, "assignment destination is read-only");
        return -1;
    }

    const ln_array *src = src_in;
    ln_array *tmp = NULL;
    if (dst->owner && src->owner == dst->owner) {
        tmp = ln_array_copy_c(src, err);
        if (!tmp) return -1;
        src = tmp;
    }

    ln_intp src_bstrides[LN_MAXDIMS] = {0};
    if (broadcast_source_strides(src, dst->nd, dst->dimensions,
                                 src_bstrides, err) < 0) {
        ln_array_free(tmp);
        return -1;
    }

    ln_intp n = ln_array_size(dst);
    if (n < 0) {
        ln_array_free(tmp);
        map_error(err, "array is too large");
        return -1;
    }
    ln_intp coord[LN_MAXDIMS] = {0};
    for (ln_intp i = 0; i < n; ++i) {
        char *dp = dst->data;
        const char *sp = src->data;
        for (int d = 0; d < dst->nd; ++d) {
            dp += coord[d] * dst->strides[d];
            sp += coord[d] * src_bstrides[d];
        }
        if (ln_cast_strided_numeric(sp, 0, src->descr,
                                    dp, 0, dst->descr, 1, err) < 0) {
            ln_array_free(tmp);
            return -1;
        }
        advance_coord(dst->nd, dst->dimensions, coord);
    }
    ln_array_free(tmp);
    return 0;
}

static int
mask_true_at(const ln_array *mask, const ln_intp *coord)
{
    const char *p = mask->data;
    for (int i = 0; i < mask->nd; ++i) p += coord[i] * mask->strides[i];
    return (*(const uint8_t *)p) != 0;
}

static int
count_mask_true(const ln_array *mask, ln_intp *out, ln_error *err)
{
    if (!mask || mask->descr->type_num != LN_BOOL) {
        map_error(err, "boolean indexing requires a boolean index");
        return -1;
    }
    ln_intp n = ln_array_size(mask);
    if (n < 0) {
        map_error(err, "boolean index is too large");
        return -1;
    }
    ln_intp count = 0;
    ln_intp coord[LN_MAXDIMS] = {0};
    for (ln_intp i = 0; i < n; ++i) {
        if (mask_true_at(mask, coord)) count++;
        advance_coord(mask->nd, mask->dimensions, coord);
    }
    *out = count;
    return 0;
}

ln_array *
ln_array_boolean_get(const ln_array *src, const ln_array *mask, ln_error *err)
{
    if (!src || !mask || mask->descr->type_num != LN_BOOL) {
        map_error(err, "boolean indexing requires a boolean index");
        return NULL;
    }
    if (!same_shape(src, mask)) {
        map_error(err, "boolean index did not match indexed array shape");
        return NULL;
    }

    ln_intp count;
    if (count_mask_true(mask, &count, err) < 0) return NULL;
    ln_intp shape[1] = {count};
    ln_array *ret = ln_array_new(1, shape, src->descr, 0, 0, err);
    if (!ret) return NULL;

    ln_intp n = ln_array_size(src);
    ln_intp coord[LN_MAXDIMS] = {0};
    ln_intp out_i = 0;
    for (ln_intp i = 0; i < n; ++i) {
        if (mask_true_at(mask, coord)) {
            const char *sp = coord_ptr(src, coord);
            memcpy(ret->data + out_i * (ln_intp)src->descr->elsize,
                   sp, src->descr->elsize);
            out_i++;
        }
        advance_coord(src->nd, src->dimensions, coord);
    }
    return ret;
}

int
ln_array_boolean_assign_array(ln_array *dst, const ln_array *mask,
                              const ln_array *values_in, ln_error *err)
{
    if (!dst || !mask || !values_in || mask->descr->type_num != LN_BOOL) {
        map_error(err, "boolean indexing assignment requires a boolean index");
        return -1;
    }
    if (!(dst->flags & LN_ARRAY_WRITEABLE)) {
        map_error(err, "assignment destination is read-only");
        return -1;
    }
    if (!same_shape(dst, mask)) {
        map_error(err, "The boolean mask assignment indexing array must have the same shape as the array being indexed");
        return -1;
    }
    if (values_in->nd > 1) {
        map_error(err,
            "boolean array indexing assignment requires a 0 or 1-dimensional input, input has %d dimensions",
            values_in->nd);
        return -1;
    }

    ln_intp count;
    if (count_mask_true(mask, &count, err) < 0) return -1;
    if (values_in->nd == 1 && values_in->dimensions[0] != 1 &&
            values_in->dimensions[0] != count) {
        map_error(err,
            "boolean array indexing assignment cannot assign %" PRIdPTR
            " input values to the %" PRIdPTR " output values where the mask is true",
            (intptr_t)values_in->dimensions[0], (intptr_t)count);
        return -1;
    }

    const ln_array *values = values_in;
    ln_array *tmp = NULL;
    if (dst->owner && values->owner == dst->owner) {
        tmp = ln_array_copy_c(values, err);
        if (!tmp) return -1;
        values = tmp;
    }

    int repeat = values->nd == 0 || (values->nd == 1 && values->dimensions[0] == 1);
    ln_intp n = ln_array_size(dst);
    ln_intp coord[LN_MAXDIMS] = {0};
    ln_intp vi = 0;
    for (ln_intp i = 0; i < n; ++i) {
        if (mask_true_at(mask, coord)) {
            char *dp = coord_ptr(dst, coord);
            const char *sp;
            if (values->nd == 0) sp = values->data;
            else sp = values->data + (repeat ? 0 : vi * values->strides[0]);
            if (ln_cast_strided_numeric(sp, 0, values->descr,
                                        dp, 0, dst->descr, 1, err) < 0) {
                ln_array_free(tmp);
                return -1;
            }
            vi++;
        }
        advance_coord(dst->nd, dst->dimensions, coord);
    }
    ln_array_free(tmp);
    return 0;
}

static ln_array *
make_scalar_for_dtype(const ln_dtype *dt, double v, int64_t vi, int is_integer,
                      ln_error *err)
{
    ln_array *s = ln_array_new(0, NULL, dt, 0, 0, err);
    if (!s) return NULL;
    if (ln_array_pack_number(s, NULL, v, vi, is_integer, err) < 0) {
        ln_array_free(s);
        return NULL;
    }
    return s;
}

int
ln_array_boolean_assign_scalar(ln_array *dst, const ln_array *mask,
                               double v, int64_t vi, int is_integer,
                               ln_error *err)
{
    if (!dst) {
        map_error(err, "invalid assignment destination");
        return -1;
    }
    ln_array *s = make_scalar_for_dtype(dst->descr, v, vi, is_integer, err);
    if (!s) return -1;
    int rc = ln_array_boolean_assign_array(dst, mask, s, err);
    ln_array_free(s);
    return rc;
}

int
ln_boolean_nonzero_indices(const ln_array *mask, ln_array **out_indices,
                           int *out_count, ln_error *err)
{
    if (!mask || !out_indices || !out_count || mask->descr->type_num != LN_BOOL) {
        map_error(err, "nonzero index conversion requires a boolean array");
        return -1;
    }
    if (mask->nd <= 0) {
        map_error(err, "0-D boolean uses the scalar boolean indexing path");
        return -1;
    }

    ln_intp count;
    if (count_mask_true(mask, &count, err) < 0) return -1;
    const ln_dtype *intp_dtype = ln_dtype_by_name(sizeof(ln_intp) == 8 ? "int64" : "int32");
    if (!intp_dtype) {
        map_error(err, "platform index dtype unavailable");
        return -1;
    }
    ln_intp shape[1] = {count};
    for (int axis = 0; axis < mask->nd; ++axis) {
        out_indices[axis] = ln_array_new(1, shape, intp_dtype, 0, 0, err);
        if (!out_indices[axis]) {
            for (int j = 0; j < axis; ++j) ln_array_free(out_indices[j]);
            return -1;
        }
    }

    ln_intp n = ln_array_size(mask);
    ln_intp coord[LN_MAXDIMS] = {0};
    ln_intp pos = 0;
    for (ln_intp i = 0; i < n; ++i) {
        if (mask_true_at(mask, coord)) {
            for (int axis = 0; axis < mask->nd; ++axis) {
                ln_intp q[1] = {pos};
                /* Generated indices use Lua's 1-based positive convention. */
                int64_t lua_index = (int64_t)coord[axis] + 1;
                if (ln_array_pack_number(out_indices[axis], q,
                                         (double)lua_index, lua_index, 1, err) < 0) {
                    for (int j = 0; j < mask->nd; ++j) ln_array_free(out_indices[j]);
                    return -1;
                }
            }
            pos++;
        }
        advance_coord(mask->nd, mask->dimensions, coord);
    }
    *out_count = mask->nd;
    return 0;
}

static int
store_signed_index(intmax_t x, ln_intp *out, ln_error *err)
{
    if (x < (intmax_t)INTPTR_MIN || x > (intmax_t)INTPTR_MAX) {
        map_error(err, "index value is outside platform intp range");
        return -1;
    }
    *out = (ln_intp)x;
    return 0;
}

static int
store_unsigned_index(uintmax_t x, ln_intp *out, ln_error *err)
{
    if (x > (uintmax_t)INTPTR_MAX) {
        map_error(err, "index value is outside platform intp range");
        return -1;
    }
    *out = (ln_intp)x;
    return 0;
}

static int
read_integer_at_ptr(const char *p, const ln_dtype *dt, ln_intp *out,
                    ln_error *err)
{
    if (!dt || !is_integer_dtype(dt)) {
        map_error(err, "arrays used as indices must be of integer (or boolean) type");
        return -1;
    }
#define READ_SIGNED(T) do { T x; memcpy(&x,p,sizeof(x)); \
    return store_signed_index((intmax_t)x,out,err); } while(0)
#define READ_UNSIGNED(T) do { T x; memcpy(&x,p,sizeof(x)); \
    return store_unsigned_index((uintmax_t)x,out,err); } while(0)
    switch (dt->type_num) {
        case LN_BYTE: READ_SIGNED(int8_t);
        case LN_UBYTE: READ_UNSIGNED(uint8_t);
        case LN_SHORT: READ_SIGNED(int16_t);
        case LN_USHORT: READ_UNSIGNED(uint16_t);
        case LN_INT: READ_SIGNED(int32_t);
        case LN_UINT: READ_UNSIGNED(uint32_t);
        case LN_LONG: READ_SIGNED(long);
        case LN_ULONG: READ_UNSIGNED(unsigned long);
        case LN_LONGLONG: READ_SIGNED(long long);
        case LN_ULONGLONG: READ_UNSIGNED(unsigned long long);
        default:
            map_error(err, "arrays used as indices must be of integer (or boolean) type");
            return -1;
    }
#undef READ_SIGNED
#undef READ_UNSIGNED
}

static int
normalize_fancy_value(ln_intp raw, ln_intp dim, int axis, ln_intp *out,
                      ln_error *err)
{
    ln_intp x;
    if (raw > 0) x = raw - 1;
    else if (raw < 0) x = dim + raw;
    else {
        map_error(err, "index 0 is invalid in Lua's 1-based indexing model");
        return -1;
    }
    if (x < 0 || x >= dim) {
        map_error(err, "index %" PRIdPTR " is out of bounds for axis %d with size %" PRIdPTR,
                  (intptr_t)raw, axis + 1, (intptr_t)dim);
        return -1;
    }
    *out = x;
    return 0;
}

typedef struct ln_map_plan {
    const ln_array *array;
    int num_fancy;
    int nd_fancy;
    int sub_nd;
    int out_nd;
    int consec;
    char *baseoffset;

    const ln_array *fancy_arrays[LN_MAXDIMS];
    int fancy_axes[LN_MAXDIMS];
    ln_intp fancy_dims[LN_MAXDIMS];
    ln_intp fancy_strides[LN_MAXDIMS];
    ln_intp fancy_bstrides[LN_MAXDIMS][LN_MAXDIMS];
    ln_intp fancy_shape[LN_MAXDIMS];

    ln_intp sub_shape[LN_MAXDIMS];
    ln_intp sub_strides[LN_MAXDIMS];

    ln_intp out_shape[LN_MAXDIMS];
    ln_intp out_strides[LN_MAXDIMS];
} ln_map_plan;

typedef struct ln_stride_item {
    int perm;
    ln_intp stride;
} ln_stride_item;

/* Port of shape.c:_npy_stride_sort_item_comparator /
 * PyArray_CreateSortedStridePerm: descending absolute stride, stable by axis. */
static int
stride_item_cmp(const void *va, const void *vb)
{
    const ln_stride_item *a = (const ln_stride_item *)va;
    const ln_stride_item *b = (const ln_stride_item *)vb;
    ln_intp as = a->stride < 0 ? -a->stride : a->stride;
    ln_intp bs = b->stride < 0 ? -b->stride : b->stride;
    if (as == bs) return a->perm < b->perm ? -1 : 1;
    return as > bs ? -1 : 1;
}

/* nditer_constr.c:npyiter_find_best_axis_ordering. Order is fastest first;
 * only nonzero operand strides resolve ties, with C-order winning conflicts. */
static uintmax_t stride_magnitude(ln_intp stride)
{ return stride<0?(uintmax_t)(-(stride+1))+1:(uintmax_t)stride; }

static void mapiter_order(const ln_map_plan *p,const ln_intp *values_strides,
                          int *order,int *flipped)
{
    int nd=p->nd_fancy,nops=p->num_fancy+(values_strides!=NULL);
    for(int d=0;d<nd;++d) {
        order[d]=nd-1-d;flipped[d]=0;
        int negative=0,positive=0;
        for(int op=0;op<nops;++op) {
            ln_intp stride=op<p->num_fancy?p->fancy_bstrides[op][d]:values_strides[d];
            negative|=stride<0;positive|=stride>0;
        }
        if(!(p->num_fancy==1 && p->fancy_arrays[0]->nd==1))flipped[d]=negative&&!positive;
    }
    for(int i=1;i<nd;++i) {
        int candidate=order[i],pos=i;
        for(int j=i-1;j>=0;--j) {
            int ambig=1,swap=0,previous=order[j];
            for(int op=0;op<nops;++op) {
                ln_intp a=op<p->num_fancy?p->fancy_bstrides[op][candidate]:values_strides[candidate];
                ln_intp b=op<p->num_fancy?p->fancy_bstrides[op][previous]:values_strides[previous];
                if(a && b) {
                    if(stride_magnitude(b)<=stride_magnitude(a))swap=0;
                    else if(ambig)swap=1;
                    ambig=0;
                }
            }
            if(!ambig) { if(swap)pos=j;else break; }
        }
        for(int j=i;j>pos;--j)order[j]=order[j-1];
        order[pos]=candidate;
    }
}

static void mapiter_advance(const ln_map_plan *p,const int *order,
                            const int *flipped,ln_intp *coord)
{
    for(int j=0;j<p->nd_fancy;++j) {
        int d=order[j];
        coord[d]+=flipped[d]?-1:1;
        if(coord[d]>=0 && coord[d]<p->fancy_shape[d])break;
        coord[d]=flipped[d]?p->fancy_shape[d]-1:0;
    }
}

/*
 * Port of mapping.c:PyArray_MapIterNew output allocation for the common
 * `subspace != NULL && PyArray_SIZE(subspace) > 1` branch.  NumPy does not
 * simply allocate a C-contiguous result here: the advanced block is C-ordered
 * while the subspace axes are laid out according to their original stride
 * ordering.  Singleton/newaxis strides therefore retain the characteristic
 * itemsize stride visible in NumPy results.
 */
static ln_array *
allocate_mapiter_internal(const ln_map_plan *p, const ln_dtype *dtype,
                          ln_error *err)
{
    ln_intp shape[LN_MAXDIMS];
    ln_intp strides[LN_MAXDIMS];
    int nd = 0;
    for (int i = 0; i < p->nd_fancy; ++i) shape[nd++] = p->fancy_shape[i];
    for (int i = 0; i < p->sub_nd; ++i) shape[nd++] = p->sub_shape[i];

    ln_intp subsize = 1;
    if (shape_product(p->sub_nd, p->sub_shape, &subsize, err) < 0) return NULL;

    if (subsize > 1) {
        ln_intp stride = (ln_intp)dtype->elsize * subsize;
        for (int i = p->nd_fancy - 1; i >= 0; --i) {
            strides[i] = stride;
            if (ln_mul_sizes_with_overflow(&stride, stride, p->fancy_shape[i]) < 0) {
                map_error(err, "advanced indexing operation result is too large");
                return NULL;
            }
        }

        ln_stride_item perm[LN_MAXDIMS];
        for (int i = 0; i < p->sub_nd; ++i) {
            perm[i].perm = i;
            perm[i].stride = p->sub_strides[i];
        }
        qsort(perm, (size_t)p->sub_nd, sizeof(perm[0]), stride_item_cmp);
        stride = (ln_intp)dtype->elsize;
        for (int i = p->sub_nd - 1; i >= 0; --i) {
            int axis = perm[i].perm;
            strides[p->nd_fancy + axis] = stride;
            if (ln_mul_sizes_with_overflow(&stride, stride, p->sub_shape[axis]) < 0) {
                map_error(err, "advanced indexing operation result is too large");
                return NULL;
            }
        }
    }
    else {
        int order[LN_MAXDIMS],flipped[LN_MAXDIMS];
        mapiter_order(p,NULL,order,flipped);
        ln_intp stride=(ln_intp)dtype->elsize;
        for(int d=p->nd_fancy;d<nd;++d)strides[d]=stride;
        for(int i=0;i<p->nd_fancy;++i) {
            int d=order[i];strides[d]=stride;
            if(ln_mul_sizes_with_overflow(&stride,stride,shape[d])<0) {
                map_error(err,"advanced indexing operation result is too large");return NULL;
            }
        }
    }

    ln_array *storage = ln_array_new(nd, shape, dtype, 0, 0, err);
    if (!storage) return NULL;
    if (ln_array_size(storage) == 0) {
        for (int i = 0; i < nd; ++i) strides[i] = 0;
    }
    ln_array *view = ln_array_view(storage, nd, shape, strides, storage->data, err);
    ln_array_free(storage);
    return view;
}

static int
plan_build(const ln_array *a, const ln_index *indices, int index_num,
           ln_map_plan *p, ln_error *err)
{
    memset(p, 0, sizeof(*p));
    p->array = a;
    p->baseoffset = a->data;

    int curr_dim = 0;
    int result_dim = 0;
    int consec_status = -1;

    /* Determine the broadcast rank first, matching prepare_index's fancy_ndim. */
    for (int i = 0; i < index_num; ++i) {
        if (indices[i].kind == LN_INDEX_FANCY || indices[i].kind == LN_INDEX_0D_BOOL) {
            if (!indices[i].array) {
                map_error(err, "missing advanced index array");
                return -1;
            }
            if (indices[i].array->nd > p->nd_fancy) p->nd_fancy = indices[i].array->nd;
        }
    }
    if (p->nd_fancy <= 0) {
        map_error(err, "advanced index operation has no advanced indices");
        return -1;
    }
    for (int i = 0; i < p->nd_fancy; ++i) p->fancy_shape[i] = 1;

    for (int i = 0; i < index_num; ++i) {
        const ln_index *ix = &indices[i];
        int advanced_like = (ix->kind == LN_INDEX_FANCY ||
                             ix->kind == LN_INDEX_0D_BOOL ||
                             ix->kind == LN_INDEX_INTEGER);
        if (advanced_like) {
            if (consec_status == -1) {
                p->consec = result_dim;
                consec_status = 0;
            }
            else if (consec_status == 1) {
                consec_status = 2;
                p->consec = 0;
            }
        }
        else if (consec_status == 0) {
            consec_status = 1;
        }

        switch (ix->kind) {
            case LN_INDEX_INTEGER:
                if (curr_dim >= a->nd || ix->value < 0 || ix->value >= a->dimensions[curr_dim]) {
                    map_error(err, "index out of bounds");
                    return -1;
                }
                p->baseoffset += ix->value * a->strides[curr_dim];
                curr_dim++;
                /* mapiter_fill_info counts integer positions for consec bookkeeping. */
                result_dim++;
                break;

            case LN_INDEX_SLICE:
                if (curr_dim >= a->nd || p->sub_nd >= LN_MAXDIMS) {
                    map_error(err, "too many indices for array");
                    return -1;
                }
                if (ix->length > 0) p->baseoffset += ix->start * a->strides[curr_dim];
                p->sub_shape[p->sub_nd] = ix->length;
                p->sub_strides[p->sub_nd] = a->strides[curr_dim] * ix->step;
                p->sub_nd++;
                curr_dim++;
                result_dim++;
                break;

            case LN_INDEX_ELLIPSIS:
                for (ln_intp k = 0; k < ix->value; ++k) {
                    if (curr_dim >= a->nd || p->sub_nd >= LN_MAXDIMS) {
                        map_error(err, "invalid ellipsis expansion");
                        return -1;
                    }
                    p->sub_shape[p->sub_nd] = a->dimensions[curr_dim];
                    p->sub_strides[p->sub_nd] = a->strides[curr_dim];
                    p->sub_nd++;
                    curr_dim++;
                    result_dim++;
                }
                break;

            case LN_INDEX_NEWAXIS:
                if (p->sub_nd >= LN_MAXDIMS) {
                    map_error(err, "number of dimensions must be within [0, %d]", LN_MAXDIMS);
                    return -1;
                }
                p->sub_shape[p->sub_nd] = 1;
                p->sub_strides[p->sub_nd] = 0;
                p->sub_nd++;
                result_dim++;
                break;

            case LN_INDEX_FANCY:
            case LN_INDEX_0D_BOOL: {
                if (p->num_fancy >= LN_MAXDIMS) {
                    map_error(err, "too many advanced (array) indices");
                    return -1;
                }
                const ln_array *ind = ix->array;
                if (!is_integer_dtype(ind->descr)) {
                    map_error(err, "arrays used as indices must be of integer (or boolean) type");
                    return -1;
                }
                int j = p->num_fancy++;
                p->fancy_arrays[j] = ind;
                if (ix->kind == LN_INDEX_0D_BOOL) {
                    p->fancy_axes[j] = -1;
                    p->fancy_dims[j] = 1;
                    p->fancy_strides[j] = 0;
                }
                else {
                    if (curr_dim >= a->nd) {
                        map_error(err, "too many indices for array");
                        return -1;
                    }
                    if (ix->boolean_axis_size >= 0 &&
                            ix->boolean_axis_size != a->dimensions[curr_dim]) {
                        map_error(err,
                            "boolean index did not match indexed array along axis %d; size of axis is %" PRIdPTR
                            " but size of corresponding boolean axis is %" PRIdPTR,
                            curr_dim + 1, (intptr_t)a->dimensions[curr_dim],
                            (intptr_t)ix->boolean_axis_size);
                        return -1;
                    }
                    p->fancy_axes[j] = curr_dim;
                    p->fancy_dims[j] = a->dimensions[curr_dim];
                    p->fancy_strides[j] = a->strides[curr_dim];
                    curr_dim++;
                }

                int baxis = p->nd_fancy;
                for (int axis = ind->nd - 1; axis >= 0; --axis) {
                    --baxis;
                    ln_intp dim = ind->dimensions[axis];
                    if (dim != 1) {
                        if (p->fancy_shape[baxis] != 1 && p->fancy_shape[baxis] != dim) {
                            map_error(err, "shape mismatch: indexing arrays could not be broadcast together");
                            return -1;
                        }
                        p->fancy_shape[baxis] = dim;
                    }
                }
                break;
            }

            default:
                map_error(err, "unsupported index kind");
                return -1;
        }
    }

    if (curr_dim != a->nd) {
        map_error(err, "index did not consume all array dimensions");
        return -1;
    }

    for (int j = 0; j < p->num_fancy; ++j) {
        if (ln_broadcast_strides(p->nd_fancy, p->fancy_shape,
                p->fancy_arrays[j]->nd, p->fancy_arrays[j]->dimensions,
                p->fancy_arrays[j]->strides, "indexing array",
                p->fancy_bstrides[j], err) < 0) {
            map_error(err, "shape mismatch: indexing arrays could not be broadcast together");
            return -1;
        }
    }

    p->out_nd = p->nd_fancy + p->sub_nd;
    if (p->out_nd > LN_MAXDIMS) {
        map_error(err, "number of dimensions must be within [0, %d]", LN_MAXDIMS);
        return -1;
    }

    int od = 0;
    if (p->consec > 0) {
        if (p->consec > p->sub_nd) {
            map_error(err, "internal advanced-index axis placement error");
            return -1;
        }
        for (int i = 0; i < p->consec; ++i) p->out_shape[od++] = p->sub_shape[i];
        for (int i = 0; i < p->nd_fancy; ++i) p->out_shape[od++] = p->fancy_shape[i];
        for (int i = p->consec; i < p->sub_nd; ++i) p->out_shape[od++] = p->sub_shape[i];
    }
    else {
        for (int i = 0; i < p->nd_fancy; ++i) p->out_shape[od++] = p->fancy_shape[i];
        for (int i = 0; i < p->sub_nd; ++i) p->out_shape[od++] = p->sub_shape[i];
    }
    return 0;
}

static int
fancy_pointer(const ln_map_plan *p, int j, const ln_intp *fcoord,
              char **out_ptr, ln_error *err)
{
    const ln_array *ind = p->fancy_arrays[j];
    const char *ip = ind->data;
    for (int d = 0; d < p->nd_fancy; ++d) ip += fcoord[d] * p->fancy_bstrides[j][d];
    ln_intp raw;
    if (read_integer_at_ptr(ip, ind->descr, &raw, err) < 0) return -1;
    ln_intp normalized;
    if (normalize_fancy_value(raw, p->fancy_dims[j],
                              p->fancy_axes[j] < 0 ? 0 : p->fancy_axes[j],
                              &normalized, err) < 0) return -1;
    *out_ptr += normalized * p->fancy_strides[j];
    return 0;
}

static int
check_fancy_bounds(const ln_map_plan *p, ln_error *err)
{
    ln_intp ftotal;
    if (shape_product(p->nd_fancy, p->fancy_shape, &ftotal, err) < 0) return -1;
    if (ftotal == 0) return 0;  /* Matches PyArray_MapIterCheckIndices. */

    ln_intp fcoord[LN_MAXDIMS] = {0};
    for (ln_intp n = 0; n < ftotal; ++n) {
        for (int j = 0; j < p->num_fancy; ++j) {
            char *dummy = NULL;
            /* Avoid pointer arithmetic on NULL: use baseoffset then discard. */
            dummy = p->baseoffset;
            if (fancy_pointer(p, j, fcoord, &dummy, err) < 0) return -1;
        }
        advance_coord(p->nd_fancy, p->fancy_shape, fcoord);
    }
    return 0;
}

static const char *
source_ptr_for_internal(const ln_map_plan *p, const ln_array *src,
                        const ln_intp *src_bstrides,
                        const ln_intp *fcoord, const ln_intp *scoord)
{
    const char *sp = src->data;
    if (p->consec > 0) {
        for (int i = 0; i < p->consec; ++i) sp += scoord[i] * src_bstrides[i];
        for (int i = 0; i < p->nd_fancy; ++i) sp += fcoord[i] * src_bstrides[p->consec + i];
        for (int i = p->consec; i < p->sub_nd; ++i) {
            int od = p->consec + p->nd_fancy + (i - p->consec);
            sp += scoord[i] * src_bstrides[od];
        }
    }
    else {
        for (int i = 0; i < p->nd_fancy; ++i) sp += fcoord[i] * src_bstrides[i];
        for (int i = 0; i < p->sub_nd; ++i) sp += scoord[i] * src_bstrides[p->nd_fancy + i];
    }
    return sp;
}

ln_array *
ln_array_advanced_get(const ln_array *src, const ln_index *indices,
                      int index_num, ln_error *err)
{
    if (!src || !indices || index_num <= 0) {
        map_error(err, "invalid advanced index");
        return NULL;
    }
    ln_map_plan p;
    if (plan_build(src, indices, index_num, &p, err) < 0) return NULL;
    if (check_fancy_bounds(&p, err) < 0) return NULL;

    /*
     * MapIter always allocates/iterates the advanced axes first, followed by
     * the basic-index subspace.  When advanced indices are consecutive,
     * PyArray_MapIterSwapAxes returns a transposed view that reinserts those
     * axes at `consec`.  Allocate in that internal order so the returned
     * strides/contiguity match NumPy instead of merely matching values.
     */
    int fortran_fast = 0;
    /* mapping.c:mapiter_trivial_get preserves the index memory order only for
     * the exact one-dimensional-source / one-fancy-index fast path. */
    if (src->nd == 1 && index_num == 1 && p.num_fancy == 1 && p.sub_nd == 0) {
        const ln_array *ind = p.fancy_arrays[0];
        if ((ind->flags & LN_ARRAY_F_CONTIGUOUS) && !(ind->flags & LN_ARRAY_C_CONTIGUOUS)) {
            fortran_fast = 1;
        }
    }

    ln_array *internal;
    if (fortran_fast) {
        ln_intp internal_shape[LN_MAXDIMS];
        int id = 0;
        for (int i = 0; i < p.nd_fancy; ++i) internal_shape[id++] = p.fancy_shape[i];
        for (int i = 0; i < p.sub_nd; ++i) internal_shape[id++] = p.sub_shape[i];
        internal = ln_array_new(p.out_nd, internal_shape, src->descr, 1, 0, err);
    }
    else {
        internal = allocate_mapiter_internal(&p, src->descr, err);
    }
    if (!internal) return NULL;

    ln_intp ftotal, stotal;
    if (shape_product(p.nd_fancy, p.fancy_shape, &ftotal, err) < 0 ||
            shape_product(p.sub_nd, p.sub_shape, &stotal, err) < 0) {
        ln_array_free(internal);
        return NULL;
    }
    if (ftotal == 0 || stotal == 0) {
        if (p.consec == 0) return internal;
        ln_intp final_strides[LN_MAXDIMS];
        int od = 0;
        for (int i = 0; i < p.consec; ++i) final_strides[od++] = internal->strides[p.nd_fancy + i];
        for (int i = 0; i < p.nd_fancy; ++i) final_strides[od++] = internal->strides[i];
        for (int i = p.consec; i < p.sub_nd; ++i) final_strides[od++] = internal->strides[p.nd_fancy + i];
        ln_array *view = ln_array_view(internal,p.out_nd,p.out_shape,final_strides,internal->data,err);
        ln_array_free(internal);
        return view;
    }

    ln_intp fcoord[LN_MAXDIMS] = {0};
    for (ln_intp fi = 0; fi < ftotal; ++fi) {
        char *fbase = p.baseoffset;
        for (int j = 0; j < p.num_fancy; ++j) {
            if (fancy_pointer(&p, j, fcoord, &fbase, err) < 0) {
                ln_array_free(internal);
                return NULL;
            }
        }

        ln_intp scoord[LN_MAXDIMS] = {0};
        for (ln_intp si = 0; si < stotal; ++si) {
            const char *sp = fbase;
            for (int d = 0; d < p.sub_nd; ++d) sp += scoord[d] * p.sub_strides[d];
            char *dp = internal->data;
            for (int d = 0; d < p.nd_fancy; ++d) dp += fcoord[d] * internal->strides[d];
            for (int d = 0; d < p.sub_nd; ++d) dp += scoord[d] * internal->strides[p.nd_fancy + d];
            memcpy(dp, sp, src->descr->elsize);
            advance_coord(p.sub_nd, p.sub_shape, scoord);
        }
        advance_coord(p.nd_fancy, p.fancy_shape, fcoord);
    }
    if (p.consec == 0) return internal;

    ln_intp final_strides[LN_MAXDIMS];
    int od = 0;
    for (int i = 0; i < p.consec; ++i) final_strides[od++] = internal->strides[p.nd_fancy + i];
    for (int i = 0; i < p.nd_fancy; ++i) final_strides[od++] = internal->strides[i];
    for (int i = p.consec; i < p.sub_nd; ++i) final_strides[od++] = internal->strides[p.nd_fancy + i];
    ln_array *view = ln_array_view(internal,p.out_nd,p.out_shape,final_strides,internal->data,err);
    ln_array_free(internal);
    return view;
}

static int
advanced_assign_prepared(ln_array *dst, const ln_index *indices,
                               int index_num, const ln_array *values_in,
                               ln_error *err)
{
    if (!dst || !indices || !values_in || index_num <= 0) {
        map_error(err, "invalid advanced index assignment");
        return -1;
    }
    if (!(dst->flags & LN_ARRAY_WRITEABLE)) {
        map_error(err, "assignment destination is read-only");
        return -1;
    }

    ln_map_plan p;
    if (plan_build(dst, indices, index_num, &p, err) < 0) return -1;
    if (check_fancy_bounds(&p, err) < 0) return -1;

    const ln_array *values = values_in;
    ln_array *tmp = NULL;
    if (dst->owner && values->owner == dst->owner) {
        tmp = ln_array_copy_c(values, err);
        if (!tmp) return -1;
        values = tmp;
    }

    ln_intp src_bstrides[LN_MAXDIMS] = {0};
    if (broadcast_source_strides(values, p.out_nd, p.out_shape,
                                 src_bstrides, err) < 0) {
        ln_array_free(tmp);
        /* Match mapping.c's assignment-oriented error wording. */
        if (err && err->message[0]) {
            char original[sizeof(err->message)];
            snprintf(original, sizeof(original), "%s", err->message);
            map_error(err, "shape mismatch: value array could not be broadcast to indexing result (%s)", original);
        }
        return -1;
    }

    ln_intp ftotal, stotal;
    if (shape_product(p.nd_fancy, p.fancy_shape, &ftotal, err) < 0 ||
            shape_product(p.sub_nd, p.sub_shape, &stotal, err) < 0) {
        ln_array_free(tmp);
        return -1;
    }
    if (ftotal == 0 || stotal == 0) {
        ln_array_free(tmp);
        return 0;
    }

    if(p.sub_nd==0) {
        int order[LN_MAXDIMS],flipped[LN_MAXDIMS];
        mapiter_order(&p,src_bstrides,order,flipped);
        ln_intp coord[LN_MAXDIMS]={0};
        for(int d=0;d<p.nd_fancy;++d)if(flipped[d])coord[d]=p.fancy_shape[d]-1;
        int cast=values->descr!=dst->descr;
        ln_intp capacity=ftotal<8192?ftotal:8192;
        ln_array *buffer=cast?ln_array_new(1,&capacity,dst->descr,0,0,err):NULL;
        if(cast && !buffer){ln_array_free(tmp);return -1;}
        for(ln_intp start=0;start<ftotal;) {
            ln_intp count=ftotal-start<capacity?ftotal-start:capacity;
            if(cast) {
                ln_intp readcoord[LN_MAXDIMS];memcpy(readcoord,coord,sizeof(coord));
                for(ln_intp k=0;k<count;++k) {
                    const char *sp=source_ptr_for_internal(&p,values,src_bstrides,readcoord,NULL);
                    if(ln_cast_strided_numeric(sp,0,values->descr,
                            buffer->data+(size_t)k*dst->descr->elsize,0,dst->descr,1,err)<0) {
                        ln_array_free(buffer);ln_array_free(tmp);return -1;
                    }
                    mapiter_advance(&p,order,flipped,readcoord);
                }
            }
            for(ln_intp k=0;k<count;++k) {
                char *dp=p.baseoffset;
                for(int j=0;j<p.num_fancy;++j)if(fancy_pointer(&p,j,coord,&dp,err)<0) {
                    ln_array_free(buffer);ln_array_free(tmp);return -1;
                }
                const char *sp=cast?buffer->data+(size_t)k*dst->descr->elsize:
                    source_ptr_for_internal(&p,values,src_bstrides,coord,NULL);
                memmove(dp,sp,dst->descr->elsize);
                mapiter_advance(&p,order,flipped,coord);
            }
            start+=count;
        }
        ln_array_free(buffer);ln_array_free(tmp);return 0;
    }

    ln_intp fcoord[LN_MAXDIMS] = {0};
    for (ln_intp fi = 0; fi < ftotal; ++fi) {
        char *fbase = p.baseoffset;
        for (int j = 0; j < p.num_fancy; ++j) {
            if (fancy_pointer(&p, j, fcoord, &fbase, err) < 0) {
                ln_array_free(tmp);
                return -1;
            }
        }

        ln_intp scoord[LN_MAXDIMS] = {0};
        for (ln_intp si = 0; si < stotal; ++si) {
            char *dp = fbase;
            for (int d = 0; d < p.sub_nd; ++d) dp += scoord[d] * p.sub_strides[d];
            const char *sp = source_ptr_for_internal(&p, values, src_bstrides,
                                                     fcoord, scoord);
            if (ln_cast_strided_numeric(sp, 0, values->descr,
                                        dp, 0, dst->descr, 1, err) < 0) {
                ln_array_free(tmp);
                return -1;
            }
            advance_coord(p.sub_nd, p.sub_shape, scoord);
        }
        advance_coord(p.nd_fancy, p.fancy_shape, fcoord);
    }
    ln_array_free(tmp);
    return 0;
}

int
ln_array_advanced_assign_array(ln_array *dst,const ln_index *indices,
                               int index_num,const ln_array *values,ln_error *err)
{
    if(index_num>LN_MAXDIMS*2+1) {
        map_error(err,"too many advanced indices");return -1;
    }
    if(!dst || !indices || index_num<=0)
        return advanced_assign_prepared(dst,indices,index_num,values,err);
    ln_index prepared[LN_MAXDIMS*2+1];ln_array *copies[LN_MAXDIMS*2+1]={0};
    memcpy(prepared,indices,(size_t)index_num*sizeof(*indices));
    int rc=-1;
    for(int j=0;j<index_num;++j) {
        const ln_array *ind=indices[j].array;
        if((indices[j].kind==LN_INDEX_FANCY || indices[j].kind==LN_INDEX_0D_BOOL) &&
           ind && dst->owner && ind->owner==dst->owner) {
            copies[j]=ln_array_copy_c(ind,err);
            if(!copies[j])goto done;
            prepared[j].array=copies[j];
        }
    }
    rc=advanced_assign_prepared(dst,prepared,index_num,values,err);
done:
    for(int j=0;j<index_num;++j)ln_array_free(copies[j]);
    return rc;
}

int
ln_array_advanced_assign_scalar(ln_array *dst, const ln_index *indices,
                                int index_num, double v, int64_t vi,
                                int is_integer, ln_error *err)
{
    if (!dst) {
        map_error(err, "invalid assignment destination");
        return -1;
    }
    ln_array *s = make_scalar_for_dtype(dst->descr, v, vi, is_integer, err);
    if (!s) return -1;
    int rc = ln_array_advanced_assign_array(dst, indices, index_num, s, err);
    ln_array_free(s);
    return rc;
}
