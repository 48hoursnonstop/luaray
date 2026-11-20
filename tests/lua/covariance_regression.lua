local lr = require("luaray")

local x = lr.array({{0, 1, 2}, {0, 2, 4}}, "float32")
local snapshot = x:tobytes()
assert(lr.allclose(lr.cov(x), {{1, 2}, {2, 4}}))
assert(lr.allclose(lr.cov(x, {fweights={1, 2, 1}}), {{2/3, 4/3}, {4/3, 8/3}}))
assert(lr.allclose(lr.cov(x, {aweights={1, 2, 1}}), {{0.8, 1.6}, {1.6, 3.2}}))
assert(lr.allclose(lr.corrcoef(lr.transpose(x), {rowvar=false}), {{1, 1}, {1, 1}}))
assert(lr.cov({1, 2, 3}, {bias=true}):item() == 2/3)
assert(lr.corrcoef({1, 2, 3}) == 1)
assert(lr.isnan(lr.corrcoef({1, 1, 1})))
assert(lr.array_equal(lr.cov(lr.empty({0, 4})), lr.empty({0, 0})))
assert(lr.cov(x, {ddof=4})[1][1] == math.huge)
assert(x:tobytes() == snapshot)

local z = {
  {lr.complex(1, 1), lr.complex(2, -1), lr.complex(4, 2)},
  {lr.complex(0, -1), lr.complex(1, 2), lr.complex(3, 4)}
}
local c = lr.cov(z)
assert(lr.allclose(lr.real(c), {{14/3, 19/6}, {19/6, 26/3}}))
assert(lr.allclose(lr.imag(c), {{0, -2.5}, {2.5, 0}}))
assert(lr.allclose(lr.real(lr.corrcoef(z)), {{1, 19/math.sqrt(1456)}, {19/math.sqrt(1456), 1}}))
assert(not pcall(lr.cov, x, {aweights={0, 0, 0}}))
assert(not pcall(lr.cov, x, {fweights={1, 1.5, 1}}))
assert(not pcall(lr.cov, x, {ddof="1"}))
assert(not pcall(lr.corrcoef, lr.zeros({2, 2, 2})))
print("Covariance and correlation regression passed")
