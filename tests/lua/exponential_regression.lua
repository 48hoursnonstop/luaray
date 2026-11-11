local np=require('luaray_core')
assert(np._version=='0.131.0-dev')
local r=np.random.default_rng(42)
assert(r:standard_exponential()==2.4042086039659947)
assert(r:standard_exponential()==2.3361896558244535)
r:reseed(42)
local a=r:standard_exponential({2,3})
assert(a.dtype=='float64' and a.shape[1]==2 and a.shape[2]==3)
assert(a:get(1,1)==2.4042086039659947)
assert(a:get(1,2)==2.3361896558244535)
local f=np.random.default_rng(42):standard_exponential(4,'float32')
assert(f.dtype=='float32' and f:get(1)==0.08859460800886154)
local inv=np.random.default_rng(42):standard_exponential(4,'float32','inv')
assert(inv:get(1)==0.09348785877227783)
-- Reproduced glibc 2.39 log1pf one-ULP differences. Keep exact values and the
-- next PCG64 word fixed; the precision correction must consume no extra draws.
local portable=np.random.default_rng(0)
local values=portable:standard_exponential(18,'float32','inv')
assert(values:get(11)==1.0481542348861694)
assert(values:get(14)==0.93301922082901)
assert(values:get(16)==1.307470440864563)
assert(portable:raw_hex()=='ef60e8078f56bfed')
local scaled=np.random.default_rng(42):exponential(2.5,{2,2})
assert(scaled.dtype=='float64' and scaled:get(1,1)==6.0105215099149865)
local z=np.random.default_rng(42):standard_exponential({2,0,3})
assert(z.shape[2]==0)
assert(type(np.random.default_rng(42):standard_exponential())=='number')
local zero=np.random.default_rng(42):standard_exponential({})
assert(zero.dtype=='float64' and zero:get()==2.4042086039659947)
local cases={
 function()return r:standard_exponential(-1)end,
 function()return r:standard_exponential(2,'int32')end,
 function()return r:standard_exponential(2,'float64','wrong')end,
 function()return r:standard_exponential(2,nil,nil,'extra')end,
 function()return r:exponential(-1)end,
 function()return r:exponential(1,-4)end,
 function()return r:exponential(1,3,'extra')end,
}
for _,fn in ipairs(cases) do assert(not pcall(fn)) end
print('exponential distribution regression passed')
