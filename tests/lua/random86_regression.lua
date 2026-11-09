local np=require('luaray_core')
assert(np._version=='0.119.0-dev')
local checks=0
local function invalid(f)
 local a=np.random.default_rng(860086)
 local b=np.random.default_rng(860086)
 assert(not pcall(function() f(a) end), 'expected input error '..(checks+1))
 assert(a:raw_hex()==b:raw_hex(),'invalid input consumed PCG64')
 checks=checks+1
end
-- Reject invalid values BEFORE sampling the *entire* parameter broadcast,
-- including negative-stride arrays and empty output requests.
invalid(function(r) r:standard_t({1,0}) end)
invalid(function(r) r:standard_t({1,-.5},{0,2}) end)
invalid(function(r) r:standard_t(np.flip(np.array({1,-2}),1)) end)
invalid(function(r) r:standard_t({1,2},{2,3}) end)
invalid(function(r) r:standard_t({1,2,3}, {2,2}) end)
invalid(function(r) r:standard_t({0,1}, {0,2}) end)
invalid(function(r) r:vonmises({1,2},{1,-1}) end)
invalid(function(r) r:vonmises({1,2},{1,-1},{0,2}) end)
invalid(function(r) r:vonmises({1,2},{1,2,3}) end)
invalid(function(r) r:vonmises({1,2}, {1,2},{2,3}) end)
invalid(function(r) r:vonmises({1,2},nil) end)
invalid(function(r) r:vonmises(nil,{1,2}) end)
invalid(function(r) r:triangular({0,1},{.2,.5},{1,.6}) end)
invalid(function(r) r:triangular({0,1},{.2,.5},{1,.6},{0,2}) end)
invalid(function(r) r:triangular({0,1},{.2,.5},{1,2}) end) -- one left > mode
invalid(function(r) r:triangular({0,1},{.2,1.5},{1,1.4}) end)
invalid(function(r) r:triangular({0,1},{.2,1.5},{1,1.4},{0,2}) end)
invalid(function(r) r:triangular({0,1},{.2,.5},{1,.6},{0,2}) end)
invalid(function(r) r:triangular({0,1},{.2,1.5},{1,2},{3,3}) end)
invalid(function(r) r:triangular({0,1},{.2,1.5}) end)
invalid(function(r) r:triangular({0,1},nil,{1,2}) end)
invalid(function(r) r:triangular(nil,{.2,.5},{1,2}) end)
invalid(function(r) r:triangular({0,1},{.2,1.5},{1,2,3}) end)
invalid(function(r) r:triangular({0,1},{.2,1.5},{1,2},{2,3}) end)
local r=np.random.default_rng(8600)
local t=r:standard_t({{.5},{2.},{100.}}, {3,2})
assert(t.dtype=='float64' and t.shape[1]==3 and t.shape[2]==2)
local v=r:vonmises({{0},{1},{2}},{{0,1e-6,1e7}})
assert(v.shape[1]==3 and v.shape[2]==3)
local a=r:triangular({{0},{.2}},{{.5,3,4}},{{5,6,7}})
assert(a.shape[1]==2 and a.shape[2]==3)
local b=r:vonmises(np.flip(np.array({0,1,2}),1), 1.2)
assert(b.shape[1]==3)
local c=r:triangular(np.transpose(np.array({{0,1},{2,3}})),4,5)
assert(c.shape[1]==2 and c.shape[2]==2)
local z=r:standard_t({.2,3.},{0,2})
assert(z.shape[1]==0 and z.shape[2]==2)
local z2=r:vonmises({1,2}, {1,2}, {0,2})
assert(z2.shape[1]==0 and z2.shape[2]==2)
local z3=r:triangular({0,1},{1,2},{2,3},{0,2})
assert(z3.shape[1]==0 and z3.shape[2]==2)
local d=r:triangular(np.array(0),np.array(.5),np.array(1))
assert(type(d)=='number' and d>=0 and d<=1)
-- Distribution-level sanity; differential tests above enforce exact stream.
local count=10000
local td=np.random.default_rng(861):standard_t(10,{count}):tolist()
local ts,tss=0,0
for _,x in ipairs(td) do ts=ts+x;tss=tss+x*x end
assert(math.abs(ts/count)<.12)
assert(math.abs(tss/count-10/8)<.23)
local tr=np.random.default_rng(862):triangular(0,2,5,{count}):tolist()
local sum=0
for _,x in ipairs(tr) do assert(x>=0 and x<=5);sum=sum+x end
assert(math.abs(sum/count-7/3)<.09)
local vm=np.random.default_rng(863):vonmises(0,4,{count}):tolist()
local vmcos=0
for _,x in ipairs(vm) do assert(x>=-math.pi and x<=math.pi);vmcos=vmcos+math.cos(x) end
assert(vmcos/count>.75 and vmcos/count<.93)
print('random86 regression: '..checks..' invalid checks; 30000 statistical samples; shapes/views passed')
