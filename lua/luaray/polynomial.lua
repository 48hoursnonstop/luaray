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

  local code_order='GDFgdfQqLlIiHhBb?'
  local function code_allowed(typeset,code)
    if type(typeset)=='string' then return typeset:find(code,1,true)~=nil end
    for _,allowed in ipairs(typeset) do
      if allowed==code then return true end
    end
    return false
  end

  local function type_codes(input)
    if type(input)=='string' then
      local codes={}
      for code in input:gmatch('.') do codes[#codes+1]=code end
      return codes
    end
    if type(input)=='table' then return input end
    local a=lr.asanyarray(input)
    if a.ndim==0 then error('mintypecode requires a sequence',3) end
    if a.shape[1]==0 then return {} end
    return {lr.dtype(a.dtype).char}
  end

  function lr.mintypecode(input,typeset,default)
    if typeset==nil then typeset='GDFgdf' end
    if default==nil then default='d' end
    if type(typeset)~='string' and type(typeset)~='table' then
      error('typeset must be a string or sequence',2)
    end
    local best,best_pos=default,math.huge
    local intersection={}
    for _,entry in ipairs(type_codes(input)) do
      local code=entry
      if type(code)~='string' or code=='' then code=lr.dtype(lr.asanyarray(entry).dtype).char end
      if code_allowed(typeset,code) then intersection[code]=true end
    end
    if intersection.F and intersection.d then return 'D' end
    for code in pairs(intersection) do
      local pos=code_order:find(code,1,true)
      if not pos then error('typeset contains an unknown matching code',2) end
      if pos<best_pos then best,best_pos=code,pos end
    end
    return best
  end

  function lr.poly(input)
    local values=lr.asanyarray(input)
    if values.ndim==1 then
      values=lr.astype(values,lr.mintypecode(lr.dtype(values.dtype).char))
    elseif values.ndim==2 and values.shape[1]==values.shape[2] and values.size>0 then
      local kind=lr.dtype(values.dtype).kind
      if kind=='S' or kind=='U' then error('poly matrix must have a numeric dtype',2) end
      values=lr.linalg.eigvals(values)
    else
      error('poly requires a root vector or a nonempty square matrix',2)
    end
    if values.size==0 then return 1.0 end
    local one=lr.ones({1},values.dtype)
    local p=one
    for i=1,values.size do
      local zero=values:get(lr.s(i,i+1))
      p=lr.convolve(p,lr.concatenate({one,lr.negative(zero)}))
    end
    if lr.iscomplexobj(values) then
      local zeros=lr.astype(values,'complex128')
      local ordered=lr.sort(zeros)
      local conjugate=lr.sort(lr.conjugate(zeros))
      if lr.array_equal(ordered,conjugate) then return lr.copy(lr.real(p)) end
    end
    return p
  end

  function lr.roots(input)
    local values=required_vector(input)
    local nonzero=lr.flatnonzero(values)
    if nonzero.size==0 then return lr.empty({0},'float64') end
    local first,last=nonzero[1],nonzero[nonzero.size]
    local remaining=values.size-last
    local p=values:get(lr.s(first,last+1))
    local kind=lr.dtype(p.dtype).kind
    if kind~='f' and kind~='c' then p=lr.astype(p,'float64') end
    local roots
    if p.size>1 then
      local companion=lr.diag(lr.ones({p.size-2},p.dtype),-1)
      local rest=p:get(lr.s(2,nil))
      companion:set(lr.true_divide(lr.negative(rest),coefficient(p,1)),1,lr.s())
      roots=lr.linalg.eigvals(companion)
      if kind~='c' and lr.all(lr.equal(lr.imag(roots),0)) then roots=lr.real(roots) end
    else
      roots=lr.empty({0},'float64')
    end
    return lr.concatenate({roots,lr.zeros({remaining},roots.dtype)})
  end
end
