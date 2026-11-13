local lr=require('luaray')
local checks=0
local function check(value)checks=checks+1;assert(value)end
local function reject(call)check(not pcall(call))end
local a=lr.arange(6):reshape({2,3}):copy()
check(a.itemsize==8 and a.nbytes==48)
check(a.flags.c_contiguous and not a.flags.f_contiguous and a.flags.owndata)
check(a.flags.num==1285 and a.flags==a.flags)
check(a.flags['C'] and a.flags['W'] and not a.flags['X'])
local f=lr.asfortranarray(a);check(lr.isfortran(f) and f.flags.fnc and f.flags.forc)
check(not lr.isfortran(lr.array({1,2})))
local view=a:get(lr.s());local saved=a.flags
check(a:setflags({write=false})==nil and not a.flags.writeable)
check(saved.writeable and view.flags.writeable)
view[1][1]=9;check(a[1][1]==9)
reject(function()a[1][1]=7 end)
view:setflags(false);reject(function()view:setflags(true)end)
a:setflags(true);view:setflags(true);check(view.flags.writeable)
local flags=a.flags;flags.writeable=false
check(flags.writeable and not a.flags.writeable)
flags.writeable=true;flags.aligned=false;check(not a.flags.aligned and flags.aligned)
a:setflags(nil,true);check(a.flags.aligned)
check(type(tostring(a.flags))=='string')
local readonly=lr.frombuffer(string.pack('i4i4',1,2),'int32')
check(not readonly.flags.owndata and not readonly.flags.writeable)
local before=readonly.flags.num;reject(function()readonly:setflags(true,false)end)
check(readonly.flags.num==before)
local unaligned=lr.frombuffer('x'..string.pack('i4i4',1,2),'int32',2,1)
check(not unaligned.flags.aligned);reject(function()unaligned:setflags(nil,true)end)
local empty=lr.frombuffer('x','int32',0,1);check(empty.flags.aligned and empty.nbytes==0)
empty:setflags(nil,false);check(not empty.flags.aligned);empty:setflags(nil,true);check(empty.flags.aligned)
local root=lr.arange(3);local child=lr.frombuffer(root,'int64');root:setflags(false);child:setflags(false)
reject(function()child:setflags(true)end);root:setflags(true);child:setflags(true);check(child.flags.writeable)
root:setflags(false);root=nil;collectgarbage('collect');reject(function()child:setflags(true)end)
local keep=lr.ones({3},'int8').flags;collectgarbage('collect');keep.writeable=false
check(keep.owndata and keep.writeable)
local diagonal=lr.diagonal(a);diagonal:setflags(true);check(diagonal.flags.writeable)
local broadcast=lr.broadcast_to(lr.array(1),{3});broadcast:setflags(true);check(broadcast.flags.writeable)
local imag=lr.imag(lr.arange(3));local imaginary_view=imag:view()
check(imag.flags.owndata and not imag.flags.writeable)
reject(function()imaginary_view:setflags(true)end)
imag:setflags(true);imaginary_view:setflags(true);check(imaginary_view.flags.writeable)
for _,call in ipairs({
 function()a:setflags('false')end,
 function()a:setflags({write=1})end,
 function()a:setflags({align='true'})end,
 function()a:setflags({uic=false})end,
 function()a:setflags(true,true,false)end,
 function()a.flags.C=false end,
 function()a.flags.owndata=true end,
 function()a.flags.writebackifcopy=false end,
 function()a.flags.writeable=1 end,
 function()return a.flags.missing end,
 function()return a.flags[1]end,
 function()lr.isfortran({1,2})end,
 function()lr.isfortran(a,a)end,
})do reject(call)end
print('flags regression: '..checks..' checks passed')
