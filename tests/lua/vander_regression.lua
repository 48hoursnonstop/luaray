local lr=require('luaray')
local checks=0
local function check(value) checks=checks+1;assert(value)end
local function reject(call)check(not pcall(call))end
local x=lr.array({1,2,3},'int8')
local v=lr.vander(x)
check(v.shape[1]==3 and v.shape[2]==3 and v.dtype=='int64')
check(v:get(2,1)==4 and v:get(2,2)==2 and v:get(2,3)==1)
local increasing=lr.vander(x,{n=4,increasing=true})
check(increasing:get(3,1)==1 and increasing:get(3,4)==27)
check(not lr.shares_memory(x,v))
v:set(99,1,1);check(x[1]==1)
check(lr.vander(x,0).shape[2]==0)
check(lr.vander(lr.array({},'float32'),2).shape[1]==0)
check(lr.vander(lr.array({1.,2.},'float32')).dtype=='float64')
check(lr.vander(lr.array({true,false})).dtype=='int64')
local text=lr.vander(lr.array({'a','b'},'S4'),1)
check(text.dtype=='|S21' and text:get(2,1)=='1')
check(lr.vander(lr.array({'a','b'},'S4'),0).shape[2]==0)
check(lr.vander(lr.array({1},'timedelta64[h]'),0).size==0)
check(lr.astype(lr.vander(lr.array({1},'timedelta64[h]'),1),'int64'):get(1,1)==1)
local constant=lr.broadcast_to(lr.array(2),{3})
check(lr.vander(constant):get(3,1)==4)
local retained=lr.vander(lr.array({2,3}),3)
collectgarbage('collect');check(retained:get(2,1)==9)
local samples=lr.array({0.,1.,2.},'float64')
local coefficients=lr.linalg.solve(lr.vander(samples),lr.array({1.,4.,9.},'float64'))
check(math.abs(coefficients[1]-1)<1e-12 and math.abs(coefficients[2]-2)<1e-12 and math.abs(coefficients[3]-1)<1e-12)
for _,call in ipairs({
 function()lr.vander()end,
 function()lr.vander(1)end,
 function()lr.vander({{1,2},{3,4}})end,
 function()lr.vander(x,-1)end,
 function()lr.vander(x,1.5)end,
 function()lr.vander(x,true)end,
 function()lr.vander(x,2,1)end,
 function()lr.vander(x,{n=2,increasing=1})end,
 function()lr.vander(x,{unknown=1})end,
 function()lr.vander(x,{['n\0']=2})end,
 function()lr.vander(x,{},true)end,
 function()lr.vander(x,2,true,1)end,
 function()lr.vander(lr.array({},'S4'),2)end,
 function()lr.vander({'a','b'},2)end,
 function()lr.vander(lr.array({1},'timedelta64[h]'),2)end,
 function()lr.vander(lr.array({1},'float64'),math.maxinteger)end,
})do reject(call)end
print('vander regression: '..checks..' checks passed')
