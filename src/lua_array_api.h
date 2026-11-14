#ifndef LUARAY_LUA_ARRAY_API_H
#define LUARAY_LUA_ARRAY_API_H
#include "ln_core.h"
#include "lua_compat.h"
#include "ln_ufunc.h"
/* Internal binding boundary: borrowed native pointers remain valid while
 * their userdata is rooted on the Lua stack. push takes ownership; legacy
 * conversion roots its result on the stack. Calls raise ordinary Lua errors. */
ln_array *ln_lua_test_array(lua_State *L,int index);
int ln_lua_operand(lua_State *L,int index,ln_ufunc_operand *operand);
/* Array buffers are borrowed; string-backed byte storage is rooted on stack. */
ln_array *ln_lua_buffer_storage(lua_State *L,int index);
const ln_dtype *ln_lua_test_dtype(lua_State *L,int index);
const ln_dtype *ln_lua_check_dtype(lua_State *L,int index);
const ln_dtype *ln_lua_temporal_scalar_dtype(lua_State *L,int index);
ln_array *ln_lua_legacy_array(lua_State *L,int index,const ln_dtype *dtype);
int ln_lua_push_array(lua_State *L,ln_array *array);
int ln_lua_push_scalar_or_array(lua_State *L,ln_array *array);
int ln_lua_fail(lua_State *L,ln_error *err);
int ln_lua_shape(lua_State *L,int index,ln_intp *dims,int *nd);
const ln_dtype *ln_lua_creation_target(lua_State *L,int source_index,const ln_array *array,const ln_dtype *dtype,ln_error *err);
void ln_lua_copyto_unsafe(lua_State *L,int destination,int source);
/* Assign an ordinary equal-shape sequence progressively; 0 means the caller
 * must use the temporary/broadcast path. Shape errors precede mutation. */
int ln_lua_assign_exact_sequence(lua_State *L,int index,ln_array *destination);
/* Typed arrays are borrowed unchanged for the caller's native casting path.
 * Ordinary Lua sequences/scalars are converted directly with assignment bounds
 * checks and rooted on the stack, preserving Python scalar/ndarray distinctions. */
ln_array *ln_lua_assignment_values(lua_State *L,int index,const ln_dtype *dtype);
/* Pack a single Lua value into borrowed typed storage; raises on failure. */
void ln_lua_pack_scalar(lua_State *L,int index,const ln_dtype *dtype,char *destination);
#endif
