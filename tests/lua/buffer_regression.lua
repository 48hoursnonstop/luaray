local lr=require('luaray')
local checks=0
local function check(value)checks=checks+1;assert(value)end
local function reject(call)check(not pcall(call))end
local bytes=string.pack('i4i4',123,-456)
local a=lr.frombuffer(bytes,'int32')
check(a.dtype=='int32' and a.ndim==1 and a.shape[1]==2 and a.strides[1]==4)
check(a[1]==123 and a[2]==-456)
check(lr.frombuffer(string.pack('dd',1.25,-2.5))[2]==-2.5)
check(lr.frombuffer(bytes,'int32',1,4)[1]==-456)
check(lr.frombuffer(bytes,'int32',-3).shape[1]==2)
local empty=lr.frombuffer(bytes,'int32',0,8);check(empty.shape[1]==0 and empty.strides[1]==4)
reject(function()a[1]=7 end);reject(function()a:fill(7)end)
reject(function()empty:fill(7)end)
reject(function()lr.copyto(a,lr.zeros({2},'int32'))end)
reject(function()lr.add(a,a,{out=a})end)
reject(function()lr.flip(a)[1]=7 end)
local copy=lr.copy(a);copy[1]=9;check(a[1]==123 and not lr.shares_memory(a,copy))
local b=lr.frombuffer(bytes,'uint8',4,2)
check(lr.shares_memory(a,b) and lr.may_share_memory(a,b))
check(not lr.shares_memory(lr.frombuffer(bytes,'uint8',2),lr.frombuffer(bytes,'uint8',2,4)))
check(not lr.shares_memory(empty,a))
local storage=lr.array({1,2,3},'int32');b=lr.frombuffer(storage,'int32',2,4)
b[1]=77;check(storage[2]==77 and lr.shares_memory(storage,b))
storage=nil;collectgarbage('collect');check(b[2]==3);b:fill(9);check(b[1]==9)
local readonly=lr.frombuffer(a,'uint8');reject(function()readonly[1]=9 end)
local unaligned=lr.frombuffer('x'..bytes,'int32',2,1);check(unaligned[1]==123 and unaligned[2]==-456)
check(lr.sum(unaligned)==-333)
local co=coroutine.create(function()return lr.frombuffer(string.rep('q',20000),'uint8')end)
local weak=setmetatable({co},{__mode='v'})
local ok,escaped=coroutine.resume(co);check(ok);co=nil;collectgarbage('collect')
check(weak[1]==nil and escaped[20000]==string.byte('q'))
local tail=escaped:get(lr.s(19999));escaped=nil;collectgarbage('collect');check(tail[2]==113)
-- Registry references release exactly when the final native view disappears.
local pinned=string.rep('unique buffer lifetime:',4000)
local function references()local n=0;for _,v in pairs(debug.getregistry())do if v==pinned then n=n+1 end end;return n end
local before=references();local root=lr.frombuffer(pinned,'uint8');check(references()==before+1)
local view=root:get(lr.s(2,5));root=nil;collectgarbage('collect');check(references()==before+1)
view=nil;collectgarbage('collect');check(references()==before)
local matrix=lr.arange(6):reshape({2,3})
reject(function()lr.frombuffer(lr.asfortranarray(matrix),'uint8')end)
reject(function()lr.frombuffer(lr.flip(matrix),'uint8')end)
for _,call in ipairs({
 function()lr.frombuffer()end,
 function()lr.frombuffer({1,2},'uint8')end,
 function()lr.frombuffer(123,'uint8')end,
 function()lr.frombuffer(bytes,'S0',0)end,
 function()lr.frombuffer(bytes,'U0',0)end,
 function()lr.frombuffer(bytes,'int32',-1,1)end,
 function()lr.frombuffer(bytes,'int32',3)end,
 function()lr.frombuffer(bytes,'int32',0,-1)end,
 function()lr.frombuffer(bytes,'int32',0,9)end,
 function()lr.frombuffer(bytes,'int32',math.maxinteger)end,
 function()lr.frombuffer(bytes,'int32',1.0)end,
 function()lr.frombuffer(bytes,'int32',1,0.0)end,
 function()lr.frombuffer(bytes,'int32',true)end,
 function()lr.frombuffer(bytes,'int32\0garbage')end,
 function()lr.frombuffer(bytes,'int32',1,0,1)end,
})do reject(call)end
local wide=lr.zeros({2},'complex256');wide:set(7)
check(wide[1].real==7 and wide[2].imag==0)
wide:set(3.5);check(wide[1].real==3.5 and wide[2].real==3.5)
local rankzero=lr.zeros({},'complex256');rankzero:set(-9)
check(rankzero:tolist().real==-9 and rankzero:tolist().imag==0)
print('buffer regression: '..checks..' checks passed')
