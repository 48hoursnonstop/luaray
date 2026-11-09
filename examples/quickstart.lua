local lr = require("luaray")

local values = lr.array({1, 2, 3}, "float64")
local squared = lr.square(values)
assert(lr.sum(squared) == 14)

local normal = lr.cross({1, 0, 0}, {0, 1, 0})
assert(normal:tolist()[3] == 1)

print("LuaRay quickstart passed")
