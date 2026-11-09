#ifndef LUARAY_LUA_CREATION_H
#define LUARAY_LUA_CREATION_H
#include "lua_compat.h"
int ln_lua_array_constructor(lua_State *L);
int ln_lua_array_copy(lua_State *L);
extern const luaL_Reg ln_lua_creation_functions[];
#endif
