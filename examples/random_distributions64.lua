local np = require("luaray_core")
local rng = np.random.default_rng(42)

local attempts = rng:geometric(0.25, {2, 3})
local first_success = rng:geometric(1)
local rare_events = rng:geometric(0.001, {4})

assert(attempts.dtype == "int64")
assert(attempts.shape[1] == 2 and attempts.shape[2] == 3)
assert(first_success == 1)
assert(rare_events.dtype == "int64" and rare_events.shape[1] == 4)
print("LuaRay 0.64 example executed: geometric")
