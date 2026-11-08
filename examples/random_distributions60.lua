-- Executed example for LuaRay 0.61.0-dev
local np = require("luaray_core")
local rng = np.random.default_rng(42)
local chi = rng:noncentral_chisquare(4, 2.5, {2, 3})
local fisher = rng:noncentral_f(5, 10, 3, {2, 3})
assert(chi.dtype == "float64" and fisher.dtype == "float64")
assert(chi.shape[1] == 2 and chi.shape[2] == 3)
assert(fisher.shape[1] == 2 and fisher.shape[2] == 3)
print("LuaRay 0.60 example executed: noncentral_chisquare, noncentral_f")
