local lr=require('luaray')
local checks=0
local function eq(a,b)checks=checks+1;assert(a==b)end
for _,value in ipairs({math.maxinteger,math.mininteger,9007199254740993,-9007199254740993,1,0})do
 local ordinary=lr.array(value,'clongdouble')
 local expected=lr.array(value+0.0,'clongdouble')
 eq(lr.array_equal(ordinary,expected),true)
 eq(lr.array_equal(lr.full({3},value,'clongdouble'),lr.full({3},expected,'clongdouble')),true)
 local a=lr.empty({3},'clongdouble');a:fill(value)
 eq(lr.array_equal(a,lr.full({3},expected,'clongdouble')),true)
 a[1]=value;eq(lr.array_equal(a[1],expected),true)
 lr.copyto(a,value,'unsafe');eq(lr.array_equal(a,lr.full({3},expected,'clongdouble')),true)
 local stream=lr.fromiter(function()return value end,'clongdouble',1)
 eq(lr.array_equal(stream,lr.full({1},expected,'clongdouble')),true)
 eq(lr.array_equal(lr.add(lr.zeros({3},'clongdouble'),value),lr.full({3},expected,'clongdouble')),true)
 local typed=lr.array(value,'int64');local strong=lr.array(typed,'clongdouble')
 local real=lr.array(value,'longdouble')
 eq(lr.array_equal(lr.real(strong),real),true)
 eq(lr.array_equal(lr.full({1},typed,'clongdouble'),lr.full({1},strong,'clongdouble')),true)
 local copied=lr.empty({1},'clongdouble');lr.copyto(copied,typed,'unsafe')
 eq(lr.array_equal(copied,lr.full({1},strong,'clongdouble')),true)
end
if lr.finfo('longdouble').nmant>52 then
 eq(lr.array_equal(lr.array(math.maxinteger,'clongdouble'),lr.array(lr.array(math.maxinteger,'int64'),'clongdouble')),false)
end
print('scalar packing regression: '..checks..' checks passed')
