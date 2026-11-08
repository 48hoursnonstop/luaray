local np=require('luaray_core')
local n=0

local function equal(a,b)
 if type(b)=='table' then
  assert(type(a)=='table' and #a==#b,'case '..n..' table mismatch')
  for i=1,#b do equal(a[i],b[i]) end
 else assert(a==b or (type(a)=='number' and type(b)=='number' and
     (a~=a and b~=b or math.abs(a-b)<1e-8*math.max(1,math.abs(b)))),
     'case '..n..': '..tostring(a)..' ~= '..tostring(b)) end
end
local function check(a,shape,strides,dtype,values)
 assert(a.ndim==#shape,'case '..n..' dimension mismatch')
 assert(a.dtype==dtype,'case '..n..' dtype '..a.dtype..' ~= '..dtype)
 equal(a.shape,shape)
 equal(a.strides,strides)
 equal(a:tolist(),values)
end

do local results={np.broadcast_to(np.reshape(np.array({-5},"int32"),{}),{})}
assert(#results==1,"case 1: result count")
check(results[1],{},{},"int32",-5)
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5},"int32"),{}),{0})}
assert(#results==1,"case 2: result count")
check(results[1],{0},{0},"int32",{})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5},"int32"),{}),{1})}
assert(#results==1,"case 3: result count")
check(results[1],{1},{0},"int32",{-5})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5},"int32"),{}),{3})}
assert(#results==1,"case 4: result count")
check(results[1],{3},{0},"int32",{-5,-5,-5})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5},"int32"),{}),{2})}
assert(#results==1,"case 5: result count")
check(results[1],{2},{0},"int32",{-5,-5})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5},"int32"),{}),{0,1})}
assert(#results==1,"case 6: result count")
check(results[1],{0,1},{0,0},"int32",{})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5},"int32"),{}),{1,0})}
assert(#results==1,"case 7: result count")
check(results[1],{1,0},{0,0},"int32",{{}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5},"int32"),{}),{1,3})}
assert(#results==1,"case 8: result count")
check(results[1],{1,3},{0,0},"int32",{{-5,-5,-5}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5},"int32"),{}),{3,1})}
assert(#results==1,"case 9: result count")
check(results[1],{3,1},{0,0},"int32",{{-5},{-5},{-5}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5},"int32"),{}),{2,3})}
assert(#results==1,"case 10: result count")
check(results[1],{2,3},{0,0},"int32",{{-5,-5,-5},{-5,-5,-5}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5},"int32"),{}),{0,3})}
assert(#results==1,"case 11: result count")
check(results[1],{0,3},{0,0},"int32",{})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5},"int32"),{}),{1,0,3})}
assert(#results==1,"case 12: result count")
check(results[1],{1,0,3},{0,0,0},"int32",{{}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5},"int32"),{}),{2,1,3})}
assert(#results==1,"case 13: result count")
check(results[1],{2,1,3},{0,0,0},"int32",{{{-5,-5,-5}},{{-5,-5,-5}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5},"int32"),{}),{2,2,3})}
assert(#results==1,"case 14: result count")
check(results[1],{2,2,3},{0,0,0},"int32",{{{-5,-5,-5},{-5,-5,-5}},{{-5,-5,-5},{-5,-5,-5}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5},"int32"),{}),{1,2,1,3})}
assert(#results==1,"case 15: result count")
check(results[1],{1,2,1,3},{0,0,0,0},"int32",{{{{-5,-5,-5}},{{-5,-5,-5}}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5},"int32"),{}),{2,0,3})}
assert(#results==1,"case 16: result count")
check(results[1],{2,0,3},{0,0,0},"int32",{{},{}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5},"int32"),{}),{0,2,3})}
assert(#results==1,"case 17: result count")
check(results[1],{0,2,3},{0,0,0},"int32",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0}),{}) end),"case 18: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({},"int32"),{0}),{0})}
assert(#results==1,"case 19: result count")
check(results[1],{0},{0},"int32",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0}),{1}) end),"case 20: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0}),{3}) end),"case 21: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0}),{2}) end),"case 22: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0}),{0,1}) end),"case 23: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({},"int32"),{0}),{1,0})}
assert(#results==1,"case 24: result count")
check(results[1],{1,0},{0,0},"int32",{{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0}),{1,3}) end),"case 25: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0}),{3,1}) end),"case 26: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0}),{2,3}) end),"case 27: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0}),{0,3}) end),"case 28: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0}),{1,0,3}) end),"case 29: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0}),{2,1,3}) end),"case 30: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0}),{2,2,3}) end),"case 31: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0}),{1,2,1,3}) end),"case 32: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0}),{2,0,3}) end),"case 33: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0}),{0,2,3}) end),"case 34: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0}),1),{}) end),"case 35: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0}),1),{0})}
assert(#results==1,"case 36: result count")
check(results[1],{0},{0},"int32",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0}),1),{1}) end),"case 37: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0}),1),{3}) end),"case 38: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0}),1),{2}) end),"case 39: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0}),1),{0,1}) end),"case 40: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0}),1),{1,0})}
assert(#results==1,"case 41: result count")
check(results[1],{1,0},{0,0},"int32",{{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0}),1),{1,3}) end),"case 42: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0}),1),{3,1}) end),"case 43: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0}),1),{2,3}) end),"case 44: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0}),1),{0,3}) end),"case 45: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0}),1),{1,0,3}) end),"case 46: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0}),1),{2,1,3}) end),"case 47: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0}),1),{2,2,3}) end),"case 48: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0}),1),{1,2,1,3}) end),"case 49: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0}),1),{2,0,3}) end),"case 50: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0}),1),{0,2,3}) end),"case 51: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5},"int32"),{1}),{}) end),"case 52: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5},"int32"),{1}),{0})}
assert(#results==1,"case 53: result count")
check(results[1],{0},{0},"int32",{})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5},"int32"),{1}),{1})}
assert(#results==1,"case 54: result count")
check(results[1],{1},{0},"int32",{-5})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5},"int32"),{1}),{3})}
assert(#results==1,"case 55: result count")
check(results[1],{3},{0},"int32",{-5,-5,-5})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5},"int32"),{1}),{2})}
assert(#results==1,"case 56: result count")
check(results[1],{2},{0},"int32",{-5,-5})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5},"int32"),{1}),{0,1})}
assert(#results==1,"case 57: result count")
check(results[1],{0,1},{0,0},"int32",{})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5},"int32"),{1}),{1,0})}
assert(#results==1,"case 58: result count")
check(results[1],{1,0},{0,0},"int32",{{}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5},"int32"),{1}),{1,3})}
assert(#results==1,"case 59: result count")
check(results[1],{1,3},{0,0},"int32",{{-5,-5,-5}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5},"int32"),{1}),{3,1})}
assert(#results==1,"case 60: result count")
check(results[1],{3,1},{0,0},"int32",{{-5},{-5},{-5}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5},"int32"),{1}),{2,3})}
assert(#results==1,"case 61: result count")
check(results[1],{2,3},{0,0},"int32",{{-5,-5,-5},{-5,-5,-5}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5},"int32"),{1}),{0,3})}
assert(#results==1,"case 62: result count")
check(results[1],{0,3},{0,0},"int32",{})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5},"int32"),{1}),{1,0,3})}
assert(#results==1,"case 63: result count")
check(results[1],{1,0,3},{0,0,0},"int32",{{}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5},"int32"),{1}),{2,1,3})}
assert(#results==1,"case 64: result count")
check(results[1],{2,1,3},{0,0,0},"int32",{{{-5,-5,-5}},{{-5,-5,-5}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5},"int32"),{1}),{2,2,3})}
assert(#results==1,"case 65: result count")
check(results[1],{2,2,3},{0,0,0},"int32",{{{-5,-5,-5},{-5,-5,-5}},{{-5,-5,-5},{-5,-5,-5}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5},"int32"),{1}),{1,2,1,3})}
assert(#results==1,"case 66: result count")
check(results[1],{1,2,1,3},{0,0,0,0},"int32",{{{{-5,-5,-5}},{{-5,-5,-5}}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5},"int32"),{1}),{2,0,3})}
assert(#results==1,"case 67: result count")
check(results[1],{2,0,3},{0,0,0},"int32",{{},{}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5},"int32"),{1}),{0,2,3})}
assert(#results==1,"case 68: result count")
check(results[1],{0,2,3},{0,0,0},"int32",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5},"int32"),{1}),1),{}) end),"case 69: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5},"int32"),{1}),1),{0})}
assert(#results==1,"case 70: result count")
check(results[1],{0},{0},"int32",{})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5},"int32"),{1}),1),{1})}
assert(#results==1,"case 71: result count")
check(results[1],{1},{0},"int32",{-5})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5},"int32"),{1}),1),{3})}
assert(#results==1,"case 72: result count")
check(results[1],{3},{0},"int32",{-5,-5,-5})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5},"int32"),{1}),1),{2})}
assert(#results==1,"case 73: result count")
check(results[1],{2},{0},"int32",{-5,-5})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5},"int32"),{1}),1),{0,1})}
assert(#results==1,"case 74: result count")
check(results[1],{0,1},{0,0},"int32",{})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5},"int32"),{1}),1),{1,0})}
assert(#results==1,"case 75: result count")
check(results[1],{1,0},{0,0},"int32",{{}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5},"int32"),{1}),1),{1,3})}
assert(#results==1,"case 76: result count")
check(results[1],{1,3},{0,0},"int32",{{-5,-5,-5}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5},"int32"),{1}),1),{3,1})}
assert(#results==1,"case 77: result count")
check(results[1],{3,1},{0,0},"int32",{{-5},{-5},{-5}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5},"int32"),{1}),1),{2,3})}
assert(#results==1,"case 78: result count")
check(results[1],{2,3},{0,0},"int32",{{-5,-5,-5},{-5,-5,-5}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5},"int32"),{1}),1),{0,3})}
assert(#results==1,"case 79: result count")
check(results[1],{0,3},{0,0},"int32",{})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5},"int32"),{1}),1),{1,0,3})}
assert(#results==1,"case 80: result count")
check(results[1],{1,0,3},{0,0,0},"int32",{{}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5},"int32"),{1}),1),{2,1,3})}
assert(#results==1,"case 81: result count")
check(results[1],{2,1,3},{0,0,0},"int32",{{{-5,-5,-5}},{{-5,-5,-5}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5},"int32"),{1}),1),{2,2,3})}
assert(#results==1,"case 82: result count")
check(results[1],{2,2,3},{0,0,0},"int32",{{{-5,-5,-5},{-5,-5,-5}},{{-5,-5,-5},{-5,-5,-5}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5},"int32"),{1}),1),{1,2,1,3})}
assert(#results==1,"case 83: result count")
check(results[1],{1,2,1,3},{0,0,0,0},"int32",{{{{-5,-5,-5}},{{-5,-5,-5}}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5},"int32"),{1}),1),{2,0,3})}
assert(#results==1,"case 84: result count")
check(results[1],{2,0,3},{0,0,0},"int32",{{},{}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5},"int32"),{1}),1),{0,2,3})}
assert(#results==1,"case 85: result count")
check(results[1],{0,2,3},{0,0,0},"int32",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{3}),{}) end),"case 86: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{3}),{0}) end),"case 87: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{3}),{1}) end),"case 88: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{3}),{3})}
assert(#results==1,"case 89: result count")
check(results[1],{3},{4},"int32",{-5,-2,1})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{3}),{2}) end),"case 90: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{3}),{0,1}) end),"case 91: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{3}),{1,0}) end),"case 92: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{3}),{1,3})}
assert(#results==1,"case 93: result count")
check(results[1],{1,3},{0,4},"int32",{{-5,-2,1}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{3}),{3,1}) end),"case 94: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{3}),{2,3})}
assert(#results==1,"case 95: result count")
check(results[1],{2,3},{0,4},"int32",{{-5,-2,1},{-5,-2,1}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{3}),{0,3})}
assert(#results==1,"case 96: result count")
check(results[1],{0,3},{0,4},"int32",{})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{3}),{1,0,3})}
assert(#results==1,"case 97: result count")
check(results[1],{1,0,3},{0,0,4},"int32",{{}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{3}),{2,1,3})}
assert(#results==1,"case 98: result count")
check(results[1],{2,1,3},{0,0,4},"int32",{{{-5,-2,1}},{{-5,-2,1}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{3}),{2,2,3})}
assert(#results==1,"case 99: result count")
check(results[1],{2,2,3},{0,0,4},"int32",{{{-5,-2,1},{-5,-2,1}},{{-5,-2,1},{-5,-2,1}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{3}),{1,2,1,3})}
assert(#results==1,"case 100: result count")
check(results[1],{1,2,1,3},{0,0,0,4},"int32",{{{{-5,-2,1}},{{-5,-2,1}}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{3}),{2,0,3})}
assert(#results==1,"case 101: result count")
check(results[1],{2,0,3},{0,0,4},"int32",{{},{}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{3}),{0,2,3})}
assert(#results==1,"case 102: result count")
check(results[1],{0,2,3},{0,0,4},"int32",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{3}),1),{}) end),"case 103: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{3}),1),{0}) end),"case 104: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{3}),1),{1}) end),"case 105: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{3}),1),{3})}
assert(#results==1,"case 106: result count")
check(results[1],{3},{-4},"int32",{1,-2,-5})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{3}),1),{2}) end),"case 107: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{3}),1),{0,1}) end),"case 108: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{3}),1),{1,0}) end),"case 109: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{3}),1),{1,3})}
assert(#results==1,"case 110: result count")
check(results[1],{1,3},{0,-4},"int32",{{1,-2,-5}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{3}),1),{3,1}) end),"case 111: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{3}),1),{2,3})}
assert(#results==1,"case 112: result count")
check(results[1],{2,3},{0,-4},"int32",{{1,-2,-5},{1,-2,-5}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{3}),1),{0,3})}
assert(#results==1,"case 113: result count")
check(results[1],{0,3},{0,-4},"int32",{})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{3}),1),{1,0,3})}
assert(#results==1,"case 114: result count")
check(results[1],{1,0,3},{0,0,-4},"int32",{{}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{3}),1),{2,1,3})}
assert(#results==1,"case 115: result count")
check(results[1],{2,1,3},{0,0,-4},"int32",{{{1,-2,-5}},{{1,-2,-5}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{3}),1),{2,2,3})}
assert(#results==1,"case 116: result count")
check(results[1],{2,2,3},{0,0,-4},"int32",{{{1,-2,-5},{1,-2,-5}},{{1,-2,-5},{1,-2,-5}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{3}),1),{1,2,1,3})}
assert(#results==1,"case 117: result count")
check(results[1],{1,2,1,3},{0,0,0,-4},"int32",{{{{1,-2,-5}},{{1,-2,-5}}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{3}),1),{2,0,3})}
assert(#results==1,"case 118: result count")
check(results[1],{2,0,3},{0,0,-4},"int32",{{},{}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{3}),1),{0,2,3})}
assert(#results==1,"case 119: result count")
check(results[1],{0,2,3},{0,0,-4},"int32",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0,1}),{}) end),"case 120: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0,1}),{0}) end),"case 121: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0,1}),{1}) end),"case 122: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0,1}),{3}) end),"case 123: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0,1}),{2}) end),"case 124: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({},"int32"),{0,1}),{0,1})}
assert(#results==1,"case 125: result count")
check(results[1],{0,1},{4,0},"int32",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0,1}),{1,0}) end),"case 126: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0,1}),{1,3}) end),"case 127: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0,1}),{3,1}) end),"case 128: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0,1}),{2,3}) end),"case 129: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({},"int32"),{0,1}),{0,3})}
assert(#results==1,"case 130: result count")
check(results[1],{0,3},{4,0},"int32",{})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({},"int32"),{0,1}),{1,0,3})}
assert(#results==1,"case 131: result count")
check(results[1],{1,0,3},{0,4,0},"int32",{{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0,1}),{2,1,3}) end),"case 132: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0,1}),{2,2,3}) end),"case 133: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0,1}),{1,2,1,3}) end),"case 134: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({},"int32"),{0,1}),{2,0,3})}
assert(#results==1,"case 135: result count")
check(results[1],{2,0,3},{0,4,0},"int32",{{},{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0,1}),{0,2,3}) end),"case 136: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0,1}),1),{}) end),"case 137: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0,1}),1),{0}) end),"case 138: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0,1}),1),{1}) end),"case 139: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0,1}),1),{3}) end),"case 140: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0,1}),1),{2}) end),"case 141: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0,1}),1),{0,1})}
assert(#results==1,"case 142: result count")
check(results[1],{0,1},{4,0},"int32",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0,1}),1),{1,0}) end),"case 143: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0,1}),1),{1,3}) end),"case 144: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0,1}),1),{3,1}) end),"case 145: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0,1}),1),{2,3}) end),"case 146: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0,1}),1),{0,3})}
assert(#results==1,"case 147: result count")
check(results[1],{0,3},{4,0},"int32",{})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0,1}),1),{1,0,3})}
assert(#results==1,"case 148: result count")
check(results[1],{1,0,3},{0,4,0},"int32",{{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0,1}),1),{2,1,3}) end),"case 149: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0,1}),1),{2,2,3}) end),"case 150: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0,1}),1),{1,2,1,3}) end),"case 151: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0,1}),1),{2,0,3})}
assert(#results==1,"case 152: result count")
check(results[1],{2,0,3},{0,4,0},"int32",{{},{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0,1}),1),{0,2,3}) end),"case 153: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{0,1})),{}) end),"case 154: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{0,1})),{0}) end),"case 155: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{0,1})),{1}) end),"case 156: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{0,1})),{3}) end),"case 157: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{0,1})),{2}) end),"case 158: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{0,1})),{0,1}) end),"case 159: expected rejection")
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{0,1})),{1,0})}
assert(#results==1,"case 160: result count")
check(results[1],{1,0},{0,4},"int32",{{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{0,1})),{1,3}) end),"case 161: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{0,1})),{3,1}) end),"case 162: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{0,1})),{2,3}) end),"case 163: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{0,1})),{0,3}) end),"case 164: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{0,1})),{1,0,3}) end),"case 165: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{0,1})),{2,1,3}) end),"case 166: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{0,1})),{2,2,3}) end),"case 167: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{0,1})),{1,2,1,3}) end),"case 168: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{0,1})),{2,0,3}) end),"case 169: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{0,1})),{0,2,3}) end),"case 170: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{1,0}),{}) end),"case 171: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{1,0}),{0}) end),"case 172: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{1,0}),{1}) end),"case 173: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{1,0}),{3}) end),"case 174: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{1,0}),{2}) end),"case 175: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{1,0}),{0,1}) end),"case 176: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({},"int32"),{1,0}),{1,0})}
assert(#results==1,"case 177: result count")
check(results[1],{1,0},{0,4},"int32",{{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{1,0}),{1,3}) end),"case 178: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{1,0}),{3,1}) end),"case 179: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{1,0}),{2,3}) end),"case 180: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{1,0}),{0,3}) end),"case 181: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{1,0}),{1,0,3}) end),"case 182: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{1,0}),{2,1,3}) end),"case 183: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{1,0}),{2,2,3}) end),"case 184: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{1,0}),{1,2,1,3}) end),"case 185: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{1,0}),{2,0,3}) end),"case 186: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{1,0}),{0,2,3}) end),"case 187: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{1,0}),1),{}) end),"case 188: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{1,0}),1),{0}) end),"case 189: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{1,0}),1),{1}) end),"case 190: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{1,0}),1),{3}) end),"case 191: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{1,0}),1),{2}) end),"case 192: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{1,0}),1),{0,1}) end),"case 193: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{1,0}),1),{1,0})}
assert(#results==1,"case 194: result count")
check(results[1],{1,0},{0,4},"int32",{{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{1,0}),1),{1,3}) end),"case 195: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{1,0}),1),{3,1}) end),"case 196: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{1,0}),1),{2,3}) end),"case 197: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{1,0}),1),{0,3}) end),"case 198: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{1,0}),1),{1,0,3}) end),"case 199: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{1,0}),1),{2,1,3}) end),"case 200: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{1,0}),1),{2,2,3}) end),"case 201: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{1,0}),1),{1,2,1,3}) end),"case 202: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{1,0}),1),{2,0,3}) end),"case 203: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{1,0}),1),{0,2,3}) end),"case 204: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{1,0})),{}) end),"case 205: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{1,0})),{0}) end),"case 206: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{1,0})),{1}) end),"case 207: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{1,0})),{3}) end),"case 208: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{1,0})),{2}) end),"case 209: expected rejection")
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{1,0})),{0,1})}
assert(#results==1,"case 210: result count")
check(results[1],{0,1},{4,0},"int32",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{1,0})),{1,0}) end),"case 211: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{1,0})),{1,3}) end),"case 212: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{1,0})),{3,1}) end),"case 213: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{1,0})),{2,3}) end),"case 214: expected rejection")
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{1,0})),{0,3})}
assert(#results==1,"case 215: result count")
check(results[1],{0,3},{4,0},"int32",{})
end
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{1,0})),{1,0,3})}
assert(#results==1,"case 216: result count")
check(results[1],{1,0,3},{0,4,0},"int32",{{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{1,0})),{2,1,3}) end),"case 217: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{1,0})),{2,2,3}) end),"case 218: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{1,0})),{1,2,1,3}) end),"case 219: expected rejection")
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{1,0})),{2,0,3})}
assert(#results==1,"case 220: result count")
check(results[1],{2,0,3},{0,4,0},"int32",{{},{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{1,0})),{0,2,3}) end),"case 221: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{1,3}),{}) end),"case 222: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{1,3}),{0}) end),"case 223: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{1,3}),{1}) end),"case 224: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{1,3}),{3}) end),"case 225: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{1,3}),{2}) end),"case 226: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{1,3}),{0,1}) end),"case 227: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{1,3}),{1,0}) end),"case 228: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{1,3}),{1,3})}
assert(#results==1,"case 229: result count")
check(results[1],{1,3},{0,4},"int32",{{-5,-2,1}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{1,3}),{3,1}) end),"case 230: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{1,3}),{2,3})}
assert(#results==1,"case 231: result count")
check(results[1],{2,3},{0,4},"int32",{{-5,-2,1},{-5,-2,1}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{1,3}),{0,3})}
assert(#results==1,"case 232: result count")
check(results[1],{0,3},{0,4},"int32",{})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{1,3}),{1,0,3})}
assert(#results==1,"case 233: result count")
check(results[1],{1,0,3},{0,0,4},"int32",{{}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{1,3}),{2,1,3})}
assert(#results==1,"case 234: result count")
check(results[1],{2,1,3},{0,0,4},"int32",{{{-5,-2,1}},{{-5,-2,1}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{1,3}),{2,2,3})}
assert(#results==1,"case 235: result count")
check(results[1],{2,2,3},{0,0,4},"int32",{{{-5,-2,1},{-5,-2,1}},{{-5,-2,1},{-5,-2,1}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{1,3}),{1,2,1,3})}
assert(#results==1,"case 236: result count")
check(results[1],{1,2,1,3},{0,0,0,4},"int32",{{{{-5,-2,1}},{{-5,-2,1}}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{1,3}),{2,0,3})}
assert(#results==1,"case 237: result count")
check(results[1],{2,0,3},{0,0,4},"int32",{{},{}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{1,3}),{0,2,3})}
assert(#results==1,"case 238: result count")
check(results[1],{0,2,3},{0,0,4},"int32",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{1,3}),1),{}) end),"case 239: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{1,3}),1),{0}) end),"case 240: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{1,3}),1),{1}) end),"case 241: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{1,3}),1),{3}) end),"case 242: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{1,3}),1),{2}) end),"case 243: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{1,3}),1),{0,1}) end),"case 244: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{1,3}),1),{1,0}) end),"case 245: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{1,3}),1),{1,3})}
assert(#results==1,"case 246: result count")
check(results[1],{1,3},{0,4},"int32",{{-5,-2,1}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{1,3}),1),{3,1}) end),"case 247: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{1,3}),1),{2,3})}
assert(#results==1,"case 248: result count")
check(results[1],{2,3},{0,4},"int32",{{-5,-2,1},{-5,-2,1}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{1,3}),1),{0,3})}
assert(#results==1,"case 249: result count")
check(results[1],{0,3},{0,4},"int32",{})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{1,3}),1),{1,0,3})}
assert(#results==1,"case 250: result count")
check(results[1],{1,0,3},{0,0,4},"int32",{{}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{1,3}),1),{2,1,3})}
assert(#results==1,"case 251: result count")
check(results[1],{2,1,3},{0,0,4},"int32",{{{-5,-2,1}},{{-5,-2,1}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{1,3}),1),{2,2,3})}
assert(#results==1,"case 252: result count")
check(results[1],{2,2,3},{0,0,4},"int32",{{{-5,-2,1},{-5,-2,1}},{{-5,-2,1},{-5,-2,1}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{1,3}),1),{1,2,1,3})}
assert(#results==1,"case 253: result count")
check(results[1],{1,2,1,3},{0,0,0,4},"int32",{{{{-5,-2,1}},{{-5,-2,1}}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{1,3}),1),{2,0,3})}
assert(#results==1,"case 254: result count")
check(results[1],{2,0,3},{0,0,4},"int32",{{},{}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{1,3}),1),{0,2,3})}
assert(#results==1,"case 255: result count")
check(results[1],{0,2,3},{0,0,4},"int32",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1},"int32"),{1,3})),{}) end),"case 256: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1},"int32"),{1,3})),{0}) end),"case 257: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1},"int32"),{1,3})),{1}) end),"case 258: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1},"int32"),{1,3})),{3}) end),"case 259: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1},"int32"),{1,3})),{2}) end),"case 260: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1},"int32"),{1,3})),{0,1}) end),"case 261: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1},"int32"),{1,3})),{1,0}) end),"case 262: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1},"int32"),{1,3})),{1,3}) end),"case 263: expected rejection")
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1},"int32"),{1,3})),{3,1})}
assert(#results==1,"case 264: result count")
check(results[1],{3,1},{4,0},"int32",{{-5},{-2},{1}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1},"int32"),{1,3})),{2,3}) end),"case 265: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1},"int32"),{1,3})),{0,3}) end),"case 266: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1},"int32"),{1,3})),{1,0,3}) end),"case 267: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1},"int32"),{1,3})),{2,1,3}) end),"case 268: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1},"int32"),{1,3})),{2,2,3}) end),"case 269: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1},"int32"),{1,3})),{1,2,1,3}) end),"case 270: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1},"int32"),{1,3})),{2,0,3}) end),"case 271: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1},"int32"),{1,3})),{0,2,3}) end),"case 272: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{3,1}),{}) end),"case 273: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{3,1}),{0}) end),"case 274: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{3,1}),{1}) end),"case 275: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{3,1}),{3}) end),"case 276: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{3,1}),{2}) end),"case 277: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{3,1}),{0,1}) end),"case 278: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{3,1}),{1,0}) end),"case 279: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{3,1}),{1,3}) end),"case 280: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{3,1}),{3,1})}
assert(#results==1,"case 281: result count")
check(results[1],{3,1},{4,0},"int32",{{-5},{-2},{1}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{3,1}),{2,3}) end),"case 282: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{3,1}),{0,3}) end),"case 283: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{3,1}),{1,0,3}) end),"case 284: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{3,1}),{2,1,3}) end),"case 285: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{3,1}),{2,2,3}) end),"case 286: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{3,1}),{1,2,1,3}) end),"case 287: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{3,1}),{2,0,3}) end),"case 288: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1},"int32"),{3,1}),{0,2,3}) end),"case 289: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{3,1}),1),{}) end),"case 290: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{3,1}),1),{0}) end),"case 291: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{3,1}),1),{1}) end),"case 292: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{3,1}),1),{3}) end),"case 293: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{3,1}),1),{2}) end),"case 294: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{3,1}),1),{0,1}) end),"case 295: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{3,1}),1),{1,0}) end),"case 296: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{3,1}),1),{1,3}) end),"case 297: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{3,1}),1),{3,1})}
assert(#results==1,"case 298: result count")
check(results[1],{3,1},{-4,0},"int32",{{1},{-2},{-5}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{3,1}),1),{2,3}) end),"case 299: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{3,1}),1),{0,3}) end),"case 300: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{3,1}),1),{1,0,3}) end),"case 301: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{3,1}),1),{2,1,3}) end),"case 302: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{3,1}),1),{2,2,3}) end),"case 303: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{3,1}),1),{1,2,1,3}) end),"case 304: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{3,1}),1),{2,0,3}) end),"case 305: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1},"int32"),{3,1}),1),{0,2,3}) end),"case 306: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1},"int32"),{3,1})),{}) end),"case 307: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1},"int32"),{3,1})),{0}) end),"case 308: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1},"int32"),{3,1})),{1}) end),"case 309: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1},"int32"),{3,1})),{3}) end),"case 310: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1},"int32"),{3,1})),{2}) end),"case 311: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1},"int32"),{3,1})),{0,1}) end),"case 312: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1},"int32"),{3,1})),{1,0}) end),"case 313: expected rejection")
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1},"int32"),{3,1})),{1,3})}
assert(#results==1,"case 314: result count")
check(results[1],{1,3},{0,4},"int32",{{-5,-2,1}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1},"int32"),{3,1})),{3,1}) end),"case 315: expected rejection")
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1},"int32"),{3,1})),{2,3})}
assert(#results==1,"case 316: result count")
check(results[1],{2,3},{0,4},"int32",{{-5,-2,1},{-5,-2,1}})
end
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1},"int32"),{3,1})),{0,3})}
assert(#results==1,"case 317: result count")
check(results[1],{0,3},{0,4},"int32",{})
end
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1},"int32"),{3,1})),{1,0,3})}
assert(#results==1,"case 318: result count")
check(results[1],{1,0,3},{0,0,4},"int32",{{}})
end
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1},"int32"),{3,1})),{2,1,3})}
assert(#results==1,"case 319: result count")
check(results[1],{2,1,3},{0,0,4},"int32",{{{-5,-2,1}},{{-5,-2,1}}})
end
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1},"int32"),{3,1})),{2,2,3})}
assert(#results==1,"case 320: result count")
check(results[1],{2,2,3},{0,0,4},"int32",{{{-5,-2,1},{-5,-2,1}},{{-5,-2,1},{-5,-2,1}}})
end
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1},"int32"),{3,1})),{1,2,1,3})}
assert(#results==1,"case 321: result count")
check(results[1],{1,2,1,3},{0,0,0,4},"int32",{{{{-5,-2,1}},{{-5,-2,1}}}})
end
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1},"int32"),{3,1})),{2,0,3})}
assert(#results==1,"case 322: result count")
check(results[1],{2,0,3},{0,0,4},"int32",{{},{}})
end
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1},"int32"),{3,1})),{0,2,3})}
assert(#results==1,"case 323: result count")
check(results[1],{0,2,3},{0,0,4},"int32",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3}),{}) end),"case 324: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3}),{0}) end),"case 325: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3}),{1}) end),"case 326: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3}),{3}) end),"case 327: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3}),{2}) end),"case 328: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3}),{0,1}) end),"case 329: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3}),{1,0}) end),"case 330: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3}),{1,3}) end),"case 331: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3}),{3,1}) end),"case 332: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3}),{2,3})}
assert(#results==1,"case 333: result count")
check(results[1],{2,3},{12,4},"int32",{{-5,-2,1},{4,7,10}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3}),{0,3}) end),"case 334: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3}),{1,0,3}) end),"case 335: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3}),{2,1,3}) end),"case 336: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3}),{2,2,3})}
assert(#results==1,"case 337: result count")
check(results[1],{2,2,3},{0,12,4},"int32",{{{-5,-2,1},{4,7,10}},{{-5,-2,1},{4,7,10}}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3}),{1,2,1,3}) end),"case 338: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3}),{2,0,3}) end),"case 339: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3}),{0,2,3})}
assert(#results==1,"case 340: result count")
check(results[1],{0,2,3},{0,12,4},"int32",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3}),1),{}) end),"case 341: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3}),1),{0}) end),"case 342: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3}),1),{1}) end),"case 343: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3}),1),{3}) end),"case 344: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3}),1),{2}) end),"case 345: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3}),1),{0,1}) end),"case 346: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3}),1),{1,0}) end),"case 347: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3}),1),{1,3}) end),"case 348: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3}),1),{3,1}) end),"case 349: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3}),1),{2,3})}
assert(#results==1,"case 350: result count")
check(results[1],{2,3},{-12,4},"int32",{{4,7,10},{-5,-2,1}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3}),1),{0,3}) end),"case 351: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3}),1),{1,0,3}) end),"case 352: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3}),1),{2,1,3}) end),"case 353: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3}),1),{2,2,3})}
assert(#results==1,"case 354: result count")
check(results[1],{2,2,3},{0,-12,4},"int32",{{{4,7,10},{-5,-2,1}},{{4,7,10},{-5,-2,1}}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3}),1),{1,2,1,3}) end),"case 355: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3}),1),{2,0,3}) end),"case 356: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3}),1),{0,2,3})}
assert(#results==1,"case 357: result count")
check(results[1],{0,2,3},{0,-12,4},"int32",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3})),{}) end),"case 358: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3})),{0}) end),"case 359: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3})),{1}) end),"case 360: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3})),{3}) end),"case 361: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3})),{2}) end),"case 362: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3})),{0,1}) end),"case 363: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3})),{1,0}) end),"case 364: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3})),{1,3}) end),"case 365: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3})),{3,1}) end),"case 366: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3})),{2,3}) end),"case 367: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3})),{0,3}) end),"case 368: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3})),{1,0,3}) end),"case 369: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3})),{2,1,3}) end),"case 370: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3})),{2,2,3}) end),"case 371: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3})),{1,2,1,3}) end),"case 372: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3})),{2,0,3}) end),"case 373: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,3})),{0,2,3}) end),"case 374: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3}),{}) end),"case 375: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3}),{0}) end),"case 376: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3}),{1}) end),"case 377: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3}),{3}) end),"case 378: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3}),{2}) end),"case 379: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3}),{0,1}) end),"case 380: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3}),{1,0}) end),"case 381: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3}),{1,3}) end),"case 382: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3}),{3,1}) end),"case 383: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3}),{2,3}) end),"case 384: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3}),{0,3}) end),"case 385: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3}),{1,0,3}) end),"case 386: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3}),{2,1,3})}
assert(#results==1,"case 387: result count")
check(results[1],{2,1,3},{12,0,4},"int32",{{{-5,-2,1}},{{4,7,10}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3}),{2,2,3})}
assert(#results==1,"case 388: result count")
check(results[1],{2,2,3},{12,0,4},"int32",{{{-5,-2,1},{-5,-2,1}},{{4,7,10},{4,7,10}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3}),{1,2,1,3})}
assert(#results==1,"case 389: result count")
check(results[1],{1,2,1,3},{0,12,0,4},"int32",{{{{-5,-2,1}},{{4,7,10}}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3}),{2,0,3})}
assert(#results==1,"case 390: result count")
check(results[1],{2,0,3},{12,0,4},"int32",{{},{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3}),{0,2,3}) end),"case 391: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3}),1),{}) end),"case 392: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3}),1),{0}) end),"case 393: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3}),1),{1}) end),"case 394: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3}),1),{3}) end),"case 395: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3}),1),{2}) end),"case 396: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3}),1),{0,1}) end),"case 397: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3}),1),{1,0}) end),"case 398: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3}),1),{1,3}) end),"case 399: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3}),1),{3,1}) end),"case 400: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3}),1),{2,3}) end),"case 401: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3}),1),{0,3}) end),"case 402: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3}),1),{1,0,3}) end),"case 403: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3}),1),{2,1,3})}
assert(#results==1,"case 404: result count")
check(results[1],{2,1,3},{-12,0,4},"int32",{{{4,7,10}},{{-5,-2,1}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3}),1),{2,2,3})}
assert(#results==1,"case 405: result count")
check(results[1],{2,2,3},{-12,0,4},"int32",{{{4,7,10},{4,7,10}},{{-5,-2,1},{-5,-2,1}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3}),1),{1,2,1,3})}
assert(#results==1,"case 406: result count")
check(results[1],{1,2,1,3},{0,-12,0,4},"int32",{{{{4,7,10}},{{-5,-2,1}}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3}),1),{2,0,3})}
assert(#results==1,"case 407: result count")
check(results[1],{2,0,3},{-12,0,4},"int32",{{},{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3}),1),{0,2,3}) end),"case 408: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3})),{}) end),"case 409: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3})),{0}) end),"case 410: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3})),{1}) end),"case 411: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3})),{3}) end),"case 412: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3})),{2}) end),"case 413: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3})),{0,1}) end),"case 414: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3})),{1,0}) end),"case 415: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3})),{1,3}) end),"case 416: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3})),{3,1}) end),"case 417: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3})),{2,3}) end),"case 418: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3})),{0,3}) end),"case 419: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3})),{1,0,3}) end),"case 420: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3})),{2,1,3}) end),"case 421: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3})),{2,2,3}) end),"case 422: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3})),{1,2,1,3}) end),"case 423: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3})),{2,0,3}) end),"case 424: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10},"int32"),{2,1,3})),{0,2,3}) end),"case 425: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2},"int32"),{1,2,1}),{}) end),"case 426: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2},"int32"),{1,2,1}),{0}) end),"case 427: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2},"int32"),{1,2,1}),{1}) end),"case 428: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2},"int32"),{1,2,1}),{3}) end),"case 429: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2},"int32"),{1,2,1}),{2}) end),"case 430: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2},"int32"),{1,2,1}),{0,1}) end),"case 431: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2},"int32"),{1,2,1}),{1,0}) end),"case 432: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2},"int32"),{1,2,1}),{1,3}) end),"case 433: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2},"int32"),{1,2,1}),{3,1}) end),"case 434: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2},"int32"),{1,2,1}),{2,3}) end),"case 435: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2},"int32"),{1,2,1}),{0,3}) end),"case 436: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2},"int32"),{1,2,1}),{1,0,3}) end),"case 437: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2},"int32"),{1,2,1}),{2,1,3}) end),"case 438: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5,-2},"int32"),{1,2,1}),{2,2,3})}
assert(#results==1,"case 439: result count")
check(results[1],{2,2,3},{0,4,0},"int32",{{{-5,-5,-5},{-2,-2,-2}},{{-5,-5,-5},{-2,-2,-2}}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2},"int32"),{1,2,1}),{1,2,1,3}) end),"case 440: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2},"int32"),{1,2,1}),{2,0,3}) end),"case 441: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5,-2},"int32"),{1,2,1}),{0,2,3})}
assert(#results==1,"case 442: result count")
check(results[1],{0,2,3},{0,4,0},"int32",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2},"int32"),{1,2,1}),1),{}) end),"case 443: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2},"int32"),{1,2,1}),1),{0}) end),"case 444: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2},"int32"),{1,2,1}),1),{1}) end),"case 445: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2},"int32"),{1,2,1}),1),{3}) end),"case 446: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2},"int32"),{1,2,1}),1),{2}) end),"case 447: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2},"int32"),{1,2,1}),1),{0,1}) end),"case 448: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2},"int32"),{1,2,1}),1),{1,0}) end),"case 449: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2},"int32"),{1,2,1}),1),{1,3}) end),"case 450: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2},"int32"),{1,2,1}),1),{3,1}) end),"case 451: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2},"int32"),{1,2,1}),1),{2,3}) end),"case 452: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2},"int32"),{1,2,1}),1),{0,3}) end),"case 453: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2},"int32"),{1,2,1}),1),{1,0,3}) end),"case 454: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2},"int32"),{1,2,1}),1),{2,1,3}) end),"case 455: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5,-2},"int32"),{1,2,1}),1),{2,2,3})}
assert(#results==1,"case 456: result count")
check(results[1],{2,2,3},{0,4,0},"int32",{{{-5,-5,-5},{-2,-2,-2}},{{-5,-5,-5},{-2,-2,-2}}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2},"int32"),{1,2,1}),1),{1,2,1,3}) end),"case 457: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2},"int32"),{1,2,1}),1),{2,0,3}) end),"case 458: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5,-2},"int32"),{1,2,1}),1),{0,2,3})}
assert(#results==1,"case 459: result count")
check(results[1],{0,2,3},{0,4,0},"int32",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2},"int32"),{1,2,1})),{}) end),"case 460: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2},"int32"),{1,2,1})),{0}) end),"case 461: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2},"int32"),{1,2,1})),{1}) end),"case 462: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2},"int32"),{1,2,1})),{3}) end),"case 463: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2},"int32"),{1,2,1})),{2}) end),"case 464: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2},"int32"),{1,2,1})),{0,1}) end),"case 465: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2},"int32"),{1,2,1})),{1,0}) end),"case 466: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2},"int32"),{1,2,1})),{1,3}) end),"case 467: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2},"int32"),{1,2,1})),{3,1}) end),"case 468: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2},"int32"),{1,2,1})),{2,3}) end),"case 469: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2},"int32"),{1,2,1})),{0,3}) end),"case 470: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2},"int32"),{1,2,1})),{1,0,3}) end),"case 471: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2},"int32"),{1,2,1})),{2,1,3}) end),"case 472: expected rejection")
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2},"int32"),{1,2,1})),{2,2,3})}
assert(#results==1,"case 473: result count")
check(results[1],{2,2,3},{0,4,0},"int32",{{{-5,-5,-5},{-2,-2,-2}},{{-5,-5,-5},{-2,-2,-2}}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2},"int32"),{1,2,1})),{1,2,1,3}) end),"case 474: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2},"int32"),{1,2,1})),{2,0,3}) end),"case 475: expected rejection")
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2},"int32"),{1,2,1})),{0,2,3})}
assert(#results==1,"case 476: result count")
check(results[1],{0,2,3},{0,4,0},"int32",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3}),{}) end),"case 477: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3}),{0}) end),"case 478: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3}),{1}) end),"case 479: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3}),{3}) end),"case 480: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3}),{2}) end),"case 481: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3}),{0,1}) end),"case 482: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3}),{1,0}) end),"case 483: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3}),{1,3}) end),"case 484: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3}),{3,1}) end),"case 485: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3}),{2,3}) end),"case 486: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3}),{0,3}) end),"case 487: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3}),{1,0,3}) end),"case 488: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3}),{2,1,3}) end),"case 489: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3}),{2,2,3})}
assert(#results==1,"case 490: result count")
check(results[1],{2,2,3},{24,12,4},"int32",{{{-5,-2,1},{4,7,10}},{{13,16,19},{22,25,28}}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3}),{1,2,1,3}) end),"case 491: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3}),{2,0,3}) end),"case 492: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3}),{0,2,3}) end),"case 493: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3}),1),{}) end),"case 494: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3}),1),{0}) end),"case 495: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3}),1),{1}) end),"case 496: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3}),1),{3}) end),"case 497: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3}),1),{2}) end),"case 498: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3}),1),{0,1}) end),"case 499: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3}),1),{1,0}) end),"case 500: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3}),1),{1,3}) end),"case 501: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3}),1),{3,1}) end),"case 502: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3}),1),{2,3}) end),"case 503: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3}),1),{0,3}) end),"case 504: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3}),1),{1,0,3}) end),"case 505: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3}),1),{2,1,3}) end),"case 506: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3}),1),{2,2,3})}
assert(#results==1,"case 507: result count")
check(results[1],{2,2,3},{-24,12,4},"int32",{{{13,16,19},{22,25,28}},{{-5,-2,1},{4,7,10}}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3}),1),{1,2,1,3}) end),"case 508: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3}),1),{2,0,3}) end),"case 509: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3}),1),{0,2,3}) end),"case 510: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3})),{}) end),"case 511: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3})),{0}) end),"case 512: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3})),{1}) end),"case 513: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3})),{3}) end),"case 514: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3})),{2}) end),"case 515: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3})),{0,1}) end),"case 516: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3})),{1,0}) end),"case 517: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3})),{1,3}) end),"case 518: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3})),{3,1}) end),"case 519: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3})),{2,3}) end),"case 520: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3})),{0,3}) end),"case 521: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3})),{1,0,3}) end),"case 522: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3})),{2,1,3}) end),"case 523: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3})),{2,2,3}) end),"case 524: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3})),{1,2,1,3}) end),"case 525: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3})),{2,0,3}) end),"case 526: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-5,-2,1,4,7,10,13,16,19,22,25,28},"int32"),{2,2,3})),{0,2,3}) end),"case 527: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0,1,3}),{}) end),"case 528: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0,1,3}),{0}) end),"case 529: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0,1,3}),{1}) end),"case 530: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0,1,3}),{3}) end),"case 531: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0,1,3}),{2}) end),"case 532: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0,1,3}),{0,1}) end),"case 533: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0,1,3}),{1,0}) end),"case 534: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0,1,3}),{1,3}) end),"case 535: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0,1,3}),{3,1}) end),"case 536: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0,1,3}),{2,3}) end),"case 537: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0,1,3}),{0,3}) end),"case 538: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0,1,3}),{1,0,3}) end),"case 539: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0,1,3}),{2,1,3}) end),"case 540: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0,1,3}),{2,2,3}) end),"case 541: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0,1,3}),{1,2,1,3}) end),"case 542: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"int32"),{0,1,3}),{2,0,3}) end),"case 543: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({},"int32"),{0,1,3}),{0,2,3})}
assert(#results==1,"case 544: result count")
check(results[1],{0,2,3},{12,0,4},"int32",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0,1,3}),1),{}) end),"case 545: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0,1,3}),1),{0}) end),"case 546: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0,1,3}),1),{1}) end),"case 547: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0,1,3}),1),{3}) end),"case 548: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0,1,3}),1),{2}) end),"case 549: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0,1,3}),1),{0,1}) end),"case 550: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0,1,3}),1),{1,0}) end),"case 551: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0,1,3}),1),{1,3}) end),"case 552: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0,1,3}),1),{3,1}) end),"case 553: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0,1,3}),1),{2,3}) end),"case 554: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0,1,3}),1),{0,3}) end),"case 555: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0,1,3}),1),{1,0,3}) end),"case 556: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0,1,3}),1),{2,1,3}) end),"case 557: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0,1,3}),1),{2,2,3}) end),"case 558: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0,1,3}),1),{1,2,1,3}) end),"case 559: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0,1,3}),1),{2,0,3}) end),"case 560: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({},"int32"),{0,1,3}),1),{0,2,3})}
assert(#results==1,"case 561: result count")
check(results[1],{0,2,3},{12,0,4},"int32",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{0,1,3})),{}) end),"case 562: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{0,1,3})),{0}) end),"case 563: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{0,1,3})),{1}) end),"case 564: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{0,1,3})),{3}) end),"case 565: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{0,1,3})),{2}) end),"case 566: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{0,1,3})),{0,1}) end),"case 567: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{0,1,3})),{1,0}) end),"case 568: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{0,1,3})),{1,3}) end),"case 569: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{0,1,3})),{3,1}) end),"case 570: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{0,1,3})),{2,3}) end),"case 571: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{0,1,3})),{0,3}) end),"case 572: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{0,1,3})),{1,0,3}) end),"case 573: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{0,1,3})),{2,1,3}) end),"case 574: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{0,1,3})),{2,2,3}) end),"case 575: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{0,1,3})),{1,2,1,3}) end),"case 576: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{0,1,3})),{2,0,3}) end),"case 577: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"int32"),{0,1,3})),{0,2,3}) end),"case 578: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0},"float64"),{}),{})}
assert(#results==1,"case 579: result count")
check(results[1],{},{},"float64",-4.0)
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0},"float64"),{}),{0})}
assert(#results==1,"case 580: result count")
check(results[1],{0},{0},"float64",{})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0},"float64"),{}),{1})}
assert(#results==1,"case 581: result count")
check(results[1],{1},{0},"float64",{-4.0})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0},"float64"),{}),{3})}
assert(#results==1,"case 582: result count")
check(results[1],{3},{0},"float64",{-4.0,-4.0,-4.0})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0},"float64"),{}),{2})}
assert(#results==1,"case 583: result count")
check(results[1],{2},{0},"float64",{-4.0,-4.0})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0},"float64"),{}),{0,1})}
assert(#results==1,"case 584: result count")
check(results[1],{0,1},{0,0},"float64",{})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0},"float64"),{}),{1,0})}
assert(#results==1,"case 585: result count")
check(results[1],{1,0},{0,0},"float64",{{}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0},"float64"),{}),{1,3})}
assert(#results==1,"case 586: result count")
check(results[1],{1,3},{0,0},"float64",{{-4.0,-4.0,-4.0}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0},"float64"),{}),{3,1})}
assert(#results==1,"case 587: result count")
check(results[1],{3,1},{0,0},"float64",{{-4.0},{-4.0},{-4.0}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0},"float64"),{}),{2,3})}
assert(#results==1,"case 588: result count")
check(results[1],{2,3},{0,0},"float64",{{-4.0,-4.0,-4.0},{-4.0,-4.0,-4.0}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0},"float64"),{}),{0,3})}
assert(#results==1,"case 589: result count")
check(results[1],{0,3},{0,0},"float64",{})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0},"float64"),{}),{1,0,3})}
assert(#results==1,"case 590: result count")
check(results[1],{1,0,3},{0,0,0},"float64",{{}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0},"float64"),{}),{2,1,3})}
assert(#results==1,"case 591: result count")
check(results[1],{2,1,3},{0,0,0},"float64",{{{-4.0,-4.0,-4.0}},{{-4.0,-4.0,-4.0}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0},"float64"),{}),{2,2,3})}
assert(#results==1,"case 592: result count")
check(results[1],{2,2,3},{0,0,0},"float64",{{{-4.0,-4.0,-4.0},{-4.0,-4.0,-4.0}},{{-4.0,-4.0,-4.0},{-4.0,-4.0,-4.0}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0},"float64"),{}),{1,2,1,3})}
assert(#results==1,"case 593: result count")
check(results[1],{1,2,1,3},{0,0,0,0},"float64",{{{{-4.0,-4.0,-4.0}},{{-4.0,-4.0,-4.0}}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0},"float64"),{}),{2,0,3})}
assert(#results==1,"case 594: result count")
check(results[1],{2,0,3},{0,0,0},"float64",{{},{}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0},"float64"),{}),{0,2,3})}
assert(#results==1,"case 595: result count")
check(results[1],{0,2,3},{0,0,0},"float64",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0}),{}) end),"case 596: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({},"float64"),{0}),{0})}
assert(#results==1,"case 597: result count")
check(results[1],{0},{0},"float64",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0}),{1}) end),"case 598: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0}),{3}) end),"case 599: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0}),{2}) end),"case 600: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0}),{0,1}) end),"case 601: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({},"float64"),{0}),{1,0})}
assert(#results==1,"case 602: result count")
check(results[1],{1,0},{0,0},"float64",{{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0}),{1,3}) end),"case 603: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0}),{3,1}) end),"case 604: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0}),{2,3}) end),"case 605: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0}),{0,3}) end),"case 606: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0}),{1,0,3}) end),"case 607: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0}),{2,1,3}) end),"case 608: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0}),{2,2,3}) end),"case 609: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0}),{1,2,1,3}) end),"case 610: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0}),{2,0,3}) end),"case 611: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0}),{0,2,3}) end),"case 612: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0}),1),{}) end),"case 613: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0}),1),{0})}
assert(#results==1,"case 614: result count")
check(results[1],{0},{0},"float64",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0}),1),{1}) end),"case 615: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0}),1),{3}) end),"case 616: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0}),1),{2}) end),"case 617: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0}),1),{0,1}) end),"case 618: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0}),1),{1,0})}
assert(#results==1,"case 619: result count")
check(results[1],{1,0},{0,0},"float64",{{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0}),1),{1,3}) end),"case 620: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0}),1),{3,1}) end),"case 621: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0}),1),{2,3}) end),"case 622: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0}),1),{0,3}) end),"case 623: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0}),1),{1,0,3}) end),"case 624: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0}),1),{2,1,3}) end),"case 625: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0}),1),{2,2,3}) end),"case 626: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0}),1),{1,2,1,3}) end),"case 627: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0}),1),{2,0,3}) end),"case 628: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0}),1),{0,2,3}) end),"case 629: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0},"float64"),{1}),{}) end),"case 630: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0},"float64"),{1}),{0})}
assert(#results==1,"case 631: result count")
check(results[1],{0},{0},"float64",{})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0},"float64"),{1}),{1})}
assert(#results==1,"case 632: result count")
check(results[1],{1},{0},"float64",{-4.0})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0},"float64"),{1}),{3})}
assert(#results==1,"case 633: result count")
check(results[1],{3},{0},"float64",{-4.0,-4.0,-4.0})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0},"float64"),{1}),{2})}
assert(#results==1,"case 634: result count")
check(results[1],{2},{0},"float64",{-4.0,-4.0})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0},"float64"),{1}),{0,1})}
assert(#results==1,"case 635: result count")
check(results[1],{0,1},{0,0},"float64",{})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0},"float64"),{1}),{1,0})}
assert(#results==1,"case 636: result count")
check(results[1],{1,0},{0,0},"float64",{{}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0},"float64"),{1}),{1,3})}
assert(#results==1,"case 637: result count")
check(results[1],{1,3},{0,0},"float64",{{-4.0,-4.0,-4.0}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0},"float64"),{1}),{3,1})}
assert(#results==1,"case 638: result count")
check(results[1],{3,1},{0,0},"float64",{{-4.0},{-4.0},{-4.0}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0},"float64"),{1}),{2,3})}
assert(#results==1,"case 639: result count")
check(results[1],{2,3},{0,0},"float64",{{-4.0,-4.0,-4.0},{-4.0,-4.0,-4.0}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0},"float64"),{1}),{0,3})}
assert(#results==1,"case 640: result count")
check(results[1],{0,3},{0,0},"float64",{})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0},"float64"),{1}),{1,0,3})}
assert(#results==1,"case 641: result count")
check(results[1],{1,0,3},{0,0,0},"float64",{{}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0},"float64"),{1}),{2,1,3})}
assert(#results==1,"case 642: result count")
check(results[1],{2,1,3},{0,0,0},"float64",{{{-4.0,-4.0,-4.0}},{{-4.0,-4.0,-4.0}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0},"float64"),{1}),{2,2,3})}
assert(#results==1,"case 643: result count")
check(results[1],{2,2,3},{0,0,0},"float64",{{{-4.0,-4.0,-4.0},{-4.0,-4.0,-4.0}},{{-4.0,-4.0,-4.0},{-4.0,-4.0,-4.0}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0},"float64"),{1}),{1,2,1,3})}
assert(#results==1,"case 644: result count")
check(results[1],{1,2,1,3},{0,0,0,0},"float64",{{{{-4.0,-4.0,-4.0}},{{-4.0,-4.0,-4.0}}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0},"float64"),{1}),{2,0,3})}
assert(#results==1,"case 645: result count")
check(results[1],{2,0,3},{0,0,0},"float64",{{},{}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0},"float64"),{1}),{0,2,3})}
assert(#results==1,"case 646: result count")
check(results[1],{0,2,3},{0,0,0},"float64",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0},"float64"),{1}),1),{}) end),"case 647: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0},"float64"),{1}),1),{0})}
assert(#results==1,"case 648: result count")
check(results[1],{0},{0},"float64",{})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0},"float64"),{1}),1),{1})}
assert(#results==1,"case 649: result count")
check(results[1],{1},{0},"float64",{-4.0})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0},"float64"),{1}),1),{3})}
assert(#results==1,"case 650: result count")
check(results[1],{3},{0},"float64",{-4.0,-4.0,-4.0})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0},"float64"),{1}),1),{2})}
assert(#results==1,"case 651: result count")
check(results[1],{2},{0},"float64",{-4.0,-4.0})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0},"float64"),{1}),1),{0,1})}
assert(#results==1,"case 652: result count")
check(results[1],{0,1},{0,0},"float64",{})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0},"float64"),{1}),1),{1,0})}
assert(#results==1,"case 653: result count")
check(results[1],{1,0},{0,0},"float64",{{}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0},"float64"),{1}),1),{1,3})}
assert(#results==1,"case 654: result count")
check(results[1],{1,3},{0,0},"float64",{{-4.0,-4.0,-4.0}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0},"float64"),{1}),1),{3,1})}
assert(#results==1,"case 655: result count")
check(results[1],{3,1},{0,0},"float64",{{-4.0},{-4.0},{-4.0}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0},"float64"),{1}),1),{2,3})}
assert(#results==1,"case 656: result count")
check(results[1],{2,3},{0,0},"float64",{{-4.0,-4.0,-4.0},{-4.0,-4.0,-4.0}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0},"float64"),{1}),1),{0,3})}
assert(#results==1,"case 657: result count")
check(results[1],{0,3},{0,0},"float64",{})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0},"float64"),{1}),1),{1,0,3})}
assert(#results==1,"case 658: result count")
check(results[1],{1,0,3},{0,0,0},"float64",{{}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0},"float64"),{1}),1),{2,1,3})}
assert(#results==1,"case 659: result count")
check(results[1],{2,1,3},{0,0,0},"float64",{{{-4.0,-4.0,-4.0}},{{-4.0,-4.0,-4.0}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0},"float64"),{1}),1),{2,2,3})}
assert(#results==1,"case 660: result count")
check(results[1],{2,2,3},{0,0,0},"float64",{{{-4.0,-4.0,-4.0},{-4.0,-4.0,-4.0}},{{-4.0,-4.0,-4.0},{-4.0,-4.0,-4.0}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0},"float64"),{1}),1),{1,2,1,3})}
assert(#results==1,"case 661: result count")
check(results[1],{1,2,1,3},{0,0,0,0},"float64",{{{{-4.0,-4.0,-4.0}},{{-4.0,-4.0,-4.0}}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0},"float64"),{1}),1),{2,0,3})}
assert(#results==1,"case 662: result count")
check(results[1],{2,0,3},{0,0,0},"float64",{{},{}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0},"float64"),{1}),1),{0,2,3})}
assert(#results==1,"case 663: result count")
check(results[1],{0,2,3},{0,0,0},"float64",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3}),{}) end),"case 664: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3}),{0}) end),"case 665: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3}),{1}) end),"case 666: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3}),{3})}
assert(#results==1,"case 667: result count")
check(results[1],{3},{8},"float64",{-4.0,-2.75,-1.5})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3}),{2}) end),"case 668: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3}),{0,1}) end),"case 669: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3}),{1,0}) end),"case 670: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3}),{1,3})}
assert(#results==1,"case 671: result count")
check(results[1],{1,3},{0,8},"float64",{{-4.0,-2.75,-1.5}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3}),{3,1}) end),"case 672: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3}),{2,3})}
assert(#results==1,"case 673: result count")
check(results[1],{2,3},{0,8},"float64",{{-4.0,-2.75,-1.5},{-4.0,-2.75,-1.5}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3}),{0,3})}
assert(#results==1,"case 674: result count")
check(results[1],{0,3},{0,8},"float64",{})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3}),{1,0,3})}
assert(#results==1,"case 675: result count")
check(results[1],{1,0,3},{0,0,8},"float64",{{}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3}),{2,1,3})}
assert(#results==1,"case 676: result count")
check(results[1],{2,1,3},{0,0,8},"float64",{{{-4.0,-2.75,-1.5}},{{-4.0,-2.75,-1.5}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3}),{2,2,3})}
assert(#results==1,"case 677: result count")
check(results[1],{2,2,3},{0,0,8},"float64",{{{-4.0,-2.75,-1.5},{-4.0,-2.75,-1.5}},{{-4.0,-2.75,-1.5},{-4.0,-2.75,-1.5}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3}),{1,2,1,3})}
assert(#results==1,"case 678: result count")
check(results[1],{1,2,1,3},{0,0,0,8},"float64",{{{{-4.0,-2.75,-1.5}},{{-4.0,-2.75,-1.5}}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3}),{2,0,3})}
assert(#results==1,"case 679: result count")
check(results[1],{2,0,3},{0,0,8},"float64",{{},{}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3}),{0,2,3})}
assert(#results==1,"case 680: result count")
check(results[1],{0,2,3},{0,0,8},"float64",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3}),1),{}) end),"case 681: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3}),1),{0}) end),"case 682: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3}),1),{1}) end),"case 683: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3}),1),{3})}
assert(#results==1,"case 684: result count")
check(results[1],{3},{-8},"float64",{-1.5,-2.75,-4.0})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3}),1),{2}) end),"case 685: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3}),1),{0,1}) end),"case 686: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3}),1),{1,0}) end),"case 687: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3}),1),{1,3})}
assert(#results==1,"case 688: result count")
check(results[1],{1,3},{0,-8},"float64",{{-1.5,-2.75,-4.0}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3}),1),{3,1}) end),"case 689: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3}),1),{2,3})}
assert(#results==1,"case 690: result count")
check(results[1],{2,3},{0,-8},"float64",{{-1.5,-2.75,-4.0},{-1.5,-2.75,-4.0}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3}),1),{0,3})}
assert(#results==1,"case 691: result count")
check(results[1],{0,3},{0,-8},"float64",{})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3}),1),{1,0,3})}
assert(#results==1,"case 692: result count")
check(results[1],{1,0,3},{0,0,-8},"float64",{{}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3}),1),{2,1,3})}
assert(#results==1,"case 693: result count")
check(results[1],{2,1,3},{0,0,-8},"float64",{{{-1.5,-2.75,-4.0}},{{-1.5,-2.75,-4.0}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3}),1),{2,2,3})}
assert(#results==1,"case 694: result count")
check(results[1],{2,2,3},{0,0,-8},"float64",{{{-1.5,-2.75,-4.0},{-1.5,-2.75,-4.0}},{{-1.5,-2.75,-4.0},{-1.5,-2.75,-4.0}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3}),1),{1,2,1,3})}
assert(#results==1,"case 695: result count")
check(results[1],{1,2,1,3},{0,0,0,-8},"float64",{{{{-1.5,-2.75,-4.0}},{{-1.5,-2.75,-4.0}}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3}),1),{2,0,3})}
assert(#results==1,"case 696: result count")
check(results[1],{2,0,3},{0,0,-8},"float64",{{},{}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3}),1),{0,2,3})}
assert(#results==1,"case 697: result count")
check(results[1],{0,2,3},{0,0,-8},"float64",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0,1}),{}) end),"case 698: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0,1}),{0}) end),"case 699: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0,1}),{1}) end),"case 700: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0,1}),{3}) end),"case 701: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0,1}),{2}) end),"case 702: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({},"float64"),{0,1}),{0,1})}
assert(#results==1,"case 703: result count")
check(results[1],{0,1},{8,0},"float64",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0,1}),{1,0}) end),"case 704: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0,1}),{1,3}) end),"case 705: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0,1}),{3,1}) end),"case 706: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0,1}),{2,3}) end),"case 707: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({},"float64"),{0,1}),{0,3})}
assert(#results==1,"case 708: result count")
check(results[1],{0,3},{8,0},"float64",{})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({},"float64"),{0,1}),{1,0,3})}
assert(#results==1,"case 709: result count")
check(results[1],{1,0,3},{0,8,0},"float64",{{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0,1}),{2,1,3}) end),"case 710: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0,1}),{2,2,3}) end),"case 711: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0,1}),{1,2,1,3}) end),"case 712: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({},"float64"),{0,1}),{2,0,3})}
assert(#results==1,"case 713: result count")
check(results[1],{2,0,3},{0,8,0},"float64",{{},{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0,1}),{0,2,3}) end),"case 714: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0,1}),1),{}) end),"case 715: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0,1}),1),{0}) end),"case 716: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0,1}),1),{1}) end),"case 717: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0,1}),1),{3}) end),"case 718: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0,1}),1),{2}) end),"case 719: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0,1}),1),{0,1})}
assert(#results==1,"case 720: result count")
check(results[1],{0,1},{8,0},"float64",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0,1}),1),{1,0}) end),"case 721: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0,1}),1),{1,3}) end),"case 722: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0,1}),1),{3,1}) end),"case 723: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0,1}),1),{2,3}) end),"case 724: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0,1}),1),{0,3})}
assert(#results==1,"case 725: result count")
check(results[1],{0,3},{8,0},"float64",{})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0,1}),1),{1,0,3})}
assert(#results==1,"case 726: result count")
check(results[1],{1,0,3},{0,8,0},"float64",{{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0,1}),1),{2,1,3}) end),"case 727: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0,1}),1),{2,2,3}) end),"case 728: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0,1}),1),{1,2,1,3}) end),"case 729: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0,1}),1),{2,0,3})}
assert(#results==1,"case 730: result count")
check(results[1],{2,0,3},{0,8,0},"float64",{{},{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0,1}),1),{0,2,3}) end),"case 731: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{0,1})),{}) end),"case 732: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{0,1})),{0}) end),"case 733: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{0,1})),{1}) end),"case 734: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{0,1})),{3}) end),"case 735: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{0,1})),{2}) end),"case 736: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{0,1})),{0,1}) end),"case 737: expected rejection")
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{0,1})),{1,0})}
assert(#results==1,"case 738: result count")
check(results[1],{1,0},{0,8},"float64",{{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{0,1})),{1,3}) end),"case 739: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{0,1})),{3,1}) end),"case 740: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{0,1})),{2,3}) end),"case 741: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{0,1})),{0,3}) end),"case 742: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{0,1})),{1,0,3}) end),"case 743: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{0,1})),{2,1,3}) end),"case 744: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{0,1})),{2,2,3}) end),"case 745: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{0,1})),{1,2,1,3}) end),"case 746: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{0,1})),{2,0,3}) end),"case 747: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{0,1})),{0,2,3}) end),"case 748: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{1,0}),{}) end),"case 749: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{1,0}),{0}) end),"case 750: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{1,0}),{1}) end),"case 751: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{1,0}),{3}) end),"case 752: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{1,0}),{2}) end),"case 753: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{1,0}),{0,1}) end),"case 754: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({},"float64"),{1,0}),{1,0})}
assert(#results==1,"case 755: result count")
check(results[1],{1,0},{0,8},"float64",{{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{1,0}),{1,3}) end),"case 756: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{1,0}),{3,1}) end),"case 757: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{1,0}),{2,3}) end),"case 758: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{1,0}),{0,3}) end),"case 759: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{1,0}),{1,0,3}) end),"case 760: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{1,0}),{2,1,3}) end),"case 761: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{1,0}),{2,2,3}) end),"case 762: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{1,0}),{1,2,1,3}) end),"case 763: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{1,0}),{2,0,3}) end),"case 764: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{1,0}),{0,2,3}) end),"case 765: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{1,0}),1),{}) end),"case 766: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{1,0}),1),{0}) end),"case 767: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{1,0}),1),{1}) end),"case 768: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{1,0}),1),{3}) end),"case 769: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{1,0}),1),{2}) end),"case 770: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{1,0}),1),{0,1}) end),"case 771: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{1,0}),1),{1,0})}
assert(#results==1,"case 772: result count")
check(results[1],{1,0},{0,8},"float64",{{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{1,0}),1),{1,3}) end),"case 773: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{1,0}),1),{3,1}) end),"case 774: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{1,0}),1),{2,3}) end),"case 775: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{1,0}),1),{0,3}) end),"case 776: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{1,0}),1),{1,0,3}) end),"case 777: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{1,0}),1),{2,1,3}) end),"case 778: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{1,0}),1),{2,2,3}) end),"case 779: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{1,0}),1),{1,2,1,3}) end),"case 780: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{1,0}),1),{2,0,3}) end),"case 781: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{1,0}),1),{0,2,3}) end),"case 782: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{1,0})),{}) end),"case 783: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{1,0})),{0}) end),"case 784: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{1,0})),{1}) end),"case 785: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{1,0})),{3}) end),"case 786: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{1,0})),{2}) end),"case 787: expected rejection")
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{1,0})),{0,1})}
assert(#results==1,"case 788: result count")
check(results[1],{0,1},{8,0},"float64",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{1,0})),{1,0}) end),"case 789: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{1,0})),{1,3}) end),"case 790: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{1,0})),{3,1}) end),"case 791: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{1,0})),{2,3}) end),"case 792: expected rejection")
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{1,0})),{0,3})}
assert(#results==1,"case 793: result count")
check(results[1],{0,3},{8,0},"float64",{})
end
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{1,0})),{1,0,3})}
assert(#results==1,"case 794: result count")
check(results[1],{1,0,3},{0,8,0},"float64",{{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{1,0})),{2,1,3}) end),"case 795: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{1,0})),{2,2,3}) end),"case 796: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{1,0})),{1,2,1,3}) end),"case 797: expected rejection")
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{1,0})),{2,0,3})}
assert(#results==1,"case 798: result count")
check(results[1],{2,0,3},{0,8,0},"float64",{{},{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{1,0})),{0,2,3}) end),"case 799: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3}),{}) end),"case 800: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3}),{0}) end),"case 801: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3}),{1}) end),"case 802: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3}),{3}) end),"case 803: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3}),{2}) end),"case 804: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3}),{0,1}) end),"case 805: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3}),{1,0}) end),"case 806: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3}),{1,3})}
assert(#results==1,"case 807: result count")
check(results[1],{1,3},{0,8},"float64",{{-4.0,-2.75,-1.5}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3}),{3,1}) end),"case 808: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3}),{2,3})}
assert(#results==1,"case 809: result count")
check(results[1],{2,3},{0,8},"float64",{{-4.0,-2.75,-1.5},{-4.0,-2.75,-1.5}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3}),{0,3})}
assert(#results==1,"case 810: result count")
check(results[1],{0,3},{0,8},"float64",{})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3}),{1,0,3})}
assert(#results==1,"case 811: result count")
check(results[1],{1,0,3},{0,0,8},"float64",{{}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3}),{2,1,3})}
assert(#results==1,"case 812: result count")
check(results[1],{2,1,3},{0,0,8},"float64",{{{-4.0,-2.75,-1.5}},{{-4.0,-2.75,-1.5}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3}),{2,2,3})}
assert(#results==1,"case 813: result count")
check(results[1],{2,2,3},{0,0,8},"float64",{{{-4.0,-2.75,-1.5},{-4.0,-2.75,-1.5}},{{-4.0,-2.75,-1.5},{-4.0,-2.75,-1.5}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3}),{1,2,1,3})}
assert(#results==1,"case 814: result count")
check(results[1],{1,2,1,3},{0,0,0,8},"float64",{{{{-4.0,-2.75,-1.5}},{{-4.0,-2.75,-1.5}}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3}),{2,0,3})}
assert(#results==1,"case 815: result count")
check(results[1],{2,0,3},{0,0,8},"float64",{{},{}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3}),{0,2,3})}
assert(#results==1,"case 816: result count")
check(results[1],{0,2,3},{0,0,8},"float64",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3}),1),{}) end),"case 817: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3}),1),{0}) end),"case 818: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3}),1),{1}) end),"case 819: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3}),1),{3}) end),"case 820: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3}),1),{2}) end),"case 821: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3}),1),{0,1}) end),"case 822: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3}),1),{1,0}) end),"case 823: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3}),1),{1,3})}
assert(#results==1,"case 824: result count")
check(results[1],{1,3},{0,8},"float64",{{-4.0,-2.75,-1.5}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3}),1),{3,1}) end),"case 825: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3}),1),{2,3})}
assert(#results==1,"case 826: result count")
check(results[1],{2,3},{0,8},"float64",{{-4.0,-2.75,-1.5},{-4.0,-2.75,-1.5}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3}),1),{0,3})}
assert(#results==1,"case 827: result count")
check(results[1],{0,3},{0,8},"float64",{})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3}),1),{1,0,3})}
assert(#results==1,"case 828: result count")
check(results[1],{1,0,3},{0,0,8},"float64",{{}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3}),1),{2,1,3})}
assert(#results==1,"case 829: result count")
check(results[1],{2,1,3},{0,0,8},"float64",{{{-4.0,-2.75,-1.5}},{{-4.0,-2.75,-1.5}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3}),1),{2,2,3})}
assert(#results==1,"case 830: result count")
check(results[1],{2,2,3},{0,0,8},"float64",{{{-4.0,-2.75,-1.5},{-4.0,-2.75,-1.5}},{{-4.0,-2.75,-1.5},{-4.0,-2.75,-1.5}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3}),1),{1,2,1,3})}
assert(#results==1,"case 831: result count")
check(results[1],{1,2,1,3},{0,0,0,8},"float64",{{{{-4.0,-2.75,-1.5}},{{-4.0,-2.75,-1.5}}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3}),1),{2,0,3})}
assert(#results==1,"case 832: result count")
check(results[1],{2,0,3},{0,0,8},"float64",{{},{}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3}),1),{0,2,3})}
assert(#results==1,"case 833: result count")
check(results[1],{0,2,3},{0,0,8},"float64",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3})),{}) end),"case 834: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3})),{0}) end),"case 835: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3})),{1}) end),"case 836: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3})),{3}) end),"case 837: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3})),{2}) end),"case 838: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3})),{0,1}) end),"case 839: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3})),{1,0}) end),"case 840: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3})),{1,3}) end),"case 841: expected rejection")
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3})),{3,1})}
assert(#results==1,"case 842: result count")
check(results[1],{3,1},{8,0},"float64",{{-4.0},{-2.75},{-1.5}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3})),{2,3}) end),"case 843: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3})),{0,3}) end),"case 844: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3})),{1,0,3}) end),"case 845: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3})),{2,1,3}) end),"case 846: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3})),{2,2,3}) end),"case 847: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3})),{1,2,1,3}) end),"case 848: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3})),{2,0,3}) end),"case 849: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{1,3})),{0,2,3}) end),"case 850: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1}),{}) end),"case 851: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1}),{0}) end),"case 852: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1}),{1}) end),"case 853: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1}),{3}) end),"case 854: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1}),{2}) end),"case 855: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1}),{0,1}) end),"case 856: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1}),{1,0}) end),"case 857: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1}),{1,3}) end),"case 858: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1}),{3,1})}
assert(#results==1,"case 859: result count")
check(results[1],{3,1},{8,0},"float64",{{-4.0},{-2.75},{-1.5}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1}),{2,3}) end),"case 860: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1}),{0,3}) end),"case 861: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1}),{1,0,3}) end),"case 862: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1}),{2,1,3}) end),"case 863: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1}),{2,2,3}) end),"case 864: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1}),{1,2,1,3}) end),"case 865: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1}),{2,0,3}) end),"case 866: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1}),{0,2,3}) end),"case 867: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1}),1),{}) end),"case 868: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1}),1),{0}) end),"case 869: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1}),1),{1}) end),"case 870: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1}),1),{3}) end),"case 871: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1}),1),{2}) end),"case 872: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1}),1),{0,1}) end),"case 873: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1}),1),{1,0}) end),"case 874: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1}),1),{1,3}) end),"case 875: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1}),1),{3,1})}
assert(#results==1,"case 876: result count")
check(results[1],{3,1},{-8,0},"float64",{{-1.5},{-2.75},{-4.0}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1}),1),{2,3}) end),"case 877: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1}),1),{0,3}) end),"case 878: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1}),1),{1,0,3}) end),"case 879: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1}),1),{2,1,3}) end),"case 880: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1}),1),{2,2,3}) end),"case 881: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1}),1),{1,2,1,3}) end),"case 882: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1}),1),{2,0,3}) end),"case 883: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1}),1),{0,2,3}) end),"case 884: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1})),{}) end),"case 885: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1})),{0}) end),"case 886: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1})),{1}) end),"case 887: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1})),{3}) end),"case 888: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1})),{2}) end),"case 889: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1})),{0,1}) end),"case 890: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1})),{1,0}) end),"case 891: expected rejection")
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1})),{1,3})}
assert(#results==1,"case 892: result count")
check(results[1],{1,3},{0,8},"float64",{{-4.0,-2.75,-1.5}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1})),{3,1}) end),"case 893: expected rejection")
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1})),{2,3})}
assert(#results==1,"case 894: result count")
check(results[1],{2,3},{0,8},"float64",{{-4.0,-2.75,-1.5},{-4.0,-2.75,-1.5}})
end
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1})),{0,3})}
assert(#results==1,"case 895: result count")
check(results[1],{0,3},{0,8},"float64",{})
end
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1})),{1,0,3})}
assert(#results==1,"case 896: result count")
check(results[1],{1,0,3},{0,0,8},"float64",{{}})
end
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1})),{2,1,3})}
assert(#results==1,"case 897: result count")
check(results[1],{2,1,3},{0,0,8},"float64",{{{-4.0,-2.75,-1.5}},{{-4.0,-2.75,-1.5}}})
end
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1})),{2,2,3})}
assert(#results==1,"case 898: result count")
check(results[1],{2,2,3},{0,0,8},"float64",{{{-4.0,-2.75,-1.5},{-4.0,-2.75,-1.5}},{{-4.0,-2.75,-1.5},{-4.0,-2.75,-1.5}}})
end
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1})),{1,2,1,3})}
assert(#results==1,"case 899: result count")
check(results[1],{1,2,1,3},{0,0,0,8},"float64",{{{{-4.0,-2.75,-1.5}},{{-4.0,-2.75,-1.5}}}})
end
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1})),{2,0,3})}
assert(#results==1,"case 900: result count")
check(results[1],{2,0,3},{0,0,8},"float64",{{},{}})
end
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5},"float64"),{3,1})),{0,2,3})}
assert(#results==1,"case 901: result count")
check(results[1],{0,2,3},{0,0,8},"float64",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3}),{}) end),"case 902: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3}),{0}) end),"case 903: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3}),{1}) end),"case 904: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3}),{3}) end),"case 905: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3}),{2}) end),"case 906: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3}),{0,1}) end),"case 907: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3}),{1,0}) end),"case 908: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3}),{1,3}) end),"case 909: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3}),{3,1}) end),"case 910: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3}),{2,3})}
assert(#results==1,"case 911: result count")
check(results[1],{2,3},{24,8},"float64",{{-4.0,-2.75,-1.5},{-0.25,1.0,2.25}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3}),{0,3}) end),"case 912: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3}),{1,0,3}) end),"case 913: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3}),{2,1,3}) end),"case 914: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3}),{2,2,3})}
assert(#results==1,"case 915: result count")
check(results[1],{2,2,3},{0,24,8},"float64",{{{-4.0,-2.75,-1.5},{-0.25,1.0,2.25}},{{-4.0,-2.75,-1.5},{-0.25,1.0,2.25}}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3}),{1,2,1,3}) end),"case 916: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3}),{2,0,3}) end),"case 917: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3}),{0,2,3})}
assert(#results==1,"case 918: result count")
check(results[1],{0,2,3},{0,24,8},"float64",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3}),1),{}) end),"case 919: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3}),1),{0}) end),"case 920: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3}),1),{1}) end),"case 921: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3}),1),{3}) end),"case 922: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3}),1),{2}) end),"case 923: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3}),1),{0,1}) end),"case 924: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3}),1),{1,0}) end),"case 925: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3}),1),{1,3}) end),"case 926: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3}),1),{3,1}) end),"case 927: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3}),1),{2,3})}
assert(#results==1,"case 928: result count")
check(results[1],{2,3},{-24,8},"float64",{{-0.25,1.0,2.25},{-4.0,-2.75,-1.5}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3}),1),{0,3}) end),"case 929: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3}),1),{1,0,3}) end),"case 930: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3}),1),{2,1,3}) end),"case 931: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3}),1),{2,2,3})}
assert(#results==1,"case 932: result count")
check(results[1],{2,2,3},{0,-24,8},"float64",{{{-0.25,1.0,2.25},{-4.0,-2.75,-1.5}},{{-0.25,1.0,2.25},{-4.0,-2.75,-1.5}}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3}),1),{1,2,1,3}) end),"case 933: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3}),1),{2,0,3}) end),"case 934: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3}),1),{0,2,3})}
assert(#results==1,"case 935: result count")
check(results[1],{0,2,3},{0,-24,8},"float64",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3})),{}) end),"case 936: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3})),{0}) end),"case 937: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3})),{1}) end),"case 938: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3})),{3}) end),"case 939: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3})),{2}) end),"case 940: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3})),{0,1}) end),"case 941: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3})),{1,0}) end),"case 942: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3})),{1,3}) end),"case 943: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3})),{3,1}) end),"case 944: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3})),{2,3}) end),"case 945: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3})),{0,3}) end),"case 946: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3})),{1,0,3}) end),"case 947: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3})),{2,1,3}) end),"case 948: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3})),{2,2,3}) end),"case 949: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3})),{1,2,1,3}) end),"case 950: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3})),{2,0,3}) end),"case 951: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,3})),{0,2,3}) end),"case 952: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3}),{}) end),"case 953: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3}),{0}) end),"case 954: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3}),{1}) end),"case 955: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3}),{3}) end),"case 956: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3}),{2}) end),"case 957: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3}),{0,1}) end),"case 958: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3}),{1,0}) end),"case 959: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3}),{1,3}) end),"case 960: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3}),{3,1}) end),"case 961: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3}),{2,3}) end),"case 962: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3}),{0,3}) end),"case 963: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3}),{1,0,3}) end),"case 964: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3}),{2,1,3})}
assert(#results==1,"case 965: result count")
check(results[1],{2,1,3},{24,0,8},"float64",{{{-4.0,-2.75,-1.5}},{{-0.25,1.0,2.25}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3}),{2,2,3})}
assert(#results==1,"case 966: result count")
check(results[1],{2,2,3},{24,0,8},"float64",{{{-4.0,-2.75,-1.5},{-4.0,-2.75,-1.5}},{{-0.25,1.0,2.25},{-0.25,1.0,2.25}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3}),{1,2,1,3})}
assert(#results==1,"case 967: result count")
check(results[1],{1,2,1,3},{0,24,0,8},"float64",{{{{-4.0,-2.75,-1.5}},{{-0.25,1.0,2.25}}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3}),{2,0,3})}
assert(#results==1,"case 968: result count")
check(results[1],{2,0,3},{24,0,8},"float64",{{},{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3}),{0,2,3}) end),"case 969: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3}),1),{}) end),"case 970: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3}),1),{0}) end),"case 971: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3}),1),{1}) end),"case 972: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3}),1),{3}) end),"case 973: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3}),1),{2}) end),"case 974: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3}),1),{0,1}) end),"case 975: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3}),1),{1,0}) end),"case 976: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3}),1),{1,3}) end),"case 977: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3}),1),{3,1}) end),"case 978: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3}),1),{2,3}) end),"case 979: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3}),1),{0,3}) end),"case 980: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3}),1),{1,0,3}) end),"case 981: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3}),1),{2,1,3})}
assert(#results==1,"case 982: result count")
check(results[1],{2,1,3},{-24,0,8},"float64",{{{-0.25,1.0,2.25}},{{-4.0,-2.75,-1.5}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3}),1),{2,2,3})}
assert(#results==1,"case 983: result count")
check(results[1],{2,2,3},{-24,0,8},"float64",{{{-0.25,1.0,2.25},{-0.25,1.0,2.25}},{{-4.0,-2.75,-1.5},{-4.0,-2.75,-1.5}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3}),1),{1,2,1,3})}
assert(#results==1,"case 984: result count")
check(results[1],{1,2,1,3},{0,-24,0,8},"float64",{{{{-0.25,1.0,2.25}},{{-4.0,-2.75,-1.5}}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3}),1),{2,0,3})}
assert(#results==1,"case 985: result count")
check(results[1],{2,0,3},{-24,0,8},"float64",{{},{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3}),1),{0,2,3}) end),"case 986: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3})),{}) end),"case 987: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3})),{0}) end),"case 988: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3})),{1}) end),"case 989: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3})),{3}) end),"case 990: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3})),{2}) end),"case 991: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3})),{0,1}) end),"case 992: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3})),{1,0}) end),"case 993: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3})),{1,3}) end),"case 994: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3})),{3,1}) end),"case 995: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3})),{2,3}) end),"case 996: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3})),{0,3}) end),"case 997: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3})),{1,0,3}) end),"case 998: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3})),{2,1,3}) end),"case 999: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3})),{2,2,3}) end),"case 1000: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3})),{1,2,1,3}) end),"case 1001: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3})),{2,0,3}) end),"case 1002: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25},"float64"),{2,1,3})),{0,2,3}) end),"case 1003: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1}),{}) end),"case 1004: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1}),{0}) end),"case 1005: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1}),{1}) end),"case 1006: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1}),{3}) end),"case 1007: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1}),{2}) end),"case 1008: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1}),{0,1}) end),"case 1009: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1}),{1,0}) end),"case 1010: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1}),{1,3}) end),"case 1011: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1}),{3,1}) end),"case 1012: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1}),{2,3}) end),"case 1013: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1}),{0,3}) end),"case 1014: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1}),{1,0,3}) end),"case 1015: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1}),{2,1,3}) end),"case 1016: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1}),{2,2,3})}
assert(#results==1,"case 1017: result count")
check(results[1],{2,2,3},{0,8,0},"float64",{{{-4.0,-4.0,-4.0},{-2.75,-2.75,-2.75}},{{-4.0,-4.0,-4.0},{-2.75,-2.75,-2.75}}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1}),{1,2,1,3}) end),"case 1018: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1}),{2,0,3}) end),"case 1019: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1}),{0,2,3})}
assert(#results==1,"case 1020: result count")
check(results[1],{0,2,3},{0,8,0},"float64",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1}),1),{}) end),"case 1021: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1}),1),{0}) end),"case 1022: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1}),1),{1}) end),"case 1023: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1}),1),{3}) end),"case 1024: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1}),1),{2}) end),"case 1025: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1}),1),{0,1}) end),"case 1026: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1}),1),{1,0}) end),"case 1027: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1}),1),{1,3}) end),"case 1028: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1}),1),{3,1}) end),"case 1029: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1}),1),{2,3}) end),"case 1030: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1}),1),{0,3}) end),"case 1031: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1}),1),{1,0,3}) end),"case 1032: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1}),1),{2,1,3}) end),"case 1033: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1}),1),{2,2,3})}
assert(#results==1,"case 1034: result count")
check(results[1],{2,2,3},{0,8,0},"float64",{{{-4.0,-4.0,-4.0},{-2.75,-2.75,-2.75}},{{-4.0,-4.0,-4.0},{-2.75,-2.75,-2.75}}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1}),1),{1,2,1,3}) end),"case 1035: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1}),1),{2,0,3}) end),"case 1036: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1}),1),{0,2,3})}
assert(#results==1,"case 1037: result count")
check(results[1],{0,2,3},{0,8,0},"float64",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1})),{}) end),"case 1038: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1})),{0}) end),"case 1039: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1})),{1}) end),"case 1040: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1})),{3}) end),"case 1041: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1})),{2}) end),"case 1042: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1})),{0,1}) end),"case 1043: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1})),{1,0}) end),"case 1044: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1})),{1,3}) end),"case 1045: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1})),{3,1}) end),"case 1046: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1})),{2,3}) end),"case 1047: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1})),{0,3}) end),"case 1048: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1})),{1,0,3}) end),"case 1049: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1})),{2,1,3}) end),"case 1050: expected rejection")
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1})),{2,2,3})}
assert(#results==1,"case 1051: result count")
check(results[1],{2,2,3},{0,8,0},"float64",{{{-4.0,-4.0,-4.0},{-2.75,-2.75,-2.75}},{{-4.0,-4.0,-4.0},{-2.75,-2.75,-2.75}}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1})),{1,2,1,3}) end),"case 1052: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1})),{2,0,3}) end),"case 1053: expected rejection")
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75},"float64"),{1,2,1})),{0,2,3})}
assert(#results==1,"case 1054: result count")
check(results[1],{0,2,3},{0,8,0},"float64",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3}),{}) end),"case 1055: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3}),{0}) end),"case 1056: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3}),{1}) end),"case 1057: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3}),{3}) end),"case 1058: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3}),{2}) end),"case 1059: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3}),{0,1}) end),"case 1060: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3}),{1,0}) end),"case 1061: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3}),{1,3}) end),"case 1062: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3}),{3,1}) end),"case 1063: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3}),{2,3}) end),"case 1064: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3}),{0,3}) end),"case 1065: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3}),{1,0,3}) end),"case 1066: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3}),{2,1,3}) end),"case 1067: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3}),{2,2,3})}
assert(#results==1,"case 1068: result count")
check(results[1],{2,2,3},{48,24,8},"float64",{{{-4.0,-2.75,-1.5},{-0.25,1.0,2.25}},{{3.5,4.75,6.0},{7.25,8.5,9.75}}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3}),{1,2,1,3}) end),"case 1069: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3}),{2,0,3}) end),"case 1070: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3}),{0,2,3}) end),"case 1071: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3}),1),{}) end),"case 1072: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3}),1),{0}) end),"case 1073: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3}),1),{1}) end),"case 1074: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3}),1),{3}) end),"case 1075: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3}),1),{2}) end),"case 1076: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3}),1),{0,1}) end),"case 1077: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3}),1),{1,0}) end),"case 1078: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3}),1),{1,3}) end),"case 1079: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3}),1),{3,1}) end),"case 1080: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3}),1),{2,3}) end),"case 1081: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3}),1),{0,3}) end),"case 1082: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3}),1),{1,0,3}) end),"case 1083: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3}),1),{2,1,3}) end),"case 1084: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3}),1),{2,2,3})}
assert(#results==1,"case 1085: result count")
check(results[1],{2,2,3},{-48,24,8},"float64",{{{3.5,4.75,6.0},{7.25,8.5,9.75}},{{-4.0,-2.75,-1.5},{-0.25,1.0,2.25}}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3}),1),{1,2,1,3}) end),"case 1086: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3}),1),{2,0,3}) end),"case 1087: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3}),1),{0,2,3}) end),"case 1088: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3})),{}) end),"case 1089: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3})),{0}) end),"case 1090: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3})),{1}) end),"case 1091: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3})),{3}) end),"case 1092: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3})),{2}) end),"case 1093: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3})),{0,1}) end),"case 1094: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3})),{1,0}) end),"case 1095: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3})),{1,3}) end),"case 1096: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3})),{3,1}) end),"case 1097: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3})),{2,3}) end),"case 1098: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3})),{0,3}) end),"case 1099: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3})),{1,0,3}) end),"case 1100: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3})),{2,1,3}) end),"case 1101: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3})),{2,2,3}) end),"case 1102: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3})),{1,2,1,3}) end),"case 1103: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3})),{2,0,3}) end),"case 1104: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({-4.0,-2.75,-1.5,-0.25,1.0,2.25,3.5,4.75,6.0,7.25,8.5,9.75},"float64"),{2,2,3})),{0,2,3}) end),"case 1105: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0,1,3}),{}) end),"case 1106: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0,1,3}),{0}) end),"case 1107: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0,1,3}),{1}) end),"case 1108: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0,1,3}),{3}) end),"case 1109: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0,1,3}),{2}) end),"case 1110: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0,1,3}),{0,1}) end),"case 1111: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0,1,3}),{1,0}) end),"case 1112: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0,1,3}),{1,3}) end),"case 1113: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0,1,3}),{3,1}) end),"case 1114: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0,1,3}),{2,3}) end),"case 1115: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0,1,3}),{0,3}) end),"case 1116: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0,1,3}),{1,0,3}) end),"case 1117: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0,1,3}),{2,1,3}) end),"case 1118: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0,1,3}),{2,2,3}) end),"case 1119: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0,1,3}),{1,2,1,3}) end),"case 1120: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"float64"),{0,1,3}),{2,0,3}) end),"case 1121: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({},"float64"),{0,1,3}),{0,2,3})}
assert(#results==1,"case 1122: result count")
check(results[1],{0,2,3},{24,0,8},"float64",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0,1,3}),1),{}) end),"case 1123: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0,1,3}),1),{0}) end),"case 1124: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0,1,3}),1),{1}) end),"case 1125: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0,1,3}),1),{3}) end),"case 1126: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0,1,3}),1),{2}) end),"case 1127: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0,1,3}),1),{0,1}) end),"case 1128: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0,1,3}),1),{1,0}) end),"case 1129: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0,1,3}),1),{1,3}) end),"case 1130: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0,1,3}),1),{3,1}) end),"case 1131: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0,1,3}),1),{2,3}) end),"case 1132: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0,1,3}),1),{0,3}) end),"case 1133: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0,1,3}),1),{1,0,3}) end),"case 1134: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0,1,3}),1),{2,1,3}) end),"case 1135: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0,1,3}),1),{2,2,3}) end),"case 1136: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0,1,3}),1),{1,2,1,3}) end),"case 1137: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0,1,3}),1),{2,0,3}) end),"case 1138: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({},"float64"),{0,1,3}),1),{0,2,3})}
assert(#results==1,"case 1139: result count")
check(results[1],{0,2,3},{24,0,8},"float64",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{0,1,3})),{}) end),"case 1140: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{0,1,3})),{0}) end),"case 1141: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{0,1,3})),{1}) end),"case 1142: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{0,1,3})),{3}) end),"case 1143: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{0,1,3})),{2}) end),"case 1144: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{0,1,3})),{0,1}) end),"case 1145: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{0,1,3})),{1,0}) end),"case 1146: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{0,1,3})),{1,3}) end),"case 1147: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{0,1,3})),{3,1}) end),"case 1148: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{0,1,3})),{2,3}) end),"case 1149: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{0,1,3})),{0,3}) end),"case 1150: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{0,1,3})),{1,0,3}) end),"case 1151: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{0,1,3})),{2,1,3}) end),"case 1152: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{0,1,3})),{2,2,3}) end),"case 1153: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{0,1,3})),{1,2,1,3}) end),"case 1154: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{0,1,3})),{2,0,3}) end),"case 1155: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"float64"),{0,1,3})),{0,2,3}) end),"case 1156: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true},"bool"),{}),{})}
assert(#results==1,"case 1157: result count")
check(results[1],{},{},"bool",true)
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true},"bool"),{}),{0})}
assert(#results==1,"case 1158: result count")
check(results[1],{0},{0},"bool",{})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true},"bool"),{}),{1})}
assert(#results==1,"case 1159: result count")
check(results[1],{1},{0},"bool",{true})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true},"bool"),{}),{3})}
assert(#results==1,"case 1160: result count")
check(results[1],{3},{0},"bool",{true,true,true})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true},"bool"),{}),{2})}
assert(#results==1,"case 1161: result count")
check(results[1],{2},{0},"bool",{true,true})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true},"bool"),{}),{0,1})}
assert(#results==1,"case 1162: result count")
check(results[1],{0,1},{0,0},"bool",{})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true},"bool"),{}),{1,0})}
assert(#results==1,"case 1163: result count")
check(results[1],{1,0},{0,0},"bool",{{}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true},"bool"),{}),{1,3})}
assert(#results==1,"case 1164: result count")
check(results[1],{1,3},{0,0},"bool",{{true,true,true}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true},"bool"),{}),{3,1})}
assert(#results==1,"case 1165: result count")
check(results[1],{3,1},{0,0},"bool",{{true},{true},{true}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true},"bool"),{}),{2,3})}
assert(#results==1,"case 1166: result count")
check(results[1],{2,3},{0,0},"bool",{{true,true,true},{true,true,true}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true},"bool"),{}),{0,3})}
assert(#results==1,"case 1167: result count")
check(results[1],{0,3},{0,0},"bool",{})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true},"bool"),{}),{1,0,3})}
assert(#results==1,"case 1168: result count")
check(results[1],{1,0,3},{0,0,0},"bool",{{}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true},"bool"),{}),{2,1,3})}
assert(#results==1,"case 1169: result count")
check(results[1],{2,1,3},{0,0,0},"bool",{{{true,true,true}},{{true,true,true}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true},"bool"),{}),{2,2,3})}
assert(#results==1,"case 1170: result count")
check(results[1],{2,2,3},{0,0,0},"bool",{{{true,true,true},{true,true,true}},{{true,true,true},{true,true,true}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true},"bool"),{}),{1,2,1,3})}
assert(#results==1,"case 1171: result count")
check(results[1],{1,2,1,3},{0,0,0,0},"bool",{{{{true,true,true}},{{true,true,true}}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true},"bool"),{}),{2,0,3})}
assert(#results==1,"case 1172: result count")
check(results[1],{2,0,3},{0,0,0},"bool",{{},{}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true},"bool"),{}),{0,2,3})}
assert(#results==1,"case 1173: result count")
check(results[1],{0,2,3},{0,0,0},"bool",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0}),{}) end),"case 1174: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({},"bool"),{0}),{0})}
assert(#results==1,"case 1175: result count")
check(results[1],{0},{0},"bool",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0}),{1}) end),"case 1176: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0}),{3}) end),"case 1177: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0}),{2}) end),"case 1178: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0}),{0,1}) end),"case 1179: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({},"bool"),{0}),{1,0})}
assert(#results==1,"case 1180: result count")
check(results[1],{1,0},{0,0},"bool",{{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0}),{1,3}) end),"case 1181: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0}),{3,1}) end),"case 1182: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0}),{2,3}) end),"case 1183: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0}),{0,3}) end),"case 1184: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0}),{1,0,3}) end),"case 1185: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0}),{2,1,3}) end),"case 1186: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0}),{2,2,3}) end),"case 1187: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0}),{1,2,1,3}) end),"case 1188: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0}),{2,0,3}) end),"case 1189: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0}),{0,2,3}) end),"case 1190: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0}),1),{}) end),"case 1191: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0}),1),{0})}
assert(#results==1,"case 1192: result count")
check(results[1],{0},{0},"bool",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0}),1),{1}) end),"case 1193: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0}),1),{3}) end),"case 1194: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0}),1),{2}) end),"case 1195: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0}),1),{0,1}) end),"case 1196: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0}),1),{1,0})}
assert(#results==1,"case 1197: result count")
check(results[1],{1,0},{0,0},"bool",{{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0}),1),{1,3}) end),"case 1198: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0}),1),{3,1}) end),"case 1199: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0}),1),{2,3}) end),"case 1200: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0}),1),{0,3}) end),"case 1201: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0}),1),{1,0,3}) end),"case 1202: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0}),1),{2,1,3}) end),"case 1203: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0}),1),{2,2,3}) end),"case 1204: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0}),1),{1,2,1,3}) end),"case 1205: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0}),1),{2,0,3}) end),"case 1206: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0}),1),{0,2,3}) end),"case 1207: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true},"bool"),{1}),{}) end),"case 1208: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true},"bool"),{1}),{0})}
assert(#results==1,"case 1209: result count")
check(results[1],{0},{0},"bool",{})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true},"bool"),{1}),{1})}
assert(#results==1,"case 1210: result count")
check(results[1],{1},{0},"bool",{true})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true},"bool"),{1}),{3})}
assert(#results==1,"case 1211: result count")
check(results[1],{3},{0},"bool",{true,true,true})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true},"bool"),{1}),{2})}
assert(#results==1,"case 1212: result count")
check(results[1],{2},{0},"bool",{true,true})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true},"bool"),{1}),{0,1})}
assert(#results==1,"case 1213: result count")
check(results[1],{0,1},{0,0},"bool",{})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true},"bool"),{1}),{1,0})}
assert(#results==1,"case 1214: result count")
check(results[1],{1,0},{0,0},"bool",{{}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true},"bool"),{1}),{1,3})}
assert(#results==1,"case 1215: result count")
check(results[1],{1,3},{0,0},"bool",{{true,true,true}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true},"bool"),{1}),{3,1})}
assert(#results==1,"case 1216: result count")
check(results[1],{3,1},{0,0},"bool",{{true},{true},{true}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true},"bool"),{1}),{2,3})}
assert(#results==1,"case 1217: result count")
check(results[1],{2,3},{0,0},"bool",{{true,true,true},{true,true,true}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true},"bool"),{1}),{0,3})}
assert(#results==1,"case 1218: result count")
check(results[1],{0,3},{0,0},"bool",{})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true},"bool"),{1}),{1,0,3})}
assert(#results==1,"case 1219: result count")
check(results[1],{1,0,3},{0,0,0},"bool",{{}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true},"bool"),{1}),{2,1,3})}
assert(#results==1,"case 1220: result count")
check(results[1],{2,1,3},{0,0,0},"bool",{{{true,true,true}},{{true,true,true}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true},"bool"),{1}),{2,2,3})}
assert(#results==1,"case 1221: result count")
check(results[1],{2,2,3},{0,0,0},"bool",{{{true,true,true},{true,true,true}},{{true,true,true},{true,true,true}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true},"bool"),{1}),{1,2,1,3})}
assert(#results==1,"case 1222: result count")
check(results[1],{1,2,1,3},{0,0,0,0},"bool",{{{{true,true,true}},{{true,true,true}}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true},"bool"),{1}),{2,0,3})}
assert(#results==1,"case 1223: result count")
check(results[1],{2,0,3},{0,0,0},"bool",{{},{}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true},"bool"),{1}),{0,2,3})}
assert(#results==1,"case 1224: result count")
check(results[1],{0,2,3},{0,0,0},"bool",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true},"bool"),{1}),1),{}) end),"case 1225: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true},"bool"),{1}),1),{0})}
assert(#results==1,"case 1226: result count")
check(results[1],{0},{0},"bool",{})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true},"bool"),{1}),1),{1})}
assert(#results==1,"case 1227: result count")
check(results[1],{1},{0},"bool",{true})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true},"bool"),{1}),1),{3})}
assert(#results==1,"case 1228: result count")
check(results[1],{3},{0},"bool",{true,true,true})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true},"bool"),{1}),1),{2})}
assert(#results==1,"case 1229: result count")
check(results[1],{2},{0},"bool",{true,true})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true},"bool"),{1}),1),{0,1})}
assert(#results==1,"case 1230: result count")
check(results[1],{0,1},{0,0},"bool",{})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true},"bool"),{1}),1),{1,0})}
assert(#results==1,"case 1231: result count")
check(results[1],{1,0},{0,0},"bool",{{}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true},"bool"),{1}),1),{1,3})}
assert(#results==1,"case 1232: result count")
check(results[1],{1,3},{0,0},"bool",{{true,true,true}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true},"bool"),{1}),1),{3,1})}
assert(#results==1,"case 1233: result count")
check(results[1],{3,1},{0,0},"bool",{{true},{true},{true}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true},"bool"),{1}),1),{2,3})}
assert(#results==1,"case 1234: result count")
check(results[1],{2,3},{0,0},"bool",{{true,true,true},{true,true,true}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true},"bool"),{1}),1),{0,3})}
assert(#results==1,"case 1235: result count")
check(results[1],{0,3},{0,0},"bool",{})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true},"bool"),{1}),1),{1,0,3})}
assert(#results==1,"case 1236: result count")
check(results[1],{1,0,3},{0,0,0},"bool",{{}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true},"bool"),{1}),1),{2,1,3})}
assert(#results==1,"case 1237: result count")
check(results[1],{2,1,3},{0,0,0},"bool",{{{true,true,true}},{{true,true,true}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true},"bool"),{1}),1),{2,2,3})}
assert(#results==1,"case 1238: result count")
check(results[1],{2,2,3},{0,0,0},"bool",{{{true,true,true},{true,true,true}},{{true,true,true},{true,true,true}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true},"bool"),{1}),1),{1,2,1,3})}
assert(#results==1,"case 1239: result count")
check(results[1],{1,2,1,3},{0,0,0,0},"bool",{{{{true,true,true}},{{true,true,true}}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true},"bool"),{1}),1),{2,0,3})}
assert(#results==1,"case 1240: result count")
check(results[1],{2,0,3},{0,0,0},"bool",{{},{}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true},"bool"),{1}),1),{0,2,3})}
assert(#results==1,"case 1241: result count")
check(results[1],{0,2,3},{0,0,0},"bool",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{3}),{}) end),"case 1242: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{3}),{0}) end),"case 1243: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{3}),{1}) end),"case 1244: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{3}),{3})}
assert(#results==1,"case 1245: result count")
check(results[1],{3},{1},"bool",{true,false,false})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{3}),{2}) end),"case 1246: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{3}),{0,1}) end),"case 1247: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{3}),{1,0}) end),"case 1248: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{3}),{1,3})}
assert(#results==1,"case 1249: result count")
check(results[1],{1,3},{0,1},"bool",{{true,false,false}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{3}),{3,1}) end),"case 1250: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{3}),{2,3})}
assert(#results==1,"case 1251: result count")
check(results[1],{2,3},{0,1},"bool",{{true,false,false},{true,false,false}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{3}),{0,3})}
assert(#results==1,"case 1252: result count")
check(results[1],{0,3},{0,1},"bool",{})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{3}),{1,0,3})}
assert(#results==1,"case 1253: result count")
check(results[1],{1,0,3},{0,0,1},"bool",{{}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{3}),{2,1,3})}
assert(#results==1,"case 1254: result count")
check(results[1],{2,1,3},{0,0,1},"bool",{{{true,false,false}},{{true,false,false}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{3}),{2,2,3})}
assert(#results==1,"case 1255: result count")
check(results[1],{2,2,3},{0,0,1},"bool",{{{true,false,false},{true,false,false}},{{true,false,false},{true,false,false}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{3}),{1,2,1,3})}
assert(#results==1,"case 1256: result count")
check(results[1],{1,2,1,3},{0,0,0,1},"bool",{{{{true,false,false}},{{true,false,false}}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{3}),{2,0,3})}
assert(#results==1,"case 1257: result count")
check(results[1],{2,0,3},{0,0,1},"bool",{{},{}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{3}),{0,2,3})}
assert(#results==1,"case 1258: result count")
check(results[1],{0,2,3},{0,0,1},"bool",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{3}),1),{}) end),"case 1259: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{3}),1),{0}) end),"case 1260: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{3}),1),{1}) end),"case 1261: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{3}),1),{3})}
assert(#results==1,"case 1262: result count")
check(results[1],{3},{-1},"bool",{false,false,true})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{3}),1),{2}) end),"case 1263: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{3}),1),{0,1}) end),"case 1264: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{3}),1),{1,0}) end),"case 1265: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{3}),1),{1,3})}
assert(#results==1,"case 1266: result count")
check(results[1],{1,3},{0,-1},"bool",{{false,false,true}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{3}),1),{3,1}) end),"case 1267: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{3}),1),{2,3})}
assert(#results==1,"case 1268: result count")
check(results[1],{2,3},{0,-1},"bool",{{false,false,true},{false,false,true}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{3}),1),{0,3})}
assert(#results==1,"case 1269: result count")
check(results[1],{0,3},{0,-1},"bool",{})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{3}),1),{1,0,3})}
assert(#results==1,"case 1270: result count")
check(results[1],{1,0,3},{0,0,-1},"bool",{{}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{3}),1),{2,1,3})}
assert(#results==1,"case 1271: result count")
check(results[1],{2,1,3},{0,0,-1},"bool",{{{false,false,true}},{{false,false,true}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{3}),1),{2,2,3})}
assert(#results==1,"case 1272: result count")
check(results[1],{2,2,3},{0,0,-1},"bool",{{{false,false,true},{false,false,true}},{{false,false,true},{false,false,true}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{3}),1),{1,2,1,3})}
assert(#results==1,"case 1273: result count")
check(results[1],{1,2,1,3},{0,0,0,-1},"bool",{{{{false,false,true}},{{false,false,true}}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{3}),1),{2,0,3})}
assert(#results==1,"case 1274: result count")
check(results[1],{2,0,3},{0,0,-1},"bool",{{},{}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{3}),1),{0,2,3})}
assert(#results==1,"case 1275: result count")
check(results[1],{0,2,3},{0,0,-1},"bool",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0,1}),{}) end),"case 1276: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0,1}),{0}) end),"case 1277: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0,1}),{1}) end),"case 1278: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0,1}),{3}) end),"case 1279: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0,1}),{2}) end),"case 1280: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({},"bool"),{0,1}),{0,1})}
assert(#results==1,"case 1281: result count")
check(results[1],{0,1},{1,0},"bool",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0,1}),{1,0}) end),"case 1282: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0,1}),{1,3}) end),"case 1283: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0,1}),{3,1}) end),"case 1284: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0,1}),{2,3}) end),"case 1285: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({},"bool"),{0,1}),{0,3})}
assert(#results==1,"case 1286: result count")
check(results[1],{0,3},{1,0},"bool",{})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({},"bool"),{0,1}),{1,0,3})}
assert(#results==1,"case 1287: result count")
check(results[1],{1,0,3},{0,1,0},"bool",{{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0,1}),{2,1,3}) end),"case 1288: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0,1}),{2,2,3}) end),"case 1289: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0,1}),{1,2,1,3}) end),"case 1290: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({},"bool"),{0,1}),{2,0,3})}
assert(#results==1,"case 1291: result count")
check(results[1],{2,0,3},{0,1,0},"bool",{{},{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0,1}),{0,2,3}) end),"case 1292: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0,1}),1),{}) end),"case 1293: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0,1}),1),{0}) end),"case 1294: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0,1}),1),{1}) end),"case 1295: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0,1}),1),{3}) end),"case 1296: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0,1}),1),{2}) end),"case 1297: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0,1}),1),{0,1})}
assert(#results==1,"case 1298: result count")
check(results[1],{0,1},{1,0},"bool",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0,1}),1),{1,0}) end),"case 1299: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0,1}),1),{1,3}) end),"case 1300: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0,1}),1),{3,1}) end),"case 1301: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0,1}),1),{2,3}) end),"case 1302: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0,1}),1),{0,3})}
assert(#results==1,"case 1303: result count")
check(results[1],{0,3},{1,0},"bool",{})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0,1}),1),{1,0,3})}
assert(#results==1,"case 1304: result count")
check(results[1],{1,0,3},{0,1,0},"bool",{{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0,1}),1),{2,1,3}) end),"case 1305: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0,1}),1),{2,2,3}) end),"case 1306: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0,1}),1),{1,2,1,3}) end),"case 1307: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0,1}),1),{2,0,3})}
assert(#results==1,"case 1308: result count")
check(results[1],{2,0,3},{0,1,0},"bool",{{},{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0,1}),1),{0,2,3}) end),"case 1309: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{0,1})),{}) end),"case 1310: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{0,1})),{0}) end),"case 1311: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{0,1})),{1}) end),"case 1312: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{0,1})),{3}) end),"case 1313: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{0,1})),{2}) end),"case 1314: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{0,1})),{0,1}) end),"case 1315: expected rejection")
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{0,1})),{1,0})}
assert(#results==1,"case 1316: result count")
check(results[1],{1,0},{0,1},"bool",{{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{0,1})),{1,3}) end),"case 1317: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{0,1})),{3,1}) end),"case 1318: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{0,1})),{2,3}) end),"case 1319: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{0,1})),{0,3}) end),"case 1320: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{0,1})),{1,0,3}) end),"case 1321: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{0,1})),{2,1,3}) end),"case 1322: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{0,1})),{2,2,3}) end),"case 1323: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{0,1})),{1,2,1,3}) end),"case 1324: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{0,1})),{2,0,3}) end),"case 1325: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{0,1})),{0,2,3}) end),"case 1326: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{1,0}),{}) end),"case 1327: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{1,0}),{0}) end),"case 1328: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{1,0}),{1}) end),"case 1329: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{1,0}),{3}) end),"case 1330: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{1,0}),{2}) end),"case 1331: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{1,0}),{0,1}) end),"case 1332: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({},"bool"),{1,0}),{1,0})}
assert(#results==1,"case 1333: result count")
check(results[1],{1,0},{0,1},"bool",{{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{1,0}),{1,3}) end),"case 1334: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{1,0}),{3,1}) end),"case 1335: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{1,0}),{2,3}) end),"case 1336: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{1,0}),{0,3}) end),"case 1337: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{1,0}),{1,0,3}) end),"case 1338: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{1,0}),{2,1,3}) end),"case 1339: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{1,0}),{2,2,3}) end),"case 1340: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{1,0}),{1,2,1,3}) end),"case 1341: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{1,0}),{2,0,3}) end),"case 1342: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{1,0}),{0,2,3}) end),"case 1343: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{1,0}),1),{}) end),"case 1344: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{1,0}),1),{0}) end),"case 1345: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{1,0}),1),{1}) end),"case 1346: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{1,0}),1),{3}) end),"case 1347: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{1,0}),1),{2}) end),"case 1348: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{1,0}),1),{0,1}) end),"case 1349: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{1,0}),1),{1,0})}
assert(#results==1,"case 1350: result count")
check(results[1],{1,0},{0,1},"bool",{{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{1,0}),1),{1,3}) end),"case 1351: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{1,0}),1),{3,1}) end),"case 1352: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{1,0}),1),{2,3}) end),"case 1353: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{1,0}),1),{0,3}) end),"case 1354: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{1,0}),1),{1,0,3}) end),"case 1355: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{1,0}),1),{2,1,3}) end),"case 1356: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{1,0}),1),{2,2,3}) end),"case 1357: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{1,0}),1),{1,2,1,3}) end),"case 1358: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{1,0}),1),{2,0,3}) end),"case 1359: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{1,0}),1),{0,2,3}) end),"case 1360: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{1,0})),{}) end),"case 1361: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{1,0})),{0}) end),"case 1362: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{1,0})),{1}) end),"case 1363: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{1,0})),{3}) end),"case 1364: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{1,0})),{2}) end),"case 1365: expected rejection")
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{1,0})),{0,1})}
assert(#results==1,"case 1366: result count")
check(results[1],{0,1},{1,0},"bool",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{1,0})),{1,0}) end),"case 1367: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{1,0})),{1,3}) end),"case 1368: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{1,0})),{3,1}) end),"case 1369: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{1,0})),{2,3}) end),"case 1370: expected rejection")
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{1,0})),{0,3})}
assert(#results==1,"case 1371: result count")
check(results[1],{0,3},{1,0},"bool",{})
end
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{1,0})),{1,0,3})}
assert(#results==1,"case 1372: result count")
check(results[1],{1,0,3},{0,1,0},"bool",{{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{1,0})),{2,1,3}) end),"case 1373: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{1,0})),{2,2,3}) end),"case 1374: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{1,0})),{1,2,1,3}) end),"case 1375: expected rejection")
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{1,0})),{2,0,3})}
assert(#results==1,"case 1376: result count")
check(results[1],{2,0,3},{0,1,0},"bool",{{},{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{1,0})),{0,2,3}) end),"case 1377: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{1,3}),{}) end),"case 1378: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{1,3}),{0}) end),"case 1379: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{1,3}),{1}) end),"case 1380: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{1,3}),{3}) end),"case 1381: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{1,3}),{2}) end),"case 1382: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{1,3}),{0,1}) end),"case 1383: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{1,3}),{1,0}) end),"case 1384: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{1,3}),{1,3})}
assert(#results==1,"case 1385: result count")
check(results[1],{1,3},{0,1},"bool",{{true,false,false}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{1,3}),{3,1}) end),"case 1386: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{1,3}),{2,3})}
assert(#results==1,"case 1387: result count")
check(results[1],{2,3},{0,1},"bool",{{true,false,false},{true,false,false}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{1,3}),{0,3})}
assert(#results==1,"case 1388: result count")
check(results[1],{0,3},{0,1},"bool",{})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{1,3}),{1,0,3})}
assert(#results==1,"case 1389: result count")
check(results[1],{1,0,3},{0,0,1},"bool",{{}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{1,3}),{2,1,3})}
assert(#results==1,"case 1390: result count")
check(results[1],{2,1,3},{0,0,1},"bool",{{{true,false,false}},{{true,false,false}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{1,3}),{2,2,3})}
assert(#results==1,"case 1391: result count")
check(results[1],{2,2,3},{0,0,1},"bool",{{{true,false,false},{true,false,false}},{{true,false,false},{true,false,false}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{1,3}),{1,2,1,3})}
assert(#results==1,"case 1392: result count")
check(results[1],{1,2,1,3},{0,0,0,1},"bool",{{{{true,false,false}},{{true,false,false}}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{1,3}),{2,0,3})}
assert(#results==1,"case 1393: result count")
check(results[1],{2,0,3},{0,0,1},"bool",{{},{}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{1,3}),{0,2,3})}
assert(#results==1,"case 1394: result count")
check(results[1],{0,2,3},{0,0,1},"bool",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{1,3}),1),{}) end),"case 1395: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{1,3}),1),{0}) end),"case 1396: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{1,3}),1),{1}) end),"case 1397: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{1,3}),1),{3}) end),"case 1398: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{1,3}),1),{2}) end),"case 1399: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{1,3}),1),{0,1}) end),"case 1400: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{1,3}),1),{1,0}) end),"case 1401: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{1,3}),1),{1,3})}
assert(#results==1,"case 1402: result count")
check(results[1],{1,3},{0,1},"bool",{{true,false,false}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{1,3}),1),{3,1}) end),"case 1403: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{1,3}),1),{2,3})}
assert(#results==1,"case 1404: result count")
check(results[1],{2,3},{0,1},"bool",{{true,false,false},{true,false,false}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{1,3}),1),{0,3})}
assert(#results==1,"case 1405: result count")
check(results[1],{0,3},{0,1},"bool",{})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{1,3}),1),{1,0,3})}
assert(#results==1,"case 1406: result count")
check(results[1],{1,0,3},{0,0,1},"bool",{{}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{1,3}),1),{2,1,3})}
assert(#results==1,"case 1407: result count")
check(results[1],{2,1,3},{0,0,1},"bool",{{{true,false,false}},{{true,false,false}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{1,3}),1),{2,2,3})}
assert(#results==1,"case 1408: result count")
check(results[1],{2,2,3},{0,0,1},"bool",{{{true,false,false},{true,false,false}},{{true,false,false},{true,false,false}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{1,3}),1),{1,2,1,3})}
assert(#results==1,"case 1409: result count")
check(results[1],{1,2,1,3},{0,0,0,1},"bool",{{{{true,false,false}},{{true,false,false}}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{1,3}),1),{2,0,3})}
assert(#results==1,"case 1410: result count")
check(results[1],{2,0,3},{0,0,1},"bool",{{},{}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{1,3}),1),{0,2,3})}
assert(#results==1,"case 1411: result count")
check(results[1],{0,2,3},{0,0,1},"bool",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false},"bool"),{1,3})),{}) end),"case 1412: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false},"bool"),{1,3})),{0}) end),"case 1413: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false},"bool"),{1,3})),{1}) end),"case 1414: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false},"bool"),{1,3})),{3}) end),"case 1415: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false},"bool"),{1,3})),{2}) end),"case 1416: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false},"bool"),{1,3})),{0,1}) end),"case 1417: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false},"bool"),{1,3})),{1,0}) end),"case 1418: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false},"bool"),{1,3})),{1,3}) end),"case 1419: expected rejection")
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false},"bool"),{1,3})),{3,1})}
assert(#results==1,"case 1420: result count")
check(results[1],{3,1},{1,0},"bool",{{true},{false},{false}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false},"bool"),{1,3})),{2,3}) end),"case 1421: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false},"bool"),{1,3})),{0,3}) end),"case 1422: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false},"bool"),{1,3})),{1,0,3}) end),"case 1423: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false},"bool"),{1,3})),{2,1,3}) end),"case 1424: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false},"bool"),{1,3})),{2,2,3}) end),"case 1425: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false},"bool"),{1,3})),{1,2,1,3}) end),"case 1426: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false},"bool"),{1,3})),{2,0,3}) end),"case 1427: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false},"bool"),{1,3})),{0,2,3}) end),"case 1428: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{3,1}),{}) end),"case 1429: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{3,1}),{0}) end),"case 1430: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{3,1}),{1}) end),"case 1431: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{3,1}),{3}) end),"case 1432: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{3,1}),{2}) end),"case 1433: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{3,1}),{0,1}) end),"case 1434: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{3,1}),{1,0}) end),"case 1435: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{3,1}),{1,3}) end),"case 1436: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{3,1}),{3,1})}
assert(#results==1,"case 1437: result count")
check(results[1],{3,1},{1,0},"bool",{{true},{false},{false}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{3,1}),{2,3}) end),"case 1438: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{3,1}),{0,3}) end),"case 1439: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{3,1}),{1,0,3}) end),"case 1440: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{3,1}),{2,1,3}) end),"case 1441: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{3,1}),{2,2,3}) end),"case 1442: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{3,1}),{1,2,1,3}) end),"case 1443: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{3,1}),{2,0,3}) end),"case 1444: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false},"bool"),{3,1}),{0,2,3}) end),"case 1445: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{3,1}),1),{}) end),"case 1446: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{3,1}),1),{0}) end),"case 1447: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{3,1}),1),{1}) end),"case 1448: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{3,1}),1),{3}) end),"case 1449: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{3,1}),1),{2}) end),"case 1450: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{3,1}),1),{0,1}) end),"case 1451: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{3,1}),1),{1,0}) end),"case 1452: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{3,1}),1),{1,3}) end),"case 1453: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{3,1}),1),{3,1})}
assert(#results==1,"case 1454: result count")
check(results[1],{3,1},{-1,0},"bool",{{false},{false},{true}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{3,1}),1),{2,3}) end),"case 1455: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{3,1}),1),{0,3}) end),"case 1456: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{3,1}),1),{1,0,3}) end),"case 1457: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{3,1}),1),{2,1,3}) end),"case 1458: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{3,1}),1),{2,2,3}) end),"case 1459: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{3,1}),1),{1,2,1,3}) end),"case 1460: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{3,1}),1),{2,0,3}) end),"case 1461: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false},"bool"),{3,1}),1),{0,2,3}) end),"case 1462: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false},"bool"),{3,1})),{}) end),"case 1463: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false},"bool"),{3,1})),{0}) end),"case 1464: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false},"bool"),{3,1})),{1}) end),"case 1465: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false},"bool"),{3,1})),{3}) end),"case 1466: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false},"bool"),{3,1})),{2}) end),"case 1467: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false},"bool"),{3,1})),{0,1}) end),"case 1468: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false},"bool"),{3,1})),{1,0}) end),"case 1469: expected rejection")
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false},"bool"),{3,1})),{1,3})}
assert(#results==1,"case 1470: result count")
check(results[1],{1,3},{0,1},"bool",{{true,false,false}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false},"bool"),{3,1})),{3,1}) end),"case 1471: expected rejection")
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false},"bool"),{3,1})),{2,3})}
assert(#results==1,"case 1472: result count")
check(results[1],{2,3},{0,1},"bool",{{true,false,false},{true,false,false}})
end
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false},"bool"),{3,1})),{0,3})}
assert(#results==1,"case 1473: result count")
check(results[1],{0,3},{0,1},"bool",{})
end
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false},"bool"),{3,1})),{1,0,3})}
assert(#results==1,"case 1474: result count")
check(results[1],{1,0,3},{0,0,1},"bool",{{}})
end
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false},"bool"),{3,1})),{2,1,3})}
assert(#results==1,"case 1475: result count")
check(results[1],{2,1,3},{0,0,1},"bool",{{{true,false,false}},{{true,false,false}}})
end
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false},"bool"),{3,1})),{2,2,3})}
assert(#results==1,"case 1476: result count")
check(results[1],{2,2,3},{0,0,1},"bool",{{{true,false,false},{true,false,false}},{{true,false,false},{true,false,false}}})
end
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false},"bool"),{3,1})),{1,2,1,3})}
assert(#results==1,"case 1477: result count")
check(results[1],{1,2,1,3},{0,0,0,1},"bool",{{{{true,false,false}},{{true,false,false}}}})
end
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false},"bool"),{3,1})),{2,0,3})}
assert(#results==1,"case 1478: result count")
check(results[1],{2,0,3},{0,0,1},"bool",{{},{}})
end
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false},"bool"),{3,1})),{0,2,3})}
assert(#results==1,"case 1479: result count")
check(results[1],{0,2,3},{0,0,1},"bool",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3}),{}) end),"case 1480: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3}),{0}) end),"case 1481: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3}),{1}) end),"case 1482: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3}),{3}) end),"case 1483: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3}),{2}) end),"case 1484: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3}),{0,1}) end),"case 1485: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3}),{1,0}) end),"case 1486: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3}),{1,3}) end),"case 1487: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3}),{3,1}) end),"case 1488: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3}),{2,3})}
assert(#results==1,"case 1489: result count")
check(results[1],{2,3},{3,1},"bool",{{true,false,false},{true,false,false}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3}),{0,3}) end),"case 1490: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3}),{1,0,3}) end),"case 1491: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3}),{2,1,3}) end),"case 1492: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3}),{2,2,3})}
assert(#results==1,"case 1493: result count")
check(results[1],{2,2,3},{0,3,1},"bool",{{{true,false,false},{true,false,false}},{{true,false,false},{true,false,false}}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3}),{1,2,1,3}) end),"case 1494: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3}),{2,0,3}) end),"case 1495: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3}),{0,2,3})}
assert(#results==1,"case 1496: result count")
check(results[1],{0,2,3},{0,3,1},"bool",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3}),1),{}) end),"case 1497: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3}),1),{0}) end),"case 1498: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3}),1),{1}) end),"case 1499: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3}),1),{3}) end),"case 1500: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3}),1),{2}) end),"case 1501: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3}),1),{0,1}) end),"case 1502: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3}),1),{1,0}) end),"case 1503: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3}),1),{1,3}) end),"case 1504: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3}),1),{3,1}) end),"case 1505: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3}),1),{2,3})}
assert(#results==1,"case 1506: result count")
check(results[1],{2,3},{-3,1},"bool",{{true,false,false},{true,false,false}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3}),1),{0,3}) end),"case 1507: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3}),1),{1,0,3}) end),"case 1508: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3}),1),{2,1,3}) end),"case 1509: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3}),1),{2,2,3})}
assert(#results==1,"case 1510: result count")
check(results[1],{2,2,3},{0,-3,1},"bool",{{{true,false,false},{true,false,false}},{{true,false,false},{true,false,false}}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3}),1),{1,2,1,3}) end),"case 1511: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3}),1),{2,0,3}) end),"case 1512: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3}),1),{0,2,3})}
assert(#results==1,"case 1513: result count")
check(results[1],{0,2,3},{0,-3,1},"bool",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3})),{}) end),"case 1514: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3})),{0}) end),"case 1515: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3})),{1}) end),"case 1516: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3})),{3}) end),"case 1517: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3})),{2}) end),"case 1518: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3})),{0,1}) end),"case 1519: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3})),{1,0}) end),"case 1520: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3})),{1,3}) end),"case 1521: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3})),{3,1}) end),"case 1522: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3})),{2,3}) end),"case 1523: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3})),{0,3}) end),"case 1524: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3})),{1,0,3}) end),"case 1525: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3})),{2,1,3}) end),"case 1526: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3})),{2,2,3}) end),"case 1527: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3})),{1,2,1,3}) end),"case 1528: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3})),{2,0,3}) end),"case 1529: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,3})),{0,2,3}) end),"case 1530: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3}),{}) end),"case 1531: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3}),{0}) end),"case 1532: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3}),{1}) end),"case 1533: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3}),{3}) end),"case 1534: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3}),{2}) end),"case 1535: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3}),{0,1}) end),"case 1536: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3}),{1,0}) end),"case 1537: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3}),{1,3}) end),"case 1538: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3}),{3,1}) end),"case 1539: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3}),{2,3}) end),"case 1540: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3}),{0,3}) end),"case 1541: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3}),{1,0,3}) end),"case 1542: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3}),{2,1,3})}
assert(#results==1,"case 1543: result count")
check(results[1],{2,1,3},{3,0,1},"bool",{{{true,false,false}},{{true,false,false}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3}),{2,2,3})}
assert(#results==1,"case 1544: result count")
check(results[1],{2,2,3},{3,0,1},"bool",{{{true,false,false},{true,false,false}},{{true,false,false},{true,false,false}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3}),{1,2,1,3})}
assert(#results==1,"case 1545: result count")
check(results[1],{1,2,1,3},{0,3,0,1},"bool",{{{{true,false,false}},{{true,false,false}}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3}),{2,0,3})}
assert(#results==1,"case 1546: result count")
check(results[1],{2,0,3},{3,0,1},"bool",{{},{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3}),{0,2,3}) end),"case 1547: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3}),1),{}) end),"case 1548: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3}),1),{0}) end),"case 1549: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3}),1),{1}) end),"case 1550: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3}),1),{3}) end),"case 1551: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3}),1),{2}) end),"case 1552: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3}),1),{0,1}) end),"case 1553: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3}),1),{1,0}) end),"case 1554: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3}),1),{1,3}) end),"case 1555: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3}),1),{3,1}) end),"case 1556: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3}),1),{2,3}) end),"case 1557: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3}),1),{0,3}) end),"case 1558: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3}),1),{1,0,3}) end),"case 1559: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3}),1),{2,1,3})}
assert(#results==1,"case 1560: result count")
check(results[1],{2,1,3},{-3,0,1},"bool",{{{true,false,false}},{{true,false,false}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3}),1),{2,2,3})}
assert(#results==1,"case 1561: result count")
check(results[1],{2,2,3},{-3,0,1},"bool",{{{true,false,false},{true,false,false}},{{true,false,false},{true,false,false}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3}),1),{1,2,1,3})}
assert(#results==1,"case 1562: result count")
check(results[1],{1,2,1,3},{0,-3,0,1},"bool",{{{{true,false,false}},{{true,false,false}}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3}),1),{2,0,3})}
assert(#results==1,"case 1563: result count")
check(results[1],{2,0,3},{-3,0,1},"bool",{{},{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3}),1),{0,2,3}) end),"case 1564: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3})),{}) end),"case 1565: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3})),{0}) end),"case 1566: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3})),{1}) end),"case 1567: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3})),{3}) end),"case 1568: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3})),{2}) end),"case 1569: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3})),{0,1}) end),"case 1570: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3})),{1,0}) end),"case 1571: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3})),{1,3}) end),"case 1572: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3})),{3,1}) end),"case 1573: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3})),{2,3}) end),"case 1574: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3})),{0,3}) end),"case 1575: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3})),{1,0,3}) end),"case 1576: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3})),{2,1,3}) end),"case 1577: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3})),{2,2,3}) end),"case 1578: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3})),{1,2,1,3}) end),"case 1579: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3})),{2,0,3}) end),"case 1580: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false},"bool"),{2,1,3})),{0,2,3}) end),"case 1581: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false},"bool"),{1,2,1}),{}) end),"case 1582: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false},"bool"),{1,2,1}),{0}) end),"case 1583: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false},"bool"),{1,2,1}),{1}) end),"case 1584: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false},"bool"),{1,2,1}),{3}) end),"case 1585: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false},"bool"),{1,2,1}),{2}) end),"case 1586: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false},"bool"),{1,2,1}),{0,1}) end),"case 1587: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false},"bool"),{1,2,1}),{1,0}) end),"case 1588: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false},"bool"),{1,2,1}),{1,3}) end),"case 1589: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false},"bool"),{1,2,1}),{3,1}) end),"case 1590: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false},"bool"),{1,2,1}),{2,3}) end),"case 1591: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false},"bool"),{1,2,1}),{0,3}) end),"case 1592: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false},"bool"),{1,2,1}),{1,0,3}) end),"case 1593: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false},"bool"),{1,2,1}),{2,1,3}) end),"case 1594: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true,false},"bool"),{1,2,1}),{2,2,3})}
assert(#results==1,"case 1595: result count")
check(results[1],{2,2,3},{0,1,0},"bool",{{{true,true,true},{false,false,false}},{{true,true,true},{false,false,false}}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false},"bool"),{1,2,1}),{1,2,1,3}) end),"case 1596: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false},"bool"),{1,2,1}),{2,0,3}) end),"case 1597: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true,false},"bool"),{1,2,1}),{0,2,3})}
assert(#results==1,"case 1598: result count")
check(results[1],{0,2,3},{0,1,0},"bool",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false},"bool"),{1,2,1}),1),{}) end),"case 1599: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false},"bool"),{1,2,1}),1),{0}) end),"case 1600: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false},"bool"),{1,2,1}),1),{1}) end),"case 1601: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false},"bool"),{1,2,1}),1),{3}) end),"case 1602: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false},"bool"),{1,2,1}),1),{2}) end),"case 1603: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false},"bool"),{1,2,1}),1),{0,1}) end),"case 1604: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false},"bool"),{1,2,1}),1),{1,0}) end),"case 1605: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false},"bool"),{1,2,1}),1),{1,3}) end),"case 1606: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false},"bool"),{1,2,1}),1),{3,1}) end),"case 1607: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false},"bool"),{1,2,1}),1),{2,3}) end),"case 1608: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false},"bool"),{1,2,1}),1),{0,3}) end),"case 1609: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false},"bool"),{1,2,1}),1),{1,0,3}) end),"case 1610: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false},"bool"),{1,2,1}),1),{2,1,3}) end),"case 1611: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true,false},"bool"),{1,2,1}),1),{2,2,3})}
assert(#results==1,"case 1612: result count")
check(results[1],{2,2,3},{0,1,0},"bool",{{{true,true,true},{false,false,false}},{{true,true,true},{false,false,false}}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false},"bool"),{1,2,1}),1),{1,2,1,3}) end),"case 1613: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false},"bool"),{1,2,1}),1),{2,0,3}) end),"case 1614: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true,false},"bool"),{1,2,1}),1),{0,2,3})}
assert(#results==1,"case 1615: result count")
check(results[1],{0,2,3},{0,1,0},"bool",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false},"bool"),{1,2,1})),{}) end),"case 1616: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false},"bool"),{1,2,1})),{0}) end),"case 1617: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false},"bool"),{1,2,1})),{1}) end),"case 1618: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false},"bool"),{1,2,1})),{3}) end),"case 1619: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false},"bool"),{1,2,1})),{2}) end),"case 1620: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false},"bool"),{1,2,1})),{0,1}) end),"case 1621: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false},"bool"),{1,2,1})),{1,0}) end),"case 1622: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false},"bool"),{1,2,1})),{1,3}) end),"case 1623: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false},"bool"),{1,2,1})),{3,1}) end),"case 1624: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false},"bool"),{1,2,1})),{2,3}) end),"case 1625: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false},"bool"),{1,2,1})),{0,3}) end),"case 1626: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false},"bool"),{1,2,1})),{1,0,3}) end),"case 1627: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false},"bool"),{1,2,1})),{2,1,3}) end),"case 1628: expected rejection")
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({true,false},"bool"),{1,2,1})),{2,2,3})}
assert(#results==1,"case 1629: result count")
check(results[1],{2,2,3},{0,1,0},"bool",{{{true,true,true},{false,false,false}},{{true,true,true},{false,false,false}}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false},"bool"),{1,2,1})),{1,2,1,3}) end),"case 1630: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false},"bool"),{1,2,1})),{2,0,3}) end),"case 1631: expected rejection")
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({true,false},"bool"),{1,2,1})),{0,2,3})}
assert(#results==1,"case 1632: result count")
check(results[1],{0,2,3},{0,1,0},"bool",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3}),{}) end),"case 1633: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3}),{0}) end),"case 1634: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3}),{1}) end),"case 1635: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3}),{3}) end),"case 1636: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3}),{2}) end),"case 1637: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3}),{0,1}) end),"case 1638: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3}),{1,0}) end),"case 1639: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3}),{1,3}) end),"case 1640: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3}),{3,1}) end),"case 1641: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3}),{2,3}) end),"case 1642: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3}),{0,3}) end),"case 1643: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3}),{1,0,3}) end),"case 1644: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3}),{2,1,3}) end),"case 1645: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3}),{2,2,3})}
assert(#results==1,"case 1646: result count")
check(results[1],{2,2,3},{6,3,1},"bool",{{{true,false,false},{true,false,false}},{{true,false,false},{true,false,false}}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3}),{1,2,1,3}) end),"case 1647: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3}),{2,0,3}) end),"case 1648: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3}),{0,2,3}) end),"case 1649: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3}),1),{}) end),"case 1650: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3}),1),{0}) end),"case 1651: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3}),1),{1}) end),"case 1652: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3}),1),{3}) end),"case 1653: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3}),1),{2}) end),"case 1654: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3}),1),{0,1}) end),"case 1655: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3}),1),{1,0}) end),"case 1656: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3}),1),{1,3}) end),"case 1657: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3}),1),{3,1}) end),"case 1658: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3}),1),{2,3}) end),"case 1659: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3}),1),{0,3}) end),"case 1660: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3}),1),{1,0,3}) end),"case 1661: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3}),1),{2,1,3}) end),"case 1662: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3}),1),{2,2,3})}
assert(#results==1,"case 1663: result count")
check(results[1],{2,2,3},{-6,3,1},"bool",{{{true,false,false},{true,false,false}},{{true,false,false},{true,false,false}}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3}),1),{1,2,1,3}) end),"case 1664: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3}),1),{2,0,3}) end),"case 1665: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3}),1),{0,2,3}) end),"case 1666: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3})),{}) end),"case 1667: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3})),{0}) end),"case 1668: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3})),{1}) end),"case 1669: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3})),{3}) end),"case 1670: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3})),{2}) end),"case 1671: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3})),{0,1}) end),"case 1672: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3})),{1,0}) end),"case 1673: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3})),{1,3}) end),"case 1674: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3})),{3,1}) end),"case 1675: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3})),{2,3}) end),"case 1676: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3})),{0,3}) end),"case 1677: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3})),{1,0,3}) end),"case 1678: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3})),{2,1,3}) end),"case 1679: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3})),{2,2,3}) end),"case 1680: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3})),{1,2,1,3}) end),"case 1681: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3})),{2,0,3}) end),"case 1682: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({true,false,false,true,false,false,true,false,false,true,false,false},"bool"),{2,2,3})),{0,2,3}) end),"case 1683: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0,1,3}),{}) end),"case 1684: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0,1,3}),{0}) end),"case 1685: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0,1,3}),{1}) end),"case 1686: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0,1,3}),{3}) end),"case 1687: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0,1,3}),{2}) end),"case 1688: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0,1,3}),{0,1}) end),"case 1689: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0,1,3}),{1,0}) end),"case 1690: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0,1,3}),{1,3}) end),"case 1691: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0,1,3}),{3,1}) end),"case 1692: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0,1,3}),{2,3}) end),"case 1693: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0,1,3}),{0,3}) end),"case 1694: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0,1,3}),{1,0,3}) end),"case 1695: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0,1,3}),{2,1,3}) end),"case 1696: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0,1,3}),{2,2,3}) end),"case 1697: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0,1,3}),{1,2,1,3}) end),"case 1698: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"bool"),{0,1,3}),{2,0,3}) end),"case 1699: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({},"bool"),{0,1,3}),{0,2,3})}
assert(#results==1,"case 1700: result count")
check(results[1],{0,2,3},{3,0,1},"bool",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0,1,3}),1),{}) end),"case 1701: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0,1,3}),1),{0}) end),"case 1702: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0,1,3}),1),{1}) end),"case 1703: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0,1,3}),1),{3}) end),"case 1704: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0,1,3}),1),{2}) end),"case 1705: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0,1,3}),1),{0,1}) end),"case 1706: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0,1,3}),1),{1,0}) end),"case 1707: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0,1,3}),1),{1,3}) end),"case 1708: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0,1,3}),1),{3,1}) end),"case 1709: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0,1,3}),1),{2,3}) end),"case 1710: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0,1,3}),1),{0,3}) end),"case 1711: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0,1,3}),1),{1,0,3}) end),"case 1712: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0,1,3}),1),{2,1,3}) end),"case 1713: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0,1,3}),1),{2,2,3}) end),"case 1714: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0,1,3}),1),{1,2,1,3}) end),"case 1715: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0,1,3}),1),{2,0,3}) end),"case 1716: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({},"bool"),{0,1,3}),1),{0,2,3})}
assert(#results==1,"case 1717: result count")
check(results[1],{0,2,3},{3,0,1},"bool",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{0,1,3})),{}) end),"case 1718: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{0,1,3})),{0}) end),"case 1719: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{0,1,3})),{1}) end),"case 1720: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{0,1,3})),{3}) end),"case 1721: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{0,1,3})),{2}) end),"case 1722: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{0,1,3})),{0,1}) end),"case 1723: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{0,1,3})),{1,0}) end),"case 1724: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{0,1,3})),{1,3}) end),"case 1725: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{0,1,3})),{3,1}) end),"case 1726: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{0,1,3})),{2,3}) end),"case 1727: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{0,1,3})),{0,3}) end),"case 1728: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{0,1,3})),{1,0,3}) end),"case 1729: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{0,1,3})),{2,1,3}) end),"case 1730: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{0,1,3})),{2,2,3}) end),"case 1731: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{0,1,3})),{1,2,1,3}) end),"case 1732: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{0,1,3})),{2,0,3}) end),"case 1733: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"bool"),{0,1,3})),{0,2,3}) end),"case 1734: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é"},"U2"),{}),{})}
assert(#results==1,"case 1735: result count")
check(results[1],{},{},"<U2","é")
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é"},"U2"),{}),{0})}
assert(#results==1,"case 1736: result count")
check(results[1],{0},{0},"<U2",{})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é"},"U2"),{}),{1})}
assert(#results==1,"case 1737: result count")
check(results[1],{1},{0},"<U2",{"é"})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é"},"U2"),{}),{3})}
assert(#results==1,"case 1738: result count")
check(results[1],{3},{0},"<U2",{"é","é","é"})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é"},"U2"),{}),{2})}
assert(#results==1,"case 1739: result count")
check(results[1],{2},{0},"<U2",{"é","é"})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é"},"U2"),{}),{0,1})}
assert(#results==1,"case 1740: result count")
check(results[1],{0,1},{0,0},"<U2",{})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é"},"U2"),{}),{1,0})}
assert(#results==1,"case 1741: result count")
check(results[1],{1,0},{0,0},"<U2",{{}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é"},"U2"),{}),{1,3})}
assert(#results==1,"case 1742: result count")
check(results[1],{1,3},{0,0},"<U2",{{"é","é","é"}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é"},"U2"),{}),{3,1})}
assert(#results==1,"case 1743: result count")
check(results[1],{3,1},{0,0},"<U2",{{"é"},{"é"},{"é"}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é"},"U2"),{}),{2,3})}
assert(#results==1,"case 1744: result count")
check(results[1],{2,3},{0,0},"<U2",{{"é","é","é"},{"é","é","é"}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é"},"U2"),{}),{0,3})}
assert(#results==1,"case 1745: result count")
check(results[1],{0,3},{0,0},"<U2",{})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é"},"U2"),{}),{1,0,3})}
assert(#results==1,"case 1746: result count")
check(results[1],{1,0,3},{0,0,0},"<U2",{{}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é"},"U2"),{}),{2,1,3})}
assert(#results==1,"case 1747: result count")
check(results[1],{2,1,3},{0,0,0},"<U2",{{{"é","é","é"}},{{"é","é","é"}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é"},"U2"),{}),{2,2,3})}
assert(#results==1,"case 1748: result count")
check(results[1],{2,2,3},{0,0,0},"<U2",{{{"é","é","é"},{"é","é","é"}},{{"é","é","é"},{"é","é","é"}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é"},"U2"),{}),{1,2,1,3})}
assert(#results==1,"case 1749: result count")
check(results[1],{1,2,1,3},{0,0,0,0},"<U2",{{{{"é","é","é"}},{{"é","é","é"}}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é"},"U2"),{}),{2,0,3})}
assert(#results==1,"case 1750: result count")
check(results[1],{2,0,3},{0,0,0},"<U2",{{},{}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é"},"U2"),{}),{0,2,3})}
assert(#results==1,"case 1751: result count")
check(results[1],{0,2,3},{0,0,0},"<U2",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0}),{}) end),"case 1752: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({},"U2"),{0}),{0})}
assert(#results==1,"case 1753: result count")
check(results[1],{0},{0},"<U2",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0}),{1}) end),"case 1754: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0}),{3}) end),"case 1755: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0}),{2}) end),"case 1756: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0}),{0,1}) end),"case 1757: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({},"U2"),{0}),{1,0})}
assert(#results==1,"case 1758: result count")
check(results[1],{1,0},{0,0},"<U2",{{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0}),{1,3}) end),"case 1759: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0}),{3,1}) end),"case 1760: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0}),{2,3}) end),"case 1761: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0}),{0,3}) end),"case 1762: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0}),{1,0,3}) end),"case 1763: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0}),{2,1,3}) end),"case 1764: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0}),{2,2,3}) end),"case 1765: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0}),{1,2,1,3}) end),"case 1766: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0}),{2,0,3}) end),"case 1767: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0}),{0,2,3}) end),"case 1768: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0}),1),{}) end),"case 1769: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0}),1),{0})}
assert(#results==1,"case 1770: result count")
check(results[1],{0},{0},"<U2",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0}),1),{1}) end),"case 1771: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0}),1),{3}) end),"case 1772: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0}),1),{2}) end),"case 1773: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0}),1),{0,1}) end),"case 1774: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0}),1),{1,0})}
assert(#results==1,"case 1775: result count")
check(results[1],{1,0},{0,0},"<U2",{{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0}),1),{1,3}) end),"case 1776: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0}),1),{3,1}) end),"case 1777: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0}),1),{2,3}) end),"case 1778: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0}),1),{0,3}) end),"case 1779: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0}),1),{1,0,3}) end),"case 1780: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0}),1),{2,1,3}) end),"case 1781: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0}),1),{2,2,3}) end),"case 1782: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0}),1),{1,2,1,3}) end),"case 1783: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0}),1),{2,0,3}) end),"case 1784: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0}),1),{0,2,3}) end),"case 1785: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é"},"U2"),{1}),{}) end),"case 1786: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é"},"U2"),{1}),{0})}
assert(#results==1,"case 1787: result count")
check(results[1],{0},{0},"<U2",{})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é"},"U2"),{1}),{1})}
assert(#results==1,"case 1788: result count")
check(results[1],{1},{0},"<U2",{"é"})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é"},"U2"),{1}),{3})}
assert(#results==1,"case 1789: result count")
check(results[1],{3},{0},"<U2",{"é","é","é"})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é"},"U2"),{1}),{2})}
assert(#results==1,"case 1790: result count")
check(results[1],{2},{0},"<U2",{"é","é"})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é"},"U2"),{1}),{0,1})}
assert(#results==1,"case 1791: result count")
check(results[1],{0,1},{0,0},"<U2",{})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é"},"U2"),{1}),{1,0})}
assert(#results==1,"case 1792: result count")
check(results[1],{1,0},{0,0},"<U2",{{}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é"},"U2"),{1}),{1,3})}
assert(#results==1,"case 1793: result count")
check(results[1],{1,3},{0,0},"<U2",{{"é","é","é"}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é"},"U2"),{1}),{3,1})}
assert(#results==1,"case 1794: result count")
check(results[1],{3,1},{0,0},"<U2",{{"é"},{"é"},{"é"}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é"},"U2"),{1}),{2,3})}
assert(#results==1,"case 1795: result count")
check(results[1],{2,3},{0,0},"<U2",{{"é","é","é"},{"é","é","é"}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é"},"U2"),{1}),{0,3})}
assert(#results==1,"case 1796: result count")
check(results[1],{0,3},{0,0},"<U2",{})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é"},"U2"),{1}),{1,0,3})}
assert(#results==1,"case 1797: result count")
check(results[1],{1,0,3},{0,0,0},"<U2",{{}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é"},"U2"),{1}),{2,1,3})}
assert(#results==1,"case 1798: result count")
check(results[1],{2,1,3},{0,0,0},"<U2",{{{"é","é","é"}},{{"é","é","é"}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é"},"U2"),{1}),{2,2,3})}
assert(#results==1,"case 1799: result count")
check(results[1],{2,2,3},{0,0,0},"<U2",{{{"é","é","é"},{"é","é","é"}},{{"é","é","é"},{"é","é","é"}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é"},"U2"),{1}),{1,2,1,3})}
assert(#results==1,"case 1800: result count")
check(results[1],{1,2,1,3},{0,0,0,0},"<U2",{{{{"é","é","é"}},{{"é","é","é"}}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é"},"U2"),{1}),{2,0,3})}
assert(#results==1,"case 1801: result count")
check(results[1],{2,0,3},{0,0,0},"<U2",{{},{}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é"},"U2"),{1}),{0,2,3})}
assert(#results==1,"case 1802: result count")
check(results[1],{0,2,3},{0,0,0},"<U2",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é"},"U2"),{1}),1),{}) end),"case 1803: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é"},"U2"),{1}),1),{0})}
assert(#results==1,"case 1804: result count")
check(results[1],{0},{0},"<U2",{})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é"},"U2"),{1}),1),{1})}
assert(#results==1,"case 1805: result count")
check(results[1],{1},{0},"<U2",{"é"})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é"},"U2"),{1}),1),{3})}
assert(#results==1,"case 1806: result count")
check(results[1],{3},{0},"<U2",{"é","é","é"})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é"},"U2"),{1}),1),{2})}
assert(#results==1,"case 1807: result count")
check(results[1],{2},{0},"<U2",{"é","é"})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é"},"U2"),{1}),1),{0,1})}
assert(#results==1,"case 1808: result count")
check(results[1],{0,1},{0,0},"<U2",{})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é"},"U2"),{1}),1),{1,0})}
assert(#results==1,"case 1809: result count")
check(results[1],{1,0},{0,0},"<U2",{{}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é"},"U2"),{1}),1),{1,3})}
assert(#results==1,"case 1810: result count")
check(results[1],{1,3},{0,0},"<U2",{{"é","é","é"}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é"},"U2"),{1}),1),{3,1})}
assert(#results==1,"case 1811: result count")
check(results[1],{3,1},{0,0},"<U2",{{"é"},{"é"},{"é"}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é"},"U2"),{1}),1),{2,3})}
assert(#results==1,"case 1812: result count")
check(results[1],{2,3},{0,0},"<U2",{{"é","é","é"},{"é","é","é"}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é"},"U2"),{1}),1),{0,3})}
assert(#results==1,"case 1813: result count")
check(results[1],{0,3},{0,0},"<U2",{})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é"},"U2"),{1}),1),{1,0,3})}
assert(#results==1,"case 1814: result count")
check(results[1],{1,0,3},{0,0,0},"<U2",{{}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é"},"U2"),{1}),1),{2,1,3})}
assert(#results==1,"case 1815: result count")
check(results[1],{2,1,3},{0,0,0},"<U2",{{{"é","é","é"}},{{"é","é","é"}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é"},"U2"),{1}),1),{2,2,3})}
assert(#results==1,"case 1816: result count")
check(results[1],{2,2,3},{0,0,0},"<U2",{{{"é","é","é"},{"é","é","é"}},{{"é","é","é"},{"é","é","é"}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é"},"U2"),{1}),1),{1,2,1,3})}
assert(#results==1,"case 1817: result count")
check(results[1],{1,2,1,3},{0,0,0,0},"<U2",{{{{"é","é","é"}},{{"é","é","é"}}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é"},"U2"),{1}),1),{2,0,3})}
assert(#results==1,"case 1818: result count")
check(results[1],{2,0,3},{0,0,0},"<U2",{{},{}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é"},"U2"),{1}),1),{0,2,3})}
assert(#results==1,"case 1819: result count")
check(results[1],{0,2,3},{0,0,0},"<U2",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{3}),{}) end),"case 1820: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{3}),{0}) end),"case 1821: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{3}),{1}) end),"case 1822: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{3}),{3})}
assert(#results==1,"case 1823: result count")
check(results[1],{3},{8},"<U2",{"é","界","A"})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{3}),{2}) end),"case 1824: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{3}),{0,1}) end),"case 1825: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{3}),{1,0}) end),"case 1826: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{3}),{1,3})}
assert(#results==1,"case 1827: result count")
check(results[1],{1,3},{0,8},"<U2",{{"é","界","A"}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{3}),{3,1}) end),"case 1828: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{3}),{2,3})}
assert(#results==1,"case 1829: result count")
check(results[1],{2,3},{0,8},"<U2",{{"é","界","A"},{"é","界","A"}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{3}),{0,3})}
assert(#results==1,"case 1830: result count")
check(results[1],{0,3},{0,8},"<U2",{})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{3}),{1,0,3})}
assert(#results==1,"case 1831: result count")
check(results[1],{1,0,3},{0,0,8},"<U2",{{}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{3}),{2,1,3})}
assert(#results==1,"case 1832: result count")
check(results[1],{2,1,3},{0,0,8},"<U2",{{{"é","界","A"}},{{"é","界","A"}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{3}),{2,2,3})}
assert(#results==1,"case 1833: result count")
check(results[1],{2,2,3},{0,0,8},"<U2",{{{"é","界","A"},{"é","界","A"}},{{"é","界","A"},{"é","界","A"}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{3}),{1,2,1,3})}
assert(#results==1,"case 1834: result count")
check(results[1],{1,2,1,3},{0,0,0,8},"<U2",{{{{"é","界","A"}},{{"é","界","A"}}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{3}),{2,0,3})}
assert(#results==1,"case 1835: result count")
check(results[1],{2,0,3},{0,0,8},"<U2",{{},{}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{3}),{0,2,3})}
assert(#results==1,"case 1836: result count")
check(results[1],{0,2,3},{0,0,8},"<U2",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{3}),1),{}) end),"case 1837: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{3}),1),{0}) end),"case 1838: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{3}),1),{1}) end),"case 1839: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{3}),1),{3})}
assert(#results==1,"case 1840: result count")
check(results[1],{3},{-8},"<U2",{"A","界","é"})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{3}),1),{2}) end),"case 1841: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{3}),1),{0,1}) end),"case 1842: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{3}),1),{1,0}) end),"case 1843: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{3}),1),{1,3})}
assert(#results==1,"case 1844: result count")
check(results[1],{1,3},{0,-8},"<U2",{{"A","界","é"}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{3}),1),{3,1}) end),"case 1845: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{3}),1),{2,3})}
assert(#results==1,"case 1846: result count")
check(results[1],{2,3},{0,-8},"<U2",{{"A","界","é"},{"A","界","é"}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{3}),1),{0,3})}
assert(#results==1,"case 1847: result count")
check(results[1],{0,3},{0,-8},"<U2",{})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{3}),1),{1,0,3})}
assert(#results==1,"case 1848: result count")
check(results[1],{1,0,3},{0,0,-8},"<U2",{{}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{3}),1),{2,1,3})}
assert(#results==1,"case 1849: result count")
check(results[1],{2,1,3},{0,0,-8},"<U2",{{{"A","界","é"}},{{"A","界","é"}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{3}),1),{2,2,3})}
assert(#results==1,"case 1850: result count")
check(results[1],{2,2,3},{0,0,-8},"<U2",{{{"A","界","é"},{"A","界","é"}},{{"A","界","é"},{"A","界","é"}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{3}),1),{1,2,1,3})}
assert(#results==1,"case 1851: result count")
check(results[1],{1,2,1,3},{0,0,0,-8},"<U2",{{{{"A","界","é"}},{{"A","界","é"}}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{3}),1),{2,0,3})}
assert(#results==1,"case 1852: result count")
check(results[1],{2,0,3},{0,0,-8},"<U2",{{},{}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{3}),1),{0,2,3})}
assert(#results==1,"case 1853: result count")
check(results[1],{0,2,3},{0,0,-8},"<U2",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0,1}),{}) end),"case 1854: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0,1}),{0}) end),"case 1855: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0,1}),{1}) end),"case 1856: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0,1}),{3}) end),"case 1857: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0,1}),{2}) end),"case 1858: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({},"U2"),{0,1}),{0,1})}
assert(#results==1,"case 1859: result count")
check(results[1],{0,1},{8,0},"<U2",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0,1}),{1,0}) end),"case 1860: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0,1}),{1,3}) end),"case 1861: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0,1}),{3,1}) end),"case 1862: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0,1}),{2,3}) end),"case 1863: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({},"U2"),{0,1}),{0,3})}
assert(#results==1,"case 1864: result count")
check(results[1],{0,3},{8,0},"<U2",{})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({},"U2"),{0,1}),{1,0,3})}
assert(#results==1,"case 1865: result count")
check(results[1],{1,0,3},{0,8,0},"<U2",{{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0,1}),{2,1,3}) end),"case 1866: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0,1}),{2,2,3}) end),"case 1867: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0,1}),{1,2,1,3}) end),"case 1868: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({},"U2"),{0,1}),{2,0,3})}
assert(#results==1,"case 1869: result count")
check(results[1],{2,0,3},{0,8,0},"<U2",{{},{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0,1}),{0,2,3}) end),"case 1870: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0,1}),1),{}) end),"case 1871: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0,1}),1),{0}) end),"case 1872: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0,1}),1),{1}) end),"case 1873: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0,1}),1),{3}) end),"case 1874: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0,1}),1),{2}) end),"case 1875: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0,1}),1),{0,1})}
assert(#results==1,"case 1876: result count")
check(results[1],{0,1},{8,0},"<U2",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0,1}),1),{1,0}) end),"case 1877: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0,1}),1),{1,3}) end),"case 1878: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0,1}),1),{3,1}) end),"case 1879: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0,1}),1),{2,3}) end),"case 1880: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0,1}),1),{0,3})}
assert(#results==1,"case 1881: result count")
check(results[1],{0,3},{8,0},"<U2",{})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0,1}),1),{1,0,3})}
assert(#results==1,"case 1882: result count")
check(results[1],{1,0,3},{0,8,0},"<U2",{{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0,1}),1),{2,1,3}) end),"case 1883: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0,1}),1),{2,2,3}) end),"case 1884: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0,1}),1),{1,2,1,3}) end),"case 1885: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0,1}),1),{2,0,3})}
assert(#results==1,"case 1886: result count")
check(results[1],{2,0,3},{0,8,0},"<U2",{{},{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0,1}),1),{0,2,3}) end),"case 1887: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{0,1})),{}) end),"case 1888: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{0,1})),{0}) end),"case 1889: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{0,1})),{1}) end),"case 1890: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{0,1})),{3}) end),"case 1891: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{0,1})),{2}) end),"case 1892: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{0,1})),{0,1}) end),"case 1893: expected rejection")
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{0,1})),{1,0})}
assert(#results==1,"case 1894: result count")
check(results[1],{1,0},{0,8},"<U2",{{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{0,1})),{1,3}) end),"case 1895: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{0,1})),{3,1}) end),"case 1896: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{0,1})),{2,3}) end),"case 1897: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{0,1})),{0,3}) end),"case 1898: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{0,1})),{1,0,3}) end),"case 1899: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{0,1})),{2,1,3}) end),"case 1900: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{0,1})),{2,2,3}) end),"case 1901: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{0,1})),{1,2,1,3}) end),"case 1902: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{0,1})),{2,0,3}) end),"case 1903: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{0,1})),{0,2,3}) end),"case 1904: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{1,0}),{}) end),"case 1905: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{1,0}),{0}) end),"case 1906: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{1,0}),{1}) end),"case 1907: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{1,0}),{3}) end),"case 1908: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{1,0}),{2}) end),"case 1909: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{1,0}),{0,1}) end),"case 1910: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({},"U2"),{1,0}),{1,0})}
assert(#results==1,"case 1911: result count")
check(results[1],{1,0},{0,8},"<U2",{{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{1,0}),{1,3}) end),"case 1912: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{1,0}),{3,1}) end),"case 1913: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{1,0}),{2,3}) end),"case 1914: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{1,0}),{0,3}) end),"case 1915: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{1,0}),{1,0,3}) end),"case 1916: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{1,0}),{2,1,3}) end),"case 1917: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{1,0}),{2,2,3}) end),"case 1918: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{1,0}),{1,2,1,3}) end),"case 1919: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{1,0}),{2,0,3}) end),"case 1920: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{1,0}),{0,2,3}) end),"case 1921: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{1,0}),1),{}) end),"case 1922: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{1,0}),1),{0}) end),"case 1923: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{1,0}),1),{1}) end),"case 1924: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{1,0}),1),{3}) end),"case 1925: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{1,0}),1),{2}) end),"case 1926: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{1,0}),1),{0,1}) end),"case 1927: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{1,0}),1),{1,0})}
assert(#results==1,"case 1928: result count")
check(results[1],{1,0},{0,8},"<U2",{{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{1,0}),1),{1,3}) end),"case 1929: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{1,0}),1),{3,1}) end),"case 1930: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{1,0}),1),{2,3}) end),"case 1931: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{1,0}),1),{0,3}) end),"case 1932: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{1,0}),1),{1,0,3}) end),"case 1933: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{1,0}),1),{2,1,3}) end),"case 1934: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{1,0}),1),{2,2,3}) end),"case 1935: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{1,0}),1),{1,2,1,3}) end),"case 1936: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{1,0}),1),{2,0,3}) end),"case 1937: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{1,0}),1),{0,2,3}) end),"case 1938: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{1,0})),{}) end),"case 1939: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{1,0})),{0}) end),"case 1940: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{1,0})),{1}) end),"case 1941: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{1,0})),{3}) end),"case 1942: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{1,0})),{2}) end),"case 1943: expected rejection")
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{1,0})),{0,1})}
assert(#results==1,"case 1944: result count")
check(results[1],{0,1},{8,0},"<U2",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{1,0})),{1,0}) end),"case 1945: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{1,0})),{1,3}) end),"case 1946: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{1,0})),{3,1}) end),"case 1947: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{1,0})),{2,3}) end),"case 1948: expected rejection")
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{1,0})),{0,3})}
assert(#results==1,"case 1949: result count")
check(results[1],{0,3},{8,0},"<U2",{})
end
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{1,0})),{1,0,3})}
assert(#results==1,"case 1950: result count")
check(results[1],{1,0,3},{0,8,0},"<U2",{{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{1,0})),{2,1,3}) end),"case 1951: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{1,0})),{2,2,3}) end),"case 1952: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{1,0})),{1,2,1,3}) end),"case 1953: expected rejection")
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{1,0})),{2,0,3})}
assert(#results==1,"case 1954: result count")
check(results[1],{2,0,3},{0,8,0},"<U2",{{},{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{1,0})),{0,2,3}) end),"case 1955: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{1,3}),{}) end),"case 1956: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{1,3}),{0}) end),"case 1957: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{1,3}),{1}) end),"case 1958: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{1,3}),{3}) end),"case 1959: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{1,3}),{2}) end),"case 1960: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{1,3}),{0,1}) end),"case 1961: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{1,3}),{1,0}) end),"case 1962: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{1,3}),{1,3})}
assert(#results==1,"case 1963: result count")
check(results[1],{1,3},{0,8},"<U2",{{"é","界","A"}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{1,3}),{3,1}) end),"case 1964: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{1,3}),{2,3})}
assert(#results==1,"case 1965: result count")
check(results[1],{2,3},{0,8},"<U2",{{"é","界","A"},{"é","界","A"}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{1,3}),{0,3})}
assert(#results==1,"case 1966: result count")
check(results[1],{0,3},{0,8},"<U2",{})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{1,3}),{1,0,3})}
assert(#results==1,"case 1967: result count")
check(results[1],{1,0,3},{0,0,8},"<U2",{{}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{1,3}),{2,1,3})}
assert(#results==1,"case 1968: result count")
check(results[1],{2,1,3},{0,0,8},"<U2",{{{"é","界","A"}},{{"é","界","A"}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{1,3}),{2,2,3})}
assert(#results==1,"case 1969: result count")
check(results[1],{2,2,3},{0,0,8},"<U2",{{{"é","界","A"},{"é","界","A"}},{{"é","界","A"},{"é","界","A"}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{1,3}),{1,2,1,3})}
assert(#results==1,"case 1970: result count")
check(results[1],{1,2,1,3},{0,0,0,8},"<U2",{{{{"é","界","A"}},{{"é","界","A"}}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{1,3}),{2,0,3})}
assert(#results==1,"case 1971: result count")
check(results[1],{2,0,3},{0,0,8},"<U2",{{},{}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{1,3}),{0,2,3})}
assert(#results==1,"case 1972: result count")
check(results[1],{0,2,3},{0,0,8},"<U2",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{1,3}),1),{}) end),"case 1973: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{1,3}),1),{0}) end),"case 1974: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{1,3}),1),{1}) end),"case 1975: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{1,3}),1),{3}) end),"case 1976: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{1,3}),1),{2}) end),"case 1977: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{1,3}),1),{0,1}) end),"case 1978: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{1,3}),1),{1,0}) end),"case 1979: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{1,3}),1),{1,3})}
assert(#results==1,"case 1980: result count")
check(results[1],{1,3},{0,8},"<U2",{{"é","界","A"}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{1,3}),1),{3,1}) end),"case 1981: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{1,3}),1),{2,3})}
assert(#results==1,"case 1982: result count")
check(results[1],{2,3},{0,8},"<U2",{{"é","界","A"},{"é","界","A"}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{1,3}),1),{0,3})}
assert(#results==1,"case 1983: result count")
check(results[1],{0,3},{0,8},"<U2",{})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{1,3}),1),{1,0,3})}
assert(#results==1,"case 1984: result count")
check(results[1],{1,0,3},{0,0,8},"<U2",{{}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{1,3}),1),{2,1,3})}
assert(#results==1,"case 1985: result count")
check(results[1],{2,1,3},{0,0,8},"<U2",{{{"é","界","A"}},{{"é","界","A"}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{1,3}),1),{2,2,3})}
assert(#results==1,"case 1986: result count")
check(results[1],{2,2,3},{0,0,8},"<U2",{{{"é","界","A"},{"é","界","A"}},{{"é","界","A"},{"é","界","A"}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{1,3}),1),{1,2,1,3})}
assert(#results==1,"case 1987: result count")
check(results[1],{1,2,1,3},{0,0,0,8},"<U2",{{{{"é","界","A"}},{{"é","界","A"}}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{1,3}),1),{2,0,3})}
assert(#results==1,"case 1988: result count")
check(results[1],{2,0,3},{0,0,8},"<U2",{{},{}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{1,3}),1),{0,2,3})}
assert(#results==1,"case 1989: result count")
check(results[1],{0,2,3},{0,0,8},"<U2",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A"},"U2"),{1,3})),{}) end),"case 1990: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A"},"U2"),{1,3})),{0}) end),"case 1991: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A"},"U2"),{1,3})),{1}) end),"case 1992: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A"},"U2"),{1,3})),{3}) end),"case 1993: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A"},"U2"),{1,3})),{2}) end),"case 1994: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A"},"U2"),{1,3})),{0,1}) end),"case 1995: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A"},"U2"),{1,3})),{1,0}) end),"case 1996: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A"},"U2"),{1,3})),{1,3}) end),"case 1997: expected rejection")
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A"},"U2"),{1,3})),{3,1})}
assert(#results==1,"case 1998: result count")
check(results[1],{3,1},{8,0},"<U2",{{"é"},{"界"},{"A"}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A"},"U2"),{1,3})),{2,3}) end),"case 1999: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A"},"U2"),{1,3})),{0,3}) end),"case 2000: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A"},"U2"),{1,3})),{1,0,3}) end),"case 2001: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A"},"U2"),{1,3})),{2,1,3}) end),"case 2002: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A"},"U2"),{1,3})),{2,2,3}) end),"case 2003: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A"},"U2"),{1,3})),{1,2,1,3}) end),"case 2004: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A"},"U2"),{1,3})),{2,0,3}) end),"case 2005: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A"},"U2"),{1,3})),{0,2,3}) end),"case 2006: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{3,1}),{}) end),"case 2007: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{3,1}),{0}) end),"case 2008: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{3,1}),{1}) end),"case 2009: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{3,1}),{3}) end),"case 2010: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{3,1}),{2}) end),"case 2011: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{3,1}),{0,1}) end),"case 2012: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{3,1}),{1,0}) end),"case 2013: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{3,1}),{1,3}) end),"case 2014: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{3,1}),{3,1})}
assert(#results==1,"case 2015: result count")
check(results[1],{3,1},{8,0},"<U2",{{"é"},{"界"},{"A"}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{3,1}),{2,3}) end),"case 2016: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{3,1}),{0,3}) end),"case 2017: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{3,1}),{1,0,3}) end),"case 2018: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{3,1}),{2,1,3}) end),"case 2019: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{3,1}),{2,2,3}) end),"case 2020: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{3,1}),{1,2,1,3}) end),"case 2021: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{3,1}),{2,0,3}) end),"case 2022: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A"},"U2"),{3,1}),{0,2,3}) end),"case 2023: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{3,1}),1),{}) end),"case 2024: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{3,1}),1),{0}) end),"case 2025: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{3,1}),1),{1}) end),"case 2026: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{3,1}),1),{3}) end),"case 2027: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{3,1}),1),{2}) end),"case 2028: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{3,1}),1),{0,1}) end),"case 2029: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{3,1}),1),{1,0}) end),"case 2030: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{3,1}),1),{1,3}) end),"case 2031: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{3,1}),1),{3,1})}
assert(#results==1,"case 2032: result count")
check(results[1],{3,1},{-8,0},"<U2",{{"A"},{"界"},{"é"}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{3,1}),1),{2,3}) end),"case 2033: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{3,1}),1),{0,3}) end),"case 2034: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{3,1}),1),{1,0,3}) end),"case 2035: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{3,1}),1),{2,1,3}) end),"case 2036: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{3,1}),1),{2,2,3}) end),"case 2037: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{3,1}),1),{1,2,1,3}) end),"case 2038: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{3,1}),1),{2,0,3}) end),"case 2039: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A"},"U2"),{3,1}),1),{0,2,3}) end),"case 2040: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A"},"U2"),{3,1})),{}) end),"case 2041: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A"},"U2"),{3,1})),{0}) end),"case 2042: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A"},"U2"),{3,1})),{1}) end),"case 2043: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A"},"U2"),{3,1})),{3}) end),"case 2044: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A"},"U2"),{3,1})),{2}) end),"case 2045: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A"},"U2"),{3,1})),{0,1}) end),"case 2046: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A"},"U2"),{3,1})),{1,0}) end),"case 2047: expected rejection")
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A"},"U2"),{3,1})),{1,3})}
assert(#results==1,"case 2048: result count")
check(results[1],{1,3},{0,8},"<U2",{{"é","界","A"}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A"},"U2"),{3,1})),{3,1}) end),"case 2049: expected rejection")
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A"},"U2"),{3,1})),{2,3})}
assert(#results==1,"case 2050: result count")
check(results[1],{2,3},{0,8},"<U2",{{"é","界","A"},{"é","界","A"}})
end
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A"},"U2"),{3,1})),{0,3})}
assert(#results==1,"case 2051: result count")
check(results[1],{0,3},{0,8},"<U2",{})
end
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A"},"U2"),{3,1})),{1,0,3})}
assert(#results==1,"case 2052: result count")
check(results[1],{1,0,3},{0,0,8},"<U2",{{}})
end
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A"},"U2"),{3,1})),{2,1,3})}
assert(#results==1,"case 2053: result count")
check(results[1],{2,1,3},{0,0,8},"<U2",{{{"é","界","A"}},{{"é","界","A"}}})
end
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A"},"U2"),{3,1})),{2,2,3})}
assert(#results==1,"case 2054: result count")
check(results[1],{2,2,3},{0,0,8},"<U2",{{{"é","界","A"},{"é","界","A"}},{{"é","界","A"},{"é","界","A"}}})
end
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A"},"U2"),{3,1})),{1,2,1,3})}
assert(#results==1,"case 2055: result count")
check(results[1],{1,2,1,3},{0,0,0,8},"<U2",{{{{"é","界","A"}},{{"é","界","A"}}}})
end
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A"},"U2"),{3,1})),{2,0,3})}
assert(#results==1,"case 2056: result count")
check(results[1],{2,0,3},{0,0,8},"<U2",{{},{}})
end
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A"},"U2"),{3,1})),{0,2,3})}
assert(#results==1,"case 2057: result count")
check(results[1],{0,2,3},{0,0,8},"<U2",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3}),{}) end),"case 2058: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3}),{0}) end),"case 2059: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3}),{1}) end),"case 2060: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3}),{3}) end),"case 2061: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3}),{2}) end),"case 2062: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3}),{0,1}) end),"case 2063: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3}),{1,0}) end),"case 2064: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3}),{1,3}) end),"case 2065: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3}),{3,1}) end),"case 2066: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3}),{2,3})}
assert(#results==1,"case 2067: result count")
check(results[1],{2,3},{24,8},"<U2",{{"é","界","A"},{"東","µ","é"}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3}),{0,3}) end),"case 2068: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3}),{1,0,3}) end),"case 2069: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3}),{2,1,3}) end),"case 2070: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3}),{2,2,3})}
assert(#results==1,"case 2071: result count")
check(results[1],{2,2,3},{0,24,8},"<U2",{{{"é","界","A"},{"東","µ","é"}},{{"é","界","A"},{"東","µ","é"}}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3}),{1,2,1,3}) end),"case 2072: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3}),{2,0,3}) end),"case 2073: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3}),{0,2,3})}
assert(#results==1,"case 2074: result count")
check(results[1],{0,2,3},{0,24,8},"<U2",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3}),1),{}) end),"case 2075: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3}),1),{0}) end),"case 2076: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3}),1),{1}) end),"case 2077: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3}),1),{3}) end),"case 2078: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3}),1),{2}) end),"case 2079: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3}),1),{0,1}) end),"case 2080: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3}),1),{1,0}) end),"case 2081: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3}),1),{1,3}) end),"case 2082: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3}),1),{3,1}) end),"case 2083: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3}),1),{2,3})}
assert(#results==1,"case 2084: result count")
check(results[1],{2,3},{-24,8},"<U2",{{"東","µ","é"},{"é","界","A"}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3}),1),{0,3}) end),"case 2085: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3}),1),{1,0,3}) end),"case 2086: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3}),1),{2,1,3}) end),"case 2087: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3}),1),{2,2,3})}
assert(#results==1,"case 2088: result count")
check(results[1],{2,2,3},{0,-24,8},"<U2",{{{"東","µ","é"},{"é","界","A"}},{{"東","µ","é"},{"é","界","A"}}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3}),1),{1,2,1,3}) end),"case 2089: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3}),1),{2,0,3}) end),"case 2090: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3}),1),{0,2,3})}
assert(#results==1,"case 2091: result count")
check(results[1],{0,2,3},{0,-24,8},"<U2",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3})),{}) end),"case 2092: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3})),{0}) end),"case 2093: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3})),{1}) end),"case 2094: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3})),{3}) end),"case 2095: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3})),{2}) end),"case 2096: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3})),{0,1}) end),"case 2097: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3})),{1,0}) end),"case 2098: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3})),{1,3}) end),"case 2099: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3})),{3,1}) end),"case 2100: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3})),{2,3}) end),"case 2101: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3})),{0,3}) end),"case 2102: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3})),{1,0,3}) end),"case 2103: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3})),{2,1,3}) end),"case 2104: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3})),{2,2,3}) end),"case 2105: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3})),{1,2,1,3}) end),"case 2106: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3})),{2,0,3}) end),"case 2107: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,3})),{0,2,3}) end),"case 2108: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3}),{}) end),"case 2109: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3}),{0}) end),"case 2110: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3}),{1}) end),"case 2111: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3}),{3}) end),"case 2112: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3}),{2}) end),"case 2113: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3}),{0,1}) end),"case 2114: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3}),{1,0}) end),"case 2115: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3}),{1,3}) end),"case 2116: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3}),{3,1}) end),"case 2117: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3}),{2,3}) end),"case 2118: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3}),{0,3}) end),"case 2119: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3}),{1,0,3}) end),"case 2120: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3}),{2,1,3})}
assert(#results==1,"case 2121: result count")
check(results[1],{2,1,3},{24,0,8},"<U2",{{{"é","界","A"}},{{"東","µ","é"}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3}),{2,2,3})}
assert(#results==1,"case 2122: result count")
check(results[1],{2,2,3},{24,0,8},"<U2",{{{"é","界","A"},{"é","界","A"}},{{"東","µ","é"},{"東","µ","é"}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3}),{1,2,1,3})}
assert(#results==1,"case 2123: result count")
check(results[1],{1,2,1,3},{0,24,0,8},"<U2",{{{{"é","界","A"}},{{"東","µ","é"}}}})
end
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3}),{2,0,3})}
assert(#results==1,"case 2124: result count")
check(results[1],{2,0,3},{24,0,8},"<U2",{{},{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3}),{0,2,3}) end),"case 2125: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3}),1),{}) end),"case 2126: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3}),1),{0}) end),"case 2127: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3}),1),{1}) end),"case 2128: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3}),1),{3}) end),"case 2129: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3}),1),{2}) end),"case 2130: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3}),1),{0,1}) end),"case 2131: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3}),1),{1,0}) end),"case 2132: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3}),1),{1,3}) end),"case 2133: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3}),1),{3,1}) end),"case 2134: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3}),1),{2,3}) end),"case 2135: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3}),1),{0,3}) end),"case 2136: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3}),1),{1,0,3}) end),"case 2137: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3}),1),{2,1,3})}
assert(#results==1,"case 2138: result count")
check(results[1],{2,1,3},{-24,0,8},"<U2",{{{"東","µ","é"}},{{"é","界","A"}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3}),1),{2,2,3})}
assert(#results==1,"case 2139: result count")
check(results[1],{2,2,3},{-24,0,8},"<U2",{{{"東","µ","é"},{"東","µ","é"}},{{"é","界","A"},{"é","界","A"}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3}),1),{1,2,1,3})}
assert(#results==1,"case 2140: result count")
check(results[1],{1,2,1,3},{0,-24,0,8},"<U2",{{{{"東","µ","é"}},{{"é","界","A"}}}})
end
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3}),1),{2,0,3})}
assert(#results==1,"case 2141: result count")
check(results[1],{2,0,3},{-24,0,8},"<U2",{{},{}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3}),1),{0,2,3}) end),"case 2142: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3})),{}) end),"case 2143: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3})),{0}) end),"case 2144: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3})),{1}) end),"case 2145: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3})),{3}) end),"case 2146: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3})),{2}) end),"case 2147: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3})),{0,1}) end),"case 2148: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3})),{1,0}) end),"case 2149: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3})),{1,3}) end),"case 2150: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3})),{3,1}) end),"case 2151: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3})),{2,3}) end),"case 2152: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3})),{0,3}) end),"case 2153: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3})),{1,0,3}) end),"case 2154: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3})),{2,1,3}) end),"case 2155: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3})),{2,2,3}) end),"case 2156: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3})),{1,2,1,3}) end),"case 2157: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3})),{2,0,3}) end),"case 2158: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é"},"U2"),{2,1,3})),{0,2,3}) end),"case 2159: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界"},"U2"),{1,2,1}),{}) end),"case 2160: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界"},"U2"),{1,2,1}),{0}) end),"case 2161: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界"},"U2"),{1,2,1}),{1}) end),"case 2162: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界"},"U2"),{1,2,1}),{3}) end),"case 2163: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界"},"U2"),{1,2,1}),{2}) end),"case 2164: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界"},"U2"),{1,2,1}),{0,1}) end),"case 2165: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界"},"U2"),{1,2,1}),{1,0}) end),"case 2166: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界"},"U2"),{1,2,1}),{1,3}) end),"case 2167: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界"},"U2"),{1,2,1}),{3,1}) end),"case 2168: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界"},"U2"),{1,2,1}),{2,3}) end),"case 2169: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界"},"U2"),{1,2,1}),{0,3}) end),"case 2170: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界"},"U2"),{1,2,1}),{1,0,3}) end),"case 2171: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界"},"U2"),{1,2,1}),{2,1,3}) end),"case 2172: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é","界"},"U2"),{1,2,1}),{2,2,3})}
assert(#results==1,"case 2173: result count")
check(results[1],{2,2,3},{0,8,0},"<U2",{{{"é","é","é"},{"界","界","界"}},{{"é","é","é"},{"界","界","界"}}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界"},"U2"),{1,2,1}),{1,2,1,3}) end),"case 2174: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界"},"U2"),{1,2,1}),{2,0,3}) end),"case 2175: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é","界"},"U2"),{1,2,1}),{0,2,3})}
assert(#results==1,"case 2176: result count")
check(results[1],{0,2,3},{0,8,0},"<U2",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界"},"U2"),{1,2,1}),1),{}) end),"case 2177: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界"},"U2"),{1,2,1}),1),{0}) end),"case 2178: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界"},"U2"),{1,2,1}),1),{1}) end),"case 2179: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界"},"U2"),{1,2,1}),1),{3}) end),"case 2180: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界"},"U2"),{1,2,1}),1),{2}) end),"case 2181: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界"},"U2"),{1,2,1}),1),{0,1}) end),"case 2182: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界"},"U2"),{1,2,1}),1),{1,0}) end),"case 2183: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界"},"U2"),{1,2,1}),1),{1,3}) end),"case 2184: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界"},"U2"),{1,2,1}),1),{3,1}) end),"case 2185: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界"},"U2"),{1,2,1}),1),{2,3}) end),"case 2186: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界"},"U2"),{1,2,1}),1),{0,3}) end),"case 2187: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界"},"U2"),{1,2,1}),1),{1,0,3}) end),"case 2188: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界"},"U2"),{1,2,1}),1),{2,1,3}) end),"case 2189: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é","界"},"U2"),{1,2,1}),1),{2,2,3})}
assert(#results==1,"case 2190: result count")
check(results[1],{2,2,3},{0,8,0},"<U2",{{{"é","é","é"},{"界","界","界"}},{{"é","é","é"},{"界","界","界"}}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界"},"U2"),{1,2,1}),1),{1,2,1,3}) end),"case 2191: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界"},"U2"),{1,2,1}),1),{2,0,3}) end),"case 2192: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é","界"},"U2"),{1,2,1}),1),{0,2,3})}
assert(#results==1,"case 2193: result count")
check(results[1],{0,2,3},{0,8,0},"<U2",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界"},"U2"),{1,2,1})),{}) end),"case 2194: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界"},"U2"),{1,2,1})),{0}) end),"case 2195: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界"},"U2"),{1,2,1})),{1}) end),"case 2196: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界"},"U2"),{1,2,1})),{3}) end),"case 2197: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界"},"U2"),{1,2,1})),{2}) end),"case 2198: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界"},"U2"),{1,2,1})),{0,1}) end),"case 2199: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界"},"U2"),{1,2,1})),{1,0}) end),"case 2200: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界"},"U2"),{1,2,1})),{1,3}) end),"case 2201: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界"},"U2"),{1,2,1})),{3,1}) end),"case 2202: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界"},"U2"),{1,2,1})),{2,3}) end),"case 2203: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界"},"U2"),{1,2,1})),{0,3}) end),"case 2204: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界"},"U2"),{1,2,1})),{1,0,3}) end),"case 2205: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界"},"U2"),{1,2,1})),{2,1,3}) end),"case 2206: expected rejection")
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({"é","界"},"U2"),{1,2,1})),{2,2,3})}
assert(#results==1,"case 2207: result count")
check(results[1],{2,2,3},{0,8,0},"<U2",{{{"é","é","é"},{"界","界","界"}},{{"é","é","é"},{"界","界","界"}}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界"},"U2"),{1,2,1})),{1,2,1,3}) end),"case 2208: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界"},"U2"),{1,2,1})),{2,0,3}) end),"case 2209: expected rejection")
n=n+1
do local results={np.broadcast_to(np.transpose(np.reshape(np.array({"é","界"},"U2"),{1,2,1})),{0,2,3})}
assert(#results==1,"case 2210: result count")
check(results[1],{0,2,3},{0,8,0},"<U2",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3}),{}) end),"case 2211: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3}),{0}) end),"case 2212: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3}),{1}) end),"case 2213: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3}),{3}) end),"case 2214: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3}),{2}) end),"case 2215: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3}),{0,1}) end),"case 2216: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3}),{1,0}) end),"case 2217: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3}),{1,3}) end),"case 2218: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3}),{3,1}) end),"case 2219: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3}),{2,3}) end),"case 2220: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3}),{0,3}) end),"case 2221: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3}),{1,0,3}) end),"case 2222: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3}),{2,1,3}) end),"case 2223: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3}),{2,2,3})}
assert(#results==1,"case 2224: result count")
check(results[1],{2,2,3},{48,24,8},"<U2",{{{"é","界","A"},{"東","µ","é"}},{{"界","A","東"},{"µ","é","界"}}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3}),{1,2,1,3}) end),"case 2225: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3}),{2,0,3}) end),"case 2226: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3}),{0,2,3}) end),"case 2227: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3}),1),{}) end),"case 2228: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3}),1),{0}) end),"case 2229: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3}),1),{1}) end),"case 2230: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3}),1),{3}) end),"case 2231: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3}),1),{2}) end),"case 2232: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3}),1),{0,1}) end),"case 2233: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3}),1),{1,0}) end),"case 2234: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3}),1),{1,3}) end),"case 2235: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3}),1),{3,1}) end),"case 2236: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3}),1),{2,3}) end),"case 2237: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3}),1),{0,3}) end),"case 2238: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3}),1),{1,0,3}) end),"case 2239: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3}),1),{2,1,3}) end),"case 2240: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3}),1),{2,2,3})}
assert(#results==1,"case 2241: result count")
check(results[1],{2,2,3},{-48,24,8},"<U2",{{{"界","A","東"},{"µ","é","界"}},{{"é","界","A"},{"東","µ","é"}}})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3}),1),{1,2,1,3}) end),"case 2242: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3}),1),{2,0,3}) end),"case 2243: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3}),1),{0,2,3}) end),"case 2244: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3})),{}) end),"case 2245: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3})),{0}) end),"case 2246: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3})),{1}) end),"case 2247: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3})),{3}) end),"case 2248: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3})),{2}) end),"case 2249: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3})),{0,1}) end),"case 2250: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3})),{1,0}) end),"case 2251: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3})),{1,3}) end),"case 2252: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3})),{3,1}) end),"case 2253: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3})),{2,3}) end),"case 2254: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3})),{0,3}) end),"case 2255: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3})),{1,0,3}) end),"case 2256: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3})),{2,1,3}) end),"case 2257: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3})),{2,2,3}) end),"case 2258: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3})),{1,2,1,3}) end),"case 2259: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3})),{2,0,3}) end),"case 2260: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({"é","界","A","東","µ","é","界","A","東","µ","é","界"},"U2"),{2,2,3})),{0,2,3}) end),"case 2261: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0,1,3}),{}) end),"case 2262: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0,1,3}),{0}) end),"case 2263: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0,1,3}),{1}) end),"case 2264: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0,1,3}),{3}) end),"case 2265: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0,1,3}),{2}) end),"case 2266: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0,1,3}),{0,1}) end),"case 2267: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0,1,3}),{1,0}) end),"case 2268: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0,1,3}),{1,3}) end),"case 2269: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0,1,3}),{3,1}) end),"case 2270: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0,1,3}),{2,3}) end),"case 2271: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0,1,3}),{0,3}) end),"case 2272: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0,1,3}),{1,0,3}) end),"case 2273: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0,1,3}),{2,1,3}) end),"case 2274: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0,1,3}),{2,2,3}) end),"case 2275: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0,1,3}),{1,2,1,3}) end),"case 2276: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.reshape(np.array({},"U2"),{0,1,3}),{2,0,3}) end),"case 2277: expected rejection")
n=n+1
do local results={np.broadcast_to(np.reshape(np.array({},"U2"),{0,1,3}),{0,2,3})}
assert(#results==1,"case 2278: result count")
check(results[1],{0,2,3},{24,0,8},"<U2",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0,1,3}),1),{}) end),"case 2279: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0,1,3}),1),{0}) end),"case 2280: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0,1,3}),1),{1}) end),"case 2281: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0,1,3}),1),{3}) end),"case 2282: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0,1,3}),1),{2}) end),"case 2283: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0,1,3}),1),{0,1}) end),"case 2284: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0,1,3}),1),{1,0}) end),"case 2285: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0,1,3}),1),{1,3}) end),"case 2286: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0,1,3}),1),{3,1}) end),"case 2287: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0,1,3}),1),{2,3}) end),"case 2288: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0,1,3}),1),{0,3}) end),"case 2289: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0,1,3}),1),{1,0,3}) end),"case 2290: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0,1,3}),1),{2,1,3}) end),"case 2291: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0,1,3}),1),{2,2,3}) end),"case 2292: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0,1,3}),1),{1,2,1,3}) end),"case 2293: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0,1,3}),1),{2,0,3}) end),"case 2294: expected rejection")
n=n+1
do local results={np.broadcast_to(np.flip(np.reshape(np.array({},"U2"),{0,1,3}),1),{0,2,3})}
assert(#results==1,"case 2295: result count")
check(results[1],{0,2,3},{24,0,8},"<U2",{})
end
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{0,1,3})),{}) end),"case 2296: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{0,1,3})),{0}) end),"case 2297: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{0,1,3})),{1}) end),"case 2298: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{0,1,3})),{3}) end),"case 2299: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{0,1,3})),{2}) end),"case 2300: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{0,1,3})),{0,1}) end),"case 2301: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{0,1,3})),{1,0}) end),"case 2302: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{0,1,3})),{1,3}) end),"case 2303: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{0,1,3})),{3,1}) end),"case 2304: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{0,1,3})),{2,3}) end),"case 2305: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{0,1,3})),{0,3}) end),"case 2306: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{0,1,3})),{1,0,3}) end),"case 2307: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{0,1,3})),{2,1,3}) end),"case 2308: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{0,1,3})),{2,2,3}) end),"case 2309: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{0,1,3})),{1,2,1,3}) end),"case 2310: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{0,1,3})),{2,0,3}) end),"case 2311: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_to(np.transpose(np.reshape(np.array({},"U2"),{0,1,3})),{0,2,3}) end),"case 2312: expected rejection")
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({0,1,2},"int32"),{1,3}),np.reshape(np.array({0,1},"int32"),{2,1}))
assert(#results==2,"case 2313: result count")
check(results[1],{2,3},{0,4},"int32",{{0,1,2},{0,1,2}})
check(results[2],{2,3},{4,0},"int32",{{0,0,0},{1,1,1}})
end
n=n+1
do local results=np.broadcast_arrays(np.flip(np.reshape(np.array({0,1,2},"int32"),{1,3}),1),np.reshape(np.array({0,1},"int32"),{2,1}))
assert(#results==2,"case 2314: result count")
check(results[1],{2,3},{0,4},"int32",{{0,1,2},{0,1,2}})
check(results[2],{2,3},{4,0},"int32",{{0,0,0},{1,1,1}})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({0,1,2,3,4,5},"int32"),{2,1,3}),np.reshape(np.array({0,1},"int32"),{1,2,1}))
assert(#results==2,"case 2315: result count")
check(results[1],{2,2,3},{12,0,4},"int32",{{{0,1,2},{0,1,2}},{{3,4,5},{3,4,5}}})
check(results[2],{2,2,3},{0,4,0},"int32",{{{0,0,0},{1,1,1}},{{0,0,0},{1,1,1}}})
end
n=n+1
do local results=np.broadcast_arrays(np.flip(np.reshape(np.array({0,1,2,3,4,5},"int32"),{2,1,3}),1),np.reshape(np.array({0,1},"int32"),{1,2,1}))
assert(#results==2,"case 2316: result count")
check(results[1],{2,2,3},{-12,0,4},"int32",{{{3,4,5},{3,4,5}},{{0,1,2},{0,1,2}}})
check(results[2],{2,2,3},{0,4,0},"int32",{{{0,0,0},{1,1,1}},{{0,0,0},{1,1,1}}})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({},"int32"),{1,0}),np.reshape(np.array({0,1},"int32"),{2,1}))
assert(#results==2,"case 2317: result count")
check(results[1],{2,0},{0,4},"int32",{{},{}})
check(results[2],{2,0},{4,0},"int32",{{},{}})
end
n=n+1
do local results=np.broadcast_arrays(np.flip(np.reshape(np.array({},"int32"),{1,0}),1),np.reshape(np.array({0,1},"int32"),{2,1}))
assert(#results==2,"case 2318: result count")
check(results[1],{2,0},{0,4},"int32",{{},{}})
check(results[2],{2,0},{4,0},"int32",{{},{}})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({},"int32"),{0,1}),np.reshape(np.array({0,1},"int32"),{1,2}))
assert(#results==2,"case 2319: result count")
check(results[1],{0,2},{4,0},"int32",{})
check(results[2],{0,2},{0,4},"int32",{})
end
n=n+1
do local results=np.broadcast_arrays(np.flip(np.reshape(np.array({},"int32"),{0,1}),1),np.reshape(np.array({0,1},"int32"),{1,2}))
assert(#results==2,"case 2320: result count")
check(results[1],{0,2},{4,0},"int32",{})
check(results[2],{0,2},{0,4},"int32",{})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({0,1,2,3,4,5},"int32"),{2,3}),np.reshape(np.array({0,1,2},"int32"),{1,3}))
assert(#results==2,"case 2321: result count")
check(results[1],{2,3},{12,4},"int32",{{0,1,2},{3,4,5}})
check(results[2],{2,3},{0,4},"int32",{{0,1,2},{0,1,2}})
end
n=n+1
do local results=np.broadcast_arrays(np.flip(np.reshape(np.array({0,1,2,3,4,5},"int32"),{2,3}),1),np.reshape(np.array({0,1,2},"int32"),{1,3}))
assert(#results==2,"case 2322: result count")
check(results[1],{2,3},{-12,4},"int32",{{3,4,5},{0,1,2}})
check(results[2],{2,3},{0,4},"int32",{{0,1,2},{0,1,2}})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({0,1,2},"int32"),{3}),np.reshape(np.array({0,1,2,3,4,5},"int32"),{2,3}))
assert(#results==2,"case 2323: result count")
check(results[1],{2,3},{0,4},"int32",{{0,1,2},{0,1,2}})
check(results[2],{2,3},{12,4},"int32",{{0,1,2},{3,4,5}})
end
n=n+1
do local results=np.broadcast_arrays(np.flip(np.reshape(np.array({0,1,2},"int32"),{3}),1),np.reshape(np.array({0,1,2,3,4,5},"int32"),{2,3}))
assert(#results==2,"case 2324: result count")
check(results[1],{2,3},{0,-4},"int32",{{2,1,0},{2,1,0}})
check(results[2],{2,3},{12,4},"int32",{{0,1,2},{3,4,5}})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({0},"int32"),{}),np.reshape(np.array({0,1,2},"int32"),{3}))
assert(#results==2,"case 2325: result count")
check(results[1],{3},{0},"int32",{0,0,0})
check(results[2],{3},{4},"int32",{0,1,2})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({0},"int32"),{}),np.reshape(np.array({0,1,2},"int32"),{3}))
assert(#results==2,"case 2326: result count")
check(results[1],{3},{0},"int32",{0,0,0})
check(results[2],{3},{4},"int32",{0,1,2})
end
n=n+1
assert(not pcall(function()return np.broadcast_arrays(np.reshape(np.array({0,1,2,3,4,5},"int32"),{2,3}),np.reshape(np.array({0,1,2,3,4,5,6,7},"int32"),{2,4})) end),"case 2327: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_arrays(np.flip(np.reshape(np.array({0,1,2,3,4,5},"int32"),{2,3}),1),np.reshape(np.array({0,1,2,3,4,5,6,7},"int32"),{2,4})) end),"case 2328: expected rejection")
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({0},"int32"),{1,1}),np.reshape(np.array({0},"int32"),{1,1}))
assert(#results==2,"case 2329: result count")
check(results[1],{1,1},{4,4},"int32",{{0}})
check(results[2],{1,1},{4,4},"int32",{{0}})
end
n=n+1
do local results=np.broadcast_arrays(np.flip(np.reshape(np.array({0},"int32"),{1,1}),1),np.reshape(np.array({0},"int32"),{1,1}))
assert(#results==2,"case 2330: result count")
check(results[1],{1,1},{-4,4},"int32",{{0}})
check(results[2],{1,1},{4,4},"int32",{{0}})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({0,1,2,3},"int32"),{2,2}),np.reshape(np.array({0,1,2,3},"int32"),{2,2}))
assert(#results==2,"case 2331: result count")
check(results[1],{2,2},{8,4},"int32",{{0,1},{2,3}})
check(results[2],{2,2},{8,4},"int32",{{0,1},{2,3}})
end
n=n+1
do local results=np.broadcast_arrays(np.flip(np.reshape(np.array({0,1,2,3},"int32"),{2,2}),1),np.reshape(np.array({0,1,2,3},"int32"),{2,2}))
assert(#results==2,"case 2332: result count")
check(results[1],{2,2},{-8,4},"int32",{{2,3},{0,1}})
check(results[2],{2,2},{8,4},"int32",{{0,1},{2,3}})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({0},"int32"),{1}),np.reshape(np.array({0},"int32"),{1}))
assert(#results==2,"case 2333: result count")
check(results[1],{1},{4},"int32",{0})
check(results[2],{1},{4},"int32",{0})
end
n=n+1
do local results=np.broadcast_arrays(np.flip(np.reshape(np.array({0},"int32"),{1}),1),np.reshape(np.array({0},"int32"),{1}))
assert(#results==2,"case 2334: result count")
check(results[1],{1},{-4},"int32",{0})
check(results[2],{1},{4},"int32",{0})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({},"int32"),{0}),np.reshape(np.array({0},"int32"),{1}))
assert(#results==2,"case 2335: result count")
check(results[1],{0},{0},"int32",{})
check(results[2],{0},{0},"int32",{})
end
n=n+1
do local results=np.broadcast_arrays(np.flip(np.reshape(np.array({},"int32"),{0}),1),np.reshape(np.array({0},"int32"),{1}))
assert(#results==2,"case 2336: result count")
check(results[1],{0},{0},"int32",{})
check(results[2],{0},{0},"int32",{})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({0.0,1.0,2.0},"float64"),{1,3}),np.reshape(np.array({0.0,1.0},"float64"),{2,1}))
assert(#results==2,"case 2337: result count")
check(results[1],{2,3},{0,8},"float64",{{0.0,1.0,2.0},{0.0,1.0,2.0}})
check(results[2],{2,3},{8,0},"float64",{{0.0,0.0,0.0},{1.0,1.0,1.0}})
end
n=n+1
do local results=np.broadcast_arrays(np.flip(np.reshape(np.array({0.0,1.0,2.0},"float64"),{1,3}),1),np.reshape(np.array({0.0,1.0},"float64"),{2,1}))
assert(#results==2,"case 2338: result count")
check(results[1],{2,3},{0,8},"float64",{{0.0,1.0,2.0},{0.0,1.0,2.0}})
check(results[2],{2,3},{8,0},"float64",{{0.0,0.0,0.0},{1.0,1.0,1.0}})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({0.0,1.0,2.0,3.0,4.0,5.0},"float64"),{2,1,3}),np.reshape(np.array({0.0,1.0},"float64"),{1,2,1}))
assert(#results==2,"case 2339: result count")
check(results[1],{2,2,3},{24,0,8},"float64",{{{0.0,1.0,2.0},{0.0,1.0,2.0}},{{3.0,4.0,5.0},{3.0,4.0,5.0}}})
check(results[2],{2,2,3},{0,8,0},"float64",{{{0.0,0.0,0.0},{1.0,1.0,1.0}},{{0.0,0.0,0.0},{1.0,1.0,1.0}}})
end
n=n+1
do local results=np.broadcast_arrays(np.flip(np.reshape(np.array({0.0,1.0,2.0,3.0,4.0,5.0},"float64"),{2,1,3}),1),np.reshape(np.array({0.0,1.0},"float64"),{1,2,1}))
assert(#results==2,"case 2340: result count")
check(results[1],{2,2,3},{-24,0,8},"float64",{{{3.0,4.0,5.0},{3.0,4.0,5.0}},{{0.0,1.0,2.0},{0.0,1.0,2.0}}})
check(results[2],{2,2,3},{0,8,0},"float64",{{{0.0,0.0,0.0},{1.0,1.0,1.0}},{{0.0,0.0,0.0},{1.0,1.0,1.0}}})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({},"float64"),{1,0}),np.reshape(np.array({0.0,1.0},"float64"),{2,1}))
assert(#results==2,"case 2341: result count")
check(results[1],{2,0},{0,8},"float64",{{},{}})
check(results[2],{2,0},{8,0},"float64",{{},{}})
end
n=n+1
do local results=np.broadcast_arrays(np.flip(np.reshape(np.array({},"float64"),{1,0}),1),np.reshape(np.array({0.0,1.0},"float64"),{2,1}))
assert(#results==2,"case 2342: result count")
check(results[1],{2,0},{0,8},"float64",{{},{}})
check(results[2],{2,0},{8,0},"float64",{{},{}})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({},"float64"),{0,1}),np.reshape(np.array({0.0,1.0},"float64"),{1,2}))
assert(#results==2,"case 2343: result count")
check(results[1],{0,2},{8,0},"float64",{})
check(results[2],{0,2},{0,8},"float64",{})
end
n=n+1
do local results=np.broadcast_arrays(np.flip(np.reshape(np.array({},"float64"),{0,1}),1),np.reshape(np.array({0.0,1.0},"float64"),{1,2}))
assert(#results==2,"case 2344: result count")
check(results[1],{0,2},{8,0},"float64",{})
check(results[2],{0,2},{0,8},"float64",{})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({0.0,1.0,2.0,3.0,4.0,5.0},"float64"),{2,3}),np.reshape(np.array({0.0,1.0,2.0},"float64"),{1,3}))
assert(#results==2,"case 2345: result count")
check(results[1],{2,3},{24,8},"float64",{{0.0,1.0,2.0},{3.0,4.0,5.0}})
check(results[2],{2,3},{0,8},"float64",{{0.0,1.0,2.0},{0.0,1.0,2.0}})
end
n=n+1
do local results=np.broadcast_arrays(np.flip(np.reshape(np.array({0.0,1.0,2.0,3.0,4.0,5.0},"float64"),{2,3}),1),np.reshape(np.array({0.0,1.0,2.0},"float64"),{1,3}))
assert(#results==2,"case 2346: result count")
check(results[1],{2,3},{-24,8},"float64",{{3.0,4.0,5.0},{0.0,1.0,2.0}})
check(results[2],{2,3},{0,8},"float64",{{0.0,1.0,2.0},{0.0,1.0,2.0}})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({0.0,1.0,2.0},"float64"),{3}),np.reshape(np.array({0.0,1.0,2.0,3.0,4.0,5.0},"float64"),{2,3}))
assert(#results==2,"case 2347: result count")
check(results[1],{2,3},{0,8},"float64",{{0.0,1.0,2.0},{0.0,1.0,2.0}})
check(results[2],{2,3},{24,8},"float64",{{0.0,1.0,2.0},{3.0,4.0,5.0}})
end
n=n+1
do local results=np.broadcast_arrays(np.flip(np.reshape(np.array({0.0,1.0,2.0},"float64"),{3}),1),np.reshape(np.array({0.0,1.0,2.0,3.0,4.0,5.0},"float64"),{2,3}))
assert(#results==2,"case 2348: result count")
check(results[1],{2,3},{0,-8},"float64",{{2.0,1.0,0.0},{2.0,1.0,0.0}})
check(results[2],{2,3},{24,8},"float64",{{0.0,1.0,2.0},{3.0,4.0,5.0}})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({0.0},"float64"),{}),np.reshape(np.array({0.0,1.0,2.0},"float64"),{3}))
assert(#results==2,"case 2349: result count")
check(results[1],{3},{0},"float64",{0.0,0.0,0.0})
check(results[2],{3},{8},"float64",{0.0,1.0,2.0})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({0.0},"float64"),{}),np.reshape(np.array({0.0,1.0,2.0},"float64"),{3}))
assert(#results==2,"case 2350: result count")
check(results[1],{3},{0},"float64",{0.0,0.0,0.0})
check(results[2],{3},{8},"float64",{0.0,1.0,2.0})
end
n=n+1
assert(not pcall(function()return np.broadcast_arrays(np.reshape(np.array({0.0,1.0,2.0,3.0,4.0,5.0},"float64"),{2,3}),np.reshape(np.array({0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0},"float64"),{2,4})) end),"case 2351: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_arrays(np.flip(np.reshape(np.array({0.0,1.0,2.0,3.0,4.0,5.0},"float64"),{2,3}),1),np.reshape(np.array({0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0},"float64"),{2,4})) end),"case 2352: expected rejection")
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({0.0},"float64"),{1,1}),np.reshape(np.array({0.0},"float64"),{1,1}))
assert(#results==2,"case 2353: result count")
check(results[1],{1,1},{8,8},"float64",{{0.0}})
check(results[2],{1,1},{8,8},"float64",{{0.0}})
end
n=n+1
do local results=np.broadcast_arrays(np.flip(np.reshape(np.array({0.0},"float64"),{1,1}),1),np.reshape(np.array({0.0},"float64"),{1,1}))
assert(#results==2,"case 2354: result count")
check(results[1],{1,1},{-8,8},"float64",{{0.0}})
check(results[2],{1,1},{8,8},"float64",{{0.0}})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({0.0,1.0,2.0,3.0},"float64"),{2,2}),np.reshape(np.array({0.0,1.0,2.0,3.0},"float64"),{2,2}))
assert(#results==2,"case 2355: result count")
check(results[1],{2,2},{16,8},"float64",{{0.0,1.0},{2.0,3.0}})
check(results[2],{2,2},{16,8},"float64",{{0.0,1.0},{2.0,3.0}})
end
n=n+1
do local results=np.broadcast_arrays(np.flip(np.reshape(np.array({0.0,1.0,2.0,3.0},"float64"),{2,2}),1),np.reshape(np.array({0.0,1.0,2.0,3.0},"float64"),{2,2}))
assert(#results==2,"case 2356: result count")
check(results[1],{2,2},{-16,8},"float64",{{2.0,3.0},{0.0,1.0}})
check(results[2],{2,2},{16,8},"float64",{{0.0,1.0},{2.0,3.0}})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({0.0},"float64"),{1}),np.reshape(np.array({0.0},"float64"),{1}))
assert(#results==2,"case 2357: result count")
check(results[1],{1},{8},"float64",{0.0})
check(results[2],{1},{8},"float64",{0.0})
end
n=n+1
do local results=np.broadcast_arrays(np.flip(np.reshape(np.array({0.0},"float64"),{1}),1),np.reshape(np.array({0.0},"float64"),{1}))
assert(#results==2,"case 2358: result count")
check(results[1],{1},{-8},"float64",{0.0})
check(results[2],{1},{8},"float64",{0.0})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({},"float64"),{0}),np.reshape(np.array({0.0},"float64"),{1}))
assert(#results==2,"case 2359: result count")
check(results[1],{0},{0},"float64",{})
check(results[2],{0},{0},"float64",{})
end
n=n+1
do local results=np.broadcast_arrays(np.flip(np.reshape(np.array({},"float64"),{0}),1),np.reshape(np.array({0.0},"float64"),{1}))
assert(#results==2,"case 2360: result count")
check(results[1],{0},{0},"float64",{})
check(results[2],{0},{0},"float64",{})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({false,true,true},"bool"),{1,3}),np.reshape(np.array({false,true},"bool"),{2,1}))
assert(#results==2,"case 2361: result count")
check(results[1],{2,3},{0,1},"bool",{{false,true,true},{false,true,true}})
check(results[2],{2,3},{1,0},"bool",{{false,false,false},{true,true,true}})
end
n=n+1
do local results=np.broadcast_arrays(np.flip(np.reshape(np.array({false,true,true},"bool"),{1,3}),1),np.reshape(np.array({false,true},"bool"),{2,1}))
assert(#results==2,"case 2362: result count")
check(results[1],{2,3},{0,1},"bool",{{false,true,true},{false,true,true}})
check(results[2],{2,3},{1,0},"bool",{{false,false,false},{true,true,true}})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({false,true,true,true,true,true},"bool"),{2,1,3}),np.reshape(np.array({false,true},"bool"),{1,2,1}))
assert(#results==2,"case 2363: result count")
check(results[1],{2,2,3},{3,0,1},"bool",{{{false,true,true},{false,true,true}},{{true,true,true},{true,true,true}}})
check(results[2],{2,2,3},{0,1,0},"bool",{{{false,false,false},{true,true,true}},{{false,false,false},{true,true,true}}})
end
n=n+1
do local results=np.broadcast_arrays(np.flip(np.reshape(np.array({false,true,true,true,true,true},"bool"),{2,1,3}),1),np.reshape(np.array({false,true},"bool"),{1,2,1}))
assert(#results==2,"case 2364: result count")
check(results[1],{2,2,3},{-3,0,1},"bool",{{{true,true,true},{true,true,true}},{{false,true,true},{false,true,true}}})
check(results[2],{2,2,3},{0,1,0},"bool",{{{false,false,false},{true,true,true}},{{false,false,false},{true,true,true}}})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({},"bool"),{1,0}),np.reshape(np.array({false,true},"bool"),{2,1}))
assert(#results==2,"case 2365: result count")
check(results[1],{2,0},{0,1},"bool",{{},{}})
check(results[2],{2,0},{1,0},"bool",{{},{}})
end
n=n+1
do local results=np.broadcast_arrays(np.flip(np.reshape(np.array({},"bool"),{1,0}),1),np.reshape(np.array({false,true},"bool"),{2,1}))
assert(#results==2,"case 2366: result count")
check(results[1],{2,0},{0,1},"bool",{{},{}})
check(results[2],{2,0},{1,0},"bool",{{},{}})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({},"bool"),{0,1}),np.reshape(np.array({false,true},"bool"),{1,2}))
assert(#results==2,"case 2367: result count")
check(results[1],{0,2},{1,0},"bool",{})
check(results[2],{0,2},{0,1},"bool",{})
end
n=n+1
do local results=np.broadcast_arrays(np.flip(np.reshape(np.array({},"bool"),{0,1}),1),np.reshape(np.array({false,true},"bool"),{1,2}))
assert(#results==2,"case 2368: result count")
check(results[1],{0,2},{1,0},"bool",{})
check(results[2],{0,2},{0,1},"bool",{})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({false,true,true,true,true,true},"bool"),{2,3}),np.reshape(np.array({false,true,true},"bool"),{1,3}))
assert(#results==2,"case 2369: result count")
check(results[1],{2,3},{3,1},"bool",{{false,true,true},{true,true,true}})
check(results[2],{2,3},{0,1},"bool",{{false,true,true},{false,true,true}})
end
n=n+1
do local results=np.broadcast_arrays(np.flip(np.reshape(np.array({false,true,true,true,true,true},"bool"),{2,3}),1),np.reshape(np.array({false,true,true},"bool"),{1,3}))
assert(#results==2,"case 2370: result count")
check(results[1],{2,3},{-3,1},"bool",{{true,true,true},{false,true,true}})
check(results[2],{2,3},{0,1},"bool",{{false,true,true},{false,true,true}})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({false,true,true},"bool"),{3}),np.reshape(np.array({false,true,true,true,true,true},"bool"),{2,3}))
assert(#results==2,"case 2371: result count")
check(results[1],{2,3},{0,1},"bool",{{false,true,true},{false,true,true}})
check(results[2],{2,3},{3,1},"bool",{{false,true,true},{true,true,true}})
end
n=n+1
do local results=np.broadcast_arrays(np.flip(np.reshape(np.array({false,true,true},"bool"),{3}),1),np.reshape(np.array({false,true,true,true,true,true},"bool"),{2,3}))
assert(#results==2,"case 2372: result count")
check(results[1],{2,3},{0,-1},"bool",{{true,true,false},{true,true,false}})
check(results[2],{2,3},{3,1},"bool",{{false,true,true},{true,true,true}})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({false},"bool"),{}),np.reshape(np.array({false,true,true},"bool"),{3}))
assert(#results==2,"case 2373: result count")
check(results[1],{3},{0},"bool",{false,false,false})
check(results[2],{3},{1},"bool",{false,true,true})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({false},"bool"),{}),np.reshape(np.array({false,true,true},"bool"),{3}))
assert(#results==2,"case 2374: result count")
check(results[1],{3},{0},"bool",{false,false,false})
check(results[2],{3},{1},"bool",{false,true,true})
end
n=n+1
assert(not pcall(function()return np.broadcast_arrays(np.reshape(np.array({false,true,true,true,true,true},"bool"),{2,3}),np.reshape(np.array({false,true,true,true,true,true,true,true},"bool"),{2,4})) end),"case 2375: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_arrays(np.flip(np.reshape(np.array({false,true,true,true,true,true},"bool"),{2,3}),1),np.reshape(np.array({false,true,true,true,true,true,true,true},"bool"),{2,4})) end),"case 2376: expected rejection")
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({false},"bool"),{1,1}),np.reshape(np.array({false},"bool"),{1,1}))
assert(#results==2,"case 2377: result count")
check(results[1],{1,1},{1,1},"bool",{{false}})
check(results[2],{1,1},{1,1},"bool",{{false}})
end
n=n+1
do local results=np.broadcast_arrays(np.flip(np.reshape(np.array({false},"bool"),{1,1}),1),np.reshape(np.array({false},"bool"),{1,1}))
assert(#results==2,"case 2378: result count")
check(results[1],{1,1},{-1,1},"bool",{{false}})
check(results[2],{1,1},{1,1},"bool",{{false}})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({false,true,true,true},"bool"),{2,2}),np.reshape(np.array({false,true,true,true},"bool"),{2,2}))
assert(#results==2,"case 2379: result count")
check(results[1],{2,2},{2,1},"bool",{{false,true},{true,true}})
check(results[2],{2,2},{2,1},"bool",{{false,true},{true,true}})
end
n=n+1
do local results=np.broadcast_arrays(np.flip(np.reshape(np.array({false,true,true,true},"bool"),{2,2}),1),np.reshape(np.array({false,true,true,true},"bool"),{2,2}))
assert(#results==2,"case 2380: result count")
check(results[1],{2,2},{-2,1},"bool",{{true,true},{false,true}})
check(results[2],{2,2},{2,1},"bool",{{false,true},{true,true}})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({false},"bool"),{1}),np.reshape(np.array({false},"bool"),{1}))
assert(#results==2,"case 2381: result count")
check(results[1],{1},{1},"bool",{false})
check(results[2],{1},{1},"bool",{false})
end
n=n+1
do local results=np.broadcast_arrays(np.flip(np.reshape(np.array({false},"bool"),{1}),1),np.reshape(np.array({false},"bool"),{1}))
assert(#results==2,"case 2382: result count")
check(results[1],{1},{-1},"bool",{false})
check(results[2],{1},{1},"bool",{false})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({},"bool"),{0}),np.reshape(np.array({false},"bool"),{1}))
assert(#results==2,"case 2383: result count")
check(results[1],{0},{0},"bool",{})
check(results[2],{0},{0},"bool",{})
end
n=n+1
do local results=np.broadcast_arrays(np.flip(np.reshape(np.array({},"bool"),{0}),1),np.reshape(np.array({false},"bool"),{1}))
assert(#results==2,"case 2384: result count")
check(results[1],{0},{0},"bool",{})
check(results[2],{0},{0},"bool",{})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({"0","1","2"},"U2"),{1,3}),np.reshape(np.array({"0","1"},"U2"),{2,1}))
assert(#results==2,"case 2385: result count")
check(results[1],{2,3},{0,8},"<U2",{{"0","1","2"},{"0","1","2"}})
check(results[2],{2,3},{8,0},"<U2",{{"0","0","0"},{"1","1","1"}})
end
n=n+1
do local results=np.broadcast_arrays(np.flip(np.reshape(np.array({"0","1","2"},"U2"),{1,3}),1),np.reshape(np.array({"0","1"},"U2"),{2,1}))
assert(#results==2,"case 2386: result count")
check(results[1],{2,3},{0,8},"<U2",{{"0","1","2"},{"0","1","2"}})
check(results[2],{2,3},{8,0},"<U2",{{"0","0","0"},{"1","1","1"}})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({"0","1","2","3","4","5"},"U2"),{2,1,3}),np.reshape(np.array({"0","1"},"U2"),{1,2,1}))
assert(#results==2,"case 2387: result count")
check(results[1],{2,2,3},{24,0,8},"<U2",{{{"0","1","2"},{"0","1","2"}},{{"3","4","5"},{"3","4","5"}}})
check(results[2],{2,2,3},{0,8,0},"<U2",{{{"0","0","0"},{"1","1","1"}},{{"0","0","0"},{"1","1","1"}}})
end
n=n+1
do local results=np.broadcast_arrays(np.flip(np.reshape(np.array({"0","1","2","3","4","5"},"U2"),{2,1,3}),1),np.reshape(np.array({"0","1"},"U2"),{1,2,1}))
assert(#results==2,"case 2388: result count")
check(results[1],{2,2,3},{-24,0,8},"<U2",{{{"3","4","5"},{"3","4","5"}},{{"0","1","2"},{"0","1","2"}}})
check(results[2],{2,2,3},{0,8,0},"<U2",{{{"0","0","0"},{"1","1","1"}},{{"0","0","0"},{"1","1","1"}}})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({},"U2"),{1,0}),np.reshape(np.array({"0","1"},"U2"),{2,1}))
assert(#results==2,"case 2389: result count")
check(results[1],{2,0},{0,8},"<U2",{{},{}})
check(results[2],{2,0},{8,0},"<U2",{{},{}})
end
n=n+1
do local results=np.broadcast_arrays(np.flip(np.reshape(np.array({},"U2"),{1,0}),1),np.reshape(np.array({"0","1"},"U2"),{2,1}))
assert(#results==2,"case 2390: result count")
check(results[1],{2,0},{0,8},"<U2",{{},{}})
check(results[2],{2,0},{8,0},"<U2",{{},{}})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({},"U2"),{0,1}),np.reshape(np.array({"0","1"},"U2"),{1,2}))
assert(#results==2,"case 2391: result count")
check(results[1],{0,2},{8,0},"<U2",{})
check(results[2],{0,2},{0,8},"<U2",{})
end
n=n+1
do local results=np.broadcast_arrays(np.flip(np.reshape(np.array({},"U2"),{0,1}),1),np.reshape(np.array({"0","1"},"U2"),{1,2}))
assert(#results==2,"case 2392: result count")
check(results[1],{0,2},{8,0},"<U2",{})
check(results[2],{0,2},{0,8},"<U2",{})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({"0","1","2","3","4","5"},"U2"),{2,3}),np.reshape(np.array({"0","1","2"},"U2"),{1,3}))
assert(#results==2,"case 2393: result count")
check(results[1],{2,3},{24,8},"<U2",{{"0","1","2"},{"3","4","5"}})
check(results[2],{2,3},{0,8},"<U2",{{"0","1","2"},{"0","1","2"}})
end
n=n+1
do local results=np.broadcast_arrays(np.flip(np.reshape(np.array({"0","1","2","3","4","5"},"U2"),{2,3}),1),np.reshape(np.array({"0","1","2"},"U2"),{1,3}))
assert(#results==2,"case 2394: result count")
check(results[1],{2,3},{-24,8},"<U2",{{"3","4","5"},{"0","1","2"}})
check(results[2],{2,3},{0,8},"<U2",{{"0","1","2"},{"0","1","2"}})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({"0","1","2"},"U2"),{3}),np.reshape(np.array({"0","1","2","3","4","5"},"U2"),{2,3}))
assert(#results==2,"case 2395: result count")
check(results[1],{2,3},{0,8},"<U2",{{"0","1","2"},{"0","1","2"}})
check(results[2],{2,3},{24,8},"<U2",{{"0","1","2"},{"3","4","5"}})
end
n=n+1
do local results=np.broadcast_arrays(np.flip(np.reshape(np.array({"0","1","2"},"U2"),{3}),1),np.reshape(np.array({"0","1","2","3","4","5"},"U2"),{2,3}))
assert(#results==2,"case 2396: result count")
check(results[1],{2,3},{0,-8},"<U2",{{"2","1","0"},{"2","1","0"}})
check(results[2],{2,3},{24,8},"<U2",{{"0","1","2"},{"3","4","5"}})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({"0"},"U2"),{}),np.reshape(np.array({"0","1","2"},"U2"),{3}))
assert(#results==2,"case 2397: result count")
check(results[1],{3},{0},"<U2",{"0","0","0"})
check(results[2],{3},{8},"<U2",{"0","1","2"})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({"0"},"U2"),{}),np.reshape(np.array({"0","1","2"},"U2"),{3}))
assert(#results==2,"case 2398: result count")
check(results[1],{3},{0},"<U2",{"0","0","0"})
check(results[2],{3},{8},"<U2",{"0","1","2"})
end
n=n+1
assert(not pcall(function()return np.broadcast_arrays(np.reshape(np.array({"0","1","2","3","4","5"},"U2"),{2,3}),np.reshape(np.array({"0","1","2","3","4","5","6","7"},"U2"),{2,4})) end),"case 2399: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_arrays(np.flip(np.reshape(np.array({"0","1","2","3","4","5"},"U2"),{2,3}),1),np.reshape(np.array({"0","1","2","3","4","5","6","7"},"U2"),{2,4})) end),"case 2400: expected rejection")
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({"0"},"U2"),{1,1}),np.reshape(np.array({"0"},"U2"),{1,1}))
assert(#results==2,"case 2401: result count")
check(results[1],{1,1},{8,8},"<U2",{{"0"}})
check(results[2],{1,1},{8,8},"<U2",{{"0"}})
end
n=n+1
do local results=np.broadcast_arrays(np.flip(np.reshape(np.array({"0"},"U2"),{1,1}),1),np.reshape(np.array({"0"},"U2"),{1,1}))
assert(#results==2,"case 2402: result count")
check(results[1],{1,1},{-8,8},"<U2",{{"0"}})
check(results[2],{1,1},{8,8},"<U2",{{"0"}})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({"0","1","2","3"},"U2"),{2,2}),np.reshape(np.array({"0","1","2","3"},"U2"),{2,2}))
assert(#results==2,"case 2403: result count")
check(results[1],{2,2},{16,8},"<U2",{{"0","1"},{"2","3"}})
check(results[2],{2,2},{16,8},"<U2",{{"0","1"},{"2","3"}})
end
n=n+1
do local results=np.broadcast_arrays(np.flip(np.reshape(np.array({"0","1","2","3"},"U2"),{2,2}),1),np.reshape(np.array({"0","1","2","3"},"U2"),{2,2}))
assert(#results==2,"case 2404: result count")
check(results[1],{2,2},{-16,8},"<U2",{{"2","3"},{"0","1"}})
check(results[2],{2,2},{16,8},"<U2",{{"0","1"},{"2","3"}})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({"0"},"U2"),{1}),np.reshape(np.array({"0"},"U2"),{1}))
assert(#results==2,"case 2405: result count")
check(results[1],{1},{8},"<U2",{"0"})
check(results[2],{1},{8},"<U2",{"0"})
end
n=n+1
do local results=np.broadcast_arrays(np.flip(np.reshape(np.array({"0"},"U2"),{1}),1),np.reshape(np.array({"0"},"U2"),{1}))
assert(#results==2,"case 2406: result count")
check(results[1],{1},{-8},"<U2",{"0"})
check(results[2],{1},{8},"<U2",{"0"})
end
n=n+1
do local results=np.broadcast_arrays(np.reshape(np.array({},"U2"),{0}),np.reshape(np.array({"0"},"U2"),{1}))
assert(#results==2,"case 2407: result count")
check(results[1],{0},{0},"<U2",{})
check(results[2],{0},{0},"<U2",{})
end
n=n+1
do local results=np.broadcast_arrays(np.flip(np.reshape(np.array({},"U2"),{0}),1),np.reshape(np.array({"0"},"U2"),{1}))
assert(#results==2,"case 2408: result count")
check(results[1],{0},{0},"<U2",{})
check(results[2],{0},{0},"<U2",{})
end
n=n+1
equal(np.broadcast_shapes({},{}),{})
n=n+1
equal(np.broadcast_shapes({},{0}),{0})
n=n+1
equal(np.broadcast_shapes({},{1}),{1})
n=n+1
equal(np.broadcast_shapes({},{2}),{2})
n=n+1
equal(np.broadcast_shapes({},{3}),{3})
n=n+1
equal(np.broadcast_shapes({},{0,1}),{0,1})
n=n+1
equal(np.broadcast_shapes({},{1,0}),{1,0})
n=n+1
equal(np.broadcast_shapes({},{1,3}),{1,3})
n=n+1
equal(np.broadcast_shapes({},{3,1}),{3,1})
n=n+1
equal(np.broadcast_shapes({},{2,3}),{2,3})
n=n+1
equal(np.broadcast_shapes({},{3,2}),{3,2})
n=n+1
equal(np.broadcast_shapes({},{2,1,3}),{2,1,3})
n=n+1
equal(np.broadcast_shapes({},{1,2,1}),{1,2,1})
n=n+1
equal(np.broadcast_shapes({},{0,1,3}),{0,1,3})
n=n+1
equal(np.broadcast_shapes({},{2,2,3}),{2,2,3})
n=n+1
equal(np.broadcast_shapes({},{1,0,3}),{1,0,3})
n=n+1
equal(np.broadcast_shapes({},{2,0,3}),{2,0,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({},{-1,3}) end),"case 2426: expected rejection")
n=n+1
equal(np.broadcast_shapes({0},{}),{0})
n=n+1
equal(np.broadcast_shapes({0},{0}),{0})
n=n+1
equal(np.broadcast_shapes({0},{1}),{0})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{2}) end),"case 2430: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{3}) end),"case 2431: expected rejection")
n=n+1
equal(np.broadcast_shapes({0},{0,1}),{0,0})
n=n+1
equal(np.broadcast_shapes({0},{1,0}),{1,0})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{1,3}) end),"case 2434: expected rejection")
n=n+1
equal(np.broadcast_shapes({0},{3,1}),{3,0})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{2,3}) end),"case 2436: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{3,2}) end),"case 2437: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{2,1,3}) end),"case 2438: expected rejection")
n=n+1
equal(np.broadcast_shapes({0},{1,2,1}),{1,2,0})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{0,1,3}) end),"case 2440: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{2,2,3}) end),"case 2441: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{1,0,3}) end),"case 2442: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{2,0,3}) end),"case 2443: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{-1,3}) end),"case 2444: expected rejection")
n=n+1
equal(np.broadcast_shapes({1},{}),{1})
n=n+1
equal(np.broadcast_shapes({1},{0}),{0})
n=n+1
equal(np.broadcast_shapes({1},{1}),{1})
n=n+1
equal(np.broadcast_shapes({1},{2}),{2})
n=n+1
equal(np.broadcast_shapes({1},{3}),{3})
n=n+1
equal(np.broadcast_shapes({1},{0,1}),{0,1})
n=n+1
equal(np.broadcast_shapes({1},{1,0}),{1,0})
n=n+1
equal(np.broadcast_shapes({1},{1,3}),{1,3})
n=n+1
equal(np.broadcast_shapes({1},{3,1}),{3,1})
n=n+1
equal(np.broadcast_shapes({1},{2,3}),{2,3})
n=n+1
equal(np.broadcast_shapes({1},{3,2}),{3,2})
n=n+1
equal(np.broadcast_shapes({1},{2,1,3}),{2,1,3})
n=n+1
equal(np.broadcast_shapes({1},{1,2,1}),{1,2,1})
n=n+1
equal(np.broadcast_shapes({1},{0,1,3}),{0,1,3})
n=n+1
equal(np.broadcast_shapes({1},{2,2,3}),{2,2,3})
n=n+1
equal(np.broadcast_shapes({1},{1,0,3}),{1,0,3})
n=n+1
equal(np.broadcast_shapes({1},{2,0,3}),{2,0,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1},{-1,3}) end),"case 2462: expected rejection")
n=n+1
equal(np.broadcast_shapes({2},{}),{2})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{0}) end),"case 2464: expected rejection")
n=n+1
equal(np.broadcast_shapes({2},{1}),{2})
n=n+1
equal(np.broadcast_shapes({2},{2}),{2})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{3}) end),"case 2467: expected rejection")
n=n+1
equal(np.broadcast_shapes({2},{0,1}),{0,2})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{1,0}) end),"case 2469: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{1,3}) end),"case 2470: expected rejection")
n=n+1
equal(np.broadcast_shapes({2},{3,1}),{3,2})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{2,3}) end),"case 2472: expected rejection")
n=n+1
equal(np.broadcast_shapes({2},{3,2}),{3,2})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{2,1,3}) end),"case 2474: expected rejection")
n=n+1
equal(np.broadcast_shapes({2},{1,2,1}),{1,2,2})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{0,1,3}) end),"case 2476: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{2,2,3}) end),"case 2477: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{1,0,3}) end),"case 2478: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{2,0,3}) end),"case 2479: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{-1,3}) end),"case 2480: expected rejection")
n=n+1
equal(np.broadcast_shapes({3},{}),{3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({3},{0}) end),"case 2482: expected rejection")
n=n+1
equal(np.broadcast_shapes({3},{1}),{3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({3},{2}) end),"case 2484: expected rejection")
n=n+1
equal(np.broadcast_shapes({3},{3}),{3})
n=n+1
equal(np.broadcast_shapes({3},{0,1}),{0,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({3},{1,0}) end),"case 2487: expected rejection")
n=n+1
equal(np.broadcast_shapes({3},{1,3}),{1,3})
n=n+1
equal(np.broadcast_shapes({3},{3,1}),{3,3})
n=n+1
equal(np.broadcast_shapes({3},{2,3}),{2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({3},{3,2}) end),"case 2491: expected rejection")
n=n+1
equal(np.broadcast_shapes({3},{2,1,3}),{2,1,3})
n=n+1
equal(np.broadcast_shapes({3},{1,2,1}),{1,2,3})
n=n+1
equal(np.broadcast_shapes({3},{0,1,3}),{0,1,3})
n=n+1
equal(np.broadcast_shapes({3},{2,2,3}),{2,2,3})
n=n+1
equal(np.broadcast_shapes({3},{1,0,3}),{1,0,3})
n=n+1
equal(np.broadcast_shapes({3},{2,0,3}),{2,0,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({3},{-1,3}) end),"case 2498: expected rejection")
n=n+1
equal(np.broadcast_shapes({0,1},{}),{0,1})
n=n+1
equal(np.broadcast_shapes({0,1},{0}),{0,0})
n=n+1
equal(np.broadcast_shapes({0,1},{1}),{0,1})
n=n+1
equal(np.broadcast_shapes({0,1},{2}),{0,2})
n=n+1
equal(np.broadcast_shapes({0,1},{3}),{0,3})
n=n+1
equal(np.broadcast_shapes({0,1},{0,1}),{0,1})
n=n+1
equal(np.broadcast_shapes({0,1},{1,0}),{0,0})
n=n+1
equal(np.broadcast_shapes({0,1},{1,3}),{0,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0,1},{3,1}) end),"case 2507: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0,1},{2,3}) end),"case 2508: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0,1},{3,2}) end),"case 2509: expected rejection")
n=n+1
equal(np.broadcast_shapes({0,1},{2,1,3}),{2,0,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0,1},{1,2,1}) end),"case 2511: expected rejection")
n=n+1
equal(np.broadcast_shapes({0,1},{0,1,3}),{0,0,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0,1},{2,2,3}) end),"case 2513: expected rejection")
n=n+1
equal(np.broadcast_shapes({0,1},{1,0,3}),{1,0,3})
n=n+1
equal(np.broadcast_shapes({0,1},{2,0,3}),{2,0,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0,1},{-1,3}) end),"case 2516: expected rejection")
n=n+1
equal(np.broadcast_shapes({1,0},{}),{1,0})
n=n+1
equal(np.broadcast_shapes({1,0},{0}),{1,0})
n=n+1
equal(np.broadcast_shapes({1,0},{1}),{1,0})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,0},{2}) end),"case 2520: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,0},{3}) end),"case 2521: expected rejection")
n=n+1
equal(np.broadcast_shapes({1,0},{0,1}),{0,0})
n=n+1
equal(np.broadcast_shapes({1,0},{1,0}),{1,0})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,0},{1,3}) end),"case 2524: expected rejection")
n=n+1
equal(np.broadcast_shapes({1,0},{3,1}),{3,0})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,0},{2,3}) end),"case 2526: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,0},{3,2}) end),"case 2527: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,0},{2,1,3}) end),"case 2528: expected rejection")
n=n+1
equal(np.broadcast_shapes({1,0},{1,2,1}),{1,2,0})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,0},{0,1,3}) end),"case 2530: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,0},{2,2,3}) end),"case 2531: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,0},{1,0,3}) end),"case 2532: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,0},{2,0,3}) end),"case 2533: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,0},{-1,3}) end),"case 2534: expected rejection")
n=n+1
equal(np.broadcast_shapes({1,3},{}),{1,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,3},{0}) end),"case 2536: expected rejection")
n=n+1
equal(np.broadcast_shapes({1,3},{1}),{1,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,3},{2}) end),"case 2538: expected rejection")
n=n+1
equal(np.broadcast_shapes({1,3},{3}),{1,3})
n=n+1
equal(np.broadcast_shapes({1,3},{0,1}),{0,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,3},{1,0}) end),"case 2541: expected rejection")
n=n+1
equal(np.broadcast_shapes({1,3},{1,3}),{1,3})
n=n+1
equal(np.broadcast_shapes({1,3},{3,1}),{3,3})
n=n+1
equal(np.broadcast_shapes({1,3},{2,3}),{2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,3},{3,2}) end),"case 2545: expected rejection")
n=n+1
equal(np.broadcast_shapes({1,3},{2,1,3}),{2,1,3})
n=n+1
equal(np.broadcast_shapes({1,3},{1,2,1}),{1,2,3})
n=n+1
equal(np.broadcast_shapes({1,3},{0,1,3}),{0,1,3})
n=n+1
equal(np.broadcast_shapes({1,3},{2,2,3}),{2,2,3})
n=n+1
equal(np.broadcast_shapes({1,3},{1,0,3}),{1,0,3})
n=n+1
equal(np.broadcast_shapes({1,3},{2,0,3}),{2,0,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,3},{-1,3}) end),"case 2552: expected rejection")
n=n+1
equal(np.broadcast_shapes({3,1},{}),{3,1})
n=n+1
equal(np.broadcast_shapes({3,1},{0}),{3,0})
n=n+1
equal(np.broadcast_shapes({3,1},{1}),{3,1})
n=n+1
equal(np.broadcast_shapes({3,1},{2}),{3,2})
n=n+1
equal(np.broadcast_shapes({3,1},{3}),{3,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({3,1},{0,1}) end),"case 2558: expected rejection")
n=n+1
equal(np.broadcast_shapes({3,1},{1,0}),{3,0})
n=n+1
equal(np.broadcast_shapes({3,1},{1,3}),{3,3})
n=n+1
equal(np.broadcast_shapes({3,1},{3,1}),{3,1})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({3,1},{2,3}) end),"case 2562: expected rejection")
n=n+1
equal(np.broadcast_shapes({3,1},{3,2}),{3,2})
n=n+1
equal(np.broadcast_shapes({3,1},{2,1,3}),{2,3,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({3,1},{1,2,1}) end),"case 2565: expected rejection")
n=n+1
equal(np.broadcast_shapes({3,1},{0,1,3}),{0,3,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({3,1},{2,2,3}) end),"case 2567: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({3,1},{1,0,3}) end),"case 2568: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({3,1},{2,0,3}) end),"case 2569: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({3,1},{-1,3}) end),"case 2570: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,3},{}),{2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,3},{0}) end),"case 2572: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,3},{1}),{2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,3},{2}) end),"case 2574: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,3},{3}),{2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,3},{0,1}) end),"case 2576: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,3},{1,0}) end),"case 2577: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,3},{1,3}),{2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,3},{3,1}) end),"case 2579: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,3},{2,3}),{2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,3},{3,2}) end),"case 2581: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,3},{2,1,3}),{2,2,3})
n=n+1
equal(np.broadcast_shapes({2,3},{1,2,1}),{1,2,3})
n=n+1
equal(np.broadcast_shapes({2,3},{0,1,3}),{0,2,3})
n=n+1
equal(np.broadcast_shapes({2,3},{2,2,3}),{2,2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,3},{1,0,3}) end),"case 2586: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,3},{2,0,3}) end),"case 2587: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,3},{-1,3}) end),"case 2588: expected rejection")
n=n+1
equal(np.broadcast_shapes({3,2},{}),{3,2})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({3,2},{0}) end),"case 2590: expected rejection")
n=n+1
equal(np.broadcast_shapes({3,2},{1}),{3,2})
n=n+1
equal(np.broadcast_shapes({3,2},{2}),{3,2})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({3,2},{3}) end),"case 2593: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({3,2},{0,1}) end),"case 2594: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({3,2},{1,0}) end),"case 2595: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({3,2},{1,3}) end),"case 2596: expected rejection")
n=n+1
equal(np.broadcast_shapes({3,2},{3,1}),{3,2})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({3,2},{2,3}) end),"case 2598: expected rejection")
n=n+1
equal(np.broadcast_shapes({3,2},{3,2}),{3,2})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({3,2},{2,1,3}) end),"case 2600: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({3,2},{1,2,1}) end),"case 2601: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({3,2},{0,1,3}) end),"case 2602: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({3,2},{2,2,3}) end),"case 2603: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({3,2},{1,0,3}) end),"case 2604: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({3,2},{2,0,3}) end),"case 2605: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({3,2},{-1,3}) end),"case 2606: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,1,3},{}),{2,1,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,1,3},{0}) end),"case 2608: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,1,3},{1}),{2,1,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,1,3},{2}) end),"case 2610: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,1,3},{3}),{2,1,3})
n=n+1
equal(np.broadcast_shapes({2,1,3},{0,1}),{2,0,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,1,3},{1,0}) end),"case 2613: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,1,3},{1,3}),{2,1,3})
n=n+1
equal(np.broadcast_shapes({2,1,3},{3,1}),{2,3,3})
n=n+1
equal(np.broadcast_shapes({2,1,3},{2,3}),{2,2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,1,3},{3,2}) end),"case 2617: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,1,3},{2,1,3}),{2,1,3})
n=n+1
equal(np.broadcast_shapes({2,1,3},{1,2,1}),{2,2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,1,3},{0,1,3}) end),"case 2620: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,1,3},{2,2,3}),{2,2,3})
n=n+1
equal(np.broadcast_shapes({2,1,3},{1,0,3}),{2,0,3})
n=n+1
equal(np.broadcast_shapes({2,1,3},{2,0,3}),{2,0,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,1,3},{-1,3}) end),"case 2624: expected rejection")
n=n+1
equal(np.broadcast_shapes({1,2,1},{}),{1,2,1})
n=n+1
equal(np.broadcast_shapes({1,2,1},{0}),{1,2,0})
n=n+1
equal(np.broadcast_shapes({1,2,1},{1}),{1,2,1})
n=n+1
equal(np.broadcast_shapes({1,2,1},{2}),{1,2,2})
n=n+1
equal(np.broadcast_shapes({1,2,1},{3}),{1,2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,2,1},{0,1}) end),"case 2630: expected rejection")
n=n+1
equal(np.broadcast_shapes({1,2,1},{1,0}),{1,2,0})
n=n+1
equal(np.broadcast_shapes({1,2,1},{1,3}),{1,2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,2,1},{3,1}) end),"case 2633: expected rejection")
n=n+1
equal(np.broadcast_shapes({1,2,1},{2,3}),{1,2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,2,1},{3,2}) end),"case 2635: expected rejection")
n=n+1
equal(np.broadcast_shapes({1,2,1},{2,1,3}),{2,2,3})
n=n+1
equal(np.broadcast_shapes({1,2,1},{1,2,1}),{1,2,1})
n=n+1
equal(np.broadcast_shapes({1,2,1},{0,1,3}),{0,2,3})
n=n+1
equal(np.broadcast_shapes({1,2,1},{2,2,3}),{2,2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,2,1},{1,0,3}) end),"case 2640: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,2,1},{2,0,3}) end),"case 2641: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,2,1},{-1,3}) end),"case 2642: expected rejection")
n=n+1
equal(np.broadcast_shapes({0,1,3},{}),{0,1,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0,1,3},{0}) end),"case 2644: expected rejection")
n=n+1
equal(np.broadcast_shapes({0,1,3},{1}),{0,1,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0,1,3},{2}) end),"case 2646: expected rejection")
n=n+1
equal(np.broadcast_shapes({0,1,3},{3}),{0,1,3})
n=n+1
equal(np.broadcast_shapes({0,1,3},{0,1}),{0,0,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0,1,3},{1,0}) end),"case 2649: expected rejection")
n=n+1
equal(np.broadcast_shapes({0,1,3},{1,3}),{0,1,3})
n=n+1
equal(np.broadcast_shapes({0,1,3},{3,1}),{0,3,3})
n=n+1
equal(np.broadcast_shapes({0,1,3},{2,3}),{0,2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0,1,3},{3,2}) end),"case 2653: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0,1,3},{2,1,3}) end),"case 2654: expected rejection")
n=n+1
equal(np.broadcast_shapes({0,1,3},{1,2,1}),{0,2,3})
n=n+1
equal(np.broadcast_shapes({0,1,3},{0,1,3}),{0,1,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0,1,3},{2,2,3}) end),"case 2657: expected rejection")
n=n+1
equal(np.broadcast_shapes({0,1,3},{1,0,3}),{0,0,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0,1,3},{2,0,3}) end),"case 2659: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0,1,3},{-1,3}) end),"case 2660: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,2,3},{}),{2,2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,2,3},{0}) end),"case 2662: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,2,3},{1}),{2,2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,2,3},{2}) end),"case 2664: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,2,3},{3}),{2,2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,2,3},{0,1}) end),"case 2666: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,2,3},{1,0}) end),"case 2667: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,2,3},{1,3}),{2,2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,2,3},{3,1}) end),"case 2669: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,2,3},{2,3}),{2,2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,2,3},{3,2}) end),"case 2671: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,2,3},{2,1,3}),{2,2,3})
n=n+1
equal(np.broadcast_shapes({2,2,3},{1,2,1}),{2,2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,2,3},{0,1,3}) end),"case 2674: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,2,3},{2,2,3}),{2,2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,2,3},{1,0,3}) end),"case 2676: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,2,3},{2,0,3}) end),"case 2677: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,2,3},{-1,3}) end),"case 2678: expected rejection")
n=n+1
equal(np.broadcast_shapes({1,0,3},{}),{1,0,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,0,3},{0}) end),"case 2680: expected rejection")
n=n+1
equal(np.broadcast_shapes({1,0,3},{1}),{1,0,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,0,3},{2}) end),"case 2682: expected rejection")
n=n+1
equal(np.broadcast_shapes({1,0,3},{3}),{1,0,3})
n=n+1
equal(np.broadcast_shapes({1,0,3},{0,1}),{1,0,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,0,3},{1,0}) end),"case 2685: expected rejection")
n=n+1
equal(np.broadcast_shapes({1,0,3},{1,3}),{1,0,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,0,3},{3,1}) end),"case 2687: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,0,3},{2,3}) end),"case 2688: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,0,3},{3,2}) end),"case 2689: expected rejection")
n=n+1
equal(np.broadcast_shapes({1,0,3},{2,1,3}),{2,0,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,0,3},{1,2,1}) end),"case 2691: expected rejection")
n=n+1
equal(np.broadcast_shapes({1,0,3},{0,1,3}),{0,0,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,0,3},{2,2,3}) end),"case 2693: expected rejection")
n=n+1
equal(np.broadcast_shapes({1,0,3},{1,0,3}),{1,0,3})
n=n+1
equal(np.broadcast_shapes({1,0,3},{2,0,3}),{2,0,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,0,3},{-1,3}) end),"case 2696: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,0,3},{}),{2,0,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,0,3},{0}) end),"case 2698: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,0,3},{1}),{2,0,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,0,3},{2}) end),"case 2700: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,0,3},{3}),{2,0,3})
n=n+1
equal(np.broadcast_shapes({2,0,3},{0,1}),{2,0,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,0,3},{1,0}) end),"case 2703: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,0,3},{1,3}),{2,0,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,0,3},{3,1}) end),"case 2705: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,0,3},{2,3}) end),"case 2706: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,0,3},{3,2}) end),"case 2707: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,0,3},{2,1,3}),{2,0,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,0,3},{1,2,1}) end),"case 2709: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,0,3},{0,1,3}) end),"case 2710: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,0,3},{2,2,3}) end),"case 2711: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,0,3},{1,0,3}),{2,0,3})
n=n+1
equal(np.broadcast_shapes({2,0,3},{2,0,3}),{2,0,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,0,3},{-1,3}) end),"case 2714: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({-1,3},{}) end),"case 2715: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({-1,3},{0}) end),"case 2716: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({-1,3},{1}) end),"case 2717: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({-1,3},{2}) end),"case 2718: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({-1,3},{3}) end),"case 2719: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({-1,3},{0,1}) end),"case 2720: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({-1,3},{1,0}) end),"case 2721: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({-1,3},{1,3}) end),"case 2722: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({-1,3},{3,1}) end),"case 2723: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({-1,3},{2,3}) end),"case 2724: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({-1,3},{3,2}) end),"case 2725: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({-1,3},{2,1,3}) end),"case 2726: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({-1,3},{1,2,1}) end),"case 2727: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({-1,3},{0,1,3}) end),"case 2728: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({-1,3},{2,2,3}) end),"case 2729: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({-1,3},{1,0,3}) end),"case 2730: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({-1,3},{2,0,3}) end),"case 2731: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({-1,3},{-1,3}) end),"case 2732: expected rejection")
n=n+1
equal(np.broadcast_shapes({},{},{}),{})
n=n+1
equal(np.broadcast_shapes({},{},{0}),{0})
n=n+1
equal(np.broadcast_shapes({},{},{1}),{1})
n=n+1
equal(np.broadcast_shapes({},{},{2}),{2})
n=n+1
equal(np.broadcast_shapes({},{},{1,3}),{1,3})
n=n+1
equal(np.broadcast_shapes({},{},{2,1}),{2,1})
n=n+1
equal(np.broadcast_shapes({},{},{2,3}),{2,3})
n=n+1
equal(np.broadcast_shapes({},{0},{}),{0})
n=n+1
equal(np.broadcast_shapes({},{0},{0}),{0})
n=n+1
equal(np.broadcast_shapes({},{0},{1}),{0})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({},{0},{2}) end),"case 2743: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({},{0},{1,3}) end),"case 2744: expected rejection")
n=n+1
equal(np.broadcast_shapes({},{0},{2,1}),{2,0})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({},{0},{2,3}) end),"case 2746: expected rejection")
n=n+1
equal(np.broadcast_shapes({},{1},{}),{1})
n=n+1
equal(np.broadcast_shapes({},{1},{0}),{0})
n=n+1
equal(np.broadcast_shapes({},{1},{1}),{1})
n=n+1
equal(np.broadcast_shapes({},{1},{2}),{2})
n=n+1
equal(np.broadcast_shapes({},{1},{1,3}),{1,3})
n=n+1
equal(np.broadcast_shapes({},{1},{2,1}),{2,1})
n=n+1
equal(np.broadcast_shapes({},{1},{2,3}),{2,3})
n=n+1
equal(np.broadcast_shapes({},{2},{}),{2})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({},{2},{0}) end),"case 2755: expected rejection")
n=n+1
equal(np.broadcast_shapes({},{2},{1}),{2})
n=n+1
equal(np.broadcast_shapes({},{2},{2}),{2})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({},{2},{1,3}) end),"case 2758: expected rejection")
n=n+1
equal(np.broadcast_shapes({},{2},{2,1}),{2,2})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({},{2},{2,3}) end),"case 2760: expected rejection")
n=n+1
equal(np.broadcast_shapes({},{1,3},{}),{1,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({},{1,3},{0}) end),"case 2762: expected rejection")
n=n+1
equal(np.broadcast_shapes({},{1,3},{1}),{1,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({},{1,3},{2}) end),"case 2764: expected rejection")
n=n+1
equal(np.broadcast_shapes({},{1,3},{1,3}),{1,3})
n=n+1
equal(np.broadcast_shapes({},{1,3},{2,1}),{2,3})
n=n+1
equal(np.broadcast_shapes({},{1,3},{2,3}),{2,3})
n=n+1
equal(np.broadcast_shapes({},{2,1},{}),{2,1})
n=n+1
equal(np.broadcast_shapes({},{2,1},{0}),{2,0})
n=n+1
equal(np.broadcast_shapes({},{2,1},{1}),{2,1})
n=n+1
equal(np.broadcast_shapes({},{2,1},{2}),{2,2})
n=n+1
equal(np.broadcast_shapes({},{2,1},{1,3}),{2,3})
n=n+1
equal(np.broadcast_shapes({},{2,1},{2,1}),{2,1})
n=n+1
equal(np.broadcast_shapes({},{2,1},{2,3}),{2,3})
n=n+1
equal(np.broadcast_shapes({},{2,3},{}),{2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({},{2,3},{0}) end),"case 2776: expected rejection")
n=n+1
equal(np.broadcast_shapes({},{2,3},{1}),{2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({},{2,3},{2}) end),"case 2778: expected rejection")
n=n+1
equal(np.broadcast_shapes({},{2,3},{1,3}),{2,3})
n=n+1
equal(np.broadcast_shapes({},{2,3},{2,1}),{2,3})
n=n+1
equal(np.broadcast_shapes({},{2,3},{2,3}),{2,3})
n=n+1
equal(np.broadcast_shapes({0},{},{}),{0})
n=n+1
equal(np.broadcast_shapes({0},{},{0}),{0})
n=n+1
equal(np.broadcast_shapes({0},{},{1}),{0})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{},{2}) end),"case 2785: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{},{1,3}) end),"case 2786: expected rejection")
n=n+1
equal(np.broadcast_shapes({0},{},{2,1}),{2,0})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{},{2,3}) end),"case 2788: expected rejection")
n=n+1
equal(np.broadcast_shapes({0},{0},{}),{0})
n=n+1
equal(np.broadcast_shapes({0},{0},{0}),{0})
n=n+1
equal(np.broadcast_shapes({0},{0},{1}),{0})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{0},{2}) end),"case 2792: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{0},{1,3}) end),"case 2793: expected rejection")
n=n+1
equal(np.broadcast_shapes({0},{0},{2,1}),{2,0})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{0},{2,3}) end),"case 2795: expected rejection")
n=n+1
equal(np.broadcast_shapes({0},{1},{}),{0})
n=n+1
equal(np.broadcast_shapes({0},{1},{0}),{0})
n=n+1
equal(np.broadcast_shapes({0},{1},{1}),{0})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{1},{2}) end),"case 2799: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{1},{1,3}) end),"case 2800: expected rejection")
n=n+1
equal(np.broadcast_shapes({0},{1},{2,1}),{2,0})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{1},{2,3}) end),"case 2802: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{2},{}) end),"case 2803: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{2},{0}) end),"case 2804: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{2},{1}) end),"case 2805: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{2},{2}) end),"case 2806: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{2},{1,3}) end),"case 2807: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{2},{2,1}) end),"case 2808: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{2},{2,3}) end),"case 2809: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{1,3},{}) end),"case 2810: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{1,3},{0}) end),"case 2811: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{1,3},{1}) end),"case 2812: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{1,3},{2}) end),"case 2813: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{1,3},{1,3}) end),"case 2814: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{1,3},{2,1}) end),"case 2815: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{1,3},{2,3}) end),"case 2816: expected rejection")
n=n+1
equal(np.broadcast_shapes({0},{2,1},{}),{2,0})
n=n+1
equal(np.broadcast_shapes({0},{2,1},{0}),{2,0})
n=n+1
equal(np.broadcast_shapes({0},{2,1},{1}),{2,0})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{2,1},{2}) end),"case 2820: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{2,1},{1,3}) end),"case 2821: expected rejection")
n=n+1
equal(np.broadcast_shapes({0},{2,1},{2,1}),{2,0})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{2,1},{2,3}) end),"case 2823: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{2,3},{}) end),"case 2824: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{2,3},{0}) end),"case 2825: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{2,3},{1}) end),"case 2826: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{2,3},{2}) end),"case 2827: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{2,3},{1,3}) end),"case 2828: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{2,3},{2,1}) end),"case 2829: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({0},{2,3},{2,3}) end),"case 2830: expected rejection")
n=n+1
equal(np.broadcast_shapes({1},{},{}),{1})
n=n+1
equal(np.broadcast_shapes({1},{},{0}),{0})
n=n+1
equal(np.broadcast_shapes({1},{},{1}),{1})
n=n+1
equal(np.broadcast_shapes({1},{},{2}),{2})
n=n+1
equal(np.broadcast_shapes({1},{},{1,3}),{1,3})
n=n+1
equal(np.broadcast_shapes({1},{},{2,1}),{2,1})
n=n+1
equal(np.broadcast_shapes({1},{},{2,3}),{2,3})
n=n+1
equal(np.broadcast_shapes({1},{0},{}),{0})
n=n+1
equal(np.broadcast_shapes({1},{0},{0}),{0})
n=n+1
equal(np.broadcast_shapes({1},{0},{1}),{0})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1},{0},{2}) end),"case 2841: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1},{0},{1,3}) end),"case 2842: expected rejection")
n=n+1
equal(np.broadcast_shapes({1},{0},{2,1}),{2,0})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1},{0},{2,3}) end),"case 2844: expected rejection")
n=n+1
equal(np.broadcast_shapes({1},{1},{}),{1})
n=n+1
equal(np.broadcast_shapes({1},{1},{0}),{0})
n=n+1
equal(np.broadcast_shapes({1},{1},{1}),{1})
n=n+1
equal(np.broadcast_shapes({1},{1},{2}),{2})
n=n+1
equal(np.broadcast_shapes({1},{1},{1,3}),{1,3})
n=n+1
equal(np.broadcast_shapes({1},{1},{2,1}),{2,1})
n=n+1
equal(np.broadcast_shapes({1},{1},{2,3}),{2,3})
n=n+1
equal(np.broadcast_shapes({1},{2},{}),{2})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1},{2},{0}) end),"case 2853: expected rejection")
n=n+1
equal(np.broadcast_shapes({1},{2},{1}),{2})
n=n+1
equal(np.broadcast_shapes({1},{2},{2}),{2})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1},{2},{1,3}) end),"case 2856: expected rejection")
n=n+1
equal(np.broadcast_shapes({1},{2},{2,1}),{2,2})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1},{2},{2,3}) end),"case 2858: expected rejection")
n=n+1
equal(np.broadcast_shapes({1},{1,3},{}),{1,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1},{1,3},{0}) end),"case 2860: expected rejection")
n=n+1
equal(np.broadcast_shapes({1},{1,3},{1}),{1,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1},{1,3},{2}) end),"case 2862: expected rejection")
n=n+1
equal(np.broadcast_shapes({1},{1,3},{1,3}),{1,3})
n=n+1
equal(np.broadcast_shapes({1},{1,3},{2,1}),{2,3})
n=n+1
equal(np.broadcast_shapes({1},{1,3},{2,3}),{2,3})
n=n+1
equal(np.broadcast_shapes({1},{2,1},{}),{2,1})
n=n+1
equal(np.broadcast_shapes({1},{2,1},{0}),{2,0})
n=n+1
equal(np.broadcast_shapes({1},{2,1},{1}),{2,1})
n=n+1
equal(np.broadcast_shapes({1},{2,1},{2}),{2,2})
n=n+1
equal(np.broadcast_shapes({1},{2,1},{1,3}),{2,3})
n=n+1
equal(np.broadcast_shapes({1},{2,1},{2,1}),{2,1})
n=n+1
equal(np.broadcast_shapes({1},{2,1},{2,3}),{2,3})
n=n+1
equal(np.broadcast_shapes({1},{2,3},{}),{2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1},{2,3},{0}) end),"case 2874: expected rejection")
n=n+1
equal(np.broadcast_shapes({1},{2,3},{1}),{2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1},{2,3},{2}) end),"case 2876: expected rejection")
n=n+1
equal(np.broadcast_shapes({1},{2,3},{1,3}),{2,3})
n=n+1
equal(np.broadcast_shapes({1},{2,3},{2,1}),{2,3})
n=n+1
equal(np.broadcast_shapes({1},{2,3},{2,3}),{2,3})
n=n+1
equal(np.broadcast_shapes({2},{},{}),{2})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{},{0}) end),"case 2881: expected rejection")
n=n+1
equal(np.broadcast_shapes({2},{},{1}),{2})
n=n+1
equal(np.broadcast_shapes({2},{},{2}),{2})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{},{1,3}) end),"case 2884: expected rejection")
n=n+1
equal(np.broadcast_shapes({2},{},{2,1}),{2,2})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{},{2,3}) end),"case 2886: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{0},{}) end),"case 2887: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{0},{0}) end),"case 2888: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{0},{1}) end),"case 2889: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{0},{2}) end),"case 2890: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{0},{1,3}) end),"case 2891: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{0},{2,1}) end),"case 2892: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{0},{2,3}) end),"case 2893: expected rejection")
n=n+1
equal(np.broadcast_shapes({2},{1},{}),{2})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{1},{0}) end),"case 2895: expected rejection")
n=n+1
equal(np.broadcast_shapes({2},{1},{1}),{2})
n=n+1
equal(np.broadcast_shapes({2},{1},{2}),{2})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{1},{1,3}) end),"case 2898: expected rejection")
n=n+1
equal(np.broadcast_shapes({2},{1},{2,1}),{2,2})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{1},{2,3}) end),"case 2900: expected rejection")
n=n+1
equal(np.broadcast_shapes({2},{2},{}),{2})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{2},{0}) end),"case 2902: expected rejection")
n=n+1
equal(np.broadcast_shapes({2},{2},{1}),{2})
n=n+1
equal(np.broadcast_shapes({2},{2},{2}),{2})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{2},{1,3}) end),"case 2905: expected rejection")
n=n+1
equal(np.broadcast_shapes({2},{2},{2,1}),{2,2})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{2},{2,3}) end),"case 2907: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{1,3},{}) end),"case 2908: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{1,3},{0}) end),"case 2909: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{1,3},{1}) end),"case 2910: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{1,3},{2}) end),"case 2911: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{1,3},{1,3}) end),"case 2912: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{1,3},{2,1}) end),"case 2913: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{1,3},{2,3}) end),"case 2914: expected rejection")
n=n+1
equal(np.broadcast_shapes({2},{2,1},{}),{2,2})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{2,1},{0}) end),"case 2916: expected rejection")
n=n+1
equal(np.broadcast_shapes({2},{2,1},{1}),{2,2})
n=n+1
equal(np.broadcast_shapes({2},{2,1},{2}),{2,2})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{2,1},{1,3}) end),"case 2919: expected rejection")
n=n+1
equal(np.broadcast_shapes({2},{2,1},{2,1}),{2,2})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{2,1},{2,3}) end),"case 2921: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{2,3},{}) end),"case 2922: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{2,3},{0}) end),"case 2923: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{2,3},{1}) end),"case 2924: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{2,3},{2}) end),"case 2925: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{2,3},{1,3}) end),"case 2926: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{2,3},{2,1}) end),"case 2927: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2},{2,3},{2,3}) end),"case 2928: expected rejection")
n=n+1
equal(np.broadcast_shapes({1,3},{},{}),{1,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,3},{},{0}) end),"case 2930: expected rejection")
n=n+1
equal(np.broadcast_shapes({1,3},{},{1}),{1,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,3},{},{2}) end),"case 2932: expected rejection")
n=n+1
equal(np.broadcast_shapes({1,3},{},{1,3}),{1,3})
n=n+1
equal(np.broadcast_shapes({1,3},{},{2,1}),{2,3})
n=n+1
equal(np.broadcast_shapes({1,3},{},{2,3}),{2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,3},{0},{}) end),"case 2936: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,3},{0},{0}) end),"case 2937: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,3},{0},{1}) end),"case 2938: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,3},{0},{2}) end),"case 2939: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,3},{0},{1,3}) end),"case 2940: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,3},{0},{2,1}) end),"case 2941: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,3},{0},{2,3}) end),"case 2942: expected rejection")
n=n+1
equal(np.broadcast_shapes({1,3},{1},{}),{1,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,3},{1},{0}) end),"case 2944: expected rejection")
n=n+1
equal(np.broadcast_shapes({1,3},{1},{1}),{1,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,3},{1},{2}) end),"case 2946: expected rejection")
n=n+1
equal(np.broadcast_shapes({1,3},{1},{1,3}),{1,3})
n=n+1
equal(np.broadcast_shapes({1,3},{1},{2,1}),{2,3})
n=n+1
equal(np.broadcast_shapes({1,3},{1},{2,3}),{2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,3},{2},{}) end),"case 2950: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,3},{2},{0}) end),"case 2951: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,3},{2},{1}) end),"case 2952: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,3},{2},{2}) end),"case 2953: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,3},{2},{1,3}) end),"case 2954: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,3},{2},{2,1}) end),"case 2955: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,3},{2},{2,3}) end),"case 2956: expected rejection")
n=n+1
equal(np.broadcast_shapes({1,3},{1,3},{}),{1,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,3},{1,3},{0}) end),"case 2958: expected rejection")
n=n+1
equal(np.broadcast_shapes({1,3},{1,3},{1}),{1,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,3},{1,3},{2}) end),"case 2960: expected rejection")
n=n+1
equal(np.broadcast_shapes({1,3},{1,3},{1,3}),{1,3})
n=n+1
equal(np.broadcast_shapes({1,3},{1,3},{2,1}),{2,3})
n=n+1
equal(np.broadcast_shapes({1,3},{1,3},{2,3}),{2,3})
n=n+1
equal(np.broadcast_shapes({1,3},{2,1},{}),{2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,3},{2,1},{0}) end),"case 2965: expected rejection")
n=n+1
equal(np.broadcast_shapes({1,3},{2,1},{1}),{2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,3},{2,1},{2}) end),"case 2967: expected rejection")
n=n+1
equal(np.broadcast_shapes({1,3},{2,1},{1,3}),{2,3})
n=n+1
equal(np.broadcast_shapes({1,3},{2,1},{2,1}),{2,3})
n=n+1
equal(np.broadcast_shapes({1,3},{2,1},{2,3}),{2,3})
n=n+1
equal(np.broadcast_shapes({1,3},{2,3},{}),{2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,3},{2,3},{0}) end),"case 2972: expected rejection")
n=n+1
equal(np.broadcast_shapes({1,3},{2,3},{1}),{2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({1,3},{2,3},{2}) end),"case 2974: expected rejection")
n=n+1
equal(np.broadcast_shapes({1,3},{2,3},{1,3}),{2,3})
n=n+1
equal(np.broadcast_shapes({1,3},{2,3},{2,1}),{2,3})
n=n+1
equal(np.broadcast_shapes({1,3},{2,3},{2,3}),{2,3})
n=n+1
equal(np.broadcast_shapes({2,1},{},{}),{2,1})
n=n+1
equal(np.broadcast_shapes({2,1},{},{0}),{2,0})
n=n+1
equal(np.broadcast_shapes({2,1},{},{1}),{2,1})
n=n+1
equal(np.broadcast_shapes({2,1},{},{2}),{2,2})
n=n+1
equal(np.broadcast_shapes({2,1},{},{1,3}),{2,3})
n=n+1
equal(np.broadcast_shapes({2,1},{},{2,1}),{2,1})
n=n+1
equal(np.broadcast_shapes({2,1},{},{2,3}),{2,3})
n=n+1
equal(np.broadcast_shapes({2,1},{0},{}),{2,0})
n=n+1
equal(np.broadcast_shapes({2,1},{0},{0}),{2,0})
n=n+1
equal(np.broadcast_shapes({2,1},{0},{1}),{2,0})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,1},{0},{2}) end),"case 2988: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,1},{0},{1,3}) end),"case 2989: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,1},{0},{2,1}),{2,0})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,1},{0},{2,3}) end),"case 2991: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,1},{1},{}),{2,1})
n=n+1
equal(np.broadcast_shapes({2,1},{1},{0}),{2,0})
n=n+1
equal(np.broadcast_shapes({2,1},{1},{1}),{2,1})
n=n+1
equal(np.broadcast_shapes({2,1},{1},{2}),{2,2})
n=n+1
equal(np.broadcast_shapes({2,1},{1},{1,3}),{2,3})
n=n+1
equal(np.broadcast_shapes({2,1},{1},{2,1}),{2,1})
n=n+1
equal(np.broadcast_shapes({2,1},{1},{2,3}),{2,3})
n=n+1
equal(np.broadcast_shapes({2,1},{2},{}),{2,2})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,1},{2},{0}) end),"case 3000: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,1},{2},{1}),{2,2})
n=n+1
equal(np.broadcast_shapes({2,1},{2},{2}),{2,2})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,1},{2},{1,3}) end),"case 3003: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,1},{2},{2,1}),{2,2})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,1},{2},{2,3}) end),"case 3005: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,1},{1,3},{}),{2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,1},{1,3},{0}) end),"case 3007: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,1},{1,3},{1}),{2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,1},{1,3},{2}) end),"case 3009: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,1},{1,3},{1,3}),{2,3})
n=n+1
equal(np.broadcast_shapes({2,1},{1,3},{2,1}),{2,3})
n=n+1
equal(np.broadcast_shapes({2,1},{1,3},{2,3}),{2,3})
n=n+1
equal(np.broadcast_shapes({2,1},{2,1},{}),{2,1})
n=n+1
equal(np.broadcast_shapes({2,1},{2,1},{0}),{2,0})
n=n+1
equal(np.broadcast_shapes({2,1},{2,1},{1}),{2,1})
n=n+1
equal(np.broadcast_shapes({2,1},{2,1},{2}),{2,2})
n=n+1
equal(np.broadcast_shapes({2,1},{2,1},{1,3}),{2,3})
n=n+1
equal(np.broadcast_shapes({2,1},{2,1},{2,1}),{2,1})
n=n+1
equal(np.broadcast_shapes({2,1},{2,1},{2,3}),{2,3})
n=n+1
equal(np.broadcast_shapes({2,1},{2,3},{}),{2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,1},{2,3},{0}) end),"case 3021: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,1},{2,3},{1}),{2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,1},{2,3},{2}) end),"case 3023: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,1},{2,3},{1,3}),{2,3})
n=n+1
equal(np.broadcast_shapes({2,1},{2,3},{2,1}),{2,3})
n=n+1
equal(np.broadcast_shapes({2,1},{2,3},{2,3}),{2,3})
n=n+1
equal(np.broadcast_shapes({2,3},{},{}),{2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,3},{},{0}) end),"case 3028: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,3},{},{1}),{2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,3},{},{2}) end),"case 3030: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,3},{},{1,3}),{2,3})
n=n+1
equal(np.broadcast_shapes({2,3},{},{2,1}),{2,3})
n=n+1
equal(np.broadcast_shapes({2,3},{},{2,3}),{2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,3},{0},{}) end),"case 3034: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,3},{0},{0}) end),"case 3035: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,3},{0},{1}) end),"case 3036: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,3},{0},{2}) end),"case 3037: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,3},{0},{1,3}) end),"case 3038: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,3},{0},{2,1}) end),"case 3039: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,3},{0},{2,3}) end),"case 3040: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,3},{1},{}),{2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,3},{1},{0}) end),"case 3042: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,3},{1},{1}),{2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,3},{1},{2}) end),"case 3044: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,3},{1},{1,3}),{2,3})
n=n+1
equal(np.broadcast_shapes({2,3},{1},{2,1}),{2,3})
n=n+1
equal(np.broadcast_shapes({2,3},{1},{2,3}),{2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,3},{2},{}) end),"case 3048: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,3},{2},{0}) end),"case 3049: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,3},{2},{1}) end),"case 3050: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,3},{2},{2}) end),"case 3051: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,3},{2},{1,3}) end),"case 3052: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,3},{2},{2,1}) end),"case 3053: expected rejection")
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,3},{2},{2,3}) end),"case 3054: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,3},{1,3},{}),{2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,3},{1,3},{0}) end),"case 3056: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,3},{1,3},{1}),{2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,3},{1,3},{2}) end),"case 3058: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,3},{1,3},{1,3}),{2,3})
n=n+1
equal(np.broadcast_shapes({2,3},{1,3},{2,1}),{2,3})
n=n+1
equal(np.broadcast_shapes({2,3},{1,3},{2,3}),{2,3})
n=n+1
equal(np.broadcast_shapes({2,3},{2,1},{}),{2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,3},{2,1},{0}) end),"case 3063: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,3},{2,1},{1}),{2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,3},{2,1},{2}) end),"case 3065: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,3},{2,1},{1,3}),{2,3})
n=n+1
equal(np.broadcast_shapes({2,3},{2,1},{2,1}),{2,3})
n=n+1
equal(np.broadcast_shapes({2,3},{2,1},{2,3}),{2,3})
n=n+1
equal(np.broadcast_shapes({2,3},{2,3},{}),{2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,3},{2,3},{0}) end),"case 3070: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,3},{2,3},{1}),{2,3})
n=n+1
assert(not pcall(function()return np.broadcast_shapes({2,3},{2,3},{2}) end),"case 3072: expected rejection")
n=n+1
equal(np.broadcast_shapes({2,3},{2,3},{1,3}),{2,3})
n=n+1
equal(np.broadcast_shapes({2,3},{2,3},{2,1}),{2,3})
n=n+1
equal(np.broadcast_shapes({2,3},{2,3},{2,3}),{2,3})
n=n+1
equal(np.broadcast_shapes(),{})
n=n+1
do local results=np.broadcast_arrays()
assert(#results==0,"case 3077: result count")
end
n=n+1
print('broadcast differential: 1034/1034 matches, 2043/2043 rejected (total 3077)')
