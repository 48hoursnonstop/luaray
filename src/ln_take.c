/* Source-derived from NumPy 2.5.3 item_selection.c:PyArray_TakeFrom/fasttake. */
#include "ln_take.h"
#include "ln_mapping.h"
#include "ln_write.h"
#include <stdio.h>
#include <string.h>

static ln_array *bad(ln_error *err,const char *message)
{ if(err)snprintf(err->message,sizeof(err->message),"%s",message);return NULL; }

ln_array *ln_array_take(const ln_array *input,const ln_array *indices,int axis,
                         ln_take_mode mode,ln_array *out,ln_error *err)
{
    if(!input || !indices || indices->descr->kind!='i' ||
       indices->descr->elsize!=sizeof(ln_intp) || !(indices->flags&LN_ARRAY_C_CONTIGUOUS) ||
       mode<LN_TAKE_RAISE || mode>LN_TAKE_CLIP)return bad(err,"invalid prepared take operands");
    ln_array *source_copy=NULL,*work=NULL;
    const ln_array *src=input;
    if(!(src->flags&LN_ARRAY_C_CONTIGUOUS) || !(src->flags&LN_ARRAY_ALIGNED)) {
        source_copy=ln_array_copy_c(src,err);
        if(!source_copy)return NULL;
        src=source_copy;
    }
    ln_intp size=ln_array_size(src),m=ln_array_size(indices);
    if(size<0 || m<0){bad(err,"take operand is too large");goto fail;}
    int flat=axis==-1 || src->nd==0;
    int rank=flat?1:src->nd,ax=flat?0:axis;
    const ln_intp *dims=flat?&size:src->dimensions;
    if(axis< -1 || ax<0 || ax>=rank || (src->nd==0 && axis>0)) {
        bad(err,"take axis out of bounds");goto fail;
    }
    int nd=rank+indices->nd-1;
    if(nd>LN_MAXDIMS){bad(err,"take result exceeds supported dimensionality");goto fail;}
    ln_intp shape[LN_MAXDIMS],n=1,chunk=1,axis_size=dims[ax];
    for(int d=0;d<ax;++d) {
        shape[d]=dims[d];
        if(ln_mul_sizes_with_overflow(&n,n,dims[d])<0){bad(err,"take prefix overflow");goto fail;}
    }
    for(int d=0;d<indices->nd;++d)shape[ax+d]=indices->dimensions[d];
    for(int d=ax+1;d<rank;++d) {
        shape[d+indices->nd-1]=dims[d];
        if(ln_mul_sizes_with_overflow(&chunk,chunk,dims[d])<0){bad(err,"take suffix overflow");goto fail;}
    }
    if(out) {
        if(!(out->flags&LN_ARRAY_WRITEABLE)){bad(err,"take output is read-only");goto fail;}
        if(out->nd!=nd){bad(err,"take output shape mismatch");goto fail;}
        for(int d=0;d<nd;++d)if(out->dimensions[d]!=shape[d]){bad(err,"take output shape mismatch");goto fail;}
    }
    int staged=!out || mode==LN_TAKE_RAISE || !(out->flags&LN_ARRAY_C_CONTIGUOUS) ||
                !(out->flags&LN_ARRAY_ALIGNED) || out->descr!=src->descr ||
                (ln_arrays_may_overlap(out,src));
    if(staged) {
        work=ln_array_new(nd,shape,src->descr,0,0,err);
        if(!work)goto fail;
        /* NumPy's typed WRITEBACKIFCOPY conversion reads an existing out before
         * gathering, even though every result element will be overwritten. */
        if(out && ln_array_copyto(work,out,NULL,1,LN_UNSAFE_CASTING,err)<0)goto fail;
    }
    else work=out;
    ln_intp total=ln_array_size(work);
    if(axis_size==0 && total!=0){bad(err,"cannot take nonempty values from an empty axis");goto fail;}
    if(axis_size==0 && n>0 && m>0 && mode!=LN_TAKE_CLIP) {
        bad(err,"cannot take indices from an empty axis");goto fail;
    }
    size_t width=src->descr->elsize;
    if(width && (size_t)chunk>SIZE_MAX/width){bad(err,"take chunk byte size overflow");goto fail;}
    size_t bytes=(size_t)chunk*width,offset=0;
    for(ln_intp i=0;i<n;++i)for(ln_intp j=0;j<m;++j) {
        ln_intp raw,index;
        memcpy(&raw,indices->data+(size_t)j*sizeof(raw),sizeof(raw));
        if(raw==0){bad(err,"index 0 is invalid in Lua's 1-based indexing model");goto fail;}
        index=raw>0?raw-1:raw;
        if(mode==LN_TAKE_RAISE) {
            if(index<0)index+=axis_size;
            if(index<0 || index>=axis_size){bad(err,"take index out of bounds");goto fail;}
        }
        else if(mode==LN_TAKE_WRAP) {
            index%=axis_size;if(index<0)index+=axis_size;
        }
        else {
            if(index<0)index=0;else if(index>=axis_size)index=axis_size-1;
        }
        if(bytes)memcpy(work->data+offset,src->data+(size_t)(i*axis_size+index)*bytes,bytes);
        offset+=bytes;
    }
    if(out && staged) {
        if(ln_array_copyto(out,work,NULL,1,LN_UNSAFE_CASTING,err)<0)goto fail;
        ln_array_free(work);work=out;
    }
    ln_array_free(source_copy);return work;
fail:
    if(work && work!=out)ln_array_free(work);
    ln_array_free(source_copy);return NULL;
}
