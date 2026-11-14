local lr=require('luaray')
local checks=0
local function eq(a,b)
 checks=checks+1
 if type(b)=='table' then assert(type(a)=='table' and #a==#b);for i=1,#b do eq(a[i],b[i])end
 elseif type(b)=='number' then assert(a==b or a~=a and b~=b,tostring(a)..' ~= '..tostring(b))
 else assert(a==b,tostring(a)..' ~= '..tostring(b))end
end
local function fails(fn)checks=checks+1;assert(not pcall(fn))end
local empty=lr.empty({0,3,4},'float32')
local q=lr.quantile(empty,0.25,{axis={2,3}})
eq(q.shape,{0});eq(q.dtype,'float32');eq(q.flags.owndata,true)
q=lr.quantile(empty,{0.25,0.5},{axis={2,3}})
eq(q.shape,{2,0});eq(q.dtype,'float64')
local m=lr.median(empty,{axis={2,3},keepdims=true})
eq(m.shape,{0,1,1});eq(m.strides,{0,0,0});eq(m.flags.owndata,false)
eq(lr.shares_memory(m,empty),false)
q=lr.percentile(lr.empty({3,0},'int16'),{25,50},{axis={}})
eq(q.shape,{2,3,0});eq(q.dtype,'float64')
fails(function()lr.quantile(lr.empty({3,0}),0.25,{axis=2})end)
fails(function()lr.quantile(lr.empty({0,0}),0.25,{axis=1})end)
eq(lr.median(lr.empty({3,0}),{axis=2}):tolist(),{0/0,0/0,0/0})
local a=lr.array({{1,2,3},{4,5,6}},'float64')
local f=lr.median(lr.transpose(a),{axis={}})
eq(f.strides,{8,24});eq(f.flags.f_contiguous,true)
eq(f:tolist(),{{1,4},{2,5},{3,6}})
local view=lr.median(a,{axis=1,keepdims=true})
eq(view.strides,{0,8});eq(view.flags.owndata,false)
eq(view:tolist(),{{2.5,3.5,4.5}})
a=nil;collectgarbage('collect');eq(view:get(1,2),3.5)
local ld=lr.array({1,2,3,4},'longdouble')
eq(lr.quantile(ld,{0.25,0.5}).dtype,'longdouble')
eq(lr.quantile(ld,lr.array({0.25,0.5},'longdouble')).dtype,'longdouble')
local inf=lr.array({{1,math.huge},{0,1}})
for _,p in ipairs({1,-1,2,-2,'fro','nuc',math.huge,-math.huge})do
 eq(lr.linalg.cond(inf,p),math.huge)
end
local nan=lr.array({{1,0/0},{0,1}})
for _,p in ipairs({1,-1,2,-2,'fro','nuc',math.huge,-math.huge})do
 eq(lr.linalg.cond(nan,p),0/0)
end
for _,value in ipairs({math.huge,-math.huge,0/0})do
 local bad=lr.array({{1,value},{0,1}})
 fails(function()lr.linalg.svd(bad)end)
 fails(function()lr.linalg.svdvals(bad)end)
 fails(function()lr.linalg.pinv(bad)end)
 fails(function()lr.linalg.matrix_rank(bad)end)
 fails(function()lr.linalg.lstsq(bad,lr.ones({2}))end)
end
local out=lr.full({1},9,'int64')
fails(function()lr.add_accumulate(lr.empty({0},'int64'),{axis=1,out=out})end)
eq(out:tolist(),{9})
out=lr.full({2,3},9,'int64')
fails(function()lr.add_accumulate(lr.ones({1,3},'int64'),{axis=1,out=out})end)
eq(out:tolist(),{{9,9,9},{9,9,9}})
local scalar=lr.full({},9,'int64')
fails(function()lr.cumsum(lr.array(1),{out=scalar})end)
eq(scalar:tolist(),9)
local t=lr.empty({0},'timedelta64[D]')
fails(function()lr.add_accumulate(t,{axis=1,out=lr.empty({0},'float64')})end)
local integer=lr.empty({0},'int16')
eq(lr.add_accumulate(t,{axis=1,out=integer}),integer)
for _,stride in ipairs({math.maxinteger,math.mininteger})do
 local empty=lr.ndarray({3,0},{dtype='float64',buffer='',strides={stride,8}})
 eq(lr.median(empty,{axis=2}):tolist(),{0/0,0/0,0/0})
 eq(lr.nanmedian(empty,{axis=2}):tolist(),{0/0,0/0,0/0})
 eq(lr.nanquantile(empty,0.25,{axis=2}):tolist(),{0/0,0/0,0/0})
end
for _,fn in ipairs({lr.median,lr.quantile,lr.percentile})do
 local scalar=lr.array(7,'float64')
 local result=fn==lr.median and fn(scalar,{keepdims=true}) or fn(scalar,0.5,{keepdims=true})
 eq(result,7)
end
print('NumPy 2.5.4 regression: '..checks..' checks passed')
