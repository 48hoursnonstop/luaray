local np=require('luaray_core')

local function fsame(a,b,tol)
  if a~=a and b~=b then return true end
  if a==0 and b==0 then return true end
  if a==b then return true end
  if a==math.huge or a==-math.huge or b==math.huge or b==-math.huge then return false end
  return math.abs(a-b)<=tol*math.max(1,math.abs(a),math.abs(b))
end
local function zsame(a,b,tol)
  return type(a)=='userdata' and type(b)=='userdata' and fsame(a.real,b.real,tol) and fsame(a.imag,b.imag,tol)
end
local function list_same(a,b,tol)
  if #a~=#b then return false end
  for i=1,#a do if not zsame(a[i],b[i],tol) then return false end end
  return true
end
-- Generated against development NumPy 2.3.5.
do
 local a=np.array({np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(-0.0,-0.0),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(0.0,math.huge),np.complex(0.0,-math.huge),np.complex(math.huge,1.0),np.complex(-math.huge,-1.0),np.complex((0/0),0.0),np.complex((0/0),2.0),np.complex(2.0,(0/0)),np.complex((0/0),(0/0))},np.complex64)
 local r=np.sqrt(a)
 assert(r.dtype=='complex64','complex math dtype 0')
 assert(list_same(r:tolist(),{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,-0.0),np.complex(0.0,-0.0),np.complex(math.huge,0.0),np.complex(0.0,math.huge),np.complex(math.huge,math.huge),np.complex(math.huge,-math.huge),np.complex(math.huge,0.0),np.complex(0.0,-math.huge),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},8e-05),'complex math sqrt 0')
end
do
 local a=np.array({np.complex(-8.0,-1.0),np.complex(-0.0,0.5),np.complex(-0.0,2.0),np.complex(0.0,5.0),np.complex(0.25,0.0),np.complex(1.0,-5.0),np.complex(-1.0,0.0),np.complex(0.0,-1.0),np.complex(0.25,0.5),np.complex(-3.0,0.0),np.complex(-3.0,0.0)},np.complex64)
 local r=np.sqrt(a)
 assert(r.dtype=='complex64','complex math dtype 1')
 assert(list_same(r:tolist(),{np.complex(0.1764337718486786,-2.8339245319366455),np.complex(0.5,0.5),np.complex(1.0,1.0),np.complex(1.5811388492584229,1.5811388492584229),np.complex(0.5,0.0),np.complex(1.7462846040725708,-1.4316108226776123),np.complex(0.0,1.0),np.complex(0.7071067690849304,-0.7071067690849304),np.complex(0.6360098123550415,0.39307570457458496),np.complex(0.0,1.7320507764816284),np.complex(0.0,1.7320507764816284)},8e-05),'complex math sqrt 1')
end
do
 local a=np.array({np.complex(0.0,-0.0),np.complex(-8.0,-5.0),np.complex(-3.0,0.5),np.complex(0.25,-5.0),np.complex(0.0,5.0),np.complex(0.0,2.0),np.complex(-0.0,2.0),np.complex(8.0,-0.0),np.complex(-1.0,2.0),np.complex(-1.0,0.5),np.complex(-0.0,-1.0)},np.complex64)
 local r=np.sqrt(a)
 assert(r.dtype=='complex64','complex math dtype 2')
 assert(list_same(r:tolist(),{np.complex(0.0,-0.0),np.complex(0.846752941608429,-2.9524550437927246),np.complex(0.14384238421916962,1.7380133867263794),np.complex(1.621148705482483,-1.542116403579712),np.complex(1.5811388492584229,1.5811388492584229),np.complex(1.0,1.0),np.complex(1.0,1.0),np.complex(2.8284270763397217,-0.0),np.complex(0.7861514091491699,1.272019624710083),np.complex(0.24293413758277893,1.0290855169296265),np.complex(0.7071067690849304,-0.7071067690849304)},8e-05),'complex math sqrt 2')
end
do
 local a=np.array({np.complex(1.0,0.0),np.complex(-3.0,0.5),np.complex(0.25,-0.0),np.complex(3.0,2.0),np.complex(-0.0,-0.0),np.complex(8.0,5.0),np.complex(3.0,0.5),np.complex(-8.0,-0.0),np.complex(8.0,0.5),np.complex(3.0,5.0),np.complex(1.0,0.5)},np.complex64)
 local r=np.sqrt(a)
 assert(r.dtype=='complex64','complex math dtype 3')
 assert(list_same(r:tolist(),{np.complex(1.0,0.0),np.complex(0.14384238421916962,1.7380133867263794),np.complex(0.5,-0.0),np.complex(1.8173539638519287,0.5502505302429199),np.complex(0.0,-0.0),np.complex(2.9524550437927246,0.846752941608429),np.complex(1.7380133867263794,0.14384238421916962),np.complex(0.0,-2.8284270763397217),np.complex(2.8298065662384033,0.08834525942802429),np.complex(2.1013033390045166,1.1897377967834473),np.complex(1.0290855169296265,0.24293413758277893)},8e-05),'complex math sqrt 3')
end
do
 local a=np.array({np.complex(0.25,-5.0),np.complex(8.0,-0.0),np.complex(1.0,-0.0),np.complex(-0.0,-5.0),np.complex(0.25,-5.0),np.complex(0.0,-1.0),np.complex(-3.0,0.5),np.complex(1.0,0.0),np.complex(-3.0,2.0),np.complex(0.25,0.5),np.complex(-8.0,0.5)},np.complex64)
 local r=np.sqrt(a)
 assert(r.dtype=='complex64','complex math dtype 4')
 assert(list_same(r:tolist(),{np.complex(1.621148705482483,-1.542116403579712),np.complex(2.8284270763397217,-0.0),np.complex(1.0,-0.0),np.complex(1.5811388492584229,-1.5811388492584229),np.complex(1.621148705482483,-1.542116403579712),np.complex(0.7071067690849304,-0.7071067690849304),np.complex(0.14384238421916962,1.7380133867263794),np.complex(1.0,0.0),np.complex(0.5502505302429199,1.8173539638519287),np.complex(0.6360098123550415,0.39307570457458496),np.complex(0.08834525942802429,2.8298065662384033)},8e-05),'complex math sqrt 4')
end
do
 local a=np.array({np.complex(1.0,2.0),np.complex(-8.0,0.5),np.complex(-0.0,2.0),np.complex(3.0,0.0),np.complex(-1.0,-1.0),np.complex(3.0,0.5),np.complex(-3.0,0.5),np.complex(0.0,0.5),np.complex(0.25,0.5),np.complex(8.0,-5.0),np.complex(-3.0,-1.0)},np.complex64)
 local r=np.sqrt(a)
 assert(r.dtype=='complex64','complex math dtype 5')
 assert(list_same(r:tolist(),{np.complex(1.272019624710083,0.7861514091491699),np.complex(0.08834525942802429,2.8298065662384033),np.complex(1.0,1.0),np.complex(1.7320507764816284,0.0),np.complex(0.45508983731269836,-1.0986841917037964),np.complex(1.7380133867263794,0.14384238421916962),np.complex(0.14384238421916962,1.7380133867263794),np.complex(0.5,0.5),np.complex(0.6360098123550415,0.39307570457458496),np.complex(2.9524550437927246,-0.846752941608429),np.complex(0.28484877943992615,-1.7553173303604126)},8e-05),'complex math sqrt 5')
end
do
 local a=np.array({np.complex(0.25,-0.0),np.complex(0.0,5.0),np.complex(-8.0,-0.0),np.complex(-1.0,-1.0),np.complex(0.0,0.0),np.complex(-0.0,5.0),np.complex(3.0,-0.0),np.complex(1.0,0.5),np.complex(3.0,5.0),np.complex(0.0,0.0),np.complex(-8.0,2.0)},np.complex64)
 local r=np.sqrt(a)
 assert(r.dtype=='complex64','complex math dtype 6')
 assert(list_same(r:tolist(),{np.complex(0.5,-0.0),np.complex(1.5811388492584229,1.5811388492584229),np.complex(0.0,-2.8284270763397217),np.complex(0.45508983731269836,-1.0986841917037964),np.complex(0.0,0.0),np.complex(1.5811388492584229,1.5811388492584229),np.complex(1.7320507764816284,-0.0),np.complex(1.0290855169296265,0.24293413758277893),np.complex(2.1013033390045166,1.1897377967834473),np.complex(0.0,0.0),np.complex(0.35086411237716675,2.8501062393188477)},8e-05),'complex math sqrt 6')
end
do
 local a=np.array({np.complex(-0.0,-5.0),np.complex(-1.0,2.0),np.complex(1.0,-1.0),np.complex(-8.0,5.0),np.complex(8.0,-0.0),np.complex(0.25,2.0),np.complex(-8.0,0.0),np.complex(-3.0,5.0),np.complex(-0.0,-1.0),np.complex(8.0,2.0),np.complex(-8.0,2.0)},np.complex64)
 local r=np.sqrt(a)
 assert(r.dtype=='complex64','complex math dtype 7')
 assert(list_same(r:tolist(),{np.complex(1.5811388492584229,-1.5811388492584229),np.complex(0.7861514091491699,1.272019624710083),np.complex(1.0986841917037964,-0.45508983731269836),np.complex(0.846752941608429,2.9524550437927246),np.complex(2.8284270763397217,-0.0),np.complex(1.0643224716186523,0.9395648837089539),np.complex(0.0,2.8284270763397217),np.complex(1.1897377967834473,2.1013033390045166),np.complex(0.7071067690849304,-0.7071067690849304),np.complex(2.8501062393188477,0.35086411237716675),np.complex(0.35086411237716675,2.8501062393188477)},8e-05),'complex math sqrt 7')
end
do
 local a=np.array({np.complex(0.0,-0.0),np.complex(3.0,2.0),np.complex(8.0,-5.0),np.complex(8.0,0.5),np.complex(1.0,-5.0),np.complex(-8.0,5.0),np.complex(3.0,-5.0),np.complex(8.0,0.5),np.complex(-3.0,5.0),np.complex(8.0,-1.0),np.complex(-1.0,5.0)},np.complex64)
 local r=np.sqrt(a)
 assert(r.dtype=='complex64','complex math dtype 8')
 assert(list_same(r:tolist(),{np.complex(0.0,-0.0),np.complex(1.8173539638519287,0.5502505302429199),np.complex(2.9524550437927246,-0.846752941608429),np.complex(2.8298065662384033,0.08834525942802429),np.complex(1.7462846040725708,-1.4316108226776123),np.complex(0.846752941608429,2.9524550437927246),np.complex(2.1013033390045166,-1.1897377967834473),np.complex(2.8298065662384033,0.08834525942802429),np.complex(1.1897377967834473,2.1013033390045166),np.complex(2.8339245319366455,-0.1764337718486786),np.complex(1.4316108226776123,1.7462846040725708)},8e-05),'complex math sqrt 8')
end
do
 local a=np.array({np.complex(1.0,5.0),np.complex(-1.0,2.0),np.complex(-8.0,2.0),np.complex(-0.0,0.0),np.complex(-3.0,-1.0),np.complex(8.0,0.0),np.complex(1.0,5.0),np.complex(-8.0,0.5),np.complex(8.0,2.0),np.complex(-3.0,5.0),np.complex(3.0,5.0)},np.complex64)
 local r=np.sqrt(a)
 assert(r.dtype=='complex64','complex math dtype 9')
 assert(list_same(r:tolist(),{np.complex(1.7462846040725708,1.4316108226776123),np.complex(0.7861514091491699,1.272019624710083),np.complex(0.35086411237716675,2.8501062393188477),np.complex(0.0,0.0),np.complex(0.28484877943992615,-1.7553173303604126),np.complex(2.8284270763397217,0.0),np.complex(1.7462846040725708,1.4316108226776123),np.complex(0.08834525942802429,2.8298065662384033),np.complex(2.8501062393188477,0.35086411237716675),np.complex(1.1897377967834473,2.1013033390045166),np.complex(2.1013033390045166,1.1897377967834473)},8e-05),'complex math sqrt 9')
end
do
 local a=np.array({np.complex(-0.0,2.0),np.complex(0.25,0.0),np.complex(-8.0,2.0),np.complex(-3.0,5.0),np.complex(1.0,-5.0),np.complex(0.25,5.0),np.complex(3.0,5.0),np.complex(-1.0,-5.0),np.complex(8.0,5.0),np.complex(0.0,5.0),np.complex(3.0,-0.0)},np.complex64)
 local r=np.sqrt(a)
 assert(r.dtype=='complex64','complex math dtype 10')
 assert(list_same(r:tolist(),{np.complex(1.0,1.0),np.complex(0.5,0.0),np.complex(0.35086411237716675,2.8501062393188477),np.complex(1.1897377967834473,2.1013033390045166),np.complex(1.7462846040725708,-1.4316108226776123),np.complex(1.621148705482483,1.542116403579712),np.complex(2.1013033390045166,1.1897377967834473),np.complex(1.4316108226776123,-1.7462846040725708),np.complex(2.9524550437927246,0.846752941608429),np.complex(1.5811388492584229,1.5811388492584229),np.complex(1.7320507764816284,-0.0)},8e-05),'complex math sqrt 10')
end
do
 local a=np.array({np.complex(1.0,2.0),np.complex(-1.0,0.0),np.complex(3.0,2.0),np.complex(-0.0,-5.0),np.complex(8.0,0.0),np.complex(-3.0,-1.0),np.complex(1.0,-5.0),np.complex(-0.0,-5.0),np.complex(-1.0,-1.0),np.complex(1.0,5.0),np.complex(0.25,-1.0)},np.complex64)
 local r=np.sqrt(a)
 assert(r.dtype=='complex64','complex math dtype 11')
 assert(list_same(r:tolist(),{np.complex(1.272019624710083,0.7861514091491699),np.complex(0.0,1.0),np.complex(1.8173539638519287,0.5502505302429199),np.complex(1.5811388492584229,-1.5811388492584229),np.complex(2.8284270763397217,0.0),np.complex(0.28484877943992615,-1.7553173303604126),np.complex(1.7462846040725708,-1.4316108226776123),np.complex(1.5811388492584229,-1.5811388492584229),np.complex(0.45508983731269836,-1.0986841917037964),np.complex(1.7462846040725708,1.4316108226776123),np.complex(0.8002426028251648,-0.624810516834259)},8e-05),'complex math sqrt 11')
end
do
 local a=np.array({np.complex(0.0,2.0),np.complex(-3.0,0.5),np.complex(1.0,0.0),np.complex(-0.0,-0.0),np.complex(8.0,5.0),np.complex(1.0,-5.0),np.complex(-1.0,0.0),np.complex(-3.0,-0.0),np.complex(-8.0,0.5),np.complex(-3.0,-0.0),np.complex(1.0,5.0)},np.complex64)
 local r=np.sqrt(a)
 assert(r.dtype=='complex64','complex math dtype 12')
 assert(list_same(r:tolist(),{np.complex(1.0,1.0),np.complex(0.14384238421916962,1.7380133867263794),np.complex(1.0,0.0),np.complex(0.0,-0.0),np.complex(2.9524550437927246,0.846752941608429),np.complex(1.7462846040725708,-1.4316108226776123),np.complex(0.0,1.0),np.complex(0.0,-1.7320507764816284),np.complex(0.08834525942802429,2.8298065662384033),np.complex(0.0,-1.7320507764816284),np.complex(1.7462846040725708,1.4316108226776123)},8e-05),'complex math sqrt 12')
end
do
 local a=np.array({np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(-0.0,-0.0),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(0.0,math.huge),np.complex(0.0,-math.huge),np.complex(math.huge,1.0),np.complex(-math.huge,-1.0),np.complex((0/0),0.0),np.complex((0/0),2.0),np.complex(2.0,(0/0)),np.complex((0/0),(0/0))},np.complex64)
 local r=np.exp(a)
 assert(r.dtype=='complex64','complex math dtype 13')
 assert(list_same(r:tolist(),{np.complex(1.0,0.0),np.complex(1.0,0.0),np.complex(1.0,-0.0),np.complex(1.0,-0.0),np.complex(math.huge,0.0),np.complex(0.0,0.0),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex(math.huge,math.huge),np.complex(0.0,-0.0),np.complex((0/0),0.0),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},8e-05),'complex math exp 13')
end
do
 local a=np.array({np.complex(-1.0,-0.0),np.complex(-1.0,0.0),np.complex(3.0,5.0),np.complex(8.0,5.0),np.complex(1.0,-0.0),np.complex(-3.0,0.0),np.complex(-8.0,2.0),np.complex(8.0,0.5),np.complex(-0.0,-5.0),np.complex(1.0,-1.0),np.complex(-3.0,0.5)},np.complex64)
 local r=np.exp(a)
 assert(r.dtype=='complex64','complex math dtype 14')
 assert(list_same(r:tolist(),{np.complex(0.3678794503211975,-0.0),np.complex(0.3678794503211975,0.0),np.complex(5.697507381439209,-19.260509490966797),np.complex(845.5850830078125,-2858.512939453125),np.complex(2.7182817459106445,-0.0),np.complex(0.049787066876888275,0.0),np.complex(-0.00013960171781945974,0.00030503529706038535),np.complex(2616.03662109375,1429.1474609375),np.complex(0.28366219997406006,0.9589242935180664),np.complex(1.4686938524246216,-2.2873551845550537),np.complex(0.04369226098060608,0.023869192227721214)},8e-05),'complex math exp 14')
end
do
 local a=np.array({np.complex(3.0,5.0),np.complex(-3.0,0.0),np.complex(-3.0,0.0),np.complex(0.0,-1.0),np.complex(3.0,-1.0),np.complex(0.25,5.0),np.complex(8.0,0.0),np.complex(8.0,2.0),np.complex(3.0,0.5),np.complex(1.0,-0.0),np.complex(-1.0,2.0)},np.complex64)
 local r=np.exp(a)
 assert(r.dtype=='complex64','complex math dtype 15')
 assert(list_same(r:tolist(),{np.complex(5.697507381439209,-19.260509490966797),np.complex(0.049787066876888275,0.0),np.complex(0.049787066876888275,0.0),np.complex(0.5403022766113281,-0.8414709568023682),np.complex(10.852261543273926,-16.901395797729492),np.complex(0.3642294704914093,-1.231283187866211),np.complex(2980.9580078125,0.0),np.complex(-1240.5162353515625,2710.577392578125),np.complex(17.62671661376953,9.62951946258545),np.complex(2.7182817459106445,-0.0),np.complex(-0.15309187769889832,0.33451181650161743)},8e-05),'complex math exp 15')
end
do
 local a=np.array({np.complex(-1.0,5.0),np.complex(8.0,-5.0),np.complex(1.0,5.0),np.complex(-1.0,-1.0),np.complex(0.0,-1.0),np.complex(0.0,-5.0),np.complex(-1.0,0.5),np.complex(0.25,-5.0),np.complex(-0.0,0.5),np.complex(0.0,-0.0),np.complex(-1.0,2.0)},np.complex64)
 local r=np.exp(a)
 assert(r.dtype=='complex64','complex math dtype 16')
 assert(list_same(r:tolist(),{np.complex(0.10435349494218826,-0.35276854038238525),np.complex(845.5850830078125,2858.512939453125),np.complex(0.7710737586021423,-2.606626510620117),np.complex(0.1987660974264145,-0.3095598816871643),np.complex(0.5403022766113281,-0.8414709568023682),np.complex(0.28366219997406006,0.9589242935180664),np.complex(0.32284459471702576,0.17637081444263458),np.complex(0.3642294704914093,1.231283187866211),np.complex(0.8775825500488281,0.4794255495071411),np.complex(1.0,-0.0),np.complex(-0.15309187769889832,0.33451181650161743)},8e-05),'complex math exp 16')
end
do
 local a=np.array({np.complex(-1.0,0.5),np.complex(3.0,-0.0),np.complex(-1.0,-1.0),np.complex(-1.0,5.0),np.complex(0.25,2.0),np.complex(1.0,0.0),np.complex(1.0,-5.0),np.complex(8.0,0.5),np.complex(8.0,2.0),np.complex(1.0,-0.0),np.complex(1.0,-5.0)},np.complex64)
 local r=np.exp(a)
 assert(r.dtype=='complex64','complex math dtype 17')
 assert(list_same(r:tolist(),{np.complex(0.32284459471702576,0.17637081444263458),np.complex(20.08553695678711,-0.0),np.complex(0.1987660974264145,-0.3095598816871643),np.complex(0.10435349494218826,-0.35276854038238525),np.complex(-0.5343431234359741,1.1675609350204468),np.complex(2.7182817459106445,0.0),np.complex(0.7710737586021423,2.606626510620117),np.complex(2616.03662109375,1429.1474609375),np.complex(-1240.5162353515625,2710.577392578125),np.complex(2.7182817459106445,-0.0),np.complex(0.7710737586021423,2.606626510620117)},8e-05),'complex math exp 17')
end
do
 local a=np.array({np.complex(-3.0,5.0),np.complex(0.0,-5.0),np.complex(8.0,-5.0),np.complex(3.0,5.0),np.complex(1.0,5.0),np.complex(-0.0,-1.0),np.complex(0.25,0.5),np.complex(8.0,0.0),np.complex(3.0,-0.0),np.complex(-1.0,-1.0),np.complex(-1.0,-0.0)},np.complex64)
 local r=np.exp(a)
 assert(r.dtype=='complex64','complex math dtype 18')
 assert(list_same(r:tolist(),{np.complex(0.014122708700597286,-0.047742027789354324),np.complex(0.28366219997406006,0.9589242935180664),np.complex(845.5850830078125,2858.512939453125),np.complex(5.697507381439209,-19.260509490966797),np.complex(0.7710737586021423,-2.606626510620117),np.complex(0.5403022766113281,-0.8414709568023682),np.complex(1.1268383264541626,0.6155946254730225),np.complex(2980.9580078125,0.0),np.complex(20.08553695678711,-0.0),np.complex(0.1987660974264145,-0.3095598816871643),np.complex(0.3678794503211975,-0.0)},8e-05),'complex math exp 18')
end
do
 local a=np.array({np.complex(-3.0,0.0),np.complex(0.0,2.0),np.complex(8.0,0.5),np.complex(-3.0,-5.0),np.complex(0.25,0.5),np.complex(-8.0,0.0),np.complex(0.25,0.0),np.complex(1.0,-0.0),np.complex(8.0,5.0),np.complex(0.0,0.0),np.complex(-3.0,0.5)},np.complex64)
 local r=np.exp(a)
 assert(r.dtype=='complex64','complex math dtype 19')
 assert(list_same(r:tolist(),{np.complex(0.049787066876888275,0.0),np.complex(-0.416146844625473,0.9092974066734314),np.complex(2616.03662109375,1429.1474609375),np.complex(0.014122708700597286,0.047742027789354324),np.complex(1.1268383264541626,0.6155946254730225),np.complex(0.000335462624207139,0.0),np.complex(1.2840254306793213,0.0),np.complex(2.7182817459106445,-0.0),np.complex(845.5850830078125,-2858.512939453125),np.complex(1.0,0.0),np.complex(0.04369226098060608,0.023869192227721214)},8e-05),'complex math exp 19')
end
do
 local a=np.array({np.complex(8.0,5.0),np.complex(8.0,0.0),np.complex(-8.0,-5.0),np.complex(0.25,2.0),np.complex(-0.0,2.0),np.complex(-8.0,5.0),np.complex(1.0,5.0),np.complex(3.0,0.0),np.complex(0.0,5.0),np.complex(-8.0,0.5),np.complex(8.0,2.0)},np.complex64)
 local r=np.exp(a)
 assert(r.dtype=='complex64','complex math dtype 20')
 assert(list_same(r:tolist(),{np.complex(845.5850830078125,-2858.512939453125),np.complex(2980.9580078125,0.0),np.complex(9.515806596027687e-05,0.00032168327015824616),np.complex(-0.5343431234359741,1.1675609350204468),np.complex(-0.416146844625473,0.9092974066734314),np.complex(9.515806596027687e-05,-0.00032168327015824616),np.complex(0.7710737586021423,-2.606626510620117),np.complex(20.08553695678711,0.0),np.complex(0.28366219997406006,-0.9589242935180664),np.complex(0.0002943961590062827,0.00016082935326267034),np.complex(-1240.5162353515625,2710.577392578125)},8e-05),'complex math exp 20')
end
do
 local a=np.array({np.complex(0.25,-0.0),np.complex(8.0,5.0),np.complex(-8.0,5.0),np.complex(0.25,2.0),np.complex(1.0,-5.0),np.complex(1.0,-1.0),np.complex(0.0,0.5),np.complex(3.0,0.5),np.complex(-8.0,-1.0),np.complex(0.0,-5.0),np.complex(-0.0,0.5)},np.complex64)
 local r=np.exp(a)
 assert(r.dtype=='complex64','complex math dtype 21')
 assert(list_same(r:tolist(),{np.complex(1.2840254306793213,-0.0),np.complex(845.5850830078125,-2858.512939453125),np.complex(9.515806596027687e-05,-0.00032168327015824616),np.complex(-0.5343431234359741,1.1675609350204468),np.complex(0.7710737586021423,2.606626510620117),np.complex(1.4686938524246216,-2.2873551845550537),np.complex(0.8775825500488281,0.4794255495071411),np.complex(17.62671661376953,9.62951946258545),np.complex(0.0001812512200558558,-0.0002822820679284632),np.complex(0.28366219997406006,0.9589242935180664),np.complex(0.8775825500488281,0.4794255495071411)},8e-05),'complex math exp 21')
end
do
 local a=np.array({np.complex(-1.0,5.0),np.complex(-0.0,5.0),np.complex(-1.0,-5.0),np.complex(-3.0,2.0),np.complex(1.0,2.0),np.complex(1.0,5.0),np.complex(0.0,-1.0),np.complex(8.0,-5.0),np.complex(-1.0,0.5),np.complex(-3.0,5.0),np.complex(8.0,5.0)},np.complex64)
 local r=np.exp(a)
 assert(r.dtype=='complex64','complex math dtype 22')
 assert(list_same(r:tolist(),{np.complex(0.10435349494218826,-0.35276854038238525),np.complex(0.28366219997406006,-0.9589242935180664),np.complex(0.10435349494218826,0.35276854038238525),np.complex(-0.020718730986118317,0.04527125135064125),np.complex(-1.13120436668396,2.471726655960083),np.complex(0.7710737586021423,-2.606626510620117),np.complex(0.5403022766113281,-0.8414709568023682),np.complex(845.5850830078125,2858.512939453125),np.complex(0.32284459471702576,0.17637081444263458),np.complex(0.014122708700597286,-0.047742027789354324),np.complex(845.5850830078125,-2858.512939453125)},8e-05),'complex math exp 22')
end
do
 local a=np.array({np.complex(0.25,2.0),np.complex(-1.0,0.0),np.complex(-1.0,5.0),np.complex(1.0,5.0),np.complex(1.0,-1.0),np.complex(-0.0,2.0),np.complex(0.25,-1.0),np.complex(0.0,2.0),np.complex(-1.0,0.0),np.complex(0.0,-5.0),np.complex(0.0,0.0)},np.complex64)
 local r=np.exp(a)
 assert(r.dtype=='complex64','complex math dtype 23')
 assert(list_same(r:tolist(),{np.complex(-0.5343431234359741,1.1675609350204468),np.complex(0.3678794503211975,0.0),np.complex(0.10435349494218826,-0.35276854038238525),np.complex(0.7710737586021423,-2.606626510620117),np.complex(1.4686938524246216,-2.2873551845550537),np.complex(-0.416146844625473,0.9092974066734314),np.complex(0.6937618851661682,-1.080470085144043),np.complex(-0.416146844625473,0.9092974066734314),np.complex(0.3678794503211975,0.0),np.complex(0.28366219997406006,0.9589242935180664),np.complex(1.0,0.0)},8e-05),'complex math exp 23')
end
do
 local a=np.array({np.complex(0.0,-5.0),np.complex(0.0,-1.0),np.complex(0.0,-5.0),np.complex(1.0,0.5),np.complex(-8.0,2.0),np.complex(1.0,-5.0),np.complex(-1.0,2.0),np.complex(-3.0,0.5),np.complex(3.0,0.0),np.complex(0.25,-1.0),np.complex(-1.0,-0.0)},np.complex64)
 local r=np.exp(a)
 assert(r.dtype=='complex64','complex math dtype 24')
 assert(list_same(r:tolist(),{np.complex(0.28366219997406006,0.9589242935180664),np.complex(0.5403022766113281,-0.8414709568023682),np.complex(0.28366219997406006,0.9589242935180664),np.complex(2.38551664352417,1.3032137155532837),np.complex(-0.00013960171781945974,0.00030503529706038535),np.complex(0.7710737586021423,2.606626510620117),np.complex(-0.15309187769889832,0.33451181650161743),np.complex(0.04369226098060608,0.023869192227721214),np.complex(20.08553695678711,0.0),np.complex(0.6937618851661682,-1.080470085144043),np.complex(0.3678794503211975,-0.0)},8e-05),'complex math exp 24')
end
do
 local a=np.array({np.complex(0.25,-5.0),np.complex(-3.0,-0.0),np.complex(-8.0,0.5),np.complex(-3.0,0.0),np.complex(8.0,-1.0),np.complex(-8.0,0.5),np.complex(-1.0,2.0),np.complex(1.0,0.0),np.complex(-3.0,-0.0),np.complex(8.0,-5.0),np.complex(0.0,2.0)},np.complex64)
 local r=np.exp(a)
 assert(r.dtype=='complex64','complex math dtype 25')
 assert(list_same(r:tolist(),{np.complex(0.3642294704914093,1.231283187866211),np.complex(0.049787066876888275,-0.0),np.complex(0.0002943961590062827,0.00016082935326267034),np.complex(0.049787066876888275,0.0),np.complex(1610.618408203125,-2508.3896484375),np.complex(0.0002943961590062827,0.00016082935326267034),np.complex(-0.15309187769889832,0.33451181650161743),np.complex(2.7182817459106445,0.0),np.complex(0.049787066876888275,-0.0),np.complex(845.5850830078125,2858.512939453125),np.complex(-0.416146844625473,0.9092974066734314)},8e-05),'complex math exp 25')
end
do
 local a=np.array({np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(-0.0,-0.0),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(0.0,math.huge),np.complex(0.0,-math.huge),np.complex(math.huge,1.0),np.complex(-math.huge,-1.0),np.complex((0/0),0.0),np.complex((0/0),2.0),np.complex(2.0,(0/0)),np.complex((0/0),(0/0))},np.complex64)
 local r=np.log(a)
 assert(r.dtype=='complex64','complex math dtype 26')
 assert(list_same(r:tolist(),{np.complex(-math.huge,0.0),np.complex(-math.huge,3.1415927410125732),np.complex(-math.huge,-0.0),np.complex(-math.huge,-3.1415927410125732),np.complex(math.huge,0.0),np.complex(math.huge,3.1415927410125732),np.complex(math.huge,1.5707963705062866),np.complex(math.huge,-1.5707963705062866),np.complex(math.huge,0.0),np.complex(math.huge,-3.1415927410125732),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},8e-05),'complex math log 26')
end
do
 local a=np.array({np.complex(3.0,0.0),np.complex(-0.0,5.0),np.complex(8.0,5.0),np.complex(-1.0,0.0),np.complex(-1.0,-5.0),np.complex(8.0,0.0),np.complex(-3.0,-0.0),np.complex(8.0,5.0),np.complex(0.25,-0.0),np.complex(-0.0,0.0),np.complex(-0.0,-1.0)},np.complex64)
 local r=np.log(a)
 assert(r.dtype=='complex64','complex math dtype 27')
 assert(list_same(r:tolist(),{np.complex(1.0986123085021973,0.0),np.complex(1.6094379425048828,1.5707963705062866),np.complex(2.2443182468414307,0.5585992932319641),np.complex(0.0,3.1415927410125732),np.complex(1.629048228263855,-1.768191933631897),np.complex(2.079441547393799,0.0),np.complex(1.0986123085021973,-3.1415927410125732),np.complex(2.2443182468414307,0.5585992932319641),np.complex(-1.3862943649291992,-0.0),np.complex(-math.huge,3.1415927410125732),np.complex(0.0,-1.5707963705062866)},8e-05),'complex math log 27')
end
do
 local a=np.array({np.complex(1.0,0.0),np.complex(0.0,5.0),np.complex(8.0,5.0),np.complex(-3.0,-0.0),np.complex(3.0,-0.0),np.complex(-3.0,-0.0),np.complex(-3.0,5.0),np.complex(-1.0,2.0),np.complex(0.25,0.5),np.complex(-8.0,-1.0),np.complex(1.0,-0.0)},np.complex64)
 local r=np.log(a)
 assert(r.dtype=='complex64','complex math dtype 28')
 assert(list_same(r:tolist(),{np.complex(0.0,0.0),np.complex(1.6094379425048828,1.5707963705062866),np.complex(2.2443182468414307,0.5585992932319641),np.complex(1.0986123085021973,-3.1415927410125732),np.complex(1.0986123085021973,-0.0),np.complex(1.0986123085021973,-3.1415927410125732),np.complex(1.7631802558898926,2.111215829849243),np.complex(0.8047189712524414,2.0344438552856445),np.complex(-0.5815753936767578,1.1071487665176392),np.complex(2.087193727493286,-3.017237663269043),np.complex(0.0,-0.0)},8e-05),'complex math log 28')
end
do
 local a=np.array({np.complex(-1.0,5.0),np.complex(-3.0,-0.0),np.complex(0.25,-0.0),np.complex(1.0,2.0),np.complex(0.0,2.0),np.complex(-8.0,5.0),np.complex(-1.0,0.0),np.complex(0.0,5.0),np.complex(1.0,5.0),np.complex(-3.0,2.0),np.complex(-3.0,2.0)},np.complex64)
 local r=np.log(a)
 assert(r.dtype=='complex64','complex math dtype 29')
 assert(list_same(r:tolist(),{np.complex(1.629048228263855,1.768191933631897),np.complex(1.0986123085021973,-3.1415927410125732),np.complex(-1.3862943649291992,-0.0),np.complex(0.8047189712524414,1.1071487665176392),np.complex(0.6931471824645996,1.5707963705062866),np.complex(2.2443182468414307,2.582993268966675),np.complex(0.0,3.1415927410125732),np.complex(1.6094379425048828,1.5707963705062866),np.complex(1.629048228263855,1.3734008073806763),np.complex(1.2824746370315552,2.5535900592803955),np.complex(1.2824746370315552,2.5535900592803955)},8e-05),'complex math log 29')
end
do
 local a=np.array({np.complex(3.0,5.0),np.complex(8.0,-5.0),np.complex(3.0,-1.0),np.complex(0.0,0.5),np.complex(-1.0,-0.0),np.complex(-3.0,-1.0),np.complex(-3.0,-0.0),np.complex(-3.0,-0.0),np.complex(0.0,-5.0),np.complex(0.25,0.5),np.complex(3.0,5.0)},np.complex64)
 local r=np.log(a)
 assert(r.dtype=='complex64','complex math dtype 30')
 assert(list_same(r:tolist(),{np.complex(1.7631802558898926,1.0303767919540405),np.complex(2.2443182468414307,-0.5585992932319641),np.complex(1.1512925624847412,-0.32175055146217346),np.complex(-0.6931471824645996,1.5707963705062866),np.complex(0.0,-3.1415927410125732),np.complex(1.1512925624847412,-2.8198421001434326),np.complex(1.0986123085021973,-3.1415927410125732),np.complex(1.0986123085021973,-3.1415927410125732),np.complex(1.6094379425048828,-1.5707963705062866),np.complex(-0.5815753936767578,1.1071487665176392),np.complex(1.7631802558898926,1.0303767919540405)},8e-05),'complex math log 30')
end
do
 local a=np.array({np.complex(0.25,0.0),np.complex(8.0,2.0),np.complex(3.0,-5.0),np.complex(-1.0,5.0),np.complex(-8.0,-1.0),np.complex(-1.0,0.0),np.complex(-8.0,0.5),np.complex(-0.0,0.5),np.complex(-3.0,0.0),np.complex(-8.0,0.5),np.complex(1.0,-1.0)},np.complex64)
 local r=np.log(a)
 assert(r.dtype=='complex64','complex math dtype 31')
 assert(list_same(r:tolist(),{np.complex(-1.3862943649291992,0.0),np.complex(2.1097538471221924,0.244978666305542),np.complex(1.7631802558898926,-1.0303767919540405),np.complex(1.629048228263855,1.768191933631897),np.complex(2.087193727493286,-3.017237663269043),np.complex(0.0,3.1415927410125732),np.complex(2.081390857696533,3.0791738033294678),np.complex(-0.6931471824645996,1.5707963705062866),np.complex(1.0986123085021973,3.1415927410125732),np.complex(2.081390857696533,3.0791738033294678),np.complex(0.3465735912322998,-0.7853981852531433)},8e-05),'complex math log 31')
end
do
 local a=np.array({np.complex(-1.0,0.0),np.complex(-8.0,2.0),np.complex(-3.0,2.0),np.complex(-8.0,-1.0),np.complex(0.25,0.0),np.complex(-8.0,0.5),np.complex(0.25,-0.0),np.complex(-0.0,-1.0),np.complex(0.0,2.0),np.complex(3.0,0.5),np.complex(3.0,2.0)},np.complex64)
 local r=np.log(a)
 assert(r.dtype=='complex64','complex math dtype 32')
 assert(list_same(r:tolist(),{np.complex(0.0,3.1415927410125732),np.complex(2.1097538471221924,2.8966140747070312),np.complex(1.2824746370315552,2.5535900592803955),np.complex(2.087193727493286,-3.017237663269043),np.complex(-1.3862943649291992,0.0),np.complex(2.081390857696533,3.0791738033294678),np.complex(-1.3862943649291992,-0.0),np.complex(0.0,-1.5707963705062866),np.complex(0.6931471824645996,1.5707963705062866),np.complex(1.112311840057373,0.16514867544174194),np.complex(1.2824746370315552,0.588002622127533)},8e-05),'complex math log 32')
end
do
 local a=np.array({np.complex(-1.0,5.0),np.complex(-0.0,-5.0),np.complex(3.0,-5.0),np.complex(0.25,-0.0),np.complex(3.0,0.0),np.complex(8.0,0.5),np.complex(8.0,0.5),np.complex(3.0,-5.0),np.complex(-1.0,-0.0),np.complex(-3.0,-0.0),np.complex(-3.0,-5.0)},np.complex64)
 local r=np.log(a)
 assert(r.dtype=='complex64','complex math dtype 33')
 assert(list_same(r:tolist(),{np.complex(1.629048228263855,1.768191933631897),np.complex(1.6094379425048828,-1.5707963705062866),np.complex(1.7631802558898926,-1.0303767919540405),np.complex(-1.3862943649291992,-0.0),np.complex(1.0986123085021973,0.0),np.complex(2.081390857696533,0.06241881102323532),np.complex(2.081390857696533,0.06241881102323532),np.complex(1.7631802558898926,-1.0303767919540405),np.complex(0.0,-3.1415927410125732),np.complex(1.0986123085021973,-3.1415927410125732),np.complex(1.7631802558898926,-2.111215829849243)},8e-05),'complex math log 33')
end
do
 local a=np.array({np.complex(-8.0,-0.0),np.complex(0.25,-5.0),np.complex(-0.0,5.0),np.complex(0.0,-5.0),np.complex(-3.0,0.5),np.complex(-1.0,0.5),np.complex(-8.0,-5.0),np.complex(0.0,-0.0),np.complex(1.0,-0.0),np.complex(-0.0,0.0),np.complex(-8.0,-5.0)},np.complex64)
 local r=np.log(a)
 assert(r.dtype=='complex64','complex math dtype 34')
 assert(list_same(r:tolist(),{np.complex(2.079441547393799,-3.1415927410125732),np.complex(1.6106863021850586,-1.5208379030227661),np.complex(1.6094379425048828,1.5707963705062866),np.complex(1.6094379425048828,-1.5707963705062866),np.complex(1.112311840057373,2.9764440059661865),np.complex(0.1115717738866806,2.677945137023926),np.complex(2.2443182468414307,-2.582993268966675),np.complex(-math.huge,-0.0),np.complex(0.0,-0.0),np.complex(-math.huge,3.1415927410125732),np.complex(2.2443182468414307,-2.582993268966675)},8e-05),'complex math log 34')
end
do
 local a=np.array({np.complex(-0.0,-0.0),np.complex(0.25,-0.0),np.complex(3.0,5.0),np.complex(-0.0,5.0),np.complex(-3.0,2.0),np.complex(-8.0,-5.0),np.complex(-0.0,2.0),np.complex(-0.0,-1.0),np.complex(8.0,-1.0),np.complex(1.0,0.5),np.complex(-3.0,0.0)},np.complex64)
 local r=np.log(a)
 assert(r.dtype=='complex64','complex math dtype 35')
 assert(list_same(r:tolist(),{np.complex(-math.huge,-3.1415927410125732),np.complex(-1.3862943649291992,-0.0),np.complex(1.7631802558898926,1.0303767919540405),np.complex(1.6094379425048828,1.5707963705062866),np.complex(1.2824746370315552,2.5535900592803955),np.complex(2.2443182468414307,-2.582993268966675),np.complex(0.6931471824645996,1.5707963705062866),np.complex(0.0,-1.5707963705062866),np.complex(2.087193727493286,-0.12435499578714371),np.complex(0.1115717738866806,0.46364760398864746),np.complex(1.0986123085021973,3.1415927410125732)},8e-05),'complex math log 35')
end
do
 local a=np.array({np.complex(-0.0,-1.0),np.complex(1.0,0.5),np.complex(-3.0,5.0),np.complex(8.0,0.5),np.complex(-0.0,-0.0),np.complex(-1.0,0.0),np.complex(0.0,-0.0),np.complex(-3.0,0.0),np.complex(1.0,5.0),np.complex(0.0,2.0),np.complex(-1.0,-5.0)},np.complex64)
 local r=np.log(a)
 assert(r.dtype=='complex64','complex math dtype 36')
 assert(list_same(r:tolist(),{np.complex(0.0,-1.5707963705062866),np.complex(0.1115717738866806,0.46364760398864746),np.complex(1.7631802558898926,2.111215829849243),np.complex(2.081390857696533,0.06241881102323532),np.complex(-math.huge,-3.1415927410125732),np.complex(0.0,3.1415927410125732),np.complex(-math.huge,-0.0),np.complex(1.0986123085021973,3.1415927410125732),np.complex(1.629048228263855,1.3734008073806763),np.complex(0.6931471824645996,1.5707963705062866),np.complex(1.629048228263855,-1.768191933631897)},8e-05),'complex math log 36')
end
do
 local a=np.array({np.complex(3.0,0.0),np.complex(-8.0,0.5),np.complex(0.25,0.0),np.complex(-3.0,-0.0),np.complex(8.0,0.0),np.complex(-1.0,-1.0),np.complex(1.0,2.0),np.complex(1.0,0.5),np.complex(0.25,0.5),np.complex(0.0,0.0),np.complex(8.0,-5.0)},np.complex64)
 local r=np.log(a)
 assert(r.dtype=='complex64','complex math dtype 37')
 assert(list_same(r:tolist(),{np.complex(1.0986123085021973,0.0),np.complex(2.081390857696533,3.0791738033294678),np.complex(-1.3862943649291992,0.0),np.complex(1.0986123085021973,-3.1415927410125732),np.complex(2.079441547393799,0.0),np.complex(0.3465735912322998,-2.356194496154785),np.complex(0.8047189712524414,1.1071487665176392),np.complex(0.1115717738866806,0.46364760398864746),np.complex(-0.5815753936767578,1.1071487665176392),np.complex(-math.huge,0.0),np.complex(2.2443182468414307,-0.5585992932319641)},8e-05),'complex math log 37')
end
do
 local a=np.array({np.complex(8.0,-1.0),np.complex(1.0,0.5),np.complex(0.0,-5.0),np.complex(-0.0,0.5),np.complex(0.25,5.0),np.complex(0.0,2.0),np.complex(8.0,0.0),np.complex(-8.0,-1.0),np.complex(8.0,0.5),np.complex(-8.0,-1.0),np.complex(-8.0,-5.0)},np.complex64)
 local r=np.log(a)
 assert(r.dtype=='complex64','complex math dtype 38')
 assert(list_same(r:tolist(),{np.complex(2.087193727493286,-0.12435499578714371),np.complex(0.1115717738866806,0.46364760398864746),np.complex(1.6094379425048828,-1.5707963705062866),np.complex(-0.6931471824645996,1.5707963705062866),np.complex(1.6106863021850586,1.5208379030227661),np.complex(0.6931471824645996,1.5707963705062866),np.complex(2.079441547393799,0.0),np.complex(2.087193727493286,-3.017237663269043),np.complex(2.081390857696533,0.06241881102323532),np.complex(2.087193727493286,-3.017237663269043),np.complex(2.2443182468414307,-2.582993268966675)},8e-05),'complex math log 38')
end
do
 local a=np.array({np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(-0.0,-0.0),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(0.0,math.huge),np.complex(0.0,-math.huge),np.complex(math.huge,1.0),np.complex(-math.huge,-1.0),np.complex((0/0),0.0),np.complex((0/0),2.0),np.complex(2.0,(0/0)),np.complex((0/0),(0/0))},np.complex64)
 local r=np.sin(a)
 assert(r.dtype=='complex64','complex math dtype 39')
 assert(list_same(r:tolist(),{np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(-0.0,-0.0),np.complex((0/0),0.0),np.complex((0/0),0.0),np.complex(0.0,math.huge),np.complex(0.0,-math.huge),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),0.0),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},8e-05),'complex math sin 39')
end
do
 local a=np.array({np.complex(3.0,0.5),np.complex(8.0,5.0),np.complex(0.0,2.0),np.complex(-8.0,0.0),np.complex(-1.0,0.5),np.complex(0.0,-1.0),np.complex(-0.0,-5.0),np.complex(-8.0,-5.0),np.complex(1.0,5.0),np.complex(1.0,2.0),np.complex(1.0,2.0)},np.complex64)
 local r=np.sin(a)
 assert(r.dtype=='complex64','complex math dtype 40')
 assert(list_same(r:tolist(),{np.complex(0.15913057327270508,-0.5158804059028625),np.complex(73.42021942138672,-10.79656982421875),np.complex(0.0,3.6268603801727295),np.complex(-0.9893582463264465,-0.0),np.complex(-0.9488644599914551,0.28154897689819336),np.complex(0.0,-1.175201177597046),np.complex(-0.0,-74.20320892333984),np.complex(-73.42021942138672,10.79656982421875),np.complex(62.44551467895508,40.0921630859375),np.complex(3.165778398513794,1.9596009254455566),np.complex(3.165778398513794,1.9596009254455566)},8e-05),'complex math sin 40')
end
do
 local a=np.array({np.complex(-8.0,-1.0),np.complex(0.0,-1.0),np.complex(0.25,0.5),np.complex(-8.0,-1.0),np.complex(-1.0,0.5),np.complex(3.0,-0.0),np.complex(-0.0,5.0),np.complex(-1.0,2.0),np.complex(8.0,-0.0),np.complex(-0.0,-0.0),np.complex(-0.0,0.5)},np.complex64)
 local r=np.sin(a)
 assert(r.dtype=='complex64','complex math dtype 41')
 assert(list_same(r:tolist(),{np.complex(-1.526659607887268,0.17099180817604065),np.complex(0.0,-1.175201177597046),np.complex(0.2789791226387024,0.5048956871032715),np.complex(-1.526659607887268,0.17099180817604065),np.complex(-0.9488644599914551,0.28154897689819336),np.complex(0.14112000167369843,0.0),np.complex(-0.0,74.20320892333984),np.complex(-3.165778398513794,1.9596009254455566),np.complex(0.9893582463264465,0.0),np.complex(-0.0,-0.0),np.complex(-0.0,0.5210952758789062)},8e-05),'complex math sin 41')
end
do
 local a=np.array({np.complex(0.25,0.5),np.complex(-0.0,0.0),np.complex(-1.0,-1.0),np.complex(-0.0,0.0),np.complex(0.25,-0.0),np.complex(0.25,-5.0),np.complex(0.25,0.0),np.complex(-3.0,0.5),np.complex(-3.0,-1.0),np.complex(-0.0,0.5),np.complex(-0.0,0.0)},np.complex64)
 local r=np.sin(a)
 assert(r.dtype=='complex64','complex math dtype 42')
 assert(list_same(r:tolist(),{np.complex(0.2789791226387024,0.5048956871032715),np.complex(-0.0,0.0),np.complex(-1.2984576225280762,-0.634963870048523),np.complex(-0.0,0.0),np.complex(0.24740396440029144,-0.0),np.complex(18.359834671020508,-71.89640808105469),np.complex(0.24740396440029144,0.0),np.complex(-0.15913057327270508,-0.5158804059028625),np.complex(-0.21775954961776733,1.1634403467178345),np.complex(-0.0,0.5210952758789062),np.complex(-0.0,0.0)},8e-05),'complex math sin 42')
end
do
 local a=np.array({np.complex(1.0,5.0),np.complex(3.0,-1.0),np.complex(-8.0,-0.0),np.complex(-1.0,-0.0),np.complex(8.0,-5.0),np.complex(3.0,-0.0),np.complex(-3.0,5.0),np.complex(0.25,-5.0),np.complex(1.0,-1.0),np.complex(0.25,0.0),np.complex(-1.0,-1.0)},np.complex64)
 local r=np.sin(a)
 assert(r.dtype=='complex64','complex math dtype 43')
 assert(list_same(r:tolist(),{np.complex(62.44551467895508,40.0921630859375),np.complex(0.21775954961776733,1.1634403467178345),np.complex(-0.9893582463264465,0.0),np.complex(-0.8414709568023682,-0.0),np.complex(73.42021942138672,10.79656982421875),np.complex(0.14112000167369843,0.0),np.complex(-10.47250747680664,-73.46061706542969),np.complex(18.359834671020508,-71.89640808105469),np.complex(1.2984576225280762,-0.634963870048523),np.complex(0.24740396440029144,0.0),np.complex(-1.2984576225280762,-0.634963870048523)},8e-05),'complex math sin 43')
end
do
 local a=np.array({np.complex(8.0,0.0),np.complex(1.0,0.0),np.complex(8.0,-0.0),np.complex(0.0,0.0),np.complex(-8.0,-0.0),np.complex(-0.0,0.0),np.complex(3.0,-1.0),np.complex(-1.0,2.0),np.complex(-0.0,0.5),np.complex(8.0,2.0),np.complex(-0.0,-5.0)},np.complex64)
 local r=np.sin(a)
 assert(r.dtype=='complex64','complex math dtype 44')
 assert(list_same(r:tolist(),{np.complex(0.9893582463264465,-0.0),np.complex(0.8414709568023682,0.0),np.complex(0.9893582463264465,0.0),np.complex(0.0,0.0),np.complex(-0.9893582463264465,0.0),np.complex(-0.0,0.0),np.complex(0.21775954961776733,1.1634403467178345),np.complex(-3.165778398513794,1.9596009254455566),np.complex(-0.0,0.5210952758789062),np.complex(3.7221591472625732,-0.5277082920074463),np.complex(-0.0,-74.20320892333984)},8e-05),'complex math sin 44')
end
do
 local a=np.array({np.complex(1.0,2.0),np.complex(-8.0,2.0),np.complex(0.25,0.5),np.complex(-8.0,-0.0),np.complex(3.0,0.5),np.complex(0.0,-0.0),np.complex(-3.0,0.5),np.complex(-1.0,0.5),np.complex(-1.0,-0.0),np.complex(-1.0,0.0),np.complex(1.0,-1.0)},np.complex64)
 local r=np.sin(a)
 assert(r.dtype=='complex64','complex math dtype 45')
 assert(list_same(r:tolist(),{np.complex(3.165778398513794,1.9596009254455566),np.complex(-3.7221591472625732,-0.5277082920074463),np.complex(0.2789791226387024,0.5048956871032715),np.complex(-0.9893582463264465,0.0),np.complex(0.15913057327270508,-0.5158804059028625),np.complex(0.0,-0.0),np.complex(-0.15913057327270508,-0.5158804059028625),np.complex(-0.9488644599914551,0.28154897689819336),np.complex(-0.8414709568023682,-0.0),np.complex(-0.8414709568023682,0.0),np.complex(1.2984576225280762,-0.634963870048523)},8e-05),'complex math sin 45')
end
do
 local a=np.array({np.complex(3.0,-5.0),np.complex(-1.0,0.0),np.complex(-3.0,-1.0),np.complex(-0.0,0.0),np.complex(-3.0,-1.0),np.complex(0.0,-5.0),np.complex(1.0,-0.0),np.complex(-0.0,2.0),np.complex(3.0,-5.0),np.complex(1.0,0.0),np.complex(8.0,0.5)},np.complex64)
 local r=np.sin(a)
 assert(r.dtype=='complex64','complex math dtype 46')
 assert(list_same(r:tolist(),{np.complex(10.47250747680664,73.46061706542969),np.complex(-0.8414709568023682,0.0),np.complex(-0.21775954961776733,1.1634403467178345),np.complex(-0.0,0.0),np.complex(-0.21775954961776733,1.1634403467178345),np.complex(0.0,-74.20320892333984),np.complex(0.8414709568023682,-0.0),np.complex(-0.0,3.6268603801727295),np.complex(10.47250747680664,73.46061706542969),np.complex(0.8414709568023682,0.0),np.complex(1.1156259775161743,-0.07581938058137894)},8e-05),'complex math sin 46')
end
do
 local a=np.array({np.complex(-8.0,0.0),np.complex(-0.0,-5.0),np.complex(-1.0,-1.0),np.complex(8.0,-0.0),np.complex(1.0,0.5),np.complex(8.0,0.0),np.complex(-0.0,2.0),np.complex(0.25,5.0),np.complex(0.0,5.0),np.complex(3.0,0.5),np.complex(1.0,0.5)},np.complex64)
 local r=np.sin(a)
 assert(r.dtype=='complex64','complex math dtype 47')
 assert(list_same(r:tolist(),{np.complex(-0.9893582463264465,-0.0),np.complex(-0.0,-74.20320892333984),np.complex(-1.2984576225280762,-0.634963870048523),np.complex(0.9893582463264465,0.0),np.complex(0.9488644599914551,0.28154897689819336),np.complex(0.9893582463264465,-0.0),np.complex(-0.0,3.6268603801727295),np.complex(18.359834671020508,71.89640808105469),np.complex(0.0,74.20320892333984),np.complex(0.15913057327270508,-0.5158804059028625),np.complex(0.9488644599914551,0.28154897689819336)},8e-05),'complex math sin 47')
end
do
 local a=np.array({np.complex(8.0,2.0),np.complex(-0.0,0.0),np.complex(1.0,2.0),np.complex(8.0,5.0),np.complex(-1.0,0.0),np.complex(-1.0,2.0),np.complex(1.0,5.0),np.complex(-0.0,5.0),np.complex(0.0,2.0),np.complex(1.0,0.0),np.complex(-8.0,0.5)},np.complex64)
 local r=np.sin(a)
 assert(r.dtype=='complex64','complex math dtype 48')
 assert(list_same(r:tolist(),{np.complex(3.7221591472625732,-0.5277082920074463),np.complex(-0.0,0.0),np.complex(3.165778398513794,1.9596009254455566),np.complex(73.42021942138672,-10.79656982421875),np.complex(-0.8414709568023682,0.0),np.complex(-3.165778398513794,1.9596009254455566),np.complex(62.44551467895508,40.0921630859375),np.complex(-0.0,74.20320892333984),np.complex(0.0,3.6268603801727295),np.complex(0.8414709568023682,0.0),np.complex(-1.1156259775161743,-0.07581938058137894)},8e-05),'complex math sin 48')
end
do
 local a=np.array({np.complex(0.0,0.5),np.complex(1.0,2.0),np.complex(-8.0,0.5),np.complex(3.0,-0.0),np.complex(3.0,2.0),np.complex(-8.0,0.5),np.complex(-3.0,-1.0),np.complex(3.0,2.0),np.complex(8.0,-0.0),np.complex(-1.0,5.0),np.complex(-1.0,5.0)},np.complex64)
 local r=np.sin(a)
 assert(r.dtype=='complex64','complex math dtype 49')
 assert(list_same(r:tolist(),{np.complex(0.0,0.5210952758789062),np.complex(3.165778398513794,1.9596009254455566),np.complex(-1.1156259775161743,-0.07581938058137894),np.complex(0.14112000167369843,0.0),np.complex(0.5309210419654846,-3.590564489364624),np.complex(-1.1156259775161743,-0.07581938058137894),np.complex(-0.21775954961776733,1.1634403467178345),np.complex(0.5309210419654846,-3.590564489364624),np.complex(0.9893582463264465,0.0),np.complex(-62.44551467895508,40.0921630859375),np.complex(-62.44551467895508,40.0921630859375)},8e-05),'complex math sin 49')
end
do
 local a=np.array({np.complex(1.0,0.0),np.complex(3.0,-5.0),np.complex(0.0,-1.0),np.complex(3.0,-1.0),np.complex(1.0,0.0),np.complex(-1.0,-1.0),np.complex(-0.0,-0.0),np.complex(0.25,-5.0),np.complex(-8.0,-0.0),np.complex(-3.0,0.0),np.complex(-3.0,2.0)},np.complex64)
 local r=np.sin(a)
 assert(r.dtype=='complex64','complex math dtype 50')
 assert(list_same(r:tolist(),{np.complex(0.8414709568023682,0.0),np.complex(10.47250747680664,73.46061706542969),np.complex(0.0,-1.175201177597046),np.complex(0.21775954961776733,1.1634403467178345),np.complex(0.8414709568023682,0.0),np.complex(-1.2984576225280762,-0.634963870048523),np.complex(-0.0,-0.0),np.complex(18.359834671020508,-71.89640808105469),np.complex(-0.9893582463264465,0.0),np.complex(-0.14112000167369843,-0.0),np.complex(-0.5309210419654846,-3.590564489364624)},8e-05),'complex math sin 50')
end
do
 local a=np.array({np.complex(3.0,-5.0),np.complex(-8.0,-1.0),np.complex(8.0,-0.0),np.complex(3.0,-5.0),np.complex(0.0,-1.0),np.complex(-3.0,0.0),np.complex(0.25,5.0),np.complex(-1.0,0.5),np.complex(1.0,5.0),np.complex(0.0,0.0),np.complex(0.25,5.0)},np.complex64)
 local r=np.sin(a)
 assert(r.dtype=='complex64','complex math dtype 51')
 assert(list_same(r:tolist(),{np.complex(10.47250747680664,73.46061706542969),np.complex(-1.526659607887268,0.17099180817604065),np.complex(0.9893582463264465,0.0),np.complex(10.47250747680664,73.46061706542969),np.complex(0.0,-1.175201177597046),np.complex(-0.14112000167369843,-0.0),np.complex(18.359834671020508,71.89640808105469),np.complex(-0.9488644599914551,0.28154897689819336),np.complex(62.44551467895508,40.0921630859375),np.complex(0.0,0.0),np.complex(18.359834671020508,71.89640808105469)},8e-05),'complex math sin 51')
end
do
 local a=np.array({np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(-0.0,-0.0),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(0.0,math.huge),np.complex(0.0,-math.huge),np.complex(math.huge,1.0),np.complex(-math.huge,-1.0),np.complex((0/0),0.0),np.complex((0/0),2.0),np.complex(2.0,(0/0)),np.complex((0/0),(0/0))},np.complex64)
 local r=np.cos(a)
 assert(r.dtype=='complex64','complex math dtype 52')
 assert(list_same(r:tolist(),{np.complex(1.0,-0.0),np.complex(1.0,0.0),np.complex(1.0,0.0),np.complex(1.0,-0.0),np.complex((0/0),0.0),np.complex((0/0),0.0),np.complex(math.huge,-0.0),np.complex(math.huge,0.0),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),0.0),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},8e-05),'complex math cos 52')
end
do
 local a=np.array({np.complex(-8.0,-0.0),np.complex(8.0,0.5),np.complex(0.0,0.0),np.complex(-1.0,0.5),np.complex(-1.0,-5.0),np.complex(8.0,-1.0),np.complex(-8.0,0.0),np.complex(8.0,-0.0),np.complex(3.0,-0.0),np.complex(-0.0,-5.0),np.complex(8.0,5.0)},np.complex64)
 local r=np.cos(a)
 assert(r.dtype=='complex64','complex math dtype 53')
 assert(list_same(r:tolist(),{np.complex(-0.1455000340938568,-0.0),np.complex(-0.16406960785388947,-0.515549898147583),np.complex(1.0,-0.0),np.complex(0.6092588901519775,0.4384865462779999),np.complex(40.095802307128906,-62.43984603881836),np.complex(-0.2245182991027832,1.1626949310302734),np.complex(-0.1455000340938568,0.0),np.complex(-0.1455000340938568,0.0),np.complex(-0.9899924993515015,0.0),np.complex(74.20994567871094,-0.0),np.complex(-10.7975492477417,-73.41355895996094)},8e-05),'complex math cos 53')
end
do
 local a=np.array({np.complex(-0.0,-1.0),np.complex(-8.0,2.0),np.complex(0.0,-0.0),np.complex(0.0,-1.0),np.complex(0.0,0.5),np.complex(8.0,0.0),np.complex(8.0,-5.0),np.complex(8.0,2.0),np.complex(-8.0,-5.0),np.complex(-8.0,5.0),np.complex(3.0,2.0)},np.complex64)
 local r=np.cos(a)
 assert(r.dtype=='complex64','complex math dtype 54')
 assert(list_same(r:tolist(),{np.complex(1.5430806875228882,-0.0),np.complex(-0.5473995804786682,3.588264226913452),np.complex(1.0,0.0),np.complex(1.5430806875228882,0.0),np.complex(1.1276259422302246,-0.0),np.complex(-0.1455000340938568,-0.0),np.complex(-10.7975492477417,73.41355895996094),np.complex(-0.5473995804786682,-3.588264226913452),np.complex(-10.7975492477417,-73.41355895996094),np.complex(-10.7975492477417,73.41355895996094),np.complex(-3.724545478820801,-0.511822521686554)},8e-05),'complex math cos 54')
end
do
 local a=np.array({np.complex(-8.0,0.5),np.complex(0.0,2.0),np.complex(0.0,5.0),np.complex(-8.0,-0.0),np.complex(1.0,0.0),np.complex(1.0,0.0),np.complex(0.0,2.0),np.complex(0.0,0.5),np.complex(0.0,2.0),np.complex(0.25,-5.0),np.complex(-1.0,-1.0)},np.complex64)
 local r=np.cos(a)
 assert(r.dtype=='complex64','complex math dtype 55')
 assert(list_same(r:tolist(),{np.complex(-0.16406960785388947,0.515549898147583),np.complex(3.762195587158203,-0.0),np.complex(74.20994567871094,-0.0),np.complex(-0.1455000340938568,-0.0),np.complex(0.5403022766113281,-0.0),np.complex(0.5403022766113281,-0.0),np.complex(3.762195587158203,-0.0),np.complex(1.1276259422302246,-0.0),np.complex(3.762195587158203,-0.0),np.complex(71.90293884277344,18.35816764831543),np.complex(0.8337299823760986,-0.9888976812362671)},8e-05),'complex math cos 55')
end
do
 local a=np.array({np.complex(-1.0,2.0),np.complex(-3.0,-5.0),np.complex(-8.0,-5.0),np.complex(-3.0,-5.0),np.complex(-1.0,0.5),np.complex(-0.0,-5.0),np.complex(-0.0,-5.0),np.complex(-3.0,0.5),np.complex(-0.0,-1.0),np.complex(-3.0,5.0),np.complex(-3.0,2.0)},np.complex64)
 local r=np.cos(a)
 assert(r.dtype=='complex64','complex math dtype 56')
 assert(list_same(r:tolist(),{np.complex(2.0327229499816895,3.0518977642059326),np.complex(-73.46729278564453,-10.471556663513184),np.complex(-10.7975492477417,-73.41355895996094),np.complex(-73.46729278564453,-10.471556663513184),np.complex(0.6092588901519775,0.4384865462779999),np.complex(74.20994567871094,-0.0),np.complex(74.20994567871094,-0.0),np.complex(-1.116341233253479,0.07353696972131729),np.complex(1.5430806875228882,-0.0),np.complex(-73.46729278564453,10.471556663513184),np.complex(-3.724545478820801,0.511822521686554)},8e-05),'complex math cos 56')
end
do
 local a=np.array({np.complex(-0.0,-5.0),np.complex(3.0,-5.0),np.complex(0.0,-5.0),np.complex(-0.0,-1.0),np.complex(1.0,-5.0),np.complex(3.0,0.0),np.complex(8.0,0.0),np.complex(0.0,-5.0),np.complex(-0.0,2.0),np.complex(0.0,5.0),np.complex(-0.0,2.0)},np.complex64)
 local r=np.cos(a)
 assert(r.dtype=='complex64','complex math dtype 57')
 assert(list_same(r:tolist(),{np.complex(74.20994567871094,-0.0),np.complex(-73.46729278564453,10.471556663513184),np.complex(74.20994567871094,0.0),np.complex(1.5430806875228882,-0.0),np.complex(40.095802307128906,62.43984603881836),np.complex(-0.9899924993515015,-0.0),np.complex(-0.1455000340938568,-0.0),np.complex(74.20994567871094,0.0),np.complex(3.762195587158203,0.0),np.complex(74.20994567871094,-0.0),np.complex(3.762195587158203,0.0)},8e-05),'complex math cos 57')
end
do
 local a=np.array({np.complex(0.0,-1.0),np.complex(0.0,5.0),np.complex(3.0,2.0),np.complex(1.0,0.0),np.complex(-8.0,-5.0),np.complex(1.0,0.0),np.complex(0.25,-5.0),np.complex(0.0,-5.0),np.complex(-8.0,0.5),np.complex(3.0,-1.0),np.complex(-1.0,-0.0)},np.complex64)
 local r=np.cos(a)
 assert(r.dtype=='complex64','complex math dtype 58')
 assert(list_same(r:tolist(),{np.complex(1.5430806875228882,0.0),np.complex(74.20994567871094,-0.0),np.complex(-3.724545478820801,-0.511822521686554),np.complex(0.5403022766113281,-0.0),np.complex(-10.7975492477417,-73.41355895996094),np.complex(0.5403022766113281,-0.0),np.complex(71.90293884277344,18.35816764831543),np.complex(74.20994567871094,0.0),np.complex(-0.16406960785388947,0.515549898147583),np.complex(-1.52763831615448,0.1658443957567215),np.complex(0.5403022766113281,-0.0)},8e-05),'complex math cos 58')
end
do
 local a=np.array({np.complex(-1.0,0.5),np.complex(-0.0,2.0),np.complex(8.0,-5.0),np.complex(8.0,0.5),np.complex(-3.0,5.0),np.complex(0.25,-5.0),np.complex(1.0,2.0),np.complex(8.0,0.5),np.complex(0.25,-1.0),np.complex(1.0,5.0),np.complex(3.0,-1.0)},np.complex64)
 local r=np.cos(a)
 assert(r.dtype=='complex64','complex math dtype 59')
 assert(list_same(r:tolist(),{np.complex(0.6092588901519775,0.4384865462779999),np.complex(3.762195587158203,0.0),np.complex(-10.7975492477417,73.41355895996094),np.complex(-0.16406960785388947,-0.515549898147583),np.complex(-73.46729278564453,10.471556663513184),np.complex(71.90293884277344,18.35816764831543),np.complex(2.0327229499816895,-3.0518977642059326),np.complex(-0.16406960785388947,-0.515549898147583),np.complex(1.495110034942627,0.2907494306564331),np.complex(40.095802307128906,-62.43984603881836),np.complex(-1.52763831615448,0.1658443957567215)},8e-05),'complex math cos 59')
end
do
 local a=np.array({np.complex(-1.0,0.0),np.complex(-1.0,-1.0),np.complex(-1.0,2.0),np.complex(1.0,-5.0),np.complex(-0.0,0.5),np.complex(-3.0,5.0),np.complex(3.0,0.0),np.complex(1.0,-0.0),np.complex(-8.0,5.0),np.complex(-3.0,0.0),np.complex(0.25,0.0)},np.complex64)
 local r=np.cos(a)
 assert(r.dtype=='complex64','complex math dtype 60')
 assert(list_same(r:tolist(),{np.complex(0.5403022766113281,0.0),np.complex(0.8337299823760986,-0.9888976812362671),np.complex(2.0327229499816895,3.0518977642059326),np.complex(40.095802307128906,62.43984603881836),np.complex(1.1276259422302246,0.0),np.complex(-73.46729278564453,10.471556663513184),np.complex(-0.9899924993515015,-0.0),np.complex(0.5403022766113281,0.0),np.complex(-10.7975492477417,73.41355895996094),np.complex(-0.9899924993515015,0.0),np.complex(0.9689124226570129,-0.0)},8e-05),'complex math cos 60')
end
do
 local a=np.array({np.complex(1.0,0.5),np.complex(1.0,2.0),np.complex(1.0,0.5),np.complex(-1.0,-1.0),np.complex(8.0,5.0),np.complex(-3.0,0.0),np.complex(0.25,-5.0),np.complex(-1.0,-5.0),np.complex(0.25,-5.0),np.complex(-8.0,-1.0),np.complex(-3.0,0.5)},np.complex64)
 local r=np.cos(a)
 assert(r.dtype=='complex64','complex math dtype 61')
 assert(list_same(r:tolist(),{np.complex(0.6092588901519775,-0.4384865462779999),np.complex(2.0327229499816895,-3.0518977642059326),np.complex(0.6092588901519775,-0.4384865462779999),np.complex(0.8337299823760986,-0.9888976812362671),np.complex(-10.7975492477417,-73.41355895996094),np.complex(-0.9899924993515015,0.0),np.complex(71.90293884277344,18.35816764831543),np.complex(40.095802307128906,-62.43984603881836),np.complex(71.90293884277344,18.35816764831543),np.complex(-0.2245182991027832,-1.1626949310302734),np.complex(-1.116341233253479,0.07353696972131729)},8e-05),'complex math cos 61')
end
do
 local a=np.array({np.complex(0.25,2.0),np.complex(-3.0,-5.0),np.complex(8.0,0.5),np.complex(-1.0,0.5),np.complex(-8.0,2.0),np.complex(-1.0,-5.0),np.complex(0.25,0.0),np.complex(1.0,2.0),np.complex(-0.0,5.0),np.complex(1.0,-5.0),np.complex(0.0,-1.0)},np.complex64)
 local r=np.cos(a)
 assert(r.dtype=='complex64','complex math dtype 62')
 assert(list_same(r:tolist(),{np.complex(3.645237922668457,-0.8972996473312378),np.complex(-73.46729278564453,-10.471556663513184),np.complex(-0.16406960785388947,-0.515549898147583),np.complex(0.6092588901519775,0.4384865462779999),np.complex(-0.5473995804786682,3.588264226913452),np.complex(40.095802307128906,-62.43984603881836),np.complex(0.9689124226570129,-0.0),np.complex(2.0327229499816895,-3.0518977642059326),np.complex(74.20994567871094,0.0),np.complex(40.095802307128906,62.43984603881836),np.complex(1.5430806875228882,0.0)},8e-05),'complex math cos 62')
end
do
 local a=np.array({np.complex(8.0,-0.0),np.complex(-3.0,-1.0),np.complex(8.0,0.0),np.complex(-1.0,-0.0),np.complex(0.25,5.0),np.complex(-0.0,2.0),np.complex(-3.0,-1.0),np.complex(0.25,0.0),np.complex(3.0,0.0),np.complex(-1.0,5.0),np.complex(1.0,-5.0)},np.complex64)
 local r=np.cos(a)
 assert(r.dtype=='complex64','complex math dtype 63')
 assert(list_same(r:tolist(),{np.complex(-0.1455000340938568,0.0),np.complex(-1.52763831615448,-0.1658443957567215),np.complex(-0.1455000340938568,-0.0),np.complex(0.5403022766113281,-0.0),np.complex(71.90293884277344,-18.35816764831543),np.complex(3.762195587158203,0.0),np.complex(-1.52763831615448,-0.1658443957567215),np.complex(0.9689124226570129,-0.0),np.complex(-0.9899924993515015,-0.0),np.complex(40.095802307128906,62.43984603881836),np.complex(40.095802307128906,62.43984603881836)},8e-05),'complex math cos 63')
end
do
 local a=np.array({np.complex(-0.0,-0.0),np.complex(3.0,2.0),np.complex(-3.0,-0.0),np.complex(-3.0,0.0),np.complex(3.0,0.0),np.complex(8.0,-0.0),np.complex(0.25,0.5),np.complex(-8.0,-1.0),np.complex(0.0,-1.0),np.complex(8.0,0.0),np.complex(0.25,0.0)},np.complex64)
 local r=np.cos(a)
 assert(r.dtype=='complex64','complex math dtype 64')
 assert(list_same(r:tolist(),{np.complex(1.0,-0.0),np.complex(-3.724545478820801,-0.511822521686554),np.complex(-0.9899924993515015,-0.0),np.complex(-0.9899924993515015,0.0),np.complex(-0.9899924993515015,-0.0),np.complex(-0.1455000340938568,0.0),np.complex(1.0925707817077637,-0.1289210319519043),np.complex(-0.2245182991027832,-1.1626949310302734),np.complex(1.5430806875228882,0.0),np.complex(-0.1455000340938568,-0.0),np.complex(0.9689124226570129,-0.0)},8e-05),'complex math cos 64')
end
do
 local a=np.array({np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(-0.0,-0.0),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(0.0,math.huge),np.complex(0.0,-math.huge),np.complex(math.huge,1.0),np.complex(-math.huge,-1.0),np.complex((0/0),0.0),np.complex((0/0),2.0),np.complex(2.0,(0/0)),np.complex((0/0),(0/0))},np.complex64)
 local r=np.tan(a)
 assert(r.dtype=='complex64','complex math dtype 65')
 assert(list_same(r:tolist(),{np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(-0.0,-0.0),np.complex((0/0),0.0),np.complex((0/0),0.0),np.complex(0.0,1.0),np.complex(0.0,-1.0),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),0.0),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},8e-05),'complex math tan 65')
end
do
 local a=np.array({np.complex(0.0,0.5),np.complex(0.25,0.5),np.complex(8.0,-5.0),np.complex(0.0,-5.0),np.complex(3.0,0.5),np.complex(0.25,5.0),np.complex(-3.0,-5.0),np.complex(-0.0,2.0),np.complex(-8.0,-5.0),np.complex(-0.0,-1.0),np.complex(-0.0,-0.0)},np.complex64)
 local r=np.tan(a)
 assert(r.dtype=='complex64','complex math dtype 66')
 assert(list_same(r:tolist(),{np.complex(0.0,0.46211710572242737),np.complex(0.1980554610490799,0.4854872524738312),np.complex(-2.614385448396206e-05,-1.000087022781372),np.complex(0.0,-0.9999092221260071),np.complex(-0.11162105202674866,0.46946996450424194),np.complex(4.3528303649509326e-05,0.9999203085899353),np.complex(2.5368677597725764e-05,-0.9999128580093384),np.complex(-0.0,0.9640275835990906),np.complex(2.614385448396206e-05,-1.000087022781372),np.complex(-0.0,-0.7615941762924194),np.complex(-0.0,-0.0)},8e-05),'complex math tan 66')
end
do
 local a=np.array({np.complex(0.25,5.0),np.complex(-1.0,-0.0),np.complex(-1.0,-1.0),np.complex(-3.0,-5.0),np.complex(0.25,-0.0),np.complex(-3.0,0.0),np.complex(0.25,-1.0),np.complex(1.0,-5.0),np.complex(0.25,-0.0),np.complex(-0.0,0.0),np.complex(0.0,0.5)},np.complex64)
 local r=np.tan(a)
 assert(r.dtype=='complex64','complex math dtype 67')
 assert(list_same(r:tolist(),{np.complex(4.3528303649509326e-05,0.9999203085899353),np.complex(-1.5574077367782593,-0.0),np.complex(-0.27175256609916687,-1.08392333984375),np.complex(2.5368677597725764e-05,-0.9999128580093384),np.complex(0.25534191727638245,-0.0),np.complex(0.14254653453826904,0.0),np.complex(0.10332941263914108,-0.7816883325576782),np.complex(8.25671959319152e-05,-1.0000377893447876),np.complex(0.25534191727638245,-0.0),np.complex(-0.0,0.0),np.complex(0.0,0.46211710572242737)},8e-05),'complex math tan 67')
end
do
 local a=np.array({np.complex(3.0,-5.0),np.complex(-0.0,5.0),np.complex(3.0,-5.0),np.complex(-8.0,-0.0),np.complex(-8.0,-1.0),np.complex(-1.0,-5.0),np.complex(0.25,-1.0),np.complex(1.0,-0.0),np.complex(1.0,-5.0),np.complex(-0.0,0.5),np.complex(-0.0,0.0)},np.complex64)
 local r=np.tan(a)
 assert(r.dtype=='complex64','complex math dtype 68')
 assert(list_same(r:tolist(),{np.complex(-2.5368677597725764e-05,-0.9999128580093384),np.complex(-0.0,0.9999092221260071),np.complex(-2.5368677597725764e-05,-0.9999128580093384),np.complex(6.799711227416992,-0.0),np.complex(0.1026563048362732,-1.2932121753692627),np.complex(-8.25671959319152e-05,-1.0000377893447876),np.complex(0.10332941263914108,-0.7816883325576782),np.complex(1.5574077367782593,-0.0),np.complex(8.25671959319152e-05,-1.0000377893447876),np.complex(-0.0,0.46211710572242737),np.complex(-0.0,0.0)},8e-05),'complex math tan 68')
end
do
 local a=np.array({np.complex(8.0,0.5),np.complex(3.0,0.0),np.complex(0.25,0.5),np.complex(8.0,2.0),np.complex(-1.0,5.0),np.complex(0.0,0.5),np.complex(0.25,0.5),np.complex(3.0,2.0),np.complex(0.0,-5.0),np.complex(1.0,5.0),np.complex(-1.0,-5.0)},np.complex64)
 local r=np.tan(a)
 assert(r.dtype=='complex64','complex math dtype 69')
 assert(list_same(r:tolist(),{np.complex(-0.49178841710090637,2.007445812225342),np.complex(-0.14254653453826904,0.0),np.complex(0.1980554610490799,0.4854872524738312),np.complex(-0.010925883427262306,1.0356478691101074),np.complex(-8.25671959319152e-05,1.0000377893447876),np.complex(0.0,0.46211710572242737),np.complex(0.1980554610490799,0.4854872524738312),np.complex(-0.009884374216198921,0.9653858542442322),np.complex(0.0,-0.9999092221260071),np.complex(8.25671959319152e-05,1.0000377893447876),np.complex(-8.25671959319152e-05,-1.0000377893447876)},8e-05),'complex math tan 69')
end
do
 local a=np.array({np.complex(-0.0,5.0),np.complex(-1.0,2.0),np.complex(1.0,-0.0),np.complex(-0.0,-0.0),np.complex(-0.0,-5.0),np.complex(0.25,5.0),np.complex(0.0,-1.0),np.complex(0.0,5.0),np.complex(0.0,-1.0),np.complex(-8.0,5.0),np.complex(-0.0,-0.0)},np.complex64)
 local r=np.tan(a)
 assert(r.dtype=='complex64','complex math dtype 70')
 assert(list_same(r:tolist(),{np.complex(-0.0,0.9999092221260071),np.complex(-0.03381282463669777,1.0147936344146729),np.complex(1.5574077367782593,-0.0),np.complex(-0.0,-0.0),np.complex(-0.0,-0.9999092221260071),np.complex(4.3528303649509326e-05,0.9999203085899353),np.complex(0.0,-0.7615941762924194),np.complex(0.0,0.9999092221260071),np.complex(0.0,-0.7615941762924194),np.complex(2.614385448396206e-05,1.000087022781372),np.complex(-0.0,-0.0)},8e-05),'complex math tan 70')
end
do
 local a=np.array({np.complex(1.0,2.0),np.complex(3.0,-1.0),np.complex(8.0,-5.0),np.complex(-1.0,-1.0),np.complex(0.25,-1.0),np.complex(0.25,-5.0),np.complex(-0.0,0.5),np.complex(0.25,2.0),np.complex(0.0,-1.0),np.complex(-8.0,2.0),np.complex(0.25,0.0)},np.complex64)
 local r=np.tan(a)
 assert(r.dtype=='complex64','complex math dtype 71')
 assert(list_same(r:tolist(),{np.complex(0.03381282463669777,1.0147936344146729),np.complex(-0.05916853994131088,-0.7680176496505737),np.complex(-2.614385448396206e-05,-1.000087022781372),np.complex(-0.27175256609916687,-1.08392333984375),np.complex(0.10332941263914108,-0.7816883325576782),np.complex(4.3528303649509326e-05,-0.9999203085899353),np.complex(-0.0,0.46211710572242737),np.complex(0.017009461298584938,0.9682145714759827),np.complex(0.0,-0.7615941762924194),np.complex(0.010925883427262306,1.0356478691101074),np.complex(0.25534191727638245,0.0)},8e-05),'complex math tan 71')
end
do
 local a=np.array({np.complex(8.0,-1.0),np.complex(3.0,0.5),np.complex(-0.0,2.0),np.complex(1.0,0.0),np.complex(3.0,0.5),np.complex(-1.0,5.0),np.complex(3.0,-5.0),np.complex(-0.0,0.5),np.complex(0.0,0.0),np.complex(-3.0,2.0),np.complex(8.0,-1.0)},np.complex64)
 local r=np.tan(a)
 assert(r.dtype=='complex64','complex math dtype 72')
 assert(list_same(r:tolist(),{np.complex(-0.1026563048362732,-1.2932121753692627),np.complex(-0.11162105202674866,0.46946996450424194),np.complex(-0.0,0.9640275835990906),np.complex(1.5574077367782593,0.0),np.complex(-0.11162105202674866,0.46946996450424194),np.complex(-8.25671959319152e-05,1.0000377893447876),np.complex(-2.5368677597725764e-05,-0.9999128580093384),np.complex(-0.0,0.46211710572242737),np.complex(0.0,0.0),np.complex(0.009884374216198921,0.9653858542442322),np.complex(-0.1026563048362732,-1.2932121753692627)},8e-05),'complex math tan 72')
end
do
 local a=np.array({np.complex(1.0,2.0),np.complex(8.0,5.0),np.complex(3.0,-0.0),np.complex(3.0,2.0),np.complex(-8.0,2.0),np.complex(0.25,-1.0),np.complex(0.0,0.5),np.complex(-8.0,2.0),np.complex(0.0,0.5),np.complex(-8.0,-0.0),np.complex(0.0,0.5)},np.complex64)
 local r=np.tan(a)
 assert(r.dtype=='complex64','complex math dtype 73')
 assert(list_same(r:tolist(),{np.complex(0.03381282463669777,1.0147936344146729),np.complex(-2.614385448396206e-05,1.000087022781372),np.complex(-0.14254653453826904,-0.0),np.complex(-0.009884374216198921,0.9653858542442322),np.complex(0.010925883427262306,1.0356478691101074),np.complex(0.10332941263914108,-0.7816883325576782),np.complex(0.0,0.46211710572242737),np.complex(0.010925883427262306,1.0356478691101074),np.complex(0.0,0.46211710572242737),np.complex(6.799711227416992,-0.0),np.complex(0.0,0.46211710572242737)},8e-05),'complex math tan 73')
end
do
 local a=np.array({np.complex(-8.0,2.0),np.complex(-8.0,-1.0),np.complex(-3.0,-0.0),np.complex(8.0,-1.0),np.complex(8.0,0.5),np.complex(3.0,-1.0),np.complex(1.0,0.0),np.complex(-3.0,-1.0),np.complex(3.0,-0.0),np.complex(1.0,-0.0),np.complex(1.0,0.0)},np.complex64)
 local r=np.tan(a)
 assert(r.dtype=='complex64','complex math dtype 74')
 assert(list_same(r:tolist(),{np.complex(0.010925883427262306,1.0356478691101074),np.complex(0.1026563048362732,-1.2932121753692627),np.complex(0.14254653453826904,-0.0),np.complex(-0.1026563048362732,-1.2932121753692627),np.complex(-0.49178841710090637,2.007445812225342),np.complex(-0.05916853994131088,-0.7680176496505737),np.complex(1.5574077367782593,0.0),np.complex(0.05916853994131088,-0.7680176496505737),np.complex(-0.14254653453826904,-0.0),np.complex(1.5574077367782593,-0.0),np.complex(1.5574077367782593,0.0)},8e-05),'complex math tan 74')
end
do
 local a=np.array({np.complex(0.0,2.0),np.complex(1.0,-0.0),np.complex(0.0,-1.0),np.complex(-0.0,5.0),np.complex(8.0,5.0),np.complex(8.0,0.5),np.complex(-1.0,-0.0),np.complex(8.0,2.0),np.complex(8.0,5.0),np.complex(0.25,-0.0),np.complex(-0.0,-0.0)},np.complex64)
 local r=np.tan(a)
 assert(r.dtype=='complex64','complex math dtype 75')
 assert(list_same(r:tolist(),{np.complex(0.0,0.9640275835990906),np.complex(1.5574077367782593,-0.0),np.complex(0.0,-0.7615941762924194),np.complex(-0.0,0.9999092221260071),np.complex(-2.614385448396206e-05,1.000087022781372),np.complex(-0.49178841710090637,2.007445812225342),np.complex(-1.5574077367782593,-0.0),np.complex(-0.010925883427262306,1.0356478691101074),np.complex(-2.614385448396206e-05,1.000087022781372),np.complex(0.25534191727638245,-0.0),np.complex(-0.0,-0.0)},8e-05),'complex math tan 75')
end
do
 local a=np.array({np.complex(3.0,-0.0),np.complex(8.0,0.5),np.complex(8.0,-5.0),np.complex(0.0,-1.0),np.complex(-8.0,-1.0),np.complex(-0.0,0.5),np.complex(-0.0,5.0),np.complex(-8.0,0.5),np.complex(0.25,-1.0),np.complex(-0.0,0.0),np.complex(-3.0,0.0)},np.complex64)
 local r=np.tan(a)
 assert(r.dtype=='complex64','complex math dtype 76')
 assert(list_same(r:tolist(),{np.complex(-0.14254653453826904,-0.0),np.complex(-0.49178841710090637,2.007445812225342),np.complex(-2.614385448396206e-05,-1.000087022781372),np.complex(0.0,-0.7615941762924194),np.complex(0.1026563048362732,-1.2932121753692627),np.complex(-0.0,0.46211710572242737),np.complex(-0.0,0.9999092221260071),np.complex(0.49178841710090637,2.007445812225342),np.complex(0.10332941263914108,-0.7816883325576782),np.complex(-0.0,0.0),np.complex(0.14254653453826904,0.0)},8e-05),'complex math tan 76')
end
do
 local a=np.array({np.complex(0.25,0.5),np.complex(-0.0,-1.0),np.complex(0.25,-0.0),np.complex(-0.0,0.5),np.complex(0.25,0.0),np.complex(-0.0,-1.0),np.complex(0.25,-0.0),np.complex(-8.0,5.0),np.complex(-8.0,5.0),np.complex(-8.0,-5.0),np.complex(-0.0,-1.0)},np.complex64)
 local r=np.tan(a)
 assert(r.dtype=='complex64','complex math dtype 77')
 assert(list_same(r:tolist(),{np.complex(0.1980554610490799,0.4854872524738312),np.complex(-0.0,-0.7615941762924194),np.complex(0.25534191727638245,-0.0),np.complex(-0.0,0.46211710572242737),np.complex(0.25534191727638245,0.0),np.complex(-0.0,-0.7615941762924194),np.complex(0.25534191727638245,-0.0),np.complex(2.614385448396206e-05,1.000087022781372),np.complex(2.614385448396206e-05,1.000087022781372),np.complex(2.614385448396206e-05,-1.000087022781372),np.complex(-0.0,-0.7615941762924194)},8e-05),'complex math tan 77')
end
do
 local a=np.array({np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(-0.0,-0.0),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(0.0,math.huge),np.complex(0.0,-math.huge),np.complex(math.huge,1.0),np.complex(-math.huge,-1.0),np.complex((0/0),0.0),np.complex((0/0),2.0),np.complex(2.0,(0/0)),np.complex((0/0),(0/0))},np.complex128)
 local r=np.sqrt(a)
 assert(r.dtype=='complex128','complex math dtype 78')
 assert(list_same(r:tolist(),{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,-0.0),np.complex(0.0,-0.0),np.complex(math.huge,0.0),np.complex(0.0,math.huge),np.complex(math.huge,math.huge),np.complex(math.huge,-math.huge),np.complex(math.huge,0.0),np.complex(0.0,-math.huge),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},3e-12),'complex math sqrt 78')
end
do
 local a=np.array({np.complex(8.0,2.0),np.complex(0.25,0.0),np.complex(3.0,2.0),np.complex(-3.0,-0.0),np.complex(-0.0,-5.0),np.complex(0.0,5.0),np.complex(8.0,-5.0),np.complex(3.0,-1.0),np.complex(8.0,5.0),np.complex(0.25,5.0),np.complex(8.0,5.0)},np.complex128)
 local r=np.sqrt(a)
 assert(r.dtype=='complex128','complex math dtype 79')
 assert(list_same(r:tolist(),{np.complex(2.850106248127894,0.35086411275258766),np.complex(0.5,0.0),np.complex(1.8173540210239707,0.5502505227003375),np.complex(0.0,-1.7320508075688772),np.complex(1.5811388300841898,-1.5811388300841898),np.complex(1.5811388300841898,1.5811388300841898),np.complex(2.952455006605232,-0.8467529545435918),np.complex(1.755317301824428,-0.28484878459314106),np.complex(2.952455006605232,0.8467529545435918),np.complex(1.6211486820500451,1.5421164188583811),np.complex(2.952455006605232,0.8467529545435918)},3e-12),'complex math sqrt 79')
end
do
 local a=np.array({np.complex(3.0,0.5),np.complex(8.0,-5.0),np.complex(0.25,-1.0),np.complex(0.25,-1.0),np.complex(8.0,2.0),np.complex(1.0,-1.0),np.complex(-3.0,-5.0),np.complex(3.0,-1.0),np.complex(0.0,2.0),np.complex(8.0,2.0),np.complex(8.0,-0.0)},np.complex128)
 local r=np.sqrt(a)
 assert(r.dtype=='complex128','complex math dtype 80')
 assert(list_same(r:tolist(),{np.complex(1.738013415533538,0.14384238796180673),np.complex(2.952455006605232,-0.8467529545435918),np.complex(0.8002425902201205,-0.6248105338438266),np.complex(0.8002425902201205,-0.6248105338438266),np.complex(2.850106248127894,0.35086411275258766),np.complex(1.09868411346781,-0.45508986056222733),np.complex(1.189737764140758,-2.101303392521568),np.complex(1.755317301824428,-0.28484878459314106),np.complex(1.0,1.0),np.complex(2.850106248127894,0.35086411275258766),np.complex(2.8284271247461903,-0.0)},3e-12),'complex math sqrt 80')
end
do
 local a=np.array({np.complex(0.0,-5.0),np.complex(0.25,-1.0),np.complex(0.0,5.0),np.complex(-0.0,-0.0),np.complex(-0.0,0.0),np.complex(0.25,2.0),np.complex(-3.0,5.0),np.complex(0.0,0.0),np.complex(-0.0,5.0),np.complex(-0.0,-5.0),np.complex(-3.0,2.0)},np.complex128)
 local r=np.sqrt(a)
 assert(r.dtype=='complex128','complex math dtype 81')
 assert(list_same(r:tolist(),{np.complex(1.5811388300841898,-1.5811388300841898),np.complex(0.8002425902201205,-0.6248105338438266),np.complex(1.5811388300841898,1.5811388300841898),np.complex(0.0,-0.0),np.complex(0.0,0.0),np.complex(1.064322422265602,0.9395649091666413),np.complex(1.189737764140758,2.101303392521568),np.complex(0.0,0.0),np.complex(1.5811388300841898,1.5811388300841898),np.complex(1.5811388300841898,-1.5811388300841898),np.complex(0.5502505227003375,1.8173540210239707)},3e-12),'complex math sqrt 81')
end
do
 local a=np.array({np.complex(0.0,-0.0),np.complex(-1.0,0.5),np.complex(0.25,-1.0),np.complex(-3.0,0.0),np.complex(-0.0,2.0),np.complex(1.0,0.5),np.complex(-3.0,0.0),np.complex(-8.0,5.0),np.complex(8.0,2.0),np.complex(3.0,2.0),np.complex(1.0,-0.0)},np.complex128)
 local r=np.sqrt(a)
 assert(r.dtype=='complex128','complex math dtype 82')
 assert(list_same(r:tolist(),{np.complex(0.0,-0.0),np.complex(0.24293413587832283,1.0290855136357462),np.complex(0.8002425902201205,-0.6248105338438266),np.complex(0.0,1.7320508075688772),np.complex(1.0,1.0),np.complex(1.0290855136357462,0.24293413587832283),np.complex(0.0,1.7320508075688772),np.complex(0.8467529545435918,2.952455006605232),np.complex(2.850106248127894,0.35086411275258766),np.complex(1.8173540210239707,0.5502505227003375),np.complex(1.0,-0.0)},3e-12),'complex math sqrt 82')
end
do
 local a=np.array({np.complex(0.0,0.5),np.complex(-1.0,5.0),np.complex(1.0,5.0),np.complex(0.25,0.5),np.complex(-3.0,0.0),np.complex(-8.0,0.5),np.complex(3.0,-0.0),np.complex(-0.0,0.0),np.complex(1.0,-0.0),np.complex(0.0,0.0),np.complex(0.0,2.0)},np.complex128)
 local r=np.sqrt(a)
 assert(r.dtype=='complex128','complex math dtype 83')
 assert(list_same(r:tolist(),{np.complex(0.5,0.5),np.complex(1.4316108957382214,1.7462845577958914),np.complex(1.7462845577958914,1.4316108957382214),np.complex(0.6360098247570345,0.39307568887871164),np.complex(0.0,1.7320508075688772),np.complex(0.08834526286309494,2.8298065102530154),np.complex(1.7320508075688772,-0.0),np.complex(0.0,0.0),np.complex(1.0,-0.0),np.complex(0.0,0.0),np.complex(1.0,1.0)},3e-12),'complex math sqrt 83')
end
do
 local a=np.array({np.complex(0.0,0.0),np.complex(3.0,-5.0),np.complex(3.0,2.0),np.complex(-3.0,-5.0),np.complex(8.0,-0.0),np.complex(8.0,2.0),np.complex(-0.0,0.5),np.complex(1.0,5.0),np.complex(3.0,-1.0),np.complex(-8.0,0.5),np.complex(8.0,0.0)},np.complex128)
 local r=np.sqrt(a)
 assert(r.dtype=='complex128','complex math dtype 84')
 assert(list_same(r:tolist(),{np.complex(0.0,0.0),np.complex(2.101303392521568,-1.189737764140758),np.complex(1.8173540210239707,0.5502505227003375),np.complex(1.189737764140758,-2.101303392521568),np.complex(2.8284271247461903,-0.0),np.complex(2.850106248127894,0.35086411275258766),np.complex(0.5,0.5),np.complex(1.7462845577958914,1.4316108957382214),np.complex(1.755317301824428,-0.28484878459314106),np.complex(0.08834526286309494,2.8298065102530154),np.complex(2.8284271247461903,0.0)},3e-12),'complex math sqrt 84')
end
do
 local a=np.array({np.complex(3.0,5.0),np.complex(-1.0,-1.0),np.complex(3.0,-0.0),np.complex(3.0,-5.0),np.complex(8.0,0.5),np.complex(-8.0,5.0),np.complex(-1.0,-1.0),np.complex(-0.0,2.0),np.complex(0.0,2.0),np.complex(0.25,2.0),np.complex(1.0,-1.0)},np.complex128)
 local r=np.sqrt(a)
 assert(r.dtype=='complex128','complex math dtype 85')
 assert(list_same(r:tolist(),{np.complex(2.101303392521568,1.189737764140758),np.complex(0.45508986056222733,-1.09868411346781),np.complex(1.7320508075688772,-0.0),np.complex(2.101303392521568,-1.189737764140758),np.complex(2.8298065102530154,0.08834526286309494),np.complex(0.8467529545435918,2.952455006605232),np.complex(0.45508986056222733,-1.09868411346781),np.complex(1.0,1.0),np.complex(1.0,1.0),np.complex(1.064322422265602,0.9395649091666413),np.complex(1.09868411346781,-0.45508986056222733)},3e-12),'complex math sqrt 85')
end
do
 local a=np.array({np.complex(1.0,0.5),np.complex(0.0,-0.0),np.complex(3.0,0.5),np.complex(-8.0,0.5),np.complex(-1.0,0.0),np.complex(-8.0,-5.0),np.complex(-0.0,0.5),np.complex(-3.0,-0.0),np.complex(0.0,-1.0),np.complex(-8.0,2.0),np.complex(0.25,5.0)},np.complex128)
 local r=np.sqrt(a)
 assert(r.dtype=='complex128','complex math dtype 86')
 assert(list_same(r:tolist(),{np.complex(1.0290855136357462,0.24293413587832283),np.complex(0.0,-0.0),np.complex(1.738013415533538,0.14384238796180673),np.complex(0.08834526286309494,2.8298065102530154),np.complex(0.0,1.0),np.complex(0.8467529545435918,-2.952455006605232),np.complex(0.5,0.5),np.complex(0.0,-1.7320508075688772),np.complex(0.7071067811865476,-0.7071067811865476),np.complex(0.35086411275258766,2.850106248127894),np.complex(1.6211486820500451,1.5421164188583811)},3e-12),'complex math sqrt 86')
end
do
 local a=np.array({np.complex(0.25,2.0),np.complex(1.0,-0.0),np.complex(8.0,0.5),np.complex(0.25,-5.0),np.complex(1.0,0.0),np.complex(1.0,-5.0),np.complex(0.0,-0.0),np.complex(3.0,2.0),np.complex(8.0,5.0),np.complex(0.0,5.0),np.complex(1.0,5.0)},np.complex128)
 local r=np.sqrt(a)
 assert(r.dtype=='complex128','complex math dtype 87')
 assert(list_same(r:tolist(),{np.complex(1.064322422265602,0.9395649091666413),np.complex(1.0,-0.0),np.complex(2.8298065102530154,0.08834526286309494),np.complex(1.6211486820500451,-1.5421164188583811),np.complex(1.0,0.0),np.complex(1.7462845577958914,-1.4316108957382214),np.complex(0.0,-0.0),np.complex(1.8173540210239707,0.5502505227003375),np.complex(2.952455006605232,0.8467529545435918),np.complex(1.5811388300841898,1.5811388300841898),np.complex(1.7462845577958914,1.4316108957382214)},3e-12),'complex math sqrt 87')
end
do
 local a=np.array({np.complex(-1.0,0.5),np.complex(1.0,-0.0),np.complex(1.0,5.0),np.complex(1.0,-1.0),np.complex(0.25,-1.0),np.complex(1.0,5.0),np.complex(-8.0,0.0),np.complex(3.0,5.0),np.complex(3.0,5.0),np.complex(-0.0,-0.0),np.complex(1.0,-0.0)},np.complex128)
 local r=np.sqrt(a)
 assert(r.dtype=='complex128','complex math dtype 88')
 assert(list_same(r:tolist(),{np.complex(0.24293413587832283,1.0290855136357462),np.complex(1.0,-0.0),np.complex(1.7462845577958914,1.4316108957382214),np.complex(1.09868411346781,-0.45508986056222733),np.complex(0.8002425902201205,-0.6248105338438266),np.complex(1.7462845577958914,1.4316108957382214),np.complex(0.0,2.8284271247461903),np.complex(2.101303392521568,1.189737764140758),np.complex(2.101303392521568,1.189737764140758),np.complex(0.0,-0.0),np.complex(1.0,-0.0)},3e-12),'complex math sqrt 88')
end
do
 local a=np.array({np.complex(-1.0,0.5),np.complex(-1.0,0.0),np.complex(3.0,-5.0),np.complex(0.25,0.0),np.complex(1.0,5.0),np.complex(-1.0,0.5),np.complex(1.0,0.5),np.complex(-3.0,5.0),np.complex(8.0,0.0),np.complex(8.0,-0.0),np.complex(-1.0,-0.0)},np.complex128)
 local r=np.sqrt(a)
 assert(r.dtype=='complex128','complex math dtype 89')
 assert(list_same(r:tolist(),{np.complex(0.24293413587832283,1.0290855136357462),np.complex(0.0,1.0),np.complex(2.101303392521568,-1.189737764140758),np.complex(0.5,0.0),np.complex(1.7462845577958914,1.4316108957382214),np.complex(0.24293413587832283,1.0290855136357462),np.complex(1.0290855136357462,0.24293413587832283),np.complex(1.189737764140758,2.101303392521568),np.complex(2.8284271247461903,0.0),np.complex(2.8284271247461903,-0.0),np.complex(0.0,-1.0)},3e-12),'complex math sqrt 89')
end
do
 local a=np.array({np.complex(1.0,-1.0),np.complex(-3.0,0.0),np.complex(3.0,-0.0),np.complex(-8.0,0.0),np.complex(0.0,-5.0),np.complex(-8.0,0.0),np.complex(1.0,0.0),np.complex(1.0,-5.0),np.complex(8.0,-1.0),np.complex(-1.0,0.5),np.complex(-3.0,0.5)},np.complex128)
 local r=np.sqrt(a)
 assert(r.dtype=='complex128','complex math dtype 90')
 assert(list_same(r:tolist(),{np.complex(1.09868411346781,-0.45508986056222733),np.complex(0.0,1.7320508075688772),np.complex(1.7320508075688772,-0.0),np.complex(0.0,2.8284271247461903),np.complex(1.5811388300841898,-1.5811388300841898),np.complex(0.0,2.8284271247461903),np.complex(1.0,0.0),np.complex(1.7462845577958914,-1.4316108957382214),np.complex(2.8339246415791077,-0.17643376703248964),np.complex(0.24293413587832283,1.0290855136357462),np.complex(0.14384238796180673,1.738013415533538)},3e-12),'complex math sqrt 90')
end
do
 local a=np.array({np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(-0.0,-0.0),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(0.0,math.huge),np.complex(0.0,-math.huge),np.complex(math.huge,1.0),np.complex(-math.huge,-1.0),np.complex((0/0),0.0),np.complex((0/0),2.0),np.complex(2.0,(0/0)),np.complex((0/0),(0/0))},np.complex128)
 local r=np.exp(a)
 assert(r.dtype=='complex128','complex math dtype 91')
 assert(list_same(r:tolist(),{np.complex(1.0,0.0),np.complex(1.0,0.0),np.complex(1.0,-0.0),np.complex(1.0,-0.0),np.complex(math.huge,0.0),np.complex(0.0,0.0),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex(math.huge,math.huge),np.complex(0.0,-0.0),np.complex((0/0),0.0),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},3e-12),'complex math exp 91')
end
do
 local a=np.array({np.complex(-1.0,2.0),np.complex(-8.0,0.0),np.complex(-3.0,0.0),np.complex(1.0,5.0),np.complex(-3.0,-5.0),np.complex(3.0,-5.0),np.complex(0.25,0.5),np.complex(0.25,2.0),np.complex(8.0,-1.0),np.complex(0.25,0.5),np.complex(0.0,-1.0)},np.complex128)
 local r=np.exp(a)
 assert(r.dtype=='complex128','complex math dtype 92')
 assert(list_same(r:tolist(),{np.complex(-0.1530918656742263,0.33451182923926226),np.complex(0.00033546262790251185,0.0),np.complex(0.049787068367863944,0.0),np.complex(0.7710737641656674,-2.6066264306850795),np.complex(0.014122708621035348,0.04774202842225802),np.complex(5.697507299833739,19.26050892528742),np.complex(1.1268383147091814,0.6155945769770066),np.complex(-0.53434311520073,1.167561007372937),np.complex(1610.6184740946942,-2508.389653026968),np.complex(1.1268383147091814,0.6155945769770066),np.complex(0.5403023058681398,-0.8414709848078965)},3e-12),'complex math exp 92')
end
do
 local a=np.array({np.complex(8.0,-0.0),np.complex(0.0,0.0),np.complex(-8.0,0.5),np.complex(-0.0,0.5),np.complex(1.0,5.0),np.complex(0.0,5.0),np.complex(1.0,0.0),np.complex(0.25,0.5),np.complex(0.0,2.0),np.complex(0.25,2.0),np.complex(8.0,5.0)},np.complex128)
 local r=np.exp(a)
 assert(r.dtype=='complex128','complex math dtype 93')
 assert(list_same(r:tolist(),{np.complex(2980.9579870417283,-0.0),np.complex(1.0,0.0),np.complex(0.0002943961524131632,0.00016082935106374307),np.complex(0.8775825618903728,0.479425538604203),np.complex(0.7710737641656674,-2.6066264306850795),np.complex(0.28366218546322625,-0.9589242746631385),np.complex(2.718281828459045,0.0),np.complex(1.1268383147091814,0.6155945769770066),np.complex(-0.4161468365471424,0.9092974268256817),np.complex(-0.53434311520073,1.167561007372937),np.complex(845.5850573783163,-2858.5129755252788)},3e-12),'complex math exp 93')
end
do
 local a=np.array({np.complex(3.0,-5.0),np.complex(-8.0,0.5),np.complex(0.0,-5.0),np.complex(-0.0,-5.0),np.complex(-1.0,5.0),np.complex(-0.0,0.5),np.complex(-3.0,2.0),np.complex(1.0,0.0),np.complex(-0.0,-1.0),np.complex(1.0,2.0),np.complex(-8.0,0.5)},np.complex128)
 local r=np.exp(a)
 assert(r.dtype=='complex128','complex math dtype 94')
 assert(list_same(r:tolist(),{np.complex(5.697507299833739,19.26050892528742),np.complex(0.0002943961524131632,0.00016082935106374307),np.complex(0.28366218546322625,0.9589242746631385),np.complex(0.28366218546322625,0.9589242746631385),np.complex(0.1043534862696817,-0.35276852628880606),np.complex(0.8775825618903728,0.479425538604203),np.complex(-0.02071873100224288,0.045271253156092976),np.complex(2.718281828459045,0.0),np.complex(0.5403023058681398,-0.8414709848078965),np.complex(-1.1312043837568135,2.4717266720048188),np.complex(0.0002943961524131632,0.00016082935106374307)},3e-12),'complex math exp 94')
end
do
 local a=np.array({np.complex(0.0,-0.0),np.complex(0.0,0.5),np.complex(-1.0,-5.0),np.complex(8.0,2.0),np.complex(-0.0,-5.0),np.complex(-0.0,-1.0),np.complex(3.0,-0.0),np.complex(8.0,0.0),np.complex(3.0,5.0),np.complex(-1.0,-5.0),np.complex(0.25,5.0)},np.complex128)
 local r=np.exp(a)
 assert(r.dtype=='complex128','complex math dtype 95')
 assert(list_same(r:tolist(),{np.complex(1.0,-0.0),np.complex(0.8775825618903728,0.479425538604203),np.complex(0.1043534862696817,0.35276852628880606),np.complex(-1240.5162361873527,2710.5774270925076),np.complex(0.28366218546322625,0.9589242746631385),np.complex(0.5403023058681398,-0.8414709848078965),np.complex(20.085536923187668,-0.0),np.complex(2980.9579870417283,0.0),np.complex(5.697507299833739,-19.26050892528742),np.complex(0.1043534862696817,0.35276852628880606),np.complex(0.36422945588797445,-1.2312831413463265)},3e-12),'complex math exp 95')
end
do
 local a=np.array({np.complex(0.0,0.5),np.complex(-3.0,0.0),np.complex(8.0,5.0),np.complex(-3.0,-5.0),np.complex(-0.0,0.0),np.complex(-1.0,-1.0),np.complex(-8.0,-1.0),np.complex(1.0,0.5),np.complex(1.0,2.0),np.complex(3.0,-0.0),np.complex(1.0,5.0)},np.complex128)
 local r=np.exp(a)
 assert(r.dtype=='complex128','complex math dtype 96')
 assert(list_same(r:tolist(),{np.complex(0.8775825618903728,0.479425538604203),np.complex(0.049787068367863944,0.0),np.complex(845.5850573783163,-2858.5129755252788),np.complex(0.014122708621035348,0.04774202842225802),np.complex(1.0,0.0),np.complex(0.19876611034641298,-0.3095598756531122),np.complex(0.00018125123138831292,-0.00028228206786737157),np.complex(2.3855167309591354,1.3032137296869954),np.complex(-1.1312043837568135,2.4717266720048188),np.complex(20.085536923187668,-0.0),np.complex(0.7710737641656674,-2.6066264306850795)},3e-12),'complex math exp 96')
end
do
 local a=np.array({np.complex(0.0,0.5),np.complex(3.0,2.0),np.complex(-1.0,5.0),np.complex(-3.0,-0.0),np.complex(3.0,-1.0),np.complex(-1.0,2.0),np.complex(8.0,-1.0),np.complex(-3.0,-5.0),np.complex(-3.0,2.0),np.complex(-1.0,5.0),np.complex(3.0,-5.0)},np.complex128)
 local r=np.exp(a)
 assert(r.dtype=='complex128','complex math dtype 97')
 assert(list_same(r:tolist(),{np.complex(0.8775825618903728,0.479425538604203),np.complex(-8.358532650935372,18.263727040666765),np.complex(0.1043534862696817,-0.35276852628880606),np.complex(0.049787068367863944,-0.0),np.complex(10.852261914197959,-16.901396535150095),np.complex(-0.1530918656742263,0.33451182923926226),np.complex(1610.6184740946942,-2508.389653026968),np.complex(0.014122708621035348,0.04774202842225802),np.complex(-0.02071873100224288,0.045271253156092976),np.complex(0.1043534862696817,-0.35276852628880606),np.complex(5.697507299833739,19.26050892528742)},3e-12),'complex math exp 97')
end
do
 local a=np.array({np.complex(-8.0,0.5),np.complex(1.0,-5.0),np.complex(0.0,0.5),np.complex(8.0,-0.0),np.complex(8.0,-0.0),np.complex(-8.0,-1.0),np.complex(8.0,-1.0),np.complex(-0.0,0.0),np.complex(-0.0,-5.0),np.complex(-1.0,0.0),np.complex(-3.0,-0.0)},np.complex128)
 local r=np.exp(a)
 assert(r.dtype=='complex128','complex math dtype 98')
 assert(list_same(r:tolist(),{np.complex(0.0002943961524131632,0.00016082935106374307),np.complex(0.7710737641656674,2.6066264306850795),np.complex(0.8775825618903728,0.479425538604203),np.complex(2980.9579870417283,-0.0),np.complex(2980.9579870417283,-0.0),np.complex(0.00018125123138831292,-0.00028228206786737157),np.complex(1610.6184740946942,-2508.389653026968),np.complex(1.0,0.0),np.complex(0.28366218546322625,0.9589242746631385),np.complex(0.36787944117144233,0.0),np.complex(0.049787068367863944,-0.0)},3e-12),'complex math exp 98')
end
do
 local a=np.array({np.complex(-1.0,5.0),np.complex(-8.0,-1.0),np.complex(1.0,-5.0),np.complex(-0.0,-0.0),np.complex(1.0,5.0),np.complex(8.0,-0.0),np.complex(1.0,5.0),np.complex(0.0,-1.0),np.complex(8.0,5.0),np.complex(-3.0,-5.0),np.complex(-1.0,0.5)},np.complex128)
 local r=np.exp(a)
 assert(r.dtype=='complex128','complex math dtype 99')
 assert(list_same(r:tolist(),{np.complex(0.1043534862696817,-0.35276852628880606),np.complex(0.00018125123138831292,-0.00028228206786737157),np.complex(0.7710737641656674,2.6066264306850795),np.complex(1.0,-0.0),np.complex(0.7710737641656674,-2.6066264306850795),np.complex(2980.9579870417283,-0.0),np.complex(0.7710737641656674,-2.6066264306850795),np.complex(0.5403023058681398,-0.8414709848078965),np.complex(845.5850573783163,-2858.5129755252788),np.complex(0.014122708621035348,0.04774202842225802),np.complex(0.32284458245003306,0.17637079922503196)},3e-12),'complex math exp 99')
end
do
 local a=np.array({np.complex(-8.0,2.0),np.complex(1.0,0.5),np.complex(-3.0,2.0),np.complex(-3.0,-5.0),np.complex(0.25,0.5),np.complex(-8.0,-5.0),np.complex(-0.0,-1.0),np.complex(0.0,2.0),np.complex(8.0,-0.0),np.complex(-1.0,0.5),np.complex(0.0,2.0)},np.complex128)
 local r=np.exp(a)
 assert(r.dtype=='complex128','complex math dtype 100')
 assert(list_same(r:tolist(),{np.complex(-0.00013960171138142146,0.00030503530434793514),np.complex(2.3855167309591354,1.3032137296869954),np.complex(-0.02071873100224288,0.045271253156092976),np.complex(0.014122708621035348,0.04774202842225802),np.complex(1.1268383147091814,0.6155945769770066),np.complex(9.515806217206357e-05,0.0003216832571380065),np.complex(0.5403023058681398,-0.8414709848078965),np.complex(-0.4161468365471424,0.9092974268256817),np.complex(2980.9579870417283,-0.0),np.complex(0.32284458245003306,0.17637079922503196),np.complex(-0.4161468365471424,0.9092974268256817)},3e-12),'complex math exp 100')
end
do
 local a=np.array({np.complex(-3.0,5.0),np.complex(1.0,-0.0),np.complex(-3.0,2.0),np.complex(-3.0,0.0),np.complex(0.0,-5.0),np.complex(-1.0,0.5),np.complex(1.0,5.0),np.complex(0.0,-0.0),np.complex(8.0,0.5),np.complex(-0.0,-5.0),np.complex(-0.0,-1.0)},np.complex128)
 local r=np.exp(a)
 assert(r.dtype=='complex128','complex math dtype 101')
 assert(list_same(r:tolist(),{np.complex(0.014122708621035348,-0.04774202842225802),np.complex(2.718281828459045,-0.0),np.complex(-0.02071873100224288,0.045271253156092976),np.complex(0.049787068367863944,0.0),np.complex(0.28366218546322625,0.9589242746631385),np.complex(0.32284458245003306,0.17637079922503196),np.complex(0.7710737641656674,-2.6066264306850795),np.complex(1.0,-0.0),np.complex(2616.0367471556483,1429.1473884939815),np.complex(0.28366218546322625,0.9589242746631385),np.complex(0.5403023058681398,-0.8414709848078965)},3e-12),'complex math exp 101')
end
do
 local a=np.array({np.complex(-1.0,0.5),np.complex(-0.0,5.0),np.complex(-8.0,-5.0),np.complex(0.0,-5.0),np.complex(-3.0,0.0),np.complex(1.0,-0.0),np.complex(-3.0,5.0),np.complex(-3.0,0.0),np.complex(-0.0,0.5),np.complex(-0.0,5.0),np.complex(0.0,-1.0)},np.complex128)
 local r=np.exp(a)
 assert(r.dtype=='complex128','complex math dtype 102')
 assert(list_same(r:tolist(),{np.complex(0.32284458245003306,0.17637079922503196),np.complex(0.28366218546322625,-0.9589242746631385),np.complex(9.515806217206357e-05,0.0003216832571380065),np.complex(0.28366218546322625,0.9589242746631385),np.complex(0.049787068367863944,0.0),np.complex(2.718281828459045,-0.0),np.complex(0.014122708621035348,-0.04774202842225802),np.complex(0.049787068367863944,0.0),np.complex(0.8775825618903728,0.479425538604203),np.complex(0.28366218546322625,-0.9589242746631385),np.complex(0.5403023058681398,-0.8414709848078965)},3e-12),'complex math exp 102')
end
do
 local a=np.array({np.complex(-3.0,-0.0),np.complex(0.25,2.0),np.complex(-0.0,-0.0),np.complex(-3.0,-0.0),np.complex(0.25,2.0),np.complex(3.0,2.0),np.complex(1.0,-5.0),np.complex(-3.0,-0.0),np.complex(-0.0,-0.0),np.complex(3.0,5.0),np.complex(-3.0,0.0)},np.complex128)
 local r=np.exp(a)
 assert(r.dtype=='complex128','complex math dtype 103')
 assert(list_same(r:tolist(),{np.complex(0.049787068367863944,-0.0),np.complex(-0.53434311520073,1.167561007372937),np.complex(1.0,-0.0),np.complex(0.049787068367863944,-0.0),np.complex(-0.53434311520073,1.167561007372937),np.complex(-8.358532650935372,18.263727040666765),np.complex(0.7710737641656674,2.6066264306850795),np.complex(0.049787068367863944,-0.0),np.complex(1.0,-0.0),np.complex(5.697507299833739,-19.26050892528742),np.complex(0.049787068367863944,0.0)},3e-12),'complex math exp 103')
end
do
 local a=np.array({np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(-0.0,-0.0),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(0.0,math.huge),np.complex(0.0,-math.huge),np.complex(math.huge,1.0),np.complex(-math.huge,-1.0),np.complex((0/0),0.0),np.complex((0/0),2.0),np.complex(2.0,(0/0)),np.complex((0/0),(0/0))},np.complex128)
 local r=np.log(a)
 assert(r.dtype=='complex128','complex math dtype 104')
 assert(list_same(r:tolist(),{np.complex(-math.huge,0.0),np.complex(-math.huge,3.141592653589793),np.complex(-math.huge,-0.0),np.complex(-math.huge,-3.141592653589793),np.complex(math.huge,0.0),np.complex(math.huge,3.141592653589793),np.complex(math.huge,1.5707963267948966),np.complex(math.huge,-1.5707963267948966),np.complex(math.huge,0.0),np.complex(math.huge,-3.141592653589793),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},3e-12),'complex math log 104')
end
do
 local a=np.array({np.complex(0.0,0.5),np.complex(-0.0,5.0),np.complex(-3.0,-1.0),np.complex(-3.0,2.0),np.complex(-8.0,-5.0),np.complex(-8.0,0.5),np.complex(1.0,-5.0),np.complex(-8.0,2.0),np.complex(0.0,-1.0),np.complex(-0.0,0.0),np.complex(-3.0,-0.0)},np.complex128)
 local r=np.log(a)
 assert(r.dtype=='complex128','complex math dtype 105')
 assert(list_same(r:tolist(),{np.complex(-0.6931471805599453,1.5707963267948966),np.complex(1.6094379124341003,1.5707963267948966),np.complex(1.151292546497023,-2.819842099193151),np.complex(1.2824746787307684,2.5535900500422257),np.complex(2.24431818486607,-2.5829933382462307),np.complex(2.0813908618876646,3.079173843593836),np.complex(1.6290482690107408,-1.373400766945016),np.complex(2.1097538525880535,2.896613990462929),np.complex(0.0,-1.5707963267948966),np.complex(-math.huge,3.141592653589793),np.complex(1.0986122886681098,-3.141592653589793)},3e-12),'complex math log 105')
end
do
 local a=np.array({np.complex(0.0,-1.0),np.complex(8.0,-5.0),np.complex(-1.0,-0.0),np.complex(-3.0,-5.0),np.complex(-8.0,2.0),np.complex(-3.0,-1.0),np.complex(-0.0,2.0),np.complex(8.0,0.0),np.complex(1.0,5.0),np.complex(1.0,2.0),np.complex(0.25,5.0)},np.complex128)
 local r=np.log(a)
 assert(r.dtype=='complex128','complex math dtype 106')
 assert(list_same(r:tolist(),{np.complex(0.0,-1.5707963267948966),np.complex(2.24431818486607,-0.5585993153435624),np.complex(0.0,-3.141592653589793),np.complex(1.7631802623080808,-2.1112158270654806),np.complex(2.1097538525880535,2.896613990462929),np.complex(1.151292546497023,-2.819842099193151),np.complex(0.6931471805599453,1.5707963267948966),np.complex(2.0794415416798357,0.0),np.complex(1.6290482690107408,1.373400766945016),np.complex(0.8047189562170503,1.1071487177940904),np.complex(1.610686352533394,1.5208379310729538)},3e-12),'complex math log 106')
end
do
 local a=np.array({np.complex(-3.0,2.0),np.complex(-3.0,-5.0),np.complex(-3.0,-0.0),np.complex(0.25,0.5),np.complex(0.25,-5.0),np.complex(-1.0,5.0),np.complex(3.0,5.0),np.complex(-8.0,0.5),np.complex(0.25,2.0),np.complex(8.0,-1.0),np.complex(3.0,0.0)},np.complex128)
 local r=np.log(a)
 assert(r.dtype=='complex128','complex math dtype 107')
 assert(list_same(r:tolist(),{np.complex(1.2824746787307684,2.5535900500422257),np.complex(1.7631802623080808,-2.1112158270654806),np.complex(1.0986122886681098,-3.141592653589793),np.complex(-0.5815754049028404,1.1071487177940904),np.complex(1.610686352533394,-1.5208379310729538),np.complex(1.6290482690107408,1.7681918866447774),np.complex(1.7631802623080808,1.0303768265243125),np.complex(2.0813908618876646,3.079173843593836),np.complex(0.7008992738279278,1.446441332248135),np.complex(2.0871936349478184,-0.12435499454676144),np.complex(1.0986122886681098,0.0)},3e-12),'complex math log 107')
end
do
 local a=np.array({np.complex(0.0,2.0),np.complex(8.0,0.5),np.complex(-0.0,-0.0),np.complex(-3.0,-5.0),np.complex(3.0,0.0),np.complex(3.0,-1.0),np.complex(-0.0,0.5),np.complex(-0.0,-1.0),np.complex(0.0,0.0),np.complex(3.0,0.5),np.complex(0.0,-0.0)},np.complex128)
 local r=np.log(a)
 assert(r.dtype=='complex128','complex math dtype 108')
 assert(list_same(r:tolist(),{np.complex(0.6931471805599453,1.5707963267948966),np.complex(2.0813908618876646,0.06241880999595735),np.complex(-math.huge,-3.141592653589793),np.complex(1.7631802623080808,-2.1112158270654806),np.complex(1.0986122886681098,0.0),np.complex(1.151292546497023,-0.3217505543966422),np.complex(-0.6931471805599453,1.5707963267948966),np.complex(0.0,-1.5707963267948966),np.complex(-math.huge,0.0),np.complex(1.1123117757621668,0.16514867741462683),np.complex(-math.huge,-0.0)},3e-12),'complex math log 108')
end
do
 local a=np.array({np.complex(-8.0,0.0),np.complex(0.25,5.0),np.complex(3.0,0.0),np.complex(0.0,0.5),np.complex(0.0,2.0),np.complex(3.0,0.0),np.complex(-8.0,0.0),np.complex(0.25,0.5),np.complex(0.25,5.0),np.complex(0.0,2.0),np.complex(-1.0,0.5)},np.complex128)
 local r=np.log(a)
 assert(r.dtype=='complex128','complex math dtype 109')
 assert(list_same(r:tolist(),{np.complex(2.0794415416798357,3.141592653589793),np.complex(1.610686352533394,1.5208379310729538),np.complex(1.0986122886681098,0.0),np.complex(-0.6931471805599453,1.5707963267948966),np.complex(0.6931471805599453,1.5707963267948966),np.complex(1.0986122886681098,0.0),np.complex(2.0794415416798357,3.141592653589793),np.complex(-0.5815754049028404,1.1071487177940904),np.complex(1.610686352533394,1.5208379310729538),np.complex(0.6931471805599453,1.5707963267948966),np.complex(0.11157177565710488,2.677945044588987)},3e-12),'complex math log 109')
end
do
 local a=np.array({np.complex(3.0,-1.0),np.complex(-3.0,-5.0),np.complex(1.0,-1.0),np.complex(-3.0,-1.0),np.complex(0.25,0.0),np.complex(3.0,0.5),np.complex(8.0,5.0),np.complex(-1.0,5.0),np.complex(3.0,-5.0),np.complex(0.0,0.5),np.complex(3.0,2.0)},np.complex128)
 local r=np.log(a)
 assert(r.dtype=='complex128','complex math dtype 110')
 assert(list_same(r:tolist(),{np.complex(1.151292546497023,-0.3217505543966422),np.complex(1.7631802623080808,-2.1112158270654806),np.complex(0.34657359027997264,-0.7853981633974483),np.complex(1.151292546497023,-2.819842099193151),np.complex(-1.3862943611198906,0.0),np.complex(1.1123117757621668,0.16514867741462683),np.complex(2.24431818486607,0.5585993153435624),np.complex(1.6290482690107408,1.7681918866447774),np.complex(1.7631802623080808,-1.0303768265243125),np.complex(-0.6931471805599453,1.5707963267948966),np.complex(1.2824746787307684,0.5880026035475675)},3e-12),'complex math log 110')
end
do
 local a=np.array({np.complex(-3.0,0.0),np.complex(8.0,5.0),np.complex(-8.0,-0.0),np.complex(8.0,-1.0),np.complex(0.25,-0.0),np.complex(-3.0,5.0),np.complex(-3.0,-5.0),np.complex(-0.0,-5.0),np.complex(-8.0,-0.0),np.complex(-1.0,5.0),np.complex(3.0,-5.0)},np.complex128)
 local r=np.log(a)
 assert(r.dtype=='complex128','complex math dtype 111')
 assert(list_same(r:tolist(),{np.complex(1.0986122886681098,3.141592653589793),np.complex(2.24431818486607,0.5585993153435624),np.complex(2.0794415416798357,-3.141592653589793),np.complex(2.0871936349478184,-0.12435499454676144),np.complex(-1.3862943611198906,-0.0),np.complex(1.7631802623080808,2.1112158270654806),np.complex(1.7631802623080808,-2.1112158270654806),np.complex(1.6094379124341003,-1.5707963267948966),np.complex(2.0794415416798357,-3.141592653589793),np.complex(1.6290482690107408,1.7681918866447774),np.complex(1.7631802623080808,-1.0303768265243125)},3e-12),'complex math log 111')
end
do
 local a=np.array({np.complex(-3.0,-0.0),np.complex(0.0,0.0),np.complex(-8.0,-5.0),np.complex(-0.0,-5.0),np.complex(1.0,5.0),np.complex(0.25,2.0),np.complex(-8.0,-0.0),np.complex(-8.0,5.0),np.complex(1.0,-0.0),np.complex(-3.0,-5.0),np.complex(-1.0,5.0)},np.complex128)
 local r=np.log(a)
 assert(r.dtype=='complex128','complex math dtype 112')
 assert(list_same(r:tolist(),{np.complex(1.0986122886681098,-3.141592653589793),np.complex(-math.huge,0.0),np.complex(2.24431818486607,-2.5829933382462307),np.complex(1.6094379124341003,-1.5707963267948966),np.complex(1.6290482690107408,1.373400766945016),np.complex(0.7008992738279278,1.446441332248135),np.complex(2.0794415416798357,-3.141592653589793),np.complex(2.24431818486607,2.5829933382462307),np.complex(0.0,-0.0),np.complex(1.7631802623080808,-2.1112158270654806),np.complex(1.6290482690107408,1.7681918866447774)},3e-12),'complex math log 112')
end
do
 local a=np.array({np.complex(0.25,2.0),np.complex(1.0,0.5),np.complex(-1.0,2.0),np.complex(-0.0,-0.0),np.complex(-1.0,2.0),np.complex(-0.0,-1.0),np.complex(-1.0,-1.0),np.complex(1.0,-1.0),np.complex(-8.0,5.0),np.complex(3.0,2.0),np.complex(0.25,-1.0)},np.complex128)
 local r=np.log(a)
 assert(r.dtype=='complex128','complex math dtype 113')
 assert(list_same(r:tolist(),{np.complex(0.7008992738279278,1.446441332248135),np.complex(0.11157177565710488,0.4636476090008061),np.complex(0.8047189562170503,2.0344439357957027),np.complex(-math.huge,-3.141592653589793),np.complex(0.8047189562170503,2.0344439357957027),np.complex(0.0,-1.5707963267948966),np.complex(0.34657359027997264,-2.356194490192345),np.complex(0.34657359027997264,-0.7853981633974483),np.complex(2.24431818486607,2.5829933382462307),np.complex(1.2824746787307684,0.5880026035475675),np.complex(0.03031231090821742,-1.3258176636680326)},3e-12),'complex math log 113')
end
do
 local a=np.array({np.complex(-0.0,-5.0),np.complex(0.25,-1.0),np.complex(1.0,-0.0),np.complex(0.25,0.5),np.complex(0.0,5.0),np.complex(0.25,-1.0),np.complex(-8.0,-5.0),np.complex(-8.0,-0.0),np.complex(-1.0,0.0),np.complex(3.0,-5.0),np.complex(-1.0,0.5)},np.complex128)
 local r=np.log(a)
 assert(r.dtype=='complex128','complex math dtype 114')
 assert(list_same(r:tolist(),{np.complex(1.6094379124341003,-1.5707963267948966),np.complex(0.03031231090821742,-1.3258176636680326),np.complex(0.0,-0.0),np.complex(-0.5815754049028404,1.1071487177940904),np.complex(1.6094379124341003,1.5707963267948966),np.complex(0.03031231090821742,-1.3258176636680326),np.complex(2.24431818486607,-2.5829933382462307),np.complex(2.0794415416798357,-3.141592653589793),np.complex(0.0,3.141592653589793),np.complex(1.7631802623080808,-1.0303768265243125),np.complex(0.11157177565710488,2.677945044588987)},3e-12),'complex math log 114')
end
do
 local a=np.array({np.complex(-1.0,0.0),np.complex(0.0,-1.0),np.complex(1.0,-0.0),np.complex(3.0,5.0),np.complex(8.0,0.0),np.complex(8.0,0.5),np.complex(1.0,0.0),np.complex(-8.0,2.0),np.complex(-1.0,-1.0),np.complex(1.0,-5.0),np.complex(3.0,-1.0)},np.complex128)
 local r=np.log(a)
 assert(r.dtype=='complex128','complex math dtype 115')
 assert(list_same(r:tolist(),{np.complex(0.0,3.141592653589793),np.complex(0.0,-1.5707963267948966),np.complex(0.0,-0.0),np.complex(1.7631802623080808,1.0303768265243125),np.complex(2.0794415416798357,0.0),np.complex(2.0813908618876646,0.06241880999595735),np.complex(0.0,0.0),np.complex(2.1097538525880535,2.896613990462929),np.complex(0.34657359027997264,-2.356194490192345),np.complex(1.6290482690107408,-1.373400766945016),np.complex(1.151292546497023,-0.3217505543966422)},3e-12),'complex math log 115')
end
do
 local a=np.array({np.complex(-3.0,0.0),np.complex(3.0,2.0),np.complex(1.0,-5.0),np.complex(8.0,-1.0),np.complex(3.0,-1.0),np.complex(0.25,2.0),np.complex(8.0,-5.0),np.complex(-1.0,-1.0),np.complex(-8.0,-1.0),np.complex(-8.0,0.5),np.complex(-8.0,0.5)},np.complex128)
 local r=np.log(a)
 assert(r.dtype=='complex128','complex math dtype 116')
 assert(list_same(r:tolist(),{np.complex(1.0986122886681098,3.141592653589793),np.complex(1.2824746787307684,0.5880026035475675),np.complex(1.6290482690107408,-1.373400766945016),np.complex(2.0871936349478184,-0.12435499454676144),np.complex(1.151292546497023,-0.3217505543966422),np.complex(0.7008992738279278,1.446441332248135),np.complex(2.24431818486607,-0.5585993153435624),np.complex(0.34657359027997264,-2.356194490192345),np.complex(2.0871936349478184,-3.017237659043032),np.complex(2.0813908618876646,3.079173843593836),np.complex(2.0813908618876646,3.079173843593836)},3e-12),'complex math log 116')
end
do
 local a=np.array({np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(-0.0,-0.0),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(0.0,math.huge),np.complex(0.0,-math.huge),np.complex(math.huge,1.0),np.complex(-math.huge,-1.0),np.complex((0/0),0.0),np.complex((0/0),2.0),np.complex(2.0,(0/0)),np.complex((0/0),(0/0))},np.complex128)
 local r=np.sin(a)
 assert(r.dtype=='complex128','complex math dtype 117')
 assert(list_same(r:tolist(),{np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(-0.0,-0.0),np.complex((0/0),0.0),np.complex((0/0),0.0),np.complex(0.0,math.huge),np.complex(0.0,-math.huge),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),0.0),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},3e-12),'complex math sin 117')
end
do
 local a=np.array({np.complex(-1.0,0.0),np.complex(3.0,-1.0),np.complex(0.25,0.0),np.complex(0.0,5.0),np.complex(-8.0,-1.0),np.complex(-3.0,-0.0),np.complex(0.0,5.0),np.complex(0.0,0.5),np.complex(-1.0,0.5),np.complex(1.0,-1.0),np.complex(1.0,-0.0)},np.complex128)
 local r=np.sin(a)
 assert(r.dtype=='complex128','complex math dtype 118')
 assert(list_same(r:tolist(),{np.complex(-0.8414709848078965,0.0),np.complex(0.21775955162215221,1.1634403637032504),np.complex(0.24740395925452294,0.0),np.complex(0.0,74.20321057778875),np.complex(-1.5266595512593044,0.1709918134070961),np.complex(-0.1411200080598672,0.0),np.complex(0.0,74.20321057778875),np.complex(0.0,0.5210953054937474),np.complex(-0.948864531437168,0.28154899513533443),np.complex(1.2984575814159773,-0.6349639147847361),np.complex(0.8414709848078965,-0.0)},3e-12),'complex math sin 118')
end
do
 local a=np.array({np.complex(1.0,-0.0),np.complex(8.0,-5.0),np.complex(1.0,2.0),np.complex(1.0,5.0),np.complex(1.0,-5.0),np.complex(-1.0,2.0),np.complex(-8.0,-5.0),np.complex(-3.0,-5.0),np.complex(3.0,2.0),np.complex(-8.0,0.5),np.complex(1.0,2.0)},np.complex128)
 local r=np.sin(a)
 assert(r.dtype=='complex128','complex math dtype 119')
 assert(list_same(r:tolist(),{np.complex(0.8414709848078965,-0.0),np.complex(73.42022455449552,10.796569647775932),np.complex(3.165778513216168,1.9596010414216063),np.complex(62.44551846769654,40.0921657779984),np.complex(62.44551846769654,-40.0921657779984),np.complex(-3.165778513216168,1.9596010414216063),np.complex(-73.42022455449552,10.796569647775932),np.complex(-10.472508533940392,73.46062169567367),np.complex(0.5309210862485197,-3.59056458998578),np.complex(-1.1156260477835833,-0.07581938456685004),np.complex(3.165778513216168,1.9596010414216063)},3e-12),'complex math sin 119')
end
do
 local a=np.array({np.complex(1.0,5.0),np.complex(-8.0,-0.0),np.complex(-1.0,-0.0),np.complex(0.25,5.0),np.complex(-3.0,-5.0),np.complex(-3.0,5.0),np.complex(3.0,-1.0),np.complex(3.0,-1.0),np.complex(0.0,5.0),np.complex(0.0,0.0),np.complex(8.0,-1.0)},np.complex128)
 local r=np.sin(a)
 assert(r.dtype=='complex128','complex math dtype 120')
 assert(list_same(r:tolist(),{np.complex(62.44551846769654,40.0921657779984),np.complex(-0.9893582466233818,0.0),np.complex(-0.8414709848078965,-0.0),np.complex(18.35983508110686,71.89641245963023),np.complex(-10.472508533940392,73.46062169567367),np.complex(-10.472508533940392,-73.46062169567367),np.complex(0.21775955162215221,1.1634403637032504),np.complex(0.21775955162215221,1.1634403637032504),np.complex(0.0,74.20321057778875),np.complex(0.0,0.0),np.complex(1.5266595512593044,0.1709918134070961)},3e-12),'complex math sin 120')
end
do
 local a=np.array({np.complex(-8.0,0.0),np.complex(1.0,0.0),np.complex(0.25,-5.0),np.complex(0.0,-0.0),np.complex(0.0,0.0),np.complex(-0.0,2.0),np.complex(-1.0,0.0),np.complex(1.0,-0.0),np.complex(0.0,5.0),np.complex(0.25,-5.0),np.complex(-8.0,-1.0)},np.complex128)
 local r=np.sin(a)
 assert(r.dtype=='complex128','complex math dtype 121')
 assert(list_same(r:tolist(),{np.complex(-0.9893582466233818,-0.0),np.complex(0.8414709848078965,0.0),np.complex(18.35983508110686,-71.89641245963023),np.complex(0.0,-0.0),np.complex(0.0,0.0),np.complex(-0.0,3.626860407847019),np.complex(-0.8414709848078965,0.0),np.complex(0.8414709848078965,-0.0),np.complex(0.0,74.20321057778875),np.complex(18.35983508110686,-71.89641245963023),np.complex(-1.5266595512593044,0.1709918134070961)},3e-12),'complex math sin 121')
end
do
 local a=np.array({np.complex(0.25,-5.0),np.complex(3.0,-5.0),np.complex(1.0,-1.0),np.complex(1.0,2.0),np.complex(0.25,-5.0),np.complex(-3.0,0.5),np.complex(-3.0,5.0),np.complex(1.0,0.5),np.complex(-8.0,0.5),np.complex(3.0,2.0),np.complex(3.0,-1.0)},np.complex128)
 local r=np.sin(a)
 assert(r.dtype=='complex128','complex math dtype 122')
 assert(list_same(r:tolist(),{np.complex(18.35983508110686,-71.89641245963023),np.complex(10.472508533940392,73.46062169567367),np.complex(1.2984575814159773,-0.6349639147847361),np.complex(3.165778513216168,1.9596010414216063),np.complex(18.35983508110686,-71.89641245963023),np.complex(-0.15913058529843999,-0.5158804424525267),np.complex(-10.472508533940392,-73.46062169567367),np.complex(0.948864531437168,0.28154899513533443),np.complex(-1.1156260477835833,-0.07581938456685004),np.complex(0.5309210862485197,-3.59056458998578),np.complex(0.21775955162215221,1.1634403637032504)},3e-12),'complex math sin 122')
end
do
 local a=np.array({np.complex(0.0,2.0),np.complex(3.0,-5.0),np.complex(-1.0,0.0),np.complex(0.0,-1.0),np.complex(0.0,-5.0),np.complex(0.0,-1.0),np.complex(0.0,2.0),np.complex(-3.0,-5.0),np.complex(0.0,5.0),np.complex(8.0,2.0),np.complex(-1.0,-0.0)},np.complex128)
 local r=np.sin(a)
 assert(r.dtype=='complex128','complex math dtype 123')
 assert(list_same(r:tolist(),{np.complex(0.0,3.626860407847019),np.complex(10.472508533940392,73.46062169567367),np.complex(-0.8414709848078965,0.0),np.complex(0.0,-1.1752011936438014),np.complex(0.0,-74.20321057778875),np.complex(0.0,-1.1752011936438014),np.complex(0.0,3.626860407847019),np.complex(-10.472508533940392,73.46062169567367),np.complex(0.0,74.20321057778875),np.complex(3.722159332384544,-0.5277083119608632),np.complex(-0.8414709848078965,-0.0)},3e-12),'complex math sin 123')
end
do
 local a=np.array({np.complex(-1.0,-0.0),np.complex(1.0,-5.0),np.complex(-0.0,0.0),np.complex(-1.0,-0.0),np.complex(-8.0,2.0),np.complex(-3.0,-1.0),np.complex(-8.0,-1.0),np.complex(8.0,2.0),np.complex(-1.0,5.0),np.complex(8.0,-1.0),np.complex(-3.0,-1.0)},np.complex128)
 local r=np.sin(a)
 assert(r.dtype=='complex128','complex math dtype 124')
 assert(list_same(r:tolist(),{np.complex(-0.8414709848078965,-0.0),np.complex(62.44551846769654,-40.0921657779984),np.complex(-0.0,0.0),np.complex(-0.8414709848078965,-0.0),np.complex(-3.722159332384544,-0.5277083119608632),np.complex(-0.21775955162215221,1.1634403637032504),np.complex(-1.5266595512593044,0.1709918134070961),np.complex(3.722159332384544,-0.5277083119608632),np.complex(-62.44551846769654,40.0921657779984),np.complex(1.5266595512593044,0.1709918134070961),np.complex(-0.21775955162215221,1.1634403637032504)},3e-12),'complex math sin 124')
end
do
 local a=np.array({np.complex(8.0,0.0),np.complex(0.25,5.0),np.complex(0.25,0.5),np.complex(8.0,-0.0),np.complex(-3.0,-0.0),np.complex(0.0,-0.0),np.complex(0.25,-1.0),np.complex(-0.0,-0.0),np.complex(1.0,-1.0),np.complex(0.25,-5.0),np.complex(3.0,-0.0)},np.complex128)
 local r=np.sin(a)
 assert(r.dtype=='complex128','complex math dtype 125')
 assert(list_same(r:tolist(),{np.complex(0.9893582466233818,-0.0),np.complex(18.35983508110686,71.89641245963023),np.complex(0.2789791283502615,0.504895714387995),np.complex(0.9893582466233818,0.0),np.complex(-0.1411200080598672,0.0),np.complex(0.0,-0.0),np.complex(0.38176425850227397,-1.138667034530656),np.complex(-0.0,-0.0),np.complex(1.2984575814159773,-0.6349639147847361),np.complex(18.35983508110686,-71.89641245963023),np.complex(0.1411200080598672,0.0)},3e-12),'complex math sin 125')
end
do
 local a=np.array({np.complex(-0.0,2.0),np.complex(0.0,-1.0),np.complex(1.0,-0.0),np.complex(3.0,-0.0),np.complex(8.0,-1.0),np.complex(-8.0,5.0),np.complex(1.0,0.0),np.complex(-0.0,-0.0),np.complex(-0.0,2.0),np.complex(-3.0,-1.0),np.complex(-3.0,-1.0)},np.complex128)
 local r=np.sin(a)
 assert(r.dtype=='complex128','complex math dtype 126')
 assert(list_same(r:tolist(),{np.complex(-0.0,3.626860407847019),np.complex(0.0,-1.1752011936438014),np.complex(0.8414709848078965,-0.0),np.complex(0.1411200080598672,0.0),np.complex(1.5266595512593044,0.1709918134070961),np.complex(-73.42022455449552,-10.796569647775932),np.complex(0.8414709848078965,0.0),np.complex(-0.0,-0.0),np.complex(-0.0,3.626860407847019),np.complex(-0.21775955162215221,1.1634403637032504),np.complex(-0.21775955162215221,1.1634403637032504)},3e-12),'complex math sin 126')
end
do
 local a=np.array({np.complex(-1.0,2.0),np.complex(-3.0,5.0),np.complex(1.0,-5.0),np.complex(-8.0,5.0),np.complex(-8.0,-1.0),np.complex(-8.0,0.5),np.complex(8.0,0.5),np.complex(-8.0,2.0),np.complex(-3.0,-5.0),np.complex(0.25,0.5),np.complex(-8.0,0.0)},np.complex128)
 local r=np.sin(a)
 assert(r.dtype=='complex128','complex math dtype 127')
 assert(list_same(r:tolist(),{np.complex(-3.165778513216168,1.9596010414216063),np.complex(-10.472508533940392,-73.46062169567367),np.complex(62.44551846769654,-40.0921657779984),np.complex(-73.42022455449552,-10.796569647775932),np.complex(-1.5266595512593044,0.1709918134070961),np.complex(-1.1156260477835833,-0.07581938456685004),np.complex(1.1156260477835833,-0.07581938456685004),np.complex(-3.722159332384544,-0.5277083119608632),np.complex(-10.472508533940392,73.46062169567367),np.complex(0.2789791283502615,0.504895714387995),np.complex(-0.9893582466233818,-0.0)},3e-12),'complex math sin 127')
end
do
 local a=np.array({np.complex(0.0,2.0),np.complex(-3.0,-0.0),np.complex(0.25,-0.0),np.complex(-0.0,0.0),np.complex(-1.0,2.0),np.complex(-0.0,0.5),np.complex(0.0,-1.0),np.complex(-1.0,5.0),np.complex(-3.0,5.0),np.complex(-0.0,5.0),np.complex(1.0,-0.0)},np.complex128)
 local r=np.sin(a)
 assert(r.dtype=='complex128','complex math dtype 128')
 assert(list_same(r:tolist(),{np.complex(0.0,3.626860407847019),np.complex(-0.1411200080598672,0.0),np.complex(0.24740395925452294,-0.0),np.complex(-0.0,0.0),np.complex(-3.165778513216168,1.9596010414216063),np.complex(-0.0,0.5210953054937474),np.complex(0.0,-1.1752011936438014),np.complex(-62.44551846769654,40.0921657779984),np.complex(-10.472508533940392,-73.46062169567367),np.complex(-0.0,74.20321057778875),np.complex(0.8414709848078965,-0.0)},3e-12),'complex math sin 128')
end
do
 local a=np.array({np.complex(0.0,0.0),np.complex(-0.0,-5.0),np.complex(1.0,5.0),np.complex(0.0,-0.0),np.complex(8.0,-5.0),np.complex(-8.0,-5.0),np.complex(8.0,2.0),np.complex(1.0,-0.0),np.complex(-0.0,0.5),np.complex(3.0,2.0),np.complex(-3.0,-5.0)},np.complex128)
 local r=np.sin(a)
 assert(r.dtype=='complex128','complex math dtype 129')
 assert(list_same(r:tolist(),{np.complex(0.0,0.0),np.complex(-0.0,-74.20321057778875),np.complex(62.44551846769654,40.0921657779984),np.complex(0.0,-0.0),np.complex(73.42022455449552,10.796569647775932),np.complex(-73.42022455449552,10.796569647775932),np.complex(3.722159332384544,-0.5277083119608632),np.complex(0.8414709848078965,-0.0),np.complex(-0.0,0.5210953054937474),np.complex(0.5309210862485197,-3.59056458998578),np.complex(-10.472508533940392,73.46062169567367)},3e-12),'complex math sin 129')
end
do
 local a=np.array({np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(-0.0,-0.0),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(0.0,math.huge),np.complex(0.0,-math.huge),np.complex(math.huge,1.0),np.complex(-math.huge,-1.0),np.complex((0/0),0.0),np.complex((0/0),2.0),np.complex(2.0,(0/0)),np.complex((0/0),(0/0))},np.complex128)
 local r=np.cos(a)
 assert(r.dtype=='complex128','complex math dtype 130')
 assert(list_same(r:tolist(),{np.complex(1.0,-0.0),np.complex(1.0,0.0),np.complex(1.0,0.0),np.complex(1.0,-0.0),np.complex((0/0),0.0),np.complex((0/0),0.0),np.complex(math.huge,-0.0),np.complex(math.huge,0.0),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),0.0),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},3e-12),'complex math cos 130')
end
do
 local a=np.array({np.complex(-1.0,0.0),np.complex(0.25,-0.0),np.complex(0.25,0.0),np.complex(3.0,5.0),np.complex(3.0,-1.0),np.complex(0.0,5.0),np.complex(8.0,5.0),np.complex(3.0,0.5),np.complex(8.0,-0.0),np.complex(-1.0,-5.0),np.complex(-0.0,0.5)},np.complex128)
 local r=np.cos(a)
 assert(r.dtype=='complex128','complex math dtype 131')
 assert(list_same(r:tolist(),{np.complex(0.5403023058681398,0.0),np.complex(0.9689124217106447,0.0),np.complex(0.9689124217106447,-0.0),np.complex(-73.46729221264526,-10.471557674805572),np.complex(-1.5276382501165433,0.1658444019189788),np.complex(74.20994852478785,-0.0),np.complex(-10.797550019292101,-73.41355831106665),np.complex(-1.1163412445261518,-0.0735369737112366),np.complex(-0.14550003380861354,0.0),np.complex(40.09580630629883,-62.43984868079963),np.complex(1.1276259652063807,0.0)},3e-12),'complex math cos 131')
end
do
 local a=np.array({np.complex(-8.0,5.0),np.complex(3.0,0.0),np.complex(-0.0,5.0),np.complex(1.0,2.0),np.complex(-1.0,2.0),np.complex(0.0,0.0),np.complex(8.0,-5.0),np.complex(-8.0,0.5),np.complex(-3.0,-1.0),np.complex(-0.0,5.0),np.complex(3.0,-5.0)},np.complex128)
 local r=np.cos(a)
 assert(r.dtype=='complex128','complex math dtype 132')
 assert(list_same(r:tolist(),{np.complex(-10.797550019292101,73.41355831106665),np.complex(-0.9899924966004454,-0.0),np.complex(74.20994852478785,0.0),np.complex(2.0327230070196656,-3.0518977991518),np.complex(2.0327230070196656,3.0518977991518),np.complex(1.0,-0.0),np.complex(-10.797550019292101,73.41355831106665),np.complex(-0.16406961606099887,0.5155499377669694),np.complex(-1.5276382501165433,-0.1658444019189788),np.complex(74.20994852478785,0.0),np.complex(-73.46729221264526,10.471557674805572)},3e-12),'complex math cos 132')
end
do
 local a=np.array({np.complex(0.25,0.0),np.complex(-0.0,5.0),np.complex(1.0,-5.0),np.complex(1.0,-5.0),np.complex(-8.0,-0.0),np.complex(0.25,0.5),np.complex(1.0,0.0),np.complex(1.0,-5.0),np.complex(-0.0,-1.0),np.complex(0.25,0.0),np.complex(0.25,0.0)},np.complex128)
 local r=np.cos(a)
 assert(r.dtype=='complex128','complex math dtype 133')
 assert(list_same(r:tolist(),{np.complex(0.9689124217106447,-0.0),np.complex(74.20994852478785,0.0),np.complex(40.09580630629883,62.43984868079963),np.complex(40.09580630629883,62.43984868079963),np.complex(-0.14550003380861354,-0.0),np.complex(1.0925708047319176,-0.12892104172809826),np.complex(0.5403023058681398,-0.0),np.complex(40.09580630629883,62.43984868079963),np.complex(1.5430806348152437,-0.0),np.complex(0.9689124217106447,-0.0),np.complex(0.9689124217106447,-0.0)},3e-12),'complex math cos 133')
end
do
 local a=np.array({np.complex(1.0,2.0),np.complex(-1.0,-1.0),np.complex(1.0,0.5),np.complex(8.0,0.5),np.complex(-0.0,0.0),np.complex(1.0,-0.0),np.complex(0.25,0.0),np.complex(-1.0,-5.0),np.complex(-1.0,5.0),np.complex(8.0,5.0),np.complex(-3.0,-0.0)},np.complex128)
 local r=np.cos(a)
 assert(r.dtype=='complex128','complex math dtype 134')
 assert(list_same(r:tolist(),{np.complex(2.0327230070196656,-3.0518977991518),np.complex(0.8337300251311491,-0.9888977057628651),np.complex(0.6092589091577942,-0.4384865798925953),np.complex(-0.16406961606099887,-0.5155499377669694),np.complex(1.0,0.0),np.complex(0.5403023058681398,0.0),np.complex(0.9689124217106447,-0.0),np.complex(40.09580630629883,-62.43984868079963),np.complex(40.09580630629883,62.43984868079963),np.complex(-10.797550019292101,-73.41355831106665),np.complex(-0.9899924966004454,-0.0)},3e-12),'complex math cos 134')
end
do
 local a=np.array({np.complex(0.25,2.0),np.complex(0.0,2.0),np.complex(1.0,2.0),np.complex(1.0,2.0),np.complex(-0.0,2.0),np.complex(1.0,-5.0),np.complex(-8.0,0.0),np.complex(8.0,-1.0),np.complex(0.0,0.0),np.complex(8.0,0.5),np.complex(-3.0,-0.0)},np.complex128)
 local r=np.cos(a)
 assert(r.dtype=='complex128','complex math dtype 135')
 assert(list_same(r:tolist(),{np.complex(3.645238137997194,-0.8972996245648264),np.complex(3.7621956910836314,-0.0),np.complex(2.0327230070196656,-3.0518977991518),np.complex(2.0327230070196656,-3.0518977991518),np.complex(3.7621956910836314,0.0),np.complex(40.09580630629883,62.43984868079963),np.complex(-0.14550003380861354,0.0),np.complex(-0.2245182845350348,1.1626949923731367),np.complex(1.0,-0.0),np.complex(-0.16406961606099887,-0.5155499377669694),np.complex(-0.9899924966004454,-0.0)},3e-12),'complex math cos 135')
end
do
 local a=np.array({np.complex(3.0,-1.0),np.complex(0.25,0.5),np.complex(-8.0,-5.0),np.complex(-3.0,5.0),np.complex(-3.0,2.0),np.complex(0.0,5.0),np.complex(1.0,5.0),np.complex(-1.0,-1.0),np.complex(-1.0,-0.0),np.complex(1.0,0.5),np.complex(3.0,-5.0)},np.complex128)
 local r=np.cos(a)
 assert(r.dtype=='complex128','complex math dtype 136')
 assert(list_same(r:tolist(),{np.complex(-1.5276382501165433,0.1658444019189788),np.complex(1.0925708047319176,-0.12892104172809826),np.complex(-10.797550019292101,-73.41355831106665),np.complex(-73.46729221264526,10.471557674805572),np.complex(-3.7245455049153224,0.5118225699873846),np.complex(74.20994852478785,-0.0),np.complex(40.09580630629883,-62.43984868079963),np.complex(0.8337300251311491,-0.9888977057628651),np.complex(0.5403023058681398,-0.0),np.complex(0.6092589091577942,-0.4384865798925953),np.complex(-73.46729221264526,10.471557674805572)},3e-12),'complex math cos 136')
end
do
 local a=np.array({np.complex(8.0,-5.0),np.complex(1.0,0.0),np.complex(-3.0,0.5),np.complex(0.25,-1.0),np.complex(0.25,0.5),np.complex(0.0,2.0),np.complex(-0.0,2.0),np.complex(-0.0,-0.0),np.complex(1.0,-0.0),np.complex(-1.0,0.5),np.complex(0.25,-0.0)},np.complex128)
 local r=np.cos(a)
 assert(r.dtype=='complex128','complex math dtype 137')
 assert(list_same(r:tolist(),{np.complex(-10.797550019292101,73.41355831106665),np.complex(0.5403023058681398,-0.0),np.complex(-1.1163412445261518,0.0735369737112366),np.complex(1.4951099947736368,0.2907494282281178),np.complex(1.0925708047319176,-0.12892104172809826),np.complex(3.7621956910836314,-0.0),np.complex(3.7621956910836314,0.0),np.complex(1.0,-0.0),np.complex(0.5403023058681398,0.0),np.complex(0.6092589091577942,0.4384865798925953),np.complex(0.9689124217106447,0.0)},3e-12),'complex math cos 137')
end
do
 local a=np.array({np.complex(-1.0,0.5),np.complex(-0.0,-0.0),np.complex(0.25,-1.0),np.complex(-1.0,0.0),np.complex(8.0,0.0),np.complex(1.0,-5.0),np.complex(-8.0,-1.0),np.complex(-0.0,5.0),np.complex(8.0,-1.0),np.complex(0.25,-5.0),np.complex(3.0,5.0)},np.complex128)
 local r=np.cos(a)
 assert(r.dtype=='complex128','complex math dtype 138')
 assert(list_same(r:tolist(),{np.complex(0.6092589091577942,0.4384865798925953),np.complex(1.0,-0.0),np.complex(1.4951099947736368,0.2907494282281178),np.complex(0.5403023058681398,0.0),np.complex(-0.14550003380861354,-0.0),np.complex(40.09580630629883,62.43984868079963),np.complex(-0.2245182845350348,-1.1626949923731367),np.complex(74.20994852478785,0.0),np.complex(-0.2245182845350348,1.1626949923731367),np.complex(71.90294094017447,18.358168086342033),np.complex(-73.46729221264526,-10.471557674805572)},3e-12),'complex math cos 138')
end
do
 local a=np.array({np.complex(-1.0,5.0),np.complex(-1.0,-1.0),np.complex(-3.0,-1.0),np.complex(0.0,-0.0),np.complex(-8.0,0.5),np.complex(-1.0,5.0),np.complex(3.0,-1.0),np.complex(8.0,-1.0),np.complex(-0.0,5.0),np.complex(-0.0,-5.0),np.complex(0.0,0.5)},np.complex128)
 local r=np.cos(a)
 assert(r.dtype=='complex128','complex math dtype 139')
 assert(list_same(r:tolist(),{np.complex(40.09580630629883,62.43984868079963),np.complex(0.8337300251311491,-0.9888977057628651),np.complex(-1.5276382501165433,-0.1658444019189788),np.complex(1.0,0.0),np.complex(-0.16406961606099887,0.5155499377669694),np.complex(40.09580630629883,62.43984868079963),np.complex(-1.5276382501165433,0.1658444019189788),np.complex(-0.2245182845350348,1.1626949923731367),np.complex(74.20994852478785,0.0),np.complex(74.20994852478785,-0.0),np.complex(1.1276259652063807,-0.0)},3e-12),'complex math cos 139')
end
do
 local a=np.array({np.complex(0.0,5.0),np.complex(-1.0,5.0),np.complex(0.25,5.0),np.complex(-0.0,-1.0),np.complex(8.0,5.0),np.complex(-0.0,5.0),np.complex(0.0,-5.0),np.complex(-0.0,-0.0),np.complex(-0.0,0.0),np.complex(-3.0,0.5),np.complex(-0.0,-1.0)},np.complex128)
 local r=np.cos(a)
 assert(r.dtype=='complex128','complex math dtype 140')
 assert(list_same(r:tolist(),{np.complex(74.20994852478785,-0.0),np.complex(40.09580630629883,62.43984868079963),np.complex(71.90294094017447,-18.358168086342033),np.complex(1.5430806348152437,-0.0),np.complex(-10.797550019292101,-73.41355831106665),np.complex(74.20994852478785,0.0),np.complex(74.20994852478785,0.0),np.complex(1.0,-0.0),np.complex(1.0,0.0),np.complex(-1.1163412445261518,0.0735369737112366),np.complex(1.5430806348152437,-0.0)},3e-12),'complex math cos 140')
end
do
 local a=np.array({np.complex(1.0,-5.0),np.complex(-1.0,-0.0),np.complex(-0.0,2.0),np.complex(-3.0,-0.0),np.complex(0.25,-0.0),np.complex(-8.0,-1.0),np.complex(8.0,-1.0),np.complex(0.0,0.0),np.complex(-0.0,0.5),np.complex(0.25,0.0),np.complex(8.0,5.0)},np.complex128)
 local r=np.cos(a)
 assert(r.dtype=='complex128','complex math dtype 141')
 assert(list_same(r:tolist(),{np.complex(40.09580630629883,62.43984868079963),np.complex(0.5403023058681398,-0.0),np.complex(3.7621956910836314,0.0),np.complex(-0.9899924966004454,-0.0),np.complex(0.9689124217106447,0.0),np.complex(-0.2245182845350348,-1.1626949923731367),np.complex(-0.2245182845350348,1.1626949923731367),np.complex(1.0,-0.0),np.complex(1.1276259652063807,0.0),np.complex(0.9689124217106447,-0.0),np.complex(-10.797550019292101,-73.41355831106665)},3e-12),'complex math cos 141')
end
do
 local a=np.array({np.complex(8.0,0.5),np.complex(8.0,2.0),np.complex(-1.0,2.0),np.complex(-1.0,0.5),np.complex(0.0,2.0),np.complex(-0.0,5.0),np.complex(0.25,0.5),np.complex(-3.0,-5.0),np.complex(-1.0,5.0),np.complex(1.0,-5.0),np.complex(0.25,-5.0)},np.complex128)
 local r=np.cos(a)
 assert(r.dtype=='complex128','complex math dtype 142')
 assert(list_same(r:tolist(),{np.complex(-0.16406961606099887,-0.5155499377669694),np.complex(-0.5473996002472885,-3.5882642538552902),np.complex(2.0327230070196656,3.0518977991518),np.complex(0.6092589091577942,0.4384865798925953),np.complex(3.7621956910836314,-0.0),np.complex(74.20994852478785,0.0),np.complex(1.0925708047319176,-0.12892104172809826),np.complex(-73.46729221264526,-10.471557674805572),np.complex(40.09580630629883,62.43984868079963),np.complex(40.09580630629883,62.43984868079963),np.complex(71.90294094017447,18.358168086342033)},3e-12),'complex math cos 142')
end
do
 local a=np.array({np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(-0.0,-0.0),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(0.0,math.huge),np.complex(0.0,-math.huge),np.complex(math.huge,1.0),np.complex(-math.huge,-1.0),np.complex((0/0),0.0),np.complex((0/0),2.0),np.complex(2.0,(0/0)),np.complex((0/0),(0/0))},np.complex128)
 local r=np.tan(a)
 assert(r.dtype=='complex128','complex math dtype 143')
 assert(list_same(r:tolist(),{np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(-0.0,-0.0),np.complex((0/0),0.0),np.complex((0/0),0.0),np.complex(0.0,1.0),np.complex(0.0,-1.0),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),0.0),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},3e-12),'complex math tan 143')
end
do
 local a=np.array({np.complex(-0.0,0.0),np.complex(8.0,0.5),np.complex(3.0,-0.0),np.complex(8.0,5.0),np.complex(0.25,-1.0),np.complex(-8.0,0.0),np.complex(3.0,5.0),np.complex(3.0,-5.0),np.complex(1.0,0.5),np.complex(0.0,5.0),np.complex(3.0,-5.0)},np.complex128)
 local r=np.tan(a)
 assert(r.dtype=='complex128','complex math dtype 144')
 assert(list_same(r:tolist(),{np.complex(-0.0,0.0),np.complex(-0.49178837227869404,2.0074457245465727),np.complex(-0.1425465430742778,-0.0),np.complex(-2.6143854003952472e-05,1.0000869587853312),np.complex(0.10332940767091639,-0.7816883070914596),np.complex(6.799711455220377,0.0),np.complex(-2.5368676207676034e-05,0.999912820151354),np.complex(-2.5368676207676034e-05,-0.999912820151354),np.complex(0.806877412163085,1.0428307283443607),np.complex(0.0,0.9999092042625953),np.complex(-2.5368676207676034e-05,-0.999912820151354)},3e-12),'complex math tan 144')
end
do
 local a=np.array({np.complex(1.0,5.0),np.complex(-8.0,0.5),np.complex(8.0,2.0),np.complex(0.25,-1.0),np.complex(-1.0,-0.0),np.complex(1.0,-5.0),np.complex(8.0,0.5),np.complex(8.0,5.0),np.complex(-1.0,5.0),np.complex(0.0,-5.0),np.complex(-0.0,-5.0)},np.complex128)
 local r=np.tan(a)
 assert(r.dtype=='complex128','complex math dtype 145')
 assert(list_same(r:tolist(),{np.complex(8.2567198342296e-05,1.000037783379601),np.complex(0.49178837227869404,2.0074457245465727),np.complex(-0.010925884335752532,1.0356479469632376),np.complex(0.10332940767091639,-0.7816883070914596),np.complex(-1.557407724654902,-0.0),np.complex(8.2567198342296e-05,-1.000037783379601),np.complex(-0.49178837227869404,2.0074457245465727),np.complex(-2.6143854003952472e-05,1.0000869587853312),np.complex(-8.2567198342296e-05,1.000037783379601),np.complex(0.0,-0.9999092042625953),np.complex(-0.0,-0.9999092042625953)},3e-12),'complex math tan 145')
end
do
 local a=np.array({np.complex(-1.0,0.5),np.complex(1.0,-5.0),np.complex(1.0,-5.0),np.complex(3.0,-1.0),np.complex(3.0,-5.0),np.complex(0.25,0.5),np.complex(1.0,-1.0),np.complex(1.0,0.0),np.complex(3.0,5.0),np.complex(8.0,-5.0),np.complex(-1.0,0.0)},np.complex128)
 local r=np.tan(a)
 assert(r.dtype=='complex128','complex math dtype 146')
 assert(list_same(r:tolist(),{np.complex(-0.806877412163085,1.0428307283443607),np.complex(8.2567198342296e-05,-1.000037783379601),np.complex(8.2567198342296e-05,-1.000037783379601),np.complex(-0.05916853956605073,-0.7680176472869112),np.complex(-2.5368676207676034e-05,-0.999912820151354),np.complex(0.19805544995134955,0.4854872810241353),np.complex(0.2717525853195118,-1.0839233273386946),np.complex(1.557407724654902,0.0),np.complex(-2.5368676207676034e-05,0.999912820151354),np.complex(-2.6143854003952472e-05,-1.0000869587853312),np.complex(-1.557407724654902,0.0)},3e-12),'complex math tan 146')
end
do
 local a=np.array({np.complex(-0.0,0.5),np.complex(-8.0,0.5),np.complex(8.0,-5.0),np.complex(0.25,5.0),np.complex(0.25,-5.0),np.complex(0.0,0.5),np.complex(3.0,-1.0),np.complex(1.0,-0.0),np.complex(-3.0,0.5),np.complex(8.0,-1.0),np.complex(0.0,-1.0)},np.complex128)
 local r=np.tan(a)
 assert(r.dtype=='complex128','complex math dtype 147')
 assert(list_same(r:tolist(),{np.complex(-0.0,0.46211715726000974),np.complex(0.49178837227869404,2.0074457245465727),np.complex(-2.6143854003952472e-05,-1.0000869587853312),np.complex(4.3528302942683465e-05,0.9999203178539379),np.complex(4.3528302942683465e-05,-0.9999203178539379),np.complex(0.0,0.46211715726000974),np.complex(-0.05916853956605073,-0.7680176472869112),np.complex(1.557407724654902,-0.0),np.complex(0.11162105077158345,0.4694699934258854),np.complex(-0.10265630215807456,-1.2932121874311113),np.complex(0.0,-0.7615941559557649)},3e-12),'complex math tan 147')
end
do
 local a=np.array({np.complex(-8.0,0.0),np.complex(1.0,0.0),np.complex(0.25,-0.0),np.complex(-8.0,-1.0),np.complex(-1.0,-0.0),np.complex(-1.0,-5.0),np.complex(0.25,-5.0),np.complex(8.0,-5.0),np.complex(-1.0,-1.0),np.complex(-3.0,0.0),np.complex(0.0,0.5)},np.complex128)
 local r=np.tan(a)
 assert(r.dtype=='complex128','complex math dtype 148')
 assert(list_same(r:tolist(),{np.complex(6.799711455220377,0.0),np.complex(1.557407724654902,0.0),np.complex(0.25534192122103627,-0.0),np.complex(0.10265630215807456,-1.2932121874311113),np.complex(-1.557407724654902,-0.0),np.complex(-8.2567198342296e-05,-1.000037783379601),np.complex(4.3528302942683465e-05,-0.9999203178539379),np.complex(-2.6143854003952472e-05,-1.0000869587853312),np.complex(-0.2717525853195118,-1.0839233273386946),np.complex(0.1425465430742778,0.0),np.complex(0.0,0.46211715726000974)},3e-12),'complex math tan 148')
end
do
 local a=np.array({np.complex(8.0,0.5),np.complex(3.0,-5.0),np.complex(-0.0,0.5),np.complex(-3.0,0.0),np.complex(1.0,-0.0),np.complex(8.0,0.5),np.complex(1.0,5.0),np.complex(1.0,-1.0),np.complex(1.0,5.0),np.complex(0.25,5.0),np.complex(1.0,-1.0)},np.complex128)
 local r=np.tan(a)
 assert(r.dtype=='complex128','complex math dtype 149')
 assert(list_same(r:tolist(),{np.complex(-0.49178837227869404,2.0074457245465727),np.complex(-2.5368676207676034e-05,-0.999912820151354),np.complex(-0.0,0.46211715726000974),np.complex(0.1425465430742778,0.0),np.complex(1.557407724654902,-0.0),np.complex(-0.49178837227869404,2.0074457245465727),np.complex(8.2567198342296e-05,1.000037783379601),np.complex(0.2717525853195118,-1.0839233273386946),np.complex(8.2567198342296e-05,1.000037783379601),np.complex(4.3528302942683465e-05,0.9999203178539379),np.complex(0.2717525853195118,-1.0839233273386946)},3e-12),'complex math tan 149')
end
do
 local a=np.array({np.complex(8.0,-5.0),np.complex(0.25,-5.0),np.complex(-8.0,0.5),np.complex(-1.0,-0.0),np.complex(0.0,5.0),np.complex(0.0,2.0),np.complex(8.0,-1.0),np.complex(-0.0,-5.0),np.complex(-8.0,0.5),np.complex(3.0,-5.0),np.complex(-8.0,-0.0)},np.complex128)
 local r=np.tan(a)
 assert(r.dtype=='complex128','complex math dtype 150')
 assert(list_same(r:tolist(),{np.complex(-2.6143854003952472e-05,-1.0000869587853312),np.complex(4.3528302942683465e-05,-0.9999203178539379),np.complex(0.49178837227869404,2.0074457245465727),np.complex(-1.557407724654902,-0.0),np.complex(0.0,0.9999092042625953),np.complex(0.0,0.9640275800758168),np.complex(-0.10265630215807456,-1.2932121874311113),np.complex(-0.0,-0.9999092042625953),np.complex(0.49178837227869404,2.0074457245465727),np.complex(-2.5368676207676034e-05,-0.999912820151354),np.complex(6.799711455220377,-0.0)},3e-12),'complex math tan 150')
end
do
 local a=np.array({np.complex(-3.0,-0.0),np.complex(3.0,-1.0),np.complex(-0.0,-5.0),np.complex(1.0,-1.0),np.complex(-0.0,-0.0),np.complex(-0.0,-0.0),np.complex(3.0,-0.0),np.complex(-3.0,5.0),np.complex(1.0,5.0),np.complex(-0.0,5.0),np.complex(-8.0,0.0)},np.complex128)
 local r=np.tan(a)
 assert(r.dtype=='complex128','complex math dtype 151')
 assert(list_same(r:tolist(),{np.complex(0.1425465430742778,-0.0),np.complex(-0.05916853956605073,-0.7680176472869112),np.complex(-0.0,-0.9999092042625953),np.complex(0.2717525853195118,-1.0839233273386946),np.complex(-0.0,-0.0),np.complex(-0.0,-0.0),np.complex(-0.1425465430742778,-0.0),np.complex(2.5368676207676034e-05,0.999912820151354),np.complex(8.2567198342296e-05,1.000037783379601),np.complex(-0.0,0.9999092042625953),np.complex(6.799711455220377,0.0)},3e-12),'complex math tan 151')
end
do
 local a=np.array({np.complex(-1.0,0.0),np.complex(0.0,5.0),np.complex(-8.0,-0.0),np.complex(0.25,0.0),np.complex(-0.0,-0.0),np.complex(0.0,0.0),np.complex(-1.0,2.0),np.complex(0.0,-0.0),np.complex(-0.0,5.0),np.complex(1.0,-1.0),np.complex(0.25,2.0)},np.complex128)
 local r=np.tan(a)
 assert(r.dtype=='complex128','complex math dtype 152')
 assert(list_same(r:tolist(),{np.complex(-1.557407724654902,0.0),np.complex(0.0,0.9999092042625953),np.complex(6.799711455220377,-0.0),np.complex(0.25534192122103627,0.0),np.complex(-0.0,-0.0),np.complex(0.0,0.0),np.complex(-0.03381282607989669,1.0147936161466335),np.complex(0.0,-0.0),np.complex(-0.0,0.9999092042625953),np.complex(0.2717525853195118,-1.0839233273386946),np.complex(0.017009461384601497,0.968214572183509)},3e-12),'complex math tan 152')
end
do
 local a=np.array({np.complex(-0.0,0.5),np.complex(-1.0,-5.0),np.complex(1.0,2.0),np.complex(-1.0,-5.0),np.complex(-8.0,-0.0),np.complex(0.25,2.0),np.complex(-1.0,0.5),np.complex(-8.0,0.0),np.complex(0.25,2.0),np.complex(0.0,-0.0),np.complex(-8.0,5.0)},np.complex128)
 local r=np.tan(a)
 assert(r.dtype=='complex128','complex math dtype 153')
 assert(list_same(r:tolist(),{np.complex(-0.0,0.46211715726000974),np.complex(-8.2567198342296e-05,-1.000037783379601),np.complex(0.03381282607989669,1.0147936161466335),np.complex(-8.2567198342296e-05,-1.000037783379601),np.complex(6.799711455220377,-0.0),np.complex(0.017009461384601497,0.968214572183509),np.complex(-0.806877412163085,1.0428307283443607),np.complex(6.799711455220377,0.0),np.complex(0.017009461384601497,0.968214572183509),np.complex(0.0,-0.0),np.complex(2.6143854003952472e-05,1.0000869587853312)},3e-12),'complex math tan 153')
end
do
 local a=np.array({np.complex(8.0,-0.0),np.complex(1.0,5.0),np.complex(0.0,-0.0),np.complex(1.0,-1.0),np.complex(-8.0,5.0),np.complex(-3.0,0.0),np.complex(-1.0,0.0),np.complex(8.0,-1.0),np.complex(-1.0,0.0),np.complex(-0.0,2.0),np.complex(0.0,-0.0)},np.complex128)
 local r=np.tan(a)
 assert(r.dtype=='complex128','complex math dtype 154')
 assert(list_same(r:tolist(),{np.complex(-6.799711455220377,-0.0),np.complex(8.2567198342296e-05,1.000037783379601),np.complex(0.0,-0.0),np.complex(0.2717525853195118,-1.0839233273386946),np.complex(2.6143854003952472e-05,1.0000869587853312),np.complex(0.1425465430742778,0.0),np.complex(-1.557407724654902,0.0),np.complex(-0.10265630215807456,-1.2932121874311113),np.complex(-1.557407724654902,0.0),np.complex(-0.0,0.9640275800758168),np.complex(0.0,-0.0)},3e-12),'complex math tan 154')
end
do
 local a=np.array({np.complex(1.0,-0.0),np.complex(0.0,-0.0),np.complex(-3.0,0.5),np.complex(1.0,0.0),np.complex(8.0,-1.0),np.complex(0.0,5.0),np.complex(-0.0,-1.0),np.complex(0.0,0.5),np.complex(3.0,5.0),np.complex(-0.0,-0.0),np.complex(-3.0,0.5)},np.complex128)
 local r=np.tan(a)
 assert(r.dtype=='complex128','complex math dtype 155')
 assert(list_same(r:tolist(),{np.complex(1.557407724654902,-0.0),np.complex(0.0,-0.0),np.complex(0.11162105077158345,0.4694699934258854),np.complex(1.557407724654902,0.0),np.complex(-0.10265630215807456,-1.2932121874311113),np.complex(0.0,0.9999092042625953),np.complex(-0.0,-0.7615941559557649),np.complex(0.0,0.46211715726000974),np.complex(-2.5368676207676034e-05,0.999912820151354),np.complex(-0.0,-0.0),np.complex(0.11162105077158345,0.4694699934258854)},3e-12),'complex math tan 155')
end
do
 local a=np.array({np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(1.0,1.0),np.complex(1.0,1.0),np.complex(-1.0,0.0),np.complex(-1.0,0.0),np.complex(2.0,3.0),np.complex(math.huge,1.0)},np.complex64)
 local b=np.array({np.complex(0.0,0.0),np.complex(2.0,0.0),np.complex(-1.0,0.0),np.complex(2.0,0.0),np.complex(-3.0,0.0),np.complex(0.5,0.0),np.complex(0.5,0.0),np.complex(0.25,-1.0),np.complex(2.0,0.0)},np.complex64)
 local r=np.power(a,b)
 assert(r.dtype=='complex64','complex power dtype 156')
 assert(list_same(r:tolist(),{np.complex(1.0,0.0),np.complex(0.0,0.0),np.complex((0/0),(0/0)),np.complex(0.0,2.0),np.complex(-0.25,-0.25),np.complex(-4.371138828673793e-08,1.0),np.complex(-4.371138828673793e-08,1.0),np.complex(1.8740482330322266,-3.169208526611328),np.complex(math.huge,math.huge)},0.00032),'complex power 156')
end
do
 local a=np.array({np.complex(8.0,-5.0),np.complex(1.0,0.5),np.complex(-8.0,2.0),np.complex(8.0,5.0),np.complex(0.25,2.0),np.complex(-1.0,-5.0),np.complex(-3.0,0.5),np.complex(1.0,-0.0),np.complex(8.0,2.0)},np.complex64)
 local b=np.array({np.complex(2.0,0.0),np.complex(-2.0,0.0),np.complex(1.0,0.0),np.complex(5.0,0.0),np.complex(3.0,0.5),np.complex(0.25,0.0),np.complex(3.0,0.0),np.complex(1.0,2.0),np.complex(1.0,-1.0)},np.complex64)
 local r=np.power(a,b)
 assert(r.dtype=='complex64','complex power dtype 157')
 assert(list_same(r:tolist(),{np.complex(39.0,-80.0),np.complex(0.47999998927116394,-0.6399999856948853),np.complex(-8.0,2.0),np.complex(-70232.0,25525.0),np.complex(-0.08983943611383438,-3.971808433532715),np.complex(1.3582546710968018,-0.6428413391113281),np.complex(-24.75,13.375),np.complex(1.0,0.0),np.complex(-3.0527398586273193,-10.083330154418945)},0.00032),'complex power 157')
end
do
 local a=np.array({np.complex(-1.0,5.0),np.complex(-8.0,2.0),np.complex(-3.0,-1.0),np.complex(-3.0,5.0),np.complex(0.0,2.0),np.complex(8.0,-1.0),np.complex(-0.0,-0.0),np.complex(-0.0,-5.0),np.complex(0.25,0.0)},np.complex64)
 local b=np.array({np.complex(0.0,0.0),np.complex(2.0,0.0),np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(3.0,0.0),np.complex(-8.0,2.0),np.complex(-3.0,0.5),np.complex(3.0,0.5),np.complex(-1.0,2.0)},np.complex64)
 local r=np.power(a,b)
 assert(r.dtype=='complex64','complex power dtype 158')
 assert(list_same(r:tolist(),{np.complex(1.0,0.0),np.complex(60.0,-32.0),np.complex(0.07999999821186066,-0.05999999865889549),np.complex(1.0,0.0),np.complex(-0.0,-8.0),np.complex(3.168910112094636e-08,-6.447196909675768e-08),np.complex((0/0),(0/0)),np.complex(-197.5695037841797,190.07888793945312),np.complex(-3.730748414993286,-1.4427462816238403)},0.00032),'complex power 158')
end
do
 local a=np.array({np.complex(-8.0,-0.0),np.complex(8.0,0.0),np.complex(0.25,-0.0),np.complex(0.25,-1.0),np.complex(0.0,2.0),np.complex(3.0,-0.0),np.complex(1.0,-1.0),np.complex(-1.0,0.5),np.complex(3.0,0.5)},np.complex64)
 local b=np.array({np.complex(5.0,0.0),np.complex(-1.0,0.0),np.complex(3.0,0.0),np.complex(2.0,0.0),np.complex(1.0,-1.0),np.complex(0.25,-0.0),np.complex(3.0,0.0),np.complex(1.0,-1.0),np.complex(-0.0,-1.0)},np.complex64)
 local r=np.power(a,b)
 assert(r.dtype=='complex64','complex power dtype 159')
 assert(list_same(r:tolist(),{np.complex(-32768.0,-0.0),np.complex(0.125,0.0),np.complex(0.015625,-0.0),np.complex(-0.9375,-0.5),np.complex(6.14741849899292,7.400814533233643),np.complex(1.316074013710022,-0.0),np.complex(-2.0,-2.0),np.complex(-13.654366493225098,8.852903366088867),np.complex(0.5220648050308228,-1.057747721672058)},0.00032),'complex power 159')
end
do
 local a=np.array({np.complex(-3.0,0.5),np.complex(-1.0,0.0),np.complex(0.0,0.5),np.complex(3.0,0.5),np.complex(1.0,-0.0),np.complex(0.25,0.0),np.complex(8.0,5.0),np.complex(-8.0,5.0),np.complex(1.0,-1.0)},np.complex64)
 local b=np.array({np.complex(-2.0,0.0),np.complex(-1.0,0.0),np.complex(-1.0,0.0),np.complex(3.0,0.0),np.complex(3.0,-5.0),np.complex(0.25,2.0),np.complex(1.0,-0.0),np.complex(-1.0,2.0),np.complex(1.0,2.0)},np.complex64)
 local r=np.power(a,b)
 assert(r.dtype=='complex64','complex power dtype 160')
 assert(list_same(r:tolist(),{np.complex(0.10226442664861679,0.03506208956241608),np.complex(-1.0,-0.0),np.complex(0.0,-2.0),np.complex(24.75,13.375),np.complex(1.0,-0.0),np.complex(-0.6595093607902527,-0.2550439238548279),np.complex(8.0,5.0),np.complex(-0.00019881331536453217,0.0005713856080546975),np.complex(6.774115562438965,-0.6266977787017822)},0.00032),'complex power 160')
end
do
 local a=np.array({np.complex(8.0,-0.0),np.complex(8.0,2.0),np.complex(-3.0,-1.0),np.complex(-8.0,-1.0),np.complex(0.25,0.0),np.complex(3.0,0.5),np.complex(-3.0,-1.0),np.complex(1.0,-0.0),np.complex(0.25,0.5)},np.complex64)
 local b=np.array({np.complex(2.0,0.0),np.complex(3.0,0.0),np.complex(0.0,0.0),np.complex(-1.0,0.0),np.complex(-3.0,-5.0),np.complex(-0.0,-1.0),np.complex(-1.0,-1.0),np.complex(-1.0,5.0),np.complex(0.0,-1.0)},np.complex64)
 local r=np.power(a,b)
 assert(r.dtype=='complex64','complex power dtype 161')
 assert(list_same(r:tolist(),{np.complex(64.0,-0.0),np.complex(416.0,376.0),np.complex(1.0,0.0),np.complex(-0.1230769231915474,0.015384615398943424),np.complex(51.015655517578125,38.64457321166992),np.complex(0.5220648050308228,-1.057747721672058),np.complex(-0.0018399129621684551,0.018762029707431793),np.complex(1.0,0.0),np.complex(2.528285503387451,1.6621516942977905)},0.00032),'complex power 161')
end
do
 local a=np.array({np.complex(-8.0,-0.0),np.complex(1.0,2.0),np.complex(3.0,-5.0),np.complex(3.0,0.0),np.complex(-0.0,5.0),np.complex(-0.0,-1.0),np.complex(-0.0,0.0),np.complex(3.0,0.0),np.complex(-1.0,0.0)},np.complex64)
 local b=np.array({np.complex(-1.0,0.0),np.complex(0.0,0.0),np.complex(3.0,0.0),np.complex(3.0,0.0),np.complex(-1.0,5.0),np.complex(0.25,5.0),np.complex(0.25,-0.0),np.complex(8.0,0.0),np.complex(-3.0,-0.0)},np.complex64)
 local r=np.power(a,b)
 assert(r.dtype=='complex64','complex power dtype 162')
 assert(list_same(r:tolist(),{np.complex(-0.125,-0.0),np.complex(1.0,0.0),np.complex(-198.0,-10.0),np.complex(27.0,0.0),np.complex(7.619597454322502e-05,1.490762679168256e-05),np.complex(2379.88720703125,-985.7816772460938),np.complex(0.0,0.0),np.complex(6561.0,0.0),np.complex(-1.0,-0.0)},0.00032),'complex power 162')
end
do
 local a=np.array({np.complex(1.0,2.0),np.complex(0.0,-0.0),np.complex(8.0,-1.0),np.complex(-3.0,0.5),np.complex(0.0,0.5),np.complex(0.25,-5.0),np.complex(-3.0,-0.0),np.complex(-0.0,-1.0),np.complex(-1.0,5.0)},np.complex64)
 local b=np.array({np.complex(1.0,0.0),np.complex(0.0,0.0),np.complex(2.0,0.0),np.complex(5.0,0.0),np.complex(-0.0,5.0),np.complex(1.0,-5.0),np.complex(0.0,0.0),np.complex(-8.0,-0.0),np.complex(0.25,-0.0)},np.complex64)
 local r=np.power(a,b)
 assert(r.dtype=='complex64','complex power dtype 163')
 assert(list_same(r:tolist(),{np.complex(1.0,2.0),np.complex(1.0,0.0),np.complex(63.0,-16.0),np.complex(-176.4375,191.28125),np.complex(-0.0003679869987536222,0.00012364142457954586),np.complex(-0.0024670830462127924,0.0003715796337928623),np.complex(1.0,0.0),np.complex(1.0,0.0),np.complex(1.3582546710968018,0.6428413391113281)},0.00032),'complex power 163')
end
do
 local a=np.array({np.complex(-3.0,0.5),np.complex(1.0,2.0),np.complex(-0.0,0.5),np.complex(-3.0,-1.0),np.complex(-8.0,-5.0),np.complex(3.0,5.0),np.complex(1.0,0.5),np.complex(-3.0,-1.0),np.complex(0.25,0.5)},np.complex64)
 local b=np.array({np.complex(-5.0,0.0),np.complex(5.0,0.0),np.complex(0.0,0.0),np.complex(-3.0,0.0),np.complex(-3.0,0.5),np.complex(1.0,-0.0),np.complex(-1.0,5.0),np.complex(0.0,2.0),np.complex(0.0,2.0)},np.complex64)
 local r=np.power(a,b)
 assert(r.dtype=='complex64','complex power dtype 164')
 assert(list_same(r:tolist(),{np.complex(-0.002605447079986334,-0.0028246440924704075),np.complex(41.0,-38.0),np.complex(1.0,0.0),np.complex(-0.017999999225139618,0.025999998673796654),np.complex(-0.003685857867822051,0.002278316533192992),np.complex(3.0,5.0),np.complex(0.08766309916973114,0.008283373899757862),np.complex(-188.01443481445312,209.3365936279297),np.complex(0.0433042012155056,-0.1002795472741127)},0.00032),'complex power 164')
end
do
 local a=np.array({np.complex(0.25,2.0),np.complex(3.0,-5.0),np.complex(0.0,-0.0),np.complex(1.0,-1.0),np.complex(0.0,2.0),np.complex(1.0,-1.0),np.complex(-1.0,2.0),np.complex(8.0,5.0),np.complex(8.0,-0.0)},np.complex64)
 local b=np.array({np.complex(5.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0),np.complex(-3.0,-1.0),np.complex(8.0,2.0),np.complex(0.25,2.0),np.complex(1.0,-1.0),np.complex(0.0,-5.0)},np.complex64)
 local r=np.power(a,b)
 assert(r.dtype=='complex64','complex power dtype 165')
 assert(list_same(r:tolist(),{np.complex(19.3759765625,27.0390625),np.complex(3.0,-5.0),np.complex(0.0,0.0),np.complex(-2.0,-2.0),np.complex(0.3842136561870575,0.4625508189201355),np.complex(59.206520080566406,49.17933654785156),np.complex(-0.010878412052989006,0.017853030934929848),np.complex(-1.891215205192566,-16.383901596069336),np.complex(-0.563293993473053,0.8262565732002258)},0.00032),'complex power 165')
end
do
 local a=np.array({np.complex(-3.0,-5.0),np.complex(8.0,-0.0),np.complex(1.0,2.0),np.complex(-8.0,0.5),np.complex(-8.0,-0.0),np.complex(-1.0,-5.0),np.complex(0.25,0.0),np.complex(-1.0,-5.0),np.complex(-8.0,0.0)},np.complex64)
 local b=np.array({np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(-1.0,0.0),np.complex(2.0,0.0),np.complex(8.0,0.0),np.complex(-1.0,-5.0),np.complex(0.25,0.0),np.complex(-1.0,-1.0),np.complex(-3.0,0.0)},np.complex64)
 local r=np.power(a,b)
 assert(r.dtype=='complex64','complex power dtype 166')
 assert(list_same(r:tolist(),{np.complex(1.0,0.0),np.complex(8.0,-0.0),np.complex(0.20000000298023224,-0.4000000059604645),np.complex(63.75,-8.0),np.complex(16777216.0,0.0),np.complex(2.8249929528101347e-05,-2.659456868059351e-06),np.complex(0.7071067690849304,0.0),np.complex(0.03314206004142761,0.004641502629965544),np.complex(-0.001953125,-0.0)},0.00032),'complex power 166')
end
do
 local a=np.array({np.complex(0.25,0.0),np.complex(-0.0,0.5),np.complex(-0.0,-1.0),np.complex(-3.0,-1.0),np.complex(-0.0,0.0),np.complex(-1.0,5.0),np.complex(3.0,0.5),np.complex(-3.0,0.5),np.complex(-3.0,-0.0)},np.complex64)
 local b=np.array({np.complex(-1.0,0.0),np.complex(0.0,0.0),np.complex(5.0,0.0),np.complex(3.0,0.0),np.complex(0.25,5.0),np.complex(8.0,-0.0),np.complex(-1.0,5.0),np.complex(-8.0,2.0),np.complex(0.25,-1.0)},np.complex64)
 local r=np.power(a,b)
 assert(r.dtype=='complex64','complex power dtype 167')
 assert(list_same(r:tolist(),{np.complex(4.0,0.0),np.complex(1.0,0.0),np.complex(0.0,-1.0),np.complex(-18.0,-26.0),np.complex(0.0,0.0),np.complex(-3824.0,456960.0),np.complex(0.09098543971776962,-0.11159279942512512),np.complex(-3.2631371027491696e-07,-1.39589047876143e-07),np.complex(-0.01752351224422455,-0.05410575494170189)},0.00032),'complex power 167')
end
do
 local a=np.array({np.complex(1.0,0.0),np.complex(0.0,-5.0),np.complex(0.25,5.0),np.complex(0.25,-1.0),np.complex(-8.0,-5.0),np.complex(3.0,-0.0),np.complex(-8.0,5.0),np.complex(0.0,2.0),np.complex(0.25,0.0)},np.complex64)
 local b=np.array({np.complex(-1.0,0.0),np.complex(3.0,0.0),np.complex(-2.0,0.0),np.complex(2.0,0.0),np.complex(0.0,0.5),np.complex(-3.0,2.0),np.complex(-8.0,0.5),np.complex(-0.0,0.5),np.complex(-1.0,-0.0)},np.complex64)
 local r=np.power(a,b)
 assert(r.dtype=='complex64','complex power dtype 168')
 assert(list_same(r:tolist(),{np.complex(1.0,0.0),np.complex(-0.0,125.0),np.complex(-0.03970124572515488,-0.003980074543505907),np.complex(-0.9375,-0.5),np.complex(1.5780375003814697,3.2781851291656494),np.complex(-0.021713145077228546,0.03000468574464321),np.complex(3.372420787073338e-09,-2.796048947928398e-09),np.complex(0.42882901430130005,0.15487174689769745),np.complex(4.0,0.0)},0.00032),'complex power 168')
end
do
 local a=np.array({np.complex(1.0,2.0),np.complex(-1.0,-1.0),np.complex(0.0,0.0),np.complex(8.0,-5.0),np.complex(-8.0,0.0),np.complex(8.0,2.0),np.complex(8.0,-0.0),np.complex(-3.0,-0.0),np.complex(3.0,0.5)},np.complex64)
 local b=np.array({np.complex(3.0,0.0),np.complex(-2.0,0.0),np.complex(-2.0,0.0),np.complex(1.0,0.0),np.complex(8.0,5.0),np.complex(1.0,0.0),np.complex(8.0,-0.0),np.complex(-3.0,-1.0),np.complex(-0.0,-5.0)},np.complex64)
 local r=np.power(a,b)
 assert(r.dtype=='complex64','complex power dtype 169')
 assert(list_same(r:tolist(),{np.complex(-11.0,-2.0),np.complex(0.0,-0.5),np.complex((0/0),(0/0)),np.complex(8.0,-5.0),np.complex(-1.4242050647735596,-2.0890698432922363),np.complex(8.0,2.0),np.complex(16777216.0,0.0),np.complex(-0.0007279671262949705,0.0014253822155296803),np.complex(1.7143559455871582,1.5085458755493164)},0.00032),'complex power 169')
end
do
 local a=np.array({np.complex(-3.0,0.5),np.complex(-0.0,-5.0),np.complex(1.0,0.0),np.complex(-1.0,0.0),np.complex(-3.0,5.0),np.complex(0.25,-0.0),np.complex(1.0,2.0),np.complex(1.0,0.5),np.complex(0.25,-0.0)},np.complex64)
 local b=np.array({np.complex(-2.0,0.0),np.complex(-5.0,0.0),np.complex(-2.0,0.0),np.complex(-5.0,0.0),np.complex(-1.0,0.5),np.complex(-8.0,-5.0),np.complex(3.0,-0.0),np.complex(1.0,-1.0),np.complex(1.0,5.0)},np.complex64)
 local r=np.power(a,b)
 assert(r.dtype=='complex64','complex power dtype 170')
 assert(list_same(r:tolist(),{np.complex(0.10226442664861679,0.03506208956241608),np.complex(-0.0,0.00031999999191612005),np.complex(1.0,0.0),np.complex(-1.0,-0.0),np.complex(0.019967766478657722,-0.05623858794569969),np.complex(52240.03125,39572.04296875),np.complex(-11.0,-2.0),np.complex(1.668485403060913,0.612972617149353),np.complex(0.19927990436553955,-0.15095536410808563)},0.00032),'complex power 170')
end
do
 local a=np.array({np.complex(-3.0,5.0),np.complex(-1.0,0.5),np.complex(-0.0,-0.0),np.complex(0.25,-0.0),np.complex(8.0,-1.0),np.complex(1.0,2.0),np.complex(0.0,2.0),np.complex(3.0,0.5),np.complex(-0.0,-1.0)},np.complex64)
 local b=np.array({np.complex(-1.0,0.0),np.complex(2.0,0.0),np.complex(1.0,0.0),np.complex(-5.0,0.0),np.complex(1.0,-1.0),np.complex(0.25,0.0),np.complex(0.25,-5.0),np.complex(0.0,-5.0),np.complex(0.25,-1.0)},np.complex64)
 local r=np.power(a,b)
 assert(r.dtype=='complex64','complex power dtype 171')
 assert(list_same(r:tolist(),{np.complex(-0.0882352888584137,-0.14705881476402283),np.complex(0.75,-1.0),np.complex(0.0,0.0),np.complex(1024.0,0.0),np.complex(-4.2560343742370605,-5.707327365875244),np.complex(1.176301121711731,0.33416253328323364),np.complex(-3056.16650390625,-209.8466033935547),np.complex(1.7143559455871582,1.5085458755493164),np.complex(0.19205567240715027,-0.0795520767569542)},0.00032),'complex power 171')
end
do
 local a=np.array({np.complex(-1.0,-5.0),np.complex(-1.0,5.0),np.complex(-8.0,0.0),np.complex(0.0,-1.0),np.complex(0.25,-1.0),np.complex(0.25,2.0),np.complex(8.0,0.0),np.complex(-0.0,0.5),np.complex(-8.0,2.0)},np.complex64)
 local b=np.array({np.complex(5.0,0.0),np.complex(1.0,0.0),np.complex(0.0,0.0),np.complex(-3.0,0.0),np.complex(0.25,0.0),np.complex(1.0,-0.0),np.complex(8.0,5.0),np.complex(8.0,-5.0),np.complex(-0.0,-1.0)},np.complex64)
 local r=np.power(a,b)
 assert(r.dtype=='complex64','complex power dtype 172')
 assert(list_same(r:tolist(),{np.complex(-2876.0,-1900.0),np.complex(-1.0,5.0),np.complex(1.0,0.0),np.complex(0.0,-1.0),np.complex(0.9527629017829895,-0.32789403200149536),np.complex(0.25,2.0),np.complex(-9450505.0,-13862285.0),np.complex(-9.538378715515137,-3.204836845397949),np.complex(-9.296197891235352,-15.545130729675293)},0.00032),'complex power 172')
end
do
 local a=np.array({np.complex(-8.0,5.0),np.complex(-0.0,-0.0),np.complex(0.0,0.5),np.complex(8.0,-1.0),np.complex(0.0,-5.0),np.complex(0.0,0.0),np.complex(0.25,2.0),np.complex(-3.0,-0.0),np.complex(-8.0,-0.0)},np.complex64)
 local b=np.array({np.complex(3.0,0.0),np.complex(-2.0,0.0),np.complex(-3.0,0.0),np.complex(1.0,0.0),np.complex(1.0,-0.0),np.complex(-1.0,-0.0),np.complex(8.0,-0.0),np.complex(0.25,5.0),np.complex(8.0,0.5)},np.complex64)
 local r=np.power(a,b)
 assert(r.dtype=='complex64','complex power dtype 173')
 assert(list_same(r:tolist(),{np.complex(88.0,835.0),np.complex((0/0),(0/0)),np.complex(-0.0,8.0),np.complex(8.0,-1.0),np.complex(0.0,-5.0),np.complex((0/0),(0/0)),np.complex(148.34767150878906,-228.4365234375),np.complex(-41267.0625,-8732884.0),np.complex(40874748.0,69590152.0)},0.00032),'complex power 173')
end
do
 local a=np.array({np.complex(-3.0,5.0),np.complex(-1.0,5.0),np.complex(0.0,0.0),np.complex(-1.0,-0.0),np.complex(-0.0,2.0),np.complex(0.0,-1.0),np.complex(3.0,-5.0),np.complex(-3.0,0.0),np.complex(-1.0,-1.0)},np.complex64)
 local b=np.array({np.complex(2.0,0.0),np.complex(3.0,0.0),np.complex(5.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.5),np.complex(1.0,2.0),np.complex(0.25,-1.0),np.complex(-8.0,0.0),np.complex(0.0,0.0)},np.complex64)
 local r=np.power(a,b)
 assert(r.dtype=='complex64','complex power dtype 174')
 assert(list_same(r:tolist(),{np.complex(-16.0,-30.0),np.complex(74.0,-110.0),np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(0.42882901430130005,0.15487174689769745),np.complex(-1.0115119266629335e-06,-23.140695571899414),np.complex(-0.2412031590938568,-0.4993565082550049),np.complex(0.0001524157851235941,0.0),np.complex(1.0,0.0)},0.00032),'complex power 174')
end
do
 local a=np.array({np.complex(0.0,0.0),np.complex(1.0,2.0),np.complex(-1.0,5.0),np.complex(0.25,5.0),np.complex(0.0,2.0),np.complex(0.0,-5.0),np.complex(1.0,2.0),np.complex(-0.0,-0.0),np.complex(0.25,0.0)},np.complex64)
 local b=np.array({np.complex(3.0,0.0),np.complex(-3.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0),np.complex(0.0,-5.0),np.complex(-8.0,2.0),np.complex(-3.0,0.0),np.complex(0.0,-5.0),np.complex(-0.0,-5.0)},np.complex64)
 local r=np.power(a,b)
 assert(r.dtype=='complex64','complex power dtype 175')
 assert(list_same(r:tolist(),{np.complex(0.0,0.0),np.complex(-0.08799999952316284,0.01600000075995922),np.complex(-24.0,-10.0),np.complex(-18.734375,-124.0625),np.complex(-2441.824951171875,820.4385375976562),np.complex(-5.9063353546662256e-05,-4.573736987367738e-06),np.complex(-0.08799999952316284,0.01600000075995922),np.complex((0/0),(0/0)),np.complex(0.7971196174621582,0.6038214564323425)},0.00032),'complex power 175')
end
do
 local a=np.array({np.complex(0.25,2.0),np.complex(0.0,0.0),np.complex(-8.0,-1.0),np.complex(0.0,0.0),np.complex(-1.0,0.5),np.complex(-8.0,0.0),np.complex(3.0,-1.0),np.complex(0.0,0.5),np.complex(-8.0,0.0)},np.complex64)
 local b=np.array({np.complex(-1.0,0.0),np.complex(-5.0,0.0),np.complex(-5.0,0.0),np.complex(2.0,0.0),np.complex(-3.0,-0.0),np.complex(0.0,-0.0),np.complex(3.0,0.0),np.complex(3.0,-1.0),np.complex(0.25,-5.0)},np.complex64)
 local r=np.power(a,b)
 assert(r.dtype=='complex64','complex power dtype 176')
 assert(list_same(r:tolist(),{np.complex(0.0615384615957737,-0.4923076927661896),np.complex((0/0),(0/0)),np.complex(-2.386298729106784e-05,1.7100026525440626e-05),np.complex(0.0,0.0),np.complex(-0.12800000607967377,-0.7039999961853027),np.complex(1.0,0.0),np.complex(18.0,-26.0),np.complex(0.3842136561870575,-0.4625508189201355),np.complex(-10965143.0,2075072.0)},0.00032),'complex power 176')
end
do
 local a=np.array({np.complex(1.0,0.0),np.complex(0.25,-5.0),np.complex(8.0,2.0),np.complex(0.25,2.0),np.complex(8.0,-1.0),np.complex(-3.0,2.0),np.complex(-0.0,0.5),np.complex(-8.0,-0.0),np.complex(8.0,-5.0)},np.complex64)
 local b=np.array({np.complex(0.0,0.0),np.complex(3.0,0.0),np.complex(-5.0,0.0),np.complex(1.0,0.0),np.complex(-3.0,-0.0),np.complex(0.25,0.0),np.complex(-1.0,2.0),np.complex(1.0,2.0),np.complex(3.0,-1.0)},np.complex64)
 local r=np.power(a,b)
 assert(r.dtype=='complex64','complex power dtype 177')
 assert(list_same(r:tolist(),{np.complex(1.0,0.0),np.complex(-18.734375,124.0625),np.complex(8.89174043550156e-06,-2.4672377548995428e-05),np.complex(0.25,2.0),np.complex(0.0017769685946404934,0.0006954938871785998),np.complex(1.1065891981124878,0.8211511969566345),np.complex(-0.0849609524011612,-0.01585577428340912),np.complex(2251.947998046875,3644.2861328125),np.complex(-341.9311828613281,337.26190185546875)},0.00032),'complex power 177')
end
do
 local a=np.array({np.complex(0.0,-5.0),np.complex(0.25,5.0),np.complex(0.0,2.0),np.complex(8.0,-0.0),np.complex(-3.0,-1.0),np.complex(-3.0,2.0),np.complex(-3.0,0.0),np.complex(3.0,0.5),np.complex(3.0,5.0)},np.complex64)
 local b=np.array({np.complex(1.0,0.0),np.complex(-3.0,0.0),np.complex(-2.0,0.0),np.complex(-3.0,0.0),np.complex(0.25,-0.0),np.complex(0.0,-5.0),np.complex(8.0,2.0),np.complex(8.0,-0.0),np.complex(-1.0,-5.0)},np.complex64)
 local r=np.power(a,b)
 assert(r.dtype=='complex64','complex power dtype 178')
 assert(list_same(r:tolist(),{np.complex(0.0,-5.0),np.complex(-0.0011900522513315082,0.007880746386945248),np.complex(-0.25,-0.0),np.complex(0.001953125,0.0),np.complex(1.0156594514846802,-0.8641269207000732),np.complex(347869.25,-45192.14453125),np.complex(-7.1829833984375,9.925895690917969),np.complex(1808.44140625,7094.0625),np.complex(-27.034421920776367,12.121479034423828)},0.00032),'complex power 178')
end
do
 local a=np.array({np.complex(0.25,0.0),np.complex(-3.0,5.0),np.complex(0.0,-0.0),np.complex(-1.0,-0.0),np.complex(1.0,0.5),np.complex(-0.0,-5.0),np.complex(8.0,5.0),np.complex(0.0,0.5),np.complex(1.0,0.5)},np.complex64)
 local b=np.array({np.complex(-1.0,0.0),np.complex(-3.0,0.0),np.complex(-5.0,0.0),np.complex(0.0,0.0),np.complex(0.25,-1.0),np.complex(3.0,2.0),np.complex(-3.0,0.5),np.complex(3.0,-0.0),np.complex(0.0,0.0)},np.complex64)
 local r=np.power(a,b)
 assert(r.dtype=='complex64','complex power dtype 179')
 assert(list_same(r:tolist(),{np.complex(4.0,0.0),np.complex(0.005037655122578144,-0.00025442702462896705),np.complex((0/0),(0/0)),np.complex(1.0,0.0),np.complex(1.6348174810409546,0.007095360197126865),np.complex(223.3260498046875,-2883.953857421875),np.complex(0.0007662147399969399,-0.00047361498582176864),np.complex(-0.0,-0.125),np.complex(1.0,0.0)},0.00032),'complex power 179')
end
do
 local a=np.array({np.complex(-8.0,-5.0),np.complex(-0.0,-5.0),np.complex(-3.0,-0.0),np.complex(-0.0,0.5),np.complex(3.0,0.5),np.complex(8.0,0.0),np.complex(3.0,-1.0),np.complex(1.0,-1.0),np.complex(3.0,0.0)},np.complex64)
 local b=np.array({np.complex(-5.0,0.0),np.complex(-5.0,0.0),np.complex(-5.0,0.0),np.complex(-5.0,0.0),np.complex(8.0,0.5),np.complex(0.25,-5.0),np.complex(-0.0,2.0),np.complex(0.25,0.5),np.complex(0.25,0.0)},np.complex64)
 local r=np.power(a,b)
 assert(r.dtype=='complex64','complex power dtype 180')
 assert(list_same(r:tolist(),{np.complex(1.2577229426824488e-05,4.571047156787245e-06),np.complex(-0.0,0.00031999999191612005),np.complex(-0.004115226212888956,-0.0),np.complex(0.0,-32.0),np.complex(-2034.1468505859375,6426.46435546875),np.complex(-0.9473438262939453,1.3895924091339111),np.complex(-1.271675944328308,1.4158929586410522),np.complex(1.6145826578140259,-0.0372433215379715),np.complex(1.316074013710022,0.0)},0.00032),'complex power 180')
end
do
 local a=np.array({np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(1.0,1.0),np.complex(1.0,1.0),np.complex(-1.0,0.0),np.complex(-1.0,0.0),np.complex(2.0,3.0),np.complex(math.huge,1.0)},np.complex128)
 local b=np.array({np.complex(0.0,0.0),np.complex(2.0,0.0),np.complex(-1.0,0.0),np.complex(2.0,0.0),np.complex(-3.0,0.0),np.complex(0.5,0.0),np.complex(0.5,0.0),np.complex(0.25,-1.0),np.complex(2.0,0.0)},np.complex128)
 local r=np.power(a,b)
 assert(r.dtype=='complex128','complex power dtype 181')
 assert(list_same(r:tolist(),{np.complex(1.0,0.0),np.complex(0.0,0.0),np.complex((0/0),(0/0)),np.complex(0.0,2.0),np.complex(-0.25,-0.25),np.complex(6.123233995736766e-17,1.0),np.complex(6.123233995736766e-17,1.0),np.complex(1.8740480185761799,-3.1692086484736466),np.complex(math.huge,math.huge)},1.2e-11),'complex power 181')
end
do
 local a=np.array({np.complex(0.0,-5.0),np.complex(1.0,-5.0),np.complex(0.25,2.0),np.complex(-1.0,5.0),np.complex(0.25,0.5),np.complex(0.0,2.0),np.complex(8.0,0.0),np.complex(-0.0,2.0),np.complex(-3.0,0.0)},np.complex128)
 local b=np.array({np.complex(-1.0,0.0),np.complex(0.0,0.0),np.complex(-3.0,0.0),np.complex(-3.0,0.0),np.complex(1.0,5.0),np.complex(1.0,0.0),np.complex(-3.0,-5.0),np.complex(-0.0,0.0),np.complex(-1.0,2.0)},np.complex128)
 local r=np.power(a,b)
 assert(r.dtype=='complex128','complex power dtype 182')
 assert(list_same(r:tolist(),{np.complex(-0.0,0.2),np.complex(1.0,0.0),np.complex(-0.044511606736458806,0.113725989986345),np.complex(0.004210286754665453,0.006258534365043241),np.complex(-0.0005023980720165957,-0.002146343431766779),np.complex(0.0,2.0),np.complex(-0.001100182813192342,0.0016137828364377878),np.complex(1.0,0.0),np.complex(0.00036493250532344357,-0.0005042883605454092)},1.2e-11),'complex power 182')
end
do
 local a=np.array({np.complex(-3.0,0.5),np.complex(-1.0,0.0),np.complex(1.0,0.5),np.complex(-0.0,-5.0),np.complex(8.0,0.5),np.complex(-8.0,0.0),np.complex(-8.0,0.5),np.complex(-1.0,2.0),np.complex(-0.0,2.0)},np.complex128)
 local b=np.array({np.complex(1.0,0.0),np.complex(5.0,0.0),np.complex(-1.0,0.0),np.complex(-2.0,0.0),np.complex(-1.0,-1.0),np.complex(0.0,-1.0),np.complex(-3.0,-0.0),np.complex(-0.0,-0.0),np.complex(-8.0,-1.0)},np.complex128)
 local r=np.power(a,b)
 assert(r.dtype=='complex128','complex power dtype 183')
 assert(list_same(r:tolist(),{np.complex(-3.0,0.5),np.complex(-1.0,0.0),np.complex(0.8,-0.4),np.complex(-0.04,-0.0),np.complex(-0.07199532302632139,-0.11158118869289166),np.complex(-11.26938814002538,-20.211198541259744),np.complex(-0.0019077924283663237,-0.00036148142108620803),np.complex(1.0,0.0),np.complex(0.014454712248320418,-0.012006674871169888)},1.2e-11),'complex power 183')
end
do
 local a=np.array({np.complex(-3.0,-5.0),np.complex(3.0,-5.0),np.complex(-0.0,0.5),np.complex(3.0,2.0),np.complex(-1.0,2.0),np.complex(-3.0,0.0),np.complex(0.25,0.0),np.complex(-3.0,0.0),np.complex(-3.0,0.5)},np.complex128)
 local b=np.array({np.complex(-2.0,0.0),np.complex(5.0,0.0),np.complex(0.0,0.0),np.complex(2.0,0.0),np.complex(0.0,0.5),np.complex(3.0,-1.0),np.complex(-3.0,-5.0),np.complex(-3.0,0.0),np.complex(3.0,0.0)},np.complex128)
 local r=np.power(a,b)
 assert(r.dtype=='complex128','complex power dtype 184')
 assert(list_same(r:tolist(),{np.complex(-0.01384083044982699,-0.025951557093425608),np.complex(2868.0,6100.0),np.complex(1.0,0.0),np.complex(5.0,12.0),np.complex(0.33272071265405184,0.14159836447133536),np.complex(-284.1787069934277,556.4313788501661),np.complex(51.01565550198317,38.644571335479604),np.complex(-0.037037037037037035,-0.0),np.complex(-24.75,13.375)},1.2e-11),'complex power 184')
end
do
 local a=np.array({np.complex(-3.0,-5.0),np.complex(0.0,-1.0),np.complex(-8.0,5.0),np.complex(8.0,-0.0),np.complex(3.0,-5.0),np.complex(0.25,5.0),np.complex(-3.0,2.0),np.complex(0.25,2.0),np.complex(-1.0,-0.0)},np.complex128)
 local b=np.array({np.complex(3.0,0.0),np.complex(-3.0,0.0),np.complex(5.0,0.0),np.complex(1.0,0.0),np.complex(0.25,2.0),np.complex(8.0,0.0),np.complex(-1.0,-0.0),np.complex(-8.0,0.5),np.complex(-0.0,2.0)},np.complex128)
 local r=np.power(a,b)
 assert(r.dtype=='complex128','complex power dtype 185')
 assert(list_same(r:tolist(),{np.complex(198.0,-10.0),np.complex(0.0,-1.0),np.complex(70232.0,25525.0),np.complex(8.0,-0.0),np.complex(-12.102841456549163,-1.5475144296847647),np.complex(363451.9775543213,-153522.45849609375),np.complex(-0.23076923076923078,-0.15384615384615385),np.complex(0.00039829800433385185,0.0017361939038538277),np.complex(535.4916555247646,0.0)},1.2e-11),'complex power 185')
end
do
 local a=np.array({np.complex(0.25,-5.0),np.complex(8.0,-0.0),np.complex(8.0,5.0),np.complex(3.0,0.5),np.complex(-0.0,-5.0),np.complex(-3.0,-5.0),np.complex(8.0,0.5),np.complex(0.25,0.5),np.complex(-0.0,2.0)},np.complex128)
 local b=np.array({np.complex(-3.0,0.0),np.complex(-3.0,0.0),np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(0.0,-0.0),np.complex(-3.0,5.0),np.complex(-8.0,-1.0),np.complex(1.0,-1.0),np.complex(-3.0,-1.0)},np.complex128)
 local r=np.power(a,b)
 assert(r.dtype=='complex128','complex power dtype 186')
 assert(list_same(r:tolist(),{np.complex(-0.0011900522758563382,-0.007880746514011114),np.complex(0.001953125,0.0),np.complex(1.0,0.0),np.complex(3.0,0.5),np.complex(1.0,0.0),np.complex(-164.31366728915856,102.65381120541097),np.complex(-5.2892951145913565e-08,-3.3223972147551595e-08),np.complex(-0.19900440258303678,1.6796805950932099),np.complex(0.3842135958774366,0.46255079194625326)},1.2e-11),'complex power 186')
end
do
 local a=np.array({np.complex(-0.0,5.0),np.complex(-3.0,0.5),np.complex(-1.0,0.0),np.complex(-3.0,2.0),np.complex(1.0,5.0),np.complex(-3.0,2.0),np.complex(3.0,2.0),np.complex(-0.0,0.0),np.complex(0.0,2.0)},np.complex128)
 local b=np.array({np.complex(2.0,0.0),np.complex(1.0,0.0),np.complex(1.0,0.0),np.complex(0.0,0.0),np.complex(3.0,5.0),np.complex(-3.0,2.0),np.complex(8.0,-1.0),np.complex(-1.0,2.0),np.complex(-0.0,2.0)},np.complex128)
 local r=np.power(a,b)
 assert(r.dtype=='complex128','complex power dtype 187')
 assert(list_same(r:tolist(),{np.complex(-25.0,-0.0),np.complex(-3.0,0.5),np.complex(-1.0,0.0),np.complex(1.0,0.0),np.complex(0.13188329194693876,-0.04093027115738713),np.complex(4.83124070395936e-05,0.00011976377696994087),np.complex(-49418.9988381521,-14208.158714277555),np.complex((0/0),(0/0)),np.complex(0.007927894711475971,0.04248048042515222)},1.2e-11),'complex power 187')
end
do
 local a=np.array({np.complex(8.0,5.0),np.complex(8.0,-1.0),np.complex(3.0,5.0),np.complex(-1.0,2.0),np.complex(1.0,0.5),np.complex(0.25,5.0),np.complex(-1.0,5.0),np.complex(3.0,5.0),np.complex(1.0,0.0)},np.complex128)
 local b=np.array({np.complex(-3.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0),np.complex(3.0,0.0),np.complex(1.0,0.0),np.complex(-3.0,5.0),np.complex(1.0,-5.0),np.complex(0.0,5.0),np.complex(0.0,-5.0)},np.complex128)
 local r=np.power(a,b)
 assert(r.dtype=='complex128','complex power dtype 188')
 assert(list_same(r:tolist(),{np.complex(-0.00012482818393432904,-0.001184449245285963),np.complex(63.0,-16.0),np.complex(-198.0,10.0),np.complex(11.0,-2.0),np.complex(1.0,0.5),np.complex(-3.7320769913177092e-06,-1.3594616663638088e-06),np.complex(35087.35116514837,-3303.1509191660944),np.complex(-0.004748244929840474,0.0033107046592369097),np.complex(1.0,0.0)},1.2e-11),'complex power 188')
end
do
 local a=np.array({np.complex(0.0,5.0),np.complex(1.0,-5.0),np.complex(-0.0,-0.0),np.complex(8.0,2.0),np.complex(3.0,2.0),np.complex(-0.0,0.5),np.complex(-8.0,0.5),np.complex(1.0,5.0),np.complex(-3.0,2.0)},np.complex128)
 local b=np.array({np.complex(5.0,0.0),np.complex(-1.0,0.0),np.complex(1.0,0.0),np.complex(5.0,0.0),np.complex(0.0,-1.0),np.complex(3.0,-1.0),np.complex(-1.0,5.0),np.complex(0.25,0.0),np.complex(8.0,0.5)},np.complex128)
 local r=np.power(a,b)
 assert(r.dtype=='complex128','complex power dtype 189')
 assert(list_same(r:tolist(),{np.complex(0.0,3125.0),np.complex(0.038461538461538464,0.1923076923076923),np.complex(0.0,0.0),np.complex(12928.0,35872.0),np.complex(0.5119289280783207,-1.7260731030931866),np.complex(0.3842135958774366,-0.46255079194625326),np.complex(1.2901615657232814e-08,2.2212555883542253e-08),np.complex(1.4149885904397104,0.5058736534735399),np.complex(-4818.724193159907,6343.9150025215695)},1.2e-11),'complex power 189')
end
do
 local a=np.array({np.complex(0.0,2.0),np.complex(0.0,-1.0),np.complex(3.0,0.5),np.complex(8.0,-1.0),np.complex(-0.0,0.0),np.complex(-0.0,-1.0),np.complex(-1.0,5.0),np.complex(-3.0,-0.0),np.complex(-3.0,0.0)},np.complex128)
 local b=np.array({np.complex(3.0,0.0),np.complex(-2.0,0.0),np.complex(2.0,0.0),np.complex(-3.0,0.0),np.complex(3.0,-5.0),np.complex(-1.0,-1.0),np.complex(0.0,-5.0),np.complex(0.0,5.0),np.complex(-3.0,-5.0)},np.complex128)
 local r=np.power(a,b)
 assert(r.dtype=='complex128','complex power dtype 190')
 assert(list_same(r:tolist(),{np.complex(-0.0,-8.0),np.complex(-1.0,-0.0),np.complex(8.75,3.0),np.complex(0.0017769685935366407,0.0006954938552571688),np.complex(0.0,0.0),np.complex(1.272895288930342e-17,0.20787957635076193),np.complex(-1984.7348369607212,-6620.523265637526),np.complex(4669868.983337471,-4714215.686526724),np.complex(-172958.11049398032,-174600.5809824713)},1.2e-11),'complex power 190')
end
do
 local a=np.array({np.complex(-8.0,-5.0),np.complex(0.25,-0.0),np.complex(8.0,0.5),np.complex(-1.0,-0.0),np.complex(-8.0,-1.0),np.complex(0.25,-1.0),np.complex(1.0,0.0),np.complex(8.0,0.5),np.complex(0.25,0.0)},np.complex128)
 local b=np.array({np.complex(-2.0,0.0),np.complex(5.0,0.0),np.complex(3.0,0.0),np.complex(-2.0,0.0),np.complex(0.0,-5.0),np.complex(8.0,5.0),np.complex(3.0,-1.0),np.complex(0.25,-5.0),np.complex(-8.0,-5.0)},np.complex128)
 local r=np.power(a,b)
 assert(r.dtype=='complex128','complex power dtype 191')
 assert(list_same(r:tolist(),{np.complex(0.004923620754955183,-0.010099734881959348),np.complex(0.0009765625,0.0),np.complex(506.0,95.875),np.complex(1.0,0.0),np.complex(-1.4897914696910432e-07,2.378335228335213e-07),np.complex(-496.36447967893923,826.9460155160959),np.complex(1.0,0.0),np.complex(-1.3060751215530133,1.8918840992200272),np.complex(52240.031234030765,39572.041047531115)},1.2e-11),'complex power 191')
end
do
 local a=np.array({np.complex(3.0,-0.0),np.complex(8.0,5.0),np.complex(-1.0,-5.0),np.complex(0.0,-0.0),np.complex(0.0,-1.0),np.complex(8.0,2.0),np.complex(8.0,-5.0),np.complex(0.0,2.0),np.complex(0.25,2.0)},np.complex128)
 local b=np.array({np.complex(5.0,0.0),np.complex(0.0,0.0),np.complex(2.0,0.0),np.complex(0.0,0.0),np.complex(1.0,0.5),np.complex(-1.0,0.5),np.complex(0.0,-5.0),np.complex(3.0,-0.0),np.complex(-3.0,-1.0)},np.complex128)
 local r=np.power(a,b)
 assert(r.dtype=='complex128','complex power dtype 192')
 assert(list_same(r:tolist(),{np.complex(243.0,0.0),np.complex(1.0,0.0),np.complex(-24.0,10.0),np.complex(1.0,0.0),np.complex(1.3429966968850273e-16,-2.1932800507380152),np.complex(0.07398246453958927,0.07769942982336454),np.complex(0.013723141512065462,0.05967997116269099),np.complex(-0.0,-8.0),np.complex(0.1670469000532729,0.49116004400427543)},1.2e-11),'complex power 192')
end
do
 local a=np.array({np.complex(0.25,0.0),np.complex(-1.0,-5.0),np.complex(-8.0,2.0),np.complex(-8.0,-5.0),np.complex(-0.0,0.5),np.complex(3.0,0.0),np.complex(1.0,2.0),np.complex(3.0,5.0),np.complex(-8.0,-1.0)},np.complex128)
 local b=np.array({np.complex(-5.0,0.0),np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(1.0,0.0),np.complex(-1.0,5.0),np.complex(-8.0,0.0),np.complex(0.0,-0.0),np.complex(-1.0,-5.0),np.complex(0.25,5.0)},np.complex128)
 local r=np.power(a,b)
 assert(r.dtype=='complex128','complex power dtype 193')
 assert(list_same(r:tolist(),{np.complex(1024.0,0.0),np.complex(1.0,0.0),np.complex(-8.0,2.0),np.complex(-8.0,-5.0),np.complex(0.00024728293175611197,0.0007359742263273412),np.complex(0.00015241579027587258,0.0),np.complex(1.0,0.0),np.complex(-27.034412577253825,12.121503566181516),np.complex(-5807283.423008018,-1525482.5368641985)},1.2e-11),'complex power 193')
end
do
 local a=np.array({np.complex(-0.0,0.5),np.complex(-8.0,-5.0),np.complex(0.0,2.0),np.complex(-0.0,-5.0),np.complex(-3.0,-0.0),np.complex(-3.0,2.0),np.complex(1.0,2.0),np.complex(-1.0,0.0),np.complex(-0.0,-5.0)},np.complex128)
 local b=np.array({np.complex(5.0,0.0),np.complex(0.0,0.0),np.complex(3.0,0.0),np.complex(2.0,0.0),np.complex(8.0,0.0),np.complex(-3.0,-0.0),np.complex(-8.0,-5.0),np.complex(8.0,-5.0),np.complex(-8.0,-1.0)},np.complex128)
 local r=np.power(a,b)
 assert(r.dtype=='complex128','complex power dtype 194')
 assert(list_same(r:tolist(),{np.complex(-0.0,0.03125),np.complex(1.0,0.0),np.complex(-0.0,-8.0),np.complex(-25.0,0.0),np.complex(6561.0,0.0),np.complex(0.0040964952207555765,-0.020937642239417388),np.complex(0.3858631039911409,-0.12548316247605404),np.complex(6635623.99934113,-6.501036552910779e-09),np.complex(-2.055884171126226e-08,-5.317744529036249e-07)},1.2e-11),'complex power 194')
end
do
 local a=np.array({np.complex(-1.0,5.0),np.complex(3.0,0.0),np.complex(-3.0,-0.0),np.complex(-3.0,2.0),np.complex(1.0,0.0),np.complex(-8.0,-0.0),np.complex(8.0,-1.0),np.complex(-8.0,0.5),np.complex(8.0,-5.0)},np.complex128)
 local b=np.array({np.complex(-2.0,0.0),np.complex(-3.0,0.0),np.complex(2.0,0.0),np.complex(2.0,0.0),np.complex(-0.0,-0.0),np.complex(1.0,-0.0),np.complex(0.25,-1.0),np.complex(-3.0,2.0),np.complex(0.0,-0.0)},np.complex128)
 local r=np.power(a,b)
 assert(r.dtype=='complex128','complex power dtype 195')
 assert(list_same(r:tolist(),{np.complex(-0.03550295857988166,0.014792899408284025),np.complex(0.037037037037037035,0.0),np.complex(9.0,0.0),np.complex(5.0,-12.0),np.complex(1.0,0.0),np.complex(-8.0,-0.0),np.complex(-0.7745751791400638,-1.2705210312980284),np.complex(1.4562553076146773e-06,3.841458956502097e-06),np.complex(1.0,0.0)},1.2e-11),'complex power 195')
end
do
 local a=np.array({np.complex(0.25,-5.0),np.complex(8.0,0.0),np.complex(-1.0,2.0),np.complex(0.0,-0.0),np.complex(-1.0,0.0),np.complex(-8.0,-1.0),np.complex(3.0,-1.0),np.complex(0.25,0.0),np.complex(-0.0,5.0)},np.complex128)
 local b=np.array({np.complex(-2.0,0.0),np.complex(-5.0,0.0),np.complex(-2.0,0.0),np.complex(3.0,0.0),np.complex(8.0,5.0),np.complex(-1.0,2.0),np.complex(8.0,-0.0),np.complex(-1.0,-0.0),np.complex(0.0,-5.0)},np.complex128)
 local r=np.power(a,b)
 assert(r.dtype=='complex128','complex power dtype 196')
 assert(list_same(r:tolist(),{np.complex(-0.03970124563901965,0.003980074750778912),np.complex(3.0517578125e-05,0.0),np.complex(-0.12,0.16),np.complex(0.0,0.0),np.complex(1.5070172753900654e-07,-1.4764511060529672e-22),np.complex(31.852349692788408,40.84220612157977),np.complex(-8432.0,-5376.0),np.complex(4.0,0.0),np.complex(-494.6072442259309,-2528.0402831640877)},1.2e-11),'complex power 196')
end
do
 local a=np.array({np.complex(-1.0,2.0),np.complex(1.0,0.5),np.complex(-8.0,5.0),np.complex(-1.0,-0.0),np.complex(0.25,2.0),np.complex(-8.0,-5.0),np.complex(0.0,2.0),np.complex(-8.0,-5.0),np.complex(-3.0,-0.0)},np.complex128)
 local b=np.array({np.complex(-1.0,0.0),np.complex(3.0,0.0),np.complex(0.0,0.0),np.complex(3.0,0.0),np.complex(0.25,0.5),np.complex(-3.0,-5.0),np.complex(3.0,-5.0),np.complex(-1.0,0.5),np.complex(-8.0,-1.0)},np.complex128)
 local r=np.power(a,b)
 assert(r.dtype=='complex128','complex power dtype 197')
 assert(list_same(r:tolist(),{np.complex(-0.2,-0.4),np.complex(0.25,1.375),np.complex(1.0,0.0),np.complex(-1.0,-0.0),np.complex(0.4376373223247475,0.3777321592589923),np.complex(-2.771884138574902e-09,9.525939799500741e-10),np.complex(6563.506226353163,19534.592956456905),np.complex(-0.32601379191577173,-0.2060145218656286),np.complex(2.99574624961782e-06,-5.865770993175147e-06)},1.2e-11),'complex power 197')
end
do
 local a=np.array({np.complex(3.0,-0.0),np.complex(-1.0,0.0),np.complex(-8.0,-1.0),np.complex(3.0,5.0),np.complex(1.0,0.0),np.complex(-1.0,-1.0),np.complex(0.25,5.0),np.complex(8.0,5.0),np.complex(-8.0,2.0)},np.complex128)
 local b=np.array({np.complex(-5.0,0.0),np.complex(-5.0,0.0),np.complex(-2.0,0.0),np.complex(-1.0,0.0),np.complex(-8.0,5.0),np.complex(-0.0,-5.0),np.complex(0.0,0.0),np.complex(-1.0,5.0),np.complex(0.25,-0.0)},np.complex128)
 local r=np.power(a,b)
 assert(r.dtype=='complex128','complex power dtype 198')
 assert(list_same(r:tolist(),{np.complex(0.00411522633744856,0.0),np.complex(-1.0,-0.0),np.complex(0.014911242603550296,-0.00378698224852071),np.complex(0.08823529411764706,-0.14705882352941177),np.complex(1.0,0.0),np.complex(-1.2342203616218402e-06,-7.548482865245115e-06),np.complex(1.0,0.0),np.complex(-0.002119266558617202,-0.00613545479620062),np.complex(1.269347435452266,1.1226659338987073)},1.2e-11),'complex power 198')
end
do
 local a=np.array({np.complex(1.0,5.0),np.complex(0.0,2.0),np.complex(-1.0,2.0),np.complex(3.0,2.0),np.complex(0.25,-1.0),np.complex(8.0,2.0),np.complex(0.0,0.5),np.complex(1.0,0.5),np.complex(-3.0,-5.0)},np.complex128)
 local b=np.array({np.complex(1.0,0.0),np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0),np.complex(-0.0,2.0),np.complex(0.0,2.0),np.complex(-8.0,0.5),np.complex(1.0,2.0),np.complex(-8.0,-0.0)},np.complex128)
 local r=np.power(a,b)
 assert(r.dtype=='complex128','complex power dtype 199')
 assert(list_same(r:tolist(),{np.complex(1.0,5.0),np.complex(1.0,0.0),np.complex(-1.0,2.0),np.complex(-9.0,46.0),np.complex(14.151158990154622,0.8589612462181869),np.complex(-0.2898864578793493,-0.5397304638592608),np.complex(109.7802256113582,-39.64716863084703),np.complex(0.34203863453005506,0.280456528008854),np.complex(-2.8383118489225575e-07,-6.923979282323788e-07)},1.2e-11),'complex power 199')
end
do
 local a=np.array({np.complex(-8.0,-1.0),np.complex(-8.0,2.0),np.complex(0.25,-1.0),np.complex(0.25,0.5),np.complex(0.0,-1.0),np.complex(0.25,0.0),np.complex(0.25,-5.0),np.complex(-3.0,2.0),np.complex(-0.0,5.0)},np.complex128)
 local b=np.array({np.complex(-3.0,0.0),np.complex(-1.0,0.0),np.complex(-2.0,0.0),np.complex(1.0,0.0),np.complex(-1.0,0.0),np.complex(-8.0,5.0),np.complex(-3.0,0.0),np.complex(0.0,0.5),np.complex(1.0,5.0)},np.complex128)
 local r=np.power(a,b)
 assert(r.dtype=='complex128','complex power dtype 200')
 assert(list_same(r:tolist(),{np.complex(-0.0017769685935366407,0.0006954938552571688),np.complex(-0.11764705882352941,-0.029411764705882353),np.complex(-0.8304498269896194,0.4429065743944637),np.complex(0.25,0.5),np.complex(-0.0,1.0),np.complex(52240.031234030765,-39572.041047531115),np.complex(-0.0011900522758563382,-0.007880746514011114),np.complex(0.2235221536472958,0.16685232487528667),np.complex(-0.0019049001898051368,-0.0003726908307907755)},1.2e-11),'complex power 200')
end
do
 local a=np.array({np.complex(3.0,-0.0),np.complex(-8.0,0.0),np.complex(0.0,2.0),np.complex(-3.0,0.0),np.complex(-1.0,0.0),np.complex(3.0,-1.0),np.complex(-3.0,0.0),np.complex(1.0,-5.0),np.complex(3.0,0.0)},np.complex128)
 local b=np.array({np.complex(-5.0,0.0),np.complex(3.0,0.0),np.complex(-3.0,0.0),np.complex(5.0,0.0),np.complex(-3.0,-0.0),np.complex(0.25,5.0),np.complex(-8.0,-1.0),np.complex(-3.0,-5.0),np.complex(-1.0,2.0)},np.complex128)
 local r=np.power(a,b)
 assert(r.dtype=='complex128','complex power dtype 201')
 assert(list_same(r:tolist(),{np.complex(0.00411522633744856,0.0),np.complex(-512.0,0.0),np.complex(-0.0,0.125),np.complex(-243.0,0.0),np.complex(-1.0,-0.0),np.complex(5.4721654616934385,-3.8015146417833208),np.complex(0.0016041971187399575,-0.003141071420064499),np.complex(-4.984982509597647e-06,6.072651584973227e-06),np.complex(-0.19541831143045077,0.2700422090503306)},1.2e-11),'complex power 201')
end
do
 local a=np.array({np.complex(-3.0,-5.0),np.complex(-8.0,2.0),np.complex(-1.0,0.5),np.complex(1.0,-0.0),np.complex(-0.0,-5.0),np.complex(1.0,0.0),np.complex(-0.0,5.0),np.complex(0.0,0.5),np.complex(-8.0,-0.0)},np.complex128)
 local b=np.array({np.complex(0.0,0.0),np.complex(-2.0,0.0),np.complex(-3.0,0.0),np.complex(2.0,0.0),np.complex(-0.0,-5.0),np.complex(0.0,0.5),np.complex(0.25,2.0),np.complex(3.0,-1.0),np.complex(-3.0,-1.0)},np.complex128)
 local r=np.power(a,b)
 assert(r.dtype=='complex128','complex power dtype 202')
 assert(list_same(r:tolist(),{np.complex(1.0,0.0),np.complex(0.012975778546712804,0.006920415224913495),np.complex(-0.128,-0.7040000000000001),np.complex(1.0,-0.0),np.complex(-7.453816615815512e-05,-0.00038098003796102734),np.complex(1.0,0.0),np.complex(-0.05761355516736609,-0.02926443495377672),np.complex(0.3842135958774366,-0.46255079194625326),np.complex(4.110339252516927e-05,7.371729651363797e-05)},1.2e-11),'complex power 202')
end
do
 local a=np.array({np.complex(0.25,-0.0),np.complex(3.0,0.5),np.complex(-0.0,-0.0),np.complex(1.0,0.0),np.complex(-1.0,5.0),np.complex(0.0,5.0),np.complex(0.25,-5.0),np.complex(-1.0,-1.0),np.complex(1.0,-1.0)},np.complex128)
 local b=np.array({np.complex(-3.0,0.0),np.complex(5.0,0.0),np.complex(-2.0,0.0),np.complex(1.0,0.0),np.complex(0.25,2.0),np.complex(3.0,-1.0),np.complex(-0.0,-0.0),np.complex(-0.0,5.0),np.complex(-3.0,0.0)},np.complex128)
 local r=np.power(a,b)
 assert(r.dtype=='complex128','complex power dtype 203')
 assert(list_same(r:tolist(),{np.complex(64.0,0.0),np.complex(176.4375,191.28125),np.complex((0/0),(0/0)),np.complex(1.0,0.0),np.complex(-0.037106293458412105,-0.023188984542228692),np.complex(-600.8607990530821,23.22977719366641),np.complex(1.0,0.0),np.complex(-21096.74049366771,129027.51330379242),np.complex(-0.25,0.25)},1.2e-11),'complex power 203')
end
do
 local a=np.array({np.complex(-3.0,0.0),np.complex(-3.0,-1.0),np.complex(-0.0,-0.0),np.complex(-1.0,-0.0),np.complex(-0.0,-0.0),np.complex(-1.0,-5.0),np.complex(-1.0,2.0),np.complex(1.0,0.5),np.complex(1.0,0.0)},np.complex128)
 local b=np.array({np.complex(-5.0,0.0),np.complex(5.0,0.0),np.complex(2.0,0.0),np.complex(2.0,0.0),np.complex(1.0,-1.0),np.complex(-8.0,-0.0),np.complex(-3.0,-0.0),np.complex(-8.0,0.0),np.complex(-8.0,-0.0)},np.complex128)
 local r=np.power(a,b)
 assert(r.dtype=='complex128','complex power dtype 204')
 assert(list_same(r:tolist(),{np.complex(-0.00411522633744856,-0.0),np.complex(12.0,-316.0),np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(0.0,0.0),np.complex(-1.831180267636383e-08,2.188222110614858e-06),np.complex(0.08800000000000001,0.016),np.complex(-0.34537471999999997,0.22020095999999997),np.complex(1.0,0.0)},1.2e-11),'complex power 204')
end
do
 local a=np.array({np.complex(-8.0,5.0),np.complex(0.0,0.5),np.complex(-1.0,-5.0),np.complex(-3.0,-0.0),np.complex(-1.0,2.0),np.complex(-3.0,2.0),np.complex(0.0,-0.0),np.complex(-3.0,0.5),np.complex(-0.0,5.0)},np.complex128)
 local b=np.array({np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(3.0,0.0),np.complex(3.0,0.0),np.complex(0.0,2.0),np.complex(0.0,-0.0),np.complex(-1.0,0.5),np.complex(-1.0,2.0),np.complex(-1.0,0.5)},np.complex128)
 local r=np.power(a,b)
 assert(r.dtype=='complex128','complex power dtype 205')
 assert(list_same(r:tolist(),{np.complex(1.0,0.0),np.complex(1.0,0.0),np.complex(74.0,110.0),np.complex(-27.0,-0.0),np.complex(-0.0006604672754999542,0.017083628981750077),np.complex(1.0,0.0),np.complex((0/0),(0/0)),np.complex(0.0006240384170587661,-0.0005834775176657267),np.complex(0.06571306930804918,-0.06322163851203162)},1.2e-11),'complex power 205')
end
do
 local a=np.array({np.complex(0,0),np.complex(2,1)},np.complex128)
 local b=np.array({np.complex(-1,0),np.complex(2,0)},np.complex128)
 local out=np.array({np.complex(9,9),np.complex(8,8)},np.complex128)
 local m=np.array({false,true},np.bool)
 np.power(a,b,{out=out,where=m})
 assert(zsame(out[1],np.complex(9,9),1e-12))
 assert(zsame(out[2],np.complex(3,4),1e-12))
end
print('complex math differential: 207 cases ok')
