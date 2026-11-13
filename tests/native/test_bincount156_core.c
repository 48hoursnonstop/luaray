#include "ln_bincount.h"
#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
int main(void)
{
 ln_error error={0};ln_intp shape=4;
 const ln_dtype *dtype=ln_dtype_by_name(sizeof(ln_intp)==8?"int64":"int32");
 ln_array *labels=ln_array_new(1,&shape,dtype,0,1,&error);assert(labels);
 ln_intp values[]={0,1,1,3};memcpy(labels->data,values,sizeof values);
 ln_intp length=-1;assert(!ln_bincount_shape(labels,6,&length,&error)&&length==6);
 ln_array *out=ln_bincount(labels,NULL,0,&error);assert(out&&out->dimensions[0]==4);
 ln_intp expected[]={1,2,0,1};assert(!memcmp(out->data,expected,sizeof expected));ln_array_free(out);
 const ln_dtype *double_dtype=ln_dtype_by_name("float64");
 ln_array *weights=ln_array_new(1,&shape,double_dtype,0,0,&error);assert(weights);
 double w[]={2,3,-1,0.5};memcpy(weights->data,w,sizeof w);
 out=ln_bincount(labels,weights,5,&error);assert(out&&out->dimensions[0]==5);
 double wanted[]={2,2,0,0.5,0};assert(!memcmp(out->data,wanted,sizeof wanted));
 ln_array_free(weights);ln_array_free(labels);assert(!memcmp(out->data,wanted,sizeof wanted));ln_array_free(out);
 char storage[1+sizeof(values)];memcpy(storage+1,values,sizeof values);
 labels=ln_array_from_buffer(storage,sizeof storage,dtype,4,1,0,NULL,NULL,&error);assert(labels);
 assert(!(labels->flags&LN_ARRAY_ALIGNED));out=ln_bincount(labels,NULL,0,&error);assert(out);
 assert(!memcmp(out->data,expected,sizeof expected));ln_array_free(out);ln_array_free(labels);
 shape=0;labels=ln_array_new(1,&shape,dtype,0,0,&error);assert(labels);
 weights=ln_array_new(0,NULL,ln_dtype_by_name("complex128"),0,1,&error);assert(weights);
 out=ln_bincount(labels,weights,2,&error);assert(out&&out->descr->type_num==dtype->type_num&&out->dimensions[0]==2);
 ln_intp zero[2]={0};assert(!memcmp(out->data,zero,sizeof zero));ln_array_free(out);ln_array_free(labels);ln_array_free(weights);
 shape=1;labels=ln_array_new(1,&shape,dtype,0,0,&error);assert(labels);
 ln_intp maximum=INTPTR_MAX;memcpy(labels->data,&maximum,sizeof maximum);
 assert(ln_bincount_shape(labels,0,&length,&error)<0);assert(!ln_bincount(labels,NULL,0,&error));
 maximum=-1;memcpy(labels->data,&maximum,sizeof maximum);assert(!ln_bincount(labels,NULL,0,&error));
 assert(!ln_bincount(labels,NULL,-1,&error));ln_array_free(labels);
 puts("bincount156 native: bounds, zeros, weights, input lifetime, unaligned reads and empty-weight bypass passed");return 0;
}
