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

  function lr.polyfit(points,observations,degree,options)
    if options==nil then options={} end
    if type(options)~='table' then error('polyfit options must be a table',2) end
    for key,value in pairs(options) do
      if key=='full' then
        if type(value)~='boolean' then error('full must be boolean',2) end
      elseif key=='cov' then
        if type(value)~='boolean' and value~='unscaled' then error('invalid covariance option',2) end
      elseif key~='rcond' and key~='w' then
        error('unknown polyfit option',2)
      end
    end
    if type(degree)~='number' or degree<0 then error('degree must be nonnegative',2) end
    local n=order(degree)
    if n==math.maxinteger then error('degree exceeds native limits',2) end
    n=n+1
    local x=lr.add(lr.asanyarray(points),0.0)
    local rhs=lr.add(lr.asanyarray(observations),0.0)
    if x.ndim~=1 or x.size==0 then error('polyfit x must be a nonempty vector',2) end
    if (rhs.ndim~=1 and rhs.ndim~=2) or rhs.shape[1]~=x.size then
      error('observations must be a vector or matrix matching the number of points',2)
    end
    local rcond=options.rcond
    if rcond==nil then rcond=x.size*lr.finfo(x.dtype).eps end
    if type(rcond)=='userdata' and rcond.ndim==0 then rcond=rcond:tolist() end
    if type(rcond)~='number' then error('rcond must be a real scalar',2) end

    local lhs=lr.vander(x,n)
    if options.w~=nil then
      local weights=lr.add(lr.asanyarray(options.w),0.0)
      if weights.ndim~=1 or weights.size~=x.size then error('weights must match x',2) end
      local columns=lr.expand_dims(weights,2)
      lr.multiply(lhs,columns,{out=lhs})
      lr.multiply(rhs,rhs.ndim==2 and columns or weights,{out=rhs})
    end

    local scale=lr.sqrt(lr.sum(lr.multiply(lhs,lhs),{axis=1}))
    lr.true_divide(lhs,scale,{out=lhs})
    local coefficients,residuals,rank,singular=lr.linalg.lstsq(lhs,rhs,rcond)
    local factors=rhs.ndim==2 and lr.expand_dims(scale,2) or scale
    coefficients=lr.true_divide(coefficients,factors)
    if options.full then return coefficients,residuals,rank,singular,rcond end
    if not options.cov then return coefficients end

    local variances=lr.linalg.inv(lr.dot(lr.transpose(lhs),lhs))
    lr.true_divide(variances,lr.outer(scale,scale),{out=variances})
    local covariance_scale=1
    if options.cov~='unscaled' then
      if x.size<=n then error('more data points than coefficients are required for scaled covariance',2) end
      covariance_scale=lr.true_divide(residuals,x.size-n)
    end
    if rhs.ndim==2 then variances=lr.expand_dims(variances,3) end
    return coefficients,lr.multiply(variances,covariance_scale)
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
