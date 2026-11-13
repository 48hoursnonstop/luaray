/* NumPy arrayobject.c:array_new/CheckStrides, common/mem_overlap.c bounds.
 * Pointer formation follows checked byte ranges, including negative strides. */
#include "ln_constructor.h"
#include <stdio.h>
#include <string.h>
static ln_array *bad(ln_error *error,const char *message)
{if(error)snprintf(error->message,sizeof error->message,"%s",message);return NULL;}
static uintptr_t magnitude(ln_intp value)
{return value<0?(uintptr_t)(-(value+1))+1:(uintptr_t)value;}
static int fits(ln_intp bytes,ln_intp offset,int nd,const ln_intp *shape,
                const ln_intp *strides,size_t width)
{
    if(offset<0||offset>bytes)return 0;
    for(int d=0;d<nd;++d)if(!shape[d])return 1;
    uintptr_t before=0,after=0;
    for(int d=0;d<nd;++d){
        ln_intp extent=shape[d]-1;
        uintptr_t step=magnitude(strides[d]),length=magnitude(extent);
        if(step&&length>(uintptr_t)INTPTR_MAX/step)return 0;
        uintptr_t span=step*length;
        uintptr_t *bound=(extent<0)!=(strides[d]<0)?&before:&after;
        if(*bound>(uintptr_t)INTPTR_MAX-span)return 0;
        *bound+=span;
    }
    return before<=(uintptr_t)offset&&after<=(uintptr_t)(bytes-offset)&&
           width<=(uintptr_t)(bytes-offset)-after;
}
ln_array *ln_array_construct(int nd,const ln_intp *shape,const ln_dtype *dtype,
    const ln_array *buffer,ln_intp offset,const ln_intp *strides,int fortran,ln_error *err)
{
    if(nd<0||nd>LN_MAXDIMS||(nd&&!shape))return bad(err,"invalid ndarray shape");
    if(!dtype)dtype=ln_dtype_by_num(LN_DOUBLE);
    if(dtype->elsize>(size_t)INTPTR_MAX)return bad(err,"dtype is too large");
    ln_intp dims[LN_MAXDIMS],steps[LN_MAXDIMS],bytes=0;
    if(nd)memcpy(dims,shape,(size_t)nd*sizeof(*dims));
    if(buffer){
        if(!buffer->owner||!(buffer->flags&(LN_ARRAY_C_CONTIGUOUS|LN_ARRAY_F_CONTIGUOUS)))return bad(err,"buffer requires retained contiguous storage");
        ln_intp count=ln_array_size(buffer);
        if(count<0||ln_mul_sizes_with_overflow(&bytes,count,(ln_intp)buffer->descr->elsize))return bad(err,"buffer is too large");
        if(offset<0||offset>bytes)return bad(err,"offset is outside the buffer");
    }else offset=0;
    if(buffer&&nd==1&&dims[0]==-1){
        if(!dtype->elsize)return bad(err,"cannot infer shape for a zero-width dtype");
        /* Upstream checks explicit strides before its single -1 inference.
         * Keep that selection rule, then check the resulting real range too. */
        if(strides&&(!bytes||!fits(bytes,offset,nd,dims,strides,dtype->elsize)))return bad(err,"strides are incompatible with inferred shape");
        dims[0]=(bytes-offset)/(ln_intp)dtype->elsize;
    }
    int empty=0,layout_flags=0;
    for(int d=0;d<nd;++d){if(dims[d]<0)return bad(err,"negative dimensions are not allowed");if(!dims[d])empty=1;}
    ln_intp count=1;
    for(int d=0;d<nd;++d)if(dims[d]&&ln_mul_sizes_with_overflow(&count,count,dims[d]))return bad(err,"array has too many elements");
    ln_intp logical;
    if(ln_mul_sizes_with_overflow(&logical,count,(ln_intp)dtype->elsize))return bad(err,"array byte count is too large");
    if(empty)logical=0;
    if(strides){if(nd)memcpy(steps,strides,(size_t)nd*sizeof(*steps));}
    else{
        ln_array_fill_strides(steps,dims,nd,dtype->elsize,
            fortran?LN_ARRAY_F_CONTIGUOUS:LN_ARRAY_C_CONTIGUOUS,&layout_flags);
    }
    if(!fits(buffer?bytes:logical,offset,nd,dims,steps,dtype->elsize))return bad(err,"strides/shape exceed the available buffer");
    ln_array *result;
    if(buffer){
        result=ln_array_view(buffer,nd,dims,steps,buffer->data+offset,err);
        if(result){
            result->descr=dtype;ln_update_contiguous_flags(result);
            if(!strides&&nd)result->flags=(result->flags&~(LN_ARRAY_C_CONTIGUOUS|LN_ARRAY_F_CONTIGUOUS))|layout_flags;
        }
    }else{
        result=ln_array_new(nd,dims,dtype,fortran,0,err);
        if(result&&strides){if(nd&&logical)memcpy(result->strides,steps,(size_t)nd*sizeof(*steps));ln_update_contiguous_flags(result);}
    }
    return result;
}
