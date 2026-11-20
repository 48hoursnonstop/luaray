local lr=require('luaray')

local rows=lr.lexsort({{3,1,3,2,1},{0,0,0,1,0}})
assert(table.concat(rows:tolist(),',')=='2,5,1,3,4')

local keys=lr.array({{3,1,3,2,1},{0,0,0,1,0}})
assert(table.concat(lr.lexsort(keys):tolist(),',')=='2,5,1,3,4')

local primary=lr.array({'a','b','a\0b','','é'},'U3')
local native=lr.lexsort({primary})
assert(table.concat(native:tolist(),',')=='4,1,3,2,5')
local switched=lr.astype(primary,'>U3')
assert(table.concat(lr.lexsort({switched}):tolist(),',')=='4,1,2,5,3')

local time=lr.array({lr.timedelta64('NaT','h'),lr.timedelta64(2,'h'),
  lr.timedelta64(-1,'h'),lr.timedelta64('NaT','h')},'timedelta64[h]')
assert(table.concat(lr.lexsort({time}):tolist(),',')=='3,2,1,4')
local scalar=lr.lexsort({3,1})
assert(scalar.ndim==0 and scalar:item()==1)
assert(lr.lexsort({lr.empty({0,3}),lr.empty({0,3})},2).size==0)
assert(not pcall(lr.lexsort,{}))
assert(not pcall(lr.lexsort,{{1},{2,3}}))
assert(not pcall(lr.lexsort,{{1,2}},0))
print('Lexicographic sort regression passed')
