#include "lua_components.h"
#include "lua_array_api.h"
#include "ln_components.h"
static int part(lua_State *L,int imaginary)
{
    if(lua_gettop(L)<1)return luaL_error(L,"component operation requires an input");
    int index=1;ln_array *a=ln_lua_test_array(L,1);
    if(!a){a=ln_lua_legacy_array(L,1,NULL);index=lua_gettop(L);}
    if(!imaginary&&a->descr->kind!='c'){lua_pushvalue(L,index);return 1;}
    ln_error err={{0}};ln_array *result=ln_component_part(a,imaginary,&err);
    return result?ln_lua_push_array(L,result):ln_lua_fail(L,&err);
}
int ln_lua_real(lua_State *L){return part(L,0);}
int ln_lua_imag(lua_State *L){return part(L,1);}
