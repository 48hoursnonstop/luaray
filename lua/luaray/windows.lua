-- Window formulas and sinc follow NumPy 2.5.5 lib/_function_base_impl.py.
-- The I0 coefficient tables are from the Cephes implementation by
-- Stephen L. Moshier as distributed by NumPy. See THIRD_PARTY_NUMPY_LICENSE.txt.
local coefficients_a={
    -4.41534164647933937950E-18,
    3.33079451882223809783E-17,
    -2.43127984654795469359E-16,
    1.71539128555513303061E-15,
    -1.16853328779934516808E-14,
    7.67618549860493561688E-14,
    -4.85644678311192946090E-13,
    2.95505266312963983461E-12,
    -1.72682629144155570723E-11,
    9.67580903537323691224E-11,
    -5.18979560163526290666E-10,
    2.65982372468238665035E-9,
    -1.30002500998624804212E-8,
    6.04699502254191894932E-8,
    -2.67079385394061173391E-7,
    1.11738753912010371815E-6,
    -4.41673835845875056359E-6,
    1.64484480707288970893E-5,
    -5.75419501008210370398E-5,
    1.88502885095841655729E-4,
    -5.76375574538582365885E-4,
    1.63947561694133579842E-3,
    -4.32430999505057594430E-3,
    1.05464603945949983183E-2,
    -2.37374148058994688156E-2,
    4.93052842396707084878E-2,
    -9.49010970480476444210E-2,
    1.71620901522208775349E-1,
    -3.04682672343198398683E-1,
    6.76795274409476084995E-1
}

local coefficients_b={
    -7.23318048787475395456E-18,
    -4.83050448594418207126E-18,
    4.46562142029675999901E-17,
    3.46122286769746109310E-17,
    -2.82762398051658348494E-16,
    -3.42548561967721913462E-16,
    1.77256013305652638360E-15,
    3.81168066935262242075E-15,
    -9.55484669882830764870E-15,
    -4.15056934728722208663E-14,
    1.54008621752140982691E-14,
    3.85277838274214270114E-13,
    7.18012445138366623367E-13,
    -1.79417853150680611778E-12,
    -1.32158118404477131188E-11,
    -3.14991652796324136454E-11,
    1.18891471078464383424E-11,
    4.94060238822496958910E-10,
    3.39623202570838634515E-9,
    2.26666899049817806459E-8,
    2.04891858946906374183E-7,
    2.89137052083475648297E-6,
    6.88975834691682398426E-5,
    3.36911647825569408990E-3,
    8.04490411014108831608E-1
}

return function(lr)
  local add,sub,mul,div=lr.add,lr.subtract,lr.multiply,lr.true_divide

  local function recurrence(x,coefficients)
    local current,previous,earlier=coefficients[1],0
    for i=2,#coefficients do
      earlier,previous,current=previous,current,
        add(sub(mul(x,current),previous),coefficients[i])
    end
    return mul(0.5,sub(current,earlier))
  end

  function lr.i0(value)
    local x=lr.asanyarray(value)
    local kind=lr.dtype(x.dtype).kind
    if kind=='c' then error('i0 requires real values',2) end
    if kind~='f' then x=lr.astype(x,'float64') end
    x=lr.asanyarray(lr.absolute(x),{dtype=x.dtype})
    local result=lr.zeros_like(x)
    local dest=result
    if x.ndim==0 then
      x=x:reshape({1})
      dest=result:reshape({1})
    end
    local small=lr.less_equal(x,8)
    local large=lr.logical_not(small)
    if lr.any(small) then
      local t=x:get(small)
      local series=recurrence(sub(div(t,2.0),2),coefficients_a)
      dest:set(mul(lr.exp(t),series),small)
    end
    if lr.any(large) then
      local t=x:get(large)
      local series=recurrence(sub(div(32.0,t),2.0),coefficients_b)
      dest:set(div(mul(lr.exp(t),series),lr.sqrt(t)),large)
    end
    return result
  end

  local function parameter(value)
    local a=lr.asanyarray(value)
    if a.ndim~=0 or not lr.dtype(a.dtype).kind:match('[biuf]') then
      error('window parameters must be real numeric scalars',3)
    end
    return a
  end

  local function raised_cosine(length,kind)
    local m=parameter(length)
    local dtype=lr.result_type(m,lr.dtype('float64'))
    m=lr.astype(m,dtype)
    if lr.all(lr.less(m,1)) then return lr.empty({0},dtype) end
    if lr.all(lr.equal(m,1)) then return lr.ones({1},dtype) end
    local width=sub(m,1)
    local n=lr.arange(sub(1,m),m,2)
    if kind=='bartlett' then
      local t=div(n,width)
      return lr.where(lr.less_equal(n,0),add(1,t),sub(1,t))
    end
    local phase=div(mul(math.pi,n),width)
    if kind=='hanning' then return add(0.5,mul(0.5,lr.cos(phase))) end
    if kind=='hamming' then return add(0.54,mul(0.46,lr.cos(phase))) end
    local second_phase=div(mul(2*math.pi,n),width)
    return add(add(0.42,mul(0.5,lr.cos(phase))),mul(0.08,lr.cos(second_phase)))
  end

  function lr.bartlett(length) return raised_cosine(length,'bartlett') end
  function lr.blackman(length) return raised_cosine(length,'blackman') end
  function lr.hamming(length) return raised_cosine(length,'hamming') end
  function lr.hanning(length) return raised_cosine(length,'hanning') end

  function lr.kaiser(length,beta)
    local m,b=parameter(length),parameter(beta)
    local dtype=lr.result_type(m,b,lr.dtype('float64'))
    m,b=lr.astype(m,dtype),lr.astype(b,dtype)
    if lr.all(lr.equal(m,1)) then return lr.ones({1},dtype) end
    local n=lr.arange(0,m)
    local alpha=div(sub(m,1),2.0)
    local position=div(sub(n,alpha),alpha)
    local radius=lr.sqrt(sub(1,lr.power(position,2.0)))
    return div(lr.i0(mul(b,radius)),lr.i0(b))
  end

  function lr.sinc(input)
    local x=lr.asanyarray(mul(math.pi,lr.asanyarray(input)))
    local dtype=lr.dtype(x.dtype)
    local epsilon=dtype.kind=='f' and lr.finfo(dtype).eps or 1e-20
    local y=lr.where(x,x,epsilon)
    local result=div(lr.sin(y),y)
    if result.ndim==0 then return result:item() end
    return result
  end
end
