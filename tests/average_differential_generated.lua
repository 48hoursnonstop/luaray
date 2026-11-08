local np=require("luaray_core")
local function eq(actual,expected,tol)
 if type(expected)=='table' and expected.__complex then
   error('not used')
 end
 if type(actual)=='userdata' and actual.real~=nil then
   assert(type(expected)=='userdata', 'expected complex')
   eq(actual.real,expected.real,tol);eq(actual.imag,expected.imag,tol);return
 end
 if type(expected)=='userdata' and expected.real~=nil then
   assert(type(actual)=='userdata','expected complex result');
   eq(actual.real,expected.real,tol);eq(actual.imag,expected.imag,tol);return
 end
 if type(expected)=='table' then
   assert(type(actual)=='table' and #actual==#expected,'table shape mismatch')
   for i=1,#expected do eq(actual[i],expected[i],tol) end
 elseif type(expected)=='number' then
   assert(type(actual)=='number','number expected')
   if expected~=expected then assert(actual~=actual,'expected NaN')
   elseif expected==math.huge or expected==-math.huge then assert(actual==expected)
   else assert(math.abs(actual-expected)<=tol*math.max(1,math.abs(expected)),tostring(actual)..' != '..tostring(expected)) end
 else assert(actual==expected,tostring(actual)..' != '..tostring(expected)) end
end
do local a=np.array({np.complex(4.0,0.0)},"complex64"); local w=np.array({1.0},"float64");local v,sw=np.average(a,{keepdims=true,returned=true,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{np.complex(4.0,0.0)},2e-06);assert(sw.dtype=="complex128")
eq(sw:tolist(),{np.complex(1.0,0.0)},2e-06) end
do local a=np.zeros({0},"int8"); local w=np.array({-1,-1},"int32");assert(not pcall(function() np.average(a,{axis={},keepdims=true,weights=w}) end)) end
do local a=np.flip(np.zeros({0,3},"complex64"),2); assert(not pcall(function() np.average(a,{axis={},keepdims=true}) end)) end
do local a=np.zeros({2,0},"complex128"); local w=np.array(np.complex(-1.0,0.0),"complex64");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{{},{}},2e-06) end
do local a=np.transpose(np.array({{0.0,-3.0,4.0},{0.0,2.0,0.0}},"float64")); local v=np.average(a,{keepdims=true});assert(v.dtype=="float64")
eq(v:tolist(),{{0.5}},0.006) end
do local a=np.zeros({2,0},"int32"); assert(not pcall(function() np.average(a,{axis={},keepdims=true}) end)) end
do local a=np.array(np.complex(1.0,2.0),"complex128"); local w=np.array(3.0,"float64");local v=np.average(a,{weights=w});eq(v,np.complex(1.0,2.0),2e-06) end
do local a=np.array(true,"bool"); local w=np.array({1.0,1.0},"float16");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({{-3.0,0.0,2.0},{0.0,1.0,0.0}},"float16"),2); local w=np.array({{2.0,3.0,3.0},{2.0,-2.0,-1.0}},"float32");local v=np.average(a,{weights=w});eq(v,-1.0,0.006) end
do local a=np.array({1,1},"uint8"); local v=np.average(a);eq(v,1.0,0.006) end
do local a=np.flip(np.array({{{np.complex(1.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(4.0,0.0)}},{{np.complex(2.0,0.0),np.complex(2.0,0.0),np.complex(2.0,0.0)},{np.complex(2.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}}},"complex64"),3); local w=np.array({{{false,true,false},{true,true,true}},{{false,true,true},{true,true,false}}},"bool");assert(not pcall(function() np.average(a,{axis=1,weights=w}) end)) end
do local a=np.array({{-3.0,-3.0,4.0},{4.0,2.0,0.0}},"float16"); local w=np.array({{-2.0,-1.0,0.0},{-2.0,0.0,2.0}},"float64");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.array(1,"int64"); local v=np.average(a);eq(v,1.0,0.006) end
do local a=np.zeros({2,0},"int8"); local w=np.array(np.complex(-1.0,0.0),"complex64");local v=np.average(a,{axis={},keepdims=true,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{{},{}},2e-06) end
do local a=np.zeros({0,3},"float64"); local w=np.zeros({0,3},"float64");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.array({{0.0,2.0},{-3.0,4.0},{1.0,0.0}},"float16"); local w=np.array({{-2,1},{1,1},{-1,2}},"int64");local v=np.average(a,{axis={1,2},weights=w});eq(v,1.0,0.006) end
do local a=np.flip(np.zeros({0},"float64"),1); local w=np.zeros({0},"int32");assert(not pcall(function() np.average(a,{axis={1},returned=true,weights=w}) end)) end
do local a=np.flip(np.array({{4},{0}},"uint8"),2); local w=np.array(-2,"int32");assert(not pcall(function() np.average(a,{axis=1,weights=w}) end)) end
do local a=np.array({{2.0,4.0},{-3.0,2.0},{-3.0,2.0}},"float32"); local v=np.average(a);eq(v,0.6666666865348816,0.006) end
do local a=np.array({{4.0,0.0},{1.0,-3.0},{-3.0,0.0}},"float64"); local w=np.array({-2,2,3,3},"int32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.transpose(np.zeros({0,3},"float16")); local w=np.zeros({3,0},"int32");assert(not pcall(function() np.average(a,{axis=2,keepdims=true,weights=w}) end)) end
do local a=np.array({{0.0}},"float16"); local w=np.array(1.0,"float16");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.array({{2},{-3}},"int32"); local v=np.average(a,{axis=2,keepdims=true});assert(v.dtype=="float64")
eq(v:tolist(),{{2.0},{-3.0}},0.006) end
do local a=np.array({{-3.0,2.0},{4.0,-3.0},{-3.0,2.0}},"float16"); local w=np.array({{3.0,-2.0},{3.0,0.0},{2.0,2.0}},"float64");assert(not pcall(function() np.average(a,{axis={},keepdims=true,weights=w}) end)) end
do local a=np.flip(np.array({{false},{true}},"bool"),2); local w=np.array({{-2.0},{2.0}},"float16");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({{{np.complex(2.0,2.0),np.complex(2.0,2.0),np.complex(0.0,0.0)},{np.complex(2.0,0.0),np.complex(1.0,0.0),np.complex(-3.0,0.0)}},{{np.complex(0.0,2.0),np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex(0.0,0.0),np.complex(-3.0,2.0),np.complex(4.0,2.0)}}},"complex64"),3); local w=np.array({3,2,-1},"int8");assert(not pcall(function() np.average(a,{axis={1,2,3},weights=w}) end)) end
do local a=np.array(np.complex(1.0,0.0),"complex128"); local w=np.array(np.complex(3.0,0.0),"complex128");local v,sw=np.average(a,{axis={},keepdims=true,returned=true,weights=w});eq(v,np.complex(1.0,0.0),2e-06);eq(sw,np.complex(3.0,0.0),2e-06) end
do local a=np.transpose(np.array({{0,0},{-3,1},{0,0}},"int8")); local w=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(-2.0,0.0)},{np.complex(1.0,0.0),np.complex(3.0,0.0),np.complex(3.0,0.0)}},"complex128");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.zeros({0,3},"int8"); assert(not pcall(function() np.average(a,{axis={}}) end)) end
do local a=np.array(true,"bool"); local w=np.array({-2.0,3.0},"float16");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.array({{2.0,0.0,1.0},{0.0,1.0,4.0}},"float64"); local w=np.array({{3,2,0},{-1,0,3}},"int8");local v=np.average(a,{axis=2,keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{1.2},{6.0}},0.006) end
do local a=np.array({{np.complex(0.0,0.0)}},"complex64"); local w=np.array({-1.0,2.0},"float32");assert(not pcall(function() np.average(a,{axis=2,returned=true,weights=w}) end)) end
do local a=np.zeros({0,3},"complex128"); local w=np.zeros({0,3},"float16");local v=np.average(a,{axis={},keepdims=true,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{},2e-06) end
do local a=np.array(4,"int32"); local v,sw=np.average(a,{returned=true});eq(v,4.0,0.006);eq(sw,1.0,0.006) end
do local a=np.array({2,4},"uint8"); local w=np.array({-2.0,2.0,3.0},"float16");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.array(np.complex(4.0,0.0),"complex64"); local v,sw=np.average(a,{keepdims=true,returned=true});eq(v,np.complex(4.0,0.0),0.006);eq(sw,np.complex(1.0,0.0),0.006) end
do local a=np.flip(np.zeros({2,0},"float64"),2); local w=np.zeros({2,0},"float32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({np.complex(0.0,2.0)},"complex128"),1); local w=np.array({1},"int64");local v=np.average(a,{weights=w});eq(v,np.complex(0.0,2.0),2e-06) end
do local a=np.array({np.complex(4.0,2.0),np.complex(-3.0,0.0),np.complex(4.0,2.0)},"complex64"); local w=np.array({2.0,-1.0,-2.0},"float16");local v,sw=np.average(a,{axis=1,keepdims=true,returned=true,weights=w});assert(v.dtype=="complex64")
eq(v:tolist(),{np.complex(-3.0,-0.0)},0.006);assert(sw.dtype=="complex64")
eq(sw:tolist(),{np.complex(-1.0,0.0)},0.006) end
do local a=np.transpose(np.array({{4.0,2.0,0.0},{1.0,0.0,0.0}},"float16")); local v=np.average(a,{axis={}});assert(v.dtype=="float16")
eq(v:tolist(),{{4.0,1.0},{2.0,0.0},{0.0,0.0}},0.006) end
do local a=np.array({4,0},"int64"); local w=np.array({np.complex(2.0,0.0),np.complex(0.0,0.0)},"complex64");local v=np.average(a,{weights=w});eq(v,np.complex(4.0,0.0),2e-06) end
do local a=np.transpose(np.zeros({0,3},"uint8")); local w=np.array({-1,-1,2,2},"int8");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.transpose(np.array({{{4.0,0.0,-3.0},{4.0,2.0,4.0}},{{4.0,2.0,0.0},{2.0,4.0,-3.0}}},"float32")); local w=np.array({{{np.complex(-1.0,0.0),np.complex(3.0,2.0)},{np.complex(-1.0,0.0),np.complex(2.0,0.0)}},{{np.complex(-1.0,2.0),np.complex(0.0,2.0)},{np.complex(-1.0,2.0),np.complex(-2.0,2.0)}},{{np.complex(-1.0,2.0),np.complex(0.0,0.0)},{np.complex(1.0,2.0),np.complex(3.0,2.0)}}},"complex128");local v=np.average(a,{weights=w});eq(v,np.complex(1.2000000000000002,0.4),2e-06) end
do local a=np.array({{-3,0,0},{1,2,0}},"int8"); local w=np.array({0.0},"float64");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.flip(np.array({{0},{0}},"int8"),2); local w=np.array({{0.0},{1.0}},"float16");local v,sw=np.average(a,{returned=true,weights=w});eq(v,0.0,0.006);eq(sw,1.0,0.006) end
do local a=np.array({{{0,1,4},{2,2,4}},{{1,0,2},{1,2,4}}},"uint8"); local w=np.array(-1.0,"float32");local v=np.average(a,{axis={},keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{{-0.0,1.0,4.0},{2.0,2.0,4.0}},{{1.0,-0.0,2.0},{1.0,2.0,4.0}}},0.006) end
do local a=np.transpose(np.array({{-3.0},{0.0}},"float16")); local w=np.array({{-1,3}},"int32");local v=np.average(a,{keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{1.5}},0.006) end
do local a=np.zeros({0,3},"int64"); local w=np.zeros({0,3},"bool");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array(1,"int64"); local w=np.array({true,true,true},"bool");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.flip(np.array({-3,0},"int32"),1); local w=np.array({np.complex(3.0,0.0),np.complex(-2.0,2.0)},"complex128");local v=np.average(a,{weights=w});eq(v,np.complex(-1.2000000000000002,-3.6),2e-06) end
do local a=np.array(np.complex(0.0,0.0),"complex64"); local w=np.array(0,"int32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({0,-3,2},"int32"),1); local w=np.array({np.complex(-2.0,0.0),np.complex(3.0,0.0),np.complex(0.0,0.0)},"complex64");local v=np.average(a,{axis=1,weights=w});eq(v,np.complex(-13.0,0.0),2e-06) end
do local a=np.array({{{4,1,2},{2,4,0}},{{2,4,2},{0,0,4}}},"uint8"); local w=np.array({{{2.0,3.0,0.0},{0.0,1.0,0.0}},{{3.0,0.0,-2.0},{-1.0,3.0,2.0}}},"float16");local v=np.average(a,{axis={1,2,3},weights=w});eq(v,2.272727272727273,0.006) end
do local a=np.flip(np.array({{{true,false,false},{true,true,false}},{{false,false,false},{true,true,false}}},"bool"),3); local w=np.array({1,1,3},"int32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({-3.0,2.0,-3.0},"float32"),1); local w=np.array({np.complex(-1.0,0.0),np.complex(3.0,0.0)},"complex128");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.transpose(np.array({{2}},"int8")); local v=np.average(a);eq(v,2.0,0.006) end
do local a=np.array({{{0,2,4},{4,2,0}},{{0,0,0},{0,1,4}}},"uint8"); local w=np.array({{{-2,2,-1},{-1,1,1}},{{3,-2,3},{3,-2,3}}},"int32");local v=np.average(a,{axis={1,2,3},weights=w});eq(v,1.0,0.006) end
do local a=np.array(0,"int64"); local w=np.array(np.complex(3.0,0.0),"complex128");local v,sw=np.average(a,{returned=true,weights=w});eq(v,np.complex(0.0,0.0),2e-06);eq(sw,np.complex(3.0,0.0),2e-06) end
do local a=np.flip(np.array({{{-3.0,-3.0,0.0},{-3.0,-3.0,-3.0}},{{1.0,2.0,2.0},{4.0,0.0,-3.0}}},"float16"),3); local v,sw=np.average(a,{returned=true});eq(v,-0.75,0.006);eq(sw,12.0,0.006) end
do local a=np.array({{1.0,-3.0},{2.0,0.0},{1.0,0.0}},"float64"); local v,sw=np.average(a,{keepdims=true,returned=true});assert(v.dtype=="float64")
eq(v:tolist(),{{0.16666666666666666}},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{{6.0}},0.006) end
do local a=np.array({{4.0},{4.0}},"float32"); local w=np.array({np.complex(-2.0,2.0),np.complex(-2.0,2.0),np.complex(-1.0,2.0)},"complex128");assert(not pcall(function() np.average(a,{axis={1,2},returned=true,weights=w}) end)) end
do local a=np.zeros({0},"float32"); local w=np.array(0,"uint8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.transpose(np.zeros({2,0},"int64")); local w=np.array({-1.0},"float64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({-3,0},"int32"); local v,sw=np.average(a,{axis={},returned=true});assert(v.dtype=="float64")
eq(v:tolist(),{-3.0,0.0},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{1.0,1.0},0.006) end
do local a=np.array({np.complex(0.0,2.0),np.complex(-3.0,0.0),np.complex(2.0,0.0)},"complex64"); local w=np.array(false,"bool");assert(not pcall(function() np.average(a,{axis={1},weights=w}) end)) end
do local a=np.array({{4.0,-3.0},{2.0,0.0},{1.0,0.0}},"float64"); local w=np.array(0.0,"float64");assert(not pcall(function() np.average(a,{axis=1,weights=w}) end)) end
do local a=np.zeros({0,3},"uint8"); local w=np.array({-2.0,1.0},"float16");assert(not pcall(function() np.average(a,{axis={},returned=true,weights=w}) end)) end
do local a=np.flip(np.array({{0,2,-3},{4,-3,0}},"int32"),2); local v=np.average(a,{axis={}});assert(v.dtype=="float64")
eq(v:tolist(),{{-3.0,2.0,0.0},{0.0,-3.0,4.0}},0.006) end
do local a=np.array({{{4,0,-3},{0,0,2}},{{1,0,0},{0,0,0}}},"int64"); local v=np.average(a,{keepdims=true});assert(v.dtype=="float64")
eq(v:tolist(),{{{0.3333333333333333}}},0.006) end
do local a=np.array({{-3},{0}},"int32"); local w=np.array({0.0,-2.0,0.0},"float32");assert(not pcall(function() np.average(a,{axis={},returned=true,weights=w}) end)) end
do local a=np.array({true},"bool"); local w=np.array({0.0},"float64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{{1.0,4.0,4.0},{0.0,0.0,1.0}},{{0.0,-3.0,1.0},{0.0,-3.0,2.0}}},"float16"); local w=np.array({3.0,2.0,-2.0},"float64");local v=np.average(a,{axis=3,keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{{1.0},{-0.6666666666666666}},{{-2.6666666666666665},{-3.3333333333333335}}},0.006) end
do local a=np.array(0.0,"float32"); local w=np.array({2,1},"uint8");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.array(1.0,"float32"); local w=np.array({3,2},"uint8");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.flip(np.array({0},"uint8"),1); local w=np.array({false},"bool");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.flip(np.array({{-3},{1}},"int32"),2); local w=np.array(np.complex(3.0,0.0),"complex128");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array(np.complex(-3.0,0.0),"complex64"); local w=np.array(3.0,"float32");local v=np.average(a,{weights=w});eq(v,np.complex(-3.0,0.0),0.006) end
do local a=np.array({{false},{true}},"bool"); local w=np.array(3.0,"float16");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({2.0},"float32"); local w=np.array({1.0,0.0,3.0},"float32");assert(not pcall(function() np.average(a,{axis={1},returned=true,weights=w}) end)) end
do local a=np.transpose(np.zeros({2,0},"float32")); local v=np.average(a,{keepdims=true});assert(v.dtype=="float32")
eq(v:tolist(),{{(0/0)}},0.006) end
do local a=np.transpose(np.array({{{0,-3,0},{2,0,1}},{{2,-3,2},{-3,0,-3}}},"int64")); local w=np.array({-1,3,2,2},"int32");assert(not pcall(function() np.average(a,{axis=1,weights=w}) end)) end
do local a=np.array({{-3}},"int32"); local w=np.array({1},"int8");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.zeros({0},"bool"); local w=np.array(-2,"int32");assert(not pcall(function() np.average(a,{axis=1,returned=true,weights=w}) end)) end
do local a=np.array({{2.0,2.0,0.0}},"float64"); local w=np.array({{0,3,0}},"int64");local v=np.average(a,{axis={1,2},weights=w});eq(v,2.0,0.006) end
do local a=np.array({{true,true,false},{false,false,false}},"bool"); local w=np.array({{np.complex(1.0,0.0),np.complex(-2.0,0.0),np.complex(3.0,0.0)},{np.complex(3.0,2.0),np.complex(2.0,2.0),np.complex(2.0,2.0)}},"complex128");local v=np.average(a,{weights=w});eq(v,np.complex(-0.07692307692307693,0.05128205128205128),2e-06) end
do local a=np.array({0.0,1.0},"float32"); local w=np.array({2,1,1},"uint8");assert(not pcall(function() np.average(a,{axis={},keepdims=true,weights=w}) end)) end
do local a=np.array({{2,4,0},{2,2,2}},"uint8"); local v,sw=np.average(a,{axis={},keepdims=true,returned=true});assert(v.dtype=="float64")
eq(v:tolist(),{{2.0,4.0,0.0},{2.0,2.0,2.0}},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{{1.0,1.0,1.0},{1.0,1.0,1.0}},0.006) end
do local a=np.zeros({0,3},"int32"); local w=np.zeros({0,3},"float32");assert(not pcall(function() np.average(a,{axis=1,returned=true,weights=w}) end)) end
do local a=np.array({{{0,4,4},{2,0,0}},{{4,1,-3},{2,-3,-3}}},"int64"); local w=np.array({np.complex(-1.0,0.0),np.complex(0.0,2.0)},"complex64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({{np.complex(0.0,2.0)}},"complex128"),2); local v=np.average(a,{axis=1});assert(v.dtype=="complex128")
eq(v:tolist(),{np.complex(0.0,2.0)},2e-06) end
do local a=np.transpose(np.zeros({0,3},"complex64")); local v=np.average(a);eq(v,np.complex((0/0),(0/0)),0.006) end
do local a=np.array({{2,1,1}},"int64"); local w=np.array({{0,-2,-1}},"int64");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.zeros({0},"int8"); local w=np.array(np.complex(0.0,0.0),"complex64");assert(not pcall(function() np.average(a,{keepdims=true,returned=true,weights=w}) end)) end
do local a=np.flip(np.array({{2.0},{0.0}},"float16"),2); local w=np.array({{-2},{0}},"int32");assert(not pcall(function() np.average(a,{axis={},returned=true,weights=w}) end)) end
do local a=np.array({{-3.0,0.0,1.0},{0.0,0.0,1.0}},"float64"); local w=np.array({3.0,-2.0,-2.0},"float64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{1}},"uint8"); local w=np.array({{0}},"int8");assert(not pcall(function() np.average(a,{axis=2,keepdims=true,weights=w}) end)) end
do local a=np.array({-3.0},"float64"); local w=np.array({1},"uint8");local v=np.average(a,{keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{-3.0},0.006) end
do local a=np.zeros({0,3},"complex128"); local w=np.array(true,"bool");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.zeros({0,3},"complex64"); local w=np.array(1,"uint8");assert(not pcall(function() np.average(a,{axis=1,keepdims=true,weights=w}) end)) end
do local a=np.array({0},"int32"); local w=np.array({np.complex(3.0,0.0)},"complex128");local v=np.average(a,{weights=w});eq(v,np.complex(0.0,0.0),2e-06) end
do local a=np.transpose(np.array({{4.0,1.0},{2.0,4.0},{1.0,2.0}},"float16")); local v=np.average(a,{axis={}});assert(v.dtype=="float16")
eq(v:tolist(),{{4.0,2.0,1.0},{1.0,4.0,2.0}},0.006) end
do local a=np.array({{-3.0,4.0,1.0},{4.0,0.0,2.0}},"float64"); local v=np.average(a,{keepdims=true});assert(v.dtype=="float64")
eq(v:tolist(),{{1.3333333333333333}},0.006) end
do local a=np.array(1,"int32"); local v=np.average(a);eq(v,1.0,0.006) end
do local a=np.flip(np.array({{0.0}},"float64"),2); local w=np.array({{1}},"uint8");local v=np.average(a,{axis={},keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{0.0}},0.006) end
do local a=np.array({false,false},"bool"); local w=np.array({0,2,0},"int32");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.array({np.complex(-3.0,0.0)},"complex128"); local w=np.array({-2.0},"float16");local v=np.average(a,{axis=1,weights=w});eq(v,np.complex(-3.0,-0.0),2e-06) end
do local a=np.zeros({0},"float16"); local w=np.zeros({0},"bool");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="float16")
eq(v:tolist(),{},0.006) end
do local a=np.transpose(np.zeros({2,0},"int8")); local v=np.average(a);eq(v,(0/0),0.006) end
do local a=np.zeros({0},"complex64"); local w=np.array({-2.0,1.0,-2.0},"float16");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.array({0.0,-3.0},"float32"); local w=np.array({1,1},"uint8");local v=np.average(a,{axis={1},weights=w});eq(v,-1.5,0.006) end
do local a=np.zeros({0},"int64"); local w=np.zeros({0},"int8");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.array({{np.complex(0.0,0.0),np.complex(4.0,0.0),np.complex(0.0,0.0)}},"complex128"); local w=np.array({3,1},"int32");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.flip(np.array({{-3,-3},{4,-3},{2,-3}},"int64"),2); local w=np.array({{2,0},{0,-1},{0,2}},"int8");local v=np.average(a,{axis={1,2},weights=w});eq(v,-2.0,0.006) end
do local a=np.transpose(np.array({{2,2,0},{0,2,0}},"uint8")); local w=np.array({{1,2},{-1,3},{-1,-2}},"int8");local v=np.average(a,{axis=2,keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{0.6666666666666666},{2.0},{-0.0}},0.006) end
do local a=np.flip(np.array({2,0},"int32"),1); local v=np.average(a);eq(v,1.0,0.006) end
do local a=np.flip(np.zeros({2,0},"float32"),2); local w=np.zeros({2,0},"int32");local v=np.average(a,{axis=1,keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{}},0.006) end
do local a=np.array({{1},{0}},"int32"); local w=np.array({np.complex(3.0,2.0),np.complex(-1.0,2.0),np.complex(-2.0,0.0)},"complex128");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({0,2,2},"int32"); local w=np.array({1,0,2,3},"int32");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.flip(np.array({{false,false,true}},"bool"),2); local w=np.array({false,false},"bool");assert(not pcall(function() np.average(a,{axis={1,2},returned=true,weights=w}) end)) end
do local a=np.array({{{false,true,false},{false,true,true}},{{false,true,true},{false,true,false}}},"bool"); local w=np.array({{{0,-1,0},{-1,1,3}},{{-2,-2,-2},{2,-2,3}}},"int64");local v=np.average(a,{weights=w});eq(v,3.0,0.006) end
do local a=np.array({0},"int8"); local w=np.array({2.0},"float16");local v=np.average(a,{axis={},keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{0.0},0.006) end
do local a=np.array({{-3,4},{-3,-3},{2,-3}},"int32"); local v=np.average(a,{axis={1,2},keepdims=true});assert(v.dtype=="float64")
eq(v:tolist(),{{-1.0}},0.006) end
do local a=np.transpose(np.array({{0},{0}},"int8")); local w=np.array({1.0,2.0,-2.0},"float64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({{1},{0}},"uint8"),2); local w=np.array({{np.complex(2.0,2.0)},{np.complex(3.0,2.0)}},"complex64");local v,sw=np.average(a,{axis=1,returned=true,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{np.complex(0.4390243902439025,0.048780487804878044)},2e-06);assert(sw.dtype=="complex128")
eq(sw:tolist(),{np.complex(5.0,4.0)},2e-06) end
do local a=np.flip(np.array({{2},{4}},"int32"),2); local w=np.array({{np.complex(-2.0,2.0)},{np.complex(1.0,2.0)}},"complex64");local v=np.average(a,{axis={1,2},weights=w});eq(v,np.complex(2.8235294117647056,-0.7058823529411764),2e-06) end
do local a=np.array({0.0,2.0,1.0},"float64"); local w=np.array({-2.0,0.0,-2.0,1.0},"float64");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.array({0,0},"int64"); local w=np.array({np.complex(2.0,0.0)},"complex64");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.array({{4,0},{0,4},{4,2}},"uint8"); local v,sw=np.average(a,{axis=1,keepdims=true,returned=true});assert(v.dtype=="float64")
eq(v:tolist(),{{2.6666666666666665,2.0}},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{{3.0,3.0}},0.006) end
do local a=np.flip(np.array({1,2},"int32"),1); local w=np.array(np.complex(-1.0,2.0),"complex64");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.transpose(np.array({{-3.0,-3.0,1.0},{-3.0,-3.0,2.0}},"float16")); local w=np.array({1,0,-2,-1},"int8");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.array(np.complex(0.0,2.0),"complex128"); local w=np.array(0.0,"float32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.zeros({0},"float32"); local w=np.zeros({0},"float32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({{false},{true}},"bool"),2); local w=np.array(3.0,"float64");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{0.0},{1.0}},0.006) end
do local a=np.flip(np.array({{np.complex(-3.0,0.0)},{np.complex(0.0,2.0)}},"complex64"),2); local w=np.array({{np.complex(-2.0,0.0)},{np.complex(-1.0,2.0)}},"complex64");local v=np.average(a,{weights=w});eq(v,np.complex(-0.7692307829856873,0.1538461297750473),0.006) end
do local a=np.zeros({2,0},"bool"); assert(not pcall(function() np.average(a,{axis={},keepdims=true}) end)) end
do local a=np.array({{np.complex(4.0,2.0)}},"complex64"); local w=np.array({np.complex(-1.0,2.0),np.complex(-1.0,0.0)},"complex64");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.array({{{0.0,0.0,1.0},{0.0,4.0,-3.0}},{{4.0,0.0,0.0},{2.0,4.0,2.0}}},"float32"); local w=np.array(true,"bool");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({1,0,1},"int32"); local w=np.array({np.complex(0.0,2.0),np.complex(-1.0,2.0),np.complex(3.0,0.0),np.complex(2.0,0.0)},"complex64");assert(not pcall(function() np.average(a,{keepdims=true,returned=true,weights=w}) end)) end
do local a=np.array({4,1,-3},"int64"); local v=np.average(a);eq(v,0.6666666666666666,0.006) end
do local a=np.transpose(np.array({{2.0,0.0},{0.0,0.0},{2.0,4.0}},"float64")); local w=np.array({{2.0,2.0,-2.0},{-2.0,0.0,2.0}},"float64");assert(not pcall(function() np.average(a,{axis={},keepdims=true,weights=w}) end)) end
do local a=np.array(1,"int8"); local w=np.array({3,-2},"int8");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.flip(np.array({{{-3,2,1},{0,0,4}},{{0,0,0},{2,4,0}}},"int8"),3); local w=np.array({{{0,3,-2},{1,3,2}},{{-2,0,1},{-1,0,-2}}},"int32");assert(not pcall(function() np.average(a,{axis=2,weights=w}) end)) end
do local a=np.array({false,false,true},"bool"); local w=np.array({np.complex(1.0,2.0),np.complex(-1.0,0.0),np.complex(-2.0,0.0),np.complex(2.0,0.0)},"complex128");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.array({{{-3.0,1.0,2.0},{0.0,2.0,0.0}},{{0.0,0.0,4.0},{0.0,2.0,0.0}}},"float32"); local w=np.array({1.0,0.0,3.0},"float64");assert(not pcall(function() np.average(a,{axis={1,2,3},weights=w}) end)) end
do local a=np.array({np.complex(0.0,2.0)},"complex128"); local w=np.array(true,"bool");local v,sw=np.average(a,{axis={},returned=true,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{np.complex(0.0,2.0)},2e-06);assert(sw.dtype=="complex128")
eq(sw:tolist(),{np.complex(1.0,0.0)},2e-06) end
do local a=np.zeros({2,0},"int64"); local w=np.zeros({2,0},"float32");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.array({{np.complex(1.0,0.0)},{np.complex(-3.0,0.0)}},"complex128"); local w=np.array({0,2,1},"int8");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.array({{{4,0,2},{0,0,2}},{{2,0,-3},{0,2,0}}},"int8"); local w=np.array({{{np.complex(3.0,2.0),np.complex(3.0,0.0),np.complex(2.0,0.0)},{np.complex(-2.0,2.0),np.complex(-1.0,0.0),np.complex(3.0,0.0)}},{{np.complex(1.0,2.0),np.complex(2.0,0.0),np.complex(0.0,0.0)},{np.complex(3.0,0.0),np.complex(0.0,0.0),np.complex(1.0,2.0)}}},"complex64");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.zeros({0},"float32"); local w=np.array({-1.0},"float64");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.array(0.0,"float64"); local w=np.array({np.complex(-2.0,2.0),np.complex(2.0,2.0)},"complex64");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.array({0},"int64"); local w=np.array({2},"uint8");local v=np.average(a,{weights=w});eq(v,0.0,0.006) end
do local a=np.zeros({0},"int8"); local w=np.zeros({0},"complex128");assert(not pcall(function() np.average(a,{axis=1,weights=w}) end)) end
do local a=np.array({0,-3,0},"int8"); local v,sw=np.average(a,{axis={1},returned=true});eq(v,-1.0,0.006);eq(sw,3.0,0.006) end
do local a=np.array(1.0,"float32"); local w=np.array(-2,"int64");local v,sw=np.average(a,{axis={},returned=true,weights=w});eq(v,1.0,0.006);eq(sw,-2.0,0.006) end
do local a=np.array({np.complex(0.0,2.0),np.complex(2.0,0.0)},"complex64"); local w=np.array({-2,1},"int8");local v=np.average(a,{axis={1},weights=w});eq(v,np.complex(-2.0,4.0),0.006) end
do local a=np.array({{np.complex(2.0,0.0)},{np.complex(-3.0,0.0)}},"complex128"); local w=np.array({true,true,true},"bool");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.array(np.complex(0.0,0.0),"complex64"); local w=np.array({-1},"int32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.transpose(np.zeros({0,3},"uint8")); local w=np.array(-1.0,"float64");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.array({{np.complex(4.0,2.0),np.complex(-3.0,2.0),np.complex(0.0,0.0)}},"complex64"); local w=np.array(-2.0,"float32");assert(not pcall(function() np.average(a,{axis={1,2},keepdims=true,returned=true,weights=w}) end)) end
do local a=np.array({{1,2,4},{0,4,0}},"int8"); local w=np.array({{-1.0,3.0,0.0},{3.0,1.0,-2.0}},"float32");local v,sw=np.average(a,{axis={1,2},returned=true,weights=w});eq(v,2.25,0.006);eq(sw,4.0,0.006) end
do local a=np.array(0,"int8"); local w=np.array({-2,1},"int32");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.array({np.complex(4.0,0.0),np.complex(-3.0,0.0)},"complex128"); local w=np.array({np.complex(2.0,2.0),np.complex(-1.0,0.0),np.complex(3.0,0.0)},"complex64");assert(not pcall(function() np.average(a,{axis={},returned=true,weights=w}) end)) end
do local a=np.flip(np.array({{{-3,2,0},{2,2,2}},{{-3,0,0},{0,4,2}}},"int64"),3); local w=np.array(3.0,"float64");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.zeros({0},"uint8"); local v=np.average(a,{keepdims=true});assert(v.dtype=="float64")
eq(v:tolist(),{(0/0)},0.006) end
do local a=np.array({0.0,4.0,2.0},"float16"); local w=np.array({np.complex(-2.0,0.0),np.complex(0.0,2.0),np.complex(-1.0,2.0)},"complex128");local v=np.average(a,{axis=1,weights=w});eq(v,np.complex(2.16,-1.12),2e-06) end
do local a=np.transpose(np.array({{0.0}},"float64")); local w=np.array({3.0},"float32");local v,sw=np.average(a,{axis=2,returned=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{0.0},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{3.0},0.006) end
do local a=np.flip(np.zeros({2,0},"bool"),2); local w=np.array({true,true,false},"bool");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.flip(np.array({1},"int8"),1); local w=np.array({3,-1},"int8");assert(not pcall(function() np.average(a,{axis={1},weights=w}) end)) end
do local a=np.array({np.complex(0.0,2.0),np.complex(2.0,2.0),np.complex(2.0,0.0)},"complex128"); local w=np.array({3,-1,-2},"int32");assert(not pcall(function() np.average(a,{axis={1},returned=true,weights=w}) end)) end
do local a=np.array({0},"int32"); local w=np.array({1.0},"float16");local v=np.average(a,{axis={1},keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{0.0},0.006) end
do local a=np.array({1},"int32"); local w=np.array({-2.0,1.0},"float32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({{2.0,-3.0,0.0}},"float64"),2); local w=np.array(2.0,"float64");assert(not pcall(function() np.average(a,{axis=1,weights=w}) end)) end
do local a=np.array(4.0,"float32"); local w=np.array(2.0,"float16");local v=np.average(a,{keepdims=true,weights=w});eq(v,4.0,0.006) end
do local a=np.zeros({0},"int32"); local w=np.array({2},"uint8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({4,2,2},"int8"),1); local v=np.average(a);eq(v,2.6666666666666665,0.006) end
do local a=np.array({{0.0,-3.0},{1.0,0.0},{0.0,4.0}},"float32"); local w=np.array({-2,2,3,2},"int64");assert(not pcall(function() np.average(a,{axis=2,keepdims=true,weights=w}) end)) end
do local a=np.transpose(np.array({{-3},{2}},"int32")); local v=np.average(a,{axis=2});assert(v.dtype=="float64")
eq(v:tolist(),{-0.5},0.006) end
do local a=np.array({-3.0,1.0,4.0},"float32"); local w=np.array({2,0,3},"int8");local v=np.average(a,{axis={1},keepdims=true,weights=w});assert(v.dtype=="float32")
eq(v:tolist(),{1.2000000476837158},0.006) end
do local a=np.array({{np.complex(0.0,2.0)}},"complex64"); local w=np.array(np.complex(0.0,2.0),"complex64");assert(not pcall(function() np.average(a,{axis={1,2},keepdims=true,weights=w}) end)) end
do local a=np.flip(np.array({{4},{-3}},"int8"),2); local w=np.array({{np.complex(0.0,0.0)},{np.complex(-2.0,0.0)}},"complex128");local v=np.average(a,{weights=w});eq(v,np.complex(-3.0,-0.0),2e-06) end
do local a=np.array({{0.0,0.0,4.0},{4.0,4.0,-3.0}},"float64"); local w=np.array({3,3,0},"int64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({2,4},"int8"); local w=np.array({1,3,2},"int8");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.zeros({0},"int64"); local w=np.array(-2,"int64");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.zeros({2,0},"float32"); local w=np.array({-1.0},"float64");assert(not pcall(function() np.average(a,{axis={1,2},keepdims=true,weights=w}) end)) end
do local a=np.flip(np.array({2,2,1},"uint8"),1); local v=np.average(a,{axis=1,keepdims=true});assert(v.dtype=="float64")
eq(v:tolist(),{1.6666666666666667},0.006) end
do local a=np.transpose(np.array({{np.complex(0.0,0.0),np.complex(1.0,2.0)},{np.complex(2.0,0.0),np.complex(1.0,2.0)},{np.complex(2.0,0.0),np.complex(-3.0,0.0)}},"complex128")); local w=np.array({{1,3,-2},{1,1,0}},"int32");local v=np.average(a,{axis=1,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{np.complex(0.5,1.0),np.complex(1.75,0.5),np.complex(2.0,-0.0)},2e-06) end
do local a=np.array({{{1,0,2},{4,1,4}},{{1,0,0},{0,1,0}}},"uint8"); local w=np.array(3.0,"float64");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.array({{2,2},{-3,4},{1,4}},"int64"); local w=np.array({{0,0},{0,2},{2,2}},"int64");assert(not pcall(function() np.average(a,{axis=2,keepdims=true,weights=w}) end)) end
do local a=np.transpose(np.array({{2},{0}},"int64")); local w=np.array({{0.0,2.0}},"float32");local v=np.average(a,{weights=w});eq(v,0.0,0.006) end
do local a=np.flip(np.array({-3},"int64"),1); local w=np.array(2.0,"float16");assert(not pcall(function() np.average(a,{keepdims=true,returned=true,weights=w}) end)) end
do local a=np.array({{2.0,-3.0},{4.0,1.0},{1.0,2.0}},"float64"); local w=np.array({{2.0,-1.0},{-1.0,1.0},{-1.0,1.0}},"float64");local v,sw=np.average(a,{returned=true,weights=w});eq(v,5.0,0.006);eq(sw,1.0,0.006) end
do local a=np.array(np.complex(1.0,2.0),"complex128"); local w=np.array(0.0,"float64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({1,1,0},"uint8"),1); local w=np.array({np.complex(3.0,0.0),np.complex(1.0,0.0),np.complex(1.0,0.0)},"complex128");local v=np.average(a,{keepdims=true,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{np.complex(0.4,0.0)},2e-06) end
do local a=np.flip(np.zeros({0},"float16"),1); local w=np.array(1,"int64");assert(not pcall(function() np.average(a,{axis={1},weights=w}) end)) end
do local a=np.array({0,-3},"int8"); local w=np.array({-2.0},"float64");assert(not pcall(function() np.average(a,{axis={1},weights=w}) end)) end
do local a=np.transpose(np.array({{{2,0,1},{-3,1,0}},{{4,0,4},{-3,-3,0}}},"int64")); local w=np.array({0.0,0.0,1.0,3.0},"float32");assert(not pcall(function() np.average(a,{axis=3,weights=w}) end)) end
do local a=np.transpose(np.zeros({0,3},"float64")); local w=np.zeros({3,0},"float16");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({0.0},"float32"); local w=np.array({-2.0},"float16");local v,sw=np.average(a,{keepdims=true,returned=true,weights=w});assert(v.dtype=="float32")
eq(v:tolist(),{-0.0},0.006);assert(sw.dtype=="float32")
eq(sw:tolist(),{-2.0},0.006) end
do local a=np.array({4.0,2.0},"float32"); local w=np.array({np.complex(0.0,0.0),np.complex(2.0,0.0),np.complex(2.0,0.0)},"complex64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{true,false,false},{true,true,true}},"bool"); local w=np.array({{3.0,-1.0,2.0},{-1.0,-1.0,0.0}},"float16");local v,sw=np.average(a,{returned=true,weights=w});eq(v,0.5,0.006);eq(sw,2.0,0.006) end
do local a=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(0.0,2.0)}},"complex128"); local w=np.array({0.0,3.0},"float16");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.array({{2.0},{0.0}},"float32"); local w=np.array({-2.0},"float32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.zeros({0},"complex128"); local v,sw=np.average(a,{axis={1},returned=true});eq(v,np.complex((0/0),(0/0)),2e-06);eq(sw,np.complex(0.0,0.0),2e-06) end
do local a=np.flip(np.array({{2}},"uint8"),2); local w=np.array({{np.complex(3.0,0.0)}},"complex128");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{{np.complex(2.0,0.0)}},2e-06) end
do local a=np.transpose(np.array({{4.0,1.0},{0.0,-3.0},{0.0,-3.0}},"float64")); local w=np.array(0.0,"float32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({4},"int64"); local w=np.array({3,1},"int32");assert(not pcall(function() np.average(a,{axis={1},weights=w}) end)) end
do local a=np.array(-3,"int8"); local w=np.array(0,"int64");assert(not pcall(function() np.average(a,{axis={},keepdims=true,weights=w}) end)) end
do local a=np.zeros({2,0},"float64"); local w=np.zeros({2,0},"int64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({{4.0},{1.0}},"float64"),2); local w=np.array({{np.complex(-1.0,0.0)},{np.complex(1.0,0.0)}},"complex64");local v=np.average(a,{axis={},keepdims=true,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{{np.complex(4.0,-0.0)},{np.complex(1.0,0.0)}},2e-06) end
do local a=np.zeros({2,0},"float16"); local w=np.zeros({2,0},"int8");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.zeros({0},"float32"); local w=np.zeros({0},"float32");assert(not pcall(function() np.average(a,{axis=1,returned=true,weights=w}) end)) end
do local a=np.array({np.complex(1.0,2.0),np.complex(4.0,0.0)},"complex64"); local w=np.array({3,-2,0},"int32");assert(not pcall(function() np.average(a,{axis={1},keepdims=true,returned=true,weights=w}) end)) end
do local a=np.zeros({0},"float16"); local w=np.zeros({0},"int8");assert(not pcall(function() np.average(a,{axis={1},weights=w}) end)) end
do local a=np.array(true,"bool"); local w=np.array(0.0,"float64");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.transpose(np.zeros({2,0},"int8")); local w=np.array(1,"int64");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.zeros({0},"float32"); local w=np.array({2,1,3},"int8");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.zeros({0,3},"float64"); local w=np.array(1,"int8");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{},0.006) end
do local a=np.zeros({0,3},"int32"); local v,sw=np.average(a,{axis={1,2},returned=true});eq(v,(0/0),0.006);eq(sw,0.0,0.006) end
do local a=np.array({np.complex(1.0,2.0),np.complex(0.0,0.0),np.complex(1.0,0.0)},"complex64"); local w=np.array({np.complex(-2.0,0.0),np.complex(-1.0,0.0),np.complex(-2.0,0.0),np.complex(-1.0,0.0)},"complex128");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({4},"uint8"),1); local w=np.array({false,true},"bool");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.transpose(np.array({{true},{false}},"bool")); local w=np.array({{0.0,1.0}},"float16");local v,sw=np.average(a,{axis={1,2},returned=true,weights=w});eq(v,0.0,0.006);eq(sw,1.0,0.006) end
do local a=np.flip(np.array({2.0,1.0},"float16"),1); local w=np.array({1,3},"uint8");local v,sw=np.average(a,{axis={},returned=true,weights=w});assert(v.dtype=="float16")
eq(v:tolist(),{1.0,2.0},0.006);assert(sw.dtype=="float16")
eq(sw:tolist(),{1.0,3.0},0.006) end
do local a=np.array({np.complex(4.0,0.0)},"complex64"); local w=np.array(-2.0,"float16");assert(not pcall(function() np.average(a,{axis=1,keepdims=true,weights=w}) end)) end
do local a=np.array({{2,4,1}},"int8"); local v=np.average(a);eq(v,2.3333333333333335,0.006) end
do local a=np.array({{np.complex(4.0,0.0),np.complex(4.0,2.0)},{np.complex(-3.0,0.0),np.complex(4.0,2.0)},{np.complex(2.0,0.0),np.complex(1.0,0.0)}},"complex64"); local v,sw=np.average(a,{axis={1,2},returned=true});eq(v,np.complex(2.0,0.6666666865348816),0.006);eq(sw,np.complex(6.0,0.0),0.006) end
do local a=np.array(4.0,"float64"); local v,sw=np.average(a,{axis={},returned=true});eq(v,4.0,0.006);eq(sw,1.0,0.006) end
do local a=np.zeros({0,3},"uint8"); local w=np.array(3.0,"float32");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.transpose(np.array({{4.0},{2.0}},"float16")); local w=np.array({3},"int32");local v=np.average(a,{axis=1,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{4.0,2.0},0.006) end
do local a=np.transpose(np.zeros({2,0},"complex64")); local w=np.zeros({0,2},"int64");assert(not pcall(function() np.average(a,{axis=1,weights=w}) end)) end
do local a=np.array({0.0},"float16"); local w=np.array({-2.0,3.0},"float32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({1.0},"float32"); local w=np.array({2,2},"uint8");assert(not pcall(function() np.average(a,{axis=1,weights=w}) end)) end
do local a=np.flip(np.zeros({0},"complex64"),1); local w=np.array(-1.0,"float16");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.transpose(np.array({{0}},"int8")); local w=np.array({3,-1},"int64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.zeros({0},"int32"); local w=np.array({3},"uint8");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.array({{{4,1,4},{1,1,0}},{{1,4,1},{1,0,4}}},"uint8"); local w=np.array({{{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(0.0,0.0)},{np.complex(0.0,0.0),np.complex(0.0,2.0),np.complex(0.0,0.0)}},{{np.complex(3.0,2.0),np.complex(0.0,0.0),np.complex(3.0,2.0)},{np.complex(-1.0,0.0),np.complex(-1.0,2.0),np.complex(0.0,2.0)}}},"complex128");assert(not pcall(function() np.average(a,{axis=2,returned=true,weights=w}) end)) end
do local a=np.array({{-3.0,-3.0},{4.0,0.0},{0.0,-3.0}},"float32"); local w=np.array({{0.0,2.0},{0.0,-2.0},{0.0,2.0}},"float64");local v=np.average(a,{axis=2,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{-3.0,-0.0,-3.0},0.006) end
do local a=np.flip(np.array({{0,1,2}},"int64"),2); local w=np.array({{1,1,1}},"int32");local v,sw=np.average(a,{axis=2,keepdims=true,returned=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{1.0}},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{{3.0}},0.006) end
do local a=np.transpose(np.array({{-3,0,0},{-3,1,1}},"int8")); local v=np.average(a,{axis={1,2}});eq(v,-0.6666666666666666,0.006) end
do local a=np.array({4,1,0},"int8"); local w=np.array({0,3},"uint8");assert(not pcall(function() np.average(a,{axis={1},weights=w}) end)) end
do local a=np.array({0.0},"float32"); local w=np.array({3.0,2.0},"float32");assert(not pcall(function() np.average(a,{axis=1,weights=w}) end)) end
do local a=np.flip(np.array({0.0},"float64"),1); local w=np.array({-2.0},"float32");local v=np.average(a,{axis=1,weights=w});eq(v,-0.0,0.006) end
do local a=np.array({-3.0,4.0,4.0},"float32"); local w=np.array({false,true,true},"bool");local v,sw=np.average(a,{axis={1},keepdims=true,returned=true,weights=w});assert(v.dtype=="float32")
eq(v:tolist(),{4.0},0.006);assert(sw.dtype=="float32")
eq(sw:tolist(),{2.0},0.006) end
do local a=np.array({{{np.complex(0.0,2.0),np.complex(-3.0,2.0),np.complex(-3.0,0.0)},{np.complex(-3.0,0.0),np.complex(-3.0,0.0),np.complex(-3.0,2.0)}},{{np.complex(1.0,0.0),np.complex(1.0,0.0),np.complex(-3.0,0.0)},{np.complex(-3.0,0.0),np.complex(1.0,2.0),np.complex(2.0,0.0)}}},"complex64"); local v=np.average(a,{axis={},keepdims=true});assert(v.dtype=="complex64")
eq(v:tolist(),{{{np.complex(0.0,2.0),np.complex(-3.0,2.0),np.complex(-3.0,0.0)},{np.complex(-3.0,0.0),np.complex(-3.0,0.0),np.complex(-3.0,2.0)}},{{np.complex(1.0,0.0),np.complex(1.0,0.0),np.complex(-3.0,0.0)},{np.complex(-3.0,0.0),np.complex(1.0,2.0),np.complex(2.0,0.0)}}},0.006) end
do local a=np.zeros({0},"int8"); local w=np.array({true},"bool");assert(not pcall(function() np.average(a,{axis={1},returned=true,weights=w}) end)) end
do local a=np.array(0,"int64"); local w=np.array(0.0,"float32");assert(not pcall(function() np.average(a,{keepdims=true,returned=true,weights=w}) end)) end
do local a=np.array({0.0},"float16"); local w=np.array({3},"uint8");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="float16")
eq(v:tolist(),{0.0},0.006) end
do local a=np.flip(np.array({np.complex(2.0,0.0),np.complex(4.0,0.0)},"complex128"),1); local w=np.array({-1.0,-1.0,2.0},"float32");assert(not pcall(function() np.average(a,{axis={},keepdims=true,weights=w}) end)) end
do local a=np.array({1.0,0.0,-3.0},"float64"); local w=np.array({1,2,3},"uint8");local v,sw=np.average(a,{axis={},returned=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{1.0,0.0,-3.0},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{1.0,2.0,3.0},0.006) end
do local a=np.transpose(np.zeros({0,3},"complex64")); local v=np.average(a);eq(v,np.complex((0/0),(0/0)),0.006) end
do local a=np.flip(np.array({np.complex(-3.0,0.0),np.complex(2.0,0.0)},"complex64"),1); local v=np.average(a,{axis=1});eq(v,np.complex(-0.5,0.0),0.006) end
do local a=np.flip(np.zeros({2,0},"complex128"),2); local v=np.average(a,{axis=2});assert(v.dtype=="complex128")
eq(v:tolist(),{np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},2e-06) end
do local a=np.transpose(np.zeros({0,3},"float64")); local w=np.zeros({3,0},"int64");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{},{},{}},0.006) end
do local a=np.array(np.complex(4.0,0.0),"complex128"); local w=np.array(-2,"int32");local v=np.average(a,{axis={},weights=w});eq(v,np.complex(4.0,-0.0),2e-06) end
do local a=np.transpose(np.array({{{0.0,2.0,1.0},{1.0,1.0,-3.0}},{{1.0,0.0,2.0},{1.0,0.0,0.0}}},"float64")); local w=np.array({{{2.0,-1.0},{0.0,-1.0}},{{0.0,3.0},{0.0,1.0}},{{3.0,3.0},{0.0,0.0}}},"float16");local v,sw=np.average(a,{axis={1,2,3},returned=true,weights=w});eq(v,0.7,0.006);eq(sw,10.0,0.006) end
do local a=np.array({np.complex(0.0,0.0)},"complex128"); local w=np.array({3.0,0.0},"float64");assert(not pcall(function() np.average(a,{axis=1,weights=w}) end)) end
do local a=np.array(np.complex(4.0,2.0),"complex128"); local w=np.array({np.complex(2.0,2.0),np.complex(2.0,2.0)},"complex128");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({np.complex(4.0,2.0),np.complex(0.0,0.0)},"complex128"),1); local w=np.array(1,"uint8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({{{0.0,-3.0,0.0},{1.0,4.0,1.0}},{{2.0,2.0,2.0},{2.0,1.0,0.0}}},"float16"),3); local w=np.array({true,false,true},"bool");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({{2,0},{0,0},{1,4}},"uint8"),2); local w=np.array(true,"bool");assert(not pcall(function() np.average(a,{keepdims=true,returned=true,weights=w}) end)) end
do local a=np.flip(np.array({{np.complex(4.0,0.0),np.complex(1.0,0.0),np.complex(4.0,0.0)}},"complex64"),2); local v,sw=np.average(a,{axis=2,returned=true});assert(v.dtype=="complex64")
eq(v:tolist(),{np.complex(3.0,0.0)},0.006);assert(sw.dtype=="complex64")
eq(sw:tolist(),{np.complex(3.0,0.0)},0.006) end
do local a=np.array({0},"int8"); local w=np.array({np.complex(-2.0,0.0),np.complex(3.0,0.0),np.complex(-1.0,0.0)},"complex64");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.array({{1}},"int32"); local w=np.array(0,"int32");assert(not pcall(function() np.average(a,{axis={1,2},keepdims=true,returned=true,weights=w}) end)) end
do local a=np.array({{{-3,4,1},{1,4,0}},{{-3,2,2},{0,0,1}}},"int32"); local w=np.array({{{1.0,-2.0,0.0},{-1.0,0.0,2.0}},{{-1.0,-1.0,1.0},{1.0,2.0,2.0}}},"float32");local v=np.average(a,{weights=w});eq(v,-1.75,0.006) end
do local a=np.array({{np.complex(0.0,0.0),np.complex(0.0,2.0)},{np.complex(1.0,0.0),np.complex(0.0,0.0)},{np.complex(-3.0,0.0),np.complex(0.0,2.0)}},"complex128"); local w=np.array({-2,1},"int8");local v,sw=np.average(a,{axis=2,returned=true,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{np.complex(-0.0,-2.0),np.complex(2.0,-0.0),np.complex(-6.0,-2.0)},2e-06);assert(sw.dtype=="complex128")
eq(sw:tolist(),{np.complex(-1.0,0.0),np.complex(-1.0,0.0),np.complex(-1.0,0.0)},2e-06) end
do local a=np.array(np.complex(0.0,0.0),"complex128"); local w=np.array(np.complex(-1.0,2.0),"complex64");local v,sw=np.average(a,{returned=true,weights=w});eq(v,np.complex(0.0,-0.0),2e-06);eq(sw,np.complex(-1.0,2.0),2e-06) end
do local a=np.array({-3.0},"float64"); local w=np.array({np.complex(2.0,2.0)},"complex64");local v=np.average(a,{axis={1},weights=w});eq(v,np.complex(-3.0,0.0),2e-06) end
do local a=np.flip(np.array({4},"uint8"),1); local w=np.array({-2.0,1.0},"float16");assert(not pcall(function() np.average(a,{axis={},returned=true,weights=w}) end)) end
do local a=np.flip(np.array({{-3.0,-3.0,0.0}},"float32"),2); local w=np.array(-2.0,"float16");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.array(0,"uint8"); local w=np.array(-2,"int8");local v,sw=np.average(a,{returned=true,weights=w});eq(v,-0.0,0.006);eq(sw,-2.0,0.006) end
do local a=np.array({{0.0,0.0,2.0}},"float32"); local w=np.array({-1.0,-2.0},"float64");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.array({{1,1,0},{0,0,4}},"uint8"); local w=np.array({{2,2,1},{2,2,2}},"uint8");local v=np.average(a,{weights=w});eq(v,1.0909090909090908,0.006) end
do local a=np.zeros({0,3},"complex128"); local w=np.zeros({0,3},"float64");assert(not pcall(function() np.average(a,{axis=1,returned=true,weights=w}) end)) end
do local a=np.flip(np.array({{1.0}},"float64"),2); local w=np.array({3,3},"int8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({0,2},"uint8"); local w=np.array({3,3},"uint8");local v=np.average(a,{axis=1,keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{1.0},0.006) end
do local a=np.zeros({0,3},"float16"); local w=np.zeros({0,3},"complex128");assert(not pcall(function() np.average(a,{axis={1,2},keepdims=true,weights=w}) end)) end
do local a=np.array(0,"uint8"); local w=np.array({-1.0,2.0},"float64");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.array({0,4},"int64"); local w=np.array(-1,"int64");local v,sw=np.average(a,{axis={},returned=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{-0.0,4.0},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{-1.0,-1.0},0.006) end
do local a=np.flip(np.zeros({0},"int8"),1); local w=np.array(2,"int64");local v,sw=np.average(a,{axis={},returned=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{},0.006) end
do local a=np.array({np.complex(1.0,0.0),np.complex(1.0,2.0),np.complex(0.0,2.0)},"complex128"); local w=np.array({true},"bool");assert(not pcall(function() np.average(a,{axis={},returned=true,weights=w}) end)) end
do local a=np.array({{false,true},{false,true},{false,false}},"bool"); local v,sw=np.average(a,{axis={},returned=true});assert(v.dtype=="float64")
eq(v:tolist(),{{0.0,1.0},{0.0,1.0},{0.0,0.0}},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{{1.0,1.0},{1.0,1.0},{1.0,1.0}},0.006) end
do local a=np.zeros({0,3},"float16"); local w=np.array({0,3,1},"int8");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.flip(np.zeros({2,0},"complex64"),2); local w=np.zeros({2,0},"bool");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.zeros({0,3},"float16"),2); local v=np.average(a);eq(v,(0/0),0.006) end
do local a=np.array({{np.complex(4.0,0.0)},{np.complex(-3.0,2.0)}},"complex64"); local w=np.array({np.complex(2.0,0.0),np.complex(0.0,0.0)},"complex64");local v=np.average(a,{axis=1,weights=w});assert(v.dtype=="complex64")
eq(v:tolist(),{np.complex(4.0,0.0)},0.006) end
do local a=np.flip(np.array({{{true,true,false},{true,true,true}},{{false,false,true},{true,true,true}}},"bool"),3); local w=np.array({np.complex(1.0,0.0),np.complex(-1.0,2.0),np.complex(1.0,0.0)},"complex64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.zeros({0},"int8"); local w=np.array({1},"int64");assert(not pcall(function() np.average(a,{axis=1,weights=w}) end)) end
do local a=np.array({{-3.0,0.0},{0.0,0.0},{4.0,-3.0}},"float32"); local w=np.array({{true,true},{true,true},{true,true}},"bool");local v=np.average(a,{axis={1,2},weights=w});eq(v,-0.3333333432674408,0.006) end
do local a=np.array({{0,1,-3}},"int8"); local w=np.array({-2,0,2},"int64");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.array({{{true,true,false},{false,true,true}},{{true,true,true},{true,true,true}}},"bool"); local w=np.array({{{2,2,1},{3,1,2}},{{1,0,0},{1,2,2}}},"uint8");local v,sw=np.average(a,{returned=true,weights=w});eq(v,0.7647058823529411,0.006);eq(sw,17.0,0.006) end
do local a=np.array({{-3.0}},"float32"); local w=np.array({{0}},"uint8");assert(not pcall(function() np.average(a,{axis=2,returned=true,weights=w}) end)) end
do local a=np.flip(np.zeros({0,3},"int32"),2); local w=np.array({false},"bool");assert(not pcall(function() np.average(a,{axis={1,2},returned=true,weights=w}) end)) end
do local a=np.array(1,"int32"); local w=np.array({1},"int32");assert(not pcall(function() np.average(a,{axis={},returned=true,weights=w}) end)) end
do local a=np.array({{{2,2,2},{0,4,1}},{{2,1,0},{0,4,4}}},"uint8"); local w=np.array({{{0,3,0},{0,2,-1}},{{-1,0,2},{-1,-2,3}}},"int32");local v,sw=np.average(a,{returned=true,weights=w});eq(v,3.0,0.006);eq(sw,5.0,0.006) end
do local a=np.array({{-3.0,2.0},{4.0,2.0},{-3.0,4.0}},"float64"); local w=np.array({true,true,false,false},"bool");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{np.complex(0.0,2.0),np.complex(-3.0,2.0)},{np.complex(0.0,0.0),np.complex(2.0,0.0)},{np.complex(1.0,0.0),np.complex(4.0,0.0)}},"complex64"); local w=np.array(0.0,"float32");assert(not pcall(function() np.average(a,{axis={},keepdims=true,weights=w}) end)) end
do local a=np.array({{4}},"int32"); local v=np.average(a,{axis={}});assert(v.dtype=="float64")
eq(v:tolist(),{{4.0}},0.006) end
do local a=np.array({{np.complex(1.0,2.0)}},"complex64"); local v,sw=np.average(a,{axis=2,keepdims=true,returned=true});assert(v.dtype=="complex64")
eq(v:tolist(),{{np.complex(1.0,2.0)}},0.006);assert(sw.dtype=="complex64")
eq(sw:tolist(),{{np.complex(1.0,0.0)}},0.006) end
do local a=np.array({{{1,4,0},{4,1,0}},{{4,0,4},{0,2,0}}},"uint8"); local w=np.array({-2,3,3},"int8");assert(not pcall(function() np.average(a,{axis={1,2,3},weights=w}) end)) end
do local a=np.zeros({0},"float32"); local w=np.array({3.0,-1.0},"float16");assert(not pcall(function() np.average(a,{axis={1},weights=w}) end)) end
do local a=np.flip(np.array({{{0.0,-3.0,0.0},{-3.0,4.0,1.0}},{{4.0,2.0,1.0},{2.0,1.0,0.0}}},"float64"),3); local w=np.array({-2,0,-1},"int32");local v=np.average(a,{axis=3,keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{{-0.0},{-0.3333333333333333}},{{2.0},{0.6666666666666666}}},0.006) end
do local a=np.flip(np.array({{np.complex(4.0,0.0)},{np.complex(1.0,2.0)}},"complex128"),2); local w=np.array({0,-2},"int32");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.transpose(np.array({{4}},"int64")); local v=np.average(a,{axis={}});assert(v.dtype=="float64")
eq(v:tolist(),{{4.0}},0.006) end
do local a=np.transpose(np.array({{0.0},{0.0}},"float32")); local w=np.array({{np.complex(1.0,2.0),np.complex(-1.0,2.0)}},"complex128");local v=np.average(a,{axis={1,2},weights=w});eq(v,np.complex(0.0,0.0),2e-06) end
do local a=np.zeros({0},"float16"); local w=np.zeros({0},"complex64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.transpose(np.array({{np.complex(1.0,2.0),np.complex(1.0,2.0),np.complex(-3.0,2.0)},{np.complex(-3.0,0.0),np.complex(4.0,0.0),np.complex(4.0,2.0)}},"complex64")); local w=np.array({{-1,3},{0,1},{0,1}},"int8");local v=np.average(a,{axis={1,2},weights=w});eq(v,np.complex(-0.5,0.0),0.006) end
do local a=np.array({0,-3},"int8"); local w=np.array({np.complex(-1.0,0.0),np.complex(3.0,2.0)},"complex64");local v,sw=np.average(a,{axis=1,returned=true,weights=w});eq(v,np.complex(-3.75,0.75),2e-06);eq(sw,np.complex(2.0,2.0),2e-06) end
do local a=np.transpose(np.array({{np.complex(2.0,0.0)}},"complex64")); local w=np.array(-1,"int32");assert(not pcall(function() np.average(a,{axis=1,keepdims=true,weights=w}) end)) end
do local a=np.zeros({2,0},"float64"); local w=np.array({false,true,true},"bool");assert(not pcall(function() np.average(a,{axis=1,weights=w}) end)) end
do local a=np.zeros({2,0},"float64"); local w=np.array(np.complex(2.0,2.0),"complex128");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.transpose(np.array({{-3.0},{2.0}},"float64")); local w=np.array({{2.0,2.0}},"float32");local v=np.average(a,{axis={1,2},weights=w});eq(v,-0.5,0.006) end
do local a=np.flip(np.array({1.0},"float16"),1); local v=np.average(a,{axis=1,keepdims=true});assert(v.dtype=="float16")
eq(v:tolist(),{1.0},0.006) end
do local a=np.array({4,0},"uint8"); local w=np.array({1.0,0.0},"float32");local v=np.average(a,{axis=1,weights=w});eq(v,4.0,0.006) end
do local a=np.array({-3,0,0},"int32"); local w=np.array({3,3,2},"uint8");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{-3.0,0.0,0.0},0.006) end
do local a=np.flip(np.array({{np.complex(0.0,2.0)}},"complex64"),2); local w=np.array({2,2},"int8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{false,true,true}},"bool"); local w=np.array(1.0,"float64");assert(not pcall(function() np.average(a,{axis=2,keepdims=true,weights=w}) end)) end
do local a=np.array({{4},{0}},"int32"); local v=np.average(a,{axis={}});assert(v.dtype=="float64")
eq(v:tolist(),{{4.0},{0.0}},0.006) end
do local a=np.array(0.0,"float32"); local v=np.average(a);eq(v,0.0,0.006) end
do local a=np.zeros({0},"float32"); local w=np.array(3,"int8");assert(not pcall(function() np.average(a,{axis={1},weights=w}) end)) end
do local a=np.array({{np.complex(-3.0,2.0)}},"complex64"); local w=np.array({{1}},"int8");local v,sw=np.average(a,{axis={1,2},keepdims=true,returned=true,weights=w});assert(v.dtype=="complex64")
eq(v:tolist(),{{np.complex(-3.0,2.0)}},0.006);assert(sw.dtype=="complex64")
eq(sw:tolist(),{{np.complex(1.0,0.0)}},0.006) end
do local a=np.flip(np.array({{{1,0,0},{0,0,2}},{{1,0,2},{4,0,0}}},"uint8"),3); local w=np.array({-2.0,-2.0,-2.0},"float64");local v,sw=np.average(a,{axis=3,keepdims=true,returned=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{{0.3333333333333333},{0.6666666666666666}},{{1.0},{1.3333333333333333}}},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{{{-6.0},{-6.0}},{{-6.0},{-6.0}}},0.006) end
do local a=np.array({{2.0,-3.0,0.0},{1.0,-3.0,2.0}},"float64"); local w=np.array({false,true,true},"bool");assert(not pcall(function() np.average(a,{axis=1,weights=w}) end)) end
do local a=np.flip(np.array({{2.0,0.0},{4.0,1.0},{2.0,0.0}},"float16"),2); local w=np.array(1,"uint8");local v=np.average(a,{axis={},keepdims=true,weights=w});assert(v.dtype=="float16")
eq(v:tolist(),{{0.0,2.0},{1.0,4.0},{0.0,2.0}},0.006) end
do local a=np.array(1,"int8"); local v=np.average(a);eq(v,1.0,0.006) end
do local a=np.array({np.complex(-3.0,0.0)},"complex128"); local w=np.array({1.0},"float16");local v=np.average(a,{axis=1,keepdims=true,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{np.complex(-3.0,0.0)},2e-06) end
do local a=np.flip(np.array({{-3.0,1.0},{1.0,1.0},{0.0,1.0}},"float16"),2); local v=np.average(a);eq(v,0.1666259765625,0.006) end
do local a=np.zeros({0},"int8"); local w=np.array({1,-2,3},"int64");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.flip(np.zeros({2,0},"int8"),2); local w=np.array({-2.0,2.0,3.0},"float32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array(1,"uint8"); local w=np.array({2,2},"uint8");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.array({2.0,4.0},"float64"); local w=np.array({1.0,-1.0},"float64");assert(not pcall(function() np.average(a,{axis=1,weights=w}) end)) end
do local a=np.flip(np.array({{0.0},{2.0}},"float16"),2); local v=np.average(a,{axis={1,2}});eq(v,1.0,0.006) end
do local a=np.array({{1,2,2}},"int32"); local w=np.array({np.complex(0.0,2.0)},"complex64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({{4.0}},"float64"),2); local w=np.array({{true}},"bool");local v,sw=np.average(a,{returned=true,weights=w});eq(v,4.0,0.006);eq(sw,1.0,0.006) end
do local a=np.array({0.0,1.0},"float16"); local w=np.array(1,"int8");assert(not pcall(function() np.average(a,{axis=1,weights=w}) end)) end
do local a=np.array({{0},{0}},"int8"); local w=np.array({{-1.0},{1.0}},"float32");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{-0.0},{0.0}},0.006) end
do local a=np.transpose(np.array({{1,0,-3},{0,0,2}},"int64")); local w=np.array({{1,1},{3,-1},{2,2}},"int8");local v,sw=np.average(a,{axis={1,2},returned=true,weights=w});eq(v,-0.125,0.006);eq(sw,8.0,0.006) end
do local a=np.flip(np.array({{{4,4,-3},{2,1,-3}},{{0,1,-3},{2,2,0}}},"int8"),3); local w=np.array({-2,2,3},"int32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({1},"int32"); local v,sw=np.average(a,{axis={},returned=true});assert(v.dtype=="float64")
eq(v:tolist(),{1.0},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{1.0},0.006) end
do local a=np.transpose(np.array({{4},{1}},"int32")); local v=np.average(a,{axis={1,2}});eq(v,2.5,0.006) end
do local a=np.flip(np.array({0},"uint8"),1); local w=np.array({3.0,-2.0},"float16");assert(not pcall(function() np.average(a,{axis=1,weights=w}) end)) end
do local a=np.zeros({0},"float16"); local w=np.zeros({0},"int32");assert(not pcall(function() np.average(a,{axis=1,weights=w}) end)) end
do local a=np.zeros({0},"bool"); local w=np.zeros({0},"int32");assert(not pcall(function() np.average(a,{axis=1,weights=w}) end)) end
do local a=np.array({0,0},"int32"); local w=np.array({true,true},"bool");local v=np.average(a,{axis=1,keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{0.0},0.006) end
do local a=np.array(np.complex(4.0,0.0),"complex64"); local w=np.array(2,"int64");local v,sw=np.average(a,{axis={},returned=true,weights=w});eq(v,np.complex(4.0,0.0),2e-06);eq(sw,np.complex(2.0,0.0),2e-06) end
do local a=np.flip(np.zeros({0,3},"int8"),2); local w=np.array({3.0,3.0},"float64");assert(not pcall(function() np.average(a,{axis={},returned=true,weights=w}) end)) end
do local a=np.array({{2.0,0.0,1.0}},"float64"); local w=np.array({{-2,2,-1}},"int8");local v=np.average(a,{weights=w});eq(v,5.0,0.006) end
do local a=np.array({{-3.0},{0.0}},"float64"); local v=np.average(a,{axis=1,keepdims=true});assert(v.dtype=="float64")
eq(v:tolist(),{{-1.5}},0.006) end
do local a=np.transpose(np.array({{2.0,4.0,2.0},{0.0,2.0,1.0}},"float32")); local w=np.array({np.complex(-1.0,0.0),np.complex(2.0,0.0)},"complex128");local v=np.average(a,{axis=2,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)},2e-06) end
do local a=np.zeros({2,0},"float16"); local w=np.zeros({2,0},"int64");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{},{}},0.006) end
do local a=np.zeros({0,3},"complex128"); local w=np.zeros({0,3},"complex128");local v,sw=np.average(a,{axis={},returned=true,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{},2e-06);assert(sw.dtype=="complex128")
eq(sw:tolist(),{},2e-06) end
do local a=np.array({{4,-3,0},{-3,-3,4}},"int8"); local v,sw=np.average(a,{axis=2,keepdims=true,returned=true});assert(v.dtype=="float64")
eq(v:tolist(),{{0.3333333333333333},{-0.6666666666666666}},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{{3.0},{3.0}},0.006) end
do local a=np.transpose(np.array({{0.0,0.0,4.0},{2.0,4.0,4.0}},"float64")); local w=np.array({-2,1,-1,2},"int64");assert(not pcall(function() np.average(a,{axis={},returned=true,weights=w}) end)) end
do local a=np.array(4,"int32"); local v=np.average(a);eq(v,4.0,0.006) end
do local a=np.zeros({2,0},"complex64"); local w=np.array({1,2},"uint8");local v=np.average(a,{axis=1,keepdims=true,weights=w});assert(v.dtype=="complex64")
eq(v:tolist(),{{}},0.006) end
do local a=np.transpose(np.array({{true}},"bool")); local w=np.array(2,"uint8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array(-3.0,"float64"); local w=np.array({1},"int32");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.array({{np.complex(4.0,2.0),np.complex(1.0,0.0),np.complex(2.0,2.0)},{np.complex(1.0,2.0),np.complex(1.0,0.0),np.complex(0.0,0.0)}},"complex64"); local w=np.array({{1,2,2},{-1,-2,0}},"int8");local v=np.average(a,{weights=w});eq(v,np.complex(3.5,2.0),0.006) end
do local a=np.array({{4},{0}},"int8"); local w=np.array({{3},{1}},"int8");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{4.0},{0.0}},0.006) end
do local a=np.flip(np.zeros({0},"float32"),1); local w=np.array(-1,"int64");assert(not pcall(function() np.average(a,{axis={1},keepdims=true,weights=w}) end)) end
do local a=np.flip(np.array({{0},{4}},"uint8"),2); local v=np.average(a,{axis=1});assert(v.dtype=="float64")
eq(v:tolist(),{2.0},0.006) end
do local a=np.zeros({2,0},"complex128"); local w=np.zeros({2,0},"float64");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{{},{}},2e-06) end
do local a=np.array({{0.0,-3.0,0.0},{-3.0,0.0,4.0}},"float64"); local w=np.array({{-1,0,0},{-1,-1,-1}},"int32");local v=np.average(a,{axis={1,2},weights=w});eq(v,0.25,0.006) end
do local a=np.flip(np.array({1,0,2},"uint8"),1); local w=np.array(2.0,"float64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.transpose(np.array({{0,4},{2,2},{-3,1}},"int32")); local w=np.array({np.complex(0.0,2.0),np.complex(2.0,2.0),np.complex(-1.0,0.0)},"complex64");local v=np.average(a,{axis=2,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{np.complex(1.3529411764705883,-1.4117647058823528),np.complex(3.0,0.0)},2e-06) end
do local a=np.array({{np.complex(-3.0,0.0),np.complex(4.0,0.0),np.complex(4.0,2.0)},{np.complex(-3.0,2.0),np.complex(2.0,0.0),np.complex(1.0,0.0)}},"complex128"); local w=np.array({{0,0,2},{1,0,0}},"int8");local v=np.average(a,{weights=w});eq(v,np.complex(1.6666666666666665,2.0),2e-06) end
do local a=np.array({true,true,false},"bool"); local w=np.array({1,2,2},"int32");local v=np.average(a,{axis={1},keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{0.6},0.006) end
do local a=np.array(1,"int8"); local w=np.array(0.0,"float32");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.array({{0,2,0},{2,4,-3}},"int64"); local w=np.array({1.0,2.0,-1.0},"float32");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.transpose(np.array({{{1.0,1.0,0.0},{-3.0,0.0,0.0}},{{2.0,-3.0,0.0},{1.0,2.0,-3.0}}},"float32")); local w=np.array(2.0,"float32");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.array({{np.complex(1.0,0.0),np.complex(0.0,0.0),np.complex(0.0,2.0)},{np.complex(0.0,0.0),np.complex(-3.0,2.0),np.complex(1.0,0.0)}},"complex128"); local w=np.array({3.0,2.0,1.0},"float64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({2.0,0.0,4.0},"float32"),1); local v=np.average(a);eq(v,2.0,0.006) end
do local a=np.flip(np.array({{np.complex(4.0,0.0),np.complex(4.0,2.0),np.complex(4.0,2.0)},{np.complex(4.0,0.0),np.complex(4.0,0.0),np.complex(1.0,0.0)}},"complex64"),2); local w=np.array(0,"uint8");assert(not pcall(function() np.average(a,{axis=2,weights=w}) end)) end
do local a=np.array(2,"int32"); local v=np.average(a);eq(v,2.0,0.006) end
do local a=np.zeros({2,0},"bool"); assert(not pcall(function() np.average(a,{axis={}}) end)) end
do local a=np.transpose(np.zeros({0,3},"float64")); local w=np.array({3,0,0,3},"uint8");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.array({4.0,0.0},"float16"); local w=np.array({3.0,0.0},"float32");assert(not pcall(function() np.average(a,{axis={},keepdims=true,returned=true,weights=w}) end)) end
do local a=np.zeros({0},"float32"); local w=np.array({2,2,-1},"int8");assert(not pcall(function() np.average(a,{axis={1},keepdims=true,weights=w}) end)) end
do local a=np.flip(np.array({{0,-3},{0,0},{4,4}},"int8"),2); local w=np.array(np.complex(-2.0,0.0),"complex128");assert(not pcall(function() np.average(a,{axis=1,returned=true,weights=w}) end)) end
do local a=np.array({{{4,1,4},{-3,4,4}},{{-3,0,2},{2,0,0}}},"int32"); local w=np.array({np.complex(1.0,0.0),np.complex(-2.0,2.0),np.complex(-1.0,2.0)},"complex64");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.flip(np.array({2,4},"uint8"),1); local w=np.array({-2.0,3.0},"float32");local v,sw=np.average(a,{keepdims=true,returned=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{-2.0},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{1.0},0.006) end
do local a=np.zeros({0,3},"uint8"); local w=np.array(0.0,"float32");assert(not pcall(function() np.average(a,{axis=1,returned=true,weights=w}) end)) end
do local a=np.array({2,4},"uint8"); local w=np.array({3.0,1.0,0.0},"float32");assert(not pcall(function() np.average(a,{axis={1},weights=w}) end)) end
do local a=np.array({2.0,1.0,4.0},"float32"); local w=np.array({3,1,-2,-2},"int8");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.array({np.complex(2.0,0.0),np.complex(-3.0,0.0)},"complex64"); local v,sw=np.average(a,{axis={},returned=true});assert(v.dtype=="complex64")
eq(v:tolist(),{np.complex(2.0,0.0),np.complex(-3.0,0.0)},0.006);assert(sw.dtype=="complex64")
eq(sw:tolist(),{np.complex(1.0,0.0),np.complex(1.0,0.0)},0.006) end
do local a=np.array({{0,-3,-3}},"int64"); local w=np.array({{np.complex(2.0,2.0),np.complex(0.0,0.0),np.complex(1.0,0.0)}},"complex128");local v,sw=np.average(a,{axis={1,2},returned=true,weights=w});eq(v,np.complex(-0.6923076923076923,0.46153846153846156),2e-06);eq(sw,np.complex(3.0,2.0),2e-06) end
do local a=np.array({{1.0,4.0,1.0}},"float64"); local w=np.array({{3,1,3}},"int32");local v=np.average(a,{keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{1.4285714285714286}},0.006) end
do local a=np.array({true,false,true},"bool"); local w=np.array({2,0,3},"int8");local v=np.average(a,{weights=w});eq(v,1.0,0.006) end
do local a=np.zeros({2,0},"complex128"); local v=np.average(a,{axis={1,2},keepdims=true});assert(v.dtype=="complex128")
eq(v:tolist(),{{np.complex((0/0),(0/0))}},2e-06) end
do local a=np.transpose(np.array({{-3.0}},"float32")); local w=np.array({{1}},"uint8");local v,sw=np.average(a,{axis={},returned=true,weights=w});assert(v.dtype=="float32")
eq(v:tolist(),{{-3.0}},0.006);assert(sw.dtype=="float32")
eq(sw:tolist(),{{1.0}},0.006) end
do local a=np.transpose(np.zeros({2,0},"bool")); local w=np.zeros({0,2},"bool");local v,sw=np.average(a,{axis={},returned=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{},0.006) end
do local a=np.flip(np.array({{0.0}},"float16"),2); local w=np.array({{np.complex(0.0,0.0)}},"complex128");assert(not pcall(function() np.average(a,{axis=1,weights=w}) end)) end
do local a=np.flip(np.zeros({2,0},"int8"),2); local w=np.array(np.complex(2.0,2.0),"complex64");local v=np.average(a,{axis={},keepdims=true,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{{},{}},2e-06) end
do local a=np.array({0,1},"int32"); local w=np.array({2,-2,0},"int8");assert(not pcall(function() np.average(a,{axis={},returned=true,weights=w}) end)) end
do local a=np.flip(np.array({-3},"int64"),1); local w=np.array({-2.0,-1.0},"float64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.transpose(np.array({{{np.complex(4.0,0.0),np.complex(4.0,0.0),np.complex(4.0,0.0)},{np.complex(-3.0,0.0),np.complex(-3.0,2.0),np.complex(1.0,0.0)}},{{np.complex(0.0,0.0),np.complex(4.0,0.0),np.complex(2.0,0.0)},{np.complex(2.0,0.0),np.complex(-3.0,0.0),np.complex(1.0,0.0)}}},"complex64")); local w=np.array({1.0,-2.0,3.0},"float32");assert(not pcall(function() np.average(a,{axis={},keepdims=true,weights=w}) end)) end
do local a=np.flip(np.array({{4.0,1.0,4.0},{-3.0,0.0,0.0}},"float32"),2); local v,sw=np.average(a,{returned=true});eq(v,1.0,0.006);eq(sw,6.0,0.006) end
do local a=np.array({{{0.0,4.0,1.0},{0.0,0.0,0.0}},{{4.0,-3.0,2.0},{-3.0,1.0,0.0}}},"float16"); local w=np.array({0.0,1.0},"float64");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.array(0.0,"float16"); local w=np.array(3,"int8");local v=np.average(a,{weights=w});eq(v,0.0,0.006) end
do local a=np.array({{-3,0,2},{0,-3,0}},"int8"); local v,sw=np.average(a,{keepdims=true,returned=true});assert(v.dtype=="float64")
eq(v:tolist(),{{-0.6666666666666666}},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{{6.0}},0.006) end
do local a=np.array({true},"bool"); local v=np.average(a,{axis={}});assert(v.dtype=="float64")
eq(v:tolist(),{1.0},0.006) end
do local a=np.array({{-3.0}},"float16"); local w=np.array({{3}},"int8");local v=np.average(a,{axis=1,keepdims=true,weights=w});assert(v.dtype=="float16")
eq(v:tolist(),{{-3.0}},0.006) end
do local a=np.array({1.0},"float32"); local v,sw=np.average(a,{keepdims=true,returned=true});assert(v.dtype=="float32")
eq(v:tolist(),{1.0},0.006);assert(sw.dtype=="float32")
eq(sw:tolist(),{1.0},0.006) end
do local a=np.zeros({0,3},"bool"); local w=np.zeros({0,3},"float16");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{},0.006) end
do local a=np.zeros({0,3},"float64"); local w=np.array({true},"bool");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{np.complex(1.0,0.0),np.complex(0.0,0.0),np.complex(2.0,2.0)}},"complex128"); local w=np.array({2.0},"float32");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.array(np.complex(2.0,0.0),"complex128"); local v=np.average(a,{axis={}});eq(v,np.complex(2.0,0.0),2e-06) end
do local a=np.array({{0,0,0},{0,0,4}},"int8"); local w=np.array(1,"uint8");assert(not pcall(function() np.average(a,{axis=2,weights=w}) end)) end
do local a=np.array({{2}},"int64"); local w=np.array({-1.0},"float64");local v=np.average(a,{axis=2,keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{2.0}},0.006) end
do local a=np.array({{true,false,true},{true,false,true}},"bool"); local w=np.array({0,2,3},"uint8");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.array({4},"uint8"); local w=np.array({3,-2},"int8");assert(not pcall(function() np.average(a,{axis={1},weights=w}) end)) end
do local a=np.array({{0,-3},{0,4},{0,0}},"int64"); local w=np.array({{np.complex(-1.0,0.0),np.complex(1.0,0.0)},{np.complex(1.0,2.0),np.complex(-1.0,0.0)},{np.complex(-1.0,0.0),np.complex(1.0,0.0)}},"complex128");local v,sw=np.average(a,{axis={1,2},returned=true,weights=w});eq(v,np.complex(0.0,3.5),2e-06);eq(sw,np.complex(0.0,2.0),2e-06) end
do local a=np.flip(np.zeros({0},"int8"),1); local w=np.zeros({0},"int32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({2},"uint8"); local w=np.array({2.0},"float32");local v=np.average(a,{keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{2.0},0.006) end
do local a=np.array({{true,false,true}},"bool"); local w=np.array({{0,-1,1}},"int8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({0,1,2},"uint8"),1); local v=np.average(a,{axis={1}});eq(v,1.0,0.006) end
do local a=np.zeros({0},"complex128"); local w=np.array(np.complex(-1.0,0.0),"complex128");assert(not pcall(function() np.average(a,{axis={1},weights=w}) end)) end
do local a=np.array({{1.0,0.0,0.0},{0.0,0.0,1.0}},"float64"); local w=np.array({{3,2,3},{-2,2,3}},"int32");local v=np.average(a,{axis=2,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{0.375,1.0},0.006) end
do local a=np.array({{0,4,4},{-3,0,0}},"int32"); local w=np.array({{-2,3,-2},{3,0,-2}},"int64");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.array({{2}},"uint8"); local w=np.array({{1}},"int8");local v,sw=np.average(a,{axis={1,2},returned=true,weights=w});eq(v,2.0,0.006);eq(sw,1.0,0.006) end
do local a=np.zeros({0,3},"float32"); local v,sw=np.average(a,{returned=true});eq(v,(0/0),0.006);eq(sw,0.0,0.006) end
do local a=np.array({true,true},"bool"); local w=np.array({-1.0},"float32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{-3.0,4.0,2.0}},"float32"); local w=np.array({np.complex(-2.0,0.0)},"complex128");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.transpose(np.array({{np.complex(1.0,0.0),np.complex(-3.0,0.0)},{np.complex(4.0,0.0),np.complex(4.0,0.0)},{np.complex(4.0,0.0),np.complex(2.0,0.0)}},"complex64")); local w=np.array(1,"int8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.transpose(np.array({{{np.complex(-3.0,0.0),np.complex(4.0,0.0),np.complex(2.0,0.0)},{np.complex(-3.0,2.0),np.complex(-3.0,0.0),np.complex(-3.0,0.0)}},{{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(4.0,2.0)}}},"complex64")); local w=np.array({{{-2,0},{2,2}},{{3,0},{-1,0}},{{3,-1},{2,-1}}},"int8");local v=np.average(a,{axis={1,2,3},weights=w});eq(v,np.complex(1.571428656578064,0.2857142984867096),0.006) end
do local a=np.array({{np.complex(-3.0,0.0)}},"complex64"); local w=np.array({{-2}},"int8");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="complex64")
eq(v:tolist(),{{np.complex(-3.0,-0.0)}},0.006) end
do local a=np.array(0,"int32"); local w=np.array({-1.0,2.0},"float16");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.array({{4,0},{-3,-3},{1,4}},"int8"); local w=np.array({{1,1},{1,2},{0,0}},"uint8");local v=np.average(a,{weights=w});eq(v,-1.0,0.006) end
do local a=np.array({{{1.0,2.0,0.0},{0.0,0.0,-3.0}},{{-3.0,4.0,-3.0},{0.0,-3.0,0.0}}},"float64"); local w=np.array({1,-1},"int32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{-3,0},{2,0},{0,0}},"int8"); local w=np.array(1,"int8");assert(not pcall(function() np.average(a,{axis=2,weights=w}) end)) end
do local a=np.array({{4.0,1.0},{2.0,4.0},{0.0,4.0}},"float16"); local w=np.array({{2.0,3.0},{-2.0,0.0},{1.0,-2.0}},"float16");local v,sw=np.average(a,{axis={1,2},keepdims=true,returned=true,weights=w});assert(v.dtype=="float16")
eq(v:tolist(),{{-0.5}},0.006);assert(sw.dtype=="float16")
eq(sw:tolist(),{{2.0}},0.006) end
do local a=np.zeros({0},"uint8"); local w=np.array({-1.0,-2.0},"float16");assert(not pcall(function() np.average(a,{axis={1},keepdims=true,weights=w}) end)) end
do local a=np.array({{np.complex(4.0,0.0)}},"complex64"); local w=np.array({3,-2,2},"int8");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.zeros({2,0},"float64"); local w=np.zeros({2,0},"float64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({{-3.0}},"float64"),2); local w=np.array({2.0,3.0},"float64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array(0,"int32"); local v=np.average(a,{keepdims=true});eq(v,0.0,0.006) end
do local a=np.array({{{4.0,0.0,2.0},{-3.0,0.0,2.0}},{{1.0,4.0,0.0},{0.0,-3.0,2.0}}},"float64"); local w=np.array({-2.0,0.0,0.0},"float64");assert(not pcall(function() np.average(a,{axis={1,2,3},weights=w}) end)) end
do local a=np.array({{4,0,4},{2,1,2}},"uint8"); local w=np.array({{2.0,1.0,3.0},{3.0,-1.0,3.0}},"float32");local v=np.average(a,{axis={1,2},keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{2.8181818181818183}},0.006) end
do local a=np.array({0.0,0.0,0.0},"float32"); local w=np.array({np.complex(-1.0,0.0),np.complex(-2.0,0.0),np.complex(1.0,2.0),np.complex(-1.0,0.0)},"complex64");assert(not pcall(function() np.average(a,{axis={1},keepdims=true,weights=w}) end)) end
do local a=np.array({2,-3},"int32"); local v=np.average(a);eq(v,-0.5,0.006) end
do local a=np.flip(np.array({{{4.0,-3.0,0.0},{2.0,-3.0,2.0}},{{4.0,2.0,1.0},{4.0,4.0,0.0}}},"float64"),3); local w=np.array({{{2.0,-1.0,1.0},{0.0,0.0,0.0}},{{3.0,2.0,1.0},{-1.0,-2.0,-1.0}}},"float32");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.transpose(np.array({{0,-3,1},{1,4,-3}},"int32")); local v=np.average(a,{axis={}});assert(v.dtype=="float64")
eq(v:tolist(),{{0.0,1.0},{-3.0,4.0},{1.0,-3.0}},0.006) end
do local a=np.flip(np.array({0.0,1.0},"float32"),1); local w=np.array({2,3},"int64");local v=np.average(a,{axis={1},weights=w});eq(v,0.4,0.006) end
do local a=np.flip(np.array({{2.0}},"float64"),2); local w=np.array({{1.0}},"float32");local v=np.average(a,{weights=w});eq(v,2.0,0.006) end
do local a=np.array({np.complex(4.0,2.0)},"complex64"); local w=np.array({np.complex(1.0,2.0),np.complex(1.0,2.0)},"complex128");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.transpose(np.array({{true,false,false}},"bool")); local w=np.array({-1.0,1.0,1.0,0.0},"float32");assert(not pcall(function() np.average(a,{axis={1,2},keepdims=true,weights=w}) end)) end
do local a=np.zeros({0},"uint8"); local w=np.array({1.0},"float16");assert(not pcall(function() np.average(a,{axis={1},weights=w}) end)) end
do local a=np.zeros({2,0},"float16"); local v=np.average(a,{keepdims=true});assert(v.dtype=="float16")
eq(v:tolist(),{{(0/0)}},0.006) end
do local a=np.array({-3.0,0.0,0.0},"float16"); local w=np.array({np.complex(1.0,0.0),np.complex(-1.0,0.0),np.complex(3.0,0.0)},"complex128");local v=np.average(a,{axis=1,keepdims=true,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{np.complex(-1.0,0.0)},2e-06) end
do local a=np.array({{0}},"uint8"); local v=np.average(a);eq(v,0.0,0.006) end
do local a=np.array({{1,2,-3},{0,4,2}},"int8"); local w=np.array({{2,2,2},{2,3,2}},"uint8");local v=np.average(a,{weights=w});eq(v,1.2307692307692308,0.006) end
do local a=np.array({0.0,-3.0},"float16"); local w=np.array({2,-1},"int32");local v=np.average(a,{weights=w});eq(v,3.0,0.006) end
do local a=np.flip(np.array({{true,false},{true,true},{false,true}},"bool"),2); local v=np.average(a,{keepdims=true});assert(v.dtype=="float64")
eq(v:tolist(),{{0.6666666666666666}},0.006) end
do local a=np.array({{{-3.0,-3.0,0.0},{4.0,0.0,-3.0}},{{-3.0,-3.0,2.0},{-3.0,2.0,4.0}}},"float32"); local w=np.array({{{-1.0,2.0,2.0},{-1.0,2.0,1.0}},{{3.0,0.0,-2.0},{3.0,-2.0,2.0}}},"float64");local v=np.average(a,{axis=3,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{-1.0,-3.5},{-13.0,-1.6666666666666667}},0.006) end
do local a=np.flip(np.array({{2},{2}},"int32"),2); local w=np.array(3,"uint8");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{2.0},{2.0}},0.006) end
do local a=np.array({{np.complex(1.0,0.0),np.complex(-3.0,0.0),np.complex(0.0,0.0)}},"complex128"); local v,sw=np.average(a,{axis={1,2},returned=true});eq(v,np.complex(-0.6666666666666666,0.0),2e-06);eq(sw,np.complex(3.0,0.0),2e-06) end
do local a=np.array(1.0,"float64"); local w=np.array(2,"int64");local v=np.average(a,{weights=w});eq(v,1.0,0.006) end
do local a=np.array({{0.0},{2.0}},"float32"); local w=np.array({np.complex(0.0,0.0),np.complex(3.0,0.0),np.complex(2.0,0.0)},"complex64");assert(not pcall(function() np.average(a,{axis={1,2},returned=true,weights=w}) end)) end
do local a=np.transpose(np.array({{1.0}},"float16")); local w=np.array({np.complex(2.0,2.0),np.complex(0.0,0.0)},"complex64");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.array({{np.complex(1.0,0.0),np.complex(0.0,0.0)},{np.complex(0.0,0.0),np.complex(4.0,0.0)},{np.complex(2.0,2.0),np.complex(0.0,0.0)}},"complex128"); local w=np.array({{np.complex(1.0,0.0),np.complex(-1.0,2.0)},{np.complex(1.0,2.0),np.complex(-2.0,2.0)},{np.complex(2.0,0.0),np.complex(3.0,0.0)}},"complex128");local v=np.average(a,{weights=w});eq(v,np.complex(1.153846153846154,1.2692307692307694),2e-06) end
do local a=np.array({{false},{false}},"bool"); local w=np.array({2.0,0.0,3.0},"float32");assert(not pcall(function() np.average(a,{axis={},keepdims=true,returned=true,weights=w}) end)) end
do local a=np.zeros({0},"complex64"); local w=np.array({2.0},"float32");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.zeros({0,3},"int32"); local w=np.array({1,0,1},"int64");local v,sw=np.average(a,{axis=2,returned=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{},0.006) end
do local a=np.array({0,0,4},"int32"); local w=np.array({2,3},"int32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({0.0,1.0,-3.0},"float16"); local w=np.array({-1,-2,-2},"int8");local v=np.average(a,{weights=w});eq(v,-0.7998046875,0.006) end
do local a=np.flip(np.array({{4,2,1},{0,0,1}},"uint8"),2); local w=np.array({{np.complex(-2.0,2.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},{np.complex(3.0,0.0),np.complex(1.0,2.0),np.complex(0.0,2.0)}},"complex64");local v=np.average(a,{weights=w});eq(v,np.complex(1.5411764705882354,-1.0352941176470587),2e-06) end
do local a=np.transpose(np.zeros({2,0},"float16")); local w=np.zeros({0,2},"float32");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="float32")
eq(v:tolist(),{},0.006) end
do local a=np.zeros({2,0},"complex64"); local w=np.zeros({2,0},"complex128");assert(not pcall(function() np.average(a,{axis={1,2},returned=true,weights=w}) end)) end
do local a=np.array({{2,0,0},{4,0,2}},"int32"); local w=np.array({{0,2,1},{1,3,3}},"uint8");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.array({{0.0,0.0,4.0}},"float16"); local w=np.array({-1,3},"int32");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.transpose(np.array({{{0,0,4},{0,1,0}},{{1,1,0},{1,0,2}}},"uint8")); local w=np.array({-2,-1,3},"int32");assert(not pcall(function() np.average(a,{axis={1,2,3},weights=w}) end)) end
do local a=np.transpose(np.array({{4.0,0.0},{1.0,2.0},{-3.0,0.0}},"float16")); local w=np.array({1,1,1},"uint8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{4}},"int64"); local v=np.average(a,{axis={1,2}});eq(v,4.0,0.006) end
do local a=np.array({2.0,0.0},"float64"); local v,sw=np.average(a,{axis=1,returned=true});eq(v,1.0,0.006);eq(sw,2.0,0.006) end
do local a=np.array(0,"uint8"); local w=np.array({np.complex(3.0,2.0),np.complex(3.0,0.0),np.complex(3.0,0.0)},"complex128");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{np.complex(0.0,0.0),np.complex(2.0,2.0)},{np.complex(0.0,0.0),np.complex(0.0,2.0)},{np.complex(0.0,0.0),np.complex(2.0,0.0)}},"complex64"); local v,sw=np.average(a,{returned=true});eq(v,np.complex(0.6666666865348816,0.6666666865348816),0.006);eq(sw,np.complex(6.0,0.0),0.006) end
do local a=np.array({{1.0,-3.0,-3.0},{0.0,1.0,-3.0}},"float32"); local v=np.average(a,{keepdims=true});assert(v.dtype=="float32")
eq(v:tolist(),{{-1.1666666269302368}},0.006) end
do local a=np.flip(np.array({{{false,true,false},{true,true,true}},{{true,true,true},{false,false,false}}},"bool"),3); local w=np.array({{{1.0,2.0,0.0},{-1.0,1.0,-1.0}},{{2.0,2.0,-1.0},{2.0,-2.0,2.0}}},"float16");assert(not pcall(function() np.average(a,{axis=2,weights=w}) end)) end
do local a=np.array({{0,4,4},{0,4,1}},"int64"); local w=np.array({{3.0,-2.0,-1.0},{2.0,-2.0,0.0}},"float32");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.array({{4}},"uint8"); local w=np.array(true,"bool");assert(not pcall(function() np.average(a,{axis={1,2},keepdims=true,weights=w}) end)) end
do local a=np.zeros({2,0},"bool"); local w=np.zeros({2,0},"int64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.transpose(np.array({{0.0}},"float16")); local v=np.average(a,{axis={1,2}});eq(v,0.0,0.006) end
do local a=np.zeros({0},"complex64"); assert(not pcall(function() np.average(a,{axis={},keepdims=true}) end)) end
do local a=np.zeros({0},"int8"); local w=np.zeros({0},"int32");assert(not pcall(function() np.average(a,{axis={1},weights=w}) end)) end
do local a=np.array({{np.complex(0.0,2.0),np.complex(0.0,2.0),np.complex(4.0,0.0)}},"complex128"); local w=np.array(3,"int64");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.transpose(np.zeros({0,3},"int32")); local w=np.array(np.complex(-1.0,0.0),"complex64");assert(not pcall(function() np.average(a,{axis=2,weights=w}) end)) end
do local a=np.transpose(np.array({{0.0}},"float16")); local v=np.average(a,{axis={}});assert(v.dtype=="float16")
eq(v:tolist(),{{0.0}},0.006) end
do local a=np.array({2,0,1},"int32"); local w=np.array(0.0,"float32");assert(not pcall(function() np.average(a,{axis={1},weights=w}) end)) end
do local a=np.array({0.0,4.0},"float64"); local w=np.array({0,3},"int8");local v=np.average(a,{keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{4.0},0.006) end
do local a=np.array({np.complex(0.0,0.0),np.complex(2.0,2.0),np.complex(1.0,0.0)},"complex64"); local w=np.array({3,0,-1},"int64");local v,sw=np.average(a,{axis=1,returned=true,weights=w});eq(v,np.complex(-0.5,0.0),2e-06);eq(sw,np.complex(2.0,0.0),2e-06) end
do local a=np.array({{-3,-3,0}},"int64"); local w=np.array({true,false},"bool");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{np.complex(1.0,0.0)},{np.complex(2.0,0.0)}},"complex128"); local w=np.array(-1,"int8");assert(not pcall(function() np.average(a,{axis={1,2},keepdims=true,weights=w}) end)) end
do local a=np.array(np.complex(-3.0,0.0),"complex64"); local w=np.array({0,-2},"int32");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.transpose(np.zeros({0,3},"float32")); local w=np.array({true,true,true,true},"bool");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.zeros({2,0},"bool"); local w=np.array({np.complex(-1.0,2.0),np.complex(-2.0,0.0),np.complex(-2.0,0.0)},"complex128");assert(not pcall(function() np.average(a,{axis={1,2},keepdims=true,weights=w}) end)) end
do local a=np.array({{{2.0,4.0,2.0},{-3.0,-3.0,1.0}},{{0.0,1.0,0.0},{0.0,2.0,-3.0}}},"float64"); local w=np.array({np.complex(1.0,2.0),np.complex(0.0,0.0)},"complex64");assert(not pcall(function() np.average(a,{axis={1,2,3},returned=true,weights=w}) end)) end
do local a=np.flip(np.array({{4,0,4}},"int8"),2); local w=np.array({1.0,1.0},"float64");assert(not pcall(function() np.average(a,{axis={1,2},returned=true,weights=w}) end)) end
do local a=np.flip(np.array({0.0,0.0,4.0},"float32"),1); local w=np.array({2.0,-2.0,-1.0},"float32");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="float32")
eq(v:tolist(),{4.0,-0.0,-0.0},0.006) end
do local a=np.zeros({0,3},"float16"); local v,sw=np.average(a,{axis=1,keepdims=true,returned=true});assert(v.dtype=="float16")
eq(v:tolist(),{{(0/0),(0/0),(0/0)}},0.006);assert(sw.dtype=="float16")
eq(sw:tolist(),{{0.0,0.0,0.0}},0.006) end
do local a=np.array(0,"int64"); local w=np.array(0.0,"float16");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.array({{-3.0,4.0,2.0}},"float64"); local v,sw=np.average(a,{axis={},returned=true});assert(v.dtype=="float64")
eq(v:tolist(),{{-3.0,4.0,2.0}},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{{1.0,1.0,1.0}},0.006) end
do local a=np.array({{2,4},{0,0},{4,2}},"uint8"); local v=np.average(a,{axis=1,keepdims=true});assert(v.dtype=="float64")
eq(v:tolist(),{{2.0,2.0}},0.006) end
do local a=np.transpose(np.array({{{0.0,-3.0,0.0},{1.0,0.0,0.0}},{{0.0,0.0,0.0},{0.0,0.0,-3.0}}},"float32")); local v,sw=np.average(a,{axis={},returned=true});assert(v.dtype=="float32")
eq(v:tolist(),{{{0.0,0.0},{1.0,0.0}},{{-3.0,0.0},{0.0,0.0}},{{0.0,0.0},{0.0,-3.0}}},0.006);assert(sw.dtype=="float32")
eq(sw:tolist(),{{{1.0,1.0},{1.0,1.0}},{{1.0,1.0},{1.0,1.0}},{{1.0,1.0},{1.0,1.0}}},0.006) end
do local a=np.flip(np.array({{np.complex(-3.0,2.0),np.complex(4.0,2.0)},{np.complex(-3.0,0.0),np.complex(0.0,2.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0)}},"complex64"),2); local v=np.average(a,{axis={1,2},keepdims=true});assert(v.dtype=="complex64")
eq(v:tolist(),{{np.complex(-0.3333333432674408,1.0)}},0.006) end
do local a=np.transpose(np.array({{4,0,0}},"uint8")); local w=np.array({np.complex(-2.0,2.0)},"complex64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.transpose(np.array({{{false,true,false},{true,true,false}},{{true,true,true},{true,true,false}}},"bool")); local w=np.array({{{1,-1},{0,1}},{{3,0},{0,0}},{{1,2},{-1,3}}},"int32");local v=np.average(a,{axis={1,2,3},weights=w});eq(v,0.5555555555555556,0.006) end
do local a=np.array({{0,2,1},{1,0,1}},"int64"); local w=np.array({{0,0,0},{1,0,-1}},"int32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{-3,-3,-3}},"int8"); local w=np.array({{np.complex(3.0,2.0),np.complex(3.0,2.0),np.complex(2.0,2.0)}},"complex64");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{{np.complex(-3.0,0.0),np.complex(-3.0,0.0),np.complex(-3.0,0.0)}},2e-06) end
do local a=np.flip(np.array({{1,4,1},{4,1,2}},"int8"),2); local w=np.array(3,"int64");assert(not pcall(function() np.average(a,{axis=1,returned=true,weights=w}) end)) end
do local a=np.flip(np.array({{{2,-3,2},{0,0,4}},{{1,0,0},{-3,2,2}}},"int64"),3); local w=np.array({{{np.complex(3.0,0.0),np.complex(3.0,2.0),np.complex(-1.0,2.0)},{np.complex(3.0,0.0),np.complex(-2.0,0.0),np.complex(-2.0,0.0)}},{{np.complex(1.0,0.0),np.complex(-2.0,0.0),np.complex(3.0,0.0)},{np.complex(3.0,2.0),np.complex(3.0,2.0),np.complex(2.0,2.0)}}},"complex128");local v=np.average(a,{axis={},keepdims=true,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{{{np.complex(2.0,0.0),np.complex(-3.0,0.0),np.complex(2.0,0.0)},{np.complex(4.0,0.0),np.complex(-0.0,-0.0),np.complex(-0.0,-0.0)}},{{np.complex(0.0,0.0),np.complex(-0.0,-0.0),np.complex(1.0,0.0)},{np.complex(2.0,0.0),np.complex(2.0,0.0),np.complex(-3.0,0.0)}}},2e-06) end
do local a=np.zeros({2,0},"uint8"); local v=np.average(a,{keepdims=true});assert(v.dtype=="float64")
eq(v:tolist(),{{(0/0)}},0.006) end
do local a=np.array({{1.0,4.0,0.0},{0.0,4.0,0.0}},"float16"); local w=np.array({np.complex(-1.0,0.0),np.complex(-1.0,0.0)},"complex128");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.zeros({0},"int32"),1); local v=np.average(a,{axis=1});eq(v,(0/0),0.006) end
do local a=np.array({{0.0,4.0,0.0},{0.0,0.0,0.0}},"float32"); local w=np.array(3,"int64");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.transpose(np.array({{4,-3},{1,2},{2,0}},"int64")); local v,sw=np.average(a,{keepdims=true,returned=true});assert(v.dtype=="float64")
eq(v:tolist(),{{1.0}},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{{6.0}},0.006) end
do local a=np.array({0,0,4},"uint8"); local v,sw=np.average(a,{axis={},returned=true});assert(v.dtype=="float64")
eq(v:tolist(),{0.0,0.0,4.0},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{1.0,1.0,1.0},0.006) end
do local a=np.array({{0.0,2.0,-3.0}},"float64"); local w=np.array({-2,-2},"int32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.zeros({0,3},"uint8"),2); local v,sw=np.average(a,{axis=1,returned=true});assert(v.dtype=="float64")
eq(v:tolist(),{(0/0),(0/0),(0/0)},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{0.0,0.0,0.0},0.006) end
do local a=np.flip(np.array({np.complex(-3.0,0.0),np.complex(2.0,0.0),np.complex(0.0,0.0)},"complex64"),1); local w=np.array({np.complex(-1.0,2.0),np.complex(0.0,0.0),np.complex(3.0,0.0)},"complex128");local v=np.average(a,{keepdims=true,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{np.complex(-2.25,2.25)},2e-06) end
do local a=np.transpose(np.zeros({2,0},"float32")); local w=np.array(np.complex(-2.0,0.0),"complex64");assert(not pcall(function() np.average(a,{keepdims=true,returned=true,weights=w}) end)) end
do local a=np.array(-3.0,"float32"); local w=np.array(1.0,"float32");local v=np.average(a,{keepdims=true,weights=w});eq(v,-3.0,0.006) end
do local a=np.array({{2,-3,0}},"int64"); local w=np.array({np.complex(0.0,0.0),np.complex(1.0,0.0)},"complex64");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.flip(np.array({{0,4,1}},"int32"),2); local v=np.average(a,{axis={1,2}});eq(v,1.6666666666666667,0.006) end
do local a=np.flip(np.array({{0}},"int8"),2); local v=np.average(a);eq(v,0.0,0.006) end
do local a=np.flip(np.array({{1},{0}},"int64"),2); local w=np.array({{-1.0},{3.0}},"float64");local v=np.average(a,{axis=2,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{1.0,0.0},0.006) end
do local a=np.zeros({0},"float64"); local w=np.zeros({0},"complex128");assert(not pcall(function() np.average(a,{axis=1,weights=w}) end)) end
do local a=np.array({{true,false},{true,false},{false,true}},"bool"); local w=np.array({{3.0,0.0},{1.0,2.0},{-2.0,2.0}},"float32");local v=np.average(a,{keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{1.0}},0.006) end
do local a=np.transpose(np.array({{4,1,0}},"int64")); local w=np.array({{true},{true},{true}},"bool");local v=np.average(a,{axis={1,2},weights=w});eq(v,1.6666666666666667,0.006) end
do local a=np.flip(np.array({-3,-3,2},"int8"),1); local w=np.array(np.complex(-2.0,2.0),"complex128");assert(not pcall(function() np.average(a,{axis={1},keepdims=true,weights=w}) end)) end
do local a=np.transpose(np.zeros({0,3},"int32")); local w=np.zeros({3,0},"uint8");assert(not pcall(function() np.average(a,{keepdims=true,returned=true,weights=w}) end)) end
do local a=np.array({{np.complex(1.0,0.0)},{np.complex(4.0,0.0)}},"complex128"); local w=np.array({true,true,true},"bool");assert(not pcall(function() np.average(a,{keepdims=true,returned=true,weights=w}) end)) end
do local a=np.zeros({0,3},"float32"); local w=np.zeros({0,3},"float16");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({{4,2,4}},"uint8"),2); local w=np.array({{-2,2,1}},"int64");local v,sw=np.average(a,{axis=2,returned=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{0.0},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{1.0},0.006) end
do local a=np.array(-3,"int64"); local w=np.array({np.complex(2.0,0.0)},"complex128");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.flip(np.zeros({0,3},"int32"),2); local w=np.zeros({0,3},"int64");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.array({{4.0},{4.0}},"float32"); local v=np.average(a,{axis={1,2}});eq(v,4.0,0.006) end
do local a=np.flip(np.zeros({0},"uint8"),1); local w=np.zeros({0},"int32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{2,-3,0},{4,-3,0}},"int32"); local w=np.array({-2,-1,2},"int32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({{0,2},{1,2},{4,-3}},"int32"),2); local w=np.array({-1.0},"float16");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({2},"int32"); local w=np.array({2.0},"float32");local v,sw=np.average(a,{returned=true,weights=w});eq(v,2.0,0.006);eq(sw,2.0,0.006) end
do local a=np.array({4.0,-3.0},"float64"); local w=np.array({1,0,-2},"int8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array(0,"int8"); local w=np.array(true,"bool");local v=np.average(a,{weights=w});eq(v,0.0,0.006) end
do local a=np.array({{1,2},{4,1},{2,2}},"int64"); local w=np.array({{true,true},{true,true},{true,true}},"bool");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{1.0,2.0},{4.0,1.0},{2.0,2.0}},0.006) end
do local a=np.array({{np.complex(1.0,0.0)},{np.complex(4.0,2.0)}},"complex128"); local w=np.array(np.complex(-2.0,0.0),"complex128");local v=np.average(a,{axis={},keepdims=true,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{{np.complex(1.0,-0.0)},{np.complex(4.0,2.0)}},2e-06) end
do local a=np.transpose(np.array({{4,1},{4,0},{1,2}},"uint8")); local v=np.average(a,{keepdims=true});assert(v.dtype=="float64")
eq(v:tolist(),{{2.0}},0.006) end
do local a=np.array(4.0,"float16"); local w=np.array({3,1},"int8");assert(not pcall(function() np.average(a,{axis={},returned=true,weights=w}) end)) end
do local a=np.flip(np.zeros({0},"uint8"),1); local v=np.average(a);eq(v,(0/0),0.006) end
do local a=np.array({np.complex(1.0,2.0)},"complex128"); local v=np.average(a,{axis=1});eq(v,np.complex(1.0,2.0),2e-06) end
do local a=np.array({{2,4,0}},"uint8"); local w=np.array({2,2},"uint8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.transpose(np.array({{0.0}},"float16")); local w=np.array({1.0,-1.0},"float64");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.transpose(np.zeros({2,0},"float64")); local v=np.average(a,{axis=1});assert(v.dtype=="float64")
eq(v:tolist(),{(0/0),(0/0)},0.006) end
do local a=np.flip(np.array({{0,2,2}},"int8"),2); local w=np.array(3.0,"float32");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.array({4},"uint8"); local w=np.array({-1.0},"float64");local v=np.average(a,{axis={1},weights=w});eq(v,4.0,0.006) end
do local a=np.zeros({0},"complex128"); local v=np.average(a,{axis={1},keepdims=true});assert(v.dtype=="complex128")
eq(v:tolist(),{np.complex((0/0),(0/0))},2e-06) end
do local a=np.flip(np.array({{np.complex(0.0,0.0)},{np.complex(0.0,2.0)}},"complex64"),2); local v=np.average(a);eq(v,np.complex(0.0,1.0),0.006) end
do local a=np.array(-3,"int64"); local w=np.array(2.0,"float32");local v=np.average(a,{axis={},weights=w});eq(v,-3.0,0.006) end
do local a=np.flip(np.zeros({2,0},"int8"),2); local w=np.array({2},"uint8");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.array({np.complex(1.0,0.0)},"complex64"); local v,sw=np.average(a,{axis={1},returned=true});eq(v,np.complex(1.0,0.0),0.006);eq(sw,np.complex(1.0,0.0),0.006) end
do local a=np.array({{np.complex(0.0,2.0)}},"complex128"); local v=np.average(a);eq(v,np.complex(0.0,2.0),2e-06) end
do local a=np.zeros({0},"complex64"); local w=np.zeros({0},"int32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({{{2,4,0},{0,4,2}},{{-3,1,0},{1,1,1}}},"int32"),3); local v=np.average(a,{axis={}});assert(v.dtype=="float64")
eq(v:tolist(),{{{0.0,4.0,2.0},{2.0,4.0,0.0}},{{0.0,1.0,-3.0},{1.0,1.0,1.0}}},0.006) end
do local a=np.transpose(np.array({{{1,-3,0},{0,2,-3}},{{0,4,4},{0,1,0}}},"int8")); local v=np.average(a);eq(v,0.5,0.006) end
do local a=np.array({{np.complex(0.0,2.0),np.complex(-3.0,0.0),np.complex(0.0,0.0)}},"complex128"); local v=np.average(a,{axis=2});assert(v.dtype=="complex128")
eq(v:tolist(),{np.complex(-1.0,0.6666666666666666)},2e-06) end
do local a=np.array({{-3}},"int32"); local w=np.array({{0}},"int64");assert(not pcall(function() np.average(a,{axis={},keepdims=true,returned=true,weights=w}) end)) end
do local a=np.zeros({0,3},"bool"); local w=np.array({2,2,2},"uint8");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.array({{1,0,0},{0,4,2}},"int64"); local w=np.array({1.0,1.0,-1.0},"float16");assert(not pcall(function() np.average(a,{axis={1,2},returned=true,weights=w}) end)) end
do local a=np.array({true,true},"bool"); local w=np.array({np.complex(0.0,2.0),np.complex(0.0,2.0),np.complex(3.0,2.0)},"complex128");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{-3.0,4.0,4.0},{0.0,2.0,0.0}},"float64"); local v=np.average(a);eq(v,1.1666666666666667,0.006) end
do local a=np.array({{2,-3,0},{-3,4,1}},"int64"); local w=np.array({{2.0,0.0,3.0},{3.0,0.0,3.0}},"float64");local v=np.average(a,{axis={1,2},keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{-0.18181818181818182}},0.006) end
do local a=np.flip(np.array({{-3},{2}},"int32"),2); local w=np.array({{-2.0},{2.0}},"float64");assert(not pcall(function() np.average(a,{axis={1,2},returned=true,weights=w}) end)) end
do local a=np.flip(np.array({{4.0,0.0,4.0},{0.0,2.0,4.0}},"float16"),2); local w=np.array({{-1.0,2.0,3.0},{0.0,0.0,0.0}},"float64");assert(not pcall(function() np.average(a,{axis=2,weights=w}) end)) end
do local a=np.flip(np.array({{-3.0,4.0,0.0},{0.0,1.0,-3.0}},"float32"),2); local w=np.array({3.0,0.0},"float64");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.array({0.0,0.0,0.0},"float32"); local w=np.array({np.complex(-2.0,0.0),np.complex(2.0,2.0),np.complex(-1.0,0.0)},"complex64");local v=np.average(a,{weights=w});eq(v,np.complex(0.0,-0.0),0.006) end
do local a=np.array({{1.0,1.0,0.0}},"float16"); local w=np.array({-2.0},"float16");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{4.0,2.0,0.0},{-3.0,1.0,0.0}},"float64"); local w=np.array({0,-2,0},"int64");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.zeros({0},"int32"); local v,sw=np.average(a,{axis=1,returned=true});eq(v,(0/0),0.006);eq(sw,0.0,0.006) end
do local a=np.flip(np.array({{{0,2,-3},{0,0,-3}},{{2,-3,1},{4,0,0}}},"int64"),3); local w=np.array({-1.0,2.0,-1.0},"float32");assert(not pcall(function() np.average(a,{axis={1,2,3},returned=true,weights=w}) end)) end
do local a=np.zeros({0,3},"int32"); local w=np.array({0,2,-1},"int64");local v=np.average(a,{axis=2,keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{},0.006) end
do local a=np.array(1,"int8"); local w=np.array(2.0,"float16");local v=np.average(a,{weights=w});eq(v,1.0,0.006) end
do local a=np.array({np.complex(2.0,0.0),np.complex(1.0,0.0),np.complex(4.0,0.0)},"complex128"); local w=np.array({1.0},"float16");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.transpose(np.array({{np.complex(-3.0,2.0),np.complex(2.0,0.0),np.complex(1.0,0.0)},{np.complex(-3.0,0.0),np.complex(2.0,0.0),np.complex(0.0,0.0)}},"complex64")); local w=np.array({{np.complex(1.0,2.0),np.complex(2.0,0.0)},{np.complex(2.0,0.0),np.complex(-2.0,0.0)},{np.complex(-2.0,2.0),np.complex(0.0,0.0)}},"complex64");assert(not pcall(function() np.average(a,{axis=1,returned=true,weights=w}) end)) end
do local a=np.flip(np.array({{true,true},{true,true},{false,true}},"bool"),2); local w=np.array(0,"uint8");assert(not pcall(function() np.average(a,{keepdims=true,returned=true,weights=w}) end)) end
do local a=np.flip(np.array({4.0,0.0,0.0},"float32"),1); local w=np.array({2.0,1.0,-2.0,2.0},"float32");assert(not pcall(function() np.average(a,{axis={1},keepdims=true,weights=w}) end)) end
do local a=np.array({0.0,0.0,2.0},"float64"); local w=np.array({true,false,true},"bool");local v=np.average(a,{weights=w});eq(v,1.0,0.006) end
do local a=np.flip(np.array({0.0,1.0},"float16"),1); local v=np.average(a,{axis={1},keepdims=true});assert(v.dtype=="float16")
eq(v:tolist(),{0.5},0.006) end
do local a=np.zeros({0},"int32"); local w=np.zeros({0},"bool");assert(not pcall(function() np.average(a,{axis=1,weights=w}) end)) end
do local a=np.array(np.complex(1.0,0.0),"complex128"); local w=np.array({true},"bool");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.zeros({0,3},"uint8"); local w=np.array({np.complex(3.0,0.0)},"complex64");assert(not pcall(function() np.average(a,{axis=2,weights=w}) end)) end
do local a=np.array({true},"bool"); local w=np.array({2,1},"int32");assert(not pcall(function() np.average(a,{axis=1,weights=w}) end)) end
do local a=np.zeros({0},"float32"); local w=np.zeros({0},"float32");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.flip(np.zeros({0},"bool"),1); local v=np.average(a);eq(v,(0/0),0.006) end
do local a=np.flip(np.zeros({2,0},"float16"),2); local w=np.array(1,"uint8");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.array({0,4},"int64"); local w=np.array({-1,3},"int32");local v,sw=np.average(a,{axis=1,returned=true,weights=w});eq(v,6.0,0.006);eq(sw,2.0,0.006) end
do local a=np.zeros({0,3},"int8"); local v=np.average(a,{keepdims=true});assert(v.dtype=="float64")
eq(v:tolist(),{{(0/0)}},0.006) end
do local a=np.flip(np.array({{2},{4}},"int32"),2); local w=np.array(np.complex(-1.0,2.0),"complex128");assert(not pcall(function() np.average(a,{axis=2,weights=w}) end)) end
do local a=np.flip(np.zeros({0},"uint8"),1); local w=np.zeros({0},"float32");assert(not pcall(function() np.average(a,{axis={1},keepdims=true,weights=w}) end)) end
do local a=np.transpose(np.zeros({2,0},"float64")); local v,sw=np.average(a,{keepdims=true,returned=true});assert(v.dtype=="float64")
eq(v:tolist(),{{(0/0)}},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{{0.0}},0.006) end
do local a=np.array({{np.complex(1.0,2.0),np.complex(2.0,0.0)},{np.complex(4.0,2.0),np.complex(0.0,0.0)},{np.complex(2.0,0.0),np.complex(2.0,0.0)}},"complex128"); local w=np.array({np.complex(2.0,0.0),np.complex(1.0,0.0),np.complex(-1.0,0.0),np.complex(2.0,0.0)},"complex64");assert(not pcall(function() np.average(a,{keepdims=true,returned=true,weights=w}) end)) end
do local a=np.transpose(np.array({{0,4},{4,1},{4,-3}},"int8")); local w=np.array(true,"bool");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array(1,"int32"); local w=np.array({np.complex(2.0,0.0),np.complex(2.0,0.0)},"complex128");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{{-3,-3,4},{2,0,1}},{{0,0,1},{1,4,2}}},"int8"); local w=np.array({3,2,3},"uint8");assert(not pcall(function() np.average(a,{axis={1,2,3},weights=w}) end)) end
do local a=np.transpose(np.array({{4.0}},"float16")); local v=np.average(a);eq(v,4.0,0.006) end
do local a=np.array({{2}},"uint8"); local w=np.array({{np.complex(0.0,0.0)}},"complex128");assert(not pcall(function() np.average(a,{axis=2,weights=w}) end)) end
do local a=np.flip(np.array({{true,false},{true,true},{true,false}},"bool"),2); local v=np.average(a);eq(v,0.6666666666666666,0.006) end
do local a=np.zeros({0},"complex64"); local w=np.array(0,"uint8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({4.0,2.0,2.0},"float16"),1); local v=np.average(a);eq(v,2.666015625,0.006) end
do local a=np.zeros({0},"int32"); local w=np.array({np.complex(-2.0,0.0)},"complex128");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.array({{true,true,false},{true,true,true}},"bool"); local w=np.array({np.complex(1.0,0.0),np.complex(1.0,2.0),np.complex(2.0,0.0)},"complex128");assert(not pcall(function() np.average(a,{axis={},returned=true,weights=w}) end)) end
do local a=np.array({{2,2,4},{1,1,0}},"uint8"); local w=np.array({1},"int8");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.zeros({0},"float64"); local w=np.array({3.0,-1.0,1.0},"float64");assert(not pcall(function() np.average(a,{axis={1},weights=w}) end)) end
do local a=np.flip(np.array({0.0,0.0},"float32"),1); local w=np.array(np.complex(3.0,0.0),"complex128");assert(not pcall(function() np.average(a,{axis={1},returned=true,weights=w}) end)) end
do local a=np.array(1,"int8"); local w=np.array(np.complex(3.0,0.0),"complex64");local v=np.average(a,{axis={},keepdims=true,weights=w});eq(v,np.complex(1.0,0.0),2e-06) end
do local a=np.array({{0.0,4.0,1.0}},"float32"); local w=np.array({{-2,1,-2}},"int64");local v=np.average(a,{axis={1,2},keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{-0.6666666666666666}},0.006) end
do local a=np.array(0,"uint8"); local v=np.average(a);eq(v,0.0,0.006) end
do local a=np.transpose(np.array({{1.0},{0.0}},"float16")); local v,sw=np.average(a,{axis={},returned=true});assert(v.dtype=="float16")
eq(v:tolist(),{{1.0,0.0}},0.006);assert(sw.dtype=="float16")
eq(sw:tolist(),{{1.0,1.0}},0.006) end
do local a=np.array({{0}},"int8"); local w=np.array({{0.0}},"float32");assert(not pcall(function() np.average(a,{axis={1,2},keepdims=true,weights=w}) end)) end
do local a=np.array({2,4,-3},"int64"); local v=np.average(a,{axis={1}});eq(v,1.0,0.006) end
do local a=np.transpose(np.zeros({2,0},"uint8")); local w=np.array(2,"uint8");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{},0.006) end
do local a=np.zeros({2,0},"float64"); local w=np.zeros({2,0},"float32");assert(not pcall(function() np.average(a,{axis=2,weights=w}) end)) end
do local a=np.zeros({0},"uint8"); local w=np.zeros({0},"float16");assert(not pcall(function() np.average(a,{axis={1},weights=w}) end)) end
do local a=np.transpose(np.array({{false},{false}},"bool")); local w=np.array({1,-2,0},"int64");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.array({{np.complex(2.0,0.0),np.complex(1.0,2.0)},{np.complex(4.0,0.0),np.complex(-3.0,0.0)},{np.complex(2.0,2.0),np.complex(1.0,0.0)}},"complex128"); local w=np.array(2.0,"float32");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.array({2,0,2},"int32"); local w=np.array({2.0},"float16");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{np.complex(2.0,0.0),np.complex(2.0,2.0)},{np.complex(4.0,0.0),np.complex(4.0,2.0)},{np.complex(2.0,0.0),np.complex(0.0,0.0)}},"complex128"); local w=np.array({2.0,0.0,-1.0},"float16");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.zeros({2,0},"bool"); local w=np.array(3,"int32");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{},{}},0.006) end
do local a=np.zeros({0},"float32"); local w=np.zeros({0},"float16");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.array({{0.0}},"float32"); local v=np.average(a,{axis={1,2},keepdims=true});assert(v.dtype=="float32")
eq(v:tolist(),{{0.0}},0.006) end
do local a=np.array(np.complex(0.0,0.0),"complex128"); local w=np.array(false,"bool");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.array({2.0},"float16"); local w=np.array(false,"bool");assert(not pcall(function() np.average(a,{axis=1,weights=w}) end)) end
do local a=np.array({{1,1,0}},"int64"); local w=np.array({{np.complex(-2.0,0.0),np.complex(3.0,0.0),np.complex(1.0,0.0)}},"complex128");local v=np.average(a,{weights=w});eq(v,np.complex(0.5,0.0),2e-06) end
do local a=np.array({{np.complex(1.0,0.0),np.complex(0.0,0.0)},{np.complex(2.0,0.0),np.complex(-3.0,2.0)},{np.complex(-3.0,0.0),np.complex(1.0,0.0)}},"complex128"); local w=np.array({-2.0},"float32");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.zeros({0},"float64"); local w=np.array(3,"int32");assert(not pcall(function() np.average(a,{axis={1},weights=w}) end)) end
do local a=np.array(0,"uint8"); local w=np.array(-1.0,"float64");local v=np.average(a,{weights=w});eq(v,-0.0,0.006) end
do local a=np.array({false},"bool"); local w=np.array({0.0},"float16");assert(not pcall(function() np.average(a,{axis={},returned=true,weights=w}) end)) end
do local a=np.array({2},"int32"); local v=np.average(a,{axis=1});eq(v,2.0,0.006) end
do local a=np.array({{{0.0,4.0,4.0},{4.0,-3.0,0.0}},{{-3.0,0.0,4.0},{4.0,-3.0,1.0}}},"float32"); local w=np.array({2,1},"uint8");local v=np.average(a,{axis=2,weights=w});assert(v.dtype=="float32")
eq(v:tolist(),{{1.3333333730697632,1.6666666269302368,2.6666667461395264},{-0.6666666865348816,-1.0,3.0}},0.006) end
do local a=np.flip(np.zeros({0,3},"complex128"),2); local w=np.array(-1,"int8");assert(not pcall(function() np.average(a,{keepdims=true,returned=true,weights=w}) end)) end
do local a=np.array({1,4},"int32"); local v=np.average(a,{keepdims=true});assert(v.dtype=="float64")
eq(v:tolist(),{2.5},0.006) end
do local a=np.flip(np.array({{np.complex(-3.0,0.0),np.complex(-3.0,0.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex(-3.0,0.0),np.complex(1.0,2.0)}},"complex64"),2); local v,sw=np.average(a,{axis={1,2},keepdims=true,returned=true});assert(v.dtype=="complex64")
eq(v:tolist(),{{np.complex(-1.3333333730697632,0.3333333432674408)}},0.006);assert(sw.dtype=="complex64")
eq(sw:tolist(),{{np.complex(6.0,0.0)}},0.006) end
do local a=np.flip(np.array({false,false,true},"bool"),1); local w=np.array({0.0,0.0,0.0},"float64");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.array({4},"int64"); local w=np.array({np.complex(-1.0,0.0),np.complex(3.0,0.0)},"complex64");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.array({{0.0,1.0,0.0}},"float16"); local w=np.array({{np.complex(-2.0,0.0),np.complex(1.0,2.0),np.complex(1.0,0.0)}},"complex128");local v=np.average(a,{axis={},keepdims=true,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{{np.complex(-0.0,-0.0),np.complex(1.0,0.0),np.complex(0.0,0.0)}},2e-06) end
do local a=np.zeros({0},"bool"); local v=np.average(a);eq(v,(0/0),0.006) end
do local a=np.array({2},"uint8"); local w=np.array({0.0},"float16");assert(not pcall(function() np.average(a,{axis=1,keepdims=true,returned=true,weights=w}) end)) end
do local a=np.zeros({0,3},"int32"); local w=np.zeros({0,3},"int8");local v=np.average(a,{axis=2,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{},0.006) end
do local a=np.transpose(np.zeros({0,3},"complex128")); local w=np.array({3,2,2},"uint8");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.array({{np.complex(1.0,2.0)},{np.complex(-3.0,0.0)}},"complex64"); local w=np.array({3,3,1},"int64");assert(not pcall(function() np.average(a,{axis=2,weights=w}) end)) end
do local a=np.flip(np.array({np.complex(2.0,2.0)},"complex64"),1); local w=np.array({3.0,1.0},"float64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({0.0,2.0},"float16"); local w=np.array({3,-2},"int8");local v=np.average(a,{axis=1,weights=w});eq(v,-4.0,0.006) end
do local a=np.array({np.complex(0.0,2.0),np.complex(4.0,0.0),np.complex(0.0,0.0)},"complex128"); local w=np.array({-2.0},"float64");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.transpose(np.zeros({2,0},"float32")); local w=np.array({np.complex(0.0,0.0)},"complex64");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.transpose(np.array({{false,true,true},{true,true,false}},"bool")); local v,sw=np.average(a,{keepdims=true,returned=true});assert(v.dtype=="float64")
eq(v:tolist(),{{0.6666666666666666}},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{{6.0}},0.006) end
do local a=np.array({{{np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(4.0,0.0)},{np.complex(4.0,2.0),np.complex(4.0,2.0),np.complex(1.0,0.0)}},{{np.complex(0.0,0.0),np.complex(-3.0,0.0),np.complex(-3.0,0.0)},{np.complex(4.0,2.0),np.complex(1.0,2.0),np.complex(2.0,0.0)}}},"complex64"); local v=np.average(a,{axis=1});assert(v.dtype=="complex64")
eq(v:tolist(),{{np.complex(0.5,0.0),np.complex(-0.5,0.0),np.complex(0.5,0.0)},{np.complex(4.0,2.0),np.complex(2.5,2.0),np.complex(1.5,0.0)}},0.006) end
do local a=np.flip(np.array({{1.0}},"float32"),2); local w=np.array(0,"uint8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.transpose(np.zeros({2,0},"complex128")); local v=np.average(a,{axis=1});assert(v.dtype=="complex128")
eq(v:tolist(),{np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},2e-06) end
do local a=np.flip(np.zeros({0},"int8"),1); local v,sw=np.average(a,{axis={1},returned=true});eq(v,(0/0),0.006);eq(sw,0.0,0.006) end
do local a=np.array({{2}},"int32"); local w=np.array({{np.complex(2.0,2.0)}},"complex64");local v,sw=np.average(a,{keepdims=true,returned=true,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{{np.complex(2.0,0.0)}},2e-06);assert(sw.dtype=="complex128")
eq(sw:tolist(),{{np.complex(2.0,2.0)}},2e-06) end
do local a=np.zeros({2,0},"bool"); local w=np.array({0},"uint8");assert(not pcall(function() np.average(a,{axis={},returned=true,weights=w}) end)) end
do local a=np.array(np.complex(1.0,2.0),"complex128"); local w=np.array(np.complex(3.0,2.0),"complex64");local v=np.average(a,{axis={},keepdims=true,weights=w});eq(v,np.complex(1.0,2.0),2e-06) end
do local a=np.transpose(np.array({{{0,4,2},{0,-3,1}},{{0,2,0},{-3,1,-3}}},"int64")); local w=np.array({1.0,3.0,-2.0,0.0},"float32");assert(not pcall(function() np.average(a,{axis={1,2,3},weights=w}) end)) end
do local a=np.array({{4.0}},"float16"); local w=np.array(np.complex(0.0,2.0),"complex64");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.transpose(np.array({{-3.0,0.0,0.0}},"float32")); local v,sw=np.average(a,{axis={1,2},returned=true});eq(v,-1.0,0.006);eq(sw,3.0,0.006) end
do local a=np.array({true},"bool"); local w=np.array({2},"int8");local v=np.average(a,{axis={},keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{1.0},0.006) end
do local a=np.array({0.0,0.0},"float32"); local w=np.array({-1,0},"int32");assert(not pcall(function() np.average(a,{axis={},keepdims=true,returned=true,weights=w}) end)) end
do local a=np.array({{-3.0},{-3.0}},"float32"); local w=np.array({{3},{3}},"int32");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{-3.0},{-3.0}},0.006) end
do local a=np.transpose(np.array({{2}},"uint8")); local w=np.array({0.0},"float64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({np.complex(0.0,0.0)},"complex128"),1); local w=np.array({3.0},"float32");local v=np.average(a,{weights=w});eq(v,np.complex(0.0,0.0),2e-06) end
do local a=np.array({2.0},"float16"); local w=np.array({2,1,0},"uint8");assert(not pcall(function() np.average(a,{axis={1},weights=w}) end)) end
do local a=np.array({{2}},"int32"); local w=np.array({0.0,2.0},"float64");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.flip(np.array({{np.complex(4.0,2.0),np.complex(4.0,0.0),np.complex(1.0,0.0)},{np.complex(-3.0,0.0),np.complex(0.0,0.0),np.complex(-3.0,2.0)}},"complex128"),2); local w=np.array({{3.0,0.0,-2.0},{1.0,-2.0,1.0}},"float32");local v=np.average(a,{axis={1,2},weights=w});eq(v,np.complex(-11.0,-2.0),2e-06) end
do local a=np.array({{2.0},{0.0}},"float16"); local w=np.array({{-2.0},{1.0}},"float64");local v=np.average(a,{weights=w});eq(v,4.0,0.006) end
do local a=np.flip(np.array({0},"uint8"),1); local v=np.average(a,{axis={1}});eq(v,0.0,0.006) end
do local a=np.array({{2,-3,4}},"int64"); local v=np.average(a);eq(v,1.0,0.006) end
do local a=np.array({{2.0},{-3.0}},"float16"); local w=np.array({np.complex(1.0,0.0),np.complex(0.0,2.0)},"complex64");local v,sw=np.average(a,{axis=1,returned=true,weights=w});assert(v.dtype=="complex64")
eq(v:tolist(),{np.complex(-2.0,-2.0)},0.006);assert(sw.dtype=="complex64")
eq(sw:tolist(),{np.complex(1.0,2.0)},0.006) end
do local a=np.transpose(np.zeros({0,3},"bool")); local w=np.array(-1,"int32");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{},{},{}},0.006) end
do local a=np.flip(np.array({{{np.complex(-3.0,0.0),np.complex(4.0,0.0),np.complex(0.0,2.0)},{np.complex(4.0,2.0),np.complex(1.0,2.0),np.complex(-3.0,0.0)}},{{np.complex(4.0,2.0),np.complex(0.0,0.0),np.complex(2.0,2.0)},{np.complex(2.0,0.0),np.complex(-3.0,0.0),np.complex(4.0,0.0)}}},"complex64"),3); local w=np.array({np.complex(0.0,2.0),np.complex(0.0,0.0)},"complex128");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({np.complex(-3.0,0.0)},"complex64"); local w=np.array({1.0,-1.0},"float64");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.zeros({0},"complex64"); local w=np.zeros({0},"int32");assert(not pcall(function() np.average(a,{axis={1},returned=true,weights=w}) end)) end
do local a=np.flip(np.array({{0.0,1.0},{4.0,2.0},{4.0,0.0}},"float64"),2); local w=np.array({-2.0},"float16");assert(not pcall(function() np.average(a,{axis={1,2},keepdims=true,weights=w}) end)) end
do local a=np.array({{1}},"int32"); local w=np.array({{1}},"uint8");local v=np.average(a,{weights=w});eq(v,1.0,0.006) end
do local a=np.flip(np.array({{2,0,0},{1,0,0}},"int32"),2); local w=np.array({{0,2,-2},{-1,-2,0}},"int32");local v=np.average(a,{weights=w});eq(v,1.3333333333333333,0.006) end
do local a=np.flip(np.zeros({2,0},"float64"),2); local w=np.zeros({2,0},"float32");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.flip(np.zeros({2,0},"complex128"),2); assert(not pcall(function() np.average(a,{axis={},keepdims=true}) end)) end
do local a=np.zeros({0,3},"float64"); local w=np.zeros({0},"bool");assert(not pcall(function() np.average(a,{axis=1,weights=w}) end)) end
do local a=np.flip(np.array({{{4.0,-3.0,1.0},{4.0,0.0,0.0}},{{2.0,4.0,0.0},{1.0,0.0,4.0}}},"float32"),3); local w=np.array(true,"bool");assert(not pcall(function() np.average(a,{axis={1,2,3},weights=w}) end)) end
do local a=np.array({{0.0,2.0,0.0},{4.0,2.0,4.0}},"float32"); local w=np.array(0,"int32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.zeros({2,0},"int64"); local w=np.array(0,"int32");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.array({2},"int32"); local w=np.array(0,"int64");assert(not pcall(function() np.average(a,{axis={1},weights=w}) end)) end
do local a=np.array({{{0.0,0.0,0.0},{0.0,4.0,2.0}},{{0.0,0.0,2.0},{-3.0,0.0,2.0}}},"float16"); local w=np.array({{{-2.0,2.0,2.0},{3.0,1.0,0.0}},{{-1.0,-2.0,2.0},{3.0,0.0,2.0}}},"float64");local v=np.average(a,{axis=3,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{0.0,1.0},{-4.0,-1.0}},0.006) end
do local a=np.array({false,true,true},"bool"); local w=np.array({2,-1,-2},"int8");local v=np.average(a,{weights=w});eq(v,3.0,0.006) end
do local a=np.flip(np.zeros({0,3},"int64"),2); local w=np.zeros({0,3},"uint8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.transpose(np.array({{0},{0}},"int64")); local v,sw=np.average(a,{axis=1,keepdims=true,returned=true});assert(v.dtype=="float64")
eq(v:tolist(),{{0.0,0.0}},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{{1.0,1.0}},0.006) end
do local a=np.zeros({0,3},"int8"); local v,sw=np.average(a,{returned=true});eq(v,(0/0),0.006);eq(sw,0.0,0.006) end
do local a=np.array({{1.0,0.0},{4.0,-3.0},{0.0,0.0}},"float64"); local w=np.array({{np.complex(2.0,0.0),np.complex(2.0,0.0)},{np.complex(1.0,0.0),np.complex(-2.0,0.0)},{np.complex(1.0,0.0),np.complex(-2.0,0.0)}},"complex128");local v,sw=np.average(a,{axis=1,keepdims=true,returned=true,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{{np.complex(1.5,0.0),np.complex(-3.0,-0.0)}},2e-06);assert(sw.dtype=="complex128")
eq(sw:tolist(),{{np.complex(4.0,0.0),np.complex(-2.0,0.0)}},2e-06) end
do local a=np.flip(np.array({{4,-3,1}},"int8"),2); local w=np.array({true},"bool");local v,sw=np.average(a,{axis=1,returned=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{1.0,-3.0,4.0},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{1.0,1.0,1.0},0.006) end
do local a=np.flip(np.array({{np.complex(4.0,2.0)}},"complex64"),2); local v=np.average(a);eq(v,np.complex(4.0,2.0),0.006) end
do local a=np.flip(np.array({1,2},"uint8"),1); local v,sw=np.average(a,{axis={1},returned=true});eq(v,1.5,0.006);eq(sw,2.0,0.006) end
do local a=np.array({4.0,0.0},"float16"); local w=np.array({np.complex(3.0,2.0),np.complex(2.0,0.0),np.complex(-1.0,0.0)},"complex128");assert(not pcall(function() np.average(a,{axis={1},weights=w}) end)) end
do local a=np.array({{-3,4},{-3,4},{0,-3}},"int32"); local w=np.array({{2,1},{1,2},{1,3}},"uint8");local v,sw=np.average(a,{returned=true,weights=w});eq(v,-0.6,0.006);eq(sw,10.0,0.006) end
do local a=np.array({{0,4,0},{0,4,0}},"int64"); local w=np.array({np.complex(2.0,2.0),np.complex(0.0,2.0),np.complex(-1.0,0.0)},"complex128");local v=np.average(a,{axis=2,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{np.complex(1.8823529411764706,0.47058823529411764),np.complex(1.8823529411764706,0.47058823529411764)},2e-06) end
do local a=np.array({0,1},"int64"); local w=np.array({2,3},"int64");local v=np.average(a,{axis={},keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{0.0,1.0},0.006) end
do local a=np.transpose(np.zeros({2,0},"complex128")); local v=np.average(a,{keepdims=true});assert(v.dtype=="complex128")
eq(v:tolist(),{{np.complex((0/0),(0/0))}},2e-06) end
do local a=np.flip(np.zeros({0},"bool"),1); local w=np.array({1},"uint8");assert(not pcall(function() np.average(a,{axis=1,weights=w}) end)) end
do local a=np.array({{1.0}},"float64"); local w=np.array({{np.complex(-1.0,0.0)}},"complex64");local v=np.average(a,{axis={1,2},weights=w});eq(v,np.complex(1.0,-0.0),2e-06) end
do local a=np.array({{np.complex(2.0,0.0)},{np.complex(1.0,0.0)}},"complex128"); local w=np.array({{1},{1}},"uint8");local v,sw=np.average(a,{axis={},keepdims=true,returned=true,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{{np.complex(2.0,0.0)},{np.complex(1.0,0.0)}},2e-06);assert(sw.dtype=="complex128")
eq(sw:tolist(),{{np.complex(1.0,0.0)},{np.complex(1.0,0.0)}},2e-06) end
do local a=np.zeros({0},"int8"); local v=np.average(a,{axis=1});eq(v,(0/0),0.006) end
do local a=np.zeros({0},"bool"); local v=np.average(a);eq(v,(0/0),0.006) end
do local a=np.array({0.0,1.0,1.0},"float32"); local v=np.average(a,{axis=1});eq(v,0.6666666865348816,0.006) end
do local a=np.flip(np.zeros({0},"float16"),1); local w=np.array({1},"uint8");assert(not pcall(function() np.average(a,{axis={1},weights=w}) end)) end
do local a=np.zeros({2,0},"int32"); local w=np.array({np.complex(2.0,0.0),np.complex(0.0,2.0),np.complex(0.0,0.0)},"complex128");assert(not pcall(function() np.average(a,{axis={},keepdims=true,weights=w}) end)) end
do local a=np.array({{0.0,4.0,0.0}},"float16"); local w=np.array({1,-2},"int8");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.array({{true},{true}},"bool"); local w=np.array({{-2.0},{3.0}},"float64");local v=np.average(a,{weights=w});eq(v,1.0,0.006) end
do local a=np.zeros({0},"int32"); local w=np.array(1,"uint8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({0,0,0},"int32"); local w=np.array({-2,-1,-1},"int8");local v=np.average(a,{keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{-0.0},0.006) end
do local a=np.zeros({2,0},"int64"); assert(not pcall(function() np.average(a,{axis={},keepdims=true}) end)) end
do local a=np.array({-3},"int64"); local w=np.array(1,"int64");assert(not pcall(function() np.average(a,{axis={1},returned=true,weights=w}) end)) end
do local a=np.flip(np.array({{{np.complex(2.0,0.0),np.complex(0.0,0.0),np.complex(1.0,0.0)},{np.complex(0.0,0.0),np.complex(0.0,2.0),np.complex(0.0,0.0)}},{{np.complex(4.0,0.0),np.complex(0.0,2.0),np.complex(1.0,0.0)},{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0)}}},"complex64"),3); local v,sw=np.average(a,{axis={},returned=true});assert(v.dtype=="complex64")
eq(v:tolist(),{{{np.complex(1.0,0.0),np.complex(0.0,0.0),np.complex(2.0,0.0)},{np.complex(0.0,0.0),np.complex(0.0,2.0),np.complex(0.0,0.0)}},{{np.complex(1.0,0.0),np.complex(0.0,2.0),np.complex(4.0,0.0)},{np.complex(2.0,0.0),np.complex(1.0,0.0),np.complex(0.0,0.0)}}},0.006);assert(sw.dtype=="complex64")
eq(sw:tolist(),{{{np.complex(1.0,0.0),np.complex(1.0,0.0),np.complex(1.0,0.0)},{np.complex(1.0,0.0),np.complex(1.0,0.0),np.complex(1.0,0.0)}},{{np.complex(1.0,0.0),np.complex(1.0,0.0),np.complex(1.0,0.0)},{np.complex(1.0,0.0),np.complex(1.0,0.0),np.complex(1.0,0.0)}}},0.006) end
do local a=np.flip(np.zeros({2,0},"complex64"),2); local w=np.zeros({2,0},"int8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array(1,"int64"); local w=np.array(np.complex(-1.0,0.0),"complex128");local v=np.average(a,{axis={},keepdims=true,weights=w});eq(v,np.complex(1.0,-0.0),2e-06) end
do local a=np.transpose(np.zeros({2,0},"complex64")); assert(not pcall(function() np.average(a,{axis={}}) end)) end
do local a=np.flip(np.array({0.0},"float16"),1); local w=np.array({2,2},"int8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({{np.complex(0.0,0.0),np.complex(2.0,0.0),np.complex(4.0,2.0)}},"complex64"),2); local w=np.array({np.complex(2.0,0.0),np.complex(-1.0,2.0)},"complex64");assert(not pcall(function() np.average(a,{axis={1,2},keepdims=true,weights=w}) end)) end
do local a=np.transpose(np.array({{1},{0}},"uint8")); local w=np.array(-1.0,"float16");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.flip(np.array({{2}},"int32"),2); local w=np.array(np.complex(-2.0,2.0),"complex128");assert(not pcall(function() np.average(a,{axis=1,keepdims=true,returned=true,weights=w}) end)) end
do local a=np.array({{np.complex(-3.0,0.0),np.complex(4.0,0.0)},{np.complex(0.0,2.0),np.complex(2.0,2.0)},{np.complex(0.0,2.0),np.complex(-3.0,2.0)}},"complex128"); local w=np.array({{true,true},{false,true},{false,true}},"bool");local v=np.average(a,{weights=w});eq(v,np.complex(0.0,1.0),2e-06) end
do local a=np.array({{{1,0,-3},{2,2,4}},{{0,1,0},{-3,2,2}}},"int64"); local w=np.array({0},"int8");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.zeros({0},"float32"); local w=np.zeros({0},"uint8");local v,sw=np.average(a,{axis={},returned=true,weights=w});assert(v.dtype=="float32")
eq(v:tolist(),{},0.006);assert(sw.dtype=="float32")
eq(sw:tolist(),{},0.006) end
do local a=np.flip(np.zeros({0},"float64"),1); local w=np.array({2.0},"float16");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.zeros({2,0},"complex128"); local w=np.array(np.complex(1.0,0.0),"complex128");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.array({{4,2},{0,0},{4,4}},"int64"); local w=np.array({{1.0,0.0},{-2.0,0.0},{-1.0,1.0}},"float32");local v=np.average(a,{keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{-4.0}},0.006) end
do local a=np.transpose(np.array({{{np.complex(2.0,0.0),np.complex(0.0,2.0),np.complex(4.0,0.0)},{np.complex(0.0,2.0),np.complex(-3.0,0.0),np.complex(2.0,2.0)}},{{np.complex(-3.0,2.0),np.complex(1.0,0.0),np.complex(-3.0,0.0)},{np.complex(2.0,2.0),np.complex(2.0,2.0),np.complex(0.0,2.0)}}},"complex128")); local w=np.array({{{0.0,3.0},{0.0,-2.0}},{{2.0,1.0},{0.0,-2.0}},{{-1.0,1.0},{1.0,-1.0}}},"float16");assert(not pcall(function() np.average(a,{axis=2,weights=w}) end)) end
do local a=np.flip(np.array({{-3},{0}},"int64"),2); local w=np.array(1.0,"float16");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array(false,"bool"); local w=np.array(0,"uint8");assert(not pcall(function() np.average(a,{axis={},keepdims=true,returned=true,weights=w}) end)) end
do local a=np.array({2.0,1.0},"float16"); local w=np.array(np.complex(1.0,0.0),"complex128");assert(not pcall(function() np.average(a,{axis=1,keepdims=true,weights=w}) end)) end
do local a=np.array(0,"int32"); local w=np.array({np.complex(0.0,0.0),np.complex(-2.0,0.0),np.complex(0.0,0.0)},"complex128");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.transpose(np.array({{np.complex(4.0,0.0),np.complex(4.0,0.0)},{np.complex(2.0,0.0),np.complex(1.0,0.0)},{np.complex(4.0,0.0),np.complex(4.0,2.0)}},"complex64")); local w=np.array({{-1.0,-2.0,0.0},{0.0,2.0,0.0}},"float16");local v=np.average(a,{axis={1,2},weights=w});eq(v,np.complex(6.0,-0.0),0.006) end
do local a=np.array({{2},{0}},"int8"); local w=np.array({-1,3,-2},"int8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({np.complex(1.0,0.0)},"complex128"); local v,sw=np.average(a,{returned=true});eq(v,np.complex(1.0,0.0),2e-06);eq(sw,np.complex(1.0,0.0),2e-06) end
do local a=np.array({0.0,1.0,4.0},"float32"); local w=np.array({-1.0,-2.0,0.0},"float64");local v=np.average(a,{axis={1},weights=w});eq(v,0.6666666666666666,0.006) end
do local a=np.array({{1.0}},"float16"); local w=np.array(np.complex(-1.0,0.0),"complex128");assert(not pcall(function() np.average(a,{axis=1,weights=w}) end)) end
do local a=np.flip(np.array({{1,2,2}},"int8"),2); local w=np.array({-1},"int32");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.transpose(np.array({{0},{0}},"int32")); local w=np.array({-2.0,2.0},"float32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({{{1,0,4},{0,2,0}},{{-3,0,0},{4,-3,-3}}},"int8"),3); local v=np.average(a,{axis={}});assert(v.dtype=="float64")
eq(v:tolist(),{{{4.0,0.0,1.0},{0.0,2.0,0.0}},{{0.0,0.0,-3.0},{-3.0,-3.0,4.0}}},0.006) end
do local a=np.array(-3.0,"float16"); local w=np.array(1.0,"float16");local v=np.average(a,{keepdims=true,weights=w});eq(v,-3.0,0.006) end
do local a=np.array({1.0,4.0,0.0},"float16"); local w=np.array({2,0,2},"int64");local v=np.average(a,{axis=1,weights=w});eq(v,0.5,0.006) end
do local a=np.transpose(np.array({{0},{1}},"int32")); local v,sw=np.average(a,{returned=true});eq(v,0.5,0.006);eq(sw,2.0,0.006) end
do local a=np.transpose(np.array({{2}},"int64")); local v=np.average(a,{axis=1,keepdims=true});assert(v.dtype=="float64")
eq(v:tolist(),{{2.0}},0.006) end
do local a=np.flip(np.array({0.0},"float32"),1); local w=np.array({0},"int64");assert(not pcall(function() np.average(a,{axis={},returned=true,weights=w}) end)) end
do local a=np.transpose(np.array({{false,true,false}},"bool")); local w=np.array({{np.complex(-2.0,0.0)},{np.complex(3.0,0.0)},{np.complex(2.0,0.0)}},"complex128");local v=np.average(a,{axis=1,keepdims=true,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{{np.complex(1.0,0.0)}},2e-06) end
do local a=np.array({false,false,false},"bool"); local v,sw=np.average(a,{axis=1,returned=true});eq(v,0.0,0.006);eq(sw,3.0,0.006) end
do local a=np.array({{1}},"uint8"); local w=np.array({3},"int32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.zeros({0},"int8"); local w=np.zeros({0},"int32");assert(not pcall(function() np.average(a,{axis=1,keepdims=true,returned=true,weights=w}) end)) end
do local a=np.transpose(np.array({{4,4,-3},{4,-3,1}},"int32")); local w=np.array({{0.0,0.0},{1.0,-1.0},{1.0,0.0}},"float16");assert(not pcall(function() np.average(a,{axis=2,weights=w}) end)) end
do local a=np.zeros({2,0},"float16"); local w=np.zeros({2,0},"int64");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.array({{2},{4}},"int8"); local v,sw=np.average(a,{returned=true});eq(v,3.0,0.006);eq(sw,2.0,0.006) end
do local a=np.array(np.complex(-3.0,2.0),"complex64"); local w=np.array({0,3,0},"int8");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.zeros({0},"int8"); local w=np.array(3,"int8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{{1,2,4},{0,4,4}},{{1,0,0},{0,0,4}}},"uint8"); local w=np.array({-2.0,1.0},"float64");assert(not pcall(function() np.average(a,{axis={1,2,3},weights=w}) end)) end
do local a=np.array({{1.0},{4.0}},"float32"); local w=np.array({{1.0},{-2.0}},"float32");local v,sw=np.average(a,{returned=true,weights=w});eq(v,7.0,0.006);eq(sw,-1.0,0.006) end
do local a=np.array({0,1,4},"uint8"); local w=np.array({1,3,2},"uint8");local v=np.average(a,{axis=1,weights=w});eq(v,1.8333333333333333,0.006) end
do local a=np.zeros({0},"int8"); local w=np.array({true},"bool");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.array({{4.0,1.0,0.0},{0.0,4.0,0.0}},"float32"); local v=np.average(a,{axis={1,2},keepdims=true});assert(v.dtype=="float32")
eq(v:tolist(),{{1.5}},0.006) end
do local a=np.array({4},"int32"); local w=np.array({1},"uint8");local v=np.average(a,{axis={1},weights=w});eq(v,4.0,0.006) end
do local a=np.flip(np.array({{np.complex(0.0,0.0),np.complex(4.0,0.0),np.complex(0.0,0.0)}},"complex128"),2); local v=np.average(a);eq(v,np.complex(1.3333333333333333,0.0),2e-06) end
do local a=np.array({{1,1},{0,0},{0,0}},"int64"); local w=np.array({{np.complex(2.0,0.0),np.complex(-1.0,2.0)},{np.complex(3.0,0.0),np.complex(-1.0,0.0)},{np.complex(1.0,2.0),np.complex(0.0,0.0)}},"complex64");local v=np.average(a,{weights=w});eq(v,np.complex(0.375,0.125),2e-06) end
do local a=np.flip(np.array({{{1.0,0.0,0.0},{1.0,2.0,4.0}},{{-3.0,1.0,0.0},{2.0,2.0,4.0}}},"float16"),3); local w=np.array({2},"int32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.transpose(np.zeros({2,0},"bool")); local w=np.array(2,"int64");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.flip(np.array({0},"int64"),1); local w=np.array({2.0},"float32");local v,sw=np.average(a,{returned=true,weights=w});eq(v,0.0,0.006);eq(sw,2.0,0.006) end
do local a=np.array({-3.0},"float64"); local v=np.average(a,{axis=1});eq(v,-3.0,0.006) end
do local a=np.flip(np.array({{np.complex(0.0,0.0),np.complex(2.0,0.0)},{np.complex(-3.0,0.0),np.complex(1.0,2.0)},{np.complex(1.0,2.0),np.complex(0.0,0.0)}},"complex128"),2); local w=np.array({{-2.0,0.0},{2.0,1.0},{0.0,1.0}},"float16");local v=np.average(a,{axis={1,2},weights=w});eq(v,np.complex(-2.0,3.0),2e-06) end
do local a=np.array(-3.0,"float64"); local w=np.array(3,"int64");local v=np.average(a,{weights=w});eq(v,-3.0,0.006) end
do local a=np.flip(np.zeros({0,3},"uint8"),2); local w=np.zeros({0,3},"uint8");local v=np.average(a,{axis=2,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{},0.006) end
do local a=np.array({-3},"int8"); local w=np.array({3.0},"float64");local v=np.average(a,{axis={1},weights=w});eq(v,-3.0,0.006) end
do local a=np.zeros({0,3},"complex128"); local v=np.average(a,{axis=1});assert(v.dtype=="complex128")
eq(v:tolist(),{np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},2e-06) end
do local a=np.transpose(np.array({{{0,0,1},{0,2,-3}},{{1,0,-3},{0,1,4}}},"int64")); local w=np.array({{{true,true},{true,true}},{{false,false},{true,true}},{{true,true},{true,true}}},"bool");local v,sw=np.average(a,{keepdims=true,returned=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{{0.3}}},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{{{10.0}}},0.006) end
do local a=np.array(-3,"int64"); local w=np.array(0,"int32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.transpose(np.zeros({0,3},"complex128")); local w=np.zeros({3,0},"int64");local v,sw=np.average(a,{axis=1,returned=true,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{},2e-06);assert(sw.dtype=="complex128")
eq(sw:tolist(),{},2e-06) end
do local a=np.transpose(np.array({{{2.0,0.0,-3.0},{0.0,2.0,2.0}},{{2.0,0.0,4.0},{1.0,4.0,0.0}}},"float32")); local w=np.array(2,"int8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({{1.0,4.0},{4.0,-3.0},{2.0,0.0}},"float16"),2); local w=np.array({true,true},"bool");local v=np.average(a,{axis=2,weights=w});assert(v.dtype=="float16")
eq(v:tolist(),{2.5,0.5,1.0},0.006) end
do local a=np.flip(np.zeros({0},"bool"),1); local v,sw=np.average(a,{axis={1},returned=true});eq(v,(0/0),0.006);eq(sw,0.0,0.006) end
do local a=np.array(2,"uint8"); local w=np.array({2.0,3.0},"float32");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.zeros({0},"int8"); local v,sw=np.average(a,{axis={1},keepdims=true,returned=true});assert(v.dtype=="float64")
eq(v:tolist(),{(0/0)},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{0.0},0.006) end
do local a=np.array({0.0,0.0,0.0},"float32"); local v=np.average(a,{keepdims=true});assert(v.dtype=="float32")
eq(v:tolist(),{0.0},0.006) end
do local a=np.array({-3.0,1.0,0.0},"float16"); local w=np.array({np.complex(3.0,0.0),np.complex(-1.0,0.0),np.complex(-1.0,0.0),np.complex(1.0,0.0)},"complex64");assert(not pcall(function() np.average(a,{axis={},returned=true,weights=w}) end)) end
do local a=np.transpose(np.array({{np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex(-3.0,2.0),np.complex(0.0,2.0)},{np.complex(2.0,0.0),np.complex(-3.0,0.0)}},"complex128")); local w=np.array(3,"int64");local v=np.average(a,{axis={},keepdims=true,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{{np.complex(0.0,0.0),np.complex(-3.0,2.0),np.complex(2.0,0.0)},{np.complex(0.0,0.0),np.complex(0.0,2.0),np.complex(-3.0,0.0)}},2e-06) end
do local a=np.flip(np.array({{2,1,4},{0,1,1}},"int64"),2); local w=np.array({{2,1,2},{2,1,3}},"uint8");local v,sw=np.average(a,{axis={},returned=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{4.0,1.0,2.0},{1.0,1.0,0.0}},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{{2.0,1.0,2.0},{2.0,1.0,3.0}},0.006) end
do local a=np.zeros({0},"int64"); local w=np.zeros({0},"int32");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{},0.006) end
do local a=np.array({2,0},"uint8"); local w=np.array({true},"bool");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.flip(np.zeros({0,3},"int32"),2); local w=np.zeros({0,3},"float64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({np.complex(0.0,0.0)},"complex128"),1); local w=np.array({2.0,-1.0},"float16");assert(not pcall(function() np.average(a,{axis={1},keepdims=true,returned=true,weights=w}) end)) end
do local a=np.flip(np.array({{0.0},{4.0}},"float32"),2); local v=np.average(a,{keepdims=true});assert(v.dtype=="float32")
eq(v:tolist(),{{2.0}},0.006) end
do local a=np.array({{-3.0,1.0,1.0},{0.0,-3.0,-3.0}},"float32"); local w=np.array({{np.complex(-2.0,0.0),np.complex(3.0,2.0),np.complex(3.0,0.0)},{np.complex(3.0,2.0),np.complex(-2.0,0.0),np.complex(3.0,0.0)}},"complex64");local v=np.average(a,{weights=w});eq(v,np.complex(1.0,-0.25),0.006) end
do local a=np.transpose(np.array({{2.0},{2.0}},"float16")); local w=np.array(0,"int64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({{2.0,0.0,0.0},{0.0,1.0,2.0}},"float64"),2); local w=np.array(true,"bool");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{0,0},{2,2},{0,2}},"uint8"); local w=np.array(0,"int8");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.flip(np.array({{-3.0,4.0,4.0}},"float16"),2); local w=np.array({{-1,2,2}},"int64");local v=np.average(a,{axis={1,2},weights=w});eq(v,-0.6666666666666666,0.006) end
do local a=np.array({0},"int64"); local v=np.average(a,{axis=1});eq(v,0.0,0.006) end
do local a=np.transpose(np.zeros({2,0},"float16")); local w=np.array({true,true},"bool");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.flip(np.array({4,1},"uint8"),1); local w=np.array({3.0,-2.0},"float16");local v=np.average(a,{axis={},keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{1.0,4.0},0.006) end
do local a=np.array({{1},{2}},"int8"); local w=np.array({-1.0,2.0,-1.0},"float32");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.flip(np.array({{true,true},{true,true},{true,true}},"bool"),2); local w=np.array({1,-1,3,1},"int8");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.array({{np.complex(4.0,0.0)}},"complex64"); local w=np.array({-1,-1},"int32");assert(not pcall(function() np.average(a,{axis=2,weights=w}) end)) end
do local a=np.array(1.0,"float16"); local w=np.array(-1,"int8");local v=np.average(a,{axis={},weights=w});eq(v,1.0,0.006) end
do local a=np.array(1,"uint8"); local w=np.array(0,"int8");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.flip(np.array({{-3},{0}},"int32"),2); local v=np.average(a,{axis={}});assert(v.dtype=="float64")
eq(v:tolist(),{{-3.0},{0.0}},0.006) end
do local a=np.transpose(np.array({{2,0},{4,1},{0,-3}},"int8")); local w=np.array({true,false,true},"bool");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.flip(np.zeros({0},"complex64"),1); local v,sw=np.average(a,{axis=1,returned=true});eq(v,np.complex((0/0),(0/0)),0.006);eq(sw,np.complex(0.0,0.0),0.006) end
do local a=np.flip(np.array({-3.0},"float32"),1); local w=np.array(true,"bool");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({{4.0,0.0,0.0}},"float64"),2); local w=np.array({2},"uint8");local v,sw=np.average(a,{axis=1,returned=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{0.0,0.0,4.0},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{2.0,2.0,2.0},0.006) end
do local a=np.flip(np.array({np.complex(-3.0,2.0),np.complex(0.0,2.0),np.complex(-3.0,0.0)},"complex64"),1); local w=np.array({3,-2,0},"int32");local v=np.average(a,{axis={1},keepdims=true,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{np.complex(-9.0,-4.0)},2e-06) end
do local a=np.array({{4.0,2.0,-3.0}},"float64"); local w=np.array({2,2,2},"uint8");assert(not pcall(function() np.average(a,{axis={1,2},returned=true,weights=w}) end)) end
do local a=np.array({4.0,1.0,-3.0},"float16"); local w=np.array({np.complex(-1.0,2.0),np.complex(2.0,0.0),np.complex(-1.0,0.0)},"complex64");local v=np.average(a,{keepdims=true,weights=w});assert(v.dtype=="complex64")
eq(v:tolist(),{np.complex(4.0,-0.5)},0.006) end
do local a=np.flip(np.array({{0,0,-3},{0,4,-3}},"int32"),2); local w=np.array({-2,2,2},"int64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({{1.0},{-3.0}},"float64"),2); local w=np.array(1,"int8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({0,1,-3},"int64"); local v=np.average(a,{axis=1});eq(v,-0.6666666666666666,0.006) end
do local a=np.transpose(np.zeros({2,0},"int64")); local w=np.array(3,"int64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.zeros({2,0},"uint8"),2); local w=np.array({2.0,0.0,2.0},"float32");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.flip(np.array({{0.0,0.0,0.0}},"float64"),2); local w=np.array({{np.complex(3.0,0.0),np.complex(1.0,2.0),np.complex(0.0,2.0)}},"complex128");local v,sw=np.average(a,{returned=true,weights=w});eq(v,np.complex(0.0,0.0),2e-06);eq(sw,np.complex(4.0,4.0),2e-06) end
do local a=np.array({{-3.0,0.0,1.0},{1.0,2.0,-3.0}},"float16"); local w=np.array({{2,2,1},{2,3,1}},"uint8");local v=np.average(a,{axis=1,weights=w});assert(v.dtype=="float16")
eq(v:tolist(),{-1.0,1.2001953125,-1.0},0.006) end
do local a=np.transpose(np.array({{false,true},{true,true},{true,true}},"bool")); local w=np.array(-2,"int32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{1.0,0.0,0.0},{-3.0,2.0,2.0}},"float64"); local w=np.array({np.complex(0.0,2.0),np.complex(-1.0,0.0)},"complex128");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.flip(np.array({{4,2},{0,4},{0,0}},"int64"),2); local w=np.array({{0,1},{1,1},{2,2}},"uint8");local v,sw=np.average(a,{axis={1,2},returned=true,weights=w});eq(v,1.1428571428571428,0.006);eq(sw,7.0,0.006) end
do local a=np.array({np.complex(4.0,0.0),np.complex(2.0,0.0),np.complex(1.0,0.0)},"complex64"); local w=np.array({np.complex(-1.0,0.0),np.complex(3.0,0.0),np.complex(0.0,2.0)},"complex128");local v=np.average(a,{keepdims=true,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{np.complex(1.0,0.0)},2e-06) end
do local a=np.array({0},"uint8"); local w=np.array({1},"int64");local v,sw=np.average(a,{keepdims=true,returned=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{0.0},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{1.0},0.006) end
do local a=np.flip(np.array({{2,4},{2,0},{4,0}},"int32"),2); local v=np.average(a,{keepdims=true});assert(v.dtype=="float64")
eq(v:tolist(),{{2.0}},0.006) end
do local a=np.array({0,1},"uint8"); local w=np.array({-1},"int32");assert(not pcall(function() np.average(a,{axis={1},keepdims=true,weights=w}) end)) end
do local a=np.array(np.complex(2.0,0.0),"complex64"); local w=np.array(2,"uint8");local v=np.average(a,{axis={},weights=w});eq(v,np.complex(2.0,0.0),0.006) end
do local a=np.array({0,0,0},"uint8"); local w=np.array({3.0,-2.0,3.0},"float32");local v,sw=np.average(a,{axis={},keepdims=true,returned=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{0.0,-0.0,0.0},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{3.0,-2.0,3.0},0.006) end
do local a=np.array({{2,1,0},{1,4,0}},"uint8"); local v,sw=np.average(a,{axis={1,2},returned=true});eq(v,1.3333333333333333,0.006);eq(sw,6.0,0.006) end
do local a=np.array({4,0},"int8"); local w=np.array(true,"bool");local v,sw=np.average(a,{axis={},returned=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{4.0,0.0},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{1.0,1.0},0.006) end
do local a=np.zeros({2,0},"float16"); local w=np.zeros({2,0},"float16");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({true,true,true},"bool"),1); local w=np.array({3,1,-2},"int8");local v=np.average(a,{weights=w});eq(v,1.0,0.006) end
do local a=np.array({1.0},"float32"); local w=np.array(3,"int8");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="float32")
eq(v:tolist(),{1.0},0.006) end
do local a=np.flip(np.array({{{-3.0,2.0,4.0},{2.0,0.0,0.0}},{{1.0,-3.0,4.0},{4.0,4.0,1.0}}},"float32"),3); local v=np.average(a,{axis=1,keepdims=true});assert(v.dtype=="float32")
eq(v:tolist(),{{{4.0,-0.5,-1.0},{0.5,2.0,3.0}}},0.006) end
do local a=np.transpose(np.zeros({0,3},"float64")); local w=np.array({3.0,2.0,-1.0,1.0},"float64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{1},{0}},"uint8"); local v=np.average(a,{axis=1});assert(v.dtype=="float64")
eq(v:tolist(),{0.5},0.006) end
do local a=np.zeros({2,0},"complex128"); local v=np.average(a,{axis=2});assert(v.dtype=="complex128")
eq(v:tolist(),{np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},2e-06) end
do local a=np.flip(np.array({{np.complex(0.0,0.0),np.complex(-3.0,0.0)},{np.complex(4.0,2.0),np.complex(0.0,2.0)},{np.complex(-3.0,2.0),np.complex(0.0,0.0)}},"complex128"),2); local w=np.array({{1,0},{2,1},{2,0}},"int8");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.array(2.0,"float32"); local w=np.array(1.0,"float32");local v=np.average(a,{axis={},weights=w});eq(v,2.0,0.006) end
do local a=np.flip(np.array({{2}},"uint8"),2); local w=np.array({0.0,3.0},"float64");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.flip(np.array({{0,4,1},{0,0,2}},"int32"),2); local w=np.array(-1,"int64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{np.complex(-3.0,0.0)}},"complex64"); local w=np.array(0,"int64");assert(not pcall(function() np.average(a,{axis=1,returned=true,weights=w}) end)) end
do local a=np.array({np.complex(2.0,0.0),np.complex(1.0,2.0),np.complex(0.0,0.0)},"complex128"); local w=np.array({3.0,0.0,-1.0,2.0},"float64");assert(not pcall(function() np.average(a,{axis={1},keepdims=true,weights=w}) end)) end
do local a=np.array({{1.0,0.0,0.0},{0.0,0.0,-3.0}},"float32"); local w=np.array({0.0,-1.0,2.0},"float32");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.flip(np.array({{{0,4,0},{0,1,4}},{{1,2,4},{0,0,2}}},"uint8"),3); local v=np.average(a);eq(v,1.5,0.006) end
do local a=np.array({0.0,4.0},"float16"); local w=np.array(2,"uint8");assert(not pcall(function() np.average(a,{axis=1,weights=w}) end)) end
do local a=np.transpose(np.array({{false}},"bool")); local w=np.array({np.complex(1.0,2.0)},"complex64");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.array({np.complex(-3.0,0.0),np.complex(1.0,0.0)},"complex128"); local w=np.array({2,1,2},"uint8");assert(not pcall(function() np.average(a,{axis={1},weights=w}) end)) end
do local a=np.flip(np.array({{2.0,1.0,4.0}},"float64"),2); local w=np.array({{true,true,true}},"bool");local v,sw=np.average(a,{axis={},keepdims=true,returned=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{4.0,1.0,2.0}},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{{1.0,1.0,1.0}},0.006) end
do local a=np.array({2},"int64"); local w=np.array({2.0},"float16");local v,sw=np.average(a,{axis={},keepdims=true,returned=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{2.0},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{2.0},0.006) end
do local a=np.flip(np.array({1},"int32"),1); local w=np.array({3},"uint8");local v=np.average(a,{keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{1.0},0.006) end
do local a=np.flip(np.array({{2.0},{2.0}},"float16"),2); local w=np.array({{0},{2}},"int32");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.transpose(np.array({{0,0,-3}},"int32")); local v,sw=np.average(a,{returned=true});eq(v,-1.0,0.006);eq(sw,3.0,0.006) end
do local a=np.transpose(np.array({{np.complex(0.0,0.0)},{np.complex(2.0,0.0)}},"complex64")); local w=np.array({-1.0},"float16");local v=np.average(a,{axis=1,weights=w});assert(v.dtype=="complex64")
eq(v:tolist(),{np.complex(-0.0,-0.0),np.complex(2.0,-0.0)},0.006) end
do local a=np.array({{-3.0},{0.0}},"float16"); local w=np.array({{3.0},{0.0}},"float32");local v,sw=np.average(a,{axis={1,2},returned=true,weights=w});eq(v,-3.0,0.006);eq(sw,3.0,0.006) end
do local a=np.flip(np.array({{4.0}},"float16"),2); local w=np.array({np.complex(-1.0,0.0)},"complex64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.transpose(np.array({{true,true,true},{true,true,false}},"bool")); local w=np.array({{-1,1},{3,0},{0,-2}},"int32");local v=np.average(a,{weights=w});eq(v,3.0,0.006) end
do local a=np.array(-3.0,"float32"); local w=np.array(np.complex(-2.0,0.0),"complex128");local v=np.average(a,{axis={},keepdims=true,weights=w});eq(v,np.complex(-3.0,-0.0),2e-06) end
do local a=np.flip(np.array({1,0},"uint8"),1); local v=np.average(a);eq(v,0.5,0.006) end
do local a=np.array({2,4},"uint8"); local v=np.average(a,{axis=1});eq(v,3.0,0.006) end
do local a=np.transpose(np.array({{np.complex(0.0,0.0),np.complex(1.0,2.0),np.complex(0.0,0.0)},{np.complex(4.0,0.0),np.complex(0.0,0.0),np.complex(2.0,0.0)}},"complex128")); local w=np.array({0.0,-2.0,-1.0,-2.0},"float32");assert(not pcall(function() np.average(a,{axis=2,returned=true,weights=w}) end)) end
do local a=np.transpose(np.array({{4}},"int64")); local w=np.array(0,"int8");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.array({{2,4,1}},"uint8"); local v,sw=np.average(a,{returned=true});eq(v,2.3333333333333335,0.006);eq(sw,3.0,0.006) end
do local a=np.array({{np.complex(0.0,2.0),np.complex(4.0,2.0)},{np.complex(0.0,0.0),np.complex(1.0,0.0)},{np.complex(0.0,0.0),np.complex(0.0,2.0)}},"complex64"); local w=np.array({{2,2},{1,3},{1,2}},"uint8");local v=np.average(a,{weights=w});eq(v,np.complex(1.0,1.0909091234207153),0.006) end
do local a=np.zeros({2,0},"complex128"); local w=np.array({2.0,3.0},"float16");local v=np.average(a,{axis=1,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{},2e-06) end
do local a=np.array({{np.complex(0.0,0.0),np.complex(0.0,2.0)},{np.complex(-3.0,2.0),np.complex(0.0,0.0)},{np.complex(4.0,0.0),np.complex(-3.0,2.0)}},"complex128"); local w=np.array(2,"int32");assert(not pcall(function() np.average(a,{axis=2,weights=w}) end)) end
do local a=np.flip(np.zeros({0},"int8"),1); local w=np.array({true},"bool");assert(not pcall(function() np.average(a,{keepdims=true,returned=true,weights=w}) end)) end
do local a=np.flip(np.array({2,0,0},"uint8"),1); local v=np.average(a,{axis={1}});eq(v,0.6666666666666666,0.006) end
do local a=np.zeros({0,3},"float16"); local w=np.zeros({0,3},"bool");local v=np.average(a,{axis=2,weights=w});assert(v.dtype=="float16")
eq(v:tolist(),{},0.006) end
do local a=np.array({-3.0},"float16"); local w=np.array(3,"int8");assert(not pcall(function() np.average(a,{axis={1},weights=w}) end)) end
do local a=np.array({np.complex(2.0,0.0),np.complex(-3.0,2.0)},"complex128"); local w=np.array({2,3,0},"int32");assert(not pcall(function() np.average(a,{axis={1},weights=w}) end)) end
do local a=np.array({np.complex(1.0,0.0)},"complex128"); local w=np.array({np.complex(2.0,2.0)},"complex128");local v=np.average(a,{axis={1},weights=w});eq(v,np.complex(1.0,0.0),2e-06) end
do local a=np.flip(np.array({{0,1},{4,1},{0,4}},"uint8"),2); local w=np.array({3,1,0,1},"uint8");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.flip(np.array({{1.0,1.0,1.0}},"float16"),2); local w=np.array({{-1,-2,0}},"int64");local v=np.average(a,{weights=w});eq(v,1.0,0.006) end
do local a=np.flip(np.array({np.complex(2.0,0.0)},"complex128"),1); local w=np.array({np.complex(1.0,0.0),np.complex(1.0,0.0)},"complex64");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.flip(np.array({{1,2,-3},{2,0,4}},"int8"),2); local w=np.array({{-1.0,2.0,2.0},{1.0,0.0,-2.0}},"float64");local v=np.average(a,{weights=w});eq(v,4.5,0.006) end
do local a=np.array({{4.0,1.0,2.0}},"float16"); local w=np.array({{0.0,1.0,1.0}},"float16");local v,sw=np.average(a,{returned=true,weights=w});eq(v,1.5,0.006);eq(sw,2.0,0.006) end
do local a=np.array({0.0},"float64"); local w=np.array({0},"int64");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.array({0},"uint8"); local w=np.array({-2},"int32");local v,sw=np.average(a,{returned=true,weights=w});eq(v,-0.0,0.006);eq(sw,-2.0,0.006) end
do local a=np.flip(np.array({{0,2},{0,0},{-3,0}},"int64"),2); local w=np.array({{2,3},{1,1},{0,-1}},"int32");local v=np.average(a,{axis=2,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{0.8,0.0,-3.0},0.006) end
do local a=np.array({0,0,0},"int32"); local v,sw=np.average(a,{returned=true});eq(v,0.0,0.006);eq(sw,3.0,0.006) end
do local a=np.zeros({0},"int64"); local w=np.zeros({0},"float32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.zeros({0},"int8"); local w=np.array({2},"int8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({1,-3,2},"int64"); local v=np.average(a,{keepdims=true});assert(v.dtype=="float64")
eq(v:tolist(),{0.0},0.006) end
do local a=np.zeros({0},"complex128"); local w=np.array({np.complex(3.0,0.0),np.complex(-2.0,0.0),np.complex(2.0,2.0)},"complex64");assert(not pcall(function() np.average(a,{keepdims=true,returned=true,weights=w}) end)) end
do local a=np.flip(np.array({{4,4},{0,4},{2,2}},"int64"),2); local w=np.array(2.0,"float32");assert(not pcall(function() np.average(a,{axis=2,returned=true,weights=w}) end)) end
do local a=np.flip(np.array({0},"uint8"),1); local w=np.array({3.0},"float32");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{0.0},0.006) end
do local a=np.transpose(np.array({{4,-3,1}},"int32")); local w=np.array({3,-1,-2,3},"int8");assert(not pcall(function() np.average(a,{axis={1,2},keepdims=true,weights=w}) end)) end
do local a=np.flip(np.array({-3.0,0.0,2.0},"float64"),1); local v=np.average(a,{axis={1}});eq(v,-0.3333333333333333,0.006) end
do local a=np.zeros({0},"complex128"); local w=np.array(1.0,"float16");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{},2e-06) end
do local a=np.array({{true,true,false}},"bool"); local w=np.array({2,0},"int64");assert(not pcall(function() np.average(a,{axis=2,weights=w}) end)) end
do local a=np.zeros({0,3},"int64"); local v=np.average(a);eq(v,(0/0),0.006) end
do local a=np.array({{1.0,1.0,0.0}},"float16"); local w=np.array({1,-1},"int8");assert(not pcall(function() np.average(a,{axis=2,weights=w}) end)) end
do local a=np.flip(np.array({{1,4},{2,0},{0,2}},"uint8"),2); local w=np.array({1.0,2.0,-1.0,3.0},"float32");assert(not pcall(function() np.average(a,{axis={1,2},returned=true,weights=w}) end)) end
do local a=np.transpose(np.array({{0,2,4}},"int64")); local w=np.array(-1.0,"float64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{0,1,2},{2,-3,0}},"int32"); local w=np.array({{0.0,-2.0,-1.0},{3.0,-1.0,1.0}},"float64");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.transpose(np.array({{0}},"int64")); local v=np.average(a,{axis={1,2}});eq(v,0.0,0.006) end
do local a=np.array(0.0,"float16"); local v,sw=np.average(a,{keepdims=true,returned=true});eq(v,0.0,0.006);eq(sw,1.0,0.006) end
do local a=np.transpose(np.zeros({0,3},"float16")); local w=np.array(np.complex(3.0,2.0),"complex64");assert(not pcall(function() np.average(a,{axis={1,2},keepdims=true,weights=w}) end)) end
do local a=np.flip(np.array({{np.complex(1.0,2.0),np.complex(4.0,0.0),np.complex(0.0,0.0)},{np.complex(1.0,0.0),np.complex(0.0,0.0),np.complex(2.0,0.0)}},"complex64"),2); local w=np.array({np.complex(-2.0,2.0),np.complex(-1.0,0.0),np.complex(2.0,2.0)},"complex128");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{1.0,0.0,2.0},{2.0,4.0,-3.0}},"float64"); local w=np.array({{np.complex(-1.0,2.0),np.complex(1.0,2.0),np.complex(-1.0,0.0)},{np.complex(2.0,2.0),np.complex(2.0,0.0),np.complex(3.0,0.0)}},"complex128");local v=np.average(a,{weights=w});eq(v,np.complex(0.5,0.5),2e-06) end
do local a=np.zeros({2,0},"bool"); local w=np.zeros({2,0},"complex128");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.transpose(np.zeros({0,3},"int64")); local w=np.array({true,true,true,true},"bool");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.zeros({0},"float64"); local w=np.array({2},"int8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{4}},"int8"); local w=np.array({3,1},"int8");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.zeros({0},"float32"); local w=np.array({3.0,3.0,-1.0},"float64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.transpose(np.array({{np.complex(1.0,0.0),np.complex(1.0,2.0),np.complex(1.0,0.0)}},"complex128")); local w=np.array({3,1,0,2},"uint8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.transpose(np.array({{np.complex(-3.0,0.0)},{np.complex(0.0,2.0)}},"complex64")); local w=np.array({{np.complex(3.0,0.0),np.complex(1.0,0.0)}},"complex128");local v=np.average(a,{axis={1,2},keepdims=true,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{{np.complex(-2.25,0.5)}},2e-06) end
do local a=np.array(2,"int32"); local w=np.array({0,1,3},"int8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{{1,4,-3},{0,0,0}},{{-3,2,2},{1,0,2}}},"int32"); local v=np.average(a);eq(v,0.5,0.006) end
do local a=np.array({-3.0,-3.0},"float32"); local w=np.array({2,1},"uint8");local v=np.average(a,{weights=w});eq(v,-3.0,0.006) end
do local a=np.flip(np.array({{0,-3},{0,0},{0,1}},"int32"),2); local w=np.array({np.complex(3.0,0.0),np.complex(0.0,0.0),np.complex(2.0,2.0)},"complex64");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.flip(np.array({-3.0},"float32"),1); local w=np.array(-1.0,"float32");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.flip(np.zeros({0},"complex128"),1); local w=np.array({np.complex(1.0,2.0)},"complex64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array(2.0,"float64"); local w=np.array({np.complex(0.0,0.0)},"complex128");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.zeros({0,3},"complex128"); local w=np.array(-2.0,"float16");assert(not pcall(function() np.average(a,{axis={1,2},returned=true,weights=w}) end)) end
do local a=np.transpose(np.array({{-3,1},{-3,0},{0,2}},"int64")); local w=np.array({{true,false,true},{true,true,false}},"bool");local v=np.average(a,{axis={1,2},weights=w});eq(v,-0.5,0.006) end
do local a=np.zeros({2,0},"uint8"); local w=np.array({0.0,-2.0,-1.0},"float16");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{np.complex(0.0,0.0),np.complex(0.0,2.0),np.complex(-3.0,0.0)},{np.complex(1.0,0.0),np.complex(1.0,2.0),np.complex(0.0,2.0)}},"complex128"); local w=np.array({2,0,-2},"int64");assert(not pcall(function() np.average(a,{axis=2,weights=w}) end)) end
do local a=np.flip(np.array({{2,0,2}},"uint8"),2); local w=np.array({3,1},"int64");assert(not pcall(function() np.average(a,{axis=1,keepdims=true,returned=true,weights=w}) end)) end
do local a=np.array({{np.complex(2.0,0.0)}},"complex128"); local w=np.array({{true}},"bool");local v=np.average(a,{keepdims=true,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{{np.complex(2.0,0.0)}},2e-06) end
do local a=np.array({np.complex(0.0,0.0),np.complex(2.0,0.0)},"complex64"); local w=np.array(-2,"int64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({1.0,4.0,-3.0},"float32"); local w=np.array(-2,"int8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{0.0,4.0},{0.0,2.0},{0.0,0.0}},"float32"); local v,sw=np.average(a,{axis={},keepdims=true,returned=true});assert(v.dtype=="float32")
eq(v:tolist(),{{0.0,4.0},{0.0,2.0},{0.0,0.0}},0.006);assert(sw.dtype=="float32")
eq(sw:tolist(),{{1.0,1.0},{1.0,1.0},{1.0,1.0}},0.006) end
do local a=np.array({{true,false,false},{false,false,true}},"bool"); local w=np.array({{0,-1,2},{2,0,1}},"int8");local v=np.average(a,{axis=1,keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{0.0,-0.0,0.3333333333333333}},0.006) end
do local a=np.flip(np.array({{1.0}},"float32"),2); local w=np.array({np.complex(-2.0,2.0),np.complex(1.0,0.0),np.complex(2.0,0.0)},"complex128");assert(not pcall(function() np.average(a,{keepdims=true,returned=true,weights=w}) end)) end
do local a=np.zeros({0},"int64"); local w=np.array({np.complex(3.0,0.0)},"complex128");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.zeros({0},"complex64"); local w=np.array({np.complex(3.0,2.0)},"complex64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({2.0,2.0,0.0},"float64"); local v=np.average(a,{axis={}});assert(v.dtype=="float64")
eq(v:tolist(),{2.0,2.0,0.0},0.006) end
do local a=np.array({np.complex(-3.0,0.0),np.complex(1.0,0.0),np.complex(4.0,0.0)},"complex128"); local v=np.average(a,{axis=1,keepdims=true});assert(v.dtype=="complex128")
eq(v:tolist(),{np.complex(0.6666666666666666,0.0)},2e-06) end
do local a=np.zeros({0},"int8"); local w=np.zeros({0},"int32");assert(not pcall(function() np.average(a,{axis={1},weights=w}) end)) end
do local a=np.array(-3.0,"float64"); local w=np.array(1,"uint8");local v=np.average(a,{axis={},weights=w});eq(v,-3.0,0.006) end
do local a=np.array({{0,0,0}},"uint8"); local w=np.array({2.0,3.0},"float32");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.array({2.0,4.0},"float64"); local w=np.array({-1,0},"int64");local v=np.average(a,{axis={1},weights=w});eq(v,2.0,0.006) end
do local a=np.flip(np.zeros({0},"int8"),1); local w=np.zeros({0},"complex128");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({4},"int64"),1); local w=np.array({-1.0,2.0,-2.0},"float16");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.array({-3,2,1},"int32"); local v=np.average(a,{axis={},keepdims=true});assert(v.dtype=="float64")
eq(v:tolist(),{-3.0,2.0,1.0},0.006) end
do local a=np.flip(np.array({{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(-3.0,0.0)},{np.complex(4.0,0.0),np.complex(0.0,0.0),np.complex(0.0,2.0)}},"complex64"),2); local w=np.array({-1.0},"float32");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.zeros({2,0},"uint8"); local w=np.zeros({2,0},"int64");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.transpose(np.zeros({2,0},"int32")); local w=np.array(0,"int64");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.array({{true,true,false}},"bool"); local v,sw=np.average(a,{axis={1,2},returned=true});eq(v,0.6666666666666666,0.006);eq(sw,3.0,0.006) end
do local a=np.flip(np.array({{4.0}},"float16"),2); local w=np.array({np.complex(2.0,0.0),np.complex(-1.0,0.0)},"complex128");assert(not pcall(function() np.average(a,{axis=1,weights=w}) end)) end
do local a=np.flip(np.zeros({0,3},"float64"),2); local w=np.array({2.0,3.0,3.0},"float64");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.zeros({0},"bool"); local w=np.zeros({0},"complex64");assert(not pcall(function() np.average(a,{axis={1},weights=w}) end)) end
do local a=np.array(1.0,"float16"); local w=np.array({0,3},"int64");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.flip(np.zeros({0},"int8"),1); local w=np.array({3},"int32");assert(not pcall(function() np.average(a,{axis={},keepdims=true,weights=w}) end)) end
do local a=np.array({{{1,0,0},{0,4,0}},{{1,4,4},{0,0,0}}},"int32"); local v=np.average(a,{axis={1,2,3}});eq(v,1.1666666666666667,0.006) end
do local a=np.flip(np.array({np.complex(0.0,0.0),np.complex(4.0,0.0),np.complex(0.0,0.0)},"complex64"),1); local w=np.array({1},"uint8");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.flip(np.array({0.0},"float64"),1); local w=np.array({true,true,true},"bool");assert(not pcall(function() np.average(a,{axis={1},weights=w}) end)) end
do local a=np.array({0.0,0.0,0.0},"float16"); local w=np.array({true,true},"bool");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.array({-3},"int8"); local w=np.array({1.0},"float16");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{-3.0},0.006) end
do local a=np.transpose(np.array({{4}},"uint8")); local w=np.array({{-1}},"int64");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{4.0}},0.006) end
do local a=np.flip(np.array({{1.0,1.0},{0.0,-3.0},{-3.0,-3.0}},"float64"),2); local w=np.array({{2,1},{2,2},{3,0}},"uint8");local v,sw=np.average(a,{keepdims=true,returned=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{-1.2}},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{{10.0}},0.006) end
do local a=np.flip(np.zeros({0},"complex64"),1); local v,sw=np.average(a,{axis=1,keepdims=true,returned=true});assert(v.dtype=="complex64")
eq(v:tolist(),{np.complex((0/0),(0/0))},0.006);assert(sw.dtype=="complex64")
eq(sw:tolist(),{np.complex(0.0,0.0)},0.006) end
do local a=np.flip(np.array({{np.complex(2.0,2.0),np.complex(4.0,0.0),np.complex(4.0,0.0)}},"complex128"),2); local w=np.array({{true,false,true}},"bool");local v=np.average(a,{axis=2,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{np.complex(3.0,1.0)},2e-06) end
do local a=np.array(-3.0,"float16"); local w=np.array({np.complex(1.0,2.0)},"complex128");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{-3},{2}},"int8"); local w=np.array(-1.0,"float64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{4,0,0}},"int8"); local v,sw=np.average(a,{axis={1,2},returned=true});eq(v,1.3333333333333333,0.006);eq(sw,3.0,0.006) end
do local a=np.array({-3,2},"int8"); local w=np.array(2,"int8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{np.complex(0.0,0.0),np.complex(1.0,0.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex(-3.0,0.0),np.complex(2.0,2.0)}},"complex64"); local w=np.array({0,-2,0},"int8");local v=np.average(a,{axis=1,weights=w});assert(v.dtype=="complex64")
eq(v:tolist(),{np.complex(-0.0,-0.0),np.complex(-0.0,-0.0)},0.006) end
do local a=np.zeros({0},"complex64"); local w=np.array(true,"bool");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{0}},"uint8"); local w=np.array({{2}},"int32");local v=np.average(a,{weights=w});eq(v,0.0,0.006) end
do local a=np.flip(np.zeros({0},"int32"),1); local w=np.zeros({0},"complex128");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{1}},"uint8"); local w=np.array({{-1}},"int64");local v=np.average(a,{weights=w});eq(v,1.0,0.006) end
do local a=np.array(0,"uint8"); local w=np.array(1.0,"float16");local v,sw=np.average(a,{axis={},keepdims=true,returned=true,weights=w});eq(v,0.0,0.006);eq(sw,1.0,0.006) end
do local a=np.flip(np.array({{1,0,2},{0,-3,0}},"int8"),2); local w=np.array({{0.0,-2.0,-1.0},{3.0,2.0,2.0}},"float16");assert(not pcall(function() np.average(a,{axis={},keepdims=true,weights=w}) end)) end
do local a=np.zeros({0},"float32"); local w=np.array({3.0},"float32");assert(not pcall(function() np.average(a,{keepdims=true,returned=true,weights=w}) end)) end
do local a=np.array(1,"int32"); local w=np.array({true,true},"bool");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.zeros({0,3},"float64"); local w=np.array({true},"bool");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{{1,1,2},{4,1,2}},{{0,0,0},{0,0,1}}},"int64"); local v=np.average(a,{axis=2});assert(v.dtype=="float64")
eq(v:tolist(),{{2.5,1.0,2.0},{0.0,0.0,0.5}},0.006) end
do local a=np.transpose(np.array({{1,0,2},{4,0,0}},"uint8")); local v,sw=np.average(a,{axis=1,returned=true});assert(v.dtype=="float64")
eq(v:tolist(),{1.0,1.3333333333333333},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{3.0,3.0},0.006) end
do local a=np.zeros({0},"complex128"); local w=np.array(np.complex(2.0,0.0),"complex64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({{np.complex(2.0,2.0),np.complex(4.0,0.0),np.complex(4.0,2.0)}},"complex128"),2); local w=np.array({{np.complex(2.0,2.0),np.complex(2.0,0.0),np.complex(3.0,0.0)}},"complex64");local v=np.average(a,{axis=2,keepdims=true,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{{np.complex(3.0566037735849054,1.6981132075471699)}},2e-06) end
do local a=np.transpose(np.array({{1.0},{0.0}},"float32")); local w=np.array({{1.0,-2.0}},"float32");local v=np.average(a,{axis={1,2},weights=w});eq(v,-1.0,0.006) end
do local a=np.zeros({2,0},"uint8"); local w=np.array({-2.0,-2.0},"float16");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.transpose(np.array({{{0,4,0},{1,0,0}},{{0,4,1},{1,0,2}}},"uint8")); local v,sw=np.average(a,{returned=true});eq(v,1.0833333333333333,0.006);eq(sw,12.0,0.006) end
do local a=np.array({0,4},"uint8"); local w=np.array({3,2},"int64");local v=np.average(a,{axis=1,weights=w});eq(v,1.6,0.006) end
do local a=np.flip(np.array({-3.0},"float64"),1); local v=np.average(a,{axis={}});assert(v.dtype=="float64")
eq(v:tolist(),{-3.0},0.006) end
do local a=np.array({{{4.0,2.0,0.0},{0.0,0.0,0.0}},{{0.0,4.0,4.0},{1.0,2.0,1.0}}},"float64"); local v=np.average(a,{axis=3});assert(v.dtype=="float64")
eq(v:tolist(),{{2.0,0.0},{2.6666666666666665,1.3333333333333333}},0.006) end
do local a=np.zeros({2,0},"complex128"); local v=np.average(a);eq(v,np.complex((0/0),(0/0)),2e-06) end
do local a=np.array(4,"int8"); local w=np.array({true,true},"bool");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.array(2.0,"float32"); local w=np.array({true},"bool");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.transpose(np.array({{np.complex(1.0,0.0)}},"complex128")); local w=np.array(np.complex(0.0,2.0),"complex64");assert(not pcall(function() np.average(a,{axis=1,weights=w}) end)) end
do local a=np.zeros({2,0},"float16"); local w=np.zeros({2,0},"uint8");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.array({4.0,0.0,0.0},"float32"); local w=np.array({-1.0,2.0,0.0,-2.0},"float64");assert(not pcall(function() np.average(a,{axis=1,weights=w}) end)) end
do local a=np.array(0,"int64"); local v=np.average(a);eq(v,0.0,0.006) end
do local a=np.zeros({2,0},"uint8"); local v=np.average(a,{axis={1,2}});eq(v,(0/0),0.006) end
do local a=np.transpose(np.array({{{1.0,0.0,2.0},{1.0,0.0,4.0}},{{1.0,0.0,-3.0},{4.0,4.0,2.0}}},"float32")); local w=np.array({{{2,2},{0,-2}},{{0,0},{1,-2}},{{0,0},{0,3}}},"int64");local v=np.average(a,{weights=w});eq(v,-1.5,0.006) end
do local a=np.array(true,"bool"); local v,sw=np.average(a,{axis={},returned=true});eq(v,1.0,0.006);eq(sw,1.0,0.006) end
do local a=np.array({-3.0,0.0,2.0},"float32"); local w=np.array(np.complex(2.0,0.0),"complex64");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.flip(np.array({{{np.complex(0.0,2.0),np.complex(2.0,2.0),np.complex(4.0,2.0)},{np.complex(-3.0,2.0),np.complex(2.0,0.0),np.complex(2.0,2.0)}},{{np.complex(1.0,2.0),np.complex(0.0,2.0),np.complex(0.0,2.0)},{np.complex(2.0,0.0),np.complex(0.0,2.0),np.complex(2.0,0.0)}}},"complex64"),3); local w=np.array(0.0,"float64");assert(not pcall(function() np.average(a,{axis={1,2,3},weights=w}) end)) end
do local a=np.array({2,1},"int32"); local w=np.array({3.0,0.0,3.0},"float32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array(1,"int64"); local w=np.array(3,"int32");local v=np.average(a,{weights=w});eq(v,1.0,0.006) end
do local a=np.array(0,"int8"); local w=np.array(3,"int32");local v=np.average(a,{axis={},weights=w});eq(v,0.0,0.006) end
do local a=np.array({{np.complex(0.0,0.0)}},"complex64"); local v=np.average(a,{axis={1,2},keepdims=true});assert(v.dtype=="complex64")
eq(v:tolist(),{{np.complex(0.0,0.0)}},0.006) end
do local a=np.transpose(np.array({{{0.0,1.0,4.0},{0.0,2.0,-3.0}},{{0.0,0.0,1.0},{0.0,1.0,1.0}}},"float16")); local v=np.average(a,{axis={}});assert(v.dtype=="float16")
eq(v:tolist(),{{{0.0,0.0},{0.0,0.0}},{{1.0,0.0},{2.0,1.0}},{{4.0,1.0},{-3.0,1.0}}},0.006) end
do local a=np.array({true,false},"bool"); local w=np.array({np.complex(0.0,2.0),np.complex(1.0,0.0)},"complex64");local v,sw=np.average(a,{axis={1},keepdims=true,returned=true,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{np.complex(0.8,0.4)},2e-06);assert(sw.dtype=="complex128")
eq(sw:tolist(),{np.complex(1.0,2.0)},2e-06) end
do local a=np.flip(np.array({{np.complex(1.0,0.0)},{np.complex(0.0,0.0)}},"complex64"),2); local w=np.array(-2,"int32");assert(not pcall(function() np.average(a,{axis={1,2},keepdims=true,weights=w}) end)) end
do local a=np.transpose(np.zeros({0,3},"float64")); local w=np.zeros({3,0},"int64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{2,0},{0,4},{-3,0}},"int64"); local w=np.array({3.0,0.0,-1.0,0.0},"float64");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.flip(np.array({true,true,true},"bool"),1); local w=np.array({0.0,-2.0,1.0},"float32");local v=np.average(a,{weights=w});eq(v,1.0,0.006) end
do local a=np.array({{0,0},{0,0},{-3,-3}},"int32"); local w=np.array({{np.complex(1.0,0.0),np.complex(0.0,0.0)},{np.complex(-2.0,0.0),np.complex(0.0,0.0)},{np.complex(0.0,0.0),np.complex(-2.0,0.0)}},"complex64");local v,sw=np.average(a,{axis=1,returned=true,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{np.complex(-0.0,-0.0),np.complex(-3.0,-0.0)},2e-06);assert(sw.dtype=="complex128")
eq(sw:tolist(),{np.complex(-1.0,0.0),np.complex(-2.0,0.0)},2e-06) end
do local a=np.array({{-3.0,1.0},{2.0,0.0},{-3.0,-3.0}},"float64"); local w=np.array({{3,0},{0,-1},{0,2}},"int8");assert(not pcall(function() np.average(a,{axis={},keepdims=true,weights=w}) end)) end
do local a=np.array({{1.0,0.0,-3.0}},"float64"); local v=np.average(a,{axis=1});assert(v.dtype=="float64")
eq(v:tolist(),{1.0,0.0,-3.0},0.006) end
do local a=np.flip(np.array({{0.0}},"float16"),2); local w=np.array({{np.complex(-2.0,0.0)}},"complex64");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="complex64")
eq(v:tolist(),{{np.complex(-0.0,-0.0)}},0.006) end
do local a=np.array({-3.0,4.0,0.0},"float32"); local w=np.array({1,3,1},"int64");local v=np.average(a,{axis={},keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{-3.0,4.0,0.0},0.006) end
do local a=np.flip(np.array({1,-3},"int8"),1); local w=np.array(0,"int64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.zeros({0},"float32"),1); local w=np.array({-1.0,-1.0},"float64");assert(not pcall(function() np.average(a,{axis={},returned=true,weights=w}) end)) end
do local a=np.array({{{np.complex(4.0,0.0),np.complex(2.0,2.0),np.complex(4.0,2.0)},{np.complex(-3.0,2.0),np.complex(0.0,0.0),np.complex(1.0,0.0)}},{{np.complex(2.0,0.0),np.complex(4.0,0.0),np.complex(1.0,0.0)},{np.complex(0.0,0.0),np.complex(-3.0,0.0),np.complex(1.0,0.0)}}},"complex64"); local w=np.array({{{-2,3,2},{3,2,0}},{{0,-2,0},{-1,0,-1}}},"int8");local v,sw=np.average(a,{axis={1,2,3},returned=true,weights=w});eq(v,np.complex(-3.0,4.0),0.006);eq(sw,np.complex(4.0,0.0),0.006) end
do local a=np.array({{1,-3,0}},"int8"); local w=np.array({np.complex(3.0,2.0),np.complex(1.0,0.0)},"complex128");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.array(2,"uint8"); local w=np.array(3.0,"float64");local v=np.average(a,{weights=w});eq(v,2.0,0.006) end
do local a=np.array({1.0},"float64"); local w=np.array(3.0,"float16");assert(not pcall(function() np.average(a,{axis={1},returned=true,weights=w}) end)) end
do local a=np.array({{np.complex(1.0,2.0),np.complex(1.0,2.0),np.complex(4.0,0.0)}},"complex128"); local w=np.array({2,1,1},"uint8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.transpose(np.array({{np.complex(0.0,0.0),np.complex(4.0,0.0),np.complex(2.0,0.0)}},"complex64")); local v=np.average(a,{axis={},keepdims=true});assert(v.dtype=="complex64")
eq(v:tolist(),{{np.complex(0.0,0.0)},{np.complex(4.0,0.0)},{np.complex(2.0,0.0)}},0.006) end
do local a=np.flip(np.array({{1,1,0},{0,0,0}},"uint8"),2); local w=np.array({-2.0,2.0,1.0},"float32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.transpose(np.zeros({0,3},"complex128")); local w=np.array(-2,"int8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array(0,"int32"); local w=np.array(np.complex(2.0,0.0),"complex64");local v=np.average(a,{weights=w});eq(v,np.complex(0.0,0.0),2e-06) end
do local a=np.transpose(np.zeros({2,0},"float64")); local w=np.array({true},"bool");assert(not pcall(function() np.average(a,{axis=1,keepdims=true,weights=w}) end)) end
do local a=np.flip(np.array({true,false,false},"bool"),1); local w=np.array(true,"bool");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.array({{{0.0,1.0,2.0},{2.0,0.0,2.0}},{{1.0,-3.0,0.0},{1.0,-3.0,1.0}}},"float64"); local w=np.array({{{-2,-1,-1},{-2,2,3}},{{-2,0,-2},{3,-2,2}}},"int32");local v=np.average(a,{keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{{-4.0}}},0.006) end
do local a=np.array({{np.complex(4.0,0.0),np.complex(1.0,0.0)},{np.complex(-3.0,2.0),np.complex(4.0,0.0)},{np.complex(0.0,2.0),np.complex(-3.0,0.0)}},"complex128"); local w=np.array({{-1.0,0.0},{-1.0,3.0},{-1.0,3.0}},"float16");local v=np.average(a,{axis=1,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{np.complex(0.3333333333333333,1.3333333333333333),np.complex(0.5,0.0)},2e-06) end
do local a=np.array({np.complex(2.0,0.0)},"complex128"); local w=np.array({0,1},"uint8");assert(not pcall(function() np.average(a,{axis=1,keepdims=true,returned=true,weights=w}) end)) end
do local a=np.flip(np.array({{{-3,2,0},{0,4,0}},{{0,-3,1},{4,4,-3}}},"int64"),3); local w=np.array({np.complex(3.0,2.0),np.complex(0.0,0.0),np.complex(2.0,0.0)},"complex128");assert(not pcall(function() np.average(a,{axis=2,weights=w}) end)) end
do local a=np.array({1.0,1.0},"float64"); local w=np.array({1},"uint8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.zeros({0},"int8"); local w=np.zeros({0},"complex128");assert(not pcall(function() np.average(a,{axis=1,returned=true,weights=w}) end)) end
do local a=np.zeros({0,3},"float32"); local v=np.average(a,{keepdims=true});assert(v.dtype=="float32")
eq(v:tolist(),{{(0/0)}},0.006) end
do local a=np.array({{{4.0,4.0,1.0},{-3.0,0.0,2.0}},{{0.0,0.0,4.0},{-3.0,-3.0,0.0}}},"float32"); local v=np.average(a);eq(v,0.5,0.006) end
do local a=np.array({0.0,2.0,0.0},"float16"); local w=np.array({1,1,1},"uint8");local v=np.average(a,{axis={1},weights=w});eq(v,0.66650390625,0.006) end
do local a=np.zeros({2,0},"bool"); local w=np.zeros({2,0},"int32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex(-3.0,2.0),np.complex(-3.0,0.0)},{np.complex(2.0,0.0),np.complex(4.0,2.0)}},"complex128"); local w=np.array({-2,2,-2},"int32");local v,sw=np.average(a,{axis=1,returned=true,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{np.complex(5.0,-2.0),np.complex(7.0,2.0)},2e-06);assert(sw.dtype=="complex128")
eq(sw:tolist(),{np.complex(-2.0,0.0),np.complex(-2.0,0.0)},2e-06) end
do local a=np.flip(np.array({{0.0,4.0,0.0}},"float16"),2); local v=np.average(a,{axis={}});assert(v.dtype=="float16")
eq(v:tolist(),{{0.0,4.0,0.0}},0.006) end
do local a=np.zeros({0,3},"float16"); local w=np.zeros({0,3},"int32");local v=np.average(a,{axis=2,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{},0.006) end
do local a=np.zeros({0,3},"float64"); local w=np.array(2,"int8");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{},0.006) end
do local a=np.array(-3,"int8"); local w=np.array(2.0,"float64");local v=np.average(a,{keepdims=true,weights=w});eq(v,-3.0,0.006) end
do local a=np.flip(np.array({1.0,2.0},"float64"),1); local w=np.array({2.0,-1.0},"float64");local v=np.average(a,{weights=w});eq(v,3.0,0.006) end
do local a=np.array({{2.0},{0.0}},"float16"); local w=np.array({{-2},{3}},"int32");local v=np.average(a,{keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{-4.0}},0.006) end
do local a=np.array(1.0,"float16"); local w=np.array({-1,-1},"int64");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.array({{0,4},{4,-3},{1,1}},"int32"); local v=np.average(a);eq(v,1.1666666666666667,0.006) end
do local a=np.zeros({0},"float16"); local w=np.array(np.complex(-2.0,0.0),"complex128");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.zeros({2,0},"complex64"); local v,sw=np.average(a,{axis={1,2},returned=true});eq(v,np.complex((0/0),(0/0)),0.006);eq(sw,np.complex(0.0,0.0),0.006) end
do local a=np.transpose(np.array({{0,1},{0,2},{-3,1}},"int64")); local w=np.array({np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(2.0,0.0)},"complex64");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.flip(np.array({{0},{-3}},"int32"),2); local w=np.array({np.complex(2.0,2.0),np.complex(-1.0,2.0),np.complex(-2.0,2.0)},"complex64");assert(not pcall(function() np.average(a,{axis={1,2},returned=true,weights=w}) end)) end
do local a=np.array({{np.complex(2.0,0.0),np.complex(1.0,0.0),np.complex(1.0,0.0)}},"complex128"); local w=np.array({{-2.0,-2.0,3.0}},"float32");local v=np.average(a,{weights=w});eq(v,np.complex(3.0,-0.0),2e-06) end
do local a=np.array({{{0,0,0},{0,0,4}},{{0,0,1},{0,1,0}}},"int64"); local w=np.array(np.complex(3.0,0.0),"complex128");assert(not pcall(function() np.average(a,{axis={1,2,3},weights=w}) end)) end
do local a=np.array({0.0,4.0,2.0},"float16"); local w=np.array({3.0,1.0,-1.0},"float64");local v=np.average(a,{axis={},keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{0.0,4.0,2.0},0.006) end
do local a=np.array({1,1,-3},"int64"); local w=np.array({0,2,0},"int64");assert(not pcall(function() np.average(a,{axis={},keepdims=true,weights=w}) end)) end
do local a=np.flip(np.array({{{0.0,0.0,-3.0},{0.0,0.0,2.0}},{{2.0,-3.0,2.0},{4.0,1.0,4.0}}},"float64"),3); local w=np.array({np.complex(1.0,0.0),np.complex(2.0,2.0)},"complex64");local v,sw=np.average(a,{axis=2,keepdims=true,returned=true,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{{{np.complex(0.8461538461538461,0.7692307692307693),np.complex(0.0,0.0),np.complex(0.0,0.0)}},{{np.complex(3.5384615384615383,0.3076923076923078),np.complex(0.07692307692307691,0.6153846153846154),np.complex(3.5384615384615383,0.3076923076923078)}}},2e-06);assert(sw.dtype=="complex128")
eq(sw:tolist(),{{{np.complex(3.0,2.0),np.complex(3.0,2.0),np.complex(3.0,2.0)}},{{np.complex(3.0,2.0),np.complex(3.0,2.0),np.complex(3.0,2.0)}}},2e-06) end
do local a=np.flip(np.array({{0,0},{0,4},{1,-3}},"int8"),2); local v=np.average(a,{axis=1});assert(v.dtype=="float64")
eq(v:tolist(),{0.3333333333333333,0.3333333333333333},0.006) end
do local a=np.array({1.0},"float64"); local w=np.array({-1,0},"int64");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.array({{{np.complex(1.0,0.0),np.complex(0.0,2.0),np.complex(-3.0,0.0)},{np.complex(-3.0,0.0),np.complex(4.0,0.0),np.complex(0.0,0.0)}},{{np.complex(0.0,0.0),np.complex(2.0,0.0),np.complex(0.0,0.0)},{np.complex(-3.0,2.0),np.complex(0.0,0.0),np.complex(1.0,0.0)}}},"complex128"); local v=np.average(a,{axis=1});assert(v.dtype=="complex128")
eq(v:tolist(),{{np.complex(0.5,0.0),np.complex(1.0,1.0),np.complex(-1.5,0.0)},{np.complex(-3.0,1.0),np.complex(2.0,0.0),np.complex(0.5,0.0)}},2e-06) end
do local a=np.zeros({2,0},"float64"); local w=np.zeros({2,0},"int8");local v,sw=np.average(a,{axis={},keepdims=true,returned=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{},{}},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{{},{}},0.006) end
do local a=np.zeros({0},"complex64"); local w=np.zeros({0},"int8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{-3,-3,1}},"int64"); local w=np.array({3,1,1},"uint8");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.transpose(np.array({{np.complex(0.0,0.0)},{np.complex(-3.0,0.0)}},"complex128")); local w=np.array({true,true,true},"bool");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.array({1,0},"uint8"); local w=np.array({np.complex(2.0,0.0),np.complex(2.0,2.0)},"complex128");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{np.complex(1.0,0.0),np.complex(0.0,0.0)},2e-06) end
do local a=np.array({np.complex(0.0,2.0)},"complex128"); local w=np.array({true},"bool");local v=np.average(a,{weights=w});eq(v,np.complex(0.0,2.0),2e-06) end
do local a=np.array({{np.complex(0.0,2.0),np.complex(-3.0,0.0),np.complex(-3.0,0.0)}},"complex128"); local w=np.array({{1.0,-2.0,-1.0}},"float16");local v=np.average(a,{weights=w});eq(v,np.complex(-4.5,-1.0),2e-06) end
do local a=np.array(np.complex(4.0,0.0),"complex128"); local w=np.array(-2,"int32");local v=np.average(a,{weights=w});eq(v,np.complex(4.0,-0.0),2e-06) end
do local a=np.flip(np.array({0.0,0.0,2.0},"float64"),1); local w=np.array(1,"uint8");assert(not pcall(function() np.average(a,{axis={1},keepdims=true,weights=w}) end)) end
do local a=np.array({{2.0,2.0,2.0},{0.0,4.0,0.0}},"float16"); local w=np.array({{1.0,-2.0,3.0},{0.0,0.0,2.0}},"float32");local v=np.average(a,{weights=w});eq(v,1.0,0.006) end
do local a=np.array({{{-3.0,2.0,-3.0},{0.0,0.0,0.0}},{{1.0,0.0,2.0},{2.0,4.0,4.0}}},"float16"); local w=np.array({np.complex(-2.0,0.0),np.complex(-1.0,2.0),np.complex(1.0,0.0)},"complex128");assert(not pcall(function() np.average(a,{axis={1,2,3},returned=true,weights=w}) end)) end
do local a=np.flip(np.array({{4.0},{0.0}},"float64"),2); local w=np.array({{-1},{0}},"int8");local v=np.average(a,{weights=w});eq(v,4.0,0.006) end
do local a=np.array({{{np.complex(1.0,2.0),np.complex(-3.0,0.0),np.complex(2.0,0.0)},{np.complex(1.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)}},{{np.complex(1.0,2.0),np.complex(1.0,0.0),np.complex(0.0,2.0)},{np.complex(1.0,0.0),np.complex(-3.0,2.0),np.complex(2.0,0.0)}}},"complex128"); local v=np.average(a,{axis=1,keepdims=true});assert(v.dtype=="complex128")
eq(v:tolist(),{{{np.complex(1.0,2.0),np.complex(-1.0,0.0),np.complex(1.0,1.0)},{np.complex(1.0,0.0),np.complex(-1.5,1.0),np.complex(1.0,0.0)}}},2e-06) end
do local a=np.transpose(np.array({{np.complex(0.0,0.0)},{np.complex(4.0,0.0)}},"complex128")); local w=np.array(true,"bool");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.flip(np.array({{np.complex(0.0,0.0)}},"complex128"),2); local w=np.array({{1}},"int8");local v=np.average(a,{keepdims=true,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{{np.complex(0.0,0.0)}},2e-06) end
do local a=np.array({true},"bool"); local w=np.array({np.complex(-2.0,0.0),np.complex(3.0,2.0)},"complex64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({2,0},"uint8"); local v,sw=np.average(a,{axis={1},returned=true});eq(v,1.0,0.006);eq(sw,2.0,0.006) end
do local a=np.array({4,0},"int64"); local w=np.array(true,"bool");assert(not pcall(function() np.average(a,{axis=1,keepdims=true,returned=true,weights=w}) end)) end
do local a=np.flip(np.array({1,1},"int8"),1); local w=np.array({2.0,-1.0},"float16");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{1.0,1.0},0.006) end
do local a=np.array(2,"int64"); local w=np.array({1,3},"uint8");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.array({{-3.0,1.0,2.0}},"float64"); local w=np.array({-2},"int32");assert(not pcall(function() np.average(a,{keepdims=true,returned=true,weights=w}) end)) end
do local a=np.array({0.0},"float32"); local w=np.array(np.complex(2.0,0.0),"complex64");assert(not pcall(function() np.average(a,{axis=1,weights=w}) end)) end
do local a=np.flip(np.array({{np.complex(4.0,0.0),np.complex(2.0,0.0),np.complex(2.0,0.0)}},"complex128"),2); local w=np.array({{0.0,1.0,-1.0}},"float32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({-3},"int32"); local w=np.array({np.complex(-2.0,2.0)},"complex64");local v,sw=np.average(a,{axis={},returned=true,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{np.complex(-3.0,-0.0)},2e-06);assert(sw.dtype=="complex128")
eq(sw:tolist(),{np.complex(-2.0,2.0)},2e-06) end
do local a=np.transpose(np.zeros({0,3},"complex128")); local w=np.array(false,"bool");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{{4.0,4.0,-3.0},{0.0,-3.0,2.0}},{{1.0,-3.0,1.0},{1.0,0.0,-3.0}}},"float64"); local w=np.array({-2},"int64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.transpose(np.array({{np.complex(0.0,0.0),np.complex(2.0,2.0),np.complex(4.0,0.0)}},"complex64")); local w=np.array({true,true,false,true},"bool");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.array({{false,true,false}},"bool"); local v=np.average(a);eq(v,0.3333333333333333,0.006) end
do local a=np.zeros({2,0},"uint8"); assert(not pcall(function() np.average(a,{axis=1}) end)) end
do local a=np.array({0},"int32"); local w=np.array({1},"int32");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{0.0},0.006) end
do local a=np.transpose(np.array({{0.0}},"float64")); local w=np.array({-1.0,2.0},"float32");assert(not pcall(function() np.average(a,{axis=2,weights=w}) end)) end
do local a=np.array({np.complex(1.0,2.0),np.complex(4.0,2.0),np.complex(0.0,0.0)},"complex64"); local v=np.average(a);eq(v,np.complex(1.6666666269302368,1.3333333730697632),0.006) end
do local a=np.transpose(np.array({{{4,2,2},{1,0,2}},{{-3,2,0},{4,0,1}}},"int64")); local w=np.array(0.0,"float32");assert(not pcall(function() np.average(a,{axis=1,keepdims=true,returned=true,weights=w}) end)) end
do local a=np.transpose(np.array({{{0.0,0.0,2.0},{-3.0,0.0,4.0}},{{-3.0,-3.0,0.0},{0.0,2.0,-3.0}}},"float16")); local w=np.array({{{1,-1},{-2,-1}},{{-1,2},{0,-1}},{{0,3},{-1,3}}},"int32");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.transpose(np.array({{-3}},"int64")); local w=np.array({np.complex(3.0,0.0),np.complex(0.0,0.0)},"complex128");assert(not pcall(function() np.average(a,{keepdims=true,returned=true,weights=w}) end)) end
do local a=np.transpose(np.array({{np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex(2.0,2.0),np.complex(0.0,2.0)},{np.complex(0.0,0.0),np.complex(2.0,0.0)}},"complex64")); local w=np.array({{2.0,3.0,1.0},{-2.0,2.0,1.0}},"float64");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{{np.complex(0.0,0.0),np.complex(2.0,2.0),np.complex(0.0,0.0)},{np.complex(-0.0,-0.0),np.complex(0.0,2.0),np.complex(2.0,0.0)}},2e-06) end
do local a=np.array(2,"int64"); local w=np.array(0,"int32");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.array({{0.0},{1.0}},"float16"); local w=np.array({{3.0},{-1.0}},"float32");local v=np.average(a,{axis=1,weights=w});assert(v.dtype=="float32")
eq(v:tolist(),{-0.5},0.006) end
do local a=np.zeros({0,3},"bool"); local w=np.zeros({0,3},"int64");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.array(0,"int32"); local w=np.array({-2,-1},"int32");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.array({true},"bool"); local w=np.array(3.0,"float16");local v=np.average(a,{axis={},keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{1.0},0.006) end
do local a=np.array({{4,1},{0,2},{0,1}},"int64"); local w=np.array({np.complex(3.0,0.0),np.complex(0.0,2.0),np.complex(-1.0,2.0),np.complex(3.0,2.0)},"complex64");assert(not pcall(function() np.average(a,{keepdims=true,returned=true,weights=w}) end)) end
do local a=np.array({{{np.complex(2.0,2.0),np.complex(2.0,0.0),np.complex(0.0,0.0)},{np.complex(0.0,0.0),np.complex(2.0,2.0),np.complex(2.0,0.0)}},{{np.complex(0.0,0.0),np.complex(1.0,2.0),np.complex(-3.0,2.0)},{np.complex(-3.0,2.0),np.complex(1.0,0.0),np.complex(2.0,2.0)}}},"complex128"); local v,sw=np.average(a,{axis={},returned=true});assert(v.dtype=="complex128")
eq(v:tolist(),{{{np.complex(2.0,2.0),np.complex(2.0,0.0),np.complex(0.0,0.0)},{np.complex(0.0,0.0),np.complex(2.0,2.0),np.complex(2.0,0.0)}},{{np.complex(0.0,0.0),np.complex(1.0,2.0),np.complex(-3.0,2.0)},{np.complex(-3.0,2.0),np.complex(1.0,0.0),np.complex(2.0,2.0)}}},2e-06);assert(sw.dtype=="complex128")
eq(sw:tolist(),{{{np.complex(1.0,0.0),np.complex(1.0,0.0),np.complex(1.0,0.0)},{np.complex(1.0,0.0),np.complex(1.0,0.0),np.complex(1.0,0.0)}},{{np.complex(1.0,0.0),np.complex(1.0,0.0),np.complex(1.0,0.0)},{np.complex(1.0,0.0),np.complex(1.0,0.0),np.complex(1.0,0.0)}}},2e-06) end
do local a=np.array({1,-3},"int8"); local w=np.array(1,"int64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.zeros({2,0},"int8"),2); local v,sw=np.average(a,{axis={1,2},returned=true});eq(v,(0/0),0.006);eq(sw,0.0,0.006) end
do local a=np.transpose(np.array({{4,0},{0,-3},{4,-3}},"int64")); local v=np.average(a,{axis=2});assert(v.dtype=="float64")
eq(v:tolist(),{2.6666666666666665,-2.0},0.006) end
do local a=np.array({4},"int32"); local v=np.average(a);eq(v,4.0,0.006) end
do local a=np.flip(np.array({{-3.0,0.0},{1.0,-3.0},{0.0,-3.0}},"float16"),2); local v=np.average(a);eq(v,-1.3330078125,0.006) end
do local a=np.flip(np.zeros({2,0},"complex128"),2); local w=np.array(-1.0,"float64");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.zeros({2,0},"float32"); local w=np.array(true,"bool");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{0.0}},"float64"); local w=np.array(-2.0,"float64");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{-0.0}},0.006) end
do local a=np.array({{1}},"int32"); local w=np.array(-2.0,"float16");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({np.complex(0.0,0.0),np.complex(2.0,2.0),np.complex(0.0,0.0)},"complex64"); local v=np.average(a,{axis=1});eq(v,np.complex(0.6666666865348816,0.6666666865348816),0.006) end
do local a=np.array({{{-3,2,2},{0,-3,1}},{{-3,2,2},{4,-3,1}}},"int32"); local w=np.array({-1.0,-1.0,2.0},"float32");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.flip(np.zeros({0},"complex128"),1); local v,sw=np.average(a,{axis={1},returned=true});eq(v,np.complex((0/0),(0/0)),2e-06);eq(sw,np.complex(0.0,0.0),2e-06) end
do local a=np.flip(np.array({{{np.complex(0.0,2.0),np.complex(2.0,2.0),np.complex(0.0,0.0)},{np.complex(4.0,2.0),np.complex(-3.0,0.0),np.complex(4.0,0.0)}},{{np.complex(0.0,0.0),np.complex(-3.0,2.0),np.complex(0.0,0.0)},{np.complex(0.0,2.0),np.complex(2.0,0.0),np.complex(1.0,2.0)}}},"complex128"),3); local w=np.array({true},"bool");assert(not pcall(function() np.average(a,{axis={1,2,3},keepdims=true,returned=true,weights=w}) end)) end
do local a=np.zeros({2,0},"complex64"); local w=np.zeros({2,0},"float32");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.flip(np.array({{0}},"int8"),2); local w=np.array({{-2}},"int8");local v=np.average(a,{axis=2,keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{-0.0}},0.006) end
do local a=np.flip(np.array({{4,4,-3}},"int32"),2); local w=np.array(0,"int32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{np.complex(-3.0,0.0),np.complex(1.0,0.0),np.complex(-3.0,2.0)},{np.complex(-3.0,0.0),np.complex(0.0,0.0),np.complex(4.0,0.0)}},"complex128"); local w=np.array({-1.0,0.0},"float32");assert(not pcall(function() np.average(a,{axis={},keepdims=true,weights=w}) end)) end
do local a=np.array({0.0,4.0,0.0},"float64"); local w=np.array({3},"int8");assert(not pcall(function() np.average(a,{axis={},keepdims=true,weights=w}) end)) end
do local a=np.zeros({0},"uint8"); local w=np.array(0.0,"float32");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.array({{-3.0}},"float64"); local v,sw=np.average(a,{axis={},keepdims=true,returned=true});assert(v.dtype=="float64")
eq(v:tolist(),{{-3.0}},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{{1.0}},0.006) end
do local a=np.array(np.complex(4.0,0.0),"complex64"); local w=np.array(2,"int32");local v=np.average(a,{weights=w});eq(v,np.complex(4.0,0.0),2e-06) end
do local a=np.transpose(np.array({{0.0,0.0,2.0}},"float32")); local w=np.array({2,3,1},"int8");local v=np.average(a,{axis=1,weights=w});assert(v.dtype=="float32")
eq(v:tolist(),{0.3333333432674408},0.006) end
do local a=np.array({{{2,-3,0},{-3,-3,2}},{{-3,0,0},{0,-3,4}}},"int64"); local v=np.average(a,{keepdims=true});assert(v.dtype=="float64")
eq(v:tolist(),{{{-0.5833333333333334}}},0.006) end
do local a=np.array(2.0,"float32"); local w=np.array(-2,"int64");local v=np.average(a,{axis={},weights=w});eq(v,2.0,0.006) end
do local a=np.array({true},"bool"); local w=np.array({1.0},"float16");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{1.0},0.006) end
do local a=np.transpose(np.array({{np.complex(-3.0,0.0),np.complex(1.0,2.0),np.complex(0.0,2.0)}},"complex64")); local w=np.array({true,true,true,true},"bool");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({np.complex(0.0,2.0)},"complex64"),1); local v=np.average(a,{keepdims=true});assert(v.dtype=="complex64")
eq(v:tolist(),{np.complex(0.0,2.0)},0.006) end
do local a=np.flip(np.array({{2.0,-3.0,-3.0}},"float64"),2); local v,sw=np.average(a,{returned=true});eq(v,-1.3333333333333333,0.006);eq(sw,3.0,0.006) end
do local a=np.array({-3,4,0},"int32"); local w=np.array({-2},"int8");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.array({{4}},"int8"); local w=np.array({{2}},"int32");local v=np.average(a,{axis=1,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{4.0},0.006) end
do local a=np.array({{4.0}},"float32"); local w=np.array({{np.complex(1.0,0.0)}},"complex64");local v=np.average(a,{axis={},keepdims=true,weights=w});assert(v.dtype=="complex64")
eq(v:tolist(),{{np.complex(4.0,0.0)}},0.006) end
do local a=np.transpose(np.array({{4},{4}},"uint8")); local w=np.array({{0,-2}},"int32");local v=np.average(a,{keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{4.0}},0.006) end
do local a=np.array({{4}},"uint8"); local w=np.array({{np.complex(2.0,0.0)}},"complex128");local v=np.average(a,{weights=w});eq(v,np.complex(4.0,0.0),2e-06) end
do local a=np.array({-3,0},"int32"); local w=np.array({-2.0,1.0},"float16");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{-3.0,0.0},0.006) end
do local a=np.transpose(np.array({{false,false},{false,false},{false,false}},"bool")); local w=np.array({0,1,2},"uint8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array(2,"uint8"); local w=np.array({-1.0,2.0,3.0},"float16");assert(not pcall(function() np.average(a,{axis={},keepdims=true,returned=true,weights=w}) end)) end
do local a=np.array({{4,2,2},{4,0,-3}},"int64"); local v=np.average(a);eq(v,1.5,0.006) end
do local a=np.zeros({2,0},"bool"); local w=np.array({-1,1,-1},"int32");assert(not pcall(function() np.average(a,{axis=1,keepdims=true,weights=w}) end)) end
do local a=np.flip(np.array({{1}},"uint8"),2); local w=np.array({{true}},"bool");local v=np.average(a,{axis=1,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{1.0},0.006) end
do local a=np.array({2.0,0.0,4.0},"float64"); local w=np.array({np.complex(-1.0,0.0),np.complex(1.0,0.0),np.complex(3.0,0.0)},"complex64");local v=np.average(a,{axis=1,weights=w});eq(v,np.complex(3.333333333333333,0.0),2e-06) end
do local a=np.array({{2.0,0.0},{-3.0,2.0},{1.0,2.0}},"float32"); local v=np.average(a,{axis=1});assert(v.dtype=="float32")
eq(v:tolist(),{0.0,1.3333333730697632},0.006) end
do local a=np.flip(np.zeros({0,3},"complex64"),2); local v=np.average(a,{axis=1,keepdims=true});assert(v.dtype=="complex64")
eq(v:tolist(),{{np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))}},0.006) end
do local a=np.flip(np.array({np.complex(0.0,0.0)},"complex128"),1); local w=np.array({true},"bool");local v=np.average(a,{weights=w});eq(v,np.complex(0.0,0.0),2e-06) end
do local a=np.flip(np.array({np.complex(2.0,0.0),np.complex(-3.0,0.0)},"complex64"),1); local w=np.array(-1.0,"float16");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.transpose(np.array({{false},{false}},"bool")); local w=np.array({{1,3}},"int32");local v=np.average(a,{weights=w});eq(v,0.0,0.006) end
do local a=np.array({-3.0,0.0},"float32"); local w=np.array({-1,-1},"int8");local v=np.average(a,{axis={1},weights=w});eq(v,-1.5,0.006) end
do local a=np.flip(np.zeros({0},"complex128"),1); local w=np.zeros({0},"uint8");assert(not pcall(function() np.average(a,{axis={1},weights=w}) end)) end
do local a=np.array({4,1,0},"int32"); local w=np.array({3.0,2.0,-2.0},"float16");local v=np.average(a,{keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{4.666666666666667},0.006) end
do local a=np.array({{true}},"bool"); local w=np.array({{np.complex(1.0,2.0)}},"complex128");local v=np.average(a,{keepdims=true,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{{np.complex(1.0,0.0)}},2e-06) end
do local a=np.transpose(np.array({{2,4,0},{4,1,1}},"int64")); local v=np.average(a,{axis={}});assert(v.dtype=="float64")
eq(v:tolist(),{{2.0,4.0},{4.0,1.0},{0.0,1.0}},0.006) end
do local a=np.array({1.0,1.0},"float16"); local w=np.array(-1,"int64");assert(not pcall(function() np.average(a,{axis={1},keepdims=true,weights=w}) end)) end
do local a=np.flip(np.array({{-3.0,0.0,0.0}},"float64"),2); local w=np.array({{-1,1,3}},"int32");local v=np.average(a,{weights=w});eq(v,-3.0,0.006) end
do local a=np.transpose(np.zeros({2,0},"int64")); local w=np.array(np.complex(0.0,0.0),"complex64");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.array({{{2,1,0},{1,0,1}},{{1,-3,0},{4,2,2}}},"int32"); local w=np.array({{{-2,2,3},{0,2,3}},{{0,-1,0},{3,1,-1}}},"int64");assert(not pcall(function() np.average(a,{axis=2,keepdims=true,weights=w}) end)) end
do local a=np.array({0},"uint8"); local w=np.array({np.complex(2.0,0.0),np.complex(3.0,0.0)},"complex128");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{4.0,1.0,4.0}},"float64"); local w=np.array({2.0},"float32");local v=np.average(a,{axis=1,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{4.0,1.0,4.0},0.006) end
do local a=np.array({{np.complex(4.0,2.0),np.complex(-3.0,0.0)},{np.complex(2.0,2.0),np.complex(0.0,0.0)},{np.complex(4.0,2.0),np.complex(0.0,2.0)}},"complex64"); local v=np.average(a,{axis=2});assert(v.dtype=="complex64")
eq(v:tolist(),{np.complex(0.5,1.0),np.complex(1.0,1.0),np.complex(2.0,2.0)},0.006) end
do local a=np.transpose(np.zeros({2,0},"bool")); local w=np.zeros({0,2},"int8");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.zeros({2,0},"float16"); local w=np.array(0,"int64");assert(not pcall(function() np.average(a,{keepdims=true,returned=true,weights=w}) end)) end
do local a=np.transpose(np.zeros({0,3},"float64")); local w=np.array(0.0,"float32");assert(not pcall(function() np.average(a,{axis={1,2},returned=true,weights=w}) end)) end
do local a=np.zeros({2,0},"int32"); local w=np.array({3,2,3},"uint8");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.array({0,0},"int32"); local w=np.array({true,true},"bool");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{0.0,0.0},0.006) end
do local a=np.array(1,"uint8"); local v=np.average(a,{axis={}});eq(v,1.0,0.006) end
do local a=np.array({{0,0},{1,0},{0,0}},"int64"); local v=np.average(a,{axis={1,2}});eq(v,0.16666666666666666,0.006) end
do local a=np.array({4,2},"uint8"); local w=np.array({-2.0,-1.0},"float16");local v=np.average(a,{weights=w});eq(v,3.3333333333333335,0.006) end
do local a=np.array({{0,4},{0,4},{2,1}},"uint8"); local w=np.array({{np.complex(-1.0,0.0),np.complex(0.0,0.0)},{np.complex(-1.0,0.0),np.complex(3.0,0.0)},{np.complex(2.0,2.0),np.complex(-2.0,0.0)}},"complex128");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.array({{0,4},{0,-3},{4,-3}},"int64"); local w=np.array({{3.0,1.0},{-1.0,-2.0},{-1.0,1.0}},"float32");assert(not pcall(function() np.average(a,{axis=1,keepdims=true,returned=true,weights=w}) end)) end
do local a=np.zeros({0},"int32"); local w=np.array({0},"int32");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.array({0.0},"float64"); local v=np.average(a,{axis=1});eq(v,0.0,0.006) end
do local a=np.array({np.complex(2.0,0.0)},"complex128"); local v,sw=np.average(a,{returned=true});eq(v,np.complex(2.0,0.0),2e-06);eq(sw,np.complex(1.0,0.0),2e-06) end
do local a=np.flip(np.zeros({2,0},"float64"),2); local w=np.array({2,2,3},"uint8");assert(not pcall(function() np.average(a,{keepdims=true,returned=true,weights=w}) end)) end
do local a=np.transpose(np.array({{{true,true,true},{true,true,false}},{{true,true,true},{true,true,true}}},"bool")); local w=np.array(2,"uint8");local v=np.average(a,{axis={},keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{{1.0,1.0},{1.0,1.0}},{{1.0,1.0},{1.0,1.0}},{{1.0,1.0},{0.0,1.0}}},0.006) end
do local a=np.zeros({0},"bool"); local w=np.zeros({0},"complex128");assert(not pcall(function() np.average(a,{keepdims=true,returned=true,weights=w}) end)) end
do local a=np.array(true,"bool"); local w=np.array(1.0,"float16");local v=np.average(a,{weights=w});eq(v,1.0,0.006) end
do local a=np.array(np.complex(0.0,2.0),"complex64"); local v=np.average(a,{axis={}});eq(v,np.complex(0.0,2.0),0.006) end
do local a=np.array({{2.0}},"float16"); local w=np.array({0.0},"float32");assert(not pcall(function() np.average(a,{axis=2,weights=w}) end)) end
do local a=np.array({true},"bool"); local w=np.array({2.0},"float32");local v=np.average(a,{axis=1,weights=w});eq(v,1.0,0.006) end
do local a=np.array({{true},{true}},"bool"); local w=np.array({3,-2},"int64");local v=np.average(a,{axis=1,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{1.0},0.006) end
do local a=np.array(0.0,"float64"); local w=np.array(0,"uint8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.zeros({0},"complex128"); local w=np.array({1},"uint8");assert(not pcall(function() np.average(a,{axis={1},weights=w}) end)) end
do local a=np.transpose(np.array({{0}},"uint8")); local w=np.array({{0}},"int64");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.transpose(np.zeros({2,0},"float16")); local w=np.zeros({0,2},"float64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.zeros({0,3},"complex128"); local w=np.array({-1.0},"float16");assert(not pcall(function() np.average(a,{axis={1,2},keepdims=true,weights=w}) end)) end
do local a=np.transpose(np.array({{{2.0,2.0,0.0},{0.0,0.0,1.0}},{{-3.0,0.0,2.0},{2.0,0.0,-3.0}}},"float16")); local w=np.array({{{0,2},{1,1}},{{-1,-2},{3,1}},{{2,1},{2,3}}},"int32");local v=np.average(a,{weights=w});eq(v,-0.8461538461538461,0.006) end
do local a=np.array(np.complex(2.0,0.0),"complex128"); local v=np.average(a);eq(v,np.complex(2.0,0.0),2e-06) end
do local a=np.array({{4,4},{0,4},{2,0}},"uint8"); local v=np.average(a,{axis={}});assert(v.dtype=="float64")
eq(v:tolist(),{{4.0,4.0},{0.0,4.0},{2.0,0.0}},0.006) end
do local a=np.zeros({2,0},"uint8"); local w=np.zeros({2,0},"float64");local v=np.average(a,{axis=1,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{},0.006) end
do local a=np.flip(np.zeros({2,0},"uint8"),2); local v=np.average(a);eq(v,(0/0),0.006) end
do local a=np.transpose(np.array({{0,1,-3},{4,-3,0}},"int32")); local w=np.array({np.complex(3.0,2.0),np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(0.0,0.0)},"complex128");assert(not pcall(function() np.average(a,{axis=2,keepdims=true,returned=true,weights=w}) end)) end
do local a=np.flip(np.array({{0.0}},"float16"),2); local w=np.array({{-1.0}},"float32");local v=np.average(a,{weights=w});eq(v,-0.0,0.006) end
do local a=np.transpose(np.array({{0},{0}},"int64")); local v,sw=np.average(a,{axis=1,returned=true});assert(v.dtype=="float64")
eq(v:tolist(),{0.0,0.0},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{1.0,1.0},0.006) end
do local a=np.array({-3.0,4.0,2.0},"float32"); local w=np.array({true,true,true},"bool");local v=np.average(a,{weights=w});eq(v,1.0,0.006) end
do local a=np.array({{4.0,2.0,2.0},{4.0,4.0,0.0}},"float32"); local w=np.array({true,false,true},"bool");assert(not pcall(function() np.average(a,{axis={1,2},returned=true,weights=w}) end)) end
do local a=np.zeros({2,0},"complex64"); local w=np.zeros({2,0},"bool");assert(not pcall(function() np.average(a,{keepdims=true,returned=true,weights=w}) end)) end
do local a=np.array({{1.0}},"float16"); local v=np.average(a,{axis={}});assert(v.dtype=="float16")
eq(v:tolist(),{{1.0}},0.006) end
do local a=np.zeros({0,3},"uint8"); local w=np.array({true},"bool");assert(not pcall(function() np.average(a,{axis=2,weights=w}) end)) end
do local a=np.flip(np.array({{np.complex(0.0,0.0),np.complex(2.0,0.0),np.complex(0.0,2.0)}},"complex128"),2); local w=np.array({{0.0,2.0,3.0}},"float32");local v,sw=np.average(a,{keepdims=true,returned=true,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{{np.complex(0.8,0.0)}},2e-06);assert(sw.dtype=="complex128")
eq(sw:tolist(),{{np.complex(5.0,0.0)}},2e-06) end
do local a=np.transpose(np.array({{np.complex(-3.0,0.0),np.complex(-3.0,2.0)},{np.complex(-3.0,0.0),np.complex(1.0,0.0)},{np.complex(-3.0,0.0),np.complex(0.0,2.0)}},"complex128")); local w=np.array(1,"int64");assert(not pcall(function() np.average(a,{axis=2,keepdims=true,weights=w}) end)) end
do local a=np.array({{np.complex(-3.0,2.0),np.complex(0.0,2.0),np.complex(2.0,2.0)},{np.complex(4.0,0.0),np.complex(2.0,0.0),np.complex(4.0,0.0)}},"complex128"); local w=np.array({{2,-2,2},{3,1,-1}},"int64");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{{np.complex(-3.0,2.0),np.complex(-0.0,2.0),np.complex(2.0,2.0)},{np.complex(4.0,0.0),np.complex(2.0,0.0),np.complex(4.0,-0.0)}},2e-06) end
do local a=np.array({{{4,0,1},{4,4,4}},{{1,-3,-3},{1,1,0}}},"int64"); local w=np.array({true,true},"bool");assert(not pcall(function() np.average(a,{axis={},keepdims=true,weights=w}) end)) end
do local a=np.transpose(np.array({{{2.0,2.0,0.0},{0.0,-3.0,-3.0}},{{1.0,0.0,0.0},{-3.0,1.0,-3.0}}},"float32")); local w=np.array({{{3,2},{-1,3}},{{3,2},{3,2}},{{0,3},{3,3}}},"int32");local v,sw=np.average(a,{returned=true,weights=w});eq(v,-0.7692307692307693,0.006);eq(sw,26.0,0.006) end
do local a=np.zeros({2,0},"complex128"); local w=np.zeros({2,0},"complex128");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({{np.complex(0.0,2.0),np.complex(0.0,0.0),np.complex(0.0,2.0)}},"complex128"),2); local w=np.array({2.0,3.0},"float32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({{np.complex(0.0,2.0)},{np.complex(1.0,0.0)}},"complex64"),2); local w=np.array({np.complex(1.0,0.0),np.complex(0.0,2.0),np.complex(1.0,0.0)},"complex64");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.flip(np.array({np.complex(1.0,2.0)},"complex128"),1); local v=np.average(a);eq(v,np.complex(1.0,2.0),2e-06) end
do local a=np.array({{0.0,0.0,2.0},{4.0,0.0,2.0}},"float16"); local w=np.array({{1.0,-2.0,2.0},{0.0,-1.0,2.0}},"float64");local v,sw=np.average(a,{axis=2,returned=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{4.0,4.0},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{1.0,1.0},0.006) end
do local a=np.array({{0.0}},"float32"); local w=np.array({{3.0}},"float32");local v,sw=np.average(a,{returned=true,weights=w});eq(v,0.0,0.006);eq(sw,3.0,0.006) end
do local a=np.zeros({0},"int8"); local v=np.average(a,{axis=1});eq(v,(0/0),0.006) end
do local a=np.transpose(np.zeros({0,3},"int64")); local w=np.array(1,"int32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.zeros({0},"bool"); local w=np.array(np.complex(-2.0,0.0),"complex64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.transpose(np.zeros({0,3},"int64")); local w=np.zeros({3,0},"bool");local v=np.average(a,{axis=1,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{},0.006) end
do local a=np.flip(np.array({2,2,0},"int32"),1); local v=np.average(a,{axis={}});assert(v.dtype=="float64")
eq(v:tolist(),{0.0,2.0,2.0},0.006) end
do local a=np.array(true,"bool"); local w=np.array(1,"uint8");local v,sw=np.average(a,{returned=true,weights=w});eq(v,1.0,0.006);eq(sw,1.0,0.006) end
do local a=np.flip(np.array({{{true,true,false},{true,true,true}},{{false,false,true},{true,false,false}}},"bool"),3); local v,sw=np.average(a,{keepdims=true,returned=true});assert(v.dtype=="float64")
eq(v:tolist(),{{{0.5833333333333334}}},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{{{12.0}}},0.006) end
do local a=np.array({2},"int8"); local w=np.array({-2},"int32");local v=np.average(a,{axis={1},weights=w});eq(v,2.0,0.006) end
do local a=np.array({{1.0},{0.0}},"float64"); local w=np.array({{true},{true}},"bool");local v=np.average(a,{axis={1,2},weights=w});eq(v,0.5,0.006) end
do local a=np.array({{0.0,1.0,2.0},{4.0,1.0,1.0}},"float32"); local v,sw=np.average(a,{axis={},returned=true});assert(v.dtype=="float32")
eq(v:tolist(),{{0.0,1.0,2.0},{4.0,1.0,1.0}},0.006);assert(sw.dtype=="float32")
eq(sw:tolist(),{{1.0,1.0,1.0},{1.0,1.0,1.0}},0.006) end
do local a=np.flip(np.zeros({0},"bool"),1); local v,sw=np.average(a,{keepdims=true,returned=true});assert(v.dtype=="float64")
eq(v:tolist(),{(0/0)},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{0.0},0.006) end
do local a=np.transpose(np.zeros({2,0},"int8")); local w=np.zeros({0,2},"uint8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{0},{2}},"int8"); local w=np.array(np.complex(-1.0,2.0),"complex128");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array(np.complex(4.0,0.0),"complex64"); local w=np.array(np.complex(-1.0,0.0),"complex64");local v=np.average(a,{weights=w});eq(v,np.complex(4.0,-0.0),0.006) end
do local a=np.array({{-3,4,2},{1,2,4}},"int64"); local w=np.array({{3.0,0.0,2.0},{0.0,3.0,-2.0}},"float64");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.array({4,0,1},"int32"); local w=np.array({0.0,-1.0,-1.0},"float16");local v=np.average(a,{keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{0.5},0.006) end
do local a=np.array({0.0},"float32"); local v=np.average(a,{axis=1,keepdims=true});assert(v.dtype=="float32")
eq(v:tolist(),{0.0},0.006) end
do local a=np.zeros({0,3},"complex128"); local w=np.zeros({0,3},"int32");assert(not pcall(function() np.average(a,{keepdims=true,returned=true,weights=w}) end)) end
do local a=np.flip(np.array({{{-3,1,0},{0,-3,1}},{{2,0,0},{1,4,1}}},"int8"),3); local w=np.array({{{2,1,3},{2,2,1}},{{2,2,1},{1,2,2}}},"uint8");local v,sw=np.average(a,{keepdims=true,returned=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{{0.047619047619047616}}},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{{{21.0}}},0.006) end
do local a=np.array({{-3}},"int8"); local w=np.array({-2.0,0.0},"float64");assert(not pcall(function() np.average(a,{axis={},returned=true,weights=w}) end)) end
do local a=np.array({0,1,2},"uint8"); local w=np.array({np.complex(-2.0,2.0),np.complex(2.0,0.0),np.complex(3.0,2.0),np.complex(-2.0,0.0)},"complex128");assert(not pcall(function() np.average(a,{axis={1},weights=w}) end)) end
do local a=np.flip(np.array({np.complex(4.0,2.0),np.complex(1.0,2.0)},"complex128"),1); local w=np.array({0.0,-2.0},"float32");local v=np.average(a,{axis=1,weights=w});eq(v,np.complex(4.0,2.0),2e-06) end
do local a=np.array(true,"bool"); local w=np.array(np.complex(2.0,2.0),"complex64");local v,sw=np.average(a,{returned=true,weights=w});eq(v,np.complex(1.0,0.0),2e-06);eq(sw,np.complex(2.0,2.0),2e-06) end
do local a=np.transpose(np.array({{{2,1,0},{0,0,2}},{{0,0,2},{4,1,2}}},"int64")); local w=np.array({{{1.0,2.0},{3.0,-1.0}},{{2.0,-2.0},{2.0,-2.0}},{{0.0,-1.0},{3.0,-1.0}}},"float16");local v=np.average(a,{weights=w});eq(v,0.0,0.006) end
do local a=np.array({{0,1,0},{1,1,0}},"int32"); local w=np.array({3,-1,3},"int64");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.array({{true,true,false}},"bool"); local v=np.average(a,{keepdims=true});assert(v.dtype=="float64")
eq(v:tolist(),{{0.6666666666666666}},0.006) end
do local a=np.flip(np.array({{1,0,0}},"int32"),2); local w=np.array({np.complex(2.0,0.0)},"complex128");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.flip(np.array({{4.0},{2.0}},"float16"),2); local v=np.average(a,{axis={},keepdims=true});assert(v.dtype=="float16")
eq(v:tolist(),{{4.0},{2.0}},0.006) end
do local a=np.flip(np.array({0,0,-3},"int8"),1); local w=np.array({-1,1,-2},"int32");local v=np.average(a,{weights=w});eq(v,-1.5,0.006) end
do local a=np.array(np.complex(1.0,0.0),"complex64"); local w=np.array(true,"bool");local v=np.average(a,{weights=w});eq(v,np.complex(1.0,0.0),0.006) end
do local a=np.array({{2.0,4.0},{1.0,0.0},{0.0,4.0}},"float32"); local w=np.array(2.0,"float64");assert(not pcall(function() np.average(a,{axis={1,2},keepdims=true,weights=w}) end)) end
do local a=np.zeros({0,3},"float32"); local w=np.array(3.0,"float32");assert(not pcall(function() np.average(a,{axis=2,weights=w}) end)) end
do local a=np.transpose(np.array({{-3,1,1},{0,4,1}},"int64")); local v=np.average(a);eq(v,0.6666666666666666,0.006) end
do local a=np.transpose(np.array({{-3}},"int8")); local w=np.array({0.0},"float64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.transpose(np.array({{{true,false,true},{false,true,false}},{{true,true,true},{false,true,false}}},"bool")); local w=np.array({{{2.0,0.0},{-1.0,3.0}},{{2.0,0.0},{3.0,0.0}},{{2.0,0.0},{-1.0,3.0}}},"float16");local v=np.average(a,{keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{{0.5384615384615384}}},0.006) end
do local a=np.flip(np.array({{np.complex(4.0,2.0),np.complex(2.0,2.0),np.complex(0.0,2.0)},{np.complex(0.0,2.0),np.complex(2.0,0.0),np.complex(0.0,0.0)}},"complex64"),2); local w=np.array({{true,false,true},{true,false,true}},"bool");local v=np.average(a,{weights=w});eq(v,np.complex(1.0,1.5),0.006) end
do local a=np.array({{4,0,1}},"int8"); local w=np.array({-2.0,-1.0},"float64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.zeros({2,0},"bool"); local w=np.zeros({2,0},"int8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.zeros({2,0},"int32"),2); assert(not pcall(function() np.average(a,{axis=1}) end)) end
do local a=np.array({{np.complex(4.0,0.0),np.complex(1.0,0.0)},{np.complex(-3.0,2.0),np.complex(1.0,0.0)},{np.complex(0.0,0.0),np.complex(0.0,2.0)}},"complex64"); local v=np.average(a);eq(v,np.complex(0.5,0.6666666865348816),0.006) end
do local a=np.transpose(np.array({{np.complex(0.0,0.0)},{np.complex(2.0,0.0)}},"complex128")); local w=np.array({2,0,0},"uint8");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.array({4.0,1.0,0.0},"float64"); local w=np.array({true,true},"bool");assert(not pcall(function() np.average(a,{axis={},keepdims=true,weights=w}) end)) end
do local a=np.array({true},"bool"); local w=np.array({true},"bool");local v=np.average(a,{axis={1},weights=w});eq(v,1.0,0.006) end
do local a=np.flip(np.array({{np.complex(1.0,2.0),np.complex(0.0,0.0)},{np.complex(4.0,0.0),np.complex(2.0,2.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0)}},"complex128"),2); local v=np.average(a,{axis={},keepdims=true});assert(v.dtype=="complex128")
eq(v:tolist(),{{np.complex(0.0,0.0),np.complex(1.0,2.0)},{np.complex(2.0,2.0),np.complex(4.0,0.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0)}},2e-06) end
do local a=np.flip(np.array({{1.0},{2.0}},"float32"),2); local v=np.average(a);eq(v,1.5,0.006) end
do local a=np.transpose(np.array({{1,2,2}},"uint8")); local w=np.array(3,"int8");assert(not pcall(function() np.average(a,{axis=2,weights=w}) end)) end
do local a=np.flip(np.array({{2.0},{-3.0}},"float64"),2); local w=np.array({1.0},"float16");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.transpose(np.array({{1}},"int32")); local w=np.array({-2.0,1.0},"float32");assert(not pcall(function() np.average(a,{axis=2,returned=true,weights=w}) end)) end
do local a=np.zeros({0},"float64"); local w=np.array({true},"bool");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.transpose(np.array({{2.0,-3.0},{4.0,0.0},{0.0,0.0}},"float16")); local w=np.array(np.complex(3.0,2.0),"complex64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{{0.0,2.0,0.0},{4.0,2.0,1.0}},{{0.0,1.0,0.0},{2.0,0.0,1.0}}},"float32"); local w=np.array({{{2.0,2.0,2.0},{1.0,2.0,0.0}},{{1.0,3.0,2.0},{-2.0,-2.0,-2.0}}},"float64");local v=np.average(a,{axis={1,2,3},weights=w});eq(v,1.0,0.006) end
do local a=np.transpose(np.array({{{0,0,4},{4,2,-3}},{{4,4,1},{2,1,4}}},"int32")); local w=np.array({{{true,true},{true,true}},{{true,true},{false,true}},{{false,true},{true,true}}},"bool");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.array({1.0,0.0,-3.0},"float32"); local w=np.array({1,2,3},"uint8");local v=np.average(a,{axis=1,weights=w});eq(v,-1.3333333730697632,0.006) end
do local a=np.array(true,"bool"); local w=np.array({3,-1},"int64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.zeros({0,3},"bool"); local w=np.zeros({0,3},"int8");assert(not pcall(function() np.average(a,{keepdims=true,returned=true,weights=w}) end)) end
do local a=np.flip(np.array({{0}},"int32"),2); local v=np.average(a,{axis={1,2}});eq(v,0.0,0.006) end
do local a=np.transpose(np.array({{0.0,-3.0,1.0},{1.0,0.0,4.0}},"float32")); local w=np.array({3.0,0.0,0.0,2.0},"float16");assert(not pcall(function() np.average(a,{axis={1,2},returned=true,weights=w}) end)) end
do local a=np.array({np.complex(-3.0,2.0),np.complex(-3.0,0.0),np.complex(0.0,0.0)},"complex128"); local w=np.array({np.complex(-2.0,0.0),np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(2.0,0.0)},"complex128");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.flip(np.array({{np.complex(-3.0,2.0),np.complex(0.0,2.0)},{np.complex(0.0,2.0),np.complex(0.0,0.0)},{np.complex(4.0,0.0),np.complex(0.0,2.0)}},"complex128"),2); local w=np.array({{np.complex(0.0,0.0),np.complex(-1.0,2.0)},{np.complex(1.0,0.0),np.complex(0.0,0.0)},{np.complex(3.0,0.0),np.complex(2.0,0.0)}},"complex64");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.flip(np.array({0,2,0},"uint8"),1); local w=np.array({2.0,-1.0,2.0},"float32");local v=np.average(a,{weights=w});eq(v,-0.6666666666666666,0.006) end
do local a=np.transpose(np.zeros({2,0},"float32")); local w=np.zeros({0,2},"int64");assert(not pcall(function() np.average(a,{axis={1,2},returned=true,weights=w}) end)) end
do local a=np.array({4.0},"float16"); local w=np.array({np.complex(-1.0,2.0)},"complex128");local v,sw=np.average(a,{returned=true,weights=w});eq(v,np.complex(4.0,0.0),2e-06);eq(sw,np.complex(-1.0,2.0),2e-06) end
do local a=np.array({0.0},"float16"); local v=np.average(a);eq(v,0.0,0.006) end
do local a=np.flip(np.array({{4.0}},"float16"),2); local w=np.array({true,true},"bool");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.array({{np.complex(1.0,0.0),np.complex(2.0,2.0),np.complex(0.0,0.0)},{np.complex(0.0,0.0),np.complex(2.0,0.0),np.complex(-3.0,2.0)}},"complex128"); local v=np.average(a);eq(v,np.complex(0.3333333333333333,0.6666666666666666),2e-06) end
do local a=np.array({2},"int8"); local w=np.array({0,1},"int8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{0.0,2.0,4.0}},"float32"); local w=np.array(3,"uint8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.zeros({2,0},"float16"),2); local w=np.array({-2.0,-1.0,-1.0},"float16");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.array({{{false,true,false},{true,true,false}},{{true,false,true},{true,false,true}}},"bool"); local v,sw=np.average(a,{axis={},returned=true});assert(v.dtype=="float64")
eq(v:tolist(),{{{0.0,1.0,0.0},{1.0,1.0,0.0}},{{1.0,0.0,1.0},{1.0,0.0,1.0}}},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{{{1.0,1.0,1.0},{1.0,1.0,1.0}},{{1.0,1.0,1.0},{1.0,1.0,1.0}}},0.006) end
do local a=np.array({1.0},"float32"); local w=np.array(2.0,"float32");assert(not pcall(function() np.average(a,{axis=1,weights=w}) end)) end
do local a=np.flip(np.array({true},"bool"),1); local w=np.array({np.complex(0.0,0.0)},"complex128");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({1.0,1.0,2.0},"float64"); local w=np.array(-2,"int8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({np.complex(0.0,0.0),np.complex(-3.0,0.0)},"complex64"); local w=np.array({2},"int32");assert(not pcall(function() np.average(a,{axis={1},keepdims=true,weights=w}) end)) end
do local a=np.flip(np.array({{false,true},{true,false},{true,true}},"bool"),2); local w=np.array({{0.0,2.0},{1.0,0.0},{0.0,2.0}},"float32");local v,sw=np.average(a,{returned=true,weights=w});eq(v,0.4,0.006);eq(sw,5.0,0.006) end
do local a=np.flip(np.array({0},"uint8"),1); local w=np.array({true,true},"bool");assert(not pcall(function() np.average(a,{axis={1},returned=true,weights=w}) end)) end
do local a=np.transpose(np.array({{0}},"int32")); local v=np.average(a);eq(v,0.0,0.006) end
do local a=np.transpose(np.array({{np.complex(0.0,2.0)}},"complex128")); local w=np.array({{0}},"uint8");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.zeros({2,0},"uint8"); local w=np.array({3},"int64");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.flip(np.array({np.complex(0.0,2.0),np.complex(1.0,0.0)},"complex128"),1); local w=np.array({3.0,1.0,1.0},"float64");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.array(-3.0,"float16"); local w=np.array(3,"int64");local v=np.average(a,{weights=w});eq(v,-3.0,0.006) end
do local a=np.flip(np.array({4,-3},"int32"),1); local v,sw=np.average(a,{axis=1,returned=true});eq(v,0.5,0.006);eq(sw,2.0,0.006) end
do local a=np.flip(np.array({{false},{true}},"bool"),2); local w=np.array({{-1},{-2}},"int64");local v=np.average(a,{axis=2,keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{-0.0},{1.0}},0.006) end
do local a=np.transpose(np.array({{{1.0,2.0,2.0},{1.0,2.0,0.0}},{{0.0,-3.0,2.0},{4.0,-3.0,0.0}}},"float64")); local w=np.array(np.complex(3.0,2.0),"complex64");assert(not pcall(function() np.average(a,{axis=1,weights=w}) end)) end
do local a=np.transpose(np.array({{4,0},{0,2},{0,0}},"uint8")); local w=np.array({{1,-1,0},{2,1,0}},"int64");local v=np.average(a,{axis={1,2},weights=w});eq(v,2.0,0.006) end
do local a=np.array({-3,1},"int32"); local v=np.average(a,{axis={1}});eq(v,-1.0,0.006) end
do local a=np.transpose(np.array({{np.complex(0.0,0.0)}},"complex64")); local w=np.array(2.0,"float32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array(0.0,"float64"); local w=np.array({0,1},"int32");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.transpose(np.array({{np.complex(1.0,2.0)},{np.complex(2.0,0.0)}},"complex64")); local w=np.array({{3.0,2.0}},"float32");local v=np.average(a,{axis=1,weights=w});assert(v.dtype=="complex64")
eq(v:tolist(),{np.complex(1.0,2.0),np.complex(2.0,0.0)},0.006) end
do local a=np.array({0,2,2},"uint8"); local v=np.average(a,{axis={1}});eq(v,1.3333333333333333,0.006) end
do local a=np.array({4},"int32"); local w=np.array({2},"uint8");local v=np.average(a,{axis={1},weights=w});eq(v,4.0,0.006) end
do local a=np.array({1},"int8"); local w=np.array(np.complex(-1.0,0.0),"complex128");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({{1.0,0.0,0.0},{1.0,1.0,0.0}},"float64"),2); local w=np.array({{0,2,0},{1,1,1}},"int8");local v=np.average(a,{keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{0.4}},0.006) end
do local a=np.array({0.0},"float32"); local w=np.array({3.0,1.0},"float16");assert(not pcall(function() np.average(a,{axis={},returned=true,weights=w}) end)) end
do local a=np.array({1},"int64"); local w=np.array(false,"bool");assert(not pcall(function() np.average(a,{axis=1,weights=w}) end)) end
do local a=np.array({{true},{true}},"bool"); local v,sw=np.average(a,{axis={1,2},returned=true});eq(v,1.0,0.006);eq(sw,2.0,0.006) end
do local a=np.zeros({2,0},"complex128"); local w=np.array({2,-2,2},"int32");assert(not pcall(function() np.average(a,{axis={},keepdims=true,weights=w}) end)) end
do local a=np.zeros({0,3},"float32"); local w=np.zeros({0,3},"int64");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.zeros({0},"float64"); local w=np.zeros({0},"uint8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({{np.complex(1.0,0.0)}},"complex64"),2); local w=np.array({1,0,1},"int64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.zeros({0},"float32"); local w=np.array(3.0,"float64");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{},0.006) end
do local a=np.transpose(np.zeros({0,3},"int8")); local w=np.array(0.0,"float16");assert(not pcall(function() np.average(a,{axis={},returned=true,weights=w}) end)) end
do local a=np.array({0},"int8"); local w=np.array({np.complex(0.0,0.0)},"complex128");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({{-3}},"int32"),2); local v=np.average(a,{axis={}});assert(v.dtype=="float64")
eq(v:tolist(),{{-3.0}},0.006) end
do local a=np.array({{0}},"int64"); local w=np.array({0,0},"uint8");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.zeros({0,3},"complex128"); local v=np.average(a,{keepdims=true});assert(v.dtype=="complex128")
eq(v:tolist(),{{np.complex((0/0),(0/0))}},2e-06) end
do local a=np.array({{4.0}},"float64"); local w=np.array(2,"uint8");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.transpose(np.zeros({2,0},"complex128")); local w=np.array(2,"int8");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.zeros({2,0},"int8"); local w=np.array({2,-1,1},"int32");assert(not pcall(function() np.average(a,{axis={1,2},returned=true,weights=w}) end)) end
do local a=np.transpose(np.array({{{0,0,0},{2,4,2}},{{4,0,0},{1,2,4}}},"int8")); local w=np.array({{{3.0,-2.0},{1.0,1.0}},{{3.0,2.0},{-2.0,-2.0}},{{-1.0,0.0},{2.0,2.0}}},"float32");local v,sw=np.average(a,{keepdims=true,returned=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{{-0.7142857142857143}}},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{{{7.0}}},0.006) end
do local a=np.zeros({0,3},"bool"); local w=np.zeros({0,3},"complex128");local v,sw=np.average(a,{axis={},keepdims=true,returned=true,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{},2e-06);assert(sw.dtype=="complex128")
eq(sw:tolist(),{},2e-06) end
do local a=np.array({{2,-3},{2,0},{-3,0}},"int8"); local w=np.array({{2.0,-1.0},{-1.0,1.0},{3.0,2.0}},"float16");assert(not pcall(function() np.average(a,{axis=2,returned=true,weights=w}) end)) end
do local a=np.array({{2,0,-3}},"int64"); local w=np.array({{true,true,true}},"bool");local v=np.average(a,{weights=w});eq(v,-0.3333333333333333,0.006) end
do local a=np.zeros({0},"float64"); local w=np.zeros({0},"bool");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{},0.006) end
do local a=np.flip(np.array({{0,1},{2,4},{2,0}},"int64"),2); local w=np.array({np.complex(3.0,2.0),np.complex(3.0,0.0)},"complex64");local v=np.average(a,{axis=2,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{np.complex(0.5499999999999999,0.15),np.complex(3.1,0.3),np.complex(0.8999999999999999,-0.3)},2e-06) end
do local a=np.flip(np.array({{2.0,1.0},{0.0,-3.0},{1.0,-3.0}},"float64"),2); local w=np.array(-2,"int32");assert(not pcall(function() np.average(a,{keepdims=true,returned=true,weights=w}) end)) end
do local a=np.zeros({2,0},"float32"); local v,sw=np.average(a,{returned=true});eq(v,(0/0),0.006);eq(sw,0.0,0.006) end
do local a=np.zeros({0},"complex128"); local w=np.array(np.complex(2.0,0.0),"complex64");assert(not pcall(function() np.average(a,{axis=1,weights=w}) end)) end
do local a=np.transpose(np.array({{{2,2,0},{4,0,2}},{{0,4,-3},{1,0,2}}},"int64")); local w=np.array(2,"int32");local v,sw=np.average(a,{axis={},returned=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{{2.0,0.0},{4.0,1.0}},{{2.0,4.0},{0.0,0.0}},{{0.0,-3.0},{2.0,2.0}}},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{{{2.0,2.0},{2.0,2.0}},{{2.0,2.0},{2.0,2.0}},{{2.0,2.0},{2.0,2.0}}},0.006) end
do local a=np.array({np.complex(-3.0,0.0)},"complex64"); local w=np.array({-2},"int8");local v=np.average(a,{weights=w});eq(v,np.complex(-3.0,-0.0),0.006) end
do local a=np.array({{np.complex(0.0,0.0)},{np.complex(2.0,0.0)}},"complex128"); local w=np.array({{np.complex(0.0,2.0)},{np.complex(-1.0,0.0)}},"complex128");local v=np.average(a,{axis=1,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{np.complex(0.4,0.8)},2e-06) end
do local a=np.array({{np.complex(0.0,0.0),np.complex(2.0,0.0),np.complex(0.0,0.0)}},"complex64"); local w=np.array({true,true},"bool");assert(not pcall(function() np.average(a,{axis=2,keepdims=true,weights=w}) end)) end
do local a=np.array({{1,1},{4,-3},{1,1}},"int64"); local w=np.array({{0,1},{2,1},{0,2}},"uint8");local v=np.average(a,{axis={1,2},weights=w});eq(v,1.3333333333333333,0.006) end
do local a=np.array(4,"int8"); local w=np.array(np.complex(-2.0,0.0),"complex128");local v=np.average(a,{axis={},keepdims=true,weights=w});eq(v,np.complex(4.0,-0.0),2e-06) end
do local a=np.flip(np.array({{1,4},{2,0},{-3,4}},"int8"),2); local w=np.array({0,0,3},"int32");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.flip(np.array({2.0,0.0},"float16"),1); local v=np.average(a);eq(v,1.0,0.006) end
do local a=np.array({{0,4,0},{0,0,4}},"uint8"); local w=np.array({{true,true,false},{true,true,true}},"bool");local v=np.average(a,{axis={1,2},weights=w});eq(v,1.6,0.006) end
do local a=np.transpose(np.array({{0},{0}},"int64")); local v=np.average(a,{axis={1,2}});eq(v,0.0,0.006) end
do local a=np.zeros({0},"complex128"); local w=np.zeros({0},"float16");assert(not pcall(function() np.average(a,{axis={1},returned=true,weights=w}) end)) end
do local a=np.array({{0,1},{-3,1},{4,0}},"int8"); local w=np.array({{3.0,3.0},{0.0,2.0},{1.0,-2.0}},"float32");local v,sw=np.average(a,{axis={1,2},returned=true,weights=w});eq(v,1.2857142857142858,0.006);eq(sw,7.0,0.006) end
do local a=np.flip(np.array({{4}},"int8"),2); local w=np.array(np.complex(2.0,0.0),"complex64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.zeros({2,0},"float32"); local w=np.array({-2.0,0.0,3.0},"float16");assert(not pcall(function() np.average(a,{axis={1,2},keepdims=true,returned=true,weights=w}) end)) end
do local a=np.flip(np.array({{1,2,0}},"int8"),2); local w=np.array({{-2,3,1}},"int32");local v=np.average(a,{weights=w});eq(v,3.5,0.006) end
do local a=np.array({0,1,1},"int32"); local w=np.array({-2.0,1.0,0.0,-1.0},"float16");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{{true,true,true},{false,true,false}},{{true,false,false},{true,true,true}}},"bool"); local w=np.array({-2,0,-1},"int8");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.zeros({2,0},"int32"); assert(not pcall(function() np.average(a,{axis={}}) end)) end
do local a=np.array({{np.complex(0.0,0.0)},{np.complex(-3.0,2.0)}},"complex128"); local w=np.array({1,1},"int64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({0,0},"uint8"),1); local w=np.array({-2,3},"int64");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{-0.0,0.0},0.006) end
do local a=np.array({1,1},"uint8"); local w=np.array({false,true,false},"bool");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{true}},"bool"); local w=np.array({3.0,0.0},"float32");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.transpose(np.array({{np.complex(2.0,2.0)}},"complex128")); local v=np.average(a,{axis={}});assert(v.dtype=="complex128")
eq(v:tolist(),{{np.complex(2.0,2.0)}},2e-06) end
do local a=np.transpose(np.array({{np.complex(4.0,0.0)},{np.complex(-3.0,0.0)}},"complex64")); local w=np.array({{np.complex(-1.0,0.0),np.complex(1.0,0.0)}},"complex128");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.flip(np.zeros({2,0},"int32"),2); local w=np.zeros({2,0},"int32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({4.0},"float64"); local w=np.array({np.complex(-1.0,0.0),np.complex(-1.0,0.0)},"complex64");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.zeros({0},"complex128"); local v=np.average(a);eq(v,np.complex((0/0),(0/0)),2e-06) end
do local a=np.array(0,"uint8"); local w=np.array(0,"uint8");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.zeros({0},"float64"); local v=np.average(a,{axis=1});eq(v,(0/0),0.006) end
do local a=np.array({true,true,true},"bool"); local w=np.array({-2.0,2.0,3.0},"float32");local v,sw=np.average(a,{axis=1,returned=true,weights=w});eq(v,1.0,0.006);eq(sw,3.0,0.006) end
do local a=np.flip(np.zeros({2,0},"int64"),2); local w=np.array({3.0},"float32");assert(not pcall(function() np.average(a,{keepdims=true,returned=true,weights=w}) end)) end
do local a=np.transpose(np.zeros({0,3},"float64")); local w=np.zeros({3,0},"float32");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.array({false,true},"bool"); local w=np.array(np.complex(0.0,0.0),"complex128");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.array({{true,false,false},{false,true,true}},"bool"); local w=np.array({true,true,true},"bool");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.transpose(np.array({{1.0},{1.0}},"float16")); local w=np.array({{2,0}},"uint8");assert(not pcall(function() np.average(a,{axis=1,weights=w}) end)) end
do local a=np.array({-3.0,0.0,4.0},"float16"); local v,sw=np.average(a,{axis={},returned=true});assert(v.dtype=="float16")
eq(v:tolist(),{-3.0,0.0,4.0},0.006);assert(sw.dtype=="float16")
eq(sw:tolist(),{1.0,1.0,1.0},0.006) end
do local a=np.array(0.0,"float16"); local w=np.array(-2.0,"float64");local v=np.average(a,{keepdims=true,weights=w});eq(v,-0.0,0.006) end
do local a=np.array({{1},{1}},"int32"); local w=np.array({-1.0,-1.0,3.0},"float32");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.transpose(np.array({{{2,1,-3},{1,1,0}},{{1,4,0},{0,1,-3}}},"int32")); local w=np.array(3,"uint8");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.flip(np.array({2.0,-3.0},"float64"),1); local w=np.array(3,"int8");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.flip(np.array({{0}},"int8"),2); local w=np.array({-1.0,0.0},"float32");assert(not pcall(function() np.average(a,{axis={},returned=true,weights=w}) end)) end
do local a=np.flip(np.zeros({0,3},"bool"),2); local w=np.zeros({0,3},"int32");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.flip(np.array({{0,1},{0,2},{0,2}},"uint8"),2); local v=np.average(a,{axis={}});assert(v.dtype=="float64")
eq(v:tolist(),{{1.0,0.0},{2.0,0.0},{2.0,0.0}},0.006) end
do local a=np.flip(np.array({{1},{2}},"uint8"),2); local w=np.array({1,1,1},"uint8");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.array({{0.0,1.0,0.0}},"float16"); local w=np.array(1,"int32");assert(not pcall(function() np.average(a,{axis=1,keepdims=true,weights=w}) end)) end
do local a=np.transpose(np.array({{np.complex(4.0,0.0)},{np.complex(1.0,0.0)}},"complex128")); local w=np.array({{3,1}},"uint8");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{{np.complex(4.0,0.0),np.complex(1.0,0.0)}},2e-06) end
do local a=np.transpose(np.array({{{0.0,1.0,4.0},{4.0,-3.0,0.0}},{{0.0,-3.0,2.0},{1.0,0.0,0.0}}},"float32")); local w=np.array({0,0,1},"uint8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.zeros({0},"complex64"); local w=np.zeros({0},"int8");local v,sw=np.average(a,{axis={},keepdims=true,returned=true,weights=w});assert(v.dtype=="complex64")
eq(v:tolist(),{},0.006);assert(sw.dtype=="complex64")
eq(sw:tolist(),{},0.006) end
do local a=np.zeros({0},"int32"); local w=np.zeros({0},"bool");assert(not pcall(function() np.average(a,{axis=1,keepdims=true,returned=true,weights=w}) end)) end
do local a=np.flip(np.array({{4,0,4}},"int32"),2); local w=np.array({1,-1},"int8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.zeros({0,3},"uint8"); local w=np.zeros({0,3},"uint8");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{},0.006) end
do local a=np.transpose(np.array({{2,1,0},{0,2,2}},"uint8")); local w=np.array({1,2,1,1},"uint8");assert(not pcall(function() np.average(a,{axis=2,weights=w}) end)) end
do local a=np.transpose(np.array({{-3.0,0.0,2.0},{2.0,4.0,2.0}},"float64")); local w=np.array({{np.complex(-1.0,0.0),np.complex(-1.0,0.0)},{np.complex(-1.0,0.0),np.complex(3.0,0.0)},{np.complex(2.0,0.0),np.complex(3.0,0.0)}},"complex64");local v=np.average(a,{axis=2,keepdims=true,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{{np.complex(-0.5,-0.0)},{np.complex(6.0,0.0)},{np.complex(2.0,0.0)}},2e-06) end
do local a=np.flip(np.zeros({0},"float16"),1); local v=np.average(a,{axis=1});eq(v,(0/0),0.006) end
do local a=np.array({0},"uint8"); local w=np.array({-2,-1},"int32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{np.complex(2.0,2.0),np.complex(0.0,0.0)},{np.complex(1.0,2.0),np.complex(2.0,0.0)},{np.complex(0.0,2.0),np.complex(2.0,0.0)}},"complex128"); local w=np.array({np.complex(0.0,2.0),np.complex(1.0,0.0)},"complex64");assert(not pcall(function() np.average(a,{axis={},returned=true,weights=w}) end)) end
do local a=np.array({{np.complex(2.0,2.0),np.complex(1.0,0.0),np.complex(1.0,0.0)}},"complex64"); local w=np.array({np.complex(-1.0,2.0),np.complex(0.0,2.0)},"complex64");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.transpose(np.array({{{2,0,1},{1,4,0}},{{2,1,0},{0,0,0}}},"uint8")); local w=np.array({0.0,2.0,-1.0,3.0},"float32");assert(not pcall(function() np.average(a,{axis=3,keepdims=true,weights=w}) end)) end
do local a=np.flip(np.zeros({2,0},"int32"),2); local w=np.array({np.complex(-2.0,2.0),np.complex(0.0,0.0),np.complex(1.0,0.0)},"complex64");assert(not pcall(function() np.average(a,{axis={1,2},returned=true,weights=w}) end)) end
do local a=np.array({{{0.0,2.0,0.0},{4.0,0.0,-3.0}},{{1.0,0.0,1.0},{4.0,0.0,0.0}}},"float64"); local w=np.array({{{np.complex(0.0,2.0),np.complex(-2.0,2.0),np.complex(-1.0,0.0)},{np.complex(3.0,2.0),np.complex(-2.0,0.0),np.complex(2.0,0.0)}},{{np.complex(-1.0,2.0),np.complex(-1.0,0.0),np.complex(1.0,0.0)},{np.complex(1.0,0.0),np.complex(-2.0,0.0),np.complex(-1.0,0.0)}}},"complex128");local v=np.average(a,{weights=w});eq(v,np.complex(1.2876712328767121,-1.2328767123287672),2e-06) end
do local a=np.flip(np.array({{np.complex(-3.0,2.0),np.complex(-3.0,0.0),np.complex(4.0,0.0)}},"complex64"),2); local v=np.average(a,{axis={1,2}});eq(v,np.complex(-0.6666666865348816,0.6666666865348816),0.006) end
do local a=np.array({{2}},"uint8"); local w=np.array({{np.complex(-2.0,0.0)}},"complex128");local v,sw=np.average(a,{axis={1,2},keepdims=true,returned=true,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{{np.complex(2.0,-0.0)}},2e-06);assert(sw.dtype=="complex128")
eq(sw:tolist(),{{np.complex(-2.0,0.0)}},2e-06) end
do local a=np.array({0,0,0},"int64"); local v,sw=np.average(a,{axis={},returned=true});assert(v.dtype=="float64")
eq(v:tolist(),{0.0,0.0,0.0},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{1.0,1.0,1.0},0.006) end
do local a=np.flip(np.array({0.0},"float64"),1); local w=np.array(np.complex(2.0,2.0),"complex128");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.array(-3.0,"float32"); local w=np.array(3.0,"float32");local v=np.average(a,{axis={},weights=w});eq(v,-3.0,0.006) end
do local a=np.transpose(np.array({{0,2,4}},"int32")); local w=np.array({1,-1,1},"int8");local v,sw=np.average(a,{axis=1,returned=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{2.0},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{1.0},0.006) end
do local a=np.array({{0,0},{2,1},{0,4}},"int64"); local w=np.array({{0.0,3.0},{1.0,2.0},{2.0,-1.0}},"float32");local v=np.average(a,{weights=w});eq(v,0.0,0.006) end
do local a=np.array(-3,"int32"); local w=np.array(2.0,"float32");local v=np.average(a,{weights=w});eq(v,-3.0,0.006) end
do local a=np.array({{{2,1,1},{1,1,0}},{{0,4,2},{-3,0,0}}},"int32"); local v=np.average(a);eq(v,0.75,0.006) end
do local a=np.array({{true,true,false},{false,true,true}},"bool"); local v=np.average(a,{keepdims=true});assert(v.dtype=="float64")
eq(v:tolist(),{{0.6666666666666666}},0.006) end
do local a=np.array(0,"int8"); local w=np.array({2.0,0.0},"float32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{0,2,-3},{-3,4,0}},"int64"); local w=np.array(3.0,"float32");local v,sw=np.average(a,{axis={},returned=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{0.0,2.0,-3.0},{-3.0,4.0,0.0}},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{{3.0,3.0,3.0},{3.0,3.0,3.0}},0.006) end
do local a=np.zeros({2,0},"int64"); local w=np.zeros({2,0},"int64");assert(not pcall(function() np.average(a,{axis=2,keepdims=true,weights=w}) end)) end
do local a=np.zeros({0,3},"int32"); local v=np.average(a);eq(v,(0/0),0.006) end
do local a=np.array(0,"int8"); local v=np.average(a,{axis={},keepdims=true});eq(v,0.0,0.006) end
do local a=np.zeros({2,0},"float64"); local w=np.array({0},"int8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.zeros({0,3},"complex64"); local v=np.average(a,{axis={1,2},keepdims=true});assert(v.dtype=="complex64")
eq(v:tolist(),{{np.complex((0/0),(0/0))}},0.006) end
do local a=np.flip(np.zeros({2,0},"float16"),2); local v=np.average(a,{axis={1,2}});eq(v,(0/0),0.006) end
do local a=np.array({{4.0,1.0,4.0}},"float16"); local v=np.average(a,{axis=2,keepdims=true});assert(v.dtype=="float16")
eq(v:tolist(),{{3.0}},0.006) end
do local a=np.array(np.complex(2.0,0.0),"complex128"); local v=np.average(a);eq(v,np.complex(2.0,0.0),2e-06) end
do local a=np.flip(np.zeros({0,3},"int64"),2); local w=np.array({0.0},"float64");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.array({{{-3,0,4},{2,0,-3}},{{0,0,-3},{2,4,4}}},"int8"); local v=np.average(a);eq(v,0.5833333333333334,0.006) end
do local a=np.array({{0.0,-3.0,0.0},{1.0,4.0,0.0}},"float32"); local w=np.array(2,"int8");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.flip(np.array({{4,0,1},{2,4,4}},"int64"),2); local v=np.average(a,{axis=2});assert(v.dtype=="float64")
eq(v:tolist(),{1.6666666666666667,3.3333333333333335},0.006) end
do local a=np.transpose(np.zeros({2,0},"int32")); local w=np.array({3},"uint8");assert(not pcall(function() np.average(a,{keepdims=true,returned=true,weights=w}) end)) end
do local a=np.array({{true},{true}},"bool"); local v=np.average(a,{axis=1,keepdims=true});assert(v.dtype=="float64")
eq(v:tolist(),{{1.0}},0.006) end
do local a=np.array(1,"int64"); local v,sw=np.average(a,{axis={},keepdims=true,returned=true});eq(v,1.0,0.006);eq(sw,1.0,0.006) end
do local a=np.array({{{np.complex(0.0,0.0),np.complex(-3.0,0.0),np.complex(1.0,2.0)},{np.complex(0.0,0.0),np.complex(-3.0,0.0),np.complex(2.0,0.0)}},{{np.complex(2.0,2.0),np.complex(0.0,0.0),np.complex(2.0,0.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(1.0,0.0)}}},"complex128"); local w=np.array({-2.0,0.0,2.0},"float64");assert(not pcall(function() np.average(a,{axis=2,keepdims=true,weights=w}) end)) end
do local a=np.array({{false,true,true}},"bool"); local w=np.array(np.complex(3.0,0.0),"complex128");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.zeros({0},"float16"); local w=np.zeros({0},"complex64");assert(not pcall(function() np.average(a,{axis=1,keepdims=true,weights=w}) end)) end
do local a=np.array({{2}},"int32"); local w=np.array({np.complex(1.0,2.0),np.complex(-1.0,2.0)},"complex64");assert(not pcall(function() np.average(a,{axis=1,returned=true,weights=w}) end)) end
do local a=np.array({{{1.0,4.0,2.0},{2.0,0.0,-3.0}},{{2.0,4.0,4.0},{0.0,0.0,0.0}}},"float16"); local v=np.average(a);eq(v,1.3330078125,0.006) end
do local a=np.array({2,2},"int32"); local w=np.array({0,0},"uint8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array(-3,"int64"); local w=np.array(3.0,"float32");local v=np.average(a,{axis={},weights=w});eq(v,-3.0,0.006) end
do local a=np.array(1,"int64"); local w=np.array(-2,"int64");local v=np.average(a,{weights=w});eq(v,1.0,0.006) end
do local a=np.flip(np.array({np.complex(4.0,0.0)},"complex64"),1); local w=np.array(-1.0,"float16");assert(not pcall(function() np.average(a,{axis={1},weights=w}) end)) end
do local a=np.zeros({0,3},"int8"); assert(not pcall(function() np.average(a,{axis={}}) end)) end
do local a=np.array(4.0,"float32"); local w=np.array(0.0,"float32");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.array({{np.complex(4.0,2.0)}},"complex64"); local v=np.average(a,{keepdims=true});assert(v.dtype=="complex64")
eq(v:tolist(),{{np.complex(4.0,2.0)}},0.006) end
do local a=np.array(np.complex(0.0,0.0),"complex64"); local w=np.array({np.complex(-2.0,0.0),np.complex(2.0,0.0)},"complex64");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.array({0,0},"uint8"); local w=np.array(1.0,"float32");assert(not pcall(function() np.average(a,{axis={1},weights=w}) end)) end
do local a=np.flip(np.array({{0,0,4},{4,-3,0}},"int64"),2); local w=np.array({3,2,2},"uint8");assert(not pcall(function() np.average(a,{axis={1,2},weights=w}) end)) end
do local a=np.transpose(np.array({{np.complex(1.0,0.0)}},"complex64")); local w=np.array({3.0,3.0},"float64");assert(not pcall(function() np.average(a,{axis=1,weights=w}) end)) end
do local a=np.transpose(np.array({{true},{true}},"bool")); local w=np.array({-1,1,-2},"int64");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.array({2.0},"float16"); local w=np.array(-1,"int32");assert(not pcall(function() np.average(a,{axis={1},weights=w}) end)) end
do local a=np.array({{np.complex(0.0,0.0),np.complex(2.0,0.0)},{np.complex(4.0,0.0),np.complex(0.0,0.0)},{np.complex(0.0,0.0),np.complex(2.0,0.0)}},"complex128"); local w=np.array({2.0,-1.0,0.0,3.0},"float32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{-3},{4}},"int32"); local w=np.array({3},"int8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({2,-3},"int8"); local v=np.average(a,{axis={}});assert(v.dtype=="float64")
eq(v:tolist(),{2.0,-3.0},0.006) end
do local a=np.array({{{4,2,0},{4,2,4}},{{4,2,1},{4,0,2}}},"uint8"); local v=np.average(a,{axis={}});assert(v.dtype=="float64")
eq(v:tolist(),{{{4.0,2.0,0.0},{4.0,2.0,4.0}},{{4.0,2.0,1.0},{4.0,0.0,2.0}}},0.006) end
do local a=np.flip(np.array({1},"int32"),1); local w=np.array({np.complex(-1.0,0.0),np.complex(-2.0,0.0),np.complex(3.0,0.0)},"complex64");assert(not pcall(function() np.average(a,{axis={1},weights=w}) end)) end
do local a=np.transpose(np.array({{0.0,2.0},{-3.0,-3.0},{0.0,4.0}},"float32")); local w=np.array(0,"int32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.zeros({2,0},"float64"); local w=np.array({np.complex(2.0,0.0),np.complex(2.0,0.0),np.complex(0.0,0.0)},"complex64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.zeros({0,3},"complex64"); local w=np.zeros({0,3},"bool");assert(not pcall(function() np.average(a,{axis={1,2},returned=true,weights=w}) end)) end
do local a=np.zeros({2,0},"complex64"); local w=np.array({2.0,1.0,0.0},"float64");assert(not pcall(function() np.average(a,{axis=1,weights=w}) end)) end
do local a=np.array({{false,true},{true,true},{true,true}},"bool"); local w=np.array({{1,1},{-2,2},{-2,-2}},"int32");local v=np.average(a,{keepdims=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{1.5}},0.006) end
do local a=np.array({2,2,1},"int8"); local w=np.array(3,"uint8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.zeros({0,3},"float64"); local v=np.average(a,{axis=1,keepdims=true});assert(v.dtype=="float64")
eq(v:tolist(),{{(0/0),(0/0),(0/0)}},0.006) end
do local a=np.zeros({2,0},"int8"); local w=np.zeros({0},"uint8");assert(not pcall(function() np.average(a,{axis=2,weights=w}) end)) end
do local a=np.flip(np.array({{4},{0}},"int64"),2); local w=np.array({{np.complex(-2.0,0.0)},{np.complex(3.0,0.0)}},"complex128");local v=np.average(a,{axis=1,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{np.complex(-8.0,0.0)},2e-06) end
do local a=np.transpose(np.array({{np.complex(-3.0,0.0)}},"complex64")); local v=np.average(a);eq(v,np.complex(-3.0,0.0),0.006) end
do local a=np.flip(np.array({{np.complex(1.0,2.0),np.complex(-3.0,2.0),np.complex(-3.0,0.0)},{np.complex(-3.0,2.0),np.complex(2.0,2.0),np.complex(2.0,2.0)}},"complex128"),2); local v=np.average(a);eq(v,np.complex(-0.6666666666666666,1.6666666666666665),2e-06) end
do local a=np.array({2},"uint8"); local w=np.array({0},"int32");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.flip(np.array({0.0,0.0,-3.0},"float16"),1); local w=np.array({3.0,0.0,-2.0},"float16");assert(not pcall(function() np.average(a,{axis={},returned=true,weights=w}) end)) end
do local a=np.array({1.0,0.0,4.0},"float16"); local w=np.array({-1.0,0.0,1.0},"float16");assert(not pcall(function() np.average(a,{axis={1},weights=w}) end)) end
do local a=np.flip(np.array({{-3,1,4},{2,4,4}},"int32"),2); local v,sw=np.average(a,{axis=1,keepdims=true,returned=true});assert(v.dtype=="float64")
eq(v:tolist(),{{4.0,2.5,-0.5}},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{{2.0,2.0,2.0}},0.006) end
do local a=np.flip(np.array({{np.complex(0.0,0.0),np.complex(-3.0,2.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex(2.0,2.0),np.complex(1.0,0.0)}},"complex64"),2); local v=np.average(a,{keepdims=true});assert(v.dtype=="complex64")
eq(v:tolist(),{{np.complex(0.0,0.6666666865348816)}},0.006) end
do local a=np.array({{true}},"bool"); local w=np.array({{0}},"uint8");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.flip(np.array({{-3.0,2.0,0.0}},"float64"),2); local w=np.array({np.complex(1.0,0.0)},"complex128");assert(not pcall(function() np.average(a,{axis={},returned=true,weights=w}) end)) end
do local a=np.array({{np.complex(0.0,0.0)},{np.complex(0.0,2.0)}},"complex128"); local w=np.array({{1.0},{2.0}},"float16");local v,sw=np.average(a,{returned=true,weights=w});eq(v,np.complex(0.0,1.3333333333333333),2e-06);eq(sw,np.complex(3.0,0.0),2e-06) end
do local a=np.array(2.0,"float16"); local w=np.array({1,2,-1},"int32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({4.0,-3.0,1.0},"float64"); local w=np.array({-2.0,1.0,0.0},"float32");local v=np.average(a,{weights=w});eq(v,11.0,0.006) end
do local a=np.transpose(np.zeros({0,3},"int32")); local v=np.average(a,{axis={1,2},keepdims=true});assert(v.dtype=="float64")
eq(v:tolist(),{{(0/0)}},0.006) end
do local a=np.flip(np.array({-3.0,4.0,2.0},"float32"),1); local w=np.array({2.0,-1.0,0.0},"float16");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.array(np.complex(2.0,0.0),"complex64"); local w=np.array({2.0,2.0,0.0},"float32");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{2.0,4.0,4.0},{4.0,2.0,1.0}},"float64"); local w=np.array({{true,true,true},{true,true,true}},"bool");local v,sw=np.average(a,{axis={1,2},returned=true,weights=w});eq(v,2.8333333333333335,0.006);eq(sw,6.0,0.006) end
do local a=np.array({{np.complex(-3.0,0.0),np.complex(4.0,0.0),np.complex(0.0,0.0)},{np.complex(4.0,2.0),np.complex(0.0,0.0),np.complex(-3.0,2.0)}},"complex128"); local w=np.array(1,"int32");assert(not pcall(function() np.average(a,{axis=2,weights=w}) end)) end
do local a=np.zeros({0},"int8"); local v,sw=np.average(a,{axis={1},keepdims=true,returned=true});assert(v.dtype=="float64")
eq(v:tolist(),{(0/0)},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{0.0},0.006) end
do local a=np.transpose(np.array({{np.complex(1.0,2.0),np.complex(4.0,0.0),np.complex(0.0,0.0)},{np.complex(2.0,0.0),np.complex(2.0,2.0),np.complex(-3.0,2.0)}},"complex64")); local v=np.average(a,{keepdims=true});assert(v.dtype=="complex64")
eq(v:tolist(),{{np.complex(1.0,1.0)}},0.006) end
do local a=np.array({{0,1},{2,1},{1,4}},"uint8"); local w=np.array({0,1,0,3},"int8");assert(not pcall(function() np.average(a,{axis={1,2},returned=true,weights=w}) end)) end
do local a=np.transpose(np.array({{-3.0,4.0,0.0},{2.0,1.0,2.0}},"float16")); local w=np.array({{1.0,-2.0},{-1.0,3.0},{0.0,-1.0}},"float16");assert(not pcall(function() np.average(a,{axis={1,2},returned=true,weights=w}) end)) end
do local a=np.zeros({0},"uint8"); local w=np.array(0,"int64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({{false,true},{false,true},{false,true}},"bool"); local w=np.array(false,"bool");assert(not pcall(function() np.average(a,{axis=1,weights=w}) end)) end
do local a=np.array({{1},{1}},"int8"); local w=np.array({3,-1},"int32");assert(not pcall(function() np.average(a,{returned=true,weights=w}) end)) end
do local a=np.array({{true},{true}},"bool"); local w=np.array({{np.complex(-2.0,0.0)},{np.complex(2.0,0.0)}},"complex64");local v=np.average(a,{axis={},keepdims=true,weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{{np.complex(1.0,-0.0)},{np.complex(1.0,0.0)}},2e-06) end
do local a=np.array({{np.complex(4.0,0.0),np.complex(1.0,2.0),np.complex(0.0,0.0)},{np.complex(0.0,0.0),np.complex(4.0,0.0),np.complex(2.0,0.0)}},"complex64"); local v=np.average(a);eq(v,np.complex(1.8333333730697632,0.3333333432674408),0.006) end
do local a=np.array({{false}},"bool"); local v=np.average(a,{axis={1,2},keepdims=true});assert(v.dtype=="float64")
eq(v:tolist(),{{0.0}},0.006) end
do local a=np.array({{2},{0}},"int8"); local w=np.array(3,"uint8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.zeros({2,0},"uint8"); assert(not pcall(function() np.average(a,{axis=1}) end)) end
do local a=np.array({{np.complex(1.0,0.0)}},"complex64"); local w=np.array({0},"int32");assert(not pcall(function() np.average(a,{axis={1,2},returned=true,weights=w}) end)) end
do local a=np.zeros({0},"complex64"); local w=np.array(3.0,"float32");assert(not pcall(function() np.average(a,{axis={1},keepdims=true,weights=w}) end)) end
do local a=np.zeros({0,3},"float32"); local w=np.array(0,"int8");assert(not pcall(function() np.average(a,{axis={},weights=w}) end)) end
do local a=np.flip(np.array({-3,4,1},"int32"),1); local w=np.array({0.0,3.0,0.0},"float64");local v=np.average(a,{weights=w});eq(v,4.0,0.006) end
do local a=np.array({{{4.0,4.0,0.0},{2.0,0.0,0.0}},{{0.0,1.0,4.0},{1.0,2.0,1.0}}},"float16"); local v=np.average(a,{axis={1,2,3},keepdims=true});assert(v.dtype=="float16")
eq(v:tolist(),{{{1.5830078125}}},0.006) end
do local a=np.array({0.0,1.0,1.0},"float16"); local w=np.array({1.0,1.0,-2.0},"float64");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{0.0,1.0,1.0},0.006) end
do local a=np.array(np.complex(0.0,2.0),"complex128"); local v=np.average(a);eq(v,np.complex(0.0,2.0),2e-06) end
do local a=np.flip(np.array({{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(1.0,2.0)},{np.complex(0.0,0.0),np.complex(0.0,2.0),np.complex(0.0,2.0)}},"complex128"),2); local w=np.array({{1.0,-2.0,1.0},{0.0,2.0,-1.0}},"float64");local v=np.average(a,{axis={1,2},weights=w});eq(v,np.complex(1.0,6.0),2e-06) end
do local a=np.flip(np.array({1,2},"int64"),1); local w=np.array({3,3},"int8");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{2.0,1.0},0.006) end
do local a=np.array(4,"int8"); local w=np.array({-1,3},"int8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.zeros({0},"int32"); assert(not pcall(function() np.average(a,{axis={}}) end)) end
do local a=np.array({{1}},"int8"); local w=np.array(2.0,"float16");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.array({{4,0},{2,2},{2,2}},"int64"); local w=np.array({1,1},"int8");assert(not pcall(function() np.average(a,{axis={},returned=true,weights=w}) end)) end
do local a=np.transpose(np.zeros({2,0},"complex128")); local w=np.zeros({0,2},"int64");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.array({2.0,0.0,-3.0},"float32"); local w=np.array({-1.0,3.0,-1.0},"float32");local v=np.average(a,{axis={1},weights=w});eq(v,1.0,0.006) end
do local a=np.zeros({0},"bool"); local w=np.array({np.complex(-2.0,2.0)},"complex128");assert(not pcall(function() np.average(a,{keepdims=true,weights=w}) end)) end
do local a=np.array({{{-3,1,4},{0,0,1}},{{2,0,1},{1,2,0}}},"int32"); local v=np.average(a,{axis={}});assert(v.dtype=="float64")
eq(v:tolist(),{{{-3.0,1.0,4.0},{0.0,0.0,1.0}},{{2.0,0.0,1.0},{1.0,2.0,0.0}}},0.006) end
do local a=np.flip(np.array({{{2,1,-3},{2,0,0}},{{1,2,1},{-3,1,0}}},"int64"),3); local w=np.array({np.complex(-2.0,2.0),np.complex(2.0,2.0),np.complex(2.0,2.0)},"complex128");assert(not pcall(function() np.average(a,{axis={1,2,3},weights=w}) end)) end
do local a=np.flip(np.array({np.complex(4.0,0.0)},"complex128"),1); local v=np.average(a);eq(v,np.complex(4.0,0.0),2e-06) end
do local a=np.array({{4.0}},"float16"); local w=np.array({{3}},"int64");local v=np.average(a,{weights=w});eq(v,4.0,0.006) end
do local a=np.array({np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(0.0,0.0)},"complex128"); local w=np.array(0,"int64");assert(not pcall(function() np.average(a,{axis=1,returned=true,weights=w}) end)) end
do local a=np.array({1.0,-3.0,-3.0},"float64"); local w=np.array(0,"uint8");assert(not pcall(function() np.average(a,{axis=1,weights=w}) end)) end
do local a=np.transpose(np.array({{np.complex(-3.0,0.0)}},"complex64")); local w=np.array({0},"int8");assert(not pcall(function() np.average(a,{axis=2,keepdims=true,weights=w}) end)) end
do local a=np.array({2,4,2},"int8"); local w=np.array({3,2,2},"uint8");local v,sw=np.average(a,{axis={1},returned=true,weights=w});eq(v,2.5714285714285716,0.006);eq(sw,7.0,0.006) end
do local a=np.flip(np.array({{{np.complex(4.0,2.0),np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex(4.0,0.0),np.complex(2.0,0.0),np.complex(0.0,0.0)}},{{np.complex(0.0,0.0),np.complex(0.0,2.0),np.complex(0.0,0.0)},{np.complex(4.0,0.0),np.complex(1.0,0.0),np.complex(1.0,0.0)}}},"complex128"),3); local w=np.array(2,"int32");assert(not pcall(function() np.average(a,{axis={1,2,3},returned=true,weights=w}) end)) end
do local a=np.array({np.complex(2.0,0.0)},"complex64"); local w=np.array(-2,"int8");assert(not pcall(function() np.average(a,{weights=w}) end)) end
do local a=np.flip(np.array({{2,4},{0,4},{1,4}},"uint8"),2); local w=np.array({{np.complex(1.0,2.0),np.complex(-2.0,0.0)},{np.complex(-1.0,0.0),np.complex(0.0,0.0)},{np.complex(-1.0,2.0),np.complex(3.0,2.0)}},"complex128");local v,sw=np.average(a,{returned=true,weights=w});eq(v,np.complex(3.0,0.8333333333333333),2e-06);eq(sw,np.complex(0.0,6.0),2e-06) end
do local a=np.array({false,false,false},"bool"); local v,sw=np.average(a,{returned=true});eq(v,0.0,0.006);eq(sw,3.0,0.006) end
do local a=np.transpose(np.zeros({0,3},"complex128")); local w=np.zeros({3,0},"int32");local v=np.average(a,{axis={},weights=w});assert(v.dtype=="complex128")
eq(v:tolist(),{{},{},{}},2e-06) end
do local a=np.zeros({0,3},"float16"); local w=np.array({np.complex(1.0,0.0),np.complex(3.0,2.0),np.complex(1.0,2.0)},"complex64");assert(not pcall(function() np.average(a,{axis={},keepdims=true,returned=true,weights=w}) end)) end
do local a=np.transpose(np.array({{0.0,2.0},{1.0,1.0},{0.0,0.0}},"float16")); local w=np.array({{true,true,true},{false,true,true}},"bool");local v=np.average(a,{weights=w});eq(v,0.39990234375,0.006) end
do local a=np.array({4.0,0.0,0.0},"float64"); local w=np.array(-1,"int8");assert(not pcall(function() np.average(a,{axis=1,weights=w}) end)) end
do local a=np.zeros({0},"uint8"); local w=np.zeros({0},"complex128");assert(not pcall(function() np.average(a,{axis={1},weights=w}) end)) end
do local a=np.array({-3,1,2},"int32"); local w=np.array({2.0},"float64");assert(not pcall(function() np.average(a,{axis={},returned=true,weights=w}) end)) end
do local a=np.flip(np.zeros({0,3},"float32"),2); local w=np.zeros({0,3},"int32");assert(not pcall(function() np.average(a,{axis=1,weights=w}) end)) end
do local a=np.array({{1}},"int32"); local w=np.array({{-2.0}},"float32");local v,sw=np.average(a,{keepdims=true,returned=true,weights=w});assert(v.dtype=="float64")
eq(v:tolist(),{{1.0}},0.006);assert(sw.dtype=="float64")
eq(sw:tolist(),{{-2.0}},0.006) end
do local a=np.array({{{4,2,0},{1,4,2}},{{4,0,1},{4,0,4}}},"uint8"); local w=np.array({{{2,1,0},{2,3,-1}},{{3,1,-2},{3,3,0}}},"int32");local v=np.average(a,{axis={1,2,3},weights=w});eq(v,2.933333333333333,0.006) end
print('average differential: 1500 cases passed')
