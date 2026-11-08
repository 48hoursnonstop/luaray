#include "ln_select.h"
#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

int main(void)
{
    ln_error err={{0}};ln_intp shape[]={2,3};
    const ln_dtype *dtype=ln_dtype_by_name("int32");
    ln_array *mask=ln_array_new(2,shape,ln_dtype_by_name("bool"),0,0,&err);
    ln_array *x=ln_array_new(2,shape,dtype,0,0,&err),*y=ln_array_new(0,NULL,dtype,0,1,&err);
    assert(mask&&x&&y);
    memcpy(mask->data,(unsigned char[]){1,0,1,0,1,0},6);
    memcpy(x->data,(int32_t[]){1,2,3,4,5,6},24);
    ln_array *out=ln_array_where(mask,x,y,dtype,&err);assert(out);
    assert(memcmp(out->data,(int32_t[]){1,0,3,0,5,0},24)==0);ln_array_free(out);
    assert(!ln_array_where(NULL,x,y,dtype,&err));
    assert(!ln_array_where(mask,NULL,y,dtype,&err));
    assert(!ln_array_where(mask,x,NULL,dtype,&err));
    assert(!ln_array_where(mask,x,y,NULL,&err));
    const ln_array *conditions[]={mask},*choices[]={x};
    out=ln_array_select(conditions,choices,1,y,dtype,&err);assert(out);
    assert(memcmp(out->data,(int32_t[]){1,0,3,0,5,0},24)==0);ln_array_free(out);
    assert(!ln_array_select(NULL,choices,1,y,dtype,&err));
    assert(!ln_array_select(conditions,NULL,1,y,dtype,&err));
    assert(!ln_array_select(conditions,choices,0,y,dtype,&err));
    assert(!ln_array_select(conditions,choices,1,NULL,dtype,&err));
    assert(!ln_array_select(choices,choices,1,y,dtype,&err));
    ln_array *scalar_mask=ln_array_new(0,NULL,ln_dtype_by_name("bool"),0,1,&err);assert(scalar_mask);
    scalar_mask->data[0]=1;
    const ln_array *many_conditions[65],*many_choices[65];
    for(int i=0;i<65;++i){many_conditions[i]=scalar_mask;many_choices[i]=x;}
    out=ln_array_select(many_conditions,many_choices,65,y,dtype,&err);assert(out);
    assert(memcmp(out->data,x->data,24)==0);ln_array_free(out);
    assert(!ln_promote_dtype(ln_dtype_by_name("uint64"),ln_dtype_by_name("timedelta64[h]")));
    ln_array *binary=ln_array_new(0,NULL,ln_dtype_by_name("S1"),0,0,&err);
    ln_array *u3=ln_array_new(0,NULL,ln_dtype_by_name("U3"),0,0,&err);
    ln_array *u4=ln_array_new(0,NULL,ln_dtype_by_name("U4"),0,0,&err);assert(binary&&u3&&u4);
    binary->data[0]=(char)255;
    assert(ln_array_pack_string(u3,NULL,"x",1,&err)==0);
    assert(ln_array_pack_string(u4,NULL,"x",1,&err)==0);
    scalar_mask->data[0]=0;
    out=ln_array_where(scalar_mask,binary,u3,u3->descr,&err);assert(out&&out->nd==0);
    uint32_t cp;memcpy(&cp,out->data,4);assert(cp=='x');ln_array_free(out);
    assert(!ln_array_where(scalar_mask,binary,u4,u4->descr,&err));
    scalar_mask->data[0]=1;
    assert(!ln_array_where(scalar_mask,binary,u3,u3->descr,&err));
    ln_array_free(binary);ln_array_free(u3);ln_array_free(u4);ln_array_free(scalar_mask);
    ln_array_free(mask);ln_array_free(x);ln_array_free(y);
    puts("select104 native core: passed");return 0;
}
