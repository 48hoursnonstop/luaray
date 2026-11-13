local np=require('luaray_core')
assert(np._version=='0.137.0-dev')
local function shape(v,want)
  assert(type(v)=='userdata' and v.dtype=='float64')
  assert(#v.shape==#want)
  for j,d in ipairs(want) do assert(v.shape[j]==d) end
end
local rng=np.random.default_rng(790079)
for _,name in ipairs({'gamma','beta','chisquare','f'}) do
  local a=np.transpose(np.array({{1,2,3},{4,5,6}},'int64'))
  local x = (name=='chisquare') and rng[name](rng,a,{2,3,2})
    or rng[name](rng,a,.5,{2,3,2})
  shape(x,{2,3,2})
end
shape(rng:gamma({{0},{2}},{{0.0,1.0,2.0}}),{2,3})
shape(rng:beta({{.5},{2}},{{1,2,3}}),{2,3})
shape(rng:chisquare(np.flip(np.array({1,2,3},'int64'),1)),{3})
shape(rng:f({{1},{2}},{{3,4,5}}),{2,3})
shape(rng:gamma({1},1,{0,1}),{0,1})
shape(rng:beta({1},2,{0,1}),{0,1})
local bad={
 function(r)r:gamma({1,-1},1,{0,2})end,
 function(r)r:gamma({1},-1,{0})end,
 function(r)r:gamma({1,2},{3,4},{2,3})end,
 function(r)r:gamma(np.array({'a'},'U1'),1)end,
 function(r)r:beta({1,0},2,{0,2})end,
 function(r)r:beta(1,{.2,-3},{0,2})end,
 function(r)r:beta({1,2},{3,4},{3,3})end,
 function(r)r:beta(np.array({'a'},'U1'),1)end,
 function(r)r:chisquare({0,1},{0,2})end,
 function(r)r:chisquare({1,-2},{0,2})end,
 function(r)r:chisquare({1,2},{2,3})end,
 function(r)r:f({1,2},{1,-2},{0,2})end,
 function(r)r:f({0,2},2,{0,2})end,
 function(r)r:f({1,2},{2,3},{2,3})end,
 function(r)r:beta({1/0,2},1)end,
 function(r)r:gamma({0/0,2},1)end,
}
for j,fn in ipairs(bad) do
  local r=np.random.default_rng(792000+j)
  local control=np.random.default_rng(792000+j)
  assert(not pcall(fn,r),'invalid request unexpectedly accepted #'..j)
  assert(r:raw_hex()==control:raw_hex(),'invalid request advanced PCG64 #'..j)
end
print('random79 regression passed: 4 vectorized distributions, strided views, zero-size, 16 invalid requests')
