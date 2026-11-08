local np = require('luaray_core')
local rng = np.random.default_rng(42)
local failures = rng:negative_binomial(5, 0.35, {2, 3})
local waiting = rng:negative_binomial(2.5, 0.7, {4})
assert(failures.dtype == 'int64')
assert(failures.shape[1] == 2 and failures.shape[2] == 3)
assert(waiting.dtype == 'int64' and waiting.shape[1] == 4)
for i=1,2 do for j=1,3 do assert(failures:get(i,j) >= 0) end end
print('LuaRay 0.63 example executed: negative_binomial')
