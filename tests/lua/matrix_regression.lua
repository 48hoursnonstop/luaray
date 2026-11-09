local np = require('luaray')
local checks = 0
local function check(value) checks = checks + 1; assert(value) end
local function reject(call) check(not pcall(call)) end
local a = np.array({{1,2,3},{4,5,6}}, 'int32')
local d = np.diagonal(a)
check(d.shape[1] == 2 and d[1] == 1 and d[2] == 5)
check(np.shares_memory(a,d))
reject(function() d[1] = 9 end)
a:set(20, 2, 2); check(d[2] == 20)
check(a:diagonal(1)[2] == 6)
check(np.diagonal(a, {offset=-1,axis1=1,axis2=2})[1] == 4)
check(np.diagonal(a,0,2,1)[2] == 20)
check(np.diag(a,-1)[1] == 4)
check(np.diagonal(a,2147483647).size == 0)
check(np.diagonal(a,-2147483648).size == 0) -- safe empty result; no signed negation overflow
for _, dtype in ipairs({'bool','int8','uint64','float16','float64','complex128','S4','U4','datetime64[ms]','timedelta64[h]'}) do
 local x = np.array({1,2,3}, dtype)
 local y = np.diag(x,{k=1})
 check(y.shape[1] == 4 and y.shape[2] == 4 and y.dtype == x.dtype)
 check(not np.shares_memory(x,y))
 check(np.diagonal(y,1).strides[1] == y.itemsize*5)
end
local flat = np.diagflat(np.transpose(a),-1)
check(flat.shape[1] == 7 and flat:get(2,1) == 1 and flat:get(3,2) == 4)
check(flat:get(4,3) == 2 and flat:get(5,4) == 20)
local reversed = np.diag(np.flip(np.array({1,2,3},'int32')))
check(reversed:get(1,1) == 3 and reversed:get(3,3) == 1)
local zero = np.diag(np.array({},'float64'))
check(zero.shape[1] == 0 and zero.shape[2] == 0)
local retained = np.diagonal(np.array({{7,8},{9,10}}))
collectgarbage('collect');check(retained[2] == 10)
for _, call in ipairs({
 function() np.diag(2) end,
 function() np.diag(np.zeros({2,2,2})) end,
 function() np.diagonal({1,2}) end,
 function() np.diagonal(a,0,1,1) end,
 function() np.diagonal(a,0,0,2) end,
 function() np.diagonal(a,0,1,3) end,
 function() np.diagonal(a,2147483648) end,
 function() np.diagonal(a,{axis1=1.5}) end,
 function() np.diagonal(a,{offset=true}) end,
 function() np.diagonal(a,{unknown=1}) end,
 function() np.diagonal(a,{['axis1\0']=1}) end,
 function() np.diagonal(a,{},2) end,
 function() np.diagonal(a,0,1,2,3) end,
 function() np.diag(a,{axis1=1}) end,
 function() np.diag(a,1.5) end,
 function() np.diagflat(a,math.mininteger) end,
 function() np.diag({},math.maxinteger) end,
}) do reject(call) end
print('matrix regression: '..checks..' checks passed')
