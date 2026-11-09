local np=require('luaray_core')
assert(np._version=='0.106.0-dev')
local rng=np.random.default_rng(42)
local a=rng:chisquare(2,{2,3})
local b=rng:f(3,5,{2,3})
for _,x in ipairs({a,b}) do
  assert(x.dtype=='float64')
  assert(x.shape[1]==2 and x.shape[2]==3)
end
assert(type(rng:chisquare(2))=='number')
assert(type(rng:f(3,5))=='number')
local r=np.random.default_rng(42)
local zero=r:chisquare(1,{0,2})
assert(zero.shape[1]==0 and zero.shape[2]==2)
local same=np.random.default_rng(42)
assert(r:raw_hex()==same:raw_hex())
for _,fn in ipairs({
  function(t)t:chisquare(0)end, function(t)t:chisquare(-1)end,
  function(t)t:chisquare(math.huge)end, function(t)t:chisquare(0/0)end,
  function(t)t:f(0,1)end, function(t)t:f(1,0)end,
  function(t)t:f(1,-1)end, function(t)t:f(1,0/0)end,
  function(t)t:f(1,2,{-1})end,
}) do
  local t=np.random.default_rng(42)
  assert(not pcall(fn,t))
  local unchanged=np.random.default_rng(42)
  assert(t:raw_hex()==unchanged:raw_hex())
end
print('distributions59 Lua regression passed')
