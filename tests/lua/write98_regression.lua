local np=require('luaray_core')
local checks=0
local function eq(a,b)
  checks=checks+1
  if type(b)=='table' then assert(type(a)=='table' and #a==#b);for i=1,#b do eq(a[i],b[i]) end
  else assert(a==b,tostring(a)..' != '..tostring(b)) end
end
local function rejects(fn) checks=checks+1;assert(not pcall(fn),'expected rejection') end
local a=np.arange(5,'int32')
eq(np.put(a,{1,3,5},{9,8}),nil);eq(a:tolist(),{9,1,8,3,9})
a:put({-1,-2},{7});eq(a:tolist(),{9,1,8,7,7})
np.put(a,{-1,9},{2,3},'clip');eq(a:tolist(),{2,1,8,7,3})
np.put(a,{-7,8},{4,5},'wrap');eq(a:tolist(),{2,1,5,4,3})
rejects(function() np.put(a,{0},{7}) end)
rejects(function() np.put(a,{0},{7},'wrap') end)
rejects(function() np.put(a,{0},{7},'clip') end)
rejects(function() np.put(a,{1},{7},'invalid') end)
rejects(function() np.put(a,{1}) end)
rejects(function() np.place(a,{true,false,true,false,true}) end)
rejects(function() np.put(a,np.array({1.5},'float64'),{8}) end)
rejects(function() np.place(a,{true},{8}) end)
local b=np.arange(4,'int32')
rejects(function() np.put(b,{1,9},{90,91}) end)
eq(b:tolist(),{90,1,2,3}) -- contiguous non-overlapping writes persist before error
b=np.arange(4,'int32');local reverse=np.flip(b)
rejects(function() np.put(reverse,{1,9},{90,91}) end)
eq(b:tolist(),{0,1,2,3}) -- temporary writeback is discarded on error
b=np.arange(4,'int32')
rejects(function() np.put(b,{1,9},b) end)
eq(b:tolist(),{0,1,2,3})
b=np.array({4,3,2,1},'int64');np.put(b,b,{7,8,9,10});eq(b:tolist(),{10,9,8,7})
b=np.arange(4,'int32');np.put(b,{4,3,2,1},b);eq(b:tolist(),{3,2,1,0})
b=np.array({1,0,1,1,1},'int32');np.place(b,{true,false,true,true,true},b)
eq(b:tolist(),{1,0,0,0,0}) -- source place reads contiguous aliased values live
b=np.arange(5,'int32');np.place(b,{true,false,true,false,true},{9,8})
eq(b:tolist(),{9,1,8,3,9}) -- advance values only at selected positions
np.place(b,{false,false,false,false,false},{})
rejects(function() np.place(b,{true,false,false,false,false},{}) end)
eq(np.put(b,{99},{}),nil) -- empty values skip bounds validation
local bytes=np.zeros({3},'uint8')
rejects(function() np.put(bytes,{1},{300}) end)
rejects(function() np.place(bytes,{true,false,false},{300}) end)
rejects(function() np.place(bytes,{false,false,false},np.array({},'float64')) end)
rejects(function() np.place(bytes,{true,false,false},np.array({1.5},'float64')) end)
np.put(bytes,{1},np.array({300},'int64'));eq(bytes:tolist(),{44,0,0})
np.place(bytes,{true,false,false},{1.5});eq(bytes:tolist(),{1,0,0})
local readonly=np.broadcast_to(np.array({1},'int32'),{3})
rejects(function() np.put(readonly,{}, {}) end)
rejects(function() np.place(readonly,{false,false,false},{}) end)
rejects(function() np.put(np.array({},'int32'),{1},{}) end)
local huge=np.array({math.mininteger,math.maxinteger},'int64')
b=np.zeros({3},'int32');np.put(b,huge,{11,12},'wrap');eq(b:tolist(),{12,11,0})
collectgarbage('collect')
print(('write98 regression: %d checks passed'):format(checks))
