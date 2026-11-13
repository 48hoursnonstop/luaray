#include "ln_components.h"
#include "ln_ufunc.h"
#include <float.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

/* NumPy 2.5.3 multiarray/getset.c:_get_part and real/imag getters.
 * Existing NumPy BSD attribution is in THIRD_PARTY_NUMPY_LICENSE.txt. */
ln_array *ln_component_part(const ln_array *a,int imaginary,ln_error *err)
{
    if(!a||!a->descr){if(err)snprintf(err->message,sizeof err->message,"missing component input");return NULL;}
    if(a->descr->kind!='c'){
        if(!imaginary)return ln_array_view(a,a->nd,a->dimensions,a->strides,a->data,err);
        int fortran=(a->flags&LN_ARRAY_F_CONTIGUOUS)&&!(a->flags&LN_ARRAY_C_CONTIGUOUS);
        ln_array *out=ln_array_new(a->nd,a->dimensions,a->descr,fortran,1,err);
        if(out)ln_array_setflags(out,0,-1,err);
        return out;
    }
    const ln_dtype *dt=NULL;
    switch(a->descr->type_num){
    case LN_CFLOAT:dt=ln_dtype_by_num(LN_FLOAT);break;
    case LN_CDOUBLE:dt=ln_dtype_by_num(LN_DOUBLE);break;
    case LN_CLONGDOUBLE:dt=ln_dtype_by_num(LN_LONGDOUBLE);break;
    default:if(err)snprintf(err->message,sizeof err->message,"unsupported complex dtype");return NULL;
    }
    /* Address construction also permits an empty imaginary component view,
     * whose pointer is never dereferenced or counted as a shared byte. */
    char *data=(char *)((uintptr_t)a->data+(imaginary?dt->elsize:0));
    ln_array *out=ln_array_view(a,a->nd,a->dimensions,a->strides,data,err);
    if(out){out->descr=dt;ln_update_contiguous_flags(out);}
    return out;
}

/* lib/_type_check_impl.py:iscomplex/isreal. The latter compares a zero-valued
 * imaginary array with integer zero: fixed strings and datetimes compare
 * false, while timedeltas compare true. iscomplex's noncomplex branch instead
 * explicitly allocates C-order zeros. */
ln_array *ln_component_reality(const ln_array *a,int real,ln_error *err)
{
    if(!a){if(err)snprintf(err->message,sizeof err->message,"missing reality input");return NULL;}
    if(a->descr->kind=='c'){
        ln_array *imag=ln_component_part(a,1,err);if(!imag)return NULL;
        ln_ufunc_operand operands[2]={{0}};
        operands[0].kind=LN_UFUNC_OPERAND_ARRAY;operands[0].array=imag;
        operands[1].kind=LN_UFUNC_WEAK_INT;operands[1].integer=0;
        ln_array *out=NULL;
        int rc=ln_ufunc_execute_operands(ln_ufunc_by_name(real?"equal":"not_equal"),operands,&out,NULL,err);
        ln_array_free(imag);return rc<0?NULL:out;
    }
    int fortran=real&&(a->flags&LN_ARRAY_F_CONTIGUOUS)&&!(a->flags&LN_ARRAY_C_CONTIGUOUS);
    ln_array *out=ln_array_new(a->nd,a->dimensions,ln_dtype_by_num(LN_BOOL),fortran,1,err);
    int truth=real&&a->descr->kind!='S'&&a->descr->kind!='U'&&a->descr->kind!='M';
    if(out&&truth)memset(out->data,1,(size_t)ln_array_size(out));
    return out;
}

ln_array *ln_component_close(const ln_array *a,long double tolerance,
                             int *identity,ln_error *err)
{
    if(identity)*identity=0;
    if(!a){if(err)snprintf(err->message,sizeof err->message,"missing real_if_close input");return NULL;}
    int close=0;
    if(a->descr->kind=='c'){
        ln_array *imag=ln_component_part(a,1,err);if(!imag)return NULL;
        long double threshold;
        /* Weak Lua/Python scalar conversion happens at component precision
         * before eps multiplication and comparison, including tolerance<=1. */
        if(imag->descr->type_num==LN_FLOAT){float t=(float)tolerance;
            if(tolerance>1)t=FLT_EPSILON*t;
            threshold=t;}
        else if(imag->descr->type_num==LN_DOUBLE){double t=(double)tolerance;
            if(tolerance>1)t=DBL_EPSILON*t;
            threshold=t;}
        else{long double t=tolerance;if(tolerance>1)t=LDBL_EPSILON*t;threshold=t;}
        close=1;ln_intp coord[LN_MAXDIMS]={0},count=ln_array_size(a);
        for(ln_intp i=0;i<count;++i){
            const char *src=imag->data;
            for(int d=0;d<imag->nd;++d)src+=coord[d]*imag->strides[d];
            long double absolute;
            if(imag->descr->type_num==LN_FLOAT){float x;memcpy(&x,src,sizeof x);absolute=fabsf(x);}
            else if(imag->descr->type_num==LN_DOUBLE){double x;memcpy(&x,src,sizeof x);absolute=fabs(x);}
            else{long double x;memcpy(&x,src,sizeof x);absolute=fabsl(x);}
            if(!(absolute<threshold)){close=0;break;}
            for(int d=imag->nd-1;d>=0;--d){if(++coord[d]<imag->dimensions[d])break;coord[d]=0;}
        }
        ln_array_free(imag);
    }
    if(close)return ln_component_part(a,0,err);
    if(identity)*identity=1;
    return ln_array_view(a,a->nd,a->dimensions,a->strides,a->data,err);
}
