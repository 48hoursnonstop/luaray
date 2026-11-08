/* Copy-producing array insertion modeled after NumPy 2.5.3
 * numpy/_core/function_base.py:insert. All ndarray access is native C;
 * selection indices originate from Lua's one-based indexing convention. */
#include "ln_insert.h"
#include "ln_dtype_transfer.h"
#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct { ln_intp pos, seq; } insertion;
static ln_array *bad(ln_error *err, const char *message) {
    if (err) snprintf(err->message,sizeof(err->message),"%s",message);
    return NULL;
}
static int order_insertion(const void *lhs, const void *rhs) {
    const insertion *a=lhs,*b=rhs;
    return a->pos < b->pos ? -1 : a->pos > b->pos ? 1 :
           a->seq < b->seq ? -1 : a->seq > b->seq ? 1 : 0;
}
static void advance(int nd, const ln_intp *shape, ln_intp *idx) {
    for (int d=nd-1;d>=0;--d) {
        if (++idx[d] < shape[d])return;
        idx[d]=0;
    }
}
static int transfer(char *dst, const char *src,
                    const ln_dtype_descr *from,const ln_dtype_descr *to,
                    ln_error *err) {
    if (from==to) {memcpy(dst,src,to->elsize);return 0;}
    /* Same-family fixed width strings: resize the byte/UTF-32 payload,
     * preserving codepoints and zero-fill padding. */
    if (from->type_num==to->type_num &&
        (to->type_num==LN_UNICODE || to->type_num==LN_STRING)) {
        memset(dst,0,to->elsize);
        memcpy(dst,src,from->elsize<to->elsize?from->elsize:to->elsize);
        return 0;
    }
    if (ln_cast_strided_numeric(src,0,from,dst,0,to,1,err)==0)return 0;
    if (err && !err->message[0])snprintf(err->message,sizeof(err->message),
        "insert cannot cast values to the input dtype");
    return -1;
}
ln_array *ln_insert(const ln_array *a,int axis,const ln_intp *positions,
                    ln_intp npositions,int scalar_index,const ln_array *values,
                    ln_error *err) {
    if(!a || !values || axis< -1 || axis>=a->nd || npositions<0 ||
       (npositions && !positions) || (scalar_index && npositions!=1))
        return bad(err,"invalid insert arguments");
    int flat=axis==-1;
    int nd=flat?1:a->nd, ax=flat?0:axis;
    ln_intp shape[LN_MAXDIMS]={0},vdim[LN_MAXDIMS]={0};
    ln_intp vstride[LN_MAXDIMS]={0};
    ln_intp len=flat?ln_array_size(a):a->dimensions[axis];
    if(len<0)return bad(err,"array size overflow");
    for(ln_intp i=0;i<npositions;i++)
        if(positions[i]<0 || positions[i]>len)
            return bad(err,"insert position out of bounds");
    if(values->nd>nd)return bad(err,"insert values have too many dimensions");
    for(int d=0;d<nd;d++) {
        shape[d]=flat?len:a->dimensions[d];
        int s=d-(nd-values->nd);
        vdim[d]=s>=0?values->dimensions[s]:1;
        vstride[d]=s>=0?values->strides[s]:0;
    }
    if(scalar_index) {
        /* NumPy's special-case np.moveaxis(values,0,axis) for scalar obj. */
        ln_intp fd=vdim[0],fs=vstride[0];
        for(int d=0;d<ax;d++){vdim[d]=vdim[d+1];vstride[d]=vstride[d+1];}
        vdim[ax]=fd;vstride[ax]=fs;
    }
    ln_intp numnew=npositions==1?vdim[ax]:npositions;
    if(numnew<0 || numnew>INTPTR_MAX-len)return bad(err,"insert result too large");
    shape[ax]=len+numnew;
    /* Broadcast values to the selected new slots, not the whole output. */
    for(int d=0;d<nd;d++) {
        ln_intp expected=d==ax?numnew:shape[d];
        if(vdim[d]!=expected && vdim[d]!=1)
            return bad(err,"insert values cannot be broadcast to indexed shape");
        if(vdim[d]==1)vstride[d]=0;
    }
    /* Numpy casts values to arr.dtype; we only offer casts with a native
     * implementation. Never silently reinterpret unsupported descriptors. */
    if (values->descr!=a->descr &&
        !(values->descr->type_num==a->descr->type_num &&
          (a->descr->type_num==LN_UNICODE || a->descr->type_num==LN_STRING)) &&
        !ln_dtype_can_cast(values->descr,a->descr,LN_UNSAFE_CASTING))
        return bad(err,"insert values cannot be cast to array dtype");
    if((uintmax_t)numnew>SIZE_MAX/sizeof(insertion) ||
       (uintmax_t)shape[ax]>SIZE_MAX/sizeof(ln_intp))
        return bad(err,"insert position map too large");
    insertion *sorted=NULL;
    ln_intp *slots=NULL;
    if(numnew) {
        sorted=malloc((size_t)numnew*sizeof(*sorted));
        if(!sorted)return bad(err,"cannot allocate insert position map");
    }
    if(shape[ax]){
        slots=malloc((size_t)shape[ax]*sizeof(*slots));
        if(!slots){free(sorted);return bad(err,"cannot allocate insert axis map");}
    }
    for(ln_intp i=0;i<numnew;i++){
        sorted[i].pos=positions[npositions==1?0:i];
        sorted[i].seq=i;
    }
    if(numnew>1)qsort(sorted,(size_t)numnew,sizeof(*sorted),order_insertion);
    ln_intp k=0,srcpos=0;
    for(ln_intp i=0;i<numnew;i++) {
        while(srcpos<sorted[i].pos)slots[k++]=srcpos++;
        slots[k++]=-1-sorted[i].seq;
    }
    while(srcpos<len)slots[k++]=srcpos++;
    if(k!=shape[ax]){free(sorted);free(slots);return bad(err,"internal insert mapping error");}
    free(sorted);
    ln_array *out=ln_array_new(nd,shape,a->descr,0,0,err);
    if(!out){free(slots);return NULL;}
    ln_intp total=ln_array_size(out),ix[LN_MAXDIMS]={0};
    for(ln_intp n=0;n<total;n++){
        ln_intp selection=slots[ix[ax]];
        const char *sp;
        const ln_dtype_descr *sd;
        if(selection<0){
            ln_intp seq=-1-selection;
            sp=values->data;
            for(int d=0;d<nd;d++)sp+=(d==ax?seq:ix[d])*vstride[d];
            sd=values->descr;
        } else {
            sp=a->data;
            if(flat){
                ln_intp linear=selection;
                for(int d=a->nd-1;d>=0;d--){
                    ln_intp coord=linear%a->dimensions[d];
                    linear/=a->dimensions[d];
                    sp+=coord*a->strides[d];
                }
            } else {
                for(int d=0;d<nd;d++)sp+=(d==ax?selection:ix[d])*a->strides[d];
            }
            sd=a->descr;
        }
        char *dest=out->data;
        for(int d=0;d<nd;d++)dest+=ix[d]*out->strides[d];
        if(transfer(dest,sp,sd,out->descr,err)<0){ln_array_free(out);free(slots);return NULL;}
        advance(nd,shape,ix);
    }
    free(slots);
    return out;
}
