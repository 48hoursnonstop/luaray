#include "ln_split.h"
#include <string.h>
#include <stdint.h>
#include <stdio.h>

static ln_intp slice_boundary(ln_intp x, ln_intp len)
{
    /* Avoid signed overflow for INTP_MIN, NumPy clips after adding len. */
    if (x < 0) {
        if (x < -len) return 0;
        return len + x;
    }
    return x > len ? len : x;
}

ln_array *ln_split_view(const ln_array *base, int axis,
                        ln_intp start, ln_intp stop, ln_error *err)
{
    if (!base || axis < 0 || axis >= base->nd) {
        if (err) snprintf(err->message, sizeof(err->message), "split axis out of bounds");
        return NULL;
    }
    ln_intp begin = slice_boundary(start, base->dimensions[axis]);
    ln_intp end = slice_boundary(stop, base->dimensions[axis]);
    if (end < begin) end = begin;
    ln_intp dims[LN_MAXDIMS];
    for (int d=0; d<base->nd; ++d) dims[d] = base->dimensions[d];
    dims[axis] = end - begin;
    /* For zero-volume views, the pointer need not be advanced: strides and
     * dimensions fully specify an empty array.  This also avoids invalid
     * pointer arithmetic when another dimension was already zero. */
    char *data = base->data;
    if (ln_array_size(base) > 0 && begin < base->dimensions[axis] && end > begin)
        data += begin * base->strides[axis];
    return ln_array_view(base, base->nd, dims, base->strides, data, err);
}
