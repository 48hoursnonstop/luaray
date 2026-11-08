local np = require('luaray_core')
local rng = np.random.default_rng(42)
local colors = {12, 8, 5}
local samples = rng:multivariate_hypergeometric(colors, 10, {2, 3})
local counted = rng:multivariate_hypergeometric(colors, 10, 4, 'count')
assert(samples.dtype == 'int64' and samples.shape[1] == 2 and samples.shape[2] == 3 and samples.shape[3] == 3)
assert(counted.dtype == 'int64' and counted.shape[1] == 4 and counted.shape[2] == 3)
for i=1,2 do
  for j=1,3 do
    local total = 0
    for k=1,3 do
      local x=samples:get(i,j,k)
      assert(x>=0 and x<=colors[k])
      total=total+x
    end
    assert(total==10)
  end
end
print('LuaRay 0.67 example executed: multivariate_hypergeometric')
