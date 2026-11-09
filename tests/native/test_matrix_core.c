#include "ln_matrix.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>
int main(void)
{
    ln_error err={0};ln_intp shape[]={2,3,4};
    ln_array *a=ln_array_new(3,shape,ln_dtype_by_name("int32"),0,1,&err);assert(a);
    for(int i=0;i<24;++i)((int32_t *)a->data)[i]=i;
    ln_array *v=ln_matrix_diagonal(a,1,0,2,&err);assert(v);
    assert(v->nd==2&&v->dimensions[0]==3&&v->dimensions[1]==2);
    assert(v->strides[0]==16&&v->strides[1]==52);
    assert(!(v->flags&LN_ARRAY_WRITEABLE)&&v->owner==a->owner);
    assert(*(int32_t *)v->data==1&&*(int32_t *)(v->data+v->strides[1])==14);
    ((int32_t *)a->data)[1]=100;assert(*(int32_t *)v->data==100);
    ln_array_free(a);assert(*(int32_t *)v->data==100);ln_array_free(v);
    ln_intp n[]={3};a=ln_array_new(1,n,ln_dtype_by_name("int32"),0,0,&err);
    int32_t values[]={2,4,6};memcpy(a->data,values,sizeof values);
    ln_array *b=ln_matrix_diag(a,-1,0,&err);assert(b&&b->dimensions[0]==4);
    assert(((int32_t *)b->data)[4]==2&&((int32_t *)b->data)[9]==4&&((int32_t *)b->data)[14]==6);
    assert(b->owner!=a->owner&&b->flags&LN_ARRAY_WRITEABLE);
    v=ln_matrix_diag(b,-1,0,&err);assert(v&&v->dimensions[0]==3&&v->owner==b->owner);
    assert(ln_matrix_diagonal(a,0,0,0,&err)==NULL);
    assert(ln_matrix_diagonal(b,0,1,1,&err)==NULL);
    assert(ln_matrix_diagonal(b,0,-1,0,&err)==NULL);
    assert(ln_matrix_diag(a,INTPTR_MIN,0,&err)==NULL);
    assert(ln_matrix_diag(a,INTPTR_MAX,0,&err)==NULL);
    ln_array *empty=ln_matrix_diagonal(b,INTPTR_MIN,0,1,&err);assert(empty&&ln_array_size(empty)==0);
    ln_array_free(empty);ln_array_free(v);ln_array_free(b);ln_array_free(a);
    assert(ln_matrix_diag(NULL,0,1,&err)==NULL);
    puts("matrix native: diagonal layout, shared lifetime, readonly, construction and overflow passed");
}
