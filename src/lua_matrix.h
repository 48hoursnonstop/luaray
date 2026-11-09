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
int ln_lua_vander(lua_State *L);
int ln_lua_eye(lua_State *L);
int ln_lua_identity(lua_State *L);
int ln_lua_diag_indices(lua_State *L);
int ln_lua_diag_indices_from(lua_State *L);
int ln_lua_tril_indices(lua_State *L);
int ln_lua_triu_indices(lua_State *L);
int ln_lua_tril_indices_from(lua_State *L);
int ln_lua_triu_indices_from(lua_State *L);
int ln_lua_fill_diagonal(lua_State *L);
int ln_lua_kron(lua_State *L);
#endif
