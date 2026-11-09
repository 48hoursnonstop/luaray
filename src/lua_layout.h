#ifndef LUARAY_LUA_LAYOUT_H
#define LUARAY_LUA_LAYOUT_H
#include "lua_compat.h"
int ln_lua_layout_reshape(lua_State *L);
int ln_lua_layout_ravel(lua_State *L);
int ln_lua_layout_flatten(lua_State *L);
#endif
