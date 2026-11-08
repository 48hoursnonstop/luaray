local np=require('luaray_core')
local cases=0

local function equal(actual,expected)
 if type(expected)=='table' then
  assert(type(actual)=='table' and #actual==#expected,'case '..cases..' table length')
  for i=1,#expected do equal(actual[i],expected[i]) end
 elseif type(expected)=='number' then
  assert(type(actual)=='number' and (actual==expected or (actual~=actual and expected~=expected)),
   'case '..cases..': number mismatch '..tostring(actual)..' ~= '..tostring(expected))
 else assert(actual==expected,'case '..cases..' value mismatch '..tostring(actual)..' ~= '..tostring(expected)) end
end
local function check(arr,shape,dtype,data)
 assert(arr.ndim==#shape,'case '..cases..' ndim')
 assert(arr.dtype==dtype,'case '..cases..' dtype '..arr.dtype..' ~= '..dtype)
 equal(arr.shape,shape);equal(arr:tolist(),data)
end

check(np.hstack({np.reshape(np.array({false},"bool"),{}),np.reshape(np.array({false},"bool"),{})}),{2},"bool",{false,false})
cases=cases+1
check(np.vstack({np.reshape(np.array({false},"bool"),{}),np.reshape(np.array({false},"bool"),{})}),{2,1},"bool",{{false},{false}})
cases=cases+1
check(np.dstack({np.reshape(np.array({false},"bool"),{}),np.reshape(np.array({false},"bool"),{})}),{1,1,2},"bool",{{{false,false}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({false},"bool"),{}),np.reshape(np.array({false},"bool"),{})}),{1,2},"bool",{{false,false}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({false},"bool"),{}),np.reshape(np.array({false},"bool"),{})}),{2,1},"bool",{{false},{false}})
cases=cases+1
check(np.hstack({np.reshape(np.array({false},"bool"),{}),np.flip(np.reshape(np.array({false,true,false},"bool"),{3}),1)}),{4},"bool",{false,false,true,false})
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({false},"bool"),{}),np.flip(np.reshape(np.array({false,true,false},"bool"),{3}),1)}) end),"case 6 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({false},"bool"),{}),np.flip(np.reshape(np.array({false,true,false},"bool"),{3}),1)}) end),"case 7 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({false},"bool"),{}),np.flip(np.reshape(np.array({false,true,false},"bool"),{3}),1)}) end),"case 8 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({false},"bool"),{}),np.flip(np.reshape(np.array({false,true,false},"bool"),{3}),1)}) end),"case 9 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({false},"bool"),{}),np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}).T}) end),"case 10 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({false},"bool"),{}),np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}).T}) end),"case 11 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({false},"bool"),{}),np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}).T}) end),"case 12 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({false},"bool"),{}),np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}).T}) end),"case 13 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({false},"bool"),{}),np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}).T}) end),"case 14 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({},"bool"),{0}),np.reshape(np.array({},"bool"),{0})}),{0},"bool",{})
cases=cases+1
check(np.vstack({np.reshape(np.array({},"bool"),{0}),np.reshape(np.array({},"bool"),{0})}),{2,0},"bool",{{},{}})
cases=cases+1
check(np.dstack({np.reshape(np.array({},"bool"),{0}),np.reshape(np.array({},"bool"),{0})}),{1,0,2},"bool",{{}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"bool"),{0}),np.reshape(np.array({},"bool"),{0})}),{0,2},"bool",{})
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"bool"),{0}),np.reshape(np.array({},"bool"),{0})}),{2,0},"bool",{{},{}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"bool"),{0}),np.reshape(np.array({},"bool"),{0,2})}) end),"case 20 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"bool"),{0}),np.reshape(np.array({},"bool"),{0,2})}) end),"case 21 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"bool"),{0}),np.reshape(np.array({},"bool"),{0,2})}) end),"case 22 expected failure")
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"bool"),{0}),np.reshape(np.array({},"bool"),{0,2})}),{0,3},"bool",{})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"bool"),{0}),np.reshape(np.array({},"bool"),{0,2})}) end),"case 24 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"bool"),{0}),np.reshape(np.array({true,false,false,true},"bool"),{2,1,2})}) end),"case 25 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"bool"),{0}),np.reshape(np.array({true,false,false,true},"bool"),{2,1,2})}) end),"case 26 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"bool"),{0}),np.reshape(np.array({true,false,false,true},"bool"),{2,1,2})}) end),"case 27 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"bool"),{0}),np.reshape(np.array({true,false,false,true},"bool"),{2,1,2})}) end),"case 28 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"bool"),{0}),np.reshape(np.array({true,false,false,true},"bool"),{2,1,2})}) end),"case 29 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({false},"bool"),{1}),np.reshape(np.array({false},"bool"),{1})}),{2},"bool",{false,false})
cases=cases+1
check(np.vstack({np.reshape(np.array({false},"bool"),{1}),np.reshape(np.array({false},"bool"),{1})}),{2,1},"bool",{{false},{false}})
cases=cases+1
check(np.dstack({np.reshape(np.array({false},"bool"),{1}),np.reshape(np.array({false},"bool"),{1})}),{1,1,2},"bool",{{{false,false}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({false},"bool"),{1}),np.reshape(np.array({false},"bool"),{1})}),{1,2},"bool",{{false,false}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({false},"bool"),{1}),np.reshape(np.array({false},"bool"),{1})}),{2,1},"bool",{{false},{false}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({false},"bool"),{1}),np.reshape(np.array({},"bool"),{0,2}).T}) end),"case 35 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({false},"bool"),{1}),np.reshape(np.array({},"bool"),{0,2}).T}) end),"case 36 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({false},"bool"),{1}),np.reshape(np.array({},"bool"),{0,2}).T}) end),"case 37 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({false},"bool"),{1}),np.reshape(np.array({},"bool"),{0,2}).T}) end),"case 38 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({false},"bool"),{1}),np.reshape(np.array({},"bool"),{0,2}).T}) end),"case 39 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({false},"bool"),{1}),np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),1)}) end),"case 40 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({false},"bool"),{1}),np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),1)}) end),"case 41 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({false},"bool"),{1}),np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),1)}) end),"case 42 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({false},"bool"),{1}),np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),1)}) end),"case 43 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({false},"bool"),{1}),np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),1)}) end),"case 44 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({false},"bool"),{1}),1),np.flip(np.reshape(np.array({false},"bool"),{1}),1)}),{2},"bool",{false,false})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({false},"bool"),{1}),1),np.flip(np.reshape(np.array({false},"bool"),{1}),1)}),{2,1},"bool",{{false},{false}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({false},"bool"),{1}),1),np.flip(np.reshape(np.array({false},"bool"),{1}),1)}),{1,1,2},"bool",{{{false,false}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({false},"bool"),{1}),1),np.flip(np.reshape(np.array({false},"bool"),{1}),1)}),{1,2},"bool",{{false,false}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({false},"bool"),{1}),1),np.flip(np.reshape(np.array({false},"bool"),{1}),1)}),{2,1},"bool",{{false},{false}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({false},"bool"),{1}),1),np.reshape(np.array({},"bool"),{2,0})}) end),"case 50 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({false},"bool"),{1}),1),np.reshape(np.array({},"bool"),{2,0})}) end),"case 51 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({false},"bool"),{1}),1),np.reshape(np.array({},"bool"),{2,0})}) end),"case 52 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({false},"bool"),{1}),1),np.reshape(np.array({},"bool"),{2,0})}) end),"case 53 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({false},"bool"),{1}),1),np.reshape(np.array({},"bool"),{2,0})}) end),"case 54 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({false},"bool"),{1}),1),np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}).T}) end),"case 55 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({false},"bool"),{1}),1),np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}).T}) end),"case 56 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({false},"bool"),{1}),1),np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}).T}) end),"case 57 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({false},"bool"),{1}),1),np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}).T}) end),"case 58 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({false},"bool"),{1}),1),np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}).T}) end),"case 59 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({true,false},"bool"),{2}),np.reshape(np.array({true,false},"bool"),{2})}),{4},"bool",{true,false,true,false})
cases=cases+1
check(np.vstack({np.reshape(np.array({true,false},"bool"),{2}),np.reshape(np.array({true,false},"bool"),{2})}),{2,2},"bool",{{true,false},{true,false}})
cases=cases+1
check(np.dstack({np.reshape(np.array({true,false},"bool"),{2}),np.reshape(np.array({true,false},"bool"),{2})}),{1,2,2},"bool",{{{true,true},{false,false}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({true,false},"bool"),{2}),np.reshape(np.array({true,false},"bool"),{2})}),{2,2},"bool",{{true,true},{false,false}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({true,false},"bool"),{2}),np.reshape(np.array({true,false},"bool"),{2})}),{2,2},"bool",{{true,false},{true,false}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({true,false},"bool"),{2}),np.reshape(np.array({},"bool"),{2,0}).T}) end),"case 65 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({true,false},"bool"),{2}),np.reshape(np.array({},"bool"),{2,0}).T}),{1,2},"bool",{{true,false}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({true,false},"bool"),{2}),np.reshape(np.array({},"bool"),{2,0}).T}) end),"case 67 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({true,false},"bool"),{2}),np.reshape(np.array({},"bool"),{2,0}).T}) end),"case 68 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({true,false},"bool"),{2}),np.reshape(np.array({},"bool"),{2,0}).T}),{1,2},"bool",{{true,false}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({true,false},"bool"),{2}),np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2})}) end),"case 70 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({true,false},"bool"),{2}),np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2})}) end),"case 71 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({true,false},"bool"),{2}),np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2})}) end),"case 72 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({true,false},"bool"),{2}),np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2})}) end),"case 73 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({true,false},"bool"),{2}),np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2})}) end),"case 74 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({true,false},"bool"),{2}),1),np.flip(np.reshape(np.array({true,false},"bool"),{2}),1)}),{4},"bool",{false,true,false,true})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({true,false},"bool"),{2}),1),np.flip(np.reshape(np.array({true,false},"bool"),{2}),1)}),{2,2},"bool",{{false,true},{false,true}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({true,false},"bool"),{2}),1),np.flip(np.reshape(np.array({true,false},"bool"),{2}),1)}),{1,2,2},"bool",{{{false,false},{true,true}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({true,false},"bool"),{2}),1),np.flip(np.reshape(np.array({true,false},"bool"),{2}),1)}),{2,2},"bool",{{false,false},{true,true}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({true,false},"bool"),{2}),1),np.flip(np.reshape(np.array({true,false},"bool"),{2}),1)}),{2,2},"bool",{{false,true},{false,true}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({true,false},"bool"),{2}),1),np.reshape(np.array({false,false},"bool"),{1,2})}) end),"case 80 expected failure")
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({true,false},"bool"),{2}),1),np.reshape(np.array({false,false},"bool"),{1,2})}),{2,2},"bool",{{false,true},{false,false}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({true,false},"bool"),{2}),1),np.reshape(np.array({false,false},"bool"),{1,2})}),{1,2,2},"bool",{{{false,false},{true,false}}})
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({true,false},"bool"),{2}),1),np.reshape(np.array({false,false},"bool"),{1,2})}) end),"case 83 expected failure")
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({true,false},"bool"),{2}),1),np.reshape(np.array({false,false},"bool"),{1,2})}),{2,2},"bool",{{false,true},{false,false}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({true,false},"bool"),{2}),1),np.flip(np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),1)}) end),"case 85 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({true,false},"bool"),{2}),1),np.flip(np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),1)}) end),"case 86 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({true,false},"bool"),{2}),1),np.flip(np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),1)}) end),"case 87 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({true,false},"bool"),{2}),1),np.flip(np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),1)}) end),"case 88 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({true,false},"bool"),{2}),1),np.flip(np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),1)}) end),"case 89 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({false,true,false},"bool"),{3}),np.reshape(np.array({false,true,false},"bool"),{3})}),{6},"bool",{false,true,false,false,true,false})
cases=cases+1
check(np.vstack({np.reshape(np.array({false,true,false},"bool"),{3}),np.reshape(np.array({false,true,false},"bool"),{3})}),{2,3},"bool",{{false,true,false},{false,true,false}})
cases=cases+1
check(np.dstack({np.reshape(np.array({false,true,false},"bool"),{3}),np.reshape(np.array({false,true,false},"bool"),{3})}),{1,3,2},"bool",{{{false,false},{true,true},{false,false}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({false,true,false},"bool"),{3}),np.reshape(np.array({false,true,false},"bool"),{3})}),{3,2},"bool",{{false,false},{true,true},{false,false}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({false,true,false},"bool"),{3}),np.reshape(np.array({false,true,false},"bool"),{3})}),{2,3},"bool",{{false,true,false},{false,true,false}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({false,true,false},"bool"),{3}),np.flip(np.reshape(np.array({false,false},"bool"),{1,2}),1)}) end),"case 95 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({false,true,false},"bool"),{3}),np.flip(np.reshape(np.array({false,false},"bool"),{1,2}),1)}) end),"case 96 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({false,true,false},"bool"),{3}),np.flip(np.reshape(np.array({false,false},"bool"),{1,2}),1)}) end),"case 97 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({false,true,false},"bool"),{3}),np.flip(np.reshape(np.array({false,false},"bool"),{1,2}),1)}) end),"case 98 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({false,true,false},"bool"),{3}),np.flip(np.reshape(np.array({false,false},"bool"),{1,2}),1)}) end),"case 99 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({false,true,false},"bool"),{3}),np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}).T}) end),"case 100 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({false,true,false},"bool"),{3}),np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}).T}) end),"case 101 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({false,true,false},"bool"),{3}),np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}).T}) end),"case 102 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({false,true,false},"bool"),{3}),np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}).T}) end),"case 103 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({false,true,false},"bool"),{3}),np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}).T}) end),"case 104 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({false,true,false},"bool"),{3}),1),np.flip(np.reshape(np.array({false,true,false},"bool"),{3}),1)}),{6},"bool",{false,true,false,false,true,false})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({false,true,false},"bool"),{3}),1),np.flip(np.reshape(np.array({false,true,false},"bool"),{3}),1)}),{2,3},"bool",{{false,true,false},{false,true,false}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({false,true,false},"bool"),{3}),1),np.flip(np.reshape(np.array({false,true,false},"bool"),{3}),1)}),{1,3,2},"bool",{{{false,false},{true,true},{false,false}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({false,true,false},"bool"),{3}),1),np.flip(np.reshape(np.array({false,true,false},"bool"),{3}),1)}),{3,2},"bool",{{false,false},{true,true},{false,false}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({false,true,false},"bool"),{3}),1),np.flip(np.reshape(np.array({false,true,false},"bool"),{3}),1)}),{2,3},"bool",{{false,true,false},{false,true,false}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({false,true,false},"bool"),{3}),1),np.reshape(np.array({false,false},"bool"),{1,2}).T}) end),"case 110 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({false,true,false},"bool"),{3}),1),np.reshape(np.array({false,false},"bool"),{1,2}).T}) end),"case 111 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({false,true,false},"bool"),{3}),1),np.reshape(np.array({false,false},"bool"),{1,2}).T}) end),"case 112 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({false,true,false},"bool"),{3}),1),np.reshape(np.array({false,false},"bool"),{1,2}).T}) end),"case 113 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({false,true,false},"bool"),{3}),1),np.reshape(np.array({false,false},"bool"),{1,2}).T}) end),"case 114 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({false,true,false},"bool"),{3}),1),np.reshape(np.array({false},"bool"),{})}),{4},"bool",{false,true,false,false})
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({false,true,false},"bool"),{3}),1),np.reshape(np.array({false},"bool"),{})}) end),"case 116 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({false,true,false},"bool"),{3}),1),np.reshape(np.array({false},"bool"),{})}) end),"case 117 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({false,true,false},"bool"),{3}),1),np.reshape(np.array({false},"bool"),{})}) end),"case 118 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({false,true,false},"bool"),{3}),1),np.reshape(np.array({false},"bool"),{})}) end),"case 119 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({},"bool"),{0,2}),np.reshape(np.array({},"bool"),{0,2})}),{0,4},"bool",{})
cases=cases+1
check(np.vstack({np.reshape(np.array({},"bool"),{0,2}),np.reshape(np.array({},"bool"),{0,2})}),{0,2},"bool",{})
cases=cases+1
check(np.dstack({np.reshape(np.array({},"bool"),{0,2}),np.reshape(np.array({},"bool"),{0,2})}),{0,2,2},"bool",{})
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"bool"),{0,2}),np.reshape(np.array({},"bool"),{0,2})}),{0,4},"bool",{})
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"bool"),{0,2}),np.reshape(np.array({},"bool"),{0,2})}),{0,2},"bool",{})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"bool"),{0,2}),np.reshape(np.array({true,false},"bool"),{2,1})}) end),"case 125 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"bool"),{0,2}),np.reshape(np.array({true,false},"bool"),{2,1})}) end),"case 126 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"bool"),{0,2}),np.reshape(np.array({true,false},"bool"),{2,1})}) end),"case 127 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"bool"),{0,2}),np.reshape(np.array({true,false},"bool"),{2,1})}) end),"case 128 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"bool"),{0,2}),np.reshape(np.array({true,false},"bool"),{2,1})}) end),"case 129 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"bool"),{0,2}),np.reshape(np.array({},"bool"),{0})}) end),"case 130 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"bool"),{0,2}),np.reshape(np.array({},"bool"),{0})}) end),"case 131 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"bool"),{0,2}),np.reshape(np.array({},"bool"),{0})}) end),"case 132 expected failure")
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"bool"),{0,2}),np.reshape(np.array({},"bool"),{0})}),{0,3},"bool",{})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"bool"),{0,2}),np.reshape(np.array({},"bool"),{0})}) end),"case 134 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({},"bool"),{0,2}).T,np.reshape(np.array({},"bool"),{0,2}).T}),{2,0},"bool",{{},{}})
cases=cases+1
check(np.vstack({np.reshape(np.array({},"bool"),{0,2}).T,np.reshape(np.array({},"bool"),{0,2}).T}),{4,0},"bool",{{},{},{},{}})
cases=cases+1
check(np.dstack({np.reshape(np.array({},"bool"),{0,2}).T,np.reshape(np.array({},"bool"),{0,2}).T}),{2,0,2},"bool",{{},{}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"bool"),{0,2}).T,np.reshape(np.array({},"bool"),{0,2}).T}),{2,0},"bool",{{},{}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"bool"),{0,2}).T,np.reshape(np.array({},"bool"),{0,2}).T}),{4,0},"bool",{{},{},{},{}})
cases=cases+1
check(np.hstack({np.reshape(np.array({},"bool"),{0,2}).T,np.flip(np.reshape(np.array({true,false},"bool"),{2,1}),1)}),{2,1},"bool",{{false},{true}})
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"bool"),{0,2}).T,np.flip(np.reshape(np.array({true,false},"bool"),{2,1}),1)}) end),"case 141 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"bool"),{0,2}).T,np.flip(np.reshape(np.array({true,false},"bool"),{2,1}),1)}) end),"case 142 expected failure")
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"bool"),{0,2}).T,np.flip(np.reshape(np.array({true,false},"bool"),{2,1}),1)}),{2,1},"bool",{{false},{true}})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"bool"),{0,2}).T,np.flip(np.reshape(np.array({true,false},"bool"),{2,1}),1)}) end),"case 144 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"bool"),{0,2}).T,np.reshape(np.array({false},"bool"),{1})}) end),"case 145 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"bool"),{0,2}).T,np.reshape(np.array({false},"bool"),{1})}) end),"case 146 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"bool"),{0,2}).T,np.reshape(np.array({false},"bool"),{1})}) end),"case 147 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"bool"),{0,2}).T,np.reshape(np.array({false},"bool"),{1})}) end),"case 148 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"bool"),{0,2}).T,np.reshape(np.array({false},"bool"),{1})}) end),"case 149 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({},"bool"),{2,0}),np.reshape(np.array({},"bool"),{2,0})}),{2,0},"bool",{{},{}})
cases=cases+1
check(np.vstack({np.reshape(np.array({},"bool"),{2,0}),np.reshape(np.array({},"bool"),{2,0})}),{4,0},"bool",{{},{},{},{}})
cases=cases+1
check(np.dstack({np.reshape(np.array({},"bool"),{2,0}),np.reshape(np.array({},"bool"),{2,0})}),{2,0,2},"bool",{{},{}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"bool"),{2,0}),np.reshape(np.array({},"bool"),{2,0})}),{2,0},"bool",{{},{}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"bool"),{2,0}),np.reshape(np.array({},"bool"),{2,0})}),{4,0},"bool",{{},{},{},{}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"bool"),{2,0}),np.reshape(np.array({true,false},"bool"),{2,1}).T}) end),"case 155 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"bool"),{2,0}),np.reshape(np.array({true,false},"bool"),{2,1}).T}) end),"case 156 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"bool"),{2,0}),np.reshape(np.array({true,false},"bool"),{2,1}).T}) end),"case 157 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"bool"),{2,0}),np.reshape(np.array({true,false},"bool"),{2,1}).T}) end),"case 158 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"bool"),{2,0}),np.reshape(np.array({true,false},"bool"),{2,1}).T}) end),"case 159 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"bool"),{2,0}),np.flip(np.reshape(np.array({false},"bool"),{1}),1)}) end),"case 160 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"bool"),{2,0}),np.flip(np.reshape(np.array({false},"bool"),{1}),1)}) end),"case 161 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"bool"),{2,0}),np.flip(np.reshape(np.array({false},"bool"),{1}),1)}) end),"case 162 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"bool"),{2,0}),np.flip(np.reshape(np.array({false},"bool"),{1}),1)}) end),"case 163 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"bool"),{2,0}),np.flip(np.reshape(np.array({false},"bool"),{1}),1)}) end),"case 164 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({},"bool"),{2,0}).T,np.reshape(np.array({},"bool"),{2,0}).T}),{0,4},"bool",{})
cases=cases+1
check(np.vstack({np.reshape(np.array({},"bool"),{2,0}).T,np.reshape(np.array({},"bool"),{2,0}).T}),{0,2},"bool",{})
cases=cases+1
check(np.dstack({np.reshape(np.array({},"bool"),{2,0}).T,np.reshape(np.array({},"bool"),{2,0}).T}),{0,2,2},"bool",{})
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"bool"),{2,0}).T,np.reshape(np.array({},"bool"),{2,0}).T}),{0,4},"bool",{})
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"bool"),{2,0}).T,np.reshape(np.array({},"bool"),{2,0}).T}),{0,2},"bool",{})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"bool"),{2,0}).T,np.reshape(np.array({true,false,false,true},"bool"),{2,2})}) end),"case 170 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({},"bool"),{2,0}).T,np.reshape(np.array({true,false,false,true},"bool"),{2,2})}),{2,2},"bool",{{true,false},{false,true}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"bool"),{2,0}).T,np.reshape(np.array({true,false,false,true},"bool"),{2,2})}) end),"case 172 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"bool"),{2,0}).T,np.reshape(np.array({true,false,false,true},"bool"),{2,2})}) end),"case 173 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"bool"),{2,0}).T,np.reshape(np.array({true,false,false,true},"bool"),{2,2})}),{2,2},"bool",{{true,false},{false,true}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"bool"),{2,0}).T,np.reshape(np.array({true,false},"bool"),{2})}) end),"case 175 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({},"bool"),{2,0}).T,np.reshape(np.array({true,false},"bool"),{2})}),{1,2},"bool",{{true,false}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"bool"),{2,0}).T,np.reshape(np.array({true,false},"bool"),{2})}) end),"case 177 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"bool"),{2,0}).T,np.reshape(np.array({true,false},"bool"),{2})}) end),"case 178 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"bool"),{2,0}).T,np.reshape(np.array({true,false},"bool"),{2})}),{1,2},"bool",{{true,false}})
cases=cases+1
check(np.hstack({np.reshape(np.array({false,false},"bool"),{1,2}),np.reshape(np.array({false,false},"bool"),{1,2})}),{1,4},"bool",{{false,false,false,false}})
cases=cases+1
check(np.vstack({np.reshape(np.array({false,false},"bool"),{1,2}),np.reshape(np.array({false,false},"bool"),{1,2})}),{2,2},"bool",{{false,false},{false,false}})
cases=cases+1
check(np.dstack({np.reshape(np.array({false,false},"bool"),{1,2}),np.reshape(np.array({false,false},"bool"),{1,2})}),{1,2,2},"bool",{{{false,false},{false,false}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({false,false},"bool"),{1,2}),np.reshape(np.array({false,false},"bool"),{1,2})}),{1,4},"bool",{{false,false,false,false}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({false,false},"bool"),{1,2}),np.reshape(np.array({false,false},"bool"),{1,2})}),{2,2},"bool",{{false,false},{false,false}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({false,false},"bool"),{1,2}),np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,2}),1)}) end),"case 185 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({false,false},"bool"),{1,2}),np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,2}),1)}),{3,2},"bool",{{false,false},{false,true},{true,false}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({false,false},"bool"),{1,2}),np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,2}),1)}) end),"case 187 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({false,false},"bool"),{1,2}),np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,2}),1)}) end),"case 188 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({false,false},"bool"),{1,2}),np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,2}),1)}),{3,2},"bool",{{false,false},{false,true},{true,false}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({false,false},"bool"),{1,2}),np.flip(np.reshape(np.array({true,false},"bool"),{2}),1)}) end),"case 190 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({false,false},"bool"),{1,2}),np.flip(np.reshape(np.array({true,false},"bool"),{2}),1)}),{2,2},"bool",{{false,false},{false,true}})
cases=cases+1
check(np.dstack({np.reshape(np.array({false,false},"bool"),{1,2}),np.flip(np.reshape(np.array({true,false},"bool"),{2}),1)}),{1,2,2},"bool",{{{false,false},{false,true}}})
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({false,false},"bool"),{1,2}),np.flip(np.reshape(np.array({true,false},"bool"),{2}),1)}) end),"case 193 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({false,false},"bool"),{1,2}),np.flip(np.reshape(np.array({true,false},"bool"),{2}),1)}),{2,2},"bool",{{false,false},{false,true}})
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({false,false},"bool"),{1,2}),1),np.flip(np.reshape(np.array({false,false},"bool"),{1,2}),1)}),{1,4},"bool",{{false,false,false,false}})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({false,false},"bool"),{1,2}),1),np.flip(np.reshape(np.array({false,false},"bool"),{1,2}),1)}),{2,2},"bool",{{false,false},{false,false}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({false,false},"bool"),{1,2}),1),np.flip(np.reshape(np.array({false,false},"bool"),{1,2}),1)}),{1,2,2},"bool",{{{false,false},{false,false}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({false,false},"bool"),{1,2}),1),np.flip(np.reshape(np.array({false,false},"bool"),{1,2}),1)}),{1,4},"bool",{{false,false,false,false}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({false,false},"bool"),{1,2}),1),np.flip(np.reshape(np.array({false,false},"bool"),{1,2}),1)}),{2,2},"bool",{{false,false},{false,false}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({false,false},"bool"),{1,2}),1),np.reshape(np.array({true,false,false,true},"bool"),{2,2}).T}) end),"case 200 expected failure")
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({false,false},"bool"),{1,2}),1),np.reshape(np.array({true,false,false,true},"bool"),{2,2}).T}),{3,2},"bool",{{false,false},{true,false},{false,true}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({false,false},"bool"),{1,2}),1),np.reshape(np.array({true,false,false,true},"bool"),{2,2}).T}) end),"case 202 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({false,false},"bool"),{1,2}),1),np.reshape(np.array({true,false,false,true},"bool"),{2,2}).T}) end),"case 203 expected failure")
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({false,false},"bool"),{1,2}),1),np.reshape(np.array({true,false,false,true},"bool"),{2,2}).T}),{3,2},"bool",{{false,false},{true,false},{false,true}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({false,false},"bool"),{1,2}),1),np.reshape(np.array({false,true,false},"bool"),{3})}) end),"case 205 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({false,false},"bool"),{1,2}),1),np.reshape(np.array({false,true,false},"bool"),{3})}) end),"case 206 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({false,false},"bool"),{1,2}),1),np.reshape(np.array({false,true,false},"bool"),{3})}) end),"case 207 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({false,false},"bool"),{1,2}),1),np.reshape(np.array({false,true,false},"bool"),{3})}) end),"case 208 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({false,false},"bool"),{1,2}),1),np.reshape(np.array({false,true,false},"bool"),{3})}) end),"case 209 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({false,false},"bool"),{1,2}).T,np.reshape(np.array({false,false},"bool"),{1,2}).T}),{2,2},"bool",{{false,false},{false,false}})
cases=cases+1
check(np.vstack({np.reshape(np.array({false,false},"bool"),{1,2}).T,np.reshape(np.array({false,false},"bool"),{1,2}).T}),{4,1},"bool",{{false},{false},{false},{false}})
cases=cases+1
check(np.dstack({np.reshape(np.array({false,false},"bool"),{1,2}).T,np.reshape(np.array({false,false},"bool"),{1,2}).T}),{2,1,2},"bool",{{{false,false}},{{false,false}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({false,false},"bool"),{1,2}).T,np.reshape(np.array({false,false},"bool"),{1,2}).T}),{2,2},"bool",{{false,false},{false,false}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({false,false},"bool"),{1,2}).T,np.reshape(np.array({false,false},"bool"),{1,2}).T}),{4,1},"bool",{{false},{false},{false},{false}})
cases=cases+1
check(np.hstack({np.reshape(np.array({false,false},"bool"),{1,2}).T,np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3})}),{2,4},"bool",{{false,false,true,false},{false,false,true,false}})
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({false,false},"bool"),{1,2}).T,np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3})}) end),"case 216 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({false,false},"bool"),{1,2}).T,np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3})}) end),"case 217 expected failure")
cases=cases+1
check(np.column_stack({np.reshape(np.array({false,false},"bool"),{1,2}).T,np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3})}),{2,4},"bool",{{false,false,true,false},{false,false,true,false}})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({false,false},"bool"),{1,2}).T,np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3})}) end),"case 219 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({false,false},"bool"),{1,2}).T,np.flip(np.reshape(np.array({false,true,false},"bool"),{3}),1)}) end),"case 220 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({false,false},"bool"),{1,2}).T,np.flip(np.reshape(np.array({false,true,false},"bool"),{3}),1)}) end),"case 221 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({false,false},"bool"),{1,2}).T,np.flip(np.reshape(np.array({false,true,false},"bool"),{3}),1)}) end),"case 222 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({false,false},"bool"),{1,2}).T,np.flip(np.reshape(np.array({false,true,false},"bool"),{3}),1)}) end),"case 223 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({false,false},"bool"),{1,2}).T,np.flip(np.reshape(np.array({false,true,false},"bool"),{3}),1)}) end),"case 224 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({true,false},"bool"),{2,1}),np.reshape(np.array({true,false},"bool"),{2,1})}),{2,2},"bool",{{true,true},{false,false}})
cases=cases+1
check(np.vstack({np.reshape(np.array({true,false},"bool"),{2,1}),np.reshape(np.array({true,false},"bool"),{2,1})}),{4,1},"bool",{{true},{false},{true},{false}})
cases=cases+1
check(np.dstack({np.reshape(np.array({true,false},"bool"),{2,1}),np.reshape(np.array({true,false},"bool"),{2,1})}),{2,1,2},"bool",{{{true,true}},{{false,false}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({true,false},"bool"),{2,1}),np.reshape(np.array({true,false},"bool"),{2,1})}),{2,2},"bool",{{true,true},{false,false}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({true,false},"bool"),{2,1}),np.reshape(np.array({true,false},"bool"),{2,1})}),{4,1},"bool",{{true},{false},{true},{false}})
cases=cases+1
check(np.hstack({np.reshape(np.array({true,false},"bool"),{2,1}),np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),1)}),{2,4},"bool",{{true,false,true,false},{false,false,true,false}})
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({true,false},"bool"),{2,1}),np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),1)}) end),"case 231 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({true,false},"bool"),{2,1}),np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),1)}) end),"case 232 expected failure")
cases=cases+1
check(np.column_stack({np.reshape(np.array({true,false},"bool"),{2,1}),np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),1)}),{2,4},"bool",{{true,false,true,false},{false,false,true,false}})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({true,false},"bool"),{2,1}),np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),1)}) end),"case 234 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({true,false},"bool"),{2,1}),np.reshape(np.array({},"bool"),{0,2})}) end),"case 235 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({true,false},"bool"),{2,1}),np.reshape(np.array({},"bool"),{0,2})}) end),"case 236 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({true,false},"bool"),{2,1}),np.reshape(np.array({},"bool"),{0,2})}) end),"case 237 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({true,false},"bool"),{2,1}),np.reshape(np.array({},"bool"),{0,2})}) end),"case 238 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({true,false},"bool"),{2,1}),np.reshape(np.array({},"bool"),{0,2})}) end),"case 239 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({true,false},"bool"),{2,1}),1),np.flip(np.reshape(np.array({true,false},"bool"),{2,1}),1)}),{2,2},"bool",{{false,false},{true,true}})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({true,false},"bool"),{2,1}),1),np.flip(np.reshape(np.array({true,false},"bool"),{2,1}),1)}),{4,1},"bool",{{false},{true},{false},{true}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({true,false},"bool"),{2,1}),1),np.flip(np.reshape(np.array({true,false},"bool"),{2,1}),1)}),{2,1,2},"bool",{{{false,false}},{{true,true}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({true,false},"bool"),{2,1}),1),np.flip(np.reshape(np.array({true,false},"bool"),{2,1}),1)}),{2,2},"bool",{{false,false},{true,true}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({true,false},"bool"),{2,1}),1),np.flip(np.reshape(np.array({true,false},"bool"),{2,1}),1)}),{4,1},"bool",{{false},{true},{false},{true}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({true,false},"bool"),{2,1}),1),np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}).T}) end),"case 245 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({true,false},"bool"),{2,1}),1),np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}).T}) end),"case 246 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({true,false},"bool"),{2,1}),1),np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}).T}) end),"case 247 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({true,false},"bool"),{2,1}),1),np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}).T}) end),"case 248 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({true,false},"bool"),{2,1}),1),np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}).T}) end),"case 249 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({true,false},"bool"),{2,1}),1),np.reshape(np.array({},"bool"),{0,2}).T}),{2,1},"bool",{{false},{true}})
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({true,false},"bool"),{2,1}),1),np.reshape(np.array({},"bool"),{0,2}).T}) end),"case 251 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({true,false},"bool"),{2,1}),1),np.reshape(np.array({},"bool"),{0,2}).T}) end),"case 252 expected failure")
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({true,false},"bool"),{2,1}),1),np.reshape(np.array({},"bool"),{0,2}).T}),{2,1},"bool",{{false},{true}})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({true,false},"bool"),{2,1}),1),np.reshape(np.array({},"bool"),{0,2}).T}) end),"case 254 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({true,false},"bool"),{2,1}).T,np.reshape(np.array({true,false},"bool"),{2,1}).T}),{1,4},"bool",{{true,false,true,false}})
cases=cases+1
check(np.vstack({np.reshape(np.array({true,false},"bool"),{2,1}).T,np.reshape(np.array({true,false},"bool"),{2,1}).T}),{2,2},"bool",{{true,false},{true,false}})
cases=cases+1
check(np.dstack({np.reshape(np.array({true,false},"bool"),{2,1}).T,np.reshape(np.array({true,false},"bool"),{2,1}).T}),{1,2,2},"bool",{{{true,true},{false,false}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({true,false},"bool"),{2,1}).T,np.reshape(np.array({true,false},"bool"),{2,1}).T}),{1,4},"bool",{{true,false,true,false}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({true,false},"bool"),{2,1}).T,np.reshape(np.array({true,false},"bool"),{2,1}).T}),{2,2},"bool",{{true,false},{true,false}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({true,false},"bool"),{2,1}).T,np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2})}) end),"case 260 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({true,false},"bool"),{2,1}).T,np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2})}),{4,2},"bool",{{true,false},{false,true},{false,false},{true,false}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({true,false},"bool"),{2,1}).T,np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2})}) end),"case 262 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({true,false},"bool"),{2,1}).T,np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2})}) end),"case 263 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({true,false},"bool"),{2,1}).T,np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2})}),{4,2},"bool",{{true,false},{false,true},{false,false},{true,false}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({true,false},"bool"),{2,1}).T,np.reshape(np.array({},"bool"),{2,0})}) end),"case 265 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({true,false},"bool"),{2,1}).T,np.reshape(np.array({},"bool"),{2,0})}) end),"case 266 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({true,false},"bool"),{2,1}).T,np.reshape(np.array({},"bool"),{2,0})}) end),"case 267 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({true,false},"bool"),{2,1}).T,np.reshape(np.array({},"bool"),{2,0})}) end),"case 268 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({true,false},"bool"),{2,1}).T,np.reshape(np.array({},"bool"),{2,0})}) end),"case 269 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({true,false,false,true},"bool"),{2,2}),np.reshape(np.array({true,false,false,true},"bool"),{2,2})}),{2,4},"bool",{{true,false,true,false},{false,true,false,true}})
cases=cases+1
check(np.vstack({np.reshape(np.array({true,false,false,true},"bool"),{2,2}),np.reshape(np.array({true,false,false,true},"bool"),{2,2})}),{4,2},"bool",{{true,false},{false,true},{true,false},{false,true}})
cases=cases+1
check(np.dstack({np.reshape(np.array({true,false,false,true},"bool"),{2,2}),np.reshape(np.array({true,false,false,true},"bool"),{2,2})}),{2,2,2},"bool",{{{true,true},{false,false}},{{false,false},{true,true}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({true,false,false,true},"bool"),{2,2}),np.reshape(np.array({true,false,false,true},"bool"),{2,2})}),{2,4},"bool",{{true,false,true,false},{false,true,false,true}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({true,false,false,true},"bool"),{2,2}),np.reshape(np.array({true,false,false,true},"bool"),{2,2})}),{4,2},"bool",{{true,false},{false,true},{true,false},{false,true}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({true,false,false,true},"bool"),{2,2}),np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),1)}) end),"case 275 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({true,false,false,true},"bool"),{2,2}),np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),1)}),{5,2},"bool",{{true,false},{false,true},{true,false},{false,false},{false,true}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({true,false,false,true},"bool"),{2,2}),np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),1)}) end),"case 277 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({true,false,false,true},"bool"),{2,2}),np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),1)}) end),"case 278 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({true,false,false,true},"bool"),{2,2}),np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),1)}),{5,2},"bool",{{true,false},{false,true},{true,false},{false,false},{false,true}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({true,false,false,true},"bool"),{2,2}),np.reshape(np.array({},"bool"),{2,0}).T}) end),"case 280 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({true,false,false,true},"bool"),{2,2}),np.reshape(np.array({},"bool"),{2,0}).T}),{2,2},"bool",{{true,false},{false,true}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({true,false,false,true},"bool"),{2,2}),np.reshape(np.array({},"bool"),{2,0}).T}) end),"case 282 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({true,false,false,true},"bool"),{2,2}),np.reshape(np.array({},"bool"),{2,0}).T}) end),"case 283 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({true,false,false,true},"bool"),{2,2}),np.reshape(np.array({},"bool"),{2,0}).T}),{2,2},"bool",{{true,false},{false,true}})
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,2}),1),np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,2}),1)}),{2,4},"bool",{{false,true,false,true},{true,false,true,false}})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,2}),1),np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,2}),1)}),{4,2},"bool",{{false,true},{true,false},{false,true},{true,false}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,2}),1),np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,2}),1)}),{2,2,2},"bool",{{{false,false},{true,true}},{{true,true},{false,false}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,2}),1),np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,2}),1)}),{2,4},"bool",{{false,true,false,true},{true,false,true,false}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,2}),1),np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,2}),1)}),{4,2},"bool",{{false,true},{true,false},{false,true},{true,false}})
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,2}),1),np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}).T}),{2,5},"bool",{{false,true,false,false,true},{true,false,true,false,false}})
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,2}),1),np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}).T}) end),"case 291 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,2}),1),np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}).T}) end),"case 292 expected failure")
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,2}),1),np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}).T}),{2,5},"bool",{{false,true,false,false,true},{true,false,true,false,false}})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,2}),1),np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}).T}) end),"case 294 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,2}),1),np.reshape(np.array({false,false},"bool"),{1,2})}) end),"case 295 expected failure")
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,2}),1),np.reshape(np.array({false,false},"bool"),{1,2})}),{3,2},"bool",{{false,true},{true,false},{false,false}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,2}),1),np.reshape(np.array({false,false},"bool"),{1,2})}) end),"case 297 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,2}),1),np.reshape(np.array({false,false},"bool"),{1,2})}) end),"case 298 expected failure")
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,2}),1),np.reshape(np.array({false,false},"bool"),{1,2})}),{3,2},"bool",{{false,true},{true,false},{false,false}})
cases=cases+1
check(np.hstack({np.reshape(np.array({true,false,false,true},"bool"),{2,2}).T,np.reshape(np.array({true,false,false,true},"bool"),{2,2}).T}),{2,4},"bool",{{true,false,true,false},{false,true,false,true}})
cases=cases+1
check(np.vstack({np.reshape(np.array({true,false,false,true},"bool"),{2,2}).T,np.reshape(np.array({true,false,false,true},"bool"),{2,2}).T}),{4,2},"bool",{{true,false},{false,true},{true,false},{false,true}})
cases=cases+1
check(np.dstack({np.reshape(np.array({true,false,false,true},"bool"),{2,2}).T,np.reshape(np.array({true,false,false,true},"bool"),{2,2}).T}),{2,2,2},"bool",{{{true,true},{false,false}},{{false,false},{true,true}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({true,false,false,true},"bool"),{2,2}).T,np.reshape(np.array({true,false,false,true},"bool"),{2,2}).T}),{2,4},"bool",{{true,false,true,false},{false,true,false,true}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({true,false,false,true},"bool"),{2,2}).T,np.reshape(np.array({true,false,false,true},"bool"),{2,2}).T}),{4,2},"bool",{{true,false},{false,true},{true,false},{false,true}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({true,false,false,true},"bool"),{2,2}).T,np.reshape(np.array({},"bool"),{0,2,1})}) end),"case 305 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({true,false,false,true},"bool"),{2,2}).T,np.reshape(np.array({},"bool"),{0,2,1})}) end),"case 306 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({true,false,false,true},"bool"),{2,2}).T,np.reshape(np.array({},"bool"),{0,2,1})}) end),"case 307 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({true,false,false,true},"bool"),{2,2}).T,np.reshape(np.array({},"bool"),{0,2,1})}) end),"case 308 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({true,false,false,true},"bool"),{2,2}).T,np.reshape(np.array({},"bool"),{0,2,1})}) end),"case 309 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({true,false,false,true},"bool"),{2,2}).T,np.flip(np.reshape(np.array({false,false},"bool"),{1,2}),1)}) end),"case 310 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({true,false,false,true},"bool"),{2,2}).T,np.flip(np.reshape(np.array({false,false},"bool"),{1,2}),1)}),{3,2},"bool",{{true,false},{false,true},{false,false}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({true,false,false,true},"bool"),{2,2}).T,np.flip(np.reshape(np.array({false,false},"bool"),{1,2}),1)}) end),"case 312 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({true,false,false,true},"bool"),{2,2}).T,np.flip(np.reshape(np.array({false,false},"bool"),{1,2}),1)}) end),"case 313 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({true,false,false,true},"bool"),{2,2}).T,np.flip(np.reshape(np.array({false,false},"bool"),{1,2}),1)}),{3,2},"bool",{{true,false},{false,true},{false,false}})
cases=cases+1
check(np.hstack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3})}),{2,6},"bool",{{false,true,false,false,true,false},{false,true,false,false,true,false}})
cases=cases+1
check(np.vstack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3})}),{4,3},"bool",{{false,true,false},{false,true,false},{false,true,false},{false,true,false}})
cases=cases+1
check(np.dstack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3})}),{2,3,2},"bool",{{{false,false},{true,true},{false,false}},{{false,false},{true,true},{false,false}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3})}),{2,6},"bool",{{false,true,false,false,true,false},{false,true,false,false,true,false}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3})}),{4,3},"bool",{{false,true,false},{false,true,false},{false,true,false},{false,true,false}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),np.reshape(np.array({},"bool"),{0,2,1}).T}) end),"case 320 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),np.reshape(np.array({},"bool"),{0,2,1}).T}) end),"case 321 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),np.reshape(np.array({},"bool"),{0,2,1}).T}) end),"case 322 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),np.reshape(np.array({},"bool"),{0,2,1}).T}) end),"case 323 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),np.reshape(np.array({},"bool"),{0,2,1}).T}) end),"case 324 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),np.reshape(np.array({false,false},"bool"),{1,2}).T}),{2,4},"bool",{{false,true,false,false},{false,true,false,false}})
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),np.reshape(np.array({false,false},"bool"),{1,2}).T}) end),"case 326 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),np.reshape(np.array({false,false},"bool"),{1,2}).T}) end),"case 327 expected failure")
cases=cases+1
check(np.column_stack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),np.reshape(np.array({false,false},"bool"),{1,2}).T}),{2,4},"bool",{{false,true,false,false},{false,true,false,false}})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),np.reshape(np.array({false,false},"bool"),{1,2}).T}) end),"case 329 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),1),np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),1)}),{2,6},"bool",{{false,true,false,false,true,false},{false,true,false,false,true,false}})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),1),np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),1)}),{4,3},"bool",{{false,true,false},{false,true,false},{false,true,false},{false,true,false}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),1),np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),1)}),{2,3,2},"bool",{{{false,false},{true,true},{false,false}},{{false,false},{true,true},{false,false}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),1),np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),1)}),{2,6},"bool",{{false,true,false,false,true,false},{false,true,false,false,true,false}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),1),np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),1)}),{4,3},"bool",{{false,true,false},{false,true,false},{false,true,false},{false,true,false}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),1),np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3})}) end),"case 335 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),1),np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3})}) end),"case 336 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),1),np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3})}) end),"case 337 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),1),np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3})}) end),"case 338 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),1),np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3})}) end),"case 339 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),1),np.reshape(np.array({true,false},"bool"),{2,1})}),{2,4},"bool",{{false,true,false,true},{false,true,false,false}})
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),1),np.reshape(np.array({true,false},"bool"),{2,1})}) end),"case 341 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),1),np.reshape(np.array({true,false},"bool"),{2,1})}) end),"case 342 expected failure")
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),1),np.reshape(np.array({true,false},"bool"),{2,1})}),{2,4},"bool",{{false,true,false,true},{false,true,false,false}})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),1),np.reshape(np.array({true,false},"bool"),{2,1})}) end),"case 344 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}).T,np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}).T}),{3,4},"bool",{{false,false,false,false},{true,true,true,true},{false,false,false,false}})
cases=cases+1
check(np.vstack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}).T,np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}).T}),{6,2},"bool",{{false,false},{true,true},{false,false},{false,false},{true,true},{false,false}})
cases=cases+1
check(np.dstack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}).T,np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}).T}),{3,2,2},"bool",{{{false,false},{false,false}},{{true,true},{true,true}},{{false,false},{false,false}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}).T,np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}).T}),{3,4},"bool",{{false,false,false,false},{true,true,true,true},{false,false,false,false}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}).T,np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}).T}),{6,2},"bool",{{false,false},{true,true},{false,false},{false,false},{true,true},{false,false}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}).T,np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),1)}) end),"case 350 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}).T,np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),1)}) end),"case 351 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}).T,np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),1)}) end),"case 352 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}).T,np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),1)}) end),"case 353 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}).T,np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),1)}) end),"case 354 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}).T,np.flip(np.reshape(np.array({true,false},"bool"),{2,1}),1)}) end),"case 355 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}).T,np.flip(np.reshape(np.array({true,false},"bool"),{2,1}),1)}) end),"case 356 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}).T,np.flip(np.reshape(np.array({true,false},"bool"),{2,1}),1)}) end),"case 357 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}).T,np.flip(np.reshape(np.array({true,false},"bool"),{2,1}),1)}) end),"case 358 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}).T,np.flip(np.reshape(np.array({true,false},"bool"),{2,1}),1)}) end),"case 359 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2})}),{3,4},"bool",{{false,true,false,true},{false,false,false,false},{true,false,true,false}})
cases=cases+1
check(np.vstack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2})}),{6,2},"bool",{{false,true},{false,false},{true,false},{false,true},{false,false},{true,false}})
cases=cases+1
check(np.dstack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2})}),{3,2,2},"bool",{{{false,false},{true,true}},{{false,false},{false,false}},{{true,true},{false,false}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2})}),{3,4},"bool",{{false,true,false,true},{false,false,false,false},{true,false,true,false}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2})}),{6,2},"bool",{{false,true},{false,false},{true,false},{false,true},{false,false},{true,false}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}).T}) end),"case 365 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}).T}) end),"case 366 expected failure")
cases=cases+1
check(np.dstack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}).T}),{3,2,2},"bool",{{{false,true},{true,true}},{{false,false},{false,false}},{{true,false},{false,false}}})
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}).T}) end),"case 368 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}).T}) end),"case 369 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),np.reshape(np.array({true,false},"bool"),{2,1}).T}) end),"case 370 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),np.reshape(np.array({true,false},"bool"),{2,1}).T}),{4,2},"bool",{{false,true},{false,false},{true,false},{true,false}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),np.reshape(np.array({true,false},"bool"),{2,1}).T}) end),"case 372 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),np.reshape(np.array({true,false},"bool"),{2,1}).T}) end),"case 373 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),np.reshape(np.array({true,false},"bool"),{2,1}).T}),{4,2},"bool",{{false,true},{false,false},{true,false},{true,false}})
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),1),np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),1)}),{3,4},"bool",{{true,false,true,false},{false,false,false,false},{false,true,false,true}})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),1),np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),1)}),{6,2},"bool",{{true,false},{false,false},{false,true},{true,false},{false,false},{false,true}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),1),np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),1)}),{3,2,2},"bool",{{{true,true},{false,false}},{{false,false},{false,false}},{{false,false},{true,true}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),1),np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),1)}),{3,4},"bool",{{true,false,true,false},{false,false,false,false},{false,true,false,true}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),1),np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),1)}),{6,2},"bool",{{true,false},{false,false},{false,true},{true,false},{false,false},{false,true}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),1),np.reshape(np.array({true,false,false,true},"bool"),{2,1,2})}) end),"case 380 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),1),np.reshape(np.array({true,false,false,true},"bool"),{2,1,2})}) end),"case 381 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),1),np.reshape(np.array({true,false,false,true},"bool"),{2,1,2})}) end),"case 382 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),1),np.reshape(np.array({true,false,false,true},"bool"),{2,1,2})}) end),"case 383 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),1),np.reshape(np.array({true,false,false,true},"bool"),{2,1,2})}) end),"case 384 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),1),np.reshape(np.array({true,false,false,true},"bool"),{2,2})}) end),"case 385 expected failure")
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),1),np.reshape(np.array({true,false,false,true},"bool"),{2,2})}),{5,2},"bool",{{true,false},{false,false},{false,true},{true,false},{false,true}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),1),np.reshape(np.array({true,false,false,true},"bool"),{2,2})}) end),"case 387 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),1),np.reshape(np.array({true,false,false,true},"bool"),{2,2})}) end),"case 388 expected failure")
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),1),np.reshape(np.array({true,false,false,true},"bool"),{2,2})}),{5,2},"bool",{{true,false},{false,false},{false,true},{true,false},{false,true}})
cases=cases+1
check(np.hstack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}).T,np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}).T}),{2,6},"bool",{{false,false,true,false,false,true},{true,false,false,true,false,false}})
cases=cases+1
check(np.vstack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}).T,np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}).T}),{4,3},"bool",{{false,false,true},{true,false,false},{false,false,true},{true,false,false}})
cases=cases+1
check(np.dstack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}).T,np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}).T}),{2,3,2},"bool",{{{false,false},{false,false},{true,true}},{{true,true},{false,false},{false,false}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}).T,np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}).T}),{2,6},"bool",{{false,false,true,false,false,true},{true,false,false,true,false,false}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}).T,np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}).T}),{4,3},"bool",{{false,false,true},{true,false,false},{false,false,true},{true,false,false}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}).T,np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),1)}) end),"case 395 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}).T,np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),1)}) end),"case 396 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}).T,np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),1)}) end),"case 397 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}).T,np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),1)}) end),"case 398 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}).T,np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),1)}) end),"case 399 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}).T,np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,2}),1)}),{2,5},"bool",{{false,false,true,false,true},{true,false,false,true,false}})
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}).T,np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,2}),1)}) end),"case 401 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}).T,np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,2}),1)}) end),"case 402 expected failure")
cases=cases+1
check(np.column_stack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}).T,np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,2}),1)}),{2,5},"bool",{{false,false,true,false,true},{true,false,false,true,false}})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}).T,np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,2}),1)}) end),"case 404 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({},"bool"),{0,2,1}),np.reshape(np.array({},"bool"),{0,2,1})}),{0,4,1},"bool",{})
cases=cases+1
check(np.vstack({np.reshape(np.array({},"bool"),{0,2,1}),np.reshape(np.array({},"bool"),{0,2,1})}),{0,2,1},"bool",{})
cases=cases+1
check(np.dstack({np.reshape(np.array({},"bool"),{0,2,1}),np.reshape(np.array({},"bool"),{0,2,1})}),{0,2,2},"bool",{})
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"bool"),{0,2,1}),np.reshape(np.array({},"bool"),{0,2,1})}),{0,4,1},"bool",{})
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"bool"),{0,2,1}),np.reshape(np.array({},"bool"),{0,2,1})}),{0,2,1},"bool",{})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"bool"),{0,2,1}),np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}).T}) end),"case 410 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"bool"),{0,2,1}),np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}).T}) end),"case 411 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"bool"),{0,2,1}),np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}).T}) end),"case 412 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"bool"),{0,2,1}),np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}).T}) end),"case 413 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"bool"),{0,2,1}),np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}).T}) end),"case 414 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"bool"),{0,2,1}),np.reshape(np.array({true,false,false,true},"bool"),{2,2}).T}) end),"case 415 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"bool"),{0,2,1}),np.reshape(np.array({true,false,false,true},"bool"),{2,2}).T}) end),"case 416 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"bool"),{0,2,1}),np.reshape(np.array({true,false,false,true},"bool"),{2,2}).T}) end),"case 417 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"bool"),{0,2,1}),np.reshape(np.array({true,false,false,true},"bool"),{2,2}).T}) end),"case 418 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"bool"),{0,2,1}),np.reshape(np.array({true,false,false,true},"bool"),{2,2}).T}) end),"case 419 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({},"bool"),{0,2,1}).T,np.reshape(np.array({},"bool"),{0,2,1}).T}),{1,4,0},"bool",{{{},{},{},{}}})
cases=cases+1
check(np.vstack({np.reshape(np.array({},"bool"),{0,2,1}).T,np.reshape(np.array({},"bool"),{0,2,1}).T}),{2,2,0},"bool",{{{},{}},{{},{}}})
cases=cases+1
check(np.dstack({np.reshape(np.array({},"bool"),{0,2,1}).T,np.reshape(np.array({},"bool"),{0,2,1}).T}),{1,2,0},"bool",{{{},{}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"bool"),{0,2,1}).T,np.reshape(np.array({},"bool"),{0,2,1}).T}),{1,4,0},"bool",{{{},{},{},{}}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"bool"),{0,2,1}).T,np.reshape(np.array({},"bool"),{0,2,1}).T}),{2,2,0},"bool",{{{},{}},{{},{}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"bool"),{0,2,1}).T,np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2})}) end),"case 425 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"bool"),{0,2,1}).T,np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2})}) end),"case 426 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"bool"),{0,2,1}).T,np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2})}) end),"case 427 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"bool"),{0,2,1}).T,np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2})}) end),"case 428 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"bool"),{0,2,1}).T,np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2})}) end),"case 429 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"bool"),{0,2,1}).T,np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3})}) end),"case 430 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"bool"),{0,2,1}).T,np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3})}) end),"case 431 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"bool"),{0,2,1}).T,np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3})}) end),"case 432 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"bool"),{0,2,1}).T,np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3})}) end),"case 433 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"bool"),{0,2,1}).T,np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3})}) end),"case 434 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3})}),{1,4,3},"bool",{{{true,false,false},{true,false,false},{true,false,false},{true,false,false}}})
cases=cases+1
check(np.vstack({np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3})}),{2,2,3},"bool",{{{true,false,false},{true,false,false}},{{true,false,false},{true,false,false}}})
cases=cases+1
check(np.dstack({np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3})}),{1,2,6},"bool",{{{true,false,false,true,false,false},{true,false,false,true,false,false}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3})}),{1,4,3},"bool",{{{true,false,false},{true,false,false},{true,false,false},{true,false,false}}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3})}),{2,2,3},"bool",{{{true,false,false},{true,false,false}},{{true,false,false},{true,false,false}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),np.flip(np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),1)}) end),"case 440 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),np.flip(np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),1)}) end),"case 441 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),np.flip(np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),1)}) end),"case 442 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),np.flip(np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),1)}) end),"case 443 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),np.flip(np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),1)}) end),"case 444 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),1)}) end),"case 445 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),1)}) end),"case 446 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),1)}) end),"case 447 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),1)}) end),"case 448 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}),1)}) end),"case 449 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),1),np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),1)}),{1,4,3},"bool",{{{true,false,false},{true,false,false},{true,false,false},{true,false,false}}})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),1),np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),1)}),{2,2,3},"bool",{{{true,false,false},{true,false,false}},{{true,false,false},{true,false,false}}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),1),np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),1)}),{1,2,6},"bool",{{{true,false,false,true,false,false},{true,false,false,true,false,false}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),1),np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),1)}),{1,4,3},"bool",{{{true,false,false},{true,false,false},{true,false,false},{true,false,false}}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),1),np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),1)}),{2,2,3},"bool",{{{true,false,false},{true,false,false}},{{true,false,false},{true,false,false}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),1),np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}).T}) end),"case 455 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),1),np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}).T}) end),"case 456 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),1),np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}).T}) end),"case 457 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),1),np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}).T}) end),"case 458 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),1),np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}).T}) end),"case 459 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),1),np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}).T}) end),"case 460 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),1),np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}).T}) end),"case 461 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),1),np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}).T}) end),"case 462 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),1),np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}).T}) end),"case 463 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),1),np.reshape(np.array({false,true,false,false,true,false},"bool"),{2,3}).T}) end),"case 464 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}).T,np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}).T}),{3,4,1},"bool",{{{true},{true},{true},{true}},{{false},{false},{false},{false}},{{false},{false},{false},{false}}})
cases=cases+1
check(np.vstack({np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}).T,np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}).T}),{6,2,1},"bool",{{{true},{true}},{{false},{false}},{{false},{false}},{{true},{true}},{{false},{false}},{{false},{false}}})
cases=cases+1
check(np.dstack({np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}).T,np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}).T}),{3,2,2},"bool",{{{true,true},{true,true}},{{false,false},{false,false}},{{false,false},{false,false}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}).T,np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}).T}),{3,4,1},"bool",{{{true},{true},{true},{true}},{{false},{false},{false},{false}},{{false},{false},{false},{false}}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}).T,np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}).T}),{6,2,1},"bool",{{{true},{true}},{{false},{false}},{{false},{false}},{{true},{true}},{{false},{false}},{{false},{false}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}).T,np.reshape(np.array({false},"bool"),{})}) end),"case 470 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}).T,np.reshape(np.array({false},"bool"),{})}) end),"case 471 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}).T,np.reshape(np.array({false},"bool"),{})}) end),"case 472 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}).T,np.reshape(np.array({false},"bool"),{})}) end),"case 473 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}).T,np.reshape(np.array({false},"bool"),{})}) end),"case 474 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}).T,np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2})}) end),"case 475 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}).T,np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2})}) end),"case 476 expected failure")
cases=cases+1
check(np.dstack({np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}).T,np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2})}),{3,2,2},"bool",{{{true,false},{true,true}},{{false,false},{false,false}},{{false,true},{false,false}}})
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}).T,np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2})}) end),"case 478 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}).T,np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2})}) end),"case 479 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),np.reshape(np.array({true,false,false,true},"bool"),{2,1,2})}),{2,2,2},"bool",{{{true,false},{true,false}},{{false,true},{false,true}}})
cases=cases+1
check(np.vstack({np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),np.reshape(np.array({true,false,false,true},"bool"),{2,1,2})}),{4,1,2},"bool",{{{true,false}},{{false,true}},{{true,false}},{{false,true}}})
cases=cases+1
check(np.dstack({np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),np.reshape(np.array({true,false,false,true},"bool"),{2,1,2})}),{2,1,4},"bool",{{{true,false,true,false}},{{false,true,false,true}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),np.reshape(np.array({true,false,false,true},"bool"),{2,1,2})}),{2,2,2},"bool",{{{true,false},{true,false}},{{false,true},{false,true}}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),np.reshape(np.array({true,false,false,true},"bool"),{2,1,2})}),{4,1,2},"bool",{{{true,false}},{{false,true}},{{true,false}},{{false,true}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),np.reshape(np.array({},"bool"),{0})}) end),"case 485 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),np.reshape(np.array({},"bool"),{0})}) end),"case 486 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),np.reshape(np.array({},"bool"),{0})}) end),"case 487 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),np.reshape(np.array({},"bool"),{0})}) end),"case 488 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),np.reshape(np.array({},"bool"),{0})}) end),"case 489 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),1)}) end),"case 490 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),1)}) end),"case 491 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),1)}) end),"case 492 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),1)}) end),"case 493 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),np.flip(np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}),1)}) end),"case 494 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),1),np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),1)}),{2,2,2},"bool",{{{false,true},{false,true}},{{true,false},{true,false}}})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),1),np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),1)}),{4,1,2},"bool",{{{false,true}},{{true,false}},{{false,true}},{{true,false}}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),1),np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),1)}),{2,1,4},"bool",{{{false,true,false,true}},{{true,false,true,false}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),1),np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),1)}),{2,2,2},"bool",{{{false,true},{false,true}},{{true,false},{true,false}}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),1),np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),1)}),{4,1,2},"bool",{{{false,true}},{{true,false}},{{false,true}},{{true,false}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),1),np.reshape(np.array({false},"bool"),{1})}) end),"case 500 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),1),np.reshape(np.array({false},"bool"),{1})}) end),"case 501 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),1),np.reshape(np.array({false},"bool"),{1})}) end),"case 502 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),1),np.reshape(np.array({false},"bool"),{1})}) end),"case 503 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),1),np.reshape(np.array({false},"bool"),{1})}) end),"case 504 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),1),np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}).T}) end),"case 505 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),1),np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}).T}) end),"case 506 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),1),np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}).T}) end),"case 507 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),1),np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}).T}) end),"case 508 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}),1),np.reshape(np.array({false,true,false,false,true,false},"bool"),{3,2}).T}) end),"case 509 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}).T,np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}).T}),{2,2,2},"bool",{{{true,false},{true,false}},{{false,true},{false,true}}})
cases=cases+1
check(np.vstack({np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}).T,np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}).T}),{4,1,2},"bool",{{{true,false}},{{false,true}},{{true,false}},{{false,true}}})
cases=cases+1
check(np.dstack({np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}).T,np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}).T}),{2,1,4},"bool",{{{true,false,true,false}},{{false,true,false,true}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}).T,np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}).T}),{2,2,2},"bool",{{{true,false},{true,false}},{{false,true},{false,true}}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}).T,np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}).T}),{4,1,2},"bool",{{{true,false}},{{false,true}},{{true,false}},{{false,true}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}).T,np.flip(np.reshape(np.array({false},"bool"),{1}),1)}) end),"case 515 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}).T,np.flip(np.reshape(np.array({false},"bool"),{1}),1)}) end),"case 516 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}).T,np.flip(np.reshape(np.array({false},"bool"),{1}),1)}) end),"case 517 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}).T,np.flip(np.reshape(np.array({false},"bool"),{1}),1)}) end),"case 518 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}).T,np.flip(np.reshape(np.array({false},"bool"),{1}),1)}) end),"case 519 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}).T,np.reshape(np.array({},"bool"),{0,2,1})}) end),"case 520 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}).T,np.reshape(np.array({},"bool"),{0,2,1})}) end),"case 521 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}).T,np.reshape(np.array({},"bool"),{0,2,1})}) end),"case 522 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}).T,np.reshape(np.array({},"bool"),{0,2,1})}) end),"case 523 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({true,false,false,true},"bool"),{2,1,2}).T,np.reshape(np.array({},"bool"),{0,2,1})}) end),"case 524 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2})}),{2,4,2},"bool",{{{false,true},{false,false},{false,true},{false,false}},{{true,false},{false,true},{true,false},{false,true}}})
cases=cases+1
check(np.vstack({np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2})}),{4,2,2},"bool",{{{false,true},{false,false}},{{true,false},{false,true}},{{false,true},{false,false}},{{true,false},{false,true}}})
cases=cases+1
check(np.dstack({np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2})}),{2,2,4},"bool",{{{false,true,false,true},{false,false,false,false}},{{true,false,true,false},{false,true,false,true}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2})}),{2,4,2},"bool",{{{false,true},{false,false},{false,true},{false,false}},{{true,false},{false,true},{true,false},{false,true}}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2})}),{4,2,2},"bool",{{{false,true},{false,false}},{{true,false},{false,true}},{{false,true},{false,false}},{{true,false},{false,true}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),np.reshape(np.array({true,false},"bool"),{2})}) end),"case 530 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),np.reshape(np.array({true,false},"bool"),{2})}) end),"case 531 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),np.reshape(np.array({true,false},"bool"),{2})}) end),"case 532 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),np.reshape(np.array({true,false},"bool"),{2})}) end),"case 533 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),np.reshape(np.array({true,false},"bool"),{2})}) end),"case 534 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),np.reshape(np.array({},"bool"),{0,2,1}).T}) end),"case 535 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),np.reshape(np.array({},"bool"),{0,2,1}).T}) end),"case 536 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),np.reshape(np.array({},"bool"),{0,2,1}).T}) end),"case 537 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),np.reshape(np.array({},"bool"),{0,2,1}).T}) end),"case 538 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),np.reshape(np.array({},"bool"),{0,2,1}).T}) end),"case 539 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),1),np.flip(np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),1)}),{2,4,2},"bool",{{{true,false},{false,true},{true,false},{false,true}},{{false,true},{false,false},{false,true},{false,false}}})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),1),np.flip(np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),1)}),{4,2,2},"bool",{{{true,false},{false,true}},{{false,true},{false,false}},{{true,false},{false,true}},{{false,true},{false,false}}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),1),np.flip(np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),1)}),{2,2,4},"bool",{{{true,false,true,false},{false,true,false,true}},{{false,true,false,true},{false,false,false,false}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),1),np.flip(np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),1)}),{2,4,2},"bool",{{{true,false},{false,true},{true,false},{false,true}},{{false,true},{false,false},{false,true},{false,false}}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),1),np.flip(np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),1)}),{4,2,2},"bool",{{{true,false},{false,true}},{{false,true},{false,false}},{{true,false},{false,true}},{{false,true},{false,false}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),1),np.flip(np.reshape(np.array({true,false},"bool"),{2}),1)}) end),"case 545 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),1),np.flip(np.reshape(np.array({true,false},"bool"),{2}),1)}) end),"case 546 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),1),np.flip(np.reshape(np.array({true,false},"bool"),{2}),1)}) end),"case 547 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),1),np.flip(np.reshape(np.array({true,false},"bool"),{2}),1)}) end),"case 548 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),1),np.flip(np.reshape(np.array({true,false},"bool"),{2}),1)}) end),"case 549 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),1),np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3})}) end),"case 550 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),1),np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3})}) end),"case 551 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),1),np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3})}) end),"case 552 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),1),np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3})}) end),"case 553 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}),1),np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3})}) end),"case 554 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}).T,np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}).T}),{2,4,2},"bool",{{{false,true},{false,false},{false,true},{false,false}},{{true,false},{false,true},{true,false},{false,true}}})
cases=cases+1
check(np.vstack({np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}).T,np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}).T}),{4,2,2},"bool",{{{false,true},{false,false}},{{true,false},{false,true}},{{false,true},{false,false}},{{true,false},{false,true}}})
cases=cases+1
check(np.dstack({np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}).T,np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}).T}),{2,2,4},"bool",{{{false,true,false,true},{false,false,false,false}},{{true,false,true,false},{false,true,false,true}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}).T,np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}).T}),{2,4,2},"bool",{{{false,true},{false,false},{false,true},{false,false}},{{true,false},{false,true},{true,false},{false,true}}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}).T,np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}).T}),{4,2,2},"bool",{{{false,true},{false,false}},{{true,false},{false,true}},{{false,true},{false,false}},{{true,false},{false,true}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}).T,np.reshape(np.array({false,true,false},"bool"),{3})}) end),"case 560 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}).T,np.reshape(np.array({false,true,false},"bool"),{3})}) end),"case 561 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}).T,np.reshape(np.array({false,true,false},"bool"),{3})}) end),"case 562 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}).T,np.reshape(np.array({false,true,false},"bool"),{3})}) end),"case 563 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}).T,np.reshape(np.array({false,true,false},"bool"),{3})}) end),"case 564 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}).T,np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),1)}) end),"case 565 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}).T,np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),1)}) end),"case 566 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}).T,np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),1)}) end),"case 567 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}).T,np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),1)}) end),"case 568 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({false,true,false,false,true,false,false,true},"bool"),{2,2,2}).T,np.flip(np.reshape(np.array({true,false,false,true,false,false},"bool"),{1,2,3}),1)}) end),"case 569 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-5},"int16"),{}),np.reshape(np.array({-5},"int16"),{})}),{2},"int16",{-5,-5})
cases=cases+1
check(np.vstack({np.reshape(np.array({-5},"int16"),{}),np.reshape(np.array({-5},"int16"),{})}),{2,1},"int16",{{-5},{-5}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-5},"int16"),{}),np.reshape(np.array({-5},"int16"),{})}),{1,1,2},"int16",{{{-5,-5}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-5},"int16"),{}),np.reshape(np.array({-5},"int16"),{})}),{1,2},"int16",{{-5,-5}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-5},"int16"),{}),np.reshape(np.array({-5},"int16"),{})}),{2,1},"int16",{{-5},{-5}})
cases=cases+1
check(np.hstack({np.reshape(np.array({-5},"int16"),{}),np.flip(np.reshape(np.array({-6,-3,0},"int16"),{3}),1)}),{4},"int16",{-5,0,-3,-6})
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-5},"int16"),{}),np.flip(np.reshape(np.array({-6,-3,0},"int16"),{3}),1)}) end),"case 576 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-5},"int16"),{}),np.flip(np.reshape(np.array({-6,-3,0},"int16"),{3}),1)}) end),"case 577 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-5},"int16"),{}),np.flip(np.reshape(np.array({-6,-3,0},"int16"),{3}),1)}) end),"case 578 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-5},"int16"),{}),np.flip(np.reshape(np.array({-6,-3,0},"int16"),{3}),1)}) end),"case 579 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-5},"int16"),{}),np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}).T}) end),"case 580 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-5},"int16"),{}),np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}).T}) end),"case 581 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-5},"int16"),{}),np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}).T}) end),"case 582 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-5},"int16"),{}),np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}).T}) end),"case 583 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-5},"int16"),{}),np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}).T}) end),"case 584 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({},"int16"),{0}),np.reshape(np.array({},"int16"),{0})}),{0},"int16",{})
cases=cases+1
check(np.vstack({np.reshape(np.array({},"int16"),{0}),np.reshape(np.array({},"int16"),{0})}),{2,0},"int16",{{},{}})
cases=cases+1
check(np.dstack({np.reshape(np.array({},"int16"),{0}),np.reshape(np.array({},"int16"),{0})}),{1,0,2},"int16",{{}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"int16"),{0}),np.reshape(np.array({},"int16"),{0})}),{0,2},"int16",{})
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"int16"),{0}),np.reshape(np.array({},"int16"),{0})}),{2,0},"int16",{{},{}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"int16"),{0}),np.reshape(np.array({},"int16"),{0,2})}) end),"case 590 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"int16"),{0}),np.reshape(np.array({},"int16"),{0,2})}) end),"case 591 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"int16"),{0}),np.reshape(np.array({},"int16"),{0,2})}) end),"case 592 expected failure")
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"int16"),{0}),np.reshape(np.array({},"int16"),{0,2})}),{0,3},"int16",{})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"int16"),{0}),np.reshape(np.array({},"int16"),{0,2})}) end),"case 594 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"int16"),{0}),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2})}) end),"case 595 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"int16"),{0}),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2})}) end),"case 596 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"int16"),{0}),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2})}) end),"case 597 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"int16"),{0}),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2})}) end),"case 598 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"int16"),{0}),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2})}) end),"case 599 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-3},"int16"),{1}),np.reshape(np.array({-3},"int16"),{1})}),{2},"int16",{-3,-3})
cases=cases+1
check(np.vstack({np.reshape(np.array({-3},"int16"),{1}),np.reshape(np.array({-3},"int16"),{1})}),{2,1},"int16",{{-3},{-3}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-3},"int16"),{1}),np.reshape(np.array({-3},"int16"),{1})}),{1,1,2},"int16",{{{-3,-3}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-3},"int16"),{1}),np.reshape(np.array({-3},"int16"),{1})}),{1,2},"int16",{{-3,-3}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-3},"int16"),{1}),np.reshape(np.array({-3},"int16"),{1})}),{2,1},"int16",{{-3},{-3}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-3},"int16"),{1}),np.reshape(np.array({},"int16"),{0,2}).T}) end),"case 605 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-3},"int16"),{1}),np.reshape(np.array({},"int16"),{0,2}).T}) end),"case 606 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-3},"int16"),{1}),np.reshape(np.array({},"int16"),{0,2}).T}) end),"case 607 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-3},"int16"),{1}),np.reshape(np.array({},"int16"),{0,2}).T}) end),"case 608 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-3},"int16"),{1}),np.reshape(np.array({},"int16"),{0,2}).T}) end),"case 609 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-3},"int16"),{1}),np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),1)}) end),"case 610 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-3},"int16"),{1}),np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),1)}) end),"case 611 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-3},"int16"),{1}),np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),1)}) end),"case 612 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-3},"int16"),{1}),np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),1)}) end),"case 613 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-3},"int16"),{1}),np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),1)}) end),"case 614 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-3},"int16"),{1}),1),np.flip(np.reshape(np.array({-3},"int16"),{1}),1)}),{2},"int16",{-3,-3})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-3},"int16"),{1}),1),np.flip(np.reshape(np.array({-3},"int16"),{1}),1)}),{2,1},"int16",{{-3},{-3}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({-3},"int16"),{1}),1),np.flip(np.reshape(np.array({-3},"int16"),{1}),1)}),{1,1,2},"int16",{{{-3,-3}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({-3},"int16"),{1}),1),np.flip(np.reshape(np.array({-3},"int16"),{1}),1)}),{1,2},"int16",{{-3,-3}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-3},"int16"),{1}),1),np.flip(np.reshape(np.array({-3},"int16"),{1}),1)}),{2,1},"int16",{{-3},{-3}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-3},"int16"),{1}),1),np.reshape(np.array({},"int16"),{2,0})}) end),"case 620 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-3},"int16"),{1}),1),np.reshape(np.array({},"int16"),{2,0})}) end),"case 621 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-3},"int16"),{1}),1),np.reshape(np.array({},"int16"),{2,0})}) end),"case 622 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-3},"int16"),{1}),1),np.reshape(np.array({},"int16"),{2,0})}) end),"case 623 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-3},"int16"),{1}),1),np.reshape(np.array({},"int16"),{2,0})}) end),"case 624 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-3},"int16"),{1}),1),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}).T}) end),"case 625 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-3},"int16"),{1}),1),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}).T}) end),"case 626 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-3},"int16"),{1}),1),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}).T}) end),"case 627 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-3},"int16"),{1}),1),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}).T}) end),"case 628 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-3},"int16"),{1}),1),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}).T}) end),"case 629 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-8,-5},"int16"),{2}),np.reshape(np.array({-8,-5},"int16"),{2})}),{4},"int16",{-8,-5,-8,-5})
cases=cases+1
check(np.vstack({np.reshape(np.array({-8,-5},"int16"),{2}),np.reshape(np.array({-8,-5},"int16"),{2})}),{2,2},"int16",{{-8,-5},{-8,-5}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-8,-5},"int16"),{2}),np.reshape(np.array({-8,-5},"int16"),{2})}),{1,2,2},"int16",{{{-8,-8},{-5,-5}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-8,-5},"int16"),{2}),np.reshape(np.array({-8,-5},"int16"),{2})}),{2,2},"int16",{{-8,-8},{-5,-5}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-8,-5},"int16"),{2}),np.reshape(np.array({-8,-5},"int16"),{2})}),{2,2},"int16",{{-8,-5},{-8,-5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-8,-5},"int16"),{2}),np.reshape(np.array({},"int16"),{2,0}).T}) end),"case 635 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({-8,-5},"int16"),{2}),np.reshape(np.array({},"int16"),{2,0}).T}),{1,2},"int16",{{-8,-5}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-8,-5},"int16"),{2}),np.reshape(np.array({},"int16"),{2,0}).T}) end),"case 637 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-8,-5},"int16"),{2}),np.reshape(np.array({},"int16"),{2,0}).T}) end),"case 638 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({-8,-5},"int16"),{2}),np.reshape(np.array({},"int16"),{2,0}).T}),{1,2},"int16",{{-8,-5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-8,-5},"int16"),{2}),np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2})}) end),"case 640 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-8,-5},"int16"),{2}),np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2})}) end),"case 641 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-8,-5},"int16"),{2}),np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2})}) end),"case 642 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-8,-5},"int16"),{2}),np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2})}) end),"case 643 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-8,-5},"int16"),{2}),np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2})}) end),"case 644 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-8,-5},"int16"),{2}),1),np.flip(np.reshape(np.array({-8,-5},"int16"),{2}),1)}),{4},"int16",{-5,-8,-5,-8})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-8,-5},"int16"),{2}),1),np.flip(np.reshape(np.array({-8,-5},"int16"),{2}),1)}),{2,2},"int16",{{-5,-8},{-5,-8}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({-8,-5},"int16"),{2}),1),np.flip(np.reshape(np.array({-8,-5},"int16"),{2}),1)}),{1,2,2},"int16",{{{-5,-5},{-8,-8}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({-8,-5},"int16"),{2}),1),np.flip(np.reshape(np.array({-8,-5},"int16"),{2}),1)}),{2,2},"int16",{{-5,-5},{-8,-8}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-8,-5},"int16"),{2}),1),np.flip(np.reshape(np.array({-8,-5},"int16"),{2}),1)}),{2,2},"int16",{{-5,-8},{-5,-8}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-8,-5},"int16"),{2}),1),np.reshape(np.array({-7,-4},"int16"),{1,2})}) end),"case 650 expected failure")
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-8,-5},"int16"),{2}),1),np.reshape(np.array({-7,-4},"int16"),{1,2})}),{2,2},"int16",{{-5,-8},{-7,-4}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({-8,-5},"int16"),{2}),1),np.reshape(np.array({-7,-4},"int16"),{1,2})}),{1,2,2},"int16",{{{-5,-7},{-8,-4}}})
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-8,-5},"int16"),{2}),1),np.reshape(np.array({-7,-4},"int16"),{1,2})}) end),"case 653 expected failure")
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-8,-5},"int16"),{2}),1),np.reshape(np.array({-7,-4},"int16"),{1,2})}),{2,2},"int16",{{-5,-8},{-7,-4}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-8,-5},"int16"),{2}),1),np.flip(np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),1)}) end),"case 655 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-8,-5},"int16"),{2}),1),np.flip(np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),1)}) end),"case 656 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-8,-5},"int16"),{2}),1),np.flip(np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),1)}) end),"case 657 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-8,-5},"int16"),{2}),1),np.flip(np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),1)}) end),"case 658 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-8,-5},"int16"),{2}),1),np.flip(np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),1)}) end),"case 659 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-6,-3,0},"int16"),{3}),np.reshape(np.array({-6,-3,0},"int16"),{3})}),{6},"int16",{-6,-3,0,-6,-3,0})
cases=cases+1
check(np.vstack({np.reshape(np.array({-6,-3,0},"int16"),{3}),np.reshape(np.array({-6,-3,0},"int16"),{3})}),{2,3},"int16",{{-6,-3,0},{-6,-3,0}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-6,-3,0},"int16"),{3}),np.reshape(np.array({-6,-3,0},"int16"),{3})}),{1,3,2},"int16",{{{-6,-6},{-3,-3},{0,0}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-6,-3,0},"int16"),{3}),np.reshape(np.array({-6,-3,0},"int16"),{3})}),{3,2},"int16",{{-6,-6},{-3,-3},{0,0}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-6,-3,0},"int16"),{3}),np.reshape(np.array({-6,-3,0},"int16"),{3})}),{2,3},"int16",{{-6,-3,0},{-6,-3,0}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-6,-3,0},"int16"),{3}),np.flip(np.reshape(np.array({-7,-4},"int16"),{1,2}),1)}) end),"case 665 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-6,-3,0},"int16"),{3}),np.flip(np.reshape(np.array({-7,-4},"int16"),{1,2}),1)}) end),"case 666 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-6,-3,0},"int16"),{3}),np.flip(np.reshape(np.array({-7,-4},"int16"),{1,2}),1)}) end),"case 667 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-6,-3,0},"int16"),{3}),np.flip(np.reshape(np.array({-7,-4},"int16"),{1,2}),1)}) end),"case 668 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-6,-3,0},"int16"),{3}),np.flip(np.reshape(np.array({-7,-4},"int16"),{1,2}),1)}) end),"case 669 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-6,-3,0},"int16"),{3}),np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}).T}) end),"case 670 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-6,-3,0},"int16"),{3}),np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}).T}) end),"case 671 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-6,-3,0},"int16"),{3}),np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}).T}) end),"case 672 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-6,-3,0},"int16"),{3}),np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}).T}) end),"case 673 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-6,-3,0},"int16"),{3}),np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}).T}) end),"case 674 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-6,-3,0},"int16"),{3}),1),np.flip(np.reshape(np.array({-6,-3,0},"int16"),{3}),1)}),{6},"int16",{0,-3,-6,0,-3,-6})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-6,-3,0},"int16"),{3}),1),np.flip(np.reshape(np.array({-6,-3,0},"int16"),{3}),1)}),{2,3},"int16",{{0,-3,-6},{0,-3,-6}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({-6,-3,0},"int16"),{3}),1),np.flip(np.reshape(np.array({-6,-3,0},"int16"),{3}),1)}),{1,3,2},"int16",{{{0,0},{-3,-3},{-6,-6}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({-6,-3,0},"int16"),{3}),1),np.flip(np.reshape(np.array({-6,-3,0},"int16"),{3}),1)}),{3,2},"int16",{{0,0},{-3,-3},{-6,-6}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-6,-3,0},"int16"),{3}),1),np.flip(np.reshape(np.array({-6,-3,0},"int16"),{3}),1)}),{2,3},"int16",{{0,-3,-6},{0,-3,-6}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-6,-3,0},"int16"),{3}),1),np.reshape(np.array({-7,-4},"int16"),{1,2}).T}) end),"case 680 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-6,-3,0},"int16"),{3}),1),np.reshape(np.array({-7,-4},"int16"),{1,2}).T}) end),"case 681 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-6,-3,0},"int16"),{3}),1),np.reshape(np.array({-7,-4},"int16"),{1,2}).T}) end),"case 682 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-6,-3,0},"int16"),{3}),1),np.reshape(np.array({-7,-4},"int16"),{1,2}).T}) end),"case 683 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-6,-3,0},"int16"),{3}),1),np.reshape(np.array({-7,-4},"int16"),{1,2}).T}) end),"case 684 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-6,-3,0},"int16"),{3}),1),np.reshape(np.array({-5},"int16"),{})}),{4},"int16",{0,-3,-6,-5})
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-6,-3,0},"int16"),{3}),1),np.reshape(np.array({-5},"int16"),{})}) end),"case 686 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-6,-3,0},"int16"),{3}),1),np.reshape(np.array({-5},"int16"),{})}) end),"case 687 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-6,-3,0},"int16"),{3}),1),np.reshape(np.array({-5},"int16"),{})}) end),"case 688 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-6,-3,0},"int16"),{3}),1),np.reshape(np.array({-5},"int16"),{})}) end),"case 689 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({},"int16"),{0,2}),np.reshape(np.array({},"int16"),{0,2})}),{0,4},"int16",{})
cases=cases+1
check(np.vstack({np.reshape(np.array({},"int16"),{0,2}),np.reshape(np.array({},"int16"),{0,2})}),{0,2},"int16",{})
cases=cases+1
check(np.dstack({np.reshape(np.array({},"int16"),{0,2}),np.reshape(np.array({},"int16"),{0,2})}),{0,2,2},"int16",{})
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"int16"),{0,2}),np.reshape(np.array({},"int16"),{0,2})}),{0,4},"int16",{})
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"int16"),{0,2}),np.reshape(np.array({},"int16"),{0,2})}),{0,2},"int16",{})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"int16"),{0,2}),np.reshape(np.array({-4,-1},"int16"),{2,1})}) end),"case 695 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"int16"),{0,2}),np.reshape(np.array({-4,-1},"int16"),{2,1})}) end),"case 696 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"int16"),{0,2}),np.reshape(np.array({-4,-1},"int16"),{2,1})}) end),"case 697 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"int16"),{0,2}),np.reshape(np.array({-4,-1},"int16"),{2,1})}) end),"case 698 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"int16"),{0,2}),np.reshape(np.array({-4,-1},"int16"),{2,1})}) end),"case 699 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"int16"),{0,2}),np.reshape(np.array({},"int16"),{0})}) end),"case 700 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"int16"),{0,2}),np.reshape(np.array({},"int16"),{0})}) end),"case 701 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"int16"),{0,2}),np.reshape(np.array({},"int16"),{0})}) end),"case 702 expected failure")
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"int16"),{0,2}),np.reshape(np.array({},"int16"),{0})}),{0,3},"int16",{})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"int16"),{0,2}),np.reshape(np.array({},"int16"),{0})}) end),"case 704 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({},"int16"),{0,2}).T,np.reshape(np.array({},"int16"),{0,2}).T}),{2,0},"int16",{{},{}})
cases=cases+1
check(np.vstack({np.reshape(np.array({},"int16"),{0,2}).T,np.reshape(np.array({},"int16"),{0,2}).T}),{4,0},"int16",{{},{},{},{}})
cases=cases+1
check(np.dstack({np.reshape(np.array({},"int16"),{0,2}).T,np.reshape(np.array({},"int16"),{0,2}).T}),{2,0,2},"int16",{{},{}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"int16"),{0,2}).T,np.reshape(np.array({},"int16"),{0,2}).T}),{2,0},"int16",{{},{}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"int16"),{0,2}).T,np.reshape(np.array({},"int16"),{0,2}).T}),{4,0},"int16",{{},{},{},{}})
cases=cases+1
check(np.hstack({np.reshape(np.array({},"int16"),{0,2}).T,np.flip(np.reshape(np.array({-4,-1},"int16"),{2,1}),1)}),{2,1},"int16",{{-1},{-4}})
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"int16"),{0,2}).T,np.flip(np.reshape(np.array({-4,-1},"int16"),{2,1}),1)}) end),"case 711 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"int16"),{0,2}).T,np.flip(np.reshape(np.array({-4,-1},"int16"),{2,1}),1)}) end),"case 712 expected failure")
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"int16"),{0,2}).T,np.flip(np.reshape(np.array({-4,-1},"int16"),{2,1}),1)}),{2,1},"int16",{{-1},{-4}})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"int16"),{0,2}).T,np.flip(np.reshape(np.array({-4,-1},"int16"),{2,1}),1)}) end),"case 714 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"int16"),{0,2}).T,np.reshape(np.array({-3},"int16"),{1})}) end),"case 715 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"int16"),{0,2}).T,np.reshape(np.array({-3},"int16"),{1})}) end),"case 716 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"int16"),{0,2}).T,np.reshape(np.array({-3},"int16"),{1})}) end),"case 717 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"int16"),{0,2}).T,np.reshape(np.array({-3},"int16"),{1})}) end),"case 718 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"int16"),{0,2}).T,np.reshape(np.array({-3},"int16"),{1})}) end),"case 719 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({},"int16"),{2,0}),np.reshape(np.array({},"int16"),{2,0})}),{2,0},"int16",{{},{}})
cases=cases+1
check(np.vstack({np.reshape(np.array({},"int16"),{2,0}),np.reshape(np.array({},"int16"),{2,0})}),{4,0},"int16",{{},{},{},{}})
cases=cases+1
check(np.dstack({np.reshape(np.array({},"int16"),{2,0}),np.reshape(np.array({},"int16"),{2,0})}),{2,0,2},"int16",{{},{}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"int16"),{2,0}),np.reshape(np.array({},"int16"),{2,0})}),{2,0},"int16",{{},{}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"int16"),{2,0}),np.reshape(np.array({},"int16"),{2,0})}),{4,0},"int16",{{},{},{},{}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"int16"),{2,0}),np.reshape(np.array({-4,-1},"int16"),{2,1}).T}) end),"case 725 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"int16"),{2,0}),np.reshape(np.array({-4,-1},"int16"),{2,1}).T}) end),"case 726 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"int16"),{2,0}),np.reshape(np.array({-4,-1},"int16"),{2,1}).T}) end),"case 727 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"int16"),{2,0}),np.reshape(np.array({-4,-1},"int16"),{2,1}).T}) end),"case 728 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"int16"),{2,0}),np.reshape(np.array({-4,-1},"int16"),{2,1}).T}) end),"case 729 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"int16"),{2,0}),np.flip(np.reshape(np.array({-3},"int16"),{1}),1)}) end),"case 730 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"int16"),{2,0}),np.flip(np.reshape(np.array({-3},"int16"),{1}),1)}) end),"case 731 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"int16"),{2,0}),np.flip(np.reshape(np.array({-3},"int16"),{1}),1)}) end),"case 732 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"int16"),{2,0}),np.flip(np.reshape(np.array({-3},"int16"),{1}),1)}) end),"case 733 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"int16"),{2,0}),np.flip(np.reshape(np.array({-3},"int16"),{1}),1)}) end),"case 734 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({},"int16"),{2,0}).T,np.reshape(np.array({},"int16"),{2,0}).T}),{0,4},"int16",{})
cases=cases+1
check(np.vstack({np.reshape(np.array({},"int16"),{2,0}).T,np.reshape(np.array({},"int16"),{2,0}).T}),{0,2},"int16",{})
cases=cases+1
check(np.dstack({np.reshape(np.array({},"int16"),{2,0}).T,np.reshape(np.array({},"int16"),{2,0}).T}),{0,2,2},"int16",{})
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"int16"),{2,0}).T,np.reshape(np.array({},"int16"),{2,0}).T}),{0,4},"int16",{})
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"int16"),{2,0}).T,np.reshape(np.array({},"int16"),{2,0}).T}),{0,2},"int16",{})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"int16"),{2,0}).T,np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2})}) end),"case 740 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({},"int16"),{2,0}).T,np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2})}),{2,2},"int16",{{-8,-5},{-2,1}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"int16"),{2,0}).T,np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2})}) end),"case 742 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"int16"),{2,0}).T,np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2})}) end),"case 743 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"int16"),{2,0}).T,np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2})}),{2,2},"int16",{{-8,-5},{-2,1}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"int16"),{2,0}).T,np.reshape(np.array({-8,-5},"int16"),{2})}) end),"case 745 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({},"int16"),{2,0}).T,np.reshape(np.array({-8,-5},"int16"),{2})}),{1,2},"int16",{{-8,-5}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"int16"),{2,0}).T,np.reshape(np.array({-8,-5},"int16"),{2})}) end),"case 747 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"int16"),{2,0}).T,np.reshape(np.array({-8,-5},"int16"),{2})}) end),"case 748 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"int16"),{2,0}).T,np.reshape(np.array({-8,-5},"int16"),{2})}),{1,2},"int16",{{-8,-5}})
cases=cases+1
check(np.hstack({np.reshape(np.array({-7,-4},"int16"),{1,2}),np.reshape(np.array({-7,-4},"int16"),{1,2})}),{1,4},"int16",{{-7,-4,-7,-4}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-7,-4},"int16"),{1,2}),np.reshape(np.array({-7,-4},"int16"),{1,2})}),{2,2},"int16",{{-7,-4},{-7,-4}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-7,-4},"int16"),{1,2}),np.reshape(np.array({-7,-4},"int16"),{1,2})}),{1,2,2},"int16",{{{-7,-7},{-4,-4}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-7,-4},"int16"),{1,2}),np.reshape(np.array({-7,-4},"int16"),{1,2})}),{1,4},"int16",{{-7,-4,-7,-4}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-7,-4},"int16"),{1,2}),np.reshape(np.array({-7,-4},"int16"),{1,2})}),{2,2},"int16",{{-7,-4},{-7,-4}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-7,-4},"int16"),{1,2}),np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),1)}) end),"case 755 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({-7,-4},"int16"),{1,2}),np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),1)}),{3,2},"int16",{{-7,-4},{-2,1},{-8,-5}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-7,-4},"int16"),{1,2}),np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),1)}) end),"case 757 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-7,-4},"int16"),{1,2}),np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),1)}) end),"case 758 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({-7,-4},"int16"),{1,2}),np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),1)}),{3,2},"int16",{{-7,-4},{-2,1},{-8,-5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-7,-4},"int16"),{1,2}),np.flip(np.reshape(np.array({-8,-5},"int16"),{2}),1)}) end),"case 760 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({-7,-4},"int16"),{1,2}),np.flip(np.reshape(np.array({-8,-5},"int16"),{2}),1)}),{2,2},"int16",{{-7,-4},{-5,-8}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-7,-4},"int16"),{1,2}),np.flip(np.reshape(np.array({-8,-5},"int16"),{2}),1)}),{1,2,2},"int16",{{{-7,-5},{-4,-8}}})
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-7,-4},"int16"),{1,2}),np.flip(np.reshape(np.array({-8,-5},"int16"),{2}),1)}) end),"case 763 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({-7,-4},"int16"),{1,2}),np.flip(np.reshape(np.array({-8,-5},"int16"),{2}),1)}),{2,2},"int16",{{-7,-4},{-5,-8}})
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-7,-4},"int16"),{1,2}),1),np.flip(np.reshape(np.array({-7,-4},"int16"),{1,2}),1)}),{1,4},"int16",{{-7,-4,-7,-4}})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-7,-4},"int16"),{1,2}),1),np.flip(np.reshape(np.array({-7,-4},"int16"),{1,2}),1)}),{2,2},"int16",{{-7,-4},{-7,-4}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({-7,-4},"int16"),{1,2}),1),np.flip(np.reshape(np.array({-7,-4},"int16"),{1,2}),1)}),{1,2,2},"int16",{{{-7,-7},{-4,-4}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({-7,-4},"int16"),{1,2}),1),np.flip(np.reshape(np.array({-7,-4},"int16"),{1,2}),1)}),{1,4},"int16",{{-7,-4,-7,-4}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-7,-4},"int16"),{1,2}),1),np.flip(np.reshape(np.array({-7,-4},"int16"),{1,2}),1)}),{2,2},"int16",{{-7,-4},{-7,-4}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-7,-4},"int16"),{1,2}),1),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}).T}) end),"case 770 expected failure")
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-7,-4},"int16"),{1,2}),1),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}).T}),{3,2},"int16",{{-7,-4},{-8,-2},{-5,1}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-7,-4},"int16"),{1,2}),1),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}).T}) end),"case 772 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-7,-4},"int16"),{1,2}),1),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}).T}) end),"case 773 expected failure")
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-7,-4},"int16"),{1,2}),1),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}).T}),{3,2},"int16",{{-7,-4},{-8,-2},{-5,1}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-7,-4},"int16"),{1,2}),1),np.reshape(np.array({-6,-3,0},"int16"),{3})}) end),"case 775 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-7,-4},"int16"),{1,2}),1),np.reshape(np.array({-6,-3,0},"int16"),{3})}) end),"case 776 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-7,-4},"int16"),{1,2}),1),np.reshape(np.array({-6,-3,0},"int16"),{3})}) end),"case 777 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-7,-4},"int16"),{1,2}),1),np.reshape(np.array({-6,-3,0},"int16"),{3})}) end),"case 778 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-7,-4},"int16"),{1,2}),1),np.reshape(np.array({-6,-3,0},"int16"),{3})}) end),"case 779 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-7,-4},"int16"),{1,2}).T,np.reshape(np.array({-7,-4},"int16"),{1,2}).T}),{2,2},"int16",{{-7,-7},{-4,-4}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-7,-4},"int16"),{1,2}).T,np.reshape(np.array({-7,-4},"int16"),{1,2}).T}),{4,1},"int16",{{-7},{-4},{-7},{-4}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-7,-4},"int16"),{1,2}).T,np.reshape(np.array({-7,-4},"int16"),{1,2}).T}),{2,1,2},"int16",{{{-7,-7}},{{-4,-4}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-7,-4},"int16"),{1,2}).T,np.reshape(np.array({-7,-4},"int16"),{1,2}).T}),{2,2},"int16",{{-7,-7},{-4,-4}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-7,-4},"int16"),{1,2}).T,np.reshape(np.array({-7,-4},"int16"),{1,2}).T}),{4,1},"int16",{{-7},{-4},{-7},{-4}})
cases=cases+1
check(np.hstack({np.reshape(np.array({-7,-4},"int16"),{1,2}).T,np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3})}),{2,4},"int16",{{-7,-5,-2,1},{-4,4,7,-7}})
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-7,-4},"int16"),{1,2}).T,np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3})}) end),"case 786 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-7,-4},"int16"),{1,2}).T,np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3})}) end),"case 787 expected failure")
cases=cases+1
check(np.column_stack({np.reshape(np.array({-7,-4},"int16"),{1,2}).T,np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3})}),{2,4},"int16",{{-7,-5,-2,1},{-4,4,7,-7}})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-7,-4},"int16"),{1,2}).T,np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3})}) end),"case 789 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-7,-4},"int16"),{1,2}).T,np.flip(np.reshape(np.array({-6,-3,0},"int16"),{3}),1)}) end),"case 790 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-7,-4},"int16"),{1,2}).T,np.flip(np.reshape(np.array({-6,-3,0},"int16"),{3}),1)}) end),"case 791 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-7,-4},"int16"),{1,2}).T,np.flip(np.reshape(np.array({-6,-3,0},"int16"),{3}),1)}) end),"case 792 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-7,-4},"int16"),{1,2}).T,np.flip(np.reshape(np.array({-6,-3,0},"int16"),{3}),1)}) end),"case 793 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-7,-4},"int16"),{1,2}).T,np.flip(np.reshape(np.array({-6,-3,0},"int16"),{3}),1)}) end),"case 794 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-4,-1},"int16"),{2,1}),np.reshape(np.array({-4,-1},"int16"),{2,1})}),{2,2},"int16",{{-4,-4},{-1,-1}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-4,-1},"int16"),{2,1}),np.reshape(np.array({-4,-1},"int16"),{2,1})}),{4,1},"int16",{{-4},{-1},{-4},{-1}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-4,-1},"int16"),{2,1}),np.reshape(np.array({-4,-1},"int16"),{2,1})}),{2,1,2},"int16",{{{-4,-4}},{{-1,-1}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-4,-1},"int16"),{2,1}),np.reshape(np.array({-4,-1},"int16"),{2,1})}),{2,2},"int16",{{-4,-4},{-1,-1}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-4,-1},"int16"),{2,1}),np.reshape(np.array({-4,-1},"int16"),{2,1})}),{4,1},"int16",{{-4},{-1},{-4},{-1}})
cases=cases+1
check(np.hstack({np.reshape(np.array({-4,-1},"int16"),{2,1}),np.flip(np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),1)}),{2,4},"int16",{{-4,4,7,-7},{-1,-5,-2,1}})
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-4,-1},"int16"),{2,1}),np.flip(np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),1)}) end),"case 801 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-4,-1},"int16"),{2,1}),np.flip(np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),1)}) end),"case 802 expected failure")
cases=cases+1
check(np.column_stack({np.reshape(np.array({-4,-1},"int16"),{2,1}),np.flip(np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),1)}),{2,4},"int16",{{-4,4,7,-7},{-1,-5,-2,1}})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-4,-1},"int16"),{2,1}),np.flip(np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),1)}) end),"case 804 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-4,-1},"int16"),{2,1}),np.reshape(np.array({},"int16"),{0,2})}) end),"case 805 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-4,-1},"int16"),{2,1}),np.reshape(np.array({},"int16"),{0,2})}) end),"case 806 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-4,-1},"int16"),{2,1}),np.reshape(np.array({},"int16"),{0,2})}) end),"case 807 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-4,-1},"int16"),{2,1}),np.reshape(np.array({},"int16"),{0,2})}) end),"case 808 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-4,-1},"int16"),{2,1}),np.reshape(np.array({},"int16"),{0,2})}) end),"case 809 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-4,-1},"int16"),{2,1}),1),np.flip(np.reshape(np.array({-4,-1},"int16"),{2,1}),1)}),{2,2},"int16",{{-1,-1},{-4,-4}})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-4,-1},"int16"),{2,1}),1),np.flip(np.reshape(np.array({-4,-1},"int16"),{2,1}),1)}),{4,1},"int16",{{-1},{-4},{-1},{-4}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({-4,-1},"int16"),{2,1}),1),np.flip(np.reshape(np.array({-4,-1},"int16"),{2,1}),1)}),{2,1,2},"int16",{{{-1,-1}},{{-4,-4}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({-4,-1},"int16"),{2,1}),1),np.flip(np.reshape(np.array({-4,-1},"int16"),{2,1}),1)}),{2,2},"int16",{{-1,-1},{-4,-4}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-4,-1},"int16"),{2,1}),1),np.flip(np.reshape(np.array({-4,-1},"int16"),{2,1}),1)}),{4,1},"int16",{{-1},{-4},{-1},{-4}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-4,-1},"int16"),{2,1}),1),np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}).T}) end),"case 815 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-4,-1},"int16"),{2,1}),1),np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}).T}) end),"case 816 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-4,-1},"int16"),{2,1}),1),np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}).T}) end),"case 817 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-4,-1},"int16"),{2,1}),1),np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}).T}) end),"case 818 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-4,-1},"int16"),{2,1}),1),np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}).T}) end),"case 819 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-4,-1},"int16"),{2,1}),1),np.reshape(np.array({},"int16"),{0,2}).T}),{2,1},"int16",{{-1},{-4}})
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-4,-1},"int16"),{2,1}),1),np.reshape(np.array({},"int16"),{0,2}).T}) end),"case 821 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-4,-1},"int16"),{2,1}),1),np.reshape(np.array({},"int16"),{0,2}).T}) end),"case 822 expected failure")
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({-4,-1},"int16"),{2,1}),1),np.reshape(np.array({},"int16"),{0,2}).T}),{2,1},"int16",{{-1},{-4}})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-4,-1},"int16"),{2,1}),1),np.reshape(np.array({},"int16"),{0,2}).T}) end),"case 824 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-4,-1},"int16"),{2,1}).T,np.reshape(np.array({-4,-1},"int16"),{2,1}).T}),{1,4},"int16",{{-4,-1,-4,-1}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-4,-1},"int16"),{2,1}).T,np.reshape(np.array({-4,-1},"int16"),{2,1}).T}),{2,2},"int16",{{-4,-1},{-4,-1}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-4,-1},"int16"),{2,1}).T,np.reshape(np.array({-4,-1},"int16"),{2,1}).T}),{1,2,2},"int16",{{{-4,-4},{-1,-1}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-4,-1},"int16"),{2,1}).T,np.reshape(np.array({-4,-1},"int16"),{2,1}).T}),{1,4},"int16",{{-4,-1,-4,-1}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-4,-1},"int16"),{2,1}).T,np.reshape(np.array({-4,-1},"int16"),{2,1}).T}),{2,2},"int16",{{-4,-1},{-4,-1}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-4,-1},"int16"),{2,1}).T,np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2})}) end),"case 830 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({-4,-1},"int16"),{2,1}).T,np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2})}),{4,2},"int16",{{-4,-1},{-2,1},{4,7},{-7,-4}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-4,-1},"int16"),{2,1}).T,np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2})}) end),"case 832 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-4,-1},"int16"),{2,1}).T,np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2})}) end),"case 833 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({-4,-1},"int16"),{2,1}).T,np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2})}),{4,2},"int16",{{-4,-1},{-2,1},{4,7},{-7,-4}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-4,-1},"int16"),{2,1}).T,np.reshape(np.array({},"int16"),{2,0})}) end),"case 835 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-4,-1},"int16"),{2,1}).T,np.reshape(np.array({},"int16"),{2,0})}) end),"case 836 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-4,-1},"int16"),{2,1}).T,np.reshape(np.array({},"int16"),{2,0})}) end),"case 837 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-4,-1},"int16"),{2,1}).T,np.reshape(np.array({},"int16"),{2,0})}) end),"case 838 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-4,-1},"int16"),{2,1}).T,np.reshape(np.array({},"int16"),{2,0})}) end),"case 839 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2})}),{2,4},"int16",{{-8,-5,-8,-5},{-2,1,-2,1}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2})}),{4,2},"int16",{{-8,-5},{-2,1},{-8,-5},{-2,1}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2})}),{2,2,2},"int16",{{{-8,-8},{-5,-5}},{{-2,-2},{1,1}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2})}),{2,4},"int16",{{-8,-5,-8,-5},{-2,1,-2,1}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2})}),{4,2},"int16",{{-8,-5},{-2,1},{-8,-5},{-2,1}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),np.flip(np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),1)}) end),"case 845 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),np.flip(np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),1)}),{5,2},"int16",{{-8,-5},{-2,1},{-7,-4},{4,7},{-2,1}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),np.flip(np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),1)}) end),"case 847 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),np.flip(np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),1)}) end),"case 848 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),np.flip(np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),1)}),{5,2},"int16",{{-8,-5},{-2,1},{-7,-4},{4,7},{-2,1}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),np.reshape(np.array({},"int16"),{2,0}).T}) end),"case 850 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),np.reshape(np.array({},"int16"),{2,0}).T}),{2,2},"int16",{{-8,-5},{-2,1}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),np.reshape(np.array({},"int16"),{2,0}).T}) end),"case 852 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),np.reshape(np.array({},"int16"),{2,0}).T}) end),"case 853 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),np.reshape(np.array({},"int16"),{2,0}).T}),{2,2},"int16",{{-8,-5},{-2,1}})
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),1),np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),1)}),{2,4},"int16",{{-2,1,-2,1},{-8,-5,-8,-5}})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),1),np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),1)}),{4,2},"int16",{{-2,1},{-8,-5},{-2,1},{-8,-5}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),1),np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),1)}),{2,2,2},"int16",{{{-2,-2},{1,1}},{{-8,-8},{-5,-5}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),1),np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),1)}),{2,4},"int16",{{-2,1,-2,1},{-8,-5,-8,-5}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),1),np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),1)}),{4,2},"int16",{{-2,1},{-8,-5},{-2,1},{-8,-5}})
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),1),np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}).T}),{2,5},"int16",{{-2,1,-2,4,-7},{-8,-5,1,7,-4}})
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),1),np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}).T}) end),"case 861 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),1),np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}).T}) end),"case 862 expected failure")
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),1),np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}).T}),{2,5},"int16",{{-2,1,-2,4,-7},{-8,-5,1,7,-4}})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),1),np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}).T}) end),"case 864 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),1),np.reshape(np.array({-7,-4},"int16"),{1,2})}) end),"case 865 expected failure")
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),1),np.reshape(np.array({-7,-4},"int16"),{1,2})}),{3,2},"int16",{{-2,1},{-8,-5},{-7,-4}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),1),np.reshape(np.array({-7,-4},"int16"),{1,2})}) end),"case 867 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),1),np.reshape(np.array({-7,-4},"int16"),{1,2})}) end),"case 868 expected failure")
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),1),np.reshape(np.array({-7,-4},"int16"),{1,2})}),{3,2},"int16",{{-2,1},{-8,-5},{-7,-4}})
cases=cases+1
check(np.hstack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}).T,np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}).T}),{2,4},"int16",{{-8,-2,-8,-2},{-5,1,-5,1}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}).T,np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}).T}),{4,2},"int16",{{-8,-2},{-5,1},{-8,-2},{-5,1}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}).T,np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}).T}),{2,2,2},"int16",{{{-8,-8},{-2,-2}},{{-5,-5},{1,1}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}).T,np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}).T}),{2,4},"int16",{{-8,-2,-8,-2},{-5,1,-5,1}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}).T,np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}).T}),{4,2},"int16",{{-8,-2},{-5,1},{-8,-2},{-5,1}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}).T,np.reshape(np.array({},"int16"),{0,2,1})}) end),"case 875 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}).T,np.reshape(np.array({},"int16"),{0,2,1})}) end),"case 876 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}).T,np.reshape(np.array({},"int16"),{0,2,1})}) end),"case 877 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}).T,np.reshape(np.array({},"int16"),{0,2,1})}) end),"case 878 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}).T,np.reshape(np.array({},"int16"),{0,2,1})}) end),"case 879 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}).T,np.flip(np.reshape(np.array({-7,-4},"int16"),{1,2}),1)}) end),"case 880 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}).T,np.flip(np.reshape(np.array({-7,-4},"int16"),{1,2}),1)}),{3,2},"int16",{{-8,-2},{-5,1},{-7,-4}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}).T,np.flip(np.reshape(np.array({-7,-4},"int16"),{1,2}),1)}) end),"case 882 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}).T,np.flip(np.reshape(np.array({-7,-4},"int16"),{1,2}),1)}) end),"case 883 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}).T,np.flip(np.reshape(np.array({-7,-4},"int16"),{1,2}),1)}),{3,2},"int16",{{-8,-2},{-5,1},{-7,-4}})
cases=cases+1
check(np.hstack({np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3})}),{2,6},"int16",{{-5,-2,1,-5,-2,1},{4,7,-7,4,7,-7}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3})}),{4,3},"int16",{{-5,-2,1},{4,7,-7},{-5,-2,1},{4,7,-7}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3})}),{2,3,2},"int16",{{{-5,-5},{-2,-2},{1,1}},{{4,4},{7,7},{-7,-7}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3})}),{2,6},"int16",{{-5,-2,1,-5,-2,1},{4,7,-7,4,7,-7}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3})}),{4,3},"int16",{{-5,-2,1},{4,7,-7},{-5,-2,1},{4,7,-7}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),np.reshape(np.array({},"int16"),{0,2,1}).T}) end),"case 890 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),np.reshape(np.array({},"int16"),{0,2,1}).T}) end),"case 891 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),np.reshape(np.array({},"int16"),{0,2,1}).T}) end),"case 892 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),np.reshape(np.array({},"int16"),{0,2,1}).T}) end),"case 893 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),np.reshape(np.array({},"int16"),{0,2,1}).T}) end),"case 894 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),np.reshape(np.array({-7,-4},"int16"),{1,2}).T}),{2,4},"int16",{{-5,-2,1,-7},{4,7,-7,-4}})
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),np.reshape(np.array({-7,-4},"int16"),{1,2}).T}) end),"case 896 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),np.reshape(np.array({-7,-4},"int16"),{1,2}).T}) end),"case 897 expected failure")
cases=cases+1
check(np.column_stack({np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),np.reshape(np.array({-7,-4},"int16"),{1,2}).T}),{2,4},"int16",{{-5,-2,1,-7},{4,7,-7,-4}})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),np.reshape(np.array({-7,-4},"int16"),{1,2}).T}) end),"case 899 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),1),np.flip(np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),1)}),{2,6},"int16",{{4,7,-7,4,7,-7},{-5,-2,1,-5,-2,1}})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),1),np.flip(np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),1)}),{4,3},"int16",{{4,7,-7},{-5,-2,1},{4,7,-7},{-5,-2,1}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),1),np.flip(np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),1)}),{2,3,2},"int16",{{{4,4},{7,7},{-7,-7}},{{-5,-5},{-2,-2},{1,1}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),1),np.flip(np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),1)}),{2,6},"int16",{{4,7,-7,4,7,-7},{-5,-2,1,-5,-2,1}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),1),np.flip(np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),1)}),{4,3},"int16",{{4,7,-7},{-5,-2,1},{4,7,-7},{-5,-2,1}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),1),np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3})}) end),"case 905 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),1),np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3})}) end),"case 906 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),1),np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3})}) end),"case 907 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),1),np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3})}) end),"case 908 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),1),np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3})}) end),"case 909 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),1),np.reshape(np.array({-4,-1},"int16"),{2,1})}),{2,4},"int16",{{4,7,-7,-4},{-5,-2,1,-1}})
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),1),np.reshape(np.array({-4,-1},"int16"),{2,1})}) end),"case 911 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),1),np.reshape(np.array({-4,-1},"int16"),{2,1})}) end),"case 912 expected failure")
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),1),np.reshape(np.array({-4,-1},"int16"),{2,1})}),{2,4},"int16",{{4,7,-7,-4},{-5,-2,1,-1}})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),1),np.reshape(np.array({-4,-1},"int16"),{2,1})}) end),"case 914 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}).T,np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}).T}),{3,4},"int16",{{-5,4,-5,4},{-2,7,-2,7},{1,-7,1,-7}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}).T,np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}).T}),{6,2},"int16",{{-5,4},{-2,7},{1,-7},{-5,4},{-2,7},{1,-7}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}).T,np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}).T}),{3,2,2},"int16",{{{-5,-5},{4,4}},{{-2,-2},{7,7}},{{1,1},{-7,-7}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}).T,np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}).T}),{3,4},"int16",{{-5,4,-5,4},{-2,7,-2,7},{1,-7,1,-7}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}).T,np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}).T}),{6,2},"int16",{{-5,4},{-2,7},{1,-7},{-5,4},{-2,7},{1,-7}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}).T,np.flip(np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),1)}) end),"case 920 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}).T,np.flip(np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),1)}) end),"case 921 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}).T,np.flip(np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),1)}) end),"case 922 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}).T,np.flip(np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),1)}) end),"case 923 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}).T,np.flip(np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),1)}) end),"case 924 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}).T,np.flip(np.reshape(np.array({-4,-1},"int16"),{2,1}),1)}) end),"case 925 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}).T,np.flip(np.reshape(np.array({-4,-1},"int16"),{2,1}),1)}) end),"case 926 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}).T,np.flip(np.reshape(np.array({-4,-1},"int16"),{2,1}),1)}) end),"case 927 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}).T,np.flip(np.reshape(np.array({-4,-1},"int16"),{2,1}),1)}) end),"case 928 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}).T,np.flip(np.reshape(np.array({-4,-1},"int16"),{2,1}),1)}) end),"case 929 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2})}),{3,4},"int16",{{-2,1,-2,1},{4,7,4,7},{-7,-4,-7,-4}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2})}),{6,2},"int16",{{-2,1},{4,7},{-7,-4},{-2,1},{4,7},{-7,-4}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2})}),{3,2,2},"int16",{{{-2,-2},{1,1}},{{4,4},{7,7}},{{-7,-7},{-4,-4}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2})}),{3,4},"int16",{{-2,1,-2,1},{4,7,4,7},{-7,-4,-7,-4}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2})}),{6,2},"int16",{{-2,1},{4,7},{-7,-4},{-2,1},{4,7},{-7,-4}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}).T}) end),"case 935 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}).T}) end),"case 936 expected failure")
cases=cases+1
check(np.dstack({np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}).T}),{3,2,2},"int16",{{{-2,-4},{1,5}},{{4,-1},{7,8}},{{-7,2},{-4,-6}}})
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}).T}) end),"case 938 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}).T}) end),"case 939 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),np.reshape(np.array({-4,-1},"int16"),{2,1}).T}) end),"case 940 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),np.reshape(np.array({-4,-1},"int16"),{2,1}).T}),{4,2},"int16",{{-2,1},{4,7},{-7,-4},{-4,-1}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),np.reshape(np.array({-4,-1},"int16"),{2,1}).T}) end),"case 942 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),np.reshape(np.array({-4,-1},"int16"),{2,1}).T}) end),"case 943 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),np.reshape(np.array({-4,-1},"int16"),{2,1}).T}),{4,2},"int16",{{-2,1},{4,7},{-7,-4},{-4,-1}})
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),1),np.flip(np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),1)}),{3,4},"int16",{{-7,-4,-7,-4},{4,7,4,7},{-2,1,-2,1}})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),1),np.flip(np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),1)}),{6,2},"int16",{{-7,-4},{4,7},{-2,1},{-7,-4},{4,7},{-2,1}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),1),np.flip(np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),1)}),{3,2,2},"int16",{{{-7,-7},{-4,-4}},{{4,4},{7,7}},{{-2,-2},{1,1}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),1),np.flip(np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),1)}),{3,4},"int16",{{-7,-4,-7,-4},{4,7,4,7},{-2,1,-2,1}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),1),np.flip(np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),1)}),{6,2},"int16",{{-7,-4},{4,7},{-2,1},{-7,-4},{4,7},{-2,1}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),1),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2})}) end),"case 950 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),1),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2})}) end),"case 951 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),1),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2})}) end),"case 952 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),1),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2})}) end),"case 953 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),1),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2})}) end),"case 954 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),1),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2})}) end),"case 955 expected failure")
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),1),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2})}),{5,2},"int16",{{-7,-4},{4,7},{-2,1},{-8,-5},{-2,1}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),1),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2})}) end),"case 957 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),1),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2})}) end),"case 958 expected failure")
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),1),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2})}),{5,2},"int16",{{-7,-4},{4,7},{-2,1},{-8,-5},{-2,1}})
cases=cases+1
check(np.hstack({np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}).T,np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}).T}),{2,6},"int16",{{-2,4,-7,-2,4,-7},{1,7,-4,1,7,-4}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}).T,np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}).T}),{4,3},"int16",{{-2,4,-7},{1,7,-4},{-2,4,-7},{1,7,-4}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}).T,np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}).T}),{2,3,2},"int16",{{{-2,-2},{4,4},{-7,-7}},{{1,1},{7,7},{-4,-4}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}).T,np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}).T}),{2,6},"int16",{{-2,4,-7,-2,4,-7},{1,7,-4,1,7,-4}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}).T,np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}).T}),{4,3},"int16",{{-2,4,-7},{1,7,-4},{-2,4,-7},{1,7,-4}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}).T,np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),1)}) end),"case 965 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}).T,np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),1)}) end),"case 966 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}).T,np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),1)}) end),"case 967 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}).T,np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),1)}) end),"case 968 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}).T,np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),1)}) end),"case 969 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}).T,np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),1)}),{2,5},"int16",{{-2,4,-7,-2,1},{1,7,-4,-8,-5}})
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}).T,np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),1)}) end),"case 971 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}).T,np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),1)}) end),"case 972 expected failure")
cases=cases+1
check(np.column_stack({np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}).T,np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),1)}),{2,5},"int16",{{-2,4,-7,-2,1},{1,7,-4,-8,-5}})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}).T,np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}),1)}) end),"case 974 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({},"int16"),{0,2,1}),np.reshape(np.array({},"int16"),{0,2,1})}),{0,4,1},"int16",{})
cases=cases+1
check(np.vstack({np.reshape(np.array({},"int16"),{0,2,1}),np.reshape(np.array({},"int16"),{0,2,1})}),{0,2,1},"int16",{})
cases=cases+1
check(np.dstack({np.reshape(np.array({},"int16"),{0,2,1}),np.reshape(np.array({},"int16"),{0,2,1})}),{0,2,2},"int16",{})
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"int16"),{0,2,1}),np.reshape(np.array({},"int16"),{0,2,1})}),{0,4,1},"int16",{})
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"int16"),{0,2,1}),np.reshape(np.array({},"int16"),{0,2,1})}),{0,2,1},"int16",{})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"int16"),{0,2,1}),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}).T}) end),"case 980 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"int16"),{0,2,1}),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}).T}) end),"case 981 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"int16"),{0,2,1}),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}).T}) end),"case 982 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"int16"),{0,2,1}),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}).T}) end),"case 983 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"int16"),{0,2,1}),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}).T}) end),"case 984 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"int16"),{0,2,1}),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}).T}) end),"case 985 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"int16"),{0,2,1}),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}).T}) end),"case 986 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"int16"),{0,2,1}),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}).T}) end),"case 987 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"int16"),{0,2,1}),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}).T}) end),"case 988 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"int16"),{0,2,1}),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,2}).T}) end),"case 989 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({},"int16"),{0,2,1}).T,np.reshape(np.array({},"int16"),{0,2,1}).T}),{1,4,0},"int16",{{{},{},{},{}}})
cases=cases+1
check(np.vstack({np.reshape(np.array({},"int16"),{0,2,1}).T,np.reshape(np.array({},"int16"),{0,2,1}).T}),{2,2,0},"int16",{{{},{}},{{},{}}})
cases=cases+1
check(np.dstack({np.reshape(np.array({},"int16"),{0,2,1}).T,np.reshape(np.array({},"int16"),{0,2,1}).T}),{1,2,0},"int16",{{{},{}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"int16"),{0,2,1}).T,np.reshape(np.array({},"int16"),{0,2,1}).T}),{1,4,0},"int16",{{{},{},{},{}}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"int16"),{0,2,1}).T,np.reshape(np.array({},"int16"),{0,2,1}).T}),{2,2,0},"int16",{{{},{}},{{},{}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"int16"),{0,2,1}).T,np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2})}) end),"case 995 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"int16"),{0,2,1}).T,np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2})}) end),"case 996 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"int16"),{0,2,1}).T,np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2})}) end),"case 997 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"int16"),{0,2,1}).T,np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2})}) end),"case 998 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"int16"),{0,2,1}).T,np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2})}) end),"case 999 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"int16"),{0,2,1}).T,np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3})}) end),"case 1000 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"int16"),{0,2,1}).T,np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3})}) end),"case 1001 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"int16"),{0,2,1}).T,np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3})}) end),"case 1002 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"int16"),{0,2,1}).T,np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3})}) end),"case 1003 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"int16"),{0,2,1}).T,np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3})}) end),"case 1004 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3})}),{1,4,3},"int16",{{{-4,-1,2},{5,8,-6},{-4,-1,2},{5,8,-6}}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3})}),{2,2,3},"int16",{{{-4,-1,2},{5,8,-6}},{{-4,-1,2},{5,8,-6}}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3})}),{1,2,6},"int16",{{{-4,-1,2,-4,-1,2},{5,8,-6,5,8,-6}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3})}),{1,4,3},"int16",{{{-4,-1,2},{5,8,-6},{-4,-1,2},{5,8,-6}}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3})}),{2,2,3},"int16",{{{-4,-1,2},{5,8,-6}},{{-4,-1,2},{5,8,-6}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),np.flip(np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),1)}) end),"case 1010 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),np.flip(np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),1)}) end),"case 1011 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),np.flip(np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),1)}) end),"case 1012 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),np.flip(np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),1)}) end),"case 1013 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),np.flip(np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),1)}) end),"case 1014 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),np.flip(np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),1)}) end),"case 1015 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),np.flip(np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),1)}) end),"case 1016 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),np.flip(np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),1)}) end),"case 1017 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),np.flip(np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),1)}) end),"case 1018 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),np.flip(np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}),1)}) end),"case 1019 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),1),np.flip(np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),1)}),{1,4,3},"int16",{{{-4,-1,2},{5,8,-6},{-4,-1,2},{5,8,-6}}})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),1),np.flip(np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),1)}),{2,2,3},"int16",{{{-4,-1,2},{5,8,-6}},{{-4,-1,2},{5,8,-6}}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),1),np.flip(np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),1)}),{1,2,6},"int16",{{{-4,-1,2,-4,-1,2},{5,8,-6,5,8,-6}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),1),np.flip(np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),1)}),{1,4,3},"int16",{{{-4,-1,2},{5,8,-6},{-4,-1,2},{5,8,-6}}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),1),np.flip(np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),1)}),{2,2,3},"int16",{{{-4,-1,2},{5,8,-6}},{{-4,-1,2},{5,8,-6}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),1),np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}).T}) end),"case 1025 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),1),np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}).T}) end),"case 1026 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),1),np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}).T}) end),"case 1027 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),1),np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}).T}) end),"case 1028 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),1),np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}).T}) end),"case 1029 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),1),np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}).T}) end),"case 1030 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),1),np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}).T}) end),"case 1031 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),1),np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}).T}) end),"case 1032 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),1),np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}).T}) end),"case 1033 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),1),np.reshape(np.array({-5,-2,1,4,7,-7},"int16"),{2,3}).T}) end),"case 1034 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}).T,np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}).T}),{3,4,1},"int16",{{{-4},{5},{-4},{5}},{{-1},{8},{-1},{8}},{{2},{-6},{2},{-6}}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}).T,np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}).T}),{6,2,1},"int16",{{{-4},{5}},{{-1},{8}},{{2},{-6}},{{-4},{5}},{{-1},{8}},{{2},{-6}}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}).T,np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}).T}),{3,2,2},"int16",{{{-4,-4},{5,5}},{{-1,-1},{8,8}},{{2,2},{-6,-6}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}).T,np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}).T}),{3,4,1},"int16",{{{-4},{5},{-4},{5}},{{-1},{8},{-1},{8}},{{2},{-6},{2},{-6}}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}).T,np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}).T}),{6,2,1},"int16",{{{-4},{5}},{{-1},{8}},{{2},{-6}},{{-4},{5}},{{-1},{8}},{{2},{-6}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}).T,np.reshape(np.array({-5},"int16"),{})}) end),"case 1040 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}).T,np.reshape(np.array({-5},"int16"),{})}) end),"case 1041 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}).T,np.reshape(np.array({-5},"int16"),{})}) end),"case 1042 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}).T,np.reshape(np.array({-5},"int16"),{})}) end),"case 1043 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}).T,np.reshape(np.array({-5},"int16"),{})}) end),"case 1044 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}).T,np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2})}) end),"case 1045 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}).T,np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2})}) end),"case 1046 expected failure")
cases=cases+1
check(np.dstack({np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}).T,np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2})}),{3,2,2},"int16",{{{-4,-2},{5,1}},{{-1,4},{8,7}},{{2,-7},{-6,-4}}})
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}).T,np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2})}) end),"case 1048 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}).T,np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2})}) end),"case 1049 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2})}),{2,2,2},"int16",{{{-8,-5},{-8,-5}},{{-2,1},{-2,1}}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2})}),{4,1,2},"int16",{{{-8,-5}},{{-2,1}},{{-8,-5}},{{-2,1}}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2})}),{2,1,4},"int16",{{{-8,-5,-8,-5}},{{-2,1,-2,1}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2})}),{2,2,2},"int16",{{{-8,-5},{-8,-5}},{{-2,1},{-2,1}}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2})}),{4,1,2},"int16",{{{-8,-5}},{{-2,1}},{{-8,-5}},{{-2,1}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),np.reshape(np.array({},"int16"),{0})}) end),"case 1055 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),np.reshape(np.array({},"int16"),{0})}) end),"case 1056 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),np.reshape(np.array({},"int16"),{0})}) end),"case 1057 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),np.reshape(np.array({},"int16"),{0})}) end),"case 1058 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),np.reshape(np.array({},"int16"),{0})}) end),"case 1059 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),np.flip(np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),1)}) end),"case 1060 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),np.flip(np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),1)}) end),"case 1061 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),np.flip(np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),1)}) end),"case 1062 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),np.flip(np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),1)}) end),"case 1063 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),np.flip(np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}),1)}) end),"case 1064 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),1),np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),1)}),{2,2,2},"int16",{{{-2,1},{-2,1}},{{-8,-5},{-8,-5}}})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),1),np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),1)}),{4,1,2},"int16",{{{-2,1}},{{-8,-5}},{{-2,1}},{{-8,-5}}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),1),np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),1)}),{2,1,4},"int16",{{{-2,1,-2,1}},{{-8,-5,-8,-5}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),1),np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),1)}),{2,2,2},"int16",{{{-2,1},{-2,1}},{{-8,-5},{-8,-5}}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),1),np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),1)}),{4,1,2},"int16",{{{-2,1}},{{-8,-5}},{{-2,1}},{{-8,-5}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),1),np.reshape(np.array({-3},"int16"),{1})}) end),"case 1070 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),1),np.reshape(np.array({-3},"int16"),{1})}) end),"case 1071 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),1),np.reshape(np.array({-3},"int16"),{1})}) end),"case 1072 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),1),np.reshape(np.array({-3},"int16"),{1})}) end),"case 1073 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),1),np.reshape(np.array({-3},"int16"),{1})}) end),"case 1074 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),1),np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}).T}) end),"case 1075 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),1),np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}).T}) end),"case 1076 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),1),np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}).T}) end),"case 1077 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),1),np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}).T}) end),"case 1078 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}),1),np.reshape(np.array({-2,1,4,7,-7,-4},"int16"),{3,2}).T}) end),"case 1079 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}).T,np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}).T}),{2,2,2},"int16",{{{-8,-2},{-8,-2}},{{-5,1},{-5,1}}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}).T,np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}).T}),{4,1,2},"int16",{{{-8,-2}},{{-5,1}},{{-8,-2}},{{-5,1}}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}).T,np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}).T}),{2,1,4},"int16",{{{-8,-2,-8,-2}},{{-5,1,-5,1}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}).T,np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}).T}),{2,2,2},"int16",{{{-8,-2},{-8,-2}},{{-5,1},{-5,1}}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}).T,np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}).T}),{4,1,2},"int16",{{{-8,-2}},{{-5,1}},{{-8,-2}},{{-5,1}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}).T,np.flip(np.reshape(np.array({-3},"int16"),{1}),1)}) end),"case 1085 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}).T,np.flip(np.reshape(np.array({-3},"int16"),{1}),1)}) end),"case 1086 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}).T,np.flip(np.reshape(np.array({-3},"int16"),{1}),1)}) end),"case 1087 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}).T,np.flip(np.reshape(np.array({-3},"int16"),{1}),1)}) end),"case 1088 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}).T,np.flip(np.reshape(np.array({-3},"int16"),{1}),1)}) end),"case 1089 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}).T,np.reshape(np.array({},"int16"),{0,2,1})}) end),"case 1090 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}).T,np.reshape(np.array({},"int16"),{0,2,1})}) end),"case 1091 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}).T,np.reshape(np.array({},"int16"),{0,2,1})}) end),"case 1092 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}).T,np.reshape(np.array({},"int16"),{0,2,1})}) end),"case 1093 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-8,-5,-2,1},"int16"),{2,1,2}).T,np.reshape(np.array({},"int16"),{0,2,1})}) end),"case 1094 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2})}),{2,4,2},"int16",{{{-5,-2},{1,4},{-5,-2},{1,4}},{{7,-7},{-4,-1},{7,-7},{-4,-1}}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2})}),{4,2,2},"int16",{{{-5,-2},{1,4}},{{7,-7},{-4,-1}},{{-5,-2},{1,4}},{{7,-7},{-4,-1}}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2})}),{2,2,4},"int16",{{{-5,-2,-5,-2},{1,4,1,4}},{{7,-7,7,-7},{-4,-1,-4,-1}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2})}),{2,4,2},"int16",{{{-5,-2},{1,4},{-5,-2},{1,4}},{{7,-7},{-4,-1},{7,-7},{-4,-1}}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2})}),{4,2,2},"int16",{{{-5,-2},{1,4}},{{7,-7},{-4,-1}},{{-5,-2},{1,4}},{{7,-7},{-4,-1}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),np.reshape(np.array({-8,-5},"int16"),{2})}) end),"case 1100 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),np.reshape(np.array({-8,-5},"int16"),{2})}) end),"case 1101 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),np.reshape(np.array({-8,-5},"int16"),{2})}) end),"case 1102 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),np.reshape(np.array({-8,-5},"int16"),{2})}) end),"case 1103 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),np.reshape(np.array({-8,-5},"int16"),{2})}) end),"case 1104 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),np.reshape(np.array({},"int16"),{0,2,1}).T}) end),"case 1105 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),np.reshape(np.array({},"int16"),{0,2,1}).T}) end),"case 1106 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),np.reshape(np.array({},"int16"),{0,2,1}).T}) end),"case 1107 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),np.reshape(np.array({},"int16"),{0,2,1}).T}) end),"case 1108 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),np.reshape(np.array({},"int16"),{0,2,1}).T}) end),"case 1109 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),1),np.flip(np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),1)}),{2,4,2},"int16",{{{7,-7},{-4,-1},{7,-7},{-4,-1}},{{-5,-2},{1,4},{-5,-2},{1,4}}})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),1),np.flip(np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),1)}),{4,2,2},"int16",{{{7,-7},{-4,-1}},{{-5,-2},{1,4}},{{7,-7},{-4,-1}},{{-5,-2},{1,4}}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),1),np.flip(np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),1)}),{2,2,4},"int16",{{{7,-7,7,-7},{-4,-1,-4,-1}},{{-5,-2,-5,-2},{1,4,1,4}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),1),np.flip(np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),1)}),{2,4,2},"int16",{{{7,-7},{-4,-1},{7,-7},{-4,-1}},{{-5,-2},{1,4},{-5,-2},{1,4}}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),1),np.flip(np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),1)}),{4,2,2},"int16",{{{7,-7},{-4,-1}},{{-5,-2},{1,4}},{{7,-7},{-4,-1}},{{-5,-2},{1,4}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),1),np.flip(np.reshape(np.array({-8,-5},"int16"),{2}),1)}) end),"case 1115 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),1),np.flip(np.reshape(np.array({-8,-5},"int16"),{2}),1)}) end),"case 1116 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),1),np.flip(np.reshape(np.array({-8,-5},"int16"),{2}),1)}) end),"case 1117 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),1),np.flip(np.reshape(np.array({-8,-5},"int16"),{2}),1)}) end),"case 1118 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),1),np.flip(np.reshape(np.array({-8,-5},"int16"),{2}),1)}) end),"case 1119 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),1),np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3})}) end),"case 1120 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),1),np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3})}) end),"case 1121 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),1),np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3})}) end),"case 1122 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),1),np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3})}) end),"case 1123 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}),1),np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3})}) end),"case 1124 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}).T,np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}).T}),{2,4,2},"int16",{{{-5,7},{1,-4},{-5,7},{1,-4}},{{-2,-7},{4,-1},{-2,-7},{4,-1}}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}).T,np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}).T}),{4,2,2},"int16",{{{-5,7},{1,-4}},{{-2,-7},{4,-1}},{{-5,7},{1,-4}},{{-2,-7},{4,-1}}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}).T,np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}).T}),{2,2,4},"int16",{{{-5,7,-5,7},{1,-4,1,-4}},{{-2,-7,-2,-7},{4,-1,4,-1}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}).T,np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}).T}),{2,4,2},"int16",{{{-5,7},{1,-4},{-5,7},{1,-4}},{{-2,-7},{4,-1},{-2,-7},{4,-1}}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}).T,np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}).T}),{4,2,2},"int16",{{{-5,7},{1,-4}},{{-2,-7},{4,-1}},{{-5,7},{1,-4}},{{-2,-7},{4,-1}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}).T,np.reshape(np.array({-6,-3,0},"int16"),{3})}) end),"case 1130 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}).T,np.reshape(np.array({-6,-3,0},"int16"),{3})}) end),"case 1131 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}).T,np.reshape(np.array({-6,-3,0},"int16"),{3})}) end),"case 1132 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}).T,np.reshape(np.array({-6,-3,0},"int16"),{3})}) end),"case 1133 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}).T,np.reshape(np.array({-6,-3,0},"int16"),{3})}) end),"case 1134 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}).T,np.flip(np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),1)}) end),"case 1135 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}).T,np.flip(np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),1)}) end),"case 1136 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}).T,np.flip(np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),1)}) end),"case 1137 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}).T,np.flip(np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),1)}) end),"case 1138 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-5,-2,1,4,7,-7,-4,-1},"int16"),{2,2,2}).T,np.flip(np.reshape(np.array({-4,-1,2,5,8,-6},"int16"),{1,2,3}),1)}) end),"case 1139 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-0.5},"float32"),{}),np.reshape(np.array({-0.5},"float32"),{})}),{2},"float32",{-0.5,-0.5})
cases=cases+1
check(np.vstack({np.reshape(np.array({-0.5},"float32"),{}),np.reshape(np.array({-0.5},"float32"),{})}),{2,1},"float32",{{-0.5},{-0.5}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-0.5},"float32"),{}),np.reshape(np.array({-0.5},"float32"),{})}),{1,1,2},"float32",{{{-0.5,-0.5}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-0.5},"float32"),{}),np.reshape(np.array({-0.5},"float32"),{})}),{1,2},"float32",{{-0.5,-0.5}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-0.5},"float32"),{}),np.reshape(np.array({-0.5},"float32"),{})}),{2,1},"float32",{{-0.5},{-0.5}})
cases=cases+1
check(np.hstack({np.reshape(np.array({-0.5},"float32"),{}),np.flip(np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),1)}),{4},"float32",{-0.5,4.5,1.5,-1.5})
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-0.5},"float32"),{}),np.flip(np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),1)}) end),"case 1146 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-0.5},"float32"),{}),np.flip(np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),1)}) end),"case 1147 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-0.5},"float32"),{}),np.flip(np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),1)}) end),"case 1148 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-0.5},"float32"),{}),np.flip(np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),1)}) end),"case 1149 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-0.5},"float32"),{}),np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}).T}) end),"case 1150 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-0.5},"float32"),{}),np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}).T}) end),"case 1151 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-0.5},"float32"),{}),np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}).T}) end),"case 1152 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-0.5},"float32"),{}),np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}).T}) end),"case 1153 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-0.5},"float32"),{}),np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}).T}) end),"case 1154 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({},"float32"),{0}),np.reshape(np.array({},"float32"),{0})}),{0},"float32",{})
cases=cases+1
check(np.vstack({np.reshape(np.array({},"float32"),{0}),np.reshape(np.array({},"float32"),{0})}),{2,0},"float32",{{},{}})
cases=cases+1
check(np.dstack({np.reshape(np.array({},"float32"),{0}),np.reshape(np.array({},"float32"),{0})}),{1,0,2},"float32",{{}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"float32"),{0}),np.reshape(np.array({},"float32"),{0})}),{0,2},"float32",{})
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"float32"),{0}),np.reshape(np.array({},"float32"),{0})}),{2,0},"float32",{{},{}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"float32"),{0}),np.reshape(np.array({},"float32"),{0,2})}) end),"case 1160 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"float32"),{0}),np.reshape(np.array({},"float32"),{0,2})}) end),"case 1161 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"float32"),{0}),np.reshape(np.array({},"float32"),{0,2})}) end),"case 1162 expected failure")
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"float32"),{0}),np.reshape(np.array({},"float32"),{0,2})}),{0,3},"float32",{})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"float32"),{0}),np.reshape(np.array({},"float32"),{0,2})}) end),"case 1164 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"float32"),{0}),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2})}) end),"case 1165 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"float32"),{0}),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2})}) end),"case 1166 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"float32"),{0}),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2})}) end),"case 1167 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"float32"),{0}),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2})}) end),"case 1168 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"float32"),{0}),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2})}) end),"case 1169 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-5.5},"float32"),{1}),np.reshape(np.array({-5.5},"float32"),{1})}),{2},"float32",{-5.5,-5.5})
cases=cases+1
check(np.vstack({np.reshape(np.array({-5.5},"float32"),{1}),np.reshape(np.array({-5.5},"float32"),{1})}),{2,1},"float32",{{-5.5},{-5.5}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-5.5},"float32"),{1}),np.reshape(np.array({-5.5},"float32"),{1})}),{1,1,2},"float32",{{{-5.5,-5.5}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-5.5},"float32"),{1}),np.reshape(np.array({-5.5},"float32"),{1})}),{1,2},"float32",{{-5.5,-5.5}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-5.5},"float32"),{1}),np.reshape(np.array({-5.5},"float32"),{1})}),{2,1},"float32",{{-5.5},{-5.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-5.5},"float32"),{1}),np.reshape(np.array({},"float32"),{0,2}).T}) end),"case 1175 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-5.5},"float32"),{1}),np.reshape(np.array({},"float32"),{0,2}).T}) end),"case 1176 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-5.5},"float32"),{1}),np.reshape(np.array({},"float32"),{0,2}).T}) end),"case 1177 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-5.5},"float32"),{1}),np.reshape(np.array({},"float32"),{0,2}).T}) end),"case 1178 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-5.5},"float32"),{1}),np.reshape(np.array({},"float32"),{0,2}).T}) end),"case 1179 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-5.5},"float32"),{1}),np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),1)}) end),"case 1180 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-5.5},"float32"),{1}),np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),1)}) end),"case 1181 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-5.5},"float32"),{1}),np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),1)}) end),"case 1182 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-5.5},"float32"),{1}),np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),1)}) end),"case 1183 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-5.5},"float32"),{1}),np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),1)}) end),"case 1184 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-5.5},"float32"),{1}),1),np.flip(np.reshape(np.array({-5.5},"float32"),{1}),1)}),{2},"float32",{-5.5,-5.5})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-5.5},"float32"),{1}),1),np.flip(np.reshape(np.array({-5.5},"float32"),{1}),1)}),{2,1},"float32",{{-5.5},{-5.5}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({-5.5},"float32"),{1}),1),np.flip(np.reshape(np.array({-5.5},"float32"),{1}),1)}),{1,1,2},"float32",{{{-5.5,-5.5}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({-5.5},"float32"),{1}),1),np.flip(np.reshape(np.array({-5.5},"float32"),{1}),1)}),{1,2},"float32",{{-5.5,-5.5}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-5.5},"float32"),{1}),1),np.flip(np.reshape(np.array({-5.5},"float32"),{1}),1)}),{2,1},"float32",{{-5.5},{-5.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-5.5},"float32"),{1}),1),np.reshape(np.array({},"float32"),{2,0})}) end),"case 1190 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-5.5},"float32"),{1}),1),np.reshape(np.array({},"float32"),{2,0})}) end),"case 1191 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-5.5},"float32"),{1}),1),np.reshape(np.array({},"float32"),{2,0})}) end),"case 1192 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-5.5},"float32"),{1}),1),np.reshape(np.array({},"float32"),{2,0})}) end),"case 1193 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-5.5},"float32"),{1}),1),np.reshape(np.array({},"float32"),{2,0})}) end),"case 1194 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-5.5},"float32"),{1}),1),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}).T}) end),"case 1195 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-5.5},"float32"),{1}),1),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}).T}) end),"case 1196 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-5.5},"float32"),{1}),1),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}).T}) end),"case 1197 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-5.5},"float32"),{1}),1),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}).T}) end),"case 1198 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-5.5},"float32"),{1}),1),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}).T}) end),"case 1199 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-3.5,-0.5},"float32"),{2}),np.reshape(np.array({-3.5,-0.5},"float32"),{2})}),{4},"float32",{-3.5,-0.5,-3.5,-0.5})
cases=cases+1
check(np.vstack({np.reshape(np.array({-3.5,-0.5},"float32"),{2}),np.reshape(np.array({-3.5,-0.5},"float32"),{2})}),{2,2},"float32",{{-3.5,-0.5},{-3.5,-0.5}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-3.5,-0.5},"float32"),{2}),np.reshape(np.array({-3.5,-0.5},"float32"),{2})}),{1,2,2},"float32",{{{-3.5,-3.5},{-0.5,-0.5}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-3.5,-0.5},"float32"),{2}),np.reshape(np.array({-3.5,-0.5},"float32"),{2})}),{2,2},"float32",{{-3.5,-3.5},{-0.5,-0.5}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-3.5,-0.5},"float32"),{2}),np.reshape(np.array({-3.5,-0.5},"float32"),{2})}),{2,2},"float32",{{-3.5,-0.5},{-3.5,-0.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-3.5,-0.5},"float32"),{2}),np.reshape(np.array({},"float32"),{2,0}).T}) end),"case 1205 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({-3.5,-0.5},"float32"),{2}),np.reshape(np.array({},"float32"),{2,0}).T}),{1,2},"float32",{{-3.5,-0.5}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-3.5,-0.5},"float32"),{2}),np.reshape(np.array({},"float32"),{2,0}).T}) end),"case 1207 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-3.5,-0.5},"float32"),{2}),np.reshape(np.array({},"float32"),{2,0}).T}) end),"case 1208 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({-3.5,-0.5},"float32"),{2}),np.reshape(np.array({},"float32"),{2,0}).T}),{1,2},"float32",{{-3.5,-0.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-3.5,-0.5},"float32"),{2}),np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2})}) end),"case 1210 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-3.5,-0.5},"float32"),{2}),np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2})}) end),"case 1211 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-3.5,-0.5},"float32"),{2}),np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2})}) end),"case 1212 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-3.5,-0.5},"float32"),{2}),np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2})}) end),"case 1213 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-3.5,-0.5},"float32"),{2}),np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2})}) end),"case 1214 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-3.5,-0.5},"float32"),{2}),1),np.flip(np.reshape(np.array({-3.5,-0.5},"float32"),{2}),1)}),{4},"float32",{-0.5,-3.5,-0.5,-3.5})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-3.5,-0.5},"float32"),{2}),1),np.flip(np.reshape(np.array({-3.5,-0.5},"float32"),{2}),1)}),{2,2},"float32",{{-0.5,-3.5},{-0.5,-3.5}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({-3.5,-0.5},"float32"),{2}),1),np.flip(np.reshape(np.array({-3.5,-0.5},"float32"),{2}),1)}),{1,2,2},"float32",{{{-0.5,-0.5},{-3.5,-3.5}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({-3.5,-0.5},"float32"),{2}),1),np.flip(np.reshape(np.array({-3.5,-0.5},"float32"),{2}),1)}),{2,2},"float32",{{-0.5,-0.5},{-3.5,-3.5}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-3.5,-0.5},"float32"),{2}),1),np.flip(np.reshape(np.array({-3.5,-0.5},"float32"),{2}),1)}),{2,2},"float32",{{-0.5,-3.5},{-0.5,-3.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-3.5,-0.5},"float32"),{2}),1),np.reshape(np.array({-2.5,0.5},"float32"),{1,2})}) end),"case 1220 expected failure")
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-3.5,-0.5},"float32"),{2}),1),np.reshape(np.array({-2.5,0.5},"float32"),{1,2})}),{2,2},"float32",{{-0.5,-3.5},{-2.5,0.5}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({-3.5,-0.5},"float32"),{2}),1),np.reshape(np.array({-2.5,0.5},"float32"),{1,2})}),{1,2,2},"float32",{{{-0.5,-2.5},{-3.5,0.5}}})
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-3.5,-0.5},"float32"),{2}),1),np.reshape(np.array({-2.5,0.5},"float32"),{1,2})}) end),"case 1223 expected failure")
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-3.5,-0.5},"float32"),{2}),1),np.reshape(np.array({-2.5,0.5},"float32"),{1,2})}),{2,2},"float32",{{-0.5,-3.5},{-2.5,0.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-3.5,-0.5},"float32"),{2}),1),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),1)}) end),"case 1225 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-3.5,-0.5},"float32"),{2}),1),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),1)}) end),"case 1226 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-3.5,-0.5},"float32"),{2}),1),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),1)}) end),"case 1227 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-3.5,-0.5},"float32"),{2}),1),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),1)}) end),"case 1228 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-3.5,-0.5},"float32"),{2}),1),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),1)}) end),"case 1229 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3})}),{6},"float32",{-1.5,1.5,4.5,-1.5,1.5,4.5})
cases=cases+1
check(np.vstack({np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3})}),{2,3},"float32",{{-1.5,1.5,4.5},{-1.5,1.5,4.5}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3})}),{1,3,2},"float32",{{{-1.5,-1.5},{1.5,1.5},{4.5,4.5}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3})}),{3,2},"float32",{{-1.5,-1.5},{1.5,1.5},{4.5,4.5}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3})}),{2,3},"float32",{{-1.5,1.5,4.5},{-1.5,1.5,4.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),np.flip(np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),1)}) end),"case 1235 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),np.flip(np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),1)}) end),"case 1236 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),np.flip(np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),1)}) end),"case 1237 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),np.flip(np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),1)}) end),"case 1238 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),np.flip(np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),1)}) end),"case 1239 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}).T}) end),"case 1240 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}).T}) end),"case 1241 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}).T}) end),"case 1242 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}).T}) end),"case 1243 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}).T}) end),"case 1244 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),1),np.flip(np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),1)}),{6},"float32",{4.5,1.5,-1.5,4.5,1.5,-1.5})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),1),np.flip(np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),1)}),{2,3},"float32",{{4.5,1.5,-1.5},{4.5,1.5,-1.5}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),1),np.flip(np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),1)}),{1,3,2},"float32",{{{4.5,4.5},{1.5,1.5},{-1.5,-1.5}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),1),np.flip(np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),1)}),{3,2},"float32",{{4.5,4.5},{1.5,1.5},{-1.5,-1.5}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),1),np.flip(np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),1)}),{2,3},"float32",{{4.5,1.5,-1.5},{4.5,1.5,-1.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),1),np.reshape(np.array({-2.5,0.5},"float32"),{1,2}).T}) end),"case 1250 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),1),np.reshape(np.array({-2.5,0.5},"float32"),{1,2}).T}) end),"case 1251 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),1),np.reshape(np.array({-2.5,0.5},"float32"),{1,2}).T}) end),"case 1252 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),1),np.reshape(np.array({-2.5,0.5},"float32"),{1,2}).T}) end),"case 1253 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),1),np.reshape(np.array({-2.5,0.5},"float32"),{1,2}).T}) end),"case 1254 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),1),np.reshape(np.array({-0.5},"float32"),{})}),{4},"float32",{4.5,1.5,-1.5,-0.5})
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),1),np.reshape(np.array({-0.5},"float32"),{})}) end),"case 1256 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),1),np.reshape(np.array({-0.5},"float32"),{})}) end),"case 1257 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),1),np.reshape(np.array({-0.5},"float32"),{})}) end),"case 1258 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),1),np.reshape(np.array({-0.5},"float32"),{})}) end),"case 1259 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({},"float32"),{0,2}),np.reshape(np.array({},"float32"),{0,2})}),{0,4},"float32",{})
cases=cases+1
check(np.vstack({np.reshape(np.array({},"float32"),{0,2}),np.reshape(np.array({},"float32"),{0,2})}),{0,2},"float32",{})
cases=cases+1
check(np.dstack({np.reshape(np.array({},"float32"),{0,2}),np.reshape(np.array({},"float32"),{0,2})}),{0,2,2},"float32",{})
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"float32"),{0,2}),np.reshape(np.array({},"float32"),{0,2})}),{0,4},"float32",{})
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"float32"),{0,2}),np.reshape(np.array({},"float32"),{0,2})}),{0,2},"float32",{})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"float32"),{0,2}),np.reshape(np.array({-6.5,-3.5},"float32"),{2,1})}) end),"case 1265 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"float32"),{0,2}),np.reshape(np.array({-6.5,-3.5},"float32"),{2,1})}) end),"case 1266 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"float32"),{0,2}),np.reshape(np.array({-6.5,-3.5},"float32"),{2,1})}) end),"case 1267 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"float32"),{0,2}),np.reshape(np.array({-6.5,-3.5},"float32"),{2,1})}) end),"case 1268 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"float32"),{0,2}),np.reshape(np.array({-6.5,-3.5},"float32"),{2,1})}) end),"case 1269 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"float32"),{0,2}),np.reshape(np.array({},"float32"),{0})}) end),"case 1270 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"float32"),{0,2}),np.reshape(np.array({},"float32"),{0})}) end),"case 1271 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"float32"),{0,2}),np.reshape(np.array({},"float32"),{0})}) end),"case 1272 expected failure")
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"float32"),{0,2}),np.reshape(np.array({},"float32"),{0})}),{0,3},"float32",{})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"float32"),{0,2}),np.reshape(np.array({},"float32"),{0})}) end),"case 1274 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({},"float32"),{0,2}).T,np.reshape(np.array({},"float32"),{0,2}).T}),{2,0},"float32",{{},{}})
cases=cases+1
check(np.vstack({np.reshape(np.array({},"float32"),{0,2}).T,np.reshape(np.array({},"float32"),{0,2}).T}),{4,0},"float32",{{},{},{},{}})
cases=cases+1
check(np.dstack({np.reshape(np.array({},"float32"),{0,2}).T,np.reshape(np.array({},"float32"),{0,2}).T}),{2,0,2},"float32",{{},{}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"float32"),{0,2}).T,np.reshape(np.array({},"float32"),{0,2}).T}),{2,0},"float32",{{},{}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"float32"),{0,2}).T,np.reshape(np.array({},"float32"),{0,2}).T}),{4,0},"float32",{{},{},{},{}})
cases=cases+1
check(np.hstack({np.reshape(np.array({},"float32"),{0,2}).T,np.flip(np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),1)}),{2,1},"float32",{{-3.5},{-6.5}})
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"float32"),{0,2}).T,np.flip(np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),1)}) end),"case 1281 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"float32"),{0,2}).T,np.flip(np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),1)}) end),"case 1282 expected failure")
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"float32"),{0,2}).T,np.flip(np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),1)}),{2,1},"float32",{{-3.5},{-6.5}})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"float32"),{0,2}).T,np.flip(np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),1)}) end),"case 1284 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"float32"),{0,2}).T,np.reshape(np.array({-5.5},"float32"),{1})}) end),"case 1285 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"float32"),{0,2}).T,np.reshape(np.array({-5.5},"float32"),{1})}) end),"case 1286 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"float32"),{0,2}).T,np.reshape(np.array({-5.5},"float32"),{1})}) end),"case 1287 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"float32"),{0,2}).T,np.reshape(np.array({-5.5},"float32"),{1})}) end),"case 1288 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"float32"),{0,2}).T,np.reshape(np.array({-5.5},"float32"),{1})}) end),"case 1289 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({},"float32"),{2,0}),np.reshape(np.array({},"float32"),{2,0})}),{2,0},"float32",{{},{}})
cases=cases+1
check(np.vstack({np.reshape(np.array({},"float32"),{2,0}),np.reshape(np.array({},"float32"),{2,0})}),{4,0},"float32",{{},{},{},{}})
cases=cases+1
check(np.dstack({np.reshape(np.array({},"float32"),{2,0}),np.reshape(np.array({},"float32"),{2,0})}),{2,0,2},"float32",{{},{}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"float32"),{2,0}),np.reshape(np.array({},"float32"),{2,0})}),{2,0},"float32",{{},{}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"float32"),{2,0}),np.reshape(np.array({},"float32"),{2,0})}),{4,0},"float32",{{},{},{},{}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"float32"),{2,0}),np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}).T}) end),"case 1295 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"float32"),{2,0}),np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}).T}) end),"case 1296 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"float32"),{2,0}),np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}).T}) end),"case 1297 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"float32"),{2,0}),np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}).T}) end),"case 1298 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"float32"),{2,0}),np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}).T}) end),"case 1299 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"float32"),{2,0}),np.flip(np.reshape(np.array({-5.5},"float32"),{1}),1)}) end),"case 1300 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"float32"),{2,0}),np.flip(np.reshape(np.array({-5.5},"float32"),{1}),1)}) end),"case 1301 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"float32"),{2,0}),np.flip(np.reshape(np.array({-5.5},"float32"),{1}),1)}) end),"case 1302 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"float32"),{2,0}),np.flip(np.reshape(np.array({-5.5},"float32"),{1}),1)}) end),"case 1303 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"float32"),{2,0}),np.flip(np.reshape(np.array({-5.5},"float32"),{1}),1)}) end),"case 1304 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({},"float32"),{2,0}).T,np.reshape(np.array({},"float32"),{2,0}).T}),{0,4},"float32",{})
cases=cases+1
check(np.vstack({np.reshape(np.array({},"float32"),{2,0}).T,np.reshape(np.array({},"float32"),{2,0}).T}),{0,2},"float32",{})
cases=cases+1
check(np.dstack({np.reshape(np.array({},"float32"),{2,0}).T,np.reshape(np.array({},"float32"),{2,0}).T}),{0,2,2},"float32",{})
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"float32"),{2,0}).T,np.reshape(np.array({},"float32"),{2,0}).T}),{0,4},"float32",{})
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"float32"),{2,0}).T,np.reshape(np.array({},"float32"),{2,0}).T}),{0,2},"float32",{})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"float32"),{2,0}).T,np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2})}) end),"case 1310 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({},"float32"),{2,0}).T,np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2})}),{2,2},"float32",{{-3.5,-0.5},{2.5,5.5}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"float32"),{2,0}).T,np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2})}) end),"case 1312 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"float32"),{2,0}).T,np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2})}) end),"case 1313 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"float32"),{2,0}).T,np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2})}),{2,2},"float32",{{-3.5,-0.5},{2.5,5.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"float32"),{2,0}).T,np.reshape(np.array({-3.5,-0.5},"float32"),{2})}) end),"case 1315 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({},"float32"),{2,0}).T,np.reshape(np.array({-3.5,-0.5},"float32"),{2})}),{1,2},"float32",{{-3.5,-0.5}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"float32"),{2,0}).T,np.reshape(np.array({-3.5,-0.5},"float32"),{2})}) end),"case 1317 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"float32"),{2,0}).T,np.reshape(np.array({-3.5,-0.5},"float32"),{2})}) end),"case 1318 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"float32"),{2,0}).T,np.reshape(np.array({-3.5,-0.5},"float32"),{2})}),{1,2},"float32",{{-3.5,-0.5}})
cases=cases+1
check(np.hstack({np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),np.reshape(np.array({-2.5,0.5},"float32"),{1,2})}),{1,4},"float32",{{-2.5,0.5,-2.5,0.5}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),np.reshape(np.array({-2.5,0.5},"float32"),{1,2})}),{2,2},"float32",{{-2.5,0.5},{-2.5,0.5}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),np.reshape(np.array({-2.5,0.5},"float32"),{1,2})}),{1,2,2},"float32",{{{-2.5,-2.5},{0.5,0.5}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),np.reshape(np.array({-2.5,0.5},"float32"),{1,2})}),{1,4},"float32",{{-2.5,0.5,-2.5,0.5}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),np.reshape(np.array({-2.5,0.5},"float32"),{1,2})}),{2,2},"float32",{{-2.5,0.5},{-2.5,0.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),1)}) end),"case 1325 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),1)}),{3,2},"float32",{{-2.5,0.5},{2.5,5.5},{-3.5,-0.5}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),1)}) end),"case 1327 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),1)}) end),"case 1328 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),1)}),{3,2},"float32",{{-2.5,0.5},{2.5,5.5},{-3.5,-0.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),np.flip(np.reshape(np.array({-3.5,-0.5},"float32"),{2}),1)}) end),"case 1330 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),np.flip(np.reshape(np.array({-3.5,-0.5},"float32"),{2}),1)}),{2,2},"float32",{{-2.5,0.5},{-0.5,-3.5}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),np.flip(np.reshape(np.array({-3.5,-0.5},"float32"),{2}),1)}),{1,2,2},"float32",{{{-2.5,-0.5},{0.5,-3.5}}})
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),np.flip(np.reshape(np.array({-3.5,-0.5},"float32"),{2}),1)}) end),"case 1333 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),np.flip(np.reshape(np.array({-3.5,-0.5},"float32"),{2}),1)}),{2,2},"float32",{{-2.5,0.5},{-0.5,-3.5}})
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),1),np.flip(np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),1)}),{1,4},"float32",{{-2.5,0.5,-2.5,0.5}})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),1),np.flip(np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),1)}),{2,2},"float32",{{-2.5,0.5},{-2.5,0.5}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),1),np.flip(np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),1)}),{1,2,2},"float32",{{{-2.5,-2.5},{0.5,0.5}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),1),np.flip(np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),1)}),{1,4},"float32",{{-2.5,0.5,-2.5,0.5}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),1),np.flip(np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),1)}),{2,2},"float32",{{-2.5,0.5},{-2.5,0.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),1),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}).T}) end),"case 1340 expected failure")
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),1),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}).T}),{3,2},"float32",{{-2.5,0.5},{-3.5,2.5},{-0.5,5.5}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),1),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}).T}) end),"case 1342 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),1),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}).T}) end),"case 1343 expected failure")
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),1),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}).T}),{3,2},"float32",{{-2.5,0.5},{-3.5,2.5},{-0.5,5.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),1),np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3})}) end),"case 1345 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),1),np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3})}) end),"case 1346 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),1),np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3})}) end),"case 1347 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),1),np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3})}) end),"case 1348 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),1),np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3})}) end),"case 1349 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-2.5,0.5},"float32"),{1,2}).T,np.reshape(np.array({-2.5,0.5},"float32"),{1,2}).T}),{2,2},"float32",{{-2.5,-2.5},{0.5,0.5}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-2.5,0.5},"float32"),{1,2}).T,np.reshape(np.array({-2.5,0.5},"float32"),{1,2}).T}),{4,1},"float32",{{-2.5},{0.5},{-2.5},{0.5}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-2.5,0.5},"float32"),{1,2}).T,np.reshape(np.array({-2.5,0.5},"float32"),{1,2}).T}),{2,1,2},"float32",{{{-2.5,-2.5}},{{0.5,0.5}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-2.5,0.5},"float32"),{1,2}).T,np.reshape(np.array({-2.5,0.5},"float32"),{1,2}).T}),{2,2},"float32",{{-2.5,-2.5},{0.5,0.5}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-2.5,0.5},"float32"),{1,2}).T,np.reshape(np.array({-2.5,0.5},"float32"),{1,2}).T}),{4,1},"float32",{{-2.5},{0.5},{-2.5},{0.5}})
cases=cases+1
check(np.hstack({np.reshape(np.array({-2.5,0.5},"float32"),{1,2}).T,np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3})}),{2,4},"float32",{{-2.5,-0.5,2.5,5.5},{0.5,-4.5,-1.5,1.5}})
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-2.5,0.5},"float32"),{1,2}).T,np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3})}) end),"case 1356 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-2.5,0.5},"float32"),{1,2}).T,np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3})}) end),"case 1357 expected failure")
cases=cases+1
check(np.column_stack({np.reshape(np.array({-2.5,0.5},"float32"),{1,2}).T,np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3})}),{2,4},"float32",{{-2.5,-0.5,2.5,5.5},{0.5,-4.5,-1.5,1.5}})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-2.5,0.5},"float32"),{1,2}).T,np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3})}) end),"case 1359 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-2.5,0.5},"float32"),{1,2}).T,np.flip(np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),1)}) end),"case 1360 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-2.5,0.5},"float32"),{1,2}).T,np.flip(np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),1)}) end),"case 1361 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-2.5,0.5},"float32"),{1,2}).T,np.flip(np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),1)}) end),"case 1362 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-2.5,0.5},"float32"),{1,2}).T,np.flip(np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),1)}) end),"case 1363 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-2.5,0.5},"float32"),{1,2}).T,np.flip(np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3}),1)}) end),"case 1364 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),np.reshape(np.array({-6.5,-3.5},"float32"),{2,1})}),{2,2},"float32",{{-6.5,-6.5},{-3.5,-3.5}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),np.reshape(np.array({-6.5,-3.5},"float32"),{2,1})}),{4,1},"float32",{{-6.5},{-3.5},{-6.5},{-3.5}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),np.reshape(np.array({-6.5,-3.5},"float32"),{2,1})}),{2,1,2},"float32",{{{-6.5,-6.5}},{{-3.5,-3.5}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),np.reshape(np.array({-6.5,-3.5},"float32"),{2,1})}),{2,2},"float32",{{-6.5,-6.5},{-3.5,-3.5}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),np.reshape(np.array({-6.5,-3.5},"float32"),{2,1})}),{4,1},"float32",{{-6.5},{-3.5},{-6.5},{-3.5}})
cases=cases+1
check(np.hstack({np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),1)}),{2,4},"float32",{{-6.5,-4.5,-1.5,1.5},{-3.5,-0.5,2.5,5.5}})
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),1)}) end),"case 1371 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),1)}) end),"case 1372 expected failure")
cases=cases+1
check(np.column_stack({np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),1)}),{2,4},"float32",{{-6.5,-4.5,-1.5,1.5},{-3.5,-0.5,2.5,5.5}})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),1)}) end),"case 1374 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),np.reshape(np.array({},"float32"),{0,2})}) end),"case 1375 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),np.reshape(np.array({},"float32"),{0,2})}) end),"case 1376 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),np.reshape(np.array({},"float32"),{0,2})}) end),"case 1377 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),np.reshape(np.array({},"float32"),{0,2})}) end),"case 1378 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),np.reshape(np.array({},"float32"),{0,2})}) end),"case 1379 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),1),np.flip(np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),1)}),{2,2},"float32",{{-3.5,-3.5},{-6.5,-6.5}})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),1),np.flip(np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),1)}),{4,1},"float32",{{-3.5},{-6.5},{-3.5},{-6.5}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),1),np.flip(np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),1)}),{2,1,2},"float32",{{{-3.5,-3.5}},{{-6.5,-6.5}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),1),np.flip(np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),1)}),{2,2},"float32",{{-3.5,-3.5},{-6.5,-6.5}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),1),np.flip(np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),1)}),{4,1},"float32",{{-3.5},{-6.5},{-3.5},{-6.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),1),np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}).T}) end),"case 1385 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),1),np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}).T}) end),"case 1386 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),1),np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}).T}) end),"case 1387 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),1),np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}).T}) end),"case 1388 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),1),np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}).T}) end),"case 1389 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),1),np.reshape(np.array({},"float32"),{0,2}).T}),{2,1},"float32",{{-3.5},{-6.5}})
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),1),np.reshape(np.array({},"float32"),{0,2}).T}) end),"case 1391 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),1),np.reshape(np.array({},"float32"),{0,2}).T}) end),"case 1392 expected failure")
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),1),np.reshape(np.array({},"float32"),{0,2}).T}),{2,1},"float32",{{-3.5},{-6.5}})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),1),np.reshape(np.array({},"float32"),{0,2}).T}) end),"case 1394 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}).T,np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}).T}),{1,4},"float32",{{-6.5,-3.5,-6.5,-3.5}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}).T,np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}).T}),{2,2},"float32",{{-6.5,-3.5},{-6.5,-3.5}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}).T,np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}).T}),{1,2,2},"float32",{{{-6.5,-6.5},{-3.5,-3.5}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}).T,np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}).T}),{1,4},"float32",{{-6.5,-3.5,-6.5,-3.5}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}).T,np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}).T}),{2,2},"float32",{{-6.5,-3.5},{-6.5,-3.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}).T,np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2})}) end),"case 1400 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}).T,np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2})}),{4,2},"float32",{{-6.5,-3.5},{-4.5,-1.5},{1.5,4.5},{-5.5,-2.5}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}).T,np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2})}) end),"case 1402 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}).T,np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2})}) end),"case 1403 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}).T,np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2})}),{4,2},"float32",{{-6.5,-3.5},{-4.5,-1.5},{1.5,4.5},{-5.5,-2.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}).T,np.reshape(np.array({},"float32"),{2,0})}) end),"case 1405 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}).T,np.reshape(np.array({},"float32"),{2,0})}) end),"case 1406 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}).T,np.reshape(np.array({},"float32"),{2,0})}) end),"case 1407 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}).T,np.reshape(np.array({},"float32"),{2,0})}) end),"case 1408 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}).T,np.reshape(np.array({},"float32"),{2,0})}) end),"case 1409 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2})}),{2,4},"float32",{{-3.5,-0.5,-3.5,-0.5},{2.5,5.5,2.5,5.5}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2})}),{4,2},"float32",{{-3.5,-0.5},{2.5,5.5},{-3.5,-0.5},{2.5,5.5}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2})}),{2,2,2},"float32",{{{-3.5,-3.5},{-0.5,-0.5}},{{2.5,2.5},{5.5,5.5}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2})}),{2,4},"float32",{{-3.5,-0.5,-3.5,-0.5},{2.5,5.5,2.5,5.5}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2})}),{4,2},"float32",{{-3.5,-0.5},{2.5,5.5},{-3.5,-0.5},{2.5,5.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),1)}) end),"case 1415 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),1)}),{5,2},"float32",{{-3.5,-0.5},{2.5,5.5},{-5.5,-2.5},{1.5,4.5},{-4.5,-1.5}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),1)}) end),"case 1417 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),1)}) end),"case 1418 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),1)}),{5,2},"float32",{{-3.5,-0.5},{2.5,5.5},{-5.5,-2.5},{1.5,4.5},{-4.5,-1.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),np.reshape(np.array({},"float32"),{2,0}).T}) end),"case 1420 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),np.reshape(np.array({},"float32"),{2,0}).T}),{2,2},"float32",{{-3.5,-0.5},{2.5,5.5}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),np.reshape(np.array({},"float32"),{2,0}).T}) end),"case 1422 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),np.reshape(np.array({},"float32"),{2,0}).T}) end),"case 1423 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),np.reshape(np.array({},"float32"),{2,0}).T}),{2,2},"float32",{{-3.5,-0.5},{2.5,5.5}})
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),1),np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),1)}),{2,4},"float32",{{2.5,5.5,2.5,5.5},{-3.5,-0.5,-3.5,-0.5}})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),1),np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),1)}),{4,2},"float32",{{2.5,5.5},{-3.5,-0.5},{2.5,5.5},{-3.5,-0.5}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),1),np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),1)}),{2,2,2},"float32",{{{2.5,2.5},{5.5,5.5}},{{-3.5,-3.5},{-0.5,-0.5}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),1),np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),1)}),{2,4},"float32",{{2.5,5.5,2.5,5.5},{-3.5,-0.5,-3.5,-0.5}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),1),np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),1)}),{4,2},"float32",{{2.5,5.5},{-3.5,-0.5},{2.5,5.5},{-3.5,-0.5}})
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),1),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}).T}),{2,5},"float32",{{2.5,5.5,-4.5,1.5,-5.5},{-3.5,-0.5,-1.5,4.5,-2.5}})
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),1),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}).T}) end),"case 1431 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),1),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}).T}) end),"case 1432 expected failure")
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),1),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}).T}),{2,5},"float32",{{2.5,5.5,-4.5,1.5,-5.5},{-3.5,-0.5,-1.5,4.5,-2.5}})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),1),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}).T}) end),"case 1434 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),1),np.reshape(np.array({-2.5,0.5},"float32"),{1,2})}) end),"case 1435 expected failure")
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),1),np.reshape(np.array({-2.5,0.5},"float32"),{1,2})}),{3,2},"float32",{{2.5,5.5},{-3.5,-0.5},{-2.5,0.5}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),1),np.reshape(np.array({-2.5,0.5},"float32"),{1,2})}) end),"case 1437 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),1),np.reshape(np.array({-2.5,0.5},"float32"),{1,2})}) end),"case 1438 expected failure")
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),1),np.reshape(np.array({-2.5,0.5},"float32"),{1,2})}),{3,2},"float32",{{2.5,5.5},{-3.5,-0.5},{-2.5,0.5}})
cases=cases+1
check(np.hstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}).T,np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}).T}),{2,4},"float32",{{-3.5,2.5,-3.5,2.5},{-0.5,5.5,-0.5,5.5}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}).T,np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}).T}),{4,2},"float32",{{-3.5,2.5},{-0.5,5.5},{-3.5,2.5},{-0.5,5.5}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}).T,np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}).T}),{2,2,2},"float32",{{{-3.5,-3.5},{2.5,2.5}},{{-0.5,-0.5},{5.5,5.5}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}).T,np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}).T}),{2,4},"float32",{{-3.5,2.5,-3.5,2.5},{-0.5,5.5,-0.5,5.5}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}).T,np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}).T}),{4,2},"float32",{{-3.5,2.5},{-0.5,5.5},{-3.5,2.5},{-0.5,5.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}).T,np.reshape(np.array({},"float32"),{0,2,1})}) end),"case 1445 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}).T,np.reshape(np.array({},"float32"),{0,2,1})}) end),"case 1446 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}).T,np.reshape(np.array({},"float32"),{0,2,1})}) end),"case 1447 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}).T,np.reshape(np.array({},"float32"),{0,2,1})}) end),"case 1448 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}).T,np.reshape(np.array({},"float32"),{0,2,1})}) end),"case 1449 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}).T,np.flip(np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),1)}) end),"case 1450 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}).T,np.flip(np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),1)}),{3,2},"float32",{{-3.5,2.5},{-0.5,5.5},{-2.5,0.5}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}).T,np.flip(np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),1)}) end),"case 1452 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}).T,np.flip(np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),1)}) end),"case 1453 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}).T,np.flip(np.reshape(np.array({-2.5,0.5},"float32"),{1,2}),1)}),{3,2},"float32",{{-3.5,2.5},{-0.5,5.5},{-2.5,0.5}})
cases=cases+1
check(np.hstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3})}),{2,6},"float32",{{-0.5,2.5,5.5,-0.5,2.5,5.5},{-4.5,-1.5,1.5,-4.5,-1.5,1.5}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3})}),{4,3},"float32",{{-0.5,2.5,5.5},{-4.5,-1.5,1.5},{-0.5,2.5,5.5},{-4.5,-1.5,1.5}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3})}),{2,3,2},"float32",{{{-0.5,-0.5},{2.5,2.5},{5.5,5.5}},{{-4.5,-4.5},{-1.5,-1.5},{1.5,1.5}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3})}),{2,6},"float32",{{-0.5,2.5,5.5,-0.5,2.5,5.5},{-4.5,-1.5,1.5,-4.5,-1.5,1.5}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3})}),{4,3},"float32",{{-0.5,2.5,5.5},{-4.5,-1.5,1.5},{-0.5,2.5,5.5},{-4.5,-1.5,1.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),np.reshape(np.array({},"float32"),{0,2,1}).T}) end),"case 1460 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),np.reshape(np.array({},"float32"),{0,2,1}).T}) end),"case 1461 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),np.reshape(np.array({},"float32"),{0,2,1}).T}) end),"case 1462 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),np.reshape(np.array({},"float32"),{0,2,1}).T}) end),"case 1463 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),np.reshape(np.array({},"float32"),{0,2,1}).T}) end),"case 1464 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),np.reshape(np.array({-2.5,0.5},"float32"),{1,2}).T}),{2,4},"float32",{{-0.5,2.5,5.5,-2.5},{-4.5,-1.5,1.5,0.5}})
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),np.reshape(np.array({-2.5,0.5},"float32"),{1,2}).T}) end),"case 1466 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),np.reshape(np.array({-2.5,0.5},"float32"),{1,2}).T}) end),"case 1467 expected failure")
cases=cases+1
check(np.column_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),np.reshape(np.array({-2.5,0.5},"float32"),{1,2}).T}),{2,4},"float32",{{-0.5,2.5,5.5,-2.5},{-4.5,-1.5,1.5,0.5}})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),np.reshape(np.array({-2.5,0.5},"float32"),{1,2}).T}) end),"case 1469 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),1),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),1)}),{2,6},"float32",{{-4.5,-1.5,1.5,-4.5,-1.5,1.5},{-0.5,2.5,5.5,-0.5,2.5,5.5}})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),1),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),1)}),{4,3},"float32",{{-4.5,-1.5,1.5},{-0.5,2.5,5.5},{-4.5,-1.5,1.5},{-0.5,2.5,5.5}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),1),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),1)}),{2,3,2},"float32",{{{-4.5,-4.5},{-1.5,-1.5},{1.5,1.5}},{{-0.5,-0.5},{2.5,2.5},{5.5,5.5}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),1),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),1)}),{2,6},"float32",{{-4.5,-1.5,1.5,-4.5,-1.5,1.5},{-0.5,2.5,5.5,-0.5,2.5,5.5}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),1),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),1)}),{4,3},"float32",{{-4.5,-1.5,1.5},{-0.5,2.5,5.5},{-4.5,-1.5,1.5},{-0.5,2.5,5.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),1),np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3})}) end),"case 1475 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),1),np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3})}) end),"case 1476 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),1),np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3})}) end),"case 1477 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),1),np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3})}) end),"case 1478 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),1),np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3})}) end),"case 1479 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),1),np.reshape(np.array({-6.5,-3.5},"float32"),{2,1})}),{2,4},"float32",{{-4.5,-1.5,1.5,-6.5},{-0.5,2.5,5.5,-3.5}})
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),1),np.reshape(np.array({-6.5,-3.5},"float32"),{2,1})}) end),"case 1481 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),1),np.reshape(np.array({-6.5,-3.5},"float32"),{2,1})}) end),"case 1482 expected failure")
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),1),np.reshape(np.array({-6.5,-3.5},"float32"),{2,1})}),{2,4},"float32",{{-4.5,-1.5,1.5,-6.5},{-0.5,2.5,5.5,-3.5}})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),1),np.reshape(np.array({-6.5,-3.5},"float32"),{2,1})}) end),"case 1484 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}).T,np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}).T}),{3,4},"float32",{{-0.5,-4.5,-0.5,-4.5},{2.5,-1.5,2.5,-1.5},{5.5,1.5,5.5,1.5}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}).T,np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}).T}),{6,2},"float32",{{-0.5,-4.5},{2.5,-1.5},{5.5,1.5},{-0.5,-4.5},{2.5,-1.5},{5.5,1.5}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}).T,np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}).T}),{3,2,2},"float32",{{{-0.5,-0.5},{-4.5,-4.5}},{{2.5,2.5},{-1.5,-1.5}},{{5.5,5.5},{1.5,1.5}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}).T,np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}).T}),{3,4},"float32",{{-0.5,-4.5,-0.5,-4.5},{2.5,-1.5,2.5,-1.5},{5.5,1.5,5.5,1.5}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}).T,np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}).T}),{6,2},"float32",{{-0.5,-4.5},{2.5,-1.5},{5.5,1.5},{-0.5,-4.5},{2.5,-1.5},{5.5,1.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}).T,np.flip(np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),1)}) end),"case 1490 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}).T,np.flip(np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),1)}) end),"case 1491 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}).T,np.flip(np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),1)}) end),"case 1492 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}).T,np.flip(np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),1)}) end),"case 1493 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}).T,np.flip(np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),1)}) end),"case 1494 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}).T,np.flip(np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),1)}) end),"case 1495 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}).T,np.flip(np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),1)}) end),"case 1496 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}).T,np.flip(np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),1)}) end),"case 1497 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}).T,np.flip(np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),1)}) end),"case 1498 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}).T,np.flip(np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}),1)}) end),"case 1499 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2})}),{3,4},"float32",{{-4.5,-1.5,-4.5,-1.5},{1.5,4.5,1.5,4.5},{-5.5,-2.5,-5.5,-2.5}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2})}),{6,2},"float32",{{-4.5,-1.5},{1.5,4.5},{-5.5,-2.5},{-4.5,-1.5},{1.5,4.5},{-5.5,-2.5}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2})}),{3,2,2},"float32",{{{-4.5,-4.5},{-1.5,-1.5}},{{1.5,1.5},{4.5,4.5}},{{-5.5,-5.5},{-2.5,-2.5}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2})}),{3,4},"float32",{{-4.5,-1.5,-4.5,-1.5},{1.5,4.5,1.5,4.5},{-5.5,-2.5,-5.5,-2.5}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2})}),{6,2},"float32",{{-4.5,-1.5},{1.5,4.5},{-5.5,-2.5},{-4.5,-1.5},{1.5,4.5},{-5.5,-2.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}).T}) end),"case 1505 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}).T}) end),"case 1506 expected failure")
cases=cases+1
check(np.dstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}).T}),{3,2,2},"float32",{{{-4.5,-6.5},{-1.5,2.5}},{{1.5,-3.5},{4.5,5.5}},{{-5.5,-0.5},{-2.5,-4.5}}})
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}).T}) end),"case 1508 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}).T}) end),"case 1509 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}).T}) end),"case 1510 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}).T}),{4,2},"float32",{{-4.5,-1.5},{1.5,4.5},{-5.5,-2.5},{-6.5,-3.5}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}).T}) end),"case 1512 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}).T}) end),"case 1513 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),np.reshape(np.array({-6.5,-3.5},"float32"),{2,1}).T}),{4,2},"float32",{{-4.5,-1.5},{1.5,4.5},{-5.5,-2.5},{-6.5,-3.5}})
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),1),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),1)}),{3,4},"float32",{{-5.5,-2.5,-5.5,-2.5},{1.5,4.5,1.5,4.5},{-4.5,-1.5,-4.5,-1.5}})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),1),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),1)}),{6,2},"float32",{{-5.5,-2.5},{1.5,4.5},{-4.5,-1.5},{-5.5,-2.5},{1.5,4.5},{-4.5,-1.5}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),1),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),1)}),{3,2,2},"float32",{{{-5.5,-5.5},{-2.5,-2.5}},{{1.5,1.5},{4.5,4.5}},{{-4.5,-4.5},{-1.5,-1.5}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),1),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),1)}),{3,4},"float32",{{-5.5,-2.5,-5.5,-2.5},{1.5,4.5,1.5,4.5},{-4.5,-1.5,-4.5,-1.5}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),1),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),1)}),{6,2},"float32",{{-5.5,-2.5},{1.5,4.5},{-4.5,-1.5},{-5.5,-2.5},{1.5,4.5},{-4.5,-1.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),1),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2})}) end),"case 1520 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),1),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2})}) end),"case 1521 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),1),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2})}) end),"case 1522 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),1),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2})}) end),"case 1523 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),1),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2})}) end),"case 1524 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),1),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2})}) end),"case 1525 expected failure")
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),1),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2})}),{5,2},"float32",{{-5.5,-2.5},{1.5,4.5},{-4.5,-1.5},{-3.5,-0.5},{2.5,5.5}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),1),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2})}) end),"case 1527 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),1),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2})}) end),"case 1528 expected failure")
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),1),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2})}),{5,2},"float32",{{-5.5,-2.5},{1.5,4.5},{-4.5,-1.5},{-3.5,-0.5},{2.5,5.5}})
cases=cases+1
check(np.hstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}).T,np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}).T}),{2,6},"float32",{{-4.5,1.5,-5.5,-4.5,1.5,-5.5},{-1.5,4.5,-2.5,-1.5,4.5,-2.5}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}).T,np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}).T}),{4,3},"float32",{{-4.5,1.5,-5.5},{-1.5,4.5,-2.5},{-4.5,1.5,-5.5},{-1.5,4.5,-2.5}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}).T,np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}).T}),{2,3,2},"float32",{{{-4.5,-4.5},{1.5,1.5},{-5.5,-5.5}},{{-1.5,-1.5},{4.5,4.5},{-2.5,-2.5}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}).T,np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}).T}),{2,6},"float32",{{-4.5,1.5,-5.5,-4.5,1.5,-5.5},{-1.5,4.5,-2.5,-1.5,4.5,-2.5}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}).T,np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}).T}),{4,3},"float32",{{-4.5,1.5,-5.5},{-1.5,4.5,-2.5},{-4.5,1.5,-5.5},{-1.5,4.5,-2.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}).T,np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),1)}) end),"case 1535 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}).T,np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),1)}) end),"case 1536 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}).T,np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),1)}) end),"case 1537 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}).T,np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),1)}) end),"case 1538 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}).T,np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),1)}) end),"case 1539 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}).T,np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),1)}),{2,5},"float32",{{-4.5,1.5,-5.5,2.5,5.5},{-1.5,4.5,-2.5,-3.5,-0.5}})
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}).T,np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),1)}) end),"case 1541 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}).T,np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),1)}) end),"case 1542 expected failure")
cases=cases+1
check(np.column_stack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}).T,np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),1)}),{2,5},"float32",{{-4.5,1.5,-5.5,2.5,5.5},{-1.5,4.5,-2.5,-3.5,-0.5}})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}).T,np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}),1)}) end),"case 1544 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({},"float32"),{0,2,1}),np.reshape(np.array({},"float32"),{0,2,1})}),{0,4,1},"float32",{})
cases=cases+1
check(np.vstack({np.reshape(np.array({},"float32"),{0,2,1}),np.reshape(np.array({},"float32"),{0,2,1})}),{0,2,1},"float32",{})
cases=cases+1
check(np.dstack({np.reshape(np.array({},"float32"),{0,2,1}),np.reshape(np.array({},"float32"),{0,2,1})}),{0,2,2},"float32",{})
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"float32"),{0,2,1}),np.reshape(np.array({},"float32"),{0,2,1})}),{0,4,1},"float32",{})
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"float32"),{0,2,1}),np.reshape(np.array({},"float32"),{0,2,1})}),{0,2,1},"float32",{})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"float32"),{0,2,1}),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}).T}) end),"case 1550 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"float32"),{0,2,1}),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}).T}) end),"case 1551 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"float32"),{0,2,1}),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}).T}) end),"case 1552 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"float32"),{0,2,1}),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}).T}) end),"case 1553 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"float32"),{0,2,1}),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}).T}) end),"case 1554 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"float32"),{0,2,1}),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}).T}) end),"case 1555 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"float32"),{0,2,1}),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}).T}) end),"case 1556 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"float32"),{0,2,1}),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}).T}) end),"case 1557 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"float32"),{0,2,1}),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}).T}) end),"case 1558 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"float32"),{0,2,1}),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,2}).T}) end),"case 1559 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({},"float32"),{0,2,1}).T,np.reshape(np.array({},"float32"),{0,2,1}).T}),{1,4,0},"float32",{{{},{},{},{}}})
cases=cases+1
check(np.vstack({np.reshape(np.array({},"float32"),{0,2,1}).T,np.reshape(np.array({},"float32"),{0,2,1}).T}),{2,2,0},"float32",{{{},{}},{{},{}}})
cases=cases+1
check(np.dstack({np.reshape(np.array({},"float32"),{0,2,1}).T,np.reshape(np.array({},"float32"),{0,2,1}).T}),{1,2,0},"float32",{{{},{}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"float32"),{0,2,1}).T,np.reshape(np.array({},"float32"),{0,2,1}).T}),{1,4,0},"float32",{{{},{},{},{}}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"float32"),{0,2,1}).T,np.reshape(np.array({},"float32"),{0,2,1}).T}),{2,2,0},"float32",{{{},{}},{{},{}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"float32"),{0,2,1}).T,np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2})}) end),"case 1565 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"float32"),{0,2,1}).T,np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2})}) end),"case 1566 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"float32"),{0,2,1}).T,np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2})}) end),"case 1567 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"float32"),{0,2,1}).T,np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2})}) end),"case 1568 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"float32"),{0,2,1}).T,np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2})}) end),"case 1569 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"float32"),{0,2,1}).T,np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3})}) end),"case 1570 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"float32"),{0,2,1}).T,np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3})}) end),"case 1571 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"float32"),{0,2,1}).T,np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3})}) end),"case 1572 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"float32"),{0,2,1}).T,np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3})}) end),"case 1573 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"float32"),{0,2,1}).T,np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3})}) end),"case 1574 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3})}),{1,4,3},"float32",{{{-6.5,-3.5,-0.5},{2.5,5.5,-4.5},{-6.5,-3.5,-0.5},{2.5,5.5,-4.5}}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3})}),{2,2,3},"float32",{{{-6.5,-3.5,-0.5},{2.5,5.5,-4.5}},{{-6.5,-3.5,-0.5},{2.5,5.5,-4.5}}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3})}),{1,2,6},"float32",{{{-6.5,-3.5,-0.5,-6.5,-3.5,-0.5},{2.5,5.5,-4.5,2.5,5.5,-4.5}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3})}),{1,4,3},"float32",{{{-6.5,-3.5,-0.5},{2.5,5.5,-4.5},{-6.5,-3.5,-0.5},{2.5,5.5,-4.5}}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3})}),{2,2,3},"float32",{{{-6.5,-3.5,-0.5},{2.5,5.5,-4.5}},{{-6.5,-3.5,-0.5},{2.5,5.5,-4.5}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),1)}) end),"case 1580 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),1)}) end),"case 1581 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),1)}) end),"case 1582 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),1)}) end),"case 1583 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),1)}) end),"case 1584 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),1)}) end),"case 1585 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),1)}) end),"case 1586 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),1)}) end),"case 1587 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),1)}) end),"case 1588 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}),1)}) end),"case 1589 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),1),np.flip(np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),1)}),{1,4,3},"float32",{{{-6.5,-3.5,-0.5},{2.5,5.5,-4.5},{-6.5,-3.5,-0.5},{2.5,5.5,-4.5}}})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),1),np.flip(np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),1)}),{2,2,3},"float32",{{{-6.5,-3.5,-0.5},{2.5,5.5,-4.5}},{{-6.5,-3.5,-0.5},{2.5,5.5,-4.5}}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),1),np.flip(np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),1)}),{1,2,6},"float32",{{{-6.5,-3.5,-0.5,-6.5,-3.5,-0.5},{2.5,5.5,-4.5,2.5,5.5,-4.5}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),1),np.flip(np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),1)}),{1,4,3},"float32",{{{-6.5,-3.5,-0.5},{2.5,5.5,-4.5},{-6.5,-3.5,-0.5},{2.5,5.5,-4.5}}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),1),np.flip(np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),1)}),{2,2,3},"float32",{{{-6.5,-3.5,-0.5},{2.5,5.5,-4.5}},{{-6.5,-3.5,-0.5},{2.5,5.5,-4.5}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),1),np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}).T}) end),"case 1595 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),1),np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}).T}) end),"case 1596 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),1),np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}).T}) end),"case 1597 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),1),np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}).T}) end),"case 1598 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),1),np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}).T}) end),"case 1599 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),1),np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}).T}) end),"case 1600 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),1),np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}).T}) end),"case 1601 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),1),np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}).T}) end),"case 1602 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),1),np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}).T}) end),"case 1603 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),1),np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5},"float32"),{2,3}).T}) end),"case 1604 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}).T,np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}).T}),{3,4,1},"float32",{{{-6.5},{2.5},{-6.5},{2.5}},{{-3.5},{5.5},{-3.5},{5.5}},{{-0.5},{-4.5},{-0.5},{-4.5}}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}).T,np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}).T}),{6,2,1},"float32",{{{-6.5},{2.5}},{{-3.5},{5.5}},{{-0.5},{-4.5}},{{-6.5},{2.5}},{{-3.5},{5.5}},{{-0.5},{-4.5}}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}).T,np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}).T}),{3,2,2},"float32",{{{-6.5,-6.5},{2.5,2.5}},{{-3.5,-3.5},{5.5,5.5}},{{-0.5,-0.5},{-4.5,-4.5}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}).T,np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}).T}),{3,4,1},"float32",{{{-6.5},{2.5},{-6.5},{2.5}},{{-3.5},{5.5},{-3.5},{5.5}},{{-0.5},{-4.5},{-0.5},{-4.5}}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}).T,np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}).T}),{6,2,1},"float32",{{{-6.5},{2.5}},{{-3.5},{5.5}},{{-0.5},{-4.5}},{{-6.5},{2.5}},{{-3.5},{5.5}},{{-0.5},{-4.5}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}).T,np.reshape(np.array({-0.5},"float32"),{})}) end),"case 1610 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}).T,np.reshape(np.array({-0.5},"float32"),{})}) end),"case 1611 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}).T,np.reshape(np.array({-0.5},"float32"),{})}) end),"case 1612 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}).T,np.reshape(np.array({-0.5},"float32"),{})}) end),"case 1613 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}).T,np.reshape(np.array({-0.5},"float32"),{})}) end),"case 1614 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}).T,np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2})}) end),"case 1615 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}).T,np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2})}) end),"case 1616 expected failure")
cases=cases+1
check(np.dstack({np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}).T,np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2})}),{3,2,2},"float32",{{{-6.5,-4.5},{2.5,-1.5}},{{-3.5,1.5},{5.5,4.5}},{{-0.5,-5.5},{-4.5,-2.5}}})
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}).T,np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2})}) end),"case 1618 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}).T,np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2})}) end),"case 1619 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2})}),{2,2,2},"float32",{{{-3.5,-0.5},{-3.5,-0.5}},{{2.5,5.5},{2.5,5.5}}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2})}),{4,1,2},"float32",{{{-3.5,-0.5}},{{2.5,5.5}},{{-3.5,-0.5}},{{2.5,5.5}}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2})}),{2,1,4},"float32",{{{-3.5,-0.5,-3.5,-0.5}},{{2.5,5.5,2.5,5.5}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2})}),{2,2,2},"float32",{{{-3.5,-0.5},{-3.5,-0.5}},{{2.5,5.5},{2.5,5.5}}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2})}),{4,1,2},"float32",{{{-3.5,-0.5}},{{2.5,5.5}},{{-3.5,-0.5}},{{2.5,5.5}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),np.reshape(np.array({},"float32"),{0})}) end),"case 1625 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),np.reshape(np.array({},"float32"),{0})}) end),"case 1626 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),np.reshape(np.array({},"float32"),{0})}) end),"case 1627 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),np.reshape(np.array({},"float32"),{0})}) end),"case 1628 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),np.reshape(np.array({},"float32"),{0})}) end),"case 1629 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),1)}) end),"case 1630 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),1)}) end),"case 1631 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),1)}) end),"case 1632 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),1)}) end),"case 1633 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}),1)}) end),"case 1634 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),1),np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),1)}),{2,2,2},"float32",{{{2.5,5.5},{2.5,5.5}},{{-3.5,-0.5},{-3.5,-0.5}}})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),1),np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),1)}),{4,1,2},"float32",{{{2.5,5.5}},{{-3.5,-0.5}},{{2.5,5.5}},{{-3.5,-0.5}}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),1),np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),1)}),{2,1,4},"float32",{{{2.5,5.5,2.5,5.5}},{{-3.5,-0.5,-3.5,-0.5}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),1),np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),1)}),{2,2,2},"float32",{{{2.5,5.5},{2.5,5.5}},{{-3.5,-0.5},{-3.5,-0.5}}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),1),np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),1)}),{4,1,2},"float32",{{{2.5,5.5}},{{-3.5,-0.5}},{{2.5,5.5}},{{-3.5,-0.5}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),1),np.reshape(np.array({-5.5},"float32"),{1})}) end),"case 1640 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),1),np.reshape(np.array({-5.5},"float32"),{1})}) end),"case 1641 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),1),np.reshape(np.array({-5.5},"float32"),{1})}) end),"case 1642 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),1),np.reshape(np.array({-5.5},"float32"),{1})}) end),"case 1643 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),1),np.reshape(np.array({-5.5},"float32"),{1})}) end),"case 1644 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),1),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}).T}) end),"case 1645 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),1),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}).T}) end),"case 1646 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),1),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}).T}) end),"case 1647 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),1),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}).T}) end),"case 1648 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}),1),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float32"),{3,2}).T}) end),"case 1649 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}).T,np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}).T}),{2,2,2},"float32",{{{-3.5,2.5},{-3.5,2.5}},{{-0.5,5.5},{-0.5,5.5}}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}).T,np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}).T}),{4,1,2},"float32",{{{-3.5,2.5}},{{-0.5,5.5}},{{-3.5,2.5}},{{-0.5,5.5}}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}).T,np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}).T}),{2,1,4},"float32",{{{-3.5,2.5,-3.5,2.5}},{{-0.5,5.5,-0.5,5.5}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}).T,np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}).T}),{2,2,2},"float32",{{{-3.5,2.5},{-3.5,2.5}},{{-0.5,5.5},{-0.5,5.5}}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}).T,np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}).T}),{4,1,2},"float32",{{{-3.5,2.5}},{{-0.5,5.5}},{{-3.5,2.5}},{{-0.5,5.5}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}).T,np.flip(np.reshape(np.array({-5.5},"float32"),{1}),1)}) end),"case 1655 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}).T,np.flip(np.reshape(np.array({-5.5},"float32"),{1}),1)}) end),"case 1656 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}).T,np.flip(np.reshape(np.array({-5.5},"float32"),{1}),1)}) end),"case 1657 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}).T,np.flip(np.reshape(np.array({-5.5},"float32"),{1}),1)}) end),"case 1658 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}).T,np.flip(np.reshape(np.array({-5.5},"float32"),{1}),1)}) end),"case 1659 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}).T,np.reshape(np.array({},"float32"),{0,2,1})}) end),"case 1660 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}).T,np.reshape(np.array({},"float32"),{0,2,1})}) end),"case 1661 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}).T,np.reshape(np.array({},"float32"),{0,2,1})}) end),"case 1662 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}).T,np.reshape(np.array({},"float32"),{0,2,1})}) end),"case 1663 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-3.5,-0.5,2.5,5.5},"float32"),{2,1,2}).T,np.reshape(np.array({},"float32"),{0,2,1})}) end),"case 1664 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2})}),{2,4,2},"float32",{{{-0.5,2.5},{5.5,-4.5},{-0.5,2.5},{5.5,-4.5}},{{-1.5,1.5},{4.5,-5.5},{-1.5,1.5},{4.5,-5.5}}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2})}),{4,2,2},"float32",{{{-0.5,2.5},{5.5,-4.5}},{{-1.5,1.5},{4.5,-5.5}},{{-0.5,2.5},{5.5,-4.5}},{{-1.5,1.5},{4.5,-5.5}}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2})}),{2,2,4},"float32",{{{-0.5,2.5,-0.5,2.5},{5.5,-4.5,5.5,-4.5}},{{-1.5,1.5,-1.5,1.5},{4.5,-5.5,4.5,-5.5}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2})}),{2,4,2},"float32",{{{-0.5,2.5},{5.5,-4.5},{-0.5,2.5},{5.5,-4.5}},{{-1.5,1.5},{4.5,-5.5},{-1.5,1.5},{4.5,-5.5}}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2})}),{4,2,2},"float32",{{{-0.5,2.5},{5.5,-4.5}},{{-1.5,1.5},{4.5,-5.5}},{{-0.5,2.5},{5.5,-4.5}},{{-1.5,1.5},{4.5,-5.5}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),np.reshape(np.array({-3.5,-0.5},"float32"),{2})}) end),"case 1670 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),np.reshape(np.array({-3.5,-0.5},"float32"),{2})}) end),"case 1671 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),np.reshape(np.array({-3.5,-0.5},"float32"),{2})}) end),"case 1672 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),np.reshape(np.array({-3.5,-0.5},"float32"),{2})}) end),"case 1673 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),np.reshape(np.array({-3.5,-0.5},"float32"),{2})}) end),"case 1674 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),np.reshape(np.array({},"float32"),{0,2,1}).T}) end),"case 1675 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),np.reshape(np.array({},"float32"),{0,2,1}).T}) end),"case 1676 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),np.reshape(np.array({},"float32"),{0,2,1}).T}) end),"case 1677 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),np.reshape(np.array({},"float32"),{0,2,1}).T}) end),"case 1678 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),np.reshape(np.array({},"float32"),{0,2,1}).T}) end),"case 1679 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),1),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),1)}),{2,4,2},"float32",{{{-1.5,1.5},{4.5,-5.5},{-1.5,1.5},{4.5,-5.5}},{{-0.5,2.5},{5.5,-4.5},{-0.5,2.5},{5.5,-4.5}}})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),1),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),1)}),{4,2,2},"float32",{{{-1.5,1.5},{4.5,-5.5}},{{-0.5,2.5},{5.5,-4.5}},{{-1.5,1.5},{4.5,-5.5}},{{-0.5,2.5},{5.5,-4.5}}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),1),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),1)}),{2,2,4},"float32",{{{-1.5,1.5,-1.5,1.5},{4.5,-5.5,4.5,-5.5}},{{-0.5,2.5,-0.5,2.5},{5.5,-4.5,5.5,-4.5}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),1),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),1)}),{2,4,2},"float32",{{{-1.5,1.5},{4.5,-5.5},{-1.5,1.5},{4.5,-5.5}},{{-0.5,2.5},{5.5,-4.5},{-0.5,2.5},{5.5,-4.5}}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),1),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),1)}),{4,2,2},"float32",{{{-1.5,1.5},{4.5,-5.5}},{{-0.5,2.5},{5.5,-4.5}},{{-1.5,1.5},{4.5,-5.5}},{{-0.5,2.5},{5.5,-4.5}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),1),np.flip(np.reshape(np.array({-3.5,-0.5},"float32"),{2}),1)}) end),"case 1685 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),1),np.flip(np.reshape(np.array({-3.5,-0.5},"float32"),{2}),1)}) end),"case 1686 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),1),np.flip(np.reshape(np.array({-3.5,-0.5},"float32"),{2}),1)}) end),"case 1687 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),1),np.flip(np.reshape(np.array({-3.5,-0.5},"float32"),{2}),1)}) end),"case 1688 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),1),np.flip(np.reshape(np.array({-3.5,-0.5},"float32"),{2}),1)}) end),"case 1689 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),1),np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3})}) end),"case 1690 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),1),np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3})}) end),"case 1691 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),1),np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3})}) end),"case 1692 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),1),np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3})}) end),"case 1693 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}),1),np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3})}) end),"case 1694 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}).T,np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}).T}),{2,4,2},"float32",{{{-0.5,-1.5},{5.5,4.5},{-0.5,-1.5},{5.5,4.5}},{{2.5,1.5},{-4.5,-5.5},{2.5,1.5},{-4.5,-5.5}}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}).T,np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}).T}),{4,2,2},"float32",{{{-0.5,-1.5},{5.5,4.5}},{{2.5,1.5},{-4.5,-5.5}},{{-0.5,-1.5},{5.5,4.5}},{{2.5,1.5},{-4.5,-5.5}}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}).T,np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}).T}),{2,2,4},"float32",{{{-0.5,-1.5,-0.5,-1.5},{5.5,4.5,5.5,4.5}},{{2.5,1.5,2.5,1.5},{-4.5,-5.5,-4.5,-5.5}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}).T,np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}).T}),{2,4,2},"float32",{{{-0.5,-1.5},{5.5,4.5},{-0.5,-1.5},{5.5,4.5}},{{2.5,1.5},{-4.5,-5.5},{2.5,1.5},{-4.5,-5.5}}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}).T,np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}).T}),{4,2,2},"float32",{{{-0.5,-1.5},{5.5,4.5}},{{2.5,1.5},{-4.5,-5.5}},{{-0.5,-1.5},{5.5,4.5}},{{2.5,1.5},{-4.5,-5.5}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}).T,np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3})}) end),"case 1700 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}).T,np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3})}) end),"case 1701 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}).T,np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3})}) end),"case 1702 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}).T,np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3})}) end),"case 1703 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}).T,np.reshape(np.array({-1.5,1.5,4.5},"float32"),{3})}) end),"case 1704 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}).T,np.flip(np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),1)}) end),"case 1705 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}).T,np.flip(np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),1)}) end),"case 1706 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}).T,np.flip(np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),1)}) end),"case 1707 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}).T,np.flip(np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),1)}) end),"case 1708 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5,-1.5,1.5,4.5,-5.5},"float32"),{2,2,2}).T,np.flip(np.reshape(np.array({-6.5,-3.5,-0.5,2.5,5.5,-4.5},"float32"),{1,2,3}),1)}) end),"case 1709 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-4.5},"float64"),{}),np.reshape(np.array({-4.5},"float64"),{})}),{2},"float64",{-4.5,-4.5})
cases=cases+1
check(np.vstack({np.reshape(np.array({-4.5},"float64"),{}),np.reshape(np.array({-4.5},"float64"),{})}),{2,1},"float64",{{-4.5},{-4.5}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-4.5},"float64"),{}),np.reshape(np.array({-4.5},"float64"),{})}),{1,1,2},"float64",{{{-4.5,-4.5}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-4.5},"float64"),{}),np.reshape(np.array({-4.5},"float64"),{})}),{1,2},"float64",{{-4.5,-4.5}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-4.5},"float64"),{}),np.reshape(np.array({-4.5},"float64"),{})}),{2,1},"float64",{{-4.5},{-4.5}})
cases=cases+1
check(np.hstack({np.reshape(np.array({-4.5},"float64"),{}),np.flip(np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),1)}),{4},"float64",{-4.5,0.5,-2.5,-5.5})
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-4.5},"float64"),{}),np.flip(np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),1)}) end),"case 1716 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-4.5},"float64"),{}),np.flip(np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),1)}) end),"case 1717 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-4.5},"float64"),{}),np.flip(np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),1)}) end),"case 1718 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-4.5},"float64"),{}),np.flip(np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),1)}) end),"case 1719 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-4.5},"float64"),{}),np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}).T}) end),"case 1720 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-4.5},"float64"),{}),np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}).T}) end),"case 1721 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-4.5},"float64"),{}),np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}).T}) end),"case 1722 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-4.5},"float64"),{}),np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}).T}) end),"case 1723 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-4.5},"float64"),{}),np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}).T}) end),"case 1724 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({},"float64"),{0}),np.reshape(np.array({},"float64"),{0})}),{0},"float64",{})
cases=cases+1
check(np.vstack({np.reshape(np.array({},"float64"),{0}),np.reshape(np.array({},"float64"),{0})}),{2,0},"float64",{{},{}})
cases=cases+1
check(np.dstack({np.reshape(np.array({},"float64"),{0}),np.reshape(np.array({},"float64"),{0})}),{1,0,2},"float64",{{}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"float64"),{0}),np.reshape(np.array({},"float64"),{0})}),{0,2},"float64",{})
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"float64"),{0}),np.reshape(np.array({},"float64"),{0})}),{2,0},"float64",{{},{}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"float64"),{0}),np.reshape(np.array({},"float64"),{0,2})}) end),"case 1730 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"float64"),{0}),np.reshape(np.array({},"float64"),{0,2})}) end),"case 1731 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"float64"),{0}),np.reshape(np.array({},"float64"),{0,2})}) end),"case 1732 expected failure")
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"float64"),{0}),np.reshape(np.array({},"float64"),{0,2})}),{0,3},"float64",{})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"float64"),{0}),np.reshape(np.array({},"float64"),{0,2})}) end),"case 1734 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"float64"),{0}),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2})}) end),"case 1735 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"float64"),{0}),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2})}) end),"case 1736 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"float64"),{0}),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2})}) end),"case 1737 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"float64"),{0}),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2})}) end),"case 1738 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"float64"),{0}),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2})}) end),"case 1739 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-2.5},"float64"),{1}),np.reshape(np.array({-2.5},"float64"),{1})}),{2},"float64",{-2.5,-2.5})
cases=cases+1
check(np.vstack({np.reshape(np.array({-2.5},"float64"),{1}),np.reshape(np.array({-2.5},"float64"),{1})}),{2,1},"float64",{{-2.5},{-2.5}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-2.5},"float64"),{1}),np.reshape(np.array({-2.5},"float64"),{1})}),{1,1,2},"float64",{{{-2.5,-2.5}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-2.5},"float64"),{1}),np.reshape(np.array({-2.5},"float64"),{1})}),{1,2},"float64",{{-2.5,-2.5}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-2.5},"float64"),{1}),np.reshape(np.array({-2.5},"float64"),{1})}),{2,1},"float64",{{-2.5},{-2.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-2.5},"float64"),{1}),np.reshape(np.array({},"float64"),{0,2}).T}) end),"case 1745 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-2.5},"float64"),{1}),np.reshape(np.array({},"float64"),{0,2}).T}) end),"case 1746 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-2.5},"float64"),{1}),np.reshape(np.array({},"float64"),{0,2}).T}) end),"case 1747 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-2.5},"float64"),{1}),np.reshape(np.array({},"float64"),{0,2}).T}) end),"case 1748 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-2.5},"float64"),{1}),np.reshape(np.array({},"float64"),{0,2}).T}) end),"case 1749 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-2.5},"float64"),{1}),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),1)}) end),"case 1750 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-2.5},"float64"),{1}),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),1)}) end),"case 1751 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-2.5},"float64"),{1}),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),1)}) end),"case 1752 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-2.5},"float64"),{1}),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),1)}) end),"case 1753 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-2.5},"float64"),{1}),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),1)}) end),"case 1754 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-2.5},"float64"),{1}),1),np.flip(np.reshape(np.array({-2.5},"float64"),{1}),1)}),{2},"float64",{-2.5,-2.5})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-2.5},"float64"),{1}),1),np.flip(np.reshape(np.array({-2.5},"float64"),{1}),1)}),{2,1},"float64",{{-2.5},{-2.5}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({-2.5},"float64"),{1}),1),np.flip(np.reshape(np.array({-2.5},"float64"),{1}),1)}),{1,1,2},"float64",{{{-2.5,-2.5}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({-2.5},"float64"),{1}),1),np.flip(np.reshape(np.array({-2.5},"float64"),{1}),1)}),{1,2},"float64",{{-2.5,-2.5}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-2.5},"float64"),{1}),1),np.flip(np.reshape(np.array({-2.5},"float64"),{1}),1)}),{2,1},"float64",{{-2.5},{-2.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-2.5},"float64"),{1}),1),np.reshape(np.array({},"float64"),{2,0})}) end),"case 1760 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-2.5},"float64"),{1}),1),np.reshape(np.array({},"float64"),{2,0})}) end),"case 1761 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-2.5},"float64"),{1}),1),np.reshape(np.array({},"float64"),{2,0})}) end),"case 1762 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-2.5},"float64"),{1}),1),np.reshape(np.array({},"float64"),{2,0})}) end),"case 1763 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-2.5},"float64"),{1}),1),np.reshape(np.array({},"float64"),{2,0})}) end),"case 1764 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-2.5},"float64"),{1}),1),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}).T}) end),"case 1765 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-2.5},"float64"),{1}),1),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}).T}) end),"case 1766 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-2.5},"float64"),{1}),1),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}).T}) end),"case 1767 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-2.5},"float64"),{1}),1),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}).T}) end),"case 1768 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-2.5},"float64"),{1}),1),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}).T}) end),"case 1769 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-0.5,2.5},"float64"),{2}),np.reshape(np.array({-0.5,2.5},"float64"),{2})}),{4},"float64",{-0.5,2.5,-0.5,2.5})
cases=cases+1
check(np.vstack({np.reshape(np.array({-0.5,2.5},"float64"),{2}),np.reshape(np.array({-0.5,2.5},"float64"),{2})}),{2,2},"float64",{{-0.5,2.5},{-0.5,2.5}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-0.5,2.5},"float64"),{2}),np.reshape(np.array({-0.5,2.5},"float64"),{2})}),{1,2,2},"float64",{{{-0.5,-0.5},{2.5,2.5}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-0.5,2.5},"float64"),{2}),np.reshape(np.array({-0.5,2.5},"float64"),{2})}),{2,2},"float64",{{-0.5,-0.5},{2.5,2.5}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-0.5,2.5},"float64"),{2}),np.reshape(np.array({-0.5,2.5},"float64"),{2})}),{2,2},"float64",{{-0.5,2.5},{-0.5,2.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-0.5,2.5},"float64"),{2}),np.reshape(np.array({},"float64"),{2,0}).T}) end),"case 1775 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({-0.5,2.5},"float64"),{2}),np.reshape(np.array({},"float64"),{2,0}).T}),{1,2},"float64",{{-0.5,2.5}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-0.5,2.5},"float64"),{2}),np.reshape(np.array({},"float64"),{2,0}).T}) end),"case 1777 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-0.5,2.5},"float64"),{2}),np.reshape(np.array({},"float64"),{2,0}).T}) end),"case 1778 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({-0.5,2.5},"float64"),{2}),np.reshape(np.array({},"float64"),{2,0}).T}),{1,2},"float64",{{-0.5,2.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-0.5,2.5},"float64"),{2}),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2})}) end),"case 1780 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-0.5,2.5},"float64"),{2}),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2})}) end),"case 1781 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-0.5,2.5},"float64"),{2}),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2})}) end),"case 1782 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-0.5,2.5},"float64"),{2}),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2})}) end),"case 1783 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-0.5,2.5},"float64"),{2}),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2})}) end),"case 1784 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-0.5,2.5},"float64"),{2}),1),np.flip(np.reshape(np.array({-0.5,2.5},"float64"),{2}),1)}),{4},"float64",{2.5,-0.5,2.5,-0.5})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-0.5,2.5},"float64"),{2}),1),np.flip(np.reshape(np.array({-0.5,2.5},"float64"),{2}),1)}),{2,2},"float64",{{2.5,-0.5},{2.5,-0.5}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({-0.5,2.5},"float64"),{2}),1),np.flip(np.reshape(np.array({-0.5,2.5},"float64"),{2}),1)}),{1,2,2},"float64",{{{2.5,2.5},{-0.5,-0.5}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({-0.5,2.5},"float64"),{2}),1),np.flip(np.reshape(np.array({-0.5,2.5},"float64"),{2}),1)}),{2,2},"float64",{{2.5,2.5},{-0.5,-0.5}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-0.5,2.5},"float64"),{2}),1),np.flip(np.reshape(np.array({-0.5,2.5},"float64"),{2}),1)}),{2,2},"float64",{{2.5,-0.5},{2.5,-0.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-0.5,2.5},"float64"),{2}),1),np.reshape(np.array({-6.5,-3.5},"float64"),{1,2})}) end),"case 1790 expected failure")
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-0.5,2.5},"float64"),{2}),1),np.reshape(np.array({-6.5,-3.5},"float64"),{1,2})}),{2,2},"float64",{{2.5,-0.5},{-6.5,-3.5}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({-0.5,2.5},"float64"),{2}),1),np.reshape(np.array({-6.5,-3.5},"float64"),{1,2})}),{1,2,2},"float64",{{{2.5,-6.5},{-0.5,-3.5}}})
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-0.5,2.5},"float64"),{2}),1),np.reshape(np.array({-6.5,-3.5},"float64"),{1,2})}) end),"case 1793 expected failure")
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-0.5,2.5},"float64"),{2}),1),np.reshape(np.array({-6.5,-3.5},"float64"),{1,2})}),{2,2},"float64",{{2.5,-0.5},{-6.5,-3.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-0.5,2.5},"float64"),{2}),1),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),1)}) end),"case 1795 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-0.5,2.5},"float64"),{2}),1),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),1)}) end),"case 1796 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-0.5,2.5},"float64"),{2}),1),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),1)}) end),"case 1797 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-0.5,2.5},"float64"),{2}),1),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),1)}) end),"case 1798 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-0.5,2.5},"float64"),{2}),1),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),1)}) end),"case 1799 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3})}),{6},"float64",{-5.5,-2.5,0.5,-5.5,-2.5,0.5})
cases=cases+1
check(np.vstack({np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3})}),{2,3},"float64",{{-5.5,-2.5,0.5},{-5.5,-2.5,0.5}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3})}),{1,3,2},"float64",{{{-5.5,-5.5},{-2.5,-2.5},{0.5,0.5}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3})}),{3,2},"float64",{{-5.5,-5.5},{-2.5,-2.5},{0.5,0.5}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3})}),{2,3},"float64",{{-5.5,-2.5,0.5},{-5.5,-2.5,0.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),np.flip(np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),1)}) end),"case 1805 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),np.flip(np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),1)}) end),"case 1806 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),np.flip(np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),1)}) end),"case 1807 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),np.flip(np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),1)}) end),"case 1808 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),np.flip(np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),1)}) end),"case 1809 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}).T}) end),"case 1810 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}).T}) end),"case 1811 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}).T}) end),"case 1812 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}).T}) end),"case 1813 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}).T}) end),"case 1814 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),1),np.flip(np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),1)}),{6},"float64",{0.5,-2.5,-5.5,0.5,-2.5,-5.5})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),1),np.flip(np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),1)}),{2,3},"float64",{{0.5,-2.5,-5.5},{0.5,-2.5,-5.5}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),1),np.flip(np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),1)}),{1,3,2},"float64",{{{0.5,0.5},{-2.5,-2.5},{-5.5,-5.5}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),1),np.flip(np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),1)}),{3,2},"float64",{{0.5,0.5},{-2.5,-2.5},{-5.5,-5.5}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),1),np.flip(np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),1)}),{2,3},"float64",{{0.5,-2.5,-5.5},{0.5,-2.5,-5.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),1),np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}).T}) end),"case 1820 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),1),np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}).T}) end),"case 1821 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),1),np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}).T}) end),"case 1822 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),1),np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}).T}) end),"case 1823 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),1),np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}).T}) end),"case 1824 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),1),np.reshape(np.array({-4.5},"float64"),{})}),{4},"float64",{0.5,-2.5,-5.5,-4.5})
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),1),np.reshape(np.array({-4.5},"float64"),{})}) end),"case 1826 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),1),np.reshape(np.array({-4.5},"float64"),{})}) end),"case 1827 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),1),np.reshape(np.array({-4.5},"float64"),{})}) end),"case 1828 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),1),np.reshape(np.array({-4.5},"float64"),{})}) end),"case 1829 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({},"float64"),{0,2}),np.reshape(np.array({},"float64"),{0,2})}),{0,4},"float64",{})
cases=cases+1
check(np.vstack({np.reshape(np.array({},"float64"),{0,2}),np.reshape(np.array({},"float64"),{0,2})}),{0,2},"float64",{})
cases=cases+1
check(np.dstack({np.reshape(np.array({},"float64"),{0,2}),np.reshape(np.array({},"float64"),{0,2})}),{0,2,2},"float64",{})
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"float64"),{0,2}),np.reshape(np.array({},"float64"),{0,2})}),{0,4},"float64",{})
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"float64"),{0,2}),np.reshape(np.array({},"float64"),{0,2})}),{0,2},"float64",{})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"float64"),{0,2}),np.reshape(np.array({-3.5,-0.5},"float64"),{2,1})}) end),"case 1835 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"float64"),{0,2}),np.reshape(np.array({-3.5,-0.5},"float64"),{2,1})}) end),"case 1836 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"float64"),{0,2}),np.reshape(np.array({-3.5,-0.5},"float64"),{2,1})}) end),"case 1837 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"float64"),{0,2}),np.reshape(np.array({-3.5,-0.5},"float64"),{2,1})}) end),"case 1838 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"float64"),{0,2}),np.reshape(np.array({-3.5,-0.5},"float64"),{2,1})}) end),"case 1839 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"float64"),{0,2}),np.reshape(np.array({},"float64"),{0})}) end),"case 1840 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"float64"),{0,2}),np.reshape(np.array({},"float64"),{0})}) end),"case 1841 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"float64"),{0,2}),np.reshape(np.array({},"float64"),{0})}) end),"case 1842 expected failure")
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"float64"),{0,2}),np.reshape(np.array({},"float64"),{0})}),{0,3},"float64",{})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"float64"),{0,2}),np.reshape(np.array({},"float64"),{0})}) end),"case 1844 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({},"float64"),{0,2}).T,np.reshape(np.array({},"float64"),{0,2}).T}),{2,0},"float64",{{},{}})
cases=cases+1
check(np.vstack({np.reshape(np.array({},"float64"),{0,2}).T,np.reshape(np.array({},"float64"),{0,2}).T}),{4,0},"float64",{{},{},{},{}})
cases=cases+1
check(np.dstack({np.reshape(np.array({},"float64"),{0,2}).T,np.reshape(np.array({},"float64"),{0,2}).T}),{2,0,2},"float64",{{},{}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"float64"),{0,2}).T,np.reshape(np.array({},"float64"),{0,2}).T}),{2,0},"float64",{{},{}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"float64"),{0,2}).T,np.reshape(np.array({},"float64"),{0,2}).T}),{4,0},"float64",{{},{},{},{}})
cases=cases+1
check(np.hstack({np.reshape(np.array({},"float64"),{0,2}).T,np.flip(np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),1)}),{2,1},"float64",{{-0.5},{-3.5}})
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"float64"),{0,2}).T,np.flip(np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),1)}) end),"case 1851 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"float64"),{0,2}).T,np.flip(np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),1)}) end),"case 1852 expected failure")
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"float64"),{0,2}).T,np.flip(np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),1)}),{2,1},"float64",{{-0.5},{-3.5}})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"float64"),{0,2}).T,np.flip(np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),1)}) end),"case 1854 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"float64"),{0,2}).T,np.reshape(np.array({-2.5},"float64"),{1})}) end),"case 1855 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"float64"),{0,2}).T,np.reshape(np.array({-2.5},"float64"),{1})}) end),"case 1856 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"float64"),{0,2}).T,np.reshape(np.array({-2.5},"float64"),{1})}) end),"case 1857 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"float64"),{0,2}).T,np.reshape(np.array({-2.5},"float64"),{1})}) end),"case 1858 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"float64"),{0,2}).T,np.reshape(np.array({-2.5},"float64"),{1})}) end),"case 1859 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({},"float64"),{2,0}),np.reshape(np.array({},"float64"),{2,0})}),{2,0},"float64",{{},{}})
cases=cases+1
check(np.vstack({np.reshape(np.array({},"float64"),{2,0}),np.reshape(np.array({},"float64"),{2,0})}),{4,0},"float64",{{},{},{},{}})
cases=cases+1
check(np.dstack({np.reshape(np.array({},"float64"),{2,0}),np.reshape(np.array({},"float64"),{2,0})}),{2,0,2},"float64",{{},{}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"float64"),{2,0}),np.reshape(np.array({},"float64"),{2,0})}),{2,0},"float64",{{},{}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"float64"),{2,0}),np.reshape(np.array({},"float64"),{2,0})}),{4,0},"float64",{{},{},{},{}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"float64"),{2,0}),np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}).T}) end),"case 1865 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"float64"),{2,0}),np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}).T}) end),"case 1866 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"float64"),{2,0}),np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}).T}) end),"case 1867 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"float64"),{2,0}),np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}).T}) end),"case 1868 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"float64"),{2,0}),np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}).T}) end),"case 1869 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"float64"),{2,0}),np.flip(np.reshape(np.array({-2.5},"float64"),{1}),1)}) end),"case 1870 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"float64"),{2,0}),np.flip(np.reshape(np.array({-2.5},"float64"),{1}),1)}) end),"case 1871 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"float64"),{2,0}),np.flip(np.reshape(np.array({-2.5},"float64"),{1}),1)}) end),"case 1872 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"float64"),{2,0}),np.flip(np.reshape(np.array({-2.5},"float64"),{1}),1)}) end),"case 1873 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"float64"),{2,0}),np.flip(np.reshape(np.array({-2.5},"float64"),{1}),1)}) end),"case 1874 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({},"float64"),{2,0}).T,np.reshape(np.array({},"float64"),{2,0}).T}),{0,4},"float64",{})
cases=cases+1
check(np.vstack({np.reshape(np.array({},"float64"),{2,0}).T,np.reshape(np.array({},"float64"),{2,0}).T}),{0,2},"float64",{})
cases=cases+1
check(np.dstack({np.reshape(np.array({},"float64"),{2,0}).T,np.reshape(np.array({},"float64"),{2,0}).T}),{0,2,2},"float64",{})
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"float64"),{2,0}).T,np.reshape(np.array({},"float64"),{2,0}).T}),{0,4},"float64",{})
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"float64"),{2,0}).T,np.reshape(np.array({},"float64"),{2,0}).T}),{0,2},"float64",{})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"float64"),{2,0}).T,np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2})}) end),"case 1880 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({},"float64"),{2,0}).T,np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2})}),{2,2},"float64",{{-0.5,2.5},{5.5,-4.5}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"float64"),{2,0}).T,np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2})}) end),"case 1882 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"float64"),{2,0}).T,np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2})}) end),"case 1883 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"float64"),{2,0}).T,np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2})}),{2,2},"float64",{{-0.5,2.5},{5.5,-4.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"float64"),{2,0}).T,np.reshape(np.array({-0.5,2.5},"float64"),{2})}) end),"case 1885 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({},"float64"),{2,0}).T,np.reshape(np.array({-0.5,2.5},"float64"),{2})}),{1,2},"float64",{{-0.5,2.5}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"float64"),{2,0}).T,np.reshape(np.array({-0.5,2.5},"float64"),{2})}) end),"case 1887 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"float64"),{2,0}).T,np.reshape(np.array({-0.5,2.5},"float64"),{2})}) end),"case 1888 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"float64"),{2,0}).T,np.reshape(np.array({-0.5,2.5},"float64"),{2})}),{1,2},"float64",{{-0.5,2.5}})
cases=cases+1
check(np.hstack({np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),np.reshape(np.array({-6.5,-3.5},"float64"),{1,2})}),{1,4},"float64",{{-6.5,-3.5,-6.5,-3.5}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),np.reshape(np.array({-6.5,-3.5},"float64"),{1,2})}),{2,2},"float64",{{-6.5,-3.5},{-6.5,-3.5}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),np.reshape(np.array({-6.5,-3.5},"float64"),{1,2})}),{1,2,2},"float64",{{{-6.5,-6.5},{-3.5,-3.5}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),np.reshape(np.array({-6.5,-3.5},"float64"),{1,2})}),{1,4},"float64",{{-6.5,-3.5,-6.5,-3.5}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),np.reshape(np.array({-6.5,-3.5},"float64"),{1,2})}),{2,2},"float64",{{-6.5,-3.5},{-6.5,-3.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),1)}) end),"case 1895 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),1)}),{3,2},"float64",{{-6.5,-3.5},{5.5,-4.5},{-0.5,2.5}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),1)}) end),"case 1897 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),1)}) end),"case 1898 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),1)}),{3,2},"float64",{{-6.5,-3.5},{5.5,-4.5},{-0.5,2.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),np.flip(np.reshape(np.array({-0.5,2.5},"float64"),{2}),1)}) end),"case 1900 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),np.flip(np.reshape(np.array({-0.5,2.5},"float64"),{2}),1)}),{2,2},"float64",{{-6.5,-3.5},{2.5,-0.5}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),np.flip(np.reshape(np.array({-0.5,2.5},"float64"),{2}),1)}),{1,2,2},"float64",{{{-6.5,2.5},{-3.5,-0.5}}})
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),np.flip(np.reshape(np.array({-0.5,2.5},"float64"),{2}),1)}) end),"case 1903 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),np.flip(np.reshape(np.array({-0.5,2.5},"float64"),{2}),1)}),{2,2},"float64",{{-6.5,-3.5},{2.5,-0.5}})
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),1),np.flip(np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),1)}),{1,4},"float64",{{-6.5,-3.5,-6.5,-3.5}})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),1),np.flip(np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),1)}),{2,2},"float64",{{-6.5,-3.5},{-6.5,-3.5}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),1),np.flip(np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),1)}),{1,2,2},"float64",{{{-6.5,-6.5},{-3.5,-3.5}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),1),np.flip(np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),1)}),{1,4},"float64",{{-6.5,-3.5,-6.5,-3.5}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),1),np.flip(np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),1)}),{2,2},"float64",{{-6.5,-3.5},{-6.5,-3.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),1),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}).T}) end),"case 1910 expected failure")
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),1),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}).T}),{3,2},"float64",{{-6.5,-3.5},{-0.5,5.5},{2.5,-4.5}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),1),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}).T}) end),"case 1912 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),1),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}).T}) end),"case 1913 expected failure")
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),1),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}).T}),{3,2},"float64",{{-6.5,-3.5},{-0.5,5.5},{2.5,-4.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),1),np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3})}) end),"case 1915 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),1),np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3})}) end),"case 1916 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),1),np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3})}) end),"case 1917 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),1),np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3})}) end),"case 1918 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),1),np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3})}) end),"case 1919 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}).T,np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}).T}),{2,2},"float64",{{-6.5,-6.5},{-3.5,-3.5}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}).T,np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}).T}),{4,1},"float64",{{-6.5},{-3.5},{-6.5},{-3.5}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}).T,np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}).T}),{2,1,2},"float64",{{{-6.5,-6.5}},{{-3.5,-3.5}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}).T,np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}).T}),{2,2},"float64",{{-6.5,-6.5},{-3.5,-3.5}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}).T,np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}).T}),{4,1},"float64",{{-6.5},{-3.5},{-6.5},{-3.5}})
cases=cases+1
check(np.hstack({np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}).T,np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3})}),{2,4},"float64",{{-6.5,-4.5,-1.5,1.5},{-3.5,4.5,-5.5,-2.5}})
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}).T,np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3})}) end),"case 1926 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}).T,np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3})}) end),"case 1927 expected failure")
cases=cases+1
check(np.column_stack({np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}).T,np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3})}),{2,4},"float64",{{-6.5,-4.5,-1.5,1.5},{-3.5,4.5,-5.5,-2.5}})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}).T,np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3})}) end),"case 1929 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}).T,np.flip(np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),1)}) end),"case 1930 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}).T,np.flip(np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),1)}) end),"case 1931 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}).T,np.flip(np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),1)}) end),"case 1932 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}).T,np.flip(np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),1)}) end),"case 1933 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}).T,np.flip(np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3}),1)}) end),"case 1934 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),np.reshape(np.array({-3.5,-0.5},"float64"),{2,1})}),{2,2},"float64",{{-3.5,-3.5},{-0.5,-0.5}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),np.reshape(np.array({-3.5,-0.5},"float64"),{2,1})}),{4,1},"float64",{{-3.5},{-0.5},{-3.5},{-0.5}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),np.reshape(np.array({-3.5,-0.5},"float64"),{2,1})}),{2,1,2},"float64",{{{-3.5,-3.5}},{{-0.5,-0.5}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),np.reshape(np.array({-3.5,-0.5},"float64"),{2,1})}),{2,2},"float64",{{-3.5,-3.5},{-0.5,-0.5}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),np.reshape(np.array({-3.5,-0.5},"float64"),{2,1})}),{4,1},"float64",{{-3.5},{-0.5},{-3.5},{-0.5}})
cases=cases+1
check(np.hstack({np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),1)}),{2,4},"float64",{{-3.5,4.5,-5.5,-2.5},{-0.5,-4.5,-1.5,1.5}})
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),1)}) end),"case 1941 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),1)}) end),"case 1942 expected failure")
cases=cases+1
check(np.column_stack({np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),1)}),{2,4},"float64",{{-3.5,4.5,-5.5,-2.5},{-0.5,-4.5,-1.5,1.5}})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),1)}) end),"case 1944 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),np.reshape(np.array({},"float64"),{0,2})}) end),"case 1945 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),np.reshape(np.array({},"float64"),{0,2})}) end),"case 1946 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),np.reshape(np.array({},"float64"),{0,2})}) end),"case 1947 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),np.reshape(np.array({},"float64"),{0,2})}) end),"case 1948 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),np.reshape(np.array({},"float64"),{0,2})}) end),"case 1949 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),1),np.flip(np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),1)}),{2,2},"float64",{{-0.5,-0.5},{-3.5,-3.5}})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),1),np.flip(np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),1)}),{4,1},"float64",{{-0.5},{-3.5},{-0.5},{-3.5}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),1),np.flip(np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),1)}),{2,1,2},"float64",{{{-0.5,-0.5}},{{-3.5,-3.5}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),1),np.flip(np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),1)}),{2,2},"float64",{{-0.5,-0.5},{-3.5,-3.5}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),1),np.flip(np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),1)}),{4,1},"float64",{{-0.5},{-3.5},{-0.5},{-3.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),1),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}).T}) end),"case 1955 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),1),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}).T}) end),"case 1956 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),1),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}).T}) end),"case 1957 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),1),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}).T}) end),"case 1958 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),1),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}).T}) end),"case 1959 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),1),np.reshape(np.array({},"float64"),{0,2}).T}),{2,1},"float64",{{-0.5},{-3.5}})
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),1),np.reshape(np.array({},"float64"),{0,2}).T}) end),"case 1961 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),1),np.reshape(np.array({},"float64"),{0,2}).T}) end),"case 1962 expected failure")
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),1),np.reshape(np.array({},"float64"),{0,2}).T}),{2,1},"float64",{{-0.5},{-3.5}})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),1),np.reshape(np.array({},"float64"),{0,2}).T}) end),"case 1964 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}).T,np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}).T}),{1,4},"float64",{{-3.5,-0.5,-3.5,-0.5}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}).T,np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}).T}),{2,2},"float64",{{-3.5,-0.5},{-3.5,-0.5}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}).T,np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}).T}),{1,2,2},"float64",{{{-3.5,-3.5},{-0.5,-0.5}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}).T,np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}).T}),{1,4},"float64",{{-3.5,-0.5,-3.5,-0.5}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}).T,np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}).T}),{2,2},"float64",{{-3.5,-0.5},{-3.5,-0.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}).T,np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2})}) end),"case 1970 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}).T,np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2})}),{4,2},"float64",{{-3.5,-0.5},{-1.5,1.5},{4.5,-5.5},{-2.5,0.5}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}).T,np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2})}) end),"case 1972 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}).T,np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2})}) end),"case 1973 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}).T,np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2})}),{4,2},"float64",{{-3.5,-0.5},{-1.5,1.5},{4.5,-5.5},{-2.5,0.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}).T,np.reshape(np.array({},"float64"),{2,0})}) end),"case 1975 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}).T,np.reshape(np.array({},"float64"),{2,0})}) end),"case 1976 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}).T,np.reshape(np.array({},"float64"),{2,0})}) end),"case 1977 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}).T,np.reshape(np.array({},"float64"),{2,0})}) end),"case 1978 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}).T,np.reshape(np.array({},"float64"),{2,0})}) end),"case 1979 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2})}),{2,4},"float64",{{-0.5,2.5,-0.5,2.5},{5.5,-4.5,5.5,-4.5}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2})}),{4,2},"float64",{{-0.5,2.5},{5.5,-4.5},{-0.5,2.5},{5.5,-4.5}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2})}),{2,2,2},"float64",{{{-0.5,-0.5},{2.5,2.5}},{{5.5,5.5},{-4.5,-4.5}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2})}),{2,4},"float64",{{-0.5,2.5,-0.5,2.5},{5.5,-4.5,5.5,-4.5}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2})}),{4,2},"float64",{{-0.5,2.5},{5.5,-4.5},{-0.5,2.5},{5.5,-4.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),np.flip(np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),1)}) end),"case 1985 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),np.flip(np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),1)}),{5,2},"float64",{{-0.5,2.5},{5.5,-4.5},{-2.5,0.5},{4.5,-5.5},{-1.5,1.5}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),np.flip(np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),1)}) end),"case 1987 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),np.flip(np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),1)}) end),"case 1988 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),np.flip(np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),1)}),{5,2},"float64",{{-0.5,2.5},{5.5,-4.5},{-2.5,0.5},{4.5,-5.5},{-1.5,1.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),np.reshape(np.array({},"float64"),{2,0}).T}) end),"case 1990 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),np.reshape(np.array({},"float64"),{2,0}).T}),{2,2},"float64",{{-0.5,2.5},{5.5,-4.5}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),np.reshape(np.array({},"float64"),{2,0}).T}) end),"case 1992 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),np.reshape(np.array({},"float64"),{2,0}).T}) end),"case 1993 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),np.reshape(np.array({},"float64"),{2,0}).T}),{2,2},"float64",{{-0.5,2.5},{5.5,-4.5}})
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),1),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),1)}),{2,4},"float64",{{5.5,-4.5,5.5,-4.5},{-0.5,2.5,-0.5,2.5}})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),1),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),1)}),{4,2},"float64",{{5.5,-4.5},{-0.5,2.5},{5.5,-4.5},{-0.5,2.5}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),1),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),1)}),{2,2,2},"float64",{{{5.5,5.5},{-4.5,-4.5}},{{-0.5,-0.5},{2.5,2.5}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),1),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),1)}),{2,4},"float64",{{5.5,-4.5,5.5,-4.5},{-0.5,2.5,-0.5,2.5}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),1),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),1)}),{4,2},"float64",{{5.5,-4.5},{-0.5,2.5},{5.5,-4.5},{-0.5,2.5}})
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),1),np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}).T}),{2,5},"float64",{{5.5,-4.5,-1.5,4.5,-2.5},{-0.5,2.5,1.5,-5.5,0.5}})
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),1),np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}).T}) end),"case 2001 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),1),np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}).T}) end),"case 2002 expected failure")
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),1),np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}).T}),{2,5},"float64",{{5.5,-4.5,-1.5,4.5,-2.5},{-0.5,2.5,1.5,-5.5,0.5}})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),1),np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}).T}) end),"case 2004 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),1),np.reshape(np.array({-6.5,-3.5},"float64"),{1,2})}) end),"case 2005 expected failure")
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),1),np.reshape(np.array({-6.5,-3.5},"float64"),{1,2})}),{3,2},"float64",{{5.5,-4.5},{-0.5,2.5},{-6.5,-3.5}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),1),np.reshape(np.array({-6.5,-3.5},"float64"),{1,2})}) end),"case 2007 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),1),np.reshape(np.array({-6.5,-3.5},"float64"),{1,2})}) end),"case 2008 expected failure")
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),1),np.reshape(np.array({-6.5,-3.5},"float64"),{1,2})}),{3,2},"float64",{{5.5,-4.5},{-0.5,2.5},{-6.5,-3.5}})
cases=cases+1
check(np.hstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}).T,np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}).T}),{2,4},"float64",{{-0.5,5.5,-0.5,5.5},{2.5,-4.5,2.5,-4.5}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}).T,np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}).T}),{4,2},"float64",{{-0.5,5.5},{2.5,-4.5},{-0.5,5.5},{2.5,-4.5}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}).T,np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}).T}),{2,2,2},"float64",{{{-0.5,-0.5},{5.5,5.5}},{{2.5,2.5},{-4.5,-4.5}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}).T,np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}).T}),{2,4},"float64",{{-0.5,5.5,-0.5,5.5},{2.5,-4.5,2.5,-4.5}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}).T,np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}).T}),{4,2},"float64",{{-0.5,5.5},{2.5,-4.5},{-0.5,5.5},{2.5,-4.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}).T,np.reshape(np.array({},"float64"),{0,2,1})}) end),"case 2015 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}).T,np.reshape(np.array({},"float64"),{0,2,1})}) end),"case 2016 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}).T,np.reshape(np.array({},"float64"),{0,2,1})}) end),"case 2017 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}).T,np.reshape(np.array({},"float64"),{0,2,1})}) end),"case 2018 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}).T,np.reshape(np.array({},"float64"),{0,2,1})}) end),"case 2019 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}).T,np.flip(np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),1)}) end),"case 2020 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}).T,np.flip(np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),1)}),{3,2},"float64",{{-0.5,5.5},{2.5,-4.5},{-6.5,-3.5}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}).T,np.flip(np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),1)}) end),"case 2022 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}).T,np.flip(np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),1)}) end),"case 2023 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}).T,np.flip(np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}),1)}),{3,2},"float64",{{-0.5,5.5},{2.5,-4.5},{-6.5,-3.5}})
cases=cases+1
check(np.hstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3})}),{2,6},"float64",{{-4.5,-1.5,1.5,-4.5,-1.5,1.5},{4.5,-5.5,-2.5,4.5,-5.5,-2.5}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3})}),{4,3},"float64",{{-4.5,-1.5,1.5},{4.5,-5.5,-2.5},{-4.5,-1.5,1.5},{4.5,-5.5,-2.5}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3})}),{2,3,2},"float64",{{{-4.5,-4.5},{-1.5,-1.5},{1.5,1.5}},{{4.5,4.5},{-5.5,-5.5},{-2.5,-2.5}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3})}),{2,6},"float64",{{-4.5,-1.5,1.5,-4.5,-1.5,1.5},{4.5,-5.5,-2.5,4.5,-5.5,-2.5}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3})}),{4,3},"float64",{{-4.5,-1.5,1.5},{4.5,-5.5,-2.5},{-4.5,-1.5,1.5},{4.5,-5.5,-2.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),np.reshape(np.array({},"float64"),{0,2,1}).T}) end),"case 2030 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),np.reshape(np.array({},"float64"),{0,2,1}).T}) end),"case 2031 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),np.reshape(np.array({},"float64"),{0,2,1}).T}) end),"case 2032 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),np.reshape(np.array({},"float64"),{0,2,1}).T}) end),"case 2033 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),np.reshape(np.array({},"float64"),{0,2,1}).T}) end),"case 2034 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}).T}),{2,4},"float64",{{-4.5,-1.5,1.5,-6.5},{4.5,-5.5,-2.5,-3.5}})
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}).T}) end),"case 2036 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}).T}) end),"case 2037 expected failure")
cases=cases+1
check(np.column_stack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}).T}),{2,4},"float64",{{-4.5,-1.5,1.5,-6.5},{4.5,-5.5,-2.5,-3.5}})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),np.reshape(np.array({-6.5,-3.5},"float64"),{1,2}).T}) end),"case 2039 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),1),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),1)}),{2,6},"float64",{{4.5,-5.5,-2.5,4.5,-5.5,-2.5},{-4.5,-1.5,1.5,-4.5,-1.5,1.5}})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),1),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),1)}),{4,3},"float64",{{4.5,-5.5,-2.5},{-4.5,-1.5,1.5},{4.5,-5.5,-2.5},{-4.5,-1.5,1.5}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),1),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),1)}),{2,3,2},"float64",{{{4.5,4.5},{-5.5,-5.5},{-2.5,-2.5}},{{-4.5,-4.5},{-1.5,-1.5},{1.5,1.5}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),1),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),1)}),{2,6},"float64",{{4.5,-5.5,-2.5,4.5,-5.5,-2.5},{-4.5,-1.5,1.5,-4.5,-1.5,1.5}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),1),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),1)}),{4,3},"float64",{{4.5,-5.5,-2.5},{-4.5,-1.5,1.5},{4.5,-5.5,-2.5},{-4.5,-1.5,1.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),1),np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3})}) end),"case 2045 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),1),np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3})}) end),"case 2046 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),1),np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3})}) end),"case 2047 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),1),np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3})}) end),"case 2048 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),1),np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3})}) end),"case 2049 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),1),np.reshape(np.array({-3.5,-0.5},"float64"),{2,1})}),{2,4},"float64",{{4.5,-5.5,-2.5,-3.5},{-4.5,-1.5,1.5,-0.5}})
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),1),np.reshape(np.array({-3.5,-0.5},"float64"),{2,1})}) end),"case 2051 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),1),np.reshape(np.array({-3.5,-0.5},"float64"),{2,1})}) end),"case 2052 expected failure")
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),1),np.reshape(np.array({-3.5,-0.5},"float64"),{2,1})}),{2,4},"float64",{{4.5,-5.5,-2.5,-3.5},{-4.5,-1.5,1.5,-0.5}})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),1),np.reshape(np.array({-3.5,-0.5},"float64"),{2,1})}) end),"case 2054 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}).T,np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}).T}),{3,4},"float64",{{-4.5,4.5,-4.5,4.5},{-1.5,-5.5,-1.5,-5.5},{1.5,-2.5,1.5,-2.5}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}).T,np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}).T}),{6,2},"float64",{{-4.5,4.5},{-1.5,-5.5},{1.5,-2.5},{-4.5,4.5},{-1.5,-5.5},{1.5,-2.5}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}).T,np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}).T}),{3,2,2},"float64",{{{-4.5,-4.5},{4.5,4.5}},{{-1.5,-1.5},{-5.5,-5.5}},{{1.5,1.5},{-2.5,-2.5}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}).T,np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}).T}),{3,4},"float64",{{-4.5,4.5,-4.5,4.5},{-1.5,-5.5,-1.5,-5.5},{1.5,-2.5,1.5,-2.5}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}).T,np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}).T}),{6,2},"float64",{{-4.5,4.5},{-1.5,-5.5},{1.5,-2.5},{-4.5,4.5},{-1.5,-5.5},{1.5,-2.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}).T,np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),1)}) end),"case 2060 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}).T,np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),1)}) end),"case 2061 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}).T,np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),1)}) end),"case 2062 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}).T,np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),1)}) end),"case 2063 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}).T,np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),1)}) end),"case 2064 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}).T,np.flip(np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),1)}) end),"case 2065 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}).T,np.flip(np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),1)}) end),"case 2066 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}).T,np.flip(np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),1)}) end),"case 2067 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}).T,np.flip(np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),1)}) end),"case 2068 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}).T,np.flip(np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}),1)}) end),"case 2069 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2})}),{3,4},"float64",{{-1.5,1.5,-1.5,1.5},{4.5,-5.5,4.5,-5.5},{-2.5,0.5,-2.5,0.5}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2})}),{6,2},"float64",{{-1.5,1.5},{4.5,-5.5},{-2.5,0.5},{-1.5,1.5},{4.5,-5.5},{-2.5,0.5}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2})}),{3,2,2},"float64",{{{-1.5,-1.5},{1.5,1.5}},{{4.5,4.5},{-5.5,-5.5}},{{-2.5,-2.5},{0.5,0.5}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2})}),{3,4},"float64",{{-1.5,1.5,-1.5,1.5},{4.5,-5.5,4.5,-5.5},{-2.5,0.5,-2.5,0.5}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2})}),{6,2},"float64",{{-1.5,1.5},{4.5,-5.5},{-2.5,0.5},{-1.5,1.5},{4.5,-5.5},{-2.5,0.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}).T}) end),"case 2075 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}).T}) end),"case 2076 expected failure")
cases=cases+1
check(np.dstack({np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}).T}),{3,2,2},"float64",{{{-1.5,-3.5},{1.5,5.5}},{{4.5,-0.5},{-5.5,-4.5}},{{-2.5,2.5},{0.5,-1.5}}})
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}).T}) end),"case 2078 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}).T}) end),"case 2079 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}).T}) end),"case 2080 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}).T}),{4,2},"float64",{{-1.5,1.5},{4.5,-5.5},{-2.5,0.5},{-3.5,-0.5}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}).T}) end),"case 2082 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}).T}) end),"case 2083 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),np.reshape(np.array({-3.5,-0.5},"float64"),{2,1}).T}),{4,2},"float64",{{-1.5,1.5},{4.5,-5.5},{-2.5,0.5},{-3.5,-0.5}})
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),1),np.flip(np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),1)}),{3,4},"float64",{{-2.5,0.5,-2.5,0.5},{4.5,-5.5,4.5,-5.5},{-1.5,1.5,-1.5,1.5}})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),1),np.flip(np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),1)}),{6,2},"float64",{{-2.5,0.5},{4.5,-5.5},{-1.5,1.5},{-2.5,0.5},{4.5,-5.5},{-1.5,1.5}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),1),np.flip(np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),1)}),{3,2,2},"float64",{{{-2.5,-2.5},{0.5,0.5}},{{4.5,4.5},{-5.5,-5.5}},{{-1.5,-1.5},{1.5,1.5}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),1),np.flip(np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),1)}),{3,4},"float64",{{-2.5,0.5,-2.5,0.5},{4.5,-5.5,4.5,-5.5},{-1.5,1.5,-1.5,1.5}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),1),np.flip(np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),1)}),{6,2},"float64",{{-2.5,0.5},{4.5,-5.5},{-1.5,1.5},{-2.5,0.5},{4.5,-5.5},{-1.5,1.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),1),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2})}) end),"case 2090 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),1),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2})}) end),"case 2091 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),1),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2})}) end),"case 2092 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),1),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2})}) end),"case 2093 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),1),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2})}) end),"case 2094 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),1),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2})}) end),"case 2095 expected failure")
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),1),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2})}),{5,2},"float64",{{-2.5,0.5},{4.5,-5.5},{-1.5,1.5},{-0.5,2.5},{5.5,-4.5}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),1),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2})}) end),"case 2097 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),1),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2})}) end),"case 2098 expected failure")
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),1),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2})}),{5,2},"float64",{{-2.5,0.5},{4.5,-5.5},{-1.5,1.5},{-0.5,2.5},{5.5,-4.5}})
cases=cases+1
check(np.hstack({np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}).T,np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}).T}),{2,6},"float64",{{-1.5,4.5,-2.5,-1.5,4.5,-2.5},{1.5,-5.5,0.5,1.5,-5.5,0.5}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}).T,np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}).T}),{4,3},"float64",{{-1.5,4.5,-2.5},{1.5,-5.5,0.5},{-1.5,4.5,-2.5},{1.5,-5.5,0.5}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}).T,np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}).T}),{2,3,2},"float64",{{{-1.5,-1.5},{4.5,4.5},{-2.5,-2.5}},{{1.5,1.5},{-5.5,-5.5},{0.5,0.5}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}).T,np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}).T}),{2,6},"float64",{{-1.5,4.5,-2.5,-1.5,4.5,-2.5},{1.5,-5.5,0.5,1.5,-5.5,0.5}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}).T,np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}).T}),{4,3},"float64",{{-1.5,4.5,-2.5},{1.5,-5.5,0.5},{-1.5,4.5,-2.5},{1.5,-5.5,0.5}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}).T,np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),1)}) end),"case 2105 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}).T,np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),1)}) end),"case 2106 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}).T,np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),1)}) end),"case 2107 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}).T,np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),1)}) end),"case 2108 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}).T,np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),1)}) end),"case 2109 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}).T,np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),1)}),{2,5},"float64",{{-1.5,4.5,-2.5,5.5,-4.5},{1.5,-5.5,0.5,-0.5,2.5}})
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}).T,np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),1)}) end),"case 2111 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}).T,np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),1)}) end),"case 2112 expected failure")
cases=cases+1
check(np.column_stack({np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}).T,np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),1)}),{2,5},"float64",{{-1.5,4.5,-2.5,5.5,-4.5},{1.5,-5.5,0.5,-0.5,2.5}})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}).T,np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}),1)}) end),"case 2114 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({},"float64"),{0,2,1}),np.reshape(np.array({},"float64"),{0,2,1})}),{0,4,1},"float64",{})
cases=cases+1
check(np.vstack({np.reshape(np.array({},"float64"),{0,2,1}),np.reshape(np.array({},"float64"),{0,2,1})}),{0,2,1},"float64",{})
cases=cases+1
check(np.dstack({np.reshape(np.array({},"float64"),{0,2,1}),np.reshape(np.array({},"float64"),{0,2,1})}),{0,2,2},"float64",{})
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"float64"),{0,2,1}),np.reshape(np.array({},"float64"),{0,2,1})}),{0,4,1},"float64",{})
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"float64"),{0,2,1}),np.reshape(np.array({},"float64"),{0,2,1})}),{0,2,1},"float64",{})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"float64"),{0,2,1}),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}).T}) end),"case 2120 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"float64"),{0,2,1}),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}).T}) end),"case 2121 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"float64"),{0,2,1}),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}).T}) end),"case 2122 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"float64"),{0,2,1}),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}).T}) end),"case 2123 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"float64"),{0,2,1}),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}).T}) end),"case 2124 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"float64"),{0,2,1}),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}).T}) end),"case 2125 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"float64"),{0,2,1}),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}).T}) end),"case 2126 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"float64"),{0,2,1}),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}).T}) end),"case 2127 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"float64"),{0,2,1}),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}).T}) end),"case 2128 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"float64"),{0,2,1}),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,2}).T}) end),"case 2129 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({},"float64"),{0,2,1}).T,np.reshape(np.array({},"float64"),{0,2,1}).T}),{1,4,0},"float64",{{{},{},{},{}}})
cases=cases+1
check(np.vstack({np.reshape(np.array({},"float64"),{0,2,1}).T,np.reshape(np.array({},"float64"),{0,2,1}).T}),{2,2,0},"float64",{{{},{}},{{},{}}})
cases=cases+1
check(np.dstack({np.reshape(np.array({},"float64"),{0,2,1}).T,np.reshape(np.array({},"float64"),{0,2,1}).T}),{1,2,0},"float64",{{{},{}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"float64"),{0,2,1}).T,np.reshape(np.array({},"float64"),{0,2,1}).T}),{1,4,0},"float64",{{{},{},{},{}}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"float64"),{0,2,1}).T,np.reshape(np.array({},"float64"),{0,2,1}).T}),{2,2,0},"float64",{{{},{}},{{},{}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"float64"),{0,2,1}).T,np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2})}) end),"case 2135 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"float64"),{0,2,1}).T,np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2})}) end),"case 2136 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"float64"),{0,2,1}).T,np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2})}) end),"case 2137 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"float64"),{0,2,1}).T,np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2})}) end),"case 2138 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"float64"),{0,2,1}).T,np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2})}) end),"case 2139 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"float64"),{0,2,1}).T,np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3})}) end),"case 2140 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"float64"),{0,2,1}).T,np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3})}) end),"case 2141 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"float64"),{0,2,1}).T,np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3})}) end),"case 2142 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"float64"),{0,2,1}).T,np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3})}) end),"case 2143 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"float64"),{0,2,1}).T,np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3})}) end),"case 2144 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3})}),{1,4,3},"float64",{{{-3.5,-0.5,2.5},{5.5,-4.5,-1.5},{-3.5,-0.5,2.5},{5.5,-4.5,-1.5}}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3})}),{2,2,3},"float64",{{{-3.5,-0.5,2.5},{5.5,-4.5,-1.5}},{{-3.5,-0.5,2.5},{5.5,-4.5,-1.5}}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3})}),{1,2,6},"float64",{{{-3.5,-0.5,2.5,-3.5,-0.5,2.5},{5.5,-4.5,-1.5,5.5,-4.5,-1.5}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3})}),{1,4,3},"float64",{{{-3.5,-0.5,2.5},{5.5,-4.5,-1.5},{-3.5,-0.5,2.5},{5.5,-4.5,-1.5}}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3})}),{2,2,3},"float64",{{{-3.5,-0.5,2.5},{5.5,-4.5,-1.5}},{{-3.5,-0.5,2.5},{5.5,-4.5,-1.5}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),1)}) end),"case 2150 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),1)}) end),"case 2151 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),1)}) end),"case 2152 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),1)}) end),"case 2153 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),1)}) end),"case 2154 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),1)}) end),"case 2155 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),1)}) end),"case 2156 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),1)}) end),"case 2157 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),1)}) end),"case 2158 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}),1)}) end),"case 2159 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),1),np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),1)}),{1,4,3},"float64",{{{-3.5,-0.5,2.5},{5.5,-4.5,-1.5},{-3.5,-0.5,2.5},{5.5,-4.5,-1.5}}})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),1),np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),1)}),{2,2,3},"float64",{{{-3.5,-0.5,2.5},{5.5,-4.5,-1.5}},{{-3.5,-0.5,2.5},{5.5,-4.5,-1.5}}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),1),np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),1)}),{1,2,6},"float64",{{{-3.5,-0.5,2.5,-3.5,-0.5,2.5},{5.5,-4.5,-1.5,5.5,-4.5,-1.5}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),1),np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),1)}),{1,4,3},"float64",{{{-3.5,-0.5,2.5},{5.5,-4.5,-1.5},{-3.5,-0.5,2.5},{5.5,-4.5,-1.5}}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),1),np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),1)}),{2,2,3},"float64",{{{-3.5,-0.5,2.5},{5.5,-4.5,-1.5}},{{-3.5,-0.5,2.5},{5.5,-4.5,-1.5}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),1),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}).T}) end),"case 2165 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),1),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}).T}) end),"case 2166 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),1),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}).T}) end),"case 2167 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),1),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}).T}) end),"case 2168 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),1),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}).T}) end),"case 2169 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),1),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}).T}) end),"case 2170 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),1),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}).T}) end),"case 2171 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),1),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}).T}) end),"case 2172 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),1),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}).T}) end),"case 2173 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),1),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5},"float64"),{2,3}).T}) end),"case 2174 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}).T,np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}).T}),{3,4,1},"float64",{{{-3.5},{5.5},{-3.5},{5.5}},{{-0.5},{-4.5},{-0.5},{-4.5}},{{2.5},{-1.5},{2.5},{-1.5}}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}).T,np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}).T}),{6,2,1},"float64",{{{-3.5},{5.5}},{{-0.5},{-4.5}},{{2.5},{-1.5}},{{-3.5},{5.5}},{{-0.5},{-4.5}},{{2.5},{-1.5}}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}).T,np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}).T}),{3,2,2},"float64",{{{-3.5,-3.5},{5.5,5.5}},{{-0.5,-0.5},{-4.5,-4.5}},{{2.5,2.5},{-1.5,-1.5}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}).T,np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}).T}),{3,4,1},"float64",{{{-3.5},{5.5},{-3.5},{5.5}},{{-0.5},{-4.5},{-0.5},{-4.5}},{{2.5},{-1.5},{2.5},{-1.5}}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}).T,np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}).T}),{6,2,1},"float64",{{{-3.5},{5.5}},{{-0.5},{-4.5}},{{2.5},{-1.5}},{{-3.5},{5.5}},{{-0.5},{-4.5}},{{2.5},{-1.5}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}).T,np.reshape(np.array({-4.5},"float64"),{})}) end),"case 2180 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}).T,np.reshape(np.array({-4.5},"float64"),{})}) end),"case 2181 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}).T,np.reshape(np.array({-4.5},"float64"),{})}) end),"case 2182 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}).T,np.reshape(np.array({-4.5},"float64"),{})}) end),"case 2183 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}).T,np.reshape(np.array({-4.5},"float64"),{})}) end),"case 2184 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}).T,np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2})}) end),"case 2185 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}).T,np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2})}) end),"case 2186 expected failure")
cases=cases+1
check(np.dstack({np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}).T,np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2})}),{3,2,2},"float64",{{{-3.5,-1.5},{5.5,1.5}},{{-0.5,4.5},{-4.5,-5.5}},{{2.5,-2.5},{-1.5,0.5}}})
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}).T,np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2})}) end),"case 2188 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}).T,np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2})}) end),"case 2189 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2})}),{2,2,2},"float64",{{{-0.5,2.5},{-0.5,2.5}},{{5.5,-4.5},{5.5,-4.5}}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2})}),{4,1,2},"float64",{{{-0.5,2.5}},{{5.5,-4.5}},{{-0.5,2.5}},{{5.5,-4.5}}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2})}),{2,1,4},"float64",{{{-0.5,2.5,-0.5,2.5}},{{5.5,-4.5,5.5,-4.5}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2})}),{2,2,2},"float64",{{{-0.5,2.5},{-0.5,2.5}},{{5.5,-4.5},{5.5,-4.5}}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2})}),{4,1,2},"float64",{{{-0.5,2.5}},{{5.5,-4.5}},{{-0.5,2.5}},{{5.5,-4.5}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),np.reshape(np.array({},"float64"),{0})}) end),"case 2195 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),np.reshape(np.array({},"float64"),{0})}) end),"case 2196 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),np.reshape(np.array({},"float64"),{0})}) end),"case 2197 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),np.reshape(np.array({},"float64"),{0})}) end),"case 2198 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),np.reshape(np.array({},"float64"),{0})}) end),"case 2199 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),np.flip(np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),1)}) end),"case 2200 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),np.flip(np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),1)}) end),"case 2201 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),np.flip(np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),1)}) end),"case 2202 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),np.flip(np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),1)}) end),"case 2203 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),np.flip(np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}),1)}) end),"case 2204 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),1),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),1)}),{2,2,2},"float64",{{{5.5,-4.5},{5.5,-4.5}},{{-0.5,2.5},{-0.5,2.5}}})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),1),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),1)}),{4,1,2},"float64",{{{5.5,-4.5}},{{-0.5,2.5}},{{5.5,-4.5}},{{-0.5,2.5}}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),1),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),1)}),{2,1,4},"float64",{{{5.5,-4.5,5.5,-4.5}},{{-0.5,2.5,-0.5,2.5}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),1),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),1)}),{2,2,2},"float64",{{{5.5,-4.5},{5.5,-4.5}},{{-0.5,2.5},{-0.5,2.5}}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),1),np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),1)}),{4,1,2},"float64",{{{5.5,-4.5}},{{-0.5,2.5}},{{5.5,-4.5}},{{-0.5,2.5}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),1),np.reshape(np.array({-2.5},"float64"),{1})}) end),"case 2210 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),1),np.reshape(np.array({-2.5},"float64"),{1})}) end),"case 2211 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),1),np.reshape(np.array({-2.5},"float64"),{1})}) end),"case 2212 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),1),np.reshape(np.array({-2.5},"float64"),{1})}) end),"case 2213 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),1),np.reshape(np.array({-2.5},"float64"),{1})}) end),"case 2214 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),1),np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}).T}) end),"case 2215 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),1),np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}).T}) end),"case 2216 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),1),np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}).T}) end),"case 2217 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),1),np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}).T}) end),"case 2218 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}),1),np.reshape(np.array({-1.5,1.5,4.5,-5.5,-2.5,0.5},"float64"),{3,2}).T}) end),"case 2219 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}).T,np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}).T}),{2,2,2},"float64",{{{-0.5,5.5},{-0.5,5.5}},{{2.5,-4.5},{2.5,-4.5}}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}).T,np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}).T}),{4,1,2},"float64",{{{-0.5,5.5}},{{2.5,-4.5}},{{-0.5,5.5}},{{2.5,-4.5}}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}).T,np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}).T}),{2,1,4},"float64",{{{-0.5,5.5,-0.5,5.5}},{{2.5,-4.5,2.5,-4.5}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}).T,np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}).T}),{2,2,2},"float64",{{{-0.5,5.5},{-0.5,5.5}},{{2.5,-4.5},{2.5,-4.5}}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}).T,np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}).T}),{4,1,2},"float64",{{{-0.5,5.5}},{{2.5,-4.5}},{{-0.5,5.5}},{{2.5,-4.5}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}).T,np.flip(np.reshape(np.array({-2.5},"float64"),{1}),1)}) end),"case 2225 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}).T,np.flip(np.reshape(np.array({-2.5},"float64"),{1}),1)}) end),"case 2226 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}).T,np.flip(np.reshape(np.array({-2.5},"float64"),{1}),1)}) end),"case 2227 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}).T,np.flip(np.reshape(np.array({-2.5},"float64"),{1}),1)}) end),"case 2228 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}).T,np.flip(np.reshape(np.array({-2.5},"float64"),{1}),1)}) end),"case 2229 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}).T,np.reshape(np.array({},"float64"),{0,2,1})}) end),"case 2230 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}).T,np.reshape(np.array({},"float64"),{0,2,1})}) end),"case 2231 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}).T,np.reshape(np.array({},"float64"),{0,2,1})}) end),"case 2232 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}).T,np.reshape(np.array({},"float64"),{0,2,1})}) end),"case 2233 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-0.5,2.5,5.5,-4.5},"float64"),{2,1,2}).T,np.reshape(np.array({},"float64"),{0,2,1})}) end),"case 2234 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2})}),{2,4,2},"float64",{{{-4.5,-1.5},{1.5,4.5},{-4.5,-1.5},{1.5,4.5}},{{-5.5,-2.5},{0.5,3.5},{-5.5,-2.5},{0.5,3.5}}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2})}),{4,2,2},"float64",{{{-4.5,-1.5},{1.5,4.5}},{{-5.5,-2.5},{0.5,3.5}},{{-4.5,-1.5},{1.5,4.5}},{{-5.5,-2.5},{0.5,3.5}}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2})}),{2,2,4},"float64",{{{-4.5,-1.5,-4.5,-1.5},{1.5,4.5,1.5,4.5}},{{-5.5,-2.5,-5.5,-2.5},{0.5,3.5,0.5,3.5}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2})}),{2,4,2},"float64",{{{-4.5,-1.5},{1.5,4.5},{-4.5,-1.5},{1.5,4.5}},{{-5.5,-2.5},{0.5,3.5},{-5.5,-2.5},{0.5,3.5}}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2})}),{4,2,2},"float64",{{{-4.5,-1.5},{1.5,4.5}},{{-5.5,-2.5},{0.5,3.5}},{{-4.5,-1.5},{1.5,4.5}},{{-5.5,-2.5},{0.5,3.5}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),np.reshape(np.array({-0.5,2.5},"float64"),{2})}) end),"case 2240 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),np.reshape(np.array({-0.5,2.5},"float64"),{2})}) end),"case 2241 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),np.reshape(np.array({-0.5,2.5},"float64"),{2})}) end),"case 2242 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),np.reshape(np.array({-0.5,2.5},"float64"),{2})}) end),"case 2243 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),np.reshape(np.array({-0.5,2.5},"float64"),{2})}) end),"case 2244 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),np.reshape(np.array({},"float64"),{0,2,1}).T}) end),"case 2245 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),np.reshape(np.array({},"float64"),{0,2,1}).T}) end),"case 2246 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),np.reshape(np.array({},"float64"),{0,2,1}).T}) end),"case 2247 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),np.reshape(np.array({},"float64"),{0,2,1}).T}) end),"case 2248 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),np.reshape(np.array({},"float64"),{0,2,1}).T}) end),"case 2249 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),1),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),1)}),{2,4,2},"float64",{{{-5.5,-2.5},{0.5,3.5},{-5.5,-2.5},{0.5,3.5}},{{-4.5,-1.5},{1.5,4.5},{-4.5,-1.5},{1.5,4.5}}})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),1),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),1)}),{4,2,2},"float64",{{{-5.5,-2.5},{0.5,3.5}},{{-4.5,-1.5},{1.5,4.5}},{{-5.5,-2.5},{0.5,3.5}},{{-4.5,-1.5},{1.5,4.5}}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),1),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),1)}),{2,2,4},"float64",{{{-5.5,-2.5,-5.5,-2.5},{0.5,3.5,0.5,3.5}},{{-4.5,-1.5,-4.5,-1.5},{1.5,4.5,1.5,4.5}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),1),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),1)}),{2,4,2},"float64",{{{-5.5,-2.5},{0.5,3.5},{-5.5,-2.5},{0.5,3.5}},{{-4.5,-1.5},{1.5,4.5},{-4.5,-1.5},{1.5,4.5}}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),1),np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),1)}),{4,2,2},"float64",{{{-5.5,-2.5},{0.5,3.5}},{{-4.5,-1.5},{1.5,4.5}},{{-5.5,-2.5},{0.5,3.5}},{{-4.5,-1.5},{1.5,4.5}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),1),np.flip(np.reshape(np.array({-0.5,2.5},"float64"),{2}),1)}) end),"case 2255 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),1),np.flip(np.reshape(np.array({-0.5,2.5},"float64"),{2}),1)}) end),"case 2256 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),1),np.flip(np.reshape(np.array({-0.5,2.5},"float64"),{2}),1)}) end),"case 2257 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),1),np.flip(np.reshape(np.array({-0.5,2.5},"float64"),{2}),1)}) end),"case 2258 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),1),np.flip(np.reshape(np.array({-0.5,2.5},"float64"),{2}),1)}) end),"case 2259 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),1),np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3})}) end),"case 2260 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),1),np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3})}) end),"case 2261 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),1),np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3})}) end),"case 2262 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),1),np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3})}) end),"case 2263 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}),1),np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3})}) end),"case 2264 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}).T,np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}).T}),{2,4,2},"float64",{{{-4.5,-5.5},{1.5,0.5},{-4.5,-5.5},{1.5,0.5}},{{-1.5,-2.5},{4.5,3.5},{-1.5,-2.5},{4.5,3.5}}})
cases=cases+1
check(np.vstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}).T,np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}).T}),{4,2,2},"float64",{{{-4.5,-5.5},{1.5,0.5}},{{-1.5,-2.5},{4.5,3.5}},{{-4.5,-5.5},{1.5,0.5}},{{-1.5,-2.5},{4.5,3.5}}})
cases=cases+1
check(np.dstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}).T,np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}).T}),{2,2,4},"float64",{{{-4.5,-5.5,-4.5,-5.5},{1.5,0.5,1.5,0.5}},{{-1.5,-2.5,-1.5,-2.5},{4.5,3.5,4.5,3.5}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}).T,np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}).T}),{2,4,2},"float64",{{{-4.5,-5.5},{1.5,0.5},{-4.5,-5.5},{1.5,0.5}},{{-1.5,-2.5},{4.5,3.5},{-1.5,-2.5},{4.5,3.5}}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}).T,np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}).T}),{4,2,2},"float64",{{{-4.5,-5.5},{1.5,0.5}},{{-1.5,-2.5},{4.5,3.5}},{{-4.5,-5.5},{1.5,0.5}},{{-1.5,-2.5},{4.5,3.5}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}).T,np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3})}) end),"case 2270 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}).T,np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3})}) end),"case 2271 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}).T,np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3})}) end),"case 2272 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}).T,np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3})}) end),"case 2273 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}).T,np.reshape(np.array({-5.5,-2.5,0.5},"float64"),{3})}) end),"case 2274 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}).T,np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),1)}) end),"case 2275 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}).T,np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),1)}) end),"case 2276 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}).T,np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),1)}) end),"case 2277 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}).T,np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),1)}) end),"case 2278 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({-4.5,-1.5,1.5,4.5,-5.5,-2.5,0.5,3.5},"float64"),{2,2,2}).T,np.flip(np.reshape(np.array({-3.5,-0.5,2.5,5.5,-4.5,-1.5},"float64"),{1,2,3}),1)}) end),"case 2279 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({"é"},"U2"),{}),np.reshape(np.array({"é"},"U2"),{})}),{2},"<U2",{"é","é"})
cases=cases+1
check(np.vstack({np.reshape(np.array({"é"},"U2"),{}),np.reshape(np.array({"é"},"U2"),{})}),{2,1},"<U2",{{"é"},{"é"}})
cases=cases+1
check(np.dstack({np.reshape(np.array({"é"},"U2"),{}),np.reshape(np.array({"é"},"U2"),{})}),{1,1,2},"<U2",{{{"é","é"}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({"é"},"U2"),{}),np.reshape(np.array({"é"},"U2"),{})}),{1,2},"<U2",{{"é","é"}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({"é"},"U2"),{}),np.reshape(np.array({"é"},"U2"),{})}),{2,1},"<U2",{{"é"},{"é"}})
cases=cases+1
check(np.hstack({np.reshape(np.array({"é"},"U2"),{}),np.flip(np.reshape(np.array({"B","é","界"},"U2"),{3}),1)}),{4},"<U2",{"é","界","é","B"})
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({"é"},"U2"),{}),np.flip(np.reshape(np.array({"B","é","界"},"U2"),{3}),1)}) end),"case 2286 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({"é"},"U2"),{}),np.flip(np.reshape(np.array({"B","é","界"},"U2"),{3}),1)}) end),"case 2287 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({"é"},"U2"),{}),np.flip(np.reshape(np.array({"B","é","界"},"U2"),{3}),1)}) end),"case 2288 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({"é"},"U2"),{}),np.flip(np.reshape(np.array({"B","é","界"},"U2"),{3}),1)}) end),"case 2289 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({"é"},"U2"),{}),np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}).T}) end),"case 2290 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({"é"},"U2"),{}),np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}).T}) end),"case 2291 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({"é"},"U2"),{}),np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}).T}) end),"case 2292 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({"é"},"U2"),{}),np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}).T}) end),"case 2293 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({"é"},"U2"),{}),np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}).T}) end),"case 2294 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({},"U2"),{0}),np.reshape(np.array({},"U2"),{0})}),{0},"<U2",{})
cases=cases+1
check(np.vstack({np.reshape(np.array({},"U2"),{0}),np.reshape(np.array({},"U2"),{0})}),{2,0},"<U2",{{},{}})
cases=cases+1
check(np.dstack({np.reshape(np.array({},"U2"),{0}),np.reshape(np.array({},"U2"),{0})}),{1,0,2},"<U2",{{}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"U2"),{0}),np.reshape(np.array({},"U2"),{0})}),{0,2},"<U2",{})
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"U2"),{0}),np.reshape(np.array({},"U2"),{0})}),{2,0},"<U2",{{},{}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"U2"),{0}),np.reshape(np.array({},"U2"),{0,2})}) end),"case 2300 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"U2"),{0}),np.reshape(np.array({},"U2"),{0,2})}) end),"case 2301 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"U2"),{0}),np.reshape(np.array({},"U2"),{0,2})}) end),"case 2302 expected failure")
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"U2"),{0}),np.reshape(np.array({},"U2"),{0,2})}),{0,3},"<U2",{})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"U2"),{0}),np.reshape(np.array({},"U2"),{0,2})}) end),"case 2304 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"U2"),{0}),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2})}) end),"case 2305 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"U2"),{0}),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2})}) end),"case 2306 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"U2"),{0}),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2})}) end),"case 2307 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"U2"),{0}),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2})}) end),"case 2308 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"U2"),{0}),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2})}) end),"case 2309 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({"東"},"U2"),{1}),np.reshape(np.array({"東"},"U2"),{1})}),{2},"<U2",{"東","東"})
cases=cases+1
check(np.vstack({np.reshape(np.array({"東"},"U2"),{1}),np.reshape(np.array({"東"},"U2"),{1})}),{2,1},"<U2",{{"東"},{"東"}})
cases=cases+1
check(np.dstack({np.reshape(np.array({"東"},"U2"),{1}),np.reshape(np.array({"東"},"U2"),{1})}),{1,1,2},"<U2",{{{"東","東"}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({"東"},"U2"),{1}),np.reshape(np.array({"東"},"U2"),{1})}),{1,2},"<U2",{{"東","東"}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({"東"},"U2"),{1}),np.reshape(np.array({"東"},"U2"),{1})}),{2,1},"<U2",{{"東"},{"東"}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({"東"},"U2"),{1}),np.reshape(np.array({},"U2"),{0,2}).T}) end),"case 2315 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({"東"},"U2"),{1}),np.reshape(np.array({},"U2"),{0,2}).T}) end),"case 2316 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({"東"},"U2"),{1}),np.reshape(np.array({},"U2"),{0,2}).T}) end),"case 2317 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({"東"},"U2"),{1}),np.reshape(np.array({},"U2"),{0,2}).T}) end),"case 2318 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({"東"},"U2"),{1}),np.reshape(np.array({},"U2"),{0,2}).T}) end),"case 2319 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({"東"},"U2"),{1}),np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),1)}) end),"case 2320 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({"東"},"U2"),{1}),np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),1)}) end),"case 2321 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({"東"},"U2"),{1}),np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),1)}) end),"case 2322 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({"東"},"U2"),{1}),np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),1)}) end),"case 2323 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({"東"},"U2"),{1}),np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),1)}) end),"case 2324 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({"東"},"U2"),{1}),1),np.flip(np.reshape(np.array({"東"},"U2"),{1}),1)}),{2},"<U2",{"東","東"})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({"東"},"U2"),{1}),1),np.flip(np.reshape(np.array({"東"},"U2"),{1}),1)}),{2,1},"<U2",{{"東"},{"東"}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({"東"},"U2"),{1}),1),np.flip(np.reshape(np.array({"東"},"U2"),{1}),1)}),{1,1,2},"<U2",{{{"東","東"}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({"東"},"U2"),{1}),1),np.flip(np.reshape(np.array({"東"},"U2"),{1}),1)}),{1,2},"<U2",{{"東","東"}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({"東"},"U2"),{1}),1),np.flip(np.reshape(np.array({"東"},"U2"),{1}),1)}),{2,1},"<U2",{{"東"},{"東"}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({"東"},"U2"),{1}),1),np.reshape(np.array({},"U2"),{2,0})}) end),"case 2330 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({"東"},"U2"),{1}),1),np.reshape(np.array({},"U2"),{2,0})}) end),"case 2331 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({"東"},"U2"),{1}),1),np.reshape(np.array({},"U2"),{2,0})}) end),"case 2332 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({"東"},"U2"),{1}),1),np.reshape(np.array({},"U2"),{2,0})}) end),"case 2333 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({"東"},"U2"),{1}),1),np.reshape(np.array({},"U2"),{2,0})}) end),"case 2334 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({"東"},"U2"),{1}),1),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}).T}) end),"case 2335 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({"東"},"U2"),{1}),1),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}).T}) end),"case 2336 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({"東"},"U2"),{1}),1),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}).T}) end),"case 2337 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({"東"},"U2"),{1}),1),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}).T}) end),"case 2338 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({"東"},"U2"),{1}),1),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}).T}) end),"case 2339 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({"A","ñ"},"U2"),{2}),np.reshape(np.array({"A","ñ"},"U2"),{2})}),{4},"<U2",{"A","ñ","A","ñ"})
cases=cases+1
check(np.vstack({np.reshape(np.array({"A","ñ"},"U2"),{2}),np.reshape(np.array({"A","ñ"},"U2"),{2})}),{2,2},"<U2",{{"A","ñ"},{"A","ñ"}})
cases=cases+1
check(np.dstack({np.reshape(np.array({"A","ñ"},"U2"),{2}),np.reshape(np.array({"A","ñ"},"U2"),{2})}),{1,2,2},"<U2",{{{"A","A"},{"ñ","ñ"}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({"A","ñ"},"U2"),{2}),np.reshape(np.array({"A","ñ"},"U2"),{2})}),{2,2},"<U2",{{"A","A"},{"ñ","ñ"}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({"A","ñ"},"U2"),{2}),np.reshape(np.array({"A","ñ"},"U2"),{2})}),{2,2},"<U2",{{"A","ñ"},{"A","ñ"}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({"A","ñ"},"U2"),{2}),np.reshape(np.array({},"U2"),{2,0}).T}) end),"case 2345 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({"A","ñ"},"U2"),{2}),np.reshape(np.array({},"U2"),{2,0}).T}),{1,2},"<U2",{{"A","ñ"}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({"A","ñ"},"U2"),{2}),np.reshape(np.array({},"U2"),{2,0}).T}) end),"case 2347 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({"A","ñ"},"U2"),{2}),np.reshape(np.array({},"U2"),{2,0}).T}) end),"case 2348 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({"A","ñ"},"U2"),{2}),np.reshape(np.array({},"U2"),{2,0}).T}),{1,2},"<U2",{{"A","ñ"}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({"A","ñ"},"U2"),{2}),np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2})}) end),"case 2350 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({"A","ñ"},"U2"),{2}),np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2})}) end),"case 2351 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({"A","ñ"},"U2"),{2}),np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2})}) end),"case 2352 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({"A","ñ"},"U2"),{2}),np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2})}) end),"case 2353 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({"A","ñ"},"U2"),{2}),np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2})}) end),"case 2354 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({"A","ñ"},"U2"),{2}),1),np.flip(np.reshape(np.array({"A","ñ"},"U2"),{2}),1)}),{4},"<U2",{"ñ","A","ñ","A"})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({"A","ñ"},"U2"),{2}),1),np.flip(np.reshape(np.array({"A","ñ"},"U2"),{2}),1)}),{2,2},"<U2",{{"ñ","A"},{"ñ","A"}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({"A","ñ"},"U2"),{2}),1),np.flip(np.reshape(np.array({"A","ñ"},"U2"),{2}),1)}),{1,2,2},"<U2",{{{"ñ","ñ"},{"A","A"}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({"A","ñ"},"U2"),{2}),1),np.flip(np.reshape(np.array({"A","ñ"},"U2"),{2}),1)}),{2,2},"<U2",{{"ñ","ñ"},{"A","A"}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({"A","ñ"},"U2"),{2}),1),np.flip(np.reshape(np.array({"A","ñ"},"U2"),{2}),1)}),{2,2},"<U2",{{"ñ","A"},{"ñ","A"}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({"A","ñ"},"U2"),{2}),1),np.reshape(np.array({"ñ","B"},"U2"),{1,2})}) end),"case 2360 expected failure")
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({"A","ñ"},"U2"),{2}),1),np.reshape(np.array({"ñ","B"},"U2"),{1,2})}),{2,2},"<U2",{{"ñ","A"},{"ñ","B"}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({"A","ñ"},"U2"),{2}),1),np.reshape(np.array({"ñ","B"},"U2"),{1,2})}),{1,2,2},"<U2",{{{"ñ","ñ"},{"A","B"}}})
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({"A","ñ"},"U2"),{2}),1),np.reshape(np.array({"ñ","B"},"U2"),{1,2})}) end),"case 2363 expected failure")
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({"A","ñ"},"U2"),{2}),1),np.reshape(np.array({"ñ","B"},"U2"),{1,2})}),{2,2},"<U2",{{"ñ","A"},{"ñ","B"}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({"A","ñ"},"U2"),{2}),1),np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),1)}) end),"case 2365 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({"A","ñ"},"U2"),{2}),1),np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),1)}) end),"case 2366 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({"A","ñ"},"U2"),{2}),1),np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),1)}) end),"case 2367 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({"A","ñ"},"U2"),{2}),1),np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),1)}) end),"case 2368 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({"A","ñ"},"U2"),{2}),1),np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),1)}) end),"case 2369 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({"B","é","界"},"U2"),{3}),np.reshape(np.array({"B","é","界"},"U2"),{3})}),{6},"<U2",{"B","é","界","B","é","界"})
cases=cases+1
check(np.vstack({np.reshape(np.array({"B","é","界"},"U2"),{3}),np.reshape(np.array({"B","é","界"},"U2"),{3})}),{2,3},"<U2",{{"B","é","界"},{"B","é","界"}})
cases=cases+1
check(np.dstack({np.reshape(np.array({"B","é","界"},"U2"),{3}),np.reshape(np.array({"B","é","界"},"U2"),{3})}),{1,3,2},"<U2",{{{"B","B"},{"é","é"},{"界","界"}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({"B","é","界"},"U2"),{3}),np.reshape(np.array({"B","é","界"},"U2"),{3})}),{3,2},"<U2",{{"B","B"},{"é","é"},{"界","界"}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({"B","é","界"},"U2"),{3}),np.reshape(np.array({"B","é","界"},"U2"),{3})}),{2,3},"<U2",{{"B","é","界"},{"B","é","界"}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({"B","é","界"},"U2"),{3}),np.flip(np.reshape(np.array({"ñ","B"},"U2"),{1,2}),1)}) end),"case 2375 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({"B","é","界"},"U2"),{3}),np.flip(np.reshape(np.array({"ñ","B"},"U2"),{1,2}),1)}) end),"case 2376 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({"B","é","界"},"U2"),{3}),np.flip(np.reshape(np.array({"ñ","B"},"U2"),{1,2}),1)}) end),"case 2377 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({"B","é","界"},"U2"),{3}),np.flip(np.reshape(np.array({"ñ","B"},"U2"),{1,2}),1)}) end),"case 2378 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({"B","é","界"},"U2"),{3}),np.flip(np.reshape(np.array({"ñ","B"},"U2"),{1,2}),1)}) end),"case 2379 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({"B","é","界"},"U2"),{3}),np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}).T}) end),"case 2380 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({"B","é","界"},"U2"),{3}),np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}).T}) end),"case 2381 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({"B","é","界"},"U2"),{3}),np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}).T}) end),"case 2382 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({"B","é","界"},"U2"),{3}),np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}).T}) end),"case 2383 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({"B","é","界"},"U2"),{3}),np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}).T}) end),"case 2384 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({"B","é","界"},"U2"),{3}),1),np.flip(np.reshape(np.array({"B","é","界"},"U2"),{3}),1)}),{6},"<U2",{"界","é","B","界","é","B"})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({"B","é","界"},"U2"),{3}),1),np.flip(np.reshape(np.array({"B","é","界"},"U2"),{3}),1)}),{2,3},"<U2",{{"界","é","B"},{"界","é","B"}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({"B","é","界"},"U2"),{3}),1),np.flip(np.reshape(np.array({"B","é","界"},"U2"),{3}),1)}),{1,3,2},"<U2",{{{"界","界"},{"é","é"},{"B","B"}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({"B","é","界"},"U2"),{3}),1),np.flip(np.reshape(np.array({"B","é","界"},"U2"),{3}),1)}),{3,2},"<U2",{{"界","界"},{"é","é"},{"B","B"}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({"B","é","界"},"U2"),{3}),1),np.flip(np.reshape(np.array({"B","é","界"},"U2"),{3}),1)}),{2,3},"<U2",{{"界","é","B"},{"界","é","B"}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({"B","é","界"},"U2"),{3}),1),np.reshape(np.array({"ñ","B"},"U2"),{1,2}).T}) end),"case 2390 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({"B","é","界"},"U2"),{3}),1),np.reshape(np.array({"ñ","B"},"U2"),{1,2}).T}) end),"case 2391 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({"B","é","界"},"U2"),{3}),1),np.reshape(np.array({"ñ","B"},"U2"),{1,2}).T}) end),"case 2392 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({"B","é","界"},"U2"),{3}),1),np.reshape(np.array({"ñ","B"},"U2"),{1,2}).T}) end),"case 2393 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({"B","é","界"},"U2"),{3}),1),np.reshape(np.array({"ñ","B"},"U2"),{1,2}).T}) end),"case 2394 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({"B","é","界"},"U2"),{3}),1),np.reshape(np.array({"é"},"U2"),{})}),{4},"<U2",{"界","é","B","é"})
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({"B","é","界"},"U2"),{3}),1),np.reshape(np.array({"é"},"U2"),{})}) end),"case 2396 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({"B","é","界"},"U2"),{3}),1),np.reshape(np.array({"é"},"U2"),{})}) end),"case 2397 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({"B","é","界"},"U2"),{3}),1),np.reshape(np.array({"é"},"U2"),{})}) end),"case 2398 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({"B","é","界"},"U2"),{3}),1),np.reshape(np.array({"é"},"U2"),{})}) end),"case 2399 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({},"U2"),{0,2}),np.reshape(np.array({},"U2"),{0,2})}),{0,4},"<U2",{})
cases=cases+1
check(np.vstack({np.reshape(np.array({},"U2"),{0,2}),np.reshape(np.array({},"U2"),{0,2})}),{0,2},"<U2",{})
cases=cases+1
check(np.dstack({np.reshape(np.array({},"U2"),{0,2}),np.reshape(np.array({},"U2"),{0,2})}),{0,2,2},"<U2",{})
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"U2"),{0,2}),np.reshape(np.array({},"U2"),{0,2})}),{0,4},"<U2",{})
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"U2"),{0,2}),np.reshape(np.array({},"U2"),{0,2})}),{0,2},"<U2",{})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"U2"),{0,2}),np.reshape(np.array({"界","東"},"U2"),{2,1})}) end),"case 2405 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"U2"),{0,2}),np.reshape(np.array({"界","東"},"U2"),{2,1})}) end),"case 2406 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"U2"),{0,2}),np.reshape(np.array({"界","東"},"U2"),{2,1})}) end),"case 2407 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"U2"),{0,2}),np.reshape(np.array({"界","東"},"U2"),{2,1})}) end),"case 2408 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"U2"),{0,2}),np.reshape(np.array({"界","東"},"U2"),{2,1})}) end),"case 2409 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"U2"),{0,2}),np.reshape(np.array({},"U2"),{0})}) end),"case 2410 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"U2"),{0,2}),np.reshape(np.array({},"U2"),{0})}) end),"case 2411 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"U2"),{0,2}),np.reshape(np.array({},"U2"),{0})}) end),"case 2412 expected failure")
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"U2"),{0,2}),np.reshape(np.array({},"U2"),{0})}),{0,3},"<U2",{})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"U2"),{0,2}),np.reshape(np.array({},"U2"),{0})}) end),"case 2414 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({},"U2"),{0,2}).T,np.reshape(np.array({},"U2"),{0,2}).T}),{2,0},"<U2",{{},{}})
cases=cases+1
check(np.vstack({np.reshape(np.array({},"U2"),{0,2}).T,np.reshape(np.array({},"U2"),{0,2}).T}),{4,0},"<U2",{{},{},{},{}})
cases=cases+1
check(np.dstack({np.reshape(np.array({},"U2"),{0,2}).T,np.reshape(np.array({},"U2"),{0,2}).T}),{2,0,2},"<U2",{{},{}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"U2"),{0,2}).T,np.reshape(np.array({},"U2"),{0,2}).T}),{2,0},"<U2",{{},{}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"U2"),{0,2}).T,np.reshape(np.array({},"U2"),{0,2}).T}),{4,0},"<U2",{{},{},{},{}})
cases=cases+1
check(np.hstack({np.reshape(np.array({},"U2"),{0,2}).T,np.flip(np.reshape(np.array({"界","東"},"U2"),{2,1}),1)}),{2,1},"<U2",{{"東"},{"界"}})
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"U2"),{0,2}).T,np.flip(np.reshape(np.array({"界","東"},"U2"),{2,1}),1)}) end),"case 2421 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"U2"),{0,2}).T,np.flip(np.reshape(np.array({"界","東"},"U2"),{2,1}),1)}) end),"case 2422 expected failure")
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"U2"),{0,2}).T,np.flip(np.reshape(np.array({"界","東"},"U2"),{2,1}),1)}),{2,1},"<U2",{{"東"},{"界"}})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"U2"),{0,2}).T,np.flip(np.reshape(np.array({"界","東"},"U2"),{2,1}),1)}) end),"case 2424 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"U2"),{0,2}).T,np.reshape(np.array({"東"},"U2"),{1})}) end),"case 2425 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"U2"),{0,2}).T,np.reshape(np.array({"東"},"U2"),{1})}) end),"case 2426 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"U2"),{0,2}).T,np.reshape(np.array({"東"},"U2"),{1})}) end),"case 2427 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"U2"),{0,2}).T,np.reshape(np.array({"東"},"U2"),{1})}) end),"case 2428 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"U2"),{0,2}).T,np.reshape(np.array({"東"},"U2"),{1})}) end),"case 2429 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({},"U2"),{2,0}),np.reshape(np.array({},"U2"),{2,0})}),{2,0},"<U2",{{},{}})
cases=cases+1
check(np.vstack({np.reshape(np.array({},"U2"),{2,0}),np.reshape(np.array({},"U2"),{2,0})}),{4,0},"<U2",{{},{},{},{}})
cases=cases+1
check(np.dstack({np.reshape(np.array({},"U2"),{2,0}),np.reshape(np.array({},"U2"),{2,0})}),{2,0,2},"<U2",{{},{}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"U2"),{2,0}),np.reshape(np.array({},"U2"),{2,0})}),{2,0},"<U2",{{},{}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"U2"),{2,0}),np.reshape(np.array({},"U2"),{2,0})}),{4,0},"<U2",{{},{},{},{}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"U2"),{2,0}),np.reshape(np.array({"界","東"},"U2"),{2,1}).T}) end),"case 2435 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"U2"),{2,0}),np.reshape(np.array({"界","東"},"U2"),{2,1}).T}) end),"case 2436 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"U2"),{2,0}),np.reshape(np.array({"界","東"},"U2"),{2,1}).T}) end),"case 2437 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"U2"),{2,0}),np.reshape(np.array({"界","東"},"U2"),{2,1}).T}) end),"case 2438 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"U2"),{2,0}),np.reshape(np.array({"界","東"},"U2"),{2,1}).T}) end),"case 2439 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"U2"),{2,0}),np.flip(np.reshape(np.array({"東"},"U2"),{1}),1)}) end),"case 2440 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"U2"),{2,0}),np.flip(np.reshape(np.array({"東"},"U2"),{1}),1)}) end),"case 2441 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"U2"),{2,0}),np.flip(np.reshape(np.array({"東"},"U2"),{1}),1)}) end),"case 2442 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"U2"),{2,0}),np.flip(np.reshape(np.array({"東"},"U2"),{1}),1)}) end),"case 2443 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"U2"),{2,0}),np.flip(np.reshape(np.array({"東"},"U2"),{1}),1)}) end),"case 2444 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({},"U2"),{2,0}).T,np.reshape(np.array({},"U2"),{2,0}).T}),{0,4},"<U2",{})
cases=cases+1
check(np.vstack({np.reshape(np.array({},"U2"),{2,0}).T,np.reshape(np.array({},"U2"),{2,0}).T}),{0,2},"<U2",{})
cases=cases+1
check(np.dstack({np.reshape(np.array({},"U2"),{2,0}).T,np.reshape(np.array({},"U2"),{2,0}).T}),{0,2,2},"<U2",{})
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"U2"),{2,0}).T,np.reshape(np.array({},"U2"),{2,0}).T}),{0,4},"<U2",{})
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"U2"),{2,0}).T,np.reshape(np.array({},"U2"),{2,0}).T}),{0,2},"<U2",{})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"U2"),{2,0}).T,np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2})}) end),"case 2450 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({},"U2"),{2,0}).T,np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2})}),{2,2},"<U2",{{"A","ñ"},{"B","é"}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"U2"),{2,0}).T,np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2})}) end),"case 2452 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"U2"),{2,0}).T,np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2})}) end),"case 2453 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"U2"),{2,0}).T,np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2})}),{2,2},"<U2",{{"A","ñ"},{"B","é"}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"U2"),{2,0}).T,np.reshape(np.array({"A","ñ"},"U2"),{2})}) end),"case 2455 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({},"U2"),{2,0}).T,np.reshape(np.array({"A","ñ"},"U2"),{2})}),{1,2},"<U2",{{"A","ñ"}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"U2"),{2,0}).T,np.reshape(np.array({"A","ñ"},"U2"),{2})}) end),"case 2457 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"U2"),{2,0}).T,np.reshape(np.array({"A","ñ"},"U2"),{2})}) end),"case 2458 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"U2"),{2,0}).T,np.reshape(np.array({"A","ñ"},"U2"),{2})}),{1,2},"<U2",{{"A","ñ"}})
cases=cases+1
check(np.hstack({np.reshape(np.array({"ñ","B"},"U2"),{1,2}),np.reshape(np.array({"ñ","B"},"U2"),{1,2})}),{1,4},"<U2",{{"ñ","B","ñ","B"}})
cases=cases+1
check(np.vstack({np.reshape(np.array({"ñ","B"},"U2"),{1,2}),np.reshape(np.array({"ñ","B"},"U2"),{1,2})}),{2,2},"<U2",{{"ñ","B"},{"ñ","B"}})
cases=cases+1
check(np.dstack({np.reshape(np.array({"ñ","B"},"U2"),{1,2}),np.reshape(np.array({"ñ","B"},"U2"),{1,2})}),{1,2,2},"<U2",{{{"ñ","ñ"},{"B","B"}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({"ñ","B"},"U2"),{1,2}),np.reshape(np.array({"ñ","B"},"U2"),{1,2})}),{1,4},"<U2",{{"ñ","B","ñ","B"}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({"ñ","B"},"U2"),{1,2}),np.reshape(np.array({"ñ","B"},"U2"),{1,2})}),{2,2},"<U2",{{"ñ","B"},{"ñ","B"}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({"ñ","B"},"U2"),{1,2}),np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),1)}) end),"case 2465 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({"ñ","B"},"U2"),{1,2}),np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),1)}),{3,2},"<U2",{{"ñ","B"},{"B","é"},{"A","ñ"}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({"ñ","B"},"U2"),{1,2}),np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),1)}) end),"case 2467 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({"ñ","B"},"U2"),{1,2}),np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),1)}) end),"case 2468 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({"ñ","B"},"U2"),{1,2}),np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),1)}),{3,2},"<U2",{{"ñ","B"},{"B","é"},{"A","ñ"}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({"ñ","B"},"U2"),{1,2}),np.flip(np.reshape(np.array({"A","ñ"},"U2"),{2}),1)}) end),"case 2470 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({"ñ","B"},"U2"),{1,2}),np.flip(np.reshape(np.array({"A","ñ"},"U2"),{2}),1)}),{2,2},"<U2",{{"ñ","B"},{"ñ","A"}})
cases=cases+1
check(np.dstack({np.reshape(np.array({"ñ","B"},"U2"),{1,2}),np.flip(np.reshape(np.array({"A","ñ"},"U2"),{2}),1)}),{1,2,2},"<U2",{{{"ñ","ñ"},{"B","A"}}})
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({"ñ","B"},"U2"),{1,2}),np.flip(np.reshape(np.array({"A","ñ"},"U2"),{2}),1)}) end),"case 2473 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({"ñ","B"},"U2"),{1,2}),np.flip(np.reshape(np.array({"A","ñ"},"U2"),{2}),1)}),{2,2},"<U2",{{"ñ","B"},{"ñ","A"}})
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({"ñ","B"},"U2"),{1,2}),1),np.flip(np.reshape(np.array({"ñ","B"},"U2"),{1,2}),1)}),{1,4},"<U2",{{"ñ","B","ñ","B"}})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({"ñ","B"},"U2"),{1,2}),1),np.flip(np.reshape(np.array({"ñ","B"},"U2"),{1,2}),1)}),{2,2},"<U2",{{"ñ","B"},{"ñ","B"}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({"ñ","B"},"U2"),{1,2}),1),np.flip(np.reshape(np.array({"ñ","B"},"U2"),{1,2}),1)}),{1,2,2},"<U2",{{{"ñ","ñ"},{"B","B"}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({"ñ","B"},"U2"),{1,2}),1),np.flip(np.reshape(np.array({"ñ","B"},"U2"),{1,2}),1)}),{1,4},"<U2",{{"ñ","B","ñ","B"}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({"ñ","B"},"U2"),{1,2}),1),np.flip(np.reshape(np.array({"ñ","B"},"U2"),{1,2}),1)}),{2,2},"<U2",{{"ñ","B"},{"ñ","B"}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({"ñ","B"},"U2"),{1,2}),1),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}).T}) end),"case 2480 expected failure")
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({"ñ","B"},"U2"),{1,2}),1),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}).T}),{3,2},"<U2",{{"ñ","B"},{"A","B"},{"ñ","é"}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({"ñ","B"},"U2"),{1,2}),1),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}).T}) end),"case 2482 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({"ñ","B"},"U2"),{1,2}),1),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}).T}) end),"case 2483 expected failure")
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({"ñ","B"},"U2"),{1,2}),1),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}).T}),{3,2},"<U2",{{"ñ","B"},{"A","B"},{"ñ","é"}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({"ñ","B"},"U2"),{1,2}),1),np.reshape(np.array({"B","é","界"},"U2"),{3})}) end),"case 2485 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({"ñ","B"},"U2"),{1,2}),1),np.reshape(np.array({"B","é","界"},"U2"),{3})}) end),"case 2486 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({"ñ","B"},"U2"),{1,2}),1),np.reshape(np.array({"B","é","界"},"U2"),{3})}) end),"case 2487 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({"ñ","B"},"U2"),{1,2}),1),np.reshape(np.array({"B","é","界"},"U2"),{3})}) end),"case 2488 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({"ñ","B"},"U2"),{1,2}),1),np.reshape(np.array({"B","é","界"},"U2"),{3})}) end),"case 2489 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({"ñ","B"},"U2"),{1,2}).T,np.reshape(np.array({"ñ","B"},"U2"),{1,2}).T}),{2,2},"<U2",{{"ñ","ñ"},{"B","B"}})
cases=cases+1
check(np.vstack({np.reshape(np.array({"ñ","B"},"U2"),{1,2}).T,np.reshape(np.array({"ñ","B"},"U2"),{1,2}).T}),{4,1},"<U2",{{"ñ"},{"B"},{"ñ"},{"B"}})
cases=cases+1
check(np.dstack({np.reshape(np.array({"ñ","B"},"U2"),{1,2}).T,np.reshape(np.array({"ñ","B"},"U2"),{1,2}).T}),{2,1,2},"<U2",{{{"ñ","ñ"}},{{"B","B"}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({"ñ","B"},"U2"),{1,2}).T,np.reshape(np.array({"ñ","B"},"U2"),{1,2}).T}),{2,2},"<U2",{{"ñ","ñ"},{"B","B"}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({"ñ","B"},"U2"),{1,2}).T,np.reshape(np.array({"ñ","B"},"U2"),{1,2}).T}),{4,1},"<U2",{{"ñ"},{"B"},{"ñ"},{"B"}})
cases=cases+1
check(np.hstack({np.reshape(np.array({"ñ","B"},"U2"),{1,2}).T,np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3})}),{2,4},"<U2",{{"ñ","é","界","東"},{"B","ß","A","ñ"}})
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({"ñ","B"},"U2"),{1,2}).T,np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3})}) end),"case 2496 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({"ñ","B"},"U2"),{1,2}).T,np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3})}) end),"case 2497 expected failure")
cases=cases+1
check(np.column_stack({np.reshape(np.array({"ñ","B"},"U2"),{1,2}).T,np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3})}),{2,4},"<U2",{{"ñ","é","界","東"},{"B","ß","A","ñ"}})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({"ñ","B"},"U2"),{1,2}).T,np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3})}) end),"case 2499 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({"ñ","B"},"U2"),{1,2}).T,np.flip(np.reshape(np.array({"B","é","界"},"U2"),{3}),1)}) end),"case 2500 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({"ñ","B"},"U2"),{1,2}).T,np.flip(np.reshape(np.array({"B","é","界"},"U2"),{3}),1)}) end),"case 2501 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({"ñ","B"},"U2"),{1,2}).T,np.flip(np.reshape(np.array({"B","é","界"},"U2"),{3}),1)}) end),"case 2502 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({"ñ","B"},"U2"),{1,2}).T,np.flip(np.reshape(np.array({"B","é","界"},"U2"),{3}),1)}) end),"case 2503 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({"ñ","B"},"U2"),{1,2}).T,np.flip(np.reshape(np.array({"B","é","界"},"U2"),{3}),1)}) end),"case 2504 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({"界","東"},"U2"),{2,1}),np.reshape(np.array({"界","東"},"U2"),{2,1})}),{2,2},"<U2",{{"界","界"},{"東","東"}})
cases=cases+1
check(np.vstack({np.reshape(np.array({"界","東"},"U2"),{2,1}),np.reshape(np.array({"界","東"},"U2"),{2,1})}),{4,1},"<U2",{{"界"},{"東"},{"界"},{"東"}})
cases=cases+1
check(np.dstack({np.reshape(np.array({"界","東"},"U2"),{2,1}),np.reshape(np.array({"界","東"},"U2"),{2,1})}),{2,1,2},"<U2",{{{"界","界"}},{{"東","東"}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({"界","東"},"U2"),{2,1}),np.reshape(np.array({"界","東"},"U2"),{2,1})}),{2,2},"<U2",{{"界","界"},{"東","東"}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({"界","東"},"U2"),{2,1}),np.reshape(np.array({"界","東"},"U2"),{2,1})}),{4,1},"<U2",{{"界"},{"東"},{"界"},{"東"}})
cases=cases+1
check(np.hstack({np.reshape(np.array({"界","東"},"U2"),{2,1}),np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),1)}),{2,4},"<U2",{{"界","ß","A","ñ"},{"東","é","界","東"}})
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({"界","東"},"U2"),{2,1}),np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),1)}) end),"case 2511 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({"界","東"},"U2"),{2,1}),np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),1)}) end),"case 2512 expected failure")
cases=cases+1
check(np.column_stack({np.reshape(np.array({"界","東"},"U2"),{2,1}),np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),1)}),{2,4},"<U2",{{"界","ß","A","ñ"},{"東","é","界","東"}})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({"界","東"},"U2"),{2,1}),np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),1)}) end),"case 2514 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({"界","東"},"U2"),{2,1}),np.reshape(np.array({},"U2"),{0,2})}) end),"case 2515 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({"界","東"},"U2"),{2,1}),np.reshape(np.array({},"U2"),{0,2})}) end),"case 2516 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({"界","東"},"U2"),{2,1}),np.reshape(np.array({},"U2"),{0,2})}) end),"case 2517 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({"界","東"},"U2"),{2,1}),np.reshape(np.array({},"U2"),{0,2})}) end),"case 2518 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({"界","東"},"U2"),{2,1}),np.reshape(np.array({},"U2"),{0,2})}) end),"case 2519 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({"界","東"},"U2"),{2,1}),1),np.flip(np.reshape(np.array({"界","東"},"U2"),{2,1}),1)}),{2,2},"<U2",{{"東","東"},{"界","界"}})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({"界","東"},"U2"),{2,1}),1),np.flip(np.reshape(np.array({"界","東"},"U2"),{2,1}),1)}),{4,1},"<U2",{{"東"},{"界"},{"東"},{"界"}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({"界","東"},"U2"),{2,1}),1),np.flip(np.reshape(np.array({"界","東"},"U2"),{2,1}),1)}),{2,1,2},"<U2",{{{"東","東"}},{{"界","界"}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({"界","東"},"U2"),{2,1}),1),np.flip(np.reshape(np.array({"界","東"},"U2"),{2,1}),1)}),{2,2},"<U2",{{"東","東"},{"界","界"}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({"界","東"},"U2"),{2,1}),1),np.flip(np.reshape(np.array({"界","東"},"U2"),{2,1}),1)}),{4,1},"<U2",{{"東"},{"界"},{"東"},{"界"}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({"界","東"},"U2"),{2,1}),1),np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}).T}) end),"case 2525 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({"界","東"},"U2"),{2,1}),1),np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}).T}) end),"case 2526 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({"界","東"},"U2"),{2,1}),1),np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}).T}) end),"case 2527 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({"界","東"},"U2"),{2,1}),1),np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}).T}) end),"case 2528 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({"界","東"},"U2"),{2,1}),1),np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}).T}) end),"case 2529 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({"界","東"},"U2"),{2,1}),1),np.reshape(np.array({},"U2"),{0,2}).T}),{2,1},"<U2",{{"東"},{"界"}})
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({"界","東"},"U2"),{2,1}),1),np.reshape(np.array({},"U2"),{0,2}).T}) end),"case 2531 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({"界","東"},"U2"),{2,1}),1),np.reshape(np.array({},"U2"),{0,2}).T}) end),"case 2532 expected failure")
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({"界","東"},"U2"),{2,1}),1),np.reshape(np.array({},"U2"),{0,2}).T}),{2,1},"<U2",{{"東"},{"界"}})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({"界","東"},"U2"),{2,1}),1),np.reshape(np.array({},"U2"),{0,2}).T}) end),"case 2534 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({"界","東"},"U2"),{2,1}).T,np.reshape(np.array({"界","東"},"U2"),{2,1}).T}),{1,4},"<U2",{{"界","東","界","東"}})
cases=cases+1
check(np.vstack({np.reshape(np.array({"界","東"},"U2"),{2,1}).T,np.reshape(np.array({"界","東"},"U2"),{2,1}).T}),{2,2},"<U2",{{"界","東"},{"界","東"}})
cases=cases+1
check(np.dstack({np.reshape(np.array({"界","東"},"U2"),{2,1}).T,np.reshape(np.array({"界","東"},"U2"),{2,1}).T}),{1,2,2},"<U2",{{{"界","界"},{"東","東"}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({"界","東"},"U2"),{2,1}).T,np.reshape(np.array({"界","東"},"U2"),{2,1}).T}),{1,4},"<U2",{{"界","東","界","東"}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({"界","東"},"U2"),{2,1}).T,np.reshape(np.array({"界","東"},"U2"),{2,1}).T}),{2,2},"<U2",{{"界","東"},{"界","東"}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({"界","東"},"U2"),{2,1}).T,np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2})}) end),"case 2540 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({"界","東"},"U2"),{2,1}).T,np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2})}),{4,2},"<U2",{{"界","東"},{"ß","A"},{"ñ","B"},{"é","界"}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({"界","東"},"U2"),{2,1}).T,np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2})}) end),"case 2542 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({"界","東"},"U2"),{2,1}).T,np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2})}) end),"case 2543 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({"界","東"},"U2"),{2,1}).T,np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2})}),{4,2},"<U2",{{"界","東"},{"ß","A"},{"ñ","B"},{"é","界"}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({"界","東"},"U2"),{2,1}).T,np.reshape(np.array({},"U2"),{2,0})}) end),"case 2545 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({"界","東"},"U2"),{2,1}).T,np.reshape(np.array({},"U2"),{2,0})}) end),"case 2546 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({"界","東"},"U2"),{2,1}).T,np.reshape(np.array({},"U2"),{2,0})}) end),"case 2547 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({"界","東"},"U2"),{2,1}).T,np.reshape(np.array({},"U2"),{2,0})}) end),"case 2548 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({"界","東"},"U2"),{2,1}).T,np.reshape(np.array({},"U2"),{2,0})}) end),"case 2549 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2})}),{2,4},"<U2",{{"A","ñ","A","ñ"},{"B","é","B","é"}})
cases=cases+1
check(np.vstack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2})}),{4,2},"<U2",{{"A","ñ"},{"B","é"},{"A","ñ"},{"B","é"}})
cases=cases+1
check(np.dstack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2})}),{2,2,2},"<U2",{{{"A","A"},{"ñ","ñ"}},{{"B","B"},{"é","é"}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2})}),{2,4},"<U2",{{"A","ñ","A","ñ"},{"B","é","B","é"}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2})}),{4,2},"<U2",{{"A","ñ"},{"B","é"},{"A","ñ"},{"B","é"}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),np.flip(np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),1)}) end),"case 2555 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),np.flip(np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),1)}),{5,2},"<U2",{{"A","ñ"},{"B","é"},{"é","界"},{"ñ","B"},{"ß","A"}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),np.flip(np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),1)}) end),"case 2557 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),np.flip(np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),1)}) end),"case 2558 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),np.flip(np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),1)}),{5,2},"<U2",{{"A","ñ"},{"B","é"},{"é","界"},{"ñ","B"},{"ß","A"}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),np.reshape(np.array({},"U2"),{2,0}).T}) end),"case 2560 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),np.reshape(np.array({},"U2"),{2,0}).T}),{2,2},"<U2",{{"A","ñ"},{"B","é"}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),np.reshape(np.array({},"U2"),{2,0}).T}) end),"case 2562 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),np.reshape(np.array({},"U2"),{2,0}).T}) end),"case 2563 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),np.reshape(np.array({},"U2"),{2,0}).T}),{2,2},"<U2",{{"A","ñ"},{"B","é"}})
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),1),np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),1)}),{2,4},"<U2",{{"B","é","B","é"},{"A","ñ","A","ñ"}})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),1),np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),1)}),{4,2},"<U2",{{"B","é"},{"A","ñ"},{"B","é"},{"A","ñ"}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),1),np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),1)}),{2,2,2},"<U2",{{{"B","B"},{"é","é"}},{{"A","A"},{"ñ","ñ"}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),1),np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),1)}),{2,4},"<U2",{{"B","é","B","é"},{"A","ñ","A","ñ"}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),1),np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),1)}),{4,2},"<U2",{{"B","é"},{"A","ñ"},{"B","é"},{"A","ñ"}})
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),1),np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}).T}),{2,5},"<U2",{{"B","é","ß","ñ","é"},{"A","ñ","A","B","界"}})
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),1),np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}).T}) end),"case 2571 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),1),np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}).T}) end),"case 2572 expected failure")
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),1),np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}).T}),{2,5},"<U2",{{"B","é","ß","ñ","é"},{"A","ñ","A","B","界"}})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),1),np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}).T}) end),"case 2574 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),1),np.reshape(np.array({"ñ","B"},"U2"),{1,2})}) end),"case 2575 expected failure")
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),1),np.reshape(np.array({"ñ","B"},"U2"),{1,2})}),{3,2},"<U2",{{"B","é"},{"A","ñ"},{"ñ","B"}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),1),np.reshape(np.array({"ñ","B"},"U2"),{1,2})}) end),"case 2577 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),1),np.reshape(np.array({"ñ","B"},"U2"),{1,2})}) end),"case 2578 expected failure")
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),1),np.reshape(np.array({"ñ","B"},"U2"),{1,2})}),{3,2},"<U2",{{"B","é"},{"A","ñ"},{"ñ","B"}})
cases=cases+1
check(np.hstack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}).T,np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}).T}),{2,4},"<U2",{{"A","B","A","B"},{"ñ","é","ñ","é"}})
cases=cases+1
check(np.vstack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}).T,np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}).T}),{4,2},"<U2",{{"A","B"},{"ñ","é"},{"A","B"},{"ñ","é"}})
cases=cases+1
check(np.dstack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}).T,np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}).T}),{2,2,2},"<U2",{{{"A","A"},{"B","B"}},{{"ñ","ñ"},{"é","é"}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}).T,np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}).T}),{2,4},"<U2",{{"A","B","A","B"},{"ñ","é","ñ","é"}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}).T,np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}).T}),{4,2},"<U2",{{"A","B"},{"ñ","é"},{"A","B"},{"ñ","é"}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}).T,np.reshape(np.array({},"U2"),{0,2,1})}) end),"case 2585 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}).T,np.reshape(np.array({},"U2"),{0,2,1})}) end),"case 2586 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}).T,np.reshape(np.array({},"U2"),{0,2,1})}) end),"case 2587 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}).T,np.reshape(np.array({},"U2"),{0,2,1})}) end),"case 2588 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}).T,np.reshape(np.array({},"U2"),{0,2,1})}) end),"case 2589 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}).T,np.flip(np.reshape(np.array({"ñ","B"},"U2"),{1,2}),1)}) end),"case 2590 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}).T,np.flip(np.reshape(np.array({"ñ","B"},"U2"),{1,2}),1)}),{3,2},"<U2",{{"A","B"},{"ñ","é"},{"ñ","B"}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}).T,np.flip(np.reshape(np.array({"ñ","B"},"U2"),{1,2}),1)}) end),"case 2592 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}).T,np.flip(np.reshape(np.array({"ñ","B"},"U2"),{1,2}),1)}) end),"case 2593 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}).T,np.flip(np.reshape(np.array({"ñ","B"},"U2"),{1,2}),1)}),{3,2},"<U2",{{"A","B"},{"ñ","é"},{"ñ","B"}})
cases=cases+1
check(np.hstack({np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3})}),{2,6},"<U2",{{"é","界","東","é","界","東"},{"ß","A","ñ","ß","A","ñ"}})
cases=cases+1
check(np.vstack({np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3})}),{4,3},"<U2",{{"é","界","東"},{"ß","A","ñ"},{"é","界","東"},{"ß","A","ñ"}})
cases=cases+1
check(np.dstack({np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3})}),{2,3,2},"<U2",{{{"é","é"},{"界","界"},{"東","東"}},{{"ß","ß"},{"A","A"},{"ñ","ñ"}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3})}),{2,6},"<U2",{{"é","界","東","é","界","東"},{"ß","A","ñ","ß","A","ñ"}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3})}),{4,3},"<U2",{{"é","界","東"},{"ß","A","ñ"},{"é","界","東"},{"ß","A","ñ"}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),np.reshape(np.array({},"U2"),{0,2,1}).T}) end),"case 2600 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),np.reshape(np.array({},"U2"),{0,2,1}).T}) end),"case 2601 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),np.reshape(np.array({},"U2"),{0,2,1}).T}) end),"case 2602 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),np.reshape(np.array({},"U2"),{0,2,1}).T}) end),"case 2603 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),np.reshape(np.array({},"U2"),{0,2,1}).T}) end),"case 2604 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),np.reshape(np.array({"ñ","B"},"U2"),{1,2}).T}),{2,4},"<U2",{{"é","界","東","ñ"},{"ß","A","ñ","B"}})
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),np.reshape(np.array({"ñ","B"},"U2"),{1,2}).T}) end),"case 2606 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),np.reshape(np.array({"ñ","B"},"U2"),{1,2}).T}) end),"case 2607 expected failure")
cases=cases+1
check(np.column_stack({np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),np.reshape(np.array({"ñ","B"},"U2"),{1,2}).T}),{2,4},"<U2",{{"é","界","東","ñ"},{"ß","A","ñ","B"}})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),np.reshape(np.array({"ñ","B"},"U2"),{1,2}).T}) end),"case 2609 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),1),np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),1)}),{2,6},"<U2",{{"ß","A","ñ","ß","A","ñ"},{"é","界","東","é","界","東"}})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),1),np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),1)}),{4,3},"<U2",{{"ß","A","ñ"},{"é","界","東"},{"ß","A","ñ"},{"é","界","東"}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),1),np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),1)}),{2,3,2},"<U2",{{{"ß","ß"},{"A","A"},{"ñ","ñ"}},{{"é","é"},{"界","界"},{"東","東"}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),1),np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),1)}),{2,6},"<U2",{{"ß","A","ñ","ß","A","ñ"},{"é","界","東","é","界","東"}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),1),np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),1)}),{4,3},"<U2",{{"ß","A","ñ"},{"é","界","東"},{"ß","A","ñ"},{"é","界","東"}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),1),np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3})}) end),"case 2615 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),1),np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3})}) end),"case 2616 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),1),np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3})}) end),"case 2617 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),1),np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3})}) end),"case 2618 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),1),np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3})}) end),"case 2619 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),1),np.reshape(np.array({"界","東"},"U2"),{2,1})}),{2,4},"<U2",{{"ß","A","ñ","界"},{"é","界","東","東"}})
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),1),np.reshape(np.array({"界","東"},"U2"),{2,1})}) end),"case 2621 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),1),np.reshape(np.array({"界","東"},"U2"),{2,1})}) end),"case 2622 expected failure")
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),1),np.reshape(np.array({"界","東"},"U2"),{2,1})}),{2,4},"<U2",{{"ß","A","ñ","界"},{"é","界","東","東"}})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),1),np.reshape(np.array({"界","東"},"U2"),{2,1})}) end),"case 2624 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}).T,np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}).T}),{3,4},"<U2",{{"é","ß","é","ß"},{"界","A","界","A"},{"東","ñ","東","ñ"}})
cases=cases+1
check(np.vstack({np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}).T,np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}).T}),{6,2},"<U2",{{"é","ß"},{"界","A"},{"東","ñ"},{"é","ß"},{"界","A"},{"東","ñ"}})
cases=cases+1
check(np.dstack({np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}).T,np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}).T}),{3,2,2},"<U2",{{{"é","é"},{"ß","ß"}},{{"界","界"},{"A","A"}},{{"東","東"},{"ñ","ñ"}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}).T,np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}).T}),{3,4},"<U2",{{"é","ß","é","ß"},{"界","A","界","A"},{"東","ñ","東","ñ"}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}).T,np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}).T}),{6,2},"<U2",{{"é","ß"},{"界","A"},{"東","ñ"},{"é","ß"},{"界","A"},{"東","ñ"}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}).T,np.flip(np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),1)}) end),"case 2630 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}).T,np.flip(np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),1)}) end),"case 2631 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}).T,np.flip(np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),1)}) end),"case 2632 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}).T,np.flip(np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),1)}) end),"case 2633 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}).T,np.flip(np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),1)}) end),"case 2634 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}).T,np.flip(np.reshape(np.array({"界","東"},"U2"),{2,1}),1)}) end),"case 2635 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}).T,np.flip(np.reshape(np.array({"界","東"},"U2"),{2,1}),1)}) end),"case 2636 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}).T,np.flip(np.reshape(np.array({"界","東"},"U2"),{2,1}),1)}) end),"case 2637 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}).T,np.flip(np.reshape(np.array({"界","東"},"U2"),{2,1}),1)}) end),"case 2638 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}).T,np.flip(np.reshape(np.array({"界","東"},"U2"),{2,1}),1)}) end),"case 2639 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2})}),{3,4},"<U2",{{"ß","A","ß","A"},{"ñ","B","ñ","B"},{"é","界","é","界"}})
cases=cases+1
check(np.vstack({np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2})}),{6,2},"<U2",{{"ß","A"},{"ñ","B"},{"é","界"},{"ß","A"},{"ñ","B"},{"é","界"}})
cases=cases+1
check(np.dstack({np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2})}),{3,2,2},"<U2",{{{"ß","ß"},{"A","A"}},{{"ñ","ñ"},{"B","B"}},{{"é","é"},{"界","界"}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2})}),{3,4},"<U2",{{"ß","A","ß","A"},{"ñ","B","ñ","B"},{"é","界","é","界"}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2})}),{6,2},"<U2",{{"ß","A"},{"ñ","B"},{"é","界"},{"ß","A"},{"ñ","B"},{"é","界"}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}).T}) end),"case 2645 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}).T}) end),"case 2646 expected failure")
cases=cases+1
check(np.dstack({np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}).T}),{3,2,2},"<U2",{{{"ß","界"},{"A","A"}},{{"ñ","東"},{"B","ñ"}},{{"é","ß"},{"界","B"}}})
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}).T}) end),"case 2648 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}).T}) end),"case 2649 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),np.reshape(np.array({"界","東"},"U2"),{2,1}).T}) end),"case 2650 expected failure")
cases=cases+1
check(np.vstack({np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),np.reshape(np.array({"界","東"},"U2"),{2,1}).T}),{4,2},"<U2",{{"ß","A"},{"ñ","B"},{"é","界"},{"界","東"}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),np.reshape(np.array({"界","東"},"U2"),{2,1}).T}) end),"case 2652 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),np.reshape(np.array({"界","東"},"U2"),{2,1}).T}) end),"case 2653 expected failure")
cases=cases+1
check(np.row_stack({np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),np.reshape(np.array({"界","東"},"U2"),{2,1}).T}),{4,2},"<U2",{{"ß","A"},{"ñ","B"},{"é","界"},{"界","東"}})
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),1),np.flip(np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),1)}),{3,4},"<U2",{{"é","界","é","界"},{"ñ","B","ñ","B"},{"ß","A","ß","A"}})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),1),np.flip(np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),1)}),{6,2},"<U2",{{"é","界"},{"ñ","B"},{"ß","A"},{"é","界"},{"ñ","B"},{"ß","A"}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),1),np.flip(np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),1)}),{3,2,2},"<U2",{{{"é","é"},{"界","界"}},{{"ñ","ñ"},{"B","B"}},{{"ß","ß"},{"A","A"}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),1),np.flip(np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),1)}),{3,4},"<U2",{{"é","界","é","界"},{"ñ","B","ñ","B"},{"ß","A","ß","A"}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),1),np.flip(np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),1)}),{6,2},"<U2",{{"é","界"},{"ñ","B"},{"ß","A"},{"é","界"},{"ñ","B"},{"ß","A"}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),1),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2})}) end),"case 2660 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),1),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2})}) end),"case 2661 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),1),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2})}) end),"case 2662 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),1),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2})}) end),"case 2663 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),1),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2})}) end),"case 2664 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),1),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2})}) end),"case 2665 expected failure")
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),1),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2})}),{5,2},"<U2",{{"é","界"},{"ñ","B"},{"ß","A"},{"A","ñ"},{"B","é"}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),1),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2})}) end),"case 2667 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),1),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2})}) end),"case 2668 expected failure")
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),1),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2})}),{5,2},"<U2",{{"é","界"},{"ñ","B"},{"ß","A"},{"A","ñ"},{"B","é"}})
cases=cases+1
check(np.hstack({np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}).T,np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}).T}),{2,6},"<U2",{{"ß","ñ","é","ß","ñ","é"},{"A","B","界","A","B","界"}})
cases=cases+1
check(np.vstack({np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}).T,np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}).T}),{4,3},"<U2",{{"ß","ñ","é"},{"A","B","界"},{"ß","ñ","é"},{"A","B","界"}})
cases=cases+1
check(np.dstack({np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}).T,np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}).T}),{2,3,2},"<U2",{{{"ß","ß"},{"ñ","ñ"},{"é","é"}},{{"A","A"},{"B","B"},{"界","界"}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}).T,np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}).T}),{2,6},"<U2",{{"ß","ñ","é","ß","ñ","é"},{"A","B","界","A","B","界"}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}).T,np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}).T}),{4,3},"<U2",{{"ß","ñ","é"},{"A","B","界"},{"ß","ñ","é"},{"A","B","界"}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}).T,np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),1)}) end),"case 2675 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}).T,np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),1)}) end),"case 2676 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}).T,np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),1)}) end),"case 2677 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}).T,np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),1)}) end),"case 2678 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}).T,np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),1)}) end),"case 2679 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}).T,np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),1)}),{2,5},"<U2",{{"ß","ñ","é","B","é"},{"A","B","界","A","ñ"}})
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}).T,np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),1)}) end),"case 2681 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}).T,np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),1)}) end),"case 2682 expected failure")
cases=cases+1
check(np.column_stack({np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}).T,np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),1)}),{2,5},"<U2",{{"ß","ñ","é","B","é"},{"A","B","界","A","ñ"}})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}).T,np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}),1)}) end),"case 2684 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({},"U2"),{0,2,1}),np.reshape(np.array({},"U2"),{0,2,1})}),{0,4,1},"<U2",{})
cases=cases+1
check(np.vstack({np.reshape(np.array({},"U2"),{0,2,1}),np.reshape(np.array({},"U2"),{0,2,1})}),{0,2,1},"<U2",{})
cases=cases+1
check(np.dstack({np.reshape(np.array({},"U2"),{0,2,1}),np.reshape(np.array({},"U2"),{0,2,1})}),{0,2,2},"<U2",{})
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"U2"),{0,2,1}),np.reshape(np.array({},"U2"),{0,2,1})}),{0,4,1},"<U2",{})
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"U2"),{0,2,1}),np.reshape(np.array({},"U2"),{0,2,1})}),{0,2,1},"<U2",{})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"U2"),{0,2,1}),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}).T}) end),"case 2690 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"U2"),{0,2,1}),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}).T}) end),"case 2691 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"U2"),{0,2,1}),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}).T}) end),"case 2692 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"U2"),{0,2,1}),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}).T}) end),"case 2693 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"U2"),{0,2,1}),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}).T}) end),"case 2694 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"U2"),{0,2,1}),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}).T}) end),"case 2695 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"U2"),{0,2,1}),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}).T}) end),"case 2696 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"U2"),{0,2,1}),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}).T}) end),"case 2697 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"U2"),{0,2,1}),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}).T}) end),"case 2698 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"U2"),{0,2,1}),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,2}).T}) end),"case 2699 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({},"U2"),{0,2,1}).T,np.reshape(np.array({},"U2"),{0,2,1}).T}),{1,4,0},"<U2",{{{},{},{},{}}})
cases=cases+1
check(np.vstack({np.reshape(np.array({},"U2"),{0,2,1}).T,np.reshape(np.array({},"U2"),{0,2,1}).T}),{2,2,0},"<U2",{{{},{}},{{},{}}})
cases=cases+1
check(np.dstack({np.reshape(np.array({},"U2"),{0,2,1}).T,np.reshape(np.array({},"U2"),{0,2,1}).T}),{1,2,0},"<U2",{{{},{}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({},"U2"),{0,2,1}).T,np.reshape(np.array({},"U2"),{0,2,1}).T}),{1,4,0},"<U2",{{{},{},{},{}}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({},"U2"),{0,2,1}).T,np.reshape(np.array({},"U2"),{0,2,1}).T}),{2,2,0},"<U2",{{{},{}},{{},{}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"U2"),{0,2,1}).T,np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2})}) end),"case 2705 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"U2"),{0,2,1}).T,np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2})}) end),"case 2706 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"U2"),{0,2,1}).T,np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2})}) end),"case 2707 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"U2"),{0,2,1}).T,np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2})}) end),"case 2708 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"U2"),{0,2,1}).T,np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2})}) end),"case 2709 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({},"U2"),{0,2,1}).T,np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3})}) end),"case 2710 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({},"U2"),{0,2,1}).T,np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3})}) end),"case 2711 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({},"U2"),{0,2,1}).T,np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3})}) end),"case 2712 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({},"U2"),{0,2,1}).T,np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3})}) end),"case 2713 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({},"U2"),{0,2,1}).T,np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3})}) end),"case 2714 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3})}),{1,4,3},"<U2",{{{"界","東","ß"},{"A","ñ","B"},{"界","東","ß"},{"A","ñ","B"}}})
cases=cases+1
check(np.vstack({np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3})}),{2,2,3},"<U2",{{{"界","東","ß"},{"A","ñ","B"}},{{"界","東","ß"},{"A","ñ","B"}}})
cases=cases+1
check(np.dstack({np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3})}),{1,2,6},"<U2",{{{"界","東","ß","界","東","ß"},{"A","ñ","B","A","ñ","B"}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3})}),{1,4,3},"<U2",{{{"界","東","ß"},{"A","ñ","B"},{"界","東","ß"},{"A","ñ","B"}}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3})}),{2,2,3},"<U2",{{{"界","東","ß"},{"A","ñ","B"}},{{"界","東","ß"},{"A","ñ","B"}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),1)}) end),"case 2720 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),1)}) end),"case 2721 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),1)}) end),"case 2722 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),1)}) end),"case 2723 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),1)}) end),"case 2724 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),1)}) end),"case 2725 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),1)}) end),"case 2726 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),1)}) end),"case 2727 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),1)}) end),"case 2728 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}),1)}) end),"case 2729 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),1),np.flip(np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),1)}),{1,4,3},"<U2",{{{"界","東","ß"},{"A","ñ","B"},{"界","東","ß"},{"A","ñ","B"}}})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),1),np.flip(np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),1)}),{2,2,3},"<U2",{{{"界","東","ß"},{"A","ñ","B"}},{{"界","東","ß"},{"A","ñ","B"}}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),1),np.flip(np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),1)}),{1,2,6},"<U2",{{{"界","東","ß","界","東","ß"},{"A","ñ","B","A","ñ","B"}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),1),np.flip(np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),1)}),{1,4,3},"<U2",{{{"界","東","ß"},{"A","ñ","B"},{"界","東","ß"},{"A","ñ","B"}}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),1),np.flip(np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),1)}),{2,2,3},"<U2",{{{"界","東","ß"},{"A","ñ","B"}},{{"界","東","ß"},{"A","ñ","B"}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),1),np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}).T}) end),"case 2735 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),1),np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}).T}) end),"case 2736 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),1),np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}).T}) end),"case 2737 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),1),np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}).T}) end),"case 2738 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),1),np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}).T}) end),"case 2739 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),1),np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}).T}) end),"case 2740 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),1),np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}).T}) end),"case 2741 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),1),np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}).T}) end),"case 2742 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),1),np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}).T}) end),"case 2743 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),1),np.reshape(np.array({"é","界","東","ß","A","ñ"},"U2"),{2,3}).T}) end),"case 2744 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}).T,np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}).T}),{3,4,1},"<U2",{{{"界"},{"A"},{"界"},{"A"}},{{"東"},{"ñ"},{"東"},{"ñ"}},{{"ß"},{"B"},{"ß"},{"B"}}})
cases=cases+1
check(np.vstack({np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}).T,np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}).T}),{6,2,1},"<U2",{{{"界"},{"A"}},{{"東"},{"ñ"}},{{"ß"},{"B"}},{{"界"},{"A"}},{{"東"},{"ñ"}},{{"ß"},{"B"}}})
cases=cases+1
check(np.dstack({np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}).T,np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}).T}),{3,2,2},"<U2",{{{"界","界"},{"A","A"}},{{"東","東"},{"ñ","ñ"}},{{"ß","ß"},{"B","B"}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}).T,np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}).T}),{3,4,1},"<U2",{{{"界"},{"A"},{"界"},{"A"}},{{"東"},{"ñ"},{"東"},{"ñ"}},{{"ß"},{"B"},{"ß"},{"B"}}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}).T,np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}).T}),{6,2,1},"<U2",{{{"界"},{"A"}},{{"東"},{"ñ"}},{{"ß"},{"B"}},{{"界"},{"A"}},{{"東"},{"ñ"}},{{"ß"},{"B"}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}).T,np.reshape(np.array({"é"},"U2"),{})}) end),"case 2750 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}).T,np.reshape(np.array({"é"},"U2"),{})}) end),"case 2751 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}).T,np.reshape(np.array({"é"},"U2"),{})}) end),"case 2752 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}).T,np.reshape(np.array({"é"},"U2"),{})}) end),"case 2753 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}).T,np.reshape(np.array({"é"},"U2"),{})}) end),"case 2754 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}).T,np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2})}) end),"case 2755 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}).T,np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2})}) end),"case 2756 expected failure")
cases=cases+1
check(np.dstack({np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}).T,np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2})}),{3,2,2},"<U2",{{{"界","ß"},{"A","A"}},{{"東","ñ"},{"ñ","B"}},{{"ß","é"},{"B","界"}}})
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}).T,np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2})}) end),"case 2758 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}).T,np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2})}) end),"case 2759 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2})}),{2,2,2},"<U2",{{{"A","ñ"},{"A","ñ"}},{{"B","é"},{"B","é"}}})
cases=cases+1
check(np.vstack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2})}),{4,1,2},"<U2",{{{"A","ñ"}},{{"B","é"}},{{"A","ñ"}},{{"B","é"}}})
cases=cases+1
check(np.dstack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2})}),{2,1,4},"<U2",{{{"A","ñ","A","ñ"}},{{"B","é","B","é"}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2})}),{2,2,2},"<U2",{{{"A","ñ"},{"A","ñ"}},{{"B","é"},{"B","é"}}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2})}),{4,1,2},"<U2",{{{"A","ñ"}},{{"B","é"}},{{"A","ñ"}},{{"B","é"}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),np.reshape(np.array({},"U2"),{0})}) end),"case 2765 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),np.reshape(np.array({},"U2"),{0})}) end),"case 2766 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),np.reshape(np.array({},"U2"),{0})}) end),"case 2767 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),np.reshape(np.array({},"U2"),{0})}) end),"case 2768 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),np.reshape(np.array({},"U2"),{0})}) end),"case 2769 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),np.flip(np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),1)}) end),"case 2770 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),np.flip(np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),1)}) end),"case 2771 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),np.flip(np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),1)}) end),"case 2772 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),np.flip(np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),1)}) end),"case 2773 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),np.flip(np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}),1)}) end),"case 2774 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),1),np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),1)}),{2,2,2},"<U2",{{{"B","é"},{"B","é"}},{{"A","ñ"},{"A","ñ"}}})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),1),np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),1)}),{4,1,2},"<U2",{{{"B","é"}},{{"A","ñ"}},{{"B","é"}},{{"A","ñ"}}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),1),np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),1)}),{2,1,4},"<U2",{{{"B","é","B","é"}},{{"A","ñ","A","ñ"}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),1),np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),1)}),{2,2,2},"<U2",{{{"B","é"},{"B","é"}},{{"A","ñ"},{"A","ñ"}}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),1),np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),1)}),{4,1,2},"<U2",{{{"B","é"}},{{"A","ñ"}},{{"B","é"}},{{"A","ñ"}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),1),np.reshape(np.array({"東"},"U2"),{1})}) end),"case 2780 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),1),np.reshape(np.array({"東"},"U2"),{1})}) end),"case 2781 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),1),np.reshape(np.array({"東"},"U2"),{1})}) end),"case 2782 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),1),np.reshape(np.array({"東"},"U2"),{1})}) end),"case 2783 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),1),np.reshape(np.array({"東"},"U2"),{1})}) end),"case 2784 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),1),np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}).T}) end),"case 2785 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),1),np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}).T}) end),"case 2786 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),1),np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}).T}) end),"case 2787 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),1),np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}).T}) end),"case 2788 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}),1),np.reshape(np.array({"ß","A","ñ","B","é","界"},"U2"),{3,2}).T}) end),"case 2789 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}).T,np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}).T}),{2,2,2},"<U2",{{{"A","B"},{"A","B"}},{{"ñ","é"},{"ñ","é"}}})
cases=cases+1
check(np.vstack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}).T,np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}).T}),{4,1,2},"<U2",{{{"A","B"}},{{"ñ","é"}},{{"A","B"}},{{"ñ","é"}}})
cases=cases+1
check(np.dstack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}).T,np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}).T}),{2,1,4},"<U2",{{{"A","B","A","B"}},{{"ñ","é","ñ","é"}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}).T,np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}).T}),{2,2,2},"<U2",{{{"A","B"},{"A","B"}},{{"ñ","é"},{"ñ","é"}}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}).T,np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}).T}),{4,1,2},"<U2",{{{"A","B"}},{{"ñ","é"}},{{"A","B"}},{{"ñ","é"}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}).T,np.flip(np.reshape(np.array({"東"},"U2"),{1}),1)}) end),"case 2795 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}).T,np.flip(np.reshape(np.array({"東"},"U2"),{1}),1)}) end),"case 2796 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}).T,np.flip(np.reshape(np.array({"東"},"U2"),{1}),1)}) end),"case 2797 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}).T,np.flip(np.reshape(np.array({"東"},"U2"),{1}),1)}) end),"case 2798 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}).T,np.flip(np.reshape(np.array({"東"},"U2"),{1}),1)}) end),"case 2799 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}).T,np.reshape(np.array({},"U2"),{0,2,1})}) end),"case 2800 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}).T,np.reshape(np.array({},"U2"),{0,2,1})}) end),"case 2801 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}).T,np.reshape(np.array({},"U2"),{0,2,1})}) end),"case 2802 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}).T,np.reshape(np.array({},"U2"),{0,2,1})}) end),"case 2803 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({"A","ñ","B","é"},"U2"),{2,1,2}).T,np.reshape(np.array({},"U2"),{0,2,1})}) end),"case 2804 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2})}),{2,4,2},"<U2",{{{"é","界"},{"東","ß"},{"é","界"},{"東","ß"}},{{"A","ñ"},{"B","é"},{"A","ñ"},{"B","é"}}})
cases=cases+1
check(np.vstack({np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2})}),{4,2,2},"<U2",{{{"é","界"},{"東","ß"}},{{"A","ñ"},{"B","é"}},{{"é","界"},{"東","ß"}},{{"A","ñ"},{"B","é"}}})
cases=cases+1
check(np.dstack({np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2})}),{2,2,4},"<U2",{{{"é","界","é","界"},{"東","ß","東","ß"}},{{"A","ñ","A","ñ"},{"B","é","B","é"}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2})}),{2,4,2},"<U2",{{{"é","界"},{"東","ß"},{"é","界"},{"東","ß"}},{{"A","ñ"},{"B","é"},{"A","ñ"},{"B","é"}}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2})}),{4,2,2},"<U2",{{{"é","界"},{"東","ß"}},{{"A","ñ"},{"B","é"}},{{"é","界"},{"東","ß"}},{{"A","ñ"},{"B","é"}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),np.reshape(np.array({"A","ñ"},"U2"),{2})}) end),"case 2810 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),np.reshape(np.array({"A","ñ"},"U2"),{2})}) end),"case 2811 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),np.reshape(np.array({"A","ñ"},"U2"),{2})}) end),"case 2812 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),np.reshape(np.array({"A","ñ"},"U2"),{2})}) end),"case 2813 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),np.reshape(np.array({"A","ñ"},"U2"),{2})}) end),"case 2814 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),np.reshape(np.array({},"U2"),{0,2,1}).T}) end),"case 2815 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),np.reshape(np.array({},"U2"),{0,2,1}).T}) end),"case 2816 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),np.reshape(np.array({},"U2"),{0,2,1}).T}) end),"case 2817 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),np.reshape(np.array({},"U2"),{0,2,1}).T}) end),"case 2818 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),np.reshape(np.array({},"U2"),{0,2,1}).T}) end),"case 2819 expected failure")
cases=cases+1
check(np.hstack({np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),1),np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),1)}),{2,4,2},"<U2",{{{"A","ñ"},{"B","é"},{"A","ñ"},{"B","é"}},{{"é","界"},{"東","ß"},{"é","界"},{"東","ß"}}})
cases=cases+1
check(np.vstack({np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),1),np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),1)}),{4,2,2},"<U2",{{{"A","ñ"},{"B","é"}},{{"é","界"},{"東","ß"}},{{"A","ñ"},{"B","é"}},{{"é","界"},{"東","ß"}}})
cases=cases+1
check(np.dstack({np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),1),np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),1)}),{2,2,4},"<U2",{{{"A","ñ","A","ñ"},{"B","é","B","é"}},{{"é","界","é","界"},{"東","ß","東","ß"}}})
cases=cases+1
check(np.column_stack({np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),1),np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),1)}),{2,4,2},"<U2",{{{"A","ñ"},{"B","é"},{"A","ñ"},{"B","é"}},{{"é","界"},{"東","ß"},{"é","界"},{"東","ß"}}})
cases=cases+1
check(np.row_stack({np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),1),np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),1)}),{4,2,2},"<U2",{{{"A","ñ"},{"B","é"}},{{"é","界"},{"東","ß"}},{{"A","ñ"},{"B","é"}},{{"é","界"},{"東","ß"}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),1),np.flip(np.reshape(np.array({"A","ñ"},"U2"),{2}),1)}) end),"case 2825 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),1),np.flip(np.reshape(np.array({"A","ñ"},"U2"),{2}),1)}) end),"case 2826 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),1),np.flip(np.reshape(np.array({"A","ñ"},"U2"),{2}),1)}) end),"case 2827 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),1),np.flip(np.reshape(np.array({"A","ñ"},"U2"),{2}),1)}) end),"case 2828 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),1),np.flip(np.reshape(np.array({"A","ñ"},"U2"),{2}),1)}) end),"case 2829 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),1),np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3})}) end),"case 2830 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),1),np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3})}) end),"case 2831 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),1),np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3})}) end),"case 2832 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),1),np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3})}) end),"case 2833 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.flip(np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}),1),np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3})}) end),"case 2834 expected failure")
cases=cases+1
check(np.hstack({np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}).T,np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}).T}),{2,4,2},"<U2",{{{"é","A"},{"東","B"},{"é","A"},{"東","B"}},{{"界","ñ"},{"ß","é"},{"界","ñ"},{"ß","é"}}})
cases=cases+1
check(np.vstack({np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}).T,np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}).T}),{4,2,2},"<U2",{{{"é","A"},{"東","B"}},{{"界","ñ"},{"ß","é"}},{{"é","A"},{"東","B"}},{{"界","ñ"},{"ß","é"}}})
cases=cases+1
check(np.dstack({np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}).T,np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}).T}),{2,2,4},"<U2",{{{"é","A","é","A"},{"東","B","東","B"}},{{"界","ñ","界","ñ"},{"ß","é","ß","é"}}})
cases=cases+1
check(np.column_stack({np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}).T,np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}).T}),{2,4,2},"<U2",{{{"é","A"},{"東","B"},{"é","A"},{"東","B"}},{{"界","ñ"},{"ß","é"},{"界","ñ"},{"ß","é"}}})
cases=cases+1
check(np.row_stack({np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}).T,np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}).T}),{4,2,2},"<U2",{{{"é","A"},{"東","B"}},{{"界","ñ"},{"ß","é"}},{{"é","A"},{"東","B"}},{{"界","ñ"},{"ß","é"}}})
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}).T,np.reshape(np.array({"B","é","界"},"U2"),{3})}) end),"case 2840 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}).T,np.reshape(np.array({"B","é","界"},"U2"),{3})}) end),"case 2841 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}).T,np.reshape(np.array({"B","é","界"},"U2"),{3})}) end),"case 2842 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}).T,np.reshape(np.array({"B","é","界"},"U2"),{3})}) end),"case 2843 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}).T,np.reshape(np.array({"B","é","界"},"U2"),{3})}) end),"case 2844 expected failure")
cases=cases+1
assert(not pcall(function()return np.hstack({np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}).T,np.flip(np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),1)}) end),"case 2845 expected failure")
cases=cases+1
assert(not pcall(function()return np.vstack({np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}).T,np.flip(np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),1)}) end),"case 2846 expected failure")
cases=cases+1
assert(not pcall(function()return np.dstack({np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}).T,np.flip(np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),1)}) end),"case 2847 expected failure")
cases=cases+1
assert(not pcall(function()return np.column_stack({np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}).T,np.flip(np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),1)}) end),"case 2848 expected failure")
cases=cases+1
assert(not pcall(function()return np.row_stack({np.reshape(np.array({"é","界","東","ß","A","ñ","B","é"},"U2"),{2,2,2}).T,np.flip(np.reshape(np.array({"界","東","ß","A","ñ","B"},"U2"),{1,2,3}),1)}) end),"case 2849 expected failure")
cases=cases+1
check(np.hstack({np.array({1,2},"int16"),np.array({3.5,4.5},"float32")},{dtype="float64"}),{4},"float64",{1.0,2.0,3.5,4.5})
cases=cases+1
check(np.hstack({np.array({1,2},"int16"),np.array({3.5,4.5},"float32")},{dtype="int16",casting="unsafe"}),{4},"int16",{1,2,3,4})
cases=cases+1
assert(not pcall(function()return np.hstack({np.array({1,2},"int16"),np.array({3.5,4.5},"float32")},{dtype="int16",casting="safe"}) end))
cases=cases+1
assert(not pcall(function()return np.hstack({np.array({1,2},"int16"),np.array({3.5,4.5},"float32")},{casting="no"}) end))
cases=cases+1
check(np.hstack({np.array({1,2},"int16"),np.array({3.5,4.5},"float32")},{casting="same_kind"}),{4},"float32",{1.0,2.0,3.5,4.5})
cases=cases+1
check(np.vstack({np.array({1,2},"int16"),np.array({3.5,4.5},"float32")},{dtype="float64"}),{2,2},"float64",{{1.0,2.0},{3.5,4.5}})
cases=cases+1
check(np.vstack({np.array({1,2},"int16"),np.array({3.5,4.5},"float32")},{dtype="int16",casting="unsafe"}),{2,2},"int16",{{1,2},{3,4}})
cases=cases+1
assert(not pcall(function()return np.vstack({np.array({1,2},"int16"),np.array({3.5,4.5},"float32")},{dtype="int16",casting="safe"}) end))
cases=cases+1
assert(not pcall(function()return np.vstack({np.array({1,2},"int16"),np.array({3.5,4.5},"float32")},{casting="no"}) end))
cases=cases+1
check(np.vstack({np.array({1,2},"int16"),np.array({3.5,4.5},"float32")},{casting="same_kind"}),{2,2},"float32",{{1.0,2.0},{3.5,4.5}})
cases=cases+1
assert(not pcall(function()return np.dstack({np.array({1,2},"int16"),np.array({3.5,4.5},"float32")},{dtype="float64"}) end))
cases=cases+1
assert(not pcall(function()return np.dstack({np.array({1,2},"int16"),np.array({3.5,4.5},"float32")},{dtype="int16",casting="unsafe"}) end))
cases=cases+1
assert(not pcall(function()return np.dstack({np.array({1,2},"int16"),np.array({3.5,4.5},"float32")},{dtype="int16",casting="safe"}) end))
cases=cases+1
assert(not pcall(function()return np.dstack({np.array({1,2},"int16"),np.array({3.5,4.5},"float32")},{casting="no"}) end))
cases=cases+1
assert(not pcall(function()return np.dstack({np.array({1,2},"int16"),np.array({3.5,4.5},"float32")},{casting="same_kind"}) end))
cases=cases+1
assert(not pcall(function()return np.column_stack({np.array({1,2},"int16"),np.array({3.5,4.5},"float32")},{dtype="float64"}) end))
cases=cases+1
assert(not pcall(function()return np.column_stack({np.array({1,2},"int16"),np.array({3.5,4.5},"float32")},{dtype="int16",casting="unsafe"}) end))
cases=cases+1
assert(not pcall(function()return np.column_stack({np.array({1,2},"int16"),np.array({3.5,4.5},"float32")},{dtype="int16",casting="safe"}) end))
cases=cases+1
assert(not pcall(function()return np.column_stack({np.array({1,2},"int16"),np.array({3.5,4.5},"float32")},{casting="no"}) end))
cases=cases+1
assert(not pcall(function()return np.column_stack({np.array({1,2},"int16"),np.array({3.5,4.5},"float32")},{casting="same_kind"}) end))
cases=cases+1
check(np.row_stack({np.array({1,2},"int16"),np.array({3.5,4.5},"float32")},{dtype="float64"}),{2,2},"float64",{{1.0,2.0},{3.5,4.5}})
cases=cases+1
check(np.row_stack({np.array({1,2},"int16"),np.array({3.5,4.5},"float32")},{dtype="int16",casting="unsafe"}),{2,2},"int16",{{1,2},{3,4}})
cases=cases+1
assert(not pcall(function()return np.row_stack({np.array({1,2},"int16"),np.array({3.5,4.5},"float32")},{dtype="int16",casting="safe"}) end))
cases=cases+1
assert(not pcall(function()return np.row_stack({np.array({1,2},"int16"),np.array({3.5,4.5},"float32")},{casting="no"}) end))
cases=cases+1
check(np.row_stack({np.array({1,2},"int16"),np.array({3.5,4.5},"float32")},{casting="same_kind"}),{2,2},"float32",{{1.0,2.0},{3.5,4.5}})
cases=cases+1
assert(cases==2875);print("shape stack differential: 2875/2875 (valid 1219, expected rejections 1656)")
