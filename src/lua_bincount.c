#include "lua_bincount.h"
#include "lua_array_api.h"
#include "ln_bincount.h"
#include <stdint.h>
#include <string.h>
static int empty_sequence(lua_State *L,int index)
{
    if(lua_type(L,index)!=LUA_TTABLE)return 0;
    index=lua_absindex(L,index);lua_pushnil(L);
    if(!lua_next(L,index))return 1;
    lua_pop(L,2);return 0;
}
static int option_table(lua_State *L,int index)
{
    if(lua_type(L,index)!=LUA_TTABLE)return 0;
    index=lua_absindex(L,index);lua_pushnil(L);int options=0;
    while(lua_next(L,index)){
        if(lua_type(L,-2)==LUA_TSTRING)options=1;
        lua_pop(L,1);
    }
    if(!options)return 0;
    lua_pushnil(L);
    while(lua_next(L,index)){
        size_t size=0;const char *key=lua_type(L,-2)==LUA_TSTRING?lua_tolstring(L,-2,&size):NULL;
        if(!key||!((size==7&&!memcmp(key,"weights",7))||(size==9&&!memcmp(key,"minlength",9))))
            luaL_error(L,"bincount options only support weights and minlength");
        lua_pop(L,1);
    }
    return 1;
}
int ln_lua_bincount(lua_State *L)
{
    int arguments=lua_gettop(L);
    if(arguments>3)return luaL_error(L,"bincount accepts labels, weights and minlength");
    int options=option_table(L,2);
    if(options&&arguments>2)return luaL_error(L,"cannot combine bincount options with positional minlength");
    ln_array *labels=ln_lua_test_array(L,1);
    if(!labels){
        const ln_dtype *dtype=empty_sequence(L,1)?ln_dtype_by_name(sizeof(ln_intp)==8?"int64":"int32"):NULL;
        labels=ln_lua_legacy_array(L,1,dtype);
    }
    /* Use stable stack slots even after array construction roots a temporary. */
    int weight_index=2,minlength_index=3;
    if(options){
        lua_getfield(L,2,"weights");weight_index=lua_absindex(L,-1);
        lua_getfield(L,2,"minlength");minlength_index=lua_absindex(L,-1);
    }
    ln_intp minlength=0;
    if((options||arguments>=3)&&lua_type(L,minlength_index)!=LUA_TNIL){
        if(!lua_isinteger(L,minlength_index))return luaL_error(L,"minlength must be a Lua integer");
        lua_Integer value=lua_tointegerx(L,minlength_index,NULL);
        if(value<0||(uintmax_t)value>INTPTR_MAX)return luaL_error(L,"minlength must be a nonnegative pointer-width integer");
        minlength=(ln_intp)value;
    }
    ln_error error={0};ln_intp length;
    if(ln_bincount_shape(labels,minlength,&length,&error)<0)return ln_lua_fail(L,&error);
    ln_array *weights=NULL;
    if(labels->dimensions[0]&&(options||arguments>=2)&&lua_type(L,weight_index)!=LUA_TNIL){
        weights=ln_lua_test_array(L,weight_index);
        if(!weights)weights=ln_lua_legacy_array(L,weight_index,NULL);
    }
    ln_array *out=ln_bincount(labels,weights,minlength,&error);
    return out?ln_lua_push_array(L,out):ln_lua_fail(L,&error);
}
