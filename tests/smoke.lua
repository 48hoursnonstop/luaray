local np = require("luaray_core")
assert(np._version == "0.105.0-dev")

local a = np.array({1, 2, 3, 4})
assert(a.dtype == "int64")
assert(a.ndim == 1 and a.size == 4)
assert(a.shape[1] == 4)
assert(a.strides[1] == 8)
assert(a[1] == 1 and a[-1] == 4)

local b = a * 2
assert(b[1] == 2 and b[4] == 8)
assert(np.mean(b) == 5)

local m = np.zeros({2, 3}, np.float32)
assert(m.dtype == "float32")
assert(m.shape[1] == 2 and m.shape[2] == 3)
assert(m.strides[1] == 12 and m.strides[2] == 4)

-- Adapted from NumPy broadcast tests: (2,1,2) with (1,2,2).
local x = np.reshape(np.arange(4), {2, 1, 2})
local y = np.reshape(np.arange(4), {1, 2, 2})
local z = x + y
assert(z.shape[1] == 2 and z.shape[2] == 2 and z.shape[3] == 2)
local t = z:tolist()
assert(t[1][1][1] == 0)
assert(t[2][2][2] == 6)

-- First-axis numeric indexing is Lua-native 1-based and returns views for nd>1.
local row = np.array({{10,11,12},{20,21,22}})[2]
assert(row[1] == 20 and row[-1] == 22)

local r = np.reshape(np.arange(6), {2,3})
local rt = r.T
assert(rt.shape[1] == 3 and rt.shape[2] == 2)
assert(rt:get(2, 2) == 4)


-- NumPy ufunc-reduction dtype rules and Lua 1-based axes.
do
  local q=np.reshape(np.arange(6,np.int8),{2,3})
  local s=q:sum(2)
  assert(s.dtype=="int64")
  assert(s[1]==3 and s[2]==12)
  local p=np.array({{1,2,3},{4,5,6}},np.uint8):prod(1)
  assert(p.dtype=="uint64")
  assert(p[1]==4 and p[2]==10 and p[3]==18)
  local mf=np.reshape(np.arange(6,np.float32),{2,3}):mean(2)
  assert(mf.dtype=="float32")
  assert(mf[1]==1 and mf[2]==4)
  assert(np.sum(np.arange(10000,np.float32))==49995000.0)
end

print("lua smoke tests: ok")

-- Weak-scalar rules ported from NumPy's dtypemeta.c.
local i1 = np.array({1, 2}, np.int8)
local i1p = i1 + 2
assert(i1p.dtype == "int8" and i1p[1] == 3)
local ok, msg = pcall(function() return i1 + 200 end)
assert(not ok and string.find(msg, "out of bounds for int8", 1, true))
local f4 = np.array({1.0, 2.0}, np.float32)
assert((f4 + 2.0).dtype == "float32")
assert((np.array({1,2}, np.int32) + 2.0).dtype == "float64")


-- Basic slicing/view construction ported from numpy/_core/src/multiarray/mapping.c.
-- Positive slice bounds are Lua-native 1-based; the stop bound is exclusive.
local q = np.reshape(np.arange(24), {2, 3, 4})
local sub = q:get(2, np.slice(1, nil, 2), np.slice(2, 4))
assert(sub.shape[1] == 2 and sub.shape[2] == 2)
local st = sub:tolist()
assert(st[1][1] == 13 and st[1][2] == 14)
assert(st[2][1] == 21 and st[2][2] == 22)

local rev = q:get(np.ellipsis, np.slice(nil, nil, -1))
assert(rev.strides[3] == -8)
assert(rev:get(1, 1, 1) == 3)
assert(rev:get(2, 3, 4) == 20)

local with_axis = q:get(np.newaxis, np.ellipsis)
assert(with_axis.ndim == 4)
assert(with_axis.shape[1] == 1 and with_axis.shape[2] == 2 and with_axis.shape[3] == 3 and with_axis.shape[4] == 4)
assert(with_axis.strides[1] == 0)

-- A single slice token can be used directly as a Lua table key.
local last_block = q[np.slice(2, nil)]
assert(last_block.shape[1] == 1 and last_block:get(1, 1, 1) == 12)

local ok0, err0 = pcall(function() return q:get(0) end)
assert(not ok0 and string.find(err0, "index 0 is invalid", 1, true))
local oke, erre = pcall(function() return q:get(np.ellipsis, np.ellipsis) end)
assert(not oke and string.find(erre, "single ellipsis", 1, true))
local oks, errs = pcall(function() return np.slice(1, 3, 0) end)
assert(not oks and string.find(errs, "slice step cannot be zero", 1, true))


-- PyArray_Pack-style scalar range checks from arraytypes.c.src.
local c_ok = np.array({127.9, -128.9}, np.int8)
assert(c_ok[1] == 127 and c_ok[2] == -128)
local c1, ce1 = pcall(function() return np.array({200}, np.int8) end)
assert(not c1 and string.find(ce1, "out of bounds for int8", 1, true))
local c2, ce2 = pcall(function() return np.array({-1}, np.uint8) end)
assert(not c2 and string.find(ce2, "out of bounds for uint8", 1, true))
local c3, ce3 = pcall(function() return np.array({0/0}, np.int32) end)
assert(not c3 and string.find(ce3, "cannot convert float NaN to integer", 1, true))
assert(np.array({200, -1, 0/0}, np.bool):tolist()[1] == true)

-- shape.c:_attempt_nocopy_reshape + copy-if-needed behavior.
local rr = np.reshape(np.arange(8), {2,4}):get(np.ellipsis, np.slice(1, nil, 2))
assert(rr.shape[1] == 2 and rr.shape[2] == 2)
assert(rr.strides[1] == 32 and rr.strides[2] == 16)
local rrflat = np.reshape(rr, {4})
assert(rrflat.strides[1] == 16)
local rrlist = rrflat:tolist()
assert(rrlist[1] == 0 and rrlist[2] == 2 and rrlist[3] == 4 and rrlist[4] == 6)

local trcopy = np.reshape(np.reshape(np.arange(6), {2,3}).T, {6})
local trlist = trcopy:tolist()
assert(trcopy.strides[1] == 8)
assert(trlist[1] == 0 and trlist[2] == 3 and trlist[3] == 1 and trlist[4] == 4 and trlist[5] == 2 and trlist[6] == 5)

-- Basic scalar assignment follows mapping.c -> PyArray_CopyObject ->
-- array_assign_scalar.c and mutates the shared native buffer.
local av = np.arange(8)
av[2] = 90
assert(av[2] == 90)
av[np.slice(3, 7, 2)] = -5
assert(av[3] == -5 and av[5] == -5 and av[7] == 6)

local am = np.reshape(np.arange(12), {3, 4})
am[2] = 77
assert(am:get(2, 1) == 77 and am:get(2, 4) == 77)
am:set(33, np.slice(1, nil, 2), np.slice(nil, nil, -1))
assert(am:get(1, 1) == 33 and am:get(1, 4) == 33)
assert(am:get(3, 1) == 33 and am:get(3, 4) == 33)

local shared = np.reshape(np.arange(6), {2, 3})
local shared_rev = shared:get(np.ellipsis, np.slice(nil, nil, -1))
shared_rev:set(12)
assert(shared:get(1, 1) == 12 and shared:get(2, 3) == 12)

-- Packing errors occur before iteration, so assignment is atomic for a scalar.
local atomic = np.array({7, 8}, np.int8)
local aok, aerr = pcall(function() atomic:set(200) end)
assert(not aok and string.find(aerr, "out of bounds for int8", 1, true))
assert(atomic[1] == 7 and atomic[2] == 8)


-- Advanced indexing follows mapping.c/PyArrayMapIterObject.  Positive integer
-- arrays use Lua's 1-based convention; result axis placement/strides follow NumPy.
do
  local base=np.reshape(np.arange(12),{3,4})
  local ix=np.array({1,3},np.int64)
  local picked=base:get(ix)
  assert(picked.shape[1]==2 and picked.shape[2]==4)
  assert(picked.strides[1]==32 and picked.strides[2]==8)
  assert(picked:get(2,4)==11)

  local cols=base:get(np.slice(nil,nil,1),np.array({1,4},np.int64))
  assert(cols.shape[1]==3 and cols.shape[2]==2)
  assert(cols.strides[1]==8 and cols.strides[2]==24)
  assert(cols:get(3,2)==11)

  local mask=np.array({{true,false,false,true},{false,true,false,false},{false,false,true,false}},np.bool)
  local masked=base:get(mask)
  assert(masked.ndim==1 and masked.size==4)
  local ml=masked:tolist()
  assert(ml[1]==0 and ml[2]==3 and ml[3]==5 and ml[4]==10)

  local dst=np.arange(6)
  dst:set(np.array({90,91},np.int64),np.array({2,5},np.int64))
  assert(dst[2]==90 and dst[5]==91)
  dst:set(np.array({7,8,9},np.int64),np.array({3,3,3},np.int64))
  assert(dst[3]==9) -- MapIter order: repeated indices are last-write-wins.
end


-- subtract/true_divide use NumPy's ufunc resolver rules and strided loops.
do
  local ai=np.array({1,2},np.int8)
  local bi=np.array({2,4},np.int8)
  local sub=ai-bi
  assert(sub.dtype=='int8' and sub[1]==-1 and sub[2]==-2)
  local div=ai/bi
  assert(div.dtype=='float64' and div[1]==0.5 and div[2]==0.5)
  assert((np.array({1.0,2.0},np.float32)/2).dtype=='float32')
  local left=10-ai
  assert(left.dtype=='int8' and left[1]==9 and left[2]==8)
  local ok,err=pcall(function()
    return np.array({true,false},np.bool)-np.array({true,true},np.bool)
  end)
  assert(not ok and tostring(err):find('boolean subtract',1,true))
end

-- Native NpyIter subset: keep-order allocation, out/where, same_kind casts,
-- and COPY_IF_OVERLAP/writeback.
do
  local f=np.reshape(np.arange(6),{2,3}).T
  local fk=f+f
  assert(fk.strides[1]==8 and fk.strides[2]==24) -- preserve F/keep-order layout

  local a=np.array({1,2,3},np.int8)
  local b=np.array({10,20,30},np.int8)
  local o=np.array({100,100,100},np.int64)
  local m=np.array({true,false,true},np.bool)
  local ret=np.add(a,b,{out=o,where=m})
  assert(ret==o and o[1]==11 and o[2]==100 and o[3]==33)

  local expanded=np.add(np.array({1,2,3},np.int16),1,
                        {where=np.array({{true},{true}},np.bool)})
  assert(expanded.shape[1]==2 and expanded.shape[2]==3)
  assert(expanded:get(2,3)==4)

  local x=np.arange(8)
  np.add(x:get(np.slice(1,8)),10,{out=x:get(np.slice(2,9))})
  local xl=x:tolist()
  assert(xl[1]==0 and xl[2]==10 and xl[3]==11 and xl[8]==16)

  local bad=np.array({9,8},np.int64)
  local ok,err=pcall(function()
    np.add(np.array({1.5,2.5},np.float64),np.array({1.0,1.0},np.float64),{out=bad})
  end)
  assert(not ok and tostring(err):find('same_kind',1,true))
end

-- Extended reduce/accumulate/reduceat semantics come from the ufunc reduction
-- paths in ufunc_object.c/reduction.c.  Axes and public positions are 1-based.
do
  local a=np.reshape(np.arange(24),{2,3,4})
  local r=np.sum(a,{axis={1,3},keepdims=true,initial=1})
  assert(r.shape[1]==1 and r.shape[2]==3 and r.shape[3]==1)
  assert(r:get(1,1,1)==61 and r:get(1,2,1)==93 and r:get(1,3,1)==125)

  local mask=np.array({true,false,true,false},np.bool)
  local s=np.sum(np.array({1,2,3,4},np.int16),{where=mask,initial=10})
  assert(s==14)

  local acc=np.add_accumulate(np.array({100,100,100},np.int8))
  assert(acc.dtype=='int64' and acc[1]==100 and acc[2]==200 and acc[3]==300)
  local accout=np.zeros({3},np.int8)
  np.add_accumulate(np.array({1.6,1.6,1.6},np.float32),{out=accout})
  assert(accout[1]==1 and accout[2]==3 and accout[3]==4)

  local ra=np.add_reduceat(np.arange(5),{1,4,2})
  assert(ra[1]==3 and ra[2]==3 and ra[3]==10)
  local rn=np.add_reduceat(np.arange(5),{-5,-2,-4})
  assert(rn[1]==3 and rn[2]==3 and rn[3]==10)
  local ridx=np.array({1,4,2},np.int16)
  local ri=np.add_reduceat(np.arange(5),ridx)
  assert(ri[1]==3 and ri[2]==3 and ri[3]==10)
end

-- matmul.c.src gufunc semantics: (m?,n),(n,p?)->(m?,p?), including boolean
-- OR-of-AND, batch broadcasting and COPY_IF_OVERLAP out handling.
do
  local a=np.array({{1,2},{3,4}},np.int64)
  local b=np.array({{1,0},{1,1}},np.int64)
  local r=np.matmul(a,b)
  assert(r:get(1,1)==3 and r:get(1,2)==2 and r:get(2,1)==7 and r:get(2,2)==4)
  local v=np.array({1,2},np.int64)
  assert(np.matmul(v,v)==5)
  local vm=np.matmul(v,b)
  assert(vm[1]==3 and vm[2]==2)
  local mv=np.matmul(a,v)
  assert(mv[1]==5 and mv[2]==11)

  local ba=np.reshape(np.arange(12),{2,2,3})
  local bb=np.ones({3,2},np.int64)
  local br=np.matmul(ba,bb)
  assert(br.shape[1]==2 and br.shape[2]==2 and br.shape[3]==2)

  local bo=np.array({{true,false},{false,true}},np.bool)
  local bv=np.array({true,false},np.bool)
  local bt=np.matmul(bv,bo)
  assert(bt[1]==true and bt[2]==false)

  local overlap=np.array({{1,2},{3,4}},np.int64)
  np.matmul(overlap,overlap,{out=overlap})
  assert(overlap:get(1,1)==7 and overlap:get(1,2)==10 and overlap:get(2,1)==15 and overlap:get(2,2)==22)

  -- Large enough homogeneous floating matrices exercise the CBLAS GEMM path.
  local fa=np.reshape(np.arange(12,np.float64),{3,4})
  local fb=np.reshape(np.arange(20,np.float64),{4,5})
  local fr=fa:matmul(fb)
  assert(fr.shape[1]==3 and fr.shape[2]==5 and fr:get(1,1)==70 and fr:get(3,5)==462)
end

-- PyArray_MatrixProduct2 / PyArray_InnerProduct / numeric.outer.
do
  local a=np.reshape(np.arange(6,np.float64),{2,3})
  local b=np.reshape(np.arange(12,np.float64),{3,4})
  local d=np.dot(a,b)
  assert(d.shape[1]==2 and d.shape[2]==4 and d.strides[1]==32 and d.strides[2]==8)
  assert(d:get(2,4)==92)
  assert(a:dot(b):get(1,4)==29)

  local ib=np.array({{1,2,3},{4,5,6}},np.int64)
  local ii=np.inner(np.array({{0,1,2},{3,4,5}},np.int64),ib)
  assert(ii:get(1,1)==8 and ii:get(2,2)==62)

  local o=np.outer(np.array({1,2},np.int64),np.array({3,4,5},np.int64))
  assert(o.shape[1]==2 and o.shape[2]==3 and o:get(2,3)==10)

  -- Non-scalar dot(out=) is strict C-array/exact-dtype like new_array_for_sum.
  local bad=np.zeros({2,4},np.float32)
  local ok,err=pcall(function() np.dot(a,b,{out=bad}) end)
  assert(not ok and tostring(err):find("output array is not acceptable",1,true))
end


-- npysort: default unstable introsort + introselect, with Lua 1-based indices.
do
  local a=np.array({3,1,4,2},np.int64)
  local s=np.sort(a)
  assert(s[1]==1 and s[2]==2 and s[3]==3 and s[4]==4)
  assert(a[1]==3) -- np.sort returns a copy
  local ix=np.argsort(a)
  assert(ix[1]==2 and ix[2]==4 and ix[3]==1 and ix[4]==3)
  local p=np.partition(a,2)
  assert(p[2]==2)
  local ap=np.argpartition(a,2)
  local g=a:get(ap)
  assert(g[2]==2)
  a:sort()
  assert(a[1]==1 and a[4]==4)

  local n=np.array({0/0,2,-1,0/0,1},np.float64)
  local d=np.sort(n,{descending=true})
  assert(d[1]==2 and d[2]==1 and d[3]==-1 and d[4]~=d[4] and d[5]~=d[5])
end


-- item_selection.c:PyArray_SearchSorted + npysort/binsearch.cpp.
do
  local a=np.array({1,3,5,7},np.int32)
  assert(np.searchsorted(a,4)==3)
  assert(np.searchsorted(a,3,"left")==2)
  assert(np.searchsorted(a,3,"right")==3)
  local r=np.searchsorted(a,{0,2,8})
  assert(r[1]==1 and r[2]==2 and r[3]==5)
  local u=np.array({30,10,20},np.int64)
  local sorter=np.argsort(u)
  assert(u:searchsorted(25,{sorter=sorter})==3)
  local f=np.array({-1,1,2,0/0,0/0},np.float64)
  assert(f:searchsorted(0/0)==4 and f:searchsorted(0/0,"right")==6)
end

-- Ufunc catalogue tranche: comparisons/logicals/minmax + unary predicates/sign.
do
  local a=np.array({-2,0,3},np.int64)
  local b=np.array({-1,0,2},np.int64)
  local lt=np.less(a,b)
  assert(lt.dtype=='bool' and lt[1] and not lt[2] and not lt[3])
  assert(np.equal(a,b)[2] and np.not_equal(a,b)[1])
  assert(np.greater_equal(a,b)[2] and np.greater(a,b)[3])

  local mx=np.maximum(a,b)
  local mn=np.minimum(a,b)
  assert(mx[1]==-1 and mx[3]==3 and mn[1]==-2 and mn[3]==2)
  local la=np.logical_and(np.array({0,1,2}),np.array({3,0,4}))
  assert(not la[1] and not la[2] and la[3])

  local f=np.array({-math.huge,-0.0,2.5,0/0},np.float64)
  local neg=np.negative(f)
  assert(neg[1]==math.huge and neg[3]==-2.5)
  local ab=np.abs(np.array({-3,2},np.int16))
  assert(ab[1]==3 and ab[2]==2)
  local edge=np.array({-128},np.int8)
  assert(np.abs(edge)[1]==-128 and np.negative(edge)[1]==-128)
  local sg=np.sign(np.array({-4.0,0.0,7.0},np.float32))
  assert(sg[1]==-1 and sg[2]==0 and sg[3]==1)
  local fin=np.isfinite(f)
  assert(not fin[1] and fin[2] and fin[3] and not fin[4])
  assert(np.isinf(f)[1] and np.isnan(f)[4] and np.signbit(f)[1])

  -- Exact qQ/Qq path from loops.c.src: float64 promotion would lose this bit.
  local si=np.array({9007199254740993},np.int64)
  local ui=np.array({9007199254740992},np.uint64)
  assert(not np.equal(si,ui)[1] and np.greater(si,ui)[1])

  local out=np.zeros({3},np.int8)
  local mask=np.array({true,false,true},np.bool)
  np.greater(a,b,{out=out,where=mask})
  assert(out[1]==0 and out[2]==0 and out[3]==1)

  local ok,err=pcall(function() return np.negative(np.array({true},np.bool)) end)
  assert(not ok and tostring(err):find('boolean negative',1,true))
end

-- NumPy arithmetic/bitwise/minmax tranche translated from generated ufunc loops.
do
  local a=np.array({-7,-7,7,7},np.int16)
  local b=np.array({3,-3,3,-3},np.int16)
  local q=np.floor_divide(a,b)
  local r=np.remainder(a,b)
  assert(q[1]==-3 and q[2]==2 and q[3]==2 and q[4]==-3)
  assert(r[1]==2 and r[2]==-1 and r[3]==1 and r[4]==-2)
  assert((np.array({2,3},np.int16)^np.array({3,2},np.int16))[1]==8)
  local bits=np.bitwise_xor(np.array({5,7},np.uint8),np.array({3,1},np.uint8))
  assert(bits[1]==6 and bits[2]==6)
  local f=np.fmax(np.array({0/0,-0.0,2.0}),np.array({1.0,0.0,0/0}))
  assert(f[1]==1 and f[2]==0 and f[3]==2)
  local c=np.copysign(np.array({1.0,2.0},np.float32),np.array({-1.0,1.0},np.float32))
  assert(c[1]==-1 and c[2]==2)
end

-- Floating math ufuncs.  int16/uint16 resolve to float32, wider integers to
-- Mathematical ufuncs now include native float16 resolver/loop paths.
do
  local a=np.array({1,4,9,16},np.int16)
  local s=np.sqrt(a)
  assert(s.dtype=='float32' and s[1]==1 and s[2]==2 and s[3]==3 and s[4]==4)
  local e=np.exp(np.array({0.0,1.0},np.float64))
  assert(e.dtype=='float64' and math.abs(e[1]-1)<1e-12 and math.abs(e[2]-math.exp(1))<1e-12)
  local l=np.log(np.array({1.0,math.exp(1)},np.float64))
  assert(math.abs(l[1])<1e-12 and math.abs(l[2]-1)<1e-12)
  local z=np.array({-0.0,0.0},np.float64)
  local sn=np.sin(z)
  assert(1/sn[1]==-math.huge and 1/sn[2]==math.huge)
  local co=np.cos(np.array({0.0},np.float32))
  assert(co[1]==1)
  local ta=np.tan(np.array({0.0},np.float64))
  assert(ta[1]==0)
  local h=np.sqrt(np.array({1,4,9},np.int8))
  assert(h.dtype=='float16' and h[1]==1 and h[2]==2 and h[3]==3)
  local o=np.ones({2},np.float64)*3
  np.exp(np.array({0,1},np.int16),{out=o,where=np.array({true,false},np.bool)})
  assert(math.abs(o[1]-1)<1e-12 and o[2]==3)
end


-- Complex dtype/storage/arithmetic/math smoke (NumPy COMPLEX loops + npymath port).
do
  local z = np.array({np.complex(1,2), np.complex(-1,0)}, np.complex128)
  assert(z.dtype == "complex128")
  assert(z[1].real == 1 and z[1].imag == 2)
  local q = np.multiply(z, np.complex(0,1))
  assert(q[1].real == -2 and q[1].imag == 1)
  local p = np.power(np.array({np.complex(1,1)}, np.complex128),
                     np.array({np.complex(2,0)}, np.complex128))
  assert(math.abs(p[1].real) < 1e-12 and math.abs(p[1].imag - 2) < 1e-12)
  local e = np.exp(np.array({np.complex(0, math.pi)}, np.complex128))[1]
  assert(math.abs(e.real + 1) < 1e-12 and math.abs(e.imag) < 1e-12)
end

-- Extended NumPy real/complex elementary math + complex CBLAS paths.
do
  local h=np.sinh(np.array({0,1},np.int8))
  assert(h.dtype=='float16' and h[1]==0)
  local e2=np.exp2(np.array({0,1,2},np.float32))
  assert(e2.dtype=='float32' and e2[1]==1 and e2[2]==2 and e2[3]==4)
  local l2=np.log2(np.array({1,2,4},np.float64))
  assert(math.abs(l2[1])<1e-12 and math.abs(l2[2]-1)<1e-12 and math.abs(l2[3]-2)<1e-12)
  local l10=np.log10(np.array({1,10,100},np.float64))
  assert(math.abs(l10[1])<1e-12 and math.abs(l10[2]-1)<1e-12 and math.abs(l10[3]-2)<1e-12)
  assert(math.abs(np.expm1(np.array({0.0},np.float64))[1])<1e-12)
  assert(math.abs(np.log1p(np.array({0.0},np.float64))[1])<1e-12)
  local cb=np.cbrt(np.array({-8.0,27.0},np.float64))
  assert(math.abs(cb[1]+2)<1e-12 and math.abs(cb[2]-3)<1e-12)

  local z=np.array({np.complex(0,0),np.complex(1,0)},np.complex128)
  local sh=np.sinh(z)
  assert(math.abs(sh[1].real)<1e-12 and math.abs(sh[1].imag)<1e-12)
  local zlp=np.log1p(np.array({np.complex(1,0)},np.complex128))[1]
  assert(math.abs(zlp.real-math.log(2))<1e-12 and math.abs(zlp.imag)<1e-12)

  -- These contiguous complex matrices exercise cblas_zgemm/cdotu via the selector.
  local a=np.array({{np.complex(1,1),np.complex(2,0)},
                    {np.complex(0,1),np.complex(3,-1)}},np.complex128)
  local b=np.array({{np.complex(1,0),np.complex(0,1)},
                    {np.complex(2,-1),np.complex(1,0)}},np.complex128)
  local m=np.matmul(a,b)
  assert(math.abs(m:get(1,1).real-5)<1e-12 and math.abs(m:get(1,1).imag+1)<1e-12)
  local d=np.dot(np.array({np.complex(1,1),np.complex(2,0)},np.complex128),
                 np.array({np.complex(3,0),np.complex(0,1)},np.complex128))
  assert(math.abs(d.real-3)<1e-12 and math.abs(d.imag-5)<1e-12)
end


-- NumPy inverse trig/hyperbolic + atan2/hypot tranche.
do
  local x=np.array({-0.5,0.0,0.5},np.float32)
  assert(np.arcsin(x).dtype=='float32')
  assert(math.abs(np.asin(x)[3]-0.5235987901687622)<1e-6)
  assert(math.abs(np.arctan(x)[1]+0.46364760398864746)<1e-6)
  assert(math.abs(np.arcsinh(x)[3]-0.4812118113040924)<1e-6)
  local h=np.hypot(np.array({3},np.int8),np.array({4},np.int8))
  assert(h.dtype=='float16' and math.abs(h[1]-5.0)<1e-3)
  local a=np.atan2(np.array({1.0},np.float64),np.array({-1.0},np.float64))
  assert(math.abs(a[1]-2.356194490192345)<1e-12)
  local z=np.array({np.complex(-2.0,-0.0)},np.complex128)
  local az=np.arccos(z)[1]
  assert(type(az)=='userdata' and az.imag>0)
end


-- Native PocketFFT first tranche.  Axis values are Lua 1-based.
do
  local function near(a,b,e) return math.abs(a-b)<(e or 1e-9) end
  local x=np.array({0,1,0,0},np.float64)
  local y=np.fft.fft(x)
  assert(y.dtype=='complex128' and y.shape[1]==4)
  assert(near(y[1].real,1) and near(y[2].imag,-1) and near(y[3].real,-1) and near(y[4].imag,1))
  local z=np.fft.ifft(y)
  for i=1,4 do assert(near(z[i].real,x[i])) end
  local r=np.fft.rfft(x)
  assert(r.dtype=='complex128' and r.shape[1]==3 and near(r[2].imag,-1))
  local q=np.fft.irfft(r,{n=4})
  for i=1,4 do assert(near(q[i],x[i])) end
  assert(np.fft.fft(np.array({1,2},np.float16)).dtype=='complex64')
  assert(np.fft.irfft(np.array({1,2,3},np.float16)).dtype=='float16')
  local m=np.reshape(np.arange(8,np.float32),{2,4}).T
  local fm=np.fft.fft(m,{axis=1,n=5,norm='ortho'})
  assert(fm.shape[1]==5 and fm.shape[2]==2 and fm.strides[1]==8)
  local o=np.zeros({4},np.complex128)
  assert(np.fft.fft(np.array({0,1,0,0},np.float32),{out=o})==o)
  assert(near(o[2].imag,-1,1e-12))
end


-- N-dimensional PocketFFT wrappers mirror _cook_nd_args/_raw_fftnd.
do
  local function near(a,b,e) return math.abs(a-b)<(e or 1e-9) end
  local a=np.ones({2,3},np.float64)
  local f=np.fft.fft2(a)
  assert(f.shape[1]==2 and f.shape[2]==3 and near(f:get(1,1).real,6))
  local rf=np.fft.rfft2(a)
  assert(rf.shape[1]==2 and rf.shape[2]==2)
  local back=np.fft.irfft2(rf,{s={2,3}})
  for i=1,2 do for j=1,3 do assert(near(back:get(i,j),1,1e-12)) end end
  local x=np.reshape(np.arange(24,np.float64),{2,3,4})
  local y=np.fft.fftn(x,{axes={1,3},norm='ortho'})
  assert(y.shape[1]==2 and y.shape[2]==3 and y.shape[3]==4)
  local rep=np.fft.fftn(x,{axes={2,2}})
  assert(rep.shape[1]==2 and rep.shape[2]==3 and rep.shape[3]==4)
  assert(np.fft.fftn(x,{s={}})==x)
end

-- NumPy linalg-lite path: GESV / GETRF / POTRF with NumPy _commonType rules.
do
  local a=np.array({{1,2},{3,5}})
  local b=np.array({1,2})
  local x=np.linalg.solve(a,b)
  assert(x.dtype=='float64' and math.abs(x[1]+1)<1e-12 and math.abs(x[2]-1)<1e-12)

  local f=np.array({{1.0,2.0},{3.0,4.0}},np.float32)
  local fi=np.linalg.inv(f)
  assert(fi.dtype=='float32' and math.abs(fi:get(1,1)+2)<1e-5 and math.abs(fi:get(2,2)+0.5)<1e-5)
  assert(math.abs(np.linalg.det(f)+2)<1e-5)
  local sg,lg=np.linalg.slogdet(f)
  assert(math.abs(sg+1)<1e-6 and math.abs(lg-math.log(2))<1e-5)

  local c=np.linalg.cholesky(np.array({{4.0,2.0},{2.0,3.0}}))
  assert(math.abs(c:get(1,1)-2)<1e-12 and c:get(1,2)==0 and math.abs(c:get(2,2)-math.sqrt(2))<1e-12)
  local u=np.linalg.cholesky(np.array({{4.0,2.0},{2.0,3.0}}),{upper=true})
  assert(u:get(2,1)==0 and math.abs(u:get(1,2)-1)<1e-12)

  local ca=np.array({{np.complex(2,0),np.complex(1,1)},{np.complex(1,-1),np.complex(3,0)}},np.complex64)
  local ci=np.linalg.inv(ca)
  assert(ci.dtype=='complex64')
  local cd=np.linalg.det(ca)
  assert(math.abs(cd.real-4)<1e-5 and math.abs(cd.imag)<1e-5)
end


-- QR follows NumPy's GEQRF + ORGQR/UNGQR path and mode surface.
do
  local function near(a,b,e) return math.abs(a-b)<(e or 1e-9) end
  local a=np.array({{1.0,2.0},{3.0,4.0},{5.0,6.0}},np.float64)
  local q,r=np.linalg.qr(a)
  assert(q.shape[1]==3 and q.shape[2]==2 and r.shape[1]==2 and r.shape[2]==2)
  local rec=np.matmul(q,r)
  for i=1,3 do for j=1,2 do assert(near(rec:get(i,j),a:get(i,j),1e-10)) end end

  local qc,rc=np.linalg.qr(a,"complete")
  assert(qc.shape[1]==3 and qc.shape[2]==3 and rc.shape[1]==3 and rc.shape[2]==2)
  local rr=np.linalg.qr(a,"r")
  assert(rr.shape[1]==2 and rr.shape[2]==2)
  local h,tau=np.linalg.qr(a,"raw")
  assert(h.shape[1]==2 and h.shape[2]==3 and tau.shape[1]==2)

  local z=np.array({{np.complex(1,1),np.complex(2,0)},
                    {np.complex(3,0),np.complex(4,-1)}},np.complex64)
  local zq,zr=np.linalg.qr(z)
  assert(zq.dtype=='complex64' and zr.dtype=='complex64')
  local zr2=np.matmul(zq,zr)
  for i=1,2 do for j=1,2 do
    local got,want=zr2:get(i,j),z:get(i,j)
    assert(near(got.real,want.real,2e-5) and near(got.imag,want.imag,2e-5))
  end end
end


-- Eigenvalue/SVD tranche follows NumPy main's GEEV, SYEVD/HEEVD and GESDD paths.
do
  local function near(a,b,e) return math.abs(a-b)<(e or 1e-9) end

  -- NumPy main returns complex results for eig/eigvals even when a real
  -- matrix happens to have a purely real spectrum.
  local a=np.array({{2.0,0.0},{0.0,3.0}},np.float32)
  local w,v=np.linalg.eig(a)
  assert(w.dtype=='complex64' and v.dtype=='complex64')
  assert(near(w:get(1).imag,0,1e-6) and near(w:get(2).imag,0,1e-6))
  local ew=np.linalg.eigvals(a)
  assert(ew.dtype=='complex64')

  local h=np.array({{2.0,1.0},{1.0,2.0}},np.float64)
  local hw,hv=np.linalg.eigh(h)
  assert(hw.dtype=='float64' and hv.dtype=='float64')
  assert(near(hw:get(1),1,1e-12) and near(hw:get(2),3,1e-12))
  local ho=np.linalg.eigvalsh(h,'U')
  assert(near(ho:get(1),1,1e-12) and near(ho:get(2),3,1e-12))

  local m=np.array({{3.0,0.0},{0.0,2.0},{0.0,0.0}},np.float64)
  local u,s,vh=np.linalg.svd(m,{full_matrices=false})
  assert(u.shape[1]==3 and u.shape[2]==2 and s.shape[1]==2 and vh.shape[1]==2 and vh.shape[2]==2)
  assert(near(s:get(1),3,1e-12) and near(s:get(2),2,1e-12))
  local rec=np.matmul(np.multiply(u,np.reshape(s,{1,2})),vh)
  for i=1,3 do for j=1,2 do assert(near(rec:get(i,j),m:get(i,j),1e-10)) end end
  local sv=np.linalg.svdvals(m)
  assert(near(sv:get(1),3,1e-12) and near(sv:get(2),2,1e-12))

  -- NumPy explicitly forces full-SVD empty outputs to identities because
  -- LAPACK leaves those buffers uninitialized.
  local eu,es,evh=np.linalg.svd(np.empty({4,0},np.float64))
  assert(es.shape[1]==0 and eu:get(1,1)==1 and eu:get(1,2)==0)
  assert(evh.shape[1]==0 and evh.shape[2]==0)
end

-- Advanced linalg tranche: GELSD plus SVD/inverse-derived helpers from NumPy main.
do
  local function near(a,b,e) return math.abs(a-b)<(e or 1e-9) end

  -- Scalar construction is required by matrix_rank's upstream array-like semantics.
  local scalar=np.array(3)
  assert(scalar.ndim==0 and scalar.dtype=='int64' and np.linalg.matrix_rank(scalar)==1)

  local a=np.array({{0.0,1.0},{1.0,1.0},{2.0,1.0},{3.0,1.0}})
  local b=np.array({-1.0,0.2,0.9,2.1})
  local x,res,rank,s=np.linalg.lstsq(a,b)
  assert(rank==2 and x.dtype=='float64' and res.dtype=='float64' and s.dtype=='float64')
  assert(near(x:get(1),1.0,1e-12) and near(x:get(2),-0.95,1e-12))
  assert(res.shape[1]==1 and near(res:get(1),0.05,1e-12))

  local d=np.array({{1.0,0.0},{0.0,0.1}})
  local p=np.linalg.pinv(d)
  assert(near(p:get(1,1),1,1e-12) and near(p:get(2,2),10,1e-12))
  assert(np.linalg.matrix_rank(d)==2)
  local ranks=np.linalg.matrix_rank(d,{tol=np.array({0.05,0.2})})
  assert(ranks.dtype=='int64' and ranks.shape[1]==2 and ranks:get(1)==2 and ranks:get(2)==1)

  local v=np.array({3.0,4.0})
  assert(near(np.linalg.norm(v),5,1e-12))
  local rows=np.linalg.norm(np.array({{3.0,4.0},{5.0,12.0}}),{axis=2})
  assert(near(rows:get(1),5,1e-12) and near(rows:get(2),13,1e-12))
  local ok=pcall(function() np.linalg.norm(v,{axis=0}) end)
  assert(not ok)

  local c=np.linalg.cond(np.array({{1.0,0.0},{0.0,2.0}}))
  assert(near(c,2,1e-12))
end

-- NumPy-main linalg public-surface closure tranche.
do
  local function near(a,b,e) return math.abs(a-b)<(e or 1e-9) end

  local a=np.array({{1.0,2.0},{3.0,4.0}})
  local a2=np.linalg.matrix_power(a,2)
  assert(near(a2:get(1,1),7) and near(a2:get(2,2),22))
  assert(np.linalg.matrix_power(a,1)==a)
  local ident=np.linalg.matrix_power(a,0)
  assert(ident:get(1,1)==1 and ident:get(1,2)==0 and ident:get(2,1)==0 and ident:get(2,2)==1)

  local eye6=np.array({
    {1,0,0,0,0,0},{0,1,0,0,0,0},{0,0,1,0,0,0},
    {0,0,0,1,0,0},{0,0,0,0,1,0},{0,0,0,0,0,1}
  })
  local ti=np.linalg.tensorinv(np.reshape(eye6,{2,3,3,2}),2)
  assert(ti.shape[1]==3 and ti.shape[2]==2 and ti.shape[3]==2 and ti.shape[4]==3)
  local ta=np.reshape(eye6,{2,3,6})
  local tb=np.ones({2,3})
  local tx=np.linalg.tensorsolve(ta,tb)
  assert(tx.shape[1]==6)
  local tb2=np.linalg.tensordot(ta,tx,1)
  assert(near(tb2:get(1,1),1) and near(tb2:get(2,3),1))

  local md=np.linalg.multi_dot({np.ones({2,3}),np.ones({3,4}),np.ones({4,2})})
  assert(md.shape[1]==2 and md.shape[2]==2 and md:get(1,1)==12)
  local ov=np.linalg.outer(np.array({1,2}),np.array({3,4,5}))
  assert(ov.shape[1]==2 and ov.shape[2]==3 and ov:get(2,3)==10)

  local q=np.reshape(np.arange(24),{2,3,4})
  local dg=np.linalg.diagonal(q)
  assert(dg.shape[1]==2 and dg.shape[2]==3 and dg:get(1,2)==5)
  local tr=np.linalg.trace(q)
  assert(tr.shape[1]==2 and tr:get(1)==15 and tr:get(2)==51)

  local cr=np.linalg.cross(np.array({1,2,3}),np.array({4,5,6}))
  assert(cr:get(1)==-3 and cr:get(2)==6 and cr:get(3)==-3)
  local td=np.linalg.tensordot(np.reshape(np.arange(6),{2,3}),np.reshape(np.arange(6),{2,3}))
  assert(td==55)
  local mm=np.linalg.matmul(np.reshape(np.arange(6),{2,3}),np.linalg.matrix_transpose(np.reshape(np.arange(6),{2,3})))
  assert(mm:get(1,1)==5 and mm:get(2,2)==50)

  local mn=np.linalg.matrix_norm(np.reshape(np.arange(9),{3,3}))
  assert(near(mn,math.sqrt(204),1e-12))
  local vn=np.linalg.vector_norm(np.array({3.0,4.0}))
  assert(near(vn,5,1e-12))
  local vd=np.linalg.vecdot(np.array({np.complex(1,2),np.complex(3,4)}),
                            np.array({np.complex(5,6),np.complex(7,8)}))
  assert(near(vd.real,70,1e-12) and near(vd.imag,-8,1e-12))
end

-- Generic host-neutral ufunc registry / N-in N-out iterator tranche.
do
  local function near(a,b,e) return math.abs(a-b)<(e or 1e-6) end

  local a=np.array({5.7,-2.5,0.0,-0.0},np.float64)
  local m,e=np.frexp(a)
  assert(m.dtype=='float64' and e.dtype=='int32')
  assert(near(m:get(1),0.7125) and e:get(1)==3)
  assert(near(m:get(2),-0.625) and e:get(2)==2)
  assert(m:get(3)==0 and e:get(3)==0)

  local frac,whole=np.modf(a)
  assert(near(frac:get(1),0.7) and whole:get(1)==5)
  assert(near(frac:get(2),-0.5) and whole:get(2)==-2)

  local q,r=np.divmod(np.array({71,-71,5},np.int64),np.array({19,19,-2},np.int64))
  assert(q:get(1)==3 and r:get(1)==14)
  assert(q:get(2)==-4 and r:get(2)==5)
  assert(q:get(3)==-3 and r:get(3)==-1)

  local out1=np.array({99.0,99.0,99.0},np.float64)
  local out2=np.array({77,77,77},np.int32)
  local fm,fe=np.frexp(np.array({2.0,4.0,8.0}),{out={out1,out2},where=np.array({true,false,true})})
  assert(fm==out1 and fe==out2)
  assert(out1:get(1)==0.5 and out1:get(2)==99 and out1:get(3)==0.5)
  assert(out2:get(1)==2 and out2:get(2)==77 and out2:get(3)==4)

  local scaled=np.ldexp(np.array({0.5,-0.5,1.0},np.float32),np.array({1,2,-1},np.int64))
  assert(scaled.dtype=='float32')
  assert(near(scaled:get(1),1) and near(scaled:get(2),-2) and near(scaled:get(3),0.5))
end


-- First parameterized DTypes: datetime64/timedelta64.
do
  local d=np.array({np.datetime64(1,'D'),np.datetime64(2,'D')},'datetime64[D]')
  local t=np.array({np.timedelta64(24,'h'),np.timedelta64('NaT','h')},'timedelta64[h]')
  local r=np.add(d,t)
  assert(r.dtype=='datetime64[h]' and r[1].value==48 and r[2].isnat)
  local delta=np.subtract(d,np.array({np.datetime64(0,'h'),np.datetime64(24,'h')},'datetime64[h]'))
  assert(delta.dtype=='timedelta64[h]' and delta[1].value==24 and delta[2].value==24)
  local n=np.isnat(t)
  assert(n.dtype=='bool' and n[1]==false and n[2]==true)
end


-- ISO-8601 datetime string parsing/formatting from NumPy datetime_strings.c.
do
  local d=np.datetime64('2026-10-07T15:30:45.123456789')
  assert(d.dtype=='datetime64[ns]' and tostring(d)=='2026-10-07T15:30:45.123456789')
  assert(np.datetime_as_string(d)=='2026-10-07T15:30:45.123456789')
  assert(np.datetime_as_string(d,{unit='D',casting='unsafe'})=='2026-10-07')
  assert(np.datetime_as_string(d,{unit='auto'})=='2026-10-07T15:30:45.123456789')
  assert(np.datetime_as_string(np.datetime64('2010-03-15T06:30','m'),{timezone='UTC'})=='2010-03-15T06:30Z')
  local z=np.datetime64('1977-03-02T12:30-0230')
  assert(tostring(z)=='1977-03-02T15:00')
  local a=np.array({'1980-02-29T01:02:03','1980-02-29 01:02:04Z','NaT'},'datetime64[s]')
  assert(a[1].iso=='1980-02-29T01:02:03' and a[2].iso=='1980-02-29T01:02:04' and a[3].isnat)
  assert(np.datetime64('today').dtype=='datetime64[D]')
  assert(np.datetime64('now').dtype=='datetime64[s]')
  local g=np.array({'2010','2010-01-02'},'datetime64')
  assert(g.dtype=='datetime64[D]' and g[1].value==14610 and g[2].value==14611)
end


-- NumPy legacy fixed-width string/unicode DTypes are real ndarrays.
do
  local u=np.array({'a','bb','é','😊'})
  assert(u.dtype=='<U2')
  assert(u[1]=='a' and u[2]=='bb' and u[3]=='é' and u[4]=='😊')

  local trunc=np.array({'abcdef','é😊x'},'U3')
  assert(trunc.dtype=='<U3' and trunc[1]=='abc' and trunc[2]=='é😊x')

  local be=np.array({'é','😊'},'>U1')
  assert(be.dtype=='>U1' and be[1]=='é' and be[2]=='😊')

  local bs=np.array({'a','bb'},'S3')
  assert(bs.dtype=='|S3' and bs[1]=='a' and bs[2]=='bb')
  bs[1]='xyzq'
  assert(bs[1]=='xyz')

  local cmp=np.equal(np.array({'a','bb'},'U2'),'bb')
  assert(cmp.dtype=='bool' and cmp[1]==false and cmp[2]==true)

  local dt=np.array({'2026-10-07','2026-10-08'},'datetime64[D]')
  local ds=np.datetime_as_string(dt)
  assert(ds.dtype=='<U28')
  assert(ds[1]=='2026-10-07' and ds[2]=='2026-10-08')
end


-- 0.28 legacy string/numeric/temporal cast matrix and mixed discovery.
do
  local i=np.array({1,-2,127},np.int8)
  local su=i:astype('U')
  assert(su.dtype=='<U4' and su[1]=='1' and su[2]=='-2' and su[3]=='127')

  local f=np.array({'1.5','  -2.25 ','nan'},'U10'):astype('float32')
  assert(f.dtype=='float32' and math.abs(f[1]-1.5)<1e-6 and math.abs(f[2]+2.25)<1e-6 and f[3]~=f[3])

  local z=np.array({'1+2j','-3j'},'U8'):astype('complex64')
  assert(z.dtype=='complex64' and math.abs(z[1].real-1)<1e-6 and math.abs(z[1].imag-2)<1e-6 and math.abs(z[2].real)<1e-6 and math.abs(z[2].imag+3)<1e-6)

  local d=np.array({1,-2},np.int64):astype('datetime64[D]')
  assert(d.dtype=='datetime64[D]' and d[1].value==1 and d[2].value==-2)
  local back=d:astype('int64')
  assert(back[1]==1 and back[2]==-2)

  local inferred=np.array({'2011-03-16','1920-01-01'},'U10'):astype('datetime64')
  assert(inferred.dtype=='datetime64[D]')

  local mixed=np.array({1,'x'})
  assert(mixed.dtype=='<U21' and mixed[1]=='1' and mixed[2]=='x')
end
