local np=require('luaray_core')
assert(np._version=='0.154.0-dev')
local function equal(a,b)
  if type(a)~=type(b) then return false end
  if type(a)~='table' then return a==b end
  if #a~=#b then return false end
  for i=1,#a do if not equal(a[i],b[i]) then return false end end
  return true
end
local function throws(f) assert(not pcall(f),'expected error') end
for _,seed in ipairs({0,1,42,9876}) do
  local r=np.random.default_rng(seed)
  local a=np.arange(21,'int64'):reshape({3,7})
  local before=a:tolist()
  local b=r:permutation(a,2)
  assert(equal(a:tolist(),before),'permutation mutated input')
  for i=1,3 do
    local xs=before[i];local ys=b:tolist()[i]
    table.sort(xs);table.sort(ys);assert(equal(xs,ys))
  end
  local q=r:permutation(0)
  assert(q.dtype=='int64' and q.size==0 and q.shape[1]==0)
  assert(r:permutation(-3).size==0)
  assert(r:permutation(1):get(1)==0)
  assert(r:permutation(1,999):get(1)==0) -- NumPy ignores axis for integer input
  local empty=np.arange(0):reshape({2,0})
  r:shuffle(empty,2)
  assert(empty.size==0)
  local arr=np.arange(24,'float32'):reshape({2,3,4})
  local trans=np.transpose(arr,{3,1,2})
  local p=r:permutation(trans,1)
  assert(p.shape[1]==4 and p.dtype=='float32')
  assert(arr:get(1,1,1)==0)
  local t={10,20,30,40,50}
  assert(r:shuffle(t)==nil)
  table.sort(t);assert(equal(t,{10,20,30,40,50}))
  throws(function()r:shuffle(np.array(5))end)
  throws(function()r:permutation(np.array(5))end)
  throws(function()r:shuffle(arr,0)end)
  throws(function()r:permutation(arr,0)end)
  throws(function()r:shuffle(arr,5)end)
  throws(function()r:permutation(arr,5)end)
  throws(function()r:shuffle(t,2)end)
  throws(function()r:permutation({1,2,3},2)end)
  throws(function()r:shuffle('abc')end)
end
print('shuffle72 Lua regression passed')
