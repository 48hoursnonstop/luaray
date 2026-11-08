/* NumPy 2.5.3 multiarraymodule.c:PyArray_Where and _function_base_impl.py:select. */
#include "ln_select.h"
#include "ln_nditer_multi.h"
#include "ln_dtype_transfer.h"
#include "ln_write.h"
#include "ln_axis.h"
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static ln_array *bad(ln_error *err,const char *message)
{ if(err)snprintf(err->message,sizeof(err->message),"%s",message);return NULL; }

typedef struct {
    const ln_dtype *x,*y,*result;
    int failed;
    ln_error error;
} where_data;

static void where_loop(char **args,const ln_intp *dimensions,
                        const ln_intp *steps,void *opaque)
{
    where_data *data=opaque;
    if(data->failed)return;
    for(ln_intp i=0;i<dimensions[0];++i) {
        int pick=*(const unsigned char *)(args[0]+i*steps[0])?1:2;
        const ln_dtype *source_dtype=pick==1?data->x:data->y;
        const char *source=args[pick]+i*steps[pick];
        char *dest=args[3]+i*steps[3];
        if(ln_cast_strided_numeric(source,0,source_dtype,dest,0,data->result,1,&data->error)<0) {
            data->failed=1;return;
        }
    }
}

ln_array *ln_array_where(const ln_array *condition,const ln_array *x,
                         const ln_array *y,const ln_dtype *dtype,ln_error *err)
{
    if(!condition || !x || !y || !dtype)return bad(err,"where requires condition and both value operands");
    size_t width=dtype->elsize;
    int trivial=width==1 || width==2 || width==4 || width==8 || width==16;
    const ln_dtype *xdtype=trivial?dtype:x->descr,*ydtype=trivial?dtype:y->descr;
    const ln_array *inputs[]={condition,x,y};ln_array *outputs[]={NULL};
    const ln_dtype *dtypes[]={ln_dtype_by_num(LN_BOOL),xdtype,ydtype,dtype};
    where_data data={.x=xdtype,.y=ydtype,.result=dtype};
    int rc=ln_nditer_multi_execute(3,1,inputs,outputs,NULL,dtypes,where_loop,&data,NULL,NULL,err);
    if(data.failed) {
        if(err)*err=data.error;
        ln_array_free(outputs[0]);return NULL;
    }
    return rc<0?NULL:outputs[0];
}

/* Like Python stride_tricks._broadcast_shape, fold batches through the bounded
 * legacy MultiIter shape helper instead of inheriting its operand-count limit. */
static int broadcast_many(int count,const ln_array *const *operands,
                           int *nd,ln_intp *shape,ln_error *err)
{
    if(count<=64)return ln_broadcast_shape(count,operands,nd,shape,err);
    ln_intp current_shape[LN_MAXDIMS];ln_array current={.nd=0,.dimensions=current_shape};
    for(int start=0;start<count;) {
        const ln_array *batch[64];batch[0]=&current;
        int n=count-start<63?count-start:63;
        for(int j=0;j<n;++j)batch[j+1]=operands[start+j];
        int next_nd=0;ln_intp next_shape[LN_MAXDIMS];
        if(ln_broadcast_shape(n+1,batch,&next_nd,next_shape,err)<0)return -1;
        memcpy(current_shape,next_shape,(size_t)next_nd*sizeof(ln_intp));current.nd=next_nd;
        start+=n;
    }
    *nd=current.nd;memcpy(shape,current_shape,(size_t)*nd*sizeof(ln_intp));return 0;
}

ln_array *ln_array_select(const ln_array *const *conditions,
                          const ln_array *const *choices,int count,
                          const ln_array *default_value,const ln_dtype *dtype,
                          ln_error *err)
{
    if(!conditions || !choices || !default_value || !dtype || count<1 || count>(INT_MAX-1)/2)
        return bad(err,"select requires equal nonempty condition and choice lists");
    size_t narr=(size_t)count*2+1;
    if(narr>SIZE_MAX/sizeof(ln_array *))return bad(err,"select operand list is too large");
    const ln_array **operands=malloc(narr*sizeof(*operands));
    if(!operands)return bad(err,"could not allocate select operand list");
    for(int j=0;j<count;++j) {
        if(!conditions[j] || !choices[j] || conditions[j]->descr->type_num!=LN_BOOL) {
            free(operands);return bad(err,"select conditions must be boolean arrays");
        }
        operands[j]=conditions[j];operands[count+j]=choices[j];
    }
    operands[count*2]=default_value;
    int cnd=0,vnd=0,nd=0;ln_intp cshape[LN_MAXDIMS],vshape[LN_MAXDIMS],shape[LN_MAXDIMS];
    int rc=broadcast_many(count,operands,&cnd,cshape,err);
    if(rc==0)rc=broadcast_many(count+1,operands+count,&vnd,vshape,err);
    if(rc==0)rc=broadcast_many(count*2+1,operands,&nd,shape,err);
    free(operands);
    if(rc<0)return NULL;
    ln_array *result=ln_array_new(nd,shape,dtype,0,0,err);
    if(!result)return NULL;
    ln_array *value=ln_axis_broadcast_to(default_value,vnd,vshape,1,err);
    if(!value){ln_array_free(result);return NULL;}
    rc=ln_array_copyto(result,value,NULL,1,LN_UNSAFE_CASTING,err);
    ln_array_free(value);
    if(rc<0){ln_array_free(result);return NULL;}
    for(int j=count-1;j>=0;--j) {
        ln_array *mask=ln_axis_broadcast_to(conditions[j],cnd,cshape,1,err);
        value=ln_axis_broadcast_to(choices[j],vnd,vshape,1,err);
        if(!mask || !value) {
            ln_array_free(mask);ln_array_free(value);ln_array_free(result);return NULL;
        }
        rc=ln_array_copyto(result,value,mask,1,LN_SAME_KIND_CASTING,err);
        ln_array_free(mask);ln_array_free(value);
        if(rc<0){ln_array_free(result);return NULL;}
    }
    return result;
}
