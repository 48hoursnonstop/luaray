#ifndef LUARAY_LUA_COMPAT_H
#define LUARAY_LUA_COMPAT_H
#include <stddef.h>
#include <stdarg.h>

typedef struct lua_State lua_State;
typedef long long lua_Integer;
typedef double lua_Number;
typedef int (*lua_CFunction)(lua_State *L);
typedef struct luaL_Reg { const char *name; lua_CFunction func; } luaL_Reg;
typedef long long lua_KContext;
typedef int (*lua_KFunction)(lua_State *L, int status, lua_KContext ctx);

enum { LUA_OK=0, LUA_TNONE=-1, LUA_TNIL=0, LUA_TBOOLEAN=1, LUA_TLIGHTUSERDATA=2,
       LUA_TNUMBER=3, LUA_TSTRING=4, LUA_TTABLE=5, LUA_TFUNCTION=6,
       LUA_TUSERDATA=7, LUA_TTHREAD=8 };

extern int lua_gettop(lua_State *L);
extern void lua_settop(lua_State *L, int idx);
extern int lua_absindex(lua_State *L, int idx);
extern void lua_pushvalue(lua_State *L, int idx);
extern void lua_rotate(lua_State *L, int idx, int n);
extern void lua_copy(lua_State *L, int fromidx, int toidx);
extern int lua_type(lua_State *L, int idx);
extern int lua_toboolean(lua_State *L, int idx);
extern lua_Integer lua_tointegerx(lua_State *L, int idx, int *isnum);
extern lua_Number lua_tonumberx(lua_State *L, int idx, int *isnum);
extern const char *lua_tolstring(lua_State *L, int idx, size_t *len);
extern int lua_isinteger(lua_State *L, int idx);
extern size_t lua_rawlen(lua_State *L, int idx);
extern int lua_rawget(lua_State *L,int index);
extern int lua_error(lua_State *L);
extern int lua_rawgeti(lua_State *L,int index,lua_Integer n);
extern lua_State *lua_tothread(lua_State *L,int index);
extern int luaL_ref(lua_State *L,int index);
extern void luaL_unref(lua_State *L,int index,int ref);
/* Lua 5.4 ABI, verified against its installed lua.h/luaconf.h. */
#define LUA_REGISTRYINDEX (-1001000)
#define LUA_RIDX_MAINTHREAD 1

extern int lua_geti(lua_State *L, int idx, lua_Integer n);
extern void lua_seti(lua_State *L, int idx, lua_Integer n);
extern int lua_getfield(lua_State *L, int idx, const char *k);
extern int lua_next(lua_State *L, int idx);
extern void lua_setfield(lua_State *L, int idx, const char *k);
extern void lua_createtable(lua_State *L, int narr, int nrec);
extern void *lua_newuserdatauv(lua_State *L, size_t sz, int nuvalue);
extern int lua_getiuservalue(lua_State *L,int index,int n);
extern int lua_setiuservalue(lua_State *L,int index,int n);
extern int lua_getmetatable(lua_State *L, int objindex);
extern int lua_setmetatable(lua_State *L, int objindex);
extern void lua_pushnil(lua_State *L);
extern void lua_pushnumber(lua_State *L, lua_Number n);
extern void lua_pushinteger(lua_State *L, lua_Integer n);
extern const char *lua_pushstring(lua_State *L, const char *s);
extern const char *lua_pushlstring(lua_State *L, const char *s, size_t len);
extern void lua_pushboolean(lua_State *L, int b);
extern void lua_pushcclosure(lua_State *L, lua_CFunction fn, int n);
extern int lua_pcallk(lua_State *L, int nargs, int nresults, int errfunc, lua_KContext ctx, lua_KFunction k);
extern void lua_close(lua_State *L);

extern lua_State *luaL_newstate(void);
extern void luaL_openlibs(lua_State *L);
extern int luaL_loadfilex(lua_State *L, const char *filename, const char *mode);
extern int luaL_loadstring(lua_State *L, const char *s);
extern lua_Integer luaL_checkinteger(lua_State *L, int arg);
extern lua_Number luaL_checknumber(lua_State *L, int arg);
extern const char *luaL_checklstring(lua_State *L, int arg, size_t *l);
extern void luaL_checktype(lua_State *L, int arg, int t);
extern void luaL_checkstack(lua_State *L, int size, const char *message);
extern void *luaL_checkudata(lua_State *L, int ud, const char *tname);
extern void *luaL_testudata(lua_State *L, int ud, const char *tname);
extern int luaL_newmetatable(lua_State *L, const char *tname);
extern void luaL_setmetatable(lua_State *L, const char *tname);
extern void luaL_setfuncs(lua_State *L, const luaL_Reg *l, int nup);
extern int luaL_error(lua_State *L, const char *fmt, ...);
extern void luaL_requiref(lua_State *L, const char *modname, lua_CFunction openf, int glb);

#define lua_pop(L,n) lua_settop((L), -(n)-1)
#define lua_remove(L,idx) (lua_rotate((L),(idx),-1), lua_pop((L),1))
#define lua_pushcfunction(L,f) lua_pushcclosure((L),(f),0)
#define lua_tostring(L,i) lua_tolstring((L),(i),NULL)
#define lua_pcall(L,n,r,f) lua_pcallk((L),(n),(r),(f),0,NULL)

#endif
