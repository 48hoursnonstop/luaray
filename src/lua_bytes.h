#ifndef LUARAY_LUA_BYTES_H
#define LUARAY_LUA_BYTES_H
#include "lua_compat.h"
int ln_lua_bytes_swap(lua_State *L);
int ln_lua_bytes_view(lua_State *L);
int ln_lua_bytes_export(lua_State *L);
int ln_lua_bytes_nbytes(lua_State *L);
int ln_lua_bytes_itemsize(lua_State *L);
#endif
