#include "ln_resize.h"
#include "ln_layout.h"
#include "ln_join.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>
static int64_t item(const ln_array *a,int i)
{int64_t n;memcpy(&n,a->data+8*i,8);return n;}
static int releases;
static void release(void *p,void *context){assert(p&&context==&releases);++releases;}
int main(void)
{
    ln_error e={0};ln_intp count;
    assert(!ln_resize_shape(0,NULL,8,&count,&e)&&count==1);
    assert(!ln_resize_shape(2,(ln_intp[]){0,3},8,&count,&e)&&count==0);
    assert(ln_resize_shape(2,(ln_intp[]){0,-1},8,&count,&e)<0);
    assert(ln_resize_shape(2,(ln_intp[]){0,INTPTR_MAX},8,&count,&e)<0);
    assert(ln_resize_shape(2,(ln_intp[]){INTPTR_MAX,2},0,&count,&e)<0);
    assert(ln_resize_shape(65,NULL,8,&count,&e)<0);
    assert(!ln_array_resize_copy(NULL,0,NULL,&e));
    assert(ln_array_resize_inplace(NULL,0,NULL,&e)<0);
    ln_array *a=ln_array_new(1,(ln_intp[]){3},ln_dtype_by_name("int64"),0,1,&e);assert(a);
    int64_t initial[]={10,20,30};memcpy(a->data,initial,sizeof initial);
    ln_array *b=ln_array_resize_copy(a,2,(ln_intp[]){2,4},&e);assert(b&&b->owner!=a->owner&&!(b->flags&LN_ARRAY_OWNDATA));
    for(int i=0;i<8;++i)assert(item(b,i)==initial[i%3]);
    ln_array_free(b);
    b=ln_array_view(a,1,a->dimensions,a->strides,a->data,&e);assert(b&&a->owner->refs==2);
    assert(ln_array_resize_inplace(a,1,(ln_intp[]){4},&e)<0&&item(b,2)==30&&a->dimensions[0]==3);
    assert(!ln_array_resize_inplace(a,2,(ln_intp[]){1,3},&e)&&b->nd==1);
    assert(ln_array_resize_inplace(b,1,(ln_intp[]){4},&e)<0);
    ln_array_free(b);
    assert(!ln_array_resize_inplace(a,2,(ln_intp[]){2,3},&e));
    for(int i=0;i<6;++i)assert(item(a,i)==(i<3?initial[i]:0));
    assert(a->owner->ptr==a->data&&a->owner->nbytes==48);
    ln_intp *old=a->dimensions;char *data=a->data;
    assert(ln_array_resize_inplace(a,2,(ln_intp[]){0,-1},&e)<0&&a->dimensions==old&&a->data==data);
    assert(!ln_array_resize_inplace(a,1,(ln_intp[]){1},&e)&&item(a,0)==10);
    a->flags&=~LN_ARRAY_WRITEABLE;
    assert(!ln_array_resize_inplace(a,1,(ln_intp[]){3},&e)&&item(a,0)==10); /* No uninitialized-tail read. */
    assert(!(a->flags&LN_ARRAY_WRITEABLE));
    assert(!ln_array_resize_inplace(a,1,(ln_intp[]){0},&e)&&a->owner->nbytes==1);ln_array_free(a);
    a=ln_array_new(2,(ln_intp[]){1,1},ln_dtype_by_name("int64"),0,1,&e);assert(a);
    /* A scalar resize preserves source flags, including an existing F-only state. */
    a->flags&=~LN_ARRAY_C_CONTIGUOUS;a->flags|=LN_ARRAY_F_CONTIGUOUS;
    assert(!ln_array_resize_inplace(a,0,NULL,&e)&&a->nd==0&&!a->dimensions&&!a->strides);
    assert(!(a->flags&LN_ARRAY_C_CONTIGUOUS)&&(a->flags&LN_ARRAY_F_CONTIGUOUS));ln_array_free(a);
    a=ln_array_new(1,(ln_intp[]){2},ln_dtype_by_name("U2"),0,1,&e);assert(a);
    a->flags&=~LN_ARRAY_WRITEABLE;
    assert(!ln_array_resize_inplace(a,1,(ln_intp[]){4},&e));
    for(int i=0;i<32;++i)assert(a->data[i]==0); /* Safe Unicode initialization, including read-only growth. */
    ln_array_free(a);
    a=ln_array_new(1,(ln_intp[]){3},ln_dtype_by_name("S0"),0,1,&e);assert(a);
    b=ln_array_view(a,1,a->dimensions,a->strides,a->data,&e);assert(b);
    assert(!ln_array_resize_inplace(b,2,(ln_intp[]){2,4},&e)&&ln_array_size(b)==8);
    assert(b->flags&LN_ARRAY_C_CONTIGUOUS);assert(!(b->flags&LN_ARRAY_F_CONTIGUOUS));ln_array_free(b);
    b=ln_array_resize_copy(a,2,(ln_intp[]){2,3},&e);assert(b&&b->descr->elsize==0&&(b->flags&LN_ARRAY_C_CONTIGUOUS)&&!(b->flags&LN_ARRAY_F_CONTIGUOUS));
    ln_array_free(a);ln_array_free(b);
    int64_t external[]={1,2,3};a=ln_array_from_buffer(external,sizeof external,ln_dtype_by_name("int64"),3,0,1,release,&releases,&e);assert(a);
    assert(ln_array_resize_inplace(a,1,(ln_intp[]){4},&e)<0&&releases==0);
    assert(!ln_array_resize_inplace(a,2,(ln_intp[]){1,3},&e));ln_array_free(a);assert(releases==1);
    puts("resize145 native: repeated copies, allocation, live views, shape safety and ownership passed");return 0;
}
