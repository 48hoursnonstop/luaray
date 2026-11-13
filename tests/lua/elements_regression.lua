local lr=require('luaray')
local checks=0
local function check(value)checks=checks+1;assert(value)end
local function reject(call)check(not pcall(call))end
local a=lr.arange(6):reshape({2,3})
check(a:item(4)==3 and a:item({2,3})==5 and a:item(-1)==5)
check(a:item({4})==3 and a:item({-1,-1})==5)
local f=lr.asfortranarray(a);check(f:item(4)==3)
local reversed=a:get(lr.s(nil,nil,-1),lr.s(nil,nil,-1));check(reversed:item(1)==5)
check(lr.array(7):item()==7 and lr.array({7}):item({})==7)
check(lr.array(true):item()==true)
check(lr.array({'a\0b'},'S3'):item()=='a\0b')
local complex=lr.array({lr.complex(1,2)},'complex64'):item();check(complex.real==1 and complex.imag==2)
local temporal=lr.array({math.mininteger},'datetime64[D]'):item()
check(temporal.isnat and temporal.dtype=='datetime64[D]')
local huge=lr.astype(lr.array({'18446744073709551615'}),'uint64')
local value=huge:item();check(value.ndim==0 and value.dtype=='uint64')
check(lr.array_equal(value,huge:reshape({})) and not lr.shares_memory(value,huge))
value:set(7);check(lr.astype(huge,'U40')[1]=='18446744073709551615')
local ld=lr.add(lr.array(1.,'longdouble'),2^-63)
local ld_scalar=ld:item();check(ld_scalar.ndim==0 and ld_scalar.dtype=='longdouble')
check(lr.array_equal(ld_scalar,ld) and not lr.array_equal(ld_scalar,lr.array(1.,'longdouble')))
ld=nil;collectgarbage('collect');check(not lr.array_equal(ld_scalar,lr.array(1.,'longdouble')))
local cl=lr.array(lr.complex(1,2),'clongdouble'):item();check(cl.dtype=='complex256' and cl.ndim==0)
check(a:fill(7)==nil and a:get(2,3)==7 and a.shape[1]==2)
local base=lr.array({1,2,3,4},'int64');local alias=base:get(lr.s(2,3)):reshape({})
base:fill(alias);check(base[1]==2 and base[4]==2)
local flags=lr.array({0,0,0},'bool');flags:fill({});check(not lr.any(flags))
flags:fill({false});check(lr.all(flags))
flags:fill(lr.array({{false}}));check(not lr.any(flags))
local narrow=lr.zeros({2},'int8');reject(function()narrow:fill(256)end)
narrow:fill(lr.array(256,'int64'));check(narrow[1]==0)
local numbers=lr.zeros({2},'float64');reject(function()numbers:fill(lr.complex(1,2))end)
numbers:fill(lr.array(lr.complex(1,2),'complex128'));check(numbers[1]==1 and numbers[2]==1)
local dates=lr.zeros({2},'datetime64[D]');dates:fill(lr.datetime64(-1,'Y'))
check(lr.astype(dates,'int64')[1]==-365)
check(lr.astype(lr.astype(lr.array({-1,0,1},'datetime64[Y]'),'datetime64[D]'),'int64')[1]==-365)
local duration=lr.zeros({2},'timedelta64[h]');reject(function()duration:fill(lr.timedelta64(1,'Y'))end)
local text=lr.zeros({1},'U80');text:fill(lr.timedelta64(math.maxinteger,'Y'))
check(text[1]=='9223372036854775807 y')
local source=lr.broadcast_to(lr.array(1,'int64'),{3})
check(source:item(2)==1);reject(function()source:fill(2)end)
local empty_readonly=lr.broadcast_to(lr.array(1),{0});reject(function()empty_readonly:fill(1)end)
local empty=lr.zeros({0},'float64');reject(function()empty:fill('invalid')end)
local storage=lr.zeros({33},'uint8');local unaligned=storage:get(lr.s(2,nil)):view('longdouble')
unaligned:fill(ld_scalar);check(lr.array_equal(unaligned:item(1),ld_scalar))
check(not lr.shares_memory(unaligned:item(1),storage))
for _,call in ipairs({
 function()a:item()end,
 function()a:item(0)end,
 function()a:item(7)end,
 function()a:item(-7)end,
 function()a:item(1.0)end,
 function()a:item(true)end,
 function()a:item({1,1,1})end,
 function()a:item({1,4})end,
 function()a:item({},1)end,
 function()lr.zeros({0}):item()end,
 function()lr.zeros({0}):item(1)end,
 function()a:fill()end,
 function()a:fill(1,2)end,
 function()a:fill({1})end,
 function()a:fill(lr.array({1}))end,
 function()flags:fill(lr.array({false,true}))end,
})do reject(call)end
print('elements regression: '..checks..' checks passed')
