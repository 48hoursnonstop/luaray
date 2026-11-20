local lr=require('luaray')
local input=lr.array({{{1,2,3},{4,5,6}},{{7,8,9},{10,11,12}}})
local parts=lr.unstack(input,-1)
assert(#parts==3 and lr.shares_memory(input,parts[3]))
assert(parts[3][2][2]==12)
parts[3]:set(42,2,2)
assert(input[2][2][3]==42)
assert(lr.matrix_transpose(input)[2][3][2]==42)
assert(lr.permute_dims(input,{-1,1,2})[3][2][2]==42)
assert(lr.unstack({1,2})[2]==2)
assert(#lr.unstack(lr.empty({0,2}))==0)
assert(not pcall(lr.unstack,lr.array(1)))
assert(not pcall(lr.matrix_transpose,{1,2}))
assert(not pcall(lr.permute_dims,input,{1,1,2}))

local n=2048
local inputs={}
for i=1,n do inputs[i]={i} end
assert(lr.concat(inputs)[n]==n)
assert(lr.stack(inputs)[n][1]==n)
assert(lr.hstack(inputs)[n]==n)
assert(lr.vstack(inputs)[n][1]==n)
assert(lr.dstack(inputs)[1][1][n]==n)
assert(lr.column_stack(inputs)[1][n]==n)
inputs[1024]=false
local ok,message=pcall(lr.concat,inputs)
assert(not ok and message:find('1024',1,true))
print('Array API layout regression passed')
