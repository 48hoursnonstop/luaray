local lr=require('luaray')
local checks=0
local function check(value)checks=checks+1;assert(value)end
local function reject(call)check(not pcall(call))end
local a=lr.zeros({5,3},'int64')
check(lr.fill_diagonal(a,{2,7})==nil)
check(a:get(1,1)==2 and a:get(2,2)==7 and a:get(3,3)==2 and a:get(5,1)==0)
lr.fill_diagonal(a,{3,8},{wrap=true})
check(a:get(1,1)==3 and a:get(2,2)==8 and a:get(3,3)==3 and a:get(5,1)==8)
local reverse=lr.flip(a,1);lr.fill_diagonal(reverse,4)
check(a:get(5,1)==4 and a:get(4,2)==4 and a:get(3,3)==4)
local cube=lr.zeros({2,2,2},'float32');lr.fill_diagonal(cube,{{3,4},{5,6}})
check(cube:get(1,1,1)==3 and cube:get(2,2,2)==4 and cube:get(1,2,1)==0)
local f=lr.asfortranarray(lr.zeros({3,3},'int8'));lr.fill_diagonal(f,{1,2})
check(f:get(1,1)==1 and f:get(2,2)==2 and f:get(3,3)==1 and f.strides[1]==1)
local live=lr.arange(9):reshape({3,3});lr.fill_diagonal(live,live)
check(live:get(2,2)==1 and live:get(3,3)==2)
local progressive=lr.arange(16):reshape({4,4})
lr.fill_diagonal(progressive,progressive:get(1,lr.slice(nil,nil,-1)))
check(progressive:get(1,1)==3 and progressive:get(2,2)==2 and progressive:get(3,3)==1 and progressive:get(4,4)==3)
local shape={};for i=1,64 do shape[i]=1 end
local rank64=lr.zeros(shape,'int8');lr.fill_diagonal(rank64,7)
check(rank64:flatten()[1]==7)
local labels=lr.zeros({2,2},'U4');lr.fill_diagonal(labels,true)
check(labels:get(1,1)=='True' and labels:get(2,2)=='True' and labels:get(1,2)=='')
local boolean=lr.zeros({2,2},'bool');lr.fill_diagonal(boolean,lr.complex(0,1));check(boolean:get(2,2))
local typed=lr.zeros({2,2},'int8');lr.fill_diagonal(typed,lr.array({256},'int64'));check(typed:get(1,1)==0)
reject(function()lr.fill_diagonal(typed,256)end)
lr.fill_diagonal(typed,lr.array({},'int64'));check(typed:get(1,1)==0)
local parsed=lr.zeros({2,2},'float64');lr.fill_diagonal(parsed,{'1.25','2.5'})
check(parsed:get(1,1)==1.25 and parsed:get(2,2)==2.5)
check(lr.fill_diagonal(lr.zeros({0,3}),'2')==nil)
for _,call in ipairs({
 function()lr.fill_diagonal()end,
 function()lr.fill_diagonal(lr.zeros({2,2}))end,
 function()lr.fill_diagonal({{1,2},{3,4}},1)end,
 function()lr.fill_diagonal(lr.arange(3),1)end,
 function()lr.fill_diagonal(lr.zeros({2,1,2}),1)end,
 function()lr.fill_diagonal(lr.zeros({2,2}),1,1)end,
 function()lr.fill_diagonal(lr.zeros({2,2}),1,{wrap=1})end,
 function()lr.fill_diagonal(lr.zeros({2,2}),1,{unknown=true})end,
 function()lr.fill_diagonal(lr.zeros({2,2}),1,{['wrap\0']=true})end,
 function()lr.fill_diagonal(lr.zeros({2,2}),1,false,1)end,
 function()lr.fill_diagonal(lr.zeros({2,2},'int64'),0/0)end,
 function()lr.fill_diagonal(lr.zeros({2,2},'int64'),'bad')end,
 function()lr.fill_diagonal(lr.broadcast_to(lr.array({0}),{2,2}),{})end,
})do reject(call)end
print('fill diagonal regression: '..checks..' checks passed')
