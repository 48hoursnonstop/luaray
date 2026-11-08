-- Literal smoke example: executed as part of make distributions62-test.
local np = require("luaray_core")
local rng = np.random.default_rng(42)
local successes = rng:binomial(20, 0.35, {2, 3})
local coin_flips = rng:binomial(1, 0.5, {10})
local empty = rng:binomial(100, 0.2, {0})
assert(successes.dtype == "int64")
assert(successes.shape[1] == 2 and successes.shape[2] == 3)
for i=1,2 do for j=1,3 do
    local n = successes:get(i,j)
    assert(n >= 0 and n <= 20)
end end
assert(coin_flips.dtype == "int64" and coin_flips.shape[1] == 10)
assert(empty.shape[1] == 0)
print("LuaRay 0.62 example executed: binomial")
