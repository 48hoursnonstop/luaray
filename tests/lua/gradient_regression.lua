local lr=require('luaray')
local checks=0
local function check(value)checks=checks+1;assert(value)end
local function reject(call)check(not pcall(call))end
local function close(a,b)check(math.abs(a-b)<1e-12)end
local x=lr.array({0,1,3,6,10},'int64')
local f=lr.square(x)
local g=lr.gradient(f,{spacing=x,edge_order=2})
check(g.dtype=='float64' and g.shape[1]==5)
for i=1,5 do close(g[i],2*x[i])end
local first=lr.gradient({0,1,4,9});check(first[1]==1 and first[2]==2 and first[4]==5)
local second=lr.gradient({0,1,4,9},{edge_order=2});check(second[1]==0 and second[4]==6)
local single=lr.gradient(lr.array({1,3,5},'float32'),{spacing=2});check(single.dtype=='float32' and single[2]==1)
local matrix=lr.asfortranarray(lr.arange(12):reshape({3,4}))
local both=lr.gradient(matrix,{axis={-1,1},spacing={2,4},edge_order=2})
check(#both==2 and both[1].strides[1]==8 and both[1].strides[2]==24)
close(both[1]:get(2,3),.5);close(both[2]:get(2,3),1)
check(not lr.shares_memory(both[1],matrix) and not lr.shares_memory(both[1],both[2]))
both[1]:set(99,1,1);check(matrix:get(1,1)==0)
local readonly=lr.broadcast_to(lr.array(7,'int64'),{4})
local constant=lr.gradient(readonly);constant[1]=5;check(readonly[1]==7 and constant[2]==0)
check(#lr.gradient(3)==0 and #lr.gradient(matrix,{axis={}})==0)
local complex=lr.gradient(lr.array({lr.complex(0,0),lr.complex(1,2),lr.complex(2,4)},'complex128'))
check(complex[2].real==1 and complex[2].imag==2)
local dates=lr.array({0,2,8},'datetime64[ms]')
local duration=lr.gradient(dates,{spacing=2})
check(duration.dtype=='timedelta64[ms]' and lr.astype(duration,'int64')[2]==2)
local coordinates=lr.array({0,1,3},'timedelta64[h]')
local temporal_coordinates=lr.gradient({0,1,9},{spacing=coordinates,edge_order=2})
close(temporal_coordinates[3],6)
local ticks=lr.array({math.maxinteger,-7,math.mininteger},'timedelta64[h]')
local exact=lr.astype(lr.true_divide(ticks,1),'int64')
check(exact[1]==math.maxinteger and exact[2]==-7 and exact[3]==math.mininteger)
check(lr.astype(lr.true_divide(ticks,2),'int64')[2]==-3)
check(lr.astype(lr.true_divide(ticks,0),'int64')[1]==math.mininteger)
local ratios=lr.true_divide(lr.array({1,2},'timedelta64[D]'),lr.array({12,24},'timedelta64[h]'))
check(ratios.dtype=='float64' and ratios[1]==2 and ratios[2]==2)
local zero=lr.true_divide(lr.array({1,0},'timedelta64[h]'),lr.array({0,0},'timedelta64[h]'))
check(zero[1]==math.huge and zero[2]~=zero[2])
local alias=lr.array({2,4},'timedelta64[h]');local output=alias:view('float64')
check(rawequal(lr.true_divide(alias,lr.array(2,'timedelta64[h]'),{out=output}),output))
check(output[1]==1 and output[2]==2)
for _,call in ipairs({
 function()lr.gradient({1})end,
 function()lr.gradient({1,2},{edge_order=2})end,
 function()lr.gradient(f,{axis=0})end,
 function()lr.gradient(f,{axis={1,1}})end,
 function()lr.gradient(f,{axis=1.0})end,
 function()lr.gradient(f,{spacing=lr.array({0,1})})end,
 function()lr.gradient(matrix,{spacing={1}})end,
 function()lr.gradient(f,{edge_order=3})end,
 function()lr.gradient(f,{unknown=1})end,
 function()lr.gradient(f,false)end,
 function()lr.gradient(f,{},1)end,
 function()lr.gradient({true,false,true})end,
 function()lr.gradient(lr.array({0,1,2},'float64'),{spacing=lr.complex(2,1),edge_order=2})end,
 function()lr.true_divide(ticks,true)end,
 function()lr.true_divide(ticks,lr.array(true,'bool'))end,
 function()lr.true_divide(ticks,lr.array(1,'timedelta64[M]'))end,
})do reject(call)end
print('gradient regression: '..checks..' checks passed')
