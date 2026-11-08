/* Source-derived from NumPy 2.5.3 item_selection.c:PyArray_PutTo and
 * compiled_base.c:arr_place. See NUMPY_2_5_3_WRITE98_FILE_HASHES.sha256. */
#include "ln_write.h"
#include "ln_mapping.h"
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static int bad(ln_error *err, const char *message)
{
    if (err) snprintf(err->message, sizeof(err->message), "%s", message);
    return -1;
}

static int prepared(const ln_array *a)
{
    return a && (a->flags & LN_ARRAY_C_CONTIGUOUS) && ln_array_size(a) >= 0;
}

/* These operands are contiguous, so their byte intervals determine overlap
 * exactly. Merely sharing an owner does not imply overlapping storage. */
static int overlaps(const ln_array *a, const ln_array *b)
{
    if (!a->owner || a->owner != b->owner) return 0;
    uintptr_t ap = (uintptr_t)a->data, bp = (uintptr_t)b->data;
    size_t an = (size_t)ln_array_size(a) * a->descr->elsize;
    size_t bn = (size_t)ln_array_size(b) * b->descr->elsize;
    return an && bn && (ap <= bp ? bp - ap < an : ap - bp < bn);
}

static void writeback(ln_array *dst, const ln_array *src)
{
    ln_intp coord[LN_MAXDIMS] = {0}, count = ln_array_size(dst);
    size_t width = dst->descr->elsize;
    for (ln_intp i = 0; i < count; ++i) {
        char *p = dst->data;
        for (int d = 0; d < dst->nd; ++d) p += coord[d] * dst->strides[d];
        memcpy(p, src->data + (size_t)i * width, width);
        for (int d = dst->nd - 1; d >= 0; --d) {
            if (++coord[d] < dst->dimensions[d]) break;
            coord[d] = 0;
        }
    }
}

int ln_array_put(ln_array *dst, const ln_array *indices, const ln_array *values,
                 ln_put_mode mode, ln_error *err)
{
    if (!dst || !prepared(indices) || !prepared(values) ||
        indices->descr->kind != 'i' || indices->descr->elsize != sizeof(ln_intp) ||
        values->descr != dst->descr || mode < LN_PUT_RAISE || mode > LN_PUT_CLIP)
        return bad(err, "invalid prepared put operands");
    if (!(dst->flags & LN_ARRAY_WRITEABLE)) return bad(err, "put destination is read-only");
    ln_intp size = ln_array_size(dst), ni = ln_array_size(indices), nv = ln_array_size(values);
    if (size < 0) return bad(err, "put destination is too large");
    if (ni && !size) return bad(err, "cannot replace elements of an empty array");
    if (!nv) return 0;

    ln_array *copy = NULL, *work = dst;
    if (!(dst->flags & LN_ARRAY_C_CONTIGUOUS) || overlaps(dst, indices) || overlaps(dst, values)) {
        copy = ln_array_copy_c(dst, err);
        if (!copy) return -1;
        work = copy;
    }
    size_t width = dst->descr->elsize;
    for (ln_intp i = 0; i < ni; ++i) {
        ln_intp raw, index;
        memcpy(&raw, indices->data + (size_t)i * sizeof(raw), sizeof(raw));
        if (!raw) {
            ln_array_free(copy);
            return bad(err, "index 0 is invalid in Lua's 1-based indexing model");
        }
        index = raw > 0 ? raw - 1 : raw;
        if (mode == LN_PUT_RAISE) {
            if (index < 0) index += size;
            if (index < 0 || index >= size) {
                ln_array_free(copy);
                return bad(err, "put index out of bounds");
            }
        }
        else if (mode == LN_PUT_WRAP) {
            index %= size;
            if (index < 0) index += size;
        }
        else {
            if (index < 0) index = 0;
            else if (index >= size) index = size - 1;
        }
        memmove(work->data + (size_t)index * width,
                values->data + (size_t)(i % nv) * width, width);
    }
    if (copy) { writeback(dst, copy); ln_array_free(copy); }
    return 0;
}

static int masked_write(ln_array *dst, const ln_array *mask, const ln_array *values,
                         int positional, ln_error *err)
{
    if (!dst || !prepared(mask) || !prepared(values) ||
        mask->descr->type_num != LN_BOOL || values->descr != dst->descr)
        return bad(err, "invalid prepared masked-write operands");
    if (!(dst->flags & LN_ARRAY_WRITEABLE)) return bad(err, "masked-write destination is read-only");
    ln_intp size = ln_array_size(dst), nm = ln_array_size(mask), nv = ln_array_size(values);
    if (size < 0 || size != nm) return bad(err, "mask and data must be the same size");
    if (!nv) {
        if (positional) return 0;
        for (ln_intp i = 0; i < size; ++i)
            if ((unsigned char)mask->data[i]) return bad(err, "cannot insert from an empty array");
        return 0;
    }
    ln_array *copy = NULL, *work = dst;
    if (!(dst->flags & LN_ARRAY_C_CONTIGUOUS) ||
        (positional && (overlaps(dst,mask) || overlaps(dst,values)))) {
        copy = ln_array_copy_c(dst, err);
        if (!copy) return -1;
        work = copy;
    }
    /* place reads compatible contiguous aliased values live and advances only
     * at selected positions. putmask protects overlap and advances everywhere. */
    size_t width = dst->descr->elsize;
    ln_intp j = 0;
    for (ln_intp i = 0; i < size; ++i) {
        if ((unsigned char)mask->data[i]) {
            memmove(work->data + (size_t)i * width, values->data + (size_t)j * width, width);
            if (!positional && ++j == nv) j = 0;
        }
        if (positional && ++j == nv) j = 0;
    }
    if (copy) { writeback(dst, copy); ln_array_free(copy); }
    return 0;
}

int ln_array_place(ln_array *dst,const ln_array *mask,const ln_array *values,ln_error *err)
{ return masked_write(dst,mask,values,0,err); }

int ln_array_putmask(ln_array *dst,const ln_array *mask,const ln_array *values,ln_error *err)
{ return masked_write(dst,mask,values,1,err); }

static uint64_t stride_magnitude(ln_intp stride)
{ return stride<0 ? (uint64_t)(-(stride+1))+1 : (uint64_t)stride; }

static int raw_aligned(const ln_array *a)
{
    size_t width=a->descr->elsize;
    if(!width || width>16 || (width&(width-1)))return 0;
    if((uintptr_t)a->data%width || (uintptr_t)a->data%a->descr->alignment)return 0;
    for(int d=0;d<a->nd;++d)if(a->dimensions[d]>1 &&
        (stride_magnitude(a->strides[d])%width || stride_magnitude(a->strides[d])%a->descr->alignment))return 0;
    return 1;
}

/* Source anchors: array_assign_{array,scalar}.c, shape.c's stride permutation,
 * dtype_transfer.c's raw iterators and masked transfer wrapper. */
int ln_array_copyto(ln_array *dst,const ln_array *input,const ln_array *where,
                    int scalar_where,ln_casting casting,ln_error *err)
{
    char *buffer=NULL;
    if(!dst || !input || (where && where->descr->type_num!=LN_BOOL))
        return bad(err,"invalid copyto operands");
    int identical=input->nd>0 && input->nd==dst->nd && input->descr==dst->descr && input->data==dst->data;
    for(int d=0;identical && d<dst->nd;++d)
        identical=input->dimensions[d]==dst->dimensions[d] && input->strides[d]==dst->strides[d];
    if(identical)return 0;
    if(!(dst->flags&LN_ARRAY_WRITEABLE))return bad(err,"copyto destination is read-only");
    if(!ln_dtype_can_cast(input->descr,dst->descr,casting))return bad(err,"copyto dtype violates the casting rule");
    ln_intp count=ln_array_size(dst);
    if(count<0)return bad(err,"copyto destination is too large");
    const ln_array *src=input;
    ln_array *temporary=NULL;
    if(input->nd==0 && input->descr!=dst->descr && count>1) {
        temporary=ln_array_new(0,NULL,dst->descr,0,0,err);
        if(!temporary)return -1;
        if(ln_cast_strided_numeric(input->data,0,input->descr,temporary->data,0,dst->descr,1,err)<0)goto fail;
        src=temporary;
    }
    else if(input->nd>0 && dst->owner && input->owner==dst->owner &&
            (dst->nd>1 || (dst->nd==1 && dst->strides[0] && input->strides[input->nd-1] &&
             ((dst->strides[0]<0)!=(input->strides[input->nd-1]<0))))) {
        temporary=ln_array_copy_c(input,err);
        if(!temporary)return -1;
        src=temporary;
    }
    ln_intp ss[LN_MAXDIMS]={0},ms[LN_MAXDIMS]={0};
    int snd=src->nd;const ln_intp *s_dims=src->dimensions,*s_strides=src->strides;
    while(snd>dst->nd && s_dims[0]==1){--snd;++s_dims;++s_strides;}
    if(ln_broadcast_strides(dst->nd,dst->dimensions,snd,s_dims,s_strides,"source",ss,err)<0)goto fail;
    if(where && ln_broadcast_strides(dst->nd,dst->dimensions,where->nd,where->dimensions,where->strides,"where",ms,err)<0)goto fail;
    if(!count || (!where && !scalar_where)){ln_array_free(temporary);return 0;}

    /* Fastest destination axis first. Reverse source/mask coordinates together
     * with every negative destination stride, retaining stable C-order ties. */
    int axes[LN_MAXDIMS],nd=dst->nd;
    ln_intp shape[LN_MAXDIMS]={1},ds[LN_MAXDIMS]={0},s[LN_MAXDIMS]={0},m[LN_MAXDIMS]={0};
    for(int d=0;d<nd;++d)axes[d]=nd-d-1;
    for(int d=1;d<nd;++d) {
        int axis=axes[d],j=d;
        while(j>0 && stride_magnitude(dst->strides[axes[j-1]])>stride_magnitude(dst->strides[axis])) {
            axes[j]=axes[j-1];--j;
        }
        axes[j]=axis;
    }
    char *dp=dst->data;const char *sp=src->data,*mp=where?where->data:NULL;
    for(int d=0;d<nd;++d) {
        int axis=axes[d];shape[d]=dst->dimensions[axis];ds[d]=dst->strides[axis];s[d]=ss[axis];m[d]=ms[axis];
        if(shape[d]==1){ds[d]=s[d]=m[d]=0;}
        if(ds[d]<0) {
            dp+=(shape[d]-1)*ds[d];sp+=(shape[d]-1)*s[d];if(mp)mp+=(shape[d]-1)*m[d];
            ds[d]=-ds[d];s[d]=-s[d];m[d]=-m[d];
        }
    }
    if(!nd)nd=1;
    int k=0;
    for(int d=1;d<nd;++d) {
        if(shape[k]==1){shape[k]=shape[d];ds[k]=ds[d];s[k]=s[d];m[k]=m[d];}
        else if(shape[d]==1)continue;
        else if(ds[k]*shape[k]==ds[d] && s[k]*shape[k]==s[d] && (!mp || m[k]*shape[k]==m[d]))shape[k]*=shape[d];
        else {++k;shape[k]=shape[d];ds[k]=ds[d];s[k]=s[d];m[k]=m[d];}
    }
    nd=k+1;
    int buffered=(src->descr->kind=='S'||src->descr->kind=='U'||dst->descr->kind=='S'||dst->descr->kind=='U') &&
                 (!raw_aligned(src)||!raw_aligned(dst));
    size_t width=dst->descr->elsize;
    if(buffered) {
        size_t capacity=(size_t)(shape[0]<128?shape[0]:128);
        if(width && capacity>SIZE_MAX/width){bad(err,"copyto cast buffer too large");goto fail;}
        buffer=malloc(capacity*(width?width:1));
        if(!buffer){bad(err,"could not allocate copyto cast buffer");goto fail;}
    }
    if(input->nd>0 && nd==1 && (uintptr_t)sp<(uintptr_t)dp && s[0]>0 &&
        (uintptr_t)dp-(uintptr_t)sp<(uintptr_t)shape[0]*(uintptr_t)s[0]) {
        dp+=(shape[0]-1)*ds[0];sp+=(shape[0]-1)*s[0];if(mp)mp+=(shape[0]-1)*m[0];
        ds[0]=-ds[0];s[0]=-s[0];m[0]=-m[0];
    }
    ln_intp coord[LN_MAXDIMS]={0},outer=count/shape[0];
    for(ln_intp row=0;row<outer;++row) {
        ln_intp i=0;
        while(i<shape[0]) {
            if(mp)while(i<shape[0] && !(unsigned char)mp[i*m[0]])++i;
            if(i==shape[0])break;
            ln_intp first=i;
            if(mp)while(i<shape[0] && (unsigned char)mp[i*m[0]])++i;
            else i=shape[0];
            if(!buffered) {
                if(ln_cast_strided_numeric(sp+first*s[0],s[0],src->descr,
                        dp+first*ds[0],ds[0],dst->descr,i-first,err)<0)goto fail;
            }
            else while(first<i) {
                ln_intp block=i-first<128?i-first:128;
                if(ln_cast_strided_numeric(sp+first*s[0],s[0],src->descr,buffer,(ln_intp)width,dst->descr,block,err)<0)goto fail;
                for(ln_intp j=0;j<block;++j)memcpy(dp+(first+j)*ds[0],buffer+(size_t)j*width,width);
                first+=block;
            }
        }
        for(int d=1;d<nd;++d) {
            dp+=ds[d];sp+=s[d];if(mp)mp+=m[d];
            if(++coord[d]<shape[d])break;
            dp-=coord[d]*ds[d];sp-=coord[d]*s[d];if(mp)mp-=coord[d]*m[d];coord[d]=0;
        }
    }
    free(buffer);ln_array_free(temporary);return 0;
fail:
    free(buffer);ln_array_free(temporary);return -1;
}
