local np=require("luaray_core")
local rng=np.random.default_rng(42)
local samples=rng:dirichlet({1.5,2.0,3.0},{2,3})
assert(samples.dtype=="float64")
assert(#samples.shape==3 and samples.shape[1]==2 and samples.shape[2]==3 and samples.shape[3]==3)
for i=1,2 do for j=1,3 do
  local total=0
  for k=1,3 do total=total+samples:get(i,j,k) end
  assert(math.abs(total-1)<1e-12)
end end
local small=rng:dirichlet({0.01,0.02,0.03})
assert(#small.shape==1 and small.shape[1]==3)
assert(math.abs(small:get(1)+small:get(2)+small:get(3)-1)<1e-12)
print("LuaRay 0.69 dirichlet example executed")
