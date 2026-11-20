#include "lua_busday.h"
#include "lua_array_api.h"
#include "ln_busday.h"

int ln_lua_busday_count(lua_State *L)
{
    const ln_array *a=ln_lua_test_array(L,1);
    const ln_array *b=ln_lua_test_array(L,2);
    const ln_array *weekmask=ln_lua_test_array(L,3);
    const ln_array *holidays=ln_lua_test_array(L,4);
    ln_error err={0};
    ln_array *count=ln_busday_count(a,b,weekmask,holidays,&err);
    if(!count)return ln_lua_fail(L,&err);
    return ln_lua_push_array(L,count);
}
