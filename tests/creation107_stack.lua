local np=require('luaray_core')
local a=np.array(1,{ndmin=64})
local value=a:tolist()
for i=1,64 do assert(type(value)=='table' and #value==1);value=value[1] end
assert(value==1)
local nested=2
for i=1,64 do nested={nested} end
local b=np.array(nested)
assert(b.ndim==64)
print('fresh rank64 Lua conversion: passed')
