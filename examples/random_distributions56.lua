-- Executable example: this is tested literally by distributions56-test.
local np = require('luaray_core')
local rng = np.random.default_rng(42)

local extremes = rng:gumbel(0, 1, {2, 3})
local scores = rng:logistic(0, 2, {2, 3})
local distances = rng:rayleigh(1.5, {2, 3})
local lifetimes = rng:weibull(2, {2, 3})

for _, a in ipairs({extremes, scores, distances, lifetimes}) do
    assert(a.dtype == 'float64')
    assert(a.shape[1] == 2 and a.shape[2] == 3)
end
print('LuaRay 0.56 example executed: gumbel, logistic, rayleigh, weibull')
