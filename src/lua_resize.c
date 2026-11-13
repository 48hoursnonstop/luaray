#include "lua_resize.h"
#include "lua_array_api.h"
#include "ln_resize.h"
#include <string.h>
static ln_intp integer(lua_State *L,int index)
{
    if(!lua_isinteger(L,index))luaL_error(L,"resize dimensions must be Lua integers");
    lua_Integer n=lua_tointegerx(L,index,NULL);
    if(n<INTPTR_MIN||n>INTPTR_MAX)luaL_error(L,"resize dimension exceeds native integer range");
    return (ln_intp)n;
}
static int shape(lua_State *L,int index,ln_intp *values)
{
    if(lua_isinteger(L,index)){values[0]=integer(L,index);return 1;}
    if(lua_type(L,index)!=LUA_TTABLE)luaL_error(L,"resize shape must be an integer or a dense integer table");
    int absolute=lua_absindex(L,index);size_t count=lua_rawlen(L,index);
    if(count>LN_MAXDIMS)luaL_error(L,"resize rank exceeds 64");
    lua_pushnil(L);
    while(lua_next(L,absolute)){
        if(!lua_isinteger(L,-2)||lua_tointegerx(L,-2,NULL)<1||(size_t)lua_tointegerx(L,-2,NULL)>count)
            luaL_error(L,"resize shape must be a dense integer table");
        lua_pop(L,1);
    }
    for(size_t i=0;i<count;++i){lua_geti(L,absolute,(lua_Integer)i+1);values[i]=integer(L,-1);lua_pop(L,1);}
    return (int)count;
}
int ln_lua_resize_copy(lua_State *L)
{
    if(lua_gettop(L)!=2)return luaL_error(L,"resize expects an array and a shape");
    ln_intp dims[LN_MAXDIMS];int nd=shape(L,2,dims);
    ln_array *a=ln_lua_test_array(L,1);if(!a)a=ln_lua_legacy_array(L,1,NULL);
    ln_error error={0};ln_array *result=ln_array_resize_copy(a,nd,dims,&error);
    return result?ln_lua_push_array(L,result):ln_lua_fail(L,&error);
}
int ln_lua_resize_inplace(lua_State *L)
{
    int argc=lua_gettop(L);if(argc>3)return luaL_error(L,"array resize expects a shape and optional refcheck table");
    ln_array *a=ln_lua_test_array(L,1);if(!a)return luaL_error(L,"array resize requires an ndarray");
    if(argc==3){
        if(lua_type(L,3)!=LUA_TTABLE)return luaL_error(L,"resize options must be a table");
        lua_pushnil(L);
        while(lua_next(L,3)){
            size_t length;const char *key=lua_type(L,-2)==LUA_TSTRING?lua_tolstring(L,-2,&length):NULL;
            if(!key||length!=8||memcmp(key,"refcheck",8))return luaL_error(L,"resize only supports refcheck");
            if(lua_type(L,-1)!=LUA_TBOOLEAN)return luaL_error(L,"refcheck must be a Boolean");
            lua_pop(L,1);
        }
    }
    if(argc==1||lua_type(L,2)==LUA_TNIL)return 0;
    ln_intp dims[LN_MAXDIMS];int nd=shape(L,2,dims);
    ln_error error={0};return ln_array_resize_inplace(a,nd,dims,&error)<0?ln_lua_fail(L,&error):0;
}
