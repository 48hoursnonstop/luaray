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
  local a=np.reshape(np.arange(18),{3,3,2})
  local ix1=np.array({2,-3,2},np.int64)
  local v=700
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{700,700},{700,700},{700,700}},{{700,700},{700,700},{700,700}},{{12,13},{14,15},{16,17}}}),'advanced assignment 0')
end
do
  local a=np.reshape(np.arange(40),{5,4,2})
  local ix1=np.array({5},np.int64)
  local ix2=np.array({1},np.int64)
  local v=np.array({{1010,1011,1012,1013}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1),ix2)
  assert(eq(a:tolist(),{{{0,1},{2,3},{4,5},{6,7}},{{8,9},{10,11},{12,13},{14,15}},{{16,17},{18,19},{20,21},{22,23}},{{24,25},{26,27},{28,29},{30,31}},{{1010,33},{1011,35},{1012,37},{1013,39}}}),'advanced assignment 1')
end
do
  local a=np.reshape(np.arange(48),{4,3,4})
  local ix1=np.array({{2},{-4},{3}},np.int64)
  local ix2=np.array({{2,3,3}},np.int64)
  local v=np.array({{{2020,2021,2022,2023},{2024,2025,2026,2027},{2028,2029,2030,2031}}},np.int64)
  a:set(v,ix1,ix2,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2,3},{2020,2021,2022,2023},{2028,2029,2030,2031}},{{12,13,14,15},{2020,2021,2022,2023},{2028,2029,2030,2031}},{{24,25,26,27},{2020,2021,2022,2023},{2028,2029,2030,2031}},{{36,37,38,39},{40,41,42,43},{44,45,46,47}}}),'advanced assignment 2')
end
do
  local a=np.reshape(np.arange(32),{4,4,2})
  local ix1=np.array({false,true,true,false},np.bool)
  local v=703
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1},{2,3},{4,5},{6,7}},{{703,703},{703,703},{703,703},{703,703}},{{703,703},{703,703},{703,703},{703,703}},{{24,25},{26,27},{28,29},{30,31}}}),'advanced assignment 3')
end
do
  local a=np.reshape(np.arange(45),{5,3,3})
  local ix1=np.array({{false,false,false},{false,false,true},{false,true,false},{false,false,true},{false,false,false}},np.bool)
  local v=np.array({{1040,1041,1042},{1043,1044,1045},{1046,1047,1048}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2},{3,4,5},{6,7,8}},{{9,10,11},{12,13,14},{1040,1041,1042}},{{18,19,20},{1043,1044,1045},{24,25,26}},{{27,28,29},{30,31,32},{1046,1047,1048}},{{36,37,38},{39,40,41},{42,43,44}}}),'advanced assignment 4')
end
do
  local a=np.reshape(np.arange(30),{5,3,2})
  local ix1=np.array({-2,2},np.int64)
  local v=np.array({{2050,2051}},np.int64)
  a:set(v,np.slice(nil,nil,1),3,ix1)
  assert(eq(a:tolist(),{{{0,1},{2,3},{2050,2051}},{{6,7},{8,9},{2050,2051}},{{12,13},{14,15},{2050,2051}},{{18,19},{20,21},{2050,2051}},{{24,25},{26,27},{2050,2051}}}),'advanced assignment 5')
end
do
  local a=np.reshape(np.arange(48),{4,4,3})
  local ix1=np.array({4,3,3},np.int64)
  local v=706
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2},{3,4,5},{6,7,8},{9,10,11}},{{12,13,14},{15,16,17},{18,19,20},{21,22,23}},{{706,706,706},{706,706,706},{706,706,706},{706,706,706}},{{706,706,706},{706,706,706},{706,706,706},{706,706,706}}}),'advanced assignment 6')
end
do
  local a=np.reshape(np.arange(75),{5,3,5})
  local ix1=np.array({4},np.int64)
  local ix2=np.array({3},np.int64)
  local v=np.array({{1070,1071,1072}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1),ix2)
  assert(eq(a:tolist(),{{{0,1,2,3,4},{5,6,7,8,9},{10,11,12,13,14}},{{15,16,17,18,19},{20,21,22,23,24},{25,26,27,28,29}},{{30,31,32,33,34},{35,36,37,38,39},{40,41,42,43,44}},{{45,46,1070,48,49},{50,51,1071,53,54},{55,56,1072,58,59}},{{60,61,62,63,64},{65,66,67,68,69},{70,71,72,73,74}}}),'advanced assignment 7')
end
do
  local a=np.reshape(np.arange(24),{3,4,2})
  local ix1=np.array({{-1},{3}},np.int64)
  local ix2=np.array({{3,2}},np.int64)
  local v=np.array({{{2080,2081},{2082,2083}}},np.int64)
  a:set(v,ix1,ix2,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1},{2,3},{4,5},{6,7}},{{8,9},{10,11},{12,13},{14,15}},{{16,17},{2082,2083},{2080,2081},{22,23}}}),'advanced assignment 8')
end
do
  local a=np.reshape(np.arange(36),{3,4,3})
  local ix1=np.array({false,true,false},np.bool)
  local v=709
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2},{3,4,5},{6,7,8},{9,10,11}},{{709,709,709},{709,709,709},{709,709,709},{709,709,709}},{{24,25,26},{27,28,29},{30,31,32},{33,34,35}}}),'advanced assignment 9')
end
do
  local a=np.reshape(np.arange(40),{4,2,5})
  local ix1=np.array({{true,true},{false,false},{true,true},{false,false}},np.bool)
  local v=np.array({{1100,1101,1102,1103,1104},{1105,1106,1107,1108,1109},{1110,1111,1112,1113,1114},{1115,1116,1117,1118,1119}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{1100,1101,1102,1103,1104},{1105,1106,1107,1108,1109}},{{10,11,12,13,14},{15,16,17,18,19}},{{1110,1111,1112,1113,1114},{1115,1116,1117,1118,1119}},{{30,31,32,33,34},{35,36,37,38,39}}}),'advanced assignment 10')
end
do
  local a=np.reshape(np.arange(80),{4,4,5})
  local ix1=np.array({-4,1},np.int64)
  local v=np.array({{2110,2111}},np.int64)
  a:set(v,np.slice(nil,nil,1),2,ix1)
  assert(eq(a:tolist(),{{{0,1,2,3,4},{2111,2110,7,8,9},{10,11,12,13,14},{15,16,17,18,19}},{{20,21,22,23,24},{2111,2110,27,28,29},{30,31,32,33,34},{35,36,37,38,39}},{{40,41,42,43,44},{2111,2110,47,48,49},{50,51,52,53,54},{55,56,57,58,59}},{{60,61,62,63,64},{2111,2110,67,68,69},{70,71,72,73,74},{75,76,77,78,79}}}),'advanced assignment 11')
end
do
  local a=np.reshape(np.arange(24),{2,3,4})
  local ix1=np.array({2,-2},np.int64)
  local v=712
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{712,712,712,712},{712,712,712,712},{712,712,712,712}},{{712,712,712,712},{712,712,712,712},{712,712,712,712}}}),'advanced assignment 12')
end
do
  local a=np.reshape(np.arange(40),{4,5,2})
  local ix1=np.array({-2,3,3},np.int64)
  local ix2=np.array({1,2,1},np.int64)
  local v=np.array({{1130,1131,1132,1133,1134},{1135,1136,1137,1138,1139},{1140,1141,1142,1143,1144}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1),ix2)
  assert(eq(a:tolist(),{{{0,1},{2,3},{4,5},{6,7},{8,9}},{{10,11},{12,13},{14,15},{16,17},{18,19}},{{1140,1135},{1141,1136},{1142,1137},{1143,1138},{1144,1139}},{{30,31},{32,33},{34,35},{36,37},{38,39}}}),'advanced assignment 13')
end
do
  local a=np.reshape(np.arange(18),{3,3,2})
  local ix1=np.array({{-2},{1},{-2}},np.int64)
  local ix2=np.array({{-3,2,2}},np.int64)
  local v=np.array({{{2140,2141},{2142,2143},{2144,2145}}},np.int64)
  a:set(v,ix1,ix2,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{2140,2141},{2144,2145},{4,5}},{{2140,2141},{2144,2145},{10,11}},{{12,13},{14,15},{16,17}}}),'advanced assignment 14')
end
do
  local a=np.reshape(np.arange(18),{3,3,2})
  local ix1=np.array({true,false,false},np.bool)
  local v=715
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{715,715},{715,715},{715,715}},{{6,7},{8,9},{10,11}},{{12,13},{14,15},{16,17}}}),'advanced assignment 15')
end
do
  local a=np.reshape(np.arange(20),{5,2,2})
  local ix1=np.array({{false,true},{false,false},{true,false},{false,false},{false,false}},np.bool)
  local v=np.array({{1160,1161},{1162,1163}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1},{1160,1161}},{{4,5},{6,7}},{{1162,1163},{10,11}},{{12,13},{14,15}},{{16,17},{18,19}}}),'advanced assignment 16')
end
do
  local a=np.reshape(np.arange(64),{4,4,4})
  local ix1=np.array({2,-3},np.int64)
  local v=np.array({{2170,2171}},np.int64)
  a:set(v,np.slice(nil,nil,1),3,ix1)
  assert(eq(a:tolist(),{{{0,1,2,3},{4,5,6,7},{8,2171,10,11},{12,13,14,15}},{{16,17,18,19},{20,21,22,23},{24,2171,26,27},{28,29,30,31}},{{32,33,34,35},{36,37,38,39},{40,2171,42,43},{44,45,46,47}},{{48,49,50,51},{52,53,54,55},{56,2171,58,59},{60,61,62,63}}}),'advanced assignment 17')
end
do
  local a=np.reshape(np.arange(32),{4,2,4})
  local ix1=np.array({4,-4,-1},np.int64)
  local v=718
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{718,718,718,718},{718,718,718,718}},{{8,9,10,11},{12,13,14,15}},{{16,17,18,19},{20,21,22,23}},{{718,718,718,718},{718,718,718,718}}}),'advanced assignment 18')
end
do
  local a=np.reshape(np.arange(75),{5,3,5})
  local ix1=np.array({3,4},np.int64)
  local ix2=np.array({2,3},np.int64)
  local v=np.array({{1190,1191,1192},{1193,1194,1195}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1),ix2)
  assert(eq(a:tolist(),{{{0,1,2,3,4},{5,6,7,8,9},{10,11,12,13,14}},{{15,16,17,18,19},{20,21,22,23,24},{25,26,27,28,29}},{{30,1190,32,33,34},{35,1191,37,38,39},{40,1192,42,43,44}},{{45,46,1193,48,49},{50,51,1194,53,54},{55,56,1195,58,59}},{{60,61,62,63,64},{65,66,67,68,69},{70,71,72,73,74}}}),'advanced assignment 19')
end
do
  local a=np.reshape(np.arange(60),{4,3,5})
  local ix1=np.array({{1},{-1},{1}},np.int64)
  local ix2=np.array({{3}},np.int64)
  local v=np.array({{{2200,2201,2202,2203,2204}}},np.int64)
  a:set(v,ix1,ix2,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2,3,4},{5,6,7,8,9},{2200,2201,2202,2203,2204}},{{15,16,17,18,19},{20,21,22,23,24},{25,26,27,28,29}},{{30,31,32,33,34},{35,36,37,38,39},{40,41,42,43,44}},{{45,46,47,48,49},{50,51,52,53,54},{2200,2201,2202,2203,2204}}}),'advanced assignment 20')
end
do
  local a=np.reshape(np.arange(12),{2,2,3})
  local ix1=np.array({true,true},np.bool)
  local v=721
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{721,721,721},{721,721,721}},{{721,721,721},{721,721,721}}}),'advanced assignment 21')
end
do
  local a=np.reshape(np.arange(50),{5,5,2})
  local ix1=np.array({{true,true,false,false,true},{false,false,true,false,false},{false,false,false,true,true},{true,true,false,false,true},{false,false,true,false,true}},np.bool)
  local v=np.array({{1220,1221},{1222,1223},{1224,1225},{1226,1227},{1228,1229},{1230,1231},{1232,1233},{1234,1235},{1236,1237},{1238,1239},{1240,1241}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{1220,1221},{1222,1223},{4,5},{6,7},{1224,1225}},{{10,11},{12,13},{1226,1227},{16,17},{18,19}},{{20,21},{22,23},{24,25},{1228,1229},{1230,1231}},{{1232,1233},{1234,1235},{34,35},{36,37},{1236,1237}},{{40,41},{42,43},{1238,1239},{46,47},{1240,1241}}}),'advanced assignment 22')
end
do
  local a=np.reshape(np.arange(64),{4,4,4})
  local ix1=np.array({4},np.int64)
  local v=np.array({{2230}},np.int64)
  a:set(v,np.slice(nil,nil,1),2,ix1)
  assert(eq(a:tolist(),{{{0,1,2,3},{4,5,6,2230},{8,9,10,11},{12,13,14,15}},{{16,17,18,19},{20,21,22,2230},{24,25,26,27},{28,29,30,31}},{{32,33,34,35},{36,37,38,2230},{40,41,42,43},{44,45,46,47}},{{48,49,50,51},{52,53,54,2230},{56,57,58,59},{60,61,62,63}}}),'advanced assignment 23')
end
do
  local a=np.reshape(np.arange(24),{3,4,2})
  local ix1=np.array({-3,-2,2},np.int64)
  local v=724
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{724,724},{724,724},{724,724},{724,724}},{{724,724},{724,724},{724,724},{724,724}},{{16,17},{18,19},{20,21},{22,23}}}),'advanced assignment 24')
end
do
  local a=np.reshape(np.arange(18),{2,3,3})
  local ix1=np.array({2},np.int64)
  local ix2=np.array({-2},np.int64)
  local v=np.array({{1250,1251,1252}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1),ix2)
  assert(eq(a:tolist(),{{{0,1,2},{3,4,5},{6,7,8}},{{9,1250,11},{12,1251,14},{15,1252,17}}}),'advanced assignment 25')
end
do
  local a=np.reshape(np.arange(24),{2,4,3})
  local ix1=np.array({{1}},np.int64)
  local ix2=np.array({{-1}},np.int64)
  local v=np.array({{{2260,2261,2262}}},np.int64)
  a:set(v,ix1,ix2,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2},{3,4,5},{6,7,8},{2260,2261,2262}},{{12,13,14},{15,16,17},{18,19,20},{21,22,23}}}),'advanced assignment 26')
end
do
  local a=np.reshape(np.arange(100),{5,4,5})
  local ix1=np.array({false,false,true,false,true},np.bool)
  local v=727
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2,3,4},{5,6,7,8,9},{10,11,12,13,14},{15,16,17,18,19}},{{20,21,22,23,24},{25,26,27,28,29},{30,31,32,33,34},{35,36,37,38,39}},{{727,727,727,727,727},{727,727,727,727,727},{727,727,727,727,727},{727,727,727,727,727}},{{60,61,62,63,64},{65,66,67,68,69},{70,71,72,73,74},{75,76,77,78,79}},{{727,727,727,727,727},{727,727,727,727,727},{727,727,727,727,727},{727,727,727,727,727}}}),'advanced assignment 27')
end
do
  local a=np.reshape(np.arange(60),{3,5,4})
  local ix1=np.array({{false,true,true,false,false},{false,false,true,true,true},{false,false,false,true,false}},np.bool)
  local v=np.array({{1280,1281,1282,1283},{1284,1285,1286,1287},{1288,1289,1290,1291},{1292,1293,1294,1295},{1296,1297,1298,1299},{1300,1301,1302,1303}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2,3},{1280,1281,1282,1283},{1284,1285,1286,1287},{12,13,14,15},{16,17,18,19}},{{20,21,22,23},{24,25,26,27},{1288,1289,1290,1291},{1292,1293,1294,1295},{1296,1297,1298,1299}},{{40,41,42,43},{44,45,46,47},{48,49,50,51},{1300,1301,1302,1303},{56,57,58,59}}}),'advanced assignment 28')
end
do
  local a=np.reshape(np.arange(60),{5,4,3})
  local ix1=np.array({2},np.int64)
  local v=np.array({{2290}},np.int64)
  a:set(v,np.slice(nil,nil,1),3,ix1)
  assert(eq(a:tolist(),{{{0,1,2},{3,4,5},{6,2290,8},{9,10,11}},{{12,13,14},{15,16,17},{18,2290,20},{21,22,23}},{{24,25,26},{27,28,29},{30,2290,32},{33,34,35}},{{36,37,38},{39,40,41},{42,2290,44},{45,46,47}},{{48,49,50},{51,52,53},{54,2290,56},{57,58,59}}}),'advanced assignment 29')
end
do
  local a=np.reshape(np.arange(75),{5,3,5})
  local ix1=np.array({-3},np.int64)
  local v=730
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2,3,4},{5,6,7,8,9},{10,11,12,13,14}},{{15,16,17,18,19},{20,21,22,23,24},{25,26,27,28,29}},{{730,730,730,730,730},{730,730,730,730,730},{730,730,730,730,730}},{{45,46,47,48,49},{50,51,52,53,54},{55,56,57,58,59}},{{60,61,62,63,64},{65,66,67,68,69},{70,71,72,73,74}}}),'advanced assignment 30')
end
do
  local a=np.reshape(np.arange(80),{4,4,5})
  local ix1=np.array({-2,1,4},np.int64)
  local ix2=np.array({-4,2,-3},np.int64)
  local v=np.array({{1310,1311,1312,1313},{1314,1315,1316,1317},{1318,1319,1320,1321}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1),ix2)
  assert(eq(a:tolist(),{{{0,1314,2,3,4},{5,1315,7,8,9},{10,1316,12,13,14},{15,1317,17,18,19}},{{20,21,22,23,24},{25,26,27,28,29},{30,31,32,33,34},{35,36,37,38,39}},{{40,1310,42,43,44},{45,1311,47,48,49},{50,1312,52,53,54},{55,1313,57,58,59}},{{60,61,1318,63,64},{65,66,1319,68,69},{70,71,1320,73,74},{75,76,1321,78,79}}}),'advanced assignment 31')
end
do
  local a=np.reshape(np.arange(40),{5,2,4})
  local ix1=np.array({{4},{5},{3}},np.int64)
  local ix2=np.array({{-2,2}},np.int64)
  local v=np.array({{{2320,2321,2322,2323},{2324,2325,2326,2327}}},np.int64)
  a:set(v,ix1,ix2,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2,3},{4,5,6,7}},{{8,9,10,11},{12,13,14,15}},{{2320,2321,2322,2323},{2324,2325,2326,2327}},{{2320,2321,2322,2323},{2324,2325,2326,2327}},{{2320,2321,2322,2323},{2324,2325,2326,2327}}}),'advanced assignment 32')
end
do
  local a=np.reshape(np.arange(24),{4,2,3})
  local ix1=np.array({true,true,false,true},np.bool)
  local v=733
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{733,733,733},{733,733,733}},{{733,733,733},{733,733,733}},{{12,13,14},{15,16,17}},{{733,733,733},{733,733,733}}}),'advanced assignment 33')
end
do
  local a=np.reshape(np.arange(45),{3,3,5})
  local ix1=np.array({{true,false,false},{false,true,false},{false,false,false}},np.bool)
  local v=np.array({{1340,1341,1342,1343,1344},{1345,1346,1347,1348,1349}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{1340,1341,1342,1343,1344},{5,6,7,8,9},{10,11,12,13,14}},{{15,16,17,18,19},{1345,1346,1347,1348,1349},{25,26,27,28,29}},{{30,31,32,33,34},{35,36,37,38,39},{40,41,42,43,44}}}),'advanced assignment 34')
end
do
  local a=np.reshape(np.arange(30),{5,2,3})
  local ix1=np.array({-2,1},np.int64)
  local v=np.array({{2350,2351}},np.int64)
  a:set(v,np.slice(nil,nil,1),2,ix1)
  assert(eq(a:tolist(),{{{0,1,2},{2351,2350,5}},{{6,7,8},{2351,2350,11}},{{12,13,14},{2351,2350,17}},{{18,19,20},{2351,2350,23}},{{24,25,26},{2351,2350,29}}}),'advanced assignment 35')
end
do
  local a=np.reshape(np.arange(24),{2,3,4})
  local ix1=np.array({2,-1,1},np.int64)
  local v=736
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{736,736,736,736},{736,736,736,736},{736,736,736,736}},{{736,736,736,736},{736,736,736,736},{736,736,736,736}}}),'advanced assignment 36')
end
do
  local a=np.reshape(np.arange(24),{3,2,4})
  local ix1=np.array({-2},np.int64)
  local ix2=np.array({-3},np.int64)
  local v=np.array({{1370,1371}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1),ix2)
  assert(eq(a:tolist(),{{{0,1,2,3},{4,5,6,7}},{{8,1370,10,11},{12,1371,14,15}},{{16,17,18,19},{20,21,22,23}}}),'advanced assignment 37')
end
do
  local a=np.reshape(np.arange(48),{3,4,4})
  local ix1=np.array({{1}},np.int64)
  local ix2=np.array({{-4}},np.int64)
  local v=np.array({{{2380,2381,2382,2383}}},np.int64)
  a:set(v,ix1,ix2,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{2380,2381,2382,2383},{4,5,6,7},{8,9,10,11},{12,13,14,15}},{{16,17,18,19},{20,21,22,23},{24,25,26,27},{28,29,30,31}},{{32,33,34,35},{36,37,38,39},{40,41,42,43},{44,45,46,47}}}),'advanced assignment 38')
end
do
  local a=np.reshape(np.arange(40),{2,4,5})
  local ix1=np.array({true,false},np.bool)
  local v=739
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{739,739,739,739,739},{739,739,739,739,739},{739,739,739,739,739},{739,739,739,739,739}},{{20,21,22,23,24},{25,26,27,28,29},{30,31,32,33,34},{35,36,37,38,39}}}),'advanced assignment 39')
end
do
  local a=np.reshape(np.arange(48),{4,4,3})
  local ix1=np.array({{false,true,false,false},{true,true,false,true},{false,false,false,false},{false,true,true,true}},np.bool)
  local v=np.array({{1400,1401,1402},{1403,1404,1405},{1406,1407,1408},{1409,1410,1411},{1412,1413,1414},{1415,1416,1417},{1418,1419,1420}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2},{1400,1401,1402},{6,7,8},{9,10,11}},{{1403,1404,1405},{1406,1407,1408},{18,19,20},{1409,1410,1411}},{{24,25,26},{27,28,29},{30,31,32},{33,34,35}},{{36,37,38},{1412,1413,1414},{1415,1416,1417},{1418,1419,1420}}}),'advanced assignment 40')
end
do
  local a=np.reshape(np.arange(45),{3,5,3})
  local ix1=np.array({2,2},np.int64)
  local v=np.array({{2410,2411}},np.int64)
  a:set(v,np.slice(nil,nil,1),5,ix1)
  assert(eq(a:tolist(),{{{0,1,2},{3,4,5},{6,7,8},{9,10,11},{12,2411,14}},{{15,16,17},{18,19,20},{21,22,23},{24,25,26},{27,2411,29}},{{30,31,32},{33,34,35},{36,37,38},{39,40,41},{42,2411,44}}}),'advanced assignment 41')
end
do
  local a=np.reshape(np.arange(30),{3,5,2})
  local ix1=np.array({-3},np.int64)
  local v=742
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{742,742},{742,742},{742,742},{742,742},{742,742}},{{10,11},{12,13},{14,15},{16,17},{18,19}},{{20,21},{22,23},{24,25},{26,27},{28,29}}}),'advanced assignment 42')
end
do
  local a=np.reshape(np.arange(100),{5,5,4})
  local ix1=np.array({3,-2},np.int64)
  local ix2=np.array({2,3},np.int64)
  local v=np.array({{1430,1431,1432,1433,1434},{1435,1436,1437,1438,1439}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1),ix2)
  assert(eq(a:tolist(),{{{0,1,2,3},{4,5,6,7},{8,9,10,11},{12,13,14,15},{16,17,18,19}},{{20,21,22,23},{24,25,26,27},{28,29,30,31},{32,33,34,35},{36,37,38,39}},{{40,1430,42,43},{44,1431,46,47},{48,1432,50,51},{52,1433,54,55},{56,1434,58,59}},{{60,61,1435,63},{64,65,1436,67},{68,69,1437,71},{72,73,1438,75},{76,77,1439,79}},{{80,81,82,83},{84,85,86,87},{88,89,90,91},{92,93,94,95},{96,97,98,99}}}),'advanced assignment 43')
end
do
  local a=np.reshape(np.arange(16),{4,2,2})
  local ix1=np.array({{-3},{4},{-1}},np.int64)
  local ix2=np.array({{2,-1,-2}},np.int64)
  local v=np.array({{{2440,2441},{2442,2443},{2444,2445}}},np.int64)
  a:set(v,ix1,ix2,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1},{2,3}},{{2444,2445},{2442,2443}},{{8,9},{10,11}},{{2444,2445},{2442,2443}}}),'advanced assignment 44')
end
do
  local a=np.reshape(np.arange(30),{2,3,5})
  local ix1=np.array({false,false},np.bool)
  local v=745
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2,3,4},{5,6,7,8,9},{10,11,12,13,14}},{{15,16,17,18,19},{20,21,22,23,24},{25,26,27,28,29}}}),'advanced assignment 45')
end
do
  local a=np.reshape(np.arange(24),{2,3,4})
  local ix1=np.array({{false,true,false},{false,false,true}},np.bool)
  local v=np.array({{1460,1461,1462,1463},{1464,1465,1466,1467}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2,3},{1460,1461,1462,1463},{8,9,10,11}},{{12,13,14,15},{16,17,18,19},{1464,1465,1466,1467}}}),'advanced assignment 46')
end
do
  local a=np.reshape(np.arange(30),{3,2,5})
  local ix1=np.array({-4},np.int64)
  local v=np.array({{2470}},np.int64)
  a:set(v,np.slice(nil,nil,1),1,ix1)
  assert(eq(a:tolist(),{{{0,2470,2,3,4},{5,6,7,8,9}},{{10,2470,12,13,14},{15,16,17,18,19}},{{20,2470,22,23,24},{25,26,27,28,29}}}),'advanced assignment 47')
end
do
  local a=np.reshape(np.arange(30),{3,2,5})
  local ix1=np.array({3,1,3},np.int64)
  local v=748
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{748,748,748,748,748},{748,748,748,748,748}},{{10,11,12,13,14},{15,16,17,18,19}},{{748,748,748,748,748},{748,748,748,748,748}}}),'advanced assignment 48')
end
do
  local a=np.reshape(np.arange(40),{2,5,4})
  local ix1=np.array({-1,1,-1},np.int64)
  local ix2=np.array({4,2,4},np.int64)
  local v=np.array({{1490,1491,1492,1493,1494},{1495,1496,1497,1498,1499},{1500,1501,1502,1503,1504}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1),ix2)
  assert(eq(a:tolist(),{{{0,1495,2,3},{4,1496,6,7},{8,1497,10,11},{12,1498,14,15},{16,1499,18,19}},{{20,21,22,1500},{24,25,26,1501},{28,29,30,1502},{32,33,34,1503},{36,37,38,1504}}}),'advanced assignment 49')
end
do
  local a=np.reshape(np.arange(18),{3,2,3})
  local ix1=np.array({{1},{-2},{1}},np.int64)
  local ix2=np.array({{2}},np.int64)
  local v=np.array({{{2500,2501,2502}}},np.int64)
  a:set(v,ix1,ix2,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2},{2500,2501,2502}},{{6,7,8},{2500,2501,2502}},{{12,13,14},{15,16,17}}}),'advanced assignment 50')
end
do
  local a=np.reshape(np.arange(24),{3,2,4})
  local ix1=np.array({true,false,true},np.bool)
  local v=751
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{751,751,751,751},{751,751,751,751}},{{8,9,10,11},{12,13,14,15}},{{751,751,751,751},{751,751,751,751}}}),'advanced assignment 51')
end
do
  local a=np.reshape(np.arange(20),{5,2,2})
  local ix1=np.array({{true,false},{false,false},{false,false},{true,false},{true,true}},np.bool)
  local v=np.array({{1520,1521},{1522,1523},{1524,1525},{1526,1527}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{1520,1521},{2,3}},{{4,5},{6,7}},{{8,9},{10,11}},{{1522,1523},{14,15}},{{1524,1525},{1526,1527}}}),'advanced assignment 52')
end
do
  local a=np.reshape(np.arange(24),{4,2,3})
  local ix1=np.array({2,2,3},np.int64)
  local v=np.array({{2530,2531,2532}},np.int64)
  a:set(v,np.slice(nil,nil,1),2,ix1)
  assert(eq(a:tolist(),{{{0,1,2},{3,2531,2532}},{{6,7,8},{9,2531,2532}},{{12,13,14},{15,2531,2532}},{{18,19,20},{21,2531,2532}}}),'advanced assignment 53')
end
do
  local a=np.reshape(np.arange(60),{3,4,5})
  local ix1=np.array({-2,1,2},np.int64)
  local v=754
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{754,754,754,754,754},{754,754,754,754,754},{754,754,754,754,754},{754,754,754,754,754}},{{754,754,754,754,754},{754,754,754,754,754},{754,754,754,754,754},{754,754,754,754,754}},{{40,41,42,43,44},{45,46,47,48,49},{50,51,52,53,54},{55,56,57,58,59}}}),'advanced assignment 54')
end
do
  local a=np.reshape(np.arange(24),{2,4,3})
  local ix1=np.array({1,2},np.int64)
  local ix2=np.array({3,2},np.int64)
  local v=np.array({{1550,1551,1552,1553},{1554,1555,1556,1557}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1),ix2)
  assert(eq(a:tolist(),{{{0,1,1550},{3,4,1551},{6,7,1552},{9,10,1553}},{{12,1554,14},{15,1555,17},{18,1556,20},{21,1557,23}}}),'advanced assignment 55')
end
do
  local a=np.reshape(np.arange(100),{5,4,5})
  local ix1=np.array({{2},{-3},{2}},np.int64)
  local ix2=np.array({{-1}},np.int64)
  local v=np.array({{{2560,2561,2562,2563,2564}}},np.int64)
  a:set(v,ix1,ix2,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2,3,4},{5,6,7,8,9},{10,11,12,13,14},{15,16,17,18,19}},{{20,21,22,23,24},{25,26,27,28,29},{30,31,32,33,34},{2560,2561,2562,2563,2564}},{{40,41,42,43,44},{45,46,47,48,49},{50,51,52,53,54},{2560,2561,2562,2563,2564}},{{60,61,62,63,64},{65,66,67,68,69},{70,71,72,73,74},{75,76,77,78,79}},{{80,81,82,83,84},{85,86,87,88,89},{90,91,92,93,94},{95,96,97,98,99}}}),'advanced assignment 56')
end
do
  local a=np.reshape(np.arange(8),{2,2,2})
  local ix1=np.array({false,true},np.bool)
  local v=757
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1},{2,3}},{{757,757},{757,757}}}),'advanced assignment 57')
end
do
  local a=np.reshape(np.arange(40),{4,2,5})
  local ix1=np.array({{true,false},{false,false},{false,true},{true,false}},np.bool)
  local v=np.array({{1580,1581,1582,1583,1584},{1585,1586,1587,1588,1589},{1590,1591,1592,1593,1594}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{1580,1581,1582,1583,1584},{5,6,7,8,9}},{{10,11,12,13,14},{15,16,17,18,19}},{{20,21,22,23,24},{1585,1586,1587,1588,1589}},{{1590,1591,1592,1593,1594},{35,36,37,38,39}}}),'advanced assignment 58')
end
do
  local a=np.reshape(np.arange(30),{3,2,5})
  local ix1=np.array({2,5,-1},np.int64)
  local v=np.array({{2590,2591,2592}},np.int64)
  a:set(v,np.slice(nil,nil,1),2,ix1)
  assert(eq(a:tolist(),{{{0,1,2,3,4},{5,2590,7,8,2592}},{{10,11,12,13,14},{15,2590,17,18,2592}},{{20,21,22,23,24},{25,2590,27,28,2592}}}),'advanced assignment 59')
end
do
  local a=np.reshape(np.arange(75),{5,3,5})
  local ix1=np.array({5,3},np.int64)
  local v=760
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2,3,4},{5,6,7,8,9},{10,11,12,13,14}},{{15,16,17,18,19},{20,21,22,23,24},{25,26,27,28,29}},{{760,760,760,760,760},{760,760,760,760,760},{760,760,760,760,760}},{{45,46,47,48,49},{50,51,52,53,54},{55,56,57,58,59}},{{760,760,760,760,760},{760,760,760,760,760},{760,760,760,760,760}}}),'advanced assignment 60')
end
do
  local a=np.reshape(np.arange(32),{2,4,4})
  local ix1=np.array({-2,-1,2},np.int64)
  local ix2=np.array({-1,1,2},np.int64)
  local v=np.array({{1610,1611,1612,1613},{1614,1615,1616,1617},{1618,1619,1620,1621}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1),ix2)
  assert(eq(a:tolist(),{{{0,1,2,1610},{4,5,6,1611},{8,9,10,1612},{12,13,14,1613}},{{1614,1618,18,19},{1615,1619,22,23},{1616,1620,26,27},{1617,1621,30,31}}}),'advanced assignment 61')
end
do
  local a=np.reshape(np.arange(16),{2,4,2})
  local ix1=np.array({{-2}},np.int64)
  local ix2=np.array({{3,-3}},np.int64)
  local v=np.array({{{2620,2621},{2622,2623}}},np.int64)
  a:set(v,ix1,ix2,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1},{2622,2623},{2620,2621},{6,7}},{{8,9},{10,11},{12,13},{14,15}}}),'advanced assignment 62')
end
do
  local a=np.reshape(np.arange(30),{3,5,2})
  local ix1=np.array({true,true,false},np.bool)
  local v=763
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{763,763},{763,763},{763,763},{763,763},{763,763}},{{763,763},{763,763},{763,763},{763,763},{763,763}},{{20,21},{22,23},{24,25},{26,27},{28,29}}}),'advanced assignment 63')
end
do
  local a=np.reshape(np.arange(24),{2,4,3})
  local ix1=np.array({{false,true,true,false},{true,true,false,false}},np.bool)
  local v=np.array({{1640,1641,1642},{1643,1644,1645},{1646,1647,1648},{1649,1650,1651}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2},{1640,1641,1642},{1643,1644,1645},{9,10,11}},{{1646,1647,1648},{1649,1650,1651},{18,19,20},{21,22,23}}}),'advanced assignment 64')
end
do
  local a=np.reshape(np.arange(20),{2,2,5})
  local ix1=np.array({2,3,1},np.int64)
  local v=np.array({{2650,2651,2652}},np.int64)
  a:set(v,np.slice(nil,nil,1),1,ix1)
  assert(eq(a:tolist(),{{{2652,2650,2651,3,4},{5,6,7,8,9}},{{2652,2650,2651,13,14},{15,16,17,18,19}}}),'advanced assignment 65')
end
do
  local a=np.reshape(np.arange(36),{4,3,3})
  local ix1=np.array({1,-4},np.int64)
  local v=766
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{766,766,766},{766,766,766},{766,766,766}},{{9,10,11},{12,13,14},{15,16,17}},{{18,19,20},{21,22,23},{24,25,26}},{{27,28,29},{30,31,32},{33,34,35}}}),'advanced assignment 66')
end
do
  local a=np.reshape(np.arange(60),{4,5,3})
  local ix1=np.array({-1,-1,1},np.int64)
  local ix2=np.array({1,1,3},np.int64)
  local v=np.array({{1670,1671,1672,1673,1674},{1675,1676,1677,1678,1679},{1680,1681,1682,1683,1684}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1),ix2)
  assert(eq(a:tolist(),{{{0,1,1680},{3,4,1681},{6,7,1682},{9,10,1683},{12,13,1684}},{{15,16,17},{18,19,20},{21,22,23},{24,25,26},{27,28,29}},{{30,31,32},{33,34,35},{36,37,38},{39,40,41},{42,43,44}},{{1675,46,47},{1676,49,50},{1677,52,53},{1678,55,56},{1679,58,59}}}),'advanced assignment 67')
end
do
  local a=np.reshape(np.arange(40),{5,2,4})
  local ix1=np.array({{4}},np.int64)
  local ix2=np.array({{2,1}},np.int64)
  local v=np.array({{{2680,2681,2682,2683},{2684,2685,2686,2687}}},np.int64)
  a:set(v,ix1,ix2,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2,3},{4,5,6,7}},{{8,9,10,11},{12,13,14,15}},{{16,17,18,19},{20,21,22,23}},{{2684,2685,2686,2687},{2680,2681,2682,2683}},{{32,33,34,35},{36,37,38,39}}}),'advanced assignment 68')
end
do
  local a=np.reshape(np.arange(24),{4,2,3})
  local ix1=np.array({false,false,true,true},np.bool)
  local v=769
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2},{3,4,5}},{{6,7,8},{9,10,11}},{{769,769,769},{769,769,769}},{{769,769,769},{769,769,769}}}),'advanced assignment 69')
end
do
  local a=np.reshape(np.arange(40),{2,5,4})
  local ix1=np.array({{false,false,false,false,true},{true,true,true,true,false}},np.bool)
  local v=np.array({{1700,1701,1702,1703},{1704,1705,1706,1707},{1708,1709,1710,1711},{1712,1713,1714,1715},{1716,1717,1718,1719}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2,3},{4,5,6,7},{8,9,10,11},{12,13,14,15},{1700,1701,1702,1703}},{{1704,1705,1706,1707},{1708,1709,1710,1711},{1712,1713,1714,1715},{1716,1717,1718,1719},{36,37,38,39}}}),'advanced assignment 70')
end
do
  local a=np.reshape(np.arange(45),{3,5,3})
  local ix1=np.array({2},np.int64)
  local v=np.array({{2710}},np.int64)
  a:set(v,np.slice(nil,nil,1),4,ix1)
  assert(eq(a:tolist(),{{{0,1,2},{3,4,5},{6,7,8},{9,2710,11},{12,13,14}},{{15,16,17},{18,19,20},{21,22,23},{24,2710,26},{27,28,29}},{{30,31,32},{33,34,35},{36,37,38},{39,2710,41},{42,43,44}}}),'advanced assignment 71')
end
do
  local a=np.reshape(np.arange(24),{4,3,2})
  local ix1=np.array({-4,-4,2},np.int64)
  local v=772
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{772,772},{772,772},{772,772}},{{772,772},{772,772},{772,772}},{{12,13},{14,15},{16,17}},{{18,19},{20,21},{22,23}}}),'advanced assignment 72')
end
do
  local a=np.reshape(np.arange(60),{3,4,5})
  local ix1=np.array({3,3,3},np.int64)
  local ix2=np.array({2,5,-4},np.int64)
  local v=np.array({{1730,1731,1732,1733},{1734,1735,1736,1737},{1738,1739,1740,1741}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1),ix2)
  assert(eq(a:tolist(),{{{0,1,2,3,4},{5,6,7,8,9},{10,11,12,13,14},{15,16,17,18,19}},{{20,21,22,23,24},{25,26,27,28,29},{30,31,32,33,34},{35,36,37,38,39}},{{40,1738,42,43,1734},{45,1739,47,48,1735},{50,1740,52,53,1736},{55,1741,57,58,1737}}}),'advanced assignment 73')
end
do
  local a=np.reshape(np.arange(32),{4,2,4})
  local ix1=np.array({{-3},{4},{4}},np.int64)
  local ix2=np.array({{1,-1}},np.int64)
  local v=np.array({{{2740,2741,2742,2743},{2744,2745,2746,2747}}},np.int64)
  a:set(v,ix1,ix2,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2,3},{4,5,6,7}},{{2740,2741,2742,2743},{2744,2745,2746,2747}},{{16,17,18,19},{20,21,22,23}},{{2740,2741,2742,2743},{2744,2745,2746,2747}}}),'advanced assignment 74')
end
do
  local a=np.reshape(np.arange(48),{4,4,3})
  local ix1=np.array({false,true,true,true},np.bool)
  local v=775
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2},{3,4,5},{6,7,8},{9,10,11}},{{775,775,775},{775,775,775},{775,775,775},{775,775,775}},{{775,775,775},{775,775,775},{775,775,775},{775,775,775}},{{775,775,775},{775,775,775},{775,775,775},{775,775,775}}}),'advanced assignment 75')
end
do
  local a=np.reshape(np.arange(32),{4,4,2})
  local ix1=np.array({{false,false,true,true},{true,false,true,true},{false,false,false,false},{true,false,false,true}},np.bool)
  local v=np.array({{1760,1761},{1762,1763},{1764,1765},{1766,1767},{1768,1769},{1770,1771},{1772,1773}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1},{2,3},{1760,1761},{1762,1763}},{{1764,1765},{10,11},{1766,1767},{1768,1769}},{{16,17},{18,19},{20,21},{22,23}},{{1770,1771},{26,27},{28,29},{1772,1773}}}),'advanced assignment 76')
end
do
  local a=np.reshape(np.arange(75),{5,3,5})
  local ix1=np.array({1,5,4},np.int64)
  local v=np.array({{2770,2771,2772}},np.int64)
  a:set(v,np.slice(nil,nil,1),1,ix1)
  assert(eq(a:tolist(),{{{2770,1,2,2772,2771},{5,6,7,8,9},{10,11,12,13,14}},{{2770,16,17,2772,2771},{20,21,22,23,24},{25,26,27,28,29}},{{2770,31,32,2772,2771},{35,36,37,38,39},{40,41,42,43,44}},{{2770,46,47,2772,2771},{50,51,52,53,54},{55,56,57,58,59}},{{2770,61,62,2772,2771},{65,66,67,68,69},{70,71,72,73,74}}}),'advanced assignment 77')
end
do
  local a=np.reshape(np.arange(12),{2,3,2})
  local ix1=np.array({-1,1,1},np.int64)
  local v=778
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{778,778},{778,778},{778,778}},{{778,778},{778,778},{778,778}}}),'advanced assignment 78')
end
do
  local a=np.reshape(np.arange(50),{5,2,5})
  local ix1=np.array({4},np.int64)
  local ix2=np.array({4},np.int64)
  local v=np.array({{1790,1791}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1),ix2)
  assert(eq(a:tolist(),{{{0,1,2,3,4},{5,6,7,8,9}},{{10,11,12,13,14},{15,16,17,18,19}},{{20,21,22,23,24},{25,26,27,28,29}},{{30,31,32,1790,34},{35,36,37,1791,39}},{{40,41,42,43,44},{45,46,47,48,49}}}),'advanced assignment 79')
end
do
  local a=np.reshape(np.arange(32),{2,4,4})
  local ix1=np.array({{2},{2},{1}},np.int64)
  local ix2=np.array({{-2}},np.int64)
  local v=np.array({{{2800,2801,2802,2803}}},np.int64)
  a:set(v,ix1,ix2,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2,3},{4,5,6,7},{2800,2801,2802,2803},{12,13,14,15}},{{16,17,18,19},{20,21,22,23},{2800,2801,2802,2803},{28,29,30,31}}}),'advanced assignment 80')
end
do
  local a=np.reshape(np.arange(50),{5,2,5})
  local ix1=np.array({true,false,true,true,false},np.bool)
  local v=781
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{781,781,781,781,781},{781,781,781,781,781}},{{10,11,12,13,14},{15,16,17,18,19}},{{781,781,781,781,781},{781,781,781,781,781}},{{781,781,781,781,781},{781,781,781,781,781}},{{40,41,42,43,44},{45,46,47,48,49}}}),'advanced assignment 81')
end
do
  local a=np.reshape(np.arange(60),{4,5,3})
  local ix1=np.array({{false,false,true,false,false},{true,true,true,true,true},{false,false,false,false,false},{true,false,true,false,false}},np.bool)
  local v=np.array({{1820,1821,1822},{1823,1824,1825},{1826,1827,1828},{1829,1830,1831},{1832,1833,1834},{1835,1836,1837},{1838,1839,1840},{1841,1842,1843}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2},{3,4,5},{1820,1821,1822},{9,10,11},{12,13,14}},{{1823,1824,1825},{1826,1827,1828},{1829,1830,1831},{1832,1833,1834},{1835,1836,1837}},{{30,31,32},{33,34,35},{36,37,38},{39,40,41},{42,43,44}},{{1838,1839,1840},{48,49,50},{1841,1842,1843},{54,55,56},{57,58,59}}}),'advanced assignment 82')
end
do
  local a=np.reshape(np.arange(60),{3,5,4})
  local ix1=np.array({2,1},np.int64)
  local v=np.array({{2830,2831}},np.int64)
  a:set(v,np.slice(nil,nil,1),4,ix1)
  assert(eq(a:tolist(),{{{0,1,2,3},{4,5,6,7},{8,9,10,11},{2831,2830,14,15},{16,17,18,19}},{{20,21,22,23},{24,25,26,27},{28,29,30,31},{2831,2830,34,35},{36,37,38,39}},{{40,41,42,43},{44,45,46,47},{48,49,50,51},{2831,2830,54,55},{56,57,58,59}}}),'advanced assignment 83')
end
do
  local a=np.reshape(np.arange(60),{5,4,3})
  local ix1=np.array({-2,4},np.int64)
  local v=784
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2},{3,4,5},{6,7,8},{9,10,11}},{{12,13,14},{15,16,17},{18,19,20},{21,22,23}},{{24,25,26},{27,28,29},{30,31,32},{33,34,35}},{{784,784,784},{784,784,784},{784,784,784},{784,784,784}},{{48,49,50},{51,52,53},{54,55,56},{57,58,59}}}),'advanced assignment 84')
end
do
  local a=np.reshape(np.arange(40),{2,4,5})
  local ix1=np.array({2,-2},np.int64)
  local ix2=np.array({3,1},np.int64)
  local v=np.array({{1850,1851,1852,1853},{1854,1855,1856,1857}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1),ix2)
  assert(eq(a:tolist(),{{{1854,1,2,3,4},{1855,6,7,8,9},{1856,11,12,13,14},{1857,16,17,18,19}},{{20,21,1850,23,24},{25,26,1851,28,29},{30,31,1852,33,34},{35,36,1853,38,39}}}),'advanced assignment 85')
end
do
  local a=np.reshape(np.arange(40),{4,2,5})
  local ix1=np.array({{1},{1},{1}},np.int64)
  local ix2=np.array({{2,2}},np.int64)
  local v=np.array({{{2860,2861,2862,2863,2864},{2865,2866,2867,2868,2869}}},np.int64)
  a:set(v,ix1,ix2,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2,3,4},{2865,2866,2867,2868,2869}},{{10,11,12,13,14},{15,16,17,18,19}},{{20,21,22,23,24},{25,26,27,28,29}},{{30,31,32,33,34},{35,36,37,38,39}}}),'advanced assignment 86')
end
do
  local a=np.reshape(np.arange(45),{5,3,3})
  local ix1=np.array({false,false,false,true,true},np.bool)
  local v=787
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2},{3,4,5},{6,7,8}},{{9,10,11},{12,13,14},{15,16,17}},{{18,19,20},{21,22,23},{24,25,26}},{{787,787,787},{787,787,787},{787,787,787}},{{787,787,787},{787,787,787},{787,787,787}}}),'advanced assignment 87')
end
do
  local a=np.reshape(np.arange(18),{3,2,3})
  local ix1=np.array({{true,false},{false,false},{false,false}},np.bool)
  local v=np.array({{1880,1881,1882}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{1880,1881,1882},{3,4,5}},{{6,7,8},{9,10,11}},{{12,13,14},{15,16,17}}}),'advanced assignment 88')
end
do
  local a=np.reshape(np.arange(36),{3,3,4})
  local ix1=np.array({4,4},np.int64)
  local v=np.array({{2890,2891}},np.int64)
  a:set(v,np.slice(nil,nil,1),2,ix1)
  assert(eq(a:tolist(),{{{0,1,2,3},{4,5,6,2891},{8,9,10,11}},{{12,13,14,15},{16,17,18,2891},{20,21,22,23}},{{24,25,26,27},{28,29,30,2891},{32,33,34,35}}}),'advanced assignment 89')
end
do
  local a=np.reshape(np.arange(20),{2,2,5})
  local ix1=np.array({1,-2},np.int64)
  local v=790
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{790,790,790,790,790},{790,790,790,790,790}},{{10,11,12,13,14},{15,16,17,18,19}}}),'advanced assignment 90')
end
do
  local a=np.reshape(np.arange(45),{5,3,3})
  local ix1=np.array({5,3},np.int64)
  local ix2=np.array({3,-2},np.int64)
  local v=np.array({{1910,1911,1912},{1913,1914,1915}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1),ix2)
  assert(eq(a:tolist(),{{{0,1,2},{3,4,5},{6,7,8}},{{9,10,11},{12,13,14},{15,16,17}},{{18,1913,20},{21,1914,23},{24,1915,26}},{{27,28,29},{30,31,32},{33,34,35}},{{36,37,1910},{39,40,1911},{42,43,1912}}}),'advanced assignment 91')
end
do
  local a=np.reshape(np.arange(50),{5,5,2})
  local ix1=np.array({{4},{3}},np.int64)
  local ix2=np.array({{-2,4,-2}},np.int64)
  local v=np.array({{{2920,2921},{2922,2923},{2924,2925}}},np.int64)
  a:set(v,ix1,ix2,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1},{2,3},{4,5},{6,7},{8,9}},{{10,11},{12,13},{14,15},{16,17},{18,19}},{{20,21},{22,23},{24,25},{2924,2925},{28,29}},{{30,31},{32,33},{34,35},{2924,2925},{38,39}},{{40,41},{42,43},{44,45},{46,47},{48,49}}}),'advanced assignment 92')
end
do
  local a=np.reshape(np.arange(12),{2,2,3})
  local ix1=np.array({true,true},np.bool)
  local v=793
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{793,793,793},{793,793,793}},{{793,793,793},{793,793,793}}}),'advanced assignment 93')
end
do
  local a=np.reshape(np.arange(30),{2,5,3})
  local ix1=np.array({{true,false,true,true,false},{false,false,true,true,true}},np.bool)
  local v=np.array({{1940,1941,1942},{1943,1944,1945},{1946,1947,1948},{1949,1950,1951},{1952,1953,1954},{1955,1956,1957}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{1940,1941,1942},{3,4,5},{1943,1944,1945},{1946,1947,1948},{12,13,14}},{{15,16,17},{18,19,20},{1949,1950,1951},{1952,1953,1954},{1955,1956,1957}}}),'advanced assignment 94')
end
do
  local a=np.reshape(np.arange(48),{4,3,4})
  local ix1=np.array({1,4,-2},np.int64)
  local v=np.array({{2950,2951,2952}},np.int64)
  a:set(v,np.slice(nil,nil,1),1,ix1)
  assert(eq(a:tolist(),{{{2950,1,2952,2951},{4,5,6,7},{8,9,10,11}},{{2950,13,2952,2951},{16,17,18,19},{20,21,22,23}},{{2950,25,2952,2951},{28,29,30,31},{32,33,34,35}},{{2950,37,2952,2951},{40,41,42,43},{44,45,46,47}}}),'advanced assignment 95')
end
do
  local a=np.reshape(np.arange(80),{4,5,4})
  local ix1=np.array({4},np.int64)
  local v=796
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2,3},{4,5,6,7},{8,9,10,11},{12,13,14,15},{16,17,18,19}},{{20,21,22,23},{24,25,26,27},{28,29,30,31},{32,33,34,35},{36,37,38,39}},{{40,41,42,43},{44,45,46,47},{48,49,50,51},{52,53,54,55},{56,57,58,59}},{{796,796,796,796},{796,796,796,796},{796,796,796,796},{796,796,796,796},{796,796,796,796}}}),'advanced assignment 96')
end
do
  local a=np.reshape(np.arange(24),{4,3,2})
  local ix1=np.array({4},np.int64)
  local ix2=np.array({1},np.int64)
  local v=np.array({{1970,1971,1972}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1),ix2)
  assert(eq(a:tolist(),{{{0,1},{2,3},{4,5}},{{6,7},{8,9},{10,11}},{{12,13},{14,15},{16,17}},{{1970,19},{1971,21},{1972,23}}}),'advanced assignment 97')
end
do
  local a=np.reshape(np.arange(60),{5,3,4})
  local ix1=np.array({{3},{-4},{2}},np.int64)
  local ix2=np.array({{2,2}},np.int64)
  local v=np.array({{{2980,2981,2982,2983},{2984,2985,2986,2987}}},np.int64)
  a:set(v,ix1,ix2,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2,3},{4,5,6,7},{8,9,10,11}},{{12,13,14,15},{2984,2985,2986,2987},{20,21,22,23}},{{24,25,26,27},{2984,2985,2986,2987},{32,33,34,35}},{{36,37,38,39},{40,41,42,43},{44,45,46,47}},{{48,49,50,51},{52,53,54,55},{56,57,58,59}}}),'advanced assignment 98')
end
do
  local a=np.reshape(np.arange(32),{4,2,4})
  local ix1=np.array({true,false,true,false},np.bool)
  local v=799
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{799,799,799,799},{799,799,799,799}},{{8,9,10,11},{12,13,14,15}},{{799,799,799,799},{799,799,799,799}},{{24,25,26,27},{28,29,30,31}}}),'advanced assignment 99')
end
do
  local a=np.reshape(np.arange(100),{5,5,4})
  local ix1=np.array({{false,true,false,true,false},{false,false,true,true,false},{false,true,true,false,false},{true,true,false,true,false},{false,true,true,false,false}},np.bool)
  local v=np.array({{2000,2001,2002,2003},{2004,2005,2006,2007},{2008,2009,2010,2011},{2012,2013,2014,2015},{2016,2017,2018,2019},{2020,2021,2022,2023},{2024,2025,2026,2027},{2028,2029,2030,2031},{2032,2033,2034,2035},{2036,2037,2038,2039},{2040,2041,2042,2043}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2,3},{2000,2001,2002,2003},{8,9,10,11},{2004,2005,2006,2007},{16,17,18,19}},{{20,21,22,23},{24,25,26,27},{2008,2009,2010,2011},{2012,2013,2014,2015},{36,37,38,39}},{{40,41,42,43},{2016,2017,2018,2019},{2020,2021,2022,2023},{52,53,54,55},{56,57,58,59}},{{2024,2025,2026,2027},{2028,2029,2030,2031},{68,69,70,71},{2032,2033,2034,2035},{76,77,78,79}},{{80,81,82,83},{2036,2037,2038,2039},{2040,2041,2042,2043},{92,93,94,95},{96,97,98,99}}}),'advanced assignment 100')
end
do
  local a=np.reshape(np.arange(60),{3,4,5})
  local ix1=np.array({5,2},np.int64)
  local v=np.array({{3010,3011}},np.int64)
  a:set(v,np.slice(nil,nil,1),2,ix1)
  assert(eq(a:tolist(),{{{0,1,2,3,4},{5,3011,7,8,3010},{10,11,12,13,14},{15,16,17,18,19}},{{20,21,22,23,24},{25,3011,27,28,3010},{30,31,32,33,34},{35,36,37,38,39}},{{40,41,42,43,44},{45,3011,47,48,3010},{50,51,52,53,54},{55,56,57,58,59}}}),'advanced assignment 101')
end
do
  local a=np.reshape(np.arange(27),{3,3,3})
  local ix1=np.array({3},np.int64)
  local v=802
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2},{3,4,5},{6,7,8}},{{9,10,11},{12,13,14},{15,16,17}},{{802,802,802},{802,802,802},{802,802,802}}}),'advanced assignment 102')
end
do
  local a=np.reshape(np.arange(36),{4,3,3})
  local ix1=np.array({3},np.int64)
  local ix2=np.array({1},np.int64)
  local v=np.array({{2030,2031,2032}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1),ix2)
  assert(eq(a:tolist(),{{{0,1,2},{3,4,5},{6,7,8}},{{9,10,11},{12,13,14},{15,16,17}},{{2030,19,20},{2031,22,23},{2032,25,26}},{{27,28,29},{30,31,32},{33,34,35}}}),'advanced assignment 103')
end
do
  local a=np.reshape(np.arange(18),{3,2,3})
  local ix1=np.array({{2}},np.int64)
  local ix2=np.array({{1}},np.int64)
  local v=np.array({{{3040,3041,3042}}},np.int64)
  a:set(v,ix1,ix2,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2},{3,4,5}},{{3040,3041,3042},{9,10,11}},{{12,13,14},{15,16,17}}}),'advanced assignment 104')
end
do
  local a=np.reshape(np.arange(80),{4,5,4})
  local ix1=np.array({false,false,false,true},np.bool)
  local v=805
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2,3},{4,5,6,7},{8,9,10,11},{12,13,14,15},{16,17,18,19}},{{20,21,22,23},{24,25,26,27},{28,29,30,31},{32,33,34,35},{36,37,38,39}},{{40,41,42,43},{44,45,46,47},{48,49,50,51},{52,53,54,55},{56,57,58,59}},{{805,805,805,805},{805,805,805,805},{805,805,805,805},{805,805,805,805},{805,805,805,805}}}),'advanced assignment 105')
end
do
  local a=np.reshape(np.arange(24),{2,3,4})
  local ix1=np.array({{true,false,false},{false,false,false}},np.bool)
  local v=np.array({{2060,2061,2062,2063}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{2060,2061,2062,2063},{4,5,6,7},{8,9,10,11}},{{12,13,14,15},{16,17,18,19},{20,21,22,23}}}),'advanced assignment 106')
end
do
  local a=np.reshape(np.arange(75),{3,5,5})
  local ix1=np.array({1,5},np.int64)
  local v=np.array({{3070,3071}},np.int64)
  a:set(v,np.slice(nil,nil,1),2,ix1)
  assert(eq(a:tolist(),{{{0,1,2,3,4},{3070,6,7,8,3071},{10,11,12,13,14},{15,16,17,18,19},{20,21,22,23,24}},{{25,26,27,28,29},{3070,31,32,33,3071},{35,36,37,38,39},{40,41,42,43,44},{45,46,47,48,49}},{{50,51,52,53,54},{3070,56,57,58,3071},{60,61,62,63,64},{65,66,67,68,69},{70,71,72,73,74}}}),'advanced assignment 107')
end
do
  local a=np.reshape(np.arange(32),{4,4,2})
  local ix1=np.array({-3,1,1},np.int64)
  local v=808
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{808,808},{808,808},{808,808},{808,808}},{{808,808},{808,808},{808,808},{808,808}},{{16,17},{18,19},{20,21},{22,23}},{{24,25},{26,27},{28,29},{30,31}}}),'advanced assignment 108')
end
do
  local a=np.reshape(np.arange(75),{5,5,3})
  local ix1=np.array({-2,2},np.int64)
  local ix2=np.array({2,-2},np.int64)
  local v=np.array({{2090,2091,2092,2093,2094},{2095,2096,2097,2098,2099}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1),ix2)
  assert(eq(a:tolist(),{{{0,1,2},{3,4,5},{6,7,8},{9,10,11},{12,13,14}},{{15,2095,17},{18,2096,20},{21,2097,23},{24,2098,26},{27,2099,29}},{{30,31,32},{33,34,35},{36,37,38},{39,40,41},{42,43,44}},{{45,2090,47},{48,2091,50},{51,2092,53},{54,2093,56},{57,2094,59}},{{60,61,62},{63,64,65},{66,67,68},{69,70,71},{72,73,74}}}),'advanced assignment 109')
end
do
  local a=np.reshape(np.arange(36),{4,3,3})
  local ix1=np.array({{3},{1},{-1}},np.int64)
  local ix2=np.array({{1,-3}},np.int64)
  local v=np.array({{{3100,3101,3102},{3103,3104,3105}}},np.int64)
  a:set(v,ix1,ix2,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{3103,3104,3105},{3,4,5},{6,7,8}},{{9,10,11},{12,13,14},{15,16,17}},{{3103,3104,3105},{21,22,23},{24,25,26}},{{3103,3104,3105},{30,31,32},{33,34,35}}}),'advanced assignment 110')
end
do
  local a=np.reshape(np.arange(60),{5,3,4})
  local ix1=np.array({true,true,true,false,false},np.bool)
  local v=811
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{811,811,811,811},{811,811,811,811},{811,811,811,811}},{{811,811,811,811},{811,811,811,811},{811,811,811,811}},{{811,811,811,811},{811,811,811,811},{811,811,811,811}},{{36,37,38,39},{40,41,42,43},{44,45,46,47}},{{48,49,50,51},{52,53,54,55},{56,57,58,59}}}),'advanced assignment 111')
end
do
  local a=np.reshape(np.arange(125),{5,5,5})
  local ix1=np.array({{true,false,false,false,true},{false,true,false,false,true},{false,false,false,false,true},{true,false,true,false,false},{false,true,false,false,false}},np.bool)
  local v=np.array({{2120,2121,2122,2123,2124},{2125,2126,2127,2128,2129},{2130,2131,2132,2133,2134},{2135,2136,2137,2138,2139},{2140,2141,2142,2143,2144},{2145,2146,2147,2148,2149},{2150,2151,2152,2153,2154},{2155,2156,2157,2158,2159}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{2120,2121,2122,2123,2124},{5,6,7,8,9},{10,11,12,13,14},{15,16,17,18,19},{2125,2126,2127,2128,2129}},{{25,26,27,28,29},{2130,2131,2132,2133,2134},{35,36,37,38,39},{40,41,42,43,44},{2135,2136,2137,2138,2139}},{{50,51,52,53,54},{55,56,57,58,59},{60,61,62,63,64},{65,66,67,68,69},{2140,2141,2142,2143,2144}},{{2145,2146,2147,2148,2149},{80,81,82,83,84},{2150,2151,2152,2153,2154},{90,91,92,93,94},{95,96,97,98,99}},{{100,101,102,103,104},{2155,2156,2157,2158,2159},{110,111,112,113,114},{115,116,117,118,119},{120,121,122,123,124}}}),'advanced assignment 112')
end
do
  local a=np.reshape(np.arange(45),{5,3,3})
  local ix1=np.array({1},np.int64)
  local v=np.array({{3130}},np.int64)
  a:set(v,np.slice(nil,nil,1),1,ix1)
  assert(eq(a:tolist(),{{{3130,1,2},{3,4,5},{6,7,8}},{{3130,10,11},{12,13,14},{15,16,17}},{{3130,19,20},{21,22,23},{24,25,26}},{{3130,28,29},{30,31,32},{33,34,35}},{{3130,37,38},{39,40,41},{42,43,44}}}),'advanced assignment 113')
end
do
  local a=np.reshape(np.arange(36),{3,4,3})
  local ix1=np.array({2,-3,3},np.int64)
  local v=814
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{814,814,814},{814,814,814},{814,814,814},{814,814,814}},{{814,814,814},{814,814,814},{814,814,814},{814,814,814}},{{814,814,814},{814,814,814},{814,814,814},{814,814,814}}}),'advanced assignment 114')
end
do
  local a=np.reshape(np.arange(36),{3,4,3})
  local ix1=np.array({2,-1,-3},np.int64)
  local ix2=np.array({-1,3,-1},np.int64)
  local v=np.array({{2150,2151,2152,2153},{2154,2155,2156,2157},{2158,2159,2160,2161}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1),ix2)
  assert(eq(a:tolist(),{{{0,1,2158},{3,4,2159},{6,7,2160},{9,10,2161}},{{12,13,2150},{15,16,2151},{18,19,2152},{21,22,2153}},{{24,25,2154},{27,28,2155},{30,31,2156},{33,34,2157}}}),'advanced assignment 115')
end
do
  local a=np.reshape(np.arange(125),{5,5,5})
  local ix1=np.array({{5},{-3},{4}},np.int64)
  local ix2=np.array({{-3,4,-1}},np.int64)
  local v=np.array({{{3160,3161,3162,3163,3164},{3165,3166,3167,3168,3169},{3170,3171,3172,3173,3174}}},np.int64)
  a:set(v,ix1,ix2,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2,3,4},{5,6,7,8,9},{10,11,12,13,14},{15,16,17,18,19},{20,21,22,23,24}},{{25,26,27,28,29},{30,31,32,33,34},{35,36,37,38,39},{40,41,42,43,44},{45,46,47,48,49}},{{50,51,52,53,54},{55,56,57,58,59},{3160,3161,3162,3163,3164},{3165,3166,3167,3168,3169},{3170,3171,3172,3173,3174}},{{75,76,77,78,79},{80,81,82,83,84},{3160,3161,3162,3163,3164},{3165,3166,3167,3168,3169},{3170,3171,3172,3173,3174}},{{100,101,102,103,104},{105,106,107,108,109},{3160,3161,3162,3163,3164},{3165,3166,3167,3168,3169},{3170,3171,3172,3173,3174}}}),'advanced assignment 116')
end
do
  local a=np.reshape(np.arange(60),{4,3,5})
  local ix1=np.array({false,true,true,true},np.bool)
  local v=817
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2,3,4},{5,6,7,8,9},{10,11,12,13,14}},{{817,817,817,817,817},{817,817,817,817,817},{817,817,817,817,817}},{{817,817,817,817,817},{817,817,817,817,817},{817,817,817,817,817}},{{817,817,817,817,817},{817,817,817,817,817},{817,817,817,817,817}}}),'advanced assignment 117')
end
do
  local a=np.reshape(np.arange(75),{3,5,5})
  local ix1=np.array({{false,false,false,false,false},{true,false,true,true,false},{false,false,true,true,false}},np.bool)
  local v=np.array({{2180,2181,2182,2183,2184},{2185,2186,2187,2188,2189},{2190,2191,2192,2193,2194},{2195,2196,2197,2198,2199},{2200,2201,2202,2203,2204}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2,3,4},{5,6,7,8,9},{10,11,12,13,14},{15,16,17,18,19},{20,21,22,23,24}},{{2180,2181,2182,2183,2184},{30,31,32,33,34},{2185,2186,2187,2188,2189},{2190,2191,2192,2193,2194},{45,46,47,48,49}},{{50,51,52,53,54},{55,56,57,58,59},{2195,2196,2197,2198,2199},{2200,2201,2202,2203,2204},{70,71,72,73,74}}}),'advanced assignment 118')
end
do
  local a=np.reshape(np.arange(20),{5,2,2})
  local ix1=np.array({2,1,1},np.int64)
  local v=np.array({{3190,3191,3192}},np.int64)
  a:set(v,np.slice(nil,nil,1),2,ix1)
  assert(eq(a:tolist(),{{{0,1},{3192,3190}},{{4,5},{3192,3190}},{{8,9},{3192,3190}},{{12,13},{3192,3190}},{{16,17},{3192,3190}}}),'advanced assignment 119')
end
do
  local a=np.reshape(np.arange(60),{3,5,4})
  local ix1=np.array({2},np.int64)
  local v=820
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2,3},{4,5,6,7},{8,9,10,11},{12,13,14,15},{16,17,18,19}},{{820,820,820,820},{820,820,820,820},{820,820,820,820},{820,820,820,820},{820,820,820,820}},{{40,41,42,43},{44,45,46,47},{48,49,50,51},{52,53,54,55},{56,57,58,59}}}),'advanced assignment 120')
end
do
  local a=np.reshape(np.arange(45),{3,3,5})
  local ix1=np.array({-1},np.int64)
  local ix2=np.array({3},np.int64)
  local v=np.array({{2210,2211,2212}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1),ix2)
  assert(eq(a:tolist(),{{{0,1,2,3,4},{5,6,7,8,9},{10,11,12,13,14}},{{15,16,17,18,19},{20,21,22,23,24},{25,26,27,28,29}},{{30,31,2210,33,34},{35,36,2211,38,39},{40,41,2212,43,44}}}),'advanced assignment 121')
end
do
  local a=np.reshape(np.arange(40),{2,4,5})
  local ix1=np.array({{1},{1},{2}},np.int64)
  local ix2=np.array({{-1}},np.int64)
  local v=np.array({{{3220,3221,3222,3223,3224}}},np.int64)
  a:set(v,ix1,ix2,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2,3,4},{5,6,7,8,9},{10,11,12,13,14},{3220,3221,3222,3223,3224}},{{20,21,22,23,24},{25,26,27,28,29},{30,31,32,33,34},{3220,3221,3222,3223,3224}}}),'advanced assignment 122')
end
do
  local a=np.reshape(np.arange(80),{4,5,4})
  local ix1=np.array({false,false,true,false},np.bool)
  local v=823
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2,3},{4,5,6,7},{8,9,10,11},{12,13,14,15},{16,17,18,19}},{{20,21,22,23},{24,25,26,27},{28,29,30,31},{32,33,34,35},{36,37,38,39}},{{823,823,823,823},{823,823,823,823},{823,823,823,823},{823,823,823,823},{823,823,823,823}},{{60,61,62,63},{64,65,66,67},{68,69,70,71},{72,73,74,75},{76,77,78,79}}}),'advanced assignment 123')
end
do
  local a=np.reshape(np.arange(75),{5,3,5})
  local ix1=np.array({{false,false,false},{false,false,false},{false,false,false},{false,false,false},{false,true,false}},np.bool)
  local v=np.array({{2240,2241,2242,2243,2244}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2,3,4},{5,6,7,8,9},{10,11,12,13,14}},{{15,16,17,18,19},{20,21,22,23,24},{25,26,27,28,29}},{{30,31,32,33,34},{35,36,37,38,39},{40,41,42,43,44}},{{45,46,47,48,49},{50,51,52,53,54},{55,56,57,58,59}},{{60,61,62,63,64},{2240,2241,2242,2243,2244},{70,71,72,73,74}}}),'advanced assignment 124')
end
do
  local a=np.reshape(np.arange(24),{4,2,3})
  local ix1=np.array({1,-1,1},np.int64)
  local v=np.array({{3250,3251,3252}},np.int64)
  a:set(v,np.slice(nil,nil,1),2,ix1)
  assert(eq(a:tolist(),{{{0,1,2},{3252,4,3251}},{{6,7,8},{3252,10,3251}},{{12,13,14},{3252,16,3251}},{{18,19,20},{3252,22,3251}}}),'advanced assignment 125')
end
do
  local a=np.reshape(np.arange(24),{2,3,4})
  local ix1=np.array({1,2},np.int64)
  local v=826
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{826,826,826,826},{826,826,826,826},{826,826,826,826}},{{826,826,826,826},{826,826,826,826},{826,826,826,826}}}),'advanced assignment 126')
end
do
  local a=np.reshape(np.arange(30),{5,3,2})
  local ix1=np.array({2},np.int64)
  local ix2=np.array({1},np.int64)
  local v=np.array({{2270,2271,2272}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1),ix2)
  assert(eq(a:tolist(),{{{0,1},{2,3},{4,5}},{{2270,7},{2271,9},{2272,11}},{{12,13},{14,15},{16,17}},{{18,19},{20,21},{22,23}},{{24,25},{26,27},{28,29}}}),'advanced assignment 127')
end
do
  local a=np.reshape(np.arange(40),{2,5,4})
  local ix1=np.array({{2}},np.int64)
  local ix2=np.array({{2}},np.int64)
  local v=np.array({{{3280,3281,3282,3283}}},np.int64)
  a:set(v,ix1,ix2,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2,3},{4,5,6,7},{8,9,10,11},{12,13,14,15},{16,17,18,19}},{{20,21,22,23},{3280,3281,3282,3283},{28,29,30,31},{32,33,34,35},{36,37,38,39}}}),'advanced assignment 128')
end
do
  local a=np.reshape(np.arange(36),{4,3,3})
  local ix1=np.array({true,true,true,true},np.bool)
  local v=829
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{829,829,829},{829,829,829},{829,829,829}},{{829,829,829},{829,829,829},{829,829,829}},{{829,829,829},{829,829,829},{829,829,829}},{{829,829,829},{829,829,829},{829,829,829}}}),'advanced assignment 129')
end
do
  local a=np.reshape(np.arange(24),{2,4,3})
  local ix1=np.array({{true,true,false,true},{true,true,true,false}},np.bool)
  local v=np.array({{2300,2301,2302},{2303,2304,2305},{2306,2307,2308},{2309,2310,2311},{2312,2313,2314},{2315,2316,2317}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{2300,2301,2302},{2303,2304,2305},{6,7,8},{2306,2307,2308}},{{2309,2310,2311},{2312,2313,2314},{2315,2316,2317},{21,22,23}}}),'advanced assignment 130')
end
do
  local a=np.reshape(np.arange(30),{5,2,3})
  local ix1=np.array({1},np.int64)
  local v=np.array({{3310}},np.int64)
  a:set(v,np.slice(nil,nil,1),2,ix1)
  assert(eq(a:tolist(),{{{0,1,2},{3310,4,5}},{{6,7,8},{3310,10,11}},{{12,13,14},{3310,16,17}},{{18,19,20},{3310,22,23}},{{24,25,26},{3310,28,29}}}),'advanced assignment 131')
end
do
  local a=np.reshape(np.arange(12),{2,3,2})
  local ix1=np.array({-1},np.int64)
  local v=832
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1},{2,3},{4,5}},{{832,832},{832,832},{832,832}}}),'advanced assignment 132')
end
do
  local a=np.reshape(np.arange(24),{4,2,3})
  local ix1=np.array({1,1,-3},np.int64)
  local ix2=np.array({2,3,2},np.int64)
  local v=np.array({{2330,2331},{2332,2333},{2334,2335}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1),ix2)
  assert(eq(a:tolist(),{{{0,2330,2332},{3,2331,2333}},{{6,2334,8},{9,2335,11}},{{12,13,14},{15,16,17}},{{18,19,20},{21,22,23}}}),'advanced assignment 133')
end
do
  local a=np.reshape(np.arange(45),{5,3,3})
  local ix1=np.array({{1},{-4},{3}},np.int64)
  local ix2=np.array({{-2,1}},np.int64)
  local v=np.array({{{3340,3341,3342},{3343,3344,3345}}},np.int64)
  a:set(v,ix1,ix2,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{3343,3344,3345},{3340,3341,3342},{6,7,8}},{{3343,3344,3345},{3340,3341,3342},{15,16,17}},{{3343,3344,3345},{3340,3341,3342},{24,25,26}},{{27,28,29},{30,31,32},{33,34,35}},{{36,37,38},{39,40,41},{42,43,44}}}),'advanced assignment 134')
end
do
  local a=np.reshape(np.arange(30),{2,3,5})
  local ix1=np.array({false,true},np.bool)
  local v=835
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2,3,4},{5,6,7,8,9},{10,11,12,13,14}},{{835,835,835,835,835},{835,835,835,835,835},{835,835,835,835,835}}}),'advanced assignment 135')
end
do
  local a=np.reshape(np.arange(100),{4,5,5})
  local ix1=np.array({{true,false,true,false,true},{false,true,false,false,true},{true,false,false,true,false},{false,true,true,false,true}},np.bool)
  local v=np.array({{2360,2361,2362,2363,2364},{2365,2366,2367,2368,2369},{2370,2371,2372,2373,2374},{2375,2376,2377,2378,2379},{2380,2381,2382,2383,2384},{2385,2386,2387,2388,2389},{2390,2391,2392,2393,2394},{2395,2396,2397,2398,2399},{2400,2401,2402,2403,2404},{2405,2406,2407,2408,2409}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{2360,2361,2362,2363,2364},{5,6,7,8,9},{2365,2366,2367,2368,2369},{15,16,17,18,19},{2370,2371,2372,2373,2374}},{{25,26,27,28,29},{2375,2376,2377,2378,2379},{35,36,37,38,39},{40,41,42,43,44},{2380,2381,2382,2383,2384}},{{2385,2386,2387,2388,2389},{55,56,57,58,59},{60,61,62,63,64},{2390,2391,2392,2393,2394},{70,71,72,73,74}},{{75,76,77,78,79},{2395,2396,2397,2398,2399},{2400,2401,2402,2403,2404},{90,91,92,93,94},{2405,2406,2407,2408,2409}}}),'advanced assignment 136')
end
do
  local a=np.reshape(np.arange(60),{4,5,3})
  local ix1=np.array({2,2},np.int64)
  local v=np.array({{3370,3371}},np.int64)
  a:set(v,np.slice(nil,nil,1),5,ix1)
  assert(eq(a:tolist(),{{{0,1,2},{3,4,5},{6,7,8},{9,10,11},{12,3371,14}},{{15,16,17},{18,19,20},{21,22,23},{24,25,26},{27,3371,29}},{{30,31,32},{33,34,35},{36,37,38},{39,40,41},{42,3371,44}},{{45,46,47},{48,49,50},{51,52,53},{54,55,56},{57,3371,59}}}),'advanced assignment 137')
end
do
  local a=np.reshape(np.arange(48),{4,4,3})
  local ix1=np.array({3,1,4},np.int64)
  local v=838
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{838,838,838},{838,838,838},{838,838,838},{838,838,838}},{{12,13,14},{15,16,17},{18,19,20},{21,22,23}},{{838,838,838},{838,838,838},{838,838,838},{838,838,838}},{{838,838,838},{838,838,838},{838,838,838},{838,838,838}}}),'advanced assignment 138')
end
do
  local a=np.reshape(np.arange(8),{2,2,2})
  local ix1=np.array({1,1},np.int64)
  local ix2=np.array({1,1},np.int64)
  local v=np.array({{2390,2391},{2392,2393}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1),ix2)
  assert(eq(a:tolist(),{{{2392,1},{2393,3}},{{4,5},{6,7}}}),'advanced assignment 139')
end
do
  local a=np.reshape(np.arange(80),{4,4,5})
  local ix1=np.array({{-4},{1}},np.int64)
  local ix2=np.array({{-1,-4}},np.int64)
  local v=np.array({{{3400,3401,3402,3403,3404},{3405,3406,3407,3408,3409}}},np.int64)
  a:set(v,ix1,ix2,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{3405,3406,3407,3408,3409},{5,6,7,8,9},{10,11,12,13,14},{3400,3401,3402,3403,3404}},{{20,21,22,23,24},{25,26,27,28,29},{30,31,32,33,34},{35,36,37,38,39}},{{40,41,42,43,44},{45,46,47,48,49},{50,51,52,53,54},{55,56,57,58,59}},{{60,61,62,63,64},{65,66,67,68,69},{70,71,72,73,74},{75,76,77,78,79}}}),'advanced assignment 140')
end
do
  local a=np.reshape(np.arange(18),{2,3,3})
  local ix1=np.array({false,false},np.bool)
  local v=841
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2},{3,4,5},{6,7,8}},{{9,10,11},{12,13,14},{15,16,17}}}),'advanced assignment 141')
end
do
  local a=np.reshape(np.arange(80),{4,4,5})
  local ix1=np.array({{false,false,true,true},{true,false,false,true},{false,true,false,false},{true,true,true,true}},np.bool)
  local v=np.array({{2420,2421,2422,2423,2424},{2425,2426,2427,2428,2429},{2430,2431,2432,2433,2434},{2435,2436,2437,2438,2439},{2440,2441,2442,2443,2444},{2445,2446,2447,2448,2449},{2450,2451,2452,2453,2454},{2455,2456,2457,2458,2459},{2460,2461,2462,2463,2464}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2,3,4},{5,6,7,8,9},{2420,2421,2422,2423,2424},{2425,2426,2427,2428,2429}},{{2430,2431,2432,2433,2434},{25,26,27,28,29},{30,31,32,33,34},{2435,2436,2437,2438,2439}},{{40,41,42,43,44},{2440,2441,2442,2443,2444},{50,51,52,53,54},{55,56,57,58,59}},{{2445,2446,2447,2448,2449},{2450,2451,2452,2453,2454},{2455,2456,2457,2458,2459},{2460,2461,2462,2463,2464}}}),'advanced assignment 142')
end
do
  local a=np.reshape(np.arange(12),{2,3,2})
  local ix1=np.array({-1,2},np.int64)
  local v=np.array({{3430,3431}},np.int64)
  a:set(v,np.slice(nil,nil,1),2,ix1)
  assert(eq(a:tolist(),{{{0,1},{2,3431},{4,5}},{{6,7},{8,3431},{10,11}}}),'advanced assignment 143')
end
do
  local a=np.reshape(np.arange(40),{4,2,5})
  local ix1=np.array({3},np.int64)
  local v=844
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2,3,4},{5,6,7,8,9}},{{10,11,12,13,14},{15,16,17,18,19}},{{844,844,844,844,844},{844,844,844,844,844}},{{30,31,32,33,34},{35,36,37,38,39}}}),'advanced assignment 144')
end
do
  local a=np.reshape(np.arange(30),{2,3,5})
  local ix1=np.array({-2,2},np.int64)
  local ix2=np.array({1,2},np.int64)
  local v=np.array({{2450,2451,2452},{2453,2454,2455}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1),ix2)
  assert(eq(a:tolist(),{{{2450,1,2,3,4},{2451,6,7,8,9},{2452,11,12,13,14}},{{15,2453,17,18,19},{20,2454,22,23,24},{25,2455,27,28,29}}}),'advanced assignment 145')
end
do
  local a=np.reshape(np.arange(16),{4,2,2})
  local ix1=np.array({{4}},np.int64)
  local ix2=np.array({{2,2}},np.int64)
  local v=np.array({{{3460,3461},{3462,3463}}},np.int64)
  a:set(v,ix1,ix2,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1},{2,3}},{{4,5},{6,7}},{{8,9},{10,11}},{{12,13},{3462,3463}}}),'advanced assignment 146')
end
do
  local a=np.reshape(np.arange(12),{3,2,2})
  local ix1=np.array({true,false,true},np.bool)
  local v=847
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{847,847},{847,847}},{{4,5},{6,7}},{{847,847},{847,847}}}),'advanced assignment 147')
end
do
  local a=np.reshape(np.arange(30),{5,3,2})
  local ix1=np.array({{false,false,false},{false,true,false},{false,false,false},{false,true,false},{true,false,true}},np.bool)
  local v=np.array({{2480,2481},{2482,2483},{2484,2485},{2486,2487}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1},{2,3},{4,5}},{{6,7},{2480,2481},{10,11}},{{12,13},{14,15},{16,17}},{{18,19},{2482,2483},{22,23}},{{2484,2485},{26,27},{2486,2487}}}),'advanced assignment 148')
end
do
  local a=np.reshape(np.arange(50),{2,5,5})
  local ix1=np.array({2,4},np.int64)
  local v=np.array({{3490,3491}},np.int64)
  a:set(v,np.slice(nil,nil,1),4,ix1)
  assert(eq(a:tolist(),{{{0,1,2,3,4},{5,6,7,8,9},{10,11,12,13,14},{15,3490,17,3491,19},{20,21,22,23,24}},{{25,26,27,28,29},{30,31,32,33,34},{35,36,37,38,39},{40,3490,42,3491,44},{45,46,47,48,49}}}),'advanced assignment 149')
end
do
  local a=np.reshape(np.arange(36),{4,3,3})
  local ix1=np.array({-2,4},np.int64)
  local v=850
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2},{3,4,5},{6,7,8}},{{9,10,11},{12,13,14},{15,16,17}},{{850,850,850},{850,850,850},{850,850,850}},{{850,850,850},{850,850,850},{850,850,850}}}),'advanced assignment 150')
end
do
  local a=np.reshape(np.arange(20),{2,5,2})
  local ix1=np.array({1,-1,-1},np.int64)
  local ix2=np.array({2,-2,1},np.int64)
  local v=np.array({{2510,2511,2512,2513,2514},{2515,2516,2517,2518,2519},{2520,2521,2522,2523,2524}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1),ix2)
  assert(eq(a:tolist(),{{{0,2510},{2,2511},{4,2512},{6,2513},{8,2514}},{{2520,11},{2521,13},{2522,15},{2523,17},{2524,19}}}),'advanced assignment 151')
end
do
  local a=np.reshape(np.arange(50),{5,2,5})
  local ix1=np.array({{1},{5},{-2}},np.int64)
  local ix2=np.array({{2}},np.int64)
  local v=np.array({{{3520,3521,3522,3523,3524}}},np.int64)
  a:set(v,ix1,ix2,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2,3,4},{3520,3521,3522,3523,3524}},{{10,11,12,13,14},{15,16,17,18,19}},{{20,21,22,23,24},{25,26,27,28,29}},{{30,31,32,33,34},{3520,3521,3522,3523,3524}},{{40,41,42,43,44},{3520,3521,3522,3523,3524}}}),'advanced assignment 152')
end
do
  local a=np.reshape(np.arange(40),{5,4,2})
  local ix1=np.array({true,true,true,true,true},np.bool)
  local v=853
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{853,853},{853,853},{853,853},{853,853}},{{853,853},{853,853},{853,853},{853,853}},{{853,853},{853,853},{853,853},{853,853}},{{853,853},{853,853},{853,853},{853,853}},{{853,853},{853,853},{853,853},{853,853}}}),'advanced assignment 153')
end
do
  local a=np.reshape(np.arange(48),{4,3,4})
  local ix1=np.array({{true,true,true},{false,false,true},{false,false,false},{false,true,false}},np.bool)
  local v=np.array({{2540,2541,2542,2543},{2544,2545,2546,2547},{2548,2549,2550,2551},{2552,2553,2554,2555},{2556,2557,2558,2559}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{2540,2541,2542,2543},{2544,2545,2546,2547},{2548,2549,2550,2551}},{{12,13,14,15},{16,17,18,19},{2552,2553,2554,2555}},{{24,25,26,27},{28,29,30,31},{32,33,34,35}},{{36,37,38,39},{2556,2557,2558,2559},{44,45,46,47}}}),'advanced assignment 154')
end
do
  local a=np.reshape(np.arange(45),{3,5,3})
  local ix1=np.array({-3,3},np.int64)
  local v=np.array({{3550,3551}},np.int64)
  a:set(v,np.slice(nil,nil,1),2,ix1)
  assert(eq(a:tolist(),{{{0,1,2},{3550,4,3551},{6,7,8},{9,10,11},{12,13,14}},{{15,16,17},{3550,19,3551},{21,22,23},{24,25,26},{27,28,29}},{{30,31,32},{3550,34,3551},{36,37,38},{39,40,41},{42,43,44}}}),'advanced assignment 155')
end
do
  local a=np.reshape(np.arange(125),{5,5,5})
  local ix1=np.array({2,-4,4},np.int64)
  local v=856
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2,3,4},{5,6,7,8,9},{10,11,12,13,14},{15,16,17,18,19},{20,21,22,23,24}},{{856,856,856,856,856},{856,856,856,856,856},{856,856,856,856,856},{856,856,856,856,856},{856,856,856,856,856}},{{50,51,52,53,54},{55,56,57,58,59},{60,61,62,63,64},{65,66,67,68,69},{70,71,72,73,74}},{{856,856,856,856,856},{856,856,856,856,856},{856,856,856,856,856},{856,856,856,856,856},{856,856,856,856,856}},{{100,101,102,103,104},{105,106,107,108,109},{110,111,112,113,114},{115,116,117,118,119},{120,121,122,123,124}}}),'advanced assignment 156')
end
do
  local a=np.reshape(np.arange(24),{2,4,3})
  local ix1=np.array({1,2,1},np.int64)
  local ix2=np.array({2,3,3},np.int64)
  local v=np.array({{2570,2571,2572,2573},{2574,2575,2576,2577},{2578,2579,2580,2581}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1),ix2)
  assert(eq(a:tolist(),{{{0,2570,2578},{3,2571,2579},{6,2572,2580},{9,2573,2581}},{{12,13,2574},{15,16,2575},{18,19,2576},{21,22,2577}}}),'advanced assignment 157')
end
do
  local a=np.reshape(np.arange(40),{2,4,5})
  local ix1=np.array({{2},{2},{2}},np.int64)
  local ix2=np.array({{4}},np.int64)
  local v=np.array({{{3580,3581,3582,3583,3584}}},np.int64)
  a:set(v,ix1,ix2,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2,3,4},{5,6,7,8,9},{10,11,12,13,14},{15,16,17,18,19}},{{20,21,22,23,24},{25,26,27,28,29},{30,31,32,33,34},{3580,3581,3582,3583,3584}}}),'advanced assignment 158')
end
do
  local a=np.reshape(np.arange(40),{4,5,2})
  local ix1=np.array({false,true,false,false},np.bool)
  local v=859
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1},{2,3},{4,5},{6,7},{8,9}},{{859,859},{859,859},{859,859},{859,859},{859,859}},{{20,21},{22,23},{24,25},{26,27},{28,29}},{{30,31},{32,33},{34,35},{36,37},{38,39}}}),'advanced assignment 159')
end
do
  local a=np.reshape(np.arange(16),{4,2,2})
  local ix1=np.array({{true,false},{false,false},{false,false},{false,false}},np.bool)
  local v=np.array({{2600,2601}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{2600,2601},{2,3}},{{4,5},{6,7}},{{8,9},{10,11}},{{12,13},{14,15}}}),'advanced assignment 160')
end
do
  local a=np.reshape(np.arange(18),{3,3,2})
  local ix1=np.array({1,-1,1},np.int64)
  local v=np.array({{3610,3611,3612}},np.int64)
  a:set(v,np.slice(nil,nil,1),1,ix1)
  assert(eq(a:tolist(),{{{3612,3611},{2,3},{4,5}},{{3612,3611},{8,9},{10,11}},{{3612,3611},{14,15},{16,17}}}),'advanced assignment 161')
end
do
  local a=np.reshape(np.arange(24),{2,3,4})
  local ix1=np.array({-1},np.int64)
  local v=862
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2,3},{4,5,6,7},{8,9,10,11}},{{862,862,862,862},{862,862,862,862},{862,862,862,862}}}),'advanced assignment 162')
end
do
  local a=np.reshape(np.arange(48),{3,4,4})
  local ix1=np.array({3,2,3},np.int64)
  local ix2=np.array({3,-3,2},np.int64)
  local v=np.array({{2630,2631,2632,2633},{2634,2635,2636,2637},{2638,2639,2640,2641}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1),ix2)
  assert(eq(a:tolist(),{{{0,1,2,3},{4,5,6,7},{8,9,10,11},{12,13,14,15}},{{16,2634,18,19},{20,2635,22,23},{24,2636,26,27},{28,2637,30,31}},{{32,2638,2630,35},{36,2639,2631,39},{40,2640,2632,43},{44,2641,2633,47}}}),'advanced assignment 163')
end
do
  local a=np.reshape(np.arange(50),{5,2,5})
  local ix1=np.array({{1},{5},{3}},np.int64)
  local ix2=np.array({{2,2,1}},np.int64)
  local v=np.array({{{3640,3641,3642,3643,3644},{3645,3646,3647,3648,3649},{3650,3651,3652,3653,3654}}},np.int64)
  a:set(v,ix1,ix2,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{3650,3651,3652,3653,3654},{3645,3646,3647,3648,3649}},{{10,11,12,13,14},{15,16,17,18,19}},{{3650,3651,3652,3653,3654},{3645,3646,3647,3648,3649}},{{30,31,32,33,34},{35,36,37,38,39}},{{3650,3651,3652,3653,3654},{3645,3646,3647,3648,3649}}}),'advanced assignment 164')
end
do
  local a=np.reshape(np.arange(30),{2,3,5})
  local ix1=np.array({false,false},np.bool)
  local v=865
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2,3,4},{5,6,7,8,9},{10,11,12,13,14}},{{15,16,17,18,19},{20,21,22,23,24},{25,26,27,28,29}}}),'advanced assignment 165')
end
do
  local a=np.reshape(np.arange(30),{3,5,2})
  local ix1=np.array({{false,false,false,true,true},{false,true,false,false,true},{true,false,true,true,true}},np.bool)
  local v=np.array({{2660,2661},{2662,2663},{2664,2665},{2666,2667},{2668,2669},{2670,2671},{2672,2673},{2674,2675}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1},{2,3},{4,5},{2660,2661},{2662,2663}},{{10,11},{2664,2665},{14,15},{16,17},{2666,2667}},{{2668,2669},{22,23},{2670,2671},{2672,2673},{2674,2675}}}),'advanced assignment 166')
end
do
  local a=np.reshape(np.arange(60),{4,5,3})
  local ix1=np.array({3,2,3},np.int64)
  local v=np.array({{3670,3671,3672}},np.int64)
  a:set(v,np.slice(nil,nil,1),1,ix1)
  assert(eq(a:tolist(),{{{0,3671,3672},{3,4,5},{6,7,8},{9,10,11},{12,13,14}},{{15,3671,3672},{18,19,20},{21,22,23},{24,25,26},{27,28,29}},{{30,3671,3672},{33,34,35},{36,37,38},{39,40,41},{42,43,44}},{{45,3671,3672},{48,49,50},{51,52,53},{54,55,56},{57,58,59}}}),'advanced assignment 167')
end
do
  local a=np.reshape(np.arange(16),{4,2,2})
  local ix1=np.array({-1,2},np.int64)
  local v=868
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1},{2,3}},{{868,868},{868,868}},{{8,9},{10,11}},{{868,868},{868,868}}}),'advanced assignment 168')
end
do
  local a=np.reshape(np.arange(18),{2,3,3})
  local ix1=np.array({2,1},np.int64)
  local ix2=np.array({2,-2},np.int64)
  local v=np.array({{2690,2691,2692},{2693,2694,2695}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1),ix2)
  assert(eq(a:tolist(),{{{0,2693,2},{3,2694,5},{6,2695,8}},{{9,2690,11},{12,2691,14},{15,2692,17}}}),'advanced assignment 169')
end
do
  local a=np.reshape(np.arange(75),{3,5,5})
  local ix1=np.array({{-3}},np.int64)
  local ix2=np.array({{1}},np.int64)
  local v=np.array({{{3700,3701,3702,3703,3704}}},np.int64)
  a:set(v,ix1,ix2,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{3700,3701,3702,3703,3704},{5,6,7,8,9},{10,11,12,13,14},{15,16,17,18,19},{20,21,22,23,24}},{{25,26,27,28,29},{30,31,32,33,34},{35,36,37,38,39},{40,41,42,43,44},{45,46,47,48,49}},{{50,51,52,53,54},{55,56,57,58,59},{60,61,62,63,64},{65,66,67,68,69},{70,71,72,73,74}}}),'advanced assignment 170')
end
do
  local a=np.reshape(np.arange(24),{4,3,2})
  local ix1=np.array({true,false,true,true},np.bool)
  local v=871
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{871,871},{871,871},{871,871}},{{6,7},{8,9},{10,11}},{{871,871},{871,871},{871,871}},{{871,871},{871,871},{871,871}}}),'advanced assignment 171')
end
do
  local a=np.reshape(np.arange(30),{3,5,2})
  local ix1=np.array({{false,false,true,false,false},{false,false,true,true,false},{true,false,true,false,true}},np.bool)
  local v=np.array({{2720,2721},{2722,2723},{2724,2725},{2726,2727},{2728,2729},{2730,2731}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1},{2,3},{2720,2721},{6,7},{8,9}},{{10,11},{12,13},{2722,2723},{2724,2725},{18,19}},{{2726,2727},{22,23},{2728,2729},{26,27},{2730,2731}}}),'advanced assignment 172')
end
do
  local a=np.reshape(np.arange(60),{4,5,3})
  local ix1=np.array({3,-3,2},np.int64)
  local v=np.array({{3730,3731,3732}},np.int64)
  a:set(v,np.slice(nil,nil,1),5,ix1)
  assert(eq(a:tolist(),{{{0,1,2},{3,4,5},{6,7,8},{9,10,11},{3731,3732,3730}},{{15,16,17},{18,19,20},{21,22,23},{24,25,26},{3731,3732,3730}},{{30,31,32},{33,34,35},{36,37,38},{39,40,41},{3731,3732,3730}},{{45,46,47},{48,49,50},{51,52,53},{54,55,56},{3731,3732,3730}}}),'advanced assignment 173')
end
do
  local a=np.reshape(np.arange(36),{3,3,4})
  local ix1=np.array({-3,3},np.int64)
  local v=874
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{874,874,874,874},{874,874,874,874},{874,874,874,874}},{{12,13,14,15},{16,17,18,19},{20,21,22,23}},{{874,874,874,874},{874,874,874,874},{874,874,874,874}}}),'advanced assignment 174')
end
do
  local a=np.reshape(np.arange(30),{3,5,2})
  local ix1=np.array({1,-3,1},np.int64)
  local ix2=np.array({1,1,1},np.int64)
  local v=np.array({{2750,2751,2752,2753,2754},{2755,2756,2757,2758,2759},{2760,2761,2762,2763,2764}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1),ix2)
  assert(eq(a:tolist(),{{{2760,1},{2761,3},{2762,5},{2763,7},{2764,9}},{{10,11},{12,13},{14,15},{16,17},{18,19}},{{20,21},{22,23},{24,25},{26,27},{28,29}}}),'advanced assignment 175')
end
do
  local a=np.reshape(np.arange(24),{3,4,2})
  local ix1=np.array({{2},{1}},np.int64)
  local ix2=np.array({{1,2,-2}},np.int64)
  local v=np.array({{{3760,3761},{3762,3763},{3764,3765}}},np.int64)
  a:set(v,ix1,ix2,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{3760,3761},{3762,3763},{3764,3765},{6,7}},{{3760,3761},{3762,3763},{3764,3765},{14,15}},{{16,17},{18,19},{20,21},{22,23}}}),'advanced assignment 176')
end
do
  local a=np.reshape(np.arange(48),{4,4,3})
  local ix1=np.array({true,true,true,false},np.bool)
  local v=877
  a:set(v,ix1,np.slice(nil,nil,1),np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{877,877,877},{877,877,877},{877,877,877},{877,877,877}},{{877,877,877},{877,877,877},{877,877,877},{877,877,877}},{{877,877,877},{877,877,877},{877,877,877},{877,877,877}},{{36,37,38},{39,40,41},{42,43,44},{45,46,47}}}),'advanced assignment 177')
end
do
  local a=np.reshape(np.arange(60),{3,5,4})
  local ix1=np.array({{false,false,false,true,false},{true,true,true,false,true},{false,true,false,true,true}},np.bool)
  local v=np.array({{2780,2781,2782,2783},{2784,2785,2786,2787},{2788,2789,2790,2791},{2792,2793,2794,2795},{2796,2797,2798,2799},{2800,2801,2802,2803},{2804,2805,2806,2807},{2808,2809,2810,2811}},np.int64)
  a:set(v,ix1,np.slice(nil,nil,1))
  assert(eq(a:tolist(),{{{0,1,2,3},{4,5,6,7},{8,9,10,11},{2780,2781,2782,2783},{16,17,18,19}},{{2784,2785,2786,2787},{2788,2789,2790,2791},{2792,2793,2794,2795},{32,33,34,35},{2796,2797,2798,2799}},{{40,41,42,43},{2800,2801,2802,2803},{48,49,50,51},{2804,2805,2806,2807},{2808,2809,2810,2811}}}),'advanced assignment 178')
end
do
  local a=np.reshape(np.arange(16),{2,4,2})
  local ix1=np.array({2},np.int64)
  local v=np.array({{3790}},np.int64)
  a:set(v,np.slice(nil,nil,1),2,ix1)
  assert(eq(a:tolist(),{{{0,1},{2,3790},{4,5},{6,7}},{{8,9},{10,3790},{12,13},{14,15}}}),'advanced assignment 179')
end
do local a=np.zeros({4},np.int64); local i=np.array({2,2,2},np.int64); a:set(np.array({10,20,30},np.int64),i); assert(eq(a:tolist(),{0,30,0,0}),'repeated fancy assignment order') end
do local a=np.arange(6); local m=np.array({true,false,true,false,true,false},np.bool); a:set(np.array({50,60,70},np.int64),m); assert(eq(a:tolist(),{50,1,60,3,70,5}),'boolean vector assignment') end
do local a=np.zeros({3,4},np.int64); local v=np.array({{1,2,3,4}},np.int64); a:set(v,np.slice(nil,nil,1),np.slice(nil,nil,1)); assert(eq(a:tolist(),{{1,2,3,4},{1,2,3,4},{1,2,3,4}}),'basic array assignment broadcast') end
print('advanced assignment differential: 180 cases ok')
