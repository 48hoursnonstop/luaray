local np=require("luaray_core")
assert(np._version=="0.98.0-dev")
local rng=np.random.default_rng(42)
local a=rng:binomial(100,0.2,{2,3})
assert(a.dtype=="int64" and a.shape[1]==2 and a.shape[2]==3)
for i=1,2 do for j=1,3 do
    local v=a:get(i,j)
    assert(math.type(v)=="integer" and v>=0 and v<=100)
end end
assert(math.type(rng:binomial(10,0.5))=="integer")
local x=np.random.default_rng(42)
local y=np.random.default_rng(42)
local zeros=x:binomial(0,0.5,{200})
for i=1,200 do assert(zeros:get(i)==0) end
assert(x:raw_hex()==y:raw_hex())
local hi=np.random.default_rng(42)
local empty=np.random.default_rng(42)
local v=hi:binomial(10,0.5,{0,2})
assert(v.shape[1]==0 and v.shape[2]==2)
assert(hi:raw_hex()==empty:raw_hex())
for _,args in ipairs({{-1,0.5},{1e13,0.5},{5,-0.1},{5,1.1}}) do
    local r=np.random.default_rng(42)
    local ref=np.random.default_rng(42)
    assert(not pcall(function() return r:binomial(args[1],args[2]) end))
    assert(r:raw_hex()==ref:raw_hex())
end
print("distributions62 Lua regression passed")
