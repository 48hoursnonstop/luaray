#include "ln_vector.h"
#include "ln_axis.h"
#include "ln_creation.h"
#include "ln_layout.h"
#include "ln_ufunc.h"
#include <stdio.h>
#include <string.h>
/* NumPy2.5.3 _core/numeric.py:cross and lib/_function_base_impl.py:meshgrid.
 * NumPy BSD attribution remains in THIRD_PARTY_NUMPY_LICENSE.txt. */
static int failure(ln_error *err,const char *message)
{
    if(err){snprintf(err->message,sizeof err->message,"%s",message);err->kind=LN_ERROR_VALUE;}
    return -1;
}
static ln_array *move_axis(const ln_array *a,int source,int destination,ln_error *err)
{
    int order[LN_MAXDIMS],j=0;
    for(int i=0;i<a->nd;++i)if(i!=source)order[j++]=i;
    for(int i=a->nd-1;i>destination;--i)order[i]=order[i-1];
    order[destination]=source;return ln_axis_permute(a,order,err);
}
static ln_array *component(const ln_array *a,int index,ln_error *err)
{
    return ln_array_view(a,a->nd-1,a->dimensions,a->strides,
                         a->data+index*a->strides[a->nd-1],err);
}
static int binary(const char *name,const ln_array *a,const ln_array *b,
        ln_array **output,ln_error *err)
{
    const ln_array *inputs[]={a,b};return ln_ufunc_execute(ln_ufunc_by_name(name),inputs,output,NULL,err);
}
ln_array *ln_vector_cross(const ln_array *a,int axis_a,const ln_array *b,
        int axis_b,int axis_out,ln_error *err)
{
    if(!a||!b||a->nd<1||b->nd<1){failure(err,"cross inputs must have at least one dimension");return NULL;}
    if(axis_a<0||axis_a>=a->nd||axis_b<0||axis_b>=b->nd){failure(err,"cross input axis is out of bounds");return NULL;}
    if(a->dimensions[axis_a]!=3||b->dimensions[axis_b]!=3){failure(err,"cross requires three components in both inputs");return NULL;}
    const ln_dtype *dtype=ln_common_dtype_descr(a->descr,b->descr);
    if(!dtype){failure(err,"cross inputs have no common dtype");return NULL;}
    ln_array *moved[2]={0},*cast[2]={0},*ac[3]={0},*bc[3]={0},*cpv[3]={0},*cp=NULL,*tmp=NULL,*result=NULL;
    moved[0]=move_axis(a,axis_a,a->nd-1,err);moved[1]=move_axis(b,axis_b,b->nd-1,err);
    if(!moved[0]||!moved[1])goto finish;
    for(int i=0;i<2;++i){cast[i]=ln_creation_convert(moved[i],dtype,'K',1,0,NULL,err);if(!cast[i])goto finish;}
    for(int i=0;i<3;++i){ac[i]=component(cast[0],i,err);bc[i]=component(cast[1],i,err);if(!ac[i]||!bc[i])goto finish;}
    const ln_array *bcshape[]={ac[0],bc[0]};int nd;
    ln_intp shape[LN_MAXDIMS];if(ln_broadcast_shape(2,bcshape,&nd,shape,err)<0)goto finish;
    if(nd>=LN_MAXDIMS||axis_out<0||axis_out>nd){failure(err,"cross result axis is out of bounds");goto finish;}
    shape[nd]=3;cp=ln_array_new(nd+1,shape,dtype,0,0,err);if(!cp)goto finish;
    for(int i=0;i<3;++i){cpv[i]=component(cp,i,err);if(!cpv[i])goto finish;}
    /* The common dtype is fixed before all products. Reuse one temporary,
     * writing through the actual component views, in the source order. */
    if(binary("multiply",ac[1],bc[2],&cpv[0],err)<0||
       binary("multiply",ac[2],bc[1],&tmp,err)<0||
       binary("subtract",cpv[0],tmp,&cpv[0],err)<0||
       binary("multiply",ac[2],bc[0],&cpv[1],err)<0||
       binary("multiply",ac[0],bc[2],&tmp,err)<0||
       binary("subtract",cpv[1],tmp,&cpv[1],err)<0||
       binary("multiply",ac[0],bc[1],&cpv[2],err)<0||
       binary("multiply",ac[1],bc[0],&tmp,err)<0||
       binary("subtract",cpv[2],tmp,&cpv[2],err)<0)goto finish;
    result=move_axis(cp,nd,axis_out,err);
finish:
    for(int i=0;i<2;++i){ln_array_free(moved[i]);ln_array_free(cast[i]);}
    for(int i=0;i<3;++i){ln_array_free(ac[i]);ln_array_free(bc[i]);ln_array_free(cpv[i]);}
    ln_array_free(cp);ln_array_free(tmp);return result;
}
int ln_vector_meshgrid(int count,const ln_array *const *inputs,int copy,
        int sparse,int xy,ln_array **outputs,ln_error *err)
{
    if(count<0||count>LN_MAXDIMS||(count&&(!inputs||!outputs)))return failure(err,"meshgrid supports zero to64 input vectors");
    for(int i=0;i<count;++i)outputs[i]=NULL;
    ln_intp full[LN_MAXDIMS];
    for(int i=0;i<count;++i){
        if(!inputs[i])return failure(err,"invalid meshgrid input");
        ln_intp size=ln_array_size(inputs[i]);if(size<0)return failure(err,"meshgrid input size overflow");
        int axis=xy&&count>1&&i<2?1-i:i;full[axis]=size;
    }
    for(int i=0;i<count;++i){
        int axis=xy&&count>1&&i<2?1-i:i;
        ln_intp shape[LN_MAXDIMS];for(int d=0;d<count;++d)shape[d]=1;shape[axis]=-1; /* Source always infers this dimension, including empty/singleton inputs. */
        ln_array *view=ln_layout_reshape(inputs[i],count,shape,'C',-1,err);if(!view)goto fail;
        if(!sparse){
            ln_array *expanded=ln_axis_broadcast_to(view,count,full,0,err);ln_array_free(view);view=expanded;
            if(!view)goto fail;
        }
        if(copy){
            ln_array *owned=ln_creation_convert(view,NULL,'C',1,0,NULL,err);ln_array_free(view);view=owned;
            if(!view)goto fail;
        }
        outputs[i]=view;
    }
    return 0;
fail:
    for(int i=0;i<count;++i){ln_array_free(outputs[i]);outputs[i]=NULL;}
    return -1;
}
