/* NumPy 2.5.3 core/numeric.py axis manipulation and multiarray shape/view
 * behavior, translated into host-independent C without CPython or Python.
 * All operations preserve the owner, descriptor, and writeability. */
#include "ln_axis.h"
#include <stdio.h>
#include <string.h>

static ln_array *bad(ln_error *e, const char *why) {
    if(e)snprintf(e->message,sizeof(e->message),"%s",why);
    return NULL;
}

ln_array *ln_axis_permute(const ln_array *a, const int *order, ln_error *e) {
    if(!a)return bad(e,"null array");
    ln_intp dims[LN_MAXDIMS], strides[LN_MAXDIMS];
    unsigned char seen[LN_MAXDIMS]={0};
    for(int i=0;i<a->nd;i++){
        int j=order[i];
        if(j<0||j>=a->nd||seen[j])return bad(e,"invalid transpose permutation");
        seen[j]=1; dims[i]=a->dimensions[j]; strides[i]=a->strides[j];
    }
    return ln_array_view(a,a->nd,dims,strides,a->data,e);
}

ln_array *ln_axis_reverse(const ln_array *a, const unsigned char *axes, ln_error *e) {
    if(!a)return bad(e,"null array");
    ln_intp strides[LN_MAXDIMS];
    char *data=a->data;
    int occupied=ln_array_size(a)>0;
    for(int i=0;i<a->nd;i++){
        strides[i]=a->strides[i];
        if(axes[i]){
            /* Empty arrays stay in bounds even if their strides are odd. */
            if(occupied && a->dimensions[i]>1)data+=(a->dimensions[i]-1)*strides[i];
            /* Python slice normalization leaves an empty axis untouched. */
            if(a->dimensions[i]!=0)strides[i]=-strides[i];
        }
    }
    return ln_array_view(a,a->nd,a->dimensions,strides,data,e);
}

ln_array *ln_axis_expand(const ln_array *a, const unsigned char *positions,
                         int result_nd, ln_error *e) {
    if(!a||result_nd<0||result_nd>LN_MAXDIMS)return bad(e,"invalid expand_dims rank");
    ln_intp dims[LN_MAXDIMS], strides[LN_MAXDIMS];
    int j=0;
    for(int i=0;i<result_nd;i++){
        if(positions[i]) {dims[i]=1;strides[i]=0;}
        else {
            if(j>=a->nd)return bad(e,"invalid expand_dims axes");
            dims[i]=a->dimensions[j]; strides[i]=a->strides[j++];
        }
    }
    if(j!=a->nd)return bad(e,"invalid expand_dims axes");
    /* NumPy expand_dims uses ndarray.reshape: reuse the source-derived
     * no-copy reshape implementation to obtain exact singleton strides. */
    ln_array *reshaped=ln_array_reshape_c(a,result_nd,dims,e);
    if(!reshaped)return NULL;
    if(reshaped->owner==a->owner)return reshaped;
    /* If a corner case would copy (e.g. non-C zero-volume input), preserve
     * expand_dims' required view semantics via explicit metadata. */
    ln_array_free(reshaped);
    /* expand_dims(axis=()) leaves layout untouched, even for degenerate
     * C-contiguous negative-stride singletons. */
    if(result_nd==a->nd)
        return ln_array_view(a,a->nd,a->dimensions,a->strides,a->data,e);
    /* NumPy reshape computes canonical C strides when the source is already
     * C-contiguous (including degenerate single-element negative views). */
    if(a->flags&LN_ARRAY_C_CONTIGUOUS){
        int flags=LN_ARRAY_C_CONTIGUOUS|LN_ARRAY_F_CONTIGUOUS;
        ln_array_fill_strides(strides,dims,result_nd,a->descr->elsize,
                              LN_ARRAY_C_CONTIGUOUS,&flags);
        return ln_array_view(a,result_nd,dims,strides,a->data,e);
    }
    /* Reshape-style singleton strides: inserted axes have meaningful byte
     * strides even though their length is one. For an insertion before an
     * existing axis, use the neighboring axis stride times its extent;
     * trailing singletons inherit the original last axis stride. This
     * matches the NumPy no-copy reshape path on nonempty arrays. */
    int next=-1;
    for(int i=result_nd-1;i>=0;i--){
        if(positions[i]){
            if(next>=0)strides[i]=strides[next]*dims[next];
            else strides[i]=a->nd ? a->strides[a->nd-1] : (ln_intp)a->descr->elsize;
        } else next=i;
    }
    return ln_array_view(a,result_nd,dims,strides,a->data,e);
}

ln_array *ln_axis_squeeze(const ln_array *a, const unsigned char *axes, ln_error *e) {
    if(!a)return bad(e,"null array");
    ln_intp dims[LN_MAXDIMS], strides[LN_MAXDIMS];
    int j=0;
    for(int i=0;i<a->nd;i++){
        if(axes[i]){
            if(a->dimensions[i]!=1)return bad(e,"cannot select an axis to squeeze out which has size not equal to one");
        } else {
            dims[j]=a->dimensions[i];strides[j++]=a->strides[i];
        }
    }
    return ln_array_view(a,j,dims,strides,a->data,e);
}

ln_array *ln_axis_rot90(const ln_array *a, int k, int first, int second, ln_error *e) {
    if(!a||a->nd<2||first<0||first>=a->nd||second<0||second>=a->nd||first==second)
        return bad(e,"rot90 requires two distinct valid axes");
    /* k normalized before entry: reversing original axes and swapping is
     * equivalent to NumPy's flip/transpose construction for k=1,2,3. */
    unsigned char rev[LN_MAXDIMS]={0};
    if(k==1)rev[second]=1;
    if(k==2){rev[first]=1;rev[second]=1;}
    if(k==3)rev[first]=1;
    ln_array *flipped=ln_axis_reverse(a,rev,e);
    if(!flipped)return NULL;
    if(k==0||k==2)return flipped;
    int order[LN_MAXDIMS];
    for(int i=0;i<a->nd;i++)order[i]=i;
    order[first]=second;order[second]=first;
    ln_array *out=ln_axis_permute(flipped,order,e);
    ln_array_free(flipped);
    return out;
}

/* Port of NumPy lib/_stride_tricks_impl.py:_broadcast_to and the
 * multiarray broadcast_strides algorithm.  A view of the original storage is
 * created; repeated coordinates have zero byte stride.  broadcast_to is
 * intentionally read-only, whereas broadcast_arrays retains NumPy 2.x's
 * historically writeable result (deprecated upstream). */
ln_array *ln_axis_broadcast_to(const ln_array *a, int nd,
                                const ln_intp *shape, int readonly,
                                ln_error *err) {
    if(!a || nd<0 || nd>LN_MAXDIMS)return bad(err,"invalid broadcast rank");
    for(int i=0;i<nd;i++)
        if(shape[i]<0)return bad(err,"all elements of broadcast shape must be non-negative");
    /* NumPy broadcast_arrays leaves an unchanged array's strides intact;
     * broadcast_to always constructs a read-only iterator-style view. */
    if(!readonly && nd==a->nd) {
        int identical=1;
        for(int i=0;i<nd;i++)if(shape[i]!=a->dimensions[i])identical=0;
        if(identical)return ln_array_view(a,nd,shape,a->strides,a->data,err);
    }
    /* Reject metadata whose element count would overflow ln_intp even though
     * the broadcast itself never allocates an output buffer. */
    ln_intp elements=1;
    for(int i=0;i<nd;i++)if(ln_mul_sizes_with_overflow(&elements,elements,shape[i]))
        return bad(err,"broadcast shape is too large");
    ln_intp strides[LN_MAXDIMS]={0};
    if(ln_broadcast_strides(nd,shape,a->nd,a->dimensions,a->strides,
                            "input",strides,err)<0)return NULL;
    ln_array *v=ln_array_view(a,nd,shape,strides,a->data,err);
    if(v && readonly)v->flags &= ~LN_ARRAY_WRITEABLE;
    return v;
}

/* NumPy 2.5.3 core/shape_base.py:_atleast_nd and its _core internals:
 * - already-sufficient rank: preserve shape and strides;
 * - 1-D -> 2-D: a[None, :] (0, old stride);
 * - 1-D -> 3-D: a[None, :, None] (0, old stride, 0);
 * - 2-D -> 3-D: a[:, :, None] (old strides, 0);
 * - scalar: reshape to a length-one shape with itemsize strides.
 * Views retain their descriptor, owner and writeability; no element copy.
 */
ln_array *ln_axis_atleast(const ln_array *a, int minimum_nd, ln_error *e) {
    if (!a || minimum_nd < 1 || minimum_nd > 3)
        return bad(e, "atleast requires rank 1, 2, or 3");
    if (a->nd >= minimum_nd)
        return ln_array_view(a, a->nd, a->dimensions, a->strides, a->data, e);
    ln_intp dims[3] = {1, 1, 1};
    ln_intp strides[3] = {0, 0, 0};
    if (a->nd == 0) {
        for (int i = 0; i < minimum_nd; ++i)
            strides[i] = (ln_intp)a->descr->elsize;
    } else if (a->nd == 1) {
        int data_axis = minimum_nd == 1 ? 0 : 1;
        dims[data_axis] = a->dimensions[0];
        strides[data_axis] = a->strides[0];
    } else {
        dims[0] = a->dimensions[0];
        dims[1] = a->dimensions[1];
        strides[0] = a->strides[0];
        strides[1] = a->strides[1];
    }
    return ln_array_view(a, minimum_nd, dims, strides, a->data, e);
}
