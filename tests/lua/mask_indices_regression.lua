local lr=require('luaray')
local checks=0
local function check(value)checks=checks+1;assert(value)end
local function reject(call)check(not pcall(call))end
local indices=lr.mask_indices(3,lr.triu,1)
check(#indices==2 and indices[1].dtype=='int64' and indices[1].strides[1]==16)
local a=lr.arange(9):reshape({3,3});local selected=a:get(table.unpack(indices))
check(selected.size==3 and selected[1]==1 and selected[3]==5)
a:set(-1,table.unpack(indices));check(a:get(1,2)==-1 and a:get(3,1)==6)
local calls=0
local custom=lr.mask_indices(2,function(input,k)
 calls=calls+1;check(k==0 and input.dtype=='int64' and input:get(2,2)==1)
 input:set(0,1,1);return input
end)
check(calls==1 and custom[1].size==3)
check(lr.mask_indices(2,function(_,k)check(k==nil);return {0,2,0}end,nil)[1][1]==2)
local key={};check(lr.mask_indices(1,function(_,k)check(rawequal(k,key));return {1}end,key)[1][1]==1)
local callable=setmetatable({},{__call=function(_,input,k)check(k==false);return lr.tril(input)end})
check(lr.mask_indices(2,callable,false)[1].size==3)
local one=lr.mask_indices(2,function()return {0,2,-1}end)
check(#one==1 and one[1][1]==2 and one[1][2]==3)
local three=lr.mask_indices(2,function()return lr.ones({2,2,2})end)
check(#three==3 and three[1].size==8)
for _,dtype in ipairs({'S4','U4','>U4','datetime64[ms]'})do
 check(lr.mask_indices(2,function()return lr.zeros({2,2},dtype)end)[1].size==4)
end
check(lr.mask_indices(2,function()return lr.zeros({2,2},'timedelta64[h]')end)[1].size==0)
local nat=lr.array({math.mininteger,0,1},'timedelta64[h]')
check(lr.mask_indices(1,function()return nat end)[1].size==2)
check(lr.mask_indices(1,function()return lr.ones({1}), 'extra metadata' end)[1][1]==1)
local empty=lr.mask_indices(0,lr.tril)
check(empty[1].size==0 and empty[1].strides[1]==16)
local ran=false
reject(function()lr.mask_indices(-1,function()ran=true;return a end)end);check(not ran)
for _,call in ipairs({
 function()lr.mask_indices()end,
 function()lr.mask_indices(nil,function()return a end)end,
 function()lr.mask_indices(true,lr.triu)end,
 function()lr.mask_indices(1.0,lr.triu)end,
 function()lr.mask_indices(2,nil)end,
 function()lr.mask_indices(2,lr.triu,0,0)end,
 function()lr.mask_indices(2,function()error('callback error')end)end,
 function()lr.mask_indices(2,function()return 1 end)end,
 function()lr.mask_indices(2,function()return false end)end,
 function()lr.mask_indices(2,function()return {{1},{2,3}}end)end,
 function()lr.mask_indices(math.maxinteger,lr.triu)end,
})do reject(call)end
collectgarbage('collect');check(indices[1][1]==1 and indices[2][1]==2)
print('mask indices regression: '..checks..' checks passed')
