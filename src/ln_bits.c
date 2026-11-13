#include "ln_bits.h"
#include "ln_layout.h"
#include <stdio.h>
#include <string.h>
/* NumPy 2.5.3 compiled_base.c pack_inner/pack_bits/unpack_bits; scalar
 * traversal preserves truth bytes, axis layout, padding and logical order. */
static ln_array *bad(ln_error *err,const char *text,int type)
{if(err){snprintf(err->message,sizeof err->message,"%s",text);err->kind=type?LN_ERROR_TYPE:LN_ERROR_VALUE;}return NULL;}
static ln_array *prepare(const ln_array *a,int *axis,int little,ln_error *err)
{
    if(little!=0&&little!=1)return bad(err,"invalid bit order",0);
    if(*axis < -1)return bad(err,"invalid bit axis",0);
    if(*axis==-1||a->nd==0){
        if(*axis>0)return bad(err,"bit axis is outside array rank",0);
        ln_array *flat=ln_layout_ravel(a,'C',err);*axis=0;return flat;
    }
    if(*axis>=a->nd)return bad(err,"bit axis is outside array rank",0);
    if(a->nd>32)return bad(err,"bit-packing axis iteration supports at most 32 dimensions",0);
    return ln_array_view(a,a->nd,a->dimensions,a->strides,a->data,err);
}
static void advance(int nd,const ln_intp *shape,ln_intp *position)
{for(int d=nd-1;d>=0;d--){if(++position[d]<shape[d])break;position[d]=0;}}
static ln_array *output(const ln_array *a,int axis,ln_intp length,ln_error *err)
{
    ln_intp shape[LN_MAXDIMS];memcpy(shape,a->dimensions,(size_t)a->nd*sizeof(*shape));shape[axis]=length;
    int fortran=(a->flags&LN_ARRAY_F_CONTIGUOUS)&&!(a->flags&LN_ARRAY_C_CONTIGUOUS);
    return ln_array_new(a->nd,shape,ln_dtype_by_name("uint8"),fortran,0,err);
}
ln_array *ln_packbits(const ln_array *a,int axis,int little,ln_error *err)
{
    if(!a||(a->descr->kind!='b'&&a->descr->kind!='i'&&a->descr->kind!='u'))
        return bad(err,"packbits expects integer or Boolean data",1);
    ln_array *input=prepare(a,&axis,little,err);if(!input)return NULL;
    ln_intp n=input->dimensions[axis],length=n/8+(n%8!=0);
    ln_array *out=output(input,axis,length,err);if(!out){ln_array_free(input);return NULL;}
    ln_intp position[LN_MAXDIMS]={0},size=ln_array_size(out);
    for(ln_intp i=0;i<size;i++){
        const char *source=input->data;char *destination=out->data;
        for(int d=0;d<out->nd;d++){
            if(d!=axis)source+=position[d]*input->strides[d];
            destination+=position[d]*out->strides[d];
        }
        ln_intp start=position[axis]*8,remaining=n-start;int bits=remaining<8?(int)remaining:8;
        unsigned char byte=0;
        for(int bit=0;bit<bits;bit++){
            const unsigned char *element=(const unsigned char*)(source+(start+bit)*input->strides[axis]);
            int truth=0;for(size_t b=0;b<input->descr->elsize;b++)truth|=element[b]!=0;
            if(truth)byte|=(unsigned char)(1u<<(little?bit:7-bit));
        }
        memcpy(destination,&byte,1);advance(out->nd,out->dimensions,position);
    }
    ln_array_free(input);return out;
}
ln_array *ln_unpackbits(const ln_array *a,int axis,const ln_intp *count,int little,ln_error *err)
{
    if(!a||a->descr->type_num!=LN_UBYTE)return bad(err,"unpackbits expects uint8 data",1);
    ln_array *input=prepare(a,&axis,little,err);if(!input)return NULL;
    ln_intp available;
    if(ln_mul_sizes_with_overflow(&available,input->dimensions[axis],8)!=0){ln_array_free(input);return bad(err,"unpacked axis size exceeds intp",0);}
    ln_intp length=available;
    if(count){
        if(*count<0){
            if(*count < -available){ln_array_free(input);return bad(err,"negative count exceeds available bits",0);}
            length=available+*count;
        }else length=*count;
    }
    ln_array *out=output(input,axis,length,err);if(!out){ln_array_free(input);return NULL;}
    ln_intp position[LN_MAXDIMS]={0},size=ln_array_size(out);
    /* Empty arrays can have arbitrary strides. Padding needs no input
     * address arithmetic, including offsets that cannot fit in intp. */
    if(available==0){
        if(size)memset(out->data,0,(size_t)size);
        ln_array_free(input);return out;
    }
    for(ln_intp i=0;i<size;i++){
        const char *source=input->data;char *destination=out->data;
        for(int d=0;d<out->nd;d++){
            if(d!=axis)source+=position[d]*input->strides[d];
            destination+=position[d]*out->strides[d];
        }
        unsigned char value=0;ln_intp bit=position[axis];
        if(bit<available){
            unsigned char byte;memcpy(&byte,source+(bit/8)*input->strides[axis],1);
            value=(unsigned char)((byte>>(little?(int)(bit%8):7-(int)(bit%8)))&1u);
        }
        memcpy(destination,&value,1);advance(out->nd,out->dimensions,position);
    }
    ln_array_free(input);return out;
}
