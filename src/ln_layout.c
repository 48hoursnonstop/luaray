#include "ln_layout.h"
#include "ln_creation.h"
#include <ctype.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

/* NumPy 2.5.3 shape.c: reshape/ravel/flatten; ctors.c:CopyAsFlat;
 * nditer_constr.c: stable KEEPORDER axis selection, DONT_NEGATE_STRIDES.
 * NumPy BSD attribution is retained in THIRD_PARTY_NUMPY_LICENSE.txt. */
static ln_array *bad(ln_error *err,const char *message)
{if(err)snprintf(err->message,sizeof err->message,"%s",message);return NULL;}

static char resolve_order(const ln_array *a,char order)
{
    order=(char)toupper((unsigned char)order);
    if(order=='A')return (a->flags&LN_ARRAY_F_CONTIGUOUS)&&!(a->flags&LN_ARRAY_C_CONTIGUOUS)?'F':'C';
    return order;
}
static uintmax_t magnitude(ln_intp value)
{return value<0?(uintmax_t)(-(value+1))+1:(uintmax_t)value;}

/* Axes ordered fastest to slowest. Zero strides remain ambiguous; stable
 * insertion retains their relative C traversal instead of inventing ordering. */
static void traversal_axes(const ln_array *a,char order,int *axes)
{
    for(int i=0;i<a->nd;++i)axes[i]=order=='F'?i:a->nd-1-i;
    if(order!='K')return;
    for(int i=1;i<a->nd;++i){
        int selected=axes[i],pos=i;
        for(int j=i-1;j>=0;--j){
            ln_intp x=a->strides[selected],y=a->strides[axes[j]];
            if(x&&y){if(magnitude(y)>magnitude(x))pos=j;else break;}
        }
        if(pos!=i){for(int j=i;j>pos;--j)axes[j]=axes[j-1];axes[pos]=selected;}
    }
}

ln_array *ln_layout_flatten(const ln_array *a,char order,ln_error *err)
{
    if(!a)return bad(err,"missing flatten input");
    order=resolve_order(a,order);
    if(order!='C'&&order!='F'&&order!='K')return bad(err,"flatten order must be C, F, A or K");
    ln_intp count=ln_array_size(a);
    if(count<0)return bad(err,"array size overflow");
    ln_array *out=ln_array_new(1,&count,a->descr,0,0,err);if(!out)return NULL;
    int axes[LN_MAXDIMS];traversal_axes(a,order,axes);
    ln_intp coord[LN_MAXDIMS]={0};
    for(ln_intp i=0;i<count;++i){
        const char *src=a->data;
        for(int d=0;d<a->nd;++d)src+=coord[d]*a->strides[d];
        memcpy(out->data+(size_t)i*a->descr->elsize,src,a->descr->elsize);
        for(int j=0;j<a->nd;++j){int d=axes[j];if(++coord[d]<a->dimensions[d])break;coord[d]=0;}
    }
    return out;
}

/* shape.c:_attempt_nocopy_reshape, including F-order group strides and
 * arbitrary strides on singleton dimensions. Only nonempty arrays need it. */
static int attempt_view(const ln_array *a,int nd,const ln_intp *shape,
                        ln_intp *strides,int fortran)
{
    ln_intp dims[LN_MAXDIMS],oldstrides[LN_MAXDIMS];int oldnd=0;
    for(int i=0;i<a->nd;++i)if(a->dimensions[i]!=1){
        dims[oldnd]=a->dimensions[i];oldstrides[oldnd++]=a->strides[i];
    }
    int oi=0,oj=1,ni=0,nj=1;
    while(ni<nd&&oi<oldnd){
        ln_intp np=shape[ni],op=dims[oi];
        while(np!=op){
            if(np<op){if(nj>=nd)return 0;np*=shape[nj++];}
            else{if(oj>=oldnd)return 0;op*=dims[oj++];}
        }
        for(int k=oi;k<oj-1;++k){
            if(fortran){if(oldstrides[k+1]!=dims[k]*oldstrides[k])return 0;}
            else if(oldstrides[k]!=dims[k+1]*oldstrides[k+1])return 0;
        }
        if(fortran){
            strides[ni]=oldstrides[oi];
            for(int k=ni+1;k<nj;++k)strides[k]=strides[k-1]*shape[k-1];
        }else{
            strides[nj-1]=oldstrides[oj-1];
            for(int k=nj-1;k>ni;--k)strides[k-1]=strides[k]*shape[k];
        }
        ni=nj++;oi=oj++;
    }
    ln_intp last=ni?strides[ni-1]:(ln_intp)a->descr->elsize;
    if(fortran&&ni)last*=shape[ni-1];
    for(int k=ni;k<nd;++k)strides[k]=last;
    return 1;
}

ln_array *ln_layout_reshape(const ln_array *a,int nd,const ln_intp *newshape,
                            char order,int copy,ln_error *err)
{
    if(!a||nd<0||nd>LN_MAXDIMS||(nd&&!newshape)||copy< -1||copy>1)
        return bad(err,"invalid reshape arguments");
    order=resolve_order(a,order);
    if(order!='C'&&order!='F')return bad(err,"reshape order must be C, F or A");
    if(copy!=1&&nd==a->nd){
        int same=1;for(int d=0;d<nd;++d)if(newshape[d]!=a->dimensions[d])same=0;
        if(same)return ln_array_view(a,nd,a->dimensions,a->strides,a->data,err);
    }
    ln_intp shape[LN_MAXDIMS],strides[LN_MAXDIMS],count=1,oldcount=ln_array_size(a);
    int unknown=-1;
    for(int d=0;d<nd;++d){
        shape[d]=newshape[d];
        if(shape[d]<0){if(unknown>=0)return bad(err,"can only specify one unknown dimension");unknown=d;continue;}
        if(ln_mul_sizes_with_overflow(&count,count,shape[d]))return bad(err,"reshape size overflow");
    }
    if(unknown>=0){
        if(count==0||oldcount%count)return bad(err,"cannot infer reshape dimension");
        shape[unknown]=oldcount/count;count=oldcount;
    }
    if(oldcount!=count)return bad(err,"cannot reshape array: size mismatch");
    ln_intp span=(ln_intp)a->descr->elsize;
    for(int d=0;d<nd;++d)if(shape[d]&&ln_mul_sizes_with_overflow(&span,span,shape[d]))
        return bad(err,"reshape strides exceed maximum array size");
    int contiguous=(a->flags&(order=='F'?LN_ARRAY_F_CONTIGUOUS:LN_ARRAY_C_CONTIGUOUS))!=0;
    int has_strides=0;
    if(copy!=1&&!contiguous&&count)has_strides=attempt_view(a,nd,shape,strides,order=='F');
    ln_array *owned=NULL;
    const ln_array *base=a;
    if(copy==1||(!contiguous&&!has_strides)){
        if(copy==0)return bad(err,"unable to avoid creating a copy while reshaping");
        owned=ln_creation_convert(a,NULL,order,1,0,NULL,err);if(!owned)return NULL;
        base=owned;has_strides=0;
    }
    if(!has_strides){
        int flags=0;ln_array_fill_strides(strides,shape,nd,base->descr->elsize,
                          order=='F'?LN_ARRAY_F_CONTIGUOUS:LN_ARRAY_C_CONTIGUOUS,&flags);
    }
    ln_array *out=ln_array_view(base,nd,shape,strides,base->data,err);
    if(owned)ln_array_free(owned);
    return out;
}

ln_array *ln_layout_ravel(const ln_array *a,char order,ln_error *err)
{
    if(!a)return bad(err,"missing ravel input");
    order=resolve_order(a,order);
    if(order=='K'){
        if(a->flags&LN_ARRAY_C_CONTIGUOUS)order='C';
        else if(a->flags&LN_ARRAY_F_CONTIGUOUS)order='F';
    }
    if(order!='C'&&order!='F'&&order!='K')return bad(err,"ravel order must be C, F, A or K");
    if((order=='C'&&(a->flags&LN_ARRAY_C_CONTIGUOUS))||
       (order=='F'&&(a->flags&LN_ARRAY_F_CONTIGUOUS))){
        ln_intp shape=-1;return ln_layout_reshape(a,1,&shape,order,-1,err);
    }
    if(order=='K'){
        /* Unlike iterator traversal this view check sorts all raw strides,
         * retaining their sign. Negative/zero non-singleton strides fail. */
        int axes[LN_MAXDIMS];for(int i=0;i<a->nd;++i)axes[i]=a->nd-1-i;
        for(int i=1;i<a->nd;++i){
            int x=axes[i],j=i;
            while(j&&magnitude(a->strides[axes[j-1]])>magnitude(a->strides[x])){
                axes[j]=axes[j-1];--j;
            }axes[j]=x;
        }
        ln_intp stride=(ln_intp)a->descr->elsize;int matches=1;
        for(int i=0;i<a->nd;++i){int d=axes[i];if(a->dimensions[d]==1)continue;
            if(a->strides[d]!=stride){matches=0;break;}stride*=a->dimensions[d];}
        if(matches){ln_intp count=ln_array_size(a),item=(ln_intp)a->descr->elsize;
            return ln_array_view(a,1,&count,&item,a->data,err);}
    }
    return ln_layout_flatten(a,order,err);
}
