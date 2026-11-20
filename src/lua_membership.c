#include "lua_membership.h"
#include "lua_array_api.h"
#include "ln_membership.h"

int ln_lua_isin_table(lua_State *L)
{
    const ln_array *a=ln_lua_test_array(L,1);
    const ln_array *keys=ln_lua_test_array(L,2);
    int fallback=0;
    ln_error err={0};
    ln_array *result=ln_isin_table(a,keys,lua_toboolean(L,3),
                                    lua_toboolean(L,4),&fallback,&err);
    if(fallback){lua_pushnil(L);return 1;}
    if(!result)return ln_lua_fail(L,&err);
    return ln_lua_push_array(L,result);
}
