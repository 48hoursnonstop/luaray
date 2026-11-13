local lr=require('luaray')
local checks=0
local function eq(a,b)
  checks=checks+1
  if type(b)=='table' then
    assert(type(a)=='table' and #a==#b)
    for i=1,#b do eq(a[i],b[i]) end
  else assert(a==b,tostring(a)..' ~= '..tostring(b)) end
end
local function fails(f) checks=checks+1;assert(not pcall(f)) end
local a=lr.array({{1,2,3},{4,5,6}},'int16')
local seen={}
local sum=lr.apply_along_axis(function(row)
  seen[#seen+1]=row
  eq(row.ndim,1)
  return lr.sum(row)
end,2,a)
eq(sum:tolist(),{6,15});eq(#seen,2)
eq(lr.shares_memory(seen[1],a),true)
eq(lr.shares_memory(sum,a),false)
eq(lr.apply_along_axis(lr.sum,1,a):tolist(),{5,7,9})
eq(lr.apply_along_axis(lr.sum,-1,a):tolist(),{6,15})
local identity=lr.apply_along_axis(function(row)return row end,1,a)
eq(identity:tolist(),a:tolist());eq(identity.flags.f_contiguous,true)
eq(lr.shares_memory(identity,a),false)
identity:set(100,1,1);eq(a:get(1,1),1)
local matrix=lr.apply_along_axis(function(row)return lr.diag(row)end,2,a)
eq(matrix.shape,{2,3,3});eq(matrix:get(2,3,3),6)
local vector=lr.apply_along_axis(function(row)return {row.size,123}end,1,a)
eq(vector.shape,{2,3});eq(vector:tolist(),{{2,2,2},{123,123,123}})
local scalar=lr.apply_along_axis(function(row)return lr.sum(row)end,1,{2,3,4})
eq(scalar.ndim,0);eq(scalar:item(),9)
local callable=setmetatable({},{__call=function(_,row,scale,context)
  eq(context.name,'parameter');return row*scale
end})
eq(lr.apply_along_axis(callable,2,a,3,{name='parameter'}):tolist(),{{3,6,9},{12,15,18}})
local n=0
lr.apply_along_axis(function(row,...)
  n=n+1;eq(select('#',...),3)
  local x,y,z=...;eq(x,7);eq(y,nil);eq(z,9)
  return row
end,2,a,7,nil,9)
eq(n,2)
local first=true
local changing=lr.apply_along_axis(function()
  if first then first=false;return lr.array({1,2},'int16') end
  return 7
end,2,a)
eq(changing:tolist(),{{1,2},{7,7}});eq(lr.dtype(changing.dtype).name,'int16')
local mutable=lr.array({{1,2},{3,4}})
local mutated=lr.apply_along_axis(function(row)row:fill(7);return row end,2,mutable)
eq(mutable:tolist(),{{7,7},{7,7}});eq(mutated:tolist(),mutable:tolist())
eq(lr.shares_memory(mutated,mutable),false)
local locked=lr.array({{1,2},{3,4}});locked:setflags(false)
eq(lr.apply_along_axis(function(row)return row end,2,locked):tolist(),{{1,2},{3,4}})
fails(function()lr.apply_along_axis(function(row)row:fill(7);return row end,2,locked)end)
local empty_calls=0
local selected_empty=lr.apply_along_axis(function(row)
  empty_calls=empty_calls+1;eq(row.size,0);return 5
end,2,lr.empty({2,0}))
eq(empty_calls,2);eq(selected_empty:tolist(),{5,5})
fails(function()lr.apply_along_axis(function()empty_calls=99 end,1,lr.empty({2,0}))end)
eq(empty_calls,2)
local calls=0
fails(function()lr.apply_along_axis(function(row)
  calls=calls+1;row:fill(calls)
  if calls==2 then error('callback marker') end
  return row
end,2,mutable)end)
eq(calls,2);eq(mutable:tolist(),{{1,1},{2,2}})
local marker={tag='same error'}
local ok,err=pcall(function()lr.apply_along_axis(function()error(marker)end,2,a)end)
eq(ok,false);eq(err,marker)
for _,axis in ipairs({0,3,-3,1.0,'1',false}) do
  fails(function()lr.apply_along_axis(lr.sum,axis,a)end)
end
fails(function()lr.apply_along_axis(lr.sum,1,3)end)
fails(function()lr.apply_along_axis(7,1,{1})end)
local shape={};for i=1,64 do shape[i]=1 end
local high=lr.ones(shape,'int8')
local high_result=lr.apply_along_axis(function(row)return row end,32,high)
eq(high_result.shape,shape);eq(high_result.size,1)
fails(function()lr.apply_along_axis(function()return lr.ones({1,1})end,32,high)end)
print('axis callback regression: '..checks..' checks passed')
