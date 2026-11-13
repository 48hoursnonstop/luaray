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
local calls=0
local a=lr.fromfunction(function(i,j)
    calls=calls+1
    eq(i.shape,{2,3});eq(j.shape,{2,3})
    eq(i.dtype,'float64');eq(j.dtype,'float64')
    eq(lr.shares_memory(i,j),false)
    return 10*i+j
end,{2,3})
eq(calls,1);eq(a:tolist(),{{0,1,2},{10,11,12}})
local n=lr.fromfunction(function(...)return select('#',...)end,{})
eq(n,0)
local scalar=lr.fromfunction(function()return 42 end,{2,3});eq(scalar,42)
local marker={name='context'}
local x,y,z=lr.fromfunction(function(...)return ... end,{},nil,nil,marker,false)
eq(x,nil);eq(rawequal(y,marker),true);eq(z,false)
local count=lr.fromfunction(function(...)return select('#',...)end,{2},nil,nil,false)
eq(count,3)
local returns=table.pack(lr.fromfunction(function()return nil,false,7 end,{}))
eq(returns.n,3);eq(returns[1],nil);eq(returns[2],false);eq(returns[3],7)
returns=table.pack(lr.fromfunction(function()end,{}));eq(returns.n,0)
local token=function()end
eq(lr.fromfunction(function()return token end,{}),token)
local callback=setmetatable({}, {__call=function(self,i,j) return i+j end})
a=lr.fromfunction(callback,{2,3},{dtype=lr.dtype('float32')})
eq(a.dtype,'float32');eq(a:tolist(),{{0,1,2},{1,2,3}})
a=lr.fromfunction(lr.add,{2,3},{dtype='int32'})
eq(a.dtype,'int32');eq(a:tolist(),{{0,1,2},{1,2,3}})
local i,j=lr.fromfunction(function(...)return ... end,{2,3})
eq(i.flags.owndata,false);eq(j.flags.owndata,false)
eq(i:tolist(),{{0,0,0},{1,1,1}});eq(j:tolist(),{{0,1,2},{0,1,2}})
collectgarbage('collect');i:set(9,1,1);eq(j:tolist()[1][1],0)
a=lr.fromfunction(function(i,j) i:fill(7);return i end,{2,3})
eq(a:tolist(),{{7,7,7},{7,7,7}});eq(a.flags.owndata,false)
a=lr.fromfunction(function(i)i:setflags(false);return i end,{3})
eq(a.flags.writeable,false);eq(a:tolist(),{0,1,2})
local shape={2,3}
a=lr.fromfunction(function(i,j)shape[1]=99;return i+j end,shape)
eq(a.shape,{2,3});eq(shape[1],99)
local before=calls
fails(function()lr.fromfunction(function()calls=calls+1 end,{-1,2})end);eq(calls,before)
fails(function()lr.fromfunction(function()calls=calls+1 end,{2},{dtype='nonsense'})end);eq(calls,before)
local error_marker={message='callback error'}
local ok,err=pcall(function()lr.fromfunction(function()error(error_marker)end,{2})end)
eq(ok,false);eq(rawequal(err,error_marker),true)
fails(function()lr.fromfunction(7,{2})end)
fails(function()lr.fromfunction(function()end,{2},false)end)
fails(function()lr.fromfunction(function()end,{2},{sparse=true})end)
fails(function()lr.fromfunction(function()end)end)
local high={};for axis=1,63 do high[axis]=1 end
n=lr.fromfunction(function(...)return select('#',...)end,high);eq(n,63)
high[64]=1;fails(function()lr.fromfunction(function()end,high)end)
print('fromfunction regression: '..checks..' checks passed')
