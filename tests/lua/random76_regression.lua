local np=require('luaray_core')
assert(np._version=='0.136.0-dev')
local function eq(a,b)
 if type(a)~=type(b) then return false end
 if type(a)~='table' then return a==b end
 if #a~=#b then return false end
 for i=1,#a do if not eq(a[i],b[i]) then return false end end
 return true
end
local function bad(f)
 local ok=pcall(f)
 assert(not ok,'expected validation error')
end
local g=np.random.default_rng(42)
local z=g:bytes(0)
assert(#z==0)
local bytes=g:bytes(12)
assert(#bytes==12 and type(bytes)=='string')
local x=g:random({2,3},'float32')
assert(x.dtype=='float32' and eq(x.shape,{2,3}))
local y=np.zeros({2,3},'float64')
assert(g:random(nil,'float64',y)==y)
assert(y:tolist()[1][1]>=0 and y:tolist()[1][1]<1)
local v=np.zeros({2,3},'float32')
assert(g:random({2,3},'float32',v)==v)
local errors={
 function()g:bytes(-1)end,
 function()g:bytes(1.5)end,
 function()g:bytes()end,
 function()g:bytes('3')end,
 function()g:random(nil,'int64')end,
 function()g:random(3,'float32',np.zeros({3},'float64'))end,
 function()g:random({1,6},'float32',v)end,
 function()g:random({2,3},'float32',v,1)end,
 function()g:random(nil,'float32',{})end,
 function()g:random(nil,'float32',np.transpose(v))end,
}
local before=g:raw_hex()
for _,f in ipairs(errors)do bad(f)end
local following=g:raw_hex()
local t=np.random.default_rng(42)
t:bytes(0);t:bytes(12);t:random({2,3},'float32');t:random({2,3},'float64');t:random({2,3},'float32')
assert(t:raw_hex()==before)
assert(following~=before)
local mixed=np.random.default_rng(7)
local b1=mixed:bytes(3)
assert(#b1==3)
local f1=mixed:random(2,'float32')
local b2=mixed:bytes(9)
assert(#b2==9 and f1.size==2)
print('random76 Lua regression passed')
