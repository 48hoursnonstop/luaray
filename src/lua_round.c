#include "lua_round.h"
#include "lua_array_api.h"
#include "ln_round.h"
#include <limits.h>
#include <string.h>
static int decimals_value(lua_State *L,int index)
{
    if(lua_type(L,index)==LUA_TBOOLEAN)return lua_toboolean(L,index)?1:0;
    if(!lua_isinteger(L,index))luaL_error(L,"decimals must be a Lua integer");
    lua_Integer value=lua_tointegerx(L,index,NULL);
    if(value<INT_MIN||value>INT_MAX)luaL_error(L,"decimals exceeds native int range");
    return (int)value;
}
static int round_call(lua_State *L,int root)
{
    int top=lua_gettop(L),decimals=0,out_index=0,options=0;
    ln_array *out=NULL;
    if(top<1)return luaL_error(L,"round requires an input");
    if(top>=2&&lua_type(L,2)!=LUA_TNIL){
        if(lua_type(L,2)==LUA_TTABLE&&!ln_lua_test_array(L,2)){
            options=2;lua_pushnil(L);
            while(lua_next(L,2)){
                size_t n=0;const char *key=lua_type(L,-2)==LUA_TSTRING?lua_tolstring(L,-2,&n):NULL;
                if(!key||!((n==8&&memcmp(key,"decimals",8)==0)||(n==3&&memcmp(key,"out",3)==0)))
                    return luaL_error(L,"unknown round option");
                lua_pop(L,1);
            }
            lua_getfield(L,2,"decimals");
            if(lua_type(L,-1)!=LUA_TNIL)decimals=decimals_value(L,-1);
            lua_pop(L,1);lua_getfield(L,2,"out");
            if(lua_type(L,-1)!=LUA_TNIL){out=ln_lua_test_array(L,-1);if(!out)return luaL_error(L,"out must be an ndarray");}
            lua_pop(L,1);
            if(top>=3&&lua_type(L,3)!=LUA_TNIL)return luaL_error(L,"duplicate round output/options");
        }else decimals=decimals_value(L,2);
    }
    if(!options&&top>=3&&lua_type(L,3)!=LUA_TNIL){
        out=ln_lua_test_array(L,3);if(!out)return luaL_error(L,"out must be an ndarray");out_index=3;
    }
    /* Parse every optional slot before constructor coercion adds stack roots. */
    ln_array *a=ln_lua_test_array(L,1);int had_method=a!=NULL;
    if(!a)a=ln_lua_legacy_array(L,1,NULL);
    ln_array *result=out;ln_error err={0};
    int rc=ln_array_round(a,decimals,&result,&err);
    /* fromnumeric.py:_wrapfunc retries only a TypeError from an existing
     * bound method. Ordinary Lua input coercion corresponds to _wrapit once. */
    if(rc<0&&root&&had_method&&err.kind==LN_ERROR_TYPE){result=out;rc=ln_array_round(a,decimals,&result,&err);}
    if(rc<0)return ln_lua_fail(L,&err);
    if(out){if(out_index)lua_pushvalue(L,out_index);else lua_getfield(L,options,"out");return 1;}
    return ln_lua_push_array(L,result);
}
int ln_lua_round(lua_State *L){return round_call(L,1);}
int ln_lua_round_method(lua_State *L){return round_call(L,0);}
