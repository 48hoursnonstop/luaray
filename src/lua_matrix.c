#include "lua_matrix.h"
#include "lua_array_api.h"
#include "ln_matrix.h"
#include "ln_linalg.h"
#include <limits.h>
#include <string.h>
static lua_Integer integer(lua_State *L,int index)
{
    if(!lua_isinteger(L,index))luaL_error(L,"expected a Lua integer");
    return lua_tointegerx(L,index,NULL);
}
static lua_Integer field(lua_State *L,int table,const char *name,lua_Integer fallback)
{
    lua_getfield(L,table,name);
    if(lua_type(L,-1)!=LUA_TNIL)fallback=integer(L,-1);
    lua_pop(L,1);return fallback;
}
static void options(lua_State *L,int index,int diagonal)
{
    lua_pushnil(L);
    while(lua_next(L,index)){
        size_t n=0;const char *k=lua_type(L,-2)==LUA_TSTRING?lua_tolstring(L,-2,&n):NULL;
        int valid=k&&(diagonal?((n==6&&!memcmp(k,"offset",6))||
            (n==5&&(!memcmp(k,"axis1",5)||!memcmp(k,"axis2",5)))||
            (diagonal==2&&((n==5&&!memcmp(k,"dtype",5))||(n==3&&!memcmp(k,"out",3)))))
            :(n==1&&*k=='k'));
        if(!valid)luaL_error(L,"unknown matrix option");
        lua_pop(L,1);
    }
}
static int axis(lua_State *L,lua_Integer value,int nd)
{
    if(value==0||value>nd||value< -nd)luaL_error(L,"axis outside Lua one-based range");
    return value>0?(int)value-1:nd+(int)value;
}
int ln_lua_diagonal(lua_State *L)
{
    int top=lua_gettop(L);lua_Integer offset=0,axis1=1,axis2=2;
    if(top<1||top>4)return luaL_error(L,"diagonal accepts input, offset, axis1 and axis2");
    if(lua_type(L,2)==LUA_TTABLE){
        if(top!=2)return luaL_error(L,"diagonal options cannot be combined with positional options");
        options(L,2,1);offset=field(L,2,"offset",0);axis1=field(L,2,"axis1",1);axis2=field(L,2,"axis2",2);
    }else{
        if(top>=2&&lua_type(L,2)!=LUA_TNIL)offset=integer(L,2);
        if(top>=3&&lua_type(L,3)!=LUA_TNIL)axis1=integer(L,3);
        if(top>=4&&lua_type(L,4)!=LUA_TNIL)axis2=integer(L,4);
    }
    if(offset<INT_MIN||offset>INT_MAX)return luaL_error(L,"diagonal offset exceeds native C int range");
    ln_array *a=ln_lua_test_array(L,1);if(!a)a=ln_lua_legacy_array(L,1,NULL);
    int first=axis(L,axis1,a->nd),second=axis(L,axis2,a->nd);
    ln_error err={0};ln_array *out=ln_matrix_diagonal(a,(ln_intp)offset,first,second,&err);
    return out?ln_lua_push_array(L,out):ln_lua_fail(L,&err);
}
static int diag(lua_State *L,int flatten)
{
    int top=lua_gettop(L);lua_Integer k=0;
    if(top<1||top>2)return luaL_error(L,"diag/diagflat accept input and optional k");
    if(lua_type(L,2)==LUA_TTABLE){options(L,2,0);k=field(L,2,"k",0);}
    else if(top==2&&lua_type(L,2)!=LUA_TNIL)k=integer(L,2);
    ln_array *a=ln_lua_test_array(L,1);if(!a)a=ln_lua_legacy_array(L,1,NULL);
    if(!flatten&&a->nd==2&&(k<INT_MIN||k>INT_MAX))return luaL_error(L,"diagonal offset exceeds native C int range");
    ln_error err={0};ln_array *out=ln_matrix_diag(a,(ln_intp)k,flatten,&err);
    return out?ln_lua_push_array(L,out):ln_lua_fail(L,&err);
}
int ln_lua_diag(lua_State *L){return diag(L,0);}
int ln_lua_diagflat(lua_State *L){return diag(L,1);}

static const ln_dtype *dtype(lua_State *L,int index)
{
    if(lua_type(L,index)==LUA_TNIL||lua_type(L,index)==LUA_TNONE)return NULL;
    size_t length=0;const char *name=lua_type(L,index)==LUA_TSTRING?lua_tolstring(L,index,&length):NULL;
    const ln_dtype *result=name&&strlen(name)==length?ln_dtype_by_name(name):NULL;
    if(!result)luaL_error(L,"unsupported matrix dtype");
    return result;
}
int ln_lua_trace(lua_State *L)
{
    int top=lua_gettop(L),output_index=6;lua_Integer offset=0,axis1=1,axis2=2;
    const ln_dtype *target=NULL;ln_array *output=NULL;
    if(top<1||top>6)return luaL_error(L,"trace accepts input, offset, axis1, axis2, dtype and out");
    if(lua_type(L,2)==LUA_TTABLE){
        if(top!=2)return luaL_error(L,"trace options cannot be combined with positional options");
        options(L,2,2);offset=field(L,2,"offset",0);axis1=field(L,2,"axis1",1);axis2=field(L,2,"axis2",2);
        lua_getfield(L,2,"dtype");target=dtype(L,-1);lua_pop(L,1);
        lua_getfield(L,2,"out");output_index=lua_gettop(L);
    }else{
        if(top>=2&&lua_type(L,2)!=LUA_TNIL)offset=integer(L,2);
        if(top>=3&&lua_type(L,3)!=LUA_TNIL)axis1=integer(L,3);
        if(top>=4&&lua_type(L,4)!=LUA_TNIL)axis2=integer(L,4);
        if(top>=5)target=dtype(L,5);
    }
    if(lua_type(L,output_index)!=LUA_TNONE&&lua_type(L,output_index)!=LUA_TNIL){
        output=ln_lua_test_array(L,output_index);
        if(!output)return luaL_error(L,"trace out must be an ndarray");
    }
    if(offset<INT_MIN||offset>INT_MAX)return luaL_error(L,"trace offset exceeds native C int range");
    ln_array *a=ln_lua_test_array(L,1);if(!a)a=ln_lua_legacy_array(L,1,NULL);
    int first=axis(L,axis1,a->nd),second=axis(L,axis2,a->nd);
    ln_error err={0};ln_array *result=ln_matrix_trace(a,(ln_intp)offset,first,second,target,output,&err);
    if(!result)return ln_lua_fail(L,&err);
    if(output){lua_pushvalue(L,output_index);return 1;}
    return ln_lua_push_scalar_or_array(L,result);
}

int ln_lua_tri(lua_State *L)
{
    int top=lua_gettop(L);lua_Integer rows=0,columns=0,k=0;const ln_dtype *target=NULL;
    if(top<1||top>4)return luaL_error(L,"tri accepts rows, columns, k and dtype");
    rows=integer(L,1);columns=rows;
    if(lua_type(L,2)==LUA_TTABLE){
        if(top!=2)return luaL_error(L,"tri options cannot be combined with positional options");
        lua_pushnil(L);
        while(lua_next(L,2)){
            size_t n=0;const char *key=lua_type(L,-2)==LUA_TSTRING?lua_tolstring(L,-2,&n):NULL;
            if(!key||!((n==1&&(*key=='m'||*key=='k'))||(n==5&&!memcmp(key,"dtype",5))))
                return luaL_error(L,"unknown tri option");
            lua_pop(L,1);
        }
        columns=field(L,2,"m",rows);k=field(L,2,"k",0);
        lua_getfield(L,2,"dtype");target=dtype(L,-1);lua_pop(L,1);
    }else{
        if(top>=2&&lua_type(L,2)!=LUA_TNIL)columns=integer(L,2);
        if(top>=3&&lua_type(L,3)!=LUA_TNIL)k=integer(L,3);
        if(top>=4)target=dtype(L,4);
    }
    ln_error err={0};ln_array *result=ln_matrix_tri((ln_intp)rows,(ln_intp)columns,(ln_intp)k,target,&err);
    return result?ln_lua_push_array(L,result):ln_lua_fail(L,&err);
}
static int trilu(lua_State *L,int upper)
{
    int top=lua_gettop(L);lua_Integer k=0;
    if(top<1||top>2)return luaL_error(L,"tril/triu accept input and optional k");
    if(lua_type(L,2)==LUA_TTABLE){options(L,2,0);k=field(L,2,"k",0);}
    else if(top==2&&lua_type(L,2)!=LUA_TNIL)k=integer(L,2);
    ln_array *a=ln_lua_test_array(L,1);if(!a)a=ln_lua_legacy_array(L,1,NULL);
    ln_error err={0};ln_array *result=ln_matrix_trilu(a,(ln_intp)k,upper,&err);
    return result?ln_lua_push_array(L,result):ln_lua_fail(L,&err);
}
int ln_lua_tril(lua_State *L){return trilu(L,0);}
int ln_lua_triu(lua_State *L){return trilu(L,1);}

int ln_lua_vander(lua_State *L)
{
    int top=lua_gettop(L),increasing=0,has_columns=0;lua_Integer columns=0;
    if(top<1||top>3)return luaL_error(L,"vander accepts input, columns and increasing");
    if(lua_type(L,2)==LUA_TTABLE){
        if(top!=2)return luaL_error(L,"vander options cannot be combined with positional options");
        lua_pushnil(L);
        while(lua_next(L,2)){
            size_t n=0;const char *key=lua_type(L,-2)==LUA_TSTRING?lua_tolstring(L,-2,&n):NULL;
            if(!key||!((n==1&&*key=='n')||(n==10&&!memcmp(key,"increasing",10))))
                return luaL_error(L,"unknown vander option");
            lua_pop(L,1);
        }
        lua_getfield(L,2,"n");if(lua_type(L,-1)!=LUA_TNIL){columns=integer(L,-1);has_columns=1;}lua_pop(L,1);
        lua_getfield(L,2,"increasing");
        if(lua_type(L,-1)!=LUA_TNIL){if(lua_type(L,-1)!=LUA_TBOOLEAN)return luaL_error(L,"increasing must be boolean");increasing=lua_toboolean(L,-1);}lua_pop(L,1);
    }else{
        if(top>=2&&lua_type(L,2)!=LUA_TNIL){columns=integer(L,2);has_columns=1;}
        if(top>=3&&lua_type(L,3)!=LUA_TNIL){if(lua_type(L,3)!=LUA_TBOOLEAN)return luaL_error(L,"increasing must be boolean");increasing=lua_toboolean(L,3);}
    }
    ln_array *x=ln_lua_test_array(L,1);if(!x)x=ln_lua_legacy_array(L,1,NULL);
    if(!has_columns)columns=x->nd==1?x->dimensions[0]:0;
    ln_error err={0};ln_array *result=ln_matrix_vander(x,(ln_intp)columns,increasing,&err);
    return result?ln_lua_push_array(L,result):ln_lua_fail(L,&err);
}

static int matrix_order(lua_State *L,int index)
{
    if(lua_type(L,index)==LUA_TNIL||lua_type(L,index)==LUA_TNONE)return 0;
    size_t n=0;const char *text=lua_type(L,index)==LUA_TSTRING?lua_tolstring(L,index,&n):NULL;
    if(!text||n!=1||(text[0]!='C'&&text[0]!='F'&&text[0]!='c'&&text[0]!='f'))luaL_error(L,"eye order must be C or F");
    return text[0]=='F'||text[0]=='f';
}
static int eye(lua_State *L,int identity)
{
    int top=lua_gettop(L),fortran=0;lua_Integer rows=0,columns=0,k=0;const ln_dtype *target=NULL;
    if(top<1||top>(identity?2:5))return luaL_error(L,"invalid eye/identity argument count");
    rows=integer(L,1);columns=rows;
    if(lua_type(L,2)==LUA_TTABLE){
        if(top!=2)return luaL_error(L,"matrix options cannot be combined with positional options");
        lua_pushnil(L);
        while(lua_next(L,2)){
            size_t n=0;const char *key=lua_type(L,-2)==LUA_TSTRING?lua_tolstring(L,-2,&n):NULL;
            int valid=key&&((n==5&&!memcmp(key,"dtype",5))||(!identity&&
                ((n==1&&(*key=='m'||*key=='k'))||(n==5&&!memcmp(key,"order",5))||(n==6&&!memcmp(key,"device",6)))));
            if(!valid)return luaL_error(L,"unknown eye/identity option");
            lua_pop(L,1);
        }
        if(!identity){
            columns=field(L,2,"m",rows);k=field(L,2,"k",0);
            lua_getfield(L,2,"order");fortran=matrix_order(L,-1);lua_pop(L,1);
            lua_getfield(L,2,"device");
            if(lua_type(L,-1)!=LUA_TNIL){size_t n=0;const char *device=lua_type(L,-1)==LUA_TSTRING?lua_tolstring(L,-1,&n):NULL;if(!device||n!=3||memcmp(device,"cpu",3))return luaL_error(L,"eye device must be cpu");}lua_pop(L,1);
        }
        lua_getfield(L,2,"dtype");target=dtype(L,-1);lua_pop(L,1);
    }else if(identity){if(top>=2)target=dtype(L,2);}
    else{
        if(top>=2&&lua_type(L,2)!=LUA_TNIL)columns=integer(L,2);
        if(top>=3&&lua_type(L,3)!=LUA_TNIL)k=integer(L,3);
        if(top>=4)target=dtype(L,4);
        if(top>=5)fortran=matrix_order(L,5);
    }
    ln_error err={0};ln_array *result=ln_matrix_eye((ln_intp)rows,(ln_intp)columns,(ln_intp)k,target,fortran,&err);
    return result?ln_lua_push_array(L,result):ln_lua_fail(L,&err);
}
int ln_lua_eye(lua_State *L){return eye(L,0);}
int ln_lua_identity(lua_State *L){return eye(L,1);}

static int diagonal_indices(lua_State *L,ln_intp n,lua_Integer dimensions)
{
    if(dimensions>INT_MAX)return luaL_error(L,"diagonal index sequence exceeds Lua table capacity");
    ln_error err={0};ln_array *vector=ln_matrix_diag_indices(n,&err);
    if(!vector)return ln_lua_fail(L,&err);
    ln_lua_push_array(L,vector);int index=lua_gettop(L);
    lua_createtable(L,dimensions>0?(int)dimensions:0,0);int result=lua_gettop(L);
    for(lua_Integer i=0;i<dimensions;++i){lua_pushvalue(L,index);lua_seti(L,result,i+1);}
    return 1;
}
int ln_lua_diag_indices(lua_State *L)
{
    int top=lua_gettop(L);if(top<1||top>2)return luaL_error(L,"diag_indices accepts size and optional dimension count");
    lua_Integer n=integer(L,1),dimensions=2;
    if(lua_type(L,2)==LUA_TTABLE){
        lua_pushnil(L);
        while(lua_next(L,2)){
            size_t length=0;const char *key=lua_type(L,-2)==LUA_TSTRING?lua_tolstring(L,-2,&length):NULL;
            if(!key||length!=4||memcmp(key,"ndim",4))return luaL_error(L,"unknown diag_indices option");
            lua_pop(L,1);
        }
        dimensions=field(L,2,"ndim",2);
    }else if(top==2&&lua_type(L,2)!=LUA_TNIL)dimensions=integer(L,2);
    return diagonal_indices(L,(ln_intp)n,dimensions);
}
int ln_lua_diag_indices_from(lua_State *L)
{
    if(lua_gettop(L)!=1)return luaL_error(L,"diag_indices_from accepts exactly one ndarray");
    ln_array *a=ln_lua_test_array(L,1);
    if(!a||a->nd<2)return luaL_error(L,"diag_indices_from requires an ndarray with at least two dimensions");
    for(int d=1;d<a->nd;++d)if(a->dimensions[d]!=a->dimensions[0])return luaL_error(L,"all array dimensions must have equal length");
    return diagonal_indices(L,a->dimensions[0],a->nd);
}

static int triangular_indices(lua_State *L,int upper,int from)
{
    int top=lua_gettop(L);lua_Integer rows,columns,k=0;
    if(top<1||top>(from?2:3))return luaL_error(L,"invalid triangular-index argument count");
    if(from){
        ln_array *a=ln_lua_test_array(L,1);
        if(!a||a->nd!=2)return luaL_error(L,"triangular indices require a two-dimensional ndarray");
        rows=a->dimensions[0];columns=a->dimensions[1];
    }else{rows=integer(L,1);columns=rows;}
    if(lua_type(L,2)==LUA_TTABLE){
        if(top!=2)return luaL_error(L,"index options cannot be combined with positional options");
        lua_pushnil(L);
        while(lua_next(L,2)){
            size_t length=0;const char *key=lua_type(L,-2)==LUA_TSTRING?lua_tolstring(L,-2,&length):NULL;
            if(!key||length!=1||(*key!='k'&&(from||*key!='m')))return luaL_error(L,"unknown triangular-index option");
            lua_pop(L,1);
        }
        k=field(L,2,"k",0);if(!from)columns=field(L,2,"m",rows);
    }else{
        if(top>=2&&lua_type(L,2)!=LUA_TNIL)k=integer(L,2);
        if(!from&&top>=3&&lua_type(L,3)!=LUA_TNIL)columns=integer(L,3);
    }
    ln_error err={0};ln_array *coordinates[2];
    if(ln_matrix_trilu_indices((ln_intp)rows,(ln_intp)columns,(ln_intp)k,upper,coordinates,&err)<0)return ln_lua_fail(L,&err);
    lua_createtable(L,2,0);
    for(int d=0;d<2;++d){ln_lua_push_array(L,coordinates[d]);lua_seti(L,-2,d+1);}
    return 1;
}
int ln_lua_tril_indices(lua_State *L){return triangular_indices(L,0,0);}
int ln_lua_triu_indices(lua_State *L){return triangular_indices(L,1,0);}
int ln_lua_tril_indices_from(lua_State *L){return triangular_indices(L,0,1);}
int ln_lua_triu_indices_from(lua_State *L){return triangular_indices(L,1,1);}

int ln_lua_fill_diagonal(lua_State *L)
{
    int top=lua_gettop(L),wrap=0;
    if(top<2||top>3)return luaL_error(L,"fill_diagonal accepts destination, values and optional wrap");
    ln_array *a=ln_lua_test_array(L,1);
    if(!a||a->nd<2)return luaL_error(L,"fill_diagonal requires an ndarray of rank at least two");
    for(int d=1;a->nd>2&&d<a->nd;++d)
        if(a->dimensions[d]!=a->dimensions[0])return luaL_error(L,"all array dimensions must have equal length");
    if(!(a->flags&LN_ARRAY_WRITEABLE))return luaL_error(L,"fill_diagonal destination is read-only");
    if(lua_type(L,3)==LUA_TTABLE){
        lua_pushnil(L);
        while(lua_next(L,3)){
            size_t length=0;const char *key=lua_type(L,-2)==LUA_TSTRING?lua_tolstring(L,-2,&length):NULL;
            if(!key||length!=4||memcmp(key,"wrap",4))return luaL_error(L,"unknown fill_diagonal option");
            lua_pop(L,1);
        }
        lua_getfield(L,3,"wrap");
        if(lua_type(L,-1)!=LUA_TNIL){if(lua_type(L,-1)!=LUA_TBOOLEAN)return luaL_error(L,"wrap must be boolean");wrap=lua_toboolean(L,-1);}lua_pop(L,1);
    }else if(top==3&&lua_type(L,3)!=LUA_TNIL){
        if(lua_type(L,3)!=LUA_TBOOLEAN)return luaL_error(L,"wrap must be boolean");
        wrap=lua_toboolean(L,3);
    }
    ln_array *values=ln_lua_assignment_values(L,2,a->descr);
    ln_error err={0};return ln_matrix_fill_diagonal(a,values,wrap,&err)<0?ln_lua_fail(L,&err):0;
}

int ln_lua_kron(lua_State *L)
{
    if(lua_gettop(L)!=2)return luaL_error(L,"kron accepts exactly two inputs");
    ln_array *a=ln_lua_test_array(L,1);if(!a)a=ln_lua_legacy_array(L,1,NULL);
    ln_array *b=ln_lua_test_array(L,2);if(!b)b=ln_lua_legacy_array(L,2,NULL);
    ln_error err={0};ln_array *result=ln_matrix_kron(a,b,&err);
    return result?ln_lua_push_array(L,result):ln_lua_fail(L,&err);
}

static int contraction_axis_list(lua_State *L,int index,int nd,int *out)
{
    index=lua_absindex(L,index);
    if(lua_type(L,index)!=LUA_TTABLE){out[0]=axis(L,integer(L,index),nd);return 1;}
    size_t length=lua_rawlen(L,index);
    if(length>LN_MAXDIMS)return luaL_error(L,"too many contraction axes");
    for(size_t i=0;i<length;++i){lua_geti(L,index,(lua_Integer)i+1);out[i]=axis(L,integer(L,-1),nd);lua_pop(L,1);}
    return (int)length;
}
int ln_lua_tensordot(lua_State *L)
{
    int top=lua_gettop(L),index=3,aa[LN_MAXDIMS],bb[LN_MAXDIMS],count=2;
    if(top<2||top>3)return luaL_error(L,"tensordot accepts two inputs and optional axes");
    ln_array *a=ln_lua_test_array(L,1);if(!a)a=ln_lua_legacy_array(L,1,NULL);
    ln_array *b=ln_lua_test_array(L,2);if(!b)b=ln_lua_legacy_array(L,2,NULL);
    if(top==3&&lua_type(L,3)==LUA_TTABLE&&lua_rawlen(L,3)==0){
        lua_pushnil(L);
        while(lua_next(L,3)){
            size_t n=0;const char *key=lua_type(L,-2)==LUA_TSTRING?lua_tolstring(L,-2,&n):NULL;
            if(!key||n!=4||memcmp(key,"axes",4))return luaL_error(L,"unknown tensordot option");
            lua_pop(L,1);
        }
        lua_getfield(L,3,"axes");index=lua_gettop(L);
    }
    if(top==3&&lua_type(L,index)!=LUA_TNIL){
        if(lua_type(L,index)==LUA_TTABLE){
            if(lua_rawlen(L,index)!=2)return luaL_error(L,"axes must contain two axis lists or integers");
            lua_geti(L,index,1);count=contraction_axis_list(L,-1,a->nd,aa);lua_pop(L,1);
            lua_geti(L,index,2);int second=contraction_axis_list(L,-1,b->nd,bb);lua_pop(L,1);
            if(count!=second)return luaL_error(L,"contraction axis lists must have equal length");
            goto execute;
        }
        lua_Integer requested=integer(L,index);
        if(requested<0)requested=0;
        if(requested>a->nd||requested>b->nd)return luaL_error(L,"axes exceeds input dimensions");
        count=(int)requested;
    }
    if(count>a->nd||count>b->nd)return luaL_error(L,"axes exceeds input dimensions");
    for(int i=0;i<count;++i){aa[i]=a->nd-count+i;bb[i]=i;}
 execute:
    ln_error err={0};ln_array *result=ln_linalg_tensordot(a,b,aa,bb,count,&err);
    return result?ln_lua_push_array(L,result):ln_lua_fail(L,&err);
}
