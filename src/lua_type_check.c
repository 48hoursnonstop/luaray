#include "lua_type_check.h"
#include "lua_array_api.h"
#include "ln_type_check.h"
#include <stdlib.h>
static int selected(lua_State *L,const ln_dtype *dtype,int index)
{
 ln_error error={0};const ln_dtype *kind=ln_lua_test_dtype(L,index);int result;
 if(kind)result=ln_isdtype_class(dtype,kind,&error);
 else if(lua_type(L,index)==LUA_TSTRING){
  size_t length;const char *text=lua_tolstring(L,index,&length);
  result=ln_isdtype_kind(dtype,text,length,&error);
 }else return luaL_error(L,"isdtype selectors must be dtype descriptors or category strings");
 if(result<0)return ln_lua_fail(L,&error);
 return result;
}
int ln_lua_isdtype(lua_State *L)
{
 if(lua_gettop(L)!=2)return luaL_error(L,"isdtype expects a dtype descriptor and a selector");
 const ln_dtype *dtype=ln_lua_test_dtype(L,1);
 if(!dtype)return luaL_error(L,"isdtype input must be an actual dtype descriptor");
 int result=0;
 if(lua_type(L,2)==LUA_TTABLE){
  size_t count=lua_rawlen(L,2);lua_pushnil(L);
  while(lua_next(L,2)){
   if(!lua_isinteger(L,-2)||lua_tointegerx(L,-2,NULL)<1||
      (uint64_t)lua_tointegerx(L,-2,NULL)>(uint64_t)count)
       return luaL_error(L,"isdtype selector sequence must be dense");
   lua_pop(L,1);
  }
  for(size_t i=0;i<count;++i){
   lua_rawgeti(L,2,(lua_Integer)i+1);
   /* Validate every entry, including those after an already matching kind. */
   int match=selected(L,dtype,-1);lua_pop(L,1);result|=match;
  }
 }else result=selected(L,dtype,2);
 lua_pushboolean(L,result);return 1;
}
int ln_lua_common_type(lua_State *L)
{
 int count=lua_gettop(L);
 for(int i=1;i<=count;++i)if(!ln_lua_test_array(L,i))return luaL_error(L,"common_type arguments must be ndarrays");
 if((size_t)count>SIZE_MAX/sizeof(ln_dtype*))return luaL_error(L,"too many common_type arguments");
 const ln_dtype **types=count?malloc((size_t)count*sizeof(*types)):NULL;
 if(count&&!types)return luaL_error(L,"out of memory");
 for(int i=0;i<count;++i)types[i]=ln_lua_test_array(L,i+1)->descr;
 ln_error error={0};const ln_dtype *result=ln_common_inexact_type(types,(size_t)count,&error);free(types);
 return result?ln_lua_push_dtype(L,result):ln_lua_fail(L,&error);
}
