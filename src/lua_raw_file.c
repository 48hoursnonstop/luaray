#include "lua_raw_file.h"
#include "lua_array_api.h"
#include "ln_raw_file.h"
#include <string.h>

/* The initial Lua 5.4 luaL_Stream layout is public in lauxlib.h. */
struct file_handle {
    FILE *file;
    lua_CFunction close;
};

static FILE *open_file(lua_State *L,int index,const char *mode,int *owned)
{
    *owned=0;
    if(lua_type(L,index)==LUA_TSTRING){
        size_t length;
        const char *path=lua_tolstring(L,index,&length);
        if(strlen(path)!=length)luaL_error(L,"file path contains a NUL byte");
        FILE *file=fopen(path,mode);
        if(!file)luaL_error(L,"cannot open file for binary I/O");
        *owned=1;
        return file;
    }
    struct file_handle *handle=luaL_testudata(L,index,"FILE*");
    if(!handle||lua_rawlen(L,index)<sizeof *handle||!handle->file||!handle->close)
        luaL_error(L,"expected an open file handle or a path");
    return handle->file;
}

int ln_lua_fromfile(lua_State *L)
{
    int argc=lua_gettop(L);
    if(argc<1||argc>2||(argc==2&&lua_type(L,2)!=LUA_TTABLE))
        return luaL_error(L,"fromfile expects a path or file and optional options table");
    const ln_dtype *dtype=ln_dtype_by_num(LN_DOUBLE);
    ln_intp count=-1;
    int64_t offset=0;
    if(argc==2){
        lua_pushnil(L);
        while(lua_next(L,2)){
            size_t length=0;
            const char *key=lua_type(L,-2)==LUA_TSTRING?lua_tolstring(L,-2,&length):NULL;
            if(!key||strlen(key)!=length||
               (strcmp(key,"dtype")&&strcmp(key,"count")&&strcmp(key,"offset")&&strcmp(key,"sep")))
                return luaL_error(L,"unknown fromfile option");
            lua_pop(L,1);
        }
        lua_getfield(L,2,"dtype");
        if(lua_type(L,-1)!=LUA_TNIL)dtype=ln_lua_check_dtype(L,-1);
        lua_pop(L,1);
        lua_getfield(L,2,"count");
        if(lua_type(L,-1)!=LUA_TNIL){
            if(!lua_isinteger(L,-1))return luaL_error(L,"fromfile count must be a Lua integer");
            lua_Integer n=lua_tointegerx(L,-1,NULL);
            if(n<INTPTR_MIN||n>INTPTR_MAX)return luaL_error(L,"fromfile count exceeds native range");
            count=(ln_intp)n;
        }
        lua_pop(L,1);
        lua_getfield(L,2,"offset");
        if(lua_type(L,-1)!=LUA_TNIL){
            if(!lua_isinteger(L,-1))return luaL_error(L,"fromfile offset must be a Lua integer");
            offset=(int64_t)lua_tointegerx(L,-1,NULL);
        }
        lua_pop(L,1);
        lua_getfield(L,2,"sep");
        if(lua_type(L,-1)!=LUA_TNIL&&
          (lua_type(L,-1)!=LUA_TSTRING||lua_rawlen(L,-1)!=0))
            return luaL_error(L,"fromfile currently supports binary input only");
        lua_pop(L,1);
    }
    if(!dtype->elsize)return luaL_error(L,"fromfile requires a nonzero itemsize");
    int owned;
    FILE *file=open_file(L,1,"rb",&owned);
    ln_error error={0};
    ln_array *result=ln_read_raw_file(file,dtype,count,offset,&error);
    int closed=owned?fclose(file):0;
    if(!result)return ln_lua_fail(L,&error);
    if(closed!=0){
        ln_array_free(result);
        return luaL_error(L,"cannot close binary input");
    }
    return ln_lua_push_array(L,result);
}

int ln_lua_array_tofile(lua_State *L)
{
    ln_array *array=ln_lua_test_array(L,1);
    if(!array||lua_gettop(L)!=2)return luaL_error(L,"tofile expects an array and a path or open file");
    int owned;
    FILE *file=open_file(L,2,"wb",&owned);
    ln_error error={0};
    int status=ln_write_raw_file(file,array,&error);
    int closed=owned?fclose(file):0;
    if(status<0)return ln_lua_fail(L,&error);
    if(closed!=0)return luaL_error(L,"cannot close binary output");
    return 0;
}
