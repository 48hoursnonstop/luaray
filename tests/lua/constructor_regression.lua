local lr=require('luaray')
local checks=0
local function check(value)checks=checks+1;assert(value)end
local function reject(call)check(not pcall(call))end
local a=lr.ndarray({2,3},'int32',{order='F'});a:fill(7)
check(a.shape[1]==2 and a.shape[2]==3 and a.strides[1]==4 and a.strides[2]==8)
check(a.flags.owndata and a.flags.f_contiguous and not a.flags.c_contiguous and lr.sum(a)==42)
check(lr.ndarray({}).dtype=='float64')
check(lr.ndarray(2,lr.dtype('float32')).dtype=='float32')
local source=lr.arange(6,'int32')
local reversed=lr.ndarray(3,{dtype='int32',buffer=source,offset=8,strides=-4})
check(reversed[1]==2 and reversed[3]==0 and not reversed.flags.owndata)
reversed[2]=77;check(source[2]==77 and lr.shares_memory(source,reversed))
source=nil;collectgarbage('collect');check(reversed[2]==77)
local broadcast=lr.ndarray(3,{dtype='int32',buffer=reversed:get(lr.s(2,3)),strides=0})
broadcast:fill(19);check(reversed[2]==19 and broadcast[3]==19)
local storage=lr.asfortranarray(lr.array({{0,1,2},{3,4,5}},'int32'))
a=lr.ndarray(6,'int32',{buffer=storage})
check(a[1]==0 and a[2]==3 and a[3]==1 and a[6]==5)
a[2]=88;check(storage:get(2,1)==88)
reject(function()lr.frombuffer(storage,'int32')end)
storage:setflags(false);a=lr.ndarray(6,{dtype='int32',buffer=storage})
check(not a.flags.writeable);reject(function()a:fill(1)end)
local bytes=string.pack('i4i4',123,-456)
a=lr.ndarray({2},'int32',{buffer=bytes})
check(a[1]==123 and a[2]==-456 and not a.flags.writeable)
reject(function()a[1]=9 end);reject(function()a:setflags(true)end)
local unaligned=lr.ndarray(2,{dtype='int32',buffer='x'..bytes,offset=1})
check(not unaligned.flags.aligned and unaligned[2]==-456)
check(lr.sum(unaligned)==-333)
a=lr.ndarray(-1,'int32',{buffer=bytes..'xx'})
check(a.size==2 and a[2]==-456)
check(lr.ndarray(0,{dtype='int32',buffer=bytes,offset=8,strides=math.maxinteger}).size==0)
check(lr.ndarray(1,{dtype='int32',buffer=bytes,strides=math.mininteger})[1]==123)
for _,kind in ipairs({'S0','U0'})do
 a=lr.ndarray({2,3},{dtype=kind})
 check(a.itemsize==0 and a.nbytes==0 and a:tolist()[2][3]=='' and a.flags.owndata)
 check(a.flags.c_contiguous and not a.flags.f_contiguous)
 a=lr.ndarray({2,3},{dtype=kind,strides={0,0}})
 check(a.flags.c_contiguous and a.flags.f_contiguous)
 check(lr.empty({2},kind).itemsize>0)
end
a=lr.ndarray({2,0},{strides={400,-20}})
check(a.strides[1]==0 and a.strides[2]==0)
-- Strings remain pinned after the creating coroutine and intermediate view die.
local co=coroutine.create(function()return lr.ndarray({20000},{dtype='uint8',buffer=string.rep('q',20000)})end)
local weak=setmetatable({co},{__mode='v'});local ok,escaped=coroutine.resume(co)
check(ok);co=nil;collectgarbage('collect');check(weak[1]==nil and escaped[20000]==113)
local tail=escaped:get(lr.s(19999));escaped=nil;collectgarbage('collect');check(tail[2]==113)
local pinned=string.rep('constructor pinned lifetime:',4000)
local function references()local n=0;for _,v in pairs(debug.getregistry())do if v==pinned then n=n+1 end end;return n end
local before=references();a=lr.ndarray(2,{dtype='uint8',buffer=pinned})
check(references()==before+1);local view=a:get(lr.s(1,2));a=nil;collectgarbage('collect');check(references()==before+1)
view=nil;collectgarbage('collect');check(references()==before)
reject(function()lr.ndarray(1000000,{buffer=pinned})end)
collectgarbage('collect');check(references()==before)
for _,call in ipairs({
 function()lr.ndarray()end,
 function()lr.ndarray(-1)end,
 function()lr.ndarray({2,-1})end,
 function()lr.ndarray({1.0})end,
 function()lr.ndarray({x=2})end,
 function()lr.ndarray({1,[3]=2})end,
 function()lr.ndarray({1},{strides={1,x=2}})end,
 function()lr.ndarray(1,{strides={}})end,
 function()lr.ndarray(1,{offset=1.0})end,
 function()lr.ndarray(1,{order='invalid'})end,
 function()lr.ndarray(1,{unknown=true})end,
 function()lr.ndarray(1,'int32',{dtype='int32'})end,
 function()lr.ndarray(1,{buffer={1,2}})end,
 function()lr.ndarray(1,{buffer=bytes,offset=-1})end,
 function()lr.ndarray(0,{buffer=bytes,offset=9})end,
 function()lr.ndarray(1,{buffer='',strides=0})end,
 function()lr.ndarray(-1,{dtype='uint8',buffer=bytes,strides=-1})end,
 function()lr.ndarray(-1,{dtype='uint8',buffer=bytes,strides=2})end,
 function()lr.ndarray(-1,{dtype='U0',buffer=bytes})end,
 function()lr.ndarray(2,{dtype='uint8',buffer=bytes,strides=math.maxinteger})end,
 function()lr.ndarray(2,{dtype='uint8',buffer=bytes,strides=math.mininteger})end,
 function()lr.ndarray({math.maxinteger,2},{dtype='U0',buffer=bytes,strides={0,0}})end,
 function()lr.ndarray({0,math.maxinteger},{buffer=bytes})end,
 function()lr.ndarray({1},{buffer=lr.flip(lr.arange(4))})end,
})do reject(call)end
print('constructor regression: '..checks..' checks passed')
