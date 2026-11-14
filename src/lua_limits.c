#include "lua_limits.h"
#include "lua_array_api.h"
#include "ln_limits.h"
#include "ln_dtype_info.h"
#include <stdio.h>
#include <string.h>
#define FLOAT_MT "luaray.finfo"
#define INTEGER_MT "luaray.iinfo"
#define FLOAT_CACHE "luaray.finfo_cache"
static const ln_dtype *argument(lua_State *L)
{
 if(lua_gettop(L)!=1||lua_type(L,1)==LUA_TNIL)luaL_error(L,"numeric limits require one dtype or scalar");
 const ln_dtype *dtype=ln_lua_test_dtype(L,1);if(dtype)return dtype;
 if(lua_type(L,1)==LUA_TSTRING)return ln_lua_check_dtype(L,1);
 if(ln_lua_test_array(L,1))luaL_error(L,"pass the array's dtype to numeric limits");
 ln_ufunc_operand value;
 if(ln_lua_operand(L,1,&value)){
  switch(value.kind){
  case LN_UFUNC_WEAK_INT:return ln_dtype_by_name(sizeof(long)==8?"int64":"longlong");
  case LN_UFUNC_WEAK_FLOAT:return ln_dtype_by_num(LN_DOUBLE);
  case LN_UFUNC_WEAK_BOOL:return ln_dtype_by_num(LN_BOOL);
  case LN_UFUNC_WEAK_COMPLEX:return ln_dtype_by_num(LN_CDOUBLE);
  default:break;
  }
 }
 luaL_error(L,"numeric limits require a supported dtype or scalar");return NULL;
}
static int immutable(lua_State *L)
{return luaL_error(L,"numeric limit records are immutable");}
static const char *key(lua_State *L)
{
 size_t length;const char *text=lua_type(L,2)==LUA_TSTRING?lua_tolstring(L,2,&length):NULL;
 if(!text||strlen(text)!=length)luaL_error(L,"invalid numeric limit property");
 return text;
}
static int floating(lua_State *L,const ln_dtype *dtype,long double value)
{
 if(dtype->type_num!=LN_LONGDOUBLE){lua_pushnumber(L,(double)value);return 1;}
 ln_error error={0};ln_array *scalar=ln_array_new(0,NULL,dtype,0,0,&error);
 if(!scalar)return ln_lua_fail(L,&error);
 memcpy(scalar->data,&value,sizeof value);return ln_lua_push_array(L,scalar);
}
static int float_get(lua_State *L)
{
 ln_float_info *f=luaL_checkudata(L,1,FLOAT_MT);const char *name=key(L);
 if(!strcmp(name,"dtype"))return ln_lua_push_dtype(L,f->dtype);
 #define INT_FIELD(field) if(!strcmp(name,#field)){lua_pushinteger(L,f->field);return 1;}
 INT_FIELD(bits) INT_FIELD(nmant) INT_FIELD(minexp) INT_FIELD(maxexp)
 INT_FIELD(precision) INT_FIELD(machep) INT_FIELD(negep) INT_FIELD(nexp) INT_FIELD(iexp)
 #undef INT_FIELD
 #define VALUE_FIELD(field,member) if(!strcmp(name,field))return floating(L,f->dtype,f->member);
 VALUE_FIELD("eps",eps) VALUE_FIELD("epsneg",epsneg) VALUE_FIELD("min",minimum)
 VALUE_FIELD("max",maximum) VALUE_FIELD("resolution",resolution)
 VALUE_FIELD("smallest_normal",smallest_normal) VALUE_FIELD("tiny",smallest_normal)
 VALUE_FIELD("smallest_subnormal",smallest_subnormal)
 #undef VALUE_FIELD
 return luaL_error(L,"unsupported finfo property");
}
static int integer_get(lua_State *L)
{
 ln_integer_info *i=luaL_checkudata(L,1,INTEGER_MT);const char *name=key(L);
 if(!strcmp(name,"dtype"))return ln_lua_push_dtype(L,i->dtype);
 if(!strcmp(name,"bits")){lua_pushinteger(L,i->bits);return 1;}
 if(!strcmp(name,"kind")){lua_pushlstring(L,&i->kind,1);return 1;}
 if(!strcmp(name,"key")){char text[16];snprintf(text,sizeof text,"%c%d",i->kind,i->bits);lua_pushstring(L,text);return 1;}
 if(!strcmp(name,"min")){lua_pushinteger(L,(lua_Integer)i->minimum);return 1;}
 if(!strcmp(name,"max")){
  if(i->maximum<=INT64_MAX){lua_pushinteger(L,(lua_Integer)i->maximum);return 1;}
  ln_error error={0};ln_array *scalar=ln_array_new(0,NULL,i->dtype,0,0,&error);
  if(!scalar)return ln_lua_fail(L,&error);
  memcpy(scalar->data,&i->maximum,8);return ln_lua_push_array(L,scalar);
 }
 return luaL_error(L,"unsupported iinfo property");
}
static int description(lua_State *L,const ln_dtype *dtype,const char *prefix)
{
 char name[80],text[128];ln_error error={0};
 if(ln_dtype_name(dtype,name,sizeof name,&error)<0)return ln_lua_fail(L,&error);
 snprintf(text,sizeof text,"%s(%s)",prefix,name);lua_pushstring(L,text);return 1;
}
static int float_description(lua_State *L)
{ln_float_info *f=luaL_checkudata(L,1,FLOAT_MT);return description(L,f->dtype,"finfo");}
static int integer_description(lua_State *L)
{ln_integer_info *i=luaL_checkudata(L,1,INTEGER_MT);return description(L,i->dtype,"iinfo");}
static void metatable(lua_State *L,const char *name,lua_CFunction get,lua_CFunction describe)
{
 if(luaL_newmetatable(L,name)){
  lua_pushcfunction(L,get);lua_setfield(L,-2,"__index");
  lua_pushcfunction(L,immutable);lua_setfield(L,-2,"__newindex");
  lua_pushcfunction(L,describe);lua_setfield(L,-2,"__tostring");
 }
 lua_pop(L,1);
}
int ln_lua_finfo(lua_State *L)
{
 ln_error error={0};ln_float_info info;if(ln_finfo(argument(L),&info,&error)<0)return ln_lua_fail(L,&error);
 lua_getfield(L,LUA_REGISTRYINDEX,FLOAT_CACHE);
 if(lua_type(L,-1)==LUA_TNIL){
  lua_pop(L,1);lua_createtable(L,0,4);lua_pushvalue(L,-1);lua_setfield(L,LUA_REGISTRYINDEX,FLOAT_CACHE);
 }
 int cache=lua_gettop(L);lua_rawgeti(L,cache,info.dtype->type_num);
 if(lua_type(L,-1)==LUA_TUSERDATA)return 1;
 lua_pop(L,1);metatable(L,FLOAT_MT,float_get,float_description);
 ln_float_info *value=lua_newuserdatauv(L,sizeof(*value),0);*value=info;luaL_setmetatable(L,FLOAT_MT);
 lua_pushvalue(L,-1);lua_seti(L,cache,info.dtype->type_num);return 1;
}
int ln_lua_iinfo(lua_State *L)
{
 ln_error error={0};ln_integer_info info;if(ln_iinfo(argument(L),&info,&error)<0)return ln_lua_fail(L,&error);
 metatable(L,INTEGER_MT,integer_get,integer_description);
 ln_integer_info *value=lua_newuserdatauv(L,sizeof(*value),0);*value=info;luaL_setmetatable(L,INTEGER_MT);return 1;
}
