#include "ln_integer_math.h"
#include "ln_bytes.h"
#include <assert.h>
#include <limits.h>
#include <stdio.h>
#include <string.h>
int main(void) {
 ln_error e={0};ln_intp dim=6;
 ln_array *a=ln_array_new(1,&dim,ln_dtype_by_name("int64"),0,1,&e);assert(a);
 int64_t input[]={INT64_MIN,-7,-1,0,7,INT64_MAX};memcpy(a->data,input,sizeof input);
 const ln_array *args[]={a};ln_array *out=NULL;
 assert(!ln_ufunc_execute(ln_ufunc_by_name("bitwise_count"),args,&out,NULL,&e));
 uint8_t counts[]={1,3,1,0,3,63};assert(!memcmp(out->data,counts,sizeof counts));ln_array_free(out);out=NULL;
 assert(!ln_ufunc_execute(ln_ufunc_by_name("invert"),args,&out,NULL,&e));
 int64_t inverses[]={INT64_MAX,6,0,-1,-8,INT64_MIN};assert(!memcmp(out->data,inverses,sizeof inverses));ln_array_free(out);out=NULL;
 ln_array *b=ln_array_new(1,&dim,ln_dtype_by_name("int64"),0,1,&e);assert(b);
 int64_t shifts[]={0,1,63,64,-1,1};memcpy(b->data,shifts,sizeof shifts);
 const ln_array *binary[]={a,b};
 assert(!ln_ufunc_execute(ln_ufunc_by_name("right_shift"),binary,&out,NULL,&e));
 int64_t right[]={INT64_MIN,-4,-1,0,0,INT64_MAX/2};assert(!memcmp(out->data,right,sizeof right));ln_array_free(out);out=NULL;
 assert(!ln_ufunc_execute(ln_ufunc_by_name("left_shift"),binary,&out,NULL,&e));
 int64_t left[]={INT64_MIN,-14,INT64_MIN,0,0,-2};assert(!memcmp(out->data,left,sizeof left));ln_array_free(out);
 out=NULL;assert(!ln_ufunc_execute(ln_ufunc_by_name("gcd"),binary,&out,NULL,&e));
 int64_t gcd[]={INT64_MIN,1,1,64,1,1};assert(!memcmp(out->data,gcd,sizeof gcd));ln_array_free(out);
 out=NULL;assert(!ln_ufunc_execute(ln_ufunc_by_name("lcm"),binary,&out,NULL,&e));
 int64_t lcm[]={0,7,63,0,7,INT64_MAX};assert(!memcmp(out->data,lcm,sizeof lcm));ln_array_free(out);
 ln_array_free(a);ln_array_free(b);
 a=ln_array_new(1,(ln_intp[]){3},ln_dtype_by_name("uint64"),0,1,&e);assert(a);
 uint64_t wide[]={0,UINT64_MAX,UINT64_C(1)<<63};memcpy(a->data,wide,sizeof wide);
 const ln_array *single[]={a};out=NULL;
 assert(!ln_ufunc_execute(ln_ufunc_by_name("bitwise_count"),single,&out,NULL,&e));
 uint8_t wide_counts[]={0,64,1};assert(!memcmp(out->data,wide_counts,sizeof wide_counts));ln_array_free(out);ln_array_free(a);
 a=ln_array_new(1,(ln_intp[]){2},ln_dtype_by_name("uint64"),0,1,&e);assert(a);
 b=ln_bytes_field(a,ln_dtype_by_name("uint16"),1,&e);assert(b&&!(b->flags&LN_ARRAY_ALIGNED));
 uint16_t value=0x0102;memcpy(b->data,&value,2);memcpy(b->data+b->strides[0],&value,2);
 const ln_array *unaligned[]={b};out=NULL;
 assert(!ln_ufunc_execute(ln_ufunc_by_name("invert"),unaligned,&out,NULL,&e));
 uint16_t inverse[]={0xfefd,0xfefd};assert(!memcmp(out->data,inverse,sizeof inverse));ln_array_free(out);ln_array_free(b);ln_array_free(a);
 a=ln_array_new(1,(ln_intp[]){1},ln_dtype_by_name("uint8"),0,1,&e);assert(a);a->data[0]=(char)255;
 ln_ufunc_operand operands[2]={{0},{0}};operands[0].array=a;
 operands[1].kind=LN_UFUNC_WEAK_INT;operands[1].integer=1;out=NULL;
 assert(!ln_ufunc_execute_operands(ln_ufunc_by_name("left_shift"),operands,&out,NULL,&e));assert((uint8_t)out->data[0]==254);ln_array_free(out);out=NULL;
 operands[1].integer=256;assert(ln_ufunc_execute_operands(ln_ufunc_by_name("left_shift"),operands,&out,NULL,&e)<0&&out==NULL);ln_array_free(a);
 a=ln_array_new(1,(ln_intp[]){1},ln_dtype_by_name("float32"),0,1,&e);assert(a);single[0]=a;out=NULL;
 assert(ln_ufunc_execute(ln_ufunc_by_name("invert"),single,&out,NULL,&e)<0&&out==NULL);ln_array_free(a);
 assert(ln_promote_dtype(ln_dtype_by_name("longlong"),ln_dtype_by_name("int64"))->type_num==LN_LONGLONG);
 assert(ln_promote_dtype(ln_dtype_by_name("int64"),ln_dtype_by_name("longlong"))->type_num==LN_LONGLONG);
 puts("integer154 native: bits, signed boundaries, gcd/lcm, unaligned views, weak bounds and alias promotion passed");
}
