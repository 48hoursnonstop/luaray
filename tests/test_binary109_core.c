#include "ln_binary_math.h"
#include "ln_string.h"
#include <assert.h>
#include <limits.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

int main(void)
{
    ln_error e={0};ln_intp shape[]={4};
    assert(ln_binary_math_count()==2);
    assert(!ln_binary_math_by_name(NULL)&&!ln_binary_math_by_name("absent"));
    ln_array *a=ln_array_new(1,shape,ln_dtype_by_name("int64"),0,0,&e);assert(a);
    ln_array *b=ln_array_new(1,shape,ln_dtype_by_name("int64"),0,0,&e);assert(b);
    int64_t av[]={INT64_MIN,-5,5,3},bv[]={-1,3,-3,0};
    memcpy(a->data,av,sizeof av);memcpy(b->data,bv,sizeof bv);
    const ln_array *inputs[]={a,b};ln_array *out=NULL;
    assert(ln_ufunc_execute(ln_ufunc_by_name("fmod"),inputs,&out,NULL,&e)==0);
    int64_t actual[4];memcpy(actual,out->data,sizeof actual);
    assert(actual[0]==0&&actual[1]==-2&&actual[2]==2&&actual[3]==0);
    ln_array_free(out);ln_array_free(a);ln_array_free(b);
    a=ln_array_new(0,NULL,ln_dtype_by_name("int8"),0,0,&e);assert(a);
    a->data[0]=2;
    ln_ufunc_operand ops[2]={{0}};ops[0].kind=LN_UFUNC_OPERAND_ARRAY;ops[0].array=a;
    ops[1].kind=LN_UFUNC_WEAK_INT;ops[1].integer=-3;out=NULL;
    assert(ln_ufunc_execute_operands(ln_ufunc_by_name("float_power"),ops,&out,NULL,&e)==0);
    double value;memcpy(&value,out->data,sizeof value);
    assert(out->descr->type_num==LN_DOUBLE&&value==.125);
    ln_array_free(out);out=NULL;ops[1].integer=300;
    assert(ln_ufunc_execute_operands(ln_ufunc_by_name("float_power"),ops,&out,NULL,&e)==0);
    memcpy(&value,out->data,sizeof value);assert(value==ldexp(1.,300));
    ln_array_free(out);ln_array_free(a);
    const ln_dtype_descr *s4=ln_string_make_dtype(0,4,'|',&e),*s8=ln_string_make_dtype(0,8,'|',&e);
    char left[4]={'a',0,'b',0},right[4]={'c',0,0,0},result[8];
    assert(ln_string_add_one(left,s4,right,s4,result,s8,&e)==0);
    assert(memcmp(result,"a\0bc\0\0\0\0",8)==0);
    assert(ln_string_add_one(left,s4,right,s4,result,s4,&e)<0);
    a=ln_array_new(1,(ln_intp[]){1},s4,0,0,&e);assert(a);memcpy(a->data,left,4);
    b=ln_array_new(1,(ln_intp[]){1},s4,0,0,&e);assert(b);memcpy(b->data,right,4);
    inputs[0]=a;inputs[1]=b;out=NULL;
    assert(ln_ufunc_execute(ln_ufunc_by_name("add"),inputs,&out,NULL,&e)==0);
    assert(out->descr->elsize==8&&memcmp(out->data,result,8)==0);
    ln_array_free(out);ln_array_free(a);ln_array_free(b);
    /* Descriptor overflow is rejected without allocating the declared strings. */
    const ln_dtype_descr *huge=ln_string_make_dtype(0,INT_MAX,'|',&e);assert(huge);
    ln_array fake={0};fake.descr=huge;fake.nd=1;ln_intp zero=0,stride=INT_MAX;
    fake.dimensions=&zero;fake.strides=&stride;fake.data=left;
    inputs[0]=inputs[1]=&fake;out=NULL;
    assert(ln_ufunc_execute(ln_ufunc_by_name("add"),inputs,&out,NULL,&e)<0&&out==NULL);
    puts("binary109 native tests passed");return 0;
}
