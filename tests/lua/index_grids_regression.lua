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
local dense=lr.indices({2,3})
eq(dense.shape,{2,2,3});eq(lr.dtype(dense.dtype),lr.dtype('intp'))
eq(dense:tolist(),{{{0,0,0},{1,1,1}},{{0,1,2},{0,1,2}}})
eq(dense.flags.owndata,true)
local sparse=lr.indices({2,3},{sparse=true,dtype='float32'})
eq(#sparse,2);eq(sparse[1].shape,{2,1});eq(sparse[2].shape,{1,3})
eq(sparse[1]:tolist(),{{0},{1}});eq(sparse[2]:tolist(),{{0,1,2}})
eq(sparse[1].flags.owndata,false);eq(lr.shares_memory(sparse[1],sparse[2]),false)
sparse[1]:set(9,1,1);eq(sparse[2]:tolist(),{{0,1,2}})
eq(lr.indices({2},'bool'):tolist(),{{false,true}})
fails(function()lr.indices({3},'bool')end)
eq(lr.indices({}).shape,{0});eq(lr.indices({},'nonsense',{sparse=true}),{})
eq(lr.indices({},false,{sparse=true}),{})
eq(lr.indices({-2,3},{sparse=true})[1].shape,{0,1})
fails(function()lr.indices({-2,3})end)
local rank={};for i=1,64 do rank[i]=1 end
local high=lr.indices(rank,{sparse=true});eq(#high,64);eq(high[1].ndim,64)
fails(function()lr.indices(rank)end)
rank[65]=1;fails(function()lr.indices(rank,{sparse=true})end)
for _,shape in ipairs({{2.0},{true},{[1]=2,[3]=3},{bad=2}}) do
    fails(function()lr.indices(shape)end)
end
fails(function()lr.indices(2)end);fails(function()lr.indices()end)
fails(function()lr.indices({2},{sparse=1})end)
fails(function()lr.indices({2},{unknown=true})end)
fails(function()lr.indices({2},'int32',{dtype='int64'})end)
fails(function()lr.indices({2},{dtype='int32'},{sparse=true})end)
fails(function()lr.indices({2},'int32',{},'extra')end)
local input=lr.array({1,3},'int32')
local mesh=lr.ix_(input,{true,false,true})
eq(mesh[1].shape,{2,1});eq(mesh[2].shape,{1,2})
eq(mesh[1]:tolist(),{{1},{3}});eq(mesh[2]:tolist(),{{1,3}})
eq(lr.shares_memory(mesh[1],input),true)
mesh[1]:set(2,1,1);eq(input:tolist(),{2,3})
eq(lr.ix_(),{})
eq(lr.dtype(lr.ix_({})[1].dtype),lr.dtype('intp'))
eq(lr.ix_(lr.array({},'float64'))[1].dtype,'float64')
fails(function()lr.ix_(lr.array(1))end)
fails(function()lr.ix_({{1,2}})end)
local retained
 do
  local owner=lr.array({2,4})
  retained=lr.ix_(owner)[1]
 end
collectgarbage('collect');retained:set(7,1);eq(retained:tolist(),{7,4})
local a=lr.array({{0,1},{2,0}})
local coordinates=lr.argwhere(a)
eq(coordinates:tolist(),{{1,2},{2,1}});eq(coordinates.flags.owndata,false)
eq(coordinates.flags.f_contiguous,true);eq(lr.shares_memory(coordinates,a),false)
coordinates:set(9,1,1);eq(a:tolist(),{{0,1},{2,0}})
eq(lr.argwhere(true).shape,{1,0});eq(lr.argwhere(false).shape,{0,0})
eq(lr.argwhere(nil).shape,{0,0});eq(lr.argwhere('\0').shape,{0,0})
eq(lr.argwhere('λ').shape,{1,0});eq(lr.argwhere(lr.complex(0,0)).shape,{0,0})
eq(lr.argwhere(lr.datetime64('NaT','D')).shape,{1,0})
eq(lr.argwhere(lr.datetime64(0,'D')).shape,{0,0})
eq(lr.argwhere(lr.zeros({0,2})).shape,{0,2})
fails(function()lr.argwhere()end);fails(function()lr.argwhere(1,2)end)
print('index grids regression: '..checks..' checks passed')
