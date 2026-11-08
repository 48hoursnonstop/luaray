local np=require('luaray_core')
local rng=np.random.default_rng(42)
local shapes=rng:standard_gamma(2,{2,3},'float32')
local durations=rng:gamma(2,3,{2,3})
local proportions=rng:beta(.5,.5,{2,3})
assert(shapes.dtype=='float32')
assert(durations.dtype=='float64')
assert(proportions.dtype=='float64')
for _,a in ipairs({shapes,durations,proportions}) do
  assert(a.shape[1]==2 and a.shape[2]==3)
end
print('LuaRay 0.58 example executed: standard_gamma, gamma, beta')
