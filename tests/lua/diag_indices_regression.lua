local lr=require('luaray')
local checks=0
local function check(value)checks=checks+1;assert(value)end
local function reject(call)check(not pcall(call))end
local indices=lr.diag_indices(3)
check(#indices==2 and rawequal(indices[1],indices[2]))
check(indices[1].dtype=='int64' and indices[1][1]==1 and indices[1][3]==3)
local a=lr.arange(9):reshape({3,3})
local coords=lr.diag_indices_from(a)
local selected=a:get(table.unpack(coords))
check(selected[1]==0 and selected[2]==4 and selected[3]==8)
selected[1]=99;check(a:get(1,1)==0)
a:set(7,table.unpack(coords))
check(a:get(1,1)==7 and a:get(3,3)==7 and a:get(1,2)==1)
coords[1][1]=2;check(coords[2][1]==2)
local cube=lr.zeros({2,2,2},'int8')
cube:set(9,table.unpack(lr.diag_indices_from(cube)))
check(cube:get(1,1,1)==9 and cube:get(2,2,2)==9 and cube:get(1,2,1)==0)
check(#lr.diag_indices(3,0)==0 and #lr.diag_indices(3,-1)==0)
check(lr.diag_indices(-1)[1].size==0)
check(#lr.diag_indices(1,65)==65)
local shape={};for i=1,64 do shape[i]=1 end
check(#lr.diag_indices_from(lr.zeros(shape,'int8'))==64)
local values={7,true,1.25,0/0,lr.complex(0,1)}
local expected={'7','True','1.25','nan','1j'}
for _,dtype in ipairs({'S8','U8','>U8'})do
 for i,value in ipairs(values)do
  for mode=1,3 do
   local text=lr.zeros({2,2},dtype)
   if mode==1 then text:set(value,1,1)
   elseif mode==2 then text:set(value,table.unpack(lr.diag_indices(2)))
   else text:set(value,lr.array({{true,false},{false,true}},'bool'))end
   check(text:get(1,1)==expected[i] and text:get(1,2)=='')
  end
 end
end
check(lr.array({0/0},'U4')[1]=='nan')
check(lr.array({lr.complex(0,1)},'U8')[1]=='1j')
check(lr.array({1.234567890123456},'U32')[1]=='1.234567890123456')
check(lr.array({lr.complex(1.234567890123456,2.345678901234567)},'U64')[1]=='(1.234567890123456+2.345678901234567j)')
local clipped=lr.zeros({1},'U2');clipped[1]=1.25;check(clipped[1]=='1.')
local readonly=lr.diagonal(lr.zeros({2,2},'U4'))
reject(function()readonly[1]=7 end)
for _,call in ipairs({
 function()lr.diag_indices()end,
 function()lr.diag_indices(1.5)end,
 function()lr.diag_indices(2,true)end,
 function()lr.diag_indices(2,{unknown=1})end,
 function()lr.diag_indices(2,{['ndim\0']=2})end,
 function()lr.diag_indices(2,{},1)end,
 function()lr.diag_indices(math.maxinteger,0)end,
 function()lr.diag_indices(1,math.maxinteger)end,
 function()lr.diag_indices_from({{1,2},{3,4}})end,
 function()lr.diag_indices_from(lr.arange(3))end,
 function()lr.diag_indices_from(lr.zeros({2,3}))end,
 function()lr.diag_indices_from(a,1)end,
})do reject(call)end
print('diag indices regression: '..checks..' checks passed')
