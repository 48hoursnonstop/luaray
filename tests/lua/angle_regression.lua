local lr=require('luaray')
local checks=0
local function check(value)checks=checks+1;assert(value)end
local function close(a,b)check(math.abs(a-b)<1e-12)end
local function reject(f)check(not pcall(f))end
local z=lr.array({lr.complex(1,0),lr.complex(0,1),lr.complex(1,1)},'complex128')
local degrees=lr.angle(z,{deg=true})
check(degrees.dtype=='float64' and degrees[1]==0 and degrees[2]==90 and degrees[3]==45)
close(lr.angle(z)[3],math.pi/4)
check(lr.angle(-1).ndim==0);close(lr.angle(-1):tolist(),math.pi)
check(lr.angle(lr.array({lr.complex(1,1)},'complex64')).dtype=='float32')
check(lr.angle(lr.array({lr.complex(1,1)},'clongdouble')).dtype=='longdouble')
local zeros=lr.angle(lr.array({lr.complex(0.,-0.),lr.complex(-0.,-0.)},'complex128'))
check(zeros[1]==0 and 1/zeros[1]==-math.huge);close(zeros[2],-math.pi)
local reals=lr.angle(lr.array({0.,-0.,-1.,1.},'float64'))
check(reals[1]==0 and 1/reals[1]==math.huge);close(reals[2],math.pi)
local f=lr.asfortranarray(lr.array({{lr.complex(1,1),lr.complex(0,1)},{lr.complex(1,0),lr.complex(-1,0)}},'complex64'))
local phase=lr.angle(f);check(phase.strides[1]==4 and phase.strides[2]==8)
check(not lr.shares_memory(phase,f));phase:set(7);check(f:get(1,1).real==1)
check(lr.angle(z:get(lr.s(nil,nil,-1)))[1]==lr.angle(z)[3])
check(lr.angle(lr.array({},'float32')).size==0)
local readonly=lr.broadcast_to(lr.array(-1.,'float64'),{3})
local output=lr.angle(readonly);output[1]=0;check(readonly[1]==-1 and output[2]==math.pi)
for _,call in ipairs({
 function()lr.angle(z,{deg=1})end,
 function()lr.angle(z,{unknown=1})end,
 function()lr.angle(z,false)end,
 function()lr.angle(z,{},1)end,
 function()lr.angle(lr.array({'a','b'},'U1'))end,
 function()lr.angle(lr.array({1,2},'datetime64[h]'))end,
})do reject(call)end
print('angle regression: '..checks..' checks passed')
