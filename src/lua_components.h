#ifndef LUARAY_LUA_COMPONENTS_H
#define LUARAY_LUA_COMPONENTS_H
#include "lua_compat.h"
int ln_lua_real(lua_State *L);
int ln_lua_imag(lua_State *L);
int ln_lua_isreal(lua_State *L);
int ln_lua_iscomplex(lua_State *L);
int ln_lua_isrealobj(lua_State *L);
int ln_lua_iscomplexobj(lua_State *L);
int ln_lua_real_if_close(lua_State *L);
#endif
