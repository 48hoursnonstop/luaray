#include "ln_bincount.h"
#include "ln_dtype_transfer.h"
#include <stdint.h>
#include <stdio.h>
#include <string.h>
/* NumPy 2.5.3 compiled_base.c:arr_bincount. Unlike location helpers,
 * category zero is valid data and is not rebased at the Lua boundary. */
static int bad(ln_error *err,const char *message,int type)
{if(err){snprintf(err->message,sizeof err->message,"%s",message);err->kind=type?LN_ERROR_TYPE:LN_ERROR_VALUE;}return -1;}
static const ln_dtype *intp_dtype(void)
{return ln_dtype_by_name(sizeof(ln_intp)==8?"int64":"int32");}
static int label_at(const ln_array *labels,ln_intp i,ln_intp *value,ln_error *err)
{return ln_cast_strided_numeric(labels->data+i*labels->strides[0],0,labels->descr,(char*)value,0,intp_dtype(),1,err);}
int ln_bincount_shape(const ln_array *labels,ln_intp minlength,
                      ln_intp *output_length,ln_error *err)
{
    if(!labels||!output_length)return bad(err,"missing bincount labels or output length",0);
    if(labels->nd!=1)return bad(err,"bincount labels must be one-dimensional",0);
    if(labels->descr->kind!='b'&&labels->descr->kind!='i'&&labels->descr->kind!='u')
        return bad(err,"bincount labels must have integer or Boolean dtype",1);
    if(minlength<0)return bad(err,"minlength must not be negative",0);
    ln_intp length=minlength;
    for(ln_intp i=0;i<labels->dimensions[0];i++){
        ln_intp value;if(label_at(labels,i,&value,err)<0)return -1;
        if(value<0)return bad(err,"bincount labels must not be negative",0);
        if(value==INTPTR_MAX)return bad(err,"bincount label exceeds representable output size",0);
        if(value>=length)length=value+1;
    }
    *output_length=length;return 0;
}
ln_array *ln_bincount(const ln_array *labels,const ln_array *weights,
                     ln_intp minlength,ln_error *err)
{
    ln_intp length;
    if(ln_bincount_shape(labels,minlength,&length,err)<0)return NULL;
    ln_intp size=labels->dimensions[0];const ln_dtype *dtype=intp_dtype();
    /* NumPy's empty branch returns intp zeros without inspecting weights. */
    if(size&&weights){
        dtype=ln_dtype_by_name("float64");
        if(weights->nd!=1){bad(err,"bincount weights must be one-dimensional",0);return NULL;}
        if(!ln_dtype_can_cast(weights->descr,dtype,LN_SAFE_CASTING)){
            bad(err,"bincount weights cannot safely cast to float64",1);return NULL;
        }
        if(weights->dimensions[0]!=size){bad(err,"bincount weights and labels must have the same length",0);return NULL;}
    }
    ln_array *out=ln_array_new(1,&length,dtype,0,1,err);if(!out)return NULL;
    for(ln_intp i=0;i<size;i++){
        ln_intp label;if(label_at(labels,i,&label,err)<0)goto fail;
        if(weights){
            double value,sum;
            if(ln_cast_strided_numeric(weights->data+i*weights->strides[0],0,weights->descr,
                        (char*)&value,0,dtype,1,err)<0)goto fail;
            char *destination=out->data+label*sizeof(double);memcpy(&sum,destination,sizeof sum);
            sum+=value;memcpy(destination,&sum,sizeof sum);
        }else{
            ln_intp count;char *destination=out->data+label*sizeof(ln_intp);
            memcpy(&count,destination,sizeof count);count++;memcpy(destination,&count,sizeof count);
        }
    }
    return out;
fail:ln_array_free(out);return NULL;
}
