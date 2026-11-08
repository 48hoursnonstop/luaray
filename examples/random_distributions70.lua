local np=require("luaray_core")
local rng=np.random.default_rng(42)
local w=rng:wald(2,5,{2,3})
local count=rng:logseries(0.8,{2,3})
assert(w.dtype=="float64" and count.dtype=="int64")
assert(w.shape[1]==2 and w.shape[2]==3)
for i=1,2 do for j=1,3 do
  assert(w:get(i,j)>0 and count:get(i,j)>=1)
end end
print("LuaRay 0.70 native Wald + logseries example executed")
