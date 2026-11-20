#include "lua_fromstring.h"
#include "lua_array_api.h"
#include "ln_fromstring.h"
#include <string.h>

int ln_lua_fromstring(lua_State *L)
{
    int argc=lua_gettop(L);
    if(argc!=2||lua_type(L,1)!=LUA_TSTRING||lua_type(L,2)!=LUA_TTABLE)
        return luaL_error(L,"fromstring expects a string and {sep=..., dtype=..., count=...}");
    lua_pushnil(L);
    while(lua_next(L,2)){
        size_t length=0;
        const char *key=lua_type(L,-2)==LUA_TSTRING?lua_tolstring(L,-2,&length):NULL;
        if(!key||strlen(key)!=length||(strcmp(key,"sep")&&strcmp(key,"dtype")&&strcmp(key,"count")))
            return luaL_error(L,"unknown fromstring option");
        lua_pop(L,1);
    }
    lua_getfield(L,2,"dtype");
    const ln_dtype *dtype=lua_type(L,-1)==LUA_TNIL?ln_dtype_by_num(LN_DOUBLE):ln_lua_check_dtype(L,-1);
    lua_pop(L,1);
    ln_intp count=-1;
    lua_getfield(L,2,"count");
    if(lua_type(L,-1)!=LUA_TNIL){
        if(!lua_isinteger(L,-1))return luaL_error(L,"fromstring count must be a Lua integer");
        lua_Integer n=lua_tointegerx(L,-1,NULL);
        if(n<INTPTR_MIN||n>INTPTR_MAX)return luaL_error(L,"fromstring count exceeds native index range");
        count=(ln_intp)n;
    }
    lua_pop(L,1);
    lua_getfield(L,2,"sep");
    if(lua_type(L,-1)!=LUA_TSTRING)return luaL_error(L,"fromstring sep must be a nonempty string");
    size_t length,sep_length;
    const char *text=lua_tolstring(L,1,&length),*sep=lua_tolstring(L,-1,&sep_length);
    ln_error error={0};
    ln_array *result=ln_array_fromstring(text,length,dtype,count,sep,sep_length,&error);
    return result?ln_lua_push_array(L,result):ln_lua_fail(L,&error);
}
