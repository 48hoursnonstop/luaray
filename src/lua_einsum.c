#include "lua_einsum.h"
#include "lua_array_api.h"
#include "ln_einsum.h"
#include "ln_write.h"

int ln_lua_einsum(lua_State *L)
{
    luaL_checktype(L, 1, LUA_TTABLE);
    luaL_checktype(L, 2, LUA_TTABLE);
    size_t count = lua_rawlen(L, 1);
    if (count < 1 || count > LN_EINSUM_MAX_INPUTS || lua_rawlen(L, 2) != count)
        return luaL_error(L, "invalid Einstein operand count");

    lua_Integer nd = luaL_checkinteger(L, 3), output_nd = luaL_checkinteger(L, 4);
    if (nd < 0 || nd > LN_MAXDIMS || output_nd < 0 || output_nd > nd)
        return luaL_error(L, "invalid Einstein contraction rank");

    ln_einsum_input inputs[LN_EINSUM_MAX_INPUTS];
    for (size_t i = 0; i < count; i++) {
        lua_rawgeti(L, 1, (lua_Integer)i + 1);
        inputs[i].array = ln_lua_test_array(L, -1);
        lua_pop(L, 1);
        if (!inputs[i].array) return luaL_error(L, "Einstein operands must be arrays");
        lua_rawgeti(L, 2, (lua_Integer)i + 1);
        luaL_checktype(L, -1, LUA_TTABLE);
        if (lua_rawlen(L, -1) != (size_t)inputs[i].array->nd)
            return luaL_error(L, "Einstein axis map differs from array rank");
        for (int j = 0; j < inputs[i].array->nd; j++) {
            lua_rawgeti(L, -1, j + 1);
            lua_Integer axis = luaL_checkinteger(L, -1);
            lua_pop(L, 1);
            if (axis < 1 || axis > nd) return luaL_error(L, "invalid Einstein axis map");
            inputs[i].axis[j] = (int)axis - 1;
        }
        lua_pop(L, 1);
    }

    const ln_dtype *dtype = NULL;
    if (lua_type(L, 5) != LUA_TNIL) dtype = ln_lua_check_dtype(L, 5);
    size_t order_size;
    const char *order = luaL_checklstring(L, 6, &order_size);
    if (order_size != 1) return luaL_error(L, "einsum order must be C, F, A or K");
    ln_casting casting;
    const char *policy = luaL_checklstring(L, 7, NULL);
    if (ln_parse_casting(policy, &casting) < 0)
        return luaL_error(L, "invalid einsum casting rule");

    ln_array *out = NULL;
    if (lua_type(L, 8) != LUA_TNIL) {
        out = ln_lua_test_array(L, 8);
        if (!out) return luaL_error(L, "einsum output must be an ndarray");
    }
    ln_error err = {0};
    ln_array *result = ln_einsum(inputs, (int)count, (int)nd, (int)output_nd,
                                 dtype, order[0], casting, out, &err);
    if (!result) return ln_lua_fail(L, &err);
    if (out) {
        int status = ln_array_copyto(out, result, NULL, 1, casting, &err);
        ln_array_free(result);
        if (status < 0) return ln_lua_fail(L, &err);
        lua_pushvalue(L, 8);
        return 1;
    }
    return ln_lua_push_array(L, result);
}
