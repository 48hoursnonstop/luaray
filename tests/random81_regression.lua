local np=require('luaray_core')
assert(np._version=='0.107.0-dev')
local function equal(a,b)
 if type(a)~=type(b) then return false end
 if type(a)=='table' then
  if #a~=#b then return false end
  for i=1,#a do if not equal(a[i],b[i]) then return false end end
  return true
 end
 return a==b or (type(a)=='number' and a~=a and b~=b)
end
local checks=0
local function fail_no_draw(f)
 local g=np.random.default_rng(7215)
 local ref=np.random.default_rng(7215)
 local ok=pcall(function()f(g)end)
 assert(not ok,'expected rejection')
 assert(g:raw_hex()==ref:raw_hex(),'rejection consumed PCG64')
 checks=checks+1
end
fail_no_draw(function(g)g:standard_gamma(-1)end)
fail_no_draw(function(g)g:standard_gamma(-math.huge,{2})end)
fail_no_draw(function(g)g:standard_gamma({1,-2},{0,2})end)
fail_no_draw(function(g)g:standard_gamma({0,2},nil,'float16')end)
fail_no_draw(function(g)g:standard_gamma(2,nil,'float64',{})end)
fail_no_draw(function(g)g:standard_gamma(2,nil,'float64',np.zeros({2},'float32'))end)
fail_no_draw(function(g)g:standard_gamma(2,{2,3},'float64',np.zeros({6},'float64'))end)
fail_no_draw(function(g)g:standard_gamma({1,2},nil,'float64',np.zeros({2,3},'float64'))end)
fail_no_draw(function(g)g:standard_gamma({1,-1},nil,'float64',np.zeros({0,2},'float64'))end)
fail_no_draw(function(g)g:standard_gamma(2,nil,'float64',np.transpose(np.zeros({2,3},'float64')))end)
fail_no_draw(function(g)g:standard_gamma(2,nil,'float64',np.flip(np.zeros({2,3},'float64'),2))end)
fail_no_draw(function(g)g:standard_gamma(2,nil,'float64',np.zeros({2,3},'float64'),123)end)
local g=np.random.default_rng(123)
local f32=np.zeros({3,2},'float32')
assert(rawequal(g:standard_gamma({.5,math.huge},nil,'float32',f32),f32))
assert(f32.shape[1]==3 and f32.shape[2]==2)
assert(f32:tolist()[1][2]==math.huge)
local f64=np.zeros({2,3},'float64')
assert(rawequal(g:standard_gamma({{1},{2}},nil,nil,f64),f64))
assert(f64.shape[1]==2 and f64.shape[2]==3)
local nan=g:standard_gamma(0/0)
assert(nan~=nan)
local inf=g:standard_gamma(math.huge)
assert(inf==math.huge)
local empty=np.zeros({0,2},'float32')
assert(rawequal(g:standard_gamma({.5,0/0},nil,'float32',empty),empty))
assert(equal(empty.shape,{0,2}))
local one=np.zeros({},'float64')
assert(rawequal(g:standard_gamma(2,nil,'float64',one),one))
print('random81 Lua regression passed: '..checks..' unchanged-state validation cases plus output/nonfinite coverage')
