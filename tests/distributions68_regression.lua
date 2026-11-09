local np=require("luaray_core")
assert(np._version=="0.105.0-dev")
local r=np.random.default_rng(42)
local a=r:multinomial(20,{0.2,0.3,0.5},{2,3})
assert(a.dtype=="int64" and #a.shape==3)
assert(a.shape[1]==2 and a.shape[2]==3 and a.shape[3]==3)
for i=1,2 do for j=1,3 do
  local total=0
  for k=1,3 do local x=a:get(i,j,k);assert(x>=0 and x<=20);total=total+x end
  assert(total==20)
end end
assert(a:get(1,1,1)==5 and a:get(1,1,2)==5 and a:get(1,1,3)==10)
assert(r:raw_hex()=="a4d45831c814ce06")
local b=np.random.default_rng(42):multinomial(20,np.array({0.2,0.3,0.5},"float64"),{2,3})
assert(b:get(1,1,1)==5 and b:get(2,3,3)==8)
local single=np.random.default_rng(42):multinomial(15,{0.2})
assert(single.shape[1]==1 and single:get(1)==15)
local zeros=np.random.default_rng(42):multinomial(0,{0.4,0.6},{3})
assert(zeros:get(1,1)==0 and zeros:get(3,2)==0)
for _,args in ipairs({{10,{}},{-1,{0.5,0.5}},{10,{0.7,0.5,0.1}},{10,{0,0/0}},{10,{0.1,2}},{10,{"bad",1}}}) do
  local good=pcall(function() np.random.default_rng(42):multinomial(args[1],args[2]) end)
  assert(not good)
end
local ok=pcall(function() np.random.default_rng(42):multinomial(10,{0.2,0.8},{-1}) end)
assert(not ok)
print("distributions68 regression passed")
