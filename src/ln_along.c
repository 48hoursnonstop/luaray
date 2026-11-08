/* NumPy 2.5.3 _shape_base_impl.py:_make_along_axis_idx and iterators.c:iter_array.
 * Construct the same orthogonal advanced indices for the native MapIter. */
#include "ln_along.h"
#include "ln_mapping.h"
#include "ln_write.h"
#include <stdio.h>
#include <string.h>

typedef struct {
    const ln_array *array;
    ln_array *flat,*converted,*ranges[LN_MAXDIMS];
    ln_index indices[LN_MAXDIMS];
    int nd;
} along_plan;

static int bad(ln_error *err,const char *message)
{ if(err)snprintf(err->message,sizeof(err->message),"%s",message);return -1; }

static void cleanup(along_plan *p)
{
    for(int d=0;d<LN_MAXDIMS;++d)ln_array_free(p->ranges[d]);
    ln_array_free(p->converted);ln_array_free(p->flat);
}

static int prepare(along_plan *p,const ln_array *input,const ln_array *indices,
                   int axis,ln_error *err)
{
    memset(p,0,sizeof(*p));
    if(!input || !indices)return bad(err,"along-axis operation requires input and indices");
    if(axis< -1 || axis>=input->nd)return bad(err,"along-axis axis out of bounds");
    p->array=input;
    if(axis==-1) {
        if(indices->nd!=1)return bad(err,"flat along-axis indices must have one dimension");
        ln_intp size=ln_array_size(input),stride=(ln_intp)input->descr->elsize;
        if(input->flags&LN_ARRAY_C_CONTIGUOUS)
            p->flat=ln_array_view(input,1,&size,&stride,input->data,err);
        else {
            ln_array *copy=ln_array_copy_c(input,err);
            if(!copy)return -1;
            p->flat=ln_array_view(copy,1,&size,&stride,copy->data,err);
            ln_array_free(copy);
            if(p->flat)p->flat->flags&=~LN_ARRAY_WRITEABLE;
        }
        if(!p->flat)return -1;
        p->array=p->flat;axis=0;
    }
    if(indices->descr->kind!='i' && indices->descr->kind!='u')
        return bad(err,"along-axis indices must be an integer array");
    if(indices->nd!=p->array->nd)
        return bad(err,"along-axis indices and input must have the same rank");
    const ln_dtype *intp=ln_dtype_by_name(sizeof(ln_intp)==8?"int64":"int32");
    /* MapIter consumes pointer-width signed coordinates, including unsigned
     * values that reinterpret as negative when converted to intp. */
    if(indices->descr->kind=='u' && indices->descr->elsize>=sizeof(ln_intp)) {
        int fortran=(indices->flags&LN_ARRAY_F_CONTIGUOUS) && !(indices->flags&LN_ARRAY_C_CONTIGUOUS);
        p->converted=ln_array_new(indices->nd,indices->dimensions,intp,fortran,0,err);
        if(!p->converted || ln_array_copyto(p->converted,indices,NULL,1,LN_UNSAFE_CASTING,err)<0)return -1;
        indices=p->converted;
    }
    p->nd=p->array->nd;
    if(p->nd>=LN_MAXDIMS)return bad(err,"number of index arrays exceeds iterator operand limit");
    for(int d=0;d<p->nd;++d) {
        const ln_array *ind=indices;
        if(d!=axis) {
            ln_intp shape[LN_MAXDIMS];
            for(int k=0;k<p->nd;++k)shape[k]=k==d?p->array->dimensions[d]:1;
            p->ranges[d]=ln_array_new(p->nd,shape,intp,0,0,err);
            if(!p->ranges[d])return -1;
            for(ln_intp j=0;j<shape[d];++j) {
                ln_intp value=j+1;memcpy(p->ranges[d]->data+(size_t)j*sizeof(value),&value,sizeof(value));
            }
            ind=p->ranges[d];
        }
        p->indices[d].kind=LN_INDEX_FANCY;
        p->indices[d].array=ind;p->indices[d].boolean_axis_size=-1;
    }
    return 0;
}

ln_array *ln_array_take_along_axis(const ln_array *input,const ln_array *indices,
                                  int axis,ln_error *err)
{
    along_plan p;ln_array *result=NULL;
    if(prepare(&p,input,indices,axis,err)==0)
        result=ln_array_advanced_get(p.array,p.indices,p.nd,err);
    cleanup(&p);return result;
}

int ln_array_put_along_axis(ln_array *input,const ln_array *indices,
                           const ln_array *values,int axis,ln_error *err)
{
    along_plan p;int rc=-1;
    if(prepare(&p,input,indices,axis,err)==0) {
        if(!values)bad(err,"along-axis assignment requires values");
        else rc=ln_array_advanced_assign_array((ln_array *)p.array,p.indices,p.nd,values,err);
    }
    cleanup(&p);return rc;
}
