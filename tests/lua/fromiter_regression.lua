local lr=require('luaray')
local checks=0
local function eq(a,b)checks=checks+1;assert(a==b,tostring(a)..' ~= '..tostring(b))end
local function fails(fn)checks=checks+1;assert(not pcall(fn))end
local function sequence(values)
 local i=0;return function()i=i+1;return values[i]end
end
local a=lr.fromiter(sequence({1,2,3}),'float64')
eq(a.size,3);eq(a[3],3);eq(a.dtype,'float64');eq(a.flags.owndata,true)
eq(a.flags.writeable,true);eq(a.flags.c_contiguous,true);eq(a.flags.f_contiguous,true)
local nextvalue=sequence({7,8,9});a=lr.fromiter(nextvalue,'int16',2)
eq(a[1],7);eq(a[2],8);eq(nextvalue(),9)
a=lr.fromiter(sequence({false,true,false}),'bool');eq(a.size,3);eq(a[1],false);eq(a[2],true)
a=lr.fromiter(sequence({{},{0}}),'bool');eq(a[1],false);eq(a[2],true)
local calls=0
local function poison()calls=calls+1;error('unexpected consumption')end
for _,count in ipairs({0,-2,math.mininteger})do
 eq(lr.fromiter(poison,'int64',count).size,0)
end
eq(calls,0)
fails(function()lr.fromiter(poison,'S0',0)end);eq(calls,0)
fails(function()lr.fromiter(poison,'U0',0)end);eq(calls,0)
fails(function()lr.fromiter(poison,'int64',math.maxinteger)end);eq(calls,0)
fails(function()lr.fromiter(1,'int64',0)end)
fails(function()lr.fromiter(function()end)end)
fails(function()lr.fromiter(poison,'int64',{extra=1})end)
fails(function()lr.fromiter(poison,'int64',true)end)
fails(function()lr.fromiter(poison,'int64',1.0)end)
fails(function()lr.fromiter(poison,'int64',0,1)end)
fails(function()lr.fromiter(sequence({1}),'int64',2)end)
fails(function()lr.fromiter(sequence({256}),'uint8')end)
fails(function()lr.fromiter(sequence({math.huge}),'int64')end)
fails(function()lr.fromiter(sequence({{1}}),'int64')end)
fails(function()lr.fromiter(sequence({lr.ones({1})}),'float64')end)
local typed=lr.fromiter(sequence({lr.array(256,'int64')}),'int8');eq(typed[1],0)
local wide=lr.ndarray({},{dtype='uint64',buffer=string.rep('\255',8)})
a=lr.fromiter(sequence({wide,wide}),'uint64');eq(a:tobytes(),string.rep('\255',16))
local unaligned=lr.ndarray({},{dtype='int64',buffer='x'..string.pack('i8',912),offset=1})
unaligned:setflags(false);a=lr.fromiter(sequence({unaligned}),'int64');eq(a[1],912);eq(unaligned.flags.writeable,false)
a=lr.fromiter(sequence({'hello','世界'}),'U2');eq(a[1],'he');eq(a[2],'世界')
a=lr.fromiter(sequence({'12','13'}),'int16');eq(a[2],13)
a=lr.fromiter(sequence({'2024-01-02','NaT'}),'datetime64[D]');eq(a.size,2)
a=lr.fromiter(sequence({lr.complex(1,2)}),'complex128');eq(a[1].real,1);eq(a[1].imag,2)
local callable=setmetatable({position=0},{__call=function(self)self.position=self.position+1;if self.position<=3 then return self.position end end})
a=lr.fromiter(callable,lr.dtype('int32'),{count=3});eq(a[3],3);eq(callable.position,3)
a=lr.fromiter(sequence({1,2}),nil);eq(a.dtype,'float64')
local marker={}
local i=0
local ok,err=pcall(lr.fromiter,function()i=i+1;if i==300 then error(marker)end;collectgarbage('collect');return i end,'int64')
eq(ok,false);eq(rawequal(err,marker),true);eq(i,300)
i=0
a=lr.fromiter(function()i=i+1;if i<=10000 then if i%17==0 then collectgarbage('collect')end;return i end end,'int64')
eq(a.size,10000);eq(a[10000],10000);eq(i,10001)
local co=coroutine.wrap(function()for n=1,3 do coroutine.yield(n*2)end end)
a=lr.fromiter(co,'int64');eq(a[3],6)
local extra=0
a=lr.fromiter(function()extra=extra+1;return extra,'ignored' end,'int8',1);eq(a[1],1);eq(extra,1)
collectgarbage('collect')
print('fromiter regression: '..checks..' checks passed')
