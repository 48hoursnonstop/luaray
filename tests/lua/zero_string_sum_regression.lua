local lr=require('luaray')
local checks=0
local function eq(a,b)
 checks=checks+1
 if type(b)=='table' then
  assert(type(a)=='table' and #a==#b)
  for i=1,#b do eq(a[i],b[i]) end
 else assert(a==b,tostring(a)..' ~= '..tostring(b)) end
end
local function fails(f)checks=checks+1;assert(not pcall(f))end
for _,dtype in ipairs({'S0','U0','>U0'}) do
 local a=lr.ndarray({2,3},lr.dtype(dtype))
 local r=lr.sum(a,{axis=1,keepdims=true})
 eq(r.shape,{1,3});eq(r.strides,{0,0});eq(r:tolist(),{{'','',''}})
 eq(r.flags.owndata,true);eq(r.flags.c_contiguous,false);eq(r.flags.f_contiguous,false)
 eq(lr.dtype(r.dtype).itemsize,dtype=='S0' and 1 or 4)
 eq(lr.shares_memory(r,a),false)
 eq(lr.sum(lr.ndarray({1},lr.dtype(dtype))),'')
 fails(function()lr.sum(a)end)
 fails(function()lr.sum(a,{axis={1,2}})end)
 local unchanged=lr.sum(a,{axis={}})
 eq(unchanged.shape,{2,3});eq(unchanged:tolist(),{{'','',''},{'','',''}})
 local empty=lr.ndarray({3,0},lr.dtype(dtype))
 fails(function()lr.sum(empty,{axis=2})end)
 eq(lr.sum(empty,{axis=2,initial=0}):tolist(),{'','',''})
 fails(function()lr.sum(a,{axis=1,where=lr.array(true)})end)
 eq(lr.sum(a,{axis=1,initial=0,where=lr.array(false)}):tolist(),{'','',''})
 local out=lr.ndarray({3},lr.dtype(dtype))
 eq(rawequal(lr.sum(a,{axis=1,out=out}),out),true)
 eq(lr.dtype(out.dtype).itemsize,0)
 local width=dtype=='S0' and 'S4' or 'U4'
 out=lr.full({3},'x',{dtype=width})
 eq(rawequal(lr.sum(a,{axis=1,out=out,initial=true}),out),true)
 eq(out:tolist(),{'True','True','True'})
 lr.sum(a,{axis=1,out=out,initial=false})
 eq(out:tolist(),{'Fals','Fals','Fals'})
 lr.sum(a,{axis=1,out=out,initial=-123})
 eq(out:tolist(),{'-123','-123','-123'})
 lr.sum(a,{axis=1,out=out,initial=0.5})
 eq(out:tolist(),{'0.5','0.5','0.5'})
 out:setflags(false)
 fails(function()lr.sum(a,{axis=1,out=out})end)
end
for _,dtype in ipairs({'S0','U0','S3','U2'}) do
 local a=lr.ndarray({2,3},lr.dtype(dtype))
 if lr.dtype(a.dtype).itemsize>0 then a:fill('ab') end
 local out=lr.full({1,3},9,{dtype='int32'})
 fails(function()lr.sum(a,{axis=1,dtype='int64',out=out,keepdims=true,initial=5})end)
 eq(out:tolist(),{{5,5,5}})
 out:fill(9)
 fails(function()lr.sum(a,{axis=1,dtype='int64',out=out,keepdims=true,where=lr.ones({7},'bool')})end)
 eq(out:tolist(),{{9,9,9}})
 local scalar_input=lr.ndarray({},lr.dtype(dtype))
 if lr.dtype(scalar_input.dtype).itemsize>0 then scalar_input:fill('ab') end
 local scalar_output=lr.array(9,'int32')
 fails(function()lr.sum(scalar_input,{dtype='int64',out=scalar_output})end)
 eq(scalar_output:item(),9)
end
local nonzero_empty=lr.ndarray({0},lr.dtype('S3'))
fails(function()lr.sum(nonzero_empty,{out=lr.ndarray({},lr.dtype('S0')),dtype='int64'})end)
local scalar=lr.array(5)
eq(lr.sum(scalar,1),5);eq(lr.sum(scalar,-1),5);eq(lr.sum(scalar,{axis={}}),5)
fails(function()lr.sum(scalar,{axis={1}})end)
fails(function()lr.sum(scalar,{axis={-1}})end)
fails(function()lr.sum(scalar,{axis={1,-1}})end)
fails(function()lr.sum(lr.array({'a','b'},'S1'))end)
print('zero string sum regression: '..checks..' checks passed')
