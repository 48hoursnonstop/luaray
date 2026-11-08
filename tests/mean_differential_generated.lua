local np=require("luaray_core")
local function close(a,b)
  if type(a)~=type(b) then return false end
  if type(a)~="table" then
    if type(a)=="number" then
      if a~=a and b~=b then return true end
      if a==b then return true end
      return math.abs(a-b)<=math.max(1e-6,math.abs(b)*3e-6)
    end
    return a==b
  end
  if #a~=#b then return false end
  for i=1,#a do if not close(a[i],b[i]) then return false end end
  return true
end
-- Generated against development NumPy 2.3.5.
do -- mean 0: uint64 [1, 2] axis=None
  local a=np.reshape(np.arange(2,np.uint64),{1,2})
  local r=np.mean(a)
  assert(close(r,0.5),"mean 0 scalar")
end
do -- mean 1: float32 [1, 4, 2, 3] axis=1
  local a=np.reshape(np.arange(24,np.float32),{1,4,2,3})
  local r=np.mean(a,2)
  assert(r.dtype=="float32","mean 1 dtype "..r.dtype)
  assert(close(r:tolist(),{{{9.0,10.0,11.0},{12.0,13.0,14.0}}}),"mean 1 values")
end
do -- mean 2: int16 [3, 4, 3, 3] axis=None
  local a=np.reshape(np.arange(108,np.int16),{3,4,3,3})
  local r=np.mean(a)
  assert(close(r,53.5),"mean 2 scalar")
end
do -- mean 3: int16 [3, 4] axis=None
  local a=np.reshape(np.arange(12,np.int16),{3,4})
  local r=np.mean(a)
  assert(close(r,5.5),"mean 3 scalar")
end
do -- mean 4: uint16 [4, 2, 2, 4] axis=None
  local a=np.reshape(np.arange(64,np.uint16),{4,2,2,4})
  local r=np.mean(a)
  assert(close(r,31.5),"mean 4 scalar")
end
do -- mean 5: bool [2, 2] axis=None
  local a=np.reshape(np.arange(4,np.bool),{2,2})
  local r=np.mean(a)
  assert(close(r,0.75),"mean 5 scalar")
end
do -- mean 6: float16 [0, 2] axis=None
  local a=np.reshape(np.arange(0,np.float16),{0,2})
  local r=np.mean(a)
  assert(close(r,0/0),"mean 6 scalar")
end
do -- mean 7: float64 [0, 3] axis=None
  local a=np.reshape(np.arange(0,np.float64),{0,3})
  local r=np.mean(a)
  assert(close(r,0/0),"mean 7 scalar")
end
do -- mean 8: uint16 [0, 3, 3, 0] axis=3
  local a=np.reshape(np.arange(0,np.uint16),{0,3,3,0})
  local r=np.mean(a,4)
  assert(r.dtype=="float64","mean 8 dtype "..r.dtype)
  assert(close(r:tolist(),{}),"mean 8 values")
end
do -- mean 9: int64 [1, 1, 3, 4] axis=None
  local a=np.reshape(np.arange(12,np.int64),{1,1,3,4})
  local r=np.mean(a)
  assert(close(r,5.5),"mean 9 scalar")
end
do -- mean 10: uint64 [2, 1] axis=0
  local a=np.reshape(np.arange(2,np.uint64),{2,1})
  local r=np.mean(a,1)
  assert(r.dtype=="float64","mean 10 dtype "..r.dtype)
  assert(close(r:tolist(),{0.5}),"mean 10 values")
end
do -- mean 11: float64 [0, 3, 1] axis=None
  local a=np.reshape(np.arange(0,np.float64),{0,3,1})
  local r=np.mean(a)
  assert(close(r,0/0),"mean 11 scalar")
end
do -- mean 12: float64 [0, 4, 3] axis=2
  local a=np.reshape(np.arange(0,np.float64),{0,4,3})
  local r=np.mean(a,3)
  assert(r.dtype=="float64","mean 12 dtype "..r.dtype)
  assert(close(r:tolist(),{}),"mean 12 values")
end
do -- mean 13: uint32 [0] axis=0
  local a=np.reshape(np.arange(0,np.uint32),{0})
  local r=np.mean(a,1)
  assert(close(r,0/0),"mean 13 scalar")
end
do -- mean 14: uint8 [0, 1] axis=0
  local a=np.reshape(np.arange(0,np.uint8),{0,1})
  local r=np.mean(a,1)
  assert(r.dtype=="float64","mean 14 dtype "..r.dtype)
  assert(close(r:tolist(),{0/0}),"mean 14 values")
end
do -- mean 15: int64 [2, 3, 1, 0] axis=None
  local a=np.reshape(np.arange(0,np.int64),{2,3,1,0})
  local r=np.mean(a)
  assert(close(r,0/0),"mean 15 scalar")
end
do -- mean 16: float16 [4] axis=0
  local a=np.reshape(np.arange(4,np.float16),{4})
  local r=np.mean(a,1)
  assert(close(r,1.5),"mean 16 scalar")
end
do -- mean 17: int32 [1, 1] axis=None
  local a=np.reshape(np.arange(1,np.int32),{1,1})
  local r=np.mean(a)
  assert(close(r,0.0),"mean 17 scalar")
end
do -- mean 18: uint8 [4, 4, 0, 0] axis=None
  local a=np.reshape(np.arange(0,np.uint8),{4,4,0,0})
  local r=np.mean(a)
  assert(close(r,0/0),"mean 18 scalar")
end
do -- mean 19: int32 [0, 1, 3] axis=0
  local a=np.reshape(np.arange(0,np.int32),{0,1,3})
  local r=np.mean(a,1)
  assert(r.dtype=="float64","mean 19 dtype "..r.dtype)
  assert(close(r:tolist(),{{0/0,0/0,0/0}}),"mean 19 values")
end
do -- mean 20: float16 [3, 0, 4] axis=None
  local a=np.reshape(np.arange(0,np.float16),{3,0,4})
  local r=np.mean(a)
  assert(close(r,0/0),"mean 20 scalar")
end
do -- mean 21: float16 [1] axis=None
  local a=np.reshape(np.arange(1,np.float16),{1})
  local r=np.mean(a)
  assert(close(r,0.0),"mean 21 scalar")
end
do -- mean 22: int64 [2, 4, 2, 3] axis=None
  local a=np.reshape(np.arange(48,np.int64),{2,4,2,3})
  local r=np.mean(a)
  assert(close(r,23.5),"mean 22 scalar")
end
do -- mean 23: int64 [0, 1, 0, 4] axis=0
  local a=np.reshape(np.arange(0,np.int64),{0,1,0,4})
  local r=np.mean(a,1)
  assert(r.dtype=="float64","mean 23 dtype "..r.dtype)
  assert(close(r:tolist(),{{}}),"mean 23 values")
end
do -- mean 24: int64 [2] axis=0
  local a=np.reshape(np.arange(2,np.int64),{2})
  local r=np.mean(a,1)
  assert(close(r,0.5),"mean 24 scalar")
end
do -- mean 25: int8 [2] axis=0
  local a=np.reshape(np.arange(2,np.int8),{2})
  local r=np.mean(a,1)
  assert(close(r,0.5),"mean 25 scalar")
end
do -- mean 26: float16 [4, 2, 2] axis=0
  local a=np.reshape(np.arange(16,np.float16),{4,2,2})
  local r=np.mean(a,1)
  assert(r.dtype=="float16","mean 26 dtype "..r.dtype)
  assert(close(r:tolist(),{{6.0,7.0},{8.0,9.0}}),"mean 26 values")
end
do -- mean 27: uint16 [1, 4, 4] axis=None
  local a=np.reshape(np.arange(16,np.uint16),{1,4,4})
  local r=np.mean(a)
  assert(close(r,7.5),"mean 27 scalar")
end
do -- mean 28: int64 [0] axis=0
  local a=np.reshape(np.arange(0,np.int64),{0})
  local r=np.mean(a,1)
  assert(close(r,0/0),"mean 28 scalar")
end
do -- mean 29: float16 [2] axis=0
  local a=np.reshape(np.arange(2,np.float16),{2})
  local r=np.mean(a,1)
  assert(close(r,0.5),"mean 29 scalar")
end
do -- mean 30: uint8 [4, 3, 0] axis=None
  local a=np.reshape(np.arange(0,np.uint8),{4,3,0})
  local r=np.mean(a)
  assert(close(r,0/0),"mean 30 scalar")
end
do -- mean 31: float16 [2] axis=None
  local a=np.reshape(np.arange(2,np.float16),{2})
  local r=np.mean(a)
  assert(close(r,0.5),"mean 31 scalar")
end
do -- mean 32: int32 [1, 2, 0, 1] axis=3
  local a=np.reshape(np.arange(0,np.int32),{1,2,0,1})
  local r=np.mean(a,4)
  assert(r.dtype=="float64","mean 32 dtype "..r.dtype)
  assert(close(r:tolist(),{{{},{}}}),"mean 32 values")
end
do -- mean 33: int8 [2, 2, 1, 1] axis=None
  local a=np.reshape(np.arange(4,np.int8),{2,2,1,1})
  local r=np.mean(a)
  assert(close(r,1.5),"mean 33 scalar")
end
do -- mean 34: uint16 [2, 4] axis=0
  local a=np.reshape(np.arange(8,np.uint16),{2,4})
  local r=np.mean(a,1)
  assert(r.dtype=="float64","mean 34 dtype "..r.dtype)
  assert(close(r:tolist(),{2.0,3.0,4.0,5.0}),"mean 34 values")
end
do -- mean 35: uint32 [4, 0, 3] axis=2
  local a=np.reshape(np.arange(0,np.uint32),{4,0,3})
  local r=np.mean(a,3)
  assert(r.dtype=="float64","mean 35 dtype "..r.dtype)
  assert(close(r:tolist(),{{},{},{},{}}),"mean 35 values")
end
do -- mean 36: uint8 [1, 0] axis=None
  local a=np.reshape(np.arange(0,np.uint8),{1,0})
  local r=np.mean(a)
  assert(close(r,0/0),"mean 36 scalar")
end
do -- mean 37: int64 [1, 4, 1] axis=0
  local a=np.reshape(np.arange(4,np.int64),{1,4,1})
  local r=np.mean(a,1)
  assert(r.dtype=="float64","mean 37 dtype "..r.dtype)
  assert(close(r:tolist(),{{0.0},{1.0},{2.0},{3.0}}),"mean 37 values")
end
do -- mean 38: int16 [4] axis=None
  local a=np.reshape(np.arange(4,np.int16),{4})
  local r=np.mean(a)
  assert(close(r,1.5),"mean 38 scalar")
end
do -- mean 39: uint64 [0, 2, 4] axis=None
  local a=np.reshape(np.arange(0,np.uint64),{0,2,4})
  local r=np.mean(a)
  assert(close(r,0/0),"mean 39 scalar")
end
do -- mean 40: uint64 [3, 2, 1] axis=None
  local a=np.reshape(np.arange(6,np.uint64),{3,2,1})
  local r=np.mean(a)
  assert(close(r,2.5),"mean 40 scalar")
end
do -- mean 41: uint64 [4, 4] axis=None
  local a=np.reshape(np.arange(16,np.uint64),{4,4})
  local r=np.mean(a)
  assert(close(r,7.5),"mean 41 scalar")
end
do -- mean 42: uint64 [1, 3] axis=None
  local a=np.reshape(np.arange(3,np.uint64),{1,3})
  local r=np.mean(a)
  assert(close(r,1.0),"mean 42 scalar")
end
do -- mean 43: int8 [0, 0] axis=1
  local a=np.reshape(np.arange(0,np.int8),{0,0})
  local r=np.mean(a,2)
  assert(r.dtype=="float64","mean 43 dtype "..r.dtype)
  assert(close(r:tolist(),{}),"mean 43 values")
end
do -- mean 44: float32 [2, 3, 2, 2] axis=0
  local a=np.reshape(np.arange(24,np.float32),{2,3,2,2})
  local r=np.mean(a,1)
  assert(r.dtype=="float32","mean 44 dtype "..r.dtype)
  assert(close(r:tolist(),{{{6.0,7.0},{8.0,9.0}},{{10.0,11.0},{12.0,13.0}},{{14.0,15.0},{16.0,17.0}}}),"mean 44 values")
end
do -- mean 45: uint16 [4, 2, 1] axis=None
  local a=np.reshape(np.arange(8,np.uint16),{4,2,1})
  local r=np.mean(a)
  assert(close(r,3.5),"mean 45 scalar")
end
do -- mean 46: uint8 [3, 3, 0] axis=0
  local a=np.reshape(np.arange(0,np.uint8),{3,3,0})
  local r=np.mean(a,1)
  assert(r.dtype=="float64","mean 46 dtype "..r.dtype)
  assert(close(r:tolist(),{{},{},{}}),"mean 46 values")
end
do -- mean 47: uint64 [2, 3] axis=None
  local a=np.reshape(np.arange(6,np.uint64),{2,3})
  local r=np.mean(a)
  assert(close(r,2.5),"mean 47 scalar")
end
do -- mean 48: float64 [2, 1] axis=0
  local a=np.reshape(np.arange(2,np.float64),{2,1})
  local r=np.mean(a,1)
  assert(r.dtype=="float64","mean 48 dtype "..r.dtype)
  assert(close(r:tolist(),{0.5}),"mean 48 values")
end
do -- mean 49: int32 [3, 2, 2] axis=None
  local a=np.reshape(np.arange(12,np.int32),{3,2,2})
  local r=np.mean(a)
  assert(close(r,5.5),"mean 49 scalar")
end
do -- mean 50: int16 [4, 3, 0] axis=2
  local a=np.reshape(np.arange(0,np.int16),{4,3,0})
  local r=np.mean(a,3)
  assert(r.dtype=="float64","mean 50 dtype "..r.dtype)
  assert(close(r:tolist(),{{0/0,0/0,0/0},{0/0,0/0,0/0},{0/0,0/0,0/0},{0/0,0/0,0/0}}),"mean 50 values")
end
do -- mean 51: int16 [2] axis=0
  local a=np.reshape(np.arange(2,np.int16),{2})
  local r=np.mean(a,1)
  assert(close(r,0.5),"mean 51 scalar")
end
do -- mean 52: float64 [2] axis=0
  local a=np.reshape(np.arange(2,np.float64),{2})
  local r=np.mean(a,1)
  assert(close(r,0.5),"mean 52 scalar")
end
do -- mean 53: uint32 [0, 4, 4] axis=None
  local a=np.reshape(np.arange(0,np.uint32),{0,4,4})
  local r=np.mean(a)
  assert(close(r,0/0),"mean 53 scalar")
end
do -- mean 54: float16 [1, 0] axis=1
  local a=np.reshape(np.arange(0,np.float16),{1,0})
  local r=np.mean(a,2)
  assert(r.dtype=="float16","mean 54 dtype "..r.dtype)
  assert(close(r:tolist(),{0/0}),"mean 54 values")
end
do -- mean 55: int8 [4, 0, 4] axis=2
  local a=np.reshape(np.arange(0,np.int8),{4,0,4})
  local r=np.mean(a,3)
  assert(r.dtype=="float64","mean 55 dtype "..r.dtype)
  assert(close(r:tolist(),{{},{},{},{}}),"mean 55 values")
end
do -- mean 56: int32 [2, 3] axis=1
  local a=np.reshape(np.arange(6,np.int32),{2,3})
  local r=np.mean(a,2)
  assert(r.dtype=="float64","mean 56 dtype "..r.dtype)
  assert(close(r:tolist(),{1.0,4.0}),"mean 56 values")
end
do -- mean 57: int8 [1] axis=0
  local a=np.reshape(np.arange(1,np.int8),{1})
  local r=np.mean(a,1)
  assert(close(r,0.0),"mean 57 scalar")
end
do -- mean 58: int16 [4, 1] axis=None
  local a=np.reshape(np.arange(4,np.int16),{4,1})
  local r=np.mean(a)
  assert(close(r,1.5),"mean 58 scalar")
end
do -- mean 59: float32 [4, 3] axis=0
  local a=np.reshape(np.arange(12,np.float32),{4,3})
  local r=np.mean(a,1)
  assert(r.dtype=="float32","mean 59 dtype "..r.dtype)
  assert(close(r:tolist(),{4.5,5.5,6.5}),"mean 59 values")
end
do -- mean 60: int8 [2, 0] axis=0
  local a=np.reshape(np.arange(0,np.int8),{2,0})
  local r=np.mean(a,1)
  assert(r.dtype=="float64","mean 60 dtype "..r.dtype)
  assert(close(r:tolist(),{}),"mean 60 values")
end
do -- mean 61: float64 [0, 3, 4] axis=0
  local a=np.reshape(np.arange(0,np.float64),{0,3,4})
  local r=np.mean(a,1)
  assert(r.dtype=="float64","mean 61 dtype "..r.dtype)
  assert(close(r:tolist(),{{0/0,0/0,0/0,0/0},{0/0,0/0,0/0,0/0},{0/0,0/0,0/0,0/0}}),"mean 61 values")
end
do -- mean 62: int16 [3, 3] axis=None
  local a=np.reshape(np.arange(9,np.int16),{3,3})
  local r=np.mean(a)
  assert(close(r,4.0),"mean 62 scalar")
end
do -- mean 63: float32 [0, 3, 2, 4] axis=1
  local a=np.reshape(np.arange(0,np.float32),{0,3,2,4})
  local r=np.mean(a,2)
  assert(r.dtype=="float32","mean 63 dtype "..r.dtype)
  assert(close(r:tolist(),{}),"mean 63 values")
end
do -- mean 64: int16 [0, 4, 1] axis=0
  local a=np.reshape(np.arange(0,np.int16),{0,4,1})
  local r=np.mean(a,1)
  assert(r.dtype=="float64","mean 64 dtype "..r.dtype)
  assert(close(r:tolist(),{{0/0},{0/0},{0/0},{0/0}}),"mean 64 values")
end
do -- mean 65: uint8 [4, 1] axis=1
  local a=np.reshape(np.arange(4,np.uint8),{4,1})
  local r=np.mean(a,2)
  assert(r.dtype=="float64","mean 65 dtype "..r.dtype)
  assert(close(r:tolist(),{0.0,1.0,2.0,3.0}),"mean 65 values")
end
do -- mean 66: int32 [1, 0, 0] axis=None
  local a=np.reshape(np.arange(0,np.int32),{1,0,0})
  local r=np.mean(a)
  assert(close(r,0/0),"mean 66 scalar")
end
do -- mean 67: float64 [2] axis=0
  local a=np.reshape(np.arange(2,np.float64),{2})
  local r=np.mean(a,1)
  assert(close(r,0.5),"mean 67 scalar")
end
do -- mean 68: int8 [0, 2] axis=None
  local a=np.reshape(np.arange(0,np.int8),{0,2})
  local r=np.mean(a)
  assert(close(r,0/0),"mean 68 scalar")
end
do -- mean 69: uint64 [0, 3] axis=0
  local a=np.reshape(np.arange(0,np.uint64),{0,3})
  local r=np.mean(a,1)
  assert(r.dtype=="float64","mean 69 dtype "..r.dtype)
  assert(close(r:tolist(),{0/0,0/0,0/0}),"mean 69 values")
end
do -- mean 70: uint8 [3] axis=None
  local a=np.reshape(np.arange(3,np.uint8),{3})
  local r=np.mean(a)
  assert(close(r,1.0),"mean 70 scalar")
end
do -- mean 71: uint8 [1, 4, 4] axis=None
  local a=np.reshape(np.arange(16,np.uint8),{1,4,4})
  local r=np.mean(a)
  assert(close(r,7.5),"mean 71 scalar")
end
do -- mean 72: uint32 [2, 2] axis=None
  local a=np.reshape(np.arange(4,np.uint32),{2,2})
  local r=np.mean(a)
  assert(close(r,1.5),"mean 72 scalar")
end
do -- mean 73: int16 [3, 4] axis=1
  local a=np.reshape(np.arange(12,np.int16),{3,4})
  local r=np.mean(a,2)
  assert(r.dtype=="float64","mean 73 dtype "..r.dtype)
  assert(close(r:tolist(),{1.5,5.5,9.5}),"mean 73 values")
end
do -- mean 74: uint32 [1, 2, 3] axis=0
  local a=np.reshape(np.arange(6,np.uint32),{1,2,3})
  local r=np.mean(a,1)
  assert(r.dtype=="float64","mean 74 dtype "..r.dtype)
  assert(close(r:tolist(),{{0.0,1.0,2.0},{3.0,4.0,5.0}}),"mean 74 values")
end
do -- mean 75: int16 [3, 0, 3, 2] axis=2
  local a=np.reshape(np.arange(0,np.int16),{3,0,3,2})
  local r=np.mean(a,3)
  assert(r.dtype=="float64","mean 75 dtype "..r.dtype)
  assert(close(r:tolist(),{{},{},{}}),"mean 75 values")
end
do -- mean 76: bool [3, 2, 1] axis=2
  local a=np.reshape(np.arange(6,np.bool),{3,2,1})
  local r=np.mean(a,3)
  assert(r.dtype=="float64","mean 76 dtype "..r.dtype)
  assert(close(r:tolist(),{{0.0,1.0},{1.0,1.0},{1.0,1.0}}),"mean 76 values")
end
do -- mean 77: int32 [0, 2] axis=0
  local a=np.reshape(np.arange(0,np.int32),{0,2})
  local r=np.mean(a,1)
  assert(r.dtype=="float64","mean 77 dtype "..r.dtype)
  assert(close(r:tolist(),{0/0,0/0}),"mean 77 values")
end
do -- mean 78: uint64 [3, 4] axis=0
  local a=np.reshape(np.arange(12,np.uint64),{3,4})
  local r=np.mean(a,1)
  assert(r.dtype=="float64","mean 78 dtype "..r.dtype)
  assert(close(r:tolist(),{4.0,5.0,6.0,7.0}),"mean 78 values")
end
do -- mean 79: uint64 [1, 0, 4] axis=2
  local a=np.reshape(np.arange(0,np.uint64),{1,0,4})
  local r=np.mean(a,3)
  assert(r.dtype=="float64","mean 79 dtype "..r.dtype)
  assert(close(r:tolist(),{{}}),"mean 79 values")
end
do -- mean 80: int32 [2] axis=0
  local a=np.reshape(np.arange(2,np.int32),{2})
  local r=np.mean(a,1)
  assert(close(r,0.5),"mean 80 scalar")
end
do -- mean 81: bool [4] axis=0
  local a=np.reshape(np.arange(4,np.bool),{4})
  local r=np.mean(a,1)
  assert(close(r,0.75),"mean 81 scalar")
end
do -- mean 82: uint16 [0] axis=0
  local a=np.reshape(np.arange(0,np.uint16),{0})
  local r=np.mean(a,1)
  assert(close(r,0/0),"mean 82 scalar")
end
do -- mean 83: uint64 [2, 2, 0] axis=None
  local a=np.reshape(np.arange(0,np.uint64),{2,2,0})
  local r=np.mean(a)
  assert(close(r,0/0),"mean 83 scalar")
end
do -- mean 84: uint16 [0] axis=0
  local a=np.reshape(np.arange(0,np.uint16),{0})
  local r=np.mean(a,1)
  assert(close(r,0/0),"mean 84 scalar")
end
do -- mean 85: bool [0, 3, 2, 0] axis=0
  local a=np.reshape(np.arange(0,np.bool),{0,3,2,0})
  local r=np.mean(a,1)
  assert(r.dtype=="float64","mean 85 dtype "..r.dtype)
  assert(close(r:tolist(),{{{},{}},{{},{}},{{},{}}}),"mean 85 values")
end
do -- mean 86: uint16 [0, 4, 3] axis=None
  local a=np.reshape(np.arange(0,np.uint16),{0,4,3})
  local r=np.mean(a)
  assert(close(r,0/0),"mean 86 scalar")
end
do -- mean 87: float16 [3, 3, 0, 1] axis=3
  local a=np.reshape(np.arange(0,np.float16),{3,3,0,1})
  local r=np.mean(a,4)
  assert(r.dtype=="float16","mean 87 dtype "..r.dtype)
  assert(close(r:tolist(),{{{},{},{}},{{},{},{}},{{},{},{}}}),"mean 87 values")
end
do -- mean 88: uint8 [2, 3, 2] axis=None
  local a=np.reshape(np.arange(12,np.uint8),{2,3,2})
  local r=np.mean(a)
  assert(close(r,5.5),"mean 88 scalar")
end
do -- mean 89: uint32 [3, 4] axis=None
  local a=np.reshape(np.arange(12,np.uint32),{3,4})
  local r=np.mean(a)
  assert(close(r,5.5),"mean 89 scalar")
end
do -- mean 90: int8 [1] axis=0
  local a=np.reshape(np.arange(1,np.int8),{1})
  local r=np.mean(a,1)
  assert(close(r,0.0),"mean 90 scalar")
end
do -- mean 91: float16 [1, 2] axis=1
  local a=np.reshape(np.arange(2,np.float16),{1,2})
  local r=np.mean(a,2)
  assert(r.dtype=="float16","mean 91 dtype "..r.dtype)
  assert(close(r:tolist(),{0.5}),"mean 91 values")
end
do -- mean 92: int32 [4, 3, 0] axis=2
  local a=np.reshape(np.arange(0,np.int32),{4,3,0})
  local r=np.mean(a,3)
  assert(r.dtype=="float64","mean 92 dtype "..r.dtype)
  assert(close(r:tolist(),{{0/0,0/0,0/0},{0/0,0/0,0/0},{0/0,0/0,0/0},{0/0,0/0,0/0}}),"mean 92 values")
end
do -- mean 93: int16 [2, 1] axis=None
  local a=np.reshape(np.arange(2,np.int16),{2,1})
  local r=np.mean(a)
  assert(close(r,0.5),"mean 93 scalar")
end
do -- mean 94: bool [1, 0, 1] axis=None
  local a=np.reshape(np.arange(0,np.bool),{1,0,1})
  local r=np.mean(a)
  assert(close(r,0/0),"mean 94 scalar")
end
do -- mean 95: uint16 [0, 3, 1, 0] axis=2
  local a=np.reshape(np.arange(0,np.uint16),{0,3,1,0})
  local r=np.mean(a,3)
  assert(r.dtype=="float64","mean 95 dtype "..r.dtype)
  assert(close(r:tolist(),{}),"mean 95 values")
end
do -- mean 96: int8 [1, 0, 4] axis=2
  local a=np.reshape(np.arange(0,np.int8),{1,0,4})
  local r=np.mean(a,3)
  assert(r.dtype=="float64","mean 96 dtype "..r.dtype)
  assert(close(r:tolist(),{{}}),"mean 96 values")
end
do -- mean 97: float32 [1, 0, 3, 2] axis=None
  local a=np.reshape(np.arange(0,np.float32),{1,0,3,2})
  local r=np.mean(a)
  assert(close(r,0/0),"mean 97 scalar")
end
do -- mean 98: uint16 [2] axis=0
  local a=np.reshape(np.arange(2,np.uint16),{2})
  local r=np.mean(a,1)
  assert(close(r,0.5),"mean 98 scalar")
end
do -- mean 99: float64 [4, 1] axis=None
  local a=np.reshape(np.arange(4,np.float64),{4,1})
  local r=np.mean(a)
  assert(close(r,1.5),"mean 99 scalar")
end
do -- mean 100: int16 [2, 0, 4, 2] axis=3
  local a=np.reshape(np.arange(0,np.int16),{2,0,4,2})
  local r=np.mean(a,4)
  assert(r.dtype=="float64","mean 100 dtype "..r.dtype)
  assert(close(r:tolist(),{{},{}}),"mean 100 values")
end
do -- mean 101: uint16 [2, 2, 3] axis=None
  local a=np.reshape(np.arange(12,np.uint16),{2,2,3})
  local r=np.mean(a)
  assert(close(r,5.5),"mean 101 scalar")
end
do -- mean 102: float16 [4, 2, 1] axis=None
  local a=np.reshape(np.arange(8,np.float16),{4,2,1})
  local r=np.mean(a)
  assert(close(r,3.5),"mean 102 scalar")
end
do -- mean 103: int8 [4, 0, 0, 2] axis=None
  local a=np.reshape(np.arange(0,np.int8),{4,0,0,2})
  local r=np.mean(a)
  assert(close(r,0/0),"mean 103 scalar")
end
do -- mean 104: int32 [0] axis=None
  local a=np.reshape(np.arange(0,np.int32),{0})
  local r=np.mean(a)
  assert(close(r,0/0),"mean 104 scalar")
end
do -- mean 105: int8 [0, 1, 3] axis=None
  local a=np.reshape(np.arange(0,np.int8),{0,1,3})
  local r=np.mean(a)
  assert(close(r,0/0),"mean 105 scalar")
end
do -- mean 106: bool [2, 1, 0, 3] axis=0
  local a=np.reshape(np.arange(0,np.bool),{2,1,0,3})
  local r=np.mean(a,1)
  assert(r.dtype=="float64","mean 106 dtype "..r.dtype)
  assert(close(r:tolist(),{{}}),"mean 106 values")
end
do -- mean 107: float32 [1, 3] axis=0
  local a=np.reshape(np.arange(3,np.float32),{1,3})
  local r=np.mean(a,1)
  assert(r.dtype=="float32","mean 107 dtype "..r.dtype)
  assert(close(r:tolist(),{0.0,1.0,2.0}),"mean 107 values")
end
do -- mean 108: uint64 [4, 4, 1] axis=0
  local a=np.reshape(np.arange(16,np.uint64),{4,4,1})
  local r=np.mean(a,1)
  assert(r.dtype=="float64","mean 108 dtype "..r.dtype)
  assert(close(r:tolist(),{{6.0},{7.0},{8.0},{9.0}}),"mean 108 values")
end
do -- mean 109: float64 [4] axis=0
  local a=np.reshape(np.arange(4,np.float64),{4})
  local r=np.mean(a,1)
  assert(close(r,1.5),"mean 109 scalar")
end
do -- mean 110: bool [0, 4, 1] axis=None
  local a=np.reshape(np.arange(0,np.bool),{0,4,1})
  local r=np.mean(a)
  assert(close(r,0/0),"mean 110 scalar")
end
do -- mean 111: float16 [3, 2, 4, 2] axis=None
  local a=np.reshape(np.arange(48,np.float16),{3,2,4,2})
  local r=np.mean(a)
  assert(close(r,23.5),"mean 111 scalar")
end
do -- mean 112: int64 [3, 1] axis=1
  local a=np.reshape(np.arange(3,np.int64),{3,1})
  local r=np.mean(a,2)
  assert(r.dtype=="float64","mean 112 dtype "..r.dtype)
  assert(close(r:tolist(),{0.0,1.0,2.0}),"mean 112 values")
end
do -- mean 113: int64 [3, 1] axis=None
  local a=np.reshape(np.arange(3,np.int64),{3,1})
  local r=np.mean(a)
  assert(close(r,1.0),"mean 113 scalar")
end
do -- mean 114: float64 [3, 4, 2, 1] axis=None
  local a=np.reshape(np.arange(24,np.float64),{3,4,2,1})
  local r=np.mean(a)
  assert(close(r,11.5),"mean 114 scalar")
end
do -- mean 115: uint64 [4] axis=None
  local a=np.reshape(np.arange(4,np.uint64),{4})
  local r=np.mean(a)
  assert(close(r,1.5),"mean 115 scalar")
end
do -- mean 116: uint16 [2, 1] axis=1
  local a=np.reshape(np.arange(2,np.uint16),{2,1})
  local r=np.mean(a,2)
  assert(r.dtype=="float64","mean 116 dtype "..r.dtype)
  assert(close(r:tolist(),{0.0,1.0}),"mean 116 values")
end
do -- mean 117: float16 [1, 4, 0] axis=2
  local a=np.reshape(np.arange(0,np.float16),{1,4,0})
  local r=np.mean(a,3)
  assert(r.dtype=="float16","mean 117 dtype "..r.dtype)
  assert(close(r:tolist(),{{0/0,0/0,0/0,0/0}}),"mean 117 values")
end
do -- mean 118: int32 [1, 4, 2, 0] axis=0
  local a=np.reshape(np.arange(0,np.int32),{1,4,2,0})
  local r=np.mean(a,1)
  assert(r.dtype=="float64","mean 118 dtype "..r.dtype)
  assert(close(r:tolist(),{{{},{}},{{},{}},{{},{}},{{},{}}}),"mean 118 values")
end
do -- mean 119: float32 [3, 3, 2, 4] axis=None
  local a=np.reshape(np.arange(72,np.float32),{3,3,2,4})
  local r=np.mean(a)
  assert(close(r,35.5),"mean 119 scalar")
end
do -- mean 120: uint16 [3, 2, 0] axis=1
  local a=np.reshape(np.arange(0,np.uint16),{3,2,0})
  local r=np.mean(a,2)
  assert(r.dtype=="float64","mean 120 dtype "..r.dtype)
  assert(close(r:tolist(),{{},{},{}}),"mean 120 values")
end
do -- mean 121: int8 [1, 3] axis=0
  local a=np.reshape(np.arange(3,np.int8),{1,3})
  local r=np.mean(a,1)
  assert(r.dtype=="float64","mean 121 dtype "..r.dtype)
  assert(close(r:tolist(),{0.0,1.0,2.0}),"mean 121 values")
end
do -- mean 122: bool [0, 2, 2, 4] axis=3
  local a=np.reshape(np.arange(0,np.bool),{0,2,2,4})
  local r=np.mean(a,4)
  assert(r.dtype=="float64","mean 122 dtype "..r.dtype)
  assert(close(r:tolist(),{}),"mean 122 values")
end
do -- mean 123: bool [4] axis=None
  local a=np.reshape(np.arange(4,np.bool),{4})
  local r=np.mean(a)
  assert(close(r,0.75),"mean 123 scalar")
end
do -- mean 124: float16 [2, 4, 2, 1] axis=None
  local a=np.reshape(np.arange(16,np.float16),{2,4,2,1})
  local r=np.mean(a)
  assert(close(r,7.5),"mean 124 scalar")
end
do -- mean 125: float16 [4, 1] axis=1
  local a=np.reshape(np.arange(4,np.float16),{4,1})
  local r=np.mean(a,2)
  assert(r.dtype=="float16","mean 125 dtype "..r.dtype)
  assert(close(r:tolist(),{0.0,1.0,2.0,3.0}),"mean 125 values")
end
do -- mean 126: int32 [0, 4] axis=0
  local a=np.reshape(np.arange(0,np.int32),{0,4})
  local r=np.mean(a,1)
  assert(r.dtype=="float64","mean 126 dtype "..r.dtype)
  assert(close(r:tolist(),{0/0,0/0,0/0,0/0}),"mean 126 values")
end
do -- mean 127: int32 [3, 2] axis=None
  local a=np.reshape(np.arange(6,np.int32),{3,2})
  local r=np.mean(a)
  assert(close(r,2.5),"mean 127 scalar")
end
do -- mean 128: uint8 [1, 4, 3] axis=None
  local a=np.reshape(np.arange(12,np.uint8),{1,4,3})
  local r=np.mean(a)
  assert(close(r,5.5),"mean 128 scalar")
end
do -- mean 129: uint32 [2, 0, 1] axis=None
  local a=np.reshape(np.arange(0,np.uint32),{2,0,1})
  local r=np.mean(a)
  assert(close(r,0/0),"mean 129 scalar")
end
do -- mean 130: int16 [3] axis=0
  local a=np.reshape(np.arange(3,np.int16),{3})
  local r=np.mean(a,1)
  assert(close(r,1.0),"mean 130 scalar")
end
do -- mean 131: int16 [0, 3, 3] axis=1
  local a=np.reshape(np.arange(0,np.int16),{0,3,3})
  local r=np.mean(a,2)
  assert(r.dtype=="float64","mean 131 dtype "..r.dtype)
  assert(close(r:tolist(),{}),"mean 131 values")
end
do -- mean 132: int32 [3, 0, 0, 4] axis=1
  local a=np.reshape(np.arange(0,np.int32),{3,0,0,4})
  local r=np.mean(a,2)
  assert(r.dtype=="float64","mean 132 dtype "..r.dtype)
  assert(close(r:tolist(),{{},{},{}}),"mean 132 values")
end
do -- mean 133: bool [2, 2, 2] axis=None
  local a=np.reshape(np.arange(8,np.bool),{2,2,2})
  local r=np.mean(a)
  assert(close(r,0.875),"mean 133 scalar")
end
do -- mean 134: float64 [4, 3] axis=None
  local a=np.reshape(np.arange(12,np.float64),{4,3})
  local r=np.mean(a)
  assert(close(r,5.5),"mean 134 scalar")
end
do -- mean 135: float64 [2, 3] axis=1
  local a=np.reshape(np.arange(6,np.float64),{2,3})
  local r=np.mean(a,2)
  assert(r.dtype=="float64","mean 135 dtype "..r.dtype)
  assert(close(r:tolist(),{1.0,4.0}),"mean 135 values")
end
do -- mean 136: bool [3, 4, 0, 1] axis=0
  local a=np.reshape(np.arange(0,np.bool),{3,4,0,1})
  local r=np.mean(a,1)
  assert(r.dtype=="float64","mean 136 dtype "..r.dtype)
  assert(close(r:tolist(),{{},{},{},{}}),"mean 136 values")
end
do -- mean 137: uint32 [0] axis=0
  local a=np.reshape(np.arange(0,np.uint32),{0})
  local r=np.mean(a,1)
  assert(close(r,0/0),"mean 137 scalar")
end
do -- mean 138: float64 [2] axis=None
  local a=np.reshape(np.arange(2,np.float64),{2})
  local r=np.mean(a)
  assert(close(r,0.5),"mean 138 scalar")
end
do -- mean 139: uint64 [0, 0, 0, 1] axis=0
  local a=np.reshape(np.arange(0,np.uint64),{0,0,0,1})
  local r=np.mean(a,1)
  assert(r.dtype=="float64","mean 139 dtype "..r.dtype)
  assert(close(r:tolist(),{}),"mean 139 values")
end
do local a=np.reshape(np.arange(20000,np.float32),{2,10000}); local r=a:mean(2);
  assert(r.dtype=="float32","mean float32 dtype");
  assert(close(r:tolist(),{4999.5,14999.5009765625}),"mean float32 pairwise") end
print('mean differential: 141 cases ok')
