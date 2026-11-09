local lr = require('luaray')
local checks = 0
local function check(value) checks=checks+1; assert(value) end
local function reject(call) check(not pcall(call)) end
local a=lr.tri(3)
check(a.dtype=='float64' and a:get(1,1)==1 and a:get(1,2)==0 and a:get(3,2)==1)
local lower=lr.tri(2,{m=3,k=-1,dtype='int8'})
check(lower.dtype=='int8' and lower:get(2,1)==1 and lower:get(1,1)==0)
check(lr.tri(-2,3).shape[1]==0 and lr.tri(2,-3).shape[2]==0)
local words=lr.tri(2,{m=3,dtype='U'})
check(words.dtype=='<U5' and words:get(1,1)=='True' and words:get(1,2)=='False')
check(lr.tri(2,nil,0,'S4'):get(1,2)=='Fals')
local input=lr.array({1,2,3},'int32')
local lo,hi=lr.tril(input),lr.triu(input)
check(lo.shape[1]==3 and lo.shape[2]==3 and lo:get(2,1)==1 and lo:get(1,2)==0)
check(hi:get(1,3)==3 and hi:get(3,1)==0)
check(not lr.shares_memory(lo,input) and not lr.shares_memory(hi,input))
lo:set(99,2,1);check(input[1]==1)
local batch=lr.asfortranarray(lr.arange(24):reshape({2,3,4}))
local masked=lr.tril(batch)
check(masked.strides[1]==8 and masked.strides[2]==64 and masked.strides[3]==16)
check(masked:get(2,3,1)==20 and masked:get(2,1,2)==0)
local text=lr.array({{'a','b'},{'c','d'}},'U1')
check(lr.tril(text):get(1,2)=='' and lr.triu(text):get(2,1)=='')
local swapped=lr.array({{'a','b'},{'c','d'}},'>U4')
check(lr.tril(swapped).dtype=='<U4' and lr.triu(swapped):get(1,2)=='b')
local ticks=lr.array({{1,2},{3,4}},'timedelta64[h]')
check(lr.astype(lr.triu(ticks),'int64'):get(2,1)==0)
local empty=lr.tril({})
check(empty.shape[1]==0 and empty.shape[2]==0)
check(lr.tri(2,3,math.maxinteger):get(1,3)==1)
check(lr.triu(input,math.maxinteger):get(1,1)==0)
local wrapped=lr.tri(2,3,math.mininteger+2)
check(wrapped:get(1,1)==0 and wrapped:get(1,3)==1)
check(lr.tri(2,0,math.mininteger).size==0)
for _,call in ipairs({
 function() lr.tri() end,
 function() lr.tri(1.5) end,
 function() lr.tri(true) end,
 function() lr.tri(2,{m=true}) end,
 function() lr.tri(2,{k=1.5}) end,
 function() lr.tri(2,{unknown=1}) end,
 function() lr.tri(2,{['dtype\0']='float64'}) end,
 function() lr.tri(2,{},1) end,
 function() lr.tri(2,3,0,'object') end,
 function() lr.tri(2,3,0,'float64',5) end,
 function() lr.tril(1) end,
 function() lr.triu(false) end,
 function() lr.tril(input,1.5) end,
 function() lr.tril(input,{unknown=1}) end,
 function() lr.triu(input,0,1) end,
 function() lr.tri(2,3,math.mininteger) end,
 function() lr.triu(input,math.mininteger+1) end,
}) do reject(call) end
print('triangle regression: '..checks..' checks passed')
