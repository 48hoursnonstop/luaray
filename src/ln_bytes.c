#include "ln_bytes.h"
#include "ln_layout.h"
#include "ln_creation.h"
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
/* NumPy2.5.3 common.c:_check_compatibility_with_new_dtype and
 * convert.c:PyArray_View/PyArray_ToString. NumPy BSD attribution retained. */
static int fail(ln_error *err,const char *message,ln_error_kind kind)
{
    if(err){snprintf(err->message,sizeof err->message,"%s",message);err->kind=kind;}
    return -1;
}
int ln_bytes_size(const ln_array *a,size_t *size,ln_error *err)
{
    if(!a||!a->descr||!size)return fail(err,"invalid byte size query",LN_ERROR_TYPE);
    ln_intp count=ln_array_size(a);
    if(count<0||(a->descr->elsize&&(uintmax_t)count>(uintmax_t)INTPTR_MAX/a->descr->elsize))
        return fail(err,"array byte count exceeds native range",LN_ERROR_OVERFLOW);
    *size=(size_t)count*a->descr->elsize;return 0;
}
ln_array *ln_bytes_view(const ln_array *a,const ln_dtype *dtype,ln_error *err)
{
    if(!a||!a->descr){fail(err,"view requires an ndarray",LN_ERROR_TYPE);return NULL;}
    const ln_dtype *target=dtype?dtype:a->descr;
    size_t before=a->descr->elsize,after=target->elsize;
    ln_intp dims[LN_MAXDIMS],strides[LN_MAXDIMS];
    if(a->nd){memcpy(dims,a->dimensions,(size_t)a->nd*sizeof *dims);memcpy(strides,a->strides,(size_t)a->nd*sizeof *strides);}
    if(before!=after){
        if(a->nd==0){fail(err,"changing a 0d dtype requires unchanged itemsize",LN_ERROR_VALUE);return NULL;}
        int last=a->nd-1;ln_intp count=ln_array_size(a);
        if(dims[last]!=1&&count!=0&&(before>(size_t)INTPTR_MAX||strides[last]!=(ln_intp)before)){
            fail(err,"last axis must be contiguous to change itemsize",LN_ERROR_VALUE);return NULL;
        }
        if(after<before){
            if(!after||before%after){fail(err,"smaller dtype size must divide the original itemsize",LN_ERROR_VALUE);return NULL;}
            size_t factor=before/after;
            if(factor>(size_t)INTPTR_MAX||ln_mul_sizes_with_overflow(&dims[last],dims[last],(ln_intp)factor)){
                fail(err,"view last dimension overflows",LN_ERROR_OVERFLOW);return NULL;
            }
        }else{
            ln_intp bytes;
            if(before>(size_t)INTPTR_MAX||after>(size_t)INTPTR_MAX||
               ln_mul_sizes_with_overflow(&bytes,dims[last],(ln_intp)before)){
                fail(err,"view last-axis byte count overflows",LN_ERROR_OVERFLOW);return NULL;
            }
            if((size_t)bytes%after){fail(err,"larger dtype size must divide last-axis byte count",LN_ERROR_VALUE);return NULL;}
            dims[last]=(ln_intp)((size_t)bytes/after);
        }
        strides[last]=(ln_intp)after;
    }
    ln_array *out=ln_array_view(a,a->nd,dims,strides,a->data,err);
    if(out){out->descr=target;ln_update_contiguous_flags(out);}
    return out;
}
int ln_bytes_export(const ln_array *a,char order,char **bytes,size_t *length,ln_error *err)
{
    if(!a||!a->descr||!bytes||!length)return fail(err,"invalid byte output",LN_ERROR_TYPE);
    /* Unicode carries NPY_NEEDS_INIT upstream: its fallback calls ravel(K).
     * Plain numeric/bytes/time use CopyInto to a C-order destination for K. */
    if(order=='K'&&a->descr->kind=='U'){
        ln_array *flat=ln_layout_ravel(a,'K',err);if(!flat)return -1;
        int rc=ln_bytes_export(flat,'C',bytes,length,err);ln_array_free(flat);return rc;
    }
    if(order=='K')order='C';
    if(order=='A')order=(a->flags&LN_ARRAY_F_CONTIGUOUS)&&!(a->flags&LN_ARRAY_C_CONTIGUOUS)?'F':'C';
    if(order!='C'&&order!='F')return fail(err,"tobytes order must be C, F, A or K",LN_ERROR_VALUE);
    size_t size;if(ln_bytes_size(a,&size,err)<0)return -1;
    char *result=malloc(size?size:1);if(!result)return fail(err,"out of memory",LN_ERROR_MEMORY);
    if(size){
        if((order=='C'&&(a->flags&LN_ARRAY_C_CONTIGUOUS))||(order=='F'&&(a->flags&LN_ARRAY_F_CONTIGUOUS)))memcpy(result,a->data,size);
        else{
            ln_intp coord[LN_MAXDIMS]={0},count=ln_array_size(a);size_t item=a->descr->elsize;
            for(ln_intp i=0;i<count;++i){
                const char *source=a->data;
                for(int d=0;d<a->nd;++d)source+=coord[d]*a->strides[d];
                memcpy(result+(size_t)i*item,source,item);
                for(int j=0;j<a->nd;++j){int d=order=='C'?a->nd-1-j:j;
                    if(++coord[d]<a->dimensions[d])break;
                    coord[d]=0;
                }
            }
        }
    }
    *bytes=result;*length=size;return 0;
}

/* NumPy methods.c:PyArray_Byteswap and arraytypes.c.src copyswapn.
 * Complex components are swapped in separate passes; Unicode visits each
 * code point within an item. This order matters for overlapping byte views. */
static void reverse_bytes(char *data,size_t width)
{
    for(size_t i=0;i<width/2;++i){char t=data[i];data[i]=data[width-1-i];data[width-1-i]=t;}
}
static void swap_run(char *data,ln_intp stride,ln_intp count,const ln_dtype *dtype)
{
    size_t width=dtype->elsize;
    if(dtype->kind=='c'){
        width/=2;
        for(int part=0;part<2;++part)
            for(ln_intp i=0;i<count;++i)reverse_bytes(data+i*stride+part*width,width);
    }
    else if(dtype->kind=='U'){
        for(ln_intp i=0;i<count;++i)
            for(size_t part=0;part<width;part+=4)reverse_bytes(data+i*stride+part,4);
    }
    else for(ln_intp i=0;i<count;++i)reverse_bytes(data+i*stride,width);
}
int ln_bytes_swap_inplace(ln_array *a,ln_error *err)
{
    if(!a||!a->descr)return fail(err,"byteswap requires an ndarray",LN_ERROR_TYPE);
    if(!(a->flags&LN_ARRAY_WRITEABLE))return fail(err,"array to be byte-swapped is read-only",LN_ERROR_VALUE);
    if(!strchr("biufcSUMm",a->descr->kind))return fail(err,"unsupported byteswap dtype",LN_ERROR_TYPE);
    size_t size;if(ln_bytes_size(a,&size,err)<0)return -1;
    if(!size||a->descr->elsize==1||a->descr->kind=='S')return 0;
    ln_intp count=ln_array_size(a);
    if(a->flags&(LN_ARRAY_C_CONTIGUOUS|LN_ARRAY_F_CONTIGUOUS)){
        swap_run(a->data,(ln_intp)a->descr->elsize,count,a->descr);return 0;
    }
    /* Match IterAllButAxis's positive-minimum-stride axis selection, including
     * its first-nonzero initialization and stable tie behavior. */
    int axis=0,d=0;ln_intp minimum=0;
    while(!minimum&&d<a->nd)minimum=a->strides[d++];
    for(d=1;d<a->nd;++d)if(a->strides[d]>0&&a->strides[d]<minimum){axis=d;minimum=a->strides[d];}
    ln_intp outer=count/a->dimensions[axis],coordinates[LN_MAXDIMS]={0};
    for(ln_intp i=0;i<outer;++i){
        char *data=a->data;
        for(d=0;d<a->nd;++d)if(d!=axis)data+=coordinates[d]*a->strides[d];
        swap_run(data,a->strides[axis],a->dimensions[axis],a->descr);
        for(d=a->nd-1;d>=0;--d)if(d!=axis){
            if(++coordinates[d]<a->dimensions[d])break;
            coordinates[d]=0;
        }
    }
    return 0;
}
ln_array *ln_bytes_swap_copy(const ln_array *a,ln_error *err)
{
    ln_array *result=ln_creation_convert(a,NULL,'A',1,-1,NULL,err);if(!result)return NULL;
    if(ln_bytes_swap_inplace(result,err)<0){ln_array_free(result);return NULL;}
    return result;
}
