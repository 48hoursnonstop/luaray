local lr = require('luaray')
local checks = 0
local function check(value) checks=checks+1; assert(value) end
local function reject(call) check(not pcall(call)) end
local a=lr.array({{1,2,3},{4,5,6}},'int8')
check(lr.trace(a)==6 and a:trace()==6)
check(lr.trace(a,1)==8 and lr.trace(a,-1)==4)
check(lr.trace({{1,2},{3,4}},{dtype='float32'})==5)
local volume=lr.arange(24):reshape({2,3,4})
local out=lr.zeros(4,'float32')
check(lr.trace(volume,{out=out})==out)
check(out[1]==16 and out[4]==22)
check(lr.trace(volume,{axis1=2,axis2=3})[2]==51)
local scalar=lr.array(0,'uint8')
check(lr.trace(a,0,1,2,nil,scalar)==scalar and scalar:tolist()==6)
local overlap=volume:get(1,1)
check(lr.trace(volume,{out=overlap})==overlap)
check(volume:get(1,1,1)==16 and volume:get(1,1,4)==22)
local noncontiguous=lr.flip(lr.zeros(4),1)
check(lr.trace(volume,{out=noncontiguous})==noncontiguous)
check(noncontiguous[1]==32 and noncontiguous[4]==41)
check(lr.trace(a,2147483647)==0)
check(lr.trace(a,-2147483648)==0)
local high=lr.astype(lr.array({math.mininteger+1,1},'int64'),'uint64')
local high_matrix=lr.diag(high)
local exact=lr.array(0,'uint64')
check(lr.trace(high_matrix,{out=exact})==exact)
check(lr.astype(exact,'U40'):tolist()=='9223372036854775810')
local readonly=lr.broadcast_to(lr.array(7),{4})
local before=volume:tobytes()
for _,call in ipairs({
 function() lr.trace() end,
 function() lr.trace(1) end,
 function() lr.trace({1,2}) end,
 function() lr.trace(a,{out=7}) end,
 function() lr.trace(volume,{out=readonly}) end,
 function() lr.trace(volume,{out=lr.zeros(3)}) end,
 function() lr.trace(a,{axis1=1,axis2=1}) end,
 function() lr.trace(a,{axis1=0}) end,
 function() lr.trace(a,{offset=1.5}) end,
 function() lr.trace(a,{dtype=true}) end,
 function() lr.trace(a,{dtype='float64\0x'}) end,
 function() lr.trace(a,{unknown=1}) end,
 function() lr.trace(a,{['out\0']=out}) end,
 function() lr.trace(a,{},1) end,
 function() lr.trace(a,0,1,2,nil,nil,7) end,
}) do reject(call) end
check(volume:tobytes()==before and readonly[1]==7)
local ticks=lr.array({{1,2},{3,4}},'timedelta64[h]')
local temporal=lr.array(lr.trace(ticks,{dtype='float64'}))
check(temporal.dtype=='timedelta64[h]' and lr.astype(temporal,'int64'):tolist()==5)
local timestamp=lr.array(7,'datetime64[ms]')
check(lr.trace(ticks,{out=timestamp})==timestamp)
check(lr.astype(timestamp,'int64'):tolist()==18000000)
check(lr.trace(a,{out=timestamp})==timestamp and lr.astype(timestamp,'int64'):tolist()==6)
local narrow=lr.array({{120,0},{0,120}},'int8')
check(lr.trace(narrow,{dtype='timedelta64[s]'})==-16)
reject(function()lr.trace(lr.array({{'1','2'},{'3','4'}},'U4'),{dtype='int64'})end)
reject(function()lr.trace(ticks,{out=lr.array(0,'float64')})end)
reject(function()lr.trace(a,{dtype='datetime64[ms]'})end)
print('trace regression: '..checks..' checks passed')
