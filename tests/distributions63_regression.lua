local np=require('luaray_core')
assert(np._version=='0.107.0-dev')
local r=np.random.default_rng(42)
local a=r:negative_binomial(2.5,0.4,{2,3})
assert(a.dtype=='int64' and a.shape[1]==2 and a.shape[2]==3)
for i=1,2 do for j=1,3 do assert(math.type(a:get(i,j))=='integer' and a:get(i,j)>=0) end end
assert(math.type(r:negative_binomial(1,0.7))=='integer')
local x=np.random.default_rng(42)
local y=np.random.default_rng(42)
local empty=x:negative_binomial(2,0.5,{0})
assert(empty.shape[1]==0 and x:raw_hex()==y:raw_hex())
local z=np.random.default_rng(42)
local ones=z:negative_binomial(3,1,{6})
for i=1,6 do assert(ones:get(i)==0) end
assert(z:raw_hex()~=y:raw_hex())
for _,args in ipairs({{0,0.5},{-1,0.5},{2,0},{2,1.1},{2,0.0001}}) do
    local rng=np.random.default_rng(42)
    local ref=np.random.default_rng(42)
    assert(not pcall(function() rng:negative_binomial(args[1],args[2]) end))
    assert(rng:raw_hex()==ref:raw_hex())
end
print('distributions63 Lua regression passed')
