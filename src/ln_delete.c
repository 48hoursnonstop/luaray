/* Native array deletion, modeled on NumPy 2.5.3 function_base.py:delete.
 * No Python dependency. Copy raw fixed-width DType payloads across arbitrary
 * strides, retaining exact Unicode/complex/datetime bit patterns. */
#include "ln_delete.h"
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static ln_array *bad(ln_error *e, const char *message) {
    if (e) snprintf(e->message, sizeof(e->message), "%s", message);
    return NULL;
}
static void advance(int nd, const ln_intp *shape, ln_intp *idx) {
    for (int d=nd-1; d>=0; --d) {
        if (++idx[d] < shape[d]) return;
        idx[d]=0;
    }
}
ln_array *ln_delete(const ln_array *a, int axis, const unsigned char *remove,
                    ln_intp count, ln_error *err) {
    if (!a || axis < -1 || axis >= a->nd || count < 0 || (count && !remove))
        return bad(err, "invalid delete arguments");
    const int flat=axis==-1;
    ln_intp length=flat ? ln_array_size(a) : a->dimensions[axis];
    if (length<0 || count!=length) return bad(err,"delete mask length mismatch");
    ln_intp remain=length;
    for (ln_intp i=0;i<length;i++) if (remove[i]) --remain;
    if (remain<0 || (uintmax_t)remain > SIZE_MAX/sizeof(ln_intp))
        return bad(err,"delete result too large");
    /* Precompute source axis positions to avoid O(n^2) lookup. */
    ln_intp *keep=NULL;
    if (remain>0) {
        keep=malloc((size_t)remain*sizeof(*keep));
        if (!keep) return bad(err,"cannot allocate delete position map");
    }
    ln_intp k=0;
    for (ln_intp i=0;i<length;i++) if (!remove[i]) keep[k++]=i;
    const int nd=flat?1:a->nd;
    ln_intp shape[LN_MAXDIMS]={0};
    if (flat) shape[0]=remain;
    else {
        for (int d=0;d<nd;d++) shape[d]=a->dimensions[d];
        shape[axis]=remain;
    }
    ln_array *out=ln_array_new(nd,shape,a->descr,0,0,err);
    if (!out) {free(keep); return NULL;}
    const ln_intp total=ln_array_size(out);
    ln_intp idx[LN_MAXDIMS]={0};
    for (ln_intp i=0;i<total;i++) {
        const char *source=a->data;
        if (flat) {
            ln_intp pos=keep[idx[0]];
            for (int d=a->nd-1;d>=0;d--) {
                ln_intp coord=pos%a->dimensions[d];
                pos/=a->dimensions[d];
                source+=coord*a->strides[d];
            }
        } else {
            for (int d=0;d<a->nd;d++)
                source+=(d==axis?keep[idx[d]]:idx[d])*a->strides[d];
        }
        char *dest=out->data;
        for (int d=0;d<nd;d++) dest+=idx[d]*out->strides[d];
        if (a->descr->elsize) memcpy(dest,source,a->descr->elsize);
        advance(nd,shape,idx);
    }
    free(keep);
    return out;
}
