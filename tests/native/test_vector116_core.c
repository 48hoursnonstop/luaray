#include "ln_vector.h"
#include "ln_bytes.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>
int main(void)
{
    ln_error err={0};ln_intp n[]={3};
    ln_array *a=ln_array_new(1,n,ln_dtype_by_name("float64"),0,1,&err);
    ln_array *b=ln_array_new(1,n,ln_dtype_by_name("float32"),0,1,&err);
    double av[]={1,0,0};float bv[]={0,1,0};memcpy(a->data,av,sizeof av);memcpy(b->data,bv,sizeof bv);
    ln_array *c=ln_vector_cross(a,0,b,0,0,&err);assert(c&&c->descr->type_num==LN_DOUBLE);
    double expected[]={0,0,1};assert(!memcmp(c->data,expected,sizeof expected));
    ln_array_free(c);assert(ln_vector_cross(a,1,b,0,0,&err)==NULL);
    const ln_array *inputs[]={a,b};ln_array *out[2]={0};
    assert(ln_vector_meshgrid(2,inputs,0,0,1,out,&err)==0);
    assert(out[0]->dimensions[0]==3&&out[0]->dimensions[1]==3);
    assert(out[0]->strides[0]==0&&out[0]->strides[1]==8);
    assert(out[1]->strides[0]==4&&out[1]->strides[1]==0);
    assert(out[0]->flags&LN_ARRAY_WRITEABLE);
    ln_intp where[]={1,1};assert(ln_array_pack_number(out[0],where,7,7,1,&err)==0);
    assert(((double *)a->data)[1]==7);
    ln_array_free(out[0]);ln_array_free(out[1]);
    a->flags&=~LN_ARRAY_WRITEABLE;
    assert(ln_vector_meshgrid(2,inputs,0,1,0,out,&err)==0);
    assert(!(out[0]->flags&LN_ARRAY_WRITEABLE));
    ln_array_free(out[0]);ln_array_free(out[1]);
    assert(ln_vector_meshgrid(2,inputs,1,1,0,out,&err)==0);
    assert(out[0]->flags&LN_ARRAY_WRITEABLE);
    ln_array_free(a);ln_array_free(b); /* copied outputs own their storage */
    assert(((double *)out[0]->data)[1]==7);
    ln_array_free(out[0]);ln_array_free(out[1]);
    assert(ln_vector_meshgrid(0,NULL,1,0,1,NULL,&err)==0);
    assert(ln_vector_meshgrid(65,NULL,1,0,1,NULL,&err)<0);
    assert(ln_vector_cross(NULL,0,NULL,0,0,&err)==NULL);
    puts("vector116 native: promotion, cross, grid strides, shared writes, readonly/copies and ownership passed");
}
