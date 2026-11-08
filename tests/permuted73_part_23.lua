-- Frozen differential fixtures generated from real NumPy 2.3.5
local np=require("luaray_core")
assert(np._version=="0.101.0-dev")
local checks,cases=0,0
local function deep(a,b,desc)
    assert(type(a)==type(b),desc..': type mismatch: '..type(a)..' vs '..type(b))
    if type(a)=='table' then
        assert(#a==#b,desc..': length mismatch: '..#a..' vs '..#b)
        for i=1,#a do deep(a[i],b[i],desc..'['..i..']') end
    else
        assert(a==b,desc..': '..tostring(a)..' vs '..tostring(b))
    end
    checks=checks+1
end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"int32")
local before=x:tolist()
local y=r:permuted(x,nil)
deep(y.dtype,"int32","4294967297/(2, 3, 1, 2)/int32/plain/None/copy dtype")
deep(y:tolist(),{{{{6,2}},{{4,9}},{{7,1}}},{{{0,3}},{{5,11}},{{8,10}}}},"4294967297/(2, 3, 1, 2)/int32/plain/None/copy values")
deep(x:tolist(),{{{{0,1}},{{2,3}},{{4,5}}},{{{6,7}},{{8,9}},{{10,11}}}},"4294967297/(2, 3, 1, 2)/int32/plain/None/copy source")
deep(r:raw_hex(),"f3fe33f26b689233","4294967297/(2, 3, 1, 2)/int32/plain/None/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"int32")
local before=x:tolist()
local y=r:permuted(x,nil,x)
deep(y.dtype,"int32","4294967297/(2, 3, 1, 2)/int32/plain/None/out_same dtype")
deep(y:tolist(),{{{{6,2}},{{4,9}},{{7,1}}},{{{0,3}},{{5,11}},{{8,10}}}},"4294967297/(2, 3, 1, 2)/int32/plain/None/out_same values")
deep(x:tolist(),{{{{6,2}},{{4,9}},{{7,1}}},{{{0,3}},{{5,11}},{{8,10}}}},"4294967297/(2, 3, 1, 2)/int32/plain/None/out_same source")
assert(rawequal(y,x),"out must return identical ndarray")
deep(r:raw_hex(),"f3fe33f26b689233","4294967297/(2, 3, 1, 2)/int32/plain/None/out_same pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"int32")
local before=x:tolist()
local out=np.zeros({2,3,1,2},"int32")
local y=r:permuted(x,nil,out)
deep(y.dtype,"int32","4294967297/(2, 3, 1, 2)/int32/plain/None/out_new dtype")
deep(y:tolist(),{{{{6,2}},{{4,9}},{{7,1}}},{{{0,3}},{{5,11}},{{8,10}}}},"4294967297/(2, 3, 1, 2)/int32/plain/None/out_new values")
deep(x:tolist(),{{{{0,1}},{{2,3}},{{4,5}}},{{{6,7}},{{8,9}},{{10,11}}}},"4294967297/(2, 3, 1, 2)/int32/plain/None/out_new source")
assert(rawequal(y,out),"out must return identical ndarray")
deep(r:raw_hex(),"f3fe33f26b689233","4294967297/(2, 3, 1, 2)/int32/plain/None/out_new pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"int32")
local before=x:tolist()
local y=r:permuted(x,1)
deep(y.dtype,"int32","4294967297/(2, 3, 1, 2)/int32/plain/0/copy dtype")
deep(y:tolist(),{{{{0,1}},{{8,3}},{{10,11}}},{{{6,7}},{{2,9}},{{4,5}}}},"4294967297/(2, 3, 1, 2)/int32/plain/0/copy values")
deep(x:tolist(),{{{{0,1}},{{2,3}},{{4,5}}},{{{6,7}},{{8,9}},{{10,11}}}},"4294967297/(2, 3, 1, 2)/int32/plain/0/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/int32/plain/0/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"int32")
local before=x:tolist()
local y=r:permuted(x,1,x)
deep(y.dtype,"int32","4294967297/(2, 3, 1, 2)/int32/plain/0/out_same dtype")
deep(y:tolist(),{{{{0,1}},{{8,3}},{{10,11}}},{{{6,7}},{{2,9}},{{4,5}}}},"4294967297/(2, 3, 1, 2)/int32/plain/0/out_same values")
deep(x:tolist(),{{{{0,1}},{{8,3}},{{10,11}}},{{{6,7}},{{2,9}},{{4,5}}}},"4294967297/(2, 3, 1, 2)/int32/plain/0/out_same source")
assert(rawequal(y,x),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/int32/plain/0/out_same pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"int32")
local before=x:tolist()
local out=np.zeros({2,3,1,2},"int32")
local y=r:permuted(x,1,out)
deep(y.dtype,"int32","4294967297/(2, 3, 1, 2)/int32/plain/0/out_new dtype")
deep(y:tolist(),{{{{0,1}},{{8,3}},{{10,11}}},{{{6,7}},{{2,9}},{{4,5}}}},"4294967297/(2, 3, 1, 2)/int32/plain/0/out_new values")
deep(x:tolist(),{{{{0,1}},{{2,3}},{{4,5}}},{{{6,7}},{{8,9}},{{10,11}}}},"4294967297/(2, 3, 1, 2)/int32/plain/0/out_new source")
assert(rawequal(y,out),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/int32/plain/0/out_new pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"int32")
local before=x:tolist()
local y=r:permuted(x,4)
deep(y.dtype,"int32","4294967297/(2, 3, 1, 2)/int32/plain/3/copy dtype")
deep(y:tolist(),{{{{0,1}},{{2,3}},{{5,4}}},{{{6,7}},{{9,8}},{{11,10}}}},"4294967297/(2, 3, 1, 2)/int32/plain/3/copy values")
deep(x:tolist(),{{{{0,1}},{{2,3}},{{4,5}}},{{{6,7}},{{8,9}},{{10,11}}}},"4294967297/(2, 3, 1, 2)/int32/plain/3/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/int32/plain/3/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"int32")
local before=x:tolist()
local y=r:permuted(x,4,x)
deep(y.dtype,"int32","4294967297/(2, 3, 1, 2)/int32/plain/3/out_same dtype")
deep(y:tolist(),{{{{0,1}},{{2,3}},{{5,4}}},{{{6,7}},{{9,8}},{{11,10}}}},"4294967297/(2, 3, 1, 2)/int32/plain/3/out_same values")
deep(x:tolist(),{{{{0,1}},{{2,3}},{{5,4}}},{{{6,7}},{{9,8}},{{11,10}}}},"4294967297/(2, 3, 1, 2)/int32/plain/3/out_same source")
assert(rawequal(y,x),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/int32/plain/3/out_same pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"int32")
local before=x:tolist()
local out=np.zeros({2,3,1,2},"int32")
local y=r:permuted(x,4,out)
deep(y.dtype,"int32","4294967297/(2, 3, 1, 2)/int32/plain/3/out_new dtype")
deep(y:tolist(),{{{{0,1}},{{2,3}},{{5,4}}},{{{6,7}},{{9,8}},{{11,10}}}},"4294967297/(2, 3, 1, 2)/int32/plain/3/out_new values")
deep(x:tolist(),{{{{0,1}},{{2,3}},{{4,5}}},{{{6,7}},{{8,9}},{{10,11}}}},"4294967297/(2, 3, 1, 2)/int32/plain/3/out_new source")
assert(rawequal(y,out),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/int32/plain/3/out_new pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"int32")
local before=x:tolist()
local y=r:permuted(x,-1)
deep(y.dtype,"int32","4294967297/(2, 3, 1, 2)/int32/plain/-1/copy dtype")
deep(y:tolist(),{{{{0,1}},{{2,3}},{{5,4}}},{{{6,7}},{{9,8}},{{11,10}}}},"4294967297/(2, 3, 1, 2)/int32/plain/-1/copy values")
deep(x:tolist(),{{{{0,1}},{{2,3}},{{4,5}}},{{{6,7}},{{8,9}},{{10,11}}}},"4294967297/(2, 3, 1, 2)/int32/plain/-1/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/int32/plain/-1/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"int32")
local before=x:tolist()
local y=r:permuted(x,-1,x)
deep(y.dtype,"int32","4294967297/(2, 3, 1, 2)/int32/plain/-1/out_same dtype")
deep(y:tolist(),{{{{0,1}},{{2,3}},{{5,4}}},{{{6,7}},{{9,8}},{{11,10}}}},"4294967297/(2, 3, 1, 2)/int32/plain/-1/out_same values")
deep(x:tolist(),{{{{0,1}},{{2,3}},{{5,4}}},{{{6,7}},{{9,8}},{{11,10}}}},"4294967297/(2, 3, 1, 2)/int32/plain/-1/out_same source")
assert(rawequal(y,x),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/int32/plain/-1/out_same pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"int32")
local before=x:tolist()
local out=np.zeros({2,3,1,2},"int32")
local y=r:permuted(x,-1,out)
deep(y.dtype,"int32","4294967297/(2, 3, 1, 2)/int32/plain/-1/out_new dtype")
deep(y:tolist(),{{{{0,1}},{{2,3}},{{5,4}}},{{{6,7}},{{9,8}},{{11,10}}}},"4294967297/(2, 3, 1, 2)/int32/plain/-1/out_new values")
deep(x:tolist(),{{{{0,1}},{{2,3}},{{4,5}}},{{{6,7}},{{8,9}},{{10,11}}}},"4294967297/(2, 3, 1, 2)/int32/plain/-1/out_new source")
assert(rawequal(y,out),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/int32/plain/-1/out_new pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"int32"),{4,3,2,1})
local before=x:tolist()
local y=r:permuted(x,nil)
deep(y.dtype,"int32","4294967297/(2, 3, 1, 2)/int32/transpose/None/copy dtype")
deep(y:tolist(),{{{{6,0},{4,5},{7,8}}},{{{2,3},{9,11},{1,10}}}},"4294967297/(2, 3, 1, 2)/int32/transpose/None/copy values")
deep(x:tolist(),{{{{0,6},{2,8},{4,10}}},{{{1,7},{3,9},{5,11}}}},"4294967297/(2, 3, 1, 2)/int32/transpose/None/copy source")
deep(r:raw_hex(),"f3fe33f26b689233","4294967297/(2, 3, 1, 2)/int32/transpose/None/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"int32"),{4,3,2,1})
local before=x:tolist()
local y=r:permuted(x,nil,x)
deep(y.dtype,"int32","4294967297/(2, 3, 1, 2)/int32/transpose/None/out_same dtype")
deep(y:tolist(),{{{{6,0},{4,5},{7,8}}},{{{2,3},{9,11},{1,10}}}},"4294967297/(2, 3, 1, 2)/int32/transpose/None/out_same values")
deep(x:tolist(),{{{{6,0},{4,5},{7,8}}},{{{2,3},{9,11},{1,10}}}},"4294967297/(2, 3, 1, 2)/int32/transpose/None/out_same source")
assert(rawequal(y,x),"out must return identical ndarray")
deep(r:raw_hex(),"f3fe33f26b689233","4294967297/(2, 3, 1, 2)/int32/transpose/None/out_same pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"int32"),{4,3,2,1})
local before=x:tolist()
local out=np.zeros({2,1,3,2},"int32")
local y=r:permuted(x,nil,out)
deep(y.dtype,"int32","4294967297/(2, 3, 1, 2)/int32/transpose/None/out_new dtype")
deep(y:tolist(),{{{{1,2},{4,9},{7,6}}},{{{0,8},{10,11},{3,5}}}},"4294967297/(2, 3, 1, 2)/int32/transpose/None/out_new values")
deep(x:tolist(),{{{{0,6},{2,8},{4,10}}},{{{1,7},{3,9},{5,11}}}},"4294967297/(2, 3, 1, 2)/int32/transpose/None/out_new source")
assert(rawequal(y,out),"out must return identical ndarray")
deep(r:raw_hex(),"f3fe33f26b689233","4294967297/(2, 3, 1, 2)/int32/transpose/None/out_new pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"int32"),{4,3,2,1})
local before=x:tolist()
local y=r:permuted(x,1)
deep(y.dtype,"int32","4294967297/(2, 3, 1, 2)/int32/transpose/0/copy dtype")
deep(y:tolist(),{{{{0,6},{3,8},{5,11}}},{{{1,7},{2,9},{4,10}}}},"4294967297/(2, 3, 1, 2)/int32/transpose/0/copy values")
deep(x:tolist(),{{{{0,6},{2,8},{4,10}}},{{{1,7},{3,9},{5,11}}}},"4294967297/(2, 3, 1, 2)/int32/transpose/0/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/int32/transpose/0/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"int32"),{4,3,2,1})
local before=x:tolist()
local y=r:permuted(x,1,x)
deep(y.dtype,"int32","4294967297/(2, 3, 1, 2)/int32/transpose/0/out_same dtype")
deep(y:tolist(),{{{{0,6},{3,8},{5,11}}},{{{1,7},{2,9},{4,10}}}},"4294967297/(2, 3, 1, 2)/int32/transpose/0/out_same values")
deep(x:tolist(),{{{{0,6},{3,8},{5,11}}},{{{1,7},{2,9},{4,10}}}},"4294967297/(2, 3, 1, 2)/int32/transpose/0/out_same source")
assert(rawequal(y,x),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/int32/transpose/0/out_same pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"int32"),{4,3,2,1})
local before=x:tolist()
local out=np.zeros({2,1,3,2},"int32")
local y=r:permuted(x,1,out)
deep(y.dtype,"int32","4294967297/(2, 3, 1, 2)/int32/transpose/0/out_new dtype")
deep(y:tolist(),{{{{0,6},{3,8},{5,11}}},{{{1,7},{2,9},{4,10}}}},"4294967297/(2, 3, 1, 2)/int32/transpose/0/out_new values")
deep(x:tolist(),{{{{0,6},{2,8},{4,10}}},{{{1,7},{3,9},{5,11}}}},"4294967297/(2, 3, 1, 2)/int32/transpose/0/out_new source")
assert(rawequal(y,out),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/int32/transpose/0/out_new pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"int32"),{4,3,2,1})
local before=x:tolist()
local y=r:permuted(x,4)
deep(y.dtype,"int32","4294967297/(2, 3, 1, 2)/int32/transpose/3/copy dtype")
deep(y:tolist(),{{{{0,6},{2,8},{10,4}}},{{{1,7},{9,3},{11,5}}}},"4294967297/(2, 3, 1, 2)/int32/transpose/3/copy values")
deep(x:tolist(),{{{{0,6},{2,8},{4,10}}},{{{1,7},{3,9},{5,11}}}},"4294967297/(2, 3, 1, 2)/int32/transpose/3/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/int32/transpose/3/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"int32"),{4,3,2,1})
local before=x:tolist()
local y=r:permuted(x,4,x)
deep(y.dtype,"int32","4294967297/(2, 3, 1, 2)/int32/transpose/3/out_same dtype")
deep(y:tolist(),{{{{0,6},{2,8},{10,4}}},{{{1,7},{9,3},{11,5}}}},"4294967297/(2, 3, 1, 2)/int32/transpose/3/out_same values")
deep(x:tolist(),{{{{0,6},{2,8},{10,4}}},{{{1,7},{9,3},{11,5}}}},"4294967297/(2, 3, 1, 2)/int32/transpose/3/out_same source")
assert(rawequal(y,x),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/int32/transpose/3/out_same pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"int32"),{4,3,2,1})
local before=x:tolist()
local out=np.zeros({2,1,3,2},"int32")
local y=r:permuted(x,4,out)
deep(y.dtype,"int32","4294967297/(2, 3, 1, 2)/int32/transpose/3/out_new dtype")
deep(y:tolist(),{{{{0,6},{2,8},{10,4}}},{{{1,7},{9,3},{11,5}}}},"4294967297/(2, 3, 1, 2)/int32/transpose/3/out_new values")
deep(x:tolist(),{{{{0,6},{2,8},{4,10}}},{{{1,7},{3,9},{5,11}}}},"4294967297/(2, 3, 1, 2)/int32/transpose/3/out_new source")
assert(rawequal(y,out),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/int32/transpose/3/out_new pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"int32"),{4,3,2,1})
local before=x:tolist()
local y=r:permuted(x,-1)
deep(y.dtype,"int32","4294967297/(2, 3, 1, 2)/int32/transpose/-1/copy dtype")
deep(y:tolist(),{{{{0,6},{2,8},{10,4}}},{{{1,7},{9,3},{11,5}}}},"4294967297/(2, 3, 1, 2)/int32/transpose/-1/copy values")
deep(x:tolist(),{{{{0,6},{2,8},{4,10}}},{{{1,7},{3,9},{5,11}}}},"4294967297/(2, 3, 1, 2)/int32/transpose/-1/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/int32/transpose/-1/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"int32"),{4,3,2,1})
local before=x:tolist()
local y=r:permuted(x,-1,x)
deep(y.dtype,"int32","4294967297/(2, 3, 1, 2)/int32/transpose/-1/out_same dtype")
deep(y:tolist(),{{{{0,6},{2,8},{10,4}}},{{{1,7},{9,3},{11,5}}}},"4294967297/(2, 3, 1, 2)/int32/transpose/-1/out_same values")
deep(x:tolist(),{{{{0,6},{2,8},{10,4}}},{{{1,7},{9,3},{11,5}}}},"4294967297/(2, 3, 1, 2)/int32/transpose/-1/out_same source")
assert(rawequal(y,x),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/int32/transpose/-1/out_same pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"int32"),{4,3,2,1})
local before=x:tolist()
local out=np.zeros({2,1,3,2},"int32")
local y=r:permuted(x,-1,out)
deep(y.dtype,"int32","4294967297/(2, 3, 1, 2)/int32/transpose/-1/out_new dtype")
deep(y:tolist(),{{{{0,6},{2,8},{10,4}}},{{{1,7},{9,3},{11,5}}}},"4294967297/(2, 3, 1, 2)/int32/transpose/-1/out_new values")
deep(x:tolist(),{{{{0,6},{2,8},{4,10}}},{{{1,7},{3,9},{5,11}}}},"4294967297/(2, 3, 1, 2)/int32/transpose/-1/out_new source")
assert(rawequal(y,out),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/int32/transpose/-1/out_new pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.flip(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"int32"),1)
local before=x:tolist()
local y=r:permuted(x,nil)
deep(y.dtype,"int32","4294967297/(2, 3, 1, 2)/int32/flip/None/copy dtype")
deep(y:tolist(),{{{{0,8}},{{10,3}},{{1,7}}},{{{6,9}},{{11,5}},{{2,4}}}},"4294967297/(2, 3, 1, 2)/int32/flip/None/copy values")
deep(x:tolist(),{{{{6,7}},{{8,9}},{{10,11}}},{{{0,1}},{{2,3}},{{4,5}}}},"4294967297/(2, 3, 1, 2)/int32/flip/None/copy source")
deep(r:raw_hex(),"f3fe33f26b689233","4294967297/(2, 3, 1, 2)/int32/flip/None/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.flip(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"int32"),1)
local before=x:tolist()
local y=r:permuted(x,nil,x)
deep(y.dtype,"int32","4294967297/(2, 3, 1, 2)/int32/flip/None/out_same dtype")
deep(y:tolist(),{{{{0,8}},{{10,3}},{{1,7}}},{{{6,9}},{{11,5}},{{2,4}}}},"4294967297/(2, 3, 1, 2)/int32/flip/None/out_same values")
deep(x:tolist(),{{{{0,8}},{{10,3}},{{1,7}}},{{{6,9}},{{11,5}},{{2,4}}}},"4294967297/(2, 3, 1, 2)/int32/flip/None/out_same source")
assert(rawequal(y,x),"out must return identical ndarray")
deep(r:raw_hex(),"f3fe33f26b689233","4294967297/(2, 3, 1, 2)/int32/flip/None/out_same pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.flip(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"int32"),1)
local before=x:tolist()
local y=r:permuted(x,1)
deep(y.dtype,"int32","4294967297/(2, 3, 1, 2)/int32/flip/0/copy dtype")
deep(y:tolist(),{{{{6,7}},{{2,9}},{{4,5}}},{{{0,1}},{{8,3}},{{10,11}}}},"4294967297/(2, 3, 1, 2)/int32/flip/0/copy values")
deep(x:tolist(),{{{{6,7}},{{8,9}},{{10,11}}},{{{0,1}},{{2,3}},{{4,5}}}},"4294967297/(2, 3, 1, 2)/int32/flip/0/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/int32/flip/0/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.flip(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"int32"),1)
local before=x:tolist()
local y=r:permuted(x,1,x)
deep(y.dtype,"int32","4294967297/(2, 3, 1, 2)/int32/flip/0/out_same dtype")
deep(y:tolist(),{{{{6,7}},{{2,9}},{{4,5}}},{{{0,1}},{{8,3}},{{10,11}}}},"4294967297/(2, 3, 1, 2)/int32/flip/0/out_same values")
deep(x:tolist(),{{{{6,7}},{{2,9}},{{4,5}}},{{{0,1}},{{8,3}},{{10,11}}}},"4294967297/(2, 3, 1, 2)/int32/flip/0/out_same source")
assert(rawequal(y,x),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/int32/flip/0/out_same pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.flip(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"int32"),1)
local before=x:tolist()
local y=r:permuted(x,4)
deep(y.dtype,"int32","4294967297/(2, 3, 1, 2)/int32/flip/3/copy dtype")
deep(y:tolist(),{{{{6,7}},{{8,9}},{{11,10}}},{{{0,1}},{{3,2}},{{5,4}}}},"4294967297/(2, 3, 1, 2)/int32/flip/3/copy values")
deep(x:tolist(),{{{{6,7}},{{8,9}},{{10,11}}},{{{0,1}},{{2,3}},{{4,5}}}},"4294967297/(2, 3, 1, 2)/int32/flip/3/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/int32/flip/3/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.flip(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"int32"),1)
local before=x:tolist()
local y=r:permuted(x,4,x)
deep(y.dtype,"int32","4294967297/(2, 3, 1, 2)/int32/flip/3/out_same dtype")
deep(y:tolist(),{{{{6,7}},{{8,9}},{{11,10}}},{{{0,1}},{{3,2}},{{5,4}}}},"4294967297/(2, 3, 1, 2)/int32/flip/3/out_same values")
deep(x:tolist(),{{{{6,7}},{{8,9}},{{11,10}}},{{{0,1}},{{3,2}},{{5,4}}}},"4294967297/(2, 3, 1, 2)/int32/flip/3/out_same source")
assert(rawequal(y,x),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/int32/flip/3/out_same pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.flip(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"int32"),1)
local before=x:tolist()
local y=r:permuted(x,-1)
deep(y.dtype,"int32","4294967297/(2, 3, 1, 2)/int32/flip/-1/copy dtype")
deep(y:tolist(),{{{{6,7}},{{8,9}},{{11,10}}},{{{0,1}},{{3,2}},{{5,4}}}},"4294967297/(2, 3, 1, 2)/int32/flip/-1/copy values")
deep(x:tolist(),{{{{6,7}},{{8,9}},{{10,11}}},{{{0,1}},{{2,3}},{{4,5}}}},"4294967297/(2, 3, 1, 2)/int32/flip/-1/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/int32/flip/-1/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.flip(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"int32"),1)
local before=x:tolist()
local y=r:permuted(x,-1,x)
deep(y.dtype,"int32","4294967297/(2, 3, 1, 2)/int32/flip/-1/out_same dtype")
deep(y:tolist(),{{{{6,7}},{{8,9}},{{11,10}}},{{{0,1}},{{3,2}},{{5,4}}}},"4294967297/(2, 3, 1, 2)/int32/flip/-1/out_same values")
deep(x:tolist(),{{{{6,7}},{{8,9}},{{11,10}}},{{{0,1}},{{3,2}},{{5,4}}}},"4294967297/(2, 3, 1, 2)/int32/flip/-1/out_same source")
assert(rawequal(y,x),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/int32/flip/-1/out_same pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float64")
local before=x:tolist()
local y=r:permuted(x,nil)
deep(y.dtype,"float64","4294967297/(2, 3, 1, 2)/float64/plain/None/copy dtype")
deep(y:tolist(),{{{{6.0,2.0}},{{4.0,9.0}},{{7.0,1.0}}},{{{0.0,3.0}},{{5.0,11.0}},{{8.0,10.0}}}},"4294967297/(2, 3, 1, 2)/float64/plain/None/copy values")
deep(x:tolist(),{{{{0.0,1.0}},{{2.0,3.0}},{{4.0,5.0}}},{{{6.0,7.0}},{{8.0,9.0}},{{10.0,11.0}}}},"4294967297/(2, 3, 1, 2)/float64/plain/None/copy source")
deep(r:raw_hex(),"f3fe33f26b689233","4294967297/(2, 3, 1, 2)/float64/plain/None/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float64")
local before=x:tolist()
local y=r:permuted(x,nil,x)
deep(y.dtype,"float64","4294967297/(2, 3, 1, 2)/float64/plain/None/out_same dtype")
deep(y:tolist(),{{{{6.0,2.0}},{{4.0,9.0}},{{7.0,1.0}}},{{{0.0,3.0}},{{5.0,11.0}},{{8.0,10.0}}}},"4294967297/(2, 3, 1, 2)/float64/plain/None/out_same values")
deep(x:tolist(),{{{{6.0,2.0}},{{4.0,9.0}},{{7.0,1.0}}},{{{0.0,3.0}},{{5.0,11.0}},{{8.0,10.0}}}},"4294967297/(2, 3, 1, 2)/float64/plain/None/out_same source")
assert(rawequal(y,x),"out must return identical ndarray")
deep(r:raw_hex(),"f3fe33f26b689233","4294967297/(2, 3, 1, 2)/float64/plain/None/out_same pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float64")
local before=x:tolist()
local out=np.zeros({2,3,1,2},"float64")
local y=r:permuted(x,nil,out)
deep(y.dtype,"float64","4294967297/(2, 3, 1, 2)/float64/plain/None/out_new dtype")
deep(y:tolist(),{{{{6.0,2.0}},{{4.0,9.0}},{{7.0,1.0}}},{{{0.0,3.0}},{{5.0,11.0}},{{8.0,10.0}}}},"4294967297/(2, 3, 1, 2)/float64/plain/None/out_new values")
deep(x:tolist(),{{{{0.0,1.0}},{{2.0,3.0}},{{4.0,5.0}}},{{{6.0,7.0}},{{8.0,9.0}},{{10.0,11.0}}}},"4294967297/(2, 3, 1, 2)/float64/plain/None/out_new source")
assert(rawequal(y,out),"out must return identical ndarray")
deep(r:raw_hex(),"f3fe33f26b689233","4294967297/(2, 3, 1, 2)/float64/plain/None/out_new pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float64")
local before=x:tolist()
local y=r:permuted(x,1)
deep(y.dtype,"float64","4294967297/(2, 3, 1, 2)/float64/plain/0/copy dtype")
deep(y:tolist(),{{{{0.0,1.0}},{{8.0,3.0}},{{10.0,11.0}}},{{{6.0,7.0}},{{2.0,9.0}},{{4.0,5.0}}}},"4294967297/(2, 3, 1, 2)/float64/plain/0/copy values")
deep(x:tolist(),{{{{0.0,1.0}},{{2.0,3.0}},{{4.0,5.0}}},{{{6.0,7.0}},{{8.0,9.0}},{{10.0,11.0}}}},"4294967297/(2, 3, 1, 2)/float64/plain/0/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float64/plain/0/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float64")
local before=x:tolist()
local y=r:permuted(x,1,x)
deep(y.dtype,"float64","4294967297/(2, 3, 1, 2)/float64/plain/0/out_same dtype")
deep(y:tolist(),{{{{0.0,1.0}},{{8.0,3.0}},{{10.0,11.0}}},{{{6.0,7.0}},{{2.0,9.0}},{{4.0,5.0}}}},"4294967297/(2, 3, 1, 2)/float64/plain/0/out_same values")
deep(x:tolist(),{{{{0.0,1.0}},{{8.0,3.0}},{{10.0,11.0}}},{{{6.0,7.0}},{{2.0,9.0}},{{4.0,5.0}}}},"4294967297/(2, 3, 1, 2)/float64/plain/0/out_same source")
assert(rawequal(y,x),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float64/plain/0/out_same pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float64")
local before=x:tolist()
local out=np.zeros({2,3,1,2},"float64")
local y=r:permuted(x,1,out)
deep(y.dtype,"float64","4294967297/(2, 3, 1, 2)/float64/plain/0/out_new dtype")
deep(y:tolist(),{{{{0.0,1.0}},{{8.0,3.0}},{{10.0,11.0}}},{{{6.0,7.0}},{{2.0,9.0}},{{4.0,5.0}}}},"4294967297/(2, 3, 1, 2)/float64/plain/0/out_new values")
deep(x:tolist(),{{{{0.0,1.0}},{{2.0,3.0}},{{4.0,5.0}}},{{{6.0,7.0}},{{8.0,9.0}},{{10.0,11.0}}}},"4294967297/(2, 3, 1, 2)/float64/plain/0/out_new source")
assert(rawequal(y,out),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float64/plain/0/out_new pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float64")
local before=x:tolist()
local y=r:permuted(x,4)
deep(y.dtype,"float64","4294967297/(2, 3, 1, 2)/float64/plain/3/copy dtype")
deep(y:tolist(),{{{{0.0,1.0}},{{2.0,3.0}},{{5.0,4.0}}},{{{6.0,7.0}},{{9.0,8.0}},{{11.0,10.0}}}},"4294967297/(2, 3, 1, 2)/float64/plain/3/copy values")
deep(x:tolist(),{{{{0.0,1.0}},{{2.0,3.0}},{{4.0,5.0}}},{{{6.0,7.0}},{{8.0,9.0}},{{10.0,11.0}}}},"4294967297/(2, 3, 1, 2)/float64/plain/3/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float64/plain/3/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float64")
local before=x:tolist()
local y=r:permuted(x,4,x)
deep(y.dtype,"float64","4294967297/(2, 3, 1, 2)/float64/plain/3/out_same dtype")
deep(y:tolist(),{{{{0.0,1.0}},{{2.0,3.0}},{{5.0,4.0}}},{{{6.0,7.0}},{{9.0,8.0}},{{11.0,10.0}}}},"4294967297/(2, 3, 1, 2)/float64/plain/3/out_same values")
deep(x:tolist(),{{{{0.0,1.0}},{{2.0,3.0}},{{5.0,4.0}}},{{{6.0,7.0}},{{9.0,8.0}},{{11.0,10.0}}}},"4294967297/(2, 3, 1, 2)/float64/plain/3/out_same source")
assert(rawequal(y,x),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float64/plain/3/out_same pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float64")
local before=x:tolist()
local out=np.zeros({2,3,1,2},"float64")
local y=r:permuted(x,4,out)
deep(y.dtype,"float64","4294967297/(2, 3, 1, 2)/float64/plain/3/out_new dtype")
deep(y:tolist(),{{{{0.0,1.0}},{{2.0,3.0}},{{5.0,4.0}}},{{{6.0,7.0}},{{9.0,8.0}},{{11.0,10.0}}}},"4294967297/(2, 3, 1, 2)/float64/plain/3/out_new values")
deep(x:tolist(),{{{{0.0,1.0}},{{2.0,3.0}},{{4.0,5.0}}},{{{6.0,7.0}},{{8.0,9.0}},{{10.0,11.0}}}},"4294967297/(2, 3, 1, 2)/float64/plain/3/out_new source")
assert(rawequal(y,out),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float64/plain/3/out_new pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float64")
local before=x:tolist()
local y=r:permuted(x,-1)
deep(y.dtype,"float64","4294967297/(2, 3, 1, 2)/float64/plain/-1/copy dtype")
deep(y:tolist(),{{{{0.0,1.0}},{{2.0,3.0}},{{5.0,4.0}}},{{{6.0,7.0}},{{9.0,8.0}},{{11.0,10.0}}}},"4294967297/(2, 3, 1, 2)/float64/plain/-1/copy values")
deep(x:tolist(),{{{{0.0,1.0}},{{2.0,3.0}},{{4.0,5.0}}},{{{6.0,7.0}},{{8.0,9.0}},{{10.0,11.0}}}},"4294967297/(2, 3, 1, 2)/float64/plain/-1/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float64/plain/-1/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float64")
local before=x:tolist()
local y=r:permuted(x,-1,x)
deep(y.dtype,"float64","4294967297/(2, 3, 1, 2)/float64/plain/-1/out_same dtype")
deep(y:tolist(),{{{{0.0,1.0}},{{2.0,3.0}},{{5.0,4.0}}},{{{6.0,7.0}},{{9.0,8.0}},{{11.0,10.0}}}},"4294967297/(2, 3, 1, 2)/float64/plain/-1/out_same values")
deep(x:tolist(),{{{{0.0,1.0}},{{2.0,3.0}},{{5.0,4.0}}},{{{6.0,7.0}},{{9.0,8.0}},{{11.0,10.0}}}},"4294967297/(2, 3, 1, 2)/float64/plain/-1/out_same source")
assert(rawequal(y,x),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float64/plain/-1/out_same pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float64")
local before=x:tolist()
local out=np.zeros({2,3,1,2},"float64")
local y=r:permuted(x,-1,out)
deep(y.dtype,"float64","4294967297/(2, 3, 1, 2)/float64/plain/-1/out_new dtype")
deep(y:tolist(),{{{{0.0,1.0}},{{2.0,3.0}},{{5.0,4.0}}},{{{6.0,7.0}},{{9.0,8.0}},{{11.0,10.0}}}},"4294967297/(2, 3, 1, 2)/float64/plain/-1/out_new values")
deep(x:tolist(),{{{{0.0,1.0}},{{2.0,3.0}},{{4.0,5.0}}},{{{6.0,7.0}},{{8.0,9.0}},{{10.0,11.0}}}},"4294967297/(2, 3, 1, 2)/float64/plain/-1/out_new source")
assert(rawequal(y,out),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float64/plain/-1/out_new pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float64"),{4,3,2,1})
local before=x:tolist()
local y=r:permuted(x,nil)
deep(y.dtype,"float64","4294967297/(2, 3, 1, 2)/float64/transpose/None/copy dtype")
deep(y:tolist(),{{{{6.0,0.0},{4.0,5.0},{7.0,8.0}}},{{{2.0,3.0},{9.0,11.0},{1.0,10.0}}}},"4294967297/(2, 3, 1, 2)/float64/transpose/None/copy values")
deep(x:tolist(),{{{{0.0,6.0},{2.0,8.0},{4.0,10.0}}},{{{1.0,7.0},{3.0,9.0},{5.0,11.0}}}},"4294967297/(2, 3, 1, 2)/float64/transpose/None/copy source")
deep(r:raw_hex(),"f3fe33f26b689233","4294967297/(2, 3, 1, 2)/float64/transpose/None/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float64"),{4,3,2,1})
local before=x:tolist()
local y=r:permuted(x,nil,x)
deep(y.dtype,"float64","4294967297/(2, 3, 1, 2)/float64/transpose/None/out_same dtype")
deep(y:tolist(),{{{{6.0,0.0},{4.0,5.0},{7.0,8.0}}},{{{2.0,3.0},{9.0,11.0},{1.0,10.0}}}},"4294967297/(2, 3, 1, 2)/float64/transpose/None/out_same values")
deep(x:tolist(),{{{{6.0,0.0},{4.0,5.0},{7.0,8.0}}},{{{2.0,3.0},{9.0,11.0},{1.0,10.0}}}},"4294967297/(2, 3, 1, 2)/float64/transpose/None/out_same source")
assert(rawequal(y,x),"out must return identical ndarray")
deep(r:raw_hex(),"f3fe33f26b689233","4294967297/(2, 3, 1, 2)/float64/transpose/None/out_same pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float64"),{4,3,2,1})
local before=x:tolist()
local out=np.zeros({2,1,3,2},"float64")
local y=r:permuted(x,nil,out)
deep(y.dtype,"float64","4294967297/(2, 3, 1, 2)/float64/transpose/None/out_new dtype")
deep(y:tolist(),{{{{1.0,2.0},{4.0,9.0},{7.0,6.0}}},{{{0.0,8.0},{10.0,11.0},{3.0,5.0}}}},"4294967297/(2, 3, 1, 2)/float64/transpose/None/out_new values")
deep(x:tolist(),{{{{0.0,6.0},{2.0,8.0},{4.0,10.0}}},{{{1.0,7.0},{3.0,9.0},{5.0,11.0}}}},"4294967297/(2, 3, 1, 2)/float64/transpose/None/out_new source")
assert(rawequal(y,out),"out must return identical ndarray")
deep(r:raw_hex(),"f3fe33f26b689233","4294967297/(2, 3, 1, 2)/float64/transpose/None/out_new pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float64"),{4,3,2,1})
local before=x:tolist()
local y=r:permuted(x,1)
deep(y.dtype,"float64","4294967297/(2, 3, 1, 2)/float64/transpose/0/copy dtype")
deep(y:tolist(),{{{{0.0,6.0},{3.0,8.0},{5.0,11.0}}},{{{1.0,7.0},{2.0,9.0},{4.0,10.0}}}},"4294967297/(2, 3, 1, 2)/float64/transpose/0/copy values")
deep(x:tolist(),{{{{0.0,6.0},{2.0,8.0},{4.0,10.0}}},{{{1.0,7.0},{3.0,9.0},{5.0,11.0}}}},"4294967297/(2, 3, 1, 2)/float64/transpose/0/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float64/transpose/0/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float64"),{4,3,2,1})
local before=x:tolist()
local y=r:permuted(x,1,x)
deep(y.dtype,"float64","4294967297/(2, 3, 1, 2)/float64/transpose/0/out_same dtype")
deep(y:tolist(),{{{{0.0,6.0},{3.0,8.0},{5.0,11.0}}},{{{1.0,7.0},{2.0,9.0},{4.0,10.0}}}},"4294967297/(2, 3, 1, 2)/float64/transpose/0/out_same values")
deep(x:tolist(),{{{{0.0,6.0},{3.0,8.0},{5.0,11.0}}},{{{1.0,7.0},{2.0,9.0},{4.0,10.0}}}},"4294967297/(2, 3, 1, 2)/float64/transpose/0/out_same source")
assert(rawequal(y,x),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float64/transpose/0/out_same pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float64"),{4,3,2,1})
local before=x:tolist()
local out=np.zeros({2,1,3,2},"float64")
local y=r:permuted(x,1,out)
deep(y.dtype,"float64","4294967297/(2, 3, 1, 2)/float64/transpose/0/out_new dtype")
deep(y:tolist(),{{{{0.0,6.0},{3.0,8.0},{5.0,11.0}}},{{{1.0,7.0},{2.0,9.0},{4.0,10.0}}}},"4294967297/(2, 3, 1, 2)/float64/transpose/0/out_new values")
deep(x:tolist(),{{{{0.0,6.0},{2.0,8.0},{4.0,10.0}}},{{{1.0,7.0},{3.0,9.0},{5.0,11.0}}}},"4294967297/(2, 3, 1, 2)/float64/transpose/0/out_new source")
assert(rawequal(y,out),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float64/transpose/0/out_new pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float64"),{4,3,2,1})
local before=x:tolist()
local y=r:permuted(x,4)
deep(y.dtype,"float64","4294967297/(2, 3, 1, 2)/float64/transpose/3/copy dtype")
deep(y:tolist(),{{{{0.0,6.0},{2.0,8.0},{10.0,4.0}}},{{{1.0,7.0},{9.0,3.0},{11.0,5.0}}}},"4294967297/(2, 3, 1, 2)/float64/transpose/3/copy values")
deep(x:tolist(),{{{{0.0,6.0},{2.0,8.0},{4.0,10.0}}},{{{1.0,7.0},{3.0,9.0},{5.0,11.0}}}},"4294967297/(2, 3, 1, 2)/float64/transpose/3/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float64/transpose/3/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float64"),{4,3,2,1})
local before=x:tolist()
local y=r:permuted(x,4,x)
deep(y.dtype,"float64","4294967297/(2, 3, 1, 2)/float64/transpose/3/out_same dtype")
deep(y:tolist(),{{{{0.0,6.0},{2.0,8.0},{10.0,4.0}}},{{{1.0,7.0},{9.0,3.0},{11.0,5.0}}}},"4294967297/(2, 3, 1, 2)/float64/transpose/3/out_same values")
deep(x:tolist(),{{{{0.0,6.0},{2.0,8.0},{10.0,4.0}}},{{{1.0,7.0},{9.0,3.0},{11.0,5.0}}}},"4294967297/(2, 3, 1, 2)/float64/transpose/3/out_same source")
assert(rawequal(y,x),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float64/transpose/3/out_same pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float64"),{4,3,2,1})
local before=x:tolist()
local out=np.zeros({2,1,3,2},"float64")
local y=r:permuted(x,4,out)
deep(y.dtype,"float64","4294967297/(2, 3, 1, 2)/float64/transpose/3/out_new dtype")
deep(y:tolist(),{{{{0.0,6.0},{2.0,8.0},{10.0,4.0}}},{{{1.0,7.0},{9.0,3.0},{11.0,5.0}}}},"4294967297/(2, 3, 1, 2)/float64/transpose/3/out_new values")
deep(x:tolist(),{{{{0.0,6.0},{2.0,8.0},{4.0,10.0}}},{{{1.0,7.0},{3.0,9.0},{5.0,11.0}}}},"4294967297/(2, 3, 1, 2)/float64/transpose/3/out_new source")
assert(rawequal(y,out),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float64/transpose/3/out_new pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float64"),{4,3,2,1})
local before=x:tolist()
local y=r:permuted(x,-1)
deep(y.dtype,"float64","4294967297/(2, 3, 1, 2)/float64/transpose/-1/copy dtype")
deep(y:tolist(),{{{{0.0,6.0},{2.0,8.0},{10.0,4.0}}},{{{1.0,7.0},{9.0,3.0},{11.0,5.0}}}},"4294967297/(2, 3, 1, 2)/float64/transpose/-1/copy values")
deep(x:tolist(),{{{{0.0,6.0},{2.0,8.0},{4.0,10.0}}},{{{1.0,7.0},{3.0,9.0},{5.0,11.0}}}},"4294967297/(2, 3, 1, 2)/float64/transpose/-1/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float64/transpose/-1/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float64"),{4,3,2,1})
local before=x:tolist()
local y=r:permuted(x,-1,x)
deep(y.dtype,"float64","4294967297/(2, 3, 1, 2)/float64/transpose/-1/out_same dtype")
deep(y:tolist(),{{{{0.0,6.0},{2.0,8.0},{10.0,4.0}}},{{{1.0,7.0},{9.0,3.0},{11.0,5.0}}}},"4294967297/(2, 3, 1, 2)/float64/transpose/-1/out_same values")
deep(x:tolist(),{{{{0.0,6.0},{2.0,8.0},{10.0,4.0}}},{{{1.0,7.0},{9.0,3.0},{11.0,5.0}}}},"4294967297/(2, 3, 1, 2)/float64/transpose/-1/out_same source")
assert(rawequal(y,x),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float64/transpose/-1/out_same pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float64"),{4,3,2,1})
local before=x:tolist()
local out=np.zeros({2,1,3,2},"float64")
local y=r:permuted(x,-1,out)
deep(y.dtype,"float64","4294967297/(2, 3, 1, 2)/float64/transpose/-1/out_new dtype")
deep(y:tolist(),{{{{0.0,6.0},{2.0,8.0},{10.0,4.0}}},{{{1.0,7.0},{9.0,3.0},{11.0,5.0}}}},"4294967297/(2, 3, 1, 2)/float64/transpose/-1/out_new values")
deep(x:tolist(),{{{{0.0,6.0},{2.0,8.0},{4.0,10.0}}},{{{1.0,7.0},{3.0,9.0},{5.0,11.0}}}},"4294967297/(2, 3, 1, 2)/float64/transpose/-1/out_new source")
assert(rawequal(y,out),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float64/transpose/-1/out_new pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.flip(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float64"),1)
local before=x:tolist()
local y=r:permuted(x,nil)
deep(y.dtype,"float64","4294967297/(2, 3, 1, 2)/float64/flip/None/copy dtype")
deep(y:tolist(),{{{{0.0,8.0}},{{10.0,3.0}},{{1.0,7.0}}},{{{6.0,9.0}},{{11.0,5.0}},{{2.0,4.0}}}},"4294967297/(2, 3, 1, 2)/float64/flip/None/copy values")
deep(x:tolist(),{{{{6.0,7.0}},{{8.0,9.0}},{{10.0,11.0}}},{{{0.0,1.0}},{{2.0,3.0}},{{4.0,5.0}}}},"4294967297/(2, 3, 1, 2)/float64/flip/None/copy source")
deep(r:raw_hex(),"f3fe33f26b689233","4294967297/(2, 3, 1, 2)/float64/flip/None/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.flip(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float64"),1)
local before=x:tolist()
local y=r:permuted(x,nil,x)
deep(y.dtype,"float64","4294967297/(2, 3, 1, 2)/float64/flip/None/out_same dtype")
deep(y:tolist(),{{{{0.0,8.0}},{{10.0,3.0}},{{1.0,7.0}}},{{{6.0,9.0}},{{11.0,5.0}},{{2.0,4.0}}}},"4294967297/(2, 3, 1, 2)/float64/flip/None/out_same values")
deep(x:tolist(),{{{{0.0,8.0}},{{10.0,3.0}},{{1.0,7.0}}},{{{6.0,9.0}},{{11.0,5.0}},{{2.0,4.0}}}},"4294967297/(2, 3, 1, 2)/float64/flip/None/out_same source")
assert(rawequal(y,x),"out must return identical ndarray")
deep(r:raw_hex(),"f3fe33f26b689233","4294967297/(2, 3, 1, 2)/float64/flip/None/out_same pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.flip(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float64"),1)
local before=x:tolist()
local y=r:permuted(x,1)
deep(y.dtype,"float64","4294967297/(2, 3, 1, 2)/float64/flip/0/copy dtype")
deep(y:tolist(),{{{{6.0,7.0}},{{2.0,9.0}},{{4.0,5.0}}},{{{0.0,1.0}},{{8.0,3.0}},{{10.0,11.0}}}},"4294967297/(2, 3, 1, 2)/float64/flip/0/copy values")
deep(x:tolist(),{{{{6.0,7.0}},{{8.0,9.0}},{{10.0,11.0}}},{{{0.0,1.0}},{{2.0,3.0}},{{4.0,5.0}}}},"4294967297/(2, 3, 1, 2)/float64/flip/0/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float64/flip/0/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.flip(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float64"),1)
local before=x:tolist()
local y=r:permuted(x,1,x)
deep(y.dtype,"float64","4294967297/(2, 3, 1, 2)/float64/flip/0/out_same dtype")
deep(y:tolist(),{{{{6.0,7.0}},{{2.0,9.0}},{{4.0,5.0}}},{{{0.0,1.0}},{{8.0,3.0}},{{10.0,11.0}}}},"4294967297/(2, 3, 1, 2)/float64/flip/0/out_same values")
deep(x:tolist(),{{{{6.0,7.0}},{{2.0,9.0}},{{4.0,5.0}}},{{{0.0,1.0}},{{8.0,3.0}},{{10.0,11.0}}}},"4294967297/(2, 3, 1, 2)/float64/flip/0/out_same source")
assert(rawequal(y,x),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float64/flip/0/out_same pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.flip(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float64"),1)
local before=x:tolist()
local y=r:permuted(x,4)
deep(y.dtype,"float64","4294967297/(2, 3, 1, 2)/float64/flip/3/copy dtype")
deep(y:tolist(),{{{{6.0,7.0}},{{8.0,9.0}},{{11.0,10.0}}},{{{0.0,1.0}},{{3.0,2.0}},{{5.0,4.0}}}},"4294967297/(2, 3, 1, 2)/float64/flip/3/copy values")
deep(x:tolist(),{{{{6.0,7.0}},{{8.0,9.0}},{{10.0,11.0}}},{{{0.0,1.0}},{{2.0,3.0}},{{4.0,5.0}}}},"4294967297/(2, 3, 1, 2)/float64/flip/3/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float64/flip/3/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.flip(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float64"),1)
local before=x:tolist()
local y=r:permuted(x,4,x)
deep(y.dtype,"float64","4294967297/(2, 3, 1, 2)/float64/flip/3/out_same dtype")
deep(y:tolist(),{{{{6.0,7.0}},{{8.0,9.0}},{{11.0,10.0}}},{{{0.0,1.0}},{{3.0,2.0}},{{5.0,4.0}}}},"4294967297/(2, 3, 1, 2)/float64/flip/3/out_same values")
deep(x:tolist(),{{{{6.0,7.0}},{{8.0,9.0}},{{11.0,10.0}}},{{{0.0,1.0}},{{3.0,2.0}},{{5.0,4.0}}}},"4294967297/(2, 3, 1, 2)/float64/flip/3/out_same source")
assert(rawequal(y,x),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float64/flip/3/out_same pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.flip(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float64"),1)
local before=x:tolist()
local y=r:permuted(x,-1)
deep(y.dtype,"float64","4294967297/(2, 3, 1, 2)/float64/flip/-1/copy dtype")
deep(y:tolist(),{{{{6.0,7.0}},{{8.0,9.0}},{{11.0,10.0}}},{{{0.0,1.0}},{{3.0,2.0}},{{5.0,4.0}}}},"4294967297/(2, 3, 1, 2)/float64/flip/-1/copy values")
deep(x:tolist(),{{{{6.0,7.0}},{{8.0,9.0}},{{10.0,11.0}}},{{{0.0,1.0}},{{2.0,3.0}},{{4.0,5.0}}}},"4294967297/(2, 3, 1, 2)/float64/flip/-1/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float64/flip/-1/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.flip(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float64"),1)
local before=x:tolist()
local y=r:permuted(x,-1,x)
deep(y.dtype,"float64","4294967297/(2, 3, 1, 2)/float64/flip/-1/out_same dtype")
deep(y:tolist(),{{{{6.0,7.0}},{{8.0,9.0}},{{11.0,10.0}}},{{{0.0,1.0}},{{3.0,2.0}},{{5.0,4.0}}}},"4294967297/(2, 3, 1, 2)/float64/flip/-1/out_same values")
deep(x:tolist(),{{{{6.0,7.0}},{{8.0,9.0}},{{11.0,10.0}}},{{{0.0,1.0}},{{3.0,2.0}},{{5.0,4.0}}}},"4294967297/(2, 3, 1, 2)/float64/flip/-1/out_same source")
assert(rawequal(y,x),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float64/flip/-1/out_same pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float32")
local before=x:tolist()
local y=r:permuted(x,nil)
deep(y.dtype,"float32","4294967297/(2, 3, 1, 2)/float32/plain/None/copy dtype")
deep(y:tolist(),{{{{6.0,2.0}},{{4.0,9.0}},{{7.0,1.0}}},{{{0.0,3.0}},{{5.0,11.0}},{{8.0,10.0}}}},"4294967297/(2, 3, 1, 2)/float32/plain/None/copy values")
deep(x:tolist(),{{{{0.0,1.0}},{{2.0,3.0}},{{4.0,5.0}}},{{{6.0,7.0}},{{8.0,9.0}},{{10.0,11.0}}}},"4294967297/(2, 3, 1, 2)/float32/plain/None/copy source")
deep(r:raw_hex(),"f3fe33f26b689233","4294967297/(2, 3, 1, 2)/float32/plain/None/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float32")
local before=x:tolist()
local y=r:permuted(x,nil,x)
deep(y.dtype,"float32","4294967297/(2, 3, 1, 2)/float32/plain/None/out_same dtype")
deep(y:tolist(),{{{{6.0,2.0}},{{4.0,9.0}},{{7.0,1.0}}},{{{0.0,3.0}},{{5.0,11.0}},{{8.0,10.0}}}},"4294967297/(2, 3, 1, 2)/float32/plain/None/out_same values")
deep(x:tolist(),{{{{6.0,2.0}},{{4.0,9.0}},{{7.0,1.0}}},{{{0.0,3.0}},{{5.0,11.0}},{{8.0,10.0}}}},"4294967297/(2, 3, 1, 2)/float32/plain/None/out_same source")
assert(rawequal(y,x),"out must return identical ndarray")
deep(r:raw_hex(),"f3fe33f26b689233","4294967297/(2, 3, 1, 2)/float32/plain/None/out_same pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float32")
local before=x:tolist()
local out=np.zeros({2,3,1,2},"float32")
local y=r:permuted(x,nil,out)
deep(y.dtype,"float32","4294967297/(2, 3, 1, 2)/float32/plain/None/out_new dtype")
deep(y:tolist(),{{{{6.0,2.0}},{{4.0,9.0}},{{7.0,1.0}}},{{{0.0,3.0}},{{5.0,11.0}},{{8.0,10.0}}}},"4294967297/(2, 3, 1, 2)/float32/plain/None/out_new values")
deep(x:tolist(),{{{{0.0,1.0}},{{2.0,3.0}},{{4.0,5.0}}},{{{6.0,7.0}},{{8.0,9.0}},{{10.0,11.0}}}},"4294967297/(2, 3, 1, 2)/float32/plain/None/out_new source")
assert(rawequal(y,out),"out must return identical ndarray")
deep(r:raw_hex(),"f3fe33f26b689233","4294967297/(2, 3, 1, 2)/float32/plain/None/out_new pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float32")
local before=x:tolist()
local y=r:permuted(x,1)
deep(y.dtype,"float32","4294967297/(2, 3, 1, 2)/float32/plain/0/copy dtype")
deep(y:tolist(),{{{{0.0,1.0}},{{8.0,3.0}},{{10.0,11.0}}},{{{6.0,7.0}},{{2.0,9.0}},{{4.0,5.0}}}},"4294967297/(2, 3, 1, 2)/float32/plain/0/copy values")
deep(x:tolist(),{{{{0.0,1.0}},{{2.0,3.0}},{{4.0,5.0}}},{{{6.0,7.0}},{{8.0,9.0}},{{10.0,11.0}}}},"4294967297/(2, 3, 1, 2)/float32/plain/0/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float32/plain/0/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float32")
local before=x:tolist()
local y=r:permuted(x,1,x)
deep(y.dtype,"float32","4294967297/(2, 3, 1, 2)/float32/plain/0/out_same dtype")
deep(y:tolist(),{{{{0.0,1.0}},{{8.0,3.0}},{{10.0,11.0}}},{{{6.0,7.0}},{{2.0,9.0}},{{4.0,5.0}}}},"4294967297/(2, 3, 1, 2)/float32/plain/0/out_same values")
deep(x:tolist(),{{{{0.0,1.0}},{{8.0,3.0}},{{10.0,11.0}}},{{{6.0,7.0}},{{2.0,9.0}},{{4.0,5.0}}}},"4294967297/(2, 3, 1, 2)/float32/plain/0/out_same source")
assert(rawequal(y,x),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float32/plain/0/out_same pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float32")
local before=x:tolist()
local out=np.zeros({2,3,1,2},"float32")
local y=r:permuted(x,1,out)
deep(y.dtype,"float32","4294967297/(2, 3, 1, 2)/float32/plain/0/out_new dtype")
deep(y:tolist(),{{{{0.0,1.0}},{{8.0,3.0}},{{10.0,11.0}}},{{{6.0,7.0}},{{2.0,9.0}},{{4.0,5.0}}}},"4294967297/(2, 3, 1, 2)/float32/plain/0/out_new values")
deep(x:tolist(),{{{{0.0,1.0}},{{2.0,3.0}},{{4.0,5.0}}},{{{6.0,7.0}},{{8.0,9.0}},{{10.0,11.0}}}},"4294967297/(2, 3, 1, 2)/float32/plain/0/out_new source")
assert(rawequal(y,out),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float32/plain/0/out_new pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float32")
local before=x:tolist()
local y=r:permuted(x,4)
deep(y.dtype,"float32","4294967297/(2, 3, 1, 2)/float32/plain/3/copy dtype")
deep(y:tolist(),{{{{0.0,1.0}},{{2.0,3.0}},{{5.0,4.0}}},{{{6.0,7.0}},{{9.0,8.0}},{{11.0,10.0}}}},"4294967297/(2, 3, 1, 2)/float32/plain/3/copy values")
deep(x:tolist(),{{{{0.0,1.0}},{{2.0,3.0}},{{4.0,5.0}}},{{{6.0,7.0}},{{8.0,9.0}},{{10.0,11.0}}}},"4294967297/(2, 3, 1, 2)/float32/plain/3/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float32/plain/3/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float32")
local before=x:tolist()
local y=r:permuted(x,4,x)
deep(y.dtype,"float32","4294967297/(2, 3, 1, 2)/float32/plain/3/out_same dtype")
deep(y:tolist(),{{{{0.0,1.0}},{{2.0,3.0}},{{5.0,4.0}}},{{{6.0,7.0}},{{9.0,8.0}},{{11.0,10.0}}}},"4294967297/(2, 3, 1, 2)/float32/plain/3/out_same values")
deep(x:tolist(),{{{{0.0,1.0}},{{2.0,3.0}},{{5.0,4.0}}},{{{6.0,7.0}},{{9.0,8.0}},{{11.0,10.0}}}},"4294967297/(2, 3, 1, 2)/float32/plain/3/out_same source")
assert(rawequal(y,x),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float32/plain/3/out_same pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float32")
local before=x:tolist()
local out=np.zeros({2,3,1,2},"float32")
local y=r:permuted(x,4,out)
deep(y.dtype,"float32","4294967297/(2, 3, 1, 2)/float32/plain/3/out_new dtype")
deep(y:tolist(),{{{{0.0,1.0}},{{2.0,3.0}},{{5.0,4.0}}},{{{6.0,7.0}},{{9.0,8.0}},{{11.0,10.0}}}},"4294967297/(2, 3, 1, 2)/float32/plain/3/out_new values")
deep(x:tolist(),{{{{0.0,1.0}},{{2.0,3.0}},{{4.0,5.0}}},{{{6.0,7.0}},{{8.0,9.0}},{{10.0,11.0}}}},"4294967297/(2, 3, 1, 2)/float32/plain/3/out_new source")
assert(rawequal(y,out),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float32/plain/3/out_new pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float32")
local before=x:tolist()
local y=r:permuted(x,-1)
deep(y.dtype,"float32","4294967297/(2, 3, 1, 2)/float32/plain/-1/copy dtype")
deep(y:tolist(),{{{{0.0,1.0}},{{2.0,3.0}},{{5.0,4.0}}},{{{6.0,7.0}},{{9.0,8.0}},{{11.0,10.0}}}},"4294967297/(2, 3, 1, 2)/float32/plain/-1/copy values")
deep(x:tolist(),{{{{0.0,1.0}},{{2.0,3.0}},{{4.0,5.0}}},{{{6.0,7.0}},{{8.0,9.0}},{{10.0,11.0}}}},"4294967297/(2, 3, 1, 2)/float32/plain/-1/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float32/plain/-1/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float32")
local before=x:tolist()
local y=r:permuted(x,-1,x)
deep(y.dtype,"float32","4294967297/(2, 3, 1, 2)/float32/plain/-1/out_same dtype")
deep(y:tolist(),{{{{0.0,1.0}},{{2.0,3.0}},{{5.0,4.0}}},{{{6.0,7.0}},{{9.0,8.0}},{{11.0,10.0}}}},"4294967297/(2, 3, 1, 2)/float32/plain/-1/out_same values")
deep(x:tolist(),{{{{0.0,1.0}},{{2.0,3.0}},{{5.0,4.0}}},{{{6.0,7.0}},{{9.0,8.0}},{{11.0,10.0}}}},"4294967297/(2, 3, 1, 2)/float32/plain/-1/out_same source")
assert(rawequal(y,x),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float32/plain/-1/out_same pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float32")
local before=x:tolist()
local out=np.zeros({2,3,1,2},"float32")
local y=r:permuted(x,-1,out)
deep(y.dtype,"float32","4294967297/(2, 3, 1, 2)/float32/plain/-1/out_new dtype")
deep(y:tolist(),{{{{0.0,1.0}},{{2.0,3.0}},{{5.0,4.0}}},{{{6.0,7.0}},{{9.0,8.0}},{{11.0,10.0}}}},"4294967297/(2, 3, 1, 2)/float32/plain/-1/out_new values")
deep(x:tolist(),{{{{0.0,1.0}},{{2.0,3.0}},{{4.0,5.0}}},{{{6.0,7.0}},{{8.0,9.0}},{{10.0,11.0}}}},"4294967297/(2, 3, 1, 2)/float32/plain/-1/out_new source")
assert(rawequal(y,out),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float32/plain/-1/out_new pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float32"),{4,3,2,1})
local before=x:tolist()
local y=r:permuted(x,nil)
deep(y.dtype,"float32","4294967297/(2, 3, 1, 2)/float32/transpose/None/copy dtype")
deep(y:tolist(),{{{{6.0,0.0},{4.0,5.0},{7.0,8.0}}},{{{2.0,3.0},{9.0,11.0},{1.0,10.0}}}},"4294967297/(2, 3, 1, 2)/float32/transpose/None/copy values")
deep(x:tolist(),{{{{0.0,6.0},{2.0,8.0},{4.0,10.0}}},{{{1.0,7.0},{3.0,9.0},{5.0,11.0}}}},"4294967297/(2, 3, 1, 2)/float32/transpose/None/copy source")
deep(r:raw_hex(),"f3fe33f26b689233","4294967297/(2, 3, 1, 2)/float32/transpose/None/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float32"),{4,3,2,1})
local before=x:tolist()
local y=r:permuted(x,nil,x)
deep(y.dtype,"float32","4294967297/(2, 3, 1, 2)/float32/transpose/None/out_same dtype")
deep(y:tolist(),{{{{6.0,0.0},{4.0,5.0},{7.0,8.0}}},{{{2.0,3.0},{9.0,11.0},{1.0,10.0}}}},"4294967297/(2, 3, 1, 2)/float32/transpose/None/out_same values")
deep(x:tolist(),{{{{6.0,0.0},{4.0,5.0},{7.0,8.0}}},{{{2.0,3.0},{9.0,11.0},{1.0,10.0}}}},"4294967297/(2, 3, 1, 2)/float32/transpose/None/out_same source")
assert(rawequal(y,x),"out must return identical ndarray")
deep(r:raw_hex(),"f3fe33f26b689233","4294967297/(2, 3, 1, 2)/float32/transpose/None/out_same pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float32"),{4,3,2,1})
local before=x:tolist()
local out=np.zeros({2,1,3,2},"float32")
local y=r:permuted(x,nil,out)
deep(y.dtype,"float32","4294967297/(2, 3, 1, 2)/float32/transpose/None/out_new dtype")
deep(y:tolist(),{{{{1.0,2.0},{4.0,9.0},{7.0,6.0}}},{{{0.0,8.0},{10.0,11.0},{3.0,5.0}}}},"4294967297/(2, 3, 1, 2)/float32/transpose/None/out_new values")
deep(x:tolist(),{{{{0.0,6.0},{2.0,8.0},{4.0,10.0}}},{{{1.0,7.0},{3.0,9.0},{5.0,11.0}}}},"4294967297/(2, 3, 1, 2)/float32/transpose/None/out_new source")
assert(rawequal(y,out),"out must return identical ndarray")
deep(r:raw_hex(),"f3fe33f26b689233","4294967297/(2, 3, 1, 2)/float32/transpose/None/out_new pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float32"),{4,3,2,1})
local before=x:tolist()
local y=r:permuted(x,1)
deep(y.dtype,"float32","4294967297/(2, 3, 1, 2)/float32/transpose/0/copy dtype")
deep(y:tolist(),{{{{0.0,6.0},{3.0,8.0},{5.0,11.0}}},{{{1.0,7.0},{2.0,9.0},{4.0,10.0}}}},"4294967297/(2, 3, 1, 2)/float32/transpose/0/copy values")
deep(x:tolist(),{{{{0.0,6.0},{2.0,8.0},{4.0,10.0}}},{{{1.0,7.0},{3.0,9.0},{5.0,11.0}}}},"4294967297/(2, 3, 1, 2)/float32/transpose/0/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float32/transpose/0/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float32"),{4,3,2,1})
local before=x:tolist()
local y=r:permuted(x,1,x)
deep(y.dtype,"float32","4294967297/(2, 3, 1, 2)/float32/transpose/0/out_same dtype")
deep(y:tolist(),{{{{0.0,6.0},{3.0,8.0},{5.0,11.0}}},{{{1.0,7.0},{2.0,9.0},{4.0,10.0}}}},"4294967297/(2, 3, 1, 2)/float32/transpose/0/out_same values")
deep(x:tolist(),{{{{0.0,6.0},{3.0,8.0},{5.0,11.0}}},{{{1.0,7.0},{2.0,9.0},{4.0,10.0}}}},"4294967297/(2, 3, 1, 2)/float32/transpose/0/out_same source")
assert(rawequal(y,x),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float32/transpose/0/out_same pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float32"),{4,3,2,1})
local before=x:tolist()
local out=np.zeros({2,1,3,2},"float32")
local y=r:permuted(x,1,out)
deep(y.dtype,"float32","4294967297/(2, 3, 1, 2)/float32/transpose/0/out_new dtype")
deep(y:tolist(),{{{{0.0,6.0},{3.0,8.0},{5.0,11.0}}},{{{1.0,7.0},{2.0,9.0},{4.0,10.0}}}},"4294967297/(2, 3, 1, 2)/float32/transpose/0/out_new values")
deep(x:tolist(),{{{{0.0,6.0},{2.0,8.0},{4.0,10.0}}},{{{1.0,7.0},{3.0,9.0},{5.0,11.0}}}},"4294967297/(2, 3, 1, 2)/float32/transpose/0/out_new source")
assert(rawequal(y,out),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float32/transpose/0/out_new pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float32"),{4,3,2,1})
local before=x:tolist()
local y=r:permuted(x,4)
deep(y.dtype,"float32","4294967297/(2, 3, 1, 2)/float32/transpose/3/copy dtype")
deep(y:tolist(),{{{{0.0,6.0},{2.0,8.0},{10.0,4.0}}},{{{1.0,7.0},{9.0,3.0},{11.0,5.0}}}},"4294967297/(2, 3, 1, 2)/float32/transpose/3/copy values")
deep(x:tolist(),{{{{0.0,6.0},{2.0,8.0},{4.0,10.0}}},{{{1.0,7.0},{3.0,9.0},{5.0,11.0}}}},"4294967297/(2, 3, 1, 2)/float32/transpose/3/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float32/transpose/3/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float32"),{4,3,2,1})
local before=x:tolist()
local y=r:permuted(x,4,x)
deep(y.dtype,"float32","4294967297/(2, 3, 1, 2)/float32/transpose/3/out_same dtype")
deep(y:tolist(),{{{{0.0,6.0},{2.0,8.0},{10.0,4.0}}},{{{1.0,7.0},{9.0,3.0},{11.0,5.0}}}},"4294967297/(2, 3, 1, 2)/float32/transpose/3/out_same values")
deep(x:tolist(),{{{{0.0,6.0},{2.0,8.0},{10.0,4.0}}},{{{1.0,7.0},{9.0,3.0},{11.0,5.0}}}},"4294967297/(2, 3, 1, 2)/float32/transpose/3/out_same source")
assert(rawequal(y,x),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float32/transpose/3/out_same pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float32"),{4,3,2,1})
local before=x:tolist()
local out=np.zeros({2,1,3,2},"float32")
local y=r:permuted(x,4,out)
deep(y.dtype,"float32","4294967297/(2, 3, 1, 2)/float32/transpose/3/out_new dtype")
deep(y:tolist(),{{{{0.0,6.0},{2.0,8.0},{10.0,4.0}}},{{{1.0,7.0},{9.0,3.0},{11.0,5.0}}}},"4294967297/(2, 3, 1, 2)/float32/transpose/3/out_new values")
deep(x:tolist(),{{{{0.0,6.0},{2.0,8.0},{4.0,10.0}}},{{{1.0,7.0},{3.0,9.0},{5.0,11.0}}}},"4294967297/(2, 3, 1, 2)/float32/transpose/3/out_new source")
assert(rawequal(y,out),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float32/transpose/3/out_new pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float32"),{4,3,2,1})
local before=x:tolist()
local y=r:permuted(x,-1)
deep(y.dtype,"float32","4294967297/(2, 3, 1, 2)/float32/transpose/-1/copy dtype")
deep(y:tolist(),{{{{0.0,6.0},{2.0,8.0},{10.0,4.0}}},{{{1.0,7.0},{9.0,3.0},{11.0,5.0}}}},"4294967297/(2, 3, 1, 2)/float32/transpose/-1/copy values")
deep(x:tolist(),{{{{0.0,6.0},{2.0,8.0},{4.0,10.0}}},{{{1.0,7.0},{3.0,9.0},{5.0,11.0}}}},"4294967297/(2, 3, 1, 2)/float32/transpose/-1/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float32/transpose/-1/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float32"),{4,3,2,1})
local before=x:tolist()
local y=r:permuted(x,-1,x)
deep(y.dtype,"float32","4294967297/(2, 3, 1, 2)/float32/transpose/-1/out_same dtype")
deep(y:tolist(),{{{{0.0,6.0},{2.0,8.0},{10.0,4.0}}},{{{1.0,7.0},{9.0,3.0},{11.0,5.0}}}},"4294967297/(2, 3, 1, 2)/float32/transpose/-1/out_same values")
deep(x:tolist(),{{{{0.0,6.0},{2.0,8.0},{10.0,4.0}}},{{{1.0,7.0},{9.0,3.0},{11.0,5.0}}}},"4294967297/(2, 3, 1, 2)/float32/transpose/-1/out_same source")
assert(rawequal(y,x),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float32/transpose/-1/out_same pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float32"),{4,3,2,1})
local before=x:tolist()
local out=np.zeros({2,1,3,2},"float32")
local y=r:permuted(x,-1,out)
deep(y.dtype,"float32","4294967297/(2, 3, 1, 2)/float32/transpose/-1/out_new dtype")
deep(y:tolist(),{{{{0.0,6.0},{2.0,8.0},{10.0,4.0}}},{{{1.0,7.0},{9.0,3.0},{11.0,5.0}}}},"4294967297/(2, 3, 1, 2)/float32/transpose/-1/out_new values")
deep(x:tolist(),{{{{0.0,6.0},{2.0,8.0},{4.0,10.0}}},{{{1.0,7.0},{3.0,9.0},{5.0,11.0}}}},"4294967297/(2, 3, 1, 2)/float32/transpose/-1/out_new source")
assert(rawequal(y,out),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float32/transpose/-1/out_new pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.flip(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float32"),1)
local before=x:tolist()
local y=r:permuted(x,nil)
deep(y.dtype,"float32","4294967297/(2, 3, 1, 2)/float32/flip/None/copy dtype")
deep(y:tolist(),{{{{0.0,8.0}},{{10.0,3.0}},{{1.0,7.0}}},{{{6.0,9.0}},{{11.0,5.0}},{{2.0,4.0}}}},"4294967297/(2, 3, 1, 2)/float32/flip/None/copy values")
deep(x:tolist(),{{{{6.0,7.0}},{{8.0,9.0}},{{10.0,11.0}}},{{{0.0,1.0}},{{2.0,3.0}},{{4.0,5.0}}}},"4294967297/(2, 3, 1, 2)/float32/flip/None/copy source")
deep(r:raw_hex(),"f3fe33f26b689233","4294967297/(2, 3, 1, 2)/float32/flip/None/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.flip(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float32"),1)
local before=x:tolist()
local y=r:permuted(x,nil,x)
deep(y.dtype,"float32","4294967297/(2, 3, 1, 2)/float32/flip/None/out_same dtype")
deep(y:tolist(),{{{{0.0,8.0}},{{10.0,3.0}},{{1.0,7.0}}},{{{6.0,9.0}},{{11.0,5.0}},{{2.0,4.0}}}},"4294967297/(2, 3, 1, 2)/float32/flip/None/out_same values")
deep(x:tolist(),{{{{0.0,8.0}},{{10.0,3.0}},{{1.0,7.0}}},{{{6.0,9.0}},{{11.0,5.0}},{{2.0,4.0}}}},"4294967297/(2, 3, 1, 2)/float32/flip/None/out_same source")
assert(rawequal(y,x),"out must return identical ndarray")
deep(r:raw_hex(),"f3fe33f26b689233","4294967297/(2, 3, 1, 2)/float32/flip/None/out_same pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.flip(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float32"),1)
local before=x:tolist()
local y=r:permuted(x,1)
deep(y.dtype,"float32","4294967297/(2, 3, 1, 2)/float32/flip/0/copy dtype")
deep(y:tolist(),{{{{6.0,7.0}},{{2.0,9.0}},{{4.0,5.0}}},{{{0.0,1.0}},{{8.0,3.0}},{{10.0,11.0}}}},"4294967297/(2, 3, 1, 2)/float32/flip/0/copy values")
deep(x:tolist(),{{{{6.0,7.0}},{{8.0,9.0}},{{10.0,11.0}}},{{{0.0,1.0}},{{2.0,3.0}},{{4.0,5.0}}}},"4294967297/(2, 3, 1, 2)/float32/flip/0/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float32/flip/0/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.flip(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float32"),1)
local before=x:tolist()
local y=r:permuted(x,1,x)
deep(y.dtype,"float32","4294967297/(2, 3, 1, 2)/float32/flip/0/out_same dtype")
deep(y:tolist(),{{{{6.0,7.0}},{{2.0,9.0}},{{4.0,5.0}}},{{{0.0,1.0}},{{8.0,3.0}},{{10.0,11.0}}}},"4294967297/(2, 3, 1, 2)/float32/flip/0/out_same values")
deep(x:tolist(),{{{{6.0,7.0}},{{2.0,9.0}},{{4.0,5.0}}},{{{0.0,1.0}},{{8.0,3.0}},{{10.0,11.0}}}},"4294967297/(2, 3, 1, 2)/float32/flip/0/out_same source")
assert(rawequal(y,x),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float32/flip/0/out_same pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.flip(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float32"),1)
local before=x:tolist()
local y=r:permuted(x,4)
deep(y.dtype,"float32","4294967297/(2, 3, 1, 2)/float32/flip/3/copy dtype")
deep(y:tolist(),{{{{6.0,7.0}},{{8.0,9.0}},{{11.0,10.0}}},{{{0.0,1.0}},{{3.0,2.0}},{{5.0,4.0}}}},"4294967297/(2, 3, 1, 2)/float32/flip/3/copy values")
deep(x:tolist(),{{{{6.0,7.0}},{{8.0,9.0}},{{10.0,11.0}}},{{{0.0,1.0}},{{2.0,3.0}},{{4.0,5.0}}}},"4294967297/(2, 3, 1, 2)/float32/flip/3/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float32/flip/3/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.flip(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float32"),1)
local before=x:tolist()
local y=r:permuted(x,4,x)
deep(y.dtype,"float32","4294967297/(2, 3, 1, 2)/float32/flip/3/out_same dtype")
deep(y:tolist(),{{{{6.0,7.0}},{{8.0,9.0}},{{11.0,10.0}}},{{{0.0,1.0}},{{3.0,2.0}},{{5.0,4.0}}}},"4294967297/(2, 3, 1, 2)/float32/flip/3/out_same values")
deep(x:tolist(),{{{{6.0,7.0}},{{8.0,9.0}},{{11.0,10.0}}},{{{0.0,1.0}},{{3.0,2.0}},{{5.0,4.0}}}},"4294967297/(2, 3, 1, 2)/float32/flip/3/out_same source")
assert(rawequal(y,x),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float32/flip/3/out_same pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.flip(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float32"),1)
local before=x:tolist()
local y=r:permuted(x,-1)
deep(y.dtype,"float32","4294967297/(2, 3, 1, 2)/float32/flip/-1/copy dtype")
deep(y:tolist(),{{{{6.0,7.0}},{{8.0,9.0}},{{11.0,10.0}}},{{{0.0,1.0}},{{3.0,2.0}},{{5.0,4.0}}}},"4294967297/(2, 3, 1, 2)/float32/flip/-1/copy values")
deep(x:tolist(),{{{{6.0,7.0}},{{8.0,9.0}},{{10.0,11.0}}},{{{0.0,1.0}},{{2.0,3.0}},{{4.0,5.0}}}},"4294967297/(2, 3, 1, 2)/float32/flip/-1/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float32/flip/-1/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.flip(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"float32"),1)
local before=x:tolist()
local y=r:permuted(x,-1,x)
deep(y.dtype,"float32","4294967297/(2, 3, 1, 2)/float32/flip/-1/out_same dtype")
deep(y:tolist(),{{{{6.0,7.0}},{{8.0,9.0}},{{11.0,10.0}}},{{{0.0,1.0}},{{3.0,2.0}},{{5.0,4.0}}}},"4294967297/(2, 3, 1, 2)/float32/flip/-1/out_same values")
deep(x:tolist(),{{{{6.0,7.0}},{{8.0,9.0}},{{11.0,10.0}}},{{{0.0,1.0}},{{3.0,2.0}},{{5.0,4.0}}}},"4294967297/(2, 3, 1, 2)/float32/flip/-1/out_same source")
assert(rawequal(y,x),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/float32/flip/-1/out_same pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"uint8")
local before=x:tolist()
local y=r:permuted(x,nil)
deep(y.dtype,"uint8","4294967297/(2, 3, 1, 2)/uint8/plain/None/copy dtype")
deep(y:tolist(),{{{{6,2}},{{4,9}},{{7,1}}},{{{0,3}},{{5,11}},{{8,10}}}},"4294967297/(2, 3, 1, 2)/uint8/plain/None/copy values")
deep(x:tolist(),{{{{0,1}},{{2,3}},{{4,5}}},{{{6,7}},{{8,9}},{{10,11}}}},"4294967297/(2, 3, 1, 2)/uint8/plain/None/copy source")
deep(r:raw_hex(),"f3fe33f26b689233","4294967297/(2, 3, 1, 2)/uint8/plain/None/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"uint8")
local before=x:tolist()
local out=np.zeros({2,3,1,2},"uint8")
local y=r:permuted(x,nil,out)
deep(y.dtype,"uint8","4294967297/(2, 3, 1, 2)/uint8/plain/None/out_new dtype")
deep(y:tolist(),{{{{6,2}},{{4,9}},{{7,1}}},{{{0,3}},{{5,11}},{{8,10}}}},"4294967297/(2, 3, 1, 2)/uint8/plain/None/out_new values")
deep(x:tolist(),{{{{0,1}},{{2,3}},{{4,5}}},{{{6,7}},{{8,9}},{{10,11}}}},"4294967297/(2, 3, 1, 2)/uint8/plain/None/out_new source")
assert(rawequal(y,out),"out must return identical ndarray")
deep(r:raw_hex(),"f3fe33f26b689233","4294967297/(2, 3, 1, 2)/uint8/plain/None/out_new pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"uint8")
local before=x:tolist()
local y=r:permuted(x,1)
deep(y.dtype,"uint8","4294967297/(2, 3, 1, 2)/uint8/plain/0/copy dtype")
deep(y:tolist(),{{{{0,1}},{{8,3}},{{10,11}}},{{{6,7}},{{2,9}},{{4,5}}}},"4294967297/(2, 3, 1, 2)/uint8/plain/0/copy values")
deep(x:tolist(),{{{{0,1}},{{2,3}},{{4,5}}},{{{6,7}},{{8,9}},{{10,11}}}},"4294967297/(2, 3, 1, 2)/uint8/plain/0/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/uint8/plain/0/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"uint8")
local before=x:tolist()
local out=np.zeros({2,3,1,2},"uint8")
local y=r:permuted(x,1,out)
deep(y.dtype,"uint8","4294967297/(2, 3, 1, 2)/uint8/plain/0/out_new dtype")
deep(y:tolist(),{{{{0,1}},{{8,3}},{{10,11}}},{{{6,7}},{{2,9}},{{4,5}}}},"4294967297/(2, 3, 1, 2)/uint8/plain/0/out_new values")
deep(x:tolist(),{{{{0,1}},{{2,3}},{{4,5}}},{{{6,7}},{{8,9}},{{10,11}}}},"4294967297/(2, 3, 1, 2)/uint8/plain/0/out_new source")
assert(rawequal(y,out),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/uint8/plain/0/out_new pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"uint8")
local before=x:tolist()
local y=r:permuted(x,4)
deep(y.dtype,"uint8","4294967297/(2, 3, 1, 2)/uint8/plain/3/copy dtype")
deep(y:tolist(),{{{{0,1}},{{2,3}},{{5,4}}},{{{6,7}},{{9,8}},{{11,10}}}},"4294967297/(2, 3, 1, 2)/uint8/plain/3/copy values")
deep(x:tolist(),{{{{0,1}},{{2,3}},{{4,5}}},{{{6,7}},{{8,9}},{{10,11}}}},"4294967297/(2, 3, 1, 2)/uint8/plain/3/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/uint8/plain/3/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"uint8")
local before=x:tolist()
local out=np.zeros({2,3,1,2},"uint8")
local y=r:permuted(x,4,out)
deep(y.dtype,"uint8","4294967297/(2, 3, 1, 2)/uint8/plain/3/out_new dtype")
deep(y:tolist(),{{{{0,1}},{{2,3}},{{5,4}}},{{{6,7}},{{9,8}},{{11,10}}}},"4294967297/(2, 3, 1, 2)/uint8/plain/3/out_new values")
deep(x:tolist(),{{{{0,1}},{{2,3}},{{4,5}}},{{{6,7}},{{8,9}},{{10,11}}}},"4294967297/(2, 3, 1, 2)/uint8/plain/3/out_new source")
assert(rawequal(y,out),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/uint8/plain/3/out_new pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"uint8")
local before=x:tolist()
local y=r:permuted(x,-1)
deep(y.dtype,"uint8","4294967297/(2, 3, 1, 2)/uint8/plain/-1/copy dtype")
deep(y:tolist(),{{{{0,1}},{{2,3}},{{5,4}}},{{{6,7}},{{9,8}},{{11,10}}}},"4294967297/(2, 3, 1, 2)/uint8/plain/-1/copy values")
deep(x:tolist(),{{{{0,1}},{{2,3}},{{4,5}}},{{{6,7}},{{8,9}},{{10,11}}}},"4294967297/(2, 3, 1, 2)/uint8/plain/-1/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/uint8/plain/-1/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"uint8")
local before=x:tolist()
local out=np.zeros({2,3,1,2},"uint8")
local y=r:permuted(x,-1,out)
deep(y.dtype,"uint8","4294967297/(2, 3, 1, 2)/uint8/plain/-1/out_new dtype")
deep(y:tolist(),{{{{0,1}},{{2,3}},{{5,4}}},{{{6,7}},{{9,8}},{{11,10}}}},"4294967297/(2, 3, 1, 2)/uint8/plain/-1/out_new values")
deep(x:tolist(),{{{{0,1}},{{2,3}},{{4,5}}},{{{6,7}},{{8,9}},{{10,11}}}},"4294967297/(2, 3, 1, 2)/uint8/plain/-1/out_new source")
assert(rawequal(y,out),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/uint8/plain/-1/out_new pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"uint8"),{4,3,2,1})
local before=x:tolist()
local y=r:permuted(x,nil)
deep(y.dtype,"uint8","4294967297/(2, 3, 1, 2)/uint8/transpose/None/copy dtype")
deep(y:tolist(),{{{{6,0},{4,5},{7,8}}},{{{2,3},{9,11},{1,10}}}},"4294967297/(2, 3, 1, 2)/uint8/transpose/None/copy values")
deep(x:tolist(),{{{{0,6},{2,8},{4,10}}},{{{1,7},{3,9},{5,11}}}},"4294967297/(2, 3, 1, 2)/uint8/transpose/None/copy source")
deep(r:raw_hex(),"f3fe33f26b689233","4294967297/(2, 3, 1, 2)/uint8/transpose/None/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"uint8"),{4,3,2,1})
local before=x:tolist()
local out=np.zeros({2,1,3,2},"uint8")
local y=r:permuted(x,nil,out)
deep(y.dtype,"uint8","4294967297/(2, 3, 1, 2)/uint8/transpose/None/out_new dtype")
deep(y:tolist(),{{{{1,2},{4,9},{7,6}}},{{{0,8},{10,11},{3,5}}}},"4294967297/(2, 3, 1, 2)/uint8/transpose/None/out_new values")
deep(x:tolist(),{{{{0,6},{2,8},{4,10}}},{{{1,7},{3,9},{5,11}}}},"4294967297/(2, 3, 1, 2)/uint8/transpose/None/out_new source")
assert(rawequal(y,out),"out must return identical ndarray")
deep(r:raw_hex(),"f3fe33f26b689233","4294967297/(2, 3, 1, 2)/uint8/transpose/None/out_new pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"uint8"),{4,3,2,1})
local before=x:tolist()
local y=r:permuted(x,1)
deep(y.dtype,"uint8","4294967297/(2, 3, 1, 2)/uint8/transpose/0/copy dtype")
deep(y:tolist(),{{{{0,6},{3,8},{5,11}}},{{{1,7},{2,9},{4,10}}}},"4294967297/(2, 3, 1, 2)/uint8/transpose/0/copy values")
deep(x:tolist(),{{{{0,6},{2,8},{4,10}}},{{{1,7},{3,9},{5,11}}}},"4294967297/(2, 3, 1, 2)/uint8/transpose/0/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/uint8/transpose/0/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"uint8"),{4,3,2,1})
local before=x:tolist()
local out=np.zeros({2,1,3,2},"uint8")
local y=r:permuted(x,1,out)
deep(y.dtype,"uint8","4294967297/(2, 3, 1, 2)/uint8/transpose/0/out_new dtype")
deep(y:tolist(),{{{{0,6},{3,8},{5,11}}},{{{1,7},{2,9},{4,10}}}},"4294967297/(2, 3, 1, 2)/uint8/transpose/0/out_new values")
deep(x:tolist(),{{{{0,6},{2,8},{4,10}}},{{{1,7},{3,9},{5,11}}}},"4294967297/(2, 3, 1, 2)/uint8/transpose/0/out_new source")
assert(rawequal(y,out),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/uint8/transpose/0/out_new pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"uint8"),{4,3,2,1})
local before=x:tolist()
local y=r:permuted(x,4)
deep(y.dtype,"uint8","4294967297/(2, 3, 1, 2)/uint8/transpose/3/copy dtype")
deep(y:tolist(),{{{{0,6},{2,8},{10,4}}},{{{1,7},{9,3},{11,5}}}},"4294967297/(2, 3, 1, 2)/uint8/transpose/3/copy values")
deep(x:tolist(),{{{{0,6},{2,8},{4,10}}},{{{1,7},{3,9},{5,11}}}},"4294967297/(2, 3, 1, 2)/uint8/transpose/3/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/uint8/transpose/3/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"uint8"),{4,3,2,1})
local before=x:tolist()
local out=np.zeros({2,1,3,2},"uint8")
local y=r:permuted(x,4,out)
deep(y.dtype,"uint8","4294967297/(2, 3, 1, 2)/uint8/transpose/3/out_new dtype")
deep(y:tolist(),{{{{0,6},{2,8},{10,4}}},{{{1,7},{9,3},{11,5}}}},"4294967297/(2, 3, 1, 2)/uint8/transpose/3/out_new values")
deep(x:tolist(),{{{{0,6},{2,8},{4,10}}},{{{1,7},{3,9},{5,11}}}},"4294967297/(2, 3, 1, 2)/uint8/transpose/3/out_new source")
assert(rawequal(y,out),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/uint8/transpose/3/out_new pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"uint8"),{4,3,2,1})
local before=x:tolist()
local y=r:permuted(x,-1)
deep(y.dtype,"uint8","4294967297/(2, 3, 1, 2)/uint8/transpose/-1/copy dtype")
deep(y:tolist(),{{{{0,6},{2,8},{10,4}}},{{{1,7},{9,3},{11,5}}}},"4294967297/(2, 3, 1, 2)/uint8/transpose/-1/copy values")
deep(x:tolist(),{{{{0,6},{2,8},{4,10}}},{{{1,7},{3,9},{5,11}}}},"4294967297/(2, 3, 1, 2)/uint8/transpose/-1/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/uint8/transpose/-1/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"uint8"),{4,3,2,1})
local before=x:tolist()
local out=np.zeros({2,1,3,2},"uint8")
local y=r:permuted(x,-1,out)
deep(y.dtype,"uint8","4294967297/(2, 3, 1, 2)/uint8/transpose/-1/out_new dtype")
deep(y:tolist(),{{{{0,6},{2,8},{10,4}}},{{{1,7},{9,3},{11,5}}}},"4294967297/(2, 3, 1, 2)/uint8/transpose/-1/out_new values")
deep(x:tolist(),{{{{0,6},{2,8},{4,10}}},{{{1,7},{3,9},{5,11}}}},"4294967297/(2, 3, 1, 2)/uint8/transpose/-1/out_new source")
assert(rawequal(y,out),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/uint8/transpose/-1/out_new pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.flip(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"uint8"),1)
local before=x:tolist()
local y=r:permuted(x,nil)
deep(y.dtype,"uint8","4294967297/(2, 3, 1, 2)/uint8/flip/None/copy dtype")
deep(y:tolist(),{{{{0,8}},{{10,3}},{{1,7}}},{{{6,9}},{{11,5}},{{2,4}}}},"4294967297/(2, 3, 1, 2)/uint8/flip/None/copy values")
deep(x:tolist(),{{{{6,7}},{{8,9}},{{10,11}}},{{{0,1}},{{2,3}},{{4,5}}}},"4294967297/(2, 3, 1, 2)/uint8/flip/None/copy source")
deep(r:raw_hex(),"f3fe33f26b689233","4294967297/(2, 3, 1, 2)/uint8/flip/None/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.flip(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"uint8"),1)
local before=x:tolist()
local y=r:permuted(x,1)
deep(y.dtype,"uint8","4294967297/(2, 3, 1, 2)/uint8/flip/0/copy dtype")
deep(y:tolist(),{{{{6,7}},{{2,9}},{{4,5}}},{{{0,1}},{{8,3}},{{10,11}}}},"4294967297/(2, 3, 1, 2)/uint8/flip/0/copy values")
deep(x:tolist(),{{{{6,7}},{{8,9}},{{10,11}}},{{{0,1}},{{2,3}},{{4,5}}}},"4294967297/(2, 3, 1, 2)/uint8/flip/0/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/uint8/flip/0/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.flip(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"uint8"),1)
local before=x:tolist()
local y=r:permuted(x,4)
deep(y.dtype,"uint8","4294967297/(2, 3, 1, 2)/uint8/flip/3/copy dtype")
deep(y:tolist(),{{{{6,7}},{{8,9}},{{11,10}}},{{{0,1}},{{3,2}},{{5,4}}}},"4294967297/(2, 3, 1, 2)/uint8/flip/3/copy values")
deep(x:tolist(),{{{{6,7}},{{8,9}},{{10,11}}},{{{0,1}},{{2,3}},{{4,5}}}},"4294967297/(2, 3, 1, 2)/uint8/flip/3/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/uint8/flip/3/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.flip(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"uint8"),1)
local before=x:tolist()
local y=r:permuted(x,-1)
deep(y.dtype,"uint8","4294967297/(2, 3, 1, 2)/uint8/flip/-1/copy dtype")
deep(y:tolist(),{{{{6,7}},{{8,9}},{{11,10}}},{{{0,1}},{{3,2}},{{5,4}}}},"4294967297/(2, 3, 1, 2)/uint8/flip/-1/copy values")
deep(x:tolist(),{{{{6,7}},{{8,9}},{{10,11}}},{{{0,1}},{{2,3}},{{4,5}}}},"4294967297/(2, 3, 1, 2)/uint8/flip/-1/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/uint8/flip/-1/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"bool")
local before=x:tolist()
local y=r:permuted(x,nil)
deep(y.dtype,"bool","4294967297/(2, 3, 1, 2)/bool/plain/None/copy dtype")
deep(y:tolist(),{{{{true,true}},{{true,true}},{{true,true}}},{{{false,true}},{{true,true}},{{true,true}}}},"4294967297/(2, 3, 1, 2)/bool/plain/None/copy values")
deep(x:tolist(),{{{{false,true}},{{true,true}},{{true,true}}},{{{true,true}},{{true,true}},{{true,true}}}},"4294967297/(2, 3, 1, 2)/bool/plain/None/copy source")
deep(r:raw_hex(),"f3fe33f26b689233","4294967297/(2, 3, 1, 2)/bool/plain/None/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"bool")
local before=x:tolist()
local out=np.zeros({2,3,1,2},"bool")
local y=r:permuted(x,nil,out)
deep(y.dtype,"bool","4294967297/(2, 3, 1, 2)/bool/plain/None/out_new dtype")
deep(y:tolist(),{{{{true,true}},{{true,true}},{{true,true}}},{{{false,true}},{{true,true}},{{true,true}}}},"4294967297/(2, 3, 1, 2)/bool/plain/None/out_new values")
deep(x:tolist(),{{{{false,true}},{{true,true}},{{true,true}}},{{{true,true}},{{true,true}},{{true,true}}}},"4294967297/(2, 3, 1, 2)/bool/plain/None/out_new source")
assert(rawequal(y,out),"out must return identical ndarray")
deep(r:raw_hex(),"f3fe33f26b689233","4294967297/(2, 3, 1, 2)/bool/plain/None/out_new pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"bool")
local before=x:tolist()
local y=r:permuted(x,1)
deep(y.dtype,"bool","4294967297/(2, 3, 1, 2)/bool/plain/0/copy dtype")
deep(y:tolist(),{{{{false,true}},{{true,true}},{{true,true}}},{{{true,true}},{{true,true}},{{true,true}}}},"4294967297/(2, 3, 1, 2)/bool/plain/0/copy values")
deep(x:tolist(),{{{{false,true}},{{true,true}},{{true,true}}},{{{true,true}},{{true,true}},{{true,true}}}},"4294967297/(2, 3, 1, 2)/bool/plain/0/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/bool/plain/0/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"bool")
local before=x:tolist()
local out=np.zeros({2,3,1,2},"bool")
local y=r:permuted(x,1,out)
deep(y.dtype,"bool","4294967297/(2, 3, 1, 2)/bool/plain/0/out_new dtype")
deep(y:tolist(),{{{{false,true}},{{true,true}},{{true,true}}},{{{true,true}},{{true,true}},{{true,true}}}},"4294967297/(2, 3, 1, 2)/bool/plain/0/out_new values")
deep(x:tolist(),{{{{false,true}},{{true,true}},{{true,true}}},{{{true,true}},{{true,true}},{{true,true}}}},"4294967297/(2, 3, 1, 2)/bool/plain/0/out_new source")
assert(rawequal(y,out),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/bool/plain/0/out_new pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"bool")
local before=x:tolist()
local y=r:permuted(x,4)
deep(y.dtype,"bool","4294967297/(2, 3, 1, 2)/bool/plain/3/copy dtype")
deep(y:tolist(),{{{{false,true}},{{true,true}},{{true,true}}},{{{true,true}},{{true,true}},{{true,true}}}},"4294967297/(2, 3, 1, 2)/bool/plain/3/copy values")
deep(x:tolist(),{{{{false,true}},{{true,true}},{{true,true}}},{{{true,true}},{{true,true}},{{true,true}}}},"4294967297/(2, 3, 1, 2)/bool/plain/3/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/bool/plain/3/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"bool")
local before=x:tolist()
local out=np.zeros({2,3,1,2},"bool")
local y=r:permuted(x,4,out)
deep(y.dtype,"bool","4294967297/(2, 3, 1, 2)/bool/plain/3/out_new dtype")
deep(y:tolist(),{{{{false,true}},{{true,true}},{{true,true}}},{{{true,true}},{{true,true}},{{true,true}}}},"4294967297/(2, 3, 1, 2)/bool/plain/3/out_new values")
deep(x:tolist(),{{{{false,true}},{{true,true}},{{true,true}}},{{{true,true}},{{true,true}},{{true,true}}}},"4294967297/(2, 3, 1, 2)/bool/plain/3/out_new source")
assert(rawequal(y,out),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/bool/plain/3/out_new pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"bool")
local before=x:tolist()
local y=r:permuted(x,-1)
deep(y.dtype,"bool","4294967297/(2, 3, 1, 2)/bool/plain/-1/copy dtype")
deep(y:tolist(),{{{{false,true}},{{true,true}},{{true,true}}},{{{true,true}},{{true,true}},{{true,true}}}},"4294967297/(2, 3, 1, 2)/bool/plain/-1/copy values")
deep(x:tolist(),{{{{false,true}},{{true,true}},{{true,true}}},{{{true,true}},{{true,true}},{{true,true}}}},"4294967297/(2, 3, 1, 2)/bool/plain/-1/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/bool/plain/-1/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"bool")
local before=x:tolist()
local out=np.zeros({2,3,1,2},"bool")
local y=r:permuted(x,-1,out)
deep(y.dtype,"bool","4294967297/(2, 3, 1, 2)/bool/plain/-1/out_new dtype")
deep(y:tolist(),{{{{false,true}},{{true,true}},{{true,true}}},{{{true,true}},{{true,true}},{{true,true}}}},"4294967297/(2, 3, 1, 2)/bool/plain/-1/out_new values")
deep(x:tolist(),{{{{false,true}},{{true,true}},{{true,true}}},{{{true,true}},{{true,true}},{{true,true}}}},"4294967297/(2, 3, 1, 2)/bool/plain/-1/out_new source")
assert(rawequal(y,out),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/bool/plain/-1/out_new pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"bool"),{4,3,2,1})
local before=x:tolist()
local y=r:permuted(x,nil)
deep(y.dtype,"bool","4294967297/(2, 3, 1, 2)/bool/transpose/None/copy dtype")
deep(y:tolist(),{{{{true,false},{true,true},{true,true}}},{{{true,true},{true,true},{true,true}}}},"4294967297/(2, 3, 1, 2)/bool/transpose/None/copy values")
deep(x:tolist(),{{{{false,true},{true,true},{true,true}}},{{{true,true},{true,true},{true,true}}}},"4294967297/(2, 3, 1, 2)/bool/transpose/None/copy source")
deep(r:raw_hex(),"f3fe33f26b689233","4294967297/(2, 3, 1, 2)/bool/transpose/None/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"bool"),{4,3,2,1})
local before=x:tolist()
local out=np.zeros({2,1,3,2},"bool")
local y=r:permuted(x,nil,out)
deep(y.dtype,"bool","4294967297/(2, 3, 1, 2)/bool/transpose/None/out_new dtype")
deep(y:tolist(),{{{{true,true},{true,true},{true,true}}},{{{false,true},{true,true},{true,true}}}},"4294967297/(2, 3, 1, 2)/bool/transpose/None/out_new values")
deep(x:tolist(),{{{{false,true},{true,true},{true,true}}},{{{true,true},{true,true},{true,true}}}},"4294967297/(2, 3, 1, 2)/bool/transpose/None/out_new source")
assert(rawequal(y,out),"out must return identical ndarray")
deep(r:raw_hex(),"f3fe33f26b689233","4294967297/(2, 3, 1, 2)/bool/transpose/None/out_new pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"bool"),{4,3,2,1})
local before=x:tolist()
local y=r:permuted(x,1)
deep(y.dtype,"bool","4294967297/(2, 3, 1, 2)/bool/transpose/0/copy dtype")
deep(y:tolist(),{{{{false,true},{true,true},{true,true}}},{{{true,true},{true,true},{true,true}}}},"4294967297/(2, 3, 1, 2)/bool/transpose/0/copy values")
deep(x:tolist(),{{{{false,true},{true,true},{true,true}}},{{{true,true},{true,true},{true,true}}}},"4294967297/(2, 3, 1, 2)/bool/transpose/0/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/bool/transpose/0/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"bool"),{4,3,2,1})
local before=x:tolist()
local out=np.zeros({2,1,3,2},"bool")
local y=r:permuted(x,1,out)
deep(y.dtype,"bool","4294967297/(2, 3, 1, 2)/bool/transpose/0/out_new dtype")
deep(y:tolist(),{{{{false,true},{true,true},{true,true}}},{{{true,true},{true,true},{true,true}}}},"4294967297/(2, 3, 1, 2)/bool/transpose/0/out_new values")
deep(x:tolist(),{{{{false,true},{true,true},{true,true}}},{{{true,true},{true,true},{true,true}}}},"4294967297/(2, 3, 1, 2)/bool/transpose/0/out_new source")
assert(rawequal(y,out),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/bool/transpose/0/out_new pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"bool"),{4,3,2,1})
local before=x:tolist()
local y=r:permuted(x,4)
deep(y.dtype,"bool","4294967297/(2, 3, 1, 2)/bool/transpose/3/copy dtype")
deep(y:tolist(),{{{{false,true},{true,true},{true,true}}},{{{true,true},{true,true},{true,true}}}},"4294967297/(2, 3, 1, 2)/bool/transpose/3/copy values")
deep(x:tolist(),{{{{false,true},{true,true},{true,true}}},{{{true,true},{true,true},{true,true}}}},"4294967297/(2, 3, 1, 2)/bool/transpose/3/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/bool/transpose/3/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"bool"),{4,3,2,1})
local before=x:tolist()
local out=np.zeros({2,1,3,2},"bool")
local y=r:permuted(x,4,out)
deep(y.dtype,"bool","4294967297/(2, 3, 1, 2)/bool/transpose/3/out_new dtype")
deep(y:tolist(),{{{{false,true},{true,true},{true,true}}},{{{true,true},{true,true},{true,true}}}},"4294967297/(2, 3, 1, 2)/bool/transpose/3/out_new values")
deep(x:tolist(),{{{{false,true},{true,true},{true,true}}},{{{true,true},{true,true},{true,true}}}},"4294967297/(2, 3, 1, 2)/bool/transpose/3/out_new source")
assert(rawequal(y,out),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/bool/transpose/3/out_new pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"bool"),{4,3,2,1})
local before=x:tolist()
local y=r:permuted(x,-1)
deep(y.dtype,"bool","4294967297/(2, 3, 1, 2)/bool/transpose/-1/copy dtype")
deep(y:tolist(),{{{{false,true},{true,true},{true,true}}},{{{true,true},{true,true},{true,true}}}},"4294967297/(2, 3, 1, 2)/bool/transpose/-1/copy values")
deep(x:tolist(),{{{{false,true},{true,true},{true,true}}},{{{true,true},{true,true},{true,true}}}},"4294967297/(2, 3, 1, 2)/bool/transpose/-1/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/bool/transpose/-1/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.transpose(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"bool"),{4,3,2,1})
local before=x:tolist()
local out=np.zeros({2,1,3,2},"bool")
local y=r:permuted(x,-1,out)
deep(y.dtype,"bool","4294967297/(2, 3, 1, 2)/bool/transpose/-1/out_new dtype")
deep(y:tolist(),{{{{false,true},{true,true},{true,true}}},{{{true,true},{true,true},{true,true}}}},"4294967297/(2, 3, 1, 2)/bool/transpose/-1/out_new values")
deep(x:tolist(),{{{{false,true},{true,true},{true,true}}},{{{true,true},{true,true},{true,true}}}},"4294967297/(2, 3, 1, 2)/bool/transpose/-1/out_new source")
assert(rawequal(y,out),"out must return identical ndarray")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/bool/transpose/-1/out_new pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.flip(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"bool"),1)
local before=x:tolist()
local y=r:permuted(x,nil)
deep(y.dtype,"bool","4294967297/(2, 3, 1, 2)/bool/flip/None/copy dtype")
deep(y:tolist(),{{{{false,true}},{{true,true}},{{true,true}}},{{{true,true}},{{true,true}},{{true,true}}}},"4294967297/(2, 3, 1, 2)/bool/flip/None/copy values")
deep(x:tolist(),{{{{true,true}},{{true,true}},{{true,true}}},{{{false,true}},{{true,true}},{{true,true}}}},"4294967297/(2, 3, 1, 2)/bool/flip/None/copy source")
deep(r:raw_hex(),"f3fe33f26b689233","4294967297/(2, 3, 1, 2)/bool/flip/None/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.flip(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"bool"),1)
local before=x:tolist()
local y=r:permuted(x,1)
deep(y.dtype,"bool","4294967297/(2, 3, 1, 2)/bool/flip/0/copy dtype")
deep(y:tolist(),{{{{true,true}},{{true,true}},{{true,true}}},{{{false,true}},{{true,true}},{{true,true}}}},"4294967297/(2, 3, 1, 2)/bool/flip/0/copy values")
deep(x:tolist(),{{{{true,true}},{{true,true}},{{true,true}}},{{{false,true}},{{true,true}},{{true,true}}}},"4294967297/(2, 3, 1, 2)/bool/flip/0/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/bool/flip/0/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.flip(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"bool"),1)
local before=x:tolist()
local y=r:permuted(x,4)
deep(y.dtype,"bool","4294967297/(2, 3, 1, 2)/bool/flip/3/copy dtype")
deep(y:tolist(),{{{{true,true}},{{true,true}},{{true,true}}},{{{false,true}},{{true,true}},{{true,true}}}},"4294967297/(2, 3, 1, 2)/bool/flip/3/copy values")
deep(x:tolist(),{{{{true,true}},{{true,true}},{{true,true}}},{{{false,true}},{{true,true}},{{true,true}}}},"4294967297/(2, 3, 1, 2)/bool/flip/3/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/bool/flip/3/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(4294967297)
local x=np.flip(np.astype(np.arange(12,"int64"):reshape({2,3,1,2}),"bool"),1)
local before=x:tolist()
local y=r:permuted(x,-1)
deep(y.dtype,"bool","4294967297/(2, 3, 1, 2)/bool/flip/-1/copy dtype")
deep(y:tolist(),{{{{true,true}},{{true,true}},{{true,true}}},{{{false,true}},{{true,true}},{{true,true}}}},"4294967297/(2, 3, 1, 2)/bool/flip/-1/copy values")
deep(x:tolist(),{{{{true,true}},{{true,true}},{{true,true}}},{{{false,true}},{{true,true}},{{true,true}}}},"4294967297/(2, 3, 1, 2)/bool/flip/-1/copy source")
deep(r:raw_hex(),"2803284383ad7625","4294967297/(2, 3, 1, 2)/bool/flip/-1/copy pcg")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.astype(np.arange(12,"int64"):reshape({3,4}),"int32")
local out=np.flip(np.zeros({3,4},"int32"),1)
local y=r:permuted(x,nil,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{9,2,7,4},{5,11,0,3},{6,10,8,1}},"extra/0/(3, 4)/None/view values")
deep(r:raw_hex(),"d0dbc74d4700374c","extra/0/(3, 4)/None/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.astype(np.arange(12,"int64"):reshape({3,4}),"int32")
local out=np.zeros({3,4},"float64")
local y=r:permuted(x,nil,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{9.0,2.0,7.0,4.0},{5.0,11.0,0.0,3.0},{6.0,10.0,8.0,1.0}},"extra/0/(3, 4)/None/cast values")
deep(r:raw_hex(),"d0dbc74d4700374c","extra/0/(3, 4)/None/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.astype(np.arange(12,"int64"):reshape({3,4}),"int32")
local out=np.flip(np.zeros({3,4},"int32"),1)
local y=r:permuted(x,1,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{8,9,10,7},{0,5,2,11},{4,1,6,3}},"extra/0/(3, 4)/0/view values")
deep(r:raw_hex(),"9b4c7b7180edb27f","extra/0/(3, 4)/0/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.astype(np.arange(12,"int64"):reshape({3,4}),"int32")
local out=np.zeros({3,4},"float64")
local y=r:permuted(x,1,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{8.0,9.0,10.0,7.0},{0.0,5.0,2.0,11.0},{4.0,1.0,6.0,3.0}},"extra/0/(3, 4)/0/cast values")
deep(r:raw_hex(),"9b4c7b7180edb27f","extra/0/(3, 4)/0/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.astype(np.arange(12,"int64"):reshape({3,4}),"int32")
local out=np.flip(np.zeros({3,4},"int32"),1)
local y=r:permuted(x,2,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{2,0,1,3},{7,6,5,4},{9,11,8,10}},"extra/0/(3, 4)/1/view values")
deep(r:raw_hex(),"9b4c7b7180edb27f","extra/0/(3, 4)/1/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.astype(np.arange(12,"int64"):reshape({3,4}),"int32")
local out=np.zeros({3,4},"float64")
local y=r:permuted(x,2,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{2.0,0.0,1.0,3.0},{7.0,6.0,5.0,4.0},{9.0,11.0,8.0,10.0}},"extra/0/(3, 4)/1/cast values")
deep(r:raw_hex(),"9b4c7b7180edb27f","extra/0/(3, 4)/1/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.astype(np.arange(9,"int64"):reshape({3,3}),"int32")
local out=np.flip(np.zeros({3,3},"int32"),1)
local y=r:permuted(x,nil,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{4,5,2},{6,3,8},{7,0,1}},"extra/0/(3, 3)/None/view values")
deep(r:raw_hex(),"9b4c7b7180edb27f","extra/0/(3, 3)/None/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.astype(np.arange(9,"int64"):reshape({3,3}),"int32")
local out=np.transpose(x,{2,1})
local y=r:permuted(x,nil,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{4,2,5},{7,1,0},{6,8,3}},"extra/0/(3, 3)/None/alias values")
deep(r:raw_hex(),"9b4c7b7180edb27f","extra/0/(3, 3)/None/alias pcg")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.astype(np.arange(9,"int64"):reshape({3,3}),"int32")
local out=np.zeros({3,3},"float64")
local y=r:permuted(x,nil,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{4.0,5.0,2.0},{6.0,3.0,8.0},{7.0,0.0,1.0}},"extra/0/(3, 3)/None/cast values")
deep(r:raw_hex(),"9b4c7b7180edb27f","extra/0/(3, 3)/None/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.astype(np.arange(9,"int64"):reshape({3,3}),"int32")
local out=np.flip(np.zeros({3,3},"int32"),1)
local y=r:permuted(x,1,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{6,7,8},{0,4,2},{3,1,5}},"extra/0/(3, 3)/0/view values")
deep(r:raw_hex(),"d0327a782cde513b","extra/0/(3, 3)/0/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.astype(np.arange(9,"int64"):reshape({3,3}),"int32")
local out=np.transpose(x,{2,1})
local y=r:permuted(x,1,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{6,7,8},{0,4,2},{3,1,5}},"extra/0/(3, 3)/0/alias values")
deep(r:raw_hex(),"d0327a782cde513b","extra/0/(3, 3)/0/alias pcg")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.astype(np.arange(9,"int64"):reshape({3,3}),"int32")
local out=np.zeros({3,3},"float64")
local y=r:permuted(x,1,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{6.0,7.0,8.0},{0.0,4.0,2.0},{3.0,1.0,5.0}},"extra/0/(3, 3)/0/cast values")
deep(r:raw_hex(),"d0327a782cde513b","extra/0/(3, 3)/0/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.astype(np.arange(9,"int64"):reshape({3,3}),"int32")
local out=np.flip(np.zeros({3,3},"int32"),1)
local y=r:permuted(x,2,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{2,0,1},{5,4,3},{8,6,7}},"extra/0/(3, 3)/1/view values")
deep(r:raw_hex(),"d0327a782cde513b","extra/0/(3, 3)/1/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.astype(np.arange(9,"int64"):reshape({3,3}),"int32")
local out=np.transpose(x,{2,1})
local y=r:permuted(x,2,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{2,0,1},{5,4,3},{8,6,7}},"extra/0/(3, 3)/1/alias values")
deep(r:raw_hex(),"d0327a782cde513b","extra/0/(3, 3)/1/alias pcg")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.astype(np.arange(9,"int64"):reshape({3,3}),"int32")
local out=np.zeros({3,3},"float64")
local y=r:permuted(x,2,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{2.0,0.0,1.0},{5.0,4.0,3.0},{8.0,6.0,7.0}},"extra/0/(3, 3)/1/cast values")
deep(r:raw_hex(),"d0327a782cde513b","extra/0/(3, 3)/1/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.astype(np.arange(24,"int64"):reshape({2,3,4}),"int32")
local out=np.flip(np.zeros({2,3,4},"int32"),1)
local y=r:permuted(x,nil,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{{18,4,21,10},{11,2,22,6},{23,3,20,8}},{{0,16,12,19},{13,7,5,17},{14,9,1,15}}},"extra/0/(2, 3, 4)/None/view values")
deep(r:raw_hex(),"073ff53d673aa30c","extra/0/(2, 3, 4)/None/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.astype(np.arange(24,"int64"):reshape({2,3,4}),"int32")
local out=np.zeros({2,3,4},"float64")
local y=r:permuted(x,nil,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{{18.0,4.0,21.0,10.0},{11.0,2.0,22.0,6.0},{23.0,3.0,20.0,8.0}},{{0.0,16.0,12.0,19.0},{13.0,7.0,5.0,17.0},{14.0,9.0,1.0,15.0}}},"extra/0/(2, 3, 4)/None/cast values")
deep(r:raw_hex(),"073ff53d673aa30c","extra/0/(2, 3, 4)/None/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.astype(np.arange(24,"int64"):reshape({2,3,4}),"int32")
local out=np.flip(np.zeros({2,3,4},"int32"),1)
local y=r:permuted(x,1,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{{0,1,2,15},{16,5,6,19},{8,21,22,11}},{{12,13,14,3},{4,17,18,7},{20,9,10,23}}},"extra/0/(2, 3, 4)/0/view values")
deep(r:raw_hex(),"9b4c7b7180edb27f","extra/0/(2, 3, 4)/0/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.astype(np.arange(24,"int64"):reshape({2,3,4}),"int32")
local out=np.zeros({2,3,4},"float64")
local y=r:permuted(x,1,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{{0.0,1.0,2.0,15.0},{16.0,5.0,6.0,19.0},{8.0,21.0,22.0,11.0}},{{12.0,13.0,14.0,3.0},{4.0,17.0,18.0,7.0},{20.0,9.0,10.0,23.0}}},"extra/0/(2, 3, 4)/0/cast values")
deep(r:raw_hex(),"9b4c7b7180edb27f","extra/0/(2, 3, 4)/0/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.astype(np.arange(24,"int64"):reshape({2,3,4}),"int32")
local out=np.flip(np.zeros({2,3,4},"int32"),1)
local y=r:permuted(x,3,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{{2,0,1,3},{7,6,5,4},{9,11,8,10}},{{12,14,15,13},{16,18,17,19},{22,23,21,20}}},"extra/0/(2, 3, 4)/2/view values")
deep(r:raw_hex(),"db7ed8bf64e6f5f0","extra/0/(2, 3, 4)/2/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.astype(np.arange(24,"int64"):reshape({2,3,4}),"int32")
local out=np.zeros({2,3,4},"float64")
local y=r:permuted(x,3,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{{2.0,0.0,1.0,3.0},{7.0,6.0,5.0,4.0},{9.0,11.0,8.0,10.0}},{{12.0,14.0,15.0,13.0},{16.0,18.0,17.0,19.0},{22.0,23.0,21.0,20.0}}},"extra/0/(2, 3, 4)/2/cast values")
deep(r:raw_hex(),"db7ed8bf64e6f5f0","extra/0/(2, 3, 4)/2/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.astype(np.arange(0,"int64"):reshape({2,0,3}),"int32")
local out=np.flip(np.zeros({2,0,3},"int32"),1)
local y=r:permuted(x,nil,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{},{}},"extra/0/(2, 0, 3)/None/view values")
deep(r:raw_hex(),"a30febcfd9c2825f","extra/0/(2, 0, 3)/None/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.astype(np.arange(0,"int64"):reshape({2,0,3}),"int32")
local out=np.zeros({2,0,3},"float64")
local y=r:permuted(x,nil,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{},{}},"extra/0/(2, 0, 3)/None/cast values")
deep(r:raw_hex(),"a30febcfd9c2825f","extra/0/(2, 0, 3)/None/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.astype(np.arange(0,"int64"):reshape({2,0,3}),"int32")
local out=np.flip(np.zeros({2,0,3},"int32"),1)
local y=r:permuted(x,1,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{},{}},"extra/0/(2, 0, 3)/0/view values")
deep(r:raw_hex(),"a30febcfd9c2825f","extra/0/(2, 0, 3)/0/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.astype(np.arange(0,"int64"):reshape({2,0,3}),"int32")
local out=np.zeros({2,0,3},"float64")
local y=r:permuted(x,1,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{},{}},"extra/0/(2, 0, 3)/0/cast values")
deep(r:raw_hex(),"a30febcfd9c2825f","extra/0/(2, 0, 3)/0/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.astype(np.arange(0,"int64"):reshape({2,0,3}),"int32")
local out=np.flip(np.zeros({2,0,3},"int32"),1)
local y=r:permuted(x,3,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{},{}},"extra/0/(2, 0, 3)/2/view values")
deep(r:raw_hex(),"a30febcfd9c2825f","extra/0/(2, 0, 3)/2/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.astype(np.arange(0,"int64"):reshape({2,0,3}),"int32")
local out=np.zeros({2,0,3},"float64")
local y=r:permuted(x,3,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{},{}},"extra/0/(2, 0, 3)/2/cast values")
deep(r:raw_hex(),"a30febcfd9c2825f","extra/0/(2, 0, 3)/2/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.astype(np.arange(12,"int64"):reshape({3,4}),"int32")
local out=np.flip(np.zeros({3,4},"int32"),1)
local y=r:permuted(x,nil,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{8,11,4,7},{5,0,1,9},{2,10,6,3}},"extra/1/(3, 4)/None/view values")
deep(r:raw_hex(),"68c1464c41ca3aca","extra/1/(3, 4)/None/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.astype(np.arange(12,"int64"):reshape({3,4}),"int32")
local out=np.zeros({3,4},"float64")
local y=r:permuted(x,nil,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{8.0,11.0,4.0,7.0},{5.0,0.0,1.0,9.0},{2.0,10.0,6.0,3.0}},"extra/1/(3, 4)/None/cast values")
deep(r:raw_hex(),"68c1464c41ca3aca","extra/1/(3, 4)/None/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.astype(np.arange(12,"int64"):reshape({3,4}),"int32")
local out=np.flip(np.zeros({3,4},"int32"),1)
local y=r:permuted(x,1,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{0,9,6,11},{4,1,2,3},{8,5,10,7}},"extra/1/(3, 4)/0/view values")
deep(r:raw_hex(),"6c5f1f45de787048","extra/1/(3, 4)/0/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.astype(np.arange(12,"int64"):reshape({3,4}),"int32")
local out=np.zeros({3,4},"float64")
local y=r:permuted(x,1,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{0.0,9.0,6.0,11.0},{4.0,1.0,2.0,3.0},{8.0,5.0,10.0,7.0}},"extra/1/(3, 4)/0/cast values")
deep(r:raw_hex(),"6c5f1f45de787048","extra/1/(3, 4)/0/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.astype(np.arange(12,"int64"):reshape({3,4}),"int32")
local out=np.flip(np.zeros({3,4},"int32"),1)
local y=r:permuted(x,2,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{0,1,2,3},{7,4,6,5},{11,8,9,10}},"extra/1/(3, 4)/1/view values")
deep(r:raw_hex(),"6c5f1f45de787048","extra/1/(3, 4)/1/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.astype(np.arange(12,"int64"):reshape({3,4}),"int32")
local out=np.zeros({3,4},"float64")
local y=r:permuted(x,2,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{0.0,1.0,2.0,3.0},{7.0,4.0,6.0,5.0},{11.0,8.0,9.0,10.0}},"extra/1/(3, 4)/1/cast values")
deep(r:raw_hex(),"6c5f1f45de787048","extra/1/(3, 4)/1/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.astype(np.arange(9,"int64"):reshape({3,3}),"int32")
local out=np.flip(np.zeros({3,3},"int32"),1)
local y=r:permuted(x,nil,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{7,0,1},{4,2,5},{8,6,3}},"extra/1/(3, 3)/None/view values")
deep(r:raw_hex(),"6c5f1f45de787048","extra/1/(3, 3)/None/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.astype(np.arange(9,"int64"):reshape({3,3}),"int32")
local out=np.transpose(x,{2,1})
local y=r:permuted(x,nil,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{5,4,8},{0,6,2},{3,7,1}},"extra/1/(3, 3)/None/alias values")
deep(r:raw_hex(),"6c5f1f45de787048","extra/1/(3, 3)/None/alias pcg")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.astype(np.arange(9,"int64"):reshape({3,3}),"int32")
local out=np.zeros({3,3},"float64")
local y=r:permuted(x,nil,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{7.0,0.0,1.0},{4.0,2.0,5.0},{8.0,6.0,3.0}},"extra/1/(3, 3)/None/cast values")
deep(r:raw_hex(),"6c5f1f45de787048","extra/1/(3, 3)/None/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.astype(np.arange(9,"int64"):reshape({3,3}),"int32")
local out=np.flip(np.zeros({3,3},"int32"),1)
local y=r:permuted(x,1,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{0,7,5},{3,1,2},{6,4,8}},"extra/1/(3, 3)/0/view values")
deep(r:raw_hex(),"4fd42fa03fcd72a9","extra/1/(3, 3)/0/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.astype(np.arange(9,"int64"):reshape({3,3}),"int32")
local out=np.transpose(x,{2,1})
local y=r:permuted(x,1,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{0,7,5},{3,1,2},{6,4,8}},"extra/1/(3, 3)/0/alias values")
deep(r:raw_hex(),"4fd42fa03fcd72a9","extra/1/(3, 3)/0/alias pcg")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.astype(np.arange(9,"int64"):reshape({3,3}),"int32")
local out=np.zeros({3,3},"float64")
local y=r:permuted(x,1,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{0.0,7.0,5.0},{3.0,1.0,2.0},{6.0,4.0,8.0}},"extra/1/(3, 3)/0/cast values")
deep(r:raw_hex(),"4fd42fa03fcd72a9","extra/1/(3, 3)/0/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.astype(np.arange(9,"int64"):reshape({3,3}),"int32")
local out=np.flip(np.zeros({3,3},"int32"),1)
local y=r:permuted(x,2,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{0,1,2},{5,3,4},{7,6,8}},"extra/1/(3, 3)/1/view values")
deep(r:raw_hex(),"4fd42fa03fcd72a9","extra/1/(3, 3)/1/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.astype(np.arange(9,"int64"):reshape({3,3}),"int32")
local out=np.transpose(x,{2,1})
local y=r:permuted(x,2,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{0,1,2},{5,3,4},{7,6,8}},"extra/1/(3, 3)/1/alias values")
deep(r:raw_hex(),"4fd42fa03fcd72a9","extra/1/(3, 3)/1/alias pcg")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.astype(np.arange(9,"int64"):reshape({3,3}),"int32")
local out=np.zeros({3,3},"float64")
local y=r:permuted(x,2,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{0.0,1.0,2.0},{5.0,3.0,4.0},{7.0,6.0,8.0}},"extra/1/(3, 3)/1/cast values")
deep(r:raw_hex(),"4fd42fa03fcd72a9","extra/1/(3, 3)/1/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.astype(np.arange(24,"int64"):reshape({2,3,4}),"int32")
local out=np.flip(np.zeros({2,3,4},"int32"),1)
local y=r:permuted(x,nil,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{{1,21,7,17},{16,23,22,15},{20,11,2,12}},{{10,3,4,5},{8,0,9,14},{18,13,6,19}}},"extra/1/(2, 3, 4)/None/view values")
deep(r:raw_hex(),"4d9e2d241fb91945","extra/1/(2, 3, 4)/None/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.astype(np.arange(24,"int64"):reshape({2,3,4}),"int32")
local out=np.zeros({2,3,4},"float64")
local y=r:permuted(x,nil,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{{1.0,21.0,7.0,17.0},{16.0,23.0,22.0,15.0},{20.0,11.0,2.0,12.0}},{{10.0,3.0,4.0,5.0},{8.0,0.0,9.0,14.0},{18.0,13.0,6.0,19.0}}},"extra/1/(2, 3, 4)/None/cast values")
deep(r:raw_hex(),"4d9e2d241fb91945","extra/1/(2, 3, 4)/None/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.astype(np.arange(24,"int64"):reshape({2,3,4}),"int32")
local out=np.flip(np.zeros({2,3,4},"int32"),1)
local y=r:permuted(x,1,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{{0,1,14,3},{4,17,18,19},{8,21,22,11}},{{12,13,2,15},{16,5,6,7},{20,9,10,23}}},"extra/1/(2, 3, 4)/0/view values")
deep(r:raw_hex(),"d3e4513345ee6d24","extra/1/(2, 3, 4)/0/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.astype(np.arange(24,"int64"):reshape({2,3,4}),"int32")
local out=np.zeros({2,3,4},"float64")
local y=r:permuted(x,1,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{{0.0,1.0,14.0,3.0},{4.0,17.0,18.0,19.0},{8.0,21.0,22.0,11.0}},{{12.0,13.0,2.0,15.0},{16.0,5.0,6.0,7.0},{20.0,9.0,10.0,23.0}}},"extra/1/(2, 3, 4)/0/cast values")
deep(r:raw_hex(),"d3e4513345ee6d24","extra/1/(2, 3, 4)/0/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.astype(np.arange(24,"int64"):reshape({2,3,4}),"int32")
local out=np.flip(np.zeros({2,3,4},"int32"),1)
local y=r:permuted(x,3,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{{0,1,2,3},{7,4,6,5},{11,8,9,10}},{{14,15,13,12},{17,16,18,19},{21,20,23,22}}},"extra/1/(2, 3, 4)/2/view values")
deep(r:raw_hex(),"c0e63c2edd973235","extra/1/(2, 3, 4)/2/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.astype(np.arange(24,"int64"):reshape({2,3,4}),"int32")
local out=np.zeros({2,3,4},"float64")
local y=r:permuted(x,3,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{{0.0,1.0,2.0,3.0},{7.0,4.0,6.0,5.0},{11.0,8.0,9.0,10.0}},{{14.0,15.0,13.0,12.0},{17.0,16.0,18.0,19.0},{21.0,20.0,23.0,22.0}}},"extra/1/(2, 3, 4)/2/cast values")
deep(r:raw_hex(),"c0e63c2edd973235","extra/1/(2, 3, 4)/2/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.astype(np.arange(0,"int64"):reshape({2,0,3}),"int32")
local out=np.flip(np.zeros({2,0,3},"int32"),1)
local y=r:permuted(x,nil,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{},{}},"extra/1/(2, 0, 3)/None/view values")
deep(r:raw_hex(),"8306bdf37922e4ff","extra/1/(2, 0, 3)/None/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.astype(np.arange(0,"int64"):reshape({2,0,3}),"int32")
local out=np.zeros({2,0,3},"float64")
local y=r:permuted(x,nil,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{},{}},"extra/1/(2, 0, 3)/None/cast values")
deep(r:raw_hex(),"8306bdf37922e4ff","extra/1/(2, 0, 3)/None/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.astype(np.arange(0,"int64"):reshape({2,0,3}),"int32")
local out=np.flip(np.zeros({2,0,3},"int32"),1)
local y=r:permuted(x,1,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{},{}},"extra/1/(2, 0, 3)/0/view values")
deep(r:raw_hex(),"8306bdf37922e4ff","extra/1/(2, 0, 3)/0/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.astype(np.arange(0,"int64"):reshape({2,0,3}),"int32")
local out=np.zeros({2,0,3},"float64")
local y=r:permuted(x,1,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{},{}},"extra/1/(2, 0, 3)/0/cast values")
deep(r:raw_hex(),"8306bdf37922e4ff","extra/1/(2, 0, 3)/0/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.astype(np.arange(0,"int64"):reshape({2,0,3}),"int32")
local out=np.flip(np.zeros({2,0,3},"int32"),1)
local y=r:permuted(x,3,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{},{}},"extra/1/(2, 0, 3)/2/view values")
deep(r:raw_hex(),"8306bdf37922e4ff","extra/1/(2, 0, 3)/2/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.astype(np.arange(0,"int64"):reshape({2,0,3}),"int32")
local out=np.zeros({2,0,3},"float64")
local y=r:permuted(x,3,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{},{}},"extra/1/(2, 0, 3)/2/cast values")
deep(r:raw_hex(),"8306bdf37922e4ff","extra/1/(2, 0, 3)/2/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.astype(np.arange(12,"int64"):reshape({3,4}),"int32")
local out=np.flip(np.zeros({3,4},"int32"),1)
local y=r:permuted(x,nil,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{0,7,6,9},{11,3,5,2},{4,10,1,8}},"extra/42/(3, 4)/None/view values")
deep(r:raw_hex(),"c93b82a3b7ac9740","extra/42/(3, 4)/None/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.astype(np.arange(12,"int64"):reshape({3,4}),"int32")
local out=np.zeros({3,4},"float64")
local y=r:permuted(x,nil,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{0.0,7.0,6.0,9.0},{11.0,3.0,5.0,2.0},{4.0,10.0,1.0,8.0}},"extra/42/(3, 4)/None/cast values")
deep(r:raw_hex(),"c93b82a3b7ac9740","extra/42/(3, 4)/None/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.astype(np.arange(12,"int64"):reshape({3,4}),"int32")
local out=np.flip(np.zeros({3,4},"int32"),1)
local y=r:permuted(x,1,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{8,1,6,11},{4,9,10,3},{0,5,2,7}},"extra/42/(3, 4)/0/view values")
deep(r:raw_hex(),"181c01b5339381eb","extra/42/(3, 4)/0/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.astype(np.arange(12,"int64"):reshape({3,4}),"int32")
local out=np.zeros({3,4},"float64")
local y=r:permuted(x,1,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{8.0,1.0,6.0,11.0},{4.0,9.0,10.0,3.0},{0.0,5.0,2.0,7.0}},"extra/42/(3, 4)/0/cast values")
deep(r:raw_hex(),"181c01b5339381eb","extra/42/(3, 4)/0/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.astype(np.arange(12,"int64"):reshape({3,4}),"int32")
local out=np.flip(np.zeros({3,4},"int32"),1)
local y=r:permuted(x,2,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{3,2,1,0},{7,6,4,5},{8,11,10,9}},"extra/42/(3, 4)/1/view values")
deep(r:raw_hex(),"f9c262ed86c7538c","extra/42/(3, 4)/1/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.astype(np.arange(12,"int64"):reshape({3,4}),"int32")
local out=np.zeros({3,4},"float64")
local y=r:permuted(x,2,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{3.0,2.0,1.0,0.0},{7.0,6.0,4.0,5.0},{8.0,11.0,10.0,9.0}},"extra/42/(3, 4)/1/cast values")
deep(r:raw_hex(),"f9c262ed86c7538c","extra/42/(3, 4)/1/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.astype(np.arange(9,"int64"):reshape({3,3}),"int32")
local out=np.flip(np.zeros({3,3},"int32"),1)
local y=r:permuted(x,nil,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{3,0,7},{2,4,6},{1,5,8}},"extra/42/(3, 3)/None/view values")
deep(r:raw_hex(),"181c01b5339381eb","extra/42/(3, 3)/None/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.astype(np.arange(9,"int64"):reshape({3,3}),"int32")
local out=np.transpose(x,{2,1})
local y=r:permuted(x,nil,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{1,6,3},{0,4,7},{5,2,8}},"extra/42/(3, 3)/None/alias values")
deep(r:raw_hex(),"181c01b5339381eb","extra/42/(3, 3)/None/alias pcg")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.astype(np.arange(9,"int64"):reshape({3,3}),"int32")
local out=np.zeros({3,3},"float64")
local y=r:permuted(x,nil,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{3.0,0.0,7.0},{2.0,4.0,6.0},{1.0,5.0,8.0}},"extra/42/(3, 3)/None/cast values")
deep(r:raw_hex(),"181c01b5339381eb","extra/42/(3, 3)/None/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.astype(np.arange(9,"int64"):reshape({3,3}),"int32")
local out=np.flip(np.zeros({3,3},"int32"),1)
local y=r:permuted(x,1,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{6,1,5},{3,7,8},{0,4,2}},"extra/42/(3, 3)/0/view values")
deep(r:raw_hex(),"b286b60e1600888d","extra/42/(3, 3)/0/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.astype(np.arange(9,"int64"):reshape({3,3}),"int32")
local out=np.transpose(x,{2,1})
local y=r:permuted(x,1,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{6,1,5},{3,7,8},{0,4,2}},"extra/42/(3, 3)/0/alias values")
deep(r:raw_hex(),"b286b60e1600888d","extra/42/(3, 3)/0/alias pcg")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.astype(np.arange(9,"int64"):reshape({3,3}),"int32")
local out=np.zeros({3,3},"float64")
local y=r:permuted(x,1,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{6.0,1.0,5.0},{3.0,7.0,8.0},{0.0,4.0,2.0}},"extra/42/(3, 3)/0/cast values")
deep(r:raw_hex(),"b286b60e1600888d","extra/42/(3, 3)/0/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.astype(np.arange(9,"int64"):reshape({3,3}),"int32")
local out=np.flip(np.zeros({3,3},"int32"),1)
local y=r:permuted(x,2,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{2,1,0},{3,5,4},{7,8,6}},"extra/42/(3, 3)/1/view values")
deep(r:raw_hex(),"b286b60e1600888d","extra/42/(3, 3)/1/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.astype(np.arange(9,"int64"):reshape({3,3}),"int32")
local out=np.transpose(x,{2,1})
local y=r:permuted(x,2,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{2,1,0},{3,5,4},{7,8,6}},"extra/42/(3, 3)/1/alias values")
deep(r:raw_hex(),"b286b60e1600888d","extra/42/(3, 3)/1/alias pcg")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.astype(np.arange(9,"int64"):reshape({3,3}),"int32")
local out=np.zeros({3,3},"float64")
local y=r:permuted(x,2,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{2.0,1.0,0.0},{3.0,5.0,4.0},{7.0,8.0,6.0}},"extra/42/(3, 3)/1/cast values")
deep(r:raw_hex(),"b286b60e1600888d","extra/42/(3, 3)/1/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.astype(np.arange(24,"int64"):reshape({2,3,4}),"int32")
local out=np.flip(np.zeros({2,3,4},"int32"),1)
local y=r:permuted(x,nil,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{{16,15,18,19},{9,7,17,23},{6,10,3,0}},{{20,12,5,11},{14,22,2,4},{21,1,13,8}}},"extra/42/(2, 3, 4)/None/view values")
deep(r:raw_hex(),"d2a0814d6704a0b6","extra/42/(2, 3, 4)/None/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.astype(np.arange(24,"int64"):reshape({2,3,4}),"int32")
local out=np.zeros({2,3,4},"float64")
local y=r:permuted(x,nil,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{{16.0,15.0,18.0,19.0},{9.0,7.0,17.0,23.0},{6.0,10.0,3.0,0.0}},{{20.0,12.0,5.0,11.0},{14.0,22.0,2.0,4.0},{21.0,1.0,13.0,8.0}}},"extra/42/(2, 3, 4)/None/cast values")
deep(r:raw_hex(),"d2a0814d6704a0b6","extra/42/(2, 3, 4)/None/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.astype(np.arange(24,"int64"):reshape({2,3,4}),"int32")
local out=np.flip(np.zeros({2,3,4},"int32"),1)
local y=r:permuted(x,1,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{{12,1,2,3},{16,17,6,19},{8,9,22,11}},{{0,13,14,15},{4,5,18,7},{20,21,10,23}}},"extra/42/(2, 3, 4)/0/view values")
deep(r:raw_hex(),"c2da0d2fbc5a4471","extra/42/(2, 3, 4)/0/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.astype(np.arange(24,"int64"):reshape({2,3,4}),"int32")
local out=np.zeros({2,3,4},"float64")
local y=r:permuted(x,1,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{{12.0,1.0,2.0,3.0},{16.0,17.0,6.0,19.0},{8.0,9.0,22.0,11.0}},{{0.0,13.0,14.0,15.0},{4.0,5.0,18.0,7.0},{20.0,21.0,10.0,23.0}}},"extra/42/(2, 3, 4)/0/cast values")
deep(r:raw_hex(),"c2da0d2fbc5a4471","extra/42/(2, 3, 4)/0/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.astype(np.arange(24,"int64"):reshape({2,3,4}),"int32")
local out=np.flip(np.zeros({2,3,4},"int32"),1)
local y=r:permuted(x,3,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{{3,2,1,0},{7,6,4,5},{8,11,10,9}},{{14,15,12,13},{18,19,16,17},{21,20,22,23}}},"extra/42/(2, 3, 4)/2/view values")
deep(r:raw_hex(),"5eec9e8b80171029","extra/42/(2, 3, 4)/2/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.astype(np.arange(24,"int64"):reshape({2,3,4}),"int32")
local out=np.zeros({2,3,4},"float64")
local y=r:permuted(x,3,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{{3.0,2.0,1.0,0.0},{7.0,6.0,4.0,5.0},{8.0,11.0,10.0,9.0}},{{14.0,15.0,12.0,13.0},{18.0,19.0,16.0,17.0},{21.0,20.0,22.0,23.0}}},"extra/42/(2, 3, 4)/2/cast values")
deep(r:raw_hex(),"5eec9e8b80171029","extra/42/(2, 3, 4)/2/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.astype(np.arange(0,"int64"):reshape({2,0,3}),"int32")
local out=np.flip(np.zeros({2,0,3},"int32"),1)
local y=r:permuted(x,nil,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{},{}},"extra/42/(2, 0, 3)/None/view values")
deep(r:raw_hex(),"c621fbcd16d92688","extra/42/(2, 0, 3)/None/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.astype(np.arange(0,"int64"):reshape({2,0,3}),"int32")
local out=np.zeros({2,0,3},"float64")
local y=r:permuted(x,nil,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{},{}},"extra/42/(2, 0, 3)/None/cast values")
deep(r:raw_hex(),"c621fbcd16d92688","extra/42/(2, 0, 3)/None/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.astype(np.arange(0,"int64"):reshape({2,0,3}),"int32")
local out=np.flip(np.zeros({2,0,3},"int32"),1)
local y=r:permuted(x,1,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{},{}},"extra/42/(2, 0, 3)/0/view values")
deep(r:raw_hex(),"c621fbcd16d92688","extra/42/(2, 0, 3)/0/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.astype(np.arange(0,"int64"):reshape({2,0,3}),"int32")
local out=np.zeros({2,0,3},"float64")
local y=r:permuted(x,1,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{},{}},"extra/42/(2, 0, 3)/0/cast values")
deep(r:raw_hex(),"c621fbcd16d92688","extra/42/(2, 0, 3)/0/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.astype(np.arange(0,"int64"):reshape({2,0,3}),"int32")
local out=np.flip(np.zeros({2,0,3},"int32"),1)
local y=r:permuted(x,3,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{},{}},"extra/42/(2, 0, 3)/2/view values")
deep(r:raw_hex(),"c621fbcd16d92688","extra/42/(2, 0, 3)/2/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.astype(np.arange(0,"int64"):reshape({2,0,3}),"int32")
local out=np.zeros({2,0,3},"float64")
local y=r:permuted(x,3,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{},{}},"extra/42/(2, 0, 3)/2/cast values")
deep(r:raw_hex(),"c621fbcd16d92688","extra/42/(2, 0, 3)/2/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.astype(np.arange(12,"int64"):reshape({3,4}),"int32")
local out=np.flip(np.zeros({3,4},"int32"),1)
local y=r:permuted(x,nil,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{7,9,5,6},{4,11,3,8},{0,10,1,2}},"extra/9876/(3, 4)/None/view values")
deep(r:raw_hex(),"a8cf434814e86d52","extra/9876/(3, 4)/None/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.astype(np.arange(12,"int64"):reshape({3,4}),"int32")
local out=np.zeros({3,4},"float64")
local y=r:permuted(x,nil,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{7.0,9.0,5.0,6.0},{4.0,11.0,3.0,8.0},{0.0,10.0,1.0,2.0}},"extra/9876/(3, 4)/None/cast values")
deep(r:raw_hex(),"a8cf434814e86d52","extra/9876/(3, 4)/None/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.astype(np.arange(12,"int64"):reshape({3,4}),"int32")
local out=np.flip(np.zeros({3,4},"int32"),1)
local y=r:permuted(x,1,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{0,1,2,7},{4,9,10,11},{8,5,6,3}},"extra/9876/(3, 4)/0/view values")
deep(r:raw_hex(),"fa48e48c3b034932","extra/9876/(3, 4)/0/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.astype(np.arange(12,"int64"):reshape({3,4}),"int32")
local out=np.zeros({3,4},"float64")
local y=r:permuted(x,1,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{0.0,1.0,2.0,7.0},{4.0,9.0,10.0,11.0},{8.0,5.0,6.0,3.0}},"extra/9876/(3, 4)/0/cast values")
deep(r:raw_hex(),"fa48e48c3b034932","extra/9876/(3, 4)/0/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.astype(np.arange(12,"int64"):reshape({3,4}),"int32")
local out=np.flip(np.zeros({3,4},"int32"),1)
local y=r:permuted(x,2,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{0,1,2,3},{4,6,7,5},{9,10,8,11}},"extra/9876/(3, 4)/1/view values")
deep(r:raw_hex(),"fa48e48c3b034932","extra/9876/(3, 4)/1/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.astype(np.arange(12,"int64"):reshape({3,4}),"int32")
local out=np.zeros({3,4},"float64")
local y=r:permuted(x,2,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{0.0,1.0,2.0,3.0},{4.0,6.0,7.0,5.0},{9.0,10.0,8.0,11.0}},"extra/9876/(3, 4)/1/cast values")
deep(r:raw_hex(),"fa48e48c3b034932","extra/9876/(3, 4)/1/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.astype(np.arange(9,"int64"):reshape({3,3}),"int32")
local out=np.flip(np.zeros({3,3},"int32"),1)
local y=r:permuted(x,nil,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{7,3,8},{4,0,6},{1,5,2}},"extra/9876/(3, 3)/None/view values")
deep(r:raw_hex(),"1d1125fece33dc9b","extra/9876/(3, 3)/None/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.astype(np.arange(9,"int64"):reshape({3,3}),"int32")
local out=np.transpose(x,{2,1})
local y=r:permuted(x,nil,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{5,4,3},{1,0,7},{8,2,6}},"extra/9876/(3, 3)/None/alias values")
deep(r:raw_hex(),"1d1125fece33dc9b","extra/9876/(3, 3)/None/alias pcg")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.astype(np.arange(9,"int64"):reshape({3,3}),"int32")
local out=np.zeros({3,3},"float64")
local y=r:permuted(x,nil,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{7.0,3.0,8.0},{4.0,0.0,6.0},{1.0,5.0,2.0}},"extra/9876/(3, 3)/None/cast values")
deep(r:raw_hex(),"1d1125fece33dc9b","extra/9876/(3, 3)/None/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.astype(np.arange(9,"int64"):reshape({3,3}),"int32")
local out=np.flip(np.zeros({3,3},"int32"),1)
local y=r:permuted(x,1,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{0,1,2},{3,7,8},{6,4,5}},"extra/9876/(3, 3)/0/view values")
deep(r:raw_hex(),"5438d9338499fd38","extra/9876/(3, 3)/0/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.astype(np.arange(9,"int64"):reshape({3,3}),"int32")
local out=np.transpose(x,{2,1})
local y=r:permuted(x,1,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{0,1,2},{3,7,8},{6,4,5}},"extra/9876/(3, 3)/0/alias values")
deep(r:raw_hex(),"5438d9338499fd38","extra/9876/(3, 3)/0/alias pcg")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.astype(np.arange(9,"int64"):reshape({3,3}),"int32")
local out=np.zeros({3,3},"float64")
local y=r:permuted(x,1,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{0.0,1.0,2.0},{3.0,7.0,8.0},{6.0,4.0,5.0}},"extra/9876/(3, 3)/0/cast values")
deep(r:raw_hex(),"5438d9338499fd38","extra/9876/(3, 3)/0/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.astype(np.arange(9,"int64"):reshape({3,3}),"int32")
local out=np.flip(np.zeros({3,3},"int32"),1)
local y=r:permuted(x,2,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{0,1,2},{3,5,4},{6,8,7}},"extra/9876/(3, 3)/1/view values")
deep(r:raw_hex(),"5438d9338499fd38","extra/9876/(3, 3)/1/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.astype(np.arange(9,"int64"):reshape({3,3}),"int32")
local out=np.transpose(x,{2,1})
local y=r:permuted(x,2,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{0,1,2},{3,5,4},{6,8,7}},"extra/9876/(3, 3)/1/alias values")
deep(r:raw_hex(),"5438d9338499fd38","extra/9876/(3, 3)/1/alias pcg")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.astype(np.arange(9,"int64"):reshape({3,3}),"int32")
local out=np.zeros({3,3},"float64")
local y=r:permuted(x,2,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{0.0,1.0,2.0},{3.0,5.0,4.0},{6.0,8.0,7.0}},"extra/9876/(3, 3)/1/cast values")
deep(r:raw_hex(),"5438d9338499fd38","extra/9876/(3, 3)/1/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.astype(np.arange(24,"int64"):reshape({2,3,4}),"int32")
local out=np.flip(np.zeros({2,3,4},"int32"),1)
local y=r:permuted(x,nil,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{{18,7,0,19},{3,6,21,20},{4,10,8,22}},{{5,9,14,11},{12,16,23,17},{1,13,2,15}}},"extra/9876/(2, 3, 4)/None/view values")
deep(r:raw_hex(),"cff0bed4b59a84ec","extra/9876/(2, 3, 4)/None/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.astype(np.arange(24,"int64"):reshape({2,3,4}),"int32")
local out=np.zeros({2,3,4},"float64")
local y=r:permuted(x,nil,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{{18.0,7.0,0.0,19.0},{3.0,6.0,21.0,20.0},{4.0,10.0,8.0,22.0}},{{5.0,9.0,14.0,11.0},{12.0,16.0,23.0,17.0},{1.0,13.0,2.0,15.0}}},"extra/9876/(2, 3, 4)/None/cast values")
deep(r:raw_hex(),"cff0bed4b59a84ec","extra/9876/(2, 3, 4)/None/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.astype(np.arange(24,"int64"):reshape({2,3,4}),"int32")
local out=np.flip(np.zeros({2,3,4},"int32"),1)
local y=r:permuted(x,1,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{{0,13,2,3},{4,5,6,19},{20,9,22,23}},{{12,1,14,15},{16,17,18,7},{8,21,10,11}}},"extra/9876/(2, 3, 4)/0/view values")
deep(r:raw_hex(),"1d1125fece33dc9b","extra/9876/(2, 3, 4)/0/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.astype(np.arange(24,"int64"):reshape({2,3,4}),"int32")
local out=np.zeros({2,3,4},"float64")
local y=r:permuted(x,1,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{{0.0,13.0,2.0,3.0},{4.0,5.0,6.0,19.0},{20.0,9.0,22.0,23.0}},{{12.0,1.0,14.0,15.0},{16.0,17.0,18.0,7.0},{8.0,21.0,10.0,11.0}}},"extra/9876/(2, 3, 4)/0/cast values")
deep(r:raw_hex(),"1d1125fece33dc9b","extra/9876/(2, 3, 4)/0/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.astype(np.arange(24,"int64"):reshape({2,3,4}),"int32")
local out=np.flip(np.zeros({2,3,4},"int32"),1)
local y=r:permuted(x,3,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{{0,1,2,3},{4,6,7,5},{9,10,8,11}},{{13,12,14,15},{16,17,18,19},{23,20,22,21}}},"extra/9876/(2, 3, 4)/2/view values")
deep(r:raw_hex(),"93e4ed94f57d4a08","extra/9876/(2, 3, 4)/2/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.astype(np.arange(24,"int64"):reshape({2,3,4}),"int32")
local out=np.zeros({2,3,4},"float64")
local y=r:permuted(x,3,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{{0.0,1.0,2.0,3.0},{4.0,6.0,7.0,5.0},{9.0,10.0,8.0,11.0}},{{13.0,12.0,14.0,15.0},{16.0,17.0,18.0,19.0},{23.0,20.0,22.0,21.0}}},"extra/9876/(2, 3, 4)/2/cast values")
deep(r:raw_hex(),"93e4ed94f57d4a08","extra/9876/(2, 3, 4)/2/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.astype(np.arange(0,"int64"):reshape({2,0,3}),"int32")
local out=np.flip(np.zeros({2,0,3},"int32"),1)
local y=r:permuted(x,nil,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{},{}},"extra/9876/(2, 0, 3)/None/view values")
deep(r:raw_hex(),"b42062a2610530af","extra/9876/(2, 0, 3)/None/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.astype(np.arange(0,"int64"):reshape({2,0,3}),"int32")
local out=np.zeros({2,0,3},"float64")
local y=r:permuted(x,nil,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{},{}},"extra/9876/(2, 0, 3)/None/cast values")
deep(r:raw_hex(),"b42062a2610530af","extra/9876/(2, 0, 3)/None/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.astype(np.arange(0,"int64"):reshape({2,0,3}),"int32")
local out=np.flip(np.zeros({2,0,3},"int32"),1)
local y=r:permuted(x,1,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{},{}},"extra/9876/(2, 0, 3)/0/view values")
deep(r:raw_hex(),"b42062a2610530af","extra/9876/(2, 0, 3)/0/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.astype(np.arange(0,"int64"):reshape({2,0,3}),"int32")
local out=np.zeros({2,0,3},"float64")
local y=r:permuted(x,1,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{},{}},"extra/9876/(2, 0, 3)/0/cast values")
deep(r:raw_hex(),"b42062a2610530af","extra/9876/(2, 0, 3)/0/cast pcg")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.astype(np.arange(0,"int64"):reshape({2,0,3}),"int32")
local out=np.flip(np.zeros({2,0,3},"int32"),1)
local y=r:permuted(x,3,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{},{}},"extra/9876/(2, 0, 3)/2/view values")
deep(r:raw_hex(),"b42062a2610530af","extra/9876/(2, 0, 3)/2/view pcg")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.astype(np.arange(0,"int64"):reshape({2,0,3}),"int32")
local out=np.zeros({2,0,3},"float64")
local y=r:permuted(x,3,out)
assert(rawequal(y,out),"out must return itself")
deep(y:tolist(),{{},{}},"extra/9876/(2, 0, 3)/2/cast values")
deep(r:raw_hex(),"b42062a2610530af","extra/9876/(2, 0, 3)/2/cast pcg")
cases=cases+1; end
print("permuted73 oracle part 23: "..cases.." cases, "..checks.." checks passed")
