local np=require("luaray_core")
local function eq(a,b)
  if type(a)~=type(b) then return false end
  if type(a)~="table" then return a==b end
  if #a~=#b then return false end
  for i=1,#a do if not eq(a[i],b[i]) then return false end end
  return true
end
-- Generated against development NumPy 2.3.5.
do
  local a=np.reshape(np.arange(12),{3,4})
  local ix1=np.array({1,3},np.int64)
  local got=a:get(ix1)
  assert(eq(got.shape,{2,4}),'advanced get 0 shape')
  assert(eq(got.strides,{32,8}),'advanced get 0 strides')
  assert(eq(got:tolist(),{{0,1,2,3},{8,9,10,11}}),'advanced get 0 values')
end
do
  local a=np.reshape(np.arange(12),{3,4})
  local ix1=np.array({1,3},np.int64)
  local got=a:get(np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{3,2}),'advanced get 1 shape')
  assert(eq(got.strides,{8,24}),'advanced get 1 strides')
  assert(eq(got:tolist(),{{0,2},{4,6},{8,10}}),'advanced get 1 values')
end
do
  local a=np.reshape(np.arange(60),{3,4,5})
  local ix1=np.array({1,3},np.int64)
  local ix2=np.array({1,5},np.int64)
  local got=a:get(ix1,np.slice(nil,nil,1),ix2)
  assert(eq(got.shape,{2,4}),'advanced get 2 shape')
  assert(eq(got.strides,{32,8}),'advanced get 2 strides')
  assert(eq(got:tolist(),{{0,5,10,15},{44,49,54,59}}),'advanced get 2 values')
end
do
  local a=np.reshape(np.arange(60),{3,4,5})
  local ix1=np.array({1,5},np.int64)
  local got=a:get(2,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{2,4}),'advanced get 3 shape')
  assert(eq(got.strides,{32,8}),'advanced get 3 strides')
  assert(eq(got:tolist(),{{20,25,30,35},{24,29,34,39}}),'advanced get 3 values')
end
do
  local a=np.reshape(np.arange(60),{3,4,5})
  local ix1=np.array({1,5},np.int64)
  local got=a:get(np.slice(nil,nil,1),2,ix1)
  assert(eq(got.shape,{3,2}),'advanced get 4 shape')
  assert(eq(got.strides,{8,24}),'advanced get 4 strides')
  assert(eq(got:tolist(),{{5,9},{25,29},{45,49}}),'advanced get 4 values')
end
do
  local a=np.reshape(np.arange(60),{3,4,5})
  local ix1=np.array({{1},{3}},np.int64)
  local ix2=np.array({{1,4,2}},np.int64)
  local got=a:get(ix1,ix2)
  assert(eq(got.shape,{2,3,5}),'advanced get 5 shape')
  assert(eq(got.strides,{120,40,8}),'advanced get 5 strides')
  assert(eq(got:tolist(),{{{0,1,2,3,4},{15,16,17,18,19},{5,6,7,8,9}},{{40,41,42,43,44},{55,56,57,58,59},{45,46,47,48,49}}}),'advanced get 5 values')
end
do
  local a=np.reshape(np.arange(12),{3,4})
  local ix1=np.array({true,false,true},np.bool)
  local got=a:get(ix1,np.ellipsis)
  assert(eq(got.shape,{2,4}),'advanced get 6 shape')
  assert(eq(got.strides,{32,8}),'advanced get 6 strides')
  assert(eq(got:tolist(),{{0,1,2,3},{8,9,10,11}}),'advanced get 6 values')
end
do
  local a=np.reshape(np.arange(60),{3,4,5})
  local ix1=np.array({{true,false,false,true},{false,true,false,false},{true,false,true,false}},np.bool)
  local got=a:get(ix1,np.slice(nil,nil,1))
  assert(eq(got.shape,{5,5}),'advanced get 7 shape')
  assert(eq(got.strides,{40,8}),'advanced get 7 strides')
  assert(eq(got:tolist(),{{0,1,2,3,4},{15,16,17,18,19},{25,26,27,28,29},{40,41,42,43,44},{50,51,52,53,54}}),'advanced get 7 values')
end
do
  local a=np.reshape(np.arange(12),{3,4})
  local ix1=np.array({{true,false,true,false},{false,true,false,true},{true,false,false,false}},np.bool)
  local got=a:get(ix1)
  assert(eq(got.shape,{5}),'advanced get 8 shape')
  assert(eq(got.strides,{8}),'advanced get 8 strides')
  assert(eq(got:tolist(),{0,2,5,7,8}),'advanced get 8 values')
end
do
  local a=np.reshape(np.arange(12),{3,4})
  local ix1=np.reshape(np.array({true},np.bool),{})
  local got=a:get(ix1)
  assert(eq(got.shape,{1,3,4}),'advanced get 9 shape')
  assert(eq(got.strides,{96,32,8}),'advanced get 9 strides')
  assert(eq(got:tolist(),{{{0,1,2,3},{4,5,6,7},{8,9,10,11}}}),'advanced get 9 values')
end
do
  local a=np.reshape(np.arange(12),{3,4})
  local ix1=np.reshape(np.array({false},np.bool),{})
  local got=a:get(ix1)
  assert(eq(got.shape,{0,3,4}),'advanced get 10 shape')
  assert(eq(got.strides,{0,0,0}),'advanced get 10 strides')
  assert(eq(got:tolist(),{}),'advanced get 10 values')
end
do
  local a=np.reshape(np.arange(12),{3,4})
  local ix1=np.reshape(np.array({2},np.int64),{})
  local got=a:get(ix1,np.slice(nil,nil,1))
  assert(eq(got.shape,{4}),'advanced get 11 shape')
  assert(eq(got.strides,{8}),'advanced get 11 strides')
  assert(eq(got:tolist(),{4,5,6,7}),'advanced get 11 values')
end
do
  local a=np.reshape(np.arange(5),{5})
  local ix1=np.array({-1,1,3},np.int64)
  local got=a:get(ix1)
  assert(eq(got.shape,{3}),'advanced get 12 shape')
  assert(eq(got.strides,{8}),'advanced get 12 strides')
  assert(eq(got:tolist(),{4,0,2}),'advanced get 12 values')
end
do
  local a=np.reshape(np.arange(4),{4})
  local ix1=np.array({{1,2},{4,3}},np.int64).T
  local got=a:get(ix1)
  assert(eq(got.shape,{2,2}),'advanced get 13 shape')
  assert(eq(got.strides,{8,16}),'advanced get 13 strides')
  assert(eq(got:tolist(),{{0,3},{1,2}}),'advanced get 13 values')
end
do
  local a=np.reshape(np.arange(60),{3,4,5})
  local ix1=np.array({1,4},np.int64)
  local got=a:get(np.newaxis,np.slice(nil,nil,1),ix1,np.ellipsis)
  assert(eq(got.shape,{1,3,2,5}),'advanced get 14 shape')
  assert(eq(got.strides,{8,40,120,8}),'advanced get 14 strides')
  assert(eq(got:tolist(),{{{{0,1,2,3,4},{15,16,17,18,19}},{{20,21,22,23,24},{35,36,37,38,39}},{{40,41,42,43,44},{55,56,57,58,59}}}}),'advanced get 14 values')
end
do
  local a=np.reshape(np.arange(30),{5,3,2})
  local ix1=np.array({1,2},np.int64)
  local ix2=np.array({-1,1},np.int64)
  local got=a:get(ix1,np.slice(nil,nil,1),ix2)
  assert(eq(got.shape,{2,3}),'advanced get 15 shape')
  assert(eq(got.strides,{24,8}),'advanced get 15 strides')
  assert(eq(got:tolist(),{{1,3,5},{6,8,10}}),'advanced get 15 values')
end
do
  local a=np.reshape(np.arange(30),{3,2,5})
  local ix1=np.array({3},np.int64)
  local ix2=np.array({2},np.int64)
  local got=a:get(ix1,np.slice(nil,nil,1),ix2)
  assert(eq(got.shape,{1,2}),'advanced get 16 shape')
  assert(eq(got.strides,{16,8}),'advanced get 16 strides')
  assert(eq(got:tolist(),{{21,26}}),'advanced get 16 values')
end
do
  local a=np.reshape(np.arange(40),{2,5,4})
  local ix1=np.array({{false,true,true,false,false},{false,true,false,false,true}},np.bool)
  local got=a:get(ix1,np.slice(nil,nil,1))
  assert(eq(got.shape,{4,4}),'advanced get 17 shape')
  assert(eq(got.strides,{32,8}),'advanced get 17 strides')
  assert(eq(got:tolist(),{{4,5,6,7},{8,9,10,11},{24,25,26,27},{36,37,38,39}}),'advanced get 17 values')
end
do
  local a=np.reshape(np.arange(45),{3,3,5})
  local ix1=np.array({true,true,true},np.bool)
  local got=a:get(ix1,np.ellipsis)
  assert(eq(got.shape,{3,3,5}),'advanced get 18 shape')
  assert(eq(got.strides,{120,40,8}),'advanced get 18 strides')
  assert(eq(got:tolist(),{{{0,1,2,3,4},{5,6,7,8,9},{10,11,12,13,14}},{{15,16,17,18,19},{20,21,22,23,24},{25,26,27,28,29}},{{30,31,32,33,34},{35,36,37,38,39},{40,41,42,43,44}}}),'advanced get 18 values')
end
do
  local a=np.reshape(np.arange(30),{5,3,2})
  local ix1=np.array({{-1}},np.int64)
  local ix2=np.array({{-3,2}},np.int64)
  local got=a:get(ix1,ix2,np.slice(nil,nil,1))
  assert(eq(got.shape,{1,2,2}),'advanced get 19 shape')
  assert(eq(got.strides,{32,16,8}),'advanced get 19 strides')
  assert(eq(got:tolist(),{{{24,25},{26,27}}}),'advanced get 19 values')
end
do
  local a=np.reshape(np.arange(32),{2,4,4})
  local ix1=np.array({false,false},np.bool)
  local got=a:get(ix1,np.ellipsis)
  assert(eq(got.shape,{0,4,4}),'advanced get 20 shape')
  assert(eq(got.strides,{0,0,0}),'advanced get 20 strides')
  assert(eq(got:tolist(),{}),'advanced get 20 values')
end
do
  local a=np.reshape(np.arange(45),{3,5,3})
  local ix1=np.array({1},np.int64)
  local ix2=np.array({3},np.int64)
  local got=a:get(ix1,np.slice(nil,nil,1),ix2)
  assert(eq(got.shape,{1,5}),'advanced get 21 shape')
  assert(eq(got.strides,{40,8}),'advanced get 21 strides')
  assert(eq(got:tolist(),{{2,5,8,11,14}}),'advanced get 21 values')
end
do
  local a=np.reshape(np.arange(45),{3,5,3})
  local ix1=np.array({2},np.int64)
  local ix2=np.array({2},np.int64)
  local got=a:get(ix1,np.slice(nil,nil,1),ix2)
  assert(eq(got.shape,{1,5}),'advanced get 22 shape')
  assert(eq(got.strides,{40,8}),'advanced get 22 strides')
  assert(eq(got:tolist(),{{16,19,22,25,28}}),'advanced get 22 values')
end
do
  local a=np.reshape(np.arange(16),{2,2,4})
  local ix1=np.array({true,true},np.bool)
  local got=a:get(ix1,np.ellipsis)
  assert(eq(got.shape,{2,2,4}),'advanced get 23 shape')
  assert(eq(got.strides,{64,32,8}),'advanced get 23 strides')
  assert(eq(got:tolist(),{{{0,1,2,3},{4,5,6,7}},{{8,9,10,11},{12,13,14,15}}}),'advanced get 23 values')
end
do
  local a=np.reshape(np.arange(16),{2,4,2})
  local ix1=np.array({1,1,2},np.int64)
  local got=a:get(1,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{3,4}),'advanced get 24 shape')
  assert(eq(got.strides,{32,8}),'advanced get 24 strides')
  assert(eq(got:tolist(),{{0,2,4,6},{0,2,4,6},{1,3,5,7}}),'advanced get 24 values')
end
do
  local a=np.reshape(np.arange(32),{2,4,4})
  local ix1=np.array({2,1},np.int64)
  local got=a:get(np.slice(nil,nil,1),ix1,np.ellipsis)
  assert(eq(got.shape,{2,2,4}),'advanced get 25 shape')
  assert(eq(got.strides,{32,64,8}),'advanced get 25 strides')
  assert(eq(got:tolist(),{{{4,5,6,7},{0,1,2,3}},{{20,21,22,23},{16,17,18,19}}}),'advanced get 25 values')
end
do
  local a=np.reshape(np.arange(100),{4,5,5})
  local ix1=np.array({true,true,true,false},np.bool)
  local got=a:get(ix1,np.ellipsis)
  assert(eq(got.shape,{3,5,5}),'advanced get 26 shape')
  assert(eq(got.strides,{200,40,8}),'advanced get 26 strides')
  assert(eq(got:tolist(),{{{0,1,2,3,4},{5,6,7,8,9},{10,11,12,13,14},{15,16,17,18,19},{20,21,22,23,24}},{{25,26,27,28,29},{30,31,32,33,34},{35,36,37,38,39},{40,41,42,43,44},{45,46,47,48,49}},{{50,51,52,53,54},{55,56,57,58,59},{60,61,62,63,64},{65,66,67,68,69},{70,71,72,73,74}}}),'advanced get 26 values')
end
do
  local a=np.reshape(np.arange(64),{4,4,4})
  local ix1=np.array({{-4}},np.int64)
  local ix2=np.array({{2,-1,-1}},np.int64)
  local got=a:get(ix1,ix2,np.slice(nil,nil,1))
  assert(eq(got.shape,{1,3,4}),'advanced get 27 shape')
  assert(eq(got.strides,{96,32,8}),'advanced get 27 strides')
  assert(eq(got:tolist(),{{{4,5,6,7},{12,13,14,15},{12,13,14,15}}}),'advanced get 27 values')
end
do
  local a=np.reshape(np.arange(18),{3,2,3})
  local ix1=np.array({{false,false},{false,false},{false,false}},np.bool)
  local got=a:get(ix1,np.slice(nil,nil,1))
  assert(eq(got.shape,{0,3}),'advanced get 28 shape')
  assert(eq(got.strides,{0,0}),'advanced get 28 strides')
  assert(eq(got:tolist(),{}),'advanced get 28 values')
end
do
  local a=np.reshape(np.arange(60),{5,4,3})
  local ix1=np.array({2,-1},np.int64)
  local got=a:get(np.newaxis,ix1,np.slice(nil,nil,1),np.ellipsis)
  assert(eq(got.shape,{1,2,4,3}),'advanced get 29 shape')
  assert(eq(got.strides,{8,96,24,8}),'advanced get 29 strides')
  assert(eq(got:tolist(),{{{{12,13,14},{15,16,17},{18,19,20},{21,22,23}},{{48,49,50},{51,52,53},{54,55,56},{57,58,59}}}}),'advanced get 29 values')
end
do
  local a=np.reshape(np.arange(20),{5,2,2})
  local ix1=np.array({2},np.int64)
  local got=a:get(np.slice(nil,nil,1),ix1,np.ellipsis)
  assert(eq(got.shape,{5,1,2}),'advanced get 30 shape')
  assert(eq(got.strides,{16,80,8}),'advanced get 30 strides')
  assert(eq(got:tolist(),{{{2,3}},{{6,7}},{{10,11}},{{14,15}},{{18,19}}}),'advanced get 30 values')
end
do
  local a=np.reshape(np.arange(36),{3,3,4})
  local ix1=np.array({2,-2,2},np.int64)
  local ix2=np.array({2,-1,-4},np.int64)
  local got=a:get(ix1,np.slice(nil,nil,1),ix2)
  assert(eq(got.shape,{3,3}),'advanced get 31 shape')
  assert(eq(got.strides,{24,8}),'advanced get 31 strides')
  assert(eq(got:tolist(),{{13,17,21},{15,19,23},{12,16,20}}),'advanced get 31 values')
end
do
  local a=np.reshape(np.arange(30),{2,5,3})
  local ix1=np.array({-1,1,1},np.int64)
  local got=a:get(1,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{3,5}),'advanced get 32 shape')
  assert(eq(got.strides,{40,8}),'advanced get 32 strides')
  assert(eq(got:tolist(),{{2,5,8,11,14},{0,3,6,9,12},{0,3,6,9,12}}),'advanced get 32 values')
end
do
  local a=np.reshape(np.arange(18),{3,3,2})
  local ix1=np.array({2,3},np.int64)
  local got=a:get(ix1)
  assert(eq(got.shape,{2,3,2}),'advanced get 33 shape')
  assert(eq(got.strides,{48,16,8}),'advanced get 33 strides')
  assert(eq(got:tolist(),{{{6,7},{8,9},{10,11}},{{12,13},{14,15},{16,17}}}),'advanced get 33 values')
end
do
  local a=np.reshape(np.arange(20),{2,5,2})
  local ix1=np.array({false,true},np.bool)
  local got=a:get(ix1,np.ellipsis)
  assert(eq(got.shape,{1,5,2}),'advanced get 34 shape')
  assert(eq(got.strides,{80,16,8}),'advanced get 34 strides')
  assert(eq(got:tolist(),{{{10,11},{12,13},{14,15},{16,17},{18,19}}}),'advanced get 34 values')
end
do
  local a=np.reshape(np.arange(40),{4,5,2})
  local ix1=np.array({2,4,3},np.int64)
  local got=a:get(ix1)
  assert(eq(got.shape,{3,5,2}),'advanced get 35 shape')
  assert(eq(got.strides,{80,16,8}),'advanced get 35 strides')
  assert(eq(got:tolist(),{{{10,11},{12,13},{14,15},{16,17},{18,19}},{{30,31},{32,33},{34,35},{36,37},{38,39}},{{20,21},{22,23},{24,25},{26,27},{28,29}}}),'advanced get 35 values')
end
do
  local a=np.reshape(np.arange(36),{3,4,3})
  local ix1=np.array({4,1,-1},np.int64)
  local got=a:get(np.slice(nil,nil,1),ix1,np.ellipsis)
  assert(eq(got.shape,{3,3,3}),'advanced get 36 shape')
  assert(eq(got.strides,{24,72,8}),'advanced get 36 strides')
  assert(eq(got:tolist(),{{{9,10,11},{0,1,2},{9,10,11}},{{21,22,23},{12,13,14},{21,22,23}},{{33,34,35},{24,25,26},{33,34,35}}}),'advanced get 36 values')
end
do
  local a=np.reshape(np.arange(32),{4,2,4})
  local ix1=np.array({-3},np.int64)
  local got=a:get(np.newaxis,ix1,np.slice(nil,nil,1),np.ellipsis)
  assert(eq(got.shape,{1,1,2,4}),'advanced get 37 shape')
  assert(eq(got.strides,{8,64,32,8}),'advanced get 37 strides')
  assert(eq(got:tolist(),{{{{8,9,10,11},{12,13,14,15}}}}),'advanced get 37 values')
end
do
  local a=np.reshape(np.arange(80),{4,4,5})
  local ix1=np.array({1},np.int64)
  local ix2=np.array({5},np.int64)
  local got=a:get(ix1,np.slice(nil,nil,1),ix2)
  assert(eq(got.shape,{1,4}),'advanced get 38 shape')
  assert(eq(got.strides,{32,8}),'advanced get 38 strides')
  assert(eq(got:tolist(),{{4,9,14,19}}),'advanced get 38 values')
end
do
  local a=np.reshape(np.arange(36),{3,3,4})
  local ix1=np.array({2},np.int64)
  local got=a:get(1,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{1,3}),'advanced get 39 shape')
  assert(eq(got.strides,{24,8}),'advanced get 39 strides')
  assert(eq(got:tolist(),{{1,5,9}}),'advanced get 39 values')
end
do
  local a=np.reshape(np.arange(50),{5,2,5})
  local ix1=np.array({false,false,true,false,false},np.bool)
  local got=a:get(ix1,np.ellipsis)
  assert(eq(got.shape,{1,2,5}),'advanced get 40 shape')
  assert(eq(got.strides,{80,40,8}),'advanced get 40 strides')
  assert(eq(got:tolist(),{{{20,21,22,23,24},{25,26,27,28,29}}}),'advanced get 40 values')
end
do
  local a=np.reshape(np.arange(16),{2,4,2})
  local ix1=np.array({1,2,-1},np.int64)
  local got=a:get(1,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{3,4}),'advanced get 41 shape')
  assert(eq(got.strides,{32,8}),'advanced get 41 strides')
  assert(eq(got:tolist(),{{0,2,4,6},{1,3,5,7},{1,3,5,7}}),'advanced get 41 values')
end
do
  local a=np.reshape(np.arange(48),{4,3,4})
  local ix1=np.array({1,3,1},np.int64)
  local got=a:get(3,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{3,3}),'advanced get 42 shape')
  assert(eq(got.strides,{24,8}),'advanced get 42 strides')
  assert(eq(got:tolist(),{{24,28,32},{26,30,34},{24,28,32}}),'advanced get 42 values')
end
do
  local a=np.reshape(np.arange(36),{3,4,3})
  local ix1=np.array({{3}},np.int64)
  local ix2=np.array({{-1,2}},np.int64)
  local got=a:get(ix1,ix2,np.slice(nil,nil,1))
  assert(eq(got.shape,{1,2,3}),'advanced get 43 shape')
  assert(eq(got.strides,{48,24,8}),'advanced get 43 strides')
  assert(eq(got:tolist(),{{{33,34,35},{27,28,29}}}),'advanced get 43 values')
end
do
  local a=np.reshape(np.arange(45),{5,3,3})
  local ix1=np.array({2},np.int64)
  local got=a:get(5,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{1,3}),'advanced get 44 shape')
  assert(eq(got.strides,{24,8}),'advanced get 44 strides')
  assert(eq(got:tolist(),{{37,40,43}}),'advanced get 44 values')
end
do
  local a=np.reshape(np.arange(30),{5,3,2})
  local ix1=np.array({5,3,2},np.int64)
  local ix2=np.array({1,2,-2},np.int64)
  local got=a:get(ix1,np.slice(nil,nil,1),ix2)
  assert(eq(got.shape,{3,3}),'advanced get 45 shape')
  assert(eq(got.strides,{24,8}),'advanced get 45 strides')
  assert(eq(got:tolist(),{{24,26,28},{13,15,17},{6,8,10}}),'advanced get 45 values')
end
do
  local a=np.reshape(np.arange(30),{2,3,5})
  local ix1=np.array({false,true},np.bool)
  local got=a:get(ix1,np.ellipsis)
  assert(eq(got.shape,{1,3,5}),'advanced get 46 shape')
  assert(eq(got.strides,{120,40,8}),'advanced get 46 strides')
  assert(eq(got:tolist(),{{{15,16,17,18,19},{20,21,22,23,24},{25,26,27,28,29}}}),'advanced get 46 values')
end
do
  local a=np.reshape(np.arange(60),{4,5,3})
  local ix1=np.array({{-3},{-4},{2}},np.int64)
  local ix2=np.array({{-2}},np.int64)
  local got=a:get(ix1,ix2,np.slice(nil,nil,1))
  assert(eq(got.shape,{3,1,3}),'advanced get 47 shape')
  assert(eq(got.strides,{24,24,8}),'advanced get 47 strides')
  assert(eq(got:tolist(),{{{24,25,26}},{{9,10,11}},{{24,25,26}}}),'advanced get 47 values')
end
do
  local a=np.reshape(np.arange(125),{5,5,5})
  local ix1=np.array({{-5}},np.int64)
  local ix2=np.array({{4}},np.int64)
  local got=a:get(ix1,ix2,np.slice(nil,nil,1))
  assert(eq(got.shape,{1,1,5}),'advanced get 48 shape')
  assert(eq(got.strides,{40,40,8}),'advanced get 48 strides')
  assert(eq(got:tolist(),{{{15,16,17,18,19}}}),'advanced get 48 values')
end
do
  local a=np.reshape(np.arange(30),{5,3,2})
  local ix1=np.array({-2},np.int64)
  local ix2=np.array({-2},np.int64)
  local got=a:get(ix1,np.slice(nil,nil,1),ix2)
  assert(eq(got.shape,{1,3}),'advanced get 49 shape')
  assert(eq(got.strides,{24,8}),'advanced get 49 strides')
  assert(eq(got:tolist(),{{18,20,22}}),'advanced get 49 values')
end
do
  local a=np.reshape(np.arange(12),{2,2,3})
  local ix1=np.array({true,false},np.bool)
  local got=a:get(ix1,np.ellipsis)
  assert(eq(got.shape,{1,2,3}),'advanced get 50 shape')
  assert(eq(got.strides,{48,24,8}),'advanced get 50 strides')
  assert(eq(got:tolist(),{{{0,1,2},{3,4,5}}}),'advanced get 50 values')
end
do
  local a=np.reshape(np.arange(100),{5,5,4})
  local ix1=np.array({2},np.int64)
  local ix2=np.array({1},np.int64)
  local got=a:get(ix1,np.slice(nil,nil,1),ix2)
  assert(eq(got.shape,{1,5}),'advanced get 51 shape')
  assert(eq(got.strides,{40,8}),'advanced get 51 strides')
  assert(eq(got:tolist(),{{20,24,28,32,36}}),'advanced get 51 values')
end
do
  local a=np.reshape(np.arange(60),{5,4,3})
  local ix1=np.array({true,false,true,false,false},np.bool)
  local got=a:get(ix1,np.ellipsis)
  assert(eq(got.shape,{2,4,3}),'advanced get 52 shape')
  assert(eq(got.strides,{96,24,8}),'advanced get 52 strides')
  assert(eq(got:tolist(),{{{0,1,2},{3,4,5},{6,7,8},{9,10,11}},{{24,25,26},{27,28,29},{30,31,32},{33,34,35}}}),'advanced get 52 values')
end
do
  local a=np.reshape(np.arange(50),{2,5,5})
  local ix1=np.array({{2},{1}},np.int64)
  local ix2=np.array({{5}},np.int64)
  local got=a:get(ix1,ix2,np.slice(nil,nil,1))
  assert(eq(got.shape,{2,1,5}),'advanced get 53 shape')
  assert(eq(got.strides,{40,40,8}),'advanced get 53 strides')
  assert(eq(got:tolist(),{{{45,46,47,48,49}},{{20,21,22,23,24}}}),'advanced get 53 values')
end
do
  local a=np.reshape(np.arange(45),{3,3,5})
  local ix1=np.array({2,-3,2},np.int64)
  local got=a:get(3,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{3,3}),'advanced get 54 shape')
  assert(eq(got.strides,{24,8}),'advanced get 54 strides')
  assert(eq(got:tolist(),{{31,36,41},{32,37,42},{31,36,41}}),'advanced get 54 values')
end
do
  local a=np.reshape(np.arange(45),{3,5,3})
  local ix1=np.array({4,4},np.int64)
  local got=a:get(np.slice(nil,nil,1),ix1,np.ellipsis)
  assert(eq(got.shape,{3,2,3}),'advanced get 55 shape')
  assert(eq(got.strides,{24,72,8}),'advanced get 55 strides')
  assert(eq(got:tolist(),{{{9,10,11},{9,10,11}},{{24,25,26},{24,25,26}},{{39,40,41},{39,40,41}}}),'advanced get 55 values')
end
do
  local a=np.reshape(np.arange(18),{3,2,3})
  local ix1=np.array({-2,1},np.int64)
  local got=a:get(np.newaxis,ix1,np.slice(nil,nil,1),np.ellipsis)
  assert(eq(got.shape,{1,2,2,3}),'advanced get 56 shape')
  assert(eq(got.strides,{8,48,24,8}),'advanced get 56 strides')
  assert(eq(got:tolist(),{{{{6,7,8},{9,10,11}},{{0,1,2},{3,4,5}}}}),'advanced get 56 values')
end
do
  local a=np.reshape(np.arange(30),{5,2,3})
  local ix1=np.array({-2,1,2},np.int64)
  local got=a:get(ix1)
  assert(eq(got.shape,{3,2,3}),'advanced get 57 shape')
  assert(eq(got.strides,{48,24,8}),'advanced get 57 strides')
  assert(eq(got:tolist(),{{{18,19,20},{21,22,23}},{{0,1,2},{3,4,5}},{{6,7,8},{9,10,11}}}),'advanced get 57 values')
end
do
  local a=np.reshape(np.arange(40),{2,4,5})
  local ix1=np.array({{2}},np.int64)
  local ix2=np.array({{1,-4,1}},np.int64)
  local got=a:get(ix1,ix2,np.slice(nil,nil,1))
  assert(eq(got.shape,{1,3,5}),'advanced get 58 shape')
  assert(eq(got.strides,{120,40,8}),'advanced get 58 strides')
  assert(eq(got:tolist(),{{{20,21,22,23,24},{20,21,22,23,24},{20,21,22,23,24}}}),'advanced get 58 values')
end
do
  local a=np.reshape(np.arange(30),{2,5,3})
  local ix1=np.array({2,-1,1},np.int64)
  local got=a:get(np.newaxis,ix1,np.slice(nil,nil,1),np.ellipsis)
  assert(eq(got.shape,{1,3,5,3}),'advanced get 59 shape')
  assert(eq(got.strides,{8,120,24,8}),'advanced get 59 strides')
  assert(eq(got:tolist(),{{{{15,16,17},{18,19,20},{21,22,23},{24,25,26},{27,28,29}},{{15,16,17},{18,19,20},{21,22,23},{24,25,26},{27,28,29}},{{0,1,2},{3,4,5},{6,7,8},{9,10,11},{12,13,14}}}}),'advanced get 59 values')
end
do
  local a=np.reshape(np.arange(12),{3,2,2})
  local ix1=np.array({1},np.int64)
  local ix2=np.array({2},np.int64)
  local got=a:get(ix1,np.slice(nil,nil,1),ix2)
  assert(eq(got.shape,{1,2}),'advanced get 60 shape')
  assert(eq(got.strides,{16,8}),'advanced get 60 strides')
  assert(eq(got:tolist(),{{1,3}}),'advanced get 60 values')
end
do
  local a=np.reshape(np.arange(50),{5,5,2})
  local ix1=np.array({{true,false,false,false,false},{true,false,false,true,false},{false,false,true,false,true},{true,false,false,false,false},{false,false,false,false,false}},np.bool)
  local got=a:get(ix1,np.slice(nil,nil,1))
  assert(eq(got.shape,{6,2}),'advanced get 61 shape')
  assert(eq(got.strides,{16,8}),'advanced get 61 strides')
  assert(eq(got:tolist(),{{0,1},{10,11},{16,17},{24,25},{28,29},{30,31}}),'advanced get 61 values')
end
do
  local a=np.reshape(np.arange(40),{2,4,5})
  local ix1=np.array({true,true},np.bool)
  local got=a:get(ix1,np.ellipsis)
  assert(eq(got.shape,{2,4,5}),'advanced get 62 shape')
  assert(eq(got.strides,{160,40,8}),'advanced get 62 strides')
  assert(eq(got:tolist(),{{{0,1,2,3,4},{5,6,7,8,9},{10,11,12,13,14},{15,16,17,18,19}},{{20,21,22,23,24},{25,26,27,28,29},{30,31,32,33,34},{35,36,37,38,39}}}),'advanced get 62 values')
end
do
  local a=np.reshape(np.arange(16),{2,2,4})
  local ix1=np.array({-2,2},np.int64)
  local got=a:get(np.newaxis,ix1,np.slice(nil,nil,1),np.ellipsis)
  assert(eq(got.shape,{1,2,2,4}),'advanced get 63 shape')
  assert(eq(got.strides,{8,64,32,8}),'advanced get 63 strides')
  assert(eq(got:tolist(),{{{{0,1,2,3},{4,5,6,7}},{{8,9,10,11},{12,13,14,15}}}}),'advanced get 63 values')
end
do
  local a=np.reshape(np.arange(12),{2,3,2})
  local ix1=np.array({-1,2},np.int64)
  local ix2=np.array({1,2},np.int64)
  local got=a:get(ix1,np.slice(nil,nil,1),ix2)
  assert(eq(got.shape,{2,3}),'advanced get 64 shape')
  assert(eq(got.strides,{24,8}),'advanced get 64 strides')
  assert(eq(got:tolist(),{{6,8,10},{7,9,11}}),'advanced get 64 values')
end
do
  local a=np.reshape(np.arange(12),{3,2,2})
  local ix1=np.array({3,1,-1},np.int64)
  local got=a:get(ix1)
  assert(eq(got.shape,{3,2,2}),'advanced get 65 shape')
  assert(eq(got.strides,{32,16,8}),'advanced get 65 strides')
  assert(eq(got:tolist(),{{{8,9},{10,11}},{{0,1},{2,3}},{{8,9},{10,11}}}),'advanced get 65 values')
end
do
  local a=np.reshape(np.arange(32),{4,4,2})
  local ix1=np.array({-2,2,1},np.int64)
  local got=a:get(2,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{3,4}),'advanced get 66 shape')
  assert(eq(got.strides,{32,8}),'advanced get 66 strides')
  assert(eq(got:tolist(),{{8,10,12,14},{9,11,13,15},{8,10,12,14}}),'advanced get 66 values')
end
do
  local a=np.reshape(np.arange(24),{2,4,3})
  local ix1=np.array({true,false},np.bool)
  local got=a:get(ix1,np.ellipsis)
  assert(eq(got.shape,{1,4,3}),'advanced get 67 shape')
  assert(eq(got.strides,{96,24,8}),'advanced get 67 strides')
  assert(eq(got:tolist(),{{{0,1,2},{3,4,5},{6,7,8},{9,10,11}}}),'advanced get 67 values')
end
do
  local a=np.reshape(np.arange(75),{5,5,3})
  local ix1=np.array({{5},{-5},{1}},np.int64)
  local ix2=np.array({{3,-5,2}},np.int64)
  local got=a:get(ix1,ix2,np.slice(nil,nil,1))
  assert(eq(got.shape,{3,3,3}),'advanced get 68 shape')
  assert(eq(got.strides,{72,24,8}),'advanced get 68 strides')
  assert(eq(got:tolist(),{{{66,67,68},{60,61,62},{63,64,65}},{{6,7,8},{0,1,2},{3,4,5}},{{6,7,8},{0,1,2},{3,4,5}}}),'advanced get 68 values')
end
do
  local a=np.reshape(np.arange(80),{4,4,5})
  local ix1=np.array({{4},{3},{2}},np.int64)
  local ix2=np.array({{1}},np.int64)
  local got=a:get(ix1,ix2,np.slice(nil,nil,1))
  assert(eq(got.shape,{3,1,5}),'advanced get 69 shape')
  assert(eq(got.strides,{40,40,8}),'advanced get 69 strides')
  assert(eq(got:tolist(),{{{60,61,62,63,64}},{{40,41,42,43,44}},{{20,21,22,23,24}}}),'advanced get 69 values')
end
do
  local a=np.reshape(np.arange(32),{4,4,2})
  local ix1=np.array({-2},np.int64)
  local got=a:get(1,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{1,4}),'advanced get 70 shape')
  assert(eq(got.strides,{32,8}),'advanced get 70 strides')
  assert(eq(got:tolist(),{{0,2,4,6}}),'advanced get 70 values')
end
do
  local a=np.reshape(np.arange(30),{2,3,5})
  local ix1=np.array({2,4},np.int64)
  local got=a:get(1,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{2,3}),'advanced get 71 shape')
  assert(eq(got.strides,{24,8}),'advanced get 71 strides')
  assert(eq(got:tolist(),{{1,6,11},{3,8,13}}),'advanced get 71 values')
end
do
  local a=np.reshape(np.arange(30),{3,2,5})
  local ix1=np.array({1},np.int64)
  local ix2=np.array({2},np.int64)
  local got=a:get(ix1,np.slice(nil,nil,1),ix2)
  assert(eq(got.shape,{1,2}),'advanced get 72 shape')
  assert(eq(got.strides,{16,8}),'advanced get 72 strides')
  assert(eq(got:tolist(),{{1,6}}),'advanced get 72 values')
end
do
  local a=np.reshape(np.arange(18),{3,3,2})
  local ix1=np.array({3,2,2},np.int64)
  local got=a:get(np.newaxis,ix1,np.slice(nil,nil,1),np.ellipsis)
  assert(eq(got.shape,{1,3,3,2}),'advanced get 73 shape')
  assert(eq(got.strides,{8,48,16,8}),'advanced get 73 strides')
  assert(eq(got:tolist(),{{{{12,13},{14,15},{16,17}},{{6,7},{8,9},{10,11}},{{6,7},{8,9},{10,11}}}}),'advanced get 73 values')
end
do
  local a=np.reshape(np.arange(8),{2,2,2})
  local ix1=np.array({{2},{2},{1}},np.int64)
  local ix2=np.array({{1,1}},np.int64)
  local got=a:get(ix1,ix2,np.slice(nil,nil,1))
  assert(eq(got.shape,{3,2,2}),'advanced get 74 shape')
  assert(eq(got.strides,{32,16,8}),'advanced get 74 strides')
  assert(eq(got:tolist(),{{{4,5},{4,5}},{{4,5},{4,5}},{{0,1},{0,1}}}),'advanced get 74 values')
end
do
  local a=np.reshape(np.arange(30),{2,5,3})
  local ix1=np.array({{false,false,true,false,false},{false,false,false,true,false}},np.bool)
  local got=a:get(ix1,np.slice(nil,nil,1))
  assert(eq(got.shape,{2,3}),'advanced get 75 shape')
  assert(eq(got.strides,{24,8}),'advanced get 75 strides')
  assert(eq(got:tolist(),{{6,7,8},{24,25,26}}),'advanced get 75 values')
end
do
  local a=np.reshape(np.arange(16),{4,2,2})
  local ix1=np.array({-2},np.int64)
  local got=a:get(3,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{1,2}),'advanced get 76 shape')
  assert(eq(got.strides,{16,8}),'advanced get 76 strides')
  assert(eq(got:tolist(),{{8,10}}),'advanced get 76 values')
end
do
  local a=np.reshape(np.arange(125),{5,5,5})
  local ix1=np.array({4,4},np.int64)
  local got=a:get(np.slice(nil,nil,1),ix1,np.ellipsis)
  assert(eq(got.shape,{5,2,5}),'advanced get 77 shape')
  assert(eq(got.strides,{40,200,8}),'advanced get 77 strides')
  assert(eq(got:tolist(),{{{15,16,17,18,19},{15,16,17,18,19}},{{40,41,42,43,44},{40,41,42,43,44}},{{65,66,67,68,69},{65,66,67,68,69}},{{90,91,92,93,94},{90,91,92,93,94}},{{115,116,117,118,119},{115,116,117,118,119}}}),'advanced get 77 values')
end
do
  local a=np.reshape(np.arange(48),{4,3,4})
  local ix1=np.array({3,3},np.int64)
  local got=a:get(np.slice(nil,nil,1),ix1,np.ellipsis)
  assert(eq(got.shape,{4,2,4}),'advanced get 78 shape')
  assert(eq(got.strides,{32,128,8}),'advanced get 78 strides')
  assert(eq(got:tolist(),{{{8,9,10,11},{8,9,10,11}},{{20,21,22,23},{20,21,22,23}},{{32,33,34,35},{32,33,34,35}},{{44,45,46,47},{44,45,46,47}}}),'advanced get 78 values')
end
do
  local a=np.reshape(np.arange(40),{4,2,5})
  local ix1=np.array({5},np.int64)
  local got=a:get(2,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{1,2}),'advanced get 79 shape')
  assert(eq(got.strides,{16,8}),'advanced get 79 strides')
  assert(eq(got:tolist(),{{14,19}}),'advanced get 79 values')
end
do
  local a=np.reshape(np.arange(48),{4,4,3})
  local ix1=np.array({1,2,-1},np.int64)
  local got=a:get(3,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{3,4}),'advanced get 80 shape')
  assert(eq(got.strides,{32,8}),'advanced get 80 strides')
  assert(eq(got:tolist(),{{24,27,30,33},{25,28,31,34},{26,29,32,35}}),'advanced get 80 values')
end
do
  local a=np.reshape(np.arange(40),{4,5,2})
  local ix1=np.array({true,true,false,true},np.bool)
  local got=a:get(ix1,np.ellipsis)
  assert(eq(got.shape,{3,5,2}),'advanced get 81 shape')
  assert(eq(got.strides,{80,16,8}),'advanced get 81 strides')
  assert(eq(got:tolist(),{{{0,1},{2,3},{4,5},{6,7},{8,9}},{{10,11},{12,13},{14,15},{16,17},{18,19}},{{30,31},{32,33},{34,35},{36,37},{38,39}}}),'advanced get 81 values')
end
do
  local a=np.reshape(np.arange(27),{3,3,3})
  local ix1=np.array({1},np.int64)
  local got=a:get(ix1)
  assert(eq(got.shape,{1,3,3}),'advanced get 82 shape')
  assert(eq(got.strides,{72,24,8}),'advanced get 82 strides')
  assert(eq(got:tolist(),{{{0,1,2},{3,4,5},{6,7,8}}}),'advanced get 82 values')
end
do
  local a=np.reshape(np.arange(32),{2,4,4})
  local ix1=np.array({2},np.int64)
  local got=a:get(ix1)
  assert(eq(got.shape,{1,4,4}),'advanced get 83 shape')
  assert(eq(got.strides,{128,32,8}),'advanced get 83 strides')
  assert(eq(got:tolist(),{{{16,17,18,19},{20,21,22,23},{24,25,26,27},{28,29,30,31}}}),'advanced get 83 values')
end
do
  local a=np.reshape(np.arange(40),{5,4,2})
  local ix1=np.array({{true,false,false,false},{false,false,false,false},{false,true,false,true},{true,false,false,true},{true,true,true,false}},np.bool)
  local got=a:get(ix1,np.slice(nil,nil,1))
  assert(eq(got.shape,{8,2}),'advanced get 84 shape')
  assert(eq(got.strides,{16,8}),'advanced get 84 strides')
  assert(eq(got:tolist(),{{0,1},{18,19},{22,23},{24,25},{30,31},{32,33},{34,35},{36,37}}),'advanced get 84 values')
end
do
  local a=np.reshape(np.arange(24),{3,2,4})
  local ix1=np.array({1,3},np.int64)
  local got=a:get(np.newaxis,ix1,np.slice(nil,nil,1),np.ellipsis)
  assert(eq(got.shape,{1,2,2,4}),'advanced get 85 shape')
  assert(eq(got.strides,{8,64,32,8}),'advanced get 85 strides')
  assert(eq(got:tolist(),{{{{0,1,2,3},{4,5,6,7}},{{16,17,18,19},{20,21,22,23}}}}),'advanced get 85 values')
end
do
  local a=np.reshape(np.arange(30),{2,3,5})
  local ix1=np.array({{true,false,true},{true,true,true}},np.bool)
  local got=a:get(ix1,np.slice(nil,nil,1))
  assert(eq(got.shape,{5,5}),'advanced get 86 shape')
  assert(eq(got.strides,{40,8}),'advanced get 86 strides')
  assert(eq(got:tolist(),{{0,1,2,3,4},{10,11,12,13,14},{15,16,17,18,19},{20,21,22,23,24},{25,26,27,28,29}}),'advanced get 86 values')
end
do
  local a=np.reshape(np.arange(45),{5,3,3})
  local ix1=np.array({{true,false,false},{false,false,true},{false,true,false},{false,false,true},{false,false,false}},np.bool)
  local got=a:get(ix1,np.slice(nil,nil,1))
  assert(eq(got.shape,{4,3}),'advanced get 87 shape')
  assert(eq(got.strides,{24,8}),'advanced get 87 strides')
  assert(eq(got:tolist(),{{0,1,2},{15,16,17},{21,22,23},{33,34,35}}),'advanced get 87 values')
end
do
  local a=np.reshape(np.arange(45),{3,5,3})
  local ix1=np.array({{1}},np.int64)
  local ix2=np.array({{4}},np.int64)
  local got=a:get(ix1,ix2,np.slice(nil,nil,1))
  assert(eq(got.shape,{1,1,3}),'advanced get 88 shape')
  assert(eq(got.strides,{24,24,8}),'advanced get 88 strides')
  assert(eq(got:tolist(),{{{9,10,11}}}),'advanced get 88 values')
end
do
  local a=np.reshape(np.arange(30),{5,3,2})
  local ix1=np.array({{2},{5},{3}},np.int64)
  local ix2=np.array({{-3,-2,1}},np.int64)
  local got=a:get(ix1,ix2,np.slice(nil,nil,1))
  assert(eq(got.shape,{3,3,2}),'advanced get 89 shape')
  assert(eq(got.strides,{48,16,8}),'advanced get 89 strides')
  assert(eq(got:tolist(),{{{6,7},{8,9},{6,7}},{{24,25},{26,27},{24,25}},{{12,13},{14,15},{12,13}}}),'advanced get 89 values')
end
do
  local a=np.reshape(np.arange(50),{5,2,5})
  local ix1=np.array({{false,false},{false,true},{false,true},{false,false},{false,true}},np.bool)
  local got=a:get(ix1,np.slice(nil,nil,1))
  assert(eq(got.shape,{3,5}),'advanced get 90 shape')
  assert(eq(got.strides,{40,8}),'advanced get 90 strides')
  assert(eq(got:tolist(),{{15,16,17,18,19},{25,26,27,28,29},{45,46,47,48,49}}),'advanced get 90 values')
end
do
  local a=np.reshape(np.arange(30),{2,3,5})
  local ix1=np.array({2,2,2},np.int64)
  local got=a:get(np.newaxis,ix1,np.slice(nil,nil,1),np.ellipsis)
  assert(eq(got.shape,{1,3,3,5}),'advanced get 91 shape')
  assert(eq(got.strides,{8,120,40,8}),'advanced get 91 strides')
  assert(eq(got:tolist(),{{{{15,16,17,18,19},{20,21,22,23,24},{25,26,27,28,29}},{{15,16,17,18,19},{20,21,22,23,24},{25,26,27,28,29}},{{15,16,17,18,19},{20,21,22,23,24},{25,26,27,28,29}}}}),'advanced get 91 values')
end
do
  local a=np.reshape(np.arange(24),{3,4,2})
  local ix1=np.array({1,1,1},np.int64)
  local got=a:get(2,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{3,4}),'advanced get 92 shape')
  assert(eq(got.strides,{32,8}),'advanced get 92 strides')
  assert(eq(got:tolist(),{{8,10,12,14},{8,10,12,14},{8,10,12,14}}),'advanced get 92 values')
end
do
  local a=np.reshape(np.arange(60),{3,5,4})
  local ix1=np.array({-3,1},np.int64)
  local got=a:get(np.newaxis,ix1,np.slice(nil,nil,1),np.ellipsis)
  assert(eq(got.shape,{1,2,5,4}),'advanced get 93 shape')
  assert(eq(got.strides,{8,160,32,8}),'advanced get 93 strides')
  assert(eq(got:tolist(),{{{{0,1,2,3},{4,5,6,7},{8,9,10,11},{12,13,14,15},{16,17,18,19}},{{0,1,2,3},{4,5,6,7},{8,9,10,11},{12,13,14,15},{16,17,18,19}}}}),'advanced get 93 values')
end
do
  local a=np.reshape(np.arange(50),{5,2,5})
  local ix1=np.array({5},np.int64)
  local ix2=np.array({-2},np.int64)
  local got=a:get(ix1,np.slice(nil,nil,1),ix2)
  assert(eq(got.shape,{1,2}),'advanced get 94 shape')
  assert(eq(got.strides,{16,8}),'advanced get 94 strides')
  assert(eq(got:tolist(),{{43,48}}),'advanced get 94 values')
end
do
  local a=np.reshape(np.arange(36),{3,3,4})
  local ix1=np.array({false,false,true},np.bool)
  local got=a:get(ix1,np.ellipsis)
  assert(eq(got.shape,{1,3,4}),'advanced get 95 shape')
  assert(eq(got.strides,{96,32,8}),'advanced get 95 strides')
  assert(eq(got:tolist(),{{{24,25,26,27},{28,29,30,31},{32,33,34,35}}}),'advanced get 95 values')
end
do
  local a=np.reshape(np.arange(40),{2,4,5})
  local ix1=np.array({{true,true,false,false},{true,false,true,false}},np.bool)
  local got=a:get(ix1,np.slice(nil,nil,1))
  assert(eq(got.shape,{4,5}),'advanced get 96 shape')
  assert(eq(got.strides,{40,8}),'advanced get 96 strides')
  assert(eq(got:tolist(),{{0,1,2,3,4},{5,6,7,8,9},{20,21,22,23,24},{30,31,32,33,34}}),'advanced get 96 values')
end
do
  local a=np.reshape(np.arange(80),{4,5,4})
  local ix1=np.array({4},np.int64)
  local got=a:get(4,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{1,5}),'advanced get 97 shape')
  assert(eq(got.strides,{40,8}),'advanced get 97 strides')
  assert(eq(got:tolist(),{{63,67,71,75,79}}),'advanced get 97 values')
end
do
  local a=np.reshape(np.arange(64),{4,4,4})
  local ix1=np.array({3},np.int64)
  local got=a:get(np.slice(nil,nil,1),ix1,np.ellipsis)
  assert(eq(got.shape,{4,1,4}),'advanced get 98 shape')
  assert(eq(got.strides,{32,128,8}),'advanced get 98 strides')
  assert(eq(got:tolist(),{{{8,9,10,11}},{{24,25,26,27}},{{40,41,42,43}},{{56,57,58,59}}}),'advanced get 98 values')
end
do
  local a=np.reshape(np.arange(30),{3,5,2})
  local ix1=np.array({-5},np.int64)
  local got=a:get(np.slice(nil,nil,1),ix1,np.ellipsis)
  assert(eq(got.shape,{3,1,2}),'advanced get 99 shape')
  assert(eq(got.strides,{16,48,8}),'advanced get 99 strides')
  assert(eq(got:tolist(),{{{0,1}},{{10,11}},{{20,21}}}),'advanced get 99 values')
end
do
  local a=np.reshape(np.arange(75),{3,5,5})
  local ix1=np.array({{2},{2}},np.int64)
  local ix2=np.array({{5}},np.int64)
  local got=a:get(ix1,ix2,np.slice(nil,nil,1))
  assert(eq(got.shape,{2,1,5}),'advanced get 100 shape')
  assert(eq(got.strides,{40,40,8}),'advanced get 100 strides')
  assert(eq(got:tolist(),{{{45,46,47,48,49}},{{45,46,47,48,49}}}),'advanced get 100 values')
end
do
  local a=np.reshape(np.arange(12),{2,3,2})
  local ix1=np.array({2},np.int64)
  local got=a:get(1,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{1,3}),'advanced get 101 shape')
  assert(eq(got.strides,{24,8}),'advanced get 101 strides')
  assert(eq(got:tolist(),{{1,3,5}}),'advanced get 101 values')
end
do
  local a=np.reshape(np.arange(16),{4,2,2})
  local ix1=np.array({-2,1,-2},np.int64)
  local got=a:get(4,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{3,2}),'advanced get 102 shape')
  assert(eq(got.strides,{16,8}),'advanced get 102 strides')
  assert(eq(got:tolist(),{{12,14},{12,14},{12,14}}),'advanced get 102 values')
end
do
  local a=np.reshape(np.arange(45),{3,3,5})
  local ix1=np.array({{true,true,true},{false,false,false},{true,true,false}},np.bool)
  local got=a:get(ix1,np.slice(nil,nil,1))
  assert(eq(got.shape,{5,5}),'advanced get 103 shape')
  assert(eq(got.strides,{40,8}),'advanced get 103 strides')
  assert(eq(got:tolist(),{{0,1,2,3,4},{5,6,7,8,9},{10,11,12,13,14},{30,31,32,33,34},{35,36,37,38,39}}),'advanced get 103 values')
end
do
  local a=np.reshape(np.arange(100),{5,5,4})
  local ix1=np.array({2,5},np.int64)
  local got=a:get(ix1)
  assert(eq(got.shape,{2,5,4}),'advanced get 104 shape')
  assert(eq(got.strides,{160,32,8}),'advanced get 104 strides')
  assert(eq(got:tolist(),{{{20,21,22,23},{24,25,26,27},{28,29,30,31},{32,33,34,35},{36,37,38,39}},{{80,81,82,83},{84,85,86,87},{88,89,90,91},{92,93,94,95},{96,97,98,99}}}),'advanced get 104 values')
end
do
  local a=np.reshape(np.arange(20),{5,2,2})
  local ix1=np.array({-2,-2},np.int64)
  local got=a:get(np.slice(nil,nil,1),ix1,np.ellipsis)
  assert(eq(got.shape,{5,2,2}),'advanced get 105 shape')
  assert(eq(got.strides,{16,80,8}),'advanced get 105 strides')
  assert(eq(got:tolist(),{{{0,1},{0,1}},{{4,5},{4,5}},{{8,9},{8,9}},{{12,13},{12,13}},{{16,17},{16,17}}}),'advanced get 105 values')
end
do
  local a=np.reshape(np.arange(45),{3,3,5})
  local ix1=np.array({3,1,3},np.int64)
  local got=a:get(np.newaxis,ix1,np.slice(nil,nil,1),np.ellipsis)
  assert(eq(got.shape,{1,3,3,5}),'advanced get 106 shape')
  assert(eq(got.strides,{8,120,40,8}),'advanced get 106 strides')
  assert(eq(got:tolist(),{{{{30,31,32,33,34},{35,36,37,38,39},{40,41,42,43,44}},{{0,1,2,3,4},{5,6,7,8,9},{10,11,12,13,14}},{{30,31,32,33,34},{35,36,37,38,39},{40,41,42,43,44}}}}),'advanced get 106 values')
end
do
  local a=np.reshape(np.arange(48),{3,4,4})
  local ix1=np.array({1,1,2},np.int64)
  local got=a:get(np.newaxis,ix1,np.slice(nil,nil,1),np.ellipsis)
  assert(eq(got.shape,{1,3,4,4}),'advanced get 107 shape')
  assert(eq(got.strides,{8,128,32,8}),'advanced get 107 strides')
  assert(eq(got:tolist(),{{{{0,1,2,3},{4,5,6,7},{8,9,10,11},{12,13,14,15}},{{0,1,2,3},{4,5,6,7},{8,9,10,11},{12,13,14,15}},{{16,17,18,19},{20,21,22,23},{24,25,26,27},{28,29,30,31}}}}),'advanced get 107 values')
end
do
  local a=np.reshape(np.arange(24),{2,3,4})
  local ix1=np.array({3,-1},np.int64)
  local got=a:get(np.slice(nil,nil,1),ix1,np.ellipsis)
  assert(eq(got.shape,{2,2,4}),'advanced get 108 shape')
  assert(eq(got.strides,{32,64,8}),'advanced get 108 strides')
  assert(eq(got:tolist(),{{{8,9,10,11},{8,9,10,11}},{{20,21,22,23},{20,21,22,23}}}),'advanced get 108 values')
end
do
  local a=np.reshape(np.arange(50),{5,2,5})
  local ix1=np.array({true,true,true,false,true},np.bool)
  local got=a:get(ix1,np.ellipsis)
  assert(eq(got.shape,{4,2,5}),'advanced get 109 shape')
  assert(eq(got.strides,{80,40,8}),'advanced get 109 strides')
  assert(eq(got:tolist(),{{{0,1,2,3,4},{5,6,7,8,9}},{{10,11,12,13,14},{15,16,17,18,19}},{{20,21,22,23,24},{25,26,27,28,29}},{{40,41,42,43,44},{45,46,47,48,49}}}),'advanced get 109 values')
end
do
  local a=np.reshape(np.arange(60),{3,4,5})
  local ix1=np.array({2},np.int64)
  local got=a:get(np.newaxis,ix1,np.slice(nil,nil,1),np.ellipsis)
  assert(eq(got.shape,{1,1,4,5}),'advanced get 110 shape')
  assert(eq(got.strides,{8,160,40,8}),'advanced get 110 strides')
  assert(eq(got:tolist(),{{{{20,21,22,23,24},{25,26,27,28,29},{30,31,32,33,34},{35,36,37,38,39}}}}),'advanced get 110 values')
end
do
  local a=np.reshape(np.arange(100),{5,5,4})
  local ix1=np.array({-2,2,3},np.int64)
  local got=a:get(3,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{3,5}),'advanced get 111 shape')
  assert(eq(got.strides,{40,8}),'advanced get 111 strides')
  assert(eq(got:tolist(),{{42,46,50,54,58},{41,45,49,53,57},{42,46,50,54,58}}),'advanced get 111 values')
end
do
  local a=np.reshape(np.arange(100),{5,5,4})
  local ix1=np.array({1},np.int64)
  local got=a:get(5,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{1,5}),'advanced get 112 shape')
  assert(eq(got.strides,{40,8}),'advanced get 112 strides')
  assert(eq(got:tolist(),{{80,84,88,92,96}}),'advanced get 112 values')
end
do
  local a=np.reshape(np.arange(20),{2,5,2})
  local ix1=np.array({2,1},np.int64)
  local got=a:get(1,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{2,5}),'advanced get 113 shape')
  assert(eq(got.strides,{40,8}),'advanced get 113 strides')
  assert(eq(got:tolist(),{{1,3,5,7,9},{0,2,4,6,8}}),'advanced get 113 values')
end
do
  local a=np.reshape(np.arange(24),{2,3,4})
  local ix1=np.array({4,2,2},np.int64)
  local got=a:get(1,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{3,3}),'advanced get 114 shape')
  assert(eq(got.strides,{24,8}),'advanced get 114 strides')
  assert(eq(got:tolist(),{{3,7,11},{1,5,9},{1,5,9}}),'advanced get 114 values')
end
do
  local a=np.reshape(np.arange(24),{2,4,3})
  local ix1=np.array({3,1,1},np.int64)
  local got=a:get(np.slice(nil,nil,1),ix1,np.ellipsis)
  assert(eq(got.shape,{2,3,3}),'advanced get 115 shape')
  assert(eq(got.strides,{24,48,8}),'advanced get 115 strides')
  assert(eq(got:tolist(),{{{6,7,8},{0,1,2},{0,1,2}},{{18,19,20},{12,13,14},{12,13,14}}}),'advanced get 115 values')
end
do
  local a=np.reshape(np.arange(12),{2,2,3})
  local ix1=np.array({3,-2,2},np.int64)
  local got=a:get(1,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{3,2}),'advanced get 116 shape')
  assert(eq(got.strides,{16,8}),'advanced get 116 strides')
  assert(eq(got:tolist(),{{2,5},{1,4},{1,4}}),'advanced get 116 values')
end
do
  local a=np.reshape(np.arange(48),{3,4,4})
  local ix1=np.array({2},np.int64)
  local got=a:get(np.newaxis,ix1,np.slice(nil,nil,1),np.ellipsis)
  assert(eq(got.shape,{1,1,4,4}),'advanced get 117 shape')
  assert(eq(got.strides,{8,128,32,8}),'advanced get 117 strides')
  assert(eq(got:tolist(),{{{{16,17,18,19},{20,21,22,23},{24,25,26,27},{28,29,30,31}}}}),'advanced get 117 values')
end
do
  local a=np.reshape(np.arange(40),{5,2,4})
  local ix1=np.array({true,true,false,true,true},np.bool)
  local got=a:get(ix1,np.ellipsis)
  assert(eq(got.shape,{4,2,4}),'advanced get 118 shape')
  assert(eq(got.strides,{64,32,8}),'advanced get 118 strides')
  assert(eq(got:tolist(),{{{0,1,2,3},{4,5,6,7}},{{8,9,10,11},{12,13,14,15}},{{24,25,26,27},{28,29,30,31}},{{32,33,34,35},{36,37,38,39}}}),'advanced get 118 values')
end
do
  local a=np.reshape(np.arange(40),{5,4,2})
  local ix1=np.array({-1,5,-3},np.int64)
  local got=a:get(np.newaxis,ix1,np.slice(nil,nil,1),np.ellipsis)
  assert(eq(got.shape,{1,3,4,2}),'advanced get 119 shape')
  assert(eq(got.strides,{8,64,16,8}),'advanced get 119 strides')
  assert(eq(got:tolist(),{{{{32,33},{34,35},{36,37},{38,39}},{{32,33},{34,35},{36,37},{38,39}},{{16,17},{18,19},{20,21},{22,23}}}}),'advanced get 119 values')
end
do
  local a=np.reshape(np.arange(20),{2,5,2})
  local ix1=np.array({1},np.int64)
  local got=a:get(1,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{1,5}),'advanced get 120 shape')
  assert(eq(got.strides,{40,8}),'advanced get 120 strides')
  assert(eq(got:tolist(),{{0,2,4,6,8}}),'advanced get 120 values')
end
do
  local a=np.reshape(np.arange(24),{2,4,3})
  local ix1=np.array({2,2},np.int64)
  local ix2=np.array({3,1},np.int64)
  local got=a:get(ix1,np.slice(nil,nil,1),ix2)
  assert(eq(got.shape,{2,4}),'advanced get 121 shape')
  assert(eq(got.strides,{32,8}),'advanced get 121 strides')
  assert(eq(got:tolist(),{{14,17,20,23},{12,15,18,21}}),'advanced get 121 values')
end
do
  local a=np.reshape(np.arange(100),{5,4,5})
  local ix1=np.array({{3},{-4}},np.int64)
  local ix2=np.array({{-2,1}},np.int64)
  local got=a:get(ix1,ix2,np.slice(nil,nil,1))
  assert(eq(got.shape,{2,2,5}),'advanced get 122 shape')
  assert(eq(got.strides,{80,40,8}),'advanced get 122 strides')
  assert(eq(got:tolist(),{{{50,51,52,53,54},{40,41,42,43,44}},{{30,31,32,33,34},{20,21,22,23,24}}}),'advanced get 122 values')
end
do
  local a=np.reshape(np.arange(100),{5,4,5})
  local ix1=np.array({-4},np.int64)
  local got=a:get(np.newaxis,ix1,np.slice(nil,nil,1),np.ellipsis)
  assert(eq(got.shape,{1,1,4,5}),'advanced get 123 shape')
  assert(eq(got.strides,{8,160,40,8}),'advanced get 123 strides')
  assert(eq(got:tolist(),{{{{20,21,22,23,24},{25,26,27,28,29},{30,31,32,33,34},{35,36,37,38,39}}}}),'advanced get 123 values')
end
do
  local a=np.reshape(np.arange(40),{4,5,2})
  local ix1=np.array({1,1},np.int64)
  local ix2=np.array({1,1},np.int64)
  local got=a:get(ix1,np.slice(nil,nil,1),ix2)
  assert(eq(got.shape,{2,5}),'advanced get 124 shape')
  assert(eq(got.strides,{40,8}),'advanced get 124 strides')
  assert(eq(got:tolist(),{{0,2,4,6,8},{0,2,4,6,8}}),'advanced get 124 values')
end
do
  local a=np.reshape(np.arange(60),{5,4,3})
  local ix1=np.array({1},np.int64)
  local ix2=np.array({2},np.int64)
  local got=a:get(ix1,np.slice(nil,nil,1),ix2)
  assert(eq(got.shape,{1,4}),'advanced get 125 shape')
  assert(eq(got.strides,{32,8}),'advanced get 125 strides')
  assert(eq(got:tolist(),{{1,4,7,10}}),'advanced get 125 values')
end
do
  local a=np.reshape(np.arange(36),{3,4,3})
  local ix1=np.array({4,2},np.int64)
  local got=a:get(np.slice(nil,nil,1),ix1,np.ellipsis)
  assert(eq(got.shape,{3,2,3}),'advanced get 126 shape')
  assert(eq(got.strides,{24,72,8}),'advanced get 126 strides')
  assert(eq(got:tolist(),{{{9,10,11},{3,4,5}},{{21,22,23},{15,16,17}},{{33,34,35},{27,28,29}}}),'advanced get 126 values')
end
do
  local a=np.reshape(np.arange(32),{4,4,2})
  local ix1=np.array({{4}},np.int64)
  local ix2=np.array({{3,1}},np.int64)
  local got=a:get(ix1,ix2,np.slice(nil,nil,1))
  assert(eq(got.shape,{1,2,2}),'advanced get 127 shape')
  assert(eq(got.strides,{32,16,8}),'advanced get 127 strides')
  assert(eq(got:tolist(),{{{28,29},{24,25}}}),'advanced get 127 values')
end
do
  local a=np.reshape(np.arange(75),{5,3,5})
  local ix1=np.array({3},np.int64)
  local got=a:get(np.slice(nil,nil,1),ix1,np.ellipsis)
  assert(eq(got.shape,{5,1,5}),'advanced get 128 shape')
  assert(eq(got.strides,{40,200,8}),'advanced get 128 strides')
  assert(eq(got:tolist(),{{{10,11,12,13,14}},{{25,26,27,28,29}},{{40,41,42,43,44}},{{55,56,57,58,59}},{{70,71,72,73,74}}}),'advanced get 128 values')
end
do
  local a=np.reshape(np.arange(60),{4,5,3})
  local ix1=np.array({{false,false,true,false,false},{false,false,true,true,false},{false,false,true,false,false},{false,true,true,false,false}},np.bool)
  local got=a:get(ix1,np.slice(nil,nil,1))
  assert(eq(got.shape,{6,3}),'advanced get 129 shape')
  assert(eq(got.strides,{24,8}),'advanced get 129 strides')
  assert(eq(got:tolist(),{{6,7,8},{21,22,23},{24,25,26},{36,37,38},{48,49,50},{51,52,53}}),'advanced get 129 values')
end
do
  local a=np.reshape(np.arange(125),{5,5,5})
  local ix1=np.array({{5},{2},{4}},np.int64)
  local ix2=np.array({{4,2,-3}},np.int64)
  local got=a:get(ix1,ix2,np.slice(nil,nil,1))
  assert(eq(got.shape,{3,3,5}),'advanced get 130 shape')
  assert(eq(got.strides,{120,40,8}),'advanced get 130 strides')
  assert(eq(got:tolist(),{{{115,116,117,118,119},{105,106,107,108,109},{110,111,112,113,114}},{{40,41,42,43,44},{30,31,32,33,34},{35,36,37,38,39}},{{90,91,92,93,94},{80,81,82,83,84},{85,86,87,88,89}}}),'advanced get 130 values')
end
do
  local a=np.reshape(np.arange(80),{4,4,5})
  local ix1=np.array({{2},{3},{-3}},np.int64)
  local ix2=np.array({{4,3}},np.int64)
  local got=a:get(ix1,ix2,np.slice(nil,nil,1))
  assert(eq(got.shape,{3,2,5}),'advanced get 131 shape')
  assert(eq(got.strides,{80,40,8}),'advanced get 131 strides')
  assert(eq(got:tolist(),{{{35,36,37,38,39},{30,31,32,33,34}},{{55,56,57,58,59},{50,51,52,53,54}},{{35,36,37,38,39},{30,31,32,33,34}}}),'advanced get 131 values')
end
do
  local a=np.reshape(np.arange(24),{4,2,3})
  local ix1=np.array({3,3},np.int64)
  local got=a:get(4,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{2,2}),'advanced get 132 shape')
  assert(eq(got.strides,{16,8}),'advanced get 132 strides')
  assert(eq(got:tolist(),{{20,23},{20,23}}),'advanced get 132 values')
end
do
  local a=np.reshape(np.arange(40),{2,5,4})
  local ix1=np.array({-1},np.int64)
  local got=a:get(ix1)
  assert(eq(got.shape,{1,5,4}),'advanced get 133 shape')
  assert(eq(got.strides,{160,32,8}),'advanced get 133 strides')
  assert(eq(got:tolist(),{{{20,21,22,23},{24,25,26,27},{28,29,30,31},{32,33,34,35},{36,37,38,39}}}),'advanced get 133 values')
end
do
  local a=np.reshape(np.arange(24),{3,4,2})
  local ix1=np.array({2},np.int64)
  local got=a:get(1,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{1,4}),'advanced get 134 shape')
  assert(eq(got.strides,{32,8}),'advanced get 134 strides')
  assert(eq(got:tolist(),{{1,3,5,7}}),'advanced get 134 values')
end
do
  local a=np.reshape(np.arange(27),{3,3,3})
  local ix1=np.array({false,true,false},np.bool)
  local got=a:get(ix1,np.ellipsis)
  assert(eq(got.shape,{1,3,3}),'advanced get 135 shape')
  assert(eq(got.strides,{72,24,8}),'advanced get 135 strides')
  assert(eq(got:tolist(),{{{9,10,11},{12,13,14},{15,16,17}}}),'advanced get 135 values')
end
do
  local a=np.reshape(np.arange(48),{3,4,4})
  local ix1=np.array({-2,4,-4},np.int64)
  local got=a:get(3,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{3,4}),'advanced get 136 shape')
  assert(eq(got.strides,{32,8}),'advanced get 136 strides')
  assert(eq(got:tolist(),{{34,38,42,46},{35,39,43,47},{32,36,40,44}}),'advanced get 136 values')
end
do
  local a=np.reshape(np.arange(24),{3,2,4})
  local ix1=np.array({1},np.int64)
  local got=a:get(np.slice(nil,nil,1),ix1,np.ellipsis)
  assert(eq(got.shape,{3,1,4}),'advanced get 137 shape')
  assert(eq(got.strides,{32,96,8}),'advanced get 137 strides')
  assert(eq(got:tolist(),{{{0,1,2,3}},{{8,9,10,11}},{{16,17,18,19}}}),'advanced get 137 values')
end
do
  local a=np.reshape(np.arange(100),{4,5,5})
  local ix1=np.array({-2,1},np.int64)
  local got=a:get(ix1)
  assert(eq(got.shape,{2,5,5}),'advanced get 138 shape')
  assert(eq(got.strides,{200,40,8}),'advanced get 138 strides')
  assert(eq(got:tolist(),{{{50,51,52,53,54},{55,56,57,58,59},{60,61,62,63,64},{65,66,67,68,69},{70,71,72,73,74}},{{0,1,2,3,4},{5,6,7,8,9},{10,11,12,13,14},{15,16,17,18,19},{20,21,22,23,24}}}),'advanced get 138 values')
end
do
  local a=np.reshape(np.arange(30),{3,5,2})
  local ix1=np.array({{-3},{2}},np.int64)
  local ix2=np.array({{4,3,-4}},np.int64)
  local got=a:get(ix1,ix2,np.slice(nil,nil,1))
  assert(eq(got.shape,{2,3,2}),'advanced get 139 shape')
  assert(eq(got.strides,{48,16,8}),'advanced get 139 strides')
  assert(eq(got:tolist(),{{{6,7},{4,5},{2,3}},{{16,17},{14,15},{12,13}}}),'advanced get 139 values')
end
do
  local a=np.reshape(np.arange(45),{3,3,5})
  local ix1=np.array({-1,2},np.int64)
  local got=a:get(1,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{2,3}),'advanced get 140 shape')
  assert(eq(got.strides,{24,8}),'advanced get 140 strides')
  assert(eq(got:tolist(),{{4,9,14},{1,6,11}}),'advanced get 140 values')
end
do
  local a=np.reshape(np.arange(45),{5,3,3})
  local ix1=np.array({-1,3},np.int64)
  local got=a:get(np.slice(nil,nil,1),ix1,np.ellipsis)
  assert(eq(got.shape,{5,2,3}),'advanced get 141 shape')
  assert(eq(got.strides,{24,120,8}),'advanced get 141 strides')
  assert(eq(got:tolist(),{{{6,7,8},{6,7,8}},{{15,16,17},{15,16,17}},{{24,25,26},{24,25,26}},{{33,34,35},{33,34,35}},{{42,43,44},{42,43,44}}}),'advanced get 141 values')
end
do
  local a=np.reshape(np.arange(24),{2,3,4})
  local ix1=np.array({2},np.int64)
  local ix2=np.array({2},np.int64)
  local got=a:get(ix1,np.slice(nil,nil,1),ix2)
  assert(eq(got.shape,{1,3}),'advanced get 142 shape')
  assert(eq(got.strides,{24,8}),'advanced get 142 strides')
  assert(eq(got:tolist(),{{13,17,21}}),'advanced get 142 values')
end
do
  local a=np.reshape(np.arange(32),{4,2,4})
  local ix1=np.array({1},np.int64)
  local ix2=np.array({1},np.int64)
  local got=a:get(ix1,np.slice(nil,nil,1),ix2)
  assert(eq(got.shape,{1,2}),'advanced get 143 shape')
  assert(eq(got.strides,{16,8}),'advanced get 143 strides')
  assert(eq(got:tolist(),{{0,4}}),'advanced get 143 values')
end
do
  local a=np.reshape(np.arange(45),{3,5,3})
  local ix1=np.array({{false,true,false,false,false},{true,false,true,false,false},{false,false,true,false,false}},np.bool)
  local got=a:get(ix1,np.slice(nil,nil,1))
  assert(eq(got.shape,{4,3}),'advanced get 144 shape')
  assert(eq(got.strides,{24,8}),'advanced get 144 strides')
  assert(eq(got:tolist(),{{3,4,5},{15,16,17},{21,22,23},{36,37,38}}),'advanced get 144 values')
end
do
  local a=np.reshape(np.arange(60),{3,5,4})
  local ix1=np.array({1},np.int64)
  local got=a:get(np.slice(nil,nil,1),ix1,np.ellipsis)
  assert(eq(got.shape,{3,1,4}),'advanced get 145 shape')
  assert(eq(got.strides,{32,96,8}),'advanced get 145 strides')
  assert(eq(got:tolist(),{{{0,1,2,3}},{{20,21,22,23}},{{40,41,42,43}}}),'advanced get 145 values')
end
do
  local a=np.reshape(np.arange(40),{5,2,4})
  local ix1=np.array({-5},np.int64)
  local got=a:get(ix1)
  assert(eq(got.shape,{1,2,4}),'advanced get 146 shape')
  assert(eq(got.strides,{64,32,8}),'advanced get 146 strides')
  assert(eq(got:tolist(),{{{0,1,2,3},{4,5,6,7}}}),'advanced get 146 values')
end
do
  local a=np.reshape(np.arange(30),{5,2,3})
  local ix1=np.array({-3,-1},np.int64)
  local got=a:get(np.newaxis,ix1,np.slice(nil,nil,1),np.ellipsis)
  assert(eq(got.shape,{1,2,2,3}),'advanced get 147 shape')
  assert(eq(got.strides,{8,48,24,8}),'advanced get 147 strides')
  assert(eq(got:tolist(),{{{{12,13,14},{15,16,17}},{{24,25,26},{27,28,29}}}}),'advanced get 147 values')
end
do
  local a=np.reshape(np.arange(20),{2,2,5})
  local ix1=np.array({{false,true},{false,true}},np.bool)
  local got=a:get(ix1,np.slice(nil,nil,1))
  assert(eq(got.shape,{2,5}),'advanced get 148 shape')
  assert(eq(got.strides,{40,8}),'advanced get 148 strides')
  assert(eq(got:tolist(),{{5,6,7,8,9},{15,16,17,18,19}}),'advanced get 148 values')
end
do
  local a=np.reshape(np.arange(16),{2,4,2})
  local ix1=np.array({1},np.int64)
  local got=a:get(2,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{1,4}),'advanced get 149 shape')
  assert(eq(got.strides,{32,8}),'advanced get 149 strides')
  assert(eq(got:tolist(),{{8,10,12,14}}),'advanced get 149 values')
end
do
  local a=np.reshape(np.arange(100),{5,4,5})
  local ix1=np.array({-3},np.int64)
  local got=a:get(ix1)
  assert(eq(got.shape,{1,4,5}),'advanced get 150 shape')
  assert(eq(got.strides,{160,40,8}),'advanced get 150 strides')
  assert(eq(got:tolist(),{{{40,41,42,43,44},{45,46,47,48,49},{50,51,52,53,54},{55,56,57,58,59}}}),'advanced get 150 values')
end
do
  local a=np.reshape(np.arange(32),{4,2,4})
  local ix1=np.array({1,2},np.int64)
  local got=a:get(np.slice(nil,nil,1),ix1,np.ellipsis)
  assert(eq(got.shape,{4,2,4}),'advanced get 151 shape')
  assert(eq(got.strides,{32,128,8}),'advanced get 151 strides')
  assert(eq(got:tolist(),{{{0,1,2,3},{4,5,6,7}},{{8,9,10,11},{12,13,14,15}},{{16,17,18,19},{20,21,22,23}},{{24,25,26,27},{28,29,30,31}}}),'advanced get 151 values')
end
do
  local a=np.reshape(np.arange(75),{5,3,5})
  local ix1=np.array({1},np.int64)
  local got=a:get(np.newaxis,ix1,np.slice(nil,nil,1),np.ellipsis)
  assert(eq(got.shape,{1,1,3,5}),'advanced get 152 shape')
  assert(eq(got.strides,{8,120,40,8}),'advanced get 152 strides')
  assert(eq(got:tolist(),{{{{0,1,2,3,4},{5,6,7,8,9},{10,11,12,13,14}}}}),'advanced get 152 values')
end
do
  local a=np.reshape(np.arange(32),{4,4,2})
  local ix1=np.array({true,true,false,false},np.bool)
  local got=a:get(ix1,np.ellipsis)
  assert(eq(got.shape,{2,4,2}),'advanced get 153 shape')
  assert(eq(got.strides,{64,16,8}),'advanced get 153 strides')
  assert(eq(got:tolist(),{{{0,1},{2,3},{4,5},{6,7}},{{8,9},{10,11},{12,13},{14,15}}}),'advanced get 153 values')
end
do
  local a=np.reshape(np.arange(75),{5,5,3})
  local ix1=np.array({{false,false,false,false,false},{false,false,false,false,false},{true,false,true,false,false},{true,false,false,false,false},{false,false,false,true,false}},np.bool)
  local got=a:get(ix1,np.slice(nil,nil,1))
  assert(eq(got.shape,{4,3}),'advanced get 154 shape')
  assert(eq(got.strides,{24,8}),'advanced get 154 strides')
  assert(eq(got:tolist(),{{30,31,32},{36,37,38},{45,46,47},{69,70,71}}),'advanced get 154 values')
end
do
  local a=np.reshape(np.arange(12),{2,3,2})
  local ix1=np.array({-1},np.int64)
  local got=a:get(np.newaxis,ix1,np.slice(nil,nil,1),np.ellipsis)
  assert(eq(got.shape,{1,1,3,2}),'advanced get 155 shape')
  assert(eq(got.strides,{8,48,16,8}),'advanced get 155 strides')
  assert(eq(got:tolist(),{{{{6,7},{8,9},{10,11}}}}),'advanced get 155 values')
end
do
  local a=np.reshape(np.arange(75),{5,5,3})
  local ix1=np.array({{1},{2},{-4}},np.int64)
  local ix2=np.array({{3}},np.int64)
  local got=a:get(ix1,ix2,np.slice(nil,nil,1))
  assert(eq(got.shape,{3,1,3}),'advanced get 156 shape')
  assert(eq(got.strides,{24,24,8}),'advanced get 156 strides')
  assert(eq(got:tolist(),{{{6,7,8}},{{21,22,23}},{{21,22,23}}}),'advanced get 156 values')
end
do
  local a=np.reshape(np.arange(40),{4,2,5})
  local ix1=np.array({-2},np.int64)
  local ix2=np.array({-5},np.int64)
  local got=a:get(ix1,np.slice(nil,nil,1),ix2)
  assert(eq(got.shape,{1,2}),'advanced get 157 shape')
  assert(eq(got.strides,{16,8}),'advanced get 157 strides')
  assert(eq(got:tolist(),{{20,25}}),'advanced get 157 values')
end
do
  local a=np.reshape(np.arange(27),{3,3,3})
  local ix1=np.array({{-3},{-2}},np.int64)
  local ix2=np.array({{-1,2,2}},np.int64)
  local got=a:get(ix1,ix2,np.slice(nil,nil,1))
  assert(eq(got.shape,{2,3,3}),'advanced get 158 shape')
  assert(eq(got.strides,{72,24,8}),'advanced get 158 strides')
  assert(eq(got:tolist(),{{{6,7,8},{3,4,5},{3,4,5}},{{15,16,17},{12,13,14},{12,13,14}}}),'advanced get 158 values')
end
do
  local a=np.reshape(np.arange(20),{2,2,5})
  local ix1=np.array({-2},np.int64)
  local got=a:get(np.newaxis,ix1,np.slice(nil,nil,1),np.ellipsis)
  assert(eq(got.shape,{1,1,2,5}),'advanced get 159 shape')
  assert(eq(got.strides,{8,80,40,8}),'advanced get 159 strides')
  assert(eq(got:tolist(),{{{{0,1,2,3,4},{5,6,7,8,9}}}}),'advanced get 159 values')
end
do
  local a=np.reshape(np.arange(18),{2,3,3})
  local ix1=np.array({2,2,2},np.int64)
  local ix2=np.array({2,3,2},np.int64)
  local got=a:get(ix1,np.slice(nil,nil,1),ix2)
  assert(eq(got.shape,{3,3}),'advanced get 160 shape')
  assert(eq(got.strides,{24,8}),'advanced get 160 strides')
  assert(eq(got:tolist(),{{10,13,16},{11,14,17},{10,13,16}}),'advanced get 160 values')
end
do
  local a=np.reshape(np.arange(100),{5,5,4})
  local ix1=np.array({-2},np.int64)
  local got=a:get(2,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{1,5}),'advanced get 161 shape')
  assert(eq(got.strides,{40,8}),'advanced get 161 strides')
  assert(eq(got:tolist(),{{22,26,30,34,38}}),'advanced get 161 values')
end
do
  local a=np.reshape(np.arange(24),{4,2,3})
  local ix1=np.array({1,3},np.int64)
  local got=a:get(ix1)
  assert(eq(got.shape,{2,2,3}),'advanced get 162 shape')
  assert(eq(got.strides,{48,24,8}),'advanced get 162 strides')
  assert(eq(got:tolist(),{{{0,1,2},{3,4,5}},{{12,13,14},{15,16,17}}}),'advanced get 162 values')
end
do
  local a=np.reshape(np.arange(24),{3,4,2})
  local ix1=np.array({2,2,3},np.int64)
  local got=a:get(np.slice(nil,nil,1),ix1,np.ellipsis)
  assert(eq(got.shape,{3,3,2}),'advanced get 163 shape')
  assert(eq(got.strides,{16,48,8}),'advanced get 163 strides')
  assert(eq(got:tolist(),{{{2,3},{2,3},{4,5}},{{10,11},{10,11},{12,13}},{{18,19},{18,19},{20,21}}}),'advanced get 163 values')
end
do
  local a=np.reshape(np.arange(20),{2,5,2})
  local ix1=np.array({1,-4},np.int64)
  local got=a:get(np.slice(nil,nil,1),ix1,np.ellipsis)
  assert(eq(got.shape,{2,2,2}),'advanced get 164 shape')
  assert(eq(got.strides,{16,32,8}),'advanced get 164 strides')
  assert(eq(got:tolist(),{{{0,1},{2,3}},{{10,11},{12,13}}}),'advanced get 164 values')
end
do
  local a=np.reshape(np.arange(24),{4,2,3})
  local ix1=np.array({{true,false},{true,false},{true,true},{true,false}},np.bool)
  local got=a:get(ix1,np.slice(nil,nil,1))
  assert(eq(got.shape,{5,3}),'advanced get 165 shape')
  assert(eq(got.strides,{24,8}),'advanced get 165 strides')
  assert(eq(got:tolist(),{{0,1,2},{6,7,8},{12,13,14},{15,16,17},{18,19,20}}),'advanced get 165 values')
end
do
  local a=np.reshape(np.arange(45),{3,5,3})
  local ix1=np.array({2,2,3},np.int64)
  local got=a:get(1,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{3,5}),'advanced get 166 shape')
  assert(eq(got.strides,{40,8}),'advanced get 166 strides')
  assert(eq(got:tolist(),{{1,4,7,10,13},{1,4,7,10,13},{2,5,8,11,14}}),'advanced get 166 values')
end
do
  local a=np.reshape(np.arange(60),{3,4,5})
  local ix1=np.array({3},np.int64)
  local got=a:get(3,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{1,4}),'advanced get 167 shape')
  assert(eq(got.strides,{32,8}),'advanced get 167 strides')
  assert(eq(got:tolist(),{{42,47,52,57}}),'advanced get 167 values')
end
do
  local a=np.reshape(np.arange(40),{4,5,2})
  local ix1=np.array({4,-3,1},np.int64)
  local got=a:get(np.newaxis,ix1,np.slice(nil,nil,1),np.ellipsis)
  assert(eq(got.shape,{1,3,5,2}),'advanced get 168 shape')
  assert(eq(got.strides,{8,80,16,8}),'advanced get 168 strides')
  assert(eq(got:tolist(),{{{{30,31},{32,33},{34,35},{36,37},{38,39}},{{10,11},{12,13},{14,15},{16,17},{18,19}},{{0,1},{2,3},{4,5},{6,7},{8,9}}}}),'advanced get 168 values')
end
do
  local a=np.reshape(np.arange(20),{5,2,2})
  local ix1=np.array({false,true,true,false,true},np.bool)
  local got=a:get(ix1,np.ellipsis)
  assert(eq(got.shape,{3,2,2}),'advanced get 169 shape')
  assert(eq(got.strides,{32,16,8}),'advanced get 169 strides')
  assert(eq(got:tolist(),{{{4,5},{6,7}},{{8,9},{10,11}},{{16,17},{18,19}}}),'advanced get 169 values')
end
do
  local a=np.reshape(np.arange(30),{5,2,3})
  local ix1=np.array({{true,true},{false,true},{true,false},{false,false},{false,false}},np.bool)
  local got=a:get(ix1,np.slice(nil,nil,1))
  assert(eq(got.shape,{4,3}),'advanced get 170 shape')
  assert(eq(got.strides,{24,8}),'advanced get 170 strides')
  assert(eq(got:tolist(),{{0,1,2},{3,4,5},{9,10,11},{12,13,14}}),'advanced get 170 values')
end
do
  local a=np.reshape(np.arange(20),{2,2,5})
  local ix1=np.array({2},np.int64)
  local got=a:get(np.newaxis,ix1,np.slice(nil,nil,1),np.ellipsis)
  assert(eq(got.shape,{1,1,2,5}),'advanced get 171 shape')
  assert(eq(got.strides,{8,80,40,8}),'advanced get 171 strides')
  assert(eq(got:tolist(),{{{{10,11,12,13,14},{15,16,17,18,19}}}}),'advanced get 171 values')
end
do
  local a=np.reshape(np.arange(100),{5,5,4})
  local ix1=np.array({1,5},np.int64)
  local got=a:get(ix1)
  assert(eq(got.shape,{2,5,4}),'advanced get 172 shape')
  assert(eq(got.strides,{160,32,8}),'advanced get 172 strides')
  assert(eq(got:tolist(),{{{0,1,2,3},{4,5,6,7},{8,9,10,11},{12,13,14,15},{16,17,18,19}},{{80,81,82,83},{84,85,86,87},{88,89,90,91},{92,93,94,95},{96,97,98,99}}}),'advanced get 172 values')
end
do
  local a=np.reshape(np.arange(27),{3,3,3})
  local ix1=np.array({3},np.int64)
  local got=a:get(ix1)
  assert(eq(got.shape,{1,3,3}),'advanced get 173 shape')
  assert(eq(got.strides,{72,24,8}),'advanced get 173 strides')
  assert(eq(got:tolist(),{{{18,19,20},{21,22,23},{24,25,26}}}),'advanced get 173 values')
end
do
  local a=np.reshape(np.arange(40),{2,4,5})
  local ix1=np.array({1},np.int64)
  local got=a:get(np.slice(nil,nil,1),ix1,np.ellipsis)
  assert(eq(got.shape,{2,1,5}),'advanced get 174 shape')
  assert(eq(got.strides,{40,80,8}),'advanced get 174 strides')
  assert(eq(got:tolist(),{{{0,1,2,3,4}},{{20,21,22,23,24}}}),'advanced get 174 values')
end
do
  local a=np.reshape(np.arange(24),{2,4,3})
  local ix1=np.array({2,2},np.int64)
  local got=a:get(ix1)
  assert(eq(got.shape,{2,4,3}),'advanced get 175 shape')
  assert(eq(got.strides,{96,24,8}),'advanced get 175 strides')
  assert(eq(got:tolist(),{{{12,13,14},{15,16,17},{18,19,20},{21,22,23}},{{12,13,14},{15,16,17},{18,19,20},{21,22,23}}}),'advanced get 175 values')
end
do
  local a=np.reshape(np.arange(45),{3,3,5})
  local ix1=np.array({{false,true,false},{false,false,false},{false,true,false}},np.bool)
  local got=a:get(ix1,np.slice(nil,nil,1))
  assert(eq(got.shape,{2,5}),'advanced get 176 shape')
  assert(eq(got.strides,{40,8}),'advanced get 176 strides')
  assert(eq(got:tolist(),{{5,6,7,8,9},{35,36,37,38,39}}),'advanced get 176 values')
end
do
  local a=np.reshape(np.arange(75),{5,5,3})
  local ix1=np.array({true,true,false,true,true},np.bool)
  local got=a:get(ix1,np.ellipsis)
  assert(eq(got.shape,{4,5,3}),'advanced get 177 shape')
  assert(eq(got.strides,{120,24,8}),'advanced get 177 strides')
  assert(eq(got:tolist(),{{{0,1,2},{3,4,5},{6,7,8},{9,10,11},{12,13,14}},{{15,16,17},{18,19,20},{21,22,23},{24,25,26},{27,28,29}},{{45,46,47},{48,49,50},{51,52,53},{54,55,56},{57,58,59}},{{60,61,62},{63,64,65},{66,67,68},{69,70,71},{72,73,74}}}),'advanced get 177 values')
end
do
  local a=np.reshape(np.arange(40),{4,5,2})
  local ix1=np.array({1,2},np.int64)
  local ix2=np.array({1,1},np.int64)
  local got=a:get(ix1,np.slice(nil,nil,1),ix2)
  assert(eq(got.shape,{2,5}),'advanced get 178 shape')
  assert(eq(got.strides,{40,8}),'advanced get 178 strides')
  assert(eq(got:tolist(),{{0,2,4,6,8},{10,12,14,16,18}}),'advanced get 178 values')
end
do
  local a=np.reshape(np.arange(40),{4,5,2})
  local ix1=np.array({false,true,false,true},np.bool)
  local got=a:get(ix1,np.ellipsis)
  assert(eq(got.shape,{2,5,2}),'advanced get 179 shape')
  assert(eq(got.strides,{80,16,8}),'advanced get 179 strides')
  assert(eq(got:tolist(),{{{10,11},{12,13},{14,15},{16,17},{18,19}},{{30,31},{32,33},{34,35},{36,37},{38,39}}}),'advanced get 179 values')
end
do
  local a=np.reshape(np.arange(100),{5,5,4})
  local ix1=np.array({-5},np.int64)
  local got=a:get(ix1)
  assert(eq(got.shape,{1,5,4}),'advanced get 180 shape')
  assert(eq(got.strides,{160,32,8}),'advanced get 180 strides')
  assert(eq(got:tolist(),{{{0,1,2,3},{4,5,6,7},{8,9,10,11},{12,13,14,15},{16,17,18,19}}}),'advanced get 180 values')
end
do
  local a=np.reshape(np.arange(8),{2,2,2})
  local ix1=np.array({true,false},np.bool)
  local got=a:get(ix1,np.ellipsis)
  assert(eq(got.shape,{1,2,2}),'advanced get 181 shape')
  assert(eq(got.strides,{32,16,8}),'advanced get 181 strides')
  assert(eq(got:tolist(),{{{0,1},{2,3}}}),'advanced get 181 values')
end
do
  local a=np.reshape(np.arange(30),{3,2,5})
  local ix1=np.array({true,true,false},np.bool)
  local got=a:get(ix1,np.ellipsis)
  assert(eq(got.shape,{2,2,5}),'advanced get 182 shape')
  assert(eq(got.strides,{80,40,8}),'advanced get 182 strides')
  assert(eq(got:tolist(),{{{0,1,2,3,4},{5,6,7,8,9}},{{10,11,12,13,14},{15,16,17,18,19}}}),'advanced get 182 values')
end
do
  local a=np.reshape(np.arange(45),{3,3,5})
  local ix1=np.array({1,1,3},np.int64)
  local got=a:get(ix1)
  assert(eq(got.shape,{3,3,5}),'advanced get 183 shape')
  assert(eq(got.strides,{120,40,8}),'advanced get 183 strides')
  assert(eq(got:tolist(),{{{0,1,2,3,4},{5,6,7,8,9},{10,11,12,13,14}},{{0,1,2,3,4},{5,6,7,8,9},{10,11,12,13,14}},{{30,31,32,33,34},{35,36,37,38,39},{40,41,42,43,44}}}),'advanced get 183 values')
end
do
  local a=np.reshape(np.arange(45),{3,5,3})
  local ix1=np.array({{false,false,false,false,true},{false,false,false,false,true},{false,false,true,false,true}},np.bool)
  local got=a:get(ix1,np.slice(nil,nil,1))
  assert(eq(got.shape,{4,3}),'advanced get 184 shape')
  assert(eq(got.strides,{24,8}),'advanced get 184 strides')
  assert(eq(got:tolist(),{{12,13,14},{27,28,29},{36,37,38},{42,43,44}}),'advanced get 184 values')
end
do
  local a=np.reshape(np.arange(36),{3,3,4})
  local ix1=np.array({{false,true,false},{false,false,true},{false,false,false}},np.bool)
  local got=a:get(ix1,np.slice(nil,nil,1))
  assert(eq(got.shape,{2,4}),'advanced get 185 shape')
  assert(eq(got.strides,{32,8}),'advanced get 185 strides')
  assert(eq(got:tolist(),{{4,5,6,7},{20,21,22,23}}),'advanced get 185 values')
end
do
  local a=np.reshape(np.arange(16),{2,2,4})
  local ix1=np.array({true,false},np.bool)
  local got=a:get(ix1,np.ellipsis)
  assert(eq(got.shape,{1,2,4}),'advanced get 186 shape')
  assert(eq(got.strides,{64,32,8}),'advanced get 186 strides')
  assert(eq(got:tolist(),{{{0,1,2,3},{4,5,6,7}}}),'advanced get 186 values')
end
do
  local a=np.reshape(np.arange(40),{4,2,5})
  local ix1=np.array({1,3,5},np.int64)
  local got=a:get(4,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{3,2}),'advanced get 187 shape')
  assert(eq(got.strides,{16,8}),'advanced get 187 strides')
  assert(eq(got:tolist(),{{30,35},{32,37},{34,39}}),'advanced get 187 values')
end
do
  local a=np.reshape(np.arange(12),{2,3,2})
  local ix1=np.array({{2},{-2},{2}},np.int64)
  local ix2=np.array({{-3}},np.int64)
  local got=a:get(ix1,ix2,np.slice(nil,nil,1))
  assert(eq(got.shape,{3,1,2}),'advanced get 188 shape')
  assert(eq(got.strides,{16,16,8}),'advanced get 188 strides')
  assert(eq(got:tolist(),{{{6,7}},{{0,1}},{{6,7}}}),'advanced get 188 values')
end
do
  local a=np.reshape(np.arange(16),{2,4,2})
  local ix1=np.array({1,2},np.int64)
  local got=a:get(np.slice(nil,nil,1),ix1,np.ellipsis)
  assert(eq(got.shape,{2,2,2}),'advanced get 189 shape')
  assert(eq(got.strides,{16,32,8}),'advanced get 189 strides')
  assert(eq(got:tolist(),{{{0,1},{2,3}},{{8,9},{10,11}}}),'advanced get 189 values')
end
do
  local a=np.reshape(np.arange(24),{2,3,4})
  local ix1=np.array({2,-1},np.int64)
  local got=a:get(np.slice(nil,nil,1),ix1,np.ellipsis)
  assert(eq(got.shape,{2,2,4}),'advanced get 190 shape')
  assert(eq(got.strides,{32,64,8}),'advanced get 190 strides')
  assert(eq(got:tolist(),{{{4,5,6,7},{8,9,10,11}},{{16,17,18,19},{20,21,22,23}}}),'advanced get 190 values')
end
do
  local a=np.reshape(np.arange(24),{4,3,2})
  local ix1=np.array({-2,-2},np.int64)
  local got=a:get(1,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{2,3}),'advanced get 191 shape')
  assert(eq(got.strides,{24,8}),'advanced get 191 strides')
  assert(eq(got:tolist(),{{0,2,4},{0,2,4}}),'advanced get 191 values')
end
do
  local a=np.reshape(np.arange(80),{5,4,4})
  local ix1=np.array({{1},{-4},{-2}},np.int64)
  local ix2=np.array({{-3}},np.int64)
  local got=a:get(ix1,ix2,np.slice(nil,nil,1))
  assert(eq(got.shape,{3,1,4}),'advanced get 192 shape')
  assert(eq(got.strides,{32,32,8}),'advanced get 192 strides')
  assert(eq(got:tolist(),{{{4,5,6,7}},{{20,21,22,23}},{{52,53,54,55}}}),'advanced get 192 values')
end
do
  local a=np.reshape(np.arange(100),{4,5,5})
  local ix1=np.array({2,-3,2},np.int64)
  local got=a:get(np.newaxis,ix1,np.slice(nil,nil,1),np.ellipsis)
  assert(eq(got.shape,{1,3,5,5}),'advanced get 193 shape')
  assert(eq(got.strides,{8,200,40,8}),'advanced get 193 strides')
  assert(eq(got:tolist(),{{{{25,26,27,28,29},{30,31,32,33,34},{35,36,37,38,39},{40,41,42,43,44},{45,46,47,48,49}},{{25,26,27,28,29},{30,31,32,33,34},{35,36,37,38,39},{40,41,42,43,44},{45,46,47,48,49}},{{25,26,27,28,29},{30,31,32,33,34},{35,36,37,38,39},{40,41,42,43,44},{45,46,47,48,49}}}}),'advanced get 193 values')
end
do
  local a=np.reshape(np.arange(20),{5,2,2})
  local ix1=np.array({true,false,true,true,true},np.bool)
  local got=a:get(ix1,np.ellipsis)
  assert(eq(got.shape,{4,2,2}),'advanced get 194 shape')
  assert(eq(got.strides,{32,16,8}),'advanced get 194 strides')
  assert(eq(got:tolist(),{{{0,1},{2,3}},{{8,9},{10,11}},{{12,13},{14,15}},{{16,17},{18,19}}}),'advanced get 194 values')
end
do
  local a=np.reshape(np.arange(24),{4,2,3})
  local ix1=np.array({{-2},{2},{-1}},np.int64)
  local ix2=np.array({{1,2,-1}},np.int64)
  local got=a:get(ix1,ix2,np.slice(nil,nil,1))
  assert(eq(got.shape,{3,3,3}),'advanced get 195 shape')
  assert(eq(got.strides,{72,24,8}),'advanced get 195 strides')
  assert(eq(got:tolist(),{{{12,13,14},{15,16,17},{15,16,17}},{{6,7,8},{9,10,11},{9,10,11}},{{18,19,20},{21,22,23},{21,22,23}}}),'advanced get 195 values')
end
do
  local a=np.reshape(np.arange(80),{4,5,4})
  local ix1=np.array({{2},{3}},np.int64)
  local ix2=np.array({{4,-4}},np.int64)
  local got=a:get(ix1,ix2,np.slice(nil,nil,1))
  assert(eq(got.shape,{2,2,4}),'advanced get 196 shape')
  assert(eq(got.strides,{64,32,8}),'advanced get 196 strides')
  assert(eq(got:tolist(),{{{32,33,34,35},{24,25,26,27}},{{52,53,54,55},{44,45,46,47}}}),'advanced get 196 values')
end
do
  local a=np.reshape(np.arange(80),{5,4,4})
  local ix1=np.array({2},np.int64)
  local got=a:get(np.slice(nil,nil,1),ix1,np.ellipsis)
  assert(eq(got.shape,{5,1,4}),'advanced get 197 shape')
  assert(eq(got.strides,{32,160,8}),'advanced get 197 strides')
  assert(eq(got:tolist(),{{{4,5,6,7}},{{20,21,22,23}},{{36,37,38,39}},{{52,53,54,55}},{{68,69,70,71}}}),'advanced get 197 values')
end
do
  local a=np.reshape(np.arange(36),{3,3,4})
  local ix1=np.array({-1,2,3},np.int64)
  local got=a:get(ix1)
  assert(eq(got.shape,{3,3,4}),'advanced get 198 shape')
  assert(eq(got.strides,{96,32,8}),'advanced get 198 strides')
  assert(eq(got:tolist(),{{{24,25,26,27},{28,29,30,31},{32,33,34,35}},{{12,13,14,15},{16,17,18,19},{20,21,22,23}},{{24,25,26,27},{28,29,30,31},{32,33,34,35}}}),'advanced get 198 values')
end
do
  local a=np.reshape(np.arange(45),{5,3,3})
  local ix1=np.array({{2}},np.int64)
  local ix2=np.array({{2,2}},np.int64)
  local got=a:get(ix1,ix2,np.slice(nil,nil,1))
  assert(eq(got.shape,{1,2,3}),'advanced get 199 shape')
  assert(eq(got.strides,{48,24,8}),'advanced get 199 strides')
  assert(eq(got:tolist(),{{{12,13,14},{12,13,14}}}),'advanced get 199 values')
end
do
  local a=np.reshape(np.arange(40),{4,5,2})
  local ix1=np.array({-2,3},np.int64)
  local ix2=np.array({-1,-1},np.int64)
  local got=a:get(ix1,np.slice(nil,nil,1),ix2)
  assert(eq(got.shape,{2,5}),'advanced get 200 shape')
  assert(eq(got.strides,{40,8}),'advanced get 200 strides')
  assert(eq(got:tolist(),{{21,23,25,27,29},{21,23,25,27,29}}),'advanced get 200 values')
end
do
  local a=np.reshape(np.arange(32),{4,4,2})
  local ix1=np.array({4,2,3},np.int64)
  local got=a:get(np.newaxis,ix1,np.slice(nil,nil,1),np.ellipsis)
  assert(eq(got.shape,{1,3,4,2}),'advanced get 201 shape')
  assert(eq(got.strides,{8,64,16,8}),'advanced get 201 strides')
  assert(eq(got:tolist(),{{{{24,25},{26,27},{28,29},{30,31}},{{8,9},{10,11},{12,13},{14,15}},{{16,17},{18,19},{20,21},{22,23}}}}),'advanced get 201 values')
end
do
  local a=np.reshape(np.arange(30),{3,2,5})
  local ix1=np.array({{1}},np.int64)
  local ix2=np.array({{1,1}},np.int64)
  local got=a:get(ix1,ix2,np.slice(nil,nil,1))
  assert(eq(got.shape,{1,2,5}),'advanced get 202 shape')
  assert(eq(got.strides,{80,40,8}),'advanced get 202 strides')
  assert(eq(got:tolist(),{{{0,1,2,3,4},{0,1,2,3,4}}}),'advanced get 202 values')
end
do
  local a=np.reshape(np.arange(12),{3,2,2})
  local ix1=np.array({{false,true},{false,false},{true,false}},np.bool)
  local got=a:get(ix1,np.slice(nil,nil,1))
  assert(eq(got.shape,{2,2}),'advanced get 203 shape')
  assert(eq(got.strides,{16,8}),'advanced get 203 strides')
  assert(eq(got:tolist(),{{2,3},{8,9}}),'advanced get 203 values')
end
do
  local a=np.reshape(np.arange(12),{2,2,3})
  local ix1=np.array({-1,2,2},np.int64)
  local ix2=np.array({3,1,1},np.int64)
  local got=a:get(ix1,np.slice(nil,nil,1),ix2)
  assert(eq(got.shape,{3,2}),'advanced get 204 shape')
  assert(eq(got.strides,{16,8}),'advanced get 204 strides')
  assert(eq(got:tolist(),{{8,11},{6,9},{6,9}}),'advanced get 204 values')
end
do
  local a=np.reshape(np.arange(16),{2,4,2})
  local ix1=np.array({{true,true,false,false},{false,false,false,false}},np.bool)
  local got=a:get(ix1,np.slice(nil,nil,1))
  assert(eq(got.shape,{2,2}),'advanced get 205 shape')
  assert(eq(got.strides,{16,8}),'advanced get 205 strides')
  assert(eq(got:tolist(),{{0,1},{2,3}}),'advanced get 205 values')
end
do
  local a=np.reshape(np.arange(24),{3,4,2})
  local ix1=np.array({-1,3},np.int64)
  local got=a:get(np.newaxis,ix1,np.slice(nil,nil,1),np.ellipsis)
  assert(eq(got.shape,{1,2,4,2}),'advanced get 206 shape')
  assert(eq(got.strides,{8,64,16,8}),'advanced get 206 strides')
  assert(eq(got:tolist(),{{{{16,17},{18,19},{20,21},{22,23}},{{16,17},{18,19},{20,21},{22,23}}}}),'advanced get 206 values')
end
do
  local a=np.reshape(np.arange(24),{3,2,4})
  local ix1=np.array({2},np.int64)
  local ix2=np.array({1},np.int64)
  local got=a:get(ix1,np.slice(nil,nil,1),ix2)
  assert(eq(got.shape,{1,2}),'advanced get 207 shape')
  assert(eq(got.strides,{16,8}),'advanced get 207 strides')
  assert(eq(got:tolist(),{{8,12}}),'advanced get 207 values')
end
do
  local a=np.reshape(np.arange(75),{5,5,3})
  local ix1=np.array({-4,-2},np.int64)
  local got=a:get(np.slice(nil,nil,1),ix1,np.ellipsis)
  assert(eq(got.shape,{5,2,3}),'advanced get 208 shape')
  assert(eq(got.strides,{24,120,8}),'advanced get 208 strides')
  assert(eq(got:tolist(),{{{3,4,5},{9,10,11}},{{18,19,20},{24,25,26}},{{33,34,35},{39,40,41}},{{48,49,50},{54,55,56}},{{63,64,65},{69,70,71}}}),'advanced get 208 values')
end
do
  local a=np.reshape(np.arange(30),{3,2,5})
  local ix1=np.array({false,false,false},np.bool)
  local got=a:get(ix1,np.ellipsis)
  assert(eq(got.shape,{0,2,5}),'advanced get 209 shape')
  assert(eq(got.strides,{0,0,0}),'advanced get 209 strides')
  assert(eq(got:tolist(),{}),'advanced get 209 values')
end
do
  local a=np.reshape(np.arange(12),{3,2,2})
  local ix1=np.array({2,1,2},np.int64)
  local got=a:get(np.slice(nil,nil,1),ix1,np.ellipsis)
  assert(eq(got.shape,{3,3,2}),'advanced get 210 shape')
  assert(eq(got.strides,{16,48,8}),'advanced get 210 strides')
  assert(eq(got:tolist(),{{{2,3},{0,1},{2,3}},{{6,7},{4,5},{6,7}},{{10,11},{8,9},{10,11}}}),'advanced get 210 values')
end
do
  local a=np.reshape(np.arange(32),{2,4,4})
  local ix1=np.array({1,-2},np.int64)
  local ix2=np.array({1,4},np.int64)
  local got=a:get(ix1,np.slice(nil,nil,1),ix2)
  assert(eq(got.shape,{2,4}),'advanced get 211 shape')
  assert(eq(got.strides,{32,8}),'advanced get 211 strides')
  assert(eq(got:tolist(),{{0,4,8,12},{3,7,11,15}}),'advanced get 211 values')
end
do
  local a=np.reshape(np.arange(12),{2,3,2})
  local ix1=np.array({true,true},np.bool)
  local got=a:get(ix1,np.ellipsis)
  assert(eq(got.shape,{2,3,2}),'advanced get 212 shape')
  assert(eq(got.strides,{48,16,8}),'advanced get 212 strides')
  assert(eq(got:tolist(),{{{0,1},{2,3},{4,5}},{{6,7},{8,9},{10,11}}}),'advanced get 212 values')
end
do
  local a=np.reshape(np.arange(75),{3,5,5})
  local ix1=np.array({{-2}},np.int64)
  local ix2=np.array({{-5,-5,4}},np.int64)
  local got=a:get(ix1,ix2,np.slice(nil,nil,1))
  assert(eq(got.shape,{1,3,5}),'advanced get 213 shape')
  assert(eq(got.strides,{120,40,8}),'advanced get 213 strides')
  assert(eq(got:tolist(),{{{25,26,27,28,29},{25,26,27,28,29},{40,41,42,43,44}}}),'advanced get 213 values')
end
do
  local a=np.reshape(np.arange(32),{4,4,2})
  local ix1=np.array({1},np.int64)
  local got=a:get(2,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{1,4}),'advanced get 214 shape')
  assert(eq(got.strides,{32,8}),'advanced get 214 strides')
  assert(eq(got:tolist(),{{8,10,12,14}}),'advanced get 214 values')
end
do
  local a=np.reshape(np.arange(30),{5,3,2})
  local ix1=np.array({3,2,2},np.int64)
  local got=a:get(np.slice(nil,nil,1),ix1,np.ellipsis)
  assert(eq(got.shape,{5,3,2}),'advanced get 215 shape')
  assert(eq(got.strides,{16,80,8}),'advanced get 215 strides')
  assert(eq(got:tolist(),{{{4,5},{2,3},{2,3}},{{10,11},{8,9},{8,9}},{{16,17},{14,15},{14,15}},{{22,23},{20,21},{20,21}},{{28,29},{26,27},{26,27}}}),'advanced get 215 values')
end
do
  local a=np.reshape(np.arange(30),{2,5,3})
  local ix1=np.array({-5,4,4},np.int64)
  local got=a:get(np.slice(nil,nil,1),ix1,np.ellipsis)
  assert(eq(got.shape,{2,3,3}),'advanced get 216 shape')
  assert(eq(got.strides,{24,48,8}),'advanced get 216 strides')
  assert(eq(got:tolist(),{{{0,1,2},{9,10,11},{9,10,11}},{{15,16,17},{24,25,26},{24,25,26}}}),'advanced get 216 values')
end
do
  local a=np.reshape(np.arange(45),{3,5,3})
  local ix1=np.array({-3,3},np.int64)
  local got=a:get(np.slice(nil,nil,1),ix1,np.ellipsis)
  assert(eq(got.shape,{3,2,3}),'advanced get 217 shape')
  assert(eq(got.strides,{24,72,8}),'advanced get 217 strides')
  assert(eq(got:tolist(),{{{6,7,8},{6,7,8}},{{21,22,23},{21,22,23}},{{36,37,38},{36,37,38}}}),'advanced get 217 values')
end
do
  local a=np.reshape(np.arange(40),{5,4,2})
  local ix1=np.array({5,2},np.int64)
  local got=a:get(ix1)
  assert(eq(got.shape,{2,4,2}),'advanced get 218 shape')
  assert(eq(got.strides,{64,16,8}),'advanced get 218 strides')
  assert(eq(got:tolist(),{{{32,33},{34,35},{36,37},{38,39}},{{8,9},{10,11},{12,13},{14,15}}}),'advanced get 218 values')
end
do
  local a=np.reshape(np.arange(40),{5,4,2})
  local ix1=np.array({{-4},{2},{-4}},np.int64)
  local ix2=np.array({{4,2,4}},np.int64)
  local got=a:get(ix1,ix2,np.slice(nil,nil,1))
  assert(eq(got.shape,{3,3,2}),'advanced get 219 shape')
  assert(eq(got.strides,{48,16,8}),'advanced get 219 strides')
  assert(eq(got:tolist(),{{{14,15},{10,11},{14,15}},{{14,15},{10,11},{14,15}},{{14,15},{10,11},{14,15}}}),'advanced get 219 values')
end
do
  local a=np.reshape(np.arange(20),{2,5,2})
  local ix1=np.array({false,true},np.bool)
  local got=a:get(ix1,np.ellipsis)
  assert(eq(got.shape,{1,5,2}),'advanced get 220 shape')
  assert(eq(got.strides,{80,16,8}),'advanced get 220 strides')
  assert(eq(got:tolist(),{{{10,11},{12,13},{14,15},{16,17},{18,19}}}),'advanced get 220 values')
end
do
  local a=np.reshape(np.arange(30),{2,3,5})
  local ix1=np.array({{false,false,true},{false,false,true}},np.bool)
  local got=a:get(ix1,np.slice(nil,nil,1))
  assert(eq(got.shape,{2,5}),'advanced get 221 shape')
  assert(eq(got.strides,{40,8}),'advanced get 221 strides')
  assert(eq(got:tolist(),{{10,11,12,13,14},{25,26,27,28,29}}),'advanced get 221 values')
end
do
  local a=np.reshape(np.arange(48),{3,4,4})
  local ix1=np.array({{3},{3},{3}},np.int64)
  local ix2=np.array({{4,1,4}},np.int64)
  local got=a:get(ix1,ix2,np.slice(nil,nil,1))
  assert(eq(got.shape,{3,3,4}),'advanced get 222 shape')
  assert(eq(got.strides,{96,32,8}),'advanced get 222 strides')
  assert(eq(got:tolist(),{{{44,45,46,47},{32,33,34,35},{44,45,46,47}},{{44,45,46,47},{32,33,34,35},{44,45,46,47}},{{44,45,46,47},{32,33,34,35},{44,45,46,47}}}),'advanced get 222 values')
end
do
  local a=np.reshape(np.arange(24),{4,3,2})
  local ix1=np.array({1},np.int64)
  local ix2=np.array({1},np.int64)
  local got=a:get(ix1,np.slice(nil,nil,1),ix2)
  assert(eq(got.shape,{1,3}),'advanced get 223 shape')
  assert(eq(got.strides,{24,8}),'advanced get 223 strides')
  assert(eq(got:tolist(),{{0,2,4}}),'advanced get 223 values')
end
do
  local a=np.reshape(np.arange(16),{2,2,4})
  local ix1=np.array({{false,false},{true,false}},np.bool)
  local got=a:get(ix1,np.slice(nil,nil,1))
  assert(eq(got.shape,{1,4}),'advanced get 224 shape')
  assert(eq(got.strides,{32,8}),'advanced get 224 strides')
  assert(eq(got:tolist(),{{8,9,10,11}}),'advanced get 224 values')
end
do
  local a=np.reshape(np.arange(30),{3,5,2})
  local ix1=np.array({2},np.int64)
  local got=a:get(np.newaxis,ix1,np.slice(nil,nil,1),np.ellipsis)
  assert(eq(got.shape,{1,1,5,2}),'advanced get 225 shape')
  assert(eq(got.strides,{8,80,16,8}),'advanced get 225 strides')
  assert(eq(got:tolist(),{{{{10,11},{12,13},{14,15},{16,17},{18,19}}}}),'advanced get 225 values')
end
do
  local a=np.reshape(np.arange(16),{2,2,4})
  local ix1=np.array({2,2,1},np.int64)
  local got=a:get(np.newaxis,ix1,np.slice(nil,nil,1),np.ellipsis)
  assert(eq(got.shape,{1,3,2,4}),'advanced get 226 shape')
  assert(eq(got.strides,{8,64,32,8}),'advanced get 226 strides')
  assert(eq(got:tolist(),{{{{8,9,10,11},{12,13,14,15}},{{8,9,10,11},{12,13,14,15}},{{0,1,2,3},{4,5,6,7}}}}),'advanced get 226 values')
end
do
  local a=np.reshape(np.arange(24),{3,4,2})
  local ix1=np.array({1,2},np.int64)
  local got=a:get(np.slice(nil,nil,1),ix1,np.ellipsis)
  assert(eq(got.shape,{3,2,2}),'advanced get 227 shape')
  assert(eq(got.strides,{16,48,8}),'advanced get 227 strides')
  assert(eq(got:tolist(),{{{0,1},{2,3}},{{8,9},{10,11}},{{16,17},{18,19}}}),'advanced get 227 values')
end
do
  local a=np.reshape(np.arange(60),{3,4,5})
  local ix1=np.array({3,-5},np.int64)
  local got=a:get(2,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{2,4}),'advanced get 228 shape')
  assert(eq(got.strides,{32,8}),'advanced get 228 strides')
  assert(eq(got:tolist(),{{22,27,32,37},{20,25,30,35}}),'advanced get 228 values')
end
do
  local a=np.reshape(np.arange(40),{5,2,4})
  local ix1=np.array({1},np.int64)
  local got=a:get(np.newaxis,ix1,np.slice(nil,nil,1),np.ellipsis)
  assert(eq(got.shape,{1,1,2,4}),'advanced get 229 shape')
  assert(eq(got.strides,{8,64,32,8}),'advanced get 229 strides')
  assert(eq(got:tolist(),{{{{0,1,2,3},{4,5,6,7}}}}),'advanced get 229 values')
end
do
  local a=np.reshape(np.arange(30),{5,2,3})
  local ix1=np.array({{4}},np.int64)
  local ix2=np.array({{2,2,-2}},np.int64)
  local got=a:get(ix1,ix2,np.slice(nil,nil,1))
  assert(eq(got.shape,{1,3,3}),'advanced get 230 shape')
  assert(eq(got.strides,{72,24,8}),'advanced get 230 strides')
  assert(eq(got:tolist(),{{{21,22,23},{21,22,23},{18,19,20}}}),'advanced get 230 values')
end
do
  local a=np.reshape(np.arange(24),{4,3,2})
  local ix1=np.array({{true,true,true},{false,false,false},{false,false,true},{true,true,false}},np.bool)
  local got=a:get(ix1,np.slice(nil,nil,1))
  assert(eq(got.shape,{6,2}),'advanced get 231 shape')
  assert(eq(got.strides,{16,8}),'advanced get 231 strides')
  assert(eq(got:tolist(),{{0,1},{2,3},{4,5},{16,17},{18,19},{20,21}}),'advanced get 231 values')
end
do
  local a=np.reshape(np.arange(64),{4,4,4})
  local ix1=np.array({{false,true,false,true},{false,true,false,false},{true,true,false,true},{true,false,false,false}},np.bool)
  local got=a:get(ix1,np.slice(nil,nil,1))
  assert(eq(got.shape,{7,4}),'advanced get 232 shape')
  assert(eq(got.strides,{32,8}),'advanced get 232 strides')
  assert(eq(got:tolist(),{{4,5,6,7},{12,13,14,15},{20,21,22,23},{32,33,34,35},{36,37,38,39},{44,45,46,47},{48,49,50,51}}),'advanced get 232 values')
end
do
  local a=np.reshape(np.arange(45),{3,5,3})
  local ix1=np.array({true,false,false},np.bool)
  local got=a:get(ix1,np.ellipsis)
  assert(eq(got.shape,{1,5,3}),'advanced get 233 shape')
  assert(eq(got.strides,{120,24,8}),'advanced get 233 strides')
  assert(eq(got:tolist(),{{{0,1,2},{3,4,5},{6,7,8},{9,10,11},{12,13,14}}}),'advanced get 233 values')
end
do
  local a=np.reshape(np.arange(45),{3,5,3})
  local ix1=np.array({{2},{3},{-2}},np.int64)
  local ix2=np.array({{3,-4}},np.int64)
  local got=a:get(ix1,ix2,np.slice(nil,nil,1))
  assert(eq(got.shape,{3,2,3}),'advanced get 234 shape')
  assert(eq(got.strides,{48,24,8}),'advanced get 234 strides')
  assert(eq(got:tolist(),{{{21,22,23},{18,19,20}},{{36,37,38},{33,34,35}},{{21,22,23},{18,19,20}}}),'advanced get 234 values')
end
do
  local a=np.reshape(np.arange(100),{5,4,5})
  local ix1=np.array({5},np.int64)
  local got=a:get(np.newaxis,ix1,np.slice(nil,nil,1),np.ellipsis)
  assert(eq(got.shape,{1,1,4,5}),'advanced get 235 shape')
  assert(eq(got.strides,{8,160,40,8}),'advanced get 235 strides')
  assert(eq(got:tolist(),{{{{80,81,82,83,84},{85,86,87,88,89},{90,91,92,93,94},{95,96,97,98,99}}}}),'advanced get 235 values')
end
do
  local a=np.reshape(np.arange(60),{3,5,4})
  local ix1=np.array({1,-1},np.int64)
  local got=a:get(2,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{2,5}),'advanced get 236 shape')
  assert(eq(got.strides,{40,8}),'advanced get 236 strides')
  assert(eq(got:tolist(),{{20,24,28,32,36},{23,27,31,35,39}}),'advanced get 236 values')
end
do
  local a=np.reshape(np.arange(40),{5,4,2})
  local ix1=np.array({2,2,4},np.int64)
  local got=a:get(np.newaxis,ix1,np.slice(nil,nil,1),np.ellipsis)
  assert(eq(got.shape,{1,3,4,2}),'advanced get 237 shape')
  assert(eq(got.strides,{8,64,16,8}),'advanced get 237 strides')
  assert(eq(got:tolist(),{{{{8,9},{10,11},{12,13},{14,15}},{{8,9},{10,11},{12,13},{14,15}},{{24,25},{26,27},{28,29},{30,31}}}}),'advanced get 237 values')
end
do
  local a=np.reshape(np.arange(18),{3,3,2})
  local ix1=np.array({1},np.int64)
  local ix2=np.array({2},np.int64)
  local got=a:get(ix1,np.slice(nil,nil,1),ix2)
  assert(eq(got.shape,{1,3}),'advanced get 238 shape')
  assert(eq(got.strides,{24,8}),'advanced get 238 strides')
  assert(eq(got:tolist(),{{1,3,5}}),'advanced get 238 values')
end
do
  local a=np.reshape(np.arange(30),{3,2,5})
  local ix1=np.array({true,false,false},np.bool)
  local got=a:get(ix1,np.ellipsis)
  assert(eq(got.shape,{1,2,5}),'advanced get 239 shape')
  assert(eq(got.strides,{80,40,8}),'advanced get 239 strides')
  assert(eq(got:tolist(),{{{0,1,2,3,4},{5,6,7,8,9}}}),'advanced get 239 values')
end
do
  local a=np.reshape(np.arange(12),{3,2,2})
  local ix1=np.array({1,3},np.int64)
  local got=a:get(ix1)
  assert(eq(got.shape,{2,2,2}),'advanced get 240 shape')
  assert(eq(got.strides,{32,16,8}),'advanced get 240 strides')
  assert(eq(got:tolist(),{{{0,1},{2,3}},{{8,9},{10,11}}}),'advanced get 240 values')
end
do
  local a=np.reshape(np.arange(32),{2,4,4})
  local ix1=np.array({1,1,1},np.int64)
  local got=a:get(ix1)
  assert(eq(got.shape,{3,4,4}),'advanced get 241 shape')
  assert(eq(got.strides,{128,32,8}),'advanced get 241 strides')
  assert(eq(got:tolist(),{{{0,1,2,3},{4,5,6,7},{8,9,10,11},{12,13,14,15}},{{0,1,2,3},{4,5,6,7},{8,9,10,11},{12,13,14,15}},{{0,1,2,3},{4,5,6,7},{8,9,10,11},{12,13,14,15}}}),'advanced get 241 values')
end
do
  local a=np.reshape(np.arange(50),{5,2,5})
  local ix1=np.array({{false,false},{false,false},{false,false},{false,true},{true,false}},np.bool)
  local got=a:get(ix1,np.slice(nil,nil,1))
  assert(eq(got.shape,{2,5}),'advanced get 242 shape')
  assert(eq(got.strides,{40,8}),'advanced get 242 strides')
  assert(eq(got:tolist(),{{35,36,37,38,39},{40,41,42,43,44}}),'advanced get 242 values')
end
do
  local a=np.reshape(np.arange(100),{4,5,5})
  local ix1=np.array({1,3},np.int64)
  local got=a:get(1,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{2,5}),'advanced get 243 shape')
  assert(eq(got.strides,{40,8}),'advanced get 243 strides')
  assert(eq(got:tolist(),{{0,5,10,15,20},{2,7,12,17,22}}),'advanced get 243 values')
end
do
  local a=np.reshape(np.arange(8),{2,2,2})
  local ix1=np.array({{false,false},{false,false}},np.bool)
  local got=a:get(ix1,np.slice(nil,nil,1))
  assert(eq(got.shape,{0,2}),'advanced get 244 shape')
  assert(eq(got.strides,{0,0}),'advanced get 244 strides')
  assert(eq(got:tolist(),{}),'advanced get 244 values')
end
do
  local a=np.reshape(np.arange(20),{2,2,5})
  local ix1=np.array({{2},{-2}},np.int64)
  local ix2=np.array({{2,1,1}},np.int64)
  local got=a:get(ix1,ix2,np.slice(nil,nil,1))
  assert(eq(got.shape,{2,3,5}),'advanced get 245 shape')
  assert(eq(got.strides,{120,40,8}),'advanced get 245 strides')
  assert(eq(got:tolist(),{{{15,16,17,18,19},{10,11,12,13,14},{10,11,12,13,14}},{{5,6,7,8,9},{0,1,2,3,4},{0,1,2,3,4}}}),'advanced get 245 values')
end
do
  local a=np.reshape(np.arange(40),{5,4,2})
  local ix1=np.array({-3,2},np.int64)
  local got=a:get(np.newaxis,ix1,np.slice(nil,nil,1),np.ellipsis)
  assert(eq(got.shape,{1,2,4,2}),'advanced get 246 shape')
  assert(eq(got.strides,{8,64,16,8}),'advanced get 246 strides')
  assert(eq(got:tolist(),{{{{16,17},{18,19},{20,21},{22,23}},{{8,9},{10,11},{12,13},{14,15}}}}),'advanced get 246 values')
end
do
  local a=np.reshape(np.arange(125),{5,5,5})
  local ix1=np.array({true,false,false,true,false},np.bool)
  local got=a:get(ix1,np.ellipsis)
  assert(eq(got.shape,{2,5,5}),'advanced get 247 shape')
  assert(eq(got.strides,{200,40,8}),'advanced get 247 strides')
  assert(eq(got:tolist(),{{{0,1,2,3,4},{5,6,7,8,9},{10,11,12,13,14},{15,16,17,18,19},{20,21,22,23,24}},{{75,76,77,78,79},{80,81,82,83,84},{85,86,87,88,89},{90,91,92,93,94},{95,96,97,98,99}}}),'advanced get 247 values')
end
do
  local a=np.reshape(np.arange(40),{4,2,5})
  local ix1=np.array({{false,false},{false,false},{false,false},{false,true}},np.bool)
  local got=a:get(ix1,np.slice(nil,nil,1))
  assert(eq(got.shape,{1,5}),'advanced get 248 shape')
  assert(eq(got.strides,{40,8}),'advanced get 248 strides')
  assert(eq(got:tolist(),{{35,36,37,38,39}}),'advanced get 248 values')
end
do
  local a=np.reshape(np.arange(30),{5,3,2})
  local ix1=np.array({{false,false,true},{false,true,true},{true,true,false},{true,true,true},{false,true,true}},np.bool)
  local got=a:get(ix1,np.slice(nil,nil,1))
  assert(eq(got.shape,{10,2}),'advanced get 249 shape')
  assert(eq(got.strides,{16,8}),'advanced get 249 strides')
  assert(eq(got:tolist(),{{4,5},{8,9},{10,11},{12,13},{14,15},{18,19},{20,21},{22,23},{26,27},{28,29}}),'advanced get 249 values')
end
do
  local a=np.reshape(np.arange(24),{3,4,2})
  local ix1=np.array({{2},{-2}},np.int64)
  local ix2=np.array({{4}},np.int64)
  local got=a:get(ix1,ix2,np.slice(nil,nil,1))
  assert(eq(got.shape,{2,1,2}),'advanced get 250 shape')
  assert(eq(got.strides,{16,16,8}),'advanced get 250 strides')
  assert(eq(got:tolist(),{{{14,15}},{{14,15}}}),'advanced get 250 values')
end
do
  local a=np.reshape(np.arange(48),{4,4,3})
  local ix1=np.array({true,true,false,false},np.bool)
  local got=a:get(ix1,np.ellipsis)
  assert(eq(got.shape,{2,4,3}),'advanced get 251 shape')
  assert(eq(got.strides,{96,24,8}),'advanced get 251 strides')
  assert(eq(got:tolist(),{{{0,1,2},{3,4,5},{6,7,8},{9,10,11}},{{12,13,14},{15,16,17},{18,19,20},{21,22,23}}}),'advanced get 251 values')
end
do
  local a=np.reshape(np.arange(20),{2,2,5})
  local ix1=np.array({false,true},np.bool)
  local got=a:get(ix1,np.ellipsis)
  assert(eq(got.shape,{1,2,5}),'advanced get 252 shape')
  assert(eq(got.strides,{80,40,8}),'advanced get 252 strides')
  assert(eq(got:tolist(),{{{10,11,12,13,14},{15,16,17,18,19}}}),'advanced get 252 values')
end
do
  local a=np.reshape(np.arange(32),{4,2,4})
  local ix1=np.array({false,true,true,false},np.bool)
  local got=a:get(ix1,np.ellipsis)
  assert(eq(got.shape,{2,2,4}),'advanced get 253 shape')
  assert(eq(got.strides,{64,32,8}),'advanced get 253 strides')
  assert(eq(got:tolist(),{{{8,9,10,11},{12,13,14,15}},{{16,17,18,19},{20,21,22,23}}}),'advanced get 253 values')
end
do
  local a=np.reshape(np.arange(60),{5,3,4})
  local ix1=np.array({3,4,4},np.int64)
  local ix2=np.array({1,1,2},np.int64)
  local got=a:get(ix1,np.slice(nil,nil,1),ix2)
  assert(eq(got.shape,{3,3}),'advanced get 254 shape')
  assert(eq(got.strides,{24,8}),'advanced get 254 strides')
  assert(eq(got:tolist(),{{24,28,32},{36,40,44},{37,41,45}}),'advanced get 254 values')
end
do
  local a=np.reshape(np.arange(8),{2,2,2})
  local ix1=np.array({1,-1,2},np.int64)
  local got=a:get(np.newaxis,ix1,np.slice(nil,nil,1),np.ellipsis)
  assert(eq(got.shape,{1,3,2,2}),'advanced get 255 shape')
  assert(eq(got.strides,{8,32,16,8}),'advanced get 255 strides')
  assert(eq(got:tolist(),{{{{0,1},{2,3}},{{4,5},{6,7}},{{4,5},{6,7}}}}),'advanced get 255 values')
end
do
  local a=np.reshape(np.arange(24),{4,2,3})
  local ix1=np.array({3,3,1},np.int64)
  local got=a:get(ix1)
  assert(eq(got.shape,{3,2,3}),'advanced get 256 shape')
  assert(eq(got.strides,{48,24,8}),'advanced get 256 strides')
  assert(eq(got:tolist(),{{{12,13,14},{15,16,17}},{{12,13,14},{15,16,17}},{{0,1,2},{3,4,5}}}),'advanced get 256 values')
end
do
  local a=np.reshape(np.arange(80),{4,5,4})
  local ix1=np.array({2},np.int64)
  local ix2=np.array({-3},np.int64)
  local got=a:get(ix1,np.slice(nil,nil,1),ix2)
  assert(eq(got.shape,{1,5}),'advanced get 257 shape')
  assert(eq(got.strides,{40,8}),'advanced get 257 strides')
  assert(eq(got:tolist(),{{21,25,29,33,37}}),'advanced get 257 values')
end
do
  local a=np.reshape(np.arange(80),{4,4,5})
  local ix1=np.array({{false,true,true,true},{false,true,false,false},{false,true,false,true},{false,false,true,false}},np.bool)
  local got=a:get(ix1,np.slice(nil,nil,1))
  assert(eq(got.shape,{7,5}),'advanced get 258 shape')
  assert(eq(got.strides,{40,8}),'advanced get 258 strides')
  assert(eq(got:tolist(),{{5,6,7,8,9},{10,11,12,13,14},{15,16,17,18,19},{25,26,27,28,29},{45,46,47,48,49},{55,56,57,58,59},{70,71,72,73,74}}),'advanced get 258 values')
end
do
  local a=np.reshape(np.arange(24),{3,2,4})
  local ix1=np.array({{2},{1},{2}},np.int64)
  local ix2=np.array({{-2,1,1}},np.int64)
  local got=a:get(ix1,ix2,np.slice(nil,nil,1))
  assert(eq(got.shape,{3,3,4}),'advanced get 259 shape')
  assert(eq(got.strides,{96,32,8}),'advanced get 259 strides')
  assert(eq(got:tolist(),{{{8,9,10,11},{8,9,10,11},{8,9,10,11}},{{0,1,2,3},{0,1,2,3},{0,1,2,3}},{{8,9,10,11},{8,9,10,11},{8,9,10,11}}}),'advanced get 259 values')
end
do
  local a=np.reshape(np.arange(12),{2,2,3})
  local ix1=np.array({{-1},{-2},{1}},np.int64)
  local ix2=np.array({{-2}},np.int64)
  local got=a:get(ix1,ix2,np.slice(nil,nil,1))
  assert(eq(got.shape,{3,1,3}),'advanced get 260 shape')
  assert(eq(got.strides,{24,24,8}),'advanced get 260 strides')
  assert(eq(got:tolist(),{{{6,7,8}},{{0,1,2}},{{0,1,2}}}),'advanced get 260 values')
end
do
  local a=np.reshape(np.arange(30),{3,2,5})
  local ix1=np.array({3},np.int64)
  local got=a:get(np.newaxis,ix1,np.slice(nil,nil,1),np.ellipsis)
  assert(eq(got.shape,{1,1,2,5}),'advanced get 261 shape')
  assert(eq(got.strides,{8,80,40,8}),'advanced get 261 strides')
  assert(eq(got:tolist(),{{{{20,21,22,23,24},{25,26,27,28,29}}}}),'advanced get 261 values')
end
do
  local a=np.reshape(np.arange(45),{3,3,5})
  local ix1=np.array({3,1,4},np.int64)
  local got=a:get(1,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{3,3}),'advanced get 262 shape')
  assert(eq(got.strides,{24,8}),'advanced get 262 strides')
  assert(eq(got:tolist(),{{2,7,12},{0,5,10},{3,8,13}}),'advanced get 262 values')
end
do
  local a=np.reshape(np.arange(60),{4,3,5})
  local ix1=np.array({3},np.int64)
  local got=a:get(np.slice(nil,nil,1),ix1,np.ellipsis)
  assert(eq(got.shape,{4,1,5}),'advanced get 263 shape')
  assert(eq(got.strides,{40,160,8}),'advanced get 263 strides')
  assert(eq(got:tolist(),{{{10,11,12,13,14}},{{25,26,27,28,29}},{{40,41,42,43,44}},{{55,56,57,58,59}}}),'advanced get 263 values')
end
do
  local a=np.reshape(np.arange(48),{4,3,4})
  local ix1=np.array({{false,true,true},{false,false,true},{true,false,true},{false,true,false}},np.bool)
  local got=a:get(ix1,np.slice(nil,nil,1))
  assert(eq(got.shape,{6,4}),'advanced get 264 shape')
  assert(eq(got.strides,{32,8}),'advanced get 264 strides')
  assert(eq(got:tolist(),{{4,5,6,7},{8,9,10,11},{20,21,22,23},{24,25,26,27},{32,33,34,35},{40,41,42,43}}),'advanced get 264 values')
end
do
  local a=np.reshape(np.arange(32),{4,4,2})
  local ix1=np.array({2},np.int64)
  local got=a:get(3,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{1,4}),'advanced get 265 shape')
  assert(eq(got.strides,{32,8}),'advanced get 265 strides')
  assert(eq(got:tolist(),{{17,19,21,23}}),'advanced get 265 values')
end
do
  local a=np.reshape(np.arange(80),{4,4,5})
  local ix1=np.array({{false,true,false,true},{false,false,false,true},{false,true,false,false},{false,false,false,true}},np.bool)
  local got=a:get(ix1,np.slice(nil,nil,1))
  assert(eq(got.shape,{5,5}),'advanced get 266 shape')
  assert(eq(got.strides,{40,8}),'advanced get 266 strides')
  assert(eq(got:tolist(),{{5,6,7,8,9},{15,16,17,18,19},{35,36,37,38,39},{45,46,47,48,49},{75,76,77,78,79}}),'advanced get 266 values')
end
do
  local a=np.reshape(np.arange(32),{4,2,4})
  local ix1=np.array({1},np.int64)
  local got=a:get(4,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{1,2}),'advanced get 267 shape')
  assert(eq(got.strides,{16,8}),'advanced get 267 strides')
  assert(eq(got:tolist(),{{24,28}}),'advanced get 267 values')
end
do
  local a=np.reshape(np.arange(50),{2,5,5})
  local ix1=np.array({{2},{1}},np.int64)
  local ix2=np.array({{2,4,-5}},np.int64)
  local got=a:get(ix1,ix2,np.slice(nil,nil,1))
  assert(eq(got.shape,{2,3,5}),'advanced get 268 shape')
  assert(eq(got.strides,{120,40,8}),'advanced get 268 strides')
  assert(eq(got:tolist(),{{{30,31,32,33,34},{40,41,42,43,44},{25,26,27,28,29}},{{5,6,7,8,9},{15,16,17,18,19},{0,1,2,3,4}}}),'advanced get 268 values')
end
do
  local a=np.reshape(np.arange(60),{3,4,5})
  local ix1=np.array({false,true,false},np.bool)
  local got=a:get(ix1,np.ellipsis)
  assert(eq(got.shape,{1,4,5}),'advanced get 269 shape')
  assert(eq(got.strides,{160,40,8}),'advanced get 269 strides')
  assert(eq(got:tolist(),{{{20,21,22,23,24},{25,26,27,28,29},{30,31,32,33,34},{35,36,37,38,39}}}),'advanced get 269 values')
end
do
  local a=np.reshape(np.arange(24),{3,4,2})
  local ix1=np.array({1,3,2},np.int64)
  local got=a:get(np.newaxis,ix1,np.slice(nil,nil,1),np.ellipsis)
  assert(eq(got.shape,{1,3,4,2}),'advanced get 270 shape')
  assert(eq(got.strides,{8,64,16,8}),'advanced get 270 strides')
  assert(eq(got:tolist(),{{{{0,1},{2,3},{4,5},{6,7}},{{16,17},{18,19},{20,21},{22,23}},{{8,9},{10,11},{12,13},{14,15}}}}),'advanced get 270 values')
end
do
  local a=np.reshape(np.arange(45),{5,3,3})
  local ix1=np.array({3},np.int64)
  local ix2=np.array({3},np.int64)
  local got=a:get(ix1,np.slice(nil,nil,1),ix2)
  assert(eq(got.shape,{1,3}),'advanced get 271 shape')
  assert(eq(got.strides,{24,8}),'advanced get 271 strides')
  assert(eq(got:tolist(),{{20,23,26}}),'advanced get 271 values')
end
do
  local a=np.reshape(np.arange(60),{3,4,5})
  local ix1=np.array({false,false,true},np.bool)
  local got=a:get(ix1,np.ellipsis)
  assert(eq(got.shape,{1,4,5}),'advanced get 272 shape')
  assert(eq(got.strides,{160,40,8}),'advanced get 272 strides')
  assert(eq(got:tolist(),{{{40,41,42,43,44},{45,46,47,48,49},{50,51,52,53,54},{55,56,57,58,59}}}),'advanced get 272 values')
end
do
  local a=np.reshape(np.arange(60),{4,5,3})
  local ix1=np.array({-1},np.int64)
  local got=a:get(ix1)
  assert(eq(got.shape,{1,5,3}),'advanced get 273 shape')
  assert(eq(got.strides,{120,24,8}),'advanced get 273 strides')
  assert(eq(got:tolist(),{{{45,46,47},{48,49,50},{51,52,53},{54,55,56},{57,58,59}}}),'advanced get 273 values')
end
do
  local a=np.reshape(np.arange(20),{2,5,2})
  local ix1=np.array({{1},{1},{2}},np.int64)
  local ix2=np.array({{2}},np.int64)
  local got=a:get(ix1,ix2,np.slice(nil,nil,1))
  assert(eq(got.shape,{3,1,2}),'advanced get 274 shape')
  assert(eq(got.strides,{16,16,8}),'advanced get 274 strides')
  assert(eq(got:tolist(),{{{2,3}},{{2,3}},{{12,13}}}),'advanced get 274 values')
end
do
  local a=np.reshape(np.arange(60),{5,3,4})
  local ix1=np.array({false,true,true,true,true},np.bool)
  local got=a:get(ix1,np.ellipsis)
  assert(eq(got.shape,{4,3,4}),'advanced get 275 shape')
  assert(eq(got.strides,{96,32,8}),'advanced get 275 strides')
  assert(eq(got:tolist(),{{{12,13,14,15},{16,17,18,19},{20,21,22,23}},{{24,25,26,27},{28,29,30,31},{32,33,34,35}},{{36,37,38,39},{40,41,42,43},{44,45,46,47}},{{48,49,50,51},{52,53,54,55},{56,57,58,59}}}),'advanced get 275 values')
end
do
  local a=np.reshape(np.arange(100),{5,4,5})
  local ix1=np.array({3},np.int64)
  local got=a:get(ix1)
  assert(eq(got.shape,{1,4,5}),'advanced get 276 shape')
  assert(eq(got.strides,{160,40,8}),'advanced get 276 strides')
  assert(eq(got:tolist(),{{{40,41,42,43,44},{45,46,47,48,49},{50,51,52,53,54},{55,56,57,58,59}}}),'advanced get 276 values')
end
do
  local a=np.reshape(np.arange(48),{3,4,4})
  local ix1=np.array({true,false,false},np.bool)
  local got=a:get(ix1,np.ellipsis)
  assert(eq(got.shape,{1,4,4}),'advanced get 277 shape')
  assert(eq(got.strides,{128,32,8}),'advanced get 277 strides')
  assert(eq(got:tolist(),{{{0,1,2,3},{4,5,6,7},{8,9,10,11},{12,13,14,15}}}),'advanced get 277 values')
end
do
  local a=np.reshape(np.arange(75),{5,3,5})
  local ix1=np.array({{4},{4}},np.int64)
  local ix2=np.array({{2,2,-3}},np.int64)
  local got=a:get(ix1,ix2,np.slice(nil,nil,1))
  assert(eq(got.shape,{2,3,5}),'advanced get 278 shape')
  assert(eq(got.strides,{120,40,8}),'advanced get 278 strides')
  assert(eq(got:tolist(),{{{50,51,52,53,54},{50,51,52,53,54},{45,46,47,48,49}},{{50,51,52,53,54},{50,51,52,53,54},{45,46,47,48,49}}}),'advanced get 278 values')
end
do
  local a=np.reshape(np.arange(30),{5,2,3})
  local ix1=np.array({-4,2},np.int64)
  local got=a:get(np.newaxis,ix1,np.slice(nil,nil,1),np.ellipsis)
  assert(eq(got.shape,{1,2,2,3}),'advanced get 279 shape')
  assert(eq(got.strides,{8,48,24,8}),'advanced get 279 strides')
  assert(eq(got:tolist(),{{{{6,7,8},{9,10,11}},{{6,7,8},{9,10,11}}}}),'advanced get 279 values')
end
do
  local a=np.reshape(np.arange(40),{4,5,2})
  local ix1=np.array({{false,true,false,true,false},{false,false,true,false,false},{false,false,true,false,false},{true,false,false,false,false}},np.bool)
  local got=a:get(ix1,np.slice(nil,nil,1))
  assert(eq(got.shape,{5,2}),'advanced get 280 shape')
  assert(eq(got.strides,{16,8}),'advanced get 280 strides')
  assert(eq(got:tolist(),{{2,3},{6,7},{14,15},{24,25},{30,31}}),'advanced get 280 values')
end
do
  local a=np.reshape(np.arange(48),{3,4,4})
  local ix1=np.array({2},np.int64)
  local got=a:get(ix1)
  assert(eq(got.shape,{1,4,4}),'advanced get 281 shape')
  assert(eq(got.strides,{128,32,8}),'advanced get 281 strides')
  assert(eq(got:tolist(),{{{16,17,18,19},{20,21,22,23},{24,25,26,27},{28,29,30,31}}}),'advanced get 281 values')
end
do
  local a=np.reshape(np.arange(60),{5,3,4})
  local ix1=np.array({-2,1,3},np.int64)
  local got=a:get(ix1)
  assert(eq(got.shape,{3,3,4}),'advanced get 282 shape')
  assert(eq(got.strides,{96,32,8}),'advanced get 282 strides')
  assert(eq(got:tolist(),{{{36,37,38,39},{40,41,42,43},{44,45,46,47}},{{0,1,2,3},{4,5,6,7},{8,9,10,11}},{{24,25,26,27},{28,29,30,31},{32,33,34,35}}}),'advanced get 282 values')
end
do
  local a=np.reshape(np.arange(60),{3,5,4})
  local ix1=np.array({{-1},{-2}},np.int64)
  local ix2=np.array({{2,3,4}},np.int64)
  local got=a:get(ix1,ix2,np.slice(nil,nil,1))
  assert(eq(got.shape,{2,3,4}),'advanced get 283 shape')
  assert(eq(got.strides,{96,32,8}),'advanced get 283 strides')
  assert(eq(got:tolist(),{{{44,45,46,47},{48,49,50,51},{52,53,54,55}},{{24,25,26,27},{28,29,30,31},{32,33,34,35}}}),'advanced get 283 values')
end
do
  local a=np.reshape(np.arange(20),{2,2,5})
  local ix1=np.array({1,2,1},np.int64)
  local got=a:get(np.slice(nil,nil,1),ix1,np.ellipsis)
  assert(eq(got.shape,{2,3,5}),'advanced get 284 shape')
  assert(eq(got.strides,{40,80,8}),'advanced get 284 strides')
  assert(eq(got:tolist(),{{{0,1,2,3,4},{5,6,7,8,9},{0,1,2,3,4}},{{10,11,12,13,14},{15,16,17,18,19},{10,11,12,13,14}}}),'advanced get 284 values')
end
do
  local a=np.reshape(np.arange(36),{3,4,3})
  local ix1=np.array({3,-2,1},np.int64)
  local ix2=np.array({2,3,1},np.int64)
  local got=a:get(ix1,np.slice(nil,nil,1),ix2)
  assert(eq(got.shape,{3,4}),'advanced get 285 shape')
  assert(eq(got.strides,{32,8}),'advanced get 285 strides')
  assert(eq(got:tolist(),{{25,28,31,34},{14,17,20,23},{0,3,6,9}}),'advanced get 285 values')
end
do
  local a=np.reshape(np.arange(30),{5,3,2})
  local ix1=np.array({-3,3,5},np.int64)
  local got=a:get(ix1)
  assert(eq(got.shape,{3,3,2}),'advanced get 286 shape')
  assert(eq(got.strides,{48,16,8}),'advanced get 286 strides')
  assert(eq(got:tolist(),{{{12,13},{14,15},{16,17}},{{12,13},{14,15},{16,17}},{{24,25},{26,27},{28,29}}}),'advanced get 286 values')
end
do
  local a=np.reshape(np.arange(60),{3,5,4})
  local ix1=np.array({3,4},np.int64)
  local got=a:get(3,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{2,5}),'advanced get 287 shape')
  assert(eq(got.strides,{40,8}),'advanced get 287 strides')
  assert(eq(got:tolist(),{{42,46,50,54,58},{43,47,51,55,59}}),'advanced get 287 values')
end
do
  local a=np.reshape(np.arange(60),{5,4,3})
  local ix1=np.array({true,true,true,true,true},np.bool)
  local got=a:get(ix1,np.ellipsis)
  assert(eq(got.shape,{5,4,3}),'advanced get 288 shape')
  assert(eq(got.strides,{96,24,8}),'advanced get 288 strides')
  assert(eq(got:tolist(),{{{0,1,2},{3,4,5},{6,7,8},{9,10,11}},{{12,13,14},{15,16,17},{18,19,20},{21,22,23}},{{24,25,26},{27,28,29},{30,31,32},{33,34,35}},{{36,37,38},{39,40,41},{42,43,44},{45,46,47}},{{48,49,50},{51,52,53},{54,55,56},{57,58,59}}}),'advanced get 288 values')
end
do
  local a=np.reshape(np.arange(80),{5,4,4})
  local ix1=np.array({{false,false,false,true},{true,false,false,true},{true,true,false,true},{false,false,true,false},{false,false,false,false}},np.bool)
  local got=a:get(ix1,np.slice(nil,nil,1))
  assert(eq(got.shape,{7,4}),'advanced get 289 shape')
  assert(eq(got.strides,{32,8}),'advanced get 289 strides')
  assert(eq(got:tolist(),{{12,13,14,15},{16,17,18,19},{28,29,30,31},{32,33,34,35},{36,37,38,39},{44,45,46,47},{56,57,58,59}}),'advanced get 289 values')
end
do
  local a=np.reshape(np.arange(40),{4,5,2})
  local ix1=np.array({4,3},np.int64)
  local ix2=np.array({-1,1},np.int64)
  local got=a:get(ix1,np.slice(nil,nil,1),ix2)
  assert(eq(got.shape,{2,5}),'advanced get 290 shape')
  assert(eq(got.strides,{40,8}),'advanced get 290 strides')
  assert(eq(got:tolist(),{{31,33,35,37,39},{20,22,24,26,28}}),'advanced get 290 values')
end
do
  local a=np.reshape(np.arange(18),{2,3,3})
  local ix1=np.array({{2},{2},{1}},np.int64)
  local ix2=np.array({{-3}},np.int64)
  local got=a:get(ix1,ix2,np.slice(nil,nil,1))
  assert(eq(got.shape,{3,1,3}),'advanced get 291 shape')
  assert(eq(got.strides,{24,24,8}),'advanced get 291 strides')
  assert(eq(got:tolist(),{{{9,10,11}},{{9,10,11}},{{0,1,2}}}),'advanced get 291 values')
end
do
  local a=np.reshape(np.arange(8),{2,2,2})
  local ix1=np.array({-2},np.int64)
  local got=a:get(ix1)
  assert(eq(got.shape,{1,2,2}),'advanced get 292 shape')
  assert(eq(got.strides,{32,16,8}),'advanced get 292 strides')
  assert(eq(got:tolist(),{{{0,1},{2,3}}}),'advanced get 292 values')
end
do
  local a=np.reshape(np.arange(50),{5,5,2})
  local ix1=np.array({{-2},{4}},np.int64)
  local ix2=np.array({{5}},np.int64)
  local got=a:get(ix1,ix2,np.slice(nil,nil,1))
  assert(eq(got.shape,{2,1,2}),'advanced get 293 shape')
  assert(eq(got.strides,{16,16,8}),'advanced get 293 strides')
  assert(eq(got:tolist(),{{{38,39}},{{38,39}}}),'advanced get 293 values')
end
do
  local a=np.reshape(np.arange(64),{4,4,4})
  local ix1=np.array({1,1,-2},np.int64)
  local got=a:get(ix1)
  assert(eq(got.shape,{3,4,4}),'advanced get 294 shape')
  assert(eq(got.strides,{128,32,8}),'advanced get 294 strides')
  assert(eq(got:tolist(),{{{0,1,2,3},{4,5,6,7},{8,9,10,11},{12,13,14,15}},{{0,1,2,3},{4,5,6,7},{8,9,10,11},{12,13,14,15}},{{32,33,34,35},{36,37,38,39},{40,41,42,43},{44,45,46,47}}}),'advanced get 294 values')
end
do
  local a=np.reshape(np.arange(16),{2,4,2})
  local ix1=np.array({1,2,-1},np.int64)
  local got=a:get(ix1)
  assert(eq(got.shape,{3,4,2}),'advanced get 295 shape')
  assert(eq(got.strides,{64,16,8}),'advanced get 295 strides')
  assert(eq(got:tolist(),{{{0,1},{2,3},{4,5},{6,7}},{{8,9},{10,11},{12,13},{14,15}},{{8,9},{10,11},{12,13},{14,15}}}),'advanced get 295 values')
end
do
  local a=np.reshape(np.arange(40),{2,4,5})
  local ix1=np.array({{false,true,false,true},{false,false,false,false}},np.bool)
  local got=a:get(ix1,np.slice(nil,nil,1))
  assert(eq(got.shape,{2,5}),'advanced get 296 shape')
  assert(eq(got.strides,{40,8}),'advanced get 296 strides')
  assert(eq(got:tolist(),{{5,6,7,8,9},{15,16,17,18,19}}),'advanced get 296 values')
end
do
  local a=np.reshape(np.arange(60),{3,5,4})
  local ix1=np.array({2,-3},np.int64)
  local got=a:get(ix1)
  assert(eq(got.shape,{2,5,4}),'advanced get 297 shape')
  assert(eq(got.strides,{160,32,8}),'advanced get 297 strides')
  assert(eq(got:tolist(),{{{20,21,22,23},{24,25,26,27},{28,29,30,31},{32,33,34,35},{36,37,38,39}},{{0,1,2,3},{4,5,6,7},{8,9,10,11},{12,13,14,15},{16,17,18,19}}}),'advanced get 297 values')
end
do
  local a=np.reshape(np.arange(75),{5,3,5})
  local ix1=np.array({2},np.int64)
  local got=a:get(4,np.slice(nil,nil,1),ix1)
  assert(eq(got.shape,{1,3}),'advanced get 298 shape')
  assert(eq(got.strides,{24,8}),'advanced get 298 strides')
  assert(eq(got:tolist(),{{46,51,56}}),'advanced get 298 values')
end
do
  local a=np.reshape(np.arange(80),{4,4,5})
  local ix1=np.array({false,false,false,true},np.bool)
  local got=a:get(ix1,np.ellipsis)
  assert(eq(got.shape,{1,4,5}),'advanced get 299 shape')
  assert(eq(got.strides,{160,40,8}),'advanced get 299 strides')
  assert(eq(got:tolist(),{{{60,61,62,63,64},{65,66,67,68,69},{70,71,72,73,74},{75,76,77,78,79}}}),'advanced get 299 values')
end
do local a=np.arange(4); local i=np.array({0},np.int64); local ok,err=pcall(function() return a:get(i) end); assert(not ok and tostring(err):find('index 0'), 'advanced zero index error') end
do local a=np.arange(4); local i=np.array({5},np.int64); local ok,err=pcall(function() return a:get(i) end); assert(not ok and tostring(err):find('out of bounds'), 'advanced oob error') end
do local a=np.reshape(np.arange(12),{3,4}); local m=np.array({true,false},np.bool); local ok,err=pcall(function() return a:get(m) end); assert(not ok and tostring(err):find('boolean index did not match'), 'boolean mismatch error') end
do local a=np.reshape(np.arange(12),{3,4}); local i=np.reshape(np.array({2},np.int64),{}); local r=a:get(i,np.slice(nil,nil,1)); r[1]=999; assert(a:get(2,1)==4,'0d integer scalar-array copy semantics') end
print('advanced indexing differential: 300 cases ok')
