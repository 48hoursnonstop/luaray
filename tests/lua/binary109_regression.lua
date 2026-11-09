local np=require('luaray_core')
local checks=0
local function check(v)checks=checks+1;assert(v)end
local function rejects(fn)check(not pcall(fn))end
for _,op in ipairs({'add','subtract','multiply','true_divide','equal','not_equal','less','less_equal',
 'greater','greater_equal','logical_and','logical_or','logical_xor','maximum','minimum','floor_divide',
 'remainder','power','bitwise_and','bitwise_or','bitwise_xor','fmax','fmin','copysign','arctan2','hypot',
 'fmod','float_power'})do
 check(np[op](1,2).ndim==0)
 check(np[op]({1,2,3},2).ndim==1)
 check(np[op](2,{1,2,3}).ndim==1)
 check(np[op]({{1},{2}},{1,2,3}).size==6)
 rejects(function()np[op]()end)
 rejects(function()np[op](np.array({1}))end)
 rejects(function()np[op](np.array({1}),nil)end)
 rejects(function()np[op](1,2,{out=3})end)
 rejects(function()np[op]({1,2},3,{out=np.empty({3})})end)
 rejects(function()np[op]({1,2},3,{out=np.broadcast_to(np.array(0.0),{2})})end)
end
check(np.float_power(np.array({2},'int8'),300).dtype=='float64')
check(np.float_power(2,-3):tolist()==.125)
check(np.fmod(-5,3):tolist()==-2)
check(np.fmod(5,-3):tolist()==2)
check(np.remainder(-5,3):tolist()==1)
check(np.fmod(np.array({-9223372036854775807-1},'int64'),-1):tolist()[1]==0)
local a=np.array({'a\0b','x\0'},'S4')
local out=np.add(a,np.array({'c','y'},'S4'))
check(out.dtype=='|S8' and out:tolist()[1]=='a\0bc' and out:tolist()[2]=='xy')
check(np.add('λ','🙂'):tolist()=='λ🙂')
local c=np.array({'λ','🙂'},'>U2')
check(np.add(c,'!'):tolist()[2]=='🙂!')
for _,op in ipairs({'logical_and','logical_or','logical_xor'})do
 local a=np.array({1},'float16')
 check(np[op](a,1e-100):tolist()[1]==np[op](true,true):tolist())
 check(np[op](a,np.complex(0,1e-100)):tolist()[1]==np[op](true,true):tolist())
 check(np[op](a,'false'):tolist()[1]==np[op](true,true):tolist())
 check(np[op](a,''):tolist()[1]==np[op](true,false):tolist())
end
local dst=np.array({1,2,3},'float64')
check(rawequal(np.add({10,20,30},1,dst,false),dst))
check(dst:tolist()[2]==2)
collectgarbage('collect')
print('binary109 regression: '..checks..' checks passed')
