local np=require("luaray_core")
local function close(a,b)
  if type(a)~=type(b) then return false end
  if type(a)~="table" then
    if type(a)=="number" then
      if a~=a and b~=b then return true end
      if a==b then return true end
      return math.abs(a-b)<=math.max(1e-5,math.abs(b)*3e-6)
    end
    return a==b
  end
  if #a~=#b then return false end
  for i=1,#a do if not close(a[i],b[i]) then return false end end
  return true
end
-- Generated against development NumPy 2.3.5.
do -- reduction 0: sum uint16 [3, 0, 4] axis=0
  local a=np.reshape(np.arange(0,np.uint16),{3,0,4})
  local r=np.sum(a,1)
  assert(r.dtype=="uint64","reduction 0 dtype "..r.dtype)
  assert(close(r:tolist(),{}),"reduction 0 values")
end
do -- reduction 1: prod int32 [1] axis=None
  local a=(np.reshape(np.arange(1,np.int32),{1})+1)
  local r=np.prod(a)
  assert(close(r,1),"reduction 1 scalar")
end
do -- reduction 2: prod uint64 [0, 1] axis=1
  local a=np.reshape(np.arange(0,np.uint64),{0,1})
  local r=np.prod(a,2)
  assert(r.dtype=="uint64","reduction 2 dtype "..r.dtype)
  assert(close(r:tolist(),{}),"reduction 2 values")
end
do -- reduction 3: sum float64 [4, 3, 0] axis=1
  local a=np.reshape(np.arange(0,np.float64),{4,3,0})
  local r=np.sum(a,2)
  assert(r.dtype=="float64","reduction 3 dtype "..r.dtype)
  assert(close(r:tolist(),{{},{},{},{}}),"reduction 3 values")
end
do -- reduction 4: sum int8 [0, 4, 1, 3] axis=3
  local a=np.reshape(np.arange(0,np.int8),{0,4,1,3})
  local r=np.sum(a,4)
  assert(r.dtype=="int64","reduction 4 dtype "..r.dtype)
  assert(close(r:tolist(),{}),"reduction 4 values")
end
do -- reduction 5: sum uint64 [2, 3] axis=None
  local a=np.reshape(np.arange(6,np.uint64),{2,3})
  local r=np.sum(a)
  assert(close(r,15),"reduction 5 scalar")
end
do -- reduction 6: prod uint8 [2, 3, 2, 3] axis=None
  local a=(np.reshape(np.arange(36,np.uint8),{2,3,2,3})+1)
  local r=np.prod(a)
  assert(close(r,9003737871877668864),"reduction 6 scalar")
end
do -- reduction 7: sum int16 [1, 1] axis=0
  local a=np.reshape(np.arange(1,np.int16),{1,1})
  local r=np.sum(a,1)
  assert(r.dtype=="int64","reduction 7 dtype "..r.dtype)
  assert(close(r:tolist(),{0}),"reduction 7 values")
end
do -- reduction 8: prod int64 [0, 2, 4] axis=0
  local a=np.reshape(np.arange(0,np.int64),{0,2,4})
  local r=np.prod(a,1)
  assert(r.dtype=="int64","reduction 8 dtype "..r.dtype)
  assert(close(r:tolist(),{{1,1,1,1},{1,1,1,1}}),"reduction 8 values")
end
do -- reduction 9: prod int64 [4] axis=0
  local a=(np.reshape(np.arange(4,np.int64),{4})+1)
  local r=np.prod(a,1)
  assert(close(r,24),"reduction 9 scalar")
end
do -- reduction 10: sum bool [0] axis=None
  local a=np.reshape(np.arange(0,np.bool),{0})
  local r=np.sum(a)
  assert(close(r,0),"reduction 10 scalar")
end
do -- reduction 11: sum int8 [3, 0] axis=1
  local a=np.reshape(np.arange(0,np.int8),{3,0})
  local r=np.sum(a,2)
  assert(r.dtype=="int64","reduction 11 dtype "..r.dtype)
  assert(close(r:tolist(),{0,0,0}),"reduction 11 values")
end
do -- reduction 12: sum float64 [1, 1, 1, 4] axis=0
  local a=np.reshape(np.arange(4,np.float64),{1,1,1,4})
  local r=np.sum(a,1)
  assert(r.dtype=="float64","reduction 12 dtype "..r.dtype)
  assert(close(r:tolist(),{{{0.0,1.0,2.0,3.0}}}),"reduction 12 values")
end
do -- reduction 13: sum int32 [4, 0, 4] axis=2
  local a=np.reshape(np.arange(0,np.int32),{4,0,4})
  local r=np.sum(a,3)
  assert(r.dtype=="int64","reduction 13 dtype "..r.dtype)
  assert(close(r:tolist(),{{},{},{},{}}),"reduction 13 values")
end
do -- reduction 14: prod float64 [4, 4, 2, 3] axis=3
  local a=(np.reshape(np.arange(96,np.float64),{4,4,2,3})+1)
  local r=np.prod(a,4)
  assert(r.dtype=="float64","reduction 14 dtype "..r.dtype)
  assert(close(r:tolist(),{{{6.0,120.0},{504.0,1320.0},{2730.0,4896.0},{7980.0,12144.0}},{{17550.0,24360.0},{32736.0,42840.0},{54834.0,68880.0},{85140.0,103776.0}},{{124950.0,148824.0},{175560.0,205320.0},{238266.0,274560.0},{314364.0,357840.0}},{{405150.0,456456.0},{511920.0,571704.0},{635970.0,704880.0},{778596.0,857280.0}}}),"reduction 14 values")
end
do -- reduction 15: prod float64 [4] axis=0
  local a=(np.reshape(np.arange(4,np.float64),{4})+1)
  local r=np.prod(a,1)
  assert(close(r,24.0),"reduction 15 scalar")
end
do -- reduction 16: sum uint8 [1, 0, 1] axis=1
  local a=np.reshape(np.arange(0,np.uint8),{1,0,1})
  local r=np.sum(a,2)
  assert(r.dtype=="uint64","reduction 16 dtype "..r.dtype)
  assert(close(r:tolist(),{{0}}),"reduction 16 values")
end
do -- reduction 17: sum int16 [1] axis=0
  local a=np.reshape(np.arange(1,np.int16),{1})
  local r=np.sum(a,1)
  assert(close(r,0),"reduction 17 scalar")
end
do -- reduction 18: prod uint64 [3] axis=0
  local a=(np.reshape(np.arange(3,np.uint64),{3})+1)
  local r=np.prod(a,1)
  assert(close(r,6),"reduction 18 scalar")
end
do -- reduction 19: sum float32 [4, 2, 4, 3] axis=0
  local a=np.reshape(np.arange(96,np.float32),{4,2,4,3})
  local r=np.sum(a,1)
  assert(r.dtype=="float32","reduction 19 dtype "..r.dtype)
  assert(close(r:tolist(),{{{144.0,148.0,152.0},{156.0,160.0,164.0},{168.0,172.0,176.0},{180.0,184.0,188.0}},{{192.0,196.0,200.0},{204.0,208.0,212.0},{216.0,220.0,224.0},{228.0,232.0,236.0}}}),"reduction 19 values")
end
do -- reduction 20: sum float16 [0, 2, 1] axis=2
  local a=np.reshape(np.arange(0,np.float16),{0,2,1})
  local r=np.sum(a,3)
  assert(r.dtype=="float16","reduction 20 dtype "..r.dtype)
  assert(close(r:tolist(),{}),"reduction 20 values")
end
do -- reduction 21: prod uint64 [4, 4, 3] axis=None
  local a=(np.reshape(np.arange(48,np.uint64),{4,4,3})+1)
  local r=np.prod(a)
  assert(close(r,12602690238498734080),"reduction 21 scalar")
end
do -- reduction 22: prod bool [4, 1, 2] axis=None
  local a=np.ones({4,1,2},np.bool)
  local r=np.prod(a)
  assert(close(r,1),"reduction 22 scalar")
end
do -- reduction 23: prod uint32 [2, 1] axis=None
  local a=(np.reshape(np.arange(2,np.uint32),{2,1})+1)
  local r=np.prod(a)
  assert(close(r,2),"reduction 23 scalar")
end
do -- reduction 24: sum float16 [3, 0, 3, 3] axis=3
  local a=np.reshape(np.arange(0,np.float16),{3,0,3,3})
  local r=np.sum(a,4)
  assert(r.dtype=="float16","reduction 24 dtype "..r.dtype)
  assert(close(r:tolist(),{{},{},{}}),"reduction 24 values")
end
do -- reduction 25: sum uint8 [1, 0, 2] axis=None
  local a=np.reshape(np.arange(0,np.uint8),{1,0,2})
  local r=np.sum(a)
  assert(close(r,0),"reduction 25 scalar")
end
do -- reduction 26: sum float64 [0, 4] axis=None
  local a=np.reshape(np.arange(0,np.float64),{0,4})
  local r=np.sum(a)
  assert(close(r,0.0),"reduction 26 scalar")
end
do -- reduction 27: sum int16 [2, 2, 3, 0] axis=1
  local a=np.reshape(np.arange(0,np.int16),{2,2,3,0})
  local r=np.sum(a,2)
  assert(r.dtype=="int64","reduction 27 dtype "..r.dtype)
  assert(close(r:tolist(),{{{},{},{}},{{},{},{}}}),"reduction 27 values")
end
do -- reduction 28: prod bool [1] axis=0
  local a=np.ones({1},np.bool)
  local r=np.prod(a,1)
  assert(close(r,1),"reduction 28 scalar")
end
do -- reduction 29: prod bool [1] axis=0
  local a=np.ones({1},np.bool)
  local r=np.prod(a,1)
  assert(close(r,1),"reduction 29 scalar")
end
do -- reduction 30: prod int16 [4, 2, 4] axis=0
  local a=(np.reshape(np.arange(32,np.int16),{4,2,4})+1)
  local r=np.prod(a,1)
  assert(r.dtype=="int64","reduction 30 dtype "..r.dtype)
  assert(close(r:tolist(),{{3825,9360,16929,26880},{39585,55440,74865,98304}}),"reduction 30 values")
end
do -- reduction 31: prod float32 [2, 0, 4, 2] axis=0
  local a=np.reshape(np.arange(0,np.float32),{2,0,4,2})
  local r=np.prod(a,1)
  assert(r.dtype=="float32","reduction 31 dtype "..r.dtype)
  assert(close(r:tolist(),{}),"reduction 31 values")
end
do -- reduction 32: sum uint32 [0, 3] axis=None
  local a=np.reshape(np.arange(0,np.uint32),{0,3})
  local r=np.sum(a)
  assert(close(r,0),"reduction 32 scalar")
end
do -- reduction 33: prod uint8 [2, 0] axis=None
  local a=np.reshape(np.arange(0,np.uint8),{2,0})
  local r=np.prod(a)
  assert(close(r,1),"reduction 33 scalar")
end
do -- reduction 34: sum uint8 [3, 3, 4] axis=2
  local a=np.reshape(np.arange(36,np.uint8),{3,3,4})
  local r=np.sum(a,3)
  assert(r.dtype=="uint64","reduction 34 dtype "..r.dtype)
  assert(close(r:tolist(),{{6,22,38},{54,70,86},{102,118,134}}),"reduction 34 values")
end
do -- reduction 35: sum int16 [4, 4] axis=0
  local a=np.reshape(np.arange(16,np.int16),{4,4})
  local r=np.sum(a,1)
  assert(r.dtype=="int64","reduction 35 dtype "..r.dtype)
  assert(close(r:tolist(),{24,28,32,36}),"reduction 35 values")
end
do -- reduction 36: sum float64 [0] axis=None
  local a=np.reshape(np.arange(0,np.float64),{0})
  local r=np.sum(a)
  assert(close(r,0.0),"reduction 36 scalar")
end
do -- reduction 37: prod uint32 [3, 0, 4] axis=1
  local a=np.reshape(np.arange(0,np.uint32),{3,0,4})
  local r=np.prod(a,2)
  assert(r.dtype=="uint64","reduction 37 dtype "..r.dtype)
  assert(close(r:tolist(),{{1,1,1,1},{1,1,1,1},{1,1,1,1}}),"reduction 37 values")
end
do -- reduction 38: prod int8 [3] axis=0
  local a=(np.reshape(np.arange(3,np.int8),{3})+1)
  local r=np.prod(a,1)
  assert(close(r,6),"reduction 38 scalar")
end
do -- reduction 39: prod uint64 [3, 0, 2, 1] axis=0
  local a=np.reshape(np.arange(0,np.uint64),{3,0,2,1})
  local r=np.prod(a,1)
  assert(r.dtype=="uint64","reduction 39 dtype "..r.dtype)
  assert(close(r:tolist(),{}),"reduction 39 values")
end
do -- reduction 40: prod int64 [1, 1, 3, 0] axis=2
  local a=np.reshape(np.arange(0,np.int64),{1,1,3,0})
  local r=np.prod(a,3)
  assert(r.dtype=="int64","reduction 40 dtype "..r.dtype)
  assert(close(r:tolist(),{{{}}}),"reduction 40 values")
end
do -- reduction 41: prod float16 [3, 4] axis=None
  local a=(np.reshape(np.arange(12,np.float16),{3,4})+1)
  local r=np.prod(a)
  assert(close(r,math.huge),"reduction 41 scalar")
end
do -- reduction 42: prod int16 [1] axis=0
  local a=(np.reshape(np.arange(1,np.int16),{1})+1)
  local r=np.prod(a,1)
  assert(close(r,1),"reduction 42 scalar")
end
do -- reduction 43: sum float64 [4, 0, 2] axis=2
  local a=np.reshape(np.arange(0,np.float64),{4,0,2})
  local r=np.sum(a,3)
  assert(r.dtype=="float64","reduction 43 dtype "..r.dtype)
  assert(close(r:tolist(),{{},{},{},{}}),"reduction 43 values")
end
do -- reduction 44: sum int64 [1, 4, 3] axis=2
  local a=np.reshape(np.arange(12,np.int64),{1,4,3})
  local r=np.sum(a,3)
  assert(r.dtype=="int64","reduction 44 dtype "..r.dtype)
  assert(close(r:tolist(),{{3,12,21,30}}),"reduction 44 values")
end
do -- reduction 45: sum bool [0, 2, 4, 2] axis=1
  local a=np.reshape(np.arange(0,np.bool),{0,2,4,2})
  local r=np.sum(a,2)
  assert(r.dtype=="int64","reduction 45 dtype "..r.dtype)
  assert(close(r:tolist(),{}),"reduction 45 values")
end
do -- reduction 46: prod int16 [2, 3, 4] axis=1
  local a=(np.reshape(np.arange(24,np.int16),{2,3,4})+1)
  local r=np.prod(a,2)
  assert(r.dtype=="int64","reduction 46 dtype "..r.dtype)
  assert(close(r:tolist(),{{45,120,231,384},{4641,5544,6555,7680}}),"reduction 46 values")
end
do -- reduction 47: sum bool [3] axis=0
  local a=np.reshape(np.arange(3,np.bool),{3})
  local r=np.sum(a,1)
  assert(close(r,2),"reduction 47 scalar")
end
do -- reduction 48: prod uint32 [0, 2] axis=None
  local a=np.reshape(np.arange(0,np.uint32),{0,2})
  local r=np.prod(a)
  assert(close(r,1),"reduction 48 scalar")
end
do -- reduction 49: prod uint64 [3] axis=0
  local a=(np.reshape(np.arange(3,np.uint64),{3})+1)
  local r=np.prod(a,1)
  assert(close(r,6),"reduction 49 scalar")
end
do -- reduction 50: prod uint32 [3, 4] axis=None
  local a=(np.reshape(np.arange(12,np.uint32),{3,4})+1)
  local r=np.prod(a)
  assert(close(r,479001600),"reduction 50 scalar")
end
do -- reduction 51: prod int32 [0, 0] axis=1
  local a=np.reshape(np.arange(0,np.int32),{0,0})
  local r=np.prod(a,2)
  assert(r.dtype=="int64","reduction 51 dtype "..r.dtype)
  assert(close(r:tolist(),{}),"reduction 51 values")
end
do -- reduction 52: prod float64 [3, 0] axis=None
  local a=np.reshape(np.arange(0,np.float64),{3,0})
  local r=np.prod(a)
  assert(close(r,1.0),"reduction 52 scalar")
end
do -- reduction 53: prod int32 [2, 2] axis=None
  local a=(np.reshape(np.arange(4,np.int32),{2,2})+1)
  local r=np.prod(a)
  assert(close(r,24),"reduction 53 scalar")
end
do -- reduction 54: prod int16 [4, 3, 1] axis=None
  local a=(np.reshape(np.arange(12,np.int16),{4,3,1})+1)
  local r=np.prod(a)
  assert(close(r,479001600),"reduction 54 scalar")
end
do -- reduction 55: prod float32 [3, 1, 1, 0] axis=1
  local a=np.reshape(np.arange(0,np.float32),{3,1,1,0})
  local r=np.prod(a,2)
  assert(r.dtype=="float32","reduction 55 dtype "..r.dtype)
  assert(close(r:tolist(),{{{}},{{}},{{}}}),"reduction 55 values")
end
do -- reduction 56: sum float64 [0] axis=0
  local a=np.reshape(np.arange(0,np.float64),{0})
  local r=np.sum(a,1)
  assert(close(r,0.0),"reduction 56 scalar")
end
do -- reduction 57: sum int32 [1, 2] axis=1
  local a=np.reshape(np.arange(2,np.int32),{1,2})
  local r=np.sum(a,2)
  assert(r.dtype=="int64","reduction 57 dtype "..r.dtype)
  assert(close(r:tolist(),{1}),"reduction 57 values")
end
do -- reduction 58: sum float16 [1, 0, 0, 2] axis=None
  local a=np.reshape(np.arange(0,np.float16),{1,0,0,2})
  local r=np.sum(a)
  assert(close(r,0.0),"reduction 58 scalar")
end
do -- reduction 59: sum uint8 [4] axis=0
  local a=np.reshape(np.arange(4,np.uint8),{4})
  local r=np.sum(a,1)
  assert(close(r,6),"reduction 59 scalar")
end
do -- reduction 60: sum float16 [2] axis=0
  local a=np.reshape(np.arange(2,np.float16),{2})
  local r=np.sum(a,1)
  assert(close(r,1.0),"reduction 60 scalar")
end
do -- reduction 61: prod float16 [2, 3, 0, 0] axis=None
  local a=np.reshape(np.arange(0,np.float16),{2,3,0,0})
  local r=np.prod(a)
  assert(close(r,1.0),"reduction 61 scalar")
end
do -- reduction 62: prod uint64 [0, 1, 4] axis=2
  local a=np.reshape(np.arange(0,np.uint64),{0,1,4})
  local r=np.prod(a,3)
  assert(r.dtype=="uint64","reduction 62 dtype "..r.dtype)
  assert(close(r:tolist(),{}),"reduction 62 values")
end
do -- reduction 63: prod float32 [2, 4, 2, 3] axis=0
  local a=(np.reshape(np.arange(48,np.float32),{2,4,2,3})+1)
  local r=np.prod(a,1)
  assert(r.dtype=="float32","reduction 63 dtype "..r.dtype)
  assert(close(r:tolist(),{{{25.0,52.0,81.0},{112.0,145.0,180.0}},{{217.0,256.0,297.0},{340.0,385.0,432.0}},{{481.0,532.0,585.0},{640.0,697.0,756.0}},{{817.0,880.0,945.0},{1012.0,1081.0,1152.0}}}),"reduction 63 values")
end
do -- reduction 64: prod bool [1, 2, 2] axis=0
  local a=np.ones({1,2,2},np.bool)
  local r=np.prod(a,1)
  assert(r.dtype=="int64","reduction 64 dtype "..r.dtype)
  assert(close(r:tolist(),{{1,1},{1,1}}),"reduction 64 values")
end
do -- reduction 65: sum uint64 [2] axis=None
  local a=np.reshape(np.arange(2,np.uint64),{2})
  local r=np.sum(a)
  assert(close(r,1),"reduction 65 scalar")
end
do -- reduction 66: sum uint64 [0, 2, 2, 3] axis=None
  local a=np.reshape(np.arange(0,np.uint64),{0,2,2,3})
  local r=np.sum(a)
  assert(close(r,0),"reduction 66 scalar")
end
do -- reduction 67: prod bool [1, 3, 1, 1] axis=None
  local a=np.ones({1,3,1,1},np.bool)
  local r=np.prod(a)
  assert(close(r,1),"reduction 67 scalar")
end
do -- reduction 68: sum int64 [3, 3, 2] axis=1
  local a=np.reshape(np.arange(18,np.int64),{3,3,2})
  local r=np.sum(a,2)
  assert(r.dtype=="int64","reduction 68 dtype "..r.dtype)
  assert(close(r:tolist(),{{6,9},{24,27},{42,45}}),"reduction 68 values")
end
do -- reduction 69: prod int64 [0, 2, 4, 0] axis=1
  local a=np.reshape(np.arange(0,np.int64),{0,2,4,0})
  local r=np.prod(a,2)
  assert(r.dtype=="int64","reduction 69 dtype "..r.dtype)
  assert(close(r:tolist(),{}),"reduction 69 values")
end
do -- reduction 70: prod float32 [1, 0] axis=0
  local a=np.reshape(np.arange(0,np.float32),{1,0})
  local r=np.prod(a,1)
  assert(r.dtype=="float32","reduction 70 dtype "..r.dtype)
  assert(close(r:tolist(),{}),"reduction 70 values")
end
do -- reduction 71: sum float32 [1, 3, 1] axis=2
  local a=np.reshape(np.arange(3,np.float32),{1,3,1})
  local r=np.sum(a,3)
  assert(r.dtype=="float32","reduction 71 dtype "..r.dtype)
  assert(close(r:tolist(),{{0.0,1.0,2.0}}),"reduction 71 values")
end
do -- reduction 72: prod uint32 [1, 1, 1, 4] axis=1
  local a=(np.reshape(np.arange(4,np.uint32),{1,1,1,4})+1)
  local r=np.prod(a,2)
  assert(r.dtype=="uint64","reduction 72 dtype "..r.dtype)
  assert(close(r:tolist(),{{{1,2,3,4}}}),"reduction 72 values")
end
do -- reduction 73: sum int32 [2, 4, 1, 2] axis=0
  local a=np.reshape(np.arange(16,np.int32),{2,4,1,2})
  local r=np.sum(a,1)
  assert(r.dtype=="int64","reduction 73 dtype "..r.dtype)
  assert(close(r:tolist(),{{{8,10}},{{12,14}},{{16,18}},{{20,22}}}),"reduction 73 values")
end
do -- reduction 74: sum int64 [0, 0] axis=0
  local a=np.reshape(np.arange(0,np.int64),{0,0})
  local r=np.sum(a,1)
  assert(r.dtype=="int64","reduction 74 dtype "..r.dtype)
  assert(close(r:tolist(),{}),"reduction 74 values")
end
do -- reduction 75: prod float32 [0] axis=None
  local a=np.reshape(np.arange(0,np.float32),{0})
  local r=np.prod(a)
  assert(close(r,1.0),"reduction 75 scalar")
end
do -- reduction 76: prod float64 [4, 3] axis=1
  local a=(np.reshape(np.arange(12,np.float64),{4,3})+1)
  local r=np.prod(a,2)
  assert(r.dtype=="float64","reduction 76 dtype "..r.dtype)
  assert(close(r:tolist(),{6.0,120.0,504.0,1320.0}),"reduction 76 values")
end
do -- reduction 77: sum uint64 [4, 0, 3, 1] axis=None
  local a=np.reshape(np.arange(0,np.uint64),{4,0,3,1})
  local r=np.sum(a)
  assert(close(r,0),"reduction 77 scalar")
end
do -- reduction 78: sum int64 [4, 3] axis=0
  local a=np.reshape(np.arange(12,np.int64),{4,3})
  local r=np.sum(a,1)
  assert(r.dtype=="int64","reduction 78 dtype "..r.dtype)
  assert(close(r:tolist(),{18,22,26}),"reduction 78 values")
end
do -- reduction 79: prod uint32 [4, 2] axis=0
  local a=(np.reshape(np.arange(8,np.uint32),{4,2})+1)
  local r=np.prod(a,1)
  assert(r.dtype=="uint64","reduction 79 dtype "..r.dtype)
  assert(close(r:tolist(),{105,384}),"reduction 79 values")
end
do -- reduction 80: prod int8 [1, 0] axis=None
  local a=np.reshape(np.arange(0,np.int8),{1,0})
  local r=np.prod(a)
  assert(close(r,1),"reduction 80 scalar")
end
do -- reduction 81: prod uint16 [4, 3, 3, 0] axis=None
  local a=np.reshape(np.arange(0,np.uint16),{4,3,3,0})
  local r=np.prod(a)
  assert(close(r,1),"reduction 81 scalar")
end
do -- reduction 82: prod float32 [1, 3, 0, 0] axis=1
  local a=np.reshape(np.arange(0,np.float32),{1,3,0,0})
  local r=np.prod(a,2)
  assert(r.dtype=="float32","reduction 82 dtype "..r.dtype)
  assert(close(r:tolist(),{{}}),"reduction 82 values")
end
do -- reduction 83: prod uint32 [3, 1, 0, 4] axis=1
  local a=np.reshape(np.arange(0,np.uint32),{3,1,0,4})
  local r=np.prod(a,2)
  assert(r.dtype=="uint64","reduction 83 dtype "..r.dtype)
  assert(close(r:tolist(),{{},{},{}}),"reduction 83 values")
end
do -- reduction 84: sum uint8 [1, 2, 4, 0] axis=None
  local a=np.reshape(np.arange(0,np.uint8),{1,2,4,0})
  local r=np.sum(a)
  assert(close(r,0),"reduction 84 scalar")
end
do -- reduction 85: prod uint16 [0, 2] axis=None
  local a=np.reshape(np.arange(0,np.uint16),{0,2})
  local r=np.prod(a)
  assert(close(r,1),"reduction 85 scalar")
end
do -- reduction 86: prod int32 [2, 1, 3] axis=0
  local a=(np.reshape(np.arange(6,np.int32),{2,1,3})+1)
  local r=np.prod(a,1)
  assert(r.dtype=="int64","reduction 86 dtype "..r.dtype)
  assert(close(r:tolist(),{{4,10,18}}),"reduction 86 values")
end
do -- reduction 87: sum float16 [0, 4, 4, 3] axis=0
  local a=np.reshape(np.arange(0,np.float16),{0,4,4,3})
  local r=np.sum(a,1)
  assert(r.dtype=="float16","reduction 87 dtype "..r.dtype)
  assert(close(r:tolist(),{{{0.0,0.0,0.0},{0.0,0.0,0.0},{0.0,0.0,0.0},{0.0,0.0,0.0}},{{0.0,0.0,0.0},{0.0,0.0,0.0},{0.0,0.0,0.0},{0.0,0.0,0.0}},{{0.0,0.0,0.0},{0.0,0.0,0.0},{0.0,0.0,0.0},{0.0,0.0,0.0}},{{0.0,0.0,0.0},{0.0,0.0,0.0},{0.0,0.0,0.0},{0.0,0.0,0.0}}}),"reduction 87 values")
end
do -- reduction 88: prod bool [3] axis=None
  local a=np.ones({3},np.bool)
  local r=np.prod(a)
  assert(close(r,1),"reduction 88 scalar")
end
do -- reduction 89: prod int16 [0, 3, 4, 2] axis=0
  local a=np.reshape(np.arange(0,np.int16),{0,3,4,2})
  local r=np.prod(a,1)
  assert(r.dtype=="int64","reduction 89 dtype "..r.dtype)
  assert(close(r:tolist(),{{{1,1},{1,1},{1,1},{1,1}},{{1,1},{1,1},{1,1},{1,1}},{{1,1},{1,1},{1,1},{1,1}}}),"reduction 89 values")
end
do -- reduction 90: prod int64 [2] axis=0
  local a=(np.reshape(np.arange(2,np.int64),{2})+1)
  local r=np.prod(a,1)
  assert(close(r,2),"reduction 90 scalar")
end
do -- reduction 91: sum float64 [4, 4, 4, 3] axis=3
  local a=np.reshape(np.arange(192,np.float64),{4,4,4,3})
  local r=np.sum(a,4)
  assert(r.dtype=="float64","reduction 91 dtype "..r.dtype)
  assert(close(r:tolist(),{{{3.0,12.0,21.0,30.0},{39.0,48.0,57.0,66.0},{75.0,84.0,93.0,102.0},{111.0,120.0,129.0,138.0}},{{147.0,156.0,165.0,174.0},{183.0,192.0,201.0,210.0},{219.0,228.0,237.0,246.0},{255.0,264.0,273.0,282.0}},{{291.0,300.0,309.0,318.0},{327.0,336.0,345.0,354.0},{363.0,372.0,381.0,390.0},{399.0,408.0,417.0,426.0}},{{435.0,444.0,453.0,462.0},{471.0,480.0,489.0,498.0},{507.0,516.0,525.0,534.0},{543.0,552.0,561.0,570.0}}}),"reduction 91 values")
end
do -- reduction 92: prod float16 [2] axis=0
  local a=(np.reshape(np.arange(2,np.float16),{2})+1)
  local r=np.prod(a,1)
  assert(close(r,2.0),"reduction 92 scalar")
end
do -- reduction 93: sum float16 [1, 3, 1, 4] axis=0
  local a=np.reshape(np.arange(12,np.float16),{1,3,1,4})
  local r=np.sum(a,1)
  assert(r.dtype=="float16","reduction 93 dtype "..r.dtype)
  assert(close(r:tolist(),{{{0.0,1.0,2.0,3.0}},{{4.0,5.0,6.0,7.0}},{{8.0,9.0,10.0,11.0}}}),"reduction 93 values")
end
do -- reduction 94: sum float32 [1, 0, 4, 2] axis=None
  local a=np.reshape(np.arange(0,np.float32),{1,0,4,2})
  local r=np.sum(a)
  assert(close(r,0.0),"reduction 94 scalar")
end
do -- reduction 95: prod bool [1, 2, 0, 1] axis=2
  local a=np.ones({1,2,0,1},np.bool)
  local r=np.prod(a,3)
  assert(r.dtype=="int64","reduction 95 dtype "..r.dtype)
  assert(close(r:tolist(),{{{1},{1}}}),"reduction 95 values")
end
do -- reduction 96: prod float16 [3, 3] axis=1
  local a=(np.reshape(np.arange(9,np.float16),{3,3})+1)
  local r=np.prod(a,2)
  assert(r.dtype=="float16","reduction 96 dtype "..r.dtype)
  assert(close(r:tolist(),{6.0,120.0,504.0}),"reduction 96 values")
end
do -- reduction 97: prod uint64 [3] axis=0
  local a=(np.reshape(np.arange(3,np.uint64),{3})+1)
  local r=np.prod(a,1)
  assert(close(r,6),"reduction 97 scalar")
end
do -- reduction 98: sum int64 [0, 0, 3, 0] axis=0
  local a=np.reshape(np.arange(0,np.int64),{0,0,3,0})
  local r=np.sum(a,1)
  assert(r.dtype=="int64","reduction 98 dtype "..r.dtype)
  assert(close(r:tolist(),{}),"reduction 98 values")
end
do -- reduction 99: sum int16 [0, 4, 2] axis=None
  local a=np.reshape(np.arange(0,np.int16),{0,4,2})
  local r=np.sum(a)
  assert(close(r,0),"reduction 99 scalar")
end
do -- reduction 100: prod int8 [1] axis=0
  local a=(np.reshape(np.arange(1,np.int8),{1})+1)
  local r=np.prod(a,1)
  assert(close(r,1),"reduction 100 scalar")
end
do -- reduction 101: sum float16 [4] axis=0
  local a=np.reshape(np.arange(4,np.float16),{4})
  local r=np.sum(a,1)
  assert(close(r,6.0),"reduction 101 scalar")
end
do -- reduction 102: prod bool [2, 3, 0] axis=1
  local a=np.ones({2,3,0},np.bool)
  local r=np.prod(a,2)
  assert(r.dtype=="int64","reduction 102 dtype "..r.dtype)
  assert(close(r:tolist(),{{},{}}),"reduction 102 values")
end
do -- reduction 103: prod int32 [3, 0, 1] axis=2
  local a=np.reshape(np.arange(0,np.int32),{3,0,1})
  local r=np.prod(a,3)
  assert(r.dtype=="int64","reduction 103 dtype "..r.dtype)
  assert(close(r:tolist(),{{},{},{}}),"reduction 103 values")
end
do -- reduction 104: prod float16 [2, 0, 1, 0] axis=0
  local a=np.reshape(np.arange(0,np.float16),{2,0,1,0})
  local r=np.prod(a,1)
  assert(r.dtype=="float16","reduction 104 dtype "..r.dtype)
  assert(close(r:tolist(),{}),"reduction 104 values")
end
do -- reduction 105: sum int8 [4, 2] axis=1
  local a=np.reshape(np.arange(8,np.int8),{4,2})
  local r=np.sum(a,2)
  assert(r.dtype=="int64","reduction 105 dtype "..r.dtype)
  assert(close(r:tolist(),{1,5,9,13}),"reduction 105 values")
end
do -- reduction 106: sum bool [3] axis=0
  local a=np.reshape(np.arange(3,np.bool),{3})
  local r=np.sum(a,1)
  assert(close(r,2),"reduction 106 scalar")
end
do -- reduction 107: sum float64 [4, 2, 1, 3] axis=2
  local a=np.reshape(np.arange(24,np.float64),{4,2,1,3})
  local r=np.sum(a,3)
  assert(r.dtype=="float64","reduction 107 dtype "..r.dtype)
  assert(close(r:tolist(),{{{0.0,1.0,2.0},{3.0,4.0,5.0}},{{6.0,7.0,8.0},{9.0,10.0,11.0}},{{12.0,13.0,14.0},{15.0,16.0,17.0}},{{18.0,19.0,20.0},{21.0,22.0,23.0}}}),"reduction 107 values")
end
do -- reduction 108: prod float16 [4] axis=None
  local a=(np.reshape(np.arange(4,np.float16),{4})+1)
  local r=np.prod(a)
  assert(close(r,24.0),"reduction 108 scalar")
end
do -- reduction 109: prod bool [3] axis=0
  local a=np.ones({3},np.bool)
  local r=np.prod(a,1)
  assert(close(r,1),"reduction 109 scalar")
end
do -- reduction 110: prod int32 [0] axis=None
  local a=np.reshape(np.arange(0,np.int32),{0})
  local r=np.prod(a)
  assert(close(r,1),"reduction 110 scalar")
end
do -- reduction 111: prod uint16 [2] axis=0
  local a=(np.reshape(np.arange(2,np.uint16),{2})+1)
  local r=np.prod(a,1)
  assert(close(r,2),"reduction 111 scalar")
end
do -- reduction 112: sum int16 [1, 4, 0] axis=2
  local a=np.reshape(np.arange(0,np.int16),{1,4,0})
  local r=np.sum(a,3)
  assert(r.dtype=="int64","reduction 112 dtype "..r.dtype)
  assert(close(r:tolist(),{{0,0,0,0}}),"reduction 112 values")
end
do -- reduction 113: prod float64 [2] axis=0
  local a=(np.reshape(np.arange(2,np.float64),{2})+1)
  local r=np.prod(a,1)
  assert(close(r,2.0),"reduction 113 scalar")
end
do -- reduction 114: prod uint16 [4, 3, 3, 2] axis=2
  local a=(np.reshape(np.arange(72,np.uint16),{4,3,3,2})+1)
  local r=np.prod(a,3)
  assert(r.dtype=="uint64","reduction 114 dtype "..r.dtype)
  assert(close(r:tolist(),{{{15,48},{693,960},{3315,4032}},{{9177,10560},{19575,21840},{35805,39168}},{{59163,63840},{90945,97152},{132447,140400}},{{184965,194880},{249795,261888},{328233,342720}}}),"reduction 114 values")
end
do -- reduction 115: prod uint8 [2, 4, 4] axis=1
  local a=(np.reshape(np.arange(32,np.uint8),{2,4,4})+1)
  local r=np.prod(a,2)
  assert(r.dtype=="uint64","reduction 115 dtype "..r.dtype)
  assert(close(r:tolist(),{{585,1680,3465,6144},{258825,308880,365769,430080}}),"reduction 115 values")
end
do -- reduction 116: sum uint16 [0, 0] axis=1
  local a=np.reshape(np.arange(0,np.uint16),{0,0})
  local r=np.sum(a,2)
  assert(r.dtype=="uint64","reduction 116 dtype "..r.dtype)
  assert(close(r:tolist(),{}),"reduction 116 values")
end
do -- reduction 117: prod int64 [4, 0] axis=1
  local a=np.reshape(np.arange(0,np.int64),{4,0})
  local r=np.prod(a,2)
  assert(r.dtype=="int64","reduction 117 dtype "..r.dtype)
  assert(close(r:tolist(),{1,1,1,1}),"reduction 117 values")
end
do -- reduction 118: sum bool [2, 3, 0] axis=2
  local a=np.reshape(np.arange(0,np.bool),{2,3,0})
  local r=np.sum(a,3)
  assert(r.dtype=="int64","reduction 118 dtype "..r.dtype)
  assert(close(r:tolist(),{{0,0,0},{0,0,0}}),"reduction 118 values")
end
do -- reduction 119: prod uint64 [4, 0] axis=0
  local a=np.reshape(np.arange(0,np.uint64),{4,0})
  local r=np.prod(a,1)
  assert(r.dtype=="uint64","reduction 119 dtype "..r.dtype)
  assert(close(r:tolist(),{}),"reduction 119 values")
end
do -- reduction 120: prod uint64 [0, 2] axis=1
  local a=np.reshape(np.arange(0,np.uint64),{0,2})
  local r=np.prod(a,2)
  assert(r.dtype=="uint64","reduction 120 dtype "..r.dtype)
  assert(close(r:tolist(),{}),"reduction 120 values")
end
do -- reduction 121: prod uint16 [4] axis=None
  local a=(np.reshape(np.arange(4,np.uint16),{4})+1)
  local r=np.prod(a)
  assert(close(r,24),"reduction 121 scalar")
end
do -- reduction 122: prod uint32 [2, 4, 3, 0] axis=0
  local a=np.reshape(np.arange(0,np.uint32),{2,4,3,0})
  local r=np.prod(a,1)
  assert(r.dtype=="uint64","reduction 122 dtype "..r.dtype)
  assert(close(r:tolist(),{{{},{},{}},{{},{},{}},{{},{},{}},{{},{},{}}}),"reduction 122 values")
end
do -- reduction 123: sum uint16 [4] axis=None
  local a=np.reshape(np.arange(4,np.uint16),{4})
  local r=np.sum(a)
  assert(close(r,6),"reduction 123 scalar")
end
do -- reduction 124: prod uint32 [1, 3, 2, 4] axis=2
  local a=(np.reshape(np.arange(24,np.uint32),{1,3,2,4})+1)
  local r=np.prod(a,3)
  assert(r.dtype=="uint64","reduction 124 dtype "..r.dtype)
  assert(close(r:tolist(),{{{5,12,21,32},{117,140,165,192},{357,396,437,480}}}),"reduction 124 values")
end
do -- reduction 125: prod int8 [1, 4, 4] axis=None
  local a=(np.reshape(np.arange(16,np.int8),{1,4,4})+1)
  local r=np.prod(a)
  assert(close(r,20922789888000),"reduction 125 scalar")
end
do -- reduction 126: sum int32 [1, 4, 1] axis=1
  local a=np.reshape(np.arange(4,np.int32),{1,4,1})
  local r=np.sum(a,2)
  assert(r.dtype=="int64","reduction 126 dtype "..r.dtype)
  assert(close(r:tolist(),{{6}}),"reduction 126 values")
end
do -- reduction 127: prod int8 [3, 4] axis=None
  local a=(np.reshape(np.arange(12,np.int8),{3,4})+1)
  local r=np.prod(a)
  assert(close(r,479001600),"reduction 127 scalar")
end
do -- reduction 128: prod bool [1, 4] axis=None
  local a=np.ones({1,4},np.bool)
  local r=np.prod(a)
  assert(close(r,1),"reduction 128 scalar")
end
do -- reduction 129: prod float64 [4] axis=None
  local a=(np.reshape(np.arange(4,np.float64),{4})+1)
  local r=np.prod(a)
  assert(close(r,24.0),"reduction 129 scalar")
end
do -- reduction 130: sum float64 [4] axis=0
  local a=np.reshape(np.arange(4,np.float64),{4})
  local r=np.sum(a,1)
  assert(close(r,6.0),"reduction 130 scalar")
end
do -- reduction 131: sum float64 [1] axis=None
  local a=np.reshape(np.arange(1,np.float64),{1})
  local r=np.sum(a)
  assert(close(r,0.0),"reduction 131 scalar")
end
do -- reduction 132: sum uint32 [4, 1, 2, 1] axis=1
  local a=np.reshape(np.arange(8,np.uint32),{4,1,2,1})
  local r=np.sum(a,2)
  assert(r.dtype=="uint64","reduction 132 dtype "..r.dtype)
  assert(close(r:tolist(),{{{0},{1}},{{2},{3}},{{4},{5}},{{6},{7}}}),"reduction 132 values")
end
do -- reduction 133: prod uint64 [4, 4, 2, 3] axis=3
  local a=(np.reshape(np.arange(96,np.uint64),{4,4,2,3})+1)
  local r=np.prod(a,4)
  assert(r.dtype=="uint64","reduction 133 dtype "..r.dtype)
  assert(close(r:tolist(),{{{6,120},{504,1320},{2730,4896},{7980,12144}},{{17550,24360},{32736,42840},{54834,68880},{85140,103776}},{{124950,148824},{175560,205320},{238266,274560},{314364,357840}},{{405150,456456},{511920,571704},{635970,704880},{778596,857280}}}),"reduction 133 values")
end
do -- reduction 134: sum uint32 [1, 2] axis=1
  local a=np.reshape(np.arange(2,np.uint32),{1,2})
  local r=np.sum(a,2)
  assert(r.dtype=="uint64","reduction 134 dtype "..r.dtype)
  assert(close(r:tolist(),{1}),"reduction 134 values")
end
do -- reduction 135: prod float32 [4] axis=0
  local a=(np.reshape(np.arange(4,np.float32),{4})+1)
  local r=np.prod(a,1)
  assert(close(r,24.0),"reduction 135 scalar")
end
do -- reduction 136: sum uint16 [1, 3, 3, 1] axis=0
  local a=np.reshape(np.arange(9,np.uint16),{1,3,3,1})
  local r=np.sum(a,1)
  assert(r.dtype=="uint64","reduction 136 dtype "..r.dtype)
  assert(close(r:tolist(),{{{0},{1},{2}},{{3},{4},{5}},{{6},{7},{8}}}),"reduction 136 values")
end
do -- reduction 137: sum int16 [3, 4, 2] axis=0
  local a=np.reshape(np.arange(24,np.int16),{3,4,2})
  local r=np.sum(a,1)
  assert(r.dtype=="int64","reduction 137 dtype "..r.dtype)
  assert(close(r:tolist(),{{24,27},{30,33},{36,39},{42,45}}),"reduction 137 values")
end
do -- reduction 138: sum uint64 [0, 1, 4, 3] axis=2
  local a=np.reshape(np.arange(0,np.uint64),{0,1,4,3})
  local r=np.sum(a,3)
  assert(r.dtype=="uint64","reduction 138 dtype "..r.dtype)
  assert(close(r:tolist(),{}),"reduction 138 values")
end
do -- reduction 139: sum uint16 [2] axis=0
  local a=np.reshape(np.arange(2,np.uint16),{2})
  local r=np.sum(a,1)
  assert(close(r,1),"reduction 139 scalar")
end
do -- reduction 140: prod int8 [1, 4, 1, 2] axis=2
  local a=(np.reshape(np.arange(8,np.int8),{1,4,1,2})+1)
  local r=np.prod(a,3)
  assert(r.dtype=="int64","reduction 140 dtype "..r.dtype)
  assert(close(r:tolist(),{{{1,2},{3,4},{5,6},{7,8}}}),"reduction 140 values")
end
do -- reduction 141: sum int32 [3] axis=None
  local a=np.reshape(np.arange(3,np.int32),{3})
  local r=np.sum(a)
  assert(close(r,3),"reduction 141 scalar")
end
do -- reduction 142: prod float16 [0, 4] axis=1
  local a=np.reshape(np.arange(0,np.float16),{0,4})
  local r=np.prod(a,2)
  assert(r.dtype=="float16","reduction 142 dtype "..r.dtype)
  assert(close(r:tolist(),{}),"reduction 142 values")
end
do -- reduction 143: sum int32 [1, 2, 2, 2] axis=1
  local a=np.reshape(np.arange(8,np.int32),{1,2,2,2})
  local r=np.sum(a,2)
  assert(r.dtype=="int64","reduction 143 dtype "..r.dtype)
  assert(close(r:tolist(),{{{4,6},{8,10}}}),"reduction 143 values")
end
do -- reduction 144: prod uint16 [4, 3, 2] axis=None
  local a=(np.reshape(np.arange(24,np.uint16),{4,3,2})+1)
  local r=np.prod(a)
  assert(close(r,10611558092380307456),"reduction 144 scalar")
end
do -- reduction 145: sum uint8 [3, 0, 1] axis=None
  local a=np.reshape(np.arange(0,np.uint8),{3,0,1})
  local r=np.sum(a)
  assert(close(r,0),"reduction 145 scalar")
end
do -- reduction 146: prod uint64 [4, 1, 4, 1] axis=2
  local a=(np.reshape(np.arange(16,np.uint64),{4,1,4,1})+1)
  local r=np.prod(a,3)
  assert(r.dtype=="uint64","reduction 146 dtype "..r.dtype)
  assert(close(r:tolist(),{{{24}},{{1680}},{{11880}},{{43680}}}),"reduction 146 values")
end
do -- reduction 147: sum int64 [3, 1, 2, 2] axis=None
  local a=np.reshape(np.arange(12,np.int64),{3,1,2,2})
  local r=np.sum(a)
  assert(close(r,66),"reduction 147 scalar")
end
do -- reduction 148: sum int32 [1, 2, 2] axis=1
  local a=np.reshape(np.arange(4,np.int32),{1,2,2})
  local r=np.sum(a,2)
  assert(r.dtype=="int64","reduction 148 dtype "..r.dtype)
  assert(close(r:tolist(),{{2,4}}),"reduction 148 values")
end
do -- reduction 149: sum uint8 [3, 0] axis=None
  local a=np.reshape(np.arange(0,np.uint8),{3,0})
  local r=np.sum(a)
  assert(close(r,0),"reduction 149 scalar")
end
do -- reduction 150: sum float64 [2, 0] axis=0
  local a=np.reshape(np.arange(0,np.float64),{2,0})
  local r=np.sum(a,1)
  assert(r.dtype=="float64","reduction 150 dtype "..r.dtype)
  assert(close(r:tolist(),{}),"reduction 150 values")
end
do -- reduction 151: sum uint8 [4, 0, 0] axis=None
  local a=np.reshape(np.arange(0,np.uint8),{4,0,0})
  local r=np.sum(a)
  assert(close(r,0),"reduction 151 scalar")
end
do -- reduction 152: prod float16 [1, 2, 3, 1] axis=None
  local a=(np.reshape(np.arange(6,np.float16),{1,2,3,1})+1)
  local r=np.prod(a)
  assert(close(r,720.0),"reduction 152 scalar")
end
do -- reduction 153: prod float32 [4] axis=0
  local a=(np.reshape(np.arange(4,np.float32),{4})+1)
  local r=np.prod(a,1)
  assert(close(r,24.0),"reduction 153 scalar")
end
do -- reduction 154: prod int8 [0, 4, 2, 1] axis=2
  local a=np.reshape(np.arange(0,np.int8),{0,4,2,1})
  local r=np.prod(a,3)
  assert(r.dtype=="int64","reduction 154 dtype "..r.dtype)
  assert(close(r:tolist(),{}),"reduction 154 values")
end
do -- reduction 155: prod uint16 [0] axis=None
  local a=np.reshape(np.arange(0,np.uint16),{0})
  local r=np.prod(a)
  assert(close(r,1),"reduction 155 scalar")
end
do -- reduction 156: sum int64 [3] axis=0
  local a=np.reshape(np.arange(3,np.int64),{3})
  local r=np.sum(a,1)
  assert(close(r,3),"reduction 156 scalar")
end
do -- reduction 157: sum uint64 [0, 2, 1, 2] axis=0
  local a=np.reshape(np.arange(0,np.uint64),{0,2,1,2})
  local r=np.sum(a,1)
  assert(r.dtype=="uint64","reduction 157 dtype "..r.dtype)
  assert(close(r:tolist(),{{{0,0}},{{0,0}}}),"reduction 157 values")
end
do -- reduction 158: prod uint16 [4] axis=0
  local a=(np.reshape(np.arange(4,np.uint16),{4})+1)
  local r=np.prod(a,1)
  assert(close(r,24),"reduction 158 scalar")
end
do -- reduction 159: sum float32 [1, 2, 2, 4] axis=2
  local a=np.reshape(np.arange(16,np.float32),{1,2,2,4})
  local r=np.sum(a,3)
  assert(r.dtype=="float32","reduction 159 dtype "..r.dtype)
  assert(close(r:tolist(),{{{4.0,6.0,8.0,10.0},{20.0,22.0,24.0,26.0}}}),"reduction 159 values")
end
do -- reduction 160: sum uint32 [3, 1, 3] axis=2
  local a=np.reshape(np.arange(9,np.uint32),{3,1,3})
  local r=np.sum(a,3)
  assert(r.dtype=="uint64","reduction 160 dtype "..r.dtype)
  assert(close(r:tolist(),{{3},{12},{21}}),"reduction 160 values")
end
do -- reduction 161: prod int16 [2, 1] axis=0
  local a=(np.reshape(np.arange(2,np.int16),{2,1})+1)
  local r=np.prod(a,1)
  assert(r.dtype=="int64","reduction 161 dtype "..r.dtype)
  assert(close(r:tolist(),{2}),"reduction 161 values")
end
do -- reduction 162: sum int8 [4] axis=0
  local a=np.reshape(np.arange(4,np.int8),{4})
  local r=np.sum(a,1)
  assert(close(r,6),"reduction 162 scalar")
end
do -- reduction 163: prod bool [3] axis=0
  local a=np.ones({3},np.bool)
  local r=np.prod(a,1)
  assert(close(r,1),"reduction 163 scalar")
end
do -- reduction 164: prod uint64 [1, 2, 4] axis=2
  local a=(np.reshape(np.arange(8,np.uint64),{1,2,4})+1)
  local r=np.prod(a,3)
  assert(r.dtype=="uint64","reduction 164 dtype "..r.dtype)
  assert(close(r:tolist(),{{24,1680}}),"reduction 164 values")
end
do -- reduction 165: prod uint32 [2, 2] axis=1
  local a=(np.reshape(np.arange(4,np.uint32),{2,2})+1)
  local r=np.prod(a,2)
  assert(r.dtype=="uint64","reduction 165 dtype "..r.dtype)
  assert(close(r:tolist(),{2,12}),"reduction 165 values")
end
do -- reduction 166: prod float32 [4, 0, 4, 4] axis=3
  local a=np.reshape(np.arange(0,np.float32),{4,0,4,4})
  local r=np.prod(a,4)
  assert(r.dtype=="float32","reduction 166 dtype "..r.dtype)
  assert(close(r:tolist(),{{},{},{},{}}),"reduction 166 values")
end
do -- reduction 167: prod int64 [0] axis=0
  local a=np.reshape(np.arange(0,np.int64),{0})
  local r=np.prod(a,1)
  assert(close(r,1),"reduction 167 scalar")
end
do -- reduction 168: sum int8 [1] axis=None
  local a=np.reshape(np.arange(1,np.int8),{1})
  local r=np.sum(a)
  assert(close(r,0),"reduction 168 scalar")
end
do -- reduction 169: sum int16 [0, 3, 2, 0] axis=3
  local a=np.reshape(np.arange(0,np.int16),{0,3,2,0})
  local r=np.sum(a,4)
  assert(r.dtype=="int64","reduction 169 dtype "..r.dtype)
  assert(close(r:tolist(),{}),"reduction 169 values")
end
do -- reduction 170: prod float64 [1, 3, 4] axis=None
  local a=(np.reshape(np.arange(12,np.float64),{1,3,4})+1)
  local r=np.prod(a)
  assert(close(r,479001600.0),"reduction 170 scalar")
end
do -- reduction 171: prod bool [0, 3] axis=1
  local a=np.ones({0,3},np.bool)
  local r=np.prod(a,2)
  assert(r.dtype=="int64","reduction 171 dtype "..r.dtype)
  assert(close(r:tolist(),{}),"reduction 171 values")
end
do -- reduction 172: sum uint32 [4, 4, 4] axis=2
  local a=np.reshape(np.arange(64,np.uint32),{4,4,4})
  local r=np.sum(a,3)
  assert(r.dtype=="uint64","reduction 172 dtype "..r.dtype)
  assert(close(r:tolist(),{{6,22,38,54},{70,86,102,118},{134,150,166,182},{198,214,230,246}}),"reduction 172 values")
end
do -- reduction 173: sum int8 [4, 2, 1] axis=2
  local a=np.reshape(np.arange(8,np.int8),{4,2,1})
  local r=np.sum(a,3)
  assert(r.dtype=="int64","reduction 173 dtype "..r.dtype)
  assert(close(r:tolist(),{{0,1},{2,3},{4,5},{6,7}}),"reduction 173 values")
end
do -- reduction 174: sum uint8 [2, 1, 1, 1] axis=None
  local a=np.reshape(np.arange(2,np.uint8),{2,1,1,1})
  local r=np.sum(a)
  assert(close(r,1),"reduction 174 scalar")
end
do -- reduction 175: prod int64 [0, 3] axis=None
  local a=np.reshape(np.arange(0,np.int64),{0,3})
  local r=np.prod(a)
  assert(close(r,1),"reduction 175 scalar")
end
do -- reduction 176: sum int8 [1] axis=None
  local a=np.reshape(np.arange(1,np.int8),{1})
  local r=np.sum(a)
  assert(close(r,0),"reduction 176 scalar")
end
do -- reduction 177: prod float64 [3] axis=None
  local a=(np.reshape(np.arange(3,np.float64),{3})+1)
  local r=np.prod(a)
  assert(close(r,6.0),"reduction 177 scalar")
end
do -- reduction 178: prod int32 [2, 2, 2, 0] axis=2
  local a=np.reshape(np.arange(0,np.int32),{2,2,2,0})
  local r=np.prod(a,3)
  assert(r.dtype=="int64","reduction 178 dtype "..r.dtype)
  assert(close(r:tolist(),{{{},{}},{{},{}}}),"reduction 178 values")
end
do -- reduction 179: sum uint32 [2, 4, 3, 0] axis=0
  local a=np.reshape(np.arange(0,np.uint32),{2,4,3,0})
  local r=np.sum(a,1)
  assert(r.dtype=="uint64","reduction 179 dtype "..r.dtype)
  assert(close(r:tolist(),{{{},{},{}},{{},{},{}},{{},{},{}},{{},{},{}}}),"reduction 179 values")
end
do -- explicit pairwise summation discriminator
  local a=np.arange(10000,np.float32)
  local r=np.sum(a); assert(r==49995000.0,"pairwise float32 sum")
  assert(r~=49992896.0,"pairwise path accidentally became linear")
end
do local a=np.array({5},np.int32):get(1,np.ellipsis); assert(a.ndim==0); assert(np.sum(a,1)==5); assert(np.prod(a,-1)==5) end
print('reduction differential: 182 cases ok')
