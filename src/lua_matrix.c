#include "lua_matrix.h"
#include "lua_array_api.h"
#include "ln_matrix.h"
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
        if(!valid)luaL_error(L,"unknown diagonal option");
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
    if(!result)luaL_error(L,"unsupported trace dtype");
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
