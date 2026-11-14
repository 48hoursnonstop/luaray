#include "ln_quantile.h"
#include "ln_linalg.h"
#include <assert.h>
#include <math.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>
int main(void){
 ln_error error={0};ln_intp dims[]={0,3,4};const ln_dtype *dt=ln_dtype_by_name("float64");
 ln_array *a=ln_array_new(3,dims,dt,0,0,&error);assert(a);
 uint8_t axes[]={0,1,1};double q=0.25;
 ln_array *r=ln_quantile(a,axes,0,&q,1,1,0,NULL,NULL,0,&error);assert(r&&r->nd==1&&r->dimensions[0]==0);ln_array_free(r);
 r=ln_quantile(a,axes,1,&q,1,1,6,NULL,NULL,0,&error);assert(r&&r->nd==3&&!(r->flags&LN_ARRAY_OWNDATA));
 assert(!r->strides[0]&&!r->strides[1]&&!r->strides[2]);ln_array_free(a);ln_array_free(r);
 a=ln_array_new(2,(ln_intp[]){2,3},dt,1,0,&error);assert(a);
 double values[]={1,4,2,5,3,6};memcpy(a->data,values,sizeof values);
 uint8_t none[]={0,0};q=0.5;r=ln_quantile(a,none,0,&q,1,1,6,NULL,NULL,0,&error);assert(r);
 assert(r->strides[0]==8&&r->strides[1]==16&&!memcmp(r->data,values,sizeof values));ln_array_free(r);
 uint8_t first[]={1,0};r=ln_quantile(a,first,1,&q,1,1,6,NULL,NULL,0,&error);assert(r&&r->strides[0]==0&&r->strides[1]==8);
 double expected[]={2.5,3.5,4.5};assert(!memcmp(r->data,expected,sizeof expected));ln_array_free(a);assert(!memcmp(r->data,expected,sizeof expected));ln_array_free(r);
 a=ln_array_new(2,(ln_intp[]){2,2},dt,0,0,&error);assert(a);
 double bad[]={1,INFINITY,0,1};memcpy(a->data,bad,sizeof bad);
 r=ln_linalg_cond(a,LN_NORM_NUMBER,-1,&error);assert(r);double result;memcpy(&result,r->data,8);assert(isinf(result));ln_array_free(r);
 ln_array *singular=NULL;assert(ln_linalg_svd(a,1,0,0,NULL,&singular,NULL,&error)<0&&singular==NULL);ln_array_free(a);
 a=ln_array_new(1,(ln_intp[]){0},ln_dtype_by_name("timedelta64[D]"),0,0,&error);assert(a);
 ln_array *out=ln_array_new(1,(ln_intp[]){0},dt,0,0,&error);assert(out);
 assert(ln_accumulate_into_ex(a,0,NULL,out,LN_REDUCE_SUM,&error)<0);ln_array_free(out);
 out=ln_array_new(1,(ln_intp[]){0},ln_dtype_by_name("int16"),0,0,&error);assert(out);
 assert(!ln_accumulate_into_ex(a,0,NULL,out,LN_REDUCE_SUM,&error));ln_array_free(out);ln_array_free(a);
 a=ln_array_new(1,(ln_intp[]){0},dt,0,0,&error);assert(a);
 ln_intp empty_dims[]={3,0},empty_steps[]={INTPTR_MAX,8};uint8_t last_axis[]={0,1};q=0.5;
 for(int sign=0;sign<2;sign++){
  empty_steps[0]=sign?INTPTR_MIN:INTPTR_MAX;
  ln_array *v=ln_array_view(a,2,empty_dims,empty_steps,a->data,&error);assert(v);
  r=ln_quantile(v,last_axis,0,&q,1,1,6,NULL,NULL,0,&error);assert(r);
  for(int i=0;i<3;i++){double value;memcpy(&value,r->data+i*r->strides[0],8);assert(isnan(value));}
  ln_array_free(r);ln_array_free(v);
 }
 ln_array_free(a);
 a=ln_array_new(0,NULL,dt,0,0,&error);assert(a);double seven=7;memcpy(a->data,&seven,8);
 for(int method=0;method<=6;method+=6){
  r=ln_quantile(a,NULL,1,&q,1,1,method,NULL,NULL,0,&error);assert(r&&r->nd==0);
  assert(!(r->flags&LN_ARRAY_OWNDATA)&&!memcmp(r->data,&seven,8));ln_array_free(r);
 }
 ln_array_free(a);
 puts("numpy158 native: empty quantile axes, K-order medians, retained keepdims views, nonfinite norms and accumulate dtype validation passed");return 0;
}
