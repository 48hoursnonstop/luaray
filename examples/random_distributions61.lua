-- Ejecutado literalmente durante la validacion de LuaRay 0.61.0-dev.
local np = require("luaray_core")
local rng = np.random.default_rng(42)

local arrivals = rng:poisson(4, {2, 3})
local busy_hour = rng:poisson(25)
local quiet = rng:poisson(0, {4})

assert(arrivals.dtype == "int64")
assert(arrivals.shape[1] == 2 and arrivals.shape[2] == 3)
assert(math.type(busy_hour) == "integer")
for i = 1, 4 do assert(quiet:get(i) == 0) end
print("LuaRay 0.61 Poisson example executed")
