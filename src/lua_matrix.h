#ifndef LUARAY_LUA_MATRIX_H
#define LUARAY_LUA_MATRIX_H
#include "lua_compat.h"
int ln_lua_diagonal(lua_State *L);
int ln_lua_diag(lua_State *L);
int ln_lua_diagflat(lua_State *L);
int ln_lua_trace(lua_State *L);
int ln_lua_tri(lua_State *L);
int ln_lua_tril(lua_State *L);
int ln_lua_triu(lua_State *L);
#endif
