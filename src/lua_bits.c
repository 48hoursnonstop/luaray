#include "lua_bits.h"
#include "lua_array_api.h"
#include "ln_bits.h"
#include <stdint.h>
#include <string.h>
static int bit_order(lua_State *L,int index,int unpack)
{
    if(lua_type(L,index)==LUA_TNONE||lua_type(L,index)==LUA_TNIL)return 0;
    size_t size=0;const char *value=lua_type(L,index)==LUA_TSTRING?lua_tolstring(L,index,&size):NULL;
    if(value&&!memchr(value,0,size)){
        if(unpack){if(size&&value[0]=='b')return 0;if(size&&value[0]=='l')return 1;}
        else{if(size>=3&&!memcmp(value,"big",3))return 0;if(size>=6&&!memcmp(value,"little",6))return 1;}
    }
    luaL_error(L,unpack?"unpackbits bitorder must begin with b or l":"packbits bitorder must begin with big or little");return 0;
}
static void options(lua_State *L,int index,int unpack)
{
    index=lua_absindex(L,index);lua_pushnil(L);
    while(lua_next(L,index)){
        size_t size=0;const char *key=lua_type(L,-2)==LUA_TSTRING?lua_tolstring(L,-2,&size):NULL;
        if(!key||!((size==4&&!memcmp(key,"axis",4))||(size==8&&!memcmp(key,"bitorder",8))||(unpack&&size==5&&!memcmp(key,"count",5))))
            luaL_error(L,"unsupported bit-packing option");
        lua_pop(L,1);
    }
}
static int execute(lua_State *L,int unpack)
{
    int arguments=lua_gettop(L),axis_index=2,count_index=3,order_index=unpack?4:3;
    if(arguments>(unpack?4:3))return luaL_error(L,"too many bit-packing arguments");
    if(lua_type(L,2)==LUA_TTABLE){
        if(arguments>2)return luaL_error(L,"cannot combine bit-packing options with positional controls");
        options(L,2,unpack);
        lua_getfield(L,2,"axis");axis_index=lua_absindex(L,-1);
        lua_getfield(L,2,"bitorder");order_index=lua_absindex(L,-1);
        if(unpack){lua_getfield(L,2,"count");count_index=lua_absindex(L,-1);}
    }
    int little=bit_order(L,order_index,unpack),flatten=lua_type(L,axis_index)==LUA_TNONE||lua_type(L,axis_index)==LUA_TNIL;
    lua_Integer lua_axis=0;
    if(!flatten){
        if(!lua_isinteger(L,axis_index))return luaL_error(L,"axis must be a Lua integer");
        lua_axis=lua_tointegerx(L,axis_index,NULL);
        if(lua_axis==0)return luaL_error(L,"axis zero is invalid in Lua");
    }
    ln_intp count=0;const ln_intp *count_pointer=NULL;
    if(unpack&&lua_type(L,count_index)!=LUA_TNONE&&lua_type(L,count_index)!=LUA_TNIL){
        if(!lua_isinteger(L,count_index))return luaL_error(L,"count must be a Lua integer");
        lua_Integer value=lua_tointegerx(L,count_index,NULL);
        if(value>INTPTR_MAX||value<INTPTR_MIN)return luaL_error(L,"count exceeds native intp");
        count=(ln_intp)value;count_pointer=&count;
    }
    ln_array *a=ln_lua_test_array(L,1);if(!a)a=ln_lua_legacy_array(L,1,NULL);
    int axis=-1;
    if(!flatten){
        int rank=a->nd?a->nd:1;
        if(lua_axis>0)lua_axis--;else lua_axis+=rank;
        if(lua_axis<0||lua_axis>=rank)return luaL_error(L,"bit axis is outside array rank");
        axis=(int)lua_axis;
    }
    ln_error error={0};ln_array *out=unpack?ln_unpackbits(a,axis,count_pointer,little,&error):ln_packbits(a,axis,little,&error);
    return out?ln_lua_push_array(L,out):ln_lua_fail(L,&error);
}
int ln_lua_packbits(lua_State *L){return execute(L,0);}
int ln_lua_unpackbits(lua_State *L){return execute(L,1);}
