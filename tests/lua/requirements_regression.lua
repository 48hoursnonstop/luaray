local lr=require('luaray')
local checks=0
local function check(value)checks=checks+1;assert(value)end
local function reject(call)check(not pcall(call))end
local a=lr.arange(6):reshape({2,3})
check(rawequal(lr.require(a),a))
check(rawequal(lr.require(a,nil,{}),a))
check(rawequal(lr.require(a,nil,false),a))
check(rawequal(lr.require(a,nil,''),a))
check(rawequal(lr.require(a,nil,'C'),a))
check(rawequal(lr.require(a,nil,'E'),a))
local f=lr.require(a,'float32',{'F','O','W','A'})
check(f.dtype=='float32' and f.flags.fnc and f.flags.owndata and f.flags.writeable and f.flags.aligned)
check(not lr.shares_memory(a,f) and lr.array_equal(a,f))
local owned=lr.require(a,nil,'O');check(owned.flags.owndata and not lr.shares_memory(owned,a))
local reverse=lr.flip(a,2);check(rawequal(lr.require(reverse),reverse))
local c=lr.require(reverse,nil,{'CONTIGUOUS','WRITEABLE'})
check(c.flags.c_contiguous and lr.array_equal(c,reverse))
a:setflags(false);local writable=lr.require(a,nil,'W')
check(writable.flags.writeable and not a.flags.writeable and not lr.shares_memory(writable,a))
check(rawequal(lr.require(a,nil,'C'),a))
local data=lr.frombuffer(string.pack('i4i4',1,2),'int32')
check(rawequal(lr.require(data,nil,'C'),data))
local mutable=lr.require(data,nil,'W');mutable[1]=7
check(mutable.flags.writeable and data[1]==1)
local unaligned=lr.frombuffer('x'..string.pack('i4i4',1,2),'int32',2,1)
local aligned=lr.require(unaligned,nil,{'ALIGNED','OWNDATA'})
check(aligned.flags.aligned and aligned.flags.owndata and lr.array_equal(aligned,unaligned))
local dirty=lr.arange(3);dirty:setflags(nil,false)
check(rawequal(lr.require(dirty),dirty) and not dirty.flags.aligned)
check(lr.require(dirty,nil,'A').flags.aligned)
local scalar=lr.require(7,nil,'F');check(scalar.ndim==0 and scalar:tolist()==7)
local empty=lr.require({},'int32','COW');check(empty.shape[1]==0 and empty.flags.owndata)
check(lr.require({1,2},'float64',{'c_contiguous','a'}).dtype=='float64')
check(lr.require(a,nil,{'FORTRAN'}).flags.f_contiguous)
check(rawequal(lr.require(f,nil,{'F','F','O'}),f))
local expanded=lr.broadcast_to(lr.arange(3),{2,3})
local converted=lr.require(expanded,'float64','A')
check(converted.strides[1]==8 and converted.strides[2]==16)
local array_conversion=lr.array(expanded,'float64',{order='A'})
check(array_conversion.strides[1]==8 and array_conversion.strides[2]==16)
check(expanded:copy('A').flags.c_contiguous)
for _,call in ipairs({
 function()lr.require(a,nil,{'C','F'})end,
 function()lr.require(lr.zeros({0}),nil,'CF')end,
 function()lr.require(a,nil,{'UNKNOWN'})end,
 function()lr.require(a,nil,'ALIGNED')end,
 function()lr.require(a,nil,{1})end,
 function()lr.require(a,nil,{W=true})end,
 function()lr.require(a,nil,{[2]='W'})end,
 function()lr.require(a,nil,true)end,
 function()lr.require(a,nil,1)end,
 function()lr.require(a,nil,'C',1)end,
})do reject(call)end
print('requirements regression: '..checks..' checks passed')
