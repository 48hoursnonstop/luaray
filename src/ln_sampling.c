/* NumPy2.5.3 _core/function_base.py: native array-based sequence composition. */
#include "ln_sampling.h"
#include "ln_axis.h"
#include "ln_write.h"
#include "ln_half.h"
#include "ln_string.h"
#include <math.h>
#include <stdio.h>
#include <string.h>

static ln_array *bad(ln_error *err,const char *msg)
{if(err)snprintf(err->message,sizeof(err->message),"%s",msg);return NULL;}
static int inexact(const ln_dtype *dtype)
{return dtype&&(dtype->kind=='f'||dtype->kind=='c');}
static ln_array *operation(const char *name,const ln_array *a,const ln_array *b,
                            ln_array *out,ln_error *err)
{
    const ln_array *inputs[]={a,b};ln_array *outputs[]={out};
    if(ln_ufunc_execute(ln_ufunc_by_name(name),inputs,outputs,NULL,err)<0)return NULL;
    return outputs[0];
}
static ln_array *weak_operation(const char *name,const ln_array *a,
                                 ln_intp b,ln_array *out,ln_error *err)
{
    ln_ufunc_operand inputs[]={{.kind=LN_UFUNC_OPERAND_ARRAY,.array=a},
                               {.kind=LN_UFUNC_WEAK_INT,.integer=b}};
    ln_array *outputs[]={out};
    if(ln_ufunc_execute_operands(ln_ufunc_by_name(name),inputs,outputs,NULL,err)<0)return NULL;
    return outputs[0];
}
/* Resolve a numeric loop using the explicit inexact DType class, then let
 * the iterator convert the original strided operands directly into that loop.
 * No C-order input materialization changes KEEPORDER output allocation. */
static ln_array *difference(const ln_array *stop,const ln_array *start,
                             const ln_dtype *dtype,ln_error *err)
{
    const ln_ufunc *u=ln_ufunc_by_name("subtract");
    ln_array typed={.nd=0,.descr=dtype};const ln_array *resolve_inputs[]={&typed,&typed};
    const ln_ufunc_loop *method=NULL;
    if(u->resolve(u,resolve_inputs,&method,err)<0||!method)return NULL;
    const ln_array *inputs[]={stop,start};const ln_dtype *dtypes[]={dtype,dtype,dtype};
    ln_array *outputs[]={NULL};
    if(ln_nditer_multi_execute(2,1,inputs,outputs,NULL,dtypes,method->loop,
            method->data,method->validate,method->validate_data,err)<0)return NULL;
    return outputs[0];
}
static ln_array *cast_copy(const ln_array *a,const ln_dtype *dtype,ln_error *err)
{
    if(ln_string_is_dtype(dtype)&&!dtype->elsize){
        dtype=ln_string_make_dtype(dtype->kind=='U',ln_legacy_string_width_for_dtype(a->descr),dtype->byteorder,err);
        if(!dtype)return NULL;
    }
    ln_array *out=ln_array_new_keeporder(a,dtype,err);if(!out)return NULL;
    if(ln_array_copyto(out,a,NULL,1,LN_UNSAFE_CASTING,err)<0){ln_array_free(out);return NULL;}
    return out;
}
static ln_array *move_sample_axis(const ln_array *a,int axis,ln_error *err)
{
    int order[LN_MAXDIMS],j=1;
    for(int k=0;k<a->nd;++k)order[k]=k==axis?0:j++;
    return ln_axis_permute(a,order,err);
}
static int any_zero(const ln_array *a,ln_error *err)
{
    ln_array *mask=weak_operation("equal",a,0,NULL,err);
    if(!mask)return -1;
    int zero=0;ln_intp size=ln_array_size(mask);
    for(ln_intp i=0;i<size;++i)if(mask->data[i]){zero=1;break;}
    ln_array_free(mask);return zero;
}

static int floor_values(ln_array *a,ln_error *err)
{
    if(a->descr->kind!='f'){bad(err,"integer linspace output requires a real computation dtype");return -1;}
    ln_intp size=ln_array_size(a),idx[LN_MAXDIMS]={0};
    for(ln_intp i=0;i<size;++i) {
        ln_intp off=0;for(int d=0;d<a->nd;++d)off+=idx[d]*a->strides[d];char *p=a->data+off;
        switch(a->descr->type_num) {
            case LN_HALF:{ln_half x;memcpy(&x,p,2);x=ln_float_to_half(floorf(ln_half_to_float(x)));memcpy(p,&x,2);break;}
            case LN_FLOAT:{float x;memcpy(&x,p,sizeof(x));x=floorf(x);memcpy(p,&x,sizeof(x));break;}
            case LN_DOUBLE:{double x;memcpy(&x,p,sizeof(x));x=floor(x);memcpy(p,&x,sizeof(x));break;}
            case LN_LONGDOUBLE:{long double x;memcpy(&x,p,sizeof(x));x=floorl(x);memcpy(p,&x,sizeof(x));break;}
            default:bad(err,"unsupported linspace floor dtype");return -1;
        }
        for(int d=a->nd-1;d>=0;--d){if(++idx[d]<a->dimensions[d])break;idx[d]=0;}
    }
    return 0;
}
static int replace_endpoint(ln_array *a,ln_intp sample,const ln_array *value,ln_error *err)
{
    char *data=a->data;if(ln_array_size(a))data+=sample*a->strides[0];
    ln_array *row=ln_array_view(a,a->nd-1,a->dimensions+1,a->strides+1,data,err);
    if(!row)return -1;
    int rc=ln_array_copyto(row,value,NULL,1,LN_UNSAFE_CASTING,err);ln_array_free(row);return rc;
}
ln_array *ln_sampling_linspace(const ln_array *start,const ln_array *stop,
    ln_intp count,int endpoint,int axis,const ln_dtype *compute_dtype,
    const ln_dtype *output_dtype,ln_array **returned_step,ln_error *err)
{
    if(returned_step)*returned_step=NULL;
    if(!start||!stop||!inexact(compute_dtype)||count<0)return bad(err,"linspace requires non-negative count and numeric endpoints");
    ln_array *delta=NULL,*step=NULL,*sequence=NULL,*y=NULL,*result=NULL;
    delta=difference(stop,start,compute_dtype,err);if(!delta)goto done;
    if(delta->nd>=LN_MAXDIMS||axis<0||axis>delta->nd){bad(err,"linspace axis out of bounds");goto done;}
    sequence=ln_array_new(1,&count,compute_dtype,0,0,err);if(!sequence)goto done;
    for(ln_intp i=0;i<count;++i)if(ln_array_set_number(sequence,&i,0,i,1,err)<0)goto done;
    ln_intp shape[LN_MAXDIMS];shape[0]=count;for(int i=1;i<=delta->nd;++i)shape[i]=1;
    y=ln_array_reshape_c(sequence,delta->nd+1,shape,err);if(!y)goto done;
    ln_intp div=endpoint?count-1:count;
    if(div>0) {
        step=weak_operation("true_divide",delta,div,NULL,err);if(!step)goto done;
        int zero=any_zero(step,err);if(zero<0)goto done;
        if(zero) {
            if(!weak_operation("true_divide",y,div,y,err))goto done;
        }
        ln_array *factor=zero?delta:step;
        if(delta->nd==0) {if(!operation("multiply",y,factor,y,err))goto done;}
        else {ln_array *next=operation("multiply",y,factor,NULL,err);if(!next)goto done;ln_array_free(y);y=next;}
    }
    else {
        step=ln_array_new(0,NULL,ln_dtype_by_num(LN_DOUBLE),0,0,err);if(!step)goto done;
        if(ln_array_set_number(step,NULL,NAN,0,0,err)<0)goto done;
        ln_array *next=operation("multiply",y,delta,NULL,err);if(!next)goto done;ln_array_free(y);y=next;
    }
    if(!operation("add",y,start,y,err))goto done;
    if(endpoint&&count>1&&replace_endpoint(y,count-1,stop,err)<0)goto done;
    if(axis){ln_array *next=move_sample_axis(y,axis,err);if(!next)goto done;ln_array_free(y);y=next;}
    if(output_dtype&&(output_dtype->kind=='i'||output_dtype->kind=='u')&&floor_values(y,err)<0)goto done;
    if(output_dtype&&output_dtype!=y->descr)result=cast_copy(y,output_dtype,err);
    else {result=y;y=NULL;}
    if(result&&returned_step){*returned_step=step;step=NULL;}
done:
    ln_array_free(delta);ln_array_free(step);ln_array_free(sequence);ln_array_free(y);return result;
}
static ln_array *pad_rank(const ln_array *a,int nd,ln_error *err)
{
    ln_intp dims[LN_MAXDIMS];int extra=nd-a->nd;
    for(int j=0;j<nd;++j)dims[j]=j<extra?1:a->dimensions[j-extra];
    return ln_array_reshape_c(a,nd,dims,err);
}
ln_array *ln_sampling_logspace(const ln_array *start,const ln_array *stop,
    const ln_ufunc_operand *base,ln_intp count,int endpoint,int axis,
    const ln_dtype *compute_dtype,const ln_dtype *output_dtype,ln_error *err)
{
    if(!start||!stop||!base)return bad(err,"logspace requires endpoints and base");
    ln_array *padded_start=NULL,*padded_stop=NULL,*expanded_base=NULL,*y=NULL,*powered=NULL,*result=NULL;
    ln_ufunc_operand inputs[2];inputs[0]=*base;
    if(base->kind==LN_UFUNC_OPERAND_ARRAY) {
        if(!base->array){bad(err,"logspace base array is missing");goto done;}
        if(base->array->nd) {
            const ln_array *arrays[]={start,stop,base->array};int nd;ln_intp dims[LN_MAXDIMS];
            if(ln_broadcast_shape(3,arrays,&nd,dims,err)<0)goto done;
            if(nd>=LN_MAXDIMS||axis<0||axis>nd){bad(err,"logspace axis out of bounds");goto done;}
            padded_start=pad_rank(start,nd,err);padded_stop=pad_rank(stop,nd,err);
            ln_array *padded_base=pad_rank(base->array,nd,err);if(!padded_base)goto done;
            unsigned char positions[LN_MAXDIMS]={0};positions[axis]=1;
            expanded_base=ln_axis_expand(padded_base,positions,nd+1,err);ln_array_free(padded_base);
            if(!padded_start||!padded_stop||!expanded_base)goto done;
            start=padded_start;stop=padded_stop;inputs[0].array=expanded_base;
        }
    }
    y=ln_sampling_linspace(start,stop,count,endpoint,axis,compute_dtype,NULL,NULL,err);if(!y)goto done;
    inputs[1]=(ln_ufunc_operand){.kind=LN_UFUNC_OPERAND_ARRAY,.array=y};
    ln_array *outputs[]={NULL};
    if(ln_ufunc_execute_operands(ln_ufunc_by_name("power"),inputs,outputs,NULL,err)<0)goto done;
    powered=outputs[0];
    if(output_dtype&&output_dtype!=powered->descr)result=cast_copy(powered,output_dtype,err);
    else {result=powered;powered=NULL;}
done:
    ln_array_free(padded_start);ln_array_free(padded_stop);ln_array_free(expanded_base);ln_array_free(y);ln_array_free(powered);return result;
}
ln_array *ln_sampling_geomspace(const ln_array *start,const ln_array *stop,
    ln_intp count,int endpoint,int axis,const ln_dtype *compute_dtype,
    const ln_dtype *output_dtype,ln_error *err)
{
    if(!start||!stop||!inexact(compute_dtype))return bad(err,"geomspace requires numeric endpoints");
    int zero=any_zero(start,err);if(zero<0)return NULL;if(zero)return bad(err,"geometric sequence cannot include zero");
    zero=any_zero(stop,err);if(zero<0)return NULL;if(zero)return bad(err,"geometric sequence cannot include zero");
    ln_array *a=NULL,*b=NULL,*sign=NULL,*log_a=NULL,*log_b=NULL,*y=NULL,*result=NULL;
    a=cast_copy(start,compute_dtype,err);b=cast_copy(stop,compute_dtype,err);if(!a||!b)goto done;
    sign=operation("sign",a,NULL,NULL,err);if(!sign)goto done;
    if(!operation("true_divide",a,sign,a,err))goto done;
    ln_array *next=operation("true_divide",b,sign,NULL,err);if(!next)goto done;ln_array_free(b);b=next;
    log_a=operation("log10",a,NULL,NULL,err);log_b=operation("log10",b,NULL,NULL,err);if(!log_a||!log_b)goto done;
    ln_ufunc_operand base={.kind=LN_UFUNC_WEAK_FLOAT,.floating=10.0};
    y=ln_sampling_logspace(log_a,log_b,&base,count,endpoint,0,compute_dtype,compute_dtype,err);if(!y)goto done;
    if(count>0&&replace_endpoint(y,0,a,err)<0)goto done;
    if(count>1&&endpoint&&replace_endpoint(y,count-1,b,err)<0)goto done;
    if(!operation("multiply",y,sign,y,err))goto done;
    if(axis<0||axis>=y->nd){bad(err,"geomspace axis out of bounds");goto done;}
    if(axis){next=move_sample_axis(y,axis,err);if(!next)goto done;ln_array_free(y);y=next;}
    if(output_dtype&&output_dtype!=y->descr)result=cast_copy(y,output_dtype,err);
    else {result=y;y=NULL;}
done:
    ln_array_free(a);ln_array_free(b);ln_array_free(sign);ln_array_free(log_a);ln_array_free(log_b);ln_array_free(y);return result;
}
