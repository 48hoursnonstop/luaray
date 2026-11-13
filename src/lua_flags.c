#include "lua_flags.h"
#include "lua_array_api.h"
#include <stdio.h>
#include <string.h>
#define FLAGS_MT "luaray.array_flags"
typedef struct {int snapshot;} lua_flags;
static ln_array *array(lua_State *L,int index)
{
    ln_array *a=ln_lua_test_array(L,index);
    if(!a)luaL_error(L,"array flags require an ndarray");
    return a;
}
static int boolean(lua_State *L,int index)
{
    if(lua_type(L,index)!=LUA_TBOOLEAN)luaL_error(L,"flag values must be booleans");
    return lua_toboolean(L,index);
}
int ln_lua_array_setflags(lua_State *L)
{
    ln_array *a=array(L,1);int argc=lua_gettop(L),write=-1,align=-1;
    if(argc>3)return luaL_error(L,"setflags accepts write/align options; writeback-if-copy is unsupported");
    if(argc==2&&lua_type(L,2)==LUA_TTABLE){
        lua_pushnil(L);
        while(lua_next(L,2)){
            size_t length;const char *key=lua_type(L,-2)==LUA_TSTRING?lua_tolstring(L,-2,&length):NULL;
            if(!key||strlen(key)!=length)return luaL_error(L,"unknown flag option");
            if(!strcmp(key,"write"))write=boolean(L,-1);
            else if(!strcmp(key,"align"))align=boolean(L,-1);
            else return luaL_error(L,"unknown flag option; writeback-if-copy is unsupported");
            lua_pop(L,1);
        }
    }else{
        if(argc>=2&&lua_type(L,2)!=LUA_TNIL)write=boolean(L,2);
        if(argc>=3&&lua_type(L,3)!=LUA_TNIL)align=boolean(L,3);
    }
    ln_error error={0};return ln_array_setflags(a,write,align,&error)<0?ln_lua_fail(L,&error):0;
}
/* Lua uses the same string access for attributes and mapping keys. Accept the
 * source's attribute spellings and uppercase mapping aliases in that space. */
static int key(lua_State *L)
{
    size_t length;const char *name=lua_type(L,2)==LUA_TSTRING?lua_tolstring(L,2,&length):NULL;
    if(!name||strlen(name)!=length)return luaL_error(L,"unknown array flag");
    static const char *names[][5]={
        {"contiguous","c_contiguous","C_CONTIGUOUS","CONTIGUOUS","C"},
        {"fortran","f_contiguous","F_CONTIGUOUS","FORTRAN","F"},
        {"owndata","OWNDATA","O",NULL,NULL},
        {"aligned","ALIGNED","A",NULL,NULL},
        {"writeable","WRITEABLE","W",NULL,NULL},
        {"writebackifcopy","WRITEBACKIFCOPY","X",NULL,NULL},
        {"fnc","FNC",NULL,NULL,NULL},
        {"forc","FORC",NULL,NULL,NULL},
        {"behaved","BEHAVED","B",NULL,NULL},
        {"carray","CARRAY","CA",NULL,NULL},
        {"farray","FARRAY","FA",NULL,NULL},
        {"num",NULL,NULL,NULL,NULL}
    };
    for(int i=0;i<12;++i)for(int j=0;j<5;++j)if(names[i][j]&&!strcmp(name,names[i][j]))return i;
    return luaL_error(L,"unknown array flag");
}
static int get(lua_State *L)
{
    int flags=((lua_flags*)luaL_checkudata(L,1,FLAGS_MT))->snapshot;
    int c=!!(flags&LN_ARRAY_C_CONTIGUOUS),f=!!(flags&LN_ARRAY_F_CONTIGUOUS);
    int aligned=!!(flags&LN_ARRAY_ALIGNED),write=!!(flags&LN_ARRAY_WRITEABLE),value=0;
    switch(key(L)){
      case 0:value=c;break;case 1:value=f;break;
      case 2:value=!!(flags&LN_ARRAY_OWNDATA);break;
      case 3:value=aligned;break;case 4:value=write;break;
      case 5:value=0;break;case 6:value=f&&!c;break;case 7:value=f||c;break;
      case 8:value=aligned&&write;break;case 9:value=aligned&&write&&c;break;
      /* Preserve the source's observed any-bit FARRAY predicate. */
      case 10:value=(aligned||write||f)&&!c;break;
      case 11:lua_pushinteger(L,flags);return 1;
    }
    lua_pushboolean(L,value);return 1;
}
static int set(lua_State *L)
{
    luaL_checkudata(L,1,FLAGS_MT);int option=key(L);
    if(option!=3&&option!=4)return luaL_error(L,"flag is read-only or unsupported");
    int value=boolean(L,3);lua_getiuservalue(L,1,1);ln_array *a=array(L,-1);
    ln_error error={0};int status=ln_array_setflags(a,option==4?value:-1,option==3?value:-1,&error);
    return status<0?ln_lua_fail(L,&error):0;
}
static int equal(lua_State *L)
{
    lua_flags *a=luaL_testudata(L,1,FLAGS_MT),*b=luaL_testudata(L,2,FLAGS_MT);
    lua_pushboolean(L,a&&b&&a->snapshot==b->snapshot);return 1;
}
static int describe(lua_State *L)
{
    int flags=((lua_flags*)luaL_checkudata(L,1,FLAGS_MT))->snapshot;char text[128];
    snprintf(text,sizeof text,"array_flags(C=%d, F=%d, OWNDATA=%d, ALIGNED=%d, WRITEABLE=%d)",
      !!(flags&LN_ARRAY_C_CONTIGUOUS),!!(flags&LN_ARRAY_F_CONTIGUOUS),!!(flags&LN_ARRAY_OWNDATA),
      !!(flags&LN_ARRAY_ALIGNED),!!(flags&LN_ARRAY_WRITEABLE));
    lua_pushstring(L,text);return 1;
}
int ln_lua_array_flags(lua_State *L)
{
    ln_array *a=array(L,1);
    if(luaL_newmetatable(L,FLAGS_MT)){
        lua_pushcfunction(L,get);lua_setfield(L,-2,"__index");
        lua_pushcfunction(L,set);lua_setfield(L,-2,"__newindex");
        lua_pushcfunction(L,equal);lua_setfield(L,-2,"__eq");
        lua_pushcfunction(L,describe);lua_setfield(L,-2,"__tostring");
    }
    lua_pop(L,1);lua_flags *flags=lua_newuserdatauv(L,sizeof(*flags),1);flags->snapshot=a->flags;
    lua_pushvalue(L,1);lua_setiuservalue(L,-2,1);luaL_setmetatable(L,FLAGS_MT);return 1;
}
int ln_lua_isfortran(lua_State *L)
{
    if(lua_gettop(L)!=1)return luaL_error(L,"isfortran expects one ndarray");
    ln_array *a=array(L,1);lua_pushboolean(L,(a->flags&LN_ARRAY_F_CONTIGUOUS)&&!(a->flags&LN_ARRAY_C_CONTIGUOUS));return 1;
}
