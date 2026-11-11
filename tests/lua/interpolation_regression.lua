local lr=require('luaray')
local checks=0
local function check(v)checks=checks+1;assert(v)end
local function reject(f)check(not pcall(f))end
local function close(a,b)check(math.abs(a-b)<1e-12)end
local points=lr.array({0,1,2},'float64')
local values=lr.array({0,2,3},'float64')
local result=lr.interp({-.5,.5,1.5,3},points,values)
check(result.dtype=='float64' and result[1]==0 and result[2]==1 and result[3]==2.5 and result[4]==3)
local filled=lr.interp({-1,3},points,values,{left=-7,right=9})
check(filled[1]==-7 and filled[2]==9)
check(lr.interp(.5,points,values).ndim==0)
close(lr.interp(.5,points,values):tolist(),1)
local grid=lr.interp(lr.array({{0,.5},{1.5,2}}),points,values)
check(grid.shape[1]==2 and grid.shape[2]==2 and grid:get(2,1)==2.5)
check(not lr.shares_memory(result,points) and not lr.shares_memory(result,values))
result[1]=7;check(points[1]==0 and values[1]==0)
local empty=lr.interp(lr.array({}),{}, {},{left='ignored',right=false})
check(empty.size==0 and empty.dtype=='float64')
local singleton=lr.interp({-1,2,0/0},{1},{5},{left=-7,right=9})
check(singleton[1]==-7 and singleton[2]==9 and singleton[3]==5)
local missing=lr.interp({0/0},{0,1},{0,1});check(missing[1]~=missing[1])
local repeated=lr.interp({0,1},{0,0,1},{1,2,3});check(repeated[1]==2 and repeated[2]==3)
local infinite=lr.interp({.5},{0,1},{math.huge,math.huge});check(infinite[1]==math.huge)
local zero=lr.interp({0},{0,1},{-0.,1});check(zero[1]==0 and 1/zero[1]==-math.huge)
local periodic=lr.interp({-10,0,90,360,450},{0,180},{0,1},{period=360,left='ignored',right='ignored'})
close(periodic[1],1/18);check(periodic[2]==0 and periodic[3]==.5 and periodic[4]==0 and periodic[5]==.5)
check(lr.interp({90},{0,180},{0,1},{period=-360})[1]==.5)
local complex=lr.interp({.5},{0,1},lr.array({lr.complex(0,1),lr.complex(2,3)},'complex64'))
check(complex.dtype=='complex128' and complex[1].real==1 and complex[1].imag==2)
local complex_nan=lr.interp({0/0},{0,1},lr.array({lr.complex(0,1),lr.complex(2,3)},'complex128'))
check(complex_nan[1].real~=complex_nan[1].real and complex_nan[1].imag==0)
local readonly=lr.broadcast_to(lr.array(.5),{3});check(lr.interp(readonly,points,values)[3]==1)
local reversed=lr.interp(lr.array({0,.5,1}):get(lr.s(nil,nil,-1)),points,values)
check(reversed[1]==2 and reversed[3]==0)
local time=lr.array({0,1},'timedelta64[h]')
check(lr.interp({.5},time,{0,2},{period=4})[1]==1)
check(lr.interp({.5},{0,1},{0,1},{period=math.mininteger})[1]==.5)
check(lr.interp({.5},{0,1},{0,1},{period=lr.array(true,'bool')})[1]==.5)
for _,call in ipairs({
 function()lr.interp({0},{},{})end,
 function()lr.interp({0},{0},{0,1})end,
 function()lr.interp({0},0,1)end,
 function()lr.interp({0},{{0,1}},{{0,1}})end,
 function()lr.interp({0},{0,1},{0,1},{period=0})end,
 function()lr.interp({0},{0,1},{0,1},{period={4}})end,
 function()lr.interp({0},{0,1},{0,1},{unknown=1})end,
 function()lr.interp({0},{0,1},{0,1},false)end,
 function()lr.interp({0},{0,1},{0,1},{},1)end,
 function()lr.interp({0},{0,1},{0,1},{left=lr.array({1})})end,
 function()lr.interp({0},{0,1},{0,1},{left=lr.complex(1,1)})end,
 function()lr.interp(lr.array(.5,'longdouble'),{0,1},{0,1})end,
 function()lr.interp(lr.array({.5},'longdouble'),{0,1},{0,1})end,
 function()lr.interp({.5},time,{0,2})end,
})do reject(call)end
print('interpolation regression: '..checks..' checks passed')
