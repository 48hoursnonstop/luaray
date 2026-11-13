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
local points={}
for coordinate in lr.ndindex(2,3) do points[#points+1]=coordinate end
eq(points,{{1,1},{1,2},{1,3},{2,1},{2,2},{2,3}})
local it=lr.ndindex({2,3})
local first=it();eq(first,{1,1});first[1]=99
local second=it();eq(second,{1,2});eq(rawequal(first,second),false)
local saved=second
it();it();eq(saved,{1,2})
eq(it(),{2,2});eq(it(),{2,3});eq(it(),nil);eq(it(),nil)
local shape={2,3};it=lr.ndindex(shape);shape[1]=99
for i=1,6 do eq(it()~=nil,true) end
eq(it(),nil)
local scalar=lr.ndindex();eq(scalar(),{});eq(scalar(),nil)
scalar=lr.ndindex({});eq(scalar(),{});eq(scalar(),nil)
for _,empty in ipairs({{0},{2,0},{0,2,3},{false,3}}) do
    it=lr.ndindex(empty);eq(it(),nil);eq(it(),nil)
end
eq(lr.ndindex(true,2)(),{1,1})
local left,right=lr.ndindex(2),lr.ndindex(2)
eq(left(),{1});eq(left(),{2});eq(right(),{1})
local high={};for axis=1,1000 do high[axis]=1 end
it=lr.ndindex(high)
local coordinate=it();eq(#coordinate,1000);eq(coordinate[1],1);eq(coordinate[1000],1)
eq(it(),nil)
local variadic=lr.ndindex(table.unpack(high));eq(#variadic(),1000);eq(variadic(),nil)
local huge=lr.ndindex(math.maxinteger,math.maxinteger)
eq(huge(),{1,1});eq(huge(),{1,2});eq(huge(),{1,3})
eq(lr.ndindex(0,math.maxinteger)(),nil)
for _,bad in ipairs({{-1},{0,-1},{2.0},{true,-1},{[1]=2,[3]=3},{bad=2},table.pack(nil)}) do
    fails(function()lr.ndindex(bad)end)
end
fails(function()lr.ndindex(nil)end);fails(function()lr.ndindex('2')end)
fails(function()lr.ndindex({2},3)end)
print('ndindex regression: '..checks..' checks passed')
