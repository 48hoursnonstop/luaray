#include "lua_bytes.h"
#include "lua_array_api.h"
#include "ln_bytes.h"
#include "ln_write.h"
#include "ln_datetime_strings.h"
#include <limits.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
static ln_array *input(lua_State *L)
{
    ln_array *a=ln_lua_test_array(L,1);if(!a)luaL_error(L,"byte methods require an ndarray");return a;
}
int ln_lua_bytes_view(lua_State *L)
{
    ln_array *a=input(L);const ln_dtype *dtype=NULL;
    if(lua_gettop(L)>2)return luaL_error(L,"view accepts one optional dtype");
    if(lua_type(L,2)!=LUA_TNONE&&lua_type(L,2)!=LUA_TNIL){
        dtype=ln_lua_check_dtype(L,2);
    }
    ln_error err={0};ln_array *result=ln_bytes_view(a,dtype,&err);
    return result?ln_lua_push_array(L,result):ln_lua_fail(L,&err);
}
int ln_lua_bytes_export(lua_State *L)
{
    ln_array *a=input(L);char order='C';int index=2;
    if(lua_gettop(L)>2)return luaL_error(L,"tobytes accepts one optional order");
    if(lua_type(L,2)==LUA_TTABLE){
        lua_pushnil(L);
        while(lua_next(L,2)){
            size_t n=0;const char *key=lua_type(L,-2)==LUA_TSTRING?lua_tolstring(L,-2,&n):NULL;
            if(!key||n!=5||memcmp(key,"order",5)!=0)return luaL_error(L,"unknown tobytes option");
            lua_pop(L,1);
        }
        lua_getfield(L,2,"order");index=lua_gettop(L);
    }
    if(lua_type(L,index)!=LUA_TNONE&&lua_type(L,index)!=LUA_TNIL){
        size_t n=0;const char *value=lua_type(L,index)==LUA_TSTRING?lua_tolstring(L,index,&n):NULL;
        if(!value||n!=1)return luaL_error(L,"order must be a single C/F/A/K string");
        order=(char)toupper((unsigned char)value[0]);
    }
    ln_error err={0};char *bytes;size_t length;
    if(ln_bytes_export(a,order,&bytes,&length,&err)<0)return ln_lua_fail(L,&err);
    lua_pushlstring(L,bytes,length);free(bytes);return 1;
}
int ln_lua_bytes_nbytes(lua_State *L)
{
    size_t size;ln_error err={0};if(ln_bytes_size(input(L),&size,&err)<0)return ln_lua_fail(L,&err);
    lua_pushinteger(L,(lua_Integer)size);return 1;
}
int ln_lua_bytes_itemsize(lua_State *L){lua_pushinteger(L,(lua_Integer)input(L)->descr->elsize);return 1;}

int ln_lua_bytes_swap(lua_State *L)
{
    ln_array *a=input(L);int index=2,inplace=0;
    if(lua_gettop(L)>2)return luaL_error(L,"byteswap accepts one optional inplace control");
    if(lua_type(L,2)==LUA_TTABLE){
        lua_pushnil(L);
        while(lua_next(L,2)){
            size_t n=0;const char *key=lua_type(L,-2)==LUA_TSTRING?lua_tolstring(L,-2,&n):NULL;
            if(!key||n!=7||memcmp(key,"inplace",7))return luaL_error(L,"byteswap only supports inplace");
            lua_pop(L,1);
        }
        lua_getfield(L,2,"inplace");index=lua_gettop(L);
    }
    if(lua_type(L,index)!=LUA_TNONE&&lua_type(L,index)!=LUA_TNIL){
        if(lua_type(L,index)!=LUA_TBOOLEAN)return luaL_error(L,"inplace must be a Boolean");
        inplace=lua_toboolean(L,index);
    }
    ln_error err={0};
    if(inplace){
        if(ln_bytes_swap_inplace(a,&err)<0)return ln_lua_fail(L,&err);
        lua_pushvalue(L,1);return 1;
    }
    ln_array *result=ln_bytes_swap_copy(a,&err);
    return result?ln_lua_push_array(L,result):ln_lua_fail(L,&err);
}

static ln_intp field_offset(lua_State *L,int index)
{
    if(lua_type(L,index)==LUA_TNONE||lua_type(L,index)==LUA_TNIL)return 0;
    if(!lua_isinteger(L,index))luaL_error(L,"field offset must be an integer");
    lua_Integer offset=lua_tointegerx(L,index,NULL);
    if(offset<INT_MIN||offset>INT_MAX)luaL_error(L,"field offset exceeds the source C-int range");
    return (ln_intp)offset;
}
static const ln_dtype *field_dtype(lua_State *L,int index)
{return lua_type(L,index)==LUA_TNIL?ln_dtype_by_num(LN_DOUBLE):ln_lua_check_dtype(L,index);}
int ln_lua_bytes_getfield(lua_State *L)
{
    int argc=lua_gettop(L);if(argc<2||argc>3)return luaL_error(L,"getfield expects a dtype and optional byte offset");
    ln_array *a=input(L);const ln_dtype *dtype=field_dtype(L,2);ln_intp offset=field_offset(L,3);
    ln_error err={0};ln_array *field=ln_bytes_field(a,dtype,offset,&err);
    return field?ln_lua_push_array(L,field):ln_lua_fail(L,&err);
}
int ln_lua_bytes_setfield(lua_State *L)
{
    int argc=lua_gettop(L);if(argc<3||argc>4)return luaL_error(L,"setfield expects a value, dtype and optional byte offset");
    ln_array *a=input(L);const ln_dtype *dtype=field_dtype(L,3);ln_intp offset=field_offset(L,4);
    if(!(a->flags&LN_ARRAY_WRITEABLE))return luaL_error(L,"assignment destination is read-only");
    ln_error err={0};ln_array *field=ln_bytes_field(a,dtype,offset,&err);
    if(!field)return ln_lua_fail(L,&err);
    ln_lua_push_array(L,field); /* Root the header before fallible Lua coercion. */
    if(ln_lua_assign_exact_sequence(L,2,field))return 0;
    ln_array *value;
    if(ln_lua_temporal_scalar_dtype(L,2)){
        value=ln_lua_legacy_array(L,2,NULL);
        if(field->descr->kind=='i'){
            int64_t ticks;memcpy(&ticks,value->data,8);
            int integer=ln_datetime_integer_item(ticks,value->descr,&err);
            if(integer<0)return ln_lua_fail(L,&err);
            if(!integer)return luaL_error(L,"temporal scalar item is not an integer");
            lua_pushinteger(L,(lua_Integer)ticks);
            value=ln_lua_assignment_values(L,lua_gettop(L),field->descr);
        }
        if((field->descr->kind=='S'||field->descr->kind=='U')&&value->descr->kind=='M'){
            int64_t ticks;char text[192];memcpy(&ticks,value->data,8);
            if(ln_datetime_scalar_string(ticks,value->descr,text,sizeof text,&err)<0)return ln_lua_fail(L,&err);
            lua_pushstring(L,text);value=ln_lua_assignment_values(L,lua_gettop(L),field->descr);
        }
    }
    else value=ln_lua_assignment_values(L,2,field->descr);
    /* CopyObject limits ordinary sequence discovery to destination rank;
     * typed ndarray values keep CopyInto's leading-unit-axis broadcasting. */
    if(lua_type(L,2)==LUA_TTABLE&&value->nd>field->nd)
        return luaL_error(L,"field assignment sequence exceeds destination rank");
    return ln_array_copyto(field,value,NULL,1,LN_UNSAFE_CASTING,&err)<0?ln_lua_fail(L,&err):0;
}
