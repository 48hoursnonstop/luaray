local np=require('luaray_core')
local function same(a,b)
 if type(a)=='table' then
  assert(type(b)=='table' and #a==#b,'table length mismatch')
  for i=1,#a do same(a[i],b[i]) end
 elseif type(a)=='number' and type(b)=='number' and a~=a and b~=b then return
 else assert(a==b, tostring(a)..' ~= '..tostring(b)) end
end
do local a=np.transpose(np.zeros({0,3},"uint64")); same(np.all(a),true) end
do local a=np.flip(np.array({{{np.complex((0/0),0.0),np.complex(-1.0,0.0),np.complex(-1.0,0.0)},{np.complex(0.0,0.0),np.complex(0.0,3.0),np.complex(-1.0,3.0)}}},"complex128"),3); local v=np.any(a,{axis=3,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{true},{true}}}) end
do local a=np.zeros({0},"uint8"); same(np.count_nonzero(a,{axis={1}}),0) end
do local a=np.array("a","S3"); same(np.any(a,{axis={},where=false}),false) end
do local a=np.array({5,0},"int64"); same(np.count_nonzero(a),1) end
do local a=np.flip(np.zeros({0,3},"int32"),2); local v=np.count_nonzero(a,{axis=1});assert(v.dtype=="int64")
same(v:tolist(),{0,0,0}) end
do local a=np.zeros({2,0},"float32"); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{},{}}) end
do local a=np.array(5,"int8"); same(np.all(a,{axis={}}),true) end
do local a=np.array({{math.huge},{(0/0)}},"float16"); local v=np.any(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{true,true}) end
do local a=np.flip(np.zeros({2,0,3},"complex64"),3); same(np.count_nonzero(a),0) end
do local a=np.array({{0.0,0.0,-2.0},{-0.0,-0.0,0.0}},"float32"); same(np.all(a,{where=np.array({{false,true,false},{true,false,false}},"bool")}),false) end
do local a=np.array({0.0,math.huge},"float32"); same(np.count_nonzero(a),1) end
do local a=np.array({{0,-1},{1,0},{1,-1}},"int8"); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0,1},{1,0},{1,1}}) end
do local a=np.zeros({2,0,3},"S3"); local v=np.any(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.flip(np.array({{0,5},{0,0},{1,0}},"uint8"),2); local v=np.all(a,{keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.flip(np.zeros({0,3},"int64"),2); same(np.count_nonzero(a),0) end
do local a=np.transpose(np.array({{{(0/0),0.0},{0.0,0.0},{0.0,math.huge}},{{-0.0,-0.0},{0.0,-0.0},{0.0,(0/0)}}},"float16")); same(np.count_nonzero(a),3) end
do local a=np.array({{{"a","XX",""},{"a","a","a"}}},"S3"); same(np.any(a,{axis={1,2,3}}),true) end
do local a=np.zeros({0,3},"U3"); same(np.any(a,{where=true}),false) end
do local a=np.array({{"XX","XX"},{"a",""},{"xyz","xyz"}},"S3"); local v=np.all(a,{keepdims=true,where=np.array({{true,false},{true,false},{true,true}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.transpose(np.array({{{9007199254740995,0},{0,9007199254740995},{9007199254740995,0}},{{1,5},{5,-1},{0,-1}}},"int64")); same(np.all(a,{axis={1,2,3}}),false) end
do local a=np.flip(np.array({{np.complex(-1.0,0.0)},{np.complex(0.0,3.0)}},"complex128"),2); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{1},{1}}) end
do local a=np.transpose(np.array({{0.0,math.huge},{-0.0,0.0},{-0.0,0.0}},"float32")); same(np.count_nonzero(a),1) end
do local a=np.array({{"XX","xyz",""},{"a","",""}},"U3"); local v=np.count_nonzero(a,{axis=2});assert(v.dtype=="int64")
same(v:tolist(),{2,1}) end
do local a=np.transpose(np.zeros({0,3},"complex64")); same(np.any(a,{where=np.array({{}},"bool")}),false) end
do local a=np.array(4.0,"float16"); same(np.any(a),true) end
do local a=np.array({{{0,1},{1,1},{0,1}},{{1,5},{9007199254740995,0},{1,5}}},"uint64"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{false}}}) end
do local a=np.flip(np.zeros({0,3},"uint8"),2); same(np.any(a,{where=np.array({{true,false,false}},"bool")}),false) end
do local a=np.array({{4.0,-0.0},{4.0,0.0},{-0.0,-0.0}},"float64"); same(np.any(a,{axis={1,2}}),true) end
do local a=np.zeros({0},"int64"); local v=np.all(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.flip(np.array({{np.complex(0.0,0.0)},{np.complex(-1.0,0.0)}},"complex128"),2); same(np.all(a),false) end
do local a=np.array({{-0.0,-0.0,-0.0},{4.0,0.0,4.0}},"float32"); same(np.any(a,{where=true}),true) end
do local a=np.array({{np.complex((0/0),0.0),np.complex(0.0,3.0)},{np.complex(0.0,0.0),np.complex((0/0),0.0)},{np.complex((0/0),0.0),np.complex(0.0,0.0)}},"complex64"); same(np.any(a,{where=np.array({{false,true}},"bool")}),true) end
do local a=np.flip(np.zeros({0},"U3"),1); same(np.count_nonzero(a),0) end
do local a=np.zeros({2,0,3},"int8"); same(np.count_nonzero(a),0) end
do local a=np.array({{5,0,0},{1,-1,-1}},"int8"); same(np.count_nonzero(a),4) end
do local a=np.array({np.complex(2.0,3.0),np.complex((0/0),0.0)},"complex64"); same(np.count_nonzero(a),2) end
do local a=np.zeros({0},"S3"); same(np.count_nonzero(a),0) end
do local a=np.zeros({0},"int64"); same(np.any(a),false) end
do local a=np.array({{"xyz","","a"},{"XX","a",""}},"U3"); same(np.all(a,{where=np.array({{true,true,false},{true,true,false}},"bool")}),false) end
do local a=np.flip(np.array({{{false,false},{true,true},{false,false}},{{false,false},{true,true},{false,false}}},"bool"),3); same(np.all(a),false) end
do local a=np.zeros({2,0,3},"uint64"); local v=np.any(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.array("","S3"); same(np.all(a,{axis={},where=np.array(false,"bool")}),true) end
do local a=np.flip(np.array({(0/0),-2.0,(0/0),-2.0},"float64"),1); same(np.count_nonzero(a,{axis=1}),4) end
do local a=np.transpose(np.zeros({2,0,3},"bool")); same(np.all(a),true) end
do local a=np.array({5,0},"int16"); same(np.any(a,{axis={1}}),true) end
do local a=np.flip(np.zeros({0,3},"int8"),2); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0}}) end
do local a=np.transpose(np.array({{{math.huge,math.huge,0.0},{-0.0,0.0,4.0}}},"float64")); local v=np.count_nonzero(a,{axis={1,2,3},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{3}}}) end
do local a=np.transpose(np.array({{"XX","","XX"},{"","xyz",""}},"S3")); same(np.any(a),true) end
do local a=np.transpose(np.zeros({2,0,3},"complex128")); local v=np.all(a,{keepdims=true,where=np.zeros({3,0,2},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{{true}}}) end
do local a=np.zeros({0},"int8"); local v=np.all(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.array({1},"int64"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.zeros({0},"float32"); same(np.count_nonzero(a),0) end
do local a=np.array(0,"uint8"); same(np.all(a,{axis={},where=np.array(false,"bool")}),true) end
do local a=np.array({{{np.complex(2.0,0.0),np.complex(2.0,0.0),np.complex((0/0),3.0)},{np.complex(2.0,3.0),np.complex(2.0,0.0),np.complex(-1.0,0.0)}}},"complex128"); local v=np.count_nonzero(a,{axis=1});assert(v.dtype=="int64")
same(v:tolist(),{{1,1,1},{1,1,1}}) end
do local a=np.array({true,true,false,true},"bool"); same(np.all(a,{axis={1}}),false) end
do local a=np.array({{1,0,5},{0,-1,0}},"int32"); same(np.any(a),true) end
do local a=np.transpose(np.array({{true,false},{false,false},{false,true}},"bool")); same(np.count_nonzero(a),2) end
do local a=np.flip(np.array({{-2.0},{(0/0)}},"float32"),2); local v=np.any(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true},{true}}) end
do local a=np.flip(np.zeros({2,0,3},"float64"),3); local v=np.all(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{{true,true,true},{true,true,true}}) end
do local a=np.flip(np.array({{0,0,5},{1,9007199254740995,5}},"uint64"),2); same(np.all(a),false) end
do local a=np.transpose(np.zeros({0,3},"complex128")); same(np.any(a,{where=np.array({{}},"bool")}),false) end
do local a=np.transpose(np.array({{{np.complex(-1.0,0.0),np.complex((0/0),0.0)},{np.complex((0/0),0.0),np.complex(-1.0,0.0)},{np.complex(0.0,0.0),np.complex(-1.0,0.0)}},{{np.complex(2.0,0.0),np.complex(0.0,3.0)},{np.complex((0/0),3.0),np.complex(0.0,0.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0)}}},"complex64")); same(np.all(a,{where=np.array({{{true,true}}},"bool")}),false) end
do local a=np.flip(np.array({{0,0},{0,0},{5,1}},"int16"),2); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{false,false},{false,false},{true,true}}) end
do local a=np.array({"","a"},"U3"); same(np.count_nonzero(a),1) end
do local a=np.array({5,-1,0,1},"int64"); same(np.count_nonzero(a,{axis=1}),3) end
do local a=np.transpose(np.array({{1},{5}},"uint64")); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{2}}) end
do local a=np.flip(np.array({{true},{false}},"bool"),2); same(np.any(a),true) end
do local a=np.array({-0.0},"float16"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{0}) end
do local a=np.transpose(np.zeros({0,3},"U3")); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0}}) end
do local a=np.array({{0.0,0.0},{(0/0),-0.0},{-2.0,math.huge}},"float64"); same(np.any(a,{where=np.array({{true,true}},"bool")}),true) end
do local a=np.array({false,false,true,false},"bool"); same(np.any(a,{axis=1,where=np.array({true,true,true,true},"bool")}),true) end
do local a=np.transpose(np.zeros({2,0},"U3")); same(np.any(a,{axis={1,2}}),false) end
do local a=np.array({{5,0},{5,0},{0,9007199254740995}},"int64"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.array({{{-1,0,-1},{0,-1,-1}}},"int32"); same(np.all(a,{where=np.array({{{false,false,false},{true,false,true}}},"bool")}),false) end
do local a=np.array({"xyz","xyz","XX","a"},"S3"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array({{{np.complex(0.0,0.0),np.complex(-1.0,0.0),np.complex(-1.0,0.0)},{np.complex((0/0),0.0),np.complex(2.0,0.0),np.complex(-1.0,3.0)}}},"complex64"); same(np.any(a,{where=np.array({{{true,true,true}}},"bool")}),true) end
do local a=np.transpose(np.array({{0,0,0},{1,-1,5}},"int32")); same(np.count_nonzero(a,{axis={1,2}}),3) end
do local a=np.flip(np.array({{math.huge,0.0},{4.0,math.huge},{-0.0,(0/0)}},"float32"),2); local v=np.all(a,{keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.array({{"","xyz"},{"XX","XX"},{"a","XX"}},"S3"); same(np.any(a),true) end
do local a=np.array({{{np.complex(2.0,0.0),np.complex(2.0,3.0),np.complex(0.0,0.0)},{np.complex(2.0,0.0),np.complex(0.0,0.0),np.complex(0.0,3.0)}}},"complex64"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{{true,true,false},{true,false,true}}}) end
do local a=np.array({{5,1,0},{0,1,5}},"uint8"); same(np.all(a,{where=false}),true) end
do local a=np.zeros({2,0},"float64"); same(np.any(a,{where=false}),false) end
do local a=np.zeros({0,3},"float64"); same(np.any(a),false) end
do local a=np.array({{{1,5},{0,0},{5,5}},{{0,0},{0,0},{1,-1}}},"int16"); local v=np.all(a,{keepdims=true,where=np.array({{{true,true}}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{{false}}}) end
do local a=np.array({{5},{9007199254740995}},"int64"); local v=np.all(a,{keepdims=true,where=np.array({{true},{false}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.transpose(np.array({{1,1},{1,0},{0,0}},"int16")); local v=np.all(a,{axis=2,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false},{false}}) end
do local a=np.flip(np.zeros({2,0},"S3"),2); local v=np.any(a,{keepdims=true,where=np.zeros({2,0},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.transpose(np.array({{false,true,false},{false,true,false}},"bool")); same(np.all(a,{axis={1,2},where=false}),true) end
do local a=np.flip(np.zeros({2,0},"complex128"),2); same(np.any(a),false) end
do local a=np.array({0,0},"int32"); same(np.any(a,{axis={1}}),false) end
do local a=np.flip(np.zeros({0},"U3"),1); same(np.any(a),false) end
do local a=np.zeros({0},"float16"); same(np.all(a),true) end
do local a=np.array((0/0),"float64"); same(np.all(a,{keepdims=true,where=np.array(true,"bool")}),true) end
do local a=np.array({"XX","XX"},"S3"); local v=np.all(a,{axis={},keepdims=true,where=np.array({false,false},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{true,true}) end
do local a=np.array({{np.complex(2.0,0.0),np.complex(-1.0,3.0)},{np.complex(-1.0,0.0),np.complex((0/0),0.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0)}},"complex128"); same(np.count_nonzero(a),4) end
do local a=np.array({"XX","a"},"U3"); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{1,1}) end
do local a=np.zeros({2,0,3},"float16"); same(np.any(a,{where=false}),false) end
do local a=np.array({{np.complex((0/0),0.0),np.complex(0.0,3.0),np.complex(0.0,0.0)},{np.complex(-1.0,3.0),np.complex((0/0),0.0),np.complex((0/0),0.0)}},"complex128"); same(np.count_nonzero(a,{axis={1,2}}),5) end
do local a=np.array({np.complex(2.0,0.0),np.complex(0.0,0.0)},"complex128"); local v=np.count_nonzero(a,{axis=1,keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{1}) end
do local a=np.flip(np.array({{-1,1,0},{0,0,5}},"int32"),2); local v=np.any(a,{axis={},keepdims=true,where=np.array({{true,false,false},{true,true,true}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{false,false,false},{true,false,false}}) end
do local a=np.transpose(np.zeros({0,3},"int32")); same(np.any(a),false) end
do local a=np.zeros({0},"complex64"); same(np.all(a),true) end
do local a=np.array("a","S3"); same(np.count_nonzero(a),1) end
do local a=np.flip(np.array({{1,1},{0,0},{0,0}},"uint8"),2); same(np.count_nonzero(a),2) end
do local a=np.array({9007199254740995,1,0,0},"uint64"); same(np.count_nonzero(a,{axis={1}}),2) end
do local a=np.array({np.complex((0/0),0.0),np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(2.0,0.0)},"complex64"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.array(np.complex((0/0),0.0),"complex64"); same(np.any(a,{where=np.array(true,"bool")}),true) end
do local a=np.transpose(np.array({{{0,0},{-1,0},{1,1}},{{1,0},{5,-1},{1,-1}}},"int8")); same(np.any(a,{axis={1,2,3},where=true}),true) end
do local a=np.transpose(np.array({{4.0,-2.0,-0.0},{-2.0,(0/0),-2.0}},"float16")); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{1,1},{1,1},{0,1}}) end
do local a=np.array({{{1,0},{0,5},{0,0}},{{0,5},{-1,0},{0,0}}},"int16"); same(np.count_nonzero(a),4) end
do local a=np.zeros({0,3},"int64"); same(np.count_nonzero(a),0) end
do local a=np.flip(np.array({{0},{0}},"int32"),2); same(np.count_nonzero(a),0) end
do local a=np.zeros({0,3},"complex64"); local v=np.all(a,{axis={1,2},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.array({0,0,0,-1},"int16"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{0,0,0,1}) end
do local a=np.array(-2.0,"float32"); same(np.all(a,{axis={}}),true) end
do local a=np.array({{0.0,0.0},{(0/0),0.0},{math.huge,4.0}},"float16"); same(np.count_nonzero(a),3) end
do local a=np.zeros({2,0},"bool"); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{},{}}) end
do local a=np.array(0,"int8"); same(np.any(a,{where=false}),false) end
do local a=np.array({{{"XX","","xyz"},{"xyz","a","XX"}}},"S3"); same(np.all(a),false) end
do local a=np.transpose(np.array({{5},{5}},"int64")); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{1,1}}) end
do local a=np.flip(np.array({np.complex(0.0,3.0),np.complex(2.0,0.0)},"complex64"),1); local v=np.count_nonzero(a,{axis={1},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{2}) end
do local a=np.zeros({0,3},"int8"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.array({{0,0,5},{9007199254740995,1,0}},"uint64"); same(np.all(a),false) end
do local a=np.zeros({2,0,3},"int8"); same(np.count_nonzero(a),0) end
do local a=np.array({{{0,1},{5,0},{5,1}},{{9007199254740995,1},{0,0},{5,0}}},"uint64"); same(np.count_nonzero(a,{axis={1,2,3}}),7) end
do local a=np.transpose(np.array({{""},{"a"}},"U3")); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{0,1}}) end
do local a=np.zeros({2,0,3},"S3"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{0}}}) end
do local a=np.array({{5},{0}},"uint8"); local v=np.count_nonzero(a,{axis=1});assert(v.dtype=="int64")
same(v:tolist(),{1}) end
do local a=np.array({{np.complex(2.0,3.0),np.complex(-1.0,0.0)},{np.complex(-1.0,0.0),np.complex((0/0),0.0)},{np.complex(-1.0,0.0),np.complex(0.0,0.0)}},"complex128"); local v=np.any(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{true,true}) end
do local a=np.array(1,"uint64"); same(np.count_nonzero(a),1) end
do local a=np.array({1,9007199254740995},"uint64"); same(np.count_nonzero(a,{axis=1}),2) end
do local a=np.array({0.0,0.0},"float16"); local v=np.all(a,{axis={1},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.flip(np.array({{{np.complex((0/0),3.0),np.complex(0.0,0.0)},{np.complex(-1.0,3.0),np.complex(-1.0,0.0)},{np.complex(-1.0,0.0),np.complex(0.0,3.0)}},{{np.complex(0.0,0.0),np.complex((0/0),0.0)},{np.complex(2.0,0.0),np.complex(0.0,0.0)},{np.complex(-1.0,3.0),np.complex(0.0,0.0)}}},"complex64"),3); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{{0,1},{1,1},{1,1}},{{1,0},{0,1},{0,1}}}) end
do local a=np.array(np.complex(-1.0,0.0),"complex64"); same(np.count_nonzero(a),1) end
do local a=np.array((0/0),"float16"); same(np.all(a,{where=false}),true) end
do local a=np.transpose(np.zeros({0,3},"float64")); local v=np.all(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.transpose(np.array({{"xyz","xyz","XX"},{"","XX","xyz"}},"U3")); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.array({{{false,false},{true,false},{false,false}},{{true,true},{false,false},{true,true}}},"bool"); same(np.count_nonzero(a),5) end
do local a=np.zeros({0},"bool"); same(np.any(a,{axis=1,where=false}),false) end
do local a=np.array({0,0},"int32"); local v=np.any(a,{axis={1},keepdims=true,where=np.array({true,true},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.array({math.huge,math.huge},"float64"); same(np.count_nonzero(a),2) end
do local a=np.array({np.complex((0/0),0.0),np.complex((0/0),0.0)},"complex128"); same(np.count_nonzero(a),2) end
do local a=np.array({{0},{5}},"int64"); same(np.all(a),false) end
do local a=np.transpose(np.zeros({2,0,3},"S3")); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{},{},{}}) end
do local a=np.zeros({2,0},"int32"); local v=np.count_nonzero(a,{axis={1,2},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0}}) end
do local a=np.array({{{math.huge,0.0,-0.0},{4.0,(0/0),0.0}}},"float16"); local v=np.all(a,{keepdims=true,where=np.array({{{true,false,true}}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{{false}}}) end
do local a=np.flip(np.array({-1,0},"int16"),1); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{0,1}) end
do local a=np.zeros({2,0,3},"S3"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{0}}}) end
do local a=np.zeros({0},"uint8"); local v=np.any(a,{axis={1},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.flip(np.array({{0,1},{0,0},{5,-1}},"int16"),2); local v=np.all(a,{keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.array({{true,true},{true,false},{false,true}},"bool"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.zeros({0,3},"complex128"); same(np.all(a),true) end
do local a=np.flip(np.zeros({0},"int8"),1); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{0}) end
do local a=np.array({{false,true},{false,false},{false,false}},"bool"); local v=np.count_nonzero(a,{axis=2});assert(v.dtype=="int64")
same(v:tolist(),{1,0,0}) end
do local a=np.flip(np.array({{0,0,1},{0,0,0}},"int16"),2); same(np.all(a),false) end
do local a=np.zeros({2,0},"complex128"); local v=np.all(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.array({{4.0,-0.0},{4.0,(0/0)},{0.0,-0.0}},"float64"); same(np.all(a),false) end
do local a=np.array({4.0,-2.0,(0/0),0.0},"float32"); same(np.any(a,{where=np.array({false,true,true,true},"bool")}),true) end
do local a=np.flip(np.array({np.complex(0.0,0.0)},"complex64"),1); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{0}) end
do local a=np.array(0,"int8"); same(np.count_nonzero(a,{axis={}}),0) end
do local a=np.array({9007199254740995},"int64"); same(np.count_nonzero(a),1) end
do local a=np.array(0.0,"float32"); same(np.any(a,{axis={},where=np.array(false,"bool")}),false) end
do local a=np.flip(np.zeros({2,0},"uint8"),2); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.array({{0,1},{5,0},{5,-1}},"int64"); same(np.all(a,{axis={1,2},where=true}),false) end
do local a=np.array({0.0},"float64"); same(np.all(a,{where=np.array({false},"bool")}),true) end
do local a=np.transpose(np.zeros({2,0},"int8")); local v=np.all(a,{axis={1,2},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.flip(np.zeros({0},"complex64"),1); local v=np.count_nonzero(a,{axis={1},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{0}) end
do local a=np.transpose(np.zeros({0,3},"uint64")); same(np.any(a,{axis={1,2}}),false) end
do local a=np.flip(np.array({{np.complex(0.0,0.0),np.complex((0/0),0.0),np.complex(-1.0,0.0)},{np.complex(-1.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}},"complex64"),2); local v=np.any(a,{axis={},where=np.array({{false,true,false},{true,true,true}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{false,true,false},{false,false,true}}) end
do local a=np.flip(np.zeros({2,0,3},"int8"),3); same(np.count_nonzero(a,{axis={1,2,3}}),0) end
do local a=np.array({{{(0/0),(0/0)},{math.huge,-0.0},{0.0,-0.0}},{{4.0,-0.0},{(0/0),(0/0)},{0.0,-2.0}}},"float16"); same(np.count_nonzero(a),7) end
do local a=np.array({np.complex(2.0,0.0),np.complex((0/0),0.0),np.complex(2.0,0.0),np.complex(-1.0,0.0)},"complex64"); same(np.all(a,{axis={1},where=true}),true) end
do local a=np.transpose(np.array({{{1,1},{1,1},{0,1}},{{1,0},{5,0},{0,0}}},"uint8")); same(np.count_nonzero(a),7) end
do local a=np.transpose(np.zeros({0,3},"int8")); same(np.count_nonzero(a,{axis={1,2}}),0) end
do local a=np.flip(np.array({{{"","a","a"},{"xyz","",""}}},"S3"),3); same(np.any(a),true) end
do local a=np.flip(np.array({{4.0,0.0,-0.0},{0.0,(0/0),0.0}},"float32"),2); local v=np.all(a,{axis={},where=np.array({{false,true,false}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{true,false,true},{true,true,true}}) end
do local a=np.flip(np.array({np.complex(0.0,0.0),np.complex(0.0,3.0),np.complex(2.0,0.0),np.complex(0.0,0.0)},"complex64"),1); same(np.all(a,{where=np.array({false,true,true,false},"bool")}),true) end
do local a=np.array(0,"uint64"); same(np.all(a,{axis={}}),false) end
do local a=np.flip(np.zeros({2,0},"uint8"),2); same(np.all(a,{where=np.array({{}},"bool")}),true) end
do local a=np.flip(np.array({5,1},"int64"),1); same(np.count_nonzero(a),2) end
do local a=np.array({{"XX"},{"XX"}},"S3"); same(np.all(a,{where=np.array({{true}},"bool")}),true) end
do local a=np.flip(np.array({{{"xyz","a"},{"XX",""},{"","xyz"}},{{"XX","xyz"},{"",""},{"","xyz"}}},"U3"),3); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{7}}}) end
do local a=np.array({0.0,4.0},"float32"); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{false,true}) end
do local a=np.array({np.complex(0.0,0.0)},"complex64"); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.array({{4.0,-0.0,-0.0},{(0/0),-2.0,4.0}},"float16"); local v=np.all(a,{keepdims=true,where=false});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.array({0},"int8"); local v=np.any(a,{keepdims=true,where=np.array({true},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.array("xyz","S3"); same(np.all(a),true) end
do local a=np.array({{{false,false},{false,true},{true,false}},{{false,false},{false,true},{false,false}}},"bool"); local v=np.all(a,{axis=1,where=np.array({{{true,true},{true,true},{false,false}},{{false,true},{false,true},{true,true}}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{false,false},{false,true},{false,false}}) end
do local a=np.flip(np.zeros({2,0},"uint64"),2); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0}}) end
do local a=np.transpose(np.array({{0.0,-2.0,-2.0},{(0/0),-2.0,4.0}},"float32")); same(np.count_nonzero(a),5) end
do local a=np.flip(np.array({np.complex(0.0,0.0),np.complex(0.0,0.0)},"complex128"),1); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{0,0}) end
do local a=np.transpose(np.array({{-1,0,5},{0,5,1}},"int8")); same(np.all(a),false) end
do local a=np.zeros({2,0,3},"complex64"); same(np.all(a,{where=np.array({{{true,true,true}}},"bool")}),true) end
do local a=np.array({false},"bool"); same(np.count_nonzero(a,{axis={1}}),0) end
do local a=np.array({"a",""},"U3"); same(np.any(a,{where=np.array({true,false},"bool")}),true) end
do local a=np.transpose(np.array({{0},{-1}},"int8")); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{0,1}}) end
do local a=np.array({{{true,true},{true,true},{false,false}},{{true,false},{true,false},{false,false}}},"bool"); local v=np.any(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{{true,true},{true,false}}) end
do local a=np.flip(np.array({5,0,0,1},"int32"),1); same(np.count_nonzero(a),2) end
do local a=np.array({false,true},"bool"); same(np.all(a,{axis=1,where=false}),true) end
do local a=np.transpose(np.array({{{-1,5},{0,1},{1,0}},{{-1,0},{0,0},{0,-1}}},"int8")); same(np.all(a),false) end
do local a=np.transpose(np.array({{4.0,math.huge},{4.0,0.0},{0.0,-0.0}},"float32")); local v=np.all(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{true,false,false}) end
do local a=np.transpose(np.array({{{0,0},{0,0},{0,0}},{{1,5},{0,0},{0,1}}},"int16")); same(np.any(a),true) end
do local a=np.array({-1,1},"int64"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.flip(np.array({{np.complex(-1.0,0.0)},{np.complex(2.0,0.0)}},"complex64"),2); local v=np.all(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{true,true}) end
do local a=np.array({{1,0},{0,-1},{-1,0}},"int8"); local v=np.count_nonzero(a,{axis=2});assert(v.dtype=="int64")
same(v:tolist(),{1,1,1}) end
do local a=np.array({{{np.complex(2.0,0.0),np.complex((0/0),0.0),np.complex(0.0,0.0)},{np.complex(2.0,3.0),np.complex((0/0),3.0),np.complex(0.0,3.0)}}},"complex64"); same(np.count_nonzero(a),5) end
do local a=np.flip(np.array({{"","XX"},{"a","a"},{"xyz","a"}},"U3"),2); local v=np.all(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{true,false}) end
do local a=np.transpose(np.zeros({2,0},"int8")); same(np.all(a,{axis={1,2},where=false}),true) end
do local a=np.array({1,0,0,0},"int32"); local v=np.any(a,{axis={},where=np.array({false,true,true,true},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{false,false,false,false}) end
do local a=np.zeros({0},"float16"); same(np.count_nonzero(a),0) end
do local a=np.flip(np.array({{0.0},{-0.0}},"float16"),2); local v=np.all(a,{axis=2,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false},{false}}) end
do local a=np.zeros({2,0,3},"int8"); same(np.any(a,{where=true}),false) end
do local a=np.array({{np.complex(0.0,0.0),np.complex(-1.0,0.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex((0/0),0.0),np.complex(0.0,0.0)}},"complex128"); local v=np.all(a,{axis={1,2},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.zeros({2,0,3},"int8"); local v=np.any(a,{axis=1,keepdims=true,where=np.array({{{false,true,false}}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{}}) end
do local a=np.array({{np.complex(2.0,0.0)},{np.complex(2.0,0.0)}},"complex128"); local v=np.any(a,{keepdims=true,where=np.array({{true}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.zeros({0},"S3"); same(np.all(a,{axis=1,where=true}),true) end
do local a=np.zeros({0},"U3"); same(np.count_nonzero(a),0) end
do local a=np.transpose(np.zeros({0,3},"uint8")); same(np.count_nonzero(a),0) end
do local a=np.flip(np.array({"a","","xyz","XX"},"U3"),1); local v=np.all(a,{axis={},where=np.array({false,false,true,true},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{true,true,false,true}) end
do local a=np.transpose(np.zeros({0,3},"float16")); local v=np.any(a,{axis=1,where=true});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.array("","S3"); same(np.all(a),false) end
do local a=np.array(1,"uint8"); same(np.count_nonzero(a),1) end
do local a=np.transpose(np.zeros({2,0,3},"uint8")); local v=np.count_nonzero(a,{axis=3});assert(v.dtype=="int64")
same(v:tolist(),{{},{},{}}) end
do local a=np.zeros({2,0},"float16"); same(np.all(a,{axis={1,2},where=false}),true) end
do local a=np.transpose(np.zeros({2,0},"complex64")); same(np.all(a,{axis={1,2},where=np.zeros({0,2},"bool")}),true) end
do local a=np.array({{5},{-1}},"int8"); same(np.all(a,{where=false}),true) end
do local a=np.array({{1},{1}},"uint64"); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{true},{true}}) end
do local a=np.array({{(0/0),math.huge,4.0},{-0.0,-0.0,(0/0)}},"float16"); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{true,true,true},{false,false,true}}) end
do local a=np.array({np.complex(0.0,3.0),np.complex(-1.0,0.0),np.complex(0.0,0.0),np.complex((0/0),3.0)},"complex128"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{1,1,0,1}) end
do local a=np.zeros({2,0},"int64"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0}}) end
do local a=np.flip(np.array({"a","XX","xyz","xyz"},"S3"),1); same(np.count_nonzero(a),4) end
do local a=np.array(false,"bool"); same(np.any(a,{axis={},keepdims=true}),false) end
do local a=np.flip(np.zeros({2,0,3},"complex64"),3); local v=np.count_nonzero(a,{axis={1,2,3},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{0}}}) end
do local a=np.transpose(np.zeros({2,0,3},"U3")); local v=np.any(a,{keepdims=true,where=np.zeros({3,0,2},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{{false}}}) end
do local a=np.transpose(np.array({{{0,0,0},{1,1,0}}},"int64")); local v=np.any(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{false},{true}},{{false},{true}},{{false},{false}}}) end
do local a=np.zeros({0},"float64"); local v=np.all(a,{axis={},keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.transpose(np.array({{false},{false}},"bool")); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.array(0,"uint8"); same(np.any(a,{keepdims=true,where=true}),false) end
do local a=np.flip(np.zeros({0,3},"int16"),2); same(np.all(a),true) end
do local a=np.zeros({0},"int64"); same(np.count_nonzero(a,{axis={1}}),0) end
do local a=np.array({0.0},"float64"); same(np.all(a,{where=true}),false) end
do local a=np.array({{4.0,(0/0)},{0.0,0.0},{4.0,-0.0}},"float64"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{3}}) end
do local a=np.array({{-2.0,0.0,-2.0},{4.0,(0/0),(0/0)}},"float64"); same(np.count_nonzero(a),5) end
do local a=np.flip(np.array({np.complex(2.0,3.0)},"complex128"),1); same(np.any(a),true) end
do local a=np.flip(np.array({{-1,0},{0,9007199254740995},{0,0}},"int64"),2); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{false,true},{true,false},{false,false}}) end
do local a=np.flip(np.zeros({2,0,3},"int16"),3); same(np.all(a,{axis={1,2,3},where=np.zeros({2,0,3},"bool")}),true) end
do local a=np.array({{"","XX",""},{"XX","XX","XX"}},"U3"); same(np.all(a,{where=np.array({{true,false,false}},"bool")}),false) end
do local a=np.transpose(np.array({{{0.0,0.0,-0.0},{-2.0,0.0,-2.0}}},"float32")); same(np.any(a,{axis={1,2,3}}),true) end
do local a=np.array({4.0,-2.0,-2.0,(0/0)},"float64"); same(np.any(a),true) end
do local a=np.array({{{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex(-1.0,3.0),np.complex(-1.0,0.0),np.complex(0.0,0.0)}}},"complex128"); local v=np.any(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{{false,false,false},{true,true,false}}) end
do local a=np.array({{{0,5},{-1,0},{0,-1}},{{0,0},{5,0},{0,5}}},"int32"); same(np.all(a,{axis={1,2,3}}),false) end
do local a=np.array({{{0,-1,0},{-1,0,-1}}},"int8"); same(np.count_nonzero(a),3) end
do local a=np.transpose(np.array({{1,5},{0,5},{5,0}},"int8")); local v=np.count_nonzero(a,{axis=2});assert(v.dtype=="int64")
same(v:tolist(),{2,2}) end
do local a=np.flip(np.array({""},"S3"),1); same(np.any(a),false) end
do local a=np.array("xyz","U3"); same(np.any(a,{keepdims=true}),true) end
do local a=np.flip(np.zeros({0,3},"float16"),2); local v=np.any(a,{axis=2,keepdims=true,where=np.zeros({0,3},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.array({{{"","","xyz"},{"XX","a","a"}}},"U3"); local v=np.count_nonzero(a,{axis=2});assert(v.dtype=="int64")
same(v:tolist(),{{1,1,2}}) end
do local a=np.array({0.0},"float16"); local v=np.any(a,{axis={},where=np.array({false},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.array("xyz","S3"); same(np.count_nonzero(a,{axis={}}),1) end
do local a=np.zeros({0},"float64"); same(np.all(a),true) end
do local a=np.flip(np.array({{{5,-1,-1},{0,-1,5}}},"int8"),3); same(np.any(a,{axis={1,2,3}}),true) end
do local a=np.flip(np.array({0},"int32"),1); same(np.any(a,{axis=1}),false) end
do local a=np.flip(np.array({{false,true,false},{false,false,true}},"bool"),2); same(np.all(a),false) end
do local a=np.transpose(np.zeros({2,0},"complex128")); same(np.count_nonzero(a),0) end
do local a=np.flip(np.array({np.complex((0/0),0.0),np.complex(2.0,0.0),np.complex(-1.0,0.0),np.complex(0.0,0.0)},"complex128"),1); same(np.all(a),false) end
do local a=np.array({5,0,0,1},"int16"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{true,false,false,true}) end
do local a=np.array({np.complex(2.0,3.0)},"complex64"); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{1}) end
do local a=np.array({-2.0,4.0},"float16"); same(np.all(a,{axis=1}),true) end
do local a=np.transpose(np.array({{{0,0},{0,5},{0,1}},{{0,0},{0,0},{1,5}}},"int8")); same(np.any(a,{axis={1,2,3},where=np.array({{{false,false},{false,false},{false,false}},{{false,true},{false,false},{false,false}}},"bool")}),false) end
do local a=np.flip(np.zeros({2,0},"float32"),2); same(np.any(a),false) end
do local a=np.zeros({2,0},"float32"); same(np.all(a,{axis={1,2},where=true}),true) end
do local a=np.flip(np.array({{np.complex(-1.0,0.0),np.complex((0/0),0.0),np.complex(0.0,0.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,3.0)}},"complex64"),2); local v=np.all(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{false,false,false}) end
do local a=np.transpose(np.array({{1,0,0},{0,5,0}},"uint8")); local v=np.count_nonzero(a,{axis=2});assert(v.dtype=="int64")
same(v:tolist(),{1,1,0}) end
do local a=np.array(false,"bool"); same(np.all(a,{where=true}),false) end
do local a=np.array(1,"int32"); same(np.all(a,{axis={}}),true) end
do local a=np.array({"xyz","","xyz","XX"},"U3"); same(np.count_nonzero(a),3) end
do local a=np.array("XX","S3"); same(np.all(a,{axis={}}),true) end
do local a=np.zeros({0},"bool"); same(np.count_nonzero(a),0) end
do local a=np.array({{0},{0}},"int32"); local v=np.all(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.zeros({0},"S3"); same(np.count_nonzero(a),0) end
do local a=np.array(0,"int16"); same(np.count_nonzero(a),0) end
do local a=np.flip(np.zeros({0},"int16"),1); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{0}) end
do local a=np.zeros({0},"U3"); local v=np.all(a,{axis={1},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array(-0.0,"float32"); same(np.count_nonzero(a),0) end
do local a=np.flip(np.zeros({2,0},"complex64"),2); local v=np.count_nonzero(a,{axis={1,2},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0}}) end
do local a=np.array(np.complex(2.0,0.0),"complex128"); same(np.all(a,{axis={},keepdims=true}),true) end
do local a=np.flip(np.array({{-0.0,0.0},{0.0,-0.0},{0.0,0.0}},"float64"),2); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0}}) end
do local a=np.zeros({2,0,3},"complex128"); local v=np.count_nonzero(a,{axis=3});assert(v.dtype=="int64")
same(v:tolist(),{{},{}}) end
do local a=np.zeros({2,0,3},"float32"); same(np.all(a),true) end
do local a=np.array({1},"int64"); same(np.any(a,{where=true}),true) end
do local a=np.array({0.0,-2.0,0.0,-0.0},"float64"); local v=np.any(a,{axis=1,keepdims=true,where=np.array({false,false,true,true},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.flip(np.array({9007199254740995,1,1,0},"uint64"),1); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{3}) end
do local a=np.transpose(np.array({{{0,-1,0},{0,9007199254740995,1}}},"int64")); same(np.any(a),true) end
do local a=np.array(1,"uint8"); same(np.any(a),true) end
do local a=np.zeros({2,0},"U3"); same(np.any(a,{where=np.zeros({2,0},"bool")}),false) end
do local a=np.transpose(np.array({{{(0/0),0.0},{0.0,-2.0},{math.huge,0.0}},{{(0/0),0.0},{-2.0,-2.0},{4.0,4.0}}},"float16")); same(np.any(a),true) end
do local a=np.flip(np.array({5,0,0,0},"int16"),1); local v=np.any(a,{keepdims=true,where=false});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.transpose(np.array({{9007199254740995,0,0},{0,9007199254740995,0}},"uint64")); local v=np.all(a,{axis=1,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false,false}}) end
do local a=np.zeros({2,0},"float16"); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.array({{"","XX"},{"XX",""},{"xyz","a"}},"U3"); same(np.all(a),false) end
do local a=np.zeros({0},"S3"); local v=np.all(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.zeros({0},"float16"); local v=np.any(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.array({5},"int16"); same(np.any(a,{axis={1}}),true) end
do local a=np.array({"","xyz"},"S3"); same(np.all(a,{where=false}),true) end
do local a=np.zeros({0,3},"int32"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0}}) end
do local a=np.zeros({2,0,3},"float32"); same(np.all(a),true) end
do local a=np.array({{{1,-1},{0,1},{0,1}},{{0,-1},{-1,1},{0,0}}},"int8"); same(np.all(a),false) end
do local a=np.zeros({2,0,3},"int16"); same(np.count_nonzero(a),0) end
do local a=np.transpose(np.array({{{np.complex(0.0,0.0),np.complex(-1.0,0.0)},{np.complex(0.0,0.0),np.complex(2.0,0.0)},{np.complex((0/0),3.0),np.complex(-1.0,0.0)}},{{np.complex(0.0,3.0),np.complex(0.0,0.0)},{np.complex(2.0,0.0),np.complex(0.0,3.0)},{np.complex((0/0),0.0),np.complex(0.0,0.0)}}},"complex128")); same(np.count_nonzero(a),8) end
do local a=np.array({4.0,0.0},"float16"); same(np.all(a),false) end
do local a=np.transpose(np.array({{0.0},{-2.0}},"float64")); same(np.count_nonzero(a),1) end
do local a=np.flip(np.array({{{0,1},{1,1},{5,0}},{{0,0},{5,-1},{0,0}}},"int16"),3); local v=np.any(a,{axis={1,2,3},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{true}}}) end
do local a=np.array({0},"int8"); same(np.all(a),false) end
do local a=np.array({0},"int8"); local v=np.all(a,{axis={1},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.zeros({0},"complex64"); same(np.any(a),false) end
do local a=np.flip(np.array({0,0,1,0},"int32"),1); same(np.any(a),true) end
do local a=np.flip(np.zeros({0,3},"float64"),2); local v=np.count_nonzero(a,{axis=2});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.zeros({2,0},"complex128"); same(np.any(a),false) end
do local a=np.array({5},"uint8"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{1}) end
do local a=np.transpose(np.zeros({2,0,3},"uint8")); local v=np.any(a,{axis={},where=true});assert(v.dtype=="bool")
same(v:tolist(),{{},{},{}}) end
do local a=np.flip(np.array({(0/0),0.0,0.0,math.huge},"float64"),1); same(np.count_nonzero(a,{axis=1}),2) end
do local a=np.array({{0,1},{5,0},{0,0}},"int32"); same(np.all(a,{where=false}),true) end
do local a=np.array({{{1,1,0},{0,0,0}}},"uint8"); local v=np.any(a,{axis={1,2,3},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{true}}}) end
do local a=np.flip(np.array({-0.0,math.huge,4.0,math.huge},"float64"),1); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{1,1,1,0}) end
do local a=np.array({1,9007199254740995},"uint64"); same(np.all(a),true) end
do local a=np.flip(np.array({9007199254740995,5,0,1},"int64"),1); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.flip(np.array({{-1},{1}},"int16"),2); local v=np.any(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.flip(np.array({"XX"},"U3"),1); same(np.all(a,{axis=1}),true) end
do local a=np.array({{0},{0}},"int16"); same(np.all(a),false) end
do local a=np.array({{1},{0}},"int32"); local v=np.any(a,{axis=1,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.array({true,false,true,false},"bool"); local v=np.any(a,{axis={1},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array({{"a","XX",""},{"","xyz","XX"}},"S3"); same(np.all(a,{where=np.array({{false,true,true},{false,false,false}},"bool")}),false) end
do local a=np.array(np.complex(-1.0,0.0),"complex128"); same(np.any(a),true) end
do local a=np.flip(np.zeros({0,3},"float16"),2); same(np.all(a,{where=false}),true) end
do local a=np.zeros({2,0,3},"uint8"); local v=np.any(a,{axis=3,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.transpose(np.array({{np.complex(0.0,3.0),np.complex((0/0),0.0),np.complex(-1.0,0.0)},{np.complex(2.0,0.0),np.complex(2.0,0.0),np.complex(0.0,0.0)}},"complex64")); local v=np.count_nonzero(a,{axis=1});assert(v.dtype=="int64")
same(v:tolist(),{3,2}) end
do local a=np.zeros({0,3},"float16"); local v=np.count_nonzero(a,{axis=2,keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.zeros({0},"uint8"); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.zeros({0,3},"float32"); same(np.count_nonzero(a),0) end
do local a=np.array({"XX"},"S3"); local v=np.count_nonzero(a,{axis={1},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{1}) end
do local a=np.zeros({2,0,3},"uint8"); local v=np.all(a,{axis=3});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.transpose(np.array({{0,0},{-1,5},{0,5}},"int16")); same(np.all(a),false) end
do local a=np.transpose(np.zeros({2,0},"U3")); same(np.all(a),true) end
do local a=np.array(math.huge,"float16"); same(np.any(a),true) end
do local a=np.flip(np.array({{{-2.0,(0/0),math.huge},{0.0,-2.0,-2.0}}},"float64"),3); local v=np.all(a,{axis=3,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{true},{false}}}) end
do local a=np.array({0},"int8"); same(np.all(a,{axis=1}),false) end
do local a=np.flip(np.zeros({0},"complex64"),1); same(np.count_nonzero(a),0) end
do local a=np.flip(np.array({"XX","a","xyz","XX"},"U3"),1); local v=np.all(a,{axis={},where=true});assert(v.dtype=="bool")
same(v:tolist(),{true,true,true,true}) end
do local a=np.array({{{np.complex(2.0,0.0),np.complex(-1.0,3.0)},{np.complex(-1.0,0.0),np.complex(0.0,0.0)},{np.complex((0/0),3.0),np.complex(-1.0,0.0)}},{{np.complex(2.0,0.0),np.complex((0/0),0.0)},{np.complex((0/0),3.0),np.complex(2.0,0.0)},{np.complex((0/0),0.0),np.complex(2.0,0.0)}}},"complex128"); same(np.all(a,{where=np.array({{{true,true},{false,false},{true,true}},{{false,true},{false,false},{true,false}}},"bool")}),true) end
do local a=np.array({"XX","XX"},"S3"); local v=np.all(a,{axis={1},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array({{{"xyz","XX",""},{"","","XX"}}},"U3"); local v=np.all(a,{axis={},where=false});assert(v.dtype=="bool")
same(v:tolist(),{{{true,true,true},{true,true,true}}}) end
do local a=np.flip(np.zeros({0,3},"uint64"),2); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0}}) end
do local a=np.flip(np.array({{-2.0,4.0,-0.0},{(0/0),0.0,0.0}},"float64"),2); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.array({0.0},"float32"); same(np.count_nonzero(a,{axis=1}),0) end
do local a=np.array({{false},{true}},"bool"); local v=np.count_nonzero(a,{axis=1});assert(v.dtype=="int64")
same(v:tolist(),{1}) end
do local a=np.array({np.complex(2.0,0.0),np.complex(2.0,3.0),np.complex(0.0,3.0),np.complex(-1.0,0.0)},"complex64"); same(np.all(a,{axis=1}),true) end
do local a=np.zeros({0},"bool"); same(np.count_nonzero(a),0) end
do local a=np.array({1,0},"int8"); same(np.all(a),false) end
do local a=np.array({{{false,false,false},{true,true,false}}},"bool"); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{{false,false,false},{true,true,false}}}) end
do local a=np.array({{"a"},{"a"}},"U3"); same(np.any(a,{axis={1,2}}),true) end
do local a=np.array({np.complex(-1.0,0.0)},"complex64"); same(np.count_nonzero(a),1) end
do local a=np.array({-0.0,0.0,(0/0),-2.0},"float32"); same(np.count_nonzero(a,{axis=1}),2) end
do local a=np.zeros({0,3},"int16"); local v=np.all(a,{axis=1,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true,true,true}}) end
do local a=np.array({{{0.0,4.0,4.0},{(0/0),math.huge,(0/0)}}},"float64"); same(np.count_nonzero(a),5) end
do local a=np.zeros({0},"bool"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{0}) end
do local a=np.array({{np.complex((0/0),3.0),np.complex(2.0,0.0),np.complex((0/0),0.0)},{np.complex(-1.0,0.0),np.complex((0/0),0.0),np.complex((0/0),3.0)}},"complex128"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.array({0,0,0,9007199254740995},"int64"); same(np.all(a,{axis=1}),false) end
do local a=np.array({{math.huge},{0.0}},"float32"); same(np.count_nonzero(a),1) end
do local a=np.flip(np.array({{{0,0,1},{0,-1,-1}}},"int32"),3); local v=np.all(a,{axis=3});assert(v.dtype=="bool")
same(v:tolist(),{{false,false}}) end
do local a=np.array({{{1,0,0},{1,1,0}}},"uint64"); same(np.all(a,{axis={1,2,3}}),false) end
do local a=np.transpose(np.zeros({2,0,3},"int16")); same(np.all(a,{where=false}),true) end
do local a=np.flip(np.zeros({2,0,3},"float32"),3); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{0}}}) end
do local a=np.zeros({0,3},"int16"); same(np.any(a),false) end
do local a=np.array({{false},{true}},"bool"); local v=np.any(a,{axis={1,2},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.zeros({2,0},"int8"); same(np.any(a,{axis={1,2}}),false) end
do local a=np.array(0,"int32"); same(np.count_nonzero(a,{axis={},keepdims=true}),0) end
do local a=np.flip(np.array({"XX","","xyz",""},"U3"),1); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{false,true,false,true}) end
do local a=np.zeros({0},"uint64"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.array(1,"int32"); same(np.all(a,{where=np.array(false,"bool")}),true) end
do local a=np.array({{{0,0,0},{-1,0,1}}},"int64"); same(np.all(a,{where=false}),true) end
do local a=np.transpose(np.zeros({0,3},"uint8")); same(np.any(a),false) end
do local a=np.array({math.huge},"float32"); same(np.count_nonzero(a,{axis={1}}),1) end
do local a=np.flip(np.array({{0.0,-2.0,4.0},{(0/0),math.huge,0.0}},"float16"),2); local v=np.any(a,{axis=1,keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{{true,true,true}}) end
do local a=np.array({1,0},"int32"); same(np.count_nonzero(a,{axis={1}}),1) end
do local a=np.array({{false,false,false},{true,false,true}},"bool"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{false,false,false},{true,false,true}}) end
do local a=np.array(false,"bool"); same(np.all(a,{axis={},keepdims=true,where=false}),true) end
do local a=np.flip(np.zeros({2,0,3},"int64"),3); same(np.count_nonzero(a,{axis={1,2,3}}),0) end
do local a=np.zeros({0},"bool"); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.array({{"XX","","a"},{"","XX","XX"}},"U3"); same(np.all(a),false) end
do local a=np.transpose(np.array({{0.0},{-2.0}},"float16")); same(np.all(a),false) end
do local a=np.zeros({0},"float16"); local v=np.any(a,{keepdims=true,where=false});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.array({{{4.0,-0.0,-0.0},{-0.0,0.0,(0/0)}}},"float16"); local v=np.any(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{{true,false,true}}) end
do local a=np.array(9007199254740995,"int64"); same(np.any(a),true) end
do local a=np.zeros({0,3},"uint8"); local v=np.count_nonzero(a,{axis={1,2},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0}}) end
do local a=np.zeros({0,3},"U3"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.transpose(np.array({{{5,1},{0,0},{0,0}},{{0,-1},{0,9007199254740995},{1,0}}},"int64")); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{true}}}) end
do local a=np.array({"xyz",""},"S3"); same(np.all(a),false) end
do local a=np.array(0,"int64"); same(np.any(a,{keepdims=true,where=np.array(true,"bool")}),false) end
do local a=np.transpose(np.array({{{-1,1},{1,5},{1,0}},{{5,1},{0,-1},{1,-1}}},"int8")); local v=np.all(a,{keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{{{false}}}) end
do local a=np.flip(np.array({{1,0},{5,5},{0,5}},"uint64"),2); local v=np.any(a,{axis={},where=np.array({{true,false}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{false,false},{true,false},{true,false}}) end
do local a=np.array({0.0},"float32"); local v=np.any(a,{axis={1},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.flip(np.zeros({0,3},"float32"),2); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.flip(np.array({{0},{1}},"int64"),2); same(np.any(a,{where=np.array({{false},{false}},"bool")}),false) end
do local a=np.flip(np.array({9007199254740995,0,0,1},"int64"),1); same(np.any(a),true) end
do local a=np.array({0,0,1,0},"int8"); same(np.count_nonzero(a,{axis={1}}),1) end
do local a=np.array({np.complex(0.0,0.0),np.complex(0.0,0.0)},"complex64"); same(np.count_nonzero(a),0) end
do local a=np.array({{5,0,0},{0,1,1}},"int32"); same(np.any(a),true) end
do local a=np.array({(0/0),-2.0},"float32"); same(np.any(a,{axis={1},where=true}),true) end
do local a=np.array({"xyz","xyz","xyz",""},"S3"); local v=np.any(a,{axis=1,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array(np.complex(0.0,0.0),"complex64"); same(np.any(a),false) end
do local a=np.array({1,-1,0,0},"int8"); same(np.all(a,{axis={1}}),false) end
do local a=np.zeros({2,0},"complex128"); same(np.any(a),false) end
do local a=np.transpose(np.array({{false,true},{true,false},{false,false}},"bool")); same(np.count_nonzero(a),2) end
do local a=np.flip(np.array({0},"int64"),1); same(np.all(a),false) end
do local a=np.array({{{np.complex(-1.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex((0/0),0.0),np.complex(0.0,3.0),np.complex(-1.0,0.0)}}},"complex64"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{{true,false,false},{true,true,true}}}) end
do local a=np.transpose(np.zeros({2,0,3},"float64")); same(np.all(a,{where=np.zeros({3,0,2},"bool")}),true) end
do local a=np.array({np.complex((0/0),3.0),np.complex(2.0,3.0)},"complex128"); same(np.any(a),true) end
do local a=np.transpose(np.zeros({0,3},"uint8")); same(np.count_nonzero(a),0) end
do local a=np.zeros({2,0},"float64"); same(np.count_nonzero(a),0) end
do local a=np.array("","U3"); same(np.all(a),false) end
do local a=np.transpose(np.zeros({2,0},"int8")); same(np.count_nonzero(a),0) end
do local a=np.array({"XX",""},"S3"); same(np.all(a,{axis=1,where=np.array({false,true},"bool")}),false) end
do local a=np.array({-1},"int64"); same(np.any(a,{axis=1}),true) end
do local a=np.array({0},"int64"); same(np.count_nonzero(a),0) end
do local a=np.zeros({0,3},"uint8"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.zeros({2,0,3},"int8"); same(np.any(a),false) end
do local a=np.array(0,"uint64"); same(np.count_nonzero(a),0) end
do local a=np.transpose(np.zeros({0,3},"int64")); same(np.all(a),true) end
do local a=np.zeros({2,0,3},"uint8"); same(np.all(a),true) end
do local a=np.flip(np.zeros({2,0,3},"S3"),3); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.flip(np.array({-1,-1},"int16"),1); same(np.any(a,{axis={1},where=false}),false) end
do local a=np.array({0},"int16"); same(np.count_nonzero(a),0) end
do local a=np.transpose(np.array({{0.0,(0/0)},{0.0,0.0},{-0.0,-2.0}},"float32")); local v=np.all(a,{keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.transpose(np.array({{"XX","xyz","xyz"},{"a","xyz","XX"}},"U3")); local v=np.any(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{true,true,true}) end
do local a=np.zeros({0,3},"int32"); local v=np.any(a,{axis=2,where=np.zeros({0,3},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.array(5,"uint64"); same(np.any(a),true) end
do local a=np.array({{1},{0}},"int32"); local v=np.count_nonzero(a,{axis={1,2},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{1}}) end
do local a=np.zeros({2,0},"uint8"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.flip(np.array({{{4.0,0.0,-2.0},{-0.0,0.0,math.huge}}},"float64"),3); local v=np.count_nonzero(a,{axis=1,keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{1,0,1},{1,0,0}}}) end
do local a=np.array({0},"int16"); same(np.count_nonzero(a),0) end
do local a=np.zeros({2,0,3},"int8"); local v=np.all(a,{axis=3,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.transpose(np.zeros({0,3},"bool")); local v=np.any(a,{keepdims=true,where=np.array({{}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.array({0,1,1,5},"uint8"); same(np.all(a,{axis=1,where=np.array({false,false,true,false},"bool")}),true) end
do local a=np.flip(np.zeros({2,0},"int8"),2); local v=np.any(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{false,false}) end
do local a=np.array({np.complex(-1.0,0.0),np.complex(2.0,0.0)},"complex64"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{2}) end
do local a=np.transpose(np.zeros({2,0,3},"float64")); same(np.count_nonzero(a),0) end
do local a=np.zeros({2,0,3},"int16"); same(np.count_nonzero(a),0) end
do local a=np.flip(np.array({{{false,true,false},{true,false,false}}},"bool"),3); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{{false,true,false},{false,false,true}}}) end
do local a=np.transpose(np.zeros({2,0},"int16")); same(np.count_nonzero(a),0) end
do local a=np.array({-1,0},"int32"); local v=np.count_nonzero(a,{axis={1},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{1}) end
do local a=np.array({{{5,0,1},{5,5,0}}},"uint8"); same(np.any(a),true) end
do local a=np.array(0.0,"float32"); same(np.any(a,{axis={},keepdims=true}),false) end
do local a=np.array({(0/0),4.0},"float64"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{1,1}) end
do local a=np.flip(np.array({false,false,false,false},"bool"),1); same(np.count_nonzero(a,{axis={1}}),0) end
do local a=np.zeros({0},"float32"); local v=np.all(a,{keepdims=true,where=false});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array(0,"int32"); same(np.any(a),false) end
do local a=np.transpose(np.array({{{np.complex(-1.0,3.0),np.complex(-1.0,0.0)},{np.complex(0.0,3.0),np.complex((0/0),0.0)},{np.complex((0/0),0.0),np.complex(0.0,3.0)}},{{np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex(0.0,0.0),np.complex(-1.0,0.0)},{np.complex(0.0,3.0),np.complex((0/0),0.0)}}},"complex128")); same(np.all(a),false) end
do local a=np.array({{"xyz","a","XX"},{"XX","XX","a"}},"S3"); same(np.count_nonzero(a),6) end
do local a=np.transpose(np.array({{0,0},{0,1},{0,1}},"int32")); same(np.all(a),false) end
do local a=np.transpose(np.zeros({2,0},"complex64")); same(np.all(a,{axis={1,2}}),true) end
do local a=np.array({-1,0},"int32"); same(np.any(a),true) end
do local a=np.array({"XX"},"U3"); same(np.all(a,{axis=1,where=np.array({true},"bool")}),true) end
do local a=np.array({{"xyz"},{""}},"S3"); local v=np.any(a,{axis={1,2},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.flip(np.zeros({2,0,3},"uint64"),3); same(np.all(a,{where=true}),true) end
do local a=np.zeros({2,0},"uint64"); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.flip(np.array({{true,false},{false,false},{false,false}},"bool"),2); same(np.count_nonzero(a),1) end
do local a=np.array(0,"int16"); same(np.all(a),false) end
do local a=np.array({{{np.complex(0.0,3.0),np.complex(0.0,3.0)},{np.complex(0.0,3.0),np.complex(0.0,3.0)},{np.complex(0.0,3.0),np.complex(0.0,0.0)}},{{np.complex(0.0,0.0),np.complex((0/0),3.0)},{np.complex(-1.0,3.0),np.complex((0/0),0.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0)}}},"complex64"); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{{true,true},{true,true},{true,false}},{{false,true},{true,true},{false,false}}}) end
do local a=np.zeros({0,3},"float16"); same(np.all(a),true) end
do local a=np.transpose(np.zeros({0,3},"int32")); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0}}) end
do local a=np.zeros({0,3},"int32"); same(np.all(a),true) end
do local a=np.array(0,"int8"); same(np.all(a),false) end
do local a=np.array({{np.complex(0.0,0.0)},{np.complex(0.0,3.0)}},"complex64"); same(np.any(a),true) end
do local a=np.flip(np.array({"a","a"},"U3"),1); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{true,true}) end
do local a=np.array(0,"int64"); same(np.all(a),false) end
do local a=np.zeros({0},"int64"); same(np.count_nonzero(a),0) end
do local a=np.array({{0.0,-0.0},{-0.0,-0.0},{(0/0),0.0}},"float16"); local v=np.any(a,{axis=1,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true,false}}) end
do local a=np.zeros({2,0},"float16"); same(np.all(a,{where=true}),true) end
do local a=np.flip(np.array({{{-0.0,-2.0,-0.0},{(0/0),0.0,(0/0)}}},"float64"),3); local v=np.any(a,{axis=3});assert(v.dtype=="bool")
same(v:tolist(),{{true,true}}) end
do local a=np.array("xyz","S3"); same(np.any(a),true) end
do local a=np.zeros({0},"float16"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.array({false},"bool"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{0}) end
do local a=np.array(4.0,"float32"); same(np.count_nonzero(a),1) end
do local a=np.transpose(np.zeros({2,0,3},"float16")); local v=np.count_nonzero(a,{axis=2});assert(v.dtype=="int64")
same(v:tolist(),{{0,0},{0,0},{0,0}}) end
do local a=np.array({1,9007199254740995,0,0},"uint64"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{2}) end
do local a=np.array({0,-1,5,0},"int64"); same(np.count_nonzero(a),2) end
do local a=np.transpose(np.array({{1},{0}},"uint8")); same(np.count_nonzero(a),1) end
do local a=np.flip(np.array({{5,0,1},{5,0,-1}},"int32"),2); local v=np.any(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{true,false,true}) end
do local a=np.array({""},"U3"); same(np.any(a),false) end
do local a=np.array({{"a"},{"xyz"}},"U3"); same(np.all(a),true) end
do local a=np.transpose(np.array({{{np.complex((0/0),0.0),np.complex((0/0),0.0)},{np.complex(0.0,0.0),np.complex(-1.0,0.0)},{np.complex(2.0,0.0),np.complex(2.0,0.0)}},{{np.complex((0/0),0.0),np.complex(2.0,3.0)},{np.complex(0.0,0.0),np.complex(2.0,0.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0)}}},"complex128")); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{{1,1},{0,0},{1,0}},{{1,1},{1,1},{1,0}}}) end
do local a=np.transpose(np.array({{{(0/0),0.0},{-2.0,-2.0},{-2.0,math.huge}},{{0.0,-0.0},{-0.0,-0.0},{0.0,0.0}}},"float32")); same(np.any(a),true) end
do local a=np.zeros({0},"S3"); local v=np.all(a,{keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.flip(np.array({{0},{0}},"uint8"),2); same(np.all(a),false) end
do local a=np.array({{-0.0},{(0/0)}},"float64"); same(np.all(a),false) end
do local a=np.array({{0,1},{0,0},{0,-1}},"int8"); same(np.all(a),false) end
do local a=np.array({{{5,1,0},{5,0,-1}}},"int64"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{4}}}) end
do local a=np.flip(np.zeros({0,3},"float32"),2); same(np.all(a,{where=np.array({{true,false,true}},"bool")}),true) end
do local a=np.zeros({0,3},"U3"); local v=np.any(a,{axis={1,2},keepdims=true,where=np.zeros({0,3},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.zeros({2,0,3},"float32"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{},{}}) end
do local a=np.array({-1,0,0,0},"int64"); same(np.any(a),true) end
do local a=np.zeros({2,0},"uint8"); same(np.count_nonzero(a,{axis={1,2}}),0) end
do local a=np.array({{{-0.0,0.0,-2.0},{0.0,-0.0,-0.0}}},"float64"); same(np.count_nonzero(a),1) end
do local a=np.transpose(np.array({{"XX","XX",""},{"XX","a",""}},"U3")); same(np.any(a),true) end
do local a=np.flip(np.array({np.complex((0/0),0.0)},"complex64"),1); same(np.any(a,{where=np.array({false},"bool")}),false) end
do local a=np.array(np.complex(2.0,0.0),"complex64"); same(np.any(a,{where=false}),false) end
do local a=np.flip(np.array({{5,0},{-1,0},{0,0}},"int8"),2); same(np.count_nonzero(a),2) end
do local a=np.zeros({0},"uint64"); same(np.count_nonzero(a,{axis={1}}),0) end
do local a=np.array({0.0},"float64"); same(np.any(a,{axis={1}}),false) end
do local a=np.array({{{0,0},{0,1},{1,0}},{{0,0},{0,1},{-1,5}}},"int32"); local v=np.count_nonzero(a,{axis=2});assert(v.dtype=="int64")
same(v:tolist(),{{1,1},{1,2}}) end
do local a=np.flip(np.array({1},"int32"),1); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{1}) end
do local a=np.array({{{1,0},{1,0},{0,1}},{{0,5},{0,1},{0,1}}},"uint8"); local v=np.any(a,{keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{{{true}}}) end
do local a=np.flip(np.zeros({0,3},"U3"),2); same(np.all(a),true) end
do local a=np.transpose(np.zeros({0,3},"int32")); same(np.count_nonzero(a),0) end
do local a=np.array({0,0,0,0},"int32"); same(np.any(a,{where=false}),false) end
do local a=np.transpose(np.array({{0,-1},{0,0},{1,0}},"int8")); local v=np.count_nonzero(a,{axis={1,2},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{2}}) end
do local a=np.zeros({0},"float64"); same(np.all(a),true) end
do local a=np.transpose(np.zeros({2,0},"uint8")); same(np.count_nonzero(a),0) end
do local a=np.flip(np.array({np.complex(2.0,0.0)},"complex64"),1); same(np.count_nonzero(a),1) end
do local a=np.transpose(np.array({{np.complex(2.0,0.0),np.complex(-1.0,0.0),np.complex(0.0,3.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex((0/0),3.0)}},"complex128")); same(np.any(a),true) end
do local a=np.flip(np.array({{{1,0},{5,1},{5,-1}},{{0,-1},{0,-1},{5,-1}}},"int16"),3); same(np.any(a,{axis={1,2,3},where=true}),true) end
do local a=np.array({{1,1,0},{0,0,0}},"int16"); local v=np.any(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{true,false}) end
do local a=np.flip(np.array({"","a"},"S3"),1); same(np.any(a,{axis={1}}),true) end
do local a=np.array({{math.huge,-0.0,4.0},{-0.0,0.0,0.0}},"float32"); same(np.any(a),true) end
do local a=np.flip(np.array({{"","a","a"},{"xyz","XX","a"}},"U3"),2); same(np.all(a),false) end
do local a=np.array({{0},{0}},"int16"); same(np.count_nonzero(a),0) end
do local a=np.transpose(np.array({{np.complex(-1.0,0.0),np.complex(-1.0,0.0),np.complex(2.0,0.0)},{np.complex(2.0,0.0),np.complex(-1.0,0.0),np.complex(2.0,0.0)}},"complex64")); local v=np.count_nonzero(a,{axis=1});assert(v.dtype=="int64")
same(v:tolist(),{3,3}) end
do local a=np.zeros({0},"complex128"); same(np.any(a),false) end
do local a=np.flip(np.zeros({0,3},"float16"),2); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.array(0.0,"float16"); same(np.all(a,{where=false}),true) end
do local a=np.zeros({0,3},"bool"); same(np.all(a,{axis={1,2},where=true}),true) end
do local a=np.array({np.complex(-1.0,0.0),np.complex(2.0,3.0),np.complex(2.0,0.0),np.complex(2.0,0.0)},"complex64"); same(np.all(a,{axis={1}}),true) end
do local a=np.transpose(np.array({{"a","XX","XX"},{"XX","","XX"}},"S3")); local v=np.count_nonzero(a,{axis={1,2},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{5}}) end
do local a=np.zeros({2,0},"complex64"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0}}) end
do local a=np.array({{4.0},{-2.0}},"float64"); local v=np.any(a,{axis=1,where=false});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.array({{1},{1}},"int32"); same(np.count_nonzero(a,{axis={1,2}}),2) end
do local a=np.array(0,"int8"); same(np.count_nonzero(a,{axis={}}),0) end
do local a=np.flip(np.array({{{np.complex(-1.0,0.0),np.complex(-1.0,0.0),np.complex(0.0,0.0)},{np.complex(-1.0,0.0),np.complex(0.0,3.0),np.complex(0.0,0.0)}}},"complex128"),3); same(np.any(a,{axis={1,2,3}}),true) end
do local a=np.array({{{0.0,-2.0,-0.0},{0.0,-0.0,4.0}}},"float64"); local v=np.all(a,{axis={},where=np.array({{{true,true,true}}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{{false,true,false},{false,false,true}}}) end
do local a=np.zeros({0},"float32"); same(np.count_nonzero(a),0) end
do local a=np.array({1,0},"uint8"); local v=np.any(a,{axis={},where=np.array({true,false},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{true,false}) end
do local a=np.transpose(np.zeros({0,3},"int64")); same(np.any(a,{where=np.zeros({3,0},"bool")}),false) end
do local a=np.transpose(np.zeros({0,3},"int32")); same(np.all(a),true) end
do local a=np.array({{{0.0,0.0},{4.0,math.huge},{(0/0),0.0}},{{0.0,4.0},{math.huge,0.0},{-2.0,math.huge}}},"float64"); same(np.all(a,{where=np.array({{{true,false},{false,false},{false,false}},{{false,true},{true,false},{true,false}}},"bool")}),false) end
do local a=np.array(4.0,"float32"); same(np.any(a,{keepdims=true}),true) end
do local a=np.flip(np.array({{0,1,0},{5,1,0}},"uint8"),2); local v=np.any(a,{axis={},where=false});assert(v.dtype=="bool")
same(v:tolist(),{{false,false,false},{false,false,false}}) end
do local a=np.flip(np.zeros({0},"int8"),1); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.array(0.0,"float16"); same(np.any(a,{where=false}),false) end
do local a=np.flip(np.array({{np.complex(0.0,0.0),np.complex((0/0),0.0)},{np.complex(2.0,0.0),np.complex((0/0),3.0)},{np.complex(0.0,3.0),np.complex(2.0,3.0)}},"complex64"),2); same(np.any(a),true) end
do local a=np.zeros({0,3},"complex128"); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.transpose(np.array({{{0,1},{1,0},{1,0}},{{0,0},{0,0},{5,5}}},"uint8")); same(np.any(a),true) end
do local a=np.transpose(np.zeros({2,0,3},"U3")); same(np.count_nonzero(a),0) end
do local a=np.flip(np.array({0},"uint64"),1); local v=np.any(a,{axis={},keepdims=true,where=np.array({false},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.array({{"a","xyz"},{"XX","a"},{"",""}},"S3"); same(np.all(a,{axis={1,2}}),false) end
do local a=np.zeros({2,0,3},"uint8"); local v=np.all(a,{axis={},keepdims=true,where=false});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.array({1},"int32"); local v=np.all(a,{axis={1},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array({{{np.complex(0.0,0.0),np.complex(-1.0,0.0),np.complex(2.0,0.0)},{np.complex(0.0,3.0),np.complex(-1.0,0.0),np.complex(0.0,0.0)}}},"complex64"); same(np.all(a),false) end
do local a=np.array({{1},{0}},"int8"); local v=np.all(a,{axis={},keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{{true},{false}}) end
do local a=np.flip(np.array({{true,true,false},{false,false,false}},"bool"),2); local v=np.count_nonzero(a,{axis=1});assert(v.dtype=="int64")
same(v:tolist(),{0,1,1}) end
do local a=np.array({{"","a"},{"XX","xyz"},{"a",""}},"U3"); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{false,true},{true,true},{true,false}}) end
do local a=np.array(0,"uint64"); same(np.any(a,{keepdims=true}),false) end
do local a=np.transpose(np.array({{1},{0}},"uint64")); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.zeros({2,0},"int32"); same(np.all(a,{where=true}),true) end
do local a=np.array({{math.huge},{0.0}},"float64"); local v=np.count_nonzero(a,{axis=2});assert(v.dtype=="int64")
same(v:tolist(),{1,0}) end
do local a=np.flip(np.zeros({0},"int16"),1); same(np.all(a,{where=true}),true) end
do local a=np.transpose(np.array({{{"a","XX","a"},{"a","XX",""}}},"U3")); same(np.all(a,{axis={1,2,3}}),false) end
do local a=np.array({5,0},"int32"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{1}) end
do local a=np.flip(np.array({{0,5},{5,1},{-1,0}},"int16"),2); same(np.count_nonzero(a),4) end
do local a=np.zeros({2,0,3},"int8"); same(np.any(a),false) end
do local a=np.zeros({0,3},"int8"); same(np.count_nonzero(a),0) end
do local a=np.array({0,0},"int64"); same(np.count_nonzero(a,{axis=1}),0) end
do local a=np.flip(np.array({{{-2.0,-2.0},{-0.0,-2.0},{math.huge,4.0}},{{0.0,-2.0},{-0.0,-0.0},{0.0,0.0}}},"float32"),3); same(np.any(a,{axis={1,2,3}}),true) end
do local a=np.flip(np.zeros({0,3},"uint8"),2); local v=np.any(a,{axis=1,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false,false,false}}) end
do local a=np.flip(np.zeros({2,0,3},"bool"),3); local v=np.all(a,{axis=1,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{}}) end
do local a=np.transpose(np.zeros({2,0},"uint8")); local v=np.any(a,{keepdims=true,where=false});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.zeros({0},"int32"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array({true},"bool"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.flip(np.array({false,true},"bool"),1); same(np.count_nonzero(a),1) end
do local a=np.array({{{0,0},{-1,0},{0,-1}},{{5,0},{0,0},{0,0}}},"int8"); same(np.count_nonzero(a,{axis={1,2,3}}),3) end
do local a=np.flip(np.array({{false,true},{true,false},{true,false}},"bool"),2); local v=np.count_nonzero(a,{axis=1});assert(v.dtype=="int64")
same(v:tolist(),{1,2}) end
do local a=np.flip(np.zeros({0},"float16"),1); same(np.all(a),true) end
do local a=np.array({math.huge},"float64"); same(np.all(a,{where=np.array({false},"bool")}),true) end
do local a=np.array({{false},{true}},"bool"); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0},{1}}) end
do local a=np.array({{-1,0,1},{0,1,1}},"int16"); local v=np.all(a,{axis={},keepdims=true,where=np.array({{false,true,false},{true,true,true}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{true,false,true},{false,true,true}}) end
do local a=np.zeros({0},"float64"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{0}) end
do local a=np.array({1,5},"int32"); same(np.count_nonzero(a),2) end
do local a=np.flip(np.array({{5,0},{9007199254740995,1},{0,0}},"int64"),2); local v=np.any(a,{axis={},keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{{false,true},{true,true},{false,false}}) end
do local a=np.flip(np.array({{{0,0,0},{5,5,0}}},"int16"),3); local v=np.any(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{false,false,false},{false,true,true}}}) end
do local a=np.zeros({2,0},"bool"); same(np.any(a),false) end
do local a=np.flip(np.zeros({2,0},"complex64"),2); same(np.any(a),false) end
do local a=np.zeros({0},"int32"); same(np.count_nonzero(a),0) end
do local a=np.array({-2.0,4.0},"float16"); same(np.count_nonzero(a,{axis={1}}),2) end
do local a=np.transpose(np.zeros({2,0},"int8")); local v=np.count_nonzero(a,{axis=1});assert(v.dtype=="int64")
same(v:tolist(),{0,0}) end
do local a=np.array({{{false,true},{false,true},{false,true}},{{false,true},{true,true},{false,false}}},"bool"); local v=np.any(a,{axis=3});assert(v.dtype=="bool")
same(v:tolist(),{{true,true,true},{true,true,false}}) end
do local a=np.array({np.complex(0.0,0.0),np.complex(-1.0,0.0),np.complex(-1.0,0.0),np.complex(0.0,0.0)},"complex64"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.transpose(np.array({{-2.0,-0.0,(0/0)},{0.0,math.huge,0.0}},"float64")); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{true,false},{false,true},{true,false}}) end
do local a=np.array({{0,-1,0},{0,0,5}},"int32"); same(np.count_nonzero(a),2) end
do local a=np.array({"a"},"U3"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{1}) end
do local a=np.flip(np.array({-2.0,0.0,(0/0),0.0},"float16"),1); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{0,1,0,1}) end
do local a=np.array({{{"xyz","a"},{"XX","a"},{"xyz","a"}},{{"XX","xyz"},{"XX","a"},{"","a"}}},"S3"); same(np.any(a,{axis={1,2,3}}),true) end
do local a=np.zeros({0,3},"int32"); local v=np.any(a,{axis=2,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.flip(np.array({-1,0,5,0},"int64"),1); same(np.all(a),false) end
do local a=np.transpose(np.zeros({2,0},"uint8")); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.array(1,"int8"); same(np.any(a,{keepdims=true,where=np.array(false,"bool")}),false) end
do local a=np.array({"XX","","XX","xyz"},"U3"); local v=np.any(a,{axis={1},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.transpose(np.array({{true},{true}},"bool")); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{true,true}}) end
do local a=np.flip(np.array({{0,9007199254740995,1},{0,0,1}},"uint64"),2); same(np.count_nonzero(a),3) end
do local a=np.transpose(np.zeros({2,0,3},"int8")); same(np.any(a),false) end
do local a=np.transpose(np.array({{0,0,9007199254740995},{0,0,0}},"int64")); local v=np.count_nonzero(a,{axis=1});assert(v.dtype=="int64")
same(v:tolist(),{1,0}) end
do local a=np.zeros({0,3},"int64"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.flip(np.zeros({2,0},"int64"),2); local v=np.all(a,{keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.array({{0,0,5},{1,0,1}},"int32"); local v=np.count_nonzero(a,{axis=2,keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{1},{2}}) end
do local a=np.array(np.complex(0.0,3.0),"complex64"); same(np.all(a,{keepdims=true,where=np.array(false,"bool")}),true) end
do local a=np.array({4.0},"float32"); same(np.count_nonzero(a,{axis={1}}),1) end
do local a=np.flip(np.array({{{5,0},{1,0},{0,5}},{{0,0},{5,-1},{5,-1}}},"int16"),3); same(np.all(a),false) end
do local a=np.flip(np.zeros({2,0,3},"S3"),3); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{false}}}) end
do local a=np.array({0,0},"int16"); same(np.count_nonzero(a),0) end
do local a=np.flip(np.array({{{"a","xyz"},{"a","a"},{"xyz","XX"}},{{"XX","xyz"},{"xyz",""},{"xyz","xyz"}}},"S3"),3); same(np.all(a,{where=np.array({{{true,false}}},"bool")}),false) end
do local a=np.array({{"a","xyz","a"},{"a","XX","XX"}},"U3"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{1,1,1},{1,1,1}}) end
do local a=np.transpose(np.zeros({2,0},"int32")); same(np.any(a,{axis={1,2},where=np.array({{true,true}},"bool")}),false) end
do local a=np.transpose(np.zeros({2,0},"int16")); same(np.any(a),false) end
do local a=np.zeros({2,0,3},"U3"); local v=np.all(a,{axis={1,2,3},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{true}}}) end
do local a=np.array(false,"bool"); same(np.any(a,{axis={},where=np.array(false,"bool")}),false) end
do local a=np.zeros({2,0},"uint64"); same(np.count_nonzero(a),0) end
do local a=np.array(-1,"int16"); same(np.all(a),true) end
do local a=np.flip(np.array({{{-2.0,(0/0)},{(0/0),(0/0)},{0.0,(0/0)}},{{-0.0,math.huge},{-0.0,math.huge},{0.0,math.huge}}},"float64"),3); same(np.all(a,{axis={1,2,3}}),false) end
do local a=np.array({math.huge,4.0},"float16"); same(np.any(a),true) end
do local a=np.array({{"a","xyz","xyz"},{"XX","XX","xyz"}},"S3"); same(np.count_nonzero(a),6) end
do local a=np.array({{{1,1,-1},{0,0,1}}},"int32"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{4}}}) end
do local a=np.array({0,9007199254740995},"int64"); local v=np.any(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{false,true}) end
do local a=np.array({{{0,5},{1,1},{0,1}},{{0,0},{-1,0},{1,5}}},"int16"); local v=np.all(a,{axis={},where=np.array({{{false,true},{false,true},{true,true}},{{false,true},{true,true},{true,false}}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{{true,true},{true,true},{false,true}},{{true,false},{true,false},{true,true}}}) end
do local a=np.flip(np.zeros({2,0},"U3"),2); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0}}) end
do local a=np.flip(np.zeros({2,0},"U3"),2); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{},{}}) end
do local a=np.array({{{np.complex(-1.0,0.0),np.complex(0.0,0.0)},{np.complex(0.0,3.0),np.complex(0.0,3.0)},{np.complex(2.0,3.0),np.complex((0/0),3.0)}},{{np.complex(-1.0,3.0),np.complex(0.0,0.0)},{np.complex(2.0,0.0),np.complex(0.0,0.0)},{np.complex(2.0,3.0),np.complex(2.0,0.0)}}},"complex128"); local v=np.all(a,{axis=3,where=true});assert(v.dtype=="bool")
same(v:tolist(),{{false,true,true},{false,false,true}}) end
do local a=np.array({0,0,1,5},"int16"); same(np.count_nonzero(a,{axis=1}),2) end
do local a=np.array({{{0,1},{5,1},{0,-1}},{{1,0},{0,5},{0,-1}}},"int8"); same(np.count_nonzero(a),7) end
do local a=np.flip(np.zeros({2,0},"bool"),2); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.array({-1},"int16"); same(np.count_nonzero(a,{axis=1}),1) end
do local a=np.zeros({2,0,3},"bool"); local v=np.any(a,{axis={1,2,3},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{false}}}) end
do local a=np.array({{-1,0},{0,-1},{0,-1}},"int16"); same(np.count_nonzero(a),3) end
do local a=np.zeros({2,0},"complex64"); same(np.all(a,{axis={1,2}}),true) end
do local a=np.array({"","XX"},"S3"); same(np.count_nonzero(a,{axis=1}),1) end
do local a=np.flip(np.array({{4.0,math.huge,math.huge},{4.0,(0/0),math.huge}},"float16"),2); local v=np.all(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true,true,true},{true,true,true}}) end
do local a=np.array({-1,-1},"int8"); same(np.any(a),true) end
do local a=np.zeros({0},"complex128"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.array({0},"int32"); same(np.any(a,{where=np.array({true},"bool")}),false) end
do local a=np.array(5,"int8"); same(np.any(a,{axis={}}),true) end
do local a=np.array({{{true,true},{true,false},{false,false}},{{false,false},{true,false},{true,false}}},"bool"); same(np.any(a),true) end
do local a=np.flip(np.array({{{"a","a","xyz"},{"xyz","xyz","XX"}}},"S3"),3); local v=np.any(a,{axis=3});assert(v.dtype=="bool")
same(v:tolist(),{{true,true}}) end
do local a=np.flip(np.array({true},"bool"),1); same(np.all(a,{axis=1,where=false}),true) end
do local a=np.array({np.complex(2.0,0.0)},"complex64"); same(np.all(a,{axis={1},where=np.array({true},"bool")}),true) end
do local a=np.flip(np.zeros({2,0,3},"int16"),3); same(np.any(a),false) end
do local a=np.array({9007199254740995},"uint64"); same(np.count_nonzero(a),1) end
do local a=np.flip(np.zeros({2,0,3},"complex64"),3); same(np.all(a,{where=false}),true) end
do local a=np.array({{5},{1}},"uint64"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.zeros({2,0},"float32"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.flip(np.zeros({0,3},"complex64"),2); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.zeros({2,0,3},"float32"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{true}}}) end
do local a=np.array({0},"int8"); same(np.count_nonzero(a,{axis={1}}),0) end
do local a=np.zeros({2,0,3},"complex64"); local v=np.any(a,{axis={1,2,3},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{false}}}) end
do local a=np.transpose(np.array({{{-0.0,0.0},{4.0,-0.0},{4.0,(0/0)}},{{(0/0),4.0},{0.0,-0.0},{-2.0,(0/0)}}},"float16")); local v=np.count_nonzero(a,{axis=1,keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{0,2},{1,0},{2,2}}}) end
do local a=np.transpose(np.zeros({2,0,3},"uint8")); local v=np.any(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{},{},{}}) end
do local a=np.array({{"XX",""},{"","xyz"},{"xyz","XX"}},"U3"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.flip(np.array({-2.0,0.0,0.0,0.0},"float16"),1); local v=np.any(a,{axis={1},keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array({0},"int8"); same(np.all(a,{where=np.array({false},"bool")}),true) end
do local a=np.flip(np.array({"xyz","a"},"S3"),1); same(np.all(a),true) end
do local a=np.array({{0,-1},{5,5},{0,5}},"int16"); local v=np.count_nonzero(a,{axis=1});assert(v.dtype=="int64")
same(v:tolist(),{1,3}) end
do local a=np.transpose(np.array({{"a",""},{"a","XX"},{"","XX"}},"U3")); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{1,1,0},{0,1,1}}) end
do local a=np.flip(np.array({{{0,0},{-1,0},{5,0}},{{0,0},{1,0},{0,0}}},"int32"),3); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{{false,false},{false,true},{false,true}},{{false,false},{false,true},{false,false}}}) end
do local a=np.flip(np.array({np.complex(0.0,0.0),np.complex(0.0,0.0)},"complex128"),1); same(np.any(a,{where=false}),false) end
do local a=np.array({{5,-1},{1,0},{5,1}},"int16"); same(np.all(a,{axis={1,2}}),false) end
do local a=np.transpose(np.array({{np.complex(0.0,0.0)},{np.complex(2.0,0.0)}},"complex128")); same(np.any(a),true) end
do local a=np.array({{9007199254740995,5,1},{5,0,0}},"uint64"); same(np.count_nonzero(a),4) end
do local a=np.array({"xyz",""},"S3"); same(np.count_nonzero(a,{axis={1}}),1) end
do local a=np.transpose(np.array({{0,1,0},{0,0,0}},"uint8")); same(np.count_nonzero(a),1) end
do local a=np.zeros({0},"float64"); same(np.any(a),false) end
do local a=np.zeros({0},"S3"); same(np.all(a,{axis={1}}),true) end
do local a=np.zeros({0,3},"int16"); local v=np.all(a,{keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.array({{np.complex(2.0,3.0),np.complex((0/0),0.0),np.complex(-1.0,0.0)},{np.complex(2.0,0.0),np.complex(-1.0,0.0),np.complex(0.0,3.0)}},"complex64"); same(np.all(a),true) end
do local a=np.array({{{1,0},{9007199254740995,0},{0,1}},{{5,1},{0,0},{0,1}}},"uint64"); same(np.all(a,{axis={1,2,3},where=np.array({{{true,true},{true,false},{true,false}},{{true,false},{false,false},{true,true}}},"bool")}),false) end
do local a=np.zeros({2,0},"float64"); local v=np.all(a,{axis={},where=false});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.array({{math.huge},{4.0}},"float32"); local v=np.any(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.flip(np.zeros({0},"float32"),1); same(np.all(a),true) end
do local a=np.flip(np.array({0.0,4.0,0.0,4.0},"float32"),1); same(np.count_nonzero(a),2) end
do local a=np.array({{{"xyz","a"},{"a","xyz"},{"xyz","a"}},{{"xyz",""},{"a",""},{"a","a"}}},"S3"); same(np.all(a),false) end
do local a=np.flip(np.zeros({2,0,3},"uint8"),3); same(np.count_nonzero(a),0) end
do local a=np.flip(np.zeros({0},"int8"),1); same(np.all(a),true) end
do local a=np.array(0,"int16"); same(np.count_nonzero(a,{axis={}}),0) end
do local a=np.zeros({0},"uint8"); local v=np.count_nonzero(a,{axis={1},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{0}) end
do local a=np.zeros({0,3},"int8"); local v=np.any(a,{axis={},where=np.array({{true,false,false}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.array({-2.0,4.0,0.0,-0.0},"float32"); same(np.any(a),true) end
do local a=np.array(5,"int16"); same(np.any(a,{axis={}}),true) end
do local a=np.flip(np.zeros({2,0},"int8"),2); same(np.all(a),true) end
do local a=np.array({{1,0,1},{5,1,5}},"int16"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{5}}) end
do local a=np.array(0,"uint8"); same(np.count_nonzero(a,{keepdims=true}),0) end
do local a=np.array({{np.complex(0.0,0.0)},{np.complex((0/0),3.0)}},"complex128"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{0},{1}}) end
do local a=np.array("XX","S3"); same(np.all(a),true) end
do local a=np.flip(np.array({{5,5},{1,5},{0,5}},"int8"),2); same(np.count_nonzero(a),5) end
do local a=np.array({{{"XX","a","xyz"},{"a","xyz","XX"}}},"S3"); local v=np.any(a,{axis=1,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{true,true,true},{true,true,true}}}) end
do local a=np.flip(np.array({{-2.0,0.0,(0/0)},{math.huge,0.0,4.0}},"float16"),2); local v=np.count_nonzero(a,{axis={1,2},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{4}}) end
do local a=np.flip(np.array({"a"},"S3"),1); same(np.any(a,{where=false}),false) end
do local a=np.array(0,"uint8"); same(np.all(a,{where=false}),true) end
do local a=np.zeros({0,3},"U3"); local v=np.count_nonzero(a,{axis=2});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.zeros({0,3},"S3"); local v=np.any(a,{axis={},where=np.array({{false,true,false}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.zeros({0,3},"uint8"); same(np.count_nonzero(a),0) end
do local a=np.transpose(np.array({{0,0,0},{0,0,0}},"int32")); same(np.all(a,{where=np.array({{true,false}},"bool")}),false) end
do local a=np.array({{math.huge,-0.0},{math.huge,math.huge},{4.0,0.0}},"float64"); local v=np.any(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{true,true}) end
do local a=np.array({{"a","xyz",""},{"","xyz","xyz"}},"U3"); local v=np.any(a,{axis=1,where=true});assert(v.dtype=="bool")
same(v:tolist(),{true,true,true}) end
do local a=np.zeros({0},"int64"); same(np.count_nonzero(a),0) end
do local a=np.array({-2.0,0.0},"float16"); same(np.any(a),true) end
do local a=np.flip(np.array({{9007199254740995,0},{0,1},{1,9007199254740995}},"uint64"),2); same(np.all(a),false) end
do local a=np.array({0,0,-1,0},"int8"); same(np.count_nonzero(a),1) end
do local a=np.flip(np.array({{5},{0}},"int16"),2); same(np.any(a,{axis={1,2}}),true) end
do local a=np.zeros({2,0,3},"int8"); local v=np.count_nonzero(a,{axis=2,keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{0,0,0}},{{0,0,0}}}) end
do local a=np.flip(np.array({{{math.huge,(0/0),math.huge},{-2.0,0.0,-2.0}}},"float16"),3); local v=np.count_nonzero(a,{axis=3});assert(v.dtype=="int64")
same(v:tolist(),{{3,2}}) end
do local a=np.array({{"xyz"},{"xyz"}},"U3"); same(np.any(a,{where=np.array({{false},{true}},"bool")}),true) end
do local a=np.array({{0},{0}},"int8"); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{false},{false}}) end
do local a=np.flip(np.zeros({0},"int8"),1); same(np.all(a),true) end
do local a=np.transpose(np.array({{np.complex(-1.0,0.0)},{np.complex((0/0),0.0)}},"complex128")); local v=np.any(a,{axis={1,2},keepdims=true,where=np.array({{false,false}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.array({{{0.0,0.0,-0.0},{math.huge,-2.0,math.huge}}},"float64"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{{0,0,0},{1,1,1}}}) end
do local a=np.array({{0,5},{-1,0},{0,0}},"int16"); local v=np.any(a,{keepdims=true,where=false});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.array("XX","U3"); same(np.all(a,{axis={}}),true) end
do local a=np.array({{np.complex(0.0,0.0),np.complex(2.0,3.0)},{np.complex((0/0),0.0),np.complex(0.0,0.0)},{np.complex((0/0),0.0),np.complex((0/0),3.0)}},"complex128"); same(np.count_nonzero(a),4) end
do local a=np.flip(np.zeros({0,3},"complex128"),2); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.array({{"xyz","XX","XX"},{"xyz","xyz","XX"}},"U3"); same(np.count_nonzero(a),6) end
do local a=np.flip(np.array({{{0.0,-2.0,-0.0},{4.0,0.0,math.huge}}},"float32"),3); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{false}}}) end
do local a=np.transpose(np.zeros({2,0},"U3")); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.flip(np.zeros({0,3},"float32"),2); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.array({false,true,true,false},"bool"); same(np.all(a,{axis={1}}),false) end
do local a=np.array(5,"uint64"); same(np.any(a),true) end
do local a=np.array({{-1,0,0},{1,-1,0}},"int32"); same(np.any(a),true) end
do local a=np.array({"a"},"S3"); same(np.all(a,{where=np.array({true},"bool")}),true) end
do local a=np.flip(np.zeros({0},"U3"),1); same(np.all(a),true) end
do local a=np.flip(np.array({{{"XX","xyz","xyz"},{"XX","",""}}},"U3"),3); local v=np.count_nonzero(a,{axis=3});assert(v.dtype=="int64")
same(v:tolist(),{{3,1}}) end
do local a=np.array({{{0,-1,0},{5,0,0}}},"int8"); local v=np.all(a,{axis=3});assert(v.dtype=="bool")
same(v:tolist(),{{false,false}}) end
do local a=np.array({"a","","xyz","XX"},"U3"); local v=np.count_nonzero(a,{axis={1},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{3}) end
do local a=np.transpose(np.array({{false,true},{true,false},{false,false}},"bool")); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{0,1,0},{1,0,0}}) end
do local a=np.array({4.0,0.0},"float64"); same(np.all(a,{axis=1}),false) end
do local a=np.transpose(np.array({{"xyz"},{"a"}},"S3")); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{1,1}}) end
do local a=np.array({5,9007199254740995},"int64"); same(np.any(a),true) end
do local a=np.flip(np.array({{5},{5}},"int8"),2); local v=np.any(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{true,true}) end
do local a=np.transpose(np.zeros({2,0,3},"int8")); same(np.count_nonzero(a,{axis={1,2,3}}),0) end
do local a=np.flip(np.zeros({2,0},"complex64"),2); local v=np.all(a,{axis=2,where=np.zeros({2,0},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{true,true}) end
do local a=np.array({-2.0,(0/0),-0.0,(0/0)},"float32"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{3}) end
do local a=np.zeros({2,0,3},"S3"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{false}}}) end
do local a=np.array({{0,0,0},{0,0,1}},"int32"); local v=np.any(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{false,true}) end
do local a=np.zeros({0,3},"float64"); local v=np.any(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.zeros({2,0},"uint64"); same(np.count_nonzero(a),0) end
do local a=np.array({np.complex(0.0,0.0)},"complex128"); same(np.any(a,{axis={1}}),false) end
do local a=np.array({math.huge,(0/0)},"float16"); same(np.count_nonzero(a,{axis={1}}),2) end
do local a=np.transpose(np.zeros({2,0},"uint64")); same(np.count_nonzero(a),0) end
do local a=np.array({{"xyz"},{"a"}},"S3"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{true},{true}}) end
do local a=np.array({-0.0,0.0,0.0,0.0},"float32"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.array({1,5,1,5},"uint8"); local v=np.all(a,{axis={1},keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.zeros({2,0,3},"int16"); same(np.any(a),false) end
do local a=np.flip(np.array({0.0},"float64"),1); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.array({np.complex(2.0,0.0),np.complex((0/0),3.0)},"complex128"); same(np.all(a),true) end
do local a=np.array({{1,1,5},{0,0,0}},"uint8"); same(np.all(a),false) end
do local a=np.array({0.0,-0.0},"float16"); same(np.count_nonzero(a),0) end
do local a=np.zeros({0,3},"int32"); same(np.count_nonzero(a),0) end
do local a=np.zeros({2,0,3},"complex64"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{true}}}) end
do local a=np.array(-2.0,"float16"); same(np.count_nonzero(a,{axis={}}),1) end
do local a=np.flip(np.zeros({2,0},"S3"),2); local v=np.any(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.array({{-0.0},{(0/0)}},"float16"); same(np.count_nonzero(a,{axis={1,2}}),1) end
do local a=np.transpose(np.array({{{"xyz","XX"},{"XX","XX"},{"XX",""}},{{"a","xyz"},{"","xyz"},{"xyz","XX"}}},"S3")); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{{true,true},{true,false},{true,true}},{{true,true},{true,true},{false,true}}}) end
do local a=np.array({1,1,0,0},"int64"); local v=np.all(a,{axis={1},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.flip(np.array({0,-1},"int64"),1); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{1}) end
do local a=np.zeros({0},"complex64"); same(np.count_nonzero(a,{axis=1}),0) end
do local a=np.flip(np.array({{{np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex(-1.0,0.0),np.complex(0.0,0.0)},{np.complex(2.0,0.0),np.complex(2.0,0.0)}},{{np.complex(2.0,0.0),np.complex(0.0,0.0)},{np.complex(2.0,0.0),np.complex(-1.0,3.0)},{np.complex(-1.0,0.0),np.complex(0.0,0.0)}}},"complex128"),3); local v=np.all(a,{axis={},where=true});assert(v.dtype=="bool")
same(v:tolist(),{{{false,false},{false,true},{true,true}},{{false,true},{true,true},{false,true}}}) end
do local a=np.zeros({0,3},"S3"); local v=np.all(a,{axis=1,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true,true,true}}) end
do local a=np.flip(np.array({{np.complex((0/0),0.0)},{np.complex((0/0),0.0)}},"complex64"),2); same(np.count_nonzero(a),2) end
do local a=np.array({{{0.0,-0.0},{-0.0,-2.0},{(0/0),math.huge}},{{0.0,4.0},{math.huge,(0/0)},{-0.0,0.0}}},"float64"); local v=np.any(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{{true,true},{true,true}}) end
do local a=np.zeros({0,3},"complex128"); same(np.any(a),false) end
do local a=np.flip(np.array({{np.complex(2.0,0.0),np.complex((0/0),0.0)},{np.complex(0.0,3.0),np.complex(0.0,0.0)},{np.complex(0.0,0.0),np.complex(0.0,3.0)}},"complex64"),2); same(np.any(a,{where=false}),false) end
do local a=np.array({np.complex(0.0,3.0),np.complex(-1.0,0.0),np.complex(0.0,0.0),np.complex(-1.0,0.0)},"complex64"); same(np.any(a,{axis={1},where=false}),false) end
do local a=np.flip(np.array({{1,0,-1},{1,-1,1}},"int32"),2); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{1,0,1},{1,1,1}}) end
do local a=np.array({0.0,-0.0},"float16"); same(np.any(a,{axis=1}),false) end
do local a=np.transpose(np.zeros({2,0},"float16")); same(np.any(a,{axis={1,2},where=false}),false) end
do local a=np.flip(np.array({{{0,0,5},{1,5,1}}},"int64"),3); same(np.count_nonzero(a),4) end
do local a=np.flip(np.zeros({2,0,3},"int8"),3); same(np.all(a,{axis={1,2,3}}),true) end
do local a=np.array({{np.complex(0.0,0.0)},{np.complex(0.0,0.0)}},"complex128"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.zeros({0},"float64"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.array({0,0},"uint8"); local v=np.count_nonzero(a,{axis={1},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{0}) end
do local a=np.array(-0.0,"float16"); same(np.count_nonzero(a),0) end
do local a=np.array({{{false,false,false},{false,false,false}}},"bool"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{false}}}) end
do local a=np.flip(np.array({{-2.0,(0/0),-0.0},{0.0,(0/0),4.0}},"float32"),2); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{4}}) end
do local a=np.flip(np.array({0},"int16"),1); same(np.all(a,{axis={1}}),false) end
do local a=np.array({{{np.complex(-1.0,3.0),np.complex(2.0,0.0),np.complex((0/0),0.0)},{np.complex((0/0),0.0),np.complex((0/0),3.0),np.complex((0/0),0.0)}}},"complex128"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{{true,true,true},{true,true,true}}}) end
do local a=np.flip(np.array({{{np.complex(0.0,3.0),np.complex((0/0),0.0)},{np.complex(0.0,0.0),np.complex(2.0,0.0)},{np.complex(0.0,0.0),np.complex(2.0,0.0)}},{{np.complex((0/0),0.0),np.complex(2.0,3.0)},{np.complex(2.0,0.0),np.complex(-1.0,0.0)},{np.complex(0.0,0.0),np.complex(0.0,3.0)}}},"complex128"),3); same(np.count_nonzero(a,{axis={1,2,3}}),9) end
do local a=np.zeros({0,3},"S3"); local v=np.all(a,{axis={},where=true});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.array(np.complex(2.0,3.0),"complex64"); same(np.any(a,{where=np.array(false,"bool")}),false) end
do local a=np.flip(np.array({1},"int32"),1); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array({5},"int8"); same(np.all(a,{axis=1}),true) end
do local a=np.array(0,"int8"); same(np.any(a,{keepdims=true}),false) end
do local a=np.flip(np.array({0.0,(0/0),-0.0,-0.0},"float16"),1); local v=np.any(a,{keepdims=true,where=np.array({false,true,false,true},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.flip(np.array({{{"xyz","a","xyz"},{"","XX","xyz"}}},"S3"),3); same(np.all(a),false) end
do local a=np.array({(0/0),-2.0},"float32"); same(np.count_nonzero(a,{axis=1}),2) end
do local a=np.array({-0.0,0.0,(0/0),-2.0},"float16"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{2}) end
do local a=np.flip(np.zeros({0,3},"complex128"),2); same(np.any(a,{where=np.array({{false,true,true}},"bool")}),false) end
do local a=np.array({"","XX"},"U3"); same(np.all(a),false) end
do local a=np.flip(np.zeros({2,0,3},"float16"),3); same(np.any(a),false) end
do local a=np.array({{{"XX","",""},{"","","a"}}},"U3"); local v=np.count_nonzero(a,{axis=1});assert(v.dtype=="int64")
same(v:tolist(),{{1,0,0},{0,0,1}}) end
do local a=np.transpose(np.zeros({0,3},"int32")); same(np.count_nonzero(a),0) end
do local a=np.array("a","U3"); same(np.all(a),true) end
do local a=np.flip(np.array({{np.complex(-1.0,0.0),np.complex(0.0,0.0),np.complex((0/0),0.0)},{np.complex(0.0,3.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}},"complex128"),2); local v=np.all(a,{keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.array({{0},{0}},"int16"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.array({"XX","a"},"U3"); same(np.any(a),true) end
do local a=np.transpose(np.array({{{1,0},{5,-1},{0,-1}},{{-1,0},{1,5},{0,1}}},"int32")); local v=np.count_nonzero(a,{axis={1,2,3},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{8}}}) end
do local a=np.array({-1,0,0,-1},"int32"); same(np.count_nonzero(a),2) end
do local a=np.flip(np.array({{false,true,true},{true,false,false}},"bool"),2); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{3}}) end
do local a=np.zeros({0},"int32"); local v=np.all(a,{axis={1},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.flip(np.zeros({2,0},"float64"),2); same(np.all(a),true) end
do local a=np.array({np.complex(0.0,0.0)},"complex64"); same(np.any(a),false) end
do local a=np.transpose(np.zeros({0,3},"int16")); local v=np.count_nonzero(a,{axis=1});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.flip(np.array({{1,0,5},{-1,0,0}},"int8"),2); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{1,0,1},{0,0,1}}) end
do local a=np.transpose(np.array({{{1,1,0},{0,1,0}}},"uint8")); same(np.count_nonzero(a,{axis={1,2,3}}),3) end
do local a=np.flip(np.zeros({2,0,3},"int64"),3); local v=np.any(a,{axis=3});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.flip(np.array({{5,-1},{0,0},{0,0}},"int32"),2); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.array({4.0,-0.0,-2.0,math.huge},"float16"); local v=np.count_nonzero(a,{axis={1},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{3}) end
do local a=np.array({{0,0,0},{0,5,5}},"int8"); local v=np.all(a,{axis={},where=np.array({{true,true,true},{false,false,true}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{false,false,false},{true,true,true}}) end
do local a=np.zeros({0},"float32"); same(np.count_nonzero(a),0) end
do local a=np.array(-1,"int64"); same(np.count_nonzero(a),1) end
do local a=np.transpose(np.array({{0,1},{1,-1},{-1,0}},"int16")); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.array({{{true,false,true},{false,true,true}}},"bool"); same(np.count_nonzero(a),4) end
do local a=np.array(0,"uint8"); same(np.count_nonzero(a),0) end
do local a=np.transpose(np.array({{-2.0},{0.0}},"float32")); same(np.count_nonzero(a),1) end
do local a=np.array({{np.complex(2.0,3.0)},{np.complex(2.0,0.0)}},"complex128"); local v=np.all(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array({{0,0,0},{0,0,0}},"int32"); same(np.all(a,{axis={1,2},where=false}),true) end
do local a=np.transpose(np.zeros({0,3},"int32")); same(np.any(a),false) end
do local a=np.transpose(np.array({{-1},{0}},"int8")); local v=np.any(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{true,false}) end
do local a=np.transpose(np.array({{"xyz"},{""}},"S3")); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{true,false}}) end
do local a=np.zeros({0},"U3"); same(np.count_nonzero(a),0) end
do local a=np.flip(np.zeros({0,3},"complex128"),2); same(np.all(a,{axis={1,2},where=true}),true) end
do local a=np.zeros({2,0,3},"float32"); same(np.any(a,{where=np.array({{{true,true,false}}},"bool")}),false) end
do local a=np.flip(np.array({{np.complex(-1.0,3.0),np.complex((0/0),0.0),np.complex(-1.0,0.0)},{np.complex(0.0,3.0),np.complex((0/0),0.0),np.complex(-1.0,3.0)}},"complex64"),2); same(np.count_nonzero(a),6) end
do local a=np.transpose(np.zeros({2,0},"U3")); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.flip(np.array({{"XX"},{"XX"}},"S3"),2); same(np.count_nonzero(a),2) end
do local a=np.zeros({0,3},"int64"); same(np.all(a),true) end
do local a=np.flip(np.array({0,1},"uint64"),1); same(np.count_nonzero(a),1) end
do local a=np.transpose(np.zeros({2,0},"int16")); same(np.count_nonzero(a,{axis={1,2}}),0) end
do local a=np.flip(np.array({{"xyz","a"},{"","xyz"},{"","xyz"}},"U3"),2); same(np.all(a),false) end
do local a=np.flip(np.array({1,5,9007199254740995,1},"uint64"),1); local v=np.any(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true,true,true,true}) end
do local a=np.transpose(np.array({{{1,1,1},{0,0,0}}},"int16")); same(np.count_nonzero(a),3) end
do local a=np.array({{np.complex((0/0),3.0),np.complex(-1.0,0.0)},{np.complex(0.0,3.0),np.complex(-1.0,3.0)},{np.complex(0.0,0.0),np.complex(-1.0,0.0)}},"complex64"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.array(np.complex((0/0),0.0),"complex128"); same(np.all(a,{axis={},where=true}),true) end
do local a=np.array({0},"int32"); local v=np.any(a,{axis={},where=false});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.transpose(np.zeros({2,0,3},"int16")); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{},{},{}}) end
do local a=np.array({-2.0,math.huge,math.huge,0.0},"float32"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{3}) end
do local a=np.array({-2.0,(0/0),-0.0,(0/0)},"float64"); same(np.count_nonzero(a),3) end
do local a=np.zeros({2,0,3},"uint8"); same(np.count_nonzero(a),0) end
do local a=np.array(0,"uint8"); same(np.any(a),false) end
do local a=np.array({np.complex(-1.0,0.0)},"complex128"); same(np.any(a),true) end
do local a=np.flip(np.array({{{true,false},{false,true},{true,true}},{{true,true},{false,false},{false,true}}},"bool"),3); same(np.any(a,{axis={1,2,3}}),true) end
do local a=np.transpose(np.zeros({2,0},"int32")); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.flip(np.array({{false,true,false},{true,false,false}},"bool"),2); local v=np.all(a,{axis=1,where=np.array({{true,true,false},{true,true,false}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{false,false,true}) end
do local a=np.transpose(np.array({{{0,-1,-1},{0,1,-1}}},"int8")); local v=np.any(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{{true},{true}}) end
do local a=np.flip(np.array({{1,-1},{0,0},{1,-1}},"int16"),2); local v=np.count_nonzero(a,{axis=1,keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{2,2}}) end
do local a=np.array({{4.0,-0.0,0.0},{-2.0,4.0,0.0}},"float64"); same(np.count_nonzero(a,{axis={1,2}}),3) end
do local a=np.array({{{5,0,0},{0,0,1}}},"int8"); local v=np.any(a,{axis=3,where=np.array({{{false,false,true}}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{false,true}}) end
do local a=np.zeros({0},"U3"); same(np.all(a),true) end
do local a=np.array({"a","XX","",""},"S3"); local v=np.all(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true,true,false,false}) end
do local a=np.zeros({0},"complex64"); same(np.all(a,{where=np.array({},"bool")}),true) end
do local a=np.array({-0.0},"float16"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.zeros({0,3},"int32"); same(np.any(a,{axis={1,2},where=np.array({{true,true,true}},"bool")}),false) end
do local a=np.array({1,0,0,0},"uint8"); same(np.any(a,{axis=1,where=false}),false) end
do local a=np.array({{0,5,0},{0,0,1}},"uint8"); same(np.all(a,{where=true}),false) end
do local a=np.flip(np.zeros({0,3},"bool"),2); local v=np.any(a,{axis=2,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.flip(np.array({{{-0.0,4.0},{0.0,-0.0},{math.huge,-2.0}},{{4.0,(0/0)},{4.0,-2.0},{4.0,math.huge}}},"float16"),3); same(np.count_nonzero(a,{axis={1,2,3}}),9) end
do local a=np.array({1,0},"uint64"); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{true,false}) end
do local a=np.array({1,0,0,-1},"int16"); same(np.any(a),true) end
do local a=np.zeros({0},"S3"); same(np.count_nonzero(a,{axis=1}),0) end
do local a=np.zeros({2,0},"complex128"); same(np.count_nonzero(a),0) end
do local a=np.flip(np.zeros({0},"S3"),1); same(np.count_nonzero(a),0) end
do local a=np.array({math.huge,-2.0,-2.0,math.huge},"float16"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{4}) end
do local a=np.array({{false,false,false},{true,true,true}},"bool"); local v=np.any(a,{axis=1,where=np.array({{true,true,false},{false,true,true}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{false,true,true}) end
do local a=np.array({"","a","","XX"},"U3"); same(np.any(a),true) end
do local a=np.array({-1},"int32"); local v=np.all(a,{axis={},where=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.flip(np.array({math.huge,(0/0)},"float32"),1); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{1,1}) end
do local a=np.array(np.complex(-1.0,3.0),"complex128"); same(np.count_nonzero(a),1) end
do local a=np.flip(np.array({"","XX"},"S3"),1); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{true,false}) end
do local a=np.array({4.0,(0/0)},"float32"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array(5,"uint8"); same(np.count_nonzero(a,{axis={}}),1) end
do local a=np.array({0},"int8"); local v=np.any(a,{keepdims=true,where=np.array({false},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.transpose(np.array({{-2.0,-2.0},{0.0,-0.0},{(0/0),-0.0}},"float16")); local v=np.all(a,{axis=2,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false},{false}}) end
do local a=np.transpose(np.zeros({2,0,3},"bool")); local v=np.any(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{},{},{}}) end
do local a=np.flip(np.array({{{4.0,4.0},{0.0,-2.0},{0.0,0.0}},{{0.0,-2.0},{-0.0,0.0},{4.0,math.huge}}},"float32"),3); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{6}}}) end
do local a=np.array(5,"int32"); same(np.all(a),true) end
do local a=np.array({{{"","xyz"},{"XX","XX"},{"a",""}},{{"xyz","xyz"},{"xyz","xyz"},{"xyz","XX"}}},"S3"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{false}}}) end
do local a=np.transpose(np.zeros({2,0},"complex128")); same(np.any(a,{where=np.zeros({0,2},"bool")}),false) end
do local a=np.array({{"",""},{"XX","a"},{"xyz","xyz"}},"S3"); local v=np.count_nonzero(a,{axis={1,2},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{4}}) end
do local a=np.array({{{-1,0,0},{-1,0,0}}},"int32"); same(np.count_nonzero(a),2) end
do local a=np.array({{false},{true}},"bool"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{0},{1}}) end
do local a=np.array({math.huge,4.0,-2.0,4.0},"float32"); same(np.count_nonzero(a),4) end
do local a=np.array(true,"bool"); same(np.any(a,{keepdims=true}),true) end
do local a=np.zeros({2,0,3},"bool"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{true}}}) end
do local a=np.flip(np.array({np.complex(2.0,0.0),np.complex(0.0,0.0),np.complex(-1.0,0.0),np.complex(0.0,0.0)},"complex128"),1); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{false,true,false,true}) end
do local a=np.array({{5,1},{0,1},{0,0}},"int8"); same(np.any(a),true) end
do local a=np.zeros({0},"uint64"); same(np.count_nonzero(a,{axis=1}),0) end
do local a=np.array({{0,0,1},{1,0,1}},"int8"); local v=np.all(a,{keepdims=true,where=np.array({{true,true,true},{true,true,true}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.array({"XX","XX"},"U3"); same(np.any(a,{axis={1}}),true) end
do local a=np.array({(0/0)},"float64"); same(np.count_nonzero(a,{axis=1}),1) end
do local a=np.array({"XX",""},"U3"); same(np.all(a,{where=np.array({false,true},"bool")}),false) end
do local a=np.array({{{5,5,5},{0,0,0}}},"int16"); local v=np.all(a,{axis=2,where=np.array({{{true,false,false}}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{false,true,true}}) end
do local a=np.transpose(np.array({{{0,0},{1,0},{0,0}},{{1,0},{0,0},{1,9007199254740995}}},"uint64")); local v=np.any(a,{axis=2,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{true,true}},{{false,true}}}) end
do local a=np.array((0/0),"float64"); same(np.all(a,{keepdims=true}),true) end
do local a=np.array(1,"uint8"); same(np.any(a,{axis={}}),true) end
do local a=np.array({(0/0),-0.0,0.0,-0.0},"float64"); same(np.any(a,{axis={1}}),true) end
do local a=np.zeros({0},"bool"); same(np.all(a,{axis=1}),true) end
do local a=np.array({{(0/0)},{0.0}},"float32"); local v=np.count_nonzero(a,{axis=2});assert(v.dtype=="int64")
same(v:tolist(),{1,0}) end
do local a=np.array({0,-1,-1,-1},"int32"); same(np.all(a),false) end
do local a=np.array({false,true},"bool"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{1}) end
do local a=np.transpose(np.array({{{4.0,(0/0),-0.0},{-0.0,-0.0,-2.0}}},"float64")); same(np.count_nonzero(a,{axis={1,2,3}}),3) end
do local a=np.array({{5,5,0},{0,0,5}},"int32"); local v=np.count_nonzero(a,{axis=1,keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{1,1,1}}) end
do local a=np.transpose(np.array({{{0,5,0},{9007199254740995,0,0}}},"uint64")); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{{false},{true}},{{true},{false}},{{false},{false}}}) end
do local a=np.array({-0.0,0.0,4.0,-2.0},"float64"); local v=np.any(a,{axis={},keepdims=true,where=false});assert(v.dtype=="bool")
same(v:tolist(),{false,false,false,false}) end
do local a=np.transpose(np.zeros({0,3},"S3")); local v=np.all(a,{axis=2,where=false});assert(v.dtype=="bool")
same(v:tolist(),{true,true,true}) end
do local a=np.array({-1,1,0,-1},"int64"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.transpose(np.array({{{-1,-1},{-1,0},{0,0}},{{0,0},{-1,9007199254740995},{0,0}}},"int64")); same(np.count_nonzero(a),5) end
do local a=np.array({-1,0},"int64"); same(np.all(a,{axis={1},where=np.array({true,true},"bool")}),false) end
do local a=np.array(0,"int16"); same(np.any(a,{axis={},where=np.array(true,"bool")}),false) end
do local a=np.zeros({0,3},"float16"); same(np.count_nonzero(a),0) end
do local a=np.array({{{5,0},{-1,0},{-1,0}},{{0,0},{1,1},{1,0}}},"int16"); same(np.all(a),false) end
do local a=np.zeros({0},"float16"); same(np.all(a),true) end
do local a=np.transpose(np.array({{9007199254740995,5,9007199254740995},{0,1,0}},"int64")); same(np.count_nonzero(a,{axis={1,2}}),4) end
do local a=np.array({5,0},"uint64"); same(np.count_nonzero(a,{axis={1}}),1) end
do local a=np.zeros({0},"int32"); same(np.all(a),true) end
do local a=np.array({{{"xyz","a"},{"a","xyz"},{"","XX"}},{{"XX","XX"},{"xyz","a"},{"XX","XX"}}},"U3"); local v=np.all(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{{false,true},{true,true}}) end
do local a=np.zeros({0,3},"float32"); local v=np.all(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{true,true,true}) end
do local a=np.array({{{np.complex((0/0),3.0),np.complex(0.0,0.0),np.complex(0.0,3.0)},{np.complex(0.0,3.0),np.complex(2.0,0.0),np.complex(2.0,0.0)}}},"complex64"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{{1,0,1},{1,1,1}}}) end
do local a=np.transpose(np.zeros({0,3},"int64")); same(np.count_nonzero(a),0) end
do local a=np.transpose(np.array({{{"",""},{"a",""},{"",""}},{{"","XX"},{"XX","XX"},{"xyz","XX"}}},"S3")); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{{false,false},{true,true},{false,true}},{{false,true},{false,true},{false,true}}}) end
do local a=np.flip(np.array({{{"a","xyz","xyz"},{"","a","XX"}}},"S3"),3); local v=np.count_nonzero(a,{axis={1,2,3},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{5}}}) end
do local a=np.zeros({0},"float64"); same(np.count_nonzero(a,{axis=1}),0) end
do local a=np.array({-2.0,math.huge},"float64"); same(np.count_nonzero(a),2) end
do local a=np.transpose(np.array({{4.0,4.0,-0.0},{(0/0),-0.0,-2.0}},"float32")); local v=np.all(a,{axis=2,keepdims=true,where=false});assert(v.dtype=="bool")
same(v:tolist(),{{true},{true},{true}}) end
do local a=np.zeros({2,0},"int32"); local v=np.all(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.array({{0,0,5},{5,5,1}},"int8"); same(np.count_nonzero(a),4) end
do local a=np.transpose(np.array({{0.0},{math.huge}},"float32")); same(np.any(a,{where=np.array({{false,true}},"bool")}),true) end
do local a=np.transpose(np.array({{1,5,1},{1,5,5}},"int16")); local v=np.all(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{true,true,true}) end
do local a=np.flip(np.zeros({0},"bool"),1); local v=np.any(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.array({{np.complex(0.0,0.0)},{np.complex(2.0,0.0)}},"complex64"); same(np.count_nonzero(a),1) end
do local a=np.zeros({0},"complex128"); same(np.count_nonzero(a),0) end
do local a=np.array({0.0,math.huge},"float32"); same(np.all(a,{axis={1}}),false) end
do local a=np.array({0,1,1,5},"int8"); local v=np.count_nonzero(a,{axis=1,keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{3}) end
do local a=np.zeros({0},"float64"); local v=np.all(a,{keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array({0,0},"uint8"); same(np.any(a,{where=true}),false) end
do local a=np.array({{-1},{1}},"int16"); same(np.any(a,{where=np.array({{false},{true}},"bool")}),true) end
do local a=np.array({np.complex(-1.0,0.0),np.complex(0.0,3.0),np.complex(-1.0,0.0),np.complex(2.0,3.0)},"complex64"); same(np.count_nonzero(a),4) end
do local a=np.array(-1,"int32"); same(np.count_nonzero(a),1) end
do local a=np.transpose(np.array({{0},{0}},"int32")); local v=np.any(a,{axis={},keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{{false,false}}) end
do local a=np.flip(np.array({{0},{0}},"int16"),2); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0}}) end
do local a=np.zeros({0,3},"uint8"); same(np.count_nonzero(a,{axis={1,2}}),0) end
do local a=np.flip(np.zeros({2,0},"S3"),2); same(np.all(a),true) end
do local a=np.flip(np.array({{{0,1},{1,1},{0,5}},{{1,0},{1,-1},{0,0}}},"int16"),3); same(np.any(a,{where=false}),false) end
do local a=np.flip(np.array({{{true,true,false},{true,false,false}}},"bool"),3); same(np.all(a),false) end
do local a=np.zeros({0},"float32"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.flip(np.array({-1,-1,0,0},"int32"),1); local v=np.count_nonzero(a,{axis=1,keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{2}) end
do local a=np.array({1,1,0,5},"uint8"); local v=np.any(a,{axis={1},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array({{np.complex(-1.0,0.0)},{np.complex(-1.0,0.0)}},"complex64"); same(np.all(a,{axis={1,2},where=true}),true) end
do local a=np.zeros({0},"complex128"); same(np.any(a),false) end
do local a=np.array({0.0,4.0},"float64"); same(np.count_nonzero(a),1) end
do local a=np.flip(np.array({{{5,1},{0,9007199254740995},{5,0}},{{0,0},{0,1},{0,9007199254740995}}},"uint64"),3); local v=np.all(a,{axis={},where=np.array({{{true,false},{true,true},{false,true}},{{false,true},{true,true},{true,false}}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{{true,true},{true,false},{true,true}},{{true,false},{true,false},{true,true}}}) end
do local a=np.zeros({2,0,3},"float32"); same(np.all(a),true) end
do local a=np.zeros({0,3},"uint64"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0}}) end
do local a=np.array(0,"int32"); same(np.all(a),false) end
do local a=np.flip(np.zeros({2,0},"float64"),2); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{},{}}) end
do local a=np.zeros({0,3},"float32"); same(np.count_nonzero(a),0) end
do local a=np.array({{{5,5,1},{0,0,-1}}},"int8"); same(np.count_nonzero(a),4) end
do local a=np.array({1,0},"uint8"); same(np.any(a),true) end
do local a=np.transpose(np.zeros({2,0},"float32")); same(np.count_nonzero(a,{axis={1,2}}),0) end
do local a=np.array({{5,1,1},{1,0,0}},"uint8"); local v=np.any(a,{axis=1,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true,true,true}}) end
do local a=np.flip(np.array({{0},{0}},"int16"),2); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0},{0}}) end
do local a=np.zeros({0},"uint64"); same(np.count_nonzero(a),0) end
do local a=np.flip(np.array({0},"int32"),1); same(np.any(a),false) end
do local a=np.array({{0.0,-2.0,-2.0},{4.0,-0.0,-2.0}},"float32"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{4}}) end
do local a=np.zeros({0},"complex64"); same(np.count_nonzero(a),0) end
do local a=np.array({0,9007199254740995,9007199254740995,5},"uint64"); local v=np.any(a,{axis=1,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array({{np.complex(0.0,0.0),np.complex(-1.0,3.0),np.complex(-1.0,0.0)},{np.complex((0/0),3.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}},"complex64"); same(np.count_nonzero(a),3) end
do local a=np.transpose(np.array({{1,1},{5,0},{0,0}},"uint64")); same(np.any(a,{where=false}),false) end
do local a=np.transpose(np.array({{{0,0,1},{5,5,1}}},"uint8")); same(np.any(a,{axis={1,2,3}}),true) end
do local a=np.zeros({0},"int8"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.array({-0.0,4.0},"float16"); same(np.count_nonzero(a),1) end
do local a=np.array("XX","U3"); same(np.any(a),true) end
do local a=np.array({{5},{0}},"int16"); same(np.all(a,{axis={1,2}}),false) end
do local a=np.transpose(np.zeros({2,0},"float32")); local v=np.all(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{true,true}) end
do local a=np.array({{{0.0,(0/0),math.huge},{-2.0,-2.0,-2.0}}},"float16"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{5}}}) end
do local a=np.array({{{4.0,-0.0,math.huge},{0.0,0.0,(0/0)}}},"float64"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{{1,0,1},{0,0,1}}}) end
do local a=np.zeros({2,0},"int32"); local v=np.any(a,{axis={},where=false});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.array("","S3"); same(np.any(a),false) end
do local a=np.array({0.0},"float64"); local v=np.any(a,{axis=1,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.array({{0.0},{(0/0)}},"float16"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{false},{true}}) end
do local a=np.array({math.huge,math.huge,(0/0),(0/0)},"float64"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{true,true,true,true}) end
do local a=np.zeros({0},"float32"); same(np.count_nonzero(a),0) end
do local a=np.array(0,"uint64"); same(np.any(a,{keepdims=true,where=np.array(true,"bool")}),false) end
do local a=np.flip(np.zeros({0},"int8"),1); same(np.all(a,{axis=1,where=false}),true) end
do local a=np.flip(np.array({{{-1,-1,0},{1,0,0}}},"int32"),3); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{false}}}) end
do local a=np.zeros({2,0,3},"uint64"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{0}}}) end
do local a=np.array({{(0/0),(0/0)},{-0.0,4.0},{-0.0,(0/0)}},"float16"); same(np.all(a),false) end
do local a=np.transpose(np.zeros({2,0},"U3")); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0}}) end
do local a=np.zeros({2,0,3},"S3"); local v=np.all(a,{keepdims=true,where=np.array({{{true,true,false}}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{{true}}}) end
do local a=np.array({{1,0},{1,0},{1,0}},"uint64"); same(np.count_nonzero(a),3) end
do local a=np.flip(np.array({np.complex(-1.0,0.0),np.complex((0/0),3.0),np.complex(-1.0,0.0),np.complex(0.0,0.0)},"complex128"),1); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{false,true,true,true}) end
do local a=np.array({{0.0,4.0,0.0},{0.0,4.0,(0/0)}},"float32"); local v=np.count_nonzero(a,{axis=2});assert(v.dtype=="int64")
same(v:tolist(),{1,2}) end
do local a=np.zeros({0},"int16"); local v=np.all(a,{keepdims=true,where=np.zeros({0},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array({{5},{0}},"uint8"); local v=np.all(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{true,false}) end
do local a=np.array({-2.0,(0/0),math.huge,-0.0},"float16"); same(np.any(a),true) end
do local a=np.flip(np.zeros({0},"uint64"),1); same(np.any(a),false) end
do local a=np.array({(0/0),0.0,(0/0),-0.0},"float16"); same(np.count_nonzero(a,{axis=1}),2) end
do local a=np.flip(np.array({{{"XX","xyz",""},{"xyz","a","a"}}},"S3"),3); same(np.count_nonzero(a,{axis={1,2,3}}),5) end
do local a=np.array({np.complex((0/0),0.0),np.complex(0.0,0.0)},"complex128"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array("a","U3"); same(np.all(a,{keepdims=true}),true) end
do local a=np.array({{{(0/0),0.0},{(0/0),-0.0},{(0/0),0.0}},{{-2.0,4.0},{0.0,4.0},{math.huge,0.0}}},"float16"); same(np.any(a,{axis={1,2,3}}),true) end
do local a=np.zeros({0},"bool"); same(np.count_nonzero(a),0) end
do local a=np.array({-0.0,-0.0},"float16"); same(np.count_nonzero(a,{axis={1}}),0) end
do local a=np.array({{0,0,1},{1,0,1}},"uint64"); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{false,false,true},{true,false,true}}) end
do local a=np.transpose(np.zeros({2,0,3},"int16")); same(np.all(a),true) end
do local a=np.array({np.complex(0.0,0.0),np.complex(0.0,0.0)},"complex128"); same(np.count_nonzero(a),0) end
do local a=np.flip(np.zeros({0},"bool"),1); same(np.any(a),false) end
do local a=np.array(0,"int64"); same(np.all(a,{keepdims=true,where=false}),true) end
do local a=np.flip(np.array({0,-1},"int8"),1); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.transpose(np.array({{"xyz","XX"},{"a","xyz"},{"XX","a"}},"S3")); local v=np.any(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{true,true,true}) end
do local a=np.array({{np.complex(-1.0,0.0)},{np.complex(0.0,0.0)}},"complex64"); local v=np.any(a,{axis=1,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.flip(np.array({-0.0,0.0,-2.0,-2.0},"float64"),1); same(np.all(a,{axis={1}}),false) end
do local a=np.transpose(np.array({{{"a","xyz"},{"","a"},{"","XX"}},{{"","XX"},{"a","a"},{"xyz",""}}},"S3")); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{{1,0},{0,1},{0,1}},{{1,1},{1,1},{1,0}}}) end
do local a=np.array({"xyz"},"S3"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array({0.0,-2.0},"float64"); local v=np.any(a,{axis=1,keepdims=true,where=np.array({true,true},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.flip(np.array({np.complex((0/0),0.0),np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(-1.0,0.0)},"complex64"),1); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.array({0},"int64"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{0}) end
do local a=np.array({{{0.0,(0/0),(0/0)},{0.0,-0.0,0.0}}},"float16"); same(np.any(a,{where=np.array({{{false,true,false}}},"bool")}),true) end
do local a=np.array("","U3"); same(np.count_nonzero(a,{axis={}}),0) end
do local a=np.flip(np.array({{0,0,0},{0,5,0}},"uint8"),2); local v=np.any(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{false,true}) end
do local a=np.zeros({0},"uint8"); local v=np.any(a,{axis={1},keepdims=true,where=np.zeros({0},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.zeros({0},"uint64"); local v=np.all(a,{axis={},where=true});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.transpose(np.zeros({0,3},"complex128")); same(np.all(a,{axis={1,2}}),true) end
do local a=np.array({{1,0},{1,0},{1,0}},"uint8"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{3}}) end
do local a=np.zeros({2,0,3},"complex64"); local v=np.all(a,{axis={1,2,3},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{true}}}) end
do local a=np.zeros({0},"int64"); same(np.all(a,{where=np.zeros({0},"bool")}),true) end
do local a=np.flip(np.zeros({0,3},"uint64"),2); same(np.count_nonzero(a),0) end
do local a=np.array({0,-1},"int8"); same(np.count_nonzero(a,{axis=1}),1) end
do local a=np.array({-1,0,0,0},"int8"); same(np.any(a),true) end
do local a=np.flip(np.array({5},"uint8"),1); same(np.count_nonzero(a),1) end
do local a=np.transpose(np.array({{{5,1,0},{0,5,1}}},"uint8")); local v=np.any(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{true},{false}},{{true},{true}},{{false},{true}}}) end
do local a=np.transpose(np.array({{{4.0,0.0,4.0},{0.0,0.0,0.0}}},"float16")); same(np.all(a),false) end
do local a=np.array(4.0,"float32"); same(np.count_nonzero(a,{axis={}}),1) end
do local a=np.flip(np.array({{false,false,false},{true,false,false}},"bool"),2); same(np.count_nonzero(a),1) end
do local a=np.transpose(np.array({{9007199254740995,9007199254740995},{-1,0},{1,1}},"int64")); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{1,1,1},{1,0,1}}) end
do local a=np.array({{{true,false,false},{true,false,false}}},"bool"); same(np.all(a),false) end
do local a=np.array(5,"uint8"); same(np.any(a,{axis={}}),true) end
do local a=np.zeros({0},"bool"); same(np.count_nonzero(a,{axis=1}),0) end
do local a=np.flip(np.array({{{0,9007199254740995},{9007199254740995,1},{1,1}},{{1,9007199254740995},{1,9007199254740995},{1,0}}},"uint64"),3); same(np.all(a,{axis={1,2,3},where=true}),false) end
do local a=np.array({math.huge,-2.0,-2.0,-2.0},"float64"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{1,1,1,1}) end
do local a=np.zeros({0},"int16"); same(np.count_nonzero(a),0) end
do local a=np.array({-1,-1,0,9007199254740995},"int64"); same(np.any(a,{axis={1},where=np.array({true,false,false,true},"bool")}),true) end
do local a=np.flip(np.zeros({2,0},"S3"),2); local v=np.all(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.array("XX","S3"); same(np.count_nonzero(a,{axis={}}),1) end
do local a=np.zeros({0},"uint64"); same(np.any(a,{axis={1},where=np.zeros({0},"bool")}),false) end
do local a=np.transpose(np.array({{-1},{-1}},"int8")); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{true,true}}) end
do local a=np.array(5,"uint8"); same(np.all(a),true) end
do local a=np.array(-1,"int8"); same(np.all(a,{axis={},where=np.array(true,"bool")}),true) end
do local a=np.array({{{"xyz","xyz","XX"},{"XX","xyz","a"}}},"U3"); local v=np.count_nonzero(a,{axis=1});assert(v.dtype=="int64")
same(v:tolist(),{{1,1,1},{1,1,1}}) end
do local a=np.flip(np.zeros({2,0,3},"complex64"),3); same(np.all(a,{axis={1,2,3},where=np.zeros({2,0,3},"bool")}),true) end
do local a=np.zeros({2,0,3},"int32"); local v=np.any(a,{keepdims=true,where=np.array({{{false,true,false}}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{{false}}}) end
do local a=np.array({np.complex(0.0,0.0)},"complex64"); same(np.count_nonzero(a,{axis=1}),0) end
do local a=np.flip(np.array({{"a","XX",""},{"a","xyz","XX"}},"S3"),2); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{false,true,true},{true,true,true}}) end
do local a=np.transpose(np.zeros({2,0,3},"float32")); local v=np.all(a,{keepdims=true,where=np.array({{{false,false}}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{{true}}}) end
do local a=np.flip(np.array({np.complex(0.0,3.0),np.complex((0/0),0.0),np.complex((0/0),3.0),np.complex(-1.0,0.0)},"complex128"),1); same(np.all(a,{axis={1}}),true) end
do local a=np.array({{5},{0}},"uint64"); local v=np.all(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.flip(np.array({{(0/0),0.0,0.0},{4.0,-0.0,0.0}},"float16"),2); same(np.all(a),false) end
do local a=np.zeros({0},"complex64"); local v=np.all(a,{keepdims=true,where=false});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array({{"xyz"},{""}},"S3"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{true},{false}}) end
do local a=np.zeros({2,0},"U3"); local v=np.count_nonzero(a,{axis=1,keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{}}) end
do local a=np.flip(np.zeros({2,0},"S3"),2); same(np.all(a,{axis={1,2}}),true) end
do local a=np.zeros({0,3},"uint64"); same(np.any(a),false) end
do local a=np.array({{-0.0,-0.0,math.huge},{(0/0),(0/0),4.0}},"float16"); same(np.all(a),false) end
do local a=np.array({math.huge,-0.0},"float32"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{1,0}) end
do local a=np.array({{1,1,-1},{5,0,0}},"int32"); same(np.count_nonzero(a),4) end
do local a=np.transpose(np.zeros({2,0,3},"U3")); same(np.all(a,{axis={1,2,3},where=true}),true) end
do local a=np.zeros({2,0},"float16"); same(np.count_nonzero(a),0) end
do local a=np.flip(np.zeros({0,3},"int8"),2); same(np.count_nonzero(a),0) end
do local a=np.flip(np.array({1},"int16"),1); same(np.any(a,{axis={1}}),true) end
do local a=np.array("xyz","S3"); same(np.all(a,{axis={},where=false}),true) end
do local a=np.transpose(np.zeros({2,0},"float64")); same(np.any(a,{where=true}),false) end
do local a=np.flip(np.array({"XX"},"U3"),1); same(np.count_nonzero(a),1) end
do local a=np.transpose(np.array({{0},{-1}},"int32")); same(np.all(a,{axis={1,2}}),false) end
do local a=np.array({{{np.complex(0.0,3.0),np.complex((0/0),3.0),np.complex(0.0,0.0)},{np.complex(-1.0,0.0),np.complex((0/0),0.0),np.complex(2.0,3.0)}}},"complex128"); same(np.any(a,{axis={1,2,3}}),true) end
do local a=np.flip(np.zeros({2,0},"bool"),2); local v=np.all(a,{axis=1,where=true});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.flip(np.array({{{0.0,-0.0,0.0},{0.0,-2.0,math.huge}}},"float64"),3); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{false}}}) end
do local a=np.array({-2.0},"float16"); same(np.count_nonzero(a,{axis={1}}),1) end
do local a=np.array({"xyz","xyz","xyz","a"},"S3"); same(np.all(a),true) end
do local a=np.transpose(np.array({{{np.complex(0.0,0.0),np.complex(-1.0,0.0)},{np.complex(0.0,0.0),np.complex((0/0),0.0)},{np.complex(0.0,3.0),np.complex(-1.0,0.0)}},{{np.complex(0.0,3.0),np.complex((0/0),0.0)},{np.complex(0.0,3.0),np.complex(-1.0,3.0)},{np.complex(2.0,3.0),np.complex(0.0,0.0)}}},"complex64")); same(np.count_nonzero(a),9) end
do local a=np.array({true,true},"bool"); same(np.any(a,{axis=1,where=np.array({true,true},"bool")}),true) end
do local a=np.array({np.complex(2.0,3.0)},"complex64"); same(np.count_nonzero(a,{axis=1}),1) end
do local a=np.array({{{4.0,-2.0,(0/0)},{4.0,0.0,math.huge}}},"float16"); same(np.any(a),true) end
do local a=np.flip(np.array({0,0,1,0},"uint64"),1); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{false,true,false,false}) end
do local a=np.array({{{1,0,0},{0,0,1}}},"int32"); same(np.all(a,{where=false}),true) end
do local a=np.array({0},"int16"); local v=np.count_nonzero(a,{axis={1},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{0}) end
do local a=np.flip(np.array({{9007199254740995,1},{0,1},{0,0}},"uint64"),2); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.array({{{np.complex(0.0,3.0),np.complex(-1.0,3.0),np.complex(0.0,0.0)},{np.complex((0/0),0.0),np.complex((0/0),3.0),np.complex(0.0,0.0)}}},"complex128"); same(np.all(a),false) end
do local a=np.array({true,false,true,true},"bool"); same(np.all(a,{axis=1,where=np.array({true,true,true,false},"bool")}),false) end
do local a=np.zeros({2,0},"int64"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.array(0.0,"float16"); same(np.all(a,{axis={}}),false) end
do local a=np.zeros({0},"int32"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.array({{{5,1,5},{0,1,1}}},"uint8"); local v=np.count_nonzero(a,{axis={1,2,3},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{5}}}) end
do local a=np.transpose(np.array({{np.complex(2.0,3.0),np.complex(-1.0,3.0),np.complex(-1.0,0.0)},{np.complex(0.0,0.0),np.complex(-1.0,0.0),np.complex((0/0),0.0)}},"complex128")); same(np.count_nonzero(a),5) end
do local a=np.transpose(np.array({{0,0},{5,-1},{0,-1}},"int8")); local v=np.count_nonzero(a,{axis=2,keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{1},{2}}) end
do local a=np.flip(np.array({{(0/0),0.0,0.0},{4.0,0.0,math.huge}},"float16"),2); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.array({"","xyz","a","a"},"U3"); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{false,true,true,true}) end
do local a=np.flip(np.array({{-1,5,0},{5,0,-1}},"int8"),2); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.array({-0.0},"float16"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{0}) end
do local a=np.flip(np.zeros({2,0,3},"float16"),3); same(np.count_nonzero(a),0) end
do local a=np.transpose(np.zeros({2,0},"bool")); local v=np.any(a,{keepdims=true,where=false});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.array({{{1,0,0},{0,1,0}}},"uint8"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{2}}}) end
do local a=np.array({{{0,5},{0,5},{0,0}},{{0,-1},{0,0},{0,0}}},"int16"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{false}}}) end
do local a=np.zeros({2,0,3},"complex128"); same(np.count_nonzero(a),0) end
do local a=np.flip(np.array({0.0,-0.0},"float32"),1); same(np.count_nonzero(a),0) end
do local a=np.flip(np.zeros({0,3},"int64"),2); local v=np.any(a,{axis=2,keepdims=true,where=false});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.flip(np.zeros({0,3},"float16"),2); same(np.all(a,{axis={1,2}}),true) end
do local a=np.flip(np.array({{4.0,-0.0},{(0/0),-0.0},{0.0,-0.0}},"float32"),2); same(np.all(a,{axis={1,2}}),false) end
do local a=np.zeros({2,0},"U3"); same(np.any(a),false) end
do local a=np.zeros({0},"float16"); local v=np.count_nonzero(a,{axis={1},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{0}) end
do local a=np.array(1,"uint64"); same(np.all(a,{axis={},where=np.array(true,"bool")}),true) end
do local a=np.array({1},"int8"); same(np.all(a,{axis=1}),true) end
do local a=np.array({{{4.0,(0/0)},{0.0,-0.0},{4.0,-2.0}},{{-2.0,-0.0},{0.0,4.0},{0.0,(0/0)}}},"float32"); local v=np.any(a,{keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{{{true}}}) end
do local a=np.array({{{"XX","XX","a"},{"xyz","xyz","a"}}},"U3"); local v=np.count_nonzero(a,{axis=1});assert(v.dtype=="int64")
same(v:tolist(),{{1,1,1},{1,1,1}}) end
do local a=np.flip(np.array({-0.0,-2.0},"float32"),1); same(np.count_nonzero(a,{axis=1}),1) end
do local a=np.array({{{1,1},{5,0},{-1,0}},{{0,0},{0,0},{0,0}}},"int32"); local v=np.any(a,{axis={1,2,3},keepdims=true,where=np.array({{{false,true}}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{{true}}}) end
do local a=np.transpose(np.array({{1,5,5},{9007199254740995,0,-1}},"int64")); same(np.any(a,{axis={1,2},where=false}),false) end
do local a=np.zeros({2,0,3},"bool"); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.array({{{0,1},{0,0},{5,5}},{{0,0},{0,1},{0,0}}},"int16"); local v=np.all(a,{axis={},where=false});assert(v.dtype=="bool")
same(v:tolist(),{{{true,true},{true,true},{true,true}},{{true,true},{true,true},{true,true}}}) end
do local a=np.array({{np.complex(0.0,0.0),np.complex((0/0),3.0)},{np.complex((0/0),0.0),np.complex(2.0,3.0)},{np.complex(-1.0,0.0),np.complex((0/0),0.0)}},"complex64"); same(np.all(a),false) end
do local a=np.array(1,"int8"); same(np.all(a,{axis={},keepdims=true,where=false}),true) end
do local a=np.array(5,"int8"); same(np.all(a,{keepdims=true}),true) end
do local a=np.flip(np.array({{-1,0,5},{5,0,1}},"int16"),2); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{4}}) end
do local a=np.array({{np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex(-1.0,0.0),np.complex((0/0),0.0)},{np.complex(2.0,0.0),np.complex(0.0,0.0)}},"complex64"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{3}}) end
do local a=np.transpose(np.zeros({2,0,3},"int16")); same(np.count_nonzero(a),0) end
do local a=np.array(0,"int32"); same(np.count_nonzero(a),0) end
do local a=np.array(-1,"int8"); same(np.all(a),true) end
do local a=np.array({(0/0)},"float16"); same(np.any(a,{axis={1}}),true) end
do local a=np.transpose(np.array({{0,1,0},{1,1,0}},"uint8")); local v=np.any(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false,true},{true,true},{false,false}}) end
do local a=np.flip(np.zeros({0,3},"float32"),2); local v=np.all(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.zeros({0},"int16"); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.array(0,"int16"); same(np.any(a,{keepdims=true}),false) end
do local a=np.zeros({2,0},"bool"); local v=np.any(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.zeros({2,0,3},"complex64"); local v=np.any(a,{axis=3});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.transpose(np.array({{5},{1}},"uint64")); local v=np.all(a,{axis=2,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.array(-2.0,"float32"); same(np.any(a,{axis={},where=true}),true) end
do local a=np.flip(np.array({math.huge,0.0},"float64"),1); same(np.any(a,{where=true}),true) end
do local a=np.zeros({0,3},"complex64"); local v=np.all(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{true,true,true}) end
do local a=np.array({{{9007199254740995,-1},{0,9007199254740995},{-1,0}},{{5,0},{0,0},{5,0}}},"int64"); same(np.count_nonzero(a),6) end
do local a=np.zeros({0,3},"int32"); same(np.count_nonzero(a),0) end
do local a=np.array({0},"int16"); same(np.any(a),false) end
do local a=np.array({{{1,0},{0,0},{9007199254740995,0}},{{0,0},{1,5},{0,0}}},"uint64"); same(np.any(a),true) end
do local a=np.array({"a","XX","","XX"},"S3"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{3}) end
do local a=np.flip(np.array({{{0,0,1},{5,5,1}}},"int64"),3); local v=np.all(a,{axis={1,2,3},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{false}}}) end
do local a=np.zeros({2,0},"int8"); local v=np.count_nonzero(a,{axis=1});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.array({0,-1,5,-1},"int32"); same(np.all(a),false) end
do local a=np.flip(np.zeros({0,3},"int32"),2); same(np.all(a,{where=np.array({{true,true,true}},"bool")}),true) end
do local a=np.array({{{"a","xyz",""},{"","XX","xyz"}}},"U3"); same(np.any(a),true) end
do local a=np.zeros({0,3},"bool"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0}}) end
do local a=np.transpose(np.zeros({2,0},"int32")); same(np.all(a,{axis={1,2}}),true) end
do local a=np.flip(np.array({{{"a","xyz"},{"","XX"},{"xyz","xyz"}},{{"a","XX"},{"xyz","a"},{"a","xyz"}}},"S3"),3); same(np.any(a),true) end
do local a=np.flip(np.array({{{0,-1},{1,0},{1,5}},{{0,1},{0,-1},{1,-1}}},"int16"),3); same(np.any(a),true) end
do local a=np.array({np.complex(-1.0,0.0)},"complex64"); same(np.all(a,{axis={1}}),true) end
do local a=np.array({{0.0,-0.0,math.huge},{0.0,-2.0,(0/0)}},"float64"); local v=np.all(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{false,false,true}) end
do local a=np.zeros({0,3},"uint8"); same(np.count_nonzero(a),0) end
do local a=np.transpose(np.array({{5,5},{1,1},{5,0}},"int8")); same(np.all(a,{axis={1,2}}),false) end
do local a=np.array({{np.complex(2.0,0.0),np.complex(0.0,0.0)},{np.complex(0.0,0.0),np.complex(2.0,0.0)},{np.complex((0/0),0.0),np.complex(0.0,0.0)}},"complex64"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.array({{{"a","xyz","xyz"},{"xyz","xyz",""}}},"S3"); same(np.all(a,{where=false}),true) end
do local a=np.zeros({0},"int64"); same(np.count_nonzero(a),0) end
do local a=np.flip(np.array({{{0.0,(0/0)},{0.0,4.0},{0.0,math.huge}},{{-2.0,0.0},{(0/0),0.0},{0.0,4.0}}},"float16"),3); local v=np.any(a,{axis=1,where=np.array({{{false,true},{true,false},{false,true}},{{true,true},{false,false},{false,true}}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{false,true},{true,false},{false,false}}) end
do local a=np.array({{-0.0,4.0,math.huge},{-2.0,(0/0),(0/0)}},"float32"); local v=np.all(a,{axis={},where=np.array({{true,false,false},{false,false,false}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{false,true,true},{true,true,true}}) end
do local a=np.flip(np.array({-0.0},"float32"),1); local v=np.any(a,{axis=1,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.zeros({0,3},"int32"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0}}) end
do local a=np.array(np.complex(-1.0,0.0),"complex64"); same(np.count_nonzero(a),1) end
do local a=np.array({1,1},"uint8"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{1,1}) end
do local a=np.flip(np.array({0},"int8"),1); same(np.all(a,{axis={1}}),false) end
do local a=np.array({np.complex(2.0,0.0)},"complex64"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array({{"XX"},{""}},"S3"); same(np.all(a,{where=np.array({{true},{false}},"bool")}),true) end
do local a=np.array({{5},{0}},"int32"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{1},{0}}) end
do local a=np.transpose(np.array({{{np.complex(2.0,0.0),np.complex(-1.0,0.0)},{np.complex(2.0,0.0),np.complex(0.0,0.0)},{np.complex(2.0,0.0),np.complex((0/0),3.0)}},{{np.complex(-1.0,0.0),np.complex(-1.0,0.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex(0.0,0.0),np.complex((0/0),0.0)}}},"complex64")); same(np.count_nonzero(a),8) end
do local a=np.zeros({0},"int16"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.flip(np.array({{{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex(0.0,3.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}}},"complex128"),3); local v=np.any(a,{axis=1,keepdims=true,where=false});assert(v.dtype=="bool")
same(v:tolist(),{{{false,false,false},{false,false,false}}}) end
do local a=np.flip(np.array({{"a","","a"},{"a","XX","a"}},"S3"),2); same(np.any(a,{where=np.array({{true,true,false}},"bool")}),true) end
do local a=np.flip(np.array({{0,1,9007199254740995},{0,0,5}},"int64"),2); same(np.any(a,{where=true}),true) end
do local a=np.array(math.huge,"float64"); same(np.all(a,{where=np.array(false,"bool")}),true) end
do local a=np.array({0,0},"int16"); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{false,false}) end
do local a=np.zeros({0,3},"uint8"); same(np.any(a,{where=np.zeros({0,3},"bool")}),false) end
do local a=np.flip(np.array({"a","XX","","a"},"S3"),1); same(np.count_nonzero(a),3) end
do local a=np.flip(np.zeros({2,0},"bool"),2); local v=np.all(a,{axis=1,where=false});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.transpose(np.zeros({0,3},"float32")); local v=np.any(a,{axis={1,2},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.array(true,"bool"); same(np.any(a,{where=np.array(true,"bool")}),true) end
do local a=np.transpose(np.array({{0.0,0.0,(0/0)},{0.0,-2.0,4.0}},"float32")); same(np.all(a),false) end
do local a=np.array({{"a","XX"},{"","a"},{"a","a"}},"U3"); same(np.any(a,{axis={1,2},where=np.array({{true,true},{true,true},{true,false}},"bool")}),true) end
do local a=np.array({{{"XX","a"},{"xyz",""},{"xyz",""}},{{"a","XX"},{"","xyz"},{"xyz",""}}},"U3"); same(np.count_nonzero(a),8) end
do local a=np.array({{{9007199254740995,9007199254740995},{1,0},{9007199254740995,9007199254740995}},{{1,1},{0,9007199254740995},{0,1}}},"uint64"); local v=np.all(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{{true,false},{false,true}}) end
do local a=np.flip(np.array({-1},"int8"),1); same(np.all(a),true) end
do local a=np.array({{0,-1},{0,-1},{1,0}},"int16"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.zeros({2,0},"complex64"); local v=np.all(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.array(-1,"int64"); same(np.count_nonzero(a,{axis={},keepdims=true}),1) end
do local a=np.zeros({0,3},"S3"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0}}) end
do local a=np.array({1,5,1,0},"uint64"); same(np.any(a,{axis={1},where=false}),false) end
do local a=np.transpose(np.array({{1,-1},{-1,1},{0,0}},"int16")); same(np.all(a),false) end
do local a=np.array({np.complex(-1.0,0.0),np.complex(-1.0,3.0),np.complex(2.0,0.0),np.complex(0.0,3.0)},"complex128"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.flip(np.array({5,1,1,1},"uint8"),1); same(np.any(a,{axis={1},where=false}),false) end
do local a=np.array({{(0/0),0.0,math.huge},{0.0,0.0,-0.0}},"float16"); same(np.any(a,{axis={1,2}}),true) end
do local a=np.flip(np.zeros({2,0},"int8"),2); same(np.any(a,{where=false}),false) end
do local a=np.zeros({2,0},"bool"); same(np.any(a),false) end
do local a=np.array({false},"bool"); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.transpose(np.array({{-1,0},{0,0},{5,-1}},"int8")); local v=np.any(a,{axis={},where=np.array({{true,true,false},{false,true,false}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{true,false,false},{false,false,false}}) end
do local a=np.zeros({0,3},"U3"); local v=np.any(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{false,false,false}) end
do local a=np.array(5,"int8"); same(np.count_nonzero(a),1) end
do local a=np.array({{"XX"},{"a"}},"U3"); same(np.any(a),true) end
do local a=np.zeros({0},"bool"); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.transpose(np.array({{{5,0},{1,9007199254740995},{0,1}},{{5,-1},{9007199254740995,1},{0,0}}},"int64")); same(np.count_nonzero(a),8) end
do local a=np.flip(np.array({0,0},"uint8"),1); same(np.all(a,{where=np.array({true,false},"bool")}),false) end
do local a=np.array({np.complex(0.0,3.0),np.complex(2.0,0.0)},"complex128"); local v=np.all(a,{axis={},keepdims=true,where=np.array({true,true},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{true,true}) end
do local a=np.array(1,"uint8"); same(np.any(a,{axis={},where=true}),true) end
do local a=np.flip(np.zeros({0,3},"S3"),2); local v=np.any(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.flip(np.array({(0/0),0.0},"float64"),1); same(np.any(a,{axis={1},where=np.array({false,true},"bool")}),true) end
do local a=np.zeros({0,3},"bool"); local v=np.any(a,{axis={},keepdims=true,where=np.array({{true,false,true}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.array({true,false,false,true},"bool"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{2}) end
do local a=np.zeros({0,3},"float64"); local v=np.any(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.flip(np.array({5,1,5,5},"uint64"),1); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{4}) end
do local a=np.flip(np.array({np.complex(0.0,3.0)},"complex64"),1); same(np.all(a,{axis={1}}),true) end
do local a=np.array({{np.complex((0/0),0.0)},{np.complex(0.0,3.0)}},"complex64"); same(np.all(a,{axis={1,2},where=true}),true) end
do local a=np.array({{0.0,0.0,math.huge},{0.0,4.0,0.0}},"float32"); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{false,false,true},{false,true,false}}) end
do local a=np.flip(np.array({0,5},"uint8"),1); same(np.count_nonzero(a),1) end
do local a=np.flip(np.array({{{false,false,false},{true,false,false}}},"bool"),3); local v=np.count_nonzero(a,{axis=1});assert(v.dtype=="int64")
same(v:tolist(),{{0,0,0},{0,0,1}}) end
do local a=np.array({"XX","XX"},"U3"); same(np.all(a,{axis=1,where=np.array({true,false},"bool")}),true) end
do local a=np.array({{0,5,1},{0,0,1}},"int8"); local v=np.any(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{true,true}) end
do local a=np.flip(np.zeros({0,3},"int32"),2); same(np.any(a,{where=true}),false) end
do local a=np.flip(np.array({0,0,0,0},"int32"),1); same(np.all(a),false) end
do local a=np.array({{{1,0,5},{0,1,5}}},"uint8"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{false}}}) end
do local a=np.flip(np.array({{np.complex(0.0,0.0)},{np.complex(2.0,0.0)}},"complex128"),2); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.transpose(np.zeros({2,0,3},"U3")); same(np.any(a,{where=np.zeros({3,0,2},"bool")}),false) end
do local a=np.array(1,"int32"); same(np.count_nonzero(a),1) end
do local a=np.transpose(np.zeros({2,0},"float64")); local v=np.all(a,{keepdims=true,where=np.array({{false,true}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.array({{false,false,true},{false,false,true}},"bool"); same(np.any(a),true) end
do local a=np.zeros({2,0},"int16"); local v=np.any(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{false,false}) end
do local a=np.array({{-2.0,0.0,-2.0},{-2.0,4.0,-2.0}},"float32"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{5}}) end
do local a=np.transpose(np.array({{1,0},{5,-1},{0,0}},"int16")); same(np.count_nonzero(a),3) end
do local a=np.array({"XX","","a",""},"S3"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{2}) end
do local a=np.array({{0,5,0},{0,1,1}},"int8"); same(np.all(a),false) end
do local a=np.flip(np.array({1,0,-1,1},"int16"),1); same(np.count_nonzero(a,{axis={1}}),3) end
do local a=np.transpose(np.zeros({2,0,3},"complex128")); same(np.any(a,{where=np.zeros({3,0,2},"bool")}),false) end
do local a=np.zeros({2,0},"complex64"); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.transpose(np.zeros({2,0},"uint8")); same(np.all(a),true) end
do local a=np.flip(np.array({{0,0,5},{0,0,5}},"int16"),2); local v=np.count_nonzero(a,{axis={1,2},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{2}}) end
do local a=np.zeros({0,3},"int64"); same(np.count_nonzero(a),0) end
do local a=np.transpose(np.zeros({2,0},"bool")); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.array(np.complex(0.0,3.0),"complex64"); same(np.any(a),true) end
do local a=np.array({{np.complex(-1.0,0.0),np.complex(-1.0,0.0),np.complex(0.0,0.0)},{np.complex(-1.0,0.0),np.complex(-1.0,0.0),np.complex(-1.0,0.0)}},"complex64"); same(np.all(a),false) end
do local a=np.flip(np.array({{{-0.0,4.0},{-0.0,-2.0},{0.0,(0/0)}},{{-0.0,math.huge},{0.0,0.0},{-0.0,-2.0}}},"float64"),3); same(np.any(a),true) end
do local a=np.flip(np.array({{"a"},{""}},"U3"),2); same(np.count_nonzero(a,{axis={1,2}}),1) end
do local a=np.zeros({0},"int16"); same(np.count_nonzero(a),0) end
do local a=np.transpose(np.array({{-1,5,0},{0,0,0}},"int32")); local v=np.any(a,{axis={1,2},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.array({{{"","","a"},{"a","XX","a"}}},"S3"); same(np.count_nonzero(a),4) end
do local a=np.array({{{5,5,0},{-1,0,1}}},"int8"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{{1,1,0},{1,0,1}}}) end
do local a=np.array(np.complex((0/0),0.0),"complex64"); same(np.any(a,{axis={}}),true) end
do local a=np.transpose(np.zeros({2,0,3},"U3")); local v=np.all(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{{true,true},{true,true},{true,true}}) end
do local a=np.array({{false},{true}},"bool"); same(np.count_nonzero(a,{axis={1,2}}),1) end
do local a=np.array({{5,0},{1,5},{0,0}},"uint8"); same(np.count_nonzero(a),3) end
do local a=np.transpose(np.array({{np.complex(-1.0,0.0),np.complex(0.0,0.0),np.complex(2.0,0.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}},"complex128")); local v=np.all(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{false,false}) end
do local a=np.array({"","a"},"S3"); same(np.any(a,{where=np.array({true,false},"bool")}),false) end
do local a=np.zeros({0},"bool"); same(np.all(a,{axis=1,where=np.zeros({0},"bool")}),true) end
do local a=np.array({{np.complex((0/0),0.0),np.complex(-1.0,0.0),np.complex(0.0,0.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}},"complex64"); local v=np.any(a,{axis={1,2},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.flip(np.zeros({2,0,3},"int16"),3); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{true}}}) end
do local a=np.array({""},"U3"); same(np.all(a),false) end
do local a=np.zeros({0,3},"uint64"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.flip(np.array({{"xyz",""},{"a","XX"},{"","xyz"}},"U3"),2); same(np.any(a,{where=np.array({{true,true}},"bool")}),true) end
do local a=np.flip(np.zeros({0,3},"int64"),2); same(np.count_nonzero(a,{axis={1,2}}),0) end
do local a=np.transpose(np.array({{{0.0,(0/0),4.0},{4.0,math.huge,-0.0}}},"float64")); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{false}}}) end
do local a=np.array({5,5},"int16"); same(np.any(a,{where=false}),false) end
do local a=np.array({-2.0},"float32"); same(np.all(a),true) end
do local a=np.array(1,"int32"); same(np.all(a,{axis={},keepdims=true}),true) end
do local a=np.transpose(np.array({{{true,false},{true,true},{false,false}},{{true,true},{false,true},{false,false}}},"bool")); same(np.any(a),true) end
do local a=np.array({{{true,false},{true,false},{true,true}},{{false,true},{false,false},{false,true}}},"bool"); local v=np.any(a,{axis=2,where=true});assert(v.dtype=="bool")
same(v:tolist(),{{true,true},{false,true}}) end
do local a=np.flip(np.array({{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,3.0)},{np.complex(-1.0,0.0),np.complex(-1.0,0.0),np.complex(2.0,3.0)}},"complex128"),2); local v=np.count_nonzero(a,{axis=1});assert(v.dtype=="int64")
same(v:tolist(),{2,1,1}) end
do local a=np.flip(np.array({9007199254740995},"int64"),1); local v=np.all(a,{axis={},keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.flip(np.array({{true},{true}},"bool"),2); same(np.any(a,{where=true}),true) end
do local a=np.array(0,"int16"); same(np.any(a,{axis={},keepdims=true}),false) end
do local a=np.transpose(np.array({{0,1},{1,9007199254740995},{5,1}},"uint64")); local v=np.any(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false,true,true},{true,true,true}}) end
do local a=np.flip(np.array({0},"int16"),1); local v=np.any(a,{axis={},where=false});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.flip(np.zeros({0},"uint64"),1); same(np.any(a),false) end
do local a=np.transpose(np.zeros({2,0,3},"complex64")); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{0}}}) end
do local a=np.array(np.complex(-1.0,0.0),"complex64"); same(np.all(a),true) end
do local a=np.array({{1},{1}},"uint64"); local v=np.any(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{true,true}) end
do local a=np.flip(np.array({"","xyz"},"U3"),1); same(np.all(a,{axis=1}),false) end
do local a=np.array({{{"xyz",""},{"XX","xyz"},{"","a"}},{{"","XX"},{"xyz",""},{"xyz","xyz"}}},"U3"); local v=np.all(a,{axis=2,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{false,false}},{{false,false}}}) end
do local a=np.array(np.complex(0.0,3.0),"complex64"); same(np.all(a),true) end
do local a=np.array({0},"uint64"); same(np.count_nonzero(a),0) end
do local a=np.flip(np.zeros({2,0},"int32"),2); same(np.all(a),true) end
do local a=np.transpose(np.zeros({0,3},"int32")); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{},{},{}}) end
do local a=np.zeros({2,0},"int64"); same(np.count_nonzero(a),0) end
do local a=np.array({{{"","xyz","XX"},{"xyz","a","a"}}},"S3"); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{{false,true,true},{true,true,true}}}) end
do local a=np.zeros({0},"float16"); same(np.count_nonzero(a,{axis=1}),0) end
do local a=np.flip(np.array({"XX","","XX","XX"},"S3"),1); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{1,1,0,1}) end
do local a=np.flip(np.zeros({2,0},"float64"),2); local v=np.count_nonzero(a,{axis=1});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.flip(np.array({{"a"},{"a"}},"U3"),2); same(np.any(a),true) end
do local a=np.array({false,true},"bool"); same(np.any(a,{axis=1,where=np.array({true,true},"bool")}),true) end
do local a=np.array({"XX","xyz"},"S3"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array({{np.complex(0.0,0.0)},{np.complex(-1.0,0.0)}},"complex64"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{1}}) end
do local a=np.flip(np.zeros({0,3},"complex128"),2); same(np.any(a,{axis={1,2},where=true}),false) end
do local a=np.array({{1,5,1},{1,5,1}},"uint8"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.flip(np.array({{np.complex(0.0,3.0)},{np.complex(0.0,3.0)}},"complex64"),2); local v=np.all(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.flip(np.array({0.0,(0/0),4.0,-0.0},"float32"),1); same(np.all(a),false) end
do local a=np.array({np.complex(-1.0,3.0),np.complex(0.0,0.0)},"complex64"); local v=np.any(a,{axis={},where=true});assert(v.dtype=="bool")
same(v:tolist(),{true,false}) end
do local a=np.flip(np.array({{{"XX","XX"},{"xyz","xyz"},{"xyz","XX"}},{{"a","xyz"},{"","XX"},{"xyz","xyz"}}},"U3"),3); same(np.count_nonzero(a),11) end
do local a=np.transpose(np.zeros({0,3},"bool")); same(np.count_nonzero(a),0) end
do local a=np.flip(np.array({"","a"},"S3"),1); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.flip(np.array({{np.complex(-1.0,0.0),np.complex((0/0),3.0)},{np.complex((0/0),3.0),np.complex(-1.0,0.0)},{np.complex(0.0,0.0),np.complex((0/0),0.0)}},"complex128"),2); local v=np.any(a,{axis=2,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true},{true},{true}}) end
do local a=np.flip(np.array({{0,0},{1,9007199254740995},{1,5}},"uint64"),2); same(np.all(a,{where=true}),false) end
do local a=np.array(-1,"int16"); same(np.all(a),true) end
do local a=np.array({{{0.0,4.0},{-0.0,0.0},{4.0,0.0}},{{4.0,0.0},{-2.0,-2.0},{0.0,0.0}}},"float16"); local v=np.all(a,{axis={},where=np.array({{{true,false}}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{{false,true},{false,true},{true,true}},{{true,true},{true,true},{false,true}}}) end
do local a=np.array({np.complex(0.0,0.0)},"complex128"); same(np.any(a),false) end
do local a=np.array({{np.complex(0.0,0.0),np.complex(2.0,0.0),np.complex(2.0,0.0)},{np.complex((0/0),0.0),np.complex(-1.0,0.0),np.complex(-1.0,0.0)}},"complex128"); local v=np.count_nonzero(a,{axis={1,2},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{5}}) end
do local a=np.transpose(np.zeros({0,3},"int16")); local v=np.any(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{false,false,false}) end
do local a=np.array({{0.0,-2.0,math.huge},{4.0,0.0,(0/0)}},"float32"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{4}}) end
do local a=np.zeros({0},"bool"); same(np.all(a,{axis=1,where=np.zeros({0},"bool")}),true) end
do local a=np.flip(np.array({{{"a","a",""},{"xyz","xyz",""}}},"U3"),3); same(np.any(a),true) end
do local a=np.array({1,1},"int32"); same(np.count_nonzero(a),2) end
do local a=np.array({{{math.huge,(0/0),0.0},{(0/0),0.0,-0.0}}},"float32"); same(np.all(a),false) end
do local a=np.array({0,0},"uint8"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{false,false}) end
do local a=np.array({{""},{"XX"}},"S3"); same(np.all(a,{where=np.array({{false}},"bool")}),true) end
do local a=np.array({np.complex(0.0,0.0),np.complex(-1.0,3.0),np.complex((0/0),0.0),np.complex(2.0,3.0)},"complex128"); local v=np.all(a,{axis={},where=np.array({true,false,false,true},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{false,true,true,true}) end
do local a=np.array({0,0},"int16"); same(np.all(a),false) end
do local a=np.array({5,-1,1,1},"int16"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.zeros({2,0,3},"uint8"); same(np.all(a),true) end
do local a=np.flip(np.zeros({2,0,3},"float32"),3); same(np.count_nonzero(a),0) end
do local a=np.array({4.0},"float16"); local v=np.all(a,{axis={1},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array(np.complex(0.0,0.0),"complex64"); same(np.count_nonzero(a,{keepdims=true}),0) end
do local a=np.array({4.0,math.huge},"float64"); same(np.count_nonzero(a,{axis={1}}),2) end
do local a=np.zeros({2,0,3},"int64"); same(np.any(a),false) end
do local a=np.array({1,1,0,0},"int16"); same(np.any(a,{axis=1}),true) end
do local a=np.array({0,-1,0,1},"int32"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{2}) end
do local a=np.array({{{"xyz",""},{"","a"},{"xyz","xyz"}},{{"xyz","xyz"},{"a",""},{"a","xyz"}}},"S3"); local v=np.any(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{{true,true},{true,true}}) end
do local a=np.flip(np.array({{true,true},{false,true},{false,true}},"bool"),2); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{1,1},{1,0},{1,0}}) end
do local a=np.array({false},"bool"); same(np.count_nonzero(a),0) end
do local a=np.flip(np.zeros({2,0},"uint64"),2); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{},{}}) end
do local a=np.flip(np.array({{-1},{1}},"int64"),2); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{true},{true}}) end
do local a=np.flip(np.array({(0/0),4.0,4.0,math.huge},"float32"),1); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array({{{0.0,0.0,0.0},{-0.0,-0.0,(0/0)}}},"float64"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{1}}}) end
do local a=np.array({{"a","XX",""},{"","XX","a"}},"U3"); same(np.any(a),true) end
do local a=np.transpose(np.array({{{0,1,0},{1,0,1}}},"uint8")); same(np.count_nonzero(a),3) end
do local a=np.flip(np.zeros({2,0},"int32"),2); same(np.count_nonzero(a),0) end
do local a=np.array("xyz","U3"); same(np.any(a,{axis={}}),true) end
do local a=np.array({0.0,4.0,-2.0,4.0},"float16"); same(np.any(a,{where=np.array({true,true,true,false},"bool")}),true) end
do local a=np.array({{np.complex(0.0,3.0),np.complex(0.0,0.0)},{np.complex(-1.0,3.0),np.complex(0.0,0.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0)}},"complex128"); same(np.any(a,{axis={1,2}}),true) end
do local a=np.array({0,-1},"int8"); same(np.any(a,{where=np.array({true,true},"bool")}),true) end
do local a=np.flip(np.array({{5,0,5},{0,9007199254740995,9007199254740995}},"uint64"),2); local v=np.count_nonzero(a,{axis={1,2},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{4}}) end
do local a=np.flip(np.zeros({0},"int32"),1); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.flip(np.zeros({0},"float32"),1); same(np.all(a),true) end
do local a=np.flip(np.array({"XX","","",""},"S3"),1); local v=np.all(a,{axis={1},keepdims=true,where=false});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.zeros({2,0},"int8"); same(np.all(a,{axis={1,2}}),true) end
do local a=np.array({{{5,-1,0},{1,0,0}}},"int8"); same(np.all(a,{axis={1,2,3},where=np.array({{{false,false,false},{true,false,true}}},"bool")}),false) end
do local a=np.array({{{np.complex(2.0,0.0),np.complex((0/0),0.0)},{np.complex(2.0,0.0),np.complex(2.0,0.0)},{np.complex(-1.0,3.0),np.complex(0.0,0.0)}},{{np.complex(0.0,3.0),np.complex((0/0),0.0)},{np.complex(0.0,0.0),np.complex((0/0),0.0)},{np.complex(0.0,0.0),np.complex(-1.0,3.0)}}},"complex128"); local v=np.all(a,{axis={},where=np.array({{{true,false},{true,false},{true,true}},{{true,false},{false,false},{false,true}}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{{true,true},{true,true},{true,false}},{{true,true},{true,true},{true,true}}}) end
do local a=np.zeros({0},"int32"); same(np.all(a,{axis={1},where=np.zeros({0},"bool")}),true) end
do local a=np.array(5,"int8"); same(np.all(a),true) end
do local a=np.zeros({2,0,3},"int32"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{true}}}) end
do local a=np.array(0,"uint64"); same(np.all(a,{keepdims=true}),false) end
do local a=np.zeros({0},"int32"); same(np.all(a),true) end
do local a=np.array({{{np.complex(0.0,0.0),np.complex((0/0),0.0),np.complex(2.0,0.0)},{np.complex(-1.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}}},"complex128"); same(np.count_nonzero(a),3) end
do local a=np.flip(np.zeros({0,3},"int32"),2); same(np.all(a,{where=false}),true) end
do local a=np.array({1,0},"uint8"); same(np.any(a,{axis=1}),true) end
do local a=np.array({{{0,9007199254740995},{9007199254740995,5},{9007199254740995,0}},{{0,0},{0,0},{5,0}}},"int64"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{true}}}) end
do local a=np.array({-0.0},"float16"); same(np.all(a),false) end
do local a=np.transpose(np.array({{{1,1,5},{-1,0,1}}},"int16")); local v=np.all(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{true},{true}},{{true},{false}},{{true},{true}}}) end
do local a=np.flip(np.array({1},"int16"),1); same(np.count_nonzero(a,{axis={1}}),1) end
do local a=np.array({np.complex(0.0,3.0),np.complex(0.0,0.0)},"complex128"); local v=np.count_nonzero(a,{axis=1,keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{1}) end
do local a=np.zeros({0,3},"uint64"); same(np.all(a),true) end
do local a=np.array({{4.0},{0.0}},"float32"); same(np.count_nonzero(a),1) end
do local a=np.zeros({0,3},"S3"); local v=np.count_nonzero(a,{axis=2});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.transpose(np.zeros({0,3},"float64")); same(np.count_nonzero(a),0) end
do local a=np.array({-1},"int32"); same(np.count_nonzero(a,{axis={1}}),1) end
do local a=np.zeros({2,0,3},"int16"); same(np.any(a),false) end
do local a=np.flip(np.zeros({0},"float16"),1); same(np.all(a,{where=np.zeros({0},"bool")}),true) end
do local a=np.zeros({2,0},"U3"); same(np.all(a),true) end
do local a=np.array(false,"bool"); same(np.count_nonzero(a),0) end
do local a=np.flip(np.zeros({0,3},"int64"),2); same(np.any(a),false) end
do local a=np.array({"XX","XX"},"S3"); local v=np.any(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true,true}) end
do local a=np.array({{{false,true,true},{true,true,false}}},"bool"); same(np.count_nonzero(a),4) end
do local a=np.zeros({0,3},"int32"); same(np.count_nonzero(a,{axis={1,2}}),0) end
do local a=np.flip(np.array({{0},{0}},"uint64"),2); local v=np.all(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false},{false}}) end
do local a=np.zeros({0,3},"uint64"); same(np.count_nonzero(a),0) end
do local a=np.flip(np.array({-2.0,-0.0,0.0,-0.0},"float32"),1); local v=np.any(a,{axis={1},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array({{np.complex(0.0,0.0),np.complex(-1.0,3.0)},{np.complex(2.0,0.0),np.complex(0.0,0.0)},{np.complex(0.0,3.0),np.complex(2.0,3.0)}},"complex64"); local v=np.count_nonzero(a,{axis=2});assert(v.dtype=="int64")
same(v:tolist(),{1,1,2}) end
do local a=np.array({0,5},"int32"); same(np.any(a),true) end
do local a=np.array({{{1,0,1},{1,0,0}}},"uint8"); same(np.all(a,{axis={1,2,3}}),false) end
do local a=np.array({{{-0.0,-0.0},{0.0,4.0},{math.huge,math.huge}},{{-0.0,4.0},{0.0,math.huge},{math.huge,0.0}}},"float32"); local v=np.any(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{{false,true},{false,true},{true,true}}) end
do local a=np.flip(np.array({false,false,false,false},"bool"),1); same(np.any(a),false) end
do local a=np.flip(np.zeros({2,0,3},"int8"),3); local v=np.all(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{{true,true,true},{true,true,true}}) end
do local a=np.flip(np.array({{5,5,-1},{0,1,0}},"int32"),2); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.flip(np.zeros({2,0},"int32"),2); same(np.all(a,{axis={1,2},where=true}),true) end
do local a=np.zeros({0,3},"int32"); same(np.all(a,{where=true}),true) end
do local a=np.zeros({0},"int16"); same(np.all(a),true) end
do local a=np.array({9007199254740995},"int64"); same(np.count_nonzero(a,{axis=1}),1) end
do local a=np.array({{np.complex(-1.0,0.0)},{np.complex(2.0,0.0)}},"complex128"); same(np.all(a,{where=np.array({{true}},"bool")}),true) end
do local a=np.transpose(np.array({{{0,1,0},{5,0,0}}},"int8")); local v=np.count_nonzero(a,{axis=2,keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{1}},{{1}},{{0}}}) end
do local a=np.array({{"xyz","XX"},{"a","xyz"},{"a","xyz"}},"U3"); same(np.all(a,{where=np.array({{true,true},{false,false},{false,true}},"bool")}),true) end
do local a=np.array({{-2.0,4.0},{(0/0),-0.0},{(0/0),0.0}},"float16"); same(np.all(a),false) end
do local a=np.flip(np.array({{{-1,1,-1},{9007199254740995,0,0}}},"int64"),3); same(np.all(a),false) end
do local a=np.flip(np.zeros({2,0,3},"uint8"),3); local v=np.all(a,{axis=2,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{true,true,true}},{{true,true,true}}}) end
do local a=np.array({{{0,0},{-1,0},{0,0}},{{5,-1},{-1,1},{0,0}}},"int32"); same(np.all(a,{axis={1,2,3},where=false}),true) end
do local a=np.zeros({2,0,3},"int16"); same(np.any(a,{where=np.zeros({2,0,3},"bool")}),false) end
do local a=np.array({{"a","XX","XX"},{"a","xyz","xyz"}},"S3"); same(np.count_nonzero(a),6) end
do local a=np.array({{{np.complex((0/0),3.0),np.complex(2.0,0.0)},{np.complex(2.0,3.0),np.complex(2.0,3.0)},{np.complex((0/0),0.0),np.complex(0.0,3.0)}},{{np.complex((0/0),3.0),np.complex(2.0,0.0)},{np.complex(2.0,0.0),np.complex(0.0,3.0)},{np.complex((0/0),0.0),np.complex(0.0,0.0)}}},"complex128"); local v=np.all(a,{axis=2,keepdims=true,where=np.array({{{false,true},{false,false},{false,true}},{{false,false},{false,true},{false,true}}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{{true,true}},{{true,false}}}) end
do local a=np.array({{{5,0,5},{0,0,0}}},"uint64"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{false}}}) end
do local a=np.transpose(np.zeros({2,0},"uint8")); local v=np.any(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.array({{{np.complex(0.0,0.0),np.complex((0/0),0.0),np.complex(0.0,0.0)},{np.complex(0.0,3.0),np.complex(-1.0,3.0),np.complex(0.0,0.0)}}},"complex64"); local v=np.all(a,{axis={},where=true});assert(v.dtype=="bool")
same(v:tolist(),{{{false,true,false},{true,true,false}}}) end
do local a=np.array({4.0},"float32"); local v=np.any(a,{axis={1},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array(1,"int16"); same(np.any(a,{where=false}),false) end
do local a=np.transpose(np.zeros({0,3},"U3")); local v=np.any(a,{axis=1,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{}}) end
do local a=np.flip(np.zeros({2,0},"int64"),2); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.array({{{-2.0,0.0},{4.0,4.0},{4.0,4.0}},{{(0/0),-2.0},{(0/0),0.0},{(0/0),math.huge}}},"float64"); local v=np.all(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{true,false},{true,true},{true,true}},{{true,true},{true,false},{true,true}}}) end
do local a=np.array({{5,0,5},{5,0,1}},"int32"); local v=np.any(a,{keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.array({{np.complex(0.0,0.0),np.complex((0/0),0.0)},{np.complex(-1.0,0.0),np.complex((0/0),0.0)},{np.complex(2.0,3.0),np.complex(0.0,3.0)}},"complex64"); local v=np.any(a,{axis={1,2},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.zeros({2,0},"float16"); local v=np.count_nonzero(a,{axis=2,keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0},{0}}) end
do local a=np.transpose(np.array({{5,1,1},{0,5,1}},"uint8")); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.zeros({2,0,3},"int16"); local v=np.count_nonzero(a,{axis=1});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.array(4.0,"float64"); same(np.count_nonzero(a,{axis={}}),1) end
do local a=np.array({0.0,0.0},"float64"); same(np.any(a,{axis=1}),false) end
do local a=np.zeros({2,0},"float32"); local v=np.all(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.flip(np.zeros({2,0,3},"int64"),3); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{0}}}) end
do local a=np.array({{0,1,0},{0,0,0}},"int16"); same(np.count_nonzero(a),1) end
do local a=np.zeros({0},"uint64"); same(np.count_nonzero(a),0) end
do local a=np.flip(np.zeros({2,0},"complex128"),2); same(np.any(a,{axis={1,2}}),false) end
do local a=np.array({{false,true},{false,true},{false,false}},"bool"); local v=np.count_nonzero(a,{axis=1,keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0,2}}) end
do local a=np.array({{-2.0,4.0},{math.huge,(0/0)},{-0.0,(0/0)}},"float16"); local v=np.count_nonzero(a,{axis={1,2},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{5}}) end
do local a=np.transpose(np.zeros({2,0},"complex128")); same(np.any(a),false) end
do local a=np.array({{{5,1},{1,0},{0,0}},{{0,1},{0,1},{9007199254740995,5}}},"uint64"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{true}}}) end
do local a=np.array({{"xyz","XX"},{"","xyz"},{"XX",""}},"S3"); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{1,1},{0,1},{1,0}}) end
do local a=np.array(true,"bool"); same(np.all(a,{axis={},where=np.array(true,"bool")}),true) end
do local a=np.zeros({0},"S3"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{0}) end
do local a=np.transpose(np.array({{0},{0}},"uint64")); same(np.any(a,{where=np.array({{false,false}},"bool")}),false) end
do local a=np.transpose(np.array({{{true,false,false},{false,true,true}}},"bool")); same(np.any(a,{where=np.array({{{true},{false}},{{false},{false}},{{true},{false}}},"bool")}),true) end
do local a=np.array({{false,false,true},{false,true,true}},"bool"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.array(4.0,"float32"); same(np.count_nonzero(a),1) end
do local a=np.array({{{0.0,-2.0},{-2.0,math.huge},{4.0,(0/0)}},{{4.0,0.0},{4.0,(0/0)},{-2.0,4.0}}},"float64"); same(np.any(a,{where=false}),false) end
do local a=np.flip(np.array({{{np.complex(-1.0,0.0),np.complex((0/0),3.0)},{np.complex((0/0),3.0),np.complex(-1.0,0.0)},{np.complex((0/0),0.0),np.complex(-1.0,0.0)}},{{np.complex(-1.0,0.0),np.complex(2.0,0.0)},{np.complex(2.0,3.0),np.complex(0.0,3.0)},{np.complex((0/0),3.0),np.complex(-1.0,0.0)}}},"complex64"),3); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{{1,1},{1,1},{1,1}},{{1,1},{1,1},{1,1}}}) end
do local a=np.array({false},"bool"); same(np.all(a,{axis={1},where=true}),false) end
do local a=np.zeros({0},"complex64"); same(np.any(a),false) end
do local a=np.array({0,0},"int8"); same(np.any(a,{axis=1}),false) end
do local a=np.array({0.0,0.0},"float16"); same(np.any(a,{axis={1},where=true}),false) end
do local a=np.transpose(np.array({{{-2.0,0.0},{0.0,0.0},{0.0,0.0}},{{0.0,-0.0},{4.0,0.0},{0.0,0.0}}},"float64")); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{{true,false},{false,true},{false,false}},{{false,false},{false,false},{false,false}}}) end
do local a=np.zeros({0,3},"float64"); local v=np.count_nonzero(a,{axis=1,keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0,0,0}}) end
do local a=np.flip(np.array({{"a","a","a"},{"XX","xyz",""}},"S3"),2); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.flip(np.array({{1},{1}},"uint8"),2); same(np.all(a,{axis={1,2}}),true) end
do local a=np.array("a","U3"); same(np.count_nonzero(a,{keepdims=true}),1) end
do local a=np.array({0,-1,5,1},"int8"); same(np.any(a,{axis={1}}),true) end
do local a=np.transpose(np.zeros({2,0},"U3")); local v=np.all(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.array({0,5},"uint8"); local v=np.any(a,{axis={},where=true});assert(v.dtype=="bool")
same(v:tolist(),{false,true}) end
do local a=np.zeros({0},"float64"); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.array({0,0},"int32"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{0}) end
do local a=np.transpose(np.array({{np.complex(-1.0,0.0)},{np.complex(2.0,0.0)}},"complex128")); same(np.count_nonzero(a),2) end
do local a=np.array({{np.complex(0.0,0.0)},{np.complex((0/0),0.0)}},"complex128"); same(np.all(a),false) end
do local a=np.flip(np.array({{np.complex(-1.0,3.0),np.complex(0.0,0.0),np.complex(-1.0,0.0)},{np.complex((0/0),0.0),np.complex(2.0,0.0),np.complex(0.0,0.0)}},"complex64"),2); same(np.all(a),false) end
do local a=np.array({-1,0,0,5},"int32"); same(np.all(a,{axis={1},where=np.array({false,false,true,true},"bool")}),false) end
do local a=np.array(1,"int64"); same(np.any(a,{keepdims=true}),true) end
do local a=np.flip(np.array({{0.0,-0.0,-0.0},{-0.0,(0/0),math.huge}},"float32"),2); local v=np.count_nonzero(a,{axis=2});assert(v.dtype=="int64")
same(v:tolist(),{0,2}) end
do local a=np.flip(np.array({{{5,0},{0,0},{0,1}},{{0,0},{1,0},{0,0}}},"int32"),3); same(np.count_nonzero(a),3) end
do local a=np.array({0},"int32"); same(np.any(a,{axis=1}),false) end
do local a=np.transpose(np.zeros({2,0},"complex128")); local v=np.all(a,{axis=1,keepdims=true,where=np.array({{false,true}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{true,true}}) end
do local a=np.array({{0.0,-0.0,-2.0},{-0.0,(0/0),-2.0}},"float32"); same(np.any(a),true) end
do local a=np.flip(np.array({{{0.0,4.0},{math.huge,-2.0},{math.huge,4.0}},{{0.0,(0/0)},{0.0,0.0},{(0/0),4.0}}},"float16"),3); local v=np.count_nonzero(a,{axis=1,keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{2,0},{1,1},{2,2}}}) end
do local a=np.flip(np.zeros({0,3},"int32"),2); local v=np.count_nonzero(a,{axis=2});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.flip(np.array({{0,0,5},{0,-1,0}},"int16"),2); local v=np.count_nonzero(a,{axis=1});assert(v.dtype=="int64")
same(v:tolist(),{1,1,0}) end
do local a=np.zeros({0},"U3"); local v=np.any(a,{axis=1,keepdims=true,where=np.array({},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.array({0},"int8"); same(np.count_nonzero(a),0) end
do local a=np.array({{{0,0,5},{0,5,0}}},"int32"); same(np.count_nonzero(a),2) end
do local a=np.array({0.0,0.0,4.0,(0/0)},"float32"); same(np.any(a),true) end
do local a=np.flip(np.array({{{4.0,(0/0),4.0},{-0.0,4.0,(0/0)}}},"float64"),3); local v=np.all(a,{axis=2,where=np.array({{{true,true,true}}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{true,true,false}}) end
do local a=np.transpose(np.array({{{true,false},{true,true},{true,true}},{{true,false},{true,true},{false,true}}},"bool")); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{{true,true},{true,true},{true,false}},{{false,false},{true,true},{true,true}}}) end
do local a=np.flip(np.array({{{0,5},{1,0},{0,-1}},{{9007199254740995,9007199254740995},{5,9007199254740995},{0,0}}},"int64"),3); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{{true,false},{false,true},{true,false}},{{true,true},{true,true},{false,false}}}) end
do local a=np.array({"a","XX","xyz","XX"},"S3"); same(np.count_nonzero(a),4) end
do local a=np.array({{math.huge,0.0,-0.0},{-0.0,math.huge,0.0}},"float32"); same(np.count_nonzero(a,{axis={1,2}}),2) end
do local a=np.transpose(np.array({{{np.complex((0/0),3.0),np.complex(2.0,0.0),np.complex(0.0,0.0)},{np.complex(0.0,3.0),np.complex(0.0,0.0),np.complex(2.0,3.0)}}},"complex128")); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{{true},{true}},{{true},{false}},{{false},{true}}}) end
do local a=np.array({"xyz","XX","a","XX"},"U3"); local v=np.all(a,{axis=1,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.flip(np.array({"XX",""},"U3"),1); same(np.any(a,{axis={1}}),true) end
do local a=np.transpose(np.zeros({2,0},"complex64")); same(np.all(a,{axis={1,2},where=false}),true) end
do local a=np.array({{"xyz",""},{"a","a"},{"xyz",""}},"U3"); same(np.count_nonzero(a),4) end
do local a=np.transpose(np.zeros({2,0},"bool")); same(np.all(a),true) end
do local a=np.transpose(np.zeros({0,3},"float16")); same(np.all(a,{where=true}),true) end
do local a=np.array({{5},{0}},"uint64"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{1},{0}}) end
do local a=np.array({{1,9007199254740995},{0,9007199254740995},{0,1}},"uint64"); same(np.count_nonzero(a),4) end
do local a=np.array({0,0,0,1},"int16"); local v=np.any(a,{keepdims=true,where=false});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.flip(np.zeros({0},"bool"),1); local v=np.any(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.array({{{(0/0),0.0,math.huge},{0.0,math.huge,0.0}}},"float32"); same(np.count_nonzero(a),3) end
do local a=np.transpose(np.array({{-1},{-1}},"int16")); same(np.count_nonzero(a),2) end
do local a=np.flip(np.array({{{0,-1},{0,0},{-1,-1}},{{0,-1},{5,5},{-1,1}}},"int32"),3); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{false}}}) end
do local a=np.array({0,-1},"int32"); same(np.any(a,{where=true}),true) end
do local a=np.array({{{1,1},{0,1},{5,0}},{{1,1},{0,5},{0,0}}},"uint8"); local v=np.any(a,{axis={1,2,3},keepdims=true,where=np.array({{{false,false},{false,false},{true,true}},{{true,true},{false,true},{false,true}}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{{true}}}) end
do local a=np.transpose(np.array({{5},{1}},"int64")); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{true,true}}) end
do local a=np.flip(np.array({1,5,0,0},"uint8"),1); same(np.count_nonzero(a),2) end
do local a=np.zeros({2,0,3},"complex64"); same(np.any(a,{where=np.zeros({2,0,3},"bool")}),false) end
do local a=np.array({{{0.0,4.0,4.0},{0.0,4.0,-2.0}}},"float64"); same(np.all(a),false) end
do local a=np.array({{np.complex(2.0,0.0),np.complex(-1.0,3.0)},{np.complex((0/0),3.0),np.complex(-1.0,0.0)},{np.complex(0.0,3.0),np.complex(2.0,0.0)}},"complex64"); same(np.all(a),true) end
do local a=np.array({"XX"},"U3"); local v=np.any(a,{keepdims=true,where=np.array({false},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.flip(np.zeros({0},"S3"),1); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.transpose(np.zeros({2,0},"float64")); same(np.any(a,{axis={1,2},where=false}),false) end
do local a=np.array({math.huge,(0/0),math.huge,math.huge},"float16"); same(np.count_nonzero(a,{axis={1}}),4) end
do local a=np.zeros({0},"float64"); same(np.count_nonzero(a,{axis={1}}),0) end
do local a=np.zeros({2,0,3},"U3"); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{},{}}) end
do local a=np.flip(np.array({0.0,0.0},"float64"),1); local v=np.all(a,{axis=1,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.zeros({2,0,3},"float64"); same(np.any(a,{where=true}),false) end
do local a=np.transpose(np.zeros({2,0},"complex128")); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.array({{"xyz"},{"a"}},"U3"); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{true},{true}}) end
do local a=np.array({{{0,0},{5,-1},{0,0}},{{5,0},{0,0},{-1,5}}},"int16"); local v=np.any(a,{axis=1,where=np.array({{{false,true},{true,false},{true,false}},{{true,false},{true,false},{true,false}}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{true,false},{true,false},{true,false}}) end
do local a=np.array({-2.0,(0/0)},"float32"); same(np.count_nonzero(a),2) end
do local a=np.flip(np.zeros({2,0},"int8"),2); local v=np.count_nonzero(a,{axis=2});assert(v.dtype=="int64")
same(v:tolist(),{0,0}) end
do local a=np.transpose(np.array({{{5,1},{1,0},{0,0}},{{0,1},{1,1},{0,0}}},"uint8")); same(np.all(a),false) end
do local a=np.array({-2.0},"float16"); same(np.count_nonzero(a),1) end
do local a=np.array({0.0,4.0},"float16"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{1}) end
do local a=np.array({{{5,0,0},{1,5,-1}}},"int64"); same(np.any(a,{where=false}),false) end
do local a=np.transpose(np.array({{-2.0,(0/0)},{4.0,4.0},{0.0,0.0}},"float32")); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.array({{"",""},{"xyz","xyz"},{"xyz","xyz"}},"S3"); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0,0},{1,1},{1,1}}) end
do local a=np.array({9007199254740995},"uint64"); same(np.any(a,{axis={1}}),true) end
do local a=np.array({"xyz","a"},"U3"); same(np.any(a),true) end
do local a=np.array({{{0,1},{0,0},{5,5}},{{0,0},{0,0},{9007199254740995,5}}},"uint64"); same(np.all(a),false) end
do local a=np.array(-0.0,"float16"); same(np.any(a,{keepdims=true}),false) end
do local a=np.array(math.huge,"float16"); same(np.all(a,{where=false}),true) end
do local a=np.array(1,"uint8"); same(np.all(a,{where=np.array(false,"bool")}),true) end
do local a=np.array({{{1,5},{5,5},{5,0}},{{5,5},{0,5},{-1,0}}},"int8"); same(np.any(a),true) end
do local a=np.flip(np.array({5},"int8"),1); same(np.all(a,{axis=1}),true) end
do local a=np.flip(np.array({{1},{5}},"int64"),2); same(np.any(a),true) end
do local a=np.zeros({2,0,3},"complex128"); same(np.count_nonzero(a),0) end
do local a=np.array({{"XX","XX"},{"xyz","XX"},{"",""}},"S3"); same(np.any(a),true) end
do local a=np.array({{0},{1}},"uint8"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{0},{1}}) end
do local a=np.array({{5},{0}},"int8"); local v=np.any(a,{axis=2,where=true});assert(v.dtype=="bool")
same(v:tolist(),{true,false}) end
do local a=np.zeros({0,3},"uint8"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.array({{np.complex(-1.0,0.0),np.complex((0/0),0.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex((0/0),0.0),np.complex(0.0,0.0)}},"complex128"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{1,1},{0,0},{1,0}}) end
do local a=np.array({5},"int64"); same(np.count_nonzero(a),1) end
do local a=np.array({{true,true,true},{true,true,true}},"bool"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.array({{np.complex(0.0,3.0),np.complex(2.0,0.0),np.complex(0.0,0.0)},{np.complex((0/0),3.0),np.complex((0/0),0.0),np.complex(0.0,0.0)}},"complex128"); same(np.all(a),false) end
do local a=np.transpose(np.zeros({0,3},"bool")); same(np.any(a,{where=true}),false) end
do local a=np.transpose(np.array({{{np.complex(2.0,3.0),np.complex(0.0,3.0),np.complex(-1.0,0.0)},{np.complex(0.0,0.0),np.complex(-1.0,0.0),np.complex(0.0,0.0)}}},"complex64")); same(np.any(a),true) end
do local a=np.flip(np.array({{0.0},{0.0}},"float16"),2); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.transpose(np.zeros({0,3},"complex64")); same(np.all(a,{axis={1,2}}),true) end
do local a=np.flip(np.array({"a","","xyz","XX"},"S3"),1); same(np.count_nonzero(a),3) end
do local a=np.array({{0,1},{1,0},{1,-1}},"int64"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.flip(np.zeros({0,3},"uint8"),2); local v=np.all(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{true,true,true}) end
do local a=np.zeros({0},"U3"); same(np.count_nonzero(a,{axis={1}}),0) end
do local a=np.transpose(np.zeros({2,0},"float64")); same(np.all(a),true) end
do local a=np.zeros({2,0},"uint64"); local v=np.any(a,{axis={},keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.zeros({0},"complex64"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.flip(np.array({{{5,5,5},{1,0,1}}},"uint8"),3); local v=np.all(a,{axis={1,2,3},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{false}}}) end
do local a=np.zeros({0,3},"int8"); same(np.count_nonzero(a),0) end
do local a=np.array({"a","xyz","xyz","XX"},"S3"); same(np.any(a),true) end
do local a=np.zeros({0,3},"float16"); local v=np.count_nonzero(a,{axis=2});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.flip(np.array({false},"bool"),1); local v=np.all(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.array({np.complex((0/0),0.0)},"complex128"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{1}) end
do local a=np.flip(np.array({{np.complex(0.0,0.0),np.complex(2.0,0.0)},{np.complex(0.0,3.0),np.complex(0.0,0.0)},{np.complex(2.0,0.0),np.complex((0/0),0.0)}},"complex128"),2); same(np.all(a),false) end
do local a=np.array(-1,"int8"); same(np.any(a,{axis={}}),true) end
do local a=np.transpose(np.array({{true,true,true},{true,true,true}},"bool")); same(np.all(a,{axis={1,2}}),true) end
do local a=np.array(1,"uint64"); same(np.all(a),true) end
do local a=np.flip(np.array({{-1,1},{0,1},{5,-1}},"int16"),2); same(np.all(a,{where=np.array({{true,false}},"bool")}),true) end
do local a=np.flip(np.array({{{np.complex((0/0),3.0),np.complex(2.0,0.0),np.complex(0.0,0.0)},{np.complex((0/0),3.0),np.complex((0/0),0.0),np.complex(2.0,0.0)}}},"complex128"),3); same(np.any(a,{where=false}),false) end
do local a=np.array({{{false,true,false},{true,false,true}}},"bool"); local v=np.any(a,{keepdims=true,where=np.array({{{true,true,false}}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{{true}}}) end
do local a=np.zeros({0,3},"bool"); same(np.count_nonzero(a),0) end
do local a=np.zeros({2,0},"bool"); same(np.any(a,{where=false}),false) end
do local a=np.array({{4.0,-2.0},{0.0,-0.0},{math.huge,math.huge}},"float32"); local v=np.count_nonzero(a,{axis=2});assert(v.dtype=="int64")
same(v:tolist(),{2,0,2}) end
do local a=np.zeros({2,0},"float32"); local v=np.any(a,{axis={1,2},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.array(9007199254740995,"uint64"); same(np.count_nonzero(a,{keepdims=true}),1) end
do local a=np.zeros({2,0,3},"int8"); same(np.count_nonzero(a),0) end
do local a=np.array({1},"int8"); same(np.any(a,{axis={1},where=np.array({false},"bool")}),false) end
do local a=np.transpose(np.array({{{1,1,5},{1,0,0}}},"uint64")); same(np.all(a),false) end
do local a=np.flip(np.array({(0/0),4.0},"float16"),1); same(np.all(a),true) end
do local a=np.flip(np.array({{5},{5}},"int8"),2); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{2}}) end
do local a=np.array(4.0,"float16"); same(np.all(a),true) end
do local a=np.transpose(np.array({{0,0,0},{0,9007199254740995,1}},"int64")); local v=np.any(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{false,true}) end
do local a=np.array({{{1,0},{1,1},{1,5}},{{0,0},{0,1},{0,0}}},"uint8"); same(np.all(a),false) end
do local a=np.array({{{0,0},{1,5},{5,0}},{{1,5},{5,1},{0,0}}},"int16"); same(np.count_nonzero(a),7) end
do local a=np.flip(np.array({np.complex(2.0,0.0),np.complex(0.0,0.0)},"complex64"),1); local v=np.all(a,{axis={},where=false});assert(v.dtype=="bool")
same(v:tolist(),{true,true}) end
do local a=np.array({{np.complex(-1.0,0.0),np.complex(0.0,3.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex((0/0),3.0),np.complex(0.0,0.0)}},"complex64"); same(np.any(a,{axis={1,2}}),true) end
do local a=np.array(0,"int8"); same(np.any(a),false) end
do local a=np.array(np.complex(0.0,0.0),"complex128"); same(np.all(a,{keepdims=true}),false) end
do local a=np.array({0,9007199254740995,0,-1},"int64"); same(np.all(a),false) end
do local a=np.array({{{-0.0,-0.0},{4.0,math.huge},{-0.0,4.0}},{{0.0,(0/0)},{math.huge,math.huge},{-0.0,-2.0}}},"float32"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{{0,0},{1,1},{0,1}},{{0,1},{1,1},{0,1}}}) end
do local a=np.array({0,1},"int64"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{1}) end
do local a=np.flip(np.array({{"XX"},{"a"}},"U3"),2); local v=np.count_nonzero(a,{axis=2});assert(v.dtype=="int64")
same(v:tolist(),{1,1}) end
do local a=np.array({(0/0)},"float16"); same(np.all(a,{where=np.array({true},"bool")}),true) end
do local a=np.array({{{0.0,(0/0)},{math.huge,0.0},{0.0,0.0}},{{-2.0,0.0},{-0.0,-0.0},{-0.0,0.0}}},"float16"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{{0,1},{1,0},{0,0}},{{1,0},{0,0},{0,0}}}) end
do local a=np.transpose(np.zeros({0,3},"bool")); local v=np.all(a,{axis={},where=false});assert(v.dtype=="bool")
same(v:tolist(),{{},{},{}}) end
do local a=np.transpose(np.array({{{np.complex(0.0,0.0),np.complex(-1.0,0.0),np.complex(0.0,0.0)},{np.complex(-1.0,0.0),np.complex(-1.0,0.0),np.complex(0.0,3.0)}}},"complex128")); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{{false},{true}},{{true},{true}},{{false},{true}}}) end
do local a=np.array({{"","a","XX"},{"xyz","XX",""}},"U3"); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0,1,1},{1,1,0}}) end
do local a=np.array({0},"int64"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{0}) end
do local a=np.array({5,5,9007199254740995,0},"uint64"); same(np.all(a),false) end
do local a=np.flip(np.array({{{(0/0),4.0},{0.0,(0/0)},{(0/0),math.huge}},{{(0/0),math.huge},{(0/0),math.huge},{0.0,-0.0}}},"float16"),3); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{true}}}) end
do local a=np.transpose(np.zeros({2,0},"U3")); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.flip(np.array({-1,-1,9007199254740995,1},"int64"),1); local v=np.any(a,{axis={1},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array({np.complex(-1.0,0.0),np.complex(0.0,0.0)},"complex128"); same(np.all(a,{where=np.array({false,false},"bool")}),true) end
do local a=np.array({1},"int64"); same(np.any(a),true) end
do local a=np.flip(np.array({9007199254740995},"uint64"),1); same(np.all(a),true) end
do local a=np.array({{1},{1}},"uint8"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{true},{true}}) end
do local a=np.flip(np.array({{{0,0},{0,-1},{-1,9007199254740995}},{{9007199254740995,0},{5,5},{0,9007199254740995}}},"int64"),3); local v=np.all(a,{axis={},where=np.array({{{false,true},{false,true},{false,true}},{{false,true},{true,false},{true,true}}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{{true,false},{true,false},{true,true}},{{true,true},{true,true},{true,false}}}) end
do local a=np.flip(np.array({{"XX"},{""}},"U3"),2); same(np.count_nonzero(a),1) end
do local a=np.array({math.huge,-2.0},"float64"); same(np.count_nonzero(a,{axis={1}}),2) end
do local a=np.array({-1},"int64"); same(np.count_nonzero(a),1) end
do local a=np.array({np.complex((0/0),0.0),np.complex(2.0,0.0)},"complex64"); local v=np.any(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true,true}) end
do local a=np.array({0,0},"int8"); same(np.all(a,{axis={1}}),false) end
do local a=np.array({{0.0,0.0,4.0},{0.0,-2.0,math.huge}},"float64"); same(np.any(a),true) end
do local a=np.zeros({2,0,3},"complex128"); local v=np.all(a,{axis=1,where=np.array({{{false,false,true}}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.array({0,1},"uint64"); same(np.any(a,{axis=1}),true) end
do local a=np.flip(np.zeros({2,0},"int64"),2); same(np.all(a),true) end
do local a=np.flip(np.array({np.complex(0.0,0.0)},"complex64"),1); same(np.all(a),false) end
do local a=np.array({{0.0},{(0/0)}},"float64"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{false},{true}}) end
do local a=np.array({np.complex((0/0),0.0),np.complex(-1.0,0.0),np.complex(-1.0,0.0),np.complex(0.0,0.0)},"complex64"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{1,1,1,0}) end
do local a=np.array({"xyz","a","XX","xyz"},"S3"); same(np.count_nonzero(a),4) end
do local a=np.transpose(np.array({{0,0},{0,1},{5,1}},"int16")); same(np.any(a,{axis={1,2}}),true) end
do local a=np.zeros({0},"complex128"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{0}) end
do local a=np.array({{{4.0,4.0},{4.0,4.0},{-0.0,math.huge}},{{-0.0,-2.0},{-0.0,-0.0},{0.0,0.0}}},"float64"); same(np.count_nonzero(a,{axis={1,2,3}}),6) end
do local a=np.array({{{1,1,5},{1,0,1}}},"uint64"); local v=np.count_nonzero(a,{axis=3});assert(v.dtype=="int64")
same(v:tolist(),{{3,2}}) end
do local a=np.flip(np.array({-2.0,-0.0,math.huge,(0/0)},"float16"),1); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array({"a"},"S3"); same(np.all(a,{axis={1}}),true) end
do local a=np.array({(0/0)},"float32"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{1}) end
do local a=np.array({np.complex(2.0,0.0),np.complex(2.0,3.0)},"complex64"); same(np.any(a),true) end
do local a=np.flip(np.array({np.complex(-1.0,0.0),np.complex(-1.0,0.0)},"complex64"),1); same(np.count_nonzero(a,{axis={1}}),2) end
do local a=np.flip(np.array({{{np.complex((0/0),0.0),np.complex((0/0),0.0)},{np.complex(2.0,0.0),np.complex((0/0),3.0)},{np.complex(0.0,0.0),np.complex((0/0),0.0)}},{{np.complex((0/0),0.0),np.complex(0.0,0.0)},{np.complex(-1.0,3.0),np.complex(2.0,0.0)},{np.complex(0.0,0.0),np.complex(-1.0,0.0)}}},"complex64"),3); same(np.count_nonzero(a),9) end
do local a=np.transpose(np.array({{"XX"},{"XX"}},"U3")); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{1,1}}) end
do local a=np.zeros({2,0},"int64"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.transpose(np.array({{1},{5}},"uint8")); same(np.count_nonzero(a),2) end
do local a=np.zeros({0},"uint64"); local v=np.any(a,{keepdims=true,where=np.zeros({0},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.flip(np.array({{np.complex(2.0,0.0),np.complex(-1.0,0.0),np.complex(-1.0,3.0)},{np.complex(-1.0,0.0),np.complex(2.0,3.0),np.complex(-1.0,3.0)}},"complex64"),2); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{6}}) end
do local a=np.zeros({0},"int16"); same(np.all(a,{where=np.zeros({0},"bool")}),true) end
do local a=np.flip(np.zeros({2,0,3},"complex64"),3); local v=np.any(a,{axis=3,where=false});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.array({false,false,true,true},"bool"); same(np.all(a,{axis=1}),false) end
do local a=np.transpose(np.array({{{np.complex(0.0,0.0),np.complex((0/0),3.0)},{np.complex(0.0,3.0),np.complex((0/0),0.0)},{np.complex((0/0),3.0),np.complex(-1.0,0.0)}},{{np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex(-1.0,3.0),np.complex(0.0,0.0)},{np.complex(2.0,0.0),np.complex(0.0,0.0)}}},"complex128")); local v=np.any(a,{axis=3});assert(v.dtype=="bool")
same(v:tolist(),{{false,true,true},{true,true,true}}) end
do local a=np.array({0,0},"int8"); same(np.count_nonzero(a),0) end
do local a=np.flip(np.array({{0},{5}},"int8"),2); local v=np.all(a,{axis=1,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.array({"XX","XX","a","XX"},"U3"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{1,1,1,1}) end
do local a=np.array({0.0,0.0,0.0,(0/0)},"float16"); same(np.any(a,{axis=1}),true) end
do local a=np.transpose(np.array({{0},{0}},"uint64")); local v=np.any(a,{keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.zeros({2,0},"complex128"); local v=np.all(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.flip(np.zeros({0},"int32"),1); same(np.count_nonzero(a),0) end
do local a=np.flip(np.array({{"xyz",""},{"XX","XX"},{"XX","a"}},"S3"),2); local v=np.all(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{false,true,true}) end
do local a=np.transpose(np.array({{{0.0,0.0,0.0},{0.0,-0.0,0.0}}},"float64")); local v=np.any(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{{false},{false},{false}}) end
do local a=np.zeros({0,3},"S3"); same(np.count_nonzero(a),0) end
do local a=np.array(true,"bool"); same(np.any(a),true) end
do local a=np.array({"a",""},"U3"); local v=np.all(a,{axis=1,keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.array({{1},{-1}},"int32"); local v=np.all(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true},{true}}) end
do local a=np.array({{{np.complex(0.0,0.0),np.complex(2.0,0.0),np.complex(-1.0,0.0)},{np.complex((0/0),0.0),np.complex(0.0,0.0),np.complex((0/0),0.0)}}},"complex128"); local v=np.any(a,{axis=3,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{true},{true}}}) end
do local a=np.array({{"","a","XX"},{"xyz","","a"}},"U3"); same(np.any(a,{axis={1,2},where=false}),false) end
do local a=np.transpose(np.array({{"xyz","a"},{"","a"},{"a","xyz"}},"U3")); local v=np.all(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{true,false,true}) end
do local a=np.array({{1,5},{0,1},{-1,5}},"int16"); same(np.any(a),true) end
do local a=np.array({0.0,(0/0),math.huge,(0/0)},"float32"); same(np.all(a),false) end
do local a=np.flip(np.array({{"xyz"},{"XX"}},"U3"),2); local v=np.count_nonzero(a,{axis=2});assert(v.dtype=="int64")
same(v:tolist(),{1,1}) end
do local a=np.array({{{5,0,5},{5,1,0}}},"int16"); same(np.any(a,{where=np.array({{{true,true,true},{true,false,true}}},"bool")}),true) end
do local a=np.zeros({0,3},"bool"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.array({"a","","a","a"},"U3"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{3}) end
do local a=np.flip(np.zeros({2,0,3},"complex128"),3); same(np.any(a,{where=np.array({{{true,true,true}}},"bool")}),false) end
do local a=np.flip(np.zeros({2,0,3},"bool"),3); same(np.count_nonzero(a,{axis={1,2,3}}),0) end
do local a=np.zeros({0,3},"int16"); same(np.count_nonzero(a,{axis={1,2}}),0) end
do local a=np.flip(np.array({{{5,0,0},{5,0,1}}},"int32"),3); same(np.all(a,{axis={1,2,3},where=np.array({{{true,false,true},{false,true,false}}},"bool")}),false) end
do local a=np.flip(np.zeros({0},"int8"),1); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{0}) end
do local a=np.array(0,"int16"); same(np.any(a),false) end
do local a=np.zeros({0,3},"bool"); same(np.count_nonzero(a,{axis={1,2}}),0) end
do local a=np.array({{5,0,0},{0,-1,1}},"int8"); local v=np.any(a,{keepdims=true,where=false});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.array({0.0,math.huge,0.0,4.0},"float32"); same(np.count_nonzero(a),2) end
do local a=np.array({math.huge},"float64"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{1}) end
do local a=np.flip(np.array({{0,-1,0},{1,5,5}},"int16"),2); local v=np.all(a,{keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.flip(np.array({{0,0,0},{0,0,-1}},"int8"),2); local v=np.all(a,{keepdims=true,where=np.array({{true,false,false},{true,false,false}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.array({{"xyz"},{"a"}},"S3"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.flip(np.array({{0,0},{0,0},{1,0}},"uint8"),2); same(np.any(a),true) end
do local a=np.array({{0.0},{(0/0)}},"float32"); local v=np.count_nonzero(a,{axis=1,keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{1}}) end
do local a=np.zeros({0,3},"U3"); same(np.count_nonzero(a),0) end
do local a=np.transpose(np.zeros({0,3},"float64")); same(np.all(a,{axis={1,2},where=false}),true) end
do local a=np.zeros({2,0},"uint8"); same(np.all(a),true) end
do local a=np.transpose(np.zeros({0,3},"complex64")); same(np.all(a,{where=np.array({{}},"bool")}),true) end
do local a=np.zeros({0},"S3"); local v=np.any(a,{axis={},where=np.zeros({0},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.array({{{np.complex(-1.0,3.0),np.complex(2.0,0.0)},{np.complex(0.0,0.0),np.complex((0/0),0.0)},{np.complex(0.0,0.0),np.complex((0/0),0.0)}},{{np.complex((0/0),0.0),np.complex(-1.0,0.0)},{np.complex(2.0,3.0),np.complex((0/0),3.0)},{np.complex(0.0,0.0),np.complex(2.0,0.0)}}},"complex128"); same(np.count_nonzero(a),9) end
do local a=np.flip(np.array({{"xyz","","a"},{"","a","a"}},"U3"),2); same(np.any(a),true) end
do local a=np.array({"","XX"},"S3"); same(np.any(a,{where=np.array({true,false},"bool")}),false) end
do local a=np.array({{{0.0,-0.0},{-2.0,(0/0)},{(0/0),0.0}},{{-0.0,4.0},{-0.0,-2.0},{(0/0),0.0}}},"float32"); same(np.any(a,{where=np.array({{{true,false}}},"bool")}),true) end
do local a=np.transpose(np.zeros({2,0,3},"int8")); local v=np.any(a,{axis=3});assert(v.dtype=="bool")
same(v:tolist(),{{},{},{}}) end
do local a=np.zeros({2,0},"float64"); same(np.any(a,{axis={1,2}}),false) end
do local a=np.array({-2.0,(0/0),4.0,4.0},"float32"); same(np.count_nonzero(a,{axis={1}}),4) end
do local a=np.array({{{true,true},{true,true},{true,true}},{{true,false},{false,false},{false,false}}},"bool"); same(np.all(a),false) end
do local a=np.array({{0,1,0},{5,1,0}},"uint8"); same(np.all(a),false) end
do local a=np.array({{0.0,-0.0},{-0.0,0.0},{0.0,-0.0}},"float16"); local v=np.all(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false,false},{false,false},{false,false}}) end
do local a=np.array(np.complex(0.0,0.0),"complex128"); same(np.all(a,{axis={},keepdims=true}),false) end
do local a=np.transpose(np.array({{{true,true,true},{true,true,true}}},"bool")); same(np.all(a),true) end
do local a=np.array({1,0},"int64"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{1,0}) end
do local a=np.array({{0},{1}},"uint64"); local v=np.any(a,{axis={1,2},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.flip(np.array({1},"int8"),1); same(np.any(a),true) end
do local a=np.zeros({2,0,3},"complex128"); same(np.any(a),false) end
do local a=np.flip(np.zeros({0,3},"complex128"),2); same(np.any(a),false) end
do local a=np.flip(np.array({np.complex(0.0,0.0),np.complex(-1.0,0.0)},"complex128"),1); same(np.count_nonzero(a,{axis=1}),1) end
do local a=np.array({{true},{false}},"bool"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{1}}) end
do local a=np.flip(np.array({{np.complex(0.0,3.0),np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex(0.0,0.0),np.complex(-1.0,0.0),np.complex(2.0,0.0)}},"complex128"),2); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{false,false,true},{true,true,false}}) end
do local a=np.transpose(np.array({{1,0},{5,0},{0,0}},"uint64")); same(np.count_nonzero(a),2) end
do local a=np.flip(np.array({{{0,0},{0,-1},{0,0}},{{-1,-1},{0,1},{-1,1}}},"int32"),3); local v=np.count_nonzero(a,{axis=2});assert(v.dtype=="int64")
same(v:tolist(),{{1,0},{3,2}}) end
do local a=np.transpose(np.array({{{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex((0/0),3.0)},{np.complex(2.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}}},"complex64")); same(np.count_nonzero(a),2) end
do local a=np.array({{-0.0,math.huge},{0.0,math.huge},{-2.0,4.0}},"float16"); same(np.count_nonzero(a),4) end
do local a=np.flip(np.array({-2.0,-2.0},"float64"),1); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{1,1}) end
do local a=np.array({0},"uint64"); same(np.all(a),false) end
do local a=np.array(-1,"int32"); same(np.all(a,{axis={},where=false}),true) end
do local a=np.array({9007199254740995,0,9007199254740995,5},"int64"); local v=np.any(a,{axis={1},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array({1,-1},"int64"); same(np.count_nonzero(a),2) end
do local a=np.array("a","S3"); same(np.all(a),true) end
do local a=np.array(np.complex(0.0,0.0),"complex128"); same(np.count_nonzero(a,{keepdims=true}),0) end
do local a=np.array({{true,true,false},{true,true,true}},"bool"); local v=np.any(a,{axis=1,keepdims=true,where=np.array({{true,true,true}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{true,true,true}}) end
do local a=np.array({false,true,true,false},"bool"); same(np.count_nonzero(a,{axis=1}),2) end
do local a=np.flip(np.zeros({2,0},"int16"),2); same(np.any(a,{axis={1,2},where=np.zeros({2,0},"bool")}),false) end
do local a=np.transpose(np.zeros({0,3},"uint64")); same(np.count_nonzero(a),0) end
do local a=np.array({np.complex(-1.0,0.0),np.complex(2.0,0.0),np.complex(0.0,3.0),np.complex(0.0,0.0)},"complex64"); same(np.any(a),true) end
do local a=np.array({{"a","a"},{"","a"},{"xyz","XX"}},"U3"); same(np.any(a,{where=np.array({{true,true}},"bool")}),true) end
do local a=np.flip(np.array({0,5},"int16"),1); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{true,false}) end
do local a=np.zeros({0},"int8"); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.flip(np.zeros({0,3},"float32"),2); same(np.count_nonzero(a,{axis={1,2}}),0) end
do local a=np.array({{{0,0},{0,1},{1,0}},{{0,1},{5,1},{5,1}}},"uint64"); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{{false,false},{false,true},{true,false}},{{false,true},{true,true},{true,true}}}) end
do local a=np.array({{{0,0},{1,0},{1,1}},{{5,1},{0,0},{1,1}}},"int8"); local v=np.count_nonzero(a,{axis={1,2,3},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{7}}}) end
do local a=np.zeros({0,3},"int8"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.array({{{0,-1,1},{0,0,0}}},"int16"); local v=np.count_nonzero(a,{axis=2});assert(v.dtype=="int64")
same(v:tolist(),{{0,1,1}}) end
do local a=np.transpose(np.zeros({2,0},"float32")); same(np.count_nonzero(a),0) end
do local a=np.array({{0,1},{0,0},{0,-1}},"int64"); same(np.any(a,{axis={1,2}}),true) end
do local a=np.transpose(np.array({{0.0,-2.0,math.huge},{(0/0),-2.0,0.0}},"float32")); same(np.all(a,{axis={1,2}}),false) end
do local a=np.flip(np.array({{{0,0},{0,1},{5,1}},{{1,0},{0,0},{1,1}}},"int8"),3); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{true}}}) end
do local a=np.array({true,false},"bool"); same(np.count_nonzero(a),1) end
do local a=np.array({"a"},"U3"); same(np.all(a,{axis={1}}),true) end
do local a=np.array({false,false,false,false},"bool"); same(np.count_nonzero(a,{axis=1}),0) end
do local a=np.array({{1},{0}},"uint8"); local v=np.any(a,{keepdims=true,where=false});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.flip(np.array({{-1,0,5},{0,5,-1}},"int32"),2); local v=np.all(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{false,false}) end
do local a=np.array({true,false,false,false},"bool"); same(np.all(a,{axis={1}}),false) end
do local a=np.transpose(np.array({{true,true,false},{false,true,true}},"bool")); local v=np.all(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{false,true,false}) end
do local a=np.zeros({2,0},"complex128"); same(np.any(a,{where=true}),false) end
do local a=np.array({{9007199254740995,1,1},{1,0,1}},"uint64"); local v=np.all(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{true,false}) end
do local a=np.flip(np.array({{1,0,5},{1,1,0}},"uint8"),2); same(np.any(a,{where=false}),false) end
do local a=np.zeros({2,0,3},"uint64"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{false}}}) end
do local a=np.array({{0,5,1},{0,0,-1}},"int8"); local v=np.any(a,{axis={1,2},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.array({{{0,1,-1},{-1,1,0}}},"int8"); local v=np.count_nonzero(a,{axis=2});assert(v.dtype=="int64")
same(v:tolist(),{{1,2,1}}) end
do local a=np.flip(np.zeros({2,0},"float16"),2); same(np.any(a),false) end
do local a=np.zeros({2,0},"int32"); same(np.any(a,{axis={1,2}}),false) end
do local a=np.array({1,9007199254740995},"int64"); same(np.count_nonzero(a),2) end
do local a=np.array({{1,0},{-1,1},{-1,0}},"int16"); local v=np.count_nonzero(a,{axis={1,2},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{4}}) end
do local a=np.zeros({2,0,3},"int16"); local v=np.any(a,{axis={},where=np.array({{{false,true,true}}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.array({{0},{1}},"uint64"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{false},{true}}) end
do local a=np.flip(np.zeros({2,0,3},"int8"),3); local v=np.any(a,{keepdims=true,where=false});assert(v.dtype=="bool")
same(v:tolist(),{{{false}}}) end
do local a=np.array({{"xyz","xyz"},{"xyz","XX"},{"","xyz"}},"S3"); local v=np.all(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{true,true,false}) end
do local a=np.zeros({0},"S3"); same(np.any(a,{axis={1},where=false}),false) end
do local a=np.array({{{0,1,1},{5,1,0}}},"uint64"); local v=np.all(a,{axis=3});assert(v.dtype=="bool")
same(v:tolist(),{{false,false}}) end
do local a=np.array({5,0,5,0},"int32"); same(np.any(a,{axis={1}}),true) end
do local a=np.transpose(np.zeros({2,0},"int64")); same(np.count_nonzero(a),0) end
do local a=np.array({{0,0},{1,1},{-1,0}},"int8"); local v=np.count_nonzero(a,{axis=2});assert(v.dtype=="int64")
same(v:tolist(),{0,2,1}) end
do local a=np.zeros({2,0,3},"float16"); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.transpose(np.array({{1,0,5},{5,1,-1}},"int64")); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{5}}) end
do local a=np.flip(np.array({np.complex(0.0,3.0),np.complex(0.0,0.0)},"complex128"),1); same(np.any(a),true) end
do local a=np.flip(np.array({-1},"int32"),1); same(np.any(a),true) end
do local a=np.zeros({0},"int8"); local v=np.any(a,{axis=1,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.zeros({0,3},"complex128"); local v=np.count_nonzero(a,{axis={1,2},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0}}) end
do local a=np.array({{0},{1}},"uint8"); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0},{1}}) end
do local a=np.transpose(np.zeros({0,3},"uint8")); local v=np.count_nonzero(a,{axis=1});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.transpose(np.array({{1,5,-1},{0,0,0}},"int16")); same(np.all(a),false) end
do local a=np.flip(np.zeros({2,0,3},"S3"),3); local v=np.all(a,{axis=3,where=true});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.transpose(np.zeros({2,0,3},"uint64")); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{},{},{}}) end
do local a=np.flip(np.array({{{0,0},{0,1},{0,0}},{{1,0},{-1,0},{-1,-1}}},"int8"),3); same(np.all(a,{axis={1,2,3},where=np.array({{{false,false}}},"bool")}),true) end
do local a=np.array({0,0},"int32"); local v=np.count_nonzero(a,{axis={1},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{0}) end
do local a=np.transpose(np.array({{"XX","","a"},{"a","",""}},"U3")); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.zeros({2,0},"float32"); same(np.count_nonzero(a),0) end
do local a=np.array({{"a","XX"},{"xyz","xyz"},{"xyz",""}},"U3"); same(np.all(a,{axis={1,2},where=false}),true) end
do local a=np.flip(np.zeros({2,0},"float64"),2); local v=np.any(a,{axis=2,where=np.array({{}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{false,false}) end
do local a=np.flip(np.array({0,-1},"int8"),1); same(np.all(a,{where=false}),true) end
do local a=np.array({np.complex(0.0,0.0)},"complex128"); same(np.count_nonzero(a,{axis=1}),0) end
do local a=np.array({{{0,0},{0,5},{0,0}},{{1,0},{1,-1},{-1,1}}},"int16"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{{0,0},{0,1},{0,0}},{{1,0},{1,1},{1,1}}}) end
do local a=np.array({{np.complex(-1.0,3.0),np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex(-1.0,0.0),np.complex((0/0),0.0),np.complex(0.0,0.0)}},"complex64"); same(np.all(a),false) end
do local a=np.zeros({2,0,3},"int16"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{false}}}) end
do local a=np.flip(np.zeros({2,0},"float32"),2); same(np.all(a,{where=np.array({{}},"bool")}),true) end
do local a=np.array("a","S3"); same(np.count_nonzero(a),1) end
do local a=np.array({{1},{0}},"uint8"); same(np.any(a,{axis={1,2}}),true) end
do local a=np.transpose(np.array({{""},{"XX"}},"U3")); local v=np.all(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{false,true}) end
do local a=np.array({{{0.0,0.0,4.0},{0.0,-0.0,math.huge}}},"float64"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{{0,0,1},{0,0,1}}}) end
do local a=np.array(0,"uint8"); same(np.any(a,{keepdims=true}),false) end
do local a=np.zeros({0},"bool"); local v=np.all(a,{axis={},keepdims=true,where=np.array({},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.array({{0,5,1},{0,0,0}},"int32"); local v=np.all(a,{axis={1,2},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.flip(np.array({{0,0,1},{0,0,0}},"int16"),2); local v=np.all(a,{axis={},where=true});assert(v.dtype=="bool")
same(v:tolist(),{{true,false,false},{false,false,false}}) end
do local a=np.zeros({2,0},"int8"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.array({{0},{1}},"int8"); same(np.any(a),true) end
do local a=np.flip(np.array({0,0},"int32"),1); same(np.any(a,{axis=1,where=np.array({true,false},"bool")}),false) end
do local a=np.zeros({0,3},"bool"); same(np.all(a,{axis={1,2}}),true) end
do local a=np.flip(np.array({{0.0,4.0,0.0},{4.0,-2.0,4.0}},"float64"),2); same(np.count_nonzero(a),4) end
do local a=np.flip(np.array({{{"xyz","xyz",""},{"","XX",""}}},"S3"),3); same(np.any(a),true) end
do local a=np.array({1,0},"uint64"); same(np.any(a),true) end
do local a=np.zeros({0},"uint64"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.zeros({0},"int32"); same(np.all(a),true) end
do local a=np.flip(np.zeros({0},"float64"),1); same(np.all(a),true) end
do local a=np.array({{{0,0,1},{0,-1,1}}},"int8"); same(np.all(a,{where=false}),true) end
do local a=np.array(4.0,"float32"); same(np.all(a,{axis={},keepdims=true}),true) end
do local a=np.array({0,-1,-1,1},"int32"); same(np.any(a,{where=np.array({true,false,false,false},"bool")}),false) end
do local a=np.array({{-1},{0}},"int32"); same(np.count_nonzero(a),1) end
do local a=np.array({{"a",""},{"a","XX"},{"","xyz"}},"U3"); local v=np.all(a,{keepdims=true,where=np.array({{false,false}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.transpose(np.zeros({2,0},"U3")); same(np.count_nonzero(a),0) end
do local a=np.zeros({0,3},"uint64"); local v=np.count_nonzero(a,{axis={1,2},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0}}) end
do local a=np.zeros({2,0},"float64"); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.array({{0,-1},{5,-1},{0,-1}},"int8"); local v=np.any(a,{axis=2,keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{{true},{true},{true}}) end
do local a=np.flip(np.zeros({2,0},"complex128"),2); local v=np.count_nonzero(a,{axis=2,keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0},{0}}) end
do local a=np.zeros({0,3},"float64"); same(np.count_nonzero(a,{axis={1,2}}),0) end
do local a=np.flip(np.array({{"","xyz"},{"xyz","a"},{"",""}},"S3"),2); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{1,0},{1,1},{0,0}}) end
do local a=np.transpose(np.array({{np.complex((0/0),3.0)},{np.complex(2.0,0.0)}},"complex64")); same(np.count_nonzero(a),2) end
do local a=np.zeros({0},"float16"); local v=np.all(a,{axis={},where=true});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.array({{{0,0},{0,0},{-1,5}},{{0,-1},{-1,1},{1,0}}},"int16"); same(np.count_nonzero(a),6) end
do local a=np.flip(np.zeros({2,0},"complex64"),2); local v=np.any(a,{axis={1,2},keepdims=true,where=np.zeros({2,0},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.flip(np.array({{(0/0)},{-0.0}},"float32"),2); same(np.count_nonzero(a),1) end
do local a=np.array({4.0},"float64"); same(np.any(a),true) end
do local a=np.array({{{"xyz","XX"},{"a","a"},{"",""}},{{"XX",""},{"XX",""},{"",""}}},"S3"); local v=np.any(a,{axis=2,where=false});assert(v.dtype=="bool")
same(v:tolist(),{{false,false},{false,false}}) end
do local a=np.flip(np.array({0,0},"int16"),1); same(np.any(a,{axis={1}}),false) end
do local a=np.transpose(np.array({{{(0/0),math.huge,0.0},{-2.0,0.0,(0/0)}}},"float32")); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{4}}}) end
do local a=np.flip(np.zeros({0},"int16"),1); same(np.count_nonzero(a),0) end
do local a=np.array({{0},{5}},"uint8"); local v=np.count_nonzero(a,{axis=2});assert(v.dtype=="int64")
same(v:tolist(),{0,1}) end
do local a=np.array("xyz","U3"); same(np.all(a),true) end
do local a=np.array({{0},{5}},"int64"); local v=np.all(a,{axis=2,where=np.array({{false}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{true,true}) end
do local a=np.array(1,"int64"); same(np.count_nonzero(a,{axis={}}),1) end
do local a=np.flip(np.zeros({0},"float16"),1); same(np.any(a),false) end
do local a=np.array({1},"uint64"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array({{{1,1},{0,1},{0,1}},{{0,1},{0,1},{0,0}}},"uint8"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{false}}}) end
do local a=np.array({np.complex(0.0,0.0),np.complex(0.0,3.0),np.complex(2.0,0.0),np.complex((0/0),3.0)},"complex64"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{false,true,true,true}) end
do local a=np.array({{-1,1},{1,0},{0,-1}},"int64"); same(np.count_nonzero(a),4) end
do local a=np.array({5,0,0,5},"int8"); same(np.all(a,{axis=1,where=true}),false) end
do local a=np.array({{{4.0,(0/0),-0.0},{-0.0,0.0,-0.0}}},"float32"); same(np.count_nonzero(a,{axis={1,2,3}}),2) end
do local a=np.array({np.complex(0.0,3.0),np.complex(0.0,0.0)},"complex128"); same(np.count_nonzero(a),1) end
do local a=np.flip(np.zeros({2,0},"int32"),2); local v=np.any(a,{axis={},keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.transpose(np.zeros({2,0,3},"int8")); local v=np.any(a,{axis={},where=true});assert(v.dtype=="bool")
same(v:tolist(),{{},{},{}}) end
do local a=np.flip(np.array({{0},{0}},"int64"),2); local v=np.all(a,{axis={},where=np.array({{false},{false}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{true},{true}}) end
do local a=np.array({{"XX"},{"a"}},"U3"); same(np.all(a,{where=np.array({{false}},"bool")}),true) end
do local a=np.flip(np.zeros({2,0,3},"S3"),3); local v=np.any(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{{false,false,false},{false,false,false}}) end
do local a=np.flip(np.array({{{true,true},{true,true},{false,false}},{{false,false},{true,false},{false,false}}},"bool"),3); same(np.any(a),true) end
do local a=np.array({0.0},"float16"); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{0}) end
do local a=np.flip(np.zeros({0},"bool"),1); local v=np.all(a,{axis={},where=true});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.array({"XX","a"},"S3"); same(np.count_nonzero(a),2) end
do local a=np.flip(np.array({{{0,9007199254740995,9007199254740995},{1,0,1}}},"int64"),3); local v=np.all(a,{keepdims=true,where=np.array({{{false,false,false},{true,false,false}}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{{true}}}) end
do local a=np.transpose(np.array({{{0.0,-2.0},{4.0,math.huge},{0.0,4.0}},{{4.0,math.huge},{(0/0),math.huge},{4.0,0.0}}},"float64")); same(np.all(a,{where=true}),false) end
do local a=np.array({{{1,1,0},{1,0,1}}},"uint64"); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{{true,true,false},{true,false,true}}}) end
do local a=np.array({{{false,false},{false,true},{false,true}},{{true,false},{true,false},{false,false}}},"bool"); same(np.count_nonzero(a),4) end
do local a=np.flip(np.zeros({2,0,3},"float32"),3); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{false}}}) end
do local a=np.zeros({0},"float32"); local v=np.any(a,{keepdims=true,where=false});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.array({np.complex(2.0,3.0),np.complex(0.0,0.0)},"complex128"); same(np.count_nonzero(a),1) end
do local a=np.array({0,0,-1,5},"int32"); same(np.any(a,{axis={1},where=np.array({false,true,true,false},"bool")}),true) end
do local a=np.flip(np.array({{4.0,(0/0)},{0.0,-0.0},{-2.0,0.0}},"float32"),2); local v=np.any(a,{axis=1,where=np.array({{false,false}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{false,false}) end
do local a=np.array({{true,true,false},{true,false,false}},"bool"); local v=np.count_nonzero(a,{axis=1});assert(v.dtype=="int64")
same(v:tolist(),{2,1,0}) end
do local a=np.array({"XX","","",""},"U3"); same(np.count_nonzero(a,{axis={1}}),1) end
do local a=np.array({{-2.0,0.0,math.huge},{0.0,0.0,-2.0}},"float64"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{true,false,true},{false,false,true}}) end
do local a=np.transpose(np.array({{{5,0},{0,0},{-1,0}},{{1,-1},{0,-1},{5,0}}},"int8")); same(np.all(a),false) end
do local a=np.array({true,false,true,true},"bool"); local v=np.any(a,{keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.flip(np.array({{{0,9007199254740995},{1,1},{1,1}},{{0,9007199254740995},{1,9007199254740995},{0,1}}},"uint64"),3); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{{true,false},{true,true},{true,true}},{{true,false},{true,true},{true,false}}}) end
do local a=np.array({(0/0),-2.0},"float16"); same(np.count_nonzero(a),2) end
do local a=np.zeros({2,0,3},"int16"); same(np.any(a),false) end
do local a=np.zeros({0},"float64"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.array({0,0,1,1},"uint8"); same(np.any(a),true) end
do local a=np.zeros({0},"complex64"); same(np.count_nonzero(a,{axis=1}),0) end
do local a=np.array({-2.0,(0/0)},"float32"); local v=np.count_nonzero(a,{axis=1,keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{2}) end
do local a=np.zeros({0},"U3"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.zeros({2,0,3},"int64"); same(np.all(a,{where=np.array({{{false,true,false}}},"bool")}),true) end
do local a=np.zeros({0,3},"complex64"); same(np.all(a,{axis={1,2},where=np.array({{false,false,true}},"bool")}),true) end
do local a=np.array(-2.0,"float32"); same(np.count_nonzero(a,{axis={}}),1) end
do local a=np.zeros({0},"complex128"); same(np.any(a,{where=np.array({},"bool")}),false) end
do local a=np.transpose(np.array({{"XX"},{""}},"S3")); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.flip(np.array({0.0},"float32"),1); same(np.count_nonzero(a),0) end
do local a=np.flip(np.array({{np.complex((0/0),0.0),np.complex(0.0,0.0)},{np.complex((0/0),3.0),np.complex(0.0,0.0)},{np.complex(-1.0,3.0),np.complex(2.0,0.0)}},"complex128"),2); same(np.any(a,{axis={1,2}}),true) end
do local a=np.zeros({0,3},"int16"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0}}) end
do local a=np.array({{{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(-1.0,3.0)},{np.complex((0/0),0.0),np.complex(2.0,0.0),np.complex(0.0,0.0)}}},"complex64"); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{0,0,1},{1,1,0}}}) end
do local a=np.zeros({2,0},"U3"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.flip(np.array({5},"int16"),1); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{1}) end
do local a=np.zeros({0},"U3"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{0}) end
do local a=np.array({4.0},"float64"); same(np.all(a),true) end
do local a=np.flip(np.zeros({0,3},"complex64"),2); same(np.all(a,{axis={1,2},where=true}),true) end
do local a=np.array({0},"int64"); local v=np.any(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.array({{{np.complex(0.0,0.0),np.complex((0/0),0.0),np.complex(0.0,0.0)},{np.complex(2.0,0.0),np.complex(0.0,0.0),np.complex(2.0,0.0)}}},"complex128"); same(np.any(a),true) end
do local a=np.zeros({0,3},"int32"); same(np.any(a),false) end
do local a=np.array({{{1,1,0},{0,-1,0}}},"int8"); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{{true,true,false},{false,true,false}}}) end
do local a=np.array({{{np.complex((0/0),0.0),np.complex(0.0,0.0),np.complex((0/0),0.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}}},"complex64"); same(np.count_nonzero(a),2) end
do local a=np.flip(np.zeros({0,3},"uint64"),2); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.array({false},"bool"); same(np.all(a),false) end
do local a=np.zeros({0,3},"int64"); same(np.all(a,{where=true}),true) end
do local a=np.array({{{0,0},{9007199254740995,9007199254740995},{0,0}},{{0,0},{0,5},{9007199254740995,5}}},"uint64"); same(np.all(a),false) end
do local a=np.transpose(np.array({{-0.0,-2.0},{math.huge,(0/0)},{(0/0),0.0}},"float64")); local v=np.all(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{false,false}) end
do local a=np.zeros({0},"int8"); same(np.all(a,{axis=1}),true) end
do local a=np.array({{{math.huge,0.0},{(0/0),4.0},{-0.0,-0.0}},{{-2.0,4.0},{0.0,-0.0},{4.0,0.0}}},"float32"); local v=np.any(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{{true,true},{true,true},{true,false}}) end
do local a=np.zeros({0},"uint8"); same(np.all(a,{where=true}),true) end
do local a=np.array({np.complex(0.0,3.0)},"complex64"); same(np.any(a,{axis=1}),true) end
do local a=np.array({np.complex(0.0,0.0),np.complex(0.0,3.0)},"complex64"); same(np.all(a,{axis=1,where=np.array({true,true},"bool")}),false) end
do local a=np.array({(0/0)},"float16"); local v=np.any(a,{axis={1},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.transpose(np.array({{{0.0,0.0,(0/0)},{(0/0),4.0,(0/0)}}},"float16")); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{true}}}) end
do local a=np.transpose(np.zeros({0,3},"U3")); same(np.count_nonzero(a),0) end
do local a=np.transpose(np.zeros({2,0},"float32")); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.zeros({2,0,3},"complex128"); same(np.any(a,{where=np.array({{{false,false,true}}},"bool")}),false) end
do local a=np.flip(np.array({{{np.complex(0.0,0.0),np.complex(2.0,0.0),np.complex((0/0),0.0)},{np.complex((0/0),0.0),np.complex(-1.0,0.0),np.complex(2.0,0.0)}}},"complex128"),3); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{true}}}) end
do local a=np.array({"a",""},"U3"); same(np.count_nonzero(a,{axis=1}),1) end
do local a=np.array({"xyz"},"U3"); same(np.count_nonzero(a),1) end
do local a=np.flip(np.array({{0.0,-2.0},{4.0,0.0},{0.0,math.huge}},"float64"),2); same(np.any(a),true) end
do local a=np.array(5,"uint64"); same(np.any(a,{where=false}),false) end
do local a=np.array({4.0,-0.0,-0.0,4.0},"float64"); local v=np.all(a,{axis={},where=np.array({false,false,true,false},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{true,true,false,true}) end
do local a=np.flip(np.zeros({2,0},"complex64"),2); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.flip(np.zeros({2,0,3},"int16"),3); same(np.all(a),true) end
do local a=np.array({5},"int32"); same(np.count_nonzero(a),1) end
do local a=np.array({{1,0,0},{5,0,0}},"uint8"); same(np.all(a),false) end
do local a=np.array({{-2.0,math.huge,-0.0},{0.0,-0.0,-2.0}},"float32"); same(np.any(a),true) end
do local a=np.array({{"xyz","","xyz"},{"xyz","XX","a"}},"U3"); same(np.any(a,{axis={1,2},where=false}),false) end
do local a=np.flip(np.zeros({2,0},"S3"),2); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.flip(np.array({{{0,0,1},{0,0,-1}}},"int8"),3); same(np.any(a,{axis={1,2,3},where=false}),false) end
do local a=np.flip(np.array({{-0.0,0.0,0.0},{4.0,-2.0,4.0}},"float16"),2); same(np.any(a,{axis={1,2}}),true) end
do local a=np.flip(np.array({0,-1},"int16"),1); same(np.all(a,{where=np.array({true,false},"bool")}),true) end
do local a=np.zeros({0},"S3"); local v=np.all(a,{axis={},where=false});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.zeros({2,0,3},"int64"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{},{}}) end
do local a=np.array({0,1},"int16"); same(np.count_nonzero(a,{axis=1}),1) end
do local a=np.flip(np.zeros({0,3},"int8"),2); local v=np.all(a,{axis={1,2},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.flip(np.array({{0,0},{0,9007199254740995},{5,1}},"int64"),2); same(np.any(a,{where=false}),false) end
do local a=np.flip(np.zeros({2,0},"uint8"),2); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{},{}}) end
do local a=np.transpose(np.zeros({2,0},"float32")); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.flip(np.array({{{0,5},{9007199254740995,1},{9007199254740995,9007199254740995}},{{5,1},{0,1},{0,0}}},"uint64"),3); local v=np.all(a,{axis={},keepdims=true,where=np.array({{{false,true},{false,false},{true,false}},{{true,true},{false,true},{false,true}}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{{true,false},{true,true},{true,true}},{{true,true},{true,false},{true,false}}}) end
do local a=np.zeros({0},"S3"); same(np.any(a),false) end
do local a=np.flip(np.array({{{np.complex(-1.0,3.0),np.complex(0.0,0.0)},{np.complex(0.0,3.0),np.complex(-1.0,3.0)},{np.complex(0.0,0.0),np.complex(2.0,0.0)}},{{np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex(0.0,0.0),np.complex(0.0,3.0)},{np.complex(0.0,0.0),np.complex((0/0),3.0)}}},"complex128"),3); same(np.count_nonzero(a),6) end
do local a=np.array({"xyz",""},"S3"); same(np.any(a),true) end
do local a=np.zeros({0,3},"S3"); same(np.all(a),true) end
do local a=np.flip(np.array({{0,0},{-1,5},{0,0}},"int8"),2); same(np.all(a),false) end
do local a=np.flip(np.zeros({2,0},"int32"),2); same(np.count_nonzero(a,{axis={1,2}}),0) end
do local a=np.transpose(np.array({{{-0.0,(0/0),-2.0},{-2.0,-0.0,math.huge}}},"float32")); same(np.all(a),false) end
do local a=np.transpose(np.zeros({0,3},"uint64")); same(np.all(a),true) end
do local a=np.zeros({2,0,3},"complex64"); local v=np.all(a,{axis=3,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.array({{""},{""}},"U3"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.flip(np.array({math.huge},"float64"),1); same(np.count_nonzero(a,{axis={1}}),1) end
do local a=np.array({{np.complex(-1.0,0.0),np.complex(0.0,3.0),np.complex(0.0,0.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex((0/0),3.0)}},"complex128"); same(np.any(a),true) end
do local a=np.flip(np.array({1},"int8"),1); local v=np.all(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array(np.complex(0.0,3.0),"complex64"); same(np.count_nonzero(a),1) end
do local a=np.flip(np.array({9007199254740995,0,-1,0},"int64"),1); same(np.count_nonzero(a),2) end
do local a=np.flip(np.array({{-2.0,math.huge},{(0/0),math.huge},{(0/0),0.0}},"float64"),2); local v=np.any(a,{axis={1,2},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.zeros({2,0},"int16"); local v=np.any(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{false,false}) end
do local a=np.zeros({2,0},"uint8"); local v=np.any(a,{keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.array({0},"int32"); same(np.all(a,{axis=1}),false) end
do local a=np.array({{{4.0,0.0},{0.0,0.0},{4.0,-2.0}},{{4.0,(0/0)},{0.0,(0/0)},{-0.0,(0/0)}}},"float32"); same(np.all(a),false) end
do local a=np.array({"xyz","xyz"},"U3"); same(np.any(a,{axis={1}}),true) end
do local a=np.flip(np.array({{{5,0,1},{0,5,0}}},"uint64"),3); same(np.count_nonzero(a),3) end
do local a=np.array({0,0,0,-1},"int16"); same(np.count_nonzero(a,{axis=1}),1) end
do local a=np.array(0.0,"float64"); same(np.all(a,{keepdims=true,where=np.array(true,"bool")}),false) end
do local a=np.array({{-1,0,9007199254740995},{0,1,0}},"int64"); same(np.count_nonzero(a),3) end
do local a=np.zeros({2,0,3},"float16"); same(np.count_nonzero(a),0) end
do local a=np.flip(np.array({0},"int64"),1); same(np.count_nonzero(a),0) end
do local a=np.transpose(np.zeros({2,0,3},"S3")); same(np.all(a,{axis={1,2,3}}),true) end
do local a=np.array({0.0},"float32"); same(np.count_nonzero(a),0) end
do local a=np.flip(np.zeros({0},"bool"),1); same(np.any(a,{axis=1}),false) end
do local a=np.array({{1,9007199254740995},{1,0},{1,9007199254740995}},"uint64"); same(np.count_nonzero(a),5) end
do local a=np.array({{{0,0},{0,-1},{0,0}},{{-1,0},{-1,0},{-1,5}}},"int32"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{false}}}) end
do local a=np.flip(np.zeros({2,0,3},"float64"),3); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.array(math.huge,"float32"); same(np.count_nonzero(a,{axis={}}),1) end
do local a=np.flip(np.zeros({2,0,3},"U3"),3); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{0}}}) end
do local a=np.transpose(np.zeros({0,3},"int64")); same(np.count_nonzero(a),0) end
do local a=np.array({-1,0,0,0},"int64"); same(np.count_nonzero(a),1) end
do local a=np.array({-1,1},"int64"); local v=np.all(a,{keepdims=true,where=np.array({true,false},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array({0,0},"int8"); same(np.count_nonzero(a),0) end
do local a=np.transpose(np.array({{0,5,0},{-1,0,1}},"int8")); same(np.count_nonzero(a),3) end
do local a=np.transpose(np.zeros({2,0,3},"U3")); same(np.all(a,{axis={1,2,3}}),true) end
do local a=np.zeros({2,0,3},"int32"); same(np.any(a),false) end
do local a=np.array({{1,1,0},{0,0,0}},"int64"); same(np.any(a,{where=true}),true) end
do local a=np.flip(np.array({0,5},"int32"),1); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{1}) end
do local a=np.zeros({0,3},"int16"); same(np.count_nonzero(a),0) end
do local a=np.zeros({0},"bool"); same(np.all(a,{axis={1}}),true) end
do local a=np.zeros({2,0},"uint64"); same(np.any(a),false) end
do local a=np.transpose(np.array({{{0.0,0.0},{(0/0),-2.0},{0.0,math.huge}},{{-0.0,0.0},{-2.0,(0/0)},{math.huge,4.0}}},"float32")); same(np.any(a,{where=true}),true) end
do local a=np.flip(np.array({1},"int32"),1); same(np.all(a,{axis={1},where=np.array({true},"bool")}),true) end
do local a=np.zeros({2,0},"complex64"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0}}) end
do local a=np.transpose(np.zeros({0,3},"int16")); same(np.all(a,{where=np.zeros({3,0},"bool")}),true) end
do local a=np.array({0,0},"int64"); same(np.count_nonzero(a,{axis=1}),0) end
do local a=np.transpose(np.zeros({2,0,3},"bool")); local v=np.all(a,{axis=3,where=np.zeros({3,0,2},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{},{},{}}) end
do local a=np.zeros({2,0,3},"float32"); same(np.any(a,{axis={1,2,3}}),false) end
do local a=np.array({0,0,1,5},"int64"); same(np.all(a),false) end
do local a=np.array({"a"},"S3"); local v=np.all(a,{axis={1},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array({0},"int16"); same(np.any(a),false) end
do local a=np.array({{-0.0,math.huge},{(0/0),4.0},{-2.0,math.huge}},"float64"); same(np.all(a,{where=true}),false) end
do local a=np.zeros({0},"uint64"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.array({np.complex(0.0,0.0),np.complex((0/0),0.0),np.complex((0/0),3.0),np.complex(2.0,3.0)},"complex128"); local v=np.all(a,{axis={},where=np.array({true,false,true,true},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{false,true,true,true}) end
do local a=np.zeros({2,0,3},"float32"); same(np.any(a),false) end
do local a=np.array({4.0,-2.0,4.0,0.0},"float16"); same(np.all(a,{axis={1}}),false) end
do local a=np.transpose(np.array({{"XX","a"},{"","xyz"},{"",""}},"S3")); local v=np.any(a,{axis=2,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true},{true}}) end
do local a=np.flip(np.zeros({0},"bool"),1); same(np.count_nonzero(a),0) end
do local a=np.zeros({2,0},"float32"); same(np.any(a),false) end
do local a=np.transpose(np.array({{{5,1,0},{5,0,0}}},"int8")); same(np.all(a,{axis={1,2,3}}),false) end
do local a=np.flip(np.array({{4.0,0.0},{0.0,0.0},{0.0,-2.0}},"float32"),2); local v=np.all(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{false,false}) end
do local a=np.flip(np.zeros({2,0,3},"int16"),3); local v=np.count_nonzero(a,{axis=2});assert(v.dtype=="int64")
same(v:tolist(),{{0,0,0},{0,0,0}}) end
do local a=np.zeros({2,0,3},"float32"); same(np.any(a,{axis={1,2,3}}),false) end
do local a=np.flip(np.array({{1},{1}},"int8"),2); same(np.count_nonzero(a),2) end
do local a=np.array(1,"uint64"); same(np.any(a),true) end
do local a=np.array({{0,1,0},{-1,-1,0}},"int8"); same(np.any(a),true) end
do local a=np.array({{0,0},{-1,5},{0,1}},"int16"); local v=np.any(a,{keepdims=true,where=false});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.flip(np.zeros({2,0,3},"bool"),3); local v=np.any(a,{keepdims=true,where=np.zeros({2,0,3},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{{false}}}) end
do local a=np.flip(np.array({"XX","XX"},"S3"),1); same(np.any(a),true) end
do local a=np.zeros({0,3},"float32"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0}}) end
do local a=np.transpose(np.array({{{(0/0),4.0,0.0},{0.0,0.0,math.huge}}},"float32")); same(np.count_nonzero(a),3) end
do local a=np.array("","S3"); same(np.count_nonzero(a),0) end
do local a=np.array("a","U3"); same(np.all(a,{axis={},keepdims=true,where=true}),true) end
do local a=np.array(5,"int64"); same(np.any(a,{keepdims=true,where=np.array(false,"bool")}),false) end
do local a=np.flip(np.array({{0.0,-2.0},{-0.0,math.huge},{-2.0,-2.0}},"float32"),2); local v=np.all(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{false,false,true}) end
do local a=np.array({{true},{false}},"bool"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.array({1,5,1,0},"int32"); same(np.any(a),true) end
do local a=np.array({{math.huge,-0.0},{-2.0,4.0},{-0.0,0.0}},"float64"); same(np.all(a,{where=np.array({{true,false}},"bool")}),false) end
do local a=np.array({{true},{true}},"bool"); same(np.any(a,{axis={1,2}}),true) end
do local a=np.flip(np.array({-2.0,0.0,math.huge,-2.0},"float64"),1); same(np.all(a,{axis={1},where=np.array({false,true,false,false},"bool")}),true) end
do local a=np.flip(np.array({0,5},"uint64"),1); same(np.all(a,{axis={1}}),false) end
do local a=np.transpose(np.array({{np.complex(0.0,3.0)},{np.complex((0/0),0.0)}},"complex64")); same(np.all(a),true) end
do local a=np.array(4.0,"float32"); same(np.any(a,{axis={}}),true) end
do local a=np.array({1,9007199254740995,1,0},"uint64"); same(np.all(a),false) end
do local a=np.array({"XX","XX","XX","xyz"},"S3"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.transpose(np.zeros({2,0},"int32")); local v=np.any(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.transpose(np.array({{{0.0,-0.0,(0/0)},{0.0,4.0,0.0}}},"float64")); same(np.all(a),false) end
do local a=np.array(0,"uint8"); same(np.count_nonzero(a),0) end
do local a=np.zeros({2,0,3},"int64"); same(np.count_nonzero(a),0) end
do local a=np.flip(np.array({{-0.0,0.0},{0.0,-2.0},{(0/0),-2.0}},"float16"),2); same(np.count_nonzero(a),3) end
do local a=np.transpose(np.zeros({2,0},"int16")); same(np.count_nonzero(a),0) end
do local a=np.zeros({0},"int64"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array({{np.complex(0.0,3.0),np.complex(0.0,0.0),np.complex(0.0,3.0)},{np.complex(0.0,0.0),np.complex(2.0,0.0),np.complex(0.0,0.0)}},"complex64"); same(np.any(a,{axis={1,2}}),true) end
do local a=np.zeros({2,0},"S3"); same(np.all(a),true) end
do local a=np.flip(np.zeros({0,3},"int8"),2); local v=np.count_nonzero(a,{axis=1});assert(v.dtype=="int64")
same(v:tolist(),{0,0,0}) end
do local a=np.array({true},"bool"); same(np.all(a,{where=np.array({false},"bool")}),true) end
do local a=np.array({0},"uint8"); same(np.all(a,{where=true}),false) end
do local a=np.flip(np.array({{"","","XX"},{"a","xyz","XX"}},"S3"),2); same(np.any(a),true) end
do local a=np.array({1,0},"int32"); same(np.count_nonzero(a,{axis={1}}),1) end
do local a=np.transpose(np.array({{-1},{5}},"int32")); same(np.count_nonzero(a,{axis={1,2}}),2) end
do local a=np.zeros({2,0},"complex64"); same(np.all(a,{where=np.array({{}},"bool")}),true) end
do local a=np.transpose(np.zeros({2,0,3},"S3")); same(np.any(a),false) end
do local a=np.array({{0,0},{1,0},{5,5}},"uint8"); local v=np.count_nonzero(a,{axis=2});assert(v.dtype=="int64")
same(v:tolist(),{0,1,2}) end
do local a=np.flip(np.array({{"a"},{"XX"}},"U3"),2); local v=np.all(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array({0.0,-2.0,(0/0),0.0},"float16"); same(np.any(a),true) end
do local a=np.zeros({2,0,3},"float32"); same(np.all(a),true) end
do local a=np.transpose(np.array({{-0.0},{4.0}},"float32")); same(np.all(a),false) end
do local a=np.flip(np.zeros({2,0},"int16"),2); local v=np.any(a,{axis={1,2},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.array({{0.0,(0/0)},{math.huge,math.huge},{math.huge,0.0}},"float16"); same(np.any(a,{axis={1,2}}),true) end
do local a=np.array({4.0,4.0},"float64"); same(np.count_nonzero(a),2) end
do local a=np.flip(np.zeros({2,0},"complex64"),2); same(np.all(a,{where=true}),true) end
do local a=np.flip(np.array({-1},"int16"),1); same(np.any(a,{axis=1}),true) end
do local a=np.array({{{math.huge,4.0},{-2.0,math.huge},{4.0,0.0}},{{math.huge,-2.0},{-0.0,4.0},{(0/0),-2.0}}},"float32"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{false}}}) end
do local a=np.array({{0.0,-0.0},{-0.0,math.huge},{math.huge,(0/0)}},"float16"); same(np.all(a),false) end
do local a=np.array(np.complex(-1.0,3.0),"complex128"); same(np.count_nonzero(a,{keepdims=true}),1) end
do local a=np.flip(np.array({{0},{0}},"uint8"),2); same(np.all(a,{where=false}),true) end
do local a=np.transpose(np.array({{np.complex((0/0),0.0),np.complex(0.0,0.0)},{np.complex(2.0,0.0),np.complex(-1.0,3.0)},{np.complex((0/0),3.0),np.complex((0/0),3.0)}},"complex64")); same(np.count_nonzero(a),5) end
do local a=np.array({math.huge,0.0,4.0,4.0},"float16"); same(np.count_nonzero(a),3) end
do local a=np.zeros({0,3},"uint8"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0}}) end
do local a=np.zeros({0},"bool"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.flip(np.zeros({2,0},"bool"),2); same(np.all(a,{where=np.zeros({2,0},"bool")}),true) end
do local a=np.array({{-0.0},{0.0}},"float32"); same(np.any(a,{where=np.array({{false},{true}},"bool")}),false) end
do local a=np.array({0.0,(0/0),(0/0),-0.0},"float16"); local v=np.any(a,{axis={},where=np.array({true,true,false,false},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{false,true,false,false}) end
do local a=np.flip(np.array({{{0,5},{0,0},{5,0}},{{1,0},{1,0},{0,5}}},"uint8"),3); local v=np.all(a,{axis=1,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{false,false},{false,false},{false,false}}}) end
do local a=np.transpose(np.array({{{4.0,4.0},{-0.0,math.huge},{0.0,(0/0)}},{{0.0,4.0},{4.0,(0/0)},{-2.0,(0/0)}}},"float64")); same(np.all(a,{where=true}),false) end
do local a=np.flip(np.array({{0,0},{0,1},{0,0}},"uint64"),2); same(np.all(a),false) end
do local a=np.array({true,false,true,false},"bool"); same(np.all(a,{axis=1}),false) end
do local a=np.transpose(np.array({{0.0},{-0.0}},"float64")); local v=np.any(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.array({{5},{5}},"int32"); same(np.any(a),true) end
do local a=np.flip(np.array({{np.complex(0.0,0.0)},{np.complex((0/0),0.0)}},"complex64"),2); same(np.count_nonzero(a),1) end
do local a=np.zeros({2,0,3},"float64"); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.flip(np.zeros({0,3},"complex64"),2); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.flip(np.zeros({2,0,3},"uint64"),3); same(np.all(a,{where=np.zeros({2,0,3},"bool")}),true) end
do local a=np.transpose(np.array({{{np.complex(0.0,3.0),np.complex(-1.0,0.0),np.complex(-1.0,0.0)},{np.complex(-1.0,0.0),np.complex(-1.0,0.0),np.complex(2.0,3.0)}}},"complex128")); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{6}}}) end
do local a=np.transpose(np.array({{{"a","a"},{"a","a"},{"XX","a"}},{{"xyz","xyz"},{"xyz",""},{"","XX"}}},"U3")); local v=np.any(a,{keepdims=true,where=false});assert(v.dtype=="bool")
same(v:tolist(),{{{false}}}) end
do local a=np.array({-1,0,5,0},"int32"); same(np.any(a),true) end
do local a=np.flip(np.zeros({2,0,3},"int16"),3); same(np.any(a,{axis={1,2,3},where=true}),false) end
do local a=np.zeros({0},"int64"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array({{-1,0,1},{0,0,0}},"int32"); same(np.any(a),true) end
do local a=np.zeros({0},"float64"); same(np.all(a),true) end
do local a=np.array({np.complex(-1.0,3.0)},"complex64"); same(np.all(a,{axis=1}),true) end
do local a=np.array(0,"int64"); same(np.any(a,{axis={},keepdims=true,where=np.array(true,"bool")}),false) end
do local a=np.transpose(np.array({{{np.complex(0.0,0.0),np.complex(-1.0,0.0),np.complex(-1.0,3.0)},{np.complex(-1.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}}},"complex64")); same(np.count_nonzero(a,{axis={1,2,3}}),3) end
do local a=np.array({{1},{1}},"uint64"); local v=np.count_nonzero(a,{axis={1,2},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{2}}) end
do local a=np.flip(np.zeros({0,3},"uint8"),2); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.transpose(np.array({{5},{1}},"uint64")); local v=np.any(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{true,true}) end
do local a=np.zeros({2,0,3},"uint8"); same(np.any(a),false) end
do local a=np.array({{5,0,0},{5,1,5}},"int32"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{1,0,0},{1,1,1}}) end
do local a=np.transpose(np.array({{9007199254740995,1,9007199254740995},{1,0,0}},"int64")); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{4}}) end
do local a=np.zeros({0},"int8"); same(np.count_nonzero(a,{axis={1}}),0) end
do local a=np.flip(np.array({-0.0,math.huge,0.0,0.0},"float16"),1); same(np.any(a,{where=np.array({false,true,false,true},"bool")}),false) end
do local a=np.flip(np.array({{9007199254740995,1,9007199254740995},{-1,0,-1}},"int64"),2); same(np.count_nonzero(a),5) end
do local a=np.array({{math.huge,(0/0)},{(0/0),0.0},{-2.0,0.0}},"float64"); local v=np.any(a,{axis={},where=np.array({{true,true},{true,true},{false,true}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{true,true},{true,false},{false,false}}) end
do local a=np.transpose(np.array({{0},{5}},"int8")); local v=np.all(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{false,true}) end
do local a=np.array({{0.0,-0.0},{4.0,4.0},{math.huge,-0.0}},"float16"); same(np.count_nonzero(a),3) end
do local a=np.flip(np.zeros({0},"complex128"),1); local v=np.any(a,{axis={},where=np.zeros({0},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.array({0,0},"int32"); same(np.count_nonzero(a,{axis={1}}),0) end
do local a=np.flip(np.array({{{false,false,false},{false,false,true}}},"bool"),3); same(np.count_nonzero(a),1) end
do local a=np.transpose(np.array({{{5,-1,0},{0,0,5}}},"int16")); local v=np.all(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{{false},{false},{false}}) end
do local a=np.zeros({0,3},"U3"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0}}) end
do local a=np.flip(np.array({{0,0},{0,1},{1,9007199254740995}},"uint64"),2); same(np.count_nonzero(a),3) end
do local a=np.array(1,"int64"); same(np.any(a,{keepdims=true}),true) end
do local a=np.flip(np.zeros({0},"complex64"),1); local v=np.count_nonzero(a,{axis={1},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{0}) end
do local a=np.flip(np.zeros({2,0,3},"int32"),3); same(np.all(a,{where=np.array({{{false,true,true}}},"bool")}),true) end
do local a=np.transpose(np.array({{5,1,0},{0,0,0}},"int8")); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.flip(np.array({{0.0},{(0/0)}},"float16"),2); same(np.all(a),false) end
do local a=np.flip(np.array({9007199254740995,9007199254740995},"int64"),1); same(np.count_nonzero(a,{axis={1}}),2) end
do local a=np.array(0,"uint8"); same(np.any(a),false) end
do local a=np.flip(np.array({{true,true},{false,true},{true,false}},"bool"),2); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.array({{0},{0}},"int32"); same(np.any(a),false) end
do local a=np.array({{-1,1},{-1,-1},{0,-1}},"int32"); local v=np.all(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{false,true}) end
do local a=np.array({{0,0,0},{0,-1,-1}},"int32"); same(np.any(a),true) end
do local a=np.flip(np.array({{math.huge,0.0,-0.0},{0.0,(0/0),-2.0}},"float64"),2); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{0,0,1},{1,1,0}}) end
do local a=np.array({{5,0},{5,1},{0,1}},"int16"); local v=np.any(a,{axis={},where=false});assert(v.dtype=="bool")
same(v:tolist(),{{false,false},{false,false},{false,false}}) end
do local a=np.transpose(np.zeros({2,0},"uint8")); local v=np.any(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.zeros({0,3},"complex128"); same(np.all(a,{where=false}),true) end
do local a=np.flip(np.array({0.0},"float32"),1); local v=np.all(a,{axis=1,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.transpose(np.zeros({0,3},"int16")); local v=np.any(a,{axis=2,where=np.array({{}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{false,false,false}) end
do local a=np.array({{np.complex(0.0,0.0),np.complex(-1.0,0.0),np.complex(0.0,3.0)},{np.complex((0/0),0.0),np.complex((0/0),3.0),np.complex(-1.0,0.0)}},"complex64"); same(np.all(a),false) end
do local a=np.zeros({0,3},"U3"); same(np.any(a),false) end
do local a=np.array({np.complex(2.0,0.0)},"complex128"); same(np.count_nonzero(a),1) end
do local a=np.transpose(np.array({{{"xyz","",""},{"xyz","a","XX"}}},"U3")); same(np.all(a),false) end
do local a=np.zeros({0},"S3"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.transpose(np.zeros({0,3},"U3")); local v=np.all(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{},{},{}}) end
do local a=np.array({5,5,-1,0},"int32"); same(np.any(a,{where=np.array({false,false,true,false},"bool")}),true) end
do local a=np.flip(np.zeros({0,3},"float16"),2); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0}}) end
do local a=np.zeros({0},"uint64"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.array({{{np.complex(0.0,0.0),np.complex((0/0),0.0)},{np.complex(2.0,3.0),np.complex(2.0,0.0)},{np.complex(2.0,0.0),np.complex((0/0),3.0)}},{{np.complex(-1.0,0.0),np.complex(2.0,0.0)},{np.complex(-1.0,0.0),np.complex((0/0),0.0)},{np.complex(2.0,0.0),np.complex(2.0,3.0)}}},"complex128"); local v=np.count_nonzero(a,{axis={1,2,3},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{11}}}) end
do local a=np.array(np.complex(-1.0,3.0),"complex128"); same(np.any(a,{keepdims=true}),true) end
do local a=np.flip(np.array({{{"XX","xyz","XX"},{"","a","XX"}}},"S3"),3); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{{true,true,true},{true,true,false}}}) end
do local a=np.array({{{np.complex(0.0,0.0),np.complex((0/0),0.0)},{np.complex(2.0,0.0),np.complex((0/0),3.0)},{np.complex((0/0),0.0),np.complex(0.0,3.0)}},{{np.complex(0.0,0.0),np.complex((0/0),0.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex(0.0,0.0),np.complex(2.0,0.0)}}},"complex128"); same(np.any(a,{axis={1,2,3}}),true) end
do local a=np.array(0,"int64"); same(np.all(a,{axis={},where=np.array(true,"bool")}),false) end
do local a=np.zeros({2,0},"complex64"); local v=np.count_nonzero(a,{axis=2,keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0},{0}}) end
do local a=np.array({np.complex(0.0,0.0)},"complex128"); local v=np.any(a,{axis=1,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.zeros({2,0},"int32"); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.zeros({0},"S3"); same(np.any(a,{where=np.array({},"bool")}),false) end
do local a=np.array({{(0/0)},{0.0}},"float16"); same(np.any(a),true) end
do local a=np.transpose(np.array({{false,true},{false,true},{false,true}},"bool")); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{false,false,false},{true,true,true}}) end
do local a=np.zeros({0,3},"U3"); same(np.count_nonzero(a),0) end
do local a=np.transpose(np.array({{{"XX",""},{"a","xyz"},{"xyz","a"}},{{"xyz",""},{"a","a"},{"",""}}},"S3")); local v=np.all(a,{axis=1,where=false});assert(v.dtype=="bool")
same(v:tolist(),{{true,true},{true,true},{true,true}}) end
do local a=np.array({{{"a","XX","xyz"},{"XX","XX","a"}}},"S3"); same(np.any(a),true) end
do local a=np.flip(np.array({{{-2.0,0.0},{math.huge,0.0},{4.0,0.0}},{{4.0,(0/0)},{math.huge,0.0},{0.0,0.0}}},"float16"),3); local v=np.any(a,{keepdims=true,where=np.array({{{true,true}}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{{true}}}) end
do local a=np.transpose(np.array({{5},{0}},"int16")); local v=np.any(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{true,false}) end
do local a=np.array({5},"int32"); same(np.all(a,{axis={1}}),true) end
do local a=np.flip(np.zeros({0,3},"int32"),2); same(np.all(a),true) end
do local a=np.array({-0.0},"float32"); local v=np.any(a,{axis={},where=false});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.flip(np.array({{{5,0},{9007199254740995,0},{9007199254740995,0}},{{9007199254740995,0},{0,0},{0,-1}}},"int64"),3); same(np.any(a),true) end
do local a=np.transpose(np.array({{true},{false}},"bool")); same(np.count_nonzero(a),1) end
do local a=np.transpose(np.array({{{-0.0,0.0,0.0},{0.0,0.0,-2.0}}},"float16")); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{1}}}) end
do local a=np.array({-2.0,4.0},"float32"); local v=np.all(a,{axis={1},keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array({{{1,1,0},{1,1,0}}},"uint8"); same(np.all(a),false) end
do local a=np.array({1,5,0,0},"uint8"); local v=np.any(a,{axis={1},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.flip(np.array({{{"","a",""},{"xyz","xyz",""}}},"S3"),3); same(np.count_nonzero(a),3) end
do local a=np.array({""},"S3"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{0}) end
do local a=np.zeros({0},"bool"); same(np.all(a),true) end
do local a=np.transpose(np.array({{(0/0),0.0,0.0},{4.0,0.0,-0.0}},"float32")); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{2}}) end
do local a=np.array({np.complex(2.0,3.0),np.complex(2.0,0.0)},"complex128"); local v=np.any(a,{keepdims=true,where=false});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.array({{(0/0)},{math.huge}},"float64"); same(np.count_nonzero(a),2) end
do local a=np.array({"a","XX"},"U3"); same(np.count_nonzero(a),2) end
do local a=np.array({{1},{1}},"uint8"); local v=np.any(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true},{true}}) end
do local a=np.flip(np.zeros({2,0,3},"uint64"),3); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{},{}}) end
do local a=np.array({np.complex(0.0,0.0),np.complex(-1.0,0.0),np.complex(0.0,0.0),np.complex((0/0),3.0)},"complex64"); local v=np.count_nonzero(a,{axis={1},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{2}) end
do local a=np.zeros({0,3},"S3"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.array({0,1,1,0},"int32"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.zeros({2,0},"bool"); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{},{}}) end
do local a=np.zeros({0,3},"S3"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.flip(np.array({"a"},"U3"),1); same(np.count_nonzero(a),1) end
do local a=np.flip(np.zeros({2,0,3},"U3"),3); same(np.count_nonzero(a),0) end
do local a=np.array({{0,0},{0,5},{1,1}},"uint64"); local v=np.count_nonzero(a,{axis=1});assert(v.dtype=="int64")
same(v:tolist(),{1,2}) end
do local a=np.array({(0/0),-2.0,0.0,math.huge},"float64"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{1,1,0,1}) end
do local a=np.array({-1,0},"int16"); same(np.count_nonzero(a),1) end
do local a=np.transpose(np.zeros({0,3},"int16")); same(np.count_nonzero(a,{axis={1,2}}),0) end
do local a=np.zeros({0},"int16"); same(np.count_nonzero(a),0) end
do local a=np.flip(np.array({np.complex(2.0,0.0),np.complex(0.0,0.0)},"complex64"),1); same(np.count_nonzero(a),1) end
do local a=np.transpose(np.zeros({0,3},"float64")); local v=np.all(a,{axis={1,2},keepdims=true,where=np.zeros({3,0},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.zeros({2,0,3},"bool"); local v=np.any(a,{axis={1,2,3},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{false}}}) end
do local a=np.flip(np.array({false,false,false,true},"bool"),1); same(np.count_nonzero(a),1) end
do local a=np.transpose(np.array({{{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex(2.0,0.0),np.complex((0/0),0.0),np.complex(-1.0,3.0)}}},"complex64")); same(np.any(a,{axis={1,2,3}}),true) end
do local a=np.array({0},"uint64"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.array({{-0.0,(0/0)},{(0/0),0.0},{0.0,-0.0}},"float32"); same(np.all(a),false) end
do local a=np.flip(np.array({math.huge},"float64"),1); same(np.any(a),true) end
do local a=np.transpose(np.zeros({0,3},"bool")); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0}}) end
do local a=np.flip(np.array({{{5,0},{0,1},{0,1}},{{0,0},{5,5},{5,-1}}},"int8"),3); local v=np.all(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{false,true},{true,false},{true,false}},{{false,false},{true,true},{true,true}}}) end
do local a=np.array({0,0},"int16"); same(np.any(a,{axis=1,where=np.array({true,true},"bool")}),false) end
do local a=np.array({{np.complex((0/0),0.0),np.complex(2.0,0.0)},{np.complex(0.0,0.0),np.complex((0/0),0.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0)}},"complex128"); same(np.any(a,{axis={1,2}}),true) end
do local a=np.flip(np.array({{{1,1,5},{1,0,1}}},"int8"),3); local v=np.all(a,{axis={},where=np.array({{{true,false,true},{true,false,true}}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{{true,true,true},{true,true,true}}}) end
do local a=np.array({np.complex(2.0,3.0)},"complex64"); local v=np.all(a,{axis=1,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array(5,"int16"); same(np.any(a),true) end
do local a=np.array({-2.0},"float32"); same(np.all(a),true) end
do local a=np.array({{np.complex(2.0,0.0),np.complex(-1.0,0.0),np.complex(2.0,0.0)},{np.complex((0/0),0.0),np.complex(2.0,0.0),np.complex(0.0,0.0)}},"complex128"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{5}}) end
do local a=np.array({5},"uint64"); local v=np.count_nonzero(a,{axis=1,keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{1}) end
do local a=np.array({0,0},"uint64"); same(np.any(a,{axis={1}}),false) end
do local a=np.flip(np.array({{{np.complex((0/0),0.0),np.complex(-1.0,3.0)},{np.complex(-1.0,3.0),np.complex(0.0,0.0)},{np.complex(-1.0,0.0),np.complex(0.0,0.0)}},{{np.complex(-1.0,0.0),np.complex(0.0,3.0)},{np.complex(-1.0,3.0),np.complex(2.0,0.0)},{np.complex((0/0),3.0),np.complex((0/0),0.0)}}},"complex64"),3); same(np.count_nonzero(a),10) end
do local a=np.array({math.huge,0.0},"float64"); local v=np.any(a,{axis={1},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.flip(np.array({0.0,math.huge,0.0,(0/0)},"float16"),1); same(np.all(a,{axis=1}),false) end
do local a=np.array({-2.0,-0.0},"float16"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{true,false}) end
do local a=np.array({"a"},"S3"); same(np.count_nonzero(a,{axis=1}),1) end
do local a=np.array({{(0/0),(0/0)},{0.0,0.0},{4.0,0.0}},"float16"); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{1,1},{0,0},{1,0}}) end
do local a=np.array({{np.complex(-1.0,3.0),np.complex(2.0,0.0),np.complex(2.0,0.0)},{np.complex(0.0,0.0),np.complex(2.0,0.0),np.complex(0.0,0.0)}},"complex128"); same(np.count_nonzero(a),4) end
do local a=np.array({{false,false},{false,false},{false,false}},"bool"); same(np.count_nonzero(a),0) end
do local a=np.flip(np.array({{{np.complex(-1.0,3.0),np.complex((0/0),0.0),np.complex(0.0,0.0)},{np.complex(0.0,0.0),np.complex(-1.0,3.0),np.complex(-1.0,0.0)}}},"complex128"),3); local v=np.any(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{{true,true,true}}) end
do local a=np.transpose(np.zeros({2,0,3},"int32")); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{},{},{}}) end
do local a=np.array(0.0,"float16"); same(np.any(a,{axis={}}),false) end
do local a=np.flip(np.array({0},"int32"),1); same(np.count_nonzero(a),0) end
do local a=np.flip(np.zeros({0},"complex64"),1); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.array(0,"uint8"); same(np.all(a,{axis={}}),false) end
do local a=np.transpose(np.array({{{-0.0,-0.0,0.0},{-2.0,0.0,0.0}}},"float64")); local v=np.count_nonzero(a,{axis={1,2,3},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{1}}}) end
do local a=np.array({{0,5,5},{-1,0,9007199254740995}},"int64"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.zeros({0},"bool"); same(np.count_nonzero(a),0) end
do local a=np.array({-1},"int64"); same(np.any(a),true) end
do local a=np.transpose(np.zeros({2,0},"uint64")); local v=np.count_nonzero(a,{axis=1});assert(v.dtype=="int64")
same(v:tolist(),{0,0}) end
do local a=np.transpose(np.zeros({2,0,3},"float64")); local v=np.all(a,{axis=3,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{},{},{}}) end
do local a=np.array({{{-1,0,1},{0,0,0}}},"int16"); same(np.all(a),false) end
do local a=np.transpose(np.zeros({2,0},"int16")); local v=np.all(a,{keepdims=true,where=false});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.array({{(0/0),-2.0},{math.huge,4.0},{(0/0),(0/0)}},"float32"); local v=np.any(a,{axis=1,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true,true}}) end
do local a=np.array({{"xyz",""},{"XX","a"},{"xyz","a"}},"S3"); local v=np.all(a,{keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.array({{{"",""},{"XX","a"},{"a","XX"}},{{"XX","a"},{"xyz","xyz"},{"xyz",""}}},"S3"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{{false,false},{true,true},{true,true}},{{true,true},{true,true},{true,false}}}) end
do local a=np.array({{0,0},{5,-1},{0,-1}},"int16"); same(np.count_nonzero(a),3) end
do local a=np.array(5,"int8"); same(np.any(a),true) end
do local a=np.array({np.complex(-1.0,0.0),np.complex(0.0,0.0)},"complex64"); same(np.all(a),false) end
do local a=np.transpose(np.array({{0},{0}},"int8")); local v=np.any(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.transpose(np.array({{np.complex(-1.0,3.0),np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex(0.0,0.0),np.complex((0/0),0.0),np.complex(0.0,3.0)}},"complex64")); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{true,false},{false,true},{false,true}}) end
do local a=np.zeros({2,0,3},"bool"); same(np.all(a),true) end
do local a=np.flip(np.array({{{0,0},{5,0},{0,5}},{{-1,-1},{0,0},{5,5}}},"int16"),3); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{false}}}) end
do local a=np.array({{""},{""}},"U3"); same(np.all(a),false) end
do local a=np.zeros({0},"float32"); same(np.all(a,{axis=1,where=false}),true) end
do local a=np.zeros({0,3},"complex128"); same(np.all(a),true) end
do local a=np.array(0,"int16"); same(np.any(a,{where=np.array(false,"bool")}),false) end
do local a=np.flip(np.zeros({0},"int8"),1); same(np.any(a,{where=np.zeros({0},"bool")}),false) end
do local a=np.transpose(np.array({{{"xyz","xyz","a"},{"a","","a"}}},"U3")); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{true}}}) end
do local a=np.transpose(np.array({{np.complex((0/0),0.0),np.complex((0/0),0.0)},{np.complex(2.0,0.0),np.complex(2.0,0.0)},{np.complex(2.0,0.0),np.complex(-1.0,3.0)}},"complex128")); same(np.any(a),true) end
do local a=np.transpose(np.array({{{-0.0,-0.0,-0.0},{4.0,4.0,0.0}}},"float64")); same(np.all(a),false) end
do local a=np.array({{5},{0}},"int64"); local v=np.all(a,{axis=2,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true},{false}}) end
do local a=np.array({{"xyz","XX"},{"a","xyz"},{"a","a"}},"U3"); same(np.all(a,{axis={1,2},where=np.array({{true,true}},"bool")}),true) end
do local a=np.zeros({0},"bool"); same(np.count_nonzero(a),0) end
do local a=np.array("a","U3"); same(np.count_nonzero(a),1) end
do local a=np.array({{{math.huge,-0.0,(0/0)},{0.0,4.0,4.0}}},"float16"); local v=np.any(a,{axis={1,2,3},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{true}}}) end
do local a=np.zeros({0,3},"bool"); same(np.any(a,{where=np.array({{false,false,false}},"bool")}),false) end
do local a=np.zeros({2,0},"uint8"); local v=np.all(a,{axis={},keepdims=true,where=np.array({{}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.zeros({0},"float64"); same(np.count_nonzero(a,{axis=1}),0) end
do local a=np.array({{{1,0,0},{0,0,5}}},"int8"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{{1,0,0},{0,0,1}}}) end
do local a=np.flip(np.array({"a","xyz","","xyz"},"U3"),1); local v=np.all(a,{keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.flip(np.array({{{-1,5},{0,0},{-1,-1}},{{-1,5},{-1,5},{1,0}}},"int8"),3); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{1,1},{0,0},{1,1}},{{1,1},{1,1},{0,1}}}) end
do local a=np.flip(np.array({-2.0},"float16"),1); local v=np.any(a,{keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array({0.0,4.0},"float32"); local v=np.any(a,{axis={},where=np.array({false,true},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{false,true}) end
do local a=np.flip(np.array({{-0.0,-2.0,-2.0},{0.0,4.0,-0.0}},"float32"),2); same(np.any(a,{axis={1,2}}),true) end
do local a=np.transpose(np.array({{4.0,0.0,(0/0)},{-2.0,-0.0,(0/0)}},"float64")); local v=np.any(a,{keepdims=true,where=np.array({{false,true},{false,false},{false,false}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.flip(np.zeros({2,0},"float16"),2); local v=np.all(a,{axis=1,where=np.array({{}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.zeros({0,3},"float16"); local v=np.all(a,{axis={1,2},keepdims=true,where=np.array({{true,false,false}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.flip(np.array({{{np.complex((0/0),0.0),np.complex(2.0,0.0)},{np.complex(0.0,0.0),np.complex(-1.0,0.0)},{np.complex(-1.0,3.0),np.complex(2.0,0.0)}},{{np.complex(0.0,3.0),np.complex(-1.0,0.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex(-1.0,0.0),np.complex(2.0,0.0)}}},"complex128"),3); local v=np.any(a,{axis=3,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{true},{true},{true}},{{true},{false},{true}}}) end
do local a=np.zeros({2,0,3},"float64"); same(np.count_nonzero(a),0) end
do local a=np.transpose(np.array({{false},{false}},"bool")); same(np.count_nonzero(a),0) end
do local a=np.flip(np.array({{{np.complex(0.0,3.0),np.complex(0.0,3.0)},{np.complex((0/0),0.0),np.complex((0/0),3.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0)}},{{np.complex(0.0,0.0),np.complex(0.0,3.0)},{np.complex(2.0,0.0),np.complex(-1.0,0.0)},{np.complex(2.0,3.0),np.complex(2.0,0.0)}}},"complex128"),3); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{false}}}) end
do local a=np.flip(np.array({{np.complex(2.0,3.0),np.complex(-1.0,0.0),np.complex(0.0,3.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex((0/0),0.0)}},"complex64"),2); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{4}}) end
do local a=np.flip(np.array({0.0},"float32"),1); same(np.all(a,{where=np.array({true},"bool")}),false) end
do local a=np.transpose(np.array({{{0,0,0},{1,9007199254740995,9007199254740995}}},"uint64")); local v=np.any(a,{axis=3,where=false});assert(v.dtype=="bool")
same(v:tolist(),{{false,false},{false,false},{false,false}}) end
do local a=np.array({np.complex(0.0,3.0),np.complex((0/0),3.0)},"complex64"); same(np.any(a,{axis={1}}),true) end
do local a=np.array({{(0/0)},{0.0}},"float64"); local v=np.count_nonzero(a,{axis=1,keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{1}}) end
do local a=np.array({{5,1},{0,-1},{0,0}},"int64"); same(np.all(a,{axis={1,2},where=false}),true) end
do local a=np.flip(np.array({5},"int8"),1); same(np.any(a),true) end
do local a=np.transpose(np.zeros({2,0},"uint8")); same(np.count_nonzero(a),0) end
do local a=np.array({np.complex((0/0),3.0),np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)},"complex128"); same(np.any(a,{where=np.array({true,true,false,false},"bool")}),true) end
do local a=np.array({{{0,1},{0,-1},{0,0}},{{0,-1},{0,0},{0,-1}}},"int32"); same(np.all(a),false) end
do local a=np.flip(np.array({{""},{""}},"U3"),2); same(np.count_nonzero(a),0) end
do local a=np.array({{""},{"xyz"}},"U3"); same(np.count_nonzero(a,{axis={1,2}}),1) end
do local a=np.array(np.complex((0/0),0.0),"complex128"); same(np.count_nonzero(a),1) end
do local a=np.flip(np.array({{1,5},{5,0},{0,0}},"uint64"),2); local v=np.count_nonzero(a,{axis=2,keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{2},{1},{0}}) end
do local a=np.transpose(np.zeros({2,0,3},"int32")); local v=np.count_nonzero(a,{axis={1,2,3},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{0}}}) end
do local a=np.array({{{1,5},{0,5},{0,5}},{{0,1},{1,5},{0,1}}},"uint64"); same(np.count_nonzero(a),8) end
do local a=np.flip(np.zeros({2,0},"complex64"),2); same(np.all(a),true) end
do local a=np.array(true,"bool"); same(np.count_nonzero(a,{axis={}}),1) end
do local a=np.array({{"","XX",""},{"xyz","xyz","xyz"}},"U3"); local v=np.all(a,{axis={1,2},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.array({np.complex(-1.0,3.0)},"complex64"); same(np.count_nonzero(a),1) end
do local a=np.flip(np.array({1,5,1,5},"uint8"),1); same(np.all(a),true) end
do local a=np.array({{np.complex(2.0,0.0),np.complex(0.0,0.0)},{np.complex((0/0),3.0),np.complex(0.0,0.0)},{np.complex(2.0,0.0),np.complex((0/0),0.0)}},"complex64"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{true,false},{true,false},{true,true}}) end
do local a=np.zeros({0},"int32"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.zeros({2,0,3},"float16"); local v=np.all(a,{keepdims=true,where=false});assert(v.dtype=="bool")
same(v:tolist(),{{{true}}}) end
do local a=np.flip(np.array({{0.0,-2.0,0.0},{(0/0),(0/0),4.0}},"float64"),2); same(np.count_nonzero(a),4) end
do local a=np.array(0,"int32"); same(np.count_nonzero(a,{axis={}}),0) end
do local a=np.array({np.complex((0/0),0.0)},"complex128"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array({{{0,5,1},{0,9007199254740995,0}}},"uint64"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{3}}}) end
do local a=np.array({{np.complex((0/0),3.0),np.complex(0.0,0.0),np.complex((0/0),0.0)},{np.complex(2.0,0.0),np.complex((0/0),0.0),np.complex(0.0,0.0)}},"complex128"); local v=np.any(a,{axis=2,where=np.array({{true,true,true}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{true,true}) end
do local a=np.transpose(np.array({{math.huge,4.0,(0/0)},{0.0,(0/0),4.0}},"float64")); same(np.all(a,{axis={1,2}}),false) end
do local a=np.transpose(np.zeros({2,0},"complex64")); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0}}) end
do local a=np.array({-1,0,-1,0},"int16"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.zeros({2,0,3},"float16"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{true}}}) end
do local a=np.transpose(np.array({{0},{1}},"uint8")); local v=np.all(a,{axis={},where=np.array({{false,false}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{true,true}}) end
do local a=np.array({"XX",""},"S3"); same(np.any(a),true) end
do local a=np.array({""},"U3"); same(np.count_nonzero(a,{axis={1}}),0) end
do local a=np.array(false,"bool"); same(np.all(a),false) end
do local a=np.transpose(np.zeros({2,0},"S3")); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.zeros({0},"complex64"); local v=np.all(a,{axis=1,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array(math.huge,"float32"); same(np.count_nonzero(a,{keepdims=true}),1) end
do local a=np.flip(np.array({{{0,0},{0,0},{0,0}},{{5,1},{0,5},{0,0}}},"int32"),3); same(np.any(a),true) end
do local a=np.array({{0,0},{1,0},{1,1}},"uint8"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{3}}) end
do local a=np.zeros({0,3},"int64"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0}}) end
do local a=np.array({np.complex(2.0,0.0),np.complex(2.0,0.0)},"complex128"); local v=np.all(a,{keepdims=true,where=np.array({false,false},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array({"","xyz","XX","a"},"U3"); local v=np.all(a,{axis={},keepdims=true,where=np.array({true,false,true,true},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{false,true,true,true}) end
do local a=np.flip(np.array({np.complex(2.0,0.0)},"complex128"),1); local v=np.any(a,{axis={1},keepdims=true,where=np.array({false},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.array({9007199254740995},"uint64"); same(np.all(a,{where=true}),true) end
do local a=np.array({{{1,9007199254740995,0},{5,0,1}}},"int64"); same(np.count_nonzero(a),4) end
do local a=np.flip(np.zeros({0},"uint64"),1); same(np.all(a,{axis={1}}),true) end
do local a=np.array({{1,0},{0,0},{5,-1}},"int16"); same(np.any(a,{axis={1,2},where=np.array({{true,false}},"bool")}),true) end
do local a=np.flip(np.zeros({0,3},"S3"),2); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.zeros({0},"int64"); same(np.all(a),true) end
do local a=np.array({{{-0.0,math.huge,-2.0},{0.0,-2.0,0.0}}},"float16"); same(np.any(a),true) end
do local a=np.array({5,0,-1,1},"int32"); local v=np.all(a,{keepdims=true,where=np.array({true,true,true,true},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.zeros({0,3},"int8"); same(np.count_nonzero(a,{axis={1,2}}),0) end
do local a=np.flip(np.array({0,5},"uint8"),1); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.transpose(np.zeros({2,0,3},"S3")); same(np.count_nonzero(a),0) end
do local a=np.flip(np.array({"xyz","a"},"U3"),1); same(np.count_nonzero(a,{axis={1}}),2) end
do local a=np.zeros({2,0,3},"int64"); local v=np.count_nonzero(a,{axis={1,2,3},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{0}}}) end
do local a=np.zeros({0,3},"uint64"); local v=np.all(a,{axis=1,where=true});assert(v.dtype=="bool")
same(v:tolist(),{true,true,true}) end
do local a=np.array(0.0,"float64"); same(np.any(a,{axis={},keepdims=true}),false) end
do local a=np.array({{{"XX","xyz"},{"",""},{"XX",""}},{{"XX","xyz"},{"XX","xyz"},{"a","xyz"}}},"S3"); same(np.all(a,{where=np.array({{{true,false},{true,true},{false,false}},{{true,true},{false,false},{true,false}}},"bool")}),false) end
do local a=np.zeros({2,0},"float64"); same(np.any(a),false) end
do local a=np.array(np.complex(2.0,3.0),"complex64"); same(np.any(a,{keepdims=true}),true) end
do local a=np.array(np.complex((0/0),3.0),"complex64"); same(np.count_nonzero(a,{axis={}}),1) end
do local a=np.zeros({0,3},"uint64"); same(np.all(a),true) end
do local a=np.flip(np.array({{-0.0},{0.0}},"float16"),2); same(np.all(a),false) end
do local a=np.array({{{np.complex((0/0),3.0),np.complex(-1.0,0.0)},{np.complex(0.0,0.0),np.complex(2.0,0.0)},{np.complex(2.0,0.0),np.complex(2.0,3.0)}},{{np.complex(-1.0,0.0),np.complex(-1.0,0.0)},{np.complex(2.0,0.0),np.complex(2.0,0.0)},{np.complex(-1.0,3.0),np.complex(2.0,3.0)}}},"complex128"); local v=np.count_nonzero(a,{axis={1,2,3},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{11}}}) end
do local a=np.array({-1,0,5,1},"int32"); same(np.count_nonzero(a),3) end
do local a=np.array("","S3"); same(np.any(a),false) end
do local a=np.array({"","xyz"},"U3"); same(np.any(a,{where=np.array({false,false},"bool")}),false) end
do local a=np.transpose(np.array({{true,false,false},{false,false,true}},"bool")); same(np.any(a),true) end
do local a=np.array({{{1,1,0},{0,5,5}}},"uint64"); same(np.any(a,{axis={1,2,3}}),true) end
do local a=np.array(0.0,"float16"); same(np.all(a),false) end
do local a=np.transpose(np.zeros({2,0},"float32")); same(np.any(a),false) end
do local a=np.array(0,"int64"); same(np.count_nonzero(a,{axis={},keepdims=true}),0) end
do local a=np.flip(np.array({{np.complex((0/0),0.0),np.complex((0/0),3.0),np.complex(-1.0,0.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(-1.0,0.0)}},"complex128"),2); same(np.all(a,{where=np.array({{true,true,true},{false,false,true}},"bool")}),false) end
do local a=np.transpose(np.array({{0.0,math.huge},{-2.0,-2.0},{4.0,-2.0}},"float64")); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.array({{{"a","a","xyz"},{"XX","xyz","a"}}},"S3"); local v=np.all(a,{axis=3});assert(v.dtype=="bool")
same(v:tolist(),{{true,true}}) end
do local a=np.array(true,"bool"); same(np.any(a,{axis={}}),true) end
do local a=np.array({{"xyz",""},{"a","XX"},{"","XX"}},"S3"); same(np.all(a),false) end
do local a=np.transpose(np.zeros({2,0},"complex64")); same(np.count_nonzero(a),0) end
do local a=np.flip(np.array({{0},{0}},"int8"),2); same(np.count_nonzero(a,{axis={1,2}}),0) end
do local a=np.transpose(np.array({{4.0,0.0},{math.huge,0.0},{4.0,0.0}},"float32")); local v=np.any(a,{axis={},where=np.array({{false,false,false}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{false,false,false},{false,false,false}}) end
do local a=np.zeros({0},"float16"); same(np.any(a,{axis=1}),false) end
do local a=np.array({5},"uint8"); same(np.count_nonzero(a),1) end
do local a=np.array({{{"","XX","XX"},{"XX","","a"}}},"S3"); local v=np.count_nonzero(a,{axis=1});assert(v.dtype=="int64")
same(v:tolist(),{{0,1,1},{1,0,1}}) end
do local a=np.array({{0,-1,0},{1,0,0}},"int16"); local v=np.all(a,{axis=1,keepdims=true,where=np.array({{false,true,true},{true,true,false}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{true,false,false}}) end
do local a=np.transpose(np.zeros({2,0,3},"float32")); local v=np.count_nonzero(a,{axis=1});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.array(0,"int32"); same(np.count_nonzero(a),0) end
do local a=np.array({np.complex(0.0,3.0),np.complex(-1.0,0.0)},"complex128"); local v=np.all(a,{axis={1},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.flip(np.array({9007199254740995},"uint64"),1); same(np.count_nonzero(a,{axis={1}}),1) end
do local a=np.array({{0.0},{-0.0}},"float64"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.transpose(np.array({{1,0},{5,1},{0,9007199254740995}},"int64")); local v=np.any(a,{keepdims=true,where=false});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.array({{0,-1,0},{0,0,0}},"int16"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.flip(np.array({np.complex((0/0),0.0),np.complex(-1.0,0.0),np.complex(0.0,0.0),np.complex(-1.0,0.0)},"complex128"),1); local v=np.all(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true,false,true,true}) end
do local a=np.array({4.0,-0.0},"float16"); same(np.count_nonzero(a),1) end
do local a=np.flip(np.array({1},"uint8"),1); same(np.all(a),true) end
do local a=np.transpose(np.array({{{0.0,(0/0)},{4.0,-2.0},{4.0,-2.0}},{{0.0,4.0},{-2.0,0.0},{(0/0),0.0}}},"float32")); local v=np.any(a,{axis=3});assert(v.dtype=="bool")
same(v:tolist(),{{false,true,true},{true,true,true}}) end
do local a=np.flip(np.zeros({0,3},"complex64"),2); local v=np.all(a,{keepdims=true,where=np.array({{true,false,true}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.array({{{0,5,-1},{0,0,0}}},"int64"); same(np.count_nonzero(a),2) end
do local a=np.array({0,-1},"int16"); same(np.count_nonzero(a),1) end
do local a=np.zeros({0},"U3"); local v=np.any(a,{axis={},where=false});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.flip(np.array({{{false,true},{true,true},{false,true}},{{true,false},{false,false},{true,true}}},"bool"),3); same(np.any(a),true) end
do local a=np.transpose(np.array({{"XX","","XX"},{"a","",""}},"S3")); local v=np.count_nonzero(a,{axis={1,2},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{3}}) end
do local a=np.array(0,"int64"); same(np.all(a),false) end
do local a=np.array({{{0,1},{0,0},{5,0}},{{1,0},{1,0},{1,0}}},"int8"); same(np.any(a),true) end
do local a=np.zeros({0,3},"int64"); same(np.any(a),false) end
do local a=np.flip(np.array({{0.0,4.0},{math.huge,4.0},{-2.0,0.0}},"float16"),2); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{1,0},{1,1},{0,1}}) end
do local a=np.zeros({0},"complex64"); local v=np.any(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.transpose(np.zeros({2,0},"uint64")); same(np.any(a,{where=false}),false) end
do local a=np.zeros({0},"S3"); same(np.count_nonzero(a,{axis={1}}),0) end
do local a=np.zeros({2,0,3},"S3"); local v=np.count_nonzero(a,{axis=2,keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{0,0,0}},{{0,0,0}}}) end
do local a=np.flip(np.zeros({2,0,3},"bool"),3); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{true}}}) end
do local a=np.array({0,1},"uint64"); local v=np.all(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{false,true}) end
do local a=np.array({{-1},{0}},"int64"); same(np.any(a),true) end
do local a=np.array({-1,-1,1,-1},"int8"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{4}) end
do local a=np.flip(np.zeros({2,0,3},"U3"),3); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{0}}}) end
do local a=np.zeros({0},"float64"); local v=np.all(a,{keepdims=true,where=false});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.zeros({2,0,3},"float16"); local v=np.count_nonzero(a,{axis=1});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.array({{"XX","a",""},{"","xyz","a"}},"U3"); same(np.any(a),true) end
do local a=np.array({{0,-1,0},{-1,0,1}},"int16"); local v=np.count_nonzero(a,{axis=2});assert(v.dtype=="int64")
same(v:tolist(),{1,2}) end
do local a=np.transpose(np.zeros({2,0},"uint64")); same(np.any(a),false) end
do local a=np.array({{"XX","xyz"},{"xyz","xyz"},{"","XX"}},"U3"); same(np.count_nonzero(a),5) end
do local a=np.flip(np.zeros({2,0},"float32"),2); same(np.any(a,{where=np.zeros({2,0},"bool")}),false) end
do local a=np.array({{{"a","XX"},{"xyz","xyz"},{"","xyz"}},{{"","a"},{"XX","a"},{"xyz",""}}},"S3"); local v=np.count_nonzero(a,{axis={1,2,3},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{9}}}) end
do local a=np.flip(np.zeros({0,3},"int16"),2); same(np.any(a,{axis={1,2},where=true}),false) end
do local a=np.array(0.0,"float64"); same(np.any(a,{axis={},where=np.array(true,"bool")}),false) end
do local a=np.flip(np.array({9007199254740995,5},"int64"),1); same(np.count_nonzero(a),2) end
do local a=np.zeros({0},"bool"); same(np.any(a),false) end
do local a=np.transpose(np.array({{{5,0},{0,5},{0,5}},{{5,5},{-1,0},{1,0}}},"int16")); local v=np.count_nonzero(a,{axis=2});assert(v.dtype=="int64")
same(v:tolist(),{{1,3},{2,1}}) end
do local a=np.array({{np.complex(-1.0,0.0),np.complex(0.0,3.0)},{np.complex(0.0,0.0),np.complex(2.0,3.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0)}},"complex64"); local v=np.all(a,{axis={1,2},keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.transpose(np.zeros({2,0,3},"float64")); same(np.any(a,{where=np.array({{{true,true}}},"bool")}),false) end
do local a=np.zeros({0},"int16"); same(np.count_nonzero(a),0) end
do local a=np.array({-0.0},"float64"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.transpose(np.array({{false},{false}},"bool")); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.zeros({0},"int64"); same(np.count_nonzero(a,{axis={1}}),0) end
do local a=np.array({""},"S3"); same(np.all(a),false) end
do local a=np.zeros({0,3},"float64"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.transpose(np.zeros({2,0},"bool")); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.array({np.complex(2.0,3.0)},"complex64"); same(np.any(a,{axis={1},where=false}),false) end
do local a=np.array("xyz","U3"); same(np.all(a),true) end
do local a=np.array({math.huge},"float16"); same(np.count_nonzero(a,{axis=1}),1) end
do local a=np.array({{5},{0}},"int16"); same(np.count_nonzero(a,{axis={1,2}}),1) end
do local a=np.flip(np.array({np.complex(2.0,0.0)},"complex64"),1); local v=np.all(a,{axis={1},keepdims=true,where=np.array({false},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.flip(np.zeros({2,0},"float64"),2); same(np.any(a),false) end
do local a=np.zeros({2,0,3},"float64"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.transpose(np.zeros({2,0,3},"float32")); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{true}}}) end
do local a=np.array({0,0},"int8"); same(np.any(a,{axis={1}}),false) end
do local a=np.zeros({2,0},"int32"); local v=np.any(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{false,false}) end
do local a=np.flip(np.zeros({2,0,3},"U3"),3); same(np.count_nonzero(a,{axis={1,2,3}}),0) end
do local a=np.array({{"XX"},{"xyz"}},"U3"); same(np.all(a),true) end
do local a=np.array({np.complex((0/0),0.0),np.complex((0/0),3.0)},"complex128"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.transpose(np.array({{{"xyz","xyz",""},{"a","xyz","a"}}},"S3")); local v=np.count_nonzero(a,{axis={1,2,3},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{5}}}) end
do local a=np.array({0,0},"int16"); same(np.all(a,{axis=1,where=false}),true) end
do local a=np.array({0,0},"int16"); same(np.any(a),false) end
do local a=np.array({0,5,1,5},"int8"); same(np.count_nonzero(a),3) end
do local a=np.zeros({0},"int64"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{0}) end
do local a=np.flip(np.zeros({0,3},"int16"),2); same(np.all(a,{where=np.array({{true,true,true}},"bool")}),true) end
do local a=np.array({0,5,1,0},"uint8"); same(np.count_nonzero(a),2) end
do local a=np.zeros({0},"int32"); same(np.count_nonzero(a),0) end
do local a=np.array(5,"int16"); same(np.any(a),true) end
do local a=np.array(np.complex(0.0,0.0),"complex128"); same(np.all(a),false) end
do local a=np.array({-2.0},"float32"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{1}) end
do local a=np.zeros({2,0,3},"int32"); same(np.all(a),true) end
do local a=np.flip(np.zeros({0},"int64"),1); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.array({"xyz","xyz"},"U3"); same(np.any(a,{where=np.array({true,true},"bool")}),true) end
do local a=np.flip(np.array({{"xyz","xyz"},{"xyz","a"},{"","xyz"}},"S3"),2); same(np.count_nonzero(a),5) end
do local a=np.array({{{0,0},{1,0},{0,1}},{{1,1},{-1,-1},{0,0}}},"int16"); local v=np.all(a,{keepdims=true,where=false});assert(v.dtype=="bool")
same(v:tolist(),{{{true}}}) end
do local a=np.array({np.complex(0.0,0.0),np.complex(-1.0,0.0)},"complex64"); local v=np.count_nonzero(a,{axis=1,keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{1}) end
do local a=np.array({{{4.0,-0.0},{0.0,0.0},{0.0,-2.0}},{{4.0,(0/0)},{4.0,0.0},{math.huge,4.0}}},"float64"); same(np.all(a,{axis={1,2,3}}),false) end
do local a=np.array({np.complex(0.0,0.0),np.complex(2.0,0.0)},"complex128"); same(np.all(a),false) end
do local a=np.transpose(np.array({{{5,0},{1,0},{0,0}},{{1,5},{0,5},{5,0}}},"int8")); local v=np.any(a,{axis={},keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{{{true,true},{true,false},{false,true}},{{false,true},{false,true},{false,false}}}) end
do local a=np.array({true},"bool"); local v=np.count_nonzero(a,{axis=1,keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{1}) end
do local a=np.zeros({2,0},"U3"); local v=np.all(a,{axis=1,where=false});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.array({np.complex(0.0,0.0),np.complex((0/0),0.0)},"complex64"); same(np.any(a,{axis={1},where=np.array({true,true},"bool")}),true) end
do local a=np.array({5},"int64"); same(np.count_nonzero(a),1) end
do local a=np.flip(np.array({{-0.0},{0.0}},"float16"),2); same(np.all(a),false) end
do local a=np.flip(np.zeros({0,3},"complex64"),2); local v=np.any(a,{axis=1,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false,false,false}}) end
do local a=np.array({0},"int16"); same(np.any(a,{axis=1}),false) end
do local a=np.flip(np.zeros({0,3},"int64"),2); local v=np.count_nonzero(a,{axis=2});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.zeros({2,0,3},"bool"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{0}}}) end
do local a=np.array({{0},{-1}},"int8"); same(np.any(a,{where=np.array({{true},{true}},"bool")}),true) end
do local a=np.array(9007199254740995,"uint64"); same(np.all(a,{axis={},keepdims=true}),true) end
do local a=np.transpose(np.zeros({2,0},"float64")); same(np.any(a,{where=np.zeros({0,2},"bool")}),false) end
do local a=np.array({{{0,0},{1,1},{9007199254740995,5}},{{0,1},{1,1},{1,0}}},"uint64"); same(np.count_nonzero(a),8) end
do local a=np.array({-1,0},"int16"); same(np.count_nonzero(a),1) end
do local a=np.transpose(np.array({{0},{0}},"int32")); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0}}) end
do local a=np.array({-2.0,-2.0},"float16"); same(np.count_nonzero(a),2) end
do local a=np.flip(np.zeros({0},"complex64"),1); same(np.any(a),false) end
do local a=np.array({{-1,1,0},{0,0,5}},"int64"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{3}}) end
do local a=np.transpose(np.array({{"xyz","XX","a"},{"XX","a",""}},"S3")); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{true,true},{true,true},{true,false}}) end
do local a=np.array({{{np.complex(0.0,0.0),np.complex(-1.0,0.0),np.complex(2.0,3.0)},{np.complex((0/0),0.0),np.complex(-1.0,3.0),np.complex(-1.0,0.0)}}},"complex128"); same(np.count_nonzero(a),5) end
do local a=np.transpose(np.zeros({0,3},"complex64")); same(np.count_nonzero(a),0) end
do local a=np.array({{{math.huge,(0/0)},{-0.0,-2.0},{-2.0,0.0}},{{-2.0,0.0},{-2.0,0.0},{(0/0),math.huge}}},"float64"); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{{true,true},{false,true},{true,false}},{{true,false},{true,false},{true,true}}}) end
do local a=np.transpose(np.zeros({2,0,3},"S3")); same(np.count_nonzero(a),0) end
do local a=np.transpose(np.zeros({2,0,3},"int64")); same(np.all(a),true) end
do local a=np.array(0,"int16"); same(np.all(a),false) end
do local a=np.transpose(np.array({{np.complex(-1.0,0.0),np.complex(0.0,0.0),np.complex((0/0),0.0)},{np.complex(0.0,0.0),np.complex(-1.0,0.0),np.complex(0.0,0.0)}},"complex64")); same(np.any(a,{where=np.array({{false,false}},"bool")}),false) end
do local a=np.array({{{-0.0,(0/0),-2.0},{0.0,math.huge,0.0}}},"float32"); local v=np.count_nonzero(a,{axis=2});assert(v.dtype=="int64")
same(v:tolist(),{{0,2,1}}) end
do local a=np.array(-2.0,"float32"); same(np.count_nonzero(a),1) end
do local a=np.array({{1},{1}},"uint64"); same(np.any(a,{where=false}),false) end
do local a=np.transpose(np.zeros({2,0,3},"uint64")); same(np.count_nonzero(a),0) end
do local a=np.zeros({2,0},"bool"); same(np.any(a),false) end
do local a=np.flip(np.zeros({0,3},"uint8"),2); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.zeros({2,0},"int64"); local v=np.all(a,{keepdims=true,where=false});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.array({0},"int8"); same(np.any(a,{axis=1,where=true}),false) end
do local a=np.array({np.complex(0.0,0.0)},"complex128"); same(np.all(a,{axis=1,where=false}),true) end
do local a=np.flip(np.array({{{math.huge,(0/0)},{math.huge,0.0},{0.0,(0/0)}},{{4.0,0.0},{math.huge,4.0},{-2.0,0.0}}},"float16"),3); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{1,1},{0,1},{1,0}},{{0,1},{1,1},{0,1}}}) end
do local a=np.array({{{"a","xyz"},{"","xyz"},{"XX","a"}},{{"a","XX"},{"a","XX"},{"",""}}},"S3"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{{true,true},{false,true},{true,true}},{{true,true},{true,true},{false,false}}}) end
do local a=np.transpose(np.array({{9007199254740995},{1}},"uint64")); same(np.all(a),true) end
do local a=np.flip(np.array({{4.0,(0/0)},{-2.0,0.0},{math.huge,4.0}},"float32"),2); local v=np.any(a,{keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.array({0,1,5,1},"uint8"); same(np.all(a,{axis=1,where=true}),false) end
do local a=np.transpose(np.array({{{-0.0,0.0},{4.0,0.0},{0.0,4.0}},{{4.0,(0/0)},{(0/0),4.0},{-2.0,-2.0}}},"float16")); same(np.count_nonzero(a,{axis={1,2,3}}),8) end
do local a=np.zeros({0},"complex128"); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.array({0,5},"int16"); same(np.all(a),false) end
do local a=np.flip(np.array({1,0,5,0},"uint8"),1); same(np.count_nonzero(a,{axis={1}}),2) end
do local a=np.flip(np.array({false,true,false,true},"bool"),1); same(np.any(a,{axis=1,where=true}),true) end
do local a=np.array({0},"int16"); same(np.count_nonzero(a,{axis=1}),0) end
do local a=np.transpose(np.array({{{0,0,0},{1,5,0}}},"int16")); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{{false},{true}},{{false},{true}},{{false},{false}}}) end
do local a=np.transpose(np.array({{{0.0,-0.0,0.0},{math.huge,-2.0,0.0}}},"float32")); same(np.count_nonzero(a),2) end
do local a=np.flip(np.array({{5},{0}},"uint8"),2); local v=np.all(a,{axis={},keepdims=true,where=false});assert(v.dtype=="bool")
same(v:tolist(),{{true},{true}}) end
do local a=np.transpose(np.array({{0,0,-1},{0,0,5}},"int32")); same(np.any(a,{axis={1,2},where=np.array({{false,false},{false,false},{false,true}},"bool")}),true) end
do local a=np.zeros({2,0,3},"int8"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{},{}}) end
do local a=np.array({5},"uint64"); same(np.all(a),true) end
do local a=np.zeros({0},"U3"); same(np.count_nonzero(a),0) end
do local a=np.array({{5},{0}},"int32"); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{true},{false}}) end
do local a=np.zeros({2,0,3},"int64"); same(np.any(a),false) end
do local a=np.transpose(np.zeros({0,3},"complex64")); local v=np.all(a,{keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.flip(np.zeros({0},"S3"),1); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.zeros({0,3},"int8"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.transpose(np.array({{{0,0,0},{9007199254740995,0,9007199254740995}}},"int64")); local v=np.all(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{{false},{false},{false}}) end
do local a=np.flip(np.zeros({0},"int32"),1); same(np.count_nonzero(a),0) end
do local a=np.flip(np.array({{false,false},{true,false},{true,true}},"bool"),2); local v=np.any(a,{keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.transpose(np.array({{{-2.0,(0/0),4.0},{math.huge,0.0,math.huge}}},"float16")); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{{true},{true}},{{true},{false}},{{true},{true}}}) end
do local a=np.flip(np.zeros({0,3},"complex64"),2); same(np.all(a),true) end
do local a=np.array({1,1,0,0},"uint64"); same(np.any(a,{where=false}),false) end
do local a=np.zeros({0,3},"float16"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0}}) end
do local a=np.array({-1},"int64"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{1}) end
do local a=np.zeros({2,0},"int16"); local v=np.any(a,{axis=1,where=true});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.array({0,5,0,1},"int32"); same(np.any(a,{axis={1}}),true) end
do local a=np.zeros({0},"uint8"); same(np.any(a),false) end
do local a=np.array({{{4.0,math.huge},{0.0,math.huge},{-2.0,math.huge}},{{-0.0,0.0},{0.0,0.0},{math.huge,(0/0)}}},"float32"); same(np.all(a,{where=true}),false) end
do local a=np.array(1,"int8"); same(np.all(a),true) end
do local a=np.flip(np.array({{0},{0}},"int8"),2); local v=np.all(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.transpose(np.array({{0,-1,-1},{-1,-1,0}},"int32")); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{4}}) end
do local a=np.flip(np.zeros({2,0},"uint64"),2); same(np.all(a,{axis={1,2}}),true) end
do local a=np.zeros({2,0},"complex64"); local v=np.any(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{false,false}) end
do local a=np.flip(np.zeros({0},"float64"),1); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.zeros({0,3},"float32"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.zeros({0,3},"uint8"); local v=np.any(a,{axis={},where=true});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.transpose(np.zeros({2,0,3},"U3")); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{},{},{}}) end
do local a=np.transpose(np.array({{{0,0,5},{1,0,0}}},"uint8")); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{2}}}) end
do local a=np.array({{{"XX","a","a"},{"","xyz","XX"}}},"S3"); same(np.all(a,{axis={1,2,3},where=true}),false) end
do local a=np.array({5,9007199254740995},"int64"); same(np.any(a,{axis={1}}),true) end
do local a=np.zeros({2,0},"int16"); local v=np.all(a,{axis=1,where=np.array({{}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.flip(np.array({5,0,0,1},"int8"),1); same(np.all(a),false) end
do local a=np.zeros({0,3},"complex64"); local v=np.count_nonzero(a,{axis={1,2},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0}}) end
do local a=np.array((0/0),"float64"); same(np.any(a,{keepdims=true}),true) end
do local a=np.zeros({0},"S3"); local v=np.any(a,{axis={1},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.array({math.huge,math.huge,(0/0),-0.0},"float16"); same(np.all(a,{where=np.array({true,true,false,true},"bool")}),false) end
do local a=np.zeros({2,0,3},"int16"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{false}}}) end
do local a=np.array({0,1},"int16"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{0,1}) end
do local a=np.array({np.complex(0.0,0.0)},"complex64"); same(np.any(a),false) end
do local a=np.flip(np.zeros({2,0,3},"int16"),3); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{},{}}) end
do local a=np.array({-0.0},"float64"); same(np.any(a),false) end
do local a=np.array({{{np.complex((0/0),0.0),np.complex(0.0,0.0)},{np.complex(-1.0,3.0),np.complex(2.0,0.0)},{np.complex(0.0,0.0),np.complex((0/0),3.0)}},{{np.complex(2.0,0.0),np.complex(0.0,0.0)},{np.complex(-1.0,3.0),np.complex(0.0,3.0)},{np.complex(0.0,0.0),np.complex((0/0),3.0)}}},"complex64"); same(np.count_nonzero(a),8) end
do local a=np.zeros({2,0,3},"float64"); local v=np.any(a,{axis=1,keepdims=true,where=np.array({{{true,false,true}}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{}}) end
do local a=np.array({false},"bool"); same(np.any(a,{axis={1},where=true}),false) end
do local a=np.array({-1,-1},"int64"); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{1,1}) end
do local a=np.flip(np.array({{-2.0,-0.0},{math.huge,0.0},{math.huge,0.0}},"float16"),2); same(np.count_nonzero(a,{axis={1,2}}),3) end
do local a=np.transpose(np.array({{{0.0,0.0,(0/0)},{0.0,-0.0,-2.0}}},"float64")); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{false}}}) end
do local a=np.array(true,"bool"); same(np.count_nonzero(a,{axis={},keepdims=true}),1) end
do local a=np.array({{-1,0,0},{1,0,1}},"int16"); local v=np.all(a,{axis=2,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false},{false}}) end
do local a=np.flip(np.zeros({2,0},"S3"),2); same(np.all(a,{where=true}),true) end
do local a=np.array({false,false},"bool"); same(np.count_nonzero(a),0) end
do local a=np.array({1},"int64"); same(np.all(a,{axis={1}}),true) end
do local a=np.flip(np.array({{{0,1,5},{0,0,0}}},"int16"),3); local v=np.any(a,{axis=1,keepdims=true,where=np.array({{{true,true,false}}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{{true,true,false},{false,false,false}}}) end
do local a=np.array({{0,-1,0},{0,-1,0}},"int16"); local v=np.all(a,{axis={},where=false});assert(v.dtype=="bool")
same(v:tolist(),{{true,true,true},{true,true,true}}) end
do local a=np.array({{1},{0}},"uint8"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{1},{0}}) end
do local a=np.array(-1,"int8"); same(np.any(a,{axis={}}),true) end
do local a=np.transpose(np.zeros({2,0},"uint8")); same(np.all(a,{where=false}),true) end
do local a=np.array({{{np.complex((0/0),3.0),np.complex(0.0,3.0),np.complex(-1.0,0.0)},{np.complex(2.0,0.0),np.complex(-1.0,0.0),np.complex(2.0,0.0)}}},"complex128"); same(np.all(a),true) end
do local a=np.flip(np.array({{{1,5},{0,0},{5,0}},{{0,1},{0,0},{0,0}}},"int16"),3); local v=np.any(a,{axis=2,keepdims=true,where=false});assert(v.dtype=="bool")
same(v:tolist(),{{{false,false}},{{false,false}}}) end
do local a=np.array({{""},{"a"}},"U3"); local v=np.any(a,{axis=2,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false},{true}}) end
do local a=np.flip(np.zeros({2,0},"int32"),2); same(np.count_nonzero(a,{axis={1,2}}),0) end
do local a=np.array(np.complex(2.0,0.0),"complex128"); same(np.count_nonzero(a,{keepdims=true}),1) end
do local a=np.array({{0},{1}},"int8"); same(np.any(a,{where=false}),false) end
do local a=np.flip(np.array({4.0},"float16"),1); same(np.any(a),true) end
do local a=np.transpose(np.array({{true,false},{false,true},{false,true}},"bool")); same(np.any(a,{axis={1,2}}),true) end
do local a=np.array(5,"uint8"); same(np.count_nonzero(a,{axis={},keepdims=true}),1) end
do local a=np.zeros({0},"float32"); same(np.count_nonzero(a,{axis=1}),0) end
do local a=np.array({np.complex(0.0,0.0),np.complex(-1.0,0.0),np.complex(-1.0,3.0),np.complex(0.0,0.0)},"complex64"); same(np.all(a,{axis={1}}),false) end
do local a=np.array({0.0,0.0,math.huge,0.0},"float32"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.zeros({2,0,3},"S3"); same(np.any(a,{where=np.zeros({2,0,3},"bool")}),false) end
do local a=np.flip(np.array({{1,0,5},{0,0,1}},"uint8"),2); same(np.count_nonzero(a),3) end
do local a=np.transpose(np.zeros({0,3},"int16")); same(np.any(a,{axis={1,2}}),false) end
do local a=np.flip(np.zeros({2,0},"S3"),2); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.array({{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex((0/0),0.0)},{np.complex(-1.0,0.0),np.complex(2.0,3.0),np.complex(0.0,0.0)}},"complex128"); same(np.any(a),true) end
do local a=np.zeros({0},"int8"); same(np.all(a),true) end
do local a=np.flip(np.array({0,0,1,-1},"int64"),1); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.array({"","","XX","a"},"U3"); same(np.all(a,{axis=1,where=np.array({true,false,true,false},"bool")}),false) end
do local a=np.array({-0.0,math.huge,4.0,(0/0)},"float32"); local v=np.any(a,{keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.transpose(np.array({{{0.0,-0.0,-2.0},{math.huge,0.0,(0/0)}}},"float64")); same(np.count_nonzero(a),3) end
do local a=np.array({0.0,0.0,0.0,math.huge},"float16"); same(np.all(a,{axis={1},where=true}),false) end
do local a=np.transpose(np.array({{0.0,(0/0)},{0.0,0.0},{0.0,0.0}},"float16")); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{false,false,false},{true,false,false}}) end
do local a=np.zeros({0,3},"float64"); same(np.all(a),true) end
do local a=np.zeros({2,0},"float32"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.array({{{"a","xyz","a"},{"xyz","",""}}},"S3"); same(np.count_nonzero(a),4) end
do local a=np.array({{{1,1},{0,0},{1,0}},{{1,0},{5,1},{1,0}}},"uint8"); same(np.all(a),false) end
do local a=np.array({{0,1},{5,5},{0,0}},"uint8"); local v=np.all(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false,true},{true,true},{false,false}}) end
do local a=np.array({{""},{""}},"U3"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{0},{0}}) end
do local a=np.zeros({2,0,3},"float32"); same(np.all(a),true) end
do local a=np.array({{{1,0},{5,0},{0,0}},{{0,1},{0,0},{0,1}}},"int8"); local v=np.any(a,{keepdims=true,where=np.array({{{true,true}}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{{true}}}) end
do local a=np.array({{math.huge,-0.0},{-0.0,-2.0},{4.0,0.0}},"float16"); local v=np.any(a,{axis=2,where=np.array({{true,false},{false,false},{true,false}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{true,false,true}) end
do local a=np.array(false,"bool"); same(np.count_nonzero(a,{axis={}}),0) end
do local a=np.flip(np.zeros({0,3},"float16"),2); same(np.count_nonzero(a),0) end
do local a=np.array({{-1,5,0},{0,0,0}},"int8"); local v=np.any(a,{axis={1,2},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.zeros({2,0},"U3"); same(np.any(a,{axis={1,2},where=false}),false) end
do local a=np.array({0,-1,5,0},"int64"); same(np.count_nonzero(a),2) end
do local a=np.zeros({0},"complex128"); same(np.count_nonzero(a),0) end
do local a=np.flip(np.zeros({0,3},"float64"),2); local v=np.count_nonzero(a,{axis=2});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.array({{{0,0,1},{0,0,0}}},"uint8"); same(np.count_nonzero(a),1) end
do local a=np.flip(np.zeros({2,0,3},"float32"),3); local v=np.all(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.transpose(np.array({{9007199254740995,0,0},{1,0,0}},"uint64")); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{true,true},{false,false},{false,false}}) end
do local a=np.flip(np.zeros({0,3},"int32"),2); local v=np.count_nonzero(a,{axis={1,2},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0}}) end
do local a=np.zeros({2,0,3},"int8"); local v=np.any(a,{axis=1,where=np.array({{{false,false,true}}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.array({0},"uint64"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.transpose(np.zeros({2,0},"bool")); local v=np.all(a,{axis={},where=np.zeros({0,2},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.flip(np.zeros({2,0},"complex64"),2); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{},{}}) end
do local a=np.array({0,1},"uint8"); local v=np.all(a,{axis=1,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.array({{0,5},{-1,1},{0,1}},"int64"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{4}}) end
do local a=np.flip(np.array({4.0},"float32"),1); same(np.any(a,{where=false}),false) end
do local a=np.array({0,0},"int32"); same(np.all(a,{axis=1}),false) end
do local a=np.flip(np.array({np.complex(2.0,3.0),np.complex((0/0),0.0)},"complex64"),1); same(np.all(a),true) end
do local a=np.array({0.0,-0.0},"float32"); same(np.any(a,{axis={1},where=np.array({true,true},"bool")}),false) end
do local a=np.transpose(np.zeros({0,3},"float16")); local v=np.any(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.array({"",""},"U3"); same(np.count_nonzero(a,{axis=1}),0) end
do local a=np.transpose(np.array({{-0.0},{-0.0}},"float64")); same(np.all(a,{axis={1,2}}),false) end
do local a=np.array({np.complex(0.0,3.0),np.complex((0/0),0.0)},"complex64"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{2}) end
do local a=np.array({0},"int8"); local v=np.all(a,{axis=1,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.array({{{0,1,1},{0,0,5}}},"uint8"); same(np.all(a,{axis={1,2,3},where=np.array({{{false,true,false},{true,true,true}}},"bool")}),false) end
do local a=np.transpose(np.zeros({2,0},"float64")); same(np.all(a,{axis={1,2}}),true) end
do local a=np.array({1},"uint64"); same(np.count_nonzero(a),1) end
do local a=np.zeros({0,3},"complex64"); local v=np.all(a,{axis={},where=false});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.array({{{true,true},{false,false},{false,true}},{{false,false},{true,false},{false,true}}},"bool"); local v=np.all(a,{axis=2,where=np.array({{{false,false},{true,true},{true,false}},{{true,true},{false,true},{true,true}}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{false,false},{false,false}}) end
do local a=np.transpose(np.array({{"xyz","XX","a"},{"","XX",""}},"S3")); same(np.any(a),true) end
do local a=np.array({{0},{0}},"uint64"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{false},{false}}) end
do local a=np.zeros({0},"float64"); local v=np.all(a,{axis=1,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.zeros({2,0},"int8"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.array({np.complex((0/0),0.0),np.complex(0.0,0.0)},"complex128"); same(np.all(a),false) end
do local a=np.array({np.complex(0.0,0.0),np.complex((0/0),3.0),np.complex(2.0,0.0),np.complex(0.0,3.0)},"complex64"); same(np.any(a,{where=np.array({false,true,false,true},"bool")}),true) end
do local a=np.flip(np.array({math.huge,0.0},"float32"),1); same(np.all(a),false) end
do local a=np.zeros({0},"int32"); same(np.any(a),false) end
do local a=np.array({4.0,4.0},"float64"); same(np.all(a),true) end
do local a=np.flip(np.zeros({2,0},"uint64"),2); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.array(true,"bool"); same(np.count_nonzero(a),1) end
do local a=np.array({{{"XX",""},{"XX","XX"},{"a","XX"}},{{"xyz","XX"},{"",""},{"","XX"}}},"S3"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{{1,0},{1,1},{1,1}},{{1,1},{0,0},{0,1}}}) end
do local a=np.array({5},"int32"); local v=np.all(a,{axis={},where=np.array({true},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.transpose(np.array({{{true,true,false},{false,false,false}}},"bool")); same(np.any(a,{where=false}),false) end
do local a=np.array({{{0,1,1},{0,5,1}}},"uint8"); same(np.count_nonzero(a),4) end
do local a=np.transpose(np.array({{{0,9007199254740995,0},{0,1,5}}},"int64")); same(np.all(a),false) end
do local a=np.flip(np.array({{false},{false}},"bool"),2); same(np.any(a,{where=true}),false) end
do local a=np.transpose(np.array({{(0/0),(0/0)},{(0/0),4.0},{math.huge,-0.0}},"float64")); local v=np.any(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{true,true,true}) end
do local a=np.flip(np.array({0,0},"int16"),1); same(np.all(a),false) end
do local a=np.transpose(np.array({{0,0,1},{1,1,0}},"uint8")); same(np.any(a,{axis={1,2}}),true) end
do local a=np.array({-1,-1,0,-1},"int16"); same(np.count_nonzero(a),3) end
do local a=np.array({{0},{0}},"int64"); local v=np.all(a,{axis={},where=np.array({{false},{false}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{true},{true}}) end
do local a=np.array({0,0},"uint64"); same(np.count_nonzero(a,{axis={1}}),0) end
do local a=np.flip(np.array({{(0/0),(0/0)},{(0/0),0.0},{math.huge,0.0}},"float32"),2); same(np.count_nonzero(a),4) end
do local a=np.array({{{0,5,1},{5,0,-1}}},"int8"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{{0,1,1},{1,0,1}}}) end
do local a=np.zeros({2,0,3},"float64"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.flip(np.zeros({0},"U3"),1); same(np.count_nonzero(a),0) end
do local a=np.zeros({0},"complex64"); same(np.all(a,{axis=1,where=false}),true) end
do local a=np.array({{{np.complex(2.0,0.0),np.complex((0/0),0.0),np.complex((0/0),0.0)},{np.complex((0/0),0.0),np.complex(0.0,0.0),np.complex(0.0,3.0)}}},"complex64"); local v=np.any(a,{axis={},where=np.array({{{true,false,false}}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{{true,false,false},{true,false,false}}}) end
do local a=np.flip(np.array({{4.0,0.0,4.0},{0.0,4.0,-2.0}},"float32"),2); local v=np.any(a,{axis={1,2},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.transpose(np.zeros({2,0,3},"bool")); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{0}}}) end
do local a=np.transpose(np.zeros({0,3},"complex128")); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.array({{{-1,1},{0,0},{-1,0}},{{0,1},{0,-1},{1,0}}},"int8"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{{1,1},{0,0},{1,0}},{{0,1},{0,1},{1,0}}}) end
do local a=np.flip(np.array({{math.huge,math.huge,-2.0},{(0/0),math.huge,4.0}},"float32"),2); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.array({{-1},{1}},"int16"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{1},{1}}) end
do local a=np.zeros({2,0},"float16"); same(np.all(a),true) end
do local a=np.array({0,5,5,9007199254740995},"uint64"); same(np.all(a),false) end
do local a=np.flip(np.array({{-2.0},{-0.0}},"float64"),2); same(np.count_nonzero(a,{axis={1,2}}),1) end
do local a=np.array({5,5},"int32"); same(np.all(a),true) end
do local a=np.array({{0,-1,1},{0,0,0}},"int32"); same(np.any(a,{axis={1,2}}),true) end
do local a=np.zeros({0},"float64"); same(np.all(a,{axis={1},where=np.zeros({0},"bool")}),true) end
do local a=np.zeros({2,0,3},"U3"); local v=np.any(a,{axis={1,2,3},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{false}}}) end
do local a=np.zeros({2,0},"int8"); same(np.count_nonzero(a,{axis={1,2}}),0) end
do local a=np.flip(np.array({false},"bool"),1); same(np.count_nonzero(a,{axis={1}}),0) end
do local a=np.array({{{np.complex(2.0,0.0),np.complex(0.0,0.0),np.complex(-1.0,3.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex((0/0),3.0)}}},"complex128"); same(np.count_nonzero(a),3) end
do local a=np.array({(0/0),-2.0,-0.0,0.0},"float32"); same(np.any(a),true) end
do local a=np.array("","S3"); same(np.count_nonzero(a),0) end
do local a=np.array({5,9007199254740995,0,9007199254740995},"int64"); same(np.count_nonzero(a),3) end
do local a=np.flip(np.array({{{0,0,1},{0,1,0}}},"int32"),3); same(np.all(a),false) end
do local a=np.flip(np.array({{1,5,0},{0,0,0}},"uint64"),2); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{false,true,true},{false,false,false}}) end
do local a=np.array({np.complex(2.0,0.0)},"complex128"); same(np.all(a),true) end
do local a=np.flip(np.zeros({0},"bool"),1); same(np.any(a),false) end
do local a=np.transpose(np.array({{np.complex(-1.0,0.0),np.complex(2.0,0.0),np.complex(2.0,0.0)},{np.complex(0.0,0.0),np.complex(2.0,0.0),np.complex(0.0,3.0)}},"complex128")); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{1,0},{1,1},{1,1}}) end
do local a=np.zeros({0,3},"int32"); local v=np.any(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.flip(np.zeros({0},"bool"),1); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.flip(np.array({0,0},"int8"),1); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{0,0}) end
do local a=np.flip(np.array({{5,0},{5,1},{0,1}},"uint8"),2); same(np.any(a,{where=np.array({{false,false},{false,false},{false,true}},"bool")}),false) end
do local a=np.zeros({2,0,3},"complex64"); local v=np.any(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.zeros({0},"U3"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.flip(np.array({{"xyz","XX"},{"",""},{"","xyz"}},"U3"),2); same(np.count_nonzero(a),3) end
do local a=np.flip(np.array({{"a","XX"},{"","a"},{"XX","xyz"}},"U3"),2); same(np.any(a,{axis={1,2}}),true) end
do local a=np.transpose(np.zeros({0,3},"int64")); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0}}) end
do local a=np.array(0,"int8"); same(np.all(a),false) end
do local a=np.array({{{1,5},{5,1},{0,0}},{{0,0},{0,1},{0,0}}},"uint8"); same(np.any(a),true) end
do local a=np.array({{{np.complex(0.0,3.0),np.complex(0.0,0.0),np.complex((0/0),3.0)},{np.complex(2.0,3.0),np.complex((0/0),0.0),np.complex((0/0),0.0)}}},"complex64"); same(np.all(a),false) end
do local a=np.zeros({2,0},"float32"); local v=np.any(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.array({{{-2.0,0.0},{-0.0,4.0},{-2.0,-2.0}},{{0.0,-2.0},{0.0,-2.0},{4.0,(0/0)}}},"float16"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{8}}}) end
do local a=np.flip(np.zeros({2,0,3},"int32"),3); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{},{}}) end
do local a=np.array({5},"int8"); local v=np.all(a,{axis={},where=np.array({false},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.flip(np.zeros({0,3},"int64"),2); local v=np.count_nonzero(a,{axis=1});assert(v.dtype=="int64")
same(v:tolist(),{0,0,0}) end
do local a=np.transpose(np.array({{{1,1,1},{1,0,0}}},"uint8")); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{{true},{true}},{{true},{false}},{{true},{false}}}) end
do local a=np.zeros({2,0},"int64"); local v=np.any(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.array({{{0,0,9007199254740995},{5,9007199254740995,0}}},"uint64"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{true}}}) end
do local a=np.zeros({2,0,3},"int16"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{},{}}) end
do local a=np.flip(np.zeros({2,0},"uint64"),2); local v=np.any(a,{axis={1,2},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.transpose(np.array({{1,1,0},{0,1,1}},"uint8")); same(np.any(a,{where=np.array({{false,true},{false,false},{false,true}},"bool")}),true) end
do local a=np.flip(np.array({{0,5,-1},{0,0,0}},"int32"),2); local v=np.count_nonzero(a,{axis={1,2},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{2}}) end
do local a=np.zeros({0},"S3"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.array({5,0,0,0},"int64"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{1,0,0,0}) end
do local a=np.flip(np.zeros({0,3},"int64"),2); same(np.any(a),false) end
do local a=np.zeros({2,0},"int32"); same(np.count_nonzero(a,{axis={1,2}}),0) end
do local a=np.flip(np.array({{"XX","a","xyz"},{"xyz","xyz","xyz"}},"U3"),2); local v=np.count_nonzero(a,{axis=2});assert(v.dtype=="int64")
same(v:tolist(),{3,3}) end
do local a=np.flip(np.array({1},"int32"),1); same(np.count_nonzero(a),1) end
do local a=np.flip(np.zeros({2,0},"complex128"),2); local v=np.all(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{true,true}) end
do local a=np.array({"XX","xyz","a","XX"},"U3"); same(np.count_nonzero(a,{axis=1}),4) end
do local a=np.array(0,"uint8"); same(np.count_nonzero(a,{axis={}}),0) end
do local a=np.flip(np.array({{{0.0,0.0},{0.0,0.0},{(0/0),-0.0}},{{-0.0,4.0},{0.0,0.0},{0.0,0.0}}},"float16"),3); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{true}}}) end
do local a=np.flip(np.zeros({2,0},"complex64"),2); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.flip(np.array({0.0,0.0},"float64"),1); same(np.all(a,{axis={1}}),false) end
do local a=np.zeros({0,3},"int64"); same(np.all(a,{where=np.array({{true,false,false}},"bool")}),true) end
do local a=np.array({{{"","a"},{"a","xyz"},{"XX",""}},{{"","XX"},{"xyz","xyz"},{"a","XX"}}},"U3"); same(np.count_nonzero(a),9) end
do local a=np.array({{"xyz","a","xyz"},{"","xyz","xyz"}},"S3"); local v=np.any(a,{keepdims=true,where=np.array({{true,true,true}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.array({-0.0,-0.0,-0.0,-2.0},"float32"); local v=np.all(a,{axis={},keepdims=true,where=np.array({true,true,true,false},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{false,false,false,true}) end
do local a=np.flip(np.array({"","XX","xyz","XX"},"S3"),1); same(np.any(a),true) end
do local a=np.transpose(np.zeros({2,0,3},"uint8")); same(np.all(a),true) end
do local a=np.array({{0,-1},{5,0},{5,1}},"int32"); local v=np.count_nonzero(a,{axis=1});assert(v.dtype=="int64")
same(v:tolist(),{2,2}) end
do local a=np.transpose(np.array({{1,1,1},{1,0,0}},"uint8")); same(np.all(a),false) end
do local a=np.array(np.complex(-1.0,0.0),"complex64"); same(np.any(a,{axis={}}),true) end
do local a=np.transpose(np.zeros({2,0},"int8")); local v=np.count_nonzero(a,{axis=2});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.array(0,"uint8"); same(np.any(a,{keepdims=true}),false) end
do local a=np.transpose(np.array({{0},{0}},"uint8")); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{0,0}}) end
do local a=np.array("XX","U3"); same(np.all(a,{keepdims=true}),true) end
do local a=np.array({0},"int32"); local v=np.any(a,{axis=1,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.transpose(np.zeros({0,3},"float16")); same(np.all(a,{axis={1,2}}),true) end
do local a=np.flip(np.zeros({2,0,3},"float32"),3); same(np.all(a),true) end
do local a=np.zeros({2,0},"float32"); local v=np.any(a,{keepdims=true,where=false});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.array({-2.0,-0.0},"float32"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{true,false}) end
do local a=np.array({9007199254740995},"int64"); local v=np.all(a,{axis={},where=np.array({false},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array({"XX","xyz"},"U3"); same(np.count_nonzero(a),2) end
do local a=np.flip(np.array({0},"int16"),1); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.array({"xyz",""},"U3"); local v=np.any(a,{keepdims=true,where=false});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.zeros({0},"int16"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.flip(np.zeros({0},"uint64"),1); local v=np.any(a,{axis=1,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.array({"a"},"S3"); local v=np.all(a,{axis={1},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.zeros({0,3},"int16"); same(np.any(a),false) end
do local a=np.flip(np.array({np.complex(2.0,0.0),np.complex(2.0,3.0)},"complex128"),1); local v=np.any(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true,true}) end
do local a=np.zeros({2,0},"uint8"); local v=np.any(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{false,false}) end
do local a=np.zeros({2,0,3},"bool"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{true}}}) end
do local a=np.zeros({2,0},"int32"); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.transpose(np.array({{0},{-1}},"int64")); same(np.any(a),true) end
do local a=np.array({-1},"int16"); same(np.count_nonzero(a),1) end
do local a=np.array({9007199254740995,1},"uint64"); same(np.any(a),true) end
do local a=np.flip(np.array({0.0,0.0,(0/0),0.0},"float64"),1); same(np.any(a),true) end
do local a=np.zeros({0},"U3"); same(np.any(a,{axis={1}}),false) end
do local a=np.array({0.0,-2.0},"float64"); local v=np.any(a,{axis={1},keepdims=true,where=false});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.array({{0,-1},{0,0},{0,5}},"int16"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{2}}) end
do local a=np.array({0.0,(0/0),4.0,math.huge},"float32"); same(np.all(a),false) end
do local a=np.zeros({0},"int64"); same(np.all(a,{where=np.zeros({0},"bool")}),true) end
do local a=np.zeros({0},"int8"); same(np.any(a,{axis=1}),false) end
do local a=np.array({-1,0},"int64"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{true,false}) end
do local a=np.array({{{-1,9007199254740995,0},{-1,9007199254740995,0}}},"int64"); same(np.all(a),false) end
do local a=np.zeros({2,0},"complex64"); same(np.count_nonzero(a,{axis={1,2}}),0) end
do local a=np.array({{{(0/0),-2.0},{(0/0),-2.0},{0.0,4.0}},{{-2.0,(0/0)},{0.0,0.0},{4.0,math.huge}}},"float16"); same(np.any(a,{axis={1,2,3}}),true) end
do local a=np.array({{np.complex(0.0,3.0),np.complex(0.0,3.0)},{np.complex(0.0,0.0),np.complex((0/0),0.0)},{np.complex((0/0),0.0),np.complex(2.0,3.0)}},"complex128"); local v=np.all(a,{keepdims=true,where=np.array({{false,false}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.array({"xyz"},"S3"); same(np.all(a),true) end
do local a=np.array({{{0,1},{1,0},{0,0}},{{1,5},{5,5},{1,1}}},"uint8"); same(np.count_nonzero(a),8) end
do local a=np.transpose(np.zeros({0,3},"U3")); local v=np.all(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.zeros({2,0,3},"int8"); local v=np.any(a,{axis=2,where=np.zeros({2,0,3},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{false,false,false},{false,false,false}}) end
do local a=np.array({false},"bool"); same(np.count_nonzero(a,{axis={1}}),0) end
do local a=np.flip(np.array({np.complex(2.0,0.0)},"complex64"),1); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.flip(np.zeros({0,3},"complex64"),2); local v=np.all(a,{axis=2,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.array({0,1},"int64"); same(np.any(a,{where=true}),true) end
do local a=np.array({0},"int16"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.transpose(np.array({{0,-1,0},{5,5,0}},"int32")); same(np.any(a),true) end
do local a=np.array(np.complex(-1.0,0.0),"complex64"); same(np.count_nonzero(a,{axis={}}),1) end
do local a=np.flip(np.array({{0,0,0},{1,-1,0}},"int32"),2); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.zeros({2,0,3},"int32"); same(np.count_nonzero(a,{axis={1,2,3}}),0) end
do local a=np.array({false,true,true,true},"bool"); same(np.all(a,{axis={1}}),false) end
do local a=np.array({{false,true,true},{true,false,false}},"bool"); same(np.any(a),true) end
do local a=np.flip(np.array({(0/0)},"float16"),1); local v=np.any(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.flip(np.zeros({0,3},"uint8"),2); same(np.count_nonzero(a),0) end
do local a=np.zeros({2,0,3},"float16"); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{},{}}) end
do local a=np.array({{0.0},{4.0}},"float64"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.transpose(np.array({{{0.0,math.huge,(0/0)},{0.0,-0.0,4.0}}},"float32")); same(np.any(a),true) end
do local a=np.flip(np.zeros({0},"float64"),1); same(np.all(a,{axis=1}),true) end
do local a=np.zeros({0,3},"U3"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.transpose(np.array({{(0/0),0.0,(0/0)},{0.0,math.huge,-2.0}},"float32")); local v=np.all(a,{axis={1,2},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.array({{{0,1},{0,0},{5,9007199254740995}},{{9007199254740995,1},{0,0},{0,-1}}},"int64"); same(np.count_nonzero(a),6) end
do local a=np.array({0,5},"int32"); same(np.all(a,{where=np.array({false,true},"bool")}),true) end
do local a=np.transpose(np.array({{{5,0},{1,0},{1,0}},{{1,5},{0,1},{9007199254740995,0}}},"int64")); local v=np.any(a,{axis=3,where=false});assert(v.dtype=="bool")
same(v:tolist(),{{false,false,false},{false,false,false}}) end
do local a=np.zeros({0},"float32"); same(np.any(a,{where=np.array({},"bool")}),false) end
do local a=np.zeros({2,0},"int32"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.zeros({0},"U3"); same(np.all(a),true) end
do local a=np.transpose(np.zeros({2,0,3},"float64")); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{0}}}) end
do local a=np.transpose(np.zeros({0,3},"bool")); local v=np.count_nonzero(a,{axis=2});assert(v.dtype=="int64")
same(v:tolist(),{0,0,0}) end
do local a=np.array({0.0,(0/0)},"float64"); same(np.any(a),true) end
do local a=np.array(1,"uint8"); same(np.all(a),true) end
do local a=np.array({{"XX","a",""},{"XX","a","XX"}},"U3"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.array({{1,1},{0,9007199254740995},{1,1}},"uint64"); same(np.all(a,{where=np.array({{true,false},{true,true},{false,true}},"bool")}),false) end
do local a=np.flip(np.zeros({0,3},"bool"),2); same(np.count_nonzero(a,{axis={1,2}}),0) end
do local a=np.array(0,"uint64"); same(np.all(a),false) end
do local a=np.transpose(np.zeros({0,3},"complex128")); local v=np.all(a,{axis={},where=np.array({{}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{},{},{}}) end
do local a=np.transpose(np.array({{false,true,true},{true,true,true}},"bool")); local v=np.all(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{false,true,true}) end
do local a=np.array({{-2.0},{-2.0}},"float32"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{2}}) end
do local a=np.array(0,"uint64"); same(np.count_nonzero(a),0) end
do local a=np.transpose(np.array({{false},{true}},"bool")); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{1}}) end
do local a=np.array({math.huge,-2.0},"float32"); same(np.count_nonzero(a),2) end
do local a=np.zeros({2,0,3},"float64"); local v=np.any(a,{keepdims=true,where=false});assert(v.dtype=="bool")
same(v:tolist(),{{{false}}}) end
do local a=np.flip(np.array({{0,0},{-1,-1},{-1,0}},"int64"),2); local v=np.any(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{false,true,true}) end
do local a=np.transpose(np.array({{5},{0}},"int16")); same(np.all(a,{axis={1,2},where=false}),true) end
do local a=np.flip(np.array({{"XX"},{"XX"}},"S3"),2); local v=np.all(a,{keepdims=true,where=np.array({{true}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.array({0,0},"uint8"); same(np.count_nonzero(a),0) end
do local a=np.transpose(np.array({{1,1},{5,1},{0,0}},"uint8")); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{4}}) end
do local a=np.flip(np.array({0,0},"uint64"),1); same(np.all(a,{where=true}),false) end
do local a=np.transpose(np.zeros({0,3},"int8")); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.array({0,0,0,0},"int16"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.array({{{np.complex(0.0,3.0),np.complex(2.0,0.0)},{np.complex(0.0,3.0),np.complex((0/0),3.0)},{np.complex((0/0),0.0),np.complex((0/0),3.0)}},{{np.complex(0.0,3.0),np.complex(0.0,3.0)},{np.complex(2.0,0.0),np.complex(-1.0,0.0)},{np.complex(0.0,3.0),np.complex((0/0),0.0)}}},"complex128"); same(np.count_nonzero(a),12) end
do local a=np.flip(np.array({"XX","XX"},"S3"),1); local v=np.any(a,{axis=1,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.flip(np.array({math.huge,4.0},"float16"),1); same(np.all(a),true) end
do local a=np.zeros({0},"uint64"); same(np.count_nonzero(a),0) end
do local a=np.array({{math.huge,-0.0,(0/0)},{-2.0,math.huge,math.huge}},"float16"); local v=np.all(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true,false,true},{true,true,true}}) end
do local a=np.transpose(np.zeros({2,0},"int8")); same(np.any(a),false) end
do local a=np.transpose(np.zeros({0,3},"uint8")); same(np.all(a),true) end
do local a=np.transpose(np.array({{{5,5,0},{1,5,0}}},"uint8")); same(np.any(a),true) end
do local a=np.array({{0},{0}},"int32"); same(np.any(a),false) end
do local a=np.array({{{0,0},{5,1},{0,5}},{{0,0},{0,5},{0,1}}},"int16"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{true}}}) end
do local a=np.array(5,"int16"); same(np.all(a,{where=false}),true) end
do local a=np.array({np.complex(0.0,0.0),np.complex((0/0),0.0),np.complex(-1.0,0.0),np.complex((0/0),0.0)},"complex64"); same(np.count_nonzero(a,{axis=1}),3) end
do local a=np.flip(np.zeros({0,3},"float16"),2); same(np.any(a,{axis={1,2}}),false) end
do local a=np.transpose(np.array({{"XX",""},{"",""},{"XX","a"}},"U3")); same(np.all(a),false) end
do local a=np.flip(np.array({{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(2.0,0.0)},{np.complex(2.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}},"complex64"),2); same(np.any(a),true) end
do local a=np.array({{0,1},{5,1},{1,0}},"uint8"); same(np.count_nonzero(a),4) end
do local a=np.array({0,0,1,5},"uint8"); same(np.any(a,{axis={1}}),true) end
do local a=np.array({{{5,1},{0,1},{1,0}},{{5,5},{1,0},{0,5}}},"uint8"); same(np.count_nonzero(a),8) end
do local a=np.flip(np.zeros({2,0},"complex64"),2); same(np.count_nonzero(a,{axis={1,2}}),0) end
do local a=np.array({np.complex((0/0),0.0),np.complex(0.0,3.0)},"complex64"); same(np.count_nonzero(a,{axis=1}),2) end
do local a=np.transpose(np.zeros({2,0,3},"float32")); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{},{},{}}) end
do local a=np.array({5,5},"uint64"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{true,true}) end
do local a=np.array({{0},{5}},"int16"); same(np.all(a),false) end
do local a=np.array({{{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex((0/0),0.0)},{np.complex(0.0,3.0),np.complex((0/0),3.0),np.complex(0.0,0.0)}}},"complex64"); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{{false,false,true},{true,true,false}}}) end
do local a=np.transpose(np.array({{1},{1}},"uint64")); local v=np.all(a,{axis=2,where=np.array({{true,false}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.flip(np.array({-2.0,(0/0),-0.0,4.0},"float16"),1); local v=np.all(a,{axis={1},keepdims=true,where=false});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.zeros({0,3},"U3"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.zeros({0},"int32"); same(np.any(a,{axis={1},where=np.zeros({0},"bool")}),false) end
do local a=np.array({{false,true},{false,false},{false,true}},"bool"); local v=np.all(a,{axis=1,where=true});assert(v.dtype=="bool")
same(v:tolist(),{false,false}) end
do local a=np.flip(np.zeros({0},"float32"),1); same(np.count_nonzero(a),0) end
do local a=np.flip(np.zeros({2,0,3},"int8"),3); same(np.any(a,{axis={1,2,3}}),false) end
do local a=np.array({{{0,0,5},{0,1,0}}},"int8"); same(np.any(a,{where=true}),true) end
do local a=np.transpose(np.zeros({2,0},"int8")); same(np.all(a,{where=np.zeros({0,2},"bool")}),true) end
do local a=np.array({{-2.0,-0.0},{0.0,0.0},{math.huge,-2.0}},"float64"); local v=np.count_nonzero(a,{axis=1});assert(v.dtype=="int64")
same(v:tolist(),{2,1}) end
do local a=np.zeros({0,3},"S3"); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.array({{true,true,false},{false,true,false}},"bool"); local v=np.all(a,{axis={},where=np.array({{false,true,true},{false,false,false}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{true,true,false},{true,true,true}}) end
do local a=np.flip(np.zeros({0,3},"bool"),2); local v=np.all(a,{axis={},where=np.array({{true,true,true}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.array({"XX","XX"},"U3"); local v=np.all(a,{axis={1},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array({np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex((0/0),0.0)},"complex64"); same(np.any(a,{axis={1}}),true) end
do local a=np.array({{{0,0,1},{1,0,0}}},"int32"); same(np.any(a,{where=true}),true) end
do local a=np.zeros({0,3},"int16"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.array({0,9007199254740995},"int64"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{1}) end
do local a=np.flip(np.array({"xyz","XX","XX","xyz"},"S3"),1); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{true,true,true,true}) end
do local a=np.transpose(np.array({{math.huge},{-2.0}},"float64")); same(np.all(a),true) end
do local a=np.array(0,"uint8"); same(np.all(a,{axis={},keepdims=true}),false) end
do local a=np.transpose(np.array({{{0,1,0},{5,5,1}}},"int8")); same(np.count_nonzero(a),4) end
do local a=np.array({{{0,5,0},{-1,1,5}}},"int16"); same(np.all(a),false) end
do local a=np.flip(np.zeros({0,3},"bool"),2); same(np.count_nonzero(a),0) end
do local a=np.transpose(np.zeros({0,3},"int64")); same(np.count_nonzero(a),0) end
do local a=np.array({"a"},"U3"); same(np.all(a,{where=np.array({false},"bool")}),true) end
do local a=np.flip(np.array({{{np.complex(2.0,0.0),np.complex(0.0,0.0),np.complex(2.0,3.0)},{np.complex((0/0),3.0),np.complex(0.0,0.0),np.complex((0/0),0.0)}}},"complex128"),3); local v=np.all(a,{axis=2,where=np.array({{{true,false,true},{false,true,false}}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{true,false,true}}) end
do local a=np.array({{"XX","a",""},{"a","","xyz"}},"S3"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{1,1,0},{1,0,1}}) end
do local a=np.array({{{0,0},{5,5},{1,1}},{{0,1},{5,-1},{1,-1}}},"int32"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{true}}}) end
do local a=np.array({np.complex((0/0),3.0)},"complex64"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array({{0.0,(0/0),(0/0)},{0.0,-0.0,4.0}},"float16"); same(np.count_nonzero(a),3) end
do local a=np.array({{0},{1}},"int16"); local v=np.any(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false},{true}}) end
do local a=np.array({{1,9007199254740995,9007199254740995},{1,5,0}},"uint64"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.transpose(np.array({{0.0,0.0},{-0.0,4.0},{0.0,0.0}},"float16")); same(np.all(a,{axis={1,2}}),false) end
do local a=np.array({0,1},"uint8"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{false,true}) end
do local a=np.array({{0,0,0},{-1,0,0}},"int16"); same(np.all(a,{where=false}),true) end
do local a=np.array({np.complex(2.0,0.0),np.complex(0.0,0.0)},"complex64"); same(np.any(a,{where=false}),false) end
do local a=np.array({{"xyz","XX","XX"},{"XX","","XX"}},"U3"); local v=np.all(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{true,false}) end
do local a=np.zeros({2,0,3},"float32"); same(np.count_nonzero(a,{axis={1,2,3}}),0) end
do local a=np.transpose(np.zeros({2,0,3},"complex128")); same(np.all(a),true) end
do local a=np.zeros({2,0,3},"complex64"); same(np.all(a),true) end
do local a=np.flip(np.array({9007199254740995,5},"int64"),1); local v=np.any(a,{axis={},keepdims=true,where=np.array({false,true},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{false,true}) end
do local a=np.array(1,"uint64"); same(np.any(a,{keepdims=true}),true) end
do local a=np.transpose(np.array({{-0.0,math.huge},{0.0,4.0},{0.0,-2.0}},"float32")); same(np.all(a,{axis={1,2}}),false) end
do local a=np.flip(np.array({"a","a","xyz","a"},"S3"),1); same(np.count_nonzero(a),4) end
do local a=np.zeros({2,0,3},"complex128"); local v=np.count_nonzero(a,{axis=1});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.array({"",""},"U3"); same(np.any(a,{where=true}),false) end
do local a=np.array({{0,-1,1},{0,0,0}},"int32"); same(np.all(a),false) end
do local a=np.zeros({2,0},"U3"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0}}) end
do local a=np.array({"XX"},"U3"); same(np.count_nonzero(a),1) end
do local a=np.array({{0.0,4.0},{0.0,0.0},{4.0,(0/0)}},"float32"); same(np.count_nonzero(a),3) end
do local a=np.zeros({2,0},"int8"); same(np.count_nonzero(a),0) end
do local a=np.array({{np.complex(-1.0,0.0)},{np.complex((0/0),3.0)}},"complex64"); same(np.all(a,{axis={1,2}}),true) end
do local a=np.flip(np.array({{math.huge,0.0,math.huge},{4.0,(0/0),(0/0)}},"float16"),2); local v=np.all(a,{keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.flip(np.array({0},"uint64"),1); same(np.any(a,{where=true}),false) end
do local a=np.transpose(np.array({{4.0},{0.0}},"float16")); local v=np.all(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true,false}}) end
do local a=np.flip(np.zeros({2,0,3},"int64"),3); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.array({{5,0,5},{0,-1,-1}},"int32"); same(np.any(a,{where=np.array({{false,true,false},{false,true,true}},"bool")}),true) end
do local a=np.array({true},"bool"); same(np.all(a,{axis=1}),true) end
do local a=np.array({{np.complex(0.0,3.0)},{np.complex(0.0,0.0)}},"complex128"); same(np.all(a),false) end
do local a=np.flip(np.zeros({0,3},"uint64"),2); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.array(np.complex(-1.0,3.0),"complex64"); same(np.all(a),true) end
do local a=np.zeros({0},"bool"); same(np.count_nonzero(a,{axis={1}}),0) end
do local a=np.array(np.complex(0.0,0.0),"complex128"); same(np.count_nonzero(a),0) end
do local a=np.array({{np.complex((0/0),0.0)},{np.complex(0.0,0.0)}},"complex64"); same(np.count_nonzero(a),1) end
do local a=np.array({{{5,0},{0,0},{-1,0}},{{1,0},{0,-1},{1,0}}},"int32"); same(np.count_nonzero(a),5) end
do local a=np.array(-1,"int8"); same(np.count_nonzero(a),1) end
do local a=np.array({0},"int32"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{0}) end
do local a=np.array({{np.complex(-1.0,3.0),np.complex(0.0,3.0),np.complex(2.0,0.0)},{np.complex(0.0,0.0),np.complex(-1.0,0.0),np.complex(-1.0,0.0)}},"complex128"); local v=np.all(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{false,true,true}) end
do local a=np.array({{{0,0,-1},{5,5,1}}},"int8"); same(np.any(a),true) end
do local a=np.array({true,false},"bool"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{true,false}) end
do local a=np.transpose(np.zeros({0,3},"uint64")); local v=np.all(a,{axis={},where=np.zeros({3,0},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{},{},{}}) end
do local a=np.array({"a",""},"U3"); same(np.count_nonzero(a),1) end
do local a=np.array({{0},{9007199254740995}},"int64"); same(np.count_nonzero(a),1) end
do local a=np.transpose(np.zeros({2,0,3},"uint8")); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{},{},{}}) end
do local a=np.array({{0,1},{1,1},{0,0}},"uint8"); local v=np.all(a,{axis=2,keepdims=true,where=np.array({{true,true}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{false},{true},{false}}) end
do local a=np.flip(np.zeros({0},"int8"),1); same(np.all(a,{axis=1}),true) end
do local a=np.flip(np.zeros({0},"U3"),1); local v=np.any(a,{axis={},where=false});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.transpose(np.array({{{0,5},{0,0},{0,0}},{{0,-1},{1,0},{5,0}}},"int8")); local v=np.any(a,{axis=3});assert(v.dtype=="bool")
same(v:tolist(),{{false,true,true},{true,false,false}}) end
do local a=np.array(9007199254740995,"uint64"); same(np.count_nonzero(a),1) end
do local a=np.zeros({2,0},"U3"); same(np.all(a),true) end
do local a=np.zeros({2,0},"uint64"); same(np.any(a),false) end
do local a=np.flip(np.array({{5,-1},{0,1},{1,0}},"int32"),2); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.zeros({2,0},"int16"); same(np.count_nonzero(a,{axis={1,2}}),0) end
do local a=np.array({"xyz","","a","XX"},"U3"); same(np.all(a,{axis={1}}),false) end
do local a=np.array({{np.complex((0/0),0.0),np.complex((0/0),3.0)},{np.complex(-1.0,0.0),np.complex(0.0,0.0)},{np.complex(2.0,0.0),np.complex(0.0,0.0)}},"complex128"); same(np.count_nonzero(a),4) end
do local a=np.flip(np.array({{{"","a","XX"},{"","","XX"}}},"U3"),3); local v=np.count_nonzero(a,{axis=3});assert(v.dtype=="int64")
same(v:tolist(),{{2,1}}) end
do local a=np.transpose(np.array({{-2.0,-0.0},{0.0,-2.0},{0.0,math.huge}},"float64")); local v=np.all(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{false,false,false}) end
do local a=np.flip(np.zeros({0},"float64"),1); same(np.any(a,{where=true}),false) end
do local a=np.flip(np.array({{{0,0},{0,0},{-1,-1}},{{5,-1},{1,0},{0,0}}},"int8"),3); local v=np.any(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{{true,true},{false,true},{true,true}}) end
do local a=np.array({false,true},"bool"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{1}) end
do local a=np.array({0.0,math.huge,(0/0),-0.0},"float32"); local v=np.any(a,{axis={1},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.zeros({0},"int8"); same(np.any(a),false) end
do local a=np.flip(np.array({"a"},"S3"),1); same(np.all(a),true) end
do local a=np.flip(np.zeros({2,0},"int8"),2); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{},{}}) end
do local a=np.array({np.complex(0.0,3.0),np.complex((0/0),0.0)},"complex64"); local v=np.any(a,{axis={},where=false});assert(v.dtype=="bool")
same(v:tolist(),{false,false}) end
do local a=np.flip(np.array({np.complex(2.0,0.0),np.complex(-1.0,3.0),np.complex(0.0,0.0),np.complex((0/0),0.0)},"complex64"),1); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{true,false,true,true}) end
do local a=np.array({4.0,-0.0},"float32"); same(np.any(a),true) end
do local a=np.zeros({2,0,3},"uint8"); same(np.all(a,{where=np.array({{{true,false,true}}},"bool")}),true) end
do local a=np.flip(np.array({{false,false,false},{true,true,false}},"bool"),2); local v=np.count_nonzero(a,{axis=2,keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0},{2}}) end
do local a=np.flip(np.array({{0.0,0.0,4.0},{0.0,-2.0,0.0}},"float16"),2); local v=np.count_nonzero(a,{axis=1,keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{1,1,0}}) end
do local a=np.array({4.0,-2.0},"float32"); same(np.any(a,{where=np.array({true,false},"bool")}),true) end
do local a=np.flip(np.zeros({0},"complex128"),1); same(np.all(a,{axis={1}}),true) end
do local a=np.array({{"a","xyz"},{"a","xyz"},{"xyz","a"}},"S3"); local v=np.all(a,{keepdims=true,where=false});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.transpose(np.zeros({0,3},"S3")); local v=np.any(a,{axis=2,keepdims=true,where=false});assert(v.dtype=="bool")
same(v:tolist(),{{false},{false},{false}}) end
do local a=np.array({np.complex(0.0,0.0)},"complex64"); same(np.count_nonzero(a,{axis=1}),0) end
do local a=np.flip(np.zeros({2,0},"U3"),2); local v=np.any(a,{axis={},keepdims=true,where=np.array({{}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.zeros({2,0},"float16"); same(np.all(a,{axis={1,2}}),true) end
do local a=np.transpose(np.array({{{math.huge,0.0},{4.0,(0/0)},{0.0,4.0}},{{math.huge,(0/0)},{-2.0,-2.0},{0.0,-2.0}}},"float64")); same(np.count_nonzero(a),9) end
do local a=np.array({0,0},"int32"); same(np.count_nonzero(a),0) end
do local a=np.transpose(np.zeros({2,0,3},"int16")); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{},{},{}}) end
do local a=np.array({np.complex(2.0,3.0),np.complex((0/0),0.0)},"complex64"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{1,1}) end
do local a=np.zeros({0,3},"float32"); same(np.count_nonzero(a),0) end
do local a=np.array(1,"int16"); same(np.all(a),true) end
do local a=np.array({"XX"},"U3"); local v=np.any(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array({{""},{"a"}},"S3"); same(np.all(a),false) end
do local a=np.array({1,9007199254740995},"uint64"); same(np.count_nonzero(a,{axis={1}}),2) end
do local a=np.flip(np.array({{-1,-1,0},{5,-1,0}},"int8"),2); same(np.count_nonzero(a),4) end
do local a=np.flip(np.array({{-1,0},{0,0},{0,-1}},"int8"),2); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{0,1},{0,0},{1,0}}) end
do local a=np.zeros({0},"float32"); same(np.all(a),true) end
do local a=np.array(5,"int8"); same(np.count_nonzero(a),1) end
do local a=np.flip(np.array({{{0,1,0},{0,1,0}}},"int8"),3); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{{0,1,0},{0,1,0}}}) end
do local a=np.zeros({2,0},"complex128"); same(np.all(a),true) end
do local a=np.flip(np.array({{false,false},{false,false},{false,false}},"bool"),2); same(np.all(a,{where=false}),true) end
do local a=np.flip(np.zeros({2,0},"float64"),2); local v=np.any(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.array(0,"int32"); same(np.all(a,{keepdims=true,where=false}),true) end
do local a=np.flip(np.zeros({2,0,3},"complex128"),3); same(np.count_nonzero(a,{axis={1,2,3}}),0) end
do local a=np.zeros({0},"int64"); same(np.count_nonzero(a),0) end
do local a=np.transpose(np.array({{{1,9007199254740995},{0,5},{0,0}},{{1,1},{1,0},{9007199254740995,0}}},"uint64")); same(np.count_nonzero(a),7) end
do local a=np.flip(np.zeros({0},"float64"),1); same(np.all(a),true) end
do local a=np.array({0,0},"uint64"); same(np.any(a,{axis=1}),false) end
do local a=np.flip(np.array({{5,-1},{0,1},{0,0}},"int16"),2); same(np.any(a,{where=true}),true) end
do local a=np.array(4.0,"float64"); same(np.count_nonzero(a),1) end
do local a=np.flip(np.zeros({0,3},"int64"),2); same(np.any(a),false) end
do local a=np.zeros({0},"S3"); same(np.count_nonzero(a,{axis=1}),0) end
do local a=np.flip(np.zeros({0},"S3"),1); same(np.count_nonzero(a),0) end
do local a=np.array(0.0,"float32"); same(np.any(a),false) end
do local a=np.array({{0.0,4.0,-0.0},{-0.0,0.0,0.0}},"float32"); same(np.all(a),false) end
do local a=np.transpose(np.zeros({0,3},"int8")); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0}}) end
do local a=np.array({{5,5},{0,0},{0,0}},"int32"); same(np.any(a),true) end
do local a=np.transpose(np.array({{{4.0,-0.0},{math.huge,math.huge},{-2.0,-2.0}},{{-0.0,math.huge},{-2.0,math.huge},{0.0,0.0}}},"float64")); local v=np.all(a,{axis=3,keepdims=true,where=np.array({{{false,true}}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{{false},{true},{false}},{{true},{true},{false}}}) end
do local a=np.array({{5,1},{5,1},{0,-1}},"int32"); local v=np.all(a,{axis={1,2},keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.array(9007199254740995,"uint64"); same(np.count_nonzero(a,{axis={}}),1) end
do local a=np.array({1},"uint64"); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.zeros({0},"uint8"); same(np.any(a,{axis={1}}),false) end
do local a=np.flip(np.array({{-0.0},{math.huge}},"float64"),2); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{false},{true}}) end
do local a=np.flip(np.array({{"xyz","a","xyz"},{"","","a"}},"S3"),2); same(np.all(a,{axis={1,2}}),false) end
do local a=np.array({{"a",""},{"XX",""},{"a","XX"}},"S3"); same(np.count_nonzero(a),4) end
do local a=np.zeros({0,3},"float64"); local v=np.any(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.flip(np.array({{-0.0,0.0,-0.0},{(0/0),0.0,(0/0)}},"float32"),2); local v=np.count_nonzero(a,{axis=1});assert(v.dtype=="int64")
same(v:tolist(),{1,0,1}) end
do local a=np.array({0,0},"uint64"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.transpose(np.array({{{np.complex(2.0,0.0),np.complex(2.0,0.0)},{np.complex(0.0,0.0),np.complex(-1.0,0.0)},{np.complex(0.0,3.0),np.complex(0.0,0.0)}},{{np.complex(0.0,3.0),np.complex(-1.0,0.0)},{np.complex(0.0,3.0),np.complex(-1.0,3.0)},{np.complex(0.0,0.0),np.complex(0.0,3.0)}}},"complex64")); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{{1,1},{0,1},{1,0}},{{1,1},{1,1},{0,1}}}) end
do local a=np.zeros({2,0,3},"float64"); same(np.count_nonzero(a),0) end
do local a=np.flip(np.zeros({2,0},"int16"),2); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{},{}}) end
do local a=np.array({{{4.0,-0.0},{-0.0,0.0},{4.0,-0.0}},{{-2.0,(0/0)},{-2.0,math.huge},{4.0,0.0}}},"float16"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{{1,0},{0,0},{1,0}},{{1,1},{1,1},{1,0}}}) end
do local a=np.array({{false},{true}},"bool"); local v=np.all(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{false,true}) end
do local a=np.transpose(np.zeros({0,3},"complex128")); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0}}) end
do local a=np.array({1},"uint8"); same(np.all(a,{axis=1,where=true}),true) end
do local a=np.array({0,0,0,5},"int32"); same(np.any(a,{axis=1,where=true}),true) end
do local a=np.array({{np.complex(0.0,3.0),np.complex(2.0,0.0)},{np.complex(0.0,3.0),np.complex((0/0),0.0)},{np.complex(2.0,3.0),np.complex((0/0),0.0)}},"complex64"); local v=np.any(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{true,true,true}) end
do local a=np.transpose(np.zeros({0,3},"uint64")); local v=np.all(a,{axis=1,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{}}) end
do local a=np.flip(np.array({{0},{0}},"int16"),2); same(np.count_nonzero(a),0) end
do local a=np.zeros({0},"complex64"); same(np.count_nonzero(a,{axis={1}}),0) end
do local a=np.array(0,"int8"); same(np.any(a),false) end
do local a=np.transpose(np.array({{0},{5}},"int32")); local v=np.any(a,{axis=2,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.transpose(np.array({{{0.0,-0.0,-0.0},{-0.0,0.0,0.0}}},"float64")); same(np.any(a,{where=true}),false) end
do local a=np.zeros({0},"float64"); same(np.count_nonzero(a,{axis={1}}),0) end
do local a=np.flip(np.array({0,0,5,0},"int16"),1); same(np.any(a),true) end
do local a=np.array({{{1,5},{1,1},{0,5}},{{5,-1},{5,0},{-1,5}}},"int16"); same(np.count_nonzero(a),10) end
do local a=np.array(-2.0,"float64"); same(np.any(a,{keepdims=true}),true) end
do local a=np.array(-2.0,"float32"); same(np.any(a),true) end
do local a=np.zeros({0},"U3"); same(np.count_nonzero(a),0) end
do local a=np.array({np.complex((0/0),0.0),np.complex(-1.0,0.0),np.complex((0/0),3.0),np.complex(-1.0,0.0)},"complex128"); same(np.any(a,{axis={1}}),true) end
do local a=np.array({{"","XX",""},{"xyz","XX","XX"}},"U3"); same(np.any(a),true) end
do local a=np.transpose(np.array({{-1,5,0},{0,-1,0}},"int8")); same(np.all(a,{where=false}),true) end
do local a=np.flip(np.array({-1,0,0,1},"int8"),1); same(np.all(a,{where=np.array({false,false,false,false},"bool")}),true) end
do local a=np.array({false,true,false,true},"bool"); same(np.any(a),true) end
do local a=np.zeros({0},"float64"); same(np.any(a,{where=true}),false) end
do local a=np.zeros({0,3},"float32"); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.array(5,"int64"); same(np.count_nonzero(a),1) end
do local a=np.transpose(np.array({{(0/0)},{(0/0)}},"float64")); local v=np.count_nonzero(a,{axis={1,2},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{2}}) end
do local a=np.array({{-2.0,(0/0),math.huge},{0.0,(0/0),(0/0)}},"float64"); local v=np.any(a,{axis={},where=false});assert(v.dtype=="bool")
same(v:tolist(),{{false,false,false},{false,false,false}}) end
do local a=np.flip(np.zeros({0,3},"int32"),2); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0}}) end
do local a=np.transpose(np.array({{-2.0,0.0},{0.0,(0/0)},{-2.0,0.0}},"float64")); same(np.count_nonzero(a,{axis={1,2}}),3) end
do local a=np.flip(np.array({false,true},"bool"),1); same(np.all(a,{where=false}),true) end
do local a=np.array({false,true,false,true},"bool"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{2}) end
do local a=np.flip(np.zeros({2,0},"uint8"),2); same(np.count_nonzero(a,{axis={1,2}}),0) end
do local a=np.flip(np.array({{{np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex((0/0),0.0),np.complex((0/0),0.0)},{np.complex(0.0,3.0),np.complex(-1.0,0.0)}},{{np.complex(0.0,0.0),np.complex(-1.0,0.0)},{np.complex(2.0,3.0),np.complex(0.0,0.0)},{np.complex(0.0,3.0),np.complex(0.0,0.0)}}},"complex128"),3); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{{false,false},{true,true},{true,true}},{{true,false},{false,true},{false,true}}}) end
do local a=np.zeros({2,0,3},"int8"); same(np.any(a,{axis={1,2,3},where=np.zeros({2,0,3},"bool")}),false) end
do local a=np.array({{np.complex(0.0,0.0),np.complex(-1.0,3.0),np.complex(2.0,0.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}},"complex64"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{false,true,true},{false,false,false}}) end
do local a=np.flip(np.array({{{"XX","XX"},{"xyz","XX"},{"a",""}},{{"a",""},{"xyz","XX"},{"xyz","a"}}},"S3"),3); local v=np.all(a,{axis={1,2,3},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{false}}}) end
do local a=np.array({{0,-1},{0,0},{-1,0}},"int16"); same(np.all(a),false) end
do local a=np.array({-0.0,-0.0},"float32"); same(np.count_nonzero(a),0) end
do local a=np.array(0.0,"float16"); same(np.count_nonzero(a,{axis={}}),0) end
do local a=np.array({4.0},"float64"); same(np.count_nonzero(a),1) end
do local a=np.array({{0,0,5},{1,0,-1}},"int64"); local v=np.all(a,{axis=2,where=np.array({{true,false,true}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{false,true}) end
do local a=np.array({math.huge,-0.0},"float16"); same(np.all(a,{axis={1},where=np.array({false,true},"bool")}),false) end
do local a=np.transpose(np.array({{"XX","xyz","a"},{"XX","xyz","xyz"}},"U3")); same(np.count_nonzero(a),6) end
do local a=np.transpose(np.array({{0,1},{1,5},{0,0}},"uint8")); same(np.any(a,{axis={1,2},where=true}),true) end
do local a=np.transpose(np.array({{{5,0},{1,-1},{0,0}},{{5,1},{0,0},{1,-1}}},"int16")); same(np.any(a),true) end
do local a=np.transpose(np.array({{{0.0,0.0},{-0.0,0.0},{(0/0),0.0}},{{0.0,math.huge},{4.0,math.huge},{4.0,-2.0}}},"float64")); same(np.count_nonzero(a),6) end
do local a=np.array({{{(0/0),4.0},{-0.0,0.0},{(0/0),math.huge}},{{(0/0),4.0},{-2.0,-2.0},{(0/0),(0/0)}}},"float64"); same(np.any(a,{axis={1,2,3}}),true) end
do local a=np.zeros({2,0},"complex128"); same(np.all(a,{axis={1,2}}),true) end
do local a=np.array({{{0.0,(0/0)},{-0.0,0.0},{-2.0,-2.0}},{{-0.0,-0.0},{-0.0,-2.0},{-2.0,0.0}}},"float64"); local v=np.any(a,{keepdims=true,where=np.array({{{true,false}}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{{true}}}) end
do local a=np.zeros({0},"int16"); same(np.any(a),false) end
do local a=np.array({4.0},"float16"); same(np.all(a),true) end
do local a=np.array({{{np.complex(-1.0,0.0),np.complex(0.0,3.0)},{np.complex(2.0,0.0),np.complex(0.0,0.0)},{np.complex(-1.0,0.0),np.complex(2.0,0.0)}},{{np.complex(0.0,3.0),np.complex(-1.0,0.0)},{np.complex((0/0),3.0),np.complex((0/0),3.0)},{np.complex(2.0,3.0),np.complex(0.0,0.0)}}},"complex64"); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{1,1},{1,0},{1,1}},{{1,1},{1,1},{1,0}}}) end
do local a=np.zeros({2,0,3},"U3"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{0}}}) end
do local a=np.array({{np.complex(0.0,3.0),np.complex(-1.0,3.0)},{np.complex(0.0,3.0),np.complex(2.0,3.0)},{np.complex(-1.0,0.0),np.complex(0.0,3.0)}},"complex64"); same(np.any(a),true) end
do local a=np.array({{1,1,1},{0,1,9007199254740995}},"uint64"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{5}}) end
do local a=np.array({{"XX"},{"XX"}},"S3"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{true},{true}}) end
do local a=np.array({{{9007199254740995,0,0},{-1,5,-1}}},"int64"); same(np.any(a,{where=np.array({{{true,false,false},{false,false,true}}},"bool")}),true) end
do local a=np.array("XX","S3"); same(np.count_nonzero(a),1) end
do local a=np.flip(np.array({0,0},"uint8"),1); same(np.any(a),false) end
do local a=np.zeros({0,3},"bool"); same(np.any(a,{axis={1,2}}),false) end
do local a=np.flip(np.array({np.complex(0.0,0.0)},"complex128"),1); local v=np.count_nonzero(a,{axis={1},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{0}) end
do local a=np.array({4.0,(0/0),-2.0,0.0},"float32"); local v=np.any(a,{axis={},keepdims=true,where=false});assert(v.dtype=="bool")
same(v:tolist(),{false,false,false,false}) end
do local a=np.array({{np.complex(0.0,0.0),np.complex(2.0,0.0),np.complex((0/0),0.0)},{np.complex(0.0,0.0),np.complex(0.0,3.0),np.complex((0/0),0.0)}},"complex128"); same(np.all(a),false) end
do local a=np.flip(np.zeros({0},"int64"),1); same(np.count_nonzero(a,{axis=1}),0) end
do local a=np.zeros({0,3},"int16"); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.array({{0,1},{0,0},{1,0}},"uint8"); local v=np.any(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false,true},{false,false},{true,false}}) end
do local a=np.zeros({2,0},"int64"); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{},{}}) end
do local a=np.transpose(np.array({{0,5,0},{5,1,9007199254740995}},"uint64")); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{0,1},{1,1},{0,1}}) end
do local a=np.flip(np.array({0},"int16"),1); same(np.count_nonzero(a,{axis={1}}),0) end
do local a=np.array({{0,5},{5,0},{0,-1}},"int16"); local v=np.any(a,{axis=1,where=true});assert(v.dtype=="bool")
same(v:tolist(),{true,true}) end
do local a=np.array(0,"int32"); same(np.any(a),false) end
do local a=np.transpose(np.array({{4.0},{4.0}},"float64")); same(np.all(a),true) end
do local a=np.array({{"XX","a"},{"XX","xyz"},{"xyz","a"}},"S3"); same(np.all(a,{axis={1,2}}),true) end
do local a=np.array({{false},{true}},"bool"); same(np.any(a),true) end
do local a=np.array({5},"uint8"); same(np.all(a,{where=np.array({false},"bool")}),true) end
do local a=np.transpose(np.array({{"XX","xyz"},{"xyz","xyz"},{"XX","XX"}},"S3")); same(np.all(a),true) end
do local a=np.array({""},"U3"); same(np.all(a),false) end
do local a=np.flip(np.array({{9007199254740995,1},{0,9007199254740995},{5,9007199254740995}},"uint64"),2); same(np.all(a),false) end
do local a=np.array(np.complex(-1.0,0.0),"complex64"); same(np.any(a,{axis={}}),true) end
do local a=np.flip(np.zeros({0,3},"uint64"),2); same(np.any(a),false) end
do local a=np.array({9007199254740995,5,0,0},"uint64"); same(np.all(a),false) end
do local a=np.array({(0/0)},"float32"); same(np.any(a,{axis=1}),true) end
do local a=np.array({0},"int32"); same(np.count_nonzero(a),0) end
do local a=np.transpose(np.array({{true,false},{false,false},{false,false}},"bool")); same(np.any(a,{where=np.array({{true,false,true},{true,false,true}},"bool")}),true) end
do local a=np.array({{{math.huge,0.0},{math.huge,(0/0)},{0.0,(0/0)}},{{0.0,(0/0)},{4.0,-2.0},{-0.0,4.0}}},"float64"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{{1,0},{1,1},{0,1}},{{0,1},{1,1},{0,1}}}) end
do local a=np.array({{{0,0},{9007199254740995,0},{0,1}},{{-1,0},{0,5},{9007199254740995,0}}},"int64"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{{false,false},{true,false},{false,true}},{{true,false},{false,true},{true,false}}}) end
do local a=np.zeros({2,0},"int32"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true}}) end
do local a=np.array({0,-1},"int16"); same(np.all(a,{axis=1}),false) end
do local a=np.transpose(np.array({{{false,false,false},{true,true,false}}},"bool")); local v=np.count_nonzero(a,{axis=2});assert(v.dtype=="int64")
same(v:tolist(),{{1},{1},{0}}) end
do local a=np.flip(np.zeros({0,3},"float16"),2); local v=np.any(a,{axis=2,where=np.zeros({0,3},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.zeros({0},"int8"); same(np.any(a),false) end
do local a=np.zeros({2,0},"uint64"); same(np.count_nonzero(a),0) end
do local a=np.zeros({2,0,3},"int64"); same(np.any(a,{where=np.zeros({2,0,3},"bool")}),false) end
do local a=np.array({1,1},"uint64"); same(np.count_nonzero(a),2) end
do local a=np.array({np.complex((0/0),3.0),np.complex(2.0,0.0),np.complex(0.0,0.0),np.complex(2.0,0.0)},"complex64"); local v=np.any(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true,true,false,true}) end
do local a=np.array({"","a"},"S3"); same(np.count_nonzero(a),1) end
do local a=np.flip(np.array({np.complex(2.0,3.0)},"complex64"),1); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{1}) end
do local a=np.flip(np.zeros({0},"float64"),1); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.transpose(np.zeros({2,0,3},"S3")); local v=np.all(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{},{},{}}) end
do local a=np.flip(np.zeros({2,0},"float64"),2); local v=np.any(a,{axis={},keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.zeros({2,0,3},"bool"); local v=np.count_nonzero(a,{axis=2});assert(v.dtype=="int64")
same(v:tolist(),{{0,0,0},{0,0,0}}) end
do local a=np.array({0.0,-0.0,(0/0),math.huge},"float32"); same(np.count_nonzero(a),2) end
do local a=np.array({{5,1,1},{0,5,1}},"int8"); same(np.any(a,{axis={1,2}}),true) end
do local a=np.zeros({0},"U3"); same(np.any(a),false) end
do local a=np.array({{5},{0}},"int16"); same(np.all(a),false) end
do local a=np.flip(np.zeros({2,0},"float64"),2); same(np.any(a,{axis={1,2},where=false}),false) end
do local a=np.flip(np.array({false,false,false,true},"bool"),1); local v=np.any(a,{axis=1,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.transpose(np.array({{0},{1}},"uint64")); local v=np.count_nonzero(a,{axis={1,2},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{1}}) end
do local a=np.flip(np.zeros({2,0},"int64"),2); same(np.all(a),true) end
do local a=np.array({math.huge,0.0,-0.0,(0/0)},"float32"); same(np.all(a,{where=np.array({true,true,false,false},"bool")}),false) end
do local a=np.array({{{-1,0},{0,0},{0,1}},{{0,0},{0,0},{0,1}}},"int16"); same(np.any(a,{axis={1,2,3}}),true) end
do local a=np.transpose(np.zeros({2,0,3},"complex64")); same(np.any(a),false) end
do local a=np.array({{{-0.0,-0.0,4.0},{4.0,-2.0,0.0}}},"float32"); same(np.count_nonzero(a,{axis={1,2,3}}),3) end
do local a=np.array({np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(2.0,3.0),np.complex(-1.0,3.0)},"complex64"); same(np.any(a,{axis={1},where=false}),false) end
do local a=np.flip(np.array({{{5,0,0},{0,0,0}}},"int8"),3); local v=np.count_nonzero(a,{axis=2});assert(v.dtype=="int64")
same(v:tolist(),{{0,0,1}}) end
do local a=np.zeros({0,3},"float32"); same(np.count_nonzero(a),0) end
do local a=np.flip(np.array({{{(0/0),(0/0),-2.0},{-2.0,-0.0,0.0}}},"float64"),3); same(np.all(a),false) end
do local a=np.array({0.0,0.0},"float64"); same(np.any(a,{axis=1,where=np.array({true,true},"bool")}),false) end
do local a=np.zeros({0,3},"S3"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.zeros({0},"S3"); same(np.any(a,{where=false}),false) end
do local a=np.transpose(np.array({{{true,false,false},{false,true,true}}},"bool")); local v=np.count_nonzero(a,{axis=2,keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{1}},{{1}},{{1}}}) end
do local a=np.transpose(np.zeros({0,3},"int32")); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{},{},{}}) end
do local a=np.array({{{-2.0,(0/0),-0.0},{(0/0),0.0,(0/0)}}},"float32"); same(np.any(a),true) end
do local a=np.array({{{np.complex((0/0),0.0),np.complex(0.0,0.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex(2.0,3.0),np.complex(0.0,0.0)}},{{np.complex((0/0),0.0),np.complex(0.0,0.0)},{np.complex(-1.0,3.0),np.complex(-1.0,0.0)},{np.complex(2.0,3.0),np.complex((0/0),0.0)}}},"complex128"); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{1,0},{0,0},{1,0}},{{1,0},{1,1},{1,1}}}) end
do local a=np.array({{"a"},{""}},"U3"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{1},{0}}) end
do local a=np.zeros({0,3},"int64"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{0}}) end
do local a=np.array({"a","","a","XX"},"S3"); local v=np.count_nonzero(a,{axis={1},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{3}) end
do local a=np.array({{0,0,1},{1,0,5}},"int8"); local v=np.all(a,{keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.transpose(np.array({{{0,0},{0,0},{0,0}},{{0,1},{0,0},{0,1}}},"uint8")); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{2}}}) end
do local a=np.zeros({0},"complex128"); same(np.any(a),false) end
do local a=np.flip(np.array({0,9007199254740995,1,9007199254740995},"uint64"),1); same(np.any(a),true) end
do local a=np.flip(np.array({"","xyz"},"U3"),1); same(np.count_nonzero(a),1) end
do local a=np.flip(np.array({{-0.0,0.0,0.0},{-0.0,4.0,0.0}},"float16"),2); same(np.count_nonzero(a,{axis={1,2}}),1) end
do local a=np.array({-1,0},"int8"); same(np.all(a,{axis={1}}),false) end
do local a=np.zeros({0},"complex128"); local v=np.count_nonzero(a,{axis=1,keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{0}) end
do local a=np.array({{{"XX","XX"},{"a",""},{"xyz","xyz"}},{{"XX",""},{"","XX"},{"a","XX"}}},"U3"); same(np.any(a,{axis={1,2,3}}),true) end
do local a=np.array({{{np.complex(-1.0,3.0),np.complex((0/0),0.0)},{np.complex((0/0),0.0),np.complex(0.0,3.0)},{np.complex((0/0),0.0),np.complex(0.0,0.0)}},{{np.complex((0/0),0.0),np.complex(2.0,3.0)},{np.complex(0.0,0.0),np.complex(2.0,3.0)},{np.complex(-1.0,0.0),np.complex((0/0),0.0)}}},"complex128"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{10}}}) end
do local a=np.zeros({2,0},"uint64"); local v=np.any(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{}) end
do local a=np.transpose(np.zeros({2,0,3},"complex64")); same(np.any(a,{where=false}),false) end
do local a=np.flip(np.array({{np.complex(2.0,0.0)},{np.complex((0/0),0.0)}},"complex128"),2); same(np.all(a,{axis={1,2}}),true) end
do local a=np.array(1,"uint8"); same(np.count_nonzero(a,{axis={}}),1) end
do local a=np.array(0,"uint8"); same(np.all(a,{keepdims=true}),false) end
do local a=np.array({{9007199254740995},{5}},"int64"); same(np.all(a,{where=np.array({{false}},"bool")}),true) end
do local a=np.array({{{np.complex((0/0),0.0),np.complex(-1.0,0.0),np.complex(0.0,3.0)},{np.complex(2.0,0.0),np.complex(0.0,0.0),np.complex(2.0,3.0)}}},"complex64"); same(np.all(a),false) end
do local a=np.zeros({0,3},"complex64"); local v=np.any(a,{keepdims=true,where=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.transpose(np.zeros({2,0,3},"int32")); local v=np.all(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{},{},{}}) end
do local a=np.array({{{0,-1},{5,0},{0,0}},{{0,0},{0,1},{0,0}}},"int16"); local v=np.count_nonzero(a,{axis=1});assert(v.dtype=="int64")
same(v:tolist(),{{0,1},{1,1},{0,0}}) end
do local a=np.array({{np.complex(2.0,3.0),np.complex(2.0,3.0),np.complex(0.0,0.0)},{np.complex(2.0,0.0),np.complex(-1.0,0.0),np.complex(0.0,0.0)}},"complex64"); same(np.any(a),true) end
do local a=np.array({5,1},"int8"); local v=np.count_nonzero(a,{axis={1},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{2}) end
do local a=np.transpose(np.zeros({2,0,3},"complex64")); same(np.count_nonzero(a,{axis={1,2,3}}),0) end
do local a=np.array({1,1,0,0},"int8"); local v=np.any(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true,true,false,false}) end
do local a=np.transpose(np.array({{0,0,0},{1,1,0}},"uint8")); local v=np.all(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{false,false,false}) end
do local a=np.transpose(np.array({{{0,1},{0,0},{1,0}},{{0,5},{5,0},{0,0}}},"int16")); local v=np.all(a,{axis=3});assert(v.dtype=="bool")
same(v:tolist(),{{false,false,false},{true,false,false}}) end
do local a=np.zeros({0},"int16"); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.array({"xyz"},"U3"); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array({{{0,5},{9007199254740995,1},{0,0}},{{-1,0},{0,-1},{0,0}}},"int64"); same(np.any(a),true) end
do local a=np.transpose(np.array({{false},{false}},"bool")); same(np.all(a,{where=true}),false) end
do local a=np.zeros({0},"float16"); same(np.all(a),true) end
do local a=np.zeros({2,0},"U3"); same(np.all(a,{where=true}),true) end
do local a=np.flip(np.zeros({2,0},"complex64"),2); local v=np.any(a,{axis=2,where=np.zeros({2,0},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{false,false}) end
do local a=np.zeros({0},"uint8"); same(np.all(a),true) end
do local a=np.zeros({0,3},"uint8"); same(np.all(a,{axis={1,2}}),true) end
do local a=np.array({{{0.0,-2.0},{0.0,0.0},{-0.0,4.0}},{{0.0,math.huge},{0.0,0.0},{4.0,0.0}}},"float16"); same(np.any(a),true) end
do local a=np.flip(np.array({{-0.0},{4.0}},"float32"),2); same(np.any(a,{axis={1,2},where=false}),false) end
do local a=np.flip(np.array({{"a"},{"XX"}},"S3"),2); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{true},{true}}) end
do local a=np.array({false},"bool"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{0}) end
do local a=np.transpose(np.array({{9007199254740995,-1,0},{5,5,0}},"int64")); same(np.any(a),true) end
do local a=np.array({{{np.complex((0/0),0.0),np.complex((0/0),0.0),np.complex(0.0,0.0)},{np.complex((0/0),3.0),np.complex(-1.0,0.0),np.complex(0.0,0.0)}}},"complex64"); local v=np.count_nonzero(a,{axis={},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{1,1,0},{1,1,0}}}) end
do local a=np.array({{{0.0,math.huge},{-2.0,4.0},{(0/0),0.0}},{{0.0,0.0},{4.0,-0.0},{0.0,4.0}}},"float32"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{{false,true},{true,true},{true,false}},{{false,false},{true,false},{false,true}}}) end
do local a=np.transpose(np.array({{-0.0,-0.0},{math.huge,(0/0)},{0.0,4.0}},"float64")); same(np.any(a,{where=np.array({{false,true,true}},"bool")}),true) end
do local a=np.zeros({2,0},"bool"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{},{}}) end
do local a=np.array({{-2.0,0.0,(0/0)},{-2.0,math.huge,math.huge}},"float64"); same(np.all(a),false) end
do local a=np.array({{{-2.0,0.0},{(0/0),4.0},{-2.0,-2.0}},{{4.0,4.0},{0.0,-2.0},{-0.0,-0.0}}},"float64"); same(np.any(a),true) end
do local a=np.transpose(np.array({{-1},{5}},"int64")); same(np.count_nonzero(a),2) end
do local a=np.array({{{1,1},{-1,1},{-1,0}},{{5,9007199254740995},{0,1},{9007199254740995,-1}}},"int64"); same(np.any(a,{axis={1,2,3},where=np.array({{{true,false},{true,false},{true,false}},{{false,true},{true,false},{false,true}}},"bool")}),true) end
do local a=np.array(1,"uint8"); same(np.count_nonzero(a),1) end
do local a=np.transpose(np.zeros({0,3},"int32")); same(np.all(a),true) end
do local a=np.flip(np.zeros({2,0,3},"int8"),3); same(np.all(a,{where=true}),true) end
do local a=np.flip(np.array({{0,0},{1,0},{1,5}},"uint8"),2); same(np.any(a),true) end
do local a=np.zeros({0,3},"S3"); same(np.count_nonzero(a),0) end
do local a=np.array({(0/0),-2.0},"float16"); local v=np.all(a,{keepdims=true,where=np.array({true,true},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.flip(np.array({-2.0,0.0,0.0,(0/0)},"float32"),1); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{1,0,0,1}) end
do local a=np.array(false,"bool"); same(np.any(a,{where=np.array(true,"bool")}),false) end
do local a=np.flip(np.zeros({0,3},"float64"),2); local v=np.all(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{true,true,true}) end
do local a=np.transpose(np.zeros({2,0,3},"complex128")); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{},{},{}}) end
do local a=np.zeros({2,0},"uint64"); same(np.count_nonzero(a),0) end
do local a=np.array({{{0,5},{0,0},{-1,5}},{{0,0},{-1,-1},{5,1}}},"int32"); same(np.all(a),false) end
do local a=np.array({{0},{0}},"uint8"); same(np.all(a,{axis={1,2}}),false) end
do local a=np.flip(np.array({{{true,true,true},{false,false,true}}},"bool"),3); local v=np.any(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{{true,true,true}}) end
do local a=np.zeros({0,3},"U3"); local v=np.any(a,{axis={1,2},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.array({{false},{true}},"bool"); local v=np.any(a,{axis=1,where=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.flip(np.zeros({0},"float16"),1); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{0}) end
do local a=np.array({0},"int8"); local v=np.any(a,{axis={1},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.flip(np.zeros({2,0,3},"complex64"),3); same(np.all(a),true) end
do local a=np.transpose(np.zeros({2,0,3},"bool")); same(np.any(a),false) end
do local a=np.array({(0/0)},"float64"); same(np.any(a,{axis={1},where=np.array({true},"bool")}),true) end
do local a=np.flip(np.array({{5,5},{0,0},{-1,0}},"int16"),2); same(np.all(a,{axis={1,2}}),false) end
do local a=np.array({{{false,false,true},{true,true,false}}},"bool"); same(np.count_nonzero(a),3) end
do local a=np.zeros({2,0,3},"int8"); same(np.all(a,{where=false}),true) end
do local a=np.array({{5,0,0},{5,1,1}},"int16"); same(np.all(a,{axis={1,2}}),false) end
do local a=np.flip(np.zeros({2,0,3},"S3"),3); same(np.all(a,{axis={1,2,3}}),true) end
do local a=np.transpose(np.zeros({2,0,3},"complex64")); same(np.count_nonzero(a,{axis={1,2,3}}),0) end
do local a=np.array({5,1,0,1},"int64"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{true,true,false,true}) end
do local a=np.transpose(np.array({{{-2.0,0.0},{-2.0,(0/0)},{(0/0),4.0}},{{0.0,(0/0)},{0.0,-0.0},{-0.0,0.0}}},"float64")); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{{{1,0},{1,0},{1,0}},{{0,1},{1,0},{1,0}}}) end
do local a=np.array(0,"int64"); same(np.all(a,{keepdims=true,where=np.array(true,"bool")}),false) end
do local a=np.array({np.complex(0.0,0.0),np.complex(2.0,0.0)},"complex128"); same(np.count_nonzero(a,{axis={1}}),1) end
do local a=np.flip(np.array({-2.0,0.0},"float16"),1); same(np.any(a),true) end
do local a=np.zeros({2,0},"uint8"); local v=np.all(a,{axis={},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.flip(np.array({{{1,0,0},{0,1,1}}},"uint8"),3); same(np.count_nonzero(a),3) end
do local a=np.array({-1},"int64"); local v=np.count_nonzero(a,{axis={}});assert(v.dtype=="int64")
same(v:tolist(),{1}) end
do local a=np.zeros({0},"bool"); same(np.all(a),true) end
do local a=np.zeros({2,0},"int32"); same(np.all(a,{where=true}),true) end
do local a=np.zeros({0},"complex64"); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array(9007199254740995,"int64"); same(np.all(a,{keepdims=true}),true) end
do local a=np.transpose(np.array({{{"",""},{"a","a"},{"XX",""}},{{"a","a"},{"","XX"},{"a",""}}},"S3")); local v=np.count_nonzero(a,{axis={1,2,3},keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{{7}}}) end
do local a=np.flip(np.zeros({0,3},"float32"),2); same(np.any(a,{where=np.array({{false,false,false}},"bool")}),false) end
do local a=np.array(0,"int32"); same(np.any(a,{keepdims=true}),false) end
do local a=np.zeros({2,0},"uint64"); same(np.any(a,{axis={1,2},where=np.zeros({2,0},"bool")}),false) end
do local a=np.transpose(np.array({{{5,0,0},{0,0,0}}},"int32")); same(np.all(a,{axis={1,2,3},where=true}),false) end
do local a=np.transpose(np.array({{-0.0,0.0},{4.0,4.0},{-2.0,(0/0)}},"float16")); same(np.count_nonzero(a),4) end
do local a=np.transpose(np.array({{{np.complex(-1.0,0.0),np.complex(0.0,3.0)},{np.complex(2.0,0.0),np.complex(0.0,0.0)},{np.complex(0.0,0.0),np.complex((0/0),0.0)}},{{np.complex((0/0),0.0),np.complex(0.0,0.0)},{np.complex(2.0,0.0),np.complex((0/0),3.0)},{np.complex(-1.0,0.0),np.complex((0/0),0.0)}}},"complex64")); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{{true,true},{true,true},{false,true}},{{true,false},{false,true},{true,true}}}) end
do local a=np.array({0,1},"int16"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{1}) end
do local a=np.array({{{false,false},{false,false},{false,false}},{{false,true},{true,true},{false,true}}},"bool"); local v=np.any(a,{axis=3});assert(v.dtype=="bool")
same(v:tolist(),{{false,false,false},{true,true,true}}) end
do local a=np.array({0},"int16"); local v=np.all(a,{axis={1},keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{false}) end
do local a=np.flip(np.array({math.huge},"float64"),1); same(np.count_nonzero(a,{axis={1}}),1) end
do local a=np.flip(np.array({5,0,0,5},"int8"),1); local v=np.any(a,{axis={},keepdims=true,where=false});assert(v.dtype=="bool")
same(v:tolist(),{false,false,false,false}) end
do local a=np.zeros({0},"int32"); same(np.all(a),true) end
do local a=np.array({{false,false},{true,false},{true,false}},"bool"); local v=np.all(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{false,false}) end
do local a=np.zeros({0},"int8"); same(np.all(a),true) end
do local a=np.flip(np.array({{5,-1},{0,0},{0,0}},"int8"),2); local v=np.any(a,{axis={},where=np.array({{true,true},{true,true},{true,true}},"bool")});assert(v.dtype=="bool")
same(v:tolist(),{{true,true},{false,false},{false,false}}) end
do local a=np.array({np.complex(0.0,3.0),np.complex(0.0,0.0)},"complex64"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{1}) end
do local a=np.array({{0.0,0.0},{0.0,0.0},{math.huge,0.0}},"float32"); same(np.all(a,{where=np.array({{false,true},{true,true},{true,false}},"bool")}),false) end
do local a=np.transpose(np.array({{{"xyz","a",""},{"a","a","xyz"}}},"S3")); same(np.count_nonzero(a),5) end
do local a=np.array({{true},{true}},"bool"); local v=np.any(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{true}) end
do local a=np.array({{(0/0),math.huge},{4.0,(0/0)},{4.0,4.0}},"float64"); same(np.any(a),true) end
do local a=np.array({{np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex(0.0,0.0),np.complex(0.0,3.0)},{np.complex(-1.0,3.0),np.complex(0.0,3.0)}},"complex128"); same(np.count_nonzero(a),3) end
do local a=np.transpose(np.array({{{0,0,0},{0,5,0}}},"int16")); same(np.all(a,{axis={1,2,3},where=true}),false) end
do local a=np.array({{{0,-1,9007199254740995},{0,5,0}}},"int64"); local v=np.any(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{{false,true,true},{false,true,false}}}) end
do local a=np.flip(np.array({{{-2.0,(0/0)},{0.0,(0/0)},{0.0,0.0}},{{(0/0),-2.0},{4.0,-0.0},{-0.0,4.0}}},"float32"),3); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{{true,true},{true,false},{false,false}},{{true,true},{false,true},{true,false}}}) end
do local a=np.array({{"XX","XX"},{"xyz","xyz"},{"","XX"}},"U3"); local v=np.any(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{true,true,true}) end
do local a=np.array({{1},{0}},"uint64"); same(np.all(a,{where=true}),false) end
do local a=np.transpose(np.array({{{-1,9007199254740995},{1,0},{1,9007199254740995}},{{5,0},{1,9007199254740995},{0,9007199254740995}}},"int64")); same(np.all(a,{where=true}),false) end
do local a=np.transpose(np.array({{{np.complex(-1.0,0.0),np.complex(0.0,0.0)},{np.complex(2.0,0.0),np.complex(-1.0,0.0)},{np.complex(0.0,3.0),np.complex(0.0,0.0)}},{{np.complex(-1.0,3.0),np.complex(0.0,0.0)},{np.complex(0.0,0.0),np.complex(-1.0,0.0)},{np.complex(-1.0,0.0),np.complex(-1.0,3.0)}}},"complex64")); local v=np.any(a,{axis=3});assert(v.dtype=="bool")
same(v:tolist(),{{true,true,true},{false,true,true}}) end
do local a=np.array({true,false},"bool"); same(np.all(a,{axis=1}),false) end
do local a=np.flip(np.array({{{0.0,4.0},{4.0,0.0},{math.huge,(0/0)}},{{0.0,-0.0},{0.0,(0/0)},{0.0,0.0}}},"float16"),3); same(np.count_nonzero(a),5) end
do local a=np.array({{-1},{1}},"int64"); local v=np.count_nonzero(a,{keepdims=true});assert(v.dtype=="int64")
same(v:tolist(),{{2}}) end
do local a=np.transpose(np.array({{0},{0}},"uint64")); same(np.any(a,{axis={1,2}}),false) end
do local a=np.zeros({2,0,3},"int32"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.flip(np.array({{4.0,-0.0},{-0.0,0.0},{-2.0,-0.0}},"float64"),2); local v=np.all(a,{keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{false}}) end
do local a=np.flip(np.array({np.complex(0.0,0.0),np.complex(2.0,0.0),np.complex((0/0),0.0),np.complex(0.0,3.0)},"complex128"),1); same(np.all(a),false) end
do local a=np.array({0,1,0,0},"uint64"); same(np.count_nonzero(a),1) end
do local a=np.flip(np.array({{"xyz"},{"a"}},"U3"),2); local v=np.any(a,{axis=2,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{true},{true}}) end
do local a=np.zeros({0,3},"uint8"); local v=np.count_nonzero(a,{axis=2});assert(v.dtype=="int64")
same(v:tolist(),{}) end
do local a=np.array({{{0.0,(0/0)},{(0/0),(0/0)},{(0/0),(0/0)}},{{(0/0),math.huge},{-0.0,math.huge},{0.0,4.0}}},"float16"); local v=np.count_nonzero(a,{axis=3});assert(v.dtype=="int64")
same(v:tolist(),{{1,2,2},{2,1,1}}) end
do local a=np.flip(np.array({{{"xyz","xyz"},{"XX",""},{"XX","a"}},{{"xyz","XX"},{"xyz","XX"},{"xyz","a"}}},"U3"),3); local v=np.all(a,{axis=2,keepdims=true});assert(v.dtype=="bool")
same(v:tolist(),{{{false,true}},{{true,true}}}) end
do local a=np.array({np.complex((0/0),3.0),np.complex(0.0,0.0)},"complex128"); same(np.any(a,{axis={1},where=np.array({false,true},"bool")}),false) end
do local a=np.array({{0},{1}},"uint8"); local v=np.any(a,{axis=2});assert(v.dtype=="bool")
same(v:tolist(),{false,true}) end
do local a=np.flip(np.array({{4.0},{-0.0}},"float16"),2); same(np.any(a),true) end
do local a=np.array({{(0/0),math.huge},{0.0,-2.0},{0.0,math.huge}},"float32"); same(np.any(a),true) end
do local a=np.zeros({2,0},"U3"); local v=np.all(a,{axis={}});assert(v.dtype=="bool")
same(v:tolist(),{{},{}}) end
do local a=np.transpose(np.array({{1},{0}},"int64")); same(np.all(a),false) end
do local a=np.array({{{5,0},{0,9007199254740995},{0,1}},{{9007199254740995,9007199254740995},{5,1},{1,5}}},"uint64"); local v=np.all(a,{axis=1});assert(v.dtype=="bool")
same(v:tolist(),{{true,false},{false,true},{false,true}}) end
do local a=np.array({{{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex((0/0),0.0)},{np.complex(2.0,0.0),np.complex(-1.0,0.0),np.complex((0/0),0.0)}}},"complex128"); same(np.all(a),false) end
print('truth differential: 3200 cases passed')
