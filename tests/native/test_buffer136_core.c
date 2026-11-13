#include "ln_core.h"
#include "ln_mapping.h"
#include "ln_write.h"
#include "ln_nditer.h"
#include "ln_ufunc.h"
#include "ln_complex.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>
static void released(void *data,void *context){assert(data);++*(int*)context;}
int main(void)
{
    ln_error error={0};const ln_dtype *dtype=ln_dtype_by_name("int64");int releases=0;
    int64_t data[]={1,2,3,4,5,6};
    ln_array *a=ln_array_from_buffer(data,sizeof data,dtype,-2,0,1,released,&releases,&error);assert(a);
    assert(!(a->flags&LN_ARRAY_OWNDATA)&&(a->flags&LN_ARRAY_WRITEABLE));
    assert(a->dimensions[0]==6&&a->strides[0]==8);
    ln_array *b=ln_array_from_array_buffer(a,dtype,3,8,&error);assert(b&&b->owner==a->owner);
    ln_array_free(a);assert(releases==0&&((int64_t*)b->data)[0]==2);ln_array_free(b);assert(releases==1);
    a=ln_array_from_buffer(data,sizeof data,dtype,0,sizeof data,0,released,&releases,&error);assert(a);
    assert(a->strides[0]==8&&a->dimensions[0]==0&&!(a->flags&LN_ARRAY_WRITEABLE));
    ln_array_free(a);assert(releases==2);
    assert(!ln_array_from_buffer(data,sizeof data,dtype,INTPTR_MAX,0,1,released,&releases,&error));
    assert(!ln_array_from_buffer(data,sizeof data,dtype,-1,1,1,released,&releases,&error));
    assert(!ln_array_from_buffer(data,sizeof data,ln_dtype_by_name("S0"),0,0,1,released,&releases,&error));
    assert(releases==2); /* Failed construction leaves ownership with caller. */
    a=ln_array_from_buffer((char*)data+1,sizeof data-1,dtype,1,0,0,NULL,NULL,&error);assert(a);
    assert(!(a->flags&LN_ARRAY_ALIGNED)&&a->owner->readonly);
    b=ln_array_from_array_buffer(a,ln_dtype_by_name("uint8"),-1,0,&error);assert(b);
    assert((b->flags&LN_ARRAY_ALIGNED)&&!(b->flags&LN_ARRAY_WRITEABLE));
    ln_array_free(a);ln_array_free(b);
    /* Two independently acquired external buffers may overlap physically. */
    for(int op=0;op<4;++op){
        for(int i=0;i<6;++i)data[i]=i+1;
        a=ln_array_from_buffer(data,sizeof data,dtype,5,0,1,NULL,NULL,&error);
        b=ln_array_from_buffer(data,sizeof data,dtype,5,8,1,NULL,NULL,&error);assert(a&&b&&a->owner!=b->owner);
        assert(ln_arrays_may_overlap(a,b));
        if(op==0)assert(ln_array_copyto(b,a,NULL,1,LN_NO_CASTING,&error)==0);
        if(op==1)assert(ln_array_assign_array(b,a,&error)==0);
        if(op==2)assert(ln_nditer_binary_into(a,a,b,NULL,dtype,LN_OP_ADD,&error)==0);
        if(op==3){const ln_array *inputs[]={a,a};assert(ln_ufunc_execute(ln_ufunc_by_name("add"),inputs,&b,NULL,&error)==0);}
        for(int i=0;i<5;++i)assert(data[i+1]==(i+1)*(op>=2?2:1));
        assert(data[0]==1);ln_array_free(a);ln_array_free(b);
    }
    /* A multidimensional reversed source exercises copyto's staging path. */
    for(int i=0;i<6;++i)data[i]=i+1;
    a=ln_array_from_buffer(data,sizeof data,dtype,-1,0,1,NULL,NULL,&error);
    b=ln_array_from_buffer(data,sizeof data,dtype,-1,0,1,NULL,NULL,&error);
    ln_intp dims[]={2,3},strides[]={24,-8};
    ln_array *reverse=ln_array_view(a,2,dims,strides,a->data+16,&error);
    ln_intp positive[]={24,8};ln_array *target=ln_array_view(b,2,dims,positive,b->data,&error);
    assert(reverse&&target&&ln_array_copyto(target,reverse,NULL,1,LN_NO_CASTING,&error)==0);
    for(int i=0;i<6;++i)assert(data[i]==(i/3)*3+3-i%3);
    ln_array_free(a);ln_array_free(b);ln_array_free(reverse);ln_array_free(target);
    a=ln_array_new(1,(ln_intp[]){2},ln_dtype_by_name("complex256"),0,0,&error);assert(a);
    assert(ln_array_assign_scalar(a,0,7,1,&error)==0);
    for(int i=0;i<2;++i){ln_clongdouble value;memcpy(&value,a->data+i*sizeof value,sizeof value);assert(value.real==7&&value.imag==0);}
    ln_array_free(a);
    puts("buffer136 native: ownership, flags, range validation and independent-owner aliasing passed");return 0;
}
