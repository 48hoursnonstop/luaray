local np=require('luaray_core')
local function near(a,b,eps) assert(math.abs(a-b) <= (eps or 1e-10), tostring(a)..' ~= '..tostring(b)) end
local function flat(x) return x:tolist() end

local A=np.array({{1,2},{3,4}},np.float64)
local p2=np.linalg.matrix_power(A,2)
assert(p2:get(1,1)==7 and p2:get(2,2)==22)
local p0=np.linalg.matrix_power(np.array({{1,2},{3,4}},np.int64),0)
assert(p0.dtype=='int64' and p0:get(1,1)==1 and p0:get(1,2)==0)
local pm=np.linalg.matrix_power(A,-1)
near(pm:get(1,1),-2)

local ai=np.reshape(np.array({1,0,0,1},np.float64),{2,2})
local ti=np.linalg.tensorinv(ai,1)
assert(ti.shape[1]==2 and ti.shape[2]==2)
local ts=np.linalg.tensorsolve(ai,np.array({5,7},np.float64))
near(ts:get(1),5);near(ts:get(2),7)

local md=np.linalg.multi_dot({np.array({{1,2}},np.float64),np.array({{3},{4}},np.float64),np.array({{2,0}},np.float64)})
assert(md.shape[1]==1 and md.shape[2]==2);near(md:get(1,1),22);near(md:get(1,2),0)

local o=np.linalg.outer(np.array({1,2}),np.array({3,4,5}))
assert(o:get(2,3)==10)
local x=np.reshape(np.arange(60),{3,4,5})
local d=np.linalg.diagonal(x)
assert(d.shape[1]==3 and d.shape[2]==4 and d:get(2,4)==38)
local tr=np.linalg.trace(x)
assert(tr:get(1)==36 and tr:get(3)==196)

local cr=np.linalg.cross(np.array({1,2,3}),np.array({4,5,6}))
assert(cr:get(1)==-3 and cr:get(2)==6 and cr:get(3)==-3)
local td=np.linalg.tensordot(np.reshape(np.arange(6),{2,3}),np.reshape(np.arange(6),{2,3}))
assert(td==55)
local mm=np.linalg.matmul(np.array({{1,2},{3,4}}),np.array({{5,6},{7,8}}))
assert(mm:get(2,2)==50)
local mt=np.linalg.matrix_transpose(np.reshape(np.arange(6),{2,3}))
assert(mt.shape[1]==3 and mt.shape[2]==2 and mt:get(3,2)==5)

local mn=np.linalg.matrix_norm(np.reshape(np.arange(9),{3,3}))
near(mn,math.sqrt(204))
local vn=np.linalg.vector_norm(np.reshape(np.arange(9),{3,3}))
near(vn,math.sqrt(204))
local vn0=np.linalg.vector_norm(np.reshape(np.arange(9),{3,3}),{axis=1})
near(vn0:get(1),math.sqrt(45))

local z1=np.array({np.complex(1,2),np.complex(3,4)},np.complex128)
local z2=np.array({np.complex(5,6),np.complex(7,8)},np.complex128)
local vd=np.linalg.vecdot(z1,z2)
-- conj([1+2i,3+4i]) dot [5+6i,7+8i] = 70-8i
near(vd.real,70);near(vd.imag,-8)
print('manual linalg019: ok')
