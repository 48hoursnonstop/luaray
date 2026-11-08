local np=require('luaray_core')
local checks=0
local function eq(a,b)
  checks=checks+1
  if type(b)=='table' then assert(type(a)=='table' and #a==#b);for i=1,#b do eq(a[i],b[i]) end
  else assert(a==b,tostring(a)..' != '..tostring(b)) end
end
local function fails(fn) checks=checks+1;assert(not pcall(fn),'expected rejection') end
for _,dtype in ipairs({'int32','uint8','float32','complex64'}) do
 local a=np.zeros({3},dtype)
 eq(np.copyto(a,2),nil) -- omitted mask must not consume a temporary stack operand
 eq(a:get(1),dtype=='complex64' and np.complex(2,0) or 2)
end
local f=np.zeros({3},'float32')
np.copyto(f,1.5,'no');eq(f:tolist(),{1.5,1.5,1.5})
fails(function() np.copyto(f,1.5,'equiv') end)
fails(function() np.copyto(f,2,'equiv') end)
np.copyto(f,np.array({{1,2,3}},'float32'))
eq(f:tolist(),{1,2,3})
np.copyto(f,9,nil,{1,0,1});eq(f:tolist(),{9,2,9})
fails(function() np.copyto(f,4,nil,np.array({1,0,1},'int32')) end)
local a=np.array({1,2,3},'uint8')
eq(np.putmask(a,{1,0,1},{}),nil);eq(a:tolist(),{1,2,3})
np.putmask(a,{1,0,1},{5,6});eq(a:tolist(),{5,2,5})
np.putmask(a,{true,false,true},{1.5,2.5});eq(a:tolist(),{1,2,1})
fails(function() np.putmask(a,{false,false,false},np.array({},'float64')) end)
fails(function() np.putmask(a,{false,false,false},300) end)
fails(function() np.putmask(a,{1,0,1}) end)
fails(function() np.copyto(a) end)
local b=np.array({false,false,false},'bool')
np.putmask(b,{np.complex(1,2),np.complex(0,0),np.complex(0,1)},true)
eq(b:tolist(),{true,false,true})
np.place(b,{true,true,true},np.complex(0,1));eq(b:tolist(),{true,true,true})
local readonly=np.broadcast_to(np.array({1},'int32'),{3})
eq(np.copyto(readonly,readonly,'no'),nil) -- source's redundant array-assignment shortcut
fails(function() np.copyto(readonly,2) end)
fails(function() np.putmask(readonly,{false,false,false},{}) end)
local temporal=np.zeros({2},'datetime64[D]')
np.copyto(temporal,np.complex(2,3),'unsafe')
eq(np.astype(temporal,'int64'):tolist(),{2,2})
local t=np.zeros({2},'timedelta64[h]')
np.copyto(t,2);eq(np.astype(t,'int64'):tolist(),{2,2})
fails(function() np.copyto(t,2.5,'unsafe') end)
local d=np.zeros({2},'int32')
fails(function() np.copyto(d,'bad','unsafe',false) end) -- multi-element scalar preconversion
local single=np.zeros({1},'int32')
eq(np.copyto(single,'bad','unsafe',false),nil) -- no selected scalar conversion at size one
eq(single:tolist(),{0})
fails(function() np.copyto(d,2,'same_value') end)
local text=np.array({'a','b','c'},'S3')
np.copyto(text,text:reshape({1,3}),'no');eq(text:tolist(),{'a','b','c'})
local overlap=np.array({true,true,false,true,true,false,true,true,false},'bool')
local dst=overlap:get(np.s(1,9))
np.copyto(dst,overlap:get(np.s(2,nil)),'no',dst)
eq(overlap:tolist(),{true,false,false,true,false,false,true,false,false})
collectgarbage('collect')
print(('memory99 regression: %d checks passed'):format(checks))
