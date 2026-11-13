local lr=require('luaray')
local checks=0
local function check(value)checks=checks+1;assert(value)end
local function reject(call)check(not pcall(call))end
local function ticks(a,expected)
 local raw=lr.astype(a,'int64');check(raw.ndim==1 and raw.size==#expected)
 for i,v in ipairs(expected)do check(raw[i]==v)end
end
local days=lr.arange('2020-02-28','2020-03-02',{dtype='datetime64[D]'})
ticks(days,{18320,18321,18322})
check(lr.datetime_as_string(days)[2]=='2020-02-29')
check(days.flags.owndata and days.flags.writeable)
local start=lr.datetime64('2020-01-01')
days=lr.arange(start,3);ticks(days,{18262,18263,18264})
check(days.dtype=='datetime64[D]')
local months=lr.arange(lr.datetime64('2020-01'),lr.datetime64('2020-06'),lr.timedelta64(2,'M'))
ticks(months,{600,602,604});check(months.dtype=='datetime64[M]')
local durations=lr.arange(lr.timedelta64(0,'h'),lr.timedelta64(3,'h'),lr.timedelta64(30,'m'))
ticks(durations,{0,30,60,90,120,150});check(durations.dtype=='timedelta64[m]')
ticks(lr.arange(lr.timedelta64(3,'h')),{0,1,2})
ticks(lr.arange(nil,lr.timedelta64(3,'h')),{0,1,2})
ticks(lr.arange(3,{dtype='timedelta64'}),{0,1,2})
ticks(lr.arange(0,3,1,{dtype='datetime64[D]'}),{0,1,2})
-- The established positional-dtype helper still means raw index conversion.
ticks(lr.arange(3,'datetime64[D]'),{0,1,2})
local ns_start=lr.datetime64(0,'ns');local ns_stop=lr.datetime64(5,'ns')
ticks(lr.arange(ns_start,ns_stop,2),{0,2,4})
ticks(lr.arange(ns_start,ns_stop,2,{dtype='int64'}),{0,2})
ticks(lr.arange(ns_start,ns_stop,lr.timedelta64(2,'ns'),{dtype='int64'}),{0,2,4})
local raw_start=lr.array(256,'timedelta64');local raw_stop=lr.array(257,'timedelta64')
local wrapped=lr.arange(raw_start,raw_stop,1,{dtype='uint8'});check(wrapped.size==1 and wrapped[1]==0)
reject(function()lr.arange(lr.timedelta64(256),lr.timedelta64(257),1,{dtype='uint8'})end)
check(lr.astype(raw_start,'int64'):tolist()==256)
local bytes=string.pack('i8',3)
local unaligned=lr.ndarray({},{dtype='timedelta64[h]',buffer='x'..bytes,offset=1})
check(not unaligned.flags.writeable and not unaligned.flags.aligned)
local range=lr.arange(unaligned);ticks(range,{0,1,2})
check(not lr.shares_memory(range,unaligned))
local read_only=lr.array(5,'timedelta64[D]');read_only:setflags(false)
ticks(lr.arange(lr.timedelta64(0,'D'),read_only),{0,1,2,3,4})
check(not read_only.flags.writeable and lr.astype(read_only,'int64'):tolist()==5)
-- Upstream validates NaT after normalizing a relative endpoint.
check(lr.arange(lr.datetime64(100,'D'),lr.timedelta64('NaT','D')).size==0)
reject(function()lr.arange(lr.datetime64(0,'D'),lr.timedelta64('NaT','D'))end)
check(lr.dtype(lr.promote_types('datetime64[4Y]','datetime64[12h]')).name=='datetime64[12h]')
check(lr.dtype(lr.promote_types('datetime64[D]','timedelta64[Y]')).name=='datetime64[D]')
reject(function()lr.add(lr.array(0,'datetime64[D]'),lr.array(1,'timedelta64[Y]'))end)
reject(function()lr.subtract(lr.array(0,'datetime64[D]'),lr.array(1,'timedelta64[Y]'))end)
for _,call in ipairs({
 function()lr.arange(lr.datetime64('2020-01-01'))end,
 function()lr.arange(3,{dtype='datetime64[D]'})end,
 function()lr.arange(0,3,{dtype='datetime64'})end,
 function()lr.arange(lr.timedelta64('NaT'))end,
 function()lr.arange(lr.timedelta64(0,'D'),lr.timedelta64(0,'D'),0)end,
 function()lr.arange(lr.datetime64('2020-01-01'),lr.datetime64('2020-01-05'),lr.datetime64('1970-01-01'))end,
 function()lr.arange(lr.datetime64('2020-01-01'),lr.datetime64('2020-01-05'),1.0)end,
 function()lr.arange(lr.timedelta64(0,'Y'),lr.timedelta64(5,'D'))end,
 function()lr.arange(lr.datetime64('2020-01-01'),lr.datetime64('2020-01-05'),lr.timedelta64(1,'M'))end,
 function()lr.arange(lr.array({0,1},'datetime64[D]'),lr.datetime64('2020-01-05'))end,
 function()lr.arange(lr.array(0),lr.datetime64('2020-01-05'),1,{dtype='datetime64[D]'})end,
 function()lr.arange('2020-01-01\0extra','2020-01-05',{dtype='datetime64[D]'})end,
 function()lr.arange(lr.datetime64(math.maxinteger,'D'),1)end,
 function()lr.arange(lr.timedelta64(math.mininteger+1,'D'),lr.timedelta64(math.maxinteger,'D'),1)end,
})do reject(call)end
local co=coroutine.create(function()return lr.arange(lr.ndarray({},{dtype='timedelta64[h]',buffer=string.pack('i8',4)}))end)
local ok,escaped=coroutine.resume(co);check(ok);co=nil;collectgarbage('collect')
ticks(escaped,{0,1,2,3});check(escaped.flags.owndata)
print('temporal ranges regression: '..checks..' checks passed')
