local np = require('luaray_core')
local rng = np.random.default_rng(42)

local chi = rng:chisquare(4, {2, 3})
local fisher = rng:f(5, 10, {2, 3})

for _, a in ipairs({chi, fisher}) do
    assert(a.dtype == 'float64')
    assert(a.shape[1] == 2 and a.shape[2] == 3)
end

print('LuaRay 0.59 example executed: chisquare, f')
