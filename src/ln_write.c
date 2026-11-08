/* Source-derived from NumPy 2.5.3 item_selection.c:PyArray_PutTo and
 * compiled_base.c:arr_place. See NUMPY_2_5_3_WRITE98_FILE_HASHES.sha256. */
#include "ln_write.h"
#include "ln_mapping.h"
#include <stdint.h>
#include <stdio.h>
#include <string.h>

static int bad(ln_error *err, const char *message)
{
    if (err) snprintf(err->message, sizeof(err->message), "%s", message);
    return -1;
}

static int prepared(const ln_array *a)
{
    return a && (a->flags & LN_ARRAY_C_CONTIGUOUS) && ln_array_size(a) >= 0;
}

/* These operands are contiguous, so their byte intervals determine overlap
 * exactly. Merely sharing an owner does not imply overlapping storage. */
static int overlaps(const ln_array *a, const ln_array *b)
{
    if (!a->owner || a->owner != b->owner) return 0;
    uintptr_t ap = (uintptr_t)a->data, bp = (uintptr_t)b->data;
    size_t an = (size_t)ln_array_size(a) * a->descr->elsize;
    size_t bn = (size_t)ln_array_size(b) * b->descr->elsize;
    return an && bn && (ap <= bp ? bp - ap < an : ap - bp < bn);
}

static void writeback(ln_array *dst, const ln_array *src)
{
    ln_intp coord[LN_MAXDIMS] = {0}, count = ln_array_size(dst);
    size_t width = dst->descr->elsize;
    for (ln_intp i = 0; i < count; ++i) {
        char *p = dst->data;
        for (int d = 0; d < dst->nd; ++d) p += coord[d] * dst->strides[d];
        memcpy(p, src->data + (size_t)i * width, width);
        for (int d = dst->nd - 1; d >= 0; --d) {
            if (++coord[d] < dst->dimensions[d]) break;
            coord[d] = 0;
        }
    }
}

int ln_array_put(ln_array *dst, const ln_array *indices, const ln_array *values,
                 ln_put_mode mode, ln_error *err)
{
    if (!dst || !prepared(indices) || !prepared(values) ||
        indices->descr->kind != 'i' || indices->descr->elsize != sizeof(ln_intp) ||
        values->descr != dst->descr || mode < LN_PUT_RAISE || mode > LN_PUT_CLIP)
        return bad(err, "invalid prepared put operands");
    if (!(dst->flags & LN_ARRAY_WRITEABLE)) return bad(err, "put destination is read-only");
    ln_intp size = ln_array_size(dst), ni = ln_array_size(indices), nv = ln_array_size(values);
    if (size < 0) return bad(err, "put destination is too large");
    if (ni && !size) return bad(err, "cannot replace elements of an empty array");
    if (!nv) return 0;

    ln_array *copy = NULL, *work = dst;
    if (!(dst->flags & LN_ARRAY_C_CONTIGUOUS) || overlaps(dst, indices) || overlaps(dst, values)) {
        copy = ln_array_copy_c(dst, err);
        if (!copy) return -1;
        work = copy;
    }
    size_t width = dst->descr->elsize;
    for (ln_intp i = 0; i < ni; ++i) {
        ln_intp raw, index;
        memcpy(&raw, indices->data + (size_t)i * sizeof(raw), sizeof(raw));
        if (!raw) {
            ln_array_free(copy);
            return bad(err, "index 0 is invalid in Lua's 1-based indexing model");
        }
        index = raw > 0 ? raw - 1 : raw;
        if (mode == LN_PUT_RAISE) {
            if (index < 0) index += size;
            if (index < 0 || index >= size) {
                ln_array_free(copy);
                return bad(err, "put index out of bounds");
            }
        }
        else if (mode == LN_PUT_WRAP) {
            index %= size;
            if (index < 0) index += size;
        }
        else {
            if (index < 0) index = 0;
            else if (index >= size) index = size - 1;
        }
        memmove(work->data + (size_t)index * width,
                values->data + (size_t)(i % nv) * width, width);
    }
    if (copy) { writeback(dst, copy); ln_array_free(copy); }
    return 0;
}

int ln_array_place(ln_array *dst, const ln_array *mask, const ln_array *values,
                   ln_error *err)
{
    if (!dst || !prepared(mask) || !prepared(values) ||
        mask->descr->type_num != LN_BOOL || values->descr != dst->descr)
        return bad(err, "invalid prepared place operands");
    if (!(dst->flags & LN_ARRAY_WRITEABLE)) return bad(err, "place destination is read-only");
    ln_intp size = ln_array_size(dst), nm = ln_array_size(mask), nv = ln_array_size(values);
    if (size < 0 || size != nm) return bad(err, "place mask and data must be the same size");
    if (!nv) {
        for (ln_intp i = 0; i < size; ++i)
            if ((unsigned char)mask->data[i]) return bad(err, "cannot insert from an empty array");
        return 0;
    }
    ln_array *copy = NULL, *work = dst;
    if (!(dst->flags & LN_ARRAY_C_CONTIGUOUS)) {
        copy = ln_array_copy_c(dst, err);
        if (!copy) return -1;
        work = copy;
    }
    /* Unlike put, upstream place intentionally reads contiguous aliased values
     * live. The value index advances only for selected positions. */
    size_t width = dst->descr->elsize;
    ln_intp j = 0;
    for (ln_intp i = 0; i < size; ++i) {
        if ((unsigned char)mask->data[i]) {
            memmove(work->data + (size_t)i * width, values->data + (size_t)j * width, width);
            if (++j == nv) j = 0;
        }
    }
    if (copy) { writeback(dst, copy); ln_array_free(copy); }
    return 0;
}
