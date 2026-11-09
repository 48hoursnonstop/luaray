#include "ln_round.h"
#include "ln_components.h"
#include "ln_creation.h"
#include "ln_write.h"
#include "ln_ufunc.h"
#include <limits.h>
#include <math.h>
#include <stdio.h>

/* NumPy2.5.3 calculation.c:PyArray_Round and power_of_ten. Keep the actual
 * typed multiply/rint/divide composition and its output-dependent precision.
 * NumPy BSD attribution remains in THIRD_PARTY_NUMPY_LICENSE.txt. */
static double power_of_ten(int n)
{
    static const double small[]={1e0,1e1,1e2,1e3,1e4,1e5,1e6,1e7,1e8};
    if(n<9)return small[n];
    /* The source loop is +Inf after exponent309; further multiplies cannot
     * change its value. This also bounds work for INT_MIN/MAX decimals. */
    if(n>=309)return INFINITY;
    double value=1e9;while(n-->9)value*=10.;return value;
}
static int binary(const char *name,const ln_array *a,double scalar,ln_array *out,ln_error *err)
{
    ln_ufunc_operand operands[2]={{0}};
    operands[0].kind=LN_UFUNC_OPERAND_ARRAY;operands[0].array=a;
    operands[1].kind=LN_UFUNC_WEAK_FLOAT;operands[1].floating=scalar;
    return ln_ufunc_execute_operands(ln_ufunc_by_name(name),operands,&out,NULL,err);
}
static int unary_rint(const ln_array *a,ln_array **out,ln_error *err)
{
    const ln_array *inputs[]={a};return ln_ufunc_execute(ln_ufunc_by_name("rint"),inputs,out,NULL,err);
}
static int component(const ln_array *a,int imaginary,int decimals,ln_array *work,ln_error *err)
{
    ln_array *part=ln_component_part(a,imaginary,err);if(!part)return -1;
    ln_array *rounded=NULL;
    int rc=ln_array_round(part,decimals,&rounded,err);ln_array_free(part);
    if(rc<0)return -1;
    /* NumPy sets arr.real before it even reads/sets arr.imag. Preserve that
     * observable partial write if the caller supplied a noncomplex output. */
    if(imaginary&&work->descr->kind!='c'){
        ln_array_free(rounded);
        if(err)snprintf(err->message,sizeof err->message,"cannot set imaginary part of non-complex output");
        if(err)err->kind=LN_ERROR_TYPE;
        return -1;
    }
    ln_array *target=ln_component_part(work,imaginary,err);
    if(!target){ln_array_free(rounded);return -1;}
    rc=ln_array_copyto(target,rounded,NULL,1,LN_UNSAFE_CASTING,err);
    ln_array_free(target);ln_array_free(rounded);return rc;
}
int ln_array_round(const ln_array *a,int decimals,ln_array **output,ln_error *err)
{
    if(err)err->kind=LN_ERROR_NONE;
    if(!a||!output){if(err)snprintf(err->message,sizeof err->message,"invalid round operands");return -1;}
    ln_array *out=*output;int allocated=out==NULL;
    if(out&&ln_array_size(out)!=ln_array_size(a)){
        if(err)snprintf(err->message,sizeof err->message,"invalid output shape");
        if(err)err->kind=LN_ERROR_VALUE;
        return -1;
    }
    if(a->descr->kind=='c'){
        if(!out){out=ln_creation_convert(a,NULL,'K',1,0,NULL,err);if(!out)return -1;}
        if(component(a,0,decimals,out,err)<0||component(a,1,decimals,out,err)<0){
            if(allocated)ln_array_free(out);
            return -1;
        }
        *output=out;return 0;
    }
    int integer=a->descr->kind=='i'||a->descr->kind=='u';
    if(decimals>=0){
        if(integer){
            if(out)return ln_array_copyto(out,a,NULL,1,LN_SAME_KIND_CASTING,err);
            *output=ln_creation_convert(a,NULL,'K',1,0,NULL,err);return *output?0:-1;
        }
        if(decimals==0)return unary_rint(a,output,err);
    }
    int ret_integer=allocated&&integer;
    if(!out){
        const ln_dtype *dt=ret_integer?ln_dtype_by_num(LN_DOUBLE):a->descr;
        int fortran=(a->flags&LN_ARRAY_F_CONTIGUOUS)&&!(a->flags&LN_ARRAY_C_CONTIGUOUS);
        out=ln_array_new(a->nd,a->dimensions,dt,fortran,0,err);if(!out)return -1;
    }
    int exponent=decimals<0?(decimals==INT_MIN?INT_MAX:-decimals):decimals;
    double factor=power_of_ten(exponent);
    const char *first=decimals<0?"true_divide":"multiply";
    const char *second=decimals<0?"multiply":"true_divide";
    if(binary(first,a,factor,out,err)<0||unary_rint(out,&out,err)<0||binary(second,out,factor,out,err)<0){
        if(allocated)ln_array_free(out);
        return -1;
    }
    if(ret_integer){
        int fortran=(out->flags&LN_ARRAY_F_CONTIGUOUS)&&!(out->flags&LN_ARRAY_C_CONTIGUOUS);
        ln_array *cast=ln_creation_convert(out,a->descr,fortran?'F':'C',1,0,NULL,err);
        ln_array_free(out);if(!cast)return -1;out=cast;
    }
    *output=out;return 0;
}
