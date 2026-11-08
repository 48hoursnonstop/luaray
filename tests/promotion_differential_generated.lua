local np=require('luaray_core')
local n=0
local function verify(got, dtype, expected)
  assert(got.dtype:gsub('^[<>|=]','') == dtype, tostring(got.dtype)..' != '..dtype)
  local result=got:tolist()
  local function walk(a,b)
    if type(b)=='table' then assert(type(a)=='table' and #a==#b); for i,v in ipairs(b) do walk(a[i],v) end
    else assert(a==b,tostring(a)..' != '..tostring(b)) end
  end
  walk(result,expected)
end
-- case 1: bool + S1, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({true,false},"bool"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=1})
  verify(r,"S5",{"True","False","x","y"})
  n=n+1
end
-- case 2: bool + S1, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({true,false},"bool"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=-1})
  verify(r,"S5",{"True","False","x","y"})
  n=n+1
end
-- case 3: bool + S1, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({true,false},"bool"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=1})
  verify(r,"S5",{{"True","False"},{"x","y"}})
  n=n+1
end
-- case 4: bool + S1, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({true,false},"bool"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=-1})
  verify(r,"S5",{{"True","False","x","y"}})
  n=n+1
end
-- case 5: bool + S1, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({true,false},"bool"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=1})
  verify(r,"S5",{{"True"},{"False"},{"x"},{"y"}})
  n=n+1
end
-- case 6: bool + S1, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({true,false},"bool"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=-1})
  verify(r,"S5",{{"True","x"},{"False","y"}})
  n=n+1
end
-- case 7: bool + S1, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({true,false},"bool"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=1})
  verify(r,"S5",{{"True","False"},{"x","y"}})
  n=n+1
end
-- case 8: bool + S1, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({true,false},"bool"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=-1})
  verify(r,"S5",{{"True","x"},{"False","y"}})
  n=n+1
end
-- case 9: bool + S1, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({true,false},"bool"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=1})
  verify(r,"S5",{{{"True","False"}},{{"x","y"}}})
  n=n+1
end
-- case 10: bool + S1, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({true,false},"bool"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=-1})
  verify(r,"S5",{{{"True","x"},{"False","y"}}})
  n=n+1
end
-- case 11: bool + S1, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({true,false},"bool"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=1})
  verify(r,"S5",{{{"True"},{"False"}},{{"x"},{"y"}}})
  n=n+1
end
-- case 12: bool + S1, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({true,false},"bool"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=-1})
  verify(r,"S5",{{{"True","x"}},{{"False","y"}}})
  n=n+1
end
-- case 13: bool + S1, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({true,false},"bool"),{2})},{axis=1})
  verify(r,"S5",{"x","y","True","False"})
  n=n+1
end
-- case 14: bool + S1, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({true,false},"bool"),{2})},{axis=-1})
  verify(r,"S5",{"x","y","True","False"})
  n=n+1
end
-- case 15: bool + S1, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({true,false},"bool"),{1,2})},{axis=1})
  verify(r,"S5",{{"x","y"},{"True","False"}})
  n=n+1
end
-- case 16: bool + S1, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({true,false},"bool"),{1,2})},{axis=-1})
  verify(r,"S5",{{"x","y","True","False"}})
  n=n+1
end
-- case 17: bool + S1, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({true,false},"bool"),{2,1})},{axis=1})
  verify(r,"S5",{{"x"},{"y"},{"True"},{"False"}})
  n=n+1
end
-- case 18: bool + S1, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({true,false},"bool"),{2,1})},{axis=-1})
  verify(r,"S5",{{"x","True"},{"y","False"}})
  n=n+1
end
-- case 19: bool + S1, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({true,false},"bool"),{2})},{axis=1})
  verify(r,"S5",{{"x","y"},{"True","False"}})
  n=n+1
end
-- case 20: bool + S1, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({true,false},"bool"),{2})},{axis=-1})
  verify(r,"S5",{{"x","True"},{"y","False"}})
  n=n+1
end
-- case 21: bool + S1, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({true,false},"bool"),{1,2})},{axis=1})
  verify(r,"S5",{{{"x","y"}},{{"True","False"}}})
  n=n+1
end
-- case 22: bool + S1, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({true,false},"bool"),{1,2})},{axis=-1})
  verify(r,"S5",{{{"x","True"},{"y","False"}}})
  n=n+1
end
-- case 23: bool + S1, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({true,false},"bool"),{2,1})},{axis=1})
  verify(r,"S5",{{{"x"},{"y"}},{{"True"},{"False"}}})
  n=n+1
end
-- case 24: bool + S1, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({true,false},"bool"),{2,1})},{axis=-1})
  verify(r,"S5",{{{"x","True"}},{{"y","False"}}})
  n=n+1
end
-- case 25: bool + S3, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({true,false},"bool"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=1})
  verify(r,"S5",{"True","False","x","yz"})
  n=n+1
end
-- case 26: bool + S3, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({true,false},"bool"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=-1})
  verify(r,"S5",{"True","False","x","yz"})
  n=n+1
end
-- case 27: bool + S3, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({true,false},"bool"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=1})
  verify(r,"S5",{{"True","False"},{"x","yz"}})
  n=n+1
end
-- case 28: bool + S3, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({true,false},"bool"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=-1})
  verify(r,"S5",{{"True","False","x","yz"}})
  n=n+1
end
-- case 29: bool + S3, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({true,false},"bool"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=1})
  verify(r,"S5",{{"True"},{"False"},{"x"},{"yz"}})
  n=n+1
end
-- case 30: bool + S3, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({true,false},"bool"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=-1})
  verify(r,"S5",{{"True","x"},{"False","yz"}})
  n=n+1
end
-- case 31: bool + S3, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({true,false},"bool"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=1})
  verify(r,"S5",{{"True","False"},{"x","yz"}})
  n=n+1
end
-- case 32: bool + S3, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({true,false},"bool"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=-1})
  verify(r,"S5",{{"True","x"},{"False","yz"}})
  n=n+1
end
-- case 33: bool + S3, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({true,false},"bool"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=1})
  verify(r,"S5",{{{"True","False"}},{{"x","yz"}}})
  n=n+1
end
-- case 34: bool + S3, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({true,false},"bool"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=-1})
  verify(r,"S5",{{{"True","x"},{"False","yz"}}})
  n=n+1
end
-- case 35: bool + S3, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({true,false},"bool"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=1})
  verify(r,"S5",{{{"True"},{"False"}},{{"x"},{"yz"}}})
  n=n+1
end
-- case 36: bool + S3, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({true,false},"bool"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=-1})
  verify(r,"S5",{{{"True","x"}},{{"False","yz"}}})
  n=n+1
end
-- case 37: bool + S3, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({true,false},"bool"),{2})},{axis=1})
  verify(r,"S5",{"x","yz","True","False"})
  n=n+1
end
-- case 38: bool + S3, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({true,false},"bool"),{2})},{axis=-1})
  verify(r,"S5",{"x","yz","True","False"})
  n=n+1
end
-- case 39: bool + S3, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({true,false},"bool"),{1,2})},{axis=1})
  verify(r,"S5",{{"x","yz"},{"True","False"}})
  n=n+1
end
-- case 40: bool + S3, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({true,false},"bool"),{1,2})},{axis=-1})
  verify(r,"S5",{{"x","yz","True","False"}})
  n=n+1
end
-- case 41: bool + S3, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({true,false},"bool"),{2,1})},{axis=1})
  verify(r,"S5",{{"x"},{"yz"},{"True"},{"False"}})
  n=n+1
end
-- case 42: bool + S3, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({true,false},"bool"),{2,1})},{axis=-1})
  verify(r,"S5",{{"x","True"},{"yz","False"}})
  n=n+1
end
-- case 43: bool + S3, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({true,false},"bool"),{2})},{axis=1})
  verify(r,"S5",{{"x","yz"},{"True","False"}})
  n=n+1
end
-- case 44: bool + S3, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({true,false},"bool"),{2})},{axis=-1})
  verify(r,"S5",{{"x","True"},{"yz","False"}})
  n=n+1
end
-- case 45: bool + S3, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({true,false},"bool"),{1,2})},{axis=1})
  verify(r,"S5",{{{"x","yz"}},{{"True","False"}}})
  n=n+1
end
-- case 46: bool + S3, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({true,false},"bool"),{1,2})},{axis=-1})
  verify(r,"S5",{{{"x","True"},{"yz","False"}}})
  n=n+1
end
-- case 47: bool + S3, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({true,false},"bool"),{2,1})},{axis=1})
  verify(r,"S5",{{{"x"},{"yz"}},{{"True"},{"False"}}})
  n=n+1
end
-- case 48: bool + S3, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({true,false},"bool"),{2,1})},{axis=-1})
  verify(r,"S5",{{{"x","True"}},{{"yz","False"}}})
  n=n+1
end
-- case 49: bool + S8, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({true,false},"bool"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=1})
  verify(r,"S8",{"True","False","x","yz"})
  n=n+1
end
-- case 50: bool + S8, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({true,false},"bool"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=-1})
  verify(r,"S8",{"True","False","x","yz"})
  n=n+1
end
-- case 51: bool + S8, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({true,false},"bool"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=1})
  verify(r,"S8",{{"True","False"},{"x","yz"}})
  n=n+1
end
-- case 52: bool + S8, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({true,false},"bool"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=-1})
  verify(r,"S8",{{"True","False","x","yz"}})
  n=n+1
end
-- case 53: bool + S8, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({true,false},"bool"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=1})
  verify(r,"S8",{{"True"},{"False"},{"x"},{"yz"}})
  n=n+1
end
-- case 54: bool + S8, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({true,false},"bool"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=-1})
  verify(r,"S8",{{"True","x"},{"False","yz"}})
  n=n+1
end
-- case 55: bool + S8, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({true,false},"bool"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=1})
  verify(r,"S8",{{"True","False"},{"x","yz"}})
  n=n+1
end
-- case 56: bool + S8, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({true,false},"bool"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=-1})
  verify(r,"S8",{{"True","x"},{"False","yz"}})
  n=n+1
end
-- case 57: bool + S8, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({true,false},"bool"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=1})
  verify(r,"S8",{{{"True","False"}},{{"x","yz"}}})
  n=n+1
end
-- case 58: bool + S8, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({true,false},"bool"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=-1})
  verify(r,"S8",{{{"True","x"},{"False","yz"}}})
  n=n+1
end
-- case 59: bool + S8, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({true,false},"bool"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=1})
  verify(r,"S8",{{{"True"},{"False"}},{{"x"},{"yz"}}})
  n=n+1
end
-- case 60: bool + S8, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({true,false},"bool"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=-1})
  verify(r,"S8",{{{"True","x"}},{{"False","yz"}}})
  n=n+1
end
-- case 61: bool + S8, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({true,false},"bool"),{2})},{axis=1})
  verify(r,"S8",{"x","yz","True","False"})
  n=n+1
end
-- case 62: bool + S8, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({true,false},"bool"),{2})},{axis=-1})
  verify(r,"S8",{"x","yz","True","False"})
  n=n+1
end
-- case 63: bool + S8, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({true,false},"bool"),{1,2})},{axis=1})
  verify(r,"S8",{{"x","yz"},{"True","False"}})
  n=n+1
end
-- case 64: bool + S8, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({true,false},"bool"),{1,2})},{axis=-1})
  verify(r,"S8",{{"x","yz","True","False"}})
  n=n+1
end
-- case 65: bool + S8, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({true,false},"bool"),{2,1})},{axis=1})
  verify(r,"S8",{{"x"},{"yz"},{"True"},{"False"}})
  n=n+1
end
-- case 66: bool + S8, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({true,false},"bool"),{2,1})},{axis=-1})
  verify(r,"S8",{{"x","True"},{"yz","False"}})
  n=n+1
end
-- case 67: bool + S8, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({true,false},"bool"),{2})},{axis=1})
  verify(r,"S8",{{"x","yz"},{"True","False"}})
  n=n+1
end
-- case 68: bool + S8, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({true,false},"bool"),{2})},{axis=-1})
  verify(r,"S8",{{"x","True"},{"yz","False"}})
  n=n+1
end
-- case 69: bool + S8, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({true,false},"bool"),{1,2})},{axis=1})
  verify(r,"S8",{{{"x","yz"}},{{"True","False"}}})
  n=n+1
end
-- case 70: bool + S8, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({true,false},"bool"),{1,2})},{axis=-1})
  verify(r,"S8",{{{"x","True"},{"yz","False"}}})
  n=n+1
end
-- case 71: bool + S8, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({true,false},"bool"),{2,1})},{axis=1})
  verify(r,"S8",{{{"x"},{"yz"}},{{"True"},{"False"}}})
  n=n+1
end
-- case 72: bool + S8, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({true,false},"bool"),{2,1})},{axis=-1})
  verify(r,"S8",{{{"x","True"}},{{"yz","False"}}})
  n=n+1
end
-- case 73: bool + U1, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({true,false},"bool"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=1})
  verify(r,"U5",{"True","False","x","é"})
  n=n+1
end
-- case 74: bool + U1, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({true,false},"bool"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=-1})
  verify(r,"U5",{"True","False","x","é"})
  n=n+1
end
-- case 75: bool + U1, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({true,false},"bool"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=1})
  verify(r,"U5",{{"True","False"},{"x","é"}})
  n=n+1
end
-- case 76: bool + U1, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({true,false},"bool"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=-1})
  verify(r,"U5",{{"True","False","x","é"}})
  n=n+1
end
-- case 77: bool + U1, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({true,false},"bool"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=1})
  verify(r,"U5",{{"True"},{"False"},{"x"},{"é"}})
  n=n+1
end
-- case 78: bool + U1, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({true,false},"bool"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=-1})
  verify(r,"U5",{{"True","x"},{"False","é"}})
  n=n+1
end
-- case 79: bool + U1, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({true,false},"bool"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=1})
  verify(r,"U5",{{"True","False"},{"x","é"}})
  n=n+1
end
-- case 80: bool + U1, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({true,false},"bool"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=-1})
  verify(r,"U5",{{"True","x"},{"False","é"}})
  n=n+1
end
-- case 81: bool + U1, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({true,false},"bool"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=1})
  verify(r,"U5",{{{"True","False"}},{{"x","é"}}})
  n=n+1
end
-- case 82: bool + U1, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({true,false},"bool"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=-1})
  verify(r,"U5",{{{"True","x"},{"False","é"}}})
  n=n+1
end
-- case 83: bool + U1, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({true,false},"bool"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=1})
  verify(r,"U5",{{{"True"},{"False"}},{{"x"},{"é"}}})
  n=n+1
end
-- case 84: bool + U1, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({true,false},"bool"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=-1})
  verify(r,"U5",{{{"True","x"}},{{"False","é"}}})
  n=n+1
end
-- case 85: bool + U1, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({true,false},"bool"),{2})},{axis=1})
  verify(r,"U5",{"x","é","True","False"})
  n=n+1
end
-- case 86: bool + U1, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({true,false},"bool"),{2})},{axis=-1})
  verify(r,"U5",{"x","é","True","False"})
  n=n+1
end
-- case 87: bool + U1, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({true,false},"bool"),{1,2})},{axis=1})
  verify(r,"U5",{{"x","é"},{"True","False"}})
  n=n+1
end
-- case 88: bool + U1, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({true,false},"bool"),{1,2})},{axis=-1})
  verify(r,"U5",{{"x","é","True","False"}})
  n=n+1
end
-- case 89: bool + U1, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({true,false},"bool"),{2,1})},{axis=1})
  verify(r,"U5",{{"x"},{"é"},{"True"},{"False"}})
  n=n+1
end
-- case 90: bool + U1, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({true,false},"bool"),{2,1})},{axis=-1})
  verify(r,"U5",{{"x","True"},{"é","False"}})
  n=n+1
end
-- case 91: bool + U1, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({true,false},"bool"),{2})},{axis=1})
  verify(r,"U5",{{"x","é"},{"True","False"}})
  n=n+1
end
-- case 92: bool + U1, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({true,false},"bool"),{2})},{axis=-1})
  verify(r,"U5",{{"x","True"},{"é","False"}})
  n=n+1
end
-- case 93: bool + U1, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({true,false},"bool"),{1,2})},{axis=1})
  verify(r,"U5",{{{"x","é"}},{{"True","False"}}})
  n=n+1
end
-- case 94: bool + U1, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({true,false},"bool"),{1,2})},{axis=-1})
  verify(r,"U5",{{{"x","True"},{"é","False"}}})
  n=n+1
end
-- case 95: bool + U1, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({true,false},"bool"),{2,1})},{axis=1})
  verify(r,"U5",{{{"x"},{"é"}},{{"True"},{"False"}}})
  n=n+1
end
-- case 96: bool + U1, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({true,false},"bool"),{2,1})},{axis=-1})
  verify(r,"U5",{{{"x","True"}},{{"é","False"}}})
  n=n+1
end
-- case 97: bool + U3, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({true,false},"bool"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=1})
  verify(r,"U5",{"True","False","x","é"})
  n=n+1
end
-- case 98: bool + U3, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({true,false},"bool"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=-1})
  verify(r,"U5",{"True","False","x","é"})
  n=n+1
end
-- case 99: bool + U3, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({true,false},"bool"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=1})
  verify(r,"U5",{{"True","False"},{"x","é"}})
  n=n+1
end
-- case 100: bool + U3, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({true,false},"bool"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=-1})
  verify(r,"U5",{{"True","False","x","é"}})
  n=n+1
end
-- case 101: bool + U3, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({true,false},"bool"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=1})
  verify(r,"U5",{{"True"},{"False"},{"x"},{"é"}})
  n=n+1
end
-- case 102: bool + U3, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({true,false},"bool"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=-1})
  verify(r,"U5",{{"True","x"},{"False","é"}})
  n=n+1
end
-- case 103: bool + U3, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({true,false},"bool"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=1})
  verify(r,"U5",{{"True","False"},{"x","é"}})
  n=n+1
end
-- case 104: bool + U3, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({true,false},"bool"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=-1})
  verify(r,"U5",{{"True","x"},{"False","é"}})
  n=n+1
end
-- case 105: bool + U3, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({true,false},"bool"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=1})
  verify(r,"U5",{{{"True","False"}},{{"x","é"}}})
  n=n+1
end
-- case 106: bool + U3, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({true,false},"bool"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=-1})
  verify(r,"U5",{{{"True","x"},{"False","é"}}})
  n=n+1
end
-- case 107: bool + U3, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({true,false},"bool"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=1})
  verify(r,"U5",{{{"True"},{"False"}},{{"x"},{"é"}}})
  n=n+1
end
-- case 108: bool + U3, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({true,false},"bool"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=-1})
  verify(r,"U5",{{{"True","x"}},{{"False","é"}}})
  n=n+1
end
-- case 109: bool + U3, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({true,false},"bool"),{2})},{axis=1})
  verify(r,"U5",{"x","é","True","False"})
  n=n+1
end
-- case 110: bool + U3, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({true,false},"bool"),{2})},{axis=-1})
  verify(r,"U5",{"x","é","True","False"})
  n=n+1
end
-- case 111: bool + U3, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({true,false},"bool"),{1,2})},{axis=1})
  verify(r,"U5",{{"x","é"},{"True","False"}})
  n=n+1
end
-- case 112: bool + U3, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({true,false},"bool"),{1,2})},{axis=-1})
  verify(r,"U5",{{"x","é","True","False"}})
  n=n+1
end
-- case 113: bool + U3, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({true,false},"bool"),{2,1})},{axis=1})
  verify(r,"U5",{{"x"},{"é"},{"True"},{"False"}})
  n=n+1
end
-- case 114: bool + U3, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({true,false},"bool"),{2,1})},{axis=-1})
  verify(r,"U5",{{"x","True"},{"é","False"}})
  n=n+1
end
-- case 115: bool + U3, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({true,false},"bool"),{2})},{axis=1})
  verify(r,"U5",{{"x","é"},{"True","False"}})
  n=n+1
end
-- case 116: bool + U3, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({true,false},"bool"),{2})},{axis=-1})
  verify(r,"U5",{{"x","True"},{"é","False"}})
  n=n+1
end
-- case 117: bool + U3, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({true,false},"bool"),{1,2})},{axis=1})
  verify(r,"U5",{{{"x","é"}},{{"True","False"}}})
  n=n+1
end
-- case 118: bool + U3, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({true,false},"bool"),{1,2})},{axis=-1})
  verify(r,"U5",{{{"x","True"},{"é","False"}}})
  n=n+1
end
-- case 119: bool + U3, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({true,false},"bool"),{2,1})},{axis=1})
  verify(r,"U5",{{{"x"},{"é"}},{{"True"},{"False"}}})
  n=n+1
end
-- case 120: bool + U3, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({true,false},"bool"),{2,1})},{axis=-1})
  verify(r,"U5",{{{"x","True"}},{{"é","False"}}})
  n=n+1
end
-- case 121: bool + U8, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({true,false},"bool"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=1})
  verify(r,"U8",{"True","False","x","é"})
  n=n+1
end
-- case 122: bool + U8, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({true,false},"bool"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=-1})
  verify(r,"U8",{"True","False","x","é"})
  n=n+1
end
-- case 123: bool + U8, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({true,false},"bool"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=1})
  verify(r,"U8",{{"True","False"},{"x","é"}})
  n=n+1
end
-- case 124: bool + U8, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({true,false},"bool"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=-1})
  verify(r,"U8",{{"True","False","x","é"}})
  n=n+1
end
-- case 125: bool + U8, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({true,false},"bool"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=1})
  verify(r,"U8",{{"True"},{"False"},{"x"},{"é"}})
  n=n+1
end
-- case 126: bool + U8, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({true,false},"bool"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=-1})
  verify(r,"U8",{{"True","x"},{"False","é"}})
  n=n+1
end
-- case 127: bool + U8, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({true,false},"bool"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=1})
  verify(r,"U8",{{"True","False"},{"x","é"}})
  n=n+1
end
-- case 128: bool + U8, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({true,false},"bool"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=-1})
  verify(r,"U8",{{"True","x"},{"False","é"}})
  n=n+1
end
-- case 129: bool + U8, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({true,false},"bool"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=1})
  verify(r,"U8",{{{"True","False"}},{{"x","é"}}})
  n=n+1
end
-- case 130: bool + U8, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({true,false},"bool"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=-1})
  verify(r,"U8",{{{"True","x"},{"False","é"}}})
  n=n+1
end
-- case 131: bool + U8, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({true,false},"bool"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=1})
  verify(r,"U8",{{{"True"},{"False"}},{{"x"},{"é"}}})
  n=n+1
end
-- case 132: bool + U8, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({true,false},"bool"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=-1})
  verify(r,"U8",{{{"True","x"}},{{"False","é"}}})
  n=n+1
end
-- case 133: bool + U8, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({true,false},"bool"),{2})},{axis=1})
  verify(r,"U8",{"x","é","True","False"})
  n=n+1
end
-- case 134: bool + U8, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({true,false},"bool"),{2})},{axis=-1})
  verify(r,"U8",{"x","é","True","False"})
  n=n+1
end
-- case 135: bool + U8, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({true,false},"bool"),{1,2})},{axis=1})
  verify(r,"U8",{{"x","é"},{"True","False"}})
  n=n+1
end
-- case 136: bool + U8, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({true,false},"bool"),{1,2})},{axis=-1})
  verify(r,"U8",{{"x","é","True","False"}})
  n=n+1
end
-- case 137: bool + U8, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({true,false},"bool"),{2,1})},{axis=1})
  verify(r,"U8",{{"x"},{"é"},{"True"},{"False"}})
  n=n+1
end
-- case 138: bool + U8, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({true,false},"bool"),{2,1})},{axis=-1})
  verify(r,"U8",{{"x","True"},{"é","False"}})
  n=n+1
end
-- case 139: bool + U8, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({true,false},"bool"),{2})},{axis=1})
  verify(r,"U8",{{"x","é"},{"True","False"}})
  n=n+1
end
-- case 140: bool + U8, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({true,false},"bool"),{2})},{axis=-1})
  verify(r,"U8",{{"x","True"},{"é","False"}})
  n=n+1
end
-- case 141: bool + U8, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({true,false},"bool"),{1,2})},{axis=1})
  verify(r,"U8",{{{"x","é"}},{{"True","False"}}})
  n=n+1
end
-- case 142: bool + U8, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({true,false},"bool"),{1,2})},{axis=-1})
  verify(r,"U8",{{{"x","True"},{"é","False"}}})
  n=n+1
end
-- case 143: bool + U8, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({true,false},"bool"),{2,1})},{axis=1})
  verify(r,"U8",{{{"x"},{"é"}},{{"True"},{"False"}}})
  n=n+1
end
-- case 144: bool + U8, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({true,false},"bool"),{2,1})},{axis=-1})
  verify(r,"U8",{{{"x","True"}},{{"é","False"}}})
  n=n+1
end
-- case 145: int8 + S1, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int8"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=1})
  verify(r,"S4",{"-3","17","x","y"})
  n=n+1
end
-- case 146: int8 + S1, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int8"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=-1})
  verify(r,"S4",{"-3","17","x","y"})
  n=n+1
end
-- case 147: int8 + S1, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int8"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=1})
  verify(r,"S4",{{"-3","17"},{"x","y"}})
  n=n+1
end
-- case 148: int8 + S1, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int8"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=-1})
  verify(r,"S4",{{"-3","17","x","y"}})
  n=n+1
end
-- case 149: int8 + S1, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int8"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=1})
  verify(r,"S4",{{"-3"},{"17"},{"x"},{"y"}})
  n=n+1
end
-- case 150: int8 + S1, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int8"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=-1})
  verify(r,"S4",{{"-3","x"},{"17","y"}})
  n=n+1
end
-- case 151: int8 + S1, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int8"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=1})
  verify(r,"S4",{{"-3","17"},{"x","y"}})
  n=n+1
end
-- case 152: int8 + S1, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int8"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=-1})
  verify(r,"S4",{{"-3","x"},{"17","y"}})
  n=n+1
end
-- case 153: int8 + S1, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int8"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=1})
  verify(r,"S4",{{{"-3","17"}},{{"x","y"}}})
  n=n+1
end
-- case 154: int8 + S1, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int8"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=-1})
  verify(r,"S4",{{{"-3","x"},{"17","y"}}})
  n=n+1
end
-- case 155: int8 + S1, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int8"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=1})
  verify(r,"S4",{{{"-3"},{"17"}},{{"x"},{"y"}}})
  n=n+1
end
-- case 156: int8 + S1, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int8"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=-1})
  verify(r,"S4",{{{"-3","x"}},{{"17","y"}}})
  n=n+1
end
-- case 157: int8 + S1, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({-3,17},"int8"),{2})},{axis=1})
  verify(r,"S4",{"x","y","-3","17"})
  n=n+1
end
-- case 158: int8 + S1, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({-3,17},"int8"),{2})},{axis=-1})
  verify(r,"S4",{"x","y","-3","17"})
  n=n+1
end
-- case 159: int8 + S1, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({-3,17},"int8"),{1,2})},{axis=1})
  verify(r,"S4",{{"x","y"},{"-3","17"}})
  n=n+1
end
-- case 160: int8 + S1, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({-3,17},"int8"),{1,2})},{axis=-1})
  verify(r,"S4",{{"x","y","-3","17"}})
  n=n+1
end
-- case 161: int8 + S1, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({-3,17},"int8"),{2,1})},{axis=1})
  verify(r,"S4",{{"x"},{"y"},{"-3"},{"17"}})
  n=n+1
end
-- case 162: int8 + S1, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({-3,17},"int8"),{2,1})},{axis=-1})
  verify(r,"S4",{{"x","-3"},{"y","17"}})
  n=n+1
end
-- case 163: int8 + S1, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({-3,17},"int8"),{2})},{axis=1})
  verify(r,"S4",{{"x","y"},{"-3","17"}})
  n=n+1
end
-- case 164: int8 + S1, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({-3,17},"int8"),{2})},{axis=-1})
  verify(r,"S4",{{"x","-3"},{"y","17"}})
  n=n+1
end
-- case 165: int8 + S1, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({-3,17},"int8"),{1,2})},{axis=1})
  verify(r,"S4",{{{"x","y"}},{{"-3","17"}}})
  n=n+1
end
-- case 166: int8 + S1, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({-3,17},"int8"),{1,2})},{axis=-1})
  verify(r,"S4",{{{"x","-3"},{"y","17"}}})
  n=n+1
end
-- case 167: int8 + S1, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({-3,17},"int8"),{2,1})},{axis=1})
  verify(r,"S4",{{{"x"},{"y"}},{{"-3"},{"17"}}})
  n=n+1
end
-- case 168: int8 + S1, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({-3,17},"int8"),{2,1})},{axis=-1})
  verify(r,"S4",{{{"x","-3"}},{{"y","17"}}})
  n=n+1
end
-- case 169: int8 + S3, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int8"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=1})
  verify(r,"S4",{"-3","17","x","yz"})
  n=n+1
end
-- case 170: int8 + S3, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int8"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=-1})
  verify(r,"S4",{"-3","17","x","yz"})
  n=n+1
end
-- case 171: int8 + S3, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int8"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=1})
  verify(r,"S4",{{"-3","17"},{"x","yz"}})
  n=n+1
end
-- case 172: int8 + S3, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int8"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=-1})
  verify(r,"S4",{{"-3","17","x","yz"}})
  n=n+1
end
-- case 173: int8 + S3, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int8"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=1})
  verify(r,"S4",{{"-3"},{"17"},{"x"},{"yz"}})
  n=n+1
end
-- case 174: int8 + S3, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int8"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=-1})
  verify(r,"S4",{{"-3","x"},{"17","yz"}})
  n=n+1
end
-- case 175: int8 + S3, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int8"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=1})
  verify(r,"S4",{{"-3","17"},{"x","yz"}})
  n=n+1
end
-- case 176: int8 + S3, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int8"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=-1})
  verify(r,"S4",{{"-3","x"},{"17","yz"}})
  n=n+1
end
-- case 177: int8 + S3, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int8"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=1})
  verify(r,"S4",{{{"-3","17"}},{{"x","yz"}}})
  n=n+1
end
-- case 178: int8 + S3, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int8"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=-1})
  verify(r,"S4",{{{"-3","x"},{"17","yz"}}})
  n=n+1
end
-- case 179: int8 + S3, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int8"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=1})
  verify(r,"S4",{{{"-3"},{"17"}},{{"x"},{"yz"}}})
  n=n+1
end
-- case 180: int8 + S3, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int8"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=-1})
  verify(r,"S4",{{{"-3","x"}},{{"17","yz"}}})
  n=n+1
end
-- case 181: int8 + S3, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({-3,17},"int8"),{2})},{axis=1})
  verify(r,"S4",{"x","yz","-3","17"})
  n=n+1
end
-- case 182: int8 + S3, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({-3,17},"int8"),{2})},{axis=-1})
  verify(r,"S4",{"x","yz","-3","17"})
  n=n+1
end
-- case 183: int8 + S3, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({-3,17},"int8"),{1,2})},{axis=1})
  verify(r,"S4",{{"x","yz"},{"-3","17"}})
  n=n+1
end
-- case 184: int8 + S3, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({-3,17},"int8"),{1,2})},{axis=-1})
  verify(r,"S4",{{"x","yz","-3","17"}})
  n=n+1
end
-- case 185: int8 + S3, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({-3,17},"int8"),{2,1})},{axis=1})
  verify(r,"S4",{{"x"},{"yz"},{"-3"},{"17"}})
  n=n+1
end
-- case 186: int8 + S3, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({-3,17},"int8"),{2,1})},{axis=-1})
  verify(r,"S4",{{"x","-3"},{"yz","17"}})
  n=n+1
end
-- case 187: int8 + S3, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({-3,17},"int8"),{2})},{axis=1})
  verify(r,"S4",{{"x","yz"},{"-3","17"}})
  n=n+1
end
-- case 188: int8 + S3, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({-3,17},"int8"),{2})},{axis=-1})
  verify(r,"S4",{{"x","-3"},{"yz","17"}})
  n=n+1
end
-- case 189: int8 + S3, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({-3,17},"int8"),{1,2})},{axis=1})
  verify(r,"S4",{{{"x","yz"}},{{"-3","17"}}})
  n=n+1
end
-- case 190: int8 + S3, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({-3,17},"int8"),{1,2})},{axis=-1})
  verify(r,"S4",{{{"x","-3"},{"yz","17"}}})
  n=n+1
end
-- case 191: int8 + S3, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({-3,17},"int8"),{2,1})},{axis=1})
  verify(r,"S4",{{{"x"},{"yz"}},{{"-3"},{"17"}}})
  n=n+1
end
-- case 192: int8 + S3, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({-3,17},"int8"),{2,1})},{axis=-1})
  verify(r,"S4",{{{"x","-3"}},{{"yz","17"}}})
  n=n+1
end
-- case 193: int8 + S8, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int8"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=1})
  verify(r,"S8",{"-3","17","x","yz"})
  n=n+1
end
-- case 194: int8 + S8, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int8"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=-1})
  verify(r,"S8",{"-3","17","x","yz"})
  n=n+1
end
-- case 195: int8 + S8, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int8"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=1})
  verify(r,"S8",{{"-3","17"},{"x","yz"}})
  n=n+1
end
-- case 196: int8 + S8, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int8"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=-1})
  verify(r,"S8",{{"-3","17","x","yz"}})
  n=n+1
end
-- case 197: int8 + S8, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int8"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=1})
  verify(r,"S8",{{"-3"},{"17"},{"x"},{"yz"}})
  n=n+1
end
-- case 198: int8 + S8, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int8"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=-1})
  verify(r,"S8",{{"-3","x"},{"17","yz"}})
  n=n+1
end
-- case 199: int8 + S8, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int8"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=1})
  verify(r,"S8",{{"-3","17"},{"x","yz"}})
  n=n+1
end
-- case 200: int8 + S8, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int8"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=-1})
  verify(r,"S8",{{"-3","x"},{"17","yz"}})
  n=n+1
end
-- case 201: int8 + S8, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int8"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=1})
  verify(r,"S8",{{{"-3","17"}},{{"x","yz"}}})
  n=n+1
end
-- case 202: int8 + S8, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int8"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=-1})
  verify(r,"S8",{{{"-3","x"},{"17","yz"}}})
  n=n+1
end
-- case 203: int8 + S8, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int8"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=1})
  verify(r,"S8",{{{"-3"},{"17"}},{{"x"},{"yz"}}})
  n=n+1
end
-- case 204: int8 + S8, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int8"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=-1})
  verify(r,"S8",{{{"-3","x"}},{{"17","yz"}}})
  n=n+1
end
-- case 205: int8 + S8, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({-3,17},"int8"),{2})},{axis=1})
  verify(r,"S8",{"x","yz","-3","17"})
  n=n+1
end
-- case 206: int8 + S8, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({-3,17},"int8"),{2})},{axis=-1})
  verify(r,"S8",{"x","yz","-3","17"})
  n=n+1
end
-- case 207: int8 + S8, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({-3,17},"int8"),{1,2})},{axis=1})
  verify(r,"S8",{{"x","yz"},{"-3","17"}})
  n=n+1
end
-- case 208: int8 + S8, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({-3,17},"int8"),{1,2})},{axis=-1})
  verify(r,"S8",{{"x","yz","-3","17"}})
  n=n+1
end
-- case 209: int8 + S8, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({-3,17},"int8"),{2,1})},{axis=1})
  verify(r,"S8",{{"x"},{"yz"},{"-3"},{"17"}})
  n=n+1
end
-- case 210: int8 + S8, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({-3,17},"int8"),{2,1})},{axis=-1})
  verify(r,"S8",{{"x","-3"},{"yz","17"}})
  n=n+1
end
-- case 211: int8 + S8, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({-3,17},"int8"),{2})},{axis=1})
  verify(r,"S8",{{"x","yz"},{"-3","17"}})
  n=n+1
end
-- case 212: int8 + S8, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({-3,17},"int8"),{2})},{axis=-1})
  verify(r,"S8",{{"x","-3"},{"yz","17"}})
  n=n+1
end
-- case 213: int8 + S8, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({-3,17},"int8"),{1,2})},{axis=1})
  verify(r,"S8",{{{"x","yz"}},{{"-3","17"}}})
  n=n+1
end
-- case 214: int8 + S8, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({-3,17},"int8"),{1,2})},{axis=-1})
  verify(r,"S8",{{{"x","-3"},{"yz","17"}}})
  n=n+1
end
-- case 215: int8 + S8, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({-3,17},"int8"),{2,1})},{axis=1})
  verify(r,"S8",{{{"x"},{"yz"}},{{"-3"},{"17"}}})
  n=n+1
end
-- case 216: int8 + S8, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({-3,17},"int8"),{2,1})},{axis=-1})
  verify(r,"S8",{{{"x","-3"}},{{"yz","17"}}})
  n=n+1
end
-- case 217: int8 + U1, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int8"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=1})
  verify(r,"U4",{"-3","17","x","é"})
  n=n+1
end
-- case 218: int8 + U1, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int8"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=-1})
  verify(r,"U4",{"-3","17","x","é"})
  n=n+1
end
-- case 219: int8 + U1, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int8"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=1})
  verify(r,"U4",{{"-3","17"},{"x","é"}})
  n=n+1
end
-- case 220: int8 + U1, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int8"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=-1})
  verify(r,"U4",{{"-3","17","x","é"}})
  n=n+1
end
-- case 221: int8 + U1, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int8"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=1})
  verify(r,"U4",{{"-3"},{"17"},{"x"},{"é"}})
  n=n+1
end
-- case 222: int8 + U1, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int8"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=-1})
  verify(r,"U4",{{"-3","x"},{"17","é"}})
  n=n+1
end
-- case 223: int8 + U1, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int8"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=1})
  verify(r,"U4",{{"-3","17"},{"x","é"}})
  n=n+1
end
-- case 224: int8 + U1, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int8"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=-1})
  verify(r,"U4",{{"-3","x"},{"17","é"}})
  n=n+1
end
-- case 225: int8 + U1, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int8"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=1})
  verify(r,"U4",{{{"-3","17"}},{{"x","é"}}})
  n=n+1
end
-- case 226: int8 + U1, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int8"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=-1})
  verify(r,"U4",{{{"-3","x"},{"17","é"}}})
  n=n+1
end
-- case 227: int8 + U1, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int8"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=1})
  verify(r,"U4",{{{"-3"},{"17"}},{{"x"},{"é"}}})
  n=n+1
end
-- case 228: int8 + U1, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int8"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=-1})
  verify(r,"U4",{{{"-3","x"}},{{"17","é"}}})
  n=n+1
end
-- case 229: int8 + U1, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({-3,17},"int8"),{2})},{axis=1})
  verify(r,"U4",{"x","é","-3","17"})
  n=n+1
end
-- case 230: int8 + U1, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({-3,17},"int8"),{2})},{axis=-1})
  verify(r,"U4",{"x","é","-3","17"})
  n=n+1
end
-- case 231: int8 + U1, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({-3,17},"int8"),{1,2})},{axis=1})
  verify(r,"U4",{{"x","é"},{"-3","17"}})
  n=n+1
end
-- case 232: int8 + U1, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({-3,17},"int8"),{1,2})},{axis=-1})
  verify(r,"U4",{{"x","é","-3","17"}})
  n=n+1
end
-- case 233: int8 + U1, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({-3,17},"int8"),{2,1})},{axis=1})
  verify(r,"U4",{{"x"},{"é"},{"-3"},{"17"}})
  n=n+1
end
-- case 234: int8 + U1, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({-3,17},"int8"),{2,1})},{axis=-1})
  verify(r,"U4",{{"x","-3"},{"é","17"}})
  n=n+1
end
-- case 235: int8 + U1, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({-3,17},"int8"),{2})},{axis=1})
  verify(r,"U4",{{"x","é"},{"-3","17"}})
  n=n+1
end
-- case 236: int8 + U1, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({-3,17},"int8"),{2})},{axis=-1})
  verify(r,"U4",{{"x","-3"},{"é","17"}})
  n=n+1
end
-- case 237: int8 + U1, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({-3,17},"int8"),{1,2})},{axis=1})
  verify(r,"U4",{{{"x","é"}},{{"-3","17"}}})
  n=n+1
end
-- case 238: int8 + U1, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({-3,17},"int8"),{1,2})},{axis=-1})
  verify(r,"U4",{{{"x","-3"},{"é","17"}}})
  n=n+1
end
-- case 239: int8 + U1, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({-3,17},"int8"),{2,1})},{axis=1})
  verify(r,"U4",{{{"x"},{"é"}},{{"-3"},{"17"}}})
  n=n+1
end
-- case 240: int8 + U1, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({-3,17},"int8"),{2,1})},{axis=-1})
  verify(r,"U4",{{{"x","-3"}},{{"é","17"}}})
  n=n+1
end
-- case 241: int8 + U3, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int8"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=1})
  verify(r,"U4",{"-3","17","x","é"})
  n=n+1
end
-- case 242: int8 + U3, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int8"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=-1})
  verify(r,"U4",{"-3","17","x","é"})
  n=n+1
end
-- case 243: int8 + U3, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int8"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=1})
  verify(r,"U4",{{"-3","17"},{"x","é"}})
  n=n+1
end
-- case 244: int8 + U3, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int8"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=-1})
  verify(r,"U4",{{"-3","17","x","é"}})
  n=n+1
end
-- case 245: int8 + U3, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int8"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=1})
  verify(r,"U4",{{"-3"},{"17"},{"x"},{"é"}})
  n=n+1
end
-- case 246: int8 + U3, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int8"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=-1})
  verify(r,"U4",{{"-3","x"},{"17","é"}})
  n=n+1
end
-- case 247: int8 + U3, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int8"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=1})
  verify(r,"U4",{{"-3","17"},{"x","é"}})
  n=n+1
end
-- case 248: int8 + U3, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int8"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=-1})
  verify(r,"U4",{{"-3","x"},{"17","é"}})
  n=n+1
end
-- case 249: int8 + U3, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int8"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=1})
  verify(r,"U4",{{{"-3","17"}},{{"x","é"}}})
  n=n+1
end
-- case 250: int8 + U3, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int8"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=-1})
  verify(r,"U4",{{{"-3","x"},{"17","é"}}})
  n=n+1
end
-- case 251: int8 + U3, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int8"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=1})
  verify(r,"U4",{{{"-3"},{"17"}},{{"x"},{"é"}}})
  n=n+1
end
-- case 252: int8 + U3, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int8"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=-1})
  verify(r,"U4",{{{"-3","x"}},{{"17","é"}}})
  n=n+1
end
-- case 253: int8 + U3, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({-3,17},"int8"),{2})},{axis=1})
  verify(r,"U4",{"x","é","-3","17"})
  n=n+1
end
-- case 254: int8 + U3, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({-3,17},"int8"),{2})},{axis=-1})
  verify(r,"U4",{"x","é","-3","17"})
  n=n+1
end
-- case 255: int8 + U3, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({-3,17},"int8"),{1,2})},{axis=1})
  verify(r,"U4",{{"x","é"},{"-3","17"}})
  n=n+1
end
-- case 256: int8 + U3, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({-3,17},"int8"),{1,2})},{axis=-1})
  verify(r,"U4",{{"x","é","-3","17"}})
  n=n+1
end
-- case 257: int8 + U3, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({-3,17},"int8"),{2,1})},{axis=1})
  verify(r,"U4",{{"x"},{"é"},{"-3"},{"17"}})
  n=n+1
end
-- case 258: int8 + U3, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({-3,17},"int8"),{2,1})},{axis=-1})
  verify(r,"U4",{{"x","-3"},{"é","17"}})
  n=n+1
end
-- case 259: int8 + U3, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({-3,17},"int8"),{2})},{axis=1})
  verify(r,"U4",{{"x","é"},{"-3","17"}})
  n=n+1
end
-- case 260: int8 + U3, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({-3,17},"int8"),{2})},{axis=-1})
  verify(r,"U4",{{"x","-3"},{"é","17"}})
  n=n+1
end
-- case 261: int8 + U3, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({-3,17},"int8"),{1,2})},{axis=1})
  verify(r,"U4",{{{"x","é"}},{{"-3","17"}}})
  n=n+1
end
-- case 262: int8 + U3, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({-3,17},"int8"),{1,2})},{axis=-1})
  verify(r,"U4",{{{"x","-3"},{"é","17"}}})
  n=n+1
end
-- case 263: int8 + U3, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({-3,17},"int8"),{2,1})},{axis=1})
  verify(r,"U4",{{{"x"},{"é"}},{{"-3"},{"17"}}})
  n=n+1
end
-- case 264: int8 + U3, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({-3,17},"int8"),{2,1})},{axis=-1})
  verify(r,"U4",{{{"x","-3"}},{{"é","17"}}})
  n=n+1
end
-- case 265: int8 + U8, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int8"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=1})
  verify(r,"U8",{"-3","17","x","é"})
  n=n+1
end
-- case 266: int8 + U8, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int8"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=-1})
  verify(r,"U8",{"-3","17","x","é"})
  n=n+1
end
-- case 267: int8 + U8, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int8"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=1})
  verify(r,"U8",{{"-3","17"},{"x","é"}})
  n=n+1
end
-- case 268: int8 + U8, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int8"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=-1})
  verify(r,"U8",{{"-3","17","x","é"}})
  n=n+1
end
-- case 269: int8 + U8, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int8"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=1})
  verify(r,"U8",{{"-3"},{"17"},{"x"},{"é"}})
  n=n+1
end
-- case 270: int8 + U8, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int8"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=-1})
  verify(r,"U8",{{"-3","x"},{"17","é"}})
  n=n+1
end
-- case 271: int8 + U8, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int8"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=1})
  verify(r,"U8",{{"-3","17"},{"x","é"}})
  n=n+1
end
-- case 272: int8 + U8, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int8"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=-1})
  verify(r,"U8",{{"-3","x"},{"17","é"}})
  n=n+1
end
-- case 273: int8 + U8, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int8"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=1})
  verify(r,"U8",{{{"-3","17"}},{{"x","é"}}})
  n=n+1
end
-- case 274: int8 + U8, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int8"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=-1})
  verify(r,"U8",{{{"-3","x"},{"17","é"}}})
  n=n+1
end
-- case 275: int8 + U8, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int8"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=1})
  verify(r,"U8",{{{"-3"},{"17"}},{{"x"},{"é"}}})
  n=n+1
end
-- case 276: int8 + U8, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int8"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=-1})
  verify(r,"U8",{{{"-3","x"}},{{"17","é"}}})
  n=n+1
end
-- case 277: int8 + U8, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({-3,17},"int8"),{2})},{axis=1})
  verify(r,"U8",{"x","é","-3","17"})
  n=n+1
end
-- case 278: int8 + U8, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({-3,17},"int8"),{2})},{axis=-1})
  verify(r,"U8",{"x","é","-3","17"})
  n=n+1
end
-- case 279: int8 + U8, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({-3,17},"int8"),{1,2})},{axis=1})
  verify(r,"U8",{{"x","é"},{"-3","17"}})
  n=n+1
end
-- case 280: int8 + U8, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({-3,17},"int8"),{1,2})},{axis=-1})
  verify(r,"U8",{{"x","é","-3","17"}})
  n=n+1
end
-- case 281: int8 + U8, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({-3,17},"int8"),{2,1})},{axis=1})
  verify(r,"U8",{{"x"},{"é"},{"-3"},{"17"}})
  n=n+1
end
-- case 282: int8 + U8, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({-3,17},"int8"),{2,1})},{axis=-1})
  verify(r,"U8",{{"x","-3"},{"é","17"}})
  n=n+1
end
-- case 283: int8 + U8, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({-3,17},"int8"),{2})},{axis=1})
  verify(r,"U8",{{"x","é"},{"-3","17"}})
  n=n+1
end
-- case 284: int8 + U8, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({-3,17},"int8"),{2})},{axis=-1})
  verify(r,"U8",{{"x","-3"},{"é","17"}})
  n=n+1
end
-- case 285: int8 + U8, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({-3,17},"int8"),{1,2})},{axis=1})
  verify(r,"U8",{{{"x","é"}},{{"-3","17"}}})
  n=n+1
end
-- case 286: int8 + U8, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({-3,17},"int8"),{1,2})},{axis=-1})
  verify(r,"U8",{{{"x","-3"},{"é","17"}}})
  n=n+1
end
-- case 287: int8 + U8, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({-3,17},"int8"),{2,1})},{axis=1})
  verify(r,"U8",{{{"x"},{"é"}},{{"-3"},{"17"}}})
  n=n+1
end
-- case 288: int8 + U8, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({-3,17},"int8"),{2,1})},{axis=-1})
  verify(r,"U8",{{{"x","-3"}},{{"é","17"}}})
  n=n+1
end
-- case 289: uint8 + S1, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint8"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=1})
  verify(r,"S3",{"3","17","x","y"})
  n=n+1
end
-- case 290: uint8 + S1, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint8"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=-1})
  verify(r,"S3",{"3","17","x","y"})
  n=n+1
end
-- case 291: uint8 + S1, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint8"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=1})
  verify(r,"S3",{{"3","17"},{"x","y"}})
  n=n+1
end
-- case 292: uint8 + S1, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint8"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=-1})
  verify(r,"S3",{{"3","17","x","y"}})
  n=n+1
end
-- case 293: uint8 + S1, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint8"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=1})
  verify(r,"S3",{{"3"},{"17"},{"x"},{"y"}})
  n=n+1
end
-- case 294: uint8 + S1, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint8"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=-1})
  verify(r,"S3",{{"3","x"},{"17","y"}})
  n=n+1
end
-- case 295: uint8 + S1, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint8"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=1})
  verify(r,"S3",{{"3","17"},{"x","y"}})
  n=n+1
end
-- case 296: uint8 + S1, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint8"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=-1})
  verify(r,"S3",{{"3","x"},{"17","y"}})
  n=n+1
end
-- case 297: uint8 + S1, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint8"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=1})
  verify(r,"S3",{{{"3","17"}},{{"x","y"}}})
  n=n+1
end
-- case 298: uint8 + S1, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint8"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=-1})
  verify(r,"S3",{{{"3","x"},{"17","y"}}})
  n=n+1
end
-- case 299: uint8 + S1, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint8"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=1})
  verify(r,"S3",{{{"3"},{"17"}},{{"x"},{"y"}}})
  n=n+1
end
-- case 300: uint8 + S1, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint8"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=-1})
  verify(r,"S3",{{{"3","x"}},{{"17","y"}}})
  n=n+1
end
-- case 301: uint8 + S1, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({3,17},"uint8"),{2})},{axis=1})
  verify(r,"S3",{"x","y","3","17"})
  n=n+1
end
-- case 302: uint8 + S1, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({3,17},"uint8"),{2})},{axis=-1})
  verify(r,"S3",{"x","y","3","17"})
  n=n+1
end
-- case 303: uint8 + S1, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({3,17},"uint8"),{1,2})},{axis=1})
  verify(r,"S3",{{"x","y"},{"3","17"}})
  n=n+1
end
-- case 304: uint8 + S1, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({3,17},"uint8"),{1,2})},{axis=-1})
  verify(r,"S3",{{"x","y","3","17"}})
  n=n+1
end
-- case 305: uint8 + S1, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({3,17},"uint8"),{2,1})},{axis=1})
  verify(r,"S3",{{"x"},{"y"},{"3"},{"17"}})
  n=n+1
end
-- case 306: uint8 + S1, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({3,17},"uint8"),{2,1})},{axis=-1})
  verify(r,"S3",{{"x","3"},{"y","17"}})
  n=n+1
end
-- case 307: uint8 + S1, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({3,17},"uint8"),{2})},{axis=1})
  verify(r,"S3",{{"x","y"},{"3","17"}})
  n=n+1
end
-- case 308: uint8 + S1, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({3,17},"uint8"),{2})},{axis=-1})
  verify(r,"S3",{{"x","3"},{"y","17"}})
  n=n+1
end
-- case 309: uint8 + S1, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({3,17},"uint8"),{1,2})},{axis=1})
  verify(r,"S3",{{{"x","y"}},{{"3","17"}}})
  n=n+1
end
-- case 310: uint8 + S1, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({3,17},"uint8"),{1,2})},{axis=-1})
  verify(r,"S3",{{{"x","3"},{"y","17"}}})
  n=n+1
end
-- case 311: uint8 + S1, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({3,17},"uint8"),{2,1})},{axis=1})
  verify(r,"S3",{{{"x"},{"y"}},{{"3"},{"17"}}})
  n=n+1
end
-- case 312: uint8 + S1, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({3,17},"uint8"),{2,1})},{axis=-1})
  verify(r,"S3",{{{"x","3"}},{{"y","17"}}})
  n=n+1
end
-- case 313: uint8 + S3, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint8"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=1})
  verify(r,"S3",{"3","17","x","yz"})
  n=n+1
end
-- case 314: uint8 + S3, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint8"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=-1})
  verify(r,"S3",{"3","17","x","yz"})
  n=n+1
end
-- case 315: uint8 + S3, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint8"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=1})
  verify(r,"S3",{{"3","17"},{"x","yz"}})
  n=n+1
end
-- case 316: uint8 + S3, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint8"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=-1})
  verify(r,"S3",{{"3","17","x","yz"}})
  n=n+1
end
-- case 317: uint8 + S3, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint8"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=1})
  verify(r,"S3",{{"3"},{"17"},{"x"},{"yz"}})
  n=n+1
end
-- case 318: uint8 + S3, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint8"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=-1})
  verify(r,"S3",{{"3","x"},{"17","yz"}})
  n=n+1
end
-- case 319: uint8 + S3, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint8"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=1})
  verify(r,"S3",{{"3","17"},{"x","yz"}})
  n=n+1
end
-- case 320: uint8 + S3, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint8"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=-1})
  verify(r,"S3",{{"3","x"},{"17","yz"}})
  n=n+1
end
-- case 321: uint8 + S3, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint8"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=1})
  verify(r,"S3",{{{"3","17"}},{{"x","yz"}}})
  n=n+1
end
-- case 322: uint8 + S3, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint8"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=-1})
  verify(r,"S3",{{{"3","x"},{"17","yz"}}})
  n=n+1
end
-- case 323: uint8 + S3, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint8"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=1})
  verify(r,"S3",{{{"3"},{"17"}},{{"x"},{"yz"}}})
  n=n+1
end
-- case 324: uint8 + S3, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint8"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=-1})
  verify(r,"S3",{{{"3","x"}},{{"17","yz"}}})
  n=n+1
end
-- case 325: uint8 + S3, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({3,17},"uint8"),{2})},{axis=1})
  verify(r,"S3",{"x","yz","3","17"})
  n=n+1
end
-- case 326: uint8 + S3, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({3,17},"uint8"),{2})},{axis=-1})
  verify(r,"S3",{"x","yz","3","17"})
  n=n+1
end
-- case 327: uint8 + S3, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({3,17},"uint8"),{1,2})},{axis=1})
  verify(r,"S3",{{"x","yz"},{"3","17"}})
  n=n+1
end
-- case 328: uint8 + S3, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({3,17},"uint8"),{1,2})},{axis=-1})
  verify(r,"S3",{{"x","yz","3","17"}})
  n=n+1
end
-- case 329: uint8 + S3, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({3,17},"uint8"),{2,1})},{axis=1})
  verify(r,"S3",{{"x"},{"yz"},{"3"},{"17"}})
  n=n+1
end
-- case 330: uint8 + S3, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({3,17},"uint8"),{2,1})},{axis=-1})
  verify(r,"S3",{{"x","3"},{"yz","17"}})
  n=n+1
end
-- case 331: uint8 + S3, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({3,17},"uint8"),{2})},{axis=1})
  verify(r,"S3",{{"x","yz"},{"3","17"}})
  n=n+1
end
-- case 332: uint8 + S3, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({3,17},"uint8"),{2})},{axis=-1})
  verify(r,"S3",{{"x","3"},{"yz","17"}})
  n=n+1
end
-- case 333: uint8 + S3, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({3,17},"uint8"),{1,2})},{axis=1})
  verify(r,"S3",{{{"x","yz"}},{{"3","17"}}})
  n=n+1
end
-- case 334: uint8 + S3, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({3,17},"uint8"),{1,2})},{axis=-1})
  verify(r,"S3",{{{"x","3"},{"yz","17"}}})
  n=n+1
end
-- case 335: uint8 + S3, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({3,17},"uint8"),{2,1})},{axis=1})
  verify(r,"S3",{{{"x"},{"yz"}},{{"3"},{"17"}}})
  n=n+1
end
-- case 336: uint8 + S3, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({3,17},"uint8"),{2,1})},{axis=-1})
  verify(r,"S3",{{{"x","3"}},{{"yz","17"}}})
  n=n+1
end
-- case 337: uint8 + S8, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint8"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=1})
  verify(r,"S8",{"3","17","x","yz"})
  n=n+1
end
-- case 338: uint8 + S8, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint8"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=-1})
  verify(r,"S8",{"3","17","x","yz"})
  n=n+1
end
-- case 339: uint8 + S8, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint8"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=1})
  verify(r,"S8",{{"3","17"},{"x","yz"}})
  n=n+1
end
-- case 340: uint8 + S8, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint8"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=-1})
  verify(r,"S8",{{"3","17","x","yz"}})
  n=n+1
end
-- case 341: uint8 + S8, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint8"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=1})
  verify(r,"S8",{{"3"},{"17"},{"x"},{"yz"}})
  n=n+1
end
-- case 342: uint8 + S8, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint8"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=-1})
  verify(r,"S8",{{"3","x"},{"17","yz"}})
  n=n+1
end
-- case 343: uint8 + S8, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint8"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=1})
  verify(r,"S8",{{"3","17"},{"x","yz"}})
  n=n+1
end
-- case 344: uint8 + S8, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint8"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=-1})
  verify(r,"S8",{{"3","x"},{"17","yz"}})
  n=n+1
end
-- case 345: uint8 + S8, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint8"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=1})
  verify(r,"S8",{{{"3","17"}},{{"x","yz"}}})
  n=n+1
end
-- case 346: uint8 + S8, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint8"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=-1})
  verify(r,"S8",{{{"3","x"},{"17","yz"}}})
  n=n+1
end
-- case 347: uint8 + S8, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint8"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=1})
  verify(r,"S8",{{{"3"},{"17"}},{{"x"},{"yz"}}})
  n=n+1
end
-- case 348: uint8 + S8, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint8"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=-1})
  verify(r,"S8",{{{"3","x"}},{{"17","yz"}}})
  n=n+1
end
-- case 349: uint8 + S8, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({3,17},"uint8"),{2})},{axis=1})
  verify(r,"S8",{"x","yz","3","17"})
  n=n+1
end
-- case 350: uint8 + S8, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({3,17},"uint8"),{2})},{axis=-1})
  verify(r,"S8",{"x","yz","3","17"})
  n=n+1
end
-- case 351: uint8 + S8, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({3,17},"uint8"),{1,2})},{axis=1})
  verify(r,"S8",{{"x","yz"},{"3","17"}})
  n=n+1
end
-- case 352: uint8 + S8, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({3,17},"uint8"),{1,2})},{axis=-1})
  verify(r,"S8",{{"x","yz","3","17"}})
  n=n+1
end
-- case 353: uint8 + S8, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({3,17},"uint8"),{2,1})},{axis=1})
  verify(r,"S8",{{"x"},{"yz"},{"3"},{"17"}})
  n=n+1
end
-- case 354: uint8 + S8, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({3,17},"uint8"),{2,1})},{axis=-1})
  verify(r,"S8",{{"x","3"},{"yz","17"}})
  n=n+1
end
-- case 355: uint8 + S8, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({3,17},"uint8"),{2})},{axis=1})
  verify(r,"S8",{{"x","yz"},{"3","17"}})
  n=n+1
end
-- case 356: uint8 + S8, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({3,17},"uint8"),{2})},{axis=-1})
  verify(r,"S8",{{"x","3"},{"yz","17"}})
  n=n+1
end
-- case 357: uint8 + S8, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({3,17},"uint8"),{1,2})},{axis=1})
  verify(r,"S8",{{{"x","yz"}},{{"3","17"}}})
  n=n+1
end
-- case 358: uint8 + S8, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({3,17},"uint8"),{1,2})},{axis=-1})
  verify(r,"S8",{{{"x","3"},{"yz","17"}}})
  n=n+1
end
-- case 359: uint8 + S8, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({3,17},"uint8"),{2,1})},{axis=1})
  verify(r,"S8",{{{"x"},{"yz"}},{{"3"},{"17"}}})
  n=n+1
end
-- case 360: uint8 + S8, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({3,17},"uint8"),{2,1})},{axis=-1})
  verify(r,"S8",{{{"x","3"}},{{"yz","17"}}})
  n=n+1
end
-- case 361: uint8 + U1, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint8"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=1})
  verify(r,"U3",{"3","17","x","é"})
  n=n+1
end
-- case 362: uint8 + U1, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint8"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=-1})
  verify(r,"U3",{"3","17","x","é"})
  n=n+1
end
-- case 363: uint8 + U1, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint8"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=1})
  verify(r,"U3",{{"3","17"},{"x","é"}})
  n=n+1
end
-- case 364: uint8 + U1, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint8"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=-1})
  verify(r,"U3",{{"3","17","x","é"}})
  n=n+1
end
-- case 365: uint8 + U1, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint8"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=1})
  verify(r,"U3",{{"3"},{"17"},{"x"},{"é"}})
  n=n+1
end
-- case 366: uint8 + U1, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint8"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=-1})
  verify(r,"U3",{{"3","x"},{"17","é"}})
  n=n+1
end
-- case 367: uint8 + U1, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint8"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=1})
  verify(r,"U3",{{"3","17"},{"x","é"}})
  n=n+1
end
-- case 368: uint8 + U1, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint8"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=-1})
  verify(r,"U3",{{"3","x"},{"17","é"}})
  n=n+1
end
-- case 369: uint8 + U1, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint8"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=1})
  verify(r,"U3",{{{"3","17"}},{{"x","é"}}})
  n=n+1
end
-- case 370: uint8 + U1, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint8"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=-1})
  verify(r,"U3",{{{"3","x"},{"17","é"}}})
  n=n+1
end
-- case 371: uint8 + U1, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint8"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=1})
  verify(r,"U3",{{{"3"},{"17"}},{{"x"},{"é"}}})
  n=n+1
end
-- case 372: uint8 + U1, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint8"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=-1})
  verify(r,"U3",{{{"3","x"}},{{"17","é"}}})
  n=n+1
end
-- case 373: uint8 + U1, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({3,17},"uint8"),{2})},{axis=1})
  verify(r,"U3",{"x","é","3","17"})
  n=n+1
end
-- case 374: uint8 + U1, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({3,17},"uint8"),{2})},{axis=-1})
  verify(r,"U3",{"x","é","3","17"})
  n=n+1
end
-- case 375: uint8 + U1, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({3,17},"uint8"),{1,2})},{axis=1})
  verify(r,"U3",{{"x","é"},{"3","17"}})
  n=n+1
end
-- case 376: uint8 + U1, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({3,17},"uint8"),{1,2})},{axis=-1})
  verify(r,"U3",{{"x","é","3","17"}})
  n=n+1
end
-- case 377: uint8 + U1, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({3,17},"uint8"),{2,1})},{axis=1})
  verify(r,"U3",{{"x"},{"é"},{"3"},{"17"}})
  n=n+1
end
-- case 378: uint8 + U1, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({3,17},"uint8"),{2,1})},{axis=-1})
  verify(r,"U3",{{"x","3"},{"é","17"}})
  n=n+1
end
-- case 379: uint8 + U1, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({3,17},"uint8"),{2})},{axis=1})
  verify(r,"U3",{{"x","é"},{"3","17"}})
  n=n+1
end
-- case 380: uint8 + U1, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({3,17},"uint8"),{2})},{axis=-1})
  verify(r,"U3",{{"x","3"},{"é","17"}})
  n=n+1
end
-- case 381: uint8 + U1, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({3,17},"uint8"),{1,2})},{axis=1})
  verify(r,"U3",{{{"x","é"}},{{"3","17"}}})
  n=n+1
end
-- case 382: uint8 + U1, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({3,17},"uint8"),{1,2})},{axis=-1})
  verify(r,"U3",{{{"x","3"},{"é","17"}}})
  n=n+1
end
-- case 383: uint8 + U1, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({3,17},"uint8"),{2,1})},{axis=1})
  verify(r,"U3",{{{"x"},{"é"}},{{"3"},{"17"}}})
  n=n+1
end
-- case 384: uint8 + U1, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({3,17},"uint8"),{2,1})},{axis=-1})
  verify(r,"U3",{{{"x","3"}},{{"é","17"}}})
  n=n+1
end
-- case 385: uint8 + U3, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint8"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=1})
  verify(r,"U3",{"3","17","x","é"})
  n=n+1
end
-- case 386: uint8 + U3, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint8"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=-1})
  verify(r,"U3",{"3","17","x","é"})
  n=n+1
end
-- case 387: uint8 + U3, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint8"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=1})
  verify(r,"U3",{{"3","17"},{"x","é"}})
  n=n+1
end
-- case 388: uint8 + U3, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint8"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=-1})
  verify(r,"U3",{{"3","17","x","é"}})
  n=n+1
end
-- case 389: uint8 + U3, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint8"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=1})
  verify(r,"U3",{{"3"},{"17"},{"x"},{"é"}})
  n=n+1
end
-- case 390: uint8 + U3, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint8"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=-1})
  verify(r,"U3",{{"3","x"},{"17","é"}})
  n=n+1
end
-- case 391: uint8 + U3, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint8"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=1})
  verify(r,"U3",{{"3","17"},{"x","é"}})
  n=n+1
end
-- case 392: uint8 + U3, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint8"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=-1})
  verify(r,"U3",{{"3","x"},{"17","é"}})
  n=n+1
end
-- case 393: uint8 + U3, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint8"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=1})
  verify(r,"U3",{{{"3","17"}},{{"x","é"}}})
  n=n+1
end
-- case 394: uint8 + U3, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint8"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=-1})
  verify(r,"U3",{{{"3","x"},{"17","é"}}})
  n=n+1
end
-- case 395: uint8 + U3, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint8"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=1})
  verify(r,"U3",{{{"3"},{"17"}},{{"x"},{"é"}}})
  n=n+1
end
-- case 396: uint8 + U3, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint8"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=-1})
  verify(r,"U3",{{{"3","x"}},{{"17","é"}}})
  n=n+1
end
-- case 397: uint8 + U3, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({3,17},"uint8"),{2})},{axis=1})
  verify(r,"U3",{"x","é","3","17"})
  n=n+1
end
-- case 398: uint8 + U3, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({3,17},"uint8"),{2})},{axis=-1})
  verify(r,"U3",{"x","é","3","17"})
  n=n+1
end
-- case 399: uint8 + U3, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({3,17},"uint8"),{1,2})},{axis=1})
  verify(r,"U3",{{"x","é"},{"3","17"}})
  n=n+1
end
-- case 400: uint8 + U3, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({3,17},"uint8"),{1,2})},{axis=-1})
  verify(r,"U3",{{"x","é","3","17"}})
  n=n+1
end
-- case 401: uint8 + U3, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({3,17},"uint8"),{2,1})},{axis=1})
  verify(r,"U3",{{"x"},{"é"},{"3"},{"17"}})
  n=n+1
end
-- case 402: uint8 + U3, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({3,17},"uint8"),{2,1})},{axis=-1})
  verify(r,"U3",{{"x","3"},{"é","17"}})
  n=n+1
end
-- case 403: uint8 + U3, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({3,17},"uint8"),{2})},{axis=1})
  verify(r,"U3",{{"x","é"},{"3","17"}})
  n=n+1
end
-- case 404: uint8 + U3, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({3,17},"uint8"),{2})},{axis=-1})
  verify(r,"U3",{{"x","3"},{"é","17"}})
  n=n+1
end
-- case 405: uint8 + U3, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({3,17},"uint8"),{1,2})},{axis=1})
  verify(r,"U3",{{{"x","é"}},{{"3","17"}}})
  n=n+1
end
-- case 406: uint8 + U3, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({3,17},"uint8"),{1,2})},{axis=-1})
  verify(r,"U3",{{{"x","3"},{"é","17"}}})
  n=n+1
end
-- case 407: uint8 + U3, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({3,17},"uint8"),{2,1})},{axis=1})
  verify(r,"U3",{{{"x"},{"é"}},{{"3"},{"17"}}})
  n=n+1
end
-- case 408: uint8 + U3, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({3,17},"uint8"),{2,1})},{axis=-1})
  verify(r,"U3",{{{"x","3"}},{{"é","17"}}})
  n=n+1
end
-- case 409: uint8 + U8, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint8"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=1})
  verify(r,"U8",{"3","17","x","é"})
  n=n+1
end
-- case 410: uint8 + U8, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint8"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=-1})
  verify(r,"U8",{"3","17","x","é"})
  n=n+1
end
-- case 411: uint8 + U8, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint8"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=1})
  verify(r,"U8",{{"3","17"},{"x","é"}})
  n=n+1
end
-- case 412: uint8 + U8, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint8"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=-1})
  verify(r,"U8",{{"3","17","x","é"}})
  n=n+1
end
-- case 413: uint8 + U8, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint8"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=1})
  verify(r,"U8",{{"3"},{"17"},{"x"},{"é"}})
  n=n+1
end
-- case 414: uint8 + U8, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint8"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=-1})
  verify(r,"U8",{{"3","x"},{"17","é"}})
  n=n+1
end
-- case 415: uint8 + U8, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint8"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=1})
  verify(r,"U8",{{"3","17"},{"x","é"}})
  n=n+1
end
-- case 416: uint8 + U8, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint8"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=-1})
  verify(r,"U8",{{"3","x"},{"17","é"}})
  n=n+1
end
-- case 417: uint8 + U8, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint8"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=1})
  verify(r,"U8",{{{"3","17"}},{{"x","é"}}})
  n=n+1
end
-- case 418: uint8 + U8, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint8"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=-1})
  verify(r,"U8",{{{"3","x"},{"17","é"}}})
  n=n+1
end
-- case 419: uint8 + U8, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint8"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=1})
  verify(r,"U8",{{{"3"},{"17"}},{{"x"},{"é"}}})
  n=n+1
end
-- case 420: uint8 + U8, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint8"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=-1})
  verify(r,"U8",{{{"3","x"}},{{"17","é"}}})
  n=n+1
end
-- case 421: uint8 + U8, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({3,17},"uint8"),{2})},{axis=1})
  verify(r,"U8",{"x","é","3","17"})
  n=n+1
end
-- case 422: uint8 + U8, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({3,17},"uint8"),{2})},{axis=-1})
  verify(r,"U8",{"x","é","3","17"})
  n=n+1
end
-- case 423: uint8 + U8, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({3,17},"uint8"),{1,2})},{axis=1})
  verify(r,"U8",{{"x","é"},{"3","17"}})
  n=n+1
end
-- case 424: uint8 + U8, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({3,17},"uint8"),{1,2})},{axis=-1})
  verify(r,"U8",{{"x","é","3","17"}})
  n=n+1
end
-- case 425: uint8 + U8, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({3,17},"uint8"),{2,1})},{axis=1})
  verify(r,"U8",{{"x"},{"é"},{"3"},{"17"}})
  n=n+1
end
-- case 426: uint8 + U8, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({3,17},"uint8"),{2,1})},{axis=-1})
  verify(r,"U8",{{"x","3"},{"é","17"}})
  n=n+1
end
-- case 427: uint8 + U8, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({3,17},"uint8"),{2})},{axis=1})
  verify(r,"U8",{{"x","é"},{"3","17"}})
  n=n+1
end
-- case 428: uint8 + U8, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({3,17},"uint8"),{2})},{axis=-1})
  verify(r,"U8",{{"x","3"},{"é","17"}})
  n=n+1
end
-- case 429: uint8 + U8, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({3,17},"uint8"),{1,2})},{axis=1})
  verify(r,"U8",{{{"x","é"}},{{"3","17"}}})
  n=n+1
end
-- case 430: uint8 + U8, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({3,17},"uint8"),{1,2})},{axis=-1})
  verify(r,"U8",{{{"x","3"},{"é","17"}}})
  n=n+1
end
-- case 431: uint8 + U8, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({3,17},"uint8"),{2,1})},{axis=1})
  verify(r,"U8",{{{"x"},{"é"}},{{"3"},{"17"}}})
  n=n+1
end
-- case 432: uint8 + U8, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({3,17},"uint8"),{2,1})},{axis=-1})
  verify(r,"U8",{{{"x","3"}},{{"é","17"}}})
  n=n+1
end
-- case 433: int16 + S1, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int16"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=1})
  verify(r,"S6",{"-3","17","x","y"})
  n=n+1
end
-- case 434: int16 + S1, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int16"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=-1})
  verify(r,"S6",{"-3","17","x","y"})
  n=n+1
end
-- case 435: int16 + S1, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int16"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=1})
  verify(r,"S6",{{"-3","17"},{"x","y"}})
  n=n+1
end
-- case 436: int16 + S1, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int16"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=-1})
  verify(r,"S6",{{"-3","17","x","y"}})
  n=n+1
end
-- case 437: int16 + S1, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int16"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=1})
  verify(r,"S6",{{"-3"},{"17"},{"x"},{"y"}})
  n=n+1
end
-- case 438: int16 + S1, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int16"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=-1})
  verify(r,"S6",{{"-3","x"},{"17","y"}})
  n=n+1
end
-- case 439: int16 + S1, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int16"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=1})
  verify(r,"S6",{{"-3","17"},{"x","y"}})
  n=n+1
end
-- case 440: int16 + S1, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int16"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=-1})
  verify(r,"S6",{{"-3","x"},{"17","y"}})
  n=n+1
end
-- case 441: int16 + S1, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int16"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=1})
  verify(r,"S6",{{{"-3","17"}},{{"x","y"}}})
  n=n+1
end
-- case 442: int16 + S1, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int16"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=-1})
  verify(r,"S6",{{{"-3","x"},{"17","y"}}})
  n=n+1
end
-- case 443: int16 + S1, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int16"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=1})
  verify(r,"S6",{{{"-3"},{"17"}},{{"x"},{"y"}}})
  n=n+1
end
-- case 444: int16 + S1, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int16"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=-1})
  verify(r,"S6",{{{"-3","x"}},{{"17","y"}}})
  n=n+1
end
-- case 445: int16 + S1, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({-3,17},"int16"),{2})},{axis=1})
  verify(r,"S6",{"x","y","-3","17"})
  n=n+1
end
-- case 446: int16 + S1, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({-3,17},"int16"),{2})},{axis=-1})
  verify(r,"S6",{"x","y","-3","17"})
  n=n+1
end
-- case 447: int16 + S1, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({-3,17},"int16"),{1,2})},{axis=1})
  verify(r,"S6",{{"x","y"},{"-3","17"}})
  n=n+1
end
-- case 448: int16 + S1, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({-3,17},"int16"),{1,2})},{axis=-1})
  verify(r,"S6",{{"x","y","-3","17"}})
  n=n+1
end
-- case 449: int16 + S1, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({-3,17},"int16"),{2,1})},{axis=1})
  verify(r,"S6",{{"x"},{"y"},{"-3"},{"17"}})
  n=n+1
end
-- case 450: int16 + S1, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({-3,17},"int16"),{2,1})},{axis=-1})
  verify(r,"S6",{{"x","-3"},{"y","17"}})
  n=n+1
end
-- case 451: int16 + S1, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({-3,17},"int16"),{2})},{axis=1})
  verify(r,"S6",{{"x","y"},{"-3","17"}})
  n=n+1
end
-- case 452: int16 + S1, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({-3,17},"int16"),{2})},{axis=-1})
  verify(r,"S6",{{"x","-3"},{"y","17"}})
  n=n+1
end
-- case 453: int16 + S1, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({-3,17},"int16"),{1,2})},{axis=1})
  verify(r,"S6",{{{"x","y"}},{{"-3","17"}}})
  n=n+1
end
-- case 454: int16 + S1, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({-3,17},"int16"),{1,2})},{axis=-1})
  verify(r,"S6",{{{"x","-3"},{"y","17"}}})
  n=n+1
end
-- case 455: int16 + S1, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({-3,17},"int16"),{2,1})},{axis=1})
  verify(r,"S6",{{{"x"},{"y"}},{{"-3"},{"17"}}})
  n=n+1
end
-- case 456: int16 + S1, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({-3,17},"int16"),{2,1})},{axis=-1})
  verify(r,"S6",{{{"x","-3"}},{{"y","17"}}})
  n=n+1
end
-- case 457: int16 + S3, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int16"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=1})
  verify(r,"S6",{"-3","17","x","yz"})
  n=n+1
end
-- case 458: int16 + S3, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int16"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=-1})
  verify(r,"S6",{"-3","17","x","yz"})
  n=n+1
end
-- case 459: int16 + S3, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int16"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=1})
  verify(r,"S6",{{"-3","17"},{"x","yz"}})
  n=n+1
end
-- case 460: int16 + S3, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int16"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=-1})
  verify(r,"S6",{{"-3","17","x","yz"}})
  n=n+1
end
-- case 461: int16 + S3, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int16"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=1})
  verify(r,"S6",{{"-3"},{"17"},{"x"},{"yz"}})
  n=n+1
end
-- case 462: int16 + S3, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int16"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=-1})
  verify(r,"S6",{{"-3","x"},{"17","yz"}})
  n=n+1
end
-- case 463: int16 + S3, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int16"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=1})
  verify(r,"S6",{{"-3","17"},{"x","yz"}})
  n=n+1
end
-- case 464: int16 + S3, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int16"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=-1})
  verify(r,"S6",{{"-3","x"},{"17","yz"}})
  n=n+1
end
-- case 465: int16 + S3, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int16"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=1})
  verify(r,"S6",{{{"-3","17"}},{{"x","yz"}}})
  n=n+1
end
-- case 466: int16 + S3, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int16"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=-1})
  verify(r,"S6",{{{"-3","x"},{"17","yz"}}})
  n=n+1
end
-- case 467: int16 + S3, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int16"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=1})
  verify(r,"S6",{{{"-3"},{"17"}},{{"x"},{"yz"}}})
  n=n+1
end
-- case 468: int16 + S3, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int16"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=-1})
  verify(r,"S6",{{{"-3","x"}},{{"17","yz"}}})
  n=n+1
end
-- case 469: int16 + S3, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({-3,17},"int16"),{2})},{axis=1})
  verify(r,"S6",{"x","yz","-3","17"})
  n=n+1
end
-- case 470: int16 + S3, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({-3,17},"int16"),{2})},{axis=-1})
  verify(r,"S6",{"x","yz","-3","17"})
  n=n+1
end
-- case 471: int16 + S3, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({-3,17},"int16"),{1,2})},{axis=1})
  verify(r,"S6",{{"x","yz"},{"-3","17"}})
  n=n+1
end
-- case 472: int16 + S3, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({-3,17},"int16"),{1,2})},{axis=-1})
  verify(r,"S6",{{"x","yz","-3","17"}})
  n=n+1
end
-- case 473: int16 + S3, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({-3,17},"int16"),{2,1})},{axis=1})
  verify(r,"S6",{{"x"},{"yz"},{"-3"},{"17"}})
  n=n+1
end
-- case 474: int16 + S3, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({-3,17},"int16"),{2,1})},{axis=-1})
  verify(r,"S6",{{"x","-3"},{"yz","17"}})
  n=n+1
end
-- case 475: int16 + S3, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({-3,17},"int16"),{2})},{axis=1})
  verify(r,"S6",{{"x","yz"},{"-3","17"}})
  n=n+1
end
-- case 476: int16 + S3, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({-3,17},"int16"),{2})},{axis=-1})
  verify(r,"S6",{{"x","-3"},{"yz","17"}})
  n=n+1
end
-- case 477: int16 + S3, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({-3,17},"int16"),{1,2})},{axis=1})
  verify(r,"S6",{{{"x","yz"}},{{"-3","17"}}})
  n=n+1
end
-- case 478: int16 + S3, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({-3,17},"int16"),{1,2})},{axis=-1})
  verify(r,"S6",{{{"x","-3"},{"yz","17"}}})
  n=n+1
end
-- case 479: int16 + S3, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({-3,17},"int16"),{2,1})},{axis=1})
  verify(r,"S6",{{{"x"},{"yz"}},{{"-3"},{"17"}}})
  n=n+1
end
-- case 480: int16 + S3, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({-3,17},"int16"),{2,1})},{axis=-1})
  verify(r,"S6",{{{"x","-3"}},{{"yz","17"}}})
  n=n+1
end
-- case 481: int16 + S8, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int16"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=1})
  verify(r,"S8",{"-3","17","x","yz"})
  n=n+1
end
-- case 482: int16 + S8, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int16"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=-1})
  verify(r,"S8",{"-3","17","x","yz"})
  n=n+1
end
-- case 483: int16 + S8, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int16"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=1})
  verify(r,"S8",{{"-3","17"},{"x","yz"}})
  n=n+1
end
-- case 484: int16 + S8, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int16"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=-1})
  verify(r,"S8",{{"-3","17","x","yz"}})
  n=n+1
end
-- case 485: int16 + S8, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int16"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=1})
  verify(r,"S8",{{"-3"},{"17"},{"x"},{"yz"}})
  n=n+1
end
-- case 486: int16 + S8, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int16"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=-1})
  verify(r,"S8",{{"-3","x"},{"17","yz"}})
  n=n+1
end
-- case 487: int16 + S8, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int16"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=1})
  verify(r,"S8",{{"-3","17"},{"x","yz"}})
  n=n+1
end
-- case 488: int16 + S8, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int16"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=-1})
  verify(r,"S8",{{"-3","x"},{"17","yz"}})
  n=n+1
end
-- case 489: int16 + S8, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int16"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=1})
  verify(r,"S8",{{{"-3","17"}},{{"x","yz"}}})
  n=n+1
end
-- case 490: int16 + S8, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int16"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=-1})
  verify(r,"S8",{{{"-3","x"},{"17","yz"}}})
  n=n+1
end
-- case 491: int16 + S8, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int16"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=1})
  verify(r,"S8",{{{"-3"},{"17"}},{{"x"},{"yz"}}})
  n=n+1
end
-- case 492: int16 + S8, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int16"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=-1})
  verify(r,"S8",{{{"-3","x"}},{{"17","yz"}}})
  n=n+1
end
-- case 493: int16 + S8, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({-3,17},"int16"),{2})},{axis=1})
  verify(r,"S8",{"x","yz","-3","17"})
  n=n+1
end
-- case 494: int16 + S8, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({-3,17},"int16"),{2})},{axis=-1})
  verify(r,"S8",{"x","yz","-3","17"})
  n=n+1
end
-- case 495: int16 + S8, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({-3,17},"int16"),{1,2})},{axis=1})
  verify(r,"S8",{{"x","yz"},{"-3","17"}})
  n=n+1
end
-- case 496: int16 + S8, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({-3,17},"int16"),{1,2})},{axis=-1})
  verify(r,"S8",{{"x","yz","-3","17"}})
  n=n+1
end
-- case 497: int16 + S8, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({-3,17},"int16"),{2,1})},{axis=1})
  verify(r,"S8",{{"x"},{"yz"},{"-3"},{"17"}})
  n=n+1
end
-- case 498: int16 + S8, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({-3,17},"int16"),{2,1})},{axis=-1})
  verify(r,"S8",{{"x","-3"},{"yz","17"}})
  n=n+1
end
-- case 499: int16 + S8, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({-3,17},"int16"),{2})},{axis=1})
  verify(r,"S8",{{"x","yz"},{"-3","17"}})
  n=n+1
end
-- case 500: int16 + S8, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({-3,17},"int16"),{2})},{axis=-1})
  verify(r,"S8",{{"x","-3"},{"yz","17"}})
  n=n+1
end
-- case 501: int16 + S8, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({-3,17},"int16"),{1,2})},{axis=1})
  verify(r,"S8",{{{"x","yz"}},{{"-3","17"}}})
  n=n+1
end
-- case 502: int16 + S8, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({-3,17},"int16"),{1,2})},{axis=-1})
  verify(r,"S8",{{{"x","-3"},{"yz","17"}}})
  n=n+1
end
-- case 503: int16 + S8, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({-3,17},"int16"),{2,1})},{axis=1})
  verify(r,"S8",{{{"x"},{"yz"}},{{"-3"},{"17"}}})
  n=n+1
end
-- case 504: int16 + S8, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({-3,17},"int16"),{2,1})},{axis=-1})
  verify(r,"S8",{{{"x","-3"}},{{"yz","17"}}})
  n=n+1
end
-- case 505: int16 + U1, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int16"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=1})
  verify(r,"U6",{"-3","17","x","é"})
  n=n+1
end
-- case 506: int16 + U1, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int16"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=-1})
  verify(r,"U6",{"-3","17","x","é"})
  n=n+1
end
-- case 507: int16 + U1, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int16"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=1})
  verify(r,"U6",{{"-3","17"},{"x","é"}})
  n=n+1
end
-- case 508: int16 + U1, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int16"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=-1})
  verify(r,"U6",{{"-3","17","x","é"}})
  n=n+1
end
-- case 509: int16 + U1, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int16"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=1})
  verify(r,"U6",{{"-3"},{"17"},{"x"},{"é"}})
  n=n+1
end
-- case 510: int16 + U1, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int16"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=-1})
  verify(r,"U6",{{"-3","x"},{"17","é"}})
  n=n+1
end
-- case 511: int16 + U1, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int16"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=1})
  verify(r,"U6",{{"-3","17"},{"x","é"}})
  n=n+1
end
-- case 512: int16 + U1, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int16"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=-1})
  verify(r,"U6",{{"-3","x"},{"17","é"}})
  n=n+1
end
-- case 513: int16 + U1, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int16"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=1})
  verify(r,"U6",{{{"-3","17"}},{{"x","é"}}})
  n=n+1
end
-- case 514: int16 + U1, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int16"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=-1})
  verify(r,"U6",{{{"-3","x"},{"17","é"}}})
  n=n+1
end
-- case 515: int16 + U1, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int16"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=1})
  verify(r,"U6",{{{"-3"},{"17"}},{{"x"},{"é"}}})
  n=n+1
end
-- case 516: int16 + U1, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int16"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=-1})
  verify(r,"U6",{{{"-3","x"}},{{"17","é"}}})
  n=n+1
end
-- case 517: int16 + U1, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({-3,17},"int16"),{2})},{axis=1})
  verify(r,"U6",{"x","é","-3","17"})
  n=n+1
end
-- case 518: int16 + U1, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({-3,17},"int16"),{2})},{axis=-1})
  verify(r,"U6",{"x","é","-3","17"})
  n=n+1
end
-- case 519: int16 + U1, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({-3,17},"int16"),{1,2})},{axis=1})
  verify(r,"U6",{{"x","é"},{"-3","17"}})
  n=n+1
end
-- case 520: int16 + U1, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({-3,17},"int16"),{1,2})},{axis=-1})
  verify(r,"U6",{{"x","é","-3","17"}})
  n=n+1
end
-- case 521: int16 + U1, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({-3,17},"int16"),{2,1})},{axis=1})
  verify(r,"U6",{{"x"},{"é"},{"-3"},{"17"}})
  n=n+1
end
-- case 522: int16 + U1, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({-3,17},"int16"),{2,1})},{axis=-1})
  verify(r,"U6",{{"x","-3"},{"é","17"}})
  n=n+1
end
-- case 523: int16 + U1, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({-3,17},"int16"),{2})},{axis=1})
  verify(r,"U6",{{"x","é"},{"-3","17"}})
  n=n+1
end
-- case 524: int16 + U1, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({-3,17},"int16"),{2})},{axis=-1})
  verify(r,"U6",{{"x","-3"},{"é","17"}})
  n=n+1
end
-- case 525: int16 + U1, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({-3,17},"int16"),{1,2})},{axis=1})
  verify(r,"U6",{{{"x","é"}},{{"-3","17"}}})
  n=n+1
end
-- case 526: int16 + U1, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({-3,17},"int16"),{1,2})},{axis=-1})
  verify(r,"U6",{{{"x","-3"},{"é","17"}}})
  n=n+1
end
-- case 527: int16 + U1, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({-3,17},"int16"),{2,1})},{axis=1})
  verify(r,"U6",{{{"x"},{"é"}},{{"-3"},{"17"}}})
  n=n+1
end
-- case 528: int16 + U1, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({-3,17},"int16"),{2,1})},{axis=-1})
  verify(r,"U6",{{{"x","-3"}},{{"é","17"}}})
  n=n+1
end
-- case 529: int16 + U3, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int16"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=1})
  verify(r,"U6",{"-3","17","x","é"})
  n=n+1
end
-- case 530: int16 + U3, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int16"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=-1})
  verify(r,"U6",{"-3","17","x","é"})
  n=n+1
end
-- case 531: int16 + U3, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int16"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=1})
  verify(r,"U6",{{"-3","17"},{"x","é"}})
  n=n+1
end
-- case 532: int16 + U3, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int16"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=-1})
  verify(r,"U6",{{"-3","17","x","é"}})
  n=n+1
end
-- case 533: int16 + U3, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int16"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=1})
  verify(r,"U6",{{"-3"},{"17"},{"x"},{"é"}})
  n=n+1
end
-- case 534: int16 + U3, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int16"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=-1})
  verify(r,"U6",{{"-3","x"},{"17","é"}})
  n=n+1
end
-- case 535: int16 + U3, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int16"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=1})
  verify(r,"U6",{{"-3","17"},{"x","é"}})
  n=n+1
end
-- case 536: int16 + U3, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int16"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=-1})
  verify(r,"U6",{{"-3","x"},{"17","é"}})
  n=n+1
end
-- case 537: int16 + U3, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int16"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=1})
  verify(r,"U6",{{{"-3","17"}},{{"x","é"}}})
  n=n+1
end
-- case 538: int16 + U3, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int16"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=-1})
  verify(r,"U6",{{{"-3","x"},{"17","é"}}})
  n=n+1
end
-- case 539: int16 + U3, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int16"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=1})
  verify(r,"U6",{{{"-3"},{"17"}},{{"x"},{"é"}}})
  n=n+1
end
-- case 540: int16 + U3, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int16"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=-1})
  verify(r,"U6",{{{"-3","x"}},{{"17","é"}}})
  n=n+1
end
-- case 541: int16 + U3, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({-3,17},"int16"),{2})},{axis=1})
  verify(r,"U6",{"x","é","-3","17"})
  n=n+1
end
-- case 542: int16 + U3, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({-3,17},"int16"),{2})},{axis=-1})
  verify(r,"U6",{"x","é","-3","17"})
  n=n+1
end
-- case 543: int16 + U3, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({-3,17},"int16"),{1,2})},{axis=1})
  verify(r,"U6",{{"x","é"},{"-3","17"}})
  n=n+1
end
-- case 544: int16 + U3, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({-3,17},"int16"),{1,2})},{axis=-1})
  verify(r,"U6",{{"x","é","-3","17"}})
  n=n+1
end
-- case 545: int16 + U3, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({-3,17},"int16"),{2,1})},{axis=1})
  verify(r,"U6",{{"x"},{"é"},{"-3"},{"17"}})
  n=n+1
end
-- case 546: int16 + U3, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({-3,17},"int16"),{2,1})},{axis=-1})
  verify(r,"U6",{{"x","-3"},{"é","17"}})
  n=n+1
end
-- case 547: int16 + U3, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({-3,17},"int16"),{2})},{axis=1})
  verify(r,"U6",{{"x","é"},{"-3","17"}})
  n=n+1
end
-- case 548: int16 + U3, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({-3,17},"int16"),{2})},{axis=-1})
  verify(r,"U6",{{"x","-3"},{"é","17"}})
  n=n+1
end
-- case 549: int16 + U3, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({-3,17},"int16"),{1,2})},{axis=1})
  verify(r,"U6",{{{"x","é"}},{{"-3","17"}}})
  n=n+1
end
-- case 550: int16 + U3, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({-3,17},"int16"),{1,2})},{axis=-1})
  verify(r,"U6",{{{"x","-3"},{"é","17"}}})
  n=n+1
end
-- case 551: int16 + U3, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({-3,17},"int16"),{2,1})},{axis=1})
  verify(r,"U6",{{{"x"},{"é"}},{{"-3"},{"17"}}})
  n=n+1
end
-- case 552: int16 + U3, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({-3,17},"int16"),{2,1})},{axis=-1})
  verify(r,"U6",{{{"x","-3"}},{{"é","17"}}})
  n=n+1
end
-- case 553: int16 + U8, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int16"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=1})
  verify(r,"U8",{"-3","17","x","é"})
  n=n+1
end
-- case 554: int16 + U8, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int16"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=-1})
  verify(r,"U8",{"-3","17","x","é"})
  n=n+1
end
-- case 555: int16 + U8, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int16"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=1})
  verify(r,"U8",{{"-3","17"},{"x","é"}})
  n=n+1
end
-- case 556: int16 + U8, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int16"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=-1})
  verify(r,"U8",{{"-3","17","x","é"}})
  n=n+1
end
-- case 557: int16 + U8, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int16"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=1})
  verify(r,"U8",{{"-3"},{"17"},{"x"},{"é"}})
  n=n+1
end
-- case 558: int16 + U8, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int16"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=-1})
  verify(r,"U8",{{"-3","x"},{"17","é"}})
  n=n+1
end
-- case 559: int16 + U8, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int16"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=1})
  verify(r,"U8",{{"-3","17"},{"x","é"}})
  n=n+1
end
-- case 560: int16 + U8, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int16"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=-1})
  verify(r,"U8",{{"-3","x"},{"17","é"}})
  n=n+1
end
-- case 561: int16 + U8, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int16"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=1})
  verify(r,"U8",{{{"-3","17"}},{{"x","é"}}})
  n=n+1
end
-- case 562: int16 + U8, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int16"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=-1})
  verify(r,"U8",{{{"-3","x"},{"17","é"}}})
  n=n+1
end
-- case 563: int16 + U8, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int16"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=1})
  verify(r,"U8",{{{"-3"},{"17"}},{{"x"},{"é"}}})
  n=n+1
end
-- case 564: int16 + U8, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int16"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=-1})
  verify(r,"U8",{{{"-3","x"}},{{"17","é"}}})
  n=n+1
end
-- case 565: int16 + U8, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({-3,17},"int16"),{2})},{axis=1})
  verify(r,"U8",{"x","é","-3","17"})
  n=n+1
end
-- case 566: int16 + U8, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({-3,17},"int16"),{2})},{axis=-1})
  verify(r,"U8",{"x","é","-3","17"})
  n=n+1
end
-- case 567: int16 + U8, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({-3,17},"int16"),{1,2})},{axis=1})
  verify(r,"U8",{{"x","é"},{"-3","17"}})
  n=n+1
end
-- case 568: int16 + U8, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({-3,17},"int16"),{1,2})},{axis=-1})
  verify(r,"U8",{{"x","é","-3","17"}})
  n=n+1
end
-- case 569: int16 + U8, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({-3,17},"int16"),{2,1})},{axis=1})
  verify(r,"U8",{{"x"},{"é"},{"-3"},{"17"}})
  n=n+1
end
-- case 570: int16 + U8, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({-3,17},"int16"),{2,1})},{axis=-1})
  verify(r,"U8",{{"x","-3"},{"é","17"}})
  n=n+1
end
-- case 571: int16 + U8, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({-3,17},"int16"),{2})},{axis=1})
  verify(r,"U8",{{"x","é"},{"-3","17"}})
  n=n+1
end
-- case 572: int16 + U8, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({-3,17},"int16"),{2})},{axis=-1})
  verify(r,"U8",{{"x","-3"},{"é","17"}})
  n=n+1
end
-- case 573: int16 + U8, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({-3,17},"int16"),{1,2})},{axis=1})
  verify(r,"U8",{{{"x","é"}},{{"-3","17"}}})
  n=n+1
end
-- case 574: int16 + U8, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({-3,17},"int16"),{1,2})},{axis=-1})
  verify(r,"U8",{{{"x","-3"},{"é","17"}}})
  n=n+1
end
-- case 575: int16 + U8, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({-3,17},"int16"),{2,1})},{axis=1})
  verify(r,"U8",{{{"x"},{"é"}},{{"-3"},{"17"}}})
  n=n+1
end
-- case 576: int16 + U8, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({-3,17},"int16"),{2,1})},{axis=-1})
  verify(r,"U8",{{{"x","-3"}},{{"é","17"}}})
  n=n+1
end
-- case 577: uint16 + S1, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint16"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=1})
  verify(r,"S5",{"3","17","x","y"})
  n=n+1
end
-- case 578: uint16 + S1, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint16"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=-1})
  verify(r,"S5",{"3","17","x","y"})
  n=n+1
end
-- case 579: uint16 + S1, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint16"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=1})
  verify(r,"S5",{{"3","17"},{"x","y"}})
  n=n+1
end
-- case 580: uint16 + S1, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint16"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=-1})
  verify(r,"S5",{{"3","17","x","y"}})
  n=n+1
end
-- case 581: uint16 + S1, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint16"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=1})
  verify(r,"S5",{{"3"},{"17"},{"x"},{"y"}})
  n=n+1
end
-- case 582: uint16 + S1, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint16"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=-1})
  verify(r,"S5",{{"3","x"},{"17","y"}})
  n=n+1
end
-- case 583: uint16 + S1, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint16"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=1})
  verify(r,"S5",{{"3","17"},{"x","y"}})
  n=n+1
end
-- case 584: uint16 + S1, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint16"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=-1})
  verify(r,"S5",{{"3","x"},{"17","y"}})
  n=n+1
end
-- case 585: uint16 + S1, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint16"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=1})
  verify(r,"S5",{{{"3","17"}},{{"x","y"}}})
  n=n+1
end
-- case 586: uint16 + S1, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint16"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=-1})
  verify(r,"S5",{{{"3","x"},{"17","y"}}})
  n=n+1
end
-- case 587: uint16 + S1, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint16"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=1})
  verify(r,"S5",{{{"3"},{"17"}},{{"x"},{"y"}}})
  n=n+1
end
-- case 588: uint16 + S1, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint16"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=-1})
  verify(r,"S5",{{{"3","x"}},{{"17","y"}}})
  n=n+1
end
-- case 589: uint16 + S1, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({3,17},"uint16"),{2})},{axis=1})
  verify(r,"S5",{"x","y","3","17"})
  n=n+1
end
-- case 590: uint16 + S1, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({3,17},"uint16"),{2})},{axis=-1})
  verify(r,"S5",{"x","y","3","17"})
  n=n+1
end
-- case 591: uint16 + S1, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({3,17},"uint16"),{1,2})},{axis=1})
  verify(r,"S5",{{"x","y"},{"3","17"}})
  n=n+1
end
-- case 592: uint16 + S1, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({3,17},"uint16"),{1,2})},{axis=-1})
  verify(r,"S5",{{"x","y","3","17"}})
  n=n+1
end
-- case 593: uint16 + S1, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({3,17},"uint16"),{2,1})},{axis=1})
  verify(r,"S5",{{"x"},{"y"},{"3"},{"17"}})
  n=n+1
end
-- case 594: uint16 + S1, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({3,17},"uint16"),{2,1})},{axis=-1})
  verify(r,"S5",{{"x","3"},{"y","17"}})
  n=n+1
end
-- case 595: uint16 + S1, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({3,17},"uint16"),{2})},{axis=1})
  verify(r,"S5",{{"x","y"},{"3","17"}})
  n=n+1
end
-- case 596: uint16 + S1, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({3,17},"uint16"),{2})},{axis=-1})
  verify(r,"S5",{{"x","3"},{"y","17"}})
  n=n+1
end
-- case 597: uint16 + S1, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({3,17},"uint16"),{1,2})},{axis=1})
  verify(r,"S5",{{{"x","y"}},{{"3","17"}}})
  n=n+1
end
-- case 598: uint16 + S1, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({3,17},"uint16"),{1,2})},{axis=-1})
  verify(r,"S5",{{{"x","3"},{"y","17"}}})
  n=n+1
end
-- case 599: uint16 + S1, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({3,17},"uint16"),{2,1})},{axis=1})
  verify(r,"S5",{{{"x"},{"y"}},{{"3"},{"17"}}})
  n=n+1
end
-- case 600: uint16 + S1, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({3,17},"uint16"),{2,1})},{axis=-1})
  verify(r,"S5",{{{"x","3"}},{{"y","17"}}})
  n=n+1
end
-- case 601: uint16 + S3, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint16"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=1})
  verify(r,"S5",{"3","17","x","yz"})
  n=n+1
end
-- case 602: uint16 + S3, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint16"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=-1})
  verify(r,"S5",{"3","17","x","yz"})
  n=n+1
end
-- case 603: uint16 + S3, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint16"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=1})
  verify(r,"S5",{{"3","17"},{"x","yz"}})
  n=n+1
end
-- case 604: uint16 + S3, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint16"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=-1})
  verify(r,"S5",{{"3","17","x","yz"}})
  n=n+1
end
-- case 605: uint16 + S3, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint16"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=1})
  verify(r,"S5",{{"3"},{"17"},{"x"},{"yz"}})
  n=n+1
end
-- case 606: uint16 + S3, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint16"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=-1})
  verify(r,"S5",{{"3","x"},{"17","yz"}})
  n=n+1
end
-- case 607: uint16 + S3, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint16"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=1})
  verify(r,"S5",{{"3","17"},{"x","yz"}})
  n=n+1
end
-- case 608: uint16 + S3, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint16"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=-1})
  verify(r,"S5",{{"3","x"},{"17","yz"}})
  n=n+1
end
-- case 609: uint16 + S3, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint16"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=1})
  verify(r,"S5",{{{"3","17"}},{{"x","yz"}}})
  n=n+1
end
-- case 610: uint16 + S3, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint16"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=-1})
  verify(r,"S5",{{{"3","x"},{"17","yz"}}})
  n=n+1
end
-- case 611: uint16 + S3, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint16"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=1})
  verify(r,"S5",{{{"3"},{"17"}},{{"x"},{"yz"}}})
  n=n+1
end
-- case 612: uint16 + S3, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint16"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=-1})
  verify(r,"S5",{{{"3","x"}},{{"17","yz"}}})
  n=n+1
end
-- case 613: uint16 + S3, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({3,17},"uint16"),{2})},{axis=1})
  verify(r,"S5",{"x","yz","3","17"})
  n=n+1
end
-- case 614: uint16 + S3, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({3,17},"uint16"),{2})},{axis=-1})
  verify(r,"S5",{"x","yz","3","17"})
  n=n+1
end
-- case 615: uint16 + S3, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({3,17},"uint16"),{1,2})},{axis=1})
  verify(r,"S5",{{"x","yz"},{"3","17"}})
  n=n+1
end
-- case 616: uint16 + S3, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({3,17},"uint16"),{1,2})},{axis=-1})
  verify(r,"S5",{{"x","yz","3","17"}})
  n=n+1
end
-- case 617: uint16 + S3, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({3,17},"uint16"),{2,1})},{axis=1})
  verify(r,"S5",{{"x"},{"yz"},{"3"},{"17"}})
  n=n+1
end
-- case 618: uint16 + S3, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({3,17},"uint16"),{2,1})},{axis=-1})
  verify(r,"S5",{{"x","3"},{"yz","17"}})
  n=n+1
end
-- case 619: uint16 + S3, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({3,17},"uint16"),{2})},{axis=1})
  verify(r,"S5",{{"x","yz"},{"3","17"}})
  n=n+1
end
-- case 620: uint16 + S3, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({3,17},"uint16"),{2})},{axis=-1})
  verify(r,"S5",{{"x","3"},{"yz","17"}})
  n=n+1
end
-- case 621: uint16 + S3, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({3,17},"uint16"),{1,2})},{axis=1})
  verify(r,"S5",{{{"x","yz"}},{{"3","17"}}})
  n=n+1
end
-- case 622: uint16 + S3, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({3,17},"uint16"),{1,2})},{axis=-1})
  verify(r,"S5",{{{"x","3"},{"yz","17"}}})
  n=n+1
end
-- case 623: uint16 + S3, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({3,17},"uint16"),{2,1})},{axis=1})
  verify(r,"S5",{{{"x"},{"yz"}},{{"3"},{"17"}}})
  n=n+1
end
-- case 624: uint16 + S3, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({3,17},"uint16"),{2,1})},{axis=-1})
  verify(r,"S5",{{{"x","3"}},{{"yz","17"}}})
  n=n+1
end
-- case 625: uint16 + S8, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint16"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=1})
  verify(r,"S8",{"3","17","x","yz"})
  n=n+1
end
-- case 626: uint16 + S8, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint16"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=-1})
  verify(r,"S8",{"3","17","x","yz"})
  n=n+1
end
-- case 627: uint16 + S8, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint16"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=1})
  verify(r,"S8",{{"3","17"},{"x","yz"}})
  n=n+1
end
-- case 628: uint16 + S8, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint16"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=-1})
  verify(r,"S8",{{"3","17","x","yz"}})
  n=n+1
end
-- case 629: uint16 + S8, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint16"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=1})
  verify(r,"S8",{{"3"},{"17"},{"x"},{"yz"}})
  n=n+1
end
-- case 630: uint16 + S8, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint16"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=-1})
  verify(r,"S8",{{"3","x"},{"17","yz"}})
  n=n+1
end
-- case 631: uint16 + S8, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint16"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=1})
  verify(r,"S8",{{"3","17"},{"x","yz"}})
  n=n+1
end
-- case 632: uint16 + S8, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint16"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=-1})
  verify(r,"S8",{{"3","x"},{"17","yz"}})
  n=n+1
end
-- case 633: uint16 + S8, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint16"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=1})
  verify(r,"S8",{{{"3","17"}},{{"x","yz"}}})
  n=n+1
end
-- case 634: uint16 + S8, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint16"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=-1})
  verify(r,"S8",{{{"3","x"},{"17","yz"}}})
  n=n+1
end
-- case 635: uint16 + S8, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint16"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=1})
  verify(r,"S8",{{{"3"},{"17"}},{{"x"},{"yz"}}})
  n=n+1
end
-- case 636: uint16 + S8, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint16"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=-1})
  verify(r,"S8",{{{"3","x"}},{{"17","yz"}}})
  n=n+1
end
-- case 637: uint16 + S8, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({3,17},"uint16"),{2})},{axis=1})
  verify(r,"S8",{"x","yz","3","17"})
  n=n+1
end
-- case 638: uint16 + S8, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({3,17},"uint16"),{2})},{axis=-1})
  verify(r,"S8",{"x","yz","3","17"})
  n=n+1
end
-- case 639: uint16 + S8, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({3,17},"uint16"),{1,2})},{axis=1})
  verify(r,"S8",{{"x","yz"},{"3","17"}})
  n=n+1
end
-- case 640: uint16 + S8, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({3,17},"uint16"),{1,2})},{axis=-1})
  verify(r,"S8",{{"x","yz","3","17"}})
  n=n+1
end
-- case 641: uint16 + S8, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({3,17},"uint16"),{2,1})},{axis=1})
  verify(r,"S8",{{"x"},{"yz"},{"3"},{"17"}})
  n=n+1
end
-- case 642: uint16 + S8, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({3,17},"uint16"),{2,1})},{axis=-1})
  verify(r,"S8",{{"x","3"},{"yz","17"}})
  n=n+1
end
-- case 643: uint16 + S8, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({3,17},"uint16"),{2})},{axis=1})
  verify(r,"S8",{{"x","yz"},{"3","17"}})
  n=n+1
end
-- case 644: uint16 + S8, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({3,17},"uint16"),{2})},{axis=-1})
  verify(r,"S8",{{"x","3"},{"yz","17"}})
  n=n+1
end
-- case 645: uint16 + S8, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({3,17},"uint16"),{1,2})},{axis=1})
  verify(r,"S8",{{{"x","yz"}},{{"3","17"}}})
  n=n+1
end
-- case 646: uint16 + S8, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({3,17},"uint16"),{1,2})},{axis=-1})
  verify(r,"S8",{{{"x","3"},{"yz","17"}}})
  n=n+1
end
-- case 647: uint16 + S8, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({3,17},"uint16"),{2,1})},{axis=1})
  verify(r,"S8",{{{"x"},{"yz"}},{{"3"},{"17"}}})
  n=n+1
end
-- case 648: uint16 + S8, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({3,17},"uint16"),{2,1})},{axis=-1})
  verify(r,"S8",{{{"x","3"}},{{"yz","17"}}})
  n=n+1
end
-- case 649: uint16 + U1, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint16"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=1})
  verify(r,"U5",{"3","17","x","é"})
  n=n+1
end
-- case 650: uint16 + U1, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint16"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=-1})
  verify(r,"U5",{"3","17","x","é"})
  n=n+1
end
-- case 651: uint16 + U1, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint16"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=1})
  verify(r,"U5",{{"3","17"},{"x","é"}})
  n=n+1
end
-- case 652: uint16 + U1, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint16"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=-1})
  verify(r,"U5",{{"3","17","x","é"}})
  n=n+1
end
-- case 653: uint16 + U1, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint16"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=1})
  verify(r,"U5",{{"3"},{"17"},{"x"},{"é"}})
  n=n+1
end
-- case 654: uint16 + U1, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint16"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=-1})
  verify(r,"U5",{{"3","x"},{"17","é"}})
  n=n+1
end
-- case 655: uint16 + U1, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint16"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=1})
  verify(r,"U5",{{"3","17"},{"x","é"}})
  n=n+1
end
-- case 656: uint16 + U1, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint16"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=-1})
  verify(r,"U5",{{"3","x"},{"17","é"}})
  n=n+1
end
-- case 657: uint16 + U1, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint16"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=1})
  verify(r,"U5",{{{"3","17"}},{{"x","é"}}})
  n=n+1
end
-- case 658: uint16 + U1, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint16"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=-1})
  verify(r,"U5",{{{"3","x"},{"17","é"}}})
  n=n+1
end
-- case 659: uint16 + U1, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint16"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=1})
  verify(r,"U5",{{{"3"},{"17"}},{{"x"},{"é"}}})
  n=n+1
end
-- case 660: uint16 + U1, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint16"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=-1})
  verify(r,"U5",{{{"3","x"}},{{"17","é"}}})
  n=n+1
end
-- case 661: uint16 + U1, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({3,17},"uint16"),{2})},{axis=1})
  verify(r,"U5",{"x","é","3","17"})
  n=n+1
end
-- case 662: uint16 + U1, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({3,17},"uint16"),{2})},{axis=-1})
  verify(r,"U5",{"x","é","3","17"})
  n=n+1
end
-- case 663: uint16 + U1, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({3,17},"uint16"),{1,2})},{axis=1})
  verify(r,"U5",{{"x","é"},{"3","17"}})
  n=n+1
end
-- case 664: uint16 + U1, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({3,17},"uint16"),{1,2})},{axis=-1})
  verify(r,"U5",{{"x","é","3","17"}})
  n=n+1
end
-- case 665: uint16 + U1, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({3,17},"uint16"),{2,1})},{axis=1})
  verify(r,"U5",{{"x"},{"é"},{"3"},{"17"}})
  n=n+1
end
-- case 666: uint16 + U1, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({3,17},"uint16"),{2,1})},{axis=-1})
  verify(r,"U5",{{"x","3"},{"é","17"}})
  n=n+1
end
-- case 667: uint16 + U1, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({3,17},"uint16"),{2})},{axis=1})
  verify(r,"U5",{{"x","é"},{"3","17"}})
  n=n+1
end
-- case 668: uint16 + U1, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({3,17},"uint16"),{2})},{axis=-1})
  verify(r,"U5",{{"x","3"},{"é","17"}})
  n=n+1
end
-- case 669: uint16 + U1, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({3,17},"uint16"),{1,2})},{axis=1})
  verify(r,"U5",{{{"x","é"}},{{"3","17"}}})
  n=n+1
end
-- case 670: uint16 + U1, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({3,17},"uint16"),{1,2})},{axis=-1})
  verify(r,"U5",{{{"x","3"},{"é","17"}}})
  n=n+1
end
-- case 671: uint16 + U1, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({3,17},"uint16"),{2,1})},{axis=1})
  verify(r,"U5",{{{"x"},{"é"}},{{"3"},{"17"}}})
  n=n+1
end
-- case 672: uint16 + U1, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({3,17},"uint16"),{2,1})},{axis=-1})
  verify(r,"U5",{{{"x","3"}},{{"é","17"}}})
  n=n+1
end
-- case 673: uint16 + U3, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint16"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=1})
  verify(r,"U5",{"3","17","x","é"})
  n=n+1
end
-- case 674: uint16 + U3, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint16"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=-1})
  verify(r,"U5",{"3","17","x","é"})
  n=n+1
end
-- case 675: uint16 + U3, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint16"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=1})
  verify(r,"U5",{{"3","17"},{"x","é"}})
  n=n+1
end
-- case 676: uint16 + U3, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint16"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=-1})
  verify(r,"U5",{{"3","17","x","é"}})
  n=n+1
end
-- case 677: uint16 + U3, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint16"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=1})
  verify(r,"U5",{{"3"},{"17"},{"x"},{"é"}})
  n=n+1
end
-- case 678: uint16 + U3, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint16"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=-1})
  verify(r,"U5",{{"3","x"},{"17","é"}})
  n=n+1
end
-- case 679: uint16 + U3, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint16"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=1})
  verify(r,"U5",{{"3","17"},{"x","é"}})
  n=n+1
end
-- case 680: uint16 + U3, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint16"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=-1})
  verify(r,"U5",{{"3","x"},{"17","é"}})
  n=n+1
end
-- case 681: uint16 + U3, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint16"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=1})
  verify(r,"U5",{{{"3","17"}},{{"x","é"}}})
  n=n+1
end
-- case 682: uint16 + U3, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint16"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=-1})
  verify(r,"U5",{{{"3","x"},{"17","é"}}})
  n=n+1
end
-- case 683: uint16 + U3, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint16"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=1})
  verify(r,"U5",{{{"3"},{"17"}},{{"x"},{"é"}}})
  n=n+1
end
-- case 684: uint16 + U3, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint16"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=-1})
  verify(r,"U5",{{{"3","x"}},{{"17","é"}}})
  n=n+1
end
-- case 685: uint16 + U3, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({3,17},"uint16"),{2})},{axis=1})
  verify(r,"U5",{"x","é","3","17"})
  n=n+1
end
-- case 686: uint16 + U3, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({3,17},"uint16"),{2})},{axis=-1})
  verify(r,"U5",{"x","é","3","17"})
  n=n+1
end
-- case 687: uint16 + U3, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({3,17},"uint16"),{1,2})},{axis=1})
  verify(r,"U5",{{"x","é"},{"3","17"}})
  n=n+1
end
-- case 688: uint16 + U3, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({3,17},"uint16"),{1,2})},{axis=-1})
  verify(r,"U5",{{"x","é","3","17"}})
  n=n+1
end
-- case 689: uint16 + U3, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({3,17},"uint16"),{2,1})},{axis=1})
  verify(r,"U5",{{"x"},{"é"},{"3"},{"17"}})
  n=n+1
end
-- case 690: uint16 + U3, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({3,17},"uint16"),{2,1})},{axis=-1})
  verify(r,"U5",{{"x","3"},{"é","17"}})
  n=n+1
end
-- case 691: uint16 + U3, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({3,17},"uint16"),{2})},{axis=1})
  verify(r,"U5",{{"x","é"},{"3","17"}})
  n=n+1
end
-- case 692: uint16 + U3, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({3,17},"uint16"),{2})},{axis=-1})
  verify(r,"U5",{{"x","3"},{"é","17"}})
  n=n+1
end
-- case 693: uint16 + U3, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({3,17},"uint16"),{1,2})},{axis=1})
  verify(r,"U5",{{{"x","é"}},{{"3","17"}}})
  n=n+1
end
-- case 694: uint16 + U3, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({3,17},"uint16"),{1,2})},{axis=-1})
  verify(r,"U5",{{{"x","3"},{"é","17"}}})
  n=n+1
end
-- case 695: uint16 + U3, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({3,17},"uint16"),{2,1})},{axis=1})
  verify(r,"U5",{{{"x"},{"é"}},{{"3"},{"17"}}})
  n=n+1
end
-- case 696: uint16 + U3, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({3,17},"uint16"),{2,1})},{axis=-1})
  verify(r,"U5",{{{"x","3"}},{{"é","17"}}})
  n=n+1
end
-- case 697: uint16 + U8, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint16"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=1})
  verify(r,"U8",{"3","17","x","é"})
  n=n+1
end
-- case 698: uint16 + U8, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint16"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=-1})
  verify(r,"U8",{"3","17","x","é"})
  n=n+1
end
-- case 699: uint16 + U8, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint16"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=1})
  verify(r,"U8",{{"3","17"},{"x","é"}})
  n=n+1
end
-- case 700: uint16 + U8, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint16"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=-1})
  verify(r,"U8",{{"3","17","x","é"}})
  n=n+1
end
-- case 701: uint16 + U8, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint16"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=1})
  verify(r,"U8",{{"3"},{"17"},{"x"},{"é"}})
  n=n+1
end
-- case 702: uint16 + U8, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint16"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=-1})
  verify(r,"U8",{{"3","x"},{"17","é"}})
  n=n+1
end
-- case 703: uint16 + U8, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint16"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=1})
  verify(r,"U8",{{"3","17"},{"x","é"}})
  n=n+1
end
-- case 704: uint16 + U8, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint16"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=-1})
  verify(r,"U8",{{"3","x"},{"17","é"}})
  n=n+1
end
-- case 705: uint16 + U8, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint16"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=1})
  verify(r,"U8",{{{"3","17"}},{{"x","é"}}})
  n=n+1
end
-- case 706: uint16 + U8, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint16"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=-1})
  verify(r,"U8",{{{"3","x"},{"17","é"}}})
  n=n+1
end
-- case 707: uint16 + U8, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint16"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=1})
  verify(r,"U8",{{{"3"},{"17"}},{{"x"},{"é"}}})
  n=n+1
end
-- case 708: uint16 + U8, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint16"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=-1})
  verify(r,"U8",{{{"3","x"}},{{"17","é"}}})
  n=n+1
end
-- case 709: uint16 + U8, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({3,17},"uint16"),{2})},{axis=1})
  verify(r,"U8",{"x","é","3","17"})
  n=n+1
end
-- case 710: uint16 + U8, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({3,17},"uint16"),{2})},{axis=-1})
  verify(r,"U8",{"x","é","3","17"})
  n=n+1
end
-- case 711: uint16 + U8, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({3,17},"uint16"),{1,2})},{axis=1})
  verify(r,"U8",{{"x","é"},{"3","17"}})
  n=n+1
end
-- case 712: uint16 + U8, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({3,17},"uint16"),{1,2})},{axis=-1})
  verify(r,"U8",{{"x","é","3","17"}})
  n=n+1
end
-- case 713: uint16 + U8, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({3,17},"uint16"),{2,1})},{axis=1})
  verify(r,"U8",{{"x"},{"é"},{"3"},{"17"}})
  n=n+1
end
-- case 714: uint16 + U8, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({3,17},"uint16"),{2,1})},{axis=-1})
  verify(r,"U8",{{"x","3"},{"é","17"}})
  n=n+1
end
-- case 715: uint16 + U8, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({3,17},"uint16"),{2})},{axis=1})
  verify(r,"U8",{{"x","é"},{"3","17"}})
  n=n+1
end
-- case 716: uint16 + U8, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({3,17},"uint16"),{2})},{axis=-1})
  verify(r,"U8",{{"x","3"},{"é","17"}})
  n=n+1
end
-- case 717: uint16 + U8, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({3,17},"uint16"),{1,2})},{axis=1})
  verify(r,"U8",{{{"x","é"}},{{"3","17"}}})
  n=n+1
end
-- case 718: uint16 + U8, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({3,17},"uint16"),{1,2})},{axis=-1})
  verify(r,"U8",{{{"x","3"},{"é","17"}}})
  n=n+1
end
-- case 719: uint16 + U8, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({3,17},"uint16"),{2,1})},{axis=1})
  verify(r,"U8",{{{"x"},{"é"}},{{"3"},{"17"}}})
  n=n+1
end
-- case 720: uint16 + U8, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({3,17},"uint16"),{2,1})},{axis=-1})
  verify(r,"U8",{{{"x","3"}},{{"é","17"}}})
  n=n+1
end
-- case 721: int32 + S1, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int32"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=1})
  verify(r,"S11",{"-3","17","x","y"})
  n=n+1
end
-- case 722: int32 + S1, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int32"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=-1})
  verify(r,"S11",{"-3","17","x","y"})
  n=n+1
end
-- case 723: int32 + S1, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int32"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=1})
  verify(r,"S11",{{"-3","17"},{"x","y"}})
  n=n+1
end
-- case 724: int32 + S1, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int32"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=-1})
  verify(r,"S11",{{"-3","17","x","y"}})
  n=n+1
end
-- case 725: int32 + S1, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int32"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=1})
  verify(r,"S11",{{"-3"},{"17"},{"x"},{"y"}})
  n=n+1
end
-- case 726: int32 + S1, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int32"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=-1})
  verify(r,"S11",{{"-3","x"},{"17","y"}})
  n=n+1
end
-- case 727: int32 + S1, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int32"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=1})
  verify(r,"S11",{{"-3","17"},{"x","y"}})
  n=n+1
end
-- case 728: int32 + S1, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int32"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=-1})
  verify(r,"S11",{{"-3","x"},{"17","y"}})
  n=n+1
end
-- case 729: int32 + S1, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int32"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=1})
  verify(r,"S11",{{{"-3","17"}},{{"x","y"}}})
  n=n+1
end
-- case 730: int32 + S1, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int32"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=-1})
  verify(r,"S11",{{{"-3","x"},{"17","y"}}})
  n=n+1
end
-- case 731: int32 + S1, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int32"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=1})
  verify(r,"S11",{{{"-3"},{"17"}},{{"x"},{"y"}}})
  n=n+1
end
-- case 732: int32 + S1, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int32"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=-1})
  verify(r,"S11",{{{"-3","x"}},{{"17","y"}}})
  n=n+1
end
-- case 733: int32 + S1, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({-3,17},"int32"),{2})},{axis=1})
  verify(r,"S11",{"x","y","-3","17"})
  n=n+1
end
-- case 734: int32 + S1, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({-3,17},"int32"),{2})},{axis=-1})
  verify(r,"S11",{"x","y","-3","17"})
  n=n+1
end
-- case 735: int32 + S1, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({-3,17},"int32"),{1,2})},{axis=1})
  verify(r,"S11",{{"x","y"},{"-3","17"}})
  n=n+1
end
-- case 736: int32 + S1, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({-3,17},"int32"),{1,2})},{axis=-1})
  verify(r,"S11",{{"x","y","-3","17"}})
  n=n+1
end
-- case 737: int32 + S1, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({-3,17},"int32"),{2,1})},{axis=1})
  verify(r,"S11",{{"x"},{"y"},{"-3"},{"17"}})
  n=n+1
end
-- case 738: int32 + S1, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({-3,17},"int32"),{2,1})},{axis=-1})
  verify(r,"S11",{{"x","-3"},{"y","17"}})
  n=n+1
end
-- case 739: int32 + S1, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({-3,17},"int32"),{2})},{axis=1})
  verify(r,"S11",{{"x","y"},{"-3","17"}})
  n=n+1
end
-- case 740: int32 + S1, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({-3,17},"int32"),{2})},{axis=-1})
  verify(r,"S11",{{"x","-3"},{"y","17"}})
  n=n+1
end
-- case 741: int32 + S1, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({-3,17},"int32"),{1,2})},{axis=1})
  verify(r,"S11",{{{"x","y"}},{{"-3","17"}}})
  n=n+1
end
-- case 742: int32 + S1, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({-3,17},"int32"),{1,2})},{axis=-1})
  verify(r,"S11",{{{"x","-3"},{"y","17"}}})
  n=n+1
end
-- case 743: int32 + S1, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({-3,17},"int32"),{2,1})},{axis=1})
  verify(r,"S11",{{{"x"},{"y"}},{{"-3"},{"17"}}})
  n=n+1
end
-- case 744: int32 + S1, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({-3,17},"int32"),{2,1})},{axis=-1})
  verify(r,"S11",{{{"x","-3"}},{{"y","17"}}})
  n=n+1
end
-- case 745: int32 + S3, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int32"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=1})
  verify(r,"S11",{"-3","17","x","yz"})
  n=n+1
end
-- case 746: int32 + S3, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int32"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=-1})
  verify(r,"S11",{"-3","17","x","yz"})
  n=n+1
end
-- case 747: int32 + S3, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int32"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=1})
  verify(r,"S11",{{"-3","17"},{"x","yz"}})
  n=n+1
end
-- case 748: int32 + S3, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int32"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=-1})
  verify(r,"S11",{{"-3","17","x","yz"}})
  n=n+1
end
-- case 749: int32 + S3, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int32"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=1})
  verify(r,"S11",{{"-3"},{"17"},{"x"},{"yz"}})
  n=n+1
end
-- case 750: int32 + S3, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int32"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=-1})
  verify(r,"S11",{{"-3","x"},{"17","yz"}})
  n=n+1
end
-- case 751: int32 + S3, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int32"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=1})
  verify(r,"S11",{{"-3","17"},{"x","yz"}})
  n=n+1
end
-- case 752: int32 + S3, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int32"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=-1})
  verify(r,"S11",{{"-3","x"},{"17","yz"}})
  n=n+1
end
-- case 753: int32 + S3, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int32"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=1})
  verify(r,"S11",{{{"-3","17"}},{{"x","yz"}}})
  n=n+1
end
-- case 754: int32 + S3, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int32"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=-1})
  verify(r,"S11",{{{"-3","x"},{"17","yz"}}})
  n=n+1
end
-- case 755: int32 + S3, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int32"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=1})
  verify(r,"S11",{{{"-3"},{"17"}},{{"x"},{"yz"}}})
  n=n+1
end
-- case 756: int32 + S3, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int32"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=-1})
  verify(r,"S11",{{{"-3","x"}},{{"17","yz"}}})
  n=n+1
end
-- case 757: int32 + S3, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({-3,17},"int32"),{2})},{axis=1})
  verify(r,"S11",{"x","yz","-3","17"})
  n=n+1
end
-- case 758: int32 + S3, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({-3,17},"int32"),{2})},{axis=-1})
  verify(r,"S11",{"x","yz","-3","17"})
  n=n+1
end
-- case 759: int32 + S3, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({-3,17},"int32"),{1,2})},{axis=1})
  verify(r,"S11",{{"x","yz"},{"-3","17"}})
  n=n+1
end
-- case 760: int32 + S3, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({-3,17},"int32"),{1,2})},{axis=-1})
  verify(r,"S11",{{"x","yz","-3","17"}})
  n=n+1
end
-- case 761: int32 + S3, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({-3,17},"int32"),{2,1})},{axis=1})
  verify(r,"S11",{{"x"},{"yz"},{"-3"},{"17"}})
  n=n+1
end
-- case 762: int32 + S3, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({-3,17},"int32"),{2,1})},{axis=-1})
  verify(r,"S11",{{"x","-3"},{"yz","17"}})
  n=n+1
end
-- case 763: int32 + S3, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({-3,17},"int32"),{2})},{axis=1})
  verify(r,"S11",{{"x","yz"},{"-3","17"}})
  n=n+1
end
-- case 764: int32 + S3, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({-3,17},"int32"),{2})},{axis=-1})
  verify(r,"S11",{{"x","-3"},{"yz","17"}})
  n=n+1
end
-- case 765: int32 + S3, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({-3,17},"int32"),{1,2})},{axis=1})
  verify(r,"S11",{{{"x","yz"}},{{"-3","17"}}})
  n=n+1
end
-- case 766: int32 + S3, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({-3,17},"int32"),{1,2})},{axis=-1})
  verify(r,"S11",{{{"x","-3"},{"yz","17"}}})
  n=n+1
end
-- case 767: int32 + S3, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({-3,17},"int32"),{2,1})},{axis=1})
  verify(r,"S11",{{{"x"},{"yz"}},{{"-3"},{"17"}}})
  n=n+1
end
-- case 768: int32 + S3, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({-3,17},"int32"),{2,1})},{axis=-1})
  verify(r,"S11",{{{"x","-3"}},{{"yz","17"}}})
  n=n+1
end
-- case 769: int32 + S8, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int32"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=1})
  verify(r,"S11",{"-3","17","x","yz"})
  n=n+1
end
-- case 770: int32 + S8, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int32"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=-1})
  verify(r,"S11",{"-3","17","x","yz"})
  n=n+1
end
-- case 771: int32 + S8, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int32"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=1})
  verify(r,"S11",{{"-3","17"},{"x","yz"}})
  n=n+1
end
-- case 772: int32 + S8, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int32"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=-1})
  verify(r,"S11",{{"-3","17","x","yz"}})
  n=n+1
end
-- case 773: int32 + S8, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int32"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=1})
  verify(r,"S11",{{"-3"},{"17"},{"x"},{"yz"}})
  n=n+1
end
-- case 774: int32 + S8, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int32"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=-1})
  verify(r,"S11",{{"-3","x"},{"17","yz"}})
  n=n+1
end
-- case 775: int32 + S8, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int32"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=1})
  verify(r,"S11",{{"-3","17"},{"x","yz"}})
  n=n+1
end
-- case 776: int32 + S8, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int32"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=-1})
  verify(r,"S11",{{"-3","x"},{"17","yz"}})
  n=n+1
end
-- case 777: int32 + S8, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int32"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=1})
  verify(r,"S11",{{{"-3","17"}},{{"x","yz"}}})
  n=n+1
end
-- case 778: int32 + S8, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int32"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=-1})
  verify(r,"S11",{{{"-3","x"},{"17","yz"}}})
  n=n+1
end
-- case 779: int32 + S8, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int32"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=1})
  verify(r,"S11",{{{"-3"},{"17"}},{{"x"},{"yz"}}})
  n=n+1
end
-- case 780: int32 + S8, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int32"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=-1})
  verify(r,"S11",{{{"-3","x"}},{{"17","yz"}}})
  n=n+1
end
-- case 781: int32 + S8, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({-3,17},"int32"),{2})},{axis=1})
  verify(r,"S11",{"x","yz","-3","17"})
  n=n+1
end
-- case 782: int32 + S8, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({-3,17},"int32"),{2})},{axis=-1})
  verify(r,"S11",{"x","yz","-3","17"})
  n=n+1
end
-- case 783: int32 + S8, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({-3,17},"int32"),{1,2})},{axis=1})
  verify(r,"S11",{{"x","yz"},{"-3","17"}})
  n=n+1
end
-- case 784: int32 + S8, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({-3,17},"int32"),{1,2})},{axis=-1})
  verify(r,"S11",{{"x","yz","-3","17"}})
  n=n+1
end
-- case 785: int32 + S8, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({-3,17},"int32"),{2,1})},{axis=1})
  verify(r,"S11",{{"x"},{"yz"},{"-3"},{"17"}})
  n=n+1
end
-- case 786: int32 + S8, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({-3,17},"int32"),{2,1})},{axis=-1})
  verify(r,"S11",{{"x","-3"},{"yz","17"}})
  n=n+1
end
-- case 787: int32 + S8, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({-3,17},"int32"),{2})},{axis=1})
  verify(r,"S11",{{"x","yz"},{"-3","17"}})
  n=n+1
end
-- case 788: int32 + S8, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({-3,17},"int32"),{2})},{axis=-1})
  verify(r,"S11",{{"x","-3"},{"yz","17"}})
  n=n+1
end
-- case 789: int32 + S8, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({-3,17},"int32"),{1,2})},{axis=1})
  verify(r,"S11",{{{"x","yz"}},{{"-3","17"}}})
  n=n+1
end
-- case 790: int32 + S8, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({-3,17},"int32"),{1,2})},{axis=-1})
  verify(r,"S11",{{{"x","-3"},{"yz","17"}}})
  n=n+1
end
-- case 791: int32 + S8, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({-3,17},"int32"),{2,1})},{axis=1})
  verify(r,"S11",{{{"x"},{"yz"}},{{"-3"},{"17"}}})
  n=n+1
end
-- case 792: int32 + S8, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({-3,17},"int32"),{2,1})},{axis=-1})
  verify(r,"S11",{{{"x","-3"}},{{"yz","17"}}})
  n=n+1
end
-- case 793: int32 + U1, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int32"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=1})
  verify(r,"U11",{"-3","17","x","é"})
  n=n+1
end
-- case 794: int32 + U1, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int32"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=-1})
  verify(r,"U11",{"-3","17","x","é"})
  n=n+1
end
-- case 795: int32 + U1, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int32"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=1})
  verify(r,"U11",{{"-3","17"},{"x","é"}})
  n=n+1
end
-- case 796: int32 + U1, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int32"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=-1})
  verify(r,"U11",{{"-3","17","x","é"}})
  n=n+1
end
-- case 797: int32 + U1, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int32"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=1})
  verify(r,"U11",{{"-3"},{"17"},{"x"},{"é"}})
  n=n+1
end
-- case 798: int32 + U1, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int32"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=-1})
  verify(r,"U11",{{"-3","x"},{"17","é"}})
  n=n+1
end
-- case 799: int32 + U1, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int32"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=1})
  verify(r,"U11",{{"-3","17"},{"x","é"}})
  n=n+1
end
-- case 800: int32 + U1, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int32"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=-1})
  verify(r,"U11",{{"-3","x"},{"17","é"}})
  n=n+1
end
-- case 801: int32 + U1, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int32"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=1})
  verify(r,"U11",{{{"-3","17"}},{{"x","é"}}})
  n=n+1
end
-- case 802: int32 + U1, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int32"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=-1})
  verify(r,"U11",{{{"-3","x"},{"17","é"}}})
  n=n+1
end
-- case 803: int32 + U1, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int32"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=1})
  verify(r,"U11",{{{"-3"},{"17"}},{{"x"},{"é"}}})
  n=n+1
end
-- case 804: int32 + U1, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int32"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=-1})
  verify(r,"U11",{{{"-3","x"}},{{"17","é"}}})
  n=n+1
end
-- case 805: int32 + U1, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({-3,17},"int32"),{2})},{axis=1})
  verify(r,"U11",{"x","é","-3","17"})
  n=n+1
end
-- case 806: int32 + U1, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({-3,17},"int32"),{2})},{axis=-1})
  verify(r,"U11",{"x","é","-3","17"})
  n=n+1
end
-- case 807: int32 + U1, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({-3,17},"int32"),{1,2})},{axis=1})
  verify(r,"U11",{{"x","é"},{"-3","17"}})
  n=n+1
end
-- case 808: int32 + U1, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({-3,17},"int32"),{1,2})},{axis=-1})
  verify(r,"U11",{{"x","é","-3","17"}})
  n=n+1
end
-- case 809: int32 + U1, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({-3,17},"int32"),{2,1})},{axis=1})
  verify(r,"U11",{{"x"},{"é"},{"-3"},{"17"}})
  n=n+1
end
-- case 810: int32 + U1, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({-3,17},"int32"),{2,1})},{axis=-1})
  verify(r,"U11",{{"x","-3"},{"é","17"}})
  n=n+1
end
-- case 811: int32 + U1, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({-3,17},"int32"),{2})},{axis=1})
  verify(r,"U11",{{"x","é"},{"-3","17"}})
  n=n+1
end
-- case 812: int32 + U1, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({-3,17},"int32"),{2})},{axis=-1})
  verify(r,"U11",{{"x","-3"},{"é","17"}})
  n=n+1
end
-- case 813: int32 + U1, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({-3,17},"int32"),{1,2})},{axis=1})
  verify(r,"U11",{{{"x","é"}},{{"-3","17"}}})
  n=n+1
end
-- case 814: int32 + U1, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({-3,17},"int32"),{1,2})},{axis=-1})
  verify(r,"U11",{{{"x","-3"},{"é","17"}}})
  n=n+1
end
-- case 815: int32 + U1, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({-3,17},"int32"),{2,1})},{axis=1})
  verify(r,"U11",{{{"x"},{"é"}},{{"-3"},{"17"}}})
  n=n+1
end
-- case 816: int32 + U1, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({-3,17},"int32"),{2,1})},{axis=-1})
  verify(r,"U11",{{{"x","-3"}},{{"é","17"}}})
  n=n+1
end
-- case 817: int32 + U3, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int32"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=1})
  verify(r,"U11",{"-3","17","x","é"})
  n=n+1
end
-- case 818: int32 + U3, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int32"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=-1})
  verify(r,"U11",{"-3","17","x","é"})
  n=n+1
end
-- case 819: int32 + U3, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int32"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=1})
  verify(r,"U11",{{"-3","17"},{"x","é"}})
  n=n+1
end
-- case 820: int32 + U3, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int32"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=-1})
  verify(r,"U11",{{"-3","17","x","é"}})
  n=n+1
end
-- case 821: int32 + U3, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int32"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=1})
  verify(r,"U11",{{"-3"},{"17"},{"x"},{"é"}})
  n=n+1
end
-- case 822: int32 + U3, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int32"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=-1})
  verify(r,"U11",{{"-3","x"},{"17","é"}})
  n=n+1
end
-- case 823: int32 + U3, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int32"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=1})
  verify(r,"U11",{{"-3","17"},{"x","é"}})
  n=n+1
end
-- case 824: int32 + U3, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int32"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=-1})
  verify(r,"U11",{{"-3","x"},{"17","é"}})
  n=n+1
end
-- case 825: int32 + U3, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int32"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=1})
  verify(r,"U11",{{{"-3","17"}},{{"x","é"}}})
  n=n+1
end
-- case 826: int32 + U3, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int32"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=-1})
  verify(r,"U11",{{{"-3","x"},{"17","é"}}})
  n=n+1
end
-- case 827: int32 + U3, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int32"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=1})
  verify(r,"U11",{{{"-3"},{"17"}},{{"x"},{"é"}}})
  n=n+1
end
-- case 828: int32 + U3, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int32"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=-1})
  verify(r,"U11",{{{"-3","x"}},{{"17","é"}}})
  n=n+1
end
-- case 829: int32 + U3, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({-3,17},"int32"),{2})},{axis=1})
  verify(r,"U11",{"x","é","-3","17"})
  n=n+1
end
-- case 830: int32 + U3, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({-3,17},"int32"),{2})},{axis=-1})
  verify(r,"U11",{"x","é","-3","17"})
  n=n+1
end
-- case 831: int32 + U3, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({-3,17},"int32"),{1,2})},{axis=1})
  verify(r,"U11",{{"x","é"},{"-3","17"}})
  n=n+1
end
-- case 832: int32 + U3, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({-3,17},"int32"),{1,2})},{axis=-1})
  verify(r,"U11",{{"x","é","-3","17"}})
  n=n+1
end
-- case 833: int32 + U3, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({-3,17},"int32"),{2,1})},{axis=1})
  verify(r,"U11",{{"x"},{"é"},{"-3"},{"17"}})
  n=n+1
end
-- case 834: int32 + U3, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({-3,17},"int32"),{2,1})},{axis=-1})
  verify(r,"U11",{{"x","-3"},{"é","17"}})
  n=n+1
end
-- case 835: int32 + U3, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({-3,17},"int32"),{2})},{axis=1})
  verify(r,"U11",{{"x","é"},{"-3","17"}})
  n=n+1
end
-- case 836: int32 + U3, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({-3,17},"int32"),{2})},{axis=-1})
  verify(r,"U11",{{"x","-3"},{"é","17"}})
  n=n+1
end
-- case 837: int32 + U3, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({-3,17},"int32"),{1,2})},{axis=1})
  verify(r,"U11",{{{"x","é"}},{{"-3","17"}}})
  n=n+1
end
-- case 838: int32 + U3, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({-3,17},"int32"),{1,2})},{axis=-1})
  verify(r,"U11",{{{"x","-3"},{"é","17"}}})
  n=n+1
end
-- case 839: int32 + U3, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({-3,17},"int32"),{2,1})},{axis=1})
  verify(r,"U11",{{{"x"},{"é"}},{{"-3"},{"17"}}})
  n=n+1
end
-- case 840: int32 + U3, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({-3,17},"int32"),{2,1})},{axis=-1})
  verify(r,"U11",{{{"x","-3"}},{{"é","17"}}})
  n=n+1
end
-- case 841: int32 + U8, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int32"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=1})
  verify(r,"U11",{"-3","17","x","é"})
  n=n+1
end
-- case 842: int32 + U8, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int32"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=-1})
  verify(r,"U11",{"-3","17","x","é"})
  n=n+1
end
-- case 843: int32 + U8, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int32"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=1})
  verify(r,"U11",{{"-3","17"},{"x","é"}})
  n=n+1
end
-- case 844: int32 + U8, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int32"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=-1})
  verify(r,"U11",{{"-3","17","x","é"}})
  n=n+1
end
-- case 845: int32 + U8, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int32"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=1})
  verify(r,"U11",{{"-3"},{"17"},{"x"},{"é"}})
  n=n+1
end
-- case 846: int32 + U8, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int32"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=-1})
  verify(r,"U11",{{"-3","x"},{"17","é"}})
  n=n+1
end
-- case 847: int32 + U8, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int32"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=1})
  verify(r,"U11",{{"-3","17"},{"x","é"}})
  n=n+1
end
-- case 848: int32 + U8, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int32"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=-1})
  verify(r,"U11",{{"-3","x"},{"17","é"}})
  n=n+1
end
-- case 849: int32 + U8, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int32"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=1})
  verify(r,"U11",{{{"-3","17"}},{{"x","é"}}})
  n=n+1
end
-- case 850: int32 + U8, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int32"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=-1})
  verify(r,"U11",{{{"-3","x"},{"17","é"}}})
  n=n+1
end
-- case 851: int32 + U8, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int32"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=1})
  verify(r,"U11",{{{"-3"},{"17"}},{{"x"},{"é"}}})
  n=n+1
end
-- case 852: int32 + U8, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int32"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=-1})
  verify(r,"U11",{{{"-3","x"}},{{"17","é"}}})
  n=n+1
end
-- case 853: int32 + U8, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({-3,17},"int32"),{2})},{axis=1})
  verify(r,"U11",{"x","é","-3","17"})
  n=n+1
end
-- case 854: int32 + U8, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({-3,17},"int32"),{2})},{axis=-1})
  verify(r,"U11",{"x","é","-3","17"})
  n=n+1
end
-- case 855: int32 + U8, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({-3,17},"int32"),{1,2})},{axis=1})
  verify(r,"U11",{{"x","é"},{"-3","17"}})
  n=n+1
end
-- case 856: int32 + U8, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({-3,17},"int32"),{1,2})},{axis=-1})
  verify(r,"U11",{{"x","é","-3","17"}})
  n=n+1
end
-- case 857: int32 + U8, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({-3,17},"int32"),{2,1})},{axis=1})
  verify(r,"U11",{{"x"},{"é"},{"-3"},{"17"}})
  n=n+1
end
-- case 858: int32 + U8, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({-3,17},"int32"),{2,1})},{axis=-1})
  verify(r,"U11",{{"x","-3"},{"é","17"}})
  n=n+1
end
-- case 859: int32 + U8, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({-3,17},"int32"),{2})},{axis=1})
  verify(r,"U11",{{"x","é"},{"-3","17"}})
  n=n+1
end
-- case 860: int32 + U8, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({-3,17},"int32"),{2})},{axis=-1})
  verify(r,"U11",{{"x","-3"},{"é","17"}})
  n=n+1
end
-- case 861: int32 + U8, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({-3,17},"int32"),{1,2})},{axis=1})
  verify(r,"U11",{{{"x","é"}},{{"-3","17"}}})
  n=n+1
end
-- case 862: int32 + U8, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({-3,17},"int32"),{1,2})},{axis=-1})
  verify(r,"U11",{{{"x","-3"},{"é","17"}}})
  n=n+1
end
-- case 863: int32 + U8, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({-3,17},"int32"),{2,1})},{axis=1})
  verify(r,"U11",{{{"x"},{"é"}},{{"-3"},{"17"}}})
  n=n+1
end
-- case 864: int32 + U8, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({-3,17},"int32"),{2,1})},{axis=-1})
  verify(r,"U11",{{{"x","-3"}},{{"é","17"}}})
  n=n+1
end
-- case 865: uint32 + S1, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint32"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=1})
  verify(r,"S10",{"3","17","x","y"})
  n=n+1
end
-- case 866: uint32 + S1, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint32"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=-1})
  verify(r,"S10",{"3","17","x","y"})
  n=n+1
end
-- case 867: uint32 + S1, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint32"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=1})
  verify(r,"S10",{{"3","17"},{"x","y"}})
  n=n+1
end
-- case 868: uint32 + S1, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint32"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=-1})
  verify(r,"S10",{{"3","17","x","y"}})
  n=n+1
end
-- case 869: uint32 + S1, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint32"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=1})
  verify(r,"S10",{{"3"},{"17"},{"x"},{"y"}})
  n=n+1
end
-- case 870: uint32 + S1, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint32"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=-1})
  verify(r,"S10",{{"3","x"},{"17","y"}})
  n=n+1
end
-- case 871: uint32 + S1, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint32"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=1})
  verify(r,"S10",{{"3","17"},{"x","y"}})
  n=n+1
end
-- case 872: uint32 + S1, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint32"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=-1})
  verify(r,"S10",{{"3","x"},{"17","y"}})
  n=n+1
end
-- case 873: uint32 + S1, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint32"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=1})
  verify(r,"S10",{{{"3","17"}},{{"x","y"}}})
  n=n+1
end
-- case 874: uint32 + S1, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint32"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=-1})
  verify(r,"S10",{{{"3","x"},{"17","y"}}})
  n=n+1
end
-- case 875: uint32 + S1, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint32"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=1})
  verify(r,"S10",{{{"3"},{"17"}},{{"x"},{"y"}}})
  n=n+1
end
-- case 876: uint32 + S1, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint32"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=-1})
  verify(r,"S10",{{{"3","x"}},{{"17","y"}}})
  n=n+1
end
-- case 877: uint32 + S1, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({3,17},"uint32"),{2})},{axis=1})
  verify(r,"S10",{"x","y","3","17"})
  n=n+1
end
-- case 878: uint32 + S1, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({3,17},"uint32"),{2})},{axis=-1})
  verify(r,"S10",{"x","y","3","17"})
  n=n+1
end
-- case 879: uint32 + S1, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({3,17},"uint32"),{1,2})},{axis=1})
  verify(r,"S10",{{"x","y"},{"3","17"}})
  n=n+1
end
-- case 880: uint32 + S1, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({3,17},"uint32"),{1,2})},{axis=-1})
  verify(r,"S10",{{"x","y","3","17"}})
  n=n+1
end
-- case 881: uint32 + S1, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({3,17},"uint32"),{2,1})},{axis=1})
  verify(r,"S10",{{"x"},{"y"},{"3"},{"17"}})
  n=n+1
end
-- case 882: uint32 + S1, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({3,17},"uint32"),{2,1})},{axis=-1})
  verify(r,"S10",{{"x","3"},{"y","17"}})
  n=n+1
end
-- case 883: uint32 + S1, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({3,17},"uint32"),{2})},{axis=1})
  verify(r,"S10",{{"x","y"},{"3","17"}})
  n=n+1
end
-- case 884: uint32 + S1, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({3,17},"uint32"),{2})},{axis=-1})
  verify(r,"S10",{{"x","3"},{"y","17"}})
  n=n+1
end
-- case 885: uint32 + S1, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({3,17},"uint32"),{1,2})},{axis=1})
  verify(r,"S10",{{{"x","y"}},{{"3","17"}}})
  n=n+1
end
-- case 886: uint32 + S1, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({3,17},"uint32"),{1,2})},{axis=-1})
  verify(r,"S10",{{{"x","3"},{"y","17"}}})
  n=n+1
end
-- case 887: uint32 + S1, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({3,17},"uint32"),{2,1})},{axis=1})
  verify(r,"S10",{{{"x"},{"y"}},{{"3"},{"17"}}})
  n=n+1
end
-- case 888: uint32 + S1, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({3,17},"uint32"),{2,1})},{axis=-1})
  verify(r,"S10",{{{"x","3"}},{{"y","17"}}})
  n=n+1
end
-- case 889: uint32 + S3, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint32"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=1})
  verify(r,"S10",{"3","17","x","yz"})
  n=n+1
end
-- case 890: uint32 + S3, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint32"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=-1})
  verify(r,"S10",{"3","17","x","yz"})
  n=n+1
end
-- case 891: uint32 + S3, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint32"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=1})
  verify(r,"S10",{{"3","17"},{"x","yz"}})
  n=n+1
end
-- case 892: uint32 + S3, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint32"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=-1})
  verify(r,"S10",{{"3","17","x","yz"}})
  n=n+1
end
-- case 893: uint32 + S3, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint32"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=1})
  verify(r,"S10",{{"3"},{"17"},{"x"},{"yz"}})
  n=n+1
end
-- case 894: uint32 + S3, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint32"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=-1})
  verify(r,"S10",{{"3","x"},{"17","yz"}})
  n=n+1
end
-- case 895: uint32 + S3, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint32"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=1})
  verify(r,"S10",{{"3","17"},{"x","yz"}})
  n=n+1
end
-- case 896: uint32 + S3, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint32"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=-1})
  verify(r,"S10",{{"3","x"},{"17","yz"}})
  n=n+1
end
-- case 897: uint32 + S3, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint32"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=1})
  verify(r,"S10",{{{"3","17"}},{{"x","yz"}}})
  n=n+1
end
-- case 898: uint32 + S3, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint32"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=-1})
  verify(r,"S10",{{{"3","x"},{"17","yz"}}})
  n=n+1
end
-- case 899: uint32 + S3, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint32"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=1})
  verify(r,"S10",{{{"3"},{"17"}},{{"x"},{"yz"}}})
  n=n+1
end
-- case 900: uint32 + S3, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint32"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=-1})
  verify(r,"S10",{{{"3","x"}},{{"17","yz"}}})
  n=n+1
end
-- case 901: uint32 + S3, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({3,17},"uint32"),{2})},{axis=1})
  verify(r,"S10",{"x","yz","3","17"})
  n=n+1
end
-- case 902: uint32 + S3, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({3,17},"uint32"),{2})},{axis=-1})
  verify(r,"S10",{"x","yz","3","17"})
  n=n+1
end
-- case 903: uint32 + S3, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({3,17},"uint32"),{1,2})},{axis=1})
  verify(r,"S10",{{"x","yz"},{"3","17"}})
  n=n+1
end
-- case 904: uint32 + S3, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({3,17},"uint32"),{1,2})},{axis=-1})
  verify(r,"S10",{{"x","yz","3","17"}})
  n=n+1
end
-- case 905: uint32 + S3, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({3,17},"uint32"),{2,1})},{axis=1})
  verify(r,"S10",{{"x"},{"yz"},{"3"},{"17"}})
  n=n+1
end
-- case 906: uint32 + S3, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({3,17},"uint32"),{2,1})},{axis=-1})
  verify(r,"S10",{{"x","3"},{"yz","17"}})
  n=n+1
end
-- case 907: uint32 + S3, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({3,17},"uint32"),{2})},{axis=1})
  verify(r,"S10",{{"x","yz"},{"3","17"}})
  n=n+1
end
-- case 908: uint32 + S3, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({3,17},"uint32"),{2})},{axis=-1})
  verify(r,"S10",{{"x","3"},{"yz","17"}})
  n=n+1
end
-- case 909: uint32 + S3, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({3,17},"uint32"),{1,2})},{axis=1})
  verify(r,"S10",{{{"x","yz"}},{{"3","17"}}})
  n=n+1
end
-- case 910: uint32 + S3, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({3,17},"uint32"),{1,2})},{axis=-1})
  verify(r,"S10",{{{"x","3"},{"yz","17"}}})
  n=n+1
end
-- case 911: uint32 + S3, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({3,17},"uint32"),{2,1})},{axis=1})
  verify(r,"S10",{{{"x"},{"yz"}},{{"3"},{"17"}}})
  n=n+1
end
-- case 912: uint32 + S3, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({3,17},"uint32"),{2,1})},{axis=-1})
  verify(r,"S10",{{{"x","3"}},{{"yz","17"}}})
  n=n+1
end
-- case 913: uint32 + S8, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint32"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=1})
  verify(r,"S10",{"3","17","x","yz"})
  n=n+1
end
-- case 914: uint32 + S8, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint32"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=-1})
  verify(r,"S10",{"3","17","x","yz"})
  n=n+1
end
-- case 915: uint32 + S8, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint32"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=1})
  verify(r,"S10",{{"3","17"},{"x","yz"}})
  n=n+1
end
-- case 916: uint32 + S8, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint32"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=-1})
  verify(r,"S10",{{"3","17","x","yz"}})
  n=n+1
end
-- case 917: uint32 + S8, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint32"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=1})
  verify(r,"S10",{{"3"},{"17"},{"x"},{"yz"}})
  n=n+1
end
-- case 918: uint32 + S8, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint32"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=-1})
  verify(r,"S10",{{"3","x"},{"17","yz"}})
  n=n+1
end
-- case 919: uint32 + S8, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint32"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=1})
  verify(r,"S10",{{"3","17"},{"x","yz"}})
  n=n+1
end
-- case 920: uint32 + S8, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint32"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=-1})
  verify(r,"S10",{{"3","x"},{"17","yz"}})
  n=n+1
end
-- case 921: uint32 + S8, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint32"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=1})
  verify(r,"S10",{{{"3","17"}},{{"x","yz"}}})
  n=n+1
end
-- case 922: uint32 + S8, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint32"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=-1})
  verify(r,"S10",{{{"3","x"},{"17","yz"}}})
  n=n+1
end
-- case 923: uint32 + S8, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint32"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=1})
  verify(r,"S10",{{{"3"},{"17"}},{{"x"},{"yz"}}})
  n=n+1
end
-- case 924: uint32 + S8, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint32"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=-1})
  verify(r,"S10",{{{"3","x"}},{{"17","yz"}}})
  n=n+1
end
-- case 925: uint32 + S8, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({3,17},"uint32"),{2})},{axis=1})
  verify(r,"S10",{"x","yz","3","17"})
  n=n+1
end
-- case 926: uint32 + S8, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({3,17},"uint32"),{2})},{axis=-1})
  verify(r,"S10",{"x","yz","3","17"})
  n=n+1
end
-- case 927: uint32 + S8, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({3,17},"uint32"),{1,2})},{axis=1})
  verify(r,"S10",{{"x","yz"},{"3","17"}})
  n=n+1
end
-- case 928: uint32 + S8, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({3,17},"uint32"),{1,2})},{axis=-1})
  verify(r,"S10",{{"x","yz","3","17"}})
  n=n+1
end
-- case 929: uint32 + S8, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({3,17},"uint32"),{2,1})},{axis=1})
  verify(r,"S10",{{"x"},{"yz"},{"3"},{"17"}})
  n=n+1
end
-- case 930: uint32 + S8, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({3,17},"uint32"),{2,1})},{axis=-1})
  verify(r,"S10",{{"x","3"},{"yz","17"}})
  n=n+1
end
-- case 931: uint32 + S8, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({3,17},"uint32"),{2})},{axis=1})
  verify(r,"S10",{{"x","yz"},{"3","17"}})
  n=n+1
end
-- case 932: uint32 + S8, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({3,17},"uint32"),{2})},{axis=-1})
  verify(r,"S10",{{"x","3"},{"yz","17"}})
  n=n+1
end
-- case 933: uint32 + S8, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({3,17},"uint32"),{1,2})},{axis=1})
  verify(r,"S10",{{{"x","yz"}},{{"3","17"}}})
  n=n+1
end
-- case 934: uint32 + S8, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({3,17},"uint32"),{1,2})},{axis=-1})
  verify(r,"S10",{{{"x","3"},{"yz","17"}}})
  n=n+1
end
-- case 935: uint32 + S8, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({3,17},"uint32"),{2,1})},{axis=1})
  verify(r,"S10",{{{"x"},{"yz"}},{{"3"},{"17"}}})
  n=n+1
end
-- case 936: uint32 + S8, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({3,17},"uint32"),{2,1})},{axis=-1})
  verify(r,"S10",{{{"x","3"}},{{"yz","17"}}})
  n=n+1
end
-- case 937: uint32 + U1, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint32"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=1})
  verify(r,"U10",{"3","17","x","é"})
  n=n+1
end
-- case 938: uint32 + U1, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint32"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=-1})
  verify(r,"U10",{"3","17","x","é"})
  n=n+1
end
-- case 939: uint32 + U1, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint32"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=1})
  verify(r,"U10",{{"3","17"},{"x","é"}})
  n=n+1
end
-- case 940: uint32 + U1, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint32"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=-1})
  verify(r,"U10",{{"3","17","x","é"}})
  n=n+1
end
-- case 941: uint32 + U1, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint32"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=1})
  verify(r,"U10",{{"3"},{"17"},{"x"},{"é"}})
  n=n+1
end
-- case 942: uint32 + U1, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint32"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=-1})
  verify(r,"U10",{{"3","x"},{"17","é"}})
  n=n+1
end
-- case 943: uint32 + U1, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint32"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=1})
  verify(r,"U10",{{"3","17"},{"x","é"}})
  n=n+1
end
-- case 944: uint32 + U1, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint32"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=-1})
  verify(r,"U10",{{"3","x"},{"17","é"}})
  n=n+1
end
-- case 945: uint32 + U1, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint32"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=1})
  verify(r,"U10",{{{"3","17"}},{{"x","é"}}})
  n=n+1
end
-- case 946: uint32 + U1, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint32"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=-1})
  verify(r,"U10",{{{"3","x"},{"17","é"}}})
  n=n+1
end
-- case 947: uint32 + U1, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint32"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=1})
  verify(r,"U10",{{{"3"},{"17"}},{{"x"},{"é"}}})
  n=n+1
end
-- case 948: uint32 + U1, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint32"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=-1})
  verify(r,"U10",{{{"3","x"}},{{"17","é"}}})
  n=n+1
end
-- case 949: uint32 + U1, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({3,17},"uint32"),{2})},{axis=1})
  verify(r,"U10",{"x","é","3","17"})
  n=n+1
end
-- case 950: uint32 + U1, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({3,17},"uint32"),{2})},{axis=-1})
  verify(r,"U10",{"x","é","3","17"})
  n=n+1
end
-- case 951: uint32 + U1, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({3,17},"uint32"),{1,2})},{axis=1})
  verify(r,"U10",{{"x","é"},{"3","17"}})
  n=n+1
end
-- case 952: uint32 + U1, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({3,17},"uint32"),{1,2})},{axis=-1})
  verify(r,"U10",{{"x","é","3","17"}})
  n=n+1
end
-- case 953: uint32 + U1, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({3,17},"uint32"),{2,1})},{axis=1})
  verify(r,"U10",{{"x"},{"é"},{"3"},{"17"}})
  n=n+1
end
-- case 954: uint32 + U1, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({3,17},"uint32"),{2,1})},{axis=-1})
  verify(r,"U10",{{"x","3"},{"é","17"}})
  n=n+1
end
-- case 955: uint32 + U1, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({3,17},"uint32"),{2})},{axis=1})
  verify(r,"U10",{{"x","é"},{"3","17"}})
  n=n+1
end
-- case 956: uint32 + U1, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({3,17},"uint32"),{2})},{axis=-1})
  verify(r,"U10",{{"x","3"},{"é","17"}})
  n=n+1
end
-- case 957: uint32 + U1, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({3,17},"uint32"),{1,2})},{axis=1})
  verify(r,"U10",{{{"x","é"}},{{"3","17"}}})
  n=n+1
end
-- case 958: uint32 + U1, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({3,17},"uint32"),{1,2})},{axis=-1})
  verify(r,"U10",{{{"x","3"},{"é","17"}}})
  n=n+1
end
-- case 959: uint32 + U1, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({3,17},"uint32"),{2,1})},{axis=1})
  verify(r,"U10",{{{"x"},{"é"}},{{"3"},{"17"}}})
  n=n+1
end
-- case 960: uint32 + U1, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({3,17},"uint32"),{2,1})},{axis=-1})
  verify(r,"U10",{{{"x","3"}},{{"é","17"}}})
  n=n+1
end
-- case 961: uint32 + U3, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint32"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=1})
  verify(r,"U10",{"3","17","x","é"})
  n=n+1
end
-- case 962: uint32 + U3, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint32"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=-1})
  verify(r,"U10",{"3","17","x","é"})
  n=n+1
end
-- case 963: uint32 + U3, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint32"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=1})
  verify(r,"U10",{{"3","17"},{"x","é"}})
  n=n+1
end
-- case 964: uint32 + U3, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint32"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=-1})
  verify(r,"U10",{{"3","17","x","é"}})
  n=n+1
end
-- case 965: uint32 + U3, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint32"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=1})
  verify(r,"U10",{{"3"},{"17"},{"x"},{"é"}})
  n=n+1
end
-- case 966: uint32 + U3, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint32"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=-1})
  verify(r,"U10",{{"3","x"},{"17","é"}})
  n=n+1
end
-- case 967: uint32 + U3, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint32"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=1})
  verify(r,"U10",{{"3","17"},{"x","é"}})
  n=n+1
end
-- case 968: uint32 + U3, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint32"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=-1})
  verify(r,"U10",{{"3","x"},{"17","é"}})
  n=n+1
end
-- case 969: uint32 + U3, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint32"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=1})
  verify(r,"U10",{{{"3","17"}},{{"x","é"}}})
  n=n+1
end
-- case 970: uint32 + U3, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint32"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=-1})
  verify(r,"U10",{{{"3","x"},{"17","é"}}})
  n=n+1
end
-- case 971: uint32 + U3, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint32"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=1})
  verify(r,"U10",{{{"3"},{"17"}},{{"x"},{"é"}}})
  n=n+1
end
-- case 972: uint32 + U3, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint32"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=-1})
  verify(r,"U10",{{{"3","x"}},{{"17","é"}}})
  n=n+1
end
-- case 973: uint32 + U3, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({3,17},"uint32"),{2})},{axis=1})
  verify(r,"U10",{"x","é","3","17"})
  n=n+1
end
-- case 974: uint32 + U3, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({3,17},"uint32"),{2})},{axis=-1})
  verify(r,"U10",{"x","é","3","17"})
  n=n+1
end
-- case 975: uint32 + U3, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({3,17},"uint32"),{1,2})},{axis=1})
  verify(r,"U10",{{"x","é"},{"3","17"}})
  n=n+1
end
-- case 976: uint32 + U3, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({3,17},"uint32"),{1,2})},{axis=-1})
  verify(r,"U10",{{"x","é","3","17"}})
  n=n+1
end
-- case 977: uint32 + U3, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({3,17},"uint32"),{2,1})},{axis=1})
  verify(r,"U10",{{"x"},{"é"},{"3"},{"17"}})
  n=n+1
end
-- case 978: uint32 + U3, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({3,17},"uint32"),{2,1})},{axis=-1})
  verify(r,"U10",{{"x","3"},{"é","17"}})
  n=n+1
end
-- case 979: uint32 + U3, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({3,17},"uint32"),{2})},{axis=1})
  verify(r,"U10",{{"x","é"},{"3","17"}})
  n=n+1
end
-- case 980: uint32 + U3, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({3,17},"uint32"),{2})},{axis=-1})
  verify(r,"U10",{{"x","3"},{"é","17"}})
  n=n+1
end
-- case 981: uint32 + U3, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({3,17},"uint32"),{1,2})},{axis=1})
  verify(r,"U10",{{{"x","é"}},{{"3","17"}}})
  n=n+1
end
-- case 982: uint32 + U3, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({3,17},"uint32"),{1,2})},{axis=-1})
  verify(r,"U10",{{{"x","3"},{"é","17"}}})
  n=n+1
end
-- case 983: uint32 + U3, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({3,17},"uint32"),{2,1})},{axis=1})
  verify(r,"U10",{{{"x"},{"é"}},{{"3"},{"17"}}})
  n=n+1
end
-- case 984: uint32 + U3, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({3,17},"uint32"),{2,1})},{axis=-1})
  verify(r,"U10",{{{"x","3"}},{{"é","17"}}})
  n=n+1
end
-- case 985: uint32 + U8, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint32"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=1})
  verify(r,"U10",{"3","17","x","é"})
  n=n+1
end
-- case 986: uint32 + U8, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint32"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=-1})
  verify(r,"U10",{"3","17","x","é"})
  n=n+1
end
-- case 987: uint32 + U8, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint32"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=1})
  verify(r,"U10",{{"3","17"},{"x","é"}})
  n=n+1
end
-- case 988: uint32 + U8, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint32"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=-1})
  verify(r,"U10",{{"3","17","x","é"}})
  n=n+1
end
-- case 989: uint32 + U8, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint32"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=1})
  verify(r,"U10",{{"3"},{"17"},{"x"},{"é"}})
  n=n+1
end
-- case 990: uint32 + U8, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint32"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=-1})
  verify(r,"U10",{{"3","x"},{"17","é"}})
  n=n+1
end
-- case 991: uint32 + U8, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint32"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=1})
  verify(r,"U10",{{"3","17"},{"x","é"}})
  n=n+1
end
-- case 992: uint32 + U8, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint32"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=-1})
  verify(r,"U10",{{"3","x"},{"17","é"}})
  n=n+1
end
-- case 993: uint32 + U8, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint32"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=1})
  verify(r,"U10",{{{"3","17"}},{{"x","é"}}})
  n=n+1
end
-- case 994: uint32 + U8, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint32"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=-1})
  verify(r,"U10",{{{"3","x"},{"17","é"}}})
  n=n+1
end
-- case 995: uint32 + U8, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint32"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=1})
  verify(r,"U10",{{{"3"},{"17"}},{{"x"},{"é"}}})
  n=n+1
end
-- case 996: uint32 + U8, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint32"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=-1})
  verify(r,"U10",{{{"3","x"}},{{"17","é"}}})
  n=n+1
end
-- case 997: uint32 + U8, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({3,17},"uint32"),{2})},{axis=1})
  verify(r,"U10",{"x","é","3","17"})
  n=n+1
end
-- case 998: uint32 + U8, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({3,17},"uint32"),{2})},{axis=-1})
  verify(r,"U10",{"x","é","3","17"})
  n=n+1
end
-- case 999: uint32 + U8, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({3,17},"uint32"),{1,2})},{axis=1})
  verify(r,"U10",{{"x","é"},{"3","17"}})
  n=n+1
end
-- case 1000: uint32 + U8, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({3,17},"uint32"),{1,2})},{axis=-1})
  verify(r,"U10",{{"x","é","3","17"}})
  n=n+1
end
-- case 1001: uint32 + U8, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({3,17},"uint32"),{2,1})},{axis=1})
  verify(r,"U10",{{"x"},{"é"},{"3"},{"17"}})
  n=n+1
end
-- case 1002: uint32 + U8, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({3,17},"uint32"),{2,1})},{axis=-1})
  verify(r,"U10",{{"x","3"},{"é","17"}})
  n=n+1
end
-- case 1003: uint32 + U8, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({3,17},"uint32"),{2})},{axis=1})
  verify(r,"U10",{{"x","é"},{"3","17"}})
  n=n+1
end
-- case 1004: uint32 + U8, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({3,17},"uint32"),{2})},{axis=-1})
  verify(r,"U10",{{"x","3"},{"é","17"}})
  n=n+1
end
-- case 1005: uint32 + U8, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({3,17},"uint32"),{1,2})},{axis=1})
  verify(r,"U10",{{{"x","é"}},{{"3","17"}}})
  n=n+1
end
-- case 1006: uint32 + U8, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({3,17},"uint32"),{1,2})},{axis=-1})
  verify(r,"U10",{{{"x","3"},{"é","17"}}})
  n=n+1
end
-- case 1007: uint32 + U8, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({3,17},"uint32"),{2,1})},{axis=1})
  verify(r,"U10",{{{"x"},{"é"}},{{"3"},{"17"}}})
  n=n+1
end
-- case 1008: uint32 + U8, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({3,17},"uint32"),{2,1})},{axis=-1})
  verify(r,"U10",{{{"x","3"}},{{"é","17"}}})
  n=n+1
end
-- case 1009: int64 + S1, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int64"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=1})
  verify(r,"S21",{"-3","17","x","y"})
  n=n+1
end
-- case 1010: int64 + S1, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int64"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=-1})
  verify(r,"S21",{"-3","17","x","y"})
  n=n+1
end
-- case 1011: int64 + S1, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int64"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=1})
  verify(r,"S21",{{"-3","17"},{"x","y"}})
  n=n+1
end
-- case 1012: int64 + S1, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int64"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=-1})
  verify(r,"S21",{{"-3","17","x","y"}})
  n=n+1
end
-- case 1013: int64 + S1, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int64"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=1})
  verify(r,"S21",{{"-3"},{"17"},{"x"},{"y"}})
  n=n+1
end
-- case 1014: int64 + S1, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int64"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=-1})
  verify(r,"S21",{{"-3","x"},{"17","y"}})
  n=n+1
end
-- case 1015: int64 + S1, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int64"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=1})
  verify(r,"S21",{{"-3","17"},{"x","y"}})
  n=n+1
end
-- case 1016: int64 + S1, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int64"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=-1})
  verify(r,"S21",{{"-3","x"},{"17","y"}})
  n=n+1
end
-- case 1017: int64 + S1, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int64"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=1})
  verify(r,"S21",{{{"-3","17"}},{{"x","y"}}})
  n=n+1
end
-- case 1018: int64 + S1, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int64"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=-1})
  verify(r,"S21",{{{"-3","x"},{"17","y"}}})
  n=n+1
end
-- case 1019: int64 + S1, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int64"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=1})
  verify(r,"S21",{{{"-3"},{"17"}},{{"x"},{"y"}}})
  n=n+1
end
-- case 1020: int64 + S1, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int64"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=-1})
  verify(r,"S21",{{{"-3","x"}},{{"17","y"}}})
  n=n+1
end
-- case 1021: int64 + S1, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({-3,17},"int64"),{2})},{axis=1})
  verify(r,"S21",{"x","y","-3","17"})
  n=n+1
end
-- case 1022: int64 + S1, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({-3,17},"int64"),{2})},{axis=-1})
  verify(r,"S21",{"x","y","-3","17"})
  n=n+1
end
-- case 1023: int64 + S1, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({-3,17},"int64"),{1,2})},{axis=1})
  verify(r,"S21",{{"x","y"},{"-3","17"}})
  n=n+1
end
-- case 1024: int64 + S1, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({-3,17},"int64"),{1,2})},{axis=-1})
  verify(r,"S21",{{"x","y","-3","17"}})
  n=n+1
end
-- case 1025: int64 + S1, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({-3,17},"int64"),{2,1})},{axis=1})
  verify(r,"S21",{{"x"},{"y"},{"-3"},{"17"}})
  n=n+1
end
-- case 1026: int64 + S1, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({-3,17},"int64"),{2,1})},{axis=-1})
  verify(r,"S21",{{"x","-3"},{"y","17"}})
  n=n+1
end
-- case 1027: int64 + S1, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({-3,17},"int64"),{2})},{axis=1})
  verify(r,"S21",{{"x","y"},{"-3","17"}})
  n=n+1
end
-- case 1028: int64 + S1, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({-3,17},"int64"),{2})},{axis=-1})
  verify(r,"S21",{{"x","-3"},{"y","17"}})
  n=n+1
end
-- case 1029: int64 + S1, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({-3,17},"int64"),{1,2})},{axis=1})
  verify(r,"S21",{{{"x","y"}},{{"-3","17"}}})
  n=n+1
end
-- case 1030: int64 + S1, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({-3,17},"int64"),{1,2})},{axis=-1})
  verify(r,"S21",{{{"x","-3"},{"y","17"}}})
  n=n+1
end
-- case 1031: int64 + S1, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({-3,17},"int64"),{2,1})},{axis=1})
  verify(r,"S21",{{{"x"},{"y"}},{{"-3"},{"17"}}})
  n=n+1
end
-- case 1032: int64 + S1, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({-3,17},"int64"),{2,1})},{axis=-1})
  verify(r,"S21",{{{"x","-3"}},{{"y","17"}}})
  n=n+1
end
-- case 1033: int64 + S3, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int64"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=1})
  verify(r,"S21",{"-3","17","x","yz"})
  n=n+1
end
-- case 1034: int64 + S3, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int64"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=-1})
  verify(r,"S21",{"-3","17","x","yz"})
  n=n+1
end
-- case 1035: int64 + S3, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int64"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=1})
  verify(r,"S21",{{"-3","17"},{"x","yz"}})
  n=n+1
end
-- case 1036: int64 + S3, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int64"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=-1})
  verify(r,"S21",{{"-3","17","x","yz"}})
  n=n+1
end
-- case 1037: int64 + S3, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int64"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=1})
  verify(r,"S21",{{"-3"},{"17"},{"x"},{"yz"}})
  n=n+1
end
-- case 1038: int64 + S3, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int64"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=-1})
  verify(r,"S21",{{"-3","x"},{"17","yz"}})
  n=n+1
end
-- case 1039: int64 + S3, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int64"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=1})
  verify(r,"S21",{{"-3","17"},{"x","yz"}})
  n=n+1
end
-- case 1040: int64 + S3, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int64"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=-1})
  verify(r,"S21",{{"-3","x"},{"17","yz"}})
  n=n+1
end
-- case 1041: int64 + S3, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int64"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=1})
  verify(r,"S21",{{{"-3","17"}},{{"x","yz"}}})
  n=n+1
end
-- case 1042: int64 + S3, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int64"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=-1})
  verify(r,"S21",{{{"-3","x"},{"17","yz"}}})
  n=n+1
end
-- case 1043: int64 + S3, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int64"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=1})
  verify(r,"S21",{{{"-3"},{"17"}},{{"x"},{"yz"}}})
  n=n+1
end
-- case 1044: int64 + S3, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int64"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=-1})
  verify(r,"S21",{{{"-3","x"}},{{"17","yz"}}})
  n=n+1
end
-- case 1045: int64 + S3, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({-3,17},"int64"),{2})},{axis=1})
  verify(r,"S21",{"x","yz","-3","17"})
  n=n+1
end
-- case 1046: int64 + S3, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({-3,17},"int64"),{2})},{axis=-1})
  verify(r,"S21",{"x","yz","-3","17"})
  n=n+1
end
-- case 1047: int64 + S3, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({-3,17},"int64"),{1,2})},{axis=1})
  verify(r,"S21",{{"x","yz"},{"-3","17"}})
  n=n+1
end
-- case 1048: int64 + S3, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({-3,17},"int64"),{1,2})},{axis=-1})
  verify(r,"S21",{{"x","yz","-3","17"}})
  n=n+1
end
-- case 1049: int64 + S3, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({-3,17},"int64"),{2,1})},{axis=1})
  verify(r,"S21",{{"x"},{"yz"},{"-3"},{"17"}})
  n=n+1
end
-- case 1050: int64 + S3, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({-3,17},"int64"),{2,1})},{axis=-1})
  verify(r,"S21",{{"x","-3"},{"yz","17"}})
  n=n+1
end
-- case 1051: int64 + S3, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({-3,17},"int64"),{2})},{axis=1})
  verify(r,"S21",{{"x","yz"},{"-3","17"}})
  n=n+1
end
-- case 1052: int64 + S3, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({-3,17},"int64"),{2})},{axis=-1})
  verify(r,"S21",{{"x","-3"},{"yz","17"}})
  n=n+1
end
-- case 1053: int64 + S3, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({-3,17},"int64"),{1,2})},{axis=1})
  verify(r,"S21",{{{"x","yz"}},{{"-3","17"}}})
  n=n+1
end
-- case 1054: int64 + S3, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({-3,17},"int64"),{1,2})},{axis=-1})
  verify(r,"S21",{{{"x","-3"},{"yz","17"}}})
  n=n+1
end
-- case 1055: int64 + S3, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({-3,17},"int64"),{2,1})},{axis=1})
  verify(r,"S21",{{{"x"},{"yz"}},{{"-3"},{"17"}}})
  n=n+1
end
-- case 1056: int64 + S3, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({-3,17},"int64"),{2,1})},{axis=-1})
  verify(r,"S21",{{{"x","-3"}},{{"yz","17"}}})
  n=n+1
end
-- case 1057: int64 + S8, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int64"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=1})
  verify(r,"S21",{"-3","17","x","yz"})
  n=n+1
end
-- case 1058: int64 + S8, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int64"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=-1})
  verify(r,"S21",{"-3","17","x","yz"})
  n=n+1
end
-- case 1059: int64 + S8, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int64"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=1})
  verify(r,"S21",{{"-3","17"},{"x","yz"}})
  n=n+1
end
-- case 1060: int64 + S8, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int64"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=-1})
  verify(r,"S21",{{"-3","17","x","yz"}})
  n=n+1
end
-- case 1061: int64 + S8, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int64"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=1})
  verify(r,"S21",{{"-3"},{"17"},{"x"},{"yz"}})
  n=n+1
end
-- case 1062: int64 + S8, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int64"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=-1})
  verify(r,"S21",{{"-3","x"},{"17","yz"}})
  n=n+1
end
-- case 1063: int64 + S8, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int64"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=1})
  verify(r,"S21",{{"-3","17"},{"x","yz"}})
  n=n+1
end
-- case 1064: int64 + S8, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int64"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=-1})
  verify(r,"S21",{{"-3","x"},{"17","yz"}})
  n=n+1
end
-- case 1065: int64 + S8, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int64"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=1})
  verify(r,"S21",{{{"-3","17"}},{{"x","yz"}}})
  n=n+1
end
-- case 1066: int64 + S8, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int64"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=-1})
  verify(r,"S21",{{{"-3","x"},{"17","yz"}}})
  n=n+1
end
-- case 1067: int64 + S8, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int64"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=1})
  verify(r,"S21",{{{"-3"},{"17"}},{{"x"},{"yz"}}})
  n=n+1
end
-- case 1068: int64 + S8, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int64"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=-1})
  verify(r,"S21",{{{"-3","x"}},{{"17","yz"}}})
  n=n+1
end
-- case 1069: int64 + S8, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({-3,17},"int64"),{2})},{axis=1})
  verify(r,"S21",{"x","yz","-3","17"})
  n=n+1
end
-- case 1070: int64 + S8, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({-3,17},"int64"),{2})},{axis=-1})
  verify(r,"S21",{"x","yz","-3","17"})
  n=n+1
end
-- case 1071: int64 + S8, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({-3,17},"int64"),{1,2})},{axis=1})
  verify(r,"S21",{{"x","yz"},{"-3","17"}})
  n=n+1
end
-- case 1072: int64 + S8, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({-3,17},"int64"),{1,2})},{axis=-1})
  verify(r,"S21",{{"x","yz","-3","17"}})
  n=n+1
end
-- case 1073: int64 + S8, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({-3,17},"int64"),{2,1})},{axis=1})
  verify(r,"S21",{{"x"},{"yz"},{"-3"},{"17"}})
  n=n+1
end
-- case 1074: int64 + S8, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({-3,17},"int64"),{2,1})},{axis=-1})
  verify(r,"S21",{{"x","-3"},{"yz","17"}})
  n=n+1
end
-- case 1075: int64 + S8, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({-3,17},"int64"),{2})},{axis=1})
  verify(r,"S21",{{"x","yz"},{"-3","17"}})
  n=n+1
end
-- case 1076: int64 + S8, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({-3,17},"int64"),{2})},{axis=-1})
  verify(r,"S21",{{"x","-3"},{"yz","17"}})
  n=n+1
end
-- case 1077: int64 + S8, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({-3,17},"int64"),{1,2})},{axis=1})
  verify(r,"S21",{{{"x","yz"}},{{"-3","17"}}})
  n=n+1
end
-- case 1078: int64 + S8, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({-3,17},"int64"),{1,2})},{axis=-1})
  verify(r,"S21",{{{"x","-3"},{"yz","17"}}})
  n=n+1
end
-- case 1079: int64 + S8, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({-3,17},"int64"),{2,1})},{axis=1})
  verify(r,"S21",{{{"x"},{"yz"}},{{"-3"},{"17"}}})
  n=n+1
end
-- case 1080: int64 + S8, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({-3,17},"int64"),{2,1})},{axis=-1})
  verify(r,"S21",{{{"x","-3"}},{{"yz","17"}}})
  n=n+1
end
-- case 1081: int64 + U1, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int64"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=1})
  verify(r,"U21",{"-3","17","x","é"})
  n=n+1
end
-- case 1082: int64 + U1, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int64"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=-1})
  verify(r,"U21",{"-3","17","x","é"})
  n=n+1
end
-- case 1083: int64 + U1, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int64"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=1})
  verify(r,"U21",{{"-3","17"},{"x","é"}})
  n=n+1
end
-- case 1084: int64 + U1, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int64"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=-1})
  verify(r,"U21",{{"-3","17","x","é"}})
  n=n+1
end
-- case 1085: int64 + U1, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int64"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=1})
  verify(r,"U21",{{"-3"},{"17"},{"x"},{"é"}})
  n=n+1
end
-- case 1086: int64 + U1, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int64"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=-1})
  verify(r,"U21",{{"-3","x"},{"17","é"}})
  n=n+1
end
-- case 1087: int64 + U1, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int64"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=1})
  verify(r,"U21",{{"-3","17"},{"x","é"}})
  n=n+1
end
-- case 1088: int64 + U1, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int64"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=-1})
  verify(r,"U21",{{"-3","x"},{"17","é"}})
  n=n+1
end
-- case 1089: int64 + U1, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int64"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=1})
  verify(r,"U21",{{{"-3","17"}},{{"x","é"}}})
  n=n+1
end
-- case 1090: int64 + U1, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int64"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=-1})
  verify(r,"U21",{{{"-3","x"},{"17","é"}}})
  n=n+1
end
-- case 1091: int64 + U1, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int64"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=1})
  verify(r,"U21",{{{"-3"},{"17"}},{{"x"},{"é"}}})
  n=n+1
end
-- case 1092: int64 + U1, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int64"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=-1})
  verify(r,"U21",{{{"-3","x"}},{{"17","é"}}})
  n=n+1
end
-- case 1093: int64 + U1, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({-3,17},"int64"),{2})},{axis=1})
  verify(r,"U21",{"x","é","-3","17"})
  n=n+1
end
-- case 1094: int64 + U1, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({-3,17},"int64"),{2})},{axis=-1})
  verify(r,"U21",{"x","é","-3","17"})
  n=n+1
end
-- case 1095: int64 + U1, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({-3,17},"int64"),{1,2})},{axis=1})
  verify(r,"U21",{{"x","é"},{"-3","17"}})
  n=n+1
end
-- case 1096: int64 + U1, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({-3,17},"int64"),{1,2})},{axis=-1})
  verify(r,"U21",{{"x","é","-3","17"}})
  n=n+1
end
-- case 1097: int64 + U1, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({-3,17},"int64"),{2,1})},{axis=1})
  verify(r,"U21",{{"x"},{"é"},{"-3"},{"17"}})
  n=n+1
end
-- case 1098: int64 + U1, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({-3,17},"int64"),{2,1})},{axis=-1})
  verify(r,"U21",{{"x","-3"},{"é","17"}})
  n=n+1
end
-- case 1099: int64 + U1, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({-3,17},"int64"),{2})},{axis=1})
  verify(r,"U21",{{"x","é"},{"-3","17"}})
  n=n+1
end
-- case 1100: int64 + U1, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({-3,17},"int64"),{2})},{axis=-1})
  verify(r,"U21",{{"x","-3"},{"é","17"}})
  n=n+1
end
-- case 1101: int64 + U1, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({-3,17},"int64"),{1,2})},{axis=1})
  verify(r,"U21",{{{"x","é"}},{{"-3","17"}}})
  n=n+1
end
-- case 1102: int64 + U1, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({-3,17},"int64"),{1,2})},{axis=-1})
  verify(r,"U21",{{{"x","-3"},{"é","17"}}})
  n=n+1
end
-- case 1103: int64 + U1, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({-3,17},"int64"),{2,1})},{axis=1})
  verify(r,"U21",{{{"x"},{"é"}},{{"-3"},{"17"}}})
  n=n+1
end
-- case 1104: int64 + U1, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({-3,17},"int64"),{2,1})},{axis=-1})
  verify(r,"U21",{{{"x","-3"}},{{"é","17"}}})
  n=n+1
end
-- case 1105: int64 + U3, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int64"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=1})
  verify(r,"U21",{"-3","17","x","é"})
  n=n+1
end
-- case 1106: int64 + U3, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int64"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=-1})
  verify(r,"U21",{"-3","17","x","é"})
  n=n+1
end
-- case 1107: int64 + U3, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int64"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=1})
  verify(r,"U21",{{"-3","17"},{"x","é"}})
  n=n+1
end
-- case 1108: int64 + U3, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int64"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=-1})
  verify(r,"U21",{{"-3","17","x","é"}})
  n=n+1
end
-- case 1109: int64 + U3, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int64"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=1})
  verify(r,"U21",{{"-3"},{"17"},{"x"},{"é"}})
  n=n+1
end
-- case 1110: int64 + U3, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int64"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=-1})
  verify(r,"U21",{{"-3","x"},{"17","é"}})
  n=n+1
end
-- case 1111: int64 + U3, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int64"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=1})
  verify(r,"U21",{{"-3","17"},{"x","é"}})
  n=n+1
end
-- case 1112: int64 + U3, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int64"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=-1})
  verify(r,"U21",{{"-3","x"},{"17","é"}})
  n=n+1
end
-- case 1113: int64 + U3, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int64"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=1})
  verify(r,"U21",{{{"-3","17"}},{{"x","é"}}})
  n=n+1
end
-- case 1114: int64 + U3, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int64"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=-1})
  verify(r,"U21",{{{"-3","x"},{"17","é"}}})
  n=n+1
end
-- case 1115: int64 + U3, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int64"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=1})
  verify(r,"U21",{{{"-3"},{"17"}},{{"x"},{"é"}}})
  n=n+1
end
-- case 1116: int64 + U3, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int64"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=-1})
  verify(r,"U21",{{{"-3","x"}},{{"17","é"}}})
  n=n+1
end
-- case 1117: int64 + U3, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({-3,17},"int64"),{2})},{axis=1})
  verify(r,"U21",{"x","é","-3","17"})
  n=n+1
end
-- case 1118: int64 + U3, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({-3,17},"int64"),{2})},{axis=-1})
  verify(r,"U21",{"x","é","-3","17"})
  n=n+1
end
-- case 1119: int64 + U3, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({-3,17},"int64"),{1,2})},{axis=1})
  verify(r,"U21",{{"x","é"},{"-3","17"}})
  n=n+1
end
-- case 1120: int64 + U3, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({-3,17},"int64"),{1,2})},{axis=-1})
  verify(r,"U21",{{"x","é","-3","17"}})
  n=n+1
end
-- case 1121: int64 + U3, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({-3,17},"int64"),{2,1})},{axis=1})
  verify(r,"U21",{{"x"},{"é"},{"-3"},{"17"}})
  n=n+1
end
-- case 1122: int64 + U3, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({-3,17},"int64"),{2,1})},{axis=-1})
  verify(r,"U21",{{"x","-3"},{"é","17"}})
  n=n+1
end
-- case 1123: int64 + U3, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({-3,17},"int64"),{2})},{axis=1})
  verify(r,"U21",{{"x","é"},{"-3","17"}})
  n=n+1
end
-- case 1124: int64 + U3, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({-3,17},"int64"),{2})},{axis=-1})
  verify(r,"U21",{{"x","-3"},{"é","17"}})
  n=n+1
end
-- case 1125: int64 + U3, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({-3,17},"int64"),{1,2})},{axis=1})
  verify(r,"U21",{{{"x","é"}},{{"-3","17"}}})
  n=n+1
end
-- case 1126: int64 + U3, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({-3,17},"int64"),{1,2})},{axis=-1})
  verify(r,"U21",{{{"x","-3"},{"é","17"}}})
  n=n+1
end
-- case 1127: int64 + U3, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({-3,17},"int64"),{2,1})},{axis=1})
  verify(r,"U21",{{{"x"},{"é"}},{{"-3"},{"17"}}})
  n=n+1
end
-- case 1128: int64 + U3, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({-3,17},"int64"),{2,1})},{axis=-1})
  verify(r,"U21",{{{"x","-3"}},{{"é","17"}}})
  n=n+1
end
-- case 1129: int64 + U8, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int64"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=1})
  verify(r,"U21",{"-3","17","x","é"})
  n=n+1
end
-- case 1130: int64 + U8, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int64"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=-1})
  verify(r,"U21",{"-3","17","x","é"})
  n=n+1
end
-- case 1131: int64 + U8, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int64"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=1})
  verify(r,"U21",{{"-3","17"},{"x","é"}})
  n=n+1
end
-- case 1132: int64 + U8, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int64"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=-1})
  verify(r,"U21",{{"-3","17","x","é"}})
  n=n+1
end
-- case 1133: int64 + U8, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int64"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=1})
  verify(r,"U21",{{"-3"},{"17"},{"x"},{"é"}})
  n=n+1
end
-- case 1134: int64 + U8, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-3,17},"int64"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=-1})
  verify(r,"U21",{{"-3","x"},{"17","é"}})
  n=n+1
end
-- case 1135: int64 + U8, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int64"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=1})
  verify(r,"U21",{{"-3","17"},{"x","é"}})
  n=n+1
end
-- case 1136: int64 + U8, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int64"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=-1})
  verify(r,"U21",{{"-3","x"},{"17","é"}})
  n=n+1
end
-- case 1137: int64 + U8, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int64"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=1})
  verify(r,"U21",{{{"-3","17"}},{{"x","é"}}})
  n=n+1
end
-- case 1138: int64 + U8, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int64"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=-1})
  verify(r,"U21",{{{"-3","x"},{"17","é"}}})
  n=n+1
end
-- case 1139: int64 + U8, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int64"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=1})
  verify(r,"U21",{{{"-3"},{"17"}},{{"x"},{"é"}}})
  n=n+1
end
-- case 1140: int64 + U8, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-3,17},"int64"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=-1})
  verify(r,"U21",{{{"-3","x"}},{{"17","é"}}})
  n=n+1
end
-- case 1141: int64 + U8, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({-3,17},"int64"),{2})},{axis=1})
  verify(r,"U21",{"x","é","-3","17"})
  n=n+1
end
-- case 1142: int64 + U8, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({-3,17},"int64"),{2})},{axis=-1})
  verify(r,"U21",{"x","é","-3","17"})
  n=n+1
end
-- case 1143: int64 + U8, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({-3,17},"int64"),{1,2})},{axis=1})
  verify(r,"U21",{{"x","é"},{"-3","17"}})
  n=n+1
end
-- case 1144: int64 + U8, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({-3,17},"int64"),{1,2})},{axis=-1})
  verify(r,"U21",{{"x","é","-3","17"}})
  n=n+1
end
-- case 1145: int64 + U8, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({-3,17},"int64"),{2,1})},{axis=1})
  verify(r,"U21",{{"x"},{"é"},{"-3"},{"17"}})
  n=n+1
end
-- case 1146: int64 + U8, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({-3,17},"int64"),{2,1})},{axis=-1})
  verify(r,"U21",{{"x","-3"},{"é","17"}})
  n=n+1
end
-- case 1147: int64 + U8, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({-3,17},"int64"),{2})},{axis=1})
  verify(r,"U21",{{"x","é"},{"-3","17"}})
  n=n+1
end
-- case 1148: int64 + U8, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({-3,17},"int64"),{2})},{axis=-1})
  verify(r,"U21",{{"x","-3"},{"é","17"}})
  n=n+1
end
-- case 1149: int64 + U8, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({-3,17},"int64"),{1,2})},{axis=1})
  verify(r,"U21",{{{"x","é"}},{{"-3","17"}}})
  n=n+1
end
-- case 1150: int64 + U8, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({-3,17},"int64"),{1,2})},{axis=-1})
  verify(r,"U21",{{{"x","-3"},{"é","17"}}})
  n=n+1
end
-- case 1151: int64 + U8, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({-3,17},"int64"),{2,1})},{axis=1})
  verify(r,"U21",{{{"x"},{"é"}},{{"-3"},{"17"}}})
  n=n+1
end
-- case 1152: int64 + U8, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({-3,17},"int64"),{2,1})},{axis=-1})
  verify(r,"U21",{{{"x","-3"}},{{"é","17"}}})
  n=n+1
end
-- case 1153: uint64 + S1, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint64"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=1})
  verify(r,"S20",{"3","17","x","y"})
  n=n+1
end
-- case 1154: uint64 + S1, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint64"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=-1})
  verify(r,"S20",{"3","17","x","y"})
  n=n+1
end
-- case 1155: uint64 + S1, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint64"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=1})
  verify(r,"S20",{{"3","17"},{"x","y"}})
  n=n+1
end
-- case 1156: uint64 + S1, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint64"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=-1})
  verify(r,"S20",{{"3","17","x","y"}})
  n=n+1
end
-- case 1157: uint64 + S1, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint64"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=1})
  verify(r,"S20",{{"3"},{"17"},{"x"},{"y"}})
  n=n+1
end
-- case 1158: uint64 + S1, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint64"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=-1})
  verify(r,"S20",{{"3","x"},{"17","y"}})
  n=n+1
end
-- case 1159: uint64 + S1, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint64"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=1})
  verify(r,"S20",{{"3","17"},{"x","y"}})
  n=n+1
end
-- case 1160: uint64 + S1, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint64"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=-1})
  verify(r,"S20",{{"3","x"},{"17","y"}})
  n=n+1
end
-- case 1161: uint64 + S1, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint64"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=1})
  verify(r,"S20",{{{"3","17"}},{{"x","y"}}})
  n=n+1
end
-- case 1162: uint64 + S1, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint64"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=-1})
  verify(r,"S20",{{{"3","x"},{"17","y"}}})
  n=n+1
end
-- case 1163: uint64 + S1, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint64"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=1})
  verify(r,"S20",{{{"3"},{"17"}},{{"x"},{"y"}}})
  n=n+1
end
-- case 1164: uint64 + S1, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint64"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=-1})
  verify(r,"S20",{{{"3","x"}},{{"17","y"}}})
  n=n+1
end
-- case 1165: uint64 + S1, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({3,17},"uint64"),{2})},{axis=1})
  verify(r,"S20",{"x","y","3","17"})
  n=n+1
end
-- case 1166: uint64 + S1, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({3,17},"uint64"),{2})},{axis=-1})
  verify(r,"S20",{"x","y","3","17"})
  n=n+1
end
-- case 1167: uint64 + S1, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({3,17},"uint64"),{1,2})},{axis=1})
  verify(r,"S20",{{"x","y"},{"3","17"}})
  n=n+1
end
-- case 1168: uint64 + S1, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({3,17},"uint64"),{1,2})},{axis=-1})
  verify(r,"S20",{{"x","y","3","17"}})
  n=n+1
end
-- case 1169: uint64 + S1, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({3,17},"uint64"),{2,1})},{axis=1})
  verify(r,"S20",{{"x"},{"y"},{"3"},{"17"}})
  n=n+1
end
-- case 1170: uint64 + S1, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({3,17},"uint64"),{2,1})},{axis=-1})
  verify(r,"S20",{{"x","3"},{"y","17"}})
  n=n+1
end
-- case 1171: uint64 + S1, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({3,17},"uint64"),{2})},{axis=1})
  verify(r,"S20",{{"x","y"},{"3","17"}})
  n=n+1
end
-- case 1172: uint64 + S1, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({3,17},"uint64"),{2})},{axis=-1})
  verify(r,"S20",{{"x","3"},{"y","17"}})
  n=n+1
end
-- case 1173: uint64 + S1, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({3,17},"uint64"),{1,2})},{axis=1})
  verify(r,"S20",{{{"x","y"}},{{"3","17"}}})
  n=n+1
end
-- case 1174: uint64 + S1, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({3,17},"uint64"),{1,2})},{axis=-1})
  verify(r,"S20",{{{"x","3"},{"y","17"}}})
  n=n+1
end
-- case 1175: uint64 + S1, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({3,17},"uint64"),{2,1})},{axis=1})
  verify(r,"S20",{{{"x"},{"y"}},{{"3"},{"17"}}})
  n=n+1
end
-- case 1176: uint64 + S1, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({3,17},"uint64"),{2,1})},{axis=-1})
  verify(r,"S20",{{{"x","3"}},{{"y","17"}}})
  n=n+1
end
-- case 1177: uint64 + S3, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint64"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=1})
  verify(r,"S20",{"3","17","x","yz"})
  n=n+1
end
-- case 1178: uint64 + S3, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint64"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=-1})
  verify(r,"S20",{"3","17","x","yz"})
  n=n+1
end
-- case 1179: uint64 + S3, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint64"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=1})
  verify(r,"S20",{{"3","17"},{"x","yz"}})
  n=n+1
end
-- case 1180: uint64 + S3, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint64"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=-1})
  verify(r,"S20",{{"3","17","x","yz"}})
  n=n+1
end
-- case 1181: uint64 + S3, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint64"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=1})
  verify(r,"S20",{{"3"},{"17"},{"x"},{"yz"}})
  n=n+1
end
-- case 1182: uint64 + S3, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint64"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=-1})
  verify(r,"S20",{{"3","x"},{"17","yz"}})
  n=n+1
end
-- case 1183: uint64 + S3, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint64"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=1})
  verify(r,"S20",{{"3","17"},{"x","yz"}})
  n=n+1
end
-- case 1184: uint64 + S3, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint64"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=-1})
  verify(r,"S20",{{"3","x"},{"17","yz"}})
  n=n+1
end
-- case 1185: uint64 + S3, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint64"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=1})
  verify(r,"S20",{{{"3","17"}},{{"x","yz"}}})
  n=n+1
end
-- case 1186: uint64 + S3, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint64"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=-1})
  verify(r,"S20",{{{"3","x"},{"17","yz"}}})
  n=n+1
end
-- case 1187: uint64 + S3, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint64"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=1})
  verify(r,"S20",{{{"3"},{"17"}},{{"x"},{"yz"}}})
  n=n+1
end
-- case 1188: uint64 + S3, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint64"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=-1})
  verify(r,"S20",{{{"3","x"}},{{"17","yz"}}})
  n=n+1
end
-- case 1189: uint64 + S3, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({3,17},"uint64"),{2})},{axis=1})
  verify(r,"S20",{"x","yz","3","17"})
  n=n+1
end
-- case 1190: uint64 + S3, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({3,17},"uint64"),{2})},{axis=-1})
  verify(r,"S20",{"x","yz","3","17"})
  n=n+1
end
-- case 1191: uint64 + S3, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({3,17},"uint64"),{1,2})},{axis=1})
  verify(r,"S20",{{"x","yz"},{"3","17"}})
  n=n+1
end
-- case 1192: uint64 + S3, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({3,17},"uint64"),{1,2})},{axis=-1})
  verify(r,"S20",{{"x","yz","3","17"}})
  n=n+1
end
-- case 1193: uint64 + S3, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({3,17},"uint64"),{2,1})},{axis=1})
  verify(r,"S20",{{"x"},{"yz"},{"3"},{"17"}})
  n=n+1
end
-- case 1194: uint64 + S3, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({3,17},"uint64"),{2,1})},{axis=-1})
  verify(r,"S20",{{"x","3"},{"yz","17"}})
  n=n+1
end
-- case 1195: uint64 + S3, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({3,17},"uint64"),{2})},{axis=1})
  verify(r,"S20",{{"x","yz"},{"3","17"}})
  n=n+1
end
-- case 1196: uint64 + S3, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({3,17},"uint64"),{2})},{axis=-1})
  verify(r,"S20",{{"x","3"},{"yz","17"}})
  n=n+1
end
-- case 1197: uint64 + S3, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({3,17},"uint64"),{1,2})},{axis=1})
  verify(r,"S20",{{{"x","yz"}},{{"3","17"}}})
  n=n+1
end
-- case 1198: uint64 + S3, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({3,17},"uint64"),{1,2})},{axis=-1})
  verify(r,"S20",{{{"x","3"},{"yz","17"}}})
  n=n+1
end
-- case 1199: uint64 + S3, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({3,17},"uint64"),{2,1})},{axis=1})
  verify(r,"S20",{{{"x"},{"yz"}},{{"3"},{"17"}}})
  n=n+1
end
-- case 1200: uint64 + S3, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({3,17},"uint64"),{2,1})},{axis=-1})
  verify(r,"S20",{{{"x","3"}},{{"yz","17"}}})
  n=n+1
end
-- case 1201: uint64 + S8, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint64"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=1})
  verify(r,"S20",{"3","17","x","yz"})
  n=n+1
end
-- case 1202: uint64 + S8, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint64"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=-1})
  verify(r,"S20",{"3","17","x","yz"})
  n=n+1
end
-- case 1203: uint64 + S8, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint64"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=1})
  verify(r,"S20",{{"3","17"},{"x","yz"}})
  n=n+1
end
-- case 1204: uint64 + S8, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint64"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=-1})
  verify(r,"S20",{{"3","17","x","yz"}})
  n=n+1
end
-- case 1205: uint64 + S8, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint64"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=1})
  verify(r,"S20",{{"3"},{"17"},{"x"},{"yz"}})
  n=n+1
end
-- case 1206: uint64 + S8, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint64"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=-1})
  verify(r,"S20",{{"3","x"},{"17","yz"}})
  n=n+1
end
-- case 1207: uint64 + S8, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint64"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=1})
  verify(r,"S20",{{"3","17"},{"x","yz"}})
  n=n+1
end
-- case 1208: uint64 + S8, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint64"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=-1})
  verify(r,"S20",{{"3","x"},{"17","yz"}})
  n=n+1
end
-- case 1209: uint64 + S8, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint64"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=1})
  verify(r,"S20",{{{"3","17"}},{{"x","yz"}}})
  n=n+1
end
-- case 1210: uint64 + S8, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint64"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=-1})
  verify(r,"S20",{{{"3","x"},{"17","yz"}}})
  n=n+1
end
-- case 1211: uint64 + S8, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint64"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=1})
  verify(r,"S20",{{{"3"},{"17"}},{{"x"},{"yz"}}})
  n=n+1
end
-- case 1212: uint64 + S8, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint64"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=-1})
  verify(r,"S20",{{{"3","x"}},{{"17","yz"}}})
  n=n+1
end
-- case 1213: uint64 + S8, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({3,17},"uint64"),{2})},{axis=1})
  verify(r,"S20",{"x","yz","3","17"})
  n=n+1
end
-- case 1214: uint64 + S8, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({3,17},"uint64"),{2})},{axis=-1})
  verify(r,"S20",{"x","yz","3","17"})
  n=n+1
end
-- case 1215: uint64 + S8, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({3,17},"uint64"),{1,2})},{axis=1})
  verify(r,"S20",{{"x","yz"},{"3","17"}})
  n=n+1
end
-- case 1216: uint64 + S8, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({3,17},"uint64"),{1,2})},{axis=-1})
  verify(r,"S20",{{"x","yz","3","17"}})
  n=n+1
end
-- case 1217: uint64 + S8, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({3,17},"uint64"),{2,1})},{axis=1})
  verify(r,"S20",{{"x"},{"yz"},{"3"},{"17"}})
  n=n+1
end
-- case 1218: uint64 + S8, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({3,17},"uint64"),{2,1})},{axis=-1})
  verify(r,"S20",{{"x","3"},{"yz","17"}})
  n=n+1
end
-- case 1219: uint64 + S8, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({3,17},"uint64"),{2})},{axis=1})
  verify(r,"S20",{{"x","yz"},{"3","17"}})
  n=n+1
end
-- case 1220: uint64 + S8, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({3,17},"uint64"),{2})},{axis=-1})
  verify(r,"S20",{{"x","3"},{"yz","17"}})
  n=n+1
end
-- case 1221: uint64 + S8, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({3,17},"uint64"),{1,2})},{axis=1})
  verify(r,"S20",{{{"x","yz"}},{{"3","17"}}})
  n=n+1
end
-- case 1222: uint64 + S8, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({3,17},"uint64"),{1,2})},{axis=-1})
  verify(r,"S20",{{{"x","3"},{"yz","17"}}})
  n=n+1
end
-- case 1223: uint64 + S8, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({3,17},"uint64"),{2,1})},{axis=1})
  verify(r,"S20",{{{"x"},{"yz"}},{{"3"},{"17"}}})
  n=n+1
end
-- case 1224: uint64 + S8, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({3,17},"uint64"),{2,1})},{axis=-1})
  verify(r,"S20",{{{"x","3"}},{{"yz","17"}}})
  n=n+1
end
-- case 1225: uint64 + U1, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint64"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=1})
  verify(r,"U20",{"3","17","x","é"})
  n=n+1
end
-- case 1226: uint64 + U1, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint64"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=-1})
  verify(r,"U20",{"3","17","x","é"})
  n=n+1
end
-- case 1227: uint64 + U1, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint64"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=1})
  verify(r,"U20",{{"3","17"},{"x","é"}})
  n=n+1
end
-- case 1228: uint64 + U1, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint64"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=-1})
  verify(r,"U20",{{"3","17","x","é"}})
  n=n+1
end
-- case 1229: uint64 + U1, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint64"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=1})
  verify(r,"U20",{{"3"},{"17"},{"x"},{"é"}})
  n=n+1
end
-- case 1230: uint64 + U1, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint64"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=-1})
  verify(r,"U20",{{"3","x"},{"17","é"}})
  n=n+1
end
-- case 1231: uint64 + U1, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint64"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=1})
  verify(r,"U20",{{"3","17"},{"x","é"}})
  n=n+1
end
-- case 1232: uint64 + U1, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint64"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=-1})
  verify(r,"U20",{{"3","x"},{"17","é"}})
  n=n+1
end
-- case 1233: uint64 + U1, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint64"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=1})
  verify(r,"U20",{{{"3","17"}},{{"x","é"}}})
  n=n+1
end
-- case 1234: uint64 + U1, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint64"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=-1})
  verify(r,"U20",{{{"3","x"},{"17","é"}}})
  n=n+1
end
-- case 1235: uint64 + U1, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint64"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=1})
  verify(r,"U20",{{{"3"},{"17"}},{{"x"},{"é"}}})
  n=n+1
end
-- case 1236: uint64 + U1, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint64"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=-1})
  verify(r,"U20",{{{"3","x"}},{{"17","é"}}})
  n=n+1
end
-- case 1237: uint64 + U1, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({3,17},"uint64"),{2})},{axis=1})
  verify(r,"U20",{"x","é","3","17"})
  n=n+1
end
-- case 1238: uint64 + U1, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({3,17},"uint64"),{2})},{axis=-1})
  verify(r,"U20",{"x","é","3","17"})
  n=n+1
end
-- case 1239: uint64 + U1, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({3,17},"uint64"),{1,2})},{axis=1})
  verify(r,"U20",{{"x","é"},{"3","17"}})
  n=n+1
end
-- case 1240: uint64 + U1, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({3,17},"uint64"),{1,2})},{axis=-1})
  verify(r,"U20",{{"x","é","3","17"}})
  n=n+1
end
-- case 1241: uint64 + U1, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({3,17},"uint64"),{2,1})},{axis=1})
  verify(r,"U20",{{"x"},{"é"},{"3"},{"17"}})
  n=n+1
end
-- case 1242: uint64 + U1, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({3,17},"uint64"),{2,1})},{axis=-1})
  verify(r,"U20",{{"x","3"},{"é","17"}})
  n=n+1
end
-- case 1243: uint64 + U1, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({3,17},"uint64"),{2})},{axis=1})
  verify(r,"U20",{{"x","é"},{"3","17"}})
  n=n+1
end
-- case 1244: uint64 + U1, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({3,17},"uint64"),{2})},{axis=-1})
  verify(r,"U20",{{"x","3"},{"é","17"}})
  n=n+1
end
-- case 1245: uint64 + U1, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({3,17},"uint64"),{1,2})},{axis=1})
  verify(r,"U20",{{{"x","é"}},{{"3","17"}}})
  n=n+1
end
-- case 1246: uint64 + U1, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({3,17},"uint64"),{1,2})},{axis=-1})
  verify(r,"U20",{{{"x","3"},{"é","17"}}})
  n=n+1
end
-- case 1247: uint64 + U1, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({3,17},"uint64"),{2,1})},{axis=1})
  verify(r,"U20",{{{"x"},{"é"}},{{"3"},{"17"}}})
  n=n+1
end
-- case 1248: uint64 + U1, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({3,17},"uint64"),{2,1})},{axis=-1})
  verify(r,"U20",{{{"x","3"}},{{"é","17"}}})
  n=n+1
end
-- case 1249: uint64 + U3, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint64"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=1})
  verify(r,"U20",{"3","17","x","é"})
  n=n+1
end
-- case 1250: uint64 + U3, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint64"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=-1})
  verify(r,"U20",{"3","17","x","é"})
  n=n+1
end
-- case 1251: uint64 + U3, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint64"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=1})
  verify(r,"U20",{{"3","17"},{"x","é"}})
  n=n+1
end
-- case 1252: uint64 + U3, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint64"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=-1})
  verify(r,"U20",{{"3","17","x","é"}})
  n=n+1
end
-- case 1253: uint64 + U3, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint64"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=1})
  verify(r,"U20",{{"3"},{"17"},{"x"},{"é"}})
  n=n+1
end
-- case 1254: uint64 + U3, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint64"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=-1})
  verify(r,"U20",{{"3","x"},{"17","é"}})
  n=n+1
end
-- case 1255: uint64 + U3, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint64"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=1})
  verify(r,"U20",{{"3","17"},{"x","é"}})
  n=n+1
end
-- case 1256: uint64 + U3, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint64"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=-1})
  verify(r,"U20",{{"3","x"},{"17","é"}})
  n=n+1
end
-- case 1257: uint64 + U3, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint64"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=1})
  verify(r,"U20",{{{"3","17"}},{{"x","é"}}})
  n=n+1
end
-- case 1258: uint64 + U3, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint64"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=-1})
  verify(r,"U20",{{{"3","x"},{"17","é"}}})
  n=n+1
end
-- case 1259: uint64 + U3, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint64"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=1})
  verify(r,"U20",{{{"3"},{"17"}},{{"x"},{"é"}}})
  n=n+1
end
-- case 1260: uint64 + U3, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint64"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=-1})
  verify(r,"U20",{{{"3","x"}},{{"17","é"}}})
  n=n+1
end
-- case 1261: uint64 + U3, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({3,17},"uint64"),{2})},{axis=1})
  verify(r,"U20",{"x","é","3","17"})
  n=n+1
end
-- case 1262: uint64 + U3, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({3,17},"uint64"),{2})},{axis=-1})
  verify(r,"U20",{"x","é","3","17"})
  n=n+1
end
-- case 1263: uint64 + U3, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({3,17},"uint64"),{1,2})},{axis=1})
  verify(r,"U20",{{"x","é"},{"3","17"}})
  n=n+1
end
-- case 1264: uint64 + U3, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({3,17},"uint64"),{1,2})},{axis=-1})
  verify(r,"U20",{{"x","é","3","17"}})
  n=n+1
end
-- case 1265: uint64 + U3, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({3,17},"uint64"),{2,1})},{axis=1})
  verify(r,"U20",{{"x"},{"é"},{"3"},{"17"}})
  n=n+1
end
-- case 1266: uint64 + U3, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({3,17},"uint64"),{2,1})},{axis=-1})
  verify(r,"U20",{{"x","3"},{"é","17"}})
  n=n+1
end
-- case 1267: uint64 + U3, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({3,17},"uint64"),{2})},{axis=1})
  verify(r,"U20",{{"x","é"},{"3","17"}})
  n=n+1
end
-- case 1268: uint64 + U3, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({3,17},"uint64"),{2})},{axis=-1})
  verify(r,"U20",{{"x","3"},{"é","17"}})
  n=n+1
end
-- case 1269: uint64 + U3, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({3,17},"uint64"),{1,2})},{axis=1})
  verify(r,"U20",{{{"x","é"}},{{"3","17"}}})
  n=n+1
end
-- case 1270: uint64 + U3, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({3,17},"uint64"),{1,2})},{axis=-1})
  verify(r,"U20",{{{"x","3"},{"é","17"}}})
  n=n+1
end
-- case 1271: uint64 + U3, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({3,17},"uint64"),{2,1})},{axis=1})
  verify(r,"U20",{{{"x"},{"é"}},{{"3"},{"17"}}})
  n=n+1
end
-- case 1272: uint64 + U3, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({3,17},"uint64"),{2,1})},{axis=-1})
  verify(r,"U20",{{{"x","3"}},{{"é","17"}}})
  n=n+1
end
-- case 1273: uint64 + U8, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint64"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=1})
  verify(r,"U20",{"3","17","x","é"})
  n=n+1
end
-- case 1274: uint64 + U8, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint64"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=-1})
  verify(r,"U20",{"3","17","x","é"})
  n=n+1
end
-- case 1275: uint64 + U8, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint64"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=1})
  verify(r,"U20",{{"3","17"},{"x","é"}})
  n=n+1
end
-- case 1276: uint64 + U8, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint64"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=-1})
  verify(r,"U20",{{"3","17","x","é"}})
  n=n+1
end
-- case 1277: uint64 + U8, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint64"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=1})
  verify(r,"U20",{{"3"},{"17"},{"x"},{"é"}})
  n=n+1
end
-- case 1278: uint64 + U8, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({3,17},"uint64"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=-1})
  verify(r,"U20",{{"3","x"},{"17","é"}})
  n=n+1
end
-- case 1279: uint64 + U8, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint64"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=1})
  verify(r,"U20",{{"3","17"},{"x","é"}})
  n=n+1
end
-- case 1280: uint64 + U8, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint64"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=-1})
  verify(r,"U20",{{"3","x"},{"17","é"}})
  n=n+1
end
-- case 1281: uint64 + U8, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint64"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=1})
  verify(r,"U20",{{{"3","17"}},{{"x","é"}}})
  n=n+1
end
-- case 1282: uint64 + U8, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint64"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=-1})
  verify(r,"U20",{{{"3","x"},{"17","é"}}})
  n=n+1
end
-- case 1283: uint64 + U8, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint64"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=1})
  verify(r,"U20",{{{"3"},{"17"}},{{"x"},{"é"}}})
  n=n+1
end
-- case 1284: uint64 + U8, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({3,17},"uint64"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=-1})
  verify(r,"U20",{{{"3","x"}},{{"17","é"}}})
  n=n+1
end
-- case 1285: uint64 + U8, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({3,17},"uint64"),{2})},{axis=1})
  verify(r,"U20",{"x","é","3","17"})
  n=n+1
end
-- case 1286: uint64 + U8, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({3,17},"uint64"),{2})},{axis=-1})
  verify(r,"U20",{"x","é","3","17"})
  n=n+1
end
-- case 1287: uint64 + U8, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({3,17},"uint64"),{1,2})},{axis=1})
  verify(r,"U20",{{"x","é"},{"3","17"}})
  n=n+1
end
-- case 1288: uint64 + U8, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({3,17},"uint64"),{1,2})},{axis=-1})
  verify(r,"U20",{{"x","é","3","17"}})
  n=n+1
end
-- case 1289: uint64 + U8, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({3,17},"uint64"),{2,1})},{axis=1})
  verify(r,"U20",{{"x"},{"é"},{"3"},{"17"}})
  n=n+1
end
-- case 1290: uint64 + U8, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({3,17},"uint64"),{2,1})},{axis=-1})
  verify(r,"U20",{{"x","3"},{"é","17"}})
  n=n+1
end
-- case 1291: uint64 + U8, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({3,17},"uint64"),{2})},{axis=1})
  verify(r,"U20",{{"x","é"},{"3","17"}})
  n=n+1
end
-- case 1292: uint64 + U8, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({3,17},"uint64"),{2})},{axis=-1})
  verify(r,"U20",{{"x","3"},{"é","17"}})
  n=n+1
end
-- case 1293: uint64 + U8, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({3,17},"uint64"),{1,2})},{axis=1})
  verify(r,"U20",{{{"x","é"}},{{"3","17"}}})
  n=n+1
end
-- case 1294: uint64 + U8, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({3,17},"uint64"),{1,2})},{axis=-1})
  verify(r,"U20",{{{"x","3"},{"é","17"}}})
  n=n+1
end
-- case 1295: uint64 + U8, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({3,17},"uint64"),{2,1})},{axis=1})
  verify(r,"U20",{{{"x"},{"é"}},{{"3"},{"17"}}})
  n=n+1
end
-- case 1296: uint64 + U8, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({3,17},"uint64"),{2,1})},{axis=-1})
  verify(r,"U20",{{{"x","3"}},{{"é","17"}}})
  n=n+1
end
-- case 1297: float16 + S1, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float16"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=1})
  verify(r,"S32",{"-1.5","2.25","x","y"})
  n=n+1
end
-- case 1298: float16 + S1, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float16"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=-1})
  verify(r,"S32",{"-1.5","2.25","x","y"})
  n=n+1
end
-- case 1299: float16 + S1, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float16"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=1})
  verify(r,"S32",{{"-1.5","2.25"},{"x","y"}})
  n=n+1
end
-- case 1300: float16 + S1, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float16"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=-1})
  verify(r,"S32",{{"-1.5","2.25","x","y"}})
  n=n+1
end
-- case 1301: float16 + S1, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float16"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=1})
  verify(r,"S32",{{"-1.5"},{"2.25"},{"x"},{"y"}})
  n=n+1
end
-- case 1302: float16 + S1, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float16"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=-1})
  verify(r,"S32",{{"-1.5","x"},{"2.25","y"}})
  n=n+1
end
-- case 1303: float16 + S1, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float16"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=1})
  verify(r,"S32",{{"-1.5","2.25"},{"x","y"}})
  n=n+1
end
-- case 1304: float16 + S1, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float16"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=-1})
  verify(r,"S32",{{"-1.5","x"},{"2.25","y"}})
  n=n+1
end
-- case 1305: float16 + S1, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float16"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=1})
  verify(r,"S32",{{{"-1.5","2.25"}},{{"x","y"}}})
  n=n+1
end
-- case 1306: float16 + S1, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float16"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=-1})
  verify(r,"S32",{{{"-1.5","x"},{"2.25","y"}}})
  n=n+1
end
-- case 1307: float16 + S1, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float16"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=1})
  verify(r,"S32",{{{"-1.5"},{"2.25"}},{{"x"},{"y"}}})
  n=n+1
end
-- case 1308: float16 + S1, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float16"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=-1})
  verify(r,"S32",{{{"-1.5","x"}},{{"2.25","y"}}})
  n=n+1
end
-- case 1309: float16 + S1, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({-1.5,2.25},"float16"),{2})},{axis=1})
  verify(r,"S32",{"x","y","-1.5","2.25"})
  n=n+1
end
-- case 1310: float16 + S1, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({-1.5,2.25},"float16"),{2})},{axis=-1})
  verify(r,"S32",{"x","y","-1.5","2.25"})
  n=n+1
end
-- case 1311: float16 + S1, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({-1.5,2.25},"float16"),{1,2})},{axis=1})
  verify(r,"S32",{{"x","y"},{"-1.5","2.25"}})
  n=n+1
end
-- case 1312: float16 + S1, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({-1.5,2.25},"float16"),{1,2})},{axis=-1})
  verify(r,"S32",{{"x","y","-1.5","2.25"}})
  n=n+1
end
-- case 1313: float16 + S1, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({-1.5,2.25},"float16"),{2,1})},{axis=1})
  verify(r,"S32",{{"x"},{"y"},{"-1.5"},{"2.25"}})
  n=n+1
end
-- case 1314: float16 + S1, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({-1.5,2.25},"float16"),{2,1})},{axis=-1})
  verify(r,"S32",{{"x","-1.5"},{"y","2.25"}})
  n=n+1
end
-- case 1315: float16 + S1, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({-1.5,2.25},"float16"),{2})},{axis=1})
  verify(r,"S32",{{"x","y"},{"-1.5","2.25"}})
  n=n+1
end
-- case 1316: float16 + S1, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({-1.5,2.25},"float16"),{2})},{axis=-1})
  verify(r,"S32",{{"x","-1.5"},{"y","2.25"}})
  n=n+1
end
-- case 1317: float16 + S1, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({-1.5,2.25},"float16"),{1,2})},{axis=1})
  verify(r,"S32",{{{"x","y"}},{{"-1.5","2.25"}}})
  n=n+1
end
-- case 1318: float16 + S1, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({-1.5,2.25},"float16"),{1,2})},{axis=-1})
  verify(r,"S32",{{{"x","-1.5"},{"y","2.25"}}})
  n=n+1
end
-- case 1319: float16 + S1, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({-1.5,2.25},"float16"),{2,1})},{axis=1})
  verify(r,"S32",{{{"x"},{"y"}},{{"-1.5"},{"2.25"}}})
  n=n+1
end
-- case 1320: float16 + S1, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({-1.5,2.25},"float16"),{2,1})},{axis=-1})
  verify(r,"S32",{{{"x","-1.5"}},{{"y","2.25"}}})
  n=n+1
end
-- case 1321: float16 + S3, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float16"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=1})
  verify(r,"S32",{"-1.5","2.25","x","yz"})
  n=n+1
end
-- case 1322: float16 + S3, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float16"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=-1})
  verify(r,"S32",{"-1.5","2.25","x","yz"})
  n=n+1
end
-- case 1323: float16 + S3, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float16"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=1})
  verify(r,"S32",{{"-1.5","2.25"},{"x","yz"}})
  n=n+1
end
-- case 1324: float16 + S3, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float16"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=-1})
  verify(r,"S32",{{"-1.5","2.25","x","yz"}})
  n=n+1
end
-- case 1325: float16 + S3, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float16"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=1})
  verify(r,"S32",{{"-1.5"},{"2.25"},{"x"},{"yz"}})
  n=n+1
end
-- case 1326: float16 + S3, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float16"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=-1})
  verify(r,"S32",{{"-1.5","x"},{"2.25","yz"}})
  n=n+1
end
-- case 1327: float16 + S3, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float16"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=1})
  verify(r,"S32",{{"-1.5","2.25"},{"x","yz"}})
  n=n+1
end
-- case 1328: float16 + S3, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float16"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=-1})
  verify(r,"S32",{{"-1.5","x"},{"2.25","yz"}})
  n=n+1
end
-- case 1329: float16 + S3, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float16"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=1})
  verify(r,"S32",{{{"-1.5","2.25"}},{{"x","yz"}}})
  n=n+1
end
-- case 1330: float16 + S3, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float16"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=-1})
  verify(r,"S32",{{{"-1.5","x"},{"2.25","yz"}}})
  n=n+1
end
-- case 1331: float16 + S3, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float16"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=1})
  verify(r,"S32",{{{"-1.5"},{"2.25"}},{{"x"},{"yz"}}})
  n=n+1
end
-- case 1332: float16 + S3, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float16"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=-1})
  verify(r,"S32",{{{"-1.5","x"}},{{"2.25","yz"}}})
  n=n+1
end
-- case 1333: float16 + S3, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({-1.5,2.25},"float16"),{2})},{axis=1})
  verify(r,"S32",{"x","yz","-1.5","2.25"})
  n=n+1
end
-- case 1334: float16 + S3, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({-1.5,2.25},"float16"),{2})},{axis=-1})
  verify(r,"S32",{"x","yz","-1.5","2.25"})
  n=n+1
end
-- case 1335: float16 + S3, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({-1.5,2.25},"float16"),{1,2})},{axis=1})
  verify(r,"S32",{{"x","yz"},{"-1.5","2.25"}})
  n=n+1
end
-- case 1336: float16 + S3, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({-1.5,2.25},"float16"),{1,2})},{axis=-1})
  verify(r,"S32",{{"x","yz","-1.5","2.25"}})
  n=n+1
end
-- case 1337: float16 + S3, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({-1.5,2.25},"float16"),{2,1})},{axis=1})
  verify(r,"S32",{{"x"},{"yz"},{"-1.5"},{"2.25"}})
  n=n+1
end
-- case 1338: float16 + S3, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({-1.5,2.25},"float16"),{2,1})},{axis=-1})
  verify(r,"S32",{{"x","-1.5"},{"yz","2.25"}})
  n=n+1
end
-- case 1339: float16 + S3, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({-1.5,2.25},"float16"),{2})},{axis=1})
  verify(r,"S32",{{"x","yz"},{"-1.5","2.25"}})
  n=n+1
end
-- case 1340: float16 + S3, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({-1.5,2.25},"float16"),{2})},{axis=-1})
  verify(r,"S32",{{"x","-1.5"},{"yz","2.25"}})
  n=n+1
end
-- case 1341: float16 + S3, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({-1.5,2.25},"float16"),{1,2})},{axis=1})
  verify(r,"S32",{{{"x","yz"}},{{"-1.5","2.25"}}})
  n=n+1
end
-- case 1342: float16 + S3, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({-1.5,2.25},"float16"),{1,2})},{axis=-1})
  verify(r,"S32",{{{"x","-1.5"},{"yz","2.25"}}})
  n=n+1
end
-- case 1343: float16 + S3, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({-1.5,2.25},"float16"),{2,1})},{axis=1})
  verify(r,"S32",{{{"x"},{"yz"}},{{"-1.5"},{"2.25"}}})
  n=n+1
end
-- case 1344: float16 + S3, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({-1.5,2.25},"float16"),{2,1})},{axis=-1})
  verify(r,"S32",{{{"x","-1.5"}},{{"yz","2.25"}}})
  n=n+1
end
-- case 1345: float16 + S8, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float16"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=1})
  verify(r,"S32",{"-1.5","2.25","x","yz"})
  n=n+1
end
-- case 1346: float16 + S8, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float16"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=-1})
  verify(r,"S32",{"-1.5","2.25","x","yz"})
  n=n+1
end
-- case 1347: float16 + S8, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float16"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=1})
  verify(r,"S32",{{"-1.5","2.25"},{"x","yz"}})
  n=n+1
end
-- case 1348: float16 + S8, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float16"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=-1})
  verify(r,"S32",{{"-1.5","2.25","x","yz"}})
  n=n+1
end
-- case 1349: float16 + S8, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float16"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=1})
  verify(r,"S32",{{"-1.5"},{"2.25"},{"x"},{"yz"}})
  n=n+1
end
-- case 1350: float16 + S8, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float16"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=-1})
  verify(r,"S32",{{"-1.5","x"},{"2.25","yz"}})
  n=n+1
end
-- case 1351: float16 + S8, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float16"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=1})
  verify(r,"S32",{{"-1.5","2.25"},{"x","yz"}})
  n=n+1
end
-- case 1352: float16 + S8, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float16"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=-1})
  verify(r,"S32",{{"-1.5","x"},{"2.25","yz"}})
  n=n+1
end
-- case 1353: float16 + S8, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float16"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=1})
  verify(r,"S32",{{{"-1.5","2.25"}},{{"x","yz"}}})
  n=n+1
end
-- case 1354: float16 + S8, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float16"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=-1})
  verify(r,"S32",{{{"-1.5","x"},{"2.25","yz"}}})
  n=n+1
end
-- case 1355: float16 + S8, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float16"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=1})
  verify(r,"S32",{{{"-1.5"},{"2.25"}},{{"x"},{"yz"}}})
  n=n+1
end
-- case 1356: float16 + S8, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float16"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=-1})
  verify(r,"S32",{{{"-1.5","x"}},{{"2.25","yz"}}})
  n=n+1
end
-- case 1357: float16 + S8, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({-1.5,2.25},"float16"),{2})},{axis=1})
  verify(r,"S32",{"x","yz","-1.5","2.25"})
  n=n+1
end
-- case 1358: float16 + S8, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({-1.5,2.25},"float16"),{2})},{axis=-1})
  verify(r,"S32",{"x","yz","-1.5","2.25"})
  n=n+1
end
-- case 1359: float16 + S8, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({-1.5,2.25},"float16"),{1,2})},{axis=1})
  verify(r,"S32",{{"x","yz"},{"-1.5","2.25"}})
  n=n+1
end
-- case 1360: float16 + S8, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({-1.5,2.25},"float16"),{1,2})},{axis=-1})
  verify(r,"S32",{{"x","yz","-1.5","2.25"}})
  n=n+1
end
-- case 1361: float16 + S8, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({-1.5,2.25},"float16"),{2,1})},{axis=1})
  verify(r,"S32",{{"x"},{"yz"},{"-1.5"},{"2.25"}})
  n=n+1
end
-- case 1362: float16 + S8, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({-1.5,2.25},"float16"),{2,1})},{axis=-1})
  verify(r,"S32",{{"x","-1.5"},{"yz","2.25"}})
  n=n+1
end
-- case 1363: float16 + S8, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({-1.5,2.25},"float16"),{2})},{axis=1})
  verify(r,"S32",{{"x","yz"},{"-1.5","2.25"}})
  n=n+1
end
-- case 1364: float16 + S8, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({-1.5,2.25},"float16"),{2})},{axis=-1})
  verify(r,"S32",{{"x","-1.5"},{"yz","2.25"}})
  n=n+1
end
-- case 1365: float16 + S8, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({-1.5,2.25},"float16"),{1,2})},{axis=1})
  verify(r,"S32",{{{"x","yz"}},{{"-1.5","2.25"}}})
  n=n+1
end
-- case 1366: float16 + S8, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({-1.5,2.25},"float16"),{1,2})},{axis=-1})
  verify(r,"S32",{{{"x","-1.5"},{"yz","2.25"}}})
  n=n+1
end
-- case 1367: float16 + S8, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({-1.5,2.25},"float16"),{2,1})},{axis=1})
  verify(r,"S32",{{{"x"},{"yz"}},{{"-1.5"},{"2.25"}}})
  n=n+1
end
-- case 1368: float16 + S8, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({-1.5,2.25},"float16"),{2,1})},{axis=-1})
  verify(r,"S32",{{{"x","-1.5"}},{{"yz","2.25"}}})
  n=n+1
end
-- case 1369: float16 + U1, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float16"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=1})
  verify(r,"U32",{"-1.5","2.25","x","é"})
  n=n+1
end
-- case 1370: float16 + U1, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float16"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=-1})
  verify(r,"U32",{"-1.5","2.25","x","é"})
  n=n+1
end
-- case 1371: float16 + U1, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float16"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=1})
  verify(r,"U32",{{"-1.5","2.25"},{"x","é"}})
  n=n+1
end
-- case 1372: float16 + U1, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float16"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=-1})
  verify(r,"U32",{{"-1.5","2.25","x","é"}})
  n=n+1
end
-- case 1373: float16 + U1, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float16"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=1})
  verify(r,"U32",{{"-1.5"},{"2.25"},{"x"},{"é"}})
  n=n+1
end
-- case 1374: float16 + U1, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float16"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=-1})
  verify(r,"U32",{{"-1.5","x"},{"2.25","é"}})
  n=n+1
end
-- case 1375: float16 + U1, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float16"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=1})
  verify(r,"U32",{{"-1.5","2.25"},{"x","é"}})
  n=n+1
end
-- case 1376: float16 + U1, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float16"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=-1})
  verify(r,"U32",{{"-1.5","x"},{"2.25","é"}})
  n=n+1
end
-- case 1377: float16 + U1, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float16"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=1})
  verify(r,"U32",{{{"-1.5","2.25"}},{{"x","é"}}})
  n=n+1
end
-- case 1378: float16 + U1, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float16"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=-1})
  verify(r,"U32",{{{"-1.5","x"},{"2.25","é"}}})
  n=n+1
end
-- case 1379: float16 + U1, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float16"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=1})
  verify(r,"U32",{{{"-1.5"},{"2.25"}},{{"x"},{"é"}}})
  n=n+1
end
-- case 1380: float16 + U1, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float16"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=-1})
  verify(r,"U32",{{{"-1.5","x"}},{{"2.25","é"}}})
  n=n+1
end
-- case 1381: float16 + U1, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({-1.5,2.25},"float16"),{2})},{axis=1})
  verify(r,"U32",{"x","é","-1.5","2.25"})
  n=n+1
end
-- case 1382: float16 + U1, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({-1.5,2.25},"float16"),{2})},{axis=-1})
  verify(r,"U32",{"x","é","-1.5","2.25"})
  n=n+1
end
-- case 1383: float16 + U1, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({-1.5,2.25},"float16"),{1,2})},{axis=1})
  verify(r,"U32",{{"x","é"},{"-1.5","2.25"}})
  n=n+1
end
-- case 1384: float16 + U1, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({-1.5,2.25},"float16"),{1,2})},{axis=-1})
  verify(r,"U32",{{"x","é","-1.5","2.25"}})
  n=n+1
end
-- case 1385: float16 + U1, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({-1.5,2.25},"float16"),{2,1})},{axis=1})
  verify(r,"U32",{{"x"},{"é"},{"-1.5"},{"2.25"}})
  n=n+1
end
-- case 1386: float16 + U1, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({-1.5,2.25},"float16"),{2,1})},{axis=-1})
  verify(r,"U32",{{"x","-1.5"},{"é","2.25"}})
  n=n+1
end
-- case 1387: float16 + U1, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({-1.5,2.25},"float16"),{2})},{axis=1})
  verify(r,"U32",{{"x","é"},{"-1.5","2.25"}})
  n=n+1
end
-- case 1388: float16 + U1, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({-1.5,2.25},"float16"),{2})},{axis=-1})
  verify(r,"U32",{{"x","-1.5"},{"é","2.25"}})
  n=n+1
end
-- case 1389: float16 + U1, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({-1.5,2.25},"float16"),{1,2})},{axis=1})
  verify(r,"U32",{{{"x","é"}},{{"-1.5","2.25"}}})
  n=n+1
end
-- case 1390: float16 + U1, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({-1.5,2.25},"float16"),{1,2})},{axis=-1})
  verify(r,"U32",{{{"x","-1.5"},{"é","2.25"}}})
  n=n+1
end
-- case 1391: float16 + U1, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({-1.5,2.25},"float16"),{2,1})},{axis=1})
  verify(r,"U32",{{{"x"},{"é"}},{{"-1.5"},{"2.25"}}})
  n=n+1
end
-- case 1392: float16 + U1, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({-1.5,2.25},"float16"),{2,1})},{axis=-1})
  verify(r,"U32",{{{"x","-1.5"}},{{"é","2.25"}}})
  n=n+1
end
-- case 1393: float16 + U3, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float16"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=1})
  verify(r,"U32",{"-1.5","2.25","x","é"})
  n=n+1
end
-- case 1394: float16 + U3, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float16"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=-1})
  verify(r,"U32",{"-1.5","2.25","x","é"})
  n=n+1
end
-- case 1395: float16 + U3, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float16"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=1})
  verify(r,"U32",{{"-1.5","2.25"},{"x","é"}})
  n=n+1
end
-- case 1396: float16 + U3, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float16"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=-1})
  verify(r,"U32",{{"-1.5","2.25","x","é"}})
  n=n+1
end
-- case 1397: float16 + U3, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float16"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=1})
  verify(r,"U32",{{"-1.5"},{"2.25"},{"x"},{"é"}})
  n=n+1
end
-- case 1398: float16 + U3, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float16"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=-1})
  verify(r,"U32",{{"-1.5","x"},{"2.25","é"}})
  n=n+1
end
-- case 1399: float16 + U3, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float16"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=1})
  verify(r,"U32",{{"-1.5","2.25"},{"x","é"}})
  n=n+1
end
-- case 1400: float16 + U3, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float16"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=-1})
  verify(r,"U32",{{"-1.5","x"},{"2.25","é"}})
  n=n+1
end
-- case 1401: float16 + U3, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float16"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=1})
  verify(r,"U32",{{{"-1.5","2.25"}},{{"x","é"}}})
  n=n+1
end
-- case 1402: float16 + U3, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float16"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=-1})
  verify(r,"U32",{{{"-1.5","x"},{"2.25","é"}}})
  n=n+1
end
-- case 1403: float16 + U3, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float16"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=1})
  verify(r,"U32",{{{"-1.5"},{"2.25"}},{{"x"},{"é"}}})
  n=n+1
end
-- case 1404: float16 + U3, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float16"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=-1})
  verify(r,"U32",{{{"-1.5","x"}},{{"2.25","é"}}})
  n=n+1
end
-- case 1405: float16 + U3, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({-1.5,2.25},"float16"),{2})},{axis=1})
  verify(r,"U32",{"x","é","-1.5","2.25"})
  n=n+1
end
-- case 1406: float16 + U3, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({-1.5,2.25},"float16"),{2})},{axis=-1})
  verify(r,"U32",{"x","é","-1.5","2.25"})
  n=n+1
end
-- case 1407: float16 + U3, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({-1.5,2.25},"float16"),{1,2})},{axis=1})
  verify(r,"U32",{{"x","é"},{"-1.5","2.25"}})
  n=n+1
end
-- case 1408: float16 + U3, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({-1.5,2.25},"float16"),{1,2})},{axis=-1})
  verify(r,"U32",{{"x","é","-1.5","2.25"}})
  n=n+1
end
-- case 1409: float16 + U3, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({-1.5,2.25},"float16"),{2,1})},{axis=1})
  verify(r,"U32",{{"x"},{"é"},{"-1.5"},{"2.25"}})
  n=n+1
end
-- case 1410: float16 + U3, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({-1.5,2.25},"float16"),{2,1})},{axis=-1})
  verify(r,"U32",{{"x","-1.5"},{"é","2.25"}})
  n=n+1
end
-- case 1411: float16 + U3, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({-1.5,2.25},"float16"),{2})},{axis=1})
  verify(r,"U32",{{"x","é"},{"-1.5","2.25"}})
  n=n+1
end
-- case 1412: float16 + U3, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({-1.5,2.25},"float16"),{2})},{axis=-1})
  verify(r,"U32",{{"x","-1.5"},{"é","2.25"}})
  n=n+1
end
-- case 1413: float16 + U3, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({-1.5,2.25},"float16"),{1,2})},{axis=1})
  verify(r,"U32",{{{"x","é"}},{{"-1.5","2.25"}}})
  n=n+1
end
-- case 1414: float16 + U3, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({-1.5,2.25},"float16"),{1,2})},{axis=-1})
  verify(r,"U32",{{{"x","-1.5"},{"é","2.25"}}})
  n=n+1
end
-- case 1415: float16 + U3, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({-1.5,2.25},"float16"),{2,1})},{axis=1})
  verify(r,"U32",{{{"x"},{"é"}},{{"-1.5"},{"2.25"}}})
  n=n+1
end
-- case 1416: float16 + U3, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({-1.5,2.25},"float16"),{2,1})},{axis=-1})
  verify(r,"U32",{{{"x","-1.5"}},{{"é","2.25"}}})
  n=n+1
end
-- case 1417: float16 + U8, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float16"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=1})
  verify(r,"U32",{"-1.5","2.25","x","é"})
  n=n+1
end
-- case 1418: float16 + U8, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float16"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=-1})
  verify(r,"U32",{"-1.5","2.25","x","é"})
  n=n+1
end
-- case 1419: float16 + U8, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float16"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=1})
  verify(r,"U32",{{"-1.5","2.25"},{"x","é"}})
  n=n+1
end
-- case 1420: float16 + U8, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float16"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=-1})
  verify(r,"U32",{{"-1.5","2.25","x","é"}})
  n=n+1
end
-- case 1421: float16 + U8, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float16"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=1})
  verify(r,"U32",{{"-1.5"},{"2.25"},{"x"},{"é"}})
  n=n+1
end
-- case 1422: float16 + U8, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float16"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=-1})
  verify(r,"U32",{{"-1.5","x"},{"2.25","é"}})
  n=n+1
end
-- case 1423: float16 + U8, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float16"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=1})
  verify(r,"U32",{{"-1.5","2.25"},{"x","é"}})
  n=n+1
end
-- case 1424: float16 + U8, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float16"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=-1})
  verify(r,"U32",{{"-1.5","x"},{"2.25","é"}})
  n=n+1
end
-- case 1425: float16 + U8, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float16"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=1})
  verify(r,"U32",{{{"-1.5","2.25"}},{{"x","é"}}})
  n=n+1
end
-- case 1426: float16 + U8, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float16"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=-1})
  verify(r,"U32",{{{"-1.5","x"},{"2.25","é"}}})
  n=n+1
end
-- case 1427: float16 + U8, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float16"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=1})
  verify(r,"U32",{{{"-1.5"},{"2.25"}},{{"x"},{"é"}}})
  n=n+1
end
-- case 1428: float16 + U8, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float16"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=-1})
  verify(r,"U32",{{{"-1.5","x"}},{{"2.25","é"}}})
  n=n+1
end
-- case 1429: float16 + U8, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({-1.5,2.25},"float16"),{2})},{axis=1})
  verify(r,"U32",{"x","é","-1.5","2.25"})
  n=n+1
end
-- case 1430: float16 + U8, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({-1.5,2.25},"float16"),{2})},{axis=-1})
  verify(r,"U32",{"x","é","-1.5","2.25"})
  n=n+1
end
-- case 1431: float16 + U8, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({-1.5,2.25},"float16"),{1,2})},{axis=1})
  verify(r,"U32",{{"x","é"},{"-1.5","2.25"}})
  n=n+1
end
-- case 1432: float16 + U8, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({-1.5,2.25},"float16"),{1,2})},{axis=-1})
  verify(r,"U32",{{"x","é","-1.5","2.25"}})
  n=n+1
end
-- case 1433: float16 + U8, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({-1.5,2.25},"float16"),{2,1})},{axis=1})
  verify(r,"U32",{{"x"},{"é"},{"-1.5"},{"2.25"}})
  n=n+1
end
-- case 1434: float16 + U8, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({-1.5,2.25},"float16"),{2,1})},{axis=-1})
  verify(r,"U32",{{"x","-1.5"},{"é","2.25"}})
  n=n+1
end
-- case 1435: float16 + U8, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({-1.5,2.25},"float16"),{2})},{axis=1})
  verify(r,"U32",{{"x","é"},{"-1.5","2.25"}})
  n=n+1
end
-- case 1436: float16 + U8, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({-1.5,2.25},"float16"),{2})},{axis=-1})
  verify(r,"U32",{{"x","-1.5"},{"é","2.25"}})
  n=n+1
end
-- case 1437: float16 + U8, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({-1.5,2.25},"float16"),{1,2})},{axis=1})
  verify(r,"U32",{{{"x","é"}},{{"-1.5","2.25"}}})
  n=n+1
end
-- case 1438: float16 + U8, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({-1.5,2.25},"float16"),{1,2})},{axis=-1})
  verify(r,"U32",{{{"x","-1.5"},{"é","2.25"}}})
  n=n+1
end
-- case 1439: float16 + U8, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({-1.5,2.25},"float16"),{2,1})},{axis=1})
  verify(r,"U32",{{{"x"},{"é"}},{{"-1.5"},{"2.25"}}})
  n=n+1
end
-- case 1440: float16 + U8, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({-1.5,2.25},"float16"),{2,1})},{axis=-1})
  verify(r,"U32",{{{"x","-1.5"}},{{"é","2.25"}}})
  n=n+1
end
-- case 1441: float32 + S1, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float32"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=1})
  verify(r,"S32",{"-1.5","2.25","x","y"})
  n=n+1
end
-- case 1442: float32 + S1, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float32"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=-1})
  verify(r,"S32",{"-1.5","2.25","x","y"})
  n=n+1
end
-- case 1443: float32 + S1, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float32"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=1})
  verify(r,"S32",{{"-1.5","2.25"},{"x","y"}})
  n=n+1
end
-- case 1444: float32 + S1, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float32"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=-1})
  verify(r,"S32",{{"-1.5","2.25","x","y"}})
  n=n+1
end
-- case 1445: float32 + S1, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float32"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=1})
  verify(r,"S32",{{"-1.5"},{"2.25"},{"x"},{"y"}})
  n=n+1
end
-- case 1446: float32 + S1, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float32"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=-1})
  verify(r,"S32",{{"-1.5","x"},{"2.25","y"}})
  n=n+1
end
-- case 1447: float32 + S1, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float32"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=1})
  verify(r,"S32",{{"-1.5","2.25"},{"x","y"}})
  n=n+1
end
-- case 1448: float32 + S1, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float32"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=-1})
  verify(r,"S32",{{"-1.5","x"},{"2.25","y"}})
  n=n+1
end
-- case 1449: float32 + S1, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float32"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=1})
  verify(r,"S32",{{{"-1.5","2.25"}},{{"x","y"}}})
  n=n+1
end
-- case 1450: float32 + S1, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float32"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=-1})
  verify(r,"S32",{{{"-1.5","x"},{"2.25","y"}}})
  n=n+1
end
-- case 1451: float32 + S1, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float32"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=1})
  verify(r,"S32",{{{"-1.5"},{"2.25"}},{{"x"},{"y"}}})
  n=n+1
end
-- case 1452: float32 + S1, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float32"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=-1})
  verify(r,"S32",{{{"-1.5","x"}},{{"2.25","y"}}})
  n=n+1
end
-- case 1453: float32 + S1, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({-1.5,2.25},"float32"),{2})},{axis=1})
  verify(r,"S32",{"x","y","-1.5","2.25"})
  n=n+1
end
-- case 1454: float32 + S1, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({-1.5,2.25},"float32"),{2})},{axis=-1})
  verify(r,"S32",{"x","y","-1.5","2.25"})
  n=n+1
end
-- case 1455: float32 + S1, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({-1.5,2.25},"float32"),{1,2})},{axis=1})
  verify(r,"S32",{{"x","y"},{"-1.5","2.25"}})
  n=n+1
end
-- case 1456: float32 + S1, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({-1.5,2.25},"float32"),{1,2})},{axis=-1})
  verify(r,"S32",{{"x","y","-1.5","2.25"}})
  n=n+1
end
-- case 1457: float32 + S1, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({-1.5,2.25},"float32"),{2,1})},{axis=1})
  verify(r,"S32",{{"x"},{"y"},{"-1.5"},{"2.25"}})
  n=n+1
end
-- case 1458: float32 + S1, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({-1.5,2.25},"float32"),{2,1})},{axis=-1})
  verify(r,"S32",{{"x","-1.5"},{"y","2.25"}})
  n=n+1
end
-- case 1459: float32 + S1, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({-1.5,2.25},"float32"),{2})},{axis=1})
  verify(r,"S32",{{"x","y"},{"-1.5","2.25"}})
  n=n+1
end
-- case 1460: float32 + S1, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({-1.5,2.25},"float32"),{2})},{axis=-1})
  verify(r,"S32",{{"x","-1.5"},{"y","2.25"}})
  n=n+1
end
-- case 1461: float32 + S1, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({-1.5,2.25},"float32"),{1,2})},{axis=1})
  verify(r,"S32",{{{"x","y"}},{{"-1.5","2.25"}}})
  n=n+1
end
-- case 1462: float32 + S1, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({-1.5,2.25},"float32"),{1,2})},{axis=-1})
  verify(r,"S32",{{{"x","-1.5"},{"y","2.25"}}})
  n=n+1
end
-- case 1463: float32 + S1, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({-1.5,2.25},"float32"),{2,1})},{axis=1})
  verify(r,"S32",{{{"x"},{"y"}},{{"-1.5"},{"2.25"}}})
  n=n+1
end
-- case 1464: float32 + S1, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({-1.5,2.25},"float32"),{2,1})},{axis=-1})
  verify(r,"S32",{{{"x","-1.5"}},{{"y","2.25"}}})
  n=n+1
end
-- case 1465: float32 + S3, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float32"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=1})
  verify(r,"S32",{"-1.5","2.25","x","yz"})
  n=n+1
end
-- case 1466: float32 + S3, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float32"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=-1})
  verify(r,"S32",{"-1.5","2.25","x","yz"})
  n=n+1
end
-- case 1467: float32 + S3, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float32"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=1})
  verify(r,"S32",{{"-1.5","2.25"},{"x","yz"}})
  n=n+1
end
-- case 1468: float32 + S3, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float32"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=-1})
  verify(r,"S32",{{"-1.5","2.25","x","yz"}})
  n=n+1
end
-- case 1469: float32 + S3, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float32"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=1})
  verify(r,"S32",{{"-1.5"},{"2.25"},{"x"},{"yz"}})
  n=n+1
end
-- case 1470: float32 + S3, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float32"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=-1})
  verify(r,"S32",{{"-1.5","x"},{"2.25","yz"}})
  n=n+1
end
-- case 1471: float32 + S3, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float32"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=1})
  verify(r,"S32",{{"-1.5","2.25"},{"x","yz"}})
  n=n+1
end
-- case 1472: float32 + S3, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float32"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=-1})
  verify(r,"S32",{{"-1.5","x"},{"2.25","yz"}})
  n=n+1
end
-- case 1473: float32 + S3, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float32"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=1})
  verify(r,"S32",{{{"-1.5","2.25"}},{{"x","yz"}}})
  n=n+1
end
-- case 1474: float32 + S3, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float32"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=-1})
  verify(r,"S32",{{{"-1.5","x"},{"2.25","yz"}}})
  n=n+1
end
-- case 1475: float32 + S3, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float32"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=1})
  verify(r,"S32",{{{"-1.5"},{"2.25"}},{{"x"},{"yz"}}})
  n=n+1
end
-- case 1476: float32 + S3, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float32"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=-1})
  verify(r,"S32",{{{"-1.5","x"}},{{"2.25","yz"}}})
  n=n+1
end
-- case 1477: float32 + S3, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({-1.5,2.25},"float32"),{2})},{axis=1})
  verify(r,"S32",{"x","yz","-1.5","2.25"})
  n=n+1
end
-- case 1478: float32 + S3, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({-1.5,2.25},"float32"),{2})},{axis=-1})
  verify(r,"S32",{"x","yz","-1.5","2.25"})
  n=n+1
end
-- case 1479: float32 + S3, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({-1.5,2.25},"float32"),{1,2})},{axis=1})
  verify(r,"S32",{{"x","yz"},{"-1.5","2.25"}})
  n=n+1
end
-- case 1480: float32 + S3, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({-1.5,2.25},"float32"),{1,2})},{axis=-1})
  verify(r,"S32",{{"x","yz","-1.5","2.25"}})
  n=n+1
end
-- case 1481: float32 + S3, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({-1.5,2.25},"float32"),{2,1})},{axis=1})
  verify(r,"S32",{{"x"},{"yz"},{"-1.5"},{"2.25"}})
  n=n+1
end
-- case 1482: float32 + S3, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({-1.5,2.25},"float32"),{2,1})},{axis=-1})
  verify(r,"S32",{{"x","-1.5"},{"yz","2.25"}})
  n=n+1
end
-- case 1483: float32 + S3, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({-1.5,2.25},"float32"),{2})},{axis=1})
  verify(r,"S32",{{"x","yz"},{"-1.5","2.25"}})
  n=n+1
end
-- case 1484: float32 + S3, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({-1.5,2.25},"float32"),{2})},{axis=-1})
  verify(r,"S32",{{"x","-1.5"},{"yz","2.25"}})
  n=n+1
end
-- case 1485: float32 + S3, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({-1.5,2.25},"float32"),{1,2})},{axis=1})
  verify(r,"S32",{{{"x","yz"}},{{"-1.5","2.25"}}})
  n=n+1
end
-- case 1486: float32 + S3, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({-1.5,2.25},"float32"),{1,2})},{axis=-1})
  verify(r,"S32",{{{"x","-1.5"},{"yz","2.25"}}})
  n=n+1
end
-- case 1487: float32 + S3, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({-1.5,2.25},"float32"),{2,1})},{axis=1})
  verify(r,"S32",{{{"x"},{"yz"}},{{"-1.5"},{"2.25"}}})
  n=n+1
end
-- case 1488: float32 + S3, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({-1.5,2.25},"float32"),{2,1})},{axis=-1})
  verify(r,"S32",{{{"x","-1.5"}},{{"yz","2.25"}}})
  n=n+1
end
-- case 1489: float32 + S8, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float32"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=1})
  verify(r,"S32",{"-1.5","2.25","x","yz"})
  n=n+1
end
-- case 1490: float32 + S8, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float32"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=-1})
  verify(r,"S32",{"-1.5","2.25","x","yz"})
  n=n+1
end
-- case 1491: float32 + S8, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float32"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=1})
  verify(r,"S32",{{"-1.5","2.25"},{"x","yz"}})
  n=n+1
end
-- case 1492: float32 + S8, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float32"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=-1})
  verify(r,"S32",{{"-1.5","2.25","x","yz"}})
  n=n+1
end
-- case 1493: float32 + S8, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float32"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=1})
  verify(r,"S32",{{"-1.5"},{"2.25"},{"x"},{"yz"}})
  n=n+1
end
-- case 1494: float32 + S8, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float32"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=-1})
  verify(r,"S32",{{"-1.5","x"},{"2.25","yz"}})
  n=n+1
end
-- case 1495: float32 + S8, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float32"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=1})
  verify(r,"S32",{{"-1.5","2.25"},{"x","yz"}})
  n=n+1
end
-- case 1496: float32 + S8, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float32"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=-1})
  verify(r,"S32",{{"-1.5","x"},{"2.25","yz"}})
  n=n+1
end
-- case 1497: float32 + S8, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float32"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=1})
  verify(r,"S32",{{{"-1.5","2.25"}},{{"x","yz"}}})
  n=n+1
end
-- case 1498: float32 + S8, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float32"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=-1})
  verify(r,"S32",{{{"-1.5","x"},{"2.25","yz"}}})
  n=n+1
end
-- case 1499: float32 + S8, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float32"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=1})
  verify(r,"S32",{{{"-1.5"},{"2.25"}},{{"x"},{"yz"}}})
  n=n+1
end
-- case 1500: float32 + S8, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float32"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=-1})
  verify(r,"S32",{{{"-1.5","x"}},{{"2.25","yz"}}})
  n=n+1
end
-- case 1501: float32 + S8, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({-1.5,2.25},"float32"),{2})},{axis=1})
  verify(r,"S32",{"x","yz","-1.5","2.25"})
  n=n+1
end
-- case 1502: float32 + S8, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({-1.5,2.25},"float32"),{2})},{axis=-1})
  verify(r,"S32",{"x","yz","-1.5","2.25"})
  n=n+1
end
-- case 1503: float32 + S8, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({-1.5,2.25},"float32"),{1,2})},{axis=1})
  verify(r,"S32",{{"x","yz"},{"-1.5","2.25"}})
  n=n+1
end
-- case 1504: float32 + S8, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({-1.5,2.25},"float32"),{1,2})},{axis=-1})
  verify(r,"S32",{{"x","yz","-1.5","2.25"}})
  n=n+1
end
-- case 1505: float32 + S8, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({-1.5,2.25},"float32"),{2,1})},{axis=1})
  verify(r,"S32",{{"x"},{"yz"},{"-1.5"},{"2.25"}})
  n=n+1
end
-- case 1506: float32 + S8, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({-1.5,2.25},"float32"),{2,1})},{axis=-1})
  verify(r,"S32",{{"x","-1.5"},{"yz","2.25"}})
  n=n+1
end
-- case 1507: float32 + S8, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({-1.5,2.25},"float32"),{2})},{axis=1})
  verify(r,"S32",{{"x","yz"},{"-1.5","2.25"}})
  n=n+1
end
-- case 1508: float32 + S8, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({-1.5,2.25},"float32"),{2})},{axis=-1})
  verify(r,"S32",{{"x","-1.5"},{"yz","2.25"}})
  n=n+1
end
-- case 1509: float32 + S8, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({-1.5,2.25},"float32"),{1,2})},{axis=1})
  verify(r,"S32",{{{"x","yz"}},{{"-1.5","2.25"}}})
  n=n+1
end
-- case 1510: float32 + S8, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({-1.5,2.25},"float32"),{1,2})},{axis=-1})
  verify(r,"S32",{{{"x","-1.5"},{"yz","2.25"}}})
  n=n+1
end
-- case 1511: float32 + S8, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({-1.5,2.25},"float32"),{2,1})},{axis=1})
  verify(r,"S32",{{{"x"},{"yz"}},{{"-1.5"},{"2.25"}}})
  n=n+1
end
-- case 1512: float32 + S8, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({-1.5,2.25},"float32"),{2,1})},{axis=-1})
  verify(r,"S32",{{{"x","-1.5"}},{{"yz","2.25"}}})
  n=n+1
end
-- case 1513: float32 + U1, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float32"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=1})
  verify(r,"U32",{"-1.5","2.25","x","é"})
  n=n+1
end
-- case 1514: float32 + U1, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float32"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=-1})
  verify(r,"U32",{"-1.5","2.25","x","é"})
  n=n+1
end
-- case 1515: float32 + U1, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float32"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=1})
  verify(r,"U32",{{"-1.5","2.25"},{"x","é"}})
  n=n+1
end
-- case 1516: float32 + U1, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float32"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=-1})
  verify(r,"U32",{{"-1.5","2.25","x","é"}})
  n=n+1
end
-- case 1517: float32 + U1, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float32"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=1})
  verify(r,"U32",{{"-1.5"},{"2.25"},{"x"},{"é"}})
  n=n+1
end
-- case 1518: float32 + U1, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float32"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=-1})
  verify(r,"U32",{{"-1.5","x"},{"2.25","é"}})
  n=n+1
end
-- case 1519: float32 + U1, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float32"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=1})
  verify(r,"U32",{{"-1.5","2.25"},{"x","é"}})
  n=n+1
end
-- case 1520: float32 + U1, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float32"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=-1})
  verify(r,"U32",{{"-1.5","x"},{"2.25","é"}})
  n=n+1
end
-- case 1521: float32 + U1, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float32"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=1})
  verify(r,"U32",{{{"-1.5","2.25"}},{{"x","é"}}})
  n=n+1
end
-- case 1522: float32 + U1, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float32"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=-1})
  verify(r,"U32",{{{"-1.5","x"},{"2.25","é"}}})
  n=n+1
end
-- case 1523: float32 + U1, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float32"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=1})
  verify(r,"U32",{{{"-1.5"},{"2.25"}},{{"x"},{"é"}}})
  n=n+1
end
-- case 1524: float32 + U1, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float32"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=-1})
  verify(r,"U32",{{{"-1.5","x"}},{{"2.25","é"}}})
  n=n+1
end
-- case 1525: float32 + U1, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({-1.5,2.25},"float32"),{2})},{axis=1})
  verify(r,"U32",{"x","é","-1.5","2.25"})
  n=n+1
end
-- case 1526: float32 + U1, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({-1.5,2.25},"float32"),{2})},{axis=-1})
  verify(r,"U32",{"x","é","-1.5","2.25"})
  n=n+1
end
-- case 1527: float32 + U1, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({-1.5,2.25},"float32"),{1,2})},{axis=1})
  verify(r,"U32",{{"x","é"},{"-1.5","2.25"}})
  n=n+1
end
-- case 1528: float32 + U1, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({-1.5,2.25},"float32"),{1,2})},{axis=-1})
  verify(r,"U32",{{"x","é","-1.5","2.25"}})
  n=n+1
end
-- case 1529: float32 + U1, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({-1.5,2.25},"float32"),{2,1})},{axis=1})
  verify(r,"U32",{{"x"},{"é"},{"-1.5"},{"2.25"}})
  n=n+1
end
-- case 1530: float32 + U1, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({-1.5,2.25},"float32"),{2,1})},{axis=-1})
  verify(r,"U32",{{"x","-1.5"},{"é","2.25"}})
  n=n+1
end
-- case 1531: float32 + U1, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({-1.5,2.25},"float32"),{2})},{axis=1})
  verify(r,"U32",{{"x","é"},{"-1.5","2.25"}})
  n=n+1
end
-- case 1532: float32 + U1, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({-1.5,2.25},"float32"),{2})},{axis=-1})
  verify(r,"U32",{{"x","-1.5"},{"é","2.25"}})
  n=n+1
end
-- case 1533: float32 + U1, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({-1.5,2.25},"float32"),{1,2})},{axis=1})
  verify(r,"U32",{{{"x","é"}},{{"-1.5","2.25"}}})
  n=n+1
end
-- case 1534: float32 + U1, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({-1.5,2.25},"float32"),{1,2})},{axis=-1})
  verify(r,"U32",{{{"x","-1.5"},{"é","2.25"}}})
  n=n+1
end
-- case 1535: float32 + U1, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({-1.5,2.25},"float32"),{2,1})},{axis=1})
  verify(r,"U32",{{{"x"},{"é"}},{{"-1.5"},{"2.25"}}})
  n=n+1
end
-- case 1536: float32 + U1, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({-1.5,2.25},"float32"),{2,1})},{axis=-1})
  verify(r,"U32",{{{"x","-1.5"}},{{"é","2.25"}}})
  n=n+1
end
-- case 1537: float32 + U3, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float32"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=1})
  verify(r,"U32",{"-1.5","2.25","x","é"})
  n=n+1
end
-- case 1538: float32 + U3, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float32"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=-1})
  verify(r,"U32",{"-1.5","2.25","x","é"})
  n=n+1
end
-- case 1539: float32 + U3, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float32"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=1})
  verify(r,"U32",{{"-1.5","2.25"},{"x","é"}})
  n=n+1
end
-- case 1540: float32 + U3, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float32"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=-1})
  verify(r,"U32",{{"-1.5","2.25","x","é"}})
  n=n+1
end
-- case 1541: float32 + U3, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float32"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=1})
  verify(r,"U32",{{"-1.5"},{"2.25"},{"x"},{"é"}})
  n=n+1
end
-- case 1542: float32 + U3, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float32"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=-1})
  verify(r,"U32",{{"-1.5","x"},{"2.25","é"}})
  n=n+1
end
-- case 1543: float32 + U3, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float32"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=1})
  verify(r,"U32",{{"-1.5","2.25"},{"x","é"}})
  n=n+1
end
-- case 1544: float32 + U3, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float32"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=-1})
  verify(r,"U32",{{"-1.5","x"},{"2.25","é"}})
  n=n+1
end
-- case 1545: float32 + U3, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float32"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=1})
  verify(r,"U32",{{{"-1.5","2.25"}},{{"x","é"}}})
  n=n+1
end
-- case 1546: float32 + U3, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float32"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=-1})
  verify(r,"U32",{{{"-1.5","x"},{"2.25","é"}}})
  n=n+1
end
-- case 1547: float32 + U3, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float32"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=1})
  verify(r,"U32",{{{"-1.5"},{"2.25"}},{{"x"},{"é"}}})
  n=n+1
end
-- case 1548: float32 + U3, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float32"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=-1})
  verify(r,"U32",{{{"-1.5","x"}},{{"2.25","é"}}})
  n=n+1
end
-- case 1549: float32 + U3, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({-1.5,2.25},"float32"),{2})},{axis=1})
  verify(r,"U32",{"x","é","-1.5","2.25"})
  n=n+1
end
-- case 1550: float32 + U3, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({-1.5,2.25},"float32"),{2})},{axis=-1})
  verify(r,"U32",{"x","é","-1.5","2.25"})
  n=n+1
end
-- case 1551: float32 + U3, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({-1.5,2.25},"float32"),{1,2})},{axis=1})
  verify(r,"U32",{{"x","é"},{"-1.5","2.25"}})
  n=n+1
end
-- case 1552: float32 + U3, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({-1.5,2.25},"float32"),{1,2})},{axis=-1})
  verify(r,"U32",{{"x","é","-1.5","2.25"}})
  n=n+1
end
-- case 1553: float32 + U3, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({-1.5,2.25},"float32"),{2,1})},{axis=1})
  verify(r,"U32",{{"x"},{"é"},{"-1.5"},{"2.25"}})
  n=n+1
end
-- case 1554: float32 + U3, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({-1.5,2.25},"float32"),{2,1})},{axis=-1})
  verify(r,"U32",{{"x","-1.5"},{"é","2.25"}})
  n=n+1
end
-- case 1555: float32 + U3, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({-1.5,2.25},"float32"),{2})},{axis=1})
  verify(r,"U32",{{"x","é"},{"-1.5","2.25"}})
  n=n+1
end
-- case 1556: float32 + U3, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({-1.5,2.25},"float32"),{2})},{axis=-1})
  verify(r,"U32",{{"x","-1.5"},{"é","2.25"}})
  n=n+1
end
-- case 1557: float32 + U3, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({-1.5,2.25},"float32"),{1,2})},{axis=1})
  verify(r,"U32",{{{"x","é"}},{{"-1.5","2.25"}}})
  n=n+1
end
-- case 1558: float32 + U3, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({-1.5,2.25},"float32"),{1,2})},{axis=-1})
  verify(r,"U32",{{{"x","-1.5"},{"é","2.25"}}})
  n=n+1
end
-- case 1559: float32 + U3, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({-1.5,2.25},"float32"),{2,1})},{axis=1})
  verify(r,"U32",{{{"x"},{"é"}},{{"-1.5"},{"2.25"}}})
  n=n+1
end
-- case 1560: float32 + U3, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({-1.5,2.25},"float32"),{2,1})},{axis=-1})
  verify(r,"U32",{{{"x","-1.5"}},{{"é","2.25"}}})
  n=n+1
end
-- case 1561: float32 + U8, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float32"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=1})
  verify(r,"U32",{"-1.5","2.25","x","é"})
  n=n+1
end
-- case 1562: float32 + U8, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float32"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=-1})
  verify(r,"U32",{"-1.5","2.25","x","é"})
  n=n+1
end
-- case 1563: float32 + U8, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float32"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=1})
  verify(r,"U32",{{"-1.5","2.25"},{"x","é"}})
  n=n+1
end
-- case 1564: float32 + U8, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float32"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=-1})
  verify(r,"U32",{{"-1.5","2.25","x","é"}})
  n=n+1
end
-- case 1565: float32 + U8, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float32"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=1})
  verify(r,"U32",{{"-1.5"},{"2.25"},{"x"},{"é"}})
  n=n+1
end
-- case 1566: float32 + U8, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float32"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=-1})
  verify(r,"U32",{{"-1.5","x"},{"2.25","é"}})
  n=n+1
end
-- case 1567: float32 + U8, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float32"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=1})
  verify(r,"U32",{{"-1.5","2.25"},{"x","é"}})
  n=n+1
end
-- case 1568: float32 + U8, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float32"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=-1})
  verify(r,"U32",{{"-1.5","x"},{"2.25","é"}})
  n=n+1
end
-- case 1569: float32 + U8, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float32"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=1})
  verify(r,"U32",{{{"-1.5","2.25"}},{{"x","é"}}})
  n=n+1
end
-- case 1570: float32 + U8, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float32"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=-1})
  verify(r,"U32",{{{"-1.5","x"},{"2.25","é"}}})
  n=n+1
end
-- case 1571: float32 + U8, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float32"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=1})
  verify(r,"U32",{{{"-1.5"},{"2.25"}},{{"x"},{"é"}}})
  n=n+1
end
-- case 1572: float32 + U8, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float32"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=-1})
  verify(r,"U32",{{{"-1.5","x"}},{{"2.25","é"}}})
  n=n+1
end
-- case 1573: float32 + U8, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({-1.5,2.25},"float32"),{2})},{axis=1})
  verify(r,"U32",{"x","é","-1.5","2.25"})
  n=n+1
end
-- case 1574: float32 + U8, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({-1.5,2.25},"float32"),{2})},{axis=-1})
  verify(r,"U32",{"x","é","-1.5","2.25"})
  n=n+1
end
-- case 1575: float32 + U8, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({-1.5,2.25},"float32"),{1,2})},{axis=1})
  verify(r,"U32",{{"x","é"},{"-1.5","2.25"}})
  n=n+1
end
-- case 1576: float32 + U8, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({-1.5,2.25},"float32"),{1,2})},{axis=-1})
  verify(r,"U32",{{"x","é","-1.5","2.25"}})
  n=n+1
end
-- case 1577: float32 + U8, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({-1.5,2.25},"float32"),{2,1})},{axis=1})
  verify(r,"U32",{{"x"},{"é"},{"-1.5"},{"2.25"}})
  n=n+1
end
-- case 1578: float32 + U8, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({-1.5,2.25},"float32"),{2,1})},{axis=-1})
  verify(r,"U32",{{"x","-1.5"},{"é","2.25"}})
  n=n+1
end
-- case 1579: float32 + U8, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({-1.5,2.25},"float32"),{2})},{axis=1})
  verify(r,"U32",{{"x","é"},{"-1.5","2.25"}})
  n=n+1
end
-- case 1580: float32 + U8, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({-1.5,2.25},"float32"),{2})},{axis=-1})
  verify(r,"U32",{{"x","-1.5"},{"é","2.25"}})
  n=n+1
end
-- case 1581: float32 + U8, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({-1.5,2.25},"float32"),{1,2})},{axis=1})
  verify(r,"U32",{{{"x","é"}},{{"-1.5","2.25"}}})
  n=n+1
end
-- case 1582: float32 + U8, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({-1.5,2.25},"float32"),{1,2})},{axis=-1})
  verify(r,"U32",{{{"x","-1.5"},{"é","2.25"}}})
  n=n+1
end
-- case 1583: float32 + U8, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({-1.5,2.25},"float32"),{2,1})},{axis=1})
  verify(r,"U32",{{{"x"},{"é"}},{{"-1.5"},{"2.25"}}})
  n=n+1
end
-- case 1584: float32 + U8, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({-1.5,2.25},"float32"),{2,1})},{axis=-1})
  verify(r,"U32",{{{"x","-1.5"}},{{"é","2.25"}}})
  n=n+1
end
-- case 1585: float64 + S1, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float64"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=1})
  verify(r,"S32",{"-1.5","2.25","x","y"})
  n=n+1
end
-- case 1586: float64 + S1, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float64"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=-1})
  verify(r,"S32",{"-1.5","2.25","x","y"})
  n=n+1
end
-- case 1587: float64 + S1, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float64"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=1})
  verify(r,"S32",{{"-1.5","2.25"},{"x","y"}})
  n=n+1
end
-- case 1588: float64 + S1, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float64"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=-1})
  verify(r,"S32",{{"-1.5","2.25","x","y"}})
  n=n+1
end
-- case 1589: float64 + S1, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float64"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=1})
  verify(r,"S32",{{"-1.5"},{"2.25"},{"x"},{"y"}})
  n=n+1
end
-- case 1590: float64 + S1, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float64"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=-1})
  verify(r,"S32",{{"-1.5","x"},{"2.25","y"}})
  n=n+1
end
-- case 1591: float64 + S1, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float64"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=1})
  verify(r,"S32",{{"-1.5","2.25"},{"x","y"}})
  n=n+1
end
-- case 1592: float64 + S1, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float64"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=-1})
  verify(r,"S32",{{"-1.5","x"},{"2.25","y"}})
  n=n+1
end
-- case 1593: float64 + S1, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float64"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=1})
  verify(r,"S32",{{{"-1.5","2.25"}},{{"x","y"}}})
  n=n+1
end
-- case 1594: float64 + S1, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float64"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=-1})
  verify(r,"S32",{{{"-1.5","x"},{"2.25","y"}}})
  n=n+1
end
-- case 1595: float64 + S1, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float64"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=1})
  verify(r,"S32",{{{"-1.5"},{"2.25"}},{{"x"},{"y"}}})
  n=n+1
end
-- case 1596: float64 + S1, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float64"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=-1})
  verify(r,"S32",{{{"-1.5","x"}},{{"2.25","y"}}})
  n=n+1
end
-- case 1597: float64 + S1, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({-1.5,2.25},"float64"),{2})},{axis=1})
  verify(r,"S32",{"x","y","-1.5","2.25"})
  n=n+1
end
-- case 1598: float64 + S1, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({-1.5,2.25},"float64"),{2})},{axis=-1})
  verify(r,"S32",{"x","y","-1.5","2.25"})
  n=n+1
end
-- case 1599: float64 + S1, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({-1.5,2.25},"float64"),{1,2})},{axis=1})
  verify(r,"S32",{{"x","y"},{"-1.5","2.25"}})
  n=n+1
end
-- case 1600: float64 + S1, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({-1.5,2.25},"float64"),{1,2})},{axis=-1})
  verify(r,"S32",{{"x","y","-1.5","2.25"}})
  n=n+1
end
-- case 1601: float64 + S1, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({-1.5,2.25},"float64"),{2,1})},{axis=1})
  verify(r,"S32",{{"x"},{"y"},{"-1.5"},{"2.25"}})
  n=n+1
end
-- case 1602: float64 + S1, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({-1.5,2.25},"float64"),{2,1})},{axis=-1})
  verify(r,"S32",{{"x","-1.5"},{"y","2.25"}})
  n=n+1
end
-- case 1603: float64 + S1, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({-1.5,2.25},"float64"),{2})},{axis=1})
  verify(r,"S32",{{"x","y"},{"-1.5","2.25"}})
  n=n+1
end
-- case 1604: float64 + S1, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({-1.5,2.25},"float64"),{2})},{axis=-1})
  verify(r,"S32",{{"x","-1.5"},{"y","2.25"}})
  n=n+1
end
-- case 1605: float64 + S1, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({-1.5,2.25},"float64"),{1,2})},{axis=1})
  verify(r,"S32",{{{"x","y"}},{{"-1.5","2.25"}}})
  n=n+1
end
-- case 1606: float64 + S1, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({-1.5,2.25},"float64"),{1,2})},{axis=-1})
  verify(r,"S32",{{{"x","-1.5"},{"y","2.25"}}})
  n=n+1
end
-- case 1607: float64 + S1, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({-1.5,2.25},"float64"),{2,1})},{axis=1})
  verify(r,"S32",{{{"x"},{"y"}},{{"-1.5"},{"2.25"}}})
  n=n+1
end
-- case 1608: float64 + S1, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({-1.5,2.25},"float64"),{2,1})},{axis=-1})
  verify(r,"S32",{{{"x","-1.5"}},{{"y","2.25"}}})
  n=n+1
end
-- case 1609: float64 + S3, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float64"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=1})
  verify(r,"S32",{"-1.5","2.25","x","yz"})
  n=n+1
end
-- case 1610: float64 + S3, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float64"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=-1})
  verify(r,"S32",{"-1.5","2.25","x","yz"})
  n=n+1
end
-- case 1611: float64 + S3, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float64"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=1})
  verify(r,"S32",{{"-1.5","2.25"},{"x","yz"}})
  n=n+1
end
-- case 1612: float64 + S3, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float64"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=-1})
  verify(r,"S32",{{"-1.5","2.25","x","yz"}})
  n=n+1
end
-- case 1613: float64 + S3, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float64"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=1})
  verify(r,"S32",{{"-1.5"},{"2.25"},{"x"},{"yz"}})
  n=n+1
end
-- case 1614: float64 + S3, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float64"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=-1})
  verify(r,"S32",{{"-1.5","x"},{"2.25","yz"}})
  n=n+1
end
-- case 1615: float64 + S3, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float64"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=1})
  verify(r,"S32",{{"-1.5","2.25"},{"x","yz"}})
  n=n+1
end
-- case 1616: float64 + S3, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float64"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=-1})
  verify(r,"S32",{{"-1.5","x"},{"2.25","yz"}})
  n=n+1
end
-- case 1617: float64 + S3, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float64"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=1})
  verify(r,"S32",{{{"-1.5","2.25"}},{{"x","yz"}}})
  n=n+1
end
-- case 1618: float64 + S3, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float64"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=-1})
  verify(r,"S32",{{{"-1.5","x"},{"2.25","yz"}}})
  n=n+1
end
-- case 1619: float64 + S3, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float64"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=1})
  verify(r,"S32",{{{"-1.5"},{"2.25"}},{{"x"},{"yz"}}})
  n=n+1
end
-- case 1620: float64 + S3, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float64"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=-1})
  verify(r,"S32",{{{"-1.5","x"}},{{"2.25","yz"}}})
  n=n+1
end
-- case 1621: float64 + S3, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({-1.5,2.25},"float64"),{2})},{axis=1})
  verify(r,"S32",{"x","yz","-1.5","2.25"})
  n=n+1
end
-- case 1622: float64 + S3, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({-1.5,2.25},"float64"),{2})},{axis=-1})
  verify(r,"S32",{"x","yz","-1.5","2.25"})
  n=n+1
end
-- case 1623: float64 + S3, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({-1.5,2.25},"float64"),{1,2})},{axis=1})
  verify(r,"S32",{{"x","yz"},{"-1.5","2.25"}})
  n=n+1
end
-- case 1624: float64 + S3, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({-1.5,2.25},"float64"),{1,2})},{axis=-1})
  verify(r,"S32",{{"x","yz","-1.5","2.25"}})
  n=n+1
end
-- case 1625: float64 + S3, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({-1.5,2.25},"float64"),{2,1})},{axis=1})
  verify(r,"S32",{{"x"},{"yz"},{"-1.5"},{"2.25"}})
  n=n+1
end
-- case 1626: float64 + S3, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({-1.5,2.25},"float64"),{2,1})},{axis=-1})
  verify(r,"S32",{{"x","-1.5"},{"yz","2.25"}})
  n=n+1
end
-- case 1627: float64 + S3, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({-1.5,2.25},"float64"),{2})},{axis=1})
  verify(r,"S32",{{"x","yz"},{"-1.5","2.25"}})
  n=n+1
end
-- case 1628: float64 + S3, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({-1.5,2.25},"float64"),{2})},{axis=-1})
  verify(r,"S32",{{"x","-1.5"},{"yz","2.25"}})
  n=n+1
end
-- case 1629: float64 + S3, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({-1.5,2.25},"float64"),{1,2})},{axis=1})
  verify(r,"S32",{{{"x","yz"}},{{"-1.5","2.25"}}})
  n=n+1
end
-- case 1630: float64 + S3, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({-1.5,2.25},"float64"),{1,2})},{axis=-1})
  verify(r,"S32",{{{"x","-1.5"},{"yz","2.25"}}})
  n=n+1
end
-- case 1631: float64 + S3, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({-1.5,2.25},"float64"),{2,1})},{axis=1})
  verify(r,"S32",{{{"x"},{"yz"}},{{"-1.5"},{"2.25"}}})
  n=n+1
end
-- case 1632: float64 + S3, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({-1.5,2.25},"float64"),{2,1})},{axis=-1})
  verify(r,"S32",{{{"x","-1.5"}},{{"yz","2.25"}}})
  n=n+1
end
-- case 1633: float64 + S8, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float64"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=1})
  verify(r,"S32",{"-1.5","2.25","x","yz"})
  n=n+1
end
-- case 1634: float64 + S8, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float64"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=-1})
  verify(r,"S32",{"-1.5","2.25","x","yz"})
  n=n+1
end
-- case 1635: float64 + S8, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float64"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=1})
  verify(r,"S32",{{"-1.5","2.25"},{"x","yz"}})
  n=n+1
end
-- case 1636: float64 + S8, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float64"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=-1})
  verify(r,"S32",{{"-1.5","2.25","x","yz"}})
  n=n+1
end
-- case 1637: float64 + S8, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float64"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=1})
  verify(r,"S32",{{"-1.5"},{"2.25"},{"x"},{"yz"}})
  n=n+1
end
-- case 1638: float64 + S8, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float64"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=-1})
  verify(r,"S32",{{"-1.5","x"},{"2.25","yz"}})
  n=n+1
end
-- case 1639: float64 + S8, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float64"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=1})
  verify(r,"S32",{{"-1.5","2.25"},{"x","yz"}})
  n=n+1
end
-- case 1640: float64 + S8, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float64"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=-1})
  verify(r,"S32",{{"-1.5","x"},{"2.25","yz"}})
  n=n+1
end
-- case 1641: float64 + S8, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float64"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=1})
  verify(r,"S32",{{{"-1.5","2.25"}},{{"x","yz"}}})
  n=n+1
end
-- case 1642: float64 + S8, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float64"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=-1})
  verify(r,"S32",{{{"-1.5","x"},{"2.25","yz"}}})
  n=n+1
end
-- case 1643: float64 + S8, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float64"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=1})
  verify(r,"S32",{{{"-1.5"},{"2.25"}},{{"x"},{"yz"}}})
  n=n+1
end
-- case 1644: float64 + S8, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float64"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=-1})
  verify(r,"S32",{{{"-1.5","x"}},{{"2.25","yz"}}})
  n=n+1
end
-- case 1645: float64 + S8, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({-1.5,2.25},"float64"),{2})},{axis=1})
  verify(r,"S32",{"x","yz","-1.5","2.25"})
  n=n+1
end
-- case 1646: float64 + S8, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({-1.5,2.25},"float64"),{2})},{axis=-1})
  verify(r,"S32",{"x","yz","-1.5","2.25"})
  n=n+1
end
-- case 1647: float64 + S8, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({-1.5,2.25},"float64"),{1,2})},{axis=1})
  verify(r,"S32",{{"x","yz"},{"-1.5","2.25"}})
  n=n+1
end
-- case 1648: float64 + S8, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({-1.5,2.25},"float64"),{1,2})},{axis=-1})
  verify(r,"S32",{{"x","yz","-1.5","2.25"}})
  n=n+1
end
-- case 1649: float64 + S8, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({-1.5,2.25},"float64"),{2,1})},{axis=1})
  verify(r,"S32",{{"x"},{"yz"},{"-1.5"},{"2.25"}})
  n=n+1
end
-- case 1650: float64 + S8, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({-1.5,2.25},"float64"),{2,1})},{axis=-1})
  verify(r,"S32",{{"x","-1.5"},{"yz","2.25"}})
  n=n+1
end
-- case 1651: float64 + S8, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({-1.5,2.25},"float64"),{2})},{axis=1})
  verify(r,"S32",{{"x","yz"},{"-1.5","2.25"}})
  n=n+1
end
-- case 1652: float64 + S8, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({-1.5,2.25},"float64"),{2})},{axis=-1})
  verify(r,"S32",{{"x","-1.5"},{"yz","2.25"}})
  n=n+1
end
-- case 1653: float64 + S8, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({-1.5,2.25},"float64"),{1,2})},{axis=1})
  verify(r,"S32",{{{"x","yz"}},{{"-1.5","2.25"}}})
  n=n+1
end
-- case 1654: float64 + S8, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({-1.5,2.25},"float64"),{1,2})},{axis=-1})
  verify(r,"S32",{{{"x","-1.5"},{"yz","2.25"}}})
  n=n+1
end
-- case 1655: float64 + S8, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({-1.5,2.25},"float64"),{2,1})},{axis=1})
  verify(r,"S32",{{{"x"},{"yz"}},{{"-1.5"},{"2.25"}}})
  n=n+1
end
-- case 1656: float64 + S8, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({-1.5,2.25},"float64"),{2,1})},{axis=-1})
  verify(r,"S32",{{{"x","-1.5"}},{{"yz","2.25"}}})
  n=n+1
end
-- case 1657: float64 + U1, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float64"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=1})
  verify(r,"U32",{"-1.5","2.25","x","é"})
  n=n+1
end
-- case 1658: float64 + U1, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float64"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=-1})
  verify(r,"U32",{"-1.5","2.25","x","é"})
  n=n+1
end
-- case 1659: float64 + U1, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float64"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=1})
  verify(r,"U32",{{"-1.5","2.25"},{"x","é"}})
  n=n+1
end
-- case 1660: float64 + U1, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float64"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=-1})
  verify(r,"U32",{{"-1.5","2.25","x","é"}})
  n=n+1
end
-- case 1661: float64 + U1, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float64"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=1})
  verify(r,"U32",{{"-1.5"},{"2.25"},{"x"},{"é"}})
  n=n+1
end
-- case 1662: float64 + U1, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float64"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=-1})
  verify(r,"U32",{{"-1.5","x"},{"2.25","é"}})
  n=n+1
end
-- case 1663: float64 + U1, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float64"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=1})
  verify(r,"U32",{{"-1.5","2.25"},{"x","é"}})
  n=n+1
end
-- case 1664: float64 + U1, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float64"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=-1})
  verify(r,"U32",{{"-1.5","x"},{"2.25","é"}})
  n=n+1
end
-- case 1665: float64 + U1, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float64"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=1})
  verify(r,"U32",{{{"-1.5","2.25"}},{{"x","é"}}})
  n=n+1
end
-- case 1666: float64 + U1, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float64"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=-1})
  verify(r,"U32",{{{"-1.5","x"},{"2.25","é"}}})
  n=n+1
end
-- case 1667: float64 + U1, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float64"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=1})
  verify(r,"U32",{{{"-1.5"},{"2.25"}},{{"x"},{"é"}}})
  n=n+1
end
-- case 1668: float64 + U1, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float64"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=-1})
  verify(r,"U32",{{{"-1.5","x"}},{{"2.25","é"}}})
  n=n+1
end
-- case 1669: float64 + U1, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({-1.5,2.25},"float64"),{2})},{axis=1})
  verify(r,"U32",{"x","é","-1.5","2.25"})
  n=n+1
end
-- case 1670: float64 + U1, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({-1.5,2.25},"float64"),{2})},{axis=-1})
  verify(r,"U32",{"x","é","-1.5","2.25"})
  n=n+1
end
-- case 1671: float64 + U1, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({-1.5,2.25},"float64"),{1,2})},{axis=1})
  verify(r,"U32",{{"x","é"},{"-1.5","2.25"}})
  n=n+1
end
-- case 1672: float64 + U1, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({-1.5,2.25},"float64"),{1,2})},{axis=-1})
  verify(r,"U32",{{"x","é","-1.5","2.25"}})
  n=n+1
end
-- case 1673: float64 + U1, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({-1.5,2.25},"float64"),{2,1})},{axis=1})
  verify(r,"U32",{{"x"},{"é"},{"-1.5"},{"2.25"}})
  n=n+1
end
-- case 1674: float64 + U1, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({-1.5,2.25},"float64"),{2,1})},{axis=-1})
  verify(r,"U32",{{"x","-1.5"},{"é","2.25"}})
  n=n+1
end
-- case 1675: float64 + U1, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({-1.5,2.25},"float64"),{2})},{axis=1})
  verify(r,"U32",{{"x","é"},{"-1.5","2.25"}})
  n=n+1
end
-- case 1676: float64 + U1, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({-1.5,2.25},"float64"),{2})},{axis=-1})
  verify(r,"U32",{{"x","-1.5"},{"é","2.25"}})
  n=n+1
end
-- case 1677: float64 + U1, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({-1.5,2.25},"float64"),{1,2})},{axis=1})
  verify(r,"U32",{{{"x","é"}},{{"-1.5","2.25"}}})
  n=n+1
end
-- case 1678: float64 + U1, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({-1.5,2.25},"float64"),{1,2})},{axis=-1})
  verify(r,"U32",{{{"x","-1.5"},{"é","2.25"}}})
  n=n+1
end
-- case 1679: float64 + U1, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({-1.5,2.25},"float64"),{2,1})},{axis=1})
  verify(r,"U32",{{{"x"},{"é"}},{{"-1.5"},{"2.25"}}})
  n=n+1
end
-- case 1680: float64 + U1, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({-1.5,2.25},"float64"),{2,1})},{axis=-1})
  verify(r,"U32",{{{"x","-1.5"}},{{"é","2.25"}}})
  n=n+1
end
-- case 1681: float64 + U3, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float64"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=1})
  verify(r,"U32",{"-1.5","2.25","x","é"})
  n=n+1
end
-- case 1682: float64 + U3, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float64"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=-1})
  verify(r,"U32",{"-1.5","2.25","x","é"})
  n=n+1
end
-- case 1683: float64 + U3, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float64"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=1})
  verify(r,"U32",{{"-1.5","2.25"},{"x","é"}})
  n=n+1
end
-- case 1684: float64 + U3, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float64"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=-1})
  verify(r,"U32",{{"-1.5","2.25","x","é"}})
  n=n+1
end
-- case 1685: float64 + U3, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float64"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=1})
  verify(r,"U32",{{"-1.5"},{"2.25"},{"x"},{"é"}})
  n=n+1
end
-- case 1686: float64 + U3, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float64"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=-1})
  verify(r,"U32",{{"-1.5","x"},{"2.25","é"}})
  n=n+1
end
-- case 1687: float64 + U3, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float64"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=1})
  verify(r,"U32",{{"-1.5","2.25"},{"x","é"}})
  n=n+1
end
-- case 1688: float64 + U3, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float64"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=-1})
  verify(r,"U32",{{"-1.5","x"},{"2.25","é"}})
  n=n+1
end
-- case 1689: float64 + U3, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float64"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=1})
  verify(r,"U32",{{{"-1.5","2.25"}},{{"x","é"}}})
  n=n+1
end
-- case 1690: float64 + U3, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float64"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=-1})
  verify(r,"U32",{{{"-1.5","x"},{"2.25","é"}}})
  n=n+1
end
-- case 1691: float64 + U3, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float64"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=1})
  verify(r,"U32",{{{"-1.5"},{"2.25"}},{{"x"},{"é"}}})
  n=n+1
end
-- case 1692: float64 + U3, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float64"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=-1})
  verify(r,"U32",{{{"-1.5","x"}},{{"2.25","é"}}})
  n=n+1
end
-- case 1693: float64 + U3, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({-1.5,2.25},"float64"),{2})},{axis=1})
  verify(r,"U32",{"x","é","-1.5","2.25"})
  n=n+1
end
-- case 1694: float64 + U3, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({-1.5,2.25},"float64"),{2})},{axis=-1})
  verify(r,"U32",{"x","é","-1.5","2.25"})
  n=n+1
end
-- case 1695: float64 + U3, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({-1.5,2.25},"float64"),{1,2})},{axis=1})
  verify(r,"U32",{{"x","é"},{"-1.5","2.25"}})
  n=n+1
end
-- case 1696: float64 + U3, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({-1.5,2.25},"float64"),{1,2})},{axis=-1})
  verify(r,"U32",{{"x","é","-1.5","2.25"}})
  n=n+1
end
-- case 1697: float64 + U3, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({-1.5,2.25},"float64"),{2,1})},{axis=1})
  verify(r,"U32",{{"x"},{"é"},{"-1.5"},{"2.25"}})
  n=n+1
end
-- case 1698: float64 + U3, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({-1.5,2.25},"float64"),{2,1})},{axis=-1})
  verify(r,"U32",{{"x","-1.5"},{"é","2.25"}})
  n=n+1
end
-- case 1699: float64 + U3, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({-1.5,2.25},"float64"),{2})},{axis=1})
  verify(r,"U32",{{"x","é"},{"-1.5","2.25"}})
  n=n+1
end
-- case 1700: float64 + U3, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({-1.5,2.25},"float64"),{2})},{axis=-1})
  verify(r,"U32",{{"x","-1.5"},{"é","2.25"}})
  n=n+1
end
-- case 1701: float64 + U3, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({-1.5,2.25},"float64"),{1,2})},{axis=1})
  verify(r,"U32",{{{"x","é"}},{{"-1.5","2.25"}}})
  n=n+1
end
-- case 1702: float64 + U3, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({-1.5,2.25},"float64"),{1,2})},{axis=-1})
  verify(r,"U32",{{{"x","-1.5"},{"é","2.25"}}})
  n=n+1
end
-- case 1703: float64 + U3, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({-1.5,2.25},"float64"),{2,1})},{axis=1})
  verify(r,"U32",{{{"x"},{"é"}},{{"-1.5"},{"2.25"}}})
  n=n+1
end
-- case 1704: float64 + U3, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({-1.5,2.25},"float64"),{2,1})},{axis=-1})
  verify(r,"U32",{{{"x","-1.5"}},{{"é","2.25"}}})
  n=n+1
end
-- case 1705: float64 + U8, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float64"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=1})
  verify(r,"U32",{"-1.5","2.25","x","é"})
  n=n+1
end
-- case 1706: float64 + U8, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float64"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=-1})
  verify(r,"U32",{"-1.5","2.25","x","é"})
  n=n+1
end
-- case 1707: float64 + U8, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float64"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=1})
  verify(r,"U32",{{"-1.5","2.25"},{"x","é"}})
  n=n+1
end
-- case 1708: float64 + U8, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float64"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=-1})
  verify(r,"U32",{{"-1.5","2.25","x","é"}})
  n=n+1
end
-- case 1709: float64 + U8, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float64"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=1})
  verify(r,"U32",{{"-1.5"},{"2.25"},{"x"},{"é"}})
  n=n+1
end
-- case 1710: float64 + U8, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({-1.5,2.25},"float64"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=-1})
  verify(r,"U32",{{"-1.5","x"},{"2.25","é"}})
  n=n+1
end
-- case 1711: float64 + U8, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float64"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=1})
  verify(r,"U32",{{"-1.5","2.25"},{"x","é"}})
  n=n+1
end
-- case 1712: float64 + U8, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float64"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=-1})
  verify(r,"U32",{{"-1.5","x"},{"2.25","é"}})
  n=n+1
end
-- case 1713: float64 + U8, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float64"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=1})
  verify(r,"U32",{{{"-1.5","2.25"}},{{"x","é"}}})
  n=n+1
end
-- case 1714: float64 + U8, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float64"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=-1})
  verify(r,"U32",{{{"-1.5","x"},{"2.25","é"}}})
  n=n+1
end
-- case 1715: float64 + U8, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float64"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=1})
  verify(r,"U32",{{{"-1.5"},{"2.25"}},{{"x"},{"é"}}})
  n=n+1
end
-- case 1716: float64 + U8, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({-1.5,2.25},"float64"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=-1})
  verify(r,"U32",{{{"-1.5","x"}},{{"2.25","é"}}})
  n=n+1
end
-- case 1717: float64 + U8, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({-1.5,2.25},"float64"),{2})},{axis=1})
  verify(r,"U32",{"x","é","-1.5","2.25"})
  n=n+1
end
-- case 1718: float64 + U8, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({-1.5,2.25},"float64"),{2})},{axis=-1})
  verify(r,"U32",{"x","é","-1.5","2.25"})
  n=n+1
end
-- case 1719: float64 + U8, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({-1.5,2.25},"float64"),{1,2})},{axis=1})
  verify(r,"U32",{{"x","é"},{"-1.5","2.25"}})
  n=n+1
end
-- case 1720: float64 + U8, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({-1.5,2.25},"float64"),{1,2})},{axis=-1})
  verify(r,"U32",{{"x","é","-1.5","2.25"}})
  n=n+1
end
-- case 1721: float64 + U8, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({-1.5,2.25},"float64"),{2,1})},{axis=1})
  verify(r,"U32",{{"x"},{"é"},{"-1.5"},{"2.25"}})
  n=n+1
end
-- case 1722: float64 + U8, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({-1.5,2.25},"float64"),{2,1})},{axis=-1})
  verify(r,"U32",{{"x","-1.5"},{"é","2.25"}})
  n=n+1
end
-- case 1723: float64 + U8, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({-1.5,2.25},"float64"),{2})},{axis=1})
  verify(r,"U32",{{"x","é"},{"-1.5","2.25"}})
  n=n+1
end
-- case 1724: float64 + U8, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({-1.5,2.25},"float64"),{2})},{axis=-1})
  verify(r,"U32",{{"x","-1.5"},{"é","2.25"}})
  n=n+1
end
-- case 1725: float64 + U8, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({-1.5,2.25},"float64"),{1,2})},{axis=1})
  verify(r,"U32",{{{"x","é"}},{{"-1.5","2.25"}}})
  n=n+1
end
-- case 1726: float64 + U8, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({-1.5,2.25},"float64"),{1,2})},{axis=-1})
  verify(r,"U32",{{{"x","-1.5"},{"é","2.25"}}})
  n=n+1
end
-- case 1727: float64 + U8, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({-1.5,2.25},"float64"),{2,1})},{axis=1})
  verify(r,"U32",{{{"x"},{"é"}},{{"-1.5"},{"2.25"}}})
  n=n+1
end
-- case 1728: float64 + U8, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({-1.5,2.25},"float64"),{2,1})},{axis=-1})
  verify(r,"U32",{{{"x","-1.5"}},{{"é","2.25"}}})
  n=n+1
end
-- case 1729: complex64 + S1, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=1})
  verify(r,"S64",{"(2+3j)","(-1+0j)","x","y"})
  n=n+1
end
-- case 1730: complex64 + S1, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=-1})
  verify(r,"S64",{"(2+3j)","(-1+0j)","x","y"})
  n=n+1
end
-- case 1731: complex64 + S1, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=1})
  verify(r,"S64",{{"(2+3j)","(-1+0j)"},{"x","y"}})
  n=n+1
end
-- case 1732: complex64 + S1, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=-1})
  verify(r,"S64",{{"(2+3j)","(-1+0j)","x","y"}})
  n=n+1
end
-- case 1733: complex64 + S1, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=1})
  verify(r,"S64",{{"(2+3j)"},{"(-1+0j)"},{"x"},{"y"}})
  n=n+1
end
-- case 1734: complex64 + S1, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=-1})
  verify(r,"S64",{{"(2+3j)","x"},{"(-1+0j)","y"}})
  n=n+1
end
-- case 1735: complex64 + S1, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=1})
  verify(r,"S64",{{"(2+3j)","(-1+0j)"},{"x","y"}})
  n=n+1
end
-- case 1736: complex64 + S1, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=-1})
  verify(r,"S64",{{"(2+3j)","x"},{"(-1+0j)","y"}})
  n=n+1
end
-- case 1737: complex64 + S1, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=1})
  verify(r,"S64",{{{"(2+3j)","(-1+0j)"}},{{"x","y"}}})
  n=n+1
end
-- case 1738: complex64 + S1, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=-1})
  verify(r,"S64",{{{"(2+3j)","x"},{"(-1+0j)","y"}}})
  n=n+1
end
-- case 1739: complex64 + S1, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=1})
  verify(r,"S64",{{{"(2+3j)"},{"(-1+0j)"}},{{"x"},{"y"}}})
  n=n+1
end
-- case 1740: complex64 + S1, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=-1})
  verify(r,"S64",{{{"(2+3j)","x"}},{{"(-1+0j)","y"}}})
  n=n+1
end
-- case 1741: complex64 + S1, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2})},{axis=1})
  verify(r,"S64",{"x","y","(2+3j)","(-1+0j)"})
  n=n+1
end
-- case 1742: complex64 + S1, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2})},{axis=-1})
  verify(r,"S64",{"x","y","(2+3j)","(-1+0j)"})
  n=n+1
end
-- case 1743: complex64 + S1, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2})},{axis=1})
  verify(r,"S64",{{"x","y"},{"(2+3j)","(-1+0j)"}})
  n=n+1
end
-- case 1744: complex64 + S1, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2})},{axis=-1})
  verify(r,"S64",{{"x","y","(2+3j)","(-1+0j)"}})
  n=n+1
end
-- case 1745: complex64 + S1, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1})},{axis=1})
  verify(r,"S64",{{"x"},{"y"},{"(2+3j)"},{"(-1+0j)"}})
  n=n+1
end
-- case 1746: complex64 + S1, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1})},{axis=-1})
  verify(r,"S64",{{"x","(2+3j)"},{"y","(-1+0j)"}})
  n=n+1
end
-- case 1747: complex64 + S1, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2})},{axis=1})
  verify(r,"S64",{{"x","y"},{"(2+3j)","(-1+0j)"}})
  n=n+1
end
-- case 1748: complex64 + S1, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2})},{axis=-1})
  verify(r,"S64",{{"x","(2+3j)"},{"y","(-1+0j)"}})
  n=n+1
end
-- case 1749: complex64 + S1, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2})},{axis=1})
  verify(r,"S64",{{{"x","y"}},{{"(2+3j)","(-1+0j)"}}})
  n=n+1
end
-- case 1750: complex64 + S1, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2})},{axis=-1})
  verify(r,"S64",{{{"x","(2+3j)"},{"y","(-1+0j)"}}})
  n=n+1
end
-- case 1751: complex64 + S1, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1})},{axis=1})
  verify(r,"S64",{{{"x"},{"y"}},{{"(2+3j)"},{"(-1+0j)"}}})
  n=n+1
end
-- case 1752: complex64 + S1, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1})},{axis=-1})
  verify(r,"S64",{{{"x","(2+3j)"}},{{"y","(-1+0j)"}}})
  n=n+1
end
-- case 1753: complex64 + S3, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=1})
  verify(r,"S64",{"(2+3j)","(-1+0j)","x","yz"})
  n=n+1
end
-- case 1754: complex64 + S3, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=-1})
  verify(r,"S64",{"(2+3j)","(-1+0j)","x","yz"})
  n=n+1
end
-- case 1755: complex64 + S3, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=1})
  verify(r,"S64",{{"(2+3j)","(-1+0j)"},{"x","yz"}})
  n=n+1
end
-- case 1756: complex64 + S3, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=-1})
  verify(r,"S64",{{"(2+3j)","(-1+0j)","x","yz"}})
  n=n+1
end
-- case 1757: complex64 + S3, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=1})
  verify(r,"S64",{{"(2+3j)"},{"(-1+0j)"},{"x"},{"yz"}})
  n=n+1
end
-- case 1758: complex64 + S3, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=-1})
  verify(r,"S64",{{"(2+3j)","x"},{"(-1+0j)","yz"}})
  n=n+1
end
-- case 1759: complex64 + S3, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=1})
  verify(r,"S64",{{"(2+3j)","(-1+0j)"},{"x","yz"}})
  n=n+1
end
-- case 1760: complex64 + S3, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=-1})
  verify(r,"S64",{{"(2+3j)","x"},{"(-1+0j)","yz"}})
  n=n+1
end
-- case 1761: complex64 + S3, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=1})
  verify(r,"S64",{{{"(2+3j)","(-1+0j)"}},{{"x","yz"}}})
  n=n+1
end
-- case 1762: complex64 + S3, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=-1})
  verify(r,"S64",{{{"(2+3j)","x"},{"(-1+0j)","yz"}}})
  n=n+1
end
-- case 1763: complex64 + S3, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=1})
  verify(r,"S64",{{{"(2+3j)"},{"(-1+0j)"}},{{"x"},{"yz"}}})
  n=n+1
end
-- case 1764: complex64 + S3, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=-1})
  verify(r,"S64",{{{"(2+3j)","x"}},{{"(-1+0j)","yz"}}})
  n=n+1
end
-- case 1765: complex64 + S3, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2})},{axis=1})
  verify(r,"S64",{"x","yz","(2+3j)","(-1+0j)"})
  n=n+1
end
-- case 1766: complex64 + S3, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2})},{axis=-1})
  verify(r,"S64",{"x","yz","(2+3j)","(-1+0j)"})
  n=n+1
end
-- case 1767: complex64 + S3, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2})},{axis=1})
  verify(r,"S64",{{"x","yz"},{"(2+3j)","(-1+0j)"}})
  n=n+1
end
-- case 1768: complex64 + S3, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2})},{axis=-1})
  verify(r,"S64",{{"x","yz","(2+3j)","(-1+0j)"}})
  n=n+1
end
-- case 1769: complex64 + S3, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1})},{axis=1})
  verify(r,"S64",{{"x"},{"yz"},{"(2+3j)"},{"(-1+0j)"}})
  n=n+1
end
-- case 1770: complex64 + S3, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1})},{axis=-1})
  verify(r,"S64",{{"x","(2+3j)"},{"yz","(-1+0j)"}})
  n=n+1
end
-- case 1771: complex64 + S3, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2})},{axis=1})
  verify(r,"S64",{{"x","yz"},{"(2+3j)","(-1+0j)"}})
  n=n+1
end
-- case 1772: complex64 + S3, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2})},{axis=-1})
  verify(r,"S64",{{"x","(2+3j)"},{"yz","(-1+0j)"}})
  n=n+1
end
-- case 1773: complex64 + S3, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2})},{axis=1})
  verify(r,"S64",{{{"x","yz"}},{{"(2+3j)","(-1+0j)"}}})
  n=n+1
end
-- case 1774: complex64 + S3, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2})},{axis=-1})
  verify(r,"S64",{{{"x","(2+3j)"},{"yz","(-1+0j)"}}})
  n=n+1
end
-- case 1775: complex64 + S3, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1})},{axis=1})
  verify(r,"S64",{{{"x"},{"yz"}},{{"(2+3j)"},{"(-1+0j)"}}})
  n=n+1
end
-- case 1776: complex64 + S3, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1})},{axis=-1})
  verify(r,"S64",{{{"x","(2+3j)"}},{{"yz","(-1+0j)"}}})
  n=n+1
end
-- case 1777: complex64 + S8, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=1})
  verify(r,"S64",{"(2+3j)","(-1+0j)","x","yz"})
  n=n+1
end
-- case 1778: complex64 + S8, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=-1})
  verify(r,"S64",{"(2+3j)","(-1+0j)","x","yz"})
  n=n+1
end
-- case 1779: complex64 + S8, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=1})
  verify(r,"S64",{{"(2+3j)","(-1+0j)"},{"x","yz"}})
  n=n+1
end
-- case 1780: complex64 + S8, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=-1})
  verify(r,"S64",{{"(2+3j)","(-1+0j)","x","yz"}})
  n=n+1
end
-- case 1781: complex64 + S8, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=1})
  verify(r,"S64",{{"(2+3j)"},{"(-1+0j)"},{"x"},{"yz"}})
  n=n+1
end
-- case 1782: complex64 + S8, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=-1})
  verify(r,"S64",{{"(2+3j)","x"},{"(-1+0j)","yz"}})
  n=n+1
end
-- case 1783: complex64 + S8, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=1})
  verify(r,"S64",{{"(2+3j)","(-1+0j)"},{"x","yz"}})
  n=n+1
end
-- case 1784: complex64 + S8, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=-1})
  verify(r,"S64",{{"(2+3j)","x"},{"(-1+0j)","yz"}})
  n=n+1
end
-- case 1785: complex64 + S8, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=1})
  verify(r,"S64",{{{"(2+3j)","(-1+0j)"}},{{"x","yz"}}})
  n=n+1
end
-- case 1786: complex64 + S8, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=-1})
  verify(r,"S64",{{{"(2+3j)","x"},{"(-1+0j)","yz"}}})
  n=n+1
end
-- case 1787: complex64 + S8, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=1})
  verify(r,"S64",{{{"(2+3j)"},{"(-1+0j)"}},{{"x"},{"yz"}}})
  n=n+1
end
-- case 1788: complex64 + S8, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=-1})
  verify(r,"S64",{{{"(2+3j)","x"}},{{"(-1+0j)","yz"}}})
  n=n+1
end
-- case 1789: complex64 + S8, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2})},{axis=1})
  verify(r,"S64",{"x","yz","(2+3j)","(-1+0j)"})
  n=n+1
end
-- case 1790: complex64 + S8, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2})},{axis=-1})
  verify(r,"S64",{"x","yz","(2+3j)","(-1+0j)"})
  n=n+1
end
-- case 1791: complex64 + S8, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2})},{axis=1})
  verify(r,"S64",{{"x","yz"},{"(2+3j)","(-1+0j)"}})
  n=n+1
end
-- case 1792: complex64 + S8, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2})},{axis=-1})
  verify(r,"S64",{{"x","yz","(2+3j)","(-1+0j)"}})
  n=n+1
end
-- case 1793: complex64 + S8, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1})},{axis=1})
  verify(r,"S64",{{"x"},{"yz"},{"(2+3j)"},{"(-1+0j)"}})
  n=n+1
end
-- case 1794: complex64 + S8, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1})},{axis=-1})
  verify(r,"S64",{{"x","(2+3j)"},{"yz","(-1+0j)"}})
  n=n+1
end
-- case 1795: complex64 + S8, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2})},{axis=1})
  verify(r,"S64",{{"x","yz"},{"(2+3j)","(-1+0j)"}})
  n=n+1
end
-- case 1796: complex64 + S8, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2})},{axis=-1})
  verify(r,"S64",{{"x","(2+3j)"},{"yz","(-1+0j)"}})
  n=n+1
end
-- case 1797: complex64 + S8, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2})},{axis=1})
  verify(r,"S64",{{{"x","yz"}},{{"(2+3j)","(-1+0j)"}}})
  n=n+1
end
-- case 1798: complex64 + S8, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2})},{axis=-1})
  verify(r,"S64",{{{"x","(2+3j)"},{"yz","(-1+0j)"}}})
  n=n+1
end
-- case 1799: complex64 + S8, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1})},{axis=1})
  verify(r,"S64",{{{"x"},{"yz"}},{{"(2+3j)"},{"(-1+0j)"}}})
  n=n+1
end
-- case 1800: complex64 + S8, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1})},{axis=-1})
  verify(r,"S64",{{{"x","(2+3j)"}},{{"yz","(-1+0j)"}}})
  n=n+1
end
-- case 1801: complex64 + U1, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=1})
  verify(r,"U64",{"(2+3j)","(-1+0j)","x","é"})
  n=n+1
end
-- case 1802: complex64 + U1, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=-1})
  verify(r,"U64",{"(2+3j)","(-1+0j)","x","é"})
  n=n+1
end
-- case 1803: complex64 + U1, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=1})
  verify(r,"U64",{{"(2+3j)","(-1+0j)"},{"x","é"}})
  n=n+1
end
-- case 1804: complex64 + U1, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=-1})
  verify(r,"U64",{{"(2+3j)","(-1+0j)","x","é"}})
  n=n+1
end
-- case 1805: complex64 + U1, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=1})
  verify(r,"U64",{{"(2+3j)"},{"(-1+0j)"},{"x"},{"é"}})
  n=n+1
end
-- case 1806: complex64 + U1, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=-1})
  verify(r,"U64",{{"(2+3j)","x"},{"(-1+0j)","é"}})
  n=n+1
end
-- case 1807: complex64 + U1, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=1})
  verify(r,"U64",{{"(2+3j)","(-1+0j)"},{"x","é"}})
  n=n+1
end
-- case 1808: complex64 + U1, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=-1})
  verify(r,"U64",{{"(2+3j)","x"},{"(-1+0j)","é"}})
  n=n+1
end
-- case 1809: complex64 + U1, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=1})
  verify(r,"U64",{{{"(2+3j)","(-1+0j)"}},{{"x","é"}}})
  n=n+1
end
-- case 1810: complex64 + U1, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=-1})
  verify(r,"U64",{{{"(2+3j)","x"},{"(-1+0j)","é"}}})
  n=n+1
end
-- case 1811: complex64 + U1, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=1})
  verify(r,"U64",{{{"(2+3j)"},{"(-1+0j)"}},{{"x"},{"é"}}})
  n=n+1
end
-- case 1812: complex64 + U1, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=-1})
  verify(r,"U64",{{{"(2+3j)","x"}},{{"(-1+0j)","é"}}})
  n=n+1
end
-- case 1813: complex64 + U1, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2})},{axis=1})
  verify(r,"U64",{"x","é","(2+3j)","(-1+0j)"})
  n=n+1
end
-- case 1814: complex64 + U1, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2})},{axis=-1})
  verify(r,"U64",{"x","é","(2+3j)","(-1+0j)"})
  n=n+1
end
-- case 1815: complex64 + U1, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2})},{axis=1})
  verify(r,"U64",{{"x","é"},{"(2+3j)","(-1+0j)"}})
  n=n+1
end
-- case 1816: complex64 + U1, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2})},{axis=-1})
  verify(r,"U64",{{"x","é","(2+3j)","(-1+0j)"}})
  n=n+1
end
-- case 1817: complex64 + U1, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1})},{axis=1})
  verify(r,"U64",{{"x"},{"é"},{"(2+3j)"},{"(-1+0j)"}})
  n=n+1
end
-- case 1818: complex64 + U1, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1})},{axis=-1})
  verify(r,"U64",{{"x","(2+3j)"},{"é","(-1+0j)"}})
  n=n+1
end
-- case 1819: complex64 + U1, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2})},{axis=1})
  verify(r,"U64",{{"x","é"},{"(2+3j)","(-1+0j)"}})
  n=n+1
end
-- case 1820: complex64 + U1, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2})},{axis=-1})
  verify(r,"U64",{{"x","(2+3j)"},{"é","(-1+0j)"}})
  n=n+1
end
-- case 1821: complex64 + U1, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2})},{axis=1})
  verify(r,"U64",{{{"x","é"}},{{"(2+3j)","(-1+0j)"}}})
  n=n+1
end
-- case 1822: complex64 + U1, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2})},{axis=-1})
  verify(r,"U64",{{{"x","(2+3j)"},{"é","(-1+0j)"}}})
  n=n+1
end
-- case 1823: complex64 + U1, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1})},{axis=1})
  verify(r,"U64",{{{"x"},{"é"}},{{"(2+3j)"},{"(-1+0j)"}}})
  n=n+1
end
-- case 1824: complex64 + U1, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1})},{axis=-1})
  verify(r,"U64",{{{"x","(2+3j)"}},{{"é","(-1+0j)"}}})
  n=n+1
end
-- case 1825: complex64 + U3, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=1})
  verify(r,"U64",{"(2+3j)","(-1+0j)","x","é"})
  n=n+1
end
-- case 1826: complex64 + U3, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=-1})
  verify(r,"U64",{"(2+3j)","(-1+0j)","x","é"})
  n=n+1
end
-- case 1827: complex64 + U3, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=1})
  verify(r,"U64",{{"(2+3j)","(-1+0j)"},{"x","é"}})
  n=n+1
end
-- case 1828: complex64 + U3, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=-1})
  verify(r,"U64",{{"(2+3j)","(-1+0j)","x","é"}})
  n=n+1
end
-- case 1829: complex64 + U3, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=1})
  verify(r,"U64",{{"(2+3j)"},{"(-1+0j)"},{"x"},{"é"}})
  n=n+1
end
-- case 1830: complex64 + U3, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=-1})
  verify(r,"U64",{{"(2+3j)","x"},{"(-1+0j)","é"}})
  n=n+1
end
-- case 1831: complex64 + U3, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=1})
  verify(r,"U64",{{"(2+3j)","(-1+0j)"},{"x","é"}})
  n=n+1
end
-- case 1832: complex64 + U3, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=-1})
  verify(r,"U64",{{"(2+3j)","x"},{"(-1+0j)","é"}})
  n=n+1
end
-- case 1833: complex64 + U3, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=1})
  verify(r,"U64",{{{"(2+3j)","(-1+0j)"}},{{"x","é"}}})
  n=n+1
end
-- case 1834: complex64 + U3, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=-1})
  verify(r,"U64",{{{"(2+3j)","x"},{"(-1+0j)","é"}}})
  n=n+1
end
-- case 1835: complex64 + U3, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=1})
  verify(r,"U64",{{{"(2+3j)"},{"(-1+0j)"}},{{"x"},{"é"}}})
  n=n+1
end
-- case 1836: complex64 + U3, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=-1})
  verify(r,"U64",{{{"(2+3j)","x"}},{{"(-1+0j)","é"}}})
  n=n+1
end
-- case 1837: complex64 + U3, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2})},{axis=1})
  verify(r,"U64",{"x","é","(2+3j)","(-1+0j)"})
  n=n+1
end
-- case 1838: complex64 + U3, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2})},{axis=-1})
  verify(r,"U64",{"x","é","(2+3j)","(-1+0j)"})
  n=n+1
end
-- case 1839: complex64 + U3, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2})},{axis=1})
  verify(r,"U64",{{"x","é"},{"(2+3j)","(-1+0j)"}})
  n=n+1
end
-- case 1840: complex64 + U3, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2})},{axis=-1})
  verify(r,"U64",{{"x","é","(2+3j)","(-1+0j)"}})
  n=n+1
end
-- case 1841: complex64 + U3, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1})},{axis=1})
  verify(r,"U64",{{"x"},{"é"},{"(2+3j)"},{"(-1+0j)"}})
  n=n+1
end
-- case 1842: complex64 + U3, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1})},{axis=-1})
  verify(r,"U64",{{"x","(2+3j)"},{"é","(-1+0j)"}})
  n=n+1
end
-- case 1843: complex64 + U3, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2})},{axis=1})
  verify(r,"U64",{{"x","é"},{"(2+3j)","(-1+0j)"}})
  n=n+1
end
-- case 1844: complex64 + U3, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2})},{axis=-1})
  verify(r,"U64",{{"x","(2+3j)"},{"é","(-1+0j)"}})
  n=n+1
end
-- case 1845: complex64 + U3, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2})},{axis=1})
  verify(r,"U64",{{{"x","é"}},{{"(2+3j)","(-1+0j)"}}})
  n=n+1
end
-- case 1846: complex64 + U3, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2})},{axis=-1})
  verify(r,"U64",{{{"x","(2+3j)"},{"é","(-1+0j)"}}})
  n=n+1
end
-- case 1847: complex64 + U3, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1})},{axis=1})
  verify(r,"U64",{{{"x"},{"é"}},{{"(2+3j)"},{"(-1+0j)"}}})
  n=n+1
end
-- case 1848: complex64 + U3, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1})},{axis=-1})
  verify(r,"U64",{{{"x","(2+3j)"}},{{"é","(-1+0j)"}}})
  n=n+1
end
-- case 1849: complex64 + U8, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=1})
  verify(r,"U64",{"(2+3j)","(-1+0j)","x","é"})
  n=n+1
end
-- case 1850: complex64 + U8, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=-1})
  verify(r,"U64",{"(2+3j)","(-1+0j)","x","é"})
  n=n+1
end
-- case 1851: complex64 + U8, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=1})
  verify(r,"U64",{{"(2+3j)","(-1+0j)"},{"x","é"}})
  n=n+1
end
-- case 1852: complex64 + U8, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=-1})
  verify(r,"U64",{{"(2+3j)","(-1+0j)","x","é"}})
  n=n+1
end
-- case 1853: complex64 + U8, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=1})
  verify(r,"U64",{{"(2+3j)"},{"(-1+0j)"},{"x"},{"é"}})
  n=n+1
end
-- case 1854: complex64 + U8, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=-1})
  verify(r,"U64",{{"(2+3j)","x"},{"(-1+0j)","é"}})
  n=n+1
end
-- case 1855: complex64 + U8, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=1})
  verify(r,"U64",{{"(2+3j)","(-1+0j)"},{"x","é"}})
  n=n+1
end
-- case 1856: complex64 + U8, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=-1})
  verify(r,"U64",{{"(2+3j)","x"},{"(-1+0j)","é"}})
  n=n+1
end
-- case 1857: complex64 + U8, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=1})
  verify(r,"U64",{{{"(2+3j)","(-1+0j)"}},{{"x","é"}}})
  n=n+1
end
-- case 1858: complex64 + U8, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=-1})
  verify(r,"U64",{{{"(2+3j)","x"},{"(-1+0j)","é"}}})
  n=n+1
end
-- case 1859: complex64 + U8, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=1})
  verify(r,"U64",{{{"(2+3j)"},{"(-1+0j)"}},{{"x"},{"é"}}})
  n=n+1
end
-- case 1860: complex64 + U8, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=-1})
  verify(r,"U64",{{{"(2+3j)","x"}},{{"(-1+0j)","é"}}})
  n=n+1
end
-- case 1861: complex64 + U8, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2})},{axis=1})
  verify(r,"U64",{"x","é","(2+3j)","(-1+0j)"})
  n=n+1
end
-- case 1862: complex64 + U8, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2})},{axis=-1})
  verify(r,"U64",{"x","é","(2+3j)","(-1+0j)"})
  n=n+1
end
-- case 1863: complex64 + U8, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2})},{axis=1})
  verify(r,"U64",{{"x","é"},{"(2+3j)","(-1+0j)"}})
  n=n+1
end
-- case 1864: complex64 + U8, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2})},{axis=-1})
  verify(r,"U64",{{"x","é","(2+3j)","(-1+0j)"}})
  n=n+1
end
-- case 1865: complex64 + U8, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1})},{axis=1})
  verify(r,"U64",{{"x"},{"é"},{"(2+3j)"},{"(-1+0j)"}})
  n=n+1
end
-- case 1866: complex64 + U8, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1})},{axis=-1})
  verify(r,"U64",{{"x","(2+3j)"},{"é","(-1+0j)"}})
  n=n+1
end
-- case 1867: complex64 + U8, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2})},{axis=1})
  verify(r,"U64",{{"x","é"},{"(2+3j)","(-1+0j)"}})
  n=n+1
end
-- case 1868: complex64 + U8, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2})},{axis=-1})
  verify(r,"U64",{{"x","(2+3j)"},{"é","(-1+0j)"}})
  n=n+1
end
-- case 1869: complex64 + U8, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2})},{axis=1})
  verify(r,"U64",{{{"x","é"}},{{"(2+3j)","(-1+0j)"}}})
  n=n+1
end
-- case 1870: complex64 + U8, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{1,2})},{axis=-1})
  verify(r,"U64",{{{"x","(2+3j)"},{"é","(-1+0j)"}}})
  n=n+1
end
-- case 1871: complex64 + U8, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1})},{axis=1})
  verify(r,"U64",{{{"x"},{"é"}},{{"(2+3j)"},{"(-1+0j)"}}})
  n=n+1
end
-- case 1872: complex64 + U8, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex64"),{2,1})},{axis=-1})
  verify(r,"U64",{{{"x","(2+3j)"}},{{"é","(-1+0j)"}}})
  n=n+1
end
-- case 1873: complex128 + S1, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=1})
  verify(r,"S64",{"(2+3j)","(-1+0j)","x","y"})
  n=n+1
end
-- case 1874: complex128 + S1, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=-1})
  verify(r,"S64",{"(2+3j)","(-1+0j)","x","y"})
  n=n+1
end
-- case 1875: complex128 + S1, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=1})
  verify(r,"S64",{{"(2+3j)","(-1+0j)"},{"x","y"}})
  n=n+1
end
-- case 1876: complex128 + S1, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=-1})
  verify(r,"S64",{{"(2+3j)","(-1+0j)","x","y"}})
  n=n+1
end
-- case 1877: complex128 + S1, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=1})
  verify(r,"S64",{{"(2+3j)"},{"(-1+0j)"},{"x"},{"y"}})
  n=n+1
end
-- case 1878: complex128 + S1, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=-1})
  verify(r,"S64",{{"(2+3j)","x"},{"(-1+0j)","y"}})
  n=n+1
end
-- case 1879: complex128 + S1, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=1})
  verify(r,"S64",{{"(2+3j)","(-1+0j)"},{"x","y"}})
  n=n+1
end
-- case 1880: complex128 + S1, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2}),np.reshape(np.array({"x","yz"},"S1"),{2})},{axis=-1})
  verify(r,"S64",{{"(2+3j)","x"},{"(-1+0j)","y"}})
  n=n+1
end
-- case 1881: complex128 + S1, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=1})
  verify(r,"S64",{{{"(2+3j)","(-1+0j)"}},{{"x","y"}}})
  n=n+1
end
-- case 1882: complex128 + S1, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2}),np.reshape(np.array({"x","yz"},"S1"),{1,2})},{axis=-1})
  verify(r,"S64",{{{"(2+3j)","x"},{"(-1+0j)","y"}}})
  n=n+1
end
-- case 1883: complex128 + S1, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=1})
  verify(r,"S64",{{{"(2+3j)"},{"(-1+0j)"}},{{"x"},{"y"}}})
  n=n+1
end
-- case 1884: complex128 + S1, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1}),np.reshape(np.array({"x","yz"},"S1"),{2,1})},{axis=-1})
  verify(r,"S64",{{{"(2+3j)","x"}},{{"(-1+0j)","y"}}})
  n=n+1
end
-- case 1885: complex128 + S1, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2})},{axis=1})
  verify(r,"S64",{"x","y","(2+3j)","(-1+0j)"})
  n=n+1
end
-- case 1886: complex128 + S1, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2})},{axis=-1})
  verify(r,"S64",{"x","y","(2+3j)","(-1+0j)"})
  n=n+1
end
-- case 1887: complex128 + S1, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2})},{axis=1})
  verify(r,"S64",{{"x","y"},{"(2+3j)","(-1+0j)"}})
  n=n+1
end
-- case 1888: complex128 + S1, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2})},{axis=-1})
  verify(r,"S64",{{"x","y","(2+3j)","(-1+0j)"}})
  n=n+1
end
-- case 1889: complex128 + S1, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1})},{axis=1})
  verify(r,"S64",{{"x"},{"y"},{"(2+3j)"},{"(-1+0j)"}})
  n=n+1
end
-- case 1890: complex128 + S1, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1})},{axis=-1})
  verify(r,"S64",{{"x","(2+3j)"},{"y","(-1+0j)"}})
  n=n+1
end
-- case 1891: complex128 + S1, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2})},{axis=1})
  verify(r,"S64",{{"x","y"},{"(2+3j)","(-1+0j)"}})
  n=n+1
end
-- case 1892: complex128 + S1, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2})},{axis=-1})
  verify(r,"S64",{{"x","(2+3j)"},{"y","(-1+0j)"}})
  n=n+1
end
-- case 1893: complex128 + S1, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2})},{axis=1})
  verify(r,"S64",{{{"x","y"}},{{"(2+3j)","(-1+0j)"}}})
  n=n+1
end
-- case 1894: complex128 + S1, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2})},{axis=-1})
  verify(r,"S64",{{{"x","(2+3j)"},{"y","(-1+0j)"}}})
  n=n+1
end
-- case 1895: complex128 + S1, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1})},{axis=1})
  verify(r,"S64",{{{"x"},{"y"}},{{"(2+3j)"},{"(-1+0j)"}}})
  n=n+1
end
-- case 1896: complex128 + S1, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S1"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1})},{axis=-1})
  verify(r,"S64",{{{"x","(2+3j)"}},{{"y","(-1+0j)"}}})
  n=n+1
end
-- case 1897: complex128 + S3, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=1})
  verify(r,"S64",{"(2+3j)","(-1+0j)","x","yz"})
  n=n+1
end
-- case 1898: complex128 + S3, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=-1})
  verify(r,"S64",{"(2+3j)","(-1+0j)","x","yz"})
  n=n+1
end
-- case 1899: complex128 + S3, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=1})
  verify(r,"S64",{{"(2+3j)","(-1+0j)"},{"x","yz"}})
  n=n+1
end
-- case 1900: complex128 + S3, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=-1})
  verify(r,"S64",{{"(2+3j)","(-1+0j)","x","yz"}})
  n=n+1
end
-- case 1901: complex128 + S3, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=1})
  verify(r,"S64",{{"(2+3j)"},{"(-1+0j)"},{"x"},{"yz"}})
  n=n+1
end
-- case 1902: complex128 + S3, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=-1})
  verify(r,"S64",{{"(2+3j)","x"},{"(-1+0j)","yz"}})
  n=n+1
end
-- case 1903: complex128 + S3, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=1})
  verify(r,"S64",{{"(2+3j)","(-1+0j)"},{"x","yz"}})
  n=n+1
end
-- case 1904: complex128 + S3, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2}),np.reshape(np.array({"x","yz"},"S3"),{2})},{axis=-1})
  verify(r,"S64",{{"(2+3j)","x"},{"(-1+0j)","yz"}})
  n=n+1
end
-- case 1905: complex128 + S3, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=1})
  verify(r,"S64",{{{"(2+3j)","(-1+0j)"}},{{"x","yz"}}})
  n=n+1
end
-- case 1906: complex128 + S3, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2}),np.reshape(np.array({"x","yz"},"S3"),{1,2})},{axis=-1})
  verify(r,"S64",{{{"(2+3j)","x"},{"(-1+0j)","yz"}}})
  n=n+1
end
-- case 1907: complex128 + S3, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=1})
  verify(r,"S64",{{{"(2+3j)"},{"(-1+0j)"}},{{"x"},{"yz"}}})
  n=n+1
end
-- case 1908: complex128 + S3, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1}),np.reshape(np.array({"x","yz"},"S3"),{2,1})},{axis=-1})
  verify(r,"S64",{{{"(2+3j)","x"}},{{"(-1+0j)","yz"}}})
  n=n+1
end
-- case 1909: complex128 + S3, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2})},{axis=1})
  verify(r,"S64",{"x","yz","(2+3j)","(-1+0j)"})
  n=n+1
end
-- case 1910: complex128 + S3, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2})},{axis=-1})
  verify(r,"S64",{"x","yz","(2+3j)","(-1+0j)"})
  n=n+1
end
-- case 1911: complex128 + S3, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2})},{axis=1})
  verify(r,"S64",{{"x","yz"},{"(2+3j)","(-1+0j)"}})
  n=n+1
end
-- case 1912: complex128 + S3, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2})},{axis=-1})
  verify(r,"S64",{{"x","yz","(2+3j)","(-1+0j)"}})
  n=n+1
end
-- case 1913: complex128 + S3, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1})},{axis=1})
  verify(r,"S64",{{"x"},{"yz"},{"(2+3j)"},{"(-1+0j)"}})
  n=n+1
end
-- case 1914: complex128 + S3, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1})},{axis=-1})
  verify(r,"S64",{{"x","(2+3j)"},{"yz","(-1+0j)"}})
  n=n+1
end
-- case 1915: complex128 + S3, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2})},{axis=1})
  verify(r,"S64",{{"x","yz"},{"(2+3j)","(-1+0j)"}})
  n=n+1
end
-- case 1916: complex128 + S3, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2})},{axis=-1})
  verify(r,"S64",{{"x","(2+3j)"},{"yz","(-1+0j)"}})
  n=n+1
end
-- case 1917: complex128 + S3, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2})},{axis=1})
  verify(r,"S64",{{{"x","yz"}},{{"(2+3j)","(-1+0j)"}}})
  n=n+1
end
-- case 1918: complex128 + S3, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2})},{axis=-1})
  verify(r,"S64",{{{"x","(2+3j)"},{"yz","(-1+0j)"}}})
  n=n+1
end
-- case 1919: complex128 + S3, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1})},{axis=1})
  verify(r,"S64",{{{"x"},{"yz"}},{{"(2+3j)"},{"(-1+0j)"}}})
  n=n+1
end
-- case 1920: complex128 + S3, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S3"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1})},{axis=-1})
  verify(r,"S64",{{{"x","(2+3j)"}},{{"yz","(-1+0j)"}}})
  n=n+1
end
-- case 1921: complex128 + S8, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=1})
  verify(r,"S64",{"(2+3j)","(-1+0j)","x","yz"})
  n=n+1
end
-- case 1922: complex128 + S8, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=-1})
  verify(r,"S64",{"(2+3j)","(-1+0j)","x","yz"})
  n=n+1
end
-- case 1923: complex128 + S8, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=1})
  verify(r,"S64",{{"(2+3j)","(-1+0j)"},{"x","yz"}})
  n=n+1
end
-- case 1924: complex128 + S8, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=-1})
  verify(r,"S64",{{"(2+3j)","(-1+0j)","x","yz"}})
  n=n+1
end
-- case 1925: complex128 + S8, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=1})
  verify(r,"S64",{{"(2+3j)"},{"(-1+0j)"},{"x"},{"yz"}})
  n=n+1
end
-- case 1926: complex128 + S8, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=-1})
  verify(r,"S64",{{"(2+3j)","x"},{"(-1+0j)","yz"}})
  n=n+1
end
-- case 1927: complex128 + S8, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=1})
  verify(r,"S64",{{"(2+3j)","(-1+0j)"},{"x","yz"}})
  n=n+1
end
-- case 1928: complex128 + S8, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2}),np.reshape(np.array({"x","yz"},"S8"),{2})},{axis=-1})
  verify(r,"S64",{{"(2+3j)","x"},{"(-1+0j)","yz"}})
  n=n+1
end
-- case 1929: complex128 + S8, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=1})
  verify(r,"S64",{{{"(2+3j)","(-1+0j)"}},{{"x","yz"}}})
  n=n+1
end
-- case 1930: complex128 + S8, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2}),np.reshape(np.array({"x","yz"},"S8"),{1,2})},{axis=-1})
  verify(r,"S64",{{{"(2+3j)","x"},{"(-1+0j)","yz"}}})
  n=n+1
end
-- case 1931: complex128 + S8, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=1})
  verify(r,"S64",{{{"(2+3j)"},{"(-1+0j)"}},{{"x"},{"yz"}}})
  n=n+1
end
-- case 1932: complex128 + S8, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1}),np.reshape(np.array({"x","yz"},"S8"),{2,1})},{axis=-1})
  verify(r,"S64",{{{"(2+3j)","x"}},{{"(-1+0j)","yz"}}})
  n=n+1
end
-- case 1933: complex128 + S8, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2})},{axis=1})
  verify(r,"S64",{"x","yz","(2+3j)","(-1+0j)"})
  n=n+1
end
-- case 1934: complex128 + S8, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2})},{axis=-1})
  verify(r,"S64",{"x","yz","(2+3j)","(-1+0j)"})
  n=n+1
end
-- case 1935: complex128 + S8, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2})},{axis=1})
  verify(r,"S64",{{"x","yz"},{"(2+3j)","(-1+0j)"}})
  n=n+1
end
-- case 1936: complex128 + S8, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2})},{axis=-1})
  verify(r,"S64",{{"x","yz","(2+3j)","(-1+0j)"}})
  n=n+1
end
-- case 1937: complex128 + S8, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1})},{axis=1})
  verify(r,"S64",{{"x"},{"yz"},{"(2+3j)"},{"(-1+0j)"}})
  n=n+1
end
-- case 1938: complex128 + S8, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1})},{axis=-1})
  verify(r,"S64",{{"x","(2+3j)"},{"yz","(-1+0j)"}})
  n=n+1
end
-- case 1939: complex128 + S8, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2})},{axis=1})
  verify(r,"S64",{{"x","yz"},{"(2+3j)","(-1+0j)"}})
  n=n+1
end
-- case 1940: complex128 + S8, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2})},{axis=-1})
  verify(r,"S64",{{"x","(2+3j)"},{"yz","(-1+0j)"}})
  n=n+1
end
-- case 1941: complex128 + S8, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2})},{axis=1})
  verify(r,"S64",{{{"x","yz"}},{{"(2+3j)","(-1+0j)"}}})
  n=n+1
end
-- case 1942: complex128 + S8, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2})},{axis=-1})
  verify(r,"S64",{{{"x","(2+3j)"},{"yz","(-1+0j)"}}})
  n=n+1
end
-- case 1943: complex128 + S8, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1})},{axis=1})
  verify(r,"S64",{{{"x"},{"yz"}},{{"(2+3j)"},{"(-1+0j)"}}})
  n=n+1
end
-- case 1944: complex128 + S8, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","yz"},"S8"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1})},{axis=-1})
  verify(r,"S64",{{{"x","(2+3j)"}},{{"yz","(-1+0j)"}}})
  n=n+1
end
-- case 1945: complex128 + U1, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=1})
  verify(r,"U64",{"(2+3j)","(-1+0j)","x","é"})
  n=n+1
end
-- case 1946: complex128 + U1, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=-1})
  verify(r,"U64",{"(2+3j)","(-1+0j)","x","é"})
  n=n+1
end
-- case 1947: complex128 + U1, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=1})
  verify(r,"U64",{{"(2+3j)","(-1+0j)"},{"x","é"}})
  n=n+1
end
-- case 1948: complex128 + U1, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=-1})
  verify(r,"U64",{{"(2+3j)","(-1+0j)","x","é"}})
  n=n+1
end
-- case 1949: complex128 + U1, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=1})
  verify(r,"U64",{{"(2+3j)"},{"(-1+0j)"},{"x"},{"é"}})
  n=n+1
end
-- case 1950: complex128 + U1, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=-1})
  verify(r,"U64",{{"(2+3j)","x"},{"(-1+0j)","é"}})
  n=n+1
end
-- case 1951: complex128 + U1, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=1})
  verify(r,"U64",{{"(2+3j)","(-1+0j)"},{"x","é"}})
  n=n+1
end
-- case 1952: complex128 + U1, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2}),np.reshape(np.array({"x","é"},"U1"),{2})},{axis=-1})
  verify(r,"U64",{{"(2+3j)","x"},{"(-1+0j)","é"}})
  n=n+1
end
-- case 1953: complex128 + U1, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=1})
  verify(r,"U64",{{{"(2+3j)","(-1+0j)"}},{{"x","é"}}})
  n=n+1
end
-- case 1954: complex128 + U1, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2}),np.reshape(np.array({"x","é"},"U1"),{1,2})},{axis=-1})
  verify(r,"U64",{{{"(2+3j)","x"},{"(-1+0j)","é"}}})
  n=n+1
end
-- case 1955: complex128 + U1, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=1})
  verify(r,"U64",{{{"(2+3j)"},{"(-1+0j)"}},{{"x"},{"é"}}})
  n=n+1
end
-- case 1956: complex128 + U1, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1}),np.reshape(np.array({"x","é"},"U1"),{2,1})},{axis=-1})
  verify(r,"U64",{{{"(2+3j)","x"}},{{"(-1+0j)","é"}}})
  n=n+1
end
-- case 1957: complex128 + U1, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2})},{axis=1})
  verify(r,"U64",{"x","é","(2+3j)","(-1+0j)"})
  n=n+1
end
-- case 1958: complex128 + U1, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2})},{axis=-1})
  verify(r,"U64",{"x","é","(2+3j)","(-1+0j)"})
  n=n+1
end
-- case 1959: complex128 + U1, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2})},{axis=1})
  verify(r,"U64",{{"x","é"},{"(2+3j)","(-1+0j)"}})
  n=n+1
end
-- case 1960: complex128 + U1, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2})},{axis=-1})
  verify(r,"U64",{{"x","é","(2+3j)","(-1+0j)"}})
  n=n+1
end
-- case 1961: complex128 + U1, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1})},{axis=1})
  verify(r,"U64",{{"x"},{"é"},{"(2+3j)"},{"(-1+0j)"}})
  n=n+1
end
-- case 1962: complex128 + U1, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1})},{axis=-1})
  verify(r,"U64",{{"x","(2+3j)"},{"é","(-1+0j)"}})
  n=n+1
end
-- case 1963: complex128 + U1, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2})},{axis=1})
  verify(r,"U64",{{"x","é"},{"(2+3j)","(-1+0j)"}})
  n=n+1
end
-- case 1964: complex128 + U1, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2})},{axis=-1})
  verify(r,"U64",{{"x","(2+3j)"},{"é","(-1+0j)"}})
  n=n+1
end
-- case 1965: complex128 + U1, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2})},{axis=1})
  verify(r,"U64",{{{"x","é"}},{{"(2+3j)","(-1+0j)"}}})
  n=n+1
end
-- case 1966: complex128 + U1, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2})},{axis=-1})
  verify(r,"U64",{{{"x","(2+3j)"},{"é","(-1+0j)"}}})
  n=n+1
end
-- case 1967: complex128 + U1, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1})},{axis=1})
  verify(r,"U64",{{{"x"},{"é"}},{{"(2+3j)"},{"(-1+0j)"}}})
  n=n+1
end
-- case 1968: complex128 + U1, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U1"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1})},{axis=-1})
  verify(r,"U64",{{{"x","(2+3j)"}},{{"é","(-1+0j)"}}})
  n=n+1
end
-- case 1969: complex128 + U3, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=1})
  verify(r,"U64",{"(2+3j)","(-1+0j)","x","é"})
  n=n+1
end
-- case 1970: complex128 + U3, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=-1})
  verify(r,"U64",{"(2+3j)","(-1+0j)","x","é"})
  n=n+1
end
-- case 1971: complex128 + U3, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=1})
  verify(r,"U64",{{"(2+3j)","(-1+0j)"},{"x","é"}})
  n=n+1
end
-- case 1972: complex128 + U3, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=-1})
  verify(r,"U64",{{"(2+3j)","(-1+0j)","x","é"}})
  n=n+1
end
-- case 1973: complex128 + U3, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=1})
  verify(r,"U64",{{"(2+3j)"},{"(-1+0j)"},{"x"},{"é"}})
  n=n+1
end
-- case 1974: complex128 + U3, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=-1})
  verify(r,"U64",{{"(2+3j)","x"},{"(-1+0j)","é"}})
  n=n+1
end
-- case 1975: complex128 + U3, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=1})
  verify(r,"U64",{{"(2+3j)","(-1+0j)"},{"x","é"}})
  n=n+1
end
-- case 1976: complex128 + U3, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2}),np.reshape(np.array({"x","é"},"U3"),{2})},{axis=-1})
  verify(r,"U64",{{"(2+3j)","x"},{"(-1+0j)","é"}})
  n=n+1
end
-- case 1977: complex128 + U3, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=1})
  verify(r,"U64",{{{"(2+3j)","(-1+0j)"}},{{"x","é"}}})
  n=n+1
end
-- case 1978: complex128 + U3, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2}),np.reshape(np.array({"x","é"},"U3"),{1,2})},{axis=-1})
  verify(r,"U64",{{{"(2+3j)","x"},{"(-1+0j)","é"}}})
  n=n+1
end
-- case 1979: complex128 + U3, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=1})
  verify(r,"U64",{{{"(2+3j)"},{"(-1+0j)"}},{{"x"},{"é"}}})
  n=n+1
end
-- case 1980: complex128 + U3, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1}),np.reshape(np.array({"x","é"},"U3"),{2,1})},{axis=-1})
  verify(r,"U64",{{{"(2+3j)","x"}},{{"(-1+0j)","é"}}})
  n=n+1
end
-- case 1981: complex128 + U3, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2})},{axis=1})
  verify(r,"U64",{"x","é","(2+3j)","(-1+0j)"})
  n=n+1
end
-- case 1982: complex128 + U3, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2})},{axis=-1})
  verify(r,"U64",{"x","é","(2+3j)","(-1+0j)"})
  n=n+1
end
-- case 1983: complex128 + U3, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2})},{axis=1})
  verify(r,"U64",{{"x","é"},{"(2+3j)","(-1+0j)"}})
  n=n+1
end
-- case 1984: complex128 + U3, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2})},{axis=-1})
  verify(r,"U64",{{"x","é","(2+3j)","(-1+0j)"}})
  n=n+1
end
-- case 1985: complex128 + U3, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1})},{axis=1})
  verify(r,"U64",{{"x"},{"é"},{"(2+3j)"},{"(-1+0j)"}})
  n=n+1
end
-- case 1986: complex128 + U3, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1})},{axis=-1})
  verify(r,"U64",{{"x","(2+3j)"},{"é","(-1+0j)"}})
  n=n+1
end
-- case 1987: complex128 + U3, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2})},{axis=1})
  verify(r,"U64",{{"x","é"},{"(2+3j)","(-1+0j)"}})
  n=n+1
end
-- case 1988: complex128 + U3, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2})},{axis=-1})
  verify(r,"U64",{{"x","(2+3j)"},{"é","(-1+0j)"}})
  n=n+1
end
-- case 1989: complex128 + U3, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2})},{axis=1})
  verify(r,"U64",{{{"x","é"}},{{"(2+3j)","(-1+0j)"}}})
  n=n+1
end
-- case 1990: complex128 + U3, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2})},{axis=-1})
  verify(r,"U64",{{{"x","(2+3j)"},{"é","(-1+0j)"}}})
  n=n+1
end
-- case 1991: complex128 + U3, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1})},{axis=1})
  verify(r,"U64",{{{"x"},{"é"}},{{"(2+3j)"},{"(-1+0j)"}}})
  n=n+1
end
-- case 1992: complex128 + U3, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U3"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1})},{axis=-1})
  verify(r,"U64",{{{"x","(2+3j)"}},{{"é","(-1+0j)"}}})
  n=n+1
end
-- case 1993: complex128 + U8, concatenate, shape (2,), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=1})
  verify(r,"U64",{"(2+3j)","(-1+0j)","x","é"})
  n=n+1
end
-- case 1994: complex128 + U8, concatenate, shape (2,), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=-1})
  verify(r,"U64",{"(2+3j)","(-1+0j)","x","é"})
  n=n+1
end
-- case 1995: complex128 + U8, concatenate, shape (1, 2), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=1})
  verify(r,"U64",{{"(2+3j)","(-1+0j)"},{"x","é"}})
  n=n+1
end
-- case 1996: complex128 + U8, concatenate, shape (1, 2), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=-1})
  verify(r,"U64",{{"(2+3j)","(-1+0j)","x","é"}})
  n=n+1
end
-- case 1997: complex128 + U8, concatenate, shape (2, 1), axis 0, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=1})
  verify(r,"U64",{{"(2+3j)"},{"(-1+0j)"},{"x"},{"é"}})
  n=n+1
end
-- case 1998: complex128 + U8, concatenate, shape (2, 1), axis -1, reverse=False
do
  local r=np.concatenate({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=-1})
  verify(r,"U64",{{"(2+3j)","x"},{"(-1+0j)","é"}})
  n=n+1
end
-- case 1999: complex128 + U8, stack, shape (2,), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=1})
  verify(r,"U64",{{"(2+3j)","(-1+0j)"},{"x","é"}})
  n=n+1
end
-- case 2000: complex128 + U8, stack, shape (2,), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2}),np.reshape(np.array({"x","é"},"U8"),{2})},{axis=-1})
  verify(r,"U64",{{"(2+3j)","x"},{"(-1+0j)","é"}})
  n=n+1
end
-- case 2001: complex128 + U8, stack, shape (1, 2), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=1})
  verify(r,"U64",{{{"(2+3j)","(-1+0j)"}},{{"x","é"}}})
  n=n+1
end
-- case 2002: complex128 + U8, stack, shape (1, 2), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2}),np.reshape(np.array({"x","é"},"U8"),{1,2})},{axis=-1})
  verify(r,"U64",{{{"(2+3j)","x"},{"(-1+0j)","é"}}})
  n=n+1
end
-- case 2003: complex128 + U8, stack, shape (2, 1), axis 0, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=1})
  verify(r,"U64",{{{"(2+3j)"},{"(-1+0j)"}},{{"x"},{"é"}}})
  n=n+1
end
-- case 2004: complex128 + U8, stack, shape (2, 1), axis -1, reverse=False
do
  local r=np.stack({np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1}),np.reshape(np.array({"x","é"},"U8"),{2,1})},{axis=-1})
  verify(r,"U64",{{{"(2+3j)","x"}},{{"(-1+0j)","é"}}})
  n=n+1
end
-- case 2005: complex128 + U8, concatenate, shape (2,), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2})},{axis=1})
  verify(r,"U64",{"x","é","(2+3j)","(-1+0j)"})
  n=n+1
end
-- case 2006: complex128 + U8, concatenate, shape (2,), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2})},{axis=-1})
  verify(r,"U64",{"x","é","(2+3j)","(-1+0j)"})
  n=n+1
end
-- case 2007: complex128 + U8, concatenate, shape (1, 2), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2})},{axis=1})
  verify(r,"U64",{{"x","é"},{"(2+3j)","(-1+0j)"}})
  n=n+1
end
-- case 2008: complex128 + U8, concatenate, shape (1, 2), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2})},{axis=-1})
  verify(r,"U64",{{"x","é","(2+3j)","(-1+0j)"}})
  n=n+1
end
-- case 2009: complex128 + U8, concatenate, shape (2, 1), axis 0, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1})},{axis=1})
  verify(r,"U64",{{"x"},{"é"},{"(2+3j)"},{"(-1+0j)"}})
  n=n+1
end
-- case 2010: complex128 + U8, concatenate, shape (2, 1), axis -1, reverse=True
do
  local r=np.concatenate({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1})},{axis=-1})
  verify(r,"U64",{{"x","(2+3j)"},{"é","(-1+0j)"}})
  n=n+1
end
-- case 2011: complex128 + U8, stack, shape (2,), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2})},{axis=1})
  verify(r,"U64",{{"x","é"},{"(2+3j)","(-1+0j)"}})
  n=n+1
end
-- case 2012: complex128 + U8, stack, shape (2,), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2})},{axis=-1})
  verify(r,"U64",{{"x","(2+3j)"},{"é","(-1+0j)"}})
  n=n+1
end
-- case 2013: complex128 + U8, stack, shape (1, 2), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2})},{axis=1})
  verify(r,"U64",{{{"x","é"}},{{"(2+3j)","(-1+0j)"}}})
  n=n+1
end
-- case 2014: complex128 + U8, stack, shape (1, 2), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{1,2}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{1,2})},{axis=-1})
  verify(r,"U64",{{{"x","(2+3j)"},{"é","(-1+0j)"}}})
  n=n+1
end
-- case 2015: complex128 + U8, stack, shape (2, 1), axis 0, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1})},{axis=1})
  verify(r,"U64",{{{"x"},{"é"}},{{"(2+3j)"},{"(-1+0j)"}}})
  n=n+1
end
-- case 2016: complex128 + U8, stack, shape (2, 1), axis -1, reverse=True
do
  local r=np.stack({np.reshape(np.array({"x","é"},"U8"),{2,1}),np.reshape(np.array({np.complex(2.0,3.0),np.complex(-1.0,0.0)},"complex128"),{2,1})},{axis=-1})
  verify(r,"U64",{{{"x","(2+3j)"}},{{"é","(-1+0j)"}}})
  n=n+1
end
do
  local ok=pcall(function() return np.concatenate({np.array({1,2},"datetime64[D]"),np.array({"x","y"},"S2")}) end)
  assert(not ok,"unsupported temporal/text promotion")
  n=n+1
end
do
  local ok=pcall(function() return np.concatenate({np.array({1,2},"datetime64[D]"),np.array({"x","y"},"U3")}) end)
  assert(not ok,"unsupported temporal/text promotion")
  n=n+1
end
do
  local ok=pcall(function() return np.concatenate({np.array({1,2},"timedelta64[s]"),np.array({"x","y"},"S2")}) end)
  assert(not ok,"unsupported temporal/text promotion")
  n=n+1
end
do
  local ok=pcall(function() return np.concatenate({np.array({1,2},"timedelta64[s]"),np.array({"x","y"},"U3")}) end)
  assert(not ok,"unsupported temporal/text promotion")
  n=n+1
end
assert(n==2020);print('promotion differential: '..n..' cases ok')
