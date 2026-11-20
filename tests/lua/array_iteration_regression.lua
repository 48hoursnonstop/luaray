local lr = require("luaray")

local a = lr.array({{1,2},{3,4}}, {dtype="int8", order="F"})
local i = lr.ndenumerate(lr.flip(a, 2))
local first,value = i()
assert(first[1]==1 and first[2]==1 and value==2)
first[1]=99
local second,value2=i()
assert(second[1]==1 and second[2]==2 and value2==1)
assert(lr.ndenumerate(lr.empty({2,0,3}))()==nil)
local scalar,n=lr.ndenumerate(lr.array(17))()
assert(#scalar==0 and n==17)

local row=lr.array({1,2})
local both=lr.broadcast(row, {{3},{4}})
assert(both.ndim==2 and both.nd==2 and both.size==4 and both.numiter==2)
assert(both.shape[1]==2 and both.shape[2]==2 and both.index==0)
local result={}
for pair in both do result[#result+1]=pair[1]+pair[2] end
assert(table.concat(result,",")=="4,5,5,6" and both.index==4 and both()==nil)
both:reset()
row[1]=9
assert(both:next()[1]==9 and both.index==1)
assert(not pcall(function() both.index=4 end))
local shape=both.shape
shape[1]=100
assert(both.shape[1]==2)
local empty=lr.broadcast(lr.empty({1,0}),lr.ones({2,1}))
assert(empty.size==0 and empty()==nil)
local noargs=lr.broadcast()
assert(#noargs()==0 and noargs()==nil)
assert(not pcall(lr.broadcast,{1,2},{1,2,3}))
print("Broadcast and indexed array iteration regression passed")
