local np = require('luaray')
local rng = np.random.default_rng(42)
local samples = rng:random({2, 3})
for _, row in ipairs(samples:tolist()) do
    for _, value in ipairs(row) do assert(value >= 0 and value < 1) end
end
print('Seeded random sampling passed')
