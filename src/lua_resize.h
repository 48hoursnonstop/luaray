#ifndef LUARAY_LUA_RESIZE_H
#define LUARAY_LUA_RESIZE_H
#include "lua_compat.h"
int ln_lua_resize_copy(lua_State *L);
int ln_lua_resize_inplace(lua_State *L);
#endif
