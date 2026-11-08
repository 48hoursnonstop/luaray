local np=require("luaray_core")
local function close(a,b)
  if a~=a and b~=b then return true end
  if a==b then return true end
  return math.abs(a-b)<=math.max(1e-6,math.abs(b)*2e-7)
end
-- Generated against development NumPy 2.3.5.
do -- both-buffered-10000
  local a=np.arange(10000,np.int64)
  local b=np.arange(10000,np.uint64)
  local r=a + b
  assert(r.dtype=="float64","both-buffered-10000 dtype "..r.dtype)
  assert(r.size==10000,"both-buffered-10000 size")
  assert(close(r:get(1),0.0),"both-buffered-10000 probe (0,)")
  assert(close(r:get(8192),16382.0),"both-buffered-10000 probe (8191,)")
  assert(close(r:get(8193),16384.0),"both-buffered-10000 probe (8192,)")
  assert(close(r:get(10000),19998.0),"both-buffered-10000 probe (9999,)")
end
do -- negative-stride-buffer
  local a=np.arange(10000,np.int32):get(np.slice(nil,nil,-1))
  local b=np.arange(10000,np.float64)
  local r=a + b
  assert(r.dtype=="float64","negative-stride-buffer dtype "..r.dtype)
  assert(r.size==10000,"negative-stride-buffer size")
  assert(close(r:get(1),9999.0),"negative-stride-buffer probe (0,)")
  assert(close(r:get(8192),9999.0),"negative-stride-buffer probe (8191,)")
  assert(close(r:get(8193),9999.0),"negative-stride-buffer probe (8192,)")
  assert(close(r:get(10000),9999.0),"negative-stride-buffer probe (9999,)")
end
do -- transposed-transfer
  local a=np.reshape(np.arange(20000,np.int16),{10000,2}).T
  local b=np.reshape(np.arange(20000,np.float32),{2,10000})
  local r=a + b
  assert(r.dtype=="float32","transposed-transfer dtype "..r.dtype)
  assert(r.size==20000,"transposed-transfer size")
  assert(close(r:get(1,1),0.0),"transposed-transfer probe (0, 0)")
  assert(close(r:get(1,8192),24573.0),"transposed-transfer probe (0, 8191)")
  assert(close(r:get(1,8193),24576.0),"transposed-transfer probe (0, 8192)")
  assert(close(r:get(2,10000),39998.0),"transposed-transfer probe (1, 9999)")
end
do -- broadcast-zero-stride
  local a=np.array({{3},{7}},np.int16)
  local b=np.reshape(np.arange(20000,np.float32),{2,10000})
  local r=a * b
  assert(r.dtype=="float32","broadcast-zero-stride dtype "..r.dtype)
  assert(r.size==20000,"broadcast-zero-stride size")
  assert(close(r:get(1,1),0.0),"broadcast-zero-stride probe (0, 0)")
  assert(close(r:get(1,8193),24576.0),"broadcast-zero-stride probe (0, 8192)")
  assert(close(r:get(2,8192),127337.0),"broadcast-zero-stride probe (1, 8191)")
  assert(close(r:get(2,10000),139993.0),"broadcast-zero-stride probe (1, 9999)")
end
do -- 3d-broadcast-buffer
  local a=np.reshape(np.arange(18000,np.int32),{2,1,9000})
  local b=np.reshape(np.arange(27000,np.float64),{1,3,9000})
  local r=a + b
  assert(r.dtype=="float64","3d-broadcast-buffer dtype "..r.dtype)
  assert(r.size==54000,"3d-broadcast-buffer size")
  assert(close(r:get(1,1,1),0.0),"3d-broadcast-buffer probe (0, 0, 0)")
  assert(close(r:get(1,3,8192),34382.0),"3d-broadcast-buffer probe (0, 2, 8191)")
  assert(close(r:get(1,3,8193),34384.0),"3d-broadcast-buffer probe (0, 2, 8192)")
  assert(close(r:get(2,2,9000),35998.0),"3d-broadcast-buffer probe (1, 1, 8999)")
end
print('mixed ufunc buffered differential: 5 cases ok')
