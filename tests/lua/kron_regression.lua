local lr=require('luaray')
local checks=0
local function check(value)checks=checks+1;assert(value)end
local function reject(call)check(not pcall(call))end
local a=lr.array({{1,2},{3,4}},'int32')
local product=lr.kron(a,lr.eye(2))
check(product.dtype=='float64' and product.shape[1]==4 and product.shape[2]==4)
check(product:get(1,1)==1 and product:get(3,3)==4 and product:get(1,2)==0)
check(not lr.shares_memory(product,a));product:set(99,1,1);check(a:get(1,1)==1)
local promoted=lr.kron(lr.array({1,2},'int8'),2)
check(promoted.dtype=='int64' and promoted[2]==4)
local bool=lr.kron(lr.array({true,false},'bool'),lr.array({false,true},'bool'))
check(bool.dtype=='bool' and not bool[1] and bool[2] and not bool[4])
local reversed=lr.kron(lr.flip(a,1),lr.array({1,-1},'int8'))
check(reversed:get(1,1)==3 and reversed:get(1,2)==-3 and reversed:get(2,3)==2)
local shaped=lr.kron(lr.ones({2,1,2},'int16'),lr.ones({2,3},'int16'))
check(shaped.shape[1]==2 and shaped.shape[2]==2 and shaped.shape[3]==6)
local empty=lr.kron(lr.zeros({0,3}),a)
check(empty.shape[1]==0 and empty.shape[2]==6)
local scalar=lr.kron(2,3);check(scalar.ndim==0 and scalar:tolist()==6)
local duration=lr.array({1,2},'timedelta64[h]')
local scaled=lr.multiply(duration,3)
check(scaled.dtype=='timedelta64[h]' and lr.astype(scaled,'int64')[2]==6)
check(lr.astype(lr.kron(duration,lr.array({2,3},'uint64')),'int64')[4]==6)
local nat=lr.array({math.mininteger},'timedelta64[h]')
check(lr.astype(lr.multiply(nat,0),'int64')[1]==math.mininteger)
local dangerous=lr.array({1,2,4611686018427387904},'timedelta64[h]')
local out=lr.full({3},7,'timedelta64[h]')
reject(function()lr.multiply(dangerous,2,{out=out})end)
check(lr.astype(out,'int64')[1]==2 and lr.astype(out,'int64')[2]==4 and lr.astype(out,'int64')[3]==7)
local converted=lr.full({3},7,'timedelta64[ms]')
reject(function()lr.multiply(dangerous,2,{out=converted})end)
check(lr.astype(converted,'int64')[1]==7200000 and lr.astype(converted,'int64')[3]==7)
local base=lr.array({1,2,4611686018427387904,3},'timedelta64[h]')
local backward=lr.flip(base,1)
reject(function()lr.multiply(backward,2,{out=backward})end)
check(lr.astype(base,'int64')[1]==2 and lr.astype(base,'int64')[2]==4 and lr.astype(base,'int64')[4]==3)
local masked=lr.array({4611686018427387904,3,2,1},'timedelta64[h]')
reject(function()lr.multiply(masked,2,{out=masked,where=lr.array({true,false,true,false},'bool')})end)
check(lr.astype(masked,'int64')[1]==4611686018427387904 and lr.astype(masked,'int64')[3]==4)
local limit=lr.array({math.mininteger+1},'timedelta64[ms]')
reject(function()lr.astype(limit,'timedelta64[h]')end)
local shape={};for i=1,33 do shape[i]=1 end
local rank33=lr.ones(shape,'int8')
check(lr.kron(rank33,lr.array(2,'int8')).ndim==33)
reject(function()lr.kron(lr.array(2,'int8'),rank33)end)
for _,call in ipairs({
 function()lr.kron()end,
 function()lr.kron(a)end,
 function()lr.kron(a,a,1)end,
 function()lr.kron({{1},{2,3}},a)end,
 function()lr.kron(lr.array({'x'},'U4'),a)end,
 function()lr.kron(lr.array({1},'datetime64[ms]'),a)end,
})do reject(call)end
print('kron and integer duration regression: '..checks..' checks passed')
