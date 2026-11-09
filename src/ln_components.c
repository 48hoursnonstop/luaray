#include "ln_components.h"
#include <stdint.h>
#include <stdio.h>

/* NumPy 2.5.3 multiarray/getset.c:_get_part and real/imag getters.
 * Existing NumPy BSD attribution is in THIRD_PARTY_NUMPY_LICENSE.txt. */
ln_array *ln_component_part(const ln_array *a,int imaginary,ln_error *err)
{
    if(!a||!a->descr){if(err)snprintf(err->message,sizeof err->message,"missing component input");return NULL;}
    if(a->descr->kind!='c'){
        if(!imaginary)return ln_array_view(a,a->nd,a->dimensions,a->strides,a->data,err);
        int fortran=(a->flags&LN_ARRAY_F_CONTIGUOUS)&&!(a->flags&LN_ARRAY_C_CONTIGUOUS);
        ln_array *out=ln_array_new(a->nd,a->dimensions,a->descr,fortran,1,err);
        if(out)out->flags&=~LN_ARRAY_WRITEABLE;
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
