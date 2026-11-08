local np = require("luaray_core")
local rng = np.random.default_rng(42)

local outcomes = rng:multinomial(20, {0.2, 0.3, 0.5}, {2, 3})
assert(outcomes.dtype == "int64")
assert(outcomes.shape[1] == 2 and outcomes.shape[2] == 3 and outcomes.shape[3] == 3)
for i=1,2 do for j=1,3 do
    local sum = 0
    for k=1,3 do sum = sum + outcomes:get(i,j,k) end
    assert(sum == 20)
end end
print("LuaRay 0.68 multinomial example executed")
