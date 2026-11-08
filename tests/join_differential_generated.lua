local np=require('luaray_core')
local n=0

local function same(a,b)
  if type(b)=='table' then
    assert(type(a)=='table','expected nested list')
    for k,v in ipairs(b) do same(a[k],v) end
    assert(#a==#b,'list length')
  elseif type(b)=='number' then
    if type(a)=='userdata' then
      assert(math.abs(a.real-b)<=1e-5 and math.abs(a.imag)<=1e-5)
    else
      assert(type(a)=='number' and (a==b or (a~=a and b~=b) or
             math.abs(a-b)<=1e-5 * math.max(1,math.abs(b))),tostring(a)..' != '..tostring(b))
    end
  elseif type(b)=='userdata' then
    assert(type(a)=='userdata' and math.abs(a.real-b.real)<=1e-5 and
           math.abs(a.imag-b.imag)<=1e-5,'complex mismatch')
  elseif type(b)=='string' then
    assert(a==b,'string '..tostring(a)..' != '..b)
  elseif type(b)=='boolean' then
    assert(a==b,'boolean mismatch')
  end
end
local function check(x, dtype, shape, values)
  local actual_dtype=x.dtype:gsub('^[<>|=]','')
  assert(actual_dtype==dtype,('dtype '..tostring(x.dtype)..' != '..dtype))
  assert(x.ndim==#shape,'rank')
  for i=1,#shape do assert(x.shape[i]==shape[i], 'shape axis '..i) end
  same(x:tolist(),values)
end

-- case 1: int8+int16 concat shape=(3,), axis=1
do
 local a1=np.reshape(np.array({-2,1,3},"int8"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int16"),{3})
 local got=np.concatenate({a1,a2},1)
 check(got,"int16",{6},{-2,1,3,-2,1,3})
 n=n+1
end
-- case 2: int8+int16 concat shape=(3,), axis=False
do
 local a1=np.reshape(np.array({-2,1,3},"int8"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int16"),{3})
 local got=np.concatenate({a1,a2},false)
 check(got,"int16",{6},{-2,1,3,-2,1,3})
 n=n+1
end
-- case 3: int8+int16 stack shape=(3,), axis=1
do
 local a1=np.reshape(np.array({-2,1,3},"int8"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int16"),{3})
 local got=np.stack({a1,a2},1)
 check(got,"int16",{2,3},{{-2,1,3},{-2,1,3}})
 n=n+1
end
-- case 4: int8+int16 stack shape=(3,), axis=2
do
 local a1=np.reshape(np.array({-2,1,3},"int8"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int16"),{3})
 local got=np.stack({a1,a2},2)
 check(got,"int16",{3,2},{{-2,-2},{1,1},{3,3}})
 n=n+1
end
-- case 5: int8+int16 stack shape=(3,), axis=-1
do
 local a1=np.reshape(np.array({-2,1,3},"int8"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int16"),{3})
 local got=np.stack({a1,a2},-1)
 check(got,"int16",{3,2},{{-2,-2},{1,1},{3,3}})
 n=n+1
end
-- case 6: int8+int16 concat shape=(2, 3), axis=1
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int16"),{2,3})
 local got=np.concatenate({a1,a2},1)
 check(got,"int16",{4,3},{{-2,1,3},{4,5,-1},{-2,1,3},{4,5,-1}})
 n=n+1
end
-- case 7: int8+int16 concat shape=(2, 3), axis=-1
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int16"),{2,3})
 local got=np.concatenate({a1,a2},-1)
 check(got,"int16",{2,6},{{-2,1,3,-2,1,3},{4,5,-1,4,5,-1}})
 n=n+1
end
-- case 8: int8+int16 concat shape=(2, 3), axis=False
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int16"),{2,3})
 local got=np.concatenate({a1,a2},false)
 check(got,"int16",{12},{-2,1,3,4,5,-1,-2,1,3,4,5,-1})
 n=n+1
end
-- case 9: int8+int16 stack shape=(2, 3), axis=1
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int16"),{2,3})
 local got=np.stack({a1,a2},1)
 check(got,"int16",{2,2,3},{{{-2,1,3},{4,5,-1}},{{-2,1,3},{4,5,-1}}})
 n=n+1
end
-- case 10: int8+int16 stack shape=(2, 3), axis=3
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int16"),{2,3})
 local got=np.stack({a1,a2},3)
 check(got,"int16",{2,3,2},{{{-2,-2},{1,1},{3,3}},{{4,4},{5,5},{-1,-1}}})
 n=n+1
end
-- case 11: int8+int16 stack shape=(2, 3), axis=-1
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int16"),{2,3})
 local got=np.stack({a1,a2},-1)
 check(got,"int16",{2,3,2},{{{-2,-2},{1,1},{3,3}},{{4,4},{5,5},{-1,-1}}})
 n=n+1
end
-- case 12: int8+int16 concat shape=(1, 2, 3), axis=1
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{1,2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int16"),{1,2,3})
 local got=np.concatenate({a1,a2},1)
 check(got,"int16",{2,2,3},{{{-2,1,3},{4,5,-1}},{{-2,1,3},{4,5,-1}}})
 n=n+1
end
-- case 13: int8+int16 concat shape=(1, 2, 3), axis=-1
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{1,2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int16"),{1,2,3})
 local got=np.concatenate({a1,a2},-1)
 check(got,"int16",{1,2,6},{{{-2,1,3,-2,1,3},{4,5,-1,4,5,-1}}})
 n=n+1
end
-- case 14: int8+int16 concat shape=(1, 2, 3), axis=False
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{1,2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int16"),{1,2,3})
 local got=np.concatenate({a1,a2},false)
 check(got,"int16",{12},{-2,1,3,4,5,-1,-2,1,3,4,5,-1})
 n=n+1
end
-- case 15: int8+int16 stack shape=(1, 2, 3), axis=1
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{1,2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int16"),{1,2,3})
 local got=np.stack({a1,a2},1)
 check(got,"int16",{2,1,2,3},{{{{-2,1,3},{4,5,-1}}},{{{-2,1,3},{4,5,-1}}}})
 n=n+1
end
-- case 16: int8+int16 stack shape=(1, 2, 3), axis=4
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{1,2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int16"),{1,2,3})
 local got=np.stack({a1,a2},4)
 check(got,"int16",{1,2,3,2},{{{{-2,-2},{1,1},{3,3}},{{4,4},{5,5},{-1,-1}}}})
 n=n+1
end
-- case 17: int8+int16 stack shape=(1, 2, 3), axis=-1
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{1,2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int16"),{1,2,3})
 local got=np.stack({a1,a2},-1)
 check(got,"int16",{1,2,3,2},{{{{-2,-2},{1,1},{3,3}},{{4,4},{5,5},{-1,-1}}}})
 n=n+1
end
-- case 18: int8+int16 dtype float32 casting=no
do
 local a1=np.reshape(np.array({-2,1,3},"int8"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int16"),{3})
 local ok=pcall(function()return np.concatenate({a1,a2},1,{dtype="float32",casting="no"}) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 19: int8+int16 dtype float32 casting=equiv
do
 local a1=np.reshape(np.array({-2,1,3},"int8"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int16"),{3})
 local ok=pcall(function()return np.concatenate({a1,a2},1,{dtype="float32",casting="equiv"}) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 20: int8+int16 dtype float32 casting=safe
do
 local a1=np.reshape(np.array({-2,1,3},"int8"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int16"),{3})
 local got=np.concatenate({a1,a2},1,{dtype="float32",casting="safe"})
 check(got,"float32",{6},{-2.0,1.0,3.0,-2.0,1.0,3.0})
 n=n+1
end
-- case 21: int8+int16 dtype float32 casting=same_kind
do
 local a1=np.reshape(np.array({-2,1,3},"int8"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int16"),{3})
 local got=np.concatenate({a1,a2},1,{dtype="float32",casting="same_kind"})
 check(got,"float32",{6},{-2.0,1.0,3.0,-2.0,1.0,3.0})
 n=n+1
end
-- case 22: int8+int16 dtype float32 casting=unsafe
do
 local a1=np.reshape(np.array({-2,1,3},"int8"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int16"),{3})
 local got=np.concatenate({a1,a2},1,{dtype="float32",casting="unsafe"})
 check(got,"float32",{6},{-2.0,1.0,3.0,-2.0,1.0,3.0})
 n=n+1
end
-- case 23: int8+int16 out=float64 casting=same_kind
do
 local a1=np.reshape(np.array({-2,1,3},"int8"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int16"),{3})
 local dst=np.zeros({6},"float64")
 local got=np.concatenate({a1,a2},1,{casting="same_kind",out=dst})
 assert(got==dst,"must return supplied out")
 check(got,"float64",{6},{-2.0,1.0,3.0,-2.0,1.0,3.0})
 n=n+1
end
-- case 24: int8+int16 out=float64 casting=unsafe
do
 local a1=np.reshape(np.array({-2,1,3},"int8"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int16"),{3})
 local dst=np.zeros({6},"float64")
 local got=np.concatenate({a1,a2},1,{casting="unsafe",out=dst})
 assert(got==dst,"must return supplied out")
 check(got,"float64",{6},{-2.0,1.0,3.0,-2.0,1.0,3.0})
 n=n+1
end
-- case 25: int8+int16 out=int8 casting=same_kind
do
 local a1=np.reshape(np.array({-2,1,3},"int8"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int16"),{3})
 local dst=np.zeros({6},"int8")
 local got=np.concatenate({a1,a2},1,{casting="same_kind",out=dst})
 assert(got==dst,"must return supplied out")
 check(got,"int8",{6},{-2,1,3,-2,1,3})
 n=n+1
end
-- case 26: int8+int16 out=int8 casting=unsafe
do
 local a1=np.reshape(np.array({-2,1,3},"int8"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int16"),{3})
 local dst=np.zeros({6},"int8")
 local got=np.concatenate({a1,a2},1,{casting="unsafe",out=dst})
 assert(got==dst,"must return supplied out")
 check(got,"int8",{6},{-2,1,3,-2,1,3})
 n=n+1
end
-- case 27: int32+float64 concat shape=(3,), axis=1
do
 local a1=np.reshape(np.array({-2,1,3},"int32"),{3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0},"float64"),{3})
 local got=np.concatenate({a1,a2},1)
 check(got,"float64",{6},{-2.0,1.0,3.0,-2.5,1.0,3.0})
 n=n+1
end
-- case 28: int32+float64 concat shape=(3,), axis=False
do
 local a1=np.reshape(np.array({-2,1,3},"int32"),{3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0},"float64"),{3})
 local got=np.concatenate({a1,a2},false)
 check(got,"float64",{6},{-2.0,1.0,3.0,-2.5,1.0,3.0})
 n=n+1
end
-- case 29: int32+float64 stack shape=(3,), axis=1
do
 local a1=np.reshape(np.array({-2,1,3},"int32"),{3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0},"float64"),{3})
 local got=np.stack({a1,a2},1)
 check(got,"float64",{2,3},{{-2.0,1.0,3.0},{-2.5,1.0,3.0}})
 n=n+1
end
-- case 30: int32+float64 stack shape=(3,), axis=2
do
 local a1=np.reshape(np.array({-2,1,3},"int32"),{3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0},"float64"),{3})
 local got=np.stack({a1,a2},2)
 check(got,"float64",{3,2},{{-2.0,-2.5},{1.0,1.0},{3.0,3.0}})
 n=n+1
end
-- case 31: int32+float64 stack shape=(3,), axis=-1
do
 local a1=np.reshape(np.array({-2,1,3},"int32"),{3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0},"float64"),{3})
 local got=np.stack({a1,a2},-1)
 check(got,"float64",{3,2},{{-2.0,-2.5},{1.0,1.0},{3.0,3.0}})
 n=n+1
end
-- case 32: int32+float64 concat shape=(2, 3), axis=1
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"int32"),{2,3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float64"),{2,3})
 local got=np.concatenate({a1,a2},1)
 check(got,"float64",{4,3},{{-2.0,1.0,3.0},{4.0,5.0,-1.0},{-2.5,1.0,3.0},{4.5,5.0,-1.0}})
 n=n+1
end
-- case 33: int32+float64 concat shape=(2, 3), axis=-1
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"int32"),{2,3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float64"),{2,3})
 local got=np.concatenate({a1,a2},-1)
 check(got,"float64",{2,6},{{-2.0,1.0,3.0,-2.5,1.0,3.0},{4.0,5.0,-1.0,4.5,5.0,-1.0}})
 n=n+1
end
-- case 34: int32+float64 concat shape=(2, 3), axis=False
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"int32"),{2,3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float64"),{2,3})
 local got=np.concatenate({a1,a2},false)
 check(got,"float64",{12},{-2.0,1.0,3.0,4.0,5.0,-1.0,-2.5,1.0,3.0,4.5,5.0,-1.0})
 n=n+1
end
-- case 35: int32+float64 stack shape=(2, 3), axis=1
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"int32"),{2,3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float64"),{2,3})
 local got=np.stack({a1,a2},1)
 check(got,"float64",{2,2,3},{{{-2.0,1.0,3.0},{4.0,5.0,-1.0}},{{-2.5,1.0,3.0},{4.5,5.0,-1.0}}})
 n=n+1
end
-- case 36: int32+float64 stack shape=(2, 3), axis=3
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"int32"),{2,3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float64"),{2,3})
 local got=np.stack({a1,a2},3)
 check(got,"float64",{2,3,2},{{{-2.0,-2.5},{1.0,1.0},{3.0,3.0}},{{4.0,4.5},{5.0,5.0},{-1.0,-1.0}}})
 n=n+1
end
-- case 37: int32+float64 stack shape=(2, 3), axis=-1
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"int32"),{2,3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float64"),{2,3})
 local got=np.stack({a1,a2},-1)
 check(got,"float64",{2,3,2},{{{-2.0,-2.5},{1.0,1.0},{3.0,3.0}},{{4.0,4.5},{5.0,5.0},{-1.0,-1.0}}})
 n=n+1
end
-- case 38: int32+float64 concat shape=(1, 2, 3), axis=1
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"int32"),{1,2,3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float64"),{1,2,3})
 local got=np.concatenate({a1,a2},1)
 check(got,"float64",{2,2,3},{{{-2.0,1.0,3.0},{4.0,5.0,-1.0}},{{-2.5,1.0,3.0},{4.5,5.0,-1.0}}})
 n=n+1
end
-- case 39: int32+float64 concat shape=(1, 2, 3), axis=-1
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"int32"),{1,2,3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float64"),{1,2,3})
 local got=np.concatenate({a1,a2},-1)
 check(got,"float64",{1,2,6},{{{-2.0,1.0,3.0,-2.5,1.0,3.0},{4.0,5.0,-1.0,4.5,5.0,-1.0}}})
 n=n+1
end
-- case 40: int32+float64 concat shape=(1, 2, 3), axis=False
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"int32"),{1,2,3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float64"),{1,2,3})
 local got=np.concatenate({a1,a2},false)
 check(got,"float64",{12},{-2.0,1.0,3.0,4.0,5.0,-1.0,-2.5,1.0,3.0,4.5,5.0,-1.0})
 n=n+1
end
-- case 41: int32+float64 stack shape=(1, 2, 3), axis=1
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"int32"),{1,2,3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float64"),{1,2,3})
 local got=np.stack({a1,a2},1)
 check(got,"float64",{2,1,2,3},{{{{-2.0,1.0,3.0},{4.0,5.0,-1.0}}},{{{-2.5,1.0,3.0},{4.5,5.0,-1.0}}}})
 n=n+1
end
-- case 42: int32+float64 stack shape=(1, 2, 3), axis=4
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"int32"),{1,2,3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float64"),{1,2,3})
 local got=np.stack({a1,a2},4)
 check(got,"float64",{1,2,3,2},{{{{-2.0,-2.5},{1.0,1.0},{3.0,3.0}},{{4.0,4.5},{5.0,5.0},{-1.0,-1.0}}}})
 n=n+1
end
-- case 43: int32+float64 stack shape=(1, 2, 3), axis=-1
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"int32"),{1,2,3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float64"),{1,2,3})
 local got=np.stack({a1,a2},-1)
 check(got,"float64",{1,2,3,2},{{{{-2.0,-2.5},{1.0,1.0},{3.0,3.0}},{{4.0,4.5},{5.0,5.0},{-1.0,-1.0}}}})
 n=n+1
end
-- case 44: int32+float64 dtype float32 casting=no
do
 local a1=np.reshape(np.array({-2,1,3},"int32"),{3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0},"float64"),{3})
 local ok=pcall(function()return np.concatenate({a1,a2},1,{dtype="float32",casting="no"}) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 45: int32+float64 dtype float32 casting=equiv
do
 local a1=np.reshape(np.array({-2,1,3},"int32"),{3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0},"float64"),{3})
 local ok=pcall(function()return np.concatenate({a1,a2},1,{dtype="float32",casting="equiv"}) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 46: int32+float64 dtype float32 casting=safe
do
 local a1=np.reshape(np.array({-2,1,3},"int32"),{3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0},"float64"),{3})
 local ok=pcall(function()return np.concatenate({a1,a2},1,{dtype="float32",casting="safe"}) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 47: int32+float64 dtype float32 casting=same_kind
do
 local a1=np.reshape(np.array({-2,1,3},"int32"),{3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0},"float64"),{3})
 local got=np.concatenate({a1,a2},1,{dtype="float32",casting="same_kind"})
 check(got,"float32",{6},{-2.0,1.0,3.0,-2.5,1.0,3.0})
 n=n+1
end
-- case 48: int32+float64 dtype float32 casting=unsafe
do
 local a1=np.reshape(np.array({-2,1,3},"int32"),{3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0},"float64"),{3})
 local got=np.concatenate({a1,a2},1,{dtype="float32",casting="unsafe"})
 check(got,"float32",{6},{-2.0,1.0,3.0,-2.5,1.0,3.0})
 n=n+1
end
-- case 49: int32+float64 out=float64 casting=same_kind
do
 local a1=np.reshape(np.array({-2,1,3},"int32"),{3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0},"float64"),{3})
 local dst=np.zeros({6},"float64")
 local got=np.concatenate({a1,a2},1,{casting="same_kind",out=dst})
 assert(got==dst,"must return supplied out")
 check(got,"float64",{6},{-2.0,1.0,3.0,-2.5,1.0,3.0})
 n=n+1
end
-- case 50: int32+float64 out=float64 casting=unsafe
do
 local a1=np.reshape(np.array({-2,1,3},"int32"),{3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0},"float64"),{3})
 local dst=np.zeros({6},"float64")
 local got=np.concatenate({a1,a2},1,{casting="unsafe",out=dst})
 assert(got==dst,"must return supplied out")
 check(got,"float64",{6},{-2.0,1.0,3.0,-2.5,1.0,3.0})
 n=n+1
end
-- case 51: int32+float64 out=int8 casting=same_kind
do
 local a1=np.reshape(np.array({-2,1,3},"int32"),{3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0},"float64"),{3})
 local dst=np.zeros({6},"int8")
 local ok=pcall(function()return np.concatenate({a1,a2},1,{casting="same_kind",out=dst}) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 52: int32+float64 out=int8 casting=unsafe
do
 local a1=np.reshape(np.array({-2,1,3},"int32"),{3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0},"float64"),{3})
 local dst=np.zeros({6},"int8")
 local got=np.concatenate({a1,a2},1,{casting="unsafe",out=dst})
 assert(got==dst,"must return supplied out")
 check(got,"int8",{6},{-2,1,3,-2,1,3})
 n=n+1
end
-- case 53: float16+float32 concat shape=(3,), axis=1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float16"),{3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0},"float32"),{3})
 local got=np.concatenate({a1,a2},1)
 check(got,"float32",{6},{-2.5,1.0,3.0,-2.5,1.0,3.0})
 n=n+1
end
-- case 54: float16+float32 concat shape=(3,), axis=False
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float16"),{3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0},"float32"),{3})
 local got=np.concatenate({a1,a2},false)
 check(got,"float32",{6},{-2.5,1.0,3.0,-2.5,1.0,3.0})
 n=n+1
end
-- case 55: float16+float32 stack shape=(3,), axis=1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float16"),{3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0},"float32"),{3})
 local got=np.stack({a1,a2},1)
 check(got,"float32",{2,3},{{-2.5,1.0,3.0},{-2.5,1.0,3.0}})
 n=n+1
end
-- case 56: float16+float32 stack shape=(3,), axis=2
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float16"),{3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0},"float32"),{3})
 local got=np.stack({a1,a2},2)
 check(got,"float32",{3,2},{{-2.5,-2.5},{1.0,1.0},{3.0,3.0}})
 n=n+1
end
-- case 57: float16+float32 stack shape=(3,), axis=-1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float16"),{3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0},"float32"),{3})
 local got=np.stack({a1,a2},-1)
 check(got,"float32",{3,2},{{-2.5,-2.5},{1.0,1.0},{3.0,3.0}})
 n=n+1
end
-- case 58: float16+float32 concat shape=(2, 3), axis=1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float16"),{2,3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float32"),{2,3})
 local got=np.concatenate({a1,a2},1)
 check(got,"float32",{4,3},{{-2.5,1.0,3.0},{4.5,5.0,-1.0},{-2.5,1.0,3.0},{4.5,5.0,-1.0}})
 n=n+1
end
-- case 59: float16+float32 concat shape=(2, 3), axis=-1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float16"),{2,3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float32"),{2,3})
 local got=np.concatenate({a1,a2},-1)
 check(got,"float32",{2,6},{{-2.5,1.0,3.0,-2.5,1.0,3.0},{4.5,5.0,-1.0,4.5,5.0,-1.0}})
 n=n+1
end
-- case 60: float16+float32 concat shape=(2, 3), axis=False
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float16"),{2,3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float32"),{2,3})
 local got=np.concatenate({a1,a2},false)
 check(got,"float32",{12},{-2.5,1.0,3.0,4.5,5.0,-1.0,-2.5,1.0,3.0,4.5,5.0,-1.0})
 n=n+1
end
-- case 61: float16+float32 stack shape=(2, 3), axis=1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float16"),{2,3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float32"),{2,3})
 local got=np.stack({a1,a2},1)
 check(got,"float32",{2,2,3},{{{-2.5,1.0,3.0},{4.5,5.0,-1.0}},{{-2.5,1.0,3.0},{4.5,5.0,-1.0}}})
 n=n+1
end
-- case 62: float16+float32 stack shape=(2, 3), axis=3
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float16"),{2,3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float32"),{2,3})
 local got=np.stack({a1,a2},3)
 check(got,"float32",{2,3,2},{{{-2.5,-2.5},{1.0,1.0},{3.0,3.0}},{{4.5,4.5},{5.0,5.0},{-1.0,-1.0}}})
 n=n+1
end
-- case 63: float16+float32 stack shape=(2, 3), axis=-1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float16"),{2,3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float32"),{2,3})
 local got=np.stack({a1,a2},-1)
 check(got,"float32",{2,3,2},{{{-2.5,-2.5},{1.0,1.0},{3.0,3.0}},{{4.5,4.5},{5.0,5.0},{-1.0,-1.0}}})
 n=n+1
end
-- case 64: float16+float32 concat shape=(1, 2, 3), axis=1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float16"),{1,2,3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float32"),{1,2,3})
 local got=np.concatenate({a1,a2},1)
 check(got,"float32",{2,2,3},{{{-2.5,1.0,3.0},{4.5,5.0,-1.0}},{{-2.5,1.0,3.0},{4.5,5.0,-1.0}}})
 n=n+1
end
-- case 65: float16+float32 concat shape=(1, 2, 3), axis=-1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float16"),{1,2,3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float32"),{1,2,3})
 local got=np.concatenate({a1,a2},-1)
 check(got,"float32",{1,2,6},{{{-2.5,1.0,3.0,-2.5,1.0,3.0},{4.5,5.0,-1.0,4.5,5.0,-1.0}}})
 n=n+1
end
-- case 66: float16+float32 concat shape=(1, 2, 3), axis=False
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float16"),{1,2,3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float32"),{1,2,3})
 local got=np.concatenate({a1,a2},false)
 check(got,"float32",{12},{-2.5,1.0,3.0,4.5,5.0,-1.0,-2.5,1.0,3.0,4.5,5.0,-1.0})
 n=n+1
end
-- case 67: float16+float32 stack shape=(1, 2, 3), axis=1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float16"),{1,2,3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float32"),{1,2,3})
 local got=np.stack({a1,a2},1)
 check(got,"float32",{2,1,2,3},{{{{-2.5,1.0,3.0},{4.5,5.0,-1.0}}},{{{-2.5,1.0,3.0},{4.5,5.0,-1.0}}}})
 n=n+1
end
-- case 68: float16+float32 stack shape=(1, 2, 3), axis=4
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float16"),{1,2,3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float32"),{1,2,3})
 local got=np.stack({a1,a2},4)
 check(got,"float32",{1,2,3,2},{{{{-2.5,-2.5},{1.0,1.0},{3.0,3.0}},{{4.5,4.5},{5.0,5.0},{-1.0,-1.0}}}})
 n=n+1
end
-- case 69: float16+float32 stack shape=(1, 2, 3), axis=-1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float16"),{1,2,3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float32"),{1,2,3})
 local got=np.stack({a1,a2},-1)
 check(got,"float32",{1,2,3,2},{{{{-2.5,-2.5},{1.0,1.0},{3.0,3.0}},{{4.5,4.5},{5.0,5.0},{-1.0,-1.0}}}})
 n=n+1
end
-- case 70: float16+float32 dtype float32 casting=no
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float16"),{3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0},"float32"),{3})
 local ok=pcall(function()return np.concatenate({a1,a2},1,{dtype="float32",casting="no"}) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 71: float16+float32 dtype float32 casting=equiv
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float16"),{3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0},"float32"),{3})
 local ok=pcall(function()return np.concatenate({a1,a2},1,{dtype="float32",casting="equiv"}) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 72: float16+float32 dtype float32 casting=safe
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float16"),{3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0},"float32"),{3})
 local got=np.concatenate({a1,a2},1,{dtype="float32",casting="safe"})
 check(got,"float32",{6},{-2.5,1.0,3.0,-2.5,1.0,3.0})
 n=n+1
end
-- case 73: float16+float32 dtype float32 casting=same_kind
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float16"),{3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0},"float32"),{3})
 local got=np.concatenate({a1,a2},1,{dtype="float32",casting="same_kind"})
 check(got,"float32",{6},{-2.5,1.0,3.0,-2.5,1.0,3.0})
 n=n+1
end
-- case 74: float16+float32 dtype float32 casting=unsafe
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float16"),{3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0},"float32"),{3})
 local got=np.concatenate({a1,a2},1,{dtype="float32",casting="unsafe"})
 check(got,"float32",{6},{-2.5,1.0,3.0,-2.5,1.0,3.0})
 n=n+1
end
-- case 75: float16+float32 out=float64 casting=same_kind
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float16"),{3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0},"float32"),{3})
 local dst=np.zeros({6},"float64")
 local got=np.concatenate({a1,a2},1,{casting="same_kind",out=dst})
 assert(got==dst,"must return supplied out")
 check(got,"float64",{6},{-2.5,1.0,3.0,-2.5,1.0,3.0})
 n=n+1
end
-- case 76: float16+float32 out=float64 casting=unsafe
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float16"),{3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0},"float32"),{3})
 local dst=np.zeros({6},"float64")
 local got=np.concatenate({a1,a2},1,{casting="unsafe",out=dst})
 assert(got==dst,"must return supplied out")
 check(got,"float64",{6},{-2.5,1.0,3.0,-2.5,1.0,3.0})
 n=n+1
end
-- case 77: float16+float32 out=int8 casting=same_kind
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float16"),{3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0},"float32"),{3})
 local dst=np.zeros({6},"int8")
 local ok=pcall(function()return np.concatenate({a1,a2},1,{casting="same_kind",out=dst}) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 78: float16+float32 out=int8 casting=unsafe
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float16"),{3})
 local a2=np.reshape(np.array({-2.5,1.0,3.0},"float32"),{3})
 local dst=np.zeros({6},"int8")
 local got=np.concatenate({a1,a2},1,{casting="unsafe",out=dst})
 assert(got==dst,"must return supplied out")
 check(got,"int8",{6},{-2,1,3,-2,1,3})
 n=n+1
end
-- case 79: bool+int8 concat shape=(3,), axis=1
do
 local a1=np.reshape(np.array({false,true,true},"bool"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int8"),{3})
 local got=np.concatenate({a1,a2},1)
 check(got,"int8",{6},{0,1,1,-2,1,3})
 n=n+1
end
-- case 80: bool+int8 concat shape=(3,), axis=False
do
 local a1=np.reshape(np.array({false,true,true},"bool"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int8"),{3})
 local got=np.concatenate({a1,a2},false)
 check(got,"int8",{6},{0,1,1,-2,1,3})
 n=n+1
end
-- case 81: bool+int8 stack shape=(3,), axis=1
do
 local a1=np.reshape(np.array({false,true,true},"bool"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int8"),{3})
 local got=np.stack({a1,a2},1)
 check(got,"int8",{2,3},{{0,1,1},{-2,1,3}})
 n=n+1
end
-- case 82: bool+int8 stack shape=(3,), axis=2
do
 local a1=np.reshape(np.array({false,true,true},"bool"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int8"),{3})
 local got=np.stack({a1,a2},2)
 check(got,"int8",{3,2},{{0,-2},{1,1},{1,3}})
 n=n+1
end
-- case 83: bool+int8 stack shape=(3,), axis=-1
do
 local a1=np.reshape(np.array({false,true,true},"bool"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int8"),{3})
 local got=np.stack({a1,a2},-1)
 check(got,"int8",{3,2},{{0,-2},{1,1},{1,3}})
 n=n+1
end
-- case 84: bool+int8 concat shape=(2, 3), axis=1
do
 local a1=np.reshape(np.array({false,true,true,false,true,false},"bool"),{2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{2,3})
 local got=np.concatenate({a1,a2},1)
 check(got,"int8",{4,3},{{0,1,1},{0,1,0},{-2,1,3},{4,5,-1}})
 n=n+1
end
-- case 85: bool+int8 concat shape=(2, 3), axis=-1
do
 local a1=np.reshape(np.array({false,true,true,false,true,false},"bool"),{2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{2,3})
 local got=np.concatenate({a1,a2},-1)
 check(got,"int8",{2,6},{{0,1,1,-2,1,3},{0,1,0,4,5,-1}})
 n=n+1
end
-- case 86: bool+int8 concat shape=(2, 3), axis=False
do
 local a1=np.reshape(np.array({false,true,true,false,true,false},"bool"),{2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{2,3})
 local got=np.concatenate({a1,a2},false)
 check(got,"int8",{12},{0,1,1,0,1,0,-2,1,3,4,5,-1})
 n=n+1
end
-- case 87: bool+int8 stack shape=(2, 3), axis=1
do
 local a1=np.reshape(np.array({false,true,true,false,true,false},"bool"),{2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{2,3})
 local got=np.stack({a1,a2},1)
 check(got,"int8",{2,2,3},{{{0,1,1},{0,1,0}},{{-2,1,3},{4,5,-1}}})
 n=n+1
end
-- case 88: bool+int8 stack shape=(2, 3), axis=3
do
 local a1=np.reshape(np.array({false,true,true,false,true,false},"bool"),{2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{2,3})
 local got=np.stack({a1,a2},3)
 check(got,"int8",{2,3,2},{{{0,-2},{1,1},{1,3}},{{0,4},{1,5},{0,-1}}})
 n=n+1
end
-- case 89: bool+int8 stack shape=(2, 3), axis=-1
do
 local a1=np.reshape(np.array({false,true,true,false,true,false},"bool"),{2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{2,3})
 local got=np.stack({a1,a2},-1)
 check(got,"int8",{2,3,2},{{{0,-2},{1,1},{1,3}},{{0,4},{1,5},{0,-1}}})
 n=n+1
end
-- case 90: bool+int8 concat shape=(1, 2, 3), axis=1
do
 local a1=np.reshape(np.array({false,true,true,false,true,false},"bool"),{1,2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{1,2,3})
 local got=np.concatenate({a1,a2},1)
 check(got,"int8",{2,2,3},{{{0,1,1},{0,1,0}},{{-2,1,3},{4,5,-1}}})
 n=n+1
end
-- case 91: bool+int8 concat shape=(1, 2, 3), axis=-1
do
 local a1=np.reshape(np.array({false,true,true,false,true,false},"bool"),{1,2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{1,2,3})
 local got=np.concatenate({a1,a2},-1)
 check(got,"int8",{1,2,6},{{{0,1,1,-2,1,3},{0,1,0,4,5,-1}}})
 n=n+1
end
-- case 92: bool+int8 concat shape=(1, 2, 3), axis=False
do
 local a1=np.reshape(np.array({false,true,true,false,true,false},"bool"),{1,2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{1,2,3})
 local got=np.concatenate({a1,a2},false)
 check(got,"int8",{12},{0,1,1,0,1,0,-2,1,3,4,5,-1})
 n=n+1
end
-- case 93: bool+int8 stack shape=(1, 2, 3), axis=1
do
 local a1=np.reshape(np.array({false,true,true,false,true,false},"bool"),{1,2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{1,2,3})
 local got=np.stack({a1,a2},1)
 check(got,"int8",{2,1,2,3},{{{{0,1,1},{0,1,0}}},{{{-2,1,3},{4,5,-1}}}})
 n=n+1
end
-- case 94: bool+int8 stack shape=(1, 2, 3), axis=4
do
 local a1=np.reshape(np.array({false,true,true,false,true,false},"bool"),{1,2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{1,2,3})
 local got=np.stack({a1,a2},4)
 check(got,"int8",{1,2,3,2},{{{{0,-2},{1,1},{1,3}},{{0,4},{1,5},{0,-1}}}})
 n=n+1
end
-- case 95: bool+int8 stack shape=(1, 2, 3), axis=-1
do
 local a1=np.reshape(np.array({false,true,true,false,true,false},"bool"),{1,2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{1,2,3})
 local got=np.stack({a1,a2},-1)
 check(got,"int8",{1,2,3,2},{{{{0,-2},{1,1},{1,3}},{{0,4},{1,5},{0,-1}}}})
 n=n+1
end
-- case 96: bool+int8 dtype float32 casting=no
do
 local a1=np.reshape(np.array({false,true,true},"bool"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int8"),{3})
 local ok=pcall(function()return np.concatenate({a1,a2},1,{dtype="float32",casting="no"}) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 97: bool+int8 dtype float32 casting=equiv
do
 local a1=np.reshape(np.array({false,true,true},"bool"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int8"),{3})
 local ok=pcall(function()return np.concatenate({a1,a2},1,{dtype="float32",casting="equiv"}) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 98: bool+int8 dtype float32 casting=safe
do
 local a1=np.reshape(np.array({false,true,true},"bool"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int8"),{3})
 local got=np.concatenate({a1,a2},1,{dtype="float32",casting="safe"})
 check(got,"float32",{6},{0.0,1.0,1.0,-2.0,1.0,3.0})
 n=n+1
end
-- case 99: bool+int8 dtype float32 casting=same_kind
do
 local a1=np.reshape(np.array({false,true,true},"bool"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int8"),{3})
 local got=np.concatenate({a1,a2},1,{dtype="float32",casting="same_kind"})
 check(got,"float32",{6},{0.0,1.0,1.0,-2.0,1.0,3.0})
 n=n+1
end
-- case 100: bool+int8 dtype float32 casting=unsafe
do
 local a1=np.reshape(np.array({false,true,true},"bool"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int8"),{3})
 local got=np.concatenate({a1,a2},1,{dtype="float32",casting="unsafe"})
 check(got,"float32",{6},{0.0,1.0,1.0,-2.0,1.0,3.0})
 n=n+1
end
-- case 101: bool+int8 out=float64 casting=same_kind
do
 local a1=np.reshape(np.array({false,true,true},"bool"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int8"),{3})
 local dst=np.zeros({6},"float64")
 local got=np.concatenate({a1,a2},1,{casting="same_kind",out=dst})
 assert(got==dst,"must return supplied out")
 check(got,"float64",{6},{0.0,1.0,1.0,-2.0,1.0,3.0})
 n=n+1
end
-- case 102: bool+int8 out=float64 casting=unsafe
do
 local a1=np.reshape(np.array({false,true,true},"bool"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int8"),{3})
 local dst=np.zeros({6},"float64")
 local got=np.concatenate({a1,a2},1,{casting="unsafe",out=dst})
 assert(got==dst,"must return supplied out")
 check(got,"float64",{6},{0.0,1.0,1.0,-2.0,1.0,3.0})
 n=n+1
end
-- case 103: bool+int8 out=int8 casting=same_kind
do
 local a1=np.reshape(np.array({false,true,true},"bool"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int8"),{3})
 local dst=np.zeros({6},"int8")
 local got=np.concatenate({a1,a2},1,{casting="same_kind",out=dst})
 assert(got==dst,"must return supplied out")
 check(got,"int8",{6},{0,1,1,-2,1,3})
 n=n+1
end
-- case 104: bool+int8 out=int8 casting=unsafe
do
 local a1=np.reshape(np.array({false,true,true},"bool"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int8"),{3})
 local dst=np.zeros({6},"int8")
 local got=np.concatenate({a1,a2},1,{casting="unsafe",out=dst})
 assert(got==dst,"must return supplied out")
 check(got,"int8",{6},{0,1,1,-2,1,3})
 n=n+1
end
-- case 105: uint8+int8 concat shape=(3,), axis=1
do
 local a1=np.reshape(np.array({0,1,3},"uint8"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int8"),{3})
 local got=np.concatenate({a1,a2},1)
 check(got,"int16",{6},{0,1,3,-2,1,3})
 n=n+1
end
-- case 106: uint8+int8 concat shape=(3,), axis=False
do
 local a1=np.reshape(np.array({0,1,3},"uint8"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int8"),{3})
 local got=np.concatenate({a1,a2},false)
 check(got,"int16",{6},{0,1,3,-2,1,3})
 n=n+1
end
-- case 107: uint8+int8 stack shape=(3,), axis=1
do
 local a1=np.reshape(np.array({0,1,3},"uint8"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int8"),{3})
 local got=np.stack({a1,a2},1)
 check(got,"int16",{2,3},{{0,1,3},{-2,1,3}})
 n=n+1
end
-- case 108: uint8+int8 stack shape=(3,), axis=2
do
 local a1=np.reshape(np.array({0,1,3},"uint8"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int8"),{3})
 local got=np.stack({a1,a2},2)
 check(got,"int16",{3,2},{{0,-2},{1,1},{3,3}})
 n=n+1
end
-- case 109: uint8+int8 stack shape=(3,), axis=-1
do
 local a1=np.reshape(np.array({0,1,3},"uint8"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int8"),{3})
 local got=np.stack({a1,a2},-1)
 check(got,"int16",{3,2},{{0,-2},{1,1},{3,3}})
 n=n+1
end
-- case 110: uint8+int8 concat shape=(2, 3), axis=1
do
 local a1=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{2,3})
 local got=np.concatenate({a1,a2},1)
 check(got,"int16",{4,3},{{0,1,3},{4,5,6},{-2,1,3},{4,5,-1}})
 n=n+1
end
-- case 111: uint8+int8 concat shape=(2, 3), axis=-1
do
 local a1=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{2,3})
 local got=np.concatenate({a1,a2},-1)
 check(got,"int16",{2,6},{{0,1,3,-2,1,3},{4,5,6,4,5,-1}})
 n=n+1
end
-- case 112: uint8+int8 concat shape=(2, 3), axis=False
do
 local a1=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{2,3})
 local got=np.concatenate({a1,a2},false)
 check(got,"int16",{12},{0,1,3,4,5,6,-2,1,3,4,5,-1})
 n=n+1
end
-- case 113: uint8+int8 stack shape=(2, 3), axis=1
do
 local a1=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{2,3})
 local got=np.stack({a1,a2},1)
 check(got,"int16",{2,2,3},{{{0,1,3},{4,5,6}},{{-2,1,3},{4,5,-1}}})
 n=n+1
end
-- case 114: uint8+int8 stack shape=(2, 3), axis=3
do
 local a1=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{2,3})
 local got=np.stack({a1,a2},3)
 check(got,"int16",{2,3,2},{{{0,-2},{1,1},{3,3}},{{4,4},{5,5},{6,-1}}})
 n=n+1
end
-- case 115: uint8+int8 stack shape=(2, 3), axis=-1
do
 local a1=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{2,3})
 local got=np.stack({a1,a2},-1)
 check(got,"int16",{2,3,2},{{{0,-2},{1,1},{3,3}},{{4,4},{5,5},{6,-1}}})
 n=n+1
end
-- case 116: uint8+int8 concat shape=(1, 2, 3), axis=1
do
 local a1=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{1,2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{1,2,3})
 local got=np.concatenate({a1,a2},1)
 check(got,"int16",{2,2,3},{{{0,1,3},{4,5,6}},{{-2,1,3},{4,5,-1}}})
 n=n+1
end
-- case 117: uint8+int8 concat shape=(1, 2, 3), axis=-1
do
 local a1=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{1,2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{1,2,3})
 local got=np.concatenate({a1,a2},-1)
 check(got,"int16",{1,2,6},{{{0,1,3,-2,1,3},{4,5,6,4,5,-1}}})
 n=n+1
end
-- case 118: uint8+int8 concat shape=(1, 2, 3), axis=False
do
 local a1=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{1,2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{1,2,3})
 local got=np.concatenate({a1,a2},false)
 check(got,"int16",{12},{0,1,3,4,5,6,-2,1,3,4,5,-1})
 n=n+1
end
-- case 119: uint8+int8 stack shape=(1, 2, 3), axis=1
do
 local a1=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{1,2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{1,2,3})
 local got=np.stack({a1,a2},1)
 check(got,"int16",{2,1,2,3},{{{{0,1,3},{4,5,6}}},{{{-2,1,3},{4,5,-1}}}})
 n=n+1
end
-- case 120: uint8+int8 stack shape=(1, 2, 3), axis=4
do
 local a1=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{1,2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{1,2,3})
 local got=np.stack({a1,a2},4)
 check(got,"int16",{1,2,3,2},{{{{0,-2},{1,1},{3,3}},{{4,4},{5,5},{6,-1}}}})
 n=n+1
end
-- case 121: uint8+int8 stack shape=(1, 2, 3), axis=-1
do
 local a1=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{1,2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{1,2,3})
 local got=np.stack({a1,a2},-1)
 check(got,"int16",{1,2,3,2},{{{{0,-2},{1,1},{3,3}},{{4,4},{5,5},{6,-1}}}})
 n=n+1
end
-- case 122: uint8+int8 dtype float32 casting=no
do
 local a1=np.reshape(np.array({0,1,3},"uint8"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int8"),{3})
 local ok=pcall(function()return np.concatenate({a1,a2},1,{dtype="float32",casting="no"}) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 123: uint8+int8 dtype float32 casting=equiv
do
 local a1=np.reshape(np.array({0,1,3},"uint8"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int8"),{3})
 local ok=pcall(function()return np.concatenate({a1,a2},1,{dtype="float32",casting="equiv"}) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 124: uint8+int8 dtype float32 casting=safe
do
 local a1=np.reshape(np.array({0,1,3},"uint8"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int8"),{3})
 local got=np.concatenate({a1,a2},1,{dtype="float32",casting="safe"})
 check(got,"float32",{6},{0.0,1.0,3.0,-2.0,1.0,3.0})
 n=n+1
end
-- case 125: uint8+int8 dtype float32 casting=same_kind
do
 local a1=np.reshape(np.array({0,1,3},"uint8"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int8"),{3})
 local got=np.concatenate({a1,a2},1,{dtype="float32",casting="same_kind"})
 check(got,"float32",{6},{0.0,1.0,3.0,-2.0,1.0,3.0})
 n=n+1
end
-- case 126: uint8+int8 dtype float32 casting=unsafe
do
 local a1=np.reshape(np.array({0,1,3},"uint8"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int8"),{3})
 local got=np.concatenate({a1,a2},1,{dtype="float32",casting="unsafe"})
 check(got,"float32",{6},{0.0,1.0,3.0,-2.0,1.0,3.0})
 n=n+1
end
-- case 127: uint8+int8 out=float64 casting=same_kind
do
 local a1=np.reshape(np.array({0,1,3},"uint8"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int8"),{3})
 local dst=np.zeros({6},"float64")
 local got=np.concatenate({a1,a2},1,{casting="same_kind",out=dst})
 assert(got==dst,"must return supplied out")
 check(got,"float64",{6},{0.0,1.0,3.0,-2.0,1.0,3.0})
 n=n+1
end
-- case 128: uint8+int8 out=float64 casting=unsafe
do
 local a1=np.reshape(np.array({0,1,3},"uint8"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int8"),{3})
 local dst=np.zeros({6},"float64")
 local got=np.concatenate({a1,a2},1,{casting="unsafe",out=dst})
 assert(got==dst,"must return supplied out")
 check(got,"float64",{6},{0.0,1.0,3.0,-2.0,1.0,3.0})
 n=n+1
end
-- case 129: uint8+int8 out=int8 casting=same_kind
do
 local a1=np.reshape(np.array({0,1,3},"uint8"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int8"),{3})
 local dst=np.zeros({6},"int8")
 local got=np.concatenate({a1,a2},1,{casting="same_kind",out=dst})
 assert(got==dst,"must return supplied out")
 check(got,"int8",{6},{0,1,3,-2,1,3})
 n=n+1
end
-- case 130: uint8+int8 out=int8 casting=unsafe
do
 local a1=np.reshape(np.array({0,1,3},"uint8"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int8"),{3})
 local dst=np.zeros({6},"int8")
 local got=np.concatenate({a1,a2},1,{casting="unsafe",out=dst})
 assert(got==dst,"must return supplied out")
 check(got,"int8",{6},{0,1,3,-2,1,3})
 n=n+1
end
-- case 131: float64+complex64 concat shape=(3,), axis=1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float64"),{3})
 local a2=np.reshape(np.array({-2,1,3},"complex64"),{3})
 local got=np.concatenate({a1,a2},1)
 check(got,"complex128",{6},{np.complex(-2.5,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0),np.complex(-2.0,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0)})
 n=n+1
end
-- case 132: float64+complex64 concat shape=(3,), axis=False
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float64"),{3})
 local a2=np.reshape(np.array({-2,1,3},"complex64"),{3})
 local got=np.concatenate({a1,a2},false)
 check(got,"complex128",{6},{np.complex(-2.5,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0),np.complex(-2.0,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0)})
 n=n+1
end
-- case 133: float64+complex64 stack shape=(3,), axis=1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float64"),{3})
 local a2=np.reshape(np.array({-2,1,3},"complex64"),{3})
 local got=np.stack({a1,a2},1)
 check(got,"complex128",{2,3},{{np.complex(-2.5,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0)},{np.complex(-2.0,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0)}})
 n=n+1
end
-- case 134: float64+complex64 stack shape=(3,), axis=2
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float64"),{3})
 local a2=np.reshape(np.array({-2,1,3},"complex64"),{3})
 local got=np.stack({a1,a2},2)
 check(got,"complex128",{3,2},{{np.complex(-2.5,0.0),np.complex(-2.0,0.0)},{np.complex(1.0,0.0),np.complex(1.0,0.0)},{np.complex(3.0,0.0),np.complex(3.0,0.0)}})
 n=n+1
end
-- case 135: float64+complex64 stack shape=(3,), axis=-1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float64"),{3})
 local a2=np.reshape(np.array({-2,1,3},"complex64"),{3})
 local got=np.stack({a1,a2},-1)
 check(got,"complex128",{3,2},{{np.complex(-2.5,0.0),np.complex(-2.0,0.0)},{np.complex(1.0,0.0),np.complex(1.0,0.0)},{np.complex(3.0,0.0),np.complex(3.0,0.0)}})
 n=n+1
end
-- case 136: float64+complex64 concat shape=(2, 3), axis=1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float64"),{2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"complex64"),{2,3})
 local got=np.concatenate({a1,a2},1)
 check(got,"complex128",{4,3},{{np.complex(-2.5,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0)},{np.complex(4.5,0.0),np.complex(5.0,0.0),np.complex(-1.0,0.0)},{np.complex(-2.0,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(-1.0,0.0)}})
 n=n+1
end
-- case 137: float64+complex64 concat shape=(2, 3), axis=-1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float64"),{2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"complex64"),{2,3})
 local got=np.concatenate({a1,a2},-1)
 check(got,"complex128",{2,6},{{np.complex(-2.5,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0),np.complex(-2.0,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0)},{np.complex(4.5,0.0),np.complex(5.0,0.0),np.complex(-1.0,0.0),np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(-1.0,0.0)}})
 n=n+1
end
-- case 138: float64+complex64 concat shape=(2, 3), axis=False
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float64"),{2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"complex64"),{2,3})
 local got=np.concatenate({a1,a2},false)
 check(got,"complex128",{12},{np.complex(-2.5,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0),np.complex(4.5,0.0),np.complex(5.0,0.0),np.complex(-1.0,0.0),np.complex(-2.0,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0),np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(-1.0,0.0)})
 n=n+1
end
-- case 139: float64+complex64 stack shape=(2, 3), axis=1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float64"),{2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"complex64"),{2,3})
 local got=np.stack({a1,a2},1)
 check(got,"complex128",{2,2,3},{{{np.complex(-2.5,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0)},{np.complex(4.5,0.0),np.complex(5.0,0.0),np.complex(-1.0,0.0)}},{{np.complex(-2.0,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(-1.0,0.0)}}})
 n=n+1
end
-- case 140: float64+complex64 stack shape=(2, 3), axis=3
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float64"),{2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"complex64"),{2,3})
 local got=np.stack({a1,a2},3)
 check(got,"complex128",{2,3,2},{{{np.complex(-2.5,0.0),np.complex(-2.0,0.0)},{np.complex(1.0,0.0),np.complex(1.0,0.0)},{np.complex(3.0,0.0),np.complex(3.0,0.0)}},{{np.complex(4.5,0.0),np.complex(4.0,0.0)},{np.complex(5.0,0.0),np.complex(5.0,0.0)},{np.complex(-1.0,0.0),np.complex(-1.0,0.0)}}})
 n=n+1
end
-- case 141: float64+complex64 stack shape=(2, 3), axis=-1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float64"),{2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"complex64"),{2,3})
 local got=np.stack({a1,a2},-1)
 check(got,"complex128",{2,3,2},{{{np.complex(-2.5,0.0),np.complex(-2.0,0.0)},{np.complex(1.0,0.0),np.complex(1.0,0.0)},{np.complex(3.0,0.0),np.complex(3.0,0.0)}},{{np.complex(4.5,0.0),np.complex(4.0,0.0)},{np.complex(5.0,0.0),np.complex(5.0,0.0)},{np.complex(-1.0,0.0),np.complex(-1.0,0.0)}}})
 n=n+1
end
-- case 142: float64+complex64 concat shape=(1, 2, 3), axis=1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float64"),{1,2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"complex64"),{1,2,3})
 local got=np.concatenate({a1,a2},1)
 check(got,"complex128",{2,2,3},{{{np.complex(-2.5,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0)},{np.complex(4.5,0.0),np.complex(5.0,0.0),np.complex(-1.0,0.0)}},{{np.complex(-2.0,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(-1.0,0.0)}}})
 n=n+1
end
-- case 143: float64+complex64 concat shape=(1, 2, 3), axis=-1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float64"),{1,2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"complex64"),{1,2,3})
 local got=np.concatenate({a1,a2},-1)
 check(got,"complex128",{1,2,6},{{{np.complex(-2.5,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0),np.complex(-2.0,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0)},{np.complex(4.5,0.0),np.complex(5.0,0.0),np.complex(-1.0,0.0),np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(-1.0,0.0)}}})
 n=n+1
end
-- case 144: float64+complex64 concat shape=(1, 2, 3), axis=False
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float64"),{1,2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"complex64"),{1,2,3})
 local got=np.concatenate({a1,a2},false)
 check(got,"complex128",{12},{np.complex(-2.5,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0),np.complex(4.5,0.0),np.complex(5.0,0.0),np.complex(-1.0,0.0),np.complex(-2.0,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0),np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(-1.0,0.0)})
 n=n+1
end
-- case 145: float64+complex64 stack shape=(1, 2, 3), axis=1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float64"),{1,2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"complex64"),{1,2,3})
 local got=np.stack({a1,a2},1)
 check(got,"complex128",{2,1,2,3},{{{{np.complex(-2.5,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0)},{np.complex(4.5,0.0),np.complex(5.0,0.0),np.complex(-1.0,0.0)}}},{{{np.complex(-2.0,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(-1.0,0.0)}}}})
 n=n+1
end
-- case 146: float64+complex64 stack shape=(1, 2, 3), axis=4
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float64"),{1,2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"complex64"),{1,2,3})
 local got=np.stack({a1,a2},4)
 check(got,"complex128",{1,2,3,2},{{{{np.complex(-2.5,0.0),np.complex(-2.0,0.0)},{np.complex(1.0,0.0),np.complex(1.0,0.0)},{np.complex(3.0,0.0),np.complex(3.0,0.0)}},{{np.complex(4.5,0.0),np.complex(4.0,0.0)},{np.complex(5.0,0.0),np.complex(5.0,0.0)},{np.complex(-1.0,0.0),np.complex(-1.0,0.0)}}}})
 n=n+1
end
-- case 147: float64+complex64 stack shape=(1, 2, 3), axis=-1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float64"),{1,2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"complex64"),{1,2,3})
 local got=np.stack({a1,a2},-1)
 check(got,"complex128",{1,2,3,2},{{{{np.complex(-2.5,0.0),np.complex(-2.0,0.0)},{np.complex(1.0,0.0),np.complex(1.0,0.0)},{np.complex(3.0,0.0),np.complex(3.0,0.0)}},{{np.complex(4.5,0.0),np.complex(4.0,0.0)},{np.complex(5.0,0.0),np.complex(5.0,0.0)},{np.complex(-1.0,0.0),np.complex(-1.0,0.0)}}}})
 n=n+1
end
-- case 148: float64+complex64 dtype float32 casting=no
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float64"),{3})
 local a2=np.reshape(np.array({-2,1,3},"complex64"),{3})
 local ok=pcall(function()return np.concatenate({a1,a2},1,{dtype="float32",casting="no"}) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 149: float64+complex64 dtype float32 casting=equiv
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float64"),{3})
 local a2=np.reshape(np.array({-2,1,3},"complex64"),{3})
 local ok=pcall(function()return np.concatenate({a1,a2},1,{dtype="float32",casting="equiv"}) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 150: float64+complex64 dtype float32 casting=safe
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float64"),{3})
 local a2=np.reshape(np.array({-2,1,3},"complex64"),{3})
 local ok=pcall(function()return np.concatenate({a1,a2},1,{dtype="float32",casting="safe"}) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 151: float64+complex64 dtype float32 casting=same_kind
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float64"),{3})
 local a2=np.reshape(np.array({-2,1,3},"complex64"),{3})
 local ok=pcall(function()return np.concatenate({a1,a2},1,{dtype="float32",casting="same_kind"}) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 152: float64+complex64 dtype float32 casting=unsafe
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float64"),{3})
 local a2=np.reshape(np.array({-2,1,3},"complex64"),{3})
 local got=np.concatenate({a1,a2},1,{dtype="float32",casting="unsafe"})
 check(got,"float32",{6},{-2.5,1.0,3.0,-2.0,1.0,3.0})
 n=n+1
end
-- case 153: float64+complex64 out=float64 casting=same_kind
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float64"),{3})
 local a2=np.reshape(np.array({-2,1,3},"complex64"),{3})
 local dst=np.zeros({6},"float64")
 local ok=pcall(function()return np.concatenate({a1,a2},1,{casting="same_kind",out=dst}) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 154: float64+complex64 out=float64 casting=unsafe
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float64"),{3})
 local a2=np.reshape(np.array({-2,1,3},"complex64"),{3})
 local dst=np.zeros({6},"float64")
 local got=np.concatenate({a1,a2},1,{casting="unsafe",out=dst})
 assert(got==dst,"must return supplied out")
 check(got,"float64",{6},{-2.5,1.0,3.0,-2.0,1.0,3.0})
 n=n+1
end
-- case 155: float64+complex64 out=int8 casting=same_kind
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float64"),{3})
 local a2=np.reshape(np.array({-2,1,3},"complex64"),{3})
 local dst=np.zeros({6},"int8")
 local ok=pcall(function()return np.concatenate({a1,a2},1,{casting="same_kind",out=dst}) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 156: float64+complex64 out=int8 casting=unsafe
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float64"),{3})
 local a2=np.reshape(np.array({-2,1,3},"complex64"),{3})
 local dst=np.zeros({6},"int8")
 local got=np.concatenate({a1,a2},1,{casting="unsafe",out=dst})
 assert(got==dst,"must return supplied out")
 check(got,"int8",{6},{-2,1,3,-2,1,3})
 n=n+1
end
-- case 157: complex64+complex128 concat shape=(3,), axis=1
do
 local a1=np.reshape(np.array({-2,1,3},"complex64"),{3})
 local a2=np.reshape(np.array({-2,1,3},"complex128"),{3})
 local got=np.concatenate({a1,a2},1)
 check(got,"complex128",{6},{np.complex(-2.0,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0),np.complex(-2.0,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0)})
 n=n+1
end
-- case 158: complex64+complex128 concat shape=(3,), axis=False
do
 local a1=np.reshape(np.array({-2,1,3},"complex64"),{3})
 local a2=np.reshape(np.array({-2,1,3},"complex128"),{3})
 local got=np.concatenate({a1,a2},false)
 check(got,"complex128",{6},{np.complex(-2.0,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0),np.complex(-2.0,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0)})
 n=n+1
end
-- case 159: complex64+complex128 stack shape=(3,), axis=1
do
 local a1=np.reshape(np.array({-2,1,3},"complex64"),{3})
 local a2=np.reshape(np.array({-2,1,3},"complex128"),{3})
 local got=np.stack({a1,a2},1)
 check(got,"complex128",{2,3},{{np.complex(-2.0,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0)},{np.complex(-2.0,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0)}})
 n=n+1
end
-- case 160: complex64+complex128 stack shape=(3,), axis=2
do
 local a1=np.reshape(np.array({-2,1,3},"complex64"),{3})
 local a2=np.reshape(np.array({-2,1,3},"complex128"),{3})
 local got=np.stack({a1,a2},2)
 check(got,"complex128",{3,2},{{np.complex(-2.0,0.0),np.complex(-2.0,0.0)},{np.complex(1.0,0.0),np.complex(1.0,0.0)},{np.complex(3.0,0.0),np.complex(3.0,0.0)}})
 n=n+1
end
-- case 161: complex64+complex128 stack shape=(3,), axis=-1
do
 local a1=np.reshape(np.array({-2,1,3},"complex64"),{3})
 local a2=np.reshape(np.array({-2,1,3},"complex128"),{3})
 local got=np.stack({a1,a2},-1)
 check(got,"complex128",{3,2},{{np.complex(-2.0,0.0),np.complex(-2.0,0.0)},{np.complex(1.0,0.0),np.complex(1.0,0.0)},{np.complex(3.0,0.0),np.complex(3.0,0.0)}})
 n=n+1
end
-- case 162: complex64+complex128 concat shape=(2, 3), axis=1
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"complex64"),{2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"complex128"),{2,3})
 local got=np.concatenate({a1,a2},1)
 check(got,"complex128",{4,3},{{np.complex(-2.0,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(-1.0,0.0)},{np.complex(-2.0,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(-1.0,0.0)}})
 n=n+1
end
-- case 163: complex64+complex128 concat shape=(2, 3), axis=-1
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"complex64"),{2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"complex128"),{2,3})
 local got=np.concatenate({a1,a2},-1)
 check(got,"complex128",{2,6},{{np.complex(-2.0,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0),np.complex(-2.0,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(-1.0,0.0),np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(-1.0,0.0)}})
 n=n+1
end
-- case 164: complex64+complex128 concat shape=(2, 3), axis=False
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"complex64"),{2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"complex128"),{2,3})
 local got=np.concatenate({a1,a2},false)
 check(got,"complex128",{12},{np.complex(-2.0,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0),np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(-1.0,0.0),np.complex(-2.0,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0),np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(-1.0,0.0)})
 n=n+1
end
-- case 165: complex64+complex128 stack shape=(2, 3), axis=1
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"complex64"),{2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"complex128"),{2,3})
 local got=np.stack({a1,a2},1)
 check(got,"complex128",{2,2,3},{{{np.complex(-2.0,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(-1.0,0.0)}},{{np.complex(-2.0,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(-1.0,0.0)}}})
 n=n+1
end
-- case 166: complex64+complex128 stack shape=(2, 3), axis=3
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"complex64"),{2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"complex128"),{2,3})
 local got=np.stack({a1,a2},3)
 check(got,"complex128",{2,3,2},{{{np.complex(-2.0,0.0),np.complex(-2.0,0.0)},{np.complex(1.0,0.0),np.complex(1.0,0.0)},{np.complex(3.0,0.0),np.complex(3.0,0.0)}},{{np.complex(4.0,0.0),np.complex(4.0,0.0)},{np.complex(5.0,0.0),np.complex(5.0,0.0)},{np.complex(-1.0,0.0),np.complex(-1.0,0.0)}}})
 n=n+1
end
-- case 167: complex64+complex128 stack shape=(2, 3), axis=-1
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"complex64"),{2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"complex128"),{2,3})
 local got=np.stack({a1,a2},-1)
 check(got,"complex128",{2,3,2},{{{np.complex(-2.0,0.0),np.complex(-2.0,0.0)},{np.complex(1.0,0.0),np.complex(1.0,0.0)},{np.complex(3.0,0.0),np.complex(3.0,0.0)}},{{np.complex(4.0,0.0),np.complex(4.0,0.0)},{np.complex(5.0,0.0),np.complex(5.0,0.0)},{np.complex(-1.0,0.0),np.complex(-1.0,0.0)}}})
 n=n+1
end
-- case 168: complex64+complex128 concat shape=(1, 2, 3), axis=1
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"complex64"),{1,2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"complex128"),{1,2,3})
 local got=np.concatenate({a1,a2},1)
 check(got,"complex128",{2,2,3},{{{np.complex(-2.0,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(-1.0,0.0)}},{{np.complex(-2.0,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(-1.0,0.0)}}})
 n=n+1
end
-- case 169: complex64+complex128 concat shape=(1, 2, 3), axis=-1
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"complex64"),{1,2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"complex128"),{1,2,3})
 local got=np.concatenate({a1,a2},-1)
 check(got,"complex128",{1,2,6},{{{np.complex(-2.0,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0),np.complex(-2.0,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(-1.0,0.0),np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(-1.0,0.0)}}})
 n=n+1
end
-- case 170: complex64+complex128 concat shape=(1, 2, 3), axis=False
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"complex64"),{1,2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"complex128"),{1,2,3})
 local got=np.concatenate({a1,a2},false)
 check(got,"complex128",{12},{np.complex(-2.0,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0),np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(-1.0,0.0),np.complex(-2.0,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0),np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(-1.0,0.0)})
 n=n+1
end
-- case 171: complex64+complex128 stack shape=(1, 2, 3), axis=1
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"complex64"),{1,2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"complex128"),{1,2,3})
 local got=np.stack({a1,a2},1)
 check(got,"complex128",{2,1,2,3},{{{{np.complex(-2.0,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(-1.0,0.0)}}},{{{np.complex(-2.0,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(-1.0,0.0)}}}})
 n=n+1
end
-- case 172: complex64+complex128 stack shape=(1, 2, 3), axis=4
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"complex64"),{1,2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"complex128"),{1,2,3})
 local got=np.stack({a1,a2},4)
 check(got,"complex128",{1,2,3,2},{{{{np.complex(-2.0,0.0),np.complex(-2.0,0.0)},{np.complex(1.0,0.0),np.complex(1.0,0.0)},{np.complex(3.0,0.0),np.complex(3.0,0.0)}},{{np.complex(4.0,0.0),np.complex(4.0,0.0)},{np.complex(5.0,0.0),np.complex(5.0,0.0)},{np.complex(-1.0,0.0),np.complex(-1.0,0.0)}}}})
 n=n+1
end
-- case 173: complex64+complex128 stack shape=(1, 2, 3), axis=-1
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"complex64"),{1,2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"complex128"),{1,2,3})
 local got=np.stack({a1,a2},-1)
 check(got,"complex128",{1,2,3,2},{{{{np.complex(-2.0,0.0),np.complex(-2.0,0.0)},{np.complex(1.0,0.0),np.complex(1.0,0.0)},{np.complex(3.0,0.0),np.complex(3.0,0.0)}},{{np.complex(4.0,0.0),np.complex(4.0,0.0)},{np.complex(5.0,0.0),np.complex(5.0,0.0)},{np.complex(-1.0,0.0),np.complex(-1.0,0.0)}}}})
 n=n+1
end
-- case 174: complex64+complex128 dtype float32 casting=no
do
 local a1=np.reshape(np.array({-2,1,3},"complex64"),{3})
 local a2=np.reshape(np.array({-2,1,3},"complex128"),{3})
 local ok=pcall(function()return np.concatenate({a1,a2},1,{dtype="float32",casting="no"}) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 175: complex64+complex128 dtype float32 casting=equiv
do
 local a1=np.reshape(np.array({-2,1,3},"complex64"),{3})
 local a2=np.reshape(np.array({-2,1,3},"complex128"),{3})
 local ok=pcall(function()return np.concatenate({a1,a2},1,{dtype="float32",casting="equiv"}) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 176: complex64+complex128 dtype float32 casting=safe
do
 local a1=np.reshape(np.array({-2,1,3},"complex64"),{3})
 local a2=np.reshape(np.array({-2,1,3},"complex128"),{3})
 local ok=pcall(function()return np.concatenate({a1,a2},1,{dtype="float32",casting="safe"}) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 177: complex64+complex128 dtype float32 casting=same_kind
do
 local a1=np.reshape(np.array({-2,1,3},"complex64"),{3})
 local a2=np.reshape(np.array({-2,1,3},"complex128"),{3})
 local ok=pcall(function()return np.concatenate({a1,a2},1,{dtype="float32",casting="same_kind"}) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 178: complex64+complex128 dtype float32 casting=unsafe
do
 local a1=np.reshape(np.array({-2,1,3},"complex64"),{3})
 local a2=np.reshape(np.array({-2,1,3},"complex128"),{3})
 local got=np.concatenate({a1,a2},1,{dtype="float32",casting="unsafe"})
 check(got,"float32",{6},{-2.0,1.0,3.0,-2.0,1.0,3.0})
 n=n+1
end
-- case 179: complex64+complex128 out=float64 casting=same_kind
do
 local a1=np.reshape(np.array({-2,1,3},"complex64"),{3})
 local a2=np.reshape(np.array({-2,1,3},"complex128"),{3})
 local dst=np.zeros({6},"float64")
 local ok=pcall(function()return np.concatenate({a1,a2},1,{casting="same_kind",out=dst}) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 180: complex64+complex128 out=float64 casting=unsafe
do
 local a1=np.reshape(np.array({-2,1,3},"complex64"),{3})
 local a2=np.reshape(np.array({-2,1,3},"complex128"),{3})
 local dst=np.zeros({6},"float64")
 local got=np.concatenate({a1,a2},1,{casting="unsafe",out=dst})
 assert(got==dst,"must return supplied out")
 check(got,"float64",{6},{-2.0,1.0,3.0,-2.0,1.0,3.0})
 n=n+1
end
-- case 181: complex64+complex128 out=int8 casting=same_kind
do
 local a1=np.reshape(np.array({-2,1,3},"complex64"),{3})
 local a2=np.reshape(np.array({-2,1,3},"complex128"),{3})
 local dst=np.zeros({6},"int8")
 local ok=pcall(function()return np.concatenate({a1,a2},1,{casting="same_kind",out=dst}) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 182: complex64+complex128 out=int8 casting=unsafe
do
 local a1=np.reshape(np.array({-2,1,3},"complex64"),{3})
 local a2=np.reshape(np.array({-2,1,3},"complex128"),{3})
 local dst=np.zeros({6},"int8")
 local got=np.concatenate({a1,a2},1,{casting="unsafe",out=dst})
 assert(got==dst,"must return supplied out")
 check(got,"int8",{6},{-2,1,3,-2,1,3})
 n=n+1
end
-- case 183: int64+uint8 concat shape=(3,), axis=1
do
 local a1=np.reshape(np.array({-2,1,3},"int64"),{3})
 local a2=np.reshape(np.array({0,1,3},"uint8"),{3})
 local got=np.concatenate({a1,a2},1)
 check(got,"int64",{6},{-2,1,3,0,1,3})
 n=n+1
end
-- case 184: int64+uint8 concat shape=(3,), axis=False
do
 local a1=np.reshape(np.array({-2,1,3},"int64"),{3})
 local a2=np.reshape(np.array({0,1,3},"uint8"),{3})
 local got=np.concatenate({a1,a2},false)
 check(got,"int64",{6},{-2,1,3,0,1,3})
 n=n+1
end
-- case 185: int64+uint8 stack shape=(3,), axis=1
do
 local a1=np.reshape(np.array({-2,1,3},"int64"),{3})
 local a2=np.reshape(np.array({0,1,3},"uint8"),{3})
 local got=np.stack({a1,a2},1)
 check(got,"int64",{2,3},{{-2,1,3},{0,1,3}})
 n=n+1
end
-- case 186: int64+uint8 stack shape=(3,), axis=2
do
 local a1=np.reshape(np.array({-2,1,3},"int64"),{3})
 local a2=np.reshape(np.array({0,1,3},"uint8"),{3})
 local got=np.stack({a1,a2},2)
 check(got,"int64",{3,2},{{-2,0},{1,1},{3,3}})
 n=n+1
end
-- case 187: int64+uint8 stack shape=(3,), axis=-1
do
 local a1=np.reshape(np.array({-2,1,3},"int64"),{3})
 local a2=np.reshape(np.array({0,1,3},"uint8"),{3})
 local got=np.stack({a1,a2},-1)
 check(got,"int64",{3,2},{{-2,0},{1,1},{3,3}})
 n=n+1
end
-- case 188: int64+uint8 concat shape=(2, 3), axis=1
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"int64"),{2,3})
 local a2=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{2,3})
 local got=np.concatenate({a1,a2},1)
 check(got,"int64",{4,3},{{-2,1,3},{4,5,-1},{0,1,3},{4,5,6}})
 n=n+1
end
-- case 189: int64+uint8 concat shape=(2, 3), axis=-1
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"int64"),{2,3})
 local a2=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{2,3})
 local got=np.concatenate({a1,a2},-1)
 check(got,"int64",{2,6},{{-2,1,3,0,1,3},{4,5,-1,4,5,6}})
 n=n+1
end
-- case 190: int64+uint8 concat shape=(2, 3), axis=False
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"int64"),{2,3})
 local a2=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{2,3})
 local got=np.concatenate({a1,a2},false)
 check(got,"int64",{12},{-2,1,3,4,5,-1,0,1,3,4,5,6})
 n=n+1
end
-- case 191: int64+uint8 stack shape=(2, 3), axis=1
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"int64"),{2,3})
 local a2=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{2,3})
 local got=np.stack({a1,a2},1)
 check(got,"int64",{2,2,3},{{{-2,1,3},{4,5,-1}},{{0,1,3},{4,5,6}}})
 n=n+1
end
-- case 192: int64+uint8 stack shape=(2, 3), axis=3
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"int64"),{2,3})
 local a2=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{2,3})
 local got=np.stack({a1,a2},3)
 check(got,"int64",{2,3,2},{{{-2,0},{1,1},{3,3}},{{4,4},{5,5},{-1,6}}})
 n=n+1
end
-- case 193: int64+uint8 stack shape=(2, 3), axis=-1
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"int64"),{2,3})
 local a2=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{2,3})
 local got=np.stack({a1,a2},-1)
 check(got,"int64",{2,3,2},{{{-2,0},{1,1},{3,3}},{{4,4},{5,5},{-1,6}}})
 n=n+1
end
-- case 194: int64+uint8 concat shape=(1, 2, 3), axis=1
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"int64"),{1,2,3})
 local a2=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{1,2,3})
 local got=np.concatenate({a1,a2},1)
 check(got,"int64",{2,2,3},{{{-2,1,3},{4,5,-1}},{{0,1,3},{4,5,6}}})
 n=n+1
end
-- case 195: int64+uint8 concat shape=(1, 2, 3), axis=-1
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"int64"),{1,2,3})
 local a2=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{1,2,3})
 local got=np.concatenate({a1,a2},-1)
 check(got,"int64",{1,2,6},{{{-2,1,3,0,1,3},{4,5,-1,4,5,6}}})
 n=n+1
end
-- case 196: int64+uint8 concat shape=(1, 2, 3), axis=False
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"int64"),{1,2,3})
 local a2=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{1,2,3})
 local got=np.concatenate({a1,a2},false)
 check(got,"int64",{12},{-2,1,3,4,5,-1,0,1,3,4,5,6})
 n=n+1
end
-- case 197: int64+uint8 stack shape=(1, 2, 3), axis=1
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"int64"),{1,2,3})
 local a2=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{1,2,3})
 local got=np.stack({a1,a2},1)
 check(got,"int64",{2,1,2,3},{{{{-2,1,3},{4,5,-1}}},{{{0,1,3},{4,5,6}}}})
 n=n+1
end
-- case 198: int64+uint8 stack shape=(1, 2, 3), axis=4
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"int64"),{1,2,3})
 local a2=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{1,2,3})
 local got=np.stack({a1,a2},4)
 check(got,"int64",{1,2,3,2},{{{{-2,0},{1,1},{3,3}},{{4,4},{5,5},{-1,6}}}})
 n=n+1
end
-- case 199: int64+uint8 stack shape=(1, 2, 3), axis=-1
do
 local a1=np.reshape(np.array({-2,1,3,4,5,-1},"int64"),{1,2,3})
 local a2=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{1,2,3})
 local got=np.stack({a1,a2},-1)
 check(got,"int64",{1,2,3,2},{{{{-2,0},{1,1},{3,3}},{{4,4},{5,5},{-1,6}}}})
 n=n+1
end
-- case 200: int64+uint8 dtype float32 casting=no
do
 local a1=np.reshape(np.array({-2,1,3},"int64"),{3})
 local a2=np.reshape(np.array({0,1,3},"uint8"),{3})
 local ok=pcall(function()return np.concatenate({a1,a2},1,{dtype="float32",casting="no"}) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 201: int64+uint8 dtype float32 casting=equiv
do
 local a1=np.reshape(np.array({-2,1,3},"int64"),{3})
 local a2=np.reshape(np.array({0,1,3},"uint8"),{3})
 local ok=pcall(function()return np.concatenate({a1,a2},1,{dtype="float32",casting="equiv"}) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 202: int64+uint8 dtype float32 casting=safe
do
 local a1=np.reshape(np.array({-2,1,3},"int64"),{3})
 local a2=np.reshape(np.array({0,1,3},"uint8"),{3})
 local ok=pcall(function()return np.concatenate({a1,a2},1,{dtype="float32",casting="safe"}) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 203: int64+uint8 dtype float32 casting=same_kind
do
 local a1=np.reshape(np.array({-2,1,3},"int64"),{3})
 local a2=np.reshape(np.array({0,1,3},"uint8"),{3})
 local got=np.concatenate({a1,a2},1,{dtype="float32",casting="same_kind"})
 check(got,"float32",{6},{-2.0,1.0,3.0,0.0,1.0,3.0})
 n=n+1
end
-- case 204: int64+uint8 dtype float32 casting=unsafe
do
 local a1=np.reshape(np.array({-2,1,3},"int64"),{3})
 local a2=np.reshape(np.array({0,1,3},"uint8"),{3})
 local got=np.concatenate({a1,a2},1,{dtype="float32",casting="unsafe"})
 check(got,"float32",{6},{-2.0,1.0,3.0,0.0,1.0,3.0})
 n=n+1
end
-- case 205: int64+uint8 out=float64 casting=same_kind
do
 local a1=np.reshape(np.array({-2,1,3},"int64"),{3})
 local a2=np.reshape(np.array({0,1,3},"uint8"),{3})
 local dst=np.zeros({6},"float64")
 local got=np.concatenate({a1,a2},1,{casting="same_kind",out=dst})
 assert(got==dst,"must return supplied out")
 check(got,"float64",{6},{-2.0,1.0,3.0,0.0,1.0,3.0})
 n=n+1
end
-- case 206: int64+uint8 out=float64 casting=unsafe
do
 local a1=np.reshape(np.array({-2,1,3},"int64"),{3})
 local a2=np.reshape(np.array({0,1,3},"uint8"),{3})
 local dst=np.zeros({6},"float64")
 local got=np.concatenate({a1,a2},1,{casting="unsafe",out=dst})
 assert(got==dst,"must return supplied out")
 check(got,"float64",{6},{-2.0,1.0,3.0,0.0,1.0,3.0})
 n=n+1
end
-- case 207: int64+uint8 out=int8 casting=same_kind
do
 local a1=np.reshape(np.array({-2,1,3},"int64"),{3})
 local a2=np.reshape(np.array({0,1,3},"uint8"),{3})
 local dst=np.zeros({6},"int8")
 local got=np.concatenate({a1,a2},1,{casting="same_kind",out=dst})
 assert(got==dst,"must return supplied out")
 check(got,"int8",{6},{-2,1,3,0,1,3})
 n=n+1
end
-- case 208: int64+uint8 out=int8 casting=unsafe
do
 local a1=np.reshape(np.array({-2,1,3},"int64"),{3})
 local a2=np.reshape(np.array({0,1,3},"uint8"),{3})
 local dst=np.zeros({6},"int8")
 local got=np.concatenate({a1,a2},1,{casting="unsafe",out=dst})
 assert(got==dst,"must return supplied out")
 check(got,"int8",{6},{-2,1,3,0,1,3})
 n=n+1
end
-- case 209: float16+int64 concat shape=(3,), axis=1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float16"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int64"),{3})
 local got=np.concatenate({a1,a2},1)
 check(got,"float64",{6},{-2.5,1.0,3.0,-2.0,1.0,3.0})
 n=n+1
end
-- case 210: float16+int64 concat shape=(3,), axis=False
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float16"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int64"),{3})
 local got=np.concatenate({a1,a2},false)
 check(got,"float64",{6},{-2.5,1.0,3.0,-2.0,1.0,3.0})
 n=n+1
end
-- case 211: float16+int64 stack shape=(3,), axis=1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float16"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int64"),{3})
 local got=np.stack({a1,a2},1)
 check(got,"float64",{2,3},{{-2.5,1.0,3.0},{-2.0,1.0,3.0}})
 n=n+1
end
-- case 212: float16+int64 stack shape=(3,), axis=2
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float16"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int64"),{3})
 local got=np.stack({a1,a2},2)
 check(got,"float64",{3,2},{{-2.5,-2.0},{1.0,1.0},{3.0,3.0}})
 n=n+1
end
-- case 213: float16+int64 stack shape=(3,), axis=-1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float16"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int64"),{3})
 local got=np.stack({a1,a2},-1)
 check(got,"float64",{3,2},{{-2.5,-2.0},{1.0,1.0},{3.0,3.0}})
 n=n+1
end
-- case 214: float16+int64 concat shape=(2, 3), axis=1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float16"),{2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int64"),{2,3})
 local got=np.concatenate({a1,a2},1)
 check(got,"float64",{4,3},{{-2.5,1.0,3.0},{4.5,5.0,-1.0},{-2.0,1.0,3.0},{4.0,5.0,-1.0}})
 n=n+1
end
-- case 215: float16+int64 concat shape=(2, 3), axis=-1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float16"),{2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int64"),{2,3})
 local got=np.concatenate({a1,a2},-1)
 check(got,"float64",{2,6},{{-2.5,1.0,3.0,-2.0,1.0,3.0},{4.5,5.0,-1.0,4.0,5.0,-1.0}})
 n=n+1
end
-- case 216: float16+int64 concat shape=(2, 3), axis=False
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float16"),{2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int64"),{2,3})
 local got=np.concatenate({a1,a2},false)
 check(got,"float64",{12},{-2.5,1.0,3.0,4.5,5.0,-1.0,-2.0,1.0,3.0,4.0,5.0,-1.0})
 n=n+1
end
-- case 217: float16+int64 stack shape=(2, 3), axis=1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float16"),{2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int64"),{2,3})
 local got=np.stack({a1,a2},1)
 check(got,"float64",{2,2,3},{{{-2.5,1.0,3.0},{4.5,5.0,-1.0}},{{-2.0,1.0,3.0},{4.0,5.0,-1.0}}})
 n=n+1
end
-- case 218: float16+int64 stack shape=(2, 3), axis=3
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float16"),{2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int64"),{2,3})
 local got=np.stack({a1,a2},3)
 check(got,"float64",{2,3,2},{{{-2.5,-2.0},{1.0,1.0},{3.0,3.0}},{{4.5,4.0},{5.0,5.0},{-1.0,-1.0}}})
 n=n+1
end
-- case 219: float16+int64 stack shape=(2, 3), axis=-1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float16"),{2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int64"),{2,3})
 local got=np.stack({a1,a2},-1)
 check(got,"float64",{2,3,2},{{{-2.5,-2.0},{1.0,1.0},{3.0,3.0}},{{4.5,4.0},{5.0,5.0},{-1.0,-1.0}}})
 n=n+1
end
-- case 220: float16+int64 concat shape=(1, 2, 3), axis=1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float16"),{1,2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int64"),{1,2,3})
 local got=np.concatenate({a1,a2},1)
 check(got,"float64",{2,2,3},{{{-2.5,1.0,3.0},{4.5,5.0,-1.0}},{{-2.0,1.0,3.0},{4.0,5.0,-1.0}}})
 n=n+1
end
-- case 221: float16+int64 concat shape=(1, 2, 3), axis=-1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float16"),{1,2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int64"),{1,2,3})
 local got=np.concatenate({a1,a2},-1)
 check(got,"float64",{1,2,6},{{{-2.5,1.0,3.0,-2.0,1.0,3.0},{4.5,5.0,-1.0,4.0,5.0,-1.0}}})
 n=n+1
end
-- case 222: float16+int64 concat shape=(1, 2, 3), axis=False
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float16"),{1,2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int64"),{1,2,3})
 local got=np.concatenate({a1,a2},false)
 check(got,"float64",{12},{-2.5,1.0,3.0,4.5,5.0,-1.0,-2.0,1.0,3.0,4.0,5.0,-1.0})
 n=n+1
end
-- case 223: float16+int64 stack shape=(1, 2, 3), axis=1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float16"),{1,2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int64"),{1,2,3})
 local got=np.stack({a1,a2},1)
 check(got,"float64",{2,1,2,3},{{{{-2.5,1.0,3.0},{4.5,5.0,-1.0}}},{{{-2.0,1.0,3.0},{4.0,5.0,-1.0}}}})
 n=n+1
end
-- case 224: float16+int64 stack shape=(1, 2, 3), axis=4
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float16"),{1,2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int64"),{1,2,3})
 local got=np.stack({a1,a2},4)
 check(got,"float64",{1,2,3,2},{{{{-2.5,-2.0},{1.0,1.0},{3.0,3.0}},{{4.5,4.0},{5.0,5.0},{-1.0,-1.0}}}})
 n=n+1
end
-- case 225: float16+int64 stack shape=(1, 2, 3), axis=-1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float16"),{1,2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int64"),{1,2,3})
 local got=np.stack({a1,a2},-1)
 check(got,"float64",{1,2,3,2},{{{{-2.5,-2.0},{1.0,1.0},{3.0,3.0}},{{4.5,4.0},{5.0,5.0},{-1.0,-1.0}}}})
 n=n+1
end
-- case 226: float16+int64 dtype float32 casting=no
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float16"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int64"),{3})
 local ok=pcall(function()return np.concatenate({a1,a2},1,{dtype="float32",casting="no"}) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 227: float16+int64 dtype float32 casting=equiv
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float16"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int64"),{3})
 local ok=pcall(function()return np.concatenate({a1,a2},1,{dtype="float32",casting="equiv"}) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 228: float16+int64 dtype float32 casting=safe
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float16"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int64"),{3})
 local ok=pcall(function()return np.concatenate({a1,a2},1,{dtype="float32",casting="safe"}) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 229: float16+int64 dtype float32 casting=same_kind
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float16"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int64"),{3})
 local got=np.concatenate({a1,a2},1,{dtype="float32",casting="same_kind"})
 check(got,"float32",{6},{-2.5,1.0,3.0,-2.0,1.0,3.0})
 n=n+1
end
-- case 230: float16+int64 dtype float32 casting=unsafe
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float16"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int64"),{3})
 local got=np.concatenate({a1,a2},1,{dtype="float32",casting="unsafe"})
 check(got,"float32",{6},{-2.5,1.0,3.0,-2.0,1.0,3.0})
 n=n+1
end
-- case 231: float16+int64 out=float64 casting=same_kind
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float16"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int64"),{3})
 local dst=np.zeros({6},"float64")
 local got=np.concatenate({a1,a2},1,{casting="same_kind",out=dst})
 assert(got==dst,"must return supplied out")
 check(got,"float64",{6},{-2.5,1.0,3.0,-2.0,1.0,3.0})
 n=n+1
end
-- case 232: float16+int64 out=float64 casting=unsafe
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float16"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int64"),{3})
 local dst=np.zeros({6},"float64")
 local got=np.concatenate({a1,a2},1,{casting="unsafe",out=dst})
 assert(got==dst,"must return supplied out")
 check(got,"float64",{6},{-2.5,1.0,3.0,-2.0,1.0,3.0})
 n=n+1
end
-- case 233: float16+int64 out=int8 casting=same_kind
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float16"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int64"),{3})
 local dst=np.zeros({6},"int8")
 local ok=pcall(function()return np.concatenate({a1,a2},1,{casting="same_kind",out=dst}) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 234: float16+int64 out=int8 casting=unsafe
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float16"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int64"),{3})
 local dst=np.zeros({6},"int8")
 local got=np.concatenate({a1,a2},1,{casting="unsafe",out=dst})
 assert(got==dst,"must return supplied out")
 check(got,"int8",{6},{-2,1,3,-2,1,3})
 n=n+1
end
-- case 235: float32+int8 concat shape=(3,), axis=1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float32"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int8"),{3})
 local got=np.concatenate({a1,a2},1)
 check(got,"float32",{6},{-2.5,1.0,3.0,-2.0,1.0,3.0})
 n=n+1
end
-- case 236: float32+int8 concat shape=(3,), axis=False
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float32"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int8"),{3})
 local got=np.concatenate({a1,a2},false)
 check(got,"float32",{6},{-2.5,1.0,3.0,-2.0,1.0,3.0})
 n=n+1
end
-- case 237: float32+int8 stack shape=(3,), axis=1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float32"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int8"),{3})
 local got=np.stack({a1,a2},1)
 check(got,"float32",{2,3},{{-2.5,1.0,3.0},{-2.0,1.0,3.0}})
 n=n+1
end
-- case 238: float32+int8 stack shape=(3,), axis=2
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float32"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int8"),{3})
 local got=np.stack({a1,a2},2)
 check(got,"float32",{3,2},{{-2.5,-2.0},{1.0,1.0},{3.0,3.0}})
 n=n+1
end
-- case 239: float32+int8 stack shape=(3,), axis=-1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float32"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int8"),{3})
 local got=np.stack({a1,a2},-1)
 check(got,"float32",{3,2},{{-2.5,-2.0},{1.0,1.0},{3.0,3.0}})
 n=n+1
end
-- case 240: float32+int8 concat shape=(2, 3), axis=1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float32"),{2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{2,3})
 local got=np.concatenate({a1,a2},1)
 check(got,"float32",{4,3},{{-2.5,1.0,3.0},{4.5,5.0,-1.0},{-2.0,1.0,3.0},{4.0,5.0,-1.0}})
 n=n+1
end
-- case 241: float32+int8 concat shape=(2, 3), axis=-1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float32"),{2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{2,3})
 local got=np.concatenate({a1,a2},-1)
 check(got,"float32",{2,6},{{-2.5,1.0,3.0,-2.0,1.0,3.0},{4.5,5.0,-1.0,4.0,5.0,-1.0}})
 n=n+1
end
-- case 242: float32+int8 concat shape=(2, 3), axis=False
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float32"),{2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{2,3})
 local got=np.concatenate({a1,a2},false)
 check(got,"float32",{12},{-2.5,1.0,3.0,4.5,5.0,-1.0,-2.0,1.0,3.0,4.0,5.0,-1.0})
 n=n+1
end
-- case 243: float32+int8 stack shape=(2, 3), axis=1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float32"),{2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{2,3})
 local got=np.stack({a1,a2},1)
 check(got,"float32",{2,2,3},{{{-2.5,1.0,3.0},{4.5,5.0,-1.0}},{{-2.0,1.0,3.0},{4.0,5.0,-1.0}}})
 n=n+1
end
-- case 244: float32+int8 stack shape=(2, 3), axis=3
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float32"),{2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{2,3})
 local got=np.stack({a1,a2},3)
 check(got,"float32",{2,3,2},{{{-2.5,-2.0},{1.0,1.0},{3.0,3.0}},{{4.5,4.0},{5.0,5.0},{-1.0,-1.0}}})
 n=n+1
end
-- case 245: float32+int8 stack shape=(2, 3), axis=-1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float32"),{2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{2,3})
 local got=np.stack({a1,a2},-1)
 check(got,"float32",{2,3,2},{{{-2.5,-2.0},{1.0,1.0},{3.0,3.0}},{{4.5,4.0},{5.0,5.0},{-1.0,-1.0}}})
 n=n+1
end
-- case 246: float32+int8 concat shape=(1, 2, 3), axis=1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float32"),{1,2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{1,2,3})
 local got=np.concatenate({a1,a2},1)
 check(got,"float32",{2,2,3},{{{-2.5,1.0,3.0},{4.5,5.0,-1.0}},{{-2.0,1.0,3.0},{4.0,5.0,-1.0}}})
 n=n+1
end
-- case 247: float32+int8 concat shape=(1, 2, 3), axis=-1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float32"),{1,2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{1,2,3})
 local got=np.concatenate({a1,a2},-1)
 check(got,"float32",{1,2,6},{{{-2.5,1.0,3.0,-2.0,1.0,3.0},{4.5,5.0,-1.0,4.0,5.0,-1.0}}})
 n=n+1
end
-- case 248: float32+int8 concat shape=(1, 2, 3), axis=False
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float32"),{1,2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{1,2,3})
 local got=np.concatenate({a1,a2},false)
 check(got,"float32",{12},{-2.5,1.0,3.0,4.5,5.0,-1.0,-2.0,1.0,3.0,4.0,5.0,-1.0})
 n=n+1
end
-- case 249: float32+int8 stack shape=(1, 2, 3), axis=1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float32"),{1,2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{1,2,3})
 local got=np.stack({a1,a2},1)
 check(got,"float32",{2,1,2,3},{{{{-2.5,1.0,3.0},{4.5,5.0,-1.0}}},{{{-2.0,1.0,3.0},{4.0,5.0,-1.0}}}})
 n=n+1
end
-- case 250: float32+int8 stack shape=(1, 2, 3), axis=4
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float32"),{1,2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{1,2,3})
 local got=np.stack({a1,a2},4)
 check(got,"float32",{1,2,3,2},{{{{-2.5,-2.0},{1.0,1.0},{3.0,3.0}},{{4.5,4.0},{5.0,5.0},{-1.0,-1.0}}}})
 n=n+1
end
-- case 251: float32+int8 stack shape=(1, 2, 3), axis=-1
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0,4.5,5.0,-1.0},"float32"),{1,2,3})
 local a2=np.reshape(np.array({-2,1,3,4,5,-1},"int8"),{1,2,3})
 local got=np.stack({a1,a2},-1)
 check(got,"float32",{1,2,3,2},{{{{-2.5,-2.0},{1.0,1.0},{3.0,3.0}},{{4.5,4.0},{5.0,5.0},{-1.0,-1.0}}}})
 n=n+1
end
-- case 252: float32+int8 dtype float32 casting=no
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float32"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int8"),{3})
 local ok=pcall(function()return np.concatenate({a1,a2},1,{dtype="float32",casting="no"}) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 253: float32+int8 dtype float32 casting=equiv
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float32"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int8"),{3})
 local ok=pcall(function()return np.concatenate({a1,a2},1,{dtype="float32",casting="equiv"}) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 254: float32+int8 dtype float32 casting=safe
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float32"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int8"),{3})
 local got=np.concatenate({a1,a2},1,{dtype="float32",casting="safe"})
 check(got,"float32",{6},{-2.5,1.0,3.0,-2.0,1.0,3.0})
 n=n+1
end
-- case 255: float32+int8 dtype float32 casting=same_kind
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float32"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int8"),{3})
 local got=np.concatenate({a1,a2},1,{dtype="float32",casting="same_kind"})
 check(got,"float32",{6},{-2.5,1.0,3.0,-2.0,1.0,3.0})
 n=n+1
end
-- case 256: float32+int8 dtype float32 casting=unsafe
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float32"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int8"),{3})
 local got=np.concatenate({a1,a2},1,{dtype="float32",casting="unsafe"})
 check(got,"float32",{6},{-2.5,1.0,3.0,-2.0,1.0,3.0})
 n=n+1
end
-- case 257: float32+int8 out=float64 casting=same_kind
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float32"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int8"),{3})
 local dst=np.zeros({6},"float64")
 local got=np.concatenate({a1,a2},1,{casting="same_kind",out=dst})
 assert(got==dst,"must return supplied out")
 check(got,"float64",{6},{-2.5,1.0,3.0,-2.0,1.0,3.0})
 n=n+1
end
-- case 258: float32+int8 out=float64 casting=unsafe
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float32"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int8"),{3})
 local dst=np.zeros({6},"float64")
 local got=np.concatenate({a1,a2},1,{casting="unsafe",out=dst})
 assert(got==dst,"must return supplied out")
 check(got,"float64",{6},{-2.5,1.0,3.0,-2.0,1.0,3.0})
 n=n+1
end
-- case 259: float32+int8 out=int8 casting=same_kind
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float32"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int8"),{3})
 local dst=np.zeros({6},"int8")
 local ok=pcall(function()return np.concatenate({a1,a2},1,{casting="same_kind",out=dst}) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 260: float32+int8 out=int8 casting=unsafe
do
 local a1=np.reshape(np.array({-2.5,1.0,3.0},"float32"),{3})
 local a2=np.reshape(np.array({-2,1,3},"int8"),{3})
 local dst=np.zeros({6},"int8")
 local got=np.concatenate({a1,a2},1,{casting="unsafe",out=dst})
 assert(got==dst,"must return supplied out")
 check(got,"int8",{6},{-2,1,3,-2,1,3})
 n=n+1
end
-- case 261: uint8+uint8 concat shape=(3,), axis=1
do
 local a1=np.reshape(np.array({0,1,3},"uint8"),{3})
 local a2=np.reshape(np.array({0,1,3},"uint8"),{3})
 local got=np.concatenate({a1,a2},1)
 check(got,"uint8",{6},{0,1,3,0,1,3})
 n=n+1
end
-- case 262: uint8+uint8 concat shape=(3,), axis=False
do
 local a1=np.reshape(np.array({0,1,3},"uint8"),{3})
 local a2=np.reshape(np.array({0,1,3},"uint8"),{3})
 local got=np.concatenate({a1,a2},false)
 check(got,"uint8",{6},{0,1,3,0,1,3})
 n=n+1
end
-- case 263: uint8+uint8 stack shape=(3,), axis=1
do
 local a1=np.reshape(np.array({0,1,3},"uint8"),{3})
 local a2=np.reshape(np.array({0,1,3},"uint8"),{3})
 local got=np.stack({a1,a2},1)
 check(got,"uint8",{2,3},{{0,1,3},{0,1,3}})
 n=n+1
end
-- case 264: uint8+uint8 stack shape=(3,), axis=2
do
 local a1=np.reshape(np.array({0,1,3},"uint8"),{3})
 local a2=np.reshape(np.array({0,1,3},"uint8"),{3})
 local got=np.stack({a1,a2},2)
 check(got,"uint8",{3,2},{{0,0},{1,1},{3,3}})
 n=n+1
end
-- case 265: uint8+uint8 stack shape=(3,), axis=-1
do
 local a1=np.reshape(np.array({0,1,3},"uint8"),{3})
 local a2=np.reshape(np.array({0,1,3},"uint8"),{3})
 local got=np.stack({a1,a2},-1)
 check(got,"uint8",{3,2},{{0,0},{1,1},{3,3}})
 n=n+1
end
-- case 266: uint8+uint8 concat shape=(2, 3), axis=1
do
 local a1=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{2,3})
 local a2=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{2,3})
 local got=np.concatenate({a1,a2},1)
 check(got,"uint8",{4,3},{{0,1,3},{4,5,6},{0,1,3},{4,5,6}})
 n=n+1
end
-- case 267: uint8+uint8 concat shape=(2, 3), axis=-1
do
 local a1=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{2,3})
 local a2=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{2,3})
 local got=np.concatenate({a1,a2},-1)
 check(got,"uint8",{2,6},{{0,1,3,0,1,3},{4,5,6,4,5,6}})
 n=n+1
end
-- case 268: uint8+uint8 concat shape=(2, 3), axis=False
do
 local a1=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{2,3})
 local a2=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{2,3})
 local got=np.concatenate({a1,a2},false)
 check(got,"uint8",{12},{0,1,3,4,5,6,0,1,3,4,5,6})
 n=n+1
end
-- case 269: uint8+uint8 stack shape=(2, 3), axis=1
do
 local a1=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{2,3})
 local a2=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{2,3})
 local got=np.stack({a1,a2},1)
 check(got,"uint8",{2,2,3},{{{0,1,3},{4,5,6}},{{0,1,3},{4,5,6}}})
 n=n+1
end
-- case 270: uint8+uint8 stack shape=(2, 3), axis=3
do
 local a1=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{2,3})
 local a2=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{2,3})
 local got=np.stack({a1,a2},3)
 check(got,"uint8",{2,3,2},{{{0,0},{1,1},{3,3}},{{4,4},{5,5},{6,6}}})
 n=n+1
end
-- case 271: uint8+uint8 stack shape=(2, 3), axis=-1
do
 local a1=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{2,3})
 local a2=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{2,3})
 local got=np.stack({a1,a2},-1)
 check(got,"uint8",{2,3,2},{{{0,0},{1,1},{3,3}},{{4,4},{5,5},{6,6}}})
 n=n+1
end
-- case 272: uint8+uint8 concat shape=(1, 2, 3), axis=1
do
 local a1=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{1,2,3})
 local a2=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{1,2,3})
 local got=np.concatenate({a1,a2},1)
 check(got,"uint8",{2,2,3},{{{0,1,3},{4,5,6}},{{0,1,3},{4,5,6}}})
 n=n+1
end
-- case 273: uint8+uint8 concat shape=(1, 2, 3), axis=-1
do
 local a1=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{1,2,3})
 local a2=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{1,2,3})
 local got=np.concatenate({a1,a2},-1)
 check(got,"uint8",{1,2,6},{{{0,1,3,0,1,3},{4,5,6,4,5,6}}})
 n=n+1
end
-- case 274: uint8+uint8 concat shape=(1, 2, 3), axis=False
do
 local a1=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{1,2,3})
 local a2=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{1,2,3})
 local got=np.concatenate({a1,a2},false)
 check(got,"uint8",{12},{0,1,3,4,5,6,0,1,3,4,5,6})
 n=n+1
end
-- case 275: uint8+uint8 stack shape=(1, 2, 3), axis=1
do
 local a1=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{1,2,3})
 local a2=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{1,2,3})
 local got=np.stack({a1,a2},1)
 check(got,"uint8",{2,1,2,3},{{{{0,1,3},{4,5,6}}},{{{0,1,3},{4,5,6}}}})
 n=n+1
end
-- case 276: uint8+uint8 stack shape=(1, 2, 3), axis=4
do
 local a1=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{1,2,3})
 local a2=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{1,2,3})
 local got=np.stack({a1,a2},4)
 check(got,"uint8",{1,2,3,2},{{{{0,0},{1,1},{3,3}},{{4,4},{5,5},{6,6}}}})
 n=n+1
end
-- case 277: uint8+uint8 stack shape=(1, 2, 3), axis=-1
do
 local a1=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{1,2,3})
 local a2=np.reshape(np.array({0,1,3,4,5,6},"uint8"),{1,2,3})
 local got=np.stack({a1,a2},-1)
 check(got,"uint8",{1,2,3,2},{{{{0,0},{1,1},{3,3}},{{4,4},{5,5},{6,6}}}})
 n=n+1
end
-- case 278: uint8+uint8 dtype float32 casting=no
do
 local a1=np.reshape(np.array({0,1,3},"uint8"),{3})
 local a2=np.reshape(np.array({0,1,3},"uint8"),{3})
 local ok=pcall(function()return np.concatenate({a1,a2},1,{dtype="float32",casting="no"}) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 279: uint8+uint8 dtype float32 casting=equiv
do
 local a1=np.reshape(np.array({0,1,3},"uint8"),{3})
 local a2=np.reshape(np.array({0,1,3},"uint8"),{3})
 local ok=pcall(function()return np.concatenate({a1,a2},1,{dtype="float32",casting="equiv"}) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 280: uint8+uint8 dtype float32 casting=safe
do
 local a1=np.reshape(np.array({0,1,3},"uint8"),{3})
 local a2=np.reshape(np.array({0,1,3},"uint8"),{3})
 local got=np.concatenate({a1,a2},1,{dtype="float32",casting="safe"})
 check(got,"float32",{6},{0.0,1.0,3.0,0.0,1.0,3.0})
 n=n+1
end
-- case 281: uint8+uint8 dtype float32 casting=same_kind
do
 local a1=np.reshape(np.array({0,1,3},"uint8"),{3})
 local a2=np.reshape(np.array({0,1,3},"uint8"),{3})
 local got=np.concatenate({a1,a2},1,{dtype="float32",casting="same_kind"})
 check(got,"float32",{6},{0.0,1.0,3.0,0.0,1.0,3.0})
 n=n+1
end
-- case 282: uint8+uint8 dtype float32 casting=unsafe
do
 local a1=np.reshape(np.array({0,1,3},"uint8"),{3})
 local a2=np.reshape(np.array({0,1,3},"uint8"),{3})
 local got=np.concatenate({a1,a2},1,{dtype="float32",casting="unsafe"})
 check(got,"float32",{6},{0.0,1.0,3.0,0.0,1.0,3.0})
 n=n+1
end
-- case 283: uint8+uint8 out=float64 casting=same_kind
do
 local a1=np.reshape(np.array({0,1,3},"uint8"),{3})
 local a2=np.reshape(np.array({0,1,3},"uint8"),{3})
 local dst=np.zeros({6},"float64")
 local got=np.concatenate({a1,a2},1,{casting="same_kind",out=dst})
 assert(got==dst,"must return supplied out")
 check(got,"float64",{6},{0.0,1.0,3.0,0.0,1.0,3.0})
 n=n+1
end
-- case 284: uint8+uint8 out=float64 casting=unsafe
do
 local a1=np.reshape(np.array({0,1,3},"uint8"),{3})
 local a2=np.reshape(np.array({0,1,3},"uint8"),{3})
 local dst=np.zeros({6},"float64")
 local got=np.concatenate({a1,a2},1,{casting="unsafe",out=dst})
 assert(got==dst,"must return supplied out")
 check(got,"float64",{6},{0.0,1.0,3.0,0.0,1.0,3.0})
 n=n+1
end
-- case 285: uint8+uint8 out=int8 casting=same_kind
do
 local a1=np.reshape(np.array({0,1,3},"uint8"),{3})
 local a2=np.reshape(np.array({0,1,3},"uint8"),{3})
 local dst=np.zeros({6},"int8")
 local got=np.concatenate({a1,a2},1,{casting="same_kind",out=dst})
 assert(got==dst,"must return supplied out")
 check(got,"int8",{6},{0,1,3,0,1,3})
 n=n+1
end
-- case 286: uint8+uint8 out=int8 casting=unsafe
do
 local a1=np.reshape(np.array({0,1,3},"uint8"),{3})
 local a2=np.reshape(np.array({0,1,3},"uint8"),{3})
 local dst=np.zeros({6},"int8")
 local got=np.concatenate({a1,a2},1,{casting="unsafe",out=dst})
 assert(got==dst,"must return supplied out")
 check(got,"int8",{6},{0,1,3,0,1,3})
 n=n+1
end
-- case 287: int8 regular matrices concatenate 1
do
 local a1=np.reshape(np.array({1,2,3,4,5,6},"int8"),{2,3})
 local a2=np.reshape(np.array({1,2,3,4,5,6},"int8"),{2,3})
 local got=np.concatenate({a1,a2},1)
 check(got,"int8",{4,3},{{1,2,3},{4,5,6},{1,2,3},{4,5,6}})
 n=n+1
end
-- case 288: int8 regular matrices concatenate 2
do
 local a1=np.reshape(np.array({1,2,3,4,5,6},"int8"),{2,3})
 local a2=np.reshape(np.array({1,2,3,4,5,6},"int8"),{2,3})
 local got=np.concatenate({a1,a2},2)
 check(got,"int8",{2,6},{{1,2,3,1,2,3},{4,5,6,4,5,6}})
 n=n+1
end
-- case 289: int8 regular matrices stack 1
do
 local a1=np.reshape(np.array({1,2,3,4,5,6},"int8"),{2,3})
 local a2=np.reshape(np.array({1,2,3,4,5,6},"int8"),{2,3})
 local got=np.stack({a1,a2},1)
 check(got,"int8",{2,2,3},{{{1,2,3},{4,5,6}},{{1,2,3},{4,5,6}}})
 n=n+1
end
-- case 290: int8 regular matrices stack -1
do
 local a1=np.reshape(np.array({1,2,3,4,5,6},"int8"),{2,3})
 local a2=np.reshape(np.array({1,2,3,4,5,6},"int8"),{2,3})
 local got=np.stack({a1,a2},-1)
 check(got,"int8",{2,3,2},{{{1,1},{2,2},{3,3}},{{4,4},{5,5},{6,6}}})
 n=n+1
end
-- case 291: int8 transpose concatenate 1
do
 local a1=(np.reshape(np.array({1,2,3,4,5,6},"int8"),{2,3})).T
 local a2=(np.reshape(np.array({1,2,3,4,5,6},"int8"),{2,3})).T
 local got=np.concatenate({a1,a2},1)
 check(got,"int8",{6,2},{{1,4},{2,5},{3,6},{1,4},{2,5},{3,6}})
 n=n+1
end
-- case 292: int8 transpose concatenate 2
do
 local a1=(np.reshape(np.array({1,2,3,4,5,6},"int8"),{2,3})).T
 local a2=(np.reshape(np.array({1,2,3,4,5,6},"int8"),{2,3})).T
 local got=np.concatenate({a1,a2},2)
 check(got,"int8",{3,4},{{1,4,1,4},{2,5,2,5},{3,6,3,6}})
 n=n+1
end
-- case 293: int8 transpose stack 2
do
 local a1=(np.reshape(np.array({1,2,3,4,5,6},"int8"),{2,3})).T
 local a2=(np.reshape(np.array({1,2,3,4,5,6},"int8"),{2,3})).T
 local got=np.stack({a1,a2},2)
 check(got,"int8",{3,2,2},{{{1,4},{1,4}},{{2,5},{2,5}},{{3,6},{3,6}}})
 n=n+1
end
-- case 294: int8 transpose with flatten
do
 local a1=np.reshape(np.array({1,2,3,4,5,6},"int8"),{2,3})
 local a2=(np.reshape(np.array({1,2,3,4,5,6},"int8"),{2,3})).T
 local got=np.concatenate({a1,a2},false)
 check(got,"int8",{12},{1,2,3,4,5,6,1,4,2,5,3,6})
 n=n+1
end
-- case 295: int8 reverse concatenate 1
do
 local a1=(np.reshape(np.array({1,2,3,4,5,6},"int8"),{2,3})):get(np.slice(nil,nil,-1),np.slice(nil,nil,1))
 local a2=np.reshape(np.array({1,2,3,4,5,6},"int8"),{2,3})
 local got=np.concatenate({a1,a2},1)
 check(got,"int8",{4,3},{{4,5,6},{1,2,3},{1,2,3},{4,5,6}})
 n=n+1
end
-- case 296: int8 reverse concatenate 2
do
 local a1=(np.reshape(np.array({1,2,3,4,5,6},"int8"),{2,3})):get(np.slice(nil,nil,-1),np.slice(nil,nil,1))
 local a2=np.reshape(np.array({1,2,3,4,5,6},"int8"),{2,3})
 local got=np.concatenate({a1,a2},2)
 check(got,"int8",{2,6},{{4,5,6,1,2,3},{1,2,3,4,5,6}})
 n=n+1
end
-- case 297: int8 reverse stack -1
do
 local a1=(np.reshape(np.array({1,2,3,4,5,6},"int8"),{2,3})):get(np.slice(nil,nil,-1),np.slice(nil,nil,1))
 local a2=np.reshape(np.array({1,2,3,4,5,6},"int8"),{2,3})
 local got=np.stack({a1,a2},-1)
 check(got,"int8",{2,3,2},{{{4,1},{5,2},{6,3}},{{1,4},{2,5},{3,6}}})
 n=n+1
end
-- case 298: int8 empty join
do
 local a1=np.reshape(np.array({},"int8"),{0,3})
 local a2=np.reshape(np.array({1,2,3,4,5,6},"int8"),{2,3})
 local got=np.concatenate({a1,a2},1)
 check(got,"int8",{2,3},{{1,2,3},{4,5,6}})
 n=n+1
end
-- case 299: float32 regular matrices concatenate 1
do
 local a1=np.reshape(np.array({1,2,3,4,5,6},"float32"),{2,3})
 local a2=np.reshape(np.array({1,2,3,4,5,6},"float32"),{2,3})
 local got=np.concatenate({a1,a2},1)
 check(got,"float32",{4,3},{{1.0,2.0,3.0},{4.0,5.0,6.0},{1.0,2.0,3.0},{4.0,5.0,6.0}})
 n=n+1
end
-- case 300: float32 regular matrices concatenate 2
do
 local a1=np.reshape(np.array({1,2,3,4,5,6},"float32"),{2,3})
 local a2=np.reshape(np.array({1,2,3,4,5,6},"float32"),{2,3})
 local got=np.concatenate({a1,a2},2)
 check(got,"float32",{2,6},{{1.0,2.0,3.0,1.0,2.0,3.0},{4.0,5.0,6.0,4.0,5.0,6.0}})
 n=n+1
end
-- case 301: float32 regular matrices stack 1
do
 local a1=np.reshape(np.array({1,2,3,4,5,6},"float32"),{2,3})
 local a2=np.reshape(np.array({1,2,3,4,5,6},"float32"),{2,3})
 local got=np.stack({a1,a2},1)
 check(got,"float32",{2,2,3},{{{1.0,2.0,3.0},{4.0,5.0,6.0}},{{1.0,2.0,3.0},{4.0,5.0,6.0}}})
 n=n+1
end
-- case 302: float32 regular matrices stack -1
do
 local a1=np.reshape(np.array({1,2,3,4,5,6},"float32"),{2,3})
 local a2=np.reshape(np.array({1,2,3,4,5,6},"float32"),{2,3})
 local got=np.stack({a1,a2},-1)
 check(got,"float32",{2,3,2},{{{1.0,1.0},{2.0,2.0},{3.0,3.0}},{{4.0,4.0},{5.0,5.0},{6.0,6.0}}})
 n=n+1
end
-- case 303: float32 transpose concatenate 1
do
 local a1=(np.reshape(np.array({1,2,3,4,5,6},"float32"),{2,3})).T
 local a2=(np.reshape(np.array({1,2,3,4,5,6},"float32"),{2,3})).T
 local got=np.concatenate({a1,a2},1)
 check(got,"float32",{6,2},{{1.0,4.0},{2.0,5.0},{3.0,6.0},{1.0,4.0},{2.0,5.0},{3.0,6.0}})
 n=n+1
end
-- case 304: float32 transpose concatenate 2
do
 local a1=(np.reshape(np.array({1,2,3,4,5,6},"float32"),{2,3})).T
 local a2=(np.reshape(np.array({1,2,3,4,5,6},"float32"),{2,3})).T
 local got=np.concatenate({a1,a2},2)
 check(got,"float32",{3,4},{{1.0,4.0,1.0,4.0},{2.0,5.0,2.0,5.0},{3.0,6.0,3.0,6.0}})
 n=n+1
end
-- case 305: float32 transpose stack 2
do
 local a1=(np.reshape(np.array({1,2,3,4,5,6},"float32"),{2,3})).T
 local a2=(np.reshape(np.array({1,2,3,4,5,6},"float32"),{2,3})).T
 local got=np.stack({a1,a2},2)
 check(got,"float32",{3,2,2},{{{1.0,4.0},{1.0,4.0}},{{2.0,5.0},{2.0,5.0}},{{3.0,6.0},{3.0,6.0}}})
 n=n+1
end
-- case 306: float32 transpose with flatten
do
 local a1=np.reshape(np.array({1,2,3,4,5,6},"float32"),{2,3})
 local a2=(np.reshape(np.array({1,2,3,4,5,6},"float32"),{2,3})).T
 local got=np.concatenate({a1,a2},false)
 check(got,"float32",{12},{1.0,2.0,3.0,4.0,5.0,6.0,1.0,4.0,2.0,5.0,3.0,6.0})
 n=n+1
end
-- case 307: float32 reverse concatenate 1
do
 local a1=(np.reshape(np.array({1,2,3,4,5,6},"float32"),{2,3})):get(np.slice(nil,nil,-1),np.slice(nil,nil,1))
 local a2=np.reshape(np.array({1,2,3,4,5,6},"float32"),{2,3})
 local got=np.concatenate({a1,a2},1)
 check(got,"float32",{4,3},{{4.0,5.0,6.0},{1.0,2.0,3.0},{1.0,2.0,3.0},{4.0,5.0,6.0}})
 n=n+1
end
-- case 308: float32 reverse concatenate 2
do
 local a1=(np.reshape(np.array({1,2,3,4,5,6},"float32"),{2,3})):get(np.slice(nil,nil,-1),np.slice(nil,nil,1))
 local a2=np.reshape(np.array({1,2,3,4,5,6},"float32"),{2,3})
 local got=np.concatenate({a1,a2},2)
 check(got,"float32",{2,6},{{4.0,5.0,6.0,1.0,2.0,3.0},{1.0,2.0,3.0,4.0,5.0,6.0}})
 n=n+1
end
-- case 309: float32 reverse stack -1
do
 local a1=(np.reshape(np.array({1,2,3,4,5,6},"float32"),{2,3})):get(np.slice(nil,nil,-1),np.slice(nil,nil,1))
 local a2=np.reshape(np.array({1,2,3,4,5,6},"float32"),{2,3})
 local got=np.stack({a1,a2},-1)
 check(got,"float32",{2,3,2},{{{4.0,1.0},{5.0,2.0},{6.0,3.0}},{{1.0,4.0},{2.0,5.0},{3.0,6.0}}})
 n=n+1
end
-- case 310: float32 empty join
do
 local a1=np.reshape(np.array({},"float32"),{0,3})
 local a2=np.reshape(np.array({1,2,3,4,5,6},"float32"),{2,3})
 local got=np.concatenate({a1,a2},1)
 check(got,"float32",{2,3},{{1.0,2.0,3.0},{4.0,5.0,6.0}})
 n=n+1
end
-- case 311: complex128 regular matrices concatenate 1
do
 local a1=np.reshape(np.array({1,2,3,4,5,6},"complex128"),{2,3})
 local a2=np.reshape(np.array({1,2,3,4,5,6},"complex128"),{2,3})
 local got=np.concatenate({a1,a2},1)
 check(got,"complex128",{4,3},{{np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0)},{np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0)}})
 n=n+1
end
-- case 312: complex128 regular matrices concatenate 2
do
 local a1=np.reshape(np.array({1,2,3,4,5,6},"complex128"),{2,3})
 local a2=np.reshape(np.array({1,2,3,4,5,6},"complex128"),{2,3})
 local got=np.concatenate({a1,a2},2)
 check(got,"complex128",{2,6},{{np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0)}})
 n=n+1
end
-- case 313: complex128 regular matrices stack 1
do
 local a1=np.reshape(np.array({1,2,3,4,5,6},"complex128"),{2,3})
 local a2=np.reshape(np.array({1,2,3,4,5,6},"complex128"),{2,3})
 local got=np.stack({a1,a2},1)
 check(got,"complex128",{2,2,3},{{{np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0)}},{{np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0)}}})
 n=n+1
end
-- case 314: complex128 regular matrices stack -1
do
 local a1=np.reshape(np.array({1,2,3,4,5,6},"complex128"),{2,3})
 local a2=np.reshape(np.array({1,2,3,4,5,6},"complex128"),{2,3})
 local got=np.stack({a1,a2},-1)
 check(got,"complex128",{2,3,2},{{{np.complex(1.0,0.0),np.complex(1.0,0.0)},{np.complex(2.0,0.0),np.complex(2.0,0.0)},{np.complex(3.0,0.0),np.complex(3.0,0.0)}},{{np.complex(4.0,0.0),np.complex(4.0,0.0)},{np.complex(5.0,0.0),np.complex(5.0,0.0)},{np.complex(6.0,0.0),np.complex(6.0,0.0)}}})
 n=n+1
end
-- case 315: complex128 transpose concatenate 1
do
 local a1=(np.reshape(np.array({1,2,3,4,5,6},"complex128"),{2,3})).T
 local a2=(np.reshape(np.array({1,2,3,4,5,6},"complex128"),{2,3})).T
 local got=np.concatenate({a1,a2},1)
 check(got,"complex128",{6,2},{{np.complex(1.0,0.0),np.complex(4.0,0.0)},{np.complex(2.0,0.0),np.complex(5.0,0.0)},{np.complex(3.0,0.0),np.complex(6.0,0.0)},{np.complex(1.0,0.0),np.complex(4.0,0.0)},{np.complex(2.0,0.0),np.complex(5.0,0.0)},{np.complex(3.0,0.0),np.complex(6.0,0.0)}})
 n=n+1
end
-- case 316: complex128 transpose concatenate 2
do
 local a1=(np.reshape(np.array({1,2,3,4,5,6},"complex128"),{2,3})).T
 local a2=(np.reshape(np.array({1,2,3,4,5,6},"complex128"),{2,3})).T
 local got=np.concatenate({a1,a2},2)
 check(got,"complex128",{3,4},{{np.complex(1.0,0.0),np.complex(4.0,0.0),np.complex(1.0,0.0),np.complex(4.0,0.0)},{np.complex(2.0,0.0),np.complex(5.0,0.0),np.complex(2.0,0.0),np.complex(5.0,0.0)},{np.complex(3.0,0.0),np.complex(6.0,0.0),np.complex(3.0,0.0),np.complex(6.0,0.0)}})
 n=n+1
end
-- case 317: complex128 transpose stack 2
do
 local a1=(np.reshape(np.array({1,2,3,4,5,6},"complex128"),{2,3})).T
 local a2=(np.reshape(np.array({1,2,3,4,5,6},"complex128"),{2,3})).T
 local got=np.stack({a1,a2},2)
 check(got,"complex128",{3,2,2},{{{np.complex(1.0,0.0),np.complex(4.0,0.0)},{np.complex(1.0,0.0),np.complex(4.0,0.0)}},{{np.complex(2.0,0.0),np.complex(5.0,0.0)},{np.complex(2.0,0.0),np.complex(5.0,0.0)}},{{np.complex(3.0,0.0),np.complex(6.0,0.0)},{np.complex(3.0,0.0),np.complex(6.0,0.0)}}})
 n=n+1
end
-- case 318: complex128 transpose with flatten
do
 local a1=np.reshape(np.array({1,2,3,4,5,6},"complex128"),{2,3})
 local a2=(np.reshape(np.array({1,2,3,4,5,6},"complex128"),{2,3})).T
 local got=np.concatenate({a1,a2},false)
 check(got,"complex128",{12},{np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0),np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(1.0,0.0),np.complex(4.0,0.0),np.complex(2.0,0.0),np.complex(5.0,0.0),np.complex(3.0,0.0),np.complex(6.0,0.0)})
 n=n+1
end
-- case 319: complex128 reverse concatenate 1
do
 local a1=(np.reshape(np.array({1,2,3,4,5,6},"complex128"),{2,3})):get(np.slice(nil,nil,-1),np.slice(nil,nil,1))
 local a2=np.reshape(np.array({1,2,3,4,5,6},"complex128"),{2,3})
 local got=np.concatenate({a1,a2},1)
 check(got,"complex128",{4,3},{{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0)},{np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0)}})
 n=n+1
end
-- case 320: complex128 reverse concatenate 2
do
 local a1=(np.reshape(np.array({1,2,3,4,5,6},"complex128"),{2,3})):get(np.slice(nil,nil,-1),np.slice(nil,nil,1))
 local a2=np.reshape(np.array({1,2,3,4,5,6},"complex128"),{2,3})
 local got=np.concatenate({a1,a2},2)
 check(got,"complex128",{2,6},{{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0),np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0)}})
 n=n+1
end
-- case 321: complex128 reverse stack -1
do
 local a1=(np.reshape(np.array({1,2,3,4,5,6},"complex128"),{2,3})):get(np.slice(nil,nil,-1),np.slice(nil,nil,1))
 local a2=np.reshape(np.array({1,2,3,4,5,6},"complex128"),{2,3})
 local got=np.stack({a1,a2},-1)
 check(got,"complex128",{2,3,2},{{{np.complex(4.0,0.0),np.complex(1.0,0.0)},{np.complex(5.0,0.0),np.complex(2.0,0.0)},{np.complex(6.0,0.0),np.complex(3.0,0.0)}},{{np.complex(1.0,0.0),np.complex(4.0,0.0)},{np.complex(2.0,0.0),np.complex(5.0,0.0)},{np.complex(3.0,0.0),np.complex(6.0,0.0)}}})
 n=n+1
end
-- case 322: complex128 empty join
do
 local a1=np.reshape(np.array({},"complex128"),{0,3})
 local a2=np.reshape(np.array({1,2,3,4,5,6},"complex128"),{2,3})
 local got=np.concatenate({a1,a2},1)
 check(got,"complex128",{2,3},{{np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(4.0,0.0),np.complex(5.0,0.0),np.complex(6.0,0.0)}})
 n=n+1
end
-- case 323: U2 regular matrices concatenate 1
do
 local a1=np.reshape(np.array({"ab","cd","é","fg","hi","jk"},"U2"),{2,3})
 local a2=np.reshape(np.array({"ab","cd","é","fg","hi","jk"},"U2"),{2,3})
 local got=np.concatenate({a1,a2},1)
 check(got,"U2",{4,3},{{"ab","cd","é"},{"fg","hi","jk"},{"ab","cd","é"},{"fg","hi","jk"}})
 n=n+1
end
-- case 324: U2 regular matrices concatenate 2
do
 local a1=np.reshape(np.array({"ab","cd","é","fg","hi","jk"},"U2"),{2,3})
 local a2=np.reshape(np.array({"ab","cd","é","fg","hi","jk"},"U2"),{2,3})
 local got=np.concatenate({a1,a2},2)
 check(got,"U2",{2,6},{{"ab","cd","é","ab","cd","é"},{"fg","hi","jk","fg","hi","jk"}})
 n=n+1
end
-- case 325: U2 regular matrices stack 1
do
 local a1=np.reshape(np.array({"ab","cd","é","fg","hi","jk"},"U2"),{2,3})
 local a2=np.reshape(np.array({"ab","cd","é","fg","hi","jk"},"U2"),{2,3})
 local got=np.stack({a1,a2},1)
 check(got,"U2",{2,2,3},{{{"ab","cd","é"},{"fg","hi","jk"}},{{"ab","cd","é"},{"fg","hi","jk"}}})
 n=n+1
end
-- case 326: U2 regular matrices stack -1
do
 local a1=np.reshape(np.array({"ab","cd","é","fg","hi","jk"},"U2"),{2,3})
 local a2=np.reshape(np.array({"ab","cd","é","fg","hi","jk"},"U2"),{2,3})
 local got=np.stack({a1,a2},-1)
 check(got,"U2",{2,3,2},{{{"ab","ab"},{"cd","cd"},{"é","é"}},{{"fg","fg"},{"hi","hi"},{"jk","jk"}}})
 n=n+1
end
-- case 327: U2 transpose concatenate 1
do
 local a1=(np.reshape(np.array({"ab","cd","é","fg","hi","jk"},"U2"),{2,3})).T
 local a2=(np.reshape(np.array({"ab","cd","é","fg","hi","jk"},"U2"),{2,3})).T
 local got=np.concatenate({a1,a2},1)
 check(got,"U2",{6,2},{{"ab","fg"},{"cd","hi"},{"é","jk"},{"ab","fg"},{"cd","hi"},{"é","jk"}})
 n=n+1
end
-- case 328: U2 transpose concatenate 2
do
 local a1=(np.reshape(np.array({"ab","cd","é","fg","hi","jk"},"U2"),{2,3})).T
 local a2=(np.reshape(np.array({"ab","cd","é","fg","hi","jk"},"U2"),{2,3})).T
 local got=np.concatenate({a1,a2},2)
 check(got,"U2",{3,4},{{"ab","fg","ab","fg"},{"cd","hi","cd","hi"},{"é","jk","é","jk"}})
 n=n+1
end
-- case 329: U2 transpose stack 2
do
 local a1=(np.reshape(np.array({"ab","cd","é","fg","hi","jk"},"U2"),{2,3})).T
 local a2=(np.reshape(np.array({"ab","cd","é","fg","hi","jk"},"U2"),{2,3})).T
 local got=np.stack({a1,a2},2)
 check(got,"U2",{3,2,2},{{{"ab","fg"},{"ab","fg"}},{{"cd","hi"},{"cd","hi"}},{{"é","jk"},{"é","jk"}}})
 n=n+1
end
-- case 330: U2 transpose with flatten
do
 local a1=np.reshape(np.array({"ab","cd","é","fg","hi","jk"},"U2"),{2,3})
 local a2=(np.reshape(np.array({"ab","cd","é","fg","hi","jk"},"U2"),{2,3})).T
 local got=np.concatenate({a1,a2},false)
 check(got,"U2",{12},{"ab","cd","é","fg","hi","jk","ab","fg","cd","hi","é","jk"})
 n=n+1
end
-- case 331: S2 regular matrices concatenate 1
do
 local a1=np.reshape(np.array({"ab","cd","ef","gh","ij","kl"},"S2"),{2,3})
 local a2=np.reshape(np.array({"ab","cd","ef","gh","ij","kl"},"S2"),{2,3})
 local got=np.concatenate({a1,a2},1)
 check(got,"S2",{4,3},{{"ab","cd","ef"},{"gh","ij","kl"},{"ab","cd","ef"},{"gh","ij","kl"}})
 n=n+1
end
-- case 332: S2 regular matrices concatenate 2
do
 local a1=np.reshape(np.array({"ab","cd","ef","gh","ij","kl"},"S2"),{2,3})
 local a2=np.reshape(np.array({"ab","cd","ef","gh","ij","kl"},"S2"),{2,3})
 local got=np.concatenate({a1,a2},2)
 check(got,"S2",{2,6},{{"ab","cd","ef","ab","cd","ef"},{"gh","ij","kl","gh","ij","kl"}})
 n=n+1
end
-- case 333: S2 regular matrices stack 1
do
 local a1=np.reshape(np.array({"ab","cd","ef","gh","ij","kl"},"S2"),{2,3})
 local a2=np.reshape(np.array({"ab","cd","ef","gh","ij","kl"},"S2"),{2,3})
 local got=np.stack({a1,a2},1)
 check(got,"S2",{2,2,3},{{{"ab","cd","ef"},{"gh","ij","kl"}},{{"ab","cd","ef"},{"gh","ij","kl"}}})
 n=n+1
end
-- case 334: S2 regular matrices stack -1
do
 local a1=np.reshape(np.array({"ab","cd","ef","gh","ij","kl"},"S2"),{2,3})
 local a2=np.reshape(np.array({"ab","cd","ef","gh","ij","kl"},"S2"),{2,3})
 local got=np.stack({a1,a2},-1)
 check(got,"S2",{2,3,2},{{{"ab","ab"},{"cd","cd"},{"ef","ef"}},{{"gh","gh"},{"ij","ij"},{"kl","kl"}}})
 n=n+1
end
-- case 335: S2 transpose concatenate 1
do
 local a1=(np.reshape(np.array({"ab","cd","ef","gh","ij","kl"},"S2"),{2,3})).T
 local a2=(np.reshape(np.array({"ab","cd","ef","gh","ij","kl"},"S2"),{2,3})).T
 local got=np.concatenate({a1,a2},1)
 check(got,"S2",{6,2},{{"ab","gh"},{"cd","ij"},{"ef","kl"},{"ab","gh"},{"cd","ij"},{"ef","kl"}})
 n=n+1
end
-- case 336: S2 transpose concatenate 2
do
 local a1=(np.reshape(np.array({"ab","cd","ef","gh","ij","kl"},"S2"),{2,3})).T
 local a2=(np.reshape(np.array({"ab","cd","ef","gh","ij","kl"},"S2"),{2,3})).T
 local got=np.concatenate({a1,a2},2)
 check(got,"S2",{3,4},{{"ab","gh","ab","gh"},{"cd","ij","cd","ij"},{"ef","kl","ef","kl"}})
 n=n+1
end
-- case 337: S2 transpose stack 2
do
 local a1=(np.reshape(np.array({"ab","cd","ef","gh","ij","kl"},"S2"),{2,3})).T
 local a2=(np.reshape(np.array({"ab","cd","ef","gh","ij","kl"},"S2"),{2,3})).T
 local got=np.stack({a1,a2},2)
 check(got,"S2",{3,2,2},{{{"ab","gh"},{"ab","gh"}},{{"cd","ij"},{"cd","ij"}},{{"ef","kl"},{"ef","kl"}}})
 n=n+1
end
-- case 338: S2 transpose with flatten
do
 local a1=np.reshape(np.array({"ab","cd","ef","gh","ij","kl"},"S2"),{2,3})
 local a2=(np.reshape(np.array({"ab","cd","ef","gh","ij","kl"},"S2"),{2,3})).T
 local got=np.concatenate({a1,a2},false)
 check(got,"S2",{12},{"ab","cd","ef","gh","ij","kl","ab","gh","cd","ij","ef","kl"})
 n=n+1
end
-- case 339: S1 + S4 concatenate
do
 local a1=np.reshape(np.array({"a","b"},"S1"),{2})
 local a2=np.reshape(np.array({"test","zoo"},"S4"),{2})
 local got=np.concatenate({a1,a2},1)
 check(got,"S4",{4},{"a","b","test","zoo"})
 n=n+1
end
-- case 340: S1 + S4 stack
do
 local a1=np.reshape(np.array({"a","b"},"S1"),{2})
 local a2=np.reshape(np.array({"test","zoo"},"S4"),{2})
 local got=np.stack({a1,a2},1)
 check(got,"S4",{2,2},{{"a","b"},{"test","zoo"}})
 n=n+1
end
-- case 341: U1 + U4 concatenate
do
 local a1=np.reshape(np.array({"α","β"},"U1"),{2})
 local a2=np.reshape(np.array({"東京","аб"},"U4"),{2})
 local got=np.concatenate({a1,a2},1)
 check(got,"U4",{4},{"α","β","東京","аб"})
 n=n+1
end
-- case 342: U1 + U4 stack
do
 local a1=np.reshape(np.array({"α","β"},"U1"),{2})
 local a2=np.reshape(np.array({"東京","аб"},"U4"),{2})
 local got=np.stack({a1,a2},1)
 check(got,"U4",{2,2},{{"α","β"},{"東京","аб"}})
 n=n+1
end
-- case 343: S2 + U3 concatenate
do
 local a1=np.reshape(np.array({"ab","cd"},"S2"),{2})
 local a2=np.reshape(np.array({"猫","わ"},"U3"),{2})
 local got=np.concatenate({a1,a2},1)
 check(got,"U3",{4},{"ab","cd","猫","わ"})
 n=n+1
end
-- case 344: S2 + U3 stack
do
 local a1=np.reshape(np.array({"ab","cd"},"S2"),{2})
 local a2=np.reshape(np.array({"猫","わ"},"U3"),{2})
 local got=np.stack({a1,a2},1)
 check(got,"U3",{2,2},{{"ab","cd"},{"猫","わ"}})
 n=n+1
end
-- case 345: scalar stack int8
do
 local a1=np.reshape(np.array({9},"int8"),{})
 local a2=np.reshape(np.array({5},"int8"),{})
 local got=np.stack({a1,a2},1)
 check(got,"int8",{2},{9,5})
 n=n+1
end
-- case 346: scalar concat none int8
do
 local a1=np.reshape(np.array({9},"int8"),{})
 local a2=np.reshape(np.array({5},"int8"),{})
 local got=np.concatenate({a1,a2},false)
 check(got,"int8",{2},{9,5})
 n=n+1
end
-- case 347: scalar concat axis rejected int8
do
 local a1=np.reshape(np.array({9},"int8"),{})
 local a2=np.reshape(np.array({5},"int8"),{})
 local ok=pcall(function()return np.concatenate({a1,a2},1) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 348: scalar stack float64
do
 local a1=np.reshape(np.array({9},"float64"),{})
 local a2=np.reshape(np.array({5},"float64"),{})
 local got=np.stack({a1,a2},1)
 check(got,"float64",{2},{9.0,5.0})
 n=n+1
end
-- case 349: scalar concat none float64
do
 local a1=np.reshape(np.array({9},"float64"),{})
 local a2=np.reshape(np.array({5},"float64"),{})
 local got=np.concatenate({a1,a2},false)
 check(got,"float64",{2},{9.0,5.0})
 n=n+1
end
-- case 350: scalar concat axis rejected float64
do
 local a1=np.reshape(np.array({9},"float64"),{})
 local a2=np.reshape(np.array({5},"float64"),{})
 local ok=pcall(function()return np.concatenate({a1,a2},1) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 351: shape error
do
 local a1=np.reshape(np.array({0,1,2,3,4,5},"int32"),{2,3})
 local a2=np.reshape(np.array({0,1,2,3,4,5,6,7},"int32"),{4,2})
 local ok=pcall(function()return np.concatenate({a1,a2},1) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 352: shape error
do
 local a1=np.reshape(np.array({0,1,2,3,4,5},"int32"),{2,3})
 local a2=np.reshape(np.array({0,1,2,3,4,5,6,7,8},"int32"),{3,3})
 local ok=pcall(function()return np.concatenate({a1,a2},2) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 353: shape error
do
 local a1=np.reshape(np.array({0,1,2,3,4,5},"int32"),{2,3})
 local a2=np.reshape(np.array({0,1,2,3,4,5,6,7,8},"int32"),{3,3})
 local ok=pcall(function()return np.stack({a1,a2},1) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 354: shape error
do
 local a1=np.reshape(np.array({0,1,2,3,4,5},"int32"),{2,3})
 local a2=np.reshape(np.array({0,1,2},"int32"),{3})
 local ok=pcall(function()return np.stack({a1,a2},1) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
-- case 355: shape error
do
 local a1=np.reshape(np.array({0,1,2,3,4,5},"int32"),{2,3})
 local a2=np.reshape(np.array({0,1,2},"int32"),{3})
 local ok=pcall(function()return np.concatenate({a1,a2},1) end)
 assert(not ok,"expected oracle rejection")
 n=n+1
end
print(('join differential: %d/%d'):format(n,n))
