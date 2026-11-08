/* NumPy 2.5.3 item_selection.c:PyArray_Choose / legacy C-order MultiIter. */
#include "ln_choose.h"
#include "ln_write.h"
#include <stdint.h>
#include <stdio.h>
#include <string.h>

static ln_array *bad(ln_error *err,const char *message)
{ if(err)snprintf(err->message,sizeof(err->message),"%s",message);return NULL; }

ln_array *ln_array_choose(const ln_array *indices,const ln_array *const *choices,
                          int count,ln_take_mode mode,ln_array *out,ln_error *err)
{
    if(!indices || !choices || count<1 || count>=64 ||
       mode<LN_TAKE_RAISE || mode>LN_TAKE_CLIP ||
       indices->descr->kind!='i' || indices->descr->elsize!=sizeof(ln_intp))
        return bad(err,"invalid prepared choose operands");
    const ln_array *operands[64];
    const ln_dtype *dtype=NULL;
    for(int j=0;j<count;++j) {
        if(!choices[j] || !(choices[j]->flags&LN_ARRAY_C_CONTIGUOUS))
            return bad(err,"choose choices must be prepared C-contiguous arrays");
        if(j==0)dtype=choices[j]->descr;
        else if(choices[j]->descr!=dtype)return bad(err,"choose choices require one common dtype");
        operands[j]=choices[j];
    }
    operands[count]=indices;
    int nd=0;ln_intp shape[LN_MAXDIMS],strides[64][LN_MAXDIMS];
    if(ln_broadcast_shape(count+1,operands,&nd,shape,err)<0)return NULL;
    for(int j=0;j<=count;++j)if(ln_broadcast_strides(nd,shape,
            operands[j]->nd,operands[j]->dimensions,operands[j]->strides,
            "choose operand",strides[j],err)<0)return NULL;
    int staged=!out || mode==LN_TAKE_RAISE;
    if(out) {
        if(out->nd!=nd)return bad(err,"choose output shape mismatch");
        for(int d=0;d<nd;++d)if(out->dimensions[d]!=shape[d])return bad(err,"choose output shape mismatch");
        if(!(out->flags&LN_ARRAY_WRITEABLE))return bad(err,"choose output is read-only");
        if(out->descr!=dtype)staged=1;
        for(int j=0;j<count;++j)if(out->owner && out->owner==choices[j]->owner)staged=1;
    }
    ln_array *work=staged?ln_array_new(nd,shape,dtype,0,0,err):out;
    if(!work)return NULL;
    ln_intp total=ln_array_size(work),coord[LN_MAXDIMS]={0};
    size_t width=dtype->elsize;
    /* Upstream increments the direct output pointer linearly even for strided
     * out. Preserve in-buffer behavior, but never reproduce an out-of-bounds
     * raw write (e.g. a reversed/zero-stride view with insufficient tail). */
    if(!staged && total && width) {
        uintptr_t data=(uintptr_t)out->data,base=out->owner?(uintptr_t)out->owner->ptr:0;
        if(!out->owner || data<base || data-base>out->owner->nbytes ||
           (size_t)total>(out->owner->nbytes-(size_t)(data-base))/width)
            return bad(err,"choose direct output would exceed its owning buffer");
    }
    for(ln_intp k=0;k<total;++k) {
        const char *ip=indices->data;
        for(int d=0;d<nd;++d)ip+=coord[d]*strides[count][d];
        ln_intp raw,index;memcpy(&raw,ip,sizeof(raw));
        if(raw==0){bad(err,"index 0 is invalid in Lua's 1-based choice model");goto fail;}
        index=raw>0?raw-1:raw;
        if(index<0 || index>=count) {
            if(mode==LN_TAKE_RAISE){bad(err,"invalid entry in choice array");goto fail;}
            if(mode==LN_TAKE_WRAP){index%=count;if(index<0)index+=count;}
            else index=index<0?0:count-1;
        }
        const char *sp=choices[index]->data;
        for(int d=0;d<nd;++d)sp+=coord[d]*strides[index][d];
        if(width)memcpy(work->data+(size_t)k*width,sp,width);
        for(int d=nd-1;d>=0;--d){if(++coord[d]<shape[d])break;coord[d]=0;}
    }
    if(out && staged) {
        if(ln_array_copyto(out,work,NULL,1,LN_UNSAFE_CASTING,err)<0)goto fail;
        ln_array_free(work);return out;
    }
    return work;
fail:
    if(work!=out)ln_array_free(work);
    return NULL;
}
