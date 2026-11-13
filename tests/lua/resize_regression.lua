local lr = require('luaray')
local checks = 0
local function eq(a,b)
    checks=checks+1
    if type(b)=='table' then
        assert(type(a)=='table' and #a==#b)
        for i=1,#b do eq(a[i],b[i]) end
    else assert(a==b, tostring(a)..' ~= '..tostring(b)) end
end
local function fails(f)
    checks=checks+1
    assert(not pcall(f))
end
local a=lr.array({{1,2},{3,4}},'int32')
local b=lr.resize(a,{2,3})
eq(b:tolist(),{{1,2,3},{4,1,2}})
eq(b.flags.owndata,false)
eq(lr.shares_memory(a,b),false)
b[1]=99;eq(a:tolist(),{{1,2},{3,4}})
eq(lr.resize(lr.transpose(a),{2,3}):tolist(),{{1,3,2},{4,1,3}})
eq(lr.resize(lr.flip(a,1),{3}):tolist(),{3,4,1})
eq(lr.resize({8,9},{5}):tolist(),{8,9,8,9,8})
eq(lr.resize(7,{}):tolist(),7)
b=lr.resize(lr.array({},'int16'),{2,2})
eq(b:tolist(),{{0,0},{0,0}});eq(b.flags.owndata,true)
b=lr.resize(a,{2,0});eq(b.shape,{2,0});eq(b.flags.owndata,true)
for _,dtype in ipairs({'S0','U0'}) do
    local z=lr.ndarray({3},dtype)
    b=lr.resize(z,{2,3});eq(b.itemsize,0);eq(b.flags.c_contiguous,true);eq(b.flags.f_contiguous,false)
    eq(lr.resize(z,{0}).itemsize,dtype=='S0' and 1 or 4)
end
collectgarbage("collect") -- Earlier temporary views must release their native owners.
local alias=a
eq(a:resize({3,2}),nil);eq(alias,a);eq(alias:tolist(),{{1,2},{3,4},{0,0}})
eq(a:resize(),nil);eq(a:resize(nil),nil)
eq(a:resize({1,6},{refcheck=true}),nil);eq(alias.shape,{1,6})
eq(a:resize({2}),nil);eq(a:tolist(),{1,2})
local view=lr.reshape(a,{1,2})
fails(function()a:resize({3})end)
fails(function()a:resize({3},{refcheck=false})end)
eq(a:tolist(),{1,2});eq(view:tolist(),{{1,2}})
eq(a:resize({2,1}),nil);eq(view.shape,{1,2})
fails(function()view:resize({4})end)
view=nil;collectgarbage('collect');collectgarbage('collect')
eq(a:resize({4},{refcheck=false}),nil);eq(alias:tolist(),{1,2,0,0})
a=lr.asfortranarray(lr.array({{1,2},{3,4}}));a:resize({3,2})
eq(a:tolist(),{{1,4},{3,0},{2,0}});eq(a.flags.f_contiguous,true)
a=lr.array({{1}});a:resize({});eq(a.shape,{});eq(a:tolist(),1)
a=lr.array({1,2});a:setflags(false);a:resize({4})
eq(a:get(1),1);eq(a:get(2),2);eq(a.flags.writeable,false) -- New numeric tail is unspecified.
a=lr.array({'λ','x'},'U2');a:setflags(false);a:resize({4})
eq(a:tolist(),{'λ','x','',''});eq(a.flags.writeable,false) -- Native safety guarantee.
a=lr.ndarray({3},'S0');local zview=lr.reshape(a,{3})
zview:resize({2,4});eq(zview.size,8);eq(a.size,3)
a=lr.frombuffer(string.pack('i8i8',1,2),'int64')
a:resize({1,2});eq(a:tolist(),{{1,2}})
fails(function()a:resize({3})end)
a=lr.array({1,2,3,4});view=a:get(lr.s(1,nil,2))
fails(function()view:resize({2})end)
for _,shape in ipairs({{-1},{0,-1},{-1,0},{2,1.5},{2,false},{[1]=2,[3]=1},{bad=2},{math.maxinteger,2},{0,math.maxinteger}}) do
    fails(function()lr.resize({1,2},shape)end)
    fails(function()a:resize(shape)end)
end
local rank={};for i=1,65 do rank[i]=1 end
fails(function()lr.resize({1},rank)end);fails(function()a:resize(rank)end)
fails(function()lr.resize({1})end);fails(function()lr.resize({1},{1},'extra')end)
fails(function()a:resize({2},{refcheck=1})end)
fails(function()a:resize({2},{other=true})end)
fails(function()a:resize({2},false)end)
fails(function()a:resize({2},{refcheck=false},'extra')end)
print('resize regression: '..checks..' checks passed')
