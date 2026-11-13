#include "ln_constructor.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>
static void released(void *data,void *context){assert(data);++*(int*)context;}
int main(void)
{
    ln_error error={0};const ln_dtype *dtype=ln_dtype_by_name("int32");
    int32_t storage[]={10,20,30,40,50,60};int releases=0;
    ln_array *buffer=ln_array_from_buffer(storage,sizeof storage,dtype,-1,0,1,released,&releases,&error);assert(buffer);
    ln_intp shape[]={3},negative[]={-4};
    ln_array *a=ln_array_construct(1,shape,dtype,buffer,8,negative,0,&error);
    assert(a&&a->owner==buffer->owner&&a->data==(char*)storage+8);
    assert(!(a->flags&LN_ARRAY_OWNDATA)&&(a->flags&LN_ARRAY_WRITEABLE));
    int32_t value=99;memcpy(a->data+a->strides[0],&value,sizeof value);assert(storage[1]==99);
    ln_array_free(buffer);assert(!releases);ln_array_free(a);assert(releases==1);
    buffer=ln_array_from_buffer(storage,sizeof storage,dtype,-1,0,0,NULL,NULL,&error);assert(buffer);
    a=ln_array_construct(2,(ln_intp[]){2,3},dtype,buffer,0,NULL,1,&error);
    assert(a&&a->strides[0]==4&&a->strides[1]==8&&!(a->flags&LN_ARRAY_WRITEABLE));ln_array_free(a);
    a=ln_array_construct(1,(ln_intp[]){1},dtype,buffer,0,(ln_intp[]){INTPTR_MIN},0,&error);
    assert(a&&(a->flags&LN_ARRAY_C_CONTIGUOUS));ln_array_free(a);
    a=ln_array_construct(1,(ln_intp[]){0},dtype,buffer,sizeof storage,(ln_intp[]){INTPTR_MAX},0,&error);
    assert(a&&a->strides[0]==INTPTR_MAX);ln_array_free(a);
    assert(!ln_array_construct(1,shape,dtype,buffer,0,negative,0,&error));
    assert(!ln_array_construct(1,(ln_intp[]){2},dtype,buffer,0,(ln_intp[]){INTPTR_MIN},0,&error));
    assert(!ln_array_construct(1,(ln_intp[]){2},dtype,buffer,0,(ln_intp[]){INTPTR_MAX},0,&error));
    assert(!ln_array_construct(1,(ln_intp[]){-1},dtype,buffer,0,negative,0,&error));
    assert(!ln_array_construct(1,(ln_intp[]){-1},dtype,buffer,0,(ln_intp[]){8},0,&error));
    assert(!ln_array_construct(1,(ln_intp[]){1},dtype,buffer,-1,NULL,0,&error));
    assert(!ln_array_construct(1,(ln_intp[]){0},dtype,buffer,sizeof storage+1,NULL,0,&error));
    assert(!ln_array_construct(2,(ln_intp[]){INTPTR_MAX,2},dtype,buffer,0,(ln_intp[]){0,0},0,&error));
    assert(!ln_array_construct(3,(ln_intp[]){0,INTPTR_MAX,2},dtype,buffer,0,NULL,0,&error));
    assert(!ln_array_construct(2,(ln_intp[]){0,INTPTR_MAX},dtype,buffer,0,NULL,0,&error));
    assert(!ln_array_construct(1,(ln_intp[]){-1},ln_dtype_by_name("S0"),buffer,0,NULL,0,&error));
    ln_array_free(buffer);
    buffer=ln_array_from_buffer(storage,0,dtype,0,0,1,NULL,NULL,&error);assert(buffer);
    assert(!ln_array_construct(1,(ln_intp[]){1},dtype,buffer,0,(ln_intp[]){0},0,&error));ln_array_free(buffer);
    a=ln_array_construct(1,(ln_intp[]){-1},dtype,NULL,0,NULL,0,&error);assert(!a);
    a=ln_array_construct(2,(ln_intp[]){2,3},NULL,NULL,-99,NULL,1,&error);
    assert(a&&a->descr==ln_dtype_by_name("float64")&&a->strides[0]==8&&a->strides[1]==16&&(a->flags&LN_ARRAY_OWNDATA));ln_array_free(a);
    a=ln_array_construct(2,(ln_intp[]){2,3},ln_dtype_by_name("U0"),NULL,0,(ln_intp[]){0,0},0,&error);
    assert(a&&a->descr->elsize==0&&a->strides[0]==0&&a->strides[1]==0);
    assert((a->flags&(LN_ARRAY_C_CONTIGUOUS|LN_ARRAY_F_CONTIGUOUS))==(LN_ARRAY_C_CONTIGUOUS|LN_ARRAY_F_CONTIGUOUS));ln_array_free(a);
    a=ln_array_construct(2,(ln_intp[]){2,0},dtype,NULL,0,(ln_intp[]){400,-20},0,&error);
    assert(a&&a->strides[0]==0&&a->strides[1]==0);ln_array_free(a);
    puts("constructor141 native: bounds, overflow, lifetime, flags and owned layouts passed");return 0;
}
