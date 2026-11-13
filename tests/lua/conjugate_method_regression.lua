local lr=require('luaray')
local checks=0
local function eq(a,b)
    checks=checks+1
    if type(b)=='table' then
        assert(type(a)=='table' and #a==#b)
        for i=1,#b do eq(a[i],b[i]) end
    else assert(a==b,tostring(a)..' ~= '..tostring(b)) end
end
local function fails(f)checks=checks+1;assert(not pcall(f))end
local a=lr.array({1,2,3},'float64')
eq(rawequal(a:conj(),a),true);eq(rawequal(a:conjugate(nil),a),true)
eq(rawequal(a:conj({}),a),true)
a:setflags(false);eq(rawequal(a:conjugate(),a),true)
eq(a:conj(a),a);eq(a.flags.writeable,false)
local truth=lr.array({true,false},'bool');eq(truth:conj(),truth);eq(truth:conj().dtype,'bool')
local z=lr.array({lr.complex(1,2),lr.complex(3,-4)},'complex128')
local r=z:conjugate()
eq(rawequal(r,z),false);eq(lr.shares_memory(r,z),false)
eq(lr.real(r):tolist(),{1,3});eq(lr.imag(r):tolist(),{-2,4})
eq(lr.imag(z):tolist(),{2,-4})
local out=lr.zeros({2,3},'complex128')
eq(a:conj({out=out}),out)
eq(lr.real(out):tolist(),{{1,2,3},{1,2,3}})
eq(lr.imag(out):tolist(),{{0,0,0},{0,0,0}})
local ints=lr.zeros({3},'int32');fails(function()a:conj(ints)end);eq(ints:tolist(),{0,0,0})
local text=lr.zeros({3},'U3');a:conj(text);eq(text:tolist(),{'1.0','2.0','3.0'})
local reverse=lr.flip(z,1);eq(z:conjugate(reverse),reverse)
eq(lr.real(z):tolist(),{3,1});eq(lr.imag(z):tolist(),{4,-2})
eq(lr.imag(reverse):tolist(),{-2,4})
z:setflags(false);fails(function()z:conj(z)end)
r=z:conj();eq(r.flags.writeable,true)
for _,dtype in ipairs({'S2','U2','datetime64[D]','timedelta64[h]'}) do
    local x=lr.zeros({2},dtype)
    fails(function()x:conj()end);fails(function()x:conjugate()end)
end
for _,bad in ipairs({false,1,'float64',{where=true},{out=false},{1,2},{['out\0']=out}}) do
    fails(function()a:conj(bad)end)
end
fails(function()a:conj(out,out)end)
local z0=lr.array(lr.complex(1,2),'complex64')
local r0=z0:conj();eq(r0.shape,{});eq(r0.ndim,0)
eq(r0.flags.owndata,true);eq(r0.flags.writeable,true);eq(lr.imag(r0):tolist(),-2)
local empty=lr.zeros({0},'float64');eq(empty:conj(),empty)
local scalar=lr.array(3,'float64');eq(scalar:conj(),scalar)
print('conjugate method regression: '..checks..' checks passed')
