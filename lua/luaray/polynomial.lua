-- NumPy 2.5.5 lib/_polynomial_impl.py: descending-power coefficients.
return function(lr)
  local function coefficient(a,i)
    if a.ndim~=1 then return a[i] end
    return a:get(lr.s(i,i+1)):reshape({})
  end

  local function order(value)
    if value==nil then return 1 end
    if type(value)~='number' then error('polynomial order must be a number',3) end
    local n=math.tointeger((math.modf(value)))
    if not n or n<0 then error('polynomial order must be nonnegative and finite',3) end
    return n
  end

  local function required_vector(value)
    local a=lr.asanyarray(value)
    if a.ndim~=1 then error('polynomial coefficients must be one-dimensional',3) end
    return a
  end

  local function align(a,b,operation)
    a,b=lr.atleast_1d(a),lr.atleast_1d(b)
    local n,m=a.shape[1],b.shape[1]
    if n<m then a=lr.concatenate({lr.zeros({m-n},a.dtype),a})
    elseif m<n then b=lr.concatenate({lr.zeros({n-m},b.dtype),b}) end
    return operation(a,b)
  end

  function lr.polyadd(a,b) return align(a,b,lr.add) end
  function lr.polysub(a,b) return align(a,b,lr.subtract) end

  local function normalized(value)
    local a=required_vector(lr.atleast_1d(value))
    local nz=lr.flatnonzero(a)
    if nz.size==0 then return lr.zeros({1},a.dtype) end
    return a:get(lr.s(nz[1],nil))
  end

  function lr.polymul(a,b)
    return lr.convolve(normalized(a),normalized(b))
  end

  function lr.polyder(input,amount)
    local n=order(amount)
    local p=required_vector(input)
    for _=1,n do
      local previous=p.size
      local factors=lr.arange(previous-1,0,-1)
      p=lr.multiply(p:get(lr.s(nil,-1)),factors)
      if previous==0 then break end
    end
    return p
  end

  function lr.polyint(input,amount,constants)
    local n=order(amount)
    local p=required_vector(input)
    local k=constants==nil and lr.zeros({n},'float64') or lr.atleast_1d(constants)
    if k.ndim~=1 then error('integration constants must be one-dimensional',2) end
    if k.size==1 and n>1 then k=lr.multiply(k,lr.ones({n},'float64')) end
    if k.size<n then error('too few integration constants',2) end
    for i=1,n do
      local denominator=lr.arange(p.size,0,-1)
      p=lr.concatenate({lr.true_divide(p,denominator),k:get(lr.s(i,i+1))})
    end
    return p
  end

  function lr.polyval(input,points)
    local p=lr.asanyarray(input)
    if p.ndim==0 then error('polyval coefficients require at least one dimension',2) end
    local x=lr.asanyarray(points)
    local y=lr.zeros_like(x)
    for i=1,p.shape[1] do
      y=lr.add(lr.multiply(y,x),coefficient(p,i))
    end
    if p.shape[1]>0 and y.ndim==0 then return y:item() end
    return y
  end
end
