#include "ln_core.h"
#include "lua_layout.h"
#include "ln_random.h"
#include "ln_multivariate_normal.h"
#include "ln_mapping.h"
#include "ln_write.h"
#include "ln_take.h"
#include "ln_along.h"
#include "ln_choose.h"
#include "ln_condition.h"
#include "ln_select.h"
#include "ln_matmul.h"
#include "ln_dot.h"
#include "ln_join.h"
#include "ln_delete.h"
#include "ln_insert.h"
#include "ln_split.h"
#include "ln_axis.h"
#include "ln_repeat.h"
#include "ln_roll.h"
#include "ln_stats.h"
#include "ln_average.h"
#include "ln_truth.h"
#include "ln_quantile.h"
#include "ln_sort.h"
#include "ln_fft.h"
#include "ln_fft_helpers.h"
#include "ln_sampling.h"
#include "ln_linalg.h"
#include "ln_ufunc.h"
#include "ln_complex.h"
#include "ln_datetime.h"
#include "ln_datetime_strings.h"
#include "ln_string.h"
#include "ln_dtype_transfer.h"
#include "lua_compat.h"
#include "lua_creation.h"
#include "lua_array_api.h"

#include <ctype.h>
#include <math.h>
#include <limits.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define ARRAY_MT "luaray.ndarray"
#define GENERATOR_MT "luaray.random.Generator"
#define INDEX_MT "luaray.index"
#define COMPLEX_MT "luaray.complex"
#define DATETIME_MT "luaray.datetime64"
#define TIMEDELTA_MT "luaray.timedelta64"

typedef struct { ln_array *a; } lua_array;
typedef struct { long double real, imag; } lua_complex;
typedef struct { int64_t value; const ln_dtype *descr; } lua_datetime_scalar;

typedef struct {
    int kind;
    int has_start;
    int has_stop;
    int has_step;
    lua_Integer start;
    lua_Integer stop;
    lua_Integer step;
} lua_index_spec;

typedef struct {
    int kind;
    lua_Integer integer;
    lua_index_spec slice;
    ln_array *array;
} parsed_index;

static int np_searchsorted(lua_State *L);
static int np_put(lua_State *L);
static int np_take(lua_State *L);
static int np_choose(lua_State *L);
static int np_nonzero(lua_State *L);
static int array_compress(lua_State *L);
static int np_var(lua_State *L);
static int np_count_nonzero(lua_State *L);
static int np_any(lua_State *L);
static int np_average(lua_State *L);
static int np_all(lua_State *L);
static int np_std(lua_State *L);
static int np_nansum(lua_State *L);
static int np_nanprod(lua_State *L);
static int np_nanmean(lua_State *L);
static int np_nanvar(lua_State *L);
static int np_nanstd(lua_State *L);
static int np_amin(lua_State *L);
static int np_amax(lua_State *L);
static int np_nanmin(lua_State *L);
static int np_nanmax(lua_State *L);
static int np_nanargmin(lua_State *L);
static int np_nanargmax(lua_State *L);
static int np_cumsum(lua_State *L);
static int np_cumprod(lua_State *L);
static int np_nancumsum(lua_State *L);
static int np_nancumprod(lua_State *L);
static int np_argmin(lua_State *L);
static int np_argmax(lua_State *L);
static int np_ptp(lua_State *L);
static int np_median(lua_State *L);
static int np_quantile(lua_State *L);
static int np_nanmedian(lua_State *L);
static int np_nanquantile(lua_State *L);
static int np_nanpercentile(lua_State *L);
static int np_percentile(lua_State *L);
static lua_array *check_array(lua_State *L,int idx);
static lua_array *test_array(lua_State *L,int idx);
static lua_complex *test_complex(lua_State *L,int idx);
static ln_array *broadcast_arg(lua_State *L,int idx);
static int fail(lua_State *L,const ln_error *e);
static int push_array(lua_State *L,ln_array *a);
static ln_array *write98_arg(lua_State *L,int arg,const ln_dtype *dtype,ln_casting casting);
static int normalize_lua_axis(lua_State *L,lua_Integer raw,int nd,int *axis);
static int np_transpose(lua_State *L);
static int np_swapaxes(lua_State *L);
static int np_moveaxis(lua_State *L);
static int np_expand_dims(lua_State *L);
static int np_squeeze(lua_State *L);
static int np_flip(lua_State *L);
static int np_flipud(lua_State *L);
static int np_fliplr(lua_State *L);
static int np_rot90(lua_State *L);
static int np_tile(lua_State *L);
static int np_roll(lua_State *L);
static int np_rollaxis(lua_State *L);
static int np_atleast_1d(lua_State *L);
static int np_atleast_2d(lua_State *L);
static int np_atleast_3d(lua_State *L);
static int np_repeat_elements(lua_State *L);


typedef enum lua_fft_kind {
    LUA_FFT_FFT = 0,
    LUA_FFT_IFFT = 1,
    LUA_FFT_RFFT = 2,
    LUA_FFT_IRFFT = 3,
    LUA_FFT_HFFT = 4,
    LUA_FFT_IHFFT = 5
} lua_fft_kind;

typedef struct fft_call_options {
    ln_intp n;
    int has_n;
    int axis;
    ln_fft_norm norm;
    lua_array *out;
    int options_table_index;
} fft_call_options;

static int
parse_fft_norm(lua_State *L, int idx, ln_fft_norm *norm)
{
    if (lua_type(L,idx)==LUA_TNIL) { *norm=LN_FFT_NORM_BACKWARD; return 0; }
    const char *v=lua_tostring(L,idx);
    if (!v) return luaL_error(L,"norm must be 'backward', 'ortho', 'forward', or nil");
    if (strcmp(v,"backward")==0) *norm=LN_FFT_NORM_BACKWARD;
    else if (strcmp(v,"ortho")==0) *norm=LN_FFT_NORM_ORTHO;
    else if (strcmp(v,"forward")==0) *norm=LN_FFT_NORM_FORWARD;
    else return luaL_error(L,"Invalid norm value %s; should be 'backward', 'ortho' or 'forward'.",v);
    return 0;
}

static int
parse_fft_options_table(lua_State *L,int idx,const ln_array *a,lua_fft_kind kind,
                        fft_call_options *o)
{
    idx=lua_absindex(L,idx); o->options_table_index=idx;
    lua_getfield(L,idx,"n");
    if(lua_type(L,-1)!=LUA_TNIL){
        int ok=0;lua_Integer n=lua_tointegerx(L,-1,&ok);
        if(!ok){lua_pop(L,1);return luaL_error(L,"n must be an integer or nil");}
        o->n=(ln_intp)n;o->has_n=1;
    }
    lua_pop(L,1);
    lua_getfield(L,idx,"axis");
    if(lua_type(L,-1)!=LUA_TNIL){
        int ok=0;lua_Integer raw=lua_tointegerx(L,-1,&ok);
        if(!ok){lua_pop(L,1);return luaL_error(L,"axis must be an integer");}
        if(normalize_lua_axis(L,raw,a->nd,&o->axis)){lua_pop(L,1);return 1;}
    }
    lua_pop(L,1);
    lua_getfield(L,idx,"norm");
    if(parse_fft_norm(L,-1,&o->norm)){lua_pop(L,1);return 1;}
    lua_pop(L,1);
    lua_getfield(L,idx,"out");
    if(lua_type(L,-1)!=LUA_TNIL){
        o->out=test_array(L,-1);
        if(!o->out){lua_pop(L,1);return luaL_error(L,"out must be an ndarray or nil");}
    }
    lua_pop(L,1);
    (void)kind;
    return 0;
}

static ln_intp fft_default_length(lua_State *L,const ln_array *a,int axis,lua_fft_kind kind) {
    ln_intp length=a->dimensions[axis];
    if(kind==LUA_FFT_IRFFT || kind==LUA_FFT_HFFT) {
        if(length>INTPTR_MAX/2+1)luaL_error(L,"default real FFT length overflows native index range");
        return 2*(length-1);
    }
    return length;
}

static int
parse_fft_call(lua_State *L,const ln_array *a,lua_fft_kind kind,fft_call_options *o,int top)
{
    memset(o,0,sizeof(*o));
    if(a->nd<1)return luaL_error(L,"axis -1 is out of bounds for array of dimension 0");
    o->axis=a->nd-1; o->norm=LN_FFT_NORM_BACKWARD;
    if(top<2||lua_type(L,2)==LUA_TNIL){
        o->has_n=0;
    }
    else if(lua_type(L,2)==LUA_TTABLE){
        int rc=parse_fft_options_table(L,2,a,kind,o);if(rc)return rc;
        if(!o->has_n)o->n=fft_default_length(L,a,o->axis,kind);
        return 0;
    }
    /* Convenient NumPy-shaped positional form: (a, n, axis, norm, out).
     * Axis remains Lua 1-based. */
    int ok=0;
    if(top>=2 && lua_type(L,2)!=LUA_TNIL) {
        lua_Integer n=lua_tointegerx(L,2,&ok);
        if(!ok)return luaL_error(L,"second FFT argument must be n or an options table");
        o->n=(ln_intp)n;o->has_n=1;
    }
    if(top>=3&&lua_type(L,3)!=LUA_TNIL){
        lua_Integer raw=lua_tointegerx(L,3,&ok);if(!ok)return luaL_error(L,"axis must be an integer");
        if(normalize_lua_axis(L,raw,a->nd,&o->axis))return 1;
    }
    if(top>=4&&parse_fft_norm(L,4,&o->norm))return 1;
    if(top>=5&&lua_type(L,5)!=LUA_TNIL){o->out=test_array(L,5);if(!o->out)return luaL_error(L,"out must be an ndarray or nil");}
    if(!o->has_n)o->n=fft_default_length(L,a,o->axis,kind);
    return 0;
}

static int
fft_function(lua_State *L,lua_fft_kind kind)
{
    int nargs=lua_gettop(L);
    if(nargs<1 || nargs>5)return luaL_error(L,"FFT expects input and optional n, axis, norm and out");
    const ln_array *input=broadcast_arg(L,1);fft_call_options o;
    if(parse_fft_call(L,input,kind,&o,nargs))return 0;
    ln_error e={{0}};ln_array *r=NULL;
    const ln_dtype *outdt=o.out?o.out->a->descr:NULL;
    if(kind==LUA_FFT_FFT) r=ln_fft_fft(input,o.n,o.axis,0,o.norm,outdt,&e);
    else if(kind==LUA_FFT_IFFT) r=ln_fft_fft(input,o.n,o.axis,1,o.norm,outdt,&e);
    else if(kind==LUA_FFT_RFFT) r=ln_fft_rfft(input,o.n,o.axis,o.norm,outdt,&e);
    else if(kind==LUA_FFT_IRFFT)r=ln_fft_irfft(input,o.n,o.axis,o.norm,outdt,&e);
    else if(kind==LUA_FFT_HFFT)r=ln_fft_hfft(input,o.n,o.axis,o.norm,outdt,&e);
    else r=ln_fft_ihfft(input,o.n,o.axis,o.norm,outdt,&e);
    if(!r)return fail(L,&e);
    if(o.out){
        if(ln_fft_copy_into(r,o.out->a,&e)<0){ln_array_free(r);return fail(L,&e);}
        ln_array_free(r);
        if(o.options_table_index){lua_getfield(L,o.options_table_index,"out");return 1;}
        lua_pushvalue(L,5);return 1;
    }
    return push_array(L,r);
}
static int np_fft_fft(lua_State *L){return fft_function(L,LUA_FFT_FFT);}
static int np_fft_ifft(lua_State *L){return fft_function(L,LUA_FFT_IFFT);}
static int np_fft_rfft(lua_State *L){return fft_function(L,LUA_FFT_RFFT);}
static int np_fft_irfft(lua_State *L){return fft_function(L,LUA_FFT_IRFFT);}

static int np_fft_hfft(lua_State *L){return fft_function(L,LUA_FFT_HFFT);}
static int np_fft_ihfft(lua_State *L){return fft_function(L,LUA_FFT_IHFFT);}

static int fft_frequency_function(lua_State *L,int real_only) {
    int nargs=lua_gettop(L);
    if(nargs<1 || nargs>2)return luaL_error(L,"frequency expects n and optional spacing");
    ln_intp n;
    if(lua_type(L,1)==LUA_TBOOLEAN) {
        if(!real_only)return luaL_error(L,"fftfreq n must be an integer dimension");
        n=lua_toboolean(L,1);
    }
    else if(lua_isinteger(L,1))n=(ln_intp)lua_tointegerx(L,1,NULL);
    else return luaL_error(L,"frequency n must be an integer");
    if(nargs==1){lua_pushnumber(L,1.0);nargs=2;}
    if(lua_type(L,2)==LUA_TTABLE)return luaL_error(L,"spacing must be a numeric scalar or ndarray");
    int scalar=lua_type(L,2)==LUA_TNUMBER || lua_type(L,2)==LUA_TBOOLEAN || test_complex(L,2)!=NULL;
    const ln_array *spacing=broadcast_arg(L,2);
    ln_error err={{0}};ln_array *result=ln_fft_frequency(n,spacing,scalar,real_only,&err);
    if(!result)return fail(L,&err);
    return push_array(L,result);
}
static int np_fft_fftfreq(lua_State *L){return fft_frequency_function(L,0);}
static int np_fft_rfftfreq(lua_State *L){return fft_frequency_function(L,1);}
static int fft_shift_function(lua_State *L,int inverse) {
    int nargs=lua_gettop(L);
    if(nargs<1 || nargs>2)return luaL_error(L,"FFT shift expects input and optional axes");
    const ln_array *input=broadcast_arg(L,1);int count=-1,*axes=NULL;
    if(nargs==2 && lua_type(L,2)!=LUA_TNIL) {
        size_t n=lua_type(L,2)==LUA_TTABLE?lua_rawlen(L,2):1;
        if(n>INT_MAX || n>SIZE_MAX/sizeof(*axes))return luaL_error(L,"too many FFT shift axes");
        count=(int)n;axes=lua_newuserdatauv(L,n*sizeof(*axes),0);
        for(size_t j=0;j<n;++j) {
            if(lua_type(L,2)==LUA_TTABLE)lua_geti(L,2,(lua_Integer)j+1);
            else lua_pushvalue(L,2);
            if(!lua_isinteger(L,-1))return luaL_error(L,"FFT shift axes must be integers");
            normalize_lua_axis(L,lua_tointegerx(L,-1,NULL),input->nd,&axes[j]);lua_pop(L,1);
        }
    }
    ln_error err={{0}};ln_array *result=ln_fft_shift(input,axes,count,inverse,&err);
    if(!result)return fail(L,&err);
    return push_array(L,result);
}
static int np_fft_fftshift(lua_State *L){return fft_shift_function(L,0);}
static int np_fft_ifftshift(lua_State *L){return fft_shift_function(L,1);}

typedef enum lua_fft_nd_kind {
    LUA_FFT_FFTN = 0,
    LUA_FFT_IFFTN = 1,
    LUA_FFT_RFFTN = 2,
    LUA_FFT_IRFFTN = 3
} lua_fft_nd_kind;

typedef struct fft_nd_options {
    ln_intp *s;
    int *axes;
    size_t ntrans;
    int owns_s;
    int owns_axes;
    ln_fft_norm norm;
    lua_array *out;
    int options_table_index;
    int out_arg_index;
} fft_nd_options;

static void free_fft_nd_options(fft_nd_options *o)
{
    if (o->owns_s) free(o->s);
    if (o->owns_axes) free(o->axes);
    memset(o, 0, sizeof(*o));
}

static int table_has_fft_nd_named_fields(lua_State *L, int idx)
{
    static const char *keys[] = {"s", "axes", "norm", "out", NULL};
    idx = lua_absindex(L, idx);
    /* Lua has no tuple-vs-options-table distinction.  Reserve an empty table
     * for the common options-table spelling; an empty transform sequence is
     * still available explicitly as {s={}} or {axes={}}. */
    if (lua_rawlen(L, idx) == 0) return 1;
    for (int i=0; keys[i]; ++i) {
        lua_getfield(L, idx, keys[i]);
        int present = lua_type(L, -1) != LUA_TNIL;
        lua_pop(L, 1);
        if (present) return 1;
    }
    return 0;
}

static int read_int_sequence(lua_State *L, int idx, lua_Integer **vals, size_t *n)
{
    idx = lua_absindex(L, idx);
    if (lua_type(L, idx) != LUA_TTABLE) return -1;
    size_t len = lua_rawlen(L, idx);
    lua_Integer *v = len ? (lua_Integer *)malloc(len * sizeof(*v)) : NULL;
    if (len && !v) return -2;
    for (size_t i=0; i<len; ++i) {
        lua_geti(L, idx, (lua_Integer)i + 1);
        int ok=0; lua_Integer x=lua_tointegerx(L,-1,&ok);
        lua_pop(L,1);
        if (!ok) { free(v); return -1; }
        v[i]=x;
    }
    *vals=v; *n=len; return 0;
}

static int normalize_fft_axis_noerror(lua_Integer raw,int nd,int *axis)
{
    lua_Integer x=raw;
    if(x>0)x-=1;
    else if(x<0)x=(lua_Integer)nd+x;
    else return -1;
    if(x<0||x>=nd)return -2;
    *axis=(int)x;return 0;
}

static int parse_fft_nd_call(lua_State *L, const ln_array *a, lua_fft_nd_kind kind,
                             int default_2d, fft_nd_options *o)
{
    memset(o,0,sizeof(*o)); o->norm=LN_FFT_NORM_BACKWARD;
    int top=lua_gettop(L), named=0, sidx=0, axesidx=0, normidx=0, outidx=0;
    if (top>=2 && lua_type(L,2)==LUA_TTABLE && table_has_fft_nd_named_fields(L,2)) {
        named=1; o->options_table_index=lua_absindex(L,2);
        lua_getfield(L,2,"s"); if(lua_type(L,-1)!=LUA_TNIL) sidx=lua_absindex(L,-1); else lua_pop(L,1);
        lua_getfield(L,2,"axes"); if(lua_type(L,-1)!=LUA_TNIL) axesidx=lua_absindex(L,-1); else lua_pop(L,1);
        lua_getfield(L,2,"norm"); normidx=lua_absindex(L,-1);
        lua_getfield(L,2,"out"); outidx=lua_absindex(L,-1);
    }
    else {
        if(top>=2 && lua_type(L,2)!=LUA_TNIL) sidx=2;
        if(top>=3 && lua_type(L,3)!=LUA_TNIL) axesidx=3;
        if(top>=4) normidx=4;
        if(top>=5) outidx=5;
    }

    lua_Integer *sv=NULL,*av=NULL; size_t ns=0,na=0;
    int rr=0;
    if(sidx && (rr=read_int_sequence(L,sidx,&sv,&ns))!=0) {
        if(named) lua_settop(L,top);
        free(sv); free(av);
        return luaL_error(L,rr==-2?"out of memory parsing s":"s entries must be integers");
    }
    if(axesidx && (rr=read_int_sequence(L,axesidx,&av,&na))!=0) {
        if(named) lua_settop(L,top);
        free(sv); free(av);
        return luaL_error(L,rr==-2?"out of memory parsing axes":"axes entries must be integers");
    }
    if(sidx && axesidx && ns!=na) {
        if(named) lua_settop(L,top);
        free(sv); free(av);
        return luaL_error(L,"Shape and axes have different lengths.");
    }

    if(normidx && lua_type(L,normidx)!=LUA_TNIL) {
        const char *v=lua_tostring(L,normidx);
        if(v&&strcmp(v,"backward")==0)o->norm=LN_FFT_NORM_BACKWARD;
        else if(v&&strcmp(v,"ortho")==0)o->norm=LN_FFT_NORM_ORTHO;
        else if(v&&strcmp(v,"forward")==0)o->norm=LN_FFT_NORM_FORWARD;
        else {if(named) lua_settop(L,top);
        free(sv); free(av);return luaL_error(L,"Invalid norm value; should be 'backward', 'ortho' or 'forward'.");}
    }
    if(outidx && lua_type(L,outidx)!=LUA_TNIL) {
        o->out=test_array(L,outidx);
        if(!o->out){if(named) lua_settop(L,top);
        free(sv); free(av);return luaL_error(L,"out must be an ndarray or nil");}
        o->out_arg_index=named?0:5;
    }

    size_t nt=sidx?ns:(axesidx?na:(default_2d?2u:(size_t)a->nd));
    if(default_2d && !axesidx && a->nd<2) {
        if(named) lua_settop(L,top);
        free(sv); free(av);
        return luaL_error(L,"axis -2 is out of bounds for array of dimension %d",a->nd);
    }
    if(!axesidx && sidx && nt>(size_t)a->nd) {
        if(named) lua_settop(L,top);
        free(sv); free(av);
        return luaL_error(L,"too many FFT axes for array dimension %d",a->nd);
    }

    o->s=nt?(ln_intp*)malloc(nt*sizeof(*o->s)):NULL;
    o->axes=nt?(int*)malloc(nt*sizeof(*o->axes)):NULL;
    if(nt&&(!o->s||!o->axes)) {
        if(named) lua_settop(L,top);
        free(sv); free(av);free_fft_nd_options(o);
        return luaL_error(L,"out of memory parsing FFT axes");
    }
    o->owns_s=o->owns_axes=1;o->ntrans=nt;

    if(axesidx) {
        for(size_t i=0;i<nt;++i) {
            int ax=0,rc=normalize_fft_axis_noerror(av[i],a->nd,&ax);
            if(rc) {
                char msg[192];
                if(rc==-1)snprintf(msg,sizeof(msg),"axis 0 is invalid in Lua's 1-based indexing model");
                else snprintf(msg,sizeof(msg),"axis %lld is out of bounds for array of dimension %d",(long long)av[i],a->nd);
                if(named) lua_settop(L,top);
        free(sv); free(av);free_fft_nd_options(o);
                return luaL_error(L,"%s",msg);
            }
            o->axes[i]=ax;
        }
    }
    else if(default_2d){o->axes[0]=a->nd-2;o->axes[1]=a->nd-1;}
    else if(sidx){for(size_t i=0;i<nt;++i)o->axes[i]=a->nd-(int)nt+(int)i;}
    else {for(size_t i=0;i<nt;++i)o->axes[i]=(int)i;}

    if(sidx) {
        for(size_t i=0;i<nt;++i) {
            lua_Integer x=sv[i];
            if(x==-1)x=(lua_Integer)a->dimensions[o->axes[i]];
            o->s[i]=(ln_intp)x;
        }
    }
    else {
        for(size_t i=0;i<nt;++i)o->s[i]=a->dimensions[o->axes[i]];
        if(kind==LUA_FFT_IRFFTN&&nt>0)o->s[nt-1]=2*(a->dimensions[o->axes[nt-1]]-1);
    }

    free(sv);free(av);
    if(named)lua_settop(L,top);
    return 0;
}

static ln_array *fft_nd_one(const ln_array *in, lua_fft_kind kind, ln_intp n, int axis,
                            ln_fft_norm norm, const ln_dtype *outdt, ln_error *e)
{
    if(kind==LUA_FFT_FFT) return ln_fft_fft(in,n,axis,0,norm,outdt,e);
    if(kind==LUA_FFT_IFFT) return ln_fft_fft(in,n,axis,1,norm,outdt,e);
    if(kind==LUA_FFT_RFFT) return ln_fft_rfft(in,n,axis,norm,outdt,e);
    return ln_fft_irfft(in,n,axis,norm,outdt,e);
}

static int fft_nd_function(lua_State *L, lua_fft_nd_kind kind, int default_2d)
{
    lua_array *u=check_array(L,1); fft_nd_options o;
    if(parse_fft_nd_call(L,u->a,kind,default_2d,&o)) return 0;
    if(o.ntrans==0){ free_fft_nd_options(&o); lua_pushvalue(L,1); return 1; }

    ln_error e={{0}}; const ln_array *cur=u->a; ln_array *owned=NULL;
    int failed=0;
    if(kind==LUA_FFT_FFTN || kind==LUA_FFT_IFFTN) {
        lua_fft_kind one=(kind==LUA_FFT_FFTN)?LUA_FFT_FFT:LUA_FFT_IFFT;
        for(size_t rev=o.ntrans; rev>0; --rev) {
            size_t i=rev-1; const ln_dtype *odt=o.out?o.out->a->descr:NULL;
            ln_array *r=fft_nd_one(cur,one,o.s[i],o.axes[i],o.norm,odt,&e);
            if(!r){failed=1;break;}
            if(o.out){
                if(ln_fft_copy_into(r,o.out->a,&e)<0){ln_array_free(r);failed=1;break;}
                ln_array_free(r); if(owned){ln_array_free(owned);owned=NULL;} cur=o.out->a;
            } else {
                if(owned) ln_array_free(owned);
                owned=r;
                cur=r;
            }
        }
    }
    else if(kind==LUA_FFT_RFFTN) {
        size_t i=o.ntrans-1; const ln_dtype *odt=o.out?o.out->a->descr:NULL;
        ln_array *r=fft_nd_one(cur,LUA_FFT_RFFT,o.s[i],o.axes[i],o.norm,odt,&e);
        if(!r) failed=1;
        else if(o.out){
            if(ln_fft_copy_into(r,o.out->a,&e)<0){ln_array_free(r);failed=1;}
            else {ln_array_free(r);cur=o.out->a;}
        } else {owned=r;cur=r;}
        for(size_t rev=o.ntrans-1; !failed && rev>0; --rev) {
            size_t j=rev-1; odt=o.out?o.out->a->descr:NULL;
            r=fft_nd_one(cur,LUA_FFT_FFT,o.s[j],o.axes[j],o.norm,odt,&e);
            if(!r){failed=1;break;}
            if(o.out){
                if(ln_fft_copy_into(r,o.out->a,&e)<0){ln_array_free(r);failed=1;break;}
                ln_array_free(r); if(owned){ln_array_free(owned);owned=NULL;}cur=o.out->a;
            } else {
                if(owned)ln_array_free(owned);
                owned=r;
                cur=r;
            }
        }
    }
    else { /* irfftn: complex inverse transforms first, irfft last; out only on final step */
        for(size_t i=0; i+1<o.ntrans; ++i) {
            ln_array *r=fft_nd_one(cur,LUA_FFT_IFFT,o.s[i],o.axes[i],o.norm,NULL,&e);
            if(!r){failed=1;break;}
            if(owned)ln_array_free(owned);
            owned=r;
            cur=r;
        }
        if(!failed){
            size_t i=o.ntrans-1; const ln_dtype *odt=o.out?o.out->a->descr:NULL;
            ln_array *r=fft_nd_one(cur,LUA_FFT_IRFFT,o.s[i],o.axes[i],o.norm,odt,&e);
            if(!r) failed=1;
            else if(o.out){
                if(ln_fft_copy_into(r,o.out->a,&e)<0){ln_array_free(r);failed=1;}
                else {ln_array_free(r);if(owned){ln_array_free(owned);owned=NULL;}cur=o.out->a;}
            } else {
                if(owned)ln_array_free(owned);
                owned=r;
                cur=r;
            }
        }
    }

    if(failed){if(owned)ln_array_free(owned);free_fft_nd_options(&o);return fail(L,&e);}
    if(o.out){
        int named=o.options_table_index;
        free_fft_nd_options(&o);
        if(named){lua_getfield(L,named,"out");return 1;}
        lua_pushvalue(L,5);return 1;
    }
    free_fft_nd_options(&o);
    return push_array(L,owned);
}

static int np_fft_fftn(lua_State *L){return fft_nd_function(L,LUA_FFT_FFTN,0);}
static int np_fft_ifftn(lua_State *L){return fft_nd_function(L,LUA_FFT_IFFTN,0);}
static int np_fft_rfftn(lua_State *L){return fft_nd_function(L,LUA_FFT_RFFTN,0);}
static int np_fft_irfftn(lua_State *L){return fft_nd_function(L,LUA_FFT_IRFFTN,0);}
static int np_fft_fft2(lua_State *L){return fft_nd_function(L,LUA_FFT_FFTN,1);}
static int np_fft_ifft2(lua_State *L){return fft_nd_function(L,LUA_FFT_IFFTN,1);}
static int np_fft_rfft2(lua_State *L){return fft_nd_function(L,LUA_FFT_RFFTN,1);}
static int np_fft_irfft2(lua_State *L){return fft_nd_function(L,LUA_FFT_IRFFTN,1);}
static const luaL_Reg fft_funcs[]={
    {"fft",np_fft_fft},{"ifft",np_fft_ifft},{"rfft",np_fft_rfft},{"irfft",np_fft_irfft},
    {"hfft",np_fft_hfft},{"ihfft",np_fft_ihfft},{"fftfreq",np_fft_fftfreq},{"rfftfreq",np_fft_rfftfreq},
    {"fftshift",np_fft_fftshift},{"ifftshift",np_fft_ifftshift},
    {"fftn",np_fft_fftn},{"ifftn",np_fft_ifftn},{"rfftn",np_fft_rfftn},{"irfftn",np_fft_irfftn},
    {"fft2",np_fft_fft2},{"ifft2",np_fft_ifft2},{"rfft2",np_fft_rfft2},{"irfft2",np_fft_irfft2},
    {NULL,NULL}};

typedef struct {
    ln_index indices[LN_MAXDIMS * 2 + 1];
    int index_num;
    int pure_integer;
    int result_nd;
    int has_fancy;
    int scalar_array_copy;
    const ln_array *boolean_mask;
    ln_array *owned[LN_MAXDIMS * 2 + 1];
    int owned_count;
} built_index;

static int np_astype(lua_State *L);
static lua_array *check_array(lua_State *L,int idx){return (lua_array*)luaL_checkudata(L,idx,ARRAY_MT);} 
static lua_array *test_array(lua_State *L,int idx){return (lua_array*)luaL_testudata(L,idx,ARRAY_MT);} 
static lua_complex *check_complex(lua_State *L,int idx){return (lua_complex*)luaL_checkudata(L,idx,COMPLEX_MT);}
static lua_complex *test_complex(lua_State *L,int idx){return (lua_complex*)luaL_testudata(L,idx,COMPLEX_MT);}
static int push_complex(lua_State *L,long double real,long double imag){lua_complex*z=(lua_complex*)lua_newuserdatauv(L,sizeof(*z),0);z->real=real;z->imag=imag;luaL_setmetatable(L,COMPLEX_MT);return 1;}

static int complex_ctor(lua_State *L){long double r=(long double)luaL_checknumber(L,1);long double i=(lua_gettop(L)>=2)?(long double)luaL_checknumber(L,2):0.0L;return push_complex(L,r,i);}
static int complex_tostring(lua_State *L){lua_complex*z=check_complex(L,1);char b[160];snprintf(b,sizeof(b),"(%Lg%+Lgj)",z->real,z->imag);lua_pushstring(L,b);return 1;}
static int complex_index(lua_State *L){lua_complex*z=check_complex(L,1);const char*k=lua_tostring(L,2);if(k&&strcmp(k,"real")==0){lua_pushnumber(L,(lua_Number)z->real);return 1;}if(k&&strcmp(k,"imag")==0){lua_pushnumber(L,(lua_Number)z->imag);return 1;}lua_pushnil(L);return 1;}
static int complex_eq(lua_State *L){lua_complex*a=test_complex(L,1),*b=test_complex(L,2);if(!a||!b){lua_pushboolean(L,0);return 1;}lua_pushboolean(L,a->real==b->real&&a->imag==b->imag);return 1;}
static int read_host_complex(lua_State *L,int idx,long double*r,long double*i){lua_complex*z=test_complex(L,idx);if(z){*r=z->real;*i=z->imag;return 0;}int ok=0;lua_Number v=lua_tonumberx(L,idx,&ok);if(ok){*r=(long double)v;*i=0;return 0;}return luaL_error(L,"complex arithmetic operand must be number or luaray.complex");}
static int complex_add(lua_State *L){long double ar,ai,br,bi;if(read_host_complex(L,1,&ar,&ai)||read_host_complex(L,2,&br,&bi))return 0;return push_complex(L,ar+br,ai+bi);}
static int complex_sub(lua_State *L){long double ar,ai,br,bi;if(read_host_complex(L,1,&ar,&ai)||read_host_complex(L,2,&br,&bi))return 0;return push_complex(L,ar-br,ai-bi);}
static int complex_mul(lua_State *L){long double ar,ai,br,bi;if(read_host_complex(L,1,&ar,&ai)||read_host_complex(L,2,&br,&bi))return 0;return push_complex(L,ar*br-ai*bi,ar*bi+ai*br);}
static int complex_div(lua_State *L){long double ar,ai,br,bi;if(read_host_complex(L,1,&ar,&ai)||read_host_complex(L,2,&br,&bi))return 0;long double abr=fabsl(br),abi=fabsl(bi),rr,ri;if(abr>=abi){if(abr==0){rr=ar/abr;ri=ai/abi;}else{long double rat=bi/br,scl=1.0L/(br+bi*rat);rr=(ar+ai*rat)*scl;ri=(ai-ar*rat)*scl;}}else{long double rat=br/bi,scl=1.0L/(bi+br*rat);rr=(ar*rat+ai)*scl;ri=(ai*rat-ar)*scl;}return push_complex(L,rr,ri);}
static int complex_unm(lua_State *L){lua_complex*z=check_complex(L,1);return push_complex(L,-z->real,-z->imag);}
static int fail(lua_State *L,const ln_error *e){return luaL_error(L,"%s",(e&&e->message[0])?e->message:"LuaRay error");}
static int push_array(lua_State *L,ln_array*a){if(!a)return luaL_error(L,"internal null array");lua_array*u=(lua_array*)lua_newuserdatauv(L,sizeof(*u),0);u->a=a;luaL_setmetatable(L,ARRAY_MT);return 1;}

static int array_gc(lua_State*L){lua_array*u=check_array(L,1);if(u->a){ln_array_free(u->a);u->a=NULL;}return 0;}
static int array_tostring(lua_State*L){lua_array*u=check_array(L,1);char b[256];size_t p=0;p+=(size_t)snprintf(b+p,sizeof(b)-p,"ndarray(shape=(");for(int i=0;i<u->a->nd;i++)p+=(size_t)snprintf(b+p,p<sizeof(b)?sizeof(b)-p:0,"%s%lld%s",i?", ":"",(long long)u->a->dimensions[i],u->a->nd==1?",":"");snprintf(b+(p<sizeof(b)?p:sizeof(b)-1),p<sizeof(b)?sizeof(b)-p:1,"), dtype=%s)",u->a->descr->name);lua_pushstring(L,b);return 1;}
static int array_len(lua_State*L){lua_array*u=check_array(L,1);lua_pushinteger(L,u->a->nd?u->a->dimensions[0]:0);return 1;}

static lua_datetime_scalar *test_datetime_scalar(lua_State *L,int idx){
    lua_datetime_scalar *x=(lua_datetime_scalar*)luaL_testudata(L,idx,DATETIME_MT);
    if(x)return x;
    return (lua_datetime_scalar*)luaL_testudata(L,idx,TIMEDELTA_MT);
}
static int push_datetime_scalar(lua_State *L,int64_t value,const ln_dtype *descr){
    const char *mt=descr->type_num==LN_DATETIME?DATETIME_MT:TIMEDELTA_MT;
    lua_datetime_scalar *x=(lua_datetime_scalar*)lua_newuserdatauv(L,sizeof(*x),0);
    x->value=value;x->descr=descr;luaL_setmetatable(L,mt);return 1;
}
static int datetime_scalar_tostring(lua_State *L){
    lua_datetime_scalar *x=test_datetime_scalar(L,1);if(!x)return luaL_error(L,"invalid datetime scalar");
    const ln_datetime_meta *m=ln_datetime_metadata(x->descr);char buf[192];ln_error e={{0}};
    if(x->descr->type_num==LN_DATETIME && m){
        if(ln_datetime_format_iso8601(x->value,m,m->base,0,LN_DT_TZ_NAIVE,0,LN_DT_CAST_SAME_KIND,buf,sizeof(buf),&e)<0)
            return fail(L,&e);
        lua_pushstring(L,buf);return 1;
    }
    const char *root="timedelta64";
    if(x->value==LN_DATETIME_NAT){if(m&&m->base!=LN_FR_GENERIC)snprintf(buf,sizeof(buf),"%s('NaT','%s')",root,ln_datetime_unit_name(m->base));else snprintf(buf,sizeof(buf),"%s('NaT')",root);}
    else if(m&&m->base!=LN_FR_GENERIC)snprintf(buf,sizeof(buf),"%s(%lld,'%s')",root,(long long)x->value,ln_datetime_unit_name(m->base));
    else snprintf(buf,sizeof(buf),"%s(%lld)",root,(long long)x->value);
    lua_pushstring(L,buf);return 1;
}
static int datetime_scalar_index(lua_State *L){
    lua_datetime_scalar *x=test_datetime_scalar(L,1);const char*k=lua_tostring(L,2);if(!x||!k){lua_pushnil(L);return 1;}
    if(strcmp(k,"value")==0){lua_pushinteger(L,(lua_Integer)x->value);return 1;}
    if(strcmp(k,"dtype")==0){lua_pushstring(L,x->descr->name);return 1;}
    if(strcmp(k,"isnat")==0){lua_pushboolean(L,x->value==LN_DATETIME_NAT);return 1;}
    if(strcmp(k,"unit")==0){const ln_datetime_meta*m=ln_datetime_metadata(x->descr);lua_pushstring(L,m?ln_datetime_unit_name(m->base):"generic");return 1;}
    if(strcmp(k,"multiplier")==0){const ln_datetime_meta*m=ln_datetime_metadata(x->descr);lua_pushinteger(L,m?m->num:1);return 1;}
    if(strcmp(k,"iso")==0 && x->descr->type_num==LN_DATETIME){const ln_datetime_meta*m=ln_datetime_metadata(x->descr);char b[192];ln_error e={{0}};if(ln_datetime_format_iso8601(x->value,m,m->base,0,LN_DT_TZ_NAIVE,0,LN_DT_CAST_SAME_KIND,b,sizeof(b),&e)<0)return fail(L,&e);lua_pushstring(L,b);return 1;}
    lua_pushnil(L);return 1;
}
static int datetime_scalar_eq(lua_State *L){
    lua_datetime_scalar *a=test_datetime_scalar(L,1),*b=test_datetime_scalar(L,2);if(!a||!b){lua_pushboolean(L,0);return 1;}
    if(a->value==LN_DATETIME_NAT||b->value==LN_DATETIME_NAT){lua_pushboolean(L,0);return 1;}
    const ln_dtype *p=ln_promote_dtype(a->descr,b->descr);if(!p){lua_pushboolean(L,0);return 1;}
    const ln_datetime_meta *pm=ln_datetime_metadata(p);int64_t av,bv;ln_error e={{0}};
    if(ln_datetime_cast_value(a->value,ln_datetime_metadata(a->descr),pm,&av,&e)<0||ln_datetime_cast_value(b->value,ln_datetime_metadata(b->descr),pm,&bv,&e)<0){lua_pushboolean(L,0);return 1;}
    lua_pushboolean(L,av==bv);return 1;
}
static const ln_dtype *datetime_dtype_from_unit(lua_State *L,int td,int idx){
    if(lua_gettop(L)<idx||lua_type(L,idx)==LUA_TNIL)return ln_datetime_default_dtype(td);
    const char*u=lua_tostring(L,idx);if(!u)return NULL;char buf[80];snprintf(buf,sizeof(buf),"%s[%s]",td?"timedelta64":"datetime64",u);return ln_dtype_by_name(buf);
}
static int datetime_scalar_ctor_common(lua_State *L,int td){
    int has_unit=lua_gettop(L)>=2&&lua_type(L,2)!=LUA_TNIL;
    const ln_dtype *dt=datetime_dtype_from_unit(L,td,2);if(!dt)return luaL_error(L,"invalid datetime unit");
    int64_t v=0;
    if(lua_type(L,1)==LUA_TSTRING){
        const char*s=lua_tostring(L,1);
        if(td){
            if(strcmp(s,"NaT")==0||strcmp(s,"nat")==0){v=LN_DATETIME_NAT;}
            else return luaL_error(L,"timedelta64 string construction currently supports only 'NaT'; use integer count + unit");
        }else{
            const ln_dtype_descr *parsed=NULL;ln_error e={{0}};int hadtz=0;
            const ln_dtype_descr *req=has_unit?dt:NULL;
            if(ln_datetime_parse_iso8601(s,req,&parsed,&v,&hadtz,&e)<0)return fail(L,&e);
            dt=parsed;
        }
    }
    else {int ok=0;lua_Integer x=lua_tointegerx(L,1,&ok);if(!ok)return luaL_error(L,"datetime value must be an integer count or ISO datetime string");if(!td&&ln_datetime_metadata(dt)->base==LN_FR_GENERIC)return luaL_error(L,"Converting an integer to a NumPy datetime requires a specified unit");v=(int64_t)x;}
    return push_datetime_scalar(L,v,dt);
}
static int np_datetime64(lua_State *L){return datetime_scalar_ctor_common(L,0);}
static int np_timedelta64(lua_State *L){return datetime_scalar_ctor_common(L,1);}
static int push_scalar_at(lua_State*L,const ln_array*a,const ln_intp*idx){ln_error e={{0}};if(ln_string_is_dtype(a->descr)){char *ss=NULL;size_t nn=0;if(ln_array_get_string(a,idx,&ss,&nn,&e)<0)return fail(L,&e);lua_pushlstring(L,ss,nn);free(ss);return 1;}if(a->descr->kind=='M'||a->descr->kind=='m'){double d=0;int64_t iv=0;int isint=0;if(ln_array_get_number(a,idx,&d,&iv,&isint,&e)<0)return fail(L,&e);return push_datetime_scalar(L,iv,a->descr);}if(a->descr->kind=='c'){long double r=0,i=0;if(ln_array_get_complex(a,idx,&r,&i,&e)<0)return fail(L,&e);return push_complex(L,r,i);}double d=0;int64_t iv=0;int isint=0;if(ln_array_get_number(a,idx,&d,&iv,&isint,&e)<0)return fail(L,&e);if(a->descr->type_num==LN_BOOL)lua_pushboolean(L,iv!=0);else if(isint)lua_pushinteger(L,(lua_Integer)iv);else lua_pushnumber(L,d);return 1;}

static int read_lua_integer_value(lua_State *L, int arg, lua_Integer *out) {
    int ok = 0;
    lua_Integer x = lua_tointegerx(L, arg, &ok);
    if (!ok) return luaL_error(L, "index must be an integer");
    *out = x;
    return 0;
}

static int normalize_lua_index_value(lua_State *L, lua_Integer raw, ln_intp dim,
                                     int axis, ln_intp *out) {
    lua_Integer x = raw;
    if (x > 0) x -= 1;
    else if (x < 0) x = (lua_Integer)dim + x;
    else return luaL_error(L, "index 0 is invalid in Lua's 1-based indexing model");
    if (x < 0 || x >= (lua_Integer)dim) {
        char msg[192];
        snprintf(msg,sizeof(msg),
            "index %lld is out of bounds for axis %d with size %lld",
            (long long)raw, axis + 1, (long long)dim);
        return luaL_error(L,"%s",msg);
    }
    *out = (ln_intp)x;
    return 0;
}

static int read_lua_index(lua_State*L,int arg,ln_intp dim,ln_intp*out){
    lua_Integer raw = 0;
    if (read_lua_integer_value(L,arg,&raw)) return 1;
    return normalize_lua_index_value(L,raw,dim,0,out);
}

/*
 * Lua-native replacement for the PySlice_GetIndicesEx call used by NumPy's
 * mapping.c:get_view_from_index. Positive bounds are 1-based; negative bounds
 * count from the end. The stop bound remains exclusive, preserving NumPy's
 * half-open slice model. Internally bounds are converted to Python/NumPy's
 * zero-based convention and adjusted with the same clipping rules.
 */
static int normalize_lua_slice(lua_State *L, const lua_index_spec *s, ln_intp dim,
                               ln_index *out) {
    lua_Integer step = s->has_step ? s->step : 1;
    if (step == 0) return luaL_error(L, "slice step cannot be zero");
    if (step == LLONG_MIN) return luaL_error(L, "slice step is too small");

    lua_Integer start, stop;
    if (step < 0) {
        start = s->has_start ? (s->start > 0 ? s->start - 1 : s->start)
                             : (lua_Integer)dim - 1;
        stop = s->has_stop ? (s->stop > 0 ? s->stop - 1 : s->stop) : -1;

        if (s->has_start) {
            if (start < 0) { start += (lua_Integer)dim; if (start < 0) start = -1; }
            else if (start >= (lua_Integer)dim) start = (lua_Integer)dim - 1;
        }
        if (s->has_stop) {
            if (stop < 0) { stop += (lua_Integer)dim; if (stop < 0) stop = -1; }
            else if (stop >= (lua_Integer)dim) stop = (lua_Integer)dim - 1;
        }
    }
    else {
        start = s->has_start ? (s->start > 0 ? s->start - 1 : s->start) : 0;
        stop = s->has_stop ? (s->stop > 0 ? s->stop - 1 : s->stop)
                           : (lua_Integer)dim;

        if (s->has_start) {
            if (start < 0) { start += (lua_Integer)dim; if (start < 0) start = 0; }
            else if (start > (lua_Integer)dim) start = (lua_Integer)dim;
        }
        if (s->has_stop) {
            if (stop < 0) { stop += (lua_Integer)dim; if (stop < 0) stop = 0; }
            else if (stop > (lua_Integer)dim) stop = (lua_Integer)dim;
        }
    }

    lua_Integer n = 0;
    if (step < 0) {
        if (stop < start) n = (start - stop - 1) / (-step) + 1;
    }
    else {
        if (start < stop) n = (stop - start - 1) / step + 1;
    }

    out->kind = LN_INDEX_SLICE;
    if (n <= 0) {
        /* Matches NumPy mapping.c: empty slices reset to start=0, step=1. */
        out->start = 0;
        out->step = 1;
        out->length = 0;
    }
    else {
        out->start = (ln_intp)start;
        out->step = (ln_intp)step;
        out->length = (ln_intp)n;
    }
    return 0;
}

static lua_index_spec *test_index_spec(lua_State *L, int idx) {
    return (lua_index_spec *)luaL_testudata(L, idx, INDEX_MT);
}

static int push_index_token(lua_State *L, int kind) {
    lua_index_spec *s = (lua_index_spec *)lua_newuserdatauv(L, sizeof(*s), 0);
    memset(s, 0, sizeof(*s));
    s->kind = kind;
    luaL_setmetatable(L, INDEX_MT);
    return 1;
}

static int np_slice(lua_State *L) {
    int top = lua_gettop(L);
    lua_index_spec *s = (lua_index_spec *)lua_newuserdatauv(L, sizeof(*s), 0);
    memset(s, 0, sizeof(*s));
    s->kind = LN_INDEX_SLICE;
    if (top >= 1 && lua_type(L,1) != LUA_TNIL) {
        if (read_lua_integer_value(L,1,&s->start)) return 0;
        if (s->start == 0) return luaL_error(L,"slice bounds use Lua's 1-based indexing; 0 is invalid");
        s->has_start = 1;
    }
    if (top >= 2 && lua_type(L,2) != LUA_TNIL) {
        if (read_lua_integer_value(L,2,&s->stop)) return 0;
        if (s->stop == 0) return luaL_error(L,"slice bounds use Lua's 1-based indexing; 0 is invalid");
        s->has_stop = 1;
    }
    if (top >= 3 && lua_type(L,3) != LUA_TNIL) {
        if (read_lua_integer_value(L,3,&s->step)) return 0;
        if (s->step == 0) return luaL_error(L,"slice step cannot be zero");
        s->has_step = 1;
    }
    luaL_setmetatable(L, INDEX_MT);
    return 1;
}

static void free_built_index(built_index *b) {
    if (!b) return;
    for (int i = 0; i < b->owned_count; ++i) {
        ln_array_free(b->owned[i]);
        b->owned[i] = NULL;
    }
    b->owned_count = 0;
}

static int append_owned_index(built_index *b, ln_array *a) {
    if (b->owned_count >= LN_MAXDIMS * 2 + 1) return -1;
    b->owned[b->owned_count++] = a;
    return 0;
}

static int array_is_integer_index(const ln_array *a) {
    return a && (a->descr->kind == 'i' || a->descr->kind == 'u');
}

static int array_shapes_equal(const ln_array *a, const ln_array *b) {
    if (!a || !b || a->nd != b->nd) return 0;
    for (int i = 0; i < a->nd; ++i) if (a->dimensions[i] != b->dimensions[i]) return 0;
    return 1;
}

/*
 * Lua host parser for mapping.c:prepare_index_noarray.  Python object discovery
 * is replaced with userdata/token checks, while boolean expansion, ellipsis
 * accounting, fancy rank, and scalar-array behavior follow the upstream flow.
 */
static int build_indices(lua_State *L, lua_array *u, int first, int nraw,
                         built_index *out) {
    memset(out,0,sizeof(*out));
    if (nraw > LN_MAXDIMS * 2) return luaL_error(L,"too many indices for array");

    parsed_index raw[LN_MAXDIMS * 2 + 1];
    memset(raw,0,sizeof(raw));
    int raw_num = 0;
    int used_ndim = 0;
    int ellipsis_pos = -1;
    int fancy_ndim = 0;
    int new_ndim = 0;

    /* Exact-shape single boolean mask is mapping.c's dedicated HAS_BOOL path. */
    if (nraw == 1) {
        lua_array *idxu = test_array(L,first);
        if (idxu && idxu->a->descr->type_num == LN_BOOL &&
                array_shapes_equal(u->a,idxu->a)) {
            out->boolean_mask = idxu->a;
            out->result_nd = 1;
            return 0;
        }
    }

    for (int i = 0; i < nraw; ++i) {
        int arg = first + i;
        if (lua_type(L,arg) == LUA_TNUMBER) {
            raw[raw_num].kind = LN_INDEX_INTEGER;
            if (read_lua_integer_value(L,arg,&raw[raw_num].integer)) goto fail;
            used_ndim += 1;
            raw_num += 1;
            continue;
        }
        lua_index_spec *sp = test_index_spec(L,arg);
        if (sp) {
            raw[raw_num].kind = sp->kind;
            if (sp->kind == LN_INDEX_SLICE) {
                raw[raw_num].slice = *sp;
                used_ndim += 1;
                new_ndim += 1;
            }
            else if (sp->kind == LN_INDEX_ELLIPSIS) {
                if (ellipsis_pos >= 0) {
                    luaL_error(L,"an index can only have a single ellipsis");
                    goto fail;
                }
                ellipsis_pos = raw_num;
            }
            else if (sp->kind == LN_INDEX_NEWAXIS) {
                new_ndim += 1;
            }
            else {
                luaL_error(L,"invalid index token");
                goto fail;
            }
            raw_num += 1;
            continue;
        }

        lua_array *idxu = test_array(L,arg);
        if (!idxu) {
            luaL_error(L,
                "only integers, np.slice(...), np.ellipsis, np.newaxis, and integer or boolean ndarrays are valid indices");
            goto fail;
        }
        ln_array *arr = idxu->a;
        raw[raw_num].array = arr;
        if (arr->descr->type_num == LN_BOOL) {
            if (arr->nd == 0) {
                raw[raw_num].kind = LN_INDEX_0D_BOOL;
                if (fancy_ndim < 1) fancy_ndim = 1;
            }
            else {
                /* A non-special boolean index expands to one integer array per axis. */
                raw[raw_num].kind = LN_INDEX_FANCY;
                used_ndim += arr->nd;
                if (fancy_ndim < 1) fancy_ndim = 1;
            }
            raw_num += 1;
            continue;
        }
        if (!array_is_integer_index(arr)) {
            luaL_error(L,"arrays used as indices must be of integer (or boolean) type");
            goto fail;
        }
        if (arr->nd == 0) {
            double d = 0;
            int64_t iv = 0;
            int isint = 0;
            ln_error e={{0}};
            if (ln_array_get_number(arr,NULL,&d,&iv,&isint,&e) < 0) {
                fail(L,&e);
                goto fail;
            }
            if (!isint) {
                luaL_error(L,"0-D integer index is outside Lua/platform integer range");
                goto fail;
            }
            raw[raw_num].kind = LN_INDEX_INTEGER;
            raw[raw_num].integer = (lua_Integer)iv;
            raw[raw_num].array = arr; /* marks scalar-array origin */
            used_ndim += 1;
            raw_num += 1;
            continue;
        }
        raw[raw_num].kind = LN_INDEX_FANCY;
        if (fancy_ndim < arr->nd) fancy_ndim = arr->nd;
        used_ndim += 1;
        raw_num += 1;
    }

    if (used_ndim > u->a->nd) {
        luaL_error(L,
            "too many indices for array: array is %d-dimensional, but %d were indexed",
            u->a->nd,used_ndim);
        goto fail;
    }
    if (ellipsis_pos < 0 && used_ndim < u->a->nd) {
        raw[raw_num].kind = LN_INDEX_ELLIPSIS;
        ellipsis_pos = raw_num++;
    }
    int ellipsis_axes = u->a->nd - used_ndim;
    new_ndim += ellipsis_axes;

    int orig_dim = 0;
    int expanded = 0;
    int all_integer = (nraw > 0);
    int saw_scalar_array = 0;

    for (int i = 0; i < raw_num; ++i) {
        parsed_index *r = &raw[i];
        if (expanded >= LN_MAXDIMS * 2 + 1) {
            luaL_error(L,"too many indices for array");
            goto fail;
        }

        if (r->kind == LN_INDEX_INTEGER) {
            ln_index *ix = &out->indices[expanded++];
            memset(ix,0,sizeof(*ix));
            ix->kind = LN_INDEX_INTEGER;
            if (orig_dim >= u->a->nd ||
                    normalize_lua_index_value(L,r->integer,u->a->dimensions[orig_dim],orig_dim,&ix->value)) {
                goto fail;
            }
            if (r->array) saw_scalar_array = 1;
            orig_dim++;
            continue;
        }
        all_integer = 0;

        if (r->kind == LN_INDEX_SLICE) {
            ln_index *ix = &out->indices[expanded++];
            memset(ix,0,sizeof(*ix));
            if (orig_dim >= u->a->nd || normalize_lua_slice(L,&r->slice,u->a->dimensions[orig_dim],ix)) goto fail;
            ix->boolean_axis_size = -1;
            orig_dim++;
            continue;
        }
        if (r->kind == LN_INDEX_ELLIPSIS) {
            ln_index *ix = &out->indices[expanded++];
            memset(ix,0,sizeof(*ix));
            ix->kind = LN_INDEX_ELLIPSIS;
            ix->value = ellipsis_axes;
            ix->boolean_axis_size = -1;
            orig_dim += ellipsis_axes;
            continue;
        }
        if (r->kind == LN_INDEX_NEWAXIS) {
            ln_index *ix = &out->indices[expanded++];
            memset(ix,0,sizeof(*ix));
            ix->kind = LN_INDEX_NEWAXIS;
            ix->boolean_axis_size = -1;
            continue;
        }
        if (r->kind == LN_INDEX_0D_BOOL) {
            double d=0;
            int64_t iv=0;
            int isint=0;
            ln_error e={{0}};
            if (ln_array_get_number(r->array,NULL,&d,&iv,&isint,&e) < 0) {
                fail(L,&e);
                goto fail;
            }
            int truth = d != 0.0 || (isint && iv != 0);
            ln_intp sh[1] = {truth ? 1 : 0};
            ln_array *synthetic = ln_array_new(1,sh,ln_dtype_by_name("int64"),0,0,&e);
            if (!synthetic) {
                fail(L,&e);
                goto fail;
            }
            if (truth) {
                ln_intp q[1]={0};
                if (ln_array_pack_number(synthetic,q,1.0,1,1,&e) < 0) {
                    ln_array_free(synthetic);
                    fail(L,&e);
                    goto fail;
                }
            }
            if (append_owned_index(out,synthetic) < 0) {
                ln_array_free(synthetic);
                luaL_error(L,"too many temporary advanced indices");
                goto fail;
            }
            ln_index *ix=&out->indices[expanded++];
            memset(ix,0,sizeof(*ix));
            ix->kind=LN_INDEX_0D_BOOL;
            ix->array=synthetic;
            ix->boolean_axis_size=-1;
            out->has_fancy=1;
            continue;
        }
        if (r->kind == LN_INDEX_FANCY && r->array->descr->type_num == LN_BOOL) {
            /* NumPy validates boolean dimensions before nonzero expansion.  Do the
             * same here so a Lua error cannot longjmp past temporary-array cleanup. */
            for (int k=0;k<r->array->nd;k++) {
                if (orig_dim + k >= u->a->nd ||
                        r->array->dimensions[k] != u->a->dimensions[orig_dim+k]) {
                    char msg[256];
                    ln_intp base_size = (orig_dim+k < u->a->nd) ?
                        u->a->dimensions[orig_dim+k] : -1;
                    snprintf(msg,sizeof(msg),
                        "boolean index did not match indexed array along axis %d; size of axis is %lld but size of corresponding boolean axis is %lld",
                        orig_dim+k+1,(long long)base_size,
                        (long long)r->array->dimensions[k]);
                    return luaL_error(L,"%s",msg);
                }
            }

            ln_array *nz[LN_MAXDIMS]={0};
            int nnz=0;
            ln_error e={{0}};
            if (ln_boolean_nonzero_indices(r->array,nz,&nnz,&e) < 0) {
                fail(L,&e);
                goto fail;
            }
            if (expanded + nnz > LN_MAXDIMS * 2 + 1) {
                for (int k=0;k<nnz;k++) ln_array_free(nz[k]);
                luaL_error(L,"too many indices for array");
                goto fail;
            }
            for (int k=0;k<nnz;k++) {
                if (append_owned_index(out,nz[k]) < 0) {
                    for (int q=k;q<nnz;q++) ln_array_free(nz[q]);
                    luaL_error(L,"too many temporary advanced indices");
                    goto fail;
                }
                ln_index *ix=&out->indices[expanded++];
                memset(ix,0,sizeof(*ix));
                ix->kind=LN_INDEX_FANCY;
                ix->array=nz[k];
                ix->boolean_axis_size=r->array->dimensions[k];
                orig_dim++;
            }
            out->has_fancy=1;
            continue;
        }
        if (r->kind == LN_INDEX_FANCY) {
            ln_index *ix=&out->indices[expanded++];
            memset(ix,0,sizeof(*ix));
            ix->kind=LN_INDEX_FANCY;
            ix->array=r->array;
            ix->boolean_axis_size=-1;
            if (orig_dim >= u->a->nd) {
                luaL_error(L,"too many indices for array");
                goto fail;
            }
            orig_dim++;
            out->has_fancy=1;
            continue;
        }
    }

    if (orig_dim != u->a->nd) {
        luaL_error(L,"index did not consume all array dimensions");
        goto fail;
    }
    out->index_num=expanded;
    out->pure_integer=all_integer || (nraw==0 && u->a->nd==0);
    out->result_nd=new_ndim+fancy_ndim;
    out->scalar_array_copy=saw_scalar_array && !out->has_fancy && !out->pure_integer;
    if (out->result_nd > LN_MAXDIMS) {
        luaL_error(L,"number of dimensions must be within [0, %d]",LN_MAXDIMS);
        goto fail;
    }
    return 0;

fail:
    free_built_index(out);
    return 1;
}

static int read_scalar_value(lua_State *L, int arg, double *d, int64_t *iv,
                             int *is_integer) {
    int t = lua_type(L,arg);
    if (t == LUA_TBOOLEAN) {
        *is_integer = 1;
        *iv = lua_toboolean(L,arg) ? 1 : 0;
        *d = (double)*iv;
        return 0;
    }
    if (t == LUA_TNUMBER) {
        int ok = 0;
        *is_integer = lua_isinteger(L,arg);
        *d = (double)lua_tonumberx(L,arg,&ok);
        if (!ok) return luaL_error(L,"assignment value is not numeric");
        *iv = *is_integer ? (int64_t)lua_tointegerx(L,arg,NULL) : 0;
        return 0;
    }
    return luaL_error(L,"assignment currently supports numeric or boolean scalars");
}

static int array_get(lua_State*L){
    lua_array *u = check_array(L,1);
    int nraw = lua_gettop(L) - 1;
    built_index b;
    if (build_indices(L,u,2,nraw,&b)) return 0;

    ln_error e={{0}};
    if (b.boolean_mask) {
        ln_array *r=ln_array_boolean_get(u->a,b.boolean_mask,&e);
        free_built_index(&b);
        if(!r)return fail(L,&e);
        return push_array(L,r);
    }

    if (b.has_fancy) {
        ln_array *r=ln_array_advanced_get(u->a,b.indices,b.index_num,&e);
        free_built_index(&b);
        if(!r)return fail(L,&e);
        return push_array(L,r);
    }

    ln_array *v = ln_array_basic_view(u->a,b.indices,b.index_num,&e);
    if (!v) {
        free_built_index(&b);
        return fail(L,&e);
    }
    if (b.scalar_array_copy) {
        ln_array *copy=ln_array_copy_c(v,&e);
        ln_array_free(v);
        v=copy;
        if(!v){free_built_index(&b);return fail(L,&e);}
    }
    int pure_integer=b.pure_integer;
    free_built_index(&b);
    if (v->nd == 0 && pure_integer) {
        int ret = push_scalar_at(L,v,NULL);
        ln_array_free(v);
        return ret;
    }
    return push_array(L,v);
}

static int assign_indexed(lua_State *L, lua_array *u, int value_arg,
                          int first_index_arg, int nraw) {
    built_index b;
    if (build_indices(L,u,first_index_arg,nraw,&b)) return 0;
    lua_array *value_array=test_array(L,value_arg);
    lua_complex *z=test_complex(L,value_arg);
    int string_scalar=(lua_type(L,value_arg)==LUA_TSTRING && ln_string_is_dtype(u->a->descr));
    double d=0;
    int64_t iv=0;
    int is_integer=0;
    if (!value_array && !z && !string_scalar && read_scalar_value(L,value_arg,&d,&iv,&is_integer)) {
        free_built_index(&b);
        return 0;
    }
    if (z && u->a->descr->kind != 'c') {
        free_built_index(&b);
        return luaL_error(L,"cannot assign complex scalar to non-complex ndarray");
    }

    ln_error e={{0}};
    ln_array scalar_complex,scalar_string;
    ln_clongdouble complex_storage;
    char *string_storage=NULL;
    const ln_array *value_ndarray=value_array?value_array->a:NULL;
    if (string_scalar) {
        memset(&scalar_string,0,sizeof(scalar_string));
        size_t cap=u->a->descr->elsize?u->a->descr->elsize:1;
        string_storage=(char*)calloc(1,cap);
        if(!string_storage){free_built_index(&b);return luaL_error(L,"out of memory");}
        scalar_string.data=string_storage;scalar_string.nd=0;scalar_string.descr=u->a->descr;
        scalar_string.flags=LN_ARRAY_C_CONTIGUOUS|LN_ARRAY_F_CONTIGUOUS|LN_ARRAY_ALIGNED|LN_ARRAY_WRITEABLE;
        size_t nn=0;const char *ss=lua_tolstring(L,value_arg,&nn);
        if(ln_array_pack_string(&scalar_string,NULL,ss,nn,&e)<0){free(string_storage);free_built_index(&b);return fail(L,&e);}
        value_ndarray=&scalar_string;
    }
    if (z) {
        memset(&scalar_complex,0,sizeof(scalar_complex));
        memset(&complex_storage,0,sizeof(complex_storage));
        scalar_complex.data=(char *)&complex_storage;
        scalar_complex.nd=0;
        scalar_complex.descr=u->a->descr;
        scalar_complex.flags=LN_ARRAY_C_CONTIGUOUS|LN_ARRAY_F_CONTIGUOUS|
                             LN_ARRAY_ALIGNED|LN_ARRAY_WRITEABLE;
        if(ln_array_pack_complex(&scalar_complex,NULL,z->real,z->imag,&e)<0){
            free_built_index(&b);return fail(L,&e);
        }
        value_ndarray=&scalar_complex;
    }

    int rc=0;
    if (b.boolean_mask) {
        if (value_ndarray) rc=ln_array_boolean_assign_array(u->a,b.boolean_mask,value_ndarray,&e);
        else rc=ln_array_boolean_assign_scalar(u->a,b.boolean_mask,d,iv,is_integer,&e);
    }
    else if (b.has_fancy) {
        if (value_ndarray) rc=ln_array_advanced_assign_array(u->a,b.indices,b.index_num,value_ndarray,&e);
        else rc=ln_array_advanced_assign_scalar(u->a,b.indices,b.index_num,d,iv,is_integer,&e);
    }
    else {
        ln_array *view=ln_array_basic_view(u->a,b.indices,b.index_num,&e);
        if(!view){free_built_index(&b);return fail(L,&e);}
        if(z) rc=ln_array_assign_complex(view,z->real,z->imag,&e);
        else if(value_ndarray) rc=ln_array_assign_array(view,value_ndarray,&e);
        else rc=ln_array_assign_scalar(view,d,iv,is_integer,&e);
        ln_array_free(view);
    }
    free_built_index(&b);
    free(string_storage);
    if(rc<0)return fail(L,&e);
    return 0;
}

/* Lua method form for multidimensional assignment: a:set(value, indices...). */
static int array_set(lua_State *L) {
    lua_array *u = check_array(L,1);
    if (lua_gettop(L) < 2) return luaL_error(L,"set requires a scalar or ndarray value");
    int nraw = lua_gettop(L) - 2;
    if (assign_indexed(L,u,2,3,nraw)) return 0;
    lua_pushvalue(L,1);
    return 1;
}

/* Bracket assignment supports one-key basic/advanced forms. */
static int array_newindex(lua_State *L) {
    lua_array *u = check_array(L,1);
    int t = lua_type(L,2);
    int valid=(t==LUA_TNUMBER) || (t==LUA_TUSERDATA && (test_index_spec(L,2)||test_array(L,2)));
    if (!valid) {
        return luaL_error(L,"ndarray attributes are read-only; assignment keys must be integer/basic/advanced indices");
    }
    return assign_indexed(L,u,3,2,1);
}

static int push_shape(lua_State*L,const ln_intp*x,int n){lua_createtable(L,n,0);for(int i=0;i<n;i++){lua_pushinteger(L,(lua_Integer)x[i]);lua_seti(L,-2,i+1);}return 1;}
static int array_shape(lua_State*L){return push_shape(L,check_array(L,1)->a->dimensions,check_array(L,1)->a->nd);} 
static int array_strides(lua_State*L){return push_shape(L,check_array(L,1)->a->strides,check_array(L,1)->a->nd);} 
static int array_reshape(lua_State*L);
static int np_sum(lua_State*L);
static int np_prod(lua_State*L);
static int np_mean(lua_State*L);
static int np_matmul(lua_State*L);
static int np_dot(lua_State*L);
static int np_sort(lua_State*L);
static int np_argsort(lua_State*L);
static int np_partition(lua_State*L);
static int np_argpartition(lua_State*L);
static int array_sort_inplace(lua_State*L);
static int array_partition_inplace(lua_State*L);
static int array_transpose(lua_State*L){return np_transpose(L);} 

static int parse_shape(lua_State*L,int idx,ln_intp*dims,int*nd){idx=lua_absindex(L,idx);if(lua_type(L,idx)!=LUA_TTABLE)return luaL_error(L,"shape must be a table");size_t n=lua_rawlen(L,idx);if(n>LN_MAXDIMS)return luaL_error(L,"maximum supported dimension is %d",LN_MAXDIMS);for(size_t i=0;i<n;i++){lua_geti(L,idx,(lua_Integer)i+1);int ok=0;lua_Integer v=lua_tointegerx(L,-1,&ok);lua_pop(L,1);if(!ok)return luaL_error(L,"shape entries must be integers");dims[i]=(ln_intp)v;}*nd=(int)n;return 0;}
static int array_reshape(lua_State*L){return ln_lua_layout_reshape(L);}

static int push_nested(lua_State*L,const ln_array*a,int depth,ln_intp*idx){if(depth==a->nd)return push_scalar_at(L,a,idx);ln_intp n=a->dimensions[depth];lua_createtable(L,(int)n,0);for(ln_intp i=0;i<n;i++){idx[depth]=i;push_nested(L,a,depth+1,idx);lua_seti(L,-2,(lua_Integer)i+1);}return 1;}
static int array_tolist(lua_State*L){lua_array*u=check_array(L,1);luaL_checkstack(L,u->a->nd+8,"array conversion exceeds Lua stack capacity");ln_intp idx[LN_MAXDIMS]={0};return push_nested(L,u->a,0,idx);}

static int array_index(lua_State*L){lua_array*u=check_array(L,1);int t=lua_type(L,2);if(t==LUA_TNUMBER){if(u->a->nd==0)return luaL_error(L,"too many indices for array: array is 0-dimensional");ln_intp ix; if(read_lua_index(L,2,u->a->dimensions[0],&ix))return 0;if(u->a->nd==1){ln_intp idx[]={ix};return push_scalar_at(L,u->a,idx);}ln_error e={{0}};ln_array*v=ln_array_view(u->a,u->a->nd-1,u->a->dimensions+1,u->a->strides+1,u->a->data+ix*u->a->strides[0],&e);if(!v)return fail(L,&e);
    return push_array(L,v);}if(t==LUA_TUSERDATA && (test_index_spec(L,2)||test_array(L,2)))return array_get(L);const char*k=lua_tostring(L,2);if(!k){lua_pushnil(L);return 1;}if(strcmp(k,"shape")==0)return array_shape(L);if(strcmp(k,"strides")==0)return array_strides(L);if(strcmp(k,"ndim")==0){lua_pushinteger(L,u->a->nd);return 1;}if(strcmp(k,"size")==0){lua_pushinteger(L,(lua_Integer)ln_array_size(u->a));return 1;}if(strcmp(k,"dtype")==0){lua_pushstring(L,u->a->descr->name);return 1;}if(strcmp(k,"copy")==0){lua_pushcfunction(L,ln_lua_array_copy);return 1;}if(strcmp(k,"ravel")==0){lua_pushcfunction(L,ln_lua_layout_ravel);return 1;}if(strcmp(k,"flatten")==0){lua_pushcfunction(L,ln_lua_layout_flatten);return 1;}if(strcmp(k,"get")==0){lua_pushcfunction(L,array_get);return 1;}if(strcmp(k,"set")==0){lua_pushcfunction(L,array_set);return 1;}if(strcmp(k,"take")==0){lua_pushcfunction(L,np_take);return 1;}if(strcmp(k,"choose")==0){lua_pushcfunction(L,np_choose);return 1;}if(strcmp(k,"nonzero")==0){lua_pushcfunction(L,np_nonzero);return 1;}if(strcmp(k,"compress")==0){lua_pushcfunction(L,array_compress);return 1;}if(strcmp(k,"put")==0){lua_pushcfunction(L,np_put);return 1;}if(strcmp(k,"reshape")==0){lua_pushcfunction(L,array_reshape);return 1;}if(strcmp(k,"transpose")==0||strcmp(k,"T")==0){if(strcmp(k,"T")==0){lua_settop(L,1);return array_transpose(L);}lua_pushcfunction(L,array_transpose);return 1;}if(strcmp(k,"swapaxes")==0){lua_pushcfunction(L,np_swapaxes);return 1;}if(strcmp(k,"moveaxis")==0){lua_pushcfunction(L,np_moveaxis);return 1;}if(strcmp(k,"squeeze")==0){lua_pushcfunction(L,np_squeeze);return 1;}if(strcmp(k,"flip")==0){lua_pushcfunction(L,np_flip);return 1;}if(strcmp(k,"tile")==0){lua_pushcfunction(L,np_tile);return 1;}if(strcmp(k,"roll")==0){lua_pushcfunction(L,np_roll);return 1;}if(strcmp(k,"rollaxis")==0){lua_pushcfunction(L,np_rollaxis);return 1;}if(strcmp(k,"repeat_elements")==0||strcmp(k,"repeat")==0){lua_pushcfunction(L,np_repeat_elements);return 1;}if(strcmp(k,"tolist")==0){lua_pushcfunction(L,array_tolist);return 1;}if(strcmp(k,"astype")==0){lua_pushcfunction(L,np_astype);return 1;}if(strcmp(k,"count_nonzero")==0){lua_pushcfunction(L,np_count_nonzero);return 1;}if(strcmp(k,"any")==0){lua_pushcfunction(L,np_any);return 1;}if(strcmp(k,"all")==0){lua_pushcfunction(L,np_all);return 1;}if(strcmp(k,"sum")==0){lua_pushcfunction(L,np_sum);return 1;}if(strcmp(k,"nansum")==0){lua_pushcfunction(L,np_nansum);return 1;}if(strcmp(k,"nanprod")==0){lua_pushcfunction(L,np_nanprod);return 1;}if(strcmp(k,"cumsum")==0){lua_pushcfunction(L,np_cumsum);return 1;}if(strcmp(k,"cumprod")==0){lua_pushcfunction(L,np_cumprod);return 1;}if(strcmp(k,"nancumsum")==0){lua_pushcfunction(L,np_nancumsum);return 1;}if(strcmp(k,"nancumprod")==0){lua_pushcfunction(L,np_nancumprod);return 1;}if(strcmp(k,"nanmean")==0){lua_pushcfunction(L,np_nanmean);return 1;}if(strcmp(k,"nanvar")==0){lua_pushcfunction(L,np_nanvar);return 1;}if(strcmp(k,"nanstd")==0){lua_pushcfunction(L,np_nanstd);return 1;}if(strcmp(k,"prod")==0){lua_pushcfunction(L,np_prod);return 1;}if(strcmp(k,"mean")==0){lua_pushcfunction(L,np_mean);return 1;}if(strcmp(k,"var")==0){lua_pushcfunction(L,np_var);return 1;}if(strcmp(k,"std")==0){lua_pushcfunction(L,np_std);return 1;}if(strcmp(k,"nanmin")==0){lua_pushcfunction(L,np_nanmin);return 1;}if(strcmp(k,"nanmax")==0){lua_pushcfunction(L,np_nanmax);return 1;}if(strcmp(k,"nanargmin")==0){lua_pushcfunction(L,np_nanargmin);return 1;}if(strcmp(k,"nanargmax")==0){lua_pushcfunction(L,np_nanargmax);return 1;}if(strcmp(k,"min")==0||strcmp(k,"amin")==0){lua_pushcfunction(L,np_amin);return 1;}if(strcmp(k,"max")==0||strcmp(k,"amax")==0){lua_pushcfunction(L,np_amax);return 1;}if(strcmp(k,"argmin")==0){lua_pushcfunction(L,np_argmin);return 1;}if(strcmp(k,"argmax")==0){lua_pushcfunction(L,np_argmax);return 1;}if(strcmp(k,"ptp")==0){lua_pushcfunction(L,np_ptp);return 1;}if(strcmp(k,"median")==0){lua_pushcfunction(L,np_median);return 1;}if(strcmp(k,"nanmedian")==0){lua_pushcfunction(L,np_nanmedian);return 1;}if(strcmp(k,"matmul")==0){lua_pushcfunction(L,np_matmul);return 1;}if(strcmp(k,"dot")==0){lua_pushcfunction(L,np_dot);return 1;}if(strcmp(k,"sort")==0){lua_pushcfunction(L,array_sort_inplace);return 1;}if(strcmp(k,"argsort")==0){lua_pushcfunction(L,np_argsort);return 1;}if(strcmp(k,"partition")==0){lua_pushcfunction(L,array_partition_inplace);return 1;}if(strcmp(k,"argpartition")==0){lua_pushcfunction(L,np_argpartition);return 1;}if(strcmp(k,"searchsorted")==0){lua_pushcfunction(L,np_searchsorted);return 1;}lua_pushnil(L);return 1;}

static const char *
registered_binary_name(ln_binary_op op)
{
    switch(op){
        case LN_OP_ADD:return "add";
        case LN_OP_SUBTRACT:return "subtract";
        case LN_OP_MULTIPLY:return "multiply";
        case LN_OP_TRUE_DIVIDE:return "true_divide";
        case LN_OP_EQUAL:return "equal";
        case LN_OP_NOT_EQUAL:return "not_equal";
        case LN_OP_LESS:return "less";
        case LN_OP_LESS_EQUAL:return "less_equal";
        case LN_OP_GREATER:return "greater";
        case LN_OP_GREATER_EQUAL:return "greater_equal";
        case LN_OP_LOGICAL_AND:return "logical_and";
        case LN_OP_LOGICAL_OR:return "logical_or";
        case LN_OP_LOGICAL_XOR:return "logical_xor";
        case LN_OP_MAXIMUM:return "maximum";
        case LN_OP_MINIMUM:return "minimum";
        case LN_OP_FLOOR_DIVIDE:return "floor_divide";
        case LN_OP_REMAINDER:return "remainder";
        case LN_OP_POWER:return "power";
        case LN_OP_BITWISE_AND:return "bitwise_and";
        case LN_OP_BITWISE_OR:return "bitwise_or";
        case LN_OP_BITWISE_XOR:return "bitwise_xor";
        case LN_OP_FMAX:return "fmax";
        case LN_OP_FMIN:return "fmin";
        case LN_OP_COPYSIGN:return "copysign";
        case LN_OP_ARCTAN2:return "arctan2";
        case LN_OP_HYPOT:return "hypot";
        default:return NULL;
    }
}

static int
parse_binary_ufunc_operand(lua_State *L,int idx,ln_ufunc_operand *op)
{
    memset(op,0,sizeof(*op));
    lua_array *a=test_array(L,idx);
    if(a){op->kind=LN_UFUNC_OPERAND_ARRAY;op->array=a->a;return 1;}
    lua_complex *z=test_complex(L,idx);
    if(z){op->kind=LN_UFUNC_WEAK_COMPLEX;op->real=z->real;op->imag=z->imag;return 1;}
    int t=lua_type(L,idx);
    if(t==LUA_TBOOLEAN){op->kind=LN_UFUNC_WEAK_BOOL;op->boolean=lua_toboolean(L,idx);return 1;}
    if(t==LUA_TNUMBER){
        if(lua_isinteger(L,idx)){op->kind=LN_UFUNC_WEAK_INT;op->integer=(int64_t)lua_tointegerx(L,idx,NULL);}
        else {int ok=0;lua_Number v=lua_tonumberx(L,idx,&ok);if(!ok)return 0;op->kind=LN_UFUNC_WEAK_FLOAT;op->floating=(double)v;}
        return 1;
    }
    if(t==LUA_TSTRING){op->kind=LN_UFUNC_WEAK_STRING;op->string=lua_tolstring(L,idx,&op->string_len);return 1;}
    return 0;
}

static int binary_meta(lua_State*L,ln_binary_op op)
{
    lua_array *a=test_array(L,1),*b=test_array(L,2);
    if(!a&&!b)return luaL_error(L,"operand must include ndarray");
    const char *name=registered_binary_name(op);
    const ln_ufunc *u=name?ln_ufunc_by_name(name):NULL;
    if(!u||u->nin!=2||u->nout!=1)
        return luaL_error(L,"internal error: binary ufunc is not registered");
    ln_ufunc_operand operands[2];
    if(!parse_binary_ufunc_operand(L,1,&operands[0])||!parse_binary_ufunc_operand(L,2,&operands[1]))
        return luaL_error(L,"operand must be ndarray, string, number, boolean, or luaray.complex");
    ln_array *r=NULL;
    ln_error e={{0}};
    if(ln_ufunc_execute_operands(u,operands,&r,NULL,&e)<0)return fail(L,&e);
    return push_array(L,r);
}
static int array_add(lua_State*L){return binary_meta(L,LN_OP_ADD);}
static int array_sub(lua_State*L){return binary_meta(L,LN_OP_SUBTRACT);}
static int array_mul(lua_State*L){return binary_meta(L,LN_OP_MULTIPLY);}
static int array_div(lua_State*L){return binary_meta(L,LN_OP_TRUE_DIVIDE);}
static int array_idiv(lua_State*L){return binary_meta(L,LN_OP_FLOOR_DIVIDE);}
static int array_mod(lua_State*L){return binary_meta(L,LN_OP_REMAINDER);}
static int array_pow(lua_State*L){return binary_meta(L,LN_OP_POWER);}
static int array_band(lua_State*L){return binary_meta(L,LN_OP_BITWISE_AND);}
static int array_bor(lua_State*L){return binary_meta(L,LN_OP_BITWISE_OR);}
static int array_bxor(lua_State*L){return binary_meta(L,LN_OP_BITWISE_XOR);}
static int array_unm(lua_State*L){
    lua_array *a=check_array(L,1); ln_error e={{0}};
    const ln_ufunc *u=ln_ufunc_by_name("negative");
    ln_array *r=NULL;
    if(u){const ln_array *inputs[1]={a->a};if(ln_ufunc_execute(u,inputs,&r,NULL,&e)<0)r=NULL;}
    else r=ln_unary_array_op_where(a->a,NULL,LN_OP_NEGATIVE,&e);
    if(!r)return fail(L,&e);
    return push_array(L,r);
}

typedef struct ufunc_call_options {
    lua_array *out;
    const ln_array *where;
    ln_array where_scalar;
    uint8_t where_scalar_value;
    int out_arg_index;
    int options_table_index;
} ufunc_call_options;

static int
parse_where_value(lua_State *L, int idx, ufunc_call_options *opts)
{
    int t=lua_type(L,idx);
    if(t==LUA_TNIL || t==LUA_TNONE){opts->where=NULL;return 0;}
    if(t==LUA_TBOOLEAN || t==LUA_TNUMBER){
        int truth;
        if(t==LUA_TBOOLEAN) truth=lua_toboolean(L,idx);
        else {
            int ok=0;
            lua_Number v=lua_tonumberx(L,idx,&ok);
            if(!ok)return luaL_error(L,"where scalar must be numeric or boolean");
            truth=(v!=0);
        }
        if(truth){
            opts->where=NULL;  /* scalar True is the unmasked fast path */
        }
        else {
            memset(&opts->where_scalar,0,sizeof(opts->where_scalar));
            opts->where_scalar_value=0;
            opts->where_scalar.data=(char *)&opts->where_scalar_value;
            opts->where_scalar.nd=0;
            opts->where_scalar.descr=ln_dtype_by_num(LN_BOOL);
            opts->where_scalar.flags=LN_ARRAY_C_CONTIGUOUS|LN_ARRAY_F_CONTIGUOUS|
                                     LN_ARRAY_ALIGNED;
            opts->where=&opts->where_scalar;
        }
        return 0;
    }
    lua_array *w=test_array(L,idx);
    if(!w)return luaL_error(L,"where must be a bool ndarray, scalar number/boolean, or nil");
    opts->where=w->a;
    return 0;
}

static int
parse_ufunc_call_options(lua_State *L, int idx, ufunc_call_options *opts)
{
    memset(opts,0,sizeof(*opts));
    int top=lua_gettop(L);
    if(top<idx || lua_type(L,idx)==LUA_TNIL)return 0;
    int t=lua_type(L,idx);
    if(t==LUA_TUSERDATA){
        opts->out=test_array(L,idx);
        if(!opts->out)return luaL_error(L,"out must be an ndarray");
        opts->out_arg_index=idx;
        if(top>=idx+1 && parse_where_value(L,idx+1,opts))return 1;
        return 0;
    }
    if(t!=LUA_TTABLE)return luaL_error(L,"ufunc options must be {out=..., where=...} or an output ndarray");
    opts->options_table_index=lua_absindex(L,idx);
    lua_getfield(L,opts->options_table_index,"out");
    if(lua_type(L,-1)!=LUA_TNIL){
        opts->out=test_array(L,-1);
        if(!opts->out){lua_pop(L,1);return luaL_error(L,"out must be an ndarray or nil");}
    }
    lua_pop(L,1);
    lua_getfield(L,opts->options_table_index,"where");
    int rc=parse_where_value(L,-1,opts);
    lua_pop(L,1);
    return rc;
}

static int
push_existing_out(lua_State *L, const ufunc_call_options *opts)
{
    if(opts->out_arg_index){lua_pushvalue(L,opts->out_arg_index);return 1;}
    lua_getfield(L,opts->options_table_index,"out");
    return 1;
}

static int
binary_function_named(lua_State *L, const char *name)
{
    if(lua_gettop(L)<2||lua_type(L,1)==LUA_TNIL||lua_type(L,2)==LUA_TNIL)
        return luaL_error(L,"binary operation requires two non-nil operands");
    const ln_ufunc *u=ln_ufunc_by_name(name);
    if(!u||u->nin!=2||u->nout!=1)
        return luaL_error(L,"internal error: binary ufunc '%s' is not registered",name);
    ufunc_call_options opts;
    if(parse_ufunc_call_options(L,3,&opts))return 0;
    ln_ufunc_operand operands[2];
    int parsed[2]={parse_binary_ufunc_operand(L,1,&operands[0]),
                   parse_binary_ufunc_operand(L,2,&operands[1])};
    int both_scalars=parsed[0]&&parsed[1]&&
        operands[0].kind!=LN_UFUNC_OPERAND_ARRAY&&operands[1].kind!=LN_UFUNC_OPERAND_ARRAY;
    for(int i=0;i<2;++i)if(!parsed[i]||both_scalars){
        operands[i].array=broadcast_arg(L,i+1);
        operands[i].kind=LN_UFUNC_OPERAND_ARRAY;
    }
    ln_array *out=opts.out?opts.out->a:NULL;
    ln_error e={{0}};
    if(ln_ufunc_execute_operands(u,operands,&out,opts.where,&e)<0)return fail(L,&e);
    if(opts.out)return push_existing_out(L,&opts);
    return push_array(L,out);
}

static int
unary_function_named(lua_State *L, const char *name)
{
    ufunc_call_options opts;
    if(parse_ufunc_call_options(L,2,&opts))return 0;
    const ln_array *a=broadcast_arg(L,1);
    ln_error e={{0}};
    const ln_ufunc *u=ln_ufunc_by_name(name);
    if(!u||u->nin!=1||u->nout!=1)
        return luaL_error(L,"internal error: unary ufunc '%s' is not registered",name);
    const ln_array *inputs[1]={a};
    ln_array *out=opts.out?opts.out->a:NULL;
    if(ln_ufunc_execute(u,inputs,&out,opts.where,&e)<0)return fail(L,&e);
    if(opts.out)return push_existing_out(L,&opts);
    return push_array(L,out);
}

static int np_floor(lua_State*L){return unary_function_named(L,"floor");}
static int np_ceil(lua_State*L){return unary_function_named(L,"ceil");}
static int np_trunc(lua_State*L){return unary_function_named(L,"trunc");}
static int np_rint(lua_State*L){return unary_function_named(L,"rint");}
static int np_fabs(lua_State*L){return unary_function_named(L,"fabs");}
static int np_conjugate(lua_State*L){return unary_function_named(L,"conjugate");}
static int np_square(lua_State*L){return unary_function_named(L,"square");}
static int np_reciprocal(lua_State*L){return unary_function_named(L,"reciprocal");}
static int np_degrees(lua_State*L){return unary_function_named(L,"degrees");}
static int np_radians(lua_State*L){return unary_function_named(L,"radians");}
static int np_conj(lua_State*L){return unary_function_named(L,"conj");}
static int np_rad2deg(lua_State*L){return unary_function_named(L,"rad2deg");}
static int np_deg2rad(lua_State*L){return unary_function_named(L,"deg2rad");}
static int np_fmod(lua_State*L){return binary_function_named(L,"fmod");}
static int np_float_power(lua_State*L){return binary_function_named(L,"float_power");}
static int np_negative(lua_State*L){return unary_function_named(L,"negative");}
static int np_absolute(lua_State*L){return unary_function_named(L,"absolute");}
static int np_positive(lua_State*L){return unary_function_named(L,"positive");}
static int np_sign(lua_State*L){return unary_function_named(L,"sign");}
static int np_logical_not(lua_State*L){return unary_function_named(L,"logical_not");}
static int np_isnan(lua_State*L){return unary_function_named(L,"isnan");}
static int np_isinf(lua_State*L){return unary_function_named(L,"isinf");}
static int np_isfinite(lua_State*L){return unary_function_named(L,"isfinite");}
static int np_isnat(lua_State*L){return unary_function_named(L,"isnat");}
static int np_signbit(lua_State*L){return unary_function_named(L,"signbit");}
static int np_sqrt(lua_State*L){return unary_function_named(L,"sqrt");}
static int np_exp(lua_State*L){return unary_function_named(L,"exp");}
static int np_log(lua_State*L){return unary_function_named(L,"log");}
static int np_sin(lua_State*L){return unary_function_named(L,"sin");}
static int np_cos(lua_State*L){return unary_function_named(L,"cos");}
static int np_tan(lua_State*L){return unary_function_named(L,"tan");}
static int np_sinh(lua_State*L){return unary_function_named(L,"sinh");}
static int np_cosh(lua_State*L){return unary_function_named(L,"cosh");}
static int np_tanh(lua_State*L){return unary_function_named(L,"tanh");}
static int np_exp2(lua_State*L){return unary_function_named(L,"exp2");}
static int np_log2(lua_State*L){return unary_function_named(L,"log2");}
static int np_log10(lua_State*L){return unary_function_named(L,"log10");}
static int np_expm1(lua_State*L){return unary_function_named(L,"expm1");}
static int np_log1p(lua_State*L){return unary_function_named(L,"log1p");}
static int np_cbrt(lua_State*L){return unary_function_named(L,"cbrt");}
static int np_arcsin(lua_State*L){return unary_function_named(L,"arcsin");}
static int np_arccos(lua_State*L){return unary_function_named(L,"arccos");}
static int np_arctan(lua_State*L){return unary_function_named(L,"arctan");}
static int np_arcsinh(lua_State*L){return unary_function_named(L,"arcsinh");}
static int np_arccosh(lua_State*L){return unary_function_named(L,"arccosh");}
static int np_arctanh(lua_State*L){return unary_function_named(L,"arctanh");}


typedef struct multiout_ufunc_options {
    lua_array *out[2];
    int has_out_table;
    int options_table_index;
    const ln_array *where;
    ln_array where_scalar;
    uint8_t where_scalar_value;
} multiout_ufunc_options;

static int
parse_multiout_options(lua_State *L,int idx,multiout_ufunc_options *o)
{
    memset(o,0,sizeof(*o));
    if(lua_gettop(L)<idx || lua_type(L,idx)==LUA_TNIL)return 0;
    if(lua_type(L,idx)!=LUA_TTABLE)return luaL_error(L,"multi-output ufunc options must be a table");
    o->options_table_index=lua_absindex(L,idx);
    lua_getfield(L,o->options_table_index,"out");
    if(lua_type(L,-1)!=LUA_TNIL){
        if(lua_type(L,-1)!=LUA_TTABLE){lua_pop(L,1);return luaL_error(L,"out must be a table containing two ndarrays/nil values");}
        o->has_out_table=1;
        int outtab=lua_absindex(L,-1);
        for(int i=0;i<2;++i){
            lua_geti(L,outtab,i+1);
            if(lua_type(L,-1)!=LUA_TNIL){
                o->out[i]=test_array(L,-1);
                if(!o->out[i]){lua_pop(L,2);return luaL_error(L,"each out entry must be an ndarray or nil");}
            }
            lua_pop(L,1);
        }
    }
    lua_pop(L,1);
    lua_getfield(L,o->options_table_index,"where");
    ufunc_call_options tmp;
    memset(&tmp,0,sizeof(tmp));
    if(parse_where_value(L,-1,&tmp)){lua_pop(L,1);return 1;}
    o->where=tmp.where;
    if(tmp.where==&tmp.where_scalar){
        o->where_scalar=tmp.where_scalar;
        o->where_scalar_value=tmp.where_scalar_value;
        o->where_scalar.data=(char*)&o->where_scalar_value;
        o->where=&o->where_scalar;
    }
    lua_pop(L,1);
    return 0;
}

static int
push_multiout_result(lua_State *L,const multiout_ufunc_options *o,int slot,ln_array *a,int allocated)
{
    if(!allocated){
        lua_getfield(L,o->options_table_index,"out");
        lua_geti(L,-1,slot+1);
        /* Remove the temporary out table, leave the userdata. */
        lua_remove(L,-2);
        return 1;
    }
    return push_array(L,a);
}

static int
multiout_unary_function(lua_State *L,const char *name)
{
    lua_array *a=check_array(L,1);
    multiout_ufunc_options o;
    if(parse_multiout_options(L,2,&o))return 0;
    const ln_ufunc *u=ln_ufunc_by_name(name);
    if(!u)return luaL_error(L,"unknown ufunc %s",name);
    const ln_array *inputs[1]={a->a};
    ln_array *outs[2]={o.out[0]?o.out[0]->a:NULL,o.out[1]?o.out[1]->a:NULL};
    int allocated[2]={outs[0]==NULL,outs[1]==NULL};
    ln_error e={{0}};
    if(ln_ufunc_execute(u,inputs,outs,o.where,&e)<0)return fail(L,&e);
    push_multiout_result(L,&o,0,outs[0],allocated[0]);
    push_multiout_result(L,&o,1,outs[1],allocated[1]);
    return 2;
}

static int
multiout_binary_function(lua_State *L,const char *name)
{
    lua_array *a=check_array(L,1),*b=check_array(L,2);
    multiout_ufunc_options o;
    if(parse_multiout_options(L,3,&o))return 0;
    const ln_ufunc *u=ln_ufunc_by_name(name);
    if(!u)return luaL_error(L,"unknown ufunc %s",name);
    const ln_array *inputs[2]={a->a,b->a};
    ln_array *outs[2]={o.out[0]?o.out[0]->a:NULL,o.out[1]?o.out[1]->a:NULL};
    int allocated[2]={outs[0]==NULL,outs[1]==NULL};
    ln_error e={{0}};
    if(ln_ufunc_execute(u,inputs,outs,o.where,&e)<0)return fail(L,&e);
    push_multiout_result(L,&o,0,outs[0],allocated[0]);
    push_multiout_result(L,&o,1,outs[1],allocated[1]);
    return 2;
}

static int np_frexp(lua_State *L){return multiout_unary_function(L,"frexp");}
static int np_modf(lua_State *L){return multiout_unary_function(L,"modf");}
static int np_divmod(lua_State *L){return multiout_binary_function(L,"divmod");}


static int
generic_binary_ufunc_function(lua_State *L,const char *name)
{
    lua_array *a=check_array(L,1);
    ufunc_call_options opts;
    if(parse_ufunc_call_options(L,3,&opts))return 0;
    const ln_ufunc *u=ln_ufunc_by_name(name);
    if(!u||u->nin!=2||u->nout!=1)return luaL_error(L,"unknown binary ufunc %s",name);

    const ln_array *barr=NULL;
    ln_array scalar; unsigned char storage[sizeof(long double)]={0};
    lua_array *b=test_array(L,2);
    if(b)barr=b->a;
    else{
        memset(&scalar,0,sizeof(scalar));scalar.data=(char*)storage;scalar.nd=0;
        scalar.flags=LN_ARRAY_WRITEABLE|LN_ARRAY_ALIGNED|LN_ARRAY_C_CONTIGUOUS|LN_ARRAY_F_CONTIGUOUS;
        ln_error pe={{0}};
        if(lua_type(L,2)==LUA_TBOOLEAN){
            scalar.descr=ln_dtype_by_num(LN_BOOL);
            if(ln_array_pack_number(&scalar,NULL,(double)lua_toboolean(L,2),(int64_t)lua_toboolean(L,2),1,&pe)<0)return fail(L,&pe);
        }else{
            int isint=lua_isinteger(L,2),ok=0; double v=(double)lua_tonumberx(L,2,&ok);
            if(!ok)return luaL_error(L,"second operand must be an ndarray, integer, or number");
            scalar.descr=isint?ln_dtype_by_name("int64"):ln_dtype_by_num(LN_DOUBLE);
            int64_t iv=isint?(int64_t)lua_tointegerx(L,2,NULL):0;
            if(ln_array_pack_number(&scalar,NULL,v,iv,isint,&pe)<0)return fail(L,&pe);
        }
        barr=&scalar;
    }
    const ln_array *inputs[2]={a->a,barr};
    ln_array *out=opts.out?opts.out->a:NULL;
    ln_error e={{0}};
    if(ln_ufunc_execute(u,inputs,&out,opts.where,&e)<0)return fail(L,&e);
    if(opts.out)return push_existing_out(L,&opts);
    return push_array(L,out);
}

static int np_ldexp(lua_State *L){return generic_binary_ufunc_function(L,"ldexp");}
static int np_arctan2(lua_State*L){return binary_function_named(L,"arctan2");}
static int np_hypot(lua_State*L){return binary_function_named(L,"hypot");}



static int
advance_coord_local(int nd,const ln_intp*dims,ln_intp*idx)
{
    for(int d=nd-1;d>=0;--d){idx[d]++;if(idx[d]<dims[d])return 1;idx[d]=0;}
    return 0;
}

static char *
array_ptr_local(const ln_array *a,const ln_intp*idx)
{
    char *p=a->data;for(int d=0;d<a->nd;++d)p+=idx[d]*a->strides[d];return p;
}

static const ln_dtype *
infer_datetime_descr_from_string_array(const ln_array *a,ln_error *e)
{
    const ln_dtype *acc=NULL;ln_intp total=ln_array_size(a);ln_intp idx[LN_MAXDIMS]={0};
    for(ln_intp k=0;k<total;k++){
        char *ss=NULL;size_t nn=0;if(ln_array_get_string(a,idx,&ss,&nn,e)<0)return NULL;
        const ln_dtype *d=NULL;int64_t v=0;int tz=0;int rc=ln_datetime_parse_iso8601(ss,NULL,&d,&v,&tz,e);free(ss);if(rc<0)return NULL;
        const ln_datetime_meta*m=ln_datetime_metadata(d);if(m&&m->base!=LN_FR_GENERIC){if(!acc)acc=d;else{acc=ln_common_dtype_descr(acc,d);if(!acc){if(e)snprintf(e->message,sizeof(e->message),"datetime strings do not have a common unit");return NULL;}}}
        advance_coord_local(a->nd,a->dimensions,idx);
    }
    return acc?acc:ln_datetime_default_dtype(0);
}

static const ln_dtype *
resolve_astype_target(const ln_array *src,const ln_dtype *requested,ln_error *e)
{
    if(!requested)return NULL;
    if(ln_string_is_dtype(requested)&&ln_string_nchars(requested)==0){
        size_t w=ln_legacy_string_width_for_dtype(src->descr);if(!w&&ln_array_size(src)!=0){if(e)snprintf(e->message,sizeof(e->message),"cannot resolve unsized string cast");return NULL;}
        return ln_string_make_dtype(requested->type_num==LN_UNICODE,w,requested->byteorder,e);
    }
    if(requested->type_num==LN_DATETIME){
        const ln_datetime_meta*m=ln_datetime_metadata(requested);
        if(m&&m->base==LN_FR_GENERIC&&ln_string_is_dtype(src->descr))return infer_datetime_descr_from_string_array(src,e);
    }
    return requested;
}

static ln_array *
array_cast_new(const ln_array *src,const ln_dtype *requested,ln_casting casting,char order,ln_error *e)
{
    const ln_dtype *dst=resolve_astype_target(src,requested,e);if(!dst)return NULL;
    if(casting==LN_SAME_VALUE_CASTING){
        if(!ln_dtype_supports_same_value(src->descr,dst)){
            if(e)snprintf(e->message,sizeof(e->message),
                "Cannot cast array data from dtype('%s') to dtype('%s') according to the rule 'same_value'",
                src->descr->name,dst->name);
            return NULL;
        }
    }
    else if(!ln_dtype_can_cast(src->descr,dst,casting)){
        if(e)snprintf(e->message,sizeof(e->message),
            "Cannot cast array data from dtype('%s') to dtype('%s') according to the rule '%s'",
            src->descr->name,dst->name,ln_casting_name(casting));
        return NULL;
    }
    int fort=(order=='F') ||
        ((order=='A'||order=='K') &&
         (src->flags&LN_ARRAY_F_CONTIGUOUS) && !(src->flags&LN_ARRAY_C_CONTIGUOUS));
    ln_array*out=ln_array_new(src->nd,src->dimensions,dst,fort,0,e);if(!out)return NULL;
    ln_intp total=ln_array_size(src);ln_intp idx[LN_MAXDIMS]={0};
    /* For order='K', preserve the relative stride permutation when copying
     * noncontiguous views.  NumPy uses the same fastest-to-slowest axis
     * ordering (based on the absolute source strides). */
    if(order=='K' && total>0 && src->nd>1 &&
       !(src->flags & (LN_ARRAY_C_CONTIGUOUS|LN_ARRAY_F_CONTIGUOUS))) {
        int axes[LN_MAXDIMS];
        for(int i=0;i<src->nd;i++)axes[i]=i;
        for(int i=1;i<src->nd;i++) {
            int a=axes[i],j=i;
            uint64_t sa=src->strides[a]<0 ? (uint64_t)(-(src->strides[a]+1))+1u : (uint64_t)src->strides[a];
            while(j>0) {
                int b=axes[j-1];
                uint64_t sb=src->strides[b]<0 ? (uint64_t)(-(src->strides[b]+1))+1u : (uint64_t)src->strides[b];
                if(sb<sa || (sb==sa && b>a))break;
                axes[j]=b;j--;
            }
            axes[j]=a;
        }
        ln_intp st=(ln_intp)dst->elsize;
        for(int j=0;j<src->nd;j++){
            int a=axes[j];out->strides[a]=st;
            if(src->dimensions[a]>0)st*=src->dimensions[a];
        }
        ln_update_contiguous_flags(out);
    }
    for(ln_intp k=0;k<total;k++){
        const char*sp=array_ptr_local(src,idx);char*dp=array_ptr_local(out,idx);
        if(casting==LN_SAME_VALUE_CASTING &&
           ln_cast_same_value_one(sp,src->descr,dst,e)<0){ln_array_free(out);return NULL;}
        /* Preserve LuaRay's existing astype contract for numeric -> generic
         * datetime. Array construction has a separate raw-array cast path in
         * ln_creation_convert; do not impose this legacy API restriction there. */
        if(dst->type_num==LN_DATETIME&&ln_datetime_metadata(dst)->base==LN_FR_GENERIC&&
                src->descr->kind!='M'&&src->descr->kind!='m'&&!ln_string_is_dtype(src->descr)) {
            int64_t ticks;
            if(ln_cast_strided_numeric(sp,0,src->descr,(char *)&ticks,0,dst,1,e)<0){ln_array_free(out);return NULL;}
            if(ticks!=LN_DATETIME_NAT){snprintf(e->message,sizeof(e->message),"Cannot convert a NumPy datetime value other than NaT with generic units");ln_array_free(out);return NULL;}
        }
        if(ln_cast_strided_numeric(sp,0,src->descr,dp,0,dst,1,e)<0){ln_array_free(out);return NULL;}
        advance_coord_local(src->nd,src->dimensions,idx);
    }
    return out;
}

static int
read_casting_arg_ex(lua_State *L,int idx,ln_casting def,ln_casting *out,int allow_same_value)
{
    *out=def;
    if(lua_gettop(L)<idx||lua_type(L,idx)==LUA_TNIL)return 0;
    const char *name=NULL;
    int table=lua_type(L,idx)==LUA_TTABLE;
    if(lua_type(L,idx)==LUA_TSTRING)name=lua_tostring(L,idx);
    else if(table){
        lua_getfield(L,idx,"casting");
        if(lua_type(L,-1)!=LUA_TNIL)name=luaL_checklstring(L,-1,NULL);
        if(!name){lua_pop(L,1);return 0;}
    }
    else return luaL_error(L,"casting must be a string or options table");
    int rc=allow_same_value?ln_parse_casting_same_value(name,out):ln_parse_casting(name,out);
    if(rc<0){if(table)lua_pop(L,1);return luaL_error(L,allow_same_value?
        "casting must be one of 'no', 'equiv', 'safe', 'same_kind', 'unsafe', or 'same_value'":
        "casting must be one of 'no', 'equiv', 'safe', 'same_kind', or 'unsafe'");}
    if(table)lua_pop(L,1);
    return 0;
}

static int
read_casting_arg(lua_State *L,int idx,ln_casting def,ln_casting *out)
{ return read_casting_arg_ex(L,idx,def,out,0); }

static int np_astype(lua_State*L){
    lua_array*a=check_array(L,1);
    const char*name=luaL_checklstring(L,2,NULL);
    const ln_dtype*dt=ln_dtype_by_name(name);
    if(!dt)return luaL_error(L,"unsupported dtype");
    ln_casting casting;
    if(read_casting_arg_ex(L,3,LN_UNSAFE_CASTING,&casting,1))return 0;
    int copy=1;char order='K';
    if(lua_type(L,3)==LUA_TTABLE){
        lua_getfield(L,3,"copy");
        if(lua_type(L,-1)!=LUA_TNIL){
            if(lua_type(L,-1)!=LUA_TBOOLEAN){lua_pop(L,1);return luaL_error(L,"copy must be a boolean");}
            copy=lua_toboolean(L,-1);
        }
        lua_pop(L,1);
        lua_getfield(L,3,"order");
        if(lua_type(L,-1)!=LUA_TNIL){
            if(lua_type(L,-1)!=LUA_TSTRING){lua_pop(L,1);return luaL_error(L,"order must be 'C', 'F', 'A', or 'K'");}
            const char*o=lua_tostring(L,-1);
            if(!o || !o[0] || o[1]){lua_pop(L,1);return luaL_error(L,"order must be 'C', 'F', 'A', or 'K'");}
            order=(char)toupper((unsigned char)o[0]);
            if(order!='C' && order!='F' && order!='A' && order!='K'){
                lua_pop(L,1);return luaL_error(L,"order must be 'C', 'F', 'A', or 'K'");
            }
        }
        lua_pop(L,1);
    }
    ln_error e={{0}};
    const ln_dtype*resolved=resolve_astype_target(a->a,dt,&e);
    if(!resolved)return fail(L,&e);
    const int same=ln_dtype_cast_safety(a->a->descr,resolved)==LN_NO_CASTING;
    const int c=(a->a->flags&LN_ARRAY_C_CONTIGUOUS)!=0;
    const int f=(a->a->flags&LN_ARRAY_F_CONTIGUOUS)!=0;
    if(!copy && same &&
       (order=='K' || (order=='A'&&(c||f)) || (order=='C'&&c) || (order=='F'&&f))){
        lua_pushvalue(L,1);return 1;
    }
    ln_array*r=array_cast_new(a->a,dt,casting,order,&e);
    if(!r)return fail(L,&e);
    return push_array(L,r);
}

static int np_can_cast(lua_State *L){
    const ln_dtype *from=NULL,*to=NULL;
    lua_array *a=test_array(L,1);
    lua_datetime_scalar *ds=test_datetime_scalar(L,1);
    if(a)from=a->a->descr;
    else if(ds)from=ds->descr;
    else if(lua_type(L,1)==LUA_TSTRING)from=ln_dtype_by_name(lua_tostring(L,1));
    else return luaL_error(L,"can_cast does not accept untyped Lua scalars; pass a dtype name or ndarray");
    if(!from)return luaL_error(L,"unsupported source dtype");
    if(lua_type(L,2)!=LUA_TSTRING)return luaL_error(L,"destination must be a dtype name");
    to=ln_dtype_by_name(lua_tostring(L,2));if(!to)return luaL_error(L,"unsupported destination dtype");
    ln_casting casting;if(read_casting_arg(L,3,LN_SAFE_CASTING,&casting))return 0;
    lua_pushboolean(L,ln_dtype_can_cast(from,to,casting));return 1;
}

/* NumPy 2.x dtype-promotion API.  DType strings and ndarray operands are
 * strong; native Lua numeric/boolean/complex values are NEP 50 weak scalars.
 * We deliberately keep the host-independent promotion rules in ln_core.c. */
static int np_promote_types(lua_State *L) {
    if(lua_type(L,1)!=LUA_TSTRING || lua_type(L,2)!=LUA_TSTRING)
        return luaL_error(L,"promote_types expects two dtype names");
    const ln_dtype *a=ln_dtype_by_name(lua_tostring(L,1));
    const ln_dtype *b=ln_dtype_by_name(lua_tostring(L,2));
    if(!a || !b)return luaL_error(L,"unsupported dtype in promote_types");
    const ln_dtype *out=ln_promote_dtype(a,b);
    if(!out)return luaL_error(L,"the input dtypes have no common dtype");
    lua_pushstring(L,out->name);
    return 1;
}

/* The scalar-sensitive counterpart of dtype promotion: ndarray operands
 * retain their descriptor, while native Lua values follow NumPy's Python
 * scalar range rules rather than their host storage width. */
static int np_min_scalar_type(lua_State *L) {
    if(lua_gettop(L)!=1)return luaL_error(L,"min_scalar_type expects one value");
    lua_array *a=test_array(L,1);
    if(a){lua_pushstring(L,a->a->descr->name);return 1;}
    lua_datetime_scalar *ds=test_datetime_scalar(L,1);
    if(ds){lua_pushstring(L,ds->descr->name);return 1;}
    const char *dtype=NULL;
    if(lua_type(L,1)==LUA_TBOOLEAN)dtype="bool";
    else if(lua_isinteger(L,1)){
        lua_Integer value=lua_tointegerx(L,1,NULL);
        if(value<0)dtype=value>=INT8_MIN?"int8":value>=INT16_MIN?"int16":value>=INT32_MIN?"int32":"int64";
        else {
            uint64_t v=(uint64_t)value;
            dtype=v<=UINT8_MAX?"uint8":v<=UINT16_MAX?"uint16":v<=UINT32_MAX?"uint32":"uint64";
        }
    }
    else if(lua_type(L,1)==LUA_TNUMBER){
        double value=lua_tonumberx(L,1,NULL),mag=fabs(value);
        dtype=!isfinite(value)||mag<65000.0?"float16":mag<3.4e38?"float32":"float64";
    }
    else if(lua_type(L,1)==LUA_TSTRING){
        size_t nbytes=0,nchars=0;
        const char *value=lua_tolstring(L,1,&nbytes);
        ln_error e={{0}};
        if(ln_string_utf8_codepoints(value,nbytes,&nchars,&e)<0)return fail(L,&e);
        /* NumPy's Python-str scalar uses Unicode codepoints, never UTF-8
         * byte length, and selects <U1 for an empty string. */
        const ln_dtype *udt=ln_string_make_dtype(1,nchars?nchars:1,'=',&e);
        if(!udt)return fail(L,&e);
        lua_pushstring(L,udt->name);
        return 1;
    }
    else {
        lua_complex *z=test_complex(L,1);
        if(z){
            long double r=fabsl(z->real),i=fabsl(z->imag);
            dtype=isfinite(z->real)&&isfinite(z->imag)&&r<3.4e38L&&i<3.4e38L?
                  "complex64":"complex128";
        }
    }
    if(!dtype)return luaL_error(L,"min_scalar_type expects a scalar or ndarray");
    lua_pushstring(L,dtype);return 1;
}

/* Class-oriented NumPy issubdtype adapted to Lua's dtype-name interface.
 * Right-hand abstract NumPy scalar classes are represented by their names
 * ("integer", "number", "generic", etc.).  Concrete names continue to
 * resolve through the same native dtype registry as can_cast and astype. */
enum {
    SUB_GENERIC=1u<<0, SUB_NUMBER=1u<<1, SUB_INTEGER=1u<<2,
    SUB_SIGNED=1u<<3, SUB_UNSIGNED=1u<<4, SUB_INEXACT=1u<<5,
    SUB_FLOAT=1u<<6, SUB_COMPLEX=1u<<7, SUB_FLEXIBLE=1u<<8,
    SUB_CHARACTER=1u<<9, SUB_BYTES=1u<<10, SUB_UNICODE=1u<<11,
    SUB_DATETIME=1u<<12, SUB_TIMEDELTA=1u<<13, SUB_BOOL=1u<<14,
    SUB_OBJECT=1u<<15, SUB_VOID=1u<<16
};

static unsigned subtype_mask_for_category(const char *name){
    static const struct {const char *name;unsigned own,parents;} groups[]={
        {"generic",SUB_GENERIC,0},
        {"number",SUB_NUMBER,SUB_GENERIC},
        {"integer",SUB_INTEGER,SUB_NUMBER|SUB_GENERIC},
        {"signedinteger",SUB_SIGNED,SUB_INTEGER|SUB_NUMBER|SUB_GENERIC},
        {"unsignedinteger",SUB_UNSIGNED,SUB_INTEGER|SUB_NUMBER|SUB_GENERIC},
        {"inexact",SUB_INEXACT,SUB_NUMBER|SUB_GENERIC},
        {"floating",SUB_FLOAT,SUB_INEXACT|SUB_NUMBER|SUB_GENERIC},
        {"complexfloating",SUB_COMPLEX,SUB_INEXACT|SUB_NUMBER|SUB_GENERIC},
        {"flexible",SUB_FLEXIBLE,SUB_GENERIC},
        {"character",SUB_CHARACTER,SUB_FLEXIBLE|SUB_GENERIC},
        {"bytes_",SUB_BYTES,SUB_CHARACTER|SUB_FLEXIBLE|SUB_GENERIC},
        {"str_",SUB_UNICODE,SUB_CHARACTER|SUB_FLEXIBLE|SUB_GENERIC},
        {"datetime64",SUB_DATETIME,SUB_GENERIC},
        {"timedelta64",SUB_TIMEDELTA,SUB_SIGNED|SUB_INTEGER|SUB_NUMBER|SUB_GENERIC},
        {"bool_",SUB_BOOL,SUB_GENERIC},
        {"object_",SUB_OBJECT,SUB_GENERIC},
        {"void",SUB_VOID,SUB_FLEXIBLE|SUB_GENERIC}
    };
    for(size_t k=0;k<sizeof(groups)/sizeof(groups[0]);k++)
        if(strcmp(name,groups[k].name)==0)return groups[k].own|groups[k].parents;
    return 0;
}

static unsigned subtype_mask_for_dtype(const ln_dtype *dt){
    unsigned mask=SUB_GENERIC;
    if(!dt)return 0;
    switch(dt->kind){
        case 'b':return mask|SUB_BOOL;
        case 'i':return mask|SUB_NUMBER|SUB_INTEGER|SUB_SIGNED;
        case 'u':return mask|SUB_NUMBER|SUB_INTEGER|SUB_UNSIGNED;
        case 'f':return mask|SUB_NUMBER|SUB_INEXACT|SUB_FLOAT;
        case 'c':return mask|SUB_NUMBER|SUB_INEXACT|SUB_COMPLEX;
        case 'S':return mask|SUB_FLEXIBLE|SUB_CHARACTER|SUB_BYTES;
        case 'U':return mask|SUB_FLEXIBLE|SUB_CHARACTER|SUB_UNICODE;
        case 'M':return mask|SUB_DATETIME;
        case 'm':return mask|SUB_NUMBER|SUB_INTEGER|SUB_SIGNED|SUB_TIMEDELTA;
        case 'V':return mask|SUB_FLEXIBLE|SUB_VOID;
        case 'O':return mask|SUB_OBJECT;
        default:return mask;
    }
}

static int np_issubdtype(lua_State *L){
    if(lua_gettop(L)!=2 || lua_type(L,1)!=LUA_TSTRING || lua_type(L,2)!=LUA_TSTRING)
        return luaL_error(L,"issubdtype expects two dtype or scalar-class names");
    const char *left=lua_tostring(L,1),*right=lua_tostring(L,2);
    unsigned lc=subtype_mask_for_category(left),rc=subtype_mask_for_category(right);
    const ln_dtype *ld=lc?NULL:ln_dtype_by_name(left);
    const ln_dtype *rd=rc?NULL:ln_dtype_by_name(right);
    if((!lc&&!ld)||(!rc&&!rd))return luaL_error(L,"unsupported dtype or scalar-class name");
    int yes=0;
    if(rc){unsigned bits=lc?lc:subtype_mask_for_dtype(ld);
        /* The category's least-significant own bit denotes the class itself.
         * This also handles abstract-class to abstract-class comparisons. */
        unsigned own=rc & (~rc+1u);
        /* Each category uses a unique own bit, but inheritance masks can
         * contain lower bits: derive own from the canonical category name. */
        if(strcmp(right,"number")==0)own=SUB_NUMBER;
        else if(strcmp(right,"integer")==0)own=SUB_INTEGER;
        else if(strcmp(right,"signedinteger")==0)own=SUB_SIGNED;
        else if(strcmp(right,"unsignedinteger")==0)own=SUB_UNSIGNED;
        else if(strcmp(right,"inexact")==0)own=SUB_INEXACT;
        else if(strcmp(right,"floating")==0)own=SUB_FLOAT;
        else if(strcmp(right,"complexfloating")==0)own=SUB_COMPLEX;
        else if(strcmp(right,"flexible")==0)own=SUB_FLEXIBLE;
        else if(strcmp(right,"character")==0)own=SUB_CHARACTER;
        else if(strcmp(right,"bytes_")==0)own=SUB_BYTES;
        else if(strcmp(right,"str_")==0)own=SUB_UNICODE;
        else if(strcmp(right,"datetime64")==0)own=SUB_DATETIME;
        else if(strcmp(right,"timedelta64")==0)own=SUB_TIMEDELTA;
        else if(strcmp(right,"bool_")==0)own=SUB_BOOL;
        else if(strcmp(right,"object_")==0)own=SUB_OBJECT;
        else if(strcmp(right,"void")==0)own=SUB_VOID;
        yes=(bits&own)!=0;
    }
    else if(!lc){
        /* Byteorder and flexible-string width do not alter the scalar class. */
        yes=ld->type_num==rd->type_num && ld->kind==rd->kind;
    }
    else {
        /* Some leaf scalar classes (str_, bytes_, bool_, datetime64,
         * timedelta64) have concrete DTypes with the same scalar type. */
        unsigned leaf=subtype_mask_for_dtype(rd);
        unsigned which=rd->kind=='S'?SUB_BYTES:rd->kind=='U'?SUB_UNICODE:
            rd->kind=='b'?SUB_BOOL:rd->kind=='M'?SUB_DATETIME:
            rd->kind=='m'?SUB_TIMEDELTA:rd->kind=='O'?SUB_OBJECT:
            rd->kind=='V'?SUB_VOID:0;
        yes=which && (lc&leaf&which)!=0;
    }
    lua_pushboolean(L,yes);
    return 1;
}

static int np_result_type(lua_State *L) {
    int n=lua_gettop(L),weak_kind=0; /* bool=1, integer=2, float=3, complex=4 */
    const ln_dtype *strong=NULL;
    if(n==0)return luaL_error(L,"result_type requires at least one argument");
    /* Multi-argument NumPy promotion sorts by dtype kind before resolving.
     * Sequential left-folding loses information, e.g. int8, uint16,
     * float16 must resolve float32 (not float64). */
    for(int pass=0;pass<6;pass++) for(int i=1;i<=n;i++) {
        const ln_dtype *current=NULL;
        lua_array *u=test_array(L,i);
        lua_datetime_scalar *ds=test_datetime_scalar(L,i);
        if(u)current=u->a->descr;
        else if(ds)current=ds->descr;
        else if(lua_type(L,i)==LUA_TSTRING) {
            current=ln_dtype_by_name(lua_tostring(L,i));
            if(!current)return luaL_error(L,"unsupported dtype in result_type");
        }
        else {
            int kind=0;
            if(lua_type(L,i)==LUA_TBOOLEAN)kind=1;
            else if(lua_type(L,i)==LUA_TNUMBER)
                kind=lua_isinteger(L,i)?2:3;
            else if(test_complex(L,i))kind=4;
            else return luaL_error(L,"result_type expects dtypes, ndarrays, or numeric Lua scalars");
            if(kind>weak_kind)weak_kind=kind;
            continue;
        }
        int priority=current->kind=='c'?0:current->kind=='f'?1:
                     current->kind=='u'?2:current->kind=='i'?3:
                     current->kind=='b'?4:5;
        if(pass!=priority)continue;
        strong=strong?ln_promote_dtype(strong,current):current;
        if(!strong)return luaL_error(L,"the input dtypes have no common dtype");
    }
    if(!strong) {
        static const char *defaults[]={"", "bool", "int64", "float64", "complex128"};
        strong=ln_dtype_by_name(defaults[weak_kind]);
    }
    else if(weak_kind>0) {
        const char kind=strong->kind;
        const ln_dtype *extra=NULL;
        if(weak_kind==2 && kind=='b')extra=ln_dtype_by_name("int64");
        else if(weak_kind==3 && kind!='f' && kind!='c')extra=ln_dtype_by_name("float64");
        else if(weak_kind==4 && kind!='c') {
            if(kind=='f' && strong->elsize <= sizeof(float))
                extra=ln_dtype_by_name("complex64");
            else extra=ln_dtype_by_name("complex128");
        }
        if(extra)strong=ln_promote_dtype(strong,extra);
        if(!strong)return luaL_error(L,"the input dtypes have no common dtype");
    }
    lua_pushstring(L,strong->name);
    return 1;
}

static int infer_table_shape(lua_State*L,int idx,int depth,ln_intp*dims,int*nd){idx=lua_absindex(L,idx);if(lua_type(L,idx)!=LUA_TTABLE){if(depth>*nd)*nd=depth;return 0;}if(depth>=LN_MAXDIMS)return luaL_error(L,"maximum supported dimension is %d",LN_MAXDIMS);size_t n=lua_rawlen(L,idx);if(dims[depth]==-1)dims[depth]=(ln_intp)n;else if(dims[depth]!=(ln_intp)n)return luaL_error(L,"setting an array element with a sequence: inhomogeneous shape");if(n==0){if(depth+1>*nd)*nd=depth+1;return 0;}for(size_t i=1;i<=n;i++){lua_geti(L,idx,(lua_Integer)i);int ist=lua_type(L,-1)==LUA_TTABLE;if(i==1){if(infer_table_shape(L,-1,depth+1,dims,nd)){lua_pop(L,1);return 1;}}else{if(ist!=(depth+1<*nd)){/* deeper validation below catches most cases */}if(infer_table_shape(L,-1,depth+1,dims,nd)){lua_pop(L,1);return 1;}}lua_pop(L,1);}return 0;}

static int scan_dtype(lua_State*L,int idx,int*has_complex,int*has_float,int*has_int,int*has_bool,int*has_string){idx=lua_absindex(L,idx);int t=lua_type(L,idx);if(t==LUA_TTABLE){size_t n=lua_rawlen(L,idx);for(size_t i=1;i<=n;i++){lua_geti(L,idx,(lua_Integer)i);if(scan_dtype(L,-1,has_complex,has_float,has_int,has_bool,has_string)){lua_pop(L,1);return 1;}lua_pop(L,1);}return 0;}if(test_complex(L,idx)){*has_complex=1;return 0;}if(t==LUA_TBOOLEAN){*has_bool=1;return 0;}if(t==LUA_TNUMBER){if(lua_isinteger(L,idx))*has_int=1;else *has_float=1;return 0;}if(t==LUA_TSTRING){*has_string=1;return 0;}return luaL_error(L,"array elements must be numbers, booleans, strings, or luaray.complex values");}

static int lua_scalar_string_value(lua_State *L,int idx,const char **out,size_t *out_n,int *needs_pop);

static int fill_table(lua_State*L,int idx,ln_array*a,int depth,ln_intp*indices){idx=lua_absindex(L,idx);if(depth==a->nd){int t=lua_type(L,idx);ln_error e={{0}};lua_datetime_scalar*ds=test_datetime_scalar(L,idx);if(ds){if(!(a->descr->kind=='M'||a->descr->kind=='m'))return luaL_error(L,"datetime scalar requires datetime/timedelta destination dtype");int64_t v=ds->value;if(ds->descr!=a->descr){if(ln_datetime_cast_value(v,ln_datetime_metadata(ds->descr),ln_datetime_metadata(a->descr),&v,&e)<0)return fail(L,&e);}return ln_array_set_number(a,indices,0,v,1,&e)<0?fail(L,&e):0;}lua_complex*z=test_complex(L,idx);if(ln_string_is_dtype(a->descr)&&(z||t==LUA_TBOOLEAN||t==LUA_TNUMBER||t==LUA_TSTRING)){const char*ss=NULL;size_t nn=0;int pop=0;if(lua_scalar_string_value(L,idx,&ss,&nn,&pop))return 1;int rc=ln_array_pack_string(a,indices,ss,nn,&e);if(pop)lua_pop(L,1);return rc<0?fail(L,&e):0;}if(z)return ln_array_pack_complex(a,indices,z->real,z->imag,&e)<0?fail(L,&e):0;if(t==LUA_TBOOLEAN){int64_t v=lua_toboolean(L,idx);return ln_array_pack_number(a,indices,0,v,1,&e)<0?fail(L,&e):0;}if(t==LUA_TNUMBER){int isint=lua_isinteger(L,idx);int ok=0;double d=lua_tonumberx(L,idx,&ok);int64_t iv=isint?(int64_t)lua_tointegerx(L,idx,NULL):0;if(!ok)return luaL_error(L,"array element is not numeric");return ln_array_pack_number(a,indices,d,iv,isint,&e)<0?fail(L,&e):0;}if(t==LUA_TSTRING && ln_string_is_dtype(a->descr)){size_t nn=0;const char*ss=lua_tolstring(L,idx,&nn);return ln_array_pack_string(a,indices,ss,nn,&e)<0?fail(L,&e):0;}if(t==LUA_TSTRING && a->descr->type_num==LN_DATETIME){const char*ss=lua_tostring(L,idx);const ln_dtype_descr*pd=NULL;int64_t vv=0;int tz=0;if(ln_datetime_parse_iso8601(ss,a->descr,&pd,&vv,&tz,&e)<0)return fail(L,&e);return ln_array_pack_number(a,indices,0,vv,1,&e)<0?fail(L,&e):0;}return luaL_error(L,"array element type unsupported");}if(lua_type(L,idx)!=LUA_TTABLE)return luaL_error(L,"inhomogeneous array shape");size_t n=lua_rawlen(L,idx);if((ln_intp)n!=a->dimensions[depth])return luaL_error(L,"inhomogeneous array shape");for(size_t i=1;i<=n;i++){indices[depth]=(ln_intp)i-1;lua_geti(L,idx,(lua_Integer)i);if(fill_table(L,-1,a,depth+1,indices)){lua_pop(L,1);return 1;}lua_pop(L,1);}return 0;}

static const ln_dtype* dtype_arg(lua_State*L,int idx,const ln_dtype*def){if(lua_gettop(L)<idx||lua_type(L,idx)==LUA_TNIL)return def;const char*s=lua_tostring(L,idx);if(!s)return NULL;return ln_dtype_by_name(s);}

static int infer_temporal_descr(lua_State *L,int idx,int timedelta,const ln_dtype_descr **acc){
    idx=lua_absindex(L,idx);int t=lua_type(L,idx);
    if(t==LUA_TTABLE){size_t n=lua_rawlen(L,idx);for(size_t i=1;i<=n;i++){lua_geti(L,idx,(lua_Integer)i);if(infer_temporal_descr(L,-1,timedelta,acc)){lua_pop(L,1);return 1;}lua_pop(L,1);}return 0;}
    lua_datetime_scalar *ds=test_datetime_scalar(L,idx);
    const ln_dtype_descr *d=NULL;ln_error e={{0}};
    if(ds){if((ds->descr->type_num==LN_TIMEDELTA)!=timedelta)return luaL_error(L,"mixed datetime64/timedelta64 values cannot discover a generic temporal dtype");d=ds->descr;}
    else if(!timedelta&&t==LUA_TSTRING){int64_t v=0;int tz=0;if(ln_datetime_parse_iso8601(lua_tostring(L,idx),NULL,&d,&v,&tz,&e)<0)return fail(L,&e);}
    else if(timedelta&&t==LUA_TSTRING&&strcmp(lua_tostring(L,idx),"NaT")==0)d=ln_datetime_default_dtype(1);
    else return luaL_error(L,"generic temporal dtype discovery requires temporal scalars or datetime strings");
    const ln_datetime_meta *m=ln_datetime_metadata(d);
    if(m&&m->base==LN_FR_GENERIC)return 0;
    if(!*acc){*acc=d;return 0;}
    const ln_dtype_descr *common=ln_common_dtype_descr(*acc,d);if(!common)return luaL_error(L,"temporal values do not have a common dtype");*acc=common;return 0;
}


static int
lua_scalar_string_value(lua_State *L,int idx,const char **out,size_t *out_n,int *needs_pop)
{
    idx=lua_absindex(L,idx);*needs_pop=0;
    if(lua_type(L,idx)==LUA_TSTRING){*out=lua_tolstring(L,idx,out_n);return 0;}
    if(lua_type(L,idx)==LUA_TBOOLEAN){*out=lua_toboolean(L,idx)?"True":"False";*out_n=strlen(*out);return 0;}
    lua_complex *z=test_complex(L,idx);
    if(z){char b[192];int n=snprintf(b,sizeof(b),"(%Lg%s%Lgj)",z->real,signbit(z->imag)?"":"+",z->imag);if(n<0)return luaL_error(L,"could not format complex value");lua_pushlstring(L,b,(size_t)n);*out=lua_tolstring(L,-1,out_n);*needs_pop=1;return 0;}
    if(lua_type(L,idx)==LUA_TNUMBER){*out=lua_tolstring(L,idx,out_n);*needs_pop=0;return 0;}
    return luaL_error(L,"string dtype conversion requires strings, numbers, booleans, or luaray.complex values");
}

static int
infer_string_width_any(lua_State *L,int idx,int unicode_kind,size_t *maxw)
{
    idx=lua_absindex(L,idx);int t=lua_type(L,idx);
    if(t==LUA_TTABLE){size_t n=lua_rawlen(L,idx);for(size_t i=1;i<=n;i++){lua_geti(L,idx,(lua_Integer)i);if(infer_string_width_any(L,-1,unicode_kind,maxw)){lua_pop(L,1);return 1;}lua_pop(L,1);}return 0;}
    const char *ss=NULL;size_t nb=0;int pop=0;if(lua_scalar_string_value(L,idx,&ss,&nb,&pop))return 1;
    size_t w=nb;ln_error e={{0}};if(unicode_kind&&ln_string_utf8_codepoints(ss,nb,&w,&e)<0){if(pop)lua_pop(L,1);return fail(L,&e);}if(w>*maxw)*maxw=w;if(pop)lua_pop(L,1);return 0;
}


static int np_array_legacy(lua_State*L){
    luaL_checkstack(L,2*LN_MAXDIMS+16,"nested array construction exceeds Lua stack capacity");
    ln_intp dims[LN_MAXDIMS];for(int i=0;i<LN_MAXDIMS;i++)dims[i]=-1;int nd=0;
    if(infer_table_shape(L,1,0,dims,&nd))return 0;
    const ln_dtype*dt=NULL;
    if(lua_gettop(L)>=2&&lua_type(L,2)!=LUA_TNIL){
        dt=dtype_arg(L,2,NULL);if(!dt)return luaL_error(L,"unsupported dtype");
        const ln_datetime_meta *tm=ln_datetime_metadata(dt);
        if(tm&&tm->base==LN_FR_GENERIC&&lua_type(L,1)==LUA_TTABLE){const ln_dtype_descr *found=NULL;if(infer_temporal_descr(L,1,dt->type_num==LN_TIMEDELTA,&found))return 0;if(found)dt=found;}
        if(ln_string_is_dtype(dt)&&ln_string_nchars(dt)==0){size_t w=0;if(infer_string_width_any(L,1,dt->type_num==LN_UNICODE,&w))return 0;ln_error se={{0}};dt=ln_string_make_dtype(dt->type_num==LN_UNICODE,w?w:1,dt->byteorder,&se);if(!dt)return fail(L,&se);}
    }else{
        int hc=0,hf=0,hi=0,hb=0,hs=0;if(scan_dtype(L,1,&hc,&hf,&hi,&hb,&hs))return 0;
        if(hs){
            size_t w=0;if(infer_string_width_any(L,1,1,&w))return 0;
            /* NumPy legacy discovery promotes mixed text/numeric sequences to
             * Unicode sized for the *discovered numeric dtype*, not merely the
             * values present (e.g. int64 + U -> U21, float64 + U -> U32). */
            if(hb&&w<5)w=5;
            if(hi&&w<21)w=21;
            if(hf&&w<32)w=32;
            if(hc&&w<64)w=64;
            ln_error se={{0}};dt=ln_string_make_dtype(1,w?w:1,'=',&se);if(!dt)return fail(L,&se);
        }else dt=hc?ln_dtype_by_num(LN_CDOUBLE):(hf?ln_dtype_by_num(LN_DOUBLE):(hi?ln_dtype_by_name("int64"):(hb?ln_dtype_by_num(LN_BOOL):ln_dtype_by_num(LN_DOUBLE))));
    }
    ln_error e={{0}};ln_array*a=ln_array_new(nd,dims,dt,0,0,&e);if(!a)return fail(L,&e);
    push_array(L,a);ln_intp idx[LN_MAXDIMS]={0};if(fill_table(L,1,a,0,idx))return 0;return 1;
}


static int np_array(lua_State *L) {
    if(test_array(L,1)||test_datetime_scalar(L,1)||lua_gettop(L)>2||lua_type(L,2)==LUA_TTABLE)
        return ln_lua_array_constructor(L);
    return np_array_legacy(L);
}

/* NumPy concatenate/stack: the Lua boundary parses 1-based axes and
 * optional ndarray/table operands; the join/casting loop is host-neutral C. */
static int
join_function(lua_State *L, int stack)
{
    int nargs=lua_gettop(L);
    luaL_checktype(L,1,LUA_TTABLE);
    size_t n=lua_rawlen(L,1);
    if (!n) return luaL_error(L,"need at least one array to concatenate/stack");
    if (n > (SIZE_MAX / sizeof(const ln_array *)))
        return luaL_error(L,"too many input arrays");
    const ln_array **inputs=(const ln_array **)lua_newuserdatauv(L,n*sizeof(*inputs),0);
    int array_nd=-1;
    for (size_t i=0;i<n;++i) {
        lua_geti(L,1,(lua_Integer)i+1);
        if (lua_type(L,-1)==LUA_TTABLE) {
            /* Array conversion is native and owns its allocation as userdata. */
            lua_pushcfunction(L,np_array);
            lua_pushvalue(L,-2);
            if (lua_pcall(L,1,1,0)!=LUA_OK)
                return luaL_error(L,"cannot convert input array %llu: %s",
                    (unsigned long long)i+1,lua_tostring(L,-1));
            lua_remove(L,-2);
        }
        lua_array *u=test_array(L,-1);
        if(!u)return luaL_error(L,"input %llu must be an ndarray or Lua array table",
                               (unsigned long long)i+1);
        inputs[i]=u->a;
        if(i==0)array_nd=u->a->nd;
        /* Keep converted array userdata rooted on the Lua stack until return. */
    }
    lua_Integer raw_axis=1; int flatten=0, options_index=0;
    if (nargs>=2 && lua_type(L,2)!=LUA_TNIL) {
        if (lua_type(L,2)==LUA_TTABLE) {
            options_index=2;
            lua_getfield(L,2,"axis");
            if(lua_type(L,-1)==LUA_TBOOLEAN)flatten=!lua_toboolean(L,-1);
            else if(lua_type(L,-1)!=LUA_TNIL)raw_axis=luaL_checkinteger(L,-1);
            lua_pop(L,1);
        }
        else if(lua_type(L,2)==LUA_TBOOLEAN)flatten=!lua_toboolean(L,2);
        else raw_axis=luaL_checkinteger(L,2);
    }
    if (nargs>=3 && lua_type(L,3)==LUA_TTABLE)options_index=3;
    if (!stack && array_nd==0 && !flatten)return luaL_error(L,"zero-dimensional arrays cannot be concatenated");
    if (stack && flatten) return luaL_error(L,"stack axis must be an integer");
    int axis=0;
    if (flatten) {
        axis=-1;
    }
    else if (normalize_lua_axis(L,raw_axis,array_nd + (stack!=0),&axis)) return 0;
    ln_casting casting=LN_SAME_KIND_CASTING;
    const ln_dtype_descr *dtype=NULL;
    lua_array *out=NULL;
    if (options_index) {
        lua_getfield(L,options_index,"casting");
        if(lua_type(L,-1)!=LUA_TNIL) {
            const char *name=luaL_checklstring(L,-1,NULL);
            if(ln_parse_casting(name,&casting)<0)return luaL_error(L,"unsupported casting policy");
        }
        lua_pop(L,1);
        lua_getfield(L,options_index,"dtype");
        if(lua_type(L,-1)!=LUA_TNIL) {
            const char *name=luaL_checklstring(L,-1,NULL);
            dtype=ln_dtype_by_name(name);
            if(!dtype)return luaL_error(L,"unsupported output dtype");
        }
        lua_pop(L,1);
        lua_getfield(L,options_index,"out");
        if(lua_type(L,-1)!=LUA_TNIL) {
            out=test_array(L,-1);
            if(!out)return luaL_error(L,"out must be a LuaRay ndarray");
        }
        lua_pop(L,1);
    }
    ln_error e={{0}};
    ln_array *result=ln_join_arrays(inputs,n,axis,stack,dtype,casting,out?out->a:NULL,&e);
    if(!result)return fail(L,&e);
    if(out) { lua_getfield(L,options_index,"out"); return 1; }
    return push_array(L,result);
}

static int np_concatenate(lua_State *L) { return join_function(L,0); }
static int np_stack(lua_State *L) { return join_function(L,1); }

/* NumPy 2.5.3 shape_base.py: hstack, vstack, dstack, column_stack.
 * Convert sequence entries to ndarrays, create short-lived rank-adjusted
 * views, then delegate copying, DType promotion and casting to ln_join.
 * The Lua stack owns all temporary conversions/views, including on errors. */
typedef enum { LN_HSTACK, LN_VSTACK, LN_DSTACK, LN_COLUMN_STACK } ln_stack_kind;
static int shape_stack_function(lua_State *L, ln_stack_kind kind) {
    int nargs=lua_gettop(L);
    if((kind==LN_DSTACK || kind==LN_COLUMN_STACK) && nargs>1)
        return luaL_error(L,"dstack/column_stack accepts only the input sequence");
    luaL_checktype(L,1,LUA_TTABLE);
    size_t n=lua_rawlen(L,1);
    if(n==0) return luaL_error(L,"need at least one array to stack");
    if(n>SIZE_MAX/sizeof(const ln_array*))return luaL_error(L,"too many input arrays");
    if(nargs>2 || (nargs==2 && lua_type(L,2)!=LUA_TNIL && lua_type(L,2)!=LUA_TTABLE))
        return luaL_error(L,"stack options must be a table with dtype/casting");
    const ln_dtype_descr *dtype=NULL;
    ln_casting casting=LN_SAME_KIND_CASTING;
    if(nargs==2 && lua_type(L,2)==LUA_TTABLE) {
        lua_getfield(L,2,"dtype");
        if(lua_type(L,-1)!=LUA_TNIL) {
            const char *name=luaL_checklstring(L,-1,NULL);
            dtype=ln_dtype_by_name(name);
            if(!dtype)return luaL_error(L,"unsupported output dtype");
        }
        lua_pop(L,1);
        lua_getfield(L,2,"casting");
        if(lua_type(L,-1)!=LUA_TNIL) {
            if(ln_parse_casting(luaL_checklstring(L,-1,NULL),&casting)<0)
                return luaL_error(L,"unsupported casting policy");
        }
        lua_pop(L,1);
    }
    const ln_array **inputs=(const ln_array**)lua_newuserdatauv(L,n*sizeof(*inputs),0);
    int axis=0;
    for(size_t i=0;i<n;i++) {
        lua_geti(L,1,(lua_Integer)i+1);
        lua_array *u=test_array(L,-1);
        if(!u) {
            /* The nested table is a *sequence of arrays*, not one ndarray.
             * Every element may itself be an ndarray, Lua table, or scalar. */
            lua_pushcfunction(L,np_array);
            lua_pushvalue(L,-2);
            if(lua_pcall(L,1,1,0)!=LUA_OK)
                return luaL_error(L,"cannot convert stack input %llu: %s",
                    (unsigned long long)i+1,lua_tostring(L,-1));
            lua_remove(L,-2);
            u=check_array(L,-1);
        }
        ln_error e={{0}};
        ln_array *view=NULL;
        if(kind==LN_HSTACK) {
            view=ln_axis_atleast(u->a,1,&e);
            if(i==0)axis=view&&view->nd==1?0:1;
        } else if(kind==LN_VSTACK) {
            view=ln_axis_atleast(u->a,2,&e);
            axis=0;
        } else if(kind==LN_DSTACK) {
            view=ln_axis_atleast(u->a,3,&e);
            axis=2;
        } else if(u->a->nd==1) {
            const unsigned char positions[2]={0,1};
            view=ln_axis_expand(u->a,positions,2,&e);
            axis=1;
        } else {
            view=ln_axis_atleast(u->a,2,&e);
            axis=1;
        }
        if(!view)return fail(L,&e);
        inputs[i]=view;
        push_array(L,view); /* ensure every temporary view gets finalized */
    }
    ln_error e={{0}};
    ln_array *result=ln_join_arrays(inputs,n,axis,0,dtype,casting,NULL,&e);
    if(!result)return fail(L,&e);
    return push_array(L,result);
}
static int np_hstack(lua_State *L) {return shape_stack_function(L,LN_HSTACK);}
static int np_vstack(lua_State *L) {return shape_stack_function(L,LN_VSTACK);}
static int np_dstack(lua_State *L) {return shape_stack_function(L,LN_DSTACK);}
static int np_column_stack(lua_State *L) {return shape_stack_function(L,LN_COLUMN_STACK);}



/* Copy-producing sequence manipulation: NumPy append and delete.
 * Axis and element positions use Lua's 1-based convention (negative from end),
 * while deletion masks and slice bounds preserve the NumPy semantics. */
static int np_append(lua_State *L) {
    if (lua_gettop(L)<2) return luaL_error(L,"append expects an array and values");
    ln_array *a=broadcast_arg(L,1);
    ln_array *b=broadcast_arg(L,2);
    int axis=-1;
    if(lua_type(L,3)!=LUA_TNONE && lua_type(L,3)!=LUA_TNIL &&
       !(lua_type(L,3)==LUA_TBOOLEAN && !lua_toboolean(L,3))) {
        if (a->nd==0)return luaL_error(L,"axis is out of bounds for a scalar");
        if(normalize_lua_axis(L,luaL_checkinteger(L,3),a->nd,&axis))return 0;
    }
    const ln_array *inputs[2]={a,b};
    ln_error e={{0}};
    ln_array *result=ln_join_arrays(inputs,2,axis,0,NULL,LN_SAME_KIND_CASTING,NULL,&e);
    if(!result)return fail(L,&e);
    return push_array(L,result);
}

static int mark_delete_position(lua_State *L, unsigned char *mask,
                                ln_intp length, lua_Integer raw) {
    ln_intp i=0;
    if(normalize_lua_index_value(L,raw,length,0,&i))return 1;
    mask[i]=1;
    return 0;
}
static int np_delete(lua_State *L) {
    if(lua_gettop(L)<2)return luaL_error(L,"delete expects an array and indices");
    ln_array *a=broadcast_arg(L,1);
    int axis=-1;
    if(lua_type(L,3)!=LUA_TNIL && lua_type(L,3)!=LUA_TNONE &&
       !(lua_type(L,3)==LUA_TBOOLEAN && !lua_toboolean(L,3))) {
        if(a->nd==0)return luaL_error(L,"axis is out of bounds for a scalar");
        if(normalize_lua_axis(L,luaL_checkinteger(L,3),a->nd,&axis))return 0;
    }
    ln_intp count=axis==-1?ln_array_size(a):a->dimensions[axis];
    if(count<0 || (uintmax_t)count>SIZE_MAX-1)return luaL_error(L,"delete mask too large");
    /* Lua userdata is GC rooted even when a later argument raises an error. */
    unsigned char *remove=(unsigned char *)lua_newuserdatauv(L,(size_t)count+1,0);
    memset(remove,0,(size_t)count+1);
    lua_index_spec *sp=test_index_spec(L,2);
    lua_array *idxarr=test_array(L,2);
    if(sp) {
        if(sp->kind!=LN_INDEX_SLICE)return luaL_error(L,"delete accepts only slice tokens");
        ln_index range={0};
        if(normalize_lua_slice(L,sp,count,&range))return 0;
        for(ln_intp i=0;i<range.length;i++) remove[range.start+i*range.step]=1;
    } else if(lua_type(L,2)==LUA_TNUMBER) {
        lua_Integer raw=0;
        if(read_lua_integer_value(L,2,&raw))return 0;
        if(mark_delete_position(L,remove,count,raw))return 0;
    } else if(lua_type(L,2)==LUA_TTABLE) {
        size_t n=lua_rawlen(L,2);
        int all_bool=n>0;
        for(size_t j=0;j<n;j++) {
            lua_geti(L,2,(lua_Integer)j+1);
            if(lua_type(L,-1)!=LUA_TBOOLEAN)all_bool=0;
            lua_pop(L,1);
        }
        if(all_bool && (ln_intp)n!=count)return luaL_error(L,"boolean delete mask has wrong length");
        for(size_t j=0;j<n;j++) {
            lua_geti(L,2,(lua_Integer)j+1);
            if(all_bool)remove[j]=(unsigned char)lua_toboolean(L,-1);
            else {
                lua_Integer raw=0;
                if(lua_type(L,-1)==LUA_TBOOLEAN)raw=lua_toboolean(L,-1);
                else if(read_lua_integer_value(L,-1,&raw))return 0;
                if(mark_delete_position(L,remove,count,raw))return 0;
            }
            lua_pop(L,1);
        }
    } else if(idxarr) {
        const ln_array *ia=idxarr->a;
        if(ia->nd!=1)return luaL_error(L,"delete index array must be 1-D");
        int boolean=ia->descr->type_num==LN_BOOL;
        if(!boolean && ia->descr->kind!='i' && ia->descr->kind!='u')
            return luaL_error(L,"delete indices must be integers or booleans");
        ln_intp size=ia->dimensions[0];
        if(boolean && size!=count)return luaL_error(L,"boolean delete mask has wrong length");
        for(ln_intp j=0;j<size;j++) {
            ln_intp coords[1]={j};
            double val=0;int64_t iv=0;int isint=0;ln_error e={{0}};
            if(ln_array_get_number(ia,coords,&val,&iv,&isint,&e)<0)return fail(L,&e);
            if(!boolean && ia->descr->type_num==LN_ULONGLONG && iv<0)
                return luaL_error(L,"uint64 delete index exceeds signed intp range");
            if(boolean)remove[j]=(unsigned char)(iv!=0);
            else if(mark_delete_position(L,remove,count,(lua_Integer)iv))return 0;
        }
    } else return luaL_error(L,"delete indices must be integers, an index table, integer/boolean ndarray or np.slice");
    ln_error e={{0}};
    ln_array *result=ln_delete(a,axis,remove,count,&e);
    if(!result)return fail(L,&e);
    return push_array(L,result);
}

/* Copy-producing insertion; supports scalar/list/slice/ndarray indices.
 * LuaRay positions are 1-based; N+1 appends, negative positions refer to
 * boundaries before elements counted from the end. */
static int normalized_insert_position(lua_State *L, lua_Integer raw,
                                      ln_intp length, ln_intp *out) {
    if(raw==0)return luaL_error(L,"insert position 0 is invalid in Lua indexing");
    if(raw>0) {
        if((uintmax_t)raw>(uintmax_t)length+1)
            return luaL_error(L,"insert position exceeds axis length");
        *out=(ln_intp)(raw-1);
    } else {
        if(raw<-(lua_Integer)length)
            return luaL_error(L,"insert position is out of bounds");
        *out=(ln_intp)((lua_Integer)length+raw);
    }
    return 0;
}
static int np_insert(lua_State *L) {
    if(lua_gettop(L)<3)return luaL_error(L,"insert expects an array, positions and values");
    ln_array *a=broadcast_arg(L,1);
    int axis=-1;
    if(lua_type(L,4)!=LUA_TNONE && lua_type(L,4)!=LUA_TNIL &&
       !(lua_type(L,4)==LUA_TBOOLEAN && !lua_toboolean(L,4))) {
        if(a->nd==0)return luaL_error(L,"axis is out of bounds for a scalar");
        if(normalize_lua_axis(L,luaL_checkinteger(L,4),a->nd,&axis))return 0;
    }
    ln_intp length=axis==-1?ln_array_size(a):a->dimensions[axis];
    if(length<0)return luaL_error(L,"insert axis too large");
    lua_index_spec *sp=test_index_spec(L,2);
    lua_array *indices=test_array(L,2);
    ln_intp n=0;
    int scalar=0;
    if(sp) {
        if(sp->kind!=LN_INDEX_SLICE)return luaL_error(L,"insert accepts only slice tokens");
        ln_index range={0};
        if(normalize_lua_slice(L,sp,length,&range))return 0;
        n=range.length;
    } else if(lua_type(L,2)==LUA_TNUMBER) {n=1;scalar=1;}
    else if(lua_type(L,2)==LUA_TTABLE) {
        size_t z=lua_rawlen(L,2);
        if(z>(size_t)INTPTR_MAX)return luaL_error(L,"too many insert indices");
        n=(ln_intp)z;
    } else if(indices) {
        if(indices->a->nd>1)return luaL_error(L,"insert index array must be 1-D or scalar");
        int t=indices->a->descr->type_num;
        if(t!=LN_BOOL && indices->a->descr->kind!='i' && indices->a->descr->kind!='u')
            return luaL_error(L,"insert index array must contain integers or booleans");
        n=indices->a->nd==0?1:indices->a->dimensions[0];
        scalar=indices->a->nd==0;
    } else return luaL_error(L,"insert positions must be integer, table, ndarray, or np.slice");
    if((uintmax_t)n>SIZE_MAX/sizeof(ln_intp)-1)
        return luaL_error(L,"too many insert indices");
    /* Buffer is rooted on Lua's stack throughout argument conversion. */
    ln_intp *positions=(ln_intp*)lua_newuserdatauv(L,((size_t)n+1)*sizeof(*positions),0);
    if(sp) {
        ln_index range={0};
        if(normalize_lua_slice(L,sp,length,&range))return 0;
        for(ln_intp j=0;j<n;j++)positions[j]=range.start+j*range.step;
    } else if(lua_type(L,2)==LUA_TNUMBER) {
        lua_Integer raw=0;
        if(read_lua_integer_value(L,2,&raw) || normalized_insert_position(L,raw,length,&positions[0]))return 0;
    } else if(lua_type(L,2)==LUA_TTABLE) {
        int bools=n>0;
        for(ln_intp j=0;j<n;j++){
            lua_geti(L,2,(lua_Integer)j+1);
            if(lua_type(L,-1)!=LUA_TBOOLEAN)bools=0;
            lua_pop(L,1);
        }
        if(bools && n!=length)return luaL_error(L,"boolean insert mask has wrong length");
        ln_intp count=0;
        for(ln_intp j=0;j<n;j++){
            lua_geti(L,2,(lua_Integer)j+1);
            if(bools){if(lua_toboolean(L,-1))positions[count++]=j;}
            else{
                lua_Integer raw=0;
                if(lua_type(L,-1)==LUA_TBOOLEAN)raw=lua_toboolean(L,-1);
                else if(read_lua_integer_value(L,-1,&raw))return 0;
                if(normalized_insert_position(L,raw,length,&positions[count++]))return 0;
            }
            lua_pop(L,1);
        }
        n=count;
    } else if(indices) {
        const ln_array *ia=indices->a;
        int boolean=ia->descr->type_num==LN_BOOL;
        if(boolean && ia->nd==0)return luaL_error(L,"boolean scalar insertion index is invalid");
        if(boolean && n!=length)return luaL_error(L,"boolean insert mask has wrong length");
        ln_intp count=0;
        for(ln_intp j=0;j<n;j++){
            ln_intp idx[1]={j};double val=0;int64_t iv=0;int isint=0;ln_error e={{0}};
            if(ln_array_get_number(ia,ia->nd==0?NULL:idx,&val,&iv,&isint,&e)<0)return fail(L,&e);
            if(boolean){if(iv!=0)positions[count++]=j;}
            else {
                if(ia->descr->type_num==LN_ULONGLONG && iv<0)
                    return luaL_error(L,"uint64 insert index exceeds signed intp range");
                if(normalized_insert_position(L,(lua_Integer)iv,length,&positions[count++]))return 0;
            }
        }
        n=count;
    }
    ln_array *values=broadcast_arg(L,3);
    ln_error e={{0}};
    ln_array *out=ln_insert(a,axis,positions,n,scalar,values,&e);
    if(!out)return fail(L,&e);
    return push_array(L,out);
}

/* Dividing arrays: zero-copy ndarray views, with Lua 1-based axes.
 * Split positions are counts of elements before each boundary, matching
 * NumPy's split-index convention (e.g. {2,4} yields [:2], [2:4], [4:]). */
static int split_function(lua_State *L, int flavor)
{
    /* flavor: 0=split, 1=array_split, 2=hsplit, 3=vsplit, 4=dsplit */
    lua_array *u=test_array(L,1);
    if (!u) return luaL_error(L,"split requires a LuaRay ndarray");
    const ln_array *a=u->a;
    int axis=0;
    if (flavor==2) {
        if(a->nd<1) return luaL_error(L,"hsplit requires one or more dimensions");
        axis=a->nd==1?0:1;
    } else if(flavor==3) {
        if(a->nd<2) return luaL_error(L,"vsplit requires two or more dimensions");
    } else if(flavor==4) {
        if(a->nd<3) return luaL_error(L,"dsplit requires three or more dimensions");
        axis=2;
    } else {
        if(a->nd==0)return luaL_error(L,"cannot split a zero-dimensional array");
        lua_Integer requested=1;
        if(lua_gettop(L)>=3 && lua_type(L,3)!=LUA_TNIL)requested=luaL_checkinteger(L,3);
        if(normalize_lua_axis(L,requested,a->nd,&axis))return 0;
    }
    ln_intp dim=a->dimensions[axis];
    int sections=(lua_type(L,2)==LUA_TNUMBER);
    lua_array *bound_array=sections?NULL:test_array(L,2);
    size_t count;
    ln_intp nsplit=0;
    if(sections) {
        lua_Integer v=luaL_checkinteger(L,2);
        if(v<=0)return luaL_error(L,"number of sections must be larger than 0");
        if(v>1000000)return luaL_error(L,"too many split sections");
        nsplit=(ln_intp)v;
        if(flavor!=1 && dim%nsplit!=0)
            return luaL_error(L,"array split does not result in an equal division");
        count=(size_t)nsplit;
    } else if(lua_type(L,2)==LUA_TTABLE) {
        size_t breaks=lua_rawlen(L,2);
        if(breaks>=1000000)return luaL_error(L,"too many split boundaries");
        count=breaks+1;
    } else if(bound_array) {
        if(bound_array->a->nd!=1)return luaL_error(L,"split boundary array must be 1-D");
        if(bound_array->a->dimensions[0]>=1000000)return luaL_error(L,"too many split boundaries");
        count=(size_t)bound_array->a->dimensions[0]+1;
    } else return luaL_error(L,"split boundaries must be an integer, table, or 1-D ndarray");
    lua_createtable(L,(int)count,0);
    int output_table=lua_gettop(L);
    ln_intp prev=0;
    for(size_t i=0;i<count;++i) {
        ln_intp next=dim;
        if(sections) {
            /* First dim%sections pieces are one element larger.  Computing
             * this without multiplying huge size_t values avoids overflow. */
            ln_intp each=dim/nsplit, extra=dim%nsplit;
            ln_intp ordinal=(ln_intp)i+1;
            next=ordinal*each+(ordinal<extra?ordinal:extra);
        } else if(i<count-1) {
            if(bound_array) {
                ln_intp idx[1]={(ln_intp)i};
                push_scalar_at(L,bound_array->a,idx);
            } else lua_geti(L,2,(lua_Integer)i+1);
            if(!lua_isinteger(L,-1))return luaL_error(L,"split boundaries must be integers");
            lua_Integer raw=lua_tointegerx(L,-1,NULL);
            lua_pop(L,1);
            next=(ln_intp)raw;
        }
        ln_error e={{0}};
        ln_array *view=ln_split_view(a,axis,prev,next,&e);
        if(!view)return fail(L,&e);
        push_array(L,view);
        lua_seti(L,output_table,(lua_Integer)i+1);
        prev=next;
    }
    return 1;
}
static int np_split(lua_State *L){return split_function(L,0);}
static int np_array_split(lua_State *L){return split_function(L,1);}
static int np_hsplit(lua_State *L){return split_function(L,2);}
static int np_vsplit(lua_State *L){return split_function(L,3);}
static int np_dsplit(lua_State *L){return split_function(L,4);}

/* Build a temporary numeric ndarray for APIs such as searchsorted which, like
 * PyArray_CheckFromAny/DescrFromObject, accept scalar/sequence/array inputs.
 * Newly created arrays are immediately owned by userdata left on the Lua stack,
 * so any luaL_error during packing cannot leak native memory. */
static ln_array *
coerce_numeric_array_arg(lua_State *L,int arg)
{
    arg=lua_absindex(L,arg);
    lua_array *u=test_array(L,arg);
    if(u)return u->a;
    int t=lua_type(L,arg);
    if(t==LUA_TTABLE){
        ln_intp dims[LN_MAXDIMS];for(int i=0;i<LN_MAXDIMS;i++)dims[i]=-1;
        int nd=0;if(infer_table_shape(L,arg,0,dims,&nd))return NULL;
        int hc=0,hf=0,hi=0,hb=0,hs=0;if(scan_dtype(L,arg,&hc,&hf,&hi,&hb,&hs))return NULL;if(hs){luaL_error(L,"numeric API does not accept string arrays here");return NULL;}
        const ln_dtype*dt=hc?ln_dtype_by_num(LN_CDOUBLE):(hf?ln_dtype_by_num(LN_DOUBLE):(hi?ln_dtype_by_name("int64"):ln_dtype_by_num(LN_BOOL)));
        ln_error e={{0}};ln_array*a=ln_array_new(nd,dims,dt,0,0,&e);if(!a){fail(L,&e);return NULL;}
        push_array(L,a);ln_intp idx[LN_MAXDIMS]={0};if(fill_table(L,arg,a,0,idx))return NULL;
        return a;
    }
    lua_complex *zc=test_complex(L,arg);
    if(zc){
        const ln_dtype *dt=ln_dtype_by_num(LN_CDOUBLE);
        ln_error e={{0}};ln_array*a=ln_array_new(0,NULL,dt,0,0,&e);if(!a){fail(L,&e);return NULL;}
        push_array(L,a);
        if(ln_array_pack_complex(a,NULL,zc->real,zc->imag,&e)<0){fail(L,&e);return NULL;}
        return a;
    }
    if(t==LUA_TNUMBER||t==LUA_TBOOLEAN){
        const ln_dtype *dt;
        double d=0;int64_t iv=0;int isint=0;
        if(t==LUA_TBOOLEAN){dt=ln_dtype_by_num(LN_BOOL);iv=lua_toboolean(L,arg)?1:0;d=(double)iv;isint=1;}
        else {int ok=0;isint=lua_isinteger(L,arg);d=lua_tonumberx(L,arg,&ok);if(!ok){luaL_error(L,"value must be numeric");return NULL;}iv=isint?(int64_t)lua_tointegerx(L,arg,NULL):0;dt=isint?ln_dtype_by_name("int64"):ln_dtype_by_num(LN_DOUBLE);}
        ln_error e={{0}};ln_array*a=ln_array_new(0,NULL,dt,0,0,&e);if(!a){fail(L,&e);return NULL;}
        push_array(L,a);
        if(ln_array_pack_number(a,NULL,d,iv,isint,&e)<0){fail(L,&e);return NULL;}
        return a;
    }
    luaL_error(L,"value must be a numeric scalar, table, or ndarray");
    return NULL;
}

static int
parse_searchsort_sorter(lua_State *L,int arg,ln_intp n,ln_intp **out,ln_intp *nout)
{
    *out=NULL;*nout=0;
    if(arg<=0||lua_type(L,arg)==LUA_TNIL)return 0;
    arg=lua_absindex(L,arg);
    ln_intp count=0;
    lua_array *u=test_array(L,arg);
    if(u){
        if(u->a->nd!=1 || !(u->a->descr->kind=='i'||u->a->descr->kind=='u'))
            return luaL_error(L,"sorter must be a 1-D integer ndarray or table");
        count=u->a->dimensions[0];
    }else if(lua_type(L,arg)==LUA_TTABLE){count=(ln_intp)lua_rawlen(L,arg);}
    else return luaL_error(L,"sorter must be a 1-D integer ndarray or table");
    if(count!=n)return luaL_error(L,"sorter.size must equal a.size");
    ln_intp *v=(ln_intp*)malloc((size_t)(count?count:1)*sizeof(*v));
    if(!v)return luaL_error(L,"out of memory parsing sorter");
    for(ln_intp i=0;i<count;++i){
        lua_Integer raw=0;
        if(u){double d=0;int64_t iv=0;int isint=0;ln_intp q[1]={i};ln_error e={{0}};
            if(ln_array_get_number(u->a,q,&d,&iv,&isint,&e)<0){free(v);return fail(L,&e);}
            if(!isint){free(v);return luaL_error(L,"sorter must only contain integers");}
            raw=(lua_Integer)iv;
        }else{lua_geti(L,arg,(lua_Integer)i+1);int ok=0;raw=lua_tointegerx(L,-1,&ok);lua_pop(L,1);if(!ok){free(v);return luaL_error(L,"sorter must only contain integers");}}
        if(raw>0)v[i]=(ln_intp)(raw-1);
        else if(raw<0)v[i]=n+(ln_intp)raw;
        else {free(v);return luaL_error(L,"sorter index 0 is invalid in Lua's 1-based indexing model");}
        /* Deliberately leave range validation to ln_searchsorted, matching the
         * upstream argbinsearch error point. */
    }
    *out=v;*nout=count;return 0;
}

static int
np_searchsorted(lua_State *L)
{
    lua_array *a=check_array(L,1);
    int top=lua_gettop(L);
    ln_array *keys=coerce_numeric_array_arg(L,2);if(!keys)return 0;
    const char *side="left";int sorter_arg=0;
    if(top>=3 && lua_type(L,3)!=LUA_TNIL){
        if(lua_type(L,3)==LUA_TSTRING) side=lua_tostring(L,3);
        else if(lua_type(L,3)==LUA_TTABLE){
            lua_getfield(L,3,"side");if(lua_type(L,-1)!=LUA_TNIL)side=lua_tostring(L,-1);lua_pop(L,1);
            lua_getfield(L,3,"sorter");if(lua_type(L,-1)!=LUA_TNIL)sorter_arg=lua_absindex(L,-1);else lua_pop(L,1);
        }else return luaL_error(L,"side/options must be 'left', 'right', or an options table");
    }
    if(top>=4 && lua_type(L,4)!=LUA_TNIL)sorter_arg=4;
    int right;
    if(strcmp(side,"left")==0)right=0;else if(strcmp(side,"right")==0)right=1;else return luaL_error(L,"side must be 'left' or 'right'");
    ln_intp *sorter=NULL,nsorter=0;
    if(parse_searchsort_sorter(L,sorter_arg,a->a->nd==1?a->a->dimensions[0]:0,&sorter,&nsorter))return 0;
    ln_error e={{0}};ln_array *r=ln_searchsorted(a->a,keys,right,sorter,nsorter,&e);free(sorter);
    if(!r)return fail(L,&e);
    if(r->nd==0){int ret=push_scalar_at(L,r,NULL);ln_array_free(r);return ret;}
    return push_array(L,r);
}

static int make_filled(lua_State*L,int one,int uninitialized){ln_intp dims[LN_MAXDIMS];int nd=0;if(parse_shape(L,1,dims,&nd))return 0;const ln_dtype*dt=dtype_arg(L,2,ln_dtype_by_num(LN_DOUBLE));if(!dt)return luaL_error(L,"unsupported dtype");ln_error e={{0}};ln_array*a=ln_array_new(nd,dims,dt,0,!uninitialized,&e);if(!a)return fail(L,&e);if(one){ln_intp total=ln_array_size(a),idx[LN_MAXDIMS]={0};for(ln_intp k=0;k<total;k++){if(ln_array_set_number(a,idx,0,1,1,&e)<0){ln_array_free(a);return fail(L,&e);}for(int d=nd-1;d>=0;d--){idx[d]++;if(idx[d]<dims[d])break;idx[d]=0;}}}return push_array(L,a);} 
static int np_zeros(lua_State*L){return make_filled(L,0,0);}static int np_empty(lua_State*L){return make_filled(L,0,1);}static int np_ones(lua_State*L){return make_filled(L,1,0);} 
typedef struct reduction_call_options {
    uint8_t axis_flags[LN_MAXDIMS];
    int keepdims;
    const ln_dtype *dtype;
    lua_array *out;
    const ln_array *where;
    ln_array where_scalar;
    uint8_t where_scalar_value;
    int has_initial;
    double initial_v;
    int64_t initial_i;
    int initial_is_integer;
    int options_table_index;
} reduction_call_options;

static void
set_all_reduction_axes(int nd, uint8_t *flags)
{
    memset(flags,0,LN_MAXDIMS);
    for(int d=0;d<nd;d++)flags[d]=1;
}

static int
normalize_lua_axis(lua_State *L, lua_Integer raw, int nd, int *axis)
{
    if(raw==0)return luaL_error(L,"axis 0 is invalid in Lua's 1-based axis model");
    if(nd==0){
        /* Lua equivalents of NumPy's accepted 0/-1 axes for 0-D arrays. */
        if(raw==1||raw==-1){*axis=-1;return 0;}
        char msg[128];
        snprintf(msg,sizeof(msg),"axis %lld is out of bounds for array of dimension 0",(long long)raw);
        return luaL_error(L,"%s",msg);
    }
    ln_intp ax=raw>0?(ln_intp)raw-1:(ln_intp)nd+raw;
    if(ax<0||ax>=nd){
        char msg[128];
        snprintf(msg,sizeof(msg),"axis %lld is out of bounds for array of dimension %d",(long long)raw,nd);
        return luaL_error(L,"%s",msg);
    }
    *axis=(int)ax;
    return 0;
}

static int
parse_reduction_axes_value(lua_State *L,int idx,int nd,uint8_t *flags)
{
    if(lua_type(L,idx)==LUA_TNIL||lua_type(L,idx)==LUA_TNONE){set_all_reduction_axes(nd,flags);return 0;}
    if(lua_type(L,idx)==LUA_TNUMBER){
        int ok=0;lua_Integer raw=lua_tointegerx(L,idx,&ok);
        if(!ok)return luaL_error(L,"axis must be an integer, table of integers, or nil");
        memset(flags,0,LN_MAXDIMS);int ax;
        if(normalize_lua_axis(L,raw,nd,&ax))return 1;
        if(ax>=0)flags[ax]=1;
        return 0;
    }
    if(lua_type(L,idx)==LUA_TTABLE){
        memset(flags,0,LN_MAXDIMS);
        size_t n=lua_rawlen(L,idx);
        for(size_t i=1;i<=n;i++){
            lua_geti(L,idx,(lua_Integer)i);
            int ok=0;lua_Integer raw=lua_tointegerx(L,-1,&ok);
            lua_pop(L,1);
            if(!ok)return luaL_error(L,"axis table entries must be integers");
            int ax;
            if(normalize_lua_axis(L,raw,nd,&ax))return 1;
            if(ax>=0){
                if(flags[ax])return luaL_error(L,"duplicate value in 'axis'");
                flags[ax]=1;
            }
        }
        return 0;
    }
    return luaL_error(L,"axis must be an integer, table of integers, or nil");
}

static int
reduction_table_has_named_options(lua_State *L,int idx)
{
    static const char *keys[]={"axis","dtype","out","keepdims","initial","where","ddof","correction","mean",NULL};
    idx=lua_absindex(L,idx);
    for(int i=0;keys[i];i++){
        lua_getfield(L,idx,keys[i]);
        int present=lua_type(L,-1)!=LUA_TNIL;
        lua_pop(L,1);
        if(present)return 1;
    }
    return 0;
}

static int
parse_reduction_where(lua_State *L,int idx,reduction_call_options *opts)
{
    int t=lua_type(L,idx);
    if(t==LUA_TNIL||t==LUA_TNONE){opts->where=NULL;return 0;}
    if(t==LUA_TBOOLEAN||t==LUA_TNUMBER){
        int truth;
        if(t==LUA_TBOOLEAN)truth=lua_toboolean(L,idx);
        else{int ok=0;lua_Number v=lua_tonumberx(L,idx,&ok);if(!ok)return luaL_error(L,"where scalar must be numeric or boolean");truth=(v!=0);}
        if(truth){opts->where=NULL;return 0;}
        memset(&opts->where_scalar,0,sizeof(opts->where_scalar));
        opts->where_scalar_value=0;
        opts->where_scalar.data=(char*)&opts->where_scalar_value;
        opts->where_scalar.nd=0;
        opts->where_scalar.descr=ln_dtype_by_num(LN_BOOL);
        opts->where_scalar.flags=LN_ARRAY_C_CONTIGUOUS|LN_ARRAY_F_CONTIGUOUS|LN_ARRAY_ALIGNED;
        opts->where=&opts->where_scalar;
        return 0;
    }
    lua_array*w=test_array(L,idx);
    if(!w)return luaL_error(L,"where must be a bool ndarray, scalar number/boolean, or nil");
    opts->where=w->a;
    return 0;
}

static int
parse_reduction_options_table(lua_State *L,int idx,int nd,ln_reduce_op op,reduction_call_options *opts)
{
    idx=lua_absindex(L,idx);opts->options_table_index=idx;
    lua_getfield(L,idx,"axis");
    if(parse_reduction_axes_value(L,-1,nd,opts->axis_flags)){lua_pop(L,1);return 1;}
    lua_pop(L,1);

    lua_getfield(L,idx,"dtype");
    if(lua_type(L,-1)!=LUA_TNIL){const char*name=lua_tostring(L,-1);opts->dtype=name?ln_dtype_by_name(name):NULL;if(!opts->dtype){lua_pop(L,1);return luaL_error(L,"unsupported dtype");}}
    lua_pop(L,1);

    lua_getfield(L,idx,"out");
    if(lua_type(L,-1)!=LUA_TNIL){opts->out=test_array(L,-1);if(!opts->out){lua_pop(L,1);return luaL_error(L,"out must be an ndarray or nil");}}
    lua_pop(L,1);

    lua_getfield(L,idx,"keepdims");
    if(lua_type(L,-1)!=LUA_TNIL){if(lua_type(L,-1)!=LUA_TBOOLEAN){lua_pop(L,1);return luaL_error(L,"keepdims must be boolean");}opts->keepdims=lua_toboolean(L,-1);}
    lua_pop(L,1);

    lua_getfield(L,idx,"where");
    if(parse_reduction_where(L,-1,opts)){lua_pop(L,1);return 1;}
    lua_pop(L,1);

    lua_getfield(L,idx,"initial");
    if(lua_type(L,-1)!=LUA_TNIL){
        if(op==LN_REDUCE_MEAN){lua_pop(L,1);return luaL_error(L,"mean does not accept initial");}
        opts->has_initial=1;
        if(lua_type(L,-1)==LUA_TBOOLEAN){opts->initial_is_integer=1;opts->initial_i=lua_toboolean(L,-1);opts->initial_v=(double)opts->initial_i;}
        else if(lua_type(L,-1)==LUA_TNUMBER){int ok=0;opts->initial_is_integer=lua_isinteger(L,-1);opts->initial_v=(double)lua_tonumberx(L,-1,&ok);if(!ok){lua_pop(L,1);return luaL_error(L,"initial must be numeric or boolean");}opts->initial_i=opts->initial_is_integer?(int64_t)lua_tointegerx(L,-1,NULL):0;}
        else{lua_pop(L,1);return luaL_error(L,"initial must be numeric, boolean, or nil");}
    }
    lua_pop(L,1);
    return 0;
}

static int
parse_reduction_call(lua_State *L,int nd,ln_reduce_op op,reduction_call_options *opts)
{
    memset(opts,0,sizeof(*opts));set_all_reduction_axes(nd,opts->axis_flags);
    int top=lua_gettop(L);
    if(top<2||lua_type(L,2)==LUA_TNIL)return 0;
    if(lua_type(L,2)==LUA_TTABLE&&reduction_table_has_named_options(L,2)){
        return parse_reduction_options_table(L,2,nd,op,opts);
    }
    if(parse_reduction_axes_value(L,2,nd,opts->axis_flags))return 1;
    if(top>=3&&lua_type(L,3)!=LUA_TNIL){
        if(lua_type(L,3)!=LUA_TTABLE||!reduction_table_has_named_options(L,3))return luaL_error(L,"third reduction argument must be an options table");
        /* Preserve the positional axis unless the options table explicitly has axis=. */
        uint8_t positional[LN_MAXDIMS];memcpy(positional,opts->axis_flags,sizeof(positional));
        lua_getfield(L,3,"axis");int has_axis=lua_type(L,-1)!=LUA_TNIL;lua_pop(L,1);
        if(parse_reduction_options_table(L,3,nd,op,opts))return 1;
        if(!has_axis)memcpy(opts->axis_flags,positional,sizeof(positional));
    }
    return 0;
}

static int
push_reduction_result(lua_State *L,ln_array *r)
{
    if(r->nd==0){int ret=push_scalar_at(L,r,NULL);ln_array_free(r);return ret;}
    return push_array(L,r);
}

static int
reduction_function(lua_State *L,ln_reduce_op op)
{
    lua_array*u=check_array(L,1);
    reduction_call_options opts;
    if(parse_reduction_call(L,u->a->nd,op,&opts))return 0;
    if(opts.options_table_index) {
        lua_getfield(L,opts.options_table_index,"ddof");
        int has_ddof=lua_type(L,-1)!=LUA_TNIL;lua_pop(L,1);
        lua_getfield(L,opts.options_table_index,"correction");
        int has_correction=lua_type(L,-1)!=LUA_TNIL;lua_pop(L,1);
        lua_getfield(L,opts.options_table_index,"mean");
        int has_mean=lua_type(L,-1)!=LUA_TNIL;lua_pop(L,1);
        if(has_ddof||has_correction||has_mean)return luaL_error(L,"unsupported reduction option");
    }
    ln_error e={{0}};
    if(opts.out){
        if(ln_reduce_into_ex(u->a,opts.axis_flags,opts.keepdims,opts.dtype,
                opts.out->a,opts.where,op,opts.has_initial,opts.initial_v,
                opts.initial_i,opts.initial_is_integer,&e)<0)return fail(L,&e);
        lua_getfield(L,opts.options_table_index,"out");
        return 1;
    }
    ln_array*r=ln_reduce_ex(u->a,opts.axis_flags,opts.keepdims,opts.dtype,
            opts.where,op,opts.has_initial,opts.initial_v,opts.initial_i,
            opts.initial_is_integer,&e);
    if(!r)return fail(L,&e);
    return push_reduction_result(L,r);
}

/* NaN-filtered variants reuse native reduction kernels. Mask generation is
 * independent from the destination, so out= may safely overlap the input. */
static int nan_reduction_function(lua_State *L, ln_reduce_op op) {
    lua_array *u=check_array(L,1);
    reduction_call_options opts;
    if(parse_reduction_call(L,u->a->nd,op,&opts))return 0;
    if(opts.options_table_index) {
        static const char *unsupported[]={"ddof","correction","mean",NULL};
        for(int i=0;unsupported[i];i++) {
            lua_getfield(L,opts.options_table_index,unsupported[i]);
            int found=lua_type(L,-1)!=LUA_TNIL;lua_pop(L,1);
            if(found)return luaL_error(L,"unsupported nan reduction option '%s'",unsupported[i]);
        }
    }
    ln_error e={{0}};
    ln_array *where=ln_stats_nan_where(u->a,opts.where,&e);
    if(!where)return fail(L,&e);
    ln_array *r=NULL;
    if(opts.out) {
        int rc=ln_reduce_into_ex(u->a,opts.axis_flags,opts.keepdims,opts.dtype,
            opts.out->a,where,op,opts.has_initial,opts.initial_v,
            opts.initial_i,opts.initial_is_integer,&e);
        ln_array_free(where);
        if(rc<0)return fail(L,&e);
        lua_getfield(L,opts.options_table_index,"out");return 1;
    }
    r=ln_reduce_ex(u->a,opts.axis_flags,opts.keepdims,opts.dtype,
            where,op,opts.has_initial,opts.initial_v,opts.initial_i,
            opts.initial_is_integer,&e);
    ln_array_free(where);
    if(!r)return fail(L,&e);
    return push_reduction_result(L,r);
}
static int np_nansum(lua_State *L){return nan_reduction_function(L,LN_REDUCE_SUM);}
static int np_nanprod(lua_State *L){return nan_reduction_function(L,LN_REDUCE_PROD);}
static int np_nanmean(lua_State *L){return nan_reduction_function(L,LN_REDUCE_MEAN);}
/* 0.49: exact logical reductions with proper source-DType truth semantics. */
static int truth_reduction_function(lua_State *L,int kind) {
    lua_array *u=check_array(L,1);
    reduction_call_options opts;
    if(parse_reduction_call(L,u->a->nd,LN_REDUCE_SUM,&opts))return 0;
    if(opts.dtype||opts.has_initial)return luaL_error(L,"logical reductions do not accept dtype or initial");
    if(opts.options_table_index){
        static const char *invalid[]={"ddof","correction","mean",NULL};
        for(int i=0;invalid[i];i++){
            lua_getfield(L,opts.options_table_index,invalid[i]);
            int present=lua_type(L,-1)!=LUA_TNIL;lua_pop(L,1);
            if(present)return luaL_error(L,"unsupported logical reduction option '%s'",invalid[i]);
        }
    }
    if(kind==2&&(opts.where||opts.out))return luaL_error(L,"count_nonzero does not accept where or out");
    ln_error e={{0}};
    ln_array *r=ln_truth_reduce(u->a,opts.axis_flags,opts.keepdims,opts.where,kind,
        opts.out?opts.out->a:NULL,&e);
    if(!r)return fail(L,&e);
    if(opts.out){ln_array_free(r);lua_getfield(L,opts.options_table_index,"out");return 1;}
    return push_reduction_result(L,r);
}
static int np_any(lua_State *L){return truth_reduction_function(L,0);}
static int np_all(lua_State *L){return truth_reduction_function(L,1);}
static int np_count_nonzero(lua_State *L){return truth_reduction_function(L,2);}
static int np_sum(lua_State*L){return reduction_function(L,LN_REDUCE_SUM);}
static int np_prod(lua_State*L){return reduction_function(L,LN_REDUCE_PROD);}
static int np_mean(lua_State*L){return reduction_function(L,LN_REDUCE_MEAN);}
/* Lua-native argument convention: average(a, {axis=...,weights=...,
 * returned=true,keepdims=true}); optionally average(a, axis, {weights=...}).
 * returned=true yields two Lua return values instead of a Python tuple. */
static int np_average(lua_State *L){
    lua_array *u=check_array(L,1);
    int opts_idx=0;
    uint8_t flags[LN_MAXDIMS];set_all_reduction_axes(u->a->nd,flags);
    int keepdims=0,returned=0;
    int top=lua_gettop(L);
    if(top>=2&&lua_type(L,2)!=LUA_TNIL){
        if(lua_type(L,2)==LUA_TTABLE){
            /* Unlike a bare axis list, named average options are recognized
             * by the presence of their specific keys. */
            lua_getfield(L,2,"weights");int has_weights=lua_type(L,-1)!=LUA_TNIL;lua_pop(L,1);
            lua_getfield(L,2,"returned");int has_returned=lua_type(L,-1)!=LUA_TNIL;lua_pop(L,1);
            lua_getfield(L,2,"keepdims");int has_keepdims=lua_type(L,-1)!=LUA_TNIL;lua_pop(L,1);
            lua_getfield(L,2,"axis");int has_axis=lua_type(L,-1)!=LUA_TNIL;lua_pop(L,1);
            if(has_weights||has_returned||has_keepdims||has_axis)opts_idx=2;
            else if(parse_reduction_axes_value(L,2,u->a->nd,flags))return 0;
        }else if(parse_reduction_axes_value(L,2,u->a->nd,flags))return 0;
    }
    if(top>=3&&lua_type(L,3)!=LUA_TNIL){
        if(opts_idx)return luaL_error(L,"average options specified twice");
        if(lua_type(L,3)!=LUA_TTABLE)return luaL_error(L,"average options must be a table");
        opts_idx=3;
    }
    ln_array *weights=NULL;
    if(opts_idx){
        lua_getfield(L,opts_idx,"axis");
        if(lua_type(L,-1)!=LUA_TNIL){
            if(parse_reduction_axes_value(L,-1,u->a->nd,flags)){lua_pop(L,1);return 0;}
        }
        lua_pop(L,1);
        lua_getfield(L,opts_idx,"keepdims");
        if(lua_type(L,-1)!=LUA_TNIL){
            if(lua_type(L,-1)!=LUA_TBOOLEAN){lua_pop(L,1);return luaL_error(L,"keepdims must be boolean");}
            keepdims=lua_toboolean(L,-1);
        }
        lua_pop(L,1);
        lua_getfield(L,opts_idx,"returned");
        if(lua_type(L,-1)!=LUA_TNIL){
            if(lua_type(L,-1)!=LUA_TBOOLEAN){lua_pop(L,1);return luaL_error(L,"returned must be boolean");}
            returned=lua_toboolean(L,-1);
        }
        lua_pop(L,1);
        lua_getfield(L,opts_idx,"weights");
        if(lua_type(L,-1)!=LUA_TNIL){
            int idx=lua_absindex(L,-1);
            weights=coerce_numeric_array_arg(L,idx);
            if(!weights)return 0;
            /* Keep the new ndarray userdata rooted across C allocations. */
            if(lua_gettop(L)>idx){lua_rotate(L,idx,1);lua_pop(L,1);}
        }
        lua_pop(L,1);
    }
    ln_error err={{0}};ln_array *sumw=NULL;
    ln_array *r=ln_average(u->a,weights,flags,keepdims,returned?&sumw:NULL,&err);
    if(!r)return fail(L,&err);
    int count=push_reduction_result(L,r);
    if(returned){push_reduction_result(L,sumw);count++;}
    return count;
}
/* NumPy-compatible array-first variance/standard-deviation reductions.
 * Lua axes are 1-based, while C core axis_flags are 0-based. */
static int stats_function(lua_State *L,int standard_deviation,int omit_nan) {
    lua_array *u=check_array(L,1);
    reduction_call_options opts;
    if(parse_reduction_call(L,u->a->nd,LN_REDUCE_MEAN,&opts))return 0;
    double ddof=0.0;
    int has_ddof=0;
    if (opts.options_table_index) {
        lua_getfield(L,opts.options_table_index,"mean");
        int has_mean=lua_type(L,-1)!=LUA_TNIL;lua_pop(L,1);
        if(has_mean)return luaL_error(L,"mean= for var/std is not yet supported");
        lua_getfield(L,opts.options_table_index,"ddof");
        if (lua_type(L,-1)!=LUA_TNIL) {
            has_ddof=1;
            int ok=0; ddof=(double)lua_tonumberx(L,-1,&ok);
            if(!ok){lua_pop(L,1);return luaL_error(L,"ddof must be numeric");}
        }
        lua_pop(L,1);
        lua_getfield(L,opts.options_table_index,"correction");
        if(lua_type(L,-1)!=LUA_TNIL) {
            if(has_ddof){lua_pop(L,1);return luaL_error(L,"ddof and correction cannot both be specified");}
            int ok=0;ddof=(double)lua_tonumberx(L,-1,&ok);
            if(!ok){lua_pop(L,1);return luaL_error(L,"correction must be numeric");}
        }
        lua_pop(L,1);
    }
    ln_error e={{0}};
    ln_array *nanwhere=omit_nan?ln_stats_nan_where(u->a,opts.where,&e):NULL;
    if(omit_nan && !nanwhere)return fail(L,&e);
    ln_array *r=ln_stats_var_std(u->a,opts.axis_flags,opts.keepdims,
       opts.dtype,omit_nan?nanwhere:opts.where,ddof,standard_deviation,omit_nan,
       opts.out?opts.out->a:NULL,&e);
    ln_array_free(nanwhere);
    if(!r)return fail(L,&e);
    if(opts.out) {
        ln_array_free(r);
        lua_getfield(L,opts.options_table_index,"out");
        return 1;
    }
    return push_reduction_result(L,r);
}
static int np_var(lua_State*L){return stats_function(L,0,0);}
static int np_nanvar(lua_State*L){return stats_function(L,0,1);}
static int np_std(lua_State*L){return stats_function(L,1,0);}
static int np_nanstd(lua_State*L){return stats_function(L,1,1);}
static int extrema_function(lua_State *L,int maximum,int omit_nan) {
    lua_array *u=check_array(L,1);
    reduction_call_options opts;
    if(parse_reduction_call(L,u->a->nd,LN_REDUCE_SUM,&opts))return 0;
    if(opts.dtype)return luaL_error(L,"min/max do not accept dtype=");
    if(opts.options_table_index){
        static const char *invalid[]={"ddof","correction","mean",NULL};
        for(int i=0;invalid[i];i++){
            lua_getfield(L,opts.options_table_index,invalid[i]);
            int present=lua_type(L,-1)!=LUA_TNIL;lua_pop(L,1);
            if(present)return luaL_error(L,"unsupported min/max option '%s'",invalid[i]);
        }
    }
    ln_error e={{0}};
    ln_array *r=(omit_nan?ln_stats_nan_extrema:ln_stats_extrema)(u->a,opts.axis_flags,opts.keepdims,opts.where,
       opts.has_initial,opts.initial_v,opts.initial_i,opts.initial_is_integer,
       maximum,opts.out?opts.out->a:NULL,&e);
    if(!r)return fail(L,&e);
    if(opts.out){ln_array_free(r);lua_getfield(L,opts.options_table_index,"out");return 1;}
    return push_reduction_result(L,r);
}
static int np_amin(lua_State*L){return extrema_function(L,0,0);}
static int np_amax(lua_State*L){return extrema_function(L,1,0);}
static int np_nanmin(lua_State*L){return extrema_function(L,0,1);}
static int np_nanmax(lua_State*L){return extrema_function(L,1,1);}
static int argextrema_function(lua_State *L,int maximum,int omit_nan){
    lua_array *u=check_array(L,1);
    reduction_call_options opts;
    if(parse_reduction_call(L,u->a->nd,LN_REDUCE_SUM,&opts))return 0;
    int axis=-1;
    int axis_idx=2;
    if(opts.options_table_index){
        lua_getfield(L,opts.options_table_index,"axis");
        int has_axis=lua_type(L,-1)!=LUA_TNIL;
        lua_pop(L,1);
        axis_idx=has_axis?opts.options_table_index:2;
    }
    int type;
    if(axis_idx==opts.options_table_index && opts.options_table_index){
        lua_getfield(L,axis_idx,"axis");
        type=lua_type(L,-1);
    }else type=lua_type(L,2);
    if(type==LUA_TTABLE){
        if(axis_idx==opts.options_table_index&&opts.options_table_index)lua_pop(L,1);
        return luaL_error(L,"argmin/argmax accept only a single axis");
    }
    if(type==LUA_TNUMBER){
        int valid=0;
        lua_Integer raw=lua_tointegerx(L,axis_idx==opts.options_table_index&&opts.options_table_index?-1:2,&valid);
        if(!valid){
            if(axis_idx==opts.options_table_index&&opts.options_table_index)lua_pop(L,1);
            return luaL_error(L,"axis must be an integer");
        }
        if(normalize_lua_axis(L,raw,u->a->nd,&axis))return 0;
    }
    if(axis_idx==opts.options_table_index&&opts.options_table_index)lua_pop(L,1);
    if(opts.has_initial||opts.where||opts.dtype)return luaL_error(L,"argmin/argmax do not accept initial, where, or dtype");
    if(opts.options_table_index){
        static const char *bad[]={"ddof","correction","mean",NULL};
        for(int i=0;bad[i];i++){
            lua_getfield(L,opts.options_table_index,bad[i]);
            int present=lua_type(L,-1)!=LUA_TNIL;lua_pop(L,1);
            if(present)return luaL_error(L,"unsupported argmin/argmax option '%s'",bad[i]);
        }
    }
    ln_error e={{0}};
    ln_array *r=(omit_nan?ln_stats_nan_argextrema:ln_stats_argextrema)(u->a,axis,opts.keepdims,maximum,
         opts.out?opts.out->a:NULL,&e);
    if(!r)return fail(L,&e);
    if(opts.out){ln_array_free(r);lua_getfield(L,opts.options_table_index,"out");return 1;}
    return push_reduction_result(L,r);
}
static int np_argmin(lua_State*L){return argextrema_function(L,0,0);}
static int np_argmax(lua_State*L){return argextrema_function(L,1,0);}
static int np_nanargmin(lua_State*L){return argextrema_function(L,0,1);}
static int np_nanargmax(lua_State*L){return argextrema_function(L,1,1);}
static int np_ptp(lua_State *L){
    lua_array *u=check_array(L,1);
    reduction_call_options opts;
    if(parse_reduction_call(L,u->a->nd,LN_REDUCE_SUM,&opts))return 0;
    if(opts.dtype||opts.where||opts.has_initial)return luaL_error(L,"ptp does not accept dtype, where, or initial");
    if(opts.options_table_index){
        static const char *bad[]={"ddof","correction","mean",NULL};
        for(int i=0;bad[i];i++){
            lua_getfield(L,opts.options_table_index,bad[i]);
            int present=lua_type(L,-1)!=LUA_TNIL;lua_pop(L,1);
            if(present)return luaL_error(L,"unsupported ptp option '%s'",bad[i]);
        }
    }
    ln_error e={{0}};
    ln_array *r=ln_stats_ptp(u->a,opts.axis_flags,opts.keepdims,
                   opts.out?opts.out->a:NULL,&e);
    if(!r)return fail(L,&e);
    if(opts.out){ln_array_free(r);lua_getfield(L,opts.options_table_index,"out");return 1;}
    return push_reduction_result(L,r);
}





/* Quantiles are computed in C; q and option tables are decoded here.
 * LuaRay axes use one-based indices, including negative indexes. */
static int quantile_has_options(lua_State *L,int idx){
    idx=lua_absindex(L,idx);
    lua_pushnil(L);
    while(lua_next(L,idx)){
        if(lua_type(L,-2)==LUA_TSTRING){lua_pop(L,2);return 1;}
        lua_pop(L,1);
    }
    return 0;
}
static int quantile_api(lua_State *L,int which,int omit_nan){
    lua_array *u=check_array(L,1);
    int firstopt=which==0?2:3;
    int last=lua_gettop(L);
    double *qs=NULL;ln_intp nq=1;int scalar_q=1;
    double qsingle=0.5;int integer_q=which!=0;
    const ln_dtype *q_dtype=NULL;int q_vector_table=0;
    if(which!=0){
        int qt=lua_type(L,2);
        if(qt==LUA_TNUMBER){
            qsingle=(double)lua_tonumberx(L,2,NULL);integer_q=lua_isinteger(L,2);
        }else if(qt==LUA_TTABLE){
            size_t len=lua_rawlen(L,2);
            if(!len || len>SIZE_MAX/sizeof(double))return luaL_error(L,"q must be a nonempty one-dimensional list");
            scalar_q=0;nq=(ln_intp)len;q_vector_table=1;
            qs=(double*)malloc(len*sizeof(double));
            if(!qs)return luaL_error(L,"out of memory");
            for(size_t i=0;i<len;i++){
                lua_geti(L,2,(lua_Integer)i+1);
                int ok=0;qs[i]=(double)lua_tonumberx(L,-1,&ok);
                if(!lua_isinteger(L,-1))integer_q=0;
                lua_pop(L,1);
                if(!ok){free(qs);return luaL_error(L,"q entries must be numeric");}
            }
        }else{
            lua_array *qarr=test_array(L,2);
            if(!qarr || qarr->a->nd>1){return luaL_error(L,"q must be a number or one-dimensional numeric array");}
            integer_q=qarr->a->descr->kind=='i'||qarr->a->descr->kind=='u';
            q_dtype=qarr->a->descr;
            if(qarr->a->nd==0){
                ln_error err={{0}};
                if(ln_cast_strided_numeric(qarr->a->data,0,qarr->a->descr,
                     (char*)&qsingle,0,ln_dtype_by_num(LN_DOUBLE),1,&err)<0)return fail(L,&err);
            }else{
                ln_intp n=qarr->a->dimensions[0];
                if(n<=0 || (uintmax_t)n>SIZE_MAX/sizeof(double))return luaL_error(L,"q must be nonempty");
                qs=(double*)malloc((size_t)n*sizeof(double));
                if(!qs)return luaL_error(L,"out of memory");
                scalar_q=0;nq=n;
                ln_error err={{0}};
                for(ln_intp i=0;i<n;i++){
                    if(ln_cast_strided_numeric(qarr->a->data+i*qarr->a->strides[0],0,qarr->a->descr,
                        (char*)&qs[i],0,ln_dtype_by_num(LN_DOUBLE),1,&err)<0){
                        free(qs);return fail(L,&err);
                    }
                }
            }
        }
    }
    double *q=qs?qs:&qsingle;
    if(which==2)for(ln_intp i=0;i<nq;i++)q[i]/=100.0;
    uint8_t flags[LN_MAXDIMS]={0};
    set_all_reduction_axes(u->a->nd,flags);
    int keepdims=0,method=which==0?6:0,opts_idx=0;
    lua_array *out=NULL;
    if(firstopt<=last && lua_type(L,firstopt)!=LUA_TNIL){
        if(lua_type(L,firstopt)==LUA_TTABLE && quantile_has_options(L,firstopt)){
            opts_idx=firstopt;
        }else if(lua_type(L,firstopt)==LUA_TTABLE){
            /* A pure axis list is allowed, including {}. */
            opts_idx=0;
            if(parse_reduction_axes_value(L,firstopt,u->a->nd,flags)){free(qs);return 0;}
        }else{
            if(parse_reduction_axes_value(L,firstopt,u->a->nd,flags)){free(qs);return 0;}
        }
    }
    if(last>=firstopt+1 && lua_type(L,firstopt+1)!=LUA_TNIL){
        if(lua_type(L,firstopt+1)!=LUA_TTABLE){free(qs);return luaL_error(L,"options must be a table");}
        opts_idx=firstopt+1;
    }
    if(opts_idx){
        opts_idx=lua_absindex(L,opts_idx);
        lua_getfield(L,opts_idx,"axis");
        if(lua_type(L,-1)!=LUA_TNIL){
            if(parse_reduction_axes_value(L,-1,u->a->nd,flags)){lua_pop(L,1);free(qs);return 0;}
        }
        lua_pop(L,1);
        lua_getfield(L,opts_idx,"keepdims");
        if(lua_type(L,-1)!=LUA_TNIL){
            if(lua_type(L,-1)!=LUA_TBOOLEAN){lua_pop(L,1);free(qs);return luaL_error(L,"keepdims must be boolean");}
            keepdims=lua_toboolean(L,-1);
        }
        lua_pop(L,1);
        lua_getfield(L,opts_idx,"out");
        if(lua_type(L,-1)!=LUA_TNIL){
            out=test_array(L,-1);
            if(!out){lua_pop(L,1);free(qs);return luaL_error(L,"out must be an ndarray");}
        }
        lua_pop(L,1);
        lua_getfield(L,opts_idx,"method");
        if(which==0 && lua_type(L,-1)!=LUA_TNIL){
            lua_pop(L,1);free(qs);return luaL_error(L,"median does not accept method");
        }
        if(lua_type(L,-1)!=LUA_TNIL){
            const char *m=lua_tostring(L,-1);
            static const char *methods[]={"linear","lower","higher","nearest","midpoint","inverted_cdf"};
            method=-1;
            if(m)for(int i=0;i<6;i++)if(strcmp(m,methods[i])==0){method=i;break;}
            if(method<0){lua_pop(L,1);free(qs);return luaL_error(L,"unsupported quantile method");}
        }
        lua_pop(L,1);
        /* No accidental acceptance of ignored keyword arguments. */
        lua_pushnil(L);
        while(lua_next(L,opts_idx)){
            const char *k=lua_type(L,-2)==LUA_TSTRING?lua_tostring(L,-2):NULL;
            int valid=k&&(strcmp(k,"axis")==0||strcmp(k,"keepdims")==0||
                  strcmp(k,"out")==0||strcmp(k,"method")==0);
            if(!valid){
                char name[96];snprintf(name,sizeof(name),"%s",k?k:"non-string key");
                lua_pop(L,2);free(qs);
                return luaL_error(L,"unsupported quantile option '%s'",name);
            }
            lua_pop(L,1);
        }
    }
    for(ln_intp i=0;i<nq;i++)if(!isfinite(q[i])||q[i]<0||q[i]>1){
        free(qs);return luaL_error(L,"quantile values outside allowed range");
    }
    if(which==1 && integer_q && method==0)method=7;
    /* Vector quantile fractions participate in result dtype promotion.
     * Scalar Lua floating fractions are weakly typed, like Python scalars. */
    const ln_dtype *preferred=NULL;
    if(which!=0 && (method==0||method==4)){
        if(q_vector_table)preferred=ln_dtype_by_num(LN_DOUBLE);
        else if(q_dtype && q_dtype->kind=='f' && !scalar_q){
            int sr=u->a->descr->elsize<=2?2:(u->a->descr->elsize<=4?4:8);
            int qr=q_dtype->elsize<=2?2:(q_dtype->elsize<=4?4:8);
            int rank=qr;
            if(u->a->descr->kind=='f'){
                if(sr>rank)rank=sr;
            }else{
                if(sr>=8)rank=8;
                else if(rank<4)rank=4;
            }
            preferred=ln_dtype_by_num(rank<=2?LN_HALF:(rank<=4?LN_FLOAT:LN_DOUBLE));
        }
    }
    ln_error e={{0}};
    ln_array *r=ln_quantile(u->a,flags,keepdims,q,nq,scalar_q,method,preferred,out?out->a:NULL,omit_nan,&e);
    free(qs);
    if(!r)return fail(L,&e);
    if(out){ln_array_free(r);lua_getfield(L,opts_idx,"out");return 1;}
    return push_reduction_result(L,r);
}
static int np_median(lua_State *L){return quantile_api(L,0,0);}
static int np_quantile(lua_State *L){return quantile_api(L,1,0);}
static int np_percentile(lua_State *L){return quantile_api(L,2,0);}
static int np_nanmedian(lua_State *L){return quantile_api(L,0,1);}
static int np_nanquantile(lua_State *L){return quantile_api(L,1,1);}
static int np_nanpercentile(lua_State *L){return quantile_api(L,2,1);}

typedef struct accumulate_call_options {
    int axis;
    const ln_dtype *dtype;
    lua_array *out;
    int options_table_index;
} accumulate_call_options;

static int
parse_accumulate_options_table(lua_State *L,int idx,int nd,accumulate_call_options *opts)
{
    idx=lua_absindex(L,idx);opts->options_table_index=idx;
    lua_getfield(L,idx,"axis");
    if(lua_type(L,-1)!=LUA_TNIL){
        int ok=0;lua_Integer raw=lua_tointegerx(L,-1,&ok);
        if(!ok){lua_pop(L,1);return luaL_error(L,"axis must be an integer");}
        if(normalize_lua_axis(L,raw,nd,&opts->axis)){lua_pop(L,1);return 1;}
    }
    lua_pop(L,1);
    lua_getfield(L,idx,"dtype");
    if(lua_type(L,-1)!=LUA_TNIL){const char*name=lua_tostring(L,-1);opts->dtype=name?ln_dtype_by_name(name):NULL;if(!opts->dtype){lua_pop(L,1);return luaL_error(L,"unsupported dtype");}}
    lua_pop(L,1);
    lua_getfield(L,idx,"out");
    if(lua_type(L,-1)!=LUA_TNIL){opts->out=test_array(L,-1);if(!opts->out){lua_pop(L,1);return luaL_error(L,"out must be an ndarray or nil");}}
    lua_pop(L,1);
    return 0;
}

static int
parse_accumulate_call(lua_State *L,int nd,accumulate_call_options *opts)
{
    memset(opts,0,sizeof(*opts));opts->axis=0;
    int top=lua_gettop(L);
    if(top<2||lua_type(L,2)==LUA_TNIL)return 0;
    if(lua_type(L,2)==LUA_TTABLE)return parse_accumulate_options_table(L,2,nd,opts);
    int ok=0;lua_Integer raw=lua_tointegerx(L,2,&ok);
    if(!ok)return luaL_error(L,"axis must be an integer or options table");
    if(normalize_lua_axis(L,raw,nd,&opts->axis))return 1;
    if(top>=3&&lua_type(L,3)!=LUA_TNIL){
        if(lua_type(L,3)!=LUA_TTABLE)return luaL_error(L,"third accumulate argument must be an options table");
        int positional=opts->axis;
        lua_getfield(L,3,"axis");int has_axis=lua_type(L,-1)!=LUA_TNIL;lua_pop(L,1);
        if(parse_accumulate_options_table(L,3,nd,opts))return 1;
        if(!has_axis)opts->axis=positional;
    }
    return 0;
}

static int
accumulate_function(lua_State *L,ln_reduce_op op)
{
    lua_array*u=check_array(L,1);
    if(u->a->nd==0)return luaL_error(L,"cannot accumulate on a scalar");
    accumulate_call_options opts;
    if(parse_accumulate_call(L,u->a->nd,&opts))return 0;
    ln_error e={{0}};
    if(opts.out){
        if(ln_accumulate_into_ex(u->a,opts.axis,opts.dtype,opts.out->a,op,&e)<0)return fail(L,&e);
        lua_getfield(L,opts.options_table_index,"out");return 1;
    }
    ln_array*r=ln_accumulate_ex(u->a,opts.axis,opts.dtype,op,&e);
    if(!r)return fail(L,&e);
    return push_array(L,r);
}

/* cumsum/cumprod use NumPy's axis=None flattening (logical C order),
 * unlike the underlying ufunc accumulate API whose default is axis=0.
 * LuaRay exposes axes from 1; negative axis positions remain supported. */
static int cumulative_function(lua_State *L, ln_reduce_op op, int omit_nan) {
    lua_array *u=check_array(L,1);
    ln_error e={{0}};
    accumulate_call_options opts;
    memset(&opts,0,sizeof(opts));
    int flatten=1;
    int top=lua_gettop(L);
    int option_idx=0;
    if (top>=2 && lua_type(L,2)!=LUA_TNIL) {
        if (lua_type(L,2)==LUA_TTABLE) {
            option_idx=2;
        } else {
            int ok=0;
            lua_Integer raw=lua_tointegerx(L,2,&ok);
            if (!ok) return luaL_error(L,"axis must be an integer, nil, or options table");
            if (normalize_lua_axis(L,raw,u->a->nd,&opts.axis)) return 0;
            flatten=0;
        }
    }
    if(top>=3 && lua_type(L,3)!=LUA_TNIL) {
        if(option_idx || lua_type(L,3)!=LUA_TTABLE)
            return luaL_error(L,"third cumulative argument must be an options table");
        option_idx=3;
    }
    if(option_idx) {
        int oi=lua_absindex(L,option_idx);
        lua_getfield(L,oi,"axis");
        if(lua_type(L,-1)!=LUA_TNIL) {
            int ok=0;
            lua_Integer raw=lua_tointegerx(L,-1,&ok);
            if (!ok){lua_pop(L,1);return luaL_error(L,"axis must be an integer");}
            if (normalize_lua_axis(L,raw,u->a->nd,&opts.axis)) {lua_pop(L,1);return 0;}
            flatten=0;
        }
        lua_pop(L,1);
        lua_getfield(L,oi,"dtype");
        if(lua_type(L,-1)!=LUA_TNIL) {
            const char *name=lua_tostring(L,-1);
            opts.dtype=name?ln_dtype_by_name(name):NULL;
            if(!opts.dtype){lua_pop(L,1);return luaL_error(L,"unsupported dtype");}
        }
        lua_pop(L,1);
        lua_getfield(L,oi,"out");
        if(lua_type(L,-1)!=LUA_TNIL) {
            opts.out=test_array(L,-1);
            if(!opts.out){lua_pop(L,1);return luaL_error(L,"out must be an ndarray");}
        }
        lua_pop(L,1);
    }
    ln_array *flat=NULL, *clean=NULL;
    const ln_array *input=u->a;
    if(flatten || u->a->nd==0) {
        ln_intp dims[1]={ln_array_size(u->a)};
        if(dims[0]<0)return luaL_error(L,"array too large");
        flat=ln_array_reshape_c(u->a,1,dims,&e);
        if(!flat)return fail(L,&e);
        input=flat;
        opts.axis=0;
    }
    if(omit_nan) {
        clean=ln_stats_nan_replace(input,op==LN_REDUCE_PROD,&e);
        if(!clean){ln_array_free(flat);return fail(L,&e);}
        input=clean;
    }
    if(opts.out) {
        int rc=ln_accumulate_into_ex(input,opts.axis,opts.dtype,opts.out->a,op,&e);
        ln_array_free(clean);ln_array_free(flat);
        if(rc<0)return fail(L,&e);
        lua_getfield(L,option_idx,"out");return 1;
    }
    ln_array *r=ln_accumulate_ex(input,opts.axis,opts.dtype,op,&e);
    ln_array_free(clean);ln_array_free(flat);
    if(!r)return fail(L,&e);
    return push_array(L,r);
}
static int np_cumsum(lua_State *L){return cumulative_function(L,LN_REDUCE_SUM,0);}
static int np_cumprod(lua_State *L){return cumulative_function(L,LN_REDUCE_PROD,0);}
static int np_nancumsum(lua_State *L){return cumulative_function(L,LN_REDUCE_SUM,1);}
static int np_nancumprod(lua_State *L){return cumulative_function(L,LN_REDUCE_PROD,1);}
static int np_add_accumulate(lua_State*L){return accumulate_function(L,LN_REDUCE_SUM);}
static int np_multiply_accumulate(lua_State*L){return accumulate_function(L,LN_REDUCE_PROD);}

typedef struct reduceat_call_options {
    int axis;
    const ln_dtype *dtype;
    lua_array *out;
    int options_table_index;
} reduceat_call_options;

static int
parse_reduceat_options_table(lua_State *L,int idx,int nd,reduceat_call_options *opts)
{
    idx=lua_absindex(L,idx);opts->options_table_index=idx;
    lua_getfield(L,idx,"axis");
    if(lua_type(L,-1)!=LUA_TNIL){
        int ok=0;lua_Integer raw=lua_tointegerx(L,-1,&ok);
        if(!ok){lua_pop(L,1);return luaL_error(L,"axis must be an integer");}
        if(normalize_lua_axis(L,raw,nd,&opts->axis)){lua_pop(L,1);return 1;}
    }
    lua_pop(L,1);
    lua_getfield(L,idx,"dtype");
    if(lua_type(L,-1)!=LUA_TNIL){
        const char*name=lua_tostring(L,-1);
        opts->dtype=name?ln_dtype_by_name(name):NULL;
        if(!opts->dtype){lua_pop(L,1);return luaL_error(L,"unsupported dtype");}
    }
    lua_pop(L,1);
    lua_getfield(L,idx,"out");
    if(lua_type(L,-1)!=LUA_TNIL){
        opts->out=test_array(L,-1);
        if(!opts->out){lua_pop(L,1);return luaL_error(L,"out must be an ndarray or nil");}
    }
    lua_pop(L,1);
    return 0;
}

static int
parse_reduceat_call(lua_State *L,int nd,reduceat_call_options *opts)
{
    memset(opts,0,sizeof(*opts));opts->axis=0;
    int top=lua_gettop(L);
    if(top<3||lua_type(L,3)==LUA_TNIL)return 0;
    if(lua_type(L,3)==LUA_TTABLE)return parse_reduceat_options_table(L,3,nd,opts);
    int ok=0;lua_Integer raw=lua_tointegerx(L,3,&ok);
    if(!ok)return luaL_error(L,"axis must be an integer or options table");
    if(normalize_lua_axis(L,raw,nd,&opts->axis))return 1;
    if(top>=4&&lua_type(L,4)!=LUA_TNIL){
        if(lua_type(L,4)!=LUA_TTABLE)return luaL_error(L,"fourth reduceat argument must be an options table");
        int positional=opts->axis;
        lua_getfield(L,4,"axis");int has_axis=lua_type(L,-1)!=LUA_TNIL;lua_pop(L,1);
        if(parse_reduceat_options_table(L,4,nd,opts))return 1;
        if(!has_axis)opts->axis=positional;
    }
    return 0;
}

static int
validate_reduceat_raw_index(lua_State *L,lua_Integer raw,ln_intp axis_len,
                            int axis,ln_intp *normalized)
{
    return normalize_lua_index_value(L,raw,axis_len,axis,normalized);
}

/* Host adaptation of PyUFunc_Reduceat's integer index-array input.  Public
 * Lua positions follow this port's 1-based convention; negative positions
 * count from the end.  The core receives NumPy-style zero-based positions. */
static int
parse_reduceat_indices(lua_State *L,int arg,ln_intp axis_len,int axis,
                       ln_intp **out_indices,ln_intp *out_n)
{
    *out_indices=NULL;*out_n=0;
    int t=lua_type(L,arg);
    if(t==LUA_TTABLE){
        size_t n=lua_rawlen(L,arg);
        if(n>(size_t)INTPTR_MAX)return luaL_error(L,"too many reduceat indices");
        /* Validate before allocation so Lua errors cannot strand a C buffer. */
        for(size_t i=1;i<=n;i++){
            lua_geti(L,arg,(lua_Integer)i);
            int ok=0;lua_Integer raw=lua_tointegerx(L,-1,&ok);
            lua_pop(L,1);
            if(!ok)return luaL_error(L,"reduceat indices must be integers");
            ln_intp q;
            if(validate_reduceat_raw_index(L,raw,axis_len,axis,&q))return 1;
        }
        ln_intp *v=n?(ln_intp*)malloc(n*sizeof(*v)):NULL;
        if(n&&!v)return luaL_error(L,"out of memory parsing reduceat indices");
        for(size_t i=1;i<=n;i++){
            lua_geti(L,arg,(lua_Integer)i);
            lua_Integer raw=lua_tointegerx(L,-1,NULL);lua_pop(L,1);
            /* Already validated above; normalization cannot fail here. */
            if(raw>0)v[i-1]=(ln_intp)raw-1;
            else v[i-1]=axis_len+(ln_intp)raw;
        }
        *out_indices=v;*out_n=(ln_intp)n;return 0;
    }

    lua_array *idx=test_array(L,arg);
    if(!idx)return luaL_error(L,"reduceat indices must be a table or 1-D integer ndarray");
    if(idx->a->nd!=1)return luaL_error(L,"reduceat indices must be one-dimensional");
    if(idx->a->descr->type_num==LN_BOOL ||
       (idx->a->descr->kind!='i'&&idx->a->descr->kind!='u'))
        return luaL_error(L,"reduceat indices must have an integer dtype");
    ln_intp n=idx->a->dimensions[0];
    ln_error e={{0}};
    for(ln_intp i=0;i<n;i++){
        ln_intp pos[1]={i};double d=0;int64_t iv=0;int isint=0;
        if(ln_array_get_number(idx->a,pos,&d,&iv,&isint,&e)<0)return fail(L,&e);
        if(!isint)return luaL_error(L,"reduceat index cannot be represented by Lua's integer index type");
        ln_intp q;
        if(validate_reduceat_raw_index(L,(lua_Integer)iv,axis_len,axis,&q))return 1;
    }
    ln_intp *v=n?(ln_intp*)malloc((size_t)n*sizeof(*v)):NULL;
    if(n&&!v)return luaL_error(L,"out of memory parsing reduceat indices");
    for(ln_intp i=0;i<n;i++){
        ln_intp pos[1]={i};double d=0;int64_t iv=0;int isint=0;
        (void)ln_array_get_number(idx->a,pos,&d,&iv,&isint,&e);
        v[i]=iv>0?(ln_intp)iv-1:axis_len+(ln_intp)iv;
    }
    *out_indices=v;*out_n=n;return 0;
}

static int
reduceat_function(lua_State *L,ln_reduce_op op)
{
    lua_array *u=check_array(L,1);
    if(u->a->nd==0)return luaL_error(L,"cannot reduceat on a scalar");
    reduceat_call_options opts;
    if(parse_reduceat_call(L,u->a->nd,&opts))return 0;
    ln_intp *indices=NULL,nindices=0;
    if(parse_reduceat_indices(L,2,u->a->dimensions[opts.axis],opts.axis,
                              &indices,&nindices))return 0;
    ln_error e={{0}};
    if(opts.out){
        int rc=ln_reduceat_into_ex(u->a,indices,nindices,opts.axis,opts.dtype,
                                   opts.out->a,op,&e);
        free(indices);
        if(rc<0)return fail(L,&e);
        lua_getfield(L,opts.options_table_index,"out");return 1;
    }
    ln_array *r=ln_reduceat_ex(u->a,indices,nindices,opts.axis,opts.dtype,op,&e);
    free(indices);
    if(!r)return fail(L,&e);
    return push_array(L,r);
}

static int np_add_reduceat(lua_State*L){return reduceat_function(L,LN_REDUCE_SUM);}
static int np_multiply_reduceat(lua_State*L){return reduceat_function(L,LN_REDUCE_PROD);}

static int np_add(lua_State*L){return binary_function_named(L,"add");}
static int np_subtract(lua_State*L){return binary_function_named(L,"subtract");}
static int np_multiply(lua_State*L){return binary_function_named(L,"multiply");}
static int np_true_divide(lua_State*L){return binary_function_named(L,"true_divide");}
static int np_equal(lua_State*L){return binary_function_named(L,"equal");}
static int np_not_equal(lua_State*L){return binary_function_named(L,"not_equal");}
static int np_less(lua_State*L){return binary_function_named(L,"less");}
static int np_less_equal(lua_State*L){return binary_function_named(L,"less_equal");}
static int np_greater(lua_State*L){return binary_function_named(L,"greater");}
static int np_greater_equal(lua_State*L){return binary_function_named(L,"greater_equal");}
static int np_logical_and(lua_State*L){return binary_function_named(L,"logical_and");}
static int np_logical_or(lua_State*L){return binary_function_named(L,"logical_or");}
static int np_logical_xor(lua_State*L){return binary_function_named(L,"logical_xor");}
static int np_maximum(lua_State*L){return binary_function_named(L,"maximum");}
static int np_minimum(lua_State*L){return binary_function_named(L,"minimum");}
static int np_floor_divide(lua_State*L){return binary_function_named(L,"floor_divide");}
static int np_remainder(lua_State*L){return binary_function_named(L,"remainder");}
static int np_power(lua_State*L){return binary_function_named(L,"power");}
static int np_bitwise_and(lua_State*L){return binary_function_named(L,"bitwise_and");}
static int np_bitwise_or(lua_State*L){return binary_function_named(L,"bitwise_or");}
static int np_bitwise_xor(lua_State*L){return binary_function_named(L,"bitwise_xor");}
static int np_fmax(lua_State*L){return binary_function_named(L,"fmax");}
static int np_fmin(lua_State*L){return binary_function_named(L,"fmin");}
static int np_copysign(lua_State*L){return binary_function_named(L,"copysign");}

static int np_matmul(lua_State *L){
    lua_array *a=check_array(L,1),*b=check_array(L,2);
    lua_array *out=NULL;int out_index=0;
    if(lua_gettop(L)>=3&&lua_type(L,3)!=LUA_TNIL){
        if(lua_type(L,3)==LUA_TUSERDATA){out=test_array(L,3);out_index=3;if(!out)return luaL_error(L,"out must be an ndarray");}
        else if(lua_type(L,3)==LUA_TTABLE){
            lua_getfield(L,3,"out");
            if(lua_type(L,-1)!=LUA_TNIL){out=test_array(L,-1);if(!out){lua_pop(L,1);return luaL_error(L,"out must be an ndarray or nil");}}
            lua_pop(L,1);
            if(out)out_index=3;
        }
        else return luaL_error(L,"matmul third argument must be an output ndarray or {out=...}");
    }
    ln_error e={{0}};
    if(out){
        if(ln_matmul_into(a->a,b->a,out->a,&e)<0)return fail(L,&e);
        if(out_index==3&&lua_type(L,3)==LUA_TTABLE){lua_getfield(L,3,"out");return 1;}
        lua_pushvalue(L,3);return 1;
    }
    ln_array *r=ln_matmul(a->a,b->a,&e);
    if(!r)return fail(L,&e);
    if(r->nd==0){int ret=push_scalar_at(L,r,NULL);ln_array_free(r);return ret;}
    return push_array(L,r);
}


static int parse_linalg_out(lua_State *L,int arg,lua_array **out,int *from_table){
    *out=NULL;*from_table=0;
    if(lua_gettop(L)<arg||lua_type(L,arg)==LUA_TNIL)return 0;
    if(lua_type(L,arg)==LUA_TUSERDATA){
        *out=test_array(L,arg);
        if(!*out)return luaL_error(L,"out must be an ndarray");
        return 0;
    }
    if(lua_type(L,arg)==LUA_TTABLE){
        *from_table=1;
        lua_getfield(L,arg,"out");
        if(lua_type(L,-1)!=LUA_TNIL){
            *out=test_array(L,-1);
            if(!*out){lua_pop(L,1);return luaL_error(L,"out must be an ndarray or nil");}
        }
        lua_pop(L,1);return 0;
    }
    return luaL_error(L,"output argument must be an ndarray or {out=...}");
}

static int np_dot(lua_State *L){
    lua_array *a=check_array(L,1),*b=check_array(L,2),*out=NULL;
    int from_table=0;if(parse_linalg_out(L,3,&out,&from_table))return 0;
    ln_error e={{0}};
    if(out){
        if(ln_dot_into(a->a,b->a,out->a,&e)<0)return fail(L,&e);
        if(out->a->nd==0)return push_scalar_at(L,out->a,NULL);
        if(from_table){lua_getfield(L,3,"out");return 1;}
        lua_pushvalue(L,3);return 1;
    }
    ln_array *r=ln_dot(a->a,b->a,&e);if(!r)return fail(L,&e);
    if(r->nd==0){int ret=push_scalar_at(L,r,NULL);ln_array_free(r);return ret;}
    return push_array(L,r);
}

static int np_linalg_solve(lua_State *L){
    lua_array *a=check_array(L,1),*b=check_array(L,2);ln_error e={{0}};
    ln_array *r=ln_linalg_solve(a->a,b->a,&e);if(!r)return fail(L,&e);
    if(r->nd==0){int ret=push_scalar_at(L,r,NULL);ln_array_free(r);return ret;}
    return push_array(L,r);
}

static int np_linalg_inv(lua_State *L){
    lua_array *a=check_array(L,1);ln_error e={{0}};ln_array*r=ln_linalg_inv(a->a,&e);
    if(!r)return fail(L,&e);
    if(r->nd==0){int ret=push_scalar_at(L,r,NULL);ln_array_free(r);return ret;}
    return push_array(L,r);
}

static int np_linalg_det(lua_State *L){
    lua_array *a=check_array(L,1);ln_error e={{0}};ln_array*r=ln_linalg_det(a->a,&e);
    if(!r)return fail(L,&e);
    if(r->nd==0){int ret=push_scalar_at(L,r,NULL);ln_array_free(r);return ret;}
    return push_array(L,r);
}

static int np_linalg_slogdet(lua_State *L){
    lua_array *a=check_array(L,1);ln_error e={{0}};ln_array*s=NULL,*v=NULL;
    if(ln_linalg_slogdet(a->a,&s,&v,&e)<0)return fail(L,&e);
    if(s->nd==0){push_scalar_at(L,s,NULL);push_scalar_at(L,v,NULL);ln_array_free(s);ln_array_free(v);return 2;}
    push_array(L,s);push_array(L,v);return 2;
}

static int np_linalg_cholesky(lua_State *L){
    lua_array*a=check_array(L,1);int upper=0;
    if(lua_gettop(L)>=2&&lua_type(L,2)!=LUA_TNIL){
        if(lua_type(L,2)==LUA_TTABLE){lua_getfield(L,2,"upper");if(lua_type(L,-1)!=LUA_TNIL)upper=lua_toboolean(L,-1);lua_pop(L,1);}
        else upper=lua_toboolean(L,2);
    }
    ln_error e={{0}};ln_array*r=ln_linalg_cholesky(a->a,upper,&e);if(!r)return fail(L,&e);return push_array(L,r);
}

static int np_linalg_qr(lua_State *L){
    lua_array *a=check_array(L,1);
    const char *mode="reduced";
    if(lua_gettop(L)>=2&&lua_type(L,2)!=LUA_TNIL){mode=lua_tostring(L,2);if(!mode)return luaL_error(L,"mode must be a string");}
    ln_qr_mode qmode;
    if(strcmp(mode,"reduced")==0||strcmp(mode,"full")==0||strcmp(mode,"f")==0)qmode=LN_QR_REDUCED;
    else if(strcmp(mode,"complete")==0)qmode=LN_QR_COMPLETE;
    else if(strcmp(mode,"r")==0)qmode=LN_QR_R;
    else if(strcmp(mode,"raw")==0)qmode=LN_QR_RAW;
    else if(strcmp(mode,"economic")==0||strcmp(mode,"e")==0)qmode=LN_QR_ECONOMIC;
    else return luaL_error(L,"Unrecognized mode '%s'",mode);
    ln_error e={{0}};ln_array *q=NULL,*r=NULL;
    if(ln_linalg_qr(a->a,qmode,&q,&r,&e)<0)return fail(L,&e);
    if(qmode==LN_QR_R||qmode==LN_QR_ECONOMIC)return push_array(L,q);
    push_array(L,q);push_array(L,r);return 2;
}

static int np_linalg_eigvals(lua_State *L){
    lua_array *a=check_array(L,1);ln_error e={{0}};ln_array*w=ln_linalg_eigvals(a->a,&e);if(!w)return fail(L,&e);return push_array(L,w);
}

static int np_linalg_eig(lua_State *L){
    lua_array *a=check_array(L,1);ln_error e={{0}};ln_array *w=NULL,*v=NULL;
    if(ln_linalg_eig(a->a,&w,&v,&e)<0)return fail(L,&e);
    push_array(L,w);
    push_array(L,v);
    return 2;
}

static int parse_uplo(lua_State *L,int arg,int *upper){
    const char *u="L";
    if(lua_gettop(L)>=arg&&lua_type(L,arg)!=LUA_TNIL){
        if(lua_type(L,arg)==LUA_TTABLE){
            lua_getfield(L,arg,"UPLO");
            if(lua_type(L,-1)==LUA_TNIL){lua_pop(L,1);lua_getfield(L,arg,"uplo");}
            if(lua_type(L,-1)!=LUA_TNIL){u=lua_tostring(L,-1);if(!u){lua_pop(L,1);return luaL_error(L,"UPLO must be a string");}}
            lua_pop(L,1);
        }else{u=lua_tostring(L,arg);if(!u)return luaL_error(L,"UPLO must be a string");}
    }
    if((u[0]=='L'||u[0]=='l')&&u[1]=='\0'){*upper=0;return 0;}
    if((u[0]=='U'||u[0]=='u')&&u[1]=='\0'){*upper=1;return 0;}
    return luaL_error(L,"UPLO argument must be 'L' or 'U'");
}

static int np_linalg_eigvalsh(lua_State *L){
    lua_array*a=check_array(L,1);int upper=0;if(parse_uplo(L,2,&upper))return 0;ln_error e={{0}};
    ln_array*w=ln_linalg_eigvalsh(a->a,upper,&e);if(!w)return fail(L,&e);return push_array(L,w);
}

static int np_linalg_eigh(lua_State *L){
    lua_array*a=check_array(L,1);int upper=0;if(parse_uplo(L,2,&upper))return 0;ln_error e={{0}};ln_array*w=NULL,*v=NULL;
    if(ln_linalg_eigh(a->a,upper,&w,&v,&e)<0)return fail(L,&e);
    push_array(L,w);
    push_array(L,v);
    return 2;
}

static int np_linalg_svd(lua_State *L){
    lua_array*a=check_array(L,1);int full=1,compute=1,hermitian=0;
    if(lua_gettop(L)>=2&&lua_type(L,2)!=LUA_TNIL){
        if(lua_type(L,2)==LUA_TTABLE){
            lua_getfield(L,2,"full_matrices");if(lua_type(L,-1)!=LUA_TNIL)full=lua_toboolean(L,-1);lua_pop(L,1);
            lua_getfield(L,2,"compute_uv");if(lua_type(L,-1)!=LUA_TNIL)compute=lua_toboolean(L,-1);lua_pop(L,1);
            lua_getfield(L,2,"hermitian");if(lua_type(L,-1)!=LUA_TNIL)hermitian=lua_toboolean(L,-1);lua_pop(L,1);
        }else{
            full=lua_toboolean(L,2);
            if(lua_gettop(L)>=3&&lua_type(L,3)!=LUA_TNIL)compute=lua_toboolean(L,3);
            if(lua_gettop(L)>=4&&lua_type(L,4)!=LUA_TNIL)hermitian=lua_toboolean(L,4);
        }
    }
    ln_error e={{0}};ln_array *u=NULL,*sv=NULL,*vh=NULL;
    if(ln_linalg_svd(a->a,full,compute,hermitian,&u,&sv,&vh,&e)<0)return fail(L,&e);
    if(!compute)return push_array(L,sv);
    push_array(L,u);push_array(L,sv);push_array(L,vh);return 3;
}

static int np_linalg_svdvals(lua_State *L){
    lua_array*a=check_array(L,1);ln_error e={{0}};ln_array*s=ln_linalg_svdvals(a->a,&e);if(!s)return fail(L,&e);return push_array(L,s);
}

static int np_linalg_lstsq(lua_State *L){
    lua_array*a=check_array(L,1),*b=check_array(L,2);double rcond=0.0;int use_default=1;
    if(lua_gettop(L)>=3&&lua_type(L,3)!=LUA_TNIL){
        if(lua_type(L,3)==LUA_TTABLE){lua_getfield(L,3,"rcond");if(lua_type(L,-1)!=LUA_TNIL){rcond=luaL_checknumber(L,-1);use_default=0;}lua_pop(L,1);}
        else {rcond=luaL_checknumber(L,3);use_default=0;}
    }
    ln_error e={{0}};ln_array*x=NULL,*res=NULL,*sv=NULL;ln_intp rank=0;
    if(ln_linalg_lstsq(a->a,b->a,rcond,use_default,&x,&res,&rank,&sv,&e)<0)return fail(L,&e);
    push_array(L,x);push_array(L,res);lua_pushinteger(L,(lua_Integer)rank);push_array(L,sv);return 4;
}

static int
parse_linalg_tolerance(lua_State *L, int idx, double *scalar,
                       const ln_array **array, const char *name)
{
    lua_array *u = test_array(L, idx);
    if (u) {
        *array = u->a;
        return 0;
    }
    if (lua_type(L, idx) == LUA_TNUMBER) {
        *scalar = luaL_checknumber(L, idx);
        *array = NULL;
        return 0;
    }
    return luaL_error(L, "%s must be a number or ndarray", name);
}

static int np_linalg_pinv(lua_State *L){
    lua_array*a=check_array(L,1);double rcond=1e-15;const ln_array*rcond_array=NULL;int hermitian=0;
    int has_rcond=0,has_rtol=0;
    if(lua_gettop(L)>=2&&lua_type(L,2)!=LUA_TNIL){
        if(lua_type(L,2)==LUA_TTABLE){
            lua_getfield(L,2,"rcond");
            if(lua_type(L,-1)!=LUA_TNIL){has_rcond=1;if(parse_linalg_tolerance(L,-1,&rcond,&rcond_array,"rcond"))return 0;}
            lua_pop(L,1);
            lua_getfield(L,2,"rtol");
            if(lua_type(L,-1)!=LUA_TNIL){has_rtol=1;if(parse_linalg_tolerance(L,-1,&rcond,&rcond_array,"rtol"))return 0;}
            lua_pop(L,1);
            if(has_rcond&&has_rtol)return luaL_error(L,"`rtol` and `rcond` can't be both set.");
            lua_getfield(L,2,"hermitian");if(lua_type(L,-1)!=LUA_TNIL)hermitian=lua_toboolean(L,-1);lua_pop(L,1);
        }else if(parse_linalg_tolerance(L,2,&rcond,&rcond_array,"rcond"))return 0;
    }
    ln_error e={{0}};ln_array*r=ln_linalg_pinv(a->a,rcond,rcond_array,hermitian,&e);if(!r)return fail(L,&e);return push_array(L,r);
}

static int np_linalg_matrix_rank(lua_State *L){
    lua_array*a=check_array(L,1);int hermitian=0,has_tol=0,has_rtol=0;double tol=0,rtol=0;
    const ln_array *tol_array=NULL,*rtol_array=NULL;
    if(lua_gettop(L)>=2&&lua_type(L,2)!=LUA_TNIL){
        if(lua_type(L,2)==LUA_TTABLE){
            lua_getfield(L,2,"tol");if(lua_type(L,-1)!=LUA_TNIL){has_tol=1;if(parse_linalg_tolerance(L,-1,&tol,&tol_array,"tol"))return 0;}lua_pop(L,1);
            lua_getfield(L,2,"rtol");if(lua_type(L,-1)!=LUA_TNIL){has_rtol=1;if(parse_linalg_tolerance(L,-1,&rtol,&rtol_array,"rtol"))return 0;}lua_pop(L,1);
            if(has_tol&&has_rtol)return luaL_error(L,"`tol` and `rtol` can't be both set.");
            lua_getfield(L,2,"hermitian");if(lua_type(L,-1)!=LUA_TNIL)hermitian=lua_toboolean(L,-1);lua_pop(L,1);
        }else {has_tol=1;if(parse_linalg_tolerance(L,2,&tol,&tol_array,"tol"))return 0;}
    }
    if(lua_gettop(L)>=3&&lua_type(L,3)!=LUA_TNIL)hermitian=lua_toboolean(L,3);
    ln_error e={{0}};ln_array*r=NULL;ln_intp sr=0;int scalar=0;
    if(ln_linalg_matrix_rank(a->a,hermitian,has_tol,tol,tol_array,has_rtol,rtol,rtol_array,&r,&sr,&scalar,&e)<0)return fail(L,&e);
    if(scalar){lua_pushinteger(L,(lua_Integer)sr);return 1;}
    if(r->nd==0){int ret=push_scalar_at(L,r,NULL);ln_array_free(r);return ret;}
    return push_array(L,r);
}

static int parse_norm_ord(lua_State *L,int idx,ln_norm_kind *kind,double *ord){
    if(lua_type(L,idx)==LUA_TNIL||lua_type(L,idx)==LUA_TNONE){*kind=LN_NORM_DEFAULT;*ord=2.0;return 0;}
    if(lua_type(L,idx)==LUA_TSTRING){const char*s=lua_tostring(L,idx);if(strcmp(s,"fro")==0||strcmp(s,"f")==0){*kind=LN_NORM_FRO;*ord=0;return 0;}if(strcmp(s,"nuc")==0){*kind=LN_NORM_NUC;*ord=0;return 0;}return luaL_error(L,"invalid norm order");}
    if(lua_type(L,idx)==LUA_TNUMBER){double v=luaL_checknumber(L,idx);if(isinf(v)){*kind=v>0?LN_NORM_POSINF:LN_NORM_NEGINF;*ord=v;}else{*kind=LN_NORM_NUMBER;*ord=v;}return 0;}
    return luaL_error(L,"ord must be nil, a number, 'fro', 'f', or 'nuc'");
}

static int np_linalg_norm(lua_State *L){
    lua_array*a=check_array(L,1);ln_norm_kind kind=LN_NORM_DEFAULT;double ord=2.0;int axis_none=1,axes[2]={0,0},naxes=0,keepdims=0;
    if(lua_gettop(L)>=2&&lua_type(L,2)!=LUA_TNIL){
        if(lua_type(L,2)==LUA_TTABLE){
            lua_getfield(L,2,"ord");if(parse_norm_ord(L,lua_gettop(L),&kind,&ord))return 0;lua_pop(L,1);
            lua_getfield(L,2,"keepdims");if(lua_type(L,-1)!=LUA_TNIL)keepdims=lua_toboolean(L,-1);lua_pop(L,1);
            lua_getfield(L,2,"axis");
            if(lua_type(L,-1)!=LUA_TNIL){
                axis_none=0;
                if(lua_type(L,-1)==LUA_TNUMBER){
                    lua_Integer v=luaL_checkinteger(L,-1);naxes=1;
                    if(normalize_lua_axis(L,v,a->a->nd,&axes[0])){lua_pop(L,1);return 0;}
                } else if(lua_type(L,-1)==LUA_TTABLE){
                    size_t n=lua_rawlen(L,-1);if(n<1||n>2){lua_pop(L,1);return luaL_error(L,"axis must be an integer or a 1/2-element table");}naxes=(int)n;
                    for(size_t i=0;i<n;i++){lua_geti(L,-1,(lua_Integer)i+1);lua_Integer v=luaL_checkinteger(L,-1);if(normalize_lua_axis(L,v,a->a->nd,&axes[i])){lua_pop(L,2);return 0;}lua_pop(L,1);}
                } else {lua_pop(L,1);return luaL_error(L,"axis must be an integer or table");}
            }
            lua_pop(L,1);
        }else{
            if(parse_norm_ord(L,2,&kind,&ord))return 0;
            if(lua_gettop(L)>=3&&lua_type(L,3)!=LUA_TNIL){
                axis_none=0;
                if(lua_type(L,3)==LUA_TNUMBER){lua_Integer v=luaL_checkinteger(L,3);naxes=1;if(normalize_lua_axis(L,v,a->a->nd,&axes[0]))return 0;}
                else if(lua_type(L,3)==LUA_TTABLE){size_t n=lua_rawlen(L,3);if(n<1||n>2)return luaL_error(L,"axis must have one or two entries");naxes=(int)n;for(size_t i=0;i<n;i++){lua_geti(L,3,(lua_Integer)i+1);lua_Integer v=luaL_checkinteger(L,-1);if(normalize_lua_axis(L,v,a->a->nd,&axes[i])){lua_pop(L,1);return 0;}lua_pop(L,1);}}
                else return luaL_error(L,"axis must be an integer or table");
            }
            if(lua_gettop(L)>=4&&lua_type(L,4)!=LUA_TNIL)keepdims=lua_toboolean(L,4);
        }
    }
    ln_error e={{0}};ln_array*r=ln_linalg_norm(a->a,kind,ord,axes,naxes,axis_none,keepdims,&e);if(!r)return fail(L,&e);
    if(r->nd==0){int ret=push_scalar_at(L,r,NULL);ln_array_free(r);return ret;}return push_array(L,r);
}

static int np_linalg_cond(lua_State *L){
    lua_array*a=check_array(L,1);ln_norm_kind kind=LN_NORM_DEFAULT;double ord=2.0;
    if(lua_gettop(L)>=2&&lua_type(L,2)!=LUA_TNIL){
        if(lua_type(L,2)==LUA_TTABLE){lua_getfield(L,2,"p");if(parse_norm_ord(L,lua_gettop(L),&kind,&ord))return 0;lua_pop(L,1);}
        else if(parse_norm_ord(L,2,&kind,&ord))return 0;
    }
    ln_error e={{0}};ln_array*r=ln_linalg_cond(a->a,kind,ord,&e);if(!r)return fail(L,&e);
    if(r->nd==0){int ret=push_scalar_at(L,r,NULL);ln_array_free(r);return ret;}return push_array(L,r);
}

static int push_linalg_array_or_scalar(lua_State *L,ln_array *r){
    if(!r)return 0;
    if(r->nd==0){int ret=push_scalar_at(L,r,NULL);ln_array_free(r);return ret;}
    return push_array(L,r);
}

static int np_linalg_matrix_power(lua_State *L){
    lua_array*a=check_array(L,1);
    if(!lua_isinteger(L,2))return luaL_error(L,"exponent must be an integer");
    lua_Integer n=lua_tointegerx(L,2,NULL);
    if(n==1){lua_pushvalue(L,1);return 1;}
    ln_error e={{0}};ln_array*r=ln_linalg_matrix_power(a->a,(int64_t)n,&e);if(!r)return fail(L,&e);
    return push_linalg_array_or_scalar(L,r);
}

static int np_linalg_tensorinv(lua_State *L){
    lua_array*a=check_array(L,1);int ind=2;
    if(lua_gettop(L)>=2&&lua_type(L,2)!=LUA_TNIL){
        if(lua_type(L,2)==LUA_TTABLE){lua_getfield(L,2,"ind");if(lua_type(L,-1)!=LUA_TNIL)ind=(int)luaL_checkinteger(L,-1);lua_pop(L,1);}
        else ind=(int)luaL_checkinteger(L,2);
    }
    ln_error e={{0}};ln_array*r=ln_linalg_tensorinv(a->a,ind,&e);if(!r)return fail(L,&e);return push_array(L,r);
}

static int parse_axis_list(lua_State *L,int idx,int nd,int *axes,int *naxes,const char *name){
    idx=lua_absindex(L,idx);
    if(lua_type(L,idx)!=LUA_TTABLE)return luaL_error(L,"%s must be a table of axes",name);
    size_t n=lua_rawlen(L,idx);if(n>LN_MAXDIMS)return luaL_error(L,"too many axes");
    *naxes=(int)n;
    for(size_t i=0;i<n;i++){
        lua_geti(L,idx,(lua_Integer)i+1);lua_Integer raw=luaL_checkinteger(L,-1);
        if(normalize_lua_axis(L,raw,nd,&axes[i])){lua_pop(L,1);return 1;}
        lua_pop(L,1);
    }
    return 0;
}

static int np_linalg_tensorsolve(lua_State *L){
    lua_array*a=check_array(L,1),*b=check_array(L,2);int axes[LN_MAXDIMS],naxes=0;
    if(lua_gettop(L)>=3&&lua_type(L,3)!=LUA_TNIL){
        int idx=3;
        if(lua_type(L,3)!=LUA_TTABLE)return luaL_error(L,"axes must be a table or nil");
        lua_getfield(L,3,"axes");
        if(lua_type(L,-1)!=LUA_TNIL)idx=lua_gettop(L);else lua_pop(L,1);
        if(parse_axis_list(L,idx,a->a->nd,axes,&naxes,"axes")){if(idx!=3)lua_pop(L,1);return 0;}
        if(idx!=3)lua_pop(L,1);
    }
    ln_error e={{0}};ln_array*r=ln_linalg_tensorsolve(a->a,b->a,axes,naxes,&e);if(!r)return fail(L,&e);
    return push_linalg_array_or_scalar(L,r);
}

static int parse_tensordot_axes(lua_State *L,int idx,const ln_array*a,const ln_array*b,
                                int *aa,int *bb,int *naxes){
    idx=lua_absindex(L,idx);
    if(lua_type(L,idx)==LUA_TNUMBER){
        lua_Integer n=luaL_checkinteger(L,idx);if(n<0||n>a->nd||n>b->nd)return luaL_error(L,"axes exceeds input dimensions");
        *naxes=(int)n;for(int i=0;i<*naxes;i++){aa[i]=a->nd-*naxes+i;bb[i]=i;}return 0;
    }
    if(lua_type(L,idx)!=LUA_TTABLE)return luaL_error(L,"axes must be an integer or pair of axis tables");
    if(lua_rawlen(L,idx)!=2)return luaL_error(L,"axes table must contain two axis lists");
    lua_geti(L,idx,1);int na=0;if(parse_axis_list(L,-1,a->nd,aa,&na,"axes[1]")){lua_pop(L,1);return 1;}lua_pop(L,1);
    lua_geti(L,idx,2);int nb=0;if(parse_axis_list(L,-1,b->nd,bb,&nb,"axes[2]")){lua_pop(L,1);return 1;}lua_pop(L,1);
    if(na!=nb)return luaL_error(L,"shape-mismatch for sum");
    *naxes=na;return 0;
}

static int np_linalg_tensordot(lua_State *L){
    lua_array*a=check_array(L,1),*b=check_array(L,2);int aa[LN_MAXDIMS],bb[LN_MAXDIMS],naxes=0;
    if(lua_gettop(L)<3||lua_type(L,3)==LUA_TNIL){
        naxes=2;
        if(a->a->nd<naxes||b->a->nd<naxes)return luaL_error(L,"axes exceeds input dimensions");
        for(int i=0;i<naxes;i++){aa[i]=a->a->nd-naxes+i;bb[i]=i;}
    }else{
        int idx=3;
        if(lua_type(L,3)==LUA_TTABLE){lua_getfield(L,3,"axes");if(lua_type(L,-1)!=LUA_TNIL)idx=lua_gettop(L);else lua_pop(L,1);}
        if(idx==0){/* unreachable */}
        if(parse_tensordot_axes(L,idx,a->a,b->a,aa,bb,&naxes)){if(idx!=3)lua_pop(L,1);return 0;}
        if(idx!=3)lua_pop(L,1);
    }
    ln_error e={{0}};ln_array*r=ln_linalg_tensordot(a->a,b->a,aa,bb,naxes,&e);if(!r)return fail(L,&e);
    return push_linalg_array_or_scalar(L,r);
}

static int np_linalg_multi_dot(lua_State *L){
    if(lua_type(L,1)!=LUA_TTABLE)return luaL_error(L,"arrays must be a table");
    size_t n=lua_rawlen(L,1);if(n>(size_t)INT_MAX)return luaL_error(L,"too many arrays");
    const ln_array **arr=(const ln_array**)calloc(n?n:1,sizeof(*arr));if(!arr)return luaL_error(L,"out of memory");
    for(size_t i=0;i<n;i++){lua_geti(L,1,(lua_Integer)i+1);lua_array*u=test_array(L,-1);if(!u){free(arr);return luaL_error(L,"multi_dot entries must be ndarrays");}arr[i]=u->a;lua_pop(L,1);}
    lua_array*out=NULL;int from_table=0;if(parse_linalg_out(L,2,&out,&from_table)){free(arr);return 0;}
    ln_error e={{0}};ln_array*r=ln_linalg_multi_dot(arr,(int)n,&e);free(arr);if(!r)return fail(L,&e);
    if(out){
        if(out->a->descr!=r->descr||out->a->nd!=r->nd){ln_array_free(r);return luaL_error(L,"output array has wrong dtype or dimensionality");}
        for(int d=0;d<r->nd;d++)if(out->a->dimensions[d]!=r->dimensions[d]){ln_array_free(r);return luaL_error(L,"output array has wrong shape");}
        if(!(out->a->flags&LN_ARRAY_C_CONTIGUOUS)||!(out->a->flags&LN_ARRAY_ALIGNED)||!(out->a->flags&LN_ARRAY_WRITEABLE)){ln_array_free(r);return luaL_error(L,"output array must be writable, aligned, and C-contiguous");}
        if(ln_array_assign_array(out->a,r,&e)<0){ln_array_free(r);return fail(L,&e);}ln_array_free(r);
        if(from_table){lua_getfield(L,2,"out");return 1;}lua_pushvalue(L,2);return 1;
    }
    return push_linalg_array_or_scalar(L,r);
}

static int np_linalg_outer(lua_State *L){
    lua_array*a=check_array(L,1),*b=check_array(L,2);if(lua_gettop(L)>2)return luaL_error(L,"linalg.outer accepts exactly two arguments");
    ln_error e={{0}};ln_array*r=ln_linalg_outer(a->a,b->a,&e);if(!r)return fail(L,&e);return push_array(L,r);
}

static int np_linalg_diagonal(lua_State *L){
    lua_array*a=check_array(L,1);ln_intp offset=0;
    if(lua_gettop(L)>=2&&lua_type(L,2)!=LUA_TNIL){
        if(lua_type(L,2)==LUA_TTABLE){lua_getfield(L,2,"offset");if(lua_type(L,-1)!=LUA_TNIL)offset=(ln_intp)luaL_checkinteger(L,-1);lua_pop(L,1);}
        else offset=(ln_intp)luaL_checkinteger(L,2);
    }
    ln_error e={{0}};ln_array*r=ln_linalg_diagonal(a->a,offset,&e);if(!r)return fail(L,&e);return push_array(L,r);
}

static int np_linalg_trace(lua_State *L){
    lua_array*a=check_array(L,1);ln_intp offset=0;const ln_dtype*dt=NULL;
    if(lua_gettop(L)>=2&&lua_type(L,2)!=LUA_TNIL){
        if(lua_type(L,2)==LUA_TTABLE){
            lua_getfield(L,2,"offset");if(lua_type(L,-1)!=LUA_TNIL)offset=(ln_intp)luaL_checkinteger(L,-1);lua_pop(L,1);
            lua_getfield(L,2,"dtype");if(lua_type(L,-1)!=LUA_TNIL){const char*s=lua_tostring(L,-1);dt=s?ln_dtype_by_name(s):NULL;if(!dt){lua_pop(L,1);return luaL_error(L,"unsupported dtype");}}lua_pop(L,1);
        }else offset=(ln_intp)luaL_checkinteger(L,2);
    }
    if(lua_gettop(L)>=3&&lua_type(L,3)!=LUA_TNIL){const char*s=lua_tostring(L,3);dt=s?ln_dtype_by_name(s):NULL;if(!dt)return luaL_error(L,"unsupported dtype");}
    ln_error e={{0}};ln_array*r=ln_linalg_trace(a->a,offset,dt,&e);if(!r)return fail(L,&e);return push_linalg_array_or_scalar(L,r);
}

static int np_linalg_matrix_transpose(lua_State *L){
    lua_array*a=check_array(L,1);if(lua_gettop(L)>1)return luaL_error(L,"matrix_transpose accepts exactly one argument");
    ln_error e={{0}};ln_array*r=ln_linalg_matrix_transpose(a->a,&e);if(!r)return fail(L,&e);return push_array(L,r);
}

static int np_linalg_cross(lua_State *L){
    lua_array*a=check_array(L,1),*b=check_array(L,2);lua_Integer raw=-1;
    if(lua_gettop(L)>=3&&lua_type(L,3)!=LUA_TNIL){
        if(lua_type(L,3)==LUA_TTABLE){lua_getfield(L,3,"axis");if(lua_type(L,-1)!=LUA_TNIL)raw=luaL_checkinteger(L,-1);lua_pop(L,1);}
        else raw=luaL_checkinteger(L,3);
    }
    int aa,bb,ao;if(normalize_lua_axis(L,raw,a->a->nd,&aa)||normalize_lua_axis(L,raw,b->a->nd,&bb))return 0;
    int ond=((a->a->nd-1)>(b->a->nd-1)?(a->a->nd-1):(b->a->nd-1))+1;if(normalize_lua_axis(L,raw,ond,&ao))return 0;
    ln_error e={{0}};ln_array*r=ln_linalg_cross(a->a,aa,b->a,bb,ao,&e);if(!r)return fail(L,&e);return push_array(L,r);
}

static int np_linalg_matmul(lua_State *L){
    lua_array*a=check_array(L,1),*b=check_array(L,2);if(lua_gettop(L)>2)return luaL_error(L,"linalg.matmul accepts exactly two arguments");
    ln_error e={{0}};ln_array*r=ln_matmul(a->a,b->a,&e);if(!r)return fail(L,&e);return push_linalg_array_or_scalar(L,r);
}

static int np_linalg_matrix_norm(lua_State *L){
    lua_array*a=check_array(L,1);if(a->a->nd<2)return luaL_error(L,"matrix_norm requires an array of at least two dimensions");
    ln_norm_kind kind=LN_NORM_FRO;double ord=0.0;int keepdims=0;
    if(lua_gettop(L)>=2&&lua_type(L,2)!=LUA_TNIL){
        if(lua_type(L,2)==LUA_TTABLE){lua_getfield(L,2,"ord");if(lua_type(L,-1)!=LUA_TNIL&&parse_norm_ord(L,lua_gettop(L),&kind,&ord)){lua_pop(L,1);return 0;}lua_pop(L,1);lua_getfield(L,2,"keepdims");if(lua_type(L,-1)!=LUA_TNIL)keepdims=lua_toboolean(L,-1);lua_pop(L,1);}
        else if(parse_norm_ord(L,2,&kind,&ord))return 0;
    }
    int axes[2]={a->a->nd-2,a->a->nd-1};ln_error e={{0}};ln_array*r=ln_linalg_norm(a->a,kind,ord,axes,2,0,keepdims,&e);if(!r)return fail(L,&e);return push_linalg_array_or_scalar(L,r);
}

static int np_linalg_vector_norm(lua_State *L){
    lua_array*a=check_array(L,1);ln_norm_kind kind=LN_NORM_NUMBER;double ord=2.0;int keepdims=0,axis_none=1,axes[LN_MAXDIMS],naxes=0;
    if(lua_gettop(L)>=2&&lua_type(L,2)!=LUA_TNIL){
        if(lua_type(L,2)==LUA_TTABLE){
            lua_getfield(L,2,"ord");if(lua_type(L,-1)!=LUA_TNIL&&parse_norm_ord(L,lua_gettop(L),&kind,&ord)){lua_pop(L,1);return 0;}lua_pop(L,1);
            lua_getfield(L,2,"keepdims");if(lua_type(L,-1)!=LUA_TNIL)keepdims=lua_toboolean(L,-1);lua_pop(L,1);
            lua_getfield(L,2,"axis");if(lua_type(L,-1)!=LUA_TNIL){axis_none=0;if(a->a->nd==0){lua_pop(L,1);return luaL_error(L,"axis is out of bounds for array of dimension 0");}if(lua_type(L,-1)==LUA_TNUMBER){naxes=1;if(normalize_lua_axis(L,luaL_checkinteger(L,-1),a->a->nd,&axes[0])){lua_pop(L,1);return 0;}}else if(lua_type(L,-1)==LUA_TTABLE){if(parse_axis_list(L,-1,a->a->nd,axes,&naxes,"axis")){lua_pop(L,1);return 0;}}else{lua_pop(L,1);return luaL_error(L,"axis must be an integer or table");}}lua_pop(L,1);
        }else if(parse_norm_ord(L,2,&kind,&ord))return 0;
    }
    if(kind==LN_NORM_DEFAULT){kind=LN_NORM_NUMBER;ord=2.0;}
    ln_error e={{0}};ln_array*r=ln_linalg_vector_norm(a->a,kind,ord,axes,naxes,axis_none,keepdims,&e);if(!r)return fail(L,&e);return push_linalg_array_or_scalar(L,r);
}

static int np_linalg_vecdot(lua_State *L){
    lua_array*a=check_array(L,1),*b=check_array(L,2);lua_Integer raw=-1;
    if(lua_gettop(L)>=3&&lua_type(L,3)!=LUA_TNIL){if(lua_type(L,3)==LUA_TTABLE){lua_getfield(L,3,"axis");if(lua_type(L,-1)!=LUA_TNIL)raw=luaL_checkinteger(L,-1);lua_pop(L,1);}else raw=luaL_checkinteger(L,3);}
    int aa,bb;if(normalize_lua_axis(L,raw,a->a->nd,&aa)||normalize_lua_axis(L,raw,b->a->nd,&bb))return 0;
    ln_error e={{0}};ln_array*r=ln_linalg_vecdot(a->a,aa,b->a,bb,&e);if(!r)return fail(L,&e);return push_linalg_array_or_scalar(L,r);
}

static const luaL_Reg linalg_funcs[]={
    {"solve",np_linalg_solve},{"inv",np_linalg_inv},{"det",np_linalg_det},
    {"slogdet",np_linalg_slogdet},{"cholesky",np_linalg_cholesky},{"qr",np_linalg_qr},
    {"eig",np_linalg_eig},{"eigvals",np_linalg_eigvals},{"eigh",np_linalg_eigh},
    {"eigvalsh",np_linalg_eigvalsh},{"svd",np_linalg_svd},{"svdvals",np_linalg_svdvals},{"lstsq",np_linalg_lstsq},{"pinv",np_linalg_pinv},{"matrix_rank",np_linalg_matrix_rank},{"norm",np_linalg_norm},{"cond",np_linalg_cond},
    {"matrix_power",np_linalg_matrix_power},{"tensorinv",np_linalg_tensorinv},{"tensorsolve",np_linalg_tensorsolve},{"multi_dot",np_linalg_multi_dot},
    {"outer",np_linalg_outer},{"diagonal",np_linalg_diagonal},{"trace",np_linalg_trace},{"cross",np_linalg_cross},{"tensordot",np_linalg_tensordot},{"matmul",np_linalg_matmul},
    {"matrix_transpose",np_linalg_matrix_transpose},{"matrix_norm",np_linalg_matrix_norm},{"vector_norm",np_linalg_vector_norm},{"vecdot",np_linalg_vecdot},{NULL,NULL}
};

static int np_inner(lua_State *L){
    lua_array *a=check_array(L,1),*b=check_array(L,2);ln_error e={{0}};
    ln_array *r=ln_inner(a->a,b->a,&e);if(!r)return fail(L,&e);
    if(r->nd==0){int ret=push_scalar_at(L,r,NULL);ln_array_free(r);return ret;}
    return push_array(L,r);
}

static int np_outer(lua_State *L){
    lua_array *a=check_array(L,1),*b=check_array(L,2),*out=NULL;
    int from_table=0;if(parse_linalg_out(L,3,&out,&from_table))return 0;
    ln_error e={{0}};
    if(out){
        if(ln_outer_into(a->a,b->a,out->a,&e)<0)return fail(L,&e);
        if(from_table){lua_getfield(L,3,"out");return 1;}
        lua_pushvalue(L,3);return 1;
    }
    ln_array *r=ln_outer(a->a,b->a,&e);if(!r)return fail(L,&e);
    return push_array(L,r);
}


typedef struct sort_call_options {
    int axis;
    int descending;
} sort_call_options;

static int
parse_sort_options(lua_State *L, int idx, int nd, int partition_mode,
                   sort_call_options *opts)
{
    opts->axis = nd == 0 ? -1 : nd - 1;
    opts->descending = 0;
    if (lua_gettop(L) < idx || lua_type(L,idx) == LUA_TNIL) return 0;

    if (lua_type(L,idx) == LUA_TNUMBER) {
        int ok=0; lua_Integer raw=lua_tointegerx(L,idx,&ok);
        if (!ok) return luaL_error(L,"axis must be an integer or options table");
        return normalize_lua_axis(L,raw,nd,&opts->axis);
    }
    if (lua_type(L,idx) != LUA_TTABLE)
        return luaL_error(L,"sort options must be an axis integer or table");

    idx=lua_absindex(L,idx);
    lua_getfield(L,idx,"axis");
    if (lua_type(L,-1) != LUA_TNIL) {
        int ok=0; lua_Integer raw=lua_tointegerx(L,-1,&ok);
        if (!ok) { lua_pop(L,1); return luaL_error(L,"axis must be an integer"); }
        if (normalize_lua_axis(L,raw,nd,&opts->axis)) { lua_pop(L,1); return 1; }
    }
    lua_pop(L,1);

    lua_getfield(L,idx,"descending");
    if (lua_type(L,-1) != LUA_TNIL) {
        if (lua_type(L,-1) != LUA_TBOOLEAN) { lua_pop(L,1); return luaL_error(L,"descending must be boolean"); }
        opts->descending=lua_toboolean(L,-1);
    }
    lua_pop(L,1);

    lua_getfield(L,idx,"stable");
    if (lua_type(L,-1) != LUA_TNIL && lua_toboolean(L,-1)) {
        lua_pop(L,1);
        return luaL_error(L,"stable sorting is not ported yet; current LuaRay sort implements NumPy's introsort path");
    }
    lua_pop(L,1);

    lua_getfield(L,idx,"kind");
    if (lua_type(L,-1) != LUA_TNIL) {
        const char *kind=lua_tostring(L,-1);
        if (!kind) { lua_pop(L,1); return luaL_error(L,"kind must be a string"); }
        if (partition_mode) {
            if (strcmp(kind,"introselect") != 0) { lua_pop(L,1); return luaL_error(L,"only kind='introselect' is supported for partition"); }
        }
        else {
            if (strcmp(kind,"quicksort") != 0 && strcmp(kind,"heapsort") != 0) {
                if (strcmp(kind,"stable")==0 || strcmp(kind,"mergesort")==0) {
                    lua_pop(L,1);
                    return luaL_error(L,"stable sorting is not ported yet");
                }
                lua_pop(L,1);
                return luaL_error(L,"unsupported sort kind");
            }
        }
    }
    lua_pop(L,1);
    return 0;
}

static int
intp_cmp_qsort(const void *aa,const void *bb)
{
    ln_intp a=*(const ln_intp*)aa,b=*(const ln_intp*)bb;
    return a<b?-1:(a>b?1:0);
}

static int
parse_partition_kth(lua_State *L, int arg, ln_intp axis_len, int axis,
                    ln_intp **out, ln_intp *nout)
{
    *out=NULL; *nout=0;
    if (lua_type(L,arg)==LUA_TNUMBER) {
        int ok=0; lua_Integer raw=lua_tointegerx(L,arg,&ok);
        if (!ok) return luaL_error(L,"kth must be an integer, table, or 1-D integer ndarray");
        ln_intp q;
        if (normalize_lua_index_value(L,raw,axis_len,axis,&q)) return 1;
        ln_intp *v=(ln_intp*)malloc(sizeof(*v));
        if (!v) return luaL_error(L,"out of memory parsing kth");
        v[0]=q; *out=v; *nout=1; return 0;
    }
    if (parse_reduceat_indices(L,arg,axis_len,axis,out,nout)) return 1;
    if (*nout>1) qsort(*out,(size_t)*nout,sizeof(**out),intp_cmp_qsort);
    return 0;
}

static int
np_sort(lua_State *L)
{
    lua_array *u=check_array(L,1); sort_call_options o;
    if (parse_sort_options(L,2,u->a->nd,0,&o)) return 0;
    ln_error e={{0}}; ln_array *r=ln_sort_copy(u->a,o.axis,o.descending,&e);
    if (!r) return fail(L,&e);
    return push_array(L,r);
}

static int
array_sort_inplace(lua_State *L)
{
    lua_array *u=check_array(L,1); sort_call_options o;
    if (parse_sort_options(L,2,u->a->nd,0,&o)) return 0;
    ln_error e={{0}}; if (ln_sort_inplace(u->a,o.axis,o.descending,&e)<0) return fail(L,&e);
    return 0; /* ndarray.sort is in-place and returns None upstream. */
}

static int
np_argsort(lua_State *L)
{
    lua_array *u=check_array(L,1); sort_call_options o;
    if (parse_sort_options(L,2,u->a->nd,0,&o)) return 0;
    ln_error e={{0}}; ln_array *r=ln_argsort(u->a,o.axis,o.descending,&e);
    if (!r) return fail(L,&e);
    return push_array(L,r);
}

static int
partition_common(lua_State *L, int argpartition, int inplace)
{
    lua_array *u=check_array(L,1);
    if (u->a->nd==0 && !argpartition) return luaL_error(L,"axis -1 is out of bounds for array of dimension 0");
    sort_call_options o;
    if (parse_sort_options(L,3,u->a->nd,1,&o)) return 0;
    if (u->a->nd==0) {
        /* argsort-like PyArray_CheckAxis promotes 0-D to a one-element axis. */
        ln_error e={{0}}; ln_intp dummy=0;
        ln_array *r=ln_argpartition(u->a,&dummy,1,o.axis,o.descending,&e);
        if (!r) return fail(L,&e);
    return push_array(L,r);
    }
    ln_intp *kth=NULL,nkth=0;
    if (parse_partition_kth(L,2,u->a->dimensions[o.axis],o.axis,&kth,&nkth)) return 0;
    ln_error e={{0}};
    if (inplace) {
        int rc=ln_partition_inplace(u->a,kth,nkth,o.axis,o.descending,&e); free(kth);
        if (rc<0) return fail(L,&e);
        return 0;
    }
    ln_array *r=argpartition?ln_argpartition(u->a,kth,nkth,o.axis,o.descending,&e)
                            :ln_partition_copy(u->a,kth,nkth,o.axis,o.descending,&e);
    free(kth);
    if (!r) return fail(L,&e);
    return push_array(L,r);
}

static int np_partition(lua_State *L){return partition_common(L,0,0);}
static int np_argpartition(lua_State *L){return partition_common(L,1,0);}
static int array_partition_inplace(lua_State *L){return partition_common(L,0,1);}



/* Axis coordinates are 1-based at the Lua boundary; they are 0-based inside
 * ln_axis.c.  Explicit sequences do NOT use NumPy's 0-D scalar-axis escape. */
static int axis_strict(lua_State *L, lua_Integer raw, int nd) {
    if(raw==0)return luaL_error(L,"axis 0 is invalid in LuaRay");
    if(nd<=0 || raw>(lua_Integer)nd || raw<-(lua_Integer)nd)
        return luaL_error(L,"axis %lld is out of bounds for array of dimension %d",(long long)raw,nd);
    return raw>0?(int)raw-1:nd+(int)raw;
}
static int axis_list(lua_State *L, int idx, int nd, int *out, int *count) {
    int type=lua_type(L,idx);
    if(type==LUA_TNUMBER) {
        if(!lua_isinteger(L,idx))return luaL_error(L,"axis must be an integer");
        out[0]=axis_strict(L,lua_tointegerx(L,idx,NULL),nd);
        *count=1;return 0;
    }
    if(type!=LUA_TTABLE)return luaL_error(L,"axes must be an integer or a sequence of integers");
    size_t n=lua_rawlen(L,idx);
    if(n>LN_MAXDIMS)return luaL_error(L,"too many axes");
    for(size_t i=0;i<n;i++){
        lua_geti(L,idx,(lua_Integer)i+1);
        if(!lua_isinteger(L,-1))return luaL_error(L,"axis entries must be integers");
        out[i]=axis_strict(L,lua_tointegerx(L,-1,NULL),nd);
        lua_pop(L,1);
    }
    *count=(int)n;
    return 0;
}
static int unique_axes(lua_State *L, const int *a, int n) {
    unsigned char seen[LN_MAXDIMS]={0};
    for(int i=0;i<n;i++) {
        if(seen[a[i]])return luaL_error(L,"repeated axis in axis argument");
        seen[a[i]]=1;
    }
    return 0;
}
static int np_transpose(lua_State *L) {
    lua_array *u=check_array(L,1);
    int order[LN_MAXDIMS], n=u->a->nd;
    if(lua_type(L,2)==LUA_TNONE||lua_type(L,2)==LUA_TNIL)
        for(int i=0;i<n;i++)order[i]=n-1-i;
    else {
        int count=0;
        axis_list(L,2,n,order,&count);
        if(count!=n)return luaL_error(L,"axes don't match array");
        unique_axes(L,order,count);
    }
    ln_error e={{0}};
    ln_array *v=ln_axis_permute(u->a,order,&e);
    if(!v)return fail(L,&e);
    return push_array(L,v);
}
static int np_swapaxes(lua_State *L) {
    lua_array *u=check_array(L,1);
    if(!lua_isinteger(L,2)||!lua_isinteger(L,3))return luaL_error(L,"swapaxes requires two integer axes");
    int a=axis_strict(L,lua_tointegerx(L,2,NULL),u->a->nd);
    int b=axis_strict(L,lua_tointegerx(L,3,NULL),u->a->nd);
    int order[LN_MAXDIMS];for(int i=0;i<u->a->nd;i++)order[i]=i;
    order[a]=b;order[b]=a;
    ln_error e={{0}};ln_array *v=ln_axis_permute(u->a,order,&e);
    if(!v)return fail(L,&e);
    return push_array(L,v);
}
static int np_moveaxis(lua_State *L) {
    lua_array *u=check_array(L,1);
    int n=u->a->nd, source[LN_MAXDIMS], dest[LN_MAXDIMS],ns=0,nd=0;
    axis_list(L,2,n,source,&ns);axis_list(L,3,n,dest,&nd);
    if(ns!=nd)return luaL_error(L,"source and destination must have the same number of elements");
    unique_axes(L,source,ns);unique_axes(L,dest,nd);
    unsigned char moved[LN_MAXDIMS]={0};
    for(int i=0;i<ns;i++)moved[source[i]]=1;
    int order[LN_MAXDIMS],pos=0;
    for(int i=0;i<n;i++)if(!moved[i])order[pos++]=i;
    /* NumPy: insert each moved axis in increasing destination order. */
    for(int position=0;position<n;position++)
        for(int i=0;i<nd;i++)if(dest[i]==position){
            for(int j=pos;j>position;j--)order[j]=order[j-1];
            order[position]=source[i];pos++;
        }
    ln_error e={{0}};ln_array *v=ln_axis_permute(u->a,order,&e);
    if(!v)return fail(L,&e);
    return push_array(L,v);
}
static int np_expand_dims(lua_State *L) {
    lua_array *u=check_array(L,1);
    int count=1;
    if(lua_type(L,2)==LUA_TTABLE){
        size_t n=lua_rawlen(L,2);
        if(n>LN_MAXDIMS)return luaL_error(L,"too many axes");
        count=(int)n;
    } else if(!lua_isinteger(L,2))return luaL_error(L,"axis must be an integer or a tuple of integers");
    if(count>LN_MAXDIMS-u->a->nd)return luaL_error(L,"maximum supported rank is 64");
    int ax[LN_MAXDIMS],na=0;axis_list(L,2,u->a->nd+count,ax,&na);
    unique_axes(L,ax,na);
    unsigned char positions[LN_MAXDIMS]={0};
    for(int i=0;i<na;i++)positions[ax[i]]=1;
    ln_error e={{0}};ln_array *v=ln_axis_expand(u->a,positions,u->a->nd+count,&e);
    if(!v)return fail(L,&e);
    return push_array(L,v);
}
static int np_squeeze(lua_State *L) {
    lua_array *u=check_array(L,1);
    int n=u->a->nd,axes[LN_MAXDIMS],count=0;
    unsigned char selected[LN_MAXDIMS]={0};
    if(lua_type(L,2)==LUA_TNONE||lua_type(L,2)==LUA_TNIL){
        for(int i=0;i<n;i++)selected[i]=(u->a->dimensions[i]==1);
    } else if(n==0 && lua_isinteger(L,2)){
        lua_Integer raw=lua_tointegerx(L,2,NULL);
        if(raw!=1&&raw!=-1)return luaL_error(L,"axis out of bounds for zero-dimensional array");
        /* NumPy scalar-axis special case. */
    } else {
        axis_list(L,2,n,axes,&count);unique_axes(L,axes,count);
        for(int i=0;i<count;i++)selected[axes[i]]=1;
    }
    ln_error e={{0}};ln_array *v=ln_axis_squeeze(u->a,selected,&e);
    if(!v)return fail(L,&e);
    return push_array(L,v);
}
static int np_flip(lua_State *L) {
    lua_array *u=check_array(L,1);
    unsigned char selected[LN_MAXDIMS]={0};
    if(lua_type(L,2)==LUA_TNONE||lua_type(L,2)==LUA_TNIL)
        for(int i=0;i<u->a->nd;i++)selected[i]=1;
    else {
        int axes[LN_MAXDIMS],count=0;axis_list(L,2,u->a->nd,axes,&count);
        unique_axes(L,axes,count);
        for(int i=0;i<count;i++)selected[axes[i]]=1;
    }
    /* NumPy 2.5.3 numeric.flip indexes 0-D with (), yielding a scalar. */
    if(u->a->nd==0){ln_intp idx[1]={0};return push_scalar_at(L,u->a,idx);}
    ln_error e={{0}};ln_array *v=ln_axis_reverse(u->a,selected,&e);
    if(!v)return fail(L,&e);
    return push_array(L,v);
}
static int flip_direction(lua_State *L, int minimum_rank, int axis) {
    lua_array *u=check_array(L,1);
    if(u->a->nd<minimum_rank)return luaL_error(L,"input must be >= %d-d",minimum_rank);
    unsigned char selected[LN_MAXDIMS]={0};selected[axis]=1;
    ln_error e={{0}};ln_array *v=ln_axis_reverse(u->a,selected,&e);
    if(!v)return fail(L,&e);
    return push_array(L,v);
}
static int np_flipud(lua_State *L){return flip_direction(L,1,0);}
static int np_fliplr(lua_State *L){return flip_direction(L,2,1);}
static int np_rot90(lua_State *L) {
    lua_array *u=check_array(L,1);
    int first=0,second=1;
    lua_Integer k=1;
    if(lua_type(L,2)!=LUA_TNONE&&lua_type(L,2)!=LUA_TNIL){
        if(!lua_isinteger(L,2))return luaL_error(L,"k must be an integer");
        k=lua_tointegerx(L,2,NULL);
    }
    if(lua_type(L,3)!=LUA_TNONE&&lua_type(L,3)!=LUA_TNIL){
        int ax[LN_MAXDIMS],n=0;axis_list(L,3,u->a->nd,ax,&n);
        if(n!=2)return luaL_error(L,"axes must be a sequence of length 2");
        if(ax[0]==ax[1])return luaL_error(L,"axes must be different");
        first=ax[0];second=ax[1];
    }
    int turns=(int)((k%4+4)%4);
    ln_error e={{0}};ln_array *v=ln_axis_rot90(u->a,turns,first,second,&e);
    if(!v)return fail(L,&e);
    return push_array(L,v);
}

/* Broadcast shape arguments are tables of nonnegative dimensions or a
 * single nonnegative integer, as in numpy.broadcast_to(a, 3). */
static int broadcast_shape_arg(lua_State *L,int idx,ln_intp *dims,int *nd) {
    if(lua_isinteger(L,idx)) {
        lua_Integer d=lua_tointegerx(L,idx,NULL);
        if(d<0)return luaL_error(L,"broadcast shape cannot contain negative dimensions");
        dims[0]=(ln_intp)d;*nd=1;return 0;
    }
    parse_shape(L,idx,dims,nd);
    for(int i=0;i<*nd;i++)if(dims[i]<0)
        return luaL_error(L,"broadcast shape cannot contain negative dimensions");
    return 0;
}
static ln_array *broadcast_arg(lua_State *L,int idx) {
    lua_array *u=test_array(L,idx);
    if(u)return u->a;
    /* Reuse the native constructor for Lua tables and scalars.  Its result
     * stays rooted on the Lua stack for the duration of the broadcast. */
    lua_pushcfunction(L,np_array);
    lua_pushvalue(L,idx);
    if(lua_pcall(L,1,1,0)!=LUA_OK)
        luaL_error(L,"cannot convert broadcast input: %s",lua_tostring(L,-1));
    u=check_array(L,-1);
    return u->a;
}
static int np_broadcast_to(lua_State *L) {
    ln_array *a=broadcast_arg(L,1);
    ln_intp dims[LN_MAXDIMS];int nd=0;
    broadcast_shape_arg(L,2,dims,&nd);
    ln_error e={{0}};
    ln_array *v=ln_axis_broadcast_to(a,nd,dims,1,&e);
    if(!v)return fail(L,&e);
    return push_array(L,v);
}
static int np_broadcast_arrays(lua_State *L) {
    int nargs=lua_gettop(L);
    if(nargs>64)return luaL_error(L,"broadcast_arrays accepts at most 64 arrays");
    const ln_array *arrs[64];
    for(int i=0;i<nargs;i++)arrs[i]=broadcast_arg(L,i+1);
    ln_intp dims[LN_MAXDIMS]={0};int nd=0;
    ln_error e={{0}};
    if(ln_broadcast_shape(nargs,arrs,&nd,dims,&e)<0)return fail(L,&e);
    lua_createtable(L,nargs,0);
    int result=lua_gettop(L);
    for(int i=0;i<nargs;i++) {
        ln_array *v=ln_axis_broadcast_to(arrs[i],nd,dims,0,&e);
        if(!v)return fail(L,&e);
        push_array(L,v);
        lua_seti(L,result,i+1);
    }
    return 1;
}
static int np_broadcast_shapes(lua_State *L) {
    int nargs=lua_gettop(L),nd=0;
    ln_intp accumulated[LN_MAXDIMS]={0}, next[LN_MAXDIMS]={0};
    for(int i=1;i<=nargs;i++) {
        ln_intp dims[LN_MAXDIMS];int n=0;
        broadcast_shape_arg(L,i,dims,&n);
        ln_array a={0},b={0};
        a.nd=nd;a.dimensions=accumulated;
        b.nd=n;b.dimensions=dims;
        const ln_array *arrs[2]={&a,&b};
        ln_error e={{0}};int out_nd=0;
        if(ln_broadcast_shape(2,arrs,&out_nd,next,&e)<0)return fail(L,&e);
        nd=out_nd;
        memcpy(accumulated,next,(size_t)nd*sizeof(ln_intp));
    }
    lua_createtable(L,nd,0);
    for(int i=0;i<nd;i++) {lua_pushinteger(L,(lua_Integer)accumulated[i]);lua_seti(L,-2,i+1);}
    return 1;
}


/* Like numpy.atleast_1d/2d/3d, accept multiple array-likes.  One argument
 * returns a single ndarray; zero or multiple arguments returns a Lua table.
 * Converted scalar/table operands remain rooted on the Lua stack until all
 * native views have taken an ownership reference to their buffers. */
static int atleast_function(lua_State *L, int minimum_nd) {
    int n = lua_gettop(L);
    if (n > 256) return luaL_error(L, "atleast accepts at most 256 inputs");
    if (n == 0) { lua_createtable(L, 0, 0); return 1; }
    if (n == 1) {
        ln_array *a = broadcast_arg(L, 1);
        ln_error e = {{0}};
        ln_array *result = ln_axis_atleast(a, minimum_nd, &e);
        if (!result) return fail(L, &e);
        return push_array(L, result);
    }
    /* Using absolute indexes preserves the original arguments when a
     * table/scalar is converted through the Lua constructor on the stack. */
    lua_createtable(L, n, 0);
    int result_index = lua_gettop(L);
    for (int i = 1; i <= n; ++i) {
        ln_array *a = broadcast_arg(L, i);
        ln_error e = {{0}};
        ln_array *result = ln_axis_atleast(a, minimum_nd, &e);
        if (!result) return fail(L, &e);
        push_array(L, result);
        lua_seti(L, result_index, i);
    }
    lua_pushvalue(L, result_index);
    return 1;
}
static int np_atleast_1d(lua_State *L) { return atleast_function(L, 1); }
static int np_atleast_2d(lua_State *L) { return atleast_function(L, 2); }
static int np_atleast_3d(lua_State *L) { return atleast_function(L, 3); }

/* Copies, not views: NumPy's tile and repeat family. `repeat` is a Lua
 * keyword, so repeat_elements is an additional accessible dot-syntax alias. */
static ln_intp read_nonnegative_count(lua_State *L,int idx,int allow_float) {
    if(lua_type(L,idx)==LUA_TBOOLEAN)return (ln_intp)lua_toboolean(L,idx);
    if(!allow_float && lua_type(L,idx)==LUA_TNUMBER && !lua_isinteger(L,idx))
        return (ln_intp)luaL_error(L,"tile repetitions must be integers");
    int exact=0;
    lua_Integer count=lua_tointegerx(L,idx,&exact);
    if(!exact && allow_float && lua_type(L,idx)==LUA_TNUMBER){
        lua_Number x=lua_tonumberx(L,idx,NULL);
        /* NumPy's repeat accepts scalar/Python-sequence float counts and
         * truncates them when converting to intp; dtype=float ndarray inputs
         * are different and are rejected by NumPy's safe-casting rule. */
        if(!isfinite(x) || x<-(double)INT64_MAX || x>=9223372036854775808.0)
            luaL_error(L,"repetition count is outside intp range");
        count=(lua_Integer)x;
        exact=1;
    }
    if(!exact)return (ln_intp)luaL_error(L,"repetition counts must be integers");
    if(count<0)luaL_error(L,"repetition counts cannot be negative");
    return (ln_intp)count;
}
static void read_counts(lua_State *L,int idx,ln_intp *counts,size_t *n,int allow_float) {
    idx=lua_absindex(L,idx);
    if(lua_type(L,idx)==LUA_TNUMBER || lua_type(L,idx)==LUA_TBOOLEAN) {
        counts[0]=read_nonnegative_count(L,idx,allow_float);*n=1;return;
    }
    if(lua_type(L,idx)==LUA_TTABLE){
        size_t count=lua_rawlen(L,idx);
        for(size_t i=0;i<count;i++) {
            lua_geti(L,idx,(lua_Integer)i+1);
            counts[i]=read_nonnegative_count(L,-1,allow_float);
            lua_pop(L,1);
        }
        *n=count;return;
    }
    lua_array *u=test_array(L,idx);
    if(!u){luaL_error(L,"repetitions must be an integer, table, or integer ndarray");return;}
    const ln_array *a=u->a;
    if(a->nd>1 || (a->descr->kind!='i' && a->descr->kind!='u' && a->descr->kind!='b'))
        luaL_error(L,"repetitions must be a scalar or 1-D integer ndarray");
    if(allow_float && a->descr->type_num==LN_ULONGLONG)
        luaL_error(L,"uint64 repetitions cannot be cast safely to int64");
    size_t count=a->nd?(size_t)a->dimensions[0]:1;
    for(size_t i=0;i<count;i++) {
        ln_intp coords[1]={(ln_intp)i};
        double v=0;int64_t iv=0;int is_integer=0;
        ln_error e={{0}};
        if(ln_array_get_number(a,coords,&v,&iv,&is_integer,&e)<0)fail(L,&e);
        if(iv<0)luaL_error(L,"repetition counts cannot be negative or exceed intp");
        counts[i]=(ln_intp)iv;
    }
    *n=count;
}
static int np_tile(lua_State *L) {
    ln_array *a=broadcast_arg(L,1);
    int idx=2;
    size_t count=1;
    if(lua_type(L,idx)==LUA_TTABLE)count=lua_rawlen(L,idx);
    else {lua_array *r=test_array(L,idx);if(r && r->a->nd==1)count=(size_t)r->a->dimensions[0];}
    if(count>LN_MAXDIMS)return luaL_error(L,"tile repetitions exceed maximum rank");
    ln_intp reps[LN_MAXDIMS]={0};size_t n=0;
    read_counts(L,idx,reps,&n,0);
    ln_error e={{0}};ln_array *out=ln_tile(a,(int)n,reps,&e);
    if(!out)return fail(L,&e);
    return push_array(L,out);
}
static int np_repeat_elements(lua_State *L) {
    ln_array *a=broadcast_arg(L,1);
    int axis=-1;
    if(lua_type(L,3)!=LUA_TNONE && lua_type(L,3)!=LUA_TNIL &&
       !(lua_type(L,3)==LUA_TBOOLEAN && !lua_toboolean(L,3))) {
        lua_Integer raw=luaL_checkinteger(L,3);
        if(normalize_lua_axis(L,raw,a->nd?a->nd:1,&axis))return 0;
    }
    size_t count=1;
    if(lua_type(L,2)==LUA_TTABLE)count=lua_rawlen(L,2);
    else {lua_array *r=test_array(L,2);if(r && r->a->nd==1)count=(size_t)r->a->dimensions[0];}
    if(count>SIZE_MAX/sizeof(ln_intp))return luaL_error(L,"repetition counts too large");
    ln_intp *reps=(ln_intp*)lua_newuserdatauv(L,(count?count:1)*sizeof(ln_intp),0);
    size_t n=0;read_counts(L,2,reps,&n,1);
    ln_error e={{0}};ln_array *out=ln_repeat(a,axis,n,reps,&e);
    if(!out)return fail(L,&e);
    return push_array(L,out);
}

/* Roll: shift may be a scalar or a 1-D Lua sequence; axis is a scalar,
 * sequence, or omitted/false. Axis indexing follows LuaRay's 1-based public
 * contract and is converted to zero-based before reaching the C kernel.
 * Multiple shifts on the same axis are combined modulo its length to avoid
 * overflow even for int64 shift values. */
static lua_Integer roll_read_shift(lua_State *L, int index) {
    int ty=lua_type(L,index);
    if(ty==LUA_TBOOLEAN)return (lua_Integer)lua_toboolean(L,index);
    if(ty==LUA_TNUMBER){
        if(lua_isinteger(L,index))return lua_tointegerx(L,index,NULL);
        lua_Number number=lua_tonumberx(L,index,NULL);
        /* numeric.roll performs int(shift) at its Python boundary */
        if(!isfinite(number) || number<-9223372036854775808.0 ||
           number>=9223372036854775808.0)
            luaL_error(L,"roll shift cannot be converted to int64");
        return (lua_Integer)number;
    }
    luaL_error(L,"roll shifts must be numbers or booleans");
    return 0;
}
static int roll_shifts(lua_State *L, int index, lua_Integer *out, int *number) {
    if(lua_type(L,index)==LUA_TNUMBER || lua_type(L,index)==LUA_TBOOLEAN){
        out[0]=roll_read_shift(L,index);*number=1;return 0;
    }
    if(lua_type(L,index)==LUA_TTABLE){
        size_t n=lua_rawlen(L,index);
        if(n>LN_MAXDIMS)return luaL_error(L,"too many roll shifts");
        for(size_t i=0;i<n;i++){
            lua_geti(L,index,(lua_Integer)i+1);
            out[i]=roll_read_shift(L,-1);
            lua_pop(L,1);
        }
        *number=(int)n;return 0;
    }
    lua_array *r=test_array(L,index);
    if(!r)return luaL_error(L,"roll shift must be numeric, a sequence, or an ndarray");
    const ln_array *a=r->a;
    if(a->nd>1)return luaL_error(L,"roll shifts must be scalar or 1-D");
    if(a->descr->kind!='i' && a->descr->kind!='u' &&
       a->descr->kind!='b' && a->descr->kind!='f')
        return luaL_error(L,"roll shifts must have numeric dtype");
    /* For uint64 counts beyond int64, using ln_array_get_number's signed
     * slot would silently change the effective modulo. Reject instead of
     * producing a numerically wrong shift until full uint64 parsing lands. */
    if(a->descr->type_num==LN_ULONGLONG)
        return luaL_error(L,"uint64 ndarray roll shifts are not supported yet");
    size_t n=a->nd?(size_t)a->dimensions[0]:1;
    if(n>LN_MAXDIMS)return luaL_error(L,"too many roll shifts");
    for(size_t i=0;i<n;i++){
        ln_intp coord[1]={(ln_intp)i};
        double v=0;int64_t iv=0;int integer=0;
        ln_error e={{0}};
        if(ln_array_get_number(a,coord,&v,&iv,&integer,&e)<0)return fail(L,&e);
        /* i/u/b use their exact integer slot, floats mimic int() truncation. */
        if(a->descr->kind=='f') {
            if(!isfinite(v) || v<-9223372036854775808.0 || v>=9223372036854775808.0)
                return luaL_error(L,"roll shift cannot be converted to int64");
            out[i]=(lua_Integer)v;
        } else out[i]=(lua_Integer)iv;
    }
    *number=(int)n;
    return 0;
}
static ln_intp roll_mod(lua_Integer value, ln_intp length) {
    if(length<=1)return 0;
    ln_intp r=(ln_intp)(value % (lua_Integer)length);
    return r<0?r+length:r;
}
static int np_roll(lua_State *L) {
    ln_array *a=broadcast_arg(L,1);
    lua_Integer shifts[LN_MAXDIMS];int nshift=0;
    roll_shifts(L,2,shifts,&nshift);
    int flatten=lua_type(L,3)==LUA_TNONE || lua_type(L,3)==LUA_TNIL ||
                (lua_type(L,3)==LUA_TBOOLEAN && !lua_toboolean(L,3));
    int axes[LN_MAXDIMS],naxes=0;
    if(flatten){axes[0]=0;naxes=1;}
    else axis_list(L,3,a->nd,axes,&naxes); /* duplicates deliberately allowed */
    /* NumPy numeric.roll's empty-axis path fails on 0-D inputs when the
     * subsequent result assignment unpacks zero axis indices. */
    if(a->nd==0 && !flatten && naxes==0)
        return luaL_error(L,"roll axis is invalid for a zero-dimensional array");
    if(nshift!=1 && naxes!=1 && nshift!=naxes && !(nshift==0 && naxes==0))
        return luaL_error(L,"'shift' and 'axis' should be scalars or 1D sequences with compatible lengths");
    ln_intp offsets[LN_MAXDIMS]={0};
    if(flatten){
        ln_intp size=ln_array_size(a);
        for(int i=0;i<nshift;i++){
            ln_intp v=roll_mod(shifts[i],size);
            if(size>0)offsets[0]=(offsets[0]>=size-v)?offsets[0]-(size-v):offsets[0]+v;
        }
    } else {
        int n=(nshift==0 || naxes==0)?0:(nshift>naxes?nshift:naxes);
        for(int i=0;i<n;i++){
            int axis=axes[naxes==1?0:i];
            ln_intp length=a->dimensions[axis];
            ln_intp v=roll_mod(shifts[nshift==1?0:i],length);
            if(length>0)offsets[axis]=(offsets[axis]>=length-v)?offsets[axis]-(length-v):offsets[axis]+v;
        }
    }
    ln_error e={{0}};
    ln_array *r=ln_roll(a,flatten,offsets,&e);
    if(!r)return fail(L,&e);
    return push_array(L,r);
}

/* rollaxis(a, axis, start=1) shares the source allocation.  'start' is an
 * insertion boundary in Lua's 1-based public axis convention (1..nd+1). */
static int np_rollaxis(lua_State *L) {
    lua_array *u=check_array(L,1);
    int nd=u->a->nd;
    if(!lua_isinteger(L,2))return luaL_error(L,"rollaxis axis must be an integer");
    int axis=axis_strict(L,lua_tointegerx(L,2,NULL),nd);
    lua_Integer raw=lua_type(L,3)==LUA_TNONE || lua_type(L,3)==LUA_TNIL?1:luaL_checkinteger(L,3);
    if(raw==0)return luaL_error(L,"start 0 is invalid in LuaRay");
    if(raw>nd+1 || raw<-(lua_Integer)nd)return luaL_error(L,"rollaxis start is out of bounds");
    int start=raw>0?(int)raw-1:nd+(int)raw;
    if(axis<start)start--;
    int order[LN_MAXDIMS],n=0;
    for(int i=0;i<nd;i++)if(i!=axis)order[n++]=i;
    for(int i=nd-1;i>start;i--)order[i]=order[i-1];
    order[start]=axis;
    ln_error e={{0}};
    ln_array *r=ln_axis_permute(u->a,order,&e);
    if(!r)return fail(L,&e);
    return push_array(L,r);
}

static int np_reshape(lua_State*L){return array_reshape(L);} 

static int np_arange(lua_State*L){lua_Integer stop=luaL_checkinteger(L,1);if(stop<0)stop=0;ln_intp sh[]={stop};const ln_dtype*dt=dtype_arg(L,2,ln_dtype_by_name("int64"));if(!dt)return luaL_error(L,"unsupported dtype");ln_error e={{0}};ln_array*a=ln_array_new(1,sh,dt,0,0,&e);if(!a)return fail(L,&e);for(lua_Integer i=0;i<stop;i++){ln_intp q[]={i};if(ln_array_set_number(a,q,(double)i,(int64_t)i,1,&e)<0){ln_array_free(a);return fail(L,&e);}}return push_array(L,a);} 


static int np_datetime_as_string(lua_State *L){
    lua_datetime_scalar *x=test_datetime_scalar(L,1);
    lua_array *xa=test_array(L,1);
    const ln_dtype_descr *indescr=x?x->descr:(xa?xa->a->descr:NULL);
    if(!indescr||indescr->type_num!=LN_DATETIME)return luaL_error(L,"input must have type NumPy datetime");
    const ln_datetime_meta *m=ln_datetime_metadata(indescr);ln_datetime_unit unit=m->base;int auto_unit=0;ln_datetime_timezone_mode tz=LN_DT_TZ_NAIVE;int tzoff=0;ln_datetime_string_casting casting=LN_DT_CAST_SAME_KIND;
    if(lua_gettop(L)>=2&&lua_type(L,2)!=LUA_TNIL){
        if(lua_type(L,2)==LUA_TSTRING){const char*u=lua_tostring(L,2);if(strcmp(u,"auto")==0)auto_unit=1;else{char b[64];snprintf(b,sizeof(b),"datetime64[%s]",u);const ln_dtype_descr*d=ln_dtype_by_name(b);if(!d)return luaL_error(L,"invalid datetime_as_string unit");unit=ln_datetime_metadata(d)->base;}}
        else if(lua_type(L,2)==LUA_TTABLE){
            lua_getfield(L,2,"unit");if(lua_type(L,-1)!=LUA_TNIL){const char*u=luaL_checklstring(L,-1,NULL);if(strcmp(u,"auto")==0)auto_unit=1;else{char b[64];snprintf(b,sizeof(b),"datetime64[%s]",u);const ln_dtype_descr*d=ln_dtype_by_name(b);if(!d){lua_pop(L,1);return luaL_error(L,"invalid datetime_as_string unit");}unit=ln_datetime_metadata(d)->base;}}lua_pop(L,1);
            lua_getfield(L,2,"timezone");if(lua_type(L,-1)!=LUA_TNIL){if(lua_type(L,-1)==LUA_TNUMBER){tz=LN_DT_TZ_OFFSET;tzoff=(int)luaL_checkinteger(L,-1);}else{const char*z=luaL_checklstring(L,-1,NULL);if(strcmp(z,"naive")==0)tz=LN_DT_TZ_NAIVE;else if(strcmp(z,"UTC")==0)tz=LN_DT_TZ_UTC;else if(strcmp(z,"local")==0)tz=LN_DT_TZ_LOCAL;else{lua_pop(L,1);return luaL_error(L,"unsupported timezone string");}}}lua_pop(L,1);
            lua_getfield(L,2,"casting");if(lua_type(L,-1)!=LUA_TNIL){const char*c=luaL_checklstring(L,-1,NULL);if(strcmp(c,"safe")==0)casting=LN_DT_CAST_SAFE;else if(strcmp(c,"same_kind")==0)casting=LN_DT_CAST_SAME_KIND;else if(strcmp(c,"unsafe")==0)casting=LN_DT_CAST_UNSAFE;else if(strcmp(c,"same_value")==0)casting=LN_DT_CAST_SAME_VALUE;else{lua_pop(L,1);return luaL_error(L,"unsupported datetime string casting rule");}}lua_pop(L,1);
        }else return luaL_error(L,"datetime_as_string options must be a unit string or table");
    }
    if(x){char out[192];ln_error e={{0}};if(ln_datetime_format_iso8601(x->value,m,unit,auto_unit,tz,tzoff,casting,out,sizeof(out),&e)<0)return fail(L,&e);lua_pushstring(L,out);return 1;}

    int local=(tz==LN_DT_TZ_LOCAL||tz==LN_DT_TZ_OFFSET);
    int strsize=ln_datetime_iso8601_strlen(local,auto_unit?LN_FR_ERROR:unit);
    ln_error e={{0}};const ln_dtype_descr *udt=ln_string_make_dtype(1,(size_t)strsize,'=',&e);if(!udt)return fail(L,&e);
    int fortran=(xa->a->flags&LN_ARRAY_F_CONTIGUOUS)&&!(xa->a->flags&LN_ARRAY_C_CONTIGUOUS);
    ln_array *outa=ln_array_new(xa->a->nd,xa->a->dimensions,udt,fortran,1,&e);if(!outa)return fail(L,&e);
    ln_intp total=ln_array_size(xa->a);if(total<0){ln_array_free(outa);return luaL_error(L,"array is too large");}
    ln_intp idx[LN_MAXDIMS]={0};
    for(ln_intp k=0;k<total;k++){
        double d=0;int64_t iv=0;int isint=0;if(ln_array_get_number(xa->a,idx,&d,&iv,&isint,&e)<0){ln_array_free(outa);return fail(L,&e);}
        char buf[192];if(ln_datetime_format_iso8601(iv,m,unit,auto_unit,tz,tzoff,casting,buf,sizeof(buf),&e)<0){ln_array_free(outa);return fail(L,&e);}
        if(ln_array_pack_string(outa,idx,buf,strlen(buf),&e)<0){ln_array_free(outa);return fail(L,&e);}
        for(int q=xa->a->nd-1;q>=0;q--){idx[q]++;if(idx[q]<xa->a->dimensions[q])break;idx[q]=0;}
    }
    return push_array(L,outa);
}


/* Random Generator: scalar uint64 SeedSequence + PCG64, same raw stream as
 * NumPy default_rng(seed). No global hidden RNG state. */
static ln_pcg64 *check_generator(lua_State *L,int idx)
{
    return (ln_pcg64 *)luaL_checkudata(L,idx,GENERATOR_MT);
}

static uint64_t lua_random_seed(lua_State *L,int idx)
{
    int typ=lua_type(L,idx);
    if(typ==LUA_TNONE || typ==LUA_TNIL) {
        uint64_t seed;
        FILE *f=fopen("/dev/urandom","rb");
        if(!f)return (uint64_t)luaL_error(L,"cannot read operating-system randomness");
        size_t got=fread(&seed,1,sizeof(seed),f);
        int closed=fclose(f);
        if(got!=sizeof(seed)||closed!=0)return (uint64_t)luaL_error(L,"operating-system randomness unavailable");
        return seed;
    }
    if(!lua_isinteger(L,idx)) {
        (void)luaL_error(L,"random seed must be a nonnegative Lua integer");
        return 0;
    }
    lua_Integer seed=luaL_checkinteger(L,idx);
    if(seed<0) {
        (void)luaL_error(L,"random seed must not be negative");
        return 0;
    }
    return (uint64_t)seed;
}

static int lua_default_rng(lua_State *L)
{
    if(lua_gettop(L)>1)return luaL_error(L,"default_rng accepts at most one seed");
    uint64_t seed=lua_random_seed(L,1);
    ln_pcg64 *rng=(ln_pcg64 *)lua_newuserdatauv(L,sizeof(*rng),0);
    ln_pcg64_seed(rng,seed);
    luaL_setmetatable(L,GENERATOR_MT);
    return 1;
}

static int lua_generator_reseed(lua_State *L)
{
    ln_pcg64 *rng=check_generator(L,1);
    if(lua_gettop(L)>2)return luaL_error(L,"reseed accepts one seed");
    ln_pcg64_seed(rng,lua_random_seed(L,2));
    return 0;
}

static int lua_generator_advance(lua_State *L)
{
    ln_pcg64 *rng=check_generator(L,1);
    lua_Integer steps=luaL_checkinteger(L,2);
    if(steps<0)return luaL_error(L,"advance requires a nonnegative step count");
    ln_pcg64_advance(rng,(uint64_t)steps);
    return 0;
}

static int lua_generator_raw_hex(lua_State *L)
{
    ln_pcg64 *rng=check_generator(L,1);
    char str[17];snprintf(str,sizeof(str),"%016llx",(unsigned long long)ln_pcg64_next64(rng));
    lua_pushstring(L,str);
    return 1;
}

static int lua_random_shape(lua_State *L,int idx,ln_intp *dims,int *nd,int *has_size)
{
    int t=lua_type(L,idx);
    *nd=0;*has_size=(t!=LUA_TNONE&&t!=LUA_TNIL);
    if(!*has_size)return 0;
    if(t==LUA_TNUMBER) {
        if(!lua_isinteger(L,idx))return luaL_error(L,"size must be an integer or shape table");
        lua_Integer d=luaL_checkinteger(L,idx);
        if(d<0)return luaL_error(L,"negative dimension");
        dims[0]=(ln_intp)d;*nd=1;return 0;
    }
    if(t!=LUA_TTABLE)return luaL_error(L,"size must be an integer or shape table");
    size_t len=lua_rawlen(L,idx);
    if(len>LN_MAXDIMS)return luaL_error(L,"maximum supported dimension count exceeded");
    for(size_t i=0;i<len;i++) {
        lua_geti(L,idx,(lua_Integer)i+1);
        if(!lua_isinteger(L,-1)){lua_pop(L,1);return luaL_error(L,"shape dimensions must be integers");}
        lua_Integer d=luaL_checkinteger(L,-1);lua_pop(L,1);
        if(d<0)return luaL_error(L,"negative dimension");
        dims[i]=(ln_intp)d;
    }
    *nd=(int)len;
    return 0;
}

/* NumPy Generator.random(size=nil, dtype="float64", out=nil).
 * float32 uses PCG64's cached uint32 stream; it MUST NOT round float64.
 * NumPy's fill API requires native-endian, C-contiguous writable out.
 */
static int lua_generator_random(lua_State *L)
{
    ln_pcg64 *rng=check_generator(L,1);
    if(lua_gettop(L)>4)return luaL_error(L,"random accepts size, dtype and out");
    const char *dtype=((lua_type(L,3)==LUA_TNIL||lua_type(L,3)==LUA_TNONE))?"float64":luaL_checklstring(L,3,NULL);
    const int is32=strcmp(dtype,"float32")==0;
    if(!is32&&strcmp(dtype,"float64")!=0)
        return luaL_error(L,"random dtype must be float32 or float64");
    lua_array *provided=NULL;
    if((lua_type(L,4)!=LUA_TNIL&&lua_type(L,4)!=LUA_TNONE)){
        provided=test_array(L,4);
        if(!provided)return luaL_error(L,"random out must be an ndarray");
    }
    ln_intp dims[LN_MAXDIMS];int nd,has_size;
    if(lua_random_shape(L,2,dims,&nd,&has_size))return 0;
    ln_array *out=NULL;ln_error e={{0}};
    if(provided){
        out=provided->a;
        if(out->descr->type_num!=(is32?LN_FLOAT:LN_DOUBLE))
            return luaL_error(L,"random out dtype must match dtype");
        if(!(out->flags & LN_ARRAY_WRITEABLE)||!(out->flags & LN_ARRAY_C_CONTIGUOUS))
            return luaL_error(L,"random out must be writable and C-contiguous");
        if(has_size){
            if(out->nd!=nd)return luaL_error(L,"random size must match out.shape");
            for(int j=0;j<nd;j++)if(out->dimensions[j]!=dims[j])
                return luaL_error(L,"random size must match out.shape");
        }
        nd=out->nd;
    }else if(has_size){
        out=ln_array_new(nd,dims,ln_dtype_by_num(is32?LN_FLOAT:LN_DOUBLE),0,0,&e);
        if(!out)return fail(L,&e);
    }else{
        if(is32){
            float val=(ln_pcg64_next32(rng)>>8)*(1.0f/16777216.0f);
            lua_pushnumber(L,(lua_Number)val);
        }else lua_pushnumber(L,ln_pcg64_next_double(rng));
        return 1;
    }
    ln_intp n=ln_array_size(out);
    if(n<0){if(!provided)ln_array_free(out);return luaL_error(L,"random sample shape too large");}
    if(is32){
        float *p=(float *)out->data;
        for(ln_intp i=0;i<n;i++)p[i]=(ln_pcg64_next32(rng)>>8)*(1.0f/16777216.0f);
    }else{
        double *p=(double *)out->data;
        for(ln_intp i=0;i<n;i++)p[i]=ln_pcg64_next_double(rng);
    }
    if(provided){lua_pushvalue(L,4);return 1;}
    return push_array(L,out);
}

/* NumPy Generator.bytes(length) serializes uint32 draws as little-endian
 * bytes, independent of machine byte order; no extra draw for a partial word.
 * Lua strings support embedded NUL bytes and are therefore suitable here. */
static int lua_generator_bytes(lua_State *L)
{
    ln_pcg64 *rng=check_generator(L,1);
    if(lua_gettop(L)!=2||!lua_isinteger(L,2))
        return luaL_error(L,"bytes requires an integer length");
    lua_Integer n=luaL_checkinteger(L,2);
    if(n<0)return luaL_error(L,"bytes requires a nonnegative length");
    if((uint64_t)n>SIZE_MAX-1)return luaL_error(L,"bytes length too large");
    size_t len=(size_t)n;
    /* NumPy integers(dtype=uint32, size=0) still primes one uint32. */
    if(len==0){(void)ln_pcg64_next32(rng);lua_pushlstring(L,"",0);return 1;}
    char *buffer=(char*)malloc(len);
    if(!buffer)return luaL_error(L,"bytes allocation failed");
    for(size_t i=0;i<len;){
        uint32_t word=ln_pcg64_next32(rng);
        for(int b=0;b<4&&i<len;b++,i++)buffer[i]=(char)(word>>(8*b));
    }
    lua_pushlstring(L,buffer,len);
    free(buffer);
    return 1;
}

/* NumPy Generator parameter broadcasting.  A parameter can be a scalar,
 * an ndarray (including noncontiguous/negative-stride views) or a Lua table.
 * Retain temporary converted tables on the Lua stack until the C call exits.
 * This is deliberately limited to the float64 families below; it must not
 * change integer / rejection-sampling distributions' random draw order. */
typedef struct {
    const ln_array *array;
    double scalar;
} lua_random_bparam;

static lua_random_bparam lua_random_param(lua_State *L,int idx,double default_value)
{
    lua_random_bparam p={NULL,default_value};
    int t=lua_type(L,idx);
    if(t==LUA_TNIL||t==LUA_TNONE)return p;
    if(t==LUA_TNUMBER){p.scalar=luaL_checknumber(L,idx);return p;}
    lua_array *a=test_array(L,idx);
    if(a){p.array=a->a;return p;}
    if(t!=LUA_TTABLE)luaL_error(L,"random parameter must be numeric, ndarray or table");
    lua_pushcfunction(L,np_array);
    lua_pushvalue(L,idx);
    lua_pushstring(L,"float64");
    if(lua_pcall(L,2,1,0)!=LUA_OK)
        luaL_error(L,"invalid random parameter array: %s",lua_tostring(L,-1));
    p.array=check_array(L,-1)->a;
    return p;
}

static int lua_random_broadcast_dims(lua_State *L,const lua_random_bparam *a,
                                     const lua_random_bparam *b,int has_size,
                                     ln_intp *dims,int *nd)
{
    const ln_array *arrays[2]={a->array,b->array};
    int max_nd=*nd;
    if(!has_size){
        for(int k=0;k<2;k++)if(arrays[k]&&arrays[k]->nd>max_nd)
            max_nd=arrays[k]->nd;
        if(max_nd>LN_MAXDIMS)return luaL_error(L,"random broadcast dimension limit");
        for(int j=0;j<max_nd;j++)dims[j]=1;
    }
    for(int k=0;k<2;k++){
        const ln_array *ar=arrays[k];
        if(!ar)continue;
        if(ar->nd>max_nd)return luaL_error(L,"random size is incompatible with parameter broadcast shape");
        for(int j=0;j<ar->nd;j++){
            int dst=max_nd-ar->nd+j;
            ln_intp d=ar->dimensions[j],old=dims[dst];
            if(has_size){
                if(d!=1&&d!=old)return luaL_error(L,"random size is incompatible with parameter broadcast shape");
            }else if(old==1)dims[dst]=d;
            else if(d!=1&&d!=old)return luaL_error(L,"random parameter shapes cannot broadcast");
        }
    }
    *nd=max_nd;
    return 0;
}

static double lua_random_bget(lua_State *L,const lua_random_bparam *p,int nd,
                              const ln_intp *output_idx)
{
    if(!p->array)return p->scalar;
    const ln_array *a=p->array;
    ln_intp index[LN_MAXDIMS]={0};
    for(int j=0;j<a->nd;j++)index[j]=a->dimensions[j]==1?0:output_idx[nd-a->nd+j];
    double v=0;int64_t iv=0;int isint=0;ln_error e={{0}};
    if(ln_array_get_number(a,index,&v,&iv,&isint,&e)<0)luaL_error(L,"random parameter dtype: %s",e.message);
    return isint?(double)iv:v;
}

/* kind: 0 uniform, 1 normal, 2 exponential, 3 lognormal,
 * 4 laplace, 5 gumbel, 6 logistic, 7 rayleigh, 8 weibull,
 * 9 pareto, 10 power, 11 gamma, 12 beta, 13 chisquare,
 * 14 Fisher F, 15 Wald (inverse Gaussian), 16 logseries (int64),
 * 17 geometric (int64), 18 poisson (int64),
 * 19 binomial (int64), 20 negative_binomial (int64),
 * 21 standard_t (float64), 22 vonmises (float64), 23 zipf (int64).
 * Preserve scalar family paths unmodified.
 * Validate parameters before drawing: rejected vector arguments may not
 * advance PCG64. Iterate samples in C order, regardless of input strides. */
static int lua_generator_broadcast_sample(lua_State *L,ln_pcg64 *rng,
                                          int kind,int size_arg)
{
    ln_intp dims[LN_MAXDIMS]={0};int nd=0,has_size=0;
    if(lua_random_shape(L,size_arg,dims,&nd,&has_size))return 0;
    const int unary=(kind==2||(kind>=7&&kind<=10)||kind==13||kind==16||kind==17||kind==18||kind==21||kind==23);
    lua_random_bparam a=lua_random_param(L,2,
                    kind==0||kind==1||kind==3||kind==4||kind==5||kind==6?0.0:1.0);
    lua_random_bparam b=unary?(lua_random_bparam){NULL,0.0}:
                          lua_random_param(L,3,1.0);
    if(lua_random_broadcast_dims(L,&a,&b,has_size,dims,&nd))return 0;
    /* Validate on the *parameter* broadcast, not just output elements.
     * NumPy raises for scale=[-1] even when size=(0,). */
    ln_intp vdims[LN_MAXDIMS]={0};int vnd=0;
    if(lua_random_broadcast_dims(L,&a,&b,0,vdims,&vnd))return 0;
    size_t validation_count=1;
    for(int j=0;j<vnd;j++){
        if(vdims[j]==0){validation_count=0;break;}
        if((size_t)vdims[j]>SIZE_MAX/validation_count)
            return luaL_error(L,"random broadcast validation size too large");
        validation_count*=(size_t)vdims[j];
    }
    ln_intp ix[LN_MAXDIMS]={0};
    for(size_t i=0;i<validation_count;i++){
        double lo=lua_random_bget(L,&a,vnd,ix);
        double hi=!unary?lua_random_bget(L,&b,vnd,ix):0;
        int invalid=(kind==23)?(isnan(lo)||lo<=1.0):
                    (kind==17)?(!isfinite(lo)||lo<=0.0||lo>1.0):
                    (kind==18)?(!isfinite(lo)||lo<0.0||lo>1e12):
                    (kind>=11&&kind<=14)?(!isfinite(lo)||(kind==11?lo<0.0:lo<=0.0)||(!unary&&(!isfinite(hi)||(kind==11?hi<0.0:hi<=0.0)))):
                    (kind==15)?(isnan(lo)||lo<=0.0||isnan(hi)||hi<=0.0):
                    (kind==21)?(lo<=0.0):
                    (kind==22)?(hi<0.0):
                    (kind==16)?(isnan(lo)||lo<0.0||lo>=1.0):
                    (kind==0)?(!isfinite(lo)||!isfinite(hi)||hi<lo||!isfinite(hi-lo)):
                    (kind==1||kind==3||kind==4||kind==5||kind==6)?(hi<0.0):
                    (kind==9||kind==10)?(lo<=0.0):(lo<0.0);
        /* 0.77 normal/exponential rejected NaN scale; NumPy accepts NaN for
         * these distribution families, whereas 0.77's established behavior
         * stays unchanged to avoid silent regressions. */
        if(kind==1)invalid=(isnan(hi)||hi<0.0);
        if(kind==2)invalid=(isnan(lo)||lo<0.0);
        /* Binomial n may be a floating-point count (NumPy truncates towards
         * zero before sampling), but cannot exceed the safe scalar bound.
         * Retain the existing conservative negative-binomial bounds. */
        if(kind==19)invalid=!isfinite(lo)||lo<=-1.0||lo>1e12||
                             !isfinite(hi)||hi<0.0||hi>1.0;
        if(kind==20)invalid=!isfinite(lo)||lo<=0.0||lo>1e6||
                             !isfinite(hi)||hi<0.001||hi>1.0;
        if(invalid)return luaL_error(L,"invalid random broadcast parameter");
        for(int j=vnd-1;j>=0;j--){if(++ix[j]<vdims[j])break;ix[j]=0;}
    }
    ln_error e={{0}};
    ln_array *out=ln_array_new(nd,dims,((kind>=16&&kind<=20)||kind==23)?ln_dtype_by_name("int64"):
                               ln_dtype_by_num(LN_DOUBLE),0,0,&e);
    if(!out)return fail(L,&e);
    ln_intp n=ln_array_size(out);
    if(n<0){ln_array_free(out);return luaL_error(L,"random sample shape too large");}
    memset(ix,0,sizeof(ix));
    double *v=(double*)out->data;
    for(ln_intp i=0;i<n;i++){
        double lo=lua_random_bget(L,&a,nd,ix);
        double hi=!unary?lua_random_bget(L,&b,nd,ix):0;
        switch(kind){
            case 0: v[i]=lo+(hi-lo)*ln_pcg64_next_double(rng);break;
            case 1: v[i]=lo+hi*ln_pcg64_standard_normal(rng);break;
            case 2: v[i]=lo*ln_pcg64_standard_exponential(rng);break;
            case 3: v[i]=ln_pcg64_lognormal(rng,lo,hi);break;
            case 4: v[i]=ln_pcg64_laplace(rng,lo,hi);break;
            case 5: v[i]=ln_pcg64_gumbel(rng,lo,hi);break;
            case 6: v[i]=ln_pcg64_logistic(rng,lo,hi);break;
            case 7: v[i]=ln_pcg64_rayleigh(rng,lo);break;
            case 8: v[i]=ln_pcg64_weibull(rng,lo);break;
            case 9: v[i]=ln_pcg64_pareto(rng,lo);break;
            case 10:v[i]=ln_pcg64_power(rng,lo);break;
            case 11:v[i]=ln_pcg64_gamma(rng,lo,hi);break;
            case 12:v[i]=ln_pcg64_beta(rng,lo,hi);break;
            case 13:v[i]=ln_pcg64_chisquare(rng,lo);break;
            case 14:v[i]=ln_pcg64_f(rng,lo,hi);break;
            case 15:v[i]=ln_pcg64_wald(rng,lo,hi);break;
            case 16:((int64_t*)out->data)[i]=ln_pcg64_logseries(rng,lo);break;
            case 17:((int64_t*)out->data)[i]=ln_pcg64_geometric(rng,lo);break;
            case 18:((int64_t*)out->data)[i]=ln_pcg64_poisson(rng,lo);break;
            case 19:((int64_t*)out->data)[i]=ln_pcg64_binomial(rng,(int64_t)lo,hi);break;
            case 20:((int64_t*)out->data)[i]=ln_pcg64_negative_binomial(rng,lo,hi);break;
            case 21:v[i]=ln_pcg64_standard_t(rng,lo);break;
            case 22:v[i]=ln_pcg64_vonmises(rng,lo,hi);break;
            case 23:((int64_t*)out->data)[i]=ln_pcg64_zipf(rng,lo);break;
            default: ln_array_free(out);return luaL_error(L,"unknown random distribution");
        }
        for(int j=nd-1;j>=0;j--){if(++ix[j]<dims[j])break;ix[j]=0;}
    }
    if(!has_size&&nd==0){
        if((kind>=16&&kind<=20)||kind==23){lua_Integer one=(lua_Integer)((int64_t*)out->data)[0];
            ln_array_free(out);lua_pushinteger(L,one);return 1;}
        double one=v[0];ln_array_free(out);lua_pushnumber(L,one);return 1;
    }
    return push_array(L,out);
}

static int lua_generator_uniform(lua_State *L)
{
    ln_pcg64 *rng=check_generator(L,1);
    if(lua_gettop(L)>4)return luaL_error(L,"uniform accepts low, high and size");
    if(test_array(L,2)||test_array(L,3)||lua_type(L,2)==LUA_TTABLE||lua_type(L,3)==LUA_TTABLE)
        return lua_generator_broadcast_sample(L,rng,0,4);
    double low=lua_type(L,2)==LUA_TNIL||lua_type(L,2)==LUA_TNONE?0:luaL_checknumber(L,2);
    double high=lua_type(L,3)==LUA_TNIL||lua_type(L,3)==LUA_TNONE?1:luaL_checknumber(L,3);
    if(!isfinite(low)||!isfinite(high)||high<low)return luaL_error(L,"uniform requires finite bounds with high >= low");
    double span=high-low;
    if(!isfinite(span))return luaL_error(L,"uniform range must be finite");
    ln_intp dims[LN_MAXDIMS];int nd,has_size;
    if(lua_random_shape(L,4,dims,&nd,&has_size))return 0;
    if(!has_size){lua_pushnumber(L,low+span*ln_pcg64_next_double(rng));return 1;}
    ln_error e={{0}};
    ln_array *out=ln_array_new(nd,dims,ln_dtype_by_num(LN_DOUBLE),0,0,&e);
    if(!out)return fail(L,&e);
    ln_intp n=ln_array_size(out);
    double *p=(double *)out->data;
    for(ln_intp i=0;i<n;i++)p[i]=low+span*ln_pcg64_next_double(rng);
    return push_array(L,out);
}

/* NumPy Generator.standard_normal(size=nil, dtype="float64", out=nil).
 * Native separate float32/float64 Ziggurat paths. A provided contiguous
 * Fortran-order output is filled in physical order, as NumPy's fill API does;
 * no temporary C-order array or transposition is performed. */
static int lua_generator_standard_normal(lua_State *L)
{
    ln_pcg64 *rng=check_generator(L,1);
    if(lua_gettop(L)>4)return luaL_error(L,"standard_normal accepts size, dtype and out");
    const char *name=(lua_type(L,3)==LUA_TNIL||lua_type(L,3)==LUA_TNONE)?"float64":luaL_checklstring(L,3,NULL);
    int is32=strcmp(name,"float32")==0;
    if(!is32&&strcmp(name,"float64")!=0)return luaL_error(L,"standard_normal dtype must be float32 or float64");
    lua_array *provided=NULL;
    if(lua_type(L,4)!=LUA_TNONE&&lua_type(L,4)!=LUA_TNIL){
        provided=test_array(L,4);
        if(!provided)return luaL_error(L,"standard_normal out must be an ndarray");
        const ln_array *a=provided->a;
        if(a->descr->type_num!=(is32?LN_FLOAT:LN_DOUBLE))
            return luaL_error(L,"standard_normal out dtype must match dtype");
        if(!(a->flags&LN_ARRAY_WRITEABLE)||!(a->flags&LN_ARRAY_ALIGNED)||
           !(a->flags&(LN_ARRAY_C_CONTIGUOUS|LN_ARRAY_F_CONTIGUOUS)))
            return luaL_error(L,"standard_normal out must be contiguous, writable and aligned");
    }
    ln_intp dims[LN_MAXDIMS];int nd,has_size;
    if(lua_random_shape(L,2,dims,&nd,&has_size))return 0;
    ln_array *out=NULL;ln_error e={{0}};
    if(provided){
        out=provided->a;
        if(has_size){
            if(out->nd!=nd)return luaL_error(L,"standard_normal size must match out.shape");
            for(int i=0;i<nd;i++)if(out->dimensions[i]!=dims[i])
                return luaL_error(L,"standard_normal size must match out.shape");
        }
    }else if(has_size){
        out=ln_array_new(nd,dims,ln_dtype_by_num(is32?LN_FLOAT:LN_DOUBLE),0,0,&e);
        if(!out)return fail(L,&e);
    }else{
        lua_pushnumber(L,is32?(double)ln_pcg64_standard_normal_f(rng):ln_pcg64_standard_normal(rng));
        return 1;
    }
    ln_intp n=ln_array_size(out);
    if(n<0){if(!provided)ln_array_free(out);return luaL_error(L,"sample shape too large");}
    if(is32){float *v=(float *)out->data;for(ln_intp i=0;i<n;i++)v[i]=ln_pcg64_standard_normal_f(rng);}
    else {double *v=(double *)out->data;for(ln_intp i=0;i<n;i++)v[i]=ln_pcg64_standard_normal(rng);}
    if(provided){lua_pushvalue(L,4);return 1;}
    return push_array(L,out);
}

/* Scalar location/scale first. Vectorized broadcasting of parameters is
 * deliberately unsupported until its state-consumption rules are tested. */
static int lua_generator_normal(lua_State *L)
{
    ln_pcg64 *rng=check_generator(L,1);
    if(lua_gettop(L)>4)return luaL_error(L,"normal accepts loc, scale and size");
    if(test_array(L,2)||test_array(L,3)||lua_type(L,2)==LUA_TTABLE||lua_type(L,3)==LUA_TTABLE)
        return lua_generator_broadcast_sample(L,rng,1,4);
    double loc=(lua_type(L,2)==LUA_TNONE||lua_type(L,2)==LUA_TNIL)?0:luaL_checknumber(L,2);
    double scale=(lua_type(L,3)==LUA_TNONE||lua_type(L,3)==LUA_TNIL)?1:luaL_checknumber(L,3);
    if(scale<0)return luaL_error(L,"scale < 0");
    ln_intp dims[LN_MAXDIMS];int nd,has_size;
    if(lua_random_shape(L,4,dims,&nd,&has_size))return 0;
    if(!has_size){lua_pushnumber(L,loc+scale*ln_pcg64_standard_normal(rng));return 1;}
    ln_error e={{0}};
    ln_array *out=ln_array_new(nd,dims,ln_dtype_by_num(LN_DOUBLE),0,0,&e);
    if(!out)return fail(L,&e);
    ln_intp n=ln_array_size(out);
    if(n<0){ln_array_free(out);return luaL_error(L,"sample shape too large");}
    double *v=(double *)out->data;
    for(ln_intp i=0;i<n;i++)v[i]=loc+scale*ln_pcg64_standard_normal(rng);
    return push_array(L,out);
}

/* NumPy Generator.standard_exponential(size=nil,dtype="float64",
 * method="zig",out=nil). Supports both native dtype paths and both methods,
 * with C- or Fortran-contiguous writable, aligned output. Physical memory
 * order is filled, matching NumPy's contiguous array fill semantics. */
static int lua_generator_standard_exponential(lua_State *L)
{
    ln_pcg64 *rng=check_generator(L,1);
    if(lua_gettop(L)>5)return luaL_error(L,"standard_exponential accepts size, dtype, method and out");
    const char *dtype=(lua_type(L,3)==LUA_TNONE||lua_type(L,3)==LUA_TNIL)?"float64":luaL_checklstring(L,3,NULL);
    int is32=strcmp(dtype,"float32")==0;
    if(!is32&&strcmp(dtype,"float64")!=0)return luaL_error(L,"standard_exponential dtype must be float32 or float64");
    const char *method=(lua_type(L,4)==LUA_TNONE||lua_type(L,4)==LUA_TNIL)?"zig":luaL_checklstring(L,4,NULL);
    int inv=strcmp(method,"inv")==0;
    if(!inv&&strcmp(method,"zig")!=0)return luaL_error(L,"standard_exponential method must be zig or inv");
    lua_array *provided=NULL;
    if(lua_type(L,5)!=LUA_TNONE&&lua_type(L,5)!=LUA_TNIL){
        provided=test_array(L,5);
        if(!provided)return luaL_error(L,"standard_exponential out must be an ndarray");
        const ln_array *a=provided->a;
        if(a->descr->type_num!=(is32?LN_FLOAT:LN_DOUBLE))
            return luaL_error(L,"standard_exponential out dtype must match dtype");
        if(!(a->flags&LN_ARRAY_WRITEABLE)||!(a->flags&LN_ARRAY_ALIGNED)||
           !(a->flags&(LN_ARRAY_C_CONTIGUOUS|LN_ARRAY_F_CONTIGUOUS)))
            return luaL_error(L,"standard_exponential out must be contiguous, writable and aligned");
    }
    ln_intp dims[LN_MAXDIMS];int nd,has_size;
    if(lua_random_shape(L,2,dims,&nd,&has_size))return 0;
    ln_array *out=NULL;ln_error e={{0}};
    if(provided){
        out=provided->a;
        if(has_size){
            if(out->nd!=nd)return luaL_error(L,"standard_exponential size must match out.shape");
            for(int i=0;i<nd;i++)if(out->dimensions[i]!=dims[i])
                return luaL_error(L,"standard_exponential size must match out.shape");
        }
    }else if(has_size){
        out=ln_array_new(nd,dims,ln_dtype_by_num(is32?LN_FLOAT:LN_DOUBLE),0,0,&e);
        if(!out)return fail(L,&e);
    }else{
        double v=is32?(double)(inv?ln_pcg64_standard_exponential_inv_f(rng):ln_pcg64_standard_exponential_f(rng)):
                 (inv?ln_pcg64_standard_exponential_inv(rng):ln_pcg64_standard_exponential(rng));
        lua_pushnumber(L,v);return 1;
    }
    ln_intp n=ln_array_size(out);
    if(n<0){if(!provided)ln_array_free(out);return luaL_error(L,"sample shape too large");}
    if(is32){float *v=(float *)out->data;for(ln_intp i=0;i<n;i++)v[i]=inv?ln_pcg64_standard_exponential_inv_f(rng):ln_pcg64_standard_exponential_f(rng);}
    else {double *v=(double *)out->data;for(ln_intp i=0;i<n;i++)v[i]=inv?ln_pcg64_standard_exponential_inv(rng):ln_pcg64_standard_exponential(rng);}
    if(provided){lua_pushvalue(L,5);return 1;}
    return push_array(L,out);
}

/* Scalar scale in 0.54; an ndarray scale needs a separate broadcasting path. */
static int lua_generator_exponential(lua_State *L)
{
    ln_pcg64 *rng=check_generator(L,1);
    if(lua_gettop(L)>3)return luaL_error(L,"exponential accepts scale and size");
    if(test_array(L,2)||lua_type(L,2)==LUA_TTABLE)
        return lua_generator_broadcast_sample(L,rng,2,3);
    double scale=(lua_type(L,2)==LUA_TNONE||lua_type(L,2)==LUA_TNIL)?1.0:luaL_checknumber(L,2);
    if(isnan(scale)||scale<0)return luaL_error(L,"scale < 0 or NaN");
    ln_intp dims[LN_MAXDIMS];int nd,has_size;
    if(lua_random_shape(L,3,dims,&nd,&has_size))return 0;
    if(!has_size){lua_pushnumber(L,scale*ln_pcg64_standard_exponential(rng));return 1;}
    ln_error e={{0}};
    ln_array *out=ln_array_new(nd,dims,ln_dtype_by_num(LN_DOUBLE),0,0,&e);
    if(!out)return fail(L,&e);
    ln_intp n=ln_array_size(out);
    if(n<0){ln_array_free(out);return luaL_error(L,"sample shape too large");}
    double *v=(double *)out->data;
    for(ln_intp i=0;i<n;i++)v[i]=scale*ln_pcg64_standard_exponential(rng);
    return push_array(L,out);
}

/* Scalar-parameter distributions; future broadcasting support needs a
 * separate verified path. All three use float64 like NumPy Generator. */
static double generator_one_lognormal(ln_pcg64 *rng, double mean, double sigma)
{ return ln_pcg64_lognormal(rng,mean,sigma); }
static double generator_one_laplace(ln_pcg64 *rng, double loc, double scale)
{ return ln_pcg64_laplace(rng,loc,scale); }

static int lua_generator_two_params(lua_State *L, const char *label,
                                    double (*sample)(ln_pcg64 *,double,double),
                                    double d1,double d2)
{
    ln_pcg64 *rng=check_generator(L,1);
    if(lua_gettop(L)>4)return luaL_error(L,"%s accepts two parameters and size",label);
    if(test_array(L,2)||test_array(L,3)||lua_type(L,2)==LUA_TTABLE||lua_type(L,3)==LUA_TTABLE){
        int kind=strcmp(label,"lognormal")==0?3:strcmp(label,"laplace")==0?4:
                 strcmp(label,"gumbel")==0?5:6;
        return lua_generator_broadcast_sample(L,rng,kind,4);
    }
    double a=(lua_type(L,2)==LUA_TNONE||lua_type(L,2)==LUA_TNIL)?d1:luaL_checknumber(L,2);
    double b=(lua_type(L,3)==LUA_TNONE||lua_type(L,3)==LUA_TNIL)?d2:luaL_checknumber(L,3);
    if(isnan(b)||b<0.0)return luaL_error(L,"%s scale must be nonnegative and not NaN",label);
    ln_intp dims[LN_MAXDIMS];int nd,has_size;
    if(lua_random_shape(L,4,dims,&nd,&has_size))return 0;
    if(!has_size){lua_pushnumber(L,sample(rng,a,b));return 1;}
    ln_error e={{0}};
    ln_array *out=ln_array_new(nd,dims,ln_dtype_by_num(LN_DOUBLE),0,0,&e);
    if(!out)return fail(L,&e);
    ln_intp n=ln_array_size(out);
    if(n<0){ln_array_free(out);return luaL_error(L,"sample shape too large");}
    double *v=(double *)out->data;
    for(ln_intp i=0;i<n;i++)v[i]=sample(rng,a,b);
    return push_array(L,out);
}
static int lua_generator_lognormal(lua_State *L)
{ return lua_generator_two_params(L,"lognormal",generator_one_lognormal,0.0,1.0); }
static int lua_generator_laplace(lua_State *L)
{ return lua_generator_two_params(L,"laplace",generator_one_laplace,0.0,1.0); }
static double generator_one_gumbel(ln_pcg64 *rng, double loc, double scale)
{ return ln_pcg64_gumbel(rng,loc,scale); }
static double generator_one_logistic(ln_pcg64 *rng, double loc, double scale)
{ return ln_pcg64_logistic(rng,loc,scale); }
static int lua_generator_gumbel(lua_State *L)
{ return lua_generator_two_params(L,"gumbel",generator_one_gumbel,0.0,1.0); }
static int lua_generator_logistic(lua_State *L)
{ return lua_generator_two_params(L,"logistic",generator_one_logistic,0.0,1.0); }

/* Rayleigh and Weibull accept NaN parameters, consistent with NumPy.
 * Negative parameters, including -inf, are rejected before consuming bits. */
static int lua_generator_one_param(lua_State *L,const char *label,
                                   double (*sample)(ln_pcg64 *,double),
                                   double dflt)
{
    ln_pcg64 *rng=check_generator(L,1);
    if(lua_gettop(L)>3)return luaL_error(L,"%s accepts parameter and size",label);
    if(test_array(L,2)||lua_type(L,2)==LUA_TTABLE)
        return lua_generator_broadcast_sample(L,rng,strcmp(label,"rayleigh")==0?7:8,3);
    double a=(lua_type(L,2)==LUA_TNONE||lua_type(L,2)==LUA_TNIL)?dflt:luaL_checknumber(L,2);
    if(a<0.0)return luaL_error(L,"%s parameter must be nonnegative",label);
    ln_intp dims[LN_MAXDIMS];int nd,has_size;
    if(lua_random_shape(L,3,dims,&nd,&has_size))return 0;
    if(!has_size){lua_pushnumber(L,sample(rng,a));return 1;}
    ln_error e={{0}};
    ln_array *out=ln_array_new(nd,dims,ln_dtype_by_num(LN_DOUBLE),0,0,&e);
    if(!out)return fail(L,&e);
    ln_intp n=ln_array_size(out);
    if(n<0){ln_array_free(out);return luaL_error(L,"sample shape too large");}
    double *v=(double *)out->data;
    for(ln_intp i=0;i<n;i++)v[i]=sample(rng,a);
    return push_array(L,out);
}
static int lua_generator_rayleigh(lua_State *L)
{ return lua_generator_one_param(L,"rayleigh",ln_pcg64_rayleigh,1.0); }
static int lua_generator_weibull(lua_State *L)
{ return lua_generator_one_param(L,"weibull",ln_pcg64_weibull,1.0); }

/* Strictly positive scalar shape for Pareto II and power distributions.
 * Validate before obtaining any PCG64 words.  NaN is accepted, like NumPy. */
static int lua_generator_positive_param(lua_State *L, const char *label,
                                         double (*sample)(ln_pcg64 *,double))
{
    ln_pcg64 *rng=check_generator(L,1);
    if(lua_gettop(L)>3)return luaL_error(L,"%s accepts a and size",label);
    if(test_array(L,2)||lua_type(L,2)==LUA_TTABLE)
        return lua_generator_broadcast_sample(L,rng,strcmp(label,"pareto")==0?9:10,3);
    double a=luaL_checknumber(L,2);
    if(a<=0.0)return luaL_error(L,"%s requires a > 0",label);
    ln_intp dims[LN_MAXDIMS];int nd,has_size;
    if(lua_random_shape(L,3,dims,&nd,&has_size))return 0;
    if(!has_size){lua_pushnumber(L,sample(rng,a));return 1;}
    ln_error e={{0}};
    ln_array *out=ln_array_new(nd,dims,ln_dtype_by_num(LN_DOUBLE),0,0,&e);
    if(!out)return fail(L,&e);
    ln_intp n=ln_array_size(out);
    if(n<0){ln_array_free(out);return luaL_error(L,"sample shape too large");}
    double *v=(double *)out->data;
    for(ln_intp i=0;i<n;i++)v[i]=sample(rng,a);
    return push_array(L,out);
}
static int lua_generator_pareto(lua_State *L)
{ return lua_generator_positive_param(L,"pareto",ln_pcg64_pareto); }
static int lua_generator_power(lua_State *L)
{ return lua_generator_positive_param(L,"power",ln_pcg64_power); }

static int lua_generator_triangular_broadcast(lua_State *L,ln_pcg64 *rng);

/* Generator.triangular(left,mode,right,size=nil).  Parameter validation is
 * performed before drawing.  There are no default triangle endpoints. */
static int lua_generator_triangular(lua_State *L)
{
    ln_pcg64 *rng=check_generator(L,1);
    if(lua_gettop(L)>5)return luaL_error(L,"triangular accepts left, mode, right and size");
    if(test_array(L,2)||test_array(L,3)||test_array(L,4)||
       lua_type(L,2)==LUA_TTABLE||lua_type(L,3)==LUA_TTABLE||
       lua_type(L,4)==LUA_TTABLE){
        if(lua_type(L,2)==LUA_TNONE||lua_type(L,2)==LUA_TNIL||
           lua_type(L,3)==LUA_TNONE||lua_type(L,3)==LUA_TNIL||
           lua_type(L,4)==LUA_TNONE||lua_type(L,4)==LUA_TNIL)
            return luaL_error(L,"triangular requires left, mode and right");
        return lua_generator_triangular_broadcast(L,rng);
    }
    double left=luaL_checknumber(L,2);
    double mode=luaL_checknumber(L,3);
    double right=luaL_checknumber(L,4);
    if(left>mode)return luaL_error(L,"left > mode");
    if(mode>right)return luaL_error(L,"mode > right");
    if(left==right)return luaL_error(L,"left == right");
    ln_intp dims[LN_MAXDIMS];int nd,has_size;
    if(lua_random_shape(L,5,dims,&nd,&has_size))return 0;
    if(!has_size){lua_pushnumber(L,ln_pcg64_triangular(rng,left,mode,right));return 1;}
    ln_error e={{0}};
    ln_array *out=ln_array_new(nd,dims,ln_dtype_by_num(LN_DOUBLE),0,0,&e);
    if(!out)return fail(L,&e);
    ln_intp n=ln_array_size(out);
    if(n<0){ln_array_free(out);return luaL_error(L,"sample shape too large");}
    double *v=(double *)out->data;
    for(ln_intp i=0;i<n;i++)v[i]=ln_pcg64_triangular(rng,left,mode,right);
    return push_array(L,out);
}

/* NumPy Generator.standard_gamma(shape, size=nil, dtype="float64", out=nil).
 * Both dtype paths preserve NumPy's separate float64 and float32 bit streams.
 * The original C rejection sampler handles NaN and +Inf shapes; do not
 * short-circuit those values or the subsequent PCG64 state would differ.
 * Reject negative (including -Inf) parameters, even for empty outputs.
 * Validate output buffer, broadcast and all shape elements BEFORE drawing.
 */
static int lua_generator_standard_gamma(lua_State *L)
{
    ln_pcg64 *rng=check_generator(L,1);
    if(lua_gettop(L)>5)return luaL_error(L,"standard_gamma accepts shape, size, dtype and out");
    const char *type=((lua_type(L,4)==LUA_TNONE||lua_type(L,4)==LUA_TNIL))?
        "float64":luaL_checklstring(L,4,NULL);
    const int f32=strcmp(type,"float32")==0;
    if(!f32&&strcmp(type,"float64")!=0)
        return luaL_error(L,"standard_gamma dtype must be float32 or float64");
    lua_array *provided=NULL;
    if(lua_type(L,5)!=LUA_TNONE&&lua_type(L,5)!=LUA_TNIL){
        provided=test_array(L,5);
        if(!provided)return luaL_error(L,"standard_gamma out must be an ndarray");
        const ln_array *ar=provided->a;
        if(ar->descr->type_num!=(f32?LN_FLOAT:LN_DOUBLE))
            return luaL_error(L,"standard_gamma out dtype must match dtype");
        if(!(ar->flags&LN_ARRAY_WRITEABLE)||!(ar->flags&LN_ARRAY_C_CONTIGUOUS))
            return luaL_error(L,"standard_gamma out must be writable and C-contiguous");
    }
    ln_intp dims[LN_MAXDIMS]={0};int nd=0,has_size=0;
    if(lua_random_shape(L,3,dims,&nd,&has_size))return 0;
    if(provided){
        const ln_array *ar=provided->a;
        if(has_size){
            if(ar->nd!=nd)return luaL_error(L,"standard_gamma size must match out.shape");
            for(int j=0;j<nd;j++)if(ar->dimensions[j]!=dims[j])
                return luaL_error(L,"standard_gamma size must match out.shape");
        }else{
            nd=ar->nd;
            for(int j=0;j<nd;j++)dims[j]=ar->dimensions[j];
        }
        has_size=1;
    }
    lua_random_bparam p={NULL,0.0};
    const int vector=test_array(L,2)||lua_type(L,2)==LUA_TTABLE;
    if(vector){
        p=lua_random_param(L,2,0.0);
        lua_random_bparam none={NULL,0.0};
        if(lua_random_broadcast_dims(L,&p,&none,has_size,dims,&nd))return 0;
        /* Validate the entire parameter independently of the sampled size:
         * e.g. {1,-1} with size={0,2} must still raise without drawing. */
        ln_intp pdims[LN_MAXDIMS]={0};int pnd=0;
        if(lua_random_broadcast_dims(L,&p,&none,0,pdims,&pnd))return 0;
        size_t count=1;
        for(int j=0;j<pnd;j++){
            if(pdims[j]==0){count=0;break;}
            if((size_t)pdims[j]>SIZE_MAX/count)
                return luaL_error(L,"standard_gamma shape too large");
            count*=(size_t)pdims[j];
        }
        ln_intp ix[LN_MAXDIMS]={0};
        for(size_t i=0;i<count;i++){
            double shape=lua_random_bget(L,&p,pnd,ix);
            if(shape<0.0)return luaL_error(L,"standard_gamma shape must be nonnegative");
            for(int j=pnd-1;j>=0;j--){if(++ix[j]<pdims[j])break;ix[j]=0;}
        }
    }else{
        p.scalar=luaL_checknumber(L,2);
        if(p.scalar<0.0)return luaL_error(L,"standard_gamma shape must be nonnegative");
    }
    if(!has_size&&nd==0&&!vector){
        lua_pushnumber(L,f32?(double)ln_pcg64_standard_gamma_f(rng,(float)p.scalar):
                        ln_pcg64_standard_gamma(rng,p.scalar));
        return 1;
    }
    ln_array *out=provided?provided->a:NULL;
    ln_error e={{0}};
    if(!out){
        out=ln_array_new(nd,dims,ln_dtype_by_num(f32?LN_FLOAT:LN_DOUBLE),0,0,&e);
        if(!out)return fail(L,&e);
    }
    ln_intp n=ln_array_size(out);
    if(n<0){if(!provided)ln_array_free(out);return luaL_error(L,"standard_gamma sample shape too large");}
    ln_intp ix[LN_MAXDIMS]={0};
    for(ln_intp i=0;i<n;i++){
        double shape=vector?lua_random_bget(L,&p,nd,ix):p.scalar;
        if(f32)((float*)out->data)[i]=ln_pcg64_standard_gamma_f(rng,(float)shape);
        else ((double*)out->data)[i]=ln_pcg64_standard_gamma(rng,shape);
        for(int j=nd-1;j>=0;j--){if(++ix[j]<dims[j])break;ix[j]=0;}
    }
    if(provided){lua_pushvalue(L,5);return 1;}
    if(!has_size&&nd==0){
        double value=f32?(double)((float*)out->data)[0]:((double*)out->data)[0];
        ln_array_free(out);lua_pushnumber(L,value);return 1;
    }
    return push_array(L,out);
}

static double generator_one_gamma(ln_pcg64*rng,double shape,double scale)
{ return ln_pcg64_gamma(rng,shape,scale); }
static double generator_one_beta(ln_pcg64*rng,double a,double b)
{ return ln_pcg64_beta(rng,a,b); }
static int lua_generator_gamma_beta(lua_State *L,const char *label,int beta)
{
    ln_pcg64 *rng=check_generator(L,1);
    if(lua_gettop(L)>4)return luaL_error(L,"%s accepts two parameters and size",label);
    if(test_array(L,2)||test_array(L,3)||lua_type(L,2)==LUA_TTABLE||lua_type(L,3)==LUA_TTABLE)
        return lua_generator_broadcast_sample(L,rng,beta?12:11,4);
    double a=luaL_checknumber(L,2);
    double b=beta?luaL_checknumber(L,3):((lua_type(L,3)==LUA_TNONE||lua_type(L,3)==LUA_TNIL)?1.0:luaL_checknumber(L,3));
    if(!isfinite(a)||a<0.0||(beta&&a==0.0)||!isfinite(b)||b<0.0||(beta&&b==0.0))
        return luaL_error(L,"%s parameters outside valid domain",label);
    ln_intp dims[LN_MAXDIMS];int nd,has_size;
    if(lua_random_shape(L,4,dims,&nd,&has_size))return 0;
    double (*draw)(ln_pcg64*,double,double)=beta?generator_one_beta:generator_one_gamma;
    if(!has_size){lua_pushnumber(L,draw(rng,a,b));return 1;}
    ln_error e={{0}};
    ln_array *out=ln_array_new(nd,dims,ln_dtype_by_num(LN_DOUBLE),0,0,&e);
    if(!out)return fail(L,&e);
    ln_intp n=ln_array_size(out);
    if(n<0){ln_array_free(out);return luaL_error(L,"sample shape too large");}
    double *v=(double*)out->data;
    for(ln_intp i=0;i<n;i++)v[i]=draw(rng,a,b);
    return push_array(L,out);
}
static int lua_generator_gamma(lua_State *L){return lua_generator_gamma_beta(L,"gamma",0);}
static int lua_generator_beta(lua_State *L){return lua_generator_gamma_beta(L,"beta",1);}

/* Chi-square and Fisher-Snedecor F, with scalar positive parameters.
 * Size follows the same scalar / table convention as Gamma and Beta. */
static int lua_generator_chisquare(lua_State *L)
{
    ln_pcg64 *rng=check_generator(L,1);
    if(lua_gettop(L)>3)return luaL_error(L,"chisquare accepts df and size");
    if(test_array(L,2)||lua_type(L,2)==LUA_TTABLE)
        return lua_generator_broadcast_sample(L,rng,13,3);
    double df=luaL_checknumber(L,2);
    if(!isfinite(df)||df<=0.0)return luaL_error(L,"df must be finite and positive");
    ln_intp dims[LN_MAXDIMS];int nd,has_size;
    if(lua_random_shape(L,3,dims,&nd,&has_size))return 0;
    if(!has_size){lua_pushnumber(L,ln_pcg64_chisquare(rng,df));return 1;}
    ln_error e={{0}};
    ln_array *out=ln_array_new(nd,dims,ln_dtype_by_num(LN_DOUBLE),0,0,&e);
    if(!out)return fail(L,&e);
    ln_intp n=ln_array_size(out);
    if(n<0){ln_array_free(out);return luaL_error(L,"sample shape too large");}
    double *v=(double*)out->data;
    for(ln_intp i=0;i<n;i++)v[i]=ln_pcg64_chisquare(rng,df);
    return push_array(L,out);
}

static int lua_generator_f(lua_State *L)
{
    ln_pcg64 *rng=check_generator(L,1);
    if(lua_gettop(L)>4)return luaL_error(L,"f accepts dfnum, dfden and size");
    if(test_array(L,2)||test_array(L,3)||lua_type(L,2)==LUA_TTABLE||lua_type(L,3)==LUA_TTABLE)
        return lua_generator_broadcast_sample(L,rng,14,4);
    double dfnum=luaL_checknumber(L,2);
    double dfden=luaL_checknumber(L,3);
    if(!isfinite(dfnum)||dfnum<=0.0||!isfinite(dfden)||dfden<=0.0)
        return luaL_error(L,"F degrees of freedom must be finite and positive");
    ln_intp dims[LN_MAXDIMS];int nd,has_size;
    if(lua_random_shape(L,4,dims,&nd,&has_size))return 0;
    if(!has_size){lua_pushnumber(L,ln_pcg64_f(rng,dfnum,dfden));return 1;}
    ln_error e={{0}};
    ln_array *out=ln_array_new(nd,dims,ln_dtype_by_num(LN_DOUBLE),0,0,&e);
    if(!out)return fail(L,&e);
    ln_intp n=ln_array_size(out);
    if(n<0){ln_array_free(out);return luaL_error(L,"sample shape too large");}
    double *v=(double*)out->data;
    for(ln_intp i=0;i<n;i++)v[i]=ln_pcg64_f(rng,dfnum,dfden);
    return push_array(L,out);
}

/* Noncentral broadcast sampler: uses the same native rejection algorithms as
 * scalar draws. The ternary F family needs a third independently broadcast
 * parameter, unlike the existing two-parameter families. */
static int lua_random_broadcast_three(lua_State *L,
                                       const lua_random_bparam *a,
                                       const lua_random_bparam *b,
                                       const lua_random_bparam *c,
                                       int has_size,ln_intp *dims,int *nd)
{
    const ln_array *arrays[3]={a->array,b->array,c->array};
    int max_nd=*nd;
    if(!has_size){
        for(int k=0;k<3;k++)if(arrays[k]&&arrays[k]->nd>max_nd)
            max_nd=arrays[k]->nd;
        if(max_nd>LN_MAXDIMS)return luaL_error(L,"noncentral broadcast dimension limit");
        for(int j=0;j<max_nd;j++)dims[j]=1;
    }
    for(int k=0;k<3;k++){
        const ln_array *ar=arrays[k];
        if(!ar)continue;
        if(ar->nd>max_nd)return luaL_error(L,"noncentral size is incompatible with parameters");
        for(int j=0;j<ar->nd;j++){
            const int dst=max_nd-ar->nd+j;
            const ln_intp d=ar->dimensions[j],old=dims[dst];
            if(has_size){
                if(d!=1&&d!=old)return luaL_error(L,"noncentral size is incompatible with parameters");
            }else if(old==1)dims[dst]=d;
            else if(d!=1&&d!=old)return luaL_error(L,"noncentral parameter shapes cannot broadcast");
        }
    }
    *nd=max_nd;
    return 0;
}
/* Three-parameter Generator.triangular, with the three-way shape helper
 * shared by the noncentral distributions. Validate all parameter elements
 * before drawing, including when an explicitly requested output is empty. */
static int lua_generator_triangular_broadcast(lua_State *L,ln_pcg64 *rng)
{
    ln_intp dims[LN_MAXDIMS]={0};int nd=0,has_size=0;
    if(lua_random_shape(L,5,dims,&nd,&has_size))return 0;
    lua_random_bparam a=lua_random_param(L,2,0.0);
    lua_random_bparam b=lua_random_param(L,3,0.0);
    lua_random_bparam c=lua_random_param(L,4,0.0);
    if(lua_random_broadcast_three(L,&a,&b,&c,has_size,dims,&nd))return 0;
    ln_intp vdims[LN_MAXDIMS]={0};int vnd=0;
    if(lua_random_broadcast_three(L,&a,&b,&c,0,vdims,&vnd))return 0;
    size_t validation_count=1;
    for(int j=0;j<vnd;j++){
        if(vdims[j]==0){validation_count=0;break;}
        if((size_t)vdims[j]>SIZE_MAX/validation_count)
            return luaL_error(L,"triangular parameter validation size too large");
        validation_count*=(size_t)vdims[j];
    }
    ln_intp ix[LN_MAXDIMS]={0};
    for(size_t i=0;i<validation_count;i++){
        double left=lua_random_bget(L,&a,vnd,ix);
        double mode=lua_random_bget(L,&b,vnd,ix);
        double right=lua_random_bget(L,&c,vnd,ix);
        /* Match scalar comparisons: NaN is allowed and propagates. */
        if(left>mode||mode>right||left==right)
            return luaL_error(L,"invalid triangular parameter");
        for(int j=vnd-1;j>=0;j--){if(++ix[j]<vdims[j])break;ix[j]=0;}
    }
    ln_error e={{0}};
    ln_array *out=ln_array_new(nd,dims,ln_dtype_by_num(LN_DOUBLE),0,0,&e);
    if(!out)return fail(L,&e);
    ln_intp n=ln_array_size(out);
    if(n<0){ln_array_free(out);return luaL_error(L,"triangular sample shape too large");}
    memset(ix,0,sizeof(ix));
    double *v=(double*)out->data;
    for(ln_intp i=0;i<n;i++){
        double left=lua_random_bget(L,&a,nd,ix);
        double mode=lua_random_bget(L,&b,nd,ix);
        double right=lua_random_bget(L,&c,nd,ix);
        v[i]=ln_pcg64_triangular(rng,left,mode,right);
        for(int j=nd-1;j>=0;j--){if(++ix[j]<dims[j])break;ix[j]=0;}
    }
    if(!has_size&&nd==0){double value=v[0];ln_array_free(out);lua_pushnumber(L,value);return 1;}
    return push_array(L,out);
}

static int lua_generator_noncentral_broadcast(lua_State *L,ln_pcg64 *rng,int fisher)
{
    const int size_arg=fisher?5:4;
    ln_intp dims[LN_MAXDIMS]={0};int nd=0,has_size=0;
    if(lua_random_shape(L,size_arg,dims,&nd,&has_size))return 0;
    lua_random_bparam a=lua_random_param(L,2,0.0);
    lua_random_bparam b=lua_random_param(L,3,0.0);
    lua_random_bparam c=fisher?lua_random_param(L,4,0.0):(lua_random_bparam){NULL,0.0};
    if(lua_random_broadcast_three(L,&a,&b,&c,has_size,dims,&nd))return 0;
    /* Validate the entire broadcast parameter space before consuming PCG64,
     * including the case of a requested zero-element output. */
    ln_intp vdims[LN_MAXDIMS]={0};int vnd=0;
    if(lua_random_broadcast_three(L,&a,&b,&c,0,vdims,&vnd))return 0;
    size_t validation_count=1;
    for(int j=0;j<vnd;j++){
        if(vdims[j]==0){validation_count=0;break;}
        if((size_t)vdims[j]>SIZE_MAX/validation_count)
            return luaL_error(L,"noncentral parameter validation size too large");
        validation_count*=(size_t)vdims[j];
    }
    ln_intp ix[LN_MAXDIMS]={0};
    for(size_t i=0;i<validation_count;i++){
        double df1=lua_random_bget(L,&a,vnd,ix);
        double df2=fisher?lua_random_bget(L,&b,vnd,ix):0;
        double nonc=lua_random_bget(L,fisher?&c:&b,vnd,ix);
        if(!isfinite(df1)||df1<=0.0||(fisher&&(!isfinite(df2)||df2<=0.0)))
            return luaL_error(L,"noncentral degrees of freedom must be finite and positive");
        if(!isfinite(nonc)||nonc<0.0||nonc>1.0e12)
            return luaL_error(L,"noncentrality must be finite and between 0 and 1e12");
        for(int j=vnd-1;j>=0;j--){if(++ix[j]<vdims[j])break;ix[j]=0;}
    }
    ln_error e={{0}};
    ln_array *out=ln_array_new(nd,dims,ln_dtype_by_num(LN_DOUBLE),0,0,&e);
    if(!out)return fail(L,&e);
    ln_intp n=ln_array_size(out);
    if(n<0){ln_array_free(out);return luaL_error(L,"noncentral sample shape too large");}
    memset(ix,0,sizeof(ix));
    double *v=(double*)out->data;
    for(ln_intp i=0;i<n;i++){
        double df1=lua_random_bget(L,&a,nd,ix);
        double df2=fisher?lua_random_bget(L,&b,nd,ix):0;
        double nonc=lua_random_bget(L,fisher?&c:&b,nd,ix);
        v[i]=fisher?ln_pcg64_noncentral_f(rng,df1,df2,nonc):
                    ln_pcg64_noncentral_chisquare(rng,df1,nonc);
        for(int j=nd-1;j>=0;j--){if(++ix[j]<dims[j])break;ix[j]=0;}
    }
    if(!has_size&&nd==0){double value=v[0];ln_array_free(out);lua_pushnumber(L,value);return 1;}
    return push_array(L,out);
}

/* Scalar noncentral distributions.  The intensity cap avoids undefined
 * signed conversion in the underlying Poisson rejection algorithm. */
static int lua_generator_noncentral(lua_State *L,int fisher)
{
    ln_pcg64 *rng=check_generator(L,1);
    if(lua_gettop(L)>(fisher?5:4))
        return luaL_error(L,fisher?"noncentral_f accepts dfnum, dfden, nonc, size":"noncentral_chisquare accepts df, nonc, size");
    if(test_array(L,2)||test_array(L,3)||
       (fisher&&test_array(L,4))||lua_type(L,2)==LUA_TTABLE||
       lua_type(L,3)==LUA_TTABLE||(fisher&&lua_type(L,4)==LUA_TTABLE))
        return lua_generator_noncentral_broadcast(L,rng,fisher);
    double df1=luaL_checknumber(L,2);
    double df2=fisher?luaL_checknumber(L,3):0.0;
    double nonc=luaL_checknumber(L,fisher?4:3);
    /* Conservative documented domain: positive finite df, nonnegative
     * finite noncentrality, avoiding Poisson integer overflow for huge lam. */
    if(!isfinite(df1)||df1<=0.0||(fisher&&(!isfinite(df2)||df2<=0.0)))
        return luaL_error(L,"degrees of freedom must be finite and positive");
    if(!isfinite(nonc)||nonc<0.0||nonc>1.0e12)
        return luaL_error(L,"noncentrality must be finite and between 0 and 1e12");
    ln_intp dims[LN_MAXDIMS];int nd,has_size;
    if(lua_random_shape(L,fisher?5:4,dims,&nd,&has_size))return 0;
    if(!has_size){
        lua_pushnumber(L,fisher?ln_pcg64_noncentral_f(rng,df1,df2,nonc):ln_pcg64_noncentral_chisquare(rng,df1,nonc));
        return 1;
    }
    ln_error e={{0}};
    ln_array *out=ln_array_new(nd,dims,ln_dtype_by_num(LN_DOUBLE),0,0,&e);
    if(!out)return fail(L,&e);
    ln_intp n=ln_array_size(out);
    if(n<0){ln_array_free(out);return luaL_error(L,"sample shape too large");}
    double *v=(double *)out->data;
    for(ln_intp i=0;i<n;i++)
        v[i]=fisher?ln_pcg64_noncentral_f(rng,df1,df2,nonc):ln_pcg64_noncentral_chisquare(rng,df1,nonc);
    return push_array(L,out);
}
static int lua_generator_noncentral_chisquare(lua_State *L)
{return lua_generator_noncentral(L,0);}
static int lua_generator_noncentral_f(lua_State *L)
{return lua_generator_noncentral(L,1);}

/* NumPy Generator.standard_t(df, size): scalar positive degrees of freedom. */
static int lua_generator_standard_t(lua_State *L)
{
    ln_pcg64 *rng=check_generator(L,1);
    if(lua_gettop(L)>3)return luaL_error(L,"standard_t accepts df and size");
    if(test_array(L,2)||lua_type(L,2)==LUA_TTABLE)
        return lua_generator_broadcast_sample(L,rng,21,3);
    double df=luaL_checknumber(L,2);
    if(df<=0.0)return luaL_error(L,"standard_t df must be positive");
    ln_intp dims[LN_MAXDIMS];int nd,has_size;
    if(lua_random_shape(L,3,dims,&nd,&has_size))return 0;
    if(!has_size){lua_pushnumber(L,ln_pcg64_standard_t(rng,df));return 1;}
    ln_error e={{0}};
    ln_array *out=ln_array_new(nd,dims,ln_dtype_by_num(LN_DOUBLE),0,0,&e);
    if(!out)return fail(L,&e);
    ln_intp count=ln_array_size(out);
    if(count<0){ln_array_free(out);return luaL_error(L,"standard_t sample shape too large");}
    double *v=(double *)out->data;
    for(ln_intp i=0;i<count;i++)v[i]=ln_pcg64_standard_t(rng,df);
    return push_array(L,out);
}

/* NumPy Generator.vonmises(mu, kappa, size): circular distribution.
 * Large kappa uses NumPy's wrapped normal fallback. */
static int lua_generator_vonmises(lua_State *L)
{
    ln_pcg64 *rng=check_generator(L,1);
    if(lua_gettop(L)>4)return luaL_error(L,"vonmises accepts mu, kappa and size");
    if(test_array(L,2)||test_array(L,3)||
       lua_type(L,2)==LUA_TTABLE||lua_type(L,3)==LUA_TTABLE){
        if(lua_type(L,2)==LUA_TNONE||lua_type(L,2)==LUA_TNIL||
           lua_type(L,3)==LUA_TNONE||lua_type(L,3)==LUA_TNIL)
            return luaL_error(L,"vonmises requires mu and kappa");
        return lua_generator_broadcast_sample(L,rng,22,4);
    }
    double mu=luaL_checknumber(L,2), kappa=luaL_checknumber(L,3);
    if(kappa<0.0)
        return luaL_error(L,"vonmises kappa must be nonnegative");
    ln_intp dims[LN_MAXDIMS];int nd,has_size;
    if(lua_random_shape(L,4,dims,&nd,&has_size))return 0;
    if(!has_size){lua_pushnumber(L,ln_pcg64_vonmises(rng,mu,kappa));return 1;}
    ln_error e={{0}};
    ln_array *out=ln_array_new(nd,dims,ln_dtype_by_num(LN_DOUBLE),0,0,&e);
    if(!out)return fail(L,&e);
    ln_intp count=ln_array_size(out);
    if(count<0){ln_array_free(out);return luaL_error(L,"vonmises sample shape too large");}
    double *v=(double *)out->data;
    for(ln_intp i=0;i<count;i++)v[i]=ln_pcg64_vonmises(rng,mu,kappa);
    return push_array(L,out);
}

/* Generator.wald supports broadcasted mean/scale with existing scalar PCG64 path. */
static int lua_generator_wald(lua_State *L)
{
    ln_pcg64 *rng=check_generator(L,1);
    if(lua_gettop(L)>4)return luaL_error(L,"wald accepts mean, scale and size");
    if(test_array(L,2)||test_array(L,3)||lua_type(L,2)==LUA_TTABLE||lua_type(L,3)==LUA_TTABLE){
        if(lua_type(L,2)==LUA_TNONE||lua_type(L,2)==LUA_TNIL||
           lua_type(L,3)==LUA_TNONE||lua_type(L,3)==LUA_TNIL)
            return luaL_error(L,"wald requires mean and scale");
        return lua_generator_broadcast_sample(L,rng,15,4);
    }
    double mean=luaL_checknumber(L,2), scale=luaL_checknumber(L,3);
    if(isnan(mean)||mean<=0.0||isnan(scale)||scale<=0.0)
        return luaL_error(L,"wald mean and scale must be positive and not NaN");
    ln_intp dims[LN_MAXDIMS];int nd,has_size;
    if(lua_random_shape(L,4,dims,&nd,&has_size))return 0;
    if(!has_size){lua_pushnumber(L,ln_pcg64_wald(rng,mean,scale));return 1;}
    ln_error e={{0}};
    ln_array *out=ln_array_new(nd,dims,ln_dtype_by_num(LN_DOUBLE),0,0,&e);
    if(!out)return fail(L,&e);
    ln_intp count=ln_array_size(out);
    if(count<0){ln_array_free(out);return luaL_error(L,"wald sample shape too large");}
    double *v=(double*)out->data;
    for(ln_intp i=0;i<count;i++)v[i]=ln_pcg64_wald(rng,mean,scale);
    return push_array(L,out);
}

/* NumPy Generator.logseries(p, size): p in [0,1), native int64. */
static int lua_generator_logseries(lua_State *L)
{
    ln_pcg64 *rng=check_generator(L,1);
    if(lua_gettop(L)>3)return luaL_error(L,"logseries accepts p and size");
    if(test_array(L,2)||lua_type(L,2)==LUA_TTABLE)
        return lua_generator_broadcast_sample(L,rng,16,3);
    double p=luaL_checknumber(L,2);
    if(isnan(p)||p<0.0||p>=1.0)
        return luaL_error(L,"logseries p must be in [0,1) and not NaN");
    ln_intp dims[LN_MAXDIMS];int nd,has_size;
    if(lua_random_shape(L,3,dims,&nd,&has_size))return 0;
    if(!has_size){lua_pushinteger(L,(lua_Integer)ln_pcg64_logseries(rng,p));return 1;}
    ln_error e={{0}};
    ln_array *out=ln_array_new(nd,dims,ln_dtype_by_name("int64"),0,0,&e);
    if(!out)return fail(L,&e);
    ln_intp count=ln_array_size(out);
    if(count<0){ln_array_free(out);return luaL_error(L,"logseries sample shape too large");}
    int64_t *v=(int64_t*)out->data;
    for(ln_intp i=0;i<count;i++)v[i]=ln_pcg64_logseries(rng,p);
    return push_array(L,out);
}

/* NumPy Generator.poisson: int64 values sampled using multiplication for
 * lam < 10 and Hoermann PTRS at lam >= 10. This shares the exact Poisson
 * sampler already used by noncentral_chisquare. */
/* NumPy Generator.binomial: exact PCG64 inversion/BTPE, returning int64.
 * n is a nonnegative Lua integer and p a finite scalar in [0,1]. */
static int lua_generator_binomial(lua_State *L)
{
    ln_pcg64 *rng=check_generator(L,1);
    if(lua_gettop(L)>4)return luaL_error(L,"binomial accepts n, p and size");
    if(test_array(L,2)||test_array(L,3)||lua_type(L,2)==LUA_TTABLE||lua_type(L,3)==LUA_TTABLE){
        /* NumPy permits integer ndarrays for n, but rejects floating
         * ndarray counts even if every element is mathematically integral. */
        lua_array *na=test_array(L,2);
        if(na && na->a->descr->type_num>LN_ULONGLONG)
            return luaL_error(L,"binomial n ndarray must have integer dtype");
        if(lua_type(L,2)==LUA_TNIL||lua_type(L,2)==LUA_TNONE||
           lua_type(L,3)==LUA_TNIL||lua_type(L,3)==LUA_TNONE)
            return luaL_error(L,"binomial requires n and p");
        return lua_generator_broadcast_sample(L,rng,19,4);
    }
    if(!lua_isinteger(L,2))return luaL_error(L,"binomial n must be a Lua integer");
    lua_Integer count=lua_tointegerx(L,2,NULL);
    double p=luaL_checknumber(L,3);
    if(count<0||count>INT64_C(1000000000000))
        return luaL_error(L,"binomial n must be between 0 and 1e12");
    if(!isfinite(p)||p<0.0||p>1.0)
        return luaL_error(L,"binomial p must be finite and between 0 and 1");
    ln_intp dims[LN_MAXDIMS];int nd,has_size;
    if(lua_random_shape(L,4,dims,&nd,&has_size))return 0;
    if(!has_size){
        lua_pushinteger(L,(lua_Integer)ln_pcg64_binomial(rng,(int64_t)count,p));
        return 1;
    }
    ln_error e={{0}};
    ln_array *out=ln_array_new(nd,dims,ln_dtype_by_name("int64"),0,0,&e);
    if(!out)return fail(L,&e);
    ln_intp total=ln_array_size(out);
    if(total<0){ln_array_free(out);return luaL_error(L,"binomial sample shape too large");}
    int64_t *values=(int64_t*)out->data;
    for(ln_intp i=0;i<total;i++)values[i]=ln_pcg64_binomial(rng,(int64_t)count,p);
    return push_array(L,out);
}

/* Scalar Generator.negative_binomial: n may be fractional as in NumPy.
 * Conservative parameter bounds avoid int64_t overflow within the PTRS
 * Poisson sampler; broadcasting will be a separate implementation step. */
static int lua_generator_negative_binomial(lua_State *L)
{
    ln_pcg64 *rng=check_generator(L,1);
    if(lua_gettop(L)>4)return luaL_error(L,"negative_binomial accepts n, p and size");
    if(test_array(L,2)||test_array(L,3)||lua_type(L,2)==LUA_TTABLE||lua_type(L,3)==LUA_TTABLE){
        if(lua_type(L,2)==LUA_TNIL||lua_type(L,2)==LUA_TNONE||
           lua_type(L,3)==LUA_TNIL||lua_type(L,3)==LUA_TNONE)
            return luaL_error(L,"negative_binomial requires n and p");
        return lua_generator_broadcast_sample(L,rng,20,4);
    }
    double n=luaL_checknumber(L,2);
    double prob=luaL_checknumber(L,3);
    if(!isfinite(n)||n<=0.0||n>1e6)
        return luaL_error(L,"negative_binomial n must be finite and in (0,1e6]");
    if(!isfinite(prob)||prob<0.001||prob>1.0)
        return luaL_error(L,"negative_binomial p must be finite and in [0.001,1]");
    ln_intp dims[LN_MAXDIMS];int nd,has_size;
    if(lua_random_shape(L,4,dims,&nd,&has_size))return 0;
    if(!has_size){
        lua_pushinteger(L,(lua_Integer)ln_pcg64_negative_binomial(rng,n,prob));
        return 1;
    }
    ln_error e={{0}};
    ln_array *out=ln_array_new(nd,dims,ln_dtype_by_name("int64"),0,0,&e);
    if(!out)return fail(L,&e);
    ln_intp count=ln_array_size(out);
    if(count<0){ln_array_free(out);return luaL_error(L,"negative_binomial sample shape too large");}
    int64_t *values=(int64_t*)out->data;
    for(ln_intp i=0;i<count;i++)values[i]=ln_pcg64_negative_binomial(rng,n,prob);
    return push_array(L,out);
}

/* NumPy Generator.geometric(p, size): int64 output, scalar p. */
static int lua_generator_geometric(lua_State *L)
{
    ln_pcg64 *rng=check_generator(L,1);
    if(lua_gettop(L)>3)return luaL_error(L,"geometric accepts p and size");
    if(test_array(L,2)||lua_type(L,2)==LUA_TTABLE)
        return lua_generator_broadcast_sample(L,rng,17,3);
    double prob=luaL_checknumber(L,2);
    if(!isfinite(prob)||prob<=0.0||prob>1.0)
        return luaL_error(L,"geometric p must be finite and in (0,1]");
    ln_intp dims[LN_MAXDIMS];int nd,has_size;
    if(lua_random_shape(L,3,dims,&nd,&has_size))return 0;
    if(!has_size){
        lua_pushinteger(L,(lua_Integer)ln_pcg64_geometric(rng,prob));
        return 1;
    }
    ln_error e={{0}};
    ln_array *out=ln_array_new(nd,dims,ln_dtype_by_name("int64"),0,0,&e);
    if(!out)return fail(L,&e);
    ln_intp total=ln_array_size(out);
    if(total<0){ln_array_free(out);return luaL_error(L,"geometric sample shape too large");}
    int64_t *v=(int64_t*)out->data;
    for(ln_intp i=0;i<total;i++)v[i]=ln_pcg64_geometric(rng,prob);
    return push_array(L,out);
}

/* NumPy Generator.zipf(a, size): native int64 Zipf draws. */
static int lua_generator_zipf(lua_State *L)
{
    ln_pcg64 *rng=check_generator(L,1);
    if(lua_gettop(L)>3)return luaL_error(L,"zipf accepts a and size");
    if(test_array(L,2)||lua_type(L,2)==LUA_TTABLE)
        return lua_generator_broadcast_sample(L,rng,23,3);
    double a=luaL_checknumber(L,2);
    if(isnan(a)||a<=1.0)
        return luaL_error(L,"zipf a must be greater than 1 and not NaN");
    ln_intp dims[LN_MAXDIMS];int nd,has_size;
    if(lua_random_shape(L,3,dims,&nd,&has_size))return 0;
    if(!has_size){lua_pushinteger(L,(lua_Integer)ln_pcg64_zipf(rng,a));return 1;}
    ln_error e={{0}};
    ln_array *out=ln_array_new(nd,dims,ln_dtype_by_name("int64"),0,0,&e);
    if(!out)return fail(L,&e);
    ln_intp total=ln_array_size(out);
    if(total<0){ln_array_free(out);return luaL_error(L,"zipf sample shape too large");}
    int64_t *v=(int64_t*)out->data;
    for(ln_intp i=0;i<total;i++)v[i]=ln_pcg64_zipf(rng,a);
    return push_array(L,out);
}

/* Vectorized hypergeometric: broadcast three integer-valued parameters,
 * validating the whole parameter space before consuming the PCG64 stream.
 * NumPy converts Python numeric sequences to int64, but explicitly rejects
 * a floating-point ndarray for hypergeometric integer parameters. */
static int lua_generator_hypergeometric_broadcast(lua_State *L,ln_pcg64 *rng)
{
    ln_intp dims[LN_MAXDIMS]={0};int nd=0,has_size=0;
    if(lua_random_shape(L,5,dims,&nd,&has_size))return 0;
    for(int i=2;i<=4;i++){
        lua_array *u=test_array(L,i);
        if(u&&(u->a->descr->kind!='i'&&u->a->descr->kind!='u'&&u->a->descr->kind!='b'))
            return luaL_error(L,"hypergeometric ndarray parameters must have integer dtype");
    }
    lua_random_bparam a=lua_random_param(L,2,0.0);
    lua_random_bparam b=lua_random_param(L,3,0.0);
    lua_random_bparam c=lua_random_param(L,4,0.0);
    if(lua_random_broadcast_three(L,&a,&b,&c,has_size,dims,&nd))return 0;
    ln_intp vdims[LN_MAXDIMS]={0};int vnd=0;
    if(lua_random_broadcast_three(L,&a,&b,&c,0,vdims,&vnd))return 0;
    size_t validation_count=1;
    for(int j=0;j<vnd;j++){
        if(vdims[j]==0){validation_count=0;break;}
        if((size_t)vdims[j]>SIZE_MAX/validation_count)
            return luaL_error(L,"hypergeometric parameter validation size too large");
        validation_count*=(size_t)vdims[j];
    }
    ln_intp ix[LN_MAXDIMS]={0};
    for(size_t i=0;i<validation_count;i++){
        double good=lua_random_bget(L,&a,vnd,ix);
        double bad=lua_random_bget(L,&b,vnd,ix);
        double sample=lua_random_bget(L,&c,vnd,ix);
        /* Lists of floating values are coerced to int64 by NumPy before
         * domain validation.  A negative fraction such as -0.2 therefore
         * becomes 0; compare the truncated counts, never float inputs. */
        if(!isfinite(good)||!isfinite(bad)||!isfinite(sample)||
           good>=1e9||bad>=1e9||good<=-1.0||bad<=-1.0||
           sample<=-1.0||sample>=0x1.0p63)
            return luaL_error(L,"invalid hypergeometric broadcast parameters");
        int64_t ig=(int64_t)good,ib=(int64_t)bad,is=(int64_t)sample;
        if(is>ig+ib)return luaL_error(L,"hypergeometric ngood + nbad < nsample");
        for(int j=vnd-1;j>=0;j--){if(++ix[j]<vdims[j])break;ix[j]=0;}
    }
    ln_error e={{0}};
    ln_array *out=ln_array_new(nd,dims,ln_dtype_by_name("int64"),0,0,&e);
    if(!out)return fail(L,&e);
    ln_intp n=ln_array_size(out);
    if(n<0){ln_array_free(out);return luaL_error(L,"hypergeometric sample shape too large");}
    memset(ix,0,sizeof(ix));
    int64_t *v=(int64_t*)out->data;
    for(ln_intp i=0;i<n;i++){
        int64_t good=(int64_t)lua_random_bget(L,&a,nd,ix);
        int64_t bad=(int64_t)lua_random_bget(L,&b,nd,ix);
        int64_t sample=(int64_t)lua_random_bget(L,&c,nd,ix);
        v[i]=ln_pcg64_hypergeometric(rng,good,bad,sample);
        for(int j=nd-1;j>=0;j--){if(++ix[j]<dims[j])break;ix[j]=0;}
    }
    if(!has_size&&nd==0){lua_Integer value=(lua_Integer)v[0];ln_array_free(out);lua_pushinteger(L,value);return 1;}
    return push_array(L,out);
}

/* NumPy Generator.hypergeometric, scalar integer parameters, int64 results.
 * Parameter limits mirror NumPy 2.5.3 for ngood / nbad (< 1e9). */
static int lua_generator_hypergeometric(lua_State *L)
{
    ln_pcg64 *rng=check_generator(L,1);
    if(lua_gettop(L)>5)return luaL_error(L,"hypergeometric accepts ngood, nbad, nsample and size");
    if(test_array(L,2)||test_array(L,3)||test_array(L,4)||
       lua_type(L,2)==LUA_TTABLE||lua_type(L,3)==LUA_TTABLE||
       lua_type(L,4)==LUA_TTABLE)
        return lua_generator_hypergeometric_broadcast(L,rng);
    lua_Integer good=luaL_checkinteger(L,2),bad=luaL_checkinteger(L,3),sample=luaL_checkinteger(L,4);
    if(good<0||bad<0||sample<0)return luaL_error(L,"hypergeometric parameters must be nonnegative");
    if(good>=1000000000LL||bad>=1000000000LL)
        return luaL_error(L,"hypergeometric ngood and nbad must be less than 1e9");
    if(sample>good+bad)return luaL_error(L,"hypergeometric ngood + nbad < nsample");
    ln_intp dims[LN_MAXDIMS];int nd,has_size;
    if(lua_random_shape(L,5,dims,&nd,&has_size))return 0;
    if(!has_size){lua_pushinteger(L,(lua_Integer)ln_pcg64_hypergeometric(rng,good,bad,sample));return 1;}
    ln_error e={{0}};
    ln_array *out=ln_array_new(nd,dims,ln_dtype_by_name("int64"),0,0,&e);
    if(!out)return fail(L,&e);
    ln_intp count=ln_array_size(out);
    if(count<0){ln_array_free(out);return luaL_error(L,"hypergeometric sample shape too large");}
    int64_t *values=(int64_t*)out->data;
    for(ln_intp i=0;i<count;i++)values[i]=ln_pcg64_hypergeometric(rng,good,bad,sample);
    return push_array(L,out);
}

/* NumPy Generator.multivariate_hypergeometric(colors, nsample, size, method).
 * Colors are a dense 1D Lua integer table or 1D integral ndarray.
 * `count` retains a shuffled population array across variates, as upstream.
 */
static int lua_generator_multivariate_hypergeometric(lua_State *L)
{
    ln_pcg64 *rng=check_generator(L,1);
    if(lua_gettop(L)>5)return luaL_error(L,"multivariate_hypergeometric accepts colors, nsample, size, method");
    int count_method=0;
    if(lua_type(L,5)!=LUA_TNONE&&lua_type(L,5)!=LUA_TNIL){
        const char *meth=luaL_checklstring(L,5,NULL);
        if(strcmp(meth,"count")==0)count_method=1;
        else if(strcmp(meth,"marginals")!=0)return luaL_error(L,"method must be count or marginals");
    }
    if(!lua_isinteger(L,3))return luaL_error(L,"nsample must be an integer");
    lua_Integer nsample=luaL_checkinteger(L,3);
    if(nsample<0)return luaL_error(L,"nsample must be nonnegative");
    lua_array *arr=test_array(L,2);
    size_t k;
    if(arr){
        const ln_array *a=arr->a;
        if(a->nd!=1||(a->descr->kind!='i'&&a->descr->kind!='u'))
            return luaL_error(L,"colors must be a one-dimensional sequence of nonnegative integers");
        k=(size_t)a->dimensions[0];
    } else if(lua_type(L,2)==LUA_TTABLE)k=lua_rawlen(L,2);
    else return luaL_error(L,"colors must be a one-dimensional integer table or ndarray");
    if(k>1000000)return luaL_error(L,"colors sequence exceeds 1000000 entries");
    ln_intp dims[LN_MAXDIMS];int nd=0,has_size=0;
    if(lua_random_shape(L,4,dims,&nd,&has_size))return 0;
    if(nd>=LN_MAXDIMS)return luaL_error(L,"maximum supported dimension count exceeded");
    dims[nd++]=(ln_intp)k;
    int64_t *colors=calloc(k?k:1,sizeof(int64_t));
    if(!colors)return luaL_error(L,"cannot allocate colors");
    int64_t total=0;
    for(size_t i=0;i<k;i++){
        int64_t v=0;
        if(arr){
            const ln_array *a=arr->a;
            const unsigned char *pval=(const unsigned char*)a->data + (ln_intp)i*a->strides[0];
            uint64_t bits=0;
            memcpy(&bits,pval,(size_t)a->descr->elsize);
            if(a->descr->kind=='u'){
                if(bits>INT64_MAX){free(colors);return luaL_error(L,"colors values exceed int64");}
                v=(int64_t)bits;
            } else {
                switch(a->descr->elsize){
                case 1:v=(int8_t)bits;break;
                case 2:v=(int16_t)bits;break;
                case 4:v=(int32_t)bits;break;
                case 8:v=(int64_t)bits;break;
                default:free(colors);return luaL_error(L,"unsupported integer colors dtype");
                }
            }
        } else {
            lua_geti(L,2,(lua_Integer)i+1);
            if(!lua_isinteger(L,-1)){
                lua_pop(L,1);free(colors);
                return luaL_error(L,"colors must contain integer values");
            }
            v=(int64_t)lua_tointegerx(L,-1,NULL);
            lua_pop(L,1);
        }
        if(v<0 || v>INT64_MAX-total){free(colors);return luaL_error(L,"colors must be nonnegative and their sum fit int64");}
        colors[i]=v;total+=v;
    }
    if(!count_method&&total>=1000000000LL){free(colors);return luaL_error(L,"marginals requires sum(colors) < 1e9");}
    /* Keep memory use under control: count requires one size_t per item. */
    if(count_method&&total>2000000LL){free(colors);return luaL_error(L,"count currently supports sum(colors) <= 2000000");}
    if((int64_t)nsample>total){free(colors);return luaL_error(L,"nsample > sum(colors)");}
    ln_error e={{0}};
    ln_array *out=ln_array_new(nd,dims,ln_dtype_by_name("int64"),0,0,&e);
    if(!out){free(colors);return fail(L,&e);}
    ln_intp len=ln_array_size(out);
    if(len<0){ln_array_free(out);free(colors);return luaL_error(L,"multivariate sample shape too large");}
    /* For k=0, output shape is still meaningful but contains no samples. */
    if(len>0)memset(out->data,0,(size_t)len*sizeof(int64_t));
    size_t nvariates=k?((size_t)len/k):0;
    int rc=ln_pcg64_multivariate_hypergeometric(rng,colors,k,total,(int64_t)nsample,
                        nvariates,count_method,(int64_t*)out->data);
    free(colors);
    if(rc<0){ln_array_free(out);return luaL_error(L,"cannot allocate multivariate sampling workspace");}
    return push_array(L,out);
}

/* NumPy Generator.multinomial(n, pvals, size). The last probability is
 * validated but is not used in the sampler: it receives any leftover mass.
 * Initial release supports scalar n and a single one-dimensional pvals vector;
 * NumPy's broadcasted input parameters remain explicitly unsupported. */
static int lua_generator_multinomial(lua_State *L)
{
    ln_pcg64 *rng=check_generator(L,1);
    if(lua_gettop(L)>4)return luaL_error(L,"multinomial accepts n, pvals and size");
    if(!lua_isinteger(L,2))return luaL_error(L,"multinomial n must be a Lua integer");
    lua_Integer n=lua_tointegerx(L,2,NULL);
    if(n<0||n>INT64_C(1000000000000))return luaL_error(L,"multinomial n must be between 0 and 1e12");
    lua_array *pa=test_array(L,3);
    size_t k=0;
    if(pa) {
        const ln_array *a=pa->a;
        if(a->nd!=1||(a->descr->kind!='f'&&a->descr->kind!='i'&&a->descr->kind!='u'&&a->descr->kind!='b'))
            return luaL_error(L,"multinomial pvals must be a numeric 1D array");
        k=(size_t)a->dimensions[0];
    } else if(lua_type(L,3)==LUA_TTABLE)k=lua_rawlen(L,3);
    else return luaL_error(L,"multinomial pvals must be a one-dimensional numeric table or ndarray");
    if(k==0||k>1000000)return luaL_error(L,"multinomial pvals count must be between 1 and 1000000");
    /* Parse user-provided size before allocating C workspace; Lua raises via
     * longjmp on malformed dimensions, bypassing ordinary free() cleanup. */
    ln_intp dims[LN_MAXDIMS];int nd=0,has_size=0;
    if(lua_random_shape(L,4,dims,&nd,&has_size))return 0;
    if(nd>=LN_MAXDIMS)return luaL_error(L,"multinomial exceeds maximum dimensions");
    dims[nd++]=(ln_intp)k;
    double *prob=malloc(k*sizeof(double));
    if(!prob)return luaL_error(L,"cannot allocate probabilities");
    double sum=0.0, compensation=0.0;
    for(size_t i=0;i<k;i++) {
        double value=0.0;
        if(pa) {
            ln_intp idx[1]={(ln_intp)i};
            int64_t iv=0;int isint=0;ln_error e={{0}};
            if(ln_array_get_number(pa->a,idx,&value,&iv,&isint,&e)<0){
                free(prob);return luaL_error(L,"cannot read pvals array");
            }
            if(isint)value=(double)iv;
        } else {
            lua_geti(L,3,(lua_Integer)i+1);
            int ok=0;value=(double)lua_tonumberx(L,-1,&ok);
            lua_pop(L,1);
            if(!ok){free(prob);return luaL_error(L,"multinomial pvals must contain numbers");}
        }
        if(!isfinite(value)||value<0.0||value>1.0){
            free(prob);return luaL_error(L,"multinomial probabilities must be in [0,1]");
        }
        prob[i]=value;
        if(i+1<k) {
            /* NumPy validates sum(pvals[:-1]) using compensated summation. */
            double y=value-compensation;
            double t=sum+y;
            compensation=(t-sum)-y;
            sum=t;
        }
    }
    if(sum>1.0+1e-12){free(prob);return luaL_error(L,"multinomial sum(pvals[:-1]) exceeds 1");}
    ln_error e={{0}};
    ln_array *out=ln_array_new(nd,dims,ln_dtype_by_name("int64"),0,0,&e);
    if(!out){free(prob);return fail(L,&e);}
    ln_intp length=ln_array_size(out);
    if(length<0){free(prob);ln_array_free(out);return luaL_error(L,"multinomial sample shape too large");}
    if(length>0)memset(out->data,0,(size_t)length*sizeof(int64_t));
    ln_pcg64_multinomial(rng,(int64_t)n,prob,k,(size_t)length/k,(int64_t*)out->data);
    free(prob);
    return push_array(L,out);
}

/* Generator.dirichlet(alpha, size): independent sample vectors of float64.
 * NumPy 2.5.3 chooses Beta stick-breaking for max(alpha) < 0.1,
 * gamma normalization otherwise, preserving PCG64 draw order. */
static int lua_generator_dirichlet(lua_State *L)
{
    ln_pcg64 *rng=check_generator(L,1);
    if(lua_gettop(L)>3)return luaL_error(L,"dirichlet accepts alpha and size");
    lua_array *pa=test_array(L,2);
    size_t k=0;
    if(pa){
        const ln_array *a=pa->a;
        if(a->nd!=1||(a->descr->kind!='f'&&a->descr->kind!='i'&&a->descr->kind!='u'&&a->descr->kind!='b'))
            return luaL_error(L,"dirichlet alpha must be a numeric 1D array");
        k=(size_t)a->dimensions[0];
    } else if(lua_type(L,2)==LUA_TTABLE)k=lua_rawlen(L,2);
    else return luaL_error(L,"dirichlet alpha must be a 1D numeric table or ndarray");
    if(k>1000000)return luaL_error(L,"dirichlet alpha vector exceeds limit");
    /* Validate shape first, avoiding Lua's longjmp with C buffers live. */
    ln_intp dims[LN_MAXDIMS];int nd=0,has_size=0;
    if(lua_random_shape(L,3,dims,&nd,&has_size))return 0;
    if(nd>=LN_MAXDIMS)return luaL_error(L,"dirichlet exceeds maximum dimensions");
    dims[nd++]=(ln_intp)k;
    /* This workspace must allocate before sampling, so an allocation
     * failure never leaves PCG64 partially advanced. */
    double *alpha=malloc((k?k:1)*sizeof(*alpha));
    if(!alpha)return luaL_error(L,"cannot allocate dirichlet alpha");
    for(size_t i=0;i<k;i++){
        double value=0.0;
        if(pa){
            ln_intp idx[1]={(ln_intp)i};int64_t iv=0;int isint=0;ln_error e={{0}};
            if(ln_array_get_number(pa->a,idx,&value,&iv,&isint,&e)<0){
                free(alpha);return luaL_error(L,"cannot read dirichlet alpha array");
            }
            if(isint)value=(double)iv;
        } else {
            lua_geti(L,2,(lua_Integer)i+1);
            int ok=0;value=(double)lua_tonumberx(L,-1,&ok);lua_pop(L,1);
            if(!ok){free(alpha);return luaL_error(L,"dirichlet alpha must contain numbers");}
        }
        /* Initial port restricts nonfinite alpha to avoid libm-specific
         * Gamma corner cases; NumPy accepts certain nonfinite values. */
        if(!isfinite(value)||value<0.0){
            free(alpha);return luaL_error(L,"dirichlet alpha must be finite and nonnegative");
        }
        alpha[i]=value;
    }
    ln_error e={{0}};
    ln_array *out=ln_array_new(nd,dims,ln_dtype_by_name("float64"),0,0,&e);
    if(!out){free(alpha);return fail(L,&e);}
    ln_intp count=ln_array_size(out);
    if(count<0){free(alpha);ln_array_free(out);return luaL_error(L,"dirichlet sample shape too large");}
    if(count>0)memset(out->data,0,(size_t)count*sizeof(double));
    /* k=0 still has a well-defined shape and must not consume bits. */
    if(k && count){
        /* Enforce scratch availability before consuming RNG bits. */
        double *scratch=malloc(k*sizeof(double));
        if(!scratch){free(alpha);ln_array_free(out);return luaL_error(L,"cannot allocate dirichlet workspace");}
        ln_pcg64_dirichlet(rng,alpha,k,(size_t)count/k,(double*)out->data,scratch);
        free(scratch);
    }
    free(alpha);
    return push_array(L,out);
}

static int lua_generator_poisson(lua_State *L)
{
    ln_pcg64 *rng=check_generator(L,1);
    if(lua_gettop(L)>3)return luaL_error(L,"poisson accepts lam and size");
    if(test_array(L,2)||lua_type(L,2)==LUA_TTABLE)
        return lua_generator_broadcast_sample(L,rng,18,3);
    double lam=(lua_type(L,2)==LUA_TNONE||lua_type(L,2)==LUA_TNIL)?1.0:luaL_checknumber(L,2);
    /* Deliberate guard: 1e12 is within the safe integer conversion and
     * floating-point domain of the existing PTRS implementation. */
    if(!isfinite(lam)||lam<0.0||lam>1e12)
        return luaL_error(L,"poisson lam must be finite and between 0 and 1e12");
    ln_intp dims[LN_MAXDIMS];int nd,has_size;
    if(lua_random_shape(L,3,dims,&nd,&has_size))return 0;
    if(!has_size){lua_pushinteger(L,(lua_Integer)ln_pcg64_poisson(rng,lam));return 1;}
    ln_error e={{0}};
    ln_array *out=ln_array_new(nd,dims,ln_dtype_by_name("int64"),0,0,&e);
    if(!out)return fail(L,&e);
    ln_intp n=ln_array_size(out);
    if(n<0){ln_array_free(out);return luaL_error(L,"poisson sample shape too large");}
    int64_t *v=(int64_t*)out->data;
    for(ln_intp i=0;i<n;i++)v[i]=ln_pcg64_poisson(rng,lam);
    return push_array(L,out);
}

static int lua_generator_standard_cauchy(lua_State *L)
{
    ln_pcg64 *rng=check_generator(L,1);
    if(lua_gettop(L)>2)return luaL_error(L,"standard_cauchy accepts at most one size");
    ln_intp dims[LN_MAXDIMS];int nd,has_size;
    if(lua_random_shape(L,2,dims,&nd,&has_size))return 0;
    if(!has_size){lua_pushnumber(L,ln_pcg64_standard_cauchy(rng));return 1;}
    ln_error e={{0}};
    ln_array *out=ln_array_new(nd,dims,ln_dtype_by_num(LN_DOUBLE),0,0,&e);
    if(!out)return fail(L,&e);
    ln_intp n=ln_array_size(out);
    if(n<0){ln_array_free(out);return luaL_error(L,"sample shape too large");}
    double *v=(double *)out->data;
    for(ln_intp i=0;i<n;i++)v[i]=ln_pcg64_standard_cauchy(rng);
    return push_array(L,out);
}

/* Generator.integers with array-like boundaries: store integers separately
 * from double arguments so scalar int64 limits remain exact. Tables are
 * converted by the Lua ndarray constructor and retained on the Lua stack.
 * As with the scalar implementation, uint64 bounds above INT64_MAX are not
 * representable in Lua's numeric scalar interface. */
typedef struct {
    const ln_array *array;
    int64_t scalar;
} lua_integer_bparam;

/* Preserve signed 64-bit precision when a Lua integer table is used as a
 * vectorized bound. Converting all Lua tables to float64 (the previous
 * implementation) rounded legitimate limits above 2**53. For mixed or
 * floating-point tables keep the original float64 conversion semantics. */
static int lua_integer_table_is_exact(lua_State *L,int idx,int depth)
{
    idx=lua_absindex(L,idx);
    if(lua_type(L,idx)!=LUA_TTABLE)
        return lua_isinteger(L,idx)||lua_type(L,idx)==LUA_TBOOLEAN;
    if(depth>=LN_MAXDIMS)return 0;
    size_t n=lua_rawlen(L,idx);
    for(size_t i=0;i<n;i++){
        lua_geti(L,idx,(lua_Integer)i+1);
        int ok=lua_integer_table_is_exact(L,-1,depth+1);
        lua_pop(L,1);
        if(!ok)return 0;
    }
    return 1;
}

static lua_integer_bparam lua_integer_param(lua_State *L,int idx,int64_t def)
{
    lua_integer_bparam p={NULL,def};
    int type=lua_type(L,idx);
    if(type==LUA_TNONE||type==LUA_TNIL)return p;
    if(type==LUA_TNUMBER){
        if(lua_isinteger(L,idx)){p.scalar=(int64_t)lua_tointegerx(L,idx,NULL);return p;}
        double v=luaL_checknumber(L,idx);
        if(!isfinite(v)||v < -0x1p63 || v >= 0x1p63)
            luaL_error(L,"integers parameter out of int64 range");
        p.scalar=(int64_t)v;
        return p;
    }
    lua_array *a=test_array(L,idx);
    if(a){p.array=a->a;return p;}
    if(type!=LUA_TTABLE)luaL_error(L,"integers bounds must be numeric, tables or ndarray");
    lua_pushcfunction(L,np_array);
    lua_pushvalue(L,idx);
    lua_pushstring(L,lua_integer_table_is_exact(L,idx,0)?"int64":"float64");
    if(lua_pcall(L,2,1,0)!=LUA_OK)
        luaL_error(L,"invalid integers bound table: %s",lua_tostring(L,-1));
    p.array=check_array(L,-1)->a;
    return p;
}

static int64_t lua_integer_bget(lua_State *L,const lua_integer_bparam *p,int nd,
                                const ln_intp *index)
{
    if(!p->array)return p->scalar;
    const ln_array *a=p->array;
    if(a->descr->kind=='u'&&a->descr->elsize==8){
        /* Inspect uint64 directly; generic get_number coerces high bits. */
        ln_intp offset=0;
        for(int j=0;j<a->nd;j++){
            ln_intp pos=a->dimensions[j]==1?0:index[nd-a->nd+j];
            offset+=pos*a->strides[j];
        }
        uint64_t v=0;
        memcpy(&v,a->data+offset,sizeof(v));
        if(v>INT64_MAX)luaL_error(L,"uint64 bound exceeds LuaRay signed range");
        return (int64_t)v;
    }
    ln_intp local[LN_MAXDIMS]={0};
    for(int j=0;j<a->nd;j++)local[j]=a->dimensions[j]==1?0:index[nd-a->nd+j];
    double fv=0;int64_t iv=0;int isint=0;ln_error e={{0}};
    if(ln_array_get_number(a,local,&fv,&iv,&isint,&e)<0)
        luaL_error(L,"integers bound dtype: %s",e.message);
    if(isint)return iv;
    if(!isfinite(fv)||fv < -0x1p63 || fv >= 0x1p63)
        luaL_error(L,"integers bound is not a finite int64 value");
    return (int64_t)fv;
}

static int lua_generator_integers_broadcast(lua_State *L,ln_pcg64 *rng,
                                            const ln_dtype *dt,int has_high,int endpoint)
{
    ln_intp dims[LN_MAXDIMS]={0};int nd=0,has_size=0;
    if(lua_random_shape(L,4,dims,&nd,&has_size))return 0;
    lua_integer_bparam low=lua_integer_param(L,2,0);
    lua_integer_bparam high=has_high?lua_integer_param(L,3,0):low;
    if(!has_high){low.array=NULL;low.scalar=0;}
    lua_random_bparam lo_shape={low.array,0},hi_shape={high.array,0};
    if(lua_random_broadcast_dims(L,&lo_shape,&hi_shape,has_size,dims,&nd))return 0;
    __extension__ typedef __int128 signed128;
    signed128 type_min=dt->kind=='u'||dt->type_num==LN_BOOL?0:-((signed128)1<<(8*dt->elsize-1));
    signed128 type_max=dt->type_num==LN_BOOL?1:(dt->kind=='u'?(((signed128)1<<(8*dt->elsize))-1):(((signed128)1<<(8*dt->elsize-1))-1));
    size_t count=1;
    for(int j=0;j<nd;j++){
        if(dims[j]==0){count=0;break;}
        if(dims[j]<0||(size_t)dims[j]>SIZE_MAX/count)
            return luaL_error(L,"integers sample shape too large");
        count*=(size_t)dims[j];
    }
    /* Check all bounds before writing output or consuming any PCG64 bits.
     * As NumPy does, zero-length output skips elementwise bounds checking. */
    ln_intp coords[LN_MAXDIMS]={0};
    for(size_t i=0;i<count;i++){
        signed128 lower=lua_integer_bget(L,&low,nd,coords);
        signed128 upper=lua_integer_bget(L,&high,nd,coords);
        if(lower<type_min||lower>type_max||upper<type_min||upper>type_max+(!endpoint))
            return luaL_error(L,"integers bounds exceed dtype range");
        if(endpoint?upper<lower:upper<=lower)
            return luaL_error(L,"invalid integers bounds");
        for(int j=nd-1;j>=0;j--){if(++coords[j]<dims[j])break;coords[j]=0;}
    }
    ln_error e={{0}};
    ln_array *out=ln_array_new(nd,dims,dt,0,0,&e);
    if(!out)return fail(L,&e);
    memset(coords,0,sizeof(coords));
    uint32_t local_buf=0;int local_remain=0;
    for(size_t i=0;i<count;i++){
        int64_t lowval=lua_integer_bget(L,&low,nd,coords);
        int64_t highval=lua_integer_bget(L,&high,nd,coords);
        uint64_t range=(uint64_t)((signed128)highval-(signed128)lowval-(endpoint?0:1));
        uint64_t offset=dt->type_num==LN_BOOL?
            ln_pcg64_bounded_small(rng,(uint32_t)range,1,&local_buf,&local_remain):
            (dt->elsize<4?ln_pcg64_bounded_small(rng,(uint32_t)range,(unsigned)(8*dt->elsize),&local_buf,&local_remain):ln_pcg64_bounded64(rng,range));
        uint64_t bits=(uint64_t)lowval+offset;
        char *dest=out->data+i*(size_t)dt->elsize;
        if(dt->elsize==8)memcpy(dest,&bits,8);
        else if(dt->elsize==4){uint32_t v=(uint32_t)bits;memcpy(dest,&v,4);}
        else if(dt->elsize==2){uint16_t v=(uint16_t)bits;memcpy(dest,&v,2);}
        else {uint8_t v=(uint8_t)bits;memcpy(dest,&v,1);}
        for(int j=nd-1;j>=0;j--){if(++coords[j]<dims[j])break;coords[j]=0;}
    }
    if(!has_size&&nd==0){
        uint64_t bits=0;
        memcpy(&bits,out->data,(size_t)dt->elsize);
        if(dt->type_num==LN_BOOL){int value=(bits&1)!=0;ln_array_free(out);lua_pushboolean(L,value);return 1;}
        if(dt->kind=='u'&&bits>(uint64_t)INT64_MAX){ln_array_free(out);return luaL_error(L,"uint64 scalar result cannot be represented as a Lua integer");}
        ln_array_free(out);
        if(dt->kind=='i'){
            if(dt->elsize==1)bits=(uint64_t)(int64_t)(int8_t)bits;
            else if(dt->elsize==2)bits=(uint64_t)(int64_t)(int16_t)bits;
            else if(dt->elsize==4)bits=(uint64_t)(int64_t)(int32_t)bits;
        }
        lua_pushinteger(L,(lua_Integer)(int64_t)bits);
        return 1;
    }
    return push_array(L,out);
}

/* Endpoint and dtype follow Generator.integers. Bounds are signed Lua integers.
 * uint64 inputs beyond INT64_MAX require a future exact uint64 scalar API. */
static int lua_generator_integers(lua_State *L)
{
    ln_pcg64 *rng=check_generator(L,1);
    int argc=lua_gettop(L);
    if(argc>6)return luaL_error(L,"integers accepts low, high, size, dtype and endpoint");
    int has_high=lua_type(L,3)!=LUA_TNONE&&lua_type(L,3)!=LUA_TNIL;
    const char *name=lua_type(L,5)==LUA_TNIL||lua_type(L,5)==LUA_TNONE?"int64":luaL_checklstring(L,5,NULL);
    const ln_dtype *dt=ln_dtype_by_name(name);
    if(!dt||!(((dt->kind=='i'||dt->kind=='u')&&(dt->elsize==1||dt->elsize==2||dt->elsize==4||dt->elsize==8))||dt->type_num==LN_BOOL))
        return luaL_error(L,"integers requires a supported integer dtype");
    if(lua_type(L,6)!=LUA_TNONE&&lua_type(L,6)!=LUA_TNIL&&lua_type(L,6)!=LUA_TBOOLEAN)
        return luaL_error(L,"endpoint must be boolean");
    int endpoint=lua_toboolean(L,6);
    if(test_array(L,2)||test_array(L,3)||lua_type(L,2)==LUA_TTABLE||lua_type(L,3)==LUA_TTABLE)
        return lua_generator_integers_broadcast(L,rng,dt,has_high,endpoint);
    if(!lua_isinteger(L,2)||(has_high&&!lua_isinteger(L,3)))return luaL_error(L,"integers bounds must be Lua integers");
    int64_t low=has_high?(int64_t)lua_tointegerx(L,2,NULL):0;
    int64_t high=has_high?(int64_t)lua_tointegerx(L,3,NULL):(int64_t)lua_tointegerx(L,2,NULL);
    __extension__ typedef __int128 signed128;
    signed128 lower=low,upper=high;
    signed128 type_min=dt->kind=='u'||dt->type_num==LN_BOOL?0:-((signed128)1<<(8*dt->elsize-1));
    signed128 type_max=dt->type_num==LN_BOOL?1:(dt->kind=='u'?(((signed128)1<<(8*dt->elsize))-1):(((signed128)1<<(8*dt->elsize-1))-1));
    /* An exclusive upper bound may be one past the largest representable dtype. */
    if(lower<type_min||lower>type_max||upper<type_min||upper>type_max+(!endpoint))
        return luaL_error(L,"integers bounds exceed dtype range");
    if(endpoint?upper<lower:upper<=lower)
        return luaL_error(L,"invalid integers bounds");
    uint64_t range=(uint64_t)(upper-lower-(endpoint?0:1));
    ln_intp dims[LN_MAXDIMS];int nd,has_size;
    if(lua_random_shape(L,4,dims,&nd,&has_size))return 0;
    ln_error e={{0}};
    ln_array *out=NULL;
    ln_intp total=1;
    if(has_size){
        out=ln_array_new(nd,dims,dt,0,0,&e);
        if(!out)return fail(L,&e);
        total=ln_array_size(out);
        if(total<0){ln_array_free(out);return luaL_error(L,"integer sample shape too large");}
    }
    uint32_t local_buf=0;int local_remain=0;
    for(ln_intp i=0;i<total;i++){
        /* NumPy buffers packed 8/16-bit samples within one integers() call. */
        uint64_t offset=dt->type_num==LN_BOOL?ln_pcg64_bounded_small(rng,(uint32_t)range,1,&local_buf,&local_remain):(dt->elsize<4?ln_pcg64_bounded_small(rng,(uint32_t)range,(unsigned)(8*dt->elsize),&local_buf,&local_remain):ln_pcg64_bounded64(rng,range));
        uint64_t bits=(uint64_t)low+offset;
        if(!out){
            if(dt->type_num==LN_BOOL){lua_pushboolean(L,bits!=0);return 1;}
            if(dt->kind=='u'&&bits>(uint64_t)INT64_MAX)return luaL_error(L,"uint64 scalar result cannot be represented as a Lua integer");
            lua_pushinteger(L,(lua_Integer)(int64_t)bits);
            return 1;
        }
        char *dest=out->data+(size_t)i*dt->elsize;
        if(dt->elsize==8)memcpy(dest,&bits,8);
        else if(dt->elsize==4){uint32_t v=(uint32_t)bits;memcpy(dest,&v,4);}
        else if(dt->elsize==2){uint16_t v=(uint16_t)bits;memcpy(dest,&v,2);}
        else {uint8_t v=(uint8_t)bits;memcpy(dest,&v,1);}
    }
    return push_array(L,out);
}

/* Generator.shuffle and Generator.permutation, NumPy 2.5.3 semantics.
 * Lua uses 1-based axes (axis=1 corresponds to NumPy axis=0).
 * Permutations operate on arbitrary dtype byte representations, including
 * fixed-width strings, and preserve ndarray views/strides on shuffle. */
static int generator_shuffle_axis(lua_State *L, ln_pcg64 *rng, ln_array *a, int axis)
{
    if(!(a->flags & LN_ARRAY_WRITEABLE))return luaL_error(L,"shuffle requires a writable ndarray");
    if(a->nd==0)return luaL_error(L,"axis is out of bounds for array of dimension 0");
    ln_intp n=a->dimensions[axis];
    ln_intp total=ln_array_size(a);
    if(n<2 || total==0)return 0;
    if(total<0 || a->descr->elsize==0 || (size_t)(total/n)>SIZE_MAX/a->descr->elsize)
        return luaL_error(L,"shuffle array is too large");
    size_t item=a->descr->elsize;
    size_t slice_size=(size_t)(total/n);
    size_t nbytes=slice_size*item;
    char *tmp=(char*)malloc(nbytes?nbytes:1);
    if(!tmp)return luaL_error(L,"shuffle: out of memory");
    for(ln_intp i=n-1;i>=1;--i){
        ln_intp j=(ln_intp)ln_pcg64_interval(rng,(uint64_t)i);
        if(j==i)continue;
        ln_intp coords[LN_MAXDIMS]={0};
        /* Copy one whole axis slice so swaps work for non-contiguous axes. */
        for(size_t k=0;k<slice_size;k++){
            ln_intp off=0;
            for(int d=0;d<a->nd;d++)if(d!=axis)off+=coords[d]*a->strides[d];
            memcpy(tmp+k*item,a->data+j*a->strides[axis]+off,item);
            for(int d=a->nd-1;d>=0;d--)if(d!=axis){
                if(++coords[d]<a->dimensions[d])break;
                coords[d]=0;
            }
        }
        memset(coords,0,sizeof(coords));
        for(size_t k=0;k<slice_size;k++){
            ln_intp off=0;
            for(int d=0;d<a->nd;d++)if(d!=axis)off+=coords[d]*a->strides[d];
            memcpy(a->data+j*a->strides[axis]+off,a->data+i*a->strides[axis]+off,item);
            for(int d=a->nd-1;d>=0;d--)if(d!=axis){
                if(++coords[d]<a->dimensions[d])break;
                coords[d]=0;
            }
        }
        memset(coords,0,sizeof(coords));
        for(size_t k=0;k<slice_size;k++){
            ln_intp off=0;
            for(int d=0;d<a->nd;d++)if(d!=axis)off+=coords[d]*a->strides[d];
            memcpy(a->data+i*a->strides[axis]+off,tmp+k*item,item);
            for(int d=a->nd-1;d>=0;d--)if(d!=axis){
                if(++coords[d]<a->dimensions[d])break;
                coords[d]=0;
            }
        }
    }
    free(tmp);
    return 0;
}

static int lua_generator_shuffle(lua_State *L)
{
    ln_pcg64 *rng=check_generator(L,1);
    if(lua_type(L,2)==LUA_TNONE)return luaL_error(L,"missing sequence argument");
    lua_array *u=test_array(L,2);
    if(u){
        int axis=0;
        if(!(lua_type(L,3)==LUA_TNONE || lua_type(L,3)==LUA_TNIL) && normalize_lua_axis(L,luaL_checkinteger(L,3),u->a->nd,&axis))return 0;
        if(lua_gettop(L)>3)return luaL_error(L,"shuffle expects x and optional axis");
        generator_shuffle_axis(L,rng,u->a,axis);
        return 0; /* in-place operation has no return value */
    }
    luaL_checktype(L,2,LUA_TTABLE);
    if(!(lua_type(L,3)==LUA_TNONE || lua_type(L,3)==LUA_TNIL) && luaL_checkinteger(L,3)!=1)
        return luaL_error(L,"axis argument is only supported on ndarray objects");
    if(lua_gettop(L)>3)return luaL_error(L,"shuffle expects x and optional axis");
    size_t n=lua_rawlen(L,2);
    for(size_t i=n;i>1;i--){
        size_t j=(size_t)ln_pcg64_interval(rng,(uint64_t)(i-1))+1;
        if(i==j)continue;
        lua_geti(L,2,(lua_Integer)i);
        lua_geti(L,2,(lua_Integer)j);
        lua_seti(L,2,(lua_Integer)i);
        lua_seti(L,2,(lua_Integer)j);
    }
    return 0;
}

static ln_array *generator_array_copy(lua_State *L,const ln_array *a)
{
    ln_error e={{0}};
    ln_array *out=ln_array_new(a->nd,a->dimensions,a->descr,0,0,&e);
    if(!out){fail(L,&e);return NULL;}
    ln_intp total=ln_array_size(a),coords[LN_MAXDIMS]={0};
    if(total<0){ln_array_free(out);luaL_error(L,"permutation array is too large");return NULL;}
    size_t item=a->descr->elsize;
    for(ln_intp i=0;i<total;i++){
        ln_intp off=0;
        for(int d=0;d<a->nd;d++)off+=coords[d]*a->strides[d];
        memcpy(out->data+(size_t)i*item,a->data+off,item);
        for(int d=a->nd-1;d>=0;d--){
            if(++coords[d]<a->dimensions[d])break;
            coords[d]=0;
        }
    }
    return out;
}

static int lua_generator_permutation(lua_State *L)
{
    ln_pcg64 *rng=check_generator(L,1);
    int nargs=lua_gettop(L);
    if(nargs<2)return luaL_error(L,"missing sequence argument");
    if(nargs>3)return luaL_error(L,"permutation expects x and optional axis");
    ln_array *out=NULL;
    int axis=0;
    if(lua_isinteger(L,2)){
        lua_Integer count=lua_tointegerx(L,2,NULL);
        ln_intp dims[1]={count>0?(ln_intp)count:0};
        ln_error e={{0}};
        out=ln_array_new(1,dims,ln_dtype_by_name("int64"),0,0,&e);
        if(!out)return fail(L,&e);
        for(ln_intp i=0;i<dims[0];i++)memcpy(out->data+(size_t)i*sizeof(int64_t),&i,sizeof(int64_t));
    }else{
        lua_array *u=test_array(L,2);
        if(!u){
            /* np.array is the native LuaRay array constructor; protect its
             * conversion error and keep the resulting userdata rooted. */
            lua_pushcfunction(L,np_array);lua_pushvalue(L,2);
            if(lua_pcall(L,1,1,0)!=LUA_OK)
                return luaL_error(L,"cannot convert permutation input: %s",lua_tostring(L,-1));
            u=check_array(L,-1);
        }
        if(u->a->nd==0)return luaL_error(L,"axis is out of bounds for array of dimension 0");
        if(nargs==3 && lua_type(L,3)!=LUA_TNIL && normalize_lua_axis(L,luaL_checkinteger(L,3),u->a->nd,&axis))return 0;
        out=generator_array_copy(L,u->a);
    }
    /* Upstream permutation(ndarray, ndim>1) always shuffles an index array,
     * even when the data array has zero elements because another axis is 0.
     * Unlike shuffle(empty_ndarray), this advances PCG64. */
    if(out->nd>1 && ln_array_size(out)==0 && out->dimensions[axis]>1){
        for(ln_intp i=out->dimensions[axis]-1;i>=1;--i)
            (void)ln_pcg64_interval(rng,(uint64_t)i);
    }else generator_shuffle_axis(L,rng,out,axis);
    return push_array(L,out);
}

/* NumPy 2.5.3 Generator.permuted, native axis-independent shuffling.
 * Unlike shuffle(), permuted() shuffles each 1-D axis fiber separately,
 * rather than swapping entire axis slices.  Lua axes are 1-based; nil
 * requests an order='K' flattened shuffle. */
static int generator_copy_into(lua_State *L,const ln_array *src,ln_array *dst)
{
    if(!(dst->flags & LN_ARRAY_WRITEABLE))return luaL_error(L,"out must be writeable");
    if(src->nd!=dst->nd)return luaL_error(L,"out must have the same shape as x");
    for(int i=0;i<src->nd;i++)if(src->dimensions[i]!=dst->dimensions[i])
        return luaL_error(L,"out must have the same shape as x");
    if(!ln_dtype_can_cast(src->descr,dst->descr,LN_SAFE_CASTING))
        return luaL_error(L,"cannot safely cast x into out");
    ln_intp n=ln_array_size(src);
    if(n<0)return luaL_error(L,"permuted array is too large");
    /* Snapshot the input even if the two arrays overlap through views.
     * This is necessary for the same semantics as NumPy.copyto. */
    ln_array *snapshot=generator_array_copy(L,src);
    if(!snapshot)return 0;
    ln_intp coords[LN_MAXDIMS]={0};
    for(ln_intp k=0;k<n;k++){
        ln_intp so=0,doff=0;
        for(int j=0;j<src->nd;j++){
            so+=coords[j]*snapshot->strides[j];
            doff+=coords[j]*dst->strides[j];
        }
        const char *sp=snapshot->data+so;
        char *dp=dst->data+doff;
        if(snapshot->descr==dst->descr ||
           (snapshot->descr->type_num==dst->descr->type_num &&
            snapshot->descr->elsize==dst->descr->elsize))
            memcpy(dp,sp,dst->descr->elsize);
        else if(snapshot->descr->kind==dst->descr->kind &&
                (snapshot->descr->kind=='S'||snapshot->descr->kind=='U') &&
                dst->descr->elsize>=snapshot->descr->elsize){
            memset(dp,0,dst->descr->elsize);
            memcpy(dp,sp,snapshot->descr->elsize);
        }else{
            ln_error e={{0}};
            if(ln_cast_strided_numeric(sp,0,snapshot->descr,dp,0,dst->descr,1,&e)<0){
                ln_array_free(snapshot);
                return luaL_error(L,"permuted out cast failed: %s",e.message);
            }
        }
        for(int j=src->nd-1;j>=0;j--){
            if(++coords[j]<src->dimensions[j])break;
            coords[j]=0;
        }
    }
    ln_array_free(snapshot);
    return 0;
}

static ln_array *generator_array_copy_k(lua_State *L,const ln_array *src)
{
    int fortran=((src->flags & LN_ARRAY_F_CONTIGUOUS) &&
                 !(src->flags & LN_ARRAY_C_CONTIGUOUS));
    ln_error e={{0}};
    ln_array *dst=ln_array_new(src->nd,src->dimensions,src->descr,fortran,0,&e);
    if(!dst){fail(L,&e);return NULL;}
    generator_copy_into(L,src,dst);
    return dst;
}

static uint64_t generator_stride_magnitude(ln_intp stride)
{
    return stride<0 ? (uint64_t)(-(stride+1))+UINT64_C(1) : (uint64_t)stride;
}

/* Order of axes from fastest to slowest, exactly the order traversed by
 * NumPy's ravel(order='K') on C/F/transpose-contiguous input. */
static void generator_axis_order(int nd,const ln_array *src,int *order)
{
    for(int j=0;j<nd;j++)order[j]=nd-1-j;
    for(int j=1;j<nd;j++){
        int v=order[j],k=j;
        uint64_t stride=generator_stride_magnitude(src->strides[v]);
        while(k>0 && generator_stride_magnitude(src->strides[order[k-1]])>stride){
            order[k]=order[k-1];k--;
        }
        order[k]=v;
    }
}
static ln_intp generator_flat_offset(const ln_array *dst,ln_intp idx,const int *order)
{
    ln_intp off=0;
    for(int j=0;j<dst->nd;j++){
        int ax=order[j];
        off+=(idx%dst->dimensions[ax])*dst->strides[ax];
        idx/=dst->dimensions[ax];
    }
    return off;
}
static int generator_permuted_core(lua_State *L,ln_pcg64 *rng,ln_array *dst,
                                    const ln_array *original,int is_flat,
                                    int axis,int use_dest_order)
{
    ln_intp n=ln_array_size(dst);
    if(n<0)return luaL_error(L,"permuted array is too large");
    if(n<=1)return 0;
    size_t item=dst->descr->elsize;
    char *tmp=(char*)malloc(item?item:1);
    if(!tmp)return luaL_error(L,"permuted: out of memory");
    if(is_flat){
        int order[LN_MAXDIMS];
        if(use_dest_order){
            /* For noncontiguous out, NumPy uses a C-contiguous WRITEBACKIFCOPY
             * buffer. For C/F-contiguous out, shuffle in its storage order. */
            if(!(dst->flags & (LN_ARRAY_C_CONTIGUOUS|LN_ARRAY_F_CONTIGUOUS))){
                for(int j=0;j<dst->nd;j++)order[j]=dst->nd-1-j;
            }else generator_axis_order(dst->nd,dst,order);
        }else generator_axis_order(dst->nd,original,order);
        for(ln_intp i=n-1;i>=1;i--){
            ln_intp j=(ln_intp)ln_pcg64_interval(rng,(uint64_t)i);
            ln_intp oi=generator_flat_offset(dst,i,order);
            ln_intp oj=generator_flat_offset(dst,j,order);
            if(i!=j){
                memcpy(tmp,dst->data+oj,item);
                memcpy(dst->data+oj,dst->data+oi,item);
                memcpy(dst->data+oi,tmp,item);
            }
        }
    }else{
        ln_intp axlen=dst->dimensions[axis];
        if(axlen>1){
            ln_intp fibers=n/axlen,coords[LN_MAXDIMS]={0};
            for(ln_intp fiber=0;fiber<fibers;fiber++){
                ln_intp offset=0;
                for(int d=0;d<dst->nd;d++)if(d!=axis)offset+=coords[d]*dst->strides[d];
                char *data=dst->data+offset;
                for(ln_intp i=axlen-1;i>=1;i--){
                    ln_intp j=(ln_intp)ln_pcg64_interval(rng,(uint64_t)i);
                    if(i==j)continue;
                    memcpy(tmp,data+j*dst->strides[axis],item);
                    memcpy(data+j*dst->strides[axis],data+i*dst->strides[axis],item);
                    memcpy(data+i*dst->strides[axis],tmp,item);
                }
                for(int d=dst->nd-1;d>=0;d--)if(d!=axis){
                    if(++coords[d]<dst->dimensions[d])break;
                    coords[d]=0;
                }
            }
        }
    }
    free(tmp);
    return 0;
}

static int lua_generator_permuted(lua_State *L)
{
    ln_pcg64 *rng=check_generator(L,1);
    int nargs=lua_gettop(L);
    if(nargs<2)return luaL_error(L,"missing sequence argument");
    if(nargs>4)return luaL_error(L,"permuted expects x, optional axis, and optional out");
    lua_array *u=test_array(L,2);
    if(!u){
        lua_pushcfunction(L,np_array);lua_pushvalue(L,2);
        if(lua_pcall(L,1,1,0)!=LUA_OK)
            return luaL_error(L,"cannot convert permuted input: %s",lua_tostring(L,-1));
        u=check_array(L,-1);
    }
    ln_array *src=u->a;
    int flat=(nargs<3 || (lua_type(L,3)==LUA_TNIL));
    int axis=0;
    if(!flat && normalize_lua_axis(L,luaL_checkinteger(L,3),src->nd,&axis))return 0;
    /* NumPy permits 0-D with axis=None; its shuffle on the scalar raises. */
    if(src->nd==0)return luaL_error(L,"axis is out of bounds for array of dimension 0");
    lua_array *dst_u=(nargs>=4 && !(lua_type(L,4)==LUA_TNIL))?check_array(L,4):NULL;
    ln_array *dst=NULL;
    if(dst_u){
        dst=dst_u->a;
        generator_copy_into(L,src,dst);
    }else{
        dst=generator_array_copy_k(L,src);
        if(!dst)return 0;
    }
    generator_permuted_core(L,rng,dst,src,flat,axis,dst_u!=NULL);
    if(dst_u){lua_pushvalue(L,4);return 1;}
    return push_array(L,dst);
}

/* Generator.choice: NumPy 2.5.3 selection, Lua positional arguments
 * choice(a, size=nil, replace=true, p=nil, axis=1, shuffle=true).
 * Axes are 1-based. No Python runtime or vectorized RNG bridge. */
static int generator_choice(lua_State *L)
{
    ln_pcg64 *rng=check_generator(L,1);
    int nargs=lua_gettop(L);
    if(nargs<2||nargs>7)return luaL_error(L,"choice expects a, size, replace, p, axis and shuffle");
    ln_intp shape[LN_MAXDIMS]={0};int nd=0,has_size=0;
    if(lua_random_shape(L,3,shape,&nd,&has_size))return 0;
    int replace=1,shuffle=1;
    if(nargs>=4&&lua_type(L,4)!=LUA_TNIL){if(!(lua_type(L,4)==LUA_TBOOLEAN))return luaL_error(L,"replace must be boolean");replace=lua_toboolean(L,4);}
    if(nargs>=7&&lua_type(L,7)!=LUA_TNIL){if(!(lua_type(L,7)==LUA_TBOOLEAN))return luaL_error(L,"shuffle must be boolean");shuffle=lua_toboolean(L,7);}
    int scalar_pop=lua_isinteger(L,2),axis=0;
    ln_array *population=NULL;
    ln_intp pop_size=0;
    if(scalar_pop){
        lua_Integer n=lua_tointegerx(L,2,NULL);
        if(n<0)return luaL_error(L,"population must be non-negative");
        pop_size=(ln_intp)n;
        /* NumPy ignores axis when a is an integer. */
    }else{
        lua_array *u=test_array(L,2);
        if(!u){
            lua_pushcfunction(L,np_array);lua_pushvalue(L,2);
            if(lua_pcall(L,1,1,0)!=LUA_OK)return luaL_error(L,"cannot convert choice population: %s",lua_tostring(L,-1));
            u=check_array(L,-1);
        }
        population=u->a;
        if(population->nd==0){
            double val=0;int64_t iv=0;int isint=0;ln_error e={{0}};
            if((population->descr->kind!='i'&&population->descr->kind!='u'&&population->descr->type_num!=LN_BOOL)
               || ln_array_get_number(population,NULL,&val,&iv,&isint,&e)<0 || !isint || iv<0)
                return luaL_error(L,"a must be a non-negative integer or sequence");
            pop_size=iv;scalar_pop=1;population=NULL;
        }else{
            if(nargs>=6&&lua_type(L,6)!=LUA_TNIL && normalize_lua_axis(L,luaL_checkinteger(L,6),population->nd,&axis))return 0;
            pop_size=population->dimensions[axis];
        }
    }
    ln_intp k=1;
    for(int d=0;d<nd;d++){
        if(shape[d] && k>INT64_MAX/shape[d])return luaL_error(L,"choice sample shape too large");
        k*=shape[d];
    }
    if(pop_size<=0 && k>0)return luaL_error(L,"choice population cannot be empty");
    if(!replace&&k>pop_size)return luaL_error(L,"Cannot take a larger sample than population when replace is False");
    if(pop_size<0||((uint64_t)pop_size>SIZE_MAX/sizeof(int64_t)))return luaL_error(L,"choice population too large");

    double *p=NULL, *cdf=NULL;
    int weighted=nargs>=5&&lua_type(L,5)!=LUA_TNIL;
    if(weighted){
        if(pop_size>0){p=(double*)malloc((size_t)pop_size*sizeof(double));cdf=(double*)malloc((size_t)pop_size*sizeof(double));}
        if(pop_size>0&&(!p||!cdf)){free(p);free(cdf);return luaL_error(L,"choice: out of memory");}
        lua_array *prob=test_array(L,5);
        if(prob){
            if(prob->a->nd!=1||(ln_intp)prob->a->dimensions[0]!=pop_size){free(p);free(cdf);return luaL_error(L,"a and p must have same 1-dimensional size");}
            for(ln_intp j=0;j<pop_size;j++){
                ln_intp at[1]={j};double val=0;int64_t iv=0;int isint=0;ln_error e={{0}};
                if(ln_array_get_number(prob->a,at,&val,&iv,&isint,&e)<0){free(p);free(cdf);return fail(L,&e);}
                p[j]=isint?(double)iv:val;
            }
        }else if(lua_type(L,5)==LUA_TTABLE){
            if((ln_intp)lua_rawlen(L,5)!=pop_size){free(p);free(cdf);return luaL_error(L,"a and p must have same size");}
            for(ln_intp j=0;j<pop_size;j++){
                lua_geti(L,5,(lua_Integer)j+1);
                if(!(lua_type(L,-1)==LUA_TNUMBER)){lua_pop(L,1);free(p);free(cdf);return luaL_error(L,"probabilities must be numbers");}
                p[j]=(double)lua_tonumberx(L,-1,NULL);lua_pop(L,1);
            }
        }else{free(p);free(cdf);return luaL_error(L,"p must be a table or 1-dimensional ndarray");}
        double sum=0,comp=0;ln_intp positive=0;
        for(ln_intp j=0;j<pop_size;j++){
            if(isnan(p[j])){free(p);free(cdf);return luaL_error(L,"Probabilities contain NaN");}
            if(p[j]<0){free(p);free(cdf);return luaL_error(L,"Probabilities are not non-negative");}
            if(p[j]>0)positive++;
            double y=p[j]-comp,t=sum+y;comp=(t-sum)-y;sum=t;
        }
        double tolerance=sqrt(2.2204460492503131e-16);
        if(prob && prob->a->descr->kind=='f'&&prob->a->descr->elsize==4)tolerance=sqrt(1.1920928955078125e-7);
        if(!isfinite(sum)||fabs(sum-1.)>tolerance){free(p);free(cdf);return luaL_error(L,"Probabilities do not sum to 1");}
        if(!replace&&positive<k){free(p);free(cdf);return luaL_error(L,"Fewer non-zero entries in p than size");}
    }
    if((uint64_t)k>SIZE_MAX/sizeof(int64_t)){free(p);free(cdf);return luaL_error(L,"choice sample size too large");}
    int64_t *indices=k?(int64_t*)malloc((size_t)k*sizeof(int64_t)):NULL;
    if(k&&!indices){free(p);free(cdf);return luaL_error(L,"choice: out of memory");}
    if(replace){
        if(weighted){
            double running=0;
            for(ln_intp j=0;j<pop_size;j++){running+=p[j];cdf[j]=running;}
            for(ln_intp j=0;j<pop_size;j++)cdf[j]/=running;
            for(ln_intp i=0;i<k;i++){
                double x=ln_pcg64_next_double(rng);ln_intp lo=0,hi=pop_size;
                while(lo<hi){ln_intp mid=lo+(hi-lo)/2;if(x<cdf[mid])hi=mid;else lo=mid+1;}
                indices[i]=lo<pop_size?lo:pop_size-1;
            }
        }else for(ln_intp i=0;i<k;i++)indices[i]=(int64_t)ln_pcg64_bounded64(rng,(uint64_t)pop_size-1);
    }else if(weighted){
        ln_intp count=0;
        uint8_t *seen=(uint8_t*)calloc((size_t)pop_size? (size_t)pop_size:1,1);
        if(!seen){free(indices);free(p);free(cdf);return luaL_error(L,"choice: out of memory");}
        while(count<k){
            ln_intp remaining=k-count;
            for(ln_intp i=0;i<count;i++)p[indices[i]]=0;
            double running=0;
            for(ln_intp j=0;j<pop_size;j++){running+=p[j];cdf[j]=running;}
            for(ln_intp j=0;j<pop_size;j++)cdf[j]/=running;
            memset(seen,0,(size_t)pop_size);
            for(ln_intp i=0;i<remaining;i++){
                double x=ln_pcg64_next_double(rng);ln_intp lo=0,hi=pop_size;
                while(lo<hi){ln_intp mid=lo+(hi-lo)/2;if(x<cdf[mid])hi=mid;else lo=mid+1;}
                ln_intp id=lo<pop_size?lo:pop_size-1;
                if(!seen[id]){seen[id]=1;indices[count++]=id;}
            }
        }
        free(seen);
    }else if(pop_size>10000 && k>pop_size/(shuffle?50:20)){
        int64_t *all=(int64_t*)malloc((size_t)pop_size*sizeof(int64_t));
        if(!all){free(indices);free(p);free(cdf);return luaL_error(L,"choice: out of memory");}
        for(ln_intp i=0;i<pop_size;i++)all[i]=i;
        ln_intp first=pop_size-k;if(first<1)first=1;
        for(ln_intp i=pop_size-1;i>=first;i--){
            ln_intp j=(ln_intp)ln_pcg64_bounded64(rng,(uint64_t)i);
            int64_t tmp=all[i];all[i]=all[j];all[j]=tmp;
        }
        for(ln_intp i=0;i<k;i++)indices[i]=all[pop_size-k+i];
        free(all);
    }else{
        /* Floyd sampling, preserving NumPy's exact open-addressed hash-table
         * and Lemire bounded64 draw order. */
        uint64_t mask=(uint64_t)(1.2*(double)k);
        mask|=mask>>1;mask|=mask>>2;mask|=mask>>4;mask|=mask>>8;mask|=mask>>16;mask|=mask>>32;
        if(mask==UINT64_MAX||(mask+1)>SIZE_MAX/sizeof(uint64_t)){
            free(indices);free(p);free(cdf);return luaL_error(L,"choice hash set too large");
        }
        size_t slots=(size_t)(mask+1);
        uint64_t *set=(uint64_t*)malloc(slots*sizeof(uint64_t));
        if(!set){free(indices);free(p);free(cdf);return luaL_error(L,"choice: out of memory");}
        for(size_t i=0;i<slots;i++)set[i]=UINT64_MAX;
        for(ln_intp j=pop_size-k;j<pop_size;j++){
            uint64_t v=ln_pcg64_bounded64(rng,(uint64_t)j);
            uint64_t loc=v&mask;
            while(set[loc]!=UINT64_MAX&&set[loc]!=v)loc=(loc+1)&mask;
            if(set[loc]==UINT64_MAX){set[loc]=v;indices[j-pop_size+k]=(int64_t)v;}
            else{
                loc=(uint64_t)j&mask;
                while(set[loc]!=UINT64_MAX)loc=(loc+1)&mask;
                set[loc]=(uint64_t)j;indices[j-pop_size+k]=j;
            }
        }
        free(set);
        if(shuffle)for(ln_intp i=k-1;i>=1;i--){
            ln_intp j=(ln_intp)ln_pcg64_bounded64(rng,(uint64_t)i);
            int64_t v=indices[i];indices[i]=indices[j];indices[j]=v;
        }
    }
    free(p);free(cdf);

    /* For integer a, choice produces indices. For array a, take along axis
     * and splice requested size dimensions between its other dimensions. */
    int outnd=population?population->nd-1+(has_size?nd:0):(has_size?nd:0);
    ln_intp outdims[LN_MAXDIMS]={0};
    if(outnd>LN_MAXDIMS){free(indices);return luaL_error(L,"choice result exceeds maximum dimensions");}
    if(population){
        for(int d=0;d<axis;d++)outdims[d]=population->dimensions[d];
        for(int d=0;d<(has_size?nd:0);d++)outdims[axis+d]=shape[d];
        for(int d=axis+1;d<population->nd;d++)outdims[d-1+(has_size?nd:0)]=population->dimensions[d];
    }else for(int d=0;d<(has_size?nd:0);d++)outdims[d]=shape[d];
    const ln_dtype *dtype=population?population->descr:ln_dtype_by_name("int64");
    ln_error e={{0}};
    ln_array *out=ln_array_new(outnd,outdims,dtype,0,0,&e);
    if(!out){free(indices);return fail(L,&e);}
    if(population){
        ln_intp total=ln_array_size(out),coord[LN_MAXDIMS]={0},src[LN_MAXDIMS]={0};
        size_t item=dtype->elsize;
        for(ln_intp i=0;i<total;i++){
            ln_intp pick=0;
            for(int d=0;d<(has_size?nd:0);d++)pick=pick*shape[d]+coord[axis+d];
            src[axis]=indices[pick];
            for(int d=0;d<axis;d++)src[d]=coord[d];
            for(int d=axis+1;d<population->nd;d++)src[d]=coord[d-1+(has_size?nd:0)];
            ln_intp off=0;for(int d=0;d<population->nd;d++)off+=src[d]*population->strides[d];
            memcpy(out->data+(size_t)i*item,population->data+off,item);
            for(int d=outnd-1;d>=0;d--)if(++coord[d]<outdims[d])break;else coord[d]=0;
        }
    }else for(ln_intp i=0;i<k;i++)memcpy(out->data+(size_t)i*sizeof(int64_t),&indices[i],sizeof(int64_t));
    free(indices);
    if(!has_size && outnd==0){int ret=push_scalar_at(L,out,NULL);ln_array_free(out);return ret;}
    return push_array(L,out);
}

/* NumPy 2.5.3 Generator.multivariate_normal(mean, cov, size=nil,
 * check_valid='warn', tol=1e-8, method='svd'). Lua positional API.
 * Draws all standard normals before factorizing the covariance, matching
 * NumPy's PCG64 ordering even when the factorization later fails. */
static int lua_generator_multivariate_normal(lua_State *L)
{
    ln_pcg64 *rng=check_generator(L,1);
    if(lua_gettop(L)>7)return luaL_error(L,"multivariate_normal accepts mean, cov, size, check_valid, tol and method");
    if(lua_type(L,2)==LUA_TNONE||lua_type(L,3)==LUA_TNONE)
        return luaL_error(L,"multivariate_normal requires mean and cov");
    /* Reserve positional arguments before temporary table conversions push
       ndarray userdata onto the stack. */
    lua_settop(L,7);
    ln_array *mean=broadcast_arg(L,2);
    ln_array *cov=broadcast_arg(L,3);
    if(mean->nd!=1)return luaL_error(L,"mean must be one-dimensional");
    if(cov->nd!=2||cov->dimensions[0]!=cov->dimensions[1])
        return luaL_error(L,"cov must be a square two-dimensional array");
    if(mean->dimensions[0]!=cov->dimensions[0])
        return luaL_error(L,"mean and cov must have same length");
    if((mean->descr->kind!='f'&&mean->descr->kind!='i'&&mean->descr->kind!='u'&&mean->descr->kind!='b')||
       (cov->descr->kind!='f'&&cov->descr->kind!='i'&&cov->descr->kind!='u'&&cov->descr->kind!='b'))
        return luaL_error(L,"mean and cov must be real numeric arrays");
    size_t n=(size_t)mean->dimensions[0];
    if(!n||n>INT_MAX||n>SIZE_MAX/n||n>SIZE_MAX/n/sizeof(double))
        return luaL_error(L,"invalid multivariate dimension");
    ln_intp dims[LN_MAXDIMS];int nd=0,has_size=0;
    if(lua_random_shape(L,4,dims,&nd,&has_size))return 0;
    if(nd>=LN_MAXDIMS)return luaL_error(L,"multivariate_normal exceeds maximum dimensions");
    dims[nd++]=(ln_intp)n;
    const char *check=(lua_type(L,5)==LUA_TNONE||lua_type(L,5)==LUA_TNIL)?"warn":luaL_checklstring(L,5,NULL);
    int mode=strcmp(check,"warn")==0?1:strcmp(check,"raise")==0?2:strcmp(check,"ignore")==0?0:-1;
    /* NumPy skips validation of check_valid when method=cholesky. */
    double tol=(lua_type(L,6)==LUA_TNONE||lua_type(L,6)==LUA_TNIL)?1e-8:luaL_checknumber(L,6);
    const char *method=(lua_type(L,7)==LUA_TNONE||lua_type(L,7)==LUA_TNIL)?"svd":luaL_checklstring(L,7,NULL);
    int factor_method=strcmp(method,"svd")==0?0:strcmp(method,"eigh")==0?1:strcmp(method,"cholesky")==0?2:-1;
    if(factor_method<0)return luaL_error(L,"method must be svd, eigh, or cholesky");
    if(mode<0&&factor_method!=2)return luaL_error(L,"check_valid must equal warn, raise or ignore");
    if(mode<0)mode=0;
    double *m=malloc(n*sizeof(double));
    double *c=malloc(n*n*sizeof(double));
    double *factor=malloc(n*n*sizeof(double));
    double *scratch=malloc(n*sizeof(double));
    if(!m||!c||!factor||!scratch){free(m);free(c);free(factor);free(scratch);return luaL_error(L,"out of memory allocating multivariate normal workspace");}
    ln_error err={{0}};
    for(size_t i=0;i<n;i++){
        ln_intp ix[1]={(ln_intp)i};int64_t iv=0;int isint=0;
        if(ln_array_get_number(mean,ix,&m[i],&iv,&isint,&err)<0){
            free(m);free(c);free(factor);free(scratch);return fail(L,&err);
        }
        if(isint)m[i]=(double)iv;
    }
    for(size_t i=0;i<n;i++)for(size_t j=0;j<n;j++){
        ln_intp ix[2]={(ln_intp)i,(ln_intp)j};int64_t iv=0;int isint=0;
        if(ln_array_get_number(cov,ix,&c[i*n+j],&iv,&isint,&err)<0){
            free(m);free(c);free(factor);free(scratch);return fail(L,&err);
        }
        if(isint)c[i*n+j]=(double)iv;
    }
    ln_array *out=ln_array_new(nd,dims,ln_dtype_by_num(LN_DOUBLE),0,0,&err);
    if(!out){free(m);free(c);free(factor);free(scratch);return fail(L,&err);}
    ln_intp total=ln_array_size(out);
    if(total<0){ln_array_free(out);free(m);free(c);free(factor);free(scratch);return luaL_error(L,"multivariate sample shape too large");}
    double *dst=(double*)out->data;
    for(ln_intp i=0;i<total;i++)dst[i]=ln_pcg64_standard_normal(rng);
    char errmsg[160]={0};int warning=0;
    int status=ln_mvn_factor(c,n,factor_method,mode,tol,factor,&warning,errmsg,sizeof(errmsg));
    free(c);
    if(status<0){ln_array_free(out);free(m);free(factor);free(scratch);return luaL_error(L,"%s",errmsg);}
    if(warning)fprintf(stderr,"LuaRay RuntimeWarning: covariance is not symmetric positive-semidefinite.\n");
    for(size_t r=0;r<(size_t)total/n;r++){
        memcpy(scratch,dst+r*n,n*sizeof(double));
        for(size_t j=0;j<n;j++){
            double sum=0.0;
            for(size_t k=0;k<n;k++)sum+=scratch[k]*factor[j*n+k];
            dst[r*n+j]=m[j]+sum;
        }
    }
    free(m);free(factor);free(scratch);
    return push_array(L,out);
}

static const luaL_Reg generator_funcs[]={
    {"random",lua_generator_random},{"uniform",lua_generator_uniform},
    {"integers",lua_generator_integers},
    {"standard_normal",lua_generator_standard_normal},{"normal",lua_generator_normal},
    {"standard_exponential",lua_generator_standard_exponential},{"exponential",lua_generator_exponential},
    {"lognormal",lua_generator_lognormal},{"standard_cauchy",lua_generator_standard_cauchy},
    {"laplace",lua_generator_laplace},
    {"gumbel",lua_generator_gumbel},{"logistic",lua_generator_logistic},
    {"rayleigh",lua_generator_rayleigh},{"weibull",lua_generator_weibull},
    {"pareto",lua_generator_pareto},{"power",lua_generator_power},
    {"triangular",lua_generator_triangular},
    {"standard_gamma",lua_generator_standard_gamma},{"gamma",lua_generator_gamma},{"beta",lua_generator_beta},
    {"chisquare",lua_generator_chisquare},{"f",lua_generator_f},
    {"poisson",lua_generator_poisson},{"binomial",lua_generator_binomial},
    {"negative_binomial",lua_generator_negative_binomial},{"geometric",lua_generator_geometric},
    {"zipf",lua_generator_zipf},{"hypergeometric",lua_generator_hypergeometric},
    {"multivariate_hypergeometric",lua_generator_multivariate_hypergeometric},
    {"multinomial",lua_generator_multinomial},{"dirichlet",lua_generator_dirichlet},
    {"wald",lua_generator_wald},{"logseries",lua_generator_logseries},
    {"standard_t",lua_generator_standard_t},{"vonmises",lua_generator_vonmises},
    {"noncentral_chisquare",lua_generator_noncentral_chisquare},{"noncentral_f",lua_generator_noncentral_f},
    {"shuffle",lua_generator_shuffle},{"permutation",lua_generator_permutation},
    {"permuted",lua_generator_permuted},{"choice",generator_choice},
    {"multivariate_normal",lua_generator_multivariate_normal},
    {"raw_hex",lua_generator_raw_hex},{"bytes",lua_generator_bytes},{"advance",lua_generator_advance},
    {"reseed",lua_generator_reseed},{NULL,NULL}
};


/* ndarray overlap inspection and host-facing write adapters. Actual assignment
 * traversal, aliasing and error mutation are source-derived in ln_write.c. */
static void mem97_span(const ln_array *a, uintptr_t *low, uintptr_t *high) {
    intptr_t lo=0,hi=0;
    for (int j=0;j<a->nd;j++) {
        intptr_t delta=(intptr_t)(a->dimensions[j]-1)*a->strides[j];
        if(delta<0)lo+=delta;else hi+=delta;
    }
    *low=(uintptr_t)(a->data+lo);
    *high=(uintptr_t)(a->data+hi)+(size_t)a->descr->elsize;
}
static int mem97_may_overlap(const ln_array *a,const ln_array *b) {
    if(!ln_array_size(a)||!ln_array_size(b)||!a->owner||a->owner!=b->owner)return 0;
    uintptr_t al,ah,bl,bh;mem97_span(a,&al,&ah);mem97_span(b,&bl,&bh);
    return al<bh && bl<ah;
}
static int mem97_next(int nd,const ln_intp *dims,ln_intp *ix) {
    for(int j=nd-1;j>=0;j--) {if(++ix[j]<dims[j])return 1;ix[j]=0;}
    return 0;
}
static int np_may_share_memory(lua_State *L) {
    const ln_array *a=check_array(L,1)->a,*b=check_array(L,2)->a;
    lua_pushboolean(L,mem97_may_overlap(a,b));return 1;
}
static int np_shares_memory(lua_State *L) {
    const ln_array *a=check_array(L,1)->a,*b=check_array(L,2)->a;
    if(!mem97_may_overlap(a,b)){lua_pushboolean(L,0);return 1;}
    if(a==b || ((a->flags&LN_ARRAY_C_CONTIGUOUS || a->flags&LN_ARRAY_F_CONTIGUOUS) &&
                (b->flags&LN_ARRAY_C_CONTIGUOUS || b->flags&LN_ARRAY_F_CONTIGUOUS))){
        lua_pushboolean(L,1);return 1;
    }
    ln_intp na=ln_array_size(a),nb=ln_array_size(b);
    if(na>1000000 || nb>1000000)return luaL_error(L,"exact memory overlap exceeds current work limit");
    uintptr_t al,ah,bl,bh;mem97_span(a,&al,&ah);mem97_span(b,&bl,&bh);
    uintptr_t low=al>bl?al:bl,high=ah<bh?ah:bh;
    if(high<=low){lua_pushboolean(L,0);return 1;}
    size_t span=(size_t)(high-low);
    if(span>64u*1024u*1024u)return luaL_error(L,"exact memory overlap exceeds current memory limit");
    unsigned char *map=(unsigned char*)calloc(span,1);
    if(!map)return luaL_error(L,"out of memory checking shared memory");
    ln_intp ix[LN_MAXDIMS]={0};
    for(ln_intp k=0;k<na;k++) {
        uintptr_t p=(uintptr_t)array_ptr_local(a,ix),end=p+a->descr->elsize;
        if(p<high && end>low) {
            uintptr_t from=p>low?p:low,to=end<high?end:high;
            memset(map+(size_t)(from-low),1,(size_t)(to-from));
        }
        mem97_next(a->nd,a->dimensions,ix);
    }
    memset(ix,0,sizeof(ix));int found=0;
    for(ln_intp k=0;k<nb && !found;k++) {
        uintptr_t p=(uintptr_t)array_ptr_local(b,ix),end=p+b->descr->elsize;
        if(p<high && end>low) {
            uintptr_t from=p>low?p:low,to=end<high?end:high;
            for(uintptr_t q=from;q<to;q++)if(map[(size_t)(q-low)]){found=1;break;}
        }
        mem97_next(b->nd,b->dimensions,ix);
    }
    free(map);lua_pushboolean(L,found);return 1;
}
static int mem97_load_where(lua_State *L,int arg,const ln_array **where,int *scalar_where){
    *where=NULL;*scalar_where=1;
    if(lua_type(L,arg)==LUA_TNONE || lua_type(L,arg)==LUA_TNIL)return 0;
    if(lua_type(L,arg)==LUA_TBOOLEAN){*scalar_where=lua_toboolean(L,arg);return 0;}
    lua_array *u=test_array(L,arg);
    *where=(u && u->a->descr->type_num==LN_BOOL)?u->a:write98_arg(L,arg,ln_dtype_by_num(LN_BOOL),LN_SAFE_CASTING);
    return 0;
}
static int mem97_scalar_integer_fits(int64_t x,const ln_dtype *d){
    int n=d->type_num;
    int signed_int=n==LN_BYTE||n==LN_SHORT||n==LN_INT||n==LN_LONG||n==LN_LONGLONG;
    int unsigned_int=n==LN_UBYTE||n==LN_USHORT||n==LN_UINT||n==LN_ULONG||n==LN_ULONGLONG;
    if(!signed_int&&!unsigned_int)return 1;
    unsigned bits=(unsigned)d->elsize*8;
    if(signed_int){if(bits>=64)return 1;
        int64_t lim=(int64_t)1<<(bits-1);
        return x>=-lim&&x<lim;
    }
    if(x<0)return 0;
    if(bits>=64)return 1;
    return (uint64_t)x<((uint64_t)1<<bits);
}
static int np_copyto(lua_State *L) {
    int nargs=lua_gettop(L);
    ln_array *dst=check_array(L,1)->a;
    if(lua_gettop(L)<2 || lua_type(L,2)==LUA_TNIL)return luaL_error(L,"copyto requires a source");
    const ln_array *where=NULL;
    ln_casting casting=LN_SAME_KIND_CASTING;
    int scalar_where=1;
    if(read_casting_arg(L,3,casting,&casting))return 0;
    const ln_array *src=broadcast_arg(L,2);
    ln_error e={{0}};
    int weak_number=lua_type(L,2)==LUA_TNUMBER;
    lua_complex *complex=test_complex(L,2);
    if(weak_number || complex) {
        const ln_dtype *chosen=src->descr;
        if(dst->descr->kind=='m' && !(weak_number && !lua_isinteger(L,2) && isnan(lua_tonumberx(L,2,NULL))))chosen=dst->descr;
        else if(dst->descr->kind=='b'||dst->descr->kind=='i'||dst->descr->kind=='u'||dst->descr->kind=='f'||dst->descr->kind=='c') {
            if(complex)chosen=ln_resolve_weak_complex_dtype(dst,LN_OP_ADD,&e);
            else chosen=ln_resolve_weak_scalar_dtype(dst,lua_isinteger(L,2),lua_isinteger(L,2)?lua_tointegerx(L,2,NULL):0,LN_OP_ADD,&e);
            if(!chosen)return fail(L,&e);
        }
        if(casting==LN_EQUIV_CASTING && chosen!=src->descr)return luaL_error(L,"cannot cast Lua scalar under equiv casting");
        src=write98_arg(L,2,chosen,LN_UNSAFE_CASTING);
    }
    if(nargs>=4)mem97_load_where(L,4,&where,&scalar_where);
    return ln_array_copyto(dst,src,where,scalar_where,casting,&e)<0?fail(L,&e):0;
}
/* Python scalars/sequences are converted directly to the requested descriptor,
 * whereas ndarray operands obey the selected casting rule. Preserve that
 * distinction and keep every temporary rooted on Lua's stack across errors. */
static void write98_check_lua_bounds(lua_State *L, int arg, const ln_dtype *dtype, int depth) {
    arg=lua_absindex(L,arg);
    if(depth>LN_MAXDIMS)luaL_error(L,"maximum supported dimension exceeded");
    if(lua_type(L,arg)==LUA_TTABLE) {
        for(size_t i=1;i<=lua_rawlen(L,arg);++i) {
            lua_geti(L,arg,(lua_Integer)i);write98_check_lua_bounds(L,-1,dtype,depth+1);lua_pop(L,1);
        }
    }
    else if(dtype->kind=='i' || dtype->kind=='u') {
        if(lua_isinteger(L,arg) && !mem97_scalar_integer_fits((int64_t)lua_tointegerx(L,arg,NULL),dtype))
            luaL_error(L,"integer scalar out of bounds for destination dtype");
        if(lua_type(L,arg)==LUA_TNUMBER && !lua_isinteger(L,arg) && !isfinite(lua_tonumberx(L,arg,NULL)))
            luaL_error(L,"cannot convert nonfinite Lua number to integer");
    }
}
static void write98_fill(lua_State *L,int arg,ln_array *a,int depth,ln_intp *indices) {
    arg=lua_absindex(L,arg);
    if(depth<a->nd) {
        luaL_checktype(L,arg,LUA_TTABLE);
        if((ln_intp)lua_rawlen(L,arg)!=a->dimensions[depth])luaL_error(L,"inhomogeneous array shape");
        for(size_t i=1;i<=lua_rawlen(L,arg);++i) {
            indices[depth]=(ln_intp)i-1;lua_geti(L,arg,(lua_Integer)i);
            write98_fill(L,-1,a,depth+1,indices);lua_pop(L,1);
        }
    }
    else if(a->descr->kind=='b' && test_complex(L,arg)) {
        lua_complex *z=test_complex(L,arg);ln_error err={{0}};
        if(ln_array_pack_number(a,indices,0,z->real!=0 || z->imag!=0,1,&err)<0)fail(L,&err);
    }
    else if(lua_type(L,arg)==LUA_TSTRING && !ln_string_is_dtype(a->descr) && a->descr->kind!='M') {
        size_t n=0;const char *s=lua_tolstring(L,arg,&n);ln_error err={{0}};
        if(a->descr->kind=='b') {
            if(ln_array_pack_number(a,indices,0,n!=0,1,&err)<0)fail(L,&err);
        }
        else if(a->descr->kind=='m' && n==0) {
            if(ln_array_pack_number(a,indices,0,LN_DATETIME_NAT,1,&err)<0)fail(L,&err);
        }
        else {
            const char *nonspace=s;while(*nonspace && isspace((unsigned char)*nonspace))++nonspace;
            if(!*nonspace)luaL_error(L,"cannot convert empty string to numeric dtype");
            const ln_dtype *str=ln_string_make_dtype(0,n,'=',&err);
            if(!str || ln_cast_strided_numeric(s,0,str,array_ptr_local(a,indices),0,a->descr,1,&err)<0)fail(L,&err);
        }
    }
    else fill_table(L,arg,a,depth,indices);
}
static ln_array *write98_arg(lua_State *L,int arg,const ln_dtype *dtype,ln_casting casting) {
    lua_array *u=test_array(L,arg);
    if(u) {
        if(u->a->descr==dtype && (u->a->flags&LN_ARRAY_C_CONTIGUOUS))return u->a;
        ln_error err={{0}};ln_array *a=array_cast_new(u->a,dtype,casting,'C',&err);
        if(!a){fail(L,&err);return NULL;}
        push_array(L,a);return a;
    }
    write98_check_lua_bounds(L,arg,dtype,0);
    ln_intp dims[LN_MAXDIMS],indices[LN_MAXDIMS]={0};int nd=0;
    for(int d=0;d<LN_MAXDIMS;++d)dims[d]=-1;
    infer_table_shape(L,arg,0,dims,&nd);
    ln_error err={{0}};ln_array *a=ln_array_new(nd,dims,dtype,0,0,&err);
    if(!a){fail(L,&err);return NULL;}
    push_array(L,a);write98_fill(L,arg,a,0,indices);return a;
}
static int np_put(lua_State *L) {
    ln_array *dst=check_array(L,1)->a;
    if(lua_gettop(L)<3 || lua_type(L,2)==LUA_TNIL || lua_type(L,3)==LUA_TNIL)return luaL_error(L,"put requires indices and values");
    if(!(dst->flags&LN_ARRAY_WRITEABLE))return luaL_error(L,"put destination is read-only");
    ln_put_mode mode=LN_PUT_RAISE;
    if(lua_gettop(L)>=4 && lua_type(L,4)!=LUA_TNIL) {
        luaL_checktype(L,4,LUA_TSTRING);const char *name=lua_tostring(L,4);
        if(strcmp(name,"wrap")==0)mode=LN_PUT_WRAP;
        else if(strcmp(name,"clip")==0)mode=LN_PUT_CLIP;
        else if(strcmp(name,"raise")!=0)return luaL_error(L,"put mode must be 'raise', 'wrap' or 'clip'");
    }
    ln_array *indices=write98_arg(L,2,ln_dtype_by_name(sizeof(ln_intp)==8?"int64":"int32"),LN_SAFE_CASTING);
    if(ln_array_size(indices)>0 && !ln_array_size(dst))return luaL_error(L,"cannot replace elements of an empty array");
    ln_array *values=write98_arg(L,3,dst->descr,LN_UNSAFE_CASTING);
    ln_error err={{0}};
    return ln_array_put(dst,indices,values,mode,&err)<0?fail(L,&err):0;
}
static int np_place(lua_State *L) {
    ln_array *dst=check_array(L,1)->a;
    if(lua_gettop(L)<3 || lua_type(L,2)==LUA_TNIL || lua_type(L,3)==LUA_TNIL)return luaL_error(L,"place requires mask and values");
    if(!(dst->flags&LN_ARRAY_WRITEABLE))return luaL_error(L,"place destination is read-only");
    ln_array *mask=write98_arg(L,2,ln_dtype_by_num(LN_BOOL),LN_UNSAFE_CASTING);
    if(ln_array_size(mask)!=ln_array_size(dst))return luaL_error(L,"place mask and data must be the same size");
    ln_array *values=write98_arg(L,3,dst->descr,LN_SAFE_CASTING);
    ln_error err={{0}};
    return ln_array_place(dst,mask,values,&err)<0?fail(L,&err):0;
}
static int np_take(lua_State *L) {
    int nargs=lua_gettop(L);
    if(nargs<2 || nargs>3 || lua_type(L,2)==LUA_TNIL)return luaL_error(L,"take expects input, indices and optional axis/options");
    const ln_array *input=broadcast_arg(L,1);
    int axis=-1;ln_take_mode mode=LN_TAKE_RAISE;lua_array *out=NULL;
    if(nargs>=3 && lua_type(L,3)!=LUA_TNIL) {
        if(lua_type(L,3)==LUA_TTABLE) {
            lua_getfield(L,3,"axis");
            if(lua_type(L,-1)!=LUA_TNIL && !(lua_type(L,-1)==LUA_TBOOLEAN && !lua_toboolean(L,-1))) {
                int ok=0;lua_Integer value=lua_tointegerx(L,-1,&ok);
                if(!ok)return luaL_error(L,"take axis must be an integer, false or nil");
                normalize_lua_axis(L,value,input->nd?input->nd:1,&axis);
            }
            lua_pop(L,1);lua_getfield(L,3,"mode");
            if(lua_type(L,-1)!=LUA_TNIL) {
                luaL_checktype(L,-1,LUA_TSTRING);const char *name=lua_tostring(L,-1);
                if(strcmp(name,"wrap")==0)mode=LN_TAKE_WRAP;
                else if(strcmp(name,"clip")==0)mode=LN_TAKE_CLIP;
                else if(strcmp(name,"raise")!=0)return luaL_error(L,"take mode must be 'raise', 'wrap' or 'clip'");
            }
            lua_pop(L,1);lua_getfield(L,3,"out");
            if(lua_type(L,-1)!=LUA_TNIL){out=test_array(L,-1);if(!out)return luaL_error(L,"take out must be an ndarray");}
            lua_pop(L,1);
        }
        else if(!(lua_type(L,3)==LUA_TBOOLEAN && !lua_toboolean(L,3))) {
            int ok=0;lua_Integer value=lua_tointegerx(L,3,&ok);
            if(!ok)return luaL_error(L,"take axis must be an integer, false or options table");
            normalize_lua_axis(L,value,input->nd?input->nd:1,&axis);
        }
    }
    ln_array *indices=write98_arg(L,2,ln_dtype_by_name(sizeof(ln_intp)==8?"int64":"int32"),LN_SAME_KIND_CASTING);
    ln_error err={{0}};ln_array *result=ln_array_take(input,indices,axis,mode,out?out->a:NULL,&err);
    if(!result)return fail(L,&err);
    if(out){lua_getfield(L,3,"out");return 1;}
    if(result->nd==0) {
        int ret=push_scalar_at(L,result,NULL);ln_array_free(result);return ret;
    }
    return push_array(L,result);
}
static int along_axis_arg(lua_State *L,int arg,int nargs,int nd,int default_last) {
    if(nargs<arg) {
        if(!default_last)luaL_error(L,"put_along_axis requires an axis or false for flattening");
        if(nd==0)luaL_error(L,"along-axis axis out of bounds");
        return nd-1;
    }
    if(lua_type(L,arg)==LUA_TNIL || (lua_type(L,arg)==LUA_TBOOLEAN && !lua_toboolean(L,arg)))return -1;
    int axis=0,ok=0;lua_Integer value=lua_tointegerx(L,arg,&ok);
    if(!ok)luaL_error(L,"along-axis axis must be an integer, false or nil");
    normalize_lua_axis(L,value,nd,&axis);return axis;
}
static int np_take_along_axis(lua_State *L) {
    int nargs=lua_gettop(L);
    if(nargs<2 || nargs>3)return luaL_error(L,"take_along_axis expects input, indices and optional axis");
    const ln_array *input=broadcast_arg(L,1);
    int axis=along_axis_arg(L,3,nargs,input->nd,1);
    const ln_array *indices=broadcast_arg(L,2);
    ln_error err={{0}};ln_array *result=ln_array_take_along_axis(input,indices,axis,&err);
    if(!result)return fail(L,&err);
    return push_array(L,result);
}
static int np_put_along_axis(lua_State *L) {
    int nargs=lua_gettop(L);
    if(nargs!=4)return luaL_error(L,"put_along_axis expects input, indices, values and axis");
    ln_array *input=check_array(L,1)->a;
    int axis=along_axis_arg(L,4,nargs,input->nd,0);
    const ln_array *indices=broadcast_arg(L,2);
    lua_array *typed_values=test_array(L,3);
    const ln_array *values=typed_values?typed_values->a:write98_arg(L,3,input->descr,LN_UNSAFE_CASTING);
    ln_error err={{0}};
    return ln_array_put_along_axis(input,indices,values,axis,&err)<0?fail(L,&err):0;
}
/* Shared NEP50 common-dtype preparation for selection operations. Preserve
 * numeric Lua scalars as weak values; bool/string/table inputs become arrays. */
static const ln_dtype *selection_common_dtype(lua_State *L,int *positions,size_t n) {
    int weak=0,non_numeric=0;
    for(size_t j=0;j<n;++j) {
        int pos=positions[j];
        if(lua_type(L,pos)==LUA_TNUMBER || test_complex(L,pos))weak=1;
        else {
            const ln_array *a=broadcast_arg(L,pos);
            if(a->descr->kind=='S' || a->descr->kind=='U' || a->descr->kind=='M')non_numeric=1;
            if(!test_array(L,pos))positions[j]=lua_gettop(L);
        }
    }
    if(weak && non_numeric && n>1)luaL_error(L,"weak numeric values have no common string/datetime dtype");
    lua_pushcfunction(L,np_result_type);
    for(size_t j=0;j<n;++j)lua_pushvalue(L,positions[j]);
    if(lua_pcall(L,(int)n,1,0)!=LUA_OK)luaL_error(L,"selection dtype: %s",lua_tostring(L,-1));
    const ln_dtype *dtype=ln_dtype_by_name(lua_tostring(L,-1));lua_pop(L,1);
    if(!dtype)luaL_error(L,"selection dtype could not be resolved");
    return dtype;
}
/* Array-converter sequence API: n may be positional or in an options table.
 * All temporaries are rooted on the Lua stack before any native execution. */
static int sampling_function(lua_State *L,int kind) {
    int argc=lua_gettop(L);
    if(argc<2||argc>4)return luaL_error(L,"sampling expects start, stop, optional count and options");
    int options=0,npos=0;ln_intp count=50;int endpoint=1,retstep=0;
    lua_Integer raw_axis=1;const ln_dtype *output_dtype=NULL;
    if(argc>=3&&lua_type(L,3)!=LUA_TNIL) {
        if(lua_type(L,3)==LUA_TTABLE)options=3;
        else npos=3;
    }
    if(argc==4&&lua_type(L,4)!=LUA_TNIL) {
        if(options||lua_type(L,4)!=LUA_TTABLE)return luaL_error(L,"sampling options must be one table");
        options=4;
    }
    if(options) {
        lua_pushnil(L);
        while(lua_next(L,options)) {
            const char *key=lua_type(L,-2)==LUA_TSTRING?lua_tostring(L,-2):NULL;
            if(!key||(strcmp(key,"num")&&strcmp(key,"endpoint")&&strcmp(key,"axis")&&
                strcmp(key,"dtype")&&strcmp(key,"retstep")&&strcmp(key,"base")))
                return luaL_error(L,"unknown sampling option");
            if(!strcmp(key,"base")&&kind!=1)return luaL_error(L,"base is supported by logspace only");
            lua_pop(L,1);
        }
        lua_getfield(L,options,"num");
        if(lua_type(L,-1)!=LUA_TNIL) {
            if(npos)return luaL_error(L,"count specified twice");
            npos=lua_gettop(L);
        }else lua_pop(L,1);
        lua_getfield(L,options,"endpoint");
        if(lua_type(L,-1)!=LUA_TNIL){luaL_checktype(L,-1,LUA_TBOOLEAN);endpoint=lua_toboolean(L,-1);}lua_pop(L,1);
        lua_getfield(L,options,"retstep");
        if(lua_type(L,-1)!=LUA_TNIL){
            if(kind!=0)return luaL_error(L,"retstep is supported by linspace only");
            luaL_checktype(L,-1,LUA_TBOOLEAN);retstep=lua_toboolean(L,-1);
        }lua_pop(L,1);
        lua_getfield(L,options,"axis");
        if(lua_type(L,-1)!=LUA_TNIL){if(!lua_isinteger(L,-1))return luaL_error(L,"sampling axis must be an integer");raw_axis=lua_tointegerx(L,-1,NULL);}lua_pop(L,1);
        lua_getfield(L,options,"dtype");
        if(lua_type(L,-1)!=LUA_TNIL){output_dtype=ln_dtype_by_name(luaL_checklstring(L,-1,NULL));if(!output_dtype)return luaL_error(L,"unsupported sampling dtype");}lua_pop(L,1);
    }
    if(npos) {
        if(lua_type(L,npos)==LUA_TBOOLEAN)count=lua_toboolean(L,npos);
        else if(lua_isinteger(L,npos))count=(ln_intp)lua_tointegerx(L,npos,NULL);
        else return luaL_error(L,"sample count must be an integer");
    }
    if(count<0)return luaL_error(L,"sample count must be non-negative");
    const ln_dtype *compute_dtype=NULL;const ln_array *start,*stop;
    if(kind==2) {
        start=broadcast_arg(L,1);stop=broadcast_arg(L,2);
        compute_dtype=ln_promote_dtype(start->descr,stop->descr);
        if(compute_dtype)compute_dtype=ln_promote_dtype(compute_dtype,output_dtype?output_dtype:ln_dtype_by_num(LN_DOUBLE));
    }
    else {
        int positions[]={1,2};compute_dtype=selection_common_dtype(L,positions,2);
        start=broadcast_arg(L,positions[0]);stop=broadcast_arg(L,positions[1]);
        if(lua_type(L,1)==LUA_TNUMBER||test_complex(L,1))start=write98_arg(L,1,compute_dtype,LN_UNSAFE_CASTING);
        if(lua_type(L,2)==LUA_TNUMBER||test_complex(L,2))stop=write98_arg(L,2,compute_dtype,LN_UNSAFE_CASTING);
    }
    if(compute_dtype&&(compute_dtype->kind=='b'||compute_dtype->kind=='i'||compute_dtype->kind=='u'))compute_dtype=ln_dtype_by_num(LN_DOUBLE);
    if(!compute_dtype||(compute_dtype->kind!='f'&&compute_dtype->kind!='c'))return luaL_error(L,"sampling requires numeric endpoints");
    ln_ufunc_operand base={.kind=LN_UFUNC_WEAK_FLOAT,.floating=10.0};
    int ndim=start->nd>stop->nd?start->nd:stop->nd;
    if(kind==1&&options) {
        lua_getfield(L,options,"base");int pos=lua_gettop(L);
        if(lua_type(L,pos)!=LUA_TNIL) {
            lua_complex *z=test_complex(L,pos);
            if(z){base.kind=LN_UFUNC_WEAK_COMPLEX;base.real=z->real;base.imag=z->imag;}
            else if(lua_isinteger(L,pos)){base.kind=LN_UFUNC_WEAK_INT;base.integer=lua_tointegerx(L,pos,NULL);}
            else if(lua_type(L,pos)==LUA_TNUMBER){base.kind=LN_UFUNC_WEAK_FLOAT;base.floating=lua_tonumberx(L,pos,NULL);}
            else if(lua_type(L,pos)==LUA_TBOOLEAN){base.kind=LN_UFUNC_WEAK_BOOL;base.boolean=lua_toboolean(L,pos);}
            else {base.kind=LN_UFUNC_OPERAND_ARRAY;base.array=broadcast_arg(L,pos);if(base.array->nd>ndim)ndim=base.array->nd;}
        }
    }
    if(ndim>=LN_MAXDIMS)return luaL_error(L,"sampling result exceeds maximum rank");
    int axis=0;normalize_lua_axis(L,raw_axis,ndim+1,&axis);
    ln_error err={{0}};ln_array *result=NULL,*step=NULL;
    if(kind==0)result=ln_sampling_linspace(start,stop,count,endpoint,axis,compute_dtype,output_dtype,retstep?&step:NULL,&err);
    else if(kind==1)result=ln_sampling_logspace(start,stop,&base,count,endpoint,axis,compute_dtype,output_dtype,&err);
    else result=ln_sampling_geomspace(start,stop,count,endpoint,axis,compute_dtype,output_dtype,&err);
    if(!result)return fail(L,&err);
    push_array(L,result);
    if(retstep) {
        if(step->nd==0){push_array(L,step);push_scalar_at(L,step,NULL);lua_remove(L,-2);}
        else push_array(L,step);
        return 2;
    }
    return 1;
}
static int np_linspace(lua_State *L){return sampling_function(L,0);}
static int np_logspace(lua_State *L){return sampling_function(L,1);}
static int np_geomspace(lua_State *L){return sampling_function(L,2);}

/* Sequence iteration over an ndarray keeps scalar items as strong 0-D views. */
static ln_array *selection_array_item(const ln_array *array,size_t j,ln_error *err) {
    char *data=array->data;
    if(ln_array_size(array)>0)data+=(ln_intp)j*array->strides[0];
    return ln_array_view(array,array->nd-1,array->dimensions+1,array->strides+1,data,err);
}
static int np_choose(lua_State *L) {
    int nargs=lua_gettop(L);
    if(nargs<2 || nargs>3)return luaL_error(L,"choose expects indices, choices and optional mode/options");
    ln_take_mode mode=LN_TAKE_RAISE;lua_array *out=NULL;
    if(nargs==3 && lua_type(L,3)!=LUA_TNIL) {
        if(lua_type(L,3)==LUA_TTABLE) {
            lua_getfield(L,3,"out");
            if(lua_type(L,-1)!=LUA_TNIL){out=test_array(L,-1);if(!out)return luaL_error(L,"choose out must be an ndarray");}
            lua_pop(L,1);lua_getfield(L,3,"mode");
        }
        else lua_pushvalue(L,3);
        if(lua_type(L,-1)!=LUA_TNIL) {
            const char *name=luaL_checklstring(L,-1,NULL);
            if(strcmp(name,"wrap")==0)mode=LN_TAKE_WRAP;
            else if(strcmp(name,"clip")==0)mode=LN_TAKE_CLIP;
            else if(strcmp(name,"raise")!=0)return luaL_error(L,"choose mode must be raise, wrap or clip");
        }
        lua_pop(L,1);
    }
    lua_array *outer=test_array(L,2);
    size_t n=outer?(outer->a->nd?(size_t)outer->a->dimensions[0]:0):
        (luaL_checktype(L,2,LUA_TTABLE),lua_rawlen(L,2));
    if(!n || n>=64)return luaL_error(L,"choose requires between 1 and 63 choices");
    luaL_checkstack(L,(int)n*3+16,"too many choose operands");
    int positions[63];
    const ln_array *choices[63];
    for(size_t j=0;j<n;++j) {
        if(outer) {
            ln_error err={{0}};ln_array *view=selection_array_item(outer->a,j,&err);
            if(!view)return fail(L,&err);
            push_array(L,view);
        }
        else lua_geti(L,2,(lua_Integer)j+1);
        positions[j]=lua_gettop(L);
    }
    const ln_dtype *dtype=selection_common_dtype(L,positions,n);
    for(size_t j=0;j<n;++j) {
        if(lua_type(L,positions[j])==LUA_TNUMBER || test_complex(L,positions[j])) {
            const ln_array *scalar=broadcast_arg(L,positions[j]);
            ln_error err={{0}};
            ln_array *converted=array_cast_new(scalar,dtype,LN_UNSAFE_CASTING,'C',&err);
            if(!converted)return fail(L,&err);
            push_array(L,converted);choices[j]=converted;
        }
        else choices[j]=write98_arg(L,positions[j],dtype,LN_SAFE_CASTING);
        int flags=LN_ARRAY_C_CONTIGUOUS|LN_ARRAY_ALIGNED|LN_ARRAY_WRITEABLE;
        if((choices[j]->flags&flags)!=flags) {
            ln_error err={{0}};ln_array *copy=ln_array_copy_c(choices[j],&err);
            if(!copy)return fail(L,&err);
            push_array(L,copy);choices[j]=copy;
        }
    }
    const ln_array *raw=broadcast_arg(L,1);
    ln_error err={{0}};
    const ln_dtype *intp=ln_dtype_by_name(sizeof(ln_intp)==8?"int64":"int32");
    ln_array *indices=(ln_array *)raw;
    if(raw->descr!=intp) {
        indices=array_cast_new(raw,intp,LN_SAFE_CASTING,'C',&err);
        if(!indices)return fail(L,&err);
        push_array(L,indices);
    }
    ln_array *result=ln_array_choose(indices,choices,(int)n,mode,out?out->a:NULL,&err);
    if(!result)return fail(L,&err);
    if(out){lua_getfield(L,3,"out");return 1;}
    if(result->nd==0){int rc=push_scalar_at(L,result,NULL);ln_array_free(result);return rc;}
    return push_array(L,result);
}
static int nonzero_function(lua_State *L,int flatten) {
    if(lua_gettop(L)!=1)return luaL_error(L,"nonzero expects one input");
    const ln_array *input=broadcast_arg(L,1);
    ln_array *coordinates[LN_MAXDIMS];int count=0;ln_error err={{0}};
    if(ln_array_condition_nonzero(input,flatten,coordinates,&count,&err)<0)return fail(L,&err);
    if(flatten)return push_array(L,coordinates[0]);
    lua_createtable(L,count,0);
    for(int d=0;d<count;++d){push_array(L,coordinates[d]);lua_seti(L,-2,d+1);}
    return 1;
}
static int np_nonzero(lua_State *L){return nonzero_function(L,0);}
static int np_flatnonzero(lua_State *L){return nonzero_function(L,1);}
static int compress_function(lua_State *L,int method) {
    int nargs=lua_gettop(L),input_arg=method?1:2,condition_arg=method?2:1;
    if(nargs<2 || nargs>3)return luaL_error(L,"compress expects condition, input and optional axis/options");
    const ln_array *input=broadcast_arg(L,input_arg);
    int axis=-1;lua_array *out=NULL;
    if(nargs==3 && lua_type(L,3)!=LUA_TNIL) {
        if(lua_type(L,3)==LUA_TTABLE) {
            lua_getfield(L,3,"axis");
            if(lua_type(L,-1)!=LUA_TNIL && !(lua_type(L,-1)==LUA_TBOOLEAN && !lua_toboolean(L,-1)))
                normalize_lua_axis(L,luaL_checkinteger(L,-1),input->nd?input->nd:1,&axis);
            lua_pop(L,1);lua_getfield(L,3,"out");
            if(lua_type(L,-1)!=LUA_TNIL){out=test_array(L,-1);if(!out)return luaL_error(L,"compress out must be an ndarray");}
            lua_pop(L,1);
        }
        else if(!(lua_type(L,3)==LUA_TBOOLEAN && !lua_toboolean(L,3)))
            normalize_lua_axis(L,luaL_checkinteger(L,3),input->nd?input->nd:1,&axis);
    }
    lua_array *typed_condition=test_array(L,condition_arg);
    const ln_array *condition=typed_condition?typed_condition->a:
        write98_arg(L,condition_arg,ln_dtype_by_num(LN_BOOL),LN_UNSAFE_CASTING);
    ln_error err={{0}};
    ln_array *result=ln_array_compress_condition(input,condition,1,axis,out?out->a:NULL,&err);
    if(!result)return fail(L,&err);
    if(out){lua_getfield(L,3,"out");return 1;}
    return push_array(L,result);
}
static int np_compress(lua_State *L){return compress_function(L,0);}
static int array_compress(lua_State *L){return compress_function(L,1);}
static int np_extract(lua_State *L) {
    if(lua_gettop(L)!=2)return luaL_error(L,"extract expects condition and input");
    const ln_array *condition=broadcast_arg(L,1),*input=broadcast_arg(L,2);
    ln_error err={{0}};ln_array *result=ln_array_compress_condition(input,condition,0,-1,NULL,&err);
    if(!result)return fail(L,&err);
    return push_array(L,result);
}
static int np_where(lua_State *L) {
    int nargs=lua_gettop(L);
    if(nargs==1)return np_nonzero(L);
    if(nargs!=3)return luaL_error(L,"where requires either one or three operands");
    const ln_array *condition=broadcast_arg(L,1);
    int positions[]={2,3};
    const ln_dtype *dtype=selection_common_dtype(L,positions,2);
    const ln_array *values[2];
    for(int j=0;j<2;++j) {
        if(lua_type(L,positions[j])==LUA_TNUMBER || test_complex(L,positions[j]))
            values[j]=write98_arg(L,positions[j],dtype,LN_UNSAFE_CASTING);
        else values[j]=broadcast_arg(L,positions[j]);
    }
    ln_error err={{0}};ln_array *result=ln_array_where(condition,values[0],values[1],dtype,&err);
    if(!result)return fail(L,&err);
    return push_array(L,result);
}
static size_t selection_sequence_length(lua_State *L,int arg) {
    lua_array *outer=test_array(L,arg);
    if(outer) {
        if(outer->a->nd==0)luaL_error(L,"selection lists must have at least one dimension");
        return (size_t)outer->a->dimensions[0];
    }
    luaL_checktype(L,arg,LUA_TTABLE);return lua_rawlen(L,arg);
}
static int selection_sequence_item(lua_State *L,int arg,size_t j) {
    lua_array *outer=test_array(L,arg);
    if(outer) {
        ln_error err={{0}};ln_array *view=selection_array_item(outer->a,j,&err);
        if(!view)return fail(L,&err);
        push_array(L,view);
    }
    else lua_geti(L,arg,(lua_Integer)j+1);
    return lua_gettop(L);
}
static int np_select(lua_State *L) {
    int nargs=lua_gettop(L);
    if(nargs<2 || nargs>3)return luaL_error(L,"select expects condition list, choice list and optional default");
    size_t n=selection_sequence_length(L,1);
    if(!n || selection_sequence_length(L,2)!=n)return luaL_error(L,"select requires equal nonempty condition and choice lists");
    if(n>(INT_MAX-64)/6)return luaL_error(L,"select operand list is too large");
    luaL_checkstack(L,(int)n*6+64,"too many select operands");
    if(nargs==2)lua_pushinteger(L,0);
    int *positions=lua_newuserdatauv(L,(n+1)*sizeof(int),0);
    const ln_array **conditions=lua_newuserdatauv(L,n*sizeof(*conditions),0);
    const ln_array **choices=lua_newuserdatauv(L,n*sizeof(*choices),0);
    for(size_t j=0;j<n;++j) {
        int cpos=selection_sequence_item(L,1,j);
        conditions[j]=broadcast_arg(L,cpos);
        positions[j]=selection_sequence_item(L,2,j);
    }
    positions[n]=3;
    const ln_dtype *dtype=selection_common_dtype(L,positions,n+1);
    for(size_t j=0;j<n;++j)choices[j]=broadcast_arg(L,positions[j]);
    const ln_array *default_value=broadcast_arg(L,positions[n]);
    ln_error err={{0}};ln_array *result=ln_array_select(conditions,choices,(int)n,default_value,dtype,&err);
    if(!result)return fail(L,&err);
    return push_array(L,result);
}
static int np_putmask(lua_State *L) {
    /* Values advance by destination position, unlike place's selected count. */
    ln_array *dst=check_array(L,1)->a;
    if(lua_gettop(L)<3 || lua_type(L,2)==LUA_TNIL || lua_type(L,3)==LUA_TNIL)return luaL_error(L,"putmask requires mask and values");
    if(!(dst->flags&LN_ARRAY_WRITEABLE))return luaL_error(L,"putmask destination is read-only");
    ln_array *mask=write98_arg(L,2,ln_dtype_by_num(LN_BOOL),LN_UNSAFE_CASTING);
    if(ln_array_size(mask)!=ln_array_size(dst))return luaL_error(L,"putmask mask and data must be the same size");
    ln_array *values=write98_arg(L,3,dst->descr,LN_SAFE_CASTING);
    ln_error err={{0}};
    return ln_array_putmask(dst,mask,values,&err)<0?fail(L,&err):0;
}
/* Internal array binding API shared with independently compiled modules. */
ln_array *ln_lua_test_array(lua_State *L,int index){lua_array *u=test_array(L,index);return u?u->a:NULL;}
ln_array *ln_lua_legacy_array(lua_State *L,int index,const ln_dtype *dtype){
    index=lua_absindex(L,index);lua_datetime_scalar *temporal=test_datetime_scalar(L,index);
    if(temporal)dtype=temporal->descr;
    lua_pushcfunction(L,np_array_legacy);lua_pushvalue(L,index);
    if(dtype)lua_pushstring(L,dtype->name);else lua_pushnil(L);
    if(lua_pcall(L,2,1,0)!=LUA_OK)luaL_error(L,"array conversion: %s",lua_tostring(L,-1));
    return check_array(L,-1)->a;
}
int ln_lua_push_array(lua_State *L,ln_array *array){return push_array(L,array);}
int ln_lua_fail(lua_State *L,ln_error *err){return fail(L,err);}
int ln_lua_shape(lua_State *L,int index,ln_intp *dims,int *nd){
    if(lua_isinteger(L,index)){dims[0]=(ln_intp)lua_tointegerx(L,index,NULL);*nd=1;return 0;}
    return parse_shape(L,index,dims,nd);
}
const ln_dtype *ln_lua_creation_target(lua_State *L,int source_index,const ln_array *array,const ln_dtype *dtype,ln_error *err){
    if(!dtype)return array->descr;
    lua_datetime_scalar *temporal=test_datetime_scalar(L,source_index);
    if(temporal&&temporal->descr->type_num==LN_DATETIME&&ln_string_is_dtype(dtype)&&ln_string_nchars(dtype)==0) {
        char text[128];const ln_dtype *ascii=ln_string_make_dtype(0,sizeof(text),'|',err);if(!ascii)return NULL;
        if(ln_cast_strided_numeric((const char *)&temporal->value,0,temporal->descr,text,0,ascii,1,err)<0)return NULL;
        size_t width=0;while(width<sizeof(text)&&text[width])++width;
        return ln_string_make_dtype(dtype->type_num==LN_UNICODE,width?width:1,dtype->byteorder,err);
    }
    const ln_datetime_meta *metadata=ln_datetime_metadata(dtype);
    if(metadata&&metadata->base==LN_FR_GENERIC) {
        const ln_datetime_meta *source=ln_datetime_metadata(array->descr);
        if(source)return ln_datetime_make_dtype(dtype->type_num==LN_TIMEDELTA,*source,err);
    }
    return resolve_astype_target(array,dtype,err);
}
void ln_lua_copyto_unsafe(lua_State *L,int destination,int source){
    destination=lua_absindex(L,destination);source=lua_absindex(L,source);
    lua_pushcfunction(L,np_copyto);lua_pushvalue(L,destination);lua_pushvalue(L,source);lua_pushstring(L,"unsafe");
    if(lua_pcall(L,3,0,0)!=LUA_OK)luaL_error(L,"array fill: %s",lua_tostring(L,-1));
}

static const luaL_Reg module_funcs[]={{"complex",complex_ctor},{"datetime64",np_datetime64},{"timedelta64",np_timedelta64},{"datetime_as_string",np_datetime_as_string},{"array",np_array},{"append",np_append},{"delete",np_delete},{"insert",np_insert},{"concatenate",np_concatenate},{"stack",np_stack},{"hstack",np_hstack},{"vstack",np_vstack},{"row_stack",np_vstack},{"dstack",np_dstack},{"column_stack",np_column_stack},{"split",np_split},{"array_split",np_array_split},{"hsplit",np_hsplit},{"vsplit",np_vsplit},{"dsplit",np_dsplit},{"astype",np_astype},{"shares_memory",np_shares_memory},{"may_share_memory",np_may_share_memory},{"copyto",np_copyto},{"putmask",np_putmask},{"put",np_put},{"take",np_take},{"choose",np_choose},{"nonzero",np_nonzero},{"flatnonzero",np_flatnonzero},{"compress",np_compress},{"extract",np_extract},{"where",np_where},{"select",np_select},{"take_along_axis",np_take_along_axis},{"put_along_axis",np_put_along_axis},{"place",np_place},{"can_cast",np_can_cast},{"promote_types",np_promote_types},{"result_type",np_result_type},{"min_scalar_type",np_min_scalar_type},{"issubdtype",np_issubdtype},{"zeros",np_zeros},{"ones",np_ones},{"empty",np_empty},{"arange",np_arange},{"linspace",np_linspace},{"logspace",np_logspace},{"geomspace",np_geomspace},{"mean",np_mean},{"average",np_average},{"var",np_var},{"std",np_std},{"cumsum",np_cumsum},{"cumprod",np_cumprod},{"nancumsum",np_nancumsum},{"nancumprod",np_nancumprod},{"nansum",np_nansum},{"nanprod",np_nanprod},{"nanmean",np_nanmean},{"nanvar",np_nanvar},{"nanstd",np_nanstd},{"min",np_amin},{"amin",np_amin},{"max",np_amax},{"amax",np_amax},{"argmin",np_argmin},{"argmax",np_argmax},{"nanmin",np_nanmin},{"nanmax",np_nanmax},{"nanargmin",np_nanargmin},{"nanargmax",np_nanargmax},{"ptp",np_ptp},{"median",np_median},{"quantile",np_quantile},{"percentile",np_percentile},{"nanmedian",np_nanmedian},{"nanquantile",np_nanquantile},{"nanpercentile",np_nanpercentile},{"sum",np_sum},{"prod",np_prod},{"any",np_any},{"all",np_all},{"count_nonzero",np_count_nonzero},{"add",np_add},{"subtract",np_subtract},{"multiply",np_multiply},{"true_divide",np_true_divide},{"divide",np_true_divide},{"equal",np_equal},{"not_equal",np_not_equal},{"less",np_less},{"less_equal",np_less_equal},{"greater",np_greater},{"greater_equal",np_greater_equal},{"logical_and",np_logical_and},{"logical_or",np_logical_or},{"logical_xor",np_logical_xor},{"maximum",np_maximum},{"minimum",np_minimum},{"floor_divide",np_floor_divide},{"remainder",np_remainder},{"mod",np_remainder},{"power",np_power},{"fmod",np_fmod},{"float_power",np_float_power},{"bitwise_and",np_bitwise_and},{"bitwise_or",np_bitwise_or},{"bitwise_xor",np_bitwise_xor},{"fmax",np_fmax},{"fmin",np_fmin},{"copysign",np_copysign},{"negative",np_negative},{"absolute",np_absolute},{"abs",np_absolute},{"positive",np_positive},{"sign",np_sign},{"logical_not",np_logical_not},{"isnan",np_isnan},{"isinf",np_isinf},{"isfinite",np_isfinite},{"isnat",np_isnat},{"signbit",np_signbit},{"sqrt",np_sqrt},{"exp",np_exp},{"log",np_log},{"sin",np_sin},{"floor",np_floor},{"ceil",np_ceil},{"trunc",np_trunc},{"rint",np_rint},{"fabs",np_fabs},{"conjugate",np_conjugate},{"square",np_square},{"reciprocal",np_reciprocal},{"degrees",np_degrees},{"radians",np_radians},{"conj",np_conj},{"rad2deg",np_rad2deg},{"deg2rad",np_deg2rad},{"cos",np_cos},{"tan",np_tan},{"sinh",np_sinh},{"cosh",np_cosh},{"tanh",np_tanh},{"exp2",np_exp2},{"log2",np_log2},{"log10",np_log10},{"expm1",np_expm1},{"log1p",np_log1p},{"cbrt",np_cbrt},{"arcsin",np_arcsin},{"asin",np_arcsin},{"arccos",np_arccos},{"acos",np_arccos},{"arctan",np_arctan},{"atan",np_arctan},{"arcsinh",np_arcsinh},{"asinh",np_arcsinh},{"arccosh",np_arccosh},{"acosh",np_arccosh},{"arctanh",np_arctanh},{"atanh",np_arctanh},{"arctan2",np_arctan2},{"atan2",np_arctan2},{"hypot",np_hypot},{"frexp",np_frexp},{"modf",np_modf},{"divmod",np_divmod},{"ldexp",np_ldexp},{"matmul",np_matmul},{"dot",np_dot},{"inner",np_inner},{"outer",np_outer},{"sort",np_sort},{"argsort",np_argsort},{"partition",np_partition},{"argpartition",np_argpartition},{"searchsorted",np_searchsorted},{"add_accumulate",np_add_accumulate},{"multiply_accumulate",np_multiply_accumulate},{"add_reduceat",np_add_reduceat},{"multiply_reduceat",np_multiply_reduceat},{"ravel",ln_lua_layout_ravel},{"reshape",np_reshape},{"transpose",np_transpose},{"swapaxes",np_swapaxes},{"moveaxis",np_moveaxis},{"expand_dims",np_expand_dims},{"squeeze",np_squeeze},{"flip",np_flip},{"flipud",np_flipud},{"fliplr",np_fliplr},{"rot90",np_rot90},{"atleast_1d",np_atleast_1d},{"atleast_2d",np_atleast_2d},{"atleast_3d",np_atleast_3d},{"broadcast_to",np_broadcast_to},{"broadcast_arrays",np_broadcast_arrays},{"broadcast_shapes",np_broadcast_shapes},{"tile",np_tile},{"roll",np_roll},{"rollaxis",np_rollaxis},{"repeat",np_repeat_elements},{"repeat_elements",np_repeat_elements},{"slice",np_slice},{"s",np_slice},{NULL,NULL}};

int luaopen_luaray_core(lua_State*L){
    if(luaL_newmetatable(L,GENERATOR_MT)){
        lua_createtable(L,0,6);luaL_setfuncs(L,generator_funcs,0);lua_setfield(L,-2,"__index");
    }
    lua_pop(L,1);
    luaL_newmetatable(L,INDEX_MT);
    lua_pop(L,1);
    if(luaL_newmetatable(L,COMPLEX_MT)){
        lua_pushcfunction(L,complex_tostring);lua_setfield(L,-2,"__tostring");
        lua_pushcfunction(L,complex_index);lua_setfield(L,-2,"__index");
        lua_pushcfunction(L,complex_eq);lua_setfield(L,-2,"__eq");
        lua_pushcfunction(L,complex_add);lua_setfield(L,-2,"__add");
        lua_pushcfunction(L,complex_sub);lua_setfield(L,-2,"__sub");
        lua_pushcfunction(L,complex_mul);lua_setfield(L,-2,"__mul");
        lua_pushcfunction(L,complex_div);lua_setfield(L,-2,"__div");
        lua_pushcfunction(L,complex_unm);lua_setfield(L,-2,"__unm");
    }
    lua_pop(L,1);
    if(luaL_newmetatable(L,DATETIME_MT)){lua_pushcfunction(L,datetime_scalar_tostring);lua_setfield(L,-2,"__tostring");lua_pushcfunction(L,datetime_scalar_index);lua_setfield(L,-2,"__index");lua_pushcfunction(L,datetime_scalar_eq);lua_setfield(L,-2,"__eq");}
    lua_pop(L,1);
    if(luaL_newmetatable(L,TIMEDELTA_MT)){lua_pushcfunction(L,datetime_scalar_tostring);lua_setfield(L,-2,"__tostring");lua_pushcfunction(L,datetime_scalar_index);lua_setfield(L,-2,"__index");lua_pushcfunction(L,datetime_scalar_eq);lua_setfield(L,-2,"__eq");}
    lua_pop(L,1);
    if(luaL_newmetatable(L,ARRAY_MT)){
        lua_pushcfunction(L,array_gc);lua_setfield(L,-2,"__gc");
        lua_pushcfunction(L,array_tostring);lua_setfield(L,-2,"__tostring");
        lua_pushcfunction(L,array_len);lua_setfield(L,-2,"__len");
        lua_pushcfunction(L,array_index);lua_setfield(L,-2,"__index");
        lua_pushcfunction(L,array_newindex);lua_setfield(L,-2,"__newindex");
        lua_pushcfunction(L,array_add);lua_setfield(L,-2,"__add");
        lua_pushcfunction(L,array_sub);lua_setfield(L,-2,"__sub");
        lua_pushcfunction(L,array_mul);lua_setfield(L,-2,"__mul");
        lua_pushcfunction(L,array_div);lua_setfield(L,-2,"__div");
        lua_pushcfunction(L,array_idiv);lua_setfield(L,-2,"__idiv");
        lua_pushcfunction(L,array_mod);lua_setfield(L,-2,"__mod");
        lua_pushcfunction(L,array_pow);lua_setfield(L,-2,"__pow");
        lua_pushcfunction(L,array_band);lua_setfield(L,-2,"__band");
        lua_pushcfunction(L,array_bor);lua_setfield(L,-2,"__bor");
        lua_pushcfunction(L,array_bxor);lua_setfield(L,-2,"__bxor");
        lua_pushcfunction(L,array_unm);lua_setfield(L,-2,"__unm");
    }
    lua_pop(L,1);
    lua_createtable(L,0,96);luaL_setfuncs(L,module_funcs,0);luaL_setfuncs(L,ln_lua_creation_functions,0);
    lua_createtable(L,0,4);luaL_setfuncs(L,fft_funcs,0);lua_setfield(L,-2,"fft");
    lua_createtable(L,0,12);luaL_setfuncs(L,linalg_funcs,0);lua_setfield(L,-2,"linalg");
    lua_createtable(L,0,2);lua_pushcfunction(L,lua_default_rng);lua_setfield(L,-2,"default_rng");lua_setfield(L,-2,"random");
    const char*names[]={"bool","int8","uint8","int16","uint16","int32","uint32","int64","uint64","float16","float32","float64","longdouble","complex64","complex128","complex256","str","bytes",NULL};
    for(int i=0;names[i];i++){lua_pushstring(L,names[i]);lua_setfield(L,-2,names[i]);}
    push_index_token(L,LN_INDEX_NEWAXIS);lua_setfield(L,-2,"newaxis");
    push_index_token(L,LN_INDEX_ELLIPSIS);lua_setfield(L,-2,"ellipsis");
    lua_pushstring(L,"0.110.0-dev");lua_setfield(L,-2,"_version");
    lua_pushstring(L,"286e698f1dcf601648b165f48485ceaeec9c6231");lua_setfield(L,-2,"_numpy_upstream_commit");
    return 1;
}

/* Temporary ABI/module-name compatibility for the pre-LuaRay name. */
int luaopen_lunumpy_core(lua_State *L) { return luaopen_luaray_core(L); }
