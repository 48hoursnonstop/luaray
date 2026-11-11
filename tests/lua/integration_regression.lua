local lr=require('luaray')
local checks=0
local function check(value)checks=checks+1;assert(value)end
local function reject(call)check(not pcall(call))end
local function close(value,expected)check(math.abs(value-expected)<1e-12)end
local values=lr.array({1,2,3},'float64')
local area=lr.trapezoid(values)
check(area.ndim==0 and area.dtype=='float64');close(area:tolist(),4)
close(lr.trapezoid(values,{dx=2}):tolist(),8)
close(lr.trapezoid(values,{x={8,6,4}}):tolist(),-8)
close(lr.trapezoid({0,1,9},{x={0,1,3},dx='ignored'}):tolist(),10.5)
local grid=lr.arange(6):reshape({2,3})
local rows=lr.trapezoid(grid);check(rows.shape[1]==2 and rows[1]==2 and rows[2]==8)
local columns=lr.trapezoid(grid,{axis=1});check(columns.shape[1]==3 and columns[1]==1.5 and columns[3]==3.5)
local fortran=lr.asfortranarray(grid)
check(lr.trapezoid(fortran)[2]==8)
local reversed=grid:get(lr.s(),lr.s(nil,nil,-1));check(lr.trapezoid(reversed)[2]==8)
local empty=lr.trapezoid(lr.zeros({1,0}),{axis=1});check(empty.size==0 and empty.strides[1]==0)
check(lr.trapezoid(lr.array({},'float32')).dtype=='float32')
check(lr.trapezoid({7}):tolist()==0)
check(lr.trapezoid(lr.array({127,127},'int8')):tolist()==-1)
local readonly=lr.broadcast_to(lr.array(7),{3})
check(lr.trapezoid(readonly):tolist()==14)
area:set(99);check(values[1]==1 and not lr.shares_memory(area,values))
local complex=lr.trapezoid(lr.array({lr.complex(1,2),lr.complex(3,4)},'complex64'))
check(complex.dtype=='complex64' and complex:tolist().real==2 and complex:tolist().imag==3)
local duration=lr.trapezoid(lr.array({1,2,3},'timedelta64[h]'))
check(duration.dtype=='timedelta64[h]' and lr.astype(duration,'int64'):tolist()==3)
local missing=lr.trapezoid(lr.array({1,math.mininteger,3},'timedelta64[h]'))
check(lr.astype(missing,'int64'):tolist()==math.mininteger)
local dates=lr.array({0,2,6},'datetime64[h]')
check(lr.astype(lr.trapezoid({1,2,3},{x=dates}),'int64'):tolist()==13)
local broadcast=lr.trapezoid({1,2,3},{x=lr.array({{0,1,3},{0,2,6}})})
check(broadcast.shape[1]==2 and broadcast[1]==6.5 and broadcast[2]==13)
for _,call in ipairs({
 function()lr.trapezoid(3)end,
 function()lr.trapezoid(values,{axis=0})end,
 function()lr.trapezoid(values,{axis=2})end,
 function()lr.trapezoid(values,{axis=1.0})end,
 function()lr.trapezoid(values,{axis=true})end,
 function()lr.trapezoid(values,{unknown=1})end,
 function()lr.trapezoid(values,false)end,
 function()lr.trapezoid(values,{},1)end,
 function()lr.trapezoid(values,{x=3})end,
 function()lr.trapezoid(values,{x={0,1,2,3}})end,
 function()lr.trapezoid(lr.array({1,2},'datetime64[h]'))end,
})do reject(call)end
print('integration regression: '..checks..' checks passed')
