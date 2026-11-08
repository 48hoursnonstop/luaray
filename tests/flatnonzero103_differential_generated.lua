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
-- 1: int8/plain; source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"int8/plain: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,5,6,7,8,9,10,11,12},"int8/plain: result")
eq(result.shape,{11},"int8/plain: result: shape")
eq(result.strides,{8},"int8/plain: result: strides")
eq(result.dtype,"int64","int8/plain: result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8/plain: backing source")
eq(base.shape,{3,4},"int8/plain: backing source: shape")
eq(base.strides,{4,1},"int8/plain: backing source: strides")
eq(base.dtype,"int8","int8/plain: backing source: dtype")
eq(a.shape,{3,4},"int8/plain: source shape")
eq(a.strides,{4,1},"int8/plain: source strides")
cases=cases+1
end
-- 2: int8/transpose; source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8")
local a=np.transpose(base)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"int8/transpose: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,5,6,7,8,9,10,11,12},"int8/transpose: result")
eq(result.shape,{11},"int8/transpose: result: shape")
eq(result.strides,{8},"int8/transpose: result: strides")
eq(result.dtype,"int64","int8/transpose: result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8/transpose: backing source")
eq(base.shape,{3,4},"int8/transpose: backing source: shape")
eq(base.strides,{4,1},"int8/transpose: backing source: strides")
eq(base.dtype,"int8","int8/transpose: backing source: dtype")
eq(a.shape,{4,3},"int8/transpose: source shape")
eq(a.strides,{1,4},"int8/transpose: source strides")
cases=cases+1
end
-- 3: int8/reverse_columns; source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8")
local a=np.flip(base,2)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"int8/reverse_columns: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3,5,6,7,8,9,10,11,12},"int8/reverse_columns: result")
eq(result.shape,{11},"int8/reverse_columns: result: shape")
eq(result.strides,{8},"int8/reverse_columns: result: strides")
eq(result.dtype,"int64","int8/reverse_columns: result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8/reverse_columns: backing source")
eq(base.shape,{3,4},"int8/reverse_columns: backing source: shape")
eq(base.strides,{4,1},"int8/reverse_columns: backing source: strides")
eq(base.dtype,"int8","int8/reverse_columns: backing source: dtype")
eq(a.shape,{3,4},"int8/reverse_columns: source shape")
eq(a.strides,{4,-1},"int8/reverse_columns: source strides")
cases=cases+1
end
-- 4: int8/reverse_rows; source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8")
local a=np.flip(base,1)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"int8/reverse_rows: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3,4,5,6,7,8,10,11,12},"int8/reverse_rows: result")
eq(result.shape,{11},"int8/reverse_rows: result: shape")
eq(result.strides,{8},"int8/reverse_rows: result: strides")
eq(result.dtype,"int64","int8/reverse_rows: result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8/reverse_rows: backing source")
eq(base.shape,{3,4},"int8/reverse_rows: backing source: shape")
eq(base.strides,{4,1},"int8/reverse_rows: backing source: strides")
eq(base.dtype,"int8","int8/reverse_rows: backing source: dtype")
eq(a.shape,{3,4},"int8/reverse_rows: source shape")
eq(a.strides,{-4,1},"int8/reverse_rows: source strides")
cases=cases+1
end
-- 5: int8/strided; source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8")
local a=base:get(np.s(),np.s(1,nil,2))
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"int8/strided: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,5,6},"int8/strided: result")
eq(result.shape,{5},"int8/strided: result: shape")
eq(result.strides,{8},"int8/strided: result: strides")
eq(result.dtype,"int64","int8/strided: result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int8/strided: backing source")
eq(base.shape,{3,4},"int8/strided: backing source: shape")
eq(base.strides,{4,1},"int8/strided: backing source: strides")
eq(base.dtype,"int8","int8/strided: backing source: dtype")
eq(a.shape,{3,2},"int8/strided: source shape")
eq(a.strides,{4,2},"int8/strided: source strides")
cases=cases+1
end
-- 6: uint8/plain; source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"uint8/plain: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,5,6,7,8,9,10,11,12},"uint8/plain: result")
eq(result.shape,{11},"uint8/plain: result: shape")
eq(result.strides,{8},"uint8/plain: result: strides")
eq(result.dtype,"int64","uint8/plain: result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8/plain: backing source")
eq(base.shape,{3,4},"uint8/plain: backing source: shape")
eq(base.strides,{4,1},"uint8/plain: backing source: strides")
eq(base.dtype,"uint8","uint8/plain: backing source: dtype")
eq(a.shape,{3,4},"uint8/plain: source shape")
eq(a.strides,{4,1},"uint8/plain: source strides")
cases=cases+1
end
-- 7: uint8/transpose; source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8")
local a=np.transpose(base)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"uint8/transpose: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,5,6,7,8,9,10,11,12},"uint8/transpose: result")
eq(result.shape,{11},"uint8/transpose: result: shape")
eq(result.strides,{8},"uint8/transpose: result: strides")
eq(result.dtype,"int64","uint8/transpose: result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8/transpose: backing source")
eq(base.shape,{3,4},"uint8/transpose: backing source: shape")
eq(base.strides,{4,1},"uint8/transpose: backing source: strides")
eq(base.dtype,"uint8","uint8/transpose: backing source: dtype")
eq(a.shape,{4,3},"uint8/transpose: source shape")
eq(a.strides,{1,4},"uint8/transpose: source strides")
cases=cases+1
end
-- 8: uint8/reverse_columns; source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8")
local a=np.flip(base,2)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"uint8/reverse_columns: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3,5,6,7,8,9,10,11,12},"uint8/reverse_columns: result")
eq(result.shape,{11},"uint8/reverse_columns: result: shape")
eq(result.strides,{8},"uint8/reverse_columns: result: strides")
eq(result.dtype,"int64","uint8/reverse_columns: result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8/reverse_columns: backing source")
eq(base.shape,{3,4},"uint8/reverse_columns: backing source: shape")
eq(base.strides,{4,1},"uint8/reverse_columns: backing source: strides")
eq(base.dtype,"uint8","uint8/reverse_columns: backing source: dtype")
eq(a.shape,{3,4},"uint8/reverse_columns: source shape")
eq(a.strides,{4,-1},"uint8/reverse_columns: source strides")
cases=cases+1
end
-- 9: uint8/reverse_rows; source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8")
local a=np.flip(base,1)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"uint8/reverse_rows: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3,4,5,6,7,8,10,11,12},"uint8/reverse_rows: result")
eq(result.shape,{11},"uint8/reverse_rows: result: shape")
eq(result.strides,{8},"uint8/reverse_rows: result: strides")
eq(result.dtype,"int64","uint8/reverse_rows: result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8/reverse_rows: backing source")
eq(base.shape,{3,4},"uint8/reverse_rows: backing source: shape")
eq(base.strides,{4,1},"uint8/reverse_rows: backing source: strides")
eq(base.dtype,"uint8","uint8/reverse_rows: backing source: dtype")
eq(a.shape,{3,4},"uint8/reverse_rows: source shape")
eq(a.strides,{-4,1},"uint8/reverse_rows: source strides")
cases=cases+1
end
-- 10: uint8/strided; source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8")
local a=base:get(np.s(),np.s(1,nil,2))
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"uint8/strided: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,5,6},"uint8/strided: result")
eq(result.shape,{5},"uint8/strided: result: shape")
eq(result.strides,{8},"uint8/strided: result: strides")
eq(result.dtype,"int64","uint8/strided: result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint8/strided: backing source")
eq(base.shape,{3,4},"uint8/strided: backing source: shape")
eq(base.strides,{4,1},"uint8/strided: backing source: strides")
eq(base.dtype,"uint8","uint8/strided: backing source: dtype")
eq(a.shape,{3,2},"uint8/strided: source shape")
eq(a.strides,{4,2},"uint8/strided: source strides")
cases=cases+1
end
-- 11: int16/plain; source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"int16/plain: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,5,6,7,8,9,10,11,12},"int16/plain: result")
eq(result.shape,{11},"int16/plain: result: shape")
eq(result.strides,{8},"int16/plain: result: strides")
eq(result.dtype,"int64","int16/plain: result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16/plain: backing source")
eq(base.shape,{3,4},"int16/plain: backing source: shape")
eq(base.strides,{8,2},"int16/plain: backing source: strides")
eq(base.dtype,"int16","int16/plain: backing source: dtype")
eq(a.shape,{3,4},"int16/plain: source shape")
eq(a.strides,{8,2},"int16/plain: source strides")
cases=cases+1
end
-- 12: int16/transpose; source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16")
local a=np.transpose(base)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"int16/transpose: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,5,6,7,8,9,10,11,12},"int16/transpose: result")
eq(result.shape,{11},"int16/transpose: result: shape")
eq(result.strides,{8},"int16/transpose: result: strides")
eq(result.dtype,"int64","int16/transpose: result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16/transpose: backing source")
eq(base.shape,{3,4},"int16/transpose: backing source: shape")
eq(base.strides,{8,2},"int16/transpose: backing source: strides")
eq(base.dtype,"int16","int16/transpose: backing source: dtype")
eq(a.shape,{4,3},"int16/transpose: source shape")
eq(a.strides,{2,8},"int16/transpose: source strides")
cases=cases+1
end
-- 13: int16/reverse_columns; source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16")
local a=np.flip(base,2)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"int16/reverse_columns: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3,5,6,7,8,9,10,11,12},"int16/reverse_columns: result")
eq(result.shape,{11},"int16/reverse_columns: result: shape")
eq(result.strides,{8},"int16/reverse_columns: result: strides")
eq(result.dtype,"int64","int16/reverse_columns: result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16/reverse_columns: backing source")
eq(base.shape,{3,4},"int16/reverse_columns: backing source: shape")
eq(base.strides,{8,2},"int16/reverse_columns: backing source: strides")
eq(base.dtype,"int16","int16/reverse_columns: backing source: dtype")
eq(a.shape,{3,4},"int16/reverse_columns: source shape")
eq(a.strides,{8,-2},"int16/reverse_columns: source strides")
cases=cases+1
end
-- 14: int16/reverse_rows; source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16")
local a=np.flip(base,1)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"int16/reverse_rows: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3,4,5,6,7,8,10,11,12},"int16/reverse_rows: result")
eq(result.shape,{11},"int16/reverse_rows: result: shape")
eq(result.strides,{8},"int16/reverse_rows: result: strides")
eq(result.dtype,"int64","int16/reverse_rows: result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16/reverse_rows: backing source")
eq(base.shape,{3,4},"int16/reverse_rows: backing source: shape")
eq(base.strides,{8,2},"int16/reverse_rows: backing source: strides")
eq(base.dtype,"int16","int16/reverse_rows: backing source: dtype")
eq(a.shape,{3,4},"int16/reverse_rows: source shape")
eq(a.strides,{-8,2},"int16/reverse_rows: source strides")
cases=cases+1
end
-- 15: int16/strided; source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16")
local a=base:get(np.s(),np.s(1,nil,2))
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"int16/strided: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,5,6},"int16/strided: result")
eq(result.shape,{5},"int16/strided: result: shape")
eq(result.strides,{8},"int16/strided: result: strides")
eq(result.dtype,"int64","int16/strided: result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int16/strided: backing source")
eq(base.shape,{3,4},"int16/strided: backing source: shape")
eq(base.strides,{8,2},"int16/strided: backing source: strides")
eq(base.dtype,"int16","int16/strided: backing source: dtype")
eq(a.shape,{3,2},"int16/strided: source shape")
eq(a.strides,{8,4},"int16/strided: source strides")
cases=cases+1
end
-- 16: uint32/plain; source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"uint32/plain: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,5,6,7,8,9,10,11,12},"uint32/plain: result")
eq(result.shape,{11},"uint32/plain: result: shape")
eq(result.strides,{8},"uint32/plain: result: strides")
eq(result.dtype,"int64","uint32/plain: result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32/plain: backing source")
eq(base.shape,{3,4},"uint32/plain: backing source: shape")
eq(base.strides,{16,4},"uint32/plain: backing source: strides")
eq(base.dtype,"uint32","uint32/plain: backing source: dtype")
eq(a.shape,{3,4},"uint32/plain: source shape")
eq(a.strides,{16,4},"uint32/plain: source strides")
cases=cases+1
end
-- 17: uint32/transpose; source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32")
local a=np.transpose(base)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"uint32/transpose: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,5,6,7,8,9,10,11,12},"uint32/transpose: result")
eq(result.shape,{11},"uint32/transpose: result: shape")
eq(result.strides,{8},"uint32/transpose: result: strides")
eq(result.dtype,"int64","uint32/transpose: result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32/transpose: backing source")
eq(base.shape,{3,4},"uint32/transpose: backing source: shape")
eq(base.strides,{16,4},"uint32/transpose: backing source: strides")
eq(base.dtype,"uint32","uint32/transpose: backing source: dtype")
eq(a.shape,{4,3},"uint32/transpose: source shape")
eq(a.strides,{4,16},"uint32/transpose: source strides")
cases=cases+1
end
-- 18: uint32/reverse_columns; source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32")
local a=np.flip(base,2)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"uint32/reverse_columns: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3,5,6,7,8,9,10,11,12},"uint32/reverse_columns: result")
eq(result.shape,{11},"uint32/reverse_columns: result: shape")
eq(result.strides,{8},"uint32/reverse_columns: result: strides")
eq(result.dtype,"int64","uint32/reverse_columns: result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32/reverse_columns: backing source")
eq(base.shape,{3,4},"uint32/reverse_columns: backing source: shape")
eq(base.strides,{16,4},"uint32/reverse_columns: backing source: strides")
eq(base.dtype,"uint32","uint32/reverse_columns: backing source: dtype")
eq(a.shape,{3,4},"uint32/reverse_columns: source shape")
eq(a.strides,{16,-4},"uint32/reverse_columns: source strides")
cases=cases+1
end
-- 19: uint32/reverse_rows; source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32")
local a=np.flip(base,1)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"uint32/reverse_rows: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3,4,5,6,7,8,10,11,12},"uint32/reverse_rows: result")
eq(result.shape,{11},"uint32/reverse_rows: result: shape")
eq(result.strides,{8},"uint32/reverse_rows: result: strides")
eq(result.dtype,"int64","uint32/reverse_rows: result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32/reverse_rows: backing source")
eq(base.shape,{3,4},"uint32/reverse_rows: backing source: shape")
eq(base.strides,{16,4},"uint32/reverse_rows: backing source: strides")
eq(base.dtype,"uint32","uint32/reverse_rows: backing source: dtype")
eq(a.shape,{3,4},"uint32/reverse_rows: source shape")
eq(a.strides,{-16,4},"uint32/reverse_rows: source strides")
cases=cases+1
end
-- 20: uint32/strided; source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32")
local a=base:get(np.s(),np.s(1,nil,2))
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"uint32/strided: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,5,6},"uint32/strided: result")
eq(result.shape,{5},"uint32/strided: result: shape")
eq(result.strides,{8},"uint32/strided: result: strides")
eq(result.dtype,"int64","uint32/strided: result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint32/strided: backing source")
eq(base.shape,{3,4},"uint32/strided: backing source: shape")
eq(base.strides,{16,4},"uint32/strided: backing source: strides")
eq(base.dtype,"uint32","uint32/strided: backing source: dtype")
eq(a.shape,{3,2},"uint32/strided: source shape")
eq(a.strides,{16,8},"uint32/strided: source strides")
cases=cases+1
end
-- 21: int64/plain; source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"int64/plain: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,5,6,7,8,9,10,11,12},"int64/plain: result")
eq(result.shape,{11},"int64/plain: result: shape")
eq(result.strides,{8},"int64/plain: result: strides")
eq(result.dtype,"int64","int64/plain: result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64/plain: backing source")
eq(base.shape,{3,4},"int64/plain: backing source: shape")
eq(base.strides,{32,8},"int64/plain: backing source: strides")
eq(base.dtype,"int64","int64/plain: backing source: dtype")
eq(a.shape,{3,4},"int64/plain: source shape")
eq(a.strides,{32,8},"int64/plain: source strides")
cases=cases+1
end
-- 22: int64/transpose; source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64")
local a=np.transpose(base)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"int64/transpose: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,5,6,7,8,9,10,11,12},"int64/transpose: result")
eq(result.shape,{11},"int64/transpose: result: shape")
eq(result.strides,{8},"int64/transpose: result: strides")
eq(result.dtype,"int64","int64/transpose: result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64/transpose: backing source")
eq(base.shape,{3,4},"int64/transpose: backing source: shape")
eq(base.strides,{32,8},"int64/transpose: backing source: strides")
eq(base.dtype,"int64","int64/transpose: backing source: dtype")
eq(a.shape,{4,3},"int64/transpose: source shape")
eq(a.strides,{8,32},"int64/transpose: source strides")
cases=cases+1
end
-- 23: int64/reverse_columns; source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64")
local a=np.flip(base,2)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"int64/reverse_columns: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3,5,6,7,8,9,10,11,12},"int64/reverse_columns: result")
eq(result.shape,{11},"int64/reverse_columns: result: shape")
eq(result.strides,{8},"int64/reverse_columns: result: strides")
eq(result.dtype,"int64","int64/reverse_columns: result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64/reverse_columns: backing source")
eq(base.shape,{3,4},"int64/reverse_columns: backing source: shape")
eq(base.strides,{32,8},"int64/reverse_columns: backing source: strides")
eq(base.dtype,"int64","int64/reverse_columns: backing source: dtype")
eq(a.shape,{3,4},"int64/reverse_columns: source shape")
eq(a.strides,{32,-8},"int64/reverse_columns: source strides")
cases=cases+1
end
-- 24: int64/reverse_rows; source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64")
local a=np.flip(base,1)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"int64/reverse_rows: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3,4,5,6,7,8,10,11,12},"int64/reverse_rows: result")
eq(result.shape,{11},"int64/reverse_rows: result: shape")
eq(result.strides,{8},"int64/reverse_rows: result: strides")
eq(result.dtype,"int64","int64/reverse_rows: result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64/reverse_rows: backing source")
eq(base.shape,{3,4},"int64/reverse_rows: backing source: shape")
eq(base.strides,{32,8},"int64/reverse_rows: backing source: strides")
eq(base.dtype,"int64","int64/reverse_rows: backing source: dtype")
eq(a.shape,{3,4},"int64/reverse_rows: source shape")
eq(a.strides,{-32,8},"int64/reverse_rows: source strides")
cases=cases+1
end
-- 25: int64/strided; source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64")
local a=base:get(np.s(),np.s(1,nil,2))
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"int64/strided: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,5,6},"int64/strided: result")
eq(result.shape,{5},"int64/strided: result: shape")
eq(result.strides,{8},"int64/strided: result: strides")
eq(result.dtype,"int64","int64/strided: result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int64/strided: backing source")
eq(base.shape,{3,4},"int64/strided: backing source: shape")
eq(base.strides,{32,8},"int64/strided: backing source: strides")
eq(base.dtype,"int64","int64/strided: backing source: dtype")
eq(a.shape,{3,2},"int64/strided: source shape")
eq(a.strides,{32,16},"int64/strided: source strides")
cases=cases+1
end
-- 26: uint64/plain; source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"uint64/plain: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,5,6,7,8,9,10,11,12},"uint64/plain: result")
eq(result.shape,{11},"uint64/plain: result: shape")
eq(result.strides,{8},"uint64/plain: result: strides")
eq(result.dtype,"int64","uint64/plain: result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64/plain: backing source")
eq(base.shape,{3,4},"uint64/plain: backing source: shape")
eq(base.strides,{32,8},"uint64/plain: backing source: strides")
eq(base.dtype,"uint64","uint64/plain: backing source: dtype")
eq(a.shape,{3,4},"uint64/plain: source shape")
eq(a.strides,{32,8},"uint64/plain: source strides")
cases=cases+1
end
-- 27: uint64/transpose; source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64")
local a=np.transpose(base)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"uint64/transpose: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,5,6,7,8,9,10,11,12},"uint64/transpose: result")
eq(result.shape,{11},"uint64/transpose: result: shape")
eq(result.strides,{8},"uint64/transpose: result: strides")
eq(result.dtype,"int64","uint64/transpose: result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64/transpose: backing source")
eq(base.shape,{3,4},"uint64/transpose: backing source: shape")
eq(base.strides,{32,8},"uint64/transpose: backing source: strides")
eq(base.dtype,"uint64","uint64/transpose: backing source: dtype")
eq(a.shape,{4,3},"uint64/transpose: source shape")
eq(a.strides,{8,32},"uint64/transpose: source strides")
cases=cases+1
end
-- 28: uint64/reverse_columns; source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64")
local a=np.flip(base,2)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"uint64/reverse_columns: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3,5,6,7,8,9,10,11,12},"uint64/reverse_columns: result")
eq(result.shape,{11},"uint64/reverse_columns: result: shape")
eq(result.strides,{8},"uint64/reverse_columns: result: strides")
eq(result.dtype,"int64","uint64/reverse_columns: result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64/reverse_columns: backing source")
eq(base.shape,{3,4},"uint64/reverse_columns: backing source: shape")
eq(base.strides,{32,8},"uint64/reverse_columns: backing source: strides")
eq(base.dtype,"uint64","uint64/reverse_columns: backing source: dtype")
eq(a.shape,{3,4},"uint64/reverse_columns: source shape")
eq(a.strides,{32,-8},"uint64/reverse_columns: source strides")
cases=cases+1
end
-- 29: uint64/reverse_rows; source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64")
local a=np.flip(base,1)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"uint64/reverse_rows: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3,4,5,6,7,8,10,11,12},"uint64/reverse_rows: result")
eq(result.shape,{11},"uint64/reverse_rows: result: shape")
eq(result.strides,{8},"uint64/reverse_rows: result: strides")
eq(result.dtype,"int64","uint64/reverse_rows: result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64/reverse_rows: backing source")
eq(base.shape,{3,4},"uint64/reverse_rows: backing source: shape")
eq(base.strides,{32,8},"uint64/reverse_rows: backing source: strides")
eq(base.dtype,"uint64","uint64/reverse_rows: backing source: dtype")
eq(a.shape,{3,4},"uint64/reverse_rows: source shape")
eq(a.strides,{-32,8},"uint64/reverse_rows: source strides")
cases=cases+1
end
-- 30: uint64/strided; source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64")
local a=base:get(np.s(),np.s(1,nil,2))
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"uint64/strided: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,5,6},"uint64/strided: result")
eq(result.shape,{5},"uint64/strided: result: shape")
eq(result.strides,{8},"uint64/strided: result: strides")
eq(result.dtype,"int64","uint64/strided: result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"uint64/strided: backing source")
eq(base.shape,{3,4},"uint64/strided: backing source: shape")
eq(base.strides,{32,8},"uint64/strided: backing source: strides")
eq(base.dtype,"uint64","uint64/strided: backing source: dtype")
eq(a.shape,{3,2},"uint64/strided: source shape")
eq(a.strides,{32,16},"uint64/strided: source strides")
cases=cases+1
end
-- 31: float16/plain; source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"float16/plain: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,5,6,7,8,9,10,11,12},"float16/plain: result")
eq(result.shape,{11},"float16/plain: result: shape")
eq(result.strides,{8},"float16/plain: result: strides")
eq(result.dtype,"int64","float16/plain: result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16/plain: backing source")
eq(base.shape,{3,4},"float16/plain: backing source: shape")
eq(base.strides,{8,2},"float16/plain: backing source: strides")
eq(base.dtype,"float16","float16/plain: backing source: dtype")
eq(a.shape,{3,4},"float16/plain: source shape")
eq(a.strides,{8,2},"float16/plain: source strides")
cases=cases+1
end
-- 32: float16/transpose; source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16")
local a=np.transpose(base)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"float16/transpose: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,5,6,7,8,9,10,11,12},"float16/transpose: result")
eq(result.shape,{11},"float16/transpose: result: shape")
eq(result.strides,{8},"float16/transpose: result: strides")
eq(result.dtype,"int64","float16/transpose: result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16/transpose: backing source")
eq(base.shape,{3,4},"float16/transpose: backing source: shape")
eq(base.strides,{8,2},"float16/transpose: backing source: strides")
eq(base.dtype,"float16","float16/transpose: backing source: dtype")
eq(a.shape,{4,3},"float16/transpose: source shape")
eq(a.strides,{2,8},"float16/transpose: source strides")
cases=cases+1
end
-- 33: float16/reverse_columns; source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16")
local a=np.flip(base,2)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"float16/reverse_columns: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3,5,6,7,8,9,10,11,12},"float16/reverse_columns: result")
eq(result.shape,{11},"float16/reverse_columns: result: shape")
eq(result.strides,{8},"float16/reverse_columns: result: strides")
eq(result.dtype,"int64","float16/reverse_columns: result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16/reverse_columns: backing source")
eq(base.shape,{3,4},"float16/reverse_columns: backing source: shape")
eq(base.strides,{8,2},"float16/reverse_columns: backing source: strides")
eq(base.dtype,"float16","float16/reverse_columns: backing source: dtype")
eq(a.shape,{3,4},"float16/reverse_columns: source shape")
eq(a.strides,{8,-2},"float16/reverse_columns: source strides")
cases=cases+1
end
-- 34: float16/reverse_rows; source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16")
local a=np.flip(base,1)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"float16/reverse_rows: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3,4,5,6,7,8,10,11,12},"float16/reverse_rows: result")
eq(result.shape,{11},"float16/reverse_rows: result: shape")
eq(result.strides,{8},"float16/reverse_rows: result: strides")
eq(result.dtype,"int64","float16/reverse_rows: result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16/reverse_rows: backing source")
eq(base.shape,{3,4},"float16/reverse_rows: backing source: shape")
eq(base.strides,{8,2},"float16/reverse_rows: backing source: strides")
eq(base.dtype,"float16","float16/reverse_rows: backing source: dtype")
eq(a.shape,{3,4},"float16/reverse_rows: source shape")
eq(a.strides,{-8,2},"float16/reverse_rows: source strides")
cases=cases+1
end
-- 35: float16/strided; source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16")
local a=base:get(np.s(),np.s(1,nil,2))
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"float16/strided: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,5,6},"float16/strided: result")
eq(result.shape,{5},"float16/strided: result: shape")
eq(result.strides,{8},"float16/strided: result: strides")
eq(result.dtype,"int64","float16/strided: result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float16/strided: backing source")
eq(base.shape,{3,4},"float16/strided: backing source: shape")
eq(base.strides,{8,2},"float16/strided: backing source: strides")
eq(base.dtype,"float16","float16/strided: backing source: dtype")
eq(a.shape,{3,2},"float16/strided: source shape")
eq(a.strides,{8,4},"float16/strided: source strides")
cases=cases+1
end
-- 36: float32/plain; source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"float32/plain: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,5,6,7,8,9,10,11,12},"float32/plain: result")
eq(result.shape,{11},"float32/plain: result: shape")
eq(result.strides,{8},"float32/plain: result: strides")
eq(result.dtype,"int64","float32/plain: result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32/plain: backing source")
eq(base.shape,{3,4},"float32/plain: backing source: shape")
eq(base.strides,{16,4},"float32/plain: backing source: strides")
eq(base.dtype,"float32","float32/plain: backing source: dtype")
eq(a.shape,{3,4},"float32/plain: source shape")
eq(a.strides,{16,4},"float32/plain: source strides")
cases=cases+1
end
-- 37: float32/transpose; source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32")
local a=np.transpose(base)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"float32/transpose: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,5,6,7,8,9,10,11,12},"float32/transpose: result")
eq(result.shape,{11},"float32/transpose: result: shape")
eq(result.strides,{8},"float32/transpose: result: strides")
eq(result.dtype,"int64","float32/transpose: result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32/transpose: backing source")
eq(base.shape,{3,4},"float32/transpose: backing source: shape")
eq(base.strides,{16,4},"float32/transpose: backing source: strides")
eq(base.dtype,"float32","float32/transpose: backing source: dtype")
eq(a.shape,{4,3},"float32/transpose: source shape")
eq(a.strides,{4,16},"float32/transpose: source strides")
cases=cases+1
end
-- 38: float32/reverse_columns; source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32")
local a=np.flip(base,2)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"float32/reverse_columns: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3,5,6,7,8,9,10,11,12},"float32/reverse_columns: result")
eq(result.shape,{11},"float32/reverse_columns: result: shape")
eq(result.strides,{8},"float32/reverse_columns: result: strides")
eq(result.dtype,"int64","float32/reverse_columns: result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32/reverse_columns: backing source")
eq(base.shape,{3,4},"float32/reverse_columns: backing source: shape")
eq(base.strides,{16,4},"float32/reverse_columns: backing source: strides")
eq(base.dtype,"float32","float32/reverse_columns: backing source: dtype")
eq(a.shape,{3,4},"float32/reverse_columns: source shape")
eq(a.strides,{16,-4},"float32/reverse_columns: source strides")
cases=cases+1
end
-- 39: float32/reverse_rows; source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32")
local a=np.flip(base,1)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"float32/reverse_rows: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3,4,5,6,7,8,10,11,12},"float32/reverse_rows: result")
eq(result.shape,{11},"float32/reverse_rows: result: shape")
eq(result.strides,{8},"float32/reverse_rows: result: strides")
eq(result.dtype,"int64","float32/reverse_rows: result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32/reverse_rows: backing source")
eq(base.shape,{3,4},"float32/reverse_rows: backing source: shape")
eq(base.strides,{16,4},"float32/reverse_rows: backing source: strides")
eq(base.dtype,"float32","float32/reverse_rows: backing source: dtype")
eq(a.shape,{3,4},"float32/reverse_rows: source shape")
eq(a.strides,{-16,4},"float32/reverse_rows: source strides")
cases=cases+1
end
-- 40: float32/strided; source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32")
local a=base:get(np.s(),np.s(1,nil,2))
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"float32/strided: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,5,6},"float32/strided: result")
eq(result.shape,{5},"float32/strided: result: shape")
eq(result.strides,{8},"float32/strided: result: strides")
eq(result.dtype,"int64","float32/strided: result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32/strided: backing source")
eq(base.shape,{3,4},"float32/strided: backing source: shape")
eq(base.strides,{16,4},"float32/strided: backing source: strides")
eq(base.dtype,"float32","float32/strided: backing source: dtype")
eq(a.shape,{3,2},"float32/strided: source shape")
eq(a.strides,{16,8},"float32/strided: source strides")
cases=cases+1
end
-- 41: float64/plain; source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"float64/plain: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,5,6,7,8,9,10,11,12},"float64/plain: result")
eq(result.shape,{11},"float64/plain: result: shape")
eq(result.strides,{8},"float64/plain: result: strides")
eq(result.dtype,"int64","float64/plain: result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64/plain: backing source")
eq(base.shape,{3,4},"float64/plain: backing source: shape")
eq(base.strides,{32,8},"float64/plain: backing source: strides")
eq(base.dtype,"float64","float64/plain: backing source: dtype")
eq(a.shape,{3,4},"float64/plain: source shape")
eq(a.strides,{32,8},"float64/plain: source strides")
cases=cases+1
end
-- 42: float64/transpose; source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64")
local a=np.transpose(base)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"float64/transpose: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,5,6,7,8,9,10,11,12},"float64/transpose: result")
eq(result.shape,{11},"float64/transpose: result: shape")
eq(result.strides,{8},"float64/transpose: result: strides")
eq(result.dtype,"int64","float64/transpose: result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64/transpose: backing source")
eq(base.shape,{3,4},"float64/transpose: backing source: shape")
eq(base.strides,{32,8},"float64/transpose: backing source: strides")
eq(base.dtype,"float64","float64/transpose: backing source: dtype")
eq(a.shape,{4,3},"float64/transpose: source shape")
eq(a.strides,{8,32},"float64/transpose: source strides")
cases=cases+1
end
-- 43: float64/reverse_columns; source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64")
local a=np.flip(base,2)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"float64/reverse_columns: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3,5,6,7,8,9,10,11,12},"float64/reverse_columns: result")
eq(result.shape,{11},"float64/reverse_columns: result: shape")
eq(result.strides,{8},"float64/reverse_columns: result: strides")
eq(result.dtype,"int64","float64/reverse_columns: result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64/reverse_columns: backing source")
eq(base.shape,{3,4},"float64/reverse_columns: backing source: shape")
eq(base.strides,{32,8},"float64/reverse_columns: backing source: strides")
eq(base.dtype,"float64","float64/reverse_columns: backing source: dtype")
eq(a.shape,{3,4},"float64/reverse_columns: source shape")
eq(a.strides,{32,-8},"float64/reverse_columns: source strides")
cases=cases+1
end
-- 44: float64/reverse_rows; source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64")
local a=np.flip(base,1)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"float64/reverse_rows: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3,4,5,6,7,8,10,11,12},"float64/reverse_rows: result")
eq(result.shape,{11},"float64/reverse_rows: result: shape")
eq(result.strides,{8},"float64/reverse_rows: result: strides")
eq(result.dtype,"int64","float64/reverse_rows: result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64/reverse_rows: backing source")
eq(base.shape,{3,4},"float64/reverse_rows: backing source: shape")
eq(base.strides,{32,8},"float64/reverse_rows: backing source: strides")
eq(base.dtype,"float64","float64/reverse_rows: backing source: dtype")
eq(a.shape,{3,4},"float64/reverse_rows: source shape")
eq(a.strides,{-32,8},"float64/reverse_rows: source strides")
cases=cases+1
end
-- 45: float64/strided; source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64")
local a=base:get(np.s(),np.s(1,nil,2))
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"float64/strided: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,5,6},"float64/strided: result")
eq(result.shape,{5},"float64/strided: result: shape")
eq(result.strides,{8},"float64/strided: result: strides")
eq(result.dtype,"int64","float64/strided: result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float64/strided: backing source")
eq(base.shape,{3,4},"float64/strided: backing source: shape")
eq(base.strides,{32,8},"float64/strided: backing source: strides")
eq(base.dtype,"float64","float64/strided: backing source: dtype")
eq(a.shape,{3,2},"float64/strided: source shape")
eq(a.strides,{32,16},"float64/strided: source strides")
cases=cases+1
end
-- 46: bool/plain; source error=None
do
local base=np.array({{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"bool/plain: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,4,6,8,10,12},"bool/plain: result")
eq(result.shape,{6},"bool/plain: result: shape")
eq(result.strides,{8},"bool/plain: result: strides")
eq(result.dtype,"int64","bool/plain: result: dtype")
eq(base:tolist(),{{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool/plain: backing source")
eq(base.shape,{3,4},"bool/plain: backing source: shape")
eq(base.strides,{4,1},"bool/plain: backing source: strides")
eq(base.dtype,"bool","bool/plain: backing source: dtype")
eq(a.shape,{3,4},"bool/plain: source shape")
eq(a.strides,{4,1},"bool/plain: source strides")
cases=cases+1
end
-- 47: bool/transpose; source error=None
do
local base=np.array({{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool")
local a=np.transpose(base)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"bool/transpose: acceptance"..": "..tostring(result))
eq(result:tolist(),{4,5,6,10,11,12},"bool/transpose: result")
eq(result.shape,{6},"bool/transpose: result: shape")
eq(result.strides,{8},"bool/transpose: result: strides")
eq(result.dtype,"int64","bool/transpose: result: dtype")
eq(base:tolist(),{{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool/transpose: backing source")
eq(base.shape,{3,4},"bool/transpose: backing source: shape")
eq(base.strides,{4,1},"bool/transpose: backing source: strides")
eq(base.dtype,"bool","bool/transpose: backing source: dtype")
eq(a.shape,{4,3},"bool/transpose: source shape")
eq(a.strides,{1,4},"bool/transpose: source strides")
cases=cases+1
end
-- 48: bool/reverse_columns; source error=None
do
local base=np.array({{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool")
local a=np.flip(base,2)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"bool/reverse_columns: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,3,5,7,9,11},"bool/reverse_columns: result")
eq(result.shape,{6},"bool/reverse_columns: result: shape")
eq(result.strides,{8},"bool/reverse_columns: result: strides")
eq(result.dtype,"int64","bool/reverse_columns: result: dtype")
eq(base:tolist(),{{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool/reverse_columns: backing source")
eq(base.shape,{3,4},"bool/reverse_columns: backing source: shape")
eq(base.strides,{4,1},"bool/reverse_columns: backing source: strides")
eq(base.dtype,"bool","bool/reverse_columns: backing source: dtype")
eq(a.shape,{3,4},"bool/reverse_columns: source shape")
eq(a.strides,{4,-1},"bool/reverse_columns: source strides")
cases=cases+1
end
-- 49: bool/reverse_rows; source error=None
do
local base=np.array({{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool")
local a=np.flip(base,1)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"bool/reverse_rows: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,4,6,8,10,12},"bool/reverse_rows: result")
eq(result.shape,{6},"bool/reverse_rows: result: shape")
eq(result.strides,{8},"bool/reverse_rows: result: strides")
eq(result.dtype,"int64","bool/reverse_rows: result: dtype")
eq(base:tolist(),{{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool/reverse_rows: backing source")
eq(base.shape,{3,4},"bool/reverse_rows: backing source: shape")
eq(base.strides,{4,1},"bool/reverse_rows: backing source: strides")
eq(base.dtype,"bool","bool/reverse_rows: backing source: dtype")
eq(a.shape,{3,4},"bool/reverse_rows: source shape")
eq(a.strides,{-4,1},"bool/reverse_rows: source strides")
cases=cases+1
end
-- 50: bool/strided; source error=None
do
local base=np.array({{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool")
local a=base:get(np.s(),np.s(1,nil,2))
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"bool/strided: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"bool/strided: result")
eq(result.shape,{0},"bool/strided: result: shape")
eq(result.strides,{8},"bool/strided: result: strides")
eq(result.dtype,"int64","bool/strided: result: dtype")
eq(base:tolist(),{{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool/strided: backing source")
eq(base.shape,{3,4},"bool/strided: backing source: shape")
eq(base.strides,{4,1},"bool/strided: backing source: strides")
eq(base.dtype,"bool","bool/strided: backing source: dtype")
eq(a.shape,{3,2},"bool/strided: source shape")
eq(a.strides,{4,2},"bool/strided: source strides")
cases=cases+1
end
-- 51: complex64/plain; source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"complex64/plain: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,5,6,7,8,9,10,11,12},"complex64/plain: result")
eq(result.shape,{11},"complex64/plain: result: shape")
eq(result.strides,{8},"complex64/plain: result: strides")
eq(result.dtype,"int64","complex64/plain: result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64/plain: backing source")
eq(base.shape,{3,4},"complex64/plain: backing source: shape")
eq(base.strides,{32,8},"complex64/plain: backing source: strides")
eq(base.dtype,"complex64","complex64/plain: backing source: dtype")
eq(a.shape,{3,4},"complex64/plain: source shape")
eq(a.strides,{32,8},"complex64/plain: source strides")
cases=cases+1
end
-- 52: complex64/transpose; source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64")
local a=np.transpose(base)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"complex64/transpose: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,5,6,7,8,9,10,11,12},"complex64/transpose: result")
eq(result.shape,{11},"complex64/transpose: result: shape")
eq(result.strides,{8},"complex64/transpose: result: strides")
eq(result.dtype,"int64","complex64/transpose: result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64/transpose: backing source")
eq(base.shape,{3,4},"complex64/transpose: backing source: shape")
eq(base.strides,{32,8},"complex64/transpose: backing source: strides")
eq(base.dtype,"complex64","complex64/transpose: backing source: dtype")
eq(a.shape,{4,3},"complex64/transpose: source shape")
eq(a.strides,{8,32},"complex64/transpose: source strides")
cases=cases+1
end
-- 53: complex64/reverse_columns; source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64")
local a=np.flip(base,2)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"complex64/reverse_columns: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3,5,6,7,8,9,10,11,12},"complex64/reverse_columns: result")
eq(result.shape,{11},"complex64/reverse_columns: result: shape")
eq(result.strides,{8},"complex64/reverse_columns: result: strides")
eq(result.dtype,"int64","complex64/reverse_columns: result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64/reverse_columns: backing source")
eq(base.shape,{3,4},"complex64/reverse_columns: backing source: shape")
eq(base.strides,{32,8},"complex64/reverse_columns: backing source: strides")
eq(base.dtype,"complex64","complex64/reverse_columns: backing source: dtype")
eq(a.shape,{3,4},"complex64/reverse_columns: source shape")
eq(a.strides,{32,-8},"complex64/reverse_columns: source strides")
cases=cases+1
end
-- 54: complex64/reverse_rows; source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64")
local a=np.flip(base,1)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"complex64/reverse_rows: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3,4,5,6,7,8,10,11,12},"complex64/reverse_rows: result")
eq(result.shape,{11},"complex64/reverse_rows: result: shape")
eq(result.strides,{8},"complex64/reverse_rows: result: strides")
eq(result.dtype,"int64","complex64/reverse_rows: result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64/reverse_rows: backing source")
eq(base.shape,{3,4},"complex64/reverse_rows: backing source: shape")
eq(base.strides,{32,8},"complex64/reverse_rows: backing source: strides")
eq(base.dtype,"complex64","complex64/reverse_rows: backing source: dtype")
eq(a.shape,{3,4},"complex64/reverse_rows: source shape")
eq(a.strides,{-32,8},"complex64/reverse_rows: source strides")
cases=cases+1
end
-- 55: complex64/strided; source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64")
local a=base:get(np.s(),np.s(1,nil,2))
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"complex64/strided: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,5,6},"complex64/strided: result")
eq(result.shape,{5},"complex64/strided: result: shape")
eq(result.strides,{8},"complex64/strided: result: strides")
eq(result.dtype,"int64","complex64/strided: result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex64/strided: backing source")
eq(base.shape,{3,4},"complex64/strided: backing source: shape")
eq(base.strides,{32,8},"complex64/strided: backing source: strides")
eq(base.dtype,"complex64","complex64/strided: backing source: dtype")
eq(a.shape,{3,2},"complex64/strided: source shape")
eq(a.strides,{32,16},"complex64/strided: source strides")
cases=cases+1
end
-- 56: complex128/plain; source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"complex128/plain: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,5,6,7,8,9,10,11,12},"complex128/plain: result")
eq(result.shape,{11},"complex128/plain: result: shape")
eq(result.strides,{8},"complex128/plain: result: strides")
eq(result.dtype,"int64","complex128/plain: result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128/plain: backing source")
eq(base.shape,{3,4},"complex128/plain: backing source: shape")
eq(base.strides,{64,16},"complex128/plain: backing source: strides")
eq(base.dtype,"complex128","complex128/plain: backing source: dtype")
eq(a.shape,{3,4},"complex128/plain: source shape")
eq(a.strides,{64,16},"complex128/plain: source strides")
cases=cases+1
end
-- 57: complex128/transpose; source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128")
local a=np.transpose(base)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"complex128/transpose: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,5,6,7,8,9,10,11,12},"complex128/transpose: result")
eq(result.shape,{11},"complex128/transpose: result: shape")
eq(result.strides,{8},"complex128/transpose: result: strides")
eq(result.dtype,"int64","complex128/transpose: result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128/transpose: backing source")
eq(base.shape,{3,4},"complex128/transpose: backing source: shape")
eq(base.strides,{64,16},"complex128/transpose: backing source: strides")
eq(base.dtype,"complex128","complex128/transpose: backing source: dtype")
eq(a.shape,{4,3},"complex128/transpose: source shape")
eq(a.strides,{16,64},"complex128/transpose: source strides")
cases=cases+1
end
-- 58: complex128/reverse_columns; source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128")
local a=np.flip(base,2)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"complex128/reverse_columns: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3,5,6,7,8,9,10,11,12},"complex128/reverse_columns: result")
eq(result.shape,{11},"complex128/reverse_columns: result: shape")
eq(result.strides,{8},"complex128/reverse_columns: result: strides")
eq(result.dtype,"int64","complex128/reverse_columns: result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128/reverse_columns: backing source")
eq(base.shape,{3,4},"complex128/reverse_columns: backing source: shape")
eq(base.strides,{64,16},"complex128/reverse_columns: backing source: strides")
eq(base.dtype,"complex128","complex128/reverse_columns: backing source: dtype")
eq(a.shape,{3,4},"complex128/reverse_columns: source shape")
eq(a.strides,{64,-16},"complex128/reverse_columns: source strides")
cases=cases+1
end
-- 59: complex128/reverse_rows; source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128")
local a=np.flip(base,1)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"complex128/reverse_rows: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3,4,5,6,7,8,10,11,12},"complex128/reverse_rows: result")
eq(result.shape,{11},"complex128/reverse_rows: result: shape")
eq(result.strides,{8},"complex128/reverse_rows: result: strides")
eq(result.dtype,"int64","complex128/reverse_rows: result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128/reverse_rows: backing source")
eq(base.shape,{3,4},"complex128/reverse_rows: backing source: shape")
eq(base.strides,{64,16},"complex128/reverse_rows: backing source: strides")
eq(base.dtype,"complex128","complex128/reverse_rows: backing source: dtype")
eq(a.shape,{3,4},"complex128/reverse_rows: source shape")
eq(a.strides,{-64,16},"complex128/reverse_rows: source strides")
cases=cases+1
end
-- 60: complex128/strided; source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128")
local a=base:get(np.s(),np.s(1,nil,2))
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"complex128/strided: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,5,6},"complex128/strided: result")
eq(result.shape,{5},"complex128/strided: result: shape")
eq(result.strides,{8},"complex128/strided: result: strides")
eq(result.dtype,"int64","complex128/strided: result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(7.0,0.0)},{np.complex(8.0,0.0),np.complex(9.0,0.0),np.complex(10.0,0.0),np.complex(11.0,0.0)}},"complex128/strided: backing source")
eq(base.shape,{3,4},"complex128/strided: backing source: shape")
eq(base.strides,{64,16},"complex128/strided: backing source: strides")
eq(base.dtype,"complex128","complex128/strided: backing source: dtype")
eq(a.shape,{3,2},"complex128/strided: source shape")
eq(a.strides,{64,32},"complex128/strided: source strides")
cases=cases+1
end
-- 61: U4/plain; source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"<U4")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"U4/plain: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3,4,5,6,7,8,9,10,11,12},"U4/plain: result")
eq(result.shape,{12},"U4/plain: result: shape")
eq(result.strides,{8},"U4/plain: result: strides")
eq(result.dtype,"int64","U4/plain: result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"U4/plain: backing source")
eq(base.shape,{3,4},"U4/plain: backing source: shape")
eq(base.strides,{64,16},"U4/plain: backing source: strides")
eq(base.dtype,"<U4","U4/plain: backing source: dtype")
eq(a.shape,{3,4},"U4/plain: source shape")
eq(a.strides,{64,16},"U4/plain: source strides")
cases=cases+1
end
-- 62: U4/transpose; source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"<U4")
local a=np.transpose(base)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"U4/transpose: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3,4,5,6,7,8,9,10,11,12},"U4/transpose: result")
eq(result.shape,{12},"U4/transpose: result: shape")
eq(result.strides,{8},"U4/transpose: result: strides")
eq(result.dtype,"int64","U4/transpose: result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"U4/transpose: backing source")
eq(base.shape,{3,4},"U4/transpose: backing source: shape")
eq(base.strides,{64,16},"U4/transpose: backing source: strides")
eq(base.dtype,"<U4","U4/transpose: backing source: dtype")
eq(a.shape,{4,3},"U4/transpose: source shape")
eq(a.strides,{16,64},"U4/transpose: source strides")
cases=cases+1
end
-- 63: U4/reverse_columns; source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"<U4")
local a=np.flip(base,2)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"U4/reverse_columns: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3,4,5,6,7,8,9,10,11,12},"U4/reverse_columns: result")
eq(result.shape,{12},"U4/reverse_columns: result: shape")
eq(result.strides,{8},"U4/reverse_columns: result: strides")
eq(result.dtype,"int64","U4/reverse_columns: result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"U4/reverse_columns: backing source")
eq(base.shape,{3,4},"U4/reverse_columns: backing source: shape")
eq(base.strides,{64,16},"U4/reverse_columns: backing source: strides")
eq(base.dtype,"<U4","U4/reverse_columns: backing source: dtype")
eq(a.shape,{3,4},"U4/reverse_columns: source shape")
eq(a.strides,{64,-16},"U4/reverse_columns: source strides")
cases=cases+1
end
-- 64: U4/reverse_rows; source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"<U4")
local a=np.flip(base,1)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"U4/reverse_rows: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3,4,5,6,7,8,9,10,11,12},"U4/reverse_rows: result")
eq(result.shape,{12},"U4/reverse_rows: result: shape")
eq(result.strides,{8},"U4/reverse_rows: result: strides")
eq(result.dtype,"int64","U4/reverse_rows: result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"U4/reverse_rows: backing source")
eq(base.shape,{3,4},"U4/reverse_rows: backing source: shape")
eq(base.strides,{64,16},"U4/reverse_rows: backing source: strides")
eq(base.dtype,"<U4","U4/reverse_rows: backing source: dtype")
eq(a.shape,{3,4},"U4/reverse_rows: source shape")
eq(a.strides,{-64,16},"U4/reverse_rows: source strides")
cases=cases+1
end
-- 65: U4/strided; source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"<U4")
local a=base:get(np.s(),np.s(1,nil,2))
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"U4/strided: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3,4,5,6},"U4/strided: result")
eq(result.shape,{6},"U4/strided: result: shape")
eq(result.strides,{8},"U4/strided: result: strides")
eq(result.dtype,"int64","U4/strided: result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"U4/strided: backing source")
eq(base.shape,{3,4},"U4/strided: backing source: shape")
eq(base.strides,{64,16},"U4/strided: backing source: strides")
eq(base.dtype,"<U4","U4/strided: backing source: dtype")
eq(a.shape,{3,2},"U4/strided: source shape")
eq(a.strides,{64,32},"U4/strided: source strides")
cases=cases+1
end
-- 66: S4/plain; source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"|S4")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"S4/plain: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3,4,5,6,7,8,9,10,11,12},"S4/plain: result")
eq(result.shape,{12},"S4/plain: result: shape")
eq(result.strides,{8},"S4/plain: result: strides")
eq(result.dtype,"int64","S4/plain: result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"S4/plain: backing source")
eq(base.shape,{3,4},"S4/plain: backing source: shape")
eq(base.strides,{16,4},"S4/plain: backing source: strides")
eq(base.dtype,"|S4","S4/plain: backing source: dtype")
eq(a.shape,{3,4},"S4/plain: source shape")
eq(a.strides,{16,4},"S4/plain: source strides")
cases=cases+1
end
-- 67: S4/transpose; source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"|S4")
local a=np.transpose(base)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"S4/transpose: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3,4,5,6,7,8,9,10,11,12},"S4/transpose: result")
eq(result.shape,{12},"S4/transpose: result: shape")
eq(result.strides,{8},"S4/transpose: result: strides")
eq(result.dtype,"int64","S4/transpose: result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"S4/transpose: backing source")
eq(base.shape,{3,4},"S4/transpose: backing source: shape")
eq(base.strides,{16,4},"S4/transpose: backing source: strides")
eq(base.dtype,"|S4","S4/transpose: backing source: dtype")
eq(a.shape,{4,3},"S4/transpose: source shape")
eq(a.strides,{4,16},"S4/transpose: source strides")
cases=cases+1
end
-- 68: S4/reverse_columns; source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"|S4")
local a=np.flip(base,2)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"S4/reverse_columns: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3,4,5,6,7,8,9,10,11,12},"S4/reverse_columns: result")
eq(result.shape,{12},"S4/reverse_columns: result: shape")
eq(result.strides,{8},"S4/reverse_columns: result: strides")
eq(result.dtype,"int64","S4/reverse_columns: result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"S4/reverse_columns: backing source")
eq(base.shape,{3,4},"S4/reverse_columns: backing source: shape")
eq(base.strides,{16,4},"S4/reverse_columns: backing source: strides")
eq(base.dtype,"|S4","S4/reverse_columns: backing source: dtype")
eq(a.shape,{3,4},"S4/reverse_columns: source shape")
eq(a.strides,{16,-4},"S4/reverse_columns: source strides")
cases=cases+1
end
-- 69: S4/reverse_rows; source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"|S4")
local a=np.flip(base,1)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"S4/reverse_rows: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3,4,5,6,7,8,9,10,11,12},"S4/reverse_rows: result")
eq(result.shape,{12},"S4/reverse_rows: result: shape")
eq(result.strides,{8},"S4/reverse_rows: result: strides")
eq(result.dtype,"int64","S4/reverse_rows: result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"S4/reverse_rows: backing source")
eq(base.shape,{3,4},"S4/reverse_rows: backing source: shape")
eq(base.strides,{16,4},"S4/reverse_rows: backing source: strides")
eq(base.dtype,"|S4","S4/reverse_rows: backing source: dtype")
eq(a.shape,{3,4},"S4/reverse_rows: source shape")
eq(a.strides,{-16,4},"S4/reverse_rows: source strides")
cases=cases+1
end
-- 70: S4/strided; source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"|S4")
local a=base:get(np.s(),np.s(1,nil,2))
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"S4/strided: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3,4,5,6},"S4/strided: result")
eq(result.shape,{6},"S4/strided: result: shape")
eq(result.strides,{8},"S4/strided: result: strides")
eq(result.dtype,"int64","S4/strided: result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"S4/strided: backing source")
eq(base.shape,{3,4},"S4/strided: backing source: shape")
eq(base.strides,{16,4},"S4/strided: backing source: strides")
eq(base.dtype,"|S4","S4/strided: backing source: dtype")
eq(a.shape,{3,2},"S4/strided: source shape")
eq(a.strides,{16,8},"S4/strided: source strides")
cases=cases+1
end
-- 71: datetime64[D]/plain; source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"datetime64[D]/plain: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,5,6,7,8,9,10,11,12},"datetime64[D]/plain: result")
eq(result.shape,{11},"datetime64[D]/plain: result: shape")
eq(result.strides,{8},"datetime64[D]/plain: result: strides")
eq(result.dtype,"int64","datetime64[D]/plain: result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]/plain: backing source")
eq(base.shape,{3,4},"datetime64[D]/plain: backing source: shape")
eq(base.strides,{32,8},"datetime64[D]/plain: backing source: strides")
eq(base.dtype,"datetime64[D]","datetime64[D]/plain: backing source: dtype")
eq(a.shape,{3,4},"datetime64[D]/plain: source shape")
eq(a.strides,{32,8},"datetime64[D]/plain: source strides")
cases=cases+1
end
-- 72: datetime64[D]/transpose; source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]")
local a=np.transpose(base)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"datetime64[D]/transpose: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,5,6,7,8,9,10,11,12},"datetime64[D]/transpose: result")
eq(result.shape,{11},"datetime64[D]/transpose: result: shape")
eq(result.strides,{8},"datetime64[D]/transpose: result: strides")
eq(result.dtype,"int64","datetime64[D]/transpose: result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]/transpose: backing source")
eq(base.shape,{3,4},"datetime64[D]/transpose: backing source: shape")
eq(base.strides,{32,8},"datetime64[D]/transpose: backing source: strides")
eq(base.dtype,"datetime64[D]","datetime64[D]/transpose: backing source: dtype")
eq(a.shape,{4,3},"datetime64[D]/transpose: source shape")
eq(a.strides,{8,32},"datetime64[D]/transpose: source strides")
cases=cases+1
end
-- 73: datetime64[D]/reverse_columns; source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]")
local a=np.flip(base,2)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"datetime64[D]/reverse_columns: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3,5,6,7,8,9,10,11,12},"datetime64[D]/reverse_columns: result")
eq(result.shape,{11},"datetime64[D]/reverse_columns: result: shape")
eq(result.strides,{8},"datetime64[D]/reverse_columns: result: strides")
eq(result.dtype,"int64","datetime64[D]/reverse_columns: result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]/reverse_columns: backing source")
eq(base.shape,{3,4},"datetime64[D]/reverse_columns: backing source: shape")
eq(base.strides,{32,8},"datetime64[D]/reverse_columns: backing source: strides")
eq(base.dtype,"datetime64[D]","datetime64[D]/reverse_columns: backing source: dtype")
eq(a.shape,{3,4},"datetime64[D]/reverse_columns: source shape")
eq(a.strides,{32,-8},"datetime64[D]/reverse_columns: source strides")
cases=cases+1
end
-- 74: datetime64[D]/reverse_rows; source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]")
local a=np.flip(base,1)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"datetime64[D]/reverse_rows: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3,4,5,6,7,8,10,11,12},"datetime64[D]/reverse_rows: result")
eq(result.shape,{11},"datetime64[D]/reverse_rows: result: shape")
eq(result.strides,{8},"datetime64[D]/reverse_rows: result: strides")
eq(result.dtype,"int64","datetime64[D]/reverse_rows: result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]/reverse_rows: backing source")
eq(base.shape,{3,4},"datetime64[D]/reverse_rows: backing source: shape")
eq(base.strides,{32,8},"datetime64[D]/reverse_rows: backing source: strides")
eq(base.dtype,"datetime64[D]","datetime64[D]/reverse_rows: backing source: dtype")
eq(a.shape,{3,4},"datetime64[D]/reverse_rows: source shape")
eq(a.strides,{-32,8},"datetime64[D]/reverse_rows: source strides")
cases=cases+1
end
-- 75: datetime64[D]/strided; source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]")
local a=base:get(np.s(),np.s(1,nil,2))
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"datetime64[D]/strided: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,5,6},"datetime64[D]/strided: result")
eq(result.shape,{5},"datetime64[D]/strided: result: shape")
eq(result.strides,{8},"datetime64[D]/strided: result: strides")
eq(result.dtype,"int64","datetime64[D]/strided: result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"datetime64[D]/strided: backing source")
eq(base.shape,{3,4},"datetime64[D]/strided: backing source: shape")
eq(base.strides,{32,8},"datetime64[D]/strided: backing source: strides")
eq(base.dtype,"datetime64[D]","datetime64[D]/strided: backing source: dtype")
eq(a.shape,{3,2},"datetime64[D]/strided: source shape")
eq(a.strides,{32,16},"datetime64[D]/strided: source strides")
cases=cases+1
end
-- 76: timedelta64[h]/plain; source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"timedelta64[h]/plain: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,5,6,7,8,9,10,11,12},"timedelta64[h]/plain: result")
eq(result.shape,{11},"timedelta64[h]/plain: result: shape")
eq(result.strides,{8},"timedelta64[h]/plain: result: strides")
eq(result.dtype,"int64","timedelta64[h]/plain: result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]/plain: backing source")
eq(base.shape,{3,4},"timedelta64[h]/plain: backing source: shape")
eq(base.strides,{32,8},"timedelta64[h]/plain: backing source: strides")
eq(base.dtype,"timedelta64[h]","timedelta64[h]/plain: backing source: dtype")
eq(a.shape,{3,4},"timedelta64[h]/plain: source shape")
eq(a.strides,{32,8},"timedelta64[h]/plain: source strides")
cases=cases+1
end
-- 77: timedelta64[h]/transpose; source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]")
local a=np.transpose(base)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"timedelta64[h]/transpose: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,5,6,7,8,9,10,11,12},"timedelta64[h]/transpose: result")
eq(result.shape,{11},"timedelta64[h]/transpose: result: shape")
eq(result.strides,{8},"timedelta64[h]/transpose: result: strides")
eq(result.dtype,"int64","timedelta64[h]/transpose: result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]/transpose: backing source")
eq(base.shape,{3,4},"timedelta64[h]/transpose: backing source: shape")
eq(base.strides,{32,8},"timedelta64[h]/transpose: backing source: strides")
eq(base.dtype,"timedelta64[h]","timedelta64[h]/transpose: backing source: dtype")
eq(a.shape,{4,3},"timedelta64[h]/transpose: source shape")
eq(a.strides,{8,32},"timedelta64[h]/transpose: source strides")
cases=cases+1
end
-- 78: timedelta64[h]/reverse_columns; source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]")
local a=np.flip(base,2)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"timedelta64[h]/reverse_columns: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3,5,6,7,8,9,10,11,12},"timedelta64[h]/reverse_columns: result")
eq(result.shape,{11},"timedelta64[h]/reverse_columns: result: shape")
eq(result.strides,{8},"timedelta64[h]/reverse_columns: result: strides")
eq(result.dtype,"int64","timedelta64[h]/reverse_columns: result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]/reverse_columns: backing source")
eq(base.shape,{3,4},"timedelta64[h]/reverse_columns: backing source: shape")
eq(base.strides,{32,8},"timedelta64[h]/reverse_columns: backing source: strides")
eq(base.dtype,"timedelta64[h]","timedelta64[h]/reverse_columns: backing source: dtype")
eq(a.shape,{3,4},"timedelta64[h]/reverse_columns: source shape")
eq(a.strides,{32,-8},"timedelta64[h]/reverse_columns: source strides")
cases=cases+1
end
-- 79: timedelta64[h]/reverse_rows; source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]")
local a=np.flip(base,1)
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"timedelta64[h]/reverse_rows: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3,4,5,6,7,8,10,11,12},"timedelta64[h]/reverse_rows: result")
eq(result.shape,{11},"timedelta64[h]/reverse_rows: result: shape")
eq(result.strides,{8},"timedelta64[h]/reverse_rows: result: strides")
eq(result.dtype,"int64","timedelta64[h]/reverse_rows: result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]/reverse_rows: backing source")
eq(base.shape,{3,4},"timedelta64[h]/reverse_rows: backing source: shape")
eq(base.strides,{32,8},"timedelta64[h]/reverse_rows: backing source: strides")
eq(base.dtype,"timedelta64[h]","timedelta64[h]/reverse_rows: backing source: dtype")
eq(a.shape,{3,4},"timedelta64[h]/reverse_rows: source shape")
eq(a.strides,{-32,8},"timedelta64[h]/reverse_rows: source strides")
cases=cases+1
end
-- 80: timedelta64[h]/strided; source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]")
local a=base:get(np.s(),np.s(1,nil,2))
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"timedelta64[h]/strided: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,5,6},"timedelta64[h]/strided: result")
eq(result.shape,{5},"timedelta64[h]/strided: result: shape")
eq(result.strides,{8},"timedelta64[h]/strided: result: strides")
eq(result.dtype,"int64","timedelta64[h]/strided: result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"timedelta64[h]/strided: backing source")
eq(base.shape,{3,4},"timedelta64[h]/strided: backing source: shape")
eq(base.strides,{32,8},"timedelta64[h]/strided: backing source: strides")
eq(base.dtype,"timedelta64[h]","timedelta64[h]/strided: backing source: dtype")
eq(a.shape,{3,2},"timedelta64[h]/strided: source shape")
eq(a.strides,{32,16},"timedelta64[h]/strided: source strides")
cases=cases+1
end
-- 81: empty-scalar/()/int32; source error=None
do
local base=np.array(0,"int32")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/()/int32: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/()/int32: result")
eq(result.shape,{0},"empty-scalar/()/int32: result: shape")
eq(result.strides,{8},"empty-scalar/()/int32: result: strides")
eq(result.dtype,"int64","empty-scalar/()/int32: result: dtype")
eq(base:tolist(),0,"empty-scalar/()/int32: backing source")
eq(base.shape,{},"empty-scalar/()/int32: backing source: shape")
eq(base.strides,{},"empty-scalar/()/int32: backing source: strides")
eq(base.dtype,"int32","empty-scalar/()/int32: backing source: dtype")
eq(a.shape,{},"empty-scalar/()/int32: source shape")
eq(a.strides,{},"empty-scalar/()/int32: source strides")
cases=cases+1
end
-- 82: empty-scalar/()/float32; source error=None
do
local base=np.array(0.0,"float32")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/()/float32: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/()/float32: result")
eq(result.shape,{0},"empty-scalar/()/float32: result: shape")
eq(result.strides,{8},"empty-scalar/()/float32: result: strides")
eq(result.dtype,"int64","empty-scalar/()/float32: result: dtype")
eq(base:tolist(),0.0,"empty-scalar/()/float32: backing source")
eq(base.shape,{},"empty-scalar/()/float32: backing source: shape")
eq(base.strides,{},"empty-scalar/()/float32: backing source: strides")
eq(base.dtype,"float32","empty-scalar/()/float32: backing source: dtype")
eq(a.shape,{},"empty-scalar/()/float32: source shape")
eq(a.strides,{},"empty-scalar/()/float32: source strides")
cases=cases+1
end
-- 83: empty-scalar/()/complex128; source error=None
do
local base=np.array(np.complex(0.0,0.0),"complex128")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/()/complex128: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/()/complex128: result")
eq(result.shape,{0},"empty-scalar/()/complex128: result: shape")
eq(result.strides,{8},"empty-scalar/()/complex128: result: strides")
eq(result.dtype,"int64","empty-scalar/()/complex128: result: dtype")
eq(base:tolist(),np.complex(0.0,0.0),"empty-scalar/()/complex128: backing source")
eq(base.shape,{},"empty-scalar/()/complex128: backing source: shape")
eq(base.strides,{},"empty-scalar/()/complex128: backing source: strides")
eq(base.dtype,"complex128","empty-scalar/()/complex128: backing source: dtype")
eq(a.shape,{},"empty-scalar/()/complex128: source shape")
eq(a.strides,{},"empty-scalar/()/complex128: source strides")
cases=cases+1
end
-- 84: empty-scalar/()/U4; source error=None
do
local base=np.array("","<U4")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/()/U4: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/()/U4: result")
eq(result.shape,{0},"empty-scalar/()/U4: result: shape")
eq(result.strides,{8},"empty-scalar/()/U4: result: strides")
eq(result.dtype,"int64","empty-scalar/()/U4: result: dtype")
eq(base:tolist(),"","empty-scalar/()/U4: backing source")
eq(base.shape,{},"empty-scalar/()/U4: backing source: shape")
eq(base.strides,{},"empty-scalar/()/U4: backing source: strides")
eq(base.dtype,"<U4","empty-scalar/()/U4: backing source: dtype")
eq(a.shape,{},"empty-scalar/()/U4: source shape")
eq(a.strides,{},"empty-scalar/()/U4: source strides")
cases=cases+1
end
-- 85: empty-scalar/()/S4; source error=None
do
local base=np.array("","|S4")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/()/S4: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/()/S4: result")
eq(result.shape,{0},"empty-scalar/()/S4: result: shape")
eq(result.strides,{8},"empty-scalar/()/S4: result: strides")
eq(result.dtype,"int64","empty-scalar/()/S4: result: dtype")
eq(base:tolist(),"","empty-scalar/()/S4: backing source")
eq(base.shape,{},"empty-scalar/()/S4: backing source: shape")
eq(base.strides,{},"empty-scalar/()/S4: backing source: strides")
eq(base.dtype,"|S4","empty-scalar/()/S4: backing source: dtype")
eq(a.shape,{},"empty-scalar/()/S4: source shape")
eq(a.strides,{},"empty-scalar/()/S4: source strides")
cases=cases+1
end
-- 86: empty-scalar/()/datetime64[D]; source error=None
do
local base=np.array(0,"datetime64[D]")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/()/datetime64[D]: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/()/datetime64[D]: result")
eq(result.shape,{0},"empty-scalar/()/datetime64[D]: result: shape")
eq(result.strides,{8},"empty-scalar/()/datetime64[D]: result: strides")
eq(result.dtype,"int64","empty-scalar/()/datetime64[D]: result: dtype")
eq(np.astype(base,'int64'):tolist(),0,"empty-scalar/()/datetime64[D]: backing source")
eq(base.shape,{},"empty-scalar/()/datetime64[D]: backing source: shape")
eq(base.strides,{},"empty-scalar/()/datetime64[D]: backing source: strides")
eq(base.dtype,"datetime64[D]","empty-scalar/()/datetime64[D]: backing source: dtype")
eq(a.shape,{},"empty-scalar/()/datetime64[D]: source shape")
eq(a.strides,{},"empty-scalar/()/datetime64[D]: source strides")
cases=cases+1
end
-- 87: empty-scalar/()/timedelta64[h]; source error=None
do
local base=np.array(0,"timedelta64[h]")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/()/timedelta64[h]: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/()/timedelta64[h]: result")
eq(result.shape,{0},"empty-scalar/()/timedelta64[h]: result: shape")
eq(result.strides,{8},"empty-scalar/()/timedelta64[h]: result: strides")
eq(result.dtype,"int64","empty-scalar/()/timedelta64[h]: result: dtype")
eq(np.astype(base,'int64'):tolist(),0,"empty-scalar/()/timedelta64[h]: backing source")
eq(base.shape,{},"empty-scalar/()/timedelta64[h]: backing source: shape")
eq(base.strides,{},"empty-scalar/()/timedelta64[h]: backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-scalar/()/timedelta64[h]: backing source: dtype")
eq(a.shape,{},"empty-scalar/()/timedelta64[h]: source shape")
eq(a.strides,{},"empty-scalar/()/timedelta64[h]: source strides")
cases=cases+1
end
-- 88: empty-scalar/(0,)/int32; source error=None
do
local base=np.zeros({0},"int32")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(0,)/int32: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(0,)/int32: result")
eq(result.shape,{0},"empty-scalar/(0,)/int32: result: shape")
eq(result.strides,{8},"empty-scalar/(0,)/int32: result: strides")
eq(result.dtype,"int64","empty-scalar/(0,)/int32: result: dtype")
eq(base:tolist(),{},"empty-scalar/(0,)/int32: backing source")
eq(base.shape,{0},"empty-scalar/(0,)/int32: backing source: shape")
eq(base.strides,{0},"empty-scalar/(0,)/int32: backing source: strides")
eq(base.dtype,"int32","empty-scalar/(0,)/int32: backing source: dtype")
eq(a.shape,{0},"empty-scalar/(0,)/int32: source shape")
eq(a.strides,{0},"empty-scalar/(0,)/int32: source strides")
cases=cases+1
end
-- 89: empty-scalar/(0,)/float32; source error=None
do
local base=np.zeros({0},"float32")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(0,)/float32: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(0,)/float32: result")
eq(result.shape,{0},"empty-scalar/(0,)/float32: result: shape")
eq(result.strides,{8},"empty-scalar/(0,)/float32: result: strides")
eq(result.dtype,"int64","empty-scalar/(0,)/float32: result: dtype")
eq(base:tolist(),{},"empty-scalar/(0,)/float32: backing source")
eq(base.shape,{0},"empty-scalar/(0,)/float32: backing source: shape")
eq(base.strides,{0},"empty-scalar/(0,)/float32: backing source: strides")
eq(base.dtype,"float32","empty-scalar/(0,)/float32: backing source: dtype")
eq(a.shape,{0},"empty-scalar/(0,)/float32: source shape")
eq(a.strides,{0},"empty-scalar/(0,)/float32: source strides")
cases=cases+1
end
-- 90: empty-scalar/(0,)/complex128; source error=None
do
local base=np.zeros({0},"complex128")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(0,)/complex128: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(0,)/complex128: result")
eq(result.shape,{0},"empty-scalar/(0,)/complex128: result: shape")
eq(result.strides,{8},"empty-scalar/(0,)/complex128: result: strides")
eq(result.dtype,"int64","empty-scalar/(0,)/complex128: result: dtype")
eq(base:tolist(),{},"empty-scalar/(0,)/complex128: backing source")
eq(base.shape,{0},"empty-scalar/(0,)/complex128: backing source: shape")
eq(base.strides,{0},"empty-scalar/(0,)/complex128: backing source: strides")
eq(base.dtype,"complex128","empty-scalar/(0,)/complex128: backing source: dtype")
eq(a.shape,{0},"empty-scalar/(0,)/complex128: source shape")
eq(a.strides,{0},"empty-scalar/(0,)/complex128: source strides")
cases=cases+1
end
-- 91: empty-scalar/(0,)/U4; source error=None
do
local base=np.zeros({0},"<U4")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(0,)/U4: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(0,)/U4: result")
eq(result.shape,{0},"empty-scalar/(0,)/U4: result: shape")
eq(result.strides,{8},"empty-scalar/(0,)/U4: result: strides")
eq(result.dtype,"int64","empty-scalar/(0,)/U4: result: dtype")
eq(base:tolist(),{},"empty-scalar/(0,)/U4: backing source")
eq(base.shape,{0},"empty-scalar/(0,)/U4: backing source: shape")
eq(base.strides,{0},"empty-scalar/(0,)/U4: backing source: strides")
eq(base.dtype,"<U4","empty-scalar/(0,)/U4: backing source: dtype")
eq(a.shape,{0},"empty-scalar/(0,)/U4: source shape")
eq(a.strides,{0},"empty-scalar/(0,)/U4: source strides")
cases=cases+1
end
-- 92: empty-scalar/(0,)/S4; source error=None
do
local base=np.zeros({0},"|S4")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(0,)/S4: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(0,)/S4: result")
eq(result.shape,{0},"empty-scalar/(0,)/S4: result: shape")
eq(result.strides,{8},"empty-scalar/(0,)/S4: result: strides")
eq(result.dtype,"int64","empty-scalar/(0,)/S4: result: dtype")
eq(base:tolist(),{},"empty-scalar/(0,)/S4: backing source")
eq(base.shape,{0},"empty-scalar/(0,)/S4: backing source: shape")
eq(base.strides,{0},"empty-scalar/(0,)/S4: backing source: strides")
eq(base.dtype,"|S4","empty-scalar/(0,)/S4: backing source: dtype")
eq(a.shape,{0},"empty-scalar/(0,)/S4: source shape")
eq(a.strides,{0},"empty-scalar/(0,)/S4: source strides")
cases=cases+1
end
-- 93: empty-scalar/(0,)/datetime64[D]; source error=None
do
local base=np.zeros({0},"datetime64[D]")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(0,)/datetime64[D]: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(0,)/datetime64[D]: result")
eq(result.shape,{0},"empty-scalar/(0,)/datetime64[D]: result: shape")
eq(result.strides,{8},"empty-scalar/(0,)/datetime64[D]: result: strides")
eq(result.dtype,"int64","empty-scalar/(0,)/datetime64[D]: result: dtype")
eq(np.astype(base,'int64'):tolist(),{},"empty-scalar/(0,)/datetime64[D]: backing source")
eq(base.shape,{0},"empty-scalar/(0,)/datetime64[D]: backing source: shape")
eq(base.strides,{0},"empty-scalar/(0,)/datetime64[D]: backing source: strides")
eq(base.dtype,"datetime64[D]","empty-scalar/(0,)/datetime64[D]: backing source: dtype")
eq(a.shape,{0},"empty-scalar/(0,)/datetime64[D]: source shape")
eq(a.strides,{0},"empty-scalar/(0,)/datetime64[D]: source strides")
cases=cases+1
end
-- 94: empty-scalar/(0,)/timedelta64[h]; source error=None
do
local base=np.zeros({0},"timedelta64[h]")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(0,)/timedelta64[h]: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(0,)/timedelta64[h]: result")
eq(result.shape,{0},"empty-scalar/(0,)/timedelta64[h]: result: shape")
eq(result.strides,{8},"empty-scalar/(0,)/timedelta64[h]: result: strides")
eq(result.dtype,"int64","empty-scalar/(0,)/timedelta64[h]: result: dtype")
eq(np.astype(base,'int64'):tolist(),{},"empty-scalar/(0,)/timedelta64[h]: backing source")
eq(base.shape,{0},"empty-scalar/(0,)/timedelta64[h]: backing source: shape")
eq(base.strides,{0},"empty-scalar/(0,)/timedelta64[h]: backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-scalar/(0,)/timedelta64[h]: backing source: dtype")
eq(a.shape,{0},"empty-scalar/(0,)/timedelta64[h]: source shape")
eq(a.strides,{0},"empty-scalar/(0,)/timedelta64[h]: source strides")
cases=cases+1
end
-- 95: empty-scalar/(1,)/int32; source error=None
do
local base=np.array({0},"int32")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(1,)/int32: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(1,)/int32: result")
eq(result.shape,{0},"empty-scalar/(1,)/int32: result: shape")
eq(result.strides,{8},"empty-scalar/(1,)/int32: result: strides")
eq(result.dtype,"int64","empty-scalar/(1,)/int32: result: dtype")
eq(base:tolist(),{0},"empty-scalar/(1,)/int32: backing source")
eq(base.shape,{1},"empty-scalar/(1,)/int32: backing source: shape")
eq(base.strides,{4},"empty-scalar/(1,)/int32: backing source: strides")
eq(base.dtype,"int32","empty-scalar/(1,)/int32: backing source: dtype")
eq(a.shape,{1},"empty-scalar/(1,)/int32: source shape")
eq(a.strides,{4},"empty-scalar/(1,)/int32: source strides")
cases=cases+1
end
-- 96: empty-scalar/(1,)/float32; source error=None
do
local base=np.array({0.0},"float32")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(1,)/float32: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(1,)/float32: result")
eq(result.shape,{0},"empty-scalar/(1,)/float32: result: shape")
eq(result.strides,{8},"empty-scalar/(1,)/float32: result: strides")
eq(result.dtype,"int64","empty-scalar/(1,)/float32: result: dtype")
eq(base:tolist(),{0.0},"empty-scalar/(1,)/float32: backing source")
eq(base.shape,{1},"empty-scalar/(1,)/float32: backing source: shape")
eq(base.strides,{4},"empty-scalar/(1,)/float32: backing source: strides")
eq(base.dtype,"float32","empty-scalar/(1,)/float32: backing source: dtype")
eq(a.shape,{1},"empty-scalar/(1,)/float32: source shape")
eq(a.strides,{4},"empty-scalar/(1,)/float32: source strides")
cases=cases+1
end
-- 97: empty-scalar/(1,)/complex128; source error=None
do
local base=np.array({np.complex(0.0,0.0)},"complex128")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(1,)/complex128: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(1,)/complex128: result")
eq(result.shape,{0},"empty-scalar/(1,)/complex128: result: shape")
eq(result.strides,{8},"empty-scalar/(1,)/complex128: result: strides")
eq(result.dtype,"int64","empty-scalar/(1,)/complex128: result: dtype")
eq(base:tolist(),{np.complex(0.0,0.0)},"empty-scalar/(1,)/complex128: backing source")
eq(base.shape,{1},"empty-scalar/(1,)/complex128: backing source: shape")
eq(base.strides,{16},"empty-scalar/(1,)/complex128: backing source: strides")
eq(base.dtype,"complex128","empty-scalar/(1,)/complex128: backing source: dtype")
eq(a.shape,{1},"empty-scalar/(1,)/complex128: source shape")
eq(a.strides,{16},"empty-scalar/(1,)/complex128: source strides")
cases=cases+1
end
-- 98: empty-scalar/(1,)/U4; source error=None
do
local base=np.array({""},"<U4")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(1,)/U4: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(1,)/U4: result")
eq(result.shape,{0},"empty-scalar/(1,)/U4: result: shape")
eq(result.strides,{8},"empty-scalar/(1,)/U4: result: strides")
eq(result.dtype,"int64","empty-scalar/(1,)/U4: result: dtype")
eq(base:tolist(),{""},"empty-scalar/(1,)/U4: backing source")
eq(base.shape,{1},"empty-scalar/(1,)/U4: backing source: shape")
eq(base.strides,{16},"empty-scalar/(1,)/U4: backing source: strides")
eq(base.dtype,"<U4","empty-scalar/(1,)/U4: backing source: dtype")
eq(a.shape,{1},"empty-scalar/(1,)/U4: source shape")
eq(a.strides,{16},"empty-scalar/(1,)/U4: source strides")
cases=cases+1
end
-- 99: empty-scalar/(1,)/S4; source error=None
do
local base=np.array({""},"|S4")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(1,)/S4: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(1,)/S4: result")
eq(result.shape,{0},"empty-scalar/(1,)/S4: result: shape")
eq(result.strides,{8},"empty-scalar/(1,)/S4: result: strides")
eq(result.dtype,"int64","empty-scalar/(1,)/S4: result: dtype")
eq(base:tolist(),{""},"empty-scalar/(1,)/S4: backing source")
eq(base.shape,{1},"empty-scalar/(1,)/S4: backing source: shape")
eq(base.strides,{4},"empty-scalar/(1,)/S4: backing source: strides")
eq(base.dtype,"|S4","empty-scalar/(1,)/S4: backing source: dtype")
eq(a.shape,{1},"empty-scalar/(1,)/S4: source shape")
eq(a.strides,{4},"empty-scalar/(1,)/S4: source strides")
cases=cases+1
end
-- 100: empty-scalar/(1,)/datetime64[D]; source error=None
do
local base=np.array({0},"datetime64[D]")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(1,)/datetime64[D]: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(1,)/datetime64[D]: result")
eq(result.shape,{0},"empty-scalar/(1,)/datetime64[D]: result: shape")
eq(result.strides,{8},"empty-scalar/(1,)/datetime64[D]: result: strides")
eq(result.dtype,"int64","empty-scalar/(1,)/datetime64[D]: result: dtype")
eq(np.astype(base,'int64'):tolist(),{0},"empty-scalar/(1,)/datetime64[D]: backing source")
eq(base.shape,{1},"empty-scalar/(1,)/datetime64[D]: backing source: shape")
eq(base.strides,{8},"empty-scalar/(1,)/datetime64[D]: backing source: strides")
eq(base.dtype,"datetime64[D]","empty-scalar/(1,)/datetime64[D]: backing source: dtype")
eq(a.shape,{1},"empty-scalar/(1,)/datetime64[D]: source shape")
eq(a.strides,{8},"empty-scalar/(1,)/datetime64[D]: source strides")
cases=cases+1
end
-- 101: empty-scalar/(1,)/timedelta64[h]; source error=None
do
local base=np.array({0},"timedelta64[h]")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(1,)/timedelta64[h]: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(1,)/timedelta64[h]: result")
eq(result.shape,{0},"empty-scalar/(1,)/timedelta64[h]: result: shape")
eq(result.strides,{8},"empty-scalar/(1,)/timedelta64[h]: result: strides")
eq(result.dtype,"int64","empty-scalar/(1,)/timedelta64[h]: result: dtype")
eq(np.astype(base,'int64'):tolist(),{0},"empty-scalar/(1,)/timedelta64[h]: backing source")
eq(base.shape,{1},"empty-scalar/(1,)/timedelta64[h]: backing source: shape")
eq(base.strides,{8},"empty-scalar/(1,)/timedelta64[h]: backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-scalar/(1,)/timedelta64[h]: backing source: dtype")
eq(a.shape,{1},"empty-scalar/(1,)/timedelta64[h]: source shape")
eq(a.strides,{8},"empty-scalar/(1,)/timedelta64[h]: source strides")
cases=cases+1
end
-- 102: empty-scalar/(3,)/int32; source error=None
do
local base=np.array({0,0,0},"int32")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(3,)/int32: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(3,)/int32: result")
eq(result.shape,{0},"empty-scalar/(3,)/int32: result: shape")
eq(result.strides,{8},"empty-scalar/(3,)/int32: result: strides")
eq(result.dtype,"int64","empty-scalar/(3,)/int32: result: dtype")
eq(base:tolist(),{0,0,0},"empty-scalar/(3,)/int32: backing source")
eq(base.shape,{3},"empty-scalar/(3,)/int32: backing source: shape")
eq(base.strides,{4},"empty-scalar/(3,)/int32: backing source: strides")
eq(base.dtype,"int32","empty-scalar/(3,)/int32: backing source: dtype")
eq(a.shape,{3},"empty-scalar/(3,)/int32: source shape")
eq(a.strides,{4},"empty-scalar/(3,)/int32: source strides")
cases=cases+1
end
-- 103: empty-scalar/(3,)/float32; source error=None
do
local base=np.array({0.0,0.0,0.0},"float32")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(3,)/float32: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(3,)/float32: result")
eq(result.shape,{0},"empty-scalar/(3,)/float32: result: shape")
eq(result.strides,{8},"empty-scalar/(3,)/float32: result: strides")
eq(result.dtype,"int64","empty-scalar/(3,)/float32: result: dtype")
eq(base:tolist(),{0.0,0.0,0.0},"empty-scalar/(3,)/float32: backing source")
eq(base.shape,{3},"empty-scalar/(3,)/float32: backing source: shape")
eq(base.strides,{4},"empty-scalar/(3,)/float32: backing source: strides")
eq(base.dtype,"float32","empty-scalar/(3,)/float32: backing source: dtype")
eq(a.shape,{3},"empty-scalar/(3,)/float32: source shape")
eq(a.strides,{4},"empty-scalar/(3,)/float32: source strides")
cases=cases+1
end
-- 104: empty-scalar/(3,)/complex128; source error=None
do
local base=np.array({np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)},"complex128")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(3,)/complex128: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(3,)/complex128: result")
eq(result.shape,{0},"empty-scalar/(3,)/complex128: result: shape")
eq(result.strides,{8},"empty-scalar/(3,)/complex128: result: strides")
eq(result.dtype,"int64","empty-scalar/(3,)/complex128: result: dtype")
eq(base:tolist(),{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)},"empty-scalar/(3,)/complex128: backing source")
eq(base.shape,{3},"empty-scalar/(3,)/complex128: backing source: shape")
eq(base.strides,{16},"empty-scalar/(3,)/complex128: backing source: strides")
eq(base.dtype,"complex128","empty-scalar/(3,)/complex128: backing source: dtype")
eq(a.shape,{3},"empty-scalar/(3,)/complex128: source shape")
eq(a.strides,{16},"empty-scalar/(3,)/complex128: source strides")
cases=cases+1
end
-- 105: empty-scalar/(3,)/U4; source error=None
do
local base=np.array({"","",""},"<U4")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(3,)/U4: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(3,)/U4: result")
eq(result.shape,{0},"empty-scalar/(3,)/U4: result: shape")
eq(result.strides,{8},"empty-scalar/(3,)/U4: result: strides")
eq(result.dtype,"int64","empty-scalar/(3,)/U4: result: dtype")
eq(base:tolist(),{"","",""},"empty-scalar/(3,)/U4: backing source")
eq(base.shape,{3},"empty-scalar/(3,)/U4: backing source: shape")
eq(base.strides,{16},"empty-scalar/(3,)/U4: backing source: strides")
eq(base.dtype,"<U4","empty-scalar/(3,)/U4: backing source: dtype")
eq(a.shape,{3},"empty-scalar/(3,)/U4: source shape")
eq(a.strides,{16},"empty-scalar/(3,)/U4: source strides")
cases=cases+1
end
-- 106: empty-scalar/(3,)/S4; source error=None
do
local base=np.array({"","",""},"|S4")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(3,)/S4: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(3,)/S4: result")
eq(result.shape,{0},"empty-scalar/(3,)/S4: result: shape")
eq(result.strides,{8},"empty-scalar/(3,)/S4: result: strides")
eq(result.dtype,"int64","empty-scalar/(3,)/S4: result: dtype")
eq(base:tolist(),{"","",""},"empty-scalar/(3,)/S4: backing source")
eq(base.shape,{3},"empty-scalar/(3,)/S4: backing source: shape")
eq(base.strides,{4},"empty-scalar/(3,)/S4: backing source: strides")
eq(base.dtype,"|S4","empty-scalar/(3,)/S4: backing source: dtype")
eq(a.shape,{3},"empty-scalar/(3,)/S4: source shape")
eq(a.strides,{4},"empty-scalar/(3,)/S4: source strides")
cases=cases+1
end
-- 107: empty-scalar/(3,)/datetime64[D]; source error=None
do
local base=np.array({0,0,0},"datetime64[D]")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(3,)/datetime64[D]: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(3,)/datetime64[D]: result")
eq(result.shape,{0},"empty-scalar/(3,)/datetime64[D]: result: shape")
eq(result.strides,{8},"empty-scalar/(3,)/datetime64[D]: result: strides")
eq(result.dtype,"int64","empty-scalar/(3,)/datetime64[D]: result: dtype")
eq(np.astype(base,'int64'):tolist(),{0,0,0},"empty-scalar/(3,)/datetime64[D]: backing source")
eq(base.shape,{3},"empty-scalar/(3,)/datetime64[D]: backing source: shape")
eq(base.strides,{8},"empty-scalar/(3,)/datetime64[D]: backing source: strides")
eq(base.dtype,"datetime64[D]","empty-scalar/(3,)/datetime64[D]: backing source: dtype")
eq(a.shape,{3},"empty-scalar/(3,)/datetime64[D]: source shape")
eq(a.strides,{8},"empty-scalar/(3,)/datetime64[D]: source strides")
cases=cases+1
end
-- 108: empty-scalar/(3,)/timedelta64[h]; source error=None
do
local base=np.array({0,0,0},"timedelta64[h]")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(3,)/timedelta64[h]: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(3,)/timedelta64[h]: result")
eq(result.shape,{0},"empty-scalar/(3,)/timedelta64[h]: result: shape")
eq(result.strides,{8},"empty-scalar/(3,)/timedelta64[h]: result: strides")
eq(result.dtype,"int64","empty-scalar/(3,)/timedelta64[h]: result: dtype")
eq(np.astype(base,'int64'):tolist(),{0,0,0},"empty-scalar/(3,)/timedelta64[h]: backing source")
eq(base.shape,{3},"empty-scalar/(3,)/timedelta64[h]: backing source: shape")
eq(base.strides,{8},"empty-scalar/(3,)/timedelta64[h]: backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-scalar/(3,)/timedelta64[h]: backing source: dtype")
eq(a.shape,{3},"empty-scalar/(3,)/timedelta64[h]: source shape")
eq(a.strides,{8},"empty-scalar/(3,)/timedelta64[h]: source strides")
cases=cases+1
end
-- 109: empty-scalar/(0, 3)/int32; source error=None
do
local base=np.zeros({0,3},"int32")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(0, 3)/int32: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(0, 3)/int32: result")
eq(result.shape,{0},"empty-scalar/(0, 3)/int32: result: shape")
eq(result.strides,{8},"empty-scalar/(0, 3)/int32: result: strides")
eq(result.dtype,"int64","empty-scalar/(0, 3)/int32: result: dtype")
eq(base:tolist(),{},"empty-scalar/(0, 3)/int32: backing source")
eq(base.shape,{0,3},"empty-scalar/(0, 3)/int32: backing source: shape")
eq(base.strides,{0,0},"empty-scalar/(0, 3)/int32: backing source: strides")
eq(base.dtype,"int32","empty-scalar/(0, 3)/int32: backing source: dtype")
eq(a.shape,{0,3},"empty-scalar/(0, 3)/int32: source shape")
eq(a.strides,{0,0},"empty-scalar/(0, 3)/int32: source strides")
cases=cases+1
end
-- 110: empty-scalar/(0, 3)/float32; source error=None
do
local base=np.zeros({0,3},"float32")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(0, 3)/float32: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(0, 3)/float32: result")
eq(result.shape,{0},"empty-scalar/(0, 3)/float32: result: shape")
eq(result.strides,{8},"empty-scalar/(0, 3)/float32: result: strides")
eq(result.dtype,"int64","empty-scalar/(0, 3)/float32: result: dtype")
eq(base:tolist(),{},"empty-scalar/(0, 3)/float32: backing source")
eq(base.shape,{0,3},"empty-scalar/(0, 3)/float32: backing source: shape")
eq(base.strides,{0,0},"empty-scalar/(0, 3)/float32: backing source: strides")
eq(base.dtype,"float32","empty-scalar/(0, 3)/float32: backing source: dtype")
eq(a.shape,{0,3},"empty-scalar/(0, 3)/float32: source shape")
eq(a.strides,{0,0},"empty-scalar/(0, 3)/float32: source strides")
cases=cases+1
end
-- 111: empty-scalar/(0, 3)/complex128; source error=None
do
local base=np.zeros({0,3},"complex128")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(0, 3)/complex128: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(0, 3)/complex128: result")
eq(result.shape,{0},"empty-scalar/(0, 3)/complex128: result: shape")
eq(result.strides,{8},"empty-scalar/(0, 3)/complex128: result: strides")
eq(result.dtype,"int64","empty-scalar/(0, 3)/complex128: result: dtype")
eq(base:tolist(),{},"empty-scalar/(0, 3)/complex128: backing source")
eq(base.shape,{0,3},"empty-scalar/(0, 3)/complex128: backing source: shape")
eq(base.strides,{0,0},"empty-scalar/(0, 3)/complex128: backing source: strides")
eq(base.dtype,"complex128","empty-scalar/(0, 3)/complex128: backing source: dtype")
eq(a.shape,{0,3},"empty-scalar/(0, 3)/complex128: source shape")
eq(a.strides,{0,0},"empty-scalar/(0, 3)/complex128: source strides")
cases=cases+1
end
-- 112: empty-scalar/(0, 3)/U4; source error=None
do
local base=np.zeros({0,3},"<U4")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(0, 3)/U4: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(0, 3)/U4: result")
eq(result.shape,{0},"empty-scalar/(0, 3)/U4: result: shape")
eq(result.strides,{8},"empty-scalar/(0, 3)/U4: result: strides")
eq(result.dtype,"int64","empty-scalar/(0, 3)/U4: result: dtype")
eq(base:tolist(),{},"empty-scalar/(0, 3)/U4: backing source")
eq(base.shape,{0,3},"empty-scalar/(0, 3)/U4: backing source: shape")
eq(base.strides,{0,0},"empty-scalar/(0, 3)/U4: backing source: strides")
eq(base.dtype,"<U4","empty-scalar/(0, 3)/U4: backing source: dtype")
eq(a.shape,{0,3},"empty-scalar/(0, 3)/U4: source shape")
eq(a.strides,{0,0},"empty-scalar/(0, 3)/U4: source strides")
cases=cases+1
end
-- 113: empty-scalar/(0, 3)/S4; source error=None
do
local base=np.zeros({0,3},"|S4")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(0, 3)/S4: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(0, 3)/S4: result")
eq(result.shape,{0},"empty-scalar/(0, 3)/S4: result: shape")
eq(result.strides,{8},"empty-scalar/(0, 3)/S4: result: strides")
eq(result.dtype,"int64","empty-scalar/(0, 3)/S4: result: dtype")
eq(base:tolist(),{},"empty-scalar/(0, 3)/S4: backing source")
eq(base.shape,{0,3},"empty-scalar/(0, 3)/S4: backing source: shape")
eq(base.strides,{0,0},"empty-scalar/(0, 3)/S4: backing source: strides")
eq(base.dtype,"|S4","empty-scalar/(0, 3)/S4: backing source: dtype")
eq(a.shape,{0,3},"empty-scalar/(0, 3)/S4: source shape")
eq(a.strides,{0,0},"empty-scalar/(0, 3)/S4: source strides")
cases=cases+1
end
-- 114: empty-scalar/(0, 3)/datetime64[D]; source error=None
do
local base=np.zeros({0,3},"datetime64[D]")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(0, 3)/datetime64[D]: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(0, 3)/datetime64[D]: result")
eq(result.shape,{0},"empty-scalar/(0, 3)/datetime64[D]: result: shape")
eq(result.strides,{8},"empty-scalar/(0, 3)/datetime64[D]: result: strides")
eq(result.dtype,"int64","empty-scalar/(0, 3)/datetime64[D]: result: dtype")
eq(np.astype(base,'int64'):tolist(),{},"empty-scalar/(0, 3)/datetime64[D]: backing source")
eq(base.shape,{0,3},"empty-scalar/(0, 3)/datetime64[D]: backing source: shape")
eq(base.strides,{0,0},"empty-scalar/(0, 3)/datetime64[D]: backing source: strides")
eq(base.dtype,"datetime64[D]","empty-scalar/(0, 3)/datetime64[D]: backing source: dtype")
eq(a.shape,{0,3},"empty-scalar/(0, 3)/datetime64[D]: source shape")
eq(a.strides,{0,0},"empty-scalar/(0, 3)/datetime64[D]: source strides")
cases=cases+1
end
-- 115: empty-scalar/(0, 3)/timedelta64[h]; source error=None
do
local base=np.zeros({0,3},"timedelta64[h]")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(0, 3)/timedelta64[h]: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(0, 3)/timedelta64[h]: result")
eq(result.shape,{0},"empty-scalar/(0, 3)/timedelta64[h]: result: shape")
eq(result.strides,{8},"empty-scalar/(0, 3)/timedelta64[h]: result: strides")
eq(result.dtype,"int64","empty-scalar/(0, 3)/timedelta64[h]: result: dtype")
eq(np.astype(base,'int64'):tolist(),{},"empty-scalar/(0, 3)/timedelta64[h]: backing source")
eq(base.shape,{0,3},"empty-scalar/(0, 3)/timedelta64[h]: backing source: shape")
eq(base.strides,{0,0},"empty-scalar/(0, 3)/timedelta64[h]: backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-scalar/(0, 3)/timedelta64[h]: backing source: dtype")
eq(a.shape,{0,3},"empty-scalar/(0, 3)/timedelta64[h]: source shape")
eq(a.strides,{0,0},"empty-scalar/(0, 3)/timedelta64[h]: source strides")
cases=cases+1
end
-- 116: empty-scalar/(2, 0)/int32; source error=None
do
local base=np.zeros({2,0},"int32")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(2, 0)/int32: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(2, 0)/int32: result")
eq(result.shape,{0},"empty-scalar/(2, 0)/int32: result: shape")
eq(result.strides,{8},"empty-scalar/(2, 0)/int32: result: strides")
eq(result.dtype,"int64","empty-scalar/(2, 0)/int32: result: dtype")
eq(base:tolist(),{{},{}},"empty-scalar/(2, 0)/int32: backing source")
eq(base.shape,{2,0},"empty-scalar/(2, 0)/int32: backing source: shape")
eq(base.strides,{0,0},"empty-scalar/(2, 0)/int32: backing source: strides")
eq(base.dtype,"int32","empty-scalar/(2, 0)/int32: backing source: dtype")
eq(a.shape,{2,0},"empty-scalar/(2, 0)/int32: source shape")
eq(a.strides,{0,0},"empty-scalar/(2, 0)/int32: source strides")
cases=cases+1
end
-- 117: empty-scalar/(2, 0)/float32; source error=None
do
local base=np.zeros({2,0},"float32")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(2, 0)/float32: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(2, 0)/float32: result")
eq(result.shape,{0},"empty-scalar/(2, 0)/float32: result: shape")
eq(result.strides,{8},"empty-scalar/(2, 0)/float32: result: strides")
eq(result.dtype,"int64","empty-scalar/(2, 0)/float32: result: dtype")
eq(base:tolist(),{{},{}},"empty-scalar/(2, 0)/float32: backing source")
eq(base.shape,{2,0},"empty-scalar/(2, 0)/float32: backing source: shape")
eq(base.strides,{0,0},"empty-scalar/(2, 0)/float32: backing source: strides")
eq(base.dtype,"float32","empty-scalar/(2, 0)/float32: backing source: dtype")
eq(a.shape,{2,0},"empty-scalar/(2, 0)/float32: source shape")
eq(a.strides,{0,0},"empty-scalar/(2, 0)/float32: source strides")
cases=cases+1
end
-- 118: empty-scalar/(2, 0)/complex128; source error=None
do
local base=np.zeros({2,0},"complex128")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(2, 0)/complex128: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(2, 0)/complex128: result")
eq(result.shape,{0},"empty-scalar/(2, 0)/complex128: result: shape")
eq(result.strides,{8},"empty-scalar/(2, 0)/complex128: result: strides")
eq(result.dtype,"int64","empty-scalar/(2, 0)/complex128: result: dtype")
eq(base:tolist(),{{},{}},"empty-scalar/(2, 0)/complex128: backing source")
eq(base.shape,{2,0},"empty-scalar/(2, 0)/complex128: backing source: shape")
eq(base.strides,{0,0},"empty-scalar/(2, 0)/complex128: backing source: strides")
eq(base.dtype,"complex128","empty-scalar/(2, 0)/complex128: backing source: dtype")
eq(a.shape,{2,0},"empty-scalar/(2, 0)/complex128: source shape")
eq(a.strides,{0,0},"empty-scalar/(2, 0)/complex128: source strides")
cases=cases+1
end
-- 119: empty-scalar/(2, 0)/U4; source error=None
do
local base=np.zeros({2,0},"<U4")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(2, 0)/U4: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(2, 0)/U4: result")
eq(result.shape,{0},"empty-scalar/(2, 0)/U4: result: shape")
eq(result.strides,{8},"empty-scalar/(2, 0)/U4: result: strides")
eq(result.dtype,"int64","empty-scalar/(2, 0)/U4: result: dtype")
eq(base:tolist(),{{},{}},"empty-scalar/(2, 0)/U4: backing source")
eq(base.shape,{2,0},"empty-scalar/(2, 0)/U4: backing source: shape")
eq(base.strides,{0,0},"empty-scalar/(2, 0)/U4: backing source: strides")
eq(base.dtype,"<U4","empty-scalar/(2, 0)/U4: backing source: dtype")
eq(a.shape,{2,0},"empty-scalar/(2, 0)/U4: source shape")
eq(a.strides,{0,0},"empty-scalar/(2, 0)/U4: source strides")
cases=cases+1
end
-- 120: empty-scalar/(2, 0)/S4; source error=None
do
local base=np.zeros({2,0},"|S4")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(2, 0)/S4: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(2, 0)/S4: result")
eq(result.shape,{0},"empty-scalar/(2, 0)/S4: result: shape")
eq(result.strides,{8},"empty-scalar/(2, 0)/S4: result: strides")
eq(result.dtype,"int64","empty-scalar/(2, 0)/S4: result: dtype")
eq(base:tolist(),{{},{}},"empty-scalar/(2, 0)/S4: backing source")
eq(base.shape,{2,0},"empty-scalar/(2, 0)/S4: backing source: shape")
eq(base.strides,{0,0},"empty-scalar/(2, 0)/S4: backing source: strides")
eq(base.dtype,"|S4","empty-scalar/(2, 0)/S4: backing source: dtype")
eq(a.shape,{2,0},"empty-scalar/(2, 0)/S4: source shape")
eq(a.strides,{0,0},"empty-scalar/(2, 0)/S4: source strides")
cases=cases+1
end
-- 121: empty-scalar/(2, 0)/datetime64[D]; source error=None
do
local base=np.zeros({2,0},"datetime64[D]")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(2, 0)/datetime64[D]: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(2, 0)/datetime64[D]: result")
eq(result.shape,{0},"empty-scalar/(2, 0)/datetime64[D]: result: shape")
eq(result.strides,{8},"empty-scalar/(2, 0)/datetime64[D]: result: strides")
eq(result.dtype,"int64","empty-scalar/(2, 0)/datetime64[D]: result: dtype")
eq(np.astype(base,'int64'):tolist(),{{},{}},"empty-scalar/(2, 0)/datetime64[D]: backing source")
eq(base.shape,{2,0},"empty-scalar/(2, 0)/datetime64[D]: backing source: shape")
eq(base.strides,{0,0},"empty-scalar/(2, 0)/datetime64[D]: backing source: strides")
eq(base.dtype,"datetime64[D]","empty-scalar/(2, 0)/datetime64[D]: backing source: dtype")
eq(a.shape,{2,0},"empty-scalar/(2, 0)/datetime64[D]: source shape")
eq(a.strides,{0,0},"empty-scalar/(2, 0)/datetime64[D]: source strides")
cases=cases+1
end
-- 122: empty-scalar/(2, 0)/timedelta64[h]; source error=None
do
local base=np.zeros({2,0},"timedelta64[h]")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(2, 0)/timedelta64[h]: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(2, 0)/timedelta64[h]: result")
eq(result.shape,{0},"empty-scalar/(2, 0)/timedelta64[h]: result: shape")
eq(result.strides,{8},"empty-scalar/(2, 0)/timedelta64[h]: result: strides")
eq(result.dtype,"int64","empty-scalar/(2, 0)/timedelta64[h]: result: dtype")
eq(np.astype(base,'int64'):tolist(),{{},{}},"empty-scalar/(2, 0)/timedelta64[h]: backing source")
eq(base.shape,{2,0},"empty-scalar/(2, 0)/timedelta64[h]: backing source: shape")
eq(base.strides,{0,0},"empty-scalar/(2, 0)/timedelta64[h]: backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-scalar/(2, 0)/timedelta64[h]: backing source: dtype")
eq(a.shape,{2,0},"empty-scalar/(2, 0)/timedelta64[h]: source shape")
eq(a.strides,{0,0},"empty-scalar/(2, 0)/timedelta64[h]: source strides")
cases=cases+1
end
-- 123: empty-scalar/(2, 3)/int32; source error=None
do
local base=np.array({{0,0,0},{0,0,0}},"int32")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(2, 3)/int32: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(2, 3)/int32: result")
eq(result.shape,{0},"empty-scalar/(2, 3)/int32: result: shape")
eq(result.strides,{8},"empty-scalar/(2, 3)/int32: result: strides")
eq(result.dtype,"int64","empty-scalar/(2, 3)/int32: result: dtype")
eq(base:tolist(),{{0,0,0},{0,0,0}},"empty-scalar/(2, 3)/int32: backing source")
eq(base.shape,{2,3},"empty-scalar/(2, 3)/int32: backing source: shape")
eq(base.strides,{12,4},"empty-scalar/(2, 3)/int32: backing source: strides")
eq(base.dtype,"int32","empty-scalar/(2, 3)/int32: backing source: dtype")
eq(a.shape,{2,3},"empty-scalar/(2, 3)/int32: source shape")
eq(a.strides,{12,4},"empty-scalar/(2, 3)/int32: source strides")
cases=cases+1
end
-- 124: empty-scalar/(2, 3)/float32; source error=None
do
local base=np.array({{0.0,0.0,0.0},{0.0,0.0,0.0}},"float32")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(2, 3)/float32: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(2, 3)/float32: result")
eq(result.shape,{0},"empty-scalar/(2, 3)/float32: result: shape")
eq(result.strides,{8},"empty-scalar/(2, 3)/float32: result: strides")
eq(result.dtype,"int64","empty-scalar/(2, 3)/float32: result: dtype")
eq(base:tolist(),{{0.0,0.0,0.0},{0.0,0.0,0.0}},"empty-scalar/(2, 3)/float32: backing source")
eq(base.shape,{2,3},"empty-scalar/(2, 3)/float32: backing source: shape")
eq(base.strides,{12,4},"empty-scalar/(2, 3)/float32: backing source: strides")
eq(base.dtype,"float32","empty-scalar/(2, 3)/float32: backing source: dtype")
eq(a.shape,{2,3},"empty-scalar/(2, 3)/float32: source shape")
eq(a.strides,{12,4},"empty-scalar/(2, 3)/float32: source strides")
cases=cases+1
end
-- 125: empty-scalar/(2, 3)/complex128; source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}},"complex128")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(2, 3)/complex128: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(2, 3)/complex128: result")
eq(result.shape,{0},"empty-scalar/(2, 3)/complex128: result: shape")
eq(result.strides,{8},"empty-scalar/(2, 3)/complex128: result: strides")
eq(result.dtype,"int64","empty-scalar/(2, 3)/complex128: result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}},"empty-scalar/(2, 3)/complex128: backing source")
eq(base.shape,{2,3},"empty-scalar/(2, 3)/complex128: backing source: shape")
eq(base.strides,{48,16},"empty-scalar/(2, 3)/complex128: backing source: strides")
eq(base.dtype,"complex128","empty-scalar/(2, 3)/complex128: backing source: dtype")
eq(a.shape,{2,3},"empty-scalar/(2, 3)/complex128: source shape")
eq(a.strides,{48,16},"empty-scalar/(2, 3)/complex128: source strides")
cases=cases+1
end
-- 126: empty-scalar/(2, 3)/U4; source error=None
do
local base=np.array({{"","",""},{"","",""}},"<U4")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(2, 3)/U4: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(2, 3)/U4: result")
eq(result.shape,{0},"empty-scalar/(2, 3)/U4: result: shape")
eq(result.strides,{8},"empty-scalar/(2, 3)/U4: result: strides")
eq(result.dtype,"int64","empty-scalar/(2, 3)/U4: result: dtype")
eq(base:tolist(),{{"","",""},{"","",""}},"empty-scalar/(2, 3)/U4: backing source")
eq(base.shape,{2,3},"empty-scalar/(2, 3)/U4: backing source: shape")
eq(base.strides,{48,16},"empty-scalar/(2, 3)/U4: backing source: strides")
eq(base.dtype,"<U4","empty-scalar/(2, 3)/U4: backing source: dtype")
eq(a.shape,{2,3},"empty-scalar/(2, 3)/U4: source shape")
eq(a.strides,{48,16},"empty-scalar/(2, 3)/U4: source strides")
cases=cases+1
end
-- 127: empty-scalar/(2, 3)/S4; source error=None
do
local base=np.array({{"","",""},{"","",""}},"|S4")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(2, 3)/S4: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(2, 3)/S4: result")
eq(result.shape,{0},"empty-scalar/(2, 3)/S4: result: shape")
eq(result.strides,{8},"empty-scalar/(2, 3)/S4: result: strides")
eq(result.dtype,"int64","empty-scalar/(2, 3)/S4: result: dtype")
eq(base:tolist(),{{"","",""},{"","",""}},"empty-scalar/(2, 3)/S4: backing source")
eq(base.shape,{2,3},"empty-scalar/(2, 3)/S4: backing source: shape")
eq(base.strides,{12,4},"empty-scalar/(2, 3)/S4: backing source: strides")
eq(base.dtype,"|S4","empty-scalar/(2, 3)/S4: backing source: dtype")
eq(a.shape,{2,3},"empty-scalar/(2, 3)/S4: source shape")
eq(a.strides,{12,4},"empty-scalar/(2, 3)/S4: source strides")
cases=cases+1
end
-- 128: empty-scalar/(2, 3)/datetime64[D]; source error=None
do
local base=np.array({{0,0,0},{0,0,0}},"datetime64[D]")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(2, 3)/datetime64[D]: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(2, 3)/datetime64[D]: result")
eq(result.shape,{0},"empty-scalar/(2, 3)/datetime64[D]: result: shape")
eq(result.strides,{8},"empty-scalar/(2, 3)/datetime64[D]: result: strides")
eq(result.dtype,"int64","empty-scalar/(2, 3)/datetime64[D]: result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,0,0},{0,0,0}},"empty-scalar/(2, 3)/datetime64[D]: backing source")
eq(base.shape,{2,3},"empty-scalar/(2, 3)/datetime64[D]: backing source: shape")
eq(base.strides,{24,8},"empty-scalar/(2, 3)/datetime64[D]: backing source: strides")
eq(base.dtype,"datetime64[D]","empty-scalar/(2, 3)/datetime64[D]: backing source: dtype")
eq(a.shape,{2,3},"empty-scalar/(2, 3)/datetime64[D]: source shape")
eq(a.strides,{24,8},"empty-scalar/(2, 3)/datetime64[D]: source strides")
cases=cases+1
end
-- 129: empty-scalar/(2, 3)/timedelta64[h]; source error=None
do
local base=np.array({{0,0,0},{0,0,0}},"timedelta64[h]")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(2, 3)/timedelta64[h]: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(2, 3)/timedelta64[h]: result")
eq(result.shape,{0},"empty-scalar/(2, 3)/timedelta64[h]: result: shape")
eq(result.strides,{8},"empty-scalar/(2, 3)/timedelta64[h]: result: strides")
eq(result.dtype,"int64","empty-scalar/(2, 3)/timedelta64[h]: result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,0,0},{0,0,0}},"empty-scalar/(2, 3)/timedelta64[h]: backing source")
eq(base.shape,{2,3},"empty-scalar/(2, 3)/timedelta64[h]: backing source: shape")
eq(base.strides,{24,8},"empty-scalar/(2, 3)/timedelta64[h]: backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-scalar/(2, 3)/timedelta64[h]: backing source: dtype")
eq(a.shape,{2,3},"empty-scalar/(2, 3)/timedelta64[h]: source shape")
eq(a.strides,{24,8},"empty-scalar/(2, 3)/timedelta64[h]: source strides")
cases=cases+1
end
-- 130: empty-scalar/(2, 1, 3)/int32; source error=None
do
local base=np.array({{{0,0,0}},{{0,0,0}}},"int32")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(2, 1, 3)/int32: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(2, 1, 3)/int32: result")
eq(result.shape,{0},"empty-scalar/(2, 1, 3)/int32: result: shape")
eq(result.strides,{8},"empty-scalar/(2, 1, 3)/int32: result: strides")
eq(result.dtype,"int64","empty-scalar/(2, 1, 3)/int32: result: dtype")
eq(base:tolist(),{{{0,0,0}},{{0,0,0}}},"empty-scalar/(2, 1, 3)/int32: backing source")
eq(base.shape,{2,1,3},"empty-scalar/(2, 1, 3)/int32: backing source: shape")
eq(base.strides,{12,12,4},"empty-scalar/(2, 1, 3)/int32: backing source: strides")
eq(base.dtype,"int32","empty-scalar/(2, 1, 3)/int32: backing source: dtype")
eq(a.shape,{2,1,3},"empty-scalar/(2, 1, 3)/int32: source shape")
eq(a.strides,{12,12,4},"empty-scalar/(2, 1, 3)/int32: source strides")
cases=cases+1
end
-- 131: empty-scalar/(2, 1, 3)/float32; source error=None
do
local base=np.array({{{0.0,0.0,0.0}},{{0.0,0.0,0.0}}},"float32")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(2, 1, 3)/float32: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(2, 1, 3)/float32: result")
eq(result.shape,{0},"empty-scalar/(2, 1, 3)/float32: result: shape")
eq(result.strides,{8},"empty-scalar/(2, 1, 3)/float32: result: strides")
eq(result.dtype,"int64","empty-scalar/(2, 1, 3)/float32: result: dtype")
eq(base:tolist(),{{{0.0,0.0,0.0}},{{0.0,0.0,0.0}}},"empty-scalar/(2, 1, 3)/float32: backing source")
eq(base.shape,{2,1,3},"empty-scalar/(2, 1, 3)/float32: backing source: shape")
eq(base.strides,{12,12,4},"empty-scalar/(2, 1, 3)/float32: backing source: strides")
eq(base.dtype,"float32","empty-scalar/(2, 1, 3)/float32: backing source: dtype")
eq(a.shape,{2,1,3},"empty-scalar/(2, 1, 3)/float32: source shape")
eq(a.strides,{12,12,4},"empty-scalar/(2, 1, 3)/float32: source strides")
cases=cases+1
end
-- 132: empty-scalar/(2, 1, 3)/complex128; source error=None
do
local base=np.array({{{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}},{{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}}},"complex128")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(2, 1, 3)/complex128: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(2, 1, 3)/complex128: result")
eq(result.shape,{0},"empty-scalar/(2, 1, 3)/complex128: result: shape")
eq(result.strides,{8},"empty-scalar/(2, 1, 3)/complex128: result: strides")
eq(result.dtype,"int64","empty-scalar/(2, 1, 3)/complex128: result: dtype")
eq(base:tolist(),{{{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}},{{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}}},"empty-scalar/(2, 1, 3)/complex128: backing source")
eq(base.shape,{2,1,3},"empty-scalar/(2, 1, 3)/complex128: backing source: shape")
eq(base.strides,{48,48,16},"empty-scalar/(2, 1, 3)/complex128: backing source: strides")
eq(base.dtype,"complex128","empty-scalar/(2, 1, 3)/complex128: backing source: dtype")
eq(a.shape,{2,1,3},"empty-scalar/(2, 1, 3)/complex128: source shape")
eq(a.strides,{48,48,16},"empty-scalar/(2, 1, 3)/complex128: source strides")
cases=cases+1
end
-- 133: empty-scalar/(2, 1, 3)/U4; source error=None
do
local base=np.array({{{"","",""}},{{"","",""}}},"<U4")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(2, 1, 3)/U4: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(2, 1, 3)/U4: result")
eq(result.shape,{0},"empty-scalar/(2, 1, 3)/U4: result: shape")
eq(result.strides,{8},"empty-scalar/(2, 1, 3)/U4: result: strides")
eq(result.dtype,"int64","empty-scalar/(2, 1, 3)/U4: result: dtype")
eq(base:tolist(),{{{"","",""}},{{"","",""}}},"empty-scalar/(2, 1, 3)/U4: backing source")
eq(base.shape,{2,1,3},"empty-scalar/(2, 1, 3)/U4: backing source: shape")
eq(base.strides,{48,48,16},"empty-scalar/(2, 1, 3)/U4: backing source: strides")
eq(base.dtype,"<U4","empty-scalar/(2, 1, 3)/U4: backing source: dtype")
eq(a.shape,{2,1,3},"empty-scalar/(2, 1, 3)/U4: source shape")
eq(a.strides,{48,48,16},"empty-scalar/(2, 1, 3)/U4: source strides")
cases=cases+1
end
-- 134: empty-scalar/(2, 1, 3)/S4; source error=None
do
local base=np.array({{{"","",""}},{{"","",""}}},"|S4")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(2, 1, 3)/S4: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(2, 1, 3)/S4: result")
eq(result.shape,{0},"empty-scalar/(2, 1, 3)/S4: result: shape")
eq(result.strides,{8},"empty-scalar/(2, 1, 3)/S4: result: strides")
eq(result.dtype,"int64","empty-scalar/(2, 1, 3)/S4: result: dtype")
eq(base:tolist(),{{{"","",""}},{{"","",""}}},"empty-scalar/(2, 1, 3)/S4: backing source")
eq(base.shape,{2,1,3},"empty-scalar/(2, 1, 3)/S4: backing source: shape")
eq(base.strides,{12,12,4},"empty-scalar/(2, 1, 3)/S4: backing source: strides")
eq(base.dtype,"|S4","empty-scalar/(2, 1, 3)/S4: backing source: dtype")
eq(a.shape,{2,1,3},"empty-scalar/(2, 1, 3)/S4: source shape")
eq(a.strides,{12,12,4},"empty-scalar/(2, 1, 3)/S4: source strides")
cases=cases+1
end
-- 135: empty-scalar/(2, 1, 3)/datetime64[D]; source error=None
do
local base=np.array({{{0,0,0}},{{0,0,0}}},"datetime64[D]")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(2, 1, 3)/datetime64[D]: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(2, 1, 3)/datetime64[D]: result")
eq(result.shape,{0},"empty-scalar/(2, 1, 3)/datetime64[D]: result: shape")
eq(result.strides,{8},"empty-scalar/(2, 1, 3)/datetime64[D]: result: strides")
eq(result.dtype,"int64","empty-scalar/(2, 1, 3)/datetime64[D]: result: dtype")
eq(np.astype(base,'int64'):tolist(),{{{0,0,0}},{{0,0,0}}},"empty-scalar/(2, 1, 3)/datetime64[D]: backing source")
eq(base.shape,{2,1,3},"empty-scalar/(2, 1, 3)/datetime64[D]: backing source: shape")
eq(base.strides,{24,24,8},"empty-scalar/(2, 1, 3)/datetime64[D]: backing source: strides")
eq(base.dtype,"datetime64[D]","empty-scalar/(2, 1, 3)/datetime64[D]: backing source: dtype")
eq(a.shape,{2,1,3},"empty-scalar/(2, 1, 3)/datetime64[D]: source shape")
eq(a.strides,{24,24,8},"empty-scalar/(2, 1, 3)/datetime64[D]: source strides")
cases=cases+1
end
-- 136: empty-scalar/(2, 1, 3)/timedelta64[h]; source error=None
do
local base=np.array({{{0,0,0}},{{0,0,0}}},"timedelta64[h]")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"empty-scalar/(2, 1, 3)/timedelta64[h]: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"empty-scalar/(2, 1, 3)/timedelta64[h]: result")
eq(result.shape,{0},"empty-scalar/(2, 1, 3)/timedelta64[h]: result: shape")
eq(result.strides,{8},"empty-scalar/(2, 1, 3)/timedelta64[h]: result: strides")
eq(result.dtype,"int64","empty-scalar/(2, 1, 3)/timedelta64[h]: result: dtype")
eq(np.astype(base,'int64'):tolist(),{{{0,0,0}},{{0,0,0}}},"empty-scalar/(2, 1, 3)/timedelta64[h]: backing source")
eq(base.shape,{2,1,3},"empty-scalar/(2, 1, 3)/timedelta64[h]: backing source: shape")
eq(base.strides,{24,24,8},"empty-scalar/(2, 1, 3)/timedelta64[h]: backing source: strides")
eq(base.dtype,"timedelta64[h]","empty-scalar/(2, 1, 3)/timedelta64[h]: backing source: dtype")
eq(a.shape,{2,1,3},"empty-scalar/(2, 1, 3)/timedelta64[h]: source shape")
eq(a.strides,{24,24,8},"empty-scalar/(2, 1, 3)/timedelta64[h]: source strides")
cases=cases+1
end
-- 137: truth-values/float64; source error=None
do
local base=np.array({{0.0,(0/0)},{math.huge,-0.0}},"float64")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"truth-values/float64: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3},"truth-values/float64: result")
eq(result.shape,{2},"truth-values/float64: result: shape")
eq(result.strides,{8},"truth-values/float64: result: strides")
eq(result.dtype,"int64","truth-values/float64: result: dtype")
eq(base:tolist(),{{0.0,(0/0)},{math.huge,-0.0}},"truth-values/float64: backing source")
eq(base.shape,{2,2},"truth-values/float64: backing source: shape")
eq(base.strides,{16,8},"truth-values/float64: backing source: strides")
eq(base.dtype,"float64","truth-values/float64: backing source: dtype")
eq(a.shape,{2,2},"truth-values/float64: source shape")
eq(a.strides,{16,8},"truth-values/float64: source strides")
cases=cases+1
end
-- 138: truth-values/complex128; source error=None
do
local base=np.array({{np.complex(0.0,0.0),np.complex(0.0,1.0)},{np.complex((0/0),0.0),np.complex(0.0,(0/0))}},"complex128")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"truth-values/complex128: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4},"truth-values/complex128: result")
eq(result.shape,{3},"truth-values/complex128: result: shape")
eq(result.strides,{8},"truth-values/complex128: result: strides")
eq(result.dtype,"int64","truth-values/complex128: result: dtype")
eq(base:tolist(),{{np.complex(0.0,0.0),np.complex(0.0,1.0)},{np.complex((0/0),0.0),np.complex(0.0,(0/0))}},"truth-values/complex128: backing source")
eq(base.shape,{2,2},"truth-values/complex128: backing source: shape")
eq(base.strides,{32,16},"truth-values/complex128: backing source: strides")
eq(base.dtype,"complex128","truth-values/complex128: backing source: dtype")
eq(a.shape,{2,2},"truth-values/complex128: source shape")
eq(a.strides,{32,16},"truth-values/complex128: source strides")
cases=cases+1
end
-- 139: truth-values/U4; source error=None
do
local base=np.array({{"","0"},{" ","a"}},"<U4")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"truth-values/U4: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4},"truth-values/U4: result")
eq(result.shape,{3},"truth-values/U4: result: shape")
eq(result.strides,{8},"truth-values/U4: result: strides")
eq(result.dtype,"int64","truth-values/U4: result: dtype")
eq(base:tolist(),{{"","0"},{" ","a"}},"truth-values/U4: backing source")
eq(base.shape,{2,2},"truth-values/U4: backing source: shape")
eq(base.strides,{32,16},"truth-values/U4: backing source: strides")
eq(base.dtype,"<U4","truth-values/U4: backing source: dtype")
eq(a.shape,{2,2},"truth-values/U4: source shape")
eq(a.strides,{32,16},"truth-values/U4: source strides")
cases=cases+1
end
-- 140: truth-values/S4; source error=None
do
local base=np.array({{"","0"},{" ","a"}},"|S4")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"truth-values/S4: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4},"truth-values/S4: result")
eq(result.shape,{3},"truth-values/S4: result: shape")
eq(result.strides,{8},"truth-values/S4: result: strides")
eq(result.dtype,"int64","truth-values/S4: result: dtype")
eq(base:tolist(),{{"","0"},{" ","a"}},"truth-values/S4: backing source")
eq(base.shape,{2,2},"truth-values/S4: backing source: shape")
eq(base.strides,{8,4},"truth-values/S4: backing source: strides")
eq(base.dtype,"|S4","truth-values/S4: backing source: dtype")
eq(a.shape,{2,2},"truth-values/S4: source shape")
eq(a.strides,{8,4},"truth-values/S4: source strides")
cases=cases+1
end
-- 141: truth-values/datetime64[D]; source error=None
do
local base=np.array({{0,math.mininteger},{1,-1}},"datetime64[D]")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"truth-values/datetime64[D]: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4},"truth-values/datetime64[D]: result")
eq(result.shape,{3},"truth-values/datetime64[D]: result: shape")
eq(result.strides,{8},"truth-values/datetime64[D]: result: strides")
eq(result.dtype,"int64","truth-values/datetime64[D]: result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,-9223372036854775808},{1,-1}},"truth-values/datetime64[D]: backing source")
eq(base.shape,{2,2},"truth-values/datetime64[D]: backing source: shape")
eq(base.strides,{16,8},"truth-values/datetime64[D]: backing source: strides")
eq(base.dtype,"datetime64[D]","truth-values/datetime64[D]: backing source: dtype")
eq(a.shape,{2,2},"truth-values/datetime64[D]: source shape")
eq(a.strides,{16,8},"truth-values/datetime64[D]: source strides")
cases=cases+1
end
-- 142: truth-values/timedelta64[h]; source error=None
do
local base=np.array({{0,math.mininteger},{1,-1}},"timedelta64[h]")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"truth-values/timedelta64[h]: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4},"truth-values/timedelta64[h]: result")
eq(result.shape,{3},"truth-values/timedelta64[h]: result: shape")
eq(result.strides,{8},"truth-values/timedelta64[h]: result: strides")
eq(result.dtype,"int64","truth-values/timedelta64[h]: result: dtype")
eq(np.astype(base,'int64'):tolist(),{{0,-9223372036854775808},{1,-1}},"truth-values/timedelta64[h]: backing source")
eq(base.shape,{2,2},"truth-values/timedelta64[h]: backing source: shape")
eq(base.strides,{16,8},"truth-values/timedelta64[h]: backing source: strides")
eq(base.dtype,"timedelta64[h]","truth-values/timedelta64[h]: backing source: dtype")
eq(a.shape,{2,2},"truth-values/timedelta64[h]: source shape")
eq(a.strides,{16,8},"truth-values/timedelta64[h]: source strides")
cases=cases+1
end
-- 143: zero-stride/int32/broadcast; source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int32")
local a=np.broadcast_arrays(base:get(np.s(1,2),np.s()),np.zeros({3,4}))[1]
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"zero-stride/int32/broadcast: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,6,7,8,10,11,12},"zero-stride/int32/broadcast: result")
eq(result.shape,{9},"zero-stride/int32/broadcast: result: shape")
eq(result.strides,{8},"zero-stride/int32/broadcast: result: strides")
eq(result.dtype,"int64","zero-stride/int32/broadcast: result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"zero-stride/int32/broadcast: backing source")
eq(base.shape,{3,4},"zero-stride/int32/broadcast: backing source: shape")
eq(base.strides,{16,4},"zero-stride/int32/broadcast: backing source: strides")
eq(base.dtype,"int32","zero-stride/int32/broadcast: backing source: dtype")
eq(a.shape,{3,4},"zero-stride/int32/broadcast: source shape")
eq(a.strides,{0,4},"zero-stride/int32/broadcast: source strides")
cases=cases+1
end
-- 144: zero-stride/int32/readonly-broadcast; source error=None
do
local base=np.array({{0,1,2,3},{4,5,6,7},{8,9,10,11}},"int32")
local a=np.broadcast_to(base:get(np.s(1,2),np.s()),{3,4})
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"zero-stride/int32/readonly-broadcast: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,6,7,8,10,11,12},"zero-stride/int32/readonly-broadcast: result")
eq(result.shape,{9},"zero-stride/int32/readonly-broadcast: result: shape")
eq(result.strides,{8},"zero-stride/int32/readonly-broadcast: result: strides")
eq(result.dtype,"int64","zero-stride/int32/readonly-broadcast: result: dtype")
eq(base:tolist(),{{0,1,2,3},{4,5,6,7},{8,9,10,11}},"zero-stride/int32/readonly-broadcast: backing source")
eq(base.shape,{3,4},"zero-stride/int32/readonly-broadcast: backing source: shape")
eq(base.strides,{16,4},"zero-stride/int32/readonly-broadcast: backing source: strides")
eq(base.dtype,"int32","zero-stride/int32/readonly-broadcast: backing source: dtype")
eq(a.shape,{3,4},"zero-stride/int32/readonly-broadcast: source shape")
eq(a.strides,{0,4},"zero-stride/int32/readonly-broadcast: source strides")
cases=cases+1
end
-- 145: zero-stride/float32/broadcast; source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32")
local a=np.broadcast_arrays(base:get(np.s(1,2),np.s()),np.zeros({3,4}))[1]
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"zero-stride/float32/broadcast: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,6,7,8,10,11,12},"zero-stride/float32/broadcast: result")
eq(result.shape,{9},"zero-stride/float32/broadcast: result: shape")
eq(result.strides,{8},"zero-stride/float32/broadcast: result: strides")
eq(result.dtype,"int64","zero-stride/float32/broadcast: result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"zero-stride/float32/broadcast: backing source")
eq(base.shape,{3,4},"zero-stride/float32/broadcast: backing source: shape")
eq(base.strides,{16,4},"zero-stride/float32/broadcast: backing source: strides")
eq(base.dtype,"float32","zero-stride/float32/broadcast: backing source: dtype")
eq(a.shape,{3,4},"zero-stride/float32/broadcast: source shape")
eq(a.strides,{0,4},"zero-stride/float32/broadcast: source strides")
cases=cases+1
end
-- 146: zero-stride/float32/readonly-broadcast; source error=None
do
local base=np.array({{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"float32")
local a=np.broadcast_to(base:get(np.s(1,2),np.s()),{3,4})
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"zero-stride/float32/readonly-broadcast: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,4,6,7,8,10,11,12},"zero-stride/float32/readonly-broadcast: result")
eq(result.shape,{9},"zero-stride/float32/readonly-broadcast: result: shape")
eq(result.strides,{8},"zero-stride/float32/readonly-broadcast: result: strides")
eq(result.dtype,"int64","zero-stride/float32/readonly-broadcast: result: dtype")
eq(base:tolist(),{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},"zero-stride/float32/readonly-broadcast: backing source")
eq(base.shape,{3,4},"zero-stride/float32/readonly-broadcast: backing source: shape")
eq(base.strides,{16,4},"zero-stride/float32/readonly-broadcast: backing source: strides")
eq(base.dtype,"float32","zero-stride/float32/readonly-broadcast: backing source: dtype")
eq(a.shape,{3,4},"zero-stride/float32/readonly-broadcast: source shape")
eq(a.strides,{0,4},"zero-stride/float32/readonly-broadcast: source strides")
cases=cases+1
end
-- 147: zero-stride/bool/broadcast; source error=None
do
local base=np.array({{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool")
local a=np.broadcast_arrays(base:get(np.s(1,2),np.s()),np.zeros({3,4}))[1]
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"zero-stride/bool/broadcast: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,4,6,8,10,12},"zero-stride/bool/broadcast: result")
eq(result.shape,{6},"zero-stride/bool/broadcast: result: shape")
eq(result.strides,{8},"zero-stride/bool/broadcast: result: strides")
eq(result.dtype,"int64","zero-stride/bool/broadcast: result: dtype")
eq(base:tolist(),{{false,true,false,true},{false,true,false,true},{false,true,false,true}},"zero-stride/bool/broadcast: backing source")
eq(base.shape,{3,4},"zero-stride/bool/broadcast: backing source: shape")
eq(base.strides,{4,1},"zero-stride/bool/broadcast: backing source: strides")
eq(base.dtype,"bool","zero-stride/bool/broadcast: backing source: dtype")
eq(a.shape,{3,4},"zero-stride/bool/broadcast: source shape")
eq(a.strides,{0,1},"zero-stride/bool/broadcast: source strides")
cases=cases+1
end
-- 148: zero-stride/bool/readonly-broadcast; source error=None
do
local base=np.array({{false,true,false,true},{false,true,false,true},{false,true,false,true}},"bool")
local a=np.broadcast_to(base:get(np.s(1,2),np.s()),{3,4})
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"zero-stride/bool/readonly-broadcast: acceptance"..": "..tostring(result))
eq(result:tolist(),{2,4,6,8,10,12},"zero-stride/bool/readonly-broadcast: result")
eq(result.shape,{6},"zero-stride/bool/readonly-broadcast: result: shape")
eq(result.strides,{8},"zero-stride/bool/readonly-broadcast: result: strides")
eq(result.dtype,"int64","zero-stride/bool/readonly-broadcast: result: dtype")
eq(base:tolist(),{{false,true,false,true},{false,true,false,true},{false,true,false,true}},"zero-stride/bool/readonly-broadcast: backing source")
eq(base.shape,{3,4},"zero-stride/bool/readonly-broadcast: backing source: shape")
eq(base.strides,{4,1},"zero-stride/bool/readonly-broadcast: backing source: strides")
eq(base.dtype,"bool","zero-stride/bool/readonly-broadcast: backing source: dtype")
eq(a.shape,{3,4},"zero-stride/bool/readonly-broadcast: source shape")
eq(a.strides,{0,1},"zero-stride/bool/readonly-broadcast: source strides")
cases=cases+1
end
-- 149: zero-stride/U4/broadcast; source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"<U4")
local a=np.broadcast_arrays(base:get(np.s(1,2),np.s()),np.zeros({3,4}))[1]
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"zero-stride/U4/broadcast: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3,4,5,6,7,8,9,10,11,12},"zero-stride/U4/broadcast: result")
eq(result.shape,{12},"zero-stride/U4/broadcast: result: shape")
eq(result.strides,{8},"zero-stride/U4/broadcast: result: strides")
eq(result.dtype,"int64","zero-stride/U4/broadcast: result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"zero-stride/U4/broadcast: backing source")
eq(base.shape,{3,4},"zero-stride/U4/broadcast: backing source: shape")
eq(base.strides,{64,16},"zero-stride/U4/broadcast: backing source: strides")
eq(base.dtype,"<U4","zero-stride/U4/broadcast: backing source: dtype")
eq(a.shape,{3,4},"zero-stride/U4/broadcast: source shape")
eq(a.strides,{0,16},"zero-stride/U4/broadcast: source strides")
cases=cases+1
end
-- 150: zero-stride/U4/readonly-broadcast; source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"<U4")
local a=np.broadcast_to(base:get(np.s(1,2),np.s()),{3,4})
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"zero-stride/U4/readonly-broadcast: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3,4,5,6,7,8,9,10,11,12},"zero-stride/U4/readonly-broadcast: result")
eq(result.shape,{12},"zero-stride/U4/readonly-broadcast: result: shape")
eq(result.strides,{8},"zero-stride/U4/readonly-broadcast: result: strides")
eq(result.dtype,"int64","zero-stride/U4/readonly-broadcast: result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"zero-stride/U4/readonly-broadcast: backing source")
eq(base.shape,{3,4},"zero-stride/U4/readonly-broadcast: backing source: shape")
eq(base.strides,{64,16},"zero-stride/U4/readonly-broadcast: backing source: strides")
eq(base.dtype,"<U4","zero-stride/U4/readonly-broadcast: backing source: dtype")
eq(a.shape,{3,4},"zero-stride/U4/readonly-broadcast: source shape")
eq(a.strides,{0,16},"zero-stride/U4/readonly-broadcast: source strides")
cases=cases+1
end
-- 151: zero-stride/S4/broadcast; source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"|S4")
local a=np.broadcast_arrays(base:get(np.s(1,2),np.s()),np.zeros({3,4}))[1]
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"zero-stride/S4/broadcast: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3,4,5,6,7,8,9,10,11,12},"zero-stride/S4/broadcast: result")
eq(result.shape,{12},"zero-stride/S4/broadcast: result: shape")
eq(result.strides,{8},"zero-stride/S4/broadcast: result: strides")
eq(result.dtype,"int64","zero-stride/S4/broadcast: result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"zero-stride/S4/broadcast: backing source")
eq(base.shape,{3,4},"zero-stride/S4/broadcast: backing source: shape")
eq(base.strides,{16,4},"zero-stride/S4/broadcast: backing source: strides")
eq(base.dtype,"|S4","zero-stride/S4/broadcast: backing source: dtype")
eq(a.shape,{3,4},"zero-stride/S4/broadcast: source shape")
eq(a.strides,{0,4},"zero-stride/S4/broadcast: source strides")
cases=cases+1
end
-- 152: zero-stride/S4/readonly-broadcast; source error=None
do
local base=np.array({{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"|S4")
local a=np.broadcast_to(base:get(np.s(1,2),np.s()),{3,4})
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"zero-stride/S4/readonly-broadcast: acceptance"..": "..tostring(result))
eq(result:tolist(),{1,2,3,4,5,6,7,8,9,10,11,12},"zero-stride/S4/readonly-broadcast: result")
eq(result.shape,{12},"zero-stride/S4/readonly-broadcast: result: shape")
eq(result.strides,{8},"zero-stride/S4/readonly-broadcast: result: strides")
eq(result.dtype,"int64","zero-stride/S4/readonly-broadcast: result: dtype")
eq(base:tolist(),{{"0","1","2","3"},{"4","5","6","7"},{"8","9","10","11"}},"zero-stride/S4/readonly-broadcast: backing source")
eq(base.shape,{3,4},"zero-stride/S4/readonly-broadcast: backing source: shape")
eq(base.strides,{16,4},"zero-stride/S4/readonly-broadcast: backing source: strides")
eq(base.dtype,"|S4","zero-stride/S4/readonly-broadcast: backing source: dtype")
eq(a.shape,{3,4},"zero-stride/S4/readonly-broadcast: source shape")
eq(a.strides,{0,4},"zero-stride/S4/readonly-broadcast: source strides")
cases=cases+1
end
-- 153: multidim/bool/(2, 3, 4); source error=None
do
local base=np.array({{{false,true,true,false},{true,true,false,true},{true,false,true,true}},{{false,true,true,false},{true,true,false,true},{true,false,true,true}}},"bool")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"multidim/bool/(2, 3, 4): acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,5,6,8,9,11,12,14,15,17,18,20,21,23,24},"multidim/bool/(2, 3, 4): result")
eq(result.shape,{16},"multidim/bool/(2, 3, 4): result: shape")
eq(result.strides,{8},"multidim/bool/(2, 3, 4): result: strides")
eq(result.dtype,"int64","multidim/bool/(2, 3, 4): result: dtype")
eq(base:tolist(),{{{false,true,true,false},{true,true,false,true},{true,false,true,true}},{{false,true,true,false},{true,true,false,true},{true,false,true,true}}},"multidim/bool/(2, 3, 4): backing source")
eq(base.shape,{2,3,4},"multidim/bool/(2, 3, 4): backing source: shape")
eq(base.strides,{12,4,1},"multidim/bool/(2, 3, 4): backing source: strides")
eq(base.dtype,"bool","multidim/bool/(2, 3, 4): backing source: dtype")
eq(a.shape,{2,3,4},"multidim/bool/(2, 3, 4): source shape")
eq(a.strides,{12,4,1},"multidim/bool/(2, 3, 4): source strides")
cases=cases+1
end
-- 154: multidim/bool/(3, 0, 2); source error=None
do
local base=np.zeros({3,0,2},"bool")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"multidim/bool/(3, 0, 2): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"multidim/bool/(3, 0, 2): result")
eq(result.shape,{0},"multidim/bool/(3, 0, 2): result: shape")
eq(result.strides,{8},"multidim/bool/(3, 0, 2): result: strides")
eq(result.dtype,"int64","multidim/bool/(3, 0, 2): result: dtype")
eq(base:tolist(),{{},{},{}},"multidim/bool/(3, 0, 2): backing source")
eq(base.shape,{3,0,2},"multidim/bool/(3, 0, 2): backing source: shape")
eq(base.strides,{0,0,0},"multidim/bool/(3, 0, 2): backing source: strides")
eq(base.dtype,"bool","multidim/bool/(3, 0, 2): backing source: dtype")
eq(a.shape,{3,0,2},"multidim/bool/(3, 0, 2): source shape")
eq(a.strides,{0,0,0},"multidim/bool/(3, 0, 2): source strides")
cases=cases+1
end
-- 155: multidim/bool/(1, 2, 1, 3); source error=None
do
local base=np.array({{{{false,true,true}},{{false,true,true}}}},"bool")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"multidim/bool/(1, 2, 1, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,5,6},"multidim/bool/(1, 2, 1, 3): result")
eq(result.shape,{4},"multidim/bool/(1, 2, 1, 3): result: shape")
eq(result.strides,{8},"multidim/bool/(1, 2, 1, 3): result: strides")
eq(result.dtype,"int64","multidim/bool/(1, 2, 1, 3): result: dtype")
eq(base:tolist(),{{{{false,true,true}},{{false,true,true}}}},"multidim/bool/(1, 2, 1, 3): backing source")
eq(base.shape,{1,2,1,3},"multidim/bool/(1, 2, 1, 3): backing source: shape")
eq(base.strides,{6,3,3,1},"multidim/bool/(1, 2, 1, 3): backing source: strides")
eq(base.dtype,"bool","multidim/bool/(1, 2, 1, 3): backing source: dtype")
eq(a.shape,{1,2,1,3},"multidim/bool/(1, 2, 1, 3): source shape")
eq(a.strides,{6,3,3,1},"multidim/bool/(1, 2, 1, 3): source strides")
cases=cases+1
end
-- 156: multidim/int32/(2, 3, 4); source error=None
do
local base=np.array({{{0,1,2,0},{1,2,0,1},{2,0,1,2}},{{0,1,2,0},{1,2,0,1},{2,0,1,2}}},"int32")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"multidim/int32/(2, 3, 4): acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,5,6,8,9,11,12,14,15,17,18,20,21,23,24},"multidim/int32/(2, 3, 4): result")
eq(result.shape,{16},"multidim/int32/(2, 3, 4): result: shape")
eq(result.strides,{8},"multidim/int32/(2, 3, 4): result: strides")
eq(result.dtype,"int64","multidim/int32/(2, 3, 4): result: dtype")
eq(base:tolist(),{{{0,1,2,0},{1,2,0,1},{2,0,1,2}},{{0,1,2,0},{1,2,0,1},{2,0,1,2}}},"multidim/int32/(2, 3, 4): backing source")
eq(base.shape,{2,3,4},"multidim/int32/(2, 3, 4): backing source: shape")
eq(base.strides,{48,16,4},"multidim/int32/(2, 3, 4): backing source: strides")
eq(base.dtype,"int32","multidim/int32/(2, 3, 4): backing source: dtype")
eq(a.shape,{2,3,4},"multidim/int32/(2, 3, 4): source shape")
eq(a.strides,{48,16,4},"multidim/int32/(2, 3, 4): source strides")
cases=cases+1
end
-- 157: multidim/int32/(3, 0, 2); source error=None
do
local base=np.zeros({3,0,2},"int32")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"multidim/int32/(3, 0, 2): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"multidim/int32/(3, 0, 2): result")
eq(result.shape,{0},"multidim/int32/(3, 0, 2): result: shape")
eq(result.strides,{8},"multidim/int32/(3, 0, 2): result: strides")
eq(result.dtype,"int64","multidim/int32/(3, 0, 2): result: dtype")
eq(base:tolist(),{{},{},{}},"multidim/int32/(3, 0, 2): backing source")
eq(base.shape,{3,0,2},"multidim/int32/(3, 0, 2): backing source: shape")
eq(base.strides,{0,0,0},"multidim/int32/(3, 0, 2): backing source: strides")
eq(base.dtype,"int32","multidim/int32/(3, 0, 2): backing source: dtype")
eq(a.shape,{3,0,2},"multidim/int32/(3, 0, 2): source shape")
eq(a.strides,{0,0,0},"multidim/int32/(3, 0, 2): source strides")
cases=cases+1
end
-- 158: multidim/int32/(1, 2, 1, 3); source error=None
do
local base=np.array({{{{0,1,2}},{{0,1,2}}}},"int32")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"multidim/int32/(1, 2, 1, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,5,6},"multidim/int32/(1, 2, 1, 3): result")
eq(result.shape,{4},"multidim/int32/(1, 2, 1, 3): result: shape")
eq(result.strides,{8},"multidim/int32/(1, 2, 1, 3): result: strides")
eq(result.dtype,"int64","multidim/int32/(1, 2, 1, 3): result: dtype")
eq(base:tolist(),{{{{0,1,2}},{{0,1,2}}}},"multidim/int32/(1, 2, 1, 3): backing source")
eq(base.shape,{1,2,1,3},"multidim/int32/(1, 2, 1, 3): backing source: shape")
eq(base.strides,{24,12,12,4},"multidim/int32/(1, 2, 1, 3): backing source: strides")
eq(base.dtype,"int32","multidim/int32/(1, 2, 1, 3): backing source: dtype")
eq(a.shape,{1,2,1,3},"multidim/int32/(1, 2, 1, 3): source shape")
eq(a.strides,{24,12,12,4},"multidim/int32/(1, 2, 1, 3): source strides")
cases=cases+1
end
-- 159: multidim/float32/(2, 3, 4); source error=None
do
local base=np.array({{{0.0,1.0,2.0,0.0},{1.0,2.0,0.0,1.0},{2.0,0.0,1.0,2.0}},{{0.0,1.0,2.0,0.0},{1.0,2.0,0.0,1.0},{2.0,0.0,1.0,2.0}}},"float32")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"multidim/float32/(2, 3, 4): acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,5,6,8,9,11,12,14,15,17,18,20,21,23,24},"multidim/float32/(2, 3, 4): result")
eq(result.shape,{16},"multidim/float32/(2, 3, 4): result: shape")
eq(result.strides,{8},"multidim/float32/(2, 3, 4): result: strides")
eq(result.dtype,"int64","multidim/float32/(2, 3, 4): result: dtype")
eq(base:tolist(),{{{0.0,1.0,2.0,0.0},{1.0,2.0,0.0,1.0},{2.0,0.0,1.0,2.0}},{{0.0,1.0,2.0,0.0},{1.0,2.0,0.0,1.0},{2.0,0.0,1.0,2.0}}},"multidim/float32/(2, 3, 4): backing source")
eq(base.shape,{2,3,4},"multidim/float32/(2, 3, 4): backing source: shape")
eq(base.strides,{48,16,4},"multidim/float32/(2, 3, 4): backing source: strides")
eq(base.dtype,"float32","multidim/float32/(2, 3, 4): backing source: dtype")
eq(a.shape,{2,3,4},"multidim/float32/(2, 3, 4): source shape")
eq(a.strides,{48,16,4},"multidim/float32/(2, 3, 4): source strides")
cases=cases+1
end
-- 160: multidim/float32/(3, 0, 2); source error=None
do
local base=np.zeros({3,0,2},"float32")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"multidim/float32/(3, 0, 2): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"multidim/float32/(3, 0, 2): result")
eq(result.shape,{0},"multidim/float32/(3, 0, 2): result: shape")
eq(result.strides,{8},"multidim/float32/(3, 0, 2): result: strides")
eq(result.dtype,"int64","multidim/float32/(3, 0, 2): result: dtype")
eq(base:tolist(),{{},{},{}},"multidim/float32/(3, 0, 2): backing source")
eq(base.shape,{3,0,2},"multidim/float32/(3, 0, 2): backing source: shape")
eq(base.strides,{0,0,0},"multidim/float32/(3, 0, 2): backing source: strides")
eq(base.dtype,"float32","multidim/float32/(3, 0, 2): backing source: dtype")
eq(a.shape,{3,0,2},"multidim/float32/(3, 0, 2): source shape")
eq(a.strides,{0,0,0},"multidim/float32/(3, 0, 2): source strides")
cases=cases+1
end
-- 161: multidim/float32/(1, 2, 1, 3); source error=None
do
local base=np.array({{{{0.0,1.0,2.0}},{{0.0,1.0,2.0}}}},"float32")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"multidim/float32/(1, 2, 1, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,5,6},"multidim/float32/(1, 2, 1, 3): result")
eq(result.shape,{4},"multidim/float32/(1, 2, 1, 3): result: shape")
eq(result.strides,{8},"multidim/float32/(1, 2, 1, 3): result: strides")
eq(result.dtype,"int64","multidim/float32/(1, 2, 1, 3): result: dtype")
eq(base:tolist(),{{{{0.0,1.0,2.0}},{{0.0,1.0,2.0}}}},"multidim/float32/(1, 2, 1, 3): backing source")
eq(base.shape,{1,2,1,3},"multidim/float32/(1, 2, 1, 3): backing source: shape")
eq(base.strides,{24,12,12,4},"multidim/float32/(1, 2, 1, 3): backing source: strides")
eq(base.dtype,"float32","multidim/float32/(1, 2, 1, 3): backing source: dtype")
eq(a.shape,{1,2,1,3},"multidim/float32/(1, 2, 1, 3): source shape")
eq(a.strides,{24,12,12,4},"multidim/float32/(1, 2, 1, 3): source strides")
cases=cases+1
end
-- 162: multidim/complex128/(2, 3, 4); source error=None
do
local base=np.array({{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(0.0,0.0)},{np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(0.0,0.0),np.complex(1.0,0.0)},{np.complex(2.0,0.0),np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0)}},{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(0.0,0.0)},{np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(0.0,0.0),np.complex(1.0,0.0)},{np.complex(2.0,0.0),np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0)}}},"complex128")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"multidim/complex128/(2, 3, 4): acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,5,6,8,9,11,12,14,15,17,18,20,21,23,24},"multidim/complex128/(2, 3, 4): result")
eq(result.shape,{16},"multidim/complex128/(2, 3, 4): result: shape")
eq(result.strides,{8},"multidim/complex128/(2, 3, 4): result: strides")
eq(result.dtype,"int64","multidim/complex128/(2, 3, 4): result: dtype")
eq(base:tolist(),{{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(0.0,0.0)},{np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(0.0,0.0),np.complex(1.0,0.0)},{np.complex(2.0,0.0),np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0)}},{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(0.0,0.0)},{np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(0.0,0.0),np.complex(1.0,0.0)},{np.complex(2.0,0.0),np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0)}}},"multidim/complex128/(2, 3, 4): backing source")
eq(base.shape,{2,3,4},"multidim/complex128/(2, 3, 4): backing source: shape")
eq(base.strides,{192,64,16},"multidim/complex128/(2, 3, 4): backing source: strides")
eq(base.dtype,"complex128","multidim/complex128/(2, 3, 4): backing source: dtype")
eq(a.shape,{2,3,4},"multidim/complex128/(2, 3, 4): source shape")
eq(a.strides,{192,64,16},"multidim/complex128/(2, 3, 4): source strides")
cases=cases+1
end
-- 163: multidim/complex128/(3, 0, 2); source error=None
do
local base=np.zeros({3,0,2},"complex128")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"multidim/complex128/(3, 0, 2): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"multidim/complex128/(3, 0, 2): result")
eq(result.shape,{0},"multidim/complex128/(3, 0, 2): result: shape")
eq(result.strides,{8},"multidim/complex128/(3, 0, 2): result: strides")
eq(result.dtype,"int64","multidim/complex128/(3, 0, 2): result: dtype")
eq(base:tolist(),{{},{},{}},"multidim/complex128/(3, 0, 2): backing source")
eq(base.shape,{3,0,2},"multidim/complex128/(3, 0, 2): backing source: shape")
eq(base.strides,{0,0,0},"multidim/complex128/(3, 0, 2): backing source: strides")
eq(base.dtype,"complex128","multidim/complex128/(3, 0, 2): backing source: dtype")
eq(a.shape,{3,0,2},"multidim/complex128/(3, 0, 2): source shape")
eq(a.strides,{0,0,0},"multidim/complex128/(3, 0, 2): source strides")
cases=cases+1
end
-- 164: multidim/complex128/(1, 2, 1, 3); source error=None
do
local base=np.array({{{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0)}},{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0)}}}},"complex128")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"multidim/complex128/(1, 2, 1, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{2,3,5,6},"multidim/complex128/(1, 2, 1, 3): result")
eq(result.shape,{4},"multidim/complex128/(1, 2, 1, 3): result: shape")
eq(result.strides,{8},"multidim/complex128/(1, 2, 1, 3): result: strides")
eq(result.dtype,"int64","multidim/complex128/(1, 2, 1, 3): result: dtype")
eq(base:tolist(),{{{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0)}},{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0)}}}},"multidim/complex128/(1, 2, 1, 3): backing source")
eq(base.shape,{1,2,1,3},"multidim/complex128/(1, 2, 1, 3): backing source: shape")
eq(base.strides,{96,48,48,16},"multidim/complex128/(1, 2, 1, 3): backing source: strides")
eq(base.dtype,"complex128","multidim/complex128/(1, 2, 1, 3): backing source: dtype")
eq(a.shape,{1,2,1,3},"multidim/complex128/(1, 2, 1, 3): source shape")
eq(a.strides,{96,48,48,16},"multidim/complex128/(1, 2, 1, 3): source strides")
cases=cases+1
end
-- 165: max-rank/1; source error=None
do
local base=np.array({1},"int32")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"max-rank/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{1},"max-rank/1: result")
eq(result.shape,{1},"max-rank/1: result: shape")
eq(result.strides,{8},"max-rank/1: result: strides")
eq(result.dtype,"int64","max-rank/1: result: dtype")
eq(base:tolist(),{1},"max-rank/1: backing source")
eq(base.shape,{1},"max-rank/1: backing source: shape")
eq(base.strides,{4},"max-rank/1: backing source: strides")
eq(base.dtype,"int32","max-rank/1: backing source: dtype")
eq(a.shape,{1},"max-rank/1: source shape")
eq(a.strides,{4},"max-rank/1: source strides")
cases=cases+1
end
-- 166: max-rank/32; source error=None
do
local base=np.array({{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{1}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}},"int32")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"max-rank/32: acceptance"..": "..tostring(result))
eq(result:tolist(),{1},"max-rank/32: result")
eq(result.shape,{1},"max-rank/32: result: shape")
eq(result.strides,{8},"max-rank/32: result: strides")
eq(result.dtype,"int64","max-rank/32: result: dtype")
eq(base:tolist(),{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{1}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}},"max-rank/32: backing source")
eq(base.shape,{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},"max-rank/32: backing source: shape")
eq(base.strides,{4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4},"max-rank/32: backing source: strides")
eq(base.dtype,"int32","max-rank/32: backing source: dtype")
eq(a.shape,{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},"max-rank/32: source shape")
eq(a.strides,{4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4},"max-rank/32: source strides")
cases=cases+1
end
-- 167: max-rank/63; source error=None
do
local base=np.array({{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{1}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}},"int32")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"max-rank/63: acceptance"..": "..tostring(result))
eq(result:tolist(),{1},"max-rank/63: result")
eq(result.shape,{1},"max-rank/63: result: shape")
eq(result.strides,{8},"max-rank/63: result: strides")
eq(result.dtype,"int64","max-rank/63: result: dtype")
eq(base:tolist(),{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{1}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}},"max-rank/63: backing source")
eq(base.shape,{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},"max-rank/63: backing source: shape")
eq(base.strides,{4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4},"max-rank/63: backing source: strides")
eq(base.dtype,"int32","max-rank/63: backing source: dtype")
eq(a.shape,{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},"max-rank/63: source shape")
eq(a.strides,{4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4},"max-rank/63: source strides")
cases=cases+1
end
-- 168: max-rank/64; source error=None
do
local base=np.array({{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{1}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}},"int32")
local a=base
local ok,result=pcall(function() return np.flatnonzero(a) end)
assert(ok==true,"max-rank/64: acceptance"..": "..tostring(result))
eq(result:tolist(),{1},"max-rank/64: result")
eq(result.shape,{1},"max-rank/64: result: shape")
eq(result.strides,{8},"max-rank/64: result: strides")
eq(result.dtype,"int64","max-rank/64: result: dtype")
eq(base:tolist(),{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{1}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}},"max-rank/64: backing source")
eq(base.shape,{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},"max-rank/64: backing source: shape")
eq(base.strides,{4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4},"max-rank/64: backing source: strides")
eq(base.dtype,"int32","max-rank/64: backing source: dtype")
eq(a.shape,{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},"max-rank/64: source shape")
eq(a.strides,{4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4},"max-rank/64: source strides")
cases=cases+1
end
end
chunk()
end
assert(cases==168)
print('flatnonzero103 differential: '..cases..' cases, '..checks..' checks passed')
