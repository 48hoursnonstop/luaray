#include "lua_constructor.h"
#include "lua_array_api.h"
#include "ln_constructor.h"
#include <ctype.h>
#include <string.h>
static ln_intp integer(lua_State *L,int index)
{
    if(!lua_isinteger(L,index))luaL_error(L,"shape, stride and offset entries must be Lua integers");
    lua_Integer n=lua_tointegerx(L,index,NULL);
    if(n<INTPTR_MIN||n>INTPTR_MAX)luaL_error(L,"layout entry is outside native integer range");
    return (ln_intp)n;
}
static int sequence(lua_State *L,int index,ln_intp *values,int scalar)
{
    if(scalar&&lua_isinteger(L,index)){values[0]=integer(L,index);return 1;}
    if(lua_type(L,index)!=LUA_TTABLE)luaL_error(L,"shape/strides must be integer sequences");
    int absolute=lua_absindex(L,index);size_t count=lua_rawlen(L,index);
    if(count>LN_MAXDIMS)luaL_error(L,"maximum ndarray rank is 64");
    lua_pushnil(L);
    while(lua_next(L,absolute)){
        if(!lua_isinteger(L,-2)||lua_tointegerx(L,-2,NULL)<1||
           (size_t)lua_tointegerx(L,-2,NULL)>count)
            luaL_error(L,"shape/strides must be dense integer sequences");
        lua_pop(L,1);
    }
    for(size_t i=0;i<count;++i){lua_geti(L,absolute,(lua_Integer)i+1);values[i]=integer(L,-1);lua_pop(L,1);}
    return (int)count;
}
int ln_lua_ndarray(lua_State *L)
{
    int argc=lua_gettop(L);if(argc<1||argc>3)return luaL_error(L,"ndarray expects shape, optional dtype and layout options");
    ln_intp dims[LN_MAXDIMS],steps[LN_MAXDIMS],offset=0;int nd=sequence(L,1,dims,1),custom=0,fortran=0,options=0,buffer_index=0;
    const ln_dtype *dtype=ln_dtype_by_num(LN_DOUBLE);
    if(argc>=2&&lua_type(L,2)!=LUA_TNIL){
        if(lua_type(L,2)==LUA_TTABLE)options=2;
        else dtype=ln_lua_check_dtype(L,2);
    }
    if(argc==3){if(options||lua_type(L,3)!=LUA_TTABLE)return luaL_error(L,"layout options must be one table");options=3;}
    if(options){
        lua_pushnil(L);
        while(lua_next(L,options)){
            size_t length;const char *name=lua_type(L,-2)==LUA_TSTRING?lua_tolstring(L,-2,&length):NULL;
            if(!name||strlen(name)!=length||(strcmp(name,"dtype")&&strcmp(name,"buffer")&&strcmp(name,"offset")&&strcmp(name,"strides")&&strcmp(name,"order")))return luaL_error(L,"unknown ndarray layout option");
            lua_pop(L,1);
        }
        lua_getfield(L,options,"dtype");
        if(lua_type(L,-1)!=LUA_TNIL){if(options==3&&lua_type(L,2)!=LUA_TNIL)return luaL_error(L,"dtype specified twice");dtype=ln_lua_check_dtype(L,-1);}lua_pop(L,1);
        lua_getfield(L,options,"offset");if(lua_type(L,-1)!=LUA_TNIL)offset=integer(L,-1);lua_pop(L,1);
        lua_getfield(L,options,"strides");
        if(lua_type(L,-1)!=LUA_TNIL){if(sequence(L,-1,steps,1)!=nd)return luaL_error(L,"strides and shape must have the same rank");custom=1;}lua_pop(L,1);
        lua_getfield(L,options,"order");
        if(lua_type(L,-1)!=LUA_TNIL){
            size_t length;const char *order=lua_type(L,-1)==LUA_TSTRING?lua_tolstring(L,-1,&length):NULL;
            if(!order||length!=1)return luaL_error(L,"order must be C, F, A or K");
            int c=toupper((unsigned char)order[0]);if(c!='C'&&c!='F'&&c!='A'&&c!='K')return luaL_error(L,"order must be C, F, A or K");fortran=c=='F';
        }lua_pop(L,1);
        lua_getfield(L,options,"buffer");if(lua_type(L,-1)!=LUA_TNIL)buffer_index=lua_gettop(L);else lua_pop(L,1);
    }
    ln_array *buffer=buffer_index?ln_lua_buffer_storage(L,buffer_index):NULL;
    ln_error error={0};ln_array *result=ln_array_construct(nd,dims,dtype,buffer,offset,custom?steps:NULL,fortran,&error);
    return result?ln_lua_push_array(L,result):ln_lua_fail(L,&error);
}
