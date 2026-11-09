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
    ln_intp square[]={2,2};a=ln_array_new(2,square,ln_dtype_by_name("int32"),0,0,&err);
    int32_t cells[]={1,2,3,4};memcpy(a->data,cells,sizeof cells);
    ln_array *sum=ln_matrix_trace(a,0,0,1,NULL,NULL,&err);assert(sum&&sum->nd==0);
    double numeric=0;int64_t iv=0;int is_integer=0;
    assert(ln_array_get_number(sum,NULL,&numeric,&iv,&is_integer,&err)==0&&is_integer&&iv==5);
    ln_array_free(sum);
    ln_array *alias=ln_array_view(a,0,NULL,NULL,a->data,&err);assert(alias);
    assert(ln_matrix_trace(a,0,0,1,NULL,alias,&err)==alias&&((int32_t *)a->data)[0]==5);
    alias->flags&=~LN_ARRAY_WRITEABLE;
    assert(ln_matrix_trace(a,0,0,1,NULL,alias,&err)==NULL&&((int32_t *)a->data)[0]==5);
    assert(ln_matrix_trace(a,0,0,0,NULL,NULL,&err)==NULL);
    assert(ln_matrix_trace(a,0,0,1,NULL,a,&err)==NULL);
    ln_array_free(alias);ln_array_free(a);
    ln_array *mask=ln_matrix_tri(2,3,0,ln_dtype_by_num(LN_BOOL),&err);assert(mask);
    const char flags[]={1,0,0,1,1,0};assert(!memcmp(mask->data,flags,sizeof flags));ln_array_free(mask);
    mask=ln_matrix_tri(-2,3,0,NULL,&err);assert(mask&&mask->dimensions[0]==0&&mask->dimensions[1]==3);ln_array_free(mask);
    assert(ln_matrix_tri(2,3,INTPTR_MIN,NULL,&err)==NULL);
    a=ln_array_new(3,shape,ln_dtype_by_name("int32"),1,0,&err);assert(a);
    for(int i=0;i<24;++i)((int32_t *)a->data)[i]=i;
    mask=ln_matrix_trilu(a,0,0,&err);assert(mask&&mask->strides[0]==4&&mask->strides[1]==32&&mask->strides[2]==8);
    ln_intp location[]={1,2,1};assert(ln_array_get_number(mask,location,&numeric,&iv,&is_integer,&err)==0&&iv==11);
    assert(mask->owner!=a->owner);ln_array_free(mask);ln_array_free(a);
    a=ln_array_new(1,n,ln_dtype_by_name("int8"),0,0,&err);assert(a);
    int8_t vector[]={1,2,3};memcpy(a->data,vector,sizeof vector);
    ln_array *powers=ln_matrix_vander(a,4,1,&err);assert(powers&&powers->nd==2&&powers->dimensions[1]==4);
    ln_intp last[]={2,3};assert(ln_array_get_number(powers,last,&numeric,&iv,&is_integer,&err)==0&&iv==27);
    assert(powers->owner!=a->owner);ln_array_free(powers);
    powers=ln_matrix_vander(a,0,0,&err);assert(powers&&ln_array_size(powers)==0);ln_array_free(powers);
    assert(ln_matrix_vander(a,-1,0,&err)==NULL);ln_array_free(a);
    puts("matrix native: diagonal layout, shared lifetime, readonly, construction, overflow and staged trace passed");
}
