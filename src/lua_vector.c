#include "lua_vector.h"
#include "lua_array_api.h"
#include "ln_vector.h"
#include <string.h>
static int axis(lua_State *L,lua_Integer raw,int nd)
{
    if(raw==0||raw>nd||raw< -nd)luaL_error(L,"axis is outside Lua one-based range");
    return raw>0?(int)raw-1:nd+(int)raw;
}
static lua_Integer axis_value(lua_State *L,int index)
{
    if(!lua_isinteger(L,index))luaL_error(L,"axis must be a Lua integer");
    return lua_tointegerx(L,index,NULL);
}
static void valid_cross_options(lua_State *L)
{
    lua_pushnil(L);
    while(lua_next(L,3)){
        size_t n=0;const char *k=lua_type(L,-2)==LUA_TSTRING?lua_tolstring(L,-2,&n):NULL;
        if(!k||!((n==4&&memcmp(k,"axis",4)==0)||(n==5&&(!memcmp(k,"axisa",5)||!memcmp(k,"axisb",5)||!memcmp(k,"axisc",5)))))
            luaL_error(L,"unknown cross option");
        lua_pop(L,1);
    }
}
int ln_lua_cross(lua_State *L)
{
    int top=lua_gettop(L);lua_Integer axes[3]={-1,-1,-1};
    if(top<2||lua_type(L,1)==LUA_TNIL||lua_type(L,2)==LUA_TNIL)return luaL_error(L,"cross requires two inputs");
    if(top>3)return luaL_error(L,"cross accepts inputs and an options table");
    if(top==3&&lua_type(L,3)!=LUA_TNIL){
        if(lua_type(L,3)!=LUA_TTABLE)return luaL_error(L,"cross options must be a table");
        valid_cross_options(L);lua_getfield(L,3,"axis");
        if(lua_type(L,-1)!=LUA_TNIL){axes[0]=axes[1]=axes[2]=axis_value(L,-1);lua_pop(L,1);}
        else{
            lua_pop(L,1);const char *keys[]={"axisa","axisb","axisc"};
            for(int i=0;i<3;++i){lua_getfield(L,3,keys[i]);if(lua_type(L,-1)!=LUA_TNIL)axes[i]=axis_value(L,-1);lua_pop(L,1);}
        }
    }
    ln_array *a=ln_lua_test_array(L,1);if(!a)a=ln_lua_legacy_array(L,1,NULL);
    ln_array *b=ln_lua_test_array(L,2);if(!b)b=ln_lua_legacy_array(L,2,NULL);
    int nd=a->nd>b->nd?a->nd:b->nd;
    int aa=axis(L,axes[0],a->nd),bb=axis(L,axes[1],b->nd),cc=axis(L,axes[2],nd);
    ln_error err={0};ln_array *out=ln_vector_cross(a,aa,b,bb,cc,&err);
    return out?ln_lua_push_array(L,out):ln_lua_fail(L,&err);
}
int ln_lua_meshgrid(lua_State *L)
{
    int top=lua_gettop(L),copy=1,sparse=0,xy=1;
    if(top<1||lua_type(L,1)!=LUA_TTABLE)return luaL_error(L,"meshgrid inputs must be a sequence table");
    if(top>2)return luaL_error(L,"meshgrid accepts an input table and options");
    if(top==2&&lua_type(L,2)!=LUA_TNIL){
        if(lua_type(L,2)!=LUA_TTABLE)return luaL_error(L,"meshgrid options must be a table");
        lua_pushnil(L);
        while(lua_next(L,2)){
            size_t n=0;const char *k=lua_type(L,-2)==LUA_TSTRING?lua_tolstring(L,-2,&n):NULL;
            if(!k||!((n==4&&!memcmp(k,"copy",4))||(n==6&&!memcmp(k,"sparse",6))||(n==8&&!memcmp(k,"indexing",8))))
                return luaL_error(L,"unknown meshgrid option");
            lua_pop(L,1);
        }
        const char *keys[]={"copy","sparse"};int *values[]={&copy,&sparse};
        for(int i=0;i<2;++i){lua_getfield(L,2,keys[i]);if(lua_type(L,-1)!=LUA_TNIL){if(lua_type(L,-1)!=LUA_TBOOLEAN)return luaL_error(L,"meshgrid copy/sparse must be boolean");*values[i]=lua_toboolean(L,-1);}lua_pop(L,1);}
        lua_getfield(L,2,"indexing");
        if(lua_type(L,-1)!=LUA_TNIL){
            size_t n=0;const char *k=lua_type(L,-1)==LUA_TSTRING?lua_tolstring(L,-1,&n):NULL;
            if(!k||n!=2||(memcmp(k,"xy",2)&&memcmp(k,"ij",2)))return luaL_error(L,"indexing must be xy or ij");
            xy=!memcmp(k,"xy",2);
        }lua_pop(L,1);
    }
    size_t count=lua_rawlen(L,1);if(count>LN_MAXDIMS)return luaL_error(L,"meshgrid supports at most64 inputs");
    lua_pushnil(L);
    while(lua_next(L,1)){
        if(!lua_isinteger(L,-2))return luaL_error(L,"meshgrid inputs must be a dense sequence");
        lua_Integer key=lua_tointegerx(L,-2,NULL);
        if(key<1||(size_t)key>count)return luaL_error(L,"meshgrid inputs must be a dense sequence");
        lua_pop(L,1);
    }
    luaL_checkstack(L,(int)(count*2+8),"meshgrid input roots");
    const ln_array *inputs[LN_MAXDIMS];ln_array *outputs[LN_MAXDIMS]={0};
    for(size_t i=0;i<count;++i){
        lua_geti(L,1,(lua_Integer)i+1);int index=lua_gettop(L);
        ln_array *a=ln_lua_test_array(L,index);if(!a)a=ln_lua_legacy_array(L,index,NULL);inputs[i]=a;
    }
    ln_error err={0};if(ln_vector_meshgrid((int)count,inputs,copy,sparse,xy,outputs,&err)<0)return ln_lua_fail(L,&err);
    lua_createtable(L,(int)count,0);int table=lua_gettop(L);
    for(size_t i=0;i<count;++i){ln_lua_push_array(L,outputs[i]);lua_seti(L,table,(lua_Integer)i+1);}
    return 1;
}
