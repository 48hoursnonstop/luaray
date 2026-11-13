#include "lua_buffers.h"
#include "lua_array_api.h"
#include <stdlib.h>
#include <string.h>

/* Lua strings never move and are immutable. Keep a registry reference until
 * the final native view is freed. Use the main state: a creating coroutine may
 * be collected before the escaped array. Native arrays must die by lua_close. */
typedef struct {lua_State *main;int reference;} string_owner;
static void release_string(void *data,void *context)
{
    (void)data;string_owner *owner=context;
    luaL_unref(owner->main,LUA_REGISTRYINDEX,owner->reference);free(owner);
}
static ln_intp integer_option(lua_State *L,int index,ln_intp default_value)
{
    if(lua_type(L,index)==LUA_TNIL||lua_type(L,index)==LUA_TNONE)return default_value;
    if(!lua_isinteger(L,index))luaL_error(L,"buffer count and offset must be Lua integers");
    lua_Integer n=lua_tointegerx(L,index,NULL);
    if(n<INTPTR_MIN||n>INTPTR_MAX)luaL_error(L,"buffer count or offset is outside native index range");
    return (ln_intp)n;
}
int ln_lua_frombuffer(lua_State *L)
{
    int argc=lua_gettop(L);
    if(argc<1||argc>4)return luaL_error(L,"frombuffer expects storage, optional dtype, count and byte offset");
    const ln_dtype *dtype=ln_dtype_by_num(LN_DOUBLE);
    if(argc>=2&&lua_type(L,2)!=LUA_TNIL){
        dtype=ln_lua_check_dtype(L,2);
    }
    ln_intp count=integer_option(L,3,-1),offset=integer_option(L,4,0);ln_error error={0};
    ln_array *source=ln_lua_test_array(L,1),*result;
    if(source){
        result=ln_array_from_array_buffer(source,dtype,count,offset,&error);
        return result?ln_lua_push_array(L,result):ln_lua_fail(L,&error);
    }
    if(lua_type(L,1)!=LUA_TSTRING)return luaL_error(L,"buffer storage must be a binary Lua string or C-contiguous ndarray");
    size_t length;const char *data=lua_tolstring(L,1,&length);
    string_owner *owner=malloc(sizeof(*owner));
    if(!owner)return luaL_error(L,"out of memory");
    lua_rawgeti(L,LUA_REGISTRYINDEX,LUA_RIDX_MAINTHREAD);
    owner->main=lua_tothread(L,-1);lua_pop(L,1);
    lua_pushvalue(L,1);owner->reference=luaL_ref(L,LUA_REGISTRYINDEX);
    result=ln_array_from_buffer((void*)data,length,dtype,count,offset,0,release_string,owner,&error);
    if(!result){release_string((void*)data,owner);return ln_lua_fail(L,&error);}
    return ln_lua_push_array(L,result);
}
