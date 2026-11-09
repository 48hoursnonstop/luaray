local lr=require('luaray')
local checks=0
local function check(value)checks=checks+1;assert(value)end
local function reject(call)check(not pcall(call))end
local a=lr.eye(3)
check(a.dtype=='float64' and a:get(2,2)==1 and a:get(2,3)==0)
local f=lr.eye(2,{m=3,k=1,dtype='int16',order='F',device='cpu'})
check(f.strides[1]==2 and f.strides[2]==4)
check(f:get(1,2)==1 and f:get(2,3)==1 and f:get(1,1)==0)
local identity=lr.identity(3,{dtype='float32'})
check(identity.dtype=='float32' and identity:get(3,3)==1)
local bytes=lr.eye(2,nil,0,'S')
check(bytes.dtype=='|S1' and bytes:get(1,1)=='1' and bytes:get(1,2)=='')
check(lr.eye(2,{m=3,dtype='U4',order='f'}).strides[1]==16)
check(lr.eye(0,3).shape[1]==0 and lr.eye(2,0).shape[2]==0)
check(lr.eye(2,3,math.mininteger):get(1,1)==0)
check(lr.eye(2,3,math.maxinteger):get(1,1)==0)
local generic=lr.eye(2,{m=3,k=3,dtype='datetime64'})
check(lr.astype(generic,'int64'):get(1,1)==0)
local duration=lr.identity(2,'timedelta64')
check(lr.astype(duration,'int64'):get(2,2)==1)
check(lr.identity(0,'datetime64').size==0)
f:set(7,1,1);check(f:get(1,1)==7 and a:get(1,1)==1)
for _,call in ipairs({
 function()lr.eye()end,
 function()lr.eye(-1)end,
 function()lr.eye(2,-1)end,
 function()lr.eye(2.5)end,
 function()lr.eye(2,{k=true})end,
 function()lr.eye(2,{order='A'})end,
 function()lr.eye(2,{order='C\0'})end,
 function()lr.eye(2,{device='gpu'})end,
 function()lr.eye(2,{device=true})end,
 function()lr.eye(2,{unknown=1})end,
 function()lr.eye(2,{},0)end,
 function()lr.eye(2,3,0,'float64','C',1)end,
 function()lr.eye(0,{m=3,dtype='datetime64'})end,
 function()lr.eye(2,{m=3,k=-3,dtype='datetime64'})end,
 function()lr.identity(2,{order='F'})end,
 function()lr.identity(2,'float64',1)end,
 function()lr.identity(2,{['dtype\0']='int8'})end,
})do reject(call)end
print('eye regression: '..checks..' checks passed')
