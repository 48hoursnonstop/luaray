local np = require("luaray_core")
local rng = np.random.default_rng(42)
local drawn = rng:hypergeometric(15, 15, 10, {2, 3})
local special = rng:hypergeometric(0, 30, 4)
assert(drawn.dtype == "int64")
assert(drawn.shape[1] == 2 and drawn.shape[2] == 3)
assert(special == 0)
for i=1,2 do for j=1,3 do assert(drawn:get(i,j)>=0 and drawn:get(i,j)<=10) end end
print("LuaRay 0.66 hypergeometric example executed")
