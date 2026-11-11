-- NumPy2.5.3 _function_base_impl.py:interp and compiled_base.c:arr_interp.
return function(lr)
  local function isarray(value)return type(value)=='userdata' and value.ndim~=nil end
  local function converted(value,dtype,unsafe)
    if isarray(value) and not unsafe and not lr.can_cast(value.dtype,dtype,'safe') then
      error('interpolation input cannot be safely cast to '..dtype,3)
    end
    return lr.asarray(value,{dtype=dtype,order='C'})
  end
  local function endpoint(value,dtype)
    if isarray(value) and value.ndim~=0 then error('interpolation endpoint must be scalar',3) end
    if dtype=='float64' and lr.iscomplexobj(value) then error('real endpoint cannot be complex',3) end
    local scalar=lr.asarray(value,{dtype=dtype})
    if scalar.ndim~=0 then error('interpolation endpoint must be scalar',3) end
    return scalar:tolist()
  end
  -- Preserve the source's guess-assisted search, including small tables and
  -- its comparison order around nonfinite periodic coordinates.
  local function search(key,points,n,guess)
    if key>points[n] then return n+1 elseif key<points[1] then return 0 end
    if n<=4 then
      local i=2;while i<=n and key>=points[i] do i=i+1 end
      return i-1
    end
    local lower,upper=1,n+1
    guess=math.max(2,math.min(guess,n-2))
    if key<points[guess] then
      if key<points[guess-1] then
        upper=guess-1
        if guess>9 and key>=points[guess-8] then lower=guess-8 end
      else return guess-1 end
    else
      if key<points[guess+1] then return guess
      elseif key<points[guess+2] then return guess+1
      else
        lower=guess+2
        if guess<n-8 and key<points[guess+8] then upper=guess+8 end
      end
    end
    while lower<upper do
      local middle=lower+(upper-lower)//2
      if key>=points[middle] then lower=middle+1 else upper=middle end
    end
    return lower-1
  end
  local function interpolated(slope,x,x0,x1,y0,y1)
    local result=slope*(x-x0)+y0
    if result~=result then
      result=slope*(x-x1)+y1
      if result~=result and y0==y1 then result=y0 end
    end
    return result
  end
  function lr.interp(x,xp,fp,...)
    if select('#',...)>1 then error('interp accepts x, xp, fp and one options table',2) end
    local options=(...);if options==nil then options={} end
    if type(options)~='table' then error('interp options must be a table',2) end
    for key in pairs(options)do
      if key~='left' and key~='right' and key~='period' then error('unknown interp option',2) end
    end
    local samples=lr.asarray(fp)
    local complex=lr.issubdtype(samples.dtype,'complexfloating')
    local dtype=complex and 'complex128' or 'float64'
    local periodic=options.period~=nil
    samples=converted(samples,dtype,periodic)
    local points=converted(xp,'float64',periodic)
    local coordinates=converted(x,'float64',periodic)
    if samples.ndim~=1 or points.ndim~=1 then error('sample points and values must be one-dimensional',2) end
    if samples.size~=points.size then error('sample points and values must have equal length',2) end
    local period
    if periodic then
      local raw=options.period;local typed=isarray(raw)
      if type(raw)=='boolean' then raw=raw and 1 or 0 end
      if type(raw)~='number' then
        if not isarray(raw) or raw.ndim~=0 or lr.iscomplexobj(raw) then error('period must be a real scalar',2) end
        raw=raw:tolist()
      end
      if type(raw)=='boolean' then raw=raw and 1 or 0 end
      if not typed and math.type(raw)=='integer' and raw==math.mininteger then raw=raw+0.0 end
      period=math.abs(raw)
      if period==0 then error('period must be nonzero',2) end
      coordinates=lr.remainder(coordinates,period);points=lr.remainder(points,period)
      local order=lr.argsort(points);points=points:get(order);samples=samples:get(order)
      local n=points.size
      if n>0 then
        points=lr.concatenate({lr.subtract(points:get(lr.s(-1,nil)),period),points,lr.add(points:get(lr.s(1,2)),period)})
        samples=lr.concatenate({samples:get(lr.s(-1,nil)),samples,samples:get(lr.s(1,2))})
      end
    end
    local count=coordinates.size;local n=points.size
    if n==0 and count~=0 then error('sample points are empty',2) end
    local result=lr.empty(coordinates.shape,dtype)
    -- Empty output bypasses endpoint conversion in the pinned native kernel.
    if count==0 then return result end
    local left,right
    if not periodic then left,right=options.left,options.right end
    if left==nil then left=samples[1] else left=endpoint(left,dtype) end
    if right==nil then right=samples[n] else right=endpoint(right,dtype) end
    local xs=lr.ravel(coordinates);local out=result:reshape({count})
    local px,ys=points:tolist(),samples:tolist()
    local slopes
    if n>1 and n<=count then
      slopes={}
      for i=1,n-1 do
        if complex then
          local inverse=1.0/(px[i+1]-px[i])
          slopes[i]={(ys[i+1].real-ys[i].real)*inverse,(ys[i+1].imag-ys[i].imag)*inverse}
        else slopes[i]=(ys[i+1]-ys[i])/(px[i+1]-px[i]) end
      end
    end
    local guess=1
    for i=1,count do
      local value=xs[i];local answer
      if n==1 then answer=value<px[1] and left or (value>px[1] and right or ys[1])
      elseif value~=value then answer=complex and lr.complex(value,0.0) or value

      else
        local j=search(value,px,n,guess);guess=j
        if j==0 then answer=left
        elseif j==n+1 then answer=right
        elseif j==n or px[j]==value then answer=ys[j]
        elseif complex then
          local inverse=1.0/(px[j+1]-px[j])
          local real=slopes and slopes[j][1] or (ys[j+1].real-ys[j].real)*inverse
          local imag=slopes and slopes[j][2] or (ys[j+1].imag-ys[j].imag)*inverse
          answer=lr.complex(interpolated(real,value,px[j],px[j+1],ys[j].real,ys[j+1].real),
            interpolated(imag,value,px[j],px[j+1],ys[j].imag,ys[j+1].imag))
        else
          local slope=slopes and slopes[j] or (ys[j+1]-ys[j])/(px[j+1]-px[j])
          answer=interpolated(slope,value,px[j],px[j+1],ys[j],ys[j+1])
        end
      end
      out[i]=answer
    end
    return result
  end
end
