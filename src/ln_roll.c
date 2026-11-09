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
    ln_array *out=flatten?ln_array_new(a->nd,a->dimensions,a->descr,0,0,err):
                          ln_array_new_keeporder(a,a->descr,err);
    if(!out)return NULL;
    const ln_intp size=ln_array_size(a);
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
