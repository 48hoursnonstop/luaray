-- Original NumPy 2.5.3; nonzero coordinates adapted to positive Lua indices.
local np=require('luaray_core')
local cases,checks=0,0
local function eq(a,b,label)
 checks=checks+1
 if type(b)=='table' then
  assert(type(a)=='table' and #a==#b,label..': shape')
  for i=1,#b do eq(a[i],b[i],label..'['..i..']') end
 elseif type(b)=='number' and b~=b then assert(a~=a,label..': NaN')
 elseif type(b)=='userdata' then eq(a.real,b.real,label..'.real');eq(a.imag,b.imag,label..'.imag')
 else assert(a==b,label..': '..tostring(a)..' != '..tostring(b)) end
end

do
local function chunk()
-- 1: int8/plain/condition/(2, 3); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8")
local a=base
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int8/plain/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{0,2,4},"int8/plain/condition/(2, 3): result")
eq(result.shape,{3},"int8/plain/condition/(2, 3): result: shape")
eq(result.strides,{1},"int8/plain/condition/(2, 3): result: strides")
eq(result.dtype,"int8","int8/plain/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8/plain/condition/(2, 3): backing source")
eq(base.shape,{3,4},"int8/plain/condition/(2, 3): backing source: shape")
eq(base.strides,{4,1},"int8/plain/condition/(2, 3): backing source: strides")
eq(base.dtype,"int8","int8/plain/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"int8/plain/condition/(2, 3): source shape")
eq(a.strides,{4,1},"int8/plain/condition/(2, 3): source strides")
cases=cases+1
end
-- 2: int8/plain/condition/(12,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8")
local a=base
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int8/plain/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0,2,4,6,8,10},"int8/plain/condition/(12,): result")
eq(result.shape,{6},"int8/plain/condition/(12,): result: shape")
eq(result.strides,{1},"int8/plain/condition/(12,): result: strides")
eq(result.dtype,"int8","int8/plain/condition/(12,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8/plain/condition/(12,): backing source")
eq(base.shape,{3,4},"int8/plain/condition/(12,): backing source: shape")
eq(base.strides,{4,1},"int8/plain/condition/(12,): backing source: strides")
eq(base.dtype,"int8","int8/plain/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"int8/plain/condition/(12,): source shape")
eq(a.strides,{4,1},"int8/plain/condition/(12,): source strides")
cases=cases+1
end
-- 3: int8/plain/condition/(14,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8")
local a=base
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"int8/plain/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8/plain/condition/(14,): backing source")
eq(base.shape,{3,4},"int8/plain/condition/(14,): backing source: shape")
eq(base.strides,{4,1},"int8/plain/condition/(14,): backing source: strides")
eq(base.dtype,"int8","int8/plain/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"int8/plain/condition/(14,): source shape")
eq(a.strides,{4,1},"int8/plain/condition/(14,): source strides")
cases=cases+1
end
-- 4: int8/plain/condition/(0,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int8/plain/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"int8/plain/condition/(0,): result")
eq(result.shape,{0},"int8/plain/condition/(0,): result: shape")
eq(result.strides,{0},"int8/plain/condition/(0,): result: strides")
eq(result.dtype,"int8","int8/plain/condition/(0,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8/plain/condition/(0,): backing source")
eq(base.shape,{3,4},"int8/plain/condition/(0,): backing source: shape")
eq(base.strides,{4,1},"int8/plain/condition/(0,): backing source: strides")
eq(base.dtype,"int8","int8/plain/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"int8/plain/condition/(0,): source shape")
eq(a.strides,{4,1},"int8/plain/condition/(0,): source strides")
cases=cases+1
end
-- 5: int8/plain/condition/(); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int8/plain/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{0},"int8/plain/condition/(): result")
eq(result.shape,{1},"int8/plain/condition/(): result: shape")
eq(result.strides,{1},"int8/plain/condition/(): result: strides")
eq(result.dtype,"int8","int8/plain/condition/(): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8/plain/condition/(): backing source")
eq(base.shape,{3,4},"int8/plain/condition/(): backing source: shape")
eq(base.strides,{4,1},"int8/plain/condition/(): backing source: strides")
eq(base.dtype,"int8","int8/plain/condition/(): backing source: dtype")
eq(a.shape,{3,4},"int8/plain/condition/(): source shape")
eq(a.strides,{4,1},"int8/plain/condition/(): source strides")
cases=cases+1
end
-- 6: int8/transpose/condition/(2, 3); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8")
local a=np.transpose(base)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int8/transpose/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{0,8,5},"int8/transpose/condition/(2, 3): result")
eq(result.shape,{3},"int8/transpose/condition/(2, 3): result: shape")
eq(result.strides,{1},"int8/transpose/condition/(2, 3): result: strides")
eq(result.dtype,"int8","int8/transpose/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8/transpose/condition/(2, 3): backing source")
eq(base.shape,{3,4},"int8/transpose/condition/(2, 3): backing source: shape")
eq(base.strides,{4,1},"int8/transpose/condition/(2, 3): backing source: strides")
eq(base.dtype,"int8","int8/transpose/condition/(2, 3): backing source: dtype")
eq(a.shape,{4,3},"int8/transpose/condition/(2, 3): source shape")
eq(a.strides,{1,4},"int8/transpose/condition/(2, 3): source strides")
cases=cases+1
end
-- 7: int8/transpose/condition/(12,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8")
local a=np.transpose(base)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int8/transpose/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0,8,5,2,10,7},"int8/transpose/condition/(12,): result")
eq(result.shape,{6},"int8/transpose/condition/(12,): result: shape")
eq(result.strides,{1},"int8/transpose/condition/(12,): result: strides")
eq(result.dtype,"int8","int8/transpose/condition/(12,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8/transpose/condition/(12,): backing source")
eq(base.shape,{3,4},"int8/transpose/condition/(12,): backing source: shape")
eq(base.strides,{4,1},"int8/transpose/condition/(12,): backing source: strides")
eq(base.dtype,"int8","int8/transpose/condition/(12,): backing source: dtype")
eq(a.shape,{4,3},"int8/transpose/condition/(12,): source shape")
eq(a.strides,{1,4},"int8/transpose/condition/(12,): source strides")
cases=cases+1
end
-- 8: int8/transpose/condition/(14,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8")
local a=np.transpose(base)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"int8/transpose/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8/transpose/condition/(14,): backing source")
eq(base.shape,{3,4},"int8/transpose/condition/(14,): backing source: shape")
eq(base.strides,{4,1},"int8/transpose/condition/(14,): backing source: strides")
eq(base.dtype,"int8","int8/transpose/condition/(14,): backing source: dtype")
eq(a.shape,{4,3},"int8/transpose/condition/(14,): source shape")
eq(a.strides,{1,4},"int8/transpose/condition/(14,): source strides")
cases=cases+1
end
-- 9: int8/transpose/condition/(0,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8")
local a=np.transpose(base)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int8/transpose/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"int8/transpose/condition/(0,): result")
eq(result.shape,{0},"int8/transpose/condition/(0,): result: shape")
eq(result.strides,{0},"int8/transpose/condition/(0,): result: strides")
eq(result.dtype,"int8","int8/transpose/condition/(0,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8/transpose/condition/(0,): backing source")
eq(base.shape,{3,4},"int8/transpose/condition/(0,): backing source: shape")
eq(base.strides,{4,1},"int8/transpose/condition/(0,): backing source: strides")
eq(base.dtype,"int8","int8/transpose/condition/(0,): backing source: dtype")
eq(a.shape,{4,3},"int8/transpose/condition/(0,): source shape")
eq(a.strides,{1,4},"int8/transpose/condition/(0,): source strides")
cases=cases+1
end
-- 10: int8/transpose/condition/(); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8")
local a=np.transpose(base)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int8/transpose/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{0},"int8/transpose/condition/(): result")
eq(result.shape,{1},"int8/transpose/condition/(): result: shape")
eq(result.strides,{1},"int8/transpose/condition/(): result: strides")
eq(result.dtype,"int8","int8/transpose/condition/(): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8/transpose/condition/(): backing source")
eq(base.shape,{3,4},"int8/transpose/condition/(): backing source: shape")
eq(base.strides,{4,1},"int8/transpose/condition/(): backing source: strides")
eq(base.dtype,"int8","int8/transpose/condition/(): backing source: dtype")
eq(a.shape,{4,3},"int8/transpose/condition/(): source shape")
eq(a.strides,{1,4},"int8/transpose/condition/(): source strides")
cases=cases+1
end
-- 11: int8/reverse_columns/condition/(2, 3); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8")
local a=np.flip(base,2)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int8/reverse_columns/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{3,1,7},"int8/reverse_columns/condition/(2, 3): result")
eq(result.shape,{3},"int8/reverse_columns/condition/(2, 3): result: shape")
eq(result.strides,{1},"int8/reverse_columns/condition/(2, 3): result: strides")
eq(result.dtype,"int8","int8/reverse_columns/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8/reverse_columns/condition/(2, 3): backing source")
eq(base.shape,{3,4},"int8/reverse_columns/condition/(2, 3): backing source: shape")
eq(base.strides,{4,1},"int8/reverse_columns/condition/(2, 3): backing source: strides")
eq(base.dtype,"int8","int8/reverse_columns/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"int8/reverse_columns/condition/(2, 3): source shape")
eq(a.strides,{4,-1},"int8/reverse_columns/condition/(2, 3): source strides")
cases=cases+1
end
-- 12: int8/reverse_columns/condition/(12,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8")
local a=np.flip(base,2)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int8/reverse_columns/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{3,1,7,5,11,9},"int8/reverse_columns/condition/(12,): result")
eq(result.shape,{6},"int8/reverse_columns/condition/(12,): result: shape")
eq(result.strides,{1},"int8/reverse_columns/condition/(12,): result: strides")
eq(result.dtype,"int8","int8/reverse_columns/condition/(12,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8/reverse_columns/condition/(12,): backing source")
eq(base.shape,{3,4},"int8/reverse_columns/condition/(12,): backing source: shape")
eq(base.strides,{4,1},"int8/reverse_columns/condition/(12,): backing source: strides")
eq(base.dtype,"int8","int8/reverse_columns/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"int8/reverse_columns/condition/(12,): source shape")
eq(a.strides,{4,-1},"int8/reverse_columns/condition/(12,): source strides")
cases=cases+1
end
-- 13: int8/reverse_columns/condition/(14,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8")
local a=np.flip(base,2)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"int8/reverse_columns/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8/reverse_columns/condition/(14,): backing source")
eq(base.shape,{3,4},"int8/reverse_columns/condition/(14,): backing source: shape")
eq(base.strides,{4,1},"int8/reverse_columns/condition/(14,): backing source: strides")
eq(base.dtype,"int8","int8/reverse_columns/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"int8/reverse_columns/condition/(14,): source shape")
eq(a.strides,{4,-1},"int8/reverse_columns/condition/(14,): source strides")
cases=cases+1
end
-- 14: int8/reverse_columns/condition/(0,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8")
local a=np.flip(base,2)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int8/reverse_columns/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"int8/reverse_columns/condition/(0,): result")
eq(result.shape,{0},"int8/reverse_columns/condition/(0,): result: shape")
eq(result.strides,{0},"int8/reverse_columns/condition/(0,): result: strides")
eq(result.dtype,"int8","int8/reverse_columns/condition/(0,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8/reverse_columns/condition/(0,): backing source")
eq(base.shape,{3,4},"int8/reverse_columns/condition/(0,): backing source: shape")
eq(base.strides,{4,1},"int8/reverse_columns/condition/(0,): backing source: strides")
eq(base.dtype,"int8","int8/reverse_columns/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"int8/reverse_columns/condition/(0,): source shape")
eq(a.strides,{4,-1},"int8/reverse_columns/condition/(0,): source strides")
cases=cases+1
end
-- 15: int8/reverse_columns/condition/(); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8")
local a=np.flip(base,2)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int8/reverse_columns/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{3},"int8/reverse_columns/condition/(): result")
eq(result.shape,{1},"int8/reverse_columns/condition/(): result: shape")
eq(result.strides,{1},"int8/reverse_columns/condition/(): result: strides")
eq(result.dtype,"int8","int8/reverse_columns/condition/(): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8/reverse_columns/condition/(): backing source")
eq(base.shape,{3,4},"int8/reverse_columns/condition/(): backing source: shape")
eq(base.strides,{4,1},"int8/reverse_columns/condition/(): backing source: strides")
eq(base.dtype,"int8","int8/reverse_columns/condition/(): backing source: dtype")
eq(a.shape,{3,4},"int8/reverse_columns/condition/(): source shape")
eq(a.strides,{4,-1},"int8/reverse_columns/condition/(): source strides")
cases=cases+1
end
-- 16: int8/reverse_rows/condition/(2, 3); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8")
local a=np.flip(base,1)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int8/reverse_rows/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{8,10,4},"int8/reverse_rows/condition/(2, 3): result")
eq(result.shape,{3},"int8/reverse_rows/condition/(2, 3): result: shape")
eq(result.strides,{1},"int8/reverse_rows/condition/(2, 3): result: strides")
eq(result.dtype,"int8","int8/reverse_rows/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8/reverse_rows/condition/(2, 3): backing source")
eq(base.shape,{3,4},"int8/reverse_rows/condition/(2, 3): backing source: shape")
eq(base.strides,{4,1},"int8/reverse_rows/condition/(2, 3): backing source: strides")
eq(base.dtype,"int8","int8/reverse_rows/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"int8/reverse_rows/condition/(2, 3): source shape")
eq(a.strides,{-4,1},"int8/reverse_rows/condition/(2, 3): source strides")
cases=cases+1
end
-- 17: int8/reverse_rows/condition/(12,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8")
local a=np.flip(base,1)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int8/reverse_rows/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{8,10,4,6,0,2},"int8/reverse_rows/condition/(12,): result")
eq(result.shape,{6},"int8/reverse_rows/condition/(12,): result: shape")
eq(result.strides,{1},"int8/reverse_rows/condition/(12,): result: strides")
eq(result.dtype,"int8","int8/reverse_rows/condition/(12,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8/reverse_rows/condition/(12,): backing source")
eq(base.shape,{3,4},"int8/reverse_rows/condition/(12,): backing source: shape")
eq(base.strides,{4,1},"int8/reverse_rows/condition/(12,): backing source: strides")
eq(base.dtype,"int8","int8/reverse_rows/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"int8/reverse_rows/condition/(12,): source shape")
eq(a.strides,{-4,1},"int8/reverse_rows/condition/(12,): source strides")
cases=cases+1
end
-- 18: int8/reverse_rows/condition/(14,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8")
local a=np.flip(base,1)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"int8/reverse_rows/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8/reverse_rows/condition/(14,): backing source")
eq(base.shape,{3,4},"int8/reverse_rows/condition/(14,): backing source: shape")
eq(base.strides,{4,1},"int8/reverse_rows/condition/(14,): backing source: strides")
eq(base.dtype,"int8","int8/reverse_rows/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"int8/reverse_rows/condition/(14,): source shape")
eq(a.strides,{-4,1},"int8/reverse_rows/condition/(14,): source strides")
cases=cases+1
end
-- 19: int8/reverse_rows/condition/(0,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8")
local a=np.flip(base,1)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int8/reverse_rows/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"int8/reverse_rows/condition/(0,): result")
eq(result.shape,{0},"int8/reverse_rows/condition/(0,): result: shape")
eq(result.strides,{0},"int8/reverse_rows/condition/(0,): result: strides")
eq(result.dtype,"int8","int8/reverse_rows/condition/(0,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8/reverse_rows/condition/(0,): backing source")
eq(base.shape,{3,4},"int8/reverse_rows/condition/(0,): backing source: shape")
eq(base.strides,{4,1},"int8/reverse_rows/condition/(0,): backing source: strides")
eq(base.dtype,"int8","int8/reverse_rows/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"int8/reverse_rows/condition/(0,): source shape")
eq(a.strides,{-4,1},"int8/reverse_rows/condition/(0,): source strides")
cases=cases+1
end
-- 20: int8/reverse_rows/condition/(); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8")
local a=np.flip(base,1)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int8/reverse_rows/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{8},"int8/reverse_rows/condition/(): result")
eq(result.shape,{1},"int8/reverse_rows/condition/(): result: shape")
eq(result.strides,{1},"int8/reverse_rows/condition/(): result: strides")
eq(result.dtype,"int8","int8/reverse_rows/condition/(): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8/reverse_rows/condition/(): backing source")
eq(base.shape,{3,4},"int8/reverse_rows/condition/(): backing source: shape")
eq(base.strides,{4,1},"int8/reverse_rows/condition/(): backing source: strides")
eq(base.dtype,"int8","int8/reverse_rows/condition/(): backing source: dtype")
eq(a.shape,{3,4},"int8/reverse_rows/condition/(): source shape")
eq(a.strides,{-4,1},"int8/reverse_rows/condition/(): source strides")
cases=cases+1
end
-- 21: int8/strided/condition/(2, 3); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int8/strided/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{0,4,8},"int8/strided/condition/(2, 3): result")
eq(result.shape,{3},"int8/strided/condition/(2, 3): result: shape")
eq(result.strides,{1},"int8/strided/condition/(2, 3): result: strides")
eq(result.dtype,"int8","int8/strided/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8/strided/condition/(2, 3): backing source")
eq(base.shape,{3,4},"int8/strided/condition/(2, 3): backing source: shape")
eq(base.strides,{4,1},"int8/strided/condition/(2, 3): backing source: strides")
eq(base.dtype,"int8","int8/strided/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,2},"int8/strided/condition/(2, 3): source shape")
eq(a.strides,{4,2},"int8/strided/condition/(2, 3): source strides")
cases=cases+1
end
-- 22: int8/strided/condition/(12,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"int8/strided/condition/(12,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8/strided/condition/(12,): backing source")
eq(base.shape,{3,4},"int8/strided/condition/(12,): backing source: shape")
eq(base.strides,{4,1},"int8/strided/condition/(12,): backing source: strides")
eq(base.dtype,"int8","int8/strided/condition/(12,): backing source: dtype")
eq(a.shape,{3,2},"int8/strided/condition/(12,): source shape")
eq(a.strides,{4,2},"int8/strided/condition/(12,): source strides")
cases=cases+1
end
-- 23: int8/strided/condition/(14,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"int8/strided/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8/strided/condition/(14,): backing source")
eq(base.shape,{3,4},"int8/strided/condition/(14,): backing source: shape")
eq(base.strides,{4,1},"int8/strided/condition/(14,): backing source: strides")
eq(base.dtype,"int8","int8/strided/condition/(14,): backing source: dtype")
eq(a.shape,{3,2},"int8/strided/condition/(14,): source shape")
eq(a.strides,{4,2},"int8/strided/condition/(14,): source strides")
cases=cases+1
end
-- 24: int8/strided/condition/(0,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int8/strided/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"int8/strided/condition/(0,): result")
eq(result.shape,{0},"int8/strided/condition/(0,): result: shape")
eq(result.strides,{0},"int8/strided/condition/(0,): result: strides")
eq(result.dtype,"int8","int8/strided/condition/(0,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8/strided/condition/(0,): backing source")
eq(base.shape,{3,4},"int8/strided/condition/(0,): backing source: shape")
eq(base.strides,{4,1},"int8/strided/condition/(0,): backing source: strides")
eq(base.dtype,"int8","int8/strided/condition/(0,): backing source: dtype")
eq(a.shape,{3,2},"int8/strided/condition/(0,): source shape")
eq(a.strides,{4,2},"int8/strided/condition/(0,): source strides")
cases=cases+1
end
-- 25: int8/strided/condition/(); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int8/strided/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{0},"int8/strided/condition/(): result")
eq(result.shape,{1},"int8/strided/condition/(): result: shape")
eq(result.strides,{1},"int8/strided/condition/(): result: strides")
eq(result.dtype,"int8","int8/strided/condition/(): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8/strided/condition/(): backing source")
eq(base.shape,{3,4},"int8/strided/condition/(): backing source: shape")
eq(base.strides,{4,1},"int8/strided/condition/(): backing source: strides")
eq(base.dtype,"int8","int8/strided/condition/(): backing source: dtype")
eq(a.shape,{3,2},"int8/strided/condition/(): source shape")
eq(a.strides,{4,2},"int8/strided/condition/(): source strides")
cases=cases+1
end
-- 26: uint8/plain/condition/(2, 3); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8")
local a=base
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint8/plain/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{0,2,4},"uint8/plain/condition/(2, 3): result")
eq(result.shape,{3},"uint8/plain/condition/(2, 3): result: shape")
eq(result.strides,{1},"uint8/plain/condition/(2, 3): result: strides")
eq(result.dtype,"uint8","uint8/plain/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8/plain/condition/(2, 3): backing source")
eq(base.shape,{3,4},"uint8/plain/condition/(2, 3): backing source: shape")
eq(base.strides,{4,1},"uint8/plain/condition/(2, 3): backing source: strides")
eq(base.dtype,"uint8","uint8/plain/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"uint8/plain/condition/(2, 3): source shape")
eq(a.strides,{4,1},"uint8/plain/condition/(2, 3): source strides")
cases=cases+1
end
-- 27: uint8/plain/condition/(12,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8")
local a=base
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint8/plain/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0,2,4,6,8,10},"uint8/plain/condition/(12,): result")
eq(result.shape,{6},"uint8/plain/condition/(12,): result: shape")
eq(result.strides,{1},"uint8/plain/condition/(12,): result: strides")
eq(result.dtype,"uint8","uint8/plain/condition/(12,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8/plain/condition/(12,): backing source")
eq(base.shape,{3,4},"uint8/plain/condition/(12,): backing source: shape")
eq(base.strides,{4,1},"uint8/plain/condition/(12,): backing source: strides")
eq(base.dtype,"uint8","uint8/plain/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"uint8/plain/condition/(12,): source shape")
eq(a.strides,{4,1},"uint8/plain/condition/(12,): source strides")
cases=cases+1
end
-- 28: uint8/plain/condition/(14,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8")
local a=base
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"uint8/plain/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8/plain/condition/(14,): backing source")
eq(base.shape,{3,4},"uint8/plain/condition/(14,): backing source: shape")
eq(base.strides,{4,1},"uint8/plain/condition/(14,): backing source: strides")
eq(base.dtype,"uint8","uint8/plain/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"uint8/plain/condition/(14,): source shape")
eq(a.strides,{4,1},"uint8/plain/condition/(14,): source strides")
cases=cases+1
end
-- 29: uint8/plain/condition/(0,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint8/plain/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"uint8/plain/condition/(0,): result")
eq(result.shape,{0},"uint8/plain/condition/(0,): result: shape")
eq(result.strides,{0},"uint8/plain/condition/(0,): result: strides")
eq(result.dtype,"uint8","uint8/plain/condition/(0,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8/plain/condition/(0,): backing source")
eq(base.shape,{3,4},"uint8/plain/condition/(0,): backing source: shape")
eq(base.strides,{4,1},"uint8/plain/condition/(0,): backing source: strides")
eq(base.dtype,"uint8","uint8/plain/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"uint8/plain/condition/(0,): source shape")
eq(a.strides,{4,1},"uint8/plain/condition/(0,): source strides")
cases=cases+1
end
-- 30: uint8/plain/condition/(); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint8/plain/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{0},"uint8/plain/condition/(): result")
eq(result.shape,{1},"uint8/plain/condition/(): result: shape")
eq(result.strides,{1},"uint8/plain/condition/(): result: strides")
eq(result.dtype,"uint8","uint8/plain/condition/(): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8/plain/condition/(): backing source")
eq(base.shape,{3,4},"uint8/plain/condition/(): backing source: shape")
eq(base.strides,{4,1},"uint8/plain/condition/(): backing source: strides")
eq(base.dtype,"uint8","uint8/plain/condition/(): backing source: dtype")
eq(a.shape,{3,4},"uint8/plain/condition/(): source shape")
eq(a.strides,{4,1},"uint8/plain/condition/(): source strides")
cases=cases+1
end
-- 31: uint8/transpose/condition/(2, 3); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8")
local a=np.transpose(base)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint8/transpose/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{0,8,5},"uint8/transpose/condition/(2, 3): result")
eq(result.shape,{3},"uint8/transpose/condition/(2, 3): result: shape")
eq(result.strides,{1},"uint8/transpose/condition/(2, 3): result: strides")
eq(result.dtype,"uint8","uint8/transpose/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8/transpose/condition/(2, 3): backing source")
eq(base.shape,{3,4},"uint8/transpose/condition/(2, 3): backing source: shape")
eq(base.strides,{4,1},"uint8/transpose/condition/(2, 3): backing source: strides")
eq(base.dtype,"uint8","uint8/transpose/condition/(2, 3): backing source: dtype")
eq(a.shape,{4,3},"uint8/transpose/condition/(2, 3): source shape")
eq(a.strides,{1,4},"uint8/transpose/condition/(2, 3): source strides")
cases=cases+1
end
-- 32: uint8/transpose/condition/(12,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8")
local a=np.transpose(base)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint8/transpose/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0,8,5,2,10,7},"uint8/transpose/condition/(12,): result")
eq(result.shape,{6},"uint8/transpose/condition/(12,): result: shape")
eq(result.strides,{1},"uint8/transpose/condition/(12,): result: strides")
eq(result.dtype,"uint8","uint8/transpose/condition/(12,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8/transpose/condition/(12,): backing source")
eq(base.shape,{3,4},"uint8/transpose/condition/(12,): backing source: shape")
eq(base.strides,{4,1},"uint8/transpose/condition/(12,): backing source: strides")
eq(base.dtype,"uint8","uint8/transpose/condition/(12,): backing source: dtype")
eq(a.shape,{4,3},"uint8/transpose/condition/(12,): source shape")
eq(a.strides,{1,4},"uint8/transpose/condition/(12,): source strides")
cases=cases+1
end
-- 33: uint8/transpose/condition/(14,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8")
local a=np.transpose(base)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"uint8/transpose/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8/transpose/condition/(14,): backing source")
eq(base.shape,{3,4},"uint8/transpose/condition/(14,): backing source: shape")
eq(base.strides,{4,1},"uint8/transpose/condition/(14,): backing source: strides")
eq(base.dtype,"uint8","uint8/transpose/condition/(14,): backing source: dtype")
eq(a.shape,{4,3},"uint8/transpose/condition/(14,): source shape")
eq(a.strides,{1,4},"uint8/transpose/condition/(14,): source strides")
cases=cases+1
end
-- 34: uint8/transpose/condition/(0,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8")
local a=np.transpose(base)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint8/transpose/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"uint8/transpose/condition/(0,): result")
eq(result.shape,{0},"uint8/transpose/condition/(0,): result: shape")
eq(result.strides,{0},"uint8/transpose/condition/(0,): result: strides")
eq(result.dtype,"uint8","uint8/transpose/condition/(0,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8/transpose/condition/(0,): backing source")
eq(base.shape,{3,4},"uint8/transpose/condition/(0,): backing source: shape")
eq(base.strides,{4,1},"uint8/transpose/condition/(0,): backing source: strides")
eq(base.dtype,"uint8","uint8/transpose/condition/(0,): backing source: dtype")
eq(a.shape,{4,3},"uint8/transpose/condition/(0,): source shape")
eq(a.strides,{1,4},"uint8/transpose/condition/(0,): source strides")
cases=cases+1
end
-- 35: uint8/transpose/condition/(); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8")
local a=np.transpose(base)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint8/transpose/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{0},"uint8/transpose/condition/(): result")
eq(result.shape,{1},"uint8/transpose/condition/(): result: shape")
eq(result.strides,{1},"uint8/transpose/condition/(): result: strides")
eq(result.dtype,"uint8","uint8/transpose/condition/(): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8/transpose/condition/(): backing source")
eq(base.shape,{3,4},"uint8/transpose/condition/(): backing source: shape")
eq(base.strides,{4,1},"uint8/transpose/condition/(): backing source: strides")
eq(base.dtype,"uint8","uint8/transpose/condition/(): backing source: dtype")
eq(a.shape,{4,3},"uint8/transpose/condition/(): source shape")
eq(a.strides,{1,4},"uint8/transpose/condition/(): source strides")
cases=cases+1
end
-- 36: uint8/reverse_columns/condition/(2, 3); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8")
local a=np.flip(base,2)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint8/reverse_columns/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{3,1,7},"uint8/reverse_columns/condition/(2, 3): result")
eq(result.shape,{3},"uint8/reverse_columns/condition/(2, 3): result: shape")
eq(result.strides,{1},"uint8/reverse_columns/condition/(2, 3): result: strides")
eq(result.dtype,"uint8","uint8/reverse_columns/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8/reverse_columns/condition/(2, 3): backing source")
eq(base.shape,{3,4},"uint8/reverse_columns/condition/(2, 3): backing source: shape")
eq(base.strides,{4,1},"uint8/reverse_columns/condition/(2, 3): backing source: strides")
eq(base.dtype,"uint8","uint8/reverse_columns/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"uint8/reverse_columns/condition/(2, 3): source shape")
eq(a.strides,{4,-1},"uint8/reverse_columns/condition/(2, 3): source strides")
cases=cases+1
end
-- 37: uint8/reverse_columns/condition/(12,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8")
local a=np.flip(base,2)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint8/reverse_columns/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{3,1,7,5,11,9},"uint8/reverse_columns/condition/(12,): result")
eq(result.shape,{6},"uint8/reverse_columns/condition/(12,): result: shape")
eq(result.strides,{1},"uint8/reverse_columns/condition/(12,): result: strides")
eq(result.dtype,"uint8","uint8/reverse_columns/condition/(12,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8/reverse_columns/condition/(12,): backing source")
eq(base.shape,{3,4},"uint8/reverse_columns/condition/(12,): backing source: shape")
eq(base.strides,{4,1},"uint8/reverse_columns/condition/(12,): backing source: strides")
eq(base.dtype,"uint8","uint8/reverse_columns/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"uint8/reverse_columns/condition/(12,): source shape")
eq(a.strides,{4,-1},"uint8/reverse_columns/condition/(12,): source strides")
cases=cases+1
end
-- 38: uint8/reverse_columns/condition/(14,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8")
local a=np.flip(base,2)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"uint8/reverse_columns/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8/reverse_columns/condition/(14,): backing source")
eq(base.shape,{3,4},"uint8/reverse_columns/condition/(14,): backing source: shape")
eq(base.strides,{4,1},"uint8/reverse_columns/condition/(14,): backing source: strides")
eq(base.dtype,"uint8","uint8/reverse_columns/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"uint8/reverse_columns/condition/(14,): source shape")
eq(a.strides,{4,-1},"uint8/reverse_columns/condition/(14,): source strides")
cases=cases+1
end
-- 39: uint8/reverse_columns/condition/(0,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8")
local a=np.flip(base,2)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint8/reverse_columns/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"uint8/reverse_columns/condition/(0,): result")
eq(result.shape,{0},"uint8/reverse_columns/condition/(0,): result: shape")
eq(result.strides,{0},"uint8/reverse_columns/condition/(0,): result: strides")
eq(result.dtype,"uint8","uint8/reverse_columns/condition/(0,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8/reverse_columns/condition/(0,): backing source")
eq(base.shape,{3,4},"uint8/reverse_columns/condition/(0,): backing source: shape")
eq(base.strides,{4,1},"uint8/reverse_columns/condition/(0,): backing source: strides")
eq(base.dtype,"uint8","uint8/reverse_columns/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"uint8/reverse_columns/condition/(0,): source shape")
eq(a.strides,{4,-1},"uint8/reverse_columns/condition/(0,): source strides")
cases=cases+1
end
-- 40: uint8/reverse_columns/condition/(); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8")
local a=np.flip(base,2)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint8/reverse_columns/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{3},"uint8/reverse_columns/condition/(): result")
eq(result.shape,{1},"uint8/reverse_columns/condition/(): result: shape")
eq(result.strides,{1},"uint8/reverse_columns/condition/(): result: strides")
eq(result.dtype,"uint8","uint8/reverse_columns/condition/(): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8/reverse_columns/condition/(): backing source")
eq(base.shape,{3,4},"uint8/reverse_columns/condition/(): backing source: shape")
eq(base.strides,{4,1},"uint8/reverse_columns/condition/(): backing source: strides")
eq(base.dtype,"uint8","uint8/reverse_columns/condition/(): backing source: dtype")
eq(a.shape,{3,4},"uint8/reverse_columns/condition/(): source shape")
eq(a.strides,{4,-1},"uint8/reverse_columns/condition/(): source strides")
cases=cases+1
end
-- 41: uint8/reverse_rows/condition/(2, 3); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8")
local a=np.flip(base,1)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint8/reverse_rows/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{8,10,4},"uint8/reverse_rows/condition/(2, 3): result")
eq(result.shape,{3},"uint8/reverse_rows/condition/(2, 3): result: shape")
eq(result.strides,{1},"uint8/reverse_rows/condition/(2, 3): result: strides")
eq(result.dtype,"uint8","uint8/reverse_rows/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8/reverse_rows/condition/(2, 3): backing source")
eq(base.shape,{3,4},"uint8/reverse_rows/condition/(2, 3): backing source: shape")
eq(base.strides,{4,1},"uint8/reverse_rows/condition/(2, 3): backing source: strides")
eq(base.dtype,"uint8","uint8/reverse_rows/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"uint8/reverse_rows/condition/(2, 3): source shape")
eq(a.strides,{-4,1},"uint8/reverse_rows/condition/(2, 3): source strides")
cases=cases+1
end
-- 42: uint8/reverse_rows/condition/(12,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8")
local a=np.flip(base,1)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint8/reverse_rows/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{8,10,4,6,0,2},"uint8/reverse_rows/condition/(12,): result")
eq(result.shape,{6},"uint8/reverse_rows/condition/(12,): result: shape")
eq(result.strides,{1},"uint8/reverse_rows/condition/(12,): result: strides")
eq(result.dtype,"uint8","uint8/reverse_rows/condition/(12,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8/reverse_rows/condition/(12,): backing source")
eq(base.shape,{3,4},"uint8/reverse_rows/condition/(12,): backing source: shape")
eq(base.strides,{4,1},"uint8/reverse_rows/condition/(12,): backing source: strides")
eq(base.dtype,"uint8","uint8/reverse_rows/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"uint8/reverse_rows/condition/(12,): source shape")
eq(a.strides,{-4,1},"uint8/reverse_rows/condition/(12,): source strides")
cases=cases+1
end
-- 43: uint8/reverse_rows/condition/(14,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8")
local a=np.flip(base,1)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"uint8/reverse_rows/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8/reverse_rows/condition/(14,): backing source")
eq(base.shape,{3,4},"uint8/reverse_rows/condition/(14,): backing source: shape")
eq(base.strides,{4,1},"uint8/reverse_rows/condition/(14,): backing source: strides")
eq(base.dtype,"uint8","uint8/reverse_rows/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"uint8/reverse_rows/condition/(14,): source shape")
eq(a.strides,{-4,1},"uint8/reverse_rows/condition/(14,): source strides")
cases=cases+1
end
-- 44: uint8/reverse_rows/condition/(0,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8")
local a=np.flip(base,1)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint8/reverse_rows/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"uint8/reverse_rows/condition/(0,): result")
eq(result.shape,{0},"uint8/reverse_rows/condition/(0,): result: shape")
eq(result.strides,{0},"uint8/reverse_rows/condition/(0,): result: strides")
eq(result.dtype,"uint8","uint8/reverse_rows/condition/(0,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8/reverse_rows/condition/(0,): backing source")
eq(base.shape,{3,4},"uint8/reverse_rows/condition/(0,): backing source: shape")
eq(base.strides,{4,1},"uint8/reverse_rows/condition/(0,): backing source: strides")
eq(base.dtype,"uint8","uint8/reverse_rows/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"uint8/reverse_rows/condition/(0,): source shape")
eq(a.strides,{-4,1},"uint8/reverse_rows/condition/(0,): source strides")
cases=cases+1
end
-- 45: uint8/reverse_rows/condition/(); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8")
local a=np.flip(base,1)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint8/reverse_rows/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{8},"uint8/reverse_rows/condition/(): result")
eq(result.shape,{1},"uint8/reverse_rows/condition/(): result: shape")
eq(result.strides,{1},"uint8/reverse_rows/condition/(): result: strides")
eq(result.dtype,"uint8","uint8/reverse_rows/condition/(): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8/reverse_rows/condition/(): backing source")
eq(base.shape,{3,4},"uint8/reverse_rows/condition/(): backing source: shape")
eq(base.strides,{4,1},"uint8/reverse_rows/condition/(): backing source: strides")
eq(base.dtype,"uint8","uint8/reverse_rows/condition/(): backing source: dtype")
eq(a.shape,{3,4},"uint8/reverse_rows/condition/(): source shape")
eq(a.strides,{-4,1},"uint8/reverse_rows/condition/(): source strides")
cases=cases+1
end
-- 46: uint8/strided/condition/(2, 3); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint8/strided/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{0,4,8},"uint8/strided/condition/(2, 3): result")
eq(result.shape,{3},"uint8/strided/condition/(2, 3): result: shape")
eq(result.strides,{1},"uint8/strided/condition/(2, 3): result: strides")
eq(result.dtype,"uint8","uint8/strided/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8/strided/condition/(2, 3): backing source")
eq(base.shape,{3,4},"uint8/strided/condition/(2, 3): backing source: shape")
eq(base.strides,{4,1},"uint8/strided/condition/(2, 3): backing source: strides")
eq(base.dtype,"uint8","uint8/strided/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,2},"uint8/strided/condition/(2, 3): source shape")
eq(a.strides,{4,2},"uint8/strided/condition/(2, 3): source strides")
cases=cases+1
end
-- 47: uint8/strided/condition/(12,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"uint8/strided/condition/(12,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8/strided/condition/(12,): backing source")
eq(base.shape,{3,4},"uint8/strided/condition/(12,): backing source: shape")
eq(base.strides,{4,1},"uint8/strided/condition/(12,): backing source: strides")
eq(base.dtype,"uint8","uint8/strided/condition/(12,): backing source: dtype")
eq(a.shape,{3,2},"uint8/strided/condition/(12,): source shape")
eq(a.strides,{4,2},"uint8/strided/condition/(12,): source strides")
cases=cases+1
end
-- 48: uint8/strided/condition/(14,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"uint8/strided/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8/strided/condition/(14,): backing source")
eq(base.shape,{3,4},"uint8/strided/condition/(14,): backing source: shape")
eq(base.strides,{4,1},"uint8/strided/condition/(14,): backing source: strides")
eq(base.dtype,"uint8","uint8/strided/condition/(14,): backing source: dtype")
eq(a.shape,{3,2},"uint8/strided/condition/(14,): source shape")
eq(a.strides,{4,2},"uint8/strided/condition/(14,): source strides")
cases=cases+1
end
-- 49: uint8/strided/condition/(0,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint8/strided/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"uint8/strided/condition/(0,): result")
eq(result.shape,{0},"uint8/strided/condition/(0,): result: shape")
eq(result.strides,{0},"uint8/strided/condition/(0,): result: strides")
eq(result.dtype,"uint8","uint8/strided/condition/(0,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8/strided/condition/(0,): backing source")
eq(base.shape,{3,4},"uint8/strided/condition/(0,): backing source: shape")
eq(base.strides,{4,1},"uint8/strided/condition/(0,): backing source: strides")
eq(base.dtype,"uint8","uint8/strided/condition/(0,): backing source: dtype")
eq(a.shape,{3,2},"uint8/strided/condition/(0,): source shape")
eq(a.strides,{4,2},"uint8/strided/condition/(0,): source strides")
cases=cases+1
end
-- 50: uint8/strided/condition/(); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint8/strided/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{0},"uint8/strided/condition/(): result")
eq(result.shape,{1},"uint8/strided/condition/(): result: shape")
eq(result.strides,{1},"uint8/strided/condition/(): result: strides")
eq(result.dtype,"uint8","uint8/strided/condition/(): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8/strided/condition/(): backing source")
eq(base.shape,{3,4},"uint8/strided/condition/(): backing source: shape")
eq(base.strides,{4,1},"uint8/strided/condition/(): backing source: strides")
eq(base.dtype,"uint8","uint8/strided/condition/(): backing source: dtype")
eq(a.shape,{3,2},"uint8/strided/condition/(): source shape")
eq(a.strides,{4,2},"uint8/strided/condition/(): source strides")
cases=cases+1
end
-- 51: int16/plain/condition/(2, 3); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16")
local a=base
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int16/plain/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{0,2,4},"int16/plain/condition/(2, 3): result")
eq(result.shape,{3},"int16/plain/condition/(2, 3): result: shape")
eq(result.strides,{2},"int16/plain/condition/(2, 3): result: strides")
eq(result.dtype,"int16","int16/plain/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16/plain/condition/(2, 3): backing source")
eq(base.shape,{3,4},"int16/plain/condition/(2, 3): backing source: shape")
eq(base.strides,{8,2},"int16/plain/condition/(2, 3): backing source: strides")
eq(base.dtype,"int16","int16/plain/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"int16/plain/condition/(2, 3): source shape")
eq(a.strides,{8,2},"int16/plain/condition/(2, 3): source strides")
cases=cases+1
end
-- 52: int16/plain/condition/(12,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16")
local a=base
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int16/plain/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0,2,4,6,8,10},"int16/plain/condition/(12,): result")
eq(result.shape,{6},"int16/plain/condition/(12,): result: shape")
eq(result.strides,{2},"int16/plain/condition/(12,): result: strides")
eq(result.dtype,"int16","int16/plain/condition/(12,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16/plain/condition/(12,): backing source")
eq(base.shape,{3,4},"int16/plain/condition/(12,): backing source: shape")
eq(base.strides,{8,2},"int16/plain/condition/(12,): backing source: strides")
eq(base.dtype,"int16","int16/plain/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"int16/plain/condition/(12,): source shape")
eq(a.strides,{8,2},"int16/plain/condition/(12,): source strides")
cases=cases+1
end
-- 53: int16/plain/condition/(14,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16")
local a=base
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"int16/plain/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16/plain/condition/(14,): backing source")
eq(base.shape,{3,4},"int16/plain/condition/(14,): backing source: shape")
eq(base.strides,{8,2},"int16/plain/condition/(14,): backing source: strides")
eq(base.dtype,"int16","int16/plain/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"int16/plain/condition/(14,): source shape")
eq(a.strides,{8,2},"int16/plain/condition/(14,): source strides")
cases=cases+1
end
-- 54: int16/plain/condition/(0,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int16/plain/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"int16/plain/condition/(0,): result")
eq(result.shape,{0},"int16/plain/condition/(0,): result: shape")
eq(result.strides,{0},"int16/plain/condition/(0,): result: strides")
eq(result.dtype,"int16","int16/plain/condition/(0,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16/plain/condition/(0,): backing source")
eq(base.shape,{3,4},"int16/plain/condition/(0,): backing source: shape")
eq(base.strides,{8,2},"int16/plain/condition/(0,): backing source: strides")
eq(base.dtype,"int16","int16/plain/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"int16/plain/condition/(0,): source shape")
eq(a.strides,{8,2},"int16/plain/condition/(0,): source strides")
cases=cases+1
end
-- 55: int16/plain/condition/(); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int16/plain/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{0},"int16/plain/condition/(): result")
eq(result.shape,{1},"int16/plain/condition/(): result: shape")
eq(result.strides,{2},"int16/plain/condition/(): result: strides")
eq(result.dtype,"int16","int16/plain/condition/(): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16/plain/condition/(): backing source")
eq(base.shape,{3,4},"int16/plain/condition/(): backing source: shape")
eq(base.strides,{8,2},"int16/plain/condition/(): backing source: strides")
eq(base.dtype,"int16","int16/plain/condition/(): backing source: dtype")
eq(a.shape,{3,4},"int16/plain/condition/(): source shape")
eq(a.strides,{8,2},"int16/plain/condition/(): source strides")
cases=cases+1
end
-- 56: int16/transpose/condition/(2, 3); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16")
local a=np.transpose(base)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int16/transpose/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{0,8,5},"int16/transpose/condition/(2, 3): result")
eq(result.shape,{3},"int16/transpose/condition/(2, 3): result: shape")
eq(result.strides,{2},"int16/transpose/condition/(2, 3): result: strides")
eq(result.dtype,"int16","int16/transpose/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16/transpose/condition/(2, 3): backing source")
eq(base.shape,{3,4},"int16/transpose/condition/(2, 3): backing source: shape")
eq(base.strides,{8,2},"int16/transpose/condition/(2, 3): backing source: strides")
eq(base.dtype,"int16","int16/transpose/condition/(2, 3): backing source: dtype")
eq(a.shape,{4,3},"int16/transpose/condition/(2, 3): source shape")
eq(a.strides,{2,8},"int16/transpose/condition/(2, 3): source strides")
cases=cases+1
end
-- 57: int16/transpose/condition/(12,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16")
local a=np.transpose(base)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int16/transpose/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0,8,5,2,10,7},"int16/transpose/condition/(12,): result")
eq(result.shape,{6},"int16/transpose/condition/(12,): result: shape")
eq(result.strides,{2},"int16/transpose/condition/(12,): result: strides")
eq(result.dtype,"int16","int16/transpose/condition/(12,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16/transpose/condition/(12,): backing source")
eq(base.shape,{3,4},"int16/transpose/condition/(12,): backing source: shape")
eq(base.strides,{8,2},"int16/transpose/condition/(12,): backing source: strides")
eq(base.dtype,"int16","int16/transpose/condition/(12,): backing source: dtype")
eq(a.shape,{4,3},"int16/transpose/condition/(12,): source shape")
eq(a.strides,{2,8},"int16/transpose/condition/(12,): source strides")
cases=cases+1
end
-- 58: int16/transpose/condition/(14,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16")
local a=np.transpose(base)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"int16/transpose/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16/transpose/condition/(14,): backing source")
eq(base.shape,{3,4},"int16/transpose/condition/(14,): backing source: shape")
eq(base.strides,{8,2},"int16/transpose/condition/(14,): backing source: strides")
eq(base.dtype,"int16","int16/transpose/condition/(14,): backing source: dtype")
eq(a.shape,{4,3},"int16/transpose/condition/(14,): source shape")
eq(a.strides,{2,8},"int16/transpose/condition/(14,): source strides")
cases=cases+1
end
-- 59: int16/transpose/condition/(0,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16")
local a=np.transpose(base)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int16/transpose/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"int16/transpose/condition/(0,): result")
eq(result.shape,{0},"int16/transpose/condition/(0,): result: shape")
eq(result.strides,{0},"int16/transpose/condition/(0,): result: strides")
eq(result.dtype,"int16","int16/transpose/condition/(0,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16/transpose/condition/(0,): backing source")
eq(base.shape,{3,4},"int16/transpose/condition/(0,): backing source: shape")
eq(base.strides,{8,2},"int16/transpose/condition/(0,): backing source: strides")
eq(base.dtype,"int16","int16/transpose/condition/(0,): backing source: dtype")
eq(a.shape,{4,3},"int16/transpose/condition/(0,): source shape")
eq(a.strides,{2,8},"int16/transpose/condition/(0,): source strides")
cases=cases+1
end
-- 60: int16/transpose/condition/(); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16")
local a=np.transpose(base)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int16/transpose/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{0},"int16/transpose/condition/(): result")
eq(result.shape,{1},"int16/transpose/condition/(): result: shape")
eq(result.strides,{2},"int16/transpose/condition/(): result: strides")
eq(result.dtype,"int16","int16/transpose/condition/(): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16/transpose/condition/(): backing source")
eq(base.shape,{3,4},"int16/transpose/condition/(): backing source: shape")
eq(base.strides,{8,2},"int16/transpose/condition/(): backing source: strides")
eq(base.dtype,"int16","int16/transpose/condition/(): backing source: dtype")
eq(a.shape,{4,3},"int16/transpose/condition/(): source shape")
eq(a.strides,{2,8},"int16/transpose/condition/(): source strides")
cases=cases+1
end
-- 61: int16/reverse_columns/condition/(2, 3); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16")
local a=np.flip(base,2)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int16/reverse_columns/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{3,1,7},"int16/reverse_columns/condition/(2, 3): result")
eq(result.shape,{3},"int16/reverse_columns/condition/(2, 3): result: shape")
eq(result.strides,{2},"int16/reverse_columns/condition/(2, 3): result: strides")
eq(result.dtype,"int16","int16/reverse_columns/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16/reverse_columns/condition/(2, 3): backing source")
eq(base.shape,{3,4},"int16/reverse_columns/condition/(2, 3): backing source: shape")
eq(base.strides,{8,2},"int16/reverse_columns/condition/(2, 3): backing source: strides")
eq(base.dtype,"int16","int16/reverse_columns/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"int16/reverse_columns/condition/(2, 3): source shape")
eq(a.strides,{8,-2},"int16/reverse_columns/condition/(2, 3): source strides")
cases=cases+1
end
-- 62: int16/reverse_columns/condition/(12,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16")
local a=np.flip(base,2)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int16/reverse_columns/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{3,1,7,5,11,9},"int16/reverse_columns/condition/(12,): result")
eq(result.shape,{6},"int16/reverse_columns/condition/(12,): result: shape")
eq(result.strides,{2},"int16/reverse_columns/condition/(12,): result: strides")
eq(result.dtype,"int16","int16/reverse_columns/condition/(12,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16/reverse_columns/condition/(12,): backing source")
eq(base.shape,{3,4},"int16/reverse_columns/condition/(12,): backing source: shape")
eq(base.strides,{8,2},"int16/reverse_columns/condition/(12,): backing source: strides")
eq(base.dtype,"int16","int16/reverse_columns/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"int16/reverse_columns/condition/(12,): source shape")
eq(a.strides,{8,-2},"int16/reverse_columns/condition/(12,): source strides")
cases=cases+1
end
-- 63: int16/reverse_columns/condition/(14,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16")
local a=np.flip(base,2)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"int16/reverse_columns/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16/reverse_columns/condition/(14,): backing source")
eq(base.shape,{3,4},"int16/reverse_columns/condition/(14,): backing source: shape")
eq(base.strides,{8,2},"int16/reverse_columns/condition/(14,): backing source: strides")
eq(base.dtype,"int16","int16/reverse_columns/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"int16/reverse_columns/condition/(14,): source shape")
eq(a.strides,{8,-2},"int16/reverse_columns/condition/(14,): source strides")
cases=cases+1
end
-- 64: int16/reverse_columns/condition/(0,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16")
local a=np.flip(base,2)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int16/reverse_columns/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"int16/reverse_columns/condition/(0,): result")
eq(result.shape,{0},"int16/reverse_columns/condition/(0,): result: shape")
eq(result.strides,{0},"int16/reverse_columns/condition/(0,): result: strides")
eq(result.dtype,"int16","int16/reverse_columns/condition/(0,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16/reverse_columns/condition/(0,): backing source")
eq(base.shape,{3,4},"int16/reverse_columns/condition/(0,): backing source: shape")
eq(base.strides,{8,2},"int16/reverse_columns/condition/(0,): backing source: strides")
eq(base.dtype,"int16","int16/reverse_columns/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"int16/reverse_columns/condition/(0,): source shape")
eq(a.strides,{8,-2},"int16/reverse_columns/condition/(0,): source strides")
cases=cases+1
end
-- 65: int16/reverse_columns/condition/(); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16")
local a=np.flip(base,2)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int16/reverse_columns/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{3},"int16/reverse_columns/condition/(): result")
eq(result.shape,{1},"int16/reverse_columns/condition/(): result: shape")
eq(result.strides,{2},"int16/reverse_columns/condition/(): result: strides")
eq(result.dtype,"int16","int16/reverse_columns/condition/(): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16/reverse_columns/condition/(): backing source")
eq(base.shape,{3,4},"int16/reverse_columns/condition/(): backing source: shape")
eq(base.strides,{8,2},"int16/reverse_columns/condition/(): backing source: strides")
eq(base.dtype,"int16","int16/reverse_columns/condition/(): backing source: dtype")
eq(a.shape,{3,4},"int16/reverse_columns/condition/(): source shape")
eq(a.strides,{8,-2},"int16/reverse_columns/condition/(): source strides")
cases=cases+1
end
-- 66: int16/reverse_rows/condition/(2, 3); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16")
local a=np.flip(base,1)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int16/reverse_rows/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{8,10,4},"int16/reverse_rows/condition/(2, 3): result")
eq(result.shape,{3},"int16/reverse_rows/condition/(2, 3): result: shape")
eq(result.strides,{2},"int16/reverse_rows/condition/(2, 3): result: strides")
eq(result.dtype,"int16","int16/reverse_rows/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16/reverse_rows/condition/(2, 3): backing source")
eq(base.shape,{3,4},"int16/reverse_rows/condition/(2, 3): backing source: shape")
eq(base.strides,{8,2},"int16/reverse_rows/condition/(2, 3): backing source: strides")
eq(base.dtype,"int16","int16/reverse_rows/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"int16/reverse_rows/condition/(2, 3): source shape")
eq(a.strides,{-8,2},"int16/reverse_rows/condition/(2, 3): source strides")
cases=cases+1
end
-- 67: int16/reverse_rows/condition/(12,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16")
local a=np.flip(base,1)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int16/reverse_rows/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{8,10,4,6,0,2},"int16/reverse_rows/condition/(12,): result")
eq(result.shape,{6},"int16/reverse_rows/condition/(12,): result: shape")
eq(result.strides,{2},"int16/reverse_rows/condition/(12,): result: strides")
eq(result.dtype,"int16","int16/reverse_rows/condition/(12,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16/reverse_rows/condition/(12,): backing source")
eq(base.shape,{3,4},"int16/reverse_rows/condition/(12,): backing source: shape")
eq(base.strides,{8,2},"int16/reverse_rows/condition/(12,): backing source: strides")
eq(base.dtype,"int16","int16/reverse_rows/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"int16/reverse_rows/condition/(12,): source shape")
eq(a.strides,{-8,2},"int16/reverse_rows/condition/(12,): source strides")
cases=cases+1
end
-- 68: int16/reverse_rows/condition/(14,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16")
local a=np.flip(base,1)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"int16/reverse_rows/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16/reverse_rows/condition/(14,): backing source")
eq(base.shape,{3,4},"int16/reverse_rows/condition/(14,): backing source: shape")
eq(base.strides,{8,2},"int16/reverse_rows/condition/(14,): backing source: strides")
eq(base.dtype,"int16","int16/reverse_rows/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"int16/reverse_rows/condition/(14,): source shape")
eq(a.strides,{-8,2},"int16/reverse_rows/condition/(14,): source strides")
cases=cases+1
end
-- 69: int16/reverse_rows/condition/(0,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16")
local a=np.flip(base,1)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int16/reverse_rows/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"int16/reverse_rows/condition/(0,): result")
eq(result.shape,{0},"int16/reverse_rows/condition/(0,): result: shape")
eq(result.strides,{0},"int16/reverse_rows/condition/(0,): result: strides")
eq(result.dtype,"int16","int16/reverse_rows/condition/(0,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16/reverse_rows/condition/(0,): backing source")
eq(base.shape,{3,4},"int16/reverse_rows/condition/(0,): backing source: shape")
eq(base.strides,{8,2},"int16/reverse_rows/condition/(0,): backing source: strides")
eq(base.dtype,"int16","int16/reverse_rows/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"int16/reverse_rows/condition/(0,): source shape")
eq(a.strides,{-8,2},"int16/reverse_rows/condition/(0,): source strides")
cases=cases+1
end
-- 70: int16/reverse_rows/condition/(); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16")
local a=np.flip(base,1)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int16/reverse_rows/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{8},"int16/reverse_rows/condition/(): result")
eq(result.shape,{1},"int16/reverse_rows/condition/(): result: shape")
eq(result.strides,{2},"int16/reverse_rows/condition/(): result: strides")
eq(result.dtype,"int16","int16/reverse_rows/condition/(): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16/reverse_rows/condition/(): backing source")
eq(base.shape,{3,4},"int16/reverse_rows/condition/(): backing source: shape")
eq(base.strides,{8,2},"int16/reverse_rows/condition/(): backing source: strides")
eq(base.dtype,"int16","int16/reverse_rows/condition/(): backing source: dtype")
eq(a.shape,{3,4},"int16/reverse_rows/condition/(): source shape")
eq(a.strides,{-8,2},"int16/reverse_rows/condition/(): source strides")
cases=cases+1
end
-- 71: int16/strided/condition/(2, 3); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int16/strided/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{0,4,8},"int16/strided/condition/(2, 3): result")
eq(result.shape,{3},"int16/strided/condition/(2, 3): result: shape")
eq(result.strides,{2},"int16/strided/condition/(2, 3): result: strides")
eq(result.dtype,"int16","int16/strided/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16/strided/condition/(2, 3): backing source")
eq(base.shape,{3,4},"int16/strided/condition/(2, 3): backing source: shape")
eq(base.strides,{8,2},"int16/strided/condition/(2, 3): backing source: strides")
eq(base.dtype,"int16","int16/strided/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,2},"int16/strided/condition/(2, 3): source shape")
eq(a.strides,{8,4},"int16/strided/condition/(2, 3): source strides")
cases=cases+1
end
-- 72: int16/strided/condition/(12,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"int16/strided/condition/(12,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16/strided/condition/(12,): backing source")
eq(base.shape,{3,4},"int16/strided/condition/(12,): backing source: shape")
eq(base.strides,{8,2},"int16/strided/condition/(12,): backing source: strides")
eq(base.dtype,"int16","int16/strided/condition/(12,): backing source: dtype")
eq(a.shape,{3,2},"int16/strided/condition/(12,): source shape")
eq(a.strides,{8,4},"int16/strided/condition/(12,): source strides")
cases=cases+1
end
-- 73: int16/strided/condition/(14,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"int16/strided/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16/strided/condition/(14,): backing source")
eq(base.shape,{3,4},"int16/strided/condition/(14,): backing source: shape")
eq(base.strides,{8,2},"int16/strided/condition/(14,): backing source: strides")
eq(base.dtype,"int16","int16/strided/condition/(14,): backing source: dtype")
eq(a.shape,{3,2},"int16/strided/condition/(14,): source shape")
eq(a.strides,{8,4},"int16/strided/condition/(14,): source strides")
cases=cases+1
end
-- 74: int16/strided/condition/(0,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int16/strided/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"int16/strided/condition/(0,): result")
eq(result.shape,{0},"int16/strided/condition/(0,): result: shape")
eq(result.strides,{0},"int16/strided/condition/(0,): result: strides")
eq(result.dtype,"int16","int16/strided/condition/(0,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16/strided/condition/(0,): backing source")
eq(base.shape,{3,4},"int16/strided/condition/(0,): backing source: shape")
eq(base.strides,{8,2},"int16/strided/condition/(0,): backing source: strides")
eq(base.dtype,"int16","int16/strided/condition/(0,): backing source: dtype")
eq(a.shape,{3,2},"int16/strided/condition/(0,): source shape")
eq(a.strides,{8,4},"int16/strided/condition/(0,): source strides")
cases=cases+1
end
-- 75: int16/strided/condition/(); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int16/strided/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{0},"int16/strided/condition/(): result")
eq(result.shape,{1},"int16/strided/condition/(): result: shape")
eq(result.strides,{2},"int16/strided/condition/(): result: strides")
eq(result.dtype,"int16","int16/strided/condition/(): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16/strided/condition/(): backing source")
eq(base.shape,{3,4},"int16/strided/condition/(): backing source: shape")
eq(base.strides,{8,2},"int16/strided/condition/(): backing source: strides")
eq(base.dtype,"int16","int16/strided/condition/(): backing source: dtype")
eq(a.shape,{3,2},"int16/strided/condition/(): source shape")
eq(a.strides,{8,4},"int16/strided/condition/(): source strides")
cases=cases+1
end
-- 76: uint32/plain/condition/(2, 3); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32")
local a=base
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint32/plain/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{0,2,4},"uint32/plain/condition/(2, 3): result")
eq(result.shape,{3},"uint32/plain/condition/(2, 3): result: shape")
eq(result.strides,{4},"uint32/plain/condition/(2, 3): result: strides")
eq(result.dtype,"uint32","uint32/plain/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32/plain/condition/(2, 3): backing source")
eq(base.shape,{3,4},"uint32/plain/condition/(2, 3): backing source: shape")
eq(base.strides,{16,4},"uint32/plain/condition/(2, 3): backing source: strides")
eq(base.dtype,"uint32","uint32/plain/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"uint32/plain/condition/(2, 3): source shape")
eq(a.strides,{16,4},"uint32/plain/condition/(2, 3): source strides")
cases=cases+1
end
-- 77: uint32/plain/condition/(12,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32")
local a=base
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint32/plain/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0,2,4,6,8,10},"uint32/plain/condition/(12,): result")
eq(result.shape,{6},"uint32/plain/condition/(12,): result: shape")
eq(result.strides,{4},"uint32/plain/condition/(12,): result: strides")
eq(result.dtype,"uint32","uint32/plain/condition/(12,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32/plain/condition/(12,): backing source")
eq(base.shape,{3,4},"uint32/plain/condition/(12,): backing source: shape")
eq(base.strides,{16,4},"uint32/plain/condition/(12,): backing source: strides")
eq(base.dtype,"uint32","uint32/plain/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"uint32/plain/condition/(12,): source shape")
eq(a.strides,{16,4},"uint32/plain/condition/(12,): source strides")
cases=cases+1
end
-- 78: uint32/plain/condition/(14,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32")
local a=base
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"uint32/plain/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32/plain/condition/(14,): backing source")
eq(base.shape,{3,4},"uint32/plain/condition/(14,): backing source: shape")
eq(base.strides,{16,4},"uint32/plain/condition/(14,): backing source: strides")
eq(base.dtype,"uint32","uint32/plain/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"uint32/plain/condition/(14,): source shape")
eq(a.strides,{16,4},"uint32/plain/condition/(14,): source strides")
cases=cases+1
end
-- 79: uint32/plain/condition/(0,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint32/plain/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"uint32/plain/condition/(0,): result")
eq(result.shape,{0},"uint32/plain/condition/(0,): result: shape")
eq(result.strides,{0},"uint32/plain/condition/(0,): result: strides")
eq(result.dtype,"uint32","uint32/plain/condition/(0,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32/plain/condition/(0,): backing source")
eq(base.shape,{3,4},"uint32/plain/condition/(0,): backing source: shape")
eq(base.strides,{16,4},"uint32/plain/condition/(0,): backing source: strides")
eq(base.dtype,"uint32","uint32/plain/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"uint32/plain/condition/(0,): source shape")
eq(a.strides,{16,4},"uint32/plain/condition/(0,): source strides")
cases=cases+1
end
-- 80: uint32/plain/condition/(); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint32/plain/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{0},"uint32/plain/condition/(): result")
eq(result.shape,{1},"uint32/plain/condition/(): result: shape")
eq(result.strides,{4},"uint32/plain/condition/(): result: strides")
eq(result.dtype,"uint32","uint32/plain/condition/(): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32/plain/condition/(): backing source")
eq(base.shape,{3,4},"uint32/plain/condition/(): backing source: shape")
eq(base.strides,{16,4},"uint32/plain/condition/(): backing source: strides")
eq(base.dtype,"uint32","uint32/plain/condition/(): backing source: dtype")
eq(a.shape,{3,4},"uint32/plain/condition/(): source shape")
eq(a.strides,{16,4},"uint32/plain/condition/(): source strides")
cases=cases+1
end
-- 81: uint32/transpose/condition/(2, 3); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32")
local a=np.transpose(base)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint32/transpose/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{0,8,5},"uint32/transpose/condition/(2, 3): result")
eq(result.shape,{3},"uint32/transpose/condition/(2, 3): result: shape")
eq(result.strides,{4},"uint32/transpose/condition/(2, 3): result: strides")
eq(result.dtype,"uint32","uint32/transpose/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32/transpose/condition/(2, 3): backing source")
eq(base.shape,{3,4},"uint32/transpose/condition/(2, 3): backing source: shape")
eq(base.strides,{16,4},"uint32/transpose/condition/(2, 3): backing source: strides")
eq(base.dtype,"uint32","uint32/transpose/condition/(2, 3): backing source: dtype")
eq(a.shape,{4,3},"uint32/transpose/condition/(2, 3): source shape")
eq(a.strides,{4,16},"uint32/transpose/condition/(2, 3): source strides")
cases=cases+1
end
-- 82: uint32/transpose/condition/(12,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32")
local a=np.transpose(base)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint32/transpose/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0,8,5,2,10,7},"uint32/transpose/condition/(12,): result")
eq(result.shape,{6},"uint32/transpose/condition/(12,): result: shape")
eq(result.strides,{4},"uint32/transpose/condition/(12,): result: strides")
eq(result.dtype,"uint32","uint32/transpose/condition/(12,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32/transpose/condition/(12,): backing source")
eq(base.shape,{3,4},"uint32/transpose/condition/(12,): backing source: shape")
eq(base.strides,{16,4},"uint32/transpose/condition/(12,): backing source: strides")
eq(base.dtype,"uint32","uint32/transpose/condition/(12,): backing source: dtype")
eq(a.shape,{4,3},"uint32/transpose/condition/(12,): source shape")
eq(a.strides,{4,16},"uint32/transpose/condition/(12,): source strides")
cases=cases+1
end
-- 83: uint32/transpose/condition/(14,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32")
local a=np.transpose(base)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"uint32/transpose/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32/transpose/condition/(14,): backing source")
eq(base.shape,{3,4},"uint32/transpose/condition/(14,): backing source: shape")
eq(base.strides,{16,4},"uint32/transpose/condition/(14,): backing source: strides")
eq(base.dtype,"uint32","uint32/transpose/condition/(14,): backing source: dtype")
eq(a.shape,{4,3},"uint32/transpose/condition/(14,): source shape")
eq(a.strides,{4,16},"uint32/transpose/condition/(14,): source strides")
cases=cases+1
end
-- 84: uint32/transpose/condition/(0,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32")
local a=np.transpose(base)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint32/transpose/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"uint32/transpose/condition/(0,): result")
eq(result.shape,{0},"uint32/transpose/condition/(0,): result: shape")
eq(result.strides,{0},"uint32/transpose/condition/(0,): result: strides")
eq(result.dtype,"uint32","uint32/transpose/condition/(0,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32/transpose/condition/(0,): backing source")
eq(base.shape,{3,4},"uint32/transpose/condition/(0,): backing source: shape")
eq(base.strides,{16,4},"uint32/transpose/condition/(0,): backing source: strides")
eq(base.dtype,"uint32","uint32/transpose/condition/(0,): backing source: dtype")
eq(a.shape,{4,3},"uint32/transpose/condition/(0,): source shape")
eq(a.strides,{4,16},"uint32/transpose/condition/(0,): source strides")
cases=cases+1
end
-- 85: uint32/transpose/condition/(); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32")
local a=np.transpose(base)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint32/transpose/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{0},"uint32/transpose/condition/(): result")
eq(result.shape,{1},"uint32/transpose/condition/(): result: shape")
eq(result.strides,{4},"uint32/transpose/condition/(): result: strides")
eq(result.dtype,"uint32","uint32/transpose/condition/(): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32/transpose/condition/(): backing source")
eq(base.shape,{3,4},"uint32/transpose/condition/(): backing source: shape")
eq(base.strides,{16,4},"uint32/transpose/condition/(): backing source: strides")
eq(base.dtype,"uint32","uint32/transpose/condition/(): backing source: dtype")
eq(a.shape,{4,3},"uint32/transpose/condition/(): source shape")
eq(a.strides,{4,16},"uint32/transpose/condition/(): source strides")
cases=cases+1
end
-- 86: uint32/reverse_columns/condition/(2, 3); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32")
local a=np.flip(base,2)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint32/reverse_columns/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{3,1,7},"uint32/reverse_columns/condition/(2, 3): result")
eq(result.shape,{3},"uint32/reverse_columns/condition/(2, 3): result: shape")
eq(result.strides,{4},"uint32/reverse_columns/condition/(2, 3): result: strides")
eq(result.dtype,"uint32","uint32/reverse_columns/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32/reverse_columns/condition/(2, 3): backing source")
eq(base.shape,{3,4},"uint32/reverse_columns/condition/(2, 3): backing source: shape")
eq(base.strides,{16,4},"uint32/reverse_columns/condition/(2, 3): backing source: strides")
eq(base.dtype,"uint32","uint32/reverse_columns/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"uint32/reverse_columns/condition/(2, 3): source shape")
eq(a.strides,{16,-4},"uint32/reverse_columns/condition/(2, 3): source strides")
cases=cases+1
end
-- 87: uint32/reverse_columns/condition/(12,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32")
local a=np.flip(base,2)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint32/reverse_columns/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{3,1,7,5,11,9},"uint32/reverse_columns/condition/(12,): result")
eq(result.shape,{6},"uint32/reverse_columns/condition/(12,): result: shape")
eq(result.strides,{4},"uint32/reverse_columns/condition/(12,): result: strides")
eq(result.dtype,"uint32","uint32/reverse_columns/condition/(12,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32/reverse_columns/condition/(12,): backing source")
eq(base.shape,{3,4},"uint32/reverse_columns/condition/(12,): backing source: shape")
eq(base.strides,{16,4},"uint32/reverse_columns/condition/(12,): backing source: strides")
eq(base.dtype,"uint32","uint32/reverse_columns/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"uint32/reverse_columns/condition/(12,): source shape")
eq(a.strides,{16,-4},"uint32/reverse_columns/condition/(12,): source strides")
cases=cases+1
end
-- 88: uint32/reverse_columns/condition/(14,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32")
local a=np.flip(base,2)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"uint32/reverse_columns/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32/reverse_columns/condition/(14,): backing source")
eq(base.shape,{3,4},"uint32/reverse_columns/condition/(14,): backing source: shape")
eq(base.strides,{16,4},"uint32/reverse_columns/condition/(14,): backing source: strides")
eq(base.dtype,"uint32","uint32/reverse_columns/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"uint32/reverse_columns/condition/(14,): source shape")
eq(a.strides,{16,-4},"uint32/reverse_columns/condition/(14,): source strides")
cases=cases+1
end
-- 89: uint32/reverse_columns/condition/(0,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32")
local a=np.flip(base,2)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint32/reverse_columns/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"uint32/reverse_columns/condition/(0,): result")
eq(result.shape,{0},"uint32/reverse_columns/condition/(0,): result: shape")
eq(result.strides,{0},"uint32/reverse_columns/condition/(0,): result: strides")
eq(result.dtype,"uint32","uint32/reverse_columns/condition/(0,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32/reverse_columns/condition/(0,): backing source")
eq(base.shape,{3,4},"uint32/reverse_columns/condition/(0,): backing source: shape")
eq(base.strides,{16,4},"uint32/reverse_columns/condition/(0,): backing source: strides")
eq(base.dtype,"uint32","uint32/reverse_columns/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"uint32/reverse_columns/condition/(0,): source shape")
eq(a.strides,{16,-4},"uint32/reverse_columns/condition/(0,): source strides")
cases=cases+1
end
-- 90: uint32/reverse_columns/condition/(); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32")
local a=np.flip(base,2)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint32/reverse_columns/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{3},"uint32/reverse_columns/condition/(): result")
eq(result.shape,{1},"uint32/reverse_columns/condition/(): result: shape")
eq(result.strides,{4},"uint32/reverse_columns/condition/(): result: strides")
eq(result.dtype,"uint32","uint32/reverse_columns/condition/(): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32/reverse_columns/condition/(): backing source")
eq(base.shape,{3,4},"uint32/reverse_columns/condition/(): backing source: shape")
eq(base.strides,{16,4},"uint32/reverse_columns/condition/(): backing source: strides")
eq(base.dtype,"uint32","uint32/reverse_columns/condition/(): backing source: dtype")
eq(a.shape,{3,4},"uint32/reverse_columns/condition/(): source shape")
eq(a.strides,{16,-4},"uint32/reverse_columns/condition/(): source strides")
cases=cases+1
end
-- 91: uint32/reverse_rows/condition/(2, 3); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32")
local a=np.flip(base,1)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint32/reverse_rows/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{8,10,4},"uint32/reverse_rows/condition/(2, 3): result")
eq(result.shape,{3},"uint32/reverse_rows/condition/(2, 3): result: shape")
eq(result.strides,{4},"uint32/reverse_rows/condition/(2, 3): result: strides")
eq(result.dtype,"uint32","uint32/reverse_rows/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32/reverse_rows/condition/(2, 3): backing source")
eq(base.shape,{3,4},"uint32/reverse_rows/condition/(2, 3): backing source: shape")
eq(base.strides,{16,4},"uint32/reverse_rows/condition/(2, 3): backing source: strides")
eq(base.dtype,"uint32","uint32/reverse_rows/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"uint32/reverse_rows/condition/(2, 3): source shape")
eq(a.strides,{-16,4},"uint32/reverse_rows/condition/(2, 3): source strides")
cases=cases+1
end
-- 92: uint32/reverse_rows/condition/(12,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32")
local a=np.flip(base,1)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint32/reverse_rows/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{8,10,4,6,0,2},"uint32/reverse_rows/condition/(12,): result")
eq(result.shape,{6},"uint32/reverse_rows/condition/(12,): result: shape")
eq(result.strides,{4},"uint32/reverse_rows/condition/(12,): result: strides")
eq(result.dtype,"uint32","uint32/reverse_rows/condition/(12,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32/reverse_rows/condition/(12,): backing source")
eq(base.shape,{3,4},"uint32/reverse_rows/condition/(12,): backing source: shape")
eq(base.strides,{16,4},"uint32/reverse_rows/condition/(12,): backing source: strides")
eq(base.dtype,"uint32","uint32/reverse_rows/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"uint32/reverse_rows/condition/(12,): source shape")
eq(a.strides,{-16,4},"uint32/reverse_rows/condition/(12,): source strides")
cases=cases+1
end
-- 93: uint32/reverse_rows/condition/(14,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32")
local a=np.flip(base,1)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"uint32/reverse_rows/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32/reverse_rows/condition/(14,): backing source")
eq(base.shape,{3,4},"uint32/reverse_rows/condition/(14,): backing source: shape")
eq(base.strides,{16,4},"uint32/reverse_rows/condition/(14,): backing source: strides")
eq(base.dtype,"uint32","uint32/reverse_rows/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"uint32/reverse_rows/condition/(14,): source shape")
eq(a.strides,{-16,4},"uint32/reverse_rows/condition/(14,): source strides")
cases=cases+1
end
-- 94: uint32/reverse_rows/condition/(0,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32")
local a=np.flip(base,1)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint32/reverse_rows/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"uint32/reverse_rows/condition/(0,): result")
eq(result.shape,{0},"uint32/reverse_rows/condition/(0,): result: shape")
eq(result.strides,{0},"uint32/reverse_rows/condition/(0,): result: strides")
eq(result.dtype,"uint32","uint32/reverse_rows/condition/(0,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32/reverse_rows/condition/(0,): backing source")
eq(base.shape,{3,4},"uint32/reverse_rows/condition/(0,): backing source: shape")
eq(base.strides,{16,4},"uint32/reverse_rows/condition/(0,): backing source: strides")
eq(base.dtype,"uint32","uint32/reverse_rows/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"uint32/reverse_rows/condition/(0,): source shape")
eq(a.strides,{-16,4},"uint32/reverse_rows/condition/(0,): source strides")
cases=cases+1
end
-- 95: uint32/reverse_rows/condition/(); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32")
local a=np.flip(base,1)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint32/reverse_rows/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{8},"uint32/reverse_rows/condition/(): result")
eq(result.shape,{1},"uint32/reverse_rows/condition/(): result: shape")
eq(result.strides,{4},"uint32/reverse_rows/condition/(): result: strides")
eq(result.dtype,"uint32","uint32/reverse_rows/condition/(): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32/reverse_rows/condition/(): backing source")
eq(base.shape,{3,4},"uint32/reverse_rows/condition/(): backing source: shape")
eq(base.strides,{16,4},"uint32/reverse_rows/condition/(): backing source: strides")
eq(base.dtype,"uint32","uint32/reverse_rows/condition/(): backing source: dtype")
eq(a.shape,{3,4},"uint32/reverse_rows/condition/(): source shape")
eq(a.strides,{-16,4},"uint32/reverse_rows/condition/(): source strides")
cases=cases+1
end
-- 96: uint32/strided/condition/(2, 3); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint32/strided/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{0,4,8},"uint32/strided/condition/(2, 3): result")
eq(result.shape,{3},"uint32/strided/condition/(2, 3): result: shape")
eq(result.strides,{4},"uint32/strided/condition/(2, 3): result: strides")
eq(result.dtype,"uint32","uint32/strided/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32/strided/condition/(2, 3): backing source")
eq(base.shape,{3,4},"uint32/strided/condition/(2, 3): backing source: shape")
eq(base.strides,{16,4},"uint32/strided/condition/(2, 3): backing source: strides")
eq(base.dtype,"uint32","uint32/strided/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,2},"uint32/strided/condition/(2, 3): source shape")
eq(a.strides,{16,8},"uint32/strided/condition/(2, 3): source strides")
cases=cases+1
end
-- 97: uint32/strided/condition/(12,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"uint32/strided/condition/(12,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32/strided/condition/(12,): backing source")
eq(base.shape,{3,4},"uint32/strided/condition/(12,): backing source: shape")
eq(base.strides,{16,4},"uint32/strided/condition/(12,): backing source: strides")
eq(base.dtype,"uint32","uint32/strided/condition/(12,): backing source: dtype")
eq(a.shape,{3,2},"uint32/strided/condition/(12,): source shape")
eq(a.strides,{16,8},"uint32/strided/condition/(12,): source strides")
cases=cases+1
end
-- 98: uint32/strided/condition/(14,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"uint32/strided/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32/strided/condition/(14,): backing source")
eq(base.shape,{3,4},"uint32/strided/condition/(14,): backing source: shape")
eq(base.strides,{16,4},"uint32/strided/condition/(14,): backing source: strides")
eq(base.dtype,"uint32","uint32/strided/condition/(14,): backing source: dtype")
eq(a.shape,{3,2},"uint32/strided/condition/(14,): source shape")
eq(a.strides,{16,8},"uint32/strided/condition/(14,): source strides")
cases=cases+1
end
-- 99: uint32/strided/condition/(0,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint32/strided/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"uint32/strided/condition/(0,): result")
eq(result.shape,{0},"uint32/strided/condition/(0,): result: shape")
eq(result.strides,{0},"uint32/strided/condition/(0,): result: strides")
eq(result.dtype,"uint32","uint32/strided/condition/(0,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32/strided/condition/(0,): backing source")
eq(base.shape,{3,4},"uint32/strided/condition/(0,): backing source: shape")
eq(base.strides,{16,4},"uint32/strided/condition/(0,): backing source: strides")
eq(base.dtype,"uint32","uint32/strided/condition/(0,): backing source: dtype")
eq(a.shape,{3,2},"uint32/strided/condition/(0,): source shape")
eq(a.strides,{16,8},"uint32/strided/condition/(0,): source strides")
cases=cases+1
end
-- 100: uint32/strided/condition/(); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint32/strided/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{0},"uint32/strided/condition/(): result")
eq(result.shape,{1},"uint32/strided/condition/(): result: shape")
eq(result.strides,{4},"uint32/strided/condition/(): result: strides")
eq(result.dtype,"uint32","uint32/strided/condition/(): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32/strided/condition/(): backing source")
eq(base.shape,{3,4},"uint32/strided/condition/(): backing source: shape")
eq(base.strides,{16,4},"uint32/strided/condition/(): backing source: strides")
eq(base.dtype,"uint32","uint32/strided/condition/(): backing source: dtype")
eq(a.shape,{3,2},"uint32/strided/condition/(): source shape")
eq(a.strides,{16,8},"uint32/strided/condition/(): source strides")
cases=cases+1
end
-- 101: int64/plain/condition/(2, 3); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64")
local a=base
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int64/plain/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{0,2,4},"int64/plain/condition/(2, 3): result")
eq(result.shape,{3},"int64/plain/condition/(2, 3): result: shape")
eq(result.strides,{8},"int64/plain/condition/(2, 3): result: strides")
eq(result.dtype,"int64","int64/plain/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64/plain/condition/(2, 3): backing source")
eq(base.shape,{3,4},"int64/plain/condition/(2, 3): backing source: shape")
eq(base.strides,{32,8},"int64/plain/condition/(2, 3): backing source: strides")
eq(base.dtype,"int64","int64/plain/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"int64/plain/condition/(2, 3): source shape")
eq(a.strides,{32,8},"int64/plain/condition/(2, 3): source strides")
cases=cases+1
end
-- 102: int64/plain/condition/(12,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64")
local a=base
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int64/plain/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0,2,4,6,8,10},"int64/plain/condition/(12,): result")
eq(result.shape,{6},"int64/plain/condition/(12,): result: shape")
eq(result.strides,{8},"int64/plain/condition/(12,): result: strides")
eq(result.dtype,"int64","int64/plain/condition/(12,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64/plain/condition/(12,): backing source")
eq(base.shape,{3,4},"int64/plain/condition/(12,): backing source: shape")
eq(base.strides,{32,8},"int64/plain/condition/(12,): backing source: strides")
eq(base.dtype,"int64","int64/plain/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"int64/plain/condition/(12,): source shape")
eq(a.strides,{32,8},"int64/plain/condition/(12,): source strides")
cases=cases+1
end
-- 103: int64/plain/condition/(14,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64")
local a=base
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"int64/plain/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64/plain/condition/(14,): backing source")
eq(base.shape,{3,4},"int64/plain/condition/(14,): backing source: shape")
eq(base.strides,{32,8},"int64/plain/condition/(14,): backing source: strides")
eq(base.dtype,"int64","int64/plain/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"int64/plain/condition/(14,): source shape")
eq(a.strides,{32,8},"int64/plain/condition/(14,): source strides")
cases=cases+1
end
-- 104: int64/plain/condition/(0,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int64/plain/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"int64/plain/condition/(0,): result")
eq(result.shape,{0},"int64/plain/condition/(0,): result: shape")
eq(result.strides,{0},"int64/plain/condition/(0,): result: strides")
eq(result.dtype,"int64","int64/plain/condition/(0,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64/plain/condition/(0,): backing source")
eq(base.shape,{3,4},"int64/plain/condition/(0,): backing source: shape")
eq(base.strides,{32,8},"int64/plain/condition/(0,): backing source: strides")
eq(base.dtype,"int64","int64/plain/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"int64/plain/condition/(0,): source shape")
eq(a.strides,{32,8},"int64/plain/condition/(0,): source strides")
cases=cases+1
end
-- 105: int64/plain/condition/(); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int64/plain/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{0},"int64/plain/condition/(): result")
eq(result.shape,{1},"int64/plain/condition/(): result: shape")
eq(result.strides,{8},"int64/plain/condition/(): result: strides")
eq(result.dtype,"int64","int64/plain/condition/(): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64/plain/condition/(): backing source")
eq(base.shape,{3,4},"int64/plain/condition/(): backing source: shape")
eq(base.strides,{32,8},"int64/plain/condition/(): backing source: strides")
eq(base.dtype,"int64","int64/plain/condition/(): backing source: dtype")
eq(a.shape,{3,4},"int64/plain/condition/(): source shape")
eq(a.strides,{32,8},"int64/plain/condition/(): source strides")
cases=cases+1
end
-- 106: int64/transpose/condition/(2, 3); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64")
local a=np.transpose(base)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int64/transpose/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{0,8,5},"int64/transpose/condition/(2, 3): result")
eq(result.shape,{3},"int64/transpose/condition/(2, 3): result: shape")
eq(result.strides,{8},"int64/transpose/condition/(2, 3): result: strides")
eq(result.dtype,"int64","int64/transpose/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64/transpose/condition/(2, 3): backing source")
eq(base.shape,{3,4},"int64/transpose/condition/(2, 3): backing source: shape")
eq(base.strides,{32,8},"int64/transpose/condition/(2, 3): backing source: strides")
eq(base.dtype,"int64","int64/transpose/condition/(2, 3): backing source: dtype")
eq(a.shape,{4,3},"int64/transpose/condition/(2, 3): source shape")
eq(a.strides,{8,32},"int64/transpose/condition/(2, 3): source strides")
cases=cases+1
end
-- 107: int64/transpose/condition/(12,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64")
local a=np.transpose(base)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int64/transpose/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0,8,5,2,10,7},"int64/transpose/condition/(12,): result")
eq(result.shape,{6},"int64/transpose/condition/(12,): result: shape")
eq(result.strides,{8},"int64/transpose/condition/(12,): result: strides")
eq(result.dtype,"int64","int64/transpose/condition/(12,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64/transpose/condition/(12,): backing source")
eq(base.shape,{3,4},"int64/transpose/condition/(12,): backing source: shape")
eq(base.strides,{32,8},"int64/transpose/condition/(12,): backing source: strides")
eq(base.dtype,"int64","int64/transpose/condition/(12,): backing source: dtype")
eq(a.shape,{4,3},"int64/transpose/condition/(12,): source shape")
eq(a.strides,{8,32},"int64/transpose/condition/(12,): source strides")
cases=cases+1
end
-- 108: int64/transpose/condition/(14,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64")
local a=np.transpose(base)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"int64/transpose/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64/transpose/condition/(14,): backing source")
eq(base.shape,{3,4},"int64/transpose/condition/(14,): backing source: shape")
eq(base.strides,{32,8},"int64/transpose/condition/(14,): backing source: strides")
eq(base.dtype,"int64","int64/transpose/condition/(14,): backing source: dtype")
eq(a.shape,{4,3},"int64/transpose/condition/(14,): source shape")
eq(a.strides,{8,32},"int64/transpose/condition/(14,): source strides")
cases=cases+1
end
-- 109: int64/transpose/condition/(0,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64")
local a=np.transpose(base)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int64/transpose/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"int64/transpose/condition/(0,): result")
eq(result.shape,{0},"int64/transpose/condition/(0,): result: shape")
eq(result.strides,{0},"int64/transpose/condition/(0,): result: strides")
eq(result.dtype,"int64","int64/transpose/condition/(0,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64/transpose/condition/(0,): backing source")
eq(base.shape,{3,4},"int64/transpose/condition/(0,): backing source: shape")
eq(base.strides,{32,8},"int64/transpose/condition/(0,): backing source: strides")
eq(base.dtype,"int64","int64/transpose/condition/(0,): backing source: dtype")
eq(a.shape,{4,3},"int64/transpose/condition/(0,): source shape")
eq(a.strides,{8,32},"int64/transpose/condition/(0,): source strides")
cases=cases+1
end
-- 110: int64/transpose/condition/(); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64")
local a=np.transpose(base)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int64/transpose/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{0},"int64/transpose/condition/(): result")
eq(result.shape,{1},"int64/transpose/condition/(): result: shape")
eq(result.strides,{8},"int64/transpose/condition/(): result: strides")
eq(result.dtype,"int64","int64/transpose/condition/(): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64/transpose/condition/(): backing source")
eq(base.shape,{3,4},"int64/transpose/condition/(): backing source: shape")
eq(base.strides,{32,8},"int64/transpose/condition/(): backing source: strides")
eq(base.dtype,"int64","int64/transpose/condition/(): backing source: dtype")
eq(a.shape,{4,3},"int64/transpose/condition/(): source shape")
eq(a.strides,{8,32},"int64/transpose/condition/(): source strides")
cases=cases+1
end
-- 111: int64/reverse_columns/condition/(2, 3); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64")
local a=np.flip(base,2)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int64/reverse_columns/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{3,1,7},"int64/reverse_columns/condition/(2, 3): result")
eq(result.shape,{3},"int64/reverse_columns/condition/(2, 3): result: shape")
eq(result.strides,{8},"int64/reverse_columns/condition/(2, 3): result: strides")
eq(result.dtype,"int64","int64/reverse_columns/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64/reverse_columns/condition/(2, 3): backing source")
eq(base.shape,{3,4},"int64/reverse_columns/condition/(2, 3): backing source: shape")
eq(base.strides,{32,8},"int64/reverse_columns/condition/(2, 3): backing source: strides")
eq(base.dtype,"int64","int64/reverse_columns/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"int64/reverse_columns/condition/(2, 3): source shape")
eq(a.strides,{32,-8},"int64/reverse_columns/condition/(2, 3): source strides")
cases=cases+1
end
-- 112: int64/reverse_columns/condition/(12,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64")
local a=np.flip(base,2)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int64/reverse_columns/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{3,1,7,5,11,9},"int64/reverse_columns/condition/(12,): result")
eq(result.shape,{6},"int64/reverse_columns/condition/(12,): result: shape")
eq(result.strides,{8},"int64/reverse_columns/condition/(12,): result: strides")
eq(result.dtype,"int64","int64/reverse_columns/condition/(12,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64/reverse_columns/condition/(12,): backing source")
eq(base.shape,{3,4},"int64/reverse_columns/condition/(12,): backing source: shape")
eq(base.strides,{32,8},"int64/reverse_columns/condition/(12,): backing source: strides")
eq(base.dtype,"int64","int64/reverse_columns/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"int64/reverse_columns/condition/(12,): source shape")
eq(a.strides,{32,-8},"int64/reverse_columns/condition/(12,): source strides")
cases=cases+1
end
-- 113: int64/reverse_columns/condition/(14,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64")
local a=np.flip(base,2)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"int64/reverse_columns/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64/reverse_columns/condition/(14,): backing source")
eq(base.shape,{3,4},"int64/reverse_columns/condition/(14,): backing source: shape")
eq(base.strides,{32,8},"int64/reverse_columns/condition/(14,): backing source: strides")
eq(base.dtype,"int64","int64/reverse_columns/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"int64/reverse_columns/condition/(14,): source shape")
eq(a.strides,{32,-8},"int64/reverse_columns/condition/(14,): source strides")
cases=cases+1
end
-- 114: int64/reverse_columns/condition/(0,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64")
local a=np.flip(base,2)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int64/reverse_columns/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"int64/reverse_columns/condition/(0,): result")
eq(result.shape,{0},"int64/reverse_columns/condition/(0,): result: shape")
eq(result.strides,{0},"int64/reverse_columns/condition/(0,): result: strides")
eq(result.dtype,"int64","int64/reverse_columns/condition/(0,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64/reverse_columns/condition/(0,): backing source")
eq(base.shape,{3,4},"int64/reverse_columns/condition/(0,): backing source: shape")
eq(base.strides,{32,8},"int64/reverse_columns/condition/(0,): backing source: strides")
eq(base.dtype,"int64","int64/reverse_columns/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"int64/reverse_columns/condition/(0,): source shape")
eq(a.strides,{32,-8},"int64/reverse_columns/condition/(0,): source strides")
cases=cases+1
end
-- 115: int64/reverse_columns/condition/(); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64")
local a=np.flip(base,2)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int64/reverse_columns/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{3},"int64/reverse_columns/condition/(): result")
eq(result.shape,{1},"int64/reverse_columns/condition/(): result: shape")
eq(result.strides,{8},"int64/reverse_columns/condition/(): result: strides")
eq(result.dtype,"int64","int64/reverse_columns/condition/(): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64/reverse_columns/condition/(): backing source")
eq(base.shape,{3,4},"int64/reverse_columns/condition/(): backing source: shape")
eq(base.strides,{32,8},"int64/reverse_columns/condition/(): backing source: strides")
eq(base.dtype,"int64","int64/reverse_columns/condition/(): backing source: dtype")
eq(a.shape,{3,4},"int64/reverse_columns/condition/(): source shape")
eq(a.strides,{32,-8},"int64/reverse_columns/condition/(): source strides")
cases=cases+1
end
-- 116: int64/reverse_rows/condition/(2, 3); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64")
local a=np.flip(base,1)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int64/reverse_rows/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{8,10,4},"int64/reverse_rows/condition/(2, 3): result")
eq(result.shape,{3},"int64/reverse_rows/condition/(2, 3): result: shape")
eq(result.strides,{8},"int64/reverse_rows/condition/(2, 3): result: strides")
eq(result.dtype,"int64","int64/reverse_rows/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64/reverse_rows/condition/(2, 3): backing source")
eq(base.shape,{3,4},"int64/reverse_rows/condition/(2, 3): backing source: shape")
eq(base.strides,{32,8},"int64/reverse_rows/condition/(2, 3): backing source: strides")
eq(base.dtype,"int64","int64/reverse_rows/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"int64/reverse_rows/condition/(2, 3): source shape")
eq(a.strides,{-32,8},"int64/reverse_rows/condition/(2, 3): source strides")
cases=cases+1
end
-- 117: int64/reverse_rows/condition/(12,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64")
local a=np.flip(base,1)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int64/reverse_rows/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{8,10,4,6,0,2},"int64/reverse_rows/condition/(12,): result")
eq(result.shape,{6},"int64/reverse_rows/condition/(12,): result: shape")
eq(result.strides,{8},"int64/reverse_rows/condition/(12,): result: strides")
eq(result.dtype,"int64","int64/reverse_rows/condition/(12,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64/reverse_rows/condition/(12,): backing source")
eq(base.shape,{3,4},"int64/reverse_rows/condition/(12,): backing source: shape")
eq(base.strides,{32,8},"int64/reverse_rows/condition/(12,): backing source: strides")
eq(base.dtype,"int64","int64/reverse_rows/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"int64/reverse_rows/condition/(12,): source shape")
eq(a.strides,{-32,8},"int64/reverse_rows/condition/(12,): source strides")
cases=cases+1
end
-- 118: int64/reverse_rows/condition/(14,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64")
local a=np.flip(base,1)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"int64/reverse_rows/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64/reverse_rows/condition/(14,): backing source")
eq(base.shape,{3,4},"int64/reverse_rows/condition/(14,): backing source: shape")
eq(base.strides,{32,8},"int64/reverse_rows/condition/(14,): backing source: strides")
eq(base.dtype,"int64","int64/reverse_rows/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"int64/reverse_rows/condition/(14,): source shape")
eq(a.strides,{-32,8},"int64/reverse_rows/condition/(14,): source strides")
cases=cases+1
end
-- 119: int64/reverse_rows/condition/(0,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64")
local a=np.flip(base,1)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int64/reverse_rows/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"int64/reverse_rows/condition/(0,): result")
eq(result.shape,{0},"int64/reverse_rows/condition/(0,): result: shape")
eq(result.strides,{0},"int64/reverse_rows/condition/(0,): result: strides")
eq(result.dtype,"int64","int64/reverse_rows/condition/(0,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64/reverse_rows/condition/(0,): backing source")
eq(base.shape,{3,4},"int64/reverse_rows/condition/(0,): backing source: shape")
eq(base.strides,{32,8},"int64/reverse_rows/condition/(0,): backing source: strides")
eq(base.dtype,"int64","int64/reverse_rows/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"int64/reverse_rows/condition/(0,): source shape")
eq(a.strides,{-32,8},"int64/reverse_rows/condition/(0,): source strides")
cases=cases+1
end
-- 120: int64/reverse_rows/condition/(); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64")
local a=np.flip(base,1)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int64/reverse_rows/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{8},"int64/reverse_rows/condition/(): result")
eq(result.shape,{1},"int64/reverse_rows/condition/(): result: shape")
eq(result.strides,{8},"int64/reverse_rows/condition/(): result: strides")
eq(result.dtype,"int64","int64/reverse_rows/condition/(): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64/reverse_rows/condition/(): backing source")
eq(base.shape,{3,4},"int64/reverse_rows/condition/(): backing source: shape")
eq(base.strides,{32,8},"int64/reverse_rows/condition/(): backing source: strides")
eq(base.dtype,"int64","int64/reverse_rows/condition/(): backing source: dtype")
eq(a.shape,{3,4},"int64/reverse_rows/condition/(): source shape")
eq(a.strides,{-32,8},"int64/reverse_rows/condition/(): source strides")
cases=cases+1
end
-- 121: int64/strided/condition/(2, 3); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int64/strided/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{0,4,8},"int64/strided/condition/(2, 3): result")
eq(result.shape,{3},"int64/strided/condition/(2, 3): result: shape")
eq(result.strides,{8},"int64/strided/condition/(2, 3): result: strides")
eq(result.dtype,"int64","int64/strided/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64/strided/condition/(2, 3): backing source")
eq(base.shape,{3,4},"int64/strided/condition/(2, 3): backing source: shape")
eq(base.strides,{32,8},"int64/strided/condition/(2, 3): backing source: strides")
eq(base.dtype,"int64","int64/strided/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,2},"int64/strided/condition/(2, 3): source shape")
eq(a.strides,{32,16},"int64/strided/condition/(2, 3): source strides")
cases=cases+1
end
-- 122: int64/strided/condition/(12,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"int64/strided/condition/(12,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64/strided/condition/(12,): backing source")
eq(base.shape,{3,4},"int64/strided/condition/(12,): backing source: shape")
eq(base.strides,{32,8},"int64/strided/condition/(12,): backing source: strides")
eq(base.dtype,"int64","int64/strided/condition/(12,): backing source: dtype")
eq(a.shape,{3,2},"int64/strided/condition/(12,): source shape")
eq(a.strides,{32,16},"int64/strided/condition/(12,): source strides")
cases=cases+1
end
-- 123: int64/strided/condition/(14,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"int64/strided/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64/strided/condition/(14,): backing source")
eq(base.shape,{3,4},"int64/strided/condition/(14,): backing source: shape")
eq(base.strides,{32,8},"int64/strided/condition/(14,): backing source: strides")
eq(base.dtype,"int64","int64/strided/condition/(14,): backing source: dtype")
eq(a.shape,{3,2},"int64/strided/condition/(14,): source shape")
eq(a.strides,{32,16},"int64/strided/condition/(14,): source strides")
cases=cases+1
end
-- 124: int64/strided/condition/(0,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int64/strided/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"int64/strided/condition/(0,): result")
eq(result.shape,{0},"int64/strided/condition/(0,): result: shape")
eq(result.strides,{0},"int64/strided/condition/(0,): result: strides")
eq(result.dtype,"int64","int64/strided/condition/(0,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64/strided/condition/(0,): backing source")
eq(base.shape,{3,4},"int64/strided/condition/(0,): backing source: shape")
eq(base.strides,{32,8},"int64/strided/condition/(0,): backing source: strides")
eq(base.dtype,"int64","int64/strided/condition/(0,): backing source: dtype")
eq(a.shape,{3,2},"int64/strided/condition/(0,): source shape")
eq(a.strides,{32,16},"int64/strided/condition/(0,): source strides")
cases=cases+1
end
-- 125: int64/strided/condition/(); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"int64/strided/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{0},"int64/strided/condition/(): result")
eq(result.shape,{1},"int64/strided/condition/(): result: shape")
eq(result.strides,{8},"int64/strided/condition/(): result: strides")
eq(result.dtype,"int64","int64/strided/condition/(): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64/strided/condition/(): backing source")
eq(base.shape,{3,4},"int64/strided/condition/(): backing source: shape")
eq(base.strides,{32,8},"int64/strided/condition/(): backing source: strides")
eq(base.dtype,"int64","int64/strided/condition/(): backing source: dtype")
eq(a.shape,{3,2},"int64/strided/condition/(): source shape")
eq(a.strides,{32,16},"int64/strided/condition/(): source strides")
cases=cases+1
end
-- 126: uint64/plain/condition/(2, 3); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64")
local a=base
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint64/plain/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{0,2,4},"uint64/plain/condition/(2, 3): result")
eq(result.shape,{3},"uint64/plain/condition/(2, 3): result: shape")
eq(result.strides,{8},"uint64/plain/condition/(2, 3): result: strides")
eq(result.dtype,"uint64","uint64/plain/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64/plain/condition/(2, 3): backing source")
eq(base.shape,{3,4},"uint64/plain/condition/(2, 3): backing source: shape")
eq(base.strides,{32,8},"uint64/plain/condition/(2, 3): backing source: strides")
eq(base.dtype,"uint64","uint64/plain/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"uint64/plain/condition/(2, 3): source shape")
eq(a.strides,{32,8},"uint64/plain/condition/(2, 3): source strides")
cases=cases+1
end
-- 127: uint64/plain/condition/(12,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64")
local a=base
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint64/plain/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0,2,4,6,8,10},"uint64/plain/condition/(12,): result")
eq(result.shape,{6},"uint64/plain/condition/(12,): result: shape")
eq(result.strides,{8},"uint64/plain/condition/(12,): result: strides")
eq(result.dtype,"uint64","uint64/plain/condition/(12,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64/plain/condition/(12,): backing source")
eq(base.shape,{3,4},"uint64/plain/condition/(12,): backing source: shape")
eq(base.strides,{32,8},"uint64/plain/condition/(12,): backing source: strides")
eq(base.dtype,"uint64","uint64/plain/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"uint64/plain/condition/(12,): source shape")
eq(a.strides,{32,8},"uint64/plain/condition/(12,): source strides")
cases=cases+1
end
-- 128: uint64/plain/condition/(14,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64")
local a=base
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"uint64/plain/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64/plain/condition/(14,): backing source")
eq(base.shape,{3,4},"uint64/plain/condition/(14,): backing source: shape")
eq(base.strides,{32,8},"uint64/plain/condition/(14,): backing source: strides")
eq(base.dtype,"uint64","uint64/plain/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"uint64/plain/condition/(14,): source shape")
eq(a.strides,{32,8},"uint64/plain/condition/(14,): source strides")
cases=cases+1
end
-- 129: uint64/plain/condition/(0,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint64/plain/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"uint64/plain/condition/(0,): result")
eq(result.shape,{0},"uint64/plain/condition/(0,): result: shape")
eq(result.strides,{0},"uint64/plain/condition/(0,): result: strides")
eq(result.dtype,"uint64","uint64/plain/condition/(0,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64/plain/condition/(0,): backing source")
eq(base.shape,{3,4},"uint64/plain/condition/(0,): backing source: shape")
eq(base.strides,{32,8},"uint64/plain/condition/(0,): backing source: strides")
eq(base.dtype,"uint64","uint64/plain/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"uint64/plain/condition/(0,): source shape")
eq(a.strides,{32,8},"uint64/plain/condition/(0,): source strides")
cases=cases+1
end
-- 130: uint64/plain/condition/(); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint64/plain/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{0},"uint64/plain/condition/(): result")
eq(result.shape,{1},"uint64/plain/condition/(): result: shape")
eq(result.strides,{8},"uint64/plain/condition/(): result: strides")
eq(result.dtype,"uint64","uint64/plain/condition/(): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64/plain/condition/(): backing source")
eq(base.shape,{3,4},"uint64/plain/condition/(): backing source: shape")
eq(base.strides,{32,8},"uint64/plain/condition/(): backing source: strides")
eq(base.dtype,"uint64","uint64/plain/condition/(): backing source: dtype")
eq(a.shape,{3,4},"uint64/plain/condition/(): source shape")
eq(a.strides,{32,8},"uint64/plain/condition/(): source strides")
cases=cases+1
end
-- 131: uint64/transpose/condition/(2, 3); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64")
local a=np.transpose(base)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint64/transpose/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{0,8,5},"uint64/transpose/condition/(2, 3): result")
eq(result.shape,{3},"uint64/transpose/condition/(2, 3): result: shape")
eq(result.strides,{8},"uint64/transpose/condition/(2, 3): result: strides")
eq(result.dtype,"uint64","uint64/transpose/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64/transpose/condition/(2, 3): backing source")
eq(base.shape,{3,4},"uint64/transpose/condition/(2, 3): backing source: shape")
eq(base.strides,{32,8},"uint64/transpose/condition/(2, 3): backing source: strides")
eq(base.dtype,"uint64","uint64/transpose/condition/(2, 3): backing source: dtype")
eq(a.shape,{4,3},"uint64/transpose/condition/(2, 3): source shape")
eq(a.strides,{8,32},"uint64/transpose/condition/(2, 3): source strides")
cases=cases+1
end
-- 132: uint64/transpose/condition/(12,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64")
local a=np.transpose(base)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint64/transpose/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0,8,5,2,10,7},"uint64/transpose/condition/(12,): result")
eq(result.shape,{6},"uint64/transpose/condition/(12,): result: shape")
eq(result.strides,{8},"uint64/transpose/condition/(12,): result: strides")
eq(result.dtype,"uint64","uint64/transpose/condition/(12,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64/transpose/condition/(12,): backing source")
eq(base.shape,{3,4},"uint64/transpose/condition/(12,): backing source: shape")
eq(base.strides,{32,8},"uint64/transpose/condition/(12,): backing source: strides")
eq(base.dtype,"uint64","uint64/transpose/condition/(12,): backing source: dtype")
eq(a.shape,{4,3},"uint64/transpose/condition/(12,): source shape")
eq(a.strides,{8,32},"uint64/transpose/condition/(12,): source strides")
cases=cases+1
end
-- 133: uint64/transpose/condition/(14,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64")
local a=np.transpose(base)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"uint64/transpose/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64/transpose/condition/(14,): backing source")
eq(base.shape,{3,4},"uint64/transpose/condition/(14,): backing source: shape")
eq(base.strides,{32,8},"uint64/transpose/condition/(14,): backing source: strides")
eq(base.dtype,"uint64","uint64/transpose/condition/(14,): backing source: dtype")
eq(a.shape,{4,3},"uint64/transpose/condition/(14,): source shape")
eq(a.strides,{8,32},"uint64/transpose/condition/(14,): source strides")
cases=cases+1
end
-- 134: uint64/transpose/condition/(0,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64")
local a=np.transpose(base)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint64/transpose/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"uint64/transpose/condition/(0,): result")
eq(result.shape,{0},"uint64/transpose/condition/(0,): result: shape")
eq(result.strides,{0},"uint64/transpose/condition/(0,): result: strides")
eq(result.dtype,"uint64","uint64/transpose/condition/(0,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64/transpose/condition/(0,): backing source")
eq(base.shape,{3,4},"uint64/transpose/condition/(0,): backing source: shape")
eq(base.strides,{32,8},"uint64/transpose/condition/(0,): backing source: strides")
eq(base.dtype,"uint64","uint64/transpose/condition/(0,): backing source: dtype")
eq(a.shape,{4,3},"uint64/transpose/condition/(0,): source shape")
eq(a.strides,{8,32},"uint64/transpose/condition/(0,): source strides")
cases=cases+1
end
-- 135: uint64/transpose/condition/(); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64")
local a=np.transpose(base)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint64/transpose/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{0},"uint64/transpose/condition/(): result")
eq(result.shape,{1},"uint64/transpose/condition/(): result: shape")
eq(result.strides,{8},"uint64/transpose/condition/(): result: strides")
eq(result.dtype,"uint64","uint64/transpose/condition/(): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64/transpose/condition/(): backing source")
eq(base.shape,{3,4},"uint64/transpose/condition/(): backing source: shape")
eq(base.strides,{32,8},"uint64/transpose/condition/(): backing source: strides")
eq(base.dtype,"uint64","uint64/transpose/condition/(): backing source: dtype")
eq(a.shape,{4,3},"uint64/transpose/condition/(): source shape")
eq(a.strides,{8,32},"uint64/transpose/condition/(): source strides")
cases=cases+1
end
-- 136: uint64/reverse_columns/condition/(2, 3); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64")
local a=np.flip(base,2)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint64/reverse_columns/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{3,1,7},"uint64/reverse_columns/condition/(2, 3): result")
eq(result.shape,{3},"uint64/reverse_columns/condition/(2, 3): result: shape")
eq(result.strides,{8},"uint64/reverse_columns/condition/(2, 3): result: strides")
eq(result.dtype,"uint64","uint64/reverse_columns/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64/reverse_columns/condition/(2, 3): backing source")
eq(base.shape,{3,4},"uint64/reverse_columns/condition/(2, 3): backing source: shape")
eq(base.strides,{32,8},"uint64/reverse_columns/condition/(2, 3): backing source: strides")
eq(base.dtype,"uint64","uint64/reverse_columns/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"uint64/reverse_columns/condition/(2, 3): source shape")
eq(a.strides,{32,-8},"uint64/reverse_columns/condition/(2, 3): source strides")
cases=cases+1
end
-- 137: uint64/reverse_columns/condition/(12,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64")
local a=np.flip(base,2)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint64/reverse_columns/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{3,1,7,5,11,9},"uint64/reverse_columns/condition/(12,): result")
eq(result.shape,{6},"uint64/reverse_columns/condition/(12,): result: shape")
eq(result.strides,{8},"uint64/reverse_columns/condition/(12,): result: strides")
eq(result.dtype,"uint64","uint64/reverse_columns/condition/(12,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64/reverse_columns/condition/(12,): backing source")
eq(base.shape,{3,4},"uint64/reverse_columns/condition/(12,): backing source: shape")
eq(base.strides,{32,8},"uint64/reverse_columns/condition/(12,): backing source: strides")
eq(base.dtype,"uint64","uint64/reverse_columns/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"uint64/reverse_columns/condition/(12,): source shape")
eq(a.strides,{32,-8},"uint64/reverse_columns/condition/(12,): source strides")
cases=cases+1
end
-- 138: uint64/reverse_columns/condition/(14,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64")
local a=np.flip(base,2)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"uint64/reverse_columns/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64/reverse_columns/condition/(14,): backing source")
eq(base.shape,{3,4},"uint64/reverse_columns/condition/(14,): backing source: shape")
eq(base.strides,{32,8},"uint64/reverse_columns/condition/(14,): backing source: strides")
eq(base.dtype,"uint64","uint64/reverse_columns/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"uint64/reverse_columns/condition/(14,): source shape")
eq(a.strides,{32,-8},"uint64/reverse_columns/condition/(14,): source strides")
cases=cases+1
end
-- 139: uint64/reverse_columns/condition/(0,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64")
local a=np.flip(base,2)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint64/reverse_columns/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"uint64/reverse_columns/condition/(0,): result")
eq(result.shape,{0},"uint64/reverse_columns/condition/(0,): result: shape")
eq(result.strides,{0},"uint64/reverse_columns/condition/(0,): result: strides")
eq(result.dtype,"uint64","uint64/reverse_columns/condition/(0,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64/reverse_columns/condition/(0,): backing source")
eq(base.shape,{3,4},"uint64/reverse_columns/condition/(0,): backing source: shape")
eq(base.strides,{32,8},"uint64/reverse_columns/condition/(0,): backing source: strides")
eq(base.dtype,"uint64","uint64/reverse_columns/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"uint64/reverse_columns/condition/(0,): source shape")
eq(a.strides,{32,-8},"uint64/reverse_columns/condition/(0,): source strides")
cases=cases+1
end
-- 140: uint64/reverse_columns/condition/(); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64")
local a=np.flip(base,2)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint64/reverse_columns/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{3},"uint64/reverse_columns/condition/(): result")
eq(result.shape,{1},"uint64/reverse_columns/condition/(): result: shape")
eq(result.strides,{8},"uint64/reverse_columns/condition/(): result: strides")
eq(result.dtype,"uint64","uint64/reverse_columns/condition/(): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64/reverse_columns/condition/(): backing source")
eq(base.shape,{3,4},"uint64/reverse_columns/condition/(): backing source: shape")
eq(base.strides,{32,8},"uint64/reverse_columns/condition/(): backing source: strides")
eq(base.dtype,"uint64","uint64/reverse_columns/condition/(): backing source: dtype")
eq(a.shape,{3,4},"uint64/reverse_columns/condition/(): source shape")
eq(a.strides,{32,-8},"uint64/reverse_columns/condition/(): source strides")
cases=cases+1
end
-- 141: uint64/reverse_rows/condition/(2, 3); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64")
local a=np.flip(base,1)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint64/reverse_rows/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{8,10,4},"uint64/reverse_rows/condition/(2, 3): result")
eq(result.shape,{3},"uint64/reverse_rows/condition/(2, 3): result: shape")
eq(result.strides,{8},"uint64/reverse_rows/condition/(2, 3): result: strides")
eq(result.dtype,"uint64","uint64/reverse_rows/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64/reverse_rows/condition/(2, 3): backing source")
eq(base.shape,{3,4},"uint64/reverse_rows/condition/(2, 3): backing source: shape")
eq(base.strides,{32,8},"uint64/reverse_rows/condition/(2, 3): backing source: strides")
eq(base.dtype,"uint64","uint64/reverse_rows/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"uint64/reverse_rows/condition/(2, 3): source shape")
eq(a.strides,{-32,8},"uint64/reverse_rows/condition/(2, 3): source strides")
cases=cases+1
end
-- 142: uint64/reverse_rows/condition/(12,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64")
local a=np.flip(base,1)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint64/reverse_rows/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{8,10,4,6,0,2},"uint64/reverse_rows/condition/(12,): result")
eq(result.shape,{6},"uint64/reverse_rows/condition/(12,): result: shape")
eq(result.strides,{8},"uint64/reverse_rows/condition/(12,): result: strides")
eq(result.dtype,"uint64","uint64/reverse_rows/condition/(12,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64/reverse_rows/condition/(12,): backing source")
eq(base.shape,{3,4},"uint64/reverse_rows/condition/(12,): backing source: shape")
eq(base.strides,{32,8},"uint64/reverse_rows/condition/(12,): backing source: strides")
eq(base.dtype,"uint64","uint64/reverse_rows/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"uint64/reverse_rows/condition/(12,): source shape")
eq(a.strides,{-32,8},"uint64/reverse_rows/condition/(12,): source strides")
cases=cases+1
end
-- 143: uint64/reverse_rows/condition/(14,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64")
local a=np.flip(base,1)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"uint64/reverse_rows/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64/reverse_rows/condition/(14,): backing source")
eq(base.shape,{3,4},"uint64/reverse_rows/condition/(14,): backing source: shape")
eq(base.strides,{32,8},"uint64/reverse_rows/condition/(14,): backing source: strides")
eq(base.dtype,"uint64","uint64/reverse_rows/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"uint64/reverse_rows/condition/(14,): source shape")
eq(a.strides,{-32,8},"uint64/reverse_rows/condition/(14,): source strides")
cases=cases+1
end
-- 144: uint64/reverse_rows/condition/(0,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64")
local a=np.flip(base,1)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint64/reverse_rows/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"uint64/reverse_rows/condition/(0,): result")
eq(result.shape,{0},"uint64/reverse_rows/condition/(0,): result: shape")
eq(result.strides,{0},"uint64/reverse_rows/condition/(0,): result: strides")
eq(result.dtype,"uint64","uint64/reverse_rows/condition/(0,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64/reverse_rows/condition/(0,): backing source")
eq(base.shape,{3,4},"uint64/reverse_rows/condition/(0,): backing source: shape")
eq(base.strides,{32,8},"uint64/reverse_rows/condition/(0,): backing source: strides")
eq(base.dtype,"uint64","uint64/reverse_rows/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"uint64/reverse_rows/condition/(0,): source shape")
eq(a.strides,{-32,8},"uint64/reverse_rows/condition/(0,): source strides")
cases=cases+1
end
-- 145: uint64/reverse_rows/condition/(); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64")
local a=np.flip(base,1)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint64/reverse_rows/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{8},"uint64/reverse_rows/condition/(): result")
eq(result.shape,{1},"uint64/reverse_rows/condition/(): result: shape")
eq(result.strides,{8},"uint64/reverse_rows/condition/(): result: strides")
eq(result.dtype,"uint64","uint64/reverse_rows/condition/(): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64/reverse_rows/condition/(): backing source")
eq(base.shape,{3,4},"uint64/reverse_rows/condition/(): backing source: shape")
eq(base.strides,{32,8},"uint64/reverse_rows/condition/(): backing source: strides")
eq(base.dtype,"uint64","uint64/reverse_rows/condition/(): backing source: dtype")
eq(a.shape,{3,4},"uint64/reverse_rows/condition/(): source shape")
eq(a.strides,{-32,8},"uint64/reverse_rows/condition/(): source strides")
cases=cases+1
end
-- 146: uint64/strided/condition/(2, 3); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint64/strided/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{0,4,8},"uint64/strided/condition/(2, 3): result")
eq(result.shape,{3},"uint64/strided/condition/(2, 3): result: shape")
eq(result.strides,{8},"uint64/strided/condition/(2, 3): result: strides")
eq(result.dtype,"uint64","uint64/strided/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64/strided/condition/(2, 3): backing source")
eq(base.shape,{3,4},"uint64/strided/condition/(2, 3): backing source: shape")
eq(base.strides,{32,8},"uint64/strided/condition/(2, 3): backing source: strides")
eq(base.dtype,"uint64","uint64/strided/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,2},"uint64/strided/condition/(2, 3): source shape")
eq(a.strides,{32,16},"uint64/strided/condition/(2, 3): source strides")
cases=cases+1
end
-- 147: uint64/strided/condition/(12,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"uint64/strided/condition/(12,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64/strided/condition/(12,): backing source")
eq(base.shape,{3,4},"uint64/strided/condition/(12,): backing source: shape")
eq(base.strides,{32,8},"uint64/strided/condition/(12,): backing source: strides")
eq(base.dtype,"uint64","uint64/strided/condition/(12,): backing source: dtype")
eq(a.shape,{3,2},"uint64/strided/condition/(12,): source shape")
eq(a.strides,{32,16},"uint64/strided/condition/(12,): source strides")
cases=cases+1
end
-- 148: uint64/strided/condition/(14,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"uint64/strided/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64/strided/condition/(14,): backing source")
eq(base.shape,{3,4},"uint64/strided/condition/(14,): backing source: shape")
eq(base.strides,{32,8},"uint64/strided/condition/(14,): backing source: strides")
eq(base.dtype,"uint64","uint64/strided/condition/(14,): backing source: dtype")
eq(a.shape,{3,2},"uint64/strided/condition/(14,): source shape")
eq(a.strides,{32,16},"uint64/strided/condition/(14,): source strides")
cases=cases+1
end
-- 149: uint64/strided/condition/(0,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint64/strided/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"uint64/strided/condition/(0,): result")
eq(result.shape,{0},"uint64/strided/condition/(0,): result: shape")
eq(result.strides,{0},"uint64/strided/condition/(0,): result: strides")
eq(result.dtype,"uint64","uint64/strided/condition/(0,): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64/strided/condition/(0,): backing source")
eq(base.shape,{3,4},"uint64/strided/condition/(0,): backing source: shape")
eq(base.strides,{32,8},"uint64/strided/condition/(0,): backing source: strides")
eq(base.dtype,"uint64","uint64/strided/condition/(0,): backing source: dtype")
eq(a.shape,{3,2},"uint64/strided/condition/(0,): source shape")
eq(a.strides,{32,16},"uint64/strided/condition/(0,): source strides")
cases=cases+1
end
-- 150: uint64/strided/condition/(); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"uint64/strided/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{0},"uint64/strided/condition/(): result")
eq(result.shape,{1},"uint64/strided/condition/(): result: shape")
eq(result.strides,{8},"uint64/strided/condition/(): result: strides")
eq(result.dtype,"uint64","uint64/strided/condition/(): result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64/strided/condition/(): backing source")
eq(base.shape,{3,4},"uint64/strided/condition/(): backing source: shape")
eq(base.strides,{32,8},"uint64/strided/condition/(): backing source: strides")
eq(base.dtype,"uint64","uint64/strided/condition/(): backing source: dtype")
eq(a.shape,{3,2},"uint64/strided/condition/(): source shape")
eq(a.strides,{32,16},"uint64/strided/condition/(): source strides")
cases=cases+1
end
-- 151: float16/plain/condition/(2, 3); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16")
local a=base
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float16/plain/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,2.0,4.0},"float16/plain/condition/(2, 3): result")
eq(result.shape,{3},"float16/plain/condition/(2, 3): result: shape")
eq(result.strides,{2},"float16/plain/condition/(2, 3): result: strides")
eq(result.dtype,"float16","float16/plain/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16/plain/condition/(2, 3): backing source")
eq(base.shape,{3,4},"float16/plain/condition/(2, 3): backing source: shape")
eq(base.strides,{8,2},"float16/plain/condition/(2, 3): backing source: strides")
eq(base.dtype,"float16","float16/plain/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"float16/plain/condition/(2, 3): source shape")
eq(a.strides,{8,2},"float16/plain/condition/(2, 3): source strides")
cases=cases+1
end
-- 152: float16/plain/condition/(12,); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16")
local a=base
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float16/plain/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,2.0,4.0,6.0,8.0,10.0},"float16/plain/condition/(12,): result")
eq(result.shape,{6},"float16/plain/condition/(12,): result: shape")
eq(result.strides,{2},"float16/plain/condition/(12,): result: strides")
eq(result.dtype,"float16","float16/plain/condition/(12,): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16/plain/condition/(12,): backing source")
eq(base.shape,{3,4},"float16/plain/condition/(12,): backing source: shape")
eq(base.strides,{8,2},"float16/plain/condition/(12,): backing source: strides")
eq(base.dtype,"float16","float16/plain/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"float16/plain/condition/(12,): source shape")
eq(a.strides,{8,2},"float16/plain/condition/(12,): source strides")
cases=cases+1
end
-- 153: float16/plain/condition/(14,); source error=IndexError
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16")
local a=base
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"float16/plain/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16/plain/condition/(14,): backing source")
eq(base.shape,{3,4},"float16/plain/condition/(14,): backing source: shape")
eq(base.strides,{8,2},"float16/plain/condition/(14,): backing source: strides")
eq(base.dtype,"float16","float16/plain/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"float16/plain/condition/(14,): source shape")
eq(a.strides,{8,2},"float16/plain/condition/(14,): source strides")
cases=cases+1
end
-- 154: float16/plain/condition/(0,); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float16/plain/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"float16/plain/condition/(0,): result")
eq(result.shape,{0},"float16/plain/condition/(0,): result: shape")
eq(result.strides,{0},"float16/plain/condition/(0,): result: strides")
eq(result.dtype,"float16","float16/plain/condition/(0,): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16/plain/condition/(0,): backing source")
eq(base.shape,{3,4},"float16/plain/condition/(0,): backing source: shape")
eq(base.strides,{8,2},"float16/plain/condition/(0,): backing source: strides")
eq(base.dtype,"float16","float16/plain/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"float16/plain/condition/(0,): source shape")
eq(a.strides,{8,2},"float16/plain/condition/(0,): source strides")
cases=cases+1
end
-- 155: float16/plain/condition/(); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float16/plain/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"float16/plain/condition/(): result")
eq(result.shape,{1},"float16/plain/condition/(): result: shape")
eq(result.strides,{2},"float16/plain/condition/(): result: strides")
eq(result.dtype,"float16","float16/plain/condition/(): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16/plain/condition/(): backing source")
eq(base.shape,{3,4},"float16/plain/condition/(): backing source: shape")
eq(base.strides,{8,2},"float16/plain/condition/(): backing source: strides")
eq(base.dtype,"float16","float16/plain/condition/(): backing source: dtype")
eq(a.shape,{3,4},"float16/plain/condition/(): source shape")
eq(a.strides,{8,2},"float16/plain/condition/(): source strides")
cases=cases+1
end
-- 156: float16/transpose/condition/(2, 3); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16")
local a=np.transpose(base)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float16/transpose/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,8.0,5.0},"float16/transpose/condition/(2, 3): result")
eq(result.shape,{3},"float16/transpose/condition/(2, 3): result: shape")
eq(result.strides,{2},"float16/transpose/condition/(2, 3): result: strides")
eq(result.dtype,"float16","float16/transpose/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16/transpose/condition/(2, 3): backing source")
eq(base.shape,{3,4},"float16/transpose/condition/(2, 3): backing source: shape")
eq(base.strides,{8,2},"float16/transpose/condition/(2, 3): backing source: strides")
eq(base.dtype,"float16","float16/transpose/condition/(2, 3): backing source: dtype")
eq(a.shape,{4,3},"float16/transpose/condition/(2, 3): source shape")
eq(a.strides,{2,8},"float16/transpose/condition/(2, 3): source strides")
cases=cases+1
end
-- 157: float16/transpose/condition/(12,); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16")
local a=np.transpose(base)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float16/transpose/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,8.0,5.0,2.0,10.0,7.0},"float16/transpose/condition/(12,): result")
eq(result.shape,{6},"float16/transpose/condition/(12,): result: shape")
eq(result.strides,{2},"float16/transpose/condition/(12,): result: strides")
eq(result.dtype,"float16","float16/transpose/condition/(12,): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16/transpose/condition/(12,): backing source")
eq(base.shape,{3,4},"float16/transpose/condition/(12,): backing source: shape")
eq(base.strides,{8,2},"float16/transpose/condition/(12,): backing source: strides")
eq(base.dtype,"float16","float16/transpose/condition/(12,): backing source: dtype")
eq(a.shape,{4,3},"float16/transpose/condition/(12,): source shape")
eq(a.strides,{2,8},"float16/transpose/condition/(12,): source strides")
cases=cases+1
end
-- 158: float16/transpose/condition/(14,); source error=IndexError
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16")
local a=np.transpose(base)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"float16/transpose/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16/transpose/condition/(14,): backing source")
eq(base.shape,{3,4},"float16/transpose/condition/(14,): backing source: shape")
eq(base.strides,{8,2},"float16/transpose/condition/(14,): backing source: strides")
eq(base.dtype,"float16","float16/transpose/condition/(14,): backing source: dtype")
eq(a.shape,{4,3},"float16/transpose/condition/(14,): source shape")
eq(a.strides,{2,8},"float16/transpose/condition/(14,): source strides")
cases=cases+1
end
-- 159: float16/transpose/condition/(0,); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16")
local a=np.transpose(base)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float16/transpose/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"float16/transpose/condition/(0,): result")
eq(result.shape,{0},"float16/transpose/condition/(0,): result: shape")
eq(result.strides,{0},"float16/transpose/condition/(0,): result: strides")
eq(result.dtype,"float16","float16/transpose/condition/(0,): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16/transpose/condition/(0,): backing source")
eq(base.shape,{3,4},"float16/transpose/condition/(0,): backing source: shape")
eq(base.strides,{8,2},"float16/transpose/condition/(0,): backing source: strides")
eq(base.dtype,"float16","float16/transpose/condition/(0,): backing source: dtype")
eq(a.shape,{4,3},"float16/transpose/condition/(0,): source shape")
eq(a.strides,{2,8},"float16/transpose/condition/(0,): source strides")
cases=cases+1
end
-- 160: float16/transpose/condition/(); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16")
local a=np.transpose(base)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float16/transpose/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"float16/transpose/condition/(): result")
eq(result.shape,{1},"float16/transpose/condition/(): result: shape")
eq(result.strides,{2},"float16/transpose/condition/(): result: strides")
eq(result.dtype,"float16","float16/transpose/condition/(): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16/transpose/condition/(): backing source")
eq(base.shape,{3,4},"float16/transpose/condition/(): backing source: shape")
eq(base.strides,{8,2},"float16/transpose/condition/(): backing source: strides")
eq(base.dtype,"float16","float16/transpose/condition/(): backing source: dtype")
eq(a.shape,{4,3},"float16/transpose/condition/(): source shape")
eq(a.strides,{2,8},"float16/transpose/condition/(): source strides")
cases=cases+1
end
-- 161: float16/reverse_columns/condition/(2, 3); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16")
local a=np.flip(base,2)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float16/reverse_columns/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{3.0,1.0,7.0},"float16/reverse_columns/condition/(2, 3): result")
eq(result.shape,{3},"float16/reverse_columns/condition/(2, 3): result: shape")
eq(result.strides,{2},"float16/reverse_columns/condition/(2, 3): result: strides")
eq(result.dtype,"float16","float16/reverse_columns/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16/reverse_columns/condition/(2, 3): backing source")
eq(base.shape,{3,4},"float16/reverse_columns/condition/(2, 3): backing source: shape")
eq(base.strides,{8,2},"float16/reverse_columns/condition/(2, 3): backing source: strides")
eq(base.dtype,"float16","float16/reverse_columns/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"float16/reverse_columns/condition/(2, 3): source shape")
eq(a.strides,{8,-2},"float16/reverse_columns/condition/(2, 3): source strides")
cases=cases+1
end
-- 162: float16/reverse_columns/condition/(12,); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16")
local a=np.flip(base,2)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float16/reverse_columns/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{3.0,1.0,7.0,5.0,11.0,9.0},"float16/reverse_columns/condition/(12,): result")
eq(result.shape,{6},"float16/reverse_columns/condition/(12,): result: shape")
eq(result.strides,{2},"float16/reverse_columns/condition/(12,): result: strides")
eq(result.dtype,"float16","float16/reverse_columns/condition/(12,): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16/reverse_columns/condition/(12,): backing source")
eq(base.shape,{3,4},"float16/reverse_columns/condition/(12,): backing source: shape")
eq(base.strides,{8,2},"float16/reverse_columns/condition/(12,): backing source: strides")
eq(base.dtype,"float16","float16/reverse_columns/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"float16/reverse_columns/condition/(12,): source shape")
eq(a.strides,{8,-2},"float16/reverse_columns/condition/(12,): source strides")
cases=cases+1
end
-- 163: float16/reverse_columns/condition/(14,); source error=IndexError
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16")
local a=np.flip(base,2)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"float16/reverse_columns/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16/reverse_columns/condition/(14,): backing source")
eq(base.shape,{3,4},"float16/reverse_columns/condition/(14,): backing source: shape")
eq(base.strides,{8,2},"float16/reverse_columns/condition/(14,): backing source: strides")
eq(base.dtype,"float16","float16/reverse_columns/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"float16/reverse_columns/condition/(14,): source shape")
eq(a.strides,{8,-2},"float16/reverse_columns/condition/(14,): source strides")
cases=cases+1
end
-- 164: float16/reverse_columns/condition/(0,); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16")
local a=np.flip(base,2)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float16/reverse_columns/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"float16/reverse_columns/condition/(0,): result")
eq(result.shape,{0},"float16/reverse_columns/condition/(0,): result: shape")
eq(result.strides,{0},"float16/reverse_columns/condition/(0,): result: strides")
eq(result.dtype,"float16","float16/reverse_columns/condition/(0,): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16/reverse_columns/condition/(0,): backing source")
eq(base.shape,{3,4},"float16/reverse_columns/condition/(0,): backing source: shape")
eq(base.strides,{8,2},"float16/reverse_columns/condition/(0,): backing source: strides")
eq(base.dtype,"float16","float16/reverse_columns/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"float16/reverse_columns/condition/(0,): source shape")
eq(a.strides,{8,-2},"float16/reverse_columns/condition/(0,): source strides")
cases=cases+1
end
-- 165: float16/reverse_columns/condition/(); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16")
local a=np.flip(base,2)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float16/reverse_columns/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{3.0},"float16/reverse_columns/condition/(): result")
eq(result.shape,{1},"float16/reverse_columns/condition/(): result: shape")
eq(result.strides,{2},"float16/reverse_columns/condition/(): result: strides")
eq(result.dtype,"float16","float16/reverse_columns/condition/(): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16/reverse_columns/condition/(): backing source")
eq(base.shape,{3,4},"float16/reverse_columns/condition/(): backing source: shape")
eq(base.strides,{8,2},"float16/reverse_columns/condition/(): backing source: strides")
eq(base.dtype,"float16","float16/reverse_columns/condition/(): backing source: dtype")
eq(a.shape,{3,4},"float16/reverse_columns/condition/(): source shape")
eq(a.strides,{8,-2},"float16/reverse_columns/condition/(): source strides")
cases=cases+1
end
-- 166: float16/reverse_rows/condition/(2, 3); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16")
local a=np.flip(base,1)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float16/reverse_rows/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{8.0,10.0,4.0},"float16/reverse_rows/condition/(2, 3): result")
eq(result.shape,{3},"float16/reverse_rows/condition/(2, 3): result: shape")
eq(result.strides,{2},"float16/reverse_rows/condition/(2, 3): result: strides")
eq(result.dtype,"float16","float16/reverse_rows/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16/reverse_rows/condition/(2, 3): backing source")
eq(base.shape,{3,4},"float16/reverse_rows/condition/(2, 3): backing source: shape")
eq(base.strides,{8,2},"float16/reverse_rows/condition/(2, 3): backing source: strides")
eq(base.dtype,"float16","float16/reverse_rows/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"float16/reverse_rows/condition/(2, 3): source shape")
eq(a.strides,{-8,2},"float16/reverse_rows/condition/(2, 3): source strides")
cases=cases+1
end
-- 167: float16/reverse_rows/condition/(12,); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16")
local a=np.flip(base,1)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float16/reverse_rows/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{8.0,10.0,4.0,6.0,0.0,2.0},"float16/reverse_rows/condition/(12,): result")
eq(result.shape,{6},"float16/reverse_rows/condition/(12,): result: shape")
eq(result.strides,{2},"float16/reverse_rows/condition/(12,): result: strides")
eq(result.dtype,"float16","float16/reverse_rows/condition/(12,): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16/reverse_rows/condition/(12,): backing source")
eq(base.shape,{3,4},"float16/reverse_rows/condition/(12,): backing source: shape")
eq(base.strides,{8,2},"float16/reverse_rows/condition/(12,): backing source: strides")
eq(base.dtype,"float16","float16/reverse_rows/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"float16/reverse_rows/condition/(12,): source shape")
eq(a.strides,{-8,2},"float16/reverse_rows/condition/(12,): source strides")
cases=cases+1
end
-- 168: float16/reverse_rows/condition/(14,); source error=IndexError
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16")
local a=np.flip(base,1)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"float16/reverse_rows/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16/reverse_rows/condition/(14,): backing source")
eq(base.shape,{3,4},"float16/reverse_rows/condition/(14,): backing source: shape")
eq(base.strides,{8,2},"float16/reverse_rows/condition/(14,): backing source: strides")
eq(base.dtype,"float16","float16/reverse_rows/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"float16/reverse_rows/condition/(14,): source shape")
eq(a.strides,{-8,2},"float16/reverse_rows/condition/(14,): source strides")
cases=cases+1
end
-- 169: float16/reverse_rows/condition/(0,); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16")
local a=np.flip(base,1)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float16/reverse_rows/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"float16/reverse_rows/condition/(0,): result")
eq(result.shape,{0},"float16/reverse_rows/condition/(0,): result: shape")
eq(result.strides,{0},"float16/reverse_rows/condition/(0,): result: strides")
eq(result.dtype,"float16","float16/reverse_rows/condition/(0,): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16/reverse_rows/condition/(0,): backing source")
eq(base.shape,{3,4},"float16/reverse_rows/condition/(0,): backing source: shape")
eq(base.strides,{8,2},"float16/reverse_rows/condition/(0,): backing source: strides")
eq(base.dtype,"float16","float16/reverse_rows/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"float16/reverse_rows/condition/(0,): source shape")
eq(a.strides,{-8,2},"float16/reverse_rows/condition/(0,): source strides")
cases=cases+1
end
-- 170: float16/reverse_rows/condition/(); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16")
local a=np.flip(base,1)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float16/reverse_rows/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{8.0},"float16/reverse_rows/condition/(): result")
eq(result.shape,{1},"float16/reverse_rows/condition/(): result: shape")
eq(result.strides,{2},"float16/reverse_rows/condition/(): result: strides")
eq(result.dtype,"float16","float16/reverse_rows/condition/(): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16/reverse_rows/condition/(): backing source")
eq(base.shape,{3,4},"float16/reverse_rows/condition/(): backing source: shape")
eq(base.strides,{8,2},"float16/reverse_rows/condition/(): backing source: strides")
eq(base.dtype,"float16","float16/reverse_rows/condition/(): backing source: dtype")
eq(a.shape,{3,4},"float16/reverse_rows/condition/(): source shape")
eq(a.strides,{-8,2},"float16/reverse_rows/condition/(): source strides")
cases=cases+1
end
-- 171: float16/strided/condition/(2, 3); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float16/strided/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,4.0,8.0},"float16/strided/condition/(2, 3): result")
eq(result.shape,{3},"float16/strided/condition/(2, 3): result: shape")
eq(result.strides,{2},"float16/strided/condition/(2, 3): result: strides")
eq(result.dtype,"float16","float16/strided/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16/strided/condition/(2, 3): backing source")
eq(base.shape,{3,4},"float16/strided/condition/(2, 3): backing source: shape")
eq(base.strides,{8,2},"float16/strided/condition/(2, 3): backing source: strides")
eq(base.dtype,"float16","float16/strided/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,2},"float16/strided/condition/(2, 3): source shape")
eq(a.strides,{8,4},"float16/strided/condition/(2, 3): source strides")
cases=cases+1
end
-- 172: float16/strided/condition/(12,); source error=IndexError
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"float16/strided/condition/(12,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16/strided/condition/(12,): backing source")
eq(base.shape,{3,4},"float16/strided/condition/(12,): backing source: shape")
eq(base.strides,{8,2},"float16/strided/condition/(12,): backing source: strides")
eq(base.dtype,"float16","float16/strided/condition/(12,): backing source: dtype")
eq(a.shape,{3,2},"float16/strided/condition/(12,): source shape")
eq(a.strides,{8,4},"float16/strided/condition/(12,): source strides")
cases=cases+1
end
-- 173: float16/strided/condition/(14,); source error=IndexError
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"float16/strided/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16/strided/condition/(14,): backing source")
eq(base.shape,{3,4},"float16/strided/condition/(14,): backing source: shape")
eq(base.strides,{8,2},"float16/strided/condition/(14,): backing source: strides")
eq(base.dtype,"float16","float16/strided/condition/(14,): backing source: dtype")
eq(a.shape,{3,2},"float16/strided/condition/(14,): source shape")
eq(a.strides,{8,4},"float16/strided/condition/(14,): source strides")
cases=cases+1
end
-- 174: float16/strided/condition/(0,); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float16/strided/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"float16/strided/condition/(0,): result")
eq(result.shape,{0},"float16/strided/condition/(0,): result: shape")
eq(result.strides,{0},"float16/strided/condition/(0,): result: strides")
eq(result.dtype,"float16","float16/strided/condition/(0,): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16/strided/condition/(0,): backing source")
eq(base.shape,{3,4},"float16/strided/condition/(0,): backing source: shape")
eq(base.strides,{8,2},"float16/strided/condition/(0,): backing source: strides")
eq(base.dtype,"float16","float16/strided/condition/(0,): backing source: dtype")
eq(a.shape,{3,2},"float16/strided/condition/(0,): source shape")
eq(a.strides,{8,4},"float16/strided/condition/(0,): source strides")
cases=cases+1
end
-- 175: float16/strided/condition/(); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float16/strided/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"float16/strided/condition/(): result")
eq(result.shape,{1},"float16/strided/condition/(): result: shape")
eq(result.strides,{2},"float16/strided/condition/(): result: strides")
eq(result.dtype,"float16","float16/strided/condition/(): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16/strided/condition/(): backing source")
eq(base.shape,{3,4},"float16/strided/condition/(): backing source: shape")
eq(base.strides,{8,2},"float16/strided/condition/(): backing source: strides")
eq(base.dtype,"float16","float16/strided/condition/(): backing source: dtype")
eq(a.shape,{3,2},"float16/strided/condition/(): source shape")
eq(a.strides,{8,4},"float16/strided/condition/(): source strides")
cases=cases+1
end
-- 176: float32/plain/condition/(2, 3); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32")
local a=base
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float32/plain/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,2.0,4.0},"float32/plain/condition/(2, 3): result")
eq(result.shape,{3},"float32/plain/condition/(2, 3): result: shape")
eq(result.strides,{4},"float32/plain/condition/(2, 3): result: strides")
eq(result.dtype,"float32","float32/plain/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32/plain/condition/(2, 3): backing source")
eq(base.shape,{3,4},"float32/plain/condition/(2, 3): backing source: shape")
eq(base.strides,{16,4},"float32/plain/condition/(2, 3): backing source: strides")
eq(base.dtype,"float32","float32/plain/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"float32/plain/condition/(2, 3): source shape")
eq(a.strides,{16,4},"float32/plain/condition/(2, 3): source strides")
cases=cases+1
end
-- 177: float32/plain/condition/(12,); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32")
local a=base
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float32/plain/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,2.0,4.0,6.0,8.0,10.0},"float32/plain/condition/(12,): result")
eq(result.shape,{6},"float32/plain/condition/(12,): result: shape")
eq(result.strides,{4},"float32/plain/condition/(12,): result: strides")
eq(result.dtype,"float32","float32/plain/condition/(12,): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32/plain/condition/(12,): backing source")
eq(base.shape,{3,4},"float32/plain/condition/(12,): backing source: shape")
eq(base.strides,{16,4},"float32/plain/condition/(12,): backing source: strides")
eq(base.dtype,"float32","float32/plain/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"float32/plain/condition/(12,): source shape")
eq(a.strides,{16,4},"float32/plain/condition/(12,): source strides")
cases=cases+1
end
-- 178: float32/plain/condition/(14,); source error=IndexError
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32")
local a=base
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"float32/plain/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32/plain/condition/(14,): backing source")
eq(base.shape,{3,4},"float32/plain/condition/(14,): backing source: shape")
eq(base.strides,{16,4},"float32/plain/condition/(14,): backing source: strides")
eq(base.dtype,"float32","float32/plain/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"float32/plain/condition/(14,): source shape")
eq(a.strides,{16,4},"float32/plain/condition/(14,): source strides")
cases=cases+1
end
-- 179: float32/plain/condition/(0,); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float32/plain/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"float32/plain/condition/(0,): result")
eq(result.shape,{0},"float32/plain/condition/(0,): result: shape")
eq(result.strides,{0},"float32/plain/condition/(0,): result: strides")
eq(result.dtype,"float32","float32/plain/condition/(0,): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32/plain/condition/(0,): backing source")
eq(base.shape,{3,4},"float32/plain/condition/(0,): backing source: shape")
eq(base.strides,{16,4},"float32/plain/condition/(0,): backing source: strides")
eq(base.dtype,"float32","float32/plain/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"float32/plain/condition/(0,): source shape")
eq(a.strides,{16,4},"float32/plain/condition/(0,): source strides")
cases=cases+1
end
-- 180: float32/plain/condition/(); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float32/plain/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"float32/plain/condition/(): result")
eq(result.shape,{1},"float32/plain/condition/(): result: shape")
eq(result.strides,{4},"float32/plain/condition/(): result: strides")
eq(result.dtype,"float32","float32/plain/condition/(): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32/plain/condition/(): backing source")
eq(base.shape,{3,4},"float32/plain/condition/(): backing source: shape")
eq(base.strides,{16,4},"float32/plain/condition/(): backing source: strides")
eq(base.dtype,"float32","float32/plain/condition/(): backing source: dtype")
eq(a.shape,{3,4},"float32/plain/condition/(): source shape")
eq(a.strides,{16,4},"float32/plain/condition/(): source strides")
cases=cases+1
end
-- 181: float32/transpose/condition/(2, 3); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32")
local a=np.transpose(base)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float32/transpose/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,8.0,5.0},"float32/transpose/condition/(2, 3): result")
eq(result.shape,{3},"float32/transpose/condition/(2, 3): result: shape")
eq(result.strides,{4},"float32/transpose/condition/(2, 3): result: strides")
eq(result.dtype,"float32","float32/transpose/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32/transpose/condition/(2, 3): backing source")
eq(base.shape,{3,4},"float32/transpose/condition/(2, 3): backing source: shape")
eq(base.strides,{16,4},"float32/transpose/condition/(2, 3): backing source: strides")
eq(base.dtype,"float32","float32/transpose/condition/(2, 3): backing source: dtype")
eq(a.shape,{4,3},"float32/transpose/condition/(2, 3): source shape")
eq(a.strides,{4,16},"float32/transpose/condition/(2, 3): source strides")
cases=cases+1
end
-- 182: float32/transpose/condition/(12,); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32")
local a=np.transpose(base)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float32/transpose/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,8.0,5.0,2.0,10.0,7.0},"float32/transpose/condition/(12,): result")
eq(result.shape,{6},"float32/transpose/condition/(12,): result: shape")
eq(result.strides,{4},"float32/transpose/condition/(12,): result: strides")
eq(result.dtype,"float32","float32/transpose/condition/(12,): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32/transpose/condition/(12,): backing source")
eq(base.shape,{3,4},"float32/transpose/condition/(12,): backing source: shape")
eq(base.strides,{16,4},"float32/transpose/condition/(12,): backing source: strides")
eq(base.dtype,"float32","float32/transpose/condition/(12,): backing source: dtype")
eq(a.shape,{4,3},"float32/transpose/condition/(12,): source shape")
eq(a.strides,{4,16},"float32/transpose/condition/(12,): source strides")
cases=cases+1
end
-- 183: float32/transpose/condition/(14,); source error=IndexError
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32")
local a=np.transpose(base)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"float32/transpose/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32/transpose/condition/(14,): backing source")
eq(base.shape,{3,4},"float32/transpose/condition/(14,): backing source: shape")
eq(base.strides,{16,4},"float32/transpose/condition/(14,): backing source: strides")
eq(base.dtype,"float32","float32/transpose/condition/(14,): backing source: dtype")
eq(a.shape,{4,3},"float32/transpose/condition/(14,): source shape")
eq(a.strides,{4,16},"float32/transpose/condition/(14,): source strides")
cases=cases+1
end
-- 184: float32/transpose/condition/(0,); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32")
local a=np.transpose(base)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float32/transpose/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"float32/transpose/condition/(0,): result")
eq(result.shape,{0},"float32/transpose/condition/(0,): result: shape")
eq(result.strides,{0},"float32/transpose/condition/(0,): result: strides")
eq(result.dtype,"float32","float32/transpose/condition/(0,): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32/transpose/condition/(0,): backing source")
eq(base.shape,{3,4},"float32/transpose/condition/(0,): backing source: shape")
eq(base.strides,{16,4},"float32/transpose/condition/(0,): backing source: strides")
eq(base.dtype,"float32","float32/transpose/condition/(0,): backing source: dtype")
eq(a.shape,{4,3},"float32/transpose/condition/(0,): source shape")
eq(a.strides,{4,16},"float32/transpose/condition/(0,): source strides")
cases=cases+1
end
-- 185: float32/transpose/condition/(); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32")
local a=np.transpose(base)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float32/transpose/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"float32/transpose/condition/(): result")
eq(result.shape,{1},"float32/transpose/condition/(): result: shape")
eq(result.strides,{4},"float32/transpose/condition/(): result: strides")
eq(result.dtype,"float32","float32/transpose/condition/(): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32/transpose/condition/(): backing source")
eq(base.shape,{3,4},"float32/transpose/condition/(): backing source: shape")
eq(base.strides,{16,4},"float32/transpose/condition/(): backing source: strides")
eq(base.dtype,"float32","float32/transpose/condition/(): backing source: dtype")
eq(a.shape,{4,3},"float32/transpose/condition/(): source shape")
eq(a.strides,{4,16},"float32/transpose/condition/(): source strides")
cases=cases+1
end
-- 186: float32/reverse_columns/condition/(2, 3); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32")
local a=np.flip(base,2)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float32/reverse_columns/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{3.0,1.0,7.0},"float32/reverse_columns/condition/(2, 3): result")
eq(result.shape,{3},"float32/reverse_columns/condition/(2, 3): result: shape")
eq(result.strides,{4},"float32/reverse_columns/condition/(2, 3): result: strides")
eq(result.dtype,"float32","float32/reverse_columns/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32/reverse_columns/condition/(2, 3): backing source")
eq(base.shape,{3,4},"float32/reverse_columns/condition/(2, 3): backing source: shape")
eq(base.strides,{16,4},"float32/reverse_columns/condition/(2, 3): backing source: strides")
eq(base.dtype,"float32","float32/reverse_columns/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"float32/reverse_columns/condition/(2, 3): source shape")
eq(a.strides,{16,-4},"float32/reverse_columns/condition/(2, 3): source strides")
cases=cases+1
end
-- 187: float32/reverse_columns/condition/(12,); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32")
local a=np.flip(base,2)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float32/reverse_columns/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{3.0,1.0,7.0,5.0,11.0,9.0},"float32/reverse_columns/condition/(12,): result")
eq(result.shape,{6},"float32/reverse_columns/condition/(12,): result: shape")
eq(result.strides,{4},"float32/reverse_columns/condition/(12,): result: strides")
eq(result.dtype,"float32","float32/reverse_columns/condition/(12,): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32/reverse_columns/condition/(12,): backing source")
eq(base.shape,{3,4},"float32/reverse_columns/condition/(12,): backing source: shape")
eq(base.strides,{16,4},"float32/reverse_columns/condition/(12,): backing source: strides")
eq(base.dtype,"float32","float32/reverse_columns/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"float32/reverse_columns/condition/(12,): source shape")
eq(a.strides,{16,-4},"float32/reverse_columns/condition/(12,): source strides")
cases=cases+1
end
-- 188: float32/reverse_columns/condition/(14,); source error=IndexError
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32")
local a=np.flip(base,2)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"float32/reverse_columns/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32/reverse_columns/condition/(14,): backing source")
eq(base.shape,{3,4},"float32/reverse_columns/condition/(14,): backing source: shape")
eq(base.strides,{16,4},"float32/reverse_columns/condition/(14,): backing source: strides")
eq(base.dtype,"float32","float32/reverse_columns/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"float32/reverse_columns/condition/(14,): source shape")
eq(a.strides,{16,-4},"float32/reverse_columns/condition/(14,): source strides")
cases=cases+1
end
-- 189: float32/reverse_columns/condition/(0,); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32")
local a=np.flip(base,2)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float32/reverse_columns/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"float32/reverse_columns/condition/(0,): result")
eq(result.shape,{0},"float32/reverse_columns/condition/(0,): result: shape")
eq(result.strides,{0},"float32/reverse_columns/condition/(0,): result: strides")
eq(result.dtype,"float32","float32/reverse_columns/condition/(0,): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32/reverse_columns/condition/(0,): backing source")
eq(base.shape,{3,4},"float32/reverse_columns/condition/(0,): backing source: shape")
eq(base.strides,{16,4},"float32/reverse_columns/condition/(0,): backing source: strides")
eq(base.dtype,"float32","float32/reverse_columns/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"float32/reverse_columns/condition/(0,): source shape")
eq(a.strides,{16,-4},"float32/reverse_columns/condition/(0,): source strides")
cases=cases+1
end
-- 190: float32/reverse_columns/condition/(); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32")
local a=np.flip(base,2)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float32/reverse_columns/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{3.0},"float32/reverse_columns/condition/(): result")
eq(result.shape,{1},"float32/reverse_columns/condition/(): result: shape")
eq(result.strides,{4},"float32/reverse_columns/condition/(): result: strides")
eq(result.dtype,"float32","float32/reverse_columns/condition/(): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32/reverse_columns/condition/(): backing source")
eq(base.shape,{3,4},"float32/reverse_columns/condition/(): backing source: shape")
eq(base.strides,{16,4},"float32/reverse_columns/condition/(): backing source: strides")
eq(base.dtype,"float32","float32/reverse_columns/condition/(): backing source: dtype")
eq(a.shape,{3,4},"float32/reverse_columns/condition/(): source shape")
eq(a.strides,{16,-4},"float32/reverse_columns/condition/(): source strides")
cases=cases+1
end
-- 191: float32/reverse_rows/condition/(2, 3); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32")
local a=np.flip(base,1)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float32/reverse_rows/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{8.0,10.0,4.0},"float32/reverse_rows/condition/(2, 3): result")
eq(result.shape,{3},"float32/reverse_rows/condition/(2, 3): result: shape")
eq(result.strides,{4},"float32/reverse_rows/condition/(2, 3): result: strides")
eq(result.dtype,"float32","float32/reverse_rows/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32/reverse_rows/condition/(2, 3): backing source")
eq(base.shape,{3,4},"float32/reverse_rows/condition/(2, 3): backing source: shape")
eq(base.strides,{16,4},"float32/reverse_rows/condition/(2, 3): backing source: strides")
eq(base.dtype,"float32","float32/reverse_rows/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"float32/reverse_rows/condition/(2, 3): source shape")
eq(a.strides,{-16,4},"float32/reverse_rows/condition/(2, 3): source strides")
cases=cases+1
end
-- 192: float32/reverse_rows/condition/(12,); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32")
local a=np.flip(base,1)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float32/reverse_rows/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{8.0,10.0,4.0,6.0,0.0,2.0},"float32/reverse_rows/condition/(12,): result")
eq(result.shape,{6},"float32/reverse_rows/condition/(12,): result: shape")
eq(result.strides,{4},"float32/reverse_rows/condition/(12,): result: strides")
eq(result.dtype,"float32","float32/reverse_rows/condition/(12,): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32/reverse_rows/condition/(12,): backing source")
eq(base.shape,{3,4},"float32/reverse_rows/condition/(12,): backing source: shape")
eq(base.strides,{16,4},"float32/reverse_rows/condition/(12,): backing source: strides")
eq(base.dtype,"float32","float32/reverse_rows/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"float32/reverse_rows/condition/(12,): source shape")
eq(a.strides,{-16,4},"float32/reverse_rows/condition/(12,): source strides")
cases=cases+1
end
-- 193: float32/reverse_rows/condition/(14,); source error=IndexError
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32")
local a=np.flip(base,1)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"float32/reverse_rows/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32/reverse_rows/condition/(14,): backing source")
eq(base.shape,{3,4},"float32/reverse_rows/condition/(14,): backing source: shape")
eq(base.strides,{16,4},"float32/reverse_rows/condition/(14,): backing source: strides")
eq(base.dtype,"float32","float32/reverse_rows/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"float32/reverse_rows/condition/(14,): source shape")
eq(a.strides,{-16,4},"float32/reverse_rows/condition/(14,): source strides")
cases=cases+1
end
-- 194: float32/reverse_rows/condition/(0,); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32")
local a=np.flip(base,1)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float32/reverse_rows/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"float32/reverse_rows/condition/(0,): result")
eq(result.shape,{0},"float32/reverse_rows/condition/(0,): result: shape")
eq(result.strides,{0},"float32/reverse_rows/condition/(0,): result: strides")
eq(result.dtype,"float32","float32/reverse_rows/condition/(0,): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32/reverse_rows/condition/(0,): backing source")
eq(base.shape,{3,4},"float32/reverse_rows/condition/(0,): backing source: shape")
eq(base.strides,{16,4},"float32/reverse_rows/condition/(0,): backing source: strides")
eq(base.dtype,"float32","float32/reverse_rows/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"float32/reverse_rows/condition/(0,): source shape")
eq(a.strides,{-16,4},"float32/reverse_rows/condition/(0,): source strides")
cases=cases+1
end
-- 195: float32/reverse_rows/condition/(); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32")
local a=np.flip(base,1)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float32/reverse_rows/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{8.0},"float32/reverse_rows/condition/(): result")
eq(result.shape,{1},"float32/reverse_rows/condition/(): result: shape")
eq(result.strides,{4},"float32/reverse_rows/condition/(): result: strides")
eq(result.dtype,"float32","float32/reverse_rows/condition/(): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32/reverse_rows/condition/(): backing source")
eq(base.shape,{3,4},"float32/reverse_rows/condition/(): backing source: shape")
eq(base.strides,{16,4},"float32/reverse_rows/condition/(): backing source: strides")
eq(base.dtype,"float32","float32/reverse_rows/condition/(): backing source: dtype")
eq(a.shape,{3,4},"float32/reverse_rows/condition/(): source shape")
eq(a.strides,{-16,4},"float32/reverse_rows/condition/(): source strides")
cases=cases+1
end
-- 196: float32/strided/condition/(2, 3); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float32/strided/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,4.0,8.0},"float32/strided/condition/(2, 3): result")
eq(result.shape,{3},"float32/strided/condition/(2, 3): result: shape")
eq(result.strides,{4},"float32/strided/condition/(2, 3): result: strides")
eq(result.dtype,"float32","float32/strided/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32/strided/condition/(2, 3): backing source")
eq(base.shape,{3,4},"float32/strided/condition/(2, 3): backing source: shape")
eq(base.strides,{16,4},"float32/strided/condition/(2, 3): backing source: strides")
eq(base.dtype,"float32","float32/strided/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,2},"float32/strided/condition/(2, 3): source shape")
eq(a.strides,{16,8},"float32/strided/condition/(2, 3): source strides")
cases=cases+1
end
-- 197: float32/strided/condition/(12,); source error=IndexError
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"float32/strided/condition/(12,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32/strided/condition/(12,): backing source")
eq(base.shape,{3,4},"float32/strided/condition/(12,): backing source: shape")
eq(base.strides,{16,4},"float32/strided/condition/(12,): backing source: strides")
eq(base.dtype,"float32","float32/strided/condition/(12,): backing source: dtype")
eq(a.shape,{3,2},"float32/strided/condition/(12,): source shape")
eq(a.strides,{16,8},"float32/strided/condition/(12,): source strides")
cases=cases+1
end
-- 198: float32/strided/condition/(14,); source error=IndexError
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"float32/strided/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32/strided/condition/(14,): backing source")
eq(base.shape,{3,4},"float32/strided/condition/(14,): backing source: shape")
eq(base.strides,{16,4},"float32/strided/condition/(14,): backing source: strides")
eq(base.dtype,"float32","float32/strided/condition/(14,): backing source: dtype")
eq(a.shape,{3,2},"float32/strided/condition/(14,): source shape")
eq(a.strides,{16,8},"float32/strided/condition/(14,): source strides")
cases=cases+1
end
-- 199: float32/strided/condition/(0,); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float32/strided/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"float32/strided/condition/(0,): result")
eq(result.shape,{0},"float32/strided/condition/(0,): result: shape")
eq(result.strides,{0},"float32/strided/condition/(0,): result: strides")
eq(result.dtype,"float32","float32/strided/condition/(0,): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32/strided/condition/(0,): backing source")
eq(base.shape,{3,4},"float32/strided/condition/(0,): backing source: shape")
eq(base.strides,{16,4},"float32/strided/condition/(0,): backing source: strides")
eq(base.dtype,"float32","float32/strided/condition/(0,): backing source: dtype")
eq(a.shape,{3,2},"float32/strided/condition/(0,): source shape")
eq(a.strides,{16,8},"float32/strided/condition/(0,): source strides")
cases=cases+1
end
-- 200: float32/strided/condition/(); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float32/strided/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"float32/strided/condition/(): result")
eq(result.shape,{1},"float32/strided/condition/(): result: shape")
eq(result.strides,{4},"float32/strided/condition/(): result: strides")
eq(result.dtype,"float32","float32/strided/condition/(): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32/strided/condition/(): backing source")
eq(base.shape,{3,4},"float32/strided/condition/(): backing source: shape")
eq(base.strides,{16,4},"float32/strided/condition/(): backing source: strides")
eq(base.dtype,"float32","float32/strided/condition/(): backing source: dtype")
eq(a.shape,{3,2},"float32/strided/condition/(): source shape")
eq(a.strides,{16,8},"float32/strided/condition/(): source strides")
cases=cases+1
end
-- 201: float64/plain/condition/(2, 3); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64")
local a=base
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float64/plain/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,2.0,4.0},"float64/plain/condition/(2, 3): result")
eq(result.shape,{3},"float64/plain/condition/(2, 3): result: shape")
eq(result.strides,{8},"float64/plain/condition/(2, 3): result: strides")
eq(result.dtype,"float64","float64/plain/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64/plain/condition/(2, 3): backing source")
eq(base.shape,{3,4},"float64/plain/condition/(2, 3): backing source: shape")
eq(base.strides,{32,8},"float64/plain/condition/(2, 3): backing source: strides")
eq(base.dtype,"float64","float64/plain/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"float64/plain/condition/(2, 3): source shape")
eq(a.strides,{32,8},"float64/plain/condition/(2, 3): source strides")
cases=cases+1
end
-- 202: float64/plain/condition/(12,); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64")
local a=base
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float64/plain/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,2.0,4.0,6.0,8.0,10.0},"float64/plain/condition/(12,): result")
eq(result.shape,{6},"float64/plain/condition/(12,): result: shape")
eq(result.strides,{8},"float64/plain/condition/(12,): result: strides")
eq(result.dtype,"float64","float64/plain/condition/(12,): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64/plain/condition/(12,): backing source")
eq(base.shape,{3,4},"float64/plain/condition/(12,): backing source: shape")
eq(base.strides,{32,8},"float64/plain/condition/(12,): backing source: strides")
eq(base.dtype,"float64","float64/plain/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"float64/plain/condition/(12,): source shape")
eq(a.strides,{32,8},"float64/plain/condition/(12,): source strides")
cases=cases+1
end
-- 203: float64/plain/condition/(14,); source error=IndexError
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64")
local a=base
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"float64/plain/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64/plain/condition/(14,): backing source")
eq(base.shape,{3,4},"float64/plain/condition/(14,): backing source: shape")
eq(base.strides,{32,8},"float64/plain/condition/(14,): backing source: strides")
eq(base.dtype,"float64","float64/plain/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"float64/plain/condition/(14,): source shape")
eq(a.strides,{32,8},"float64/plain/condition/(14,): source strides")
cases=cases+1
end
-- 204: float64/plain/condition/(0,); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float64/plain/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"float64/plain/condition/(0,): result")
eq(result.shape,{0},"float64/plain/condition/(0,): result: shape")
eq(result.strides,{0},"float64/plain/condition/(0,): result: strides")
eq(result.dtype,"float64","float64/plain/condition/(0,): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64/plain/condition/(0,): backing source")
eq(base.shape,{3,4},"float64/plain/condition/(0,): backing source: shape")
eq(base.strides,{32,8},"float64/plain/condition/(0,): backing source: strides")
eq(base.dtype,"float64","float64/plain/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"float64/plain/condition/(0,): source shape")
eq(a.strides,{32,8},"float64/plain/condition/(0,): source strides")
cases=cases+1
end
-- 205: float64/plain/condition/(); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float64/plain/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"float64/plain/condition/(): result")
eq(result.shape,{1},"float64/plain/condition/(): result: shape")
eq(result.strides,{8},"float64/plain/condition/(): result: strides")
eq(result.dtype,"float64","float64/plain/condition/(): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64/plain/condition/(): backing source")
eq(base.shape,{3,4},"float64/plain/condition/(): backing source: shape")
eq(base.strides,{32,8},"float64/plain/condition/(): backing source: strides")
eq(base.dtype,"float64","float64/plain/condition/(): backing source: dtype")
eq(a.shape,{3,4},"float64/plain/condition/(): source shape")
eq(a.strides,{32,8},"float64/plain/condition/(): source strides")
cases=cases+1
end
-- 206: float64/transpose/condition/(2, 3); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64")
local a=np.transpose(base)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float64/transpose/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,8.0,5.0},"float64/transpose/condition/(2, 3): result")
eq(result.shape,{3},"float64/transpose/condition/(2, 3): result: shape")
eq(result.strides,{8},"float64/transpose/condition/(2, 3): result: strides")
eq(result.dtype,"float64","float64/transpose/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64/transpose/condition/(2, 3): backing source")
eq(base.shape,{3,4},"float64/transpose/condition/(2, 3): backing source: shape")
eq(base.strides,{32,8},"float64/transpose/condition/(2, 3): backing source: strides")
eq(base.dtype,"float64","float64/transpose/condition/(2, 3): backing source: dtype")
eq(a.shape,{4,3},"float64/transpose/condition/(2, 3): source shape")
eq(a.strides,{8,32},"float64/transpose/condition/(2, 3): source strides")
cases=cases+1
end
-- 207: float64/transpose/condition/(12,); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64")
local a=np.transpose(base)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float64/transpose/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,8.0,5.0,2.0,10.0,7.0},"float64/transpose/condition/(12,): result")
eq(result.shape,{6},"float64/transpose/condition/(12,): result: shape")
eq(result.strides,{8},"float64/transpose/condition/(12,): result: strides")
eq(result.dtype,"float64","float64/transpose/condition/(12,): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64/transpose/condition/(12,): backing source")
eq(base.shape,{3,4},"float64/transpose/condition/(12,): backing source: shape")
eq(base.strides,{32,8},"float64/transpose/condition/(12,): backing source: strides")
eq(base.dtype,"float64","float64/transpose/condition/(12,): backing source: dtype")
eq(a.shape,{4,3},"float64/transpose/condition/(12,): source shape")
eq(a.strides,{8,32},"float64/transpose/condition/(12,): source strides")
cases=cases+1
end
-- 208: float64/transpose/condition/(14,); source error=IndexError
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64")
local a=np.transpose(base)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"float64/transpose/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64/transpose/condition/(14,): backing source")
eq(base.shape,{3,4},"float64/transpose/condition/(14,): backing source: shape")
eq(base.strides,{32,8},"float64/transpose/condition/(14,): backing source: strides")
eq(base.dtype,"float64","float64/transpose/condition/(14,): backing source: dtype")
eq(a.shape,{4,3},"float64/transpose/condition/(14,): source shape")
eq(a.strides,{8,32},"float64/transpose/condition/(14,): source strides")
cases=cases+1
end
-- 209: float64/transpose/condition/(0,); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64")
local a=np.transpose(base)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float64/transpose/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"float64/transpose/condition/(0,): result")
eq(result.shape,{0},"float64/transpose/condition/(0,): result: shape")
eq(result.strides,{0},"float64/transpose/condition/(0,): result: strides")
eq(result.dtype,"float64","float64/transpose/condition/(0,): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64/transpose/condition/(0,): backing source")
eq(base.shape,{3,4},"float64/transpose/condition/(0,): backing source: shape")
eq(base.strides,{32,8},"float64/transpose/condition/(0,): backing source: strides")
eq(base.dtype,"float64","float64/transpose/condition/(0,): backing source: dtype")
eq(a.shape,{4,3},"float64/transpose/condition/(0,): source shape")
eq(a.strides,{8,32},"float64/transpose/condition/(0,): source strides")
cases=cases+1
end
-- 210: float64/transpose/condition/(); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64")
local a=np.transpose(base)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float64/transpose/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"float64/transpose/condition/(): result")
eq(result.shape,{1},"float64/transpose/condition/(): result: shape")
eq(result.strides,{8},"float64/transpose/condition/(): result: strides")
eq(result.dtype,"float64","float64/transpose/condition/(): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64/transpose/condition/(): backing source")
eq(base.shape,{3,4},"float64/transpose/condition/(): backing source: shape")
eq(base.strides,{32,8},"float64/transpose/condition/(): backing source: strides")
eq(base.dtype,"float64","float64/transpose/condition/(): backing source: dtype")
eq(a.shape,{4,3},"float64/transpose/condition/(): source shape")
eq(a.strides,{8,32},"float64/transpose/condition/(): source strides")
cases=cases+1
end
-- 211: float64/reverse_columns/condition/(2, 3); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64")
local a=np.flip(base,2)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float64/reverse_columns/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{3.0,1.0,7.0},"float64/reverse_columns/condition/(2, 3): result")
eq(result.shape,{3},"float64/reverse_columns/condition/(2, 3): result: shape")
eq(result.strides,{8},"float64/reverse_columns/condition/(2, 3): result: strides")
eq(result.dtype,"float64","float64/reverse_columns/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64/reverse_columns/condition/(2, 3): backing source")
eq(base.shape,{3,4},"float64/reverse_columns/condition/(2, 3): backing source: shape")
eq(base.strides,{32,8},"float64/reverse_columns/condition/(2, 3): backing source: strides")
eq(base.dtype,"float64","float64/reverse_columns/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"float64/reverse_columns/condition/(2, 3): source shape")
eq(a.strides,{32,-8},"float64/reverse_columns/condition/(2, 3): source strides")
cases=cases+1
end
-- 212: float64/reverse_columns/condition/(12,); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64")
local a=np.flip(base,2)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float64/reverse_columns/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{3.0,1.0,7.0,5.0,11.0,9.0},"float64/reverse_columns/condition/(12,): result")
eq(result.shape,{6},"float64/reverse_columns/condition/(12,): result: shape")
eq(result.strides,{8},"float64/reverse_columns/condition/(12,): result: strides")
eq(result.dtype,"float64","float64/reverse_columns/condition/(12,): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64/reverse_columns/condition/(12,): backing source")
eq(base.shape,{3,4},"float64/reverse_columns/condition/(12,): backing source: shape")
eq(base.strides,{32,8},"float64/reverse_columns/condition/(12,): backing source: strides")
eq(base.dtype,"float64","float64/reverse_columns/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"float64/reverse_columns/condition/(12,): source shape")
eq(a.strides,{32,-8},"float64/reverse_columns/condition/(12,): source strides")
cases=cases+1
end
-- 213: float64/reverse_columns/condition/(14,); source error=IndexError
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64")
local a=np.flip(base,2)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"float64/reverse_columns/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64/reverse_columns/condition/(14,): backing source")
eq(base.shape,{3,4},"float64/reverse_columns/condition/(14,): backing source: shape")
eq(base.strides,{32,8},"float64/reverse_columns/condition/(14,): backing source: strides")
eq(base.dtype,"float64","float64/reverse_columns/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"float64/reverse_columns/condition/(14,): source shape")
eq(a.strides,{32,-8},"float64/reverse_columns/condition/(14,): source strides")
cases=cases+1
end
-- 214: float64/reverse_columns/condition/(0,); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64")
local a=np.flip(base,2)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float64/reverse_columns/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"float64/reverse_columns/condition/(0,): result")
eq(result.shape,{0},"float64/reverse_columns/condition/(0,): result: shape")
eq(result.strides,{0},"float64/reverse_columns/condition/(0,): result: strides")
eq(result.dtype,"float64","float64/reverse_columns/condition/(0,): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64/reverse_columns/condition/(0,): backing source")
eq(base.shape,{3,4},"float64/reverse_columns/condition/(0,): backing source: shape")
eq(base.strides,{32,8},"float64/reverse_columns/condition/(0,): backing source: strides")
eq(base.dtype,"float64","float64/reverse_columns/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"float64/reverse_columns/condition/(0,): source shape")
eq(a.strides,{32,-8},"float64/reverse_columns/condition/(0,): source strides")
cases=cases+1
end
-- 215: float64/reverse_columns/condition/(); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64")
local a=np.flip(base,2)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float64/reverse_columns/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{3.0},"float64/reverse_columns/condition/(): result")
eq(result.shape,{1},"float64/reverse_columns/condition/(): result: shape")
eq(result.strides,{8},"float64/reverse_columns/condition/(): result: strides")
eq(result.dtype,"float64","float64/reverse_columns/condition/(): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64/reverse_columns/condition/(): backing source")
eq(base.shape,{3,4},"float64/reverse_columns/condition/(): backing source: shape")
eq(base.strides,{32,8},"float64/reverse_columns/condition/(): backing source: strides")
eq(base.dtype,"float64","float64/reverse_columns/condition/(): backing source: dtype")
eq(a.shape,{3,4},"float64/reverse_columns/condition/(): source shape")
eq(a.strides,{32,-8},"float64/reverse_columns/condition/(): source strides")
cases=cases+1
end
-- 216: float64/reverse_rows/condition/(2, 3); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64")
local a=np.flip(base,1)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float64/reverse_rows/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{8.0,10.0,4.0},"float64/reverse_rows/condition/(2, 3): result")
eq(result.shape,{3},"float64/reverse_rows/condition/(2, 3): result: shape")
eq(result.strides,{8},"float64/reverse_rows/condition/(2, 3): result: strides")
eq(result.dtype,"float64","float64/reverse_rows/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64/reverse_rows/condition/(2, 3): backing source")
eq(base.shape,{3,4},"float64/reverse_rows/condition/(2, 3): backing source: shape")
eq(base.strides,{32,8},"float64/reverse_rows/condition/(2, 3): backing source: strides")
eq(base.dtype,"float64","float64/reverse_rows/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"float64/reverse_rows/condition/(2, 3): source shape")
eq(a.strides,{-32,8},"float64/reverse_rows/condition/(2, 3): source strides")
cases=cases+1
end
-- 217: float64/reverse_rows/condition/(12,); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64")
local a=np.flip(base,1)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float64/reverse_rows/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{8.0,10.0,4.0,6.0,0.0,2.0},"float64/reverse_rows/condition/(12,): result")
eq(result.shape,{6},"float64/reverse_rows/condition/(12,): result: shape")
eq(result.strides,{8},"float64/reverse_rows/condition/(12,): result: strides")
eq(result.dtype,"float64","float64/reverse_rows/condition/(12,): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64/reverse_rows/condition/(12,): backing source")
eq(base.shape,{3,4},"float64/reverse_rows/condition/(12,): backing source: shape")
eq(base.strides,{32,8},"float64/reverse_rows/condition/(12,): backing source: strides")
eq(base.dtype,"float64","float64/reverse_rows/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"float64/reverse_rows/condition/(12,): source shape")
eq(a.strides,{-32,8},"float64/reverse_rows/condition/(12,): source strides")
cases=cases+1
end
-- 218: float64/reverse_rows/condition/(14,); source error=IndexError
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64")
local a=np.flip(base,1)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"float64/reverse_rows/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64/reverse_rows/condition/(14,): backing source")
eq(base.shape,{3,4},"float64/reverse_rows/condition/(14,): backing source: shape")
eq(base.strides,{32,8},"float64/reverse_rows/condition/(14,): backing source: strides")
eq(base.dtype,"float64","float64/reverse_rows/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"float64/reverse_rows/condition/(14,): source shape")
eq(a.strides,{-32,8},"float64/reverse_rows/condition/(14,): source strides")
cases=cases+1
end
-- 219: float64/reverse_rows/condition/(0,); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64")
local a=np.flip(base,1)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float64/reverse_rows/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"float64/reverse_rows/condition/(0,): result")
eq(result.shape,{0},"float64/reverse_rows/condition/(0,): result: shape")
eq(result.strides,{0},"float64/reverse_rows/condition/(0,): result: strides")
eq(result.dtype,"float64","float64/reverse_rows/condition/(0,): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64/reverse_rows/condition/(0,): backing source")
eq(base.shape,{3,4},"float64/reverse_rows/condition/(0,): backing source: shape")
eq(base.strides,{32,8},"float64/reverse_rows/condition/(0,): backing source: strides")
eq(base.dtype,"float64","float64/reverse_rows/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"float64/reverse_rows/condition/(0,): source shape")
eq(a.strides,{-32,8},"float64/reverse_rows/condition/(0,): source strides")
cases=cases+1
end
-- 220: float64/reverse_rows/condition/(); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64")
local a=np.flip(base,1)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float64/reverse_rows/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{8.0},"float64/reverse_rows/condition/(): result")
eq(result.shape,{1},"float64/reverse_rows/condition/(): result: shape")
eq(result.strides,{8},"float64/reverse_rows/condition/(): result: strides")
eq(result.dtype,"float64","float64/reverse_rows/condition/(): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64/reverse_rows/condition/(): backing source")
eq(base.shape,{3,4},"float64/reverse_rows/condition/(): backing source: shape")
eq(base.strides,{32,8},"float64/reverse_rows/condition/(): backing source: strides")
eq(base.dtype,"float64","float64/reverse_rows/condition/(): backing source: dtype")
eq(a.shape,{3,4},"float64/reverse_rows/condition/(): source shape")
eq(a.strides,{-32,8},"float64/reverse_rows/condition/(): source strides")
cases=cases+1
end
-- 221: float64/strided/condition/(2, 3); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float64/strided/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,4.0,8.0},"float64/strided/condition/(2, 3): result")
eq(result.shape,{3},"float64/strided/condition/(2, 3): result: shape")
eq(result.strides,{8},"float64/strided/condition/(2, 3): result: strides")
eq(result.dtype,"float64","float64/strided/condition/(2, 3): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64/strided/condition/(2, 3): backing source")
eq(base.shape,{3,4},"float64/strided/condition/(2, 3): backing source: shape")
eq(base.strides,{32,8},"float64/strided/condition/(2, 3): backing source: strides")
eq(base.dtype,"float64","float64/strided/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,2},"float64/strided/condition/(2, 3): source shape")
eq(a.strides,{32,16},"float64/strided/condition/(2, 3): source strides")
cases=cases+1
end
-- 222: float64/strided/condition/(12,); source error=IndexError
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"float64/strided/condition/(12,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64/strided/condition/(12,): backing source")
eq(base.shape,{3,4},"float64/strided/condition/(12,): backing source: shape")
eq(base.strides,{32,8},"float64/strided/condition/(12,): backing source: strides")
eq(base.dtype,"float64","float64/strided/condition/(12,): backing source: dtype")
eq(a.shape,{3,2},"float64/strided/condition/(12,): source shape")
eq(a.strides,{32,16},"float64/strided/condition/(12,): source strides")
cases=cases+1
end
-- 223: float64/strided/condition/(14,); source error=IndexError
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"float64/strided/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64/strided/condition/(14,): backing source")
eq(base.shape,{3,4},"float64/strided/condition/(14,): backing source: shape")
eq(base.strides,{32,8},"float64/strided/condition/(14,): backing source: strides")
eq(base.dtype,"float64","float64/strided/condition/(14,): backing source: dtype")
eq(a.shape,{3,2},"float64/strided/condition/(14,): source shape")
eq(a.strides,{32,16},"float64/strided/condition/(14,): source strides")
cases=cases+1
end
-- 224: float64/strided/condition/(0,); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float64/strided/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"float64/strided/condition/(0,): result")
eq(result.shape,{0},"float64/strided/condition/(0,): result: shape")
eq(result.strides,{0},"float64/strided/condition/(0,): result: strides")
eq(result.dtype,"float64","float64/strided/condition/(0,): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64/strided/condition/(0,): backing source")
eq(base.shape,{3,4},"float64/strided/condition/(0,): backing source: shape")
eq(base.strides,{32,8},"float64/strided/condition/(0,): backing source: strides")
eq(base.dtype,"float64","float64/strided/condition/(0,): backing source: dtype")
eq(a.shape,{3,2},"float64/strided/condition/(0,): source shape")
eq(a.strides,{32,16},"float64/strided/condition/(0,): source strides")
cases=cases+1
end
-- 225: float64/strided/condition/(); source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"float64/strided/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"float64/strided/condition/(): result")
eq(result.shape,{1},"float64/strided/condition/(): result: shape")
eq(result.strides,{8},"float64/strided/condition/(): result: strides")
eq(result.dtype,"float64","float64/strided/condition/(): result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64/strided/condition/(): backing source")
eq(base.shape,{3,4},"float64/strided/condition/(): backing source: shape")
eq(base.strides,{32,8},"float64/strided/condition/(): backing source: strides")
eq(base.dtype,"float64","float64/strided/condition/(): backing source: dtype")
eq(a.shape,{3,2},"float64/strided/condition/(): source shape")
eq(a.strides,{32,16},"float64/strided/condition/(): source strides")
cases=cases+1
end
-- 226: bool/plain/condition/(2, 3); source error=None
do
local base=np.array({{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool")
local a=base
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"bool/plain/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{false,false,false},"bool/plain/condition/(2, 3): result")
eq(result.shape,{3},"bool/plain/condition/(2, 3): result: shape")
eq(result.strides,{1},"bool/plain/condition/(2, 3): result: strides")
eq(result.dtype,"bool","bool/plain/condition/(2, 3): result: dtype")
eq(base:tolist(),{{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool/plain/condition/(2, 3): backing source")
eq(base.shape,{3,4},"bool/plain/condition/(2, 3): backing source: shape")
eq(base.strides,{4,1},"bool/plain/condition/(2, 3): backing source: strides")
eq(base.dtype,"bool","bool/plain/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"bool/plain/condition/(2, 3): source shape")
eq(a.strides,{4,1},"bool/plain/condition/(2, 3): source strides")
cases=cases+1
end
-- 227: bool/plain/condition/(12,); source error=None
do
local base=np.array({{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool")
local a=base
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"bool/plain/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{false,false,false,false,false,false},"bool/plain/condition/(12,): result")
eq(result.shape,{6},"bool/plain/condition/(12,): result: shape")
eq(result.strides,{1},"bool/plain/condition/(12,): result: strides")
eq(result.dtype,"bool","bool/plain/condition/(12,): result: dtype")
eq(base:tolist(),{{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool/plain/condition/(12,): backing source")
eq(base.shape,{3,4},"bool/plain/condition/(12,): backing source: shape")
eq(base.strides,{4,1},"bool/plain/condition/(12,): backing source: strides")
eq(base.dtype,"bool","bool/plain/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"bool/plain/condition/(12,): source shape")
eq(a.strides,{4,1},"bool/plain/condition/(12,): source strides")
cases=cases+1
end
-- 228: bool/plain/condition/(14,); source error=IndexError
do
local base=np.array({{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool")
local a=base
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"bool/plain/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool/plain/condition/(14,): backing source")
eq(base.shape,{3,4},"bool/plain/condition/(14,): backing source: shape")
eq(base.strides,{4,1},"bool/plain/condition/(14,): backing source: strides")
eq(base.dtype,"bool","bool/plain/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"bool/plain/condition/(14,): source shape")
eq(a.strides,{4,1},"bool/plain/condition/(14,): source strides")
cases=cases+1
end
-- 229: bool/plain/condition/(0,); source error=None
do
local base=np.array({{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"bool/plain/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"bool/plain/condition/(0,): result")
eq(result.shape,{0},"bool/plain/condition/(0,): result: shape")
eq(result.strides,{0},"bool/plain/condition/(0,): result: strides")
eq(result.dtype,"bool","bool/plain/condition/(0,): result: dtype")
eq(base:tolist(),{{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool/plain/condition/(0,): backing source")
eq(base.shape,{3,4},"bool/plain/condition/(0,): backing source: shape")
eq(base.strides,{4,1},"bool/plain/condition/(0,): backing source: strides")
eq(base.dtype,"bool","bool/plain/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"bool/plain/condition/(0,): source shape")
eq(a.strides,{4,1},"bool/plain/condition/(0,): source strides")
cases=cases+1
end
-- 230: bool/plain/condition/(); source error=None
do
local base=np.array({{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"bool/plain/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{false},"bool/plain/condition/(): result")
eq(result.shape,{1},"bool/plain/condition/(): result: shape")
eq(result.strides,{1},"bool/plain/condition/(): result: strides")
eq(result.dtype,"bool","bool/plain/condition/(): result: dtype")
eq(base:tolist(),{{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool/plain/condition/(): backing source")
eq(base.shape,{3,4},"bool/plain/condition/(): backing source: shape")
eq(base.strides,{4,1},"bool/plain/condition/(): backing source: strides")
eq(base.dtype,"bool","bool/plain/condition/(): backing source: dtype")
eq(a.shape,{3,4},"bool/plain/condition/(): source shape")
eq(a.strides,{4,1},"bool/plain/condition/(): source strides")
cases=cases+1
end
-- 231: bool/transpose/condition/(2, 3); source error=None
do
local base=np.array({{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool")
local a=np.transpose(base)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"bool/transpose/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{false,false,true},"bool/transpose/condition/(2, 3): result")
eq(result.shape,{3},"bool/transpose/condition/(2, 3): result: shape")
eq(result.strides,{1},"bool/transpose/condition/(2, 3): result: strides")
eq(result.dtype,"bool","bool/transpose/condition/(2, 3): result: dtype")
eq(base:tolist(),{{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool/transpose/condition/(2, 3): backing source")
eq(base.shape,{3,4},"bool/transpose/condition/(2, 3): backing source: shape")
eq(base.strides,{4,1},"bool/transpose/condition/(2, 3): backing source: strides")
eq(base.dtype,"bool","bool/transpose/condition/(2, 3): backing source: dtype")
eq(a.shape,{4,3},"bool/transpose/condition/(2, 3): source shape")
eq(a.strides,{1,4},"bool/transpose/condition/(2, 3): source strides")
cases=cases+1
end
-- 232: bool/transpose/condition/(12,); source error=None
do
local base=np.array({{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool")
local a=np.transpose(base)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"bool/transpose/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{false,false,true,false,false,true},"bool/transpose/condition/(12,): result")
eq(result.shape,{6},"bool/transpose/condition/(12,): result: shape")
eq(result.strides,{1},"bool/transpose/condition/(12,): result: strides")
eq(result.dtype,"bool","bool/transpose/condition/(12,): result: dtype")
eq(base:tolist(),{{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool/transpose/condition/(12,): backing source")
eq(base.shape,{3,4},"bool/transpose/condition/(12,): backing source: shape")
eq(base.strides,{4,1},"bool/transpose/condition/(12,): backing source: strides")
eq(base.dtype,"bool","bool/transpose/condition/(12,): backing source: dtype")
eq(a.shape,{4,3},"bool/transpose/condition/(12,): source shape")
eq(a.strides,{1,4},"bool/transpose/condition/(12,): source strides")
cases=cases+1
end
-- 233: bool/transpose/condition/(14,); source error=IndexError
do
local base=np.array({{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool")
local a=np.transpose(base)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"bool/transpose/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool/transpose/condition/(14,): backing source")
eq(base.shape,{3,4},"bool/transpose/condition/(14,): backing source: shape")
eq(base.strides,{4,1},"bool/transpose/condition/(14,): backing source: strides")
eq(base.dtype,"bool","bool/transpose/condition/(14,): backing source: dtype")
eq(a.shape,{4,3},"bool/transpose/condition/(14,): source shape")
eq(a.strides,{1,4},"bool/transpose/condition/(14,): source strides")
cases=cases+1
end
-- 234: bool/transpose/condition/(0,); source error=None
do
local base=np.array({{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool")
local a=np.transpose(base)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"bool/transpose/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"bool/transpose/condition/(0,): result")
eq(result.shape,{0},"bool/transpose/condition/(0,): result: shape")
eq(result.strides,{0},"bool/transpose/condition/(0,): result: strides")
eq(result.dtype,"bool","bool/transpose/condition/(0,): result: dtype")
eq(base:tolist(),{{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool/transpose/condition/(0,): backing source")
eq(base.shape,{3,4},"bool/transpose/condition/(0,): backing source: shape")
eq(base.strides,{4,1},"bool/transpose/condition/(0,): backing source: strides")
eq(base.dtype,"bool","bool/transpose/condition/(0,): backing source: dtype")
eq(a.shape,{4,3},"bool/transpose/condition/(0,): source shape")
eq(a.strides,{1,4},"bool/transpose/condition/(0,): source strides")
cases=cases+1
end
-- 235: bool/transpose/condition/(); source error=None
do
local base=np.array({{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool")
local a=np.transpose(base)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"bool/transpose/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{false},"bool/transpose/condition/(): result")
eq(result.shape,{1},"bool/transpose/condition/(): result: shape")
eq(result.strides,{1},"bool/transpose/condition/(): result: strides")
eq(result.dtype,"bool","bool/transpose/condition/(): result: dtype")
eq(base:tolist(),{{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool/transpose/condition/(): backing source")
eq(base.shape,{3,4},"bool/transpose/condition/(): backing source: shape")
eq(base.strides,{4,1},"bool/transpose/condition/(): backing source: strides")
eq(base.dtype,"bool","bool/transpose/condition/(): backing source: dtype")
eq(a.shape,{4,3},"bool/transpose/condition/(): source shape")
eq(a.strides,{1,4},"bool/transpose/condition/(): source strides")
cases=cases+1
end
-- 236: bool/reverse_columns/condition/(2, 3); source error=None
do
local base=np.array({{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool")
local a=np.flip(base,2)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"bool/reverse_columns/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{true,true,true},"bool/reverse_columns/condition/(2, 3): result")
eq(result.shape,{3},"bool/reverse_columns/condition/(2, 3): result: shape")
eq(result.strides,{1},"bool/reverse_columns/condition/(2, 3): result: strides")
eq(result.dtype,"bool","bool/reverse_columns/condition/(2, 3): result: dtype")
eq(base:tolist(),{{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool/reverse_columns/condition/(2, 3): backing source")
eq(base.shape,{3,4},"bool/reverse_columns/condition/(2, 3): backing source: shape")
eq(base.strides,{4,1},"bool/reverse_columns/condition/(2, 3): backing source: strides")
eq(base.dtype,"bool","bool/reverse_columns/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"bool/reverse_columns/condition/(2, 3): source shape")
eq(a.strides,{4,-1},"bool/reverse_columns/condition/(2, 3): source strides")
cases=cases+1
end
-- 237: bool/reverse_columns/condition/(12,); source error=None
do
local base=np.array({{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool")
local a=np.flip(base,2)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"bool/reverse_columns/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{true,true,true,true,true,true},"bool/reverse_columns/condition/(12,): result")
eq(result.shape,{6},"bool/reverse_columns/condition/(12,): result: shape")
eq(result.strides,{1},"bool/reverse_columns/condition/(12,): result: strides")
eq(result.dtype,"bool","bool/reverse_columns/condition/(12,): result: dtype")
eq(base:tolist(),{{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool/reverse_columns/condition/(12,): backing source")
eq(base.shape,{3,4},"bool/reverse_columns/condition/(12,): backing source: shape")
eq(base.strides,{4,1},"bool/reverse_columns/condition/(12,): backing source: strides")
eq(base.dtype,"bool","bool/reverse_columns/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"bool/reverse_columns/condition/(12,): source shape")
eq(a.strides,{4,-1},"bool/reverse_columns/condition/(12,): source strides")
cases=cases+1
end
-- 238: bool/reverse_columns/condition/(14,); source error=IndexError
do
local base=np.array({{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool")
local a=np.flip(base,2)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"bool/reverse_columns/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool/reverse_columns/condition/(14,): backing source")
eq(base.shape,{3,4},"bool/reverse_columns/condition/(14,): backing source: shape")
eq(base.strides,{4,1},"bool/reverse_columns/condition/(14,): backing source: strides")
eq(base.dtype,"bool","bool/reverse_columns/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"bool/reverse_columns/condition/(14,): source shape")
eq(a.strides,{4,-1},"bool/reverse_columns/condition/(14,): source strides")
cases=cases+1
end
-- 239: bool/reverse_columns/condition/(0,); source error=None
do
local base=np.array({{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool")
local a=np.flip(base,2)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"bool/reverse_columns/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"bool/reverse_columns/condition/(0,): result")
eq(result.shape,{0},"bool/reverse_columns/condition/(0,): result: shape")
eq(result.strides,{0},"bool/reverse_columns/condition/(0,): result: strides")
eq(result.dtype,"bool","bool/reverse_columns/condition/(0,): result: dtype")
eq(base:tolist(),{{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool/reverse_columns/condition/(0,): backing source")
eq(base.shape,{3,4},"bool/reverse_columns/condition/(0,): backing source: shape")
eq(base.strides,{4,1},"bool/reverse_columns/condition/(0,): backing source: strides")
eq(base.dtype,"bool","bool/reverse_columns/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"bool/reverse_columns/condition/(0,): source shape")
eq(a.strides,{4,-1},"bool/reverse_columns/condition/(0,): source strides")
cases=cases+1
end
-- 240: bool/reverse_columns/condition/(); source error=None
do
local base=np.array({{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool")
local a=np.flip(base,2)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"bool/reverse_columns/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{true},"bool/reverse_columns/condition/(): result")
eq(result.shape,{1},"bool/reverse_columns/condition/(): result: shape")
eq(result.strides,{1},"bool/reverse_columns/condition/(): result: strides")
eq(result.dtype,"bool","bool/reverse_columns/condition/(): result: dtype")
eq(base:tolist(),{{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool/reverse_columns/condition/(): backing source")
eq(base.shape,{3,4},"bool/reverse_columns/condition/(): backing source: shape")
eq(base.strides,{4,1},"bool/reverse_columns/condition/(): backing source: strides")
eq(base.dtype,"bool","bool/reverse_columns/condition/(): backing source: dtype")
eq(a.shape,{3,4},"bool/reverse_columns/condition/(): source shape")
eq(a.strides,{4,-1},"bool/reverse_columns/condition/(): source strides")
cases=cases+1
end
-- 241: bool/reverse_rows/condition/(2, 3); source error=None
do
local base=np.array({{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool")
local a=np.flip(base,1)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"bool/reverse_rows/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{false,false,false},"bool/reverse_rows/condition/(2, 3): result")
eq(result.shape,{3},"bool/reverse_rows/condition/(2, 3): result: shape")
eq(result.strides,{1},"bool/reverse_rows/condition/(2, 3): result: strides")
eq(result.dtype,"bool","bool/reverse_rows/condition/(2, 3): result: dtype")
eq(base:tolist(),{{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool/reverse_rows/condition/(2, 3): backing source")
eq(base.shape,{3,4},"bool/reverse_rows/condition/(2, 3): backing source: shape")
eq(base.strides,{4,1},"bool/reverse_rows/condition/(2, 3): backing source: strides")
eq(base.dtype,"bool","bool/reverse_rows/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"bool/reverse_rows/condition/(2, 3): source shape")
eq(a.strides,{-4,1},"bool/reverse_rows/condition/(2, 3): source strides")
cases=cases+1
end
-- 242: bool/reverse_rows/condition/(12,); source error=None
do
local base=np.array({{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool")
local a=np.flip(base,1)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"bool/reverse_rows/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{false,false,false,false,false,false},"bool/reverse_rows/condition/(12,): result")
eq(result.shape,{6},"bool/reverse_rows/condition/(12,): result: shape")
eq(result.strides,{1},"bool/reverse_rows/condition/(12,): result: strides")
eq(result.dtype,"bool","bool/reverse_rows/condition/(12,): result: dtype")
eq(base:tolist(),{{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool/reverse_rows/condition/(12,): backing source")
eq(base.shape,{3,4},"bool/reverse_rows/condition/(12,): backing source: shape")
eq(base.strides,{4,1},"bool/reverse_rows/condition/(12,): backing source: strides")
eq(base.dtype,"bool","bool/reverse_rows/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"bool/reverse_rows/condition/(12,): source shape")
eq(a.strides,{-4,1},"bool/reverse_rows/condition/(12,): source strides")
cases=cases+1
end
-- 243: bool/reverse_rows/condition/(14,); source error=IndexError
do
local base=np.array({{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool")
local a=np.flip(base,1)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"bool/reverse_rows/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool/reverse_rows/condition/(14,): backing source")
eq(base.shape,{3,4},"bool/reverse_rows/condition/(14,): backing source: shape")
eq(base.strides,{4,1},"bool/reverse_rows/condition/(14,): backing source: strides")
eq(base.dtype,"bool","bool/reverse_rows/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"bool/reverse_rows/condition/(14,): source shape")
eq(a.strides,{-4,1},"bool/reverse_rows/condition/(14,): source strides")
cases=cases+1
end
-- 244: bool/reverse_rows/condition/(0,); source error=None
do
local base=np.array({{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool")
local a=np.flip(base,1)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"bool/reverse_rows/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"bool/reverse_rows/condition/(0,): result")
eq(result.shape,{0},"bool/reverse_rows/condition/(0,): result: shape")
eq(result.strides,{0},"bool/reverse_rows/condition/(0,): result: strides")
eq(result.dtype,"bool","bool/reverse_rows/condition/(0,): result: dtype")
eq(base:tolist(),{{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool/reverse_rows/condition/(0,): backing source")
eq(base.shape,{3,4},"bool/reverse_rows/condition/(0,): backing source: shape")
eq(base.strides,{4,1},"bool/reverse_rows/condition/(0,): backing source: strides")
eq(base.dtype,"bool","bool/reverse_rows/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"bool/reverse_rows/condition/(0,): source shape")
eq(a.strides,{-4,1},"bool/reverse_rows/condition/(0,): source strides")
cases=cases+1
end
-- 245: bool/reverse_rows/condition/(); source error=None
do
local base=np.array({{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool")
local a=np.flip(base,1)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"bool/reverse_rows/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{false},"bool/reverse_rows/condition/(): result")
eq(result.shape,{1},"bool/reverse_rows/condition/(): result: shape")
eq(result.strides,{1},"bool/reverse_rows/condition/(): result: strides")
eq(result.dtype,"bool","bool/reverse_rows/condition/(): result: dtype")
eq(base:tolist(),{{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool/reverse_rows/condition/(): backing source")
eq(base.shape,{3,4},"bool/reverse_rows/condition/(): backing source: shape")
eq(base.strides,{4,1},"bool/reverse_rows/condition/(): backing source: strides")
eq(base.dtype,"bool","bool/reverse_rows/condition/(): backing source: dtype")
eq(a.shape,{3,4},"bool/reverse_rows/condition/(): source shape")
eq(a.strides,{-4,1},"bool/reverse_rows/condition/(): source strides")
cases=cases+1
end
-- 246: bool/strided/condition/(2, 3); source error=None
do
local base=np.array({{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"bool/strided/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{false,false,false},"bool/strided/condition/(2, 3): result")
eq(result.shape,{3},"bool/strided/condition/(2, 3): result: shape")
eq(result.strides,{1},"bool/strided/condition/(2, 3): result: strides")
eq(result.dtype,"bool","bool/strided/condition/(2, 3): result: dtype")
eq(base:tolist(),{{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool/strided/condition/(2, 3): backing source")
eq(base.shape,{3,4},"bool/strided/condition/(2, 3): backing source: shape")
eq(base.strides,{4,1},"bool/strided/condition/(2, 3): backing source: strides")
eq(base.dtype,"bool","bool/strided/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,2},"bool/strided/condition/(2, 3): source shape")
eq(a.strides,{4,2},"bool/strided/condition/(2, 3): source strides")
cases=cases+1
end
-- 247: bool/strided/condition/(12,); source error=IndexError
do
local base=np.array({{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"bool/strided/condition/(12,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool/strided/condition/(12,): backing source")
eq(base.shape,{3,4},"bool/strided/condition/(12,): backing source: shape")
eq(base.strides,{4,1},"bool/strided/condition/(12,): backing source: strides")
eq(base.dtype,"bool","bool/strided/condition/(12,): backing source: dtype")
eq(a.shape,{3,2},"bool/strided/condition/(12,): source shape")
eq(a.strides,{4,2},"bool/strided/condition/(12,): source strides")
cases=cases+1
end
-- 248: bool/strided/condition/(14,); source error=IndexError
do
local base=np.array({{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"bool/strided/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool/strided/condition/(14,): backing source")
eq(base.shape,{3,4},"bool/strided/condition/(14,): backing source: shape")
eq(base.strides,{4,1},"bool/strided/condition/(14,): backing source: strides")
eq(base.dtype,"bool","bool/strided/condition/(14,): backing source: dtype")
eq(a.shape,{3,2},"bool/strided/condition/(14,): source shape")
eq(a.strides,{4,2},"bool/strided/condition/(14,): source strides")
cases=cases+1
end
-- 249: bool/strided/condition/(0,); source error=None
do
local base=np.array({{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"bool/strided/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"bool/strided/condition/(0,): result")
eq(result.shape,{0},"bool/strided/condition/(0,): result: shape")
eq(result.strides,{0},"bool/strided/condition/(0,): result: strides")
eq(result.dtype,"bool","bool/strided/condition/(0,): result: dtype")
eq(base:tolist(),{{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool/strided/condition/(0,): backing source")
eq(base.shape,{3,4},"bool/strided/condition/(0,): backing source: shape")
eq(base.strides,{4,1},"bool/strided/condition/(0,): backing source: strides")
eq(base.dtype,"bool","bool/strided/condition/(0,): backing source: dtype")
eq(a.shape,{3,2},"bool/strided/condition/(0,): source shape")
eq(a.strides,{4,2},"bool/strided/condition/(0,): source strides")
cases=cases+1
end
-- 250: bool/strided/condition/(); source error=None
do
local base=np.array({{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"bool/strided/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{false},"bool/strided/condition/(): result")
eq(result.shape,{1},"bool/strided/condition/(): result: shape")
eq(result.strides,{1},"bool/strided/condition/(): result: strides")
eq(result.dtype,"bool","bool/strided/condition/(): result: dtype")
eq(base:tolist(),{{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool/strided/condition/(): backing source")
eq(base.shape,{3,4},"bool/strided/condition/(): backing source: shape")
eq(base.strides,{4,1},"bool/strided/condition/(): backing source: strides")
eq(base.dtype,"bool","bool/strided/condition/(): backing source: dtype")
eq(a.shape,{3,2},"bool/strided/condition/(): source shape")
eq(a.strides,{4,2},"bool/strided/condition/(): source strides")
cases=cases+1
end
-- 251: complex64/plain/condition/(2, 3); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64")
local a=base
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"complex64/plain/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(2.0,0.0),np.complex(4.0,0.0)},"complex64/plain/condition/(2, 3): result")
eq(result.shape,{3},"complex64/plain/condition/(2, 3): result: shape")
eq(result.strides,{8},"complex64/plain/condition/(2, 3): result: strides")
eq(result.dtype,"complex64","complex64/plain/condition/(2, 3): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64/plain/condition/(2, 3): backing source")
eq(base.shape,{3,4},"complex64/plain/condition/(2, 3): backing source: shape")
eq(base.strides,{32,8},"complex64/plain/condition/(2, 3): backing source: strides")
eq(base.dtype,"complex64","complex64/plain/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"complex64/plain/condition/(2, 3): source shape")
eq(a.strides,{32,8},"complex64/plain/condition/(2, 3): source strides")
cases=cases+1
end
-- 252: complex64/plain/condition/(12,); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64")
local a=base
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"complex64/plain/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(2.0,0.0),np.complex(4.0,0.0),np.complex(6.0,0.0),np.complex(8.0,0.0),np.complex(10.0,0.0)},"complex64/plain/condition/(12,): result")
eq(result.shape,{6},"complex64/plain/condition/(12,): result: shape")
eq(result.strides,{8},"complex64/plain/condition/(12,): result: strides")
eq(result.dtype,"complex64","complex64/plain/condition/(12,): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64/plain/condition/(12,): backing source")
eq(base.shape,{3,4},"complex64/plain/condition/(12,): backing source: shape")
eq(base.strides,{32,8},"complex64/plain/condition/(12,): backing source: strides")
eq(base.dtype,"complex64","complex64/plain/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"complex64/plain/condition/(12,): source shape")
eq(a.strides,{32,8},"complex64/plain/condition/(12,): source strides")
cases=cases+1
end
-- 253: complex64/plain/condition/(14,); source error=IndexError
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64")
local a=base
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"complex64/plain/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64/plain/condition/(14,): backing source")
eq(base.shape,{3,4},"complex64/plain/condition/(14,): backing source: shape")
eq(base.strides,{32,8},"complex64/plain/condition/(14,): backing source: strides")
eq(base.dtype,"complex64","complex64/plain/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"complex64/plain/condition/(14,): source shape")
eq(a.strides,{32,8},"complex64/plain/condition/(14,): source strides")
cases=cases+1
end
-- 254: complex64/plain/condition/(0,); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"complex64/plain/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"complex64/plain/condition/(0,): result")
eq(result.shape,{0},"complex64/plain/condition/(0,): result: shape")
eq(result.strides,{0},"complex64/plain/condition/(0,): result: strides")
eq(result.dtype,"complex64","complex64/plain/condition/(0,): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64/plain/condition/(0,): backing source")
eq(base.shape,{3,4},"complex64/plain/condition/(0,): backing source: shape")
eq(base.strides,{32,8},"complex64/plain/condition/(0,): backing source: strides")
eq(base.dtype,"complex64","complex64/plain/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"complex64/plain/condition/(0,): source shape")
eq(a.strides,{32,8},"complex64/plain/condition/(0,): source strides")
cases=cases+1
end
-- 255: complex64/plain/condition/(); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"complex64/plain/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0)},"complex64/plain/condition/(): result")
eq(result.shape,{1},"complex64/plain/condition/(): result: shape")
eq(result.strides,{8},"complex64/plain/condition/(): result: strides")
eq(result.dtype,"complex64","complex64/plain/condition/(): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64/plain/condition/(): backing source")
eq(base.shape,{3,4},"complex64/plain/condition/(): backing source: shape")
eq(base.strides,{32,8},"complex64/plain/condition/(): backing source: strides")
eq(base.dtype,"complex64","complex64/plain/condition/(): backing source: dtype")
eq(a.shape,{3,4},"complex64/plain/condition/(): source shape")
eq(a.strides,{32,8},"complex64/plain/condition/(): source strides")
cases=cases+1
end
-- 256: complex64/transpose/condition/(2, 3); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64")
local a=np.transpose(base)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"complex64/transpose/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(8.0,0.0),np.complex(5.0,0.0)},"complex64/transpose/condition/(2, 3): result")
eq(result.shape,{3},"complex64/transpose/condition/(2, 3): result: shape")
eq(result.strides,{8},"complex64/transpose/condition/(2, 3): result: strides")
eq(result.dtype,"complex64","complex64/transpose/condition/(2, 3): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64/transpose/condition/(2, 3): backing source")
eq(base.shape,{3,4},"complex64/transpose/condition/(2, 3): backing source: shape")
eq(base.strides,{32,8},"complex64/transpose/condition/(2, 3): backing source: strides")
eq(base.dtype,"complex64","complex64/transpose/condition/(2, 3): backing source: dtype")
eq(a.shape,{4,3},"complex64/transpose/condition/(2, 3): source shape")
eq(a.strides,{8,32},"complex64/transpose/condition/(2, 3): source strides")
cases=cases+1
end
-- 257: complex64/transpose/condition/(12,); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64")
local a=np.transpose(base)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"complex64/transpose/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(8.0,0.0),np.complex(5.0,0.0),np.complex(2.0,0.0),np.complex(10.0,0.0),np.complex(7.0,0.0)},"complex64/transpose/condition/(12,): result")
eq(result.shape,{6},"complex64/transpose/condition/(12,): result: shape")
eq(result.strides,{8},"complex64/transpose/condition/(12,): result: strides")
eq(result.dtype,"complex64","complex64/transpose/condition/(12,): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64/transpose/condition/(12,): backing source")
eq(base.shape,{3,4},"complex64/transpose/condition/(12,): backing source: shape")
eq(base.strides,{32,8},"complex64/transpose/condition/(12,): backing source: strides")
eq(base.dtype,"complex64","complex64/transpose/condition/(12,): backing source: dtype")
eq(a.shape,{4,3},"complex64/transpose/condition/(12,): source shape")
eq(a.strides,{8,32},"complex64/transpose/condition/(12,): source strides")
cases=cases+1
end
-- 258: complex64/transpose/condition/(14,); source error=IndexError
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64")
local a=np.transpose(base)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"complex64/transpose/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64/transpose/condition/(14,): backing source")
eq(base.shape,{3,4},"complex64/transpose/condition/(14,): backing source: shape")
eq(base.strides,{32,8},"complex64/transpose/condition/(14,): backing source: strides")
eq(base.dtype,"complex64","complex64/transpose/condition/(14,): backing source: dtype")
eq(a.shape,{4,3},"complex64/transpose/condition/(14,): source shape")
eq(a.strides,{8,32},"complex64/transpose/condition/(14,): source strides")
cases=cases+1
end
-- 259: complex64/transpose/condition/(0,); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64")
local a=np.transpose(base)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"complex64/transpose/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"complex64/transpose/condition/(0,): result")
eq(result.shape,{0},"complex64/transpose/condition/(0,): result: shape")
eq(result.strides,{0},"complex64/transpose/condition/(0,): result: strides")
eq(result.dtype,"complex64","complex64/transpose/condition/(0,): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64/transpose/condition/(0,): backing source")
eq(base.shape,{3,4},"complex64/transpose/condition/(0,): backing source: shape")
eq(base.strides,{32,8},"complex64/transpose/condition/(0,): backing source: strides")
eq(base.dtype,"complex64","complex64/transpose/condition/(0,): backing source: dtype")
eq(a.shape,{4,3},"complex64/transpose/condition/(0,): source shape")
eq(a.strides,{8,32},"complex64/transpose/condition/(0,): source strides")
cases=cases+1
end
-- 260: complex64/transpose/condition/(); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64")
local a=np.transpose(base)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"complex64/transpose/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0)},"complex64/transpose/condition/(): result")
eq(result.shape,{1},"complex64/transpose/condition/(): result: shape")
eq(result.strides,{8},"complex64/transpose/condition/(): result: strides")
eq(result.dtype,"complex64","complex64/transpose/condition/(): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64/transpose/condition/(): backing source")
eq(base.shape,{3,4},"complex64/transpose/condition/(): backing source: shape")
eq(base.strides,{32,8},"complex64/transpose/condition/(): backing source: strides")
eq(base.dtype,"complex64","complex64/transpose/condition/(): backing source: dtype")
eq(a.shape,{4,3},"complex64/transpose/condition/(): source shape")
eq(a.strides,{8,32},"complex64/transpose/condition/(): source strides")
cases=cases+1
end
-- 261: complex64/reverse_columns/condition/(2, 3); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64")
local a=np.flip(base,2)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"complex64/reverse_columns/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(3.0,0.0),np.complex(1.0,0.0),np.complex(7.0,0.0)},"complex64/reverse_columns/condition/(2, 3): result")
eq(result.shape,{3},"complex64/reverse_columns/condition/(2, 3): result: shape")
eq(result.strides,{8},"complex64/reverse_columns/condition/(2, 3): result: strides")
eq(result.dtype,"complex64","complex64/reverse_columns/condition/(2, 3): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64/reverse_columns/condition/(2, 3): backing source")
eq(base.shape,{3,4},"complex64/reverse_columns/condition/(2, 3): backing source: shape")
eq(base.strides,{32,8},"complex64/reverse_columns/condition/(2, 3): backing source: strides")
eq(base.dtype,"complex64","complex64/reverse_columns/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"complex64/reverse_columns/condition/(2, 3): source shape")
eq(a.strides,{32,-8},"complex64/reverse_columns/condition/(2, 3): source strides")
cases=cases+1
end
-- 262: complex64/reverse_columns/condition/(12,); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64")
local a=np.flip(base,2)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"complex64/reverse_columns/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(3.0,0.0),np.complex(1.0,0.0),np.complex(7.0,0.0),np.complex(5.0,0.0),np.complex(11.0,0.0),np.complex(9.0,0.0)},"complex64/reverse_columns/condition/(12,): result")
eq(result.shape,{6},"complex64/reverse_columns/condition/(12,): result: shape")
eq(result.strides,{8},"complex64/reverse_columns/condition/(12,): result: strides")
eq(result.dtype,"complex64","complex64/reverse_columns/condition/(12,): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64/reverse_columns/condition/(12,): backing source")
eq(base.shape,{3,4},"complex64/reverse_columns/condition/(12,): backing source: shape")
eq(base.strides,{32,8},"complex64/reverse_columns/condition/(12,): backing source: strides")
eq(base.dtype,"complex64","complex64/reverse_columns/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"complex64/reverse_columns/condition/(12,): source shape")
eq(a.strides,{32,-8},"complex64/reverse_columns/condition/(12,): source strides")
cases=cases+1
end
-- 263: complex64/reverse_columns/condition/(14,); source error=IndexError
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64")
local a=np.flip(base,2)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"complex64/reverse_columns/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64/reverse_columns/condition/(14,): backing source")
eq(base.shape,{3,4},"complex64/reverse_columns/condition/(14,): backing source: shape")
eq(base.strides,{32,8},"complex64/reverse_columns/condition/(14,): backing source: strides")
eq(base.dtype,"complex64","complex64/reverse_columns/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"complex64/reverse_columns/condition/(14,): source shape")
eq(a.strides,{32,-8},"complex64/reverse_columns/condition/(14,): source strides")
cases=cases+1
end
-- 264: complex64/reverse_columns/condition/(0,); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64")
local a=np.flip(base,2)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"complex64/reverse_columns/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"complex64/reverse_columns/condition/(0,): result")
eq(result.shape,{0},"complex64/reverse_columns/condition/(0,): result: shape")
eq(result.strides,{0},"complex64/reverse_columns/condition/(0,): result: strides")
eq(result.dtype,"complex64","complex64/reverse_columns/condition/(0,): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64/reverse_columns/condition/(0,): backing source")
eq(base.shape,{3,4},"complex64/reverse_columns/condition/(0,): backing source: shape")
eq(base.strides,{32,8},"complex64/reverse_columns/condition/(0,): backing source: strides")
eq(base.dtype,"complex64","complex64/reverse_columns/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"complex64/reverse_columns/condition/(0,): source shape")
eq(a.strides,{32,-8},"complex64/reverse_columns/condition/(0,): source strides")
cases=cases+1
end
-- 265: complex64/reverse_columns/condition/(); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64")
local a=np.flip(base,2)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"complex64/reverse_columns/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(3.0,0.0)},"complex64/reverse_columns/condition/(): result")
eq(result.shape,{1},"complex64/reverse_columns/condition/(): result: shape")
eq(result.strides,{8},"complex64/reverse_columns/condition/(): result: strides")
eq(result.dtype,"complex64","complex64/reverse_columns/condition/(): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64/reverse_columns/condition/(): backing source")
eq(base.shape,{3,4},"complex64/reverse_columns/condition/(): backing source: shape")
eq(base.strides,{32,8},"complex64/reverse_columns/condition/(): backing source: strides")
eq(base.dtype,"complex64","complex64/reverse_columns/condition/(): backing source: dtype")
eq(a.shape,{3,4},"complex64/reverse_columns/condition/(): source shape")
eq(a.strides,{32,-8},"complex64/reverse_columns/condition/(): source strides")
cases=cases+1
end
-- 266: complex64/reverse_rows/condition/(2, 3); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64")
local a=np.flip(base,1)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"complex64/reverse_rows/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(8.0,0.0),np.complex(10.0,0.0),np.complex(4.0,0.0)},"complex64/reverse_rows/condition/(2, 3): result")
eq(result.shape,{3},"complex64/reverse_rows/condition/(2, 3): result: shape")
eq(result.strides,{8},"complex64/reverse_rows/condition/(2, 3): result: strides")
eq(result.dtype,"complex64","complex64/reverse_rows/condition/(2, 3): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64/reverse_rows/condition/(2, 3): backing source")
eq(base.shape,{3,4},"complex64/reverse_rows/condition/(2, 3): backing source: shape")
eq(base.strides,{32,8},"complex64/reverse_rows/condition/(2, 3): backing source: strides")
eq(base.dtype,"complex64","complex64/reverse_rows/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"complex64/reverse_rows/condition/(2, 3): source shape")
eq(a.strides,{-32,8},"complex64/reverse_rows/condition/(2, 3): source strides")
cases=cases+1
end
-- 267: complex64/reverse_rows/condition/(12,); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64")
local a=np.flip(base,1)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"complex64/reverse_rows/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(8.0,0.0),np.complex(10.0,0.0),np.complex(4.0,0.0),np.complex(6.0,0.0),np.complex(0.0,0.0),np.complex(2.0,0.0)},"complex64/reverse_rows/condition/(12,): result")
eq(result.shape,{6},"complex64/reverse_rows/condition/(12,): result: shape")
eq(result.strides,{8},"complex64/reverse_rows/condition/(12,): result: strides")
eq(result.dtype,"complex64","complex64/reverse_rows/condition/(12,): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64/reverse_rows/condition/(12,): backing source")
eq(base.shape,{3,4},"complex64/reverse_rows/condition/(12,): backing source: shape")
eq(base.strides,{32,8},"complex64/reverse_rows/condition/(12,): backing source: strides")
eq(base.dtype,"complex64","complex64/reverse_rows/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"complex64/reverse_rows/condition/(12,): source shape")
eq(a.strides,{-32,8},"complex64/reverse_rows/condition/(12,): source strides")
cases=cases+1
end
-- 268: complex64/reverse_rows/condition/(14,); source error=IndexError
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64")
local a=np.flip(base,1)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"complex64/reverse_rows/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64/reverse_rows/condition/(14,): backing source")
eq(base.shape,{3,4},"complex64/reverse_rows/condition/(14,): backing source: shape")
eq(base.strides,{32,8},"complex64/reverse_rows/condition/(14,): backing source: strides")
eq(base.dtype,"complex64","complex64/reverse_rows/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"complex64/reverse_rows/condition/(14,): source shape")
eq(a.strides,{-32,8},"complex64/reverse_rows/condition/(14,): source strides")
cases=cases+1
end
-- 269: complex64/reverse_rows/condition/(0,); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64")
local a=np.flip(base,1)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"complex64/reverse_rows/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"complex64/reverse_rows/condition/(0,): result")
eq(result.shape,{0},"complex64/reverse_rows/condition/(0,): result: shape")
eq(result.strides,{0},"complex64/reverse_rows/condition/(0,): result: strides")
eq(result.dtype,"complex64","complex64/reverse_rows/condition/(0,): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64/reverse_rows/condition/(0,): backing source")
eq(base.shape,{3,4},"complex64/reverse_rows/condition/(0,): backing source: shape")
eq(base.strides,{32,8},"complex64/reverse_rows/condition/(0,): backing source: strides")
eq(base.dtype,"complex64","complex64/reverse_rows/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"complex64/reverse_rows/condition/(0,): source shape")
eq(a.strides,{-32,8},"complex64/reverse_rows/condition/(0,): source strides")
cases=cases+1
end
-- 270: complex64/reverse_rows/condition/(); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64")
local a=np.flip(base,1)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"complex64/reverse_rows/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(8.0,0.0)},"complex64/reverse_rows/condition/(): result")
eq(result.shape,{1},"complex64/reverse_rows/condition/(): result: shape")
eq(result.strides,{8},"complex64/reverse_rows/condition/(): result: strides")
eq(result.dtype,"complex64","complex64/reverse_rows/condition/(): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64/reverse_rows/condition/(): backing source")
eq(base.shape,{3,4},"complex64/reverse_rows/condition/(): backing source: shape")
eq(base.strides,{32,8},"complex64/reverse_rows/condition/(): backing source: strides")
eq(base.dtype,"complex64","complex64/reverse_rows/condition/(): backing source: dtype")
eq(a.shape,{3,4},"complex64/reverse_rows/condition/(): source shape")
eq(a.strides,{-32,8},"complex64/reverse_rows/condition/(): source strides")
cases=cases+1
end
-- 271: complex64/strided/condition/(2, 3); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"complex64/strided/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(4.0,0.0),np.complex(8.0,0.0)},"complex64/strided/condition/(2, 3): result")
eq(result.shape,{3},"complex64/strided/condition/(2, 3): result: shape")
eq(result.strides,{8},"complex64/strided/condition/(2, 3): result: strides")
eq(result.dtype,"complex64","complex64/strided/condition/(2, 3): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64/strided/condition/(2, 3): backing source")
eq(base.shape,{3,4},"complex64/strided/condition/(2, 3): backing source: shape")
eq(base.strides,{32,8},"complex64/strided/condition/(2, 3): backing source: strides")
eq(base.dtype,"complex64","complex64/strided/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,2},"complex64/strided/condition/(2, 3): source shape")
eq(a.strides,{32,16},"complex64/strided/condition/(2, 3): source strides")
cases=cases+1
end
-- 272: complex64/strided/condition/(12,); source error=IndexError
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"complex64/strided/condition/(12,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64/strided/condition/(12,): backing source")
eq(base.shape,{3,4},"complex64/strided/condition/(12,): backing source: shape")
eq(base.strides,{32,8},"complex64/strided/condition/(12,): backing source: strides")
eq(base.dtype,"complex64","complex64/strided/condition/(12,): backing source: dtype")
eq(a.shape,{3,2},"complex64/strided/condition/(12,): source shape")
eq(a.strides,{32,16},"complex64/strided/condition/(12,): source strides")
cases=cases+1
end
-- 273: complex64/strided/condition/(14,); source error=IndexError
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"complex64/strided/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64/strided/condition/(14,): backing source")
eq(base.shape,{3,4},"complex64/strided/condition/(14,): backing source: shape")
eq(base.strides,{32,8},"complex64/strided/condition/(14,): backing source: strides")
eq(base.dtype,"complex64","complex64/strided/condition/(14,): backing source: dtype")
eq(a.shape,{3,2},"complex64/strided/condition/(14,): source shape")
eq(a.strides,{32,16},"complex64/strided/condition/(14,): source strides")
cases=cases+1
end
-- 274: complex64/strided/condition/(0,); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"complex64/strided/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"complex64/strided/condition/(0,): result")
eq(result.shape,{0},"complex64/strided/condition/(0,): result: shape")
eq(result.strides,{0},"complex64/strided/condition/(0,): result: strides")
eq(result.dtype,"complex64","complex64/strided/condition/(0,): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64/strided/condition/(0,): backing source")
eq(base.shape,{3,4},"complex64/strided/condition/(0,): backing source: shape")
eq(base.strides,{32,8},"complex64/strided/condition/(0,): backing source: strides")
eq(base.dtype,"complex64","complex64/strided/condition/(0,): backing source: dtype")
eq(a.shape,{3,2},"complex64/strided/condition/(0,): source shape")
eq(a.strides,{32,16},"complex64/strided/condition/(0,): source strides")
cases=cases+1
end
-- 275: complex64/strided/condition/(); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"complex64/strided/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0)},"complex64/strided/condition/(): result")
eq(result.shape,{1},"complex64/strided/condition/(): result: shape")
eq(result.strides,{8},"complex64/strided/condition/(): result: strides")
eq(result.dtype,"complex64","complex64/strided/condition/(): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64/strided/condition/(): backing source")
eq(base.shape,{3,4},"complex64/strided/condition/(): backing source: shape")
eq(base.strides,{32,8},"complex64/strided/condition/(): backing source: strides")
eq(base.dtype,"complex64","complex64/strided/condition/(): backing source: dtype")
eq(a.shape,{3,2},"complex64/strided/condition/(): source shape")
eq(a.strides,{32,16},"complex64/strided/condition/(): source strides")
cases=cases+1
end
-- 276: complex128/plain/condition/(2, 3); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128")
local a=base
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"complex128/plain/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(2.0,0.0),np.complex(4.0,0.0)},"complex128/plain/condition/(2, 3): result")
eq(result.shape,{3},"complex128/plain/condition/(2, 3): result: shape")
eq(result.strides,{16},"complex128/plain/condition/(2, 3): result: strides")
eq(result.dtype,"complex128","complex128/plain/condition/(2, 3): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128/plain/condition/(2, 3): backing source")
eq(base.shape,{3,4},"complex128/plain/condition/(2, 3): backing source: shape")
eq(base.strides,{64,16},"complex128/plain/condition/(2, 3): backing source: strides")
eq(base.dtype,"complex128","complex128/plain/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"complex128/plain/condition/(2, 3): source shape")
eq(a.strides,{64,16},"complex128/plain/condition/(2, 3): source strides")
cases=cases+1
end
-- 277: complex128/plain/condition/(12,); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128")
local a=base
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"complex128/plain/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(2.0,0.0),np.complex(4.0,0.0),np.complex(6.0,0.0),np.complex(8.0,0.0),np.complex(10.0,0.0)},"complex128/plain/condition/(12,): result")
eq(result.shape,{6},"complex128/plain/condition/(12,): result: shape")
eq(result.strides,{16},"complex128/plain/condition/(12,): result: strides")
eq(result.dtype,"complex128","complex128/plain/condition/(12,): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128/plain/condition/(12,): backing source")
eq(base.shape,{3,4},"complex128/plain/condition/(12,): backing source: shape")
eq(base.strides,{64,16},"complex128/plain/condition/(12,): backing source: strides")
eq(base.dtype,"complex128","complex128/plain/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"complex128/plain/condition/(12,): source shape")
eq(a.strides,{64,16},"complex128/plain/condition/(12,): source strides")
cases=cases+1
end
-- 278: complex128/plain/condition/(14,); source error=IndexError
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128")
local a=base
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"complex128/plain/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128/plain/condition/(14,): backing source")
eq(base.shape,{3,4},"complex128/plain/condition/(14,): backing source: shape")
eq(base.strides,{64,16},"complex128/plain/condition/(14,): backing source: strides")
eq(base.dtype,"complex128","complex128/plain/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"complex128/plain/condition/(14,): source shape")
eq(a.strides,{64,16},"complex128/plain/condition/(14,): source strides")
cases=cases+1
end
-- 279: complex128/plain/condition/(0,); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"complex128/plain/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"complex128/plain/condition/(0,): result")
eq(result.shape,{0},"complex128/plain/condition/(0,): result: shape")
eq(result.strides,{0},"complex128/plain/condition/(0,): result: strides")
eq(result.dtype,"complex128","complex128/plain/condition/(0,): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128/plain/condition/(0,): backing source")
eq(base.shape,{3,4},"complex128/plain/condition/(0,): backing source: shape")
eq(base.strides,{64,16},"complex128/plain/condition/(0,): backing source: strides")
eq(base.dtype,"complex128","complex128/plain/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"complex128/plain/condition/(0,): source shape")
eq(a.strides,{64,16},"complex128/plain/condition/(0,): source strides")
cases=cases+1
end
-- 280: complex128/plain/condition/(); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"complex128/plain/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0)},"complex128/plain/condition/(): result")
eq(result.shape,{1},"complex128/plain/condition/(): result: shape")
eq(result.strides,{16},"complex128/plain/condition/(): result: strides")
eq(result.dtype,"complex128","complex128/plain/condition/(): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128/plain/condition/(): backing source")
eq(base.shape,{3,4},"complex128/plain/condition/(): backing source: shape")
eq(base.strides,{64,16},"complex128/plain/condition/(): backing source: strides")
eq(base.dtype,"complex128","complex128/plain/condition/(): backing source: dtype")
eq(a.shape,{3,4},"complex128/plain/condition/(): source shape")
eq(a.strides,{64,16},"complex128/plain/condition/(): source strides")
cases=cases+1
end
-- 281: complex128/transpose/condition/(2, 3); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128")
local a=np.transpose(base)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"complex128/transpose/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(8.0,0.0),np.complex(5.0,0.0)},"complex128/transpose/condition/(2, 3): result")
eq(result.shape,{3},"complex128/transpose/condition/(2, 3): result: shape")
eq(result.strides,{16},"complex128/transpose/condition/(2, 3): result: strides")
eq(result.dtype,"complex128","complex128/transpose/condition/(2, 3): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128/transpose/condition/(2, 3): backing source")
eq(base.shape,{3,4},"complex128/transpose/condition/(2, 3): backing source: shape")
eq(base.strides,{64,16},"complex128/transpose/condition/(2, 3): backing source: strides")
eq(base.dtype,"complex128","complex128/transpose/condition/(2, 3): backing source: dtype")
eq(a.shape,{4,3},"complex128/transpose/condition/(2, 3): source shape")
eq(a.strides,{16,64},"complex128/transpose/condition/(2, 3): source strides")
cases=cases+1
end
-- 282: complex128/transpose/condition/(12,); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128")
local a=np.transpose(base)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"complex128/transpose/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(8.0,0.0),np.complex(5.0,0.0),np.complex(2.0,0.0),np.complex(10.0,0.0),np.complex(7.0,0.0)},"complex128/transpose/condition/(12,): result")
eq(result.shape,{6},"complex128/transpose/condition/(12,): result: shape")
eq(result.strides,{16},"complex128/transpose/condition/(12,): result: strides")
eq(result.dtype,"complex128","complex128/transpose/condition/(12,): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128/transpose/condition/(12,): backing source")
eq(base.shape,{3,4},"complex128/transpose/condition/(12,): backing source: shape")
eq(base.strides,{64,16},"complex128/transpose/condition/(12,): backing source: strides")
eq(base.dtype,"complex128","complex128/transpose/condition/(12,): backing source: dtype")
eq(a.shape,{4,3},"complex128/transpose/condition/(12,): source shape")
eq(a.strides,{16,64},"complex128/transpose/condition/(12,): source strides")
cases=cases+1
end
-- 283: complex128/transpose/condition/(14,); source error=IndexError
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128")
local a=np.transpose(base)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"complex128/transpose/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128/transpose/condition/(14,): backing source")
eq(base.shape,{3,4},"complex128/transpose/condition/(14,): backing source: shape")
eq(base.strides,{64,16},"complex128/transpose/condition/(14,): backing source: strides")
eq(base.dtype,"complex128","complex128/transpose/condition/(14,): backing source: dtype")
eq(a.shape,{4,3},"complex128/transpose/condition/(14,): source shape")
eq(a.strides,{16,64},"complex128/transpose/condition/(14,): source strides")
cases=cases+1
end
-- 284: complex128/transpose/condition/(0,); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128")
local a=np.transpose(base)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"complex128/transpose/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"complex128/transpose/condition/(0,): result")
eq(result.shape,{0},"complex128/transpose/condition/(0,): result: shape")
eq(result.strides,{0},"complex128/transpose/condition/(0,): result: strides")
eq(result.dtype,"complex128","complex128/transpose/condition/(0,): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128/transpose/condition/(0,): backing source")
eq(base.shape,{3,4},"complex128/transpose/condition/(0,): backing source: shape")
eq(base.strides,{64,16},"complex128/transpose/condition/(0,): backing source: strides")
eq(base.dtype,"complex128","complex128/transpose/condition/(0,): backing source: dtype")
eq(a.shape,{4,3},"complex128/transpose/condition/(0,): source shape")
eq(a.strides,{16,64},"complex128/transpose/condition/(0,): source strides")
cases=cases+1
end
-- 285: complex128/transpose/condition/(); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128")
local a=np.transpose(base)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"complex128/transpose/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0)},"complex128/transpose/condition/(): result")
eq(result.shape,{1},"complex128/transpose/condition/(): result: shape")
eq(result.strides,{16},"complex128/transpose/condition/(): result: strides")
eq(result.dtype,"complex128","complex128/transpose/condition/(): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128/transpose/condition/(): backing source")
eq(base.shape,{3,4},"complex128/transpose/condition/(): backing source: shape")
eq(base.strides,{64,16},"complex128/transpose/condition/(): backing source: strides")
eq(base.dtype,"complex128","complex128/transpose/condition/(): backing source: dtype")
eq(a.shape,{4,3},"complex128/transpose/condition/(): source shape")
eq(a.strides,{16,64},"complex128/transpose/condition/(): source strides")
cases=cases+1
end
-- 286: complex128/reverse_columns/condition/(2, 3); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128")
local a=np.flip(base,2)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"complex128/reverse_columns/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(3.0,0.0),np.complex(1.0,0.0),np.complex(7.0,0.0)},"complex128/reverse_columns/condition/(2, 3): result")
eq(result.shape,{3},"complex128/reverse_columns/condition/(2, 3): result: shape")
eq(result.strides,{16},"complex128/reverse_columns/condition/(2, 3): result: strides")
eq(result.dtype,"complex128","complex128/reverse_columns/condition/(2, 3): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128/reverse_columns/condition/(2, 3): backing source")
eq(base.shape,{3,4},"complex128/reverse_columns/condition/(2, 3): backing source: shape")
eq(base.strides,{64,16},"complex128/reverse_columns/condition/(2, 3): backing source: strides")
eq(base.dtype,"complex128","complex128/reverse_columns/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"complex128/reverse_columns/condition/(2, 3): source shape")
eq(a.strides,{64,-16},"complex128/reverse_columns/condition/(2, 3): source strides")
cases=cases+1
end
-- 287: complex128/reverse_columns/condition/(12,); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128")
local a=np.flip(base,2)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"complex128/reverse_columns/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(3.0,0.0),np.complex(1.0,0.0),np.complex(7.0,0.0),np.complex(5.0,0.0),np.complex(11.0,0.0),np.complex(9.0,0.0)},"complex128/reverse_columns/condition/(12,): result")
eq(result.shape,{6},"complex128/reverse_columns/condition/(12,): result: shape")
eq(result.strides,{16},"complex128/reverse_columns/condition/(12,): result: strides")
eq(result.dtype,"complex128","complex128/reverse_columns/condition/(12,): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128/reverse_columns/condition/(12,): backing source")
eq(base.shape,{3,4},"complex128/reverse_columns/condition/(12,): backing source: shape")
eq(base.strides,{64,16},"complex128/reverse_columns/condition/(12,): backing source: strides")
eq(base.dtype,"complex128","complex128/reverse_columns/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"complex128/reverse_columns/condition/(12,): source shape")
eq(a.strides,{64,-16},"complex128/reverse_columns/condition/(12,): source strides")
cases=cases+1
end
-- 288: complex128/reverse_columns/condition/(14,); source error=IndexError
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128")
local a=np.flip(base,2)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"complex128/reverse_columns/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128/reverse_columns/condition/(14,): backing source")
eq(base.shape,{3,4},"complex128/reverse_columns/condition/(14,): backing source: shape")
eq(base.strides,{64,16},"complex128/reverse_columns/condition/(14,): backing source: strides")
eq(base.dtype,"complex128","complex128/reverse_columns/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"complex128/reverse_columns/condition/(14,): source shape")
eq(a.strides,{64,-16},"complex128/reverse_columns/condition/(14,): source strides")
cases=cases+1
end
-- 289: complex128/reverse_columns/condition/(0,); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128")
local a=np.flip(base,2)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"complex128/reverse_columns/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"complex128/reverse_columns/condition/(0,): result")
eq(result.shape,{0},"complex128/reverse_columns/condition/(0,): result: shape")
eq(result.strides,{0},"complex128/reverse_columns/condition/(0,): result: strides")
eq(result.dtype,"complex128","complex128/reverse_columns/condition/(0,): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128/reverse_columns/condition/(0,): backing source")
eq(base.shape,{3,4},"complex128/reverse_columns/condition/(0,): backing source: shape")
eq(base.strides,{64,16},"complex128/reverse_columns/condition/(0,): backing source: strides")
eq(base.dtype,"complex128","complex128/reverse_columns/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"complex128/reverse_columns/condition/(0,): source shape")
eq(a.strides,{64,-16},"complex128/reverse_columns/condition/(0,): source strides")
cases=cases+1
end
-- 290: complex128/reverse_columns/condition/(); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128")
local a=np.flip(base,2)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"complex128/reverse_columns/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(3.0,0.0)},"complex128/reverse_columns/condition/(): result")
eq(result.shape,{1},"complex128/reverse_columns/condition/(): result: shape")
eq(result.strides,{16},"complex128/reverse_columns/condition/(): result: strides")
eq(result.dtype,"complex128","complex128/reverse_columns/condition/(): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128/reverse_columns/condition/(): backing source")
eq(base.shape,{3,4},"complex128/reverse_columns/condition/(): backing source: shape")
eq(base.strides,{64,16},"complex128/reverse_columns/condition/(): backing source: strides")
eq(base.dtype,"complex128","complex128/reverse_columns/condition/(): backing source: dtype")
eq(a.shape,{3,4},"complex128/reverse_columns/condition/(): source shape")
eq(a.strides,{64,-16},"complex128/reverse_columns/condition/(): source strides")
cases=cases+1
end
-- 291: complex128/reverse_rows/condition/(2, 3); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128")
local a=np.flip(base,1)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"complex128/reverse_rows/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(8.0,0.0),np.complex(10.0,0.0),np.complex(4.0,0.0)},"complex128/reverse_rows/condition/(2, 3): result")
eq(result.shape,{3},"complex128/reverse_rows/condition/(2, 3): result: shape")
eq(result.strides,{16},"complex128/reverse_rows/condition/(2, 3): result: strides")
eq(result.dtype,"complex128","complex128/reverse_rows/condition/(2, 3): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128/reverse_rows/condition/(2, 3): backing source")
eq(base.shape,{3,4},"complex128/reverse_rows/condition/(2, 3): backing source: shape")
eq(base.strides,{64,16},"complex128/reverse_rows/condition/(2, 3): backing source: strides")
eq(base.dtype,"complex128","complex128/reverse_rows/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"complex128/reverse_rows/condition/(2, 3): source shape")
eq(a.strides,{-64,16},"complex128/reverse_rows/condition/(2, 3): source strides")
cases=cases+1
end
-- 292: complex128/reverse_rows/condition/(12,); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128")
local a=np.flip(base,1)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"complex128/reverse_rows/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(8.0,0.0),np.complex(10.0,0.0),np.complex(4.0,0.0),np.complex(6.0,0.0),np.complex(0.0,0.0),np.complex(2.0,0.0)},"complex128/reverse_rows/condition/(12,): result")
eq(result.shape,{6},"complex128/reverse_rows/condition/(12,): result: shape")
eq(result.strides,{16},"complex128/reverse_rows/condition/(12,): result: strides")
eq(result.dtype,"complex128","complex128/reverse_rows/condition/(12,): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128/reverse_rows/condition/(12,): backing source")
eq(base.shape,{3,4},"complex128/reverse_rows/condition/(12,): backing source: shape")
eq(base.strides,{64,16},"complex128/reverse_rows/condition/(12,): backing source: strides")
eq(base.dtype,"complex128","complex128/reverse_rows/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"complex128/reverse_rows/condition/(12,): source shape")
eq(a.strides,{-64,16},"complex128/reverse_rows/condition/(12,): source strides")
cases=cases+1
end
-- 293: complex128/reverse_rows/condition/(14,); source error=IndexError
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128")
local a=np.flip(base,1)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"complex128/reverse_rows/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128/reverse_rows/condition/(14,): backing source")
eq(base.shape,{3,4},"complex128/reverse_rows/condition/(14,): backing source: shape")
eq(base.strides,{64,16},"complex128/reverse_rows/condition/(14,): backing source: strides")
eq(base.dtype,"complex128","complex128/reverse_rows/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"complex128/reverse_rows/condition/(14,): source shape")
eq(a.strides,{-64,16},"complex128/reverse_rows/condition/(14,): source strides")
cases=cases+1
end
-- 294: complex128/reverse_rows/condition/(0,); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128")
local a=np.flip(base,1)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"complex128/reverse_rows/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"complex128/reverse_rows/condition/(0,): result")
eq(result.shape,{0},"complex128/reverse_rows/condition/(0,): result: shape")
eq(result.strides,{0},"complex128/reverse_rows/condition/(0,): result: strides")
eq(result.dtype,"complex128","complex128/reverse_rows/condition/(0,): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128/reverse_rows/condition/(0,): backing source")
eq(base.shape,{3,4},"complex128/reverse_rows/condition/(0,): backing source: shape")
eq(base.strides,{64,16},"complex128/reverse_rows/condition/(0,): backing source: strides")
eq(base.dtype,"complex128","complex128/reverse_rows/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"complex128/reverse_rows/condition/(0,): source shape")
eq(a.strides,{-64,16},"complex128/reverse_rows/condition/(0,): source strides")
cases=cases+1
end
-- 295: complex128/reverse_rows/condition/(); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128")
local a=np.flip(base,1)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"complex128/reverse_rows/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(8.0,0.0)},"complex128/reverse_rows/condition/(): result")
eq(result.shape,{1},"complex128/reverse_rows/condition/(): result: shape")
eq(result.strides,{16},"complex128/reverse_rows/condition/(): result: strides")
eq(result.dtype,"complex128","complex128/reverse_rows/condition/(): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128/reverse_rows/condition/(): backing source")
eq(base.shape,{3,4},"complex128/reverse_rows/condition/(): backing source: shape")
eq(base.strides,{64,16},"complex128/reverse_rows/condition/(): backing source: strides")
eq(base.dtype,"complex128","complex128/reverse_rows/condition/(): backing source: dtype")
eq(a.shape,{3,4},"complex128/reverse_rows/condition/(): source shape")
eq(a.strides,{-64,16},"complex128/reverse_rows/condition/(): source strides")
cases=cases+1
end
-- 296: complex128/strided/condition/(2, 3); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"complex128/strided/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(4.0,0.0),np.complex(8.0,0.0)},"complex128/strided/condition/(2, 3): result")
eq(result.shape,{3},"complex128/strided/condition/(2, 3): result: shape")
eq(result.strides,{16},"complex128/strided/condition/(2, 3): result: strides")
eq(result.dtype,"complex128","complex128/strided/condition/(2, 3): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128/strided/condition/(2, 3): backing source")
eq(base.shape,{3,4},"complex128/strided/condition/(2, 3): backing source: shape")
eq(base.strides,{64,16},"complex128/strided/condition/(2, 3): backing source: strides")
eq(base.dtype,"complex128","complex128/strided/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,2},"complex128/strided/condition/(2, 3): source shape")
eq(a.strides,{64,32},"complex128/strided/condition/(2, 3): source strides")
cases=cases+1
end
-- 297: complex128/strided/condition/(12,); source error=IndexError
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"complex128/strided/condition/(12,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128/strided/condition/(12,): backing source")
eq(base.shape,{3,4},"complex128/strided/condition/(12,): backing source: shape")
eq(base.strides,{64,16},"complex128/strided/condition/(12,): backing source: strides")
eq(base.dtype,"complex128","complex128/strided/condition/(12,): backing source: dtype")
eq(a.shape,{3,2},"complex128/strided/condition/(12,): source shape")
eq(a.strides,{64,32},"complex128/strided/condition/(12,): source strides")
cases=cases+1
end
-- 298: complex128/strided/condition/(14,); source error=IndexError
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"complex128/strided/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128/strided/condition/(14,): backing source")
eq(base.shape,{3,4},"complex128/strided/condition/(14,): backing source: shape")
eq(base.strides,{64,16},"complex128/strided/condition/(14,): backing source: strides")
eq(base.dtype,"complex128","complex128/strided/condition/(14,): backing source: dtype")
eq(a.shape,{3,2},"complex128/strided/condition/(14,): source shape")
eq(a.strides,{64,32},"complex128/strided/condition/(14,): source strides")
cases=cases+1
end
-- 299: complex128/strided/condition/(0,); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"complex128/strided/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"complex128/strided/condition/(0,): result")
eq(result.shape,{0},"complex128/strided/condition/(0,): result: shape")
eq(result.strides,{0},"complex128/strided/condition/(0,): result: strides")
eq(result.dtype,"complex128","complex128/strided/condition/(0,): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128/strided/condition/(0,): backing source")
eq(base.shape,{3,4},"complex128/strided/condition/(0,): backing source: shape")
eq(base.strides,{64,16},"complex128/strided/condition/(0,): backing source: strides")
eq(base.dtype,"complex128","complex128/strided/condition/(0,): backing source: dtype")
eq(a.shape,{3,2},"complex128/strided/condition/(0,): source shape")
eq(a.strides,{64,32},"complex128/strided/condition/(0,): source strides")
cases=cases+1
end
-- 300: complex128/strided/condition/(); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"complex128/strided/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0)},"complex128/strided/condition/(): result")
eq(result.shape,{1},"complex128/strided/condition/(): result: shape")
eq(result.strides,{16},"complex128/strided/condition/(): result: strides")
eq(result.dtype,"complex128","complex128/strided/condition/(): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128/strided/condition/(): backing source")
eq(base.shape,{3,4},"complex128/strided/condition/(): backing source: shape")
eq(base.strides,{64,16},"complex128/strided/condition/(): backing source: strides")
eq(base.dtype,"complex128","complex128/strided/condition/(): backing source: dtype")
eq(a.shape,{3,2},"complex128/strided/condition/(): source shape")
eq(a.strides,{64,32},"complex128/strided/condition/(): source strides")
cases=cases+1
end
end
chunk()
end
do
local function chunk()
-- 301: U4/plain/condition/(2, 3); source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"<U4")
local a=base
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"U4/plain/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{"0","2","4"},"U4/plain/condition/(2, 3): result")
eq(result.shape,{3},"U4/plain/condition/(2, 3): result: shape")
eq(result.strides,{16},"U4/plain/condition/(2, 3): result: strides")
eq(result.dtype,"<U4","U4/plain/condition/(2, 3): result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"U4/plain/condition/(2, 3): backing source")
eq(base.shape,{3,4},"U4/plain/condition/(2, 3): backing source: shape")
eq(base.strides,{64,16},"U4/plain/condition/(2, 3): backing source: strides")
eq(base.dtype,"<U4","U4/plain/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"U4/plain/condition/(2, 3): source shape")
eq(a.strides,{64,16},"U4/plain/condition/(2, 3): source strides")
cases=cases+1
end
-- 302: U4/plain/condition/(12,); source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"<U4")
local a=base
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"U4/plain/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{"0","2","4","6","8","10"},"U4/plain/condition/(12,): result")
eq(result.shape,{6},"U4/plain/condition/(12,): result: shape")
eq(result.strides,{16},"U4/plain/condition/(12,): result: strides")
eq(result.dtype,"<U4","U4/plain/condition/(12,): result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"U4/plain/condition/(12,): backing source")
eq(base.shape,{3,4},"U4/plain/condition/(12,): backing source: shape")
eq(base.strides,{64,16},"U4/plain/condition/(12,): backing source: strides")
eq(base.dtype,"<U4","U4/plain/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"U4/plain/condition/(12,): source shape")
eq(a.strides,{64,16},"U4/plain/condition/(12,): source strides")
cases=cases+1
end
-- 303: U4/plain/condition/(14,); source error=IndexError
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"<U4")
local a=base
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"U4/plain/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"U4/plain/condition/(14,): backing source")
eq(base.shape,{3,4},"U4/plain/condition/(14,): backing source: shape")
eq(base.strides,{64,16},"U4/plain/condition/(14,): backing source: strides")
eq(base.dtype,"<U4","U4/plain/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"U4/plain/condition/(14,): source shape")
eq(a.strides,{64,16},"U4/plain/condition/(14,): source strides")
cases=cases+1
end
-- 304: U4/plain/condition/(0,); source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"<U4")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"U4/plain/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"U4/plain/condition/(0,): result")
eq(result.shape,{0},"U4/plain/condition/(0,): result: shape")
eq(result.strides,{0},"U4/plain/condition/(0,): result: strides")
eq(result.dtype,"<U4","U4/plain/condition/(0,): result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"U4/plain/condition/(0,): backing source")
eq(base.shape,{3,4},"U4/plain/condition/(0,): backing source: shape")
eq(base.strides,{64,16},"U4/plain/condition/(0,): backing source: strides")
eq(base.dtype,"<U4","U4/plain/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"U4/plain/condition/(0,): source shape")
eq(a.strides,{64,16},"U4/plain/condition/(0,): source strides")
cases=cases+1
end
-- 305: U4/plain/condition/(); source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"<U4")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"U4/plain/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{"0"},"U4/plain/condition/(): result")
eq(result.shape,{1},"U4/plain/condition/(): result: shape")
eq(result.strides,{16},"U4/plain/condition/(): result: strides")
eq(result.dtype,"<U4","U4/plain/condition/(): result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"U4/plain/condition/(): backing source")
eq(base.shape,{3,4},"U4/plain/condition/(): backing source: shape")
eq(base.strides,{64,16},"U4/plain/condition/(): backing source: strides")
eq(base.dtype,"<U4","U4/plain/condition/(): backing source: dtype")
eq(a.shape,{3,4},"U4/plain/condition/(): source shape")
eq(a.strides,{64,16},"U4/plain/condition/(): source strides")
cases=cases+1
end
-- 306: U4/transpose/condition/(2, 3); source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"<U4")
local a=np.transpose(base)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"U4/transpose/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{"0","8","5"},"U4/transpose/condition/(2, 3): result")
eq(result.shape,{3},"U4/transpose/condition/(2, 3): result: shape")
eq(result.strides,{16},"U4/transpose/condition/(2, 3): result: strides")
eq(result.dtype,"<U4","U4/transpose/condition/(2, 3): result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"U4/transpose/condition/(2, 3): backing source")
eq(base.shape,{3,4},"U4/transpose/condition/(2, 3): backing source: shape")
eq(base.strides,{64,16},"U4/transpose/condition/(2, 3): backing source: strides")
eq(base.dtype,"<U4","U4/transpose/condition/(2, 3): backing source: dtype")
eq(a.shape,{4,3},"U4/transpose/condition/(2, 3): source shape")
eq(a.strides,{16,64},"U4/transpose/condition/(2, 3): source strides")
cases=cases+1
end
-- 307: U4/transpose/condition/(12,); source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"<U4")
local a=np.transpose(base)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"U4/transpose/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{"0","8","5","2","10","7"},"U4/transpose/condition/(12,): result")
eq(result.shape,{6},"U4/transpose/condition/(12,): result: shape")
eq(result.strides,{16},"U4/transpose/condition/(12,): result: strides")
eq(result.dtype,"<U4","U4/transpose/condition/(12,): result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"U4/transpose/condition/(12,): backing source")
eq(base.shape,{3,4},"U4/transpose/condition/(12,): backing source: shape")
eq(base.strides,{64,16},"U4/transpose/condition/(12,): backing source: strides")
eq(base.dtype,"<U4","U4/transpose/condition/(12,): backing source: dtype")
eq(a.shape,{4,3},"U4/transpose/condition/(12,): source shape")
eq(a.strides,{16,64},"U4/transpose/condition/(12,): source strides")
cases=cases+1
end
-- 308: U4/transpose/condition/(14,); source error=IndexError
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"<U4")
local a=np.transpose(base)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"U4/transpose/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"U4/transpose/condition/(14,): backing source")
eq(base.shape,{3,4},"U4/transpose/condition/(14,): backing source: shape")
eq(base.strides,{64,16},"U4/transpose/condition/(14,): backing source: strides")
eq(base.dtype,"<U4","U4/transpose/condition/(14,): backing source: dtype")
eq(a.shape,{4,3},"U4/transpose/condition/(14,): source shape")
eq(a.strides,{16,64},"U4/transpose/condition/(14,): source strides")
cases=cases+1
end
-- 309: U4/transpose/condition/(0,); source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"<U4")
local a=np.transpose(base)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"U4/transpose/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"U4/transpose/condition/(0,): result")
eq(result.shape,{0},"U4/transpose/condition/(0,): result: shape")
eq(result.strides,{0},"U4/transpose/condition/(0,): result: strides")
eq(result.dtype,"<U4","U4/transpose/condition/(0,): result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"U4/transpose/condition/(0,): backing source")
eq(base.shape,{3,4},"U4/transpose/condition/(0,): backing source: shape")
eq(base.strides,{64,16},"U4/transpose/condition/(0,): backing source: strides")
eq(base.dtype,"<U4","U4/transpose/condition/(0,): backing source: dtype")
eq(a.shape,{4,3},"U4/transpose/condition/(0,): source shape")
eq(a.strides,{16,64},"U4/transpose/condition/(0,): source strides")
cases=cases+1
end
-- 310: U4/transpose/condition/(); source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"<U4")
local a=np.transpose(base)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"U4/transpose/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{"0"},"U4/transpose/condition/(): result")
eq(result.shape,{1},"U4/transpose/condition/(): result: shape")
eq(result.strides,{16},"U4/transpose/condition/(): result: strides")
eq(result.dtype,"<U4","U4/transpose/condition/(): result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"U4/transpose/condition/(): backing source")
eq(base.shape,{3,4},"U4/transpose/condition/(): backing source: shape")
eq(base.strides,{64,16},"U4/transpose/condition/(): backing source: strides")
eq(base.dtype,"<U4","U4/transpose/condition/(): backing source: dtype")
eq(a.shape,{4,3},"U4/transpose/condition/(): source shape")
eq(a.strides,{16,64},"U4/transpose/condition/(): source strides")
cases=cases+1
end
-- 311: U4/reverse_columns/condition/(2, 3); source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"<U4")
local a=np.flip(base,2)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"U4/reverse_columns/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{"3","1","7"},"U4/reverse_columns/condition/(2, 3): result")
eq(result.shape,{3},"U4/reverse_columns/condition/(2, 3): result: shape")
eq(result.strides,{16},"U4/reverse_columns/condition/(2, 3): result: strides")
eq(result.dtype,"<U4","U4/reverse_columns/condition/(2, 3): result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"U4/reverse_columns/condition/(2, 3): backing source")
eq(base.shape,{3,4},"U4/reverse_columns/condition/(2, 3): backing source: shape")
eq(base.strides,{64,16},"U4/reverse_columns/condition/(2, 3): backing source: strides")
eq(base.dtype,"<U4","U4/reverse_columns/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"U4/reverse_columns/condition/(2, 3): source shape")
eq(a.strides,{64,-16},"U4/reverse_columns/condition/(2, 3): source strides")
cases=cases+1
end
-- 312: U4/reverse_columns/condition/(12,); source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"<U4")
local a=np.flip(base,2)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"U4/reverse_columns/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{"3","1","7","5","11","9"},"U4/reverse_columns/condition/(12,): result")
eq(result.shape,{6},"U4/reverse_columns/condition/(12,): result: shape")
eq(result.strides,{16},"U4/reverse_columns/condition/(12,): result: strides")
eq(result.dtype,"<U4","U4/reverse_columns/condition/(12,): result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"U4/reverse_columns/condition/(12,): backing source")
eq(base.shape,{3,4},"U4/reverse_columns/condition/(12,): backing source: shape")
eq(base.strides,{64,16},"U4/reverse_columns/condition/(12,): backing source: strides")
eq(base.dtype,"<U4","U4/reverse_columns/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"U4/reverse_columns/condition/(12,): source shape")
eq(a.strides,{64,-16},"U4/reverse_columns/condition/(12,): source strides")
cases=cases+1
end
-- 313: U4/reverse_columns/condition/(14,); source error=IndexError
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"<U4")
local a=np.flip(base,2)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"U4/reverse_columns/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"U4/reverse_columns/condition/(14,): backing source")
eq(base.shape,{3,4},"U4/reverse_columns/condition/(14,): backing source: shape")
eq(base.strides,{64,16},"U4/reverse_columns/condition/(14,): backing source: strides")
eq(base.dtype,"<U4","U4/reverse_columns/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"U4/reverse_columns/condition/(14,): source shape")
eq(a.strides,{64,-16},"U4/reverse_columns/condition/(14,): source strides")
cases=cases+1
end
-- 314: U4/reverse_columns/condition/(0,); source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"<U4")
local a=np.flip(base,2)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"U4/reverse_columns/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"U4/reverse_columns/condition/(0,): result")
eq(result.shape,{0},"U4/reverse_columns/condition/(0,): result: shape")
eq(result.strides,{0},"U4/reverse_columns/condition/(0,): result: strides")
eq(result.dtype,"<U4","U4/reverse_columns/condition/(0,): result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"U4/reverse_columns/condition/(0,): backing source")
eq(base.shape,{3,4},"U4/reverse_columns/condition/(0,): backing source: shape")
eq(base.strides,{64,16},"U4/reverse_columns/condition/(0,): backing source: strides")
eq(base.dtype,"<U4","U4/reverse_columns/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"U4/reverse_columns/condition/(0,): source shape")
eq(a.strides,{64,-16},"U4/reverse_columns/condition/(0,): source strides")
cases=cases+1
end
-- 315: U4/reverse_columns/condition/(); source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"<U4")
local a=np.flip(base,2)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"U4/reverse_columns/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{"3"},"U4/reverse_columns/condition/(): result")
eq(result.shape,{1},"U4/reverse_columns/condition/(): result: shape")
eq(result.strides,{16},"U4/reverse_columns/condition/(): result: strides")
eq(result.dtype,"<U4","U4/reverse_columns/condition/(): result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"U4/reverse_columns/condition/(): backing source")
eq(base.shape,{3,4},"U4/reverse_columns/condition/(): backing source: shape")
eq(base.strides,{64,16},"U4/reverse_columns/condition/(): backing source: strides")
eq(base.dtype,"<U4","U4/reverse_columns/condition/(): backing source: dtype")
eq(a.shape,{3,4},"U4/reverse_columns/condition/(): source shape")
eq(a.strides,{64,-16},"U4/reverse_columns/condition/(): source strides")
cases=cases+1
end
-- 316: U4/reverse_rows/condition/(2, 3); source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"<U4")
local a=np.flip(base,1)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"U4/reverse_rows/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{"8","10","4"},"U4/reverse_rows/condition/(2, 3): result")
eq(result.shape,{3},"U4/reverse_rows/condition/(2, 3): result: shape")
eq(result.strides,{16},"U4/reverse_rows/condition/(2, 3): result: strides")
eq(result.dtype,"<U4","U4/reverse_rows/condition/(2, 3): result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"U4/reverse_rows/condition/(2, 3): backing source")
eq(base.shape,{3,4},"U4/reverse_rows/condition/(2, 3): backing source: shape")
eq(base.strides,{64,16},"U4/reverse_rows/condition/(2, 3): backing source: strides")
eq(base.dtype,"<U4","U4/reverse_rows/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"U4/reverse_rows/condition/(2, 3): source shape")
eq(a.strides,{-64,16},"U4/reverse_rows/condition/(2, 3): source strides")
cases=cases+1
end
-- 317: U4/reverse_rows/condition/(12,); source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"<U4")
local a=np.flip(base,1)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"U4/reverse_rows/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{"8","10","4","6","0","2"},"U4/reverse_rows/condition/(12,): result")
eq(result.shape,{6},"U4/reverse_rows/condition/(12,): result: shape")
eq(result.strides,{16},"U4/reverse_rows/condition/(12,): result: strides")
eq(result.dtype,"<U4","U4/reverse_rows/condition/(12,): result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"U4/reverse_rows/condition/(12,): backing source")
eq(base.shape,{3,4},"U4/reverse_rows/condition/(12,): backing source: shape")
eq(base.strides,{64,16},"U4/reverse_rows/condition/(12,): backing source: strides")
eq(base.dtype,"<U4","U4/reverse_rows/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"U4/reverse_rows/condition/(12,): source shape")
eq(a.strides,{-64,16},"U4/reverse_rows/condition/(12,): source strides")
cases=cases+1
end
-- 318: U4/reverse_rows/condition/(14,); source error=IndexError
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"<U4")
local a=np.flip(base,1)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"U4/reverse_rows/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"U4/reverse_rows/condition/(14,): backing source")
eq(base.shape,{3,4},"U4/reverse_rows/condition/(14,): backing source: shape")
eq(base.strides,{64,16},"U4/reverse_rows/condition/(14,): backing source: strides")
eq(base.dtype,"<U4","U4/reverse_rows/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"U4/reverse_rows/condition/(14,): source shape")
eq(a.strides,{-64,16},"U4/reverse_rows/condition/(14,): source strides")
cases=cases+1
end
-- 319: U4/reverse_rows/condition/(0,); source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"<U4")
local a=np.flip(base,1)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"U4/reverse_rows/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"U4/reverse_rows/condition/(0,): result")
eq(result.shape,{0},"U4/reverse_rows/condition/(0,): result: shape")
eq(result.strides,{0},"U4/reverse_rows/condition/(0,): result: strides")
eq(result.dtype,"<U4","U4/reverse_rows/condition/(0,): result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"U4/reverse_rows/condition/(0,): backing source")
eq(base.shape,{3,4},"U4/reverse_rows/condition/(0,): backing source: shape")
eq(base.strides,{64,16},"U4/reverse_rows/condition/(0,): backing source: strides")
eq(base.dtype,"<U4","U4/reverse_rows/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"U4/reverse_rows/condition/(0,): source shape")
eq(a.strides,{-64,16},"U4/reverse_rows/condition/(0,): source strides")
cases=cases+1
end
-- 320: U4/reverse_rows/condition/(); source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"<U4")
local a=np.flip(base,1)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"U4/reverse_rows/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{"8"},"U4/reverse_rows/condition/(): result")
eq(result.shape,{1},"U4/reverse_rows/condition/(): result: shape")
eq(result.strides,{16},"U4/reverse_rows/condition/(): result: strides")
eq(result.dtype,"<U4","U4/reverse_rows/condition/(): result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"U4/reverse_rows/condition/(): backing source")
eq(base.shape,{3,4},"U4/reverse_rows/condition/(): backing source: shape")
eq(base.strides,{64,16},"U4/reverse_rows/condition/(): backing source: strides")
eq(base.dtype,"<U4","U4/reverse_rows/condition/(): backing source: dtype")
eq(a.shape,{3,4},"U4/reverse_rows/condition/(): source shape")
eq(a.strides,{-64,16},"U4/reverse_rows/condition/(): source strides")
cases=cases+1
end
-- 321: U4/strided/condition/(2, 3); source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"<U4")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"U4/strided/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{"0","4","8"},"U4/strided/condition/(2, 3): result")
eq(result.shape,{3},"U4/strided/condition/(2, 3): result: shape")
eq(result.strides,{16},"U4/strided/condition/(2, 3): result: strides")
eq(result.dtype,"<U4","U4/strided/condition/(2, 3): result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"U4/strided/condition/(2, 3): backing source")
eq(base.shape,{3,4},"U4/strided/condition/(2, 3): backing source: shape")
eq(base.strides,{64,16},"U4/strided/condition/(2, 3): backing source: strides")
eq(base.dtype,"<U4","U4/strided/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,2},"U4/strided/condition/(2, 3): source shape")
eq(a.strides,{64,32},"U4/strided/condition/(2, 3): source strides")
cases=cases+1
end
-- 322: U4/strided/condition/(12,); source error=IndexError
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"<U4")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"U4/strided/condition/(12,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"U4/strided/condition/(12,): backing source")
eq(base.shape,{3,4},"U4/strided/condition/(12,): backing source: shape")
eq(base.strides,{64,16},"U4/strided/condition/(12,): backing source: strides")
eq(base.dtype,"<U4","U4/strided/condition/(12,): backing source: dtype")
eq(a.shape,{3,2},"U4/strided/condition/(12,): source shape")
eq(a.strides,{64,32},"U4/strided/condition/(12,): source strides")
cases=cases+1
end
-- 323: U4/strided/condition/(14,); source error=IndexError
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"<U4")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"U4/strided/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"U4/strided/condition/(14,): backing source")
eq(base.shape,{3,4},"U4/strided/condition/(14,): backing source: shape")
eq(base.strides,{64,16},"U4/strided/condition/(14,): backing source: strides")
eq(base.dtype,"<U4","U4/strided/condition/(14,): backing source: dtype")
eq(a.shape,{3,2},"U4/strided/condition/(14,): source shape")
eq(a.strides,{64,32},"U4/strided/condition/(14,): source strides")
cases=cases+1
end
-- 324: U4/strided/condition/(0,); source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"<U4")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"U4/strided/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"U4/strided/condition/(0,): result")
eq(result.shape,{0},"U4/strided/condition/(0,): result: shape")
eq(result.strides,{0},"U4/strided/condition/(0,): result: strides")
eq(result.dtype,"<U4","U4/strided/condition/(0,): result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"U4/strided/condition/(0,): backing source")
eq(base.shape,{3,4},"U4/strided/condition/(0,): backing source: shape")
eq(base.strides,{64,16},"U4/strided/condition/(0,): backing source: strides")
eq(base.dtype,"<U4","U4/strided/condition/(0,): backing source: dtype")
eq(a.shape,{3,2},"U4/strided/condition/(0,): source shape")
eq(a.strides,{64,32},"U4/strided/condition/(0,): source strides")
cases=cases+1
end
-- 325: U4/strided/condition/(); source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"<U4")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"U4/strided/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{"0"},"U4/strided/condition/(): result")
eq(result.shape,{1},"U4/strided/condition/(): result: shape")
eq(result.strides,{16},"U4/strided/condition/(): result: strides")
eq(result.dtype,"<U4","U4/strided/condition/(): result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"U4/strided/condition/(): backing source")
eq(base.shape,{3,4},"U4/strided/condition/(): backing source: shape")
eq(base.strides,{64,16},"U4/strided/condition/(): backing source: strides")
eq(base.dtype,"<U4","U4/strided/condition/(): backing source: dtype")
eq(a.shape,{3,2},"U4/strided/condition/(): source shape")
eq(a.strides,{64,32},"U4/strided/condition/(): source strides")
cases=cases+1
end
-- 326: S4/plain/condition/(2, 3); source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"|S4")
local a=base
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"S4/plain/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{"0","2","4"},"S4/plain/condition/(2, 3): result")
eq(result.shape,{3},"S4/plain/condition/(2, 3): result: shape")
eq(result.strides,{4},"S4/plain/condition/(2, 3): result: strides")
eq(result.dtype,"|S4","S4/plain/condition/(2, 3): result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"S4/plain/condition/(2, 3): backing source")
eq(base.shape,{3,4},"S4/plain/condition/(2, 3): backing source: shape")
eq(base.strides,{16,4},"S4/plain/condition/(2, 3): backing source: strides")
eq(base.dtype,"|S4","S4/plain/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"S4/plain/condition/(2, 3): source shape")
eq(a.strides,{16,4},"S4/plain/condition/(2, 3): source strides")
cases=cases+1
end
-- 327: S4/plain/condition/(12,); source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"|S4")
local a=base
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"S4/plain/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{"0","2","4","6","8","10"},"S4/plain/condition/(12,): result")
eq(result.shape,{6},"S4/plain/condition/(12,): result: shape")
eq(result.strides,{4},"S4/plain/condition/(12,): result: strides")
eq(result.dtype,"|S4","S4/plain/condition/(12,): result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"S4/plain/condition/(12,): backing source")
eq(base.shape,{3,4},"S4/plain/condition/(12,): backing source: shape")
eq(base.strides,{16,4},"S4/plain/condition/(12,): backing source: strides")
eq(base.dtype,"|S4","S4/plain/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"S4/plain/condition/(12,): source shape")
eq(a.strides,{16,4},"S4/plain/condition/(12,): source strides")
cases=cases+1
end
-- 328: S4/plain/condition/(14,); source error=IndexError
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"|S4")
local a=base
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"S4/plain/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"S4/plain/condition/(14,): backing source")
eq(base.shape,{3,4},"S4/plain/condition/(14,): backing source: shape")
eq(base.strides,{16,4},"S4/plain/condition/(14,): backing source: strides")
eq(base.dtype,"|S4","S4/plain/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"S4/plain/condition/(14,): source shape")
eq(a.strides,{16,4},"S4/plain/condition/(14,): source strides")
cases=cases+1
end
-- 329: S4/plain/condition/(0,); source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"|S4")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"S4/plain/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"S4/plain/condition/(0,): result")
eq(result.shape,{0},"S4/plain/condition/(0,): result: shape")
eq(result.strides,{0},"S4/plain/condition/(0,): result: strides")
eq(result.dtype,"|S4","S4/plain/condition/(0,): result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"S4/plain/condition/(0,): backing source")
eq(base.shape,{3,4},"S4/plain/condition/(0,): backing source: shape")
eq(base.strides,{16,4},"S4/plain/condition/(0,): backing source: strides")
eq(base.dtype,"|S4","S4/plain/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"S4/plain/condition/(0,): source shape")
eq(a.strides,{16,4},"S4/plain/condition/(0,): source strides")
cases=cases+1
end
-- 330: S4/plain/condition/(); source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"|S4")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"S4/plain/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{"0"},"S4/plain/condition/(): result")
eq(result.shape,{1},"S4/plain/condition/(): result: shape")
eq(result.strides,{4},"S4/plain/condition/(): result: strides")
eq(result.dtype,"|S4","S4/plain/condition/(): result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"S4/plain/condition/(): backing source")
eq(base.shape,{3,4},"S4/plain/condition/(): backing source: shape")
eq(base.strides,{16,4},"S4/plain/condition/(): backing source: strides")
eq(base.dtype,"|S4","S4/plain/condition/(): backing source: dtype")
eq(a.shape,{3,4},"S4/plain/condition/(): source shape")
eq(a.strides,{16,4},"S4/plain/condition/(): source strides")
cases=cases+1
end
-- 331: S4/transpose/condition/(2, 3); source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"|S4")
local a=np.transpose(base)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"S4/transpose/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{"0","8","5"},"S4/transpose/condition/(2, 3): result")
eq(result.shape,{3},"S4/transpose/condition/(2, 3): result: shape")
eq(result.strides,{4},"S4/transpose/condition/(2, 3): result: strides")
eq(result.dtype,"|S4","S4/transpose/condition/(2, 3): result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"S4/transpose/condition/(2, 3): backing source")
eq(base.shape,{3,4},"S4/transpose/condition/(2, 3): backing source: shape")
eq(base.strides,{16,4},"S4/transpose/condition/(2, 3): backing source: strides")
eq(base.dtype,"|S4","S4/transpose/condition/(2, 3): backing source: dtype")
eq(a.shape,{4,3},"S4/transpose/condition/(2, 3): source shape")
eq(a.strides,{4,16},"S4/transpose/condition/(2, 3): source strides")
cases=cases+1
end
-- 332: S4/transpose/condition/(12,); source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"|S4")
local a=np.transpose(base)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"S4/transpose/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{"0","8","5","2","10","7"},"S4/transpose/condition/(12,): result")
eq(result.shape,{6},"S4/transpose/condition/(12,): result: shape")
eq(result.strides,{4},"S4/transpose/condition/(12,): result: strides")
eq(result.dtype,"|S4","S4/transpose/condition/(12,): result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"S4/transpose/condition/(12,): backing source")
eq(base.shape,{3,4},"S4/transpose/condition/(12,): backing source: shape")
eq(base.strides,{16,4},"S4/transpose/condition/(12,): backing source: strides")
eq(base.dtype,"|S4","S4/transpose/condition/(12,): backing source: dtype")
eq(a.shape,{4,3},"S4/transpose/condition/(12,): source shape")
eq(a.strides,{4,16},"S4/transpose/condition/(12,): source strides")
cases=cases+1
end
-- 333: S4/transpose/condition/(14,); source error=IndexError
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"|S4")
local a=np.transpose(base)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"S4/transpose/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"S4/transpose/condition/(14,): backing source")
eq(base.shape,{3,4},"S4/transpose/condition/(14,): backing source: shape")
eq(base.strides,{16,4},"S4/transpose/condition/(14,): backing source: strides")
eq(base.dtype,"|S4","S4/transpose/condition/(14,): backing source: dtype")
eq(a.shape,{4,3},"S4/transpose/condition/(14,): source shape")
eq(a.strides,{4,16},"S4/transpose/condition/(14,): source strides")
cases=cases+1
end
-- 334: S4/transpose/condition/(0,); source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"|S4")
local a=np.transpose(base)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"S4/transpose/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"S4/transpose/condition/(0,): result")
eq(result.shape,{0},"S4/transpose/condition/(0,): result: shape")
eq(result.strides,{0},"S4/transpose/condition/(0,): result: strides")
eq(result.dtype,"|S4","S4/transpose/condition/(0,): result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"S4/transpose/condition/(0,): backing source")
eq(base.shape,{3,4},"S4/transpose/condition/(0,): backing source: shape")
eq(base.strides,{16,4},"S4/transpose/condition/(0,): backing source: strides")
eq(base.dtype,"|S4","S4/transpose/condition/(0,): backing source: dtype")
eq(a.shape,{4,3},"S4/transpose/condition/(0,): source shape")
eq(a.strides,{4,16},"S4/transpose/condition/(0,): source strides")
cases=cases+1
end
-- 335: S4/transpose/condition/(); source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"|S4")
local a=np.transpose(base)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"S4/transpose/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{"0"},"S4/transpose/condition/(): result")
eq(result.shape,{1},"S4/transpose/condition/(): result: shape")
eq(result.strides,{4},"S4/transpose/condition/(): result: strides")
eq(result.dtype,"|S4","S4/transpose/condition/(): result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"S4/transpose/condition/(): backing source")
eq(base.shape,{3,4},"S4/transpose/condition/(): backing source: shape")
eq(base.strides,{16,4},"S4/transpose/condition/(): backing source: strides")
eq(base.dtype,"|S4","S4/transpose/condition/(): backing source: dtype")
eq(a.shape,{4,3},"S4/transpose/condition/(): source shape")
eq(a.strides,{4,16},"S4/transpose/condition/(): source strides")
cases=cases+1
end
-- 336: S4/reverse_columns/condition/(2, 3); source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"|S4")
local a=np.flip(base,2)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"S4/reverse_columns/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{"3","1","7"},"S4/reverse_columns/condition/(2, 3): result")
eq(result.shape,{3},"S4/reverse_columns/condition/(2, 3): result: shape")
eq(result.strides,{4},"S4/reverse_columns/condition/(2, 3): result: strides")
eq(result.dtype,"|S4","S4/reverse_columns/condition/(2, 3): result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"S4/reverse_columns/condition/(2, 3): backing source")
eq(base.shape,{3,4},"S4/reverse_columns/condition/(2, 3): backing source: shape")
eq(base.strides,{16,4},"S4/reverse_columns/condition/(2, 3): backing source: strides")
eq(base.dtype,"|S4","S4/reverse_columns/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"S4/reverse_columns/condition/(2, 3): source shape")
eq(a.strides,{16,-4},"S4/reverse_columns/condition/(2, 3): source strides")
cases=cases+1
end
-- 337: S4/reverse_columns/condition/(12,); source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"|S4")
local a=np.flip(base,2)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"S4/reverse_columns/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{"3","1","7","5","11","9"},"S4/reverse_columns/condition/(12,): result")
eq(result.shape,{6},"S4/reverse_columns/condition/(12,): result: shape")
eq(result.strides,{4},"S4/reverse_columns/condition/(12,): result: strides")
eq(result.dtype,"|S4","S4/reverse_columns/condition/(12,): result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"S4/reverse_columns/condition/(12,): backing source")
eq(base.shape,{3,4},"S4/reverse_columns/condition/(12,): backing source: shape")
eq(base.strides,{16,4},"S4/reverse_columns/condition/(12,): backing source: strides")
eq(base.dtype,"|S4","S4/reverse_columns/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"S4/reverse_columns/condition/(12,): source shape")
eq(a.strides,{16,-4},"S4/reverse_columns/condition/(12,): source strides")
cases=cases+1
end
-- 338: S4/reverse_columns/condition/(14,); source error=IndexError
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"|S4")
local a=np.flip(base,2)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"S4/reverse_columns/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"S4/reverse_columns/condition/(14,): backing source")
eq(base.shape,{3,4},"S4/reverse_columns/condition/(14,): backing source: shape")
eq(base.strides,{16,4},"S4/reverse_columns/condition/(14,): backing source: strides")
eq(base.dtype,"|S4","S4/reverse_columns/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"S4/reverse_columns/condition/(14,): source shape")
eq(a.strides,{16,-4},"S4/reverse_columns/condition/(14,): source strides")
cases=cases+1
end
-- 339: S4/reverse_columns/condition/(0,); source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"|S4")
local a=np.flip(base,2)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"S4/reverse_columns/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"S4/reverse_columns/condition/(0,): result")
eq(result.shape,{0},"S4/reverse_columns/condition/(0,): result: shape")
eq(result.strides,{0},"S4/reverse_columns/condition/(0,): result: strides")
eq(result.dtype,"|S4","S4/reverse_columns/condition/(0,): result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"S4/reverse_columns/condition/(0,): backing source")
eq(base.shape,{3,4},"S4/reverse_columns/condition/(0,): backing source: shape")
eq(base.strides,{16,4},"S4/reverse_columns/condition/(0,): backing source: strides")
eq(base.dtype,"|S4","S4/reverse_columns/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"S4/reverse_columns/condition/(0,): source shape")
eq(a.strides,{16,-4},"S4/reverse_columns/condition/(0,): source strides")
cases=cases+1
end
-- 340: S4/reverse_columns/condition/(); source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"|S4")
local a=np.flip(base,2)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"S4/reverse_columns/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{"3"},"S4/reverse_columns/condition/(): result")
eq(result.shape,{1},"S4/reverse_columns/condition/(): result: shape")
eq(result.strides,{4},"S4/reverse_columns/condition/(): result: strides")
eq(result.dtype,"|S4","S4/reverse_columns/condition/(): result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"S4/reverse_columns/condition/(): backing source")
eq(base.shape,{3,4},"S4/reverse_columns/condition/(): backing source: shape")
eq(base.strides,{16,4},"S4/reverse_columns/condition/(): backing source: strides")
eq(base.dtype,"|S4","S4/reverse_columns/condition/(): backing source: dtype")
eq(a.shape,{3,4},"S4/reverse_columns/condition/(): source shape")
eq(a.strides,{16,-4},"S4/reverse_columns/condition/(): source strides")
cases=cases+1
end
-- 341: S4/reverse_rows/condition/(2, 3); source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"|S4")
local a=np.flip(base,1)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"S4/reverse_rows/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{"8","10","4"},"S4/reverse_rows/condition/(2, 3): result")
eq(result.shape,{3},"S4/reverse_rows/condition/(2, 3): result: shape")
eq(result.strides,{4},"S4/reverse_rows/condition/(2, 3): result: strides")
eq(result.dtype,"|S4","S4/reverse_rows/condition/(2, 3): result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"S4/reverse_rows/condition/(2, 3): backing source")
eq(base.shape,{3,4},"S4/reverse_rows/condition/(2, 3): backing source: shape")
eq(base.strides,{16,4},"S4/reverse_rows/condition/(2, 3): backing source: strides")
eq(base.dtype,"|S4","S4/reverse_rows/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"S4/reverse_rows/condition/(2, 3): source shape")
eq(a.strides,{-16,4},"S4/reverse_rows/condition/(2, 3): source strides")
cases=cases+1
end
-- 342: S4/reverse_rows/condition/(12,); source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"|S4")
local a=np.flip(base,1)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"S4/reverse_rows/condition/(12,): acceptance"..": "..tostring(result))
eq(result:tolist(),{"8","10","4","6","0","2"},"S4/reverse_rows/condition/(12,): result")
eq(result.shape,{6},"S4/reverse_rows/condition/(12,): result: shape")
eq(result.strides,{4},"S4/reverse_rows/condition/(12,): result: strides")
eq(result.dtype,"|S4","S4/reverse_rows/condition/(12,): result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"S4/reverse_rows/condition/(12,): backing source")
eq(base.shape,{3,4},"S4/reverse_rows/condition/(12,): backing source: shape")
eq(base.strides,{16,4},"S4/reverse_rows/condition/(12,): backing source: strides")
eq(base.dtype,"|S4","S4/reverse_rows/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"S4/reverse_rows/condition/(12,): source shape")
eq(a.strides,{-16,4},"S4/reverse_rows/condition/(12,): source strides")
cases=cases+1
end
-- 343: S4/reverse_rows/condition/(14,); source error=IndexError
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"|S4")
local a=np.flip(base,1)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"S4/reverse_rows/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"S4/reverse_rows/condition/(14,): backing source")
eq(base.shape,{3,4},"S4/reverse_rows/condition/(14,): backing source: shape")
eq(base.strides,{16,4},"S4/reverse_rows/condition/(14,): backing source: strides")
eq(base.dtype,"|S4","S4/reverse_rows/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"S4/reverse_rows/condition/(14,): source shape")
eq(a.strides,{-16,4},"S4/reverse_rows/condition/(14,): source strides")
cases=cases+1
end
-- 344: S4/reverse_rows/condition/(0,); source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"|S4")
local a=np.flip(base,1)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"S4/reverse_rows/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"S4/reverse_rows/condition/(0,): result")
eq(result.shape,{0},"S4/reverse_rows/condition/(0,): result: shape")
eq(result.strides,{0},"S4/reverse_rows/condition/(0,): result: strides")
eq(result.dtype,"|S4","S4/reverse_rows/condition/(0,): result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"S4/reverse_rows/condition/(0,): backing source")
eq(base.shape,{3,4},"S4/reverse_rows/condition/(0,): backing source: shape")
eq(base.strides,{16,4},"S4/reverse_rows/condition/(0,): backing source: strides")
eq(base.dtype,"|S4","S4/reverse_rows/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"S4/reverse_rows/condition/(0,): source shape")
eq(a.strides,{-16,4},"S4/reverse_rows/condition/(0,): source strides")
cases=cases+1
end
-- 345: S4/reverse_rows/condition/(); source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"|S4")
local a=np.flip(base,1)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"S4/reverse_rows/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{"8"},"S4/reverse_rows/condition/(): result")
eq(result.shape,{1},"S4/reverse_rows/condition/(): result: shape")
eq(result.strides,{4},"S4/reverse_rows/condition/(): result: strides")
eq(result.dtype,"|S4","S4/reverse_rows/condition/(): result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"S4/reverse_rows/condition/(): backing source")
eq(base.shape,{3,4},"S4/reverse_rows/condition/(): backing source: shape")
eq(base.strides,{16,4},"S4/reverse_rows/condition/(): backing source: strides")
eq(base.dtype,"|S4","S4/reverse_rows/condition/(): backing source: dtype")
eq(a.shape,{3,4},"S4/reverse_rows/condition/(): source shape")
eq(a.strides,{-16,4},"S4/reverse_rows/condition/(): source strides")
cases=cases+1
end
-- 346: S4/strided/condition/(2, 3); source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"|S4")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"S4/strided/condition/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{"0","4","8"},"S4/strided/condition/(2, 3): result")
eq(result.shape,{3},"S4/strided/condition/(2, 3): result: shape")
eq(result.strides,{4},"S4/strided/condition/(2, 3): result: strides")
eq(result.dtype,"|S4","S4/strided/condition/(2, 3): result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"S4/strided/condition/(2, 3): backing source")
eq(base.shape,{3,4},"S4/strided/condition/(2, 3): backing source: shape")
eq(base.strides,{16,4},"S4/strided/condition/(2, 3): backing source: strides")
eq(base.dtype,"|S4","S4/strided/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,2},"S4/strided/condition/(2, 3): source shape")
eq(a.strides,{16,8},"S4/strided/condition/(2, 3): source strides")
cases=cases+1
end
-- 347: S4/strided/condition/(12,); source error=IndexError
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"|S4")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"S4/strided/condition/(12,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"S4/strided/condition/(12,): backing source")
eq(base.shape,{3,4},"S4/strided/condition/(12,): backing source: shape")
eq(base.strides,{16,4},"S4/strided/condition/(12,): backing source: strides")
eq(base.dtype,"|S4","S4/strided/condition/(12,): backing source: dtype")
eq(a.shape,{3,2},"S4/strided/condition/(12,): source shape")
eq(a.strides,{16,8},"S4/strided/condition/(12,): source strides")
cases=cases+1
end
-- 348: S4/strided/condition/(14,); source error=IndexError
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"|S4")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"S4/strided/condition/(14,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"S4/strided/condition/(14,): backing source")
eq(base.shape,{3,4},"S4/strided/condition/(14,): backing source: shape")
eq(base.strides,{16,4},"S4/strided/condition/(14,): backing source: strides")
eq(base.dtype,"|S4","S4/strided/condition/(14,): backing source: dtype")
eq(a.shape,{3,2},"S4/strided/condition/(14,): source shape")
eq(a.strides,{16,8},"S4/strided/condition/(14,): source strides")
cases=cases+1
end
-- 349: S4/strided/condition/(0,); source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"|S4")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"S4/strided/condition/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"S4/strided/condition/(0,): result")
eq(result.shape,{0},"S4/strided/condition/(0,): result: shape")
eq(result.strides,{0},"S4/strided/condition/(0,): result: strides")
eq(result.dtype,"|S4","S4/strided/condition/(0,): result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"S4/strided/condition/(0,): backing source")
eq(base.shape,{3,4},"S4/strided/condition/(0,): backing source: shape")
eq(base.strides,{16,4},"S4/strided/condition/(0,): backing source: strides")
eq(base.dtype,"|S4","S4/strided/condition/(0,): backing source: dtype")
eq(a.shape,{3,2},"S4/strided/condition/(0,): source shape")
eq(a.strides,{16,8},"S4/strided/condition/(0,): source strides")
cases=cases+1
end
-- 350: S4/strided/condition/(); source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"|S4")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"S4/strided/condition/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{"0"},"S4/strided/condition/(): result")
eq(result.shape,{1},"S4/strided/condition/(): result: shape")
eq(result.strides,{4},"S4/strided/condition/(): result: strides")
eq(result.dtype,"|S4","S4/strided/condition/(): result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"S4/strided/condition/(): backing source")
eq(base.shape,{3,4},"S4/strided/condition/(): backing source: shape")
eq(base.strides,{16,4},"S4/strided/condition/(): backing source: strides")
eq(base.dtype,"|S4","S4/strided/condition/(): backing source: dtype")
eq(a.shape,{3,2},"S4/strided/condition/(): source shape")
eq(a.strides,{16,8},"S4/strided/condition/(): source strides")
cases=cases+1
end
-- 351: datetime64[D]/plain/condition/(2, 3); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]")
local a=base
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"datetime64[D]/plain/condition/(2, 3): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0,2,4},"datetime64[D]/plain/condition/(2, 3): result")
eq(result.shape,{3},"datetime64[D]/plain/condition/(2, 3): result: shape")
eq(result.strides,{8},"datetime64[D]/plain/condition/(2, 3): result: strides")
eq(result.dtype,"datetime64[D]","datetime64[D]/plain/condition/(2, 3): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]/plain/condition/(2, 3): backing source")
eq(base.shape,{3,4},"datetime64[D]/plain/condition/(2, 3): backing source: shape")
eq(base.strides,{32,8},"datetime64[D]/plain/condition/(2, 3): backing source: strides")
eq(base.dtype,"datetime64[D]","datetime64[D]/plain/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"datetime64[D]/plain/condition/(2, 3): source shape")
eq(a.strides,{32,8},"datetime64[D]/plain/condition/(2, 3): source strides")
cases=cases+1
end
-- 352: datetime64[D]/plain/condition/(12,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]")
local a=base
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"datetime64[D]/plain/condition/(12,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0,2,4,6,8,10},"datetime64[D]/plain/condition/(12,): result")
eq(result.shape,{6},"datetime64[D]/plain/condition/(12,): result: shape")
eq(result.strides,{8},"datetime64[D]/plain/condition/(12,): result: strides")
eq(result.dtype,"datetime64[D]","datetime64[D]/plain/condition/(12,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]/plain/condition/(12,): backing source")
eq(base.shape,{3,4},"datetime64[D]/plain/condition/(12,): backing source: shape")
eq(base.strides,{32,8},"datetime64[D]/plain/condition/(12,): backing source: strides")
eq(base.dtype,"datetime64[D]","datetime64[D]/plain/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"datetime64[D]/plain/condition/(12,): source shape")
eq(a.strides,{32,8},"datetime64[D]/plain/condition/(12,): source strides")
cases=cases+1
end
-- 353: datetime64[D]/plain/condition/(14,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]")
local a=base
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"datetime64[D]/plain/condition/(14,): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]/plain/condition/(14,): backing source")
eq(base.shape,{3,4},"datetime64[D]/plain/condition/(14,): backing source: shape")
eq(base.strides,{32,8},"datetime64[D]/plain/condition/(14,): backing source: strides")
eq(base.dtype,"datetime64[D]","datetime64[D]/plain/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"datetime64[D]/plain/condition/(14,): source shape")
eq(a.strides,{32,8},"datetime64[D]/plain/condition/(14,): source strides")
cases=cases+1
end
-- 354: datetime64[D]/plain/condition/(0,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"datetime64[D]/plain/condition/(0,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{},"datetime64[D]/plain/condition/(0,): result")
eq(result.shape,{0},"datetime64[D]/plain/condition/(0,): result: shape")
eq(result.strides,{0},"datetime64[D]/plain/condition/(0,): result: strides")
eq(result.dtype,"datetime64[D]","datetime64[D]/plain/condition/(0,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]/plain/condition/(0,): backing source")
eq(base.shape,{3,4},"datetime64[D]/plain/condition/(0,): backing source: shape")
eq(base.strides,{32,8},"datetime64[D]/plain/condition/(0,): backing source: strides")
eq(base.dtype,"datetime64[D]","datetime64[D]/plain/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"datetime64[D]/plain/condition/(0,): source shape")
eq(a.strides,{32,8},"datetime64[D]/plain/condition/(0,): source strides")
cases=cases+1
end
-- 355: datetime64[D]/plain/condition/(); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"datetime64[D]/plain/condition/(): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0},"datetime64[D]/plain/condition/(): result")
eq(result.shape,{1},"datetime64[D]/plain/condition/(): result: shape")
eq(result.strides,{8},"datetime64[D]/plain/condition/(): result: strides")
eq(result.dtype,"datetime64[D]","datetime64[D]/plain/condition/(): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]/plain/condition/(): backing source")
eq(base.shape,{3,4},"datetime64[D]/plain/condition/(): backing source: shape")
eq(base.strides,{32,8},"datetime64[D]/plain/condition/(): backing source: strides")
eq(base.dtype,"datetime64[D]","datetime64[D]/plain/condition/(): backing source: dtype")
eq(a.shape,{3,4},"datetime64[D]/plain/condition/(): source shape")
eq(a.strides,{32,8},"datetime64[D]/plain/condition/(): source strides")
cases=cases+1
end
-- 356: datetime64[D]/transpose/condition/(2, 3); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]")
local a=np.transpose(base)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"datetime64[D]/transpose/condition/(2, 3): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0,8,5},"datetime64[D]/transpose/condition/(2, 3): result")
eq(result.shape,{3},"datetime64[D]/transpose/condition/(2, 3): result: shape")
eq(result.strides,{8},"datetime64[D]/transpose/condition/(2, 3): result: strides")
eq(result.dtype,"datetime64[D]","datetime64[D]/transpose/condition/(2, 3): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]/transpose/condition/(2, 3): backing source")
eq(base.shape,{3,4},"datetime64[D]/transpose/condition/(2, 3): backing source: shape")
eq(base.strides,{32,8},"datetime64[D]/transpose/condition/(2, 3): backing source: strides")
eq(base.dtype,"datetime64[D]","datetime64[D]/transpose/condition/(2, 3): backing source: dtype")
eq(a.shape,{4,3},"datetime64[D]/transpose/condition/(2, 3): source shape")
eq(a.strides,{8,32},"datetime64[D]/transpose/condition/(2, 3): source strides")
cases=cases+1
end
-- 357: datetime64[D]/transpose/condition/(12,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]")
local a=np.transpose(base)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"datetime64[D]/transpose/condition/(12,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0,8,5,2,10,7},"datetime64[D]/transpose/condition/(12,): result")
eq(result.shape,{6},"datetime64[D]/transpose/condition/(12,): result: shape")
eq(result.strides,{8},"datetime64[D]/transpose/condition/(12,): result: strides")
eq(result.dtype,"datetime64[D]","datetime64[D]/transpose/condition/(12,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]/transpose/condition/(12,): backing source")
eq(base.shape,{3,4},"datetime64[D]/transpose/condition/(12,): backing source: shape")
eq(base.strides,{32,8},"datetime64[D]/transpose/condition/(12,): backing source: strides")
eq(base.dtype,"datetime64[D]","datetime64[D]/transpose/condition/(12,): backing source: dtype")
eq(a.shape,{4,3},"datetime64[D]/transpose/condition/(12,): source shape")
eq(a.strides,{8,32},"datetime64[D]/transpose/condition/(12,): source strides")
cases=cases+1
end
-- 358: datetime64[D]/transpose/condition/(14,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]")
local a=np.transpose(base)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"datetime64[D]/transpose/condition/(14,): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]/transpose/condition/(14,): backing source")
eq(base.shape,{3,4},"datetime64[D]/transpose/condition/(14,): backing source: shape")
eq(base.strides,{32,8},"datetime64[D]/transpose/condition/(14,): backing source: strides")
eq(base.dtype,"datetime64[D]","datetime64[D]/transpose/condition/(14,): backing source: dtype")
eq(a.shape,{4,3},"datetime64[D]/transpose/condition/(14,): source shape")
eq(a.strides,{8,32},"datetime64[D]/transpose/condition/(14,): source strides")
cases=cases+1
end
-- 359: datetime64[D]/transpose/condition/(0,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]")
local a=np.transpose(base)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"datetime64[D]/transpose/condition/(0,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{},"datetime64[D]/transpose/condition/(0,): result")
eq(result.shape,{0},"datetime64[D]/transpose/condition/(0,): result: shape")
eq(result.strides,{0},"datetime64[D]/transpose/condition/(0,): result: strides")
eq(result.dtype,"datetime64[D]","datetime64[D]/transpose/condition/(0,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]/transpose/condition/(0,): backing source")
eq(base.shape,{3,4},"datetime64[D]/transpose/condition/(0,): backing source: shape")
eq(base.strides,{32,8},"datetime64[D]/transpose/condition/(0,): backing source: strides")
eq(base.dtype,"datetime64[D]","datetime64[D]/transpose/condition/(0,): backing source: dtype")
eq(a.shape,{4,3},"datetime64[D]/transpose/condition/(0,): source shape")
eq(a.strides,{8,32},"datetime64[D]/transpose/condition/(0,): source strides")
cases=cases+1
end
-- 360: datetime64[D]/transpose/condition/(); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]")
local a=np.transpose(base)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"datetime64[D]/transpose/condition/(): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0},"datetime64[D]/transpose/condition/(): result")
eq(result.shape,{1},"datetime64[D]/transpose/condition/(): result: shape")
eq(result.strides,{8},"datetime64[D]/transpose/condition/(): result: strides")
eq(result.dtype,"datetime64[D]","datetime64[D]/transpose/condition/(): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]/transpose/condition/(): backing source")
eq(base.shape,{3,4},"datetime64[D]/transpose/condition/(): backing source: shape")
eq(base.strides,{32,8},"datetime64[D]/transpose/condition/(): backing source: strides")
eq(base.dtype,"datetime64[D]","datetime64[D]/transpose/condition/(): backing source: dtype")
eq(a.shape,{4,3},"datetime64[D]/transpose/condition/(): source shape")
eq(a.strides,{8,32},"datetime64[D]/transpose/condition/(): source strides")
cases=cases+1
end
-- 361: datetime64[D]/reverse_columns/condition/(2, 3); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]")
local a=np.flip(base,2)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"datetime64[D]/reverse_columns/condition/(2, 3): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{3,1,7},"datetime64[D]/reverse_columns/condition/(2, 3): result")
eq(result.shape,{3},"datetime64[D]/reverse_columns/condition/(2, 3): result: shape")
eq(result.strides,{8},"datetime64[D]/reverse_columns/condition/(2, 3): result: strides")
eq(result.dtype,"datetime64[D]","datetime64[D]/reverse_columns/condition/(2, 3): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]/reverse_columns/condition/(2, 3): backing source")
eq(base.shape,{3,4},"datetime64[D]/reverse_columns/condition/(2, 3): backing source: shape")
eq(base.strides,{32,8},"datetime64[D]/reverse_columns/condition/(2, 3): backing source: strides")
eq(base.dtype,"datetime64[D]","datetime64[D]/reverse_columns/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"datetime64[D]/reverse_columns/condition/(2, 3): source shape")
eq(a.strides,{32,-8},"datetime64[D]/reverse_columns/condition/(2, 3): source strides")
cases=cases+1
end
-- 362: datetime64[D]/reverse_columns/condition/(12,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]")
local a=np.flip(base,2)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"datetime64[D]/reverse_columns/condition/(12,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{3,1,7,5,11,9},"datetime64[D]/reverse_columns/condition/(12,): result")
eq(result.shape,{6},"datetime64[D]/reverse_columns/condition/(12,): result: shape")
eq(result.strides,{8},"datetime64[D]/reverse_columns/condition/(12,): result: strides")
eq(result.dtype,"datetime64[D]","datetime64[D]/reverse_columns/condition/(12,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]/reverse_columns/condition/(12,): backing source")
eq(base.shape,{3,4},"datetime64[D]/reverse_columns/condition/(12,): backing source: shape")
eq(base.strides,{32,8},"datetime64[D]/reverse_columns/condition/(12,): backing source: strides")
eq(base.dtype,"datetime64[D]","datetime64[D]/reverse_columns/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"datetime64[D]/reverse_columns/condition/(12,): source shape")
eq(a.strides,{32,-8},"datetime64[D]/reverse_columns/condition/(12,): source strides")
cases=cases+1
end
-- 363: datetime64[D]/reverse_columns/condition/(14,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]")
local a=np.flip(base,2)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"datetime64[D]/reverse_columns/condition/(14,): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]/reverse_columns/condition/(14,): backing source")
eq(base.shape,{3,4},"datetime64[D]/reverse_columns/condition/(14,): backing source: shape")
eq(base.strides,{32,8},"datetime64[D]/reverse_columns/condition/(14,): backing source: strides")
eq(base.dtype,"datetime64[D]","datetime64[D]/reverse_columns/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"datetime64[D]/reverse_columns/condition/(14,): source shape")
eq(a.strides,{32,-8},"datetime64[D]/reverse_columns/condition/(14,): source strides")
cases=cases+1
end
-- 364: datetime64[D]/reverse_columns/condition/(0,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]")
local a=np.flip(base,2)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"datetime64[D]/reverse_columns/condition/(0,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{},"datetime64[D]/reverse_columns/condition/(0,): result")
eq(result.shape,{0},"datetime64[D]/reverse_columns/condition/(0,): result: shape")
eq(result.strides,{0},"datetime64[D]/reverse_columns/condition/(0,): result: strides")
eq(result.dtype,"datetime64[D]","datetime64[D]/reverse_columns/condition/(0,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]/reverse_columns/condition/(0,): backing source")
eq(base.shape,{3,4},"datetime64[D]/reverse_columns/condition/(0,): backing source: shape")
eq(base.strides,{32,8},"datetime64[D]/reverse_columns/condition/(0,): backing source: strides")
eq(base.dtype,"datetime64[D]","datetime64[D]/reverse_columns/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"datetime64[D]/reverse_columns/condition/(0,): source shape")
eq(a.strides,{32,-8},"datetime64[D]/reverse_columns/condition/(0,): source strides")
cases=cases+1
end
-- 365: datetime64[D]/reverse_columns/condition/(); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]")
local a=np.flip(base,2)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"datetime64[D]/reverse_columns/condition/(): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{3},"datetime64[D]/reverse_columns/condition/(): result")
eq(result.shape,{1},"datetime64[D]/reverse_columns/condition/(): result: shape")
eq(result.strides,{8},"datetime64[D]/reverse_columns/condition/(): result: strides")
eq(result.dtype,"datetime64[D]","datetime64[D]/reverse_columns/condition/(): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]/reverse_columns/condition/(): backing source")
eq(base.shape,{3,4},"datetime64[D]/reverse_columns/condition/(): backing source: shape")
eq(base.strides,{32,8},"datetime64[D]/reverse_columns/condition/(): backing source: strides")
eq(base.dtype,"datetime64[D]","datetime64[D]/reverse_columns/condition/(): backing source: dtype")
eq(a.shape,{3,4},"datetime64[D]/reverse_columns/condition/(): source shape")
eq(a.strides,{32,-8},"datetime64[D]/reverse_columns/condition/(): source strides")
cases=cases+1
end
-- 366: datetime64[D]/reverse_rows/condition/(2, 3); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]")
local a=np.flip(base,1)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"datetime64[D]/reverse_rows/condition/(2, 3): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{8,10,4},"datetime64[D]/reverse_rows/condition/(2, 3): result")
eq(result.shape,{3},"datetime64[D]/reverse_rows/condition/(2, 3): result: shape")
eq(result.strides,{8},"datetime64[D]/reverse_rows/condition/(2, 3): result: strides")
eq(result.dtype,"datetime64[D]","datetime64[D]/reverse_rows/condition/(2, 3): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]/reverse_rows/condition/(2, 3): backing source")
eq(base.shape,{3,4},"datetime64[D]/reverse_rows/condition/(2, 3): backing source: shape")
eq(base.strides,{32,8},"datetime64[D]/reverse_rows/condition/(2, 3): backing source: strides")
eq(base.dtype,"datetime64[D]","datetime64[D]/reverse_rows/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"datetime64[D]/reverse_rows/condition/(2, 3): source shape")
eq(a.strides,{-32,8},"datetime64[D]/reverse_rows/condition/(2, 3): source strides")
cases=cases+1
end
-- 367: datetime64[D]/reverse_rows/condition/(12,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]")
local a=np.flip(base,1)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"datetime64[D]/reverse_rows/condition/(12,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{8,10,4,6,0,2},"datetime64[D]/reverse_rows/condition/(12,): result")
eq(result.shape,{6},"datetime64[D]/reverse_rows/condition/(12,): result: shape")
eq(result.strides,{8},"datetime64[D]/reverse_rows/condition/(12,): result: strides")
eq(result.dtype,"datetime64[D]","datetime64[D]/reverse_rows/condition/(12,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]/reverse_rows/condition/(12,): backing source")
eq(base.shape,{3,4},"datetime64[D]/reverse_rows/condition/(12,): backing source: shape")
eq(base.strides,{32,8},"datetime64[D]/reverse_rows/condition/(12,): backing source: strides")
eq(base.dtype,"datetime64[D]","datetime64[D]/reverse_rows/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"datetime64[D]/reverse_rows/condition/(12,): source shape")
eq(a.strides,{-32,8},"datetime64[D]/reverse_rows/condition/(12,): source strides")
cases=cases+1
end
-- 368: datetime64[D]/reverse_rows/condition/(14,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]")
local a=np.flip(base,1)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"datetime64[D]/reverse_rows/condition/(14,): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]/reverse_rows/condition/(14,): backing source")
eq(base.shape,{3,4},"datetime64[D]/reverse_rows/condition/(14,): backing source: shape")
eq(base.strides,{32,8},"datetime64[D]/reverse_rows/condition/(14,): backing source: strides")
eq(base.dtype,"datetime64[D]","datetime64[D]/reverse_rows/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"datetime64[D]/reverse_rows/condition/(14,): source shape")
eq(a.strides,{-32,8},"datetime64[D]/reverse_rows/condition/(14,): source strides")
cases=cases+1
end
-- 369: datetime64[D]/reverse_rows/condition/(0,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]")
local a=np.flip(base,1)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"datetime64[D]/reverse_rows/condition/(0,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{},"datetime64[D]/reverse_rows/condition/(0,): result")
eq(result.shape,{0},"datetime64[D]/reverse_rows/condition/(0,): result: shape")
eq(result.strides,{0},"datetime64[D]/reverse_rows/condition/(0,): result: strides")
eq(result.dtype,"datetime64[D]","datetime64[D]/reverse_rows/condition/(0,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]/reverse_rows/condition/(0,): backing source")
eq(base.shape,{3,4},"datetime64[D]/reverse_rows/condition/(0,): backing source: shape")
eq(base.strides,{32,8},"datetime64[D]/reverse_rows/condition/(0,): backing source: strides")
eq(base.dtype,"datetime64[D]","datetime64[D]/reverse_rows/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"datetime64[D]/reverse_rows/condition/(0,): source shape")
eq(a.strides,{-32,8},"datetime64[D]/reverse_rows/condition/(0,): source strides")
cases=cases+1
end
-- 370: datetime64[D]/reverse_rows/condition/(); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]")
local a=np.flip(base,1)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"datetime64[D]/reverse_rows/condition/(): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{8},"datetime64[D]/reverse_rows/condition/(): result")
eq(result.shape,{1},"datetime64[D]/reverse_rows/condition/(): result: shape")
eq(result.strides,{8},"datetime64[D]/reverse_rows/condition/(): result: strides")
eq(result.dtype,"datetime64[D]","datetime64[D]/reverse_rows/condition/(): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]/reverse_rows/condition/(): backing source")
eq(base.shape,{3,4},"datetime64[D]/reverse_rows/condition/(): backing source: shape")
eq(base.strides,{32,8},"datetime64[D]/reverse_rows/condition/(): backing source: strides")
eq(base.dtype,"datetime64[D]","datetime64[D]/reverse_rows/condition/(): backing source: dtype")
eq(a.shape,{3,4},"datetime64[D]/reverse_rows/condition/(): source shape")
eq(a.strides,{-32,8},"datetime64[D]/reverse_rows/condition/(): source strides")
cases=cases+1
end
-- 371: datetime64[D]/strided/condition/(2, 3); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"datetime64[D]/strided/condition/(2, 3): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0,4,8},"datetime64[D]/strided/condition/(2, 3): result")
eq(result.shape,{3},"datetime64[D]/strided/condition/(2, 3): result: shape")
eq(result.strides,{8},"datetime64[D]/strided/condition/(2, 3): result: strides")
eq(result.dtype,"datetime64[D]","datetime64[D]/strided/condition/(2, 3): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]/strided/condition/(2, 3): backing source")
eq(base.shape,{3,4},"datetime64[D]/strided/condition/(2, 3): backing source: shape")
eq(base.strides,{32,8},"datetime64[D]/strided/condition/(2, 3): backing source: strides")
eq(base.dtype,"datetime64[D]","datetime64[D]/strided/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,2},"datetime64[D]/strided/condition/(2, 3): source shape")
eq(a.strides,{32,16},"datetime64[D]/strided/condition/(2, 3): source strides")
cases=cases+1
end
-- 372: datetime64[D]/strided/condition/(12,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"datetime64[D]/strided/condition/(12,): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]/strided/condition/(12,): backing source")
eq(base.shape,{3,4},"datetime64[D]/strided/condition/(12,): backing source: shape")
eq(base.strides,{32,8},"datetime64[D]/strided/condition/(12,): backing source: strides")
eq(base.dtype,"datetime64[D]","datetime64[D]/strided/condition/(12,): backing source: dtype")
eq(a.shape,{3,2},"datetime64[D]/strided/condition/(12,): source shape")
eq(a.strides,{32,16},"datetime64[D]/strided/condition/(12,): source strides")
cases=cases+1
end
-- 373: datetime64[D]/strided/condition/(14,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"datetime64[D]/strided/condition/(14,): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]/strided/condition/(14,): backing source")
eq(base.shape,{3,4},"datetime64[D]/strided/condition/(14,): backing source: shape")
eq(base.strides,{32,8},"datetime64[D]/strided/condition/(14,): backing source: strides")
eq(base.dtype,"datetime64[D]","datetime64[D]/strided/condition/(14,): backing source: dtype")
eq(a.shape,{3,2},"datetime64[D]/strided/condition/(14,): source shape")
eq(a.strides,{32,16},"datetime64[D]/strided/condition/(14,): source strides")
cases=cases+1
end
-- 374: datetime64[D]/strided/condition/(0,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"datetime64[D]/strided/condition/(0,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{},"datetime64[D]/strided/condition/(0,): result")
eq(result.shape,{0},"datetime64[D]/strided/condition/(0,): result: shape")
eq(result.strides,{0},"datetime64[D]/strided/condition/(0,): result: strides")
eq(result.dtype,"datetime64[D]","datetime64[D]/strided/condition/(0,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]/strided/condition/(0,): backing source")
eq(base.shape,{3,4},"datetime64[D]/strided/condition/(0,): backing source: shape")
eq(base.strides,{32,8},"datetime64[D]/strided/condition/(0,): backing source: strides")
eq(base.dtype,"datetime64[D]","datetime64[D]/strided/condition/(0,): backing source: dtype")
eq(a.shape,{3,2},"datetime64[D]/strided/condition/(0,): source shape")
eq(a.strides,{32,16},"datetime64[D]/strided/condition/(0,): source strides")
cases=cases+1
end
-- 375: datetime64[D]/strided/condition/(); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"datetime64[D]/strided/condition/(): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0},"datetime64[D]/strided/condition/(): result")
eq(result.shape,{1},"datetime64[D]/strided/condition/(): result: shape")
eq(result.strides,{8},"datetime64[D]/strided/condition/(): result: strides")
eq(result.dtype,"datetime64[D]","datetime64[D]/strided/condition/(): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]/strided/condition/(): backing source")
eq(base.shape,{3,4},"datetime64[D]/strided/condition/(): backing source: shape")
eq(base.strides,{32,8},"datetime64[D]/strided/condition/(): backing source: strides")
eq(base.dtype,"datetime64[D]","datetime64[D]/strided/condition/(): backing source: dtype")
eq(a.shape,{3,2},"datetime64[D]/strided/condition/(): source shape")
eq(a.strides,{32,16},"datetime64[D]/strided/condition/(): source strides")
cases=cases+1
end
-- 376: timedelta64[h]/plain/condition/(2, 3); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]")
local a=base
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"timedelta64[h]/plain/condition/(2, 3): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0,2,4},"timedelta64[h]/plain/condition/(2, 3): result")
eq(result.shape,{3},"timedelta64[h]/plain/condition/(2, 3): result: shape")
eq(result.strides,{8},"timedelta64[h]/plain/condition/(2, 3): result: strides")
eq(result.dtype,"timedelta64[h]","timedelta64[h]/plain/condition/(2, 3): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]/plain/condition/(2, 3): backing source")
eq(base.shape,{3,4},"timedelta64[h]/plain/condition/(2, 3): backing source: shape")
eq(base.strides,{32,8},"timedelta64[h]/plain/condition/(2, 3): backing source: strides")
eq(base.dtype,"timedelta64[h]","timedelta64[h]/plain/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"timedelta64[h]/plain/condition/(2, 3): source shape")
eq(a.strides,{32,8},"timedelta64[h]/plain/condition/(2, 3): source strides")
cases=cases+1
end
-- 377: timedelta64[h]/plain/condition/(12,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]")
local a=base
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"timedelta64[h]/plain/condition/(12,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0,2,4,6,8,10},"timedelta64[h]/plain/condition/(12,): result")
eq(result.shape,{6},"timedelta64[h]/plain/condition/(12,): result: shape")
eq(result.strides,{8},"timedelta64[h]/plain/condition/(12,): result: strides")
eq(result.dtype,"timedelta64[h]","timedelta64[h]/plain/condition/(12,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]/plain/condition/(12,): backing source")
eq(base.shape,{3,4},"timedelta64[h]/plain/condition/(12,): backing source: shape")
eq(base.strides,{32,8},"timedelta64[h]/plain/condition/(12,): backing source: strides")
eq(base.dtype,"timedelta64[h]","timedelta64[h]/plain/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"timedelta64[h]/plain/condition/(12,): source shape")
eq(a.strides,{32,8},"timedelta64[h]/plain/condition/(12,): source strides")
cases=cases+1
end
-- 378: timedelta64[h]/plain/condition/(14,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]")
local a=base
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"timedelta64[h]/plain/condition/(14,): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]/plain/condition/(14,): backing source")
eq(base.shape,{3,4},"timedelta64[h]/plain/condition/(14,): backing source: shape")
eq(base.strides,{32,8},"timedelta64[h]/plain/condition/(14,): backing source: strides")
eq(base.dtype,"timedelta64[h]","timedelta64[h]/plain/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"timedelta64[h]/plain/condition/(14,): source shape")
eq(a.strides,{32,8},"timedelta64[h]/plain/condition/(14,): source strides")
cases=cases+1
end
-- 379: timedelta64[h]/plain/condition/(0,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"timedelta64[h]/plain/condition/(0,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{},"timedelta64[h]/plain/condition/(0,): result")
eq(result.shape,{0},"timedelta64[h]/plain/condition/(0,): result: shape")
eq(result.strides,{0},"timedelta64[h]/plain/condition/(0,): result: strides")
eq(result.dtype,"timedelta64[h]","timedelta64[h]/plain/condition/(0,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]/plain/condition/(0,): backing source")
eq(base.shape,{3,4},"timedelta64[h]/plain/condition/(0,): backing source: shape")
eq(base.strides,{32,8},"timedelta64[h]/plain/condition/(0,): backing source: strides")
eq(base.dtype,"timedelta64[h]","timedelta64[h]/plain/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"timedelta64[h]/plain/condition/(0,): source shape")
eq(a.strides,{32,8},"timedelta64[h]/plain/condition/(0,): source strides")
cases=cases+1
end
-- 380: timedelta64[h]/plain/condition/(); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"timedelta64[h]/plain/condition/(): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0},"timedelta64[h]/plain/condition/(): result")
eq(result.shape,{1},"timedelta64[h]/plain/condition/(): result: shape")
eq(result.strides,{8},"timedelta64[h]/plain/condition/(): result: strides")
eq(result.dtype,"timedelta64[h]","timedelta64[h]/plain/condition/(): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]/plain/condition/(): backing source")
eq(base.shape,{3,4},"timedelta64[h]/plain/condition/(): backing source: shape")
eq(base.strides,{32,8},"timedelta64[h]/plain/condition/(): backing source: strides")
eq(base.dtype,"timedelta64[h]","timedelta64[h]/plain/condition/(): backing source: dtype")
eq(a.shape,{3,4},"timedelta64[h]/plain/condition/(): source shape")
eq(a.strides,{32,8},"timedelta64[h]/plain/condition/(): source strides")
cases=cases+1
end
-- 381: timedelta64[h]/transpose/condition/(2, 3); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]")
local a=np.transpose(base)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"timedelta64[h]/transpose/condition/(2, 3): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0,8,5},"timedelta64[h]/transpose/condition/(2, 3): result")
eq(result.shape,{3},"timedelta64[h]/transpose/condition/(2, 3): result: shape")
eq(result.strides,{8},"timedelta64[h]/transpose/condition/(2, 3): result: strides")
eq(result.dtype,"timedelta64[h]","timedelta64[h]/transpose/condition/(2, 3): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]/transpose/condition/(2, 3): backing source")
eq(base.shape,{3,4},"timedelta64[h]/transpose/condition/(2, 3): backing source: shape")
eq(base.strides,{32,8},"timedelta64[h]/transpose/condition/(2, 3): backing source: strides")
eq(base.dtype,"timedelta64[h]","timedelta64[h]/transpose/condition/(2, 3): backing source: dtype")
eq(a.shape,{4,3},"timedelta64[h]/transpose/condition/(2, 3): source shape")
eq(a.strides,{8,32},"timedelta64[h]/transpose/condition/(2, 3): source strides")
cases=cases+1
end
-- 382: timedelta64[h]/transpose/condition/(12,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]")
local a=np.transpose(base)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"timedelta64[h]/transpose/condition/(12,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0,8,5,2,10,7},"timedelta64[h]/transpose/condition/(12,): result")
eq(result.shape,{6},"timedelta64[h]/transpose/condition/(12,): result: shape")
eq(result.strides,{8},"timedelta64[h]/transpose/condition/(12,): result: strides")
eq(result.dtype,"timedelta64[h]","timedelta64[h]/transpose/condition/(12,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]/transpose/condition/(12,): backing source")
eq(base.shape,{3,4},"timedelta64[h]/transpose/condition/(12,): backing source: shape")
eq(base.strides,{32,8},"timedelta64[h]/transpose/condition/(12,): backing source: strides")
eq(base.dtype,"timedelta64[h]","timedelta64[h]/transpose/condition/(12,): backing source: dtype")
eq(a.shape,{4,3},"timedelta64[h]/transpose/condition/(12,): source shape")
eq(a.strides,{8,32},"timedelta64[h]/transpose/condition/(12,): source strides")
cases=cases+1
end
-- 383: timedelta64[h]/transpose/condition/(14,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]")
local a=np.transpose(base)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"timedelta64[h]/transpose/condition/(14,): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]/transpose/condition/(14,): backing source")
eq(base.shape,{3,4},"timedelta64[h]/transpose/condition/(14,): backing source: shape")
eq(base.strides,{32,8},"timedelta64[h]/transpose/condition/(14,): backing source: strides")
eq(base.dtype,"timedelta64[h]","timedelta64[h]/transpose/condition/(14,): backing source: dtype")
eq(a.shape,{4,3},"timedelta64[h]/transpose/condition/(14,): source shape")
eq(a.strides,{8,32},"timedelta64[h]/transpose/condition/(14,): source strides")
cases=cases+1
end
-- 384: timedelta64[h]/transpose/condition/(0,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]")
local a=np.transpose(base)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"timedelta64[h]/transpose/condition/(0,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{},"timedelta64[h]/transpose/condition/(0,): result")
eq(result.shape,{0},"timedelta64[h]/transpose/condition/(0,): result: shape")
eq(result.strides,{0},"timedelta64[h]/transpose/condition/(0,): result: strides")
eq(result.dtype,"timedelta64[h]","timedelta64[h]/transpose/condition/(0,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]/transpose/condition/(0,): backing source")
eq(base.shape,{3,4},"timedelta64[h]/transpose/condition/(0,): backing source: shape")
eq(base.strides,{32,8},"timedelta64[h]/transpose/condition/(0,): backing source: strides")
eq(base.dtype,"timedelta64[h]","timedelta64[h]/transpose/condition/(0,): backing source: dtype")
eq(a.shape,{4,3},"timedelta64[h]/transpose/condition/(0,): source shape")
eq(a.strides,{8,32},"timedelta64[h]/transpose/condition/(0,): source strides")
cases=cases+1
end
-- 385: timedelta64[h]/transpose/condition/(); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]")
local a=np.transpose(base)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"timedelta64[h]/transpose/condition/(): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0},"timedelta64[h]/transpose/condition/(): result")
eq(result.shape,{1},"timedelta64[h]/transpose/condition/(): result: shape")
eq(result.strides,{8},"timedelta64[h]/transpose/condition/(): result: strides")
eq(result.dtype,"timedelta64[h]","timedelta64[h]/transpose/condition/(): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]/transpose/condition/(): backing source")
eq(base.shape,{3,4},"timedelta64[h]/transpose/condition/(): backing source: shape")
eq(base.strides,{32,8},"timedelta64[h]/transpose/condition/(): backing source: strides")
eq(base.dtype,"timedelta64[h]","timedelta64[h]/transpose/condition/(): backing source: dtype")
eq(a.shape,{4,3},"timedelta64[h]/transpose/condition/(): source shape")
eq(a.strides,{8,32},"timedelta64[h]/transpose/condition/(): source strides")
cases=cases+1
end
-- 386: timedelta64[h]/reverse_columns/condition/(2, 3); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]")
local a=np.flip(base,2)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"timedelta64[h]/reverse_columns/condition/(2, 3): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{3,1,7},"timedelta64[h]/reverse_columns/condition/(2, 3): result")
eq(result.shape,{3},"timedelta64[h]/reverse_columns/condition/(2, 3): result: shape")
eq(result.strides,{8},"timedelta64[h]/reverse_columns/condition/(2, 3): result: strides")
eq(result.dtype,"timedelta64[h]","timedelta64[h]/reverse_columns/condition/(2, 3): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]/reverse_columns/condition/(2, 3): backing source")
eq(base.shape,{3,4},"timedelta64[h]/reverse_columns/condition/(2, 3): backing source: shape")
eq(base.strides,{32,8},"timedelta64[h]/reverse_columns/condition/(2, 3): backing source: strides")
eq(base.dtype,"timedelta64[h]","timedelta64[h]/reverse_columns/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"timedelta64[h]/reverse_columns/condition/(2, 3): source shape")
eq(a.strides,{32,-8},"timedelta64[h]/reverse_columns/condition/(2, 3): source strides")
cases=cases+1
end
-- 387: timedelta64[h]/reverse_columns/condition/(12,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]")
local a=np.flip(base,2)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"timedelta64[h]/reverse_columns/condition/(12,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{3,1,7,5,11,9},"timedelta64[h]/reverse_columns/condition/(12,): result")
eq(result.shape,{6},"timedelta64[h]/reverse_columns/condition/(12,): result: shape")
eq(result.strides,{8},"timedelta64[h]/reverse_columns/condition/(12,): result: strides")
eq(result.dtype,"timedelta64[h]","timedelta64[h]/reverse_columns/condition/(12,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]/reverse_columns/condition/(12,): backing source")
eq(base.shape,{3,4},"timedelta64[h]/reverse_columns/condition/(12,): backing source: shape")
eq(base.strides,{32,8},"timedelta64[h]/reverse_columns/condition/(12,): backing source: strides")
eq(base.dtype,"timedelta64[h]","timedelta64[h]/reverse_columns/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"timedelta64[h]/reverse_columns/condition/(12,): source shape")
eq(a.strides,{32,-8},"timedelta64[h]/reverse_columns/condition/(12,): source strides")
cases=cases+1
end
-- 388: timedelta64[h]/reverse_columns/condition/(14,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]")
local a=np.flip(base,2)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"timedelta64[h]/reverse_columns/condition/(14,): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]/reverse_columns/condition/(14,): backing source")
eq(base.shape,{3,4},"timedelta64[h]/reverse_columns/condition/(14,): backing source: shape")
eq(base.strides,{32,8},"timedelta64[h]/reverse_columns/condition/(14,): backing source: strides")
eq(base.dtype,"timedelta64[h]","timedelta64[h]/reverse_columns/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"timedelta64[h]/reverse_columns/condition/(14,): source shape")
eq(a.strides,{32,-8},"timedelta64[h]/reverse_columns/condition/(14,): source strides")
cases=cases+1
end
-- 389: timedelta64[h]/reverse_columns/condition/(0,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]")
local a=np.flip(base,2)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"timedelta64[h]/reverse_columns/condition/(0,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{},"timedelta64[h]/reverse_columns/condition/(0,): result")
eq(result.shape,{0},"timedelta64[h]/reverse_columns/condition/(0,): result: shape")
eq(result.strides,{0},"timedelta64[h]/reverse_columns/condition/(0,): result: strides")
eq(result.dtype,"timedelta64[h]","timedelta64[h]/reverse_columns/condition/(0,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]/reverse_columns/condition/(0,): backing source")
eq(base.shape,{3,4},"timedelta64[h]/reverse_columns/condition/(0,): backing source: shape")
eq(base.strides,{32,8},"timedelta64[h]/reverse_columns/condition/(0,): backing source: strides")
eq(base.dtype,"timedelta64[h]","timedelta64[h]/reverse_columns/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"timedelta64[h]/reverse_columns/condition/(0,): source shape")
eq(a.strides,{32,-8},"timedelta64[h]/reverse_columns/condition/(0,): source strides")
cases=cases+1
end
-- 390: timedelta64[h]/reverse_columns/condition/(); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]")
local a=np.flip(base,2)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"timedelta64[h]/reverse_columns/condition/(): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{3},"timedelta64[h]/reverse_columns/condition/(): result")
eq(result.shape,{1},"timedelta64[h]/reverse_columns/condition/(): result: shape")
eq(result.strides,{8},"timedelta64[h]/reverse_columns/condition/(): result: strides")
eq(result.dtype,"timedelta64[h]","timedelta64[h]/reverse_columns/condition/(): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]/reverse_columns/condition/(): backing source")
eq(base.shape,{3,4},"timedelta64[h]/reverse_columns/condition/(): backing source: shape")
eq(base.strides,{32,8},"timedelta64[h]/reverse_columns/condition/(): backing source: strides")
eq(base.dtype,"timedelta64[h]","timedelta64[h]/reverse_columns/condition/(): backing source: dtype")
eq(a.shape,{3,4},"timedelta64[h]/reverse_columns/condition/(): source shape")
eq(a.strides,{32,-8},"timedelta64[h]/reverse_columns/condition/(): source strides")
cases=cases+1
end
-- 391: timedelta64[h]/reverse_rows/condition/(2, 3); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]")
local a=np.flip(base,1)
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"timedelta64[h]/reverse_rows/condition/(2, 3): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{8,10,4},"timedelta64[h]/reverse_rows/condition/(2, 3): result")
eq(result.shape,{3},"timedelta64[h]/reverse_rows/condition/(2, 3): result: shape")
eq(result.strides,{8},"timedelta64[h]/reverse_rows/condition/(2, 3): result: strides")
eq(result.dtype,"timedelta64[h]","timedelta64[h]/reverse_rows/condition/(2, 3): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]/reverse_rows/condition/(2, 3): backing source")
eq(base.shape,{3,4},"timedelta64[h]/reverse_rows/condition/(2, 3): backing source: shape")
eq(base.strides,{32,8},"timedelta64[h]/reverse_rows/condition/(2, 3): backing source: strides")
eq(base.dtype,"timedelta64[h]","timedelta64[h]/reverse_rows/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,4},"timedelta64[h]/reverse_rows/condition/(2, 3): source shape")
eq(a.strides,{-32,8},"timedelta64[h]/reverse_rows/condition/(2, 3): source strides")
cases=cases+1
end
-- 392: timedelta64[h]/reverse_rows/condition/(12,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]")
local a=np.flip(base,1)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"timedelta64[h]/reverse_rows/condition/(12,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{8,10,4,6,0,2},"timedelta64[h]/reverse_rows/condition/(12,): result")
eq(result.shape,{6},"timedelta64[h]/reverse_rows/condition/(12,): result: shape")
eq(result.strides,{8},"timedelta64[h]/reverse_rows/condition/(12,): result: strides")
eq(result.dtype,"timedelta64[h]","timedelta64[h]/reverse_rows/condition/(12,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]/reverse_rows/condition/(12,): backing source")
eq(base.shape,{3,4},"timedelta64[h]/reverse_rows/condition/(12,): backing source: shape")
eq(base.strides,{32,8},"timedelta64[h]/reverse_rows/condition/(12,): backing source: strides")
eq(base.dtype,"timedelta64[h]","timedelta64[h]/reverse_rows/condition/(12,): backing source: dtype")
eq(a.shape,{3,4},"timedelta64[h]/reverse_rows/condition/(12,): source shape")
eq(a.strides,{-32,8},"timedelta64[h]/reverse_rows/condition/(12,): source strides")
cases=cases+1
end
-- 393: timedelta64[h]/reverse_rows/condition/(14,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]")
local a=np.flip(base,1)
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"timedelta64[h]/reverse_rows/condition/(14,): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]/reverse_rows/condition/(14,): backing source")
eq(base.shape,{3,4},"timedelta64[h]/reverse_rows/condition/(14,): backing source: shape")
eq(base.strides,{32,8},"timedelta64[h]/reverse_rows/condition/(14,): backing source: strides")
eq(base.dtype,"timedelta64[h]","timedelta64[h]/reverse_rows/condition/(14,): backing source: dtype")
eq(a.shape,{3,4},"timedelta64[h]/reverse_rows/condition/(14,): source shape")
eq(a.strides,{-32,8},"timedelta64[h]/reverse_rows/condition/(14,): source strides")
cases=cases+1
end
-- 394: timedelta64[h]/reverse_rows/condition/(0,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]")
local a=np.flip(base,1)
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"timedelta64[h]/reverse_rows/condition/(0,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{},"timedelta64[h]/reverse_rows/condition/(0,): result")
eq(result.shape,{0},"timedelta64[h]/reverse_rows/condition/(0,): result: shape")
eq(result.strides,{0},"timedelta64[h]/reverse_rows/condition/(0,): result: strides")
eq(result.dtype,"timedelta64[h]","timedelta64[h]/reverse_rows/condition/(0,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]/reverse_rows/condition/(0,): backing source")
eq(base.shape,{3,4},"timedelta64[h]/reverse_rows/condition/(0,): backing source: shape")
eq(base.strides,{32,8},"timedelta64[h]/reverse_rows/condition/(0,): backing source: strides")
eq(base.dtype,"timedelta64[h]","timedelta64[h]/reverse_rows/condition/(0,): backing source: dtype")
eq(a.shape,{3,4},"timedelta64[h]/reverse_rows/condition/(0,): source shape")
eq(a.strides,{-32,8},"timedelta64[h]/reverse_rows/condition/(0,): source strides")
cases=cases+1
end
-- 395: timedelta64[h]/reverse_rows/condition/(); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]")
local a=np.flip(base,1)
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"timedelta64[h]/reverse_rows/condition/(): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{8},"timedelta64[h]/reverse_rows/condition/(): result")
eq(result.shape,{1},"timedelta64[h]/reverse_rows/condition/(): result: shape")
eq(result.strides,{8},"timedelta64[h]/reverse_rows/condition/(): result: strides")
eq(result.dtype,"timedelta64[h]","timedelta64[h]/reverse_rows/condition/(): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]/reverse_rows/condition/(): backing source")
eq(base.shape,{3,4},"timedelta64[h]/reverse_rows/condition/(): backing source: shape")
eq(base.strides,{32,8},"timedelta64[h]/reverse_rows/condition/(): backing source: strides")
eq(base.dtype,"timedelta64[h]","timedelta64[h]/reverse_rows/condition/(): backing source: dtype")
eq(a.shape,{3,4},"timedelta64[h]/reverse_rows/condition/(): source shape")
eq(a.strides,{-32,8},"timedelta64[h]/reverse_rows/condition/(): source strides")
cases=cases+1
end
-- 396: timedelta64[h]/strided/condition/(2, 3); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({{true,false,true},{false,true,false}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"timedelta64[h]/strided/condition/(2, 3): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0,4,8},"timedelta64[h]/strided/condition/(2, 3): result")
eq(result.shape,{3},"timedelta64[h]/strided/condition/(2, 3): result: shape")
eq(result.strides,{8},"timedelta64[h]/strided/condition/(2, 3): result: strides")
eq(result.dtype,"timedelta64[h]","timedelta64[h]/strided/condition/(2, 3): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]/strided/condition/(2, 3): backing source")
eq(base.shape,{3,4},"timedelta64[h]/strided/condition/(2, 3): backing source: shape")
eq(base.strides,{32,8},"timedelta64[h]/strided/condition/(2, 3): backing source: strides")
eq(base.dtype,"timedelta64[h]","timedelta64[h]/strided/condition/(2, 3): backing source: dtype")
eq(a.shape,{3,2},"timedelta64[h]/strided/condition/(2, 3): source shape")
eq(a.strides,{32,16},"timedelta64[h]/strided/condition/(2, 3): source strides")
cases=cases+1
end
-- 397: timedelta64[h]/strided/condition/(12,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"timedelta64[h]/strided/condition/(12,): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]/strided/condition/(12,): backing source")
eq(base.shape,{3,4},"timedelta64[h]/strided/condition/(12,): backing source: shape")
eq(base.strides,{32,8},"timedelta64[h]/strided/condition/(12,): backing source: strides")
eq(base.dtype,"timedelta64[h]","timedelta64[h]/strided/condition/(12,): backing source: dtype")
eq(a.shape,{3,2},"timedelta64[h]/strided/condition/(12,): source shape")
eq(a.strides,{32,16},"timedelta64[h]/strided/condition/(12,): source strides")
cases=cases+1
end
-- 398: timedelta64[h]/strided/condition/(14,); source error=IndexError
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array({true,false,true,false,true,false,true,false,true,false,true,false,true,false},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"timedelta64[h]/strided/condition/(14,): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]/strided/condition/(14,): backing source")
eq(base.shape,{3,4},"timedelta64[h]/strided/condition/(14,): backing source: shape")
eq(base.strides,{32,8},"timedelta64[h]/strided/condition/(14,): backing source: strides")
eq(base.dtype,"timedelta64[h]","timedelta64[h]/strided/condition/(14,): backing source: dtype")
eq(a.shape,{3,2},"timedelta64[h]/strided/condition/(14,): source shape")
eq(a.strides,{32,16},"timedelta64[h]/strided/condition/(14,): source strides")
cases=cases+1
end
-- 399: timedelta64[h]/strided/condition/(0,); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"timedelta64[h]/strided/condition/(0,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{},"timedelta64[h]/strided/condition/(0,): result")
eq(result.shape,{0},"timedelta64[h]/strided/condition/(0,): result: shape")
eq(result.strides,{0},"timedelta64[h]/strided/condition/(0,): result: strides")
eq(result.dtype,"timedelta64[h]","timedelta64[h]/strided/condition/(0,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]/strided/condition/(0,): backing source")
eq(base.shape,{3,4},"timedelta64[h]/strided/condition/(0,): backing source: shape")
eq(base.strides,{32,8},"timedelta64[h]/strided/condition/(0,): backing source: strides")
eq(base.dtype,"timedelta64[h]","timedelta64[h]/strided/condition/(0,): backing source: dtype")
eq(a.shape,{3,2},"timedelta64[h]/strided/condition/(0,): source shape")
eq(a.strides,{32,16},"timedelta64[h]/strided/condition/(0,): source strides")
cases=cases+1
end
-- 400: timedelta64[h]/strided/condition/(); source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]")
local a=base:get(np.s(),np.s(1,nil,2))
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"timedelta64[h]/strided/condition/(): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0},"timedelta64[h]/strided/condition/(): result")
eq(result.shape,{1},"timedelta64[h]/strided/condition/(): result: shape")
eq(result.strides,{8},"timedelta64[h]/strided/condition/(): result: strides")
eq(result.dtype,"timedelta64[h]","timedelta64[h]/strided/condition/(): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]/strided/condition/(): backing source")
eq(base.shape,{3,4},"timedelta64[h]/strided/condition/(): backing source: shape")
eq(base.strides,{32,8},"timedelta64[h]/strided/condition/(): backing source: strides")
eq(base.dtype,"timedelta64[h]","timedelta64[h]/strided/condition/(): backing source: dtype")
eq(a.shape,{3,2},"timedelta64[h]/strided/condition/(): source shape")
eq(a.strides,{32,16},"timedelta64[h]/strided/condition/(): source strides")
cases=cases+1
end
-- 401: empty-source/()/int32/(); source error=None
do
local base=np.array(0,"int32")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/()/int32/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{0},"empty-source/()/int32/(): result")
eq(result.shape,{1},"empty-source/()/int32/(): result: shape")
eq(result.strides,{4},"empty-source/()/int32/(): result: strides")
eq(result.dtype,"int32","empty-source/()/int32/(): result: dtype")
eq(base:tolist(),0,"empty-source/()/int32/(): backing source")
eq(base.shape,{},"empty-source/()/int32/(): backing source: shape")
eq(base.strides,{},"empty-source/()/int32/(): backing source: strides")
eq(base.dtype,"int32","empty-source/()/int32/(): backing source: dtype")
eq(a.shape,{},"empty-source/()/int32/(): source shape")
eq(a.strides,{},"empty-source/()/int32/(): source strides")
cases=cases+1
end
-- 402: empty-source/()/int32/(0,); source error=None
do
local base=np.array(0,"int32")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/()/int32/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-source/()/int32/(0,): result")
eq(result.shape,{0},"empty-source/()/int32/(0,): result: shape")
eq(result.strides,{0},"empty-source/()/int32/(0,): result: strides")
eq(result.dtype,"int32","empty-source/()/int32/(0,): result: dtype")
eq(base:tolist(),0,"empty-source/()/int32/(0,): backing source")
eq(base.shape,{},"empty-source/()/int32/(0,): backing source: shape")
eq(base.strides,{},"empty-source/()/int32/(0,): backing source: strides")
eq(base.dtype,"int32","empty-source/()/int32/(0,): backing source: dtype")
eq(a.shape,{},"empty-source/()/int32/(0,): source shape")
eq(a.strides,{},"empty-source/()/int32/(0,): source strides")
cases=cases+1
end
-- 403: empty-source/()/int32/(1,); source error=None
do
local base=np.array(0,"int32")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/()/int32/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0},"empty-source/()/int32/(1,): result")
eq(result.shape,{1},"empty-source/()/int32/(1,): result: shape")
eq(result.strides,{4},"empty-source/()/int32/(1,): result: strides")
eq(result.dtype,"int32","empty-source/()/int32/(1,): result: dtype")
eq(base:tolist(),0,"empty-source/()/int32/(1,): backing source")
eq(base.shape,{},"empty-source/()/int32/(1,): backing source: shape")
eq(base.strides,{},"empty-source/()/int32/(1,): backing source: strides")
eq(base.dtype,"int32","empty-source/()/int32/(1,): backing source: dtype")
eq(a.shape,{},"empty-source/()/int32/(1,): source shape")
eq(a.strides,{},"empty-source/()/int32/(1,): source strides")
cases=cases+1
end
-- 404: empty-source/()/int32/(2,); source error=IndexError
do
local base=np.array(0,"int32")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/()/int32/(2,): acceptance"..": "..tostring(result))
eq(base:tolist(),0,"empty-source/()/int32/(2,): backing source")
eq(base.shape,{},"empty-source/()/int32/(2,): backing source: shape")
eq(base.strides,{},"empty-source/()/int32/(2,): backing source: strides")
eq(base.dtype,"int32","empty-source/()/int32/(2,): backing source: dtype")
eq(a.shape,{},"empty-source/()/int32/(2,): source shape")
eq(a.strides,{},"empty-source/()/int32/(2,): source strides")
cases=cases+1
end
-- 405: empty-source/()/int32/(1, 2); source error=IndexError
do
local base=np.array(0,"int32")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/()/int32/(1, 2): acceptance"..": "..tostring(result))
eq(base:tolist(),0,"empty-source/()/int32/(1, 2): backing source")
eq(base.shape,{},"empty-source/()/int32/(1, 2): backing source: shape")
eq(base.strides,{},"empty-source/()/int32/(1, 2): backing source: strides")
eq(base.dtype,"int32","empty-source/()/int32/(1, 2): backing source: dtype")
eq(a.shape,{},"empty-source/()/int32/(1, 2): source shape")
eq(a.strides,{},"empty-source/()/int32/(1, 2): source strides")
cases=cases+1
end
-- 406: empty-source/()/float32/(); source error=None
do
local base=np.array(0.0,"float32")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/()/float32/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"empty-source/()/float32/(): result")
eq(result.shape,{1},"empty-source/()/float32/(): result: shape")
eq(result.strides,{4},"empty-source/()/float32/(): result: strides")
eq(result.dtype,"float32","empty-source/()/float32/(): result: dtype")
eq(base:tolist(),0.0,"empty-source/()/float32/(): backing source")
eq(base.shape,{},"empty-source/()/float32/(): backing source: shape")
eq(base.strides,{},"empty-source/()/float32/(): backing source: strides")
eq(base.dtype,"float32","empty-source/()/float32/(): backing source: dtype")
eq(a.shape,{},"empty-source/()/float32/(): source shape")
eq(a.strides,{},"empty-source/()/float32/(): source strides")
cases=cases+1
end
-- 407: empty-source/()/float32/(0,); source error=None
do
local base=np.array(0.0,"float32")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/()/float32/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-source/()/float32/(0,): result")
eq(result.shape,{0},"empty-source/()/float32/(0,): result: shape")
eq(result.strides,{0},"empty-source/()/float32/(0,): result: strides")
eq(result.dtype,"float32","empty-source/()/float32/(0,): result: dtype")
eq(base:tolist(),0.0,"empty-source/()/float32/(0,): backing source")
eq(base.shape,{},"empty-source/()/float32/(0,): backing source: shape")
eq(base.strides,{},"empty-source/()/float32/(0,): backing source: strides")
eq(base.dtype,"float32","empty-source/()/float32/(0,): backing source: dtype")
eq(a.shape,{},"empty-source/()/float32/(0,): source shape")
eq(a.strides,{},"empty-source/()/float32/(0,): source strides")
cases=cases+1
end
-- 408: empty-source/()/float32/(1,); source error=None
do
local base=np.array(0.0,"float32")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/()/float32/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"empty-source/()/float32/(1,): result")
eq(result.shape,{1},"empty-source/()/float32/(1,): result: shape")
eq(result.strides,{4},"empty-source/()/float32/(1,): result: strides")
eq(result.dtype,"float32","empty-source/()/float32/(1,): result: dtype")
eq(base:tolist(),0.0,"empty-source/()/float32/(1,): backing source")
eq(base.shape,{},"empty-source/()/float32/(1,): backing source: shape")
eq(base.strides,{},"empty-source/()/float32/(1,): backing source: strides")
eq(base.dtype,"float32","empty-source/()/float32/(1,): backing source: dtype")
eq(a.shape,{},"empty-source/()/float32/(1,): source shape")
eq(a.strides,{},"empty-source/()/float32/(1,): source strides")
cases=cases+1
end
-- 409: empty-source/()/float32/(2,); source error=IndexError
do
local base=np.array(0.0,"float32")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/()/float32/(2,): acceptance"..": "..tostring(result))
eq(base:tolist(),0.0,"empty-source/()/float32/(2,): backing source")
eq(base.shape,{},"empty-source/()/float32/(2,): backing source: shape")
eq(base.strides,{},"empty-source/()/float32/(2,): backing source: strides")
eq(base.dtype,"float32","empty-source/()/float32/(2,): backing source: dtype")
eq(a.shape,{},"empty-source/()/float32/(2,): source shape")
eq(a.strides,{},"empty-source/()/float32/(2,): source strides")
cases=cases+1
end
-- 410: empty-source/()/float32/(1, 2); source error=IndexError
do
local base=np.array(0.0,"float32")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/()/float32/(1, 2): acceptance"..": "..tostring(result))
eq(base:tolist(),0.0,"empty-source/()/float32/(1, 2): backing source")
eq(base.shape,{},"empty-source/()/float32/(1, 2): backing source: shape")
eq(base.strides,{},"empty-source/()/float32/(1, 2): backing source: strides")
eq(base.dtype,"float32","empty-source/()/float32/(1, 2): backing source: dtype")
eq(a.shape,{},"empty-source/()/float32/(1, 2): source shape")
eq(a.strides,{},"empty-source/()/float32/(1, 2): source strides")
cases=cases+1
end
-- 411: empty-source/()/complex128/(); source error=None
do
local base=np.array(np.complex(0.0,0.0),"complex128")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/()/complex128/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0)},"empty-source/()/complex128/(): result")
eq(result.shape,{1},"empty-source/()/complex128/(): result: shape")
eq(result.strides,{16},"empty-source/()/complex128/(): result: strides")
eq(result.dtype,"complex128","empty-source/()/complex128/(): result: dtype")
eq(base:tolist(),np.complex(0.0,0.0),"empty-source/()/complex128/(): backing source")
eq(base.shape,{},"empty-source/()/complex128/(): backing source: shape")
eq(base.strides,{},"empty-source/()/complex128/(): backing source: strides")
eq(base.dtype,"complex128","empty-source/()/complex128/(): backing source: dtype")
eq(a.shape,{},"empty-source/()/complex128/(): source shape")
eq(a.strides,{},"empty-source/()/complex128/(): source strides")
cases=cases+1
end
-- 412: empty-source/()/complex128/(0,); source error=None
do
local base=np.array(np.complex(0.0,0.0),"complex128")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/()/complex128/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-source/()/complex128/(0,): result")
eq(result.shape,{0},"empty-source/()/complex128/(0,): result: shape")
eq(result.strides,{0},"empty-source/()/complex128/(0,): result: strides")
eq(result.dtype,"complex128","empty-source/()/complex128/(0,): result: dtype")
eq(base:tolist(),np.complex(0.0,0.0),"empty-source/()/complex128/(0,): backing source")
eq(base.shape,{},"empty-source/()/complex128/(0,): backing source: shape")
eq(base.strides,{},"empty-source/()/complex128/(0,): backing source: strides")
eq(base.dtype,"complex128","empty-source/()/complex128/(0,): backing source: dtype")
eq(a.shape,{},"empty-source/()/complex128/(0,): source shape")
eq(a.strides,{},"empty-source/()/complex128/(0,): source strides")
cases=cases+1
end
-- 413: empty-source/()/complex128/(1,); source error=None
do
local base=np.array(np.complex(0.0,0.0),"complex128")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/()/complex128/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0)},"empty-source/()/complex128/(1,): result")
eq(result.shape,{1},"empty-source/()/complex128/(1,): result: shape")
eq(result.strides,{16},"empty-source/()/complex128/(1,): result: strides")
eq(result.dtype,"complex128","empty-source/()/complex128/(1,): result: dtype")
eq(base:tolist(),np.complex(0.0,0.0),"empty-source/()/complex128/(1,): backing source")
eq(base.shape,{},"empty-source/()/complex128/(1,): backing source: shape")
eq(base.strides,{},"empty-source/()/complex128/(1,): backing source: strides")
eq(base.dtype,"complex128","empty-source/()/complex128/(1,): backing source: dtype")
eq(a.shape,{},"empty-source/()/complex128/(1,): source shape")
eq(a.strides,{},"empty-source/()/complex128/(1,): source strides")
cases=cases+1
end
-- 414: empty-source/()/complex128/(2,); source error=IndexError
do
local base=np.array(np.complex(0.0,0.0),"complex128")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/()/complex128/(2,): acceptance"..": "..tostring(result))
eq(base:tolist(),np.complex(0.0,0.0),"empty-source/()/complex128/(2,): backing source")
eq(base.shape,{},"empty-source/()/complex128/(2,): backing source: shape")
eq(base.strides,{},"empty-source/()/complex128/(2,): backing source: strides")
eq(base.dtype,"complex128","empty-source/()/complex128/(2,): backing source: dtype")
eq(a.shape,{},"empty-source/()/complex128/(2,): source shape")
eq(a.strides,{},"empty-source/()/complex128/(2,): source strides")
cases=cases+1
end
-- 415: empty-source/()/complex128/(1, 2); source error=IndexError
do
local base=np.array(np.complex(0.0,0.0),"complex128")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/()/complex128/(1, 2): acceptance"..": "..tostring(result))
eq(base:tolist(),np.complex(0.0,0.0),"empty-source/()/complex128/(1, 2): backing source")
eq(base.shape,{},"empty-source/()/complex128/(1, 2): backing source: shape")
eq(base.strides,{},"empty-source/()/complex128/(1, 2): backing source: strides")
eq(base.dtype,"complex128","empty-source/()/complex128/(1, 2): backing source: dtype")
eq(a.shape,{},"empty-source/()/complex128/(1, 2): source shape")
eq(a.strides,{},"empty-source/()/complex128/(1, 2): source strides")
cases=cases+1
end
-- 416: empty-source/()/U4/(); source error=None
do
local base=np.array("","<U4")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/()/U4/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{""},"empty-source/()/U4/(): result")
eq(result.shape,{1},"empty-source/()/U4/(): result: shape")
eq(result.strides,{16},"empty-source/()/U4/(): result: strides")
eq(result.dtype,"<U4","empty-source/()/U4/(): result: dtype")
eq(base:tolist(),"","empty-source/()/U4/(): backing source")
eq(base.shape,{},"empty-source/()/U4/(): backing source: shape")
eq(base.strides,{},"empty-source/()/U4/(): backing source: strides")
eq(base.dtype,"<U4","empty-source/()/U4/(): backing source: dtype")
eq(a.shape,{},"empty-source/()/U4/(): source shape")
eq(a.strides,{},"empty-source/()/U4/(): source strides")
cases=cases+1
end
-- 417: empty-source/()/U4/(0,); source error=None
do
local base=np.array("","<U4")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/()/U4/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-source/()/U4/(0,): result")
eq(result.shape,{0},"empty-source/()/U4/(0,): result: shape")
eq(result.strides,{0},"empty-source/()/U4/(0,): result: strides")
eq(result.dtype,"<U4","empty-source/()/U4/(0,): result: dtype")
eq(base:tolist(),"","empty-source/()/U4/(0,): backing source")
eq(base.shape,{},"empty-source/()/U4/(0,): backing source: shape")
eq(base.strides,{},"empty-source/()/U4/(0,): backing source: strides")
eq(base.dtype,"<U4","empty-source/()/U4/(0,): backing source: dtype")
eq(a.shape,{},"empty-source/()/U4/(0,): source shape")
eq(a.strides,{},"empty-source/()/U4/(0,): source strides")
cases=cases+1
end
-- 418: empty-source/()/U4/(1,); source error=None
do
local base=np.array("","<U4")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/()/U4/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{""},"empty-source/()/U4/(1,): result")
eq(result.shape,{1},"empty-source/()/U4/(1,): result: shape")
eq(result.strides,{16},"empty-source/()/U4/(1,): result: strides")
eq(result.dtype,"<U4","empty-source/()/U4/(1,): result: dtype")
eq(base:tolist(),"","empty-source/()/U4/(1,): backing source")
eq(base.shape,{},"empty-source/()/U4/(1,): backing source: shape")
eq(base.strides,{},"empty-source/()/U4/(1,): backing source: strides")
eq(base.dtype,"<U4","empty-source/()/U4/(1,): backing source: dtype")
eq(a.shape,{},"empty-source/()/U4/(1,): source shape")
eq(a.strides,{},"empty-source/()/U4/(1,): source strides")
cases=cases+1
end
-- 419: empty-source/()/U4/(2,); source error=IndexError
do
local base=np.array("","<U4")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/()/U4/(2,): acceptance"..": "..tostring(result))
eq(base:tolist(),"","empty-source/()/U4/(2,): backing source")
eq(base.shape,{},"empty-source/()/U4/(2,): backing source: shape")
eq(base.strides,{},"empty-source/()/U4/(2,): backing source: strides")
eq(base.dtype,"<U4","empty-source/()/U4/(2,): backing source: dtype")
eq(a.shape,{},"empty-source/()/U4/(2,): source shape")
eq(a.strides,{},"empty-source/()/U4/(2,): source strides")
cases=cases+1
end
-- 420: empty-source/()/U4/(1, 2); source error=IndexError
do
local base=np.array("","<U4")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/()/U4/(1, 2): acceptance"..": "..tostring(result))
eq(base:tolist(),"","empty-source/()/U4/(1, 2): backing source")
eq(base.shape,{},"empty-source/()/U4/(1, 2): backing source: shape")
eq(base.strides,{},"empty-source/()/U4/(1, 2): backing source: strides")
eq(base.dtype,"<U4","empty-source/()/U4/(1, 2): backing source: dtype")
eq(a.shape,{},"empty-source/()/U4/(1, 2): source shape")
eq(a.strides,{},"empty-source/()/U4/(1, 2): source strides")
cases=cases+1
end
-- 421: empty-source/()/S4/(); source error=None
do
local base=np.array("","|S4")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/()/S4/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{""},"empty-source/()/S4/(): result")
eq(result.shape,{1},"empty-source/()/S4/(): result: shape")
eq(result.strides,{4},"empty-source/()/S4/(): result: strides")
eq(result.dtype,"|S4","empty-source/()/S4/(): result: dtype")
eq(base:tolist(),"","empty-source/()/S4/(): backing source")
eq(base.shape,{},"empty-source/()/S4/(): backing source: shape")
eq(base.strides,{},"empty-source/()/S4/(): backing source: strides")
eq(base.dtype,"|S4","empty-source/()/S4/(): backing source: dtype")
eq(a.shape,{},"empty-source/()/S4/(): source shape")
eq(a.strides,{},"empty-source/()/S4/(): source strides")
cases=cases+1
end
-- 422: empty-source/()/S4/(0,); source error=None
do
local base=np.array("","|S4")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/()/S4/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-source/()/S4/(0,): result")
eq(result.shape,{0},"empty-source/()/S4/(0,): result: shape")
eq(result.strides,{0},"empty-source/()/S4/(0,): result: strides")
eq(result.dtype,"|S4","empty-source/()/S4/(0,): result: dtype")
eq(base:tolist(),"","empty-source/()/S4/(0,): backing source")
eq(base.shape,{},"empty-source/()/S4/(0,): backing source: shape")
eq(base.strides,{},"empty-source/()/S4/(0,): backing source: strides")
eq(base.dtype,"|S4","empty-source/()/S4/(0,): backing source: dtype")
eq(a.shape,{},"empty-source/()/S4/(0,): source shape")
eq(a.strides,{},"empty-source/()/S4/(0,): source strides")
cases=cases+1
end
-- 423: empty-source/()/S4/(1,); source error=None
do
local base=np.array("","|S4")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/()/S4/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{""},"empty-source/()/S4/(1,): result")
eq(result.shape,{1},"empty-source/()/S4/(1,): result: shape")
eq(result.strides,{4},"empty-source/()/S4/(1,): result: strides")
eq(result.dtype,"|S4","empty-source/()/S4/(1,): result: dtype")
eq(base:tolist(),"","empty-source/()/S4/(1,): backing source")
eq(base.shape,{},"empty-source/()/S4/(1,): backing source: shape")
eq(base.strides,{},"empty-source/()/S4/(1,): backing source: strides")
eq(base.dtype,"|S4","empty-source/()/S4/(1,): backing source: dtype")
eq(a.shape,{},"empty-source/()/S4/(1,): source shape")
eq(a.strides,{},"empty-source/()/S4/(1,): source strides")
cases=cases+1
end
-- 424: empty-source/()/S4/(2,); source error=IndexError
do
local base=np.array("","|S4")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/()/S4/(2,): acceptance"..": "..tostring(result))
eq(base:tolist(),"","empty-source/()/S4/(2,): backing source")
eq(base.shape,{},"empty-source/()/S4/(2,): backing source: shape")
eq(base.strides,{},"empty-source/()/S4/(2,): backing source: strides")
eq(base.dtype,"|S4","empty-source/()/S4/(2,): backing source: dtype")
eq(a.shape,{},"empty-source/()/S4/(2,): source shape")
eq(a.strides,{},"empty-source/()/S4/(2,): source strides")
cases=cases+1
end
-- 425: empty-source/()/S4/(1, 2); source error=IndexError
do
local base=np.array("","|S4")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/()/S4/(1, 2): acceptance"..": "..tostring(result))
eq(base:tolist(),"","empty-source/()/S4/(1, 2): backing source")
eq(base.shape,{},"empty-source/()/S4/(1, 2): backing source: shape")
eq(base.strides,{},"empty-source/()/S4/(1, 2): backing source: strides")
eq(base.dtype,"|S4","empty-source/()/S4/(1, 2): backing source: dtype")
eq(a.shape,{},"empty-source/()/S4/(1, 2): source shape")
eq(a.strides,{},"empty-source/()/S4/(1, 2): source strides")
cases=cases+1
end
-- 426: empty-source/()/datetime64[D]/(); source error=None
do
local base=np.array(0,"datetime64[D]")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/()/datetime64[D]/(): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0},"empty-source/()/datetime64[D]/(): result")
eq(result.shape,{1},"empty-source/()/datetime64[D]/(): result: shape")
eq(result.strides,{8},"empty-source/()/datetime64[D]/(): result: strides")
eq(result.dtype,"datetime64[D]","empty-source/()/datetime64[D]/(): result: dtype")
eq(np.astype(base,'int64'):tolist(),0,"empty-source/()/datetime64[D]/(): backing source")
eq(base.shape,{},"empty-source/()/datetime64[D]/(): backing source: shape")
eq(base.strides,{},"empty-source/()/datetime64[D]/(): backing source: strides")
eq(base.dtype,"datetime64[D]","empty-source/()/datetime64[D]/(): backing source: dtype")
eq(a.shape,{},"empty-source/()/datetime64[D]/(): source shape")
eq(a.strides,{},"empty-source/()/datetime64[D]/(): source strides")
cases=cases+1
end
-- 427: empty-source/()/datetime64[D]/(0,); source error=None
do
local base=np.array(0,"datetime64[D]")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/()/datetime64[D]/(0,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{},"empty-source/()/datetime64[D]/(0,): result")
eq(result.shape,{0},"empty-source/()/datetime64[D]/(0,): result: shape")
eq(result.strides,{0},"empty-source/()/datetime64[D]/(0,): result: strides")
eq(result.dtype,"datetime64[D]","empty-source/()/datetime64[D]/(0,): result: dtype")
eq(np.astype(base,'int64'):tolist(),0,"empty-source/()/datetime64[D]/(0,): backing source")
eq(base.shape,{},"empty-source/()/datetime64[D]/(0,): backing source: shape")
eq(base.strides,{},"empty-source/()/datetime64[D]/(0,): backing source: strides")
eq(base.dtype,"datetime64[D]","empty-source/()/datetime64[D]/(0,): backing source: dtype")
eq(a.shape,{},"empty-source/()/datetime64[D]/(0,): source shape")
eq(a.strides,{},"empty-source/()/datetime64[D]/(0,): source strides")
cases=cases+1
end
-- 428: empty-source/()/datetime64[D]/(1,); source error=None
do
local base=np.array(0,"datetime64[D]")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/()/datetime64[D]/(1,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0},"empty-source/()/datetime64[D]/(1,): result")
eq(result.shape,{1},"empty-source/()/datetime64[D]/(1,): result: shape")
eq(result.strides,{8},"empty-source/()/datetime64[D]/(1,): result: strides")
eq(result.dtype,"datetime64[D]","empty-source/()/datetime64[D]/(1,): result: dtype")
eq(np.astype(base,'int64'):tolist(),0,"empty-source/()/datetime64[D]/(1,): backing source")
eq(base.shape,{},"empty-source/()/datetime64[D]/(1,): backing source: shape")
eq(base.strides,{},"empty-source/()/datetime64[D]/(1,): backing source: strides")
eq(base.dtype,"datetime64[D]","empty-source/()/datetime64[D]/(1,): backing source: dtype")
eq(a.shape,{},"empty-source/()/datetime64[D]/(1,): source shape")
eq(a.strides,{},"empty-source/()/datetime64[D]/(1,): source strides")
cases=cases+1
end
-- 429: empty-source/()/datetime64[D]/(2,); source error=IndexError
do
local base=np.array(0,"datetime64[D]")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/()/datetime64[D]/(2,): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),0,"empty-source/()/datetime64[D]/(2,): backing source")
eq(base.shape,{},"empty-source/()/datetime64[D]/(2,): backing source: shape")
eq(base.strides,{},"empty-source/()/datetime64[D]/(2,): backing source: strides")
eq(base.dtype,"datetime64[D]","empty-source/()/datetime64[D]/(2,): backing source: dtype")
eq(a.shape,{},"empty-source/()/datetime64[D]/(2,): source shape")
eq(a.strides,{},"empty-source/()/datetime64[D]/(2,): source strides")
cases=cases+1
end
-- 430: empty-source/()/datetime64[D]/(1, 2); source error=IndexError
do
local base=np.array(0,"datetime64[D]")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/()/datetime64[D]/(1, 2): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),0,"empty-source/()/datetime64[D]/(1, 2): backing source")
eq(base.shape,{},"empty-source/()/datetime64[D]/(1, 2): backing source: shape")
eq(base.strides,{},"empty-source/()/datetime64[D]/(1, 2): backing source: strides")
eq(base.dtype,"datetime64[D]","empty-source/()/datetime64[D]/(1, 2): backing source: dtype")
eq(a.shape,{},"empty-source/()/datetime64[D]/(1, 2): source shape")
eq(a.strides,{},"empty-source/()/datetime64[D]/(1, 2): source strides")
cases=cases+1
end
-- 431: empty-source/()/timedelta64[h]/(); source error=None
do
local base=np.array(0,"timedelta64[h]")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/()/timedelta64[h]/(): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0},"empty-source/()/timedelta64[h]/(): result")
eq(result.shape,{1},"empty-source/()/timedelta64[h]/(): result: shape")
eq(result.strides,{8},"empty-source/()/timedelta64[h]/(): result: strides")
eq(result.dtype,"timedelta64[h]","empty-source/()/timedelta64[h]/(): result: dtype")
eq(np.astype(base,'int64'):tolist(),0,"empty-source/()/timedelta64[h]/(): backing source")
eq(base.shape,{},"empty-source/()/timedelta64[h]/(): backing source: shape")
eq(base.strides,{},"empty-source/()/timedelta64[h]/(): backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-source/()/timedelta64[h]/(): backing source: dtype")
eq(a.shape,{},"empty-source/()/timedelta64[h]/(): source shape")
eq(a.strides,{},"empty-source/()/timedelta64[h]/(): source strides")
cases=cases+1
end
-- 432: empty-source/()/timedelta64[h]/(0,); source error=None
do
local base=np.array(0,"timedelta64[h]")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/()/timedelta64[h]/(0,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{},"empty-source/()/timedelta64[h]/(0,): result")
eq(result.shape,{0},"empty-source/()/timedelta64[h]/(0,): result: shape")
eq(result.strides,{0},"empty-source/()/timedelta64[h]/(0,): result: strides")
eq(result.dtype,"timedelta64[h]","empty-source/()/timedelta64[h]/(0,): result: dtype")
eq(np.astype(base,'int64'):tolist(),0,"empty-source/()/timedelta64[h]/(0,): backing source")
eq(base.shape,{},"empty-source/()/timedelta64[h]/(0,): backing source: shape")
eq(base.strides,{},"empty-source/()/timedelta64[h]/(0,): backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-source/()/timedelta64[h]/(0,): backing source: dtype")
eq(a.shape,{},"empty-source/()/timedelta64[h]/(0,): source shape")
eq(a.strides,{},"empty-source/()/timedelta64[h]/(0,): source strides")
cases=cases+1
end
-- 433: empty-source/()/timedelta64[h]/(1,); source error=None
do
local base=np.array(0,"timedelta64[h]")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/()/timedelta64[h]/(1,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0},"empty-source/()/timedelta64[h]/(1,): result")
eq(result.shape,{1},"empty-source/()/timedelta64[h]/(1,): result: shape")
eq(result.strides,{8},"empty-source/()/timedelta64[h]/(1,): result: strides")
eq(result.dtype,"timedelta64[h]","empty-source/()/timedelta64[h]/(1,): result: dtype")
eq(np.astype(base,'int64'):tolist(),0,"empty-source/()/timedelta64[h]/(1,): backing source")
eq(base.shape,{},"empty-source/()/timedelta64[h]/(1,): backing source: shape")
eq(base.strides,{},"empty-source/()/timedelta64[h]/(1,): backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-source/()/timedelta64[h]/(1,): backing source: dtype")
eq(a.shape,{},"empty-source/()/timedelta64[h]/(1,): source shape")
eq(a.strides,{},"empty-source/()/timedelta64[h]/(1,): source strides")
cases=cases+1
end
-- 434: empty-source/()/timedelta64[h]/(2,); source error=IndexError
do
local base=np.array(0,"timedelta64[h]")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/()/timedelta64[h]/(2,): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),0,"empty-source/()/timedelta64[h]/(2,): backing source")
eq(base.shape,{},"empty-source/()/timedelta64[h]/(2,): backing source: shape")
eq(base.strides,{},"empty-source/()/timedelta64[h]/(2,): backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-source/()/timedelta64[h]/(2,): backing source: dtype")
eq(a.shape,{},"empty-source/()/timedelta64[h]/(2,): source shape")
eq(a.strides,{},"empty-source/()/timedelta64[h]/(2,): source strides")
cases=cases+1
end
-- 435: empty-source/()/timedelta64[h]/(1, 2); source error=IndexError
do
local base=np.array(0,"timedelta64[h]")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/()/timedelta64[h]/(1, 2): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),0,"empty-source/()/timedelta64[h]/(1, 2): backing source")
eq(base.shape,{},"empty-source/()/timedelta64[h]/(1, 2): backing source: shape")
eq(base.strides,{},"empty-source/()/timedelta64[h]/(1, 2): backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-source/()/timedelta64[h]/(1, 2): backing source: dtype")
eq(a.shape,{},"empty-source/()/timedelta64[h]/(1, 2): source shape")
eq(a.strides,{},"empty-source/()/timedelta64[h]/(1, 2): source strides")
cases=cases+1
end
-- 436: empty-source/(0,)/int32/(); source error=IndexError
do
local base=np.zeros({0},"int32")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0,)/int32/(): acceptance"..": "..tostring(result))
eq(base:tolist(),{},"empty-source/(0,)/int32/(): backing source")
eq(base.shape,{0},"empty-source/(0,)/int32/(): backing source: shape")
eq(base.strides,{0},"empty-source/(0,)/int32/(): backing source: strides")
eq(base.dtype,"int32","empty-source/(0,)/int32/(): backing source: dtype")
eq(a.shape,{0},"empty-source/(0,)/int32/(): source shape")
eq(a.strides,{0},"empty-source/(0,)/int32/(): source strides")
cases=cases+1
end
-- 437: empty-source/(0,)/int32/(0,); source error=None
do
local base=np.zeros({0},"int32")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(0,)/int32/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-source/(0,)/int32/(0,): result")
eq(result.shape,{0},"empty-source/(0,)/int32/(0,): result: shape")
eq(result.strides,{0},"empty-source/(0,)/int32/(0,): result: strides")
eq(result.dtype,"int32","empty-source/(0,)/int32/(0,): result: dtype")
eq(base:tolist(),{},"empty-source/(0,)/int32/(0,): backing source")
eq(base.shape,{0},"empty-source/(0,)/int32/(0,): backing source: shape")
eq(base.strides,{0},"empty-source/(0,)/int32/(0,): backing source: strides")
eq(base.dtype,"int32","empty-source/(0,)/int32/(0,): backing source: dtype")
eq(a.shape,{0},"empty-source/(0,)/int32/(0,): source shape")
eq(a.strides,{0},"empty-source/(0,)/int32/(0,): source strides")
cases=cases+1
end
-- 438: empty-source/(0,)/int32/(1,); source error=IndexError
do
local base=np.zeros({0},"int32")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0,)/int32/(1,): acceptance"..": "..tostring(result))
eq(base:tolist(),{},"empty-source/(0,)/int32/(1,): backing source")
eq(base.shape,{0},"empty-source/(0,)/int32/(1,): backing source: shape")
eq(base.strides,{0},"empty-source/(0,)/int32/(1,): backing source: strides")
eq(base.dtype,"int32","empty-source/(0,)/int32/(1,): backing source: dtype")
eq(a.shape,{0},"empty-source/(0,)/int32/(1,): source shape")
eq(a.strides,{0},"empty-source/(0,)/int32/(1,): source strides")
cases=cases+1
end
-- 439: empty-source/(0,)/int32/(2,); source error=IndexError
do
local base=np.zeros({0},"int32")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0,)/int32/(2,): acceptance"..": "..tostring(result))
eq(base:tolist(),{},"empty-source/(0,)/int32/(2,): backing source")
eq(base.shape,{0},"empty-source/(0,)/int32/(2,): backing source: shape")
eq(base.strides,{0},"empty-source/(0,)/int32/(2,): backing source: strides")
eq(base.dtype,"int32","empty-source/(0,)/int32/(2,): backing source: dtype")
eq(a.shape,{0},"empty-source/(0,)/int32/(2,): source shape")
eq(a.strides,{0},"empty-source/(0,)/int32/(2,): source strides")
cases=cases+1
end
-- 440: empty-source/(0,)/int32/(1, 2); source error=IndexError
do
local base=np.zeros({0},"int32")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0,)/int32/(1, 2): acceptance"..": "..tostring(result))
eq(base:tolist(),{},"empty-source/(0,)/int32/(1, 2): backing source")
eq(base.shape,{0},"empty-source/(0,)/int32/(1, 2): backing source: shape")
eq(base.strides,{0},"empty-source/(0,)/int32/(1, 2): backing source: strides")
eq(base.dtype,"int32","empty-source/(0,)/int32/(1, 2): backing source: dtype")
eq(a.shape,{0},"empty-source/(0,)/int32/(1, 2): source shape")
eq(a.strides,{0},"empty-source/(0,)/int32/(1, 2): source strides")
cases=cases+1
end
-- 441: empty-source/(0,)/float32/(); source error=IndexError
do
local base=np.zeros({0},"float32")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0,)/float32/(): acceptance"..": "..tostring(result))
eq(base:tolist(),{},"empty-source/(0,)/float32/(): backing source")
eq(base.shape,{0},"empty-source/(0,)/float32/(): backing source: shape")
eq(base.strides,{0},"empty-source/(0,)/float32/(): backing source: strides")
eq(base.dtype,"float32","empty-source/(0,)/float32/(): backing source: dtype")
eq(a.shape,{0},"empty-source/(0,)/float32/(): source shape")
eq(a.strides,{0},"empty-source/(0,)/float32/(): source strides")
cases=cases+1
end
-- 442: empty-source/(0,)/float32/(0,); source error=None
do
local base=np.zeros({0},"float32")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(0,)/float32/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-source/(0,)/float32/(0,): result")
eq(result.shape,{0},"empty-source/(0,)/float32/(0,): result: shape")
eq(result.strides,{0},"empty-source/(0,)/float32/(0,): result: strides")
eq(result.dtype,"float32","empty-source/(0,)/float32/(0,): result: dtype")
eq(base:tolist(),{},"empty-source/(0,)/float32/(0,): backing source")
eq(base.shape,{0},"empty-source/(0,)/float32/(0,): backing source: shape")
eq(base.strides,{0},"empty-source/(0,)/float32/(0,): backing source: strides")
eq(base.dtype,"float32","empty-source/(0,)/float32/(0,): backing source: dtype")
eq(a.shape,{0},"empty-source/(0,)/float32/(0,): source shape")
eq(a.strides,{0},"empty-source/(0,)/float32/(0,): source strides")
cases=cases+1
end
-- 443: empty-source/(0,)/float32/(1,); source error=IndexError
do
local base=np.zeros({0},"float32")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0,)/float32/(1,): acceptance"..": "..tostring(result))
eq(base:tolist(),{},"empty-source/(0,)/float32/(1,): backing source")
eq(base.shape,{0},"empty-source/(0,)/float32/(1,): backing source: shape")
eq(base.strides,{0},"empty-source/(0,)/float32/(1,): backing source: strides")
eq(base.dtype,"float32","empty-source/(0,)/float32/(1,): backing source: dtype")
eq(a.shape,{0},"empty-source/(0,)/float32/(1,): source shape")
eq(a.strides,{0},"empty-source/(0,)/float32/(1,): source strides")
cases=cases+1
end
-- 444: empty-source/(0,)/float32/(2,); source error=IndexError
do
local base=np.zeros({0},"float32")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0,)/float32/(2,): acceptance"..": "..tostring(result))
eq(base:tolist(),{},"empty-source/(0,)/float32/(2,): backing source")
eq(base.shape,{0},"empty-source/(0,)/float32/(2,): backing source: shape")
eq(base.strides,{0},"empty-source/(0,)/float32/(2,): backing source: strides")
eq(base.dtype,"float32","empty-source/(0,)/float32/(2,): backing source: dtype")
eq(a.shape,{0},"empty-source/(0,)/float32/(2,): source shape")
eq(a.strides,{0},"empty-source/(0,)/float32/(2,): source strides")
cases=cases+1
end
-- 445: empty-source/(0,)/float32/(1, 2); source error=IndexError
do
local base=np.zeros({0},"float32")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0,)/float32/(1, 2): acceptance"..": "..tostring(result))
eq(base:tolist(),{},"empty-source/(0,)/float32/(1, 2): backing source")
eq(base.shape,{0},"empty-source/(0,)/float32/(1, 2): backing source: shape")
eq(base.strides,{0},"empty-source/(0,)/float32/(1, 2): backing source: strides")
eq(base.dtype,"float32","empty-source/(0,)/float32/(1, 2): backing source: dtype")
eq(a.shape,{0},"empty-source/(0,)/float32/(1, 2): source shape")
eq(a.strides,{0},"empty-source/(0,)/float32/(1, 2): source strides")
cases=cases+1
end
-- 446: empty-source/(0,)/complex128/(); source error=IndexError
do
local base=np.zeros({0},"complex128")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0,)/complex128/(): acceptance"..": "..tostring(result))
eq(base:tolist(),{},"empty-source/(0,)/complex128/(): backing source")
eq(base.shape,{0},"empty-source/(0,)/complex128/(): backing source: shape")
eq(base.strides,{0},"empty-source/(0,)/complex128/(): backing source: strides")
eq(base.dtype,"complex128","empty-source/(0,)/complex128/(): backing source: dtype")
eq(a.shape,{0},"empty-source/(0,)/complex128/(): source shape")
eq(a.strides,{0},"empty-source/(0,)/complex128/(): source strides")
cases=cases+1
end
-- 447: empty-source/(0,)/complex128/(0,); source error=None
do
local base=np.zeros({0},"complex128")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(0,)/complex128/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-source/(0,)/complex128/(0,): result")
eq(result.shape,{0},"empty-source/(0,)/complex128/(0,): result: shape")
eq(result.strides,{0},"empty-source/(0,)/complex128/(0,): result: strides")
eq(result.dtype,"complex128","empty-source/(0,)/complex128/(0,): result: dtype")
eq(base:tolist(),{},"empty-source/(0,)/complex128/(0,): backing source")
eq(base.shape,{0},"empty-source/(0,)/complex128/(0,): backing source: shape")
eq(base.strides,{0},"empty-source/(0,)/complex128/(0,): backing source: strides")
eq(base.dtype,"complex128","empty-source/(0,)/complex128/(0,): backing source: dtype")
eq(a.shape,{0},"empty-source/(0,)/complex128/(0,): source shape")
eq(a.strides,{0},"empty-source/(0,)/complex128/(0,): source strides")
cases=cases+1
end
-- 448: empty-source/(0,)/complex128/(1,); source error=IndexError
do
local base=np.zeros({0},"complex128")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0,)/complex128/(1,): acceptance"..": "..tostring(result))
eq(base:tolist(),{},"empty-source/(0,)/complex128/(1,): backing source")
eq(base.shape,{0},"empty-source/(0,)/complex128/(1,): backing source: shape")
eq(base.strides,{0},"empty-source/(0,)/complex128/(1,): backing source: strides")
eq(base.dtype,"complex128","empty-source/(0,)/complex128/(1,): backing source: dtype")
eq(a.shape,{0},"empty-source/(0,)/complex128/(1,): source shape")
eq(a.strides,{0},"empty-source/(0,)/complex128/(1,): source strides")
cases=cases+1
end
-- 449: empty-source/(0,)/complex128/(2,); source error=IndexError
do
local base=np.zeros({0},"complex128")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0,)/complex128/(2,): acceptance"..": "..tostring(result))
eq(base:tolist(),{},"empty-source/(0,)/complex128/(2,): backing source")
eq(base.shape,{0},"empty-source/(0,)/complex128/(2,): backing source: shape")
eq(base.strides,{0},"empty-source/(0,)/complex128/(2,): backing source: strides")
eq(base.dtype,"complex128","empty-source/(0,)/complex128/(2,): backing source: dtype")
eq(a.shape,{0},"empty-source/(0,)/complex128/(2,): source shape")
eq(a.strides,{0},"empty-source/(0,)/complex128/(2,): source strides")
cases=cases+1
end
-- 450: empty-source/(0,)/complex128/(1, 2); source error=IndexError
do
local base=np.zeros({0},"complex128")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0,)/complex128/(1, 2): acceptance"..": "..tostring(result))
eq(base:tolist(),{},"empty-source/(0,)/complex128/(1, 2): backing source")
eq(base.shape,{0},"empty-source/(0,)/complex128/(1, 2): backing source: shape")
eq(base.strides,{0},"empty-source/(0,)/complex128/(1, 2): backing source: strides")
eq(base.dtype,"complex128","empty-source/(0,)/complex128/(1, 2): backing source: dtype")
eq(a.shape,{0},"empty-source/(0,)/complex128/(1, 2): source shape")
eq(a.strides,{0},"empty-source/(0,)/complex128/(1, 2): source strides")
cases=cases+1
end
-- 451: empty-source/(0,)/U4/(); source error=IndexError
do
local base=np.zeros({0},"<U4")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0,)/U4/(): acceptance"..": "..tostring(result))
eq(base:tolist(),{},"empty-source/(0,)/U4/(): backing source")
eq(base.shape,{0},"empty-source/(0,)/U4/(): backing source: shape")
eq(base.strides,{0},"empty-source/(0,)/U4/(): backing source: strides")
eq(base.dtype,"<U4","empty-source/(0,)/U4/(): backing source: dtype")
eq(a.shape,{0},"empty-source/(0,)/U4/(): source shape")
eq(a.strides,{0},"empty-source/(0,)/U4/(): source strides")
cases=cases+1
end
-- 452: empty-source/(0,)/U4/(0,); source error=None
do
local base=np.zeros({0},"<U4")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(0,)/U4/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-source/(0,)/U4/(0,): result")
eq(result.shape,{0},"empty-source/(0,)/U4/(0,): result: shape")
eq(result.strides,{0},"empty-source/(0,)/U4/(0,): result: strides")
eq(result.dtype,"<U4","empty-source/(0,)/U4/(0,): result: dtype")
eq(base:tolist(),{},"empty-source/(0,)/U4/(0,): backing source")
eq(base.shape,{0},"empty-source/(0,)/U4/(0,): backing source: shape")
eq(base.strides,{0},"empty-source/(0,)/U4/(0,): backing source: strides")
eq(base.dtype,"<U4","empty-source/(0,)/U4/(0,): backing source: dtype")
eq(a.shape,{0},"empty-source/(0,)/U4/(0,): source shape")
eq(a.strides,{0},"empty-source/(0,)/U4/(0,): source strides")
cases=cases+1
end
-- 453: empty-source/(0,)/U4/(1,); source error=IndexError
do
local base=np.zeros({0},"<U4")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0,)/U4/(1,): acceptance"..": "..tostring(result))
eq(base:tolist(),{},"empty-source/(0,)/U4/(1,): backing source")
eq(base.shape,{0},"empty-source/(0,)/U4/(1,): backing source: shape")
eq(base.strides,{0},"empty-source/(0,)/U4/(1,): backing source: strides")
eq(base.dtype,"<U4","empty-source/(0,)/U4/(1,): backing source: dtype")
eq(a.shape,{0},"empty-source/(0,)/U4/(1,): source shape")
eq(a.strides,{0},"empty-source/(0,)/U4/(1,): source strides")
cases=cases+1
end
-- 454: empty-source/(0,)/U4/(2,); source error=IndexError
do
local base=np.zeros({0},"<U4")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0,)/U4/(2,): acceptance"..": "..tostring(result))
eq(base:tolist(),{},"empty-source/(0,)/U4/(2,): backing source")
eq(base.shape,{0},"empty-source/(0,)/U4/(2,): backing source: shape")
eq(base.strides,{0},"empty-source/(0,)/U4/(2,): backing source: strides")
eq(base.dtype,"<U4","empty-source/(0,)/U4/(2,): backing source: dtype")
eq(a.shape,{0},"empty-source/(0,)/U4/(2,): source shape")
eq(a.strides,{0},"empty-source/(0,)/U4/(2,): source strides")
cases=cases+1
end
-- 455: empty-source/(0,)/U4/(1, 2); source error=IndexError
do
local base=np.zeros({0},"<U4")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0,)/U4/(1, 2): acceptance"..": "..tostring(result))
eq(base:tolist(),{},"empty-source/(0,)/U4/(1, 2): backing source")
eq(base.shape,{0},"empty-source/(0,)/U4/(1, 2): backing source: shape")
eq(base.strides,{0},"empty-source/(0,)/U4/(1, 2): backing source: strides")
eq(base.dtype,"<U4","empty-source/(0,)/U4/(1, 2): backing source: dtype")
eq(a.shape,{0},"empty-source/(0,)/U4/(1, 2): source shape")
eq(a.strides,{0},"empty-source/(0,)/U4/(1, 2): source strides")
cases=cases+1
end
-- 456: empty-source/(0,)/S4/(); source error=IndexError
do
local base=np.zeros({0},"|S4")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0,)/S4/(): acceptance"..": "..tostring(result))
eq(base:tolist(),{},"empty-source/(0,)/S4/(): backing source")
eq(base.shape,{0},"empty-source/(0,)/S4/(): backing source: shape")
eq(base.strides,{0},"empty-source/(0,)/S4/(): backing source: strides")
eq(base.dtype,"|S4","empty-source/(0,)/S4/(): backing source: dtype")
eq(a.shape,{0},"empty-source/(0,)/S4/(): source shape")
eq(a.strides,{0},"empty-source/(0,)/S4/(): source strides")
cases=cases+1
end
-- 457: empty-source/(0,)/S4/(0,); source error=None
do
local base=np.zeros({0},"|S4")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(0,)/S4/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-source/(0,)/S4/(0,): result")
eq(result.shape,{0},"empty-source/(0,)/S4/(0,): result: shape")
eq(result.strides,{0},"empty-source/(0,)/S4/(0,): result: strides")
eq(result.dtype,"|S4","empty-source/(0,)/S4/(0,): result: dtype")
eq(base:tolist(),{},"empty-source/(0,)/S4/(0,): backing source")
eq(base.shape,{0},"empty-source/(0,)/S4/(0,): backing source: shape")
eq(base.strides,{0},"empty-source/(0,)/S4/(0,): backing source: strides")
eq(base.dtype,"|S4","empty-source/(0,)/S4/(0,): backing source: dtype")
eq(a.shape,{0},"empty-source/(0,)/S4/(0,): source shape")
eq(a.strides,{0},"empty-source/(0,)/S4/(0,): source strides")
cases=cases+1
end
-- 458: empty-source/(0,)/S4/(1,); source error=IndexError
do
local base=np.zeros({0},"|S4")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0,)/S4/(1,): acceptance"..": "..tostring(result))
eq(base:tolist(),{},"empty-source/(0,)/S4/(1,): backing source")
eq(base.shape,{0},"empty-source/(0,)/S4/(1,): backing source: shape")
eq(base.strides,{0},"empty-source/(0,)/S4/(1,): backing source: strides")
eq(base.dtype,"|S4","empty-source/(0,)/S4/(1,): backing source: dtype")
eq(a.shape,{0},"empty-source/(0,)/S4/(1,): source shape")
eq(a.strides,{0},"empty-source/(0,)/S4/(1,): source strides")
cases=cases+1
end
-- 459: empty-source/(0,)/S4/(2,); source error=IndexError
do
local base=np.zeros({0},"|S4")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0,)/S4/(2,): acceptance"..": "..tostring(result))
eq(base:tolist(),{},"empty-source/(0,)/S4/(2,): backing source")
eq(base.shape,{0},"empty-source/(0,)/S4/(2,): backing source: shape")
eq(base.strides,{0},"empty-source/(0,)/S4/(2,): backing source: strides")
eq(base.dtype,"|S4","empty-source/(0,)/S4/(2,): backing source: dtype")
eq(a.shape,{0},"empty-source/(0,)/S4/(2,): source shape")
eq(a.strides,{0},"empty-source/(0,)/S4/(2,): source strides")
cases=cases+1
end
-- 460: empty-source/(0,)/S4/(1, 2); source error=IndexError
do
local base=np.zeros({0},"|S4")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0,)/S4/(1, 2): acceptance"..": "..tostring(result))
eq(base:tolist(),{},"empty-source/(0,)/S4/(1, 2): backing source")
eq(base.shape,{0},"empty-source/(0,)/S4/(1, 2): backing source: shape")
eq(base.strides,{0},"empty-source/(0,)/S4/(1, 2): backing source: strides")
eq(base.dtype,"|S4","empty-source/(0,)/S4/(1, 2): backing source: dtype")
eq(a.shape,{0},"empty-source/(0,)/S4/(1, 2): source shape")
eq(a.strides,{0},"empty-source/(0,)/S4/(1, 2): source strides")
cases=cases+1
end
-- 461: empty-source/(0,)/datetime64[D]/(); source error=IndexError
do
local base=np.zeros({0},"datetime64[D]")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0,)/datetime64[D]/(): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),{},"empty-source/(0,)/datetime64[D]/(): backing source")
eq(base.shape,{0},"empty-source/(0,)/datetime64[D]/(): backing source: shape")
eq(base.strides,{0},"empty-source/(0,)/datetime64[D]/(): backing source: strides")
eq(base.dtype,"datetime64[D]","empty-source/(0,)/datetime64[D]/(): backing source: dtype")
eq(a.shape,{0},"empty-source/(0,)/datetime64[D]/(): source shape")
eq(a.strides,{0},"empty-source/(0,)/datetime64[D]/(): source strides")
cases=cases+1
end
-- 462: empty-source/(0,)/datetime64[D]/(0,); source error=None
do
local base=np.zeros({0},"datetime64[D]")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(0,)/datetime64[D]/(0,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{},"empty-source/(0,)/datetime64[D]/(0,): result")
eq(result.shape,{0},"empty-source/(0,)/datetime64[D]/(0,): result: shape")
eq(result.strides,{0},"empty-source/(0,)/datetime64[D]/(0,): result: strides")
eq(result.dtype,"datetime64[D]","empty-source/(0,)/datetime64[D]/(0,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{},"empty-source/(0,)/datetime64[D]/(0,): backing source")
eq(base.shape,{0},"empty-source/(0,)/datetime64[D]/(0,): backing source: shape")
eq(base.strides,{0},"empty-source/(0,)/datetime64[D]/(0,): backing source: strides")
eq(base.dtype,"datetime64[D]","empty-source/(0,)/datetime64[D]/(0,): backing source: dtype")
eq(a.shape,{0},"empty-source/(0,)/datetime64[D]/(0,): source shape")
eq(a.strides,{0},"empty-source/(0,)/datetime64[D]/(0,): source strides")
cases=cases+1
end
-- 463: empty-source/(0,)/datetime64[D]/(1,); source error=IndexError
do
local base=np.zeros({0},"datetime64[D]")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0,)/datetime64[D]/(1,): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),{},"empty-source/(0,)/datetime64[D]/(1,): backing source")
eq(base.shape,{0},"empty-source/(0,)/datetime64[D]/(1,): backing source: shape")
eq(base.strides,{0},"empty-source/(0,)/datetime64[D]/(1,): backing source: strides")
eq(base.dtype,"datetime64[D]","empty-source/(0,)/datetime64[D]/(1,): backing source: dtype")
eq(a.shape,{0},"empty-source/(0,)/datetime64[D]/(1,): source shape")
eq(a.strides,{0},"empty-source/(0,)/datetime64[D]/(1,): source strides")
cases=cases+1
end
-- 464: empty-source/(0,)/datetime64[D]/(2,); source error=IndexError
do
local base=np.zeros({0},"datetime64[D]")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0,)/datetime64[D]/(2,): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),{},"empty-source/(0,)/datetime64[D]/(2,): backing source")
eq(base.shape,{0},"empty-source/(0,)/datetime64[D]/(2,): backing source: shape")
eq(base.strides,{0},"empty-source/(0,)/datetime64[D]/(2,): backing source: strides")
eq(base.dtype,"datetime64[D]","empty-source/(0,)/datetime64[D]/(2,): backing source: dtype")
eq(a.shape,{0},"empty-source/(0,)/datetime64[D]/(2,): source shape")
eq(a.strides,{0},"empty-source/(0,)/datetime64[D]/(2,): source strides")
cases=cases+1
end
-- 465: empty-source/(0,)/datetime64[D]/(1, 2); source error=IndexError
do
local base=np.zeros({0},"datetime64[D]")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0,)/datetime64[D]/(1, 2): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),{},"empty-source/(0,)/datetime64[D]/(1, 2): backing source")
eq(base.shape,{0},"empty-source/(0,)/datetime64[D]/(1, 2): backing source: shape")
eq(base.strides,{0},"empty-source/(0,)/datetime64[D]/(1, 2): backing source: strides")
eq(base.dtype,"datetime64[D]","empty-source/(0,)/datetime64[D]/(1, 2): backing source: dtype")
eq(a.shape,{0},"empty-source/(0,)/datetime64[D]/(1, 2): source shape")
eq(a.strides,{0},"empty-source/(0,)/datetime64[D]/(1, 2): source strides")
cases=cases+1
end
-- 466: empty-source/(0,)/timedelta64[h]/(); source error=IndexError
do
local base=np.zeros({0},"timedelta64[h]")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0,)/timedelta64[h]/(): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),{},"empty-source/(0,)/timedelta64[h]/(): backing source")
eq(base.shape,{0},"empty-source/(0,)/timedelta64[h]/(): backing source: shape")
eq(base.strides,{0},"empty-source/(0,)/timedelta64[h]/(): backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-source/(0,)/timedelta64[h]/(): backing source: dtype")
eq(a.shape,{0},"empty-source/(0,)/timedelta64[h]/(): source shape")
eq(a.strides,{0},"empty-source/(0,)/timedelta64[h]/(): source strides")
cases=cases+1
end
-- 467: empty-source/(0,)/timedelta64[h]/(0,); source error=None
do
local base=np.zeros({0},"timedelta64[h]")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(0,)/timedelta64[h]/(0,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{},"empty-source/(0,)/timedelta64[h]/(0,): result")
eq(result.shape,{0},"empty-source/(0,)/timedelta64[h]/(0,): result: shape")
eq(result.strides,{0},"empty-source/(0,)/timedelta64[h]/(0,): result: strides")
eq(result.dtype,"timedelta64[h]","empty-source/(0,)/timedelta64[h]/(0,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{},"empty-source/(0,)/timedelta64[h]/(0,): backing source")
eq(base.shape,{0},"empty-source/(0,)/timedelta64[h]/(0,): backing source: shape")
eq(base.strides,{0},"empty-source/(0,)/timedelta64[h]/(0,): backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-source/(0,)/timedelta64[h]/(0,): backing source: dtype")
eq(a.shape,{0},"empty-source/(0,)/timedelta64[h]/(0,): source shape")
eq(a.strides,{0},"empty-source/(0,)/timedelta64[h]/(0,): source strides")
cases=cases+1
end
-- 468: empty-source/(0,)/timedelta64[h]/(1,); source error=IndexError
do
local base=np.zeros({0},"timedelta64[h]")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0,)/timedelta64[h]/(1,): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),{},"empty-source/(0,)/timedelta64[h]/(1,): backing source")
eq(base.shape,{0},"empty-source/(0,)/timedelta64[h]/(1,): backing source: shape")
eq(base.strides,{0},"empty-source/(0,)/timedelta64[h]/(1,): backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-source/(0,)/timedelta64[h]/(1,): backing source: dtype")
eq(a.shape,{0},"empty-source/(0,)/timedelta64[h]/(1,): source shape")
eq(a.strides,{0},"empty-source/(0,)/timedelta64[h]/(1,): source strides")
cases=cases+1
end
-- 469: empty-source/(0,)/timedelta64[h]/(2,); source error=IndexError
do
local base=np.zeros({0},"timedelta64[h]")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0,)/timedelta64[h]/(2,): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),{},"empty-source/(0,)/timedelta64[h]/(2,): backing source")
eq(base.shape,{0},"empty-source/(0,)/timedelta64[h]/(2,): backing source: shape")
eq(base.strides,{0},"empty-source/(0,)/timedelta64[h]/(2,): backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-source/(0,)/timedelta64[h]/(2,): backing source: dtype")
eq(a.shape,{0},"empty-source/(0,)/timedelta64[h]/(2,): source shape")
eq(a.strides,{0},"empty-source/(0,)/timedelta64[h]/(2,): source strides")
cases=cases+1
end
-- 470: empty-source/(0,)/timedelta64[h]/(1, 2); source error=IndexError
do
local base=np.zeros({0},"timedelta64[h]")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0,)/timedelta64[h]/(1, 2): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),{},"empty-source/(0,)/timedelta64[h]/(1, 2): backing source")
eq(base.shape,{0},"empty-source/(0,)/timedelta64[h]/(1, 2): backing source: shape")
eq(base.strides,{0},"empty-source/(0,)/timedelta64[h]/(1, 2): backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-source/(0,)/timedelta64[h]/(1, 2): backing source: dtype")
eq(a.shape,{0},"empty-source/(0,)/timedelta64[h]/(1, 2): source shape")
eq(a.strides,{0},"empty-source/(0,)/timedelta64[h]/(1, 2): source strides")
cases=cases+1
end
-- 471: empty-source/(1,)/int32/(); source error=None
do
local base=np.array({0},"int32")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(1,)/int32/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{0},"empty-source/(1,)/int32/(): result")
eq(result.shape,{1},"empty-source/(1,)/int32/(): result: shape")
eq(result.strides,{4},"empty-source/(1,)/int32/(): result: strides")
eq(result.dtype,"int32","empty-source/(1,)/int32/(): result: dtype")
eq(base:tolist(),{0},"empty-source/(1,)/int32/(): backing source")
eq(base.shape,{1},"empty-source/(1,)/int32/(): backing source: shape")
eq(base.strides,{4},"empty-source/(1,)/int32/(): backing source: strides")
eq(base.dtype,"int32","empty-source/(1,)/int32/(): backing source: dtype")
eq(a.shape,{1},"empty-source/(1,)/int32/(): source shape")
eq(a.strides,{4},"empty-source/(1,)/int32/(): source strides")
cases=cases+1
end
-- 472: empty-source/(1,)/int32/(0,); source error=None
do
local base=np.array({0},"int32")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(1,)/int32/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-source/(1,)/int32/(0,): result")
eq(result.shape,{0},"empty-source/(1,)/int32/(0,): result: shape")
eq(result.strides,{0},"empty-source/(1,)/int32/(0,): result: strides")
eq(result.dtype,"int32","empty-source/(1,)/int32/(0,): result: dtype")
eq(base:tolist(),{0},"empty-source/(1,)/int32/(0,): backing source")
eq(base.shape,{1},"empty-source/(1,)/int32/(0,): backing source: shape")
eq(base.strides,{4},"empty-source/(1,)/int32/(0,): backing source: strides")
eq(base.dtype,"int32","empty-source/(1,)/int32/(0,): backing source: dtype")
eq(a.shape,{1},"empty-source/(1,)/int32/(0,): source shape")
eq(a.strides,{4},"empty-source/(1,)/int32/(0,): source strides")
cases=cases+1
end
-- 473: empty-source/(1,)/int32/(1,); source error=None
do
local base=np.array({0},"int32")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(1,)/int32/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0},"empty-source/(1,)/int32/(1,): result")
eq(result.shape,{1},"empty-source/(1,)/int32/(1,): result: shape")
eq(result.strides,{4},"empty-source/(1,)/int32/(1,): result: strides")
eq(result.dtype,"int32","empty-source/(1,)/int32/(1,): result: dtype")
eq(base:tolist(),{0},"empty-source/(1,)/int32/(1,): backing source")
eq(base.shape,{1},"empty-source/(1,)/int32/(1,): backing source: shape")
eq(base.strides,{4},"empty-source/(1,)/int32/(1,): backing source: strides")
eq(base.dtype,"int32","empty-source/(1,)/int32/(1,): backing source: dtype")
eq(a.shape,{1},"empty-source/(1,)/int32/(1,): source shape")
eq(a.strides,{4},"empty-source/(1,)/int32/(1,): source strides")
cases=cases+1
end
-- 474: empty-source/(1,)/int32/(2,); source error=IndexError
do
local base=np.array({0},"int32")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(1,)/int32/(2,): acceptance"..": "..tostring(result))
eq(base:tolist(),{0},"empty-source/(1,)/int32/(2,): backing source")
eq(base.shape,{1},"empty-source/(1,)/int32/(2,): backing source: shape")
eq(base.strides,{4},"empty-source/(1,)/int32/(2,): backing source: strides")
eq(base.dtype,"int32","empty-source/(1,)/int32/(2,): backing source: dtype")
eq(a.shape,{1},"empty-source/(1,)/int32/(2,): source shape")
eq(a.strides,{4},"empty-source/(1,)/int32/(2,): source strides")
cases=cases+1
end
-- 475: empty-source/(1,)/int32/(1, 2); source error=IndexError
do
local base=np.array({0},"int32")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(1,)/int32/(1, 2): acceptance"..": "..tostring(result))
eq(base:tolist(),{0},"empty-source/(1,)/int32/(1, 2): backing source")
eq(base.shape,{1},"empty-source/(1,)/int32/(1, 2): backing source: shape")
eq(base.strides,{4},"empty-source/(1,)/int32/(1, 2): backing source: strides")
eq(base.dtype,"int32","empty-source/(1,)/int32/(1, 2): backing source: dtype")
eq(a.shape,{1},"empty-source/(1,)/int32/(1, 2): source shape")
eq(a.strides,{4},"empty-source/(1,)/int32/(1, 2): source strides")
cases=cases+1
end
-- 476: empty-source/(1,)/float32/(); source error=None
do
local base=np.array({0.0},"float32")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(1,)/float32/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"empty-source/(1,)/float32/(): result")
eq(result.shape,{1},"empty-source/(1,)/float32/(): result: shape")
eq(result.strides,{4},"empty-source/(1,)/float32/(): result: strides")
eq(result.dtype,"float32","empty-source/(1,)/float32/(): result: dtype")
eq(base:tolist(),{0.0},"empty-source/(1,)/float32/(): backing source")
eq(base.shape,{1},"empty-source/(1,)/float32/(): backing source: shape")
eq(base.strides,{4},"empty-source/(1,)/float32/(): backing source: strides")
eq(base.dtype,"float32","empty-source/(1,)/float32/(): backing source: dtype")
eq(a.shape,{1},"empty-source/(1,)/float32/(): source shape")
eq(a.strides,{4},"empty-source/(1,)/float32/(): source strides")
cases=cases+1
end
-- 477: empty-source/(1,)/float32/(0,); source error=None
do
local base=np.array({0.0},"float32")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(1,)/float32/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-source/(1,)/float32/(0,): result")
eq(result.shape,{0},"empty-source/(1,)/float32/(0,): result: shape")
eq(result.strides,{0},"empty-source/(1,)/float32/(0,): result: strides")
eq(result.dtype,"float32","empty-source/(1,)/float32/(0,): result: dtype")
eq(base:tolist(),{0.0},"empty-source/(1,)/float32/(0,): backing source")
eq(base.shape,{1},"empty-source/(1,)/float32/(0,): backing source: shape")
eq(base.strides,{4},"empty-source/(1,)/float32/(0,): backing source: strides")
eq(base.dtype,"float32","empty-source/(1,)/float32/(0,): backing source: dtype")
eq(a.shape,{1},"empty-source/(1,)/float32/(0,): source shape")
eq(a.strides,{4},"empty-source/(1,)/float32/(0,): source strides")
cases=cases+1
end
-- 478: empty-source/(1,)/float32/(1,); source error=None
do
local base=np.array({0.0},"float32")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(1,)/float32/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"empty-source/(1,)/float32/(1,): result")
eq(result.shape,{1},"empty-source/(1,)/float32/(1,): result: shape")
eq(result.strides,{4},"empty-source/(1,)/float32/(1,): result: strides")
eq(result.dtype,"float32","empty-source/(1,)/float32/(1,): result: dtype")
eq(base:tolist(),{0.0},"empty-source/(1,)/float32/(1,): backing source")
eq(base.shape,{1},"empty-source/(1,)/float32/(1,): backing source: shape")
eq(base.strides,{4},"empty-source/(1,)/float32/(1,): backing source: strides")
eq(base.dtype,"float32","empty-source/(1,)/float32/(1,): backing source: dtype")
eq(a.shape,{1},"empty-source/(1,)/float32/(1,): source shape")
eq(a.strides,{4},"empty-source/(1,)/float32/(1,): source strides")
cases=cases+1
end
-- 479: empty-source/(1,)/float32/(2,); source error=IndexError
do
local base=np.array({0.0},"float32")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(1,)/float32/(2,): acceptance"..": "..tostring(result))
eq(base:tolist(),{0.0},"empty-source/(1,)/float32/(2,): backing source")
eq(base.shape,{1},"empty-source/(1,)/float32/(2,): backing source: shape")
eq(base.strides,{4},"empty-source/(1,)/float32/(2,): backing source: strides")
eq(base.dtype,"float32","empty-source/(1,)/float32/(2,): backing source: dtype")
eq(a.shape,{1},"empty-source/(1,)/float32/(2,): source shape")
eq(a.strides,{4},"empty-source/(1,)/float32/(2,): source strides")
cases=cases+1
end
-- 480: empty-source/(1,)/float32/(1, 2); source error=IndexError
do
local base=np.array({0.0},"float32")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(1,)/float32/(1, 2): acceptance"..": "..tostring(result))
eq(base:tolist(),{0.0},"empty-source/(1,)/float32/(1, 2): backing source")
eq(base.shape,{1},"empty-source/(1,)/float32/(1, 2): backing source: shape")
eq(base.strides,{4},"empty-source/(1,)/float32/(1, 2): backing source: strides")
eq(base.dtype,"float32","empty-source/(1,)/float32/(1, 2): backing source: dtype")
eq(a.shape,{1},"empty-source/(1,)/float32/(1, 2): source shape")
eq(a.strides,{4},"empty-source/(1,)/float32/(1, 2): source strides")
cases=cases+1
end
-- 481: empty-source/(1,)/complex128/(); source error=None
do
local base=np.array({np.complex(0.0,0.0)},"complex128")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(1,)/complex128/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0)},"empty-source/(1,)/complex128/(): result")
eq(result.shape,{1},"empty-source/(1,)/complex128/(): result: shape")
eq(result.strides,{16},"empty-source/(1,)/complex128/(): result: strides")
eq(result.dtype,"complex128","empty-source/(1,)/complex128/(): result: dtype")
eq(base:tolist(),{np.complex(0.0,0.0)},"empty-source/(1,)/complex128/(): backing source")
eq(base.shape,{1},"empty-source/(1,)/complex128/(): backing source: shape")
eq(base.strides,{16},"empty-source/(1,)/complex128/(): backing source: strides")
eq(base.dtype,"complex128","empty-source/(1,)/complex128/(): backing source: dtype")
eq(a.shape,{1},"empty-source/(1,)/complex128/(): source shape")
eq(a.strides,{16},"empty-source/(1,)/complex128/(): source strides")
cases=cases+1
end
-- 482: empty-source/(1,)/complex128/(0,); source error=None
do
local base=np.array({np.complex(0.0,0.0)},"complex128")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(1,)/complex128/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-source/(1,)/complex128/(0,): result")
eq(result.shape,{0},"empty-source/(1,)/complex128/(0,): result: shape")
eq(result.strides,{0},"empty-source/(1,)/complex128/(0,): result: strides")
eq(result.dtype,"complex128","empty-source/(1,)/complex128/(0,): result: dtype")
eq(base:tolist(),{np.complex(0.0,0.0)},"empty-source/(1,)/complex128/(0,): backing source")
eq(base.shape,{1},"empty-source/(1,)/complex128/(0,): backing source: shape")
eq(base.strides,{16},"empty-source/(1,)/complex128/(0,): backing source: strides")
eq(base.dtype,"complex128","empty-source/(1,)/complex128/(0,): backing source: dtype")
eq(a.shape,{1},"empty-source/(1,)/complex128/(0,): source shape")
eq(a.strides,{16},"empty-source/(1,)/complex128/(0,): source strides")
cases=cases+1
end
-- 483: empty-source/(1,)/complex128/(1,); source error=None
do
local base=np.array({np.complex(0.0,0.0)},"complex128")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(1,)/complex128/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0)},"empty-source/(1,)/complex128/(1,): result")
eq(result.shape,{1},"empty-source/(1,)/complex128/(1,): result: shape")
eq(result.strides,{16},"empty-source/(1,)/complex128/(1,): result: strides")
eq(result.dtype,"complex128","empty-source/(1,)/complex128/(1,): result: dtype")
eq(base:tolist(),{np.complex(0.0,0.0)},"empty-source/(1,)/complex128/(1,): backing source")
eq(base.shape,{1},"empty-source/(1,)/complex128/(1,): backing source: shape")
eq(base.strides,{16},"empty-source/(1,)/complex128/(1,): backing source: strides")
eq(base.dtype,"complex128","empty-source/(1,)/complex128/(1,): backing source: dtype")
eq(a.shape,{1},"empty-source/(1,)/complex128/(1,): source shape")
eq(a.strides,{16},"empty-source/(1,)/complex128/(1,): source strides")
cases=cases+1
end
-- 484: empty-source/(1,)/complex128/(2,); source error=IndexError
do
local base=np.array({np.complex(0.0,0.0)},"complex128")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(1,)/complex128/(2,): acceptance"..": "..tostring(result))
eq(base:tolist(),{np.complex(0.0,0.0)},"empty-source/(1,)/complex128/(2,): backing source")
eq(base.shape,{1},"empty-source/(1,)/complex128/(2,): backing source: shape")
eq(base.strides,{16},"empty-source/(1,)/complex128/(2,): backing source: strides")
eq(base.dtype,"complex128","empty-source/(1,)/complex128/(2,): backing source: dtype")
eq(a.shape,{1},"empty-source/(1,)/complex128/(2,): source shape")
eq(a.strides,{16},"empty-source/(1,)/complex128/(2,): source strides")
cases=cases+1
end
-- 485: empty-source/(1,)/complex128/(1, 2); source error=IndexError
do
local base=np.array({np.complex(0.0,0.0)},"complex128")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(1,)/complex128/(1, 2): acceptance"..": "..tostring(result))
eq(base:tolist(),{np.complex(0.0,0.0)},"empty-source/(1,)/complex128/(1, 2): backing source")
eq(base.shape,{1},"empty-source/(1,)/complex128/(1, 2): backing source: shape")
eq(base.strides,{16},"empty-source/(1,)/complex128/(1, 2): backing source: strides")
eq(base.dtype,"complex128","empty-source/(1,)/complex128/(1, 2): backing source: dtype")
eq(a.shape,{1},"empty-source/(1,)/complex128/(1, 2): source shape")
eq(a.strides,{16},"empty-source/(1,)/complex128/(1, 2): source strides")
cases=cases+1
end
-- 486: empty-source/(1,)/U4/(); source error=None
do
local base=np.array({""},"<U4")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(1,)/U4/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{""},"empty-source/(1,)/U4/(): result")
eq(result.shape,{1},"empty-source/(1,)/U4/(): result: shape")
eq(result.strides,{16},"empty-source/(1,)/U4/(): result: strides")
eq(result.dtype,"<U4","empty-source/(1,)/U4/(): result: dtype")
eq(base:tolist(),{""},"empty-source/(1,)/U4/(): backing source")
eq(base.shape,{1},"empty-source/(1,)/U4/(): backing source: shape")
eq(base.strides,{16},"empty-source/(1,)/U4/(): backing source: strides")
eq(base.dtype,"<U4","empty-source/(1,)/U4/(): backing source: dtype")
eq(a.shape,{1},"empty-source/(1,)/U4/(): source shape")
eq(a.strides,{16},"empty-source/(1,)/U4/(): source strides")
cases=cases+1
end
-- 487: empty-source/(1,)/U4/(0,); source error=None
do
local base=np.array({""},"<U4")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(1,)/U4/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-source/(1,)/U4/(0,): result")
eq(result.shape,{0},"empty-source/(1,)/U4/(0,): result: shape")
eq(result.strides,{0},"empty-source/(1,)/U4/(0,): result: strides")
eq(result.dtype,"<U4","empty-source/(1,)/U4/(0,): result: dtype")
eq(base:tolist(),{""},"empty-source/(1,)/U4/(0,): backing source")
eq(base.shape,{1},"empty-source/(1,)/U4/(0,): backing source: shape")
eq(base.strides,{16},"empty-source/(1,)/U4/(0,): backing source: strides")
eq(base.dtype,"<U4","empty-source/(1,)/U4/(0,): backing source: dtype")
eq(a.shape,{1},"empty-source/(1,)/U4/(0,): source shape")
eq(a.strides,{16},"empty-source/(1,)/U4/(0,): source strides")
cases=cases+1
end
-- 488: empty-source/(1,)/U4/(1,); source error=None
do
local base=np.array({""},"<U4")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(1,)/U4/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{""},"empty-source/(1,)/U4/(1,): result")
eq(result.shape,{1},"empty-source/(1,)/U4/(1,): result: shape")
eq(result.strides,{16},"empty-source/(1,)/U4/(1,): result: strides")
eq(result.dtype,"<U4","empty-source/(1,)/U4/(1,): result: dtype")
eq(base:tolist(),{""},"empty-source/(1,)/U4/(1,): backing source")
eq(base.shape,{1},"empty-source/(1,)/U4/(1,): backing source: shape")
eq(base.strides,{16},"empty-source/(1,)/U4/(1,): backing source: strides")
eq(base.dtype,"<U4","empty-source/(1,)/U4/(1,): backing source: dtype")
eq(a.shape,{1},"empty-source/(1,)/U4/(1,): source shape")
eq(a.strides,{16},"empty-source/(1,)/U4/(1,): source strides")
cases=cases+1
end
-- 489: empty-source/(1,)/U4/(2,); source error=IndexError
do
local base=np.array({""},"<U4")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(1,)/U4/(2,): acceptance"..": "..tostring(result))
eq(base:tolist(),{""},"empty-source/(1,)/U4/(2,): backing source")
eq(base.shape,{1},"empty-source/(1,)/U4/(2,): backing source: shape")
eq(base.strides,{16},"empty-source/(1,)/U4/(2,): backing source: strides")
eq(base.dtype,"<U4","empty-source/(1,)/U4/(2,): backing source: dtype")
eq(a.shape,{1},"empty-source/(1,)/U4/(2,): source shape")
eq(a.strides,{16},"empty-source/(1,)/U4/(2,): source strides")
cases=cases+1
end
-- 490: empty-source/(1,)/U4/(1, 2); source error=IndexError
do
local base=np.array({""},"<U4")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(1,)/U4/(1, 2): acceptance"..": "..tostring(result))
eq(base:tolist(),{""},"empty-source/(1,)/U4/(1, 2): backing source")
eq(base.shape,{1},"empty-source/(1,)/U4/(1, 2): backing source: shape")
eq(base.strides,{16},"empty-source/(1,)/U4/(1, 2): backing source: strides")
eq(base.dtype,"<U4","empty-source/(1,)/U4/(1, 2): backing source: dtype")
eq(a.shape,{1},"empty-source/(1,)/U4/(1, 2): source shape")
eq(a.strides,{16},"empty-source/(1,)/U4/(1, 2): source strides")
cases=cases+1
end
-- 491: empty-source/(1,)/S4/(); source error=None
do
local base=np.array({""},"|S4")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(1,)/S4/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{""},"empty-source/(1,)/S4/(): result")
eq(result.shape,{1},"empty-source/(1,)/S4/(): result: shape")
eq(result.strides,{4},"empty-source/(1,)/S4/(): result: strides")
eq(result.dtype,"|S4","empty-source/(1,)/S4/(): result: dtype")
eq(base:tolist(),{""},"empty-source/(1,)/S4/(): backing source")
eq(base.shape,{1},"empty-source/(1,)/S4/(): backing source: shape")
eq(base.strides,{4},"empty-source/(1,)/S4/(): backing source: strides")
eq(base.dtype,"|S4","empty-source/(1,)/S4/(): backing source: dtype")
eq(a.shape,{1},"empty-source/(1,)/S4/(): source shape")
eq(a.strides,{4},"empty-source/(1,)/S4/(): source strides")
cases=cases+1
end
-- 492: empty-source/(1,)/S4/(0,); source error=None
do
local base=np.array({""},"|S4")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(1,)/S4/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-source/(1,)/S4/(0,): result")
eq(result.shape,{0},"empty-source/(1,)/S4/(0,): result: shape")
eq(result.strides,{0},"empty-source/(1,)/S4/(0,): result: strides")
eq(result.dtype,"|S4","empty-source/(1,)/S4/(0,): result: dtype")
eq(base:tolist(),{""},"empty-source/(1,)/S4/(0,): backing source")
eq(base.shape,{1},"empty-source/(1,)/S4/(0,): backing source: shape")
eq(base.strides,{4},"empty-source/(1,)/S4/(0,): backing source: strides")
eq(base.dtype,"|S4","empty-source/(1,)/S4/(0,): backing source: dtype")
eq(a.shape,{1},"empty-source/(1,)/S4/(0,): source shape")
eq(a.strides,{4},"empty-source/(1,)/S4/(0,): source strides")
cases=cases+1
end
-- 493: empty-source/(1,)/S4/(1,); source error=None
do
local base=np.array({""},"|S4")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(1,)/S4/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{""},"empty-source/(1,)/S4/(1,): result")
eq(result.shape,{1},"empty-source/(1,)/S4/(1,): result: shape")
eq(result.strides,{4},"empty-source/(1,)/S4/(1,): result: strides")
eq(result.dtype,"|S4","empty-source/(1,)/S4/(1,): result: dtype")
eq(base:tolist(),{""},"empty-source/(1,)/S4/(1,): backing source")
eq(base.shape,{1},"empty-source/(1,)/S4/(1,): backing source: shape")
eq(base.strides,{4},"empty-source/(1,)/S4/(1,): backing source: strides")
eq(base.dtype,"|S4","empty-source/(1,)/S4/(1,): backing source: dtype")
eq(a.shape,{1},"empty-source/(1,)/S4/(1,): source shape")
eq(a.strides,{4},"empty-source/(1,)/S4/(1,): source strides")
cases=cases+1
end
-- 494: empty-source/(1,)/S4/(2,); source error=IndexError
do
local base=np.array({""},"|S4")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(1,)/S4/(2,): acceptance"..": "..tostring(result))
eq(base:tolist(),{""},"empty-source/(1,)/S4/(2,): backing source")
eq(base.shape,{1},"empty-source/(1,)/S4/(2,): backing source: shape")
eq(base.strides,{4},"empty-source/(1,)/S4/(2,): backing source: strides")
eq(base.dtype,"|S4","empty-source/(1,)/S4/(2,): backing source: dtype")
eq(a.shape,{1},"empty-source/(1,)/S4/(2,): source shape")
eq(a.strides,{4},"empty-source/(1,)/S4/(2,): source strides")
cases=cases+1
end
-- 495: empty-source/(1,)/S4/(1, 2); source error=IndexError
do
local base=np.array({""},"|S4")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(1,)/S4/(1, 2): acceptance"..": "..tostring(result))
eq(base:tolist(),{""},"empty-source/(1,)/S4/(1, 2): backing source")
eq(base.shape,{1},"empty-source/(1,)/S4/(1, 2): backing source: shape")
eq(base.strides,{4},"empty-source/(1,)/S4/(1, 2): backing source: strides")
eq(base.dtype,"|S4","empty-source/(1,)/S4/(1, 2): backing source: dtype")
eq(a.shape,{1},"empty-source/(1,)/S4/(1, 2): source shape")
eq(a.strides,{4},"empty-source/(1,)/S4/(1, 2): source strides")
cases=cases+1
end
-- 496: empty-source/(1,)/datetime64[D]/(); source error=None
do
local base=np.array({0},"datetime64[D]")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(1,)/datetime64[D]/(): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0},"empty-source/(1,)/datetime64[D]/(): result")
eq(result.shape,{1},"empty-source/(1,)/datetime64[D]/(): result: shape")
eq(result.strides,{8},"empty-source/(1,)/datetime64[D]/(): result: strides")
eq(result.dtype,"datetime64[D]","empty-source/(1,)/datetime64[D]/(): result: dtype")
eq(np.astype(base,'int64'):tolist(),{0},"empty-source/(1,)/datetime64[D]/(): backing source")
eq(base.shape,{1},"empty-source/(1,)/datetime64[D]/(): backing source: shape")
eq(base.strides,{8},"empty-source/(1,)/datetime64[D]/(): backing source: strides")
eq(base.dtype,"datetime64[D]","empty-source/(1,)/datetime64[D]/(): backing source: dtype")
eq(a.shape,{1},"empty-source/(1,)/datetime64[D]/(): source shape")
eq(a.strides,{8},"empty-source/(1,)/datetime64[D]/(): source strides")
cases=cases+1
end
-- 497: empty-source/(1,)/datetime64[D]/(0,); source error=None
do
local base=np.array({0},"datetime64[D]")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(1,)/datetime64[D]/(0,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{},"empty-source/(1,)/datetime64[D]/(0,): result")
eq(result.shape,{0},"empty-source/(1,)/datetime64[D]/(0,): result: shape")
eq(result.strides,{0},"empty-source/(1,)/datetime64[D]/(0,): result: strides")
eq(result.dtype,"datetime64[D]","empty-source/(1,)/datetime64[D]/(0,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{0},"empty-source/(1,)/datetime64[D]/(0,): backing source")
eq(base.shape,{1},"empty-source/(1,)/datetime64[D]/(0,): backing source: shape")
eq(base.strides,{8},"empty-source/(1,)/datetime64[D]/(0,): backing source: strides")
eq(base.dtype,"datetime64[D]","empty-source/(1,)/datetime64[D]/(0,): backing source: dtype")
eq(a.shape,{1},"empty-source/(1,)/datetime64[D]/(0,): source shape")
eq(a.strides,{8},"empty-source/(1,)/datetime64[D]/(0,): source strides")
cases=cases+1
end
-- 498: empty-source/(1,)/datetime64[D]/(1,); source error=None
do
local base=np.array({0},"datetime64[D]")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(1,)/datetime64[D]/(1,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0},"empty-source/(1,)/datetime64[D]/(1,): result")
eq(result.shape,{1},"empty-source/(1,)/datetime64[D]/(1,): result: shape")
eq(result.strides,{8},"empty-source/(1,)/datetime64[D]/(1,): result: strides")
eq(result.dtype,"datetime64[D]","empty-source/(1,)/datetime64[D]/(1,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{0},"empty-source/(1,)/datetime64[D]/(1,): backing source")
eq(base.shape,{1},"empty-source/(1,)/datetime64[D]/(1,): backing source: shape")
eq(base.strides,{8},"empty-source/(1,)/datetime64[D]/(1,): backing source: strides")
eq(base.dtype,"datetime64[D]","empty-source/(1,)/datetime64[D]/(1,): backing source: dtype")
eq(a.shape,{1},"empty-source/(1,)/datetime64[D]/(1,): source shape")
eq(a.strides,{8},"empty-source/(1,)/datetime64[D]/(1,): source strides")
cases=cases+1
end
-- 499: empty-source/(1,)/datetime64[D]/(2,); source error=IndexError
do
local base=np.array({0},"datetime64[D]")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(1,)/datetime64[D]/(2,): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),{0},"empty-source/(1,)/datetime64[D]/(2,): backing source")
eq(base.shape,{1},"empty-source/(1,)/datetime64[D]/(2,): backing source: shape")
eq(base.strides,{8},"empty-source/(1,)/datetime64[D]/(2,): backing source: strides")
eq(base.dtype,"datetime64[D]","empty-source/(1,)/datetime64[D]/(2,): backing source: dtype")
eq(a.shape,{1},"empty-source/(1,)/datetime64[D]/(2,): source shape")
eq(a.strides,{8},"empty-source/(1,)/datetime64[D]/(2,): source strides")
cases=cases+1
end
-- 500: empty-source/(1,)/datetime64[D]/(1, 2); source error=IndexError
do
local base=np.array({0},"datetime64[D]")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(1,)/datetime64[D]/(1, 2): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),{0},"empty-source/(1,)/datetime64[D]/(1, 2): backing source")
eq(base.shape,{1},"empty-source/(1,)/datetime64[D]/(1, 2): backing source: shape")
eq(base.strides,{8},"empty-source/(1,)/datetime64[D]/(1, 2): backing source: strides")
eq(base.dtype,"datetime64[D]","empty-source/(1,)/datetime64[D]/(1, 2): backing source: dtype")
eq(a.shape,{1},"empty-source/(1,)/datetime64[D]/(1, 2): source shape")
eq(a.strides,{8},"empty-source/(1,)/datetime64[D]/(1, 2): source strides")
cases=cases+1
end
-- 501: empty-source/(1,)/timedelta64[h]/(); source error=None
do
local base=np.array({0},"timedelta64[h]")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(1,)/timedelta64[h]/(): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0},"empty-source/(1,)/timedelta64[h]/(): result")
eq(result.shape,{1},"empty-source/(1,)/timedelta64[h]/(): result: shape")
eq(result.strides,{8},"empty-source/(1,)/timedelta64[h]/(): result: strides")
eq(result.dtype,"timedelta64[h]","empty-source/(1,)/timedelta64[h]/(): result: dtype")
eq(np.astype(base,'int64'):tolist(),{0},"empty-source/(1,)/timedelta64[h]/(): backing source")
eq(base.shape,{1},"empty-source/(1,)/timedelta64[h]/(): backing source: shape")
eq(base.strides,{8},"empty-source/(1,)/timedelta64[h]/(): backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-source/(1,)/timedelta64[h]/(): backing source: dtype")
eq(a.shape,{1},"empty-source/(1,)/timedelta64[h]/(): source shape")
eq(a.strides,{8},"empty-source/(1,)/timedelta64[h]/(): source strides")
cases=cases+1
end
-- 502: empty-source/(1,)/timedelta64[h]/(0,); source error=None
do
local base=np.array({0},"timedelta64[h]")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(1,)/timedelta64[h]/(0,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{},"empty-source/(1,)/timedelta64[h]/(0,): result")
eq(result.shape,{0},"empty-source/(1,)/timedelta64[h]/(0,): result: shape")
eq(result.strides,{0},"empty-source/(1,)/timedelta64[h]/(0,): result: strides")
eq(result.dtype,"timedelta64[h]","empty-source/(1,)/timedelta64[h]/(0,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{0},"empty-source/(1,)/timedelta64[h]/(0,): backing source")
eq(base.shape,{1},"empty-source/(1,)/timedelta64[h]/(0,): backing source: shape")
eq(base.strides,{8},"empty-source/(1,)/timedelta64[h]/(0,): backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-source/(1,)/timedelta64[h]/(0,): backing source: dtype")
eq(a.shape,{1},"empty-source/(1,)/timedelta64[h]/(0,): source shape")
eq(a.strides,{8},"empty-source/(1,)/timedelta64[h]/(0,): source strides")
cases=cases+1
end
-- 503: empty-source/(1,)/timedelta64[h]/(1,); source error=None
do
local base=np.array({0},"timedelta64[h]")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(1,)/timedelta64[h]/(1,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0},"empty-source/(1,)/timedelta64[h]/(1,): result")
eq(result.shape,{1},"empty-source/(1,)/timedelta64[h]/(1,): result: shape")
eq(result.strides,{8},"empty-source/(1,)/timedelta64[h]/(1,): result: strides")
eq(result.dtype,"timedelta64[h]","empty-source/(1,)/timedelta64[h]/(1,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{0},"empty-source/(1,)/timedelta64[h]/(1,): backing source")
eq(base.shape,{1},"empty-source/(1,)/timedelta64[h]/(1,): backing source: shape")
eq(base.strides,{8},"empty-source/(1,)/timedelta64[h]/(1,): backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-source/(1,)/timedelta64[h]/(1,): backing source: dtype")
eq(a.shape,{1},"empty-source/(1,)/timedelta64[h]/(1,): source shape")
eq(a.strides,{8},"empty-source/(1,)/timedelta64[h]/(1,): source strides")
cases=cases+1
end
-- 504: empty-source/(1,)/timedelta64[h]/(2,); source error=IndexError
do
local base=np.array({0},"timedelta64[h]")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(1,)/timedelta64[h]/(2,): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),{0},"empty-source/(1,)/timedelta64[h]/(2,): backing source")
eq(base.shape,{1},"empty-source/(1,)/timedelta64[h]/(2,): backing source: shape")
eq(base.strides,{8},"empty-source/(1,)/timedelta64[h]/(2,): backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-source/(1,)/timedelta64[h]/(2,): backing source: dtype")
eq(a.shape,{1},"empty-source/(1,)/timedelta64[h]/(2,): source shape")
eq(a.strides,{8},"empty-source/(1,)/timedelta64[h]/(2,): source strides")
cases=cases+1
end
-- 505: empty-source/(1,)/timedelta64[h]/(1, 2); source error=IndexError
do
local base=np.array({0},"timedelta64[h]")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(1,)/timedelta64[h]/(1, 2): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),{0},"empty-source/(1,)/timedelta64[h]/(1, 2): backing source")
eq(base.shape,{1},"empty-source/(1,)/timedelta64[h]/(1, 2): backing source: shape")
eq(base.strides,{8},"empty-source/(1,)/timedelta64[h]/(1, 2): backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-source/(1,)/timedelta64[h]/(1, 2): backing source: dtype")
eq(a.shape,{1},"empty-source/(1,)/timedelta64[h]/(1, 2): source shape")
eq(a.strides,{8},"empty-source/(1,)/timedelta64[h]/(1, 2): source strides")
cases=cases+1
end
-- 506: empty-source/(3,)/int32/(); source error=None
do
local base=np.array({0,0,0},"int32")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(3,)/int32/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{0},"empty-source/(3,)/int32/(): result")
eq(result.shape,{1},"empty-source/(3,)/int32/(): result: shape")
eq(result.strides,{4},"empty-source/(3,)/int32/(): result: strides")
eq(result.dtype,"int32","empty-source/(3,)/int32/(): result: dtype")
eq(base:tolist(),{0,0,0},"empty-source/(3,)/int32/(): backing source")
eq(base.shape,{3},"empty-source/(3,)/int32/(): backing source: shape")
eq(base.strides,{4},"empty-source/(3,)/int32/(): backing source: strides")
eq(base.dtype,"int32","empty-source/(3,)/int32/(): backing source: dtype")
eq(a.shape,{3},"empty-source/(3,)/int32/(): source shape")
eq(a.strides,{4},"empty-source/(3,)/int32/(): source strides")
cases=cases+1
end
-- 507: empty-source/(3,)/int32/(0,); source error=None
do
local base=np.array({0,0,0},"int32")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(3,)/int32/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-source/(3,)/int32/(0,): result")
eq(result.shape,{0},"empty-source/(3,)/int32/(0,): result: shape")
eq(result.strides,{0},"empty-source/(3,)/int32/(0,): result: strides")
eq(result.dtype,"int32","empty-source/(3,)/int32/(0,): result: dtype")
eq(base:tolist(),{0,0,0},"empty-source/(3,)/int32/(0,): backing source")
eq(base.shape,{3},"empty-source/(3,)/int32/(0,): backing source: shape")
eq(base.strides,{4},"empty-source/(3,)/int32/(0,): backing source: strides")
eq(base.dtype,"int32","empty-source/(3,)/int32/(0,): backing source: dtype")
eq(a.shape,{3},"empty-source/(3,)/int32/(0,): source shape")
eq(a.strides,{4},"empty-source/(3,)/int32/(0,): source strides")
cases=cases+1
end
-- 508: empty-source/(3,)/int32/(1,); source error=None
do
local base=np.array({0,0,0},"int32")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(3,)/int32/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0},"empty-source/(3,)/int32/(1,): result")
eq(result.shape,{1},"empty-source/(3,)/int32/(1,): result: shape")
eq(result.strides,{4},"empty-source/(3,)/int32/(1,): result: strides")
eq(result.dtype,"int32","empty-source/(3,)/int32/(1,): result: dtype")
eq(base:tolist(),{0,0,0},"empty-source/(3,)/int32/(1,): backing source")
eq(base.shape,{3},"empty-source/(3,)/int32/(1,): backing source: shape")
eq(base.strides,{4},"empty-source/(3,)/int32/(1,): backing source: strides")
eq(base.dtype,"int32","empty-source/(3,)/int32/(1,): backing source: dtype")
eq(a.shape,{3},"empty-source/(3,)/int32/(1,): source shape")
eq(a.strides,{4},"empty-source/(3,)/int32/(1,): source strides")
cases=cases+1
end
-- 509: empty-source/(3,)/int32/(2,); source error=None
do
local base=np.array({0,0,0},"int32")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(3,)/int32/(2,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0},"empty-source/(3,)/int32/(2,): result")
eq(result.shape,{1},"empty-source/(3,)/int32/(2,): result: shape")
eq(result.strides,{4},"empty-source/(3,)/int32/(2,): result: strides")
eq(result.dtype,"int32","empty-source/(3,)/int32/(2,): result: dtype")
eq(base:tolist(),{0,0,0},"empty-source/(3,)/int32/(2,): backing source")
eq(base.shape,{3},"empty-source/(3,)/int32/(2,): backing source: shape")
eq(base.strides,{4},"empty-source/(3,)/int32/(2,): backing source: strides")
eq(base.dtype,"int32","empty-source/(3,)/int32/(2,): backing source: dtype")
eq(a.shape,{3},"empty-source/(3,)/int32/(2,): source shape")
eq(a.strides,{4},"empty-source/(3,)/int32/(2,): source strides")
cases=cases+1
end
-- 510: empty-source/(3,)/int32/(1, 2); source error=None
do
local base=np.array({0,0,0},"int32")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(3,)/int32/(1, 2): acceptance"..": "..tostring(result))
eq(result:tolist(),{0,0},"empty-source/(3,)/int32/(1, 2): result")
eq(result.shape,{2},"empty-source/(3,)/int32/(1, 2): result: shape")
eq(result.strides,{4},"empty-source/(3,)/int32/(1, 2): result: strides")
eq(result.dtype,"int32","empty-source/(3,)/int32/(1, 2): result: dtype")
eq(base:tolist(),{0,0,0},"empty-source/(3,)/int32/(1, 2): backing source")
eq(base.shape,{3},"empty-source/(3,)/int32/(1, 2): backing source: shape")
eq(base.strides,{4},"empty-source/(3,)/int32/(1, 2): backing source: strides")
eq(base.dtype,"int32","empty-source/(3,)/int32/(1, 2): backing source: dtype")
eq(a.shape,{3},"empty-source/(3,)/int32/(1, 2): source shape")
eq(a.strides,{4},"empty-source/(3,)/int32/(1, 2): source strides")
cases=cases+1
end
-- 511: empty-source/(3,)/float32/(); source error=None
do
local base=np.array({0.0,0.0,0.0},"float32")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(3,)/float32/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"empty-source/(3,)/float32/(): result")
eq(result.shape,{1},"empty-source/(3,)/float32/(): result: shape")
eq(result.strides,{4},"empty-source/(3,)/float32/(): result: strides")
eq(result.dtype,"float32","empty-source/(3,)/float32/(): result: dtype")
eq(base:tolist(),{0.0,0.0,0.0},"empty-source/(3,)/float32/(): backing source")
eq(base.shape,{3},"empty-source/(3,)/float32/(): backing source: shape")
eq(base.strides,{4},"empty-source/(3,)/float32/(): backing source: strides")
eq(base.dtype,"float32","empty-source/(3,)/float32/(): backing source: dtype")
eq(a.shape,{3},"empty-source/(3,)/float32/(): source shape")
eq(a.strides,{4},"empty-source/(3,)/float32/(): source strides")
cases=cases+1
end
-- 512: empty-source/(3,)/float32/(0,); source error=None
do
local base=np.array({0.0,0.0,0.0},"float32")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(3,)/float32/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-source/(3,)/float32/(0,): result")
eq(result.shape,{0},"empty-source/(3,)/float32/(0,): result: shape")
eq(result.strides,{0},"empty-source/(3,)/float32/(0,): result: strides")
eq(result.dtype,"float32","empty-source/(3,)/float32/(0,): result: dtype")
eq(base:tolist(),{0.0,0.0,0.0},"empty-source/(3,)/float32/(0,): backing source")
eq(base.shape,{3},"empty-source/(3,)/float32/(0,): backing source: shape")
eq(base.strides,{4},"empty-source/(3,)/float32/(0,): backing source: strides")
eq(base.dtype,"float32","empty-source/(3,)/float32/(0,): backing source: dtype")
eq(a.shape,{3},"empty-source/(3,)/float32/(0,): source shape")
eq(a.strides,{4},"empty-source/(3,)/float32/(0,): source strides")
cases=cases+1
end
-- 513: empty-source/(3,)/float32/(1,); source error=None
do
local base=np.array({0.0,0.0,0.0},"float32")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(3,)/float32/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"empty-source/(3,)/float32/(1,): result")
eq(result.shape,{1},"empty-source/(3,)/float32/(1,): result: shape")
eq(result.strides,{4},"empty-source/(3,)/float32/(1,): result: strides")
eq(result.dtype,"float32","empty-source/(3,)/float32/(1,): result: dtype")
eq(base:tolist(),{0.0,0.0,0.0},"empty-source/(3,)/float32/(1,): backing source")
eq(base.shape,{3},"empty-source/(3,)/float32/(1,): backing source: shape")
eq(base.strides,{4},"empty-source/(3,)/float32/(1,): backing source: strides")
eq(base.dtype,"float32","empty-source/(3,)/float32/(1,): backing source: dtype")
eq(a.shape,{3},"empty-source/(3,)/float32/(1,): source shape")
eq(a.strides,{4},"empty-source/(3,)/float32/(1,): source strides")
cases=cases+1
end
-- 514: empty-source/(3,)/float32/(2,); source error=None
do
local base=np.array({0.0,0.0,0.0},"float32")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(3,)/float32/(2,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"empty-source/(3,)/float32/(2,): result")
eq(result.shape,{1},"empty-source/(3,)/float32/(2,): result: shape")
eq(result.strides,{4},"empty-source/(3,)/float32/(2,): result: strides")
eq(result.dtype,"float32","empty-source/(3,)/float32/(2,): result: dtype")
eq(base:tolist(),{0.0,0.0,0.0},"empty-source/(3,)/float32/(2,): backing source")
eq(base.shape,{3},"empty-source/(3,)/float32/(2,): backing source: shape")
eq(base.strides,{4},"empty-source/(3,)/float32/(2,): backing source: strides")
eq(base.dtype,"float32","empty-source/(3,)/float32/(2,): backing source: dtype")
eq(a.shape,{3},"empty-source/(3,)/float32/(2,): source shape")
eq(a.strides,{4},"empty-source/(3,)/float32/(2,): source strides")
cases=cases+1
end
-- 515: empty-source/(3,)/float32/(1, 2); source error=None
do
local base=np.array({0.0,0.0,0.0},"float32")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(3,)/float32/(1, 2): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.0},"empty-source/(3,)/float32/(1, 2): result")
eq(result.shape,{2},"empty-source/(3,)/float32/(1, 2): result: shape")
eq(result.strides,{4},"empty-source/(3,)/float32/(1, 2): result: strides")
eq(result.dtype,"float32","empty-source/(3,)/float32/(1, 2): result: dtype")
eq(base:tolist(),{0.0,0.0,0.0},"empty-source/(3,)/float32/(1, 2): backing source")
eq(base.shape,{3},"empty-source/(3,)/float32/(1, 2): backing source: shape")
eq(base.strides,{4},"empty-source/(3,)/float32/(1, 2): backing source: strides")
eq(base.dtype,"float32","empty-source/(3,)/float32/(1, 2): backing source: dtype")
eq(a.shape,{3},"empty-source/(3,)/float32/(1, 2): source shape")
eq(a.strides,{4},"empty-source/(3,)/float32/(1, 2): source strides")
cases=cases+1
end
-- 516: empty-source/(3,)/complex128/(); source error=None
do
local base=np.array({np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)},"complex128")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(3,)/complex128/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0)},"empty-source/(3,)/complex128/(): result")
eq(result.shape,{1},"empty-source/(3,)/complex128/(): result: shape")
eq(result.strides,{16},"empty-source/(3,)/complex128/(): result: strides")
eq(result.dtype,"complex128","empty-source/(3,)/complex128/(): result: dtype")
eq(base:tolist(),{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)},"empty-source/(3,)/complex128/(): backing source")
eq(base.shape,{3},"empty-source/(3,)/complex128/(): backing source: shape")
eq(base.strides,{16},"empty-source/(3,)/complex128/(): backing source: strides")
eq(base.dtype,"complex128","empty-source/(3,)/complex128/(): backing source: dtype")
eq(a.shape,{3},"empty-source/(3,)/complex128/(): source shape")
eq(a.strides,{16},"empty-source/(3,)/complex128/(): source strides")
cases=cases+1
end
-- 517: empty-source/(3,)/complex128/(0,); source error=None
do
local base=np.array({np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)},"complex128")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(3,)/complex128/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-source/(3,)/complex128/(0,): result")
eq(result.shape,{0},"empty-source/(3,)/complex128/(0,): result: shape")
eq(result.strides,{0},"empty-source/(3,)/complex128/(0,): result: strides")
eq(result.dtype,"complex128","empty-source/(3,)/complex128/(0,): result: dtype")
eq(base:tolist(),{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)},"empty-source/(3,)/complex128/(0,): backing source")
eq(base.shape,{3},"empty-source/(3,)/complex128/(0,): backing source: shape")
eq(base.strides,{16},"empty-source/(3,)/complex128/(0,): backing source: strides")
eq(base.dtype,"complex128","empty-source/(3,)/complex128/(0,): backing source: dtype")
eq(a.shape,{3},"empty-source/(3,)/complex128/(0,): source shape")
eq(a.strides,{16},"empty-source/(3,)/complex128/(0,): source strides")
cases=cases+1
end
-- 518: empty-source/(3,)/complex128/(1,); source error=None
do
local base=np.array({np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)},"complex128")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(3,)/complex128/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0)},"empty-source/(3,)/complex128/(1,): result")
eq(result.shape,{1},"empty-source/(3,)/complex128/(1,): result: shape")
eq(result.strides,{16},"empty-source/(3,)/complex128/(1,): result: strides")
eq(result.dtype,"complex128","empty-source/(3,)/complex128/(1,): result: dtype")
eq(base:tolist(),{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)},"empty-source/(3,)/complex128/(1,): backing source")
eq(base.shape,{3},"empty-source/(3,)/complex128/(1,): backing source: shape")
eq(base.strides,{16},"empty-source/(3,)/complex128/(1,): backing source: strides")
eq(base.dtype,"complex128","empty-source/(3,)/complex128/(1,): backing source: dtype")
eq(a.shape,{3},"empty-source/(3,)/complex128/(1,): source shape")
eq(a.strides,{16},"empty-source/(3,)/complex128/(1,): source strides")
cases=cases+1
end
-- 519: empty-source/(3,)/complex128/(2,); source error=None
do
local base=np.array({np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)},"complex128")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(3,)/complex128/(2,): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0)},"empty-source/(3,)/complex128/(2,): result")
eq(result.shape,{1},"empty-source/(3,)/complex128/(2,): result: shape")
eq(result.strides,{16},"empty-source/(3,)/complex128/(2,): result: strides")
eq(result.dtype,"complex128","empty-source/(3,)/complex128/(2,): result: dtype")
eq(base:tolist(),{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)},"empty-source/(3,)/complex128/(2,): backing source")
eq(base.shape,{3},"empty-source/(3,)/complex128/(2,): backing source: shape")
eq(base.strides,{16},"empty-source/(3,)/complex128/(2,): backing source: strides")
eq(base.dtype,"complex128","empty-source/(3,)/complex128/(2,): backing source: dtype")
eq(a.shape,{3},"empty-source/(3,)/complex128/(2,): source shape")
eq(a.strides,{16},"empty-source/(3,)/complex128/(2,): source strides")
cases=cases+1
end
-- 520: empty-source/(3,)/complex128/(1, 2); source error=None
do
local base=np.array({np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)},"complex128")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(3,)/complex128/(1, 2): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.0,0.0)},"empty-source/(3,)/complex128/(1, 2): result")
eq(result.shape,{2},"empty-source/(3,)/complex128/(1, 2): result: shape")
eq(result.strides,{16},"empty-source/(3,)/complex128/(1, 2): result: strides")
eq(result.dtype,"complex128","empty-source/(3,)/complex128/(1, 2): result: dtype")
eq(base:tolist(),{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)},"empty-source/(3,)/complex128/(1, 2): backing source")
eq(base.shape,{3},"empty-source/(3,)/complex128/(1, 2): backing source: shape")
eq(base.strides,{16},"empty-source/(3,)/complex128/(1, 2): backing source: strides")
eq(base.dtype,"complex128","empty-source/(3,)/complex128/(1, 2): backing source: dtype")
eq(a.shape,{3},"empty-source/(3,)/complex128/(1, 2): source shape")
eq(a.strides,{16},"empty-source/(3,)/complex128/(1, 2): source strides")
cases=cases+1
end
-- 521: empty-source/(3,)/U4/(); source error=None
do
local base=np.array({"","",""},"<U4")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(3,)/U4/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{""},"empty-source/(3,)/U4/(): result")
eq(result.shape,{1},"empty-source/(3,)/U4/(): result: shape")
eq(result.strides,{16},"empty-source/(3,)/U4/(): result: strides")
eq(result.dtype,"<U4","empty-source/(3,)/U4/(): result: dtype")
eq(base:tolist(),{"","",""},"empty-source/(3,)/U4/(): backing source")
eq(base.shape,{3},"empty-source/(3,)/U4/(): backing source: shape")
eq(base.strides,{16},"empty-source/(3,)/U4/(): backing source: strides")
eq(base.dtype,"<U4","empty-source/(3,)/U4/(): backing source: dtype")
eq(a.shape,{3},"empty-source/(3,)/U4/(): source shape")
eq(a.strides,{16},"empty-source/(3,)/U4/(): source strides")
cases=cases+1
end
-- 522: empty-source/(3,)/U4/(0,); source error=None
do
local base=np.array({"","",""},"<U4")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(3,)/U4/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-source/(3,)/U4/(0,): result")
eq(result.shape,{0},"empty-source/(3,)/U4/(0,): result: shape")
eq(result.strides,{0},"empty-source/(3,)/U4/(0,): result: strides")
eq(result.dtype,"<U4","empty-source/(3,)/U4/(0,): result: dtype")
eq(base:tolist(),{"","",""},"empty-source/(3,)/U4/(0,): backing source")
eq(base.shape,{3},"empty-source/(3,)/U4/(0,): backing source: shape")
eq(base.strides,{16},"empty-source/(3,)/U4/(0,): backing source: strides")
eq(base.dtype,"<U4","empty-source/(3,)/U4/(0,): backing source: dtype")
eq(a.shape,{3},"empty-source/(3,)/U4/(0,): source shape")
eq(a.strides,{16},"empty-source/(3,)/U4/(0,): source strides")
cases=cases+1
end
-- 523: empty-source/(3,)/U4/(1,); source error=None
do
local base=np.array({"","",""},"<U4")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(3,)/U4/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{""},"empty-source/(3,)/U4/(1,): result")
eq(result.shape,{1},"empty-source/(3,)/U4/(1,): result: shape")
eq(result.strides,{16},"empty-source/(3,)/U4/(1,): result: strides")
eq(result.dtype,"<U4","empty-source/(3,)/U4/(1,): result: dtype")
eq(base:tolist(),{"","",""},"empty-source/(3,)/U4/(1,): backing source")
eq(base.shape,{3},"empty-source/(3,)/U4/(1,): backing source: shape")
eq(base.strides,{16},"empty-source/(3,)/U4/(1,): backing source: strides")
eq(base.dtype,"<U4","empty-source/(3,)/U4/(1,): backing source: dtype")
eq(a.shape,{3},"empty-source/(3,)/U4/(1,): source shape")
eq(a.strides,{16},"empty-source/(3,)/U4/(1,): source strides")
cases=cases+1
end
-- 524: empty-source/(3,)/U4/(2,); source error=None
do
local base=np.array({"","",""},"<U4")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(3,)/U4/(2,): acceptance"..": "..tostring(result))
eq(result:tolist(),{""},"empty-source/(3,)/U4/(2,): result")
eq(result.shape,{1},"empty-source/(3,)/U4/(2,): result: shape")
eq(result.strides,{16},"empty-source/(3,)/U4/(2,): result: strides")
eq(result.dtype,"<U4","empty-source/(3,)/U4/(2,): result: dtype")
eq(base:tolist(),{"","",""},"empty-source/(3,)/U4/(2,): backing source")
eq(base.shape,{3},"empty-source/(3,)/U4/(2,): backing source: shape")
eq(base.strides,{16},"empty-source/(3,)/U4/(2,): backing source: strides")
eq(base.dtype,"<U4","empty-source/(3,)/U4/(2,): backing source: dtype")
eq(a.shape,{3},"empty-source/(3,)/U4/(2,): source shape")
eq(a.strides,{16},"empty-source/(3,)/U4/(2,): source strides")
cases=cases+1
end
-- 525: empty-source/(3,)/U4/(1, 2); source error=None
do
local base=np.array({"","",""},"<U4")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(3,)/U4/(1, 2): acceptance"..": "..tostring(result))
eq(result:tolist(),{"",""},"empty-source/(3,)/U4/(1, 2): result")
eq(result.shape,{2},"empty-source/(3,)/U4/(1, 2): result: shape")
eq(result.strides,{16},"empty-source/(3,)/U4/(1, 2): result: strides")
eq(result.dtype,"<U4","empty-source/(3,)/U4/(1, 2): result: dtype")
eq(base:tolist(),{"","",""},"empty-source/(3,)/U4/(1, 2): backing source")
eq(base.shape,{3},"empty-source/(3,)/U4/(1, 2): backing source: shape")
eq(base.strides,{16},"empty-source/(3,)/U4/(1, 2): backing source: strides")
eq(base.dtype,"<U4","empty-source/(3,)/U4/(1, 2): backing source: dtype")
eq(a.shape,{3},"empty-source/(3,)/U4/(1, 2): source shape")
eq(a.strides,{16},"empty-source/(3,)/U4/(1, 2): source strides")
cases=cases+1
end
-- 526: empty-source/(3,)/S4/(); source error=None
do
local base=np.array({"","",""},"|S4")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(3,)/S4/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{""},"empty-source/(3,)/S4/(): result")
eq(result.shape,{1},"empty-source/(3,)/S4/(): result: shape")
eq(result.strides,{4},"empty-source/(3,)/S4/(): result: strides")
eq(result.dtype,"|S4","empty-source/(3,)/S4/(): result: dtype")
eq(base:tolist(),{"","",""},"empty-source/(3,)/S4/(): backing source")
eq(base.shape,{3},"empty-source/(3,)/S4/(): backing source: shape")
eq(base.strides,{4},"empty-source/(3,)/S4/(): backing source: strides")
eq(base.dtype,"|S4","empty-source/(3,)/S4/(): backing source: dtype")
eq(a.shape,{3},"empty-source/(3,)/S4/(): source shape")
eq(a.strides,{4},"empty-source/(3,)/S4/(): source strides")
cases=cases+1
end
-- 527: empty-source/(3,)/S4/(0,); source error=None
do
local base=np.array({"","",""},"|S4")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(3,)/S4/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-source/(3,)/S4/(0,): result")
eq(result.shape,{0},"empty-source/(3,)/S4/(0,): result: shape")
eq(result.strides,{0},"empty-source/(3,)/S4/(0,): result: strides")
eq(result.dtype,"|S4","empty-source/(3,)/S4/(0,): result: dtype")
eq(base:tolist(),{"","",""},"empty-source/(3,)/S4/(0,): backing source")
eq(base.shape,{3},"empty-source/(3,)/S4/(0,): backing source: shape")
eq(base.strides,{4},"empty-source/(3,)/S4/(0,): backing source: strides")
eq(base.dtype,"|S4","empty-source/(3,)/S4/(0,): backing source: dtype")
eq(a.shape,{3},"empty-source/(3,)/S4/(0,): source shape")
eq(a.strides,{4},"empty-source/(3,)/S4/(0,): source strides")
cases=cases+1
end
-- 528: empty-source/(3,)/S4/(1,); source error=None
do
local base=np.array({"","",""},"|S4")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(3,)/S4/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{""},"empty-source/(3,)/S4/(1,): result")
eq(result.shape,{1},"empty-source/(3,)/S4/(1,): result: shape")
eq(result.strides,{4},"empty-source/(3,)/S4/(1,): result: strides")
eq(result.dtype,"|S4","empty-source/(3,)/S4/(1,): result: dtype")
eq(base:tolist(),{"","",""},"empty-source/(3,)/S4/(1,): backing source")
eq(base.shape,{3},"empty-source/(3,)/S4/(1,): backing source: shape")
eq(base.strides,{4},"empty-source/(3,)/S4/(1,): backing source: strides")
eq(base.dtype,"|S4","empty-source/(3,)/S4/(1,): backing source: dtype")
eq(a.shape,{3},"empty-source/(3,)/S4/(1,): source shape")
eq(a.strides,{4},"empty-source/(3,)/S4/(1,): source strides")
cases=cases+1
end
-- 529: empty-source/(3,)/S4/(2,); source error=None
do
local base=np.array({"","",""},"|S4")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(3,)/S4/(2,): acceptance"..": "..tostring(result))
eq(result:tolist(),{""},"empty-source/(3,)/S4/(2,): result")
eq(result.shape,{1},"empty-source/(3,)/S4/(2,): result: shape")
eq(result.strides,{4},"empty-source/(3,)/S4/(2,): result: strides")
eq(result.dtype,"|S4","empty-source/(3,)/S4/(2,): result: dtype")
eq(base:tolist(),{"","",""},"empty-source/(3,)/S4/(2,): backing source")
eq(base.shape,{3},"empty-source/(3,)/S4/(2,): backing source: shape")
eq(base.strides,{4},"empty-source/(3,)/S4/(2,): backing source: strides")
eq(base.dtype,"|S4","empty-source/(3,)/S4/(2,): backing source: dtype")
eq(a.shape,{3},"empty-source/(3,)/S4/(2,): source shape")
eq(a.strides,{4},"empty-source/(3,)/S4/(2,): source strides")
cases=cases+1
end
-- 530: empty-source/(3,)/S4/(1, 2); source error=None
do
local base=np.array({"","",""},"|S4")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(3,)/S4/(1, 2): acceptance"..": "..tostring(result))
eq(result:tolist(),{"",""},"empty-source/(3,)/S4/(1, 2): result")
eq(result.shape,{2},"empty-source/(3,)/S4/(1, 2): result: shape")
eq(result.strides,{4},"empty-source/(3,)/S4/(1, 2): result: strides")
eq(result.dtype,"|S4","empty-source/(3,)/S4/(1, 2): result: dtype")
eq(base:tolist(),{"","",""},"empty-source/(3,)/S4/(1, 2): backing source")
eq(base.shape,{3},"empty-source/(3,)/S4/(1, 2): backing source: shape")
eq(base.strides,{4},"empty-source/(3,)/S4/(1, 2): backing source: strides")
eq(base.dtype,"|S4","empty-source/(3,)/S4/(1, 2): backing source: dtype")
eq(a.shape,{3},"empty-source/(3,)/S4/(1, 2): source shape")
eq(a.strides,{4},"empty-source/(3,)/S4/(1, 2): source strides")
cases=cases+1
end
-- 531: empty-source/(3,)/datetime64[D]/(); source error=None
do
local base=np.array({0,0,0},"datetime64[D]")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(3,)/datetime64[D]/(): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0},"empty-source/(3,)/datetime64[D]/(): result")
eq(result.shape,{1},"empty-source/(3,)/datetime64[D]/(): result: shape")
eq(result.strides,{8},"empty-source/(3,)/datetime64[D]/(): result: strides")
eq(result.dtype,"datetime64[D]","empty-source/(3,)/datetime64[D]/(): result: dtype")
eq(np.astype(base,'int64'):tolist(),{0,0,0},"empty-source/(3,)/datetime64[D]/(): backing source")
eq(base.shape,{3},"empty-source/(3,)/datetime64[D]/(): backing source: shape")
eq(base.strides,{8},"empty-source/(3,)/datetime64[D]/(): backing source: strides")
eq(base.dtype,"datetime64[D]","empty-source/(3,)/datetime64[D]/(): backing source: dtype")
eq(a.shape,{3},"empty-source/(3,)/datetime64[D]/(): source shape")
eq(a.strides,{8},"empty-source/(3,)/datetime64[D]/(): source strides")
cases=cases+1
end
-- 532: empty-source/(3,)/datetime64[D]/(0,); source error=None
do
local base=np.array({0,0,0},"datetime64[D]")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(3,)/datetime64[D]/(0,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{},"empty-source/(3,)/datetime64[D]/(0,): result")
eq(result.shape,{0},"empty-source/(3,)/datetime64[D]/(0,): result: shape")
eq(result.strides,{0},"empty-source/(3,)/datetime64[D]/(0,): result: strides")
eq(result.dtype,"datetime64[D]","empty-source/(3,)/datetime64[D]/(0,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{0,0,0},"empty-source/(3,)/datetime64[D]/(0,): backing source")
eq(base.shape,{3},"empty-source/(3,)/datetime64[D]/(0,): backing source: shape")
eq(base.strides,{8},"empty-source/(3,)/datetime64[D]/(0,): backing source: strides")
eq(base.dtype,"datetime64[D]","empty-source/(3,)/datetime64[D]/(0,): backing source: dtype")
eq(a.shape,{3},"empty-source/(3,)/datetime64[D]/(0,): source shape")
eq(a.strides,{8},"empty-source/(3,)/datetime64[D]/(0,): source strides")
cases=cases+1
end
-- 533: empty-source/(3,)/datetime64[D]/(1,); source error=None
do
local base=np.array({0,0,0},"datetime64[D]")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(3,)/datetime64[D]/(1,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0},"empty-source/(3,)/datetime64[D]/(1,): result")
eq(result.shape,{1},"empty-source/(3,)/datetime64[D]/(1,): result: shape")
eq(result.strides,{8},"empty-source/(3,)/datetime64[D]/(1,): result: strides")
eq(result.dtype,"datetime64[D]","empty-source/(3,)/datetime64[D]/(1,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{0,0,0},"empty-source/(3,)/datetime64[D]/(1,): backing source")
eq(base.shape,{3},"empty-source/(3,)/datetime64[D]/(1,): backing source: shape")
eq(base.strides,{8},"empty-source/(3,)/datetime64[D]/(1,): backing source: strides")
eq(base.dtype,"datetime64[D]","empty-source/(3,)/datetime64[D]/(1,): backing source: dtype")
eq(a.shape,{3},"empty-source/(3,)/datetime64[D]/(1,): source shape")
eq(a.strides,{8},"empty-source/(3,)/datetime64[D]/(1,): source strides")
cases=cases+1
end
-- 534: empty-source/(3,)/datetime64[D]/(2,); source error=None
do
local base=np.array({0,0,0},"datetime64[D]")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(3,)/datetime64[D]/(2,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0},"empty-source/(3,)/datetime64[D]/(2,): result")
eq(result.shape,{1},"empty-source/(3,)/datetime64[D]/(2,): result: shape")
eq(result.strides,{8},"empty-source/(3,)/datetime64[D]/(2,): result: strides")
eq(result.dtype,"datetime64[D]","empty-source/(3,)/datetime64[D]/(2,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{0,0,0},"empty-source/(3,)/datetime64[D]/(2,): backing source")
eq(base.shape,{3},"empty-source/(3,)/datetime64[D]/(2,): backing source: shape")
eq(base.strides,{8},"empty-source/(3,)/datetime64[D]/(2,): backing source: strides")
eq(base.dtype,"datetime64[D]","empty-source/(3,)/datetime64[D]/(2,): backing source: dtype")
eq(a.shape,{3},"empty-source/(3,)/datetime64[D]/(2,): source shape")
eq(a.strides,{8},"empty-source/(3,)/datetime64[D]/(2,): source strides")
cases=cases+1
end
-- 535: empty-source/(3,)/datetime64[D]/(1, 2); source error=None
do
local base=np.array({0,0,0},"datetime64[D]")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(3,)/datetime64[D]/(1, 2): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0,0},"empty-source/(3,)/datetime64[D]/(1, 2): result")
eq(result.shape,{2},"empty-source/(3,)/datetime64[D]/(1, 2): result: shape")
eq(result.strides,{8},"empty-source/(3,)/datetime64[D]/(1, 2): result: strides")
eq(result.dtype,"datetime64[D]","empty-source/(3,)/datetime64[D]/(1, 2): result: dtype")
eq(np.astype(base,'int64'):tolist(),{0,0,0},"empty-source/(3,)/datetime64[D]/(1, 2): backing source")
eq(base.shape,{3},"empty-source/(3,)/datetime64[D]/(1, 2): backing source: shape")
eq(base.strides,{8},"empty-source/(3,)/datetime64[D]/(1, 2): backing source: strides")
eq(base.dtype,"datetime64[D]","empty-source/(3,)/datetime64[D]/(1, 2): backing source: dtype")
eq(a.shape,{3},"empty-source/(3,)/datetime64[D]/(1, 2): source shape")
eq(a.strides,{8},"empty-source/(3,)/datetime64[D]/(1, 2): source strides")
cases=cases+1
end
-- 536: empty-source/(3,)/timedelta64[h]/(); source error=None
do
local base=np.array({0,0,0},"timedelta64[h]")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(3,)/timedelta64[h]/(): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0},"empty-source/(3,)/timedelta64[h]/(): result")
eq(result.shape,{1},"empty-source/(3,)/timedelta64[h]/(): result: shape")
eq(result.strides,{8},"empty-source/(3,)/timedelta64[h]/(): result: strides")
eq(result.dtype,"timedelta64[h]","empty-source/(3,)/timedelta64[h]/(): result: dtype")
eq(np.astype(base,'int64'):tolist(),{0,0,0},"empty-source/(3,)/timedelta64[h]/(): backing source")
eq(base.shape,{3},"empty-source/(3,)/timedelta64[h]/(): backing source: shape")
eq(base.strides,{8},"empty-source/(3,)/timedelta64[h]/(): backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-source/(3,)/timedelta64[h]/(): backing source: dtype")
eq(a.shape,{3},"empty-source/(3,)/timedelta64[h]/(): source shape")
eq(a.strides,{8},"empty-source/(3,)/timedelta64[h]/(): source strides")
cases=cases+1
end
-- 537: empty-source/(3,)/timedelta64[h]/(0,); source error=None
do
local base=np.array({0,0,0},"timedelta64[h]")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(3,)/timedelta64[h]/(0,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{},"empty-source/(3,)/timedelta64[h]/(0,): result")
eq(result.shape,{0},"empty-source/(3,)/timedelta64[h]/(0,): result: shape")
eq(result.strides,{0},"empty-source/(3,)/timedelta64[h]/(0,): result: strides")
eq(result.dtype,"timedelta64[h]","empty-source/(3,)/timedelta64[h]/(0,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{0,0,0},"empty-source/(3,)/timedelta64[h]/(0,): backing source")
eq(base.shape,{3},"empty-source/(3,)/timedelta64[h]/(0,): backing source: shape")
eq(base.strides,{8},"empty-source/(3,)/timedelta64[h]/(0,): backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-source/(3,)/timedelta64[h]/(0,): backing source: dtype")
eq(a.shape,{3},"empty-source/(3,)/timedelta64[h]/(0,): source shape")
eq(a.strides,{8},"empty-source/(3,)/timedelta64[h]/(0,): source strides")
cases=cases+1
end
-- 538: empty-source/(3,)/timedelta64[h]/(1,); source error=None
do
local base=np.array({0,0,0},"timedelta64[h]")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(3,)/timedelta64[h]/(1,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0},"empty-source/(3,)/timedelta64[h]/(1,): result")
eq(result.shape,{1},"empty-source/(3,)/timedelta64[h]/(1,): result: shape")
eq(result.strides,{8},"empty-source/(3,)/timedelta64[h]/(1,): result: strides")
eq(result.dtype,"timedelta64[h]","empty-source/(3,)/timedelta64[h]/(1,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{0,0,0},"empty-source/(3,)/timedelta64[h]/(1,): backing source")
eq(base.shape,{3},"empty-source/(3,)/timedelta64[h]/(1,): backing source: shape")
eq(base.strides,{8},"empty-source/(3,)/timedelta64[h]/(1,): backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-source/(3,)/timedelta64[h]/(1,): backing source: dtype")
eq(a.shape,{3},"empty-source/(3,)/timedelta64[h]/(1,): source shape")
eq(a.strides,{8},"empty-source/(3,)/timedelta64[h]/(1,): source strides")
cases=cases+1
end
-- 539: empty-source/(3,)/timedelta64[h]/(2,); source error=None
do
local base=np.array({0,0,0},"timedelta64[h]")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(3,)/timedelta64[h]/(2,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0},"empty-source/(3,)/timedelta64[h]/(2,): result")
eq(result.shape,{1},"empty-source/(3,)/timedelta64[h]/(2,): result: shape")
eq(result.strides,{8},"empty-source/(3,)/timedelta64[h]/(2,): result: strides")
eq(result.dtype,"timedelta64[h]","empty-source/(3,)/timedelta64[h]/(2,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{0,0,0},"empty-source/(3,)/timedelta64[h]/(2,): backing source")
eq(base.shape,{3},"empty-source/(3,)/timedelta64[h]/(2,): backing source: shape")
eq(base.strides,{8},"empty-source/(3,)/timedelta64[h]/(2,): backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-source/(3,)/timedelta64[h]/(2,): backing source: dtype")
eq(a.shape,{3},"empty-source/(3,)/timedelta64[h]/(2,): source shape")
eq(a.strides,{8},"empty-source/(3,)/timedelta64[h]/(2,): source strides")
cases=cases+1
end
-- 540: empty-source/(3,)/timedelta64[h]/(1, 2); source error=None
do
local base=np.array({0,0,0},"timedelta64[h]")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(3,)/timedelta64[h]/(1, 2): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0,0},"empty-source/(3,)/timedelta64[h]/(1, 2): result")
eq(result.shape,{2},"empty-source/(3,)/timedelta64[h]/(1, 2): result: shape")
eq(result.strides,{8},"empty-source/(3,)/timedelta64[h]/(1, 2): result: strides")
eq(result.dtype,"timedelta64[h]","empty-source/(3,)/timedelta64[h]/(1, 2): result: dtype")
eq(np.astype(base,'int64'):tolist(),{0,0,0},"empty-source/(3,)/timedelta64[h]/(1, 2): backing source")
eq(base.shape,{3},"empty-source/(3,)/timedelta64[h]/(1, 2): backing source: shape")
eq(base.strides,{8},"empty-source/(3,)/timedelta64[h]/(1, 2): backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-source/(3,)/timedelta64[h]/(1, 2): backing source: dtype")
eq(a.shape,{3},"empty-source/(3,)/timedelta64[h]/(1, 2): source shape")
eq(a.strides,{8},"empty-source/(3,)/timedelta64[h]/(1, 2): source strides")
cases=cases+1
end
-- 541: empty-source/(0, 3)/int32/(); source error=IndexError
do
local base=np.zeros({0,3},"int32")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0, 3)/int32/(): acceptance"..": "..tostring(result))
eq(base:tolist(),{},"empty-source/(0, 3)/int32/(): backing source")
eq(base.shape,{0,3},"empty-source/(0, 3)/int32/(): backing source: shape")
eq(base.strides,{0,0},"empty-source/(0, 3)/int32/(): backing source: strides")
eq(base.dtype,"int32","empty-source/(0, 3)/int32/(): backing source: dtype")
eq(a.shape,{0,3},"empty-source/(0, 3)/int32/(): source shape")
eq(a.strides,{0,0},"empty-source/(0, 3)/int32/(): source strides")
cases=cases+1
end
-- 542: empty-source/(0, 3)/int32/(0,); source error=None
do
local base=np.zeros({0,3},"int32")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(0, 3)/int32/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-source/(0, 3)/int32/(0,): result")
eq(result.shape,{0},"empty-source/(0, 3)/int32/(0,): result: shape")
eq(result.strides,{0},"empty-source/(0, 3)/int32/(0,): result: strides")
eq(result.dtype,"int32","empty-source/(0, 3)/int32/(0,): result: dtype")
eq(base:tolist(),{},"empty-source/(0, 3)/int32/(0,): backing source")
eq(base.shape,{0,3},"empty-source/(0, 3)/int32/(0,): backing source: shape")
eq(base.strides,{0,0},"empty-source/(0, 3)/int32/(0,): backing source: strides")
eq(base.dtype,"int32","empty-source/(0, 3)/int32/(0,): backing source: dtype")
eq(a.shape,{0,3},"empty-source/(0, 3)/int32/(0,): source shape")
eq(a.strides,{0,0},"empty-source/(0, 3)/int32/(0,): source strides")
cases=cases+1
end
-- 543: empty-source/(0, 3)/int32/(1,); source error=IndexError
do
local base=np.zeros({0,3},"int32")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0, 3)/int32/(1,): acceptance"..": "..tostring(result))
eq(base:tolist(),{},"empty-source/(0, 3)/int32/(1,): backing source")
eq(base.shape,{0,3},"empty-source/(0, 3)/int32/(1,): backing source: shape")
eq(base.strides,{0,0},"empty-source/(0, 3)/int32/(1,): backing source: strides")
eq(base.dtype,"int32","empty-source/(0, 3)/int32/(1,): backing source: dtype")
eq(a.shape,{0,3},"empty-source/(0, 3)/int32/(1,): source shape")
eq(a.strides,{0,0},"empty-source/(0, 3)/int32/(1,): source strides")
cases=cases+1
end
-- 544: empty-source/(0, 3)/int32/(2,); source error=IndexError
do
local base=np.zeros({0,3},"int32")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0, 3)/int32/(2,): acceptance"..": "..tostring(result))
eq(base:tolist(),{},"empty-source/(0, 3)/int32/(2,): backing source")
eq(base.shape,{0,3},"empty-source/(0, 3)/int32/(2,): backing source: shape")
eq(base.strides,{0,0},"empty-source/(0, 3)/int32/(2,): backing source: strides")
eq(base.dtype,"int32","empty-source/(0, 3)/int32/(2,): backing source: dtype")
eq(a.shape,{0,3},"empty-source/(0, 3)/int32/(2,): source shape")
eq(a.strides,{0,0},"empty-source/(0, 3)/int32/(2,): source strides")
cases=cases+1
end
-- 545: empty-source/(0, 3)/int32/(1, 2); source error=IndexError
do
local base=np.zeros({0,3},"int32")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0, 3)/int32/(1, 2): acceptance"..": "..tostring(result))
eq(base:tolist(),{},"empty-source/(0, 3)/int32/(1, 2): backing source")
eq(base.shape,{0,3},"empty-source/(0, 3)/int32/(1, 2): backing source: shape")
eq(base.strides,{0,0},"empty-source/(0, 3)/int32/(1, 2): backing source: strides")
eq(base.dtype,"int32","empty-source/(0, 3)/int32/(1, 2): backing source: dtype")
eq(a.shape,{0,3},"empty-source/(0, 3)/int32/(1, 2): source shape")
eq(a.strides,{0,0},"empty-source/(0, 3)/int32/(1, 2): source strides")
cases=cases+1
end
-- 546: empty-source/(0, 3)/float32/(); source error=IndexError
do
local base=np.zeros({0,3},"float32")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0, 3)/float32/(): acceptance"..": "..tostring(result))
eq(base:tolist(),{},"empty-source/(0, 3)/float32/(): backing source")
eq(base.shape,{0,3},"empty-source/(0, 3)/float32/(): backing source: shape")
eq(base.strides,{0,0},"empty-source/(0, 3)/float32/(): backing source: strides")
eq(base.dtype,"float32","empty-source/(0, 3)/float32/(): backing source: dtype")
eq(a.shape,{0,3},"empty-source/(0, 3)/float32/(): source shape")
eq(a.strides,{0,0},"empty-source/(0, 3)/float32/(): source strides")
cases=cases+1
end
-- 547: empty-source/(0, 3)/float32/(0,); source error=None
do
local base=np.zeros({0,3},"float32")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(0, 3)/float32/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-source/(0, 3)/float32/(0,): result")
eq(result.shape,{0},"empty-source/(0, 3)/float32/(0,): result: shape")
eq(result.strides,{0},"empty-source/(0, 3)/float32/(0,): result: strides")
eq(result.dtype,"float32","empty-source/(0, 3)/float32/(0,): result: dtype")
eq(base:tolist(),{},"empty-source/(0, 3)/float32/(0,): backing source")
eq(base.shape,{0,3},"empty-source/(0, 3)/float32/(0,): backing source: shape")
eq(base.strides,{0,0},"empty-source/(0, 3)/float32/(0,): backing source: strides")
eq(base.dtype,"float32","empty-source/(0, 3)/float32/(0,): backing source: dtype")
eq(a.shape,{0,3},"empty-source/(0, 3)/float32/(0,): source shape")
eq(a.strides,{0,0},"empty-source/(0, 3)/float32/(0,): source strides")
cases=cases+1
end
-- 548: empty-source/(0, 3)/float32/(1,); source error=IndexError
do
local base=np.zeros({0,3},"float32")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0, 3)/float32/(1,): acceptance"..": "..tostring(result))
eq(base:tolist(),{},"empty-source/(0, 3)/float32/(1,): backing source")
eq(base.shape,{0,3},"empty-source/(0, 3)/float32/(1,): backing source: shape")
eq(base.strides,{0,0},"empty-source/(0, 3)/float32/(1,): backing source: strides")
eq(base.dtype,"float32","empty-source/(0, 3)/float32/(1,): backing source: dtype")
eq(a.shape,{0,3},"empty-source/(0, 3)/float32/(1,): source shape")
eq(a.strides,{0,0},"empty-source/(0, 3)/float32/(1,): source strides")
cases=cases+1
end
-- 549: empty-source/(0, 3)/float32/(2,); source error=IndexError
do
local base=np.zeros({0,3},"float32")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0, 3)/float32/(2,): acceptance"..": "..tostring(result))
eq(base:tolist(),{},"empty-source/(0, 3)/float32/(2,): backing source")
eq(base.shape,{0,3},"empty-source/(0, 3)/float32/(2,): backing source: shape")
eq(base.strides,{0,0},"empty-source/(0, 3)/float32/(2,): backing source: strides")
eq(base.dtype,"float32","empty-source/(0, 3)/float32/(2,): backing source: dtype")
eq(a.shape,{0,3},"empty-source/(0, 3)/float32/(2,): source shape")
eq(a.strides,{0,0},"empty-source/(0, 3)/float32/(2,): source strides")
cases=cases+1
end
-- 550: empty-source/(0, 3)/float32/(1, 2); source error=IndexError
do
local base=np.zeros({0,3},"float32")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0, 3)/float32/(1, 2): acceptance"..": "..tostring(result))
eq(base:tolist(),{},"empty-source/(0, 3)/float32/(1, 2): backing source")
eq(base.shape,{0,3},"empty-source/(0, 3)/float32/(1, 2): backing source: shape")
eq(base.strides,{0,0},"empty-source/(0, 3)/float32/(1, 2): backing source: strides")
eq(base.dtype,"float32","empty-source/(0, 3)/float32/(1, 2): backing source: dtype")
eq(a.shape,{0,3},"empty-source/(0, 3)/float32/(1, 2): source shape")
eq(a.strides,{0,0},"empty-source/(0, 3)/float32/(1, 2): source strides")
cases=cases+1
end
-- 551: empty-source/(0, 3)/complex128/(); source error=IndexError
do
local base=np.zeros({0,3},"complex128")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0, 3)/complex128/(): acceptance"..": "..tostring(result))
eq(base:tolist(),{},"empty-source/(0, 3)/complex128/(): backing source")
eq(base.shape,{0,3},"empty-source/(0, 3)/complex128/(): backing source: shape")
eq(base.strides,{0,0},"empty-source/(0, 3)/complex128/(): backing source: strides")
eq(base.dtype,"complex128","empty-source/(0, 3)/complex128/(): backing source: dtype")
eq(a.shape,{0,3},"empty-source/(0, 3)/complex128/(): source shape")
eq(a.strides,{0,0},"empty-source/(0, 3)/complex128/(): source strides")
cases=cases+1
end
-- 552: empty-source/(0, 3)/complex128/(0,); source error=None
do
local base=np.zeros({0,3},"complex128")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(0, 3)/complex128/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-source/(0, 3)/complex128/(0,): result")
eq(result.shape,{0},"empty-source/(0, 3)/complex128/(0,): result: shape")
eq(result.strides,{0},"empty-source/(0, 3)/complex128/(0,): result: strides")
eq(result.dtype,"complex128","empty-source/(0, 3)/complex128/(0,): result: dtype")
eq(base:tolist(),{},"empty-source/(0, 3)/complex128/(0,): backing source")
eq(base.shape,{0,3},"empty-source/(0, 3)/complex128/(0,): backing source: shape")
eq(base.strides,{0,0},"empty-source/(0, 3)/complex128/(0,): backing source: strides")
eq(base.dtype,"complex128","empty-source/(0, 3)/complex128/(0,): backing source: dtype")
eq(a.shape,{0,3},"empty-source/(0, 3)/complex128/(0,): source shape")
eq(a.strides,{0,0},"empty-source/(0, 3)/complex128/(0,): source strides")
cases=cases+1
end
-- 553: empty-source/(0, 3)/complex128/(1,); source error=IndexError
do
local base=np.zeros({0,3},"complex128")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0, 3)/complex128/(1,): acceptance"..": "..tostring(result))
eq(base:tolist(),{},"empty-source/(0, 3)/complex128/(1,): backing source")
eq(base.shape,{0,3},"empty-source/(0, 3)/complex128/(1,): backing source: shape")
eq(base.strides,{0,0},"empty-source/(0, 3)/complex128/(1,): backing source: strides")
eq(base.dtype,"complex128","empty-source/(0, 3)/complex128/(1,): backing source: dtype")
eq(a.shape,{0,3},"empty-source/(0, 3)/complex128/(1,): source shape")
eq(a.strides,{0,0},"empty-source/(0, 3)/complex128/(1,): source strides")
cases=cases+1
end
-- 554: empty-source/(0, 3)/complex128/(2,); source error=IndexError
do
local base=np.zeros({0,3},"complex128")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0, 3)/complex128/(2,): acceptance"..": "..tostring(result))
eq(base:tolist(),{},"empty-source/(0, 3)/complex128/(2,): backing source")
eq(base.shape,{0,3},"empty-source/(0, 3)/complex128/(2,): backing source: shape")
eq(base.strides,{0,0},"empty-source/(0, 3)/complex128/(2,): backing source: strides")
eq(base.dtype,"complex128","empty-source/(0, 3)/complex128/(2,): backing source: dtype")
eq(a.shape,{0,3},"empty-source/(0, 3)/complex128/(2,): source shape")
eq(a.strides,{0,0},"empty-source/(0, 3)/complex128/(2,): source strides")
cases=cases+1
end
-- 555: empty-source/(0, 3)/complex128/(1, 2); source error=IndexError
do
local base=np.zeros({0,3},"complex128")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0, 3)/complex128/(1, 2): acceptance"..": "..tostring(result))
eq(base:tolist(),{},"empty-source/(0, 3)/complex128/(1, 2): backing source")
eq(base.shape,{0,3},"empty-source/(0, 3)/complex128/(1, 2): backing source: shape")
eq(base.strides,{0,0},"empty-source/(0, 3)/complex128/(1, 2): backing source: strides")
eq(base.dtype,"complex128","empty-source/(0, 3)/complex128/(1, 2): backing source: dtype")
eq(a.shape,{0,3},"empty-source/(0, 3)/complex128/(1, 2): source shape")
eq(a.strides,{0,0},"empty-source/(0, 3)/complex128/(1, 2): source strides")
cases=cases+1
end
-- 556: empty-source/(0, 3)/U4/(); source error=IndexError
do
local base=np.zeros({0,3},"<U4")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0, 3)/U4/(): acceptance"..": "..tostring(result))
eq(base:tolist(),{},"empty-source/(0, 3)/U4/(): backing source")
eq(base.shape,{0,3},"empty-source/(0, 3)/U4/(): backing source: shape")
eq(base.strides,{0,0},"empty-source/(0, 3)/U4/(): backing source: strides")
eq(base.dtype,"<U4","empty-source/(0, 3)/U4/(): backing source: dtype")
eq(a.shape,{0,3},"empty-source/(0, 3)/U4/(): source shape")
eq(a.strides,{0,0},"empty-source/(0, 3)/U4/(): source strides")
cases=cases+1
end
-- 557: empty-source/(0, 3)/U4/(0,); source error=None
do
local base=np.zeros({0,3},"<U4")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(0, 3)/U4/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-source/(0, 3)/U4/(0,): result")
eq(result.shape,{0},"empty-source/(0, 3)/U4/(0,): result: shape")
eq(result.strides,{0},"empty-source/(0, 3)/U4/(0,): result: strides")
eq(result.dtype,"<U4","empty-source/(0, 3)/U4/(0,): result: dtype")
eq(base:tolist(),{},"empty-source/(0, 3)/U4/(0,): backing source")
eq(base.shape,{0,3},"empty-source/(0, 3)/U4/(0,): backing source: shape")
eq(base.strides,{0,0},"empty-source/(0, 3)/U4/(0,): backing source: strides")
eq(base.dtype,"<U4","empty-source/(0, 3)/U4/(0,): backing source: dtype")
eq(a.shape,{0,3},"empty-source/(0, 3)/U4/(0,): source shape")
eq(a.strides,{0,0},"empty-source/(0, 3)/U4/(0,): source strides")
cases=cases+1
end
-- 558: empty-source/(0, 3)/U4/(1,); source error=IndexError
do
local base=np.zeros({0,3},"<U4")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0, 3)/U4/(1,): acceptance"..": "..tostring(result))
eq(base:tolist(),{},"empty-source/(0, 3)/U4/(1,): backing source")
eq(base.shape,{0,3},"empty-source/(0, 3)/U4/(1,): backing source: shape")
eq(base.strides,{0,0},"empty-source/(0, 3)/U4/(1,): backing source: strides")
eq(base.dtype,"<U4","empty-source/(0, 3)/U4/(1,): backing source: dtype")
eq(a.shape,{0,3},"empty-source/(0, 3)/U4/(1,): source shape")
eq(a.strides,{0,0},"empty-source/(0, 3)/U4/(1,): source strides")
cases=cases+1
end
-- 559: empty-source/(0, 3)/U4/(2,); source error=IndexError
do
local base=np.zeros({0,3},"<U4")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0, 3)/U4/(2,): acceptance"..": "..tostring(result))
eq(base:tolist(),{},"empty-source/(0, 3)/U4/(2,): backing source")
eq(base.shape,{0,3},"empty-source/(0, 3)/U4/(2,): backing source: shape")
eq(base.strides,{0,0},"empty-source/(0, 3)/U4/(2,): backing source: strides")
eq(base.dtype,"<U4","empty-source/(0, 3)/U4/(2,): backing source: dtype")
eq(a.shape,{0,3},"empty-source/(0, 3)/U4/(2,): source shape")
eq(a.strides,{0,0},"empty-source/(0, 3)/U4/(2,): source strides")
cases=cases+1
end
-- 560: empty-source/(0, 3)/U4/(1, 2); source error=IndexError
do
local base=np.zeros({0,3},"<U4")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0, 3)/U4/(1, 2): acceptance"..": "..tostring(result))
eq(base:tolist(),{},"empty-source/(0, 3)/U4/(1, 2): backing source")
eq(base.shape,{0,3},"empty-source/(0, 3)/U4/(1, 2): backing source: shape")
eq(base.strides,{0,0},"empty-source/(0, 3)/U4/(1, 2): backing source: strides")
eq(base.dtype,"<U4","empty-source/(0, 3)/U4/(1, 2): backing source: dtype")
eq(a.shape,{0,3},"empty-source/(0, 3)/U4/(1, 2): source shape")
eq(a.strides,{0,0},"empty-source/(0, 3)/U4/(1, 2): source strides")
cases=cases+1
end
-- 561: empty-source/(0, 3)/S4/(); source error=IndexError
do
local base=np.zeros({0,3},"|S4")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0, 3)/S4/(): acceptance"..": "..tostring(result))
eq(base:tolist(),{},"empty-source/(0, 3)/S4/(): backing source")
eq(base.shape,{0,3},"empty-source/(0, 3)/S4/(): backing source: shape")
eq(base.strides,{0,0},"empty-source/(0, 3)/S4/(): backing source: strides")
eq(base.dtype,"|S4","empty-source/(0, 3)/S4/(): backing source: dtype")
eq(a.shape,{0,3},"empty-source/(0, 3)/S4/(): source shape")
eq(a.strides,{0,0},"empty-source/(0, 3)/S4/(): source strides")
cases=cases+1
end
-- 562: empty-source/(0, 3)/S4/(0,); source error=None
do
local base=np.zeros({0,3},"|S4")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(0, 3)/S4/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-source/(0, 3)/S4/(0,): result")
eq(result.shape,{0},"empty-source/(0, 3)/S4/(0,): result: shape")
eq(result.strides,{0},"empty-source/(0, 3)/S4/(0,): result: strides")
eq(result.dtype,"|S4","empty-source/(0, 3)/S4/(0,): result: dtype")
eq(base:tolist(),{},"empty-source/(0, 3)/S4/(0,): backing source")
eq(base.shape,{0,3},"empty-source/(0, 3)/S4/(0,): backing source: shape")
eq(base.strides,{0,0},"empty-source/(0, 3)/S4/(0,): backing source: strides")
eq(base.dtype,"|S4","empty-source/(0, 3)/S4/(0,): backing source: dtype")
eq(a.shape,{0,3},"empty-source/(0, 3)/S4/(0,): source shape")
eq(a.strides,{0,0},"empty-source/(0, 3)/S4/(0,): source strides")
cases=cases+1
end
-- 563: empty-source/(0, 3)/S4/(1,); source error=IndexError
do
local base=np.zeros({0,3},"|S4")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0, 3)/S4/(1,): acceptance"..": "..tostring(result))
eq(base:tolist(),{},"empty-source/(0, 3)/S4/(1,): backing source")
eq(base.shape,{0,3},"empty-source/(0, 3)/S4/(1,): backing source: shape")
eq(base.strides,{0,0},"empty-source/(0, 3)/S4/(1,): backing source: strides")
eq(base.dtype,"|S4","empty-source/(0, 3)/S4/(1,): backing source: dtype")
eq(a.shape,{0,3},"empty-source/(0, 3)/S4/(1,): source shape")
eq(a.strides,{0,0},"empty-source/(0, 3)/S4/(1,): source strides")
cases=cases+1
end
-- 564: empty-source/(0, 3)/S4/(2,); source error=IndexError
do
local base=np.zeros({0,3},"|S4")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0, 3)/S4/(2,): acceptance"..": "..tostring(result))
eq(base:tolist(),{},"empty-source/(0, 3)/S4/(2,): backing source")
eq(base.shape,{0,3},"empty-source/(0, 3)/S4/(2,): backing source: shape")
eq(base.strides,{0,0},"empty-source/(0, 3)/S4/(2,): backing source: strides")
eq(base.dtype,"|S4","empty-source/(0, 3)/S4/(2,): backing source: dtype")
eq(a.shape,{0,3},"empty-source/(0, 3)/S4/(2,): source shape")
eq(a.strides,{0,0},"empty-source/(0, 3)/S4/(2,): source strides")
cases=cases+1
end
-- 565: empty-source/(0, 3)/S4/(1, 2); source error=IndexError
do
local base=np.zeros({0,3},"|S4")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0, 3)/S4/(1, 2): acceptance"..": "..tostring(result))
eq(base:tolist(),{},"empty-source/(0, 3)/S4/(1, 2): backing source")
eq(base.shape,{0,3},"empty-source/(0, 3)/S4/(1, 2): backing source: shape")
eq(base.strides,{0,0},"empty-source/(0, 3)/S4/(1, 2): backing source: strides")
eq(base.dtype,"|S4","empty-source/(0, 3)/S4/(1, 2): backing source: dtype")
eq(a.shape,{0,3},"empty-source/(0, 3)/S4/(1, 2): source shape")
eq(a.strides,{0,0},"empty-source/(0, 3)/S4/(1, 2): source strides")
cases=cases+1
end
-- 566: empty-source/(0, 3)/datetime64[D]/(); source error=IndexError
do
local base=np.zeros({0,3},"datetime64[D]")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0, 3)/datetime64[D]/(): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),{},"empty-source/(0, 3)/datetime64[D]/(): backing source")
eq(base.shape,{0,3},"empty-source/(0, 3)/datetime64[D]/(): backing source: shape")
eq(base.strides,{0,0},"empty-source/(0, 3)/datetime64[D]/(): backing source: strides")
eq(base.dtype,"datetime64[D]","empty-source/(0, 3)/datetime64[D]/(): backing source: dtype")
eq(a.shape,{0,3},"empty-source/(0, 3)/datetime64[D]/(): source shape")
eq(a.strides,{0,0},"empty-source/(0, 3)/datetime64[D]/(): source strides")
cases=cases+1
end
-- 567: empty-source/(0, 3)/datetime64[D]/(0,); source error=None
do
local base=np.zeros({0,3},"datetime64[D]")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(0, 3)/datetime64[D]/(0,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{},"empty-source/(0, 3)/datetime64[D]/(0,): result")
eq(result.shape,{0},"empty-source/(0, 3)/datetime64[D]/(0,): result: shape")
eq(result.strides,{0},"empty-source/(0, 3)/datetime64[D]/(0,): result: strides")
eq(result.dtype,"datetime64[D]","empty-source/(0, 3)/datetime64[D]/(0,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{},"empty-source/(0, 3)/datetime64[D]/(0,): backing source")
eq(base.shape,{0,3},"empty-source/(0, 3)/datetime64[D]/(0,): backing source: shape")
eq(base.strides,{0,0},"empty-source/(0, 3)/datetime64[D]/(0,): backing source: strides")
eq(base.dtype,"datetime64[D]","empty-source/(0, 3)/datetime64[D]/(0,): backing source: dtype")
eq(a.shape,{0,3},"empty-source/(0, 3)/datetime64[D]/(0,): source shape")
eq(a.strides,{0,0},"empty-source/(0, 3)/datetime64[D]/(0,): source strides")
cases=cases+1
end
-- 568: empty-source/(0, 3)/datetime64[D]/(1,); source error=IndexError
do
local base=np.zeros({0,3},"datetime64[D]")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0, 3)/datetime64[D]/(1,): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),{},"empty-source/(0, 3)/datetime64[D]/(1,): backing source")
eq(base.shape,{0,3},"empty-source/(0, 3)/datetime64[D]/(1,): backing source: shape")
eq(base.strides,{0,0},"empty-source/(0, 3)/datetime64[D]/(1,): backing source: strides")
eq(base.dtype,"datetime64[D]","empty-source/(0, 3)/datetime64[D]/(1,): backing source: dtype")
eq(a.shape,{0,3},"empty-source/(0, 3)/datetime64[D]/(1,): source shape")
eq(a.strides,{0,0},"empty-source/(0, 3)/datetime64[D]/(1,): source strides")
cases=cases+1
end
-- 569: empty-source/(0, 3)/datetime64[D]/(2,); source error=IndexError
do
local base=np.zeros({0,3},"datetime64[D]")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0, 3)/datetime64[D]/(2,): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),{},"empty-source/(0, 3)/datetime64[D]/(2,): backing source")
eq(base.shape,{0,3},"empty-source/(0, 3)/datetime64[D]/(2,): backing source: shape")
eq(base.strides,{0,0},"empty-source/(0, 3)/datetime64[D]/(2,): backing source: strides")
eq(base.dtype,"datetime64[D]","empty-source/(0, 3)/datetime64[D]/(2,): backing source: dtype")
eq(a.shape,{0,3},"empty-source/(0, 3)/datetime64[D]/(2,): source shape")
eq(a.strides,{0,0},"empty-source/(0, 3)/datetime64[D]/(2,): source strides")
cases=cases+1
end
-- 570: empty-source/(0, 3)/datetime64[D]/(1, 2); source error=IndexError
do
local base=np.zeros({0,3},"datetime64[D]")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0, 3)/datetime64[D]/(1, 2): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),{},"empty-source/(0, 3)/datetime64[D]/(1, 2): backing source")
eq(base.shape,{0,3},"empty-source/(0, 3)/datetime64[D]/(1, 2): backing source: shape")
eq(base.strides,{0,0},"empty-source/(0, 3)/datetime64[D]/(1, 2): backing source: strides")
eq(base.dtype,"datetime64[D]","empty-source/(0, 3)/datetime64[D]/(1, 2): backing source: dtype")
eq(a.shape,{0,3},"empty-source/(0, 3)/datetime64[D]/(1, 2): source shape")
eq(a.strides,{0,0},"empty-source/(0, 3)/datetime64[D]/(1, 2): source strides")
cases=cases+1
end
-- 571: empty-source/(0, 3)/timedelta64[h]/(); source error=IndexError
do
local base=np.zeros({0,3},"timedelta64[h]")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0, 3)/timedelta64[h]/(): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),{},"empty-source/(0, 3)/timedelta64[h]/(): backing source")
eq(base.shape,{0,3},"empty-source/(0, 3)/timedelta64[h]/(): backing source: shape")
eq(base.strides,{0,0},"empty-source/(0, 3)/timedelta64[h]/(): backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-source/(0, 3)/timedelta64[h]/(): backing source: dtype")
eq(a.shape,{0,3},"empty-source/(0, 3)/timedelta64[h]/(): source shape")
eq(a.strides,{0,0},"empty-source/(0, 3)/timedelta64[h]/(): source strides")
cases=cases+1
end
-- 572: empty-source/(0, 3)/timedelta64[h]/(0,); source error=None
do
local base=np.zeros({0,3},"timedelta64[h]")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(0, 3)/timedelta64[h]/(0,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{},"empty-source/(0, 3)/timedelta64[h]/(0,): result")
eq(result.shape,{0},"empty-source/(0, 3)/timedelta64[h]/(0,): result: shape")
eq(result.strides,{0},"empty-source/(0, 3)/timedelta64[h]/(0,): result: strides")
eq(result.dtype,"timedelta64[h]","empty-source/(0, 3)/timedelta64[h]/(0,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{},"empty-source/(0, 3)/timedelta64[h]/(0,): backing source")
eq(base.shape,{0,3},"empty-source/(0, 3)/timedelta64[h]/(0,): backing source: shape")
eq(base.strides,{0,0},"empty-source/(0, 3)/timedelta64[h]/(0,): backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-source/(0, 3)/timedelta64[h]/(0,): backing source: dtype")
eq(a.shape,{0,3},"empty-source/(0, 3)/timedelta64[h]/(0,): source shape")
eq(a.strides,{0,0},"empty-source/(0, 3)/timedelta64[h]/(0,): source strides")
cases=cases+1
end
-- 573: empty-source/(0, 3)/timedelta64[h]/(1,); source error=IndexError
do
local base=np.zeros({0,3},"timedelta64[h]")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0, 3)/timedelta64[h]/(1,): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),{},"empty-source/(0, 3)/timedelta64[h]/(1,): backing source")
eq(base.shape,{0,3},"empty-source/(0, 3)/timedelta64[h]/(1,): backing source: shape")
eq(base.strides,{0,0},"empty-source/(0, 3)/timedelta64[h]/(1,): backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-source/(0, 3)/timedelta64[h]/(1,): backing source: dtype")
eq(a.shape,{0,3},"empty-source/(0, 3)/timedelta64[h]/(1,): source shape")
eq(a.strides,{0,0},"empty-source/(0, 3)/timedelta64[h]/(1,): source strides")
cases=cases+1
end
-- 574: empty-source/(0, 3)/timedelta64[h]/(2,); source error=IndexError
do
local base=np.zeros({0,3},"timedelta64[h]")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0, 3)/timedelta64[h]/(2,): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),{},"empty-source/(0, 3)/timedelta64[h]/(2,): backing source")
eq(base.shape,{0,3},"empty-source/(0, 3)/timedelta64[h]/(2,): backing source: shape")
eq(base.strides,{0,0},"empty-source/(0, 3)/timedelta64[h]/(2,): backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-source/(0, 3)/timedelta64[h]/(2,): backing source: dtype")
eq(a.shape,{0,3},"empty-source/(0, 3)/timedelta64[h]/(2,): source shape")
eq(a.strides,{0,0},"empty-source/(0, 3)/timedelta64[h]/(2,): source strides")
cases=cases+1
end
-- 575: empty-source/(0, 3)/timedelta64[h]/(1, 2); source error=IndexError
do
local base=np.zeros({0,3},"timedelta64[h]")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(0, 3)/timedelta64[h]/(1, 2): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),{},"empty-source/(0, 3)/timedelta64[h]/(1, 2): backing source")
eq(base.shape,{0,3},"empty-source/(0, 3)/timedelta64[h]/(1, 2): backing source: shape")
eq(base.strides,{0,0},"empty-source/(0, 3)/timedelta64[h]/(1, 2): backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-source/(0, 3)/timedelta64[h]/(1, 2): backing source: dtype")
eq(a.shape,{0,3},"empty-source/(0, 3)/timedelta64[h]/(1, 2): source shape")
eq(a.strides,{0,0},"empty-source/(0, 3)/timedelta64[h]/(1, 2): source strides")
cases=cases+1
end
-- 576: empty-source/(2, 0)/int32/(); source error=IndexError
do
local base=np.zeros({2,0},"int32")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(2, 0)/int32/(): acceptance"..": "..tostring(result))
eq(base:tolist(),{{},{}},"empty-source/(2, 0)/int32/(): backing source")
eq(base.shape,{2,0},"empty-source/(2, 0)/int32/(): backing source: shape")
eq(base.strides,{0,0},"empty-source/(2, 0)/int32/(): backing source: strides")
eq(base.dtype,"int32","empty-source/(2, 0)/int32/(): backing source: dtype")
eq(a.shape,{2,0},"empty-source/(2, 0)/int32/(): source shape")
eq(a.strides,{0,0},"empty-source/(2, 0)/int32/(): source strides")
cases=cases+1
end
-- 577: empty-source/(2, 0)/int32/(0,); source error=None
do
local base=np.zeros({2,0},"int32")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 0)/int32/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-source/(2, 0)/int32/(0,): result")
eq(result.shape,{0},"empty-source/(2, 0)/int32/(0,): result: shape")
eq(result.strides,{0},"empty-source/(2, 0)/int32/(0,): result: strides")
eq(result.dtype,"int32","empty-source/(2, 0)/int32/(0,): result: dtype")
eq(base:tolist(),{{},{}},"empty-source/(2, 0)/int32/(0,): backing source")
eq(base.shape,{2,0},"empty-source/(2, 0)/int32/(0,): backing source: shape")
eq(base.strides,{0,0},"empty-source/(2, 0)/int32/(0,): backing source: strides")
eq(base.dtype,"int32","empty-source/(2, 0)/int32/(0,): backing source: dtype")
eq(a.shape,{2,0},"empty-source/(2, 0)/int32/(0,): source shape")
eq(a.strides,{0,0},"empty-source/(2, 0)/int32/(0,): source strides")
cases=cases+1
end
-- 578: empty-source/(2, 0)/int32/(1,); source error=IndexError
do
local base=np.zeros({2,0},"int32")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(2, 0)/int32/(1,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{},{}},"empty-source/(2, 0)/int32/(1,): backing source")
eq(base.shape,{2,0},"empty-source/(2, 0)/int32/(1,): backing source: shape")
eq(base.strides,{0,0},"empty-source/(2, 0)/int32/(1,): backing source: strides")
eq(base.dtype,"int32","empty-source/(2, 0)/int32/(1,): backing source: dtype")
eq(a.shape,{2,0},"empty-source/(2, 0)/int32/(1,): source shape")
eq(a.strides,{0,0},"empty-source/(2, 0)/int32/(1,): source strides")
cases=cases+1
end
-- 579: empty-source/(2, 0)/int32/(2,); source error=IndexError
do
local base=np.zeros({2,0},"int32")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(2, 0)/int32/(2,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{},{}},"empty-source/(2, 0)/int32/(2,): backing source")
eq(base.shape,{2,0},"empty-source/(2, 0)/int32/(2,): backing source: shape")
eq(base.strides,{0,0},"empty-source/(2, 0)/int32/(2,): backing source: strides")
eq(base.dtype,"int32","empty-source/(2, 0)/int32/(2,): backing source: dtype")
eq(a.shape,{2,0},"empty-source/(2, 0)/int32/(2,): source shape")
eq(a.strides,{0,0},"empty-source/(2, 0)/int32/(2,): source strides")
cases=cases+1
end
-- 580: empty-source/(2, 0)/int32/(1, 2); source error=IndexError
do
local base=np.zeros({2,0},"int32")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(2, 0)/int32/(1, 2): acceptance"..": "..tostring(result))
eq(base:tolist(),{{},{}},"empty-source/(2, 0)/int32/(1, 2): backing source")
eq(base.shape,{2,0},"empty-source/(2, 0)/int32/(1, 2): backing source: shape")
eq(base.strides,{0,0},"empty-source/(2, 0)/int32/(1, 2): backing source: strides")
eq(base.dtype,"int32","empty-source/(2, 0)/int32/(1, 2): backing source: dtype")
eq(a.shape,{2,0},"empty-source/(2, 0)/int32/(1, 2): source shape")
eq(a.strides,{0,0},"empty-source/(2, 0)/int32/(1, 2): source strides")
cases=cases+1
end
-- 581: empty-source/(2, 0)/float32/(); source error=IndexError
do
local base=np.zeros({2,0},"float32")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(2, 0)/float32/(): acceptance"..": "..tostring(result))
eq(base:tolist(),{{},{}},"empty-source/(2, 0)/float32/(): backing source")
eq(base.shape,{2,0},"empty-source/(2, 0)/float32/(): backing source: shape")
eq(base.strides,{0,0},"empty-source/(2, 0)/float32/(): backing source: strides")
eq(base.dtype,"float32","empty-source/(2, 0)/float32/(): backing source: dtype")
eq(a.shape,{2,0},"empty-source/(2, 0)/float32/(): source shape")
eq(a.strides,{0,0},"empty-source/(2, 0)/float32/(): source strides")
cases=cases+1
end
-- 582: empty-source/(2, 0)/float32/(0,); source error=None
do
local base=np.zeros({2,0},"float32")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 0)/float32/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-source/(2, 0)/float32/(0,): result")
eq(result.shape,{0},"empty-source/(2, 0)/float32/(0,): result: shape")
eq(result.strides,{0},"empty-source/(2, 0)/float32/(0,): result: strides")
eq(result.dtype,"float32","empty-source/(2, 0)/float32/(0,): result: dtype")
eq(base:tolist(),{{},{}},"empty-source/(2, 0)/float32/(0,): backing source")
eq(base.shape,{2,0},"empty-source/(2, 0)/float32/(0,): backing source: shape")
eq(base.strides,{0,0},"empty-source/(2, 0)/float32/(0,): backing source: strides")
eq(base.dtype,"float32","empty-source/(2, 0)/float32/(0,): backing source: dtype")
eq(a.shape,{2,0},"empty-source/(2, 0)/float32/(0,): source shape")
eq(a.strides,{0,0},"empty-source/(2, 0)/float32/(0,): source strides")
cases=cases+1
end
-- 583: empty-source/(2, 0)/float32/(1,); source error=IndexError
do
local base=np.zeros({2,0},"float32")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(2, 0)/float32/(1,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{},{}},"empty-source/(2, 0)/float32/(1,): backing source")
eq(base.shape,{2,0},"empty-source/(2, 0)/float32/(1,): backing source: shape")
eq(base.strides,{0,0},"empty-source/(2, 0)/float32/(1,): backing source: strides")
eq(base.dtype,"float32","empty-source/(2, 0)/float32/(1,): backing source: dtype")
eq(a.shape,{2,0},"empty-source/(2, 0)/float32/(1,): source shape")
eq(a.strides,{0,0},"empty-source/(2, 0)/float32/(1,): source strides")
cases=cases+1
end
-- 584: empty-source/(2, 0)/float32/(2,); source error=IndexError
do
local base=np.zeros({2,0},"float32")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(2, 0)/float32/(2,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{},{}},"empty-source/(2, 0)/float32/(2,): backing source")
eq(base.shape,{2,0},"empty-source/(2, 0)/float32/(2,): backing source: shape")
eq(base.strides,{0,0},"empty-source/(2, 0)/float32/(2,): backing source: strides")
eq(base.dtype,"float32","empty-source/(2, 0)/float32/(2,): backing source: dtype")
eq(a.shape,{2,0},"empty-source/(2, 0)/float32/(2,): source shape")
eq(a.strides,{0,0},"empty-source/(2, 0)/float32/(2,): source strides")
cases=cases+1
end
-- 585: empty-source/(2, 0)/float32/(1, 2); source error=IndexError
do
local base=np.zeros({2,0},"float32")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(2, 0)/float32/(1, 2): acceptance"..": "..tostring(result))
eq(base:tolist(),{{},{}},"empty-source/(2, 0)/float32/(1, 2): backing source")
eq(base.shape,{2,0},"empty-source/(2, 0)/float32/(1, 2): backing source: shape")
eq(base.strides,{0,0},"empty-source/(2, 0)/float32/(1, 2): backing source: strides")
eq(base.dtype,"float32","empty-source/(2, 0)/float32/(1, 2): backing source: dtype")
eq(a.shape,{2,0},"empty-source/(2, 0)/float32/(1, 2): source shape")
eq(a.strides,{0,0},"empty-source/(2, 0)/float32/(1, 2): source strides")
cases=cases+1
end
-- 586: empty-source/(2, 0)/complex128/(); source error=IndexError
do
local base=np.zeros({2,0},"complex128")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(2, 0)/complex128/(): acceptance"..": "..tostring(result))
eq(base:tolist(),{{},{}},"empty-source/(2, 0)/complex128/(): backing source")
eq(base.shape,{2,0},"empty-source/(2, 0)/complex128/(): backing source: shape")
eq(base.strides,{0,0},"empty-source/(2, 0)/complex128/(): backing source: strides")
eq(base.dtype,"complex128","empty-source/(2, 0)/complex128/(): backing source: dtype")
eq(a.shape,{2,0},"empty-source/(2, 0)/complex128/(): source shape")
eq(a.strides,{0,0},"empty-source/(2, 0)/complex128/(): source strides")
cases=cases+1
end
-- 587: empty-source/(2, 0)/complex128/(0,); source error=None
do
local base=np.zeros({2,0},"complex128")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 0)/complex128/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-source/(2, 0)/complex128/(0,): result")
eq(result.shape,{0},"empty-source/(2, 0)/complex128/(0,): result: shape")
eq(result.strides,{0},"empty-source/(2, 0)/complex128/(0,): result: strides")
eq(result.dtype,"complex128","empty-source/(2, 0)/complex128/(0,): result: dtype")
eq(base:tolist(),{{},{}},"empty-source/(2, 0)/complex128/(0,): backing source")
eq(base.shape,{2,0},"empty-source/(2, 0)/complex128/(0,): backing source: shape")
eq(base.strides,{0,0},"empty-source/(2, 0)/complex128/(0,): backing source: strides")
eq(base.dtype,"complex128","empty-source/(2, 0)/complex128/(0,): backing source: dtype")
eq(a.shape,{2,0},"empty-source/(2, 0)/complex128/(0,): source shape")
eq(a.strides,{0,0},"empty-source/(2, 0)/complex128/(0,): source strides")
cases=cases+1
end
-- 588: empty-source/(2, 0)/complex128/(1,); source error=IndexError
do
local base=np.zeros({2,0},"complex128")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(2, 0)/complex128/(1,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{},{}},"empty-source/(2, 0)/complex128/(1,): backing source")
eq(base.shape,{2,0},"empty-source/(2, 0)/complex128/(1,): backing source: shape")
eq(base.strides,{0,0},"empty-source/(2, 0)/complex128/(1,): backing source: strides")
eq(base.dtype,"complex128","empty-source/(2, 0)/complex128/(1,): backing source: dtype")
eq(a.shape,{2,0},"empty-source/(2, 0)/complex128/(1,): source shape")
eq(a.strides,{0,0},"empty-source/(2, 0)/complex128/(1,): source strides")
cases=cases+1
end
-- 589: empty-source/(2, 0)/complex128/(2,); source error=IndexError
do
local base=np.zeros({2,0},"complex128")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(2, 0)/complex128/(2,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{},{}},"empty-source/(2, 0)/complex128/(2,): backing source")
eq(base.shape,{2,0},"empty-source/(2, 0)/complex128/(2,): backing source: shape")
eq(base.strides,{0,0},"empty-source/(2, 0)/complex128/(2,): backing source: strides")
eq(base.dtype,"complex128","empty-source/(2, 0)/complex128/(2,): backing source: dtype")
eq(a.shape,{2,0},"empty-source/(2, 0)/complex128/(2,): source shape")
eq(a.strides,{0,0},"empty-source/(2, 0)/complex128/(2,): source strides")
cases=cases+1
end
-- 590: empty-source/(2, 0)/complex128/(1, 2); source error=IndexError
do
local base=np.zeros({2,0},"complex128")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(2, 0)/complex128/(1, 2): acceptance"..": "..tostring(result))
eq(base:tolist(),{{},{}},"empty-source/(2, 0)/complex128/(1, 2): backing source")
eq(base.shape,{2,0},"empty-source/(2, 0)/complex128/(1, 2): backing source: shape")
eq(base.strides,{0,0},"empty-source/(2, 0)/complex128/(1, 2): backing source: strides")
eq(base.dtype,"complex128","empty-source/(2, 0)/complex128/(1, 2): backing source: dtype")
eq(a.shape,{2,0},"empty-source/(2, 0)/complex128/(1, 2): source shape")
eq(a.strides,{0,0},"empty-source/(2, 0)/complex128/(1, 2): source strides")
cases=cases+1
end
-- 591: empty-source/(2, 0)/U4/(); source error=IndexError
do
local base=np.zeros({2,0},"<U4")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(2, 0)/U4/(): acceptance"..": "..tostring(result))
eq(base:tolist(),{{},{}},"empty-source/(2, 0)/U4/(): backing source")
eq(base.shape,{2,0},"empty-source/(2, 0)/U4/(): backing source: shape")
eq(base.strides,{0,0},"empty-source/(2, 0)/U4/(): backing source: strides")
eq(base.dtype,"<U4","empty-source/(2, 0)/U4/(): backing source: dtype")
eq(a.shape,{2,0},"empty-source/(2, 0)/U4/(): source shape")
eq(a.strides,{0,0},"empty-source/(2, 0)/U4/(): source strides")
cases=cases+1
end
-- 592: empty-source/(2, 0)/U4/(0,); source error=None
do
local base=np.zeros({2,0},"<U4")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 0)/U4/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-source/(2, 0)/U4/(0,): result")
eq(result.shape,{0},"empty-source/(2, 0)/U4/(0,): result: shape")
eq(result.strides,{0},"empty-source/(2, 0)/U4/(0,): result: strides")
eq(result.dtype,"<U4","empty-source/(2, 0)/U4/(0,): result: dtype")
eq(base:tolist(),{{},{}},"empty-source/(2, 0)/U4/(0,): backing source")
eq(base.shape,{2,0},"empty-source/(2, 0)/U4/(0,): backing source: shape")
eq(base.strides,{0,0},"empty-source/(2, 0)/U4/(0,): backing source: strides")
eq(base.dtype,"<U4","empty-source/(2, 0)/U4/(0,): backing source: dtype")
eq(a.shape,{2,0},"empty-source/(2, 0)/U4/(0,): source shape")
eq(a.strides,{0,0},"empty-source/(2, 0)/U4/(0,): source strides")
cases=cases+1
end
-- 593: empty-source/(2, 0)/U4/(1,); source error=IndexError
do
local base=np.zeros({2,0},"<U4")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(2, 0)/U4/(1,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{},{}},"empty-source/(2, 0)/U4/(1,): backing source")
eq(base.shape,{2,0},"empty-source/(2, 0)/U4/(1,): backing source: shape")
eq(base.strides,{0,0},"empty-source/(2, 0)/U4/(1,): backing source: strides")
eq(base.dtype,"<U4","empty-source/(2, 0)/U4/(1,): backing source: dtype")
eq(a.shape,{2,0},"empty-source/(2, 0)/U4/(1,): source shape")
eq(a.strides,{0,0},"empty-source/(2, 0)/U4/(1,): source strides")
cases=cases+1
end
-- 594: empty-source/(2, 0)/U4/(2,); source error=IndexError
do
local base=np.zeros({2,0},"<U4")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(2, 0)/U4/(2,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{},{}},"empty-source/(2, 0)/U4/(2,): backing source")
eq(base.shape,{2,0},"empty-source/(2, 0)/U4/(2,): backing source: shape")
eq(base.strides,{0,0},"empty-source/(2, 0)/U4/(2,): backing source: strides")
eq(base.dtype,"<U4","empty-source/(2, 0)/U4/(2,): backing source: dtype")
eq(a.shape,{2,0},"empty-source/(2, 0)/U4/(2,): source shape")
eq(a.strides,{0,0},"empty-source/(2, 0)/U4/(2,): source strides")
cases=cases+1
end
-- 595: empty-source/(2, 0)/U4/(1, 2); source error=IndexError
do
local base=np.zeros({2,0},"<U4")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(2, 0)/U4/(1, 2): acceptance"..": "..tostring(result))
eq(base:tolist(),{{},{}},"empty-source/(2, 0)/U4/(1, 2): backing source")
eq(base.shape,{2,0},"empty-source/(2, 0)/U4/(1, 2): backing source: shape")
eq(base.strides,{0,0},"empty-source/(2, 0)/U4/(1, 2): backing source: strides")
eq(base.dtype,"<U4","empty-source/(2, 0)/U4/(1, 2): backing source: dtype")
eq(a.shape,{2,0},"empty-source/(2, 0)/U4/(1, 2): source shape")
eq(a.strides,{0,0},"empty-source/(2, 0)/U4/(1, 2): source strides")
cases=cases+1
end
-- 596: empty-source/(2, 0)/S4/(); source error=IndexError
do
local base=np.zeros({2,0},"|S4")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(2, 0)/S4/(): acceptance"..": "..tostring(result))
eq(base:tolist(),{{},{}},"empty-source/(2, 0)/S4/(): backing source")
eq(base.shape,{2,0},"empty-source/(2, 0)/S4/(): backing source: shape")
eq(base.strides,{0,0},"empty-source/(2, 0)/S4/(): backing source: strides")
eq(base.dtype,"|S4","empty-source/(2, 0)/S4/(): backing source: dtype")
eq(a.shape,{2,0},"empty-source/(2, 0)/S4/(): source shape")
eq(a.strides,{0,0},"empty-source/(2, 0)/S4/(): source strides")
cases=cases+1
end
-- 597: empty-source/(2, 0)/S4/(0,); source error=None
do
local base=np.zeros({2,0},"|S4")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 0)/S4/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-source/(2, 0)/S4/(0,): result")
eq(result.shape,{0},"empty-source/(2, 0)/S4/(0,): result: shape")
eq(result.strides,{0},"empty-source/(2, 0)/S4/(0,): result: strides")
eq(result.dtype,"|S4","empty-source/(2, 0)/S4/(0,): result: dtype")
eq(base:tolist(),{{},{}},"empty-source/(2, 0)/S4/(0,): backing source")
eq(base.shape,{2,0},"empty-source/(2, 0)/S4/(0,): backing source: shape")
eq(base.strides,{0,0},"empty-source/(2, 0)/S4/(0,): backing source: strides")
eq(base.dtype,"|S4","empty-source/(2, 0)/S4/(0,): backing source: dtype")
eq(a.shape,{2,0},"empty-source/(2, 0)/S4/(0,): source shape")
eq(a.strides,{0,0},"empty-source/(2, 0)/S4/(0,): source strides")
cases=cases+1
end
-- 598: empty-source/(2, 0)/S4/(1,); source error=IndexError
do
local base=np.zeros({2,0},"|S4")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(2, 0)/S4/(1,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{},{}},"empty-source/(2, 0)/S4/(1,): backing source")
eq(base.shape,{2,0},"empty-source/(2, 0)/S4/(1,): backing source: shape")
eq(base.strides,{0,0},"empty-source/(2, 0)/S4/(1,): backing source: strides")
eq(base.dtype,"|S4","empty-source/(2, 0)/S4/(1,): backing source: dtype")
eq(a.shape,{2,0},"empty-source/(2, 0)/S4/(1,): source shape")
eq(a.strides,{0,0},"empty-source/(2, 0)/S4/(1,): source strides")
cases=cases+1
end
-- 599: empty-source/(2, 0)/S4/(2,); source error=IndexError
do
local base=np.zeros({2,0},"|S4")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(2, 0)/S4/(2,): acceptance"..": "..tostring(result))
eq(base:tolist(),{{},{}},"empty-source/(2, 0)/S4/(2,): backing source")
eq(base.shape,{2,0},"empty-source/(2, 0)/S4/(2,): backing source: shape")
eq(base.strides,{0,0},"empty-source/(2, 0)/S4/(2,): backing source: strides")
eq(base.dtype,"|S4","empty-source/(2, 0)/S4/(2,): backing source: dtype")
eq(a.shape,{2,0},"empty-source/(2, 0)/S4/(2,): source shape")
eq(a.strides,{0,0},"empty-source/(2, 0)/S4/(2,): source strides")
cases=cases+1
end
-- 600: empty-source/(2, 0)/S4/(1, 2); source error=IndexError
do
local base=np.zeros({2,0},"|S4")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(2, 0)/S4/(1, 2): acceptance"..": "..tostring(result))
eq(base:tolist(),{{},{}},"empty-source/(2, 0)/S4/(1, 2): backing source")
eq(base.shape,{2,0},"empty-source/(2, 0)/S4/(1, 2): backing source: shape")
eq(base.strides,{0,0},"empty-source/(2, 0)/S4/(1, 2): backing source: strides")
eq(base.dtype,"|S4","empty-source/(2, 0)/S4/(1, 2): backing source: dtype")
eq(a.shape,{2,0},"empty-source/(2, 0)/S4/(1, 2): source shape")
eq(a.strides,{0,0},"empty-source/(2, 0)/S4/(1, 2): source strides")
cases=cases+1
end
end
chunk()
end
do
local function chunk()
-- 601: empty-source/(2, 0)/datetime64[D]/(); source error=IndexError
do
local base=np.zeros({2,0},"datetime64[D]")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(2, 0)/datetime64[D]/(): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),{{},{}},"empty-source/(2, 0)/datetime64[D]/(): backing source")
eq(base.shape,{2,0},"empty-source/(2, 0)/datetime64[D]/(): backing source: shape")
eq(base.strides,{0,0},"empty-source/(2, 0)/datetime64[D]/(): backing source: strides")
eq(base.dtype,"datetime64[D]","empty-source/(2, 0)/datetime64[D]/(): backing source: dtype")
eq(a.shape,{2,0},"empty-source/(2, 0)/datetime64[D]/(): source shape")
eq(a.strides,{0,0},"empty-source/(2, 0)/datetime64[D]/(): source strides")
cases=cases+1
end
-- 602: empty-source/(2, 0)/datetime64[D]/(0,); source error=None
do
local base=np.zeros({2,0},"datetime64[D]")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 0)/datetime64[D]/(0,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{},"empty-source/(2, 0)/datetime64[D]/(0,): result")
eq(result.shape,{0},"empty-source/(2, 0)/datetime64[D]/(0,): result: shape")
eq(result.strides,{0},"empty-source/(2, 0)/datetime64[D]/(0,): result: strides")
eq(result.dtype,"datetime64[D]","empty-source/(2, 0)/datetime64[D]/(0,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{},{}},"empty-source/(2, 0)/datetime64[D]/(0,): backing source")
eq(base.shape,{2,0},"empty-source/(2, 0)/datetime64[D]/(0,): backing source: shape")
eq(base.strides,{0,0},"empty-source/(2, 0)/datetime64[D]/(0,): backing source: strides")
eq(base.dtype,"datetime64[D]","empty-source/(2, 0)/datetime64[D]/(0,): backing source: dtype")
eq(a.shape,{2,0},"empty-source/(2, 0)/datetime64[D]/(0,): source shape")
eq(a.strides,{0,0},"empty-source/(2, 0)/datetime64[D]/(0,): source strides")
cases=cases+1
end
-- 603: empty-source/(2, 0)/datetime64[D]/(1,); source error=IndexError
do
local base=np.zeros({2,0},"datetime64[D]")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(2, 0)/datetime64[D]/(1,): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),{{},{}},"empty-source/(2, 0)/datetime64[D]/(1,): backing source")
eq(base.shape,{2,0},"empty-source/(2, 0)/datetime64[D]/(1,): backing source: shape")
eq(base.strides,{0,0},"empty-source/(2, 0)/datetime64[D]/(1,): backing source: strides")
eq(base.dtype,"datetime64[D]","empty-source/(2, 0)/datetime64[D]/(1,): backing source: dtype")
eq(a.shape,{2,0},"empty-source/(2, 0)/datetime64[D]/(1,): source shape")
eq(a.strides,{0,0},"empty-source/(2, 0)/datetime64[D]/(1,): source strides")
cases=cases+1
end
-- 604: empty-source/(2, 0)/datetime64[D]/(2,); source error=IndexError
do
local base=np.zeros({2,0},"datetime64[D]")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(2, 0)/datetime64[D]/(2,): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),{{},{}},"empty-source/(2, 0)/datetime64[D]/(2,): backing source")
eq(base.shape,{2,0},"empty-source/(2, 0)/datetime64[D]/(2,): backing source: shape")
eq(base.strides,{0,0},"empty-source/(2, 0)/datetime64[D]/(2,): backing source: strides")
eq(base.dtype,"datetime64[D]","empty-source/(2, 0)/datetime64[D]/(2,): backing source: dtype")
eq(a.shape,{2,0},"empty-source/(2, 0)/datetime64[D]/(2,): source shape")
eq(a.strides,{0,0},"empty-source/(2, 0)/datetime64[D]/(2,): source strides")
cases=cases+1
end
-- 605: empty-source/(2, 0)/datetime64[D]/(1, 2); source error=IndexError
do
local base=np.zeros({2,0},"datetime64[D]")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(2, 0)/datetime64[D]/(1, 2): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),{{},{}},"empty-source/(2, 0)/datetime64[D]/(1, 2): backing source")
eq(base.shape,{2,0},"empty-source/(2, 0)/datetime64[D]/(1, 2): backing source: shape")
eq(base.strides,{0,0},"empty-source/(2, 0)/datetime64[D]/(1, 2): backing source: strides")
eq(base.dtype,"datetime64[D]","empty-source/(2, 0)/datetime64[D]/(1, 2): backing source: dtype")
eq(a.shape,{2,0},"empty-source/(2, 0)/datetime64[D]/(1, 2): source shape")
eq(a.strides,{0,0},"empty-source/(2, 0)/datetime64[D]/(1, 2): source strides")
cases=cases+1
end
-- 606: empty-source/(2, 0)/timedelta64[h]/(); source error=IndexError
do
local base=np.zeros({2,0},"timedelta64[h]")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(2, 0)/timedelta64[h]/(): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),{{},{}},"empty-source/(2, 0)/timedelta64[h]/(): backing source")
eq(base.shape,{2,0},"empty-source/(2, 0)/timedelta64[h]/(): backing source: shape")
eq(base.strides,{0,0},"empty-source/(2, 0)/timedelta64[h]/(): backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-source/(2, 0)/timedelta64[h]/(): backing source: dtype")
eq(a.shape,{2,0},"empty-source/(2, 0)/timedelta64[h]/(): source shape")
eq(a.strides,{0,0},"empty-source/(2, 0)/timedelta64[h]/(): source strides")
cases=cases+1
end
-- 607: empty-source/(2, 0)/timedelta64[h]/(0,); source error=None
do
local base=np.zeros({2,0},"timedelta64[h]")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 0)/timedelta64[h]/(0,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{},"empty-source/(2, 0)/timedelta64[h]/(0,): result")
eq(result.shape,{0},"empty-source/(2, 0)/timedelta64[h]/(0,): result: shape")
eq(result.strides,{0},"empty-source/(2, 0)/timedelta64[h]/(0,): result: strides")
eq(result.dtype,"timedelta64[h]","empty-source/(2, 0)/timedelta64[h]/(0,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{},{}},"empty-source/(2, 0)/timedelta64[h]/(0,): backing source")
eq(base.shape,{2,0},"empty-source/(2, 0)/timedelta64[h]/(0,): backing source: shape")
eq(base.strides,{0,0},"empty-source/(2, 0)/timedelta64[h]/(0,): backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-source/(2, 0)/timedelta64[h]/(0,): backing source: dtype")
eq(a.shape,{2,0},"empty-source/(2, 0)/timedelta64[h]/(0,): source shape")
eq(a.strides,{0,0},"empty-source/(2, 0)/timedelta64[h]/(0,): source strides")
cases=cases+1
end
-- 608: empty-source/(2, 0)/timedelta64[h]/(1,); source error=IndexError
do
local base=np.zeros({2,0},"timedelta64[h]")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(2, 0)/timedelta64[h]/(1,): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),{{},{}},"empty-source/(2, 0)/timedelta64[h]/(1,): backing source")
eq(base.shape,{2,0},"empty-source/(2, 0)/timedelta64[h]/(1,): backing source: shape")
eq(base.strides,{0,0},"empty-source/(2, 0)/timedelta64[h]/(1,): backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-source/(2, 0)/timedelta64[h]/(1,): backing source: dtype")
eq(a.shape,{2,0},"empty-source/(2, 0)/timedelta64[h]/(1,): source shape")
eq(a.strides,{0,0},"empty-source/(2, 0)/timedelta64[h]/(1,): source strides")
cases=cases+1
end
-- 609: empty-source/(2, 0)/timedelta64[h]/(2,); source error=IndexError
do
local base=np.zeros({2,0},"timedelta64[h]")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(2, 0)/timedelta64[h]/(2,): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),{{},{}},"empty-source/(2, 0)/timedelta64[h]/(2,): backing source")
eq(base.shape,{2,0},"empty-source/(2, 0)/timedelta64[h]/(2,): backing source: shape")
eq(base.strides,{0,0},"empty-source/(2, 0)/timedelta64[h]/(2,): backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-source/(2, 0)/timedelta64[h]/(2,): backing source: dtype")
eq(a.shape,{2,0},"empty-source/(2, 0)/timedelta64[h]/(2,): source shape")
eq(a.strides,{0,0},"empty-source/(2, 0)/timedelta64[h]/(2,): source strides")
cases=cases+1
end
-- 610: empty-source/(2, 0)/timedelta64[h]/(1, 2); source error=IndexError
do
local base=np.zeros({2,0},"timedelta64[h]")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==false,"empty-source/(2, 0)/timedelta64[h]/(1, 2): acceptance"..": "..tostring(result))
eq(np.astype(base,'int64'):tolist(),{{},{}},"empty-source/(2, 0)/timedelta64[h]/(1, 2): backing source")
eq(base.shape,{2,0},"empty-source/(2, 0)/timedelta64[h]/(1, 2): backing source: shape")
eq(base.strides,{0,0},"empty-source/(2, 0)/timedelta64[h]/(1, 2): backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-source/(2, 0)/timedelta64[h]/(1, 2): backing source: dtype")
eq(a.shape,{2,0},"empty-source/(2, 0)/timedelta64[h]/(1, 2): source shape")
eq(a.strides,{0,0},"empty-source/(2, 0)/timedelta64[h]/(1, 2): source strides")
cases=cases+1
end
-- 611: empty-source/(2, 3)/int32/(); source error=None
do
local base=np.array({{0,0,0},{0,0,0}},"int32")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 3)/int32/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{0},"empty-source/(2, 3)/int32/(): result")
eq(result.shape,{1},"empty-source/(2, 3)/int32/(): result: shape")
eq(result.strides,{4},"empty-source/(2, 3)/int32/(): result: strides")
eq(result.dtype,"int32","empty-source/(2, 3)/int32/(): result: dtype")
eq(base:tolist(),{{0,0,0},{0,0,0}},"empty-source/(2, 3)/int32/(): backing source")
eq(base.shape,{2,3},"empty-source/(2, 3)/int32/(): backing source: shape")
eq(base.strides,{12,4},"empty-source/(2, 3)/int32/(): backing source: strides")
eq(base.dtype,"int32","empty-source/(2, 3)/int32/(): backing source: dtype")
eq(a.shape,{2,3},"empty-source/(2, 3)/int32/(): source shape")
eq(a.strides,{12,4},"empty-source/(2, 3)/int32/(): source strides")
cases=cases+1
end
-- 612: empty-source/(2, 3)/int32/(0,); source error=None
do
local base=np.array({{0,0,0},{0,0,0}},"int32")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 3)/int32/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-source/(2, 3)/int32/(0,): result")
eq(result.shape,{0},"empty-source/(2, 3)/int32/(0,): result: shape")
eq(result.strides,{0},"empty-source/(2, 3)/int32/(0,): result: strides")
eq(result.dtype,"int32","empty-source/(2, 3)/int32/(0,): result: dtype")
eq(base:tolist(),{{0,0,0},{0,0,0}},"empty-source/(2, 3)/int32/(0,): backing source")
eq(base.shape,{2,3},"empty-source/(2, 3)/int32/(0,): backing source: shape")
eq(base.strides,{12,4},"empty-source/(2, 3)/int32/(0,): backing source: strides")
eq(base.dtype,"int32","empty-source/(2, 3)/int32/(0,): backing source: dtype")
eq(a.shape,{2,3},"empty-source/(2, 3)/int32/(0,): source shape")
eq(a.strides,{12,4},"empty-source/(2, 3)/int32/(0,): source strides")
cases=cases+1
end
-- 613: empty-source/(2, 3)/int32/(1,); source error=None
do
local base=np.array({{0,0,0},{0,0,0}},"int32")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 3)/int32/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0},"empty-source/(2, 3)/int32/(1,): result")
eq(result.shape,{1},"empty-source/(2, 3)/int32/(1,): result: shape")
eq(result.strides,{4},"empty-source/(2, 3)/int32/(1,): result: strides")
eq(result.dtype,"int32","empty-source/(2, 3)/int32/(1,): result: dtype")
eq(base:tolist(),{{0,0,0},{0,0,0}},"empty-source/(2, 3)/int32/(1,): backing source")
eq(base.shape,{2,3},"empty-source/(2, 3)/int32/(1,): backing source: shape")
eq(base.strides,{12,4},"empty-source/(2, 3)/int32/(1,): backing source: strides")
eq(base.dtype,"int32","empty-source/(2, 3)/int32/(1,): backing source: dtype")
eq(a.shape,{2,3},"empty-source/(2, 3)/int32/(1,): source shape")
eq(a.strides,{12,4},"empty-source/(2, 3)/int32/(1,): source strides")
cases=cases+1
end
-- 614: empty-source/(2, 3)/int32/(2,); source error=None
do
local base=np.array({{0,0,0},{0,0,0}},"int32")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 3)/int32/(2,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0},"empty-source/(2, 3)/int32/(2,): result")
eq(result.shape,{1},"empty-source/(2, 3)/int32/(2,): result: shape")
eq(result.strides,{4},"empty-source/(2, 3)/int32/(2,): result: strides")
eq(result.dtype,"int32","empty-source/(2, 3)/int32/(2,): result: dtype")
eq(base:tolist(),{{0,0,0},{0,0,0}},"empty-source/(2, 3)/int32/(2,): backing source")
eq(base.shape,{2,3},"empty-source/(2, 3)/int32/(2,): backing source: shape")
eq(base.strides,{12,4},"empty-source/(2, 3)/int32/(2,): backing source: strides")
eq(base.dtype,"int32","empty-source/(2, 3)/int32/(2,): backing source: dtype")
eq(a.shape,{2,3},"empty-source/(2, 3)/int32/(2,): source shape")
eq(a.strides,{12,4},"empty-source/(2, 3)/int32/(2,): source strides")
cases=cases+1
end
-- 615: empty-source/(2, 3)/int32/(1, 2); source error=None
do
local base=np.array({{0,0,0},{0,0,0}},"int32")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 3)/int32/(1, 2): acceptance"..": "..tostring(result))
eq(result:tolist(),{0,0},"empty-source/(2, 3)/int32/(1, 2): result")
eq(result.shape,{2},"empty-source/(2, 3)/int32/(1, 2): result: shape")
eq(result.strides,{4},"empty-source/(2, 3)/int32/(1, 2): result: strides")
eq(result.dtype,"int32","empty-source/(2, 3)/int32/(1, 2): result: dtype")
eq(base:tolist(),{{0,0,0},{0,0,0}},"empty-source/(2, 3)/int32/(1, 2): backing source")
eq(base.shape,{2,3},"empty-source/(2, 3)/int32/(1, 2): backing source: shape")
eq(base.strides,{12,4},"empty-source/(2, 3)/int32/(1, 2): backing source: strides")
eq(base.dtype,"int32","empty-source/(2, 3)/int32/(1, 2): backing source: dtype")
eq(a.shape,{2,3},"empty-source/(2, 3)/int32/(1, 2): source shape")
eq(a.strides,{12,4},"empty-source/(2, 3)/int32/(1, 2): source strides")
cases=cases+1
end
-- 616: empty-source/(2, 3)/float32/(); source error=None
do
local base=np.array({{0.0,0.0,0.0},{0.0,0.0,0.0}},"float32")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 3)/float32/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"empty-source/(2, 3)/float32/(): result")
eq(result.shape,{1},"empty-source/(2, 3)/float32/(): result: shape")
eq(result.strides,{4},"empty-source/(2, 3)/float32/(): result: strides")
eq(result.dtype,"float32","empty-source/(2, 3)/float32/(): result: dtype")
eq(base:tolist(),{{0.0,0.0,0.0},{0.0,0.0,0.0}},"empty-source/(2, 3)/float32/(): backing source")
eq(base.shape,{2,3},"empty-source/(2, 3)/float32/(): backing source: shape")
eq(base.strides,{12,4},"empty-source/(2, 3)/float32/(): backing source: strides")
eq(base.dtype,"float32","empty-source/(2, 3)/float32/(): backing source: dtype")
eq(a.shape,{2,3},"empty-source/(2, 3)/float32/(): source shape")
eq(a.strides,{12,4},"empty-source/(2, 3)/float32/(): source strides")
cases=cases+1
end
-- 617: empty-source/(2, 3)/float32/(0,); source error=None
do
local base=np.array({{0.0,0.0,0.0},{0.0,0.0,0.0}},"float32")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 3)/float32/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-source/(2, 3)/float32/(0,): result")
eq(result.shape,{0},"empty-source/(2, 3)/float32/(0,): result: shape")
eq(result.strides,{0},"empty-source/(2, 3)/float32/(0,): result: strides")
eq(result.dtype,"float32","empty-source/(2, 3)/float32/(0,): result: dtype")
eq(base:tolist(),{{0.0,0.0,0.0},{0.0,0.0,0.0}},"empty-source/(2, 3)/float32/(0,): backing source")
eq(base.shape,{2,3},"empty-source/(2, 3)/float32/(0,): backing source: shape")
eq(base.strides,{12,4},"empty-source/(2, 3)/float32/(0,): backing source: strides")
eq(base.dtype,"float32","empty-source/(2, 3)/float32/(0,): backing source: dtype")
eq(a.shape,{2,3},"empty-source/(2, 3)/float32/(0,): source shape")
eq(a.strides,{12,4},"empty-source/(2, 3)/float32/(0,): source strides")
cases=cases+1
end
-- 618: empty-source/(2, 3)/float32/(1,); source error=None
do
local base=np.array({{0.0,0.0,0.0},{0.0,0.0,0.0}},"float32")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 3)/float32/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"empty-source/(2, 3)/float32/(1,): result")
eq(result.shape,{1},"empty-source/(2, 3)/float32/(1,): result: shape")
eq(result.strides,{4},"empty-source/(2, 3)/float32/(1,): result: strides")
eq(result.dtype,"float32","empty-source/(2, 3)/float32/(1,): result: dtype")
eq(base:tolist(),{{0.0,0.0,0.0},{0.0,0.0,0.0}},"empty-source/(2, 3)/float32/(1,): backing source")
eq(base.shape,{2,3},"empty-source/(2, 3)/float32/(1,): backing source: shape")
eq(base.strides,{12,4},"empty-source/(2, 3)/float32/(1,): backing source: strides")
eq(base.dtype,"float32","empty-source/(2, 3)/float32/(1,): backing source: dtype")
eq(a.shape,{2,3},"empty-source/(2, 3)/float32/(1,): source shape")
eq(a.strides,{12,4},"empty-source/(2, 3)/float32/(1,): source strides")
cases=cases+1
end
-- 619: empty-source/(2, 3)/float32/(2,); source error=None
do
local base=np.array({{0.0,0.0,0.0},{0.0,0.0,0.0}},"float32")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 3)/float32/(2,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"empty-source/(2, 3)/float32/(2,): result")
eq(result.shape,{1},"empty-source/(2, 3)/float32/(2,): result: shape")
eq(result.strides,{4},"empty-source/(2, 3)/float32/(2,): result: strides")
eq(result.dtype,"float32","empty-source/(2, 3)/float32/(2,): result: dtype")
eq(base:tolist(),{{0.0,0.0,0.0},{0.0,0.0,0.0}},"empty-source/(2, 3)/float32/(2,): backing source")
eq(base.shape,{2,3},"empty-source/(2, 3)/float32/(2,): backing source: shape")
eq(base.strides,{12,4},"empty-source/(2, 3)/float32/(2,): backing source: strides")
eq(base.dtype,"float32","empty-source/(2, 3)/float32/(2,): backing source: dtype")
eq(a.shape,{2,3},"empty-source/(2, 3)/float32/(2,): source shape")
eq(a.strides,{12,4},"empty-source/(2, 3)/float32/(2,): source strides")
cases=cases+1
end
-- 620: empty-source/(2, 3)/float32/(1, 2); source error=None
do
local base=np.array({{0.0,0.0,0.0},{0.0,0.0,0.0}},"float32")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 3)/float32/(1, 2): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.0},"empty-source/(2, 3)/float32/(1, 2): result")
eq(result.shape,{2},"empty-source/(2, 3)/float32/(1, 2): result: shape")
eq(result.strides,{4},"empty-source/(2, 3)/float32/(1, 2): result: strides")
eq(result.dtype,"float32","empty-source/(2, 3)/float32/(1, 2): result: dtype")
eq(base:tolist(),{{0.0,0.0,0.0},{0.0,0.0,0.0}},"empty-source/(2, 3)/float32/(1, 2): backing source")
eq(base.shape,{2,3},"empty-source/(2, 3)/float32/(1, 2): backing source: shape")
eq(base.strides,{12,4},"empty-source/(2, 3)/float32/(1, 2): backing source: strides")
eq(base.dtype,"float32","empty-source/(2, 3)/float32/(1, 2): backing source: dtype")
eq(a.shape,{2,3},"empty-source/(2, 3)/float32/(1, 2): source shape")
eq(a.strides,{12,4},"empty-source/(2, 3)/float32/(1, 2): source strides")
cases=cases+1
end
-- 621: empty-source/(2, 3)/complex128/(); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}},"complex128")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 3)/complex128/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0)},"empty-source/(2, 3)/complex128/(): result")
eq(result.shape,{1},"empty-source/(2, 3)/complex128/(): result: shape")
eq(result.strides,{16},"empty-source/(2, 3)/complex128/(): result: strides")
eq(result.dtype,"complex128","empty-source/(2, 3)/complex128/(): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}},"empty-source/(2, 3)/complex128/(): backing source")
eq(base.shape,{2,3},"empty-source/(2, 3)/complex128/(): backing source: shape")
eq(base.strides,{48,16},"empty-source/(2, 3)/complex128/(): backing source: strides")
eq(base.dtype,"complex128","empty-source/(2, 3)/complex128/(): backing source: dtype")
eq(a.shape,{2,3},"empty-source/(2, 3)/complex128/(): source shape")
eq(a.strides,{48,16},"empty-source/(2, 3)/complex128/(): source strides")
cases=cases+1
end
-- 622: empty-source/(2, 3)/complex128/(0,); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}},"complex128")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 3)/complex128/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-source/(2, 3)/complex128/(0,): result")
eq(result.shape,{0},"empty-source/(2, 3)/complex128/(0,): result: shape")
eq(result.strides,{0},"empty-source/(2, 3)/complex128/(0,): result: strides")
eq(result.dtype,"complex128","empty-source/(2, 3)/complex128/(0,): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}},"empty-source/(2, 3)/complex128/(0,): backing source")
eq(base.shape,{2,3},"empty-source/(2, 3)/complex128/(0,): backing source: shape")
eq(base.strides,{48,16},"empty-source/(2, 3)/complex128/(0,): backing source: strides")
eq(base.dtype,"complex128","empty-source/(2, 3)/complex128/(0,): backing source: dtype")
eq(a.shape,{2,3},"empty-source/(2, 3)/complex128/(0,): source shape")
eq(a.strides,{48,16},"empty-source/(2, 3)/complex128/(0,): source strides")
cases=cases+1
end
-- 623: empty-source/(2, 3)/complex128/(1,); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}},"complex128")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 3)/complex128/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0)},"empty-source/(2, 3)/complex128/(1,): result")
eq(result.shape,{1},"empty-source/(2, 3)/complex128/(1,): result: shape")
eq(result.strides,{16},"empty-source/(2, 3)/complex128/(1,): result: strides")
eq(result.dtype,"complex128","empty-source/(2, 3)/complex128/(1,): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}},"empty-source/(2, 3)/complex128/(1,): backing source")
eq(base.shape,{2,3},"empty-source/(2, 3)/complex128/(1,): backing source: shape")
eq(base.strides,{48,16},"empty-source/(2, 3)/complex128/(1,): backing source: strides")
eq(base.dtype,"complex128","empty-source/(2, 3)/complex128/(1,): backing source: dtype")
eq(a.shape,{2,3},"empty-source/(2, 3)/complex128/(1,): source shape")
eq(a.strides,{48,16},"empty-source/(2, 3)/complex128/(1,): source strides")
cases=cases+1
end
-- 624: empty-source/(2, 3)/complex128/(2,); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}},"complex128")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 3)/complex128/(2,): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0)},"empty-source/(2, 3)/complex128/(2,): result")
eq(result.shape,{1},"empty-source/(2, 3)/complex128/(2,): result: shape")
eq(result.strides,{16},"empty-source/(2, 3)/complex128/(2,): result: strides")
eq(result.dtype,"complex128","empty-source/(2, 3)/complex128/(2,): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}},"empty-source/(2, 3)/complex128/(2,): backing source")
eq(base.shape,{2,3},"empty-source/(2, 3)/complex128/(2,): backing source: shape")
eq(base.strides,{48,16},"empty-source/(2, 3)/complex128/(2,): backing source: strides")
eq(base.dtype,"complex128","empty-source/(2, 3)/complex128/(2,): backing source: dtype")
eq(a.shape,{2,3},"empty-source/(2, 3)/complex128/(2,): source shape")
eq(a.strides,{48,16},"empty-source/(2, 3)/complex128/(2,): source strides")
cases=cases+1
end
-- 625: empty-source/(2, 3)/complex128/(1, 2); source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}},"complex128")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 3)/complex128/(1, 2): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.0,0.0)},"empty-source/(2, 3)/complex128/(1, 2): result")
eq(result.shape,{2},"empty-source/(2, 3)/complex128/(1, 2): result: shape")
eq(result.strides,{16},"empty-source/(2, 3)/complex128/(1, 2): result: strides")
eq(result.dtype,"complex128","empty-source/(2, 3)/complex128/(1, 2): result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}},"empty-source/(2, 3)/complex128/(1, 2): backing source")
eq(base.shape,{2,3},"empty-source/(2, 3)/complex128/(1, 2): backing source: shape")
eq(base.strides,{48,16},"empty-source/(2, 3)/complex128/(1, 2): backing source: strides")
eq(base.dtype,"complex128","empty-source/(2, 3)/complex128/(1, 2): backing source: dtype")
eq(a.shape,{2,3},"empty-source/(2, 3)/complex128/(1, 2): source shape")
eq(a.strides,{48,16},"empty-source/(2, 3)/complex128/(1, 2): source strides")
cases=cases+1
end
-- 626: empty-source/(2, 3)/U4/(); source error=None
do
local base=np.array({{"","",""},{"","",""}},"<U4")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 3)/U4/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{""},"empty-source/(2, 3)/U4/(): result")
eq(result.shape,{1},"empty-source/(2, 3)/U4/(): result: shape")
eq(result.strides,{16},"empty-source/(2, 3)/U4/(): result: strides")
eq(result.dtype,"<U4","empty-source/(2, 3)/U4/(): result: dtype")
eq(base:tolist(),{{"","",""},{"","",""}},"empty-source/(2, 3)/U4/(): backing source")
eq(base.shape,{2,3},"empty-source/(2, 3)/U4/(): backing source: shape")
eq(base.strides,{48,16},"empty-source/(2, 3)/U4/(): backing source: strides")
eq(base.dtype,"<U4","empty-source/(2, 3)/U4/(): backing source: dtype")
eq(a.shape,{2,3},"empty-source/(2, 3)/U4/(): source shape")
eq(a.strides,{48,16},"empty-source/(2, 3)/U4/(): source strides")
cases=cases+1
end
-- 627: empty-source/(2, 3)/U4/(0,); source error=None
do
local base=np.array({{"","",""},{"","",""}},"<U4")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 3)/U4/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-source/(2, 3)/U4/(0,): result")
eq(result.shape,{0},"empty-source/(2, 3)/U4/(0,): result: shape")
eq(result.strides,{0},"empty-source/(2, 3)/U4/(0,): result: strides")
eq(result.dtype,"<U4","empty-source/(2, 3)/U4/(0,): result: dtype")
eq(base:tolist(),{{"","",""},{"","",""}},"empty-source/(2, 3)/U4/(0,): backing source")
eq(base.shape,{2,3},"empty-source/(2, 3)/U4/(0,): backing source: shape")
eq(base.strides,{48,16},"empty-source/(2, 3)/U4/(0,): backing source: strides")
eq(base.dtype,"<U4","empty-source/(2, 3)/U4/(0,): backing source: dtype")
eq(a.shape,{2,3},"empty-source/(2, 3)/U4/(0,): source shape")
eq(a.strides,{48,16},"empty-source/(2, 3)/U4/(0,): source strides")
cases=cases+1
end
-- 628: empty-source/(2, 3)/U4/(1,); source error=None
do
local base=np.array({{"","",""},{"","",""}},"<U4")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 3)/U4/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{""},"empty-source/(2, 3)/U4/(1,): result")
eq(result.shape,{1},"empty-source/(2, 3)/U4/(1,): result: shape")
eq(result.strides,{16},"empty-source/(2, 3)/U4/(1,): result: strides")
eq(result.dtype,"<U4","empty-source/(2, 3)/U4/(1,): result: dtype")
eq(base:tolist(),{{"","",""},{"","",""}},"empty-source/(2, 3)/U4/(1,): backing source")
eq(base.shape,{2,3},"empty-source/(2, 3)/U4/(1,): backing source: shape")
eq(base.strides,{48,16},"empty-source/(2, 3)/U4/(1,): backing source: strides")
eq(base.dtype,"<U4","empty-source/(2, 3)/U4/(1,): backing source: dtype")
eq(a.shape,{2,3},"empty-source/(2, 3)/U4/(1,): source shape")
eq(a.strides,{48,16},"empty-source/(2, 3)/U4/(1,): source strides")
cases=cases+1
end
-- 629: empty-source/(2, 3)/U4/(2,); source error=None
do
local base=np.array({{"","",""},{"","",""}},"<U4")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 3)/U4/(2,): acceptance"..": "..tostring(result))
eq(result:tolist(),{""},"empty-source/(2, 3)/U4/(2,): result")
eq(result.shape,{1},"empty-source/(2, 3)/U4/(2,): result: shape")
eq(result.strides,{16},"empty-source/(2, 3)/U4/(2,): result: strides")
eq(result.dtype,"<U4","empty-source/(2, 3)/U4/(2,): result: dtype")
eq(base:tolist(),{{"","",""},{"","",""}},"empty-source/(2, 3)/U4/(2,): backing source")
eq(base.shape,{2,3},"empty-source/(2, 3)/U4/(2,): backing source: shape")
eq(base.strides,{48,16},"empty-source/(2, 3)/U4/(2,): backing source: strides")
eq(base.dtype,"<U4","empty-source/(2, 3)/U4/(2,): backing source: dtype")
eq(a.shape,{2,3},"empty-source/(2, 3)/U4/(2,): source shape")
eq(a.strides,{48,16},"empty-source/(2, 3)/U4/(2,): source strides")
cases=cases+1
end
-- 630: empty-source/(2, 3)/U4/(1, 2); source error=None
do
local base=np.array({{"","",""},{"","",""}},"<U4")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 3)/U4/(1, 2): acceptance"..": "..tostring(result))
eq(result:tolist(),{"",""},"empty-source/(2, 3)/U4/(1, 2): result")
eq(result.shape,{2},"empty-source/(2, 3)/U4/(1, 2): result: shape")
eq(result.strides,{16},"empty-source/(2, 3)/U4/(1, 2): result: strides")
eq(result.dtype,"<U4","empty-source/(2, 3)/U4/(1, 2): result: dtype")
eq(base:tolist(),{{"","",""},{"","",""}},"empty-source/(2, 3)/U4/(1, 2): backing source")
eq(base.shape,{2,3},"empty-source/(2, 3)/U4/(1, 2): backing source: shape")
eq(base.strides,{48,16},"empty-source/(2, 3)/U4/(1, 2): backing source: strides")
eq(base.dtype,"<U4","empty-source/(2, 3)/U4/(1, 2): backing source: dtype")
eq(a.shape,{2,3},"empty-source/(2, 3)/U4/(1, 2): source shape")
eq(a.strides,{48,16},"empty-source/(2, 3)/U4/(1, 2): source strides")
cases=cases+1
end
-- 631: empty-source/(2, 3)/S4/(); source error=None
do
local base=np.array({{"","",""},{"","",""}},"|S4")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 3)/S4/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{""},"empty-source/(2, 3)/S4/(): result")
eq(result.shape,{1},"empty-source/(2, 3)/S4/(): result: shape")
eq(result.strides,{4},"empty-source/(2, 3)/S4/(): result: strides")
eq(result.dtype,"|S4","empty-source/(2, 3)/S4/(): result: dtype")
eq(base:tolist(),{{"","",""},{"","",""}},"empty-source/(2, 3)/S4/(): backing source")
eq(base.shape,{2,3},"empty-source/(2, 3)/S4/(): backing source: shape")
eq(base.strides,{12,4},"empty-source/(2, 3)/S4/(): backing source: strides")
eq(base.dtype,"|S4","empty-source/(2, 3)/S4/(): backing source: dtype")
eq(a.shape,{2,3},"empty-source/(2, 3)/S4/(): source shape")
eq(a.strides,{12,4},"empty-source/(2, 3)/S4/(): source strides")
cases=cases+1
end
-- 632: empty-source/(2, 3)/S4/(0,); source error=None
do
local base=np.array({{"","",""},{"","",""}},"|S4")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 3)/S4/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-source/(2, 3)/S4/(0,): result")
eq(result.shape,{0},"empty-source/(2, 3)/S4/(0,): result: shape")
eq(result.strides,{0},"empty-source/(2, 3)/S4/(0,): result: strides")
eq(result.dtype,"|S4","empty-source/(2, 3)/S4/(0,): result: dtype")
eq(base:tolist(),{{"","",""},{"","",""}},"empty-source/(2, 3)/S4/(0,): backing source")
eq(base.shape,{2,3},"empty-source/(2, 3)/S4/(0,): backing source: shape")
eq(base.strides,{12,4},"empty-source/(2, 3)/S4/(0,): backing source: strides")
eq(base.dtype,"|S4","empty-source/(2, 3)/S4/(0,): backing source: dtype")
eq(a.shape,{2,3},"empty-source/(2, 3)/S4/(0,): source shape")
eq(a.strides,{12,4},"empty-source/(2, 3)/S4/(0,): source strides")
cases=cases+1
end
-- 633: empty-source/(2, 3)/S4/(1,); source error=None
do
local base=np.array({{"","",""},{"","",""}},"|S4")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 3)/S4/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{""},"empty-source/(2, 3)/S4/(1,): result")
eq(result.shape,{1},"empty-source/(2, 3)/S4/(1,): result: shape")
eq(result.strides,{4},"empty-source/(2, 3)/S4/(1,): result: strides")
eq(result.dtype,"|S4","empty-source/(2, 3)/S4/(1,): result: dtype")
eq(base:tolist(),{{"","",""},{"","",""}},"empty-source/(2, 3)/S4/(1,): backing source")
eq(base.shape,{2,3},"empty-source/(2, 3)/S4/(1,): backing source: shape")
eq(base.strides,{12,4},"empty-source/(2, 3)/S4/(1,): backing source: strides")
eq(base.dtype,"|S4","empty-source/(2, 3)/S4/(1,): backing source: dtype")
eq(a.shape,{2,3},"empty-source/(2, 3)/S4/(1,): source shape")
eq(a.strides,{12,4},"empty-source/(2, 3)/S4/(1,): source strides")
cases=cases+1
end
-- 634: empty-source/(2, 3)/S4/(2,); source error=None
do
local base=np.array({{"","",""},{"","",""}},"|S4")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 3)/S4/(2,): acceptance"..": "..tostring(result))
eq(result:tolist(),{""},"empty-source/(2, 3)/S4/(2,): result")
eq(result.shape,{1},"empty-source/(2, 3)/S4/(2,): result: shape")
eq(result.strides,{4},"empty-source/(2, 3)/S4/(2,): result: strides")
eq(result.dtype,"|S4","empty-source/(2, 3)/S4/(2,): result: dtype")
eq(base:tolist(),{{"","",""},{"","",""}},"empty-source/(2, 3)/S4/(2,): backing source")
eq(base.shape,{2,3},"empty-source/(2, 3)/S4/(2,): backing source: shape")
eq(base.strides,{12,4},"empty-source/(2, 3)/S4/(2,): backing source: strides")
eq(base.dtype,"|S4","empty-source/(2, 3)/S4/(2,): backing source: dtype")
eq(a.shape,{2,3},"empty-source/(2, 3)/S4/(2,): source shape")
eq(a.strides,{12,4},"empty-source/(2, 3)/S4/(2,): source strides")
cases=cases+1
end
-- 635: empty-source/(2, 3)/S4/(1, 2); source error=None
do
local base=np.array({{"","",""},{"","",""}},"|S4")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 3)/S4/(1, 2): acceptance"..": "..tostring(result))
eq(result:tolist(),{"",""},"empty-source/(2, 3)/S4/(1, 2): result")
eq(result.shape,{2},"empty-source/(2, 3)/S4/(1, 2): result: shape")
eq(result.strides,{4},"empty-source/(2, 3)/S4/(1, 2): result: strides")
eq(result.dtype,"|S4","empty-source/(2, 3)/S4/(1, 2): result: dtype")
eq(base:tolist(),{{"","",""},{"","",""}},"empty-source/(2, 3)/S4/(1, 2): backing source")
eq(base.shape,{2,3},"empty-source/(2, 3)/S4/(1, 2): backing source: shape")
eq(base.strides,{12,4},"empty-source/(2, 3)/S4/(1, 2): backing source: strides")
eq(base.dtype,"|S4","empty-source/(2, 3)/S4/(1, 2): backing source: dtype")
eq(a.shape,{2,3},"empty-source/(2, 3)/S4/(1, 2): source shape")
eq(a.strides,{12,4},"empty-source/(2, 3)/S4/(1, 2): source strides")
cases=cases+1
end
-- 636: empty-source/(2, 3)/datetime64[D]/(); source error=None
do
local base=np.array({{0,0,0},{0,0,0}},"datetime64[D]")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 3)/datetime64[D]/(): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0},"empty-source/(2, 3)/datetime64[D]/(): result")
eq(result.shape,{1},"empty-source/(2, 3)/datetime64[D]/(): result: shape")
eq(result.strides,{8},"empty-source/(2, 3)/datetime64[D]/(): result: strides")
eq(result.dtype,"datetime64[D]","empty-source/(2, 3)/datetime64[D]/(): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,0,0},{0,0,0}},"empty-source/(2, 3)/datetime64[D]/(): backing source")
eq(base.shape,{2,3},"empty-source/(2, 3)/datetime64[D]/(): backing source: shape")
eq(base.strides,{24,8},"empty-source/(2, 3)/datetime64[D]/(): backing source: strides")
eq(base.dtype,"datetime64[D]","empty-source/(2, 3)/datetime64[D]/(): backing source: dtype")
eq(a.shape,{2,3},"empty-source/(2, 3)/datetime64[D]/(): source shape")
eq(a.strides,{24,8},"empty-source/(2, 3)/datetime64[D]/(): source strides")
cases=cases+1
end
-- 637: empty-source/(2, 3)/datetime64[D]/(0,); source error=None
do
local base=np.array({{0,0,0},{0,0,0}},"datetime64[D]")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 3)/datetime64[D]/(0,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{},"empty-source/(2, 3)/datetime64[D]/(0,): result")
eq(result.shape,{0},"empty-source/(2, 3)/datetime64[D]/(0,): result: shape")
eq(result.strides,{0},"empty-source/(2, 3)/datetime64[D]/(0,): result: strides")
eq(result.dtype,"datetime64[D]","empty-source/(2, 3)/datetime64[D]/(0,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,0,0},{0,0,0}},"empty-source/(2, 3)/datetime64[D]/(0,): backing source")
eq(base.shape,{2,3},"empty-source/(2, 3)/datetime64[D]/(0,): backing source: shape")
eq(base.strides,{24,8},"empty-source/(2, 3)/datetime64[D]/(0,): backing source: strides")
eq(base.dtype,"datetime64[D]","empty-source/(2, 3)/datetime64[D]/(0,): backing source: dtype")
eq(a.shape,{2,3},"empty-source/(2, 3)/datetime64[D]/(0,): source shape")
eq(a.strides,{24,8},"empty-source/(2, 3)/datetime64[D]/(0,): source strides")
cases=cases+1
end
-- 638: empty-source/(2, 3)/datetime64[D]/(1,); source error=None
do
local base=np.array({{0,0,0},{0,0,0}},"datetime64[D]")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 3)/datetime64[D]/(1,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0},"empty-source/(2, 3)/datetime64[D]/(1,): result")
eq(result.shape,{1},"empty-source/(2, 3)/datetime64[D]/(1,): result: shape")
eq(result.strides,{8},"empty-source/(2, 3)/datetime64[D]/(1,): result: strides")
eq(result.dtype,"datetime64[D]","empty-source/(2, 3)/datetime64[D]/(1,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,0,0},{0,0,0}},"empty-source/(2, 3)/datetime64[D]/(1,): backing source")
eq(base.shape,{2,3},"empty-source/(2, 3)/datetime64[D]/(1,): backing source: shape")
eq(base.strides,{24,8},"empty-source/(2, 3)/datetime64[D]/(1,): backing source: strides")
eq(base.dtype,"datetime64[D]","empty-source/(2, 3)/datetime64[D]/(1,): backing source: dtype")
eq(a.shape,{2,3},"empty-source/(2, 3)/datetime64[D]/(1,): source shape")
eq(a.strides,{24,8},"empty-source/(2, 3)/datetime64[D]/(1,): source strides")
cases=cases+1
end
-- 639: empty-source/(2, 3)/datetime64[D]/(2,); source error=None
do
local base=np.array({{0,0,0},{0,0,0}},"datetime64[D]")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 3)/datetime64[D]/(2,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0},"empty-source/(2, 3)/datetime64[D]/(2,): result")
eq(result.shape,{1},"empty-source/(2, 3)/datetime64[D]/(2,): result: shape")
eq(result.strides,{8},"empty-source/(2, 3)/datetime64[D]/(2,): result: strides")
eq(result.dtype,"datetime64[D]","empty-source/(2, 3)/datetime64[D]/(2,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,0,0},{0,0,0}},"empty-source/(2, 3)/datetime64[D]/(2,): backing source")
eq(base.shape,{2,3},"empty-source/(2, 3)/datetime64[D]/(2,): backing source: shape")
eq(base.strides,{24,8},"empty-source/(2, 3)/datetime64[D]/(2,): backing source: strides")
eq(base.dtype,"datetime64[D]","empty-source/(2, 3)/datetime64[D]/(2,): backing source: dtype")
eq(a.shape,{2,3},"empty-source/(2, 3)/datetime64[D]/(2,): source shape")
eq(a.strides,{24,8},"empty-source/(2, 3)/datetime64[D]/(2,): source strides")
cases=cases+1
end
-- 640: empty-source/(2, 3)/datetime64[D]/(1, 2); source error=None
do
local base=np.array({{0,0,0},{0,0,0}},"datetime64[D]")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 3)/datetime64[D]/(1, 2): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0,0},"empty-source/(2, 3)/datetime64[D]/(1, 2): result")
eq(result.shape,{2},"empty-source/(2, 3)/datetime64[D]/(1, 2): result: shape")
eq(result.strides,{8},"empty-source/(2, 3)/datetime64[D]/(1, 2): result: strides")
eq(result.dtype,"datetime64[D]","empty-source/(2, 3)/datetime64[D]/(1, 2): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,0,0},{0,0,0}},"empty-source/(2, 3)/datetime64[D]/(1, 2): backing source")
eq(base.shape,{2,3},"empty-source/(2, 3)/datetime64[D]/(1, 2): backing source: shape")
eq(base.strides,{24,8},"empty-source/(2, 3)/datetime64[D]/(1, 2): backing source: strides")
eq(base.dtype,"datetime64[D]","empty-source/(2, 3)/datetime64[D]/(1, 2): backing source: dtype")
eq(a.shape,{2,3},"empty-source/(2, 3)/datetime64[D]/(1, 2): source shape")
eq(a.strides,{24,8},"empty-source/(2, 3)/datetime64[D]/(1, 2): source strides")
cases=cases+1
end
-- 641: empty-source/(2, 3)/timedelta64[h]/(); source error=None
do
local base=np.array({{0,0,0},{0,0,0}},"timedelta64[h]")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 3)/timedelta64[h]/(): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0},"empty-source/(2, 3)/timedelta64[h]/(): result")
eq(result.shape,{1},"empty-source/(2, 3)/timedelta64[h]/(): result: shape")
eq(result.strides,{8},"empty-source/(2, 3)/timedelta64[h]/(): result: strides")
eq(result.dtype,"timedelta64[h]","empty-source/(2, 3)/timedelta64[h]/(): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,0,0},{0,0,0}},"empty-source/(2, 3)/timedelta64[h]/(): backing source")
eq(base.shape,{2,3},"empty-source/(2, 3)/timedelta64[h]/(): backing source: shape")
eq(base.strides,{24,8},"empty-source/(2, 3)/timedelta64[h]/(): backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-source/(2, 3)/timedelta64[h]/(): backing source: dtype")
eq(a.shape,{2,3},"empty-source/(2, 3)/timedelta64[h]/(): source shape")
eq(a.strides,{24,8},"empty-source/(2, 3)/timedelta64[h]/(): source strides")
cases=cases+1
end
-- 642: empty-source/(2, 3)/timedelta64[h]/(0,); source error=None
do
local base=np.array({{0,0,0},{0,0,0}},"timedelta64[h]")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 3)/timedelta64[h]/(0,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{},"empty-source/(2, 3)/timedelta64[h]/(0,): result")
eq(result.shape,{0},"empty-source/(2, 3)/timedelta64[h]/(0,): result: shape")
eq(result.strides,{0},"empty-source/(2, 3)/timedelta64[h]/(0,): result: strides")
eq(result.dtype,"timedelta64[h]","empty-source/(2, 3)/timedelta64[h]/(0,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,0,0},{0,0,0}},"empty-source/(2, 3)/timedelta64[h]/(0,): backing source")
eq(base.shape,{2,3},"empty-source/(2, 3)/timedelta64[h]/(0,): backing source: shape")
eq(base.strides,{24,8},"empty-source/(2, 3)/timedelta64[h]/(0,): backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-source/(2, 3)/timedelta64[h]/(0,): backing source: dtype")
eq(a.shape,{2,3},"empty-source/(2, 3)/timedelta64[h]/(0,): source shape")
eq(a.strides,{24,8},"empty-source/(2, 3)/timedelta64[h]/(0,): source strides")
cases=cases+1
end
-- 643: empty-source/(2, 3)/timedelta64[h]/(1,); source error=None
do
local base=np.array({{0,0,0},{0,0,0}},"timedelta64[h]")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 3)/timedelta64[h]/(1,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0},"empty-source/(2, 3)/timedelta64[h]/(1,): result")
eq(result.shape,{1},"empty-source/(2, 3)/timedelta64[h]/(1,): result: shape")
eq(result.strides,{8},"empty-source/(2, 3)/timedelta64[h]/(1,): result: strides")
eq(result.dtype,"timedelta64[h]","empty-source/(2, 3)/timedelta64[h]/(1,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,0,0},{0,0,0}},"empty-source/(2, 3)/timedelta64[h]/(1,): backing source")
eq(base.shape,{2,3},"empty-source/(2, 3)/timedelta64[h]/(1,): backing source: shape")
eq(base.strides,{24,8},"empty-source/(2, 3)/timedelta64[h]/(1,): backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-source/(2, 3)/timedelta64[h]/(1,): backing source: dtype")
eq(a.shape,{2,3},"empty-source/(2, 3)/timedelta64[h]/(1,): source shape")
eq(a.strides,{24,8},"empty-source/(2, 3)/timedelta64[h]/(1,): source strides")
cases=cases+1
end
-- 644: empty-source/(2, 3)/timedelta64[h]/(2,); source error=None
do
local base=np.array({{0,0,0},{0,0,0}},"timedelta64[h]")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 3)/timedelta64[h]/(2,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0},"empty-source/(2, 3)/timedelta64[h]/(2,): result")
eq(result.shape,{1},"empty-source/(2, 3)/timedelta64[h]/(2,): result: shape")
eq(result.strides,{8},"empty-source/(2, 3)/timedelta64[h]/(2,): result: strides")
eq(result.dtype,"timedelta64[h]","empty-source/(2, 3)/timedelta64[h]/(2,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,0,0},{0,0,0}},"empty-source/(2, 3)/timedelta64[h]/(2,): backing source")
eq(base.shape,{2,3},"empty-source/(2, 3)/timedelta64[h]/(2,): backing source: shape")
eq(base.strides,{24,8},"empty-source/(2, 3)/timedelta64[h]/(2,): backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-source/(2, 3)/timedelta64[h]/(2,): backing source: dtype")
eq(a.shape,{2,3},"empty-source/(2, 3)/timedelta64[h]/(2,): source shape")
eq(a.strides,{24,8},"empty-source/(2, 3)/timedelta64[h]/(2,): source strides")
cases=cases+1
end
-- 645: empty-source/(2, 3)/timedelta64[h]/(1, 2); source error=None
do
local base=np.array({{0,0,0},{0,0,0}},"timedelta64[h]")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 3)/timedelta64[h]/(1, 2): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0,0},"empty-source/(2, 3)/timedelta64[h]/(1, 2): result")
eq(result.shape,{2},"empty-source/(2, 3)/timedelta64[h]/(1, 2): result: shape")
eq(result.strides,{8},"empty-source/(2, 3)/timedelta64[h]/(1, 2): result: strides")
eq(result.dtype,"timedelta64[h]","empty-source/(2, 3)/timedelta64[h]/(1, 2): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,0,0},{0,0,0}},"empty-source/(2, 3)/timedelta64[h]/(1, 2): backing source")
eq(base.shape,{2,3},"empty-source/(2, 3)/timedelta64[h]/(1, 2): backing source: shape")
eq(base.strides,{24,8},"empty-source/(2, 3)/timedelta64[h]/(1, 2): backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-source/(2, 3)/timedelta64[h]/(1, 2): backing source: dtype")
eq(a.shape,{2,3},"empty-source/(2, 3)/timedelta64[h]/(1, 2): source shape")
eq(a.strides,{24,8},"empty-source/(2, 3)/timedelta64[h]/(1, 2): source strides")
cases=cases+1
end
-- 646: empty-source/(2, 1, 3)/int32/(); source error=None
do
local base=np.array({{{0,0,0}},{{0,0,0}}},"int32")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 1, 3)/int32/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{0},"empty-source/(2, 1, 3)/int32/(): result")
eq(result.shape,{1},"empty-source/(2, 1, 3)/int32/(): result: shape")
eq(result.strides,{4},"empty-source/(2, 1, 3)/int32/(): result: strides")
eq(result.dtype,"int32","empty-source/(2, 1, 3)/int32/(): result: dtype")
eq(base:tolist(),{{{0,0,0}},{{0,0,0}}},"empty-source/(2, 1, 3)/int32/(): backing source")
eq(base.shape,{2,1,3},"empty-source/(2, 1, 3)/int32/(): backing source: shape")
eq(base.strides,{12,12,4},"empty-source/(2, 1, 3)/int32/(): backing source: strides")
eq(base.dtype,"int32","empty-source/(2, 1, 3)/int32/(): backing source: dtype")
eq(a.shape,{2,1,3},"empty-source/(2, 1, 3)/int32/(): source shape")
eq(a.strides,{12,12,4},"empty-source/(2, 1, 3)/int32/(): source strides")
cases=cases+1
end
-- 647: empty-source/(2, 1, 3)/int32/(0,); source error=None
do
local base=np.array({{{0,0,0}},{{0,0,0}}},"int32")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 1, 3)/int32/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-source/(2, 1, 3)/int32/(0,): result")
eq(result.shape,{0},"empty-source/(2, 1, 3)/int32/(0,): result: shape")
eq(result.strides,{0},"empty-source/(2, 1, 3)/int32/(0,): result: strides")
eq(result.dtype,"int32","empty-source/(2, 1, 3)/int32/(0,): result: dtype")
eq(base:tolist(),{{{0,0,0}},{{0,0,0}}},"empty-source/(2, 1, 3)/int32/(0,): backing source")
eq(base.shape,{2,1,3},"empty-source/(2, 1, 3)/int32/(0,): backing source: shape")
eq(base.strides,{12,12,4},"empty-source/(2, 1, 3)/int32/(0,): backing source: strides")
eq(base.dtype,"int32","empty-source/(2, 1, 3)/int32/(0,): backing source: dtype")
eq(a.shape,{2,1,3},"empty-source/(2, 1, 3)/int32/(0,): source shape")
eq(a.strides,{12,12,4},"empty-source/(2, 1, 3)/int32/(0,): source strides")
cases=cases+1
end
-- 648: empty-source/(2, 1, 3)/int32/(1,); source error=None
do
local base=np.array({{{0,0,0}},{{0,0,0}}},"int32")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 1, 3)/int32/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0},"empty-source/(2, 1, 3)/int32/(1,): result")
eq(result.shape,{1},"empty-source/(2, 1, 3)/int32/(1,): result: shape")
eq(result.strides,{4},"empty-source/(2, 1, 3)/int32/(1,): result: strides")
eq(result.dtype,"int32","empty-source/(2, 1, 3)/int32/(1,): result: dtype")
eq(base:tolist(),{{{0,0,0}},{{0,0,0}}},"empty-source/(2, 1, 3)/int32/(1,): backing source")
eq(base.shape,{2,1,3},"empty-source/(2, 1, 3)/int32/(1,): backing source: shape")
eq(base.strides,{12,12,4},"empty-source/(2, 1, 3)/int32/(1,): backing source: strides")
eq(base.dtype,"int32","empty-source/(2, 1, 3)/int32/(1,): backing source: dtype")
eq(a.shape,{2,1,3},"empty-source/(2, 1, 3)/int32/(1,): source shape")
eq(a.strides,{12,12,4},"empty-source/(2, 1, 3)/int32/(1,): source strides")
cases=cases+1
end
-- 649: empty-source/(2, 1, 3)/int32/(2,); source error=None
do
local base=np.array({{{0,0,0}},{{0,0,0}}},"int32")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 1, 3)/int32/(2,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0},"empty-source/(2, 1, 3)/int32/(2,): result")
eq(result.shape,{1},"empty-source/(2, 1, 3)/int32/(2,): result: shape")
eq(result.strides,{4},"empty-source/(2, 1, 3)/int32/(2,): result: strides")
eq(result.dtype,"int32","empty-source/(2, 1, 3)/int32/(2,): result: dtype")
eq(base:tolist(),{{{0,0,0}},{{0,0,0}}},"empty-source/(2, 1, 3)/int32/(2,): backing source")
eq(base.shape,{2,1,3},"empty-source/(2, 1, 3)/int32/(2,): backing source: shape")
eq(base.strides,{12,12,4},"empty-source/(2, 1, 3)/int32/(2,): backing source: strides")
eq(base.dtype,"int32","empty-source/(2, 1, 3)/int32/(2,): backing source: dtype")
eq(a.shape,{2,1,3},"empty-source/(2, 1, 3)/int32/(2,): source shape")
eq(a.strides,{12,12,4},"empty-source/(2, 1, 3)/int32/(2,): source strides")
cases=cases+1
end
-- 650: empty-source/(2, 1, 3)/int32/(1, 2); source error=None
do
local base=np.array({{{0,0,0}},{{0,0,0}}},"int32")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 1, 3)/int32/(1, 2): acceptance"..": "..tostring(result))
eq(result:tolist(),{0,0},"empty-source/(2, 1, 3)/int32/(1, 2): result")
eq(result.shape,{2},"empty-source/(2, 1, 3)/int32/(1, 2): result: shape")
eq(result.strides,{4},"empty-source/(2, 1, 3)/int32/(1, 2): result: strides")
eq(result.dtype,"int32","empty-source/(2, 1, 3)/int32/(1, 2): result: dtype")
eq(base:tolist(),{{{0,0,0}},{{0,0,0}}},"empty-source/(2, 1, 3)/int32/(1, 2): backing source")
eq(base.shape,{2,1,3},"empty-source/(2, 1, 3)/int32/(1, 2): backing source: shape")
eq(base.strides,{12,12,4},"empty-source/(2, 1, 3)/int32/(1, 2): backing source: strides")
eq(base.dtype,"int32","empty-source/(2, 1, 3)/int32/(1, 2): backing source: dtype")
eq(a.shape,{2,1,3},"empty-source/(2, 1, 3)/int32/(1, 2): source shape")
eq(a.strides,{12,12,4},"empty-source/(2, 1, 3)/int32/(1, 2): source strides")
cases=cases+1
end
-- 651: empty-source/(2, 1, 3)/float32/(); source error=None
do
local base=np.array({{{0.0,0.0,0.0}},{{0.0,0.0,0.0}}},"float32")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 1, 3)/float32/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"empty-source/(2, 1, 3)/float32/(): result")
eq(result.shape,{1},"empty-source/(2, 1, 3)/float32/(): result: shape")
eq(result.strides,{4},"empty-source/(2, 1, 3)/float32/(): result: strides")
eq(result.dtype,"float32","empty-source/(2, 1, 3)/float32/(): result: dtype")
eq(base:tolist(),{{{0.0,0.0,0.0}},{{0.0,0.0,0.0}}},"empty-source/(2, 1, 3)/float32/(): backing source")
eq(base.shape,{2,1,3},"empty-source/(2, 1, 3)/float32/(): backing source: shape")
eq(base.strides,{12,12,4},"empty-source/(2, 1, 3)/float32/(): backing source: strides")
eq(base.dtype,"float32","empty-source/(2, 1, 3)/float32/(): backing source: dtype")
eq(a.shape,{2,1,3},"empty-source/(2, 1, 3)/float32/(): source shape")
eq(a.strides,{12,12,4},"empty-source/(2, 1, 3)/float32/(): source strides")
cases=cases+1
end
-- 652: empty-source/(2, 1, 3)/float32/(0,); source error=None
do
local base=np.array({{{0.0,0.0,0.0}},{{0.0,0.0,0.0}}},"float32")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 1, 3)/float32/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-source/(2, 1, 3)/float32/(0,): result")
eq(result.shape,{0},"empty-source/(2, 1, 3)/float32/(0,): result: shape")
eq(result.strides,{0},"empty-source/(2, 1, 3)/float32/(0,): result: strides")
eq(result.dtype,"float32","empty-source/(2, 1, 3)/float32/(0,): result: dtype")
eq(base:tolist(),{{{0.0,0.0,0.0}},{{0.0,0.0,0.0}}},"empty-source/(2, 1, 3)/float32/(0,): backing source")
eq(base.shape,{2,1,3},"empty-source/(2, 1, 3)/float32/(0,): backing source: shape")
eq(base.strides,{12,12,4},"empty-source/(2, 1, 3)/float32/(0,): backing source: strides")
eq(base.dtype,"float32","empty-source/(2, 1, 3)/float32/(0,): backing source: dtype")
eq(a.shape,{2,1,3},"empty-source/(2, 1, 3)/float32/(0,): source shape")
eq(a.strides,{12,12,4},"empty-source/(2, 1, 3)/float32/(0,): source strides")
cases=cases+1
end
-- 653: empty-source/(2, 1, 3)/float32/(1,); source error=None
do
local base=np.array({{{0.0,0.0,0.0}},{{0.0,0.0,0.0}}},"float32")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 1, 3)/float32/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"empty-source/(2, 1, 3)/float32/(1,): result")
eq(result.shape,{1},"empty-source/(2, 1, 3)/float32/(1,): result: shape")
eq(result.strides,{4},"empty-source/(2, 1, 3)/float32/(1,): result: strides")
eq(result.dtype,"float32","empty-source/(2, 1, 3)/float32/(1,): result: dtype")
eq(base:tolist(),{{{0.0,0.0,0.0}},{{0.0,0.0,0.0}}},"empty-source/(2, 1, 3)/float32/(1,): backing source")
eq(base.shape,{2,1,3},"empty-source/(2, 1, 3)/float32/(1,): backing source: shape")
eq(base.strides,{12,12,4},"empty-source/(2, 1, 3)/float32/(1,): backing source: strides")
eq(base.dtype,"float32","empty-source/(2, 1, 3)/float32/(1,): backing source: dtype")
eq(a.shape,{2,1,3},"empty-source/(2, 1, 3)/float32/(1,): source shape")
eq(a.strides,{12,12,4},"empty-source/(2, 1, 3)/float32/(1,): source strides")
cases=cases+1
end
-- 654: empty-source/(2, 1, 3)/float32/(2,); source error=None
do
local base=np.array({{{0.0,0.0,0.0}},{{0.0,0.0,0.0}}},"float32")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 1, 3)/float32/(2,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"empty-source/(2, 1, 3)/float32/(2,): result")
eq(result.shape,{1},"empty-source/(2, 1, 3)/float32/(2,): result: shape")
eq(result.strides,{4},"empty-source/(2, 1, 3)/float32/(2,): result: strides")
eq(result.dtype,"float32","empty-source/(2, 1, 3)/float32/(2,): result: dtype")
eq(base:tolist(),{{{0.0,0.0,0.0}},{{0.0,0.0,0.0}}},"empty-source/(2, 1, 3)/float32/(2,): backing source")
eq(base.shape,{2,1,3},"empty-source/(2, 1, 3)/float32/(2,): backing source: shape")
eq(base.strides,{12,12,4},"empty-source/(2, 1, 3)/float32/(2,): backing source: strides")
eq(base.dtype,"float32","empty-source/(2, 1, 3)/float32/(2,): backing source: dtype")
eq(a.shape,{2,1,3},"empty-source/(2, 1, 3)/float32/(2,): source shape")
eq(a.strides,{12,12,4},"empty-source/(2, 1, 3)/float32/(2,): source strides")
cases=cases+1
end
-- 655: empty-source/(2, 1, 3)/float32/(1, 2); source error=None
do
local base=np.array({{{0.0,0.0,0.0}},{{0.0,0.0,0.0}}},"float32")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 1, 3)/float32/(1, 2): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.0},"empty-source/(2, 1, 3)/float32/(1, 2): result")
eq(result.shape,{2},"empty-source/(2, 1, 3)/float32/(1, 2): result: shape")
eq(result.strides,{4},"empty-source/(2, 1, 3)/float32/(1, 2): result: strides")
eq(result.dtype,"float32","empty-source/(2, 1, 3)/float32/(1, 2): result: dtype")
eq(base:tolist(),{{{0.0,0.0,0.0}},{{0.0,0.0,0.0}}},"empty-source/(2, 1, 3)/float32/(1, 2): backing source")
eq(base.shape,{2,1,3},"empty-source/(2, 1, 3)/float32/(1, 2): backing source: shape")
eq(base.strides,{12,12,4},"empty-source/(2, 1, 3)/float32/(1, 2): backing source: strides")
eq(base.dtype,"float32","empty-source/(2, 1, 3)/float32/(1, 2): backing source: dtype")
eq(a.shape,{2,1,3},"empty-source/(2, 1, 3)/float32/(1, 2): source shape")
eq(a.strides,{12,12,4},"empty-source/(2, 1, 3)/float32/(1, 2): source strides")
cases=cases+1
end
-- 656: empty-source/(2, 1, 3)/complex128/(); source error=None
do
local base=np.array({{{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}},{{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}}},"complex128")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 1, 3)/complex128/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0)},"empty-source/(2, 1, 3)/complex128/(): result")
eq(result.shape,{1},"empty-source/(2, 1, 3)/complex128/(): result: shape")
eq(result.strides,{16},"empty-source/(2, 1, 3)/complex128/(): result: strides")
eq(result.dtype,"complex128","empty-source/(2, 1, 3)/complex128/(): result: dtype")
eq(base:tolist(),{{{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}},{{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}}},"empty-source/(2, 1, 3)/complex128/(): backing source")
eq(base.shape,{2,1,3},"empty-source/(2, 1, 3)/complex128/(): backing source: shape")
eq(base.strides,{48,48,16},"empty-source/(2, 1, 3)/complex128/(): backing source: strides")
eq(base.dtype,"complex128","empty-source/(2, 1, 3)/complex128/(): backing source: dtype")
eq(a.shape,{2,1,3},"empty-source/(2, 1, 3)/complex128/(): source shape")
eq(a.strides,{48,48,16},"empty-source/(2, 1, 3)/complex128/(): source strides")
cases=cases+1
end
-- 657: empty-source/(2, 1, 3)/complex128/(0,); source error=None
do
local base=np.array({{{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}},{{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}}},"complex128")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 1, 3)/complex128/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-source/(2, 1, 3)/complex128/(0,): result")
eq(result.shape,{0},"empty-source/(2, 1, 3)/complex128/(0,): result: shape")
eq(result.strides,{0},"empty-source/(2, 1, 3)/complex128/(0,): result: strides")
eq(result.dtype,"complex128","empty-source/(2, 1, 3)/complex128/(0,): result: dtype")
eq(base:tolist(),{{{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}},{{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}}},"empty-source/(2, 1, 3)/complex128/(0,): backing source")
eq(base.shape,{2,1,3},"empty-source/(2, 1, 3)/complex128/(0,): backing source: shape")
eq(base.strides,{48,48,16},"empty-source/(2, 1, 3)/complex128/(0,): backing source: strides")
eq(base.dtype,"complex128","empty-source/(2, 1, 3)/complex128/(0,): backing source: dtype")
eq(a.shape,{2,1,3},"empty-source/(2, 1, 3)/complex128/(0,): source shape")
eq(a.strides,{48,48,16},"empty-source/(2, 1, 3)/complex128/(0,): source strides")
cases=cases+1
end
-- 658: empty-source/(2, 1, 3)/complex128/(1,); source error=None
do
local base=np.array({{{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}},{{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}}},"complex128")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 1, 3)/complex128/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0)},"empty-source/(2, 1, 3)/complex128/(1,): result")
eq(result.shape,{1},"empty-source/(2, 1, 3)/complex128/(1,): result: shape")
eq(result.strides,{16},"empty-source/(2, 1, 3)/complex128/(1,): result: strides")
eq(result.dtype,"complex128","empty-source/(2, 1, 3)/complex128/(1,): result: dtype")
eq(base:tolist(),{{{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}},{{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}}},"empty-source/(2, 1, 3)/complex128/(1,): backing source")
eq(base.shape,{2,1,3},"empty-source/(2, 1, 3)/complex128/(1,): backing source: shape")
eq(base.strides,{48,48,16},"empty-source/(2, 1, 3)/complex128/(1,): backing source: strides")
eq(base.dtype,"complex128","empty-source/(2, 1, 3)/complex128/(1,): backing source: dtype")
eq(a.shape,{2,1,3},"empty-source/(2, 1, 3)/complex128/(1,): source shape")
eq(a.strides,{48,48,16},"empty-source/(2, 1, 3)/complex128/(1,): source strides")
cases=cases+1
end
-- 659: empty-source/(2, 1, 3)/complex128/(2,); source error=None
do
local base=np.array({{{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}},{{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}}},"complex128")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 1, 3)/complex128/(2,): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0)},"empty-source/(2, 1, 3)/complex128/(2,): result")
eq(result.shape,{1},"empty-source/(2, 1, 3)/complex128/(2,): result: shape")
eq(result.strides,{16},"empty-source/(2, 1, 3)/complex128/(2,): result: strides")
eq(result.dtype,"complex128","empty-source/(2, 1, 3)/complex128/(2,): result: dtype")
eq(base:tolist(),{{{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}},{{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}}},"empty-source/(2, 1, 3)/complex128/(2,): backing source")
eq(base.shape,{2,1,3},"empty-source/(2, 1, 3)/complex128/(2,): backing source: shape")
eq(base.strides,{48,48,16},"empty-source/(2, 1, 3)/complex128/(2,): backing source: strides")
eq(base.dtype,"complex128","empty-source/(2, 1, 3)/complex128/(2,): backing source: dtype")
eq(a.shape,{2,1,3},"empty-source/(2, 1, 3)/complex128/(2,): source shape")
eq(a.strides,{48,48,16},"empty-source/(2, 1, 3)/complex128/(2,): source strides")
cases=cases+1
end
-- 660: empty-source/(2, 1, 3)/complex128/(1, 2); source error=None
do
local base=np.array({{{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}},{{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}}},"complex128")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 1, 3)/complex128/(1, 2): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.0,0.0)},"empty-source/(2, 1, 3)/complex128/(1, 2): result")
eq(result.shape,{2},"empty-source/(2, 1, 3)/complex128/(1, 2): result: shape")
eq(result.strides,{16},"empty-source/(2, 1, 3)/complex128/(1, 2): result: strides")
eq(result.dtype,"complex128","empty-source/(2, 1, 3)/complex128/(1, 2): result: dtype")
eq(base:tolist(),{{{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}},{{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}}},"empty-source/(2, 1, 3)/complex128/(1, 2): backing source")
eq(base.shape,{2,1,3},"empty-source/(2, 1, 3)/complex128/(1, 2): backing source: shape")
eq(base.strides,{48,48,16},"empty-source/(2, 1, 3)/complex128/(1, 2): backing source: strides")
eq(base.dtype,"complex128","empty-source/(2, 1, 3)/complex128/(1, 2): backing source: dtype")
eq(a.shape,{2,1,3},"empty-source/(2, 1, 3)/complex128/(1, 2): source shape")
eq(a.strides,{48,48,16},"empty-source/(2, 1, 3)/complex128/(1, 2): source strides")
cases=cases+1
end
-- 661: empty-source/(2, 1, 3)/U4/(); source error=None
do
local base=np.array({{{"","",""}},{{"","",""}}},"<U4")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 1, 3)/U4/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{""},"empty-source/(2, 1, 3)/U4/(): result")
eq(result.shape,{1},"empty-source/(2, 1, 3)/U4/(): result: shape")
eq(result.strides,{16},"empty-source/(2, 1, 3)/U4/(): result: strides")
eq(result.dtype,"<U4","empty-source/(2, 1, 3)/U4/(): result: dtype")
eq(base:tolist(),{{{"","",""}},{{"","",""}}},"empty-source/(2, 1, 3)/U4/(): backing source")
eq(base.shape,{2,1,3},"empty-source/(2, 1, 3)/U4/(): backing source: shape")
eq(base.strides,{48,48,16},"empty-source/(2, 1, 3)/U4/(): backing source: strides")
eq(base.dtype,"<U4","empty-source/(2, 1, 3)/U4/(): backing source: dtype")
eq(a.shape,{2,1,3},"empty-source/(2, 1, 3)/U4/(): source shape")
eq(a.strides,{48,48,16},"empty-source/(2, 1, 3)/U4/(): source strides")
cases=cases+1
end
-- 662: empty-source/(2, 1, 3)/U4/(0,); source error=None
do
local base=np.array({{{"","",""}},{{"","",""}}},"<U4")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 1, 3)/U4/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-source/(2, 1, 3)/U4/(0,): result")
eq(result.shape,{0},"empty-source/(2, 1, 3)/U4/(0,): result: shape")
eq(result.strides,{0},"empty-source/(2, 1, 3)/U4/(0,): result: strides")
eq(result.dtype,"<U4","empty-source/(2, 1, 3)/U4/(0,): result: dtype")
eq(base:tolist(),{{{"","",""}},{{"","",""}}},"empty-source/(2, 1, 3)/U4/(0,): backing source")
eq(base.shape,{2,1,3},"empty-source/(2, 1, 3)/U4/(0,): backing source: shape")
eq(base.strides,{48,48,16},"empty-source/(2, 1, 3)/U4/(0,): backing source: strides")
eq(base.dtype,"<U4","empty-source/(2, 1, 3)/U4/(0,): backing source: dtype")
eq(a.shape,{2,1,3},"empty-source/(2, 1, 3)/U4/(0,): source shape")
eq(a.strides,{48,48,16},"empty-source/(2, 1, 3)/U4/(0,): source strides")
cases=cases+1
end
-- 663: empty-source/(2, 1, 3)/U4/(1,); source error=None
do
local base=np.array({{{"","",""}},{{"","",""}}},"<U4")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 1, 3)/U4/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{""},"empty-source/(2, 1, 3)/U4/(1,): result")
eq(result.shape,{1},"empty-source/(2, 1, 3)/U4/(1,): result: shape")
eq(result.strides,{16},"empty-source/(2, 1, 3)/U4/(1,): result: strides")
eq(result.dtype,"<U4","empty-source/(2, 1, 3)/U4/(1,): result: dtype")
eq(base:tolist(),{{{"","",""}},{{"","",""}}},"empty-source/(2, 1, 3)/U4/(1,): backing source")
eq(base.shape,{2,1,3},"empty-source/(2, 1, 3)/U4/(1,): backing source: shape")
eq(base.strides,{48,48,16},"empty-source/(2, 1, 3)/U4/(1,): backing source: strides")
eq(base.dtype,"<U4","empty-source/(2, 1, 3)/U4/(1,): backing source: dtype")
eq(a.shape,{2,1,3},"empty-source/(2, 1, 3)/U4/(1,): source shape")
eq(a.strides,{48,48,16},"empty-source/(2, 1, 3)/U4/(1,): source strides")
cases=cases+1
end
-- 664: empty-source/(2, 1, 3)/U4/(2,); source error=None
do
local base=np.array({{{"","",""}},{{"","",""}}},"<U4")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 1, 3)/U4/(2,): acceptance"..": "..tostring(result))
eq(result:tolist(),{""},"empty-source/(2, 1, 3)/U4/(2,): result")
eq(result.shape,{1},"empty-source/(2, 1, 3)/U4/(2,): result: shape")
eq(result.strides,{16},"empty-source/(2, 1, 3)/U4/(2,): result: strides")
eq(result.dtype,"<U4","empty-source/(2, 1, 3)/U4/(2,): result: dtype")
eq(base:tolist(),{{{"","",""}},{{"","",""}}},"empty-source/(2, 1, 3)/U4/(2,): backing source")
eq(base.shape,{2,1,3},"empty-source/(2, 1, 3)/U4/(2,): backing source: shape")
eq(base.strides,{48,48,16},"empty-source/(2, 1, 3)/U4/(2,): backing source: strides")
eq(base.dtype,"<U4","empty-source/(2, 1, 3)/U4/(2,): backing source: dtype")
eq(a.shape,{2,1,3},"empty-source/(2, 1, 3)/U4/(2,): source shape")
eq(a.strides,{48,48,16},"empty-source/(2, 1, 3)/U4/(2,): source strides")
cases=cases+1
end
-- 665: empty-source/(2, 1, 3)/U4/(1, 2); source error=None
do
local base=np.array({{{"","",""}},{{"","",""}}},"<U4")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 1, 3)/U4/(1, 2): acceptance"..": "..tostring(result))
eq(result:tolist(),{"",""},"empty-source/(2, 1, 3)/U4/(1, 2): result")
eq(result.shape,{2},"empty-source/(2, 1, 3)/U4/(1, 2): result: shape")
eq(result.strides,{16},"empty-source/(2, 1, 3)/U4/(1, 2): result: strides")
eq(result.dtype,"<U4","empty-source/(2, 1, 3)/U4/(1, 2): result: dtype")
eq(base:tolist(),{{{"","",""}},{{"","",""}}},"empty-source/(2, 1, 3)/U4/(1, 2): backing source")
eq(base.shape,{2,1,3},"empty-source/(2, 1, 3)/U4/(1, 2): backing source: shape")
eq(base.strides,{48,48,16},"empty-source/(2, 1, 3)/U4/(1, 2): backing source: strides")
eq(base.dtype,"<U4","empty-source/(2, 1, 3)/U4/(1, 2): backing source: dtype")
eq(a.shape,{2,1,3},"empty-source/(2, 1, 3)/U4/(1, 2): source shape")
eq(a.strides,{48,48,16},"empty-source/(2, 1, 3)/U4/(1, 2): source strides")
cases=cases+1
end
-- 666: empty-source/(2, 1, 3)/S4/(); source error=None
do
local base=np.array({{{"","",""}},{{"","",""}}},"|S4")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 1, 3)/S4/(): acceptance"..": "..tostring(result))
eq(result:tolist(),{""},"empty-source/(2, 1, 3)/S4/(): result")
eq(result.shape,{1},"empty-source/(2, 1, 3)/S4/(): result: shape")
eq(result.strides,{4},"empty-source/(2, 1, 3)/S4/(): result: strides")
eq(result.dtype,"|S4","empty-source/(2, 1, 3)/S4/(): result: dtype")
eq(base:tolist(),{{{"","",""}},{{"","",""}}},"empty-source/(2, 1, 3)/S4/(): backing source")
eq(base.shape,{2,1,3},"empty-source/(2, 1, 3)/S4/(): backing source: shape")
eq(base.strides,{12,12,4},"empty-source/(2, 1, 3)/S4/(): backing source: strides")
eq(base.dtype,"|S4","empty-source/(2, 1, 3)/S4/(): backing source: dtype")
eq(a.shape,{2,1,3},"empty-source/(2, 1, 3)/S4/(): source shape")
eq(a.strides,{12,12,4},"empty-source/(2, 1, 3)/S4/(): source strides")
cases=cases+1
end
-- 667: empty-source/(2, 1, 3)/S4/(0,); source error=None
do
local base=np.array({{{"","",""}},{{"","",""}}},"|S4")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 1, 3)/S4/(0,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-source/(2, 1, 3)/S4/(0,): result")
eq(result.shape,{0},"empty-source/(2, 1, 3)/S4/(0,): result: shape")
eq(result.strides,{0},"empty-source/(2, 1, 3)/S4/(0,): result: strides")
eq(result.dtype,"|S4","empty-source/(2, 1, 3)/S4/(0,): result: dtype")
eq(base:tolist(),{{{"","",""}},{{"","",""}}},"empty-source/(2, 1, 3)/S4/(0,): backing source")
eq(base.shape,{2,1,3},"empty-source/(2, 1, 3)/S4/(0,): backing source: shape")
eq(base.strides,{12,12,4},"empty-source/(2, 1, 3)/S4/(0,): backing source: strides")
eq(base.dtype,"|S4","empty-source/(2, 1, 3)/S4/(0,): backing source: dtype")
eq(a.shape,{2,1,3},"empty-source/(2, 1, 3)/S4/(0,): source shape")
eq(a.strides,{12,12,4},"empty-source/(2, 1, 3)/S4/(0,): source strides")
cases=cases+1
end
-- 668: empty-source/(2, 1, 3)/S4/(1,); source error=None
do
local base=np.array({{{"","",""}},{{"","",""}}},"|S4")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 1, 3)/S4/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{""},"empty-source/(2, 1, 3)/S4/(1,): result")
eq(result.shape,{1},"empty-source/(2, 1, 3)/S4/(1,): result: shape")
eq(result.strides,{4},"empty-source/(2, 1, 3)/S4/(1,): result: strides")
eq(result.dtype,"|S4","empty-source/(2, 1, 3)/S4/(1,): result: dtype")
eq(base:tolist(),{{{"","",""}},{{"","",""}}},"empty-source/(2, 1, 3)/S4/(1,): backing source")
eq(base.shape,{2,1,3},"empty-source/(2, 1, 3)/S4/(1,): backing source: shape")
eq(base.strides,{12,12,4},"empty-source/(2, 1, 3)/S4/(1,): backing source: strides")
eq(base.dtype,"|S4","empty-source/(2, 1, 3)/S4/(1,): backing source: dtype")
eq(a.shape,{2,1,3},"empty-source/(2, 1, 3)/S4/(1,): source shape")
eq(a.strides,{12,12,4},"empty-source/(2, 1, 3)/S4/(1,): source strides")
cases=cases+1
end
-- 669: empty-source/(2, 1, 3)/S4/(2,); source error=None
do
local base=np.array({{{"","",""}},{{"","",""}}},"|S4")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 1, 3)/S4/(2,): acceptance"..": "..tostring(result))
eq(result:tolist(),{""},"empty-source/(2, 1, 3)/S4/(2,): result")
eq(result.shape,{1},"empty-source/(2, 1, 3)/S4/(2,): result: shape")
eq(result.strides,{4},"empty-source/(2, 1, 3)/S4/(2,): result: strides")
eq(result.dtype,"|S4","empty-source/(2, 1, 3)/S4/(2,): result: dtype")
eq(base:tolist(),{{{"","",""}},{{"","",""}}},"empty-source/(2, 1, 3)/S4/(2,): backing source")
eq(base.shape,{2,1,3},"empty-source/(2, 1, 3)/S4/(2,): backing source: shape")
eq(base.strides,{12,12,4},"empty-source/(2, 1, 3)/S4/(2,): backing source: strides")
eq(base.dtype,"|S4","empty-source/(2, 1, 3)/S4/(2,): backing source: dtype")
eq(a.shape,{2,1,3},"empty-source/(2, 1, 3)/S4/(2,): source shape")
eq(a.strides,{12,12,4},"empty-source/(2, 1, 3)/S4/(2,): source strides")
cases=cases+1
end
-- 670: empty-source/(2, 1, 3)/S4/(1, 2); source error=None
do
local base=np.array({{{"","",""}},{{"","",""}}},"|S4")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 1, 3)/S4/(1, 2): acceptance"..": "..tostring(result))
eq(result:tolist(),{"",""},"empty-source/(2, 1, 3)/S4/(1, 2): result")
eq(result.shape,{2},"empty-source/(2, 1, 3)/S4/(1, 2): result: shape")
eq(result.strides,{4},"empty-source/(2, 1, 3)/S4/(1, 2): result: strides")
eq(result.dtype,"|S4","empty-source/(2, 1, 3)/S4/(1, 2): result: dtype")
eq(base:tolist(),{{{"","",""}},{{"","",""}}},"empty-source/(2, 1, 3)/S4/(1, 2): backing source")
eq(base.shape,{2,1,3},"empty-source/(2, 1, 3)/S4/(1, 2): backing source: shape")
eq(base.strides,{12,12,4},"empty-source/(2, 1, 3)/S4/(1, 2): backing source: strides")
eq(base.dtype,"|S4","empty-source/(2, 1, 3)/S4/(1, 2): backing source: dtype")
eq(a.shape,{2,1,3},"empty-source/(2, 1, 3)/S4/(1, 2): source shape")
eq(a.strides,{12,12,4},"empty-source/(2, 1, 3)/S4/(1, 2): source strides")
cases=cases+1
end
-- 671: empty-source/(2, 1, 3)/datetime64[D]/(); source error=None
do
local base=np.array({{{0,0,0}},{{0,0,0}}},"datetime64[D]")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 1, 3)/datetime64[D]/(): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0},"empty-source/(2, 1, 3)/datetime64[D]/(): result")
eq(result.shape,{1},"empty-source/(2, 1, 3)/datetime64[D]/(): result: shape")
eq(result.strides,{8},"empty-source/(2, 1, 3)/datetime64[D]/(): result: strides")
eq(result.dtype,"datetime64[D]","empty-source/(2, 1, 3)/datetime64[D]/(): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{{0,0,0}},{{0,0,0}}},"empty-source/(2, 1, 3)/datetime64[D]/(): backing source")
eq(base.shape,{2,1,3},"empty-source/(2, 1, 3)/datetime64[D]/(): backing source: shape")
eq(base.strides,{24,24,8},"empty-source/(2, 1, 3)/datetime64[D]/(): backing source: strides")
eq(base.dtype,"datetime64[D]","empty-source/(2, 1, 3)/datetime64[D]/(): backing source: dtype")
eq(a.shape,{2,1,3},"empty-source/(2, 1, 3)/datetime64[D]/(): source shape")
eq(a.strides,{24,24,8},"empty-source/(2, 1, 3)/datetime64[D]/(): source strides")
cases=cases+1
end
-- 672: empty-source/(2, 1, 3)/datetime64[D]/(0,); source error=None
do
local base=np.array({{{0,0,0}},{{0,0,0}}},"datetime64[D]")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 1, 3)/datetime64[D]/(0,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{},"empty-source/(2, 1, 3)/datetime64[D]/(0,): result")
eq(result.shape,{0},"empty-source/(2, 1, 3)/datetime64[D]/(0,): result: shape")
eq(result.strides,{0},"empty-source/(2, 1, 3)/datetime64[D]/(0,): result: strides")
eq(result.dtype,"datetime64[D]","empty-source/(2, 1, 3)/datetime64[D]/(0,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{{0,0,0}},{{0,0,0}}},"empty-source/(2, 1, 3)/datetime64[D]/(0,): backing source")
eq(base.shape,{2,1,3},"empty-source/(2, 1, 3)/datetime64[D]/(0,): backing source: shape")
eq(base.strides,{24,24,8},"empty-source/(2, 1, 3)/datetime64[D]/(0,): backing source: strides")
eq(base.dtype,"datetime64[D]","empty-source/(2, 1, 3)/datetime64[D]/(0,): backing source: dtype")
eq(a.shape,{2,1,3},"empty-source/(2, 1, 3)/datetime64[D]/(0,): source shape")
eq(a.strides,{24,24,8},"empty-source/(2, 1, 3)/datetime64[D]/(0,): source strides")
cases=cases+1
end
-- 673: empty-source/(2, 1, 3)/datetime64[D]/(1,); source error=None
do
local base=np.array({{{0,0,0}},{{0,0,0}}},"datetime64[D]")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 1, 3)/datetime64[D]/(1,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0},"empty-source/(2, 1, 3)/datetime64[D]/(1,): result")
eq(result.shape,{1},"empty-source/(2, 1, 3)/datetime64[D]/(1,): result: shape")
eq(result.strides,{8},"empty-source/(2, 1, 3)/datetime64[D]/(1,): result: strides")
eq(result.dtype,"datetime64[D]","empty-source/(2, 1, 3)/datetime64[D]/(1,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{{0,0,0}},{{0,0,0}}},"empty-source/(2, 1, 3)/datetime64[D]/(1,): backing source")
eq(base.shape,{2,1,3},"empty-source/(2, 1, 3)/datetime64[D]/(1,): backing source: shape")
eq(base.strides,{24,24,8},"empty-source/(2, 1, 3)/datetime64[D]/(1,): backing source: strides")
eq(base.dtype,"datetime64[D]","empty-source/(2, 1, 3)/datetime64[D]/(1,): backing source: dtype")
eq(a.shape,{2,1,3},"empty-source/(2, 1, 3)/datetime64[D]/(1,): source shape")
eq(a.strides,{24,24,8},"empty-source/(2, 1, 3)/datetime64[D]/(1,): source strides")
cases=cases+1
end
-- 674: empty-source/(2, 1, 3)/datetime64[D]/(2,); source error=None
do
local base=np.array({{{0,0,0}},{{0,0,0}}},"datetime64[D]")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 1, 3)/datetime64[D]/(2,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0},"empty-source/(2, 1, 3)/datetime64[D]/(2,): result")
eq(result.shape,{1},"empty-source/(2, 1, 3)/datetime64[D]/(2,): result: shape")
eq(result.strides,{8},"empty-source/(2, 1, 3)/datetime64[D]/(2,): result: strides")
eq(result.dtype,"datetime64[D]","empty-source/(2, 1, 3)/datetime64[D]/(2,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{{0,0,0}},{{0,0,0}}},"empty-source/(2, 1, 3)/datetime64[D]/(2,): backing source")
eq(base.shape,{2,1,3},"empty-source/(2, 1, 3)/datetime64[D]/(2,): backing source: shape")
eq(base.strides,{24,24,8},"empty-source/(2, 1, 3)/datetime64[D]/(2,): backing source: strides")
eq(base.dtype,"datetime64[D]","empty-source/(2, 1, 3)/datetime64[D]/(2,): backing source: dtype")
eq(a.shape,{2,1,3},"empty-source/(2, 1, 3)/datetime64[D]/(2,): source shape")
eq(a.strides,{24,24,8},"empty-source/(2, 1, 3)/datetime64[D]/(2,): source strides")
cases=cases+1
end
-- 675: empty-source/(2, 1, 3)/datetime64[D]/(1, 2); source error=None
do
local base=np.array({{{0,0,0}},{{0,0,0}}},"datetime64[D]")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 1, 3)/datetime64[D]/(1, 2): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0,0},"empty-source/(2, 1, 3)/datetime64[D]/(1, 2): result")
eq(result.shape,{2},"empty-source/(2, 1, 3)/datetime64[D]/(1, 2): result: shape")
eq(result.strides,{8},"empty-source/(2, 1, 3)/datetime64[D]/(1, 2): result: strides")
eq(result.dtype,"datetime64[D]","empty-source/(2, 1, 3)/datetime64[D]/(1, 2): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{{0,0,0}},{{0,0,0}}},"empty-source/(2, 1, 3)/datetime64[D]/(1, 2): backing source")
eq(base.shape,{2,1,3},"empty-source/(2, 1, 3)/datetime64[D]/(1, 2): backing source: shape")
eq(base.strides,{24,24,8},"empty-source/(2, 1, 3)/datetime64[D]/(1, 2): backing source: strides")
eq(base.dtype,"datetime64[D]","empty-source/(2, 1, 3)/datetime64[D]/(1, 2): backing source: dtype")
eq(a.shape,{2,1,3},"empty-source/(2, 1, 3)/datetime64[D]/(1, 2): source shape")
eq(a.strides,{24,24,8},"empty-source/(2, 1, 3)/datetime64[D]/(1, 2): source strides")
cases=cases+1
end
-- 676: empty-source/(2, 1, 3)/timedelta64[h]/(); source error=None
do
local base=np.array({{{0,0,0}},{{0,0,0}}},"timedelta64[h]")
local a=base
local condition=np.array(true,"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 1, 3)/timedelta64[h]/(): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0},"empty-source/(2, 1, 3)/timedelta64[h]/(): result")
eq(result.shape,{1},"empty-source/(2, 1, 3)/timedelta64[h]/(): result: shape")
eq(result.strides,{8},"empty-source/(2, 1, 3)/timedelta64[h]/(): result: strides")
eq(result.dtype,"timedelta64[h]","empty-source/(2, 1, 3)/timedelta64[h]/(): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{{0,0,0}},{{0,0,0}}},"empty-source/(2, 1, 3)/timedelta64[h]/(): backing source")
eq(base.shape,{2,1,3},"empty-source/(2, 1, 3)/timedelta64[h]/(): backing source: shape")
eq(base.strides,{24,24,8},"empty-source/(2, 1, 3)/timedelta64[h]/(): backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-source/(2, 1, 3)/timedelta64[h]/(): backing source: dtype")
eq(a.shape,{2,1,3},"empty-source/(2, 1, 3)/timedelta64[h]/(): source shape")
eq(a.strides,{24,24,8},"empty-source/(2, 1, 3)/timedelta64[h]/(): source strides")
cases=cases+1
end
-- 677: empty-source/(2, 1, 3)/timedelta64[h]/(0,); source error=None
do
local base=np.array({{{0,0,0}},{{0,0,0}}},"timedelta64[h]")
local a=base
local condition=np.zeros({0},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 1, 3)/timedelta64[h]/(0,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{},"empty-source/(2, 1, 3)/timedelta64[h]/(0,): result")
eq(result.shape,{0},"empty-source/(2, 1, 3)/timedelta64[h]/(0,): result: shape")
eq(result.strides,{0},"empty-source/(2, 1, 3)/timedelta64[h]/(0,): result: strides")
eq(result.dtype,"timedelta64[h]","empty-source/(2, 1, 3)/timedelta64[h]/(0,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{{0,0,0}},{{0,0,0}}},"empty-source/(2, 1, 3)/timedelta64[h]/(0,): backing source")
eq(base.shape,{2,1,3},"empty-source/(2, 1, 3)/timedelta64[h]/(0,): backing source: shape")
eq(base.strides,{24,24,8},"empty-source/(2, 1, 3)/timedelta64[h]/(0,): backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-source/(2, 1, 3)/timedelta64[h]/(0,): backing source: dtype")
eq(a.shape,{2,1,3},"empty-source/(2, 1, 3)/timedelta64[h]/(0,): source shape")
eq(a.strides,{24,24,8},"empty-source/(2, 1, 3)/timedelta64[h]/(0,): source strides")
cases=cases+1
end
-- 678: empty-source/(2, 1, 3)/timedelta64[h]/(1,); source error=None
do
local base=np.array({{{0,0,0}},{{0,0,0}}},"timedelta64[h]")
local a=base
local condition=np.array({true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 1, 3)/timedelta64[h]/(1,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0},"empty-source/(2, 1, 3)/timedelta64[h]/(1,): result")
eq(result.shape,{1},"empty-source/(2, 1, 3)/timedelta64[h]/(1,): result: shape")
eq(result.strides,{8},"empty-source/(2, 1, 3)/timedelta64[h]/(1,): result: strides")
eq(result.dtype,"timedelta64[h]","empty-source/(2, 1, 3)/timedelta64[h]/(1,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{{0,0,0}},{{0,0,0}}},"empty-source/(2, 1, 3)/timedelta64[h]/(1,): backing source")
eq(base.shape,{2,1,3},"empty-source/(2, 1, 3)/timedelta64[h]/(1,): backing source: shape")
eq(base.strides,{24,24,8},"empty-source/(2, 1, 3)/timedelta64[h]/(1,): backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-source/(2, 1, 3)/timedelta64[h]/(1,): backing source: dtype")
eq(a.shape,{2,1,3},"empty-source/(2, 1, 3)/timedelta64[h]/(1,): source shape")
eq(a.strides,{24,24,8},"empty-source/(2, 1, 3)/timedelta64[h]/(1,): source strides")
cases=cases+1
end
-- 679: empty-source/(2, 1, 3)/timedelta64[h]/(2,); source error=None
do
local base=np.array({{{0,0,0}},{{0,0,0}}},"timedelta64[h]")
local a=base
local condition=np.array({false,true},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 1, 3)/timedelta64[h]/(2,): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0},"empty-source/(2, 1, 3)/timedelta64[h]/(2,): result")
eq(result.shape,{1},"empty-source/(2, 1, 3)/timedelta64[h]/(2,): result: shape")
eq(result.strides,{8},"empty-source/(2, 1, 3)/timedelta64[h]/(2,): result: strides")
eq(result.dtype,"timedelta64[h]","empty-source/(2, 1, 3)/timedelta64[h]/(2,): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{{0,0,0}},{{0,0,0}}},"empty-source/(2, 1, 3)/timedelta64[h]/(2,): backing source")
eq(base.shape,{2,1,3},"empty-source/(2, 1, 3)/timedelta64[h]/(2,): backing source: shape")
eq(base.strides,{24,24,8},"empty-source/(2, 1, 3)/timedelta64[h]/(2,): backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-source/(2, 1, 3)/timedelta64[h]/(2,): backing source: dtype")
eq(a.shape,{2,1,3},"empty-source/(2, 1, 3)/timedelta64[h]/(2,): source shape")
eq(a.strides,{24,24,8},"empty-source/(2, 1, 3)/timedelta64[h]/(2,): source strides")
cases=cases+1
end
-- 680: empty-source/(2, 1, 3)/timedelta64[h]/(1, 2); source error=None
do
local base=np.array({{{0,0,0}},{{0,0,0}}},"timedelta64[h]")
local a=base
local condition=np.array({{true,true}},"bool")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"empty-source/(2, 1, 3)/timedelta64[h]/(1, 2): acceptance"..": "..tostring(result))
eq(np.astype(result,'int64'):tolist(),{0,0},"empty-source/(2, 1, 3)/timedelta64[h]/(1, 2): result")
eq(result.shape,{2},"empty-source/(2, 1, 3)/timedelta64[h]/(1, 2): result: shape")
eq(result.strides,{8},"empty-source/(2, 1, 3)/timedelta64[h]/(1, 2): result: strides")
eq(result.dtype,"timedelta64[h]","empty-source/(2, 1, 3)/timedelta64[h]/(1, 2): result: dtype")
eq(np.astype(base,'int64'):tolist(),{{{0,0,0}},{{0,0,0}}},"empty-source/(2, 1, 3)/timedelta64[h]/(1, 2): backing source")
eq(base.shape,{2,1,3},"empty-source/(2, 1, 3)/timedelta64[h]/(1, 2): backing source: shape")
eq(base.strides,{24,24,8},"empty-source/(2, 1, 3)/timedelta64[h]/(1, 2): backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-source/(2, 1, 3)/timedelta64[h]/(1, 2): backing source: dtype")
eq(a.shape,{2,1,3},"empty-source/(2, 1, 3)/timedelta64[h]/(1, 2): source shape")
eq(a.strides,{24,24,8},"empty-source/(2, 1, 3)/timedelta64[h]/(1, 2): source strides")
cases=cases+1
end
-- 681: truth-condition/float64; source error=None
do
local base=np.array({0,1,2,3},"int64")
local a=base
local condition=np.array({0.0,(0/0),math.huge,-0.0},"float64")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"truth-condition/float64: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2},"truth-condition/float64: result")
eq(result.shape,{2},"truth-condition/float64: result: shape")
eq(result.strides,{8},"truth-condition/float64: result: strides")
eq(result.dtype,"int64","truth-condition/float64: result: dtype")
eq(base:tolist(),{0,1,2,3},"truth-condition/float64: backing source")
eq(base.shape,{4},"truth-condition/float64: backing source: shape")
eq(base.strides,{8},"truth-condition/float64: backing source: strides")
eq(base.dtype,"int64","truth-condition/float64: backing source: dtype")
eq(a.shape,{4},"truth-condition/float64: source shape")
eq(a.strides,{8},"truth-condition/float64: source strides")
cases=cases+1
end
-- 682: truth-condition/complex128; source error=None
do
local base=np.array({0,1,2,3},"int64")
local a=base
local condition=np.array({np.complex(0.0,0.0),np.complex(0.0,1.0),np.complex((0/0),0.0),np.complex(0.0,(0/0))},"complex128")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"truth-condition/complex128: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3},"truth-condition/complex128: result")
eq(result.shape,{3},"truth-condition/complex128: result: shape")
eq(result.strides,{8},"truth-condition/complex128: result: strides")
eq(result.dtype,"int64","truth-condition/complex128: result: dtype")
eq(base:tolist(),{0,1,2,3},"truth-condition/complex128: backing source")
eq(base.shape,{4},"truth-condition/complex128: backing source: shape")
eq(base.strides,{8},"truth-condition/complex128: backing source: strides")
eq(base.dtype,"int64","truth-condition/complex128: backing source: dtype")
eq(a.shape,{4},"truth-condition/complex128: source shape")
eq(a.strides,{8},"truth-condition/complex128: source strides")
cases=cases+1
end
-- 683: truth-condition/U4; source error=None
do
local base=np.array({0,1,2,3},"int64")
local a=base
local condition=np.array({"","0"," ","a"},"<U4")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"truth-condition/U4: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3},"truth-condition/U4: result")
eq(result.shape,{3},"truth-condition/U4: result: shape")
eq(result.strides,{8},"truth-condition/U4: result: strides")
eq(result.dtype,"int64","truth-condition/U4: result: dtype")
eq(base:tolist(),{0,1,2,3},"truth-condition/U4: backing source")
eq(base.shape,{4},"truth-condition/U4: backing source: shape")
eq(base.strides,{8},"truth-condition/U4: backing source: strides")
eq(base.dtype,"int64","truth-condition/U4: backing source: dtype")
eq(a.shape,{4},"truth-condition/U4: source shape")
eq(a.strides,{8},"truth-condition/U4: source strides")
cases=cases+1
end
-- 684: truth-condition/S4; source error=None
do
local base=np.array({0,1,2,3},"int64")
local a=base
local condition=np.array({"","0"," ","a"},"|S4")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"truth-condition/S4: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3},"truth-condition/S4: result")
eq(result.shape,{3},"truth-condition/S4: result: shape")
eq(result.strides,{8},"truth-condition/S4: result: strides")
eq(result.dtype,"int64","truth-condition/S4: result: dtype")
eq(base:tolist(),{0,1,2,3},"truth-condition/S4: backing source")
eq(base.shape,{4},"truth-condition/S4: backing source: shape")
eq(base.strides,{8},"truth-condition/S4: backing source: strides")
eq(base.dtype,"int64","truth-condition/S4: backing source: dtype")
eq(a.shape,{4},"truth-condition/S4: source shape")
eq(a.strides,{8},"truth-condition/S4: source strides")
cases=cases+1
end
-- 685: truth-condition/datetime64[D]; source error=None
do
local base=np.array({0,1,2,3},"int64")
local a=base
local condition=np.array({0,math.mininteger,1,-1},"datetime64[D]")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"truth-condition/datetime64[D]: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3},"truth-condition/datetime64[D]: result")
eq(result.shape,{3},"truth-condition/datetime64[D]: result: shape")
eq(result.strides,{8},"truth-condition/datetime64[D]: result: strides")
eq(result.dtype,"int64","truth-condition/datetime64[D]: result: dtype")
eq(base:tolist(),{0,1,2,3},"truth-condition/datetime64[D]: backing source")
eq(base.shape,{4},"truth-condition/datetime64[D]: backing source: shape")
eq(base.strides,{8},"truth-condition/datetime64[D]: backing source: strides")
eq(base.dtype,"int64","truth-condition/datetime64[D]: backing source: dtype")
eq(a.shape,{4},"truth-condition/datetime64[D]: source shape")
eq(a.strides,{8},"truth-condition/datetime64[D]: source strides")
cases=cases+1
end
-- 686: truth-condition/timedelta64[h]; source error=None
do
local base=np.array({0,1,2,3},"int64")
local a=base
local condition=np.array({0,math.mininteger,1,-1},"timedelta64[h]")
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"truth-condition/timedelta64[h]: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3},"truth-condition/timedelta64[h]: result")
eq(result.shape,{3},"truth-condition/timedelta64[h]: result: shape")
eq(result.strides,{8},"truth-condition/timedelta64[h]: result: strides")
eq(result.dtype,"int64","truth-condition/timedelta64[h]: result: dtype")
eq(base:tolist(),{0,1,2,3},"truth-condition/timedelta64[h]: backing source")
eq(base.shape,{4},"truth-condition/timedelta64[h]: backing source: shape")
eq(base.strides,{8},"truth-condition/timedelta64[h]: backing source: strides")
eq(base.dtype,"int64","truth-condition/timedelta64[h]: backing source: dtype")
eq(a.shape,{4},"truth-condition/timedelta64[h]: source shape")
eq(a.strides,{8},"truth-condition/timedelta64[h]: source strides")
cases=cases+1
end
-- 687: literal/[]; source error=None
do
local base=np.array({0,1,2,3,4,5},"int64")
local a=base
local condition={}
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"literal/[]: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"literal/[]: result")
eq(result.shape,{0},"literal/[]: result: shape")
eq(result.strides,{0},"literal/[]: result: strides")
eq(result.dtype,"int64","literal/[]: result: dtype")
eq(base:tolist(),{0,1,2,3,4,5},"literal/[]: backing source")
eq(base.shape,{6},"literal/[]: backing source: shape")
eq(base.strides,{8},"literal/[]: backing source: strides")
eq(base.dtype,"int64","literal/[]: backing source: dtype")
eq(a.shape,{6},"literal/[]: source shape")
eq(a.strides,{8},"literal/[]: source strides")
cases=cases+1
end
-- 688: literal/[0, 1, 2]; source error=None
do
local base=np.array({0,1,2,3,4,5},"int64")
local a=base
local condition={0,1,2}
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"literal/[0, 1, 2]: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2},"literal/[0, 1, 2]: result")
eq(result.shape,{2},"literal/[0, 1, 2]: result: shape")
eq(result.strides,{8},"literal/[0, 1, 2]: result: strides")
eq(result.dtype,"int64","literal/[0, 1, 2]: result: dtype")
eq(base:tolist(),{0,1,2,3,4,5},"literal/[0, 1, 2]: backing source")
eq(base.shape,{6},"literal/[0, 1, 2]: backing source: shape")
eq(base.strides,{8},"literal/[0, 1, 2]: backing source: strides")
eq(base.dtype,"int64","literal/[0, 1, 2]: backing source: dtype")
eq(a.shape,{6},"literal/[0, 1, 2]: source shape")
eq(a.strides,{8},"literal/[0, 1, 2]: source strides")
cases=cases+1
end
-- 689: literal/['', '0', 'a']; source error=None
do
local base=np.array({0,1,2,3,4,5},"int64")
local a=base
local condition={"","0","a"}
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"literal/['', '0', 'a']: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2},"literal/['', '0', 'a']: result")
eq(result.shape,{2},"literal/['', '0', 'a']: result: shape")
eq(result.strides,{8},"literal/['', '0', 'a']: result: strides")
eq(result.dtype,"int64","literal/['', '0', 'a']: result: dtype")
eq(base:tolist(),{0,1,2,3,4,5},"literal/['', '0', 'a']: backing source")
eq(base.shape,{6},"literal/['', '0', 'a']: backing source: shape")
eq(base.strides,{8},"literal/['', '0', 'a']: backing source: strides")
eq(base.dtype,"int64","literal/['', '0', 'a']: backing source: dtype")
eq(a.shape,{6},"literal/['', '0', 'a']: source shape")
eq(a.strides,{8},"literal/['', '0', 'a']: source strides")
cases=cases+1
end
-- 690: literal/[1, True, 0]; source error=None
do
local base=np.array({0,1,2,3,4,5},"int64")
local a=base
local condition={1,true,0}
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"literal/[1, True, 0]: acceptance"..": "..tostring(result))
eq(result:tolist(),{0,1},"literal/[1, True, 0]: result")
eq(result.shape,{2},"literal/[1, True, 0]: result: shape")
eq(result.strides,{8},"literal/[1, True, 0]: result: strides")
eq(result.dtype,"int64","literal/[1, True, 0]: result: dtype")
eq(base:tolist(),{0,1,2,3,4,5},"literal/[1, True, 0]: backing source")
eq(base.shape,{6},"literal/[1, True, 0]: backing source: shape")
eq(base.strides,{8},"literal/[1, True, 0]: backing source: strides")
eq(base.dtype,"int64","literal/[1, True, 0]: backing source: dtype")
eq(a.shape,{6},"literal/[1, True, 0]: source shape")
eq(a.strides,{8},"literal/[1, True, 0]: source strides")
cases=cases+1
end
-- 691: literal/True; source error=None
do
local base=np.array({0,1,2,3,4,5},"int64")
local a=base
local condition=true
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"literal/True: acceptance"..": "..tostring(result))
eq(result:tolist(),{0},"literal/True: result")
eq(result.shape,{1},"literal/True: result: shape")
eq(result.strides,{8},"literal/True: result: strides")
eq(result.dtype,"int64","literal/True: result: dtype")
eq(base:tolist(),{0,1,2,3,4,5},"literal/True: backing source")
eq(base.shape,{6},"literal/True: backing source: shape")
eq(base.strides,{8},"literal/True: backing source: strides")
eq(base.dtype,"int64","literal/True: backing source: dtype")
eq(a.shape,{6},"literal/True: source shape")
eq(a.strides,{8},"literal/True: source strides")
cases=cases+1
end
-- 692: literal/[[1, 0], [0, 2]]; source error=None
do
local base=np.array({0,1,2,3,4,5},"int64")
local a=base
local condition={{1,0},{0,2}}
local ok,result=pcall(function() return np.extract(condition,a) end)
assert(ok==true,"literal/[[1, 0], [0, 2]]: acceptance"..": "..tostring(result))
eq(result:tolist(),{0,3},"literal/[[1, 0], [0, 2]]: result")
eq(result.shape,{2},"literal/[[1, 0], [0, 2]]: result: shape")
eq(result.strides,{8},"literal/[[1, 0], [0, 2]]: result: strides")
eq(result.dtype,"int64","literal/[[1, 0], [0, 2]]: result: dtype")
eq(base:tolist(),{0,1,2,3,4,5},"literal/[[1, 0], [0, 2]]: backing source")
eq(base.shape,{6},"literal/[[1, 0], [0, 2]]: backing source: shape")
eq(base.strides,{8},"literal/[[1, 0], [0, 2]]: backing source: strides")
eq(base.dtype,"int64","literal/[[1, 0], [0, 2]]: backing source: dtype")
eq(a.shape,{6},"literal/[[1, 0], [0, 2]]: source shape")
eq(a.strides,{8},"literal/[[1, 0], [0, 2]]: source strides")
cases=cases+1
end
end
chunk()
end
assert(cases==692)
print('extract103 differential: '..cases..' cases, '..checks..' checks passed')
