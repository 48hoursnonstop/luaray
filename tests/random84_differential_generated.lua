-- Frozen independent NumPy 2.3.5 random84 reference
local np=require('luaray_core')
assert(np._version=='0.114.0-dev')
local cases=0
local function eq(a,b)
 if type(a)~=type(b) then return false end
 if type(a)=='table' then
  if #a~=#b then return false end
  for i=1,#a do if not eq(a[i],b[i]) then return false end end
  return true
 end
 return a==b
end
local function check(x,shape,expected,tail,r)
 cases=cases+1
 if #shape==0 then assert(type(x)=='number' and x==expected,('case %d scalar'):format(cases))
 else
  assert(type(x)=='userdata',('case %d ndarray'):format(cases))
  assert(x.dtype=='int64',('case %d dtype'):format(cases))
  assert(eq(x.shape,shape),('case %d shape'):format(cases))
  assert(eq(x:tolist(),expected),('case %d values'):format(cases))
 end
 assert(r:raw_hex()==tail,('case %d PCG64'):format(cases))
end
do local r=np.random.default_rng(0);local x=r:binomial(np.array({0,1,2,10,100,1000},"int64"),0.4);check(x,{6},{0,1,0,1,34,373},"089910738de7951f",r) end
do local r=np.random.default_rng(0);local x=r:binomial(np.array({0,1,2,10,100,1000},"int64"),0.4, {2,6});check(x,{2,6},{{0,1,0,1,34,373},{0,0,1,3,31,400}},"073ff53d673aa30c",r) end
do local r=np.random.default_rng(0);local x=r:binomial(np.array({0,1,2,10,100,1000},"int64"),0.4, {0,6});check(x,{0,6},{},"a30febcfd9c2825f",r) end
do local r=np.random.default_rng(0);local x=r:binomial(np.array({{0},{1},{10},{50}},"int64"),np.array({{0.0,0.01,0.5,0.99,1.0}},"float64"));check(x,{4,5},{{0,0,0,0,0},{0,0,0,1,1},{0,0,7,10,10},{0,0,30,49,50}},"db7ed8bf64e6f5f0",r) end
do local r=np.random.default_rng(0);local x=r:binomial(np.array({{0},{1},{10},{50}},"int64"),np.array({{0.0,0.01,0.5,0.99,1.0}},"float64"), {2,4,5});check(x,{2,4,5},{{{0,0,0,0,0},{0,0,0,1,1},{0,0,7,10,10},{0,0,30,49,50}},{{0,0,0,0,0},{0,0,0,1,1},{0,0,5,10,10},{0,0,21,49,50}}},"9d89e0f041de6631",r) end
do local r=np.random.default_rng(0);local x=r:binomial(np.array({{0},{1},{10},{50}},"int64"),np.array({{0.0,0.01,0.5,0.99,1.0}},"float64"), {0,4,5});check(x,{0,4,5},{},"a30febcfd9c2825f",r) end
do local r=np.random.default_rng(0);local x=r:binomial(np.flip(np.array({{4,9,13},{20,30,50}},"int64"),2),0.3);check(x,{2,3},{{4,2,0},{8,11,9}},"9b4c7b7180edb27f",r) end
do local r=np.random.default_rng(0);local x=r:binomial(np.flip(np.array({{4,9,13},{20,30,50}},"int64"),2),0.3, {2,2,3});check(x,{2,2,3},{{{4,2,0},{8,11,9}},{{4,3,1},{20,11,1}}},"db7ed8bf64e6f5f0",r) end
do local r=np.random.default_rng(0);local x=r:binomial(np.flip(np.array({{4,9,13},{20,30,50}},"int64"),2),0.3, {0,2,3});check(x,{0,2,3},{},"a30febcfd9c2825f",r) end
do local r=np.random.default_rng(0);local x=r:binomial(100,np.array({0.0,0.1,0.5,0.9,1.0},"float32"));check(x,{5},{0,11,55,96,100},"e9aa5979a6401c4e",r) end
do local r=np.random.default_rng(0);local x=r:binomial(100,np.array({0.0,0.1,0.5,0.9,1.0},"float32"), {2,5});check(x,{2,5},{{0,11,55,96,100},{0,14,57,87,100}},"bacab307c3cfd379",r) end
do local r=np.random.default_rng(0);local x=r:binomial(100,np.array({0.0,0.1,0.5,0.9,1.0},"float32"), {0,5});check(x,{0,5},{},"a30febcfd9c2825f",r) end
do local r=np.random.default_rng(0);local x=r:binomial(np.transpose(np.array({{10,20},{30,40}},"int64")),0.12);check(x,{2,2},{{1,2},{0,1}},"d0327a782cde513b",r) end
do local r=np.random.default_rng(0);local x=r:binomial(np.transpose(np.array({{10,20},{30,40}},"int64")),0.12, {2,2,2});check(x,{2,2,2},{{{1,2},{0,1}},{{2,6},{3,6}}},"8b2b01e7a1dc7fbf",r) end
do local r=np.random.default_rng(0);local x=r:binomial(np.transpose(np.array({{10,20},{30,40}},"int64")),0.12, {0,2,2});check(x,{0,2,2},{},"a30febcfd9c2825f",r) end
do local r=np.random.default_rng(0);local x=r:binomial(np.array({3,13,25},"int64"),np.array({0.15,0.5,0.95},"float64"));check(x,{3},{1,5,25},"043b27b61342f01d",r) end
do local r=np.random.default_rng(0);local x=r:binomial(np.array({3,13,25},"int64"),np.array({0.15,0.5,0.95},"float64"), {2,3});check(x,{2,3},{{1,5,25},{0,8,22}},"9b4c7b7180edb27f",r) end
do local r=np.random.default_rng(0);local x=r:binomial(np.array({3,13,25},"int64"),np.array({0.15,0.5,0.95},"float64"), {0,3});check(x,{0,3},{},"a30febcfd9c2825f",r) end
do local r=np.random.default_rng(0);local x=r:binomial(np.array({4,100,1000,100000},"int64"),np.array({0.05,0.75,0.5,0.001},"float64"));check(x,{4},{0,78,501,101},"d0dbc74d4700374c",r) end
do local r=np.random.default_rng(0);local x=r:binomial(np.array({4,100,1000,100000},"int64"),np.array({0.05,0.75,0.5,0.001},"float64"), {2,4});check(x,{2,4},{{0,78,501,101},{1,86,510,101}},"dcf94b3a16db7f0e",r) end
do local r=np.random.default_rng(0);local x=r:binomial(np.array({4,100,1000,100000},"int64"),np.array({0.05,0.75,0.5,0.001},"float64"), {0,4});check(x,{0,4},{},"a30febcfd9c2825f",r) end
do local r=np.random.default_rng(0);local x=r:binomial(np.array({{100,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2));check(x,{2,2},{{99,0},{11,23}},"d0327a782cde513b",r) end
do local r=np.random.default_rng(0);local x=r:binomial(np.array({{100,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2), {2,2,2});check(x,{2,2,2},{{{99,0},{11,23}},{{98,2},{17,17}}},"8b2b01e7a1dc7fbf",r) end
do local r=np.random.default_rng(0);local x=r:binomial(np.array({{100,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2), {0,2,2});check(x,{0,2,2},{},"a30febcfd9c2825f",r) end
do local r=np.random.default_rng(0);local x=r:binomial(1000000000000,np.array({1e-08,0.0001,0.5,0.9999,1.0},"float64"));check(x,{5},{10124,100000827,500000080624,999900004729,1000000000000},"00b37868abbe90b0",r) end
do local r=np.random.default_rng(0);local x=r:binomial(1000000000000,np.array({1e-08,0.0001,0.5,0.9999,1.0},"float64"), {2,5});check(x,{2,5},{{10124,100000827,500000080624,999900004729,1000000000000},{9817,99984964,499999307834,999899990849,1000000000000}},"073ff53d673aa30c",r) end
do local r=np.random.default_rng(0);local x=r:binomial(1000000000000,np.array({1e-08,0.0001,0.5,0.9999,1.0},"float64"), {0,5});check(x,{0,5},{},"a30febcfd9c2825f",r) end
do local r=np.random.default_rng(0);local x=r:binomial(np.array(6,"int64"),np.array(0.23,"float64"));check(x,{},2,"4510bdf882d9d721",r) end
do local r=np.random.default_rng(0);local x=r:binomial(np.array(6,"int64"),np.array(0.23,"float64"), {2});check(x,{2},{2,1},"0a7d3da94ecde8b8",r) end
do local r=np.random.default_rng(0);local x=r:binomial(np.array(6,"int64"),np.array(0.23,"float64"), {0});check(x,{0},{},"a30febcfd9c2825f",r) end
do local r=np.random.default_rng(0);local x=r:binomial(30,0.5);check(x,{},16,"4510bdf882d9d721",r) end
do local r=np.random.default_rng(0);local x=r:binomial(30,0.5, {2});check(x,{2},{16,13},"0a7d3da94ecde8b8",r) end
do local r=np.random.default_rng(0);local x=r:binomial(30,0.5, {0});check(x,{0},{},"a30febcfd9c2825f",r) end
do local r=np.random.default_rng(0);local x=r:binomial(0,np.array({0.0,0.4,1.0},"float64"));check(x,{3},{0,0,0},"a30febcfd9c2825f",r) end
do local r=np.random.default_rng(0);local x=r:binomial(0,np.array({0.0,0.4,1.0},"float64"), {2,3});check(x,{2,3},{{0,0,0},{0,0,0}},"a30febcfd9c2825f",r) end
do local r=np.random.default_rng(0);local x=r:binomial(0,np.array({0.0,0.4,1.0},"float64"), {0,3});check(x,{0,3},{},"a30febcfd9c2825f",r) end
do local r=np.random.default_rng(0);local x=r:binomial(np.array({0,1,2,3,4},"int64"),np.array({1.0,1.0,1.0,1.0,1.0},"float64"));check(x,{5},{0,1,2,3,4},"d0327a782cde513b",r) end
do local r=np.random.default_rng(0);local x=r:binomial(np.array({0,1,2,3,4},"int64"),np.array({1.0,1.0,1.0,1.0,1.0},"float64"), {2,5});check(x,{2,5},{{0,1,2,3,4},{0,1,2,3,4}},"8b2b01e7a1dc7fbf",r) end
do local r=np.random.default_rng(0);local x=r:binomial(np.array({0,1,2,3,4},"int64"),np.array({1.0,1.0,1.0,1.0,1.0},"float64"), {0,5});check(x,{0,5},{},"a30febcfd9c2825f",r) end
do local r=np.random.default_rng(0);local x=r:negative_binomial(np.array({0.1,0.5,1.0,2.5,5.0,20.0},"float64"),0.5);check(x,{6},{0,0,1,0,1,15},"073ff53d673aa30c",r) end
do local r=np.random.default_rng(0);local x=r:negative_binomial(np.array({0.1,0.5,1.0,2.5,5.0,20.0},"float64"),0.5, {2,6});check(x,{2,6},{{0,0,1,0,1,15},{0,0,1,2,5,17}},"158207910c6d8aef",r) end
do local r=np.random.default_rng(0);local x=r:negative_binomial(np.array({0.1,0.5,1.0,2.5,5.0,20.0},"float64"),0.5, {0,6});check(x,{0,6},{},"a30febcfd9c2825f",r) end
do local r=np.random.default_rng(0);local x=r:negative_binomial(np.array({{0.1},{0.5},{1.2},{20.0}},"float64"),np.array({{0.01,0.1,0.5,0.95,1.0}},"float64"));check(x,{4,5},{{0,0,0,0,0},{124,0,0,0,0},{139,7,4,0,0},{1631,164,18,2,0}},"f2edf9019a8fd343",r) end
do local r=np.random.default_rng(0);local x=r:negative_binomial(np.array({{0.1},{0.5},{1.2},{20.0}},"float64"),np.array({{0.01,0.1,0.5,0.95,1.0}},"float64"), {2,4,5});check(x,{2,4,5},{{{0,0,0,0,0},{124,0,0,0,0},{139,7,4,0,0},{1631,164,18,2,0}},{{78,0,0,0,0},{159,41,0,0,0},{127,1,2,0,0},{1715,186,7,2,0}}},"1421191e1c14829a",r) end
do local r=np.random.default_rng(0);local x=r:negative_binomial(np.array({{0.1},{0.5},{1.2},{20.0}},"float64"),np.array({{0.01,0.1,0.5,0.95,1.0}},"float64"), {0,4,5});check(x,{0,4,5},{},"a30febcfd9c2825f",r) end
do local r=np.random.default_rng(0);local x=r:negative_binomial(np.flip(np.array({{1.3,2.8},{3.5,8.5}},"float64"),2),0.4);check(x,{2,2},{{1,1},{3,3}},"073ff53d673aa30c",r) end
do local r=np.random.default_rng(0);local x=r:negative_binomial(np.flip(np.array({{1.3,2.8},{3.5,8.5}},"float64"),2),0.4, {2,2,2});check(x,{2,2,2},{{{1,1},{3,3}},{{8,2},{10,7}}},"0d51449ac45abd88",r) end
do local r=np.random.default_rng(0);local x=r:negative_binomial(np.flip(np.array({{1.3,2.8},{3.5,8.5}},"float64"),2),0.4, {0,2,2});check(x,{0,2,2},{},"a30febcfd9c2825f",r) end
do local r=np.random.default_rng(0);local x=r:negative_binomial(10.0,np.array({0.001,0.01,0.1,0.5,1.0},"float32"));check(x,{5},{9796,810,77,5,0},"abae0aa9021eeba8",r) end
do local r=np.random.default_rng(0);local x=r:negative_binomial(10.0,np.array({0.001,0.01,0.1,0.5,1.0},"float32"), {2,5});check(x,{2,5},{{9796,810,77,5,0},{7764,761,52,10,0}},"924fc76bac38a5d1",r) end
do local r=np.random.default_rng(0);local x=r:negative_binomial(10.0,np.array({0.001,0.01,0.1,0.5,1.0},"float32"), {0,5});check(x,{0,5},{},"a30febcfd9c2825f",r) end
do local r=np.random.default_rng(0);local x=r:negative_binomial(np.transpose(np.array({{3.0,20.0},{30.0,40.0}},"float32")),0.12);check(x,{2,2},{{10,201},{134,206}},"dcf94b3a16db7f0e",r) end
do local r=np.random.default_rng(0);local x=r:negative_binomial(np.transpose(np.array({{3.0,20.0},{30.0,40.0}},"float32")),0.12, {2,2,2});check(x,{2,2,2},{{{10,201},{134,206}},{{11,220},{183,227}}},"867d9ef1d8716a3b",r) end
do local r=np.random.default_rng(0);local x=r:negative_binomial(np.transpose(np.array({{3.0,20.0},{30.0,40.0}},"float32")),0.12, {0,2,2});check(x,{0,2,2},{},"a30febcfd9c2825f",r) end
do local r=np.random.default_rng(0);local x=r:negative_binomial(np.array({0.1,1.2,3.7},"float64"),np.array({0.9,0.5,0.2},"float64"));check(x,{3},{0,3,2},"bacab307c3cfd379",r) end
do local r=np.random.default_rng(0);local x=r:negative_binomial(np.array({0.1,1.2,3.7},"float64"),np.array({0.9,0.5,0.2},"float64"), {2,3});check(x,{2,3},{{0,3,2},{0,0,14}},"9d89e0f041de6631",r) end
do local r=np.random.default_rng(0);local x=r:negative_binomial(np.array({0.1,1.2,3.7},"float64"),np.array({0.9,0.5,0.2},"float64"), {0,3});check(x,{0,3},{},"a30febcfd9c2825f",r) end
do local r=np.random.default_rng(0);local x=r:negative_binomial(np.array({4,10,100,1000},"int64"),np.array({0.95,0.75,0.5,0.1},"float64"));check(x,{4},{0,6,84,8787},"073ff53d673aa30c",r) end
do local r=np.random.default_rng(0);local x=r:negative_binomial(np.array({4,10,100,1000},"int64"),np.array({0.95,0.75,0.5,0.1},"float64"), {2,4});check(x,{2,4},{{0,6,84,8787},{0,7,99,8921}},"5266084c412ddeed",r) end
do local r=np.random.default_rng(0);local x=r:negative_binomial(np.array({4,10,100,1000},"int64"),np.array({0.95,0.75,0.5,0.1},"float64"), {0,4});check(x,{0,4},{},"a30febcfd9c2825f",r) end
do local r=np.random.default_rng(0);local x=r:negative_binomial(np.array({{10,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2));check(x,{2,2},{{0,27},{136,7}},"1fd10760015eca68",r) end
do local r=np.random.default_rng(0);local x=r:negative_binomial(np.array({{10,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2), {2,2,2});check(x,{2,2,2},{{{0,27},{136,7}},{{0,31},{75,12}}},"d5282ab7608c2cbc",r) end
do local r=np.random.default_rng(0);local x=r:negative_binomial(np.array({{10,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2), {0,2,2});check(x,{0,2,2},{},"a30febcfd9c2825f",r) end
do local r=np.random.default_rng(0);local x=r:negative_binomial(1000.0,np.array({0.01,0.05,0.5,0.999,1.0},"float64"));check(x,{5},{98552,18715,1009,1,0},"4cb9eb2014951238",r) end
do local r=np.random.default_rng(0);local x=r:negative_binomial(1000.0,np.array({0.01,0.05,0.5,0.999,1.0},"float64"), {2,5});check(x,{2,5},{{98552,18715,1009,1,0},{99221,18642,993,0,0}},"4f6c02f5601b4e18",r) end
do local r=np.random.default_rng(0);local x=r:negative_binomial(1000.0,np.array({0.01,0.05,0.5,0.999,1.0},"float64"), {0,5});check(x,{0,5},{},"a30febcfd9c2825f",r) end
do local r=np.random.default_rng(0);local x=r:negative_binomial(np.array(6.0,"float64"),np.array(0.23,"float64"));check(x,{},9,"d0327a782cde513b",r) end
do local r=np.random.default_rng(0);local x=r:negative_binomial(np.array(6.0,"float64"),np.array(0.23,"float64"), {2});check(x,{2},{9,16},"8b2b01e7a1dc7fbf",r) end
do local r=np.random.default_rng(0);local x=r:negative_binomial(np.array(6.0,"float64"),np.array(0.23,"float64"), {0});check(x,{0},{},"a30febcfd9c2825f",r) end
do local r=np.random.default_rng(0);local x=r:negative_binomial(30.0,0.5);check(x,{},17,"d0327a782cde513b",r) end
do local r=np.random.default_rng(0);local x=r:negative_binomial(30.0,0.5, {2});check(x,{2},{17,28},"8b2b01e7a1dc7fbf",r) end
do local r=np.random.default_rng(0);local x=r:negative_binomial(30.0,0.5, {0});check(x,{0},{},"a30febcfd9c2825f",r) end
do local r=np.random.default_rng(0);local x=r:negative_binomial(np.array({0.5,1.0,2.0,4.0},"float64"),np.array({1.0,1.0,1.0,1.0},"float64"));check(x,{4},{0,0,0,0},"bac0495ff8829a45",r) end
do local r=np.random.default_rng(0);local x=r:negative_binomial(np.array({0.5,1.0,2.0,4.0},"float64"),np.array({1.0,1.0,1.0,1.0},"float64"), {2,4});check(x,{2,4},{{0,0,0,0},{0,0,0,0}},"bacab307c3cfd379",r) end
do local r=np.random.default_rng(0);local x=r:negative_binomial(np.array({0.5,1.0,2.0,4.0},"float64"),np.array({1.0,1.0,1.0,1.0},"float64"), {0,4});check(x,{0,4},{},"a30febcfd9c2825f",r) end
do local r=np.random.default_rng(1);local x=r:binomial(np.array({0,1,2,10,100,1000},"int64"),0.4);check(x,{6},{0,0,2,2,51,393},"68c1464c41ca3aca",r) end
do local r=np.random.default_rng(1);local x=r:binomial(np.array({0,1,2,10,100,1000},"int64"),0.4, {2,6});check(x,{2,6},{{0,0,2,2,51,393},{0,0,1,1,40,400}},"22508e81fa16820b",r) end
do local r=np.random.default_rng(1);local x=r:binomial(np.array({0,1,2,10,100,1000},"int64"),0.4, {0,6});check(x,{0,6},{},"8306bdf37922e4ff",r) end
do local r=np.random.default_rng(1);local x=r:binomial(np.array({{0},{1},{10},{50}},"int64"),np.array({{0.0,0.01,0.5,0.99,1.0}},"float64"));check(x,{4,5},{{0,0,0,0,0},{0,0,1,1,1},{0,0,5,10,10},{0,0,18,49,50}},"54694c3ad14a9948",r) end
do local r=np.random.default_rng(1);local x=r:binomial(np.array({{0},{1},{10},{50}},"int64"),np.array({{0.0,0.01,0.5,0.99,1.0}},"float64"), {2,4,5});check(x,{2,4,5},{{{0,0,0,0,0},{0,0,1,1,1},{0,0,5,10,10},{0,0,18,49,50}},{{0,0,0,0,0},{0,0,1,1,1},{0,0,5,10,10},{0,1,23,50,50}}},"f62f2a74bfc53500",r) end
do local r=np.random.default_rng(1);local x=r:binomial(np.array({{0},{1},{10},{50}},"int64"),np.array({{0.0,0.01,0.5,0.99,1.0}},"float64"), {0,4,5});check(x,{0,4,5},{},"8306bdf37922e4ff",r) end
do local r=np.random.default_rng(1);local x=r:binomial(np.flip(np.array({{4,9,13},{20,30,50}},"int64"),2),0.3);check(x,{2,3},{{4,5,0},{20,8,6}},"d3e4513345ee6d24",r) end
do local r=np.random.default_rng(1);local x=r:binomial(np.flip(np.array({{4,9,13},{20,30,50}},"int64"),2),0.3, {2,2,3});check(x,{2,2,3},{{{4,5,0},{20,8,6}},{{5,2,1},{9,11,6}}},"54694c3ad14a9948",r) end
do local r=np.random.default_rng(1);local x=r:binomial(np.flip(np.array({{4,9,13},{20,30,50}},"int64"),2),0.3, {0,2,3});check(x,{0,2,3},{},"8306bdf37922e4ff",r) end
do local r=np.random.default_rng(1);local x=r:binomial(100,np.array({0.0,0.1,0.5,0.9,1.0},"float32"));check(x,{5},{0,10,62,91,100},"68c1464c41ca3aca",r) end
do local r=np.random.default_rng(1);local x=r:binomial(100,np.array({0.0,0.1,0.5,0.9,1.0},"float32"), {2,5});check(x,{2,5},{{0,10,62,91,100},{0,9,46,88,100}},"54694c3ad14a9948",r) end
do local r=np.random.default_rng(1);local x=r:binomial(100,np.array({0.0,0.1,0.5,0.9,1.0},"float32"), {0,5});check(x,{0,5},{},"8306bdf37922e4ff",r) end
do local r=np.random.default_rng(1);local x=r:binomial(np.transpose(np.array({{10,20},{30,40}},"int64")),0.12);check(x,{2,2},{{1,7},{1,8}},"4fd42fa03fcd72a9",r) end
do local r=np.random.default_rng(1);local x=r:binomial(np.transpose(np.array({{10,20},{30,40}},"int64")),0.12, {2,2,2});check(x,{2,2,2},{{{1,7},{1,8}},{{1,3},{4,4}}},"8cb22c02a4d1fa2a",r) end
do local r=np.random.default_rng(1);local x=r:binomial(np.transpose(np.array({{10,20},{30,40}},"int64")),0.12, {0,2,2});check(x,{0,2,2},{},"8306bdf37922e4ff",r) end
do local r=np.random.default_rng(1);local x=r:binomial(np.array({3,13,25},"int64"),np.array({0.15,0.5,0.95},"float64"));check(x,{3},{0,9,25},"f2dab0aed2ac6fd2",r) end
do local r=np.random.default_rng(1);local x=r:binomial(np.array({3,13,25},"int64"),np.array({0.15,0.5,0.95},"float64"), {2,3});check(x,{2,3},{{0,9,25},{2,6,24}},"d3e4513345ee6d24",r) end
do local r=np.random.default_rng(1);local x=r:binomial(np.array({3,13,25},"int64"),np.array({0.15,0.5,0.95},"float64"), {0,3});check(x,{0,3},{},"8306bdf37922e4ff",r) end
do local r=np.random.default_rng(1);local x=r:binomial(np.array({4,100,1000,100000},"int64"),np.array({0.05,0.75,0.5,0.001},"float64"));check(x,{4},{0,68,476,103},"d3e4513345ee6d24",r) end
do local r=np.random.default_rng(1);local x=r:binomial(np.array({4,100,1000,100000},"int64"),np.array({0.05,0.75,0.5,0.001},"float64"), {2,4});check(x,{2,4},{{0,68,476,103},{1,76,525,97}},"4d9e2d241fb91945",r) end
do local r=np.random.default_rng(1);local x=r:binomial(np.array({4,100,1000,100000},"int64"),np.array({0.05,0.75,0.5,0.001},"float64"), {0,4});check(x,{0,4},{},"8306bdf37922e4ff",r) end
do local r=np.random.default_rng(1);local x=r:binomial(np.array({{100,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2));check(x,{2,2},{{99,3},{13,15}},"4fd42fa03fcd72a9",r) end
do local r=np.random.default_rng(1);local x=r:binomial(np.array({{100,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2), {2,2,2});check(x,{2,2,2},{{{99,3},{13,15}},{{100,1},{20,19}}},"8cb22c02a4d1fa2a",r) end
do local r=np.random.default_rng(1);local x=r:binomial(np.array({{100,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2), {0,2,2});check(x,{0,2,2},{},"8306bdf37922e4ff",r) end
do local r=np.random.default_rng(1);local x=r:binomial(1000000000000,np.array({1e-08,0.0001,0.5,0.9999,1.0},"float64"));check(x,{5},{9942,99983370,499999988390,999900006291,1000000000000},"070e1d3215f30262",r) end
do local r=np.random.default_rng(1);local x=r:binomial(1000000000000,np.array({1e-08,0.0001,0.5,0.9999,1.0},"float64"), {2,5});check(x,{2,5},{{9942,99983370,499999988390,999900006291,1000000000000},{9846,100008396,500000511675,999899992756,1000000000000}},"c017e631051316f3",r) end
do local r=np.random.default_rng(1);local x=r:binomial(1000000000000,np.array({1e-08,0.0001,0.5,0.9999,1.0},"float64"), {0,5});check(x,{0,5},{},"8306bdf37922e4ff",r) end
do local r=np.random.default_rng(1);local x=r:binomial(np.array(6,"int64"),np.array(0.23,"float64"));check(x,{},1,"f35196bbc152a866",r) end
do local r=np.random.default_rng(1);local x=r:binomial(np.array(6,"int64"),np.array(0.23,"float64"), {2});check(x,{2},{1,3},"24e7a4f608ec18cd",r) end
do local r=np.random.default_rng(1);local x=r:binomial(np.array(6,"int64"),np.array(0.23,"float64"), {0});check(x,{0},{},"8306bdf37922e4ff",r) end
do local r=np.random.default_rng(1);local x=r:binomial(30,0.5);check(x,{},15,"f35196bbc152a866",r) end
do local r=np.random.default_rng(1);local x=r:binomial(30,0.5, {2});check(x,{2},{15,19},"24e7a4f608ec18cd",r) end
do local r=np.random.default_rng(1);local x=r:binomial(30,0.5, {0});check(x,{0},{},"8306bdf37922e4ff",r) end
do local r=np.random.default_rng(1);local x=r:binomial(0,np.array({0.0,0.4,1.0},"float64"));check(x,{3},{0,0,0},"8306bdf37922e4ff",r) end
do local r=np.random.default_rng(1);local x=r:binomial(0,np.array({0.0,0.4,1.0},"float64"), {2,3});check(x,{2,3},{{0,0,0},{0,0,0}},"8306bdf37922e4ff",r) end
do local r=np.random.default_rng(1);local x=r:binomial(0,np.array({0.0,0.4,1.0},"float64"), {0,3});check(x,{0,3},{},"8306bdf37922e4ff",r) end
do local r=np.random.default_rng(1);local x=r:binomial(np.array({0,1,2,3,4},"int64"),np.array({1.0,1.0,1.0,1.0,1.0},"float64"));check(x,{5},{0,1,2,3,4},"4fd42fa03fcd72a9",r) end
do local r=np.random.default_rng(1);local x=r:binomial(np.array({0,1,2,3,4},"int64"),np.array({1.0,1.0,1.0,1.0,1.0},"float64"), {2,5});check(x,{2,5},{{0,1,2,3,4},{0,1,2,3,4}},"8cb22c02a4d1fa2a",r) end
do local r=np.random.default_rng(1);local x=r:binomial(np.array({0,1,2,3,4},"int64"),np.array({1.0,1.0,1.0,1.0,1.0},"float64"), {0,5});check(x,{0,5},{},"8306bdf37922e4ff",r) end
do local r=np.random.default_rng(1);local x=r:negative_binomial(np.array({0.1,0.5,1.0,2.5,5.0,20.0},"float64"),0.5);check(x,{6},{0,0,0,3,5,28},"46e25789ecc847b9",r) end
do local r=np.random.default_rng(1);local x=r:negative_binomial(np.array({0.1,0.5,1.0,2.5,5.0,20.0},"float64"),0.5, {2,6});check(x,{2,6},{{0,0,0,3,5,28},{0,0,2,0,6,27}},"cd67bcd78e26e09e",r) end
do local r=np.random.default_rng(1);local x=r:negative_binomial(np.array({0.1,0.5,1.0,2.5,5.0,20.0},"float64"),0.5, {0,6});check(x,{0,6},{},"8306bdf37922e4ff",r) end
do local r=np.random.default_rng(1);local x=r:negative_binomial(np.array({{0.1},{0.5},{1.2},{20.0}},"float64"),np.array({{0.01,0.1,0.5,0.95,1.0}},"float64"));check(x,{4,5},{{1,0,0,0,0},{1,9,0,0,0},{44,7,1,0,0},{2054,118,23,0,0}},"d4ce6d74df25a3aa",r) end
do local r=np.random.default_rng(1);local x=r:negative_binomial(np.array({{0.1},{0.5},{1.2},{20.0}},"float64"),np.array({{0.01,0.1,0.5,0.95,1.0}},"float64"), {2,4,5});check(x,{2,4,5},{{{1,0,0,0,0},{1,9,0,0,0},{44,7,1,0,0},{2054,118,23,0,0}},{{13,0,0,0,0},{39,0,0,0,0},{19,47,0,0,0},{1810,122,26,1,0}}},"bbcc959ef81816e4",r) end
do local r=np.random.default_rng(1);local x=r:negative_binomial(np.array({{0.1},{0.5},{1.2},{20.0}},"float64"),np.array({{0.01,0.1,0.5,0.95,1.0}},"float64"), {0,4,5});check(x,{0,4,5},{},"8306bdf37922e4ff",r) end
do local r=np.random.default_rng(1);local x=r:negative_binomial(np.flip(np.array({{1.3,2.8},{3.5,8.5}},"float64"),2),0.4);check(x,{2,2},{{5,3},{6,6}},"46e25789ecc847b9",r) end
do local r=np.random.default_rng(1);local x=r:negative_binomial(np.flip(np.array({{1.3,2.8},{3.5,8.5}},"float64"),2),0.4, {2,2,2});check(x,{2,2,2},{{{5,3},{6,6}},{{2,0},{16,7}}},"d1d30e818b89e43c",r) end
do local r=np.random.default_rng(1);local x=r:negative_binomial(np.flip(np.array({{1.3,2.8},{3.5,8.5}},"float64"),2),0.4, {0,2,2});check(x,{0,2,2},{},"8306bdf37922e4ff",r) end
do local r=np.random.default_rng(1);local x=r:negative_binomial(10.0,np.array({0.001,0.01,0.1,0.5,1.0},"float32"));check(x,{5},{10713,805,83,9,0},"29207d73b9d2f219",r) end
do local r=np.random.default_rng(1);local x=r:negative_binomial(10.0,np.array({0.001,0.01,0.1,0.5,1.0},"float32"), {2,5});check(x,{2,5},{{10713,805,83,9,0},{10340,662,106,11,0}},"82c99d2aac766a40",r) end
do local r=np.random.default_rng(1);local x=r:negative_binomial(10.0,np.array({0.001,0.01,0.1,0.5,1.0},"float32"), {0,5});check(x,{0,5},{},"8306bdf37922e4ff",r) end
do local r=np.random.default_rng(1);local x=r:negative_binomial(np.transpose(np.array({{3.0,20.0},{30.0,40.0}},"float32")),0.12);check(x,{2,2},{{21,199},{139,248}},"3415a484e7642555",r) end
do local r=np.random.default_rng(1);local x=r:negative_binomial(np.transpose(np.array({{3.0,20.0},{30.0,40.0}},"float32")),0.12, {2,2,2});check(x,{2,2,2},{{{21,199},{139,248}},{{14,275},{152,248}}},"0a22c23e6d6462c7",r) end
do local r=np.random.default_rng(1);local x=r:negative_binomial(np.transpose(np.array({{3.0,20.0},{30.0,40.0}},"float32")),0.12, {0,2,2});check(x,{0,2,2},{},"8306bdf37922e4ff",r) end
do local r=np.random.default_rng(1);local x=r:negative_binomial(np.array({0.1,1.2,3.7},"float64"),np.array({0.9,0.5,0.2},"float64"));check(x,{3},{0,3,12},"4d9e2d241fb91945",r) end
do local r=np.random.default_rng(1);local x=r:negative_binomial(np.array({0.1,1.2,3.7},"float64"),np.array({0.9,0.5,0.2},"float64"), {2,3});check(x,{2,3},{{0,3,12},{0,0,14}},"29207d73b9d2f219",r) end
do local r=np.random.default_rng(1);local x=r:negative_binomial(np.array({0.1,1.2,3.7},"float64"),np.array({0.9,0.5,0.2},"float64"), {0,3});check(x,{0,3},{},"8306bdf37922e4ff",r) end
do local r=np.random.default_rng(1);local x=r:negative_binomial(np.array({4,10,100,1000},"int64"),np.array({0.95,0.75,0.5,0.1},"float64"));check(x,{4},{0,3,104,8938},"673269a56220b55d",r) end
do local r=np.random.default_rng(1);local x=r:negative_binomial(np.array({4,10,100,1000},"int64"),np.array({0.95,0.75,0.5,0.1},"float64"), {2,4});check(x,{2,4},{{0,3,104,8938},{0,6,105,9580}},"a42e153875093c21",r) end
do local r=np.random.default_rng(1);local x=r:negative_binomial(np.array({4,10,100,1000},"int64"),np.array({0.95,0.75,0.5,0.1},"float64"), {0,4});check(x,{0,4},{},"8306bdf37922e4ff",r) end
do local r=np.random.default_rng(1);local x=r:negative_binomial(np.array({{10,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2));check(x,{2,2},{{0,9},{107,10}},"9f9d064d6cb28f44",r) end
do local r=np.random.default_rng(1);local x=r:negative_binomial(np.array({{10,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2), {2,2,2});check(x,{2,2,2},{{{0,9},{107,10}},{{0,25},{115,10}}},"daf027ad3851e159",r) end
do local r=np.random.default_rng(1);local x=r:negative_binomial(np.array({{10,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2), {0,2,2});check(x,{0,2,2},{},"8306bdf37922e4ff",r) end
do local r=np.random.default_rng(1);local x=r:negative_binomial(1000.0,np.array({0.01,0.05,0.5,0.999,1.0},"float64"));check(x,{5},{99878,18692,985,0,0},"4326f7928093fdec",r) end
do local r=np.random.default_rng(1);local x=r:negative_binomial(1000.0,np.array({0.01,0.05,0.5,0.999,1.0},"float64"), {2,5});check(x,{2,5},{{99878,18692,985,0,0},{97959,19699,943,1,0}},"0ff6245b5e3a7203",r) end
do local r=np.random.default_rng(1);local x=r:negative_binomial(1000.0,np.array({0.01,0.05,0.5,0.999,1.0},"float64"), {0,5});check(x,{0,5},{},"8306bdf37922e4ff",r) end
do local r=np.random.default_rng(1);local x=r:negative_binomial(np.array(6.0,"float64"),np.array(0.23,"float64"));check(x,{},19,"d3e4513345ee6d24",r) end
do local r=np.random.default_rng(1);local x=r:negative_binomial(np.array(6.0,"float64"),np.array(0.23,"float64"), {2});check(x,{2},{19,16},"c0e63c2edd973235",r) end
do local r=np.random.default_rng(1);local x=r:negative_binomial(np.array(6.0,"float64"),np.array(0.23,"float64"), {0});check(x,{0},{},"8306bdf37922e4ff",r) end
do local r=np.random.default_rng(1);local x=r:negative_binomial(30.0,0.5);check(x,{},28,"d3e4513345ee6d24",r) end
do local r=np.random.default_rng(1);local x=r:negative_binomial(30.0,0.5, {2});check(x,{2},{28,28},"c0e63c2edd973235",r) end
do local r=np.random.default_rng(1);local x=r:negative_binomial(30.0,0.5, {0});check(x,{0},{},"8306bdf37922e4ff",r) end
do local r=np.random.default_rng(1);local x=r:negative_binomial(np.array({0.5,1.0,2.0,4.0},"float64"),np.array({1.0,1.0,1.0,1.0},"float64"));check(x,{4},{0,0,0,0},"8cb22c02a4d1fa2a",r) end
do local r=np.random.default_rng(1);local x=r:negative_binomial(np.array({0.5,1.0,2.0,4.0},"float64"),np.array({1.0,1.0,1.0,1.0},"float64"), {2,4});check(x,{2,4},{{0,0,0,0},{0,0,0,0}},"673269a56220b55d",r) end
do local r=np.random.default_rng(1);local x=r:negative_binomial(np.array({0.5,1.0,2.0,4.0},"float64"),np.array({1.0,1.0,1.0,1.0},"float64"), {0,4});check(x,{0,4},{},"8306bdf37922e4ff",r) end
do local r=np.random.default_rng(2);local x=r:binomial(np.array({0,1,2,10,100,1000},"int64"),0.4);check(x,{6},{0,0,0,5,37,379},"0e1e16e0e1569e9f",r) end
do local r=np.random.default_rng(2);local x=r:binomial(np.array({0,1,2,10,100,1000},"int64"),0.4, {2,6});check(x,{2,6},{{0,0,0,5,37,379},{0,0,0,5,38,399}},"6c3b9dc8f1fb8a4d",r) end
do local r=np.random.default_rng(2);local x=r:binomial(np.array({0,1,2,10,100,1000},"int64"),0.4, {0,6});check(x,{0,6},{},"42f90348d66b58c1",r) end
do local r=np.random.default_rng(2);local x=r:binomial(np.array({{0},{1},{10},{50}},"int64"),np.array({{0.0,0.01,0.5,0.99,1.0}},"float64"));check(x,{4,5},{{0,0,0,0,0},{0,0,0,1,1},{0,0,6,10,10},{0,0,26,50,50}},"6ec0e439bfca2d16",r) end
do local r=np.random.default_rng(2);local x=r:binomial(np.array({{0},{1},{10},{50}},"int64"),np.array({{0.0,0.01,0.5,0.99,1.0}},"float64"), {2,4,5});check(x,{2,4,5},{{{0,0,0,0,0},{0,0,0,1,1},{0,0,6,10,10},{0,0,26,50,50}},{{0,0,0,0,0},{0,0,1,1,1},{0,1,6,10,10},{0,0,25,49,50}}},"51720e3cfa02e5ac",r) end
do local r=np.random.default_rng(2);local x=r:binomial(np.array({{0},{1},{10},{50}},"int64"),np.array({{0.0,0.01,0.5,0.99,1.0}},"float64"), {0,4,5});check(x,{0,4,5},{},"42f90348d66b58c1",r) end
do local r=np.random.default_rng(2);local x=r:binomial(np.flip(np.array({{4,9,13},{20,30,50}},"int64"),2),0.3);check(x,{2,3},{{3,2,2},{11,10,7}},"301a48e4fe2bfb11",r) end
do local r=np.random.default_rng(2);local x=r:binomial(np.flip(np.array({{4,9,13},{20,30,50}},"int64"),2),0.3, {2,2,3});check(x,{2,2,3},{{{3,2,2},{11,10,7}},{{2,1,1},{16,9,4}}},"6ec0e439bfca2d16",r) end
do local r=np.random.default_rng(2);local x=r:binomial(np.flip(np.array({{4,9,13},{20,30,50}},"int64"),2),0.3, {0,2,3});check(x,{0,2,3},{},"42f90348d66b58c1",r) end
do local r=np.random.default_rng(2);local x=r:binomial(100,np.array({0.0,0.1,0.5,0.9,1.0},"float32"));check(x,{5},{0,8,49,94,100},"ba82f153d02d2c69",r) end
do local r=np.random.default_rng(2);local x=r:binomial(100,np.array({0.0,0.1,0.5,0.9,1.0},"float32"), {2,5});check(x,{2,5},{{0,8,49,94,100},{0,12,53,92,100}},"8ff0a4794e428eb9",r) end
do local r=np.random.default_rng(2);local x=r:binomial(100,np.array({0.0,0.1,0.5,0.9,1.0},"float32"), {0,5});check(x,{0,5},{},"42f90348d66b58c1",r) end
do local r=np.random.default_rng(2);local x=r:binomial(np.transpose(np.array({{10,20},{30,40}},"int64")),0.12);check(x,{2,2},{{0,3},{4,2}},"99a0302555bae4d5",r) end
do local r=np.random.default_rng(2);local x=r:binomial(np.transpose(np.array({{10,20},{30,40}},"int64")),0.12, {2,2,2});check(x,{2,2,2},{{{0,3},{4,2}},{{1,5},{1,2}}},"4664647a8ee7e46d",r) end
do local r=np.random.default_rng(2);local x=r:binomial(np.transpose(np.array({{10,20},{30,40}},"int64")),0.12, {0,2,2});check(x,{0,2,2},{},"42f90348d66b58c1",r) end
do local r=np.random.default_rng(2);local x=r:binomial(np.array({3,13,25},"int64"),np.array({0.15,0.5,0.95},"float64"));check(x,{3},{0,6,23},"1787cd9d73866ffd",r) end
do local r=np.random.default_rng(2);local x=r:binomial(np.array({3,13,25},"int64"),np.array({0.15,0.5,0.95},"float64"), {2,3});check(x,{2,3},{{0,6,23},{0,7,23}},"301a48e4fe2bfb11",r) end
do local r=np.random.default_rng(2);local x=r:binomial(np.array({3,13,25},"int64"),np.array({0.15,0.5,0.95},"float64"), {0,3});check(x,{0,3},{},"42f90348d66b58c1",r) end
do local r=np.random.default_rng(2);local x=r:binomial(np.array({4,100,1000,100000},"int64"),np.array({0.05,0.75,0.5,0.001},"float64"));check(x,{4},{0,77,498,105},"4664647a8ee7e46d",r) end
do local r=np.random.default_rng(2);local x=r:binomial(np.array({4,100,1000,100000},"int64"),np.array({0.05,0.75,0.5,0.001},"float64"), {2,4});check(x,{2,4},{{0,77,498,105},{0,73,521,102}},"6c3b9dc8f1fb8a4d",r) end
do local r=np.random.default_rng(2);local x=r:binomial(np.array({4,100,1000,100000},"int64"),np.array({0.05,0.75,0.5,0.001},"float64"), {0,4});check(x,{0,4},{},"42f90348d66b58c1",r) end
do local r=np.random.default_rng(2);local x=r:binomial(np.array({{100,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2));check(x,{2,2},{{100,0},{19,22}},"99a0302555bae4d5",r) end
do local r=np.random.default_rng(2);local x=r:binomial(np.array({{100,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2), {2,2,2});check(x,{2,2,2},{{{100,0},{19,22}},{{99,1},{14,22}}},"4664647a8ee7e46d",r) end
do local r=np.random.default_rng(2);local x=r:binomial(np.array({{100,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2), {0,2,2});check(x,{0,2,2},{},"42f90348d66b58c1",r) end
do local r=np.random.default_rng(2);local x=r:binomial(1000000000000,np.array({1e-08,0.0001,0.5,0.9999,1.0},"float64"));check(x,{5},{10011,99990788,500000072158,999899995752,1000000000000},"a84d87b2338bc9cb",r) end
do local r=np.random.default_rng(2);local x=r:binomial(1000000000000,np.array({1e-08,0.0001,0.5,0.9999,1.0},"float64"), {2,5});check(x,{2,5},{{10011,99990788,500000072158,999899995752,1000000000000},{10067,99994865,500000508266,999900002838,1000000000000}},"6441866a6152e82e",r) end
do local r=np.random.default_rng(2);local x=r:binomial(1000000000000,np.array({1e-08,0.0001,0.5,0.9999,1.0},"float64"), {0,5});check(x,{0,5},{},"42f90348d66b58c1",r) end
do local r=np.random.default_rng(2);local x=r:binomial(np.array(6,"int64"),np.array(0.23,"float64"));check(x,{},1,"4c69ea631bfb7164",r) end
do local r=np.random.default_rng(2);local x=r:binomial(np.array(6,"int64"),np.array(0.23,"float64"), {2});check(x,{2},{1,1},"d071191f69efb11e",r) end
do local r=np.random.default_rng(2);local x=r:binomial(np.array(6,"int64"),np.array(0.23,"float64"), {0});check(x,{0},{},"42f90348d66b58c1",r) end
do local r=np.random.default_rng(2);local x=r:binomial(30,0.5);check(x,{},13,"4c69ea631bfb7164",r) end
do local r=np.random.default_rng(2);local x=r:binomial(30,0.5, {2});check(x,{2},{13,14},"d071191f69efb11e",r) end
do local r=np.random.default_rng(2);local x=r:binomial(30,0.5, {0});check(x,{0},{},"42f90348d66b58c1",r) end
do local r=np.random.default_rng(2);local x=r:binomial(0,np.array({0.0,0.4,1.0},"float64"));check(x,{3},{0,0,0},"42f90348d66b58c1",r) end
do local r=np.random.default_rng(2);local x=r:binomial(0,np.array({0.0,0.4,1.0},"float64"), {2,3});check(x,{2,3},{{0,0,0},{0,0,0}},"42f90348d66b58c1",r) end
do local r=np.random.default_rng(2);local x=r:binomial(0,np.array({0.0,0.4,1.0},"float64"), {0,3});check(x,{0,3},{},"42f90348d66b58c1",r) end
do local r=np.random.default_rng(2);local x=r:binomial(np.array({0,1,2,3,4},"int64"),np.array({1.0,1.0,1.0,1.0,1.0},"float64"));check(x,{5},{0,1,2,3,4},"99a0302555bae4d5",r) end
do local r=np.random.default_rng(2);local x=r:binomial(np.array({0,1,2,3,4},"int64"),np.array({1.0,1.0,1.0,1.0,1.0},"float64"), {2,5});check(x,{2,5},{{0,1,2,3,4},{0,1,2,3,4}},"4664647a8ee7e46d",r) end
do local r=np.random.default_rng(2);local x=r:binomial(np.array({0,1,2,3,4},"int64"),np.array({1.0,1.0,1.0,1.0,1.0},"float64"), {0,5});check(x,{0,5},{},"42f90348d66b58c1",r) end
do local r=np.random.default_rng(2);local x=r:negative_binomial(np.array({0.1,0.5,1.0,2.5,5.0,20.0},"float64"),0.5);check(x,{6},{0,0,0,2,4,21},"788d8cdd394a0cef",r) end
do local r=np.random.default_rng(2);local x=r:negative_binomial(np.array({0.1,0.5,1.0,2.5,5.0,20.0},"float64"),0.5, {2,6});check(x,{2,6},{{0,0,0,2,4,21},{0,0,2,5,2,24}},"d5ce910652627ea3",r) end
do local r=np.random.default_rng(2);local x=r:negative_binomial(np.array({0.1,0.5,1.0,2.5,5.0,20.0},"float64"),0.5, {0,6});check(x,{0,6},{},"42f90348d66b58c1",r) end
do local r=np.random.default_rng(2);local x=r:negative_binomial(np.array({{0.1},{0.5},{1.2},{20.0}},"float64"),np.array({{0.01,0.1,0.5,0.95,1.0}},"float64"));check(x,{4,5},{{0,0,0,0,0},{16,2,1,0,0},{107,4,1,0,0},{1997,152,24,1,0}},"93103c850e13ef55",r) end
do local r=np.random.default_rng(2);local x=r:negative_binomial(np.array({{0.1},{0.5},{1.2},{20.0}},"float64"),np.array({{0.01,0.1,0.5,0.95,1.0}},"float64"), {2,4,5});check(x,{2,4,5},{{{0,0,0,0,0},{16,2,1,0,0},{107,4,1,0,0},{1997,152,24,1,0}},{{0,6,0,0,0},{0,0,0,0,0},{43,2,0,0,0},{2363,162,22,0,0}}},"abc0629bd2fc21e9",r) end
do local r=np.random.default_rng(2);local x=r:negative_binomial(np.array({{0.1},{0.5},{1.2},{20.0}},"float64"),np.array({{0.01,0.1,0.5,0.95,1.0}},"float64"), {0,4,5});check(x,{0,4,5},{},"42f90348d66b58c1",r) end
do local r=np.random.default_rng(2);local x=r:negative_binomial(np.flip(np.array({{1.3,2.8},{3.5,8.5}},"float64"),2),0.4);check(x,{2,2},{{4,3},{13,4}},"843e77f197f6315a",r) end
do local r=np.random.default_rng(2);local x=r:negative_binomial(np.flip(np.array({{1.3,2.8},{3.5,8.5}},"float64"),2),0.4, {2,2,2});check(x,{2,2,2},{{{4,3},{13,4}},{{7,0},{17,8}}},"0518deef1878f512",r) end
do local r=np.random.default_rng(2);local x=r:negative_binomial(np.flip(np.array({{1.3,2.8},{3.5,8.5}},"float64"),2),0.4, {0,2,2});check(x,{0,2,2},{},"42f90348d66b58c1",r) end
do local r=np.random.default_rng(2);local x=r:negative_binomial(10.0,np.array({0.001,0.01,0.1,0.5,1.0},"float32"));check(x,{5},{10358,1584,97,13,0},"33b034dbf5340a67",r) end
do local r=np.random.default_rng(2);local x=r:negative_binomial(10.0,np.array({0.001,0.01,0.1,0.5,1.0},"float32"), {2,5});check(x,{2,5},{{10358,1584,97,13,0},{12572,1025,70,5,0}},"e5d1e7b244843a22",r) end
do local r=np.random.default_rng(2);local x=r:negative_binomial(10.0,np.array({0.001,0.01,0.1,0.5,1.0},"float32"), {0,5});check(x,{0,5},{},"42f90348d66b58c1",r) end
do local r=np.random.default_rng(2);local x=r:negative_binomial(np.transpose(np.array({{3.0,20.0},{30.0,40.0}},"float32")),0.12);check(x,{2,2},{{27,280},{156,272}},"f7a9e1f0ef58f418",r) end
do local r=np.random.default_rng(2);local x=r:negative_binomial(np.transpose(np.array({{3.0,20.0},{30.0,40.0}},"float32")),0.12, {2,2,2});check(x,{2,2,2},{{{27,280},{156,272}},{{25,276},{113,204}}},"ae081fba85b234e4",r) end
do local r=np.random.default_rng(2);local x=r:negative_binomial(np.transpose(np.array({{3.0,20.0},{30.0,40.0}},"float32")),0.12, {0,2,2});check(x,{0,2,2},{},"42f90348d66b58c1",r) end
do local r=np.random.default_rng(2);local x=r:negative_binomial(np.array({0.1,1.2,3.7},"float64"),np.array({0.9,0.5,0.2},"float64"));check(x,{3},{0,0,16},"6ec0e439bfca2d16",r) end
do local r=np.random.default_rng(2);local x=r:negative_binomial(np.array({0.1,1.2,3.7},"float64"),np.array({0.9,0.5,0.2},"float64"), {2,3});check(x,{2,3},{{0,0,16},{0,1,9}},"e26b4b3772f7b898",r) end
do local r=np.random.default_rng(2);local x=r:negative_binomial(np.array({0.1,1.2,3.7},"float64"),np.array({0.9,0.5,0.2},"float64"), {0,3});check(x,{0,3},{},"42f90348d66b58c1",r) end
do local r=np.random.default_rng(2);local x=r:negative_binomial(np.array({4,10,100,1000},"int64"),np.array({0.95,0.75,0.5,0.1},"float64"));check(x,{4},{1,2,83,8809},"aedd5610de2e2f5e",r) end
do local r=np.random.default_rng(2);local x=r:negative_binomial(np.array({4,10,100,1000},"int64"),np.array({0.95,0.75,0.5,0.1},"float64"), {2,4});check(x,{2,4},{{1,2,83,8809},{0,6,98,9179}},"97ebea14c8e97c49",r) end
do local r=np.random.default_rng(2);local x=r:negative_binomial(np.array({4,10,100,1000},"int64"),np.array({0.95,0.75,0.5,0.1},"float64"), {0,4});check(x,{0,4},{},"42f90348d66b58c1",r) end
do local r=np.random.default_rng(2);local x=r:negative_binomial(np.array({{10,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2));check(x,{2,2},{{0,2},{107,12}},"b19a2df291c463f8",r) end
do local r=np.random.default_rng(2);local x=r:negative_binomial(np.array({{10,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2), {2,2,2});check(x,{2,2,2},{{{0,2},{107,12}},{{0,29},{111,7}}},"b3b2f5fc85ab9295",r) end
do local r=np.random.default_rng(2);local x=r:negative_binomial(np.array({{10,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2), {0,2,2});check(x,{0,2,2},{},"42f90348d66b58c1",r) end
do local r=np.random.default_rng(2);local x=r:negative_binomial(1000.0,np.array({0.01,0.05,0.5,0.999,1.0},"float64"));check(x,{5},{99878,19954,1014,1,0},"6441866a6152e82e",r) end
do local r=np.random.default_rng(2);local x=r:negative_binomial(1000.0,np.array({0.01,0.05,0.5,0.999,1.0},"float64"), {2,5});check(x,{2,5},{{99878,19954,1014,1,0},{99224,19119,1018,3,0}},"dcb3c3a678c05757",r) end
do local r=np.random.default_rng(2);local x=r:negative_binomial(1000.0,np.array({0.01,0.05,0.5,0.999,1.0},"float64"), {0,5});check(x,{0,5},{},"42f90348d66b58c1",r) end
do local r=np.random.default_rng(2);local x=r:negative_binomial(np.array(6.0,"float64"),np.array(0.23,"float64"));check(x,{},25,"99a0302555bae4d5",r) end
do local r=np.random.default_rng(2);local x=r:negative_binomial(np.array(6.0,"float64"),np.array(0.23,"float64"), {2});check(x,{2},{25,31},"4664647a8ee7e46d",r) end
do local r=np.random.default_rng(2);local x=r:negative_binomial(np.array(6.0,"float64"),np.array(0.23,"float64"), {0});check(x,{0},{},"42f90348d66b58c1",r) end
do local r=np.random.default_rng(2);local x=r:negative_binomial(30.0,0.5);check(x,{},36,"99a0302555bae4d5",r) end
do local r=np.random.default_rng(2);local x=r:negative_binomial(30.0,0.5, {2});check(x,{2},{36,34},"4664647a8ee7e46d",r) end
do local r=np.random.default_rng(2);local x=r:negative_binomial(30.0,0.5, {0});check(x,{0},{},"42f90348d66b58c1",r) end
do local r=np.random.default_rng(2);local x=r:negative_binomial(np.array({0.5,1.0,2.0,4.0},"float64"),np.array({1.0,1.0,1.0,1.0},"float64"));check(x,{4},{0,0,0,0},"0e1e16e0e1569e9f",r) end
do local r=np.random.default_rng(2);local x=r:negative_binomial(np.array({0.5,1.0,2.0,4.0},"float64"),np.array({1.0,1.0,1.0,1.0},"float64"), {2,4});check(x,{2,4},{{0,0,0,0},{0,0,0,0}},"6c3b9dc8f1fb8a4d",r) end
do local r=np.random.default_rng(2);local x=r:negative_binomial(np.array({0.5,1.0,2.0,4.0},"float64"),np.array({1.0,1.0,1.0,1.0},"float64"), {0,4});check(x,{0,4},{},"42f90348d66b58c1",r) end
do local r=np.random.default_rng(3);local x=r:binomial(np.array({0,1,2,10,100,1000},"int64"),0.4);check(x,{6},{0,0,0,5,39,405},"28e4a64643c92921",r) end
do local r=np.random.default_rng(3);local x=r:binomial(np.array({0,1,2,10,100,1000},"int64"),0.4, {2,6});check(x,{2,6},{{0,0,0,5,39,405},{0,0,1,2,43,401}},"bce2efee2c3ec14a",r) end
do local r=np.random.default_rng(3);local x=r:binomial(np.array({0,1,2,10,100,1000},"int64"),0.4, {0,6});check(x,{0,6},{},"15ed1a93cfbec2f8",r) end
do local r=np.random.default_rng(3);local x=r:binomial(np.array({{0},{1},{10},{50}},"int64"),np.array({{0.0,0.01,0.5,0.99,1.0}},"float64"));check(x,{4,5},{{0,0,0,0,0},{0,0,0,1,1},{0,0,5,10,10},{0,1,21,50,50}},"6e3da3506b8c9910",r) end
do local r=np.random.default_rng(3);local x=r:binomial(np.array({{0},{1},{10},{50}},"int64"),np.array({{0.0,0.01,0.5,0.99,1.0}},"float64"), {2,4,5});check(x,{2,4,5},{{{0,0,0,0,0},{0,0,0,1,1},{0,0,5,10,10},{0,1,21,50,50}},{{0,0,0,0,0},{0,0,1,1,1},{0,0,6,10,10},{0,0,32,50,50}}},"e4472d3d0b08c167",r) end
do local r=np.random.default_rng(3);local x=r:binomial(np.array({{0},{1},{10},{50}},"int64"),np.array({{0.0,0.01,0.5,0.99,1.0}},"float64"), {0,4,5});check(x,{0,4,5},{},"15ed1a93cfbec2f8",r) end
do local r=np.random.default_rng(3);local x=r:binomial(np.flip(np.array({{4,9,13},{20,30,50}},"int64"),2),0.3);check(x,{2,3},{{2,2,2},{16,6,6}},"7aa31b1a9f08c9e2",r) end
do local r=np.random.default_rng(3);local x=r:binomial(np.flip(np.array({{4,9,13},{20,30,50}},"int64"),2),0.3, {2,2,3});check(x,{2,2,3},{{{2,2,2},{16,6,6}},{{4,1,2},{11,8,6}}},"6e3da3506b8c9910",r) end
do local r=np.random.default_rng(3);local x=r:binomial(np.flip(np.array({{4,9,13},{20,30,50}},"int64"),2),0.3, {0,2,3});check(x,{0,2,3},{},"15ed1a93cfbec2f8",r) end
do local r=np.random.default_rng(3);local x=r:binomial(100,np.array({0.0,0.1,0.5,0.9,1.0},"float32"));check(x,{5},{0,6,48,90,100},"6ee1683b550b2907",r) end
do local r=np.random.default_rng(3);local x=r:binomial(100,np.array({0.0,0.1,0.5,0.9,1.0},"float32"), {2,5});check(x,{2,5},{{0,6,48,90,100},{0,9,43,88,100}},"642787db73be929d",r) end
do local r=np.random.default_rng(3);local x=r:binomial(100,np.array({0.0,0.1,0.5,0.9,1.0},"float32"), {0,5});check(x,{0,5},{},"15ed1a93cfbec2f8",r) end
do local r=np.random.default_rng(3);local x=r:binomial(np.transpose(np.array({{10,20},{30,40}},"int64")),0.12);check(x,{2,2},{{0,2},{4,5}},"1818d0900a160f0e",r) end
do local r=np.random.default_rng(3);local x=r:binomial(np.transpose(np.array({{10,20},{30,40}},"int64")),0.12, {2,2,2});check(x,{2,2,2},{{{0,2},{4,5}},{{0,3},{2,3}}},"bc0d3f89b100b332",r) end
do local r=np.random.default_rng(3);local x=r:binomial(np.transpose(np.array({{10,20},{30,40}},"int64")),0.12, {0,2,2});check(x,{0,2,2},{},"15ed1a93cfbec2f8",r) end
do local r=np.random.default_rng(3);local x=r:binomial(np.array({3,13,25},"int64"),np.array({0.15,0.5,0.95},"float64"));check(x,{3},{0,5,23},"95089239de860724",r) end
do local r=np.random.default_rng(3);local x=r:binomial(np.array({3,13,25},"int64"),np.array({0.15,0.5,0.95},"float64"), {2,3});check(x,{2,3},{{0,5,23},{0,4,24}},"7aa31b1a9f08c9e2",r) end
do local r=np.random.default_rng(3);local x=r:binomial(np.array({3,13,25},"int64"),np.array({0.15,0.5,0.95},"float64"), {0,3});check(x,{0,3},{},"15ed1a93cfbec2f8",r) end
do local r=np.random.default_rng(3);local x=r:binomial(np.array({4,100,1000,100000},"int64"),np.array({0.05,0.75,0.5,0.001},"float64"));check(x,{4},{0,78,495,95},"7aa31b1a9f08c9e2",r) end
do local r=np.random.default_rng(3);local x=r:binomial(np.array({4,100,1000,100000},"int64"),np.array({0.05,0.75,0.5,0.001},"float64"), {2,4});check(x,{2,4},{{0,78,495,95},{0,79,477,103}},"6e3da3506b8c9910",r) end
do local r=np.random.default_rng(3);local x=r:binomial(np.array({4,100,1000,100000},"int64"),np.array({0.05,0.75,0.5,0.001},"float64"), {0,4});check(x,{0,4},{},"15ed1a93cfbec2f8",r) end
do local r=np.random.default_rng(3);local x=r:binomial(np.array({{100,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2));check(x,{2,2},{{100,0},{19,18}},"1818d0900a160f0e",r) end
do local r=np.random.default_rng(3);local x=r:binomial(np.array({{100,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2), {2,2,2});check(x,{2,2,2},{{{100,0},{19,18}},{{100,1},{16,21}}},"bc0d3f89b100b332",r) end
do local r=np.random.default_rng(3);local x=r:binomial(np.array({{100,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2), {0,2,2});check(x,{0,2,2},{},"15ed1a93cfbec2f8",r) end
do local r=np.random.default_rng(3);local x=r:binomial(1000000000000,np.array({1e-08,0.0001,0.5,0.9999,1.0},"float64"));check(x,{5},{9974,99993229,500000520593,999899981157,1000000000000},"844915a8e3487fed",r) end
do local r=np.random.default_rng(3);local x=r:binomial(1000000000000,np.array({1e-08,0.0001,0.5,0.9999,1.0},"float64"), {2,5});check(x,{2,5},{{9974,99993229,500000520593,999899981157,1000000000000},{10055,100000853,500001078979,999899996440,1000000000000}},"0061a773f0529ac1",r) end
do local r=np.random.default_rng(3);local x=r:binomial(1000000000000,np.array({1e-08,0.0001,0.5,0.9999,1.0},"float64"), {0,5});check(x,{0,5},{},"15ed1a93cfbec2f8",r) end
do local r=np.random.default_rng(3);local x=r:binomial(np.array(6,"int64"),np.array(0.23,"float64"));check(x,{},0,"3c9f9d052defd3f5",r) end
do local r=np.random.default_rng(3);local x=r:binomial(np.array(6,"int64"),np.array(0.23,"float64"), {2});check(x,{2},{0,1},"cd2052c72e6dec36",r) end
do local r=np.random.default_rng(3);local x=r:binomial(np.array(6,"int64"),np.array(0.23,"float64"), {0});check(x,{0},{},"15ed1a93cfbec2f8",r) end
do local r=np.random.default_rng(3);local x=r:binomial(30,0.5);check(x,{},11,"3c9f9d052defd3f5",r) end
do local r=np.random.default_rng(3);local x=r:binomial(30,0.5, {2});check(x,{2},{11,13},"cd2052c72e6dec36",r) end
do local r=np.random.default_rng(3);local x=r:binomial(30,0.5, {0});check(x,{0},{},"15ed1a93cfbec2f8",r) end
do local r=np.random.default_rng(3);local x=r:binomial(0,np.array({0.0,0.4,1.0},"float64"));check(x,{3},{0,0,0},"15ed1a93cfbec2f8",r) end
do local r=np.random.default_rng(3);local x=r:binomial(0,np.array({0.0,0.4,1.0},"float64"), {2,3});check(x,{2,3},{{0,0,0},{0,0,0}},"15ed1a93cfbec2f8",r) end
do local r=np.random.default_rng(3);local x=r:binomial(0,np.array({0.0,0.4,1.0},"float64"), {0,3});check(x,{0,3},{},"15ed1a93cfbec2f8",r) end
do local r=np.random.default_rng(3);local x=r:binomial(np.array({0,1,2,3,4},"int64"),np.array({1.0,1.0,1.0,1.0,1.0},"float64"));check(x,{5},{0,1,2,3,4},"1818d0900a160f0e",r) end
do local r=np.random.default_rng(3);local x=r:binomial(np.array({0,1,2,3,4},"int64"),np.array({1.0,1.0,1.0,1.0,1.0},"float64"), {2,5});check(x,{2,5},{{0,1,2,3,4},{0,1,2,3,4}},"bc0d3f89b100b332",r) end
do local r=np.random.default_rng(3);local x=r:binomial(np.array({0,1,2,3,4},"int64"),np.array({1.0,1.0,1.0,1.0,1.0},"float64"), {0,5});check(x,{0,5},{},"15ed1a93cfbec2f8",r) end
do local r=np.random.default_rng(3);local x=r:negative_binomial(np.array({0.1,0.5,1.0,2.5,5.0,20.0},"float64"),0.5);check(x,{6},{0,0,0,1,6,24},"95cd3d09a9a45a1d",r) end
do local r=np.random.default_rng(3);local x=r:negative_binomial(np.array({0.1,0.5,1.0,2.5,5.0,20.0},"float64"),0.5, {2,6});check(x,{2,6},{{0,0,0,1,6,24},{0,0,0,4,5,23}},"b2cc11a6366bc786",r) end
do local r=np.random.default_rng(3);local x=r:negative_binomial(np.array({0.1,0.5,1.0,2.5,5.0,20.0},"float64"),0.5, {0,6});check(x,{0,6},{},"15ed1a93cfbec2f8",r) end
do local r=np.random.default_rng(3);local x=r:negative_binomial(np.array({{0.1},{0.5},{1.2},{20.0}},"float64"),np.array({{0.01,0.1,0.5,0.95,1.0}},"float64"));check(x,{4,5},{{0,0,0,0,0},{62,0,0,0,0},{34,13,0,0,0},{2302,130,25,1,0}},"318b060944b34411",r) end
do local r=np.random.default_rng(3);local x=r:negative_binomial(np.array({{0.1},{0.5},{1.2},{20.0}},"float64"),np.array({{0.01,0.1,0.5,0.95,1.0}},"float64"), {2,4,5});check(x,{2,4,5},{{{0,0,0,0,0},{62,0,0,0,0},{34,13,0,0,0},{2302,130,25,1,0}},{{0,0,0,0,0},{15,2,0,0,0},{141,29,5,0,0},{2748,148,20,0,0}}},"56f82d425dabff8e",r) end
do local r=np.random.default_rng(3);local x=r:negative_binomial(np.array({{0.1},{0.5},{1.2},{20.0}},"float64"),np.array({{0.01,0.1,0.5,0.95,1.0}},"float64"), {0,4,5});check(x,{0,4,5},{},"15ed1a93cfbec2f8",r) end
do local r=np.random.default_rng(3);local x=r:negative_binomial(np.flip(np.array({{1.3,2.8},{3.5,8.5}},"float64"),2),0.4);check(x,{2,2},{{14,1},{10,11}},"c5f57b6b30ba5173",r) end
do local r=np.random.default_rng(3);local x=r:negative_binomial(np.flip(np.array({{1.3,2.8},{3.5,8.5}},"float64"),2),0.4, {2,2,2});check(x,{2,2,2},{{{14,1},{10,11}},{{2,0},{15,6}}},"d98a6af297ea862c",r) end
do local r=np.random.default_rng(3);local x=r:negative_binomial(np.flip(np.array({{1.3,2.8},{3.5,8.5}},"float64"),2),0.4, {0,2,2});check(x,{0,2,2},{},"15ed1a93cfbec2f8",r) end
do local r=np.random.default_rng(3);local x=r:negative_binomial(10.0,np.array({0.001,0.01,0.1,0.5,1.0},"float32"));check(x,{5},{17610,823,62,6,0},"506162fa23a6f732",r) end
do local r=np.random.default_rng(3);local x=r:negative_binomial(10.0,np.array({0.001,0.01,0.1,0.5,1.0},"float32"), {2,5});check(x,{2,5},{{17610,823,62,6,0},{8193,895,78,14,0}},"df02f9aea0f32c0e",r) end
do local r=np.random.default_rng(3);local x=r:negative_binomial(10.0,np.array({0.001,0.01,0.1,0.5,1.0},"float32"), {0,5});check(x,{0,5},{},"15ed1a93cfbec2f8",r) end
do local r=np.random.default_rng(3);local x=r:negative_binomial(np.transpose(np.array({{3.0,20.0},{30.0,40.0}},"float32")),0.12);check(x,{2,2},{{63,199},{114,267}},"b23b3628a67e2895",r) end
do local r=np.random.default_rng(3);local x=r:negative_binomial(np.transpose(np.array({{3.0,20.0},{30.0,40.0}},"float32")),0.12, {2,2,2});check(x,{2,2,2},{{{63,199},{114,267}},{{30,209},{132,262}}},"4c546a933f77d89d",r) end
do local r=np.random.default_rng(3);local x=r:negative_binomial(np.transpose(np.array({{3.0,20.0},{30.0,40.0}},"float32")),0.12, {0,2,2});check(x,{0,2,2},{},"15ed1a93cfbec2f8",r) end
do local r=np.random.default_rng(3);local x=r:negative_binomial(np.array({0.1,1.2,3.7},"float64"),np.array({0.9,0.5,0.2},"float64"));check(x,{3},{0,0,2},"844915a8e3487fed",r) end
do local r=np.random.default_rng(3);local x=r:negative_binomial(np.array({0.1,1.2,3.7},"float64"),np.array({0.9,0.5,0.2},"float64"), {2,3});check(x,{2,3},{{0,0,2},{0,0,9}},"f934b14c13b0d2b9",r) end
do local r=np.random.default_rng(3);local x=r:negative_binomial(np.array({0.1,1.2,3.7},"float64"),np.array({0.9,0.5,0.2},"float64"), {0,3});check(x,{0,3},{},"15ed1a93cfbec2f8",r) end
do local r=np.random.default_rng(3);local x=r:negative_binomial(np.array({4,10,100,1000},"int64"),np.array({0.95,0.75,0.5,0.1},"float64"));check(x,{4},{1,2,137,9039},"a607309451eac558",r) end
do local r=np.random.default_rng(3);local x=r:negative_binomial(np.array({4,10,100,1000},"int64"),np.array({0.95,0.75,0.5,0.1},"float64"), {2,4});check(x,{2,4},{{1,2,137,9039},{0,4,103,8905}},"a14d97619bb002d5",r) end
do local r=np.random.default_rng(3);local x=r:negative_binomial(np.array({4,10,100,1000},"int64"),np.array({0.95,0.75,0.5,0.1},"float64"), {0,4});check(x,{0,4},{},"15ed1a93cfbec2f8",r) end
do local r=np.random.default_rng(3);local x=r:negative_binomial(np.array({{10,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2));check(x,{2,2},{{0,13},{83,7}},"f934b14c13b0d2b9",r) end
do local r=np.random.default_rng(3);local x=r:negative_binomial(np.array({{10,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2), {2,2,2});check(x,{2,2,2},{{{0,13},{83,7}},{{0,17},{94,12}}},"1a31a36e62740c9a",r) end
do local r=np.random.default_rng(3);local x=r:negative_binomial(np.array({{10,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2), {0,2,2});check(x,{0,2,2},{},"15ed1a93cfbec2f8",r) end
do local r=np.random.default_rng(3);local x=r:negative_binomial(1000.0,np.array({0.01,0.05,0.5,0.999,1.0},"float64"));check(x,{5},{105803,18715,963,2,0},"4aefbf3bde87990d",r) end
do local r=np.random.default_rng(3);local x=r:negative_binomial(1000.0,np.array({0.01,0.05,0.5,0.999,1.0},"float64"), {2,5});check(x,{2,5},{{105803,18715,963,2,0},{98172,19437,980,1,0}},"37fdbbeba75d875a",r) end
do local r=np.random.default_rng(3);local x=r:negative_binomial(1000.0,np.array({0.01,0.05,0.5,0.999,1.0},"float64"), {0,5});check(x,{0,5},{},"15ed1a93cfbec2f8",r) end
do local r=np.random.default_rng(3);local x=r:negative_binomial(np.array(6.0,"float64"),np.array(0.23,"float64"));check(x,{},46,"1818d0900a160f0e",r) end
do local r=np.random.default_rng(3);local x=r:negative_binomial(np.array(6.0,"float64"),np.array(0.23,"float64"), {2});check(x,{2},{46,15},"bc0d3f89b100b332",r) end
do local r=np.random.default_rng(3);local x=r:negative_binomial(np.array(6.0,"float64"),np.array(0.23,"float64"), {0});check(x,{0},{},"15ed1a93cfbec2f8",r) end
do local r=np.random.default_rng(3);local x=r:negative_binomial(30.0,0.5);check(x,{},49,"1818d0900a160f0e",r) end
do local r=np.random.default_rng(3);local x=r:negative_binomial(30.0,0.5, {2});check(x,{2},{49,27},"bc0d3f89b100b332",r) end
do local r=np.random.default_rng(3);local x=r:negative_binomial(30.0,0.5, {0});check(x,{0},{},"15ed1a93cfbec2f8",r) end
do local r=np.random.default_rng(3);local x=r:negative_binomial(np.array({0.5,1.0,2.0,4.0},"float64"),np.array({1.0,1.0,1.0,1.0},"float64"));check(x,{4},{0,0,0,0},"28e4a64643c92921",r) end
do local r=np.random.default_rng(3);local x=r:negative_binomial(np.array({0.5,1.0,2.0,4.0},"float64"),np.array({1.0,1.0,1.0,1.0},"float64"), {2,4});check(x,{2,4},{{0,0,0,0},{0,0,0,0}},"bce2efee2c3ec14a",r) end
do local r=np.random.default_rng(3);local x=r:negative_binomial(np.array({0.5,1.0,2.0,4.0},"float64"),np.array({1.0,1.0,1.0,1.0},"float64"), {0,4});check(x,{0,4},{},"15ed1a93cfbec2f8",r) end
do local r=np.random.default_rng(4);local x=r:binomial(np.array({0,1,2,10,100,1000},"int64"),0.4);check(x,{6},{0,1,1,7,37,392},"2caddade94b61004",r) end
do local r=np.random.default_rng(4);local x=r:binomial(np.array({0,1,2,10,100,1000},"int64"),0.4, {2,6});check(x,{2,6},{{0,1,1,7,37,392},{0,0,2,4,39,426}},"7f74403e856f867c",r) end
do local r=np.random.default_rng(4);local x=r:binomial(np.array({0,1,2,10,100,1000},"int64"),0.4, {0,6});check(x,{0,6},{},"f16c1ffbb9f8274e",r) end
do local r=np.random.default_rng(4);local x=r:binomial(np.array({{0},{1},{10},{50}},"int64"),np.array({{0.0,0.01,0.5,0.99,1.0}},"float64"));check(x,{4,5},{{0,0,0,0,0},{0,0,1,1,1},{0,0,4,10,10},{0,1,25,49,50}},"6e350109e5c6a816",r) end
do local r=np.random.default_rng(4);local x=r:binomial(np.array({{0},{1},{10},{50}},"int64"),np.array({{0.0,0.01,0.5,0.99,1.0}},"float64"), {2,4,5});check(x,{2,4,5},{{{0,0,0,0,0},{0,0,1,1,1},{0,0,4,10,10},{0,1,25,49,50}},{{0,0,0,0,0},{0,0,1,1,1},{0,1,7,10,10},{0,1,31,49,50}}},"7f74403e856f867c",r) end
do local r=np.random.default_rng(4);local x=r:binomial(np.array({{0},{1},{10},{50}},"int64"),np.array({{0.0,0.01,0.5,0.99,1.0}},"float64"), {0,4,5});check(x,{0,4,5},{},"f16c1ffbb9f8274e",r) end
do local r=np.random.default_rng(4);local x=r:binomial(np.flip(np.array({{4,9,13},{20,30,50}},"int64"),2),0.3);check(x,{2,3},{{7,3,3},{11,10,5}},"cd4965c2a081097b",r) end
do local r=np.random.default_rng(4);local x=r:binomial(np.flip(np.array({{4,9,13},{20,30,50}},"int64"),2),0.3, {2,2,3});check(x,{2,2,3},{{{7,3,3},{11,10,5}},{{5,1,2},{15,12,6}}},"6e350109e5c6a816",r) end
do local r=np.random.default_rng(4);local x=r:binomial(np.flip(np.array({{4,9,13},{20,30,50}},"int64"),2),0.3, {0,2,3});check(x,{0,2,3},{},"f16c1ffbb9f8274e",r) end
do local r=np.random.default_rng(4);local x=r:binomial(100,np.array({0.0,0.1,0.5,0.9,1.0},"float32"));check(x,{5},{0,15,46,91,100},"2caddade94b61004",r) end
do local r=np.random.default_rng(4);local x=r:binomial(100,np.array({0.0,0.1,0.5,0.9,1.0},"float32"), {2,5});check(x,{2,5},{{0,15,46,91,100},{0,7,40,86,100}},"6e350109e5c6a816",r) end
do local r=np.random.default_rng(4);local x=r:binomial(100,np.array({0.0,0.1,0.5,0.9,1.0},"float32"), {0,5});check(x,{0,5},{},"f16c1ffbb9f8274e",r) end
do local r=np.random.default_rng(4);local x=r:binomial(np.transpose(np.array({{10,20},{30,40}},"int64")),0.12);check(x,{2,2},{{3,4},{6,2}},"9b7babfb741a13b3",r) end
do local r=np.random.default_rng(4);local x=r:binomial(np.transpose(np.array({{10,20},{30,40}},"int64")),0.12, {2,2,2});check(x,{2,2,2},{{{3,4},{6,2}},{{1,3},{4,3}}},"df237d44ad0cd991",r) end
do local r=np.random.default_rng(4);local x=r:binomial(np.transpose(np.array({{10,20},{30,40}},"int64")),0.12, {0,2,2});check(x,{0,2,2},{},"f16c1ffbb9f8274e",r) end
do local r=np.random.default_rng(4);local x=r:binomial(np.array({3,13,25},"int64"),np.array({0.15,0.5,0.95},"float64"));check(x,{3},{2,7,21},"14b1ab6ef864ac36",r) end
do local r=np.random.default_rng(4);local x=r:binomial(np.array({3,13,25},"int64"),np.array({0.15,0.5,0.95},"float64"), {2,3});check(x,{2,3},{{2,7,21},{0,7,24}},"cd4965c2a081097b",r) end
do local r=np.random.default_rng(4);local x=r:binomial(np.array({3,13,25},"int64"),np.array({0.15,0.5,0.95},"float64"), {0,3});check(x,{0,3},{},"f16c1ffbb9f8274e",r) end
do local r=np.random.default_rng(4);local x=r:binomial(np.array({4,100,1000,100000},"int64"),np.array({0.05,0.75,0.5,0.001},"float64"));check(x,{4},{1,75,552,89},"cd4965c2a081097b",r) end
do local r=np.random.default_rng(4);local x=r:binomial(np.array({4,100,1000,100000},"int64"),np.array({0.05,0.75,0.5,0.001},"float64"), {2,4});check(x,{2,4},{{1,75,552,89},{0,79,514,78}},"6e350109e5c6a816",r) end
do local r=np.random.default_rng(4);local x=r:binomial(np.array({4,100,1000,100000},"int64"),np.array({0.05,0.75,0.5,0.001},"float64"), {0,4});check(x,{0,4},{},"f16c1ffbb9f8274e",r) end
do local r=np.random.default_rng(4);local x=r:binomial(np.array({{100,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2));check(x,{2,2},{{97,1},{23,22}},"9b7babfb741a13b3",r) end
do local r=np.random.default_rng(4);local x=r:binomial(np.array({{100,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2), {2,2,2});check(x,{2,2,2},{{{97,1},{23,22}},{{99,1},{19,21}}},"df237d44ad0cd991",r) end
do local r=np.random.default_rng(4);local x=r:binomial(np.array({{100,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2), {0,2,2});check(x,{0,2,2},{},"f16c1ffbb9f8274e",r) end
do local r=np.random.default_rng(4);local x=r:binomial(1000000000000,np.array({1e-08,0.0001,0.5,0.9999,1.0},"float64"));check(x,{5},{10093,99988116,500000161496,999899990139,1000000000000},"c9f8697e23b2a48f",r) end
do local r=np.random.default_rng(4);local x=r:binomial(1000000000000,np.array({1e-08,0.0001,0.5,0.9999,1.0},"float64"), {2,5});check(x,{2,5},{{10093,99988116,500000161496,999899990139,1000000000000},{9898,100002217,499999647372,999899996639,1000000000000}},"59957f57e244b030",r) end
do local r=np.random.default_rng(4);local x=r:binomial(1000000000000,np.array({1e-08,0.0001,0.5,0.9999,1.0},"float64"), {0,5});check(x,{0,5},{},"f16c1ffbb9f8274e",r) end
do local r=np.random.default_rng(4);local x=r:binomial(np.array(6,"int64"),np.array(0.23,"float64"));check(x,{},3,"82e65ccce1a329b5",r) end
do local r=np.random.default_rng(4);local x=r:binomial(np.array(6,"int64"),np.array(0.23,"float64"), {2});check(x,{2},{3,1},"f9eb1b84f0c08ec3",r) end
do local r=np.random.default_rng(4);local x=r:binomial(np.array(6,"int64"),np.array(0.23,"float64"), {0});check(x,{0},{},"f16c1ffbb9f8274e",r) end
do local r=np.random.default_rng(4);local x=r:binomial(30,0.5);check(x,{},19,"82e65ccce1a329b5",r) end
do local r=np.random.default_rng(4);local x=r:binomial(30,0.5, {2});check(x,{2},{19,15},"f9eb1b84f0c08ec3",r) end
do local r=np.random.default_rng(4);local x=r:binomial(30,0.5, {0});check(x,{0},{},"f16c1ffbb9f8274e",r) end
do local r=np.random.default_rng(4);local x=r:binomial(0,np.array({0.0,0.4,1.0},"float64"));check(x,{3},{0,0,0},"f16c1ffbb9f8274e",r) end
do local r=np.random.default_rng(4);local x=r:binomial(0,np.array({0.0,0.4,1.0},"float64"), {2,3});check(x,{2,3},{{0,0,0},{0,0,0}},"f16c1ffbb9f8274e",r) end
do local r=np.random.default_rng(4);local x=r:binomial(0,np.array({0.0,0.4,1.0},"float64"), {0,3});check(x,{0,3},{},"f16c1ffbb9f8274e",r) end
do local r=np.random.default_rng(4);local x=r:binomial(np.array({0,1,2,3,4},"int64"),np.array({1.0,1.0,1.0,1.0,1.0},"float64"));check(x,{5},{0,1,2,3,4},"9b7babfb741a13b3",r) end
do local r=np.random.default_rng(4);local x=r:binomial(np.array({0,1,2,3,4},"int64"),np.array({1.0,1.0,1.0,1.0,1.0},"float64"), {2,5});check(x,{2,5},{{0,1,2,3,4},{0,1,2,3,4}},"df237d44ad0cd991",r) end
do local r=np.random.default_rng(4);local x=r:binomial(np.array({0,1,2,3,4},"int64"),np.array({1.0,1.0,1.0,1.0,1.0},"float64"), {0,5});check(x,{0,5},{},"f16c1ffbb9f8274e",r) end
do local r=np.random.default_rng(4);local x=r:negative_binomial(np.array({0.1,0.5,1.0,2.5,5.0,20.0},"float64"),0.5);check(x,{6},{1,1,1,10,13,19},"5c9fe9697a9e871d",r) end
do local r=np.random.default_rng(4);local x=r:negative_binomial(np.array({0.1,0.5,1.0,2.5,5.0,20.0},"float64"),0.5, {2,6});check(x,{2,6},{{1,1,1,10,13,19},{0,2,4,2,5,27}},"8182376467be69f6",r) end
do local r=np.random.default_rng(4);local x=r:negative_binomial(np.array({0.1,0.5,1.0,2.5,5.0,20.0},"float64"),0.5, {0,6});check(x,{0,6},{},"f16c1ffbb9f8274e",r) end
do local r=np.random.default_rng(4);local x=r:negative_binomial(np.array({{0.1},{0.5},{1.2},{20.0}},"float64"),np.array({{0.01,0.1,0.5,0.95,1.0}},"float64"));check(x,{4,5},{{92,0,0,0,0},{333,6,0,0,0},{67,4,1,1,0},{2273,165,13,1,0}},"5ece551aa45c419f",r) end
do local r=np.random.default_rng(4);local x=r:negative_binomial(np.array({{0.1},{0.5},{1.2},{20.0}},"float64"),np.array({{0.01,0.1,0.5,0.95,1.0}},"float64"), {2,4,5});check(x,{2,4,5},{{{92,0,0,0,0},{333,6,0,0,0},{67,4,1,1,0},{2273,165,13,1,0}},{{0,0,0,0,0},{34,0,0,0,0},{47,20,0,0,0},{3029,195,35,3,0}}},"ee0a6b7a45dc69b9",r) end
do local r=np.random.default_rng(4);local x=r:negative_binomial(np.array({{0.1},{0.5},{1.2},{20.0}},"float64"),np.array({{0.01,0.1,0.5,0.95,1.0}},"float64"), {0,4,5});check(x,{0,4,5},{},"f16c1ffbb9f8274e",r) end
do local r=np.random.default_rng(4);local x=r:negative_binomial(np.flip(np.array({{1.3,2.8},{3.5,8.5}},"float64"),2),0.4);check(x,{2,2},{{1,0},{13,16}},"9bddb31676cc4935",r) end
do local r=np.random.default_rng(4);local x=r:negative_binomial(np.flip(np.array({{1.3,2.8},{3.5,8.5}},"float64"),2),0.4, {2,2,2});check(x,{2,2,2},{{{1,0},{13,16}},{{2,7},{13,3}}},"5c9fe9697a9e871d",r) end
do local r=np.random.default_rng(4);local x=r:negative_binomial(np.flip(np.array({{1.3,2.8},{3.5,8.5}},"float64"),2),0.4, {0,2,2});check(x,{0,2,2},{},"f16c1ffbb9f8274e",r) end
do local r=np.random.default_rng(4);local x=r:negative_binomial(10.0,np.array({0.001,0.01,0.1,0.5,1.0},"float32"));check(x,{5},{7798,814,92,8,0},"f565a6115d37c162",r) end
do local r=np.random.default_rng(4);local x=r:negative_binomial(10.0,np.array({0.001,0.01,0.1,0.5,1.0},"float32"), {2,5});check(x,{2,5},{{7798,814,92,8,0},{7070,1031,124,8,0}},"d1fd121e12423197",r) end
do local r=np.random.default_rng(4);local x=r:negative_binomial(10.0,np.array({0.001,0.01,0.1,0.5,1.0},"float32"), {0,5});check(x,{0,5},{},"f16c1ffbb9f8274e",r) end
do local r=np.random.default_rng(4);local x=r:negative_binomial(np.transpose(np.array({{3.0,20.0},{30.0,40.0}},"float32")),0.12);check(x,{2,2},{{25,170},{113,287}},"b47204164dce6737",r) end
do local r=np.random.default_rng(4);local x=r:negative_binomial(np.transpose(np.array({{3.0,20.0},{30.0,40.0}},"float32")),0.12, {2,2,2});check(x,{2,2,2},{{{25,170},{113,287}},{{14,282},{172,217}}},"7de1b55006e18837",r) end
do local r=np.random.default_rng(4);local x=r:negative_binomial(np.transpose(np.array({{3.0,20.0},{30.0,40.0}},"float32")),0.12, {0,2,2});check(x,{0,2,2},{},"f16c1ffbb9f8274e",r) end
do local r=np.random.default_rng(4);local x=r:negative_binomial(np.array({0.1,1.2,3.7},"float64"),np.array({0.9,0.5,0.2},"float64"));check(x,{3},{1,0,15},"7a26bbbc0f800cb5",r) end
do local r=np.random.default_rng(4);local x=r:negative_binomial(np.array({0.1,1.2,3.7},"float64"),np.array({0.9,0.5,0.2},"float64"), {2,3});check(x,{2,3},{{1,0,15},{0,1,13}},"7f74403e856f867c",r) end
do local r=np.random.default_rng(4);local x=r:negative_binomial(np.array({0.1,1.2,3.7},"float64"),np.array({0.9,0.5,0.2},"float64"), {0,3});check(x,{0,3},{},"f16c1ffbb9f8274e",r) end
do local r=np.random.default_rng(4);local x=r:negative_binomial(np.array({4,10,100,1000},"int64"),np.array({0.95,0.75,0.5,0.1},"float64"));check(x,{4},{1,1,99,8988},"b47204164dce6737",r) end
do local r=np.random.default_rng(4);local x=r:negative_binomial(np.array({4,10,100,1000},"int64"),np.array({0.95,0.75,0.5,0.1},"float64"), {2,4});check(x,{2,4},{{1,1,99,8988},{0,4,116,9046}},"79ddafa01d85d732",r) end
do local r=np.random.default_rng(4);local x=r:negative_binomial(np.array({4,10,100,1000},"int64"),np.array({0.95,0.75,0.5,0.1},"float64"), {0,4});check(x,{0,4},{},"f16c1ffbb9f8274e",r) end
do local r=np.random.default_rng(4);local x=r:negative_binomial(np.array({{10,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2));check(x,{2,2},{{1,13},{96,9}},"85a77e682a3371b7",r) end
do local r=np.random.default_rng(4);local x=r:negative_binomial(np.array({{10,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2), {2,2,2});check(x,{2,2,2},{{{1,13},{96,9}},{{1,20},{95,9}}},"d1fd121e12423197",r) end
do local r=np.random.default_rng(4);local x=r:negative_binomial(np.array({{10,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2), {0,2,2});check(x,{0,2,2},{},"f16c1ffbb9f8274e",r) end
do local r=np.random.default_rng(4);local x=r:negative_binomial(1000.0,np.array({0.01,0.05,0.5,0.999,1.0},"float64"));check(x,{5},{97036,18800,1001,2,0},"f15b94f868832754",r) end
do local r=np.random.default_rng(4);local x=r:negative_binomial(1000.0,np.array({0.01,0.05,0.5,0.999,1.0},"float64"), {2,5});check(x,{2,5},{{97036,18800,1001,2,0},{96482,18257,947,2,0}},"b14b173ecf4e46a0",r) end
do local r=np.random.default_rng(4);local x=r:negative_binomial(1000.0,np.array({0.01,0.05,0.5,0.999,1.0},"float64"), {0,5});check(x,{0,5},{},"f16c1ffbb9f8274e",r) end
do local r=np.random.default_rng(4);local x=r:negative_binomial(np.array(6.0,"float64"),np.array(0.23,"float64"));check(x,{},27,"9b7babfb741a13b3",r) end
do local r=np.random.default_rng(4);local x=r:negative_binomial(np.array(6.0,"float64"),np.array(0.23,"float64"), {2});check(x,{2},{27,16},"222639671719b18f",r) end
do local r=np.random.default_rng(4);local x=r:negative_binomial(np.array(6.0,"float64"),np.array(0.23,"float64"), {0});check(x,{0},{},"f16c1ffbb9f8274e",r) end
do local r=np.random.default_rng(4);local x=r:negative_binomial(30.0,0.5);check(x,{},44,"9b7babfb741a13b3",r) end
do local r=np.random.default_rng(4);local x=r:negative_binomial(30.0,0.5, {2});check(x,{2},{44,26},"df237d44ad0cd991",r) end
do local r=np.random.default_rng(4);local x=r:negative_binomial(30.0,0.5, {0});check(x,{0},{},"f16c1ffbb9f8274e",r) end
do local r=np.random.default_rng(4);local x=r:negative_binomial(np.array({0.5,1.0,2.0,4.0},"float64"),np.array({1.0,1.0,1.0,1.0},"float64"));check(x,{4},{0,0,0,0},"2caddade94b61004",r) end
do local r=np.random.default_rng(4);local x=r:negative_binomial(np.array({0.5,1.0,2.0,4.0},"float64"),np.array({1.0,1.0,1.0,1.0},"float64"), {2,4});check(x,{2,4},{{0,0,0,0},{0,0,0,0}},"fbf17374f6e6a799",r) end
do local r=np.random.default_rng(4);local x=r:negative_binomial(np.array({0.5,1.0,2.0,4.0},"float64"),np.array({1.0,1.0,1.0,1.0},"float64"), {0,4});check(x,{0,4},{},"f16c1ffbb9f8274e",r) end
do local r=np.random.default_rng(5);local x=r:binomial(np.array({0,1,2,10,100,1000},"int64"),0.4);check(x,{6},{0,1,1,4,45,405},"0b9727b5218d35ce",r) end
do local r=np.random.default_rng(5);local x=r:binomial(np.array({0,1,2,10,100,1000},"int64"),0.4, {2,6});check(x,{2,6},{{0,1,1,4,45,405},{0,0,0,9,41,389}},"e5ce33212d7f2843",r) end
do local r=np.random.default_rng(5);local x=r:binomial(np.array({0,1,2,10,100,1000},"int64"),0.4, {0,6});check(x,{0,6},{},"ce14abeeabb8e5a8",r) end
do local r=np.random.default_rng(5);local x=r:binomial(np.array({{0},{1},{10},{50}},"int64"),np.array({{0.0,0.01,0.5,0.99,1.0}},"float64"));check(x,{4,5},{{0,0,0,0,0},{0,0,1,1,1},{0,0,5,10,10},{0,0,36,49,50}},"6f58b9084840b5bd",r) end
do local r=np.random.default_rng(5);local x=r:binomial(np.array({{0},{1},{10},{50}},"int64"),np.array({{0.0,0.01,0.5,0.99,1.0}},"float64"), {2,4,5});check(x,{2,4,5},{{{0,0,0,0,0},{0,0,1,1,1},{0,0,5,10,10},{0,0,36,49,50}},{{0,0,0,0,0},{0,0,1,1,1},{0,0,5,10,10},{0,0,23,49,50}}},"added7485fb8582d",r) end
do local r=np.random.default_rng(5);local x=r:binomial(np.array({{0},{1},{10},{50}},"int64"),np.array({{0.0,0.01,0.5,0.99,1.0}},"float64"), {0,4,5});check(x,{0,4,5},{},"ce14abeeabb8e5a8",r) end
do local r=np.random.default_rng(5);local x=r:binomial(np.flip(np.array({{4,9,13},{20,30,50}},"int64"),2),0.3);check(x,{2,3},{{5,4,1},{13,5,5}},"6891b332923923c4",r) end
do local r=np.random.default_rng(5);local x=r:binomial(np.flip(np.array({{4,9,13},{20,30,50}},"int64"),2),0.3, {2,2,3});check(x,{2,2,3},{{{5,4,1},{13,5,5}},{{3,1,0},{26,10,4}}},"6f58b9084840b5bd",r) end
do local r=np.random.default_rng(5);local x=r:binomial(np.flip(np.array({{4,9,13},{20,30,50}},"int64"),2),0.3, {0,2,3});check(x,{0,2,3},{},"ce14abeeabb8e5a8",r) end
do local r=np.random.default_rng(5);local x=r:binomial(100,np.array({0.0,0.1,0.5,0.9,1.0},"float32"));check(x,{5},{0,13,56,92,100},"622476854726028f",r) end
do local r=np.random.default_rng(5);local x=r:binomial(100,np.array({0.0,0.1,0.5,0.9,1.0},"float32"), {2,5});check(x,{2,5},{{0,13,56,92,100},{0,9,57,95,100}},"a701a97f30e43655",r) end
do local r=np.random.default_rng(5);local x=r:binomial(100,np.array({0.0,0.1,0.5,0.9,1.0},"float32"), {0,5});check(x,{0,5},{},"ce14abeeabb8e5a8",r) end
do local r=np.random.default_rng(5);local x=r:binomial(np.transpose(np.array({{10,20},{30,40}},"int64")),0.12);check(x,{2,2},{{2,5},{2,4}},"0dce670afac210ed",r) end
do local r=np.random.default_rng(5);local x=r:binomial(np.transpose(np.array({{10,20},{30,40}},"int64")),0.12, {2,2,2});check(x,{2,2,2},{{{2,5},{2,4}},{{0,3},{2,2}}},"0c7b62a500428ab4",r) end
do local r=np.random.default_rng(5);local x=r:binomial(np.transpose(np.array({{10,20},{30,40}},"int64")),0.12, {0,2,2});check(x,{0,2,2},{},"ce14abeeabb8e5a8",r) end
do local r=np.random.default_rng(5);local x=r:binomial(np.array({3,13,25},"int64"),np.array({0.15,0.5,0.95},"float64"));check(x,{3},{1,8,24},"492a477ca1570476",r) end
do local r=np.random.default_rng(5);local x=r:binomial(np.array({3,13,25},"int64"),np.array({0.15,0.5,0.95},"float64"), {2,3});check(x,{2,3},{{1,8,24},{0,4,24}},"6891b332923923c4",r) end
do local r=np.random.default_rng(5);local x=r:binomial(np.array({3,13,25},"int64"),np.array({0.15,0.5,0.95},"float64"), {0,3});check(x,{0,3},{},"ce14abeeabb8e5a8",r) end
do local r=np.random.default_rng(5);local x=r:binomial(np.array({4,100,1000,100000},"int64"),np.array({0.05,0.75,0.5,0.001},"float64"));check(x,{4},{0,71,515,95},"6891b332923923c4",r) end
do local r=np.random.default_rng(5);local x=r:binomial(np.array({4,100,1000,100000},"int64"),np.array({0.05,0.75,0.5,0.001},"float64"), {2,4});check(x,{2,4},{{0,71,515,95},{0,82,470,93}},"6f58b9084840b5bd",r) end
do local r=np.random.default_rng(5);local x=r:binomial(np.array({4,100,1000,100000},"int64"),np.array({0.05,0.75,0.5,0.001},"float64"), {0,4});check(x,{0,4},{},"ce14abeeabb8e5a8",r) end
do local r=np.random.default_rng(5);local x=r:binomial(np.array({{100,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2));check(x,{2,2},{{98,2},{17,20}},"0dce670afac210ed",r) end
do local r=np.random.default_rng(5);local x=r:binomial(np.array({{100,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2), {2,2,2});check(x,{2,2,2},{{{98,2},{17,20}},{{100,1},{16,22}}},"0c7b62a500428ab4",r) end
do local r=np.random.default_rng(5);local x=r:binomial(np.array({{100,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2), {0,2,2});check(x,{0,2,2},{},"ce14abeeabb8e5a8",r) end
do local r=np.random.default_rng(5);local x=r:binomial(1000000000000,np.array({1e-08,0.0001,0.5,0.9999,1.0},"float64"));check(x,{5},{10086,99993154,500000543689,999900020510,1000000000000},"3c08dc4ec010f76d",r) end
do local r=np.random.default_rng(5);local x=r:binomial(1000000000000,np.array({1e-08,0.0001,0.5,0.9999,1.0},"float64"), {2,5});check(x,{2,5},{{10086,99993154,500000543689,999900020510,1000000000000},{9974,99997292,499999973537,999900010426,1000000000000}},"e130d1bd5c8c7597",r) end
do local r=np.random.default_rng(5);local x=r:binomial(1000000000000,np.array({1e-08,0.0001,0.5,0.9999,1.0},"float64"), {0,5});check(x,{0,5},{},"ce14abeeabb8e5a8",r) end
do local r=np.random.default_rng(5);local x=r:binomial(np.array(6,"int64"),np.array(0.23,"float64"));check(x,{},2,"ced5352505cc99f5",r) end
do local r=np.random.default_rng(5);local x=r:binomial(np.array(6,"int64"),np.array(0.23,"float64"), {2});check(x,{2},{2,2},"83ec603f7806adc0",r) end
do local r=np.random.default_rng(5);local x=r:binomial(np.array(6,"int64"),np.array(0.23,"float64"), {0});check(x,{0},{},"ce14abeeabb8e5a8",r) end
do local r=np.random.default_rng(5);local x=r:binomial(30,0.5);check(x,{},17,"ced5352505cc99f5",r) end
do local r=np.random.default_rng(5);local x=r:binomial(30,0.5, {2});check(x,{2},{17,17},"83ec603f7806adc0",r) end
do local r=np.random.default_rng(5);local x=r:binomial(30,0.5, {0});check(x,{0},{},"ce14abeeabb8e5a8",r) end
do local r=np.random.default_rng(5);local x=r:binomial(0,np.array({0.0,0.4,1.0},"float64"));check(x,{3},{0,0,0},"ce14abeeabb8e5a8",r) end
do local r=np.random.default_rng(5);local x=r:binomial(0,np.array({0.0,0.4,1.0},"float64"), {2,3});check(x,{2,3},{{0,0,0},{0,0,0}},"ce14abeeabb8e5a8",r) end
do local r=np.random.default_rng(5);local x=r:binomial(0,np.array({0.0,0.4,1.0},"float64"), {0,3});check(x,{0,3},{},"ce14abeeabb8e5a8",r) end
do local r=np.random.default_rng(5);local x=r:binomial(np.array({0,1,2,3,4},"int64"),np.array({1.0,1.0,1.0,1.0,1.0},"float64"));check(x,{5},{0,1,2,3,4},"0dce670afac210ed",r) end
do local r=np.random.default_rng(5);local x=r:binomial(np.array({0,1,2,3,4},"int64"),np.array({1.0,1.0,1.0,1.0,1.0},"float64"), {2,5});check(x,{2,5},{{0,1,2,3,4},{0,1,2,3,4}},"0c7b62a500428ab4",r) end
do local r=np.random.default_rng(5);local x=r:binomial(np.array({0,1,2,3,4},"int64"),np.array({1.0,1.0,1.0,1.0,1.0},"float64"), {0,5});check(x,{0,5},{},"ce14abeeabb8e5a8",r) end
do local r=np.random.default_rng(5);local x=r:negative_binomial(np.array({0.1,0.5,1.0,2.5,5.0,20.0},"float64"),0.5);check(x,{6},{0,0,1,3,0,22},"added7485fb8582d",r) end
do local r=np.random.default_rng(5);local x=r:negative_binomial(np.array({0.1,0.5,1.0,2.5,5.0,20.0},"float64"),0.5, {2,6});check(x,{2,6},{{0,0,1,3,0,22},{0,0,0,1,2,20}},"81cf37b18501400d",r) end
do local r=np.random.default_rng(5);local x=r:negative_binomial(np.array({0.1,0.5,1.0,2.5,5.0,20.0},"float64"),0.5, {0,6});check(x,{0,6},{},"ce14abeeabb8e5a8",r) end
do local r=np.random.default_rng(5);local x=r:negative_binomial(np.array({{0.1},{0.5},{1.2},{20.0}},"float64"),np.array({{0.01,0.1,0.5,0.95,1.0}},"float64"));check(x,{4,5},{{11,0,0,0,0},{116,0,0,0,0},{25,8,1,0,0},{3252,136,25,1,0}},"fdde867bad73555b",r) end
do local r=np.random.default_rng(5);local x=r:negative_binomial(np.array({{0.1},{0.5},{1.2},{20.0}},"float64"),np.array({{0.01,0.1,0.5,0.95,1.0}},"float64"), {2,4,5});check(x,{2,4,5},{{{11,0,0,0,0},{116,0,0,0,0},{25,8,1,0,0},{3252,136,25,1,0}},{{415,0,0,0,0},{213,0,0,0,0},{362,15,1,0,0},{1592,256,31,0,0}}},"0b018f8c3c898118",r) end
do local r=np.random.default_rng(5);local x=r:negative_binomial(np.array({{0.1},{0.5},{1.2},{20.0}},"float64"),np.array({{0.01,0.1,0.5,0.95,1.0}},"float64"), {0,4,5});check(x,{0,4,5},{},"ce14abeeabb8e5a8",r) end
do local r=np.random.default_rng(5);local x=r:negative_binomial(np.flip(np.array({{1.3,2.8},{3.5,8.5}},"float64"),2),0.4);check(x,{2,2},{{2,0},{18,5}},"8e3b8c0ff587898a",r) end
do local r=np.random.default_rng(5);local x=r:negative_binomial(np.flip(np.array({{1.3,2.8},{3.5,8.5}},"float64"),2),0.4, {2,2,2});check(x,{2,2,2},{{{2,0},{18,5}},{{1,3},{7,6}}},"eee7c2f35055810b",r) end
do local r=np.random.default_rng(5);local x=r:negative_binomial(np.flip(np.array({{1.3,2.8},{3.5,8.5}},"float64"),2),0.4, {0,2,2});check(x,{0,2,2},{},"ce14abeeabb8e5a8",r) end
do local r=np.random.default_rng(5);local x=r:negative_binomial(10.0,np.array({0.001,0.01,0.1,0.5,1.0},"float32"));check(x,{5},{7378,1341,114,7,0},"added7485fb8582d",r) end
do local r=np.random.default_rng(5);local x=r:negative_binomial(10.0,np.array({0.001,0.01,0.1,0.5,1.0},"float32"), {2,5});check(x,{2,5},{{7378,1341,114,7,0},{10898,702,77,7,0}},"03b8a650c49fe9be",r) end
do local r=np.random.default_rng(5);local x=r:negative_binomial(10.0,np.array({0.001,0.01,0.1,0.5,1.0},"float32"), {0,5});check(x,{0,5},{},"ce14abeeabb8e5a8",r) end
do local r=np.random.default_rng(5);local x=r:negative_binomial(np.transpose(np.array({{3.0,20.0},{30.0,40.0}},"float32")),0.12);check(x,{2,2},{{12,262},{176,272}},"6474a1d01da07f0e",r) end
do local r=np.random.default_rng(5);local x=r:negative_binomial(np.transpose(np.array({{3.0,20.0},{30.0,40.0}},"float32")),0.12, {2,2,2});check(x,{2,2,2},{{{12,262},{176,272}},{{21,209},{147,258}}},"80dc75fa09b12f6d",r) end
do local r=np.random.default_rng(5);local x=r:negative_binomial(np.transpose(np.array({{3.0,20.0},{30.0,40.0}},"float32")),0.12, {0,2,2});check(x,{0,2,2},{},"ce14abeeabb8e5a8",r) end
do local r=np.random.default_rng(5);local x=r:negative_binomial(np.array({0.1,1.2,3.7},"float64"),np.array({0.9,0.5,0.2},"float64"));check(x,{3},{0,1,12},"e130d1bd5c8c7597",r) end
do local r=np.random.default_rng(5);local x=r:negative_binomial(np.array({0.1,1.2,3.7},"float64"),np.array({0.9,0.5,0.2},"float64"), {2,3});check(x,{2,3},{{0,1,12},{0,0,6}},"b2d1ae8a47f083b0",r) end
do local r=np.random.default_rng(5);local x=r:negative_binomial(np.array({0.1,1.2,3.7},"float64"),np.array({0.9,0.5,0.2},"float64"), {0,3});check(x,{0,3},{},"ce14abeeabb8e5a8",r) end
do local r=np.random.default_rng(5);local x=r:negative_binomial(np.array({4,10,100,1000},"int64"),np.array({0.95,0.75,0.5,0.1},"float64"));check(x,{4},{0,2,112,8867},"6474a1d01da07f0e",r) end
do local r=np.random.default_rng(5);local x=r:negative_binomial(np.array({4,10,100,1000},"int64"),np.array({0.95,0.75,0.5,0.1},"float64"), {2,4});check(x,{2,4},{{0,2,112,8867},{0,2,95,8778}},"80dc75fa09b12f6d",r) end
do local r=np.random.default_rng(5);local x=r:negative_binomial(np.array({4,10,100,1000},"int64"),np.array({0.95,0.75,0.5,0.1},"float64"), {0,4});check(x,{0,4},{},"ce14abeeabb8e5a8",r) end
do local r=np.random.default_rng(5);local x=r:negative_binomial(np.array({{10,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2));check(x,{2,2},{{0,21},{82,15}},"7e36c1ada0c69753",r) end
do local r=np.random.default_rng(5);local x=r:negative_binomial(np.array({{10,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2), {2,2,2});check(x,{2,2,2},{{{0,21},{82,15}},{{0,18},{98,1}}},"80dc75fa09b12f6d",r) end
do local r=np.random.default_rng(5);local x=r:negative_binomial(np.array({{10,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2), {0,2,2});check(x,{0,2,2},{},"ce14abeeabb8e5a8",r) end
do local r=np.random.default_rng(5);local x=r:negative_binomial(1000.0,np.array({0.01,0.05,0.5,0.999,1.0},"float64"));check(x,{5},{96491,19648,1038,2,0},"0f90c43fa9b58b34",r) end
do local r=np.random.default_rng(5);local x=r:negative_binomial(1000.0,np.array({0.01,0.05,0.5,0.999,1.0},"float64"), {2,5});check(x,{2,5},{{96491,19648,1038,2,0},{97234,18819,986,0,0}},"72d3c943945d0ebc",r) end
do local r=np.random.default_rng(5);local x=r:negative_binomial(1000.0,np.array({0.01,0.05,0.5,0.999,1.0},"float64"), {0,5});check(x,{0,5},{},"ce14abeeabb8e5a8",r) end
do local r=np.random.default_rng(5);local x=r:negative_binomial(np.array(6.0,"float64"),np.array(0.23,"float64"));check(x,{},13,"0dce670afac210ed",r) end
do local r=np.random.default_rng(5);local x=r:negative_binomial(np.array(6.0,"float64"),np.array(0.23,"float64"), {2});check(x,{2},{13,28},"0c7b62a500428ab4",r) end
do local r=np.random.default_rng(5);local x=r:negative_binomial(np.array(6.0,"float64"),np.array(0.23,"float64"), {0});check(x,{0},{},"ce14abeeabb8e5a8",r) end
do local r=np.random.default_rng(5);local x=r:negative_binomial(30.0,0.5);check(x,{},26,"0dce670afac210ed",r) end
do local r=np.random.default_rng(5);local x=r:negative_binomial(30.0,0.5, {2});check(x,{2},{26,35},"0c7b62a500428ab4",r) end
do local r=np.random.default_rng(5);local x=r:negative_binomial(30.0,0.5, {0});check(x,{0},{},"ce14abeeabb8e5a8",r) end
do local r=np.random.default_rng(5);local x=r:negative_binomial(np.array({0.5,1.0,2.0,4.0},"float64"),np.array({1.0,1.0,1.0,1.0},"float64"));check(x,{4},{0,0,0,0},"0b9727b5218d35ce",r) end
do local r=np.random.default_rng(5);local x=r:negative_binomial(np.array({0.5,1.0,2.0,4.0},"float64"),np.array({1.0,1.0,1.0,1.0},"float64"), {2,4});check(x,{2,4},{{0,0,0,0},{0,0,0,0}},"6474a1d01da07f0e",r) end
do local r=np.random.default_rng(5);local x=r:negative_binomial(np.array({0.5,1.0,2.0,4.0},"float64"),np.array({1.0,1.0,1.0,1.0},"float64"), {0,4});check(x,{0,4},{},"ce14abeeabb8e5a8",r) end
do local r=np.random.default_rng(42);local x=r:binomial(np.array({0,1,2,10,100,1000},"int64"),0.4);check(x,{6},{0,1,1,6,43,434},"c93b82a3b7ac9740",r) end
do local r=np.random.default_rng(42);local x=r:binomial(np.array({0,1,2,10,100,1000},"int64"),0.4, {2,6});check(x,{2,6},{{0,1,1,6,43,434},{0,1,0,4,40,404}},"718397ca8ba13e23",r) end
do local r=np.random.default_rng(42);local x=r:binomial(np.array({0,1,2,10,100,1000},"int64"),0.4, {0,6});check(x,{0,6},{},"c621fbcd16d92688",r) end
do local r=np.random.default_rng(42);local x=r:binomial(np.array({{0},{1},{10},{50}},"int64"),np.array({{0.0,0.01,0.5,0.99,1.0}},"float64"));check(x,{4,5},{{0,0,0,0,0},{0,0,0,1,1},{0,0,8,10,10},{0,0,25,50,50}},"a4d45831c814ce06",r) end
do local r=np.random.default_rng(42);local x=r:binomial(np.array({{0},{1},{10},{50}},"int64"),np.array({{0.0,0.01,0.5,0.99,1.0}},"float64"), {2,4,5});check(x,{2,4,5},{{{0,0,0,0,0},{0,0,0,1,1},{0,0,8,10,10},{0,0,25,50,50}},{{0,0,0,0,0},{0,0,1,1,1},{0,0,3,10,10},{0,1,24,48,50}}},"c744240fad8c19b0",r) end
do local r=np.random.default_rng(42);local x=r:binomial(np.array({{0},{1},{10},{50}},"int64"),np.array({{0.0,0.01,0.5,0.99,1.0}},"float64"), {0,4,5});check(x,{0,4,5},{},"c621fbcd16d92688",r) end
do local r=np.random.default_rng(42);local x=r:binomial(np.flip(np.array({{4,9,13},{20,30,50}},"int64"),2),0.3);check(x,{2,3},{{5,2,2},{17,6,10}},"c2da0d2fbc5a4471",r) end
do local r=np.random.default_rng(42);local x=r:binomial(np.flip(np.array({{4,9,13},{20,30,50}},"int64"),2),0.3, {2,2,3});check(x,{2,2,3},{{{5,2,2},{17,6,10}},{{5,4,0},{15,8,9}}},"a4d45831c814ce06",r) end
do local r=np.random.default_rng(42);local x=r:binomial(np.flip(np.array({{4,9,13},{20,30,50}},"int64"),2),0.3, {0,2,3});check(x,{0,2,3},{},"c621fbcd16d92688",r) end
do local r=np.random.default_rng(42);local x=r:binomial(100,np.array({0.0,0.1,0.5,0.9,1.0},"float32"));check(x,{5},{0,12,51,89,100},"f9c262ed86c7538c",r) end
do local r=np.random.default_rng(42);local x=r:binomial(100,np.array({0.0,0.1,0.5,0.9,1.0},"float32"), {2,5});check(x,{2,5},{{0,12,51,89,100},{0,16,49,91,100}},"a4d45831c814ce06",r) end
do local r=np.random.default_rng(42);local x=r:binomial(100,np.array({0.0,0.1,0.5,0.9,1.0},"float32"), {0,5});check(x,{0,5},{},"c621fbcd16d92688",r) end
do local r=np.random.default_rng(42);local x=r:binomial(np.transpose(np.array({{10,20},{30,40}},"int64")),0.12);check(x,{2,2},{{2,3},{4,6}},"181c01b5339381eb",r) end
do local r=np.random.default_rng(42);local x=r:binomial(np.transpose(np.array({{10,20},{30,40}},"int64")),0.12, {2,2,2});check(x,{2,2,2},{{{2,3},{4,6}},{{0,7},{3,6}}},"20cc0e168362d113",r) end
do local r=np.random.default_rng(42);local x=r:binomial(np.transpose(np.array({{10,20},{30,40}},"int64")),0.12, {0,2,2});check(x,{0,2,2},{},"c621fbcd16d92688",r) end
do local r=np.random.default_rng(42);local x=r:binomial(np.array({3,13,25},"int64"),np.array({0.15,0.5,0.95},"float64"));check(x,{3},{1,6,23},"b286b60e1600888d",r) end
do local r=np.random.default_rng(42);local x=r:binomial(np.array({3,13,25},"int64"),np.array({0.15,0.5,0.95},"float64"), {2,3});check(x,{2,3},{{1,6,23},{1,4,21}},"c2da0d2fbc5a4471",r) end
do local r=np.random.default_rng(42);local x=r:binomial(np.array({3,13,25},"int64"),np.array({0.15,0.5,0.95},"float64"), {0,3});check(x,{0,3},{},"c621fbcd16d92688",r) end
do local r=np.random.default_rng(42);local x=r:binomial(np.array({4,100,1000,100000},"int64"),np.array({0.05,0.75,0.5,0.001},"float64"));check(x,{4},{0,76,510,86},"c2da0d2fbc5a4471",r) end
do local r=np.random.default_rng(42);local x=r:binomial(np.array({4,100,1000,100000},"int64"),np.array({0.05,0.75,0.5,0.001},"float64"), {2,4});check(x,{2,4},{{0,76,510,86},{0,72,491,96}},"a4d45831c814ce06",r) end
do local r=np.random.default_rng(42);local x=r:binomial(np.array({4,100,1000,100000},"int64"),np.array({0.05,0.75,0.5,0.001},"float64"), {0,4});check(x,{0,4},{},"c621fbcd16d92688",r) end
do local r=np.random.default_rng(42);local x=r:binomial(np.array({{100,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2));check(x,{2,2},{{98,1},{20,18}},"181c01b5339381eb",r) end
do local r=np.random.default_rng(42);local x=r:binomial(np.array({{100,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2), {2,2,2});check(x,{2,2,2},{{{98,1},{20,18}},{{100,3},{19,17}}},"20cc0e168362d113",r) end
do local r=np.random.default_rng(42);local x=r:binomial(np.array({{100,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2), {0,2,2});check(x,{0,2,2},{},"c621fbcd16d92688",r) end
do local r=np.random.default_rng(42);local x=r:binomial(1000000000000,np.array({1e-08,0.0001,0.5,0.9999,1.0},"float64"));check(x,{5},{9818,99993838,499999521527,999899999353,1000000000000},"3a2c511e7351513a",r) end
do local r=np.random.default_rng(42);local x=r:binomial(1000000000000,np.array({1e-08,0.0001,0.5,0.9999,1.0},"float64"), {2,5});check(x,{2,5},{{9818,99993838,499999521527,999899999353,1000000000000},{9946,99983692,500000085604,999900011004,1000000000000}},"c744240fad8c19b0",r) end
do local r=np.random.default_rng(42);local x=r:binomial(1000000000000,np.array({1e-08,0.0001,0.5,0.9999,1.0},"float64"), {0,5});check(x,{0,5},{},"c621fbcd16d92688",r) end
do local r=np.random.default_rng(42);local x=r:binomial(np.array(6,"int64"),np.array(0.23,"float64"));check(x,{},2,"705a5661a791ffc1",r) end
do local r=np.random.default_rng(42);local x=r:binomial(np.array(6,"int64"),np.array(0.23,"float64"), {2});check(x,{2},{2,1},"dbcd12c26eda1624",r) end
do local r=np.random.default_rng(42);local x=r:binomial(np.array(6,"int64"),np.array(0.23,"float64"), {0});check(x,{0},{},"c621fbcd16d92688",r) end
do local r=np.random.default_rng(42);local x=r:binomial(30,0.5);check(x,{},17,"705a5661a791ffc1",r) end
do local r=np.random.default_rng(42);local x=r:binomial(30,0.5, {2});check(x,{2},{17,15},"dbcd12c26eda1624",r) end
do local r=np.random.default_rng(42);local x=r:binomial(30,0.5, {0});check(x,{0},{},"c621fbcd16d92688",r) end
do local r=np.random.default_rng(42);local x=r:binomial(0,np.array({0.0,0.4,1.0},"float64"));check(x,{3},{0,0,0},"c621fbcd16d92688",r) end
do local r=np.random.default_rng(42);local x=r:binomial(0,np.array({0.0,0.4,1.0},"float64"), {2,3});check(x,{2,3},{{0,0,0},{0,0,0}},"c621fbcd16d92688",r) end
do local r=np.random.default_rng(42);local x=r:binomial(0,np.array({0.0,0.4,1.0},"float64"), {0,3});check(x,{0,3},{},"c621fbcd16d92688",r) end
do local r=np.random.default_rng(42);local x=r:binomial(np.array({0,1,2,3,4},"int64"),np.array({1.0,1.0,1.0,1.0,1.0},"float64"));check(x,{5},{0,1,2,3,4},"181c01b5339381eb",r) end
do local r=np.random.default_rng(42);local x=r:binomial(np.array({0,1,2,3,4},"int64"),np.array({1.0,1.0,1.0,1.0,1.0},"float64"), {2,5});check(x,{2,5},{{0,1,2,3,4},{0,1,2,3,4}},"20cc0e168362d113",r) end
do local r=np.random.default_rng(42);local x=r:binomial(np.array({0,1,2,3,4},"int64"),np.array({1.0,1.0,1.0,1.0,1.0},"float64"), {0,5});check(x,{0,5},{},"c621fbcd16d92688",r) end
do local r=np.random.default_rng(42);local x=r:negative_binomial(np.array({0.1,0.5,1.0,2.5,5.0,20.0},"float64"),0.5);check(x,{6},{0,3,1,1,9,19},"7834cf45138b3a1f",r) end
do local r=np.random.default_rng(42);local x=r:negative_binomial(np.array({0.1,0.5,1.0,2.5,5.0,20.0},"float64"),0.5, {2,6});check(x,{2,6},{{0,3,1,1,9,19},{0,0,2,1,3,13}},"23c9bc6f098a05db",r) end
do local r=np.random.default_rng(42);local x=r:negative_binomial(np.array({0.1,0.5,1.0,2.5,5.0,20.0},"float64"),0.5, {0,6});check(x,{0,6},{},"c621fbcd16d92688",r) end
do local r=np.random.default_rng(42);local x=r:negative_binomial(np.array({{0.1},{0.5},{1.2},{20.0}},"float64"),np.array({{0.01,0.1,0.5,0.95,1.0}},"float64"));check(x,{4,5},{{10,0,0,0,0},{80,0,0,0,0},{158,7,0,0,0},{2189,156,12,2,0}},"05d0755b55941fbd",r) end
do local r=np.random.default_rng(42);local x=r:negative_binomial(np.array({{0.1},{0.5},{1.2},{20.0}},"float64"),np.array({{0.01,0.1,0.5,0.95,1.0}},"float64"), {2,4,5});check(x,{2,4,5},{{{10,0,0,0,0},{80,0,0,0,0},{158,7,0,0,0},{2189,156,12,2,0}},{{0,0,0,0,0},{2,36,0,0,0},{48,4,3,1,0},{3070,100,12,0,0}}},"c4c614fff052a825",r) end
do local r=np.random.default_rng(42);local x=r:negative_binomial(np.array({{0.1},{0.5},{1.2},{20.0}},"float64"),np.array({{0.01,0.1,0.5,0.95,1.0}},"float64"), {0,4,5});check(x,{0,4,5},{},"c621fbcd16d92688",r) end
do local r=np.random.default_rng(42);local x=r:negative_binomial(np.flip(np.array({{1.3,2.8},{3.5,8.5}},"float64"),2),0.4);check(x,{2,2},{{6,2},{15,8}},"aedc4bd3be4de22b",r) end
do local r=np.random.default_rng(42);local x=r:negative_binomial(np.flip(np.array({{1.3,2.8},{3.5,8.5}},"float64"),2),0.4, {2,2,2});check(x,{2,2,2},{{{6,2},{15,8}},{{5,1},{19,2}}},"c973e041cbfde031",r) end
do local r=np.random.default_rng(42);local x=r:negative_binomial(np.flip(np.array({{1.3,2.8},{3.5,8.5}},"float64"),2),0.4, {0,2,2});check(x,{0,2,2},{},"c621fbcd16d92688",r) end
do local r=np.random.default_rng(42);local x=r:negative_binomial(10.0,np.array({0.001,0.01,0.1,0.5,1.0},"float32"));check(x,{5},{10761,491,83,12,0},"aedc4bd3be4de22b",r) end
do local r=np.random.default_rng(42);local x=r:negative_binomial(10.0,np.array({0.001,0.01,0.1,0.5,1.0},"float32"), {2,5});check(x,{2,5},{{10761,491,83,12,0},{11019,1346,118,15,0}},"23c6d19aa302d2b1",r) end
do local r=np.random.default_rng(42);local x=r:negative_binomial(10.0,np.array({0.001,0.01,0.1,0.5,1.0},"float32"), {0,5});check(x,{0,5},{},"c621fbcd16d92688",r) end
do local r=np.random.default_rng(42);local x=r:negative_binomial(np.transpose(np.array({{3.0,20.0},{30.0,40.0}},"float32")),0.12);check(x,{2,2},{{29,158},{139,291}},"8df944c317963822",r) end
do local r=np.random.default_rng(42);local x=r:negative_binomial(np.transpose(np.array({{3.0,20.0},{30.0,40.0}},"float32")),0.12, {2,2,2});check(x,{2,2,2},{{{29,158},{139,291}},{{30,223},{147,391}}},"7834cf45138b3a1f",r) end
do local r=np.random.default_rng(42);local x=r:negative_binomial(np.transpose(np.array({{3.0,20.0},{30.0,40.0}},"float32")),0.12, {0,2,2});check(x,{0,2,2},{},"c621fbcd16d92688",r) end
do local r=np.random.default_rng(42);local x=r:negative_binomial(np.array({0.1,1.2,3.7},"float64"),np.array({0.9,0.5,0.2},"float64"));check(x,{3},{0,3,10},"f87faa6d11633489",r) end
do local r=np.random.default_rng(42);local x=r:negative_binomial(np.array({0.1,1.2,3.7},"float64"),np.array({0.9,0.5,0.2},"float64"), {2,3});check(x,{2,3},{{0,3,10},{0,0,14}},"7834cf45138b3a1f",r) end
do local r=np.random.default_rng(42);local x=r:negative_binomial(np.array({0.1,1.2,3.7},"float64"),np.array({0.9,0.5,0.2},"float64"), {0,3});check(x,{0,3},{},"c621fbcd16d92688",r) end
do local r=np.random.default_rng(42);local x=r:negative_binomial(np.array({4,10,100,1000},"int64"),np.array({0.95,0.75,0.5,0.1},"float64"));check(x,{4},{1,2,109,9240},"105653e3e34cbfaf",r) end
do local r=np.random.default_rng(42);local x=r:negative_binomial(np.array({4,10,100,1000},"int64"),np.array({0.95,0.75,0.5,0.1},"float64"), {2,4});check(x,{2,4},{{1,2,109,9240},{0,5,98,9049}},"3a16bb295487bf35",r) end
do local r=np.random.default_rng(42);local x=r:negative_binomial(np.array({4,10,100,1000},"int64"),np.array({0.95,0.75,0.5,0.1},"float64"), {0,4});check(x,{0,4},{},"c621fbcd16d92688",r) end
do local r=np.random.default_rng(42);local x=r:negative_binomial(np.array({{10,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2));check(x,{2,2},{{0,33},{106,7}},"105653e3e34cbfaf",r) end
do local r=np.random.default_rng(42);local x=r:negative_binomial(np.array({{10,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2), {2,2,2});check(x,{2,2,2},{{{0,33},{106,7}},{{0,21},{96,10}}},"7834cf45138b3a1f",r) end
do local r=np.random.default_rng(42);local x=r:negative_binomial(np.array({{10,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2), {0,2,2});check(x,{0,2,2},{},"c621fbcd16d92688",r) end
do local r=np.random.default_rng(42);local x=r:negative_binomial(1000.0,np.array({0.01,0.05,0.5,0.999,1.0},"float64"));check(x,{5},{100311,17952,987,1,0},"d3dfa2f0dbb8fa6e",r) end
do local r=np.random.default_rng(42);local x=r:negative_binomial(1000.0,np.array({0.01,0.05,0.5,0.999,1.0},"float64"), {2,5});check(x,{2,5},{{100311,17952,987,1,0},{101993,19859,979,0,0}},"308131eacbb1aed0",r) end
do local r=np.random.default_rng(42);local x=r:negative_binomial(1000.0,np.array({0.01,0.05,0.5,0.999,1.0},"float64"), {0,5});check(x,{0,5},{},"c621fbcd16d92688",r) end
do local r=np.random.default_rng(42);local x=r:negative_binomial(np.array(6.0,"float64"),np.array(0.23,"float64"));check(x,{},27,"181c01b5339381eb",r) end
do local r=np.random.default_rng(42);local x=r:negative_binomial(np.array(6.0,"float64"),np.array(0.23,"float64"), {2});check(x,{2},{27,14},"5eec9e8b80171029",r) end
do local r=np.random.default_rng(42);local x=r:negative_binomial(np.array(6.0,"float64"),np.array(0.23,"float64"), {0});check(x,{0},{},"c621fbcd16d92688",r) end
do local r=np.random.default_rng(42);local x=r:negative_binomial(30.0,0.5);check(x,{},38,"181c01b5339381eb",r) end
do local r=np.random.default_rng(42);local x=r:negative_binomial(30.0,0.5, {2});check(x,{2},{38,14},"5eec9e8b80171029",r) end
do local r=np.random.default_rng(42);local x=r:negative_binomial(30.0,0.5, {0});check(x,{0},{},"c621fbcd16d92688",r) end
do local r=np.random.default_rng(42);local x=r:negative_binomial(np.array({0.5,1.0,2.0,4.0},"float64"),np.array({1.0,1.0,1.0,1.0},"float64"));check(x,{4},{0,0,0,0},"c93b82a3b7ac9740",r) end
do local r=np.random.default_rng(42);local x=r:negative_binomial(np.array({0.5,1.0,2.0,4.0},"float64"),np.array({1.0,1.0,1.0,1.0},"float64"), {2,4});check(x,{2,4},{{0,0,0,0},{0,0,0,0}},"718397ca8ba13e23",r) end
do local r=np.random.default_rng(42);local x=r:negative_binomial(np.array({0.5,1.0,2.0,4.0},"float64"),np.array({1.0,1.0,1.0,1.0},"float64"), {0,4});check(x,{0,4},{},"c621fbcd16d92688",r) end
do local r=np.random.default_rng(1234);local x=r:binomial(np.array({0,1,2,10,100,1000},"int64"),0.4);check(x,{6},{0,1,1,6,42,398},"518b7086c93af29b",r) end
do local r=np.random.default_rng(1234);local x=r:binomial(np.array({0,1,2,10,100,1000},"int64"),0.4, {2,6});check(x,{2,6},{{0,1,1,6,42,398},{0,0,2,3,34,410}},"bc5a9dd40c192770",r) end
do local r=np.random.default_rng(1234);local x=r:binomial(np.array({0,1,2,10,100,1000},"int64"),0.4, {0,6});check(x,{0,6},{},"fa08fef3fab6bbba",r) end
do local r=np.random.default_rng(1234);local x=r:binomial(np.array({{0},{1},{10},{50}},"int64"),np.array({{0.0,0.01,0.5,0.99,1.0}},"float64"));check(x,{4,5},{{0,0,0,0,0},{0,0,0,1,1},{0,0,3,10,10},{0,2,23,50,50}},"dd164908e5a8465d",r) end
do local r=np.random.default_rng(1234);local x=r:binomial(np.array({{0},{1},{10},{50}},"int64"),np.array({{0.0,0.01,0.5,0.99,1.0}},"float64"), {2,4,5});check(x,{2,4,5},{{{0,0,0,0,0},{0,0,0,1,1},{0,0,3,10,10},{0,2,23,50,50}},{{0,0,0,0,0},{0,0,1,1,1},{0,0,4,10,10},{0,0,27,49,50}}},"0f6528af8c7a1ee5",r) end
do local r=np.random.default_rng(1234);local x=r:binomial(np.array({{0},{1},{10},{50}},"int64"),np.array({{0.0,0.01,0.5,0.99,1.0}},"float64"), {0,4,5});check(x,{0,4,5},{},"fa08fef3fab6bbba",r) end
do local r=np.random.default_rng(1234);local x=r:binomial(np.flip(np.array({{4,9,13},{20,30,50}},"int64"),2),0.3);check(x,{2,3},{{7,2,3},{13,8,4}},"3de46552cbbd5187",r) end
do local r=np.random.default_rng(1234);local x=r:binomial(np.flip(np.array({{4,9,13},{20,30,50}},"int64"),2),0.3, {2,2,3});check(x,{2,2,3},{{{7,2,3},{13,8,4}},{{3,2,3},{13,9,7}}},"dd164908e5a8465d",r) end
do local r=np.random.default_rng(1234);local x=r:binomial(np.flip(np.array({{4,9,13},{20,30,50}},"int64"),2),0.3, {0,2,3});check(x,{0,2,3},{},"fa08fef3fab6bbba",r) end
do local r=np.random.default_rng(1234);local x=r:binomial(100,np.array({0.0,0.1,0.5,0.9,1.0},"float32"));check(x,{5},{0,16,49,92,100},"1e3b3a1f893a76fa",r) end
do local r=np.random.default_rng(1234);local x=r:binomial(100,np.array({0.0,0.1,0.5,0.9,1.0},"float32"), {2,5});check(x,{2,5},{{0,16,49,92,100},{0,7,52,84,100}},"70e5c6f78e3cdf30",r) end
do local r=np.random.default_rng(1234);local x=r:binomial(100,np.array({0.0,0.1,0.5,0.9,1.0},"float32"), {0,5});check(x,{0,5},{},"fa08fef3fab6bbba",r) end
do local r=np.random.default_rng(1234);local x=r:binomial(np.transpose(np.array({{10,20},{30,40}},"int64")),0.12);check(x,{2,2},{{4,3},{5,3}},"51b0584623871e84",r) end
do local r=np.random.default_rng(1234);local x=r:binomial(np.transpose(np.array({{10,20},{30,40}},"int64")),0.12, {2,2,2});check(x,{2,2,2},{{{4,3},{5,3}},{{1,2},{1,4}}},"f6cde5bccb224bdc",r) end
do local r=np.random.default_rng(1234);local x=r:binomial(np.transpose(np.array({{10,20},{30,40}},"int64")),0.12, {0,2,2});check(x,{0,2,2},{},"fa08fef3fab6bbba",r) end
do local r=np.random.default_rng(1234);local x=r:binomial(np.array({3,13,25},"int64"),np.array({0.15,0.5,0.95},"float64"));check(x,{3},{2,6,22},"42fe46521ada3e8e",r) end
do local r=np.random.default_rng(1234);local x=r:binomial(np.array({3,13,25},"int64"),np.array({0.15,0.5,0.95},"float64"), {2,3});check(x,{2,3},{{2,6,22},{0,6,25}},"3de46552cbbd5187",r) end
do local r=np.random.default_rng(1234);local x=r:binomial(np.array({3,13,25},"int64"),np.array({0.15,0.5,0.95},"float64"), {0,3});check(x,{0,3},{},"fa08fef3fab6bbba",r) end
do local r=np.random.default_rng(1234);local x=r:binomial(np.array({4,100,1000,100000},"int64"),np.array({0.05,0.75,0.5,0.001},"float64"));check(x,{4},{1,76,527,108},"3de46552cbbd5187",r) end
do local r=np.random.default_rng(1234);local x=r:binomial(np.array({4,100,1000,100000},"int64"),np.array({0.05,0.75,0.5,0.001},"float64"), {2,4});check(x,{2,4},{{1,76,527,108},{0,77,501,102}},"2c0c878bddf96848",r) end
do local r=np.random.default_rng(1234);local x=r:binomial(np.array({4,100,1000,100000},"int64"),np.array({0.05,0.75,0.5,0.001},"float64"), {0,4});check(x,{0,4},{},"fa08fef3fab6bbba",r) end
do local r=np.random.default_rng(1234);local x=r:binomial(np.array({{100,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2));check(x,{2,2},{{97,1},{21,20}},"51b0584623871e84",r) end
do local r=np.random.default_rng(1234);local x=r:binomial(np.array({{100,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2), {2,2,2});check(x,{2,2,2},{{{97,1},{21,20}},{{100,0},{14,20}}},"f6cde5bccb224bdc",r) end
do local r=np.random.default_rng(1234);local x=r:binomial(np.array({{100,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2), {0,2,2});check(x,{0,2,2},{},"fa08fef3fab6bbba",r) end
do local r=np.random.default_rng(1234);local x=r:binomial(1000000000000,np.array({1e-08,0.0001,0.5,0.9999,1.0},"float64"));check(x,{5},{10066,100000032,499998598827,999900000574,1000000000000},"dd1f3903a55ea874",r) end
do local r=np.random.default_rng(1234);local x=r:binomial(1000000000000,np.array({1e-08,0.0001,0.5,0.9999,1.0},"float64"), {2,5});check(x,{2,5},{{10066,100000032,499998598827,999900000574,1000000000000},{10031,100002694,500000148267,999899994871,1000000000000}},"0f6528af8c7a1ee5",r) end
do local r=np.random.default_rng(1234);local x=r:binomial(1000000000000,np.array({1e-08,0.0001,0.5,0.9999,1.0},"float64"), {0,5});check(x,{0,5},{},"fa08fef3fab6bbba",r) end
do local r=np.random.default_rng(1234);local x=r:binomial(np.array(6,"int64"),np.array(0.23,"float64"));check(x,{},4,"615481f7fce9ac81",r) end
do local r=np.random.default_rng(1234);local x=r:binomial(np.array(6,"int64"),np.array(0.23,"float64"), {2});check(x,{2},{4,1},"ec59dd7c2bde3cb4",r) end
do local r=np.random.default_rng(1234);local x=r:binomial(np.array(6,"int64"),np.array(0.23,"float64"), {0});check(x,{0},{},"fa08fef3fab6bbba",r) end
do local r=np.random.default_rng(1234);local x=r:binomial(30,0.5);check(x,{},20,"615481f7fce9ac81",r) end
do local r=np.random.default_rng(1234);local x=r:binomial(30,0.5, {2});check(x,{2},{20,14},"ec59dd7c2bde3cb4",r) end
do local r=np.random.default_rng(1234);local x=r:binomial(30,0.5, {0});check(x,{0},{},"fa08fef3fab6bbba",r) end
do local r=np.random.default_rng(1234);local x=r:binomial(0,np.array({0.0,0.4,1.0},"float64"));check(x,{3},{0,0,0},"fa08fef3fab6bbba",r) end
do local r=np.random.default_rng(1234);local x=r:binomial(0,np.array({0.0,0.4,1.0},"float64"), {2,3});check(x,{2,3},{{0,0,0},{0,0,0}},"fa08fef3fab6bbba",r) end
do local r=np.random.default_rng(1234);local x=r:binomial(0,np.array({0.0,0.4,1.0},"float64"), {0,3});check(x,{0,3},{},"fa08fef3fab6bbba",r) end
do local r=np.random.default_rng(1234);local x=r:binomial(np.array({0,1,2,3,4},"int64"),np.array({1.0,1.0,1.0,1.0,1.0},"float64"));check(x,{5},{0,1,2,3,4},"51b0584623871e84",r) end
do local r=np.random.default_rng(1234);local x=r:binomial(np.array({0,1,2,3,4},"int64"),np.array({1.0,1.0,1.0,1.0,1.0},"float64"), {2,5});check(x,{2,5},{{0,1,2,3,4},{0,1,2,3,4}},"f6cde5bccb224bdc",r) end
do local r=np.random.default_rng(1234);local x=r:binomial(np.array({0,1,2,3,4},"int64"),np.array({1.0,1.0,1.0,1.0,1.0},"float64"), {0,5});check(x,{0,5},{},"fa08fef3fab6bbba",r) end
do local r=np.random.default_rng(1234);local x=r:negative_binomial(np.array({0.1,0.5,1.0,2.5,5.0,20.0},"float64"),0.5);check(x,{6},{2,0,1,5,1,15},"40530a80a54ed65d",r) end
do local r=np.random.default_rng(1234);local x=r:negative_binomial(np.array({0.1,0.5,1.0,2.5,5.0,20.0},"float64"),0.5, {2,6});check(x,{2,6},{{2,0,1,5,1,15},{0,0,0,2,2,23}},"bbb511ca2bbbba92",r) end
do local r=np.random.default_rng(1234);local x=r:negative_binomial(np.array({0.1,0.5,1.0,2.5,5.0,20.0},"float64"),0.5, {0,6});check(x,{0,6},{},"fa08fef3fab6bbba",r) end
do local r=np.random.default_rng(1234);local x=r:negative_binomial(np.array({{0.1},{0.5},{1.2},{20.0}},"float64"),np.array({{0.01,0.1,0.5,0.95,1.0}},"float64"));check(x,{4,5},{{177,0,0,0,0},{41,14,1,0,0},{37,22,0,0,0},{1807,126,23,1,0}},"573b0dc4071d98cc",r) end
do local r=np.random.default_rng(1234);local x=r:negative_binomial(np.array({{0.1},{0.5},{1.2},{20.0}},"float64"),np.array({{0.01,0.1,0.5,0.95,1.0}},"float64"), {2,4,5});check(x,{2,4,5},{{{177,0,0,0,0},{41,14,1,0,0},{37,22,0,0,0},{1807,126,23,1,0}},{{0,0,0,0,0},{7,0,0,0,0},{194,4,1,0,0},{3040,179,28,0,0}}},"082af15f3d3e3687",r) end
do local r=np.random.default_rng(1234);local x=r:negative_binomial(np.array({{0.1},{0.5},{1.2},{20.0}},"float64"),np.array({{0.01,0.1,0.5,0.95,1.0}},"float64"), {0,4,5});check(x,{0,4,5},{},"fa08fef3fab6bbba",r) end
do local r=np.random.default_rng(1234);local x=r:negative_binomial(np.flip(np.array({{1.3,2.8},{3.5,8.5}},"float64"),2),0.4);check(x,{2,2},{{1,3},{12,2}},"af063c81298eafcb",r) end
do local r=np.random.default_rng(1234);local x=r:negative_binomial(np.flip(np.array({{1.3,2.8},{3.5,8.5}},"float64"),2),0.4, {2,2,2});check(x,{2,2,2},{{{1,3},{12,2}},{{1,0},{16,11}}},"5ed9a3f4c1e64b84",r) end
do local r=np.random.default_rng(1234);local x=r:negative_binomial(np.flip(np.array({{1.3,2.8},{3.5,8.5}},"float64"),2),0.4, {0,2,2});check(x,{0,2,2},{},"fa08fef3fab6bbba",r) end
do local r=np.random.default_rng(1234);local x=r:negative_binomial(10.0,np.array({0.001,0.01,0.1,0.5,1.0},"float32"));check(x,{5},{5613,1220,47,16,0},"2c0c878bddf96848",r) end
do local r=np.random.default_rng(1234);local x=r:negative_binomial(10.0,np.array({0.001,0.01,0.1,0.5,1.0},"float32"), {2,5});check(x,{2,5},{{5613,1220,47,16,0},{10857,1036,98,8,0}},"de7cc801c29645a3",r) end
do local r=np.random.default_rng(1234);local x=r:negative_binomial(10.0,np.array({0.001,0.01,0.1,0.5,1.0},"float32"), {0,5});check(x,{0,5},{},"fa08fef3fab6bbba",r) end
do local r=np.random.default_rng(1234);local x=r:negative_binomial(np.transpose(np.array({{3.0,20.0},{30.0,40.0}},"float32")),0.12);check(x,{2,2},{{4,246},{198,221}},"af063c81298eafcb",r) end
do local r=np.random.default_rng(1234);local x=r:negative_binomial(np.transpose(np.array({{3.0,20.0},{30.0,40.0}},"float32")),0.12, {2,2,2});check(x,{2,2,2},{{{4,246},{198,221}},{{5,215},{178,223}}},"f9f66fc5dd86b390",r) end
do local r=np.random.default_rng(1234);local x=r:negative_binomial(np.transpose(np.array({{3.0,20.0},{30.0,40.0}},"float32")),0.12, {0,2,2});check(x,{0,2,2},{},"fa08fef3fab6bbba",r) end
do local r=np.random.default_rng(1234);local x=r:negative_binomial(np.array({0.1,1.2,3.7},"float64"),np.array({0.9,0.5,0.2},"float64"));check(x,{3},{1,1,8},"ded38400c9e966a5",r) end
do local r=np.random.default_rng(1234);local x=r:negative_binomial(np.array({0.1,1.2,3.7},"float64"),np.array({0.9,0.5,0.2},"float64"), {2,3});check(x,{2,3},{{1,1,8},{0,2,13}},"ec0b0635b2eb2214",r) end
do local r=np.random.default_rng(1234);local x=r:negative_binomial(np.array({0.1,1.2,3.7},"float64"),np.array({0.9,0.5,0.2},"float64"), {0,3});check(x,{0,3},{},"fa08fef3fab6bbba",r) end
do local r=np.random.default_rng(1234);local x=r:negative_binomial(np.array({4,10,100,1000},"int64"),np.array({0.95,0.75,0.5,0.1},"float64"));check(x,{4},{0,1,102,9424},"3906623cbd19a9f2",r) end
do local r=np.random.default_rng(1234);local x=r:negative_binomial(np.array({4,10,100,1000},"int64"),np.array({0.95,0.75,0.5,0.1},"float64"), {2,4});check(x,{2,4},{{0,1,102,9424},{0,4,95,8986}},"fe04b36bcdb113ee",r) end
do local r=np.random.default_rng(1234);local x=r:negative_binomial(np.array({4,10,100,1000},"int64"),np.array({0.95,0.75,0.5,0.1},"float64"), {0,4});check(x,{0,4},{},"fa08fef3fab6bbba",r) end
do local r=np.random.default_rng(1234);local x=r:negative_binomial(np.array({{10,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2));check(x,{2,2},{{0,14},{107,12}},"3906623cbd19a9f2",r) end
do local r=np.random.default_rng(1234);local x=r:negative_binomial(np.array({{10,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2), {2,2,2});check(x,{2,2,2},{{{0,14},{107,12}},{{0,26},{117,9}}},"d438a2de6e88305e",r) end
do local r=np.random.default_rng(1234);local x=r:negative_binomial(np.array({{10,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2), {0,2,2});check(x,{0,2,2},{},"fa08fef3fab6bbba",r) end
do local r=np.random.default_rng(1234);local x=r:negative_binomial(1000.0,np.array({0.01,0.05,0.5,0.999,1.0},"float64"));check(x,{5},{94572,19407,943,2,0},"ded38400c9e966a5",r) end
do local r=np.random.default_rng(1234);local x=r:negative_binomial(1000.0,np.array({0.01,0.05,0.5,0.999,1.0},"float64"), {2,5});check(x,{2,5},{{94572,19407,943,2,0},{104666,19471,993,1,0}},"77dca84ce103cfa3",r) end
do local r=np.random.default_rng(1234);local x=r:negative_binomial(1000.0,np.array({0.01,0.05,0.5,0.999,1.0},"float64"), {0,5});check(x,{0,5},{},"fa08fef3fab6bbba",r) end
do local r=np.random.default_rng(1234);local x=r:negative_binomial(np.array(6.0,"float64"),np.array(0.23,"float64"));check(x,{},8,"9c207e4d41353802",r) end
do local r=np.random.default_rng(1234);local x=r:negative_binomial(np.array(6.0,"float64"),np.array(0.23,"float64"), {2});check(x,{2},{8,34},"3906623cbd19a9f2",r) end
do local r=np.random.default_rng(1234);local x=r:negative_binomial(np.array(6.0,"float64"),np.array(0.23,"float64"), {0});check(x,{0},{},"fa08fef3fab6bbba",r) end
do local r=np.random.default_rng(1234);local x=r:negative_binomial(30.0,0.5);check(x,{},30,"51b0584623871e84",r) end
do local r=np.random.default_rng(1234);local x=r:negative_binomial(30.0,0.5, {2});check(x,{2},{30,30},"f6cde5bccb224bdc",r) end
do local r=np.random.default_rng(1234);local x=r:negative_binomial(30.0,0.5, {0});check(x,{0},{},"fa08fef3fab6bbba",r) end
do local r=np.random.default_rng(1234);local x=r:negative_binomial(np.array({0.5,1.0,2.0,4.0},"float64"),np.array({1.0,1.0,1.0,1.0},"float64"));check(x,{4},{0,0,0,0},"437e8db6f5550efb",r) end
do local r=np.random.default_rng(1234);local x=r:negative_binomial(np.array({0.5,1.0,2.0,4.0},"float64"),np.array({1.0,1.0,1.0,1.0},"float64"), {2,4});check(x,{2,4},{{0,0,0,0},{0,0,0,0}},"bc5a9dd40c192770",r) end
do local r=np.random.default_rng(1234);local x=r:negative_binomial(np.array({0.5,1.0,2.0,4.0},"float64"),np.array({1.0,1.0,1.0,1.0},"float64"), {0,4});check(x,{0,4},{},"fa08fef3fab6bbba",r) end
do local r=np.random.default_rng(840084);local x=r:binomial(np.array({0,1,2,10,100,1000},"int64"),0.4);check(x,{6},{0,1,2,4,46,388},"09c4a2fedeeee731",r) end
do local r=np.random.default_rng(840084);local x=r:binomial(np.array({0,1,2,10,100,1000},"int64"),0.4, {2,6});check(x,{2,6},{{0,1,2,4,46,388},{0,0,1,4,42,408}},"9a934c4540252525",r) end
do local r=np.random.default_rng(840084);local x=r:binomial(np.array({0,1,2,10,100,1000},"int64"),0.4, {0,6});check(x,{0,6},{},"a10e5f36b2c66e67",r) end
do local r=np.random.default_rng(840084);local x=r:binomial(np.array({{0},{1},{10},{50}},"int64"),np.array({{0.0,0.01,0.5,0.99,1.0}},"float64"));check(x,{4,5},{{0,0,0,0,0},{0,0,1,1,1},{0,0,9,10,10},{0,0,21,50,50}},"a8874cecedeb172c",r) end
do local r=np.random.default_rng(840084);local x=r:binomial(np.array({{0},{1},{10},{50}},"int64"),np.array({{0.0,0.01,0.5,0.99,1.0}},"float64"), {2,4,5});check(x,{2,4,5},{{{0,0,0,0,0},{0,0,1,1,1},{0,0,9,10,10},{0,0,21,50,50}},{{0,0,0,0,0},{0,0,0,1,1},{0,0,3,10,10},{0,0,22,50,50}}},"c20501570f134a1b",r) end
do local r=np.random.default_rng(840084);local x=r:binomial(np.array({{0},{1},{10},{50}},"int64"),np.array({{0.0,0.01,0.5,0.99,1.0}},"float64"), {0,4,5});check(x,{0,4,5},{},"a10e5f36b2c66e67",r) end
do local r=np.random.default_rng(840084);local x=r:binomial(np.flip(np.array({{4,9,13},{20,30,50}},"int64"),2),0.3);check(x,{2,3},{{4,5,1},{18,11,12}},"2a515d2b9731000b",r) end
do local r=np.random.default_rng(840084);local x=r:binomial(np.flip(np.array({{4,9,13},{20,30,50}},"int64"),2),0.3, {2,2,3});check(x,{2,2,3},{{{4,5,1},{18,11,12}},{{2,4,1},{11,9,3}}},"a8874cecedeb172c",r) end
do local r=np.random.default_rng(840084);local x=r:binomial(np.flip(np.array({{4,9,13},{20,30,50}},"int64"),2),0.3, {0,2,3});check(x,{0,2,3},{},"a10e5f36b2c66e67",r) end
do local r=np.random.default_rng(840084);local x=r:binomial(100,np.array({0.0,0.1,0.5,0.9,1.0},"float32"));check(x,{5},{0,11,55,93,100},"09c4a2fedeeee731",r) end
do local r=np.random.default_rng(840084);local x=r:binomial(100,np.array({0.0,0.1,0.5,0.9,1.0},"float32"), {2,5});check(x,{2,5},{{0,11,55,93,100},{0,5,48,93,100}},"7e993913160d68db",r) end
do local r=np.random.default_rng(840084);local x=r:binomial(100,np.array({0.0,0.1,0.5,0.9,1.0},"float32"), {0,5});check(x,{0,5},{},"a10e5f36b2c66e67",r) end
do local r=np.random.default_rng(840084);local x=r:binomial(np.transpose(np.array({{10,20},{30,40}},"int64")),0.12);check(x,{2,2},{{1,6},{2,6}},"cba9cff48a89169e",r) end
do local r=np.random.default_rng(840084);local x=r:binomial(np.transpose(np.array({{10,20},{30,40}},"int64")),0.12, {2,2,2});check(x,{2,2,2},{{{1,6},{2,6}},{{2,9},{1,6}}},"4cc36af8d6de87a8",r) end
do local r=np.random.default_rng(840084);local x=r:binomial(np.transpose(np.array({{10,20},{30,40}},"int64")),0.12, {0,2,2});check(x,{0,2,2},{},"a10e5f36b2c66e67",r) end
do local r=np.random.default_rng(840084);local x=r:binomial(np.array({3,13,25},"int64"),np.array({0.15,0.5,0.95},"float64"));check(x,{3},{1,9,24},"cb11d36ac2e8f092",r) end
do local r=np.random.default_rng(840084);local x=r:binomial(np.array({3,13,25},"int64"),np.array({0.15,0.5,0.95},"float64"), {2,3});check(x,{2,3},{{1,9,24},{1,8,20}},"2a515d2b9731000b",r) end
do local r=np.random.default_rng(840084);local x=r:binomial(np.array({3,13,25},"int64"),np.array({0.15,0.5,0.95},"float64"), {0,3});check(x,{0,3},{},"a10e5f36b2c66e67",r) end
do local r=np.random.default_rng(840084);local x=r:binomial(np.array({4,100,1000,100000},"int64"),np.array({0.05,0.75,0.5,0.001},"float64"));check(x,{4},{0,69,500,92},"4cc36af8d6de87a8",r) end
do local r=np.random.default_rng(840084);local x=r:binomial(np.array({4,100,1000,100000},"int64"),np.array({0.05,0.75,0.5,0.001},"float64"), {2,4});check(x,{2,4},{{0,69,500,92},{0,80,525,94}},"9b2ba235b98cca7a",r) end
do local r=np.random.default_rng(840084);local x=r:binomial(np.array({4,100,1000,100000},"int64"),np.array({0.05,0.75,0.5,0.001},"float64"), {0,4});check(x,{0,4},{},"a10e5f36b2c66e67",r) end
do local r=np.random.default_rng(840084);local x=r:binomial(np.array({{100,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2));check(x,{2,2},{{99,2},{17,17}},"cba9cff48a89169e",r) end
do local r=np.random.default_rng(840084);local x=r:binomial(np.array({{100,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2), {2,2,2});check(x,{2,2,2},{{{99,2},{17,17}},{{98,4},{13,17}}},"4cc36af8d6de87a8",r) end
do local r=np.random.default_rng(840084);local x=r:binomial(np.array({{100,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2), {0,2,2});check(x,{0,2,2},{},"a10e5f36b2c66e67",r) end
do local r=np.random.default_rng(840084);local x=r:binomial(1000000000000,np.array({1e-08,0.0001,0.5,0.9999,1.0},"float64"));check(x,{5},{9984,99998474,499999389013,999899994024,1000000000000},"09c4a2fedeeee731",r) end
do local r=np.random.default_rng(840084);local x=r:binomial(1000000000000,np.array({1e-08,0.0001,0.5,0.9999,1.0},"float64"), {2,5});check(x,{2,5},{{9984,99998474,499999389013,999899994024,1000000000000},{9870,99998360,500000215470,999900008826,1000000000000}},"9a934c4540252525",r) end
do local r=np.random.default_rng(840084);local x=r:binomial(1000000000000,np.array({1e-08,0.0001,0.5,0.9999,1.0},"float64"), {0,5});check(x,{0,5},{},"a10e5f36b2c66e67",r) end
do local r=np.random.default_rng(840084);local x=r:binomial(np.array(6,"int64"),np.array(0.23,"float64"));check(x,{},2,"e97849745a15da43",r) end
do local r=np.random.default_rng(840084);local x=r:binomial(np.array(6,"int64"),np.array(0.23,"float64"), {2});check(x,{2},{2,3},"8bf6b6d48351e732",r) end
do local r=np.random.default_rng(840084);local x=r:binomial(np.array(6,"int64"),np.array(0.23,"float64"), {0});check(x,{0},{},"a10e5f36b2c66e67",r) end
do local r=np.random.default_rng(840084);local x=r:binomial(30,0.5);check(x,{},16,"e97849745a15da43",r) end
do local r=np.random.default_rng(840084);local x=r:binomial(30,0.5, {2});check(x,{2},{16,19},"8bf6b6d48351e732",r) end
do local r=np.random.default_rng(840084);local x=r:binomial(30,0.5, {0});check(x,{0},{},"a10e5f36b2c66e67",r) end
do local r=np.random.default_rng(840084);local x=r:binomial(0,np.array({0.0,0.4,1.0},"float64"));check(x,{3},{0,0,0},"a10e5f36b2c66e67",r) end
do local r=np.random.default_rng(840084);local x=r:binomial(0,np.array({0.0,0.4,1.0},"float64"), {2,3});check(x,{2,3},{{0,0,0},{0,0,0}},"a10e5f36b2c66e67",r) end
do local r=np.random.default_rng(840084);local x=r:binomial(0,np.array({0.0,0.4,1.0},"float64"), {0,3});check(x,{0,3},{},"a10e5f36b2c66e67",r) end
do local r=np.random.default_rng(840084);local x=r:binomial(np.array({0,1,2,3,4},"int64"),np.array({1.0,1.0,1.0,1.0,1.0},"float64"));check(x,{5},{0,1,2,3,4},"cba9cff48a89169e",r) end
do local r=np.random.default_rng(840084);local x=r:binomial(np.array({0,1,2,3,4},"int64"),np.array({1.0,1.0,1.0,1.0,1.0},"float64"), {2,5});check(x,{2,5},{{0,1,2,3,4},{0,1,2,3,4}},"4cc36af8d6de87a8",r) end
do local r=np.random.default_rng(840084);local x=r:binomial(np.array({0,1,2,3,4},"int64"),np.array({1.0,1.0,1.0,1.0,1.0},"float64"), {0,5});check(x,{0,5},{},"a10e5f36b2c66e67",r) end
do local r=np.random.default_rng(840084);local x=r:negative_binomial(np.array({0.1,0.5,1.0,2.5,5.0,20.0},"float64"),0.5);check(x,{6},{0,1,1,3,2,10},"304e342848e236a3",r) end
do local r=np.random.default_rng(840084);local x=r:negative_binomial(np.array({0.1,0.5,1.0,2.5,5.0,20.0},"float64"),0.5, {2,6});check(x,{2,6},{{0,1,1,3,2,10},{0,0,3,0,6,19}},"a5eb93b4db3da3e3",r) end
do local r=np.random.default_rng(840084);local x=r:negative_binomial(np.array({0.1,0.5,1.0,2.5,5.0,20.0},"float64"),0.5, {0,6});check(x,{0,6},{},"a10e5f36b2c66e67",r) end
do local r=np.random.default_rng(840084);local x=r:negative_binomial(np.array({{0.1},{0.5},{1.2},{20.0}},"float64"),np.array({{0.01,0.1,0.5,0.95,1.0}},"float64"));check(x,{4,5},{{2,0,0,0,0},{0,0,7,0,0},{163,2,0,0,0},{1926,264,20,1,0}},"3b26717e76fc9971",r) end
do local r=np.random.default_rng(840084);local x=r:negative_binomial(np.array({{0.1},{0.5},{1.2},{20.0}},"float64"),np.array({{0.01,0.1,0.5,0.95,1.0}},"float64"), {2,4,5});check(x,{2,4,5},{{{2,0,0,0,0},{0,0,7,0,0},{163,2,0,0,0},{1926,264,20,1,0}},{{0,0,0,0,0},{13,17,0,0,0},{99,14,0,0,0},{1703,194,17,2,0}}},"b7b7e1aa3e502a37",r) end
do local r=np.random.default_rng(840084);local x=r:negative_binomial(np.array({{0.1},{0.5},{1.2},{20.0}},"float64"),np.array({{0.01,0.1,0.5,0.95,1.0}},"float64"), {0,4,5});check(x,{0,4,5},{},"a10e5f36b2c66e67",r) end
do local r=np.random.default_rng(840084);local x=r:negative_binomial(np.flip(np.array({{1.3,2.8},{3.5,8.5}},"float64"),2),0.4);check(x,{2,2},{{6,1},{4,3}},"f70bf9f487682fd0",r) end
do local r=np.random.default_rng(840084);local x=r:negative_binomial(np.flip(np.array({{1.3,2.8},{3.5,8.5}},"float64"),2),0.4, {2,2,2});check(x,{2,2,2},{{{6,1},{4,3}},{{2,1},{5,4}}},"03ba8a1a139cc9f4",r) end
do local r=np.random.default_rng(840084);local x=r:negative_binomial(np.flip(np.array({{1.3,2.8},{3.5,8.5}},"float64"),2),0.4, {0,2,2});check(x,{0,2,2},{},"a10e5f36b2c66e67",r) end
do local r=np.random.default_rng(840084);local x=r:negative_binomial(10.0,np.array({0.001,0.01,0.1,0.5,1.0},"float32"));check(x,{5},{9811,1129,69,7,0},"c20501570f134a1b",r) end
do local r=np.random.default_rng(840084);local x=r:negative_binomial(10.0,np.array({0.001,0.01,0.1,0.5,1.0},"float32"), {2,5});check(x,{2,5},{{9811,1129,69,7,0},{9734,558,105,19,0}},"661dd96bdea0e2ad",r) end
do local r=np.random.default_rng(840084);local x=r:negative_binomial(10.0,np.array({0.001,0.01,0.1,0.5,1.0},"float32"), {0,5});check(x,{0,5},{},"a10e5f36b2c66e67",r) end
do local r=np.random.default_rng(840084);local x=r:negative_binomial(np.transpose(np.array({{3.0,20.0},{30.0,40.0}},"float32")),0.12);check(x,{2,2},{{21,227},{124,285}},"1ee7a5a260a847bd",r) end
do local r=np.random.default_rng(840084);local x=r:negative_binomial(np.transpose(np.array({{3.0,20.0},{30.0,40.0}},"float32")),0.12, {2,2,2});check(x,{2,2,2},{{{21,227},{124,285}},{{4,131},{174,372}}},"bc39d8bc117f3b1b",r) end
do local r=np.random.default_rng(840084);local x=r:negative_binomial(np.transpose(np.array({{3.0,20.0},{30.0,40.0}},"float32")),0.12, {0,2,2});check(x,{0,2,2},{},"a10e5f36b2c66e67",r) end
do local r=np.random.default_rng(840084);local x=r:negative_binomial(np.array({0.1,1.2,3.7},"float64"),np.array({0.9,0.5,0.2},"float64"));check(x,{3},{0,1,7},"09c4a2fedeeee731",r) end
do local r=np.random.default_rng(840084);local x=r:negative_binomial(np.array({0.1,1.2,3.7},"float64"),np.array({0.9,0.5,0.2},"float64"), {2,3});check(x,{2,3},{{0,1,7},{0,1,39}},"01f459d45a3b2f6e",r) end
do local r=np.random.default_rng(840084);local x=r:negative_binomial(np.array({0.1,1.2,3.7},"float64"),np.array({0.9,0.5,0.2},"float64"), {0,3});check(x,{0,3},{},"a10e5f36b2c66e67",r) end
do local r=np.random.default_rng(840084);local x=r:negative_binomial(np.array({4,10,100,1000},"int64"),np.array({0.95,0.75,0.5,0.1},"float64"));check(x,{4},{0,4,109,9232},"7e993913160d68db",r) end
do local r=np.random.default_rng(840084);local x=r:negative_binomial(np.array({4,10,100,1000},"int64"),np.array({0.95,0.75,0.5,0.1},"float64"), {2,4});check(x,{2,4},{{0,4,109,9232},{1,2,108,9452}},"bc39d8bc117f3b1b",r) end
do local r=np.random.default_rng(840084);local x=r:negative_binomial(np.array({4,10,100,1000},"int64"),np.array({0.95,0.75,0.5,0.1},"float64"), {0,4});check(x,{0,4},{},"a10e5f36b2c66e67",r) end
do local r=np.random.default_rng(840084);local x=r:negative_binomial(np.array({{10,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2));check(x,{2,2},{{0,28},{94,4}},"01f459d45a3b2f6e",r) end
do local r=np.random.default_rng(840084);local x=r:negative_binomial(np.array({{10,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2), {2,2,2});check(x,{2,2,2},{{{0,28},{94,4}},{{0,27},{134,5}}},"4e738297df1b5e77",r) end
do local r=np.random.default_rng(840084);local x=r:negative_binomial(np.array({{10,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2), {0,2,2});check(x,{0,2,2},{},"a10e5f36b2c66e67",r) end
do local r=np.random.default_rng(840084);local x=r:negative_binomial(1000.0,np.array({0.01,0.05,0.5,0.999,1.0},"float64"));check(x,{5},{99150,19225,982,1,0},"7e993913160d68db",r) end
do local r=np.random.default_rng(840084);local x=r:negative_binomial(1000.0,np.array({0.01,0.05,0.5,0.999,1.0},"float64"), {2,5});check(x,{2,5},{{99150,19225,982,1,0},{106184,19050,923,3,0}},"8ae7e25955cc1232",r) end
do local r=np.random.default_rng(840084);local x=r:negative_binomial(1000.0,np.array({0.01,0.05,0.5,0.999,1.0},"float64"), {0,5});check(x,{0,5},{},"a10e5f36b2c66e67",r) end
do local r=np.random.default_rng(840084);local x=r:negative_binomial(np.array(6.0,"float64"),np.array(0.23,"float64"));check(x,{},20,"cba9cff48a89169e",r) end
do local r=np.random.default_rng(840084);local x=r:negative_binomial(np.array(6.0,"float64"),np.array(0.23,"float64"), {2});check(x,{2},{20,19},"4cc36af8d6de87a8",r) end
do local r=np.random.default_rng(840084);local x=r:negative_binomial(np.array(6.0,"float64"),np.array(0.23,"float64"), {0});check(x,{0},{},"a10e5f36b2c66e67",r) end
do local r=np.random.default_rng(840084);local x=r:negative_binomial(30.0,0.5);check(x,{},31,"cba9cff48a89169e",r) end
do local r=np.random.default_rng(840084);local x=r:negative_binomial(30.0,0.5, {2});check(x,{2},{31,27},"4cc36af8d6de87a8",r) end
do local r=np.random.default_rng(840084);local x=r:negative_binomial(30.0,0.5, {0});check(x,{0},{},"a10e5f36b2c66e67",r) end
do local r=np.random.default_rng(840084);local x=r:negative_binomial(np.array({0.5,1.0,2.0,4.0},"float64"),np.array({1.0,1.0,1.0,1.0},"float64"));check(x,{4},{0,0,0,0},"c687caac880d5f19",r) end
do local r=np.random.default_rng(840084);local x=r:negative_binomial(np.array({0.5,1.0,2.0,4.0},"float64"),np.array({1.0,1.0,1.0,1.0},"float64"), {2,4});check(x,{2,4},{{0,0,0,0},{0,0,0,0}},"3d51fa4aef3535d6",r) end
do local r=np.random.default_rng(840084);local x=r:negative_binomial(np.array({0.5,1.0,2.0,4.0},"float64"),np.array({1.0,1.0,1.0,1.0},"float64"), {0,4});check(x,{0,4},{},"a10e5f36b2c66e67",r) end
do local r=np.random.default_rng(2147483647);local x=r:binomial(np.array({0,1,2,10,100,1000},"int64"),0.4);check(x,{6},{0,0,2,4,35,433},"dcccd78cd19c442e",r) end
do local r=np.random.default_rng(2147483647);local x=r:binomial(np.array({0,1,2,10,100,1000},"int64"),0.4, {2,6});check(x,{2,6},{{0,0,2,4,35,433},{0,1,1,4,41,404}},"cf6a1626b1a675d0",r) end
do local r=np.random.default_rng(2147483647);local x=r:binomial(np.array({0,1,2,10,100,1000},"int64"),0.4, {0,6});check(x,{0,6},{},"4556b1b9d0d8c66a",r) end
do local r=np.random.default_rng(2147483647);local x=r:binomial(np.array({{0},{1},{10},{50}},"int64"),np.array({{0.0,0.01,0.5,0.99,1.0}},"float64"));check(x,{4,5},{{0,0,0,0,0},{0,0,1,1,1},{0,0,5,10,10},{0,1,29,50,50}},"a25461b4cac4f1bb",r) end
do local r=np.random.default_rng(2147483647);local x=r:binomial(np.array({{0},{1},{10},{50}},"int64"),np.array({{0.0,0.01,0.5,0.99,1.0}},"float64"), {2,4,5});check(x,{2,4,5},{{{0,0,0,0,0},{0,0,1,1,1},{0,0,5,10,10},{0,1,29,50,50}},{{0,0,0,0,0},{0,0,0,1,1},{0,0,1,10,10},{0,1,28,47,50}}},"e2616cbc5fc55f5c",r) end
do local r=np.random.default_rng(2147483647);local x=r:binomial(np.array({{0},{1},{10},{50}},"int64"),np.array({{0.0,0.01,0.5,0.99,1.0}},"float64"), {0,4,5});check(x,{0,4,5},{},"4556b1b9d0d8c66a",r) end
do local r=np.random.default_rng(2147483647);local x=r:binomial(np.flip(np.array({{4,9,13},{20,30,50}},"int64"),2),0.3);check(x,{2,3},{{3,5,1},{16,9,6}},"2b7175caea43cc46",r) end
do local r=np.random.default_rng(2147483647);local x=r:binomial(np.flip(np.array({{4,9,13},{20,30,50}},"int64"),2),0.3, {2,2,3});check(x,{2,2,3},{{{3,5,1},{16,9,6}},{{2,6,2},{19,9,6}}},"a25461b4cac4f1bb",r) end
do local r=np.random.default_rng(2147483647);local x=r:binomial(np.flip(np.array({{4,9,13},{20,30,50}},"int64"),2),0.3, {0,2,3});check(x,{0,2,3},{},"4556b1b9d0d8c66a",r) end
do local r=np.random.default_rng(2147483647);local x=r:binomial(100,np.array({0.0,0.1,0.5,0.9,1.0},"float32"));check(x,{5},{0,8,61,89,100},"7780c1f659d00ca8",r) end
do local r=np.random.default_rng(2147483647);local x=r:binomial(100,np.array({0.0,0.1,0.5,0.9,1.0},"float32"), {2,5});check(x,{2,5},{{0,8,61,89,100},{0,10,45,87,100}},"71d31c27012ad938",r) end
do local r=np.random.default_rng(2147483647);local x=r:binomial(100,np.array({0.0,0.1,0.5,0.9,1.0},"float32"), {0,5});check(x,{0,5},{},"4556b1b9d0d8c66a",r) end
do local r=np.random.default_rng(2147483647);local x=r:binomial(np.transpose(np.array({{10,20},{30,40}},"int64")),0.12);check(x,{2,2},{{0,6},{2,5}},"7f4b40adfe34f236",r) end
do local r=np.random.default_rng(2147483647);local x=r:binomial(np.transpose(np.array({{10,20},{30,40}},"int64")),0.12, {2,2,2});check(x,{2,2,2},{{{0,6},{2,5}},{{1,3},{1,10}}},"d85edea9d140e4bc",r) end
do local r=np.random.default_rng(2147483647);local x=r:binomial(np.transpose(np.array({{10,20},{30,40}},"int64")),0.12, {0,2,2});check(x,{0,2,2},{},"4556b1b9d0d8c66a",r) end
do local r=np.random.default_rng(2147483647);local x=r:binomial(np.array({3,13,25},"int64"),np.array({0.15,0.5,0.95},"float64"));check(x,{3},{0,9,24},"a4fc7805e6680c0e",r) end
do local r=np.random.default_rng(2147483647);local x=r:binomial(np.array({3,13,25},"int64"),np.array({0.15,0.5,0.95},"float64"), {2,3});check(x,{2,3},{{0,9,24},{1,6,24}},"2b7175caea43cc46",r) end
do local r=np.random.default_rng(2147483647);local x=r:binomial(np.array({3,13,25},"int64"),np.array({0.15,0.5,0.95},"float64"), {0,3});check(x,{0,3},{},"4556b1b9d0d8c66a",r) end
do local r=np.random.default_rng(2147483647);local x=r:binomial(np.array({4,100,1000,100000},"int64"),np.array({0.05,0.75,0.5,0.001},"float64"));check(x,{4},{0,68,499,108},"2b7175caea43cc46",r) end
do local r=np.random.default_rng(2147483647);local x=r:binomial(np.array({4,100,1000,100000},"int64"),np.array({0.05,0.75,0.5,0.001},"float64"), {2,4});check(x,{2,4},{{0,68,499,108},{0,65,507,91}},"2fdc954f372669e6",r) end
do local r=np.random.default_rng(2147483647);local x=r:binomial(np.array({4,100,1000,100000},"int64"),np.array({0.05,0.75,0.5,0.001},"float64"), {0,4});check(x,{0,4},{},"4556b1b9d0d8c66a",r) end
do local r=np.random.default_rng(2147483647);local x=r:binomial(np.array({{100,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2));check(x,{2,2},{{100,2},{16,18}},"7f4b40adfe34f236",r) end
do local r=np.random.default_rng(2147483647);local x=r:binomial(np.array({{100,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2), {2,2,2});check(x,{2,2,2},{{{100,2},{16,18}},{{99,1},{13,13}}},"d85edea9d140e4bc",r) end
do local r=np.random.default_rng(2147483647);local x=r:binomial(np.array({{100,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2), {0,2,2});check(x,{0,2,2},{},"4556b1b9d0d8c66a",r) end
do local r=np.random.default_rng(2147483647);local x=r:binomial(1000000000000,np.array({1e-08,0.0001,0.5,0.9999,1.0},"float64"));check(x,{5},{9877,99998621,500000210010,999900016785,1000000000000},"dcccd78cd19c442e",r) end
do local r=np.random.default_rng(2147483647);local x=r:binomial(1000000000000,np.array({1e-08,0.0001,0.5,0.9999,1.0},"float64"), {2,5});check(x,{2,5},{{9877,99998621,500000210010,999900016785,1000000000000},{10019,99998537,499999970593,999900013556,1000000000000}},"dd5ce134ff78e588",r) end
do local r=np.random.default_rng(2147483647);local x=r:binomial(1000000000000,np.array({1e-08,0.0001,0.5,0.9999,1.0},"float64"), {0,5});check(x,{0,5},{},"4556b1b9d0d8c66a",r) end
do local r=np.random.default_rng(2147483647);local x=r:binomial(np.array(6,"int64"),np.array(0.23,"float64"));check(x,{},1,"ef1408cd3177cb2b",r) end
do local r=np.random.default_rng(2147483647);local x=r:binomial(np.array(6,"int64"),np.array(0.23,"float64"), {2});check(x,{2},{1,3},"707dad1482ff2869",r) end
do local r=np.random.default_rng(2147483647);local x=r:binomial(np.array(6,"int64"),np.array(0.23,"float64"), {0});check(x,{0},{},"4556b1b9d0d8c66a",r) end
do local r=np.random.default_rng(2147483647);local x=r:binomial(30,0.5);check(x,{},13,"ef1408cd3177cb2b",r) end
do local r=np.random.default_rng(2147483647);local x=r:binomial(30,0.5, {2});check(x,{2},{13,19},"707dad1482ff2869",r) end
do local r=np.random.default_rng(2147483647);local x=r:binomial(30,0.5, {0});check(x,{0},{},"4556b1b9d0d8c66a",r) end
do local r=np.random.default_rng(2147483647);local x=r:binomial(0,np.array({0.0,0.4,1.0},"float64"));check(x,{3},{0,0,0},"4556b1b9d0d8c66a",r) end
do local r=np.random.default_rng(2147483647);local x=r:binomial(0,np.array({0.0,0.4,1.0},"float64"), {2,3});check(x,{2,3},{{0,0,0},{0,0,0}},"4556b1b9d0d8c66a",r) end
do local r=np.random.default_rng(2147483647);local x=r:binomial(0,np.array({0.0,0.4,1.0},"float64"), {0,3});check(x,{0,3},{},"4556b1b9d0d8c66a",r) end
do local r=np.random.default_rng(2147483647);local x=r:binomial(np.array({0,1,2,3,4},"int64"),np.array({1.0,1.0,1.0,1.0,1.0},"float64"));check(x,{5},{0,1,2,3,4},"7f4b40adfe34f236",r) end
do local r=np.random.default_rng(2147483647);local x=r:binomial(np.array({0,1,2,3,4},"int64"),np.array({1.0,1.0,1.0,1.0,1.0},"float64"), {2,5});check(x,{2,5},{{0,1,2,3,4},{0,1,2,3,4}},"d85edea9d140e4bc",r) end
do local r=np.random.default_rng(2147483647);local x=r:binomial(np.array({0,1,2,3,4},"int64"),np.array({1.0,1.0,1.0,1.0,1.0},"float64"), {0,5});check(x,{0,5},{},"4556b1b9d0d8c66a",r) end
do local r=np.random.default_rng(2147483647);local x=r:negative_binomial(np.array({0.1,0.5,1.0,2.5,5.0,20.0},"float64"),0.5);check(x,{6},{0,0,2,1,1,19},"bb93a111ef0be9d4",r) end
do local r=np.random.default_rng(2147483647);local x=r:negative_binomial(np.array({0.1,0.5,1.0,2.5,5.0,20.0},"float64"),0.5, {2,6});check(x,{2,6},{{0,0,2,1,1,19},{0,0,0,0,8,12}},"2a67080f0af2c60e",r) end
do local r=np.random.default_rng(2147483647);local x=r:negative_binomial(np.array({0.1,0.5,1.0,2.5,5.0,20.0},"float64"),0.5, {0,6});check(x,{0,6},{},"4556b1b9d0d8c66a",r) end
do local r=np.random.default_rng(2147483647);local x=r:negative_binomial(np.array({{0.1},{0.5},{1.2},{20.0}},"float64"),np.array({{0.01,0.1,0.5,0.95,1.0}},"float64"));check(x,{4,5},{{0,0,0,0,0},{1,17,1,0,0},{66,3,0,0,0},{1986,211,9,0,0}},"e5da8c256acabbc6",r) end
do local r=np.random.default_rng(2147483647);local x=r:negative_binomial(np.array({{0.1},{0.5},{1.2},{20.0}},"float64"),np.array({{0.01,0.1,0.5,0.95,1.0}},"float64"), {2,4,5});check(x,{2,4,5},{{{0,0,0,0,0},{1,17,1,0,0},{66,3,0,0,0},{1986,211,9,0,0}},{{37,0,2,0,0},{84,0,0,0,0},{50,0,0,0,0},{1758,237,19,1,0}}},"1a4899ffca8708f1",r) end
do local r=np.random.default_rng(2147483647);local x=r:negative_binomial(np.array({{0.1},{0.5},{1.2},{20.0}},"float64"),np.array({{0.01,0.1,0.5,0.95,1.0}},"float64"), {0,4,5});check(x,{0,4,5},{},"4556b1b9d0d8c66a",r) end
do local r=np.random.default_rng(2147483647);local x=r:negative_binomial(np.flip(np.array({{1.3,2.8},{3.5,8.5}},"float64"),2),0.4);check(x,{2,2},{{4,6},{15,1}},"79ef50e991e66529",r) end
do local r=np.random.default_rng(2147483647);local x=r:negative_binomial(np.flip(np.array({{1.3,2.8},{3.5,8.5}},"float64"),2),0.4, {2,2,2});check(x,{2,2,2},{{{4,6},{15,1}},{{3,1},{7,5}}},"49ef086826bd6490",r) end
do local r=np.random.default_rng(2147483647);local x=r:negative_binomial(np.flip(np.array({{1.3,2.8},{3.5,8.5}},"float64"),2),0.4, {0,2,2});check(x,{0,2,2},{},"4556b1b9d0d8c66a",r) end
do local r=np.random.default_rng(2147483647);local x=r:negative_binomial(10.0,np.array({0.001,0.01,0.1,0.5,1.0},"float32"));check(x,{5},{10377,1339,75,9,0},"c5e506238293115e",r) end
do local r=np.random.default_rng(2147483647);local x=r:negative_binomial(10.0,np.array({0.001,0.01,0.1,0.5,1.0},"float32"), {2,5});check(x,{2,5},{{10377,1339,75,9,0},{8975,675,120,18,0}},"f0cd7c727dfe8b7a",r) end
do local r=np.random.default_rng(2147483647);local x=r:negative_binomial(10.0,np.array({0.001,0.01,0.1,0.5,1.0},"float32"), {0,5});check(x,{0,5},{},"4556b1b9d0d8c66a",r) end
do local r=np.random.default_rng(2147483647);local x=r:negative_binomial(np.transpose(np.array({{3.0,20.0},{30.0,40.0}},"float32")),0.12);check(x,{2,2},{{22,257},{128,265}},"ac35089e53d0d704",r) end
do local r=np.random.default_rng(2147483647);local x=r:negative_binomial(np.transpose(np.array({{3.0,20.0},{30.0,40.0}},"float32")),0.12, {2,2,2});check(x,{2,2,2},{{{22,257},{128,265}},{{24,160},{116,241}}},"79ef50e991e66529",r) end
do local r=np.random.default_rng(2147483647);local x=r:negative_binomial(np.transpose(np.array({{3.0,20.0},{30.0,40.0}},"float32")),0.12, {0,2,2});check(x,{0,2,2},{},"4556b1b9d0d8c66a",r) end
do local r=np.random.default_rng(2147483647);local x=r:negative_binomial(np.array({0.1,1.2,3.7},"float64"),np.array({0.9,0.5,0.2},"float64"));check(x,{3},{0,1,44},"6dbd89bf1a925d79",r) end
do local r=np.random.default_rng(2147483647);local x=r:negative_binomial(np.array({0.1,1.2,3.7},"float64"),np.array({0.9,0.5,0.2},"float64"), {2,3});check(x,{2,3},{{0,1,44},{0,0,18}},"d1a4f93f7e57ac43",r) end
do local r=np.random.default_rng(2147483647);local x=r:negative_binomial(np.array({0.1,1.2,3.7},"float64"),np.array({0.9,0.5,0.2},"float64"), {0,3});check(x,{0,3},{},"4556b1b9d0d8c66a",r) end
do local r=np.random.default_rng(2147483647);local x=r:negative_binomial(np.array({4,10,100,1000},"int64"),np.array({0.95,0.75,0.5,0.1},"float64"));check(x,{4},{0,5,80,9194},"d1a4f93f7e57ac43",r) end
do local r=np.random.default_rng(2147483647);local x=r:negative_binomial(np.array({4,10,100,1000},"int64"),np.array({0.95,0.75,0.5,0.1},"float64"), {2,4});check(x,{2,4},{{0,5,80,9194},{2,2,68,8834}},"69419184c0be7f8e",r) end
do local r=np.random.default_rng(2147483647);local x=r:negative_binomial(np.array({4,10,100,1000},"int64"),np.array({0.95,0.75,0.5,0.1},"float64"), {0,4});check(x,{0,4},{},"4556b1b9d0d8c66a",r) end
do local r=np.random.default_rng(2147483647);local x=r:negative_binomial(np.array({{10,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2));check(x,{2,2},{{0,19},{149,4}},"dd5ce134ff78e588",r) end
do local r=np.random.default_rng(2147483647);local x=r:negative_binomial(np.array({{10,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2), {2,2,2});check(x,{2,2,2},{{{0,19},{149,4}},{{0,23},{120,4}}},"79ef50e991e66529",r) end
do local r=np.random.default_rng(2147483647);local x=r:negative_binomial(np.array({{10,5},{50,25}},"int64"),np.flip(np.array({{0.2,0.99},{0.75,0.33}},"float64"),2), {0,2,2});check(x,{0,2,2},{},"4556b1b9d0d8c66a",r) end
do local r=np.random.default_rng(2147483647);local x=r:negative_binomial(1000.0,np.array({0.01,0.05,0.5,0.999,1.0},"float64"));check(x,{5},{99639,19760,994,1,0},"ac35089e53d0d704",r) end
do local r=np.random.default_rng(2147483647);local x=r:negative_binomial(1000.0,np.array({0.01,0.05,0.5,0.999,1.0},"float64"), {2,5});check(x,{2,5},{{99639,19760,994,1,0},{98956,17972,944,0,0}},"69419184c0be7f8e",r) end
do local r=np.random.default_rng(2147483647);local x=r:negative_binomial(1000.0,np.array({0.01,0.05,0.5,0.999,1.0},"float64"), {0,5});check(x,{0,5},{},"4556b1b9d0d8c66a",r) end
do local r=np.random.default_rng(2147483647);local x=r:negative_binomial(np.array(6.0,"float64"),np.array(0.23,"float64"));check(x,{},20,"7f4b40adfe34f236",r) end
do local r=np.random.default_rng(2147483647);local x=r:negative_binomial(np.array(6.0,"float64"),np.array(0.23,"float64"), {2});check(x,{2},{20,27},"a25461b4cac4f1bb",r) end
do local r=np.random.default_rng(2147483647);local x=r:negative_binomial(np.array(6.0,"float64"),np.array(0.23,"float64"), {0});check(x,{0},{},"4556b1b9d0d8c66a",r) end
do local r=np.random.default_rng(2147483647);local x=r:negative_binomial(30.0,0.5);check(x,{},30,"7f4b40adfe34f236",r) end
do local r=np.random.default_rng(2147483647);local x=r:negative_binomial(30.0,0.5, {2});check(x,{2},{30,34},"a25461b4cac4f1bb",r) end
do local r=np.random.default_rng(2147483647);local x=r:negative_binomial(30.0,0.5, {0});check(x,{0},{},"4556b1b9d0d8c66a",r) end
do local r=np.random.default_rng(2147483647);local x=r:negative_binomial(np.array({0.5,1.0,2.0,4.0},"float64"),np.array({1.0,1.0,1.0,1.0},"float64"));check(x,{4},{0,0,0,0},"fd4f25db1d6274dd",r) end
do local r=np.random.default_rng(2147483647);local x=r:negative_binomial(np.array({0.5,1.0,2.0,4.0},"float64"),np.array({1.0,1.0,1.0,1.0},"float64"), {2,4});check(x,{2,4},{{0,0,0,0},{0,0,0,0}},"cf6a1626b1a675d0",r) end
do local r=np.random.default_rng(2147483647);local x=r:negative_binomial(np.array({0.5,1.0,2.0,4.0},"float64"),np.array({1.0,1.0,1.0,1.0},"float64"), {0,4});check(x,{0,4},{},"4556b1b9d0d8c66a",r) end
print('random84 NumPy differential: '..cases..'/750 passed')
