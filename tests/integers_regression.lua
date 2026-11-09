local np=require('luaray_core')
assert(np._version=='0.114.0-dev')
local known={0,7,6,4,4,8,0,6,2,0,5,9}
local r=np.random.default_rng(42)
local a=r:integers(0,10,12)
assert(a.dtype=='int64' and a.shape[1]==12)
for i=1,#known do assert(a:get(i)==known[i]) end
local scalar=np.random.default_rng(42):integers(10)
assert(scalar==0)
local b=np.random.default_rng(42):integers(-7,20,{3,4},'int32')
assert(b.dtype=='int32' and b.shape[1]==3 and b.shape[2]==4)
assert(b:get(1,1)==-5 and b:get(3,4)==19)
local c=np.random.default_rng(42):integers(0,2,{2,3},'bool')
assert(c.dtype=='bool')
assert(c:get(1,1)==false and c:get(2,1)==true)
local empty=np.random.default_rng(42):integers(10,nil,{2,0,3},'int8')
assert(empty.dtype=='int8' and empty.shape[2]==0)
local zero=np.random.default_rng(42):integers(5,5,3,'int64',true)
for i=1,3 do assert(zero:get(i)==5) end
local expect_bad={
 function()r:integers(0)end,
 function()r:integers(5,5)end,
 function()r:integers(7,5)end,
 function()r:integers(-1,10,nil,'uint8')end,
 function()r:integers(0,256,nil,'int8')end,
 function()r:integers(0,9,nil,'float64')end,
 function()r:integers(0,9,{-1,2})end,
 function()r:integers(0,9,nil,'int32','true')end,
 function()r:integers(0,9,nil,'int8',true,true)end,
 function()r:integers(1.5,10)end,
}
for i,f in ipairs(expect_bad) do assert(not pcall(f),'invalid integers arguments accepted: '..i) end
-- Lower 32-bit draws are buffered; raw hexadecimal accesses the PCG64 core.
local mix=np.random.default_rng(42)
assert(mix:integers(0,10)==0)
assert(mix:raw_hex()=='705a5661a791ffc1')
assert(mix:integers(0,10)==7)
assert(mix:raw_hex()=='dbcd12c26eda1624')
local advance=np.random.default_rng(42)
assert(advance:integers(0,10)==0)
advance:advance(0)
assert(advance:integers(0,10)==6)
print('integers regression passed')
