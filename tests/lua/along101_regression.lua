local np=require('luaray_core')
local checks=0
local function eq(a,b)
 checks=checks+1
 if type(b)=='table' then assert(type(a)=='table' and #a==#b);for i=1,#b do eq(a[i],b[i]) end
 else assert(a==b,tostring(a)..' != '..tostring(b)) end
end
local function fails(fn,fragment)
 checks=checks+1;local ok,err=pcall(fn);assert(not ok,'expected along-axis error')
 if fragment then assert(tostring(err):find(fragment,1,true),tostring(err)) end
end
local a=np.array({{10,30,20},{60,40,50}},'int32')
local indices=np.array({{1,-1},{-1,1}},'int64')
eq(np.take_along_axis(a,indices):tolist(),{{10,20},{50,60}})
eq(np.take_along_axis(a,np.array({-1,1},'int64'),false):tolist(),{50,10})
eq(np.take_along_axis(a,np.array({-1,1},'int64'),nil):tolist(),{50,10})
local sorted=np.take_along_axis(a,np.argsort(a,{axis=2}),2)
eq(sorted:tolist(),{{10,20,30},{40,50,60}})
eq(np.shares_memory(sorted,a),false)
sorted:set(100,1,1);eq(a:get(1,1),10)
eq(np.put_along_axis(a,np.array({{2},{1}},'int64'),99,2),nil)
eq(a:tolist(),{{10,99,20},{99,40,50}})
np.put_along_axis(a,np.array({1,-1},'int64'),{7,8},false)
eq(a:tolist(),{{7,99,20},{99,40,8}})
local transpose=np.transpose(a)
fails(function()np.put_along_axis(transpose,np.array({1},'int64'),5,false)end,'read-only')
eq(a:tolist(),{{7,99,20},{99,40,8}})
local readonly=np.broadcast_to(np.array({{1,2,3}},'int32'),{2,3})
fails(function()np.put_along_axis(readonly,np.array({{1}},'int64'),9,2)end,'read-only')
for _,bad in ipairs({np.array({{1.0}},'float64'),np.array({{true}},'bool'),np.array({{'1'}},'U1')}) do
 fails(function()np.take_along_axis(a,bad,2)end,'integer array')
end
fails(function()np.take_along_axis(a,np.array({1},'int64'),2)end,'same rank')
fails(function()np.take_along_axis(a,np.array({{1}},'int64'),false)end,'one dimension')
fails(function()np.take_along_axis(a,indices,0)end)
fails(function()np.take_along_axis(a,indices,true)end)
fails(function()np.take_along_axis(a,indices,3)end)
fails(function()np.take_along_axis(np.array(5),np.array(1))end)
eq(np.take_along_axis(np.array(5),np.array({1},'int64'),false):tolist(),{5})
fails(function()np.put_along_axis(a,indices,9)end)
fails(function()np.take_along_axis(a)end)
fails(function()np.take_along_axis(a,indices,2,4)end)
fails(function()np.put_along_axis({},indices,9,2)end)
fails(function()np.take_along_axis(a,np.array({{0}},'int64'),2)end,'index 0')
local alias=np.array({{-1,-2,-1},{-2,-1,-2}},'int64')
np.put_along_axis(alias,alias,-1,2)
eq(alias:tolist(),{{-1,-1,-1},{-2,-1,-1}}) -- indices snapshotted before writes
local target=np.array({{'x','x','x'}},'S4')
fails(function()np.put_along_axis(target,np.array({{1,2}},'int64'),np.array({'a','β'},'U1'),2)end)
eq(target:tolist(),{{'x','x','x'}}) -- first conversion buffer fails before writes
collectgarbage('collect')
print('along101 regression: '..checks..' checks passed')
