local np = require('luaray_core')
local rng = np.random.default_rng(42)
local tails = rng:pareto(2.5, {2, 3})
local power_samples = rng:power(3, {2, 3})
local triangles = rng:triangular(-2, 0, 5, {2, 3})
for _,a in ipairs({tails,power_samples,triangles}) do
    assert(a.dtype == 'float64')
    assert(a.shape[1] == 2 and a.shape[2] == 3)
end
print('LuaRay 0.57 example executed: pareto, power, triangular')
