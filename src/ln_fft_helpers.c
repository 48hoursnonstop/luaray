/* NumPy2.5.3 fft/_helper.py and _pocketfft.py Hermitian compositions. */
#include "ln_fft_helpers.h"
#include "ln_ufunc.h"
#include "ln_roll.h"
#include "ln_complex.h"
#include <stdio.h>
#include <math.h>
#include <string.h>

static ln_array *bad(ln_error *err,const char *message)
{ if(err)snprintf(err->message,sizeof(err->message),"%s",message);return NULL; }

ln_array *ln_fft_frequency(ln_intp n,const ln_array *spacing,int raw_scalar,
                           int real_only,ln_error *err)
{
    if(!spacing || (real_only!=0 && real_only!=1))return bad(err,"invalid frequency arguments");
    if(raw_scalar) {
        if(spacing->nd!=0)return bad(err,"scalar spacing must have zero dimensions");
        int zero=0,finite=1;
        if(spacing->descr->kind=='c') {
            long double real,imag;
            if(ln_array_get_complex(spacing,NULL,&real,&imag,err)<0)return NULL;
            zero=real==0 && imag==0;finite=isfinite(real)&&isfinite(imag);
        }
        else {
            double value=0;int64_t integer=0;int is_integer=0;
            if(ln_array_get_number(spacing,NULL,&value,&integer,&is_integer,err)<0)return NULL;
            zero=is_integer?integer==0:value==0;finite=is_integer || isfinite(value);
        }
        if((n==0 && finite) || zero)return bad(err,"frequency spacing division by zero");
    }
    if(n<0 && !real_only)return bad(err,"negative frequency array dimensions");
    ln_intp count=real_only?(n>=0?n/2+1:0):n;
    ln_array *bins=ln_array_new(1,&count,ln_dtype_by_name(sizeof(ln_intp)==8?"int64":"int32"),0,0,err);
    if(!bins)return NULL;
    ln_intp positive=n>0?(n-1)/2+1:0;
    for(ln_intp i=0;i<count;++i) {
        ln_intp value=real_only || i<positive?i:i-n;
        memcpy(bins->data+(size_t)i*sizeof(value),&value,sizeof(value));
    }
    ln_array *product[1]={NULL},*factor[1]={NULL},*out[1]={NULL};
    ln_ufunc_operand multiply[2]={{.kind=LN_UFUNC_WEAK_INT,.integer=n},
                                 {.kind=LN_UFUNC_OPERAND_ARRAY,.array=spacing}};
    if(ln_ufunc_execute_operands(ln_ufunc_by_name("multiply"),multiply,product,NULL,err)<0)goto done;
    ln_ufunc_operand reciprocal[2]={{.kind=LN_UFUNC_WEAK_FLOAT,.floating=1.0},
                                   {.kind=LN_UFUNC_OPERAND_ARRAY,.array=product[0]}};
    if(ln_ufunc_execute_operands(ln_ufunc_by_name("true_divide"),reciprocal,factor,NULL,err)<0)goto done;
    const ln_array *inputs[]={bins,factor[0]};
    if(ln_ufunc_execute(ln_ufunc_by_name("multiply"),inputs,out,NULL,err)<0)goto done;
done:
    ln_array_free(bins);ln_array_free(product[0]);ln_array_free(factor[0]);return out[0];
}

ln_array *ln_fft_shift(const ln_array *input,const int *axes,int count,
                       int inverse,ln_error *err)
{
    if(!input || count< -1 || (count>0 && !axes))return bad(err,"invalid FFT shift axes");
    if(input->nd==0)return bad(err,"FFT shift does not accept zero-dimensional input");
    ln_intp offsets[LN_MAXDIMS]={0};int n=count<0?input->nd:count;
    for(int j=0;j<n;++j) {
        int axis=count<0?j:axes[j];
        if(axis<0 || axis>=input->nd)return bad(err,"FFT shift axis out of bounds");
        ln_intp length=input->dimensions[axis];
        if(!length)continue;
        ln_intp shift=length/2;
        if(inverse && shift)shift=length-shift;
        if(offsets[axis]>=length-shift)offsets[axis]-=length-shift;
        else offsets[axis]+=shift;
    }
    return ln_roll(input,0,offsets,err);
}

static int conjugate_inplace(ln_array *array,ln_error *err)
{
    if(array->descr->kind!='c')return 0;
    ln_intp count=ln_array_size(array);
    for(ln_intp i=0;i<count;++i) {
        char *p=array->data+(size_t)i*array->descr->elsize;
        switch(array->descr->type_num) {
            case LN_CFLOAT:{ln_cfloat z;memcpy(&z,p,sizeof(z));z.imag=-z.imag;memcpy(p,&z,sizeof(z));break;}
            case LN_CDOUBLE:{ln_cdouble z;memcpy(&z,p,sizeof(z));z.imag=-z.imag;memcpy(p,&z,sizeof(z));break;}
            case LN_CLONGDOUBLE:{ln_clongdouble z;memcpy(&z,p,sizeof(z));z.imag=-z.imag;memcpy(p,&z,sizeof(z));break;}
            default:bad(err,"unsupported complex conjugate dtype");return -1;
        }
    }
    return 0;
}

typedef struct { const ln_dtype *dtype; } conjugate_data;
static void conjugate_copy_loop(char **args,const ln_intp *dimensions,
                                 const ln_intp *steps,void *opaque) {
    const ln_dtype *dtype=((conjugate_data *)opaque)->dtype;
    for(ln_intp i=0;i<dimensions[0];++i) {
        char *dest=args[1]+i*steps[1];
        memcpy(dest,args[0]+i*steps[0],dtype->elsize);
        if(dtype->kind=='c') {
            ln_array element={.data=dest,.nd=0,.descr=dtype};
            conjugate_inplace(&element,NULL);
        }
    }
}
static ln_array *conjugate_copy(const ln_array *input,ln_error *err) {
    const ln_array *inputs[]={input};ln_array *outputs[]={NULL};
    const ln_dtype *dtype=input->descr->type_num==LN_BOOL?ln_dtype_by_num(LN_BYTE):input->descr;
    const ln_dtype *dtypes[]={input->descr,dtype};conjugate_data data={.dtype=input->descr};
    if(ln_nditer_multi_execute(1,1,inputs,outputs,NULL,dtypes,conjugate_copy_loop,&data,NULL,NULL,err)<0)return NULL;
    return outputs[0];
}

static ln_fft_norm swap_norm(ln_fft_norm norm)
{ return norm==LN_FFT_NORM_BACKWARD?LN_FFT_NORM_FORWARD:norm==LN_FFT_NORM_FORWARD?LN_FFT_NORM_BACKWARD:norm; }

ln_array *ln_fft_hfft(const ln_array *input,ln_intp n,int axis,ln_fft_norm norm,
                       const ln_dtype *out_dtype,ln_error *err)
{
    if(!input)return bad(err,"hfft requires an input array");
    if(norm<LN_FFT_NORM_BACKWARD || norm>LN_FFT_NORM_FORWARD)return bad(err,"invalid hfft norm");
    ln_array *copy=conjugate_copy(input,err);
    if(!copy)return NULL;
    ln_array *result=ln_fft_irfft(copy,n,axis,swap_norm(norm),out_dtype,err);
    ln_array_free(copy);return result;
}

ln_array *ln_fft_ihfft(const ln_array *input,ln_intp n,int axis,ln_fft_norm norm,
                        const ln_dtype *out_dtype,ln_error *err)
{
    if(!input)return bad(err,"ihfft requires an input array");
    if(norm<LN_FFT_NORM_BACKWARD || norm>LN_FFT_NORM_FORWARD)return bad(err,"invalid ihfft norm");
    ln_array *result=ln_fft_rfft(input,n,axis,swap_norm(norm),out_dtype,err);
    if(result && conjugate_inplace(result,err)<0){ln_array_free(result);return NULL;}
    return result;
}
