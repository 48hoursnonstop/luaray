#include "lua_layout.h"
#include "lua_array_api.h"
#include "ln_layout.h"
#include <string.h>

typedef struct { char order; int copy; } options;
static char read_order(lua_State *L,int index)
{
    size_t length=0;
    if(lua_type(L,index)!=LUA_TSTRING)luaL_error(L,"order must be a single C/F/A/K string");
    const char *text=lua_tolstring(L,index,&length);
    if(length!=1)luaL_error(L,"order must be a single C/F/A/K string");
    return text[0];
}
static options parse_options(lua_State *L,int index,int reshape)
{
    options out={'C',-1};int t=lua_type(L,index);
    if(t==LUA_TNONE||t==LUA_TNIL)return out;
    if(t==LUA_TSTRING){out.order=read_order(L,index);return out;}
    if(t!=LUA_TTABLE)luaL_error(L,"layout options must be an order string or options table");
    index=lua_absindex(L,index);lua_pushnil(L);
    while(lua_next(L,index)){
        size_t length=0;const char *key=lua_type(L,-2)==LUA_TSTRING?lua_tolstring(L,-2,&length):NULL;
        if(!key||!((length==5&&memcmp(key,"order",5)==0)||
                   (reshape&&length==4&&memcmp(key,"copy",4)==0)))
            luaL_error(L,"unknown layout option");
        lua_pop(L,1);
    }
    lua_getfield(L,index,"order");
    if(lua_type(L,-1)!=LUA_TNIL)out.order=read_order(L,-1);
    lua_pop(L,1);
    if(reshape){
        lua_getfield(L,index,"copy");t=lua_type(L,-1);
        if(t==LUA_TBOOLEAN)out.copy=lua_toboolean(L,-1)?1:0;
        else if(t!=LUA_TNIL){
            size_t length=0;const char *copy=t==LUA_TSTRING?lua_tolstring(L,-1,&length):NULL;
            if(!copy||length!=9||memcmp(copy,"if_needed",9)!=0)
                luaL_error(L,"copy must be true, false or 'if_needed'");
        }
        lua_pop(L,1);
    }
    return out;
}
static ln_array *input(lua_State *L)
{
    ln_array *a=ln_lua_test_array(L,1);
    return a?a:ln_lua_legacy_array(L,1,NULL);
}
int ln_lua_layout_reshape(lua_State *L)
{
    if(lua_gettop(L)<2)return luaL_error(L,"reshape requires an input and shape");
    options opt=parse_options(L,3,1);
    ln_intp shape[LN_MAXDIMS];int nd=0;
    if(ln_lua_shape(L,2,shape,&nd))return 0;
    ln_array *a=input(L);ln_error err={{0}};
    ln_array *result=ln_layout_reshape(a,nd,shape,opt.order,opt.copy,&err);
    return result?ln_lua_push_array(L,result):ln_lua_fail(L,&err);
}
int ln_lua_layout_ravel(lua_State *L)
{
    if(lua_gettop(L)<1)return luaL_error(L,"ravel requires an input");
    options opt=parse_options(L,2,0);
    ln_array *a=input(L);ln_error err={{0}};
    ln_array *result=ln_layout_ravel(a,opt.order,&err);
    return result?ln_lua_push_array(L,result):ln_lua_fail(L,&err);
}
int ln_lua_layout_flatten(lua_State *L)
{
    options opt=parse_options(L,2,0);
    ln_array *a=ln_lua_test_array(L,1);
    if(!a)return luaL_error(L,"flatten method requires an ndarray");
    ln_error err={{0}};ln_array *result=ln_layout_flatten(a,opt.order,&err);
    return result?ln_lua_push_array(L,result):ln_lua_fail(L,&err);
}
