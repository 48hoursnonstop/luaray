local np=require("luaray_core")
assert(np._version=="0.127.0-dev")
local rng=np.random.default_rng(42)
local result=rng:hypergeometric(15,15,15,{2,3})
assert(result.dtype=="int64")
assert(result.shape[1]==2 and result.shape[2]==3)
for i=1,2 do for j=1,3 do local x=result:get(i,j); assert(x>=0 and x<=15) end end
assert(rng:hypergeometric(0,50,20)==0)
assert(rng:hypergeometric(50,0,20)==20)
assert(rng:hypergeometric(10,20,0)==0)
for _,args in ipairs({{-1,5,1},{4,-2,1},{5,5,11},{1000000000,1,1}}) do
 local ok=pcall(function() rng:hypergeometric(table.unpack(args)) end)
 assert(not ok)
end
print("distributions66 regression passed")
