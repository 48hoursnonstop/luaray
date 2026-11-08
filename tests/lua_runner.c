#include "lua_compat.h"
#include <stdio.h>
extern int luaopen_luaray_core(lua_State *L);
int main(int argc,char**argv){const char*file=argc>1?argv[1]:"tests/smoke.lua";lua_State*L=luaL_newstate();if(!L){fprintf(stderr,"failed to create Lua state\n");return 2;}luaL_openlibs(L);luaL_requiref(L,"luaray_core",luaopen_luaray_core,1);lua_pop(L,1);if(luaL_loadfilex(L,file,NULL)!=LUA_OK){fprintf(stderr,"load: %s\n",lua_tostring(L,-1));lua_close(L);return 2;}if(lua_pcall(L,0,0,0)!=LUA_OK){fprintf(stderr,"lua: %s\n",lua_tostring(L,-1));lua_close(L);return 1;}lua_close(L);return 0;}
