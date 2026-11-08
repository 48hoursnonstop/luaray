local np=require("luaray_core")
local function eq(a,b)
  if type(a)~=type(b) then return false end
  if type(a)~="table" then if type(a)=="number" and a~=a and b~=b then return true end; return a==b end
  if #a~=#b then return false end; for i=1,#a do if not eq(a[i],b[i]) then return false end end; return true
end
-- Generated against development NumPy 2.3.5.
do -- searcharray 0
  local a=np.array({13,21,42,50,71,79,100,108,137,166,195},np.uint16)
  local k=np.array({-115,-28,-13},np.int16)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 0 dtype")
  assert(eq(r.shape,{3}),"searchsorted 0 shape")
  assert(eq(r.strides,{8}),"searchsorted 0 strides")
  assert(eq(r:tolist(),{1,1,1}),"searchsorted 0 values")
end
do -- searcharray 1
  local a=np.array({},np.float32)
  local k=np.array({-89,-108,109,89,38,57,89,-53,72,-62,2,79},np.int64)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 1 dtype")
  assert(eq(r.shape,{12}),"searchsorted 1 shape")
  assert(eq(r.strides,{8}),"searchsorted 1 strides")
  assert(eq(r:tolist(),{1,1,1,1,1,1,1,1,1,1,1,1}),"searchsorted 1 values")
end
do -- searcharray 2
  local a=np.array({-17.5,-10.25,-3.0,4.25,11.5,18.75},np.float64)
  local k=np.array({false,true,true},np.bool)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 2 dtype")
  assert(eq(r.shape,{3}),"searchsorted 2 shape")
  assert(eq(r.strides,{8}),"searchsorted 2 strides")
  assert(eq(r:tolist(),{4,4,4}),"searchsorted 2 values")
end
do -- searchscalar 3
  local a=np.array({-63},np.int16)
  local r=np.searchsorted(a,141,"right")
  assert(r==2,"searchsorted scalar 3 got "..tostring(r))
end
do -- searchscalar 4
  local a=np.array({49,78,107,136},np.uint8)
  local r=np.searchsorted(a,false,"right")
  assert(r==1,"searchsorted scalar 4 got "..tostring(r))
end
do -- searchscalar 5
  local a=np.array({false,false,false,true,true,true},np.bool)
  local r=np.searchsorted(a,165,"right")
  assert(r==7,"searchsorted scalar 5 got "..tostring(r))
end
do -- searchscalar 6
  local a=np.array({},np.int32)
  local r=np.searchsorted(a,10,"right")
  assert(r==1,"searchsorted scalar 6 got "..tostring(r))
end
do -- searcharray 7
  local a=np.array({-8.75},np.float64)
  local k=np.array({false,true,true,true,false},np.bool)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 7 dtype")
  assert(eq(r.shape,{5}),"searchsorted 7 shape")
  assert(eq(r.strides,{8}),"searchsorted 7 strides")
  assert(eq(r:tolist(),{2,2,2,2,2}),"searchsorted 7 values")
end
do -- searcharray 8
  local a=np.array({-7.0,0.25,7.5,14.75,0/0},np.float64)
  local k=np.array({41,13,123,174,73,77,5},np.uint16)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 8 dtype")
  assert(eq(r.shape,{7}),"searchsorted 8 shape")
  assert(eq(r.strides,{8}),"searchsorted 8 strides")
  assert(eq(r:tolist(),{5,4,5,5,5,5,3}),"searchsorted 8 values")
end
do -- searcharray 9
  local a=np.array({-21},np.int64)
  local k=np.array({20,-66,11,100,102,-68,110,119,44},np.int8)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 9 dtype")
  assert(eq(r.shape,{9}),"searchsorted 9 shape")
  assert(eq(r.strides,{8}),"searchsorted 9 strides")
  assert(eq(r:tolist(),{2,1,2,2,2,1,2,2,2}),"searchsorted 9 values")
end
do -- searcharray 10
  local a=np.array({-14,15},np.int64)
  local k=np.array({-30,10,-113,-117},np.int16)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 10 dtype")
  assert(eq(r.shape,{4}),"searchsorted 10 shape")
  assert(eq(r.strides,{8}),"searchsorted 10 strides")
  assert(eq(r:tolist(),{1,2,1,1}),"searchsorted 10 values")
end
do -- searcharray 11
  local a=np.array({-102,-81,-73,-52,-44,-23,-15,-7,6,14,22,35,43,51,64,72,80,101},np.int64)
  local k=np.array({-11.25,-11.5,24.75,6.75,27.75,24.25},np.float32)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 11 dtype")
  assert(eq(r.shape,{6}),"searchsorted 11 shape")
  assert(eq(r.strides,{8}),"searchsorted 11 strides")
  assert(eq(r:tolist(),{8,8,12,10,12,12}),"searchsorted 11 values")
end
do -- searchscalar 12
  local a=np.array({-103,-95,-74,-66,-45,-37,-16,-8,0,13,21,29,50,58,79,87},np.int64)
  local r=np.searchsorted(a,130,"right")
  assert(r==17,"searchsorted scalar 12 got "..tostring(r))
end
do -- searcharray 13
  local a=np.array({},np.uint16)
  local k=np.array({{68,-105,13,94},{2,98,12,53}},np.int32)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 13 dtype")
  assert(eq(r.shape,{2,4}),"searchsorted 13 shape")
  assert(eq(r.strides,{32,8}),"searchsorted 13 strides")
  assert(eq(r:tolist(),{{1,1,1,1},{1,1,1,1}}),"searchsorted 13 values")
end
do -- searcharray 14
  local a=np.array({},np.uint16)
  local k=np.array({{20,8},{5,-42}},np.int64)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 14 dtype")
  assert(eq(r.shape,{2,2}),"searchsorted 14 shape")
  assert(eq(r.strides,{16,8}),"searchsorted 14 strides")
  assert(eq(r:tolist(),{{1,1},{1,1}}),"searchsorted 14 values")
end
do -- searcharray 15
  local a=np.array({-103,-74,-45,-16,13,21,42,50,71,79,100},np.int64)
  local k=np.array({{3.75},{1.75}},np.float64)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 15 dtype")
  assert(eq(r.shape,{2,1}),"searchsorted 15 shape")
  assert(eq(r.strides,{8,8}),"searchsorted 15 strides")
  assert(eq(r:tolist(),{{5},{5}}),"searchsorted 15 values")
end
do -- searcharray 16
  local a=np.array({-104,-96,-75,-67,-46,-38,-17,-9,20,28,49,57,78,86},np.int64)
  local k=np.array({40,14,105,148,141},np.uint32)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 16 dtype")
  assert(eq(r.shape,{5}),"searchsorted 16 shape")
  assert(eq(r.strides,{8}),"searchsorted 16 strides")
  assert(eq(r:tolist(),{11,9,15,15,15}),"searchsorted 16 values")
end
do -- searcharray 17
  local a=np.array({-89,-60,-31,-2,27,35,64,93},np.int8)
  local k=np.array({{108,-18,-51,-119,29},{8,-6,-54,20,-56}},np.int32)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 17 dtype")
  assert(eq(r.shape,{2,5}),"searchsorted 17 shape")
  assert(eq(r.strides,{40,8}),"searchsorted 17 strides")
  assert(eq(r:tolist(),{{9,4,3,1,6},{5,4,3,5,3}}),"searchsorted 17 values")
end
do -- searcharray 18
  local a=np.array({-90,-82,-53,-24,5,34,42,63,71,92,100},np.int32)
  local k=np.array({37,9},np.uint8)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 18 dtype")
  assert(eq(r.shape,{2}),"searchsorted 18 shape")
  assert(eq(r.strides,{8}),"searchsorted 18 strides")
  assert(eq(r:tolist(),{7,6}),"searchsorted 18 values")
end
do -- searcharray 19
  local a=np.array({-26.0,-18.75,-11.5,-4.25,12.25,19.5},np.float32)
  local k=np.array({-9,113},np.int64)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 19 dtype")
  assert(eq(r.shape,{2}),"searchsorted 19 shape")
  assert(eq(r.strides,{8}),"searchsorted 19 strides")
  assert(eq(r:tolist(),{4,7}),"searchsorted 19 values")
end
do -- searchscalar 20
  local a=np.array({false,false,false,false,false,true,true,true,true,true,true},np.bool)
  local r=np.searchsorted(a,98,"left")
  assert(r==12,"searchsorted scalar 20 got "..tostring(r))
end
do -- searcharray 21
  local a=np.array({},np.float64)
  local k=np.array({{69,182,170,23,55,78},{128,162,214,219,91,208}},np.uint16)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 21 dtype")
  assert(eq(r.shape,{2,6}),"searchsorted 21 shape")
  assert(eq(r.strides,{48,8}),"searchsorted 21 strides")
  assert(eq(r:tolist(),{{1,1,1,1,1,1},{1,1,1,1,1,1}}),"searchsorted 21 values")
end
do -- searcharray 22
  local a=np.array({14,22,43,51,72,80,101,109,130,138,159,167,175,188,196,204},np.uint32)
  local k=np.array({},np.bool)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 22 dtype")
  assert(eq(r.shape,{0}),"searchsorted 22 shape")
  assert(eq(r.strides,{0}),"searchsorted 22 strides")
  assert(eq(r:tolist(),{}),"searchsorted 22 values")
end
do -- searcharray 23
  local a=np.array({0,21,29,50,58,79,87,116,145,174,182,203},np.uint32)
  local k=np.array({9,184,56,165,106,87,39,168,29,116,99,79},np.uint16)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 23 dtype")
  assert(eq(r.shape,{12}),"searchsorted 23 shape")
  assert(eq(r.strides,{8}),"searchsorted 23 strides")
  assert(eq(r:tolist(),{2,12,5,10,8,7,4,10,3,8,8,6}),"searchsorted 23 values")
end
do -- searchscalar 24
  local a=np.array({},np.uint8)
  local r=np.searchsorted(a,92,"right")
  assert(r==1,"searchsorted scalar 24 got "..tostring(r))
end
do -- searchscalar 25
  local a=np.array({-99,-91,-70,-62,-33,-4,25,54,83,91},np.int64)
  local r=np.searchsorted(a,-50,"right")
  assert(r==5,"searchsorted scalar 25 got "..tostring(r))
end
do -- searchscalar 26
  local a=np.array({-92,-84,-63,-55,-34,-26,-5,3,24,32,61,90,98},np.int32)
  local r=np.searchsorted(a,217,"left")
  assert(r==14,"searchsorted scalar 26 got "..tostring(r))
end
do -- searcharray 27
  local a=np.array({false,false,true,true},np.bool)
  local k=np.array({113,-64},np.int32)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 27 dtype")
  assert(eq(r.shape,{2}),"searchsorted 27 shape")
  assert(eq(r.strides,{8}),"searchsorted 27 strides")
  assert(eq(r:tolist(),{5,1}),"searchsorted 27 values")
end
do -- searcharray 28
  local a=np.array({false,false,false,false,false,false,true,true,true,true,true,true,true},np.bool)
  local k=np.array({2,58,7,117,143,37,40,100,164,209,68,103},np.uint32)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 28 dtype")
  assert(eq(r.shape,{12}),"searchsorted 28 shape")
  assert(eq(r.strides,{8}),"searchsorted 28 strides")
  assert(eq(r:tolist(),{14,14,14,14,14,14,14,14,14,14,14,14}),"searchsorted 28 values")
end
do -- searchscalar 29
  local a=np.array({-25.0,-23.0,-17.75,-15.75,-10.5,-8.5,-3.25,-1.25,4.0,6.0,11.25,13.25,18.5,20.5,25.75},np.float32)
  local r=np.searchsorted(a,133,"left")
  assert(r==16,"searchsorted scalar 29 got "..tostring(r))
end
do -- searchscalar 30
  local a=np.array({},np.float32)
  local r=np.searchsorted(a,207,"left")
  assert(r==1,"searchsorted scalar 30 got "..tostring(r))
end
do -- searcharray 31
  local a=np.array({11,19,27,40,48,56,69,77,85,98,106,114,135,143,164,172,193,201},np.uint8)
  local k=np.array({{-0.5,16.5,-19.75,19.5},{-23.5,11.75,-23.25,4.25}},np.float64)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 31 dtype")
  assert(eq(r.shape,{2,4}),"searchsorted 31 shape")
  assert(eq(r.strides,{32,8}),"searchsorted 31 strides")
  assert(eq(r:tolist(),{{1,2,1,3},{1,2,1,1}}),"searchsorted 31 values")
end
do -- searchscalar 32
  local a=np.array({26,34,63,92,121,150,179,208},np.uint8)
  local r=np.searchsorted(a,12,"right")
  assert(r==1,"searchsorted scalar 32 got "..tostring(r))
end
do -- searcharray 33
  local a=np.array({-64,-35,-6,23,52,81},np.int64)
  local k=np.array({-16.75,-13.5,7.25,9.75,0/0},np.float32)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 33 dtype")
  assert(eq(r.shape,{5}),"searchsorted 33 shape")
  assert(eq(r.strides,{8}),"searchsorted 33 strides")
  assert(eq(r:tolist(),{3,3,4,4,7}),"searchsorted 33 values")
end
do -- searchscalar 34
  local a=np.array({-102,-94,-65,-57,-36,-28,-7,1,22,30,51,59,80,88},np.int32)
  local r=np.searchsorted(a,-55,"left")
  assert(r==5,"searchsorted scalar 34 got "..tostring(r))
end
do -- searchscalar 35
  local a=np.array({-87,-50,-21,8,37,66,95},np.int16)
  local r=np.searchsorted(a,11,"left")
  assert(r==5,"searchsorted scalar 35 got "..tostring(r))
end
do -- searcharray 36
  local a=np.array({25,54,62,83,91,112,120,149,178,207},np.uint8)
  local k=np.array({215,4,31,75,163,116,75,189},np.uint8)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 36 dtype")
  assert(eq(r.shape,{8}),"searchsorted 36 shape")
  assert(eq(r.strides,{8}),"searchsorted 36 strides")
  assert(eq(r:tolist(),{11,1,2,4,9,7,4,10}),"searchsorted 36 values")
end
do -- searchscalar 37
  local a=np.array({3,69,98,127,156,185},np.uint16)
  local r=np.searchsorted(a,80,"right")
  assert(r==3,"searchsorted scalar 37 got "..tostring(r))
end
do -- searcharray 38
  local a=np.array({-7.25},np.float32)
  local k=np.array({{37,58,-37,104,25,36},{-57,-28,81,-53,-45,10}},np.int32)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 38 dtype")
  assert(eq(r.shape,{2,6}),"searchsorted 38 shape")
  assert(eq(r.strides,{48,8}),"searchsorted 38 strides")
  assert(eq(r:tolist(),{{2,2,1,2,2,2},{1,1,2,1,1,2}}),"searchsorted 38 values")
end
do -- searcharray 39
  local a=np.array({-96,-88,-67,-59,-38,-30,-22,-1,7,28,36,57,65,86,94},np.int64)
  local k=np.array({20.0,-13.25,20.5,-16.75,-27.75,29.25,-8.75},np.float32)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 39 dtype")
  assert(eq(r.shape,{7}),"searchsorted 39 shape")
  assert(eq(r.strides,{8}),"searchsorted 39 strides")
  assert(eq(r:tolist(),{10,8,10,8,7,11,8}),"searchsorted 39 values")
end
do -- searcharray 40
  local a=np.array({-81,-52,-15,14,43,72,101},np.int16)
  local k=np.array({114,158,91},np.uint32)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 40 dtype")
  assert(eq(r.shape,{3}),"searchsorted 40 shape")
  assert(eq(r.strides,{8}),"searchsorted 40 strides")
  assert(eq(r:tolist(),{8,8,7}),"searchsorted 40 values")
end
do -- searcharray 41
  local a=np.array({false,false,false,false,false,false,false,false,false,true,true,true,true,true,true,true,true,true},np.bool)
  local k=np.array({62,96},np.uint32)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 41 dtype")
  assert(eq(r.shape,{2}),"searchsorted 41 shape")
  assert(eq(r.strides,{8}),"searchsorted 41 strides")
  assert(eq(r:tolist(),{19,19}),"searchsorted 41 values")
end
do -- searcharray 42
  local a=np.array({9,38,67,96,104,133,162,191},np.uint8)
  local k=np.array({-78,14,39,4,115,-22,19,-76},np.int8)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 42 dtype")
  assert(eq(r.shape,{8}),"searchsorted 42 shape")
  assert(eq(r.strides,{8}),"searchsorted 42 strides")
  assert(eq(r:tolist(),{1,2,3,1,6,1,2,1}),"searchsorted 42 values")
end
do -- searcharray 43
  local a=np.array({8,16,45,74,103,111,132,140,161,169,190,198},np.uint16)
  local k=np.array({152,18,183,8,21,20,12,43,188,199,84},np.uint8)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 43 dtype")
  assert(eq(r.shape,{11}),"searchsorted 43 shape")
  assert(eq(r.strides,{8}),"searchsorted 43 strides")
  assert(eq(r:tolist(),{9,3,11,2,3,3,2,3,11,13,5}),"searchsorted 43 values")
end
do -- searcharray 44
  local a=np.array({3.25,10.5,17.75,0/0},np.float32)
  local k=np.array({18.25,12.0,28.75,18.0,5.0,20.75,23.25},np.float64)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 44 dtype")
  assert(eq(r.shape,{7}),"searchsorted 44 shape")
  assert(eq(r.strides,{8}),"searchsorted 44 strides")
  assert(eq(r:tolist(),{4,3,4,4,2,4,4}),"searchsorted 44 values")
end
do -- searcharray 45
  local a=np.array({-104,-83,-75,-54,-46,-25,-17,4,12,20,33,41,49,62,70,78,99},np.int8)
  local k=np.array({4,46,48,54,131,180,72,199,191},np.uint16)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 45 dtype")
  assert(eq(r.shape,{9}),"searchsorted 45 shape")
  assert(eq(r.strides,{8}),"searchsorted 45 strides")
  assert(eq(r:tolist(),{9,13,13,14,18,18,16,18,18}),"searchsorted 45 values")
end
do -- searchscalar 46
  local a=np.array({false,true,true},np.bool)
  local r=np.searchsorted(a,15,"left")
  assert(r==4,"searchsorted scalar 46 got "..tostring(r))
end
do -- searcharray 47
  local a=np.array({-90,-61,-32,-3,26,34,55,63,92},np.int8)
  local k=np.array({-14,-10,34,-10,59,119,38,112,74,-49,55,-75},np.int8)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 47 dtype")
  assert(eq(r.shape,{12}),"searchsorted 47 shape")
  assert(eq(r.strides,{8}),"searchsorted 47 strides")
  assert(eq(r:tolist(),{4,4,6,4,8,10,7,10,9,3,7,2}),"searchsorted 47 values")
end
do -- searchscalar 48
  local a=np.array({22,146,175,204},np.uint8)
  local r=np.searchsorted(a,129,"left")
  assert(r==2,"searchsorted scalar 48 got "..tostring(r))
end
do -- searchscalar 49
  local a=np.array({0,29,58,87,153,182},np.uint32)
  local r=np.searchsorted(a,43,"right")
  assert(r==3,"searchsorted scalar 49 got "..tostring(r))
end
do -- searchscalar 50
  local a=np.array({7,36,65,94,160,189},np.uint16)
  local r=np.searchsorted(a,-30,"left")
  assert(r==1,"searchsorted scalar 50 got "..tostring(r))
end
do -- searcharray 51
  local a=np.array({-24.75,-22.75,-17.5,-15.5,-10.25,-8.25,-3.0,-1.0,4.25,6.25,11.5,13.5,15.5,18.75,20.75,0/0},np.float32)
  local k=np.array({16.75,-17.25,10.0,-26.75,18.5,28.5,9.0,-1.0,-11.5,-23.5},np.float64)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 51 dtype")
  assert(eq(r.shape,{10}),"searchsorted 51 shape")
  assert(eq(r.strides,{8}),"searchsorted 51 strides")
  assert(eq(r:tolist(),{14,4,11,1,14,16,11,9,5,2}),"searchsorted 51 values")
end
do -- searcharray 52
  local a=np.array({174},np.uint32)
  local k=np.array({-48,-49,-25,10,49,-13,70},np.int32)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 52 dtype")
  assert(eq(r.shape,{7}),"searchsorted 52 shape")
  assert(eq(r.strides,{8}),"searchsorted 52 strides")
  assert(eq(r:tolist(),{1,1,1,1,1,1,1}),"searchsorted 52 values")
end
do -- searcharray 53
  local a=np.array({19.0},np.float32)
  local k=np.array({{false,true,false},{true,false,false}},np.bool)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 53 dtype")
  assert(eq(r.shape,{2,3}),"searchsorted 53 shape")
  assert(eq(r.strides,{24,8}),"searchsorted 53 strides")
  assert(eq(r:tolist(),{{1,1,1},{1,1,1}}),"searchsorted 53 values")
end
do -- searcharray 54
  local a=np.array({true},np.bool)
  local k=np.array({{70},{105}},np.int16)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 54 dtype")
  assert(eq(r.shape,{2,1}),"searchsorted 54 shape")
  assert(eq(r.strides,{8,8}),"searchsorted 54 strides")
  assert(eq(r:tolist(),{{2},{2}}),"searchsorted 54 values")
end
do -- searcharray 55
  local a=np.array({-23.0,22.5},np.float32)
  local k=np.array({{true,true,false,false},{false,true,false,false}},np.bool)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 55 dtype")
  assert(eq(r.shape,{2,4}),"searchsorted 55 shape")
  assert(eq(r.strides,{32,8}),"searchsorted 55 strides")
  assert(eq(r:tolist(),{{2,2,2,2},{2,2,2,2}}),"searchsorted 55 values")
end
do -- searcharray 56
  local a=np.array({20,49,202},np.uint16)
  local k=np.array({-13,-68,31,96,-93,-88,103,-95,56,70},np.int64)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 56 dtype")
  assert(eq(r.shape,{10}),"searchsorted 56 shape")
  assert(eq(r.strides,{8}),"searchsorted 56 strides")
  assert(eq(r:tolist(),{1,1,2,3,1,1,3,1,3,3}),"searchsorted 56 values")
end
do -- searcharray 57
  local a=np.array({27,56,85,209},np.uint32)
  local k=np.array({107,-118,-74,-7,93,-33,22,-72,-60,-91,22},np.int16)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 57 dtype")
  assert(eq(r.shape,{11}),"searchsorted 57 shape")
  assert(eq(r.strides,{8}),"searchsorted 57 strides")
  assert(eq(r:tolist(),{4,1,1,1,4,1,1,1,1,1,1}),"searchsorted 57 values")
end
do -- searcharray 58
  local a=np.array({5,18,26,34,47,55,63,76,84,92,113,121,142,150,171,179,200,208},np.uint32)
  local k=np.array({104},np.uint16)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 58 dtype")
  assert(eq(r.shape,{1}),"searchsorted 58 shape")
  assert(eq(r.strides,{8}),"searchsorted 58 strides")
  assert(eq(r:tolist(),{11}),"searchsorted 58 values")
end
do -- searchscalar 59
  local a=np.array({-25.25,-23.25,-18.0,-16.0,-10.75,-8.75,-3.5,-1.5,3.75,5.75,13.0,20.25},np.float32)
  local r=np.searchsorted(a,-3.5,"right")
  assert(r==8,"searchsorted scalar 59 got "..tostring(r))
end
do -- searcharray 60
  local a=np.array({19,48,77,106},np.uint8)
  local k=np.array({{-33,-60},{54,-82}},np.int16)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 60 dtype")
  assert(eq(r.shape,{2,2}),"searchsorted 60 shape")
  assert(eq(r.strides,{16,8}),"searchsorted 60 strides")
  assert(eq(r:tolist(),{{1,1},{3,1}}),"searchsorted 60 values")
end
do -- searcharray 61
  local a=np.array({-95,-87,-79,-66,-58,-50,-37,-29,-21,0,8,29,37,58,66,87,95},np.int32)
  local k=np.array({{-55,-88,-24,92,105,-118},{90,-68,-14,68,-97,-57}},np.int32)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 61 dtype")
  assert(eq(r.shape,{2,6}),"searchsorted 61 shape")
  assert(eq(r.strides,{48,8}),"searchsorted 61 strides")
  assert(eq(r:tolist(),{{6,2,9,17,18,1},{17,4,10,16,1,6}}),"searchsorted 61 values")
end
do -- searchscalar 62
  local a=np.array({-20.0,-18.0,-12.75,-10.75,-5.5,-3.5,1.75,3.75,9.0,11.0,18.25,25.5},np.float32)
  local r=np.searchsorted(a,false,"right")
  assert(r==7,"searchsorted scalar 62 got "..tostring(r))
end
do -- searcharray 63
  local a=np.array({-102,-73,-65,-44,-36,-7,22,51,80},np.int64)
  local k=np.array({56,-52,67,-30,-105},np.int16)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 63 dtype")
  assert(eq(r.shape,{5}),"searchsorted 63 shape")
  assert(eq(r.strides,{8}),"searchsorted 63 strides")
  assert(eq(r:tolist(),{9,4,9,6,1}),"searchsorted 63 values")
end
do -- searchscalar 64
  local a=np.array({-23.75,-16.5,-14.5,-9.25,-7.25,-2.0,0.0,5.25,7.25,12.5,14.5,19.75,21.75},np.float32)
  local r=np.searchsorted(a,30,"left")
  assert(r==14,"searchsorted scalar 64 got "..tostring(r))
end
do -- searcharray 65
  local a=np.array({-24.0,-22.0,-16.75,-14.75,-12.75,-7.5,-5.5,-0.25,1.75,7.0,9.0,14.25,16.25,21.5,23.5},np.float32)
  local k=np.array({112,-86,-73,10,83,-24,-23,36},np.int32)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 65 dtype")
  assert(eq(r.shape,{8}),"searchsorted 65 shape")
  assert(eq(r.strides,{8}),"searchsorted 65 strides")
  assert(eq(r:tolist(),{16,1,1,12,16,2,2,16}),"searchsorted 65 values")
end
do -- searchscalar 66
  local a=np.array({-81,-52,-44,-23,-15,6,14,35,43,64,72,93,101},np.int16)
  local r=np.searchsorted(a,90,"right")
  assert(r==12,"searchsorted scalar 66 got "..tostring(r))
end
do -- searchscalar 67
  local a=np.array({-37,-8,21},np.int32)
  local r=np.searchsorted(a,0/0,"right")
  assert(r==4,"searchsorted scalar 67 got "..tostring(r))
end
do -- searchscalar 68
  local a=np.array({-24.0,-7.5,-0.25,7.0,14.25,0/0},np.float32)
  local r=np.searchsorted(a,109,"left")
  assert(r==6,"searchsorted scalar 68 got "..tostring(r))
end
do -- searchscalar 69
  local a=np.array({-97,-89,-68,-60,-39,-31,-23,-10,-2,6,19,27,35,56,64,85,93},np.int8)
  local r=np.searchsorted(a,98,"right")
  assert(r==18,"searchsorted scalar 69 got "..tostring(r))
end
do -- searcharray 70
  local a=np.array({89},np.uint32)
  local k=np.array({46},np.uint16)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 70 dtype")
  assert(eq(r.shape,{1}),"searchsorted 70 shape")
  assert(eq(r.strides,{8}),"searchsorted 70 strides")
  assert(eq(r:tolist(),{1}),"searchsorted 70 values")
end
do -- searcharray 71
  local a=np.array({1,22,30,51,59,80,88,96,109,117,125,138,146,154,167,175,183,204},np.uint8)
  local k=np.array({98,-48},np.int64)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 71 dtype")
  assert(eq(r.shape,{2}),"searchsorted 71 shape")
  assert(eq(r.strides,{8}),"searchsorted 71 strides")
  assert(eq(r:tolist(),{9,1}),"searchsorted 71 values")
end
do -- searcharray 72
  local a=np.array({-2,27,56,85},np.int8)
  local k=np.array({61},np.uint16)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 72 dtype")
  assert(eq(r.shape,{1}),"searchsorted 72 shape")
  assert(eq(r.strides,{8}),"searchsorted 72 strides")
  assert(eq(r:tolist(),{4}),"searchsorted 72 values")
end
do -- searcharray 73
  local a=np.array({5},np.int64)
  local k=np.array({-20.75,27.0,1.25,0.0,-15.5,-7.25,-2.25},np.float32)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 73 dtype")
  assert(eq(r.shape,{7}),"searchsorted 73 shape")
  assert(eq(r.strides,{8}),"searchsorted 73 strides")
  assert(eq(r:tolist(),{1,2,1,1,1,1,1}),"searchsorted 73 values")
end
do -- searchscalar 74
  local a=np.array({-91,-83,-62,-54,-33,-25,-4,4,12,25,33,41,62,70,91,99},np.int8)
  local r=np.searchsorted(a,true,"right")
  assert(r==8,"searchsorted scalar 74 got "..tostring(r))
end
do -- searcharray 75
  local a=np.array({19,48,77},np.int32)
  local k=np.array({{-110},{53}},np.int8)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 75 dtype")
  assert(eq(r.shape,{2,1}),"searchsorted 75 shape")
  assert(eq(r.strides,{8,8}),"searchsorted 75 strides")
  assert(eq(r:tolist(),{{1},{3}}),"searchsorted 75 values")
end
do -- searcharray 76
  local a=np.array({},np.float64)
  local k=np.array({81,-63,-94,-48,-64,-85,-120,-20,-105,64,-7},np.int16)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 76 dtype")
  assert(eq(r.shape,{11}),"searchsorted 76 shape")
  assert(eq(r.strides,{8}),"searchsorted 76 strides")
  assert(eq(r:tolist(),{1,1,1,1,1,1,1,1,1,1,1}),"searchsorted 76 values")
end
do -- searchscalar 77
  local a=np.array({6,14,35,43,64,72,101,130,138,159,167,188,196},np.uint8)
  local r=np.searchsorted(a,-24.25,"left")
  assert(r==1,"searchsorted scalar 77 got "..tostring(r))
end
do -- searcharray 78
  local a=np.array({},np.uint32)
  local k=np.array({120,-106,8,28,-43},np.int32)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 78 dtype")
  assert(eq(r.shape,{5}),"searchsorted 78 shape")
  assert(eq(r.strides,{8}),"searchsorted 78 strides")
  assert(eq(r:tolist(),{1,1,1,1,1}),"searchsorted 78 values")
end
do -- searcharray 79
  local a=np.array({152},np.uint8)
  local k=np.array({},np.uint8)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 79 dtype")
  assert(eq(r.shape,{0}),"searchsorted 79 shape")
  assert(eq(r.strides,{0}),"searchsorted 79 strides")
  assert(eq(r:tolist(),{}),"searchsorted 79 values")
end
do -- searcharray 80
  local a=np.array({6,27,35,56,64,85,93,114,122,143,151,159,172,180,188,201,209},np.uint8)
  local k=np.array({true,true,true},np.bool)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 80 dtype")
  assert(eq(r.shape,{3}),"searchsorted 80 shape")
  assert(eq(r.strides,{8}),"searchsorted 80 strides")
  assert(eq(r:tolist(),{1,1,1}),"searchsorted 80 values")
end
do -- searcharray 81
  local a=np.array({false,false,false,false,false,false,true,true,true,true,true,true},np.bool)
  local k=np.array({84},np.int16)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 81 dtype")
  assert(eq(r.shape,{1}),"searchsorted 81 shape")
  assert(eq(r.strides,{8}),"searchsorted 81 strides")
  assert(eq(r:tolist(),{13}),"searchsorted 81 values")
end
do -- searcharray 82
  local a=np.array({-93,-85,-64,-56,-35,-27,2,31,60,68,89,97},np.int32)
  local k=np.array({135,92,124,213},np.uint8)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 82 dtype")
  assert(eq(r.shape,{4}),"searchsorted 82 shape")
  assert(eq(r.strides,{8}),"searchsorted 82 strides")
  assert(eq(r:tolist(),{13,12,13,13}),"searchsorted 82 values")
end
do -- searcharray 83
  local a=np.array({false,false,false,false,true,true,true,true,true},np.bool)
  local k=np.array({{-114,94},{-61,-108}},np.int16)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 83 dtype")
  assert(eq(r.shape,{2,2}),"searchsorted 83 shape")
  assert(eq(r.strides,{16,8}),"searchsorted 83 strides")
  assert(eq(r:tolist(),{{1,10},{1,1}}),"searchsorted 83 values")
end
do -- searcharray 84
  local a=np.array({-100,-87,-79,-71,-50,-42,-21,-13,8,16,37,45,66,74,82,95,103},np.int16)
  local k=np.array({13.5,11.5,-13.25,-8.0,18.5,10.5,23.75,4.5,-26.0},np.float64)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 84 dtype")
  assert(eq(r.shape,{9}),"searchsorted 84 shape")
  assert(eq(r.strides,{8}),"searchsorted 84 strides")
  assert(eq(r:tolist(),{10,10,8,9,11,10,11,9,7}),"searchsorted 84 values")
end
do -- searcharray 85
  local a=np.array({12,41,70,99,194},np.uint32)
  local k=np.array({{true,false,false},{true,false,true}},np.bool)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 85 dtype")
  assert(eq(r.shape,{2,3}),"searchsorted 85 shape")
  assert(eq(r.strides,{24,8}),"searchsorted 85 strides")
  assert(eq(r:tolist(),{{1,1,1},{1,1,1}}),"searchsorted 85 values")
end
do -- searchscalar 86
  local a=np.array({96},np.int32)
  local r=np.searchsorted(a,-5.75,"left")
  assert(r==1,"searchsorted scalar 86 got "..tostring(r))
end
do -- searcharray 87
  local a=np.array({26,55,84,113,142,171,200,208},np.uint16)
  local k=np.array({75,-84,-39,1,61,-89,78},np.int16)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 87 dtype")
  assert(eq(r.shape,{7}),"searchsorted 87 shape")
  assert(eq(r.strides,{8}),"searchsorted 87 strides")
  assert(eq(r:tolist(),{3,1,1,1,3,1,3}),"searchsorted 87 values")
end
do -- searchscalar 88
  local a=np.array({-101,-88,-80,-72,-59,-51,-43,-22,-14,7,15,36,44,65,73,94,102},np.int8)
  local r=np.searchsorted(a,-48,"left")
  assert(r==7,"searchsorted scalar 88 got "..tostring(r))
end
do -- searcharray 89
  local a=np.array({-25.5,-23.5,-18.25,-16.25,-11.0,-9.0,-3.75,-1.75,3.5,5.5,10.75,12.75,18.0,20.0},np.float64)
  local k=np.array({{true},{false}},np.bool)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 89 dtype")
  assert(eq(r.shape,{2,1}),"searchsorted 89 shape")
  assert(eq(r.strides,{8,8}),"searchsorted 89 strides")
  assert(eq(r:tolist(),{{9},{9}}),"searchsorted 89 values")
end
do -- searcharray 90
  local a=np.array({10,18,39,47,68,76,97,105,134,163,192},np.uint16)
  local k=np.array({{9,102,98,-23,70,107},{41,-46,68,-24,-55,-71}},np.int64)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 90 dtype")
  assert(eq(r.shape,{2,6}),"searchsorted 90 shape")
  assert(eq(r.strides,{48,8}),"searchsorted 90 strides")
  assert(eq(r:tolist(),{{1,8,8,1,6,9},{4,1,6,1,1,1}}),"searchsorted 90 values")
end
do -- searcharray 91
  local a=np.array({25,54,83,112,141,170},np.uint32)
  local k=np.array({-80,-56,23,6,119,37,0,-57,80},np.int32)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 91 dtype")
  assert(eq(r.shape,{9}),"searchsorted 91 shape")
  assert(eq(r.strides,{8}),"searchsorted 91 strides")
  assert(eq(r:tolist(),{1,1,1,1,5,2,1,1,3}),"searchsorted 91 values")
end
do -- searchscalar 92
  local a=np.array({16,24,32,45,53,61,82,90,111,119,140,148,169,177,198,206},np.uint8)
  local r=np.searchsorted(a,45,"left")
  assert(r==4,"searchsorted scalar 92 got "..tostring(r))
end
do -- searcharray 93
  local a=np.array({-25.75,-16.5,-9.25,-2.0,5.25,12.5,19.75},np.float64)
  local k=np.array({{169,112,210,201,215},{87,199,49,39,54}},np.uint16)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 93 dtype")
  assert(eq(r.shape,{2,5}),"searchsorted 93 shape")
  assert(eq(r.strides,{40,8}),"searchsorted 93 strides")
  assert(eq(r:tolist(),{{8,8,8,8,8},{8,8,8,8,8}}),"searchsorted 93 values")
end
do -- searcharray 94
  local a=np.array({-96,-67,-59,-38,-30,-1,28,57,86},np.int8)
  local k=np.array({-119},np.int8)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 94 dtype")
  assert(eq(r.shape,{1}),"searchsorted 94 shape")
  assert(eq(r.strides,{8}),"searchsorted 94 strides")
  assert(eq(r:tolist(),{1}),"searchsorted 94 values")
end
do -- searcharray 95
  local a=np.array({-13.0,-5.75,1.5,8.75},np.float32)
  local k=np.array({99,50,4,117},np.int8)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 95 dtype")
  assert(eq(r.shape,{4}),"searchsorted 95 shape")
  assert(eq(r.strides,{8}),"searchsorted 95 strides")
  assert(eq(r:tolist(),{5,5,4,5}),"searchsorted 95 values")
end
do -- searchscalar 96
  local a=np.array({-45,-16,13,42,71,100},np.int32)
  local r=np.searchsorted(a,45,"right")
  assert(r==5,"searchsorted scalar 96 got "..tostring(r))
end
do -- searchscalar 97
  local a=np.array({-104,-75,-46,-38,-17,-9,12,20,49,78},np.int8)
  local r=np.searchsorted(a,13,"left")
  assert(r==8,"searchsorted scalar 97 got "..tostring(r))
end
do -- searchscalar 98
  local a=np.array({},np.int32)
  local r=np.searchsorted(a,-47,"left")
  assert(r==1,"searchsorted scalar 98 got "..tostring(r))
end
do -- searcharray 99
  local a=np.array({true},np.bool)
  local k=np.array({-19,118,90,70,85,108,82,57,-66,-37,85},np.int64)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 99 dtype")
  assert(eq(r.shape,{11}),"searchsorted 99 shape")
  assert(eq(r.strides,{8}),"searchsorted 99 strides")
  assert(eq(r:tolist(),{1,2,2,2,2,2,2,2,1,1,2}),"searchsorted 99 values")
end
do -- searcharray 100
  local a=np.array({-4.25,3.0,10.25,17.5,24.75},np.float32)
  local k=np.array({59},np.uint8)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 100 dtype")
  assert(eq(r.shape,{1}),"searchsorted 100 shape")
  assert(eq(r.strides,{8}),"searchsorted 100 strides")
  assert(eq(r:tolist(),{6}),"searchsorted 100 values")
end
do -- searchscalar 101
  local a=np.array({false,false,true,true},np.bool)
  local r=np.searchsorted(a,75,"right")
  assert(r==5,"searchsorted scalar 101 got "..tostring(r))
end
do -- searcharray 102
  local a=np.array({},np.bool)
  local k=np.array({18.5,0.0,-0.25,19.25,23.75,-8.75,-9.25,28.5,-2.25},np.float64)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 102 dtype")
  assert(eq(r.shape,{9}),"searchsorted 102 shape")
  assert(eq(r.strides,{8}),"searchsorted 102 strides")
  assert(eq(r:tolist(),{1,1,1,1,1,1,1,1,1}),"searchsorted 102 values")
end
do -- searcharray 103
  local a=np.array({6,14,35,43,72,101,109,130,138,159,167,188,196},np.uint16)
  local k=np.array({{25.0,15.0,-0.75,16.75,0.0},{9.5,19.5,-9.0,25.0,-8.5}},np.float64)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 103 dtype")
  assert(eq(r.shape,{2,5}),"searchsorted 103 shape")
  assert(eq(r.strides,{40,8}),"searchsorted 103 strides")
  assert(eq(r:tolist(),{{3,3,1,3,1},{2,3,1,3,1}}),"searchsorted 103 values")
end
do -- searcharray 104
  local a=np.array({116,145},np.uint32)
  local k=np.array({{-109,-96,-61,99,110},{-117,91,-7,117,-92}},np.int16)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 104 dtype")
  assert(eq(r.shape,{2,5}),"searchsorted 104 shape")
  assert(eq(r.strides,{40,8}),"searchsorted 104 strides")
  assert(eq(r:tolist(),{{1,1,1,1,1},{1,1,1,2,1}}),"searchsorted 104 values")
end
do -- searcharray 105
  local a=np.array({123},np.uint32)
  local k=np.array({111,2,203},np.uint8)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 105 dtype")
  assert(eq(r.shape,{3}),"searchsorted 105 shape")
  assert(eq(r.strides,{8}),"searchsorted 105 strides")
  assert(eq(r:tolist(),{1,1,2}),"searchsorted 105 values")
end
do -- searcharray 106
  local a=np.array({6,35,64,93,122,130,159,188},np.uint8)
  local k=np.array({true,true,false,false,false,true,false,true,true,true,false},np.bool)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 106 dtype")
  assert(eq(r.shape,{11}),"searchsorted 106 shape")
  assert(eq(r.strides,{8}),"searchsorted 106 strides")
  assert(eq(r:tolist(),{1,1,1,1,1,1,1,1,1,1,1}),"searchsorted 106 values")
end
do -- searcharray 107
  local a=np.array({13,42,71,100,129,137,158,166,187,195},np.uint32)
  local k=np.array({2,59,59},np.uint16)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 107 dtype")
  assert(eq(r.shape,{3}),"searchsorted 107 shape")
  assert(eq(r.strides,{8}),"searchsorted 107 strides")
  assert(eq(r:tolist(),{1,3,3}),"searchsorted 107 values")
end
do -- searcharray 108
  local a=np.array({144,173},np.uint8)
  local k=np.array({{99,194,17},{145,129,26}},np.uint16)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 108 dtype")
  assert(eq(r.shape,{2,3}),"searchsorted 108 shape")
  assert(eq(r.strides,{24,8}),"searchsorted 108 strides")
  assert(eq(r:tolist(),{{1,3,1},{2,1,1}}),"searchsorted 108 values")
end
do -- searcharray 109
  local a=np.array({46,75},np.int32)
  local k=np.array({22,129,34,119,173,139,158,53,88,199,203},np.uint8)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 109 dtype")
  assert(eq(r.shape,{11}),"searchsorted 109 shape")
  assert(eq(r.strides,{8}),"searchsorted 109 strides")
  assert(eq(r:tolist(),{1,3,1,3,3,3,3,2,3,3,3}),"searchsorted 109 values")
end
do -- searchscalar 110
  local a=np.array({-100,-71,53,82},np.int16)
  local r=np.searchsorted(a,133,"left")
  assert(r==5,"searchsorted scalar 110 got "..tostring(r))
end
do -- searchscalar 111
  local a=np.array({-25.25,-23.25,-18.0,-16.0,-10.75,-8.75,-3.5,-1.5,5.75,13.0,15.0,20.25,0/0},np.float64)
  local r=np.searchsorted(a,57,"right")
  assert(r==13,"searchsorted scalar 111 got "..tostring(r))
end
do -- searcharray 112
  local a=np.array({-23.5,-21.5,-16.25,-14.25,-9.0,-7.0,-1.75,0.25,5.5,7.5,12.75,14.75,16.75,22.0,0/0},np.float32)
  local k=np.array({{-15.5,28.25,-26.25,16.75},{-11.25,-14.5,-9.0,-28.0}},np.float64)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 112 dtype")
  assert(eq(r.shape,{2,4}),"searchsorted 112 shape")
  assert(eq(r.strides,{32,8}),"searchsorted 112 strides")
  assert(eq(r:tolist(),{{4,15,1,14},{5,4,6,1}}),"searchsorted 112 values")
end
do -- searchscalar 113
  local a=np.array({false,false,false,false,false,true,true,true,true,true,true},np.bool)
  local r=np.searchsorted(a,50,"right")
  assert(r==12,"searchsorted scalar 113 got "..tostring(r))
end
do -- searcharray 114
  local a=np.array({-25.25,-20.0,-18.0,-12.75,-10.75,-5.5,-3.5,1.75,3.75,9.0,11.0,16.25,18.25,20.25,25.5},np.float64)
  local k=np.array({19.25,0/0},np.float64)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 114 dtype")
  assert(eq(r.shape,{2}),"searchsorted 114 shape")
  assert(eq(r.strides,{8}),"searchsorted 114 strides")
  assert(eq(r:tolist(),{14,16}),"searchsorted 114 values")
end
do -- searchscalar 115
  local a=np.array({-94,-65,-36,-7,22,51,88},np.int64)
  local r=np.searchsorted(a,-26,"left")
  assert(r==4,"searchsorted scalar 115 got "..tostring(r))
end
do -- searchscalar 116
  local a=np.array({-87,-58,-29,0,29,95},np.int32)
  local r=np.searchsorted(a,7.5,"left")
  assert(r==5,"searchsorted scalar 116 got "..tostring(r))
end
do -- searcharray 117
  local a=np.array({25,54,83,112,207},np.uint32)
  local k=np.array({{-8.0,-4.5,-16.0,-11.25,27.5,-23.5},{-26.0,20.75,-7.5,6.5,-1.25,-21.75}},np.float64)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 117 dtype")
  assert(eq(r.shape,{2,6}),"searchsorted 117 shape")
  assert(eq(r.strides,{48,8}),"searchsorted 117 strides")
  assert(eq(r:tolist(),{{1,1,1,1,2,1},{1,1,1,1,1,1}}),"searchsorted 117 values")
end
do -- searchscalar 118
  local a=np.array({-102},np.int64)
  local r=np.searchsorted(a,103,"left")
  assert(r==2,"searchsorted scalar 118 got "..tostring(r))
end
do -- searcharray 119
  local a=np.array({-103,-95,-82,-74,-66,-53,-45,-37,-16,-8,13,21,42,50,71,79,100},np.int16)
  local k=np.array({25.25,28.0,20.75,-29.5,-9.25},np.float64)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 119 dtype")
  assert(eq(r.shape,{5}),"searchsorted 119 shape")
  assert(eq(r.strides,{8}),"searchsorted 119 strides")
  assert(eq(r:tolist(),{13,13,12,9,10}),"searchsorted 119 values")
end
do -- searcharray 120
  local a=np.array({false,false,false,false,false,false,true,true,true,true,true,true},np.bool)
  local k=np.array({19.0,14.25,12.0,15.5,-25.5,-17.0,-19.0},np.float64)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 120 dtype")
  assert(eq(r.shape,{7}),"searchsorted 120 shape")
  assert(eq(r.strides,{8}),"searchsorted 120 strides")
  assert(eq(r:tolist(),{13,13,13,13,1,1,1}),"searchsorted 120 values")
end
do -- searcharray 121
  local a=np.array({24,53},np.uint32)
  local k=np.array({-28.75,-2.5,-14.75,15.5,12.25,6.5,0/0},np.float64)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 121 dtype")
  assert(eq(r.shape,{7}),"searchsorted 121 shape")
  assert(eq(r.strides,{8}),"searchsorted 121 strides")
  assert(eq(r:tolist(),{1,1,1,1,1,1,3}),"searchsorted 121 values")
end
do -- searchscalar 122
  local a=np.array({-18.5,-11.25,-4.0,3.25,10.5,17.75},np.float64)
  local r=np.searchsorted(a,17.25,"right")
  assert(r==6,"searchsorted scalar 122 got "..tostring(r))
end
do -- searcharray 123
  local a=np.array({1,22,30,38,51,59,67,88,96,117,125,146,154,175,183,204},np.uint32)
  local k=np.array({-108},np.int16)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 123 dtype")
  assert(eq(r.shape,{1}),"searchsorted 123 shape")
  assert(eq(r.strides,{8}),"searchsorted 123 strides")
  assert(eq(r:tolist(),{1}),"searchsorted 123 values")
end
do -- searcharray 124
  local a=np.array({8,37,45,66,74,95,103,124,132,153,161,190},np.uint8)
  local k=np.array({-87,88},np.int16)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 124 dtype")
  assert(eq(r.shape,{2}),"searchsorted 124 shape")
  assert(eq(r.strides,{8}),"searchsorted 124 strides")
  assert(eq(r:tolist(),{1,6}),"searchsorted 124 values")
end
do -- searcharray 125
  local a=np.array({false,true,true},np.bool)
  local k=np.array({{-4.0,-24.75,4.5},{1.25,1.0,-1.5}},np.float64)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 125 dtype")
  assert(eq(r.shape,{2,3}),"searchsorted 125 shape")
  assert(eq(r.strides,{24,8}),"searchsorted 125 strides")
  assert(eq(r:tolist(),{{1,1,4},{4,2,1}}),"searchsorted 125 values")
end
do -- searchscalar 126
  local a=np.array({false,true},np.bool)
  local r=np.searchsorted(a,77,"left")
  assert(r==3,"searchsorted scalar 126 got "..tostring(r))
end
do -- searcharray 127
  local a=np.array({66,95,124,153},np.uint32)
  local k=np.array({85,11,135,138,43},np.uint32)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 127 dtype")
  assert(eq(r.shape,{5}),"searchsorted 127 shape")
  assert(eq(r.strides,{8}),"searchsorted 127 strides")
  assert(eq(r:tolist(),{2,1,4,4,1}),"searchsorted 127 values")
end
do -- searcharray 128
  local a=np.array({7,36,65,73,94,102,123,131,152,160,181,189},np.uint16)
  local k=np.array({{218,214,29},{157,63,140}},np.uint32)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 128 dtype")
  assert(eq(r.shape,{2,3}),"searchsorted 128 shape")
  assert(eq(r.strides,{24,8}),"searchsorted 128 strides")
  assert(eq(r:tolist(),{{13,13,2},{10,3,9}}),"searchsorted 128 values")
end
do -- searcharray 129
  local a=np.array({-22.75,-15.5,-8.25,-6.25,1.0,8.25,15.5,22.75},np.float32)
  local k=np.array({95,180,200,2,44,180,79,162,219,149,96},np.uint8)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 129 dtype")
  assert(eq(r.shape,{11}),"searchsorted 129 shape")
  assert(eq(r.strides,{8}),"searchsorted 129 strides")
  assert(eq(r:tolist(),{9,9,9,6,9,9,9,9,9,9,9}),"searchsorted 129 values")
end
do -- searcharray 130
  local a=np.array({-21.0,-13.75,-6.5,-4.5,0.75,2.75,10.0,17.25,24.5},np.float32)
  local k=np.array({{22.25,1.25},{-15.75,0/0}},np.float64)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 130 dtype")
  assert(eq(r.shape,{2,2}),"searchsorted 130 shape")
  assert(eq(r.strides,{16,8}),"searchsorted 130 strides")
  assert(eq(r:tolist(),{{9,6},{2,10}}),"searchsorted 130 values")
end
do -- searcharray 131
  local a=np.array({-85,-77,-56,-48,-27,-19,-11,2,10,18,31,39,47,68,76,97,105},np.int32)
  local k=np.array({true,true,false,true,false,true,false,true,true,false,false},np.bool)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 131 dtype")
  assert(eq(r.shape,{11}),"searchsorted 131 shape")
  assert(eq(r.strides,{8}),"searchsorted 131 strides")
  assert(eq(r:tolist(),{8,8,8,8,8,8,8,8,8,8,8}),"searchsorted 131 values")
end
do -- searcharray 132
  local a=np.array({false,false,false,false,false,false,false,false,true,true,true,true,true,true,true,true,true},np.bool)
  local k=np.array({false},np.bool)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 132 dtype")
  assert(eq(r.shape,{1}),"searchsorted 132 shape")
  assert(eq(r.strides,{8}),"searchsorted 132 strides")
  assert(eq(r:tolist(),{9}),"searchsorted 132 values")
end
do -- searchscalar 133
  local a=np.array({-92,-63,-34,-5,3,24,32,53,61,82,90},np.int8)
  local r=np.searchsorted(a,35,"right")
  assert(r==8,"searchsorted scalar 133 got "..tostring(r))
end
do -- searcharray 134
  local a=np.array({-21.25,-14.0,-6.75,0.5,2.5,9.75,17.0,0/0},np.float64)
  local k=np.array({93},np.int32)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 134 dtype")
  assert(eq(r.shape,{1}),"searchsorted 134 shape")
  assert(eq(r.strides,{8}),"searchsorted 134 strides")
  assert(eq(r:tolist(),{8}),"searchsorted 134 values")
end
do -- searcharray 135
  local a=np.array({19,27,48,56,77,85,106,114,122,135,143,151,164,172,180,201,209},np.uint32)
  local k=np.array({164,125,42,96},np.uint32)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 135 dtype")
  assert(eq(r.shape,{4}),"searchsorted 135 shape")
  assert(eq(r.strides,{8}),"searchsorted 135 strides")
  assert(eq(r:tolist(),{14,10,3,7}),"searchsorted 135 values")
end
do -- searcharray 136
  local a=np.array({-100,-79,-71,-50,-42,-13,16,24,45,53,74,82,103},np.int32)
  local k=np.array({true,false,true},np.bool)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 136 dtype")
  assert(eq(r.shape,{3}),"searchsorted 136 shape")
  assert(eq(r.strides,{8}),"searchsorted 136 strides")
  assert(eq(r:tolist(),{7,7,7}),"searchsorted 136 values")
end
do -- searcharray 137
  local a=np.array({-101,-93,-64,-35,-6,23,31,52,60,81,89},np.int16)
  local k=np.array({-63,-39,39,25,-118,106},np.int32)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 137 dtype")
  assert(eq(r.shape,{6}),"searchsorted 137 shape")
  assert(eq(r.strides,{8}),"searchsorted 137 strides")
  assert(eq(r:tolist(),{4,4,8,7,1,12}),"searchsorted 137 values")
end
do -- searchscalar 138
  local a=np.array({-21.5,-14.25,-7.0,9.5,16.75,24.0},np.float64)
  local r=np.searchsorted(a,-120,"left")
  assert(r==1,"searchsorted scalar 138 got "..tostring(r))
end
do -- searchscalar 139
  local a=np.array({-95,-87,-79,-58,-50,-29,-21,0,8,29,37,45,58,66,74,87,95,103},np.int16)
  local r=np.searchsorted(a,-51,"right")
  assert(r==5,"searchsorted scalar 139 got "..tostring(r))
end
do -- searcharray 140
  local a=np.array({-101,-72,-43,-14,15,44,52,73,81,102},np.int16)
  local k=np.array({-8.25,5.0,17.0,1.25,28.75,17.5,24.75,-10.25,-28.25,3.5,27.75,-11.75},np.float32)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 140 dtype")
  assert(eq(r.shape,{12}),"searchsorted 140 shape")
  assert(eq(r.strides,{8}),"searchsorted 140 strides")
  assert(eq(r:tolist(),{5,5,6,5,6,6,6,5,4,5,6,5}),"searchsorted 140 values")
end
do -- searcharray 141
  local a=np.array({-25.5,-23.5,-16.25,-9.0,-1.75,5.5,12.75,14.75,20.0,22.0},np.float64)
  local k=np.array({50,148,95,32},np.uint16)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 141 dtype")
  assert(eq(r.shape,{4}),"searchsorted 141 shape")
  assert(eq(r.strides,{8}),"searchsorted 141 strides")
  assert(eq(r:tolist(),{11,11,11,11}),"searchsorted 141 values")
end
do -- searcharray 142
  local a=np.array({171},np.uint32)
  local k=np.array({27.75,2.25,11.5,4.0,3.75,14.5,-19.5,-11.0,22.5,-15.5,-27.0},np.float64)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 142 dtype")
  assert(eq(r.shape,{11}),"searchsorted 142 shape")
  assert(eq(r.strides,{8}),"searchsorted 142 strides")
  assert(eq(r:tolist(),{1,1,1,1,1,1,1,1,1,1,1}),"searchsorted 142 values")
end
do -- searchscalar 143
  local a=np.array({17,25,46,54,75,83,104,112,141,170,178,199,207},np.uint8)
  local r=np.searchsorted(a,0,"left")
  assert(r==1,"searchsorted scalar 143 got "..tostring(r))
end
do -- searcharray 144
  local a=np.array({3,32,61,90,185},np.uint8)
  local k=np.array({14,-57,104,93,12,57,-72,32,-111,-30,-6,83},np.int32)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 144 dtype")
  assert(eq(r.shape,{12}),"searchsorted 144 shape")
  assert(eq(r.strides,{8}),"searchsorted 144 strides")
  assert(eq(r:tolist(),{2,1,5,5,2,3,1,3,1,1,1,4}),"searchsorted 144 values")
end
do -- searcharray 145
  local a=np.array({-95,-66,-37,87},np.int16)
  local k=np.array({-12},np.int32)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 145 dtype")
  assert(eq(r.shape,{1}),"searchsorted 145 shape")
  assert(eq(r.strides,{8}),"searchsorted 145 strides")
  assert(eq(r:tolist(),{4}),"searchsorted 145 values")
end
do -- searcharray 146
  local a=np.array({-88,-59,-30,-1,94},np.int32)
  local k=np.array({82,117,-29,-5,5,44,-104},np.int16)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 146 dtype")
  assert(eq(r.shape,{7}),"searchsorted 146 shape")
  assert(eq(r.strides,{8}),"searchsorted 146 strides")
  assert(eq(r:tolist(),{5,6,4,4,5,5,1}),"searchsorted 146 values")
end
do -- searchscalar 147
  local a=np.array({-89,-81,-60,-52,-31,-23,-2,6,35,64,93,101},np.int16)
  local r=np.searchsorted(a,124,"right")
  assert(r==13,"searchsorted scalar 147 got "..tostring(r))
end
do -- searcharray 148
  local a=np.array({-103,-82,-74,-53,-45,-24,-16,5,13,34,42,71,100},np.int32)
  local k=np.array({48,164,151},np.uint32)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 148 dtype")
  assert(eq(r.shape,{3}),"searchsorted 148 shape")
  assert(eq(r.strides,{8}),"searchsorted 148 strides")
  assert(eq(r:tolist(),{12,14,14}),"searchsorted 148 values")
end
do -- searcharray 149
  local a=np.array({9,38,67,96,125,154,183},np.uint32)
  local k=np.array({{20,-112,104},{-51,19,93}},np.int64)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 149 dtype")
  assert(eq(r.shape,{2,3}),"searchsorted 149 shape")
  assert(eq(r.strides,{24,8}),"searchsorted 149 strides")
  assert(eq(r:tolist(),{{2,1,5},{1,2,4}}),"searchsorted 149 values")
end
do -- searcharray 150
  local a=np.array({0,8,16,37,45,66,74,95,103,124,132,153,161,182,190},np.uint8)
  local k=np.array({true,false,false,true,false,true},np.bool)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 150 dtype")
  assert(eq(r.shape,{6}),"searchsorted 150 shape")
  assert(eq(r.strides,{8}),"searchsorted 150 strides")
  assert(eq(r:tolist(),{2,1,1,2,1,2}),"searchsorted 150 values")
end
do -- searchscalar 151
  local a=np.array({-20.5,-13.25,-6.0,1.25,8.5,15.75},np.float64)
  local r=np.searchsorted(a,168,"right")
  assert(r==7,"searchsorted scalar 151 got "..tostring(r))
end
do -- searcharray 152
  local a=np.array({-18.75,-11.5,-4.25,3.0,10.25,17.5},np.float64)
  local k=np.array({-36,-78,63,-95,109,-90,37,67,-90,62,82,107},np.int8)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 152 dtype")
  assert(eq(r.shape,{12}),"searchsorted 152 shape")
  assert(eq(r.strides,{8}),"searchsorted 152 strides")
  assert(eq(r:tolist(),{1,1,7,1,7,1,7,7,1,7,7,7}),"searchsorted 152 values")
end
do -- searcharray 153
  local a=np.array({-68,-39,-10,19,48},np.int16)
  local k=np.array({-94,-78,4,34,89,106,89,-63},np.int16)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 153 dtype")
  assert(eq(r.shape,{8}),"searchsorted 153 shape")
  assert(eq(r.strides,{8}),"searchsorted 153 strides")
  assert(eq(r:tolist(),{1,1,4,5,6,6,6,2}),"searchsorted 153 values")
end
do -- searcharray 154
  local a=np.array({-98,-69,-61,-40,-32,-11,-3,18,26,47,55,84},np.int8)
  local k=np.array({-10,118,-71,-55,-7,-39,62,70,-21,-64},np.int8)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 154 dtype")
  assert(eq(r.shape,{10}),"searchsorted 154 shape")
  assert(eq(r.strides,{8}),"searchsorted 154 strides")
  assert(eq(r:tolist(),{7,13,2,4,7,5,12,12,6,3}),"searchsorted 154 values")
end
do -- searchscalar 155
  local a=np.array({-22.75,-15.5,-13.5,-8.25,-6.25,-1.0,1.0,6.25,8.25,13.5,15.5,22.75},np.float64)
  local r=np.searchsorted(a,-17.25,"right")
  assert(r==2,"searchsorted scalar 155 got "..tostring(r))
end
do -- searchscalar 156
  local a=np.array({-84,-55,-47,-26,-18,3,11,32,40,69,98},np.int8)
  local r=np.searchsorted(a,-94,"right")
  assert(r==1,"searchsorted scalar 156 got "..tostring(r))
end
do -- searcharray 157
  local a=np.array({false,false,false,false,true,true,true,true},np.bool)
  local k=np.array({22,-25,-58,25,57,40,57},np.int16)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 157 dtype")
  assert(eq(r.shape,{7}),"searchsorted 157 shape")
  assert(eq(r.strides,{8}),"searchsorted 157 strides")
  assert(eq(r:tolist(),{9,1,1,9,9,9,9}),"searchsorted 157 values")
end
do -- searcharray 158
  local a=np.array({false,false,false,true,true,true},np.bool)
  local k=np.array({-3.5,-11.0,-7.0},np.float32)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 158 dtype")
  assert(eq(r.shape,{3}),"searchsorted 158 shape")
  assert(eq(r.strides,{8}),"searchsorted 158 strides")
  assert(eq(r:tolist(),{1,1,1}),"searchsorted 158 values")
end
do -- searchscalar 159
  local a=np.array({5,13,34,42,63,71,79,92,100,108,121,129,137,150,158,166,187,195},np.uint16)
  local r=np.searchsorted(a,-20.75,"right")
  assert(r==1,"searchsorted scalar 159 got "..tostring(r))
end
do -- searcharray 160
  local a=np.array({-21.25,-14.0,-6.75,-4.75,2.5,9.75,17.0,24.25},np.float64)
  local k=np.array({},np.int8)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 160 dtype")
  assert(eq(r.shape,{0}),"searchsorted 160 shape")
  assert(eq(r.strides,{0}),"searchsorted 160 strides")
  assert(eq(r:tolist(),{}),"searchsorted 160 values")
end
do -- searchscalar 161
  local a=np.array({93,122,151},np.uint32)
  local r=np.searchsorted(a,-16.5,"left")
  assert(r==1,"searchsorted scalar 161 got "..tostring(r))
end
do -- searcharray 162
  local a=np.array({5,34,63,92,100,121,129,150,158,187},np.uint32)
  local k=np.array({{157,35},{3,47}},np.uint16)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 162 dtype")
  assert(eq(r.shape,{2,2}),"searchsorted 162 shape")
  assert(eq(r.strides,{16,8}),"searchsorted 162 strides")
  assert(eq(r:tolist(),{{9,3},{1,3}}),"searchsorted 162 values")
end
do -- searcharray 163
  local a=np.array({},np.int16)
  local k=np.array({63,78,87},np.int16)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 163 dtype")
  assert(eq(r.shape,{3}),"searchsorted 163 shape")
  assert(eq(r.strides,{8}),"searchsorted 163 strides")
  assert(eq(r:tolist(),{1,1,1}),"searchsorted 163 values")
end
do -- searchscalar 164
  local a=np.array({-21.5,-14.25,-7.0,0.25,2.25,7.5,9.5,14.75,16.75,24.0},np.float64)
  local r=np.searchsorted(a,-58,"left")
  assert(r==1,"searchsorted scalar 164 got "..tostring(r))
end
do -- searchscalar 165
  local a=np.array({},np.uint16)
  local r=np.searchsorted(a,176,"right")
  assert(r==1,"searchsorted scalar 165 got "..tostring(r))
end
do -- searcharray 166
  local a=np.array({4,25,33,54,62,83,91,112,120,128,141,149,157,178,186,207},np.uint8)
  local k=np.array({42,24,123,107,214,184},np.uint8)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 166 dtype")
  assert(eq(r.shape,{6}),"searchsorted 166 shape")
  assert(eq(r.strides,{8}),"searchsorted 166 strides")
  assert(eq(r:tolist(),{4,2,10,8,17,15}),"searchsorted 166 values")
end
do -- searchscalar 167
  local a=np.array({-102,-94,-73,-65,-44,-36,-15,-7,14,22,30,43,51,59,80,88},np.int32)
  local r=np.searchsorted(a,-103,"left")
  assert(r==1,"searchsorted scalar 167 got "..tostring(r))
end
do -- searchscalar 168
  local a=np.array({-23.75,-21.75,-14.5,-7.25,0.0,7.25,9.25,14.5,16.5,21.75,23.75},np.float64)
  local r=np.searchsorted(a,-28.25,"left")
  assert(r==1,"searchsorted scalar 168 got "..tostring(r))
end
do -- searcharray 169
  local a=np.array({-80,-51,-22,7,36,44,65,73,94,102},np.int16)
  local k=np.array({53,-104,-63,-91,-73,37,91,-95,100},np.int16)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 169 dtype")
  assert(eq(r.shape,{9}),"searchsorted 169 shape")
  assert(eq(r.strides,{8}),"searchsorted 169 strides")
  assert(eq(r:tolist(),{7,1,2,1,2,6,9,1,10}),"searchsorted 169 values")
end
do -- searcharray 170
  local a=np.array({51},np.int8)
  local k=np.array({72},np.uint32)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 170 dtype")
  assert(eq(r.shape,{1}),"searchsorted 170 shape")
  assert(eq(r.strides,{8}),"searchsorted 170 strides")
  assert(eq(r:tolist(),{2}),"searchsorted 170 values")
end
do -- searcharray 171
  local a=np.array({-95,-66,-37,58,87},np.int8)
  local k=np.array({{-9.5,26.0,-7.5,-3.75,20.25,9.0},{-8.0,12.5,23.0,25.25,29.25,-3.75}},np.float32)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 171 dtype")
  assert(eq(r.shape,{2,6}),"searchsorted 171 shape")
  assert(eq(r.strides,{48,8}),"searchsorted 171 strides")
  assert(eq(r:tolist(),{{4,4,4,4,4,4},{4,4,4,4,4,4}}),"searchsorted 171 values")
end
do -- searcharray 172
  local a=np.array({-88,-59,-30,-1,28,65,94},np.int32)
  local k=np.array({{-6,113,-87,-35,15},{-24,-99,-82,-93,-45}},np.int16)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 172 dtype")
  assert(eq(r.shape,{2,5}),"searchsorted 172 shape")
  assert(eq(r.strides,{40,8}),"searchsorted 172 strides")
  assert(eq(r:tolist(),{{4,8,2,3,5},{4,1,2,1,3}}),"searchsorted 172 values")
end
do -- searcharray 173
  local a=np.array({false,false,false,false,false,false,false,false,false,true,true,true,true,true,true,true,true,true},np.bool)
  local k=np.array({},np.int64)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 173 dtype")
  assert(eq(r.shape,{0}),"searchsorted 173 shape")
  assert(eq(r.strides,{0}),"searchsorted 173 strides")
  assert(eq(r:tolist(),{}),"searchsorted 173 values")
end
do -- searchscalar 174
  local a=np.array({2,23,31,52,60,81,89,110,118,139,147,176,184,205},np.uint16)
  local r=np.searchsorted(a,95,"left")
  assert(r==8,"searchsorted scalar 174 got "..tostring(r))
end
do -- searchscalar 175
  local a=np.array({false,true,true},np.bool)
  local r=np.searchsorted(a,-15,"right")
  assert(r==1,"searchsorted scalar 175 got "..tostring(r))
end
do -- searcharray 176
  local a=np.array({16,45,198},np.uint16)
  local k=np.array({106,181,161,123,84,116,167,36},np.uint16)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 176 dtype")
  assert(eq(r.shape,{8}),"searchsorted 176 shape")
  assert(eq(r.strides,{8}),"searchsorted 176 strides")
  assert(eq(r:tolist(),{3,3,3,3,3,3,3,2}),"searchsorted 176 values")
end
do -- searchscalar 177
  local a=np.array({-82,-53,100},np.int16)
  local r=np.searchsorted(a,214,"left")
  assert(r==4,"searchsorted scalar 177 got "..tostring(r))
end
do -- searcharray 178
  local a=np.array({1,22,30,51,59,80,88,109,117,138,146,167,175,204},np.uint32)
  local k=np.array({-2},np.int8)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 178 dtype")
  assert(eq(r.shape,{1}),"searchsorted 178 shape")
  assert(eq(r.strides,{8}),"searchsorted 178 strides")
  assert(eq(r:tolist(),{1}),"searchsorted 178 values")
end
do -- searchscalar 179
  local a=np.array({-24.25,-17.0,-9.75,-2.5,4.75,12.0,19.25},np.float32)
  local r=np.searchsorted(a,10.25,"right")
  assert(r==6,"searchsorted scalar 179 got "..tostring(r))
end
do -- searchscalar 180
  local a=np.array({-98,-90,-69,-61,-40,-32,-11,-3,18,26,55,84},np.int32)
  local r=np.searchsorted(a,-35,"right")
  assert(r==6,"searchsorted scalar 180 got "..tostring(r))
end
do -- searcharray 181
  local a=np.array({22},np.uint8)
  local k=np.array({83,-48,-26,25,-88,-21,30,52,-94,13,57},np.int8)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 181 dtype")
  assert(eq(r.shape,{11}),"searchsorted 181 shape")
  assert(eq(r.strides,{8}),"searchsorted 181 strides")
  assert(eq(r:tolist(),{2,1,1,2,1,1,2,2,1,1,2}),"searchsorted 181 values")
end
do -- searcharray 182
  local a=np.array({-76},np.int8)
  local k=np.array({51,85,30,71,71},np.uint32)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 182 dtype")
  assert(eq(r.shape,{5}),"searchsorted 182 shape")
  assert(eq(r.strides,{8}),"searchsorted 182 strides")
  assert(eq(r:tolist(),{2,2,2,2,2}),"searchsorted 182 values")
end
do -- searcharray 183
  local a=np.array({28,36,57,65,86,94,123,152,181,210},np.uint8)
  local k=np.array({29,75,117,-82,-45},np.int64)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 183 dtype")
  assert(eq(r.shape,{5}),"searchsorted 183 shape")
  assert(eq(r.strides,{8}),"searchsorted 183 strides")
  assert(eq(r:tolist(),{2,5,7,1,1}),"searchsorted 183 values")
end
do -- searcharray 184
  local a=np.array({43,72,101,130,159,188},np.uint16)
  local k=np.array({},np.bool)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 184 dtype")
  assert(eq(r.shape,{0}),"searchsorted 184 shape")
  assert(eq(r.strides,{0}),"searchsorted 184 strides")
  assert(eq(r:tolist(),{}),"searchsorted 184 values")
end
do -- searcharray 185
  local a=np.array({5,13,34,42,50,71,79,100,108,129,137,158,166,187,195},np.uint32)
  local k=np.array({71,-26,-103,-49,-73},np.int16)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 185 dtype")
  assert(eq(r.shape,{5}),"searchsorted 185 shape")
  assert(eq(r.strides,{8}),"searchsorted 185 strides")
  assert(eq(r:tolist(),{6,1,1,1,1}),"searchsorted 185 values")
end
do -- searcharray 186
  local a=np.array({-21.25,-14.0,-12.0,-6.75,-4.75,0.5,2.5,9.75,17.0,0/0},np.float32)
  local k=np.array({76,132},np.uint8)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 186 dtype")
  assert(eq(r.shape,{2}),"searchsorted 186 shape")
  assert(eq(r.strides,{8}),"searchsorted 186 strides")
  assert(eq(r:tolist(),{10,10}),"searchsorted 186 values")
end
do -- searcharray 187
  local a=np.array({-86,-78,-57,-49,-41,-28,-20,-12,1,9,17,38,46,67,75,96,104},np.int16)
  local k=np.array({{-72,113},{-44,-51}},np.int16)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 187 dtype")
  assert(eq(r.shape,{2,2}),"searchsorted 187 shape")
  assert(eq(r.strides,{16,8}),"searchsorted 187 strides")
  assert(eq(r:tolist(),{{3,18},{5,4}}),"searchsorted 187 values")
end
do -- searchscalar 188
  local a=np.array({false,false,false,false,false,true,true,true,true,true,true},np.bool)
  local r=np.searchsorted(a,3,"right")
  assert(r==12,"searchsorted scalar 188 got "..tostring(r))
end
do -- searcharray 189
  local a=np.array({-93,-64,-35,-27,2,31,60,89},np.int32)
  local k=np.array({},np.float64)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 189 dtype")
  assert(eq(r.shape,{0}),"searchsorted 189 shape")
  assert(eq(r.strides,{0}),"searchsorted 189 strides")
  assert(eq(r:tolist(),{}),"searchsorted 189 values")
end
do -- searcharray 190
  local a=np.array({false,false,false,true,true,true,true},np.bool)
  local k=np.array({28.75,-3.25,-8.0,23.0,-27.5,14.25,6.75},np.float32)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 190 dtype")
  assert(eq(r.shape,{7}),"searchsorted 190 shape")
  assert(eq(r.strides,{8}),"searchsorted 190 strides")
  assert(eq(r:tolist(),{8,1,1,8,1,8,8}),"searchsorted 190 values")
end
do -- searcharray 191
  local a=np.array({},np.uint8)
  local k=np.array({{68,80,-59},{59,-12,1}},np.int32)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 191 dtype")
  assert(eq(r.shape,{2,3}),"searchsorted 191 shape")
  assert(eq(r.strides,{24,8}),"searchsorted 191 strides")
  assert(eq(r:tolist(),{{1,1,1},{1,1,1}}),"searchsorted 191 values")
end
do -- searcharray 192
  local a=np.array({4,25,33,62,91,99,120,128,149,157,178,186,207},np.uint8)
  local k=np.array({{-88,51,-14,47,-47},{-17,-98,114,109,-31}},np.int32)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 192 dtype")
  assert(eq(r.shape,{2,5}),"searchsorted 192 shape")
  assert(eq(r.strides,{40,8}),"searchsorted 192 strides")
  assert(eq(r:tolist(),{{1,4,1,4,1},{1,1,7,7,1}}),"searchsorted 192 values")
end
do -- searchscalar 193
  local a=np.array({-25.5,-23.5,-18.25,-16.25,-11.0,-9.0,-1.75,0.25,5.5,7.5,12.75,14.75,20.0,0/0},np.float32)
  local r=np.searchsorted(a,-11.75,"left")
  assert(r==5,"searchsorted scalar 193 got "..tostring(r))
end
do -- searcharray 194
  local a=np.array({-95,-87,-66,-58,-37,-29,-8,0,8,21,29,37,50,58,66,79,87,95},np.int8)
  local k=np.array({28.0,-11.5,8.5,0.25,-10.5},np.float64)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 194 dtype")
  assert(eq(r.shape,{5}),"searchsorted 194 shape")
  assert(eq(r.strides,{8}),"searchsorted 194 strides")
  assert(eq(r:tolist(),{11,7,10,9,7}),"searchsorted 194 values")
end
do -- searcharray 195
  local a=np.array({3.75,11.0,18.25,25.5},np.float32)
  local k=np.array({21.0,-20.0,11.0,-6.25,8.0,-4.0,15.0,2.0,14.5,-25.0},np.float64)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 195 dtype")
  assert(eq(r.shape,{10}),"searchsorted 195 shape")
  assert(eq(r.strides,{8}),"searchsorted 195 strides")
  assert(eq(r:tolist(),{4,1,3,1,2,1,3,1,3,1}),"searchsorted 195 values")
end
do -- searchscalar 196
  local a=np.array({-102,-81,-73,-52,-44,-23,-15,6,14,22,35,43,51,72,80,101},np.int16)
  local r=np.searchsorted(a,-6.75,"right")
  assert(r==8,"searchsorted scalar 196 got "..tostring(r))
end
do -- searcharray 197
  local a=np.array({2,10,31,39,68,97,126,134,155,163,184,192},np.uint8)
  local k=np.array({125,5,88,89,174,122,200,9},np.uint8)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 197 dtype")
  assert(eq(r.shape,{8}),"searchsorted 197 shape")
  assert(eq(r.strides,{8}),"searchsorted 197 strides")
  assert(eq(r:tolist(),{7,2,6,6,11,7,13,2}),"searchsorted 197 values")
end
do -- searchscalar 198
  local a=np.array({17,46,75,104,133,141,162,170,191,199},np.uint8)
  local r=np.searchsorted(a,true,"left")
  assert(r==1,"searchsorted scalar 198 got "..tostring(r))
end
do -- searcharray 199
  local a=np.array({-97,-89,-81,-60,-52,-31,-23,-2,6,27,35,43,56,64,72,85,93,101},np.int64)
  local k=np.array({-3.0,18.5,-17.5,26.0,4.75,-26.0,15.0,9.5,27.5,2.0,5.75},np.float64)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 199 dtype")
  assert(eq(r.shape,{11}),"searchsorted 199 shape")
  assert(eq(r.strides,{8}),"searchsorted 199 strides")
  assert(eq(r:tolist(),{8,10,8,10,9,7,10,10,11,9,9}),"searchsorted 199 values")
end
do -- searchscalar 200
  local a=np.array({-103,-74,-45,-16,13,42,50,71,79,100},np.int32)
  local r=np.searchsorted(a,3,"right")
  assert(r==5,"searchsorted scalar 200 got "..tostring(r))
end
do -- searcharray 201
  local a=np.array({-26.0,-24.0,-20.75,-18.75,-16.75,-11.5,-9.5,-4.25,-2.25,3.0,5.0,10.25,12.25,14.25,17.5,19.5,21.5,24.75},np.float64)
  local k=np.array({{false,true,true,false},{true,true,false,false}},np.bool)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 201 dtype")
  assert(eq(r.shape,{2,4}),"searchsorted 201 shape")
  assert(eq(r.strides,{32,8}),"searchsorted 201 strides")
  assert(eq(r:tolist(),{{10,10,10,10},{10,10,10,10}}),"searchsorted 201 values")
end
do -- searchscalar 202
  local a=np.array({-22.25,-15.0,-7.75,-0.5,6.75,16.0,23.25},np.float64)
  local r=np.searchsorted(a,64,"right")
  assert(r==8,"searchsorted scalar 202 got "..tostring(r))
end
do -- searcharray 203
  local a=np.array({15,23,44,52,73,81,110,139,168,176,197,205},np.uint16)
  local k=np.array({181,111,141,194,177,216,118},np.uint32)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 203 dtype")
  assert(eq(r.shape,{7}),"searchsorted 203 shape")
  assert(eq(r.strides,{8}),"searchsorted 203 strides")
  assert(eq(r:tolist(),{11,8,9,11,11,13,8}),"searchsorted 203 values")
end
do -- searchscalar 204
  local a=np.array({-26.0,-18.75,-11.5,-4.25,3.0,10.25,19.5},np.float64)
  local r=np.searchsorted(a,0/0,"right")
  assert(r==8,"searchsorted scalar 204 got "..tostring(r))
end
do -- searcharray 205
  local a=np.array({-97,-68,-39,-10,85},np.int16)
  local k=np.array({28,-117,-30},np.int64)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 205 dtype")
  assert(eq(r.shape,{3}),"searchsorted 205 shape")
  assert(eq(r.strides,{8}),"searchsorted 205 strides")
  assert(eq(r:tolist(),{5,1,4}),"searchsorted 205 values")
end
do -- searcharray 206
  local a=np.array({15,44,73,102,197},np.uint32)
  local k=np.array({-68,102,100,90,-11},np.int32)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 206 dtype")
  assert(eq(r.shape,{5}),"searchsorted 206 shape")
  assert(eq(r.strides,{8}),"searchsorted 206 strides")
  assert(eq(r:tolist(),{1,5,4,4,1}),"searchsorted 206 values")
end
do -- searcharray 207
  local a=np.array({-83,-54,99},np.int32)
  local k=np.array({8.75,-0.5,3.0,-19.0,17.75,12.5,27.5,-18.75,-11.0},np.float64)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 207 dtype")
  assert(eq(r.shape,{9}),"searchsorted 207 shape")
  assert(eq(r.strides,{8}),"searchsorted 207 strides")
  assert(eq(r:tolist(),{3,3,3,3,3,3,3,3,3}),"searchsorted 207 values")
end
do -- searchscalar 208
  local a=np.array({-26.25,-19.0,-11.75,0/0},np.float64)
  local r=np.searchsorted(a,178,"right")
  assert(r==4,"searchsorted scalar 208 got "..tostring(r))
end
do -- searchscalar 209
  local a=np.array({-98,-69},np.int16)
  local r=np.searchsorted(a,77,"right")
  assert(r==3,"searchsorted scalar 209 got "..tostring(r))
end
do -- searcharray 210
  local a=np.array({-91,-62,-33,-4,25},np.int8)
  local k=np.array({-99},np.int32)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 210 dtype")
  assert(eq(r.shape,{1}),"searchsorted 210 shape")
  assert(eq(r.strides,{8}),"searchsorted 210 strides")
  assert(eq(r:tolist(),{1}),"searchsorted 210 values")
end
do -- searchscalar 211
  local a=np.array({-84,-55,-26,3,32,61},np.int8)
  local r=np.searchsorted(a,-12,"left")
  assert(r==4,"searchsorted scalar 211 got "..tostring(r))
end
do -- searchscalar 212
  local a=np.array({-19.25,-12.0,-4.75,2.5,9.75,17.0},np.float32)
  local r=np.searchsorted(a,-54,"left")
  assert(r==1,"searchsorted scalar 212 got "..tostring(r))
end
do -- searcharray 213
  local a=np.array({-19.5,-17.5,-12.25,-10.25,-5.0,-3.0,2.25,4.25,9.5,11.5,16.75,18.75,24.0,26.0},np.float32)
  local k=np.array({120,-90,64,-54,-112,3,-46,-32,-118},np.int32)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 213 dtype")
  assert(eq(r.shape,{9}),"searchsorted 213 shape")
  assert(eq(r.strides,{8}),"searchsorted 213 strides")
  assert(eq(r:tolist(),{15,1,15,1,1,8,1,1,1}),"searchsorted 213 values")
end
do -- searchscalar 214
  local a=np.array({-100,-71,-63,-42,-34,-13,-5,16,24,45,53,74,82},np.int8)
  local r=np.searchsorted(a,-103,"right")
  assert(r==1,"searchsorted scalar 214 got "..tostring(r))
end
do -- searchscalar 215
  local a=np.array({-101,-93,-72,-64,-56,-43,-35,-27,-6,2,23,31,52,60,81,89},np.int64)
  local r=np.searchsorted(a,58,"right")
  assert(r==14,"searchsorted scalar 215 got "..tostring(r))
end
do -- searchscalar 216
  local a=np.array({-21.5,-14.25,-12.25,-7.0,-5.0,0.25,2.25,7.5,9.5,16.75,24.0},np.float32)
  local r=np.searchsorted(a,38,"right")
  assert(r==12,"searchsorted scalar 216 got "..tostring(r))
end
do -- searchscalar 217
  local a=np.array({-19.75,-12.5,-10.5,-5.25,-3.25,2.0,4.0,11.25,18.5,25.75},np.float32)
  local r=np.searchsorted(a,-13.25,"left")
  assert(r==2,"searchsorted scalar 217 got "..tostring(r))
end
do -- searcharray 218
  local a=np.array({false,false,false,false,false,false,false,true,true,true,true,true,true,true,true},np.bool)
  local k=np.array({},np.uint16)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 218 dtype")
  assert(eq(r.shape,{0}),"searchsorted 218 shape")
  assert(eq(r.strides,{0}),"searchsorted 218 strides")
  assert(eq(r:tolist(),{}),"searchsorted 218 values")
end
do -- searcharray 219
  local a=np.array({11,40,69,77,98,106,127,135,164,193},np.uint8)
  local k=np.array({160,105,2,104,163,159,181},np.uint16)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 219 dtype")
  assert(eq(r.shape,{7}),"searchsorted 219 shape")
  assert(eq(r.strides,{8}),"searchsorted 219 strides")
  assert(eq(r:tolist(),{9,6,1,6,9,9,10}),"searchsorted 219 values")
end
do -- searchscalar 220
  local a=np.array({-23.75,-21.75,-16.5,-14.5,-9.25,-7.25,-5.25,-2.0,0.0,2.0,5.25,7.25,9.25,12.5,14.5,16.5,21.75,0/0},np.float32)
  local r=np.searchsorted(a,81,"left")
  assert(r==18,"searchsorted scalar 220 got "..tostring(r))
end
do -- searcharray 221
  local a=np.array({25,54,83,91,112,120,141,149,170,178,207},np.uint8)
  local k=np.array({11,96,97,144,216,110},np.uint32)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 221 dtype")
  assert(eq(r.shape,{6}),"searchsorted 221 shape")
  assert(eq(r.strides,{8}),"searchsorted 221 strides")
  assert(eq(r:tolist(),{1,5,5,8,12,5}),"searchsorted 221 values")
end
do -- searchscalar 222
  local a=np.array({},np.int8)
  local r=np.searchsorted(a,-22,"left")
  assert(r==1,"searchsorted scalar 222 got "..tostring(r))
end
do -- searcharray 223
  local a=np.array({-103,-95,-74,-66,-45,-37,-8,0,21,29,50,58,79,87},np.int16)
  local k=np.array({{-8.0},{-15.5}},np.float32)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 223 dtype")
  assert(eq(r.shape,{2,1}),"searchsorted 223 shape")
  assert(eq(r.strides,{8,8}),"searchsorted 223 strides")
  assert(eq(r:tolist(),{{8},{7}}),"searchsorted 223 values")
end
do -- searchscalar 224
  local a=np.array({9,17,38,46,67,75,96,104,112,125,133,141,154,162,170,183,191,199},np.uint8)
  local r=np.searchsorted(a,68,"left")
  assert(r==6,"searchsorted scalar 224 got "..tostring(r))
end
do -- searcharray 225
  local a=np.array({14,43},np.int64)
  local k=np.array({83,159,163,39,203,83},np.uint8)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 225 dtype")
  assert(eq(r.shape,{6}),"searchsorted 225 shape")
  assert(eq(r.strides,{8}),"searchsorted 225 strides")
  assert(eq(r:tolist(),{3,3,3,2,3,3}),"searchsorted 225 values")
end
do -- searcharray 226
  local a=np.array({2,31,60,89,118,126,147,155,176,184},np.uint32)
  local k=np.array({{98},{-50}},np.int32)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 226 dtype")
  assert(eq(r.shape,{2,1}),"searchsorted 226 shape")
  assert(eq(r.strides,{8,8}),"searchsorted 226 strides")
  assert(eq(r:tolist(),{{5},{1}}),"searchsorted 226 values")
end
do -- searchscalar 227
  local a=np.array({9,38,67,96,125,133,154,162,183,191},np.uint16)
  local r=np.searchsorted(a,129,"right")
  assert(r==6,"searchsorted scalar 227 got "..tostring(r))
end
do -- searcharray 228
  local a=np.array({-97,-89,-68,-60,-39,-31,-10,-2,27,35,56,64,85,93},np.int8)
  local k=np.array({102,30,-85,53,-106,-19,-63,-72,-46,-57},np.int32)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 228 dtype")
  assert(eq(r.shape,{10}),"searchsorted 228 shape")
  assert(eq(r.strides,{8}),"searchsorted 228 strides")
  assert(eq(r:tolist(),{15,10,3,11,1,7,4,3,5,5}),"searchsorted 228 values")
end
do -- searchscalar 229
  local a=np.array({-82,-53,-24,5,42,71,100},np.int64)
  local r=np.searchsorted(a,153,"right")
  assert(r==8,"searchsorted scalar 229 got "..tostring(r))
end
do -- searcharray 230
  local a=np.array({false,false,false,false,true,true,true,true},np.bool)
  local k=np.array({194,116,89,60,133,211,158},np.uint32)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 230 dtype")
  assert(eq(r.shape,{7}),"searchsorted 230 shape")
  assert(eq(r.strides,{8}),"searchsorted 230 strides")
  assert(eq(r:tolist(),{9,9,9,9,9,9,9}),"searchsorted 230 values")
end
do -- searcharray 231
  local a=np.array({0,8,29,37,58,66,95,124,153,161,182,190},np.uint8)
  local k=np.array({{30,192,112,95},{181,130,76,170}},np.uint8)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 231 dtype")
  assert(eq(r.shape,{2,4}),"searchsorted 231 shape")
  assert(eq(r.strides,{32,8}),"searchsorted 231 strides")
  assert(eq(r:tolist(),{{4,13,8,7},{11,9,7,11}}),"searchsorted 231 values")
end
do -- searcharray 232
  local a=np.array({-98,-90,-69,-61,-40,-32,-11,-3,18,26,47,55,63,84,92},np.int32)
  local k=np.array({-38,-30,-105,-33,-93,112},np.int16)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 232 dtype")
  assert(eq(r.shape,{6}),"searchsorted 232 shape")
  assert(eq(r.strides,{8}),"searchsorted 232 strides")
  assert(eq(r:tolist(),{6,7,1,6,2,16}),"searchsorted 232 values")
end
do -- searchscalar 233
  local a=np.array({14,22,43,51,72,80,101,109,130,138,159,167,175,188,196,204},np.uint16)
  local r=np.searchsorted(a,157,"right")
  assert(r==11,"searchsorted scalar 233 got "..tostring(r))
end
do -- searcharray 234
  local a=np.array({-105,-84,-76,-55,-47,-26,-18,11,40,69,77,98},np.int32)
  local k=np.array({-96,-11,-12,-56,83,35,31,-81,115,21,-24},np.int32)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 234 dtype")
  assert(eq(r.shape,{11}),"searchsorted 234 shape")
  assert(eq(r.strides,{8}),"searchsorted 234 strides")
  assert(eq(r:tolist(),{2,8,8,4,12,9,9,3,13,9,7}),"searchsorted 234 values")
end
do -- searcharray 235
  local a=np.array({-98,-77,-69,-48,-40,-19,-11,10,18,39,47,76,84,105},np.int16)
  local k=np.array({-110},np.int16)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 235 dtype")
  assert(eq(r.shape,{1}),"searchsorted 235 shape")
  assert(eq(r.strides,{8}),"searchsorted 235 strides")
  assert(eq(r:tolist(),{1}),"searchsorted 235 values")
end
do -- searcharray 236
  local a=np.array({14,43,72,101,130,196},np.uint32)
  local k=np.array({-14},np.int16)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 236 dtype")
  assert(eq(r.shape,{1}),"searchsorted 236 shape")
  assert(eq(r.strides,{8}),"searchsorted 236 strides")
  assert(eq(r:tolist(),{1}),"searchsorted 236 values")
end
do -- searchscalar 237
  local a=np.array({-92,-84,-63,-55,-34,-26,-5,3,24,32,53,61,82,90,98},np.int32)
  local r=np.searchsorted(a,true,"right")
  assert(r==8,"searchsorted scalar 237 got "..tostring(r))
end
do -- searcharray 238
  local a=np.array({-23.25,-21.25,-19.25,-16.0,-14.0,-12.0,-6.75,-4.75,0.5,2.5,7.75,9.75,15.0,17.0,22.25,24.25,26.25},np.float32)
  local k=np.array({77,71,22,54,71},np.uint32)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 238 dtype")
  assert(eq(r.shape,{5}),"searchsorted 238 shape")
  assert(eq(r.strides,{8}),"searchsorted 238 strides")
  assert(eq(r:tolist(),{18,18,15,18,18}),"searchsorted 238 values")
end
do -- searcharray 239
  local a=np.array({-99,-70,-41,-12,17,46},np.int16)
  local k=np.array({{-1.75,24.0,4.25},{-23.5,28.5,13.75}},np.float64)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 239 dtype")
  assert(eq(r.shape,{2,3}),"searchsorted 239 shape")
  assert(eq(r.strides,{24,8}),"searchsorted 239 strides")
  assert(eq(r:tolist(),{{5,6,5},{4,6,5}}),"searchsorted 239 values")
end
do -- searchscalar 240
  local a=np.array({-100,-92,-79,-71,-63,-42,-34,-13,-5,16,24,45,53,74,82,103},np.int64)
  local r=np.searchsorted(a,6,"left")
  assert(r==10,"searchsorted scalar 240 got "..tostring(r))
end
do -- searcharray 241
  local a=np.array({false,false,false,false,false,false,false,true,true,true,true,true,true,true,true},np.bool)
  local k=np.array({0/0},np.float32)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 241 dtype")
  assert(eq(r.shape,{1}),"searchsorted 241 shape")
  assert(eq(r.strides,{8}),"searchsorted 241 strides")
  assert(eq(r:tolist(),{16}),"searchsorted 241 values")
end
do -- searchscalar 242
  local a=np.array({19,27,48,56,85,114,143,172,201},np.uint8)
  local r=np.searchsorted(a,106,"left")
  assert(r==6,"searchsorted scalar 242 got "..tostring(r))
end
do -- searcharray 243
  local a=np.array({false,false,false,true,true,true,true},np.bool)
  local k=np.array({{33,0},{103,24}},np.uint8)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 243 dtype")
  assert(eq(r.shape,{2,2}),"searchsorted 243 shape")
  assert(eq(r.strides,{16,8}),"searchsorted 243 strides")
  assert(eq(r:tolist(),{{8,1},{8,8}}),"searchsorted 243 values")
end
do -- searchscalar 244
  local a=np.array({4,33,41,62,70,99,128,157,186},np.uint8)
  local r=np.searchsorted(a,186,"left")
  assert(r==9,"searchsorted scalar 244 got "..tostring(r))
end
do -- searchscalar 245
  local a=np.array({-94,-65,-57,-36,-28,-7,1,30,59,88},np.int32)
  local r=np.searchsorted(a,-17.0,"right")
  assert(r==6,"searchsorted scalar 245 got "..tostring(r))
end
do -- searcharray 246
  local a=np.array({55,84,113,142,171,200},np.uint32)
  local k=np.array({-31},np.int8)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 246 dtype")
  assert(eq(r.shape,{1}),"searchsorted 246 shape")
  assert(eq(r.strides,{8}),"searchsorted 246 strides")
  assert(eq(r:tolist(),{1}),"searchsorted 246 values")
end
do -- searchscalar 247
  local a=np.array({false,false,false,false,false,false,true,true,true,true,true,true,true},np.bool)
  local r=np.searchsorted(a,17.25,"right")
  assert(r==14,"searchsorted scalar 247 got "..tostring(r))
end
do -- searchscalar 248
  local a=np.array({},np.float64)
  local r=np.searchsorted(a,-84,"left")
  assert(r==1,"searchsorted scalar 248 got "..tostring(r))
end
do -- searcharray 249
  local a=np.array({},np.int16)
  local k=np.array({{108,206,1,58,135,152},{128,197,80,8,10,44}},np.uint32)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 249 dtype")
  assert(eq(r.shape,{2,6}),"searchsorted 249 shape")
  assert(eq(r.strides,{48,8}),"searchsorted 249 strides")
  assert(eq(r:tolist(),{{1,1,1,1,1,1},{1,1,1,1,1,1}}),"searchsorted 249 values")
end
do -- searchscalar 250
  local a=np.array({83,112},np.uint8)
  local r=np.searchsorted(a,-91,"right")
  assert(r==1,"searchsorted scalar 250 got "..tostring(r))
end
do -- searcharray 251
  local a=np.array({24,53,82,90,111,119,140,148,169,177,198,206},np.uint32)
  local k=np.array({163,124,109,23,105,135,127,111,124},np.uint32)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 251 dtype")
  assert(eq(r.shape,{9}),"searchsorted 251 shape")
  assert(eq(r.strides,{8}),"searchsorted 251 strides")
  assert(eq(r:tolist(),{9,7,5,1,5,7,7,6,7}),"searchsorted 251 values")
end
do -- searcharray 252
  local a=np.array({2,23,31,52,60,81,89,97,110,118,126,139,147,155,168,176,184,205},np.uint16)
  local k=np.array({-113,26,104},np.int16)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 252 dtype")
  assert(eq(r.shape,{3}),"searchsorted 252 shape")
  assert(eq(r.strides,{8}),"searchsorted 252 strides")
  assert(eq(r:tolist(),{1,3,9}),"searchsorted 252 values")
end
do -- searchscalar 253
  local a=np.array({9,38,67,96,104,125,133,154,162,191},np.uint16)
  local r=np.searchsorted(a,-20.75,"left")
  assert(r==1,"searchsorted scalar 253 got "..tostring(r))
end
do -- searchscalar 254
  local a=np.array({6},np.int8)
  local r=np.searchsorted(a,20.5,"left")
  assert(r==2,"searchsorted scalar 254 got "..tostring(r))
end
do -- searcharray 255
  local a=np.array({13},np.int64)
  local k=np.array({},np.int64)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 255 dtype")
  assert(eq(r.shape,{0}),"searchsorted 255 shape")
  assert(eq(r.strides,{0}),"searchsorted 255 strides")
  assert(eq(r:tolist(),{}),"searchsorted 255 values")
end
do -- searcharray 256
  local a=np.array({-26.0,5.0,12.25,19.5},np.float64)
  local k=np.array({},np.int8)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 256 dtype")
  assert(eq(r.shape,{0}),"searchsorted 256 shape")
  assert(eq(r.strides,{0}),"searchsorted 256 strides")
  assert(eq(r:tolist(),{}),"searchsorted 256 values")
end
do -- searcharray 257
  local a=np.array({-105,-97,-76,-68,-47,-39,-18,-10,11,19,27,48,56,77,85},np.int32)
  local k=np.array({},np.int32)
  local r=np.searchsorted(a,k,"left")
  assert(r.dtype=="int64","searchsorted 257 dtype")
  assert(eq(r.shape,{0}),"searchsorted 257 shape")
  assert(eq(r.strides,{0}),"searchsorted 257 strides")
  assert(eq(r:tolist(),{}),"searchsorted 257 values")
end
do -- searcharray 258
  local a=np.array({-24.5,-22.5,-17.25,-15.25,-10.0,-8.0,-2.75,-0.75,4.5,6.5,8.5,11.75,13.75,15.75,19.0,21.0,23.0,26.25},np.float32)
  local k=np.array({{136,142,34,152,200},{93,159,78,112,190}},np.uint32)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 258 dtype")
  assert(eq(r.shape,{2,5}),"searchsorted 258 shape")
  assert(eq(r.strides,{40,8}),"searchsorted 258 strides")
  assert(eq(r:tolist(),{{19,19,19,19,19},{19,19,19,19,19}}),"searchsorted 258 values")
end
do -- searcharray 259
  local a=np.array({146},np.uint32)
  local k=np.array({{-26},{9}},np.int16)
  local r=np.searchsorted(a,k,"right")
  assert(r.dtype=="int64","searchsorted 259 dtype")
  assert(eq(r.shape,{2,1}),"searchsorted 259 shape")
  assert(eq(r.strides,{8,8}),"searchsorted 259 strides")
  assert(eq(r:tolist(),{{1},{1}}),"searchsorted 259 values")
end
do -- sorter 0
  local a=np.array({0,47,94,141,188,12,59,106,153,200,24},np.uint8)
  local k=np.array({153,0,94},np.uint8)
  local sorter=np.array({1,6,11,2,7,3,8,4,9,5,10},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{9,1,6}),"searchsorted sorter 0")
end
do -- sorter 1
  local a=np.array({13,60,107,154,201,25,72,119,166,213,37,84,131,178,2},np.uint32)
  local k=np.array({84,0,166},np.uint32)
  local sorter=np.array({15,1,6,11,2,7,12,3,8,13,4,9,14,5,10},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{8,1,13}),"searchsorted sorter 1")
end
do -- sorter 2
  local a=np.array({-85,-38},np.int32)
  local k=np.array({-85,0,-85},np.int32)
  local sorter=np.array({1,2},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{1,3,1}),"searchsorted sorter 2")
end
do -- sorter 3
  local a=np.array({39,86,133,180,4,51,98,145,192,16,63,110,157,204,28},np.uint16)
  local k=np.array({86,0,180},np.uint16)
  local sorter=np.array({5,10,15,1,6,11,2,7,12,3,8,13,4,9,14},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{8,1,14}),"searchsorted sorter 3")
end
do -- sorter 4
  local a=np.array({-59,-12,35,82,-94,-47,0,47,94,-82,-35,12,59,106},np.int64)
  local k=np.array({-59,0,-94},np.int64)
  local sorter=np.array({5,10,1,6,11,2,7,12,3,8,13,4,9,14},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{3,7,1}),"searchsorted sorter 4")
end
do -- sorter 5
  local a=np.array({-46,1,48},np.int8)
  local k=np.array({48,0,48},np.int8)
  local sorter=np.array({1,2,3},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{3,2,3}),"searchsorted sorter 5")
end
do -- sorter 6
  local a=np.array({78,125},np.uint32)
  local k=np.array({78,0,78},np.uint32)
  local sorter=np.array({1,2},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{1,1,1}),"searchsorted sorter 6")
end
do -- sorter 7
  local a=np.array({-2.5,3.375,9.25,-12.75,-6.875,-1.0,4.875,10.75},np.float64)
  local k=np.array({3.375,0.0,-1.0},np.float64)
  local sorter=np.array({4,5,1,6,2,7,3,8},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{5,5,4}),"searchsorted sorter 7")
end
do -- sorter 8
  local a=np.array({-7,40,87,-89,-42,5,52,99,-77,-30,17,64},np.int32)
  local k=np.array({-30,0,99},np.int32)
  local sorter=np.array({4,9,5,10,1,6,11,2,7,12,3,8},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{5,6,13}),"searchsorted sorter 8")
end
do -- sorter 9
  local a=np.array({6,53,100,-76,-29,18,65,-111,-64},np.int32)
  local k=np.array({-76,0,6},np.int32)
  local sorter=np.array({8,4,9,5,1,6,2,7,3},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{2,5,5}),"searchsorted sorter 9")
end
do -- sorter 10
  local a=np.array({19,66,-110,-63,-16,31,78,-98,-51,-4,43,90,-86,-39,8,55},np.int64)
  local k=np.array({8,0,-39},np.int64)
  local sorter=np.array({3,8,13,4,9,14,5,10,15,1,6,11,16,2,7,12},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{10,9,7}),"searchsorted sorter 10")
end
do -- sorter 11
  local a=np.array({32,79,-97},np.int8)
  local k=np.array({32,0,32},np.int8)
  local sorter=np.array({3,1,2},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{2,2,2}),"searchsorted sorter 11")
end
do -- sorter 12
  local a=np.array({45,92,-84,-37,10,57,104,-72,-25,22,69,-107,-60},np.int8)
  local k=np.array({22,0,45},np.int8)
  local sorter=np.array({12,3,8,13,4,9,5,10,1,6,11,2,7},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{8,7,9}),"searchsorted sorter 12")
end
do -- sorter 13
  local a=np.array({7.25,13.125,-8.875},np.float32)
  local k=np.array({13.125,0.0,13.125},np.float32)
  local sorter=np.array({3,1,2},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{4,2,4}),"searchsorted sorter 13")
end
do -- sorter 14
  local a=np.array({71,-105,-58,-11,36,83,-93,-46,1,48,95,-81,-34},np.int8)
  local k=np.array({48,0,71},np.int8)
  local sorter=np.array({2,7,12,3,8,13,4,9,5,10,1,6,11},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{11,8,12}),"searchsorted sorter 14")
end
do -- sorter 15
  local a=np.array({195,19,66,113,160,207,31,78,125,172,219,43,90,137,184},np.uint8)
  local k=np.array({160,0,43},np.uint8)
  local sorter=np.array({2,7,12,3,8,13,4,9,14,5,10,15,1,6,11},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{11,1,4}),"searchsorted sorter 15")
end
do -- sorter 16
  local a=np.array({97,-79,-32,15,62,109,-67,-20,27,74,-102,-55,-8,39},np.int32)
  local k=np.array({109,0,74},np.int32)
  local sorter=np.array({11,2,7,12,3,8,13,4,9,14,5,10,1,6},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{14,8,12}),"searchsorted sorter 16")
end
do -- sorter 17
  local a=np.array({110,-66,-19,28,75,-101,-54,-7,40,87},np.int64)
  local k=np.array({87,0,-101},np.int64)
  local sorter=np.array({6,2,7,3,8,4,9,5,10,1},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{9,6,1}),"searchsorted sorter 17")
end
do -- sorter 18
  local a=np.array({11,58,105,152},np.uint16)
  local k=np.array({152,0,11},np.uint16)
  local sorter=np.array({1,2,3,4},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{5,1,2}),"searchsorted sorter 18")
end
do -- sorter 19
  local a=np.array({-10.875,-5.0,0.875,6.75,12.625,-9.375},np.float64)
  local k=np.array({12.625,0.0,0.875},np.float64)
  local sorter=np.array({1,6,2,3,4,5},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{6,4,4}),"searchsorted sorter 19")
end
do -- sorter 20
  local a=np.array({-74,-27,20,67,-109,-62},np.int16)
  local k=np.array({20,0,-109},np.int16)
  local sorter=np.array({5,1,6,2,3,4},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{6,5,2}),"searchsorted sorter 20")
end
do -- sorter 21
  local a=np.array({-61,-14,33,80,-96,-49,-2,45},np.int16)
  local k=np.array({-96,0,80},np.int16)
  local sorter=np.array({5,1,6,2,7,3,8,4},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{2,6,9}),"searchsorted sorter 21")
end
do -- sorter 22
  local a=np.array({-6.0,-0.125},np.float64)
  local k=np.array({-0.125,0.0,-0.125},np.float64)
  local sorter=np.array({1,2},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{3,3,3}),"searchsorted sorter 22")
end
do -- sorter 23
  local a=np.array({-35,12,59,106,-70,-23,24,71,-105},np.int16)
  local k=np.array({-23,0,59},np.int16)
  local sorter=np.array({9,5,1,6,2,7,3,8,4},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{5,5,8}),"searchsorted sorter 23")
end
do -- sorter 24
  local a=np.array({-22,25,72,-104,-57,-10,37,84,-92,-45},np.int32)
  local k=np.array({84,0,84},np.int32)
  local sorter=np.array({4,9,5,10,1,6,2,7,3,8},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{10,7,10}),"searchsorted sorter 24")
end
do -- sorter 25
  local a=np.array({102,149,196,20,67,114,161,208,32,79,126},np.uint16)
  local k=np.array({67,0,20},np.uint16)
  local sorter=np.array({4,9,5,10,1,6,11,2,7,3,8},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{3,1,1}),"searchsorted sorter 25")
end
do -- sorter 26
  local a=np.array({4,51,98,-78,-31,16},np.int16)
  local k=np.array({16,0,-31},np.int16)
  local sorter=np.array({4,5,1,6,2,3},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{4,3,2}),"searchsorted sorter 26")
end
do -- sorter 27
  local a=np.array({2.125},np.float64)
  local k=np.array({2.125,0.0,2.125},np.float64)
  local sorter=np.array({1},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{2,1,2}),"searchsorted sorter 27")
end
do -- sorter 28
  local a=np.array({30,77,-99,-52,-5,42,89,-87,-40},np.int64)
  local k=np.array({-87,0,-5},np.int64)
  local sorter=np.array({3,8,4,9,5,1,6,2,7},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{3,6,6}),"searchsorted sorter 28")
end
do -- sorter 29
  local a=np.array({5.375,11.25,-10.75,-4.875,1.0,6.875},np.float32)
  local k=np.array({11.25,0.0,-4.875},np.float32)
  local sorter=np.array({3,4,5,1,6,2},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{7,3,3}),"searchsorted sorter 29")
end
do -- sorter 30
  local a=np.array({56,103,-73,-26,21,68,-108,-61},np.int32)
  local k=np.array({56,0,68},np.int32)
  local sorter=np.array({7,3,8,4,5,1,6,2},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{7,5,8}),"searchsorted sorter 30")
end
do -- sorter 31
  local a=np.array({69,-107,-60,-13},np.int64)
  local k=np.array({-13,0,-13},np.int64)
  local sorter=np.array({2,3,4,1},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{4,4,4}),"searchsorted sorter 31")
end
do -- sorter 32
  local a=np.array({10.25,-11.75,-5.875,0.0,5.875,11.75,-10.25,-4.375,1.5,7.375,13.25},np.float32)
  local k=np.array({-5.875,0.0,-5.875},np.float32)
  local sorter=np.array({2,7,3,8,4,9,5,10,1,6,11},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{4,6,4}),"searchsorted sorter 32")
end
do -- sorter 33
  local a=np.array({206,30,77,124,171,218,42,89,136,183,7,54,101,148},np.uint16)
  local k=np.array({183,0,54},np.uint16)
  local sorter=np.array({11,2,7,12,3,8,13,4,9,14,5,10,1,6},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{12,1,4}),"searchsorted sorter 33")
end
do -- sorter 34
  local a=np.array({108,-68,-21},np.int8)
  local k=np.array({-21,0,-21},np.int8)
  local sorter=np.array({2,3,1},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{2,3,2}),"searchsorted sorter 34")
end
do -- sorter 35
  local a=np.array({-102,-55,-8,39,86,-90,-43,4,51,98,-78,-31,16,63,110},np.int32)
  local k=np.array({-90,0,4},np.int32)
  local sorter=np.array({1,6,11,2,7,12,3,8,13,4,9,14,5,10,15},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{2,8,8}),"searchsorted sorter 35")
end
do -- sorter 36
  local a=np.array({-89,-42,5,52},np.int64)
  local k=np.array({-89,0,-42},np.int64)
  local sorter=np.array({1,2,3,4},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{2,3,3}),"searchsorted sorter 36")
end
do -- sorter 37
  local a=np.array({35,82,129,176,0,47,94,141,188,12,59,106,153,200},np.uint8)
  local k=np.array({141,0,153},np.uint8)
  local sorter=np.array({5,10,1,6,11,2,7,12,3,8,13,4,9,14},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{10,1,11}),"searchsorted sorter 37")
end
do -- sorter 38
  local a=np.array({48},np.uint8)
  local k=np.array({48,0,48},np.uint8)
  local sorter=np.array({1},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{1,1,1}),"searchsorted sorter 38")
end
do -- sorter 39
  local a=np.array({-6.25,-0.375,5.5,11.375,-10.625,-4.75,1.125,7.0,12.875,-9.125,-3.25},np.float64)
  local k=np.array({5.5,0.0,11.375},np.float64)
  local sorter=np.array({5,10,1,6,11,2,7,3,8,4,9},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{9,7,11}),"searchsorted sorter 39")
end
do -- sorter 40
  local a=np.array({74,121,168,215,39,86},np.uint8)
  local k=np.array({215,0,121},np.uint8)
  local sorter=np.array({5,1,6,2,3,4},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{7,1,5}),"searchsorted sorter 40")
end
do -- sorter 41
  local a=np.array({-24},np.int32)
  local k=np.array({-24,0,-24},np.int32)
  local sorter=np.array({1},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{1,2,1}),"searchsorted sorter 41")
end
do -- sorter 42
  local a=np.array({100,147,194,18},np.uint16)
  local k=np.array({194,0,100},np.uint16)
  local sorter=np.array({4,1,2,3},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{5,1,3}),"searchsorted sorter 42")
end
do -- sorter 43
  local a=np.array({2,49,96,-80,-33},np.int32)
  local k=np.array({-80,0,49},np.int32)
  local sorter=np.array({4,5,1,2,3},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{1,3,4}),"searchsorted sorter 43")
end
do -- sorter 44
  local a=np.array({126,173,220,44,91,138,185,9,56,103,150,197,21,68,115,162},np.uint8)
  local k=np.array({197,0,56},np.uint8)
  local sorter=np.array({8,13,4,9,14,5,10,15,1,6,11,16,2,7,12,3},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{16,1,5}),"searchsorted sorter 44")
end
do -- sorter 45
  local a=np.array({3.5,9.375,-12.625,-6.75,-0.875,5.0,10.875,-11.125,-5.25,0.625,6.5,12.375},np.float32)
  local k=np.array({-11.125,0.0,9.375},np.float32)
  local sorter=np.array({3,8,4,9,5,10,1,6,11,2,7,12},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{3,6,11}),"searchsorted sorter 45")
end
do -- sorter 46
  local a=np.array({41,88,-88,-41,6,53,100,-76,-29,18,65,-111,-64},np.int32)
  local k=np.array({-41,0,-88},np.int32)
  local sorter=np.array({12,3,8,13,4,9,5,10,1,6,11,2,7},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{5,7,2}),"searchsorted sorter 46")
end
do -- sorter 47
  local a=np.array({165,212,36,83,130,177,1,48,95,142},np.uint16)
  local k=np.array({142,0,130},np.uint16)
  local sorter=np.array({7,3,8,4,9,5,10,1,6,2},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{8,1,7}),"searchsorted sorter 47")
end
do -- sorter 48
  local a=np.array({67,-109,-62,-15,32,79,-97},np.int16)
  local k=np.array({-109,0,-15},np.int16)
  local sorter=np.array({2,7,3,4,5,1,6},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{2,5,5}),"searchsorted sorter 48")
end
do -- sorter 49
  local a=np.array({10.0,-12.0,-6.125,-0.25},np.float64)
  local k=np.array({-0.25,0.0,-6.125},np.float64)
  local sorter=np.array({2,3,4,1},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{4,4,3}),"searchsorted sorter 49")
end
do -- sorter 50
  local a=np.array({11.625,-10.375,-4.5,1.375,7.25,13.125,-8.875,-3.0,2.875,8.75,-13.25,-7.375,-1.5,4.375,10.25,-11.75},np.float64)
  local k=np.array({-3.0,0.0,-11.75},np.float64)
  local sorter=np.array({11,16,2,7,12,3,8,13,4,9,14,5,10,15,1,6},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{8,9,3}),"searchsorted sorter 50")
end
do -- sorter 51
  local a=np.array({106,-70},np.int64)
  local k=np.array({106,0,106},np.int64)
  local sorter=np.array({2,1},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{2,2,2}),"searchsorted sorter 51")
end
do -- sorter 52
  local a=np.array({7,54,101,148,195,19,66,113,160,207,31,78,125,172,219},np.uint32)
  local k=np.array({148,0,207},np.uint32)
  local sorter=np.array({1,6,11,2,7,12,3,8,13,4,9,14,5,10,15},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{10,1,14}),"searchsorted sorter 52")
end
do -- sorter 53
  local a=np.array({-11.375,-5.5,0.375,6.25,12.125,-9.875,-4.0,1.875,7.75,13.625,-8.375,-2.5,3.375,9.25},np.float32)
  local k=np.array({-4.0,0.0,-11.375},np.float32)
  local sorter=np.array({1,6,11,2,7,12,3,8,13,4,9,14,5,10},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{6,7,2}),"searchsorted sorter 53")
end
do -- sorter 54
  local a=np.array({-78,-31,16,63,110,-66,-19,28,75,-101,-54,-7,40,87},np.int8)
  local k=np.array({40,0,-54},np.int8)
  local sorter=np.array({10,1,6,11,2,7,12,3,8,13,4,9,14,5},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{10,8,4}),"searchsorted sorter 54")
end
do -- sorter 55
  local a=np.array({-65,-18,29,76},np.int16)
  local k=np.array({-65,0,29},np.int16)
  local sorter=np.array({1,2,3,4},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{1,3,3}),"searchsorted sorter 55")
end
do -- sorter 56
  local a=np.array({-6.5,-0.625,5.25,11.125,-10.875,-5.0,0.875,6.75,12.625,-9.375,-3.5,2.375,8.25,-13.75},np.float64)
  local k=np.array({11.125,0.0,-0.625},np.float64)
  local sorter=np.array({14,5,10,1,6,11,2,7,12,3,8,13,4,9},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{13,8,7}),"searchsorted sorter 56")
end
do -- sorter 57
  local a=np.array({-4.875,1.0,6.875,12.75},np.float32)
  local k=np.array({6.875,0.0,12.75},np.float32)
  local sorter=np.array({1,2,3,4},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{3,2,4}),"searchsorted sorter 57")
end
do -- sorter 58
  local a=np.array({-26,21,68,-108,-61,-14,33,80,-96,-49,-2,45,92},np.int16)
  local k=np.array({-96,0,-26},np.int16)
  local sorter=np.array({4,9,5,10,1,6,11,2,7,12,3,8,13},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{2,8,5}),"searchsorted sorter 58")
end
do -- sorter 59
  local a=np.array({-13,34,81,-95,-48,-1,46,93},np.int16)
  local k=np.array({81,0,46},np.int16)
  local sorter=np.array({4,5,1,6,2,7,3,8},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{7,5,6}),"searchsorted sorter 59")
end
do -- sorter 60
  local a=np.array({111,158,205,29,76,123,170,217,41,88,135,182,6},np.uint16)
  local k=np.array({135,0,88},np.uint16)
  local sorter=np.array({13,4,9,5,10,1,6,11,2,7,12,3,8},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{8,1,5}),"searchsorted sorter 60")
end
do -- sorter 61
  local a=np.array({1.625,7.5,13.375,-8.625,-2.75,3.125,9.0,-13.0,-7.125,-1.25,4.625,10.5},np.float64)
  local k=np.array({4.625,0.0,-1.25},np.float64)
  local sorter=np.array({8,4,9,5,10,1,6,11,2,7,12,3},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{9,6,6}),"searchsorted sorter 61")
end
do -- sorter 62
  local a=np.array({137,184,8,55,102,149,196},np.uint16)
  local k=np.array({55,0,137},np.uint16)
  local sorter=np.array({3,4,5,1,6,2,7},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{3,1,5}),"searchsorted sorter 62")
end
do -- sorter 63
  local a=np.array({39,86,-90,-43,4,51,98,-78},np.int8)
  local k=np.array({-78,0,51},np.int8)
  local sorter=np.array({3,8,4,5,1,6,2,7},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{2,4,6}),"searchsorted sorter 63")
end
do -- sorter 64
  local a=np.array({163,210,34,81,128,175,222,46,93,140,187,11,58,105},np.uint32)
  local k=np.array({140,0,34},np.uint32)
  local sorter=np.array({12,3,8,13,4,9,14,5,10,1,6,11,2,7},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{9,1,2}),"searchsorted sorter 64")
end
do -- sorter 65
  local a=np.array({8.125,-13.875,-8.0,-2.125,3.75,9.625,-12.375,-6.5,-0.625,5.25,11.125,-10.875,-5.0,0.875},np.float32)
  local k=np.array({-5.0,0.0,-2.125},np.float32)
  local sorter=np.array({2,7,12,3,8,13,4,9,14,5,10,1,6,11},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{7,9,8}),"searchsorted sorter 65")
end
do -- sorter 66
  local a=np.array({189,13,60,107,154,201,25,72,119,166,213,37,84,131,178,2},np.uint8)
  local k=np.array({213,0,119},np.uint8)
  local sorter=np.array({16,2,7,12,3,8,13,4,9,14,5,10,15,1,6,11},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{16,1,9}),"searchsorted sorter 66")
end
do -- sorter 67
  local a=np.array({202,26,73,120,167,214,38,85,132,179},np.uint8)
  local k=np.array({179,0,85},np.uint8)
  local sorter=np.array({2,7,3,8,4,9,5,10,1,6},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{9,1,5}),"searchsorted sorter 67")
end
do -- sorter 68
  local a=np.array({215,39,86,133,180,4},np.uint16)
  local k=np.array({86,0,215},np.uint16)
  local sorter=np.array({6,2,3,4,5,1},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{4,1,7}),"searchsorted sorter 68")
end
do -- sorter 69
  local a=np.array({-106,-59,-12,35,82,-94,-47,0,47,94,-82,-35},np.int8)
  local k=np.array({-47,0,47},np.int8)
  local sorter=np.array({1,6,11,2,7,12,3,8,4,9,5,10},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{6,9,11}),"searchsorted sorter 69")
end
do -- sorter 70
  local a=np.array({-93,-46},np.int16)
  local k=np.array({-93,0,-46},np.int16)
  local sorter=np.array({1,2},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{1,3,2}),"searchsorted sorter 70")
end
do -- sorter 71
  local a=np.array({-80,-33,14,61,108,-68,-21,26,73,-103,-56,-9,38,85,-91,-44},np.int16)
  local k=np.array({-103,0,85},np.int16)
  local sorter=np.array({10,15,1,6,11,16,2,7,12,3,8,13,4,9,14,5},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{2,10,16}),"searchsorted sorter 71")
end
do -- sorter 72
  local a=np.array({44,91,138,185,9,56},np.uint8)
  local k=np.array({56,0,91},np.uint8)
  local sorter=np.array({5,1,6,2,3,4},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{4,1,5}),"searchsorted sorter 72")
end
do -- sorter 73
  local a=np.array({57,104,151,198,22,69,116},np.uint8)
  local k=np.array({57,0,22},np.uint8)
  local sorter=np.array({5,1,6,2,7,3,4},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{2,1,1}),"searchsorted sorter 73")
end
do -- sorter 74
  local a=np.array({70,117,164,211,35,82,129,176,0,47,94,141,188,12,59,106},np.uint16)
  local k=np.array({59,0,0},np.uint16)
  local sorter=np.array({9,14,5,10,15,1,6,11,16,2,7,12,3,8,13,4},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{5,1,1}),"searchsorted sorter 74")
end
do -- sorter 75
  local a=np.array({-28,19,66,-110,-63,-16,31,78,-98,-51,-4,43,90,-86,-39,8},np.int8)
  local k=np.array({-63,0,-39},np.int8)
  local sorter=np.array({4,9,14,5,10,15,1,6,11,16,2,7,12,3,8,13},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{4,10,6}),"searchsorted sorter 75")
end
do -- sorter 76
  local a=np.array({96,143,190,14,61,108,155,202,26,73,120,167},np.uint16)
  local k=np.array({73,0,120},np.uint16)
  local sorter=np.array({4,9,5,10,1,6,11,2,7,12,3,8},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{5,1,8}),"searchsorted sorter 76")
end
do -- sorter 77
  local a=np.array({-2,45,92,-84,-37,10,57,104,-72,-25,22},np.int64)
  local k=np.array({45,0,-37},np.int64)
  local sorter=np.array({4,9,5,10,1,6,11,2,7,3,8},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{8,6,3}),"searchsorted sorter 77")
end
do -- sorter 78
  local a=np.array({1.375,7.25,13.125,-8.875,-3.0,2.875,8.75,-13.25,-7.375,-1.5,4.375,10.25,-11.75},np.float64)
  local k=np.array({4.375,0.0,2.875},np.float64)
  local sorter=np.array({8,13,4,9,5,10,1,6,11,2,7,12,3},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{9,7,8}),"searchsorted sorter 78")
end
do -- sorter 79
  local a=np.array({24,71,-105,-58,-11,36,83,-93,-46,1,48,95,-81,-34,13},np.int32)
  local k=np.array({36,0,-46},np.int32)
  local sorter=np.array({3,8,13,4,9,14,5,10,15,1,6,11,2,7,12},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{11,8,5}),"searchsorted sorter 79")
end
do -- sorter 80
  local a=np.array({37},np.int64)
  local k=np.array({37,0,37},np.int64)
  local sorter=np.array({1},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{1,1,1}),"searchsorted sorter 80")
end
do -- sorter 81
  local a=np.array({50,97,-79,-32,15,62,109,-67,-20,27,74,-102,-55},np.int32)
  local k=np.array({-55,0,15},np.int32)
  local sorter=np.array({12,3,8,13,4,9,5,10,1,6,11,2,7},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{4,7,7}),"searchsorted sorter 81")
end
do -- sorter 82
  local a=np.array({7.875},np.float32)
  local k=np.array({7.875,0.0,7.875},np.float32)
  local sorter=np.array({1},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{1,1,1}),"searchsorted sorter 82")
end
do -- sorter 83
  local a=np.array({76,-100,-53,-6,41,88,-88,-41,6,53,100,-76,-29,18,65,-111},np.int32)
  local k=np.array({53,0,-53},np.int32)
  local sorter=np.array({16,2,7,12,3,8,13,4,9,14,5,10,15,1,6,11},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{13,9,6}),"searchsorted sorter 83")
end
do -- sorter 84
  local a=np.array({200,24,71,118,165,212,36,83,130,177,1,48,95},np.uint16)
  local k=np.array({118,0,24},np.uint16)
  local sorter=np.array({11,2,7,12,3,8,13,4,9,5,10,1,6},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{9,1,3}),"searchsorted sorter 84")
end
do -- sorter 85
  local a=np.array({213,37,84,131,178,2,49,96},np.uint32)
  local k=np.array({96,0,178},np.uint32)
  local sorter=np.array({6,2,7,3,8,4,5,1},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{5,1,7}),"searchsorted sorter 85")
end
do -- sorter 86
  local a=np.array({3,50,97,144},np.uint8)
  local k=np.array({144,0,50},np.uint8)
  local sorter=np.array({1,2,3,4},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{5,1,3}),"searchsorted sorter 86")
end
do -- sorter 87
  local a=np.array({16,63,110,157,204,28,75,122},np.uint32)
  local k=np.array({63,0,157},np.uint32)
  local sorter=np.array({1,6,2,7,3,8,4,5},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{4,1,8}),"searchsorted sorter 87")
end
do -- sorter 88
  local a=np.array({-82,-35,12},np.int32)
  local k=np.array({-82,0,-82},np.int32)
  local sorter=np.array({1,2,3},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{2,3,2}),"searchsorted sorter 88")
end
do -- sorter 89
  local a=np.array({-69,-22,25,72,-104,-57,-10,37},np.int64)
  local k=np.array({-57,0,72},np.int64)
  local sorter=np.array({5,1,6,2,7,3,8,4},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{4,6,9}),"searchsorted sorter 89")
end
do -- sorter 90
  local a=np.array({-56,-9,38,85,-91,-44,3,50,97,-79,-32},np.int16)
  local k=np.array({-9,0,-91},np.int16)
  local sorter=np.array({5,10,1,6,11,2,7,3,8,4,9},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{7,7,2}),"searchsorted sorter 90")
end
do -- sorter 91
  local a=np.array({68,115,162,209,33,80},np.uint32)
  local k=np.array({33,0,80},np.uint32)
  local sorter=np.array({5,1,6,2,3,4},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{1,1,3}),"searchsorted sorter 91")
end
do -- sorter 92
  local a=np.array({81,128,175,222,46,93,140,187,11,58},np.uint8)
  local k=np.array({128,0,46},np.uint8)
  local sorter=np.array({9,5,10,1,6,2,7,3,8,4},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{7,1,3}),"searchsorted sorter 92")
end
do -- sorter 93
  local a=np.array({-17,30,77,-99,-52},np.int16)
  local k=np.array({-52,0,30},np.int16)
  local sorter=np.array({4,5,1,2,3},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{3,4,5}),"searchsorted sorter 93")
end
do -- sorter 94
  local a=np.array({-0.5,5.375,11.25,-10.75,-4.875,1.0,6.875,12.75,-9.25,-3.375},np.float64)
  local k=np.array({-3.375,0.0,11.25},np.float64)
  local sorter=np.array({4,9,5,10,1,6,2,7,3,8},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{4,6,9}),"searchsorted sorter 94")
end
do -- sorter 95
  local a=np.array({9},np.int16)
  local k=np.array({9,0,9},np.int16)
  local sorter=np.array({1},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{2,1,2}),"searchsorted sorter 95")
end
do -- sorter 96
  local a=np.array({133,180},np.uint32)
  local k=np.array({180,0,180},np.uint32)
  local sorter=np.array({1,2},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{3,1,3}),"searchsorted sorter 96")
end
do -- sorter 97
  local a=np.array({35,82,-94,-47,0,47,94,-82,-35},np.int64)
  local k=np.array({82,0,-35},np.int64)
  local sorter=np.array({3,8,4,9,5,1,6,2,7},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{8,5,4}),"searchsorted sorter 97")
end
do -- sorter 98
  local a=np.array({48,95,-81,-34,13,60,107},np.int64)
  local k=np.array({95,0,60},np.int64)
  local sorter=np.array({3,4,5,1,6,2,7},np.int64)
  local r=np.searchsorted(a,k,{side="left",sorter=sorter})
  assert(eq(r:tolist(),{6,3,5}),"searchsorted sorter 98")
end
do -- sorter 99
  local a=np.array({61,108,-68,-21,26,73,-103,-56,-9,38,85,-91,-44,3,50,97},np.int32)
  local k=np.array({61,0,3},np.int32)
  local sorter=np.array({7,12,3,8,13,4,9,14,5,10,15,1,6,11,16,2},np.int64)
  local r=np.searchsorted(a,k,{side="right",sorter=sorter})
  assert(eq(r:tolist(),{13,8,9}),"searchsorted sorter 99")
end
do local a=np.array({-5,99,-2,99,0,99,4,99},np.int64):get(np.slice(1,nil,2)); local r=np.searchsorted(a,{-3,0,9}); assert(eq(r:tolist(),{2,3,5}),'strided haystack') end
do local a=np.array({-1,0,2,0/0,0/0},np.float64); assert(a:searchsorted(0/0)==4 and a:searchsorted(0/0,'right')==6,'NaN boundary') end
do local a=np.array({3,1,2},np.int64); local s=np.argsort(a); assert(a:searchsorted(2,{sorter=s})==2,'method sorter') end
do local a=np.array({1,2,3},np.int64); local ok,e=pcall(function() return np.searchsorted(a,2,{sorter={5,5,5}}) end); assert(not ok and tostring(e):find('Sorter index out of range.',1,true),'sorter range error') end
do local a=np.array({1,2,3},np.int64); local ok,e=pcall(function() return np.searchsorted(a,2,{sorter={1,0,3}}) end); assert(not ok and tostring(e):find('sorter index 0 is invalid',1,true),'sorter zero error') end
do local a=np.reshape(np.arange(4),{2,2}); local ok,e=pcall(function() return np.searchsorted(a,2) end); assert(not ok and tostring(e):find('object too deep',1,true),'1d haystack error') end
print('searchsorted differential: 366 cases ok')
