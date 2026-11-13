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
local a=lr.array({0x0102,0x0304},'uint16')
local b=a:byteswap()
eq(b:tolist(),{0x0201,0x0403});eq(a:tolist(),{0x0102,0x0304})
eq(lr.shares_memory(a,b),false);eq(b.dtype,a.dtype);eq(b.flags.owndata,true)
eq(rawequal(a:byteswap(true),a),true);eq(a:tolist(),{0x0201,0x0403})
a:byteswap({inplace=true});eq(a:tolist(),{0x0102,0x0304})
for _,control in ipairs({false,{},{inplace=false}}) do
    b=a:byteswap(control);eq(b:tolist(),{0x0201,0x0403});eq(rawequal(a,b),false)
end
local reverse=lr.flip(a,1)
reverse:byteswap(true);eq(a:tolist(),{0x0201,0x0403});eq(reverse:tolist(),{0x0403,0x0201})
a:setflags(false);fails(function()a:byteswap(true)end)
b=a:byteswap();eq(b.flags.writeable,true);eq(b:tolist(),{0x0102,0x0304})
for _,dtype in ipairs({'S0','U0','S2','uint8','bool'}) do
    local x=lr.ndarray({0},dtype);x:setflags(false)
    fails(function()x:byteswap(true)end)
    b=x:byteswap();eq(b.flags.writeable,true);eq(b.size,0)
end
for _,dtype in ipairs({'U2','>U2'}) do
    local text=lr.array({'λ','ab'},dtype);local raw=text:tobytes()
    b=text:byteswap();eq(b.dtype,text.dtype)
    eq(b:byteswap():tobytes(),raw);eq(text:tobytes(),raw)
    eq(b:byteswap():tolist(),{'λ','ab'})
end
local text=lr.array({'ab','cd'},'S2');eq(text:byteswap():tolist(),{'ab','cd'})
local z=lr.ndarray({3},'S0');eq(z:byteswap().itemsize,1);eq(z:byteswap(true).itemsize,0)
a=lr.asfortranarray(lr.array({{0x0102,0x0304},{0x0506,0x0708}},'uint16'))
b=a:byteswap();eq(b.flags.f_contiguous,true);eq(b:tolist(),{{0x0201,0x0403},{0x0605,0x0807}})
local storage=lr.arange(32,'uint8')
local overlap=lr.ndarray({2,3},{dtype='int32',buffer=storage,offset=4,strides={-1,2}})
overlap:byteswap(true)
eq(storage:get(lr.s(1,17)):tolist(),{0,1,2,5,6,4,8,3,10,11,9,7,12,13,14,15})
-- Source memory-overlap queries omit width terms for S0/U0, preserving a
-- reflected-address quirk. Bounds overlap need not imply an exact solution.
local zero=lr.ndarray({2,3},{dtype='S0',buffer=storage,offset=4,strides={1,2}})
eq(lr.may_share_memory(zero,zero),true);eq(lr.shares_memory(zero,zero),true)
zero=lr.ndarray({2,3},{dtype='U0',buffer=storage,offset=4,strides={2,4}})
eq(lr.may_share_memory(zero,zero),true);eq(lr.shares_memory(zero,zero),false)
zero=lr.ndarray({2,3},{dtype='U0',buffer=storage,offset=4,strides={0,0}})
eq(lr.may_share_memory(zero,zero),false);eq(lr.shares_memory(zero,zero),false)
for _,bad in ipairs({1,'true',{inplace=1},{other=true},{['inplace\0']=true}}) do
    fails(function()a:byteswap(bad)end)
end
fails(function()a:byteswap(true,false)end)
print('byteswap regression: '..checks..' checks passed')
