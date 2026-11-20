-- NumPy 2.5.5 lib/_function_base_impl.py: digitize and compiled_base monotonicity.
return function(lr)
  local function direction(edges)
    local n=edges.size
    if n<2 then return 1 end
    local first=edges[1]
    local i=2
    while i<=n and edges[i]==first do i=i+1 end
    if i>n then return 1 end
    local last=edges[i]
    local increasing=first<last
    for j=i+1,n do
      local next_value=edges[j]
      if (increasing and last>next_value) or (not increasing and last<next_value) then
        error('bin edges must be monotone',3)
      end
      last=next_value
    end
    return increasing and 1 or -1
  end

  function lr.digitize(input,bins,right)
    if right~=nil and type(right)~='boolean' then error('right must be a boolean',2) end
    local x=lr.asanyarray(input)
    local edges=lr.asanyarray(bins)
    if lr.dtype(x.dtype).kind=='c' then error('digitize input must be real',2) end
    if edges.ndim~=1 or not lr.can_cast(edges.dtype,'float64','safe') then
      error('bin edges must be a one-dimensional array safely convertible to float64',2)
    end
    local sign=direction(lr.astype(edges,'float64'))
    local side=right and 'left' or 'right'
    local sorted=sign<0 and lr.flip(edges,1) or edges
    local positions=lr.searchsorted(sorted,x,side)
    if type(positions)=='number' then
      return sign<0 and edges.size+1-positions or positions-1
    end
    if sign<0 then return lr.subtract(edges.size+1,positions) end
    return lr.subtract(positions,1)
  end
end
