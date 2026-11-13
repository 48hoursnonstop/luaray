#ifndef LUARAY_LUA_FLAGS_H
#define LUARAY_LUA_FLAGS_H
#include "lua_compat.h"
int ln_lua_array_flags(lua_State *L);
int ln_lua_array_setflags(lua_State *L);
int ln_lua_isfortran(lua_State *L);
#endif
