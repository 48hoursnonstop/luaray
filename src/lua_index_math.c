#include "lua_index_math.h"
#include "lua_array_api.h"
#include "ln_index_math.h"
#include <ctype.h>
#include <stdint.h>
#include <string.h>

static void dense_keys(lua_State *L,int index,size_t length)
{
    index=lua_absindex(L,index);lua_pushnil(L);
    while(lua_next(L,index)){
        if(!lua_isinteger(L,-2))luaL_error(L,"expected a dense Lua sequence");
        lua_Integer key=lua_tointegerx(L,-2,NULL);
        if(key<1||(uintmax_t)key>length)luaL_error(L,"expected a dense Lua sequence");
        lua_pop(L,1);
    }
}
static int target_shape(lua_State *L,int index,ln_intp *shape)
{
    if(lua_isinteger(L,index)){
        lua_Integer value=lua_tointegerx(L,index,NULL);
        if(value<0||(uintmax_t)value>INTPTR_MAX)luaL_error(L,"invalid target dimension");
        shape[0]=(ln_intp)value;return 1;
    }
    luaL_checktype(L,index,LUA_TTABLE);size_t n=lua_rawlen(L,index);
    if(n>LN_MAXDIMS)luaL_error(L,"target shape rank exceeds 64");
    dense_keys(L,index,n);
    for(size_t i=0;i<n;i++){
        lua_geti(L,index,(lua_Integer)i+1);
        if(!lua_isinteger(L,-1))luaL_error(L,"target dimensions must be Lua integers");
        lua_Integer value=lua_tointegerx(L,-1,NULL);lua_pop(L,1);
        if(value<0||(uintmax_t)value>INTPTR_MAX)luaL_error(L,"invalid target dimension");
        shape[i]=(ln_intp)value;
    }
    return (int)n;
}
static char read_order(lua_State *L,int index)
{
    if(lua_type(L,index)==LUA_TNONE||lua_type(L,index)==LUA_TNIL)return 'C';
    size_t length=0;const char *text=lua_type(L,index)==LUA_TSTRING?lua_tolstring(L,index,&length):NULL;
    char order=text&&length==1?(char)toupper((unsigned char)text[0]):0;
    if(order!='C'&&order!='F')luaL_error(L,"index order must be C or F");
    return order;
}
static ln_index_mode read_mode(lua_State *L,int index)
{
    int type=lua_type(L,index);
    if(type==LUA_TNONE||type==LUA_TNIL)return LN_INDEX_RAISE;
    if(lua_isinteger(L,index)){
        lua_Integer value=lua_tointegerx(L,index,NULL);
        if(value>=0&&value<=2)return (ln_index_mode)value;
    }else if(type==LUA_TSTRING){
        size_t length;const char *value=lua_tolstring(L,index,&length);
        if(length==5&&!memcmp(value,"raise",5))return LN_INDEX_RAISE;
        if(length==4&&!memcmp(value,"wrap",4))return LN_INDEX_WRAP;
        if(length==4&&!memcmp(value,"clip",4))return LN_INDEX_CLIP;
    }
    luaL_error(L,"coordinate mode must be raise, wrap or clip");return LN_INDEX_RAISE;
}
static void read_modes(lua_State *L,int index,int nd,ln_index_mode *modes)
{
    if(lua_type(L,index)==LUA_TTABLE){
        index=lua_absindex(L,index);
        if(lua_rawlen(L,index)!=(size_t)nd)luaL_error(L,"mode sequence must match target shape rank");
        dense_keys(L,index,(size_t)nd);
        for(int i=0;i<nd;i++){lua_geti(L,index,i+1);modes[i]=read_mode(L,-1);lua_pop(L,1);}
    }else{
        ln_index_mode mode=read_mode(L,index);
        for(int i=0;i<nd;i++)modes[i]=mode;
    }
}
static void option_keys(lua_State *L,int index,int allow_mode)
{
    index=lua_absindex(L,index);lua_pushnil(L);
    while(lua_next(L,index)){
        size_t length=0;const char *key=lua_type(L,-2)==LUA_TSTRING?lua_tolstring(L,-2,&length):NULL;
        int known=key&&((length==5&&!memcmp(key,"order",5))||
                       (allow_mode&&length==4&&!memcmp(key,"mode",4)));
        if(!known)
            luaL_error(L,"unsupported index option");
        lua_pop(L,1);
    }
}
int ln_lua_ravel_multi_index(lua_State *L)
{
    ln_intp shape[LN_MAXDIMS];int nd=target_shape(L,2,shape);
    if(nd>=LN_MAXDIMS)return luaL_error(L,"ravel supports at most 63 coordinate axes");
    ln_index_mode modes[LN_MAXDIMS];char order='C';
    if(lua_type(L,3)==LUA_TTABLE){
        option_keys(L,3,1);
        lua_getfield(L,3,"mode");read_modes(L,-1,nd,modes);lua_pop(L,1);
        lua_getfield(L,3,"order");order=read_order(L,-1);lua_pop(L,1);
        if(lua_gettop(L)>3)return luaL_error(L,"cannot combine an options table with positional order");
    }else{read_modes(L,3,nd,modes);order=read_order(L,4);}
    ln_array *container=ln_lua_test_array(L,1);
    if(container){
        if(container->nd==0||container->dimensions[0]!=nd)return luaL_error(L,"coordinate sequence must match target shape rank");
    }else{
        luaL_checktype(L,1,LUA_TTABLE);
        if(lua_rawlen(L,1)!=(size_t)nd)return luaL_error(L,"coordinate sequence must match target shape rank");
        dense_keys(L,1,(size_t)nd);
    }
    luaL_checkstack(L,2*nd+8,"coordinate buffers");
    const ln_array *coordinates[LN_MAXDIMS];
    for(int i=0;i<nd;i++){
        if(container){
            ln_error error={0};
            ln_array *row=container->nd==1
                ?ln_array_view(container,0,NULL,NULL,container->data+i*container->strides[0],&error)
                :ln_array_index_axis0(container,i+1,&error);
            if(!row)return ln_lua_fail(L,&error);
            ln_lua_push_array(L,row);coordinates[i]=row;
        }else{
            lua_geti(L,1,i+1);coordinates[i]=ln_lua_test_array(L,-1);
            if(!coordinates[i])coordinates[i]=ln_lua_legacy_array(L,-1,NULL);
        }
    }
    ln_error error={0};ln_array *result=ln_ravel_multi_index(nd,shape,coordinates,modes,order,&error);
    if(!result)return ln_lua_fail(L,&error);
    return ln_lua_push_scalar_or_array(L,result);
}
int ln_lua_unravel_index(lua_State *L)
{
    ln_intp shape[LN_MAXDIMS];int nd=target_shape(L,2,shape);char order;
    if(lua_type(L,3)==LUA_TTABLE){
        option_keys(L,3,0);lua_getfield(L,3,"order");order=read_order(L,-1);lua_pop(L,1);
    }else order=read_order(L,3);
    ln_array *indices=ln_lua_test_array(L,1);
    if(!indices)indices=ln_lua_legacy_array(L,1,NULL);
    ln_error error={0};ln_array *storage=ln_unravel_index_storage(indices,nd,shape,order,&error);
    if(!storage)return ln_lua_fail(L,&error);
    ln_lua_push_array(L,storage); /* Roots ownership before allocating tables/views. */
    lua_createtable(L,nd,0);int result=lua_absindex(L,-1);
    for(int i=0;i<nd;i++){
        if(indices->nd==0){
            ln_intp value;memcpy(&value,storage->data+i*sizeof(value),sizeof value);lua_pushinteger(L,(lua_Integer)value);
        }else{
            /* Empty coordinate views may have offsets beyond a zero-byte
             * allocation. Form their non-dereferenced addresses as integers. */
            uintptr_t address=(uintptr_t)storage->data,offset=(uintptr_t)i*sizeof(ln_intp);
            if(offset>UINTPTR_MAX-address)return luaL_error(L,"coordinate view address overflow");
            ln_array *view=ln_array_view(storage,indices->nd,indices->dimensions,
                storage->strides,(char*)(address+offset),&error);
            if(!view)return ln_lua_fail(L,&error);
            ln_lua_push_array(L,view);
        }
        lua_seti(L,result,i+1);
    }
    return 1;
}
