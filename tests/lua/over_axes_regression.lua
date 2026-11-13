local lr=require('luaray')
local checks=0
local function eq(a,b)
 checks=checks+1
 if type(b)=='table' then
  assert(type(a)=='table' and #a==#b)
  for i=1,#b do eq(a[i],b[i]) end
 else assert(a==b,tostring(a)..' ~= '..tostring(b)) end
end
local function fails(fn) checks=checks+1;assert(not pcall(fn)) end
local a=lr.arange(24):reshape({2,3,4})
local axes={}
local result=lr.apply_over_axes(function(value,axis)
 axes[#axes+1]=axis
 return lr.sum(value,{axis=axis})
end,a,{1,-1})
eq(axes,{1,3});eq(result.shape,{1,3,1})
eq(result:tolist(),{{{60},{92},{124}}})
eq(lr.shares_memory(result,a),false)
local same=lr.apply_over_axes(function(v)return v end,a,{3,1,1})
eq(rawequal(same,a),true)
eq(rawequal(lr.apply_over_axes(7,a,{}),a),true)
local copied=lr.apply_over_axes(function(v)return v:copy()end,a,2)
eq(copied:tolist(),a:tolist());eq(lr.shares_memory(copied,a),false)
local keep=lr.apply_over_axes(function(value,axis)
 return lr.sum(value,{axis=axis,keepdims=true})
end,a,{1,3})
eq(keep:tolist(),result:tolist())
local callable=setmetatable({},{__call=function(_,value,axis)
 return lr.sum(value,{axis=axis})
end})
eq(lr.apply_over_axes(callable,a,{1,3}):tolist(),result:tolist())
local repeated=lr.apply_over_axes(function(value,axis)return lr.sum(value,{axis=axis})end,a,{1,1,3})
eq(repeated:tolist(),result:tolist())
local normalized={}
local identity=lr.apply_over_axes(function(v,axis)
 normalized[#normalized+1]=axis;return v
end,a,{-1,-3,-4,-7,99})
eq(rawequal(identity,a),true);eq(normalized,{3,1,-1,-4,99})
local value=lr.apply_over_axes(function(v,axis)return lr.sum(v,{axis=axis})end,{1,2,3},1)
eq(value.shape,{1});eq(value:tolist(),{6})
local scalar=lr.apply_over_axes(function()return 5 end,lr.array(1),1)
eq(scalar.ndim,0);eq(scalar:item(),5)
local fixed=lr.apply_over_axes(function()return lr.zeros({2,3})end,lr.ones({4,5}),99)
eq(fixed.shape,{2,3})
local mutable=lr.ones({2,3})
local calls=0
local failed=pcall(function()lr.apply_over_axes(function(v)
 calls=calls+1;v:fill(calls)
 if calls==2 then error('stop') end
 return v
end,mutable,{1,2,1})end)
eq(failed,false);eq(calls,2);eq(mutable:tolist(),{{2,2,2},{2,2,2}})
local marker={}
local ok,err=pcall(function()lr.apply_over_axes(function()error(marker)end,a,1)end)
eq(ok,false);eq(err,marker)
fails(function()lr.apply_over_axes(function()return 1 end,a,1)end)
fails(function()lr.apply_over_axes(function(v)return lr.expand_dims(v,1)end,a,1)end)
fails(function()lr.apply_over_axes(function(v)return v end,a,0)end)
fails(function()lr.apply_over_axes(function(v)return v end,a,{1,2.0})end)
fails(function()lr.apply_over_axes(function(v)return v end,a,{[1]=1,[3]=2})end)
fails(function()lr.apply_over_axes(function(v)return v end,a,{x=1})end)
fails(function()lr.apply_over_axes(function(v)return v end,a,nil)end)
fails(function()lr.apply_over_axes(7,a,1)end)
local before=lr.empty({0,3})
eq(lr.apply_over_axes(function(v,axis)return lr.sum(v,{axis=axis})end,before,1):tolist(),{{0,0,0}})
local readonly=lr.ones({2,3});readonly:setflags(false)
eq(rawequal(lr.apply_over_axes(function(v)return v end,readonly,1),readonly),true)
fails(function()lr.apply_over_axes(function(v)v:fill(3);return v end,readonly,1)end)
local shape={};for i=1,64 do shape[i]=1 end
local high=lr.ones(shape)
eq(lr.apply_over_axes(function(v,axis)return lr.sum(v,{axis=axis})end,high,{1,64}).shape,shape)
for _,item in ipairs({lr.array(5),lr.empty({0}),lr.ones({2,3}),lr.ones({1,2,1})}) do
 eq(rawequal(lr.squeeze(item,{}),item),true)
 eq(lr.squeeze(item,{}).flags.owndata,item.flags.owndata)
end
local no_singletons=lr.ones({2,3})
eq(rawequal(lr.squeeze(no_singletons),no_singletons),true)
local singleton=lr.ones({1,3})
eq(rawequal(lr.squeeze(singleton),singleton),false)
eq(lr.shares_memory(lr.squeeze(singleton),singleton),true)
print('over axes regression: '..checks..' checks passed')
