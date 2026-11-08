local np=require('luaray_core')
local rng=np.random.default_rng(42)
local mean={1,-1}
local cov={{2,0.3},{0.3,1}}
local samples=rng:multivariate_normal(mean,cov,{3,2},'raise',1e-8,'cholesky')
assert(samples.dtype=='float64' and samples.ndim==3)
assert(samples.shape[1]==3 and samples.shape[2]==2 and samples.shape[3]==2)
print('multivariate_normal75 Lua example passed: shape 3x2x2, dtype '..samples.dtype)
