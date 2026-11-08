/* LuaRay's native NumPy 2.5.3 numeric.roll kernel.  Never reads data as a
 * floating-point value: arbitrary fixed-width payloads and descriptors are
 * copied byte-for-byte, respecting arbitrary source and result strides. */
#include "ln_roll.h"
#include <stdio.h>
#include <string.h>

static ln_array *bad(ln_error *err, const char *message) {
    if(err)snprintf(err->message,sizeof(err->message),"%s",message);
    return NULL;
}

ln_array *ln_roll(const ln_array *a, int flatten, const ln_intp *offsets,
                  ln_error *err) {
    if(!a || !offsets)return bad(err,"invalid roll arguments");
    /* np.roll(axis=None) flattens in C order, whereas explicit axes use
     * empty_like and preserve Fortran layout for F-only input arrays. */
    int fortran=!flatten && (a->flags & LN_ARRAY_F_CONTIGUOUS) &&
                !(a->flags & LN_ARRAY_C_CONTIGUOUS);
    ln_array *out=ln_array_new(a->nd,a->dimensions,a->descr,fortran,0,err);
    if(!out)return NULL;
    const ln_intp size=ln_array_size(a);
    /* NumPy empty_like(order='K') keeps the physical axis order even when
     * the input is neither C nor F contiguous (e.g. a 3-D permutation).
     * Materialize into that memory order without leaking source stride
     * signs or zero strides into the independently writable destination. */
    if(!flatten && size && !(a->flags&LN_ARRAY_C_CONTIGUOUS) &&
       !(a->flags&LN_ARRAY_F_CONTIGUOUS)) {
        int order[LN_MAXDIMS];
        for(int i=0;i<a->nd;i++)order[i]=i;
        for(int i=1;i<a->nd;i++) {
            int selected=order[i],j=i;
            ln_intp stride=a->strides[selected];
            uintmax_t magnitude=stride<0?(uintmax_t)(-(stride+1))+1:(uintmax_t)stride;
            if(!magnitude)magnitude=UINTMAX_MAX;
            while(j>0) {
                int other=order[j-1];
                ln_intp value=a->strides[other];
                uintmax_t compare=value<0?(uintmax_t)(-(value+1))+1:(uintmax_t)value;
                if(!compare)compare=UINTMAX_MAX;
                if(compare<magnitude || (compare==magnitude && other>selected))break;
                order[j]=other;j--;
            }
            order[j]=selected;
        }
        ln_intp factor=(ln_intp)a->descr->elsize;
        for(int i=0;i<a->nd;i++) {
            int axis=order[i];
            out->strides[axis]=factor;
            factor*=out->dimensions[axis];
        }
        ln_update_contiguous_flags(out);
    }
    ln_intp coords[LN_MAXDIMS]={0};
    for(ln_intp i=0;i<size;i++) {
        const char *input=a->data;
        if(flatten) {
            ln_intp j=i-offsets[0];
            if(j<0)j+=size;
            for(int d=a->nd-1;d>=0;d--) {
                ln_intp dim=a->dimensions[d];
                ln_intp pos=j%dim;
                j/=dim;
                input+=pos*a->strides[d];
            }
        } else {
            for(int d=0;d<a->nd;d++) {
                ln_intp source=coords[d]-offsets[d];
                if(source<0)source+=a->dimensions[d];
                input+=source*a->strides[d];
            }
        }
        char *destination=out->data;
        for(int d=0;d<a->nd;d++)destination+=coords[d]*out->strides[d];
        if(a->descr->elsize)memcpy(destination,input,a->descr->elsize);
        for(int d=a->nd-1;d>=0;d--) {
            if(++coords[d]<a->dimensions[d])break;
            coords[d]=0;
        }
    }
    return out;
}
