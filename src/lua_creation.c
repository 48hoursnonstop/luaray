/* Lua-native creation/conversion bindings, separate from ndarray metatables. */
#include "lua_creation.h"
#include "lua_array_api.h"
#include "ln_creation.h"
#include "ln_string.h"
#include <ctype.h>
#include <limits.h>
#include <stdint.h>
#include <string.h>

enum creation_kind { ARRAY,ASARRAY,ASANYARRAY,ASCONTIGUOUS,ASFORTRAN,CHKFINITE,
                     COPY,METHOD_COPY,EMPTY_LIKE,ZEROS_LIKE,ONES_LIKE,FULL_LIKE,FULL,EMPTY,ZEROS,ONES };
typedef struct {
    const ln_dtype *dtype;char order;int copy,ndmin,shape_nd,shape_present;
    ln_intp shape[LN_MAXDIMS];
} creation_options;
static char order_arg(lua_State *L,int index)
{
    size_t length;const char *s=luaL_checklstring(L,index,&length);
    char order=(char)toupper((unsigned char)s[0]);
    if(length!=1||(order!='C'&&order!='F'&&order!='A'&&order!='K'))luaL_error(L,"order must be C, F, A or K");
    return order;
}
static const ln_dtype *dtype_arg(lua_State *L,int index)
{
    size_t length;const char *s=luaL_checklstring(L,index,&length);
    const ln_dtype *dtype=strlen(s)==length?ln_dtype_by_name(s):NULL;
    if(!dtype)luaL_error(L,"unsupported creation dtype");
    return dtype;
}
static void parse_options(lua_State *L,int kind,int first,int argc,creation_options *out)
{
    memset(out,0,sizeof(*out));out->order=kind==METHOD_COPY||kind==FULL||kind>=EMPTY?'C':kind==ASCONTIGUOUS?'C':kind==ASFORTRAN?'F':'K';
    out->copy=kind==ARRAY||kind==COPY||kind==METHOD_COPY?1:-1;
    out->ndmin=kind==ASCONTIGUOUS||kind==ASFORTRAN?1:0;
    int table=0,copy_kind=kind==COPY||kind==METHOD_COPY;
    if(argc>=first&&lua_type(L,first)!=LUA_TNIL) {
        if(lua_type(L,first)==LUA_TTABLE)table=first;
        else if(copy_kind)out->order=order_arg(L,first);
        else out->dtype=dtype_arg(L,first);
    }
    if(argc>first) {
        if(table||copy_kind||argc>first+1||lua_type(L,first+1)!=LUA_TTABLE)luaL_error(L,"creation options must be one table");
        table=first+1;
    }
    if(!table)return;
    lua_pushnil(L);
    while(lua_next(L,table)) {
        size_t key_length=0;
        const char *key=lua_type(L,-2)==LUA_TSTRING?lua_tolstring(L,-2,&key_length):NULL;
        int like=kind>=EMPTY_LIKE&&kind<=FULL_LIKE;
        if(!key||strlen(key)!=key_length||(strcmp(key,"dtype")&&strcmp(key,"order")&&strcmp(key,"copy")&&strcmp(key,"ndmin")&&strcmp(key,"shape")&&strcmp(key,"subok")))luaL_error(L,"unknown creation option");
        if(!strcmp(key,"dtype")) {
            if(copy_kind||out->dtype)luaL_error(L,"dtype is not allowed or was specified twice");
            if(lua_type(L,-1)!=LUA_TNIL)out->dtype=dtype_arg(L,-1);
        }
        else if(!strcmp(key,"order")) {
            char order=order_arg(L,-1);
            if((kind==ASCONTIGUOUS&&order!='C')||(kind==ASFORTRAN&&order!='F'))luaL_error(L,"contiguity function fixes its memory order");
            out->order=order;
        }
        else if(!strcmp(key,"copy")) {
            if(kind!=ARRAY&&kind!=ASARRAY&&kind!=ASANYARRAY)luaL_error(L,"copy option is only supported by array/asarray/asanyarray");
            if(lua_type(L,-1)==LUA_TBOOLEAN)out->copy=lua_toboolean(L,-1);
            else if(lua_type(L,-1)==LUA_TSTRING&&lua_rawlen(L,-1)==9&&!strcmp(lua_tostring(L,-1),"if_needed"))out->copy=-1;
            else luaL_error(L,"copy must be a boolean or 'if_needed'");
        }
        else if(!strcmp(key,"ndmin")) {
            if(kind!=ARRAY||!lua_isinteger(L,-1))luaL_error(L,"ndmin requires an integer on array");
            lua_Integer n=lua_tointegerx(L,-1,NULL);
            if(n<INT_MIN||n>INT_MAX)luaL_error(L,"ndmin is outside C integer range");
            out->ndmin=n<0?0:(int)n;
        }
        else if(!strcmp(key,"shape")) {
            if(!like)luaL_error(L,"shape option requires a like constructor");
            ln_lua_shape(L,-1,out->shape,&out->shape_nd);out->shape_present=1;
        }
        else if(!strcmp(key,"subok")) {
            if(kind!=ARRAY&&kind!=COPY&&!like)luaL_error(L,"subok option is unavailable for this function");
            luaL_checktype(L,-1,LUA_TBOOLEAN); /* only the native array class exists */
        }
        lua_pop(L,1);
    }
}
static int convert_function(lua_State *L,int kind)
{
    int argc=lua_gettop(L),copy_kind=kind==COPY||kind==METHOD_COPY;
    if(argc<1||argc>(copy_kind?2:3))return luaL_error(L,"conversion expects input, optional dtype and options");
    creation_options options;parse_options(L,kind,2,argc,&options);
    ln_array *input=ln_lua_test_array(L,1);int input_index=1,untyped=input==NULL;
    if(kind==METHOD_COPY&&untyped)return luaL_error(L,"ndarray copy requires an ndarray");
    if(untyped) {
        if(options.copy==0)return luaL_error(L,"unable to avoid a copy while creating an array as requested");
        input=ln_lua_legacy_array(L,1,options.dtype);input_index=lua_gettop(L);
    }
    ln_error err={0};
    const ln_dtype *dtype=ln_lua_creation_target(L,1,input,options.dtype,&err);if(!dtype)return ln_lua_fail(L,&err);
    int copy=untyped&&options.copy==1?-1:options.copy,identity=0;
    ln_array *result=ln_creation_convert(input,dtype,options.order,copy,options.ndmin,&identity,&err);
    if(!result)return ln_lua_fail(L,&err);
    if(kind==CHKFINITE&&ln_creation_checkfinite(result,&err)<0){ln_array_free(result);return ln_lua_fail(L,&err);}
    if(identity){ln_array_free(result);lua_pushvalue(L,input_index);return 1;}
    return ln_lua_push_array(L,result);
}
int ln_lua_array_constructor(lua_State *L){return convert_function(L,ARRAY);}
int ln_lua_array_copy(lua_State *L){return convert_function(L,METHOD_COPY);}
static int asarray(lua_State *L){return convert_function(L,ASARRAY);}
static int asanyarray(lua_State *L){return convert_function(L,ASANYARRAY);}
static int ascontiguous(lua_State *L){return convert_function(L,ASCONTIGUOUS);}
static int asfortran(lua_State *L){return convert_function(L,ASFORTRAN);}
static int chkfinite(lua_State *L){return convert_function(L,CHKFINITE);}
static int copy(lua_State *L){return convert_function(L,COPY);}
static int filled_function(lua_State *L,int kind)
{
    int argc=lua_gettop(L),full=kind==FULL,shape_constructor=kind==FULL||kind>=EMPTY;
    int fill=full||kind==FULL_LIKE;
    int first=fill?3:2;
    if(argc<first-1||argc>first+1)return luaL_error(L,"creation requires prototype/shape, optional fill, dtype and options");
    creation_options options;parse_options(L,kind,first,argc,&options);
    ln_error err={0};ln_array *prototype=NULL,*result=NULL;int fill_index=2;
    if(shape_constructor) {
        ln_lua_shape(L,1,options.shape,&options.shape_nd);
        if(options.order!='C'&&options.order!='F')return luaL_error(L,"shape constructors support C or F memory order");
        const ln_dtype *dtype=options.dtype;
        if(!dtype&&!full)dtype=ln_dtype_by_num(LN_DOUBLE);
        if(!dtype){ln_array *values=ln_lua_test_array(L,2);if(!values){values=ln_lua_legacy_array(L,2,NULL);fill_index=lua_gettop(L);}dtype=values->descr;}
        if(ln_string_is_dtype(dtype)&&ln_string_nchars(dtype)==0){dtype=ln_string_make_dtype(dtype->type_num==LN_UNICODE,1,dtype->byteorder,&err);if(!dtype)return ln_lua_fail(L,&err);}
        result=ln_array_new(options.shape_nd,options.shape,dtype,options.order=='F',0,&err);
    }
    else {
        prototype=ln_lua_test_array(L,1);if(!prototype)prototype=ln_lua_legacy_array(L,1,NULL);
        result=ln_creation_new_like(prototype,options.dtype,options.order,options.shape_present?options.shape_nd:-1,options.shape,&err);
    }
    if(!result)return ln_lua_fail(L,&err);
    ln_lua_push_array(L,result);int destination=lua_gettop(L);
    if(kind==ZEROS_LIKE||kind==ZEROS) {
        ln_intp count=ln_array_size(result);if(count&&result->descr->elsize)memset(result->data,0,(size_t)count*result->descr->elsize);
    }
    else if(kind==ONES_LIKE||kind==ONES){lua_pushinteger(L,1);ln_lua_copyto_unsafe(L,destination,lua_gettop(L));}
    else if(fill)ln_lua_copyto_unsafe(L,destination,fill_index);
    lua_pushvalue(L,destination);return 1;
}
static int empty_like(lua_State *L){return filled_function(L,EMPTY_LIKE);}
static int zeros_like(lua_State *L){return filled_function(L,ZEROS_LIKE);}
static int ones_like(lua_State *L){return filled_function(L,ONES_LIKE);}
static int full_like(lua_State *L){return filled_function(L,FULL_LIKE);}
static int full(lua_State *L){return filled_function(L,FULL);}
static int empty(lua_State *L){return filled_function(L,EMPTY);}
static int zeros(lua_State *L){return filled_function(L,ZEROS);}
static int ones(lua_State *L){return filled_function(L,ONES);}
const luaL_Reg ln_lua_creation_functions[]={
    {"asarray",asarray},{"asanyarray",asanyarray},{"ascontiguousarray",ascontiguous},
    {"asfortranarray",asfortran},{"asarray_chkfinite",chkfinite},{"copy",copy},
    {"empty_like",empty_like},{"zeros_like",zeros_like},{"ones_like",ones_like},
    {"full_like",full_like},{"full",full},{"empty",empty},{"zeros",zeros},{"ones",ones},{NULL,NULL}
};
