local np=require('luaray_core')
local function eq(a,b) assert(a==b,tostring(a)..' != '..tostring(b)) end
local function reject(fn) assert(not pcall(fn),'expected error') end

-- Returned parts must share storage rather than making copies.
local a=np.reshape(np.array({1,2,3,4,5,6},'int32'),{2,3})
local p=np.split(a,{1,2},2)
eq(#p,3)
for i=1,3 do eq(p[i].shape[1],2);eq(p[i].shape[2],1) end
p[2]:set(99,1,1)
eq(a:get(1,2),99)
a:set(77,2,2)
eq(p[2]:get(2,1),77)

-- Views must keep the shared owner alive after the original array is GC'd.
local function orphaned()
  local arr=np.array({11,12,13,14},'int64')
  local parts=np.split(arr,{1,3})
  return parts[2]
end
local orphan=orphaned()
collectgarbage('collect')
eq(orphan[1],12);eq(orphan[2],13)
orphan[1]=555
collectgarbage('collect')
eq(orphan[1],555)

-- Negative-stride and transposed inputs remain views at their original layout.
local original=np.array({4,7,11,19,28},'int64')
local rev=original:get(np.slice(nil,nil,-1))
local pieces=np.array_split(rev,3)
eq(pieces[1][1],28);eq(pieces[2][1],11);eq(pieces[3][1],4)
pieces[1][2]=808
eq(original[4],808)
local tr=np.reshape(np.array({1,2,3,4,5,6},'float64'),{2,3}).T
local rows=np.vsplit(tr,3)
rows[3]:set(100,1,2)
eq(tr:get(3,2),100)

-- Unsorted/overlong/negative boundaries reproduce NumPy slicing semantics.
local x=np.array({1,2,3,4},'int32')
local weird=np.split(x,{-1,3,2,100,-100})
eq(#weird,6)
local lens={3,0,0,2,0,4}
for i=1,#weird do eq(weird[i].shape[1],lens[i]) end
local empty=np.array_split(np.zeros({0,3},'U2'),4)
eq(#empty,4)
for _,part in ipairs(empty) do eq(part.shape[1],0);eq(part.shape[2],3);eq(part.dtype,'<U2') end

-- The views must preserve parameterized temporal/string descriptors too.
local dt=np.array({'2026-10-09','2026-10-10','2026-10-11'},'datetime64[D]')
local dp=np.split(dt,{1})
eq(dp[1].dtype,'datetime64[D]')
eq(tostring(dp[2][1]),'2026-10-10')
local txt=np.array({'東京','é','界'},'U2')
local tp=np.array_split(txt,2)
eq(tp[1].dtype,'<U2')
eq(tp[2][1],'界')

-- Valid alternative split-index representation: a 1-D integer ndarray.
local indexed=np.split(x,np.array({1,3},'int64'))
eq(indexed[1][1],1);eq(indexed[2][1],2);eq(indexed[3][1],4)

-- Dimension constraints and equal-split rules.
reject(function()np.split(x,3)end)
reject(function()np.array_split(x,0)end)
reject(function()np.split(x,0)end)
reject(function()np.split(x,2,0)end)
reject(function()np.split(x,2,2)end)
reject(function()np.split(x,2,np.array({1,2}))end)
reject(function()np.vsplit(x,2)end)
reject(function()np.dsplit(tr,2)end)
reject(function()np.split(np.array(10,'int64'),1)end)
reject(function()np.hsplit(np.array(10,'int64'),1)end)
reject(function()np.split(x,{1.5})end)
reject(function()np.split(x,np.array({{1}},'int64'))end)
print('split regression: ok')
