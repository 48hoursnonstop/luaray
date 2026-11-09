#include "lua_bytes.h"
#include "lua_array_api.h"
#include "ln_bytes.h"
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
static ln_array *input(lua_State *L)
{
    ln_array *a=ln_lua_test_array(L,1);if(!a)luaL_error(L,"byte methods require an ndarray");return a;
}
int ln_lua_bytes_view(lua_State *L)
{
    ln_array *a=input(L);const ln_dtype *dtype=NULL;
    if(lua_gettop(L)>2)return luaL_error(L,"view accepts one optional dtype");
    if(lua_type(L,2)!=LUA_TNONE&&lua_type(L,2)!=LUA_TNIL){
        if(lua_type(L,2)!=LUA_TSTRING)return luaL_error(L,"view dtype must be a dtype string");
        size_t length;const char *text=lua_tolstring(L,2,&length);
        if(strlen(text)!=length||!(dtype=ln_dtype_by_name(text)))return luaL_error(L,"unsupported view dtype");
    }
    ln_error err={0};ln_array *result=ln_bytes_view(a,dtype,&err);
    return result?ln_lua_push_array(L,result):ln_lua_fail(L,&err);
}
int ln_lua_bytes_export(lua_State *L)
{
    ln_array *a=input(L);char order='C';int index=2;
    if(lua_gettop(L)>2)return luaL_error(L,"tobytes accepts one optional order");
    if(lua_type(L,2)==LUA_TTABLE){
        lua_pushnil(L);
        while(lua_next(L,2)){
            size_t n=0;const char *key=lua_type(L,-2)==LUA_TSTRING?lua_tolstring(L,-2,&n):NULL;
            if(!key||n!=5||memcmp(key,"order",5)!=0)return luaL_error(L,"unknown tobytes option");
            lua_pop(L,1);
        }
        lua_getfield(L,2,"order");index=lua_gettop(L);
    }
    if(lua_type(L,index)!=LUA_TNONE&&lua_type(L,index)!=LUA_TNIL){
        size_t n=0;const char *value=lua_type(L,index)==LUA_TSTRING?lua_tolstring(L,index,&n):NULL;
        if(!value||n!=1)return luaL_error(L,"order must be a single C/F/A/K string");
        order=(char)toupper((unsigned char)value[0]);
    }
    ln_error err={0};char *bytes;size_t length;
    if(ln_bytes_export(a,order,&bytes,&length,&err)<0)return ln_lua_fail(L,&err);
    lua_pushlstring(L,bytes,length);free(bytes);return 1;
}
int ln_lua_bytes_nbytes(lua_State *L)
{
    size_t size;ln_error err={0};if(ln_bytes_size(input(L),&size,&err)<0)return ln_lua_fail(L,&err);
    lua_pushinteger(L,(lua_Integer)size);return 1;
}
int ln_lua_bytes_itemsize(lua_State *L){lua_pushinteger(L,(lua_Integer)input(L)->descr->elsize);return 1;}
