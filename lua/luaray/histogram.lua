-- NumPy 2.5.5 lib/_histograms_impl.py: range and width selection.
return function(lr)
  local function scalar(value)
    return type(value)=='number' and value or value:item()
  end

  local function extrema(a)
    local lo,hi=lr.ndarray({},a.dtype),lr.ndarray({},a.dtype)
    lr.min(a,{out=lo})
    lr.max(a,{out=hi})
    return lo,hi
  end

  local function span(lo,hi)
    local dtype=lr.dtype(lr.result_type(lo,hi))
    if dtype.kind=='i' then
      local unsigned=lr.dtype('uint'..(dtype.itemsize*8))
      lo=lr.astype(lr.asanyarray(lo),unsigned)
      hi=lr.astype(lr.asanyarray(hi),unsigned)
    end
    return scalar(lr.astype(lr.subtract(hi,lo),'float64'))
  end

  local function interval(a,range)
    local lo,hi
    if range~=nil then
      if type(range)~='table' or #range~=2 then error('range must contain two endpoints',3) end
      lo,hi=range[1],range[2]
      if lr.ndim(lo)~=0 or lr.ndim(hi)~=0 then error('range endpoints must be scalars',3) end
    elseif a.size==0 then
      lo,hi=0,1
    else
      lo,hi=extrema(a)
    end
    if lr.all(lr.greater(lo,hi)) then error('histogram range is reversed',3) end
    if not (lr.all(lr.isfinite(lo)) and lr.all(lr.isfinite(hi))) then
      error('histogram range must be finite',3)
    end
    if lr.all(lr.equal(lo,hi)) then
      lo,hi=lr.subtract(lo,0.5),lr.add(hi,0.5)
    end
    return lo,hi
  end

  local function neighbors(a)
    return a:get(lr.s(nil,-1)),a:get(lr.s(2,nil))
  end

  local function equal_edges(a,lo,hi,bins)
    if math.type(bins)~='integer' or bins<1 or bins==math.maxinteger then
      error('bin count must be a positive integer within native range',3)
    end
    local dtype=lr.dtype(lr.result_type(lo,hi,a))
    if dtype.kind=='i' or dtype.kind=='u' then dtype=lr.dtype('float64') end
    local edges=lr.linspace(lo,hi,{num=bins+1,dtype=dtype})
    local left,right=neighbors(edges)
    if lr.any(lr.greater_equal(left,right)) then
      error('too many bins for the selected range',3)
    end
    return edges
  end

  local function inclusive_positions(a,edges)
    local interior=lr.searchsorted(a,edges:get(lr.s(nil,-1)),'left')
    local end_position=lr.searchsorted(a,edges:get(lr.s(-1,nil)),'right')
    return lr.concat({interior,end_position})
  end

  local function count_sorted(a,edges)
    return lr.diff(inclusive_positions(a,edges))
  end

  local function width_for(a,lo,hi,name)
    local first,last=extrema(a)
    local ptp=span(first,last)
    local n=a.size
    local sqrt=ptp/math.sqrt(n)
    local sturges=ptp/(math.log(n,2)+1)
    if name=='sqrt' then return sqrt end
    if name=='sturges' then return sturges end
    if name=='rice' then return ptp/(2*n^(1/3)) end
    if name=='scott' then return (24*math.sqrt(math.pi)/n)^(1/3)*lr.std(a) end
    if name=='fd' or name=='auto' then
      local quartiles=lr.percentile(a,{25,75})
      local fd=2*(quartiles[2]-quartiles[1])*n^(-1/3)
      if name=='fd' then return fd end
      return math.min(math.max(fd,sqrt/2),sturges)
    end
    if name=='doane' then
      if n<=2 then return 0 end
      local sigma=lr.std(a)
      if sigma<=0 then return 0 end
      local mean=lr.mean(a)
      local normalized=lr.true_divide(lr.subtract(a,mean),sigma)
      local skew=lr.mean(lr.power(normalized,3))
      local sg=math.sqrt(6*(n-2)/((n+1)*(n+3)))
      return ptp/(1+math.log(n,2)+math.log(1+math.abs(skew)/sg,2))
    end
    if ptp==0 or n<=1 then return 0 end
    local ordered=lr.take(a,lr.lexsort({a}))
    local score,best=math.huge,1
    for k=1,math.max(100,math.floor(math.sqrt(n))) do
      local edges=equal_edges(a,lo,hi,k)
      local probabilities=lr.true_divide(count_sorted(ordered,edges),n)
      local candidate=(2-(n+1)*lr.dot(probabilities,probabilities))/(ptp/k)
      if candidate<score then score,best=candidate,k end
    end
    return ptp/best
  end

  local estimators={sqrt=true,sturges=true,rice=true,scott=true,fd=true,
                    doane=true,auto=true,stone=true}
  local function settings(options,density_allowed)
    if options==nil then return {} end
    if type(options)~='table' then error('histogram options must be a table',3) end
    for key,value in pairs(options) do
      if key=='density' and density_allowed then
        if type(value)~='boolean' then error('density must be a boolean',3) end
      elseif key~='bins' and key~='range' and key~='weights' then
        error('unknown histogram option',3)
      end
    end
    return options
  end

  local function samples(input,weights)
    local a=lr.asanyarray(input)
    if weights~=nil then
      weights=lr.asanyarray(weights)
      local shape,weight_shape=a.shape,weights.shape
      if #shape~=#weight_shape then error('weights must match the input shape',3) end
      for i=1,#shape do
        if shape[i]~=weight_shape[i] then error('weights must match the input shape',3) end
      end
      weights=lr.ravel(weights)
    end
    a=lr.ravel(a)
    if a.dtype=='bool' then a=lr.astype(a,'uint8') end
    return a,weights
  end

  local function choose_edges(a,weights,options)
    local bins=options.bins
    if bins==nil then bins=10 end
    if type(bins)~='string' and type(bins)~='number' and type(bins)~='boolean' then
      local edges=lr.asanyarray(bins)
      if edges.ndim==1 then
        local left,right=neighbors(edges)
        if lr.any(lr.greater(left,right)) then error('bin edges must be nondecreasing',2) end
        return edges
      end
      if edges.ndim~=0 then error('bin edges must be one-dimensional',2) end
      local kind=lr.dtype(edges.dtype).kind
      if not kind:match('[biu]') then error('bin count must be an integer',2) end
      bins=edges:item()
    end

    local kind=lr.dtype(a.dtype).kind
    if not kind:match('[iuf]') then error('histogram ranges require real numeric data',3) end
    local lo,hi=interval(a,options.range)
    if type(bins)=='boolean' then bins=bins and 1 or 0 end
    if type(bins)=='string' then
      if not estimators[bins] then error('unknown histogram width estimator',2) end
      if weights~=nil then error('automatic bin widths require unweighted data',2) end
      if options.range~=nil then
        a=a:get(lr.logical_and(lr.greater_equal(a,lo),lr.less_equal(a,hi)))
      end
      local width=a.size==0 and 0 or width_for(a,lo,hi,bins)
      if width==0 then bins=1
      else
        if kind:match('[iu]') and width<1 then width=1 end
        bins=math.ceil(span(lo,hi)/width)
      end
    end
    return equal_edges(a,lo,hi,bins),lo,hi
  end

  function lr.histogram_bin_edges(input,options)
    options=settings(options,false)
    local a,weights=samples(input,options.weights)
    return (choose_edges(a,weights,options))
  end

  local block_size=65536

  local function add_counts(counts,values)
    lr.add(counts,values,{out=counts})
  end

  local function equal_histogram(a,weights,edges,lo,hi,dtype)
    local bins=edges.size-1
    local counts=lr.zeros({bins},dtype)
    local complex=lr.dtype(dtype).kind=='c'
    for first=1,a.size,block_size do
      local block=lr.s(first,first+block_size)
      local values=a:get(block)
      local w=weights and weights:get(block)
      local keep=lr.logical_and(lr.greater_equal(values,lo),lr.less_equal(values,hi))
      if not lr.all(keep) then
        values=values:get(keep)
        if w then w=w:get(keep) end
      end
      values=lr.astype(values,edges.dtype)
      local intervals=lr.subtract(lr.searchsorted(edges,values,'right'),2)
      local labels=lr.minimum(intervals,bins-1)
      if complex then
        add_counts(lr.real(counts),lr.bincount(labels,{weights=lr.real(w),minlength=bins}))
        add_counts(lr.imag(counts),lr.bincount(labels,{weights=lr.imag(w),minlength=bins}))
      else
        local sums=lr.bincount(labels,{weights=w,minlength=bins})
        add_counts(counts,lr.astype(sums,dtype))
      end
    end
    return counts
  end

  local function cumulative_histogram(a,weights,edges,dtype)
    local cumulative=lr.zeros(edges.shape,dtype)
    local initial=weights and lr.zeros({1},dtype)
    for first=1,a.size,block_size do
      local block=lr.s(first,first+block_size)
      local values=a:get(block)
      if weights then
        local order=lr.argsort(values)
        local sorted=lr.take(values,order)
        local positions=inclusive_positions(sorted,edges)
        local w=lr.take(weights:get(block),order)
        local prefix=lr.concat({initial,lr.cumsum(w)})
        add_counts(cumulative,lr.take(prefix,positions))
      else
        add_counts(cumulative,inclusive_positions(lr.sort(values),edges))
      end
    end
    return lr.diff(cumulative)
  end

  function lr.histogram(input,options)
    options=settings(options,true)
    local a,weights=samples(input,options.weights)
    local edges,lo,hi=choose_edges(a,weights,options)
    local dtype=weights and weights.dtype or 'intp'
    local simple=not weights or lr.can_cast(dtype,'float64','safe')
      or lr.can_cast(dtype,'complex128','safe')
    local counts
    if lo~=nil and simple then counts=equal_histogram(a,weights,edges,lo,hi,dtype)
    else counts=cumulative_histogram(a,weights,edges,dtype) end
    if options.density then
      local widths=lr.astype(lr.diff(edges),'float64')
      counts=lr.true_divide(lr.true_divide(counts,widths),lr.sum(counts))
    end
    return counts,edges
  end
end
