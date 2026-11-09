local np = require("luaray")

local values = np.array({1, 2, 3}, "float64")
local squared = np.square(values)
assert(np.sum(squared) == 14)

local normal = np.cross({1, 0, 0}, {0, 1, 0})
assert(normal:tolist()[3] == 1)

print("LuaRay quickstart passed")
