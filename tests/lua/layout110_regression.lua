local np=require('luaray_core')
local checks=0
local function check(value)checks=checks+1;assert(value)end
local function rejects(fn)check(not pcall(fn))end
local a=np.array({{0,1,2},{3,4,5}},'float64')
for _,order in ipairs({'C','F','A','K','c','f','a','k'})do
 local r=np.ravel(a,order)
 check(r.ndim==1 and r.size==6)
 check(a:flatten(order).size==6)
 check(not np.shares_memory(a:flatten(order),a))
end
local reversed=np.flip(np.ravel(a),1)
local v=reversed:reshape({2,3},{copy=false})
check(np.shares_memory(v,a))
check(v.strides[1]==-24 and v.strides[2]==-8)
check(not np.shares_memory(reversed:ravel('K'),a))
check(not np.shares_memory(a:reshape(a.shape,{copy=true}),a))
check(np.shares_memory(a:reshape(a.shape,{copy=false}),a))
check(a:reshape(-2).size==6)
local stride=np.ravel(a):get(np.s(1,nil,2))
check(np.shares_memory(stride:reshape({3}),a))
check(not np.shares_memory(stride:ravel(),a))
local t=np.transpose(a)
rejects(function()t:reshape(6,{copy=false})end)
check(np.shares_memory(t:reshape(6,{order='F',copy=false}),a))
for _,order in ipairs({'bad','C\0','X'})do
 rejects(function()np.ravel(a,order)end)
 rejects(function()a:flatten(order)end)
 rejects(function()a:reshape(6,order)end)
end
for _,op in ipairs({function(x)return np.ravel(a,x)end,function(x)return a:flatten(x)end})do
 rejects(function()op({copy=false})end)
 rejects(function()op({['order\0']='C'})end)
 rejects(function()op(3)end)
end
rejects(function()a:reshape(6,{['copy\0']=true})end)
rejects(function()a:reshape(6,{copy='if_needed\0'})end)
rejects(function()a:reshape(6,{copy=1})end)
rejects(function()a:reshape(6,{order='K'})end)
rejects(function()a:reshape({-1,-1})end)
rejects(function()np.reshape(a)end)
rejects(function()np.ravel()end)
local shape={};for i=1,65 do shape[i]=1 end
rejects(function()np.reshape(np.array(1),shape)end)
local view
do local original=np.array({1,2,3});view=original:ravel();original=nil end
collectgarbage('collect');check(view:tolist()[3]==3)
local ro=np.broadcast_to(np.array(1),{3})
local copied=ro:ravel();np.copyto(copied,2,'unsafe')
check(copied:tolist()[1]==2 and ro:tolist()[1]==1)
local ro1=np.broadcast_to(np.array(1),{1})
rejects(function()np.copyto(ro1:ravel(),2,'unsafe')end)
local independent=ro1:flatten();np.copyto(independent,2,'unsafe')
check(independent:tolist()[1]==2 and ro1:tolist()[1]==1)
print('layout110 regression: '..checks..' checks passed')
