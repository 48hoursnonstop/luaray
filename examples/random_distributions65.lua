local np = require('luaray_core')
local rng = np.random.default_rng(42)
local frequencies = rng:zipf(2.0, {2, 3})
local sample = rng:zipf(4.0)
assert(frequencies.dtype == 'int64')
assert(frequencies.shape[1] == 2 and frequencies.shape[2] == 3)
for i=1,2 do for j=1,3 do assert(frequencies:get(i,j)>=1) end end
assert(math.type(sample)=='integer' and sample>=1)
print('LuaRay 0.65 Zipf example executed')
