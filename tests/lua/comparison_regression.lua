local lr=require('luaray')
local checks=0
local function check(value)checks=checks+1;assert(value)end
local function reject(call)check(not pcall(call))end
check(lr.array_equal({1,2},{1.,2.}))
check(not lr.array_equal({1,2},{{1,2}}))
check(lr.array_equiv({{1,2},{1,2}},{1,2}))
check(not lr.array_equiv({1,2},{1,2,3}))
check(not lr.array_equal({{1},{2,3}},{1,2}))
check(not lr.array_equiv({{1},{2,3}},{1,2}))
check(not lr.array_equal(lr.array({1,2}),lr.array({'1','2'},'U1')))
check(not lr.array_equal(lr.array({'a'},'S1'),lr.array({'a'},'U1')))
local nan=lr.array({0/0},'float64')
check(not lr.array_equal(nan,nan))
check(lr.array_equal(nan,nan,{equal_nan=true}))
check(lr.array_equal(nan,lr.array({0/0}),{equal_nan=true}))
local real_nan=lr.array({lr.complex(0/0,1)},'complex128')
local imag_nan=lr.array({lr.complex(1,0/0)},'complex128')
check(lr.array_equal(real_nan,imag_nan,{equal_nan=true}))
local text=lr.array({'a'},'U1');check(lr.array_equal(text,text,{equal_nan=true}))
reject(function()lr.array_equal(text,lr.array({'a'},'U1'),{equal_nan=true})end)
local empty=lr.zeros({0},'int64');check(lr.array_equal(empty,lr.zeros({0},'float32')))
check(lr.array_equiv(lr.zeros({0,3}),lr.ones({1,3})))
local close=lr.isclose({1.,2.,math.huge,-math.huge,0/0},{1.000001,3.,math.huge,math.huge,0/0},{equal_nan=true})
check(close.dtype=='bool' and close[1] and not close[2] and close[3] and not close[4] and close[5])
check(lr.allclose({1.,2.},{1.000001,2.}))
check(not lr.allclose({1.,2.},{1.0001,2.}))
check(lr.isclose(1.,1.).ndim==0 and lr.isclose(1.,1.):tolist())
check(lr.isclose(0.,-0.):tolist())
check(lr.allclose(lr.zeros({0}),lr.ones({1})))
local bounds=lr.isclose({1.,1.01},{1.,1.},{rtol=0,atol={0.,.02}})
check(bounds[1] and bounds[2])
local original=lr.asfortranarray(lr.array({{1.,2.},{3.,4.}},'float32'))
local out=lr.isclose(original,original);check(out.strides[1]==1 and out.strides[2]==2)
out:set(false);check(original:get(1,1)==1 and not lr.shares_memory(out,original))
local readonly=lr.broadcast_to(lr.array(1.,'float32'),{3})
check(lr.allclose(readonly,1.) and lr.array_equiv(readonly,1.))
local ld=lr.array(1.,'longdouble')
check(not lr.isclose(lr.add(ld,2^-63),ld,{rtol=0,atol=2^-64}):tolist())
check(lr.isclose(lr.add(ld,2^-63),ld,{rtol=0,atol=2^-63}):tolist())
local ticks=lr.array({0,1,math.mininteger},'timedelta64[h]')
check(lr.array_equal(ticks,ticks,{equal_nan=true}))
check(not lr.array_equal(ticks,ticks))
local comparison=lr.isclose(ticks,ticks,{rtol=0,atol=0,equal_nan=true})
check(comparison[1] and comparison[2] and comparison[3])
local nat=lr.isnan(ticks);check(not nat[1] and nat[3] and not lr.any(lr.isinf(ticks)))
local equal=lr.equal(ticks,lr.array({0,1,2},'int8'));check(equal[1] and equal[2] and not equal[3])
local shifted=lr.add(ticks,1);check(lr.astype(shifted,'int64')[2]==2 and lr.isnat(shifted)[3])
local prefix=lr.array({0,1,math.maxinteger,math.mininteger},'datetime64[D]')
local destination=lr.full({4},7,'datetime64[D]')
reject(function()lr.add(prefix,1,{out=destination})end)
local state=lr.astype(destination,'int64');check(state[1]==1 and state[2]==2 and state[3]==7 and state[4]==7)
for _,call in ipairs({
 function()lr.array_equal({1},{1},false)end,
 function()lr.array_equal({1},{1},{unknown=1})end,
 function()lr.array_equal({1},{1},{equal_nan=1})end,
 function()lr.array_equal({1},{1},{},1)end,
 function()lr.array_equiv({1},{1},{})end,
 function()lr.isclose({1},{1},false)end,
 function()lr.isclose({1},{1},{unknown=1})end,
 function()lr.isclose({1},{1},{equal_nan=1})end,
 function()lr.isclose({1},{1},{},1)end,
 function()lr.isclose({1,2},{1,2,3})end,
 function()lr.isclose({{1},{2,3}},{1})end,
 function()lr.array_equal(lr.array({1},'timedelta64[Y]'),lr.array({1},'timedelta64[D]'))end,
})do reject(call)end
print('comparison regression: '..checks..' checks passed')
