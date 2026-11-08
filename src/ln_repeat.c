/* LuaRay native repeat/tile, modeled on NumPy 2.5.3
 * numpy/_core/numeric.py:tile and multiarray.repeat.
 * Fixed-size dtype payloads are copied byte-for-byte; the original strided
 * array may be transposed, flipped, broadcast, empty, or scalar. */
#include "ln_repeat.h"
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static ln_array *bad(ln_error *e, const char *s) {
    if(e)snprintf(e->message,sizeof(e->message),"%s",s);
    return NULL;
}
static void step(int nd, const ln_intp *shape, ln_intp *indices) {
    for(int i=nd-1;i>=0;--i){
        if(++indices[i]<shape[i])return;
        indices[i]=0;
    }
}

ln_array *ln_tile(const ln_array *a, int reps_nd, const ln_intp *reps,
                  ln_error *err) {
    if(!a || reps_nd<0 || reps_nd>LN_MAXDIMS || (reps_nd && !reps))
        return bad(err,"invalid tile arguments");
    int nd=a->nd>reps_nd ? a->nd : reps_nd;
    ln_intp shape[LN_MAXDIMS], coords[LN_MAXDIMS]={0};
    int all_one=1;
    for(int i=0;i<nd;i++){
        ln_intp dim = i<nd-a->nd ? 1 : a->dimensions[i-(nd-a->nd)];
        ln_intp rep = i<nd-reps_nd ? 1 : reps[i-(nd-reps_nd)];
        if(rep<0)return bad(err,"negative tile repetitions are not allowed");
        if(rep!=1)all_one=0;
        if(ln_mul_sizes_with_overflow(&shape[i],dim,rep))
            return bad(err,"tile shape is too large");
    }
    /* NumPy tile with every repetition equal to one follows the copy
     * construction path and preserves the F-order of F-only inputs. */
    int fortran=all_one && (a->flags&LN_ARRAY_F_CONTIGUOUS) &&
                !(a->flags&LN_ARRAY_C_CONTIGUOUS);
    ln_array *out=ln_array_new(nd,shape,a->descr,fortran,0,err);
    if(!out)return NULL;
    ln_intp size=ln_array_size(out);
    for(ln_intp k=0;k<size;k++){
        const char *src=a->data;
        for(int i=0;i<a->nd;i++){
            ln_intp dim=a->dimensions[i];
            src+=(coords[nd-a->nd+i]%dim)*a->strides[i];
        }
        char *dest=out->data;
        for(int i=0;i<nd;i++)dest+=coords[i]*out->strides[i];
        if(a->descr->elsize)memcpy(dest,src,a->descr->elsize);
        step(nd,shape,coords);
    }
    return out;
}

ln_array *ln_repeat(const ln_array *a, int axis, size_t nreps,
                    const ln_intp *reps, ln_error *err) {
    if(!a || !reps || (axis<-1 || axis >= (a->nd?a->nd:1)))
        return bad(err,"repeat axis is out of bounds");
    int flat=axis==-1;
    ln_intp length=flat?ln_array_size(a):a->nd?a->dimensions[axis]:1;
    if(length<0 || (nreps!=1 && nreps!=(size_t)length))
        return bad(err,"repeats must be a scalar or match the axis length");
    if((uintmax_t)length>(SIZE_MAX/sizeof(ln_intp))-1)
        return bad(err,"repeat axis is too large");
    /* A prefix map handles nonuniform counts, zero counts and C-order flatten
     * without ever interpreting numeric dtype payloads as floating point. */
    ln_intp *prefix=(ln_intp *)malloc(((size_t)length+1)*sizeof(*prefix));
    if(!prefix)return bad(err,"out of memory");
    prefix[0]=0;
    for(ln_intp i=0;i<length;i++){
        ln_intp count=reps[nreps==1?0:(size_t)i];
        if(count<0){free(prefix);return bad(err,"repeats may not be negative");}
        if(prefix[i]>INTPTR_MAX-count){
            free(prefix);return bad(err,"repeated array is too large");
        }
        prefix[i+1]=prefix[i]+count;
    }
    int nd=flat || a->nd==0 ? 1:a->nd;
    int out_axis=flat?0:axis;
    ln_intp shape[LN_MAXDIMS], coords[LN_MAXDIMS]={0};
    for(int i=0;i<nd;i++)shape[i]=(flat || a->nd==0)?length:a->dimensions[i];
    shape[out_axis]=prefix[length];
    ln_array *out=ln_array_new(nd,shape,a->descr,0,0,err);
    if(!out){free(prefix);return NULL;}
    ln_intp total=ln_array_size(out);
    for(ln_intp k=0;k<total;k++){
        ln_intp selected=coords[out_axis];
        ln_intp low=0,high=length;
        /* Find the first original element whose exclusive prefix exceeds
         * the output coordinate; zero-count elements are skipped. */
        while(low<high){
            ln_intp mid=low+(high-low)/2;
            if(prefix[mid+1]<=selected) low=mid+1;
            else high=mid;
        }
        const char *src=a->data;
        if(flat){
            ln_intp rem=low;
            for(int d=a->nd-1;d>=0;d--){
                ln_intp coordinate=rem%a->dimensions[d];
                rem/=a->dimensions[d];
                src+=coordinate*a->strides[d];
            }
        } else if(a->nd){
            for(int d=0;d<a->nd;d++)
                src+=(d==axis?low:coords[d])*a->strides[d];
        }
        if(a->descr->elsize)memcpy(out->data+(size_t)k*a->descr->elsize,src,a->descr->elsize);
        step(nd,shape,coords);
    }
    free(prefix);
    return out;
}
