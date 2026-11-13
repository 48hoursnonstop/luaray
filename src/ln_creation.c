/* Host-independent creation layout: NumPy2.5.3 ctors.c NewLikeArray K-order. */
#include "ln_core.h"
#include <stdio.h>
#include "ln_creation.h"
#include "ln_dtype_transfer.h"
#include "ln_write.h"
#include "ln_string.h"
#include "ln_ufunc.h"
#include "ln_truth.h"
#include <string.h>
#include <ctype.h>


static void keeporder_shape_strides(ln_array *out,const ln_array *prototype)
{
    int axes[LN_MAXDIMS];for(int i=0;i<out->nd;++i)axes[i]=i;
    for(int i=1;i<out->nd;++i) {
        int selected=axes[i],j=i;ln_intp stride=prototype->strides[selected];
        uintmax_t magnitude=stride<0?(uintmax_t)(-(stride+1))+1:(uintmax_t)stride;
        while(j>0) {
            int previous=axes[j-1];ln_intp value=prototype->strides[previous];
            uintmax_t compare=value<0?(uintmax_t)(-(value+1))+1:(uintmax_t)value;
            if(compare<magnitude||(compare==magnitude&&previous>selected))break;
            axes[j]=previous;--j;
        }
        axes[j]=selected;
    }
    ln_intp stride=(ln_intp)out->descr->elsize;
    for(int i=0;i<out->nd;++i){int axis=axes[i];out->strides[axis]=stride;stride*=out->dimensions[axis];}
    ln_update_contiguous_flags(out);
}

ln_array *ln_array_new_keeporder(const ln_array *a,const ln_dtype *dtype,ln_error *err)
{
    if(!a){if(err)snprintf(err->message,sizeof(err->message),"missing array prototype");return NULL;}
    int fortran=(a->flags&LN_ARRAY_F_CONTIGUOUS)&&!(a->flags&LN_ARRAY_C_CONTIGUOUS);
    ln_array *out=ln_array_new(a->nd,a->dimensions,dtype?dtype:a->descr,fortran,0,err);
    if(!out)return NULL;
    ln_intp size=ln_array_size(a);
    if(size&&!(a->flags&(LN_ARRAY_C_CONTIGUOUS|LN_ARRAY_F_CONTIGUOUS)))
        keeporder_shape_strides(out,a);
    return out;
}


static ln_array *creation_bad(ln_error *err,const char *message)
{if(err)snprintf(err->message,sizeof(err->message),"%s",message);return NULL;}
static int creation_order(char order)
{return order=='C'||order=='F'||order=='A'||order=='K';}

ln_array *ln_creation_new_like(const ln_array *prototype,const ln_dtype *dtype,
    char order,int nd,const ln_intp *dims,ln_error *err)
{
    order=(char)toupper((unsigned char)order);
    if(!prototype||!creation_order(order)||nd< -1||nd>LN_MAXDIMS)return creation_bad(err,"invalid like-array creation arguments");
    if(nd== -1){nd=prototype->nd;dims=prototype->dimensions;}
    else if(nd!=prototype->nd&&order=='K')order='C';
    if(nd&& !dims)return creation_bad(err,"missing array shape");
    if(!dtype)dtype=prototype->descr;
    if(ln_string_is_dtype(dtype)&&ln_string_nchars(dtype)==0) {
        dtype=ln_string_make_dtype(dtype->type_num==LN_UNICODE,1,dtype->byteorder,err);if(!dtype)return NULL;
    }
    if(order=='A')order=(prototype->flags&LN_ARRAY_F_CONTIGUOUS)&&!(prototype->flags&LN_ARRAY_C_CONTIGUOUS)?'F':'C';
    if(order=='K') {
        if((prototype->flags&LN_ARRAY_C_CONTIGUOUS)||nd<=1)order='C';
        else if(prototype->flags&LN_ARRAY_F_CONTIGUOUS)order='F';
    }
    ln_array *out=ln_array_new(nd,dims,dtype,order=='F',0,err);if(!out)return NULL;
    if(order=='K'&&ln_array_size(out))keeporder_shape_strides(out,prototype);
    return out;
}
ln_array *ln_creation_convert(const ln_array *input,const ln_dtype *dtype,
    char order,int copy,int ndmin,int *identity,ln_error *err)
{
    if(identity)*identity=0;
    order=(char)toupper((unsigned char)order);
    if(!input||!creation_order(order)||copy< -1||copy>1||ndmin>LN_MAXDIMS)return creation_bad(err,"invalid array conversion arguments");
    if(!dtype)dtype=input->descr;
    int c=(input->flags&LN_ARRAY_C_CONTIGUOUS)!=0,f=(input->flags&LN_ARRAY_F_CONTIGUOUS)!=0;
    int same=ln_dtype_cast_safety(input->descr,dtype)==LN_NO_CASTING;
    int striding_ok=order=='K'||order=='A'||(order=='C'&&c)||(order=='F'&&f);
    int needs_copy=copy==1||!same||!striding_ok;
    if(copy==0&&needs_copy)return creation_bad(err,"unable to avoid a copy while creating an array as requested");
    ln_array *out;
    if(needs_copy) {
        /* FromArray defaults dtype-changing ANYORDER transfers to KEEPORDER;
         * same-dtype copy shortcuts retain the requested ANYORDER behavior. */
        char allocation_order=order=='A'&&!same?'K':order;
        out=ln_creation_new_like(input,dtype,allocation_order,-1,NULL,err);if(!out)return NULL;
        if(ln_array_copyto(out,input,NULL,1,LN_UNSAFE_CASTING,err)<0){ln_array_free(out);return NULL;}
    }
    else {
        out=ln_array_view(input,input->nd,input->dimensions,input->strides,input->data,err);if(!out)return NULL;
        out->descr=dtype;
    }
    if(ndmin>out->nd) {
        ln_intp dims[LN_MAXDIMS],strides[LN_MAXDIMS];int extra=ndmin-out->nd;
        ln_intp stride=order=='F'||((out->flags&LN_ARRAY_F_CONTIGUOUS)&&!(out->flags&LN_ARRAY_C_CONTIGUOUS))||out->nd==0?
            (ln_intp)out->descr->elsize:out->strides[0]*out->dimensions[0];
        for(int j=0;j<ndmin;++j){dims[j]=j<extra?1:out->dimensions[j-extra];strides[j]=j<extra?stride:out->strides[j-extra];}
        ln_array *view=ln_array_view(out,ndmin,dims,strides,out->data,err);ln_array_free(out);out=view;
        if(!out)return NULL;
    }
    else if(identity&& !needs_copy&&input->descr==dtype)*identity=1;
    return out;
}
int ln_creation_checkfinite(const ln_array *input,ln_error *err)
{
    if(!input){creation_bad(err,"missing finite-check input");return -1;}
    if(input->descr->kind!='f'&&input->descr->kind!='c')return 0;
    const ln_array *inputs[]={input};ln_array *mask=NULL;
    if(ln_ufunc_execute(ln_ufunc_by_name("isfinite"),inputs,&mask,NULL,err)<0)return -1;
    uint8_t axes[LN_MAXDIMS];memset(axes,1,sizeof(axes));
    ln_array *all=ln_truth_reduce(mask,axes,0,NULL,1,NULL,err);ln_array_free(mask);
    if(!all)return -1;
    int finite=all->data[0]!=0;ln_array_free(all);
    if(!finite){creation_bad(err,"array must not contain infs or NaNs");return -1;}
    return 0;
}
