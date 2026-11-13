#include "ln_string.h"
#include "ln_dtype_transfer.h"

#include <ctype.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Source-derived from NumPy's legacy flexible dtype machinery:
 *   multiarray/descriptor.c
 *   multiarray/dtypemeta.c
 *   multiarray/legacy_dtype_implementation.c
 *   multiarray/convert_datatype.c
 *   multiarray/dtype_transfer.c
 * and UCS4 scalar handling in arraytypes.c.src.
 *
 * We keep fixed-width bytes as raw bytes and fixed-width Unicode as UCS4,
 * matching NumPy's NPY_STRING/NPY_UNICODE in-memory model. */

typedef struct ln_string_descr_node {
    ln_dtype_descr descr;
    char name[48];
    struct ln_string_descr_node *next;
} ln_string_descr_node;

static ln_string_descr_node *descr_cache = NULL;
static int ready = 0;
static ln_dtype_class bytes_cls, unicode_cls;
static ln_dtype_descr bytes0, unicode0;

static void serr(ln_error *err, const char *msg) {
    if (err) snprintf(err->message, sizeof(err->message), "%s", msg);
}

static uint32_t bswap32u(uint32_t x) {
    return ((x & 0x000000ffu) << 24) | ((x & 0x0000ff00u) << 8) |
           ((x & 0x00ff0000u) >> 8) | ((x & 0xff000000u) >> 24);
}
static int host_little(void) { const uint16_t x=1; return *(const uint8_t *)&x; }
static uint32_t load_u32(const char *p, char bo) {
    uint32_t v; memcpy(&v,p,4);
    if ((bo=='>' && host_little()) || (bo=='<' && !host_little())) v=bswap32u(v);
    return v;
}
static void store_u32(char *p, uint32_t v, char bo) {
    if ((bo=='>' && host_little()) || (bo=='<' && !host_little())) v=bswap32u(v);
    memcpy(p,&v,4);
}

static const ln_dtype_descr *str_default(const ln_dtype_class *cls);
static const ln_dtype_class *str_common_dtype(const ln_dtype_class *self,
                                               const ln_dtype_class *other);
static const ln_dtype_descr *str_common_instance(const ln_dtype_descr *a,
                                                  const ln_dtype_descr *b);
static const ln_dtype_class_slots str_slots = {
    str_default, str_common_dtype, str_common_instance
};

static void init_classes(void) {
    if (ready) return;
    memset(&bytes_cls,0,sizeof(bytes_cls)); memset(&unicode_cls,0,sizeof(unicode_cls));
    memset(&bytes0,0,sizeof(bytes0)); memset(&unicode0,0,sizeof(unicode0));
    bytes_cls.name="bytes_"; bytes_cls.kind='S'; bytes_cls.legacy_type_num=LN_STRING;
    bytes_cls.flags=LN_DTYPE_CLASS_PARAMETRIC; bytes_cls.slots=&str_slots; bytes_cls.singleton=&bytes0;
    unicode_cls.name="str_"; unicode_cls.kind='U'; unicode_cls.legacy_type_num=LN_UNICODE;
    unicode_cls.flags=LN_DTYPE_CLASS_PARAMETRIC; unicode_cls.slots=&str_slots; unicode_cls.singleton=&unicode0;
    bytes0.cls=&bytes_cls; bytes0.type_num=LN_STRING; bytes0.name="|S0"; bytes0.kind='S';
    bytes0.byteorder='|'; bytes0.elsize=0; bytes0.alignment=1;
    unicode0.cls=&unicode_cls; unicode0.type_num=LN_UNICODE; unicode0.name="<U0"; unicode0.kind='U';
    unicode0.byteorder=host_little()?'<':'>'; unicode0.flags=LN_DTYPE_NEEDS_INIT; unicode0.elsize=0; unicode0.alignment=4;
    ready=1;
}

const ln_dtype_descr *ln_string_default_dtype(int unicode_kind) {
    init_classes(); return unicode_kind?&unicode0:&bytes0;
}

int ln_string_is_dtype(const ln_dtype_descr *dt) {
    return dt && (dt->type_num==LN_STRING || dt->type_num==LN_UNICODE);
}
size_t ln_string_nchars(const ln_dtype_descr *dt) {
    if (!dt) return 0;
    return dt->type_num==LN_UNICODE ? dt->elsize/4 : dt->elsize;
}

static const ln_dtype_descr *str_default(const ln_dtype_class *cls) {
    init_classes(); return cls==&unicode_cls?&unicode0:&bytes0;
}
static const ln_dtype_class *str_common_dtype(const ln_dtype_class *self,
                                               const ln_dtype_class *other) {
    init_classes();
    /* NumPy's legacy flexible DType promotion converts numeric classes to
     * a fixed-width text descriptor.  Temporal and custom DTypes are not
     * numeric: their promotion is deliberately left to their own slots. */
    int numeric = (other->flags & LN_DTYPE_CLASS_LEGACY_NUMERIC) != 0;
    if (self==&unicode_cls) {
        if (other==&unicode_cls || other==&bytes_cls || numeric) return &unicode_cls;
        return NULL;
    }
    if (self==&bytes_cls) {
        if (other==&unicode_cls) return &unicode_cls;
        if (other==&bytes_cls || numeric) return &bytes_cls;
        return NULL;
    }
    return NULL;
}

const ln_dtype_descr *ln_string_make_dtype(int unicode_kind, size_t nchars,
                                            char byteorder, ln_error *err) {
    init_classes();
    if (unicode_kind) {
        if (nchars > (size_t)INT_MAX/4u) { serr(err,"string size is too large"); return NULL; }
        if (byteorder=='=' || byteorder==0) byteorder=host_little()?'<':'>';
        if (byteorder!='<' && byteorder!='>') { serr(err,"invalid unicode byteorder"); return NULL; }
        if (nchars==0 && byteorder==(host_little()?'<':'>')) return &unicode0;
    } else {
        if (nchars > (size_t)INT_MAX) { serr(err,"string size is too large"); return NULL; }
        byteorder='|';
        if (nchars==0) return &bytes0;
    }
    for (ln_string_descr_node *n=descr_cache;n;n=n->next) {
        if (n->descr.type_num==(unicode_kind?LN_UNICODE:LN_STRING) &&
            ln_string_nchars(&n->descr)==nchars && n->descr.byteorder==byteorder) return &n->descr;
    }
    ln_string_descr_node *n=(ln_string_descr_node*)calloc(1,sizeof(*n));
    if(!n){serr(err,"out of memory");return NULL;}
    n->descr.cls=unicode_kind?&unicode_cls:&bytes_cls;
    n->descr.type_num=unicode_kind?LN_UNICODE:LN_STRING;
    n->descr.kind=unicode_kind?'U':'S'; n->descr.byteorder=byteorder;
    n->descr.flags=unicode_kind?LN_DTYPE_NEEDS_INIT:0;
    n->descr.elsize=unicode_kind?nchars*4:nchars; n->descr.alignment=unicode_kind?4:1;
    if(unicode_kind) snprintf(n->name,sizeof(n->name),"%cU%zu",byteorder,nchars);
    else snprintf(n->name,sizeof(n->name),"|S%zu",nchars);
    n->descr.name=n->name;
    n->next=descr_cache; descr_cache=n;
    return &n->descr;
}

static const ln_dtype_descr *str_common_instance(const ln_dtype_descr *a,
                                                  const ln_dtype_descr *b) {
    if(!a||!b)return NULL;
    /* The chosen class may be flexible even if only one operand is text.
     * Widths must be calculated from the numeric type's largest possible
     * formatted representation, not from the current element values. */
    int astr=ln_string_is_dtype(a), bstr=ln_string_is_dtype(b);
    if(!astr && !(a->cls->flags & LN_DTYPE_CLASS_LEGACY_NUMERIC))return NULL;
    if(!bstr && !(b->cls->flags & LN_DTYPE_CLASS_LEGACY_NUMERIC))return NULL;
    if(!astr && !bstr)return NULL;
    int uni=(a->type_num==LN_UNICODE || b->type_num==LN_UNICODE);
    size_t wa=ln_legacy_string_width_for_dtype(a);
    size_t wb=ln_legacy_string_width_for_dtype(b), w=wa>wb?wa:wb;
    if (wa==0 && !astr) return NULL;
    if (wb==0 && !bstr) return NULL;
    char bo=uni?(host_little()?'<':'>'):'|';
    return ln_string_make_dtype(uni,w,bo,NULL);
}

const ln_dtype_descr *ln_string_parse_dtype(const char *name, ln_error *err) {
    if(!name||!*name)return NULL;
    init_classes();
    const char *p=name; char bo=0;
    if(*p=='<'||*p=='>'||*p=='='||*p=='|'){bo=*p++;}
    int uni=0;
    if(*p=='U')uni=1;
    else if(*p=='S'||*p=='a')uni=0;
    else {
        if(strcmp(name,"str")==0||strcmp(name,"unicode")==0||strcmp(name,"str_")==0)return &unicode0;
        if(strcmp(name,"bytes")==0||strcmp(name,"bytes_")==0)return &bytes0;
        return NULL;
    }
    ++p;
    size_t width=0;
    if(*p){
        char *end=NULL; unsigned long long v=strtoull(p,&end,10);
        if(!end||*end){serr(err,"invalid string dtype");return NULL;}
        if(v>(unsigned long long)SIZE_MAX){serr(err,"string size is too large");return NULL;}
        width=(size_t)v;
    }
    if(!uni)bo='|';
    else if(bo==0||bo=='|'||bo=='=')bo=host_little()?'<':'>';
    return ln_string_make_dtype(uni,width,bo,err);
}

/* Strict UTF-8 decoder. Lua strings may contain arbitrary bytes, but U dtypes
 * are Unicode. Invalid byte sequences therefore fail rather than silently
 * manufacturing UCS4 values. */
static int next_cp(const unsigned char *s,size_t n,size_t *i,uint32_t *cp) {
    if(*i>=n)return 0;
    unsigned char c=s[(*i)++];
    if(c<0x80){*cp=c;return 1;}
    int k; uint32_t v;
    if((c&0xe0)==0xc0){k=1;v=c&0x1f;if(v<2)return -1;}
    else if((c&0xf0)==0xe0){k=2;v=c&0x0f;}
    else if((c&0xf8)==0xf0){k=3;v=c&0x07;if(v>4)return -1;}
    else return -1;
    if(*i+(size_t)k>n)return -1;
    for(int j=0;j<k;j++){unsigned char d=s[(*i)++];if((d&0xc0)!=0x80)return -1;v=(v<<6)|(d&0x3f);}
    if((k==2&&v<0x800)||(k==3&&v<0x10000)||v>0x10ffff||(v>=0xd800&&v<=0xdfff))return -1;
    *cp=v;return 1;
}

int ln_string_utf8_codepoints(const char *s,size_t nbytes,size_t *out,ln_error *err){
    size_t i=0,n=0;uint32_t cp;while(i<nbytes){int r=next_cp((const unsigned char*)s,nbytes,&i,&cp);if(r<0){serr(err,"invalid UTF-8 string");return -1;}n++;}*out=n;return 0;
}

int ln_string_pack_utf8(const ln_dtype_descr *dt,char *dst,const char *s,size_t nbytes,ln_error *err){
    if(!ln_string_is_dtype(dt)||!dst){serr(err,"invalid string pack");return -1;}
    memset(dst,0,dt->elsize);
    if(dt->type_num==LN_STRING){size_t n=nbytes<dt->elsize?nbytes:dt->elsize;if(n)memcpy(dst,s,n);return 0;}
    size_t i=0,k=0,w=ln_string_nchars(dt);uint32_t cp;
    while(i<nbytes&&k<w){int r=next_cp((const unsigned char*)s,nbytes,&i,&cp);if(r<0){serr(err,"invalid UTF-8 string");return -1;}store_u32(dst+k*4,cp,dt->byteorder);k++;}
    return 0;
}

static size_t utf8_len_cp(uint32_t cp){return cp<0x80?1:cp<0x800?2:cp<0x10000?3:4;}
static size_t put_cp(char *p,uint32_t cp){
    if(cp<0x80){p[0]=(char)cp;return 1;}
    if(cp<0x800){p[0]=(char)(0xc0|(cp>>6));p[1]=(char)(0x80|(cp&63));return 2;}
    if(cp<0x10000){p[0]=(char)(0xe0|(cp>>12));p[1]=(char)(0x80|((cp>>6)&63));p[2]=(char)(0x80|(cp&63));return 3;}
    p[0]=(char)(0xf0|(cp>>18));p[1]=(char)(0x80|((cp>>12)&63));p[2]=(char)(0x80|((cp>>6)&63));p[3]=(char)(0x80|(cp&63));return 4;
}

int ln_string_unpack_utf8(const ln_dtype_descr *dt,const char *src,char **out,size_t *out_nbytes,ln_error *err){
    if(!ln_string_is_dtype(dt)||!src||!out){serr(err,"invalid string unpack");return -1;}
    if(dt->type_num==LN_STRING){size_t n=dt->elsize;while(n&&src[n-1]=='\0')n--;char *p=(char*)malloc(n+1);if(!p){serr(err,"out of memory");return -1;}if(n)memcpy(p,src,n);p[n]=0;*out=p;if(out_nbytes)*out_nbytes=n;return 0;}
    size_t w=ln_string_nchars(dt),last=w;while(last&&load_u32(src+(last-1)*4,dt->byteorder)==0)last--;
    size_t n=0;for(size_t i=0;i<last;i++){uint32_t cp=load_u32(src+i*4,dt->byteorder);if(cp>0x10ffff||(cp>=0xd800&&cp<=0xdfff)){serr(err,"invalid UCS4 value");return -1;}n+=utf8_len_cp(cp);}
    char *p=(char*)malloc(n+1);if(!p){serr(err,"out of memory");return -1;}size_t q=0;for(size_t i=0;i<last;i++)q+=put_cp(p+q,load_u32(src+i*4,dt->byteorder));p[q]=0;*out=p;if(out_nbytes)*out_nbytes=q;return 0;
}

int ln_string_cast_one(const char *src,const ln_dtype_descr *sdt,char *dst,const ln_dtype_descr *ddt,ln_error *err){
    if(!ln_string_is_dtype(sdt)||!ln_string_is_dtype(ddt)){serr(err,"unsupported string cast");return -1;}
    if(sdt->type_num==LN_STRING&&ddt->type_num==LN_STRING){memset(dst,0,ddt->elsize);size_t n=sdt->elsize<ddt->elsize?sdt->elsize:ddt->elsize;if(n)memcpy(dst,src,n);return 0;}
    if(sdt->type_num==LN_UNICODE&&ddt->type_num==LN_UNICODE){memset(dst,0,ddt->elsize);size_t n=ln_string_nchars(sdt),m=ln_string_nchars(ddt),k=n<m?n:m;for(size_t i=0;i<k;i++)store_u32(dst+i*4,load_u32(src+i*4,sdt->byteorder),ddt->byteorder);return 0;}
    if(sdt->type_num==LN_STRING&&ddt->type_num==LN_UNICODE){
        /* NumPy legacy S->U decodes byte strings as ASCII. */
        size_t sn=sdt->elsize;while(sn&&src[sn-1]=='\0')sn--;
        for(size_t i=0;i<sn;i++)if((unsigned char)src[i]>=128){serr(err,"'ascii' codec can't decode byte string");return -1;}
        memset(dst,0,ddt->elsize);size_t m=ln_string_nchars(ddt),k=sn<m?sn:m;
        for(size_t i=0;i<k;i++)store_u32(dst+i*4,(unsigned char)src[i],ddt->byteorder);
        return 0;
    }
    /* U->S is unsafe in NumPy and effectively ASCII encoding for legacy cast. */
    size_t n=ln_string_nchars(sdt),m=ddt->elsize,k=n<m?n:m;
    for(size_t i=0;i<n;i++)if(load_u32(src+i*4,sdt->byteorder)>=128){serr(err,"'ascii' codec can't encode unicode string");return -1;}
    memset(dst,0,ddt->elsize);
    for(size_t i=0;i<k;i++)dst[i]=(char)load_u32(src+i*4,sdt->byteorder);
    return 0;
}

int ln_string_compare_one(const char *a,const ln_dtype_descr *adt,const char *b,const ln_dtype_descr *bdt,int *cmp,ln_error *err){
    if(!ln_string_is_dtype(adt)||!ln_string_is_dtype(bdt)||adt->type_num!=bdt->type_num){serr(err,"string comparison requires matching S or U classes");return -1;}
    if(adt->type_num==LN_STRING){size_t na=adt->elsize,nb=bdt->elsize;while(na&&a[na-1]=='\0')na--;while(nb&&b[nb-1]=='\0')nb--;size_t n=na<nb?na:nb;int c=n?memcmp(a,b,n):0;if(c<0)*cmp=-1;else if(c>0)*cmp=1;else *cmp=na<nb?-1:na>nb?1:0;return 0;}
    size_t na=ln_string_nchars(adt),nb=ln_string_nchars(bdt),ia=na,ib=nb;
    while(ia&&load_u32(a+(ia-1)*4,adt->byteorder)==0)ia--;
    while(ib&&load_u32(b+(ib-1)*4,bdt->byteorder)==0)ib--;
    size_t n=ia<ib?ia:ib;for(size_t i=0;i<n;i++){uint32_t x=load_u32(a+i*4,adt->byteorder),y=load_u32(b+i*4,bdt->byteorder);if(x<y){*cmp=-1;return 0;}if(x>y){*cmp=1;return 0;}}
    *cmp=ia<ib?-1:ia>ib?1:0;return 0;
}

/* NumPy string_ufuncs.cpp:string_add and string_buffer.h:num_codepoints.
 * Trailing zero padding is not part of either string; embedded zeros are. */
int ln_string_add_one(const char *a,const ln_dtype_descr *adt,
                      const char *b,const ln_dtype_descr *bdt,
                      char *out,const ln_dtype_descr *outdt,ln_error *err)
{
    if(!ln_string_is_dtype(adt)||!ln_string_is_dtype(bdt)||!ln_string_is_dtype(outdt)||
       adt->type_num!=bdt->type_num||adt->type_num!=outdt->type_num){
        serr(err,"string addition requires matching string dtype classes");return -1;
    }
    size_t na=ln_string_nchars(adt),nb=ln_string_nchars(bdt),capacity=ln_string_nchars(outdt);
    if(na>capacity||nb>capacity-na){serr(err,"string addition output is too small");return -1;}
    memset(out,0,outdt->elsize);
    if(adt->type_num==LN_STRING){
        while(na&&a[na-1]==0)--na;
        while(nb&&b[nb-1]==0)--nb;
        memcpy(out,a,na);memcpy(out+na,b,nb);
    }else{
        while(na&&load_u32(a+(na-1)*4,adt->byteorder)==0)--na;
        while(nb&&load_u32(b+(nb-1)*4,bdt->byteorder)==0)--nb;
        for(size_t i=0;i<na;++i)store_u32(out+i*4,load_u32(a+i*4,adt->byteorder),outdt->byteorder);
        for(size_t i=0;i<nb;++i)store_u32(out+(na+i)*4,load_u32(b+i*4,bdt->byteorder),outdt->byteorder);
    }
    return 0;
}
