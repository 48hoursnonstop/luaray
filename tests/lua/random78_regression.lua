local np=require('luaray_core')
assert(np._version=='0.130.0-dev')
local function shape(a, expected)
  assert(type(a)=='userdata' and a.dtype=='float64')
  assert(#a.shape==#expected)
  for i=1,#expected do assert(a.shape[i]==expected[i]) end
end
local rng=np.random.default_rng(42)
local names={'lognormal','laplace','gumbel','logistic','rayleigh','weibull','pareto','power'}
for _,name in ipairs(names) do
  local a={{1},{2}}
  local v=(name=='lognormal' or name=='laplace' or name=='gumbel' or name=='logistic')
      and rng[name](rng,a,{{.5,.75,1.0}})
      or rng[name](rng,a,{2,3})
  shape(v,{2,3})
end
local reversed=np.flip(np.array({.5,1,2,3},'float64'),1)
local view=rng:weibull(reversed)
shape(view,{4})
for _,v in ipairs(view:tolist()) do assert(v>=0) end
local x=rng:laplace(np.array({{0},{2}},'int64'),{{.5,1,2}},{2,2,3})
shape(x,{2,2,3})
local empty=rng:lognormal({.5}, {1.5}, {0,1})
shape(empty,{0,1})
local invalid={
  function(r)r:lognormal({0,1},{.5,-1},{0,2})end,
  function(r)r:laplace({0},{-0.1},{0})end,
  function(r)r:gumbel({0},np.array({-2.0},'float64'))end,
  function(r)r:logistic({0,1},{1,-.1})end,
  function(r)r:rayleigh({1,-1},{0})end,
  function(r)r:weibull({0,-.01},{0,2})end,
  function(r)r:pareto({0.0}, {0})end,
  function(r)r:power({0,-1},{0,2})end,
  function(r)r:power({1,2},{3,1})end,
  function(r)r:laplace({0,1},{.5,1},{3,1})end,
  function(r)r:rayleigh(np.array({'x'},'U1'))end,
}
for i,fn in ipairs(invalid) do
  local a=np.random.default_rng(800+i)
  local b=np.random.default_rng(800+i)
  local ok=pcall(fn,a)
  assert(not ok, 'bad arguments unexpectedly accepted: '..i)
  assert(a:raw_hex()==b:raw_hex(),'invalid request advanced PCG64: '..i)
end
print('random78 regression passed: 8 broadcast distributions, negative views, empty outputs, 11 invalid cases')
