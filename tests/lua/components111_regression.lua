local np=require('luaray_core')
local checks=0
local function check(v)checks=checks+1;assert(v)end
for _,dt in ipairs({'complex64','complex128','clongdouble'})do
 local a=np.array({np.complex(1,2),np.complex(3,4)},dt)
 local real,imag=a.real,a.imag
 check(np.shares_memory(real,a) and np.shares_memory(imag,a))
 check(not np.shares_memory(real,imag))
 check(np.may_share_memory(real,imag))
 np.copyto(real,7,'unsafe');check(a:tolist()[1].real==7 and a:tolist()[1].imag==2)
 np.copyto(imag,-3,'unsafe');check(a:tolist()[2].real==7 and a:tolist()[2].imag==-3)
 local ro=np.broadcast_to(a:get(np.s(1,2)),{3})
 check(not pcall(function()np.copyto(ro.real,1,'unsafe')end))
 check(not pcall(function()np.copyto(ro.imag,1,'unsafe')end))
 a=nil;collectgarbage('collect');check(real:tolist()[2]==7 and imag:tolist()[2]==-3)
end
local a=np.array({1,2,3})
check(rawequal(a,a.real) and rawequal(a,np.real(a)))
check(not pcall(function()np.copyto(a.imag,7,'unsafe')end))
check(np.imag(a):tolist()[2]==0 and a:tolist()[2]==2)
check(np.real(3):tolist()==3 and np.imag(3):tolist()==0)
check(np.real(np.complex(2,3)):tolist()==2)
check(np.imag(np.complex(2,3)):tolist()==3)
check(not pcall(function()np.real()end))
check(not pcall(function()np.imag()end))
check(not pcall(function()a.real=np.array({3,2,1})end))
print('components111 regression: '..checks..' checks passed')
