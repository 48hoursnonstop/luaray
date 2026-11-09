local np=require('luaray_core')
assert(np._version=='0.121.0-dev')
local function eq(a,b)
  if type(a)~=type(b) then return false end
  if type(a)~='table' then return a==b end
  if #a~=#b then return false end
  for i=1,#a do if not eq(a[i],b[i]) then return false end end
  return true
end
local function err(fn) local ok=pcall(fn);assert(not ok,'expected failure') end
for _,seed in ipairs({0,1,42,9876}) do
  local rng=np.random.default_rng(seed)
  local x=np.arange(24,'int64'):reshape({2,3,4})
  local before=x:tolist()
  local y=rng:permuted(x,3)
  assert(eq(x:tolist(),before),'copy must not mutate source')
  assert(y.size==24 and y.dtype=='int64')
  local values=y:tolist()
  for i=1,2 do for j=1,3 do
    local source={table.unpack(before[i][j])}
    local target={table.unpack(values[i][j])}
    table.sort(source); table.sort(target)
    assert(eq(source,target),'each axis fiber is independently shuffled')
  end end
  local out=np.zeros({2,3,4},'int64')
  assert(rawequal(rng:permuted(x,3,out),out))
  assert(eq(x:tolist(),before),'out must not mutate source')
  local x2=np.arange(12,'int64'):reshape({3,4})
  local t=np.transpose(x2,{2,1})
  local output=rng:permuted(t,nil)
  assert(output.shape[1]==4 and output.shape[2]==3)
  assert(eq(t:tolist(),np.transpose(x2,{2,1}):tolist()))
  local alias=np.arange(9,'int32'):reshape({3,3})
  local alias_out=np.transpose(alias,{2,1})
  assert(rawequal(rng:permuted(alias,2,alias_out),alias_out))
  local small=np.arange(8,'int32'):reshape({2,4})
  local wide=np.zeros({2,4},'float64')
  assert(rawequal(rng:permuted(small,2,wide),wide))
  assert(wide.dtype=='float64')
  local table_out=rng:permuted({10,20,30,40,50})
  assert(table_out.size==5)
  local sorted=table_out:tolist();table.sort(sorted)
  assert(eq(sorted,{10,20,30,40,50}))
  local empty=np.arange(0,'int64'):reshape({2,0,3})
  local z=rng:permuted(empty,1)
  assert(z.size==0 and z.shape[1]==2 and z.shape[2]==0 and z.shape[3]==3)
  assert(rng:permuted(np.arange(0,'int64')).size==0)
  local reversed=np.flip(x2,2)
  local z2=rng:permuted(reversed,2)
  assert(z2.shape[1]==3 and z2.shape[2]==4)
end
local rng=np.random.default_rng(1)
local x=np.arange(12,'int64'):reshape({3,4})
err(function()rng:permuted()end)
err(function()rng:permuted(np.array(5))end)
err(function()rng:permuted(x,0)end)
err(function()rng:permuted(x,3)end)
err(function()rng:permuted(x,1.4)end)
err(function()rng:permuted(x,1,np.zeros({2,6},'int64'))end)
err(function()rng:permuted(x,1,np.zeros({3,4},'int8'))end)
err(function()rng:permuted(x,1,{})end)
err(function()rng:permuted(x,1,nil,'extra')end)
print('permuted73 Lua regression passed')
