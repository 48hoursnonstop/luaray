#include "ln_sort.h"
#include "ln_dtype_transfer.h"
#include "ln_half.h"
#include "ln_complex.h"

#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*
 * Native numeric subset ported from NumPy main:
 *   numpy/_core/src/multiarray/item_selection.c:_new_sortlike/_new_argsortlike
 *   numpy/_core/src/npysort/quicksort_generic.cpp
 *   numpy/_core/src/npysort/heapsort.cpp
 *   numpy/_core/src/npysort/selection.hpp
 *   numpy/_core/src/npysort/selection_methods.cpp
 *   numpy/_core/src/common/numpy_tag.hpp
 *   numpy/_core/src/multiarray/ctors.c:PyArray_NewLikeArrayWithShape(KEEPORDER)
 *   numpy/_core/src/multiarray/shape.c:PyArray_CreateSortedStridePerm
 *
 * CPython/DType-method dispatch is replaced by ln_dtype switches, but the
 * ordering, introsort, introselect, axis buffering, and KEEPORDER layout
 * algorithms are kept structurally equivalent.  Public Lua index arrays are
 * 1-based, so argsort/argpartition add one only at the host-facing result.
 */

#define LN_SMALL_QUICKSORT 15
#define LN_QS_STACK ((int)(sizeof(ln_intp) * 8 * 2))
#define LN_MAX_PIVOT_STACK 50
#define LN_MAX_ITEMSIZE 32

typedef struct ln_stride_item {
    int perm;
    ln_intp stride;
} ln_stride_item;

typedef struct ln_selctx {
    char *v;
    ln_intp *indices; /* non-NULL for indirect selection */
    ln_intp base;
    ln_intp elsize;
    const ln_dtype *dtype;
    int descending;
} ln_selctx;

static void sort_error(ln_error *err, const char *msg)
{
    if (err) snprintf(err->message, sizeof(err->message), "%s", msg ? msg : "sort error");
}

static int valid_axis(const ln_array *a, int axis, ln_error *err)
{
    if (!a) { sort_error(err, "invalid array"); return 0; }
    if (a->nd == 0) {
        sort_error(err, "axis out of bounds for array of dimension 0");
        return 0;
    }
    if (axis < 0) axis += a->nd;
    if (axis < 0 || axis >= a->nd) {
        sort_error(err, "axis out of bounds");
        return 0;
    }
    return 1;
}

static int normalize_axis(const ln_array *a, int axis)
{
    if (a->nd == 0) return 0;
    return axis < 0 ? axis + a->nd : axis;
}

static int highest_bit(ln_intp n)
{
    int k = 0;
    while (n > 1) { n >>= 1; ++k; }
    return k;
}

static int item_less_ascending(const char *ap, const char *bp, const ln_dtype *dt)
{
#define LN_CMP_SCALAR(T) do { T a,b; memcpy(&a,ap,sizeof(T)); memcpy(&b,bp,sizeof(T)); return a < b; } while (0)
    switch (dt->type_num) {
        case LN_BOOL:      LN_CMP_SCALAR(uint8_t);
        case LN_BYTE:      LN_CMP_SCALAR(int8_t);
        case LN_UBYTE:     LN_CMP_SCALAR(uint8_t);
        case LN_SHORT:     LN_CMP_SCALAR(int16_t);
        case LN_USHORT:    LN_CMP_SCALAR(uint16_t);
        case LN_INT:       LN_CMP_SCALAR(int32_t);
        case LN_UINT:      LN_CMP_SCALAR(uint32_t);
        case LN_LONG:      LN_CMP_SCALAR(long);
        case LN_ULONG:     LN_CMP_SCALAR(unsigned long);
        case LN_LONGLONG:  LN_CMP_SCALAR(long long);
        case LN_ULONGLONG: LN_CMP_SCALAR(unsigned long long);
        case LN_HALF: {
            ln_half a,b; memcpy(&a,ap,sizeof(a)); memcpy(&b,bp,sizeof(b));
            return ln_half_lt(a,b) || (ln_half_isnan(b) && !ln_half_isnan(a));
        }
        case LN_FLOAT: {
            float a,b; memcpy(&a,ap,sizeof(a)); memcpy(&b,bp,sizeof(b));
            return a < b || (isnan(b) && !isnan(a));
        }
        case LN_DOUBLE: {
            double a,b; memcpy(&a,ap,sizeof(a)); memcpy(&b,bp,sizeof(b));
            return a < b || (isnan(b) && !isnan(a));
        }
        case LN_LONGDOUBLE: {
            long double a,b; memcpy(&a,ap,sizeof(a)); memcpy(&b,bp,sizeof(b));
            return a < b || (isnan(b) && !isnan(a));
        }
        case LN_CFLOAT: { ln_cfloat a,b; memcpy(&a,ap,sizeof(a));memcpy(&b,bp,sizeof(b));return ln_cfloat_sort_less(a.real,a.imag,b.real,b.imag); }
        case LN_CDOUBLE: { ln_cdouble a,b; memcpy(&a,ap,sizeof(a));memcpy(&b,bp,sizeof(b));return ln_cdouble_sort_less(a.real,a.imag,b.real,b.imag); }
        case LN_CLONGDOUBLE: { ln_clongdouble a,b; memcpy(&a,ap,sizeof(a));memcpy(&b,bp,sizeof(b));return ln_clongdouble_sort_less(a.real,a.imag,b.real,b.imag); }
        default: return 0;
    }
#undef LN_CMP_SCALAR
}

static int item_less(const char *ap, const char *bp, const ln_dtype *dt, int descending)
{
    if (!descending) return item_less_ascending(ap,bp,dt);
    /* numpy_tag.hpp::greater: NaNs remain at the end even in reverse. */
#define LN_CMP_SCALAR(T) do { T a,b; memcpy(&a,ap,sizeof(T)); memcpy(&b,bp,sizeof(T)); return a > b; } while (0)
    switch (dt->type_num) {
        case LN_BOOL:      LN_CMP_SCALAR(uint8_t);
        case LN_BYTE:      LN_CMP_SCALAR(int8_t);
        case LN_UBYTE:     LN_CMP_SCALAR(uint8_t);
        case LN_SHORT:     LN_CMP_SCALAR(int16_t);
        case LN_USHORT:    LN_CMP_SCALAR(uint16_t);
        case LN_INT:       LN_CMP_SCALAR(int32_t);
        case LN_UINT:      LN_CMP_SCALAR(uint32_t);
        case LN_LONG:      LN_CMP_SCALAR(long);
        case LN_ULONG:     LN_CMP_SCALAR(unsigned long);
        case LN_LONGLONG:  LN_CMP_SCALAR(long long);
        case LN_ULONGLONG: LN_CMP_SCALAR(unsigned long long);
        case LN_HALF: {
            ln_half a,b; memcpy(&a,ap,sizeof(a)); memcpy(&b,bp,sizeof(b));
            return ln_half_gt(a,b) || (ln_half_isnan(b) && !ln_half_isnan(a));
        }
        case LN_FLOAT: {
            float a,b; memcpy(&a,ap,sizeof(a)); memcpy(&b,bp,sizeof(b));
            return a > b || (isnan(b) && !isnan(a));
        }
        case LN_DOUBLE: {
            double a,b; memcpy(&a,ap,sizeof(a)); memcpy(&b,bp,sizeof(b));
            return a > b || (isnan(b) && !isnan(a));
        }
        case LN_LONGDOUBLE: {
            long double a,b; memcpy(&a,ap,sizeof(a)); memcpy(&b,bp,sizeof(b));
            return a > b || (isnan(b) && !isnan(a));
        }
        case LN_CFLOAT: { ln_cfloat a,b; memcpy(&a,ap,sizeof(a));memcpy(&b,bp,sizeof(b));return ln_cfloat_sort_greater(a.real,a.imag,b.real,b.imag); }
        case LN_CDOUBLE: { ln_cdouble a,b; memcpy(&a,ap,sizeof(a));memcpy(&b,bp,sizeof(b));return ln_cdouble_sort_greater(a.real,a.imag,b.real,b.imag); }
        case LN_CLONGDOUBLE: { ln_clongdouble a,b; memcpy(&a,ap,sizeof(a));memcpy(&b,bp,sizeof(b));return ln_clongdouble_sort_greater(a.real,a.imag,b.real,b.imag); }
        default: return 0;
    }
#undef LN_CMP_SCALAR
}

static void swap_bytes(char *a, char *b, size_t n)
{
    while (n--) { char t=*a; *a++=*b; *b++=t; }
}

static int heapsort_values(char *start, ln_intp num, const ln_dtype *dt, int descending)
{
    ln_intp es=(ln_intp)dt->elsize;
    unsigned char tmp[LN_MAX_ITEMSIZE];
    if (dt->elsize > sizeof(tmp)) return -1;
    if (num <= 1) return 0;
    char *a=start-es; /* source algorithm uses 1-based heap indexing */
    ln_intp i,j,l;
    for (l=num>>1;l>0;--l) {
        memcpy(tmp,a+l*es,(size_t)es);
        for (i=l,j=l<<1;j<=num;) {
            if (j<num && item_less(a+j*es,a+(j+1)*es,dt,descending)) ++j;
            if (item_less((char*)tmp,a+j*es,dt,descending)) {
                memcpy(a+i*es,a+j*es,(size_t)es); i=j; j+=j;
            } else break;
        }
        memcpy(a+i*es,tmp,(size_t)es);
    }
    for (;num>1;) {
        memcpy(tmp,a+num*es,(size_t)es);
        memcpy(a+num*es,a+es,(size_t)es);
        --num;
        for (i=1,j=2;j<=num;) {
            if (j<num && item_less(a+j*es,a+(j+1)*es,dt,descending)) ++j;
            if (item_less((char*)tmp,a+j*es,dt,descending)) {
                memcpy(a+i*es,a+j*es,(size_t)es); i=j; j+=j;
            } else break;
        }
        memcpy(a+i*es,tmp,(size_t)es);
    }
    return 0;
}

static int heapsort_indices(const char *v, ln_intp *tosort, ln_intp n,
                            const ln_dtype *dt, int descending)
{
    ln_intp es=(ln_intp)dt->elsize;
    ln_intp *a=tosort-1,i,j,l,tmp;
    for (l=n>>1;l>0;--l) {
        tmp=a[l];
        for (i=l,j=l<<1;j<=n;) {
            if (j<n && item_less(v+a[j]*es,v+a[j+1]*es,dt,descending)) ++j;
            if (item_less(v+tmp*es,v+a[j]*es,dt,descending)) { a[i]=a[j]; i=j; j+=j; }
            else break;
        }
        a[i]=tmp;
    }
    for (;n>1;) {
        tmp=a[n]; a[n]=a[1]; --n;
        for (i=1,j=2;j<=n;) {
            if (j<n && item_less(v+a[j]*es,v+a[j+1]*es,dt,descending)) ++j;
            if (item_less(v+tmp*es,v+a[j]*es,dt,descending)) { a[i]=a[j]; i=j; j+=j; }
            else break;
        }
        a[i]=tmp;
    }
    return 0;
}

static int quicksort_values(char *start, ln_intp num, const ln_dtype *dt, int descending)
{
    if (num <= 1) return 0;
    ln_intp es=(ln_intp)dt->elsize;
    char *pl=start,*pr=pl+(num-1)*es;
    char *stack[LN_QS_STACK],**sptr=stack,*pm,*pi,*pj,*pk;
    int depth[LN_QS_STACK],*psdepth=depth,cdepth=highest_bit(num)*2;
    unsigned char vp[LN_MAX_ITEMSIZE];
    if (dt->elsize > sizeof(vp)) return -1;
    for (;;) {
        if (cdepth < 0) { if (heapsort_values(pl,(pr-pl)/es+1,dt,descending)<0) return -1; goto stack_pop; }
        while (pr-pl > LN_SMALL_QUICKSORT*es) {
            pm=pl+(((pr-pl)/es)>>1)*es;
            if (item_less(pm,pl,dt,descending)) swap_bytes(pm,pl,(size_t)es);
            if (item_less(pr,pm,dt,descending)) swap_bytes(pr,pm,(size_t)es);
            if (item_less(pm,pl,dt,descending)) swap_bytes(pm,pl,(size_t)es);
            memcpy(vp,pm,(size_t)es); pi=pl; pj=pr-es; swap_bytes(pm,pj,(size_t)es);
            for (;;) {
                do { pi+=es; } while (item_less(pi,(char*)vp,dt,descending) && pi<pj);
                do { pj-=es; } while (item_less((char*)vp,pj,dt,descending) && pi<pj);
                if (pi>=pj) break;
                swap_bytes(pi,pj,(size_t)es);
            }
            pk=pr-es; swap_bytes(pi,pk,(size_t)es);
            if (pi-pl < pr-pi) { *sptr++=pi+es; *sptr++=pr; pr=pi-es; }
            else { *sptr++=pl; *sptr++=pi-es; pl=pi+es; }
            *psdepth++=--cdepth;
        }
        for (pi=pl+es;pi<=pr;pi+=es) {
            memcpy(vp,pi,(size_t)es); pj=pi; pk=pi-es;
            while (pj>pl && item_less((char*)vp,pk,dt,descending)) {
                memcpy(pj,pk,(size_t)es); pj-=es; pk-=es;
            }
            memcpy(pj,vp,(size_t)es);
        }
stack_pop:
        if (sptr==stack) break;
        pr=*(--sptr); pl=*(--sptr); cdepth=*(--psdepth);
    }
    return 0;
}

static int quicksort_indices(const char *v, ln_intp *idx, ln_intp num,
                             const ln_dtype *dt, int descending)
{
    if (num <= 1) return 0;
    ln_intp es=(ln_intp)dt->elsize;
    ln_intp *pl=idx,*pr=idx+num-1,*stack[LN_QS_STACK],**sptr=stack,*pm,*pi,*pj,*pk,vi;
    int depth[LN_QS_STACK],*psdepth=depth,cdepth=highest_bit(num)*2;
    for (;;) {
        if (cdepth < 0) { if (heapsort_indices(v,pl,pr-pl+1,dt,descending)<0) return -1; goto stack_pop; }
        while (pr-pl > LN_SMALL_QUICKSORT) {
            pm=pl+((pr-pl)>>1);
            if (item_less(v+(*pm)*es,v+(*pl)*es,dt,descending)) { ln_intp t=*pm;*pm=*pl;*pl=t; }
            if (item_less(v+(*pr)*es,v+(*pm)*es,dt,descending)) { ln_intp t=*pr;*pr=*pm;*pm=t; }
            if (item_less(v+(*pm)*es,v+(*pl)*es,dt,descending)) { ln_intp t=*pm;*pm=*pl;*pl=t; }
            vi=*pm; pi=pl; pj=pr-1; {ln_intp t=*pm;*pm=*pj;*pj=t;}
            for (;;) {
                do { ++pi; } while (item_less(v+(*pi)*es,v+vi*es,dt,descending) && pi<pj);
                do { --pj; } while (item_less(v+vi*es,v+(*pj)*es,dt,descending) && pi<pj);
                if (pi>=pj) break;
                {ln_intp t=*pi;*pi=*pj;*pj=t;}
            }
            pk=pr-1; {ln_intp t=*pi;*pi=*pk;*pk=t;}
            if (pi-pl < pr-pi) { *sptr++=pi+1; *sptr++=pr; pr=pi-1; }
            else { *sptr++=pl; *sptr++=pi-1; pl=pi+1; }
            *psdepth++=--cdepth;
        }
        for (pi=pl+1;pi<=pr;++pi) {
            vi=*pi; pj=pi; pk=pi-1;
            while (pj>pl && item_less(v+vi*es,v+(*pk)*es,dt,descending)) *pj--=*pk--;
            *pj=vi;
        }
stack_pop:
        if (sptr==stack) break;
        pr=*(--sptr); pl=*(--sptr); cdepth=*(--psdepth);
    }
    return 0;
}

static int stride_item_cmp(const void *aa,const void *bb)
{
    const ln_stride_item *a=(const ln_stride_item*)aa,*b=(const ln_stride_item*)bb;
    ln_intp as=a->stride<0?-a->stride:a->stride, bs=b->stride<0?-b->stride:b->stride;
    if (as==bs) return a->perm<b->perm?-1:1;
    return as>bs?-1:1;
}

static void advance_coord_skip(int nd,const ln_intp *shape,int skip,ln_intp *coord)
{
    for (int d=nd-1;d>=0;--d) {
        if (d==skip) continue;
        coord[d]++;
        if (coord[d]<shape[d]) return;
        coord[d]=0;
    }
}

static char *coord_ptr_skip(const ln_array *a,const ln_intp *coord,int skip)
{
    char *p=a->data;
    for (int d=0;d<a->nd;++d) if (d!=skip) p += coord[d]*a->strides[d];
    return p;
}

static ln_intp outer_count(const ln_array *a,int axis)
{
    ln_intp n=1;
    for (int d=0;d<a->nd;++d) if (d!=axis) n*=a->dimensions[d];
    return n;
}

static ln_array *copy_keeporder(const ln_array *src, ln_error *err)
{
    if (src->nd<=1 || (src->flags & LN_ARRAY_C_CONTIGUOUS)) {
        ln_array *out=ln_array_new(src->nd,src->dimensions,src->descr,0,0,err);
        if (!out) return NULL;
        ln_intp n=ln_array_size(src),coord[LN_MAXDIMS]={0};
        for (ln_intp i=0;i<n;++i) {
            char *sp=src->data,*dp=out->data;
            for (int d=0;d<src->nd;++d) { sp+=coord[d]*src->strides[d]; dp+=coord[d]*out->strides[d]; }
            memcpy(dp,sp,src->descr->elsize);
            for (int d=src->nd-1;d>=0;--d){ if(++coord[d]<src->dimensions[d])break;coord[d]=0; }
        }
        return out;
    }
    if (src->flags & LN_ARRAY_F_CONTIGUOUS) {
        ln_array *out=ln_array_new(src->nd,src->dimensions,src->descr,1,0,err);
        if (!out) return NULL;
        ln_intp n=ln_array_size(src),coord[LN_MAXDIMS]={0};
        for (ln_intp i=0;i<n;++i) {
            char *sp=src->data,*dp=out->data;
            for (int d=0;d<src->nd;++d){sp+=coord[d]*src->strides[d];dp+=coord[d]*out->strides[d];}
            memcpy(dp,sp,src->descr->elsize);
            for (int d=src->nd-1;d>=0;--d){if(++coord[d]<src->dimensions[d])break;coord[d]=0;}
        }
        return out;
    }
    ln_array *out=ln_array_new(src->nd,src->dimensions,src->descr,0,0,err);
    if (!out) return NULL;
    ln_stride_item perm[LN_MAXDIMS];
    for (int d=0;d<src->nd;++d){perm[d].perm=d;perm[d].stride=src->strides[d];}
    qsort(perm,(size_t)src->nd,sizeof(perm[0]),stride_item_cmp);
    ln_intp stride=(ln_intp)src->descr->elsize;
    for (int i=src->nd-1;i>=0;--i){int d=perm[i].perm;out->strides[d]=stride;stride*=src->dimensions[d];}
    ln_update_contiguous_flags(out);
    ln_intp n=ln_array_size(src),coord[LN_MAXDIMS]={0};
    for (ln_intp i=0;i<n;++i) {
        char *sp=src->data,*dp=out->data;
        for (int d=0;d<src->nd;++d){sp+=coord[d]*src->strides[d];dp+=coord[d]*out->strides[d];}
        memcpy(dp,sp,src->descr->elsize);
        for (int d=src->nd-1;d>=0;--d){if(++coord[d]<src->dimensions[d])break;coord[d]=0;}
    }
    return out;
}

int ln_sort_inplace(ln_array *a,int axis,int descending,ln_error *err)
{
    if (!valid_axis(a,axis,err)) return -1;
    if (!(a->flags & LN_ARRAY_WRITEABLE)) { sort_error(err,"sort array is read-only"); return -1; }
    axis=normalize_axis(a,axis);
    if (a->nd==0 || ln_array_size(a)==0 || a->dimensions[axis]<=1) return 0;
    ln_intp n=a->dimensions[axis],astride=a->strides[axis],es=(ln_intp)a->descr->elsize;
    char *buffer=NULL;
    if (astride!=es) { buffer=(char*)malloc((size_t)n*(size_t)es); if(!buffer){sort_error(err,"out of memory during sorting");return -1;} }
    ln_intp coord[LN_MAXDIMS]={0},outer=outer_count(a,axis);
    for (ln_intp row=0;row<outer;++row) {
        char *base=coord_ptr_skip(a,coord,axis),*p=base;
        if (buffer) { for(ln_intp i=0;i<n;++i)memcpy(buffer+i*es,base+i*astride,(size_t)es); p=buffer; }
        if (quicksort_values(p,n,a->descr,descending)<0){free(buffer);sort_error(err,"sort failed");return -1;}
        if (buffer) for(ln_intp i=0;i<n;++i)memcpy(base+i*astride,buffer+i*es,(size_t)es);
        advance_coord_skip(a->nd,a->dimensions,axis,coord);
    }
    free(buffer); return 0;
}

ln_array *ln_sort_copy(const ln_array *a,int axis,int descending,ln_error *err)
{
    if (!valid_axis(a,axis,err)) return NULL;
    ln_array *out=copy_keeporder(a,err); if(!out)return NULL;
    if (ln_sort_inplace(out,axis,descending,err)<0){ln_array_free(out);return NULL;}
    return out;
}

static const ln_dtype *intp_dtype(void)
{
    if (sizeof(ln_intp)==sizeof(long)) return ln_dtype_by_num(LN_LONG);
    return ln_dtype_by_num(LN_LONGLONG);
}

ln_array *ln_argsort(const ln_array *a,int axis,int descending,ln_error *err)
{
    if (!a) { sort_error(err,"invalid array"); return NULL; }
    if (a->nd==0) {
        if (!(axis==0 || axis==-1)) { sort_error(err,"axis out of bounds for array of dimension 1"); return NULL; }
        ln_intp one=1;
        ln_array *out=ln_array_new(1,&one,intp_dtype(),0,0,err);
        if (!out) return NULL;
        ln_intp public_idx=1;
        memcpy(out->data,&public_idx,sizeof(public_idx));
        return out;
    }
    if (!valid_axis(a,axis,err)) return NULL;
    axis=normalize_axis(a,axis);
    ln_array *out=ln_array_new(a->nd,a->dimensions,intp_dtype(),0,0,err); if(!out)return NULL;
    ln_intp n=a->dimensions[axis],es=(ln_intp)a->descr->elsize,astride=a->strides[axis];
    if (n==0) return out;
    char *values=(char*)malloc((size_t)n*(size_t)es); ln_intp *idx=(ln_intp*)malloc((size_t)n*sizeof(*idx));
    if(!values||!idx){free(values);free(idx);ln_array_free(out);sort_error(err,"out of memory during argsort");return NULL;}
    ln_intp coord[LN_MAXDIMS]={0},outer=outer_count(a,axis);
    for(ln_intp row=0;row<outer;++row){
        char *base=coord_ptr_skip(a,coord,axis),*obase=coord_ptr_skip(out,coord,axis);
        for(ln_intp i=0;i<n;++i){memcpy(values+i*es,base+i*astride,(size_t)es);idx[i]=i;}
        if(quicksort_indices(values,idx,n,a->descr,descending)<0){free(values);free(idx);ln_array_free(out);sort_error(err,"argsort failed");return NULL;}
        for(ln_intp i=0;i<n;++i){ln_intp public_idx=idx[i]+1;memcpy(obase+i*out->strides[axis],&public_idx,sizeof(public_idx));}
        advance_coord_skip(a->nd,a->dimensions,axis,coord);
    }
    free(values);free(idx);return out;
}

/* ----- introselect port ----- */
static char *sel_value(const ln_selctx *c,ln_intp pos)
{
    ln_intp slot=c->base+pos;
    ln_intp vi=c->indices?c->indices[slot]:slot;
    return c->v+vi*c->elsize;
}
static void sel_swap(const ln_selctx *c,ln_intp a,ln_intp b)
{
    a+=c->base;b+=c->base;
    if(c->indices){ln_intp t=c->indices[a];c->indices[a]=c->indices[b];c->indices[b]=t;}
    else swap_bytes(c->v+a*c->elsize,c->v+b*c->elsize,(size_t)c->elsize);
}
static ln_selctx sel_sub(const ln_selctx *c,ln_intp offset){ln_selctx r=*c;r.base+=offset;return r;}
static int sel_less(const ln_selctx *c,const char *a,const char *b){return item_less(a,b,c->dtype,c->descending);}

static void store_pivot(ln_intp pivot,ln_intp kth,ln_intp *pivots,ln_intp *npiv)
{
    if(!pivots)return;
    if(pivot==kth && *npiv==LN_MAX_PIVOT_STACK)pivots[*npiv-1]=pivot;
    else if(pivot>=kth && *npiv<LN_MAX_PIVOT_STACK)pivots[(*npiv)++]=pivot;
}

static void median3_swap(const ln_selctx*c,ln_intp low,ln_intp mid,ln_intp high)
{
    if(sel_less(c,sel_value(c,high),sel_value(c,mid)))sel_swap(c,high,mid);
    if(sel_less(c,sel_value(c,high),sel_value(c,low)))sel_swap(c,high,low);
    if(sel_less(c,sel_value(c,low),sel_value(c,mid)))sel_swap(c,low,mid);
    sel_swap(c,mid,low+1);
}

static ln_intp median5(const ln_selctx*c)
{
    if(sel_less(c,sel_value(c,1),sel_value(c,0)))sel_swap(c,1,0);
    if(sel_less(c,sel_value(c,4),sel_value(c,3)))sel_swap(c,4,3);
    if(sel_less(c,sel_value(c,3),sel_value(c,0)))sel_swap(c,3,0);
    if(sel_less(c,sel_value(c,4),sel_value(c,1)))sel_swap(c,4,1);
    if(sel_less(c,sel_value(c,2),sel_value(c,1)))sel_swap(c,2,1);
    if(sel_less(c,sel_value(c,3),sel_value(c,2))) return sel_less(c,sel_value(c,3),sel_value(c,1))?1:3;
    return 2;
}

static void unguarded_partition(const ln_selctx*c,const unsigned char*pivot,ln_intp*ll,ln_intp*hh)
{
    for(;;){
        do{(*ll)++;}while(sel_less(c,sel_value(c,*ll),(const char*)pivot));
        do{(*hh)--;}while(sel_less(c,(const char*)pivot,sel_value(c,*hh)));
        if(*hh<*ll)break;
        sel_swap(c,*ll,*hh);
    }
}

static int introselect(const ln_selctx*c,ln_intp num,ln_intp kth,ln_intp*pivots,ln_intp*npiv);

static ln_intp median_of_median5(const ln_selctx*c,ln_intp num)
{
    ln_intp right=num-1,nmed=(right+1)/5;
    for(ln_intp i=0,sub=0;i<nmed;++i,sub+=5){ln_selctx sc=sel_sub(c,sub);ln_intp m=median5(&sc);sel_swap(c,sub+m,i);}
    if(nmed>2)introselect(c,nmed,nmed/2,NULL,NULL);
    return nmed/2;
}

static int dumb_select(const ln_selctx*c,ln_intp num,ln_intp kth)
{
    for(ln_intp i=0;i<=kth;++i){ln_intp minidx=i;for(ln_intp k=i+1;k<num;++k)if(sel_less(c,sel_value(c,k),sel_value(c,minidx)))minidx=k;sel_swap(c,i,minidx);}return 0;
}

static int dtype_inexact(const ln_dtype*dt){return dt->kind=='f';}

static int introselect(const ln_selctx*c,ln_intp num,ln_intp kth,ln_intp*pivots,ln_intp*npiv)
{
    ln_intp low=0,high=num-1;
    if(npiv==NULL)pivots=NULL;
    while(pivots&&*npiv>0){
        if(pivots[*npiv-1]>kth){high=pivots[*npiv-1]-1;break;}
        else if(pivots[*npiv-1]==kth)return 0;
        low=pivots[*npiv-1]+1;--(*npiv);
    }
    if(kth-low<3){ln_selctx sc=sel_sub(c,low);dumb_select(&sc,high-low+1,kth-low);store_pivot(kth,kth,pivots,npiv);return 0;}
    else if(dtype_inexact(c->dtype)&&kth==num-1){
        ln_intp maxidx=low;
        for(ln_intp k=low+1;k<num;++k)if(!sel_less(c,sel_value(c,k),sel_value(c,maxidx)))maxidx=k;
        sel_swap(c,kth,maxidx);return 0;
    }
    int depth_limit=highest_bit(num)*2;
    for(;low+1<high;){
        ln_intp ll=low+1,hh=high;
        if(depth_limit>0||hh-ll<5){ln_intp mid=low+(high-low)/2;median3_swap(c,low,mid,high);}
        else{ln_selctx sc=sel_sub(c,ll);ln_intp mid=ll+median_of_median5(&sc,hh-ll);sel_swap(c,mid,low);--ll;++hh;}
        --depth_limit;
        unsigned char pivot[LN_MAX_ITEMSIZE]; if(c->dtype->elsize>sizeof(pivot))return -1; memcpy(pivot,sel_value(c,low),c->dtype->elsize);
        unguarded_partition(c,pivot,&ll,&hh); sel_swap(c,low,hh);
        if(hh!=kth)store_pivot(hh,kth,pivots,npiv);
        if(hh>=kth)high=hh-1;
        if(hh<=kth)low=ll;
    }
    if(high==low+1&&sel_less(c,sel_value(c,high),sel_value(c,low)))sel_swap(c,high,low);
    store_pivot(kth,kth,pivots,npiv);return 0;
}

static int partition_contiguous(char *values,ln_intp *indices,ln_intp n,
                                const ln_intp*kth,ln_intp nkth,
                                const ln_dtype*dt,int descending)
{
    ln_selctx c={values,indices,0,(ln_intp)dt->elsize,dt,descending};
    ln_intp pivots[LN_MAX_PIVOT_STACK],npiv=0;
    for(ln_intp i=0;i<nkth;++i)if(introselect(&c,n,kth[i],pivots,&npiv)<0)return -1;
    return 0;
}

int ln_partition_inplace(ln_array*a,const ln_intp*kth,ln_intp nkth,int axis,int descending,ln_error*err)
{
    if(!valid_axis(a,axis,err))return -1;
    if(!(a->flags&LN_ARRAY_WRITEABLE)){sort_error(err,"partition array is read-only");return -1;}
    axis=normalize_axis(a,axis);if(a->nd==0){sort_error(err,"partition axis is invalid for a 0-D array");return -1;}
    ln_intp n=a->dimensions[axis];
    for(ln_intp k=0;k<nkth;++k)if(kth[k]<0||kth[k]>=n){sort_error(err,"kth out of bounds");return -1;}
    if(n<=1||nkth==0||ln_array_size(a)==0)return 0;
    ln_intp es=(ln_intp)a->descr->elsize,astride=a->strides[axis];char*buffer=NULL;
    if(astride!=es){buffer=(char*)malloc((size_t)n*(size_t)es);if(!buffer){sort_error(err,"out of memory during partition");return -1;}}
    ln_intp coord[LN_MAXDIMS]={0},outer=outer_count(a,axis);
    for(ln_intp row=0;row<outer;++row){char*base=coord_ptr_skip(a,coord,axis),*p=base;if(buffer){for(ln_intp i=0;i<n;++i)memcpy(buffer+i*es,base+i*astride,(size_t)es);p=buffer;}
        if(partition_contiguous(p,NULL,n,kth,nkth,a->descr,descending)<0){free(buffer);sort_error(err,"partition failed");return -1;}
        if (buffer) {
            for (ln_intp i=0;i<n;++i) memcpy(base+i*astride,buffer+i*es,(size_t)es);
        }
        advance_coord_skip(a->nd,a->dimensions,axis,coord);
    }
    free(buffer);return 0;
}

ln_array *ln_partition_copy(const ln_array*a,const ln_intp*kth,ln_intp nkth,int axis,int descending,ln_error*err)
{
    if (!valid_axis(a,axis,err)) return NULL;
    ln_array *out=copy_keeporder(a,err);
    if (!out) return NULL;
    if (ln_partition_inplace(out,kth,nkth,axis,descending,err)<0) {
        ln_array_free(out);
        return NULL;
    }
    return out;
}

ln_array *ln_argpartition(const ln_array*a,const ln_intp*kth,ln_intp nkth,int axis,int descending,ln_error*err)
{
    if (!a) { sort_error(err,"invalid array"); return NULL; }
    if (a->nd==0) {
        if (!(axis==0 || axis==-1)) { sort_error(err,"axis out of bounds for array of dimension 1"); return NULL; }
        ln_intp one=1;
        ln_array *out=ln_array_new(1,&one,intp_dtype(),0,0,err);
        if (!out) return NULL;
        ln_intp public_idx=1;
        memcpy(out->data,&public_idx,sizeof(public_idx));
        return out;
    }
    if(!valid_axis(a,axis,err))return NULL;
    axis=normalize_axis(a,axis);
    ln_intp n=a->dimensions[axis];for(ln_intp k=0;k<nkth;++k)if(kth[k]<0||kth[k]>=n){sort_error(err,"kth out of bounds");return NULL;}
    ln_array*out=ln_array_new(a->nd,a->dimensions,intp_dtype(),0,0,err);if(!out)return NULL;if(n==0||nkth==0)return out;
    ln_intp es=(ln_intp)a->descr->elsize,astride=a->strides[axis];char*values=(char*)malloc((size_t)n*(size_t)es);ln_intp*idx=(ln_intp*)malloc((size_t)n*sizeof(*idx));
    if(!values||!idx){free(values);free(idx);ln_array_free(out);sort_error(err,"out of memory during argpartition");return NULL;}
    ln_intp coord[LN_MAXDIMS]={0},outer=outer_count(a,axis);
    for(ln_intp row=0;row<outer;++row){char*base=coord_ptr_skip(a,coord,axis),*obase=coord_ptr_skip(out,coord,axis);for(ln_intp i=0;i<n;++i){memcpy(values+i*es,base+i*astride,(size_t)es);idx[i]=i;}
        if(partition_contiguous(values,idx,n,kth,nkth,a->descr,descending)<0){free(values);free(idx);ln_array_free(out);sort_error(err,"argpartition failed");return NULL;}
        for(ln_intp i=0;i<n;++i){ln_intp public_idx=idx[i]+1;memcpy(obase+i*out->strides[axis],&public_idx,sizeof(public_idx));}advance_coord_skip(a->nd,a->dimensions,axis,coord);}
    free(values);free(idx);return out;
}


/* ----- searchsorted port -----
 * Source subset:
 *   item_selection.c:PyArray_SearchSorted
 *   npysort/binsearch.cpp:binsearch/argbinsearch
 * Numeric builtin dtypes only.  CPython conversion is performed by the Lua
 * binding; here we retain dtype promotion/casting, 1-D validation, batched
 * binary search and optional sorter semantics. */
static const char *
flat_c_ptr_sort(const ln_array *a, ln_intp flat)
{
    const char *p = a->data;
    for (int d=a->nd-1; d>=0; --d) {
        ln_intp dim=a->dimensions[d];
        ln_intp q=dim ? flat % dim : 0;
        flat=dim ? flat / dim : 0;
        p += q*a->strides[d];
    }
    return p;
}

static int
copy_cast_c_sort(const ln_array *src, ln_array *dst, ln_error *err)
{
    if (!src || !dst || src->nd != dst->nd) {
        sort_error(err,"invalid searchsorted cast"); return -1;
    }
    for (int d=0; d<src->nd; ++d) {
        if (src->dimensions[d] != dst->dimensions[d]) {
            sort_error(err,"searchsorted cast shape mismatch"); return -1;
        }
    }
    ln_intp total=ln_array_size(src);
    for (ln_intp i=0; i<total; ++i) {
        const char *sp=flat_c_ptr_sort(src,i);
        char *dp=dst->data+i*(ln_intp)dst->descr->elsize;
        if (ln_cast_strided_numeric(sp,0,src->descr,dp,0,dst->descr,1,err)<0) return -1;
    }
    return 0;
}

static int
item_less_equal_ascending(const char *ap, const char *bp, const ln_dtype *dt)
{
    /* numpy_tag.hpp: less_equal(a,b) == !less(b,a), including NaN ordering. */
    return !item_less_ascending(bp,ap,dt);
}

ln_array *
ln_searchsorted(const ln_array *a, const ln_array *keys, int side_right,
                const ln_intp *sorter, ln_intp sorter_len, ln_error *err)
{
    if (!a || !keys) { sort_error(err,"invalid searchsorted operand"); return NULL; }
    if (a->nd != 1) {
        sort_error(err,"object too deep for desired array");
        return NULL;
    }
    const ln_dtype *dt=ln_promote_dtype(a->descr,keys->descr);
    if (!dt) { sort_error(err,"compare not supported for type"); return NULL; }

    ln_array *owned_a=NULL,*owned_k=NULL;
    const ln_array *ha=a,*ka=keys;
    ln_intp nkeys=ln_array_size(keys),n=a->dimensions[0];

    /* PyArray_SearchSorted always makes needles C-contiguous in common dtype. */
    int keys_c = (keys->flags & LN_ARRAY_C_CONTIGUOUS) && keys->descr->type_num==dt->type_num;
    if (!keys_c) {
        owned_k=ln_array_new(keys->nd,keys->nd?keys->dimensions:NULL,dt,0,0,err);
        if (!owned_k) goto fail;
        if (copy_cast_c_sort(keys,owned_k,err)<0) goto fail;
        ka=owned_k;
    }

    /* Haystack must use common dtype.  Match upstream's cache heuristic: when
     * needles outnumber haystack values, materialize a C-contiguous haystack. */
    int need_a_cast=a->descr->type_num!=dt->type_num;
    int need_a_contig=nkeys>n && (!(a->flags & LN_ARRAY_C_CONTIGUOUS) || a->strides[0]!=(ln_intp)a->descr->elsize);
    if (need_a_cast || need_a_contig) {
        ln_intp sh=n;
        owned_a=ln_array_new(1,&sh,dt,0,0,err);
        if (!owned_a) goto fail;
        if (copy_cast_c_sort(a,owned_a,err)<0) goto fail;
        ha=owned_a;
    }

    if (sorter && sorter_len != n) {
        sort_error(err,"sorter.size must equal a.size"); goto fail;
    }

    ln_array *out=ln_array_new(keys->nd,keys->nd?keys->dimensions:NULL,intp_dtype(),0,0,err);
    if (!out) goto fail;
    ln_intp arr_stride=ha->strides[0];
    ln_intp key_stride=(ln_intp)ka->descr->elsize;
    for (ln_intp j=0; j<nkeys; ++j) {
        const char *key=ka->data+j*key_stride;
        ln_intp lo=0,hi=n;
        while (lo<hi) {
            ln_intp mid=lo+((hi-lo)>>1);
            ln_intp ai=mid;
            if (sorter) {
                ai=sorter[mid];
                if (ai<0 || ai>=n) {
                    ln_array_free(out);
                    sort_error(err,"Sorter index out of range.");
                    goto fail;
                }
            }
            const char *v=ha->data+ai*arr_stride;
            int before = side_right ? item_less_equal_ascending(v,key,dt)
                                    : item_less_ascending(v,key,dt);
            if (before) lo=mid+1;
            else hi=mid;
        }
        ln_intp public_pos=lo+1; /* Lua insertion positions: 1 .. n+1 */
        memcpy(out->data+j*(ln_intp)sizeof(ln_intp),&public_pos,sizeof(public_pos));
    }
    ln_array_free(owned_a); ln_array_free(owned_k);
    return out;
fail:
    ln_array_free(owned_a); ln_array_free(owned_k);
    return NULL;
}
