/* NumPy 2.5.3 fromnumeric.py: shape, ndim, size. Array metadata is read
 * directly; ordinary Lua array-like values use the native discovery path. */
#include "lua_metadata.h"
#include "lua_array_api.h"
static ln_array *input(lua_State *L)
{
    ln_array *a=ln_lua_test_array(L,1);
    return a?a:ln_lua_legacy_array(L,1,NULL);
}
int ln_lua_shape_query(lua_State *L)
{
    if(lua_gettop(L)!=1)return luaL_error(L,"shape expects one array-like value");
    ln_array *a=input(L);lua_createtable(L,a->nd,0);
    for(int d=0;d<a->nd;++d){lua_pushinteger(L,(lua_Integer)a->dimensions[d]);lua_seti(L,-2,d+1);}
    return 1;
}
int ln_lua_ndim_query(lua_State *L)
{
    if(lua_gettop(L)!=1)return luaL_error(L,"ndim expects one array-like value");
    ln_array *a=input(L);lua_pushinteger(L,a->nd);return 1;
}
int ln_lua_size_query(lua_State *L)
{
    int argc=lua_gettop(L),has_axis=argc==2&&lua_type(L,2)!=LUA_TNIL;
    if(argc<1||argc>2)return luaL_error(L,"size expects an array-like value and optional axis");
    lua_Integer axis=0;
    if(has_axis){
        if(!lua_isinteger(L,2))return luaL_error(L,"size axis must be a Lua integer");
        axis=lua_tointegerx(L,2,NULL);
    }
    ln_array *a=input(L);ln_intp size;
    if(has_axis){
        if(axis<0)axis+=(lua_Integer)a->nd+1;
        if(axis<1||axis>a->nd)return luaL_error(L,"size axis is out of bounds; positive axes start at one");
        size=a->dimensions[axis-1];
    }else{
        size=ln_array_size(a);if(size<0)return luaL_error(L,"array size exceeds the native integer range");
    }
    lua_pushinteger(L,(lua_Integer)size);return 1;
}
