#include "ln_bits.h"
#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
int main(void)
{
 ln_error error={0};ln_intp n=9;const ln_dtype *dtype=ln_dtype_by_name("int16");
 ln_array *a=ln_array_new(1,&n,dtype,0,0,&error);assert(a);
 int16_t values[]={1,0,-1,0,1,0,1,0,7};memcpy(a->data,values,sizeof values);
 ln_array *packed=ln_packbits(a,-1,0,&error);assert(packed&&packed->dimensions[0]==2);
 unsigned char expected[]={170,128};assert(!memcmp(packed->data,expected,2));
 ln_intp count=9;ln_array *unpacked=ln_unpackbits(packed,0,&count,0,&error);assert(unpacked);
 unsigned char bits[]={1,0,1,0,1,0,1,0,1};assert(!memcmp(unpacked->data,bits,9));ln_array_free(unpacked);
 ln_array_free(a);ln_array_free(packed);
 n=0;a=ln_array_new(1,&n,ln_dtype_by_name("uint8"),0,0,&error);assert(a);
 count=17;unpacked=ln_unpackbits(a,0,&count,1,&error);assert(unpacked);
 unsigned char zeros[17]={0};assert(!memcmp(unpacked->data,zeros,17));ln_array_free(unpacked);

 ln_intp empty_shape[]={3,0},empty_strides[]={INTPTR_MAX,1};
 for(int sign=0;sign<2;sign++){
  empty_strides[0]=sign?INTPTR_MIN:INTPTR_MAX;
  ln_array *extreme=ln_array_view(a,2,empty_shape,empty_strides,a->data,&error);assert(extreme);
  count=17;unpacked=ln_unpackbits(extreme,1,&count,sign,&error);assert(unpacked);
  unsigned char padded_zero[51]={0};assert(!memcmp(unpacked->data,padded_zero,51));
  ln_array_free(unpacked);ln_array_free(extreme);
 }
 count=INTPTR_MIN;assert(!ln_unpackbits(a,0,&count,0,&error));
 ln_intp dims[]={0,INTPTR_MAX/8+1},strides[]={0,0};
 ln_array *huge=ln_array_view(a,2,dims,strides,a->data,&error);assert(huge);
 assert(!ln_unpackbits(huge,1,NULL,0,&error));ln_array_free(huge);ln_array_free(a);
 n=1;a=ln_array_new(1,&n,ln_dtype_by_name("uint8"),0,0,&error);assert(a);a->data[0]=3;
 packed=ln_packbits(a,0,1,&error);assert(packed&&packed->data[0]==1);ln_array_free(packed);
 count=-9;assert(!ln_unpackbits(a,0,&count,0,&error));
 assert(!ln_packbits(a,1,0,&error));assert(!ln_packbits(a,0,2,&error));
 ln_array_free(a);
 ln_intp shape[LN_MAXDIMS];for(int i=0;i<LN_MAXDIMS;i++)shape[i]=1;
 a=ln_array_new(33,shape,ln_dtype_by_name("uint8"),0,1,&error);assert(a);
 assert(!ln_packbits(a,0,0,&error));packed=ln_packbits(a,-1,0,&error);assert(packed&&packed->nd==1);
 ln_array_free(a);assert(packed->data[0]==0);ln_array_free(packed);
 puts("bits157 native: padding, signed truth, bounds, storage lifetime, overflow and axis-iterator rank cap passed");return 0;
}
