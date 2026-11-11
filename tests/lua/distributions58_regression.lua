local np=require('luaray_core')
assert(np._version=='0.133.0-dev')
local r=np.random.default_rng(42)
local a=r:standard_gamma(2,{2,3},'float32')
local b=r:gamma(2,3,{2,3})
local c=r:beta(.5,.5,{2,3})
assert(a.dtype=='float32' and b.dtype=='float64' and c.dtype=='float64')
for _,v in ipairs({a,b,c}) do
  assert(v.shape[1]==2 and v.shape[2]==3)
end
local zero=np.random.default_rng(42)
assert(zero:standard_gamma(0)==0)
assert(zero:gamma(0,4)==0)
local ref=np.random.default_rng(42)
assert(zero:raw_hex()==ref:raw_hex())
local bad={
  function(t)t:standard_gamma(-1)end,
  function(t)t:standard_gamma(2,nil,'int64')end,
  function(t)t:gamma(1,-1)end,
  function(t)t:beta(0,1)end,
  function(t)t:beta(1,math.huge)end,
  function(t)t:beta(1,1,{-1})end,
}
for _,fn in ipairs(bad) do
  local t=np.random.default_rng(42)
  assert(not pcall(fn,t))
  local same=np.random.default_rng(42)
  assert(t:raw_hex()==same:raw_hex())
end
local nonfinite=np.random.default_rng(42)
assert(nonfinite:standard_gamma(math.huge)==math.huge)
assert(nonfinite:standard_gamma(0/0)~=nonfinite:standard_gamma(0/0))
print('distributions58 Lua regression passed')
