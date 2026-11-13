#include "ln_index_math.h"
#include "ln_order.h"
#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
static ln_intp item(const ln_array *a){ln_intp value;memcpy(&value,a->data,sizeof value);return value;}
int main(void)
{
 ln_error error={0};const ln_dtype *dtype=ln_dtype_by_name(sizeof(ln_intp)==8?"int64":"int32");
 ln_array *row=ln_array_new(0,NULL,dtype,0,1,&error),*column=ln_array_new(0,NULL,dtype,0,1,&error);assert(row&&column);
 ln_intp r=2,c=3;memcpy(row->data,&r,sizeof r);memcpy(column->data,&c,sizeof c);
 const ln_array *coordinates[]={row,column};ln_index_mode modes[]={LN_INDEX_RAISE,LN_INDEX_RAISE};
 ln_array *out=ln_ravel_multi_index(2,(ln_intp[]){2,3},coordinates,modes,'C',&error);assert(out&&item(out)==6);ln_array_free(out);
 c=1;memcpy(column->data,&c,sizeof c);
 out=ln_ravel_multi_index(2,(ln_intp[]){2,3},coordinates,modes,'F',&error);assert(out&&item(out)==2);ln_array_free(out);
 r=-1;c=99;memcpy(row->data,&r,sizeof r);memcpy(column->data,&c,sizeof c);modes[0]=LN_INDEX_WRAP;modes[1]=LN_INDEX_CLIP;
 out=ln_ravel_multi_index(2,(ln_intp[]){2,3},coordinates,modes,'C',&error);assert(out&&item(out)==6);ln_array_free(out);
 r=0;memcpy(row->data,&r,sizeof r);assert(!ln_ravel_multi_index(2,(ln_intp[]){2,3},coordinates,modes,'C',&error));
 r=c=1;memcpy(row->data,&r,sizeof r);memcpy(column->data,&c,sizeof c);
 ln_intp overflow;assert(ln_mul_sizes_with_overflow(&overflow,INTPTR_MAX,2)!=0);
 assert(!ln_ravel_multi_index(2,(ln_intp[]){INTPTR_MAX,2},coordinates,modes,'C',&error));
 assert(!ln_unravel_index_storage(row,2,(ln_intp[]){INTPTR_MAX,2},'C',&error));
 out=ln_ravel_multi_index(0,NULL,NULL,NULL,'C',&error);assert(out&&item(out)==1);ln_array_free(out);
 ln_array *indices=ln_array_new(1,(ln_intp[]){3},dtype,0,1,&error);assert(indices);
 ln_intp values[]={1,3,6};memcpy(indices->data,values,sizeof values);
 out=ln_unravel_index_storage(indices,2,(ln_intp[]){2,3},'C',&error);assert(out&&out->nd==2);
 ln_intp expected[]={1,1,1,3,2,3};assert(!memcmp(out->data,expected,sizeof expected));
 assert(out->strides[0]==16&&out->strides[1]==8);
 ln_array *view=ln_array_view(out,1,(ln_intp[]){3},out->strides,out->data+sizeof(ln_intp),&error);assert(view);
 ln_array_free(out);assert(item(view)==1);assert(view->strides[0]==16);ln_array_free(view);
 ln_array_free(indices);ln_array_free(row);ln_array_free(column);
 ln_intp dimensions[LN_MAXDIMS],strides[LN_MAXDIMS]={0};
 for(int i=0;i<LN_MAXDIMS;i++)dimensions[i]=1;
 row=ln_array_new(0,NULL,dtype,0,1,&error);assert(row);r=1;memcpy(row->data,&r,sizeof r);
 const ln_array *many[LN_MAXDIMS];ln_index_mode many_modes[LN_MAXDIMS];
 for(int i=0;i<LN_MAXDIMS;i++){many[i]=row;many_modes[i]=LN_INDEX_RAISE;}
 out=ln_ravel_multi_index(63,dimensions,many,many_modes,'C',&error);assert(out&&item(out)==1);ln_array_free(out);
 assert(!ln_ravel_multi_index(64,dimensions,many,many_modes,'C',&error));
 out=ln_unravel_index_storage(row,64,dimensions,'C',&error);assert(out&&out->nd==1&&out->dimensions[0]==64);ln_array_free(out);
 indices=ln_array_new(64,dimensions,dtype,0,1,&error);assert(indices);
 assert(!ln_unravel_index_storage(indices,1,(ln_intp[]){3},'C',&error));ln_array_free(indices);ln_array_free(row);
 const ln_intp *rows[]={strides};int order[LN_MAXDIMS];
 strides[0]=INTPTR_MIN;strides[1]=8;
 assert(!ln_keeporder_axes(2,1,rows,order,&error));assert(order[0]==1&&order[1]==0);
 strides[0]=8;strides[1]=0;strides[2]=16;
 assert(!ln_keeporder_axes(3,1,rows,order,&error));assert(order[0]==0&&order[1]==2&&order[2]==1);
 assert(ln_keeporder_axes(-1,1,rows,order,&error)<0);
 puts("index155 native: C/F coordinates, bounds modes, checked overflow, storage lifetime, rank caps and safe KEEPORDER passed");return 0;
}
