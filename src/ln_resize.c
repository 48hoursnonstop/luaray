/* NumPy _core/fromnumeric.py:resize: C-order ravel, repeated concatenate,
 * prefix and reshape. Reuse the engine's real layout and dtype transfers. */
#include "ln_resize.h"
#include "ln_layout.h"
#include "ln_creation.h"
#include "ln_join.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
static int bad(ln_error *err,const char *text)
{if(err)snprintf(err->message,sizeof err->message,"%s",text);return -1;}
int ln_resize_shape(int nd,const ln_intp *shape,size_t itemsize,ln_intp *count,ln_error *err)
{
    if(nd<0||nd>LN_MAXDIMS||(nd&&!shape)||itemsize>(size_t)INTPTR_MAX)return bad(err,"invalid resize shape or dtype width");
    ln_intp extent=1;int empty=0;
    for(int d=0;d<nd;++d){
        if(shape[d]<0)return bad(err,"resize dimensions must be nonnegative");
        if(!shape[d])empty=1;
        else if(ln_mul_sizes_with_overflow(&extent,extent,shape[d]))return bad(err,"resize shape exceeds native index range");
    }
    ln_intp bytes;if(ln_mul_sizes_with_overflow(&bytes,extent,(ln_intp)itemsize))return bad(err,"resize byte/stride count is too large");
    *count=empty?0:extent;return 0;
}
ln_array *ln_array_resize_copy(const ln_array *array,int nd,const ln_intp *shape,ln_error *err)
{
    if(!array){bad(err,"resize requires an array");return NULL;}
    ln_intp count;if(ln_resize_shape(nd,shape,array->descr->elsize,&count,err)<0)return NULL;
    ln_array *flat=ln_layout_ravel(array,'C',err);if(!flat)return NULL;
    ln_intp size=ln_array_size(flat);ln_array *result=NULL,*joined=NULL,*prefix=NULL;
    if(size<0){bad(err,"resize input size exceeds native range");goto finish;}
    if(!size||!count){
        result=ln_creation_new_like(flat,NULL,'C',nd,shape,err);
        if(result){ln_intp nbytes=ln_array_size(result)*(ln_intp)result->descr->elsize;if(nbytes)memset(result->data,0,(size_t)nbytes);}
        goto finish;
    }
    ln_intp repeats=count/size+(count%size!=0);
    if((uintmax_t)repeats>SIZE_MAX/sizeof(ln_array*)){bad(err,"resize repetition list is too large");goto finish;}
    const ln_array **inputs=malloc((size_t)repeats*sizeof(*inputs));
    if(!inputs){bad(err,"out of memory");goto finish;}
    for(ln_intp i=0;i<repeats;++i)inputs[i]=flat;
    joined=ln_join_arrays(inputs,(size_t)repeats,0,0,NULL,LN_SAME_KIND_CASTING,NULL,err);free(inputs);if(!joined)goto finish;
    ln_intp stride=(ln_intp)joined->descr->elsize;
    prefix=ln_array_view(joined,1,&count,&stride,joined->data,err);if(!prefix)goto finish;
    result=ln_layout_reshape(prefix,nd,shape,'C',-1,err);
finish:
    ln_array_free(flat);ln_array_free(joined);ln_array_free(prefix);return result;
}
