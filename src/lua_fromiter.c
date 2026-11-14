#include "lua_fromiter.h"
#include "lua_array_api.h"
#include "ln_fromiter.h"
#include <string.h>
static ln_intp count_arg(lua_State *L,int index)
{
    if(lua_type(L,index)==LUA_TNIL)return -1;
    if(!lua_isinteger(L,index))luaL_error(L,"fromiter count must be a Lua integer");
    lua_Integer n=lua_tointegerx(L,index,NULL);
    if(n<INTPTR_MIN||n>INTPTR_MAX)luaL_error(L,"fromiter count exceeds native index range");
    return (ln_intp)n;
}
static void callable(lua_State *L,int index)
{
    if(lua_type(L,index)==LUA_TFUNCTION)return;
    if(lua_getmetatable(L,index)){
        lua_pushstring(L,"__call");lua_rawget(L,-2);
        int valid=lua_type(L,-1)==LUA_TFUNCTION;lua_pop(L,2);
        if(valid)return;
    }
    luaL_error(L,"fromiter expects a function or an object with a function __call");
}
int ln_lua_fromiter(lua_State *L)
{
    int argc=lua_gettop(L);
    if(argc<2||argc>3)return luaL_error(L,"fromiter expects iterator, dtype and optional count/options");
    const ln_dtype *dtype=lua_type(L,2)==LUA_TNIL?ln_dtype_by_num(LN_DOUBLE):ln_lua_check_dtype(L,2);
    ln_intp count=-1;
    if(argc==3&&lua_type(L,3)==LUA_TTABLE){
        lua_pushnil(L);
        while(lua_next(L,3)){
            size_t n=0;const char *key=lua_type(L,-2)==LUA_TSTRING?lua_tolstring(L,-2,&n):NULL;
            if(!key||n!=5||memcmp(key,"count",5))return luaL_error(L,"fromiter only supports the count option");
            lua_pop(L,1);
        }
        lua_getfield(L,3,"count");count=count_arg(L,-1);lua_pop(L,1);
    }else if(argc==3)count=count_arg(L,3);
    callable(L,1);
    ln_error error={0};ln_array *result=ln_fromiter_new(dtype,count,&error);
    if(!result)return ln_lua_fail(L,&error);
    /* Root storage before calling user code: Lua errors and GC may occur at
     * every callback or scalar conversion, including after a reallocation. */
    ln_lua_push_array(L,result);int result_index=lua_gettop(L);ln_intp written=0;
    while(count==-1||written<count){
        lua_pushvalue(L,1);if(lua_pcall(L,0,1,0)!=LUA_OK)return lua_error(L);
        if(lua_type(L,-1)==LUA_TNIL){lua_pop(L,1);break;}
        if(ln_fromiter_reserve(result,written,&error)<0)return ln_lua_fail(L,&error);
        ln_lua_pack_scalar(L,-1,dtype,result->data+written*(ln_intp)dtype->elsize);
        lua_pop(L,1);written++;
    }
    if(written<count)return luaL_error(L,"fromiter iterator too short: expected %I but received %I",(lua_Integer)count,(lua_Integer)written);
    if(ln_fromiter_finish(result,written,&error)<0)return ln_lua_fail(L,&error);
    lua_settop(L,result_index);return 1;
}
