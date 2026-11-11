local lr=require('luaray')
local checks=0
local function check(value)checks=checks+1;assert(value)end
local function reject(call)check(not pcall(call))end
local a=lr.arange(6):reshape({2,3})
local b=lr.arange(12):reshape({3,4})
local matrix=lr.tensordot(a,b,1)
check(matrix.shape[1]==2 and matrix.shape[2]==4 and matrix:get(1,1)==20 and matrix:get(2,4)==92)
check(not lr.shares_memory(matrix,a) and not lr.shares_memory(matrix,b))
matrix:set(-1,1,1);check(a:get(1,1)==0 and b:get(1,1)==0)
local scalar=lr.tensordot({1,2},{3,4},{axes={1,1}})
check(scalar.ndim==0 and scalar:tolist()==11)
local product=lr.tensordot({1,2},{3,4},0)
check(product.shape[1]==2 and product.shape[2]==2 and product:get(2,2)==8)
check(lr.tensordot(2,3,math.mininteger):tolist()==6)
local explicit=lr.tensordot(a,b,{{-1},{1}})
check(explicit:get(1,1)==20)
check(lr.tensordot(a,a,{}):tolist()==55)
local tensor=lr.arange(12):reshape({2,3,2})
local contraction=lr.tensordot(tensor,tensor,{axes={{3,1},{3,1}}})
check(contraction.shape[1]==3 and contraction.shape[2]==3 and contraction:get(1,1)==86)
local empty=lr.tensordot(lr.zeros({2,0},'int8'),lr.zeros({0,3},'int8'),1)
check(empty.dtype=='int8' and empty:get(2,3)==0)
local promoted=lr.tensordot(lr.array({1,2},'int8'),lr.array({1,2},'float32'),1)
check(promoted.dtype=='float32' and promoted:tolist()==5)
local boolean=lr.tensordot(lr.array({true,false},'bool'),lr.array({false,true},'bool'),1)
check(boolean.dtype=='bool' and not boolean:tolist())
local complex=lr.tensordot(lr.array({lr.complex(0,1)},'complex128'),lr.array({lr.complex(0,1)},'complex128'),1)
check(complex:tolist().real==-1 and complex:tolist().imag==0)
local reversed=lr.tensordot(lr.flip(a,1),b,{axes=1})
check(reversed:get(1,1)==56 and reversed:get(2,1)==20)
local flags=lr.array({true,true,false},'bool')
local coefficients=lr.array({lr.complex(-2,-1),lr.complex(-1,0),lr.complex(0,1)},'complex64')
local zero=lr.tensordot(flags,coefficients,0):get(3,2)
check(zero.real==0 and zero.imag==0)
local seconds=lr.array({1,2},'timedelta64[s]')
local milliseconds=lr.array({1,2},'timedelta64[ms]')
local duration=lr.tensordot(seconds,milliseconds,1)
check(duration.dtype=='timedelta64[ms]' and lr.astype(duration,'int64'):tolist()==5000)
local nat=lr.array({math.mininteger},'timedelta64[h]')
check(lr.astype(lr.tensordot(nat,{2},1),'int64'):tolist()==0)
local shape={};for i=1,64 do shape[i]=1 end
local high=lr.ones(shape,'int8')
check(lr.tensordot(high,high,64):tolist()==1)
reject(function()lr.tensordot(high,{1},0)end)
reject(function()lr.linalg.tensordot(high,lr.array({1}),0)end)
for _,call in ipairs({
 function()lr.tensordot()end,
 function()lr.tensordot(a)end,
 function()lr.tensordot(a,b,1,1)end,
 function()lr.tensordot(a,b,true)end,
 function()lr.tensordot(a,b,1.0)end,
 function()lr.tensordot(a,b,{axes=1,unknown=1})end,
 function()lr.tensordot(a,b,{['axes\0']=1})end,
 function()lr.tensordot(a,b,3)end,
 function()lr.tensordot(a,b,{0,1})end,
 function()lr.tensordot(a,b,{{1,1},{1,2}})end,
 function()lr.tensordot(a,b,{{1},{1,2}})end,
 function()lr.tensordot(a,b,{{1},{1}})end,
 function()lr.tensordot({{1},{2,3}},b,1)end,
 function()lr.tensordot({'a'},{'b'},1)end,
})do reject(call)end
print('tensordot regression: '..checks..' checks passed')
