#include "ln_index_math.h"
#include "ln_dtype_transfer.h"
#include "ln_order.h"
#include <stdio.h>
#include <string.h>
/* NumPy 2.5.3 compiled_base.c ravel/unravel loops and nditer_api.c
 * CreateCompatibleStrides, with explicit Lua location conversion. */
static ln_array *bad(ln_error *err,const char *message)
{if(err){snprintf(err->message,sizeof err->message,"%s",message);err->kind=LN_ERROR_VALUE;}return NULL;}
static const ln_dtype *intp_dtype(void)
{return ln_dtype_by_name(sizeof(ln_intp)==8?"int64":"int32");}
static int integer_input(const ln_array *a,ln_error *err)
{
    if(!a||(a->descr->kind!='b'&&a->descr->kind!='i'&&a->descr->kind!='u')){
        bad(err,"only integer index arrays are permitted");if(err)err->kind=LN_ERROR_TYPE;return -1;
    }
    return 0;
}
static int shape_valid(int nd,const ln_intp *dimensions,ln_error *err)
{
    if(nd<0||nd>LN_MAXDIMS||(nd&&!dimensions)){bad(err,"invalid index target shape");return -1;}
    for(int i=0;i<nd;i++)if(dimensions[i]<0){bad(err,"negative target dimensions are not permitted");return -1;}
    return 0;
}
static int load_location(const char *source,const ln_dtype *dtype,ln_intp *value,ln_error *err)
{
    if(ln_cast_strided_numeric(source,0,dtype,(char*)value,0,intp_dtype(),1,err)<0)return -1;
    if(*value==0){bad(err,"index zero is invalid in Lua's one-based location model");return -1;}
    if(*value>0)(*value)--;
    return 0;
}
static void advance(int nd,const ln_intp *shape,ln_intp *position)
{for(int d=nd-1;d>=0;d--){if(++position[d]<shape[d])break;position[d]=0;}}

ln_array *ln_ravel_multi_index(int nd,const ln_intp *dimensions,
    const ln_array *const *coordinates,const ln_index_mode *modes,char order,ln_error *err)
{
    if(shape_valid(nd,dimensions,err)<0)return NULL;
    if(nd>=LN_MAXDIMS)return bad(err,"ravel_multi_index supports at most 63 coordinate axes");
    if(order!='C'&&order!='F')return bad(err,"index order must be C or F");
    if(nd&&(!coordinates||!modes))return bad(err,"missing coordinates or modes");
    ln_intp flat_strides[LN_MAXDIMS],size=1;
    for(int j=0;j<nd;j++){
        int i=order=='C'?nd-1-j:j;flat_strides[i]=size;
        if(ln_mul_sizes_with_overflow(&size,size,dimensions[i])!=0)return bad(err,"target shape size exceeds intp");
        if(modes[i]<LN_INDEX_CLIP||modes[i]>LN_INDEX_RAISE)return bad(err,"invalid coordinate bounds mode");
        if(integer_input(coordinates[i],err)<0)return NULL;
    }
    int rank=0;ln_intp shape[LN_MAXDIMS]={0};
    if(ln_broadcast_shape(nd,coordinates,&rank,shape,err)<0)return NULL;
    ln_array *out=ln_array_new(rank,rank?shape:NULL,intp_dtype(),0,0,err);if(!out)return NULL;
    ln_intp total=ln_array_size(out);
    if(total==0)return out;
    if(nd&&size==0){ln_array_free(out);return bad(err,"cannot index a target shape containing zero dimensions");}
    ln_intp broadcast[LN_MAXDIMS][LN_MAXDIMS];
    const ln_intp *rows[LN_MAXDIMS];
    for(int k=0;k<nd;k++){
        if(ln_broadcast_strides(rank,shape,coordinates[k]->nd,coordinates[k]->dimensions,
                coordinates[k]->strides,"coordinate",broadcast[k],err)<0)goto fail;
        rows[k]=broadcast[k];
    }
    int axes[LN_MAXDIMS];
    if(ln_keeporder_axes(rank,nd,rows,axes,err)<0)goto fail;
    ln_intp stride=(ln_intp)sizeof(ln_intp);
    for(int j=0;j<rank;j++){int d=axes[j];out->strides[d]=stride;stride*=shape[d];}
    ln_update_contiguous_flags(out);
    ln_intp position[LN_MAXDIMS]={0};
    for(ln_intp item=0;item<total;item++){
        ln_intp flat=0;
        for(int k=0;k<nd;k++){
            const char *source=coordinates[k]->data;
            for(int d=0;d<rank;d++)source+=position[d]*broadcast[k][d];
            ln_intp value;if(load_location(source,coordinates[k]->descr,&value,err)<0)goto fail;
            ln_intp dimension=dimensions[k];
            if(modes[k]==LN_INDEX_RAISE){if(value<0||value>=dimension){bad(err,"invalid entry in coordinate array");goto fail;}}
            else if(modes[k]==LN_INDEX_WRAP){value%=dimension;if(value<0)value+=dimension;}
            else{if(value<0)value=0;else if(value>=dimension)value=dimension-1;}
            flat+=value*flat_strides[k];
        }
        flat++;
        char *destination=out->data;
        for(int d=0;d<rank;d++)destination+=position[d]*out->strides[d];
        memcpy(destination,&flat,sizeof flat);advance(rank,shape,position);
    }
    return out;
fail:ln_array_free(out);return NULL;
}

ln_array *ln_unravel_index_storage(const ln_array *indices,int nd,
    const ln_intp *dimensions,char order,ln_error *err)
{
    if(shape_valid(nd,dimensions,err)<0||integer_input(indices,err)<0)return NULL;
    if(order!='C'&&order!='F')return bad(err,"index order must be C or F");
    if(indices->nd>=LN_MAXDIMS)return bad(err,"unravel input rank must be below 64");
    ln_intp size=1;
    for(int k=0;k<nd;k++)if(ln_mul_sizes_with_overflow(&size,size,dimensions[k])!=0)return bad(err,"target shape size exceeds intp");
    ln_intp shape[LN_MAXDIMS];
    for(int d=0;d<indices->nd;d++)shape[d]=indices->dimensions[d];
    shape[indices->nd]=nd;
    ln_array *storage=ln_array_new(indices->nd+1,shape,intp_dtype(),0,0,err);if(!storage)return NULL;
    ln_intp broadcast[LN_MAXDIMS];
    if(ln_broadcast_strides(indices->nd,indices->dimensions,indices->nd,
            indices->dimensions,indices->strides,"indices",broadcast,err)<0)goto fail;
    const ln_intp *rows[]={broadcast};int axes[LN_MAXDIMS];
    if(ln_keeporder_axes(indices->nd,1,rows,axes,err)<0)goto fail;
    ln_intp stride=(ln_intp)(nd*sizeof(ln_intp));
    for(int j=0;j<indices->nd;j++){
        int d=axes[j];storage->strides[d]=stride;
        if(ln_mul_sizes_with_overflow(&stride,stride,indices->dimensions[d])!=0){bad(err,"coordinate storage stride exceeds intp");goto fail;}
    }
    storage->strides[indices->nd]=(ln_intp)sizeof(ln_intp);ln_update_contiguous_flags(storage);
    ln_intp total=ln_array_size(indices),position[LN_MAXDIMS]={0};
    for(ln_intp item=0;item<total;item++){
        const char *source=indices->data;char *destination=storage->data;
        for(int d=0;d<indices->nd;d++){source+=position[d]*indices->strides[d];destination+=position[d]*storage->strides[d];}
        ln_intp value;if(load_location(source,indices->descr,&value,err)<0)goto fail;
        if(value<0||value>=size){bad(err,"flat index is outside target shape");goto fail;}
        for(int j=0;j<nd;j++){
            int d=order=='C'?nd-1-j:j;ln_intp coordinate=value%dimensions[d]+1;value/=dimensions[d];
            memcpy(destination+d*sizeof(ln_intp),&coordinate,sizeof coordinate);
        }
        advance(indices->nd,indices->dimensions,position);
    }
    if(nd==0&&indices->nd!=0){bad(err,"multiple indices are not supported for a scalar target shape");goto fail;}
    return storage;
fail:ln_array_free(storage);return NULL;
}
