#include "lua_dtype.h"
#include "lua_array_api.h"
#include "ln_dtype_info.h"
#include <string.h>
#define DTYPE_MT "luaray.dtype"
typedef struct {const ln_dtype *descriptor;} lua_dtype;
const ln_dtype *ln_lua_test_dtype(lua_State *L,int index)
{
    lua_dtype *value=luaL_testudata(L,index,DTYPE_MT);return value?value->descriptor:NULL;
}
const ln_dtype *ln_lua_check_dtype(lua_State *L,int index)
{
    const ln_dtype *dtype=ln_lua_test_dtype(L,index);if(dtype)return dtype;
    if(lua_type(L,index)!=LUA_TSTRING){luaL_error(L,"dtype must be a supported string or dtype descriptor");return NULL;}
    size_t length;const char *name=lua_tolstring(L,index,&length);
    dtype=strlen(name)==length?ln_dtype_by_name(name):NULL;
    if(!dtype)luaL_error(L,"unsupported dtype descriptor");
    return dtype;
}
static const ln_dtype *input(lua_State *L)
{return ((lua_dtype*)luaL_checkudata(L,1,DTYPE_MT))->descriptor;}
static int representation(lua_State *L,const ln_dtype *dtype,int typestr,int display)
{
    char text[160];ln_error error={0};
    if(display&&(dtype->kind=='S'||dtype->kind=='U'||dtype->kind=='M'||dtype->kind=='m')){
        lua_pushstring(L,dtype->name);return 1;
    }
    if((typestr?ln_dtype_typestr(dtype,text,sizeof text,&error):ln_dtype_name(dtype,text,sizeof text,&error))<0)
        return ln_lua_fail(L,&error);
    lua_pushstring(L,text);return 1;
}
static int get(lua_State *L)
{
    const ln_dtype *d=input(L);size_t length;const char *key=lua_type(L,2)==LUA_TSTRING?lua_tolstring(L,2,&length):NULL;
    if(!key||strlen(key)!=length)return luaL_error(L,"unknown dtype property");
    if(!strcmp(key,"name"))return representation(L,d,0,0);
    if(!strcmp(key,"str"))return representation(L,d,1,0);
    if(!strcmp(key,"kind")||!strcmp(key,"char")||!strcmp(key,"byteorder")){
        char c=!strcmp(key,"kind")?d->kind:!strcmp(key,"char")?ln_dtype_char(d):ln_dtype_byteorder(d);
        lua_pushlstring(L,&c,1);return 1;
    }
    if(!strcmp(key,"itemsize")){lua_pushinteger(L,(lua_Integer)d->elsize);return 1;}
    if(!strcmp(key,"alignment")){lua_pushinteger(L,(lua_Integer)d->alignment);return 1;}
    if(!strcmp(key,"num")){lua_pushinteger(L,d->type_num);return 1;}
    if(!strcmp(key,"flags")){lua_pushinteger(L,(lua_Integer)d->flags);return 1;}
    if(!strcmp(key,"ndim")){lua_pushinteger(L,0);return 1;}
    if(!strcmp(key,"shape")){lua_createtable(L,0,0);return 1;}
    if(!strcmp(key,"base")){lua_pushvalue(L,1);return 1;}
    if(!strcmp(key,"hasobject")||!strcmp(key,"isalignedstruct")){lua_pushboolean(L,0);return 1;}
    if(!strcmp(key,"isnative")){char order=ln_dtype_byteorder(d);lua_pushboolean(L,order=='='||order=='|');return 1;}
    if(!strcmp(key,"fields")||!strcmp(key,"subdtype")||!strcmp(key,"names")||!strcmp(key,"metadata")){lua_pushnil(L);return 1;}
    if(!strcmp(key,"descr")){
        lua_createtable(L,1,0);lua_createtable(L,2,0);
        lua_pushstring(L,"");lua_seti(L,-2,1);representation(L,d,1,0);lua_seti(L,-2,2);lua_seti(L,-2,1);return 1;
    }
    return luaL_error(L,"unsupported dtype property");
}
static int immutable(lua_State *L){(void)L;return luaL_error(L,"dtype descriptors are immutable");}
static int equal(lua_State *L)
{
    const ln_dtype *a=ln_lua_test_dtype(L,1),*b=ln_lua_test_dtype(L,2);
    lua_pushboolean(L,ln_dtype_equivalent(a,b));return 1;
}
static int describe(lua_State *L){return representation(L,input(L),0,1);}
int ln_lua_push_dtype(lua_State *L,const ln_dtype *d)
{
    if(luaL_newmetatable(L,DTYPE_MT)){
        lua_pushcfunction(L,get);lua_setfield(L,-2,"__index");
        lua_pushcfunction(L,immutable);lua_setfield(L,-2,"__newindex");
        lua_pushcfunction(L,equal);lua_setfield(L,-2,"__eq");
        lua_pushcfunction(L,describe);lua_setfield(L,-2,"__tostring");
    }
    lua_pop(L,1);lua_dtype *value=lua_newuserdatauv(L,sizeof(*value),0);value->descriptor=d;
    luaL_setmetatable(L,DTYPE_MT);return 1;
}

int ln_lua_dtype_constructor(lua_State *L)
{
    int argc=lua_gettop(L);if(argc>1)return luaL_error(L,"dtype accepts one optional string or descriptor");
    if(argc==1&&ln_lua_test_dtype(L,1)){lua_pushvalue(L,1);return 1;}
    const ln_dtype *d=argc==0||lua_type(L,1)==LUA_TNIL?ln_dtype_by_num(LN_DOUBLE):ln_lua_check_dtype(L,1);
    return ln_lua_push_dtype(L,d);
}
