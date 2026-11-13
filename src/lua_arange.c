#include "lua_arange.h"
#include "lua_array_api.h"
#include "ln_arange.h"
#include <string.h>
int ln_lua_arange(lua_State *L)
{
    int argc=lua_gettop(L),end=argc,options=0;
    if(argc<1||argc>4)return luaL_error(L,"arange expects stop or start, stop, optional step and dtype");
    const ln_dtype *dtype=NULL;
    if(lua_type(L,end)==LUA_TTABLE){options=end--;}
    else if(lua_type(L,end)==LUA_TSTRING||ln_lua_test_dtype(L,end)){dtype=ln_lua_check_dtype(L,end--);}
    else if(argc==4&&lua_type(L,end)==LUA_TNIL)--end;
    if(options){
        lua_pushnil(L);
        while(lua_next(L,options)){
            size_t length;const char *name=lua_type(L,-2)==LUA_TSTRING?lua_tolstring(L,-2,&length):NULL;
            if(!name||length!=5||memcmp(name,"dtype",5))return luaL_error(L,"arange options only support dtype");
            lua_pop(L,1);
        }
        lua_getfield(L,options,"dtype");if(lua_type(L,-1)!=LUA_TNIL)dtype=ln_lua_check_dtype(L,-1);lua_pop(L,1);
    }
    if(end<1||end>3)return luaL_error(L,"arange expects one to three numeric arguments");
    int integer_stop=0;lua_Integer n=lua_tointegerx(L,1,&integer_stop);
    if(argc==2&&end==1&&!options&&dtype&&lua_type(L,1)==LUA_TNUMBER&&integer_stop){
        if(n<INTPTR_MIN||n>INTPTR_MAX)return luaL_error(L,"legacy arange stop is outside native index range");
        ln_error error={0};ln_array *result=ln_array_arange_legacy((ln_intp)n,dtype,&error);
        return result?ln_lua_push_array(L,result):ln_lua_fail(L,&error);
    }
    ln_ufunc_operand start={.kind=LN_UFUNC_WEAK_INT},stop,step={.kind=LN_UFUNC_WEAK_INT,.integer=1};
    int single=end==1||lua_type(L,2)==LUA_TNIL;
    if(!ln_lua_operand(L,1,single?&stop:&start))return luaL_error(L,"arange arguments must be numeric scalars");
    if(!single&&!ln_lua_operand(L,2,&stop))return luaL_error(L,"arange stop must be a numeric scalar");
    if(end>=3&&lua_type(L,3)!=LUA_TNIL&&!ln_lua_operand(L,3,&step))return luaL_error(L,"arange step must be a numeric scalar");
    ln_error error={0};ln_array *result=ln_array_arange(&start,&stop,&step,dtype,&error);
    return result?ln_lua_push_array(L,result):ln_lua_fail(L,&error);
}
