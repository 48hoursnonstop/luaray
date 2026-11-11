local lr=require('luaray')
local checks=0
local function check(v)checks=checks+1;assert(v)end
local function reject(f)check(not pcall(f))end
local source=lr.array({0,1,2,-1,0},'int64')
local result=lr.unwrap(source,{period=4})
check(result.dtype=='int64' and result[4]==3 and result[5]==4)
check(not lr.shares_memory(result,source));result[1]=9;check(source[1]==0)
local radians=lr.unwrap({0,math.pi/2,-math.pi,-math.pi/2,0})
check(math.abs(radians[3]-math.pi)<1e-12 and math.abs(radians[5]-2*math.pi)<1e-12)
local tie=lr.unwrap({0,2,0},{period=4});check(tie[2]==2 and tie[3]==0)
local odd=lr.unwrap({0,2,-2},{period=5});check(odd[2]==2 and odd[3]==3)
local threshold=lr.unwrap(source,{period=4,discont=4});check(threshold[4]==-1)
local lower=lr.unwrap(source,{period=4,discont=0});check(lower[5]==4)
local typed=lr.unwrap(lr.array({0,1,2,-1,0},'float32'),{period=lr.array(4,'float32')})
check(typed.dtype=='float32' and typed[5]==4)
local row=lr.array({{0,1,2,-1},{0,1,2,-1}},'int64')
check(lr.unwrap(row,{period=4}):get(2,4)==3)
local column=lr.unwrap(lr.transpose(row),{axis=1,period=4})
check(column:get(4,2)==3)
local f=lr.unwrap(lr.asfortranarray(row),{period=4})
check(f.strides[1]==8 and f.strides[2]==16 and f:get(2,4)==3)
local reverse=lr.unwrap(source:get(lr.s(nil,nil,-1)),{period=4})
check(reverse[1]==0 and reverse[5]==-4)
local readonly=lr.broadcast_to(lr.array(7,'float32'),{3})
local writable=lr.unwrap(readonly);writable[1]=5;check(readonly[1]==7 and writable[2]==7)
check(lr.unwrap(lr.array({},'int64')).size==0)
check(lr.unwrap({1},{period=4})[1]==1)
local zero=lr.unwrap({0,1,3},{period=0});check(zero[2]==0 and zero[3]==0)
local variable=lr.unwrap({0,1,2,-1,0},{period=lr.array({4,4,4,4},'float32')})
check(variable[5]==4)
local nan=lr.unwrap({0,0/0,1});check(nan[1]==0 and nan[2]~=nan[2] and nan[3]~=nan[3])
for _,call in ipairs({
 function()lr.unwrap(3)end,
 function()lr.unwrap(source,{axis=0})end,
 function()lr.unwrap(source,{axis=2})end,
 function()lr.unwrap(source,{axis=1.0})end,
 function()lr.unwrap(source,{unknown=1})end,
 function()lr.unwrap(source,false)end,
 function()lr.unwrap(source,{},1)end,
 function()lr.unwrap(lr.array({lr.complex(1,2),lr.complex(2,3)},'complex128'))end,
 function()lr.unwrap(source,{period=lr.array({4,4,4,4},'int64')})end,
})do reject(call)end
print('phase regression: '..checks..' checks passed')
