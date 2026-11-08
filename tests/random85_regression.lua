local np=require('luaray_core')
assert(np._version=='0.103.0-dev')
local checks=0
local function invalid(fn)
  local rng=np.random.default_rng(850085)
  local ref=np.random.default_rng(850085)
  assert(not pcall(function() fn(rng) end),'expected invalid parameter')
  assert(rng:raw_hex()==ref:raw_hex(),'invalid parameters drew randomness')
  checks=checks+1
end
invalid(function(r)r:noncentral_chisquare({0,2},{1,2})end)
invalid(function(r)r:noncentral_chisquare({1,-1},{0,1},{0,2})end)
invalid(function(r)r:noncentral_chisquare({1,2},{0,-1})end)
invalid(function(r)r:noncentral_chisquare({1,2},{0/0,1})end)
invalid(function(r)r:noncentral_chisquare({1,2},{0,1,2})end)
invalid(function(r)r:noncentral_chisquare({1,2},{0,1},{2,3})end)
invalid(function(r)r:noncentral_chisquare({1,2},{0,1e13})end)
invalid(function(r)r:noncentral_f({1,-2},{3,4},{1,2})end)
invalid(function(r)r:noncentral_f({1,2},{3,0},{1,2})end)
invalid(function(r)r:noncentral_f({1,2},{3,4},{1,-1})end)
invalid(function(r)r:noncentral_f({1,2},{3,4},{1,0/0})end)
invalid(function(r)r:noncentral_f({1,2},{3,4},{1,1e13})end)
invalid(function(r)r:noncentral_f({1,2},{3,4},{1,2,3})end)
invalid(function(r)r:noncentral_f({1,2},{3,4},{1,2},{2,3})end)
invalid(function(r)r:noncentral_f({1,2},{3,4,5},{1,2})end)
invalid(function(r)r:noncentral_f({1,2},{3,4},{1,2}, {0,3})end)
local rng=np.random.default_rng(123)
local a=rng:noncentral_chisquare({{.5},{1},{10}},{{0,1,20}})
assert(a.dtype=='float64' and a.shape[1]==3 and a.shape[2]==3)
local b=rng:noncentral_f({{.5},{1}},{{4,8,20}},{{.1,1,3}})
assert(b.dtype=='float64' and b.shape[1]==2 and b.shape[2]==3)
local c=rng:noncentral_chisquare(np.flip(np.array({1,2,3}),1),{.1,.2,.3})
assert(c.shape[1]==3)
local d=rng:noncentral_f(np.array(.5),np.array(5),np.array(2))
assert(type(d)=='number')
local e=rng:noncentral_chisquare({.5,1},0,{0,2})
assert(e.shape[1]==0 and e.shape[2]==2)
-- Sanity checks: population moments, not replacements for oracle verification.
local n=10000
local chi=np.random.default_rng(851):noncentral_chisquare(3.,2.,{n}):tolist()
local sum=0
for i=1,#chi do assert(chi[i]>=0);sum=sum+chi[i] end
assert(math.abs(sum/n-5)<.20,'noncentral chi-square mean')
local f=np.random.default_rng(852):noncentral_f(5.,10.,2.,{n}):tolist()
local sm=0
for i=1,#f do assert(f[i]>=0);sm=sm+f[i] end
assert(math.abs(sm/n-1.75)<.12,'noncentral F mean')
print('random85 regressions: '..checks..' invalid checks, 20000 samples, shape/view passed')
