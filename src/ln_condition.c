/* NumPy 2.5.3 item_selection.c:PyArray_Nonzero/PyArray_Compress and extract. */
#include "ln_condition.h"
#include "ln_take.h"
#include "ln_write.h"
#include <stdio.h>
#include <string.h>

static int bad(ln_error *err,const char *message)
{ if(err)snprintf(err->message,sizeof(err->message),"%s",message);return -1; }

static void advance(int nd,const ln_intp *shape,ln_intp *coord)
{ for(int d=nd-1;d>=0;--d){if(++coord[d]<shape[d])break;coord[d]=0;} }

static int truth(const ln_array *mask,const ln_intp *coord)
{
    const char *p=mask->data;
    for(int d=0;d<mask->nd;++d)p+=coord[d]*mask->strides[d];
    return *(const unsigned char *)p!=0;
}

int ln_array_condition_nonzero(const ln_array *input,int flatten,
                                ln_array **outputs,int *nout,ln_error *err)
{
    if(nout)*nout=0;
    if(!input || !outputs || !nout)return bad(err,"nonzero requires input and coordinate outputs");
    if(!flatten && input->nd==0)return bad(err,"nonzero does not accept zero-dimensional input");
    ln_array *converted=NULL;const ln_array *mask=input;
    if(input->descr->type_num!=LN_BOOL) {
        converted=ln_array_new(input->nd,input->dimensions,ln_dtype_by_num(LN_BOOL),0,0,err);
        if(!converted)return -1;
        if(ln_array_copyto(converted,input,NULL,1,LN_UNSAFE_CASTING,err)<0){ln_array_free(converted);return -1;}
        mask=converted;
    }
    ln_intp total=ln_array_size(mask),count=0,coord[LN_MAXDIMS]={0};
    if(total<0){ln_array_free(converted);return bad(err,"nonzero input is too large");}
    for(ln_intp i=0;i<total;++i){count+=truth(mask,coord);advance(mask->nd,mask->dimensions,coord);}
    int columns=flatten?1:mask->nd;
    ln_intp shape[]={count,columns};
    const ln_dtype *intp=ln_dtype_by_name(sizeof(ln_intp)==8?"int64":"int32");
    ln_array *storage=ln_array_new(2,shape,intp,0,0,err);
    if(!storage){ln_array_free(converted);return -1;}
    memset(coord,0,sizeof(coord));ln_intp selected=0;
    for(ln_intp i=0;i<total;++i) {
        if(truth(mask,coord)) {
            for(int d=0;d<columns;++d) {
                ln_intp value=flatten?i+1:coord[d]+1;
                memcpy(storage->data+((size_t)selected*columns+d)*sizeof(value),&value,sizeof(value));
            }
            ++selected;
        }
        advance(mask->nd,mask->dimensions,coord);
    }
    ln_array_free(converted);
    ln_intp stride=(ln_intp)columns*(ln_intp)sizeof(ln_intp);
    for(int d=0;d<columns;++d) {
        char *data=storage->data+(count?(size_t)d*sizeof(ln_intp):0);
        outputs[d]=ln_array_view(storage,1,&count,&stride,data,err);
        if(!outputs[d]) {
            for(int k=0;k<d;++k)ln_array_free(outputs[k]);
            ln_array_free(storage);return -1;
        }
    }
    ln_array_free(storage);*nout=columns;return 0;
}

ln_array *ln_array_compress_condition(const ln_array *input,const ln_array *condition,
                                     int rank_one,int axis,ln_array *out,ln_error *err)
{
    if(!input || !condition){bad(err,"compress requires input and condition");return NULL;}
    if(rank_one && condition->nd!=1){bad(err,"compress condition must have one dimension");return NULL;}
    ln_array *indices[1];int nout=0;
    if(ln_array_condition_nonzero(condition,1,indices,&nout,err)<0)return NULL;
    ln_array *result=ln_array_take(input,indices[0],axis,LN_TAKE_RAISE,out,err);
    ln_array_free(indices[0]);return result;
}
