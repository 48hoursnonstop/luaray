/* Host-independent creation layout: NumPy2.5.3 ctors.c NewLikeArray K-order. */
#include "ln_core.h"
#include <stdio.h>

ln_array *ln_array_new_keeporder(const ln_array *a,const ln_dtype *dtype,ln_error *err)
{
    if(!a){if(err)snprintf(err->message,sizeof(err->message),"missing array prototype");return NULL;}
    int fortran=(a->flags&LN_ARRAY_F_CONTIGUOUS)&&!(a->flags&LN_ARRAY_C_CONTIGUOUS);
    ln_array *out=ln_array_new(a->nd,a->dimensions,dtype?dtype:a->descr,fortran,0,err);
    if(!out)return NULL;
    ln_intp size=ln_array_size(a);
    /* NumPy empty_like(order='K') keeps the physical axis order even when
     * the input is neither C nor F contiguous (e.g. a 3-D permutation).
     * Materialize into that memory order without leaking source stride
     * signs or zero strides into the independently writable destination. */
    if(size && !(a->flags&LN_ARRAY_C_CONTIGUOUS) &&
       !(a->flags&LN_ARRAY_F_CONTIGUOUS)) {
        int order[LN_MAXDIMS];
        for(int i=0;i<a->nd;i++)order[i]=i;
        for(int i=1;i<a->nd;i++) {
            int selected=order[i],j=i;
            ln_intp stride=a->strides[selected];
            uintmax_t magnitude=stride<0?(uintmax_t)(-(stride+1))+1:(uintmax_t)stride;
            while(j>0) {
                int other=order[j-1];
                ln_intp value=a->strides[other];
                uintmax_t compare=value<0?(uintmax_t)(-(value+1))+1:(uintmax_t)value;
                if(compare<magnitude || (compare==magnitude && other>selected))break;
                order[j]=other;j--;
            }
            order[j]=selected;
        }
        ln_intp factor=(ln_intp)out->descr->elsize;
        for(int i=0;i<a->nd;i++) {
            int axis=order[i];
            out->strides[axis]=factor;
            factor*=out->dimensions[axis];
        }
        ln_update_contiguous_flags(out);
    }
    return out;
}
