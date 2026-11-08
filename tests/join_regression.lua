local np=require('luaray_core')
local function equal(a,b) assert(a==b,tostring(a)..' != '..tostring(b)) end
local function rejected(fn) local ok=pcall(fn); assert(not ok,'expected error') end

-- Default axis is Lua 1, while explicit false is NumPy's axis=None.
local c=np.concatenate({{1,2},{3,4}})
equal(c.size,4);equal(c[4],4)
local s=np.stack({{1,2},{3,4}})
equal(s.shape[1],2);equal(s.shape[2],2);equal(s:get(2,1),3)

-- A strided output must be written by coordinates, not as a flat buffer.
local output_base=np.zeros({2,4},np.int32)
local output=output_base.T
local a=np.array({{1,2},{3,4}},np.int8)
local b=np.array({{5,6},{7,8}},np.int32)
local r=np.concatenate({a,b},{out=output})
assert(r==output);equal(output:get(4,2),8);equal(output_base:get(2,4),8)

-- Output sharing memory with input must be staged before any mutation.
local original=np.array({1,2,3,4},np.int64)
local tail=original:get(np.slice(2,5))
local first=original:get(np.slice(1,2))
local joined=np.concatenate({tail,first},{out=original})
assert(joined==original)
local want={2,3,4,1}
for i=1,4 do equal(original[i],want[i]) end

-- Strings and temporal families retain concrete descriptor information.
local mixed=np.concatenate({np.array({'a','é'},'U1'),np.array({'東京'},'U2')})
equal(mixed.dtype,'<U2');equal(mixed[3],'東京')
local temporal=np.concatenate({np.array({'2026-10-09'},'datetime64[D]'),np.array({'2026-10-09T12'},'datetime64[h]')})
equal(temporal.dtype,'datetime64[h]')
equal(tostring(temporal[1]),'2026-10-09T00');equal(tostring(temporal[2]),'2026-10-09T12')

local x=np.array({1,2},np.int64)
rejected(function()return np.concatenate({x},0)end)
rejected(function()return np.stack({x},0)end)
rejected(function()return np.concatenate({})end)
rejected(function()return np.concatenate({np.array(1)})end)
rejected(function()return np.concatenate({x},{out=x,dtype='int64'})end)
rejected(function()return np.concatenate({x},{dtype='int8',casting='safe'})end)
rejected(function()return np.stack({x,np.array({1})})end)
rejected(function()return np.concatenate({x},{out=np.zeros({3},np.int64)})end)
rejected(function()return np.stack({x},{axis=false})end)

-- Same-class stacking with destination casting, and empty inputs.
local z=np.concatenate({np.zeros({0,2},np.float32),np.ones({2,2},np.float32)})
equal(z.shape[1],2);equal(z:get(2,2),1)
local r3=np.stack({x,x,x},{axis=-1,casting='safe'})
equal(r3.shape[2],3);equal(r3:get(2,3),2)
print('join regression: ok')
