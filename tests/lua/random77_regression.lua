local np=require('luaray_core')
assert(np._version=='0.142.0-dev')
local function same(a,b)
  if type(a)~=type(b) then return false end
  if type(a)~='table' then return a==b end
  if #a~=#b then return false end
  for i=1,#a do if not same(a[i],b[i]) then return false end end
  return true
end
local g=np.random.default_rng(42)
local m=g:normal({{0},{2}},{{1,2,3}})
assert(same(m.shape,{2,3}) and m.dtype=='float64')
local u=g:uniform({{0},{1}},{{3,4,5}},{2,2,3})
assert(same(u.shape,{2,2,3}))
local e=g:exponential({0.5,1.0,1.5},{0,3})
assert(same(e.shape,{0,3}) and e.size==0)
local v=np.flip(np.array({1,2,3,4},'int64'),1)
assert(same(v:tolist(),{4,3,2,1}))
local samp=g:exponential(v)
assert(samp.shape[1]==4 and samp:tolist()[1]>=0)
local z=np.array(1.5,'float64')
local zero=g:normal(z,np.array(0.0,'float64'))
assert(type(zero)=='number' and zero==1.5)
local bad={
  function(r)r:normal({1,2},{1,2},{2,1})end,
  function(r)r:normal({0}, {-1},{0})end,
  function(r)r:normal({0}, {0/0},{0})end,
  function(r)r:uniform({10},{0},{0})end,
  function(r)r:uniform({0,1},{2,3},{1})end,
  function(r)r:exponential({-1},{0})end,
  function(r)r:exponential(np.array({1,2},'int64'),{2,1})end,
  function(r)r:exponential(np.array({'x'},'U1'))end,
  function(r)r:normal({2.0},1.0,{})end,
}
local reference=np.random.default_rng(500)
local broken=np.random.default_rng(500)
for _,fn in ipairs(bad) do
  local ok=pcall(fn,broken)
  assert(not ok,'expected parameter/shape validation failure')
end
assert(broken:raw_hex()==reference:raw_hex(), 'invalid calls consumed PCG64')
print('random77 Lua regression passed: '..#bad..' invalid calls and valid broadcast inputs')
