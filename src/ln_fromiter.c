/* NumPy 2.5.4 ctors.c:PyArray_FromIter: typed allocation, 50% growth and
 * final shrink. Python iteration is replaced by Lua callbacks in the binding. */
#include "ln_fromiter.h"
#include "ln_resize.h"
#include <stdio.h>
static int bad(ln_error *err,const char *text)
{if(err)snprintf(err->message,sizeof err->message,"%s",text);return -1;}
static int builder(const ln_array *a,ln_error *err)
{
    if(!a||a->nd!=1||!a->descr||!a->descr->elsize||
       !(a->flags&LN_ARRAY_OWNDATA)||!(a->flags&LN_ARRAY_WRITEABLE))
        return bad(err,"fromiter requires writable owned one-dimensional storage");
    return 0;
}
ln_array *ln_fromiter_new(const ln_dtype *dtype,ln_intp count,ln_error *err)
{
    if(!dtype||!dtype->elsize){bad(err,"fromiter requires a dtype with specified itemsize");return NULL;}
    ln_intp size=count>0?count:0;
    return ln_array_new(1,&size,dtype,0,0,err);
}
int ln_fromiter_reserve(ln_array *a,ln_intp index,ln_error *err)
{
    if(builder(a,err)<0)return -1;
    if(index<0||index>a->dimensions[0])return bad(err,"invalid fromiter write position");
    if(index<a->dimensions[0])return 0;
    ln_intp extra=(index>>1)+(index<4?4:2);
    if(index>INTPTR_MAX-extra)return bad(err,"fromiter capacity exceeds native index range");
    ln_intp capacity=index+extra;
    return ln_array_resize_inplace(a,1,&capacity,err);
}
int ln_fromiter_finish(ln_array *a,ln_intp written,ln_error *err)
{
    if(builder(a,err)<0)return -1;
    if(written<0||written>a->dimensions[0])return bad(err,"invalid fromiter final length");
    return ln_array_resize_inplace(a,1,&written,err);
}
