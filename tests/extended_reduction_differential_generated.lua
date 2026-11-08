local np=require("luaray_core")
local function close(a,b)
  if type(a)~=type(b) then return false end
  if type(a)~="table" then
    if type(a)=="number" then
      if a~=a and b~=b then return true end
      if a==b then return true end
      return math.abs(a-b)<=math.max(2e-5,math.abs(b)*8e-6)
    end
    return a==b
  end
  if #a~=#b then return false end
  for i=1,#a do if not close(a[i],b[i]) then return false end end
  return true
end
-- Generated against development NumPy 2.3.5.
do -- extended reduction 0: sum uint8 shape=[4, 1, 4, 0] axis=3
  local a=np.zeros({4,1,4,0},np.uint8)
  local r=np.sum(a,{axis=4,keepdims=true,where=false})
  assert(r.dtype=="uint64","ext reduction 0 dtype "..r.dtype)
  assert(close(r.shape,{4,1,4,1}),"ext reduction 0 shape")
  assert(close(r.strides,{32,32,8,8}),"ext reduction 0 strides")
  assert(close(r:tolist(),{{{{0},{0},{0},{0}}},{{{0},{0},{0},{0}}},{{{0},{0},{0},{0}}},{{{0},{0},{0},{0}}}}),"ext reduction 0 values")
end
do -- extended reduction 1: mean uint8 shape=[3] axis=0
  local a=np.array({1,4,0},np.uint8)
  local r=np.mean(a,{axis=1,keepdims=true,where=np.array({true,true,false},np.bool)})
  assert(r.dtype=="float64","ext reduction 1 dtype "..r.dtype)
  assert(close(r.shape,{1}),"ext reduction 1 shape")
  assert(close(r.strides,{8}),"ext reduction 1 strides")
  assert(close(r:tolist(),{2.5}),"ext reduction 1 values")
end
do -- extended reduction 2: prod float16 shape=[1, 4, 4] axis=(0, 1, 2)
  local a=np.array({{{-1.25,-0.75,-0.25,0.25},{0.75,1.25,1.75,-1.25},{-0.75,-0.25,0.25,0.75},{1.25,1.75,-1.25,-0.75}}},np.float16)
  local r=np.prod(a,{axis={1,2,3},keepdims=true,where=true})
  assert(r.dtype=="float16","ext reduction 2 dtype "..r.dtype)
  assert(close(r.shape,{1,1,1}),"ext reduction 2 shape")
  assert(close(r.strides,{2,2,2}),"ext reduction 2 strides")
  assert(close(r:tolist(),{{{0.0086669921875}}}),"ext reduction 2 values")
end
do -- extended reduction 3: prod int16 shape=[4, 4, 1, 0] axis=None
  local a=np.zeros({4,4,1,0},np.int16)
  local r=np.prod(a,{axis=nil,keepdims=false,where=np.zeros({1,1,1,0},np.bool),dtype=np.int32})
  assert(close(r,1),"ext reduction 3 scalar")
end
do -- extended reduction 4: sum float64 shape=[4, 2, 2] axis=-1
  local a=np.array({{{-1.375,-0.875},{-0.375,0.125}},{{0.625,1.125},{1.625,-1.375}},{{-0.875,-0.375},{0.125,0.625}},{{1.125,1.625},{-1.375,-0.875}}},np.float64)
  local r=np.sum(a,{axis=-1,keepdims=true,where=np.array({true,true},np.bool)})
  assert(r.dtype=="float64","ext reduction 4 dtype "..r.dtype)
  assert(close(r.shape,{4,2,1}),"ext reduction 4 shape")
  assert(close(r.strides,{16,8,8}),"ext reduction 4 strides")
  assert(close(r:tolist(),{{{-2.25},{-0.25}},{{1.75},{0.25}},{{-1.25},{0.75}},{{2.75},{-2.25}}}),"ext reduction 4 values")
end
do -- extended reduction 5: prod int32 shape=[1, 1] axis=()
  local a=np.array({{0}},np.int32)
  local r=np.prod(a,{axis={},keepdims=true,where=np.array({{true}},np.bool),dtype=np.uint16,initial=2})
  assert(r.dtype=="uint16","ext reduction 5 dtype "..r.dtype)
  assert(close(r.shape,{1,1}),"ext reduction 5 shape")
  assert(close(r.strides,{2,2}),"ext reduction 5 strides")
  assert(close(r:tolist(),{{0}}),"ext reduction 5 values")
end
do -- extended reduction 6: prod float32 shape=[2] axis=0
  local a=np.array({-1.5,-1.0},np.float32)
  local r=np.prod(a,{axis=1,keepdims=true,where=np.array({false,true},np.bool)})
  assert(r.dtype=="float32","ext reduction 6 dtype "..r.dtype)
  assert(close(r.shape,{1}),"ext reduction 6 shape")
  assert(close(r.strides,{4}),"ext reduction 6 strides")
  assert(close(r:tolist(),{-1.0}),"ext reduction 6 values")
end
do -- extended reduction 7: prod float64 shape=[0, 2] axis=None
  local a=np.zeros({0,2},np.float64)
  local r=np.prod(a,{axis=nil,keepdims=false,where=true,dtype=np.uint32})
  assert(close(r,1),"ext reduction 7 scalar")
end
do -- extended reduction 8: prod float64 shape=[3, 4, 3] axis=(-3, 1)
  local a=np.array({{{-1.25,-0.75,-0.25},{0.25,0.75,1.25},{1.75,-1.25,-0.75},{-0.25,0.25,0.75}},{{1.25,1.75,-1.25},{-0.75,-0.25,0.25},{0.75,1.25,1.75},{-1.25,-0.75,-0.25}},{{0.25,0.75,1.25},{1.75,-1.25,-0.75},{-0.25,0.25,0.75},{1.25,1.75,-1.25}}},np.float64)
  local r=np.prod(a,{axis={-3,2},keepdims=false,where=np.array({{{true,false,true}}},np.bool),dtype=np.bool,initial=0})
  assert(r.dtype=="bool","ext reduction 8 dtype "..r.dtype)
  assert(close(r.shape,{3}),"ext reduction 8 shape")
  assert(close(r.strides,{1}),"ext reduction 8 strides")
  assert(close(r:tolist(),{false,false,false}),"ext reduction 8 values")
end
do -- extended reduction 9: prod float64 shape=[0, 3, 0] axis=0
  local a=np.zeros({0,3,0},np.float64)
  local r=np.prod(a,{axis=1,keepdims=false,where=np.zeros({1,1,0},np.bool),dtype=np.uint32})
  assert(r.dtype=="uint32","ext reduction 9 dtype "..r.dtype)
  assert(close(r.shape,{3,0}),"ext reduction 9 shape")
  assert(close(r.strides,{0,0}),"ext reduction 9 strides")
  assert(close(r:tolist(),{{},{},{}}),"ext reduction 9 values")
end
do -- extended reduction 10: prod int32 shape=[3, 3, 0, 3] axis=1
  local a=np.zeros({3,3,0,3},np.int32)
  local o=np.zeros({3,1,0,3},np.float16)
  local r=np.prod(a,{axis=2,keepdims=true,where=np.array({{{{true,true,false}}}},np.bool),initial=-2,out=o})
  assert(r==o,"ext reduction 10 out identity")
  assert(r.dtype=="float16","ext reduction 10 out dtype "..r.dtype)
  assert(close(r:tolist(),{{{}},{{}},{{}}}),"ext reduction 10 out values")
end
do -- extended reduction 11: mean uint8 shape=[4, 4] axis=(0, 1)
  local a=np.array({{4,0,3,6},{2,5,1,4},{0,3,6,2},{5,1,4,0}},np.uint8)
  local r=np.mean(a,{axis={1,2},keepdims=true,where=false})
  assert(r.dtype=="float64","ext reduction 11 dtype "..r.dtype)
  assert(close(r.shape,{1,1}),"ext reduction 11 shape")
  assert(close(r.strides,{8,8}),"ext reduction 11 strides")
  assert(close(r:tolist(),{{0/0}}),"ext reduction 11 values")
end
do -- extended reduction 12: mean float64 shape=[3, 2] axis=None
  local a=np.array({{-1.5,-1.0},{-0.5,0.0},{0.5,1.0}},np.float64)
  local o=np.zeros({1,1},np.float32)
  local r=np.mean(a,{axis=nil,keepdims=true,where=np.array({{false,true},{true,false},{true,true}},np.bool),dtype=np.float32,out=o})
  assert(r==o,"ext reduction 12 out identity")
  assert(r.dtype=="float32","ext reduction 12 out dtype "..r.dtype)
  assert(close(r:tolist(),{{0.0}}),"ext reduction 12 out values")
end
do -- extended reduction 13: mean int32 shape=[4] axis=0
  local a=np.array({-3,2,-4,1},np.int32)
  local o=np.zeros({},np.int32)
  local r=np.mean(a,{axis=1,keepdims=false,where=true,out=o})
  assert(r==o,"ext reduction 13 out identity")
  assert(r.dtype=="int32","ext reduction 13 out dtype "..r.dtype)
  assert(close(r:tolist(),-1),"ext reduction 13 out values")
end
do -- extended reduction 14: prod int64 shape=[4] axis=None
  local a=np.array({-2,3,-3,2},np.int64)
  local r=np.prod(a,{axis=nil,keepdims=false,where=np.array({true,false,true,true},np.bool)})
  assert(close(r,12),"ext reduction 14 scalar")
end
do -- extended reduction 15: sum float16 shape=[0] axis=None
  local a=np.zeros({0},np.float16)
  local r=np.sum(a,{axis=nil,keepdims=true,where=false,initial=0})
  assert(r.dtype=="float16","ext reduction 15 dtype "..r.dtype)
  assert(close(r.shape,{1}),"ext reduction 15 shape")
  assert(close(r.strides,{2}),"ext reduction 15 strides")
  assert(close(r:tolist(),{0.0}),"ext reduction 15 values")
end
do -- extended reduction 16: prod float32 shape=[0, 4] axis=-1
  local a=np.zeros({0,4},np.float32)
  local r=np.prod(a,{axis=-1,keepdims=false,where=false})
  assert(r.dtype=="float32","ext reduction 16 dtype "..r.dtype)
  assert(close(r.shape,{0}),"ext reduction 16 shape")
  assert(close(r.strides,{0}),"ext reduction 16 strides")
  assert(close(r:tolist(),{}),"ext reduction 16 values")
end
do -- extended reduction 17: sum int64 shape=[0, 2, 4] axis=0
  local a=np.zeros({0,2,4},np.int64)
  local r=np.sum(a,{axis=1,keepdims=false,where=np.array({true,false,true,true},np.bool),initial=-2})
  assert(r.dtype=="int64","ext reduction 17 dtype "..r.dtype)
  assert(close(r.shape,{2,4}),"ext reduction 17 shape")
  assert(close(r.strides,{32,8}),"ext reduction 17 strides")
  assert(close(r:tolist(),{{-2,-2,-2,-2},{-2,-2,-2,-2}}),"ext reduction 17 values")
end
do -- extended reduction 18: prod uint8 shape=[1, 1, 4] axis=(0,)
  local a=np.array({{{4,0,3,6}}},np.uint8)
  local r=np.prod(a,{axis={1},keepdims=false,where=np.array({false,true,true,false},np.bool)})
  assert(r.dtype=="uint64","ext reduction 18 dtype "..r.dtype)
  assert(close(r.shape,{1,4}),"ext reduction 18 shape")
  assert(close(r.strides,{32,8}),"ext reduction 18 strides")
  assert(close(r:tolist(),{{1,0,3,1}}),"ext reduction 18 values")
end
do -- extended reduction 19: sum float64 shape=[2, 3, 4, 0] axis=()
  local a=np.zeros({2,3,4,0},np.float64)
  local r=np.sum(a,{axis={},keepdims=true,where=false})
  assert(r.dtype=="float64","ext reduction 19 dtype "..r.dtype)
  assert(close(r.shape,{2,3,4,0}),"ext reduction 19 shape")
  assert(close(r.strides,{0,0,0,0}),"ext reduction 19 strides")
  assert(close(r:tolist(),{{{{},{},{},{}},{{},{},{},{}},{{},{},{},{}}},{{{},{},{},{}},{{},{},{},{}},{{},{},{},{}}}}),"ext reduction 19 values")
end
do -- extended reduction 20: prod uint16 shape=[0, 4] axis=(0,)
  local a=np.zeros({0,4},np.uint16)
  local r=np.prod(a,{axis={1},keepdims=false,where=false})
  assert(r.dtype=="uint64","ext reduction 20 dtype "..r.dtype)
  assert(close(r.shape,{4}),"ext reduction 20 shape")
  assert(close(r.strides,{8}),"ext reduction 20 strides")
  assert(close(r:tolist(),{1,1,1,1}),"ext reduction 20 values")
end
do -- extended reduction 21: prod uint64 shape=[4] axis=0
  local a=np.array({0,3,6,2},np.uint64)
  local r=np.prod(a,{axis=1,keepdims=true,where=np.array({false,true,true,false},np.bool)})
  assert(r.dtype=="uint64","ext reduction 21 dtype "..r.dtype)
  assert(close(r.shape,{1}),"ext reduction 21 shape")
  assert(close(r.strides,{8}),"ext reduction 21 strides")
  assert(close(r:tolist(),{18}),"ext reduction 21 values")
end
do -- extended reduction 22: prod float32 shape=[2, 2] axis=0
  local a=np.array({{-1.375,-0.875},{-0.375,0.125}},np.float32)
  local r=np.prod(a,{axis=1,keepdims=true,where=np.array({{true,true},{false,true}},np.bool),dtype=np.float64})
  assert(r.dtype=="float64","ext reduction 22 dtype "..r.dtype)
  assert(close(r.shape,{1,2}),"ext reduction 22 shape")
  assert(close(r.strides,{16,8}),"ext reduction 22 strides")
  assert(close(r:tolist(),{{-1.375,-0.109375}}),"ext reduction 22 values")
end
do -- extended reduction 23: prod float64 shape=[1] axis=()
  local a=np.array({-1.25},np.float64)
  local r=np.prod(a,{axis={},keepdims=false,where=np.array({true},np.bool),dtype=np.float64})
  assert(r.dtype=="float64","ext reduction 23 dtype "..r.dtype)
  assert(close(r.shape,{1}),"ext reduction 23 shape")
  assert(close(r.strides,{8}),"ext reduction 23 strides")
  assert(close(r:tolist(),{-1.25}),"ext reduction 23 values")
end
do -- extended reduction 24: mean uint64 shape=[3, 1, 1, 0] axis=None
  local a=np.zeros({3,1,1,0},np.uint64)
  local o=np.zeros({1,1,1,1},np.float64)
  local r=np.mean(a,{axis=nil,keepdims=true,where=np.zeros({0},np.bool),out=o})
  assert(r==o,"ext reduction 24 out identity")
  assert(r.dtype=="float64","ext reduction 24 out dtype "..r.dtype)
  assert(close(r:tolist(),{{{{0/0}}}}),"ext reduction 24 out values")
end
do -- extended reduction 25: mean int16 shape=[1, 1, 4, 1] axis=None
  local a=np.array({{{{-2},{3},{-3},{2}}}},np.int16)
  local r=np.mean(a,{axis=nil,keepdims=true,where=true,dtype=np.uint32})
  assert(r.dtype=="uint32","ext reduction 25 dtype "..r.dtype)
  assert(close(r.shape,{1,1,1,1}),"ext reduction 25 shape")
  assert(close(r.strides,{4,4,4,4}),"ext reduction 25 strides")
  assert(close(r:tolist(),{{{{0}}}}),"ext reduction 25 values")
end
do -- extended reduction 26: sum float64 shape=[3, 4, 4, 3] axis=None
  local a=np.array({{{{-1.25,-0.75,-0.25},{0.25,0.75,1.25},{1.75,-1.25,-0.75},{-0.25,0.25,0.75}},{{1.25,1.75,-1.25},{-0.75,-0.25,0.25},{0.75,1.25,1.75},{-1.25,-0.75,-0.25}},{{0.25,0.75,1.25},{1.75,-1.25,-0.75},{-0.25,0.25,0.75},{1.25,1.75,-1.25}},{{-0.75,-0.25,0.25},{0.75,1.25,1.75},{-1.25,-0.75,-0.25},{0.25,0.75,1.25}}},{{{1.75,-1.25,-0.75},{-0.25,0.25,0.75},{1.25,1.75,-1.25},{-0.75,-0.25,0.25}},{{0.75,1.25,1.75},{-1.25,-0.75,-0.25},{0.25,0.75,1.25},{1.75,-1.25,-0.75}},{{-0.25,0.25,0.75},{1.25,1.75,-1.25},{-0.75,-0.25,0.25},{0.75,1.25,1.75}},{{-1.25,-0.75,-0.25},{0.25,0.75,1.25},{1.75,-1.25,-0.75},{-0.25,0.25,0.75}}},{{{1.25,1.75,-1.25},{-0.75,-0.25,0.25},{0.75,1.25,1.75},{-1.25,-0.75,-0.25}},{{0.25,0.75,1.25},{1.75,-1.25,-0.75},{-0.25,0.25,0.75},{1.25,1.75,-1.25}},{{-0.75,-0.25,0.25},{0.75,1.25,1.75},{-1.25,-0.75,-0.25},{0.25,0.75,1.25}},{{1.75,-1.25,-0.75},{-0.25,0.25,0.75},{1.25,1.75,-1.25},{-0.75,-0.25,0.25}}}},np.float64)
  local r=np.sum(a,{axis=nil,keepdims=true,where=np.array({true,false,true},np.bool)})
  assert(r.dtype=="float64","ext reduction 26 dtype "..r.dtype)
  assert(close(r.shape,{1,1,1,1}),"ext reduction 26 shape")
  assert(close(r.strides,{8,8,8,8}),"ext reduction 26 strides")
  assert(close(r:tolist(),{{{{22.0}}}}),"ext reduction 26 values")
end
do -- extended reduction 27: sum uint8 shape=[0, 1] axis=None
  local a=np.zeros({0,1},np.uint8)
  local r=np.sum(a,{axis=nil,keepdims=true,where=true,dtype=np.float16,initial=1})
  assert(r.dtype=="float16","ext reduction 27 dtype "..r.dtype)
  assert(close(r.shape,{1,1}),"ext reduction 27 shape")
  assert(close(r.strides,{2,2}),"ext reduction 27 strides")
  assert(close(r:tolist(),{{1.0}}),"ext reduction 27 values")
end
do -- extended reduction 28: sum int16 shape=[3, 2, 1, 1] axis=-2
  local a=np.array({{{{1}},{{-5}}},{{{0}},{{5}}},{{{-1}},{{4}}}},np.int16)
  local r=np.sum(a,{axis=-2,keepdims=false,where=np.array({true},np.bool),dtype=np.int32})
  assert(r.dtype=="int32","ext reduction 28 dtype "..r.dtype)
  assert(close(r.shape,{3,2,1}),"ext reduction 28 shape")
  assert(close(r.strides,{8,4,4}),"ext reduction 28 strides")
  assert(close(r:tolist(),{{{1},{-5}},{{0},{5}},{{-1},{4}}}),"ext reduction 28 values")
end
do -- extended reduction 29: prod bool shape=[4, 4] axis=()
  local a=np.array({{true,true,false,true},{true,true,true,false},{true,true,true,true},{false,true,true,true}},np.bool)
  local r=np.prod(a,{axis={},keepdims=true,where=np.array({true,false,true,true},np.bool)})
  assert(r.dtype=="int64","ext reduction 29 dtype "..r.dtype)
  assert(close(r.shape,{4,4}),"ext reduction 29 shape")
  assert(close(r.strides,{32,8}),"ext reduction 29 strides")
  assert(close(r:tolist(),{{1,1,0,1},{1,1,1,0},{1,1,1,1},{0,1,1,1}}),"ext reduction 29 values")
end
do -- extended reduction 30: mean uint16 shape=[4, 1, 1, 3] axis=2
  local a=np.array({{{{2,5,1}}},{{{4,0,3}}},{{{6,2,5}}},{{{1,4,0}}}},np.uint16)
  local r=np.mean(a,{axis=3,keepdims=true,where=false,dtype=np.float32})
  assert(r.dtype=="float32","ext reduction 30 dtype "..r.dtype)
  assert(close(r.shape,{4,1,1,3}),"ext reduction 30 shape")
  assert(close(r.strides,{12,12,12,4}),"ext reduction 30 strides")
  assert(close(r:tolist(),{{{{0/0,0/0,0/0}}},{{{0/0,0/0,0/0}}},{{{0/0,0/0,0/0}}},{{{0/0,0/0,0/0}}}}),"ext reduction 30 values")
end
do -- extended reduction 31: prod float32 shape=[3] axis=()
  local a=np.array({-1.375,-0.875,-0.375},np.float32)
  local r=np.prod(a,{axis={},keepdims=false,where=false})
  assert(r.dtype=="float32","ext reduction 31 dtype "..r.dtype)
  assert(close(r.shape,{3}),"ext reduction 31 shape")
  assert(close(r.strides,{4}),"ext reduction 31 strides")
  assert(close(r:tolist(),{1.0,1.0,1.0}),"ext reduction 31 values")
end
do -- extended reduction 32: mean int16 shape=[0, 1, 3, 0] axis=-1
  local a=np.zeros({0,1,3,0},np.int16)
  local r=np.mean(a,{axis=-1,keepdims=false,where=true,dtype=np.float32})
  assert(r.dtype=="float32","ext reduction 32 dtype "..r.dtype)
  assert(close(r.shape,{0,1,3}),"ext reduction 32 shape")
  assert(close(r.strides,{0,0,0}),"ext reduction 32 strides")
  assert(close(r:tolist(),{}),"ext reduction 32 values")
end
do -- extended reduction 33: sum uint64 shape=[4, 4, 1, 0] axis=None
  local a=np.zeros({4,4,1,0},np.uint64)
  local r=np.sum(a,{axis=nil,keepdims=false,where=true,dtype=np.uint8})
  assert(close(r,0),"ext reduction 33 scalar")
end
do -- extended reduction 34: mean uint8 shape=[3] axis=(0,)
  local a=np.array({6,2,5},np.uint8)
  local r=np.mean(a,{axis={1},keepdims=true,where=false})
  assert(r.dtype=="float64","ext reduction 34 dtype "..r.dtype)
  assert(close(r.shape,{1}),"ext reduction 34 shape")
  assert(close(r.strides,{8}),"ext reduction 34 strides")
  assert(close(r:tolist(),{0/0}),"ext reduction 34 values")
end
do -- extended reduction 35: sum uint8 shape=[0, 0] axis=1
  local a=np.zeros({0,0},np.uint8)
  local o=np.zeros({0},np.float64)
  local r=np.sum(a,{axis=2,keepdims=false,where=np.zeros({0},np.bool),initial=3,out=o})
  assert(r==o,"ext reduction 35 out identity")
  assert(r.dtype=="float64","ext reduction 35 out dtype "..r.dtype)
  assert(close(r:tolist(),{}),"ext reduction 35 out values")
end
do -- extended reduction 36: sum float16 shape=[2, 2] axis=0
  local a=(np.array({{-1.5,-1.0},{-0.5,0.0}},np.float16)).T
  local r=np.sum(a,{axis=1,keepdims=false,where=false})
  assert(r.dtype=="float16","ext reduction 36 dtype "..r.dtype)
  assert(close(r.shape,{2}),"ext reduction 36 shape")
  assert(close(r.strides,{2}),"ext reduction 36 strides")
  assert(close(r:tolist(),{0.0,0.0}),"ext reduction 36 values")
end
do -- extended reduction 37: sum float64 shape=[0, 3] axis=(1,)
  local a=np.zeros({0,3},np.float64)
  local r=np.sum(a,{axis={2},keepdims=false,where=false})
  assert(r.dtype=="float64","ext reduction 37 dtype "..r.dtype)
  assert(close(r.shape,{0}),"ext reduction 37 shape")
  assert(close(r.strides,{0}),"ext reduction 37 strides")
  assert(close(r:tolist(),{}),"ext reduction 37 values")
end
do -- extended reduction 38: prod int8 shape=[2, 2, 3] axis=-1
  local a=(np.array({{{0,5},{-1,4}},{{-2,3},{-3,2}},{{-4,1},{-5,0}}},np.int8)).T
  local r=np.prod(a,{axis=-1,keepdims=true,where=true})
  assert(r.dtype=="int64","ext reduction 38 dtype "..r.dtype)
  assert(close(r.shape,{2,2,1}),"ext reduction 38 shape")
  assert(close(r.strides,{8,16,32}),"ext reduction 38 strides")
  assert(close(r:tolist(),{{{0},{-15}},{{15},{0}}}),"ext reduction 38 values")
end
do -- extended reduction 39: prod uint64 shape=[4] axis=0
  local a=np.array({4,0,3,6},np.uint64)
  local r=np.prod(a,{axis=1,keepdims=false,where=np.array({false,true,true,false},np.bool),initial=3})
  assert(close(r,0),"ext reduction 39 scalar")
end
do -- extended reduction 40: mean bool shape=[0, 4] axis=None
  local a=np.zeros({0,4},np.bool)
  local r=np.mean(a,{axis=nil,keepdims=true,where=true})
  assert(r.dtype=="float64","ext reduction 40 dtype "..r.dtype)
  assert(close(r.shape,{1,1}),"ext reduction 40 shape")
  assert(close(r.strides,{8,8}),"ext reduction 40 strides")
  assert(close(r:tolist(),{{0/0}}),"ext reduction 40 values")
end
do -- extended reduction 41: mean uint16 shape=[2, 0, 4] axis=0
  local a=np.zeros({2,0,4},np.uint16)
  local r=np.mean(a,{axis=1,keepdims=true,where=np.array({{{true,false,true,true}}},np.bool)})
  assert(r.dtype=="float64","ext reduction 41 dtype "..r.dtype)
  assert(close(r.shape,{1,0,4}),"ext reduction 41 shape")
  assert(close(r.strides,{0,0,0}),"ext reduction 41 strides")
  assert(close(r:tolist(),{{}}),"ext reduction 41 values")
end
do -- extended reduction 42: sum uint64 shape=[3, 0] axis=()
  local a=np.zeros({3,0},np.uint64)
  local o=np.zeros({3,0},np.float16)
  local r=np.sum(a,{axis={},keepdims=true,where=np.zeros({0},np.bool),out=o})
  assert(r==o,"ext reduction 42 out identity")
  assert(r.dtype=="float16","ext reduction 42 out dtype "..r.dtype)
  assert(close(r:tolist(),{{},{},{}}),"ext reduction 42 out values")
end
do -- extended reduction 43: prod uint16 shape=[0] axis=()
  local a=np.zeros({0},np.uint16)
  local r=np.prod(a,{axis={},keepdims=true,where=np.zeros({0},np.bool),initial=1})
  assert(r.dtype=="uint64","ext reduction 43 dtype "..r.dtype)
  assert(close(r.shape,{0}),"ext reduction 43 shape")
  assert(close(r.strides,{0}),"ext reduction 43 strides")
  assert(close(r:tolist(),{}),"ext reduction 43 values")
end
do -- extended reduction 44: mean uint32 shape=[4] axis=(0,)
  local a=np.array({2,5,1,4},np.uint32)
  local o=np.zeros({1},np.float64)
  local r=np.mean(a,{axis={1},keepdims=true,where=np.array({true,false,true,true},np.bool),out=o})
  assert(r==o,"ext reduction 44 out identity")
  assert(r.dtype=="float64","ext reduction 44 out dtype "..r.dtype)
  assert(close(r:tolist(),{2.3333333333333335}),"ext reduction 44 out values")
end
do -- extended reduction 45: sum float32 shape=[4, 0, 4] axis=0
  local a=np.zeros({4,0,4},np.float32)
  local r=np.sum(a,{axis=1,keepdims=false,where=true,dtype=np.uint16})
  assert(r.dtype=="uint16","ext reduction 45 dtype "..r.dtype)
  assert(close(r.shape,{0,4}),"ext reduction 45 shape")
  assert(close(r.strides,{0,0}),"ext reduction 45 strides")
  assert(close(r:tolist(),{}),"ext reduction 45 values")
end
do -- extended reduction 46: mean int16 shape=[3, 3] axis=None
  local a=np.array({{-3,2,-4},{1,-5,0},{5,-1,4}},np.int16)
  local r=np.mean(a,{axis=nil,keepdims=true,where=false,dtype=np.float64})
  assert(r.dtype=="float64","ext reduction 46 dtype "..r.dtype)
  assert(close(r.shape,{1,1}),"ext reduction 46 shape")
  assert(close(r.strides,{8,8}),"ext reduction 46 strides")
  assert(close(r:tolist(),{{0/0}}),"ext reduction 46 values")
end
do -- extended reduction 47: mean uint8 shape=[4, 4] axis=(-2,)
  local a=(np.array({{5,1,4,0},{3,6,2,5},{1,4,0,3},{6,2,5,1}},np.uint8)).T
  local r=np.mean(a,{axis={-2},keepdims=true,where=np.array({true,false,true,true},np.bool),dtype=np.float64})
  assert(r.dtype=="float64","ext reduction 47 dtype "..r.dtype)
  assert(close(r.shape,{1,4}),"ext reduction 47 shape")
  assert(close(r.strides,{8,8}),"ext reduction 47 strides")
  assert(close(r:tolist(),{{2.5,0/0,2.0,3.5}}),"ext reduction 47 values")
end
do -- extended reduction 48: sum float32 shape=[4, 2, 2, 1] axis=-1
  local a=np.array({{{{-1.5},{-1.0}},{{-0.5},{0.0}}},{{{0.5},{1.0}},{{1.5},{-1.5}}},{{{-1.0},{-0.5}},{{0.0},{0.5}}},{{{1.0},{1.5}},{{-1.5},{-1.0}}}},np.float32)
  local r=np.sum(a,{axis=-1,keepdims=false,where=np.array({{{{false}}}},np.bool),dtype=np.uint8})
  assert(r.dtype=="uint8","ext reduction 48 dtype "..r.dtype)
  assert(close(r.shape,{4,2,2}),"ext reduction 48 shape")
  assert(close(r.strides,{4,2,1}),"ext reduction 48 strides")
  assert(close(r:tolist(),{{{0,0},{0,0}},{{0,0},{0,0}},{{0,0},{0,0}},{{0,0},{0,0}}}),"ext reduction 48 values")
end
do -- extended reduction 49: sum float32 shape=[1] axis=None
  local a=np.array({-1.375},np.float32)
  local o=np.zeros({},np.float16)
  local r=np.sum(a,{axis=nil,keepdims=false,where=false,initial=3,out=o})
  assert(r==o,"ext reduction 49 out identity")
  assert(r.dtype=="float16","ext reduction 49 out dtype "..r.dtype)
  assert(close(r:tolist(),3.0),"ext reduction 49 out values")
end
do -- extended reduction 50: mean uint32 shape=[0, 1, 1] axis=-2
  local a=np.zeros({0,1,1},np.uint32)
  local r=np.mean(a,{axis=-2,keepdims=true,where=true})
  assert(r.dtype=="float64","ext reduction 50 dtype "..r.dtype)
  assert(close(r.shape,{0,1,1}),"ext reduction 50 shape")
  assert(close(r.strides,{0,0,0}),"ext reduction 50 strides")
  assert(close(r:tolist(),{}),"ext reduction 50 values")
end
do -- extended reduction 51: prod uint64 shape=[0, 2, 2] axis=None
  local a=np.zeros({0,2,2},np.uint64)
  local r=np.prod(a,{axis=nil,keepdims=false,where=np.zeros({0,2,2},np.bool)})
  assert(close(r,1),"ext reduction 51 scalar")
end
do -- extended reduction 52: sum uint16 shape=[4, 2, 1] axis=()
  local a=np.array({{{3},{6}},{{2},{5}},{{1},{4}},{{0},{3}}},np.uint16)
  local o=np.zeros({4,2,1},np.int8)
  local r=np.sum(a,{axis={},keepdims=false,where=np.array({true},np.bool),initial=2,out=o})
  assert(r==o,"ext reduction 52 out identity")
  assert(r.dtype=="int8","ext reduction 52 out dtype "..r.dtype)
  assert(close(r:tolist(),{{{5},{8}},{{4},{7}},{{3},{6}},{{2},{5}}}),"ext reduction 52 out values")
end
do -- extended reduction 53: mean uint8 shape=[1, 4, 1] axis=None
  local a=np.array({{{4},{0},{3},{6}}},np.uint8)
  local r=np.mean(a,{axis=nil,keepdims=true,where=true})
  assert(r.dtype=="float64","ext reduction 53 dtype "..r.dtype)
  assert(close(r.shape,{1,1,1}),"ext reduction 53 shape")
  assert(close(r.strides,{8,8,8}),"ext reduction 53 strides")
  assert(close(r:tolist(),{{{3.25}}}),"ext reduction 53 values")
end
do -- extended reduction 54: mean uint32 shape=[0, 0, 3] axis=None
  local a=np.zeros({0,0,3},np.uint32)
  local r=np.mean(a,{axis=nil,keepdims=true,where=np.zeros({0,0,3},np.bool)})
  assert(r.dtype=="float64","ext reduction 54 dtype "..r.dtype)
  assert(close(r.shape,{1,1,1}),"ext reduction 54 shape")
  assert(close(r.strides,{8,8,8}),"ext reduction 54 strides")
  assert(close(r:tolist(),{{{0/0}}}),"ext reduction 54 values")
end
do -- extended reduction 55: prod bool shape=[0, 0, 0, 1] axis=(0,)
  local a=np.zeros({0,0,0,1},np.bool)
  local r=np.prod(a,{axis={1},keepdims=true,where=np.array({true},np.bool),dtype=np.int16})
  assert(r.dtype=="int16","ext reduction 55 dtype "..r.dtype)
  assert(close(r.shape,{1,0,0,1}),"ext reduction 55 shape")
  assert(close(r.strides,{0,0,0,0}),"ext reduction 55 strides")
  assert(close(r:tolist(),{{}}),"ext reduction 55 values")
end
do -- extended reduction 56: prod int8 shape=[4, 4] axis=1
  local a=np.array({{-4,1,-5,0},{5,-1,4,-2},{3,-3,2,-4},{1,-5,0,5}},np.int8)
  local r=np.prod(a,{axis=2,keepdims=true,where=np.array({true,false,true,true},np.bool),initial=3})
  assert(r.dtype=="int64","ext reduction 56 dtype "..r.dtype)
  assert(close(r.shape,{4,1}),"ext reduction 56 shape")
  assert(close(r.strides,{8,8}),"ext reduction 56 strides")
  assert(close(r:tolist(),{{0},{-120},{-72},{0}}),"ext reduction 56 values")
end
do -- extended reduction 57: sum int64 shape=[1] axis=()
  local a=np.array({-3},np.int64)
  local r=np.sum(a,{axis={},keepdims=true,where=np.array({false},np.bool)})
  assert(r.dtype=="int64","ext reduction 57 dtype "..r.dtype)
  assert(close(r.shape,{1}),"ext reduction 57 shape")
  assert(close(r.strides,{8}),"ext reduction 57 strides")
  assert(close(r:tolist(),{0}),"ext reduction 57 values")
end
do -- extended reduction 58: prod uint32 shape=[1, 4] axis=None
  local a=np.array({{2,5,1,4}},np.uint32)
  local r=np.prod(a,{axis=nil,keepdims=true,where=false})
  assert(r.dtype=="uint64","ext reduction 58 dtype "..r.dtype)
  assert(close(r.shape,{1,1}),"ext reduction 58 shape")
  assert(close(r.strides,{8,8}),"ext reduction 58 strides")
  assert(close(r:tolist(),{{1}}),"ext reduction 58 values")
end
do -- extended reduction 59: sum int16 shape=[3, 1] axis=None
  local a=np.array({{-1},{4},{-2}},np.int16)
  local r=np.sum(a,{axis=nil,keepdims=false,where=false})
  assert(close(r,0),"ext reduction 59 scalar")
end
do -- extended reduction 60: mean float32 shape=[1, 0, 1, 1] axis=(0,)
  local a=np.zeros({1,0,1,1},np.float32)
  local r=np.mean(a,{axis={1},keepdims=false,where=true})
  assert(r.dtype=="float32","ext reduction 60 dtype "..r.dtype)
  assert(close(r.shape,{0,1,1}),"ext reduction 60 shape")
  assert(close(r.strides,{0,0,0}),"ext reduction 60 strides")
  assert(close(r:tolist(),{}),"ext reduction 60 values")
end
do -- extended reduction 61: prod uint64 shape=[0, 3, 0] axis=(0, 1, 2)
  local a=np.zeros({0,3,0},np.uint64)
  local r=np.prod(a,{axis={1,2,3},keepdims=false,where=np.zeros({0},np.bool)})
  assert(close(r,1),"ext reduction 61 scalar")
end
do -- extended reduction 62: prod int64 shape=[1] axis=(0,)
  local a=np.array({2},np.int64)
  local o=np.zeros({},np.float64)
  local r=np.prod(a,{axis={1},keepdims=false,where=np.array({true},np.bool),dtype=np.int64,initial=1,out=o})
  assert(r==o,"ext reduction 62 out identity")
  assert(r.dtype=="float64","ext reduction 62 out dtype "..r.dtype)
  assert(close(r:tolist(),2.0),"ext reduction 62 out values")
end
do -- extended reduction 63: prod uint8 shape=[3] axis=(0,)
  local a=np.array({0,3,6},np.uint8)
  local r=np.prod(a,{axis={1},keepdims=true,where=np.array({false,true,true},np.bool)})
  assert(r.dtype=="uint64","ext reduction 63 dtype "..r.dtype)
  assert(close(r.shape,{1}),"ext reduction 63 shape")
  assert(close(r.strides,{8}),"ext reduction 63 strides")
  assert(close(r:tolist(),{18}),"ext reduction 63 values")
end
do -- extended reduction 64: sum uint64 shape=[0, 4, 3, 4] axis=(0, 2, 3)
  local a=np.zeros({0,4,3,4},np.uint64)
  local r=np.sum(a,{axis={1,3,4},keepdims=true,where=np.zeros({0,4,3,4},np.bool)})
  assert(r.dtype=="uint64","ext reduction 64 dtype "..r.dtype)
  assert(close(r.shape,{1,4,1,1}),"ext reduction 64 shape")
  assert(close(r.strides,{32,8,8,8}),"ext reduction 64 strides")
  assert(close(r:tolist(),{{{{0}},{{0}},{{0}},{{0}}}}),"ext reduction 64 values")
end
do -- extended reduction 65: sum uint32 shape=[4, 0, 2, 4] axis=-2
  local a=np.zeros({4,0,2,4},np.uint32)
  local r=np.sum(a,{axis=-2,keepdims=true,where=true,initial=1.5})
  assert(r.dtype=="uint64","ext reduction 65 dtype "..r.dtype)
  assert(close(r.shape,{4,0,1,4}),"ext reduction 65 shape")
  assert(close(r.strides,{0,0,0,0}),"ext reduction 65 strides")
  assert(close(r:tolist(),{{},{},{},{}}),"ext reduction 65 values")
end
do -- extended reduction 66: mean int64 shape=[2, 3, 1] axis=(0, 1)
  local a=np.array({{{-5},{0},{5}},{{-1},{4},{-2}}},np.int64)
  local r=np.mean(a,{axis={1,2},keepdims=true,where=false})
  assert(r.dtype=="float64","ext reduction 66 dtype "..r.dtype)
  assert(close(r.shape,{1,1,1}),"ext reduction 66 shape")
  assert(close(r.strides,{8,8,8}),"ext reduction 66 strides")
  assert(close(r:tolist(),{{{0/0}}}),"ext reduction 66 values")
end
do -- extended reduction 67: prod bool shape=[0, 0, 1, 0] axis=-4
  local a=np.zeros({0,0,1,0},np.bool)
  local r=np.prod(a,{axis=-4,keepdims=false,where=np.zeros({0},np.bool),dtype=np.uint16})
  assert(r.dtype=="uint16","ext reduction 67 dtype "..r.dtype)
  assert(close(r.shape,{0,1,0}),"ext reduction 67 shape")
  assert(close(r.strides,{0,0,0}),"ext reduction 67 strides")
  assert(close(r:tolist(),{}),"ext reduction 67 values")
end
do -- extended reduction 68: mean uint16 shape=[4, 0] axis=(0, 1)
  local a=np.zeros({4,0},np.uint16)
  local o=np.zeros({1,1},np.float32)
  local r=np.mean(a,{axis={1,2},keepdims=true,where=true,out=o})
  assert(r==o,"ext reduction 68 out identity")
  assert(r.dtype=="float32","ext reduction 68 out dtype "..r.dtype)
  assert(close(r:tolist(),{{0/0}}),"ext reduction 68 out values")
end
do -- extended reduction 69: mean int32 shape=[4, 1, 1] axis=1
  local a=np.array({{{-2}},{{3}},{{-3}},{{2}}},np.int32)
  local o=np.zeros({4,1},np.float64)
  local r=np.mean(a,{axis=2,keepdims=false,where=np.array({{{false}},{{true}},{{true}},{{false}}},np.bool),dtype=np.float32,out=o})
  assert(r==o,"ext reduction 69 out identity")
  assert(r.dtype=="float64","ext reduction 69 out dtype "..r.dtype)
  assert(close(r:tolist(),{{0/0},{3.0},{-3.0},{0/0}}),"ext reduction 69 out values")
end
do -- extended reduction 70: prod float16 shape=[1, 3] axis=(0, -1)
  local a=np.array({{-1.375,-0.875,-0.375}},np.float16)
  local r=np.prod(a,{axis={1,-1},keepdims=false,where=np.array({true,true,false},np.bool)})
  assert(close(r,1.203125),"ext reduction 70 scalar")
end
do -- extended reduction 71: sum int8 shape=[4] axis=0
  local a=np.array({0,5,-1,4},np.int8)
  local r=np.sum(a,{axis=1,keepdims=false,where=false})
  assert(close(r,0),"ext reduction 71 scalar")
end
do -- extended reduction 72: prod uint32 shape=[3, 4, 4, 1] axis=(1, 2)
  local a=np.array({{{{2},{5},{1},{4}},{{0},{3},{6},{2}},{{5},{1},{4},{0}},{{3},{6},{2},{5}}},{{{1},{4},{0},{3}},{{6},{2},{5},{1}},{{4},{0},{3},{6}},{{2},{5},{1},{4}}},{{{0},{3},{6},{2}},{{5},{1},{4},{0}},{{3},{6},{2},{5}},{{1},{4},{0},{3}}}},np.uint32)
  local r=np.prod(a,{axis={2,3},keepdims=true,where=true,dtype=np.float64})
  assert(r.dtype=="float64","ext reduction 72 dtype "..r.dtype)
  assert(close(r.shape,{3,1,1,1}),"ext reduction 72 shape")
  assert(close(r.strides,{8,8,8,8}),"ext reduction 72 strides")
  assert(close(r:tolist(),{{{{0.0}}},{{{0.0}}},{{{0.0}}}}),"ext reduction 72 values")
end
do -- extended reduction 73: prod int32 shape=[0, 3, 4] axis=-3
  local a=np.zeros({0,3,4},np.int32)
  local r=np.prod(a,{axis=-3,keepdims=false,where=true,initial=0})
  assert(r.dtype=="int64","ext reduction 73 dtype "..r.dtype)
  assert(close(r.shape,{3,4}),"ext reduction 73 shape")
  assert(close(r.strides,{32,8}),"ext reduction 73 strides")
  assert(close(r:tolist(),{{0,0,0,0},{0,0,0,0},{0,0,0,0}}),"ext reduction 73 values")
end
do -- extended reduction 74: mean float64 shape=[1, 1] axis=-1
  local a=np.array({{-1.25}},np.float64)
  local r=np.mean(a,{axis=-1,keepdims=true,where=np.array({true},np.bool)})
  assert(r.dtype=="float64","ext reduction 74 dtype "..r.dtype)
  assert(close(r.shape,{1,1}),"ext reduction 74 shape")
  assert(close(r.strides,{8,8}),"ext reduction 74 strides")
  assert(close(r:tolist(),{{-1.25}}),"ext reduction 74 values")
end
do -- extended reduction 75: mean int8 shape=[2, 2, 2] axis=()
  local a=np.array({{{4,-2},{3,-3}},{{2,-4},{1,-5}}},np.int8)
  local r=np.mean(a,{axis={},keepdims=false,where=np.array({{{false,true},{true,false}},{{true,true},{false,true}}},np.bool)})
  assert(r.dtype=="float64","ext reduction 75 dtype "..r.dtype)
  assert(close(r.shape,{2,2,2}),"ext reduction 75 shape")
  assert(close(r.strides,{32,16,8}),"ext reduction 75 strides")
  assert(close(r:tolist(),{{{0/0,-2.0},{3.0,0/0}},{{2.0,-4.0},{0/0,-5.0}}}),"ext reduction 75 values")
end
do -- extended reduction 76: mean uint64 shape=[0] axis=(-1,)
  local a=np.zeros({0},np.uint64)
  local r=np.mean(a,{axis={-1},keepdims=false,where=false,dtype=np.float32})
  assert(close(r,0/0),"ext reduction 76 scalar")
end
do -- extended reduction 77: sum int16 shape=[3, 4] axis=None
  local a=np.array({{-5,0,5,-1},{4,-2,3,-3},{2,-4,1,-5}},np.int16)
  local r=np.sum(a,{axis=nil,keepdims=false,where=np.array({{true,false,true,true}},np.bool),initial=-2})
  assert(close(r,-1),"ext reduction 77 scalar")
end
do -- extended reduction 78: sum int8 shape=[4, 3, 4] axis=()
  local a=np.array({{{-4,1,-5,0},{5,-1,4,-2},{3,-3,2,-4}},{{1,-5,0,5},{-1,4,-2,3},{-3,2,-4,1}},{{-5,0,5,-1},{4,-2,3,-3},{2,-4,1,-5}},{{0,5,-1,4},{-2,3,-3,2},{-4,1,-5,0}}},np.int8)
  local o=np.zeros({4,3,4},np.int8)
  local r=np.sum(a,{axis={},keepdims=true,where=np.array({{{false,true,true,false}}},np.bool),out=o})
  assert(r==o,"ext reduction 78 out identity")
  assert(r.dtype=="int8","ext reduction 78 out dtype "..r.dtype)
  assert(close(r:tolist(),{{{0,1,-5,0},{0,-1,4,0},{0,-3,2,0}},{{0,-5,0,0},{0,4,-2,0},{0,2,-4,0}},{{0,0,5,0},{0,-2,3,0},{0,-4,1,0}},{{0,5,-1,0},{0,3,-3,0},{0,1,-5,0}}}),"ext reduction 78 out values")
end
do -- extended reduction 79: mean uint8 shape=[2, 2] axis=(1,)
  local a=np.array({{2,5},{1,4}},np.uint8)
  local r=np.mean(a,{axis={2},keepdims=false,where=true})
  assert(r.dtype=="float64","ext reduction 79 dtype "..r.dtype)
  assert(close(r.shape,{2}),"ext reduction 79 shape")
  assert(close(r.strides,{8}),"ext reduction 79 strides")
  assert(close(r:tolist(),{3.5,2.5}),"ext reduction 79 values")
end
do -- extended reduction 80: sum int32 shape=[4, 0, 2, 4] axis=None
  local a=np.zeros({4,0,2,4},np.int32)
  local r=np.sum(a,{axis=nil,keepdims=false,where=np.array({true,false,true,true},np.bool)})
  assert(close(r,0),"ext reduction 80 scalar")
end
do -- extended reduction 81: mean float64 shape=[0, 4, 3] axis=()
  local a=np.zeros({0,4,3},np.float64)
  local o=np.zeros({0,4,3},np.float32)
  local r=np.mean(a,{axis={},keepdims=false,where=np.zeros({0,4,3},np.bool),out=o})
  assert(r==o,"ext reduction 81 out identity")
  assert(r.dtype=="float32","ext reduction 81 out dtype "..r.dtype)
  assert(close(r:tolist(),{}),"ext reduction 81 out values")
end
do -- extended reduction 82: prod uint32 shape=[0, 2, 1, 1] axis=(0, -1)
  local a=np.zeros({0,2,1,1},np.uint32)
  local r=np.prod(a,{axis={1,-1},keepdims=true,where=np.array({true},np.bool)})
  assert(r.dtype=="uint64","ext reduction 82 dtype "..r.dtype)
  assert(close(r.shape,{1,2,1,1}),"ext reduction 82 shape")
  assert(close(r.strides,{16,8,8,8}),"ext reduction 82 strides")
  assert(close(r:tolist(),{{{{1}},{{1}}}}),"ext reduction 82 values")
end
do -- extended reduction 83: mean int32 shape=[0, 4] axis=None
  local a=np.zeros({0,4},np.int32)
  local r=np.mean(a,{axis=nil,keepdims=true,where=np.array({{true,false,true,true}},np.bool)})
  assert(r.dtype=="float64","ext reduction 83 dtype "..r.dtype)
  assert(close(r.shape,{1,1}),"ext reduction 83 shape")
  assert(close(r.strides,{8,8}),"ext reduction 83 strides")
  assert(close(r:tolist(),{{0/0}}),"ext reduction 83 values")
end
do -- extended reduction 84: prod int16 shape=[1, 3, 3] axis=()
  local a=(np.array({{{2},{-4},{1}},{{-5},{0},{5}},{{-1},{4},{-2}}},np.int16)).T
  local r=np.prod(a,{axis={},keepdims=false,where=false})
  assert(r.dtype=="int64","ext reduction 84 dtype "..r.dtype)
  assert(close(r.shape,{1,3,3}),"ext reduction 84 shape")
  assert(close(r.strides,{72,8,24}),"ext reduction 84 strides")
  assert(close(r:tolist(),{{{1,1,1},{1,1,1},{1,1,1}}}),"ext reduction 84 values")
end
do -- extended reduction 85: prod float16 shape=[3] axis=None
  local a=np.array({-1.375,-0.875,-0.375},np.float16)
  local r=np.prod(a,{axis=nil,keepdims=false,where=np.array({true,true,false},np.bool),initial=3})
  assert(close(r,3.609375),"ext reduction 85 scalar")
end
do -- extended reduction 86: mean int64 shape=[0, 2] axis=1
  local a=np.zeros({0,2},np.int64)
  local r=np.mean(a,{axis=2,keepdims=false,where=np.zeros({0,2},np.bool)})
  assert(r.dtype=="float64","ext reduction 86 dtype "..r.dtype)
  assert(close(r.shape,{0}),"ext reduction 86 shape")
  assert(close(r.strides,{0}),"ext reduction 86 strides")
  assert(close(r:tolist(),{}),"ext reduction 86 values")
end
do -- extended reduction 87: mean int8 shape=[1, 2, 4, 2] axis=0
  local a=np.array({{{{5,-1},{4,-2},{3,-3},{2,-4}},{{1,-5},{0,5},{-1,4},{-2,3}}}},np.int8)
  local r=np.mean(a,{axis=1,keepdims=false,where=np.array({{{{false,true},{true,false},{true,true},{false,true}},{{true,false},{true,true},{false,true},{true,false}}}},np.bool)})
  assert(r.dtype=="float64","ext reduction 87 dtype "..r.dtype)
  assert(close(r.shape,{2,4,2}),"ext reduction 87 shape")
  assert(close(r.strides,{64,16,8}),"ext reduction 87 strides")
  assert(close(r:tolist(),{{{0/0,-1.0},{4.0,0/0},{3.0,-3.0},{0/0,-4.0}},{{1.0,0/0},{0.0,5.0},{0/0,4.0},{-2.0,0/0}}}),"ext reduction 87 values")
end
do -- extended reduction 88: sum int16 shape=[4, 0, 4] axis=-3
  local a=np.zeros({4,0,4},np.int16)
  local o=np.zeros({0,4},np.int64)
  local r=np.sum(a,{axis=-3,keepdims=false,where=np.array({{{true,true,false,true}}},np.bool),out=o})
  assert(r==o,"ext reduction 88 out identity")
  assert(r.dtype=="int64","ext reduction 88 out dtype "..r.dtype)
  assert(close(r:tolist(),{}),"ext reduction 88 out values")
end
do -- extended reduction 89: mean float64 shape=[1, 2] axis=0
  local a=np.array({{-1.25,-0.75}},np.float64)
  local r=np.mean(a,{axis=1,keepdims=true,where=np.array({{true,false}},np.bool)})
  assert(r.dtype=="float64","ext reduction 89 dtype "..r.dtype)
  assert(close(r.shape,{1,2}),"ext reduction 89 shape")
  assert(close(r.strides,{16,8}),"ext reduction 89 strides")
  assert(close(r:tolist(),{{-1.25,0/0}}),"ext reduction 89 values")
end
do -- extended reduction 90: prod uint32 shape=[1, 3] axis=(0, 1)
  local a=np.array({{6,2,5}},np.uint32)
  local r=np.prod(a,{axis={1,2},keepdims=true,where=np.array({{false,true,true}},np.bool)})
  assert(r.dtype=="uint64","ext reduction 90 dtype "..r.dtype)
  assert(close(r.shape,{1,1}),"ext reduction 90 shape")
  assert(close(r.strides,{8,8}),"ext reduction 90 strides")
  assert(close(r:tolist(),{{10}}),"ext reduction 90 values")
end
do -- extended reduction 91: sum uint32 shape=[3, 3] axis=()
  local a=np.array({{0,3,6},{2,5,1},{4,0,3}},np.uint32)
  local r=np.sum(a,{axis={},keepdims=false,where=np.array({{true,true,false},{true,true,false},{true,true,false}},np.bool)})
  assert(r.dtype=="uint64","ext reduction 91 dtype "..r.dtype)
  assert(close(r.shape,{3,3}),"ext reduction 91 shape")
  assert(close(r.strides,{24,8}),"ext reduction 91 strides")
  assert(close(r:tolist(),{{0,3,0},{2,5,0},{4,0,0}}),"ext reduction 91 values")
end
do -- extended reduction 92: sum int16 shape=[1, 2, 1] axis=(2,)
  local a=np.array({{{-1},{4}}},np.int16)
  local r=np.sum(a,{axis={3},keepdims=false,where=np.array({true},np.bool),dtype=np.uint16})
  assert(r.dtype=="uint16","ext reduction 92 dtype "..r.dtype)
  assert(close(r.shape,{1,2}),"ext reduction 92 shape")
  assert(close(r.strides,{4,2}),"ext reduction 92 strides")
  assert(close(r:tolist(),{{65535,4}}),"ext reduction 92 values")
end
do -- extended reduction 93: prod float64 shape=[4] axis=None
  local a=np.array({-1.5,-1.0,-0.5,0.0},np.float64)
  local r=np.prod(a,{axis=nil,keepdims=true,where=np.array({false,true,true,false},np.bool)})
  assert(r.dtype=="float64","ext reduction 93 dtype "..r.dtype)
  assert(close(r.shape,{1}),"ext reduction 93 shape")
  assert(close(r.strides,{8}),"ext reduction 93 strides")
  assert(close(r:tolist(),{0.5}),"ext reduction 93 values")
end
do -- extended reduction 94: mean int16 shape=[0, 4, 2] axis=None
  local a=np.zeros({0,4,2},np.int16)
  local r=np.mean(a,{axis=nil,keepdims=false,where=np.zeros({0,4,2},np.bool),dtype=np.float32})
  assert(close(r,0/0),"ext reduction 94 scalar")
end
do -- extended reduction 95: prod uint16 shape=[4, 1] axis=()
  local a=np.array({{4},{0},{3},{6}},np.uint16)
  local o=np.zeros({4,1},np.float64)
  local r=np.prod(a,{axis={},keepdims=false,where=np.array({{true}},np.bool),out=o})
  assert(r==o,"ext reduction 95 out identity")
  assert(r.dtype=="float64","ext reduction 95 out dtype "..r.dtype)
  assert(close(r:tolist(),{{4.0},{0.0},{3.0},{6.0}}),"ext reduction 95 out values")
end
do -- extended reduction 96: sum uint64 shape=[0, 2] axis=1
  local a=np.zeros({0,2},np.uint64)
  local r=np.sum(a,{axis=2,keepdims=false,where=np.array({false,true},np.bool),dtype=np.float16})
  assert(r.dtype=="float16","ext reduction 96 dtype "..r.dtype)
  assert(close(r.shape,{0}),"ext reduction 96 shape")
  assert(close(r.strides,{0}),"ext reduction 96 strides")
  assert(close(r:tolist(),{}),"ext reduction 96 values")
end
do -- extended reduction 97: mean uint16 shape=[0, 0] axis=None
  local a=np.zeros({0,0},np.uint16)
  local r=np.mean(a,{axis=nil,keepdims=false,where=false})
  assert(close(r,0/0),"ext reduction 97 scalar")
end
do -- extended reduction 98: prod int64 shape=[0] axis=(0,)
  local a=np.zeros({0},np.int64)
  local o=np.zeros({1},np.float32)
  local r=np.prod(a,{axis={1},keepdims=true,where=false,out=o})
  assert(r==o,"ext reduction 98 out identity")
  assert(r.dtype=="float32","ext reduction 98 out dtype "..r.dtype)
  assert(close(r:tolist(),{1.0}),"ext reduction 98 out values")
end
do -- extended reduction 99: mean float32 shape=[1] axis=-1
  local a=np.array({-1.5},np.float32)
  local r=np.mean(a,{axis=-1,keepdims=true,where=np.array({false},np.bool),dtype=np.float32})
  assert(r.dtype=="float32","ext reduction 99 dtype "..r.dtype)
  assert(close(r.shape,{1}),"ext reduction 99 shape")
  assert(close(r.strides,{4}),"ext reduction 99 strides")
  assert(close(r:tolist(),{0/0}),"ext reduction 99 values")
end
do -- extended reduction 100: mean int32 shape=[1] axis=(0,)
  local a=np.array({-4},np.int32)
  local o=np.zeros({1},np.float32)
  local r=np.mean(a,{axis={1},keepdims=true,where=np.array({true},np.bool),out=o})
  assert(r==o,"ext reduction 100 out identity")
  assert(r.dtype=="float32","ext reduction 100 out dtype "..r.dtype)
  assert(close(r:tolist(),{-4.0}),"ext reduction 100 out values")
end
do -- extended reduction 101: sum bool shape=[2] axis=()
  local a=np.array({true,true},np.bool)
  local o=np.zeros({2},np.float16)
  local r=np.sum(a,{axis={},keepdims=false,where=np.array({true,false},np.bool),out=o})
  assert(r==o,"ext reduction 101 out identity")
  assert(r.dtype=="float16","ext reduction 101 out dtype "..r.dtype)
  assert(close(r:tolist(),{1.0,0.0}),"ext reduction 101 out values")
end
do -- extended reduction 102: prod int16 shape=[2, 3, 4] axis=1
  local a=(np.array({{{-2,3},{-3,2},{-4,1}},{{-5,0},{5,-1},{4,-2}},{{3,-3},{2,-4},{1,-5}},{{0,5},{-1,4},{-2,3}}},np.int16)).T
  local o=np.zeros({2,4},np.int64)
  local r=np.prod(a,{axis=2,keepdims=false,where=np.array({{{false,true,true,false}}},np.bool),dtype=np.int64,out=o})
  assert(r==o,"ext reduction 102 out identity")
  assert(r.dtype=="int64","ext reduction 102 out dtype "..r.dtype)
  assert(close(r:tolist(),{{1,-100,6,1},{1,0,-60,1}}),"ext reduction 102 out values")
end
do -- extended reduction 103: prod float16 shape=[0, 1, 0] axis=None
  local a=np.zeros({0,1,0},np.float16)
  local o=np.zeros({},np.float16)
  local r=np.prod(a,{axis=nil,keepdims=false,where=true,dtype=np.bool,initial=1,out=o})
  assert(r==o,"ext reduction 103 out identity")
  assert(r.dtype=="float16","ext reduction 103 out dtype "..r.dtype)
  assert(close(r:tolist(),1.0),"ext reduction 103 out values")
end
do -- extended reduction 104: sum float16 shape=[2, 2, 1, 4] axis=None
  local a=np.array({{{{-1.25,-0.75,-0.25,0.25}},{{0.75,1.25,1.75,-1.25}}},{{{-0.75,-0.25,0.25,0.75}},{{1.25,1.75,-1.25,-0.75}}}},np.float16)
  local o=np.zeros({},np.int8)
  local r=np.sum(a,{axis=nil,keepdims=false,where=np.array({{{{true,false,true,true}},{{false,true,true,false}}},{{{true,true,false,true}},{{true,false,true,true}}}},np.bool),out=o})
  assert(r==o,"ext reduction 104 out identity")
  assert(r.dtype=="int8","ext reduction 104 out dtype "..r.dtype)
  assert(close(r:tolist(),0),"ext reduction 104 out values")
end
do -- extended reduction 105: sum int8 shape=[2] axis=0
  local a=np.array({1,-5},np.int8)
  local o=np.zeros({1},np.int8)
  local r=np.sum(a,{axis=1,keepdims=true,where=np.array({false,true},np.bool),dtype=np.uint8,initial=2,out=o})
  assert(r==o,"ext reduction 105 out identity")
  assert(r.dtype=="int8","ext reduction 105 out dtype "..r.dtype)
  assert(close(r:tolist(),{-3}),"ext reduction 105 out values")
end
do -- extended reduction 106: prod float64 shape=[0, 4, 2, 2] axis=-1
  local a=np.zeros({0,4,2,2},np.float64)
  local r=np.prod(a,{axis=-1,keepdims=false,where=np.zeros({0,4,2,2},np.bool),initial=2})
  assert(r.dtype=="float64","ext reduction 106 dtype "..r.dtype)
  assert(close(r.shape,{0,4,2}),"ext reduction 106 shape")
  assert(close(r.strides,{0,0,0}),"ext reduction 106 strides")
  assert(close(r:tolist(),{}),"ext reduction 106 values")
end
do -- extended reduction 107: mean uint32 shape=[0, 4, 4, 3] axis=(0, -3, 2, -1)
  local a=np.zeros({0,4,4,3},np.uint32)
  local r=np.mean(a,{axis={1,-3,3,-1},keepdims=true,where=np.array({{{{true,false,true}}}},np.bool)})
  assert(r.dtype=="float64","ext reduction 107 dtype "..r.dtype)
  assert(close(r.shape,{1,1,1,1}),"ext reduction 107 shape")
  assert(close(r.strides,{8,8,8,8}),"ext reduction 107 strides")
  assert(close(r:tolist(),{{{{0/0}}}}),"ext reduction 107 values")
end
do -- extended reduction 108: sum float32 shape=[1, 0, 0] axis=None
  local a=np.zeros({1,0,0},np.float32)
  local r=np.sum(a,{axis=nil,keepdims=true,where=true,initial=3})
  assert(r.dtype=="float32","ext reduction 108 dtype "..r.dtype)
  assert(close(r.shape,{1,1,1}),"ext reduction 108 shape")
  assert(close(r.strides,{4,4,4}),"ext reduction 108 strides")
  assert(close(r:tolist(),{{{3.0}}}),"ext reduction 108 values")
end
do -- extended reduction 109: mean uint8 shape=[2] axis=()
  local a=np.array({4,0},np.uint8)
  local r=np.mean(a,{axis={},keepdims=true,where=true})
  assert(r.dtype=="float64","ext reduction 109 dtype "..r.dtype)
  assert(close(r.shape,{2}),"ext reduction 109 shape")
  assert(close(r.strides,{8}),"ext reduction 109 strides")
  assert(close(r:tolist(),{4.0,0.0}),"ext reduction 109 values")
end
do -- extended reduction 110: prod int16 shape=[1, 2] axis=(0, 1)
  local a=(np.array({{-5},{0}},np.int16)).T
  local o=np.zeros({},np.int16)
  local r=np.prod(a,{axis={1,2},keepdims=false,where=np.array({{true,false}},np.bool),dtype=np.bool,out=o})
  assert(r==o,"ext reduction 110 out identity")
  assert(r.dtype=="int16","ext reduction 110 out dtype "..r.dtype)
  assert(close(r:tolist(),1),"ext reduction 110 out values")
end
do -- extended reduction 111: sum int32 shape=[1, 1] axis=1
  local a=np.array({{-4}},np.int32)
  local r=np.sum(a,{axis=2,keepdims=true,where=np.array({{false}},np.bool),initial=0})
  assert(r.dtype=="int64","ext reduction 111 dtype "..r.dtype)
  assert(close(r.shape,{1,1}),"ext reduction 111 shape")
  assert(close(r.strides,{8,8}),"ext reduction 111 strides")
  assert(close(r:tolist(),{{0}}),"ext reduction 111 values")
end
do -- extended reduction 112: mean uint64 shape=[0] axis=-1
  local a=np.zeros({0},np.uint64)
  local o=np.zeros({1},np.float64)
  local r=np.mean(a,{axis=-1,keepdims=true,where=false,out=o})
  assert(r==o,"ext reduction 112 out identity")
  assert(r.dtype=="float64","ext reduction 112 out dtype "..r.dtype)
  assert(close(r:tolist(),{0/0}),"ext reduction 112 out values")
end
do -- extended reduction 113: prod float16 shape=[3, 1, 2, 4] axis=(0, 1, -2, 3)
  local a=np.array({{{{-1.25,-0.75,-0.25,0.25},{0.75,1.25,1.75,-1.25}}},{{{-0.75,-0.25,0.25,0.75},{1.25,1.75,-1.25,-0.75}}},{{{-0.25,0.25,0.75,1.25},{1.75,-1.25,-0.75,-0.25}}}},np.float16)
  local o=np.zeros({1,1,1,1},np.int64)
  local r=np.prod(a,{axis={1,2,-2,4},keepdims=true,where=true,initial=1.5,out=o})
  assert(r==o,"ext reduction 113 out identity")
  assert(r.dtype=="int64","ext reduction 113 out dtype "..r.dtype)
  assert(close(r:tolist(),{{{{0}}}}),"ext reduction 113 out values")
end
do -- extended reduction 114: sum uint16 shape=[2] axis=()
  local a=np.array({2,5},np.uint16)
  local r=np.sum(a,{axis={},keepdims=true,where=false,initial=1})
  assert(r.dtype=="uint64","ext reduction 114 dtype "..r.dtype)
  assert(close(r.shape,{2}),"ext reduction 114 shape")
  assert(close(r.strides,{8}),"ext reduction 114 strides")
  assert(close(r:tolist(),{1,1}),"ext reduction 114 values")
end
do -- extended reduction 115: prod int64 shape=[4, 0, 4] axis=None
  local a=np.zeros({4,0,4},np.int64)
  local r=np.prod(a,{axis=nil,keepdims=true,where=np.array({{{true,true,false,true}}},np.bool),dtype=np.int16})
  assert(r.dtype=="int16","ext reduction 115 dtype "..r.dtype)
  assert(close(r.shape,{1,1,1}),"ext reduction 115 shape")
  assert(close(r.strides,{2,2,2}),"ext reduction 115 strides")
  assert(close(r:tolist(),{{{1}}}),"ext reduction 115 values")
end
do -- extended reduction 116: prod float16 shape=[1] axis=None
  local a=np.array({-1.25},np.float16)
  local r=np.prod(a,{axis=nil,keepdims=true,where=np.array({true},np.bool)})
  assert(r.dtype=="float16","ext reduction 116 dtype "..r.dtype)
  assert(close(r.shape,{1}),"ext reduction 116 shape")
  assert(close(r.strides,{2}),"ext reduction 116 strides")
  assert(close(r:tolist(),{-1.25}),"ext reduction 116 values")
end
do -- extended reduction 117: sum uint8 shape=[0, 4, 4] axis=()
  local a=np.zeros({0,4,4},np.uint8)
  local r=np.sum(a,{axis={},keepdims=false,where=np.array({false,true,true,false},np.bool)})
  assert(r.dtype=="uint64","ext reduction 117 dtype "..r.dtype)
  assert(close(r.shape,{0,4,4}),"ext reduction 117 shape")
  assert(close(r.strides,{0,0,0}),"ext reduction 117 strides")
  assert(close(r:tolist(),{}),"ext reduction 117 values")
end
do -- extended reduction 118: mean int64 shape=[1, 2, 4] axis=()
  local a=np.array({{{3,-3,2,-4},{1,-5,0,5}}},np.int64)
  local r=np.mean(a,{axis={},keepdims=false,where=np.array({{{true,true,false,true}}},np.bool)})
  assert(r.dtype=="float64","ext reduction 118 dtype "..r.dtype)
  assert(close(r.shape,{1,2,4}),"ext reduction 118 shape")
  assert(close(r.strides,{64,32,8}),"ext reduction 118 strides")
  assert(close(r:tolist(),{{{3.0,-3.0,0/0,-4.0},{1.0,-5.0,0/0,5.0}}}),"ext reduction 118 values")
end
do -- extended reduction 119: prod float16 shape=[4, 4, 0, 3] axis=0
  local a=np.zeros({4,4,0,3},np.float16)
  local o=np.zeros({4,0,3},np.float32)
  local r=np.prod(a,{axis=1,keepdims=false,where=np.array({true,false,true},np.bool),initial=2,out=o})
  assert(r==o,"ext reduction 119 out identity")
  assert(r.dtype=="float32","ext reduction 119 out dtype "..r.dtype)
  assert(close(r:tolist(),{{},{},{},{}}),"ext reduction 119 out values")
end
do -- extended reduction 120: mean uint16 shape=[0] axis=0
  local a=np.zeros({0},np.uint16)
  local o=np.zeros({1},np.float32)
  local r=np.mean(a,{axis=1,keepdims=true,where=true,out=o})
  assert(r==o,"ext reduction 120 out identity")
  assert(r.dtype=="float32","ext reduction 120 out dtype "..r.dtype)
  assert(close(r:tolist(),{0/0}),"ext reduction 120 out values")
end
do -- extended reduction 121: sum float16 shape=[3, 4, 2] axis=(0, 1, -1)
  local a=np.array({{{-1.375,-0.875},{-0.375,0.125},{0.625,1.125},{1.625,-1.375}},{{-0.875,-0.375},{0.125,0.625},{1.125,1.625},{-1.375,-0.875}},{{-0.375,0.125},{0.625,1.125},{1.625,-1.375},{-0.875,-0.375}}},np.float16)
  local r=np.sum(a,{axis={1,2,-1},keepdims=true,where=np.array({true,true},np.bool),dtype=np.int64,initial=1.5})
  assert(r.dtype=="int64","ext reduction 121 dtype "..r.dtype)
  assert(close(r.shape,{1,1,1}),"ext reduction 121 shape")
  assert(close(r.strides,{8,8,8}),"ext reduction 121 strides")
  assert(close(r:tolist(),{{{3}}}),"ext reduction 121 values")
end
do -- extended reduction 122: sum float32 shape=[4] axis=0
  local a=np.array({-1.25,-0.75,-0.25,0.25},np.float32)
  local r=np.sum(a,{axis=1,keepdims=false,where=false})
  assert(close(r,0.0),"ext reduction 122 scalar")
end
do -- extended reduction 123: mean bool shape=[3, 0, 1] axis=None
  local a=np.zeros({3,0,1},np.bool)
  local r=np.mean(a,{axis=nil,keepdims=false,where=true,dtype=np.float32})
  assert(close(r,0/0),"ext reduction 123 scalar")
end
do -- extended reduction 124: sum int16 shape=[3, 1] axis=1
  local a=np.array({{-2},{3},{-3}},np.int16)
  local r=np.sum(a,{axis=2,keepdims=false,where=np.array({{true}},np.bool)})
  assert(r.dtype=="int64","ext reduction 124 dtype "..r.dtype)
  assert(close(r.shape,{3}),"ext reduction 124 shape")
  assert(close(r.strides,{8}),"ext reduction 124 strides")
  assert(close(r:tolist(),{-2,3,-3}),"ext reduction 124 values")
end
do -- extended reduction 125: sum float32 shape=[1] axis=(0,)
  local a=np.array({-1.25},np.float32)
  local r=np.sum(a,{axis={1},keepdims=false,where=np.array({true},np.bool),initial=0})
  assert(close(r,-1.25),"ext reduction 125 scalar")
end
do -- extended reduction 126: prod float64 shape=[0, 1, 3, 0] axis=0
  local a=np.zeros({0,1,3,0},np.float64)
  local r=np.prod(a,{axis=1,keepdims=true,where=np.zeros({0,1,3,0},np.bool)})
  assert(r.dtype=="float64","ext reduction 126 dtype "..r.dtype)
  assert(close(r.shape,{1,1,3,0}),"ext reduction 126 shape")
  assert(close(r.strides,{0,0,0,0}),"ext reduction 126 strides")
  assert(close(r:tolist(),{{{{},{},{}}}}),"ext reduction 126 values")
end
do -- extended reduction 127: sum uint64 shape=[0, 2, 1, 1] axis=None
  local a=np.zeros({0,2,1,1},np.uint64)
  local o=np.zeros({},np.int8)
  local r=np.sum(a,{axis=nil,keepdims=false,where=np.array({true},np.bool),out=o})
  assert(r==o,"ext reduction 127 out identity")
  assert(r.dtype=="int8","ext reduction 127 out dtype "..r.dtype)
  assert(close(r:tolist(),0),"ext reduction 127 out values")
end
do -- extended reduction 128: sum int8 shape=[4, 0] axis=None
  local a=np.zeros({4,0},np.int8)
  local r=np.sum(a,{axis=nil,keepdims=false,where=np.zeros({0},np.bool),dtype=np.bool})
  assert(close(r,false),"ext reduction 128 scalar")
end
do -- extended reduction 129: mean uint64 shape=[0, 3, 0] axis=0
  local a=np.zeros({0,3,0},np.uint64)
  local o=np.zeros({3,0},np.float32)
  local r=np.mean(a,{axis=1,keepdims=false,where=np.zeros({1,1,0},np.bool),out=o})
  assert(r==o,"ext reduction 129 out identity")
  assert(r.dtype=="float32","ext reduction 129 out dtype "..r.dtype)
  assert(close(r:tolist(),{{},{},{}}),"ext reduction 129 out values")
end
do -- extended reduction 130: sum uint32 shape=[2, 4] axis=()
  local a=np.array({{4,0,3,6},{2,5,1,4}},np.uint32)
  local r=np.sum(a,{axis={},keepdims=true,where=true})
  assert(r.dtype=="uint64","ext reduction 130 dtype "..r.dtype)
  assert(close(r.shape,{2,4}),"ext reduction 130 shape")
  assert(close(r.strides,{32,8}),"ext reduction 130 strides")
  assert(close(r:tolist(),{{4,0,3,6},{2,5,1,4}}),"ext reduction 130 values")
end
do -- extended reduction 131: sum uint64 shape=[4, 0] axis=1
  local a=np.zeros({4,0},np.uint64)
  local o=np.zeros({4},np.int64)
  local r=np.sum(a,{axis=2,keepdims=false,where=np.zeros({4,0},np.bool),out=o})
  assert(r==o,"ext reduction 131 out identity")
  assert(r.dtype=="int64","ext reduction 131 out dtype "..r.dtype)
  assert(close(r:tolist(),{0,0,0,0}),"ext reduction 131 out values")
end
do -- extended reduction 132: sum int32 shape=[4, 1] axis=None
  local a=np.array({{-5},{0},{5},{-1}},np.int32)
  local r=np.sum(a,{axis=nil,keepdims=false,where=np.array({{false}},np.bool),initial=1.5})
  assert(close(r,1),"ext reduction 132 scalar")
end
do -- extended reduction 133: prod float64 shape=[3, 0, 4, 0] axis=(2,)
  local a=np.zeros({3,0,4,0},np.float64)
  local r=np.prod(a,{axis={3},keepdims=true,where=np.zeros({3,0,4,0},np.bool)})
  assert(r.dtype=="float64","ext reduction 133 dtype "..r.dtype)
  assert(close(r.shape,{3,0,1,0}),"ext reduction 133 shape")
  assert(close(r.strides,{0,0,0,0}),"ext reduction 133 strides")
  assert(close(r:tolist(),{{},{},{}}),"ext reduction 133 values")
end
do -- extended reduction 134: prod int8 shape=[2] axis=None
  local a=np.array({-3,2},np.int8)
  local r=np.prod(a,{axis=nil,keepdims=false,where=true})
  assert(close(r,-6),"ext reduction 134 scalar")
end
do -- extended reduction 135: sum int64 shape=[2] axis=(0,)
  local a=np.array({-2,3},np.int64)
  local o=np.zeros({},np.float32)
  local r=np.sum(a,{axis={1},keepdims=false,where=np.array({false,true},np.bool),dtype=np.int8,initial=3,out=o})
  assert(r==o,"ext reduction 135 out identity")
  assert(r.dtype=="float32","ext reduction 135 out dtype "..r.dtype)
  assert(close(r:tolist(),6.0),"ext reduction 135 out values")
end
do -- extended reduction 136: prod bool shape=[4] axis=None
  local a=np.array({true,true,true,false},np.bool)
  local r=np.prod(a,{axis=nil,keepdims=false,where=true})
  assert(close(r,0),"ext reduction 136 scalar")
end
do -- extended reduction 137: mean float16 shape=[4, 2, 4, 0] axis=0
  local a=np.zeros({4,2,4,0},np.float16)
  local o=np.zeros({1,2,4,0},np.float32)
  local r=np.mean(a,{axis=1,keepdims=true,where=false,out=o})
  assert(r==o,"ext reduction 137 out identity")
  assert(r.dtype=="float32","ext reduction 137 out dtype "..r.dtype)
  assert(close(r:tolist(),{{{{},{},{},{}},{{},{},{},{}}}}),"ext reduction 137 out values")
end
do -- extended reduction 138: prod uint64 shape=[4, 3] axis=0
  local a=np.array({{5,1,4},{0,3,6},{2,5,1},{4,0,3}},np.uint64)
  local o=np.zeros({1,3},np.float16)
  local r=np.prod(a,{axis=1,keepdims=true,where=false,out=o})
  assert(r==o,"ext reduction 138 out identity")
  assert(r.dtype=="float16","ext reduction 138 out dtype "..r.dtype)
  assert(close(r:tolist(),{{1.0,1.0,1.0}}),"ext reduction 138 out values")
end
do -- extended reduction 139: mean uint64 shape=[1, 0] axis=(0, 1)
  local a=np.zeros({1,0},np.uint64)
  local r=np.mean(a,{axis={1,2},keepdims=false,where=false})
  assert(close(r,0/0),"ext reduction 139 scalar")
end
do -- extended reduction 140: prod uint8 shape=[0, 2] axis=None
  local a=np.zeros({0,2},np.uint8)
  local r=np.prod(a,{axis=nil,keepdims=false,where=np.zeros({0,2},np.bool)})
  assert(close(r,1),"ext reduction 140 scalar")
end
do -- extended reduction 141: prod bool shape=[4] axis=None
  local a=np.array({true,true,true,false},np.bool)
  local r=np.prod(a,{axis=nil,keepdims=false,where=np.array({false,true,true,false},np.bool),dtype=np.int16})
  assert(close(r,1),"ext reduction 141 scalar")
end
do -- extended reduction 142: prod float16 shape=[4, 1] axis=None
  local a=np.array({{-1.375},{-0.875},{-0.375},{0.125}},np.float16)
  local r=np.prod(a,{axis=nil,keepdims=false,where=np.array({true},np.bool),dtype=np.int64})
  assert(close(r,0),"ext reduction 142 scalar")
end
do -- extended reduction 143: sum uint32 shape=[1, 0, 2, 4] axis=(1, 2, 3)
  local a=np.zeros({1,0,2,4},np.uint32)
  local r=np.sum(a,{axis={2,3,4},keepdims=true,where=np.array({true,false,true,true},np.bool)})
  assert(r.dtype=="uint64","ext reduction 143 dtype "..r.dtype)
  assert(close(r.shape,{1,1,1,1}),"ext reduction 143 shape")
  assert(close(r.strides,{8,8,8,8}),"ext reduction 143 strides")
  assert(close(r:tolist(),{{{{0}}}}),"ext reduction 143 values")
end
do -- extended reduction 144: prod int64 shape=[0, 4] axis=None
  local a=np.zeros({0,4},np.int64)
  local r=np.prod(a,{axis=nil,keepdims=true,where=false})
  assert(r.dtype=="int64","ext reduction 144 dtype "..r.dtype)
  assert(close(r.shape,{1,1}),"ext reduction 144 shape")
  assert(close(r.strides,{8,8}),"ext reduction 144 strides")
  assert(close(r:tolist(),{{1}}),"ext reduction 144 values")
end
do -- extended reduction 145: mean bool shape=[1, 2] axis=1
  local a=np.array({{false,true}},np.bool)
  local r=np.mean(a,{axis=2,keepdims=false,where=false})
  assert(r.dtype=="float64","ext reduction 145 dtype "..r.dtype)
  assert(close(r.shape,{1}),"ext reduction 145 shape")
  assert(close(r.strides,{8}),"ext reduction 145 strides")
  assert(close(r:tolist(),{0/0}),"ext reduction 145 values")
end
do -- extended reduction 146: sum int16 shape=[4, 4] axis=-1
  local a=np.array({{-2,3,-3,2},{-4,1,-5,0},{5,-1,4,-2},{3,-3,2,-4}},np.int16)
  local r=np.sum(a,{axis=-1,keepdims=false,where=false})
  assert(r.dtype=="int64","ext reduction 146 dtype "..r.dtype)
  assert(close(r.shape,{4}),"ext reduction 146 shape")
  assert(close(r.strides,{8}),"ext reduction 146 strides")
  assert(close(r:tolist(),{0,0,0,0}),"ext reduction 146 values")
end
do -- extended reduction 147: mean int32 shape=[3, 0, 1] axis=(0, 1, 2)
  local a=np.zeros({3,0,1},np.int32)
  local o=np.zeros({},np.float64)
  local r=np.mean(a,{axis={1,2,3},keepdims=false,where=np.zeros({3,0,1},np.bool),out=o})
  assert(r==o,"ext reduction 147 out identity")
  assert(r.dtype=="float64","ext reduction 147 out dtype "..r.dtype)
  assert(close(r:tolist(),0/0),"ext reduction 147 out values")
end
do -- extended reduction 148: prod uint64 shape=[4, 3, 1, 4] axis=(-4, 1, -2, -1)
  local a=np.array({{{{1,4,0,3}},{{6,2,5,1}},{{4,0,3,6}}},{{{2,5,1,4}},{{0,3,6,2}},{{5,1,4,0}}},{{{3,6,2,5}},{{1,4,0,3}},{{6,2,5,1}}},{{{4,0,3,6}},{{2,5,1,4}},{{0,3,6,2}}}},np.uint64)
  local o=np.zeros({},np.float64)
  local r=np.prod(a,{axis={-4,2,-2,-1},keepdims=false,where=false,dtype=np.uint64,initial=1.5,out=o})
  assert(r==o,"ext reduction 148 out identity")
  assert(r.dtype=="float64","ext reduction 148 out dtype "..r.dtype)
  assert(close(r:tolist(),1.0),"ext reduction 148 out values")
end
do -- extended reduction 149: sum uint8 shape=[0, 2, 3, 4] axis=None
  local a=np.zeros({0,2,3,4},np.uint8)
  local r=np.sum(a,{axis=nil,keepdims=true,where=np.zeros({0,2,3,4},np.bool),initial=2})
  assert(r.dtype=="uint64","ext reduction 149 dtype "..r.dtype)
  assert(close(r.shape,{1,1,1,1}),"ext reduction 149 shape")
  assert(close(r.strides,{8,8,8,8}),"ext reduction 149 strides")
  assert(close(r:tolist(),{{{{2}}}}),"ext reduction 149 values")
end
do -- extended reduction 150: mean int32 shape=[0, 4, 4, 1] axis=None
  local a=np.zeros({0,4,4,1},np.int32)
  local r=np.mean(a,{axis=nil,keepdims=true,where=true})
  assert(r.dtype=="float64","ext reduction 150 dtype "..r.dtype)
  assert(close(r.shape,{1,1,1,1}),"ext reduction 150 shape")
  assert(close(r.strides,{8,8,8,8}),"ext reduction 150 strides")
  assert(close(r:tolist(),{{{{0/0}}}}),"ext reduction 150 values")
end
do -- extended reduction 151: sum float64 shape=[2, 4, 3] axis=(1,)
  local a=np.array({{{-1.375,-0.875,-0.375},{0.125,0.625,1.125},{1.625,-1.375,-0.875},{-0.375,0.125,0.625}},{{1.125,1.625,-1.375},{-0.875,-0.375,0.125},{0.625,1.125,1.625},{-1.375,-0.875,-0.375}}},np.float64)
  local r=np.sum(a,{axis={2},keepdims=false,where=np.array({{{true,true,false}}},np.bool),initial=3})
  assert(r.dtype=="float64","ext reduction 151 dtype "..r.dtype)
  assert(close(r.shape,{2,3}),"ext reduction 151 shape")
  assert(close(r.strides,{24,8}),"ext reduction 151 strides")
  assert(close(r:tolist(),{{3.0,1.5,3.0},{2.5,4.5,3.0}}),"ext reduction 151 values")
end
do -- extended reduction 152: prod uint8 shape=[0, 2] axis=None
  local a=np.zeros({0,2},np.uint8)
  local r=np.prod(a,{axis=nil,keepdims=false,where=np.array({true,false},np.bool),dtype=np.int16})
  assert(close(r,1),"ext reduction 152 scalar")
end
do -- extended reduction 153: prod uint8 shape=[2] axis=0
  local a=np.array({6,2},np.uint8)
  local r=np.prod(a,{axis=1,keepdims=true,where=np.array({false,true},np.bool)})
  assert(r.dtype=="uint64","ext reduction 153 dtype "..r.dtype)
  assert(close(r.shape,{1}),"ext reduction 153 shape")
  assert(close(r.strides,{8}),"ext reduction 153 strides")
  assert(close(r:tolist(),{2}),"ext reduction 153 values")
end
do -- extended reduction 154: mean bool shape=[1, 1, 4] axis=(2,)
  local a=(np.array({{{true}},{{true}},{{false}},{{true}}},np.bool)).T
  local o=np.zeros({1,1},np.float64)
  local r=np.mean(a,{axis={3},keepdims=false,where=np.array({{{true,true,false,true}}},np.bool),out=o})
  assert(r==o,"ext reduction 154 out identity")
  assert(r.dtype=="float64","ext reduction 154 out dtype "..r.dtype)
  assert(close(r:tolist(),{{1.0}}),"ext reduction 154 out values")
end
do -- extended reduction 155: sum float32 shape=[1, 2, 0] axis=0
  local a=np.zeros({1,2,0},np.float32)
  local r=np.sum(a,{axis=1,keepdims=true,where=np.zeros({1,2,0},np.bool),initial=-2})
  assert(r.dtype=="float32","ext reduction 155 dtype "..r.dtype)
  assert(close(r.shape,{1,2,0}),"ext reduction 155 shape")
  assert(close(r.strides,{0,0,0}),"ext reduction 155 strides")
  assert(close(r:tolist(),{{{},{}}}),"ext reduction 155 values")
end
do -- extended reduction 156: mean int8 shape=[2] axis=0
  local a=np.array({-3,2},np.int8)
  local o=np.zeros({1},np.float32)
  local r=np.mean(a,{axis=1,keepdims=true,where=np.array({false,true},np.bool),out=o})
  assert(r==o,"ext reduction 156 out identity")
  assert(r.dtype=="float32","ext reduction 156 out dtype "..r.dtype)
  assert(close(r:tolist(),{2.0}),"ext reduction 156 out values")
end
do -- extended reduction 157: prod int8 shape=[0, 0] axis=1
  local a=np.zeros({0,0},np.int8)
  local o=np.zeros({0},np.int64)
  local r=np.prod(a,{axis=2,keepdims=false,where=np.zeros({0,0},np.bool),initial=-1,out=o})
  assert(r==o,"ext reduction 157 out identity")
  assert(r.dtype=="int64","ext reduction 157 out dtype "..r.dtype)
  assert(close(r:tolist(),{}),"ext reduction 157 out values")
end
do -- extended reduction 158: prod float16 shape=[1, 0, 0, 4] axis=-3
  local a=np.zeros({1,0,0,4},np.float16)
  local o=np.zeros({1,1,0,4},np.float32)
  local r=np.prod(a,{axis=-3,keepdims=true,where=true,dtype=np.int16,out=o})
  assert(r==o,"ext reduction 158 out identity")
  assert(r.dtype=="float32","ext reduction 158 out dtype "..r.dtype)
  assert(close(r:tolist(),{{{}}}),"ext reduction 158 out values")
end
do -- extended reduction 159: sum uint8 shape=[3, 3, 3, 1] axis=None
  local a=np.array({{{{5},{1},{4}},{{0},{3},{6}},{{2},{5},{1}}},{{{4},{0},{3}},{{6},{2},{5}},{{1},{4},{0}}},{{{3},{6},{2}},{{5},{1},{4}},{{0},{3},{6}}}},np.uint8)
  local r=np.sum(a,{axis=nil,keepdims=false,where=np.array({false},np.bool),dtype=np.int32})
  assert(close(r,0),"ext reduction 159 scalar")
end
do -- extended reduction 160: sum uint64 shape=[0, 0, 3] axis=-1
  local a=np.zeros({0,0,3},np.uint64)
  local r=np.sum(a,{axis=-1,keepdims=false,where=false,dtype=np.float32})
  assert(r.dtype=="float32","ext reduction 160 dtype "..r.dtype)
  assert(close(r.shape,{0,0}),"ext reduction 160 shape")
  assert(close(r.strides,{0,0}),"ext reduction 160 strides")
  assert(close(r:tolist(),{}),"ext reduction 160 values")
end
do -- extended reduction 161: mean float64 shape=[3, 2] axis=1
  local a=np.array({{-1.25,-0.75},{-0.25,0.25},{0.75,1.25}},np.float64)
  local r=np.mean(a,{axis=2,keepdims=true,where=true})
  assert(r.dtype=="float64","ext reduction 161 dtype "..r.dtype)
  assert(close(r.shape,{3,1}),"ext reduction 161 shape")
  assert(close(r.strides,{8,8}),"ext reduction 161 strides")
  assert(close(r:tolist(),{{-1.0},{0.0},{1.0}}),"ext reduction 161 values")
end
do -- extended reduction 162: prod int16 shape=[0, 2, 0, 0] axis=(2, 3)
  local a=np.zeros({0,2,0,0},np.int16)
  local o=np.zeros({0,2,1,1},np.float32)
  local r=np.prod(a,{axis={3,4},keepdims=true,where=false,out=o})
  assert(r==o,"ext reduction 162 out identity")
  assert(r.dtype=="float32","ext reduction 162 out dtype "..r.dtype)
  assert(close(r:tolist(),{}),"ext reduction 162 out values")
end
do -- extended reduction 163: prod float64 shape=[3, 4, 2] axis=-1
  local a=np.array({{{-1.375,-0.875},{-0.375,0.125},{0.625,1.125},{1.625,-1.375}},{{-0.875,-0.375},{0.125,0.625},{1.125,1.625},{-1.375,-0.875}},{{-0.375,0.125},{0.625,1.125},{1.625,-1.375},{-0.875,-0.375}}},np.float64)
  local r=np.prod(a,{axis=-1,keepdims=false,where=np.array({{{true,true}}},np.bool)})
  assert(r.dtype=="float64","ext reduction 163 dtype "..r.dtype)
  assert(close(r.shape,{3,4}),"ext reduction 163 shape")
  assert(close(r.strides,{32,8}),"ext reduction 163 strides")
  assert(close(r:tolist(),{{1.203125,-0.046875,0.703125,-2.234375},{0.328125,0.078125,1.828125,1.203125},{-0.046875,0.703125,-2.234375,0.328125}}),"ext reduction 163 values")
end
do -- extended reduction 164: prod bool shape=[1, 0, 1] axis=1
  local a=np.zeros({1,0,1},np.bool)
  local r=np.prod(a,{axis=2,keepdims=true,where=np.zeros({1,0,1},np.bool)})
  assert(r.dtype=="int64","ext reduction 164 dtype "..r.dtype)
  assert(close(r.shape,{1,1,1}),"ext reduction 164 shape")
  assert(close(r.strides,{8,8,8}),"ext reduction 164 strides")
  assert(close(r:tolist(),{{{1}}}),"ext reduction 164 values")
end
do -- extended reduction 165: sum float16 shape=[3, 4, 0, 1] axis=-2
  local a=np.zeros({3,4,0,1},np.float16)
  local r=np.sum(a,{axis=-2,keepdims=true,where=true})
  assert(r.dtype=="float16","ext reduction 165 dtype "..r.dtype)
  assert(close(r.shape,{3,4,1,1}),"ext reduction 165 shape")
  assert(close(r.strides,{8,2,2,2}),"ext reduction 165 strides")
  assert(close(r:tolist(),{{{{0.0}},{{0.0}},{{0.0}},{{0.0}}},{{{0.0}},{{0.0}},{{0.0}},{{0.0}}},{{{0.0}},{{0.0}},{{0.0}},{{0.0}}}}),"ext reduction 165 values")
end
do -- extended reduction 166: mean float64 shape=[3, 3, 2, 3] axis=2
  local a=np.array({{{{-1.375,-0.875,-0.375},{0.125,0.625,1.125}},{{1.625,-1.375,-0.875},{-0.375,0.125,0.625}},{{1.125,1.625,-1.375},{-0.875,-0.375,0.125}}},{{{0.625,1.125,1.625},{-1.375,-0.875,-0.375}},{{0.125,0.625,1.125},{1.625,-1.375,-0.875}},{{-0.375,0.125,0.625},{1.125,1.625,-1.375}}},{{{-0.875,-0.375,0.125},{0.625,1.125,1.625}},{{-1.375,-0.875,-0.375},{0.125,0.625,1.125}},{{1.625,-1.375,-0.875},{-0.375,0.125,0.625}}}},np.float64)
  local r=np.mean(a,{axis=3,keepdims=false,where=true,dtype=np.float64})
  assert(r.dtype=="float64","ext reduction 166 dtype "..r.dtype)
  assert(close(r.shape,{3,3,3}),"ext reduction 166 shape")
  assert(close(r.strides,{72,24,8}),"ext reduction 166 strides")
  assert(close(r:tolist(),{{{-0.625,-0.125,0.375},{0.625,-0.625,-0.125},{0.125,0.625,-0.625}},{{-0.375,0.125,0.625},{0.875,-0.375,0.125},{0.375,0.875,-0.375}},{{-0.125,0.375,0.875},{-0.625,-0.125,0.375},{0.625,-0.625,-0.125}}}),"ext reduction 166 values")
end
do -- extended reduction 167: prod uint8 shape=[3, 1] axis=-2
  local a=np.array({{6},{2},{5}},np.uint8)
  local r=np.prod(a,{axis=-2,keepdims=true,where=np.array({true},np.bool),dtype=np.uint64})
  assert(r.dtype=="uint64","ext reduction 167 dtype "..r.dtype)
  assert(close(r.shape,{1,1}),"ext reduction 167 shape")
  assert(close(r.strides,{8,8}),"ext reduction 167 strides")
  assert(close(r:tolist(),{{60}}),"ext reduction 167 values")
end
do -- extended reduction 168: mean float64 shape=[1, 0, 3, 0] axis=0
  local a=np.zeros({1,0,3,0},np.float64)
  local r=np.mean(a,{axis=1,keepdims=false,where=np.zeros({1,1,1,0},np.bool)})
  assert(r.dtype=="float64","ext reduction 168 dtype "..r.dtype)
  assert(close(r.shape,{0,3,0}),"ext reduction 168 shape")
  assert(close(r.strides,{0,0,0}),"ext reduction 168 strides")
  assert(close(r:tolist(),{}),"ext reduction 168 values")
end
do -- extended reduction 169: prod bool shape=[2, 2, 2] axis=0
  local a=(np.array({{{true,true},{false,true}},{{true,true},{true,false}}},np.bool)).T
  local o=np.zeros({2,2},np.float32)
  local r=np.prod(a,{axis=1,keepdims=false,where=false,out=o})
  assert(r==o,"ext reduction 169 out identity")
  assert(r.dtype=="float32","ext reduction 169 out dtype "..r.dtype)
  assert(close(r:tolist(),{{1.0,1.0},{1.0,1.0}}),"ext reduction 169 out values")
end
do -- extended reduction 170: prod float64 shape=[3, 4, 4, 3] axis=1
  local a=np.array({{{{-1.25,-0.75,-0.25},{0.25,0.75,1.25},{1.75,-1.25,-0.75},{-0.25,0.25,0.75}},{{1.25,1.75,-1.25},{-0.75,-0.25,0.25},{0.75,1.25,1.75},{-1.25,-0.75,-0.25}},{{0.25,0.75,1.25},{1.75,-1.25,-0.75},{-0.25,0.25,0.75},{1.25,1.75,-1.25}},{{-0.75,-0.25,0.25},{0.75,1.25,1.75},{-1.25,-0.75,-0.25},{0.25,0.75,1.25}}},{{{1.75,-1.25,-0.75},{-0.25,0.25,0.75},{1.25,1.75,-1.25},{-0.75,-0.25,0.25}},{{0.75,1.25,1.75},{-1.25,-0.75,-0.25},{0.25,0.75,1.25},{1.75,-1.25,-0.75}},{{-0.25,0.25,0.75},{1.25,1.75,-1.25},{-0.75,-0.25,0.25},{0.75,1.25,1.75}},{{-1.25,-0.75,-0.25},{0.25,0.75,1.25},{1.75,-1.25,-0.75},{-0.25,0.25,0.75}}},{{{1.25,1.75,-1.25},{-0.75,-0.25,0.25},{0.75,1.25,1.75},{-1.25,-0.75,-0.25}},{{0.25,0.75,1.25},{1.75,-1.25,-0.75},{-0.25,0.25,0.75},{1.25,1.75,-1.25}},{{-0.75,-0.25,0.25},{0.75,1.25,1.75},{-1.25,-0.75,-0.25},{0.25,0.75,1.25}},{{1.75,-1.25,-0.75},{-0.25,0.25,0.75},{1.25,1.75,-1.25},{-0.75,-0.25,0.25}}}},np.float64)
  local r=np.prod(a,{axis=2,keepdims=true,where=np.array({{{{true,false,true},{true,false,true},{true,false,true},{true,false,true}},{{true,false,true},{true,false,true},{true,false,true},{true,false,true}},{{true,false,true},{true,false,true},{true,false,true},{true,false,true}},{{true,false,true},{true,false,true},{true,false,true},{true,false,true}}},{{{true,false,true},{true,false,true},{true,false,true},{true,false,true}},{{true,false,true},{true,false,true},{true,false,true},{true,false,true}},{{true,false,true},{true,false,true},{true,false,true},{true,false,true}},{{true,false,true},{true,false,true},{true,false,true},{true,false,true}}},{{{true,false,true},{true,false,true},{true,false,true},{true,false,true}},{{true,false,true},{true,false,true},{true,false,true},{true,false,true}},{{true,false,true},{true,false,true},{true,false,true},{true,false,true}},{{true,false,true},{true,false,true},{true,false,true},{true,false,true}}}},np.bool)})
  assert(r.dtype=="float64","ext reduction 170 dtype "..r.dtype)
  assert(close(r.shape,{3,1,4,3}),"ext reduction 170 shape")
  assert(close(r.strides,{96,96,24,8}),"ext reduction 170 strides")
  assert(close(r:tolist(),{{{{0.29296875,1.0,0.09765625},{-0.24609375,1.0,-0.41015625},{0.41015625,1.0,0.24609375},{0.09765625,1.0,0.29296875}}},{{{0.41015625,1.0,0.24609375},{0.09765625,1.0,0.29296875},{-0.41015625,1.0,0.29296875},{0.24609375,1.0,-0.24609375}}},{{{-0.41015625,1.0,0.29296875},{0.24609375,1.0,-0.24609375},{0.29296875,1.0,0.41015625},{0.29296875,1.0,0.09765625}}}}),"ext reduction 170 values")
end
do -- extended reduction 171: sum float32 shape=[1] axis=-1
  local a=np.array({-1.5},np.float32)
  local r=np.sum(a,{axis=-1,keepdims=true,where=false,dtype=np.float64,initial=0})
  assert(r.dtype=="float64","ext reduction 171 dtype "..r.dtype)
  assert(close(r.shape,{1}),"ext reduction 171 shape")
  assert(close(r.strides,{8}),"ext reduction 171 strides")
  assert(close(r:tolist(),{0.0}),"ext reduction 171 values")
end
do -- extended reduction 172: mean int16 shape=[1, 1, 4, 3] axis=(0, 1, 2, 3)
  local a=np.array({{{{2,-4,1},{-5,0,5},{-1,4,-2},{3,-3,2}}}},np.int16)
  local r=np.mean(a,{axis={1,2,3,4},keepdims=true,where=np.array({{{{true,true,false},{true,true,false},{true,true,false},{true,true,false}}}},np.bool)})
  assert(r.dtype=="float64","ext reduction 172 dtype "..r.dtype)
  assert(close(r.shape,{1,1,1,1}),"ext reduction 172 shape")
  assert(close(r.strides,{8,8,8,8}),"ext reduction 172 strides")
  assert(close(r:tolist(),{{{{-0.5}}}}),"ext reduction 172 values")
end
do -- extended reduction 173: sum int32 shape=[0, 4, 2] axis=(0, 1, 2)
  local a=np.zeros({0,4,2},np.int32)
  local o=np.zeros({},np.int16)
  local r=np.sum(a,{axis={1,2,3},keepdims=false,where=true,out=o})
  assert(r==o,"ext reduction 173 out identity")
  assert(r.dtype=="int16","ext reduction 173 out dtype "..r.dtype)
  assert(close(r:tolist(),0),"ext reduction 173 out values")
end
do -- extended reduction 174: mean uint16 shape=[2, 2, 2, 4] axis=-4
  local a=(np.array({{{{6,2},{5,1}},{{4,0},{3,6}}},{{{2,5},{1,4}},{{0,3},{6,2}}},{{{5,1},{4,0}},{{3,6},{2,5}}},{{{1,4},{0,3}},{{6,2},{5,1}}}},np.uint16)).T
  local r=np.mean(a,{axis=-4,keepdims=false,where=true})
  assert(r.dtype=="float64","ext reduction 174 dtype "..r.dtype)
  assert(close(r.shape,{2,2,4}),"ext reduction 174 shape")
  assert(close(r.strides,{8,16,32}),"ext reduction 174 strides")
  assert(close(r:tolist(),{{{4.0,3.5,3.0,2.5},{2.0,1.5,4.5,4.0}},{{3.0,2.5,2.0,1.5},{4.5,4.0,3.5,3.0}}}),"ext reduction 174 values")
end
do -- extended reduction 175: prod float64 shape=[2, 1] axis=()
  local a=np.array({{-1.375},{-0.875}},np.float64)
  local r=np.prod(a,{axis={},keepdims=true,where=true,initial=-1})
  assert(r.dtype=="float64","ext reduction 175 dtype "..r.dtype)
  assert(close(r.shape,{2,1}),"ext reduction 175 shape")
  assert(close(r.strides,{8,8}),"ext reduction 175 strides")
  assert(close(r:tolist(),{{1.375},{0.875}}),"ext reduction 175 values")
end
do -- extended reduction 176: sum float64 shape=[3, 2, 4, 1] axis=-4
  local a=np.array({{{{-1.25},{-0.75},{-0.25},{0.25}},{{0.75},{1.25},{1.75},{-1.25}}},{{{-0.75},{-0.25},{0.25},{0.75}},{{1.25},{1.75},{-1.25},{-0.75}}},{{{-0.25},{0.25},{0.75},{1.25}},{{1.75},{-1.25},{-0.75},{-0.25}}}},np.float64)
  local o=np.zeros({2,4,1},np.int8)
  local r=np.sum(a,{axis=-4,keepdims=false,where=false,out=o})
  assert(r==o,"ext reduction 176 out identity")
  assert(r.dtype=="int8","ext reduction 176 out dtype "..r.dtype)
  assert(close(r:tolist(),{{{0},{0},{0},{0}},{{0},{0},{0},{0}}}),"ext reduction 176 out values")
end
do -- extended reduction 177: mean float16 shape=[0, 3, 1, 4] axis=()
  local a=np.zeros({0,3,1,4},np.float16)
  local r=np.mean(a,{axis={},keepdims=false,where=true})
  assert(r.dtype=="float16","ext reduction 177 dtype "..r.dtype)
  assert(close(r.shape,{0,3,1,4}),"ext reduction 177 shape")
  assert(close(r.strides,{0,0,0,0}),"ext reduction 177 strides")
  assert(close(r:tolist(),{}),"ext reduction 177 values")
end
do -- extended reduction 178: mean float32 shape=[2] axis=-1
  local a=np.array({-1.375,-0.875},np.float32)
  local o=np.zeros({},np.float64)
  local r=np.mean(a,{axis=-1,keepdims=false,where=np.array({true,true},np.bool),out=o})
  assert(r==o,"ext reduction 178 out identity")
  assert(r.dtype=="float64","ext reduction 178 out dtype "..r.dtype)
  assert(close(r:tolist(),-1.125),"ext reduction 178 out values")
end
do -- extended reduction 179: prod float64 shape=[0, 1] axis=-2
  local a=np.zeros({0,1},np.float64)
  local r=np.prod(a,{axis=-2,keepdims=false,where=np.array({true},np.bool),initial=3})
  assert(r.dtype=="float64","ext reduction 179 dtype "..r.dtype)
  assert(close(r.shape,{1}),"ext reduction 179 shape")
  assert(close(r.strides,{8}),"ext reduction 179 strides")
  assert(close(r:tolist(),{3.0}),"ext reduction 179 values")
end
do -- extended reduction 180: prod uint32 shape=[3, 0, 0, 0] axis=(-4, -3, 2, -1)
  local a=np.zeros({3,0,0,0},np.uint32)
  local o=np.zeros({1,1,1,1},np.float64)
  local r=np.prod(a,{axis={-4,-3,3,-1},keepdims=true,where=np.zeros({1,1,1,0},np.bool),out=o})
  assert(r==o,"ext reduction 180 out identity")
  assert(r.dtype=="float64","ext reduction 180 out dtype "..r.dtype)
  assert(close(r:tolist(),{{{{1.0}}}}),"ext reduction 180 out values")
end
do -- extended reduction 181: sum float32 shape=[2, 0, 3, 3] axis=3
  local a=np.zeros({2,0,3,3},np.float32)
  local r=np.sum(a,{axis=4,keepdims=true,where=np.array({{{{true,true,false}}}},np.bool)})
  assert(r.dtype=="float32","ext reduction 181 dtype "..r.dtype)
  assert(close(r.shape,{2,0,3,1}),"ext reduction 181 shape")
  assert(close(r.strides,{0,0,0,0}),"ext reduction 181 strides")
  assert(close(r:tolist(),{{},{}}),"ext reduction 181 values")
end
do -- extended reduction 182: mean int32 shape=[3, 2] axis=(0,)
  local a=(np.array({{1,-5,0},{5,-1,4}},np.int32)).T
  local r=np.mean(a,{axis={1},keepdims=true,where=false})
  assert(r.dtype=="float64","ext reduction 182 dtype "..r.dtype)
  assert(close(r.shape,{1,2}),"ext reduction 182 shape")
  assert(close(r.strides,{8,8}),"ext reduction 182 strides")
  assert(close(r:tolist(),{{0/0,0/0}}),"ext reduction 182 values")
end
do -- extended reduction 183: sum uint32 shape=[0] axis=(-1,)
  local a=np.zeros({0},np.uint32)
  local r=np.sum(a,{axis={-1},keepdims=false,where=np.zeros({0},np.bool),dtype=np.int16,initial=-1})
  assert(close(r,-1),"ext reduction 183 scalar")
end
do -- extended reduction 184: sum int16 shape=[4] axis=()
  local a=np.array({3,-3,2,-4},np.int16)
  local o=np.zeros({4},np.int16)
  local r=np.sum(a,{axis={},keepdims=false,where=np.array({true,true,false,true},np.bool),out=o})
  assert(r==o,"ext reduction 184 out identity")
  assert(r.dtype=="int16","ext reduction 184 out dtype "..r.dtype)
  assert(close(r:tolist(),{3,-3,0,-4}),"ext reduction 184 out values")
end
do -- extended reduction 185: sum int16 shape=[4, 3, 1] axis=(0, 1)
  local a=np.array({{{4},{-2},{3}},{{-3},{2},{-4}},{{1},{-5},{0}},{{5},{-1},{4}}},np.int16)
  local r=np.sum(a,{axis={1,2},keepdims=false,where=np.array({{{true},{false},{true}},{{true},{false},{true}},{{true},{false},{true}},{{true},{false},{true}}},np.bool),initial=1})
  assert(r.dtype=="int64","ext reduction 185 dtype "..r.dtype)
  assert(close(r.shape,{1}),"ext reduction 185 shape")
  assert(close(r.strides,{8}),"ext reduction 185 strides")
  assert(close(r:tolist(),{11}),"ext reduction 185 values")
end
do -- extended reduction 186: mean bool shape=[4, 2] axis=1
  local a=np.array({{true,true},{true,false},{true,true},{true,true}},np.bool)
  local o=np.zeros({4,1},np.float64)
  local r=np.mean(a,{axis=2,keepdims=true,where=np.array({false,true},np.bool),out=o})
  assert(r==o,"ext reduction 186 out identity")
  assert(r.dtype=="float64","ext reduction 186 out dtype "..r.dtype)
  assert(close(r:tolist(),{{1.0},{0.0},{1.0},{1.0}}),"ext reduction 186 out values")
end
do -- extended reduction 187: prod int64 shape=[2, 0] axis=0
  local a=np.zeros({2,0},np.int64)
  local r=np.prod(a,{axis=1,keepdims=false,where=np.zeros({1,0},np.bool),initial=-1})
  assert(r.dtype=="int64","ext reduction 187 dtype "..r.dtype)
  assert(close(r.shape,{0}),"ext reduction 187 shape")
  assert(close(r.strides,{0}),"ext reduction 187 strides")
  assert(close(r:tolist(),{}),"ext reduction 187 values")
end
do -- extended reduction 188: sum int8 shape=[4, 2] axis=(-2, -1)
  local a=np.array({{-4,1},{-5,0},{5,-1},{4,-2}},np.int8)
  local r=np.sum(a,{axis={-2,-1},keepdims=true,where=true,initial=2})
  assert(r.dtype=="int64","ext reduction 188 dtype "..r.dtype)
  assert(close(r.shape,{1,1}),"ext reduction 188 shape")
  assert(close(r.strides,{8,8}),"ext reduction 188 strides")
  assert(close(r:tolist(),{{0}}),"ext reduction 188 values")
end
do -- extended reduction 189: prod int32 shape=[4] axis=None
  local a=np.array({-3,2,-4,1},np.int32)
  local o=np.zeros({1},np.int8)
  local r=np.prod(a,{axis=nil,keepdims=true,where=np.array({false,true,true,false},np.bool),out=o})
  assert(r==o,"ext reduction 189 out identity")
  assert(r.dtype=="int8","ext reduction 189 out dtype "..r.dtype)
  assert(close(r:tolist(),{-8}),"ext reduction 189 out values")
end
do -- extended reduction 190: prod uint8 shape=[2, 0] axis=(1,)
  local a=np.zeros({2,0},np.uint8)
  local r=np.prod(a,{axis={2},keepdims=false,where=np.zeros({1,0},np.bool),dtype=np.bool,initial=1.5})
  assert(r.dtype=="bool","ext reduction 190 dtype "..r.dtype)
  assert(close(r.shape,{2}),"ext reduction 190 shape")
  assert(close(r.strides,{1}),"ext reduction 190 strides")
  assert(close(r:tolist(),{true,true}),"ext reduction 190 values")
end
do -- extended reduction 191: sum bool shape=[1] axis=None
  local a=np.array({true},np.bool)
  local o=np.zeros({1},np.float64)
  local r=np.sum(a,{axis=nil,keepdims=true,where=np.array({true},np.bool),out=o})
  assert(r==o,"ext reduction 191 out identity")
  assert(r.dtype=="float64","ext reduction 191 out dtype "..r.dtype)
  assert(close(r:tolist(),{1.0}),"ext reduction 191 out values")
end
do -- extended reduction 192: mean uint16 shape=[1, 0] axis=-1
  local a=np.zeros({1,0},np.uint16)
  local o=np.zeros({1,1},np.float32)
  local r=np.mean(a,{axis=-1,keepdims=true,where=true,dtype=np.float32,out=o})
  assert(r==o,"ext reduction 192 out identity")
  assert(r.dtype=="float32","ext reduction 192 out dtype "..r.dtype)
  assert(close(r:tolist(),{{0/0}}),"ext reduction 192 out values")
end
do -- extended reduction 193: sum bool shape=[4, 4, 0] axis=2
  local a=np.zeros({4,4,0},np.bool)
  local o=np.zeros({4,4,1},np.int8)
  local r=np.sum(a,{axis=3,keepdims=true,where=false,out=o})
  assert(r==o,"ext reduction 193 out identity")
  assert(r.dtype=="int8","ext reduction 193 out dtype "..r.dtype)
  assert(close(r:tolist(),{{{0},{0},{0},{0}},{{0},{0},{0},{0}},{{0},{0},{0},{0}},{{0},{0},{0},{0}}}),"ext reduction 193 out values")
end
do -- extended reduction 194: sum uint64 shape=[1] axis=()
  local a=np.array({5},np.uint64)
  local r=np.sum(a,{axis={},keepdims=false,where=np.array({true},np.bool),dtype=np.float32,initial=2})
  assert(r.dtype=="float32","ext reduction 194 dtype "..r.dtype)
  assert(close(r.shape,{1}),"ext reduction 194 shape")
  assert(close(r.strides,{4}),"ext reduction 194 strides")
  assert(close(r:tolist(),{7.0}),"ext reduction 194 values")
end
do -- extended reduction 195: prod bool shape=[3, 2] axis=None
  local a=np.array({{false,true},{true,true},{true,false}},np.bool)
  local r=np.prod(a,{axis=nil,keepdims=false,where=np.array({{false,true},{true,false},{true,true}},np.bool),initial=3})
  assert(close(r,0),"ext reduction 195 scalar")
end
do -- extended reduction 196: prod uint64 shape=[1] axis=0
  local a=np.array({0},np.uint64)
  local r=np.prod(a,{axis=1,keepdims=false,where=true})
  assert(close(r,0),"ext reduction 196 scalar")
end
do -- extended reduction 197: sum bool shape=[2, 0, 1] axis=None
  local a=np.zeros({2,0,1},np.bool)
  local r=np.sum(a,{axis=nil,keepdims=false,where=np.zeros({2,0,1},np.bool),dtype=np.uint64})
  assert(close(r,0),"ext reduction 197 scalar")
end
do -- extended reduction 198: mean int64 shape=[2, 0, 2] axis=(1, 2)
  local a=np.zeros({2,0,2},np.int64)
  local r=np.mean(a,{axis={2,3},keepdims=false,where=false,dtype=np.float16})
  assert(r.dtype=="float16","ext reduction 198 dtype "..r.dtype)
  assert(close(r.shape,{2}),"ext reduction 198 shape")
  assert(close(r.strides,{2}),"ext reduction 198 strides")
  assert(close(r:tolist(),{0/0,0/0}),"ext reduction 198 values")
end
do -- extended reduction 199: sum float64 shape=[4] axis=()
  local a=np.array({-1.375,-0.875,-0.375,0.125},np.float64)
  local r=np.sum(a,{axis={},keepdims=true,where=false})
  assert(r.dtype=="float64","ext reduction 199 dtype "..r.dtype)
  assert(close(r.shape,{4}),"ext reduction 199 shape")
  assert(close(r.strides,{8}),"ext reduction 199 strides")
  assert(close(r:tolist(),{0.0,0.0,0.0,0.0}),"ext reduction 199 values")
end
do -- extended reduction 200: sum uint16 shape=[1, 4] axis=(1,)
  local a=np.array({{4,0,3,6}},np.uint16)
  local o=np.zeros({1,1},np.float64)
  local r=np.sum(a,{axis={2},keepdims=true,where=false,out=o})
  assert(r==o,"ext reduction 200 out identity")
  assert(r.dtype=="float64","ext reduction 200 out dtype "..r.dtype)
  assert(close(r:tolist(),{{0.0}}),"ext reduction 200 out values")
end
do -- extended reduction 201: sum int64 shape=[1, 2, 3, 4] axis=3
  local a=np.array({{{{-2,3,-3,2},{-4,1,-5,0},{5,-1,4,-2}},{{3,-3,2,-4},{1,-5,0,5},{-1,4,-2,3}}}},np.int64)
  local o=np.zeros({1,2,3,1},np.float32)
  local r=np.sum(a,{axis=4,keepdims=true,where=true,initial=1.5,out=o})
  assert(r==o,"ext reduction 201 out identity")
  assert(r.dtype=="float32","ext reduction 201 out dtype "..r.dtype)
  assert(close(r:tolist(),{{{{1.5},{-6.5},{7.5}},{{-0.5},{2.5},{5.5}}}}),"ext reduction 201 out values")
end
do -- extended reduction 202: sum int16 shape=[2, 4, 2, 2] axis=(1, -2, -1)
  local a=np.array({{{{-1,4},{-2,3}},{{-3,2},{-4,1}},{{-5,0},{5,-1}},{{4,-2},{3,-3}}},{{{2,-4},{1,-5}},{{0,5},{-1,4}},{{-2,3},{-3,2}},{{-4,1},{-5,0}}}},np.int16)
  local r=np.sum(a,{axis={2,-2,-1},keepdims=true,where=false,dtype=np.uint8})
  assert(r.dtype=="uint8","ext reduction 202 dtype "..r.dtype)
  assert(close(r.shape,{2,1,1,1}),"ext reduction 202 shape")
  assert(close(r.strides,{1,1,1,1}),"ext reduction 202 strides")
  assert(close(r:tolist(),{{{{0}}},{{{0}}}}),"ext reduction 202 values")
end
do -- extended reduction 203: prod uint8 shape=[2] axis=()
  local a=np.array({0,3},np.uint8)
  local r=np.prod(a,{axis={},keepdims=true,where=np.array({true,false},np.bool),initial=1})
  assert(r.dtype=="uint64","ext reduction 203 dtype "..r.dtype)
  assert(close(r.shape,{2}),"ext reduction 203 shape")
  assert(close(r.strides,{8}),"ext reduction 203 strides")
  assert(close(r:tolist(),{0,1}),"ext reduction 203 values")
end
do -- extended reduction 204: sum int64 shape=[4, 0] axis=0
  local a=np.zeros({4,0},np.int64)
  local r=np.sum(a,{axis=1,keepdims=false,where=true})
  assert(r.dtype=="int64","ext reduction 204 dtype "..r.dtype)
  assert(close(r.shape,{0}),"ext reduction 204 shape")
  assert(close(r.strides,{0}),"ext reduction 204 strides")
  assert(close(r:tolist(),{}),"ext reduction 204 values")
end
do -- extended reduction 205: prod float16 shape=[4, 1, 4, 4] axis=(1, 2)
  local a=np.array({{{{-1.375,-0.875,-0.375,0.125},{0.625,1.125,1.625,-1.375},{-0.875,-0.375,0.125,0.625},{1.125,1.625,-1.375,-0.875}}},{{{-0.375,0.125,0.625,1.125},{1.625,-1.375,-0.875,-0.375},{0.125,0.625,1.125,1.625},{-1.375,-0.875,-0.375,0.125}}},{{{0.625,1.125,1.625,-1.375},{-0.875,-0.375,0.125,0.625},{1.125,1.625,-1.375,-0.875},{-0.375,0.125,0.625,1.125}}},{{{1.625,-1.375,-0.875,-0.375},{0.125,0.625,1.125,1.625},{-1.375,-0.875,-0.375,0.125},{0.625,1.125,1.625,-1.375}}}},np.float16)
  local r=np.prod(a,{axis={2,3},keepdims=true,where=np.array({{{{true,true,false,true}}}},np.bool),dtype=np.uint16})
  assert(r.dtype=="uint16","ext reduction 205 dtype "..r.dtype)
  assert(close(r.shape,{4,1,1,4}),"ext reduction 205 shape")
  assert(close(r.strides,{8,8,8,2}),"ext reduction 205 strides")
  assert(close(r:tolist(),{{{{0,0,1,0}}},{{{0,0,1,0}}},{{{0,0,1,0}}},{{{0,0,1,0}}}}),"ext reduction 205 values")
end
do -- extended reduction 206: sum int32 shape=[1] axis=(0,)
  local a=np.array({3},np.int32)
  local r=np.sum(a,{axis={1},keepdims=true,where=np.array({true},np.bool)})
  assert(r.dtype=="int64","ext reduction 206 dtype "..r.dtype)
  assert(close(r.shape,{1}),"ext reduction 206 shape")
  assert(close(r.strides,{8}),"ext reduction 206 strides")
  assert(close(r:tolist(),{3}),"ext reduction 206 values")
end
do -- extended reduction 207: prod uint64 shape=[1, 3, 4, 3] axis=(0, 1, 2)
  local a=np.array({{{{4,0,3},{6,2,5},{1,4,0},{3,6,2}},{{5,1,4},{0,3,6},{2,5,1},{4,0,3}},{{6,2,5},{1,4,0},{3,6,2},{5,1,4}}}},np.uint64)
  local r=np.prod(a,{axis={1,2,3},keepdims=true,where=true})
  assert(r.dtype=="uint64","ext reduction 207 dtype "..r.dtype)
  assert(close(r.shape,{1,1,1,3}),"ext reduction 207 shape")
  assert(close(r.strides,{24,24,24,8}),"ext reduction 207 strides")
  assert(close(r:tolist(),{{{{0,0,0}}}}),"ext reduction 207 values")
end
do -- extended reduction 208: mean int32 shape=[0, 1] axis=-2
  local a=np.zeros({0,1},np.int32)
  local r=np.mean(a,{axis=-2,keepdims=false,where=np.array({{true}},np.bool)})
  assert(r.dtype=="float64","ext reduction 208 dtype "..r.dtype)
  assert(close(r.shape,{1}),"ext reduction 208 shape")
  assert(close(r.strides,{8}),"ext reduction 208 strides")
  assert(close(r:tolist(),{0/0}),"ext reduction 208 values")
end
do -- extended reduction 209: mean float32 shape=[3, 2, 1, 0] axis=None
  local a=np.zeros({3,2,1,0},np.float32)
  local r=np.mean(a,{axis=nil,keepdims=true,where=np.zeros({0},np.bool)})
  assert(r.dtype=="float32","ext reduction 209 dtype "..r.dtype)
  assert(close(r.shape,{1,1,1,1}),"ext reduction 209 shape")
  assert(close(r.strides,{4,4,4,4}),"ext reduction 209 strides")
  assert(close(r:tolist(),{{{{0/0}}}}),"ext reduction 209 values")
end
do -- extended reduction 210: prod int16 shape=[4, 3, 4, 1] axis=(0, 1, 2, 3)
  local a=np.array({{{{-4},{1},{-5},{0}},{{5},{-1},{4},{-2}},{{3},{-3},{2},{-4}}},{{{1},{-5},{0},{5}},{{-1},{4},{-2},{3}},{{-3},{2},{-4},{1}}},{{{-5},{0},{5},{-1}},{{4},{-2},{3},{-3}},{{2},{-4},{1},{-5}}},{{{0},{5},{-1},{4}},{{-2},{3},{-3},{2}},{{-4},{1},{-5},{0}}}},np.int16)
  local r=np.prod(a,{axis={1,2,3,4},keepdims=true,where=false,initial=3})
  assert(r.dtype=="int64","ext reduction 210 dtype "..r.dtype)
  assert(close(r.shape,{1,1,1,1}),"ext reduction 210 shape")
  assert(close(r.strides,{8,8,8,8}),"ext reduction 210 strides")
  assert(close(r:tolist(),{{{{3}}}}),"ext reduction 210 values")
end
do -- extended reduction 211: mean int8 shape=[3] axis=None
  local a=np.array({-3,2,-4},np.int8)
  local r=np.mean(a,{axis=nil,keepdims=false,where=np.array({true,true,false},np.bool)})
  assert(close(r,-0.5),"ext reduction 211 scalar")
end
do -- extended reduction 212: mean int32 shape=[3, 4] axis=None
  local a=np.array({{-2,3,-3,2},{-4,1,-5,0},{5,-1,4,-2}},np.int32)
  local o=np.zeros({1,1},np.float64)
  local r=np.mean(a,{axis=nil,keepdims=true,where=np.array({true,false,true,true},np.bool),dtype=np.float32,out=o})
  assert(r==o,"ext reduction 212 out identity")
  assert(r.dtype=="float64","ext reduction 212 out dtype "..r.dtype)
  assert(close(r:tolist(),{{-0.5555555555555556}}),"ext reduction 212 out values")
end
do -- extended reduction 213: sum float64 shape=[0, 0] axis=0
  local a=np.zeros({0,0},np.float64)
  local r=np.sum(a,{axis=1,keepdims=false,where=np.zeros({1,0},np.bool)})
  assert(r.dtype=="float64","ext reduction 213 dtype "..r.dtype)
  assert(close(r.shape,{0}),"ext reduction 213 shape")
  assert(close(r.strides,{0}),"ext reduction 213 strides")
  assert(close(r:tolist(),{}),"ext reduction 213 values")
end
do -- extended reduction 214: mean float16 shape=[2, 1] axis=()
  local a=np.array({{-1.375},{-0.875}},np.float16)
  local r=np.mean(a,{axis={},keepdims=false,where=np.array({{true},{true}},np.bool)})
  assert(r.dtype=="float16","ext reduction 214 dtype "..r.dtype)
  assert(close(r.shape,{2,1}),"ext reduction 214 shape")
  assert(close(r.strides,{2,2}),"ext reduction 214 strides")
  assert(close(r:tolist(),{{-1.375},{-0.875}}),"ext reduction 214 values")
end
do -- extended reduction 215: sum uint32 shape=[1, 2, 4] axis=()
  local a=np.array({{{5,1,4,0},{3,6,2,5}}},np.uint32)
  local o=np.zeros({1,2,4},np.int64)
  local r=np.sum(a,{axis={},keepdims=true,where=np.array({{{true,false,true,true}}},np.bool),out=o})
  assert(r==o,"ext reduction 215 out identity")
  assert(r.dtype=="int64","ext reduction 215 out dtype "..r.dtype)
  assert(close(r:tolist(),{{{5,0,4,0},{3,0,2,5}}}),"ext reduction 215 out values")
end
do -- extended reduction 216: mean float64 shape=[2, 3, 2] axis=-3
  local a=np.array({{{-1.5,-1.0},{-0.5,0.0},{0.5,1.0}},{{1.5,-1.5},{-1.0,-0.5},{0.0,0.5}}},np.float64)
  local r=np.mean(a,{axis=-3,keepdims=false,where=false})
  assert(r.dtype=="float64","ext reduction 216 dtype "..r.dtype)
  assert(close(r.shape,{3,2}),"ext reduction 216 shape")
  assert(close(r.strides,{16,8}),"ext reduction 216 strides")
  assert(close(r:tolist(),{{0/0,0/0},{0/0,0/0},{0/0,0/0}}),"ext reduction 216 values")
end
do -- extended reduction 217: sum int32 shape=[3, 0, 0, 4] axis=-4
  local a=np.zeros({3,0,0,4},np.int32)
  local r=np.sum(a,{axis=-4,keepdims=false,where=np.array({true,true,false,true},np.bool)})
  assert(r.dtype=="int64","ext reduction 217 dtype "..r.dtype)
  assert(close(r.shape,{0,0,4}),"ext reduction 217 shape")
  assert(close(r.strides,{0,0,0}),"ext reduction 217 strides")
  assert(close(r:tolist(),{}),"ext reduction 217 values")
end
do -- extended reduction 218: prod float64 shape=[3] axis=()
  local a=np.array({-1.25,-0.75,-0.25},np.float64)
  local r=np.prod(a,{axis={},keepdims=true,where=true})
  assert(r.dtype=="float64","ext reduction 218 dtype "..r.dtype)
  assert(close(r.shape,{3}),"ext reduction 218 shape")
  assert(close(r.strides,{8}),"ext reduction 218 strides")
  assert(close(r:tolist(),{-1.25,-0.75,-0.25}),"ext reduction 218 values")
end
do -- extended reduction 219: prod float32 shape=[4, 4] axis=None
  local a=np.array({{-1.5,-1.0,-0.5,0.0},{0.5,1.0,1.5,-1.5},{-1.0,-0.5,0.0,0.5},{1.0,1.5,-1.5,-1.0}},np.float32)
  local o=np.zeros({1,1},np.float32)
  local r=np.prod(a,{axis=nil,keepdims=true,where=np.array({{false,true,true,false}},np.bool),initial=1.5,out=o})
  assert(r==o,"ext reduction 219 out identity")
  assert(r.dtype=="float32","ext reduction 219 out dtype "..r.dtype)
  assert(close(r:tolist(),{{0.0}}),"ext reduction 219 out values")
end
do -- extended reduction 220: mean float32 shape=[0, 2, 1, 2] axis=None
  local a=np.zeros({0,2,1,2},np.float32)
  local r=np.mean(a,{axis=nil,keepdims=true,where=false})
  assert(r.dtype=="float32","ext reduction 220 dtype "..r.dtype)
  assert(close(r.shape,{1,1,1,1}),"ext reduction 220 shape")
  assert(close(r.strides,{4,4,4,4}),"ext reduction 220 strides")
  assert(close(r:tolist(),{{{{0/0}}}}),"ext reduction 220 values")
end
do -- extended reduction 221: sum uint64 shape=[0, 4, 1, 4] axis=None
  local a=np.zeros({0,4,1,4},np.uint64)
  local r=np.sum(a,{axis=nil,keepdims=true,where=false,dtype=np.float16,initial=2})
  assert(r.dtype=="float16","ext reduction 221 dtype "..r.dtype)
  assert(close(r.shape,{1,1,1,1}),"ext reduction 221 shape")
  assert(close(r.strides,{2,2,2,2}),"ext reduction 221 strides")
  assert(close(r:tolist(),{{{{2.0}}}}),"ext reduction 221 values")
end
do -- extended reduction 222: prod uint32 shape=[0, 1, 2, 0] axis=(0, 2)
  local a=np.zeros({0,1,2,0},np.uint32)
  local r=np.prod(a,{axis={1,3},keepdims=true,where=false,initial=0})
  assert(r.dtype=="uint64","ext reduction 222 dtype "..r.dtype)
  assert(close(r.shape,{1,1,1,0}),"ext reduction 222 shape")
  assert(close(r.strides,{0,0,0,0}),"ext reduction 222 strides")
  assert(close(r:tolist(),{{{{}}}}),"ext reduction 222 values")
end
do -- extended reduction 223: mean uint64 shape=[1] axis=-1
  local a=np.array({6},np.uint64)
  local r=np.mean(a,{axis=-1,keepdims=false,where=np.array({true},np.bool)})
  assert(close(r,6.0),"ext reduction 223 scalar")
end
do -- extended reduction 224: prod uint64 shape=[3, 3, 0] axis=1
  local a=np.zeros({3,3,0},np.uint64)
  local r=np.prod(a,{axis=2,keepdims=true,where=np.zeros({3,3,0},np.bool)})
  assert(r.dtype=="uint64","ext reduction 224 dtype "..r.dtype)
  assert(close(r.shape,{3,1,0}),"ext reduction 224 shape")
  assert(close(r.strides,{0,0,0}),"ext reduction 224 strides")
  assert(close(r:tolist(),{{{}},{{}},{{}}}),"ext reduction 224 values")
end
do -- extended reduction 225: prod int16 shape=[3, 4] axis=()
  local a=np.array({{0,5,-1,4},{-2,3,-3,2},{-4,1,-5,0}},np.int16)
  local r=np.prod(a,{axis={},keepdims=true,where=np.array({false,true,true,false},np.bool),dtype=np.int32})
  assert(r.dtype=="int32","ext reduction 225 dtype "..r.dtype)
  assert(close(r.shape,{3,4}),"ext reduction 225 shape")
  assert(close(r.strides,{16,4}),"ext reduction 225 strides")
  assert(close(r:tolist(),{{1,5,-1,1},{1,3,-3,1},{1,1,-5,1}}),"ext reduction 225 values")
end
do -- extended reduction 226: prod float32 shape=[1, 0, 2, 1] axis=(1, 2)
  local a=np.zeros({1,0,2,1},np.float32)
  local o=np.zeros({1,1},np.int64)
  local r=np.prod(a,{axis={2,3},keepdims=false,where=false,initial=-1,out=o})
  assert(r==o,"ext reduction 226 out identity")
  assert(r.dtype=="int64","ext reduction 226 out dtype "..r.dtype)
  assert(close(r:tolist(),{{-1}}),"ext reduction 226 out values")
end
do -- extended reduction 227: sum uint64 shape=[0, 4, 2] axis=None
  local a=np.zeros({0,4,2},np.uint64)
  local r=np.sum(a,{axis=nil,keepdims=true,where=false,initial=3})
  assert(r.dtype=="uint64","ext reduction 227 dtype "..r.dtype)
  assert(close(r.shape,{1,1,1}),"ext reduction 227 shape")
  assert(close(r.strides,{8,8,8}),"ext reduction 227 strides")
  assert(close(r:tolist(),{{{3}}}),"ext reduction 227 values")
end
do -- extended reduction 228: prod float32 shape=[1] axis=None
  local a=np.array({-1.5},np.float32)
  local r=np.prod(a,{axis=nil,keepdims=false,where=false,dtype=np.uint16})
  assert(close(r,1),"ext reduction 228 scalar")
end
do -- extended reduction 229: prod int16 shape=[2, 3] axis=None
  local a=np.array({{4,-2,3},{-3,2,-4}},np.int16)
  local o=np.zeros({1,1},np.int8)
  local r=np.prod(a,{axis=nil,keepdims=true,where=np.array({{true,true,false}},np.bool),initial=1,out=o})
  assert(r==o,"ext reduction 229 out identity")
  assert(r.dtype=="int8","ext reduction 229 out dtype "..r.dtype)
  assert(close(r:tolist(),{{48}}),"ext reduction 229 out values")
end
do -- extended reduction 230: sum uint32 shape=[4] axis=(0,)
  local a=np.array({6,2,5,1},np.uint32)
  local r=np.sum(a,{axis={1},keepdims=false,where=np.array({true,false,true,true},np.bool)})
  assert(close(r,12),"ext reduction 230 scalar")
end
do -- extended reduction 231: prod int16 shape=[2, 4] axis=(0,)
  local a=np.array({{-5,0,5,-1},{4,-2,3,-3}},np.int16)
  local r=np.prod(a,{axis={1},keepdims=true,where=true,initial=0})
  assert(r.dtype=="int64","ext reduction 231 dtype "..r.dtype)
  assert(close(r.shape,{1,4}),"ext reduction 231 shape")
  assert(close(r.strides,{32,8}),"ext reduction 231 strides")
  assert(close(r:tolist(),{{0,0,0,0}}),"ext reduction 231 values")
end
do -- extended reduction 232: sum int64 shape=[0, 4] axis=None
  local a=np.zeros({0,4},np.int64)
  local r=np.sum(a,{axis=nil,keepdims=false,where=np.array({{true,true,false,true}},np.bool)})
  assert(close(r,0),"ext reduction 232 scalar")
end
do -- extended reduction 233: prod int16 shape=[3] axis=None
  local a=np.array({-3,2,-4},np.int16)
  local r=np.prod(a,{axis=nil,keepdims=true,where=np.array({true,false,true},np.bool)})
  assert(r.dtype=="int64","ext reduction 233 dtype "..r.dtype)
  assert(close(r.shape,{1}),"ext reduction 233 shape")
  assert(close(r.strides,{8}),"ext reduction 233 strides")
  assert(close(r:tolist(),{12}),"ext reduction 233 values")
end
do -- extended reduction 234: mean int16 shape=[4] axis=None
  local a=np.array({-2,3,-3,2},np.int16)
  local r=np.mean(a,{axis=nil,keepdims=false,where=np.array({false,true,true,false},np.bool)})
  assert(close(r,0.0),"ext reduction 234 scalar")
end
do -- extended reduction 235: mean int8 shape=[4, 0] axis=-2
  local a=np.zeros({4,0},np.int8)
  local o=np.zeros({1,0},np.float64)
  local r=np.mean(a,{axis=-2,keepdims=true,where=false,out=o})
  assert(r==o,"ext reduction 235 out identity")
  assert(r.dtype=="float64","ext reduction 235 out dtype "..r.dtype)
  assert(close(r:tolist(),{{}}),"ext reduction 235 out values")
end
do -- extended reduction 236: sum bool shape=[1, 1, 0] axis=None
  local a=np.zeros({1,1,0},np.bool)
  local r=np.sum(a,{axis=nil,keepdims=false,where=false,dtype=np.uint64})
  assert(close(r,0),"ext reduction 236 scalar")
end
do -- extended reduction 237: mean float64 shape=[3, 2, 1, 1] axis=None
  local a=np.array({{{{-1.5}},{{-1.0}}},{{{-0.5}},{{0.0}}},{{{0.5}},{{1.0}}}},np.float64)
  local r=np.mean(a,{axis=nil,keepdims=false,where=np.array({{{{false}},{{true}}},{{{true}},{{false}}},{{{true}},{{true}}}},np.bool),dtype=np.float32})
  assert(close(r,0.0),"ext reduction 237 scalar")
end
do -- extended reduction 238: mean float32 shape=[2, 0, 1] axis=None
  local a=np.zeros({2,0,1},np.float32)
  local r=np.mean(a,{axis=nil,keepdims=true,where=np.array({{{true}}},np.bool)})
  assert(r.dtype=="float32","ext reduction 238 dtype "..r.dtype)
  assert(close(r.shape,{1,1,1}),"ext reduction 238 shape")
  assert(close(r.strides,{4,4,4}),"ext reduction 238 strides")
  assert(close(r:tolist(),{{{0/0}}}),"ext reduction 238 values")
end
do -- extended reduction 239: mean float16 shape=[4, 2, 0, 2] axis=None
  local a=np.zeros({4,2,0,2},np.float16)
  local r=np.mean(a,{axis=nil,keepdims=true,where=true})
  assert(r.dtype=="float16","ext reduction 239 dtype "..r.dtype)
  assert(close(r.shape,{1,1,1,1}),"ext reduction 239 shape")
  assert(close(r.strides,{2,2,2,2}),"ext reduction 239 strides")
  assert(close(r:tolist(),{{{{0/0}}}}),"ext reduction 239 values")
end
do -- extended reduction 240: sum int64 shape=[4, 3, 0, 1] axis=2
  local a=np.zeros({4,3,0,1},np.int64)
  local o=np.zeros({4,3,1},np.int8)
  local r=np.sum(a,{axis=3,keepdims=false,where=np.array({{{{false}}}},np.bool),dtype=np.int8,out=o})
  assert(r==o,"ext reduction 240 out identity")
  assert(r.dtype=="int8","ext reduction 240 out dtype "..r.dtype)
  assert(close(r:tolist(),{{{0},{0},{0}},{{0},{0},{0}},{{0},{0},{0}},{{0},{0},{0}}}),"ext reduction 240 out values")
end
do -- extended reduction 241: sum int64 shape=[0, 3] axis=None
  local a=np.zeros({0,3},np.int64)
  local r=np.sum(a,{axis=nil,keepdims=false,where=false})
  assert(close(r,0),"ext reduction 241 scalar")
end
do -- extended reduction 242: prod int8 shape=[2, 0, 3] axis=None
  local a=np.zeros({2,0,3},np.int8)
  local o=np.zeros({},np.float16)
  local r=np.prod(a,{axis=nil,keepdims=false,where=true,out=o})
  assert(r==o,"ext reduction 242 out identity")
  assert(r.dtype=="float16","ext reduction 242 out dtype "..r.dtype)
  assert(close(r:tolist(),1.0),"ext reduction 242 out values")
end
do -- extended reduction 243: prod int32 shape=[1, 2, 0] axis=None
  local a=np.zeros({1,2,0},np.int32)
  local o=np.zeros({1,1,1},np.float32)
  local r=np.prod(a,{axis=nil,keepdims=true,where=np.zeros({1,2,0},np.bool),out=o})
  assert(r==o,"ext reduction 243 out identity")
  assert(r.dtype=="float32","ext reduction 243 out dtype "..r.dtype)
  assert(close(r:tolist(),{{{1.0}}}),"ext reduction 243 out values")
end
do -- extended reduction 244: prod float16 shape=[2, 1, 0] axis=()
  local a=np.zeros({2,1,0},np.float16)
  local r=np.prod(a,{axis={},keepdims=true,where=true})
  assert(r.dtype=="float16","ext reduction 244 dtype "..r.dtype)
  assert(close(r.shape,{2,1,0}),"ext reduction 244 shape")
  assert(close(r.strides,{0,0,0}),"ext reduction 244 strides")
  assert(close(r:tolist(),{{{}},{{}}}),"ext reduction 244 values")
end
do -- extended reduction 245: prod uint8 shape=[0, 3, 3, 3] axis=-1
  local a=np.zeros({0,3,3,3},np.uint8)
  local r=np.prod(a,{axis=-1,keepdims=true,where=true})
  assert(r.dtype=="uint64","ext reduction 245 dtype "..r.dtype)
  assert(close(r.shape,{0,3,3,1}),"ext reduction 245 shape")
  assert(close(r.strides,{0,0,0,0}),"ext reduction 245 strides")
  assert(close(r:tolist(),{}),"ext reduction 245 values")
end
do -- extended reduction 246: sum uint8 shape=[1, 0, 4, 4] axis=2
  local a=np.zeros({1,0,4,4},np.uint8)
  local r=np.sum(a,{axis=3,keepdims=false,where=np.zeros({1,0,4,4},np.bool)})
  assert(r.dtype=="uint64","ext reduction 246 dtype "..r.dtype)
  assert(close(r.shape,{1,0,4}),"ext reduction 246 shape")
  assert(close(r.strides,{0,0,0}),"ext reduction 246 strides")
  assert(close(r:tolist(),{{}}),"ext reduction 246 values")
end
do -- extended reduction 247: sum int16 shape=[4, 3] axis=-2
  local a=np.array({{0,5,-1},{4,-2,3},{-3,2,-4},{1,-5,0}},np.int16)
  local r=np.sum(a,{axis=-2,keepdims=true,where=true})
  assert(r.dtype=="int64","ext reduction 247 dtype "..r.dtype)
  assert(close(r.shape,{1,3}),"ext reduction 247 shape")
  assert(close(r.strides,{24,8}),"ext reduction 247 strides")
  assert(close(r:tolist(),{{2,0,-2}}),"ext reduction 247 values")
end
do -- extended reduction 248: prod uint32 shape=[0, 3, 4, 3] axis=1
  local a=np.zeros({0,3,4,3},np.uint32)
  local o=np.zeros({0,1,4,3},np.float32)
  local r=np.prod(a,{axis=2,keepdims=true,where=true,out=o})
  assert(r==o,"ext reduction 248 out identity")
  assert(r.dtype=="float32","ext reduction 248 out dtype "..r.dtype)
  assert(close(r:tolist(),{}),"ext reduction 248 out values")
end
do -- extended reduction 249: sum float16 shape=[4, 0, 2, 3] axis=-2
  local a=np.zeros({4,0,2,3},np.float16)
  local r=np.sum(a,{axis=-2,keepdims=true,where=np.array({{{{false,true,true}}}},np.bool)})
  assert(r.dtype=="float16","ext reduction 249 dtype "..r.dtype)
  assert(close(r.shape,{4,0,1,3}),"ext reduction 249 shape")
  assert(close(r.strides,{0,0,0,0}),"ext reduction 249 strides")
  assert(close(r:tolist(),{{},{},{},{}}),"ext reduction 249 values")
end
do -- extended reduction 250: mean int16 shape=[1, 1, 1, 4] axis=None
  local a=np.array({{{{3,-3,2,-4}}}},np.int16)
  local r=np.mean(a,{axis=nil,keepdims=true,where=np.array({true,true,false,true},np.bool)})
  assert(r.dtype=="float64","ext reduction 250 dtype "..r.dtype)
  assert(close(r.shape,{1,1,1,1}),"ext reduction 250 shape")
  assert(close(r.strides,{8,8,8,8}),"ext reduction 250 strides")
  assert(close(r:tolist(),{{{{-1.3333333333333333}}}}),"ext reduction 250 values")
end
do -- extended reduction 251: mean float64 shape=[1, 1, 3, 2] axis=None
  local a=(np.array({{{{-1.25}},{{-0.75}},{{-0.25}}},{{{0.25}},{{0.75}},{{1.25}}}},np.float64)).T
  local r=np.mean(a,{axis=nil,keepdims=false,where=false})
  assert(close(r,0/0),"ext reduction 251 scalar")
end
do -- extended reduction 252: prod int64 shape=[4, 1] axis=(0, 1)
  local a=np.array({{5},{-1},{4},{-2}},np.int64)
  local r=np.prod(a,{axis={1,2},keepdims=true,where=true})
  assert(r.dtype=="int64","ext reduction 252 dtype "..r.dtype)
  assert(close(r.shape,{1,1}),"ext reduction 252 shape")
  assert(close(r.strides,{8,8}),"ext reduction 252 strides")
  assert(close(r:tolist(),{{40}}),"ext reduction 252 values")
end
do -- extended reduction 253: prod uint16 shape=[0, 1, 0, 2] axis=None
  local a=np.zeros({0,1,0,2},np.uint16)
  local r=np.prod(a,{axis=nil,keepdims=true,where=np.array({true,true},np.bool)})
  assert(r.dtype=="uint64","ext reduction 253 dtype "..r.dtype)
  assert(close(r.shape,{1,1,1,1}),"ext reduction 253 shape")
  assert(close(r.strides,{8,8,8,8}),"ext reduction 253 strides")
  assert(close(r:tolist(),{{{{1}}}}),"ext reduction 253 values")
end
do -- extended reduction 254: sum uint32 shape=[3, 2, 2, 1] axis=(0, 2)
  local a=np.array({{{{2},{5}},{{1},{4}}},{{{0},{3}},{{6},{2}}},{{{5},{1}},{{4},{0}}}},np.uint32)
  local r=np.sum(a,{axis={1,3},keepdims=false,where=true})
  assert(r.dtype=="uint64","ext reduction 254 dtype "..r.dtype)
  assert(close(r.shape,{2,1}),"ext reduction 254 shape")
  assert(close(r.strides,{8,8}),"ext reduction 254 strides")
  assert(close(r:tolist(),{{16},{17}}),"ext reduction 254 values")
end
do -- extended reduction 255: sum uint32 shape=[1] axis=None
  local a=np.array({3},np.uint32)
  local r=np.sum(a,{axis=nil,keepdims=false,where=true,dtype=np.float32,initial=1})
  assert(close(r,4.0),"ext reduction 255 scalar")
end
do -- extended reduction 256: mean int16 shape=[2, 4] axis=0
  local a=np.array({{-2,3,-3,2},{-4,1,-5,0}},np.int16)
  local r=np.mean(a,{axis=1,keepdims=false,where=true})
  assert(r.dtype=="float64","ext reduction 256 dtype "..r.dtype)
  assert(close(r.shape,{4}),"ext reduction 256 shape")
  assert(close(r.strides,{8}),"ext reduction 256 strides")
  assert(close(r:tolist(),{-3.0,2.0,-4.0,1.0}),"ext reduction 256 values")
end
do -- extended reduction 257: mean int8 shape=[2] axis=None
  local a=np.array({-1,4},np.int8)
  local r=np.mean(a,{axis=nil,keepdims=false,where=np.array({true,false},np.bool),dtype=np.float32})
  assert(close(r,-1.0),"ext reduction 257 scalar")
end
do -- extended reduction 258: sum uint16 shape=[0, 2, 0, 2] axis=(0, 1, 2, 3)
  local a=np.zeros({0,2,0,2},np.uint16)
  local r=np.sum(a,{axis={1,2,3,4},keepdims=false,where=true})
  assert(close(r,0),"ext reduction 258 scalar")
end
do -- extended reduction 259: mean float64 shape=[3, 3, 2] axis=0
  local a=np.array({{{-1.375,-0.875},{-0.375,0.125},{0.625,1.125}},{{1.625,-1.375},{-0.875,-0.375},{0.125,0.625}},{{1.125,1.625},{-1.375,-0.875},{-0.375,0.125}}},np.float64)
  local r=np.mean(a,{axis=1,keepdims=false,where=np.array({{{true,true}}},np.bool)})
  assert(r.dtype=="float64","ext reduction 259 dtype "..r.dtype)
  assert(close(r.shape,{3,2}),"ext reduction 259 shape")
  assert(close(r.strides,{16,8}),"ext reduction 259 strides")
  assert(close(r:tolist(),{{0.4583333333333333,-0.20833333333333334},{-0.875,-0.375},{0.125,0.625}}),"ext reduction 259 values")
end
do -- extended reduction 260: mean float32 shape=[2, 3, 4] axis=None
  local a=np.array({{{-1.25,-0.75,-0.25,0.25},{0.75,1.25,1.75,-1.25},{-0.75,-0.25,0.25,0.75}},{{1.25,1.75,-1.25,-0.75},{-0.25,0.25,0.75,1.25},{1.75,-1.25,-0.75,-0.25}}},np.float32)
  local r=np.mean(a,{axis=nil,keepdims=false,where=np.array({{{true,false,true,true},{false,true,true,false},{true,true,false,true}},{{true,false,true,true},{false,true,true,false},{true,true,false,true}}},np.bool)})
  assert(close(r,0.125),"ext reduction 260 scalar")
end
do -- extended reduction 261: mean uint32 shape=[1] axis=(-1,)
  local a=np.array({2},np.uint32)
  local o=np.zeros({1},np.float64)
  local r=np.mean(a,{axis={-1},keepdims=true,where=np.array({false},np.bool),out=o})
  assert(r==o,"ext reduction 261 out identity")
  assert(r.dtype=="float64","ext reduction 261 out dtype "..r.dtype)
  assert(close(r:tolist(),{0/0}),"ext reduction 261 out values")
end
do -- extended reduction 262: prod bool shape=[0] axis=(0,)
  local a=np.zeros({0},np.bool)
  local o=np.zeros({1},np.int64)
  local r=np.prod(a,{axis={1},keepdims=true,where=np.zeros({0},np.bool),initial=3,out=o})
  assert(r==o,"ext reduction 262 out identity")
  assert(r.dtype=="int64","ext reduction 262 out dtype "..r.dtype)
  assert(close(r:tolist(),{3}),"ext reduction 262 out values")
end
do -- extended reduction 263: mean uint32 shape=[2] axis=-1
  local a=np.array({4,0},np.uint32)
  local r=np.mean(a,{axis=-1,keepdims=true,where=np.array({true,false},np.bool)})
  assert(r.dtype=="float64","ext reduction 263 dtype "..r.dtype)
  assert(close(r.shape,{1}),"ext reduction 263 shape")
  assert(close(r.strides,{8}),"ext reduction 263 strides")
  assert(close(r:tolist(),{4.0}),"ext reduction 263 values")
end
do -- extended reduction 264: mean float32 shape=[3, 4, 1] axis=None
  local a=(np.array({{{-1.5,-1.0,-0.5},{0.0,0.5,1.0},{1.5,-1.5,-1.0},{-0.5,0.0,0.5}}},np.float32)).T
  local o=np.zeros({},np.float64)
  local r=np.mean(a,{axis=nil,keepdims=false,where=np.array({{{false},{true},{true},{false}},{{true},{true},{false},{true}},{{true},{false},{true},{true}}},np.bool),dtype=np.float32,out=o})
  assert(r==o,"ext reduction 264 out identity")
  assert(r.dtype=="float64","ext reduction 264 out dtype "..r.dtype)
  assert(close(r:tolist(),0.0),"ext reduction 264 out values")
end
do -- extended reduction 265: sum float64 shape=[2, 4, 1, 2] axis=1
  local a=np.array({{{{-1.375,-0.875}},{{-0.375,0.125}},{{0.625,1.125}},{{1.625,-1.375}}},{{{-0.875,-0.375}},{{0.125,0.625}},{{1.125,1.625}},{{-1.375,-0.875}}}},np.float64)
  local o=np.zeros({2,1,1,2},np.float64)
  local r=np.sum(a,{axis=2,keepdims=true,where=np.array({true,true},np.bool),dtype=np.float64,out=o})
  assert(r==o,"ext reduction 265 out identity")
  assert(r.dtype=="float64","ext reduction 265 out dtype "..r.dtype)
  assert(close(r:tolist(),{{{{0.5,-1.0}}},{{{-1.0,1.0}}}}),"ext reduction 265 out values")
end
do -- extended reduction 266: prod int8 shape=[4] axis=-1
  local a=np.array({-3,2,-4,1},np.int8)
  local o=np.zeros({1},np.float64)
  local r=np.prod(a,{axis=-1,keepdims=true,where=np.array({true,false,true,true},np.bool),out=o})
  assert(r==o,"ext reduction 266 out identity")
  assert(r.dtype=="float64","ext reduction 266 out dtype "..r.dtype)
  assert(close(r:tolist(),{12.0}),"ext reduction 266 out values")
end
do -- extended reduction 267: mean float64 shape=[0, 3] axis=1
  local a=np.zeros({0,3},np.float64)
  local r=np.mean(a,{axis=2,keepdims=false,where=np.zeros({0,3},np.bool)})
  assert(r.dtype=="float64","ext reduction 267 dtype "..r.dtype)
  assert(close(r.shape,{0}),"ext reduction 267 shape")
  assert(close(r.strides,{0}),"ext reduction 267 strides")
  assert(close(r:tolist(),{}),"ext reduction 267 values")
end
do -- extended reduction 268: mean bool shape=[1, 4, 0, 4] axis=None
  local a=np.zeros({1,4,0,4},np.bool)
  local r=np.mean(a,{axis=nil,keepdims=true,where=false})
  assert(r.dtype=="float64","ext reduction 268 dtype "..r.dtype)
  assert(close(r.shape,{1,1,1,1}),"ext reduction 268 shape")
  assert(close(r.strides,{8,8,8,8}),"ext reduction 268 strides")
  assert(close(r:tolist(),{{{{0/0}}}}),"ext reduction 268 values")
end
do -- extended reduction 269: prod int32 shape=[1] axis=-1
  local a=np.array({0},np.int32)
  local r=np.prod(a,{axis=-1,keepdims=false,where=np.array({true},np.bool)})
  assert(close(r,0),"ext reduction 269 scalar")
end
do -- extended reduction 270: sum int64 shape=[2, 2, 2, 4] axis=-4
  local a=np.array({{{{1,-5,0,5},{-1,4,-2,3}},{{-3,2,-4,1},{-5,0,5,-1}}},{{{4,-2,3,-3},{2,-4,1,-5}},{{0,5,-1,4},{-2,3,-3,2}}}},np.int64)
  local r=np.sum(a,{axis=-4,keepdims=false,where=np.array({false,true,true,false},np.bool)})
  assert(r.dtype=="int64","ext reduction 270 dtype "..r.dtype)
  assert(close(r.shape,{2,2,4}),"ext reduction 270 shape")
  assert(close(r.strides,{64,32,8}),"ext reduction 270 strides")
  assert(close(r:tolist(),{{{0,-7,3,0},{0,0,-1,0}},{{0,7,-5,0},{0,3,2,0}}}),"ext reduction 270 values")
end
do -- extended reduction 271: prod int16 shape=[1, 3, 4, 4] axis=2
  local a=np.array({{{{2,-4,1,-5},{0,5,-1,4},{-2,3,-3,2},{-4,1,-5,0}},{{5,-1,4,-2},{3,-3,2,-4},{1,-5,0,5},{-1,4,-2,3}},{{-3,2,-4,1},{-5,0,5,-1},{4,-2,3,-3},{2,-4,1,-5}}}},np.int16)
  local r=np.prod(a,{axis=3,keepdims=true,where=np.array({true,true,false,true},np.bool),initial=2})
  assert(r.dtype=="int64","ext reduction 271 dtype "..r.dtype)
  assert(close(r.shape,{1,3,1,4}),"ext reduction 271 shape")
  assert(close(r.strides,{96,32,32,8}),"ext reduction 271 strides")
  assert(close(r:tolist(),{{{{0,-120,2,0}},{{-30,-120,2,240}},{{240,0,2,-30}}}}),"ext reduction 271 values")
end
do -- extended reduction 272: mean uint8 shape=[2, 4, 4, 4] axis=None
  local a=np.array({{{{6,2,5,1},{4,0,3,6},{2,5,1,4},{0,3,6,2}},{{5,1,4,0},{3,6,2,5},{1,4,0,3},{6,2,5,1}},{{4,0,3,6},{2,5,1,4},{0,3,6,2},{5,1,4,0}},{{3,6,2,5},{1,4,0,3},{6,2,5,1},{4,0,3,6}}},{{{2,5,1,4},{0,3,6,2},{5,1,4,0},{3,6,2,5}},{{1,4,0,3},{6,2,5,1},{4,0,3,6},{2,5,1,4}},{{0,3,6,2},{5,1,4,0},{3,6,2,5},{1,4,0,3}},{{6,2,5,1},{4,0,3,6},{2,5,1,4},{0,3,6,2}}}},np.uint8)
  local r=np.mean(a,{axis=nil,keepdims=false,where=np.array({{{{true,false,true,true},{false,true,true,false},{true,true,false,true},{true,false,true,true}},{{false,true,true,false},{true,true,false,true},{true,false,true,true},{false,true,true,false}},{{true,true,false,true},{true,false,true,true},{false,true,true,false},{true,true,false,true}},{{true,false,true,true},{false,true,true,false},{true,true,false,true},{true,false,true,true}}},{{{false,true,true,false},{true,true,false,true},{true,false,true,true},{false,true,true,false}},{{true,true,false,true},{true,false,true,true},{false,true,true,false},{true,true,false,true}},{{true,false,true,true},{false,true,true,false},{true,true,false,true},{true,false,true,true}},{{false,true,true,false},{true,true,false,true},{true,false,true,true},{false,true,true,false}}}},np.bool)})
  assert(close(r,3.0352941176470587),"ext reduction 272 scalar")
end
do -- extended reduction 273: mean float32 shape=[1, 1] axis=None
  local a=np.array({{-1.5}},np.float32)
  local o=np.zeros({},np.float32)
  local r=np.mean(a,{axis=nil,keepdims=false,where=np.array({{false}},np.bool),out=o})
  assert(r==o,"ext reduction 273 out identity")
  assert(r.dtype=="float32","ext reduction 273 out dtype "..r.dtype)
  assert(close(r:tolist(),0/0),"ext reduction 273 out values")
end
do -- extended reduction 274: mean uint16 shape=[2, 0, 1, 4] axis=(1,)
  local a=np.zeros({2,0,1,4},np.uint16)
  local o=np.zeros({2,1,4},np.float32)
  local r=np.mean(a,{axis={2},keepdims=false,where=np.array({{{{true,true,false,true}}}},np.bool),out=o})
  assert(r==o,"ext reduction 274 out identity")
  assert(r.dtype=="float32","ext reduction 274 out dtype "..r.dtype)
  assert(close(r:tolist(),{{{0/0,0/0,0/0,0/0}},{{0/0,0/0,0/0,0/0}}}),"ext reduction 274 out values")
end
do -- extended reduction 275: prod int32 shape=[0, 4, 3, 1] axis=()
  local a=np.zeros({0,4,3,1},np.int32)
  local r=np.prod(a,{axis={},keepdims=true,where=np.zeros({0,4,3,1},np.bool)})
  assert(r.dtype=="int64","ext reduction 275 dtype "..r.dtype)
  assert(close(r.shape,{0,4,3,1}),"ext reduction 275 shape")
  assert(close(r.strides,{0,0,0,0}),"ext reduction 275 strides")
  assert(close(r:tolist(),{}),"ext reduction 275 values")
end
do -- extended reduction 276: prod int8 shape=[1, 1, 2, 2] axis=-3
  local a=np.array({{{{-4,1},{-5,0}}}},np.int8)
  local r=np.prod(a,{axis=-3,keepdims=false,where=false,dtype=np.uint16})
  assert(r.dtype=="uint16","ext reduction 276 dtype "..r.dtype)
  assert(close(r.shape,{1,2,2}),"ext reduction 276 shape")
  assert(close(r.strides,{8,4,2}),"ext reduction 276 strides")
  assert(close(r:tolist(),{{{1,1},{1,1}}}),"ext reduction 276 values")
end
do -- extended reduction 277: sum uint16 shape=[2, 0, 3] axis=(-1,)
  local a=np.zeros({2,0,3},np.uint16)
  local r=np.sum(a,{axis={-1},keepdims=true,where=np.array({{{true,true,false}}},np.bool),dtype=np.uint16})
  assert(r.dtype=="uint16","ext reduction 277 dtype "..r.dtype)
  assert(close(r.shape,{2,0,1}),"ext reduction 277 shape")
  assert(close(r.strides,{0,0,0}),"ext reduction 277 strides")
  assert(close(r:tolist(),{{},{}}),"ext reduction 277 values")
end
do -- extended reduction 278: mean uint64 shape=[2] axis=(0,)
  local a=np.array({5,1},np.uint64)
  local r=np.mean(a,{axis={1},keepdims=true,where=true})
  assert(r.dtype=="float64","ext reduction 278 dtype "..r.dtype)
  assert(close(r.shape,{1}),"ext reduction 278 shape")
  assert(close(r.strides,{8}),"ext reduction 278 strides")
  assert(close(r:tolist(),{3.0}),"ext reduction 278 values")
end
do -- extended reduction 279: sum uint16 shape=[1, 2, 3] axis=(1,)
  local a=np.array({{{6,2,5},{1,4,0}}},np.uint16)
  local r=np.sum(a,{axis={2},keepdims=false,where=false})
  assert(r.dtype=="uint64","ext reduction 279 dtype "..r.dtype)
  assert(close(r.shape,{1,3}),"ext reduction 279 shape")
  assert(close(r.strides,{24,8}),"ext reduction 279 strides")
  assert(close(r:tolist(),{{0,0,0}}),"ext reduction 279 values")
end
do -- extended reduction 280: sum float32 shape=[3, 3] axis=None
  local a=np.array({{-1.375,-0.875,-0.375},{0.125,0.625,1.125},{1.625,-1.375,-0.875}},np.float32)
  local r=np.sum(a,{axis=nil,keepdims=false,where=np.array({{true,true,false}},np.bool),dtype=np.bool,initial=1.5})
  assert(close(r,true),"ext reduction 280 scalar")
end
do -- extended reduction 281: prod float64 shape=[4, 4, 1, 2] axis=2
  local a=np.array({{{{-1.25,-0.75}},{{-0.25,0.25}},{{0.75,1.25}},{{1.75,-1.25}}},{{{-0.75,-0.25}},{{0.25,0.75}},{{1.25,1.75}},{{-1.25,-0.75}}},{{{-0.25,0.25}},{{0.75,1.25}},{{1.75,-1.25}},{{-0.75,-0.25}}},{{{0.25,0.75}},{{1.25,1.75}},{{-1.25,-0.75}},{{-0.25,0.25}}}},np.float64)
  local r=np.prod(a,{axis=3,keepdims=true,where=np.array({{{{true,false}},{{true,true}},{{false,true}},{{true,false}}},{{{true,true}},{{false,true}},{{true,false}},{{true,true}}},{{{false,true}},{{true,false}},{{true,true}},{{false,true}}},{{{true,false}},{{true,true}},{{false,true}},{{true,false}}}},np.bool),initial=1.5})
  assert(r.dtype=="float64","ext reduction 281 dtype "..r.dtype)
  assert(close(r.shape,{4,4,1,2}),"ext reduction 281 shape")
  assert(close(r.strides,{64,16,16,8}),"ext reduction 281 strides")
  assert(close(r:tolist(),{{{{-1.875,1.5}},{{-0.375,0.375}},{{1.5,1.875}},{{2.625,1.5}}},{{{-1.125,-0.375}},{{1.5,1.125}},{{1.875,1.5}},{{-1.875,-1.125}}},{{{1.5,0.375}},{{1.125,1.5}},{{2.625,-1.875}},{{1.5,-0.375}}},{{{0.375,1.5}},{{1.875,2.625}},{{1.5,-1.125}},{{-0.375,1.5}}}}),"ext reduction 281 values")
end
do -- extended reduction 282: sum float16 shape=[0, 0, 1, 1] axis=(0, 1, 3)
  local a=np.zeros({0,0,1,1},np.float16)
  local r=np.sum(a,{axis={1,2,4},keepdims=false,where=np.array({false},np.bool),initial=2})
  assert(r.dtype=="float16","ext reduction 282 dtype "..r.dtype)
  assert(close(r.shape,{1}),"ext reduction 282 shape")
  assert(close(r.strides,{2}),"ext reduction 282 strides")
  assert(close(r:tolist(),{2.0}),"ext reduction 282 values")
end
do -- extended reduction 283: mean int8 shape=[1, 3] axis=()
  local a=(np.array({{3},{-3},{2}},np.int8)).T
  local o=np.zeros({1,3},np.float64)
  local r=np.mean(a,{axis={},keepdims=true,where=false,out=o})
  assert(r==o,"ext reduction 283 out identity")
  assert(r.dtype=="float64","ext reduction 283 out dtype "..r.dtype)
  assert(close(r:tolist(),{{0/0,0/0,0/0}}),"ext reduction 283 out values")
end
do -- extended reduction 284: sum uint16 shape=[2, 0] axis=()
  local a=np.zeros({2,0},np.uint16)
  local o=np.zeros({2,0},np.float16)
  local r=np.sum(a,{axis={},keepdims=true,where=np.zeros({0},np.bool),dtype=np.int16,initial=-1,out=o})
  assert(r==o,"ext reduction 284 out identity")
  assert(r.dtype=="float16","ext reduction 284 out dtype "..r.dtype)
  assert(close(r:tolist(),{{},{}}),"ext reduction 284 out values")
end
do -- extended reduction 285: sum float64 shape=[3, 2, 0, 4] axis=(1, 2, 3)
  local a=np.zeros({3,2,0,4},np.float64)
  local r=np.sum(a,{axis={2,3,4},keepdims=true,where=true,dtype=np.int64})
  assert(r.dtype=="int64","ext reduction 285 dtype "..r.dtype)
  assert(close(r.shape,{3,1,1,1}),"ext reduction 285 shape")
  assert(close(r.strides,{8,8,8,8}),"ext reduction 285 strides")
  assert(close(r:tolist(),{{{{0}}},{{{0}}},{{{0}}}}),"ext reduction 285 values")
end
do -- extended reduction 286: prod bool shape=[3, 4, 4, 0] axis=()
  local a=np.zeros({3,4,4,0},np.bool)
  local r=np.prod(a,{axis={},keepdims=true,where=true,dtype=np.int32,initial=0})
  assert(r.dtype=="int32","ext reduction 286 dtype "..r.dtype)
  assert(close(r.shape,{3,4,4,0}),"ext reduction 286 shape")
  assert(close(r.strides,{0,0,0,0}),"ext reduction 286 strides")
  assert(close(r:tolist(),{{{{},{},{},{}},{{},{},{},{}},{{},{},{},{}},{{},{},{},{}}},{{{},{},{},{}},{{},{},{},{}},{{},{},{},{}},{{},{},{},{}}},{{{},{},{},{}},{{},{},{},{}},{{},{},{},{}},{{},{},{},{}}}}),"ext reduction 286 values")
end
do -- extended reduction 287: prod int64 shape=[0] axis=-1
  local a=np.zeros({0},np.int64)
  local r=np.prod(a,{axis=-1,keepdims=true,where=true})
  assert(r.dtype=="int64","ext reduction 287 dtype "..r.dtype)
  assert(close(r.shape,{1}),"ext reduction 287 shape")
  assert(close(r.strides,{8}),"ext reduction 287 strides")
  assert(close(r:tolist(),{1}),"ext reduction 287 values")
end
do -- extended reduction 288: mean int32 shape=[4] axis=0
  local a=np.array({-3,2,-4,1},np.int32)
  local o=np.zeros({},np.float32)
  local r=np.mean(a,{axis=1,keepdims=false,where=np.array({false,true,true,false},np.bool),out=o})
  assert(r==o,"ext reduction 288 out identity")
  assert(r.dtype=="float32","ext reduction 288 out dtype "..r.dtype)
  assert(close(r:tolist(),-1.0),"ext reduction 288 out values")
end
do -- extended reduction 289: mean uint64 shape=[0, 3] axis=(0,)
  local a=np.zeros({0,3},np.uint64)
  local o=np.zeros({1,3},np.float32)
  local r=np.mean(a,{axis={1},keepdims=true,where=true,out=o})
  assert(r==o,"ext reduction 289 out identity")
  assert(r.dtype=="float32","ext reduction 289 out dtype "..r.dtype)
  assert(close(r:tolist(),{{0/0,0/0,0/0}}),"ext reduction 289 out values")
end
do -- extended reduction 290: sum uint8 shape=[1] axis=0
  local a=np.array({3},np.uint8)
  local r=np.sum(a,{axis=1,keepdims=false,where=np.array({true},np.bool)})
  assert(close(r,3),"ext reduction 290 scalar")
end
do -- extended reduction 291: sum int64 shape=[2, 3, 3] axis=None
  local a=np.array({{{0,5,-1},{4,-2,3},{-3,2,-4}},{{1,-5,0},{5,-1,4},{-2,3,-3}}},np.int64)
  local r=np.sum(a,{axis=nil,keepdims=true,where=true,dtype=np.int32,initial=2})
  assert(r.dtype=="int32","ext reduction 291 dtype "..r.dtype)
  assert(close(r.shape,{1,1,1}),"ext reduction 291 shape")
  assert(close(r.strides,{4,4,4}),"ext reduction 291 strides")
  assert(close(r:tolist(),{{{8}}}),"ext reduction 291 values")
end
do -- extended reduction 292: sum int8 shape=[3] axis=None
  local a=np.array({1,-5,0},np.int8)
  local r=np.sum(a,{axis=nil,keepdims=true,where=true,initial=1.5})
  assert(r.dtype=="int64","ext reduction 292 dtype "..r.dtype)
  assert(close(r.shape,{1}),"ext reduction 292 shape")
  assert(close(r.strides,{8}),"ext reduction 292 strides")
  assert(close(r:tolist(),{-3}),"ext reduction 292 values")
end
do -- extended reduction 293: mean float16 shape=[1] axis=None
  local a=np.array({-1.25},np.float16)
  local r=np.mean(a,{axis=nil,keepdims=false,where=false})
  assert(close(r,0/0),"ext reduction 293 scalar")
end
do -- extended reduction 294: sum int16 shape=[2, 2, 3] axis=(1, 2)
  local a=np.array({{{3,-3,2},{-4,1,-5}},{{0,5,-1},{4,-2,3}}},np.int16)
  local r=np.sum(a,{axis={2,3},keepdims=false,where=false})
  assert(r.dtype=="int64","ext reduction 294 dtype "..r.dtype)
  assert(close(r.shape,{2}),"ext reduction 294 shape")
  assert(close(r.strides,{8}),"ext reduction 294 strides")
  assert(close(r:tolist(),{0,0}),"ext reduction 294 values")
end
do -- extended reduction 295: mean int8 shape=[2, 0, 4, 4] axis=()
  local a=np.zeros({2,0,4,4},np.int8)
  local r=np.mean(a,{axis={},keepdims=false,where=np.zeros({2,0,4,4},np.bool)})
  assert(r.dtype=="float64","ext reduction 295 dtype "..r.dtype)
  assert(close(r.shape,{2,0,4,4}),"ext reduction 295 shape")
  assert(close(r.strides,{0,0,0,0}),"ext reduction 295 strides")
  assert(close(r:tolist(),{{},{}}),"ext reduction 295 values")
end
do -- extended reduction 296: mean uint32 shape=[0, 0] axis=-1
  local a=np.zeros({0,0},np.uint32)
  local r=np.mean(a,{axis=-1,keepdims=true,where=np.zeros({0,0},np.bool)})
  assert(r.dtype=="float64","ext reduction 296 dtype "..r.dtype)
  assert(close(r.shape,{0,1}),"ext reduction 296 shape")
  assert(close(r.strides,{0,0}),"ext reduction 296 strides")
  assert(close(r:tolist(),{}),"ext reduction 296 values")
end
do -- extended reduction 297: sum int64 shape=[4, 0] axis=0
  local a=np.zeros({4,0},np.int64)
  local r=np.sum(a,{axis=1,keepdims=false,where=np.zeros({0},np.bool)})
  assert(r.dtype=="int64","ext reduction 297 dtype "..r.dtype)
  assert(close(r.shape,{0}),"ext reduction 297 shape")
  assert(close(r.strides,{0}),"ext reduction 297 strides")
  assert(close(r:tolist(),{}),"ext reduction 297 values")
end
do -- extended reduction 298: mean float64 shape=[0, 0] axis=-1
  local a=np.zeros({0,0},np.float64)
  local o=np.zeros({0},np.float32)
  local r=np.mean(a,{axis=-1,keepdims=false,where=np.zeros({0,0},np.bool),out=o})
  assert(r==o,"ext reduction 298 out identity")
  assert(r.dtype=="float32","ext reduction 298 out dtype "..r.dtype)
  assert(close(r:tolist(),{}),"ext reduction 298 out values")
end
do -- extended reduction 299: mean uint8 shape=[1, 3, 1] axis=-3
  local a=np.array({{{5},{1},{4}}},np.uint8)
  local o=np.zeros({3,1},np.float32)
  local r=np.mean(a,{axis=-3,keepdims=false,where=true,out=o})
  assert(r==o,"ext reduction 299 out identity")
  assert(r.dtype=="float32","ext reduction 299 out dtype "..r.dtype)
  assert(close(r:tolist(),{{5.0},{1.0},{4.0}}),"ext reduction 299 out values")
end
do -- extended reduction 300: prod uint64 shape=[3, 2, 3] axis=()
  local a=np.array({{{6,2,5},{1,4,0}},{{3,6,2},{5,1,4}},{{0,3,6},{2,5,1}}},np.uint64)
  local r=np.prod(a,{axis={},keepdims=false,where=false})
  assert(r.dtype=="uint64","ext reduction 300 dtype "..r.dtype)
  assert(close(r.shape,{3,2,3}),"ext reduction 300 shape")
  assert(close(r.strides,{48,24,8}),"ext reduction 300 strides")
  assert(close(r:tolist(),{{{1,1,1},{1,1,1}},{{1,1,1},{1,1,1}},{{1,1,1},{1,1,1}}}),"ext reduction 300 values")
end
do -- extended reduction 301: sum int8 shape=[4] axis=0
  local a=np.array({-1,4,-2,3},np.int8)
  local r=np.sum(a,{axis=1,keepdims=true,where=true})
  assert(r.dtype=="int64","ext reduction 301 dtype "..r.dtype)
  assert(close(r.shape,{1}),"ext reduction 301 shape")
  assert(close(r.strides,{8}),"ext reduction 301 strides")
  assert(close(r:tolist(),{4}),"ext reduction 301 values")
end
do -- extended reduction 302: prod uint32 shape=[2, 4] axis=None
  local a=(np.array({{1,4},{0,3},{6,2},{5,1}},np.uint32)).T
  local o=np.zeros({1,1},np.float16)
  local r=np.prod(a,{axis=nil,keepdims=true,where=np.array({true,false,true,true},np.bool),out=o})
  assert(r==o,"ext reduction 302 out identity")
  assert(r.dtype=="float16","ext reduction 302 out dtype "..r.dtype)
  assert(close(r:tolist(),{{240.0}}),"ext reduction 302 out values")
end
do -- extended reduction 303: mean uint64 shape=[0, 4, 4] axis=2
  local a=np.zeros({0,4,4},np.uint64)
  local r=np.mean(a,{axis=3,keepdims=false,where=false})
  assert(r.dtype=="float64","ext reduction 303 dtype "..r.dtype)
  assert(close(r.shape,{0,4}),"ext reduction 303 shape")
  assert(close(r.strides,{0,0}),"ext reduction 303 strides")
  assert(close(r:tolist(),{}),"ext reduction 303 values")
end
do -- extended reduction 304: prod int16 shape=[1, 3] axis=None
  local a=np.array({{2,-4,1}},np.int16)
  local r=np.prod(a,{axis=nil,keepdims=false,where=np.array({{true,true,false}},np.bool)})
  assert(close(r,-8),"ext reduction 304 scalar")
end
do -- extended reduction 305: prod float32 shape=[3, 2, 3] axis=1
  local a=np.array({{{-1.25,-0.75,-0.25},{0.25,0.75,1.25}},{{1.75,-1.25,-0.75},{-0.25,0.25,0.75}},{{1.25,1.75,-1.25},{-0.75,-0.25,0.25}}},np.float32)
  local o=np.zeros({3,1,3},np.int32)
  local r=np.prod(a,{axis=2,keepdims=true,where=np.array({true,false,true},np.bool),dtype=np.bool,out=o})
  assert(r==o,"ext reduction 305 out identity")
  assert(r.dtype=="int32","ext reduction 305 out dtype "..r.dtype)
  assert(close(r:tolist(),{{{1,1,1}},{{1,1,1}},{{1,1,1}}}),"ext reduction 305 out values")
end
do -- extended reduction 306: prod uint8 shape=[4, 0] axis=(0, -1)
  local a=np.zeros({4,0},np.uint8)
  local r=np.prod(a,{axis={1,-1},keepdims=false,where=np.zeros({0},np.bool),initial=1})
  assert(close(r,1),"ext reduction 306 scalar")
end
do -- extended reduction 307: prod uint16 shape=[1] axis=0
  local a=np.array({6},np.uint16)
  local o=np.zeros({},np.float64)
  local r=np.prod(a,{axis=1,keepdims=false,where=false,dtype=np.float64,initial=3,out=o})
  assert(r==o,"ext reduction 307 out identity")
  assert(r.dtype=="float64","ext reduction 307 out dtype "..r.dtype)
  assert(close(r:tolist(),3.0),"ext reduction 307 out values")
end
do -- extended reduction 308: prod uint16 shape=[1, 4] axis=0
  local a=np.array({{0,3,6,2}},np.uint16)
  local r=np.prod(a,{axis=1,keepdims=false,where=false,dtype=np.int8})
  assert(r.dtype=="int8","ext reduction 308 dtype "..r.dtype)
  assert(close(r.shape,{4}),"ext reduction 308 shape")
  assert(close(r.strides,{1}),"ext reduction 308 strides")
  assert(close(r:tolist(),{1,1,1,1}),"ext reduction 308 values")
end
do -- extended reduction 309: sum int8 shape=[2, 3] axis=()
  local a=np.array({{-4,1,-5},{0,5,-1}},np.int8)
  local r=np.sum(a,{axis={},keepdims=false,where=true})
  assert(r.dtype=="int64","ext reduction 309 dtype "..r.dtype)
  assert(close(r.shape,{2,3}),"ext reduction 309 shape")
  assert(close(r.strides,{24,8}),"ext reduction 309 strides")
  assert(close(r:tolist(),{{-4,1,-5},{0,5,-1}}),"ext reduction 309 values")
end
do -- extended reduction 310: mean float16 shape=[1, 1] axis=0
  local a=(np.array({{-1.375}},np.float16)).T
  local r=np.mean(a,{axis=1,keepdims=true,where=true})
  assert(r.dtype=="float16","ext reduction 310 dtype "..r.dtype)
  assert(close(r.shape,{1,1}),"ext reduction 310 shape")
  assert(close(r.strides,{2,2}),"ext reduction 310 strides")
  assert(close(r:tolist(),{{-1.375}}),"ext reduction 310 values")
end
do -- extended reduction 311: mean uint16 shape=[2, 0] axis=(0,)
  local a=np.zeros({2,0},np.uint16)
  local r=np.mean(a,{axis={1},keepdims=false,where=false,dtype=np.float32})
  assert(r.dtype=="float32","ext reduction 311 dtype "..r.dtype)
  assert(close(r.shape,{0}),"ext reduction 311 shape")
  assert(close(r.strides,{0}),"ext reduction 311 strides")
  assert(close(r:tolist(),{}),"ext reduction 311 values")
end
do -- extended reduction 312: prod uint64 shape=[3, 3, 4, 4] axis=()
  local a=np.array({{{{4,0,3,6},{2,5,1,4},{0,3,6,2},{5,1,4,0}},{{3,6,2,5},{1,4,0,3},{6,2,5,1},{4,0,3,6}},{{2,5,1,4},{0,3,6,2},{5,1,4,0},{3,6,2,5}}},{{{1,4,0,3},{6,2,5,1},{4,0,3,6},{2,5,1,4}},{{0,3,6,2},{5,1,4,0},{3,6,2,5},{1,4,0,3}},{{6,2,5,1},{4,0,3,6},{2,5,1,4},{0,3,6,2}}},{{{5,1,4,0},{3,6,2,5},{1,4,0,3},{6,2,5,1}},{{4,0,3,6},{2,5,1,4},{0,3,6,2},{5,1,4,0}},{{3,6,2,5},{1,4,0,3},{6,2,5,1},{4,0,3,6}}}},np.uint64)
  local r=np.prod(a,{axis={},keepdims=true,where=true,initial=2})
  assert(r.dtype=="uint64","ext reduction 312 dtype "..r.dtype)
  assert(close(r.shape,{3,3,4,4}),"ext reduction 312 shape")
  assert(close(r.strides,{384,128,32,8}),"ext reduction 312 strides")
  assert(close(r:tolist(),{{{{8,0,6,12},{4,10,2,8},{0,6,12,4},{10,2,8,0}},{{6,12,4,10},{2,8,0,6},{12,4,10,2},{8,0,6,12}},{{4,10,2,8},{0,6,12,4},{10,2,8,0},{6,12,4,10}}},{{{2,8,0,6},{12,4,10,2},{8,0,6,12},{4,10,2,8}},{{0,6,12,4},{10,2,8,0},{6,12,4,10},{2,8,0,6}},{{12,4,10,2},{8,0,6,12},{4,10,2,8},{0,6,12,4}}},{{{10,2,8,0},{6,12,4,10},{2,8,0,6},{12,4,10,2}},{{8,0,6,12},{4,10,2,8},{0,6,12,4},{10,2,8,0}},{{6,12,4,10},{2,8,0,6},{12,4,10,2},{8,0,6,12}}}}),"ext reduction 312 values")
end
do -- extended reduction 313: mean int16 shape=[3, 4, 4] axis=(0, 1, 2)
  local a=(np.array({{{0,5,-1},{4,-2,3},{-3,2,-4},{1,-5,0}},{{5,-1,4},{-2,3,-3},{2,-4,1},{-5,0,5}},{{-1,4,-2},{3,-3,2},{-4,1,-5},{0,5,-1}},{{4,-2,3},{-3,2,-4},{1,-5,0},{5,-1,4}}},np.int16)).T
  local r=np.mean(a,{axis={1,2,3},keepdims=true,where=np.array({true,true,false,true},np.bool)})
  assert(r.dtype=="float64","ext reduction 313 dtype "..r.dtype)
  assert(close(r.shape,{1,1,1}),"ext reduction 313 shape")
  assert(close(r.strides,{8,8,8}),"ext reduction 313 strides")
  assert(close(r:tolist(),{{{0.25}}}),"ext reduction 313 values")
end
do -- extended reduction 314: sum bool shape=[3, 4, 3, 4] axis=None
  local a=np.array({{{{true,true,false,true},{true,true,true,false},{true,true,true,true}},{{false,true,true,true},{true,false,true,true},{true,true,false,true}},{{true,true,true,false},{true,true,true,true},{false,true,true,true}},{{true,false,true,true},{true,true,false,true},{true,true,true,false}}},{{{true,true,true,true},{false,true,true,true},{true,false,true,true}},{{true,true,false,true},{true,true,true,false},{true,true,true,true}},{{false,true,true,true},{true,false,true,true},{true,true,false,true}},{{true,true,true,false},{true,true,true,true},{false,true,true,true}}},{{{true,false,true,true},{true,true,false,true},{true,true,true,false}},{{true,true,true,true},{false,true,true,true},{true,false,true,true}},{{true,true,false,true},{true,true,true,false},{true,true,true,true}},{{false,true,true,true},{true,false,true,true},{true,true,false,true}}}},np.bool)
  local r=np.sum(a,{axis=nil,keepdims=true,where=np.array({true,false,true,true},np.bool),initial=-1})
  assert(r.dtype=="int64","ext reduction 314 dtype "..r.dtype)
  assert(close(r.shape,{1,1,1,1}),"ext reduction 314 shape")
  assert(close(r.strides,{8,8,8,8}),"ext reduction 314 strides")
  assert(close(r:tolist(),{{{{85}}}}),"ext reduction 314 values")
end
do -- extended reduction 315: sum float64 shape=[2] axis=(-1,)
  local a=np.array({-1.5,-1.0},np.float64)
  local r=np.sum(a,{axis={-1},keepdims=true,where=true,initial=2})
  assert(r.dtype=="float64","ext reduction 315 dtype "..r.dtype)
  assert(close(r.shape,{1}),"ext reduction 315 shape")
  assert(close(r.strides,{8}),"ext reduction 315 strides")
  assert(close(r:tolist(),{-0.5}),"ext reduction 315 values")
end
do -- extended reduction 316: sum uint8 shape=[1, 1, 3, 0] axis=()
  local a=np.zeros({1,1,3,0},np.uint8)
  local r=np.sum(a,{axis={},keepdims=false,where=false,initial=3})
  assert(r.dtype=="uint64","ext reduction 316 dtype "..r.dtype)
  assert(close(r.shape,{1,1,3,0}),"ext reduction 316 shape")
  assert(close(r.strides,{0,0,0,0}),"ext reduction 316 strides")
  assert(close(r:tolist(),{{{{},{},{}}}}),"ext reduction 316 values")
end
do -- extended reduction 317: prod int8 shape=[1, 4, 4] axis=1
  local a=np.array({{{4,-2,3,-3},{2,-4,1,-5},{0,5,-1,4},{-2,3,-3,2}}},np.int8)
  local r=np.prod(a,{axis=2,keepdims=true,where=np.array({true,false,true,true},np.bool)})
  assert(r.dtype=="int64","ext reduction 317 dtype "..r.dtype)
  assert(close(r.shape,{1,1,4}),"ext reduction 317 shape")
  assert(close(r.strides,{32,32,8}),"ext reduction 317 strides")
  assert(close(r:tolist(),{{{0,1,9,120}}}),"ext reduction 317 values")
end
do -- extended reduction 318: sum bool shape=[1, 2, 1] axis=(0, 1)
  local a=(np.array({{{true},{true}}},np.bool)).T
  local r=np.sum(a,{axis={1,2},keepdims=true,where=np.array({{{false}}},np.bool),initial=0})
  assert(r.dtype=="int64","ext reduction 318 dtype "..r.dtype)
  assert(close(r.shape,{1,1,1}),"ext reduction 318 shape")
  assert(close(r.strides,{8,8,8}),"ext reduction 318 strides")
  assert(close(r:tolist(),{{{0}}}),"ext reduction 318 values")
end
do -- extended reduction 319: sum int32 shape=[0, 4, 1, 2] axis=-4
  local a=np.zeros({0,4,1,2},np.int32)
  local r=np.sum(a,{axis=-4,keepdims=false,where=np.array({{{{true,true}}}},np.bool)})
  assert(r.dtype=="int64","ext reduction 319 dtype "..r.dtype)
  assert(close(r.shape,{4,1,2}),"ext reduction 319 shape")
  assert(close(r.strides,{16,16,8}),"ext reduction 319 strides")
  assert(close(r:tolist(),{{{0,0}},{{0,0}},{{0,0}},{{0,0}}}),"ext reduction 319 values")
end
do local a=np.reshape(np.arange(6),{2,3}); local r=np.sum(a,{}); assert(close(r:tolist(),a:tolist()),"axis empty tuple copy") end
do local a=np.reshape(np.arange(6),{2,3}); local r=np.sum(a,{axis={},initial=10}); assert(close(r:tolist(),{{10,11,12},{13,14,15}}),"axis empty initial") end
do local a=np.reshape(np.arange(12),{4,3}); local o=np.zeros({1,3},np.float64); local r=np.sum(a,{axis=1,keepdims=true,out=o}); assert(r==o and close(o:tolist(),{{18,22,26}}),"keepdims out exact shape") end
do local a=np.array({100,100},np.int8); local o=np.zeros({},np.int8); np.sum(a,{out=o}); assert(o:tolist()==-56,"out dtype seeds sum accumulator") end
do local a=np.array({1.8,2.8},np.float64); local o=np.zeros({},np.int32); np.mean(a,{out=o}); assert(o:tolist()==2,"mean out does not seed accumulator") end
print('extended reduction differential: 325 cases ok')
