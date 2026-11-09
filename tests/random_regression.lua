local np = require('luaray_core')
assert(np._version=='0.115.0-dev')
local rng = np.random.default_rng(42)
local raws = {
 'c621fbcd16d92688','705a5661a791ffc1','dbcd12c26eda1624',
 'b286b60e1600888d'
}
for i=1,#raws do assert(rng:raw_hex()==raws[i]) end
rng:reseed(42)
local v=rng:random({2,2})
assert(v.dtype=='float64')
assert(v.shape[1]==2 and v.shape[2]==2)
assert(math.abs(v:get(1,1)-0.7739560485559633)<1e-15)
assert(math.abs(v:get(2,2)-0.6973680290593639)<1e-15)
local b=np.random.default_rng(42)
local c=b:random(4)
for i=1,4 do assert(math.abs(c:get(i)-v:get(math.floor((i-1)/2)+1,((i-1)%2)+1))<1e-15) end
local a=np.random.default_rng(1)
local u=a:uniform(2,5,5)
local n=np.random.default_rng(1)
for i=1,5 do assert(math.abs(u:get(i)-(2+3*n:random()))<1e-15) end
local d=np.random.default_rng(1)
local e=np.random.default_rng(1)
d:advance(10)
for i=1,10 do e:raw_hex() end
assert(d:raw_hex()==e:raw_hex())
assert(type(np.random.default_rng(2):random())=='number')
local empty=np.random.default_rng(3):random({2,0,3})
assert(empty.shape[1]==2 and empty.shape[2]==0 and empty.shape[3]==3)
assert(not pcall(function()np.random.default_rng(-1)end))
assert(not pcall(function()np.random.default_rng(1.5)end))
assert(not pcall(function()np.random.default_rng(1):random({-2,3})end))
assert(not pcall(function()np.random.default_rng(1):uniform(2,1)end))
print('random PCG64 regression passed')
