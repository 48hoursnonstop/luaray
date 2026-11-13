#include "lua_components.h"
#include "lua_array_api.h"
#include "ln_components.h"
#include "ln_ufunc.h"
#include "ln_write.h"
#include <string.h>
static int part(lua_State *L,int imaginary)
{
    if(lua_gettop(L)<1)return luaL_error(L,"component operation requires an input");
    int index=1;ln_array *a=ln_lua_test_array(L,1);
    if(!a){a=ln_lua_legacy_array(L,1,NULL);index=lua_gettop(L);}
    if(!imaginary&&a->descr->kind!='c'){lua_pushvalue(L,index);return 1;}
    ln_error err={0};ln_array *result=ln_component_part(a,imaginary,&err);
    return result?ln_lua_push_array(L,result):ln_lua_fail(L,&err);
}
int ln_lua_real(lua_State *L){return part(L,0);}
int ln_lua_imag(lua_State *L){return part(L,1);}

static ln_array *coerce(lua_State *L,int *index)
{
    if(lua_gettop(L)<1)luaL_error(L,"reality operation requires an input");
    ln_array *a=ln_lua_test_array(L,1);*index=1;
    if(!a){a=ln_lua_legacy_array(L,1,NULL);*index=lua_gettop(L);}
    return a;
}
static int reality(lua_State *L,int real,int object)
{
    int index;ln_array *a=coerce(L,&index);(void)index;
    if(object){lua_pushboolean(L,real?(a->descr->kind!='c'):(a->descr->kind=='c'));return 1;}
    ln_error err={0};ln_array *out=ln_component_reality(a,real,&err);
    return out?ln_lua_push_array(L,out):ln_lua_fail(L,&err);
}
int ln_lua_isreal(lua_State *L){return reality(L,1,0);}
int ln_lua_iscomplex(lua_State *L){return reality(L,0,0);}
int ln_lua_isrealobj(lua_State *L){return reality(L,1,1);}
int ln_lua_iscomplexobj(lua_State *L){return reality(L,0,1);}
int ln_lua_real_if_close(lua_State *L)
{
    int top=lua_gettop(L),toltype=top>=2?lua_type(L,2):LUA_TNONE,index;
    ln_array *a=coerce(L,&index);
    /* The source returns real inputs before it even examines tolerance. */
    if(a->descr->kind!='c'){lua_pushvalue(L,index);return 1;}
    long double tol=100;
    if(toltype==LUA_TBOOLEAN)tol=lua_toboolean(L,2)?1:0;
    else if(toltype!=LUA_TNONE&&toltype!=LUA_TNIL){
        if(toltype!=LUA_TNUMBER)return luaL_error(L,"tol must be a Lua number or boolean");
        if(lua_isinteger(L,2))tol=(long double)lua_tointegerx(L,2,NULL);
        else{int ok=0;tol=(long double)lua_tonumberx(L,2,&ok);if(!ok)return luaL_error(L,"invalid tolerance");}
    }
    ln_error err={0};int identity=0;
    ln_array *out=ln_component_close(a,tol,&identity,&err);
    if(!out)return ln_lua_fail(L,&err);
    if(identity){ln_array_free(out);lua_pushvalue(L,index);return 1;}
    return ln_lua_push_array(L,out);
}

/* calculation.c:PyArray_Conjugate has a real-valued identity/assignment path
 * distinct from the root conjugate ufunc. */
int ln_lua_array_conjugate(lua_State *L)
{
    if(lua_gettop(L)<1||lua_gettop(L)>2)return luaL_error(L,"conjugate expects one optional output");
    ln_array *a=ln_lua_test_array(L,1);if(!a)return luaL_error(L,"conjugate method requires an ndarray");
    int index=2;
    if(lua_type(L,2)==LUA_TTABLE){
        lua_pushnil(L);
        while(lua_next(L,2)){
            size_t n=0;const char *key=lua_type(L,-2)==LUA_TSTRING?lua_tolstring(L,-2,&n):NULL;
            if(!key||n!=3||memcmp(key,"out",3))return luaL_error(L,"conjugate method only supports out");
            lua_pop(L,1);
        }
        lua_getfield(L,2,"out");index=lua_gettop(L);
    }
    ln_array *out=NULL;
    if(lua_type(L,index)!=LUA_TNONE&&lua_type(L,index)!=LUA_TNIL){
        out=ln_lua_test_array(L,index);
        if(!out)return luaL_error(L,"conjugate output must be an ndarray");
    }
    if(!strchr("biufc",a->descr->kind))return luaL_error(L,"cannot conjugate non-numeric dtype");
    ln_error err={0};
    if(a->descr->kind!='c'){
        if(!out){lua_pushvalue(L,1);return 1;}
        if(ln_array_copyto(out,a,NULL,1,LN_SAME_KIND_CASTING,&err)<0)return ln_lua_fail(L,&err);
        lua_pushvalue(L,index);return 1;
    }
    int existing=out!=NULL;const ln_array *inputs[]={a};
    if(ln_ufunc_execute(ln_ufunc_by_name("conjugate"),inputs,&out,NULL,&err)<0)return ln_lua_fail(L,&err);
    if(existing){lua_pushvalue(L,index);return 1;}
    return ln_lua_push_array(L,out);
}
