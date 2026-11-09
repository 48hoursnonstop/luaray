#include "ln_matrix.h"
#include "ln_layout.h"
#include <stdint.h>
#include <stdio.h>
#include <string.h>
/* NumPy 2.5.3 item_selection.c:PyArray_Diagonal and _twodim_base_impl.py.
 * See THIRD_PARTY_NUMPY_LICENSE.txt for the retained BSD notice. */
static ln_array *failure(ln_error *err,const char *message)
{
    if(err){snprintf(err->message,sizeof err->message,"%s",message);err->kind=LN_ERROR_VALUE;}
    return NULL;
}
ln_array *ln_matrix_diagonal(const ln_array *a,ln_intp offset,int axis1,int axis2,ln_error *err)
{
    if(!a||a->nd<2)return failure(err,"diagonal requires at least two dimensions");
    if(axis1<0||axis1>=a->nd||axis2<0||axis2>=a->nd||axis1==axis2)
        return failure(err,"diagonal axes must be distinct existing axes");
    ln_intp n1=a->dimensions[axis1],n2=a->dimensions[axis2];
    ln_intp length=0,start=0;
    int shifted_axis=offset<0?axis1:axis2;
    /* Avoid negating INTPTR_MIN, including empty diagonals. */
    if(offset>=0){if(offset<=n2){start=offset;n2-=offset;length=n1<n2?n1:n2;}}
    else if(offset!=INTPTR_MIN&&-offset<=n1){start=-offset;n1+=offset;length=n1<n2?n1:n2;}
    ln_intp s1=a->strides[axis1],s2=a->strides[axis2];
    if((s2>0&&s1>INTPTR_MAX-s2)||(s2<0&&s1<INTPTR_MIN-s2))
        return failure(err,"diagonal stride overflow");
    ln_intp shape[LN_MAXDIMS],strides[LN_MAXDIMS];int j=0;
    for(int d=0;d<a->nd;++d)if(d!=axis1&&d!=axis2){shape[j]=a->dimensions[d];strides[j++]=a->strides[d];}
    shape[j]=length;strides[j]=s1+s2;
    /* Empty views have no dereferenceable elements. Keep their data inside
     * the owner rather than forming an out-of-allocation pointer. */
    char *data=a->data;
    if(length>0){
        ln_intp stride=a->strides[shifted_axis];
        if(start&&((stride>0&&start>INTPTR_MAX/stride)||(stride<0&&stride<INTPTR_MIN/start)))
            return failure(err,"diagonal offset overflow");
        data+=start*stride;
    }
    ln_array *view=ln_array_view(a,a->nd-1,shape,strides,data,err);
    if(view)view->flags&=~LN_ARRAY_WRITEABLE;
    return view;
}
ln_array *ln_matrix_diag(const ln_array *a,ln_intp offset,int flatten,ln_error *err)
{
    if(!a||(!flatten&&a->nd!=1&&a->nd!=2))return failure(err,"diag input must be one- or two-dimensional");
    if(!flatten&&a->nd==2)return ln_matrix_diagonal(a,offset,0,1,err);
    ln_array *flat=ln_layout_ravel(a,'C',err);if(!flat)return NULL;
    ln_intp size=ln_array_size(flat);
    if(offset==INTPTR_MIN||size<0||size>INTPTR_MAX-(offset<0?-offset:offset)){
        ln_array_free(flat);return failure(err,"diagonal shape overflow");
    }
    ln_intp side=size+(offset<0?-offset:offset),shape[]={side,side};
    ln_array *out=ln_array_new(2,shape,a->descr,0,1,err);
    if(out&&size){
        ln_intp row=offset<0?-offset:0,col=offset>0?offset:0;
        for(ln_intp i=0;i<size;++i)
            memcpy(out->data+(row+i)*out->strides[0]+(col+i)*out->strides[1],
                   flat->data+i*flat->strides[0],a->descr->elsize);
    }
    ln_array_free(flat);return out;
}
