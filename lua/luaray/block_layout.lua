-- NumPy 2.5.5 _core/shape_base.py:block and lib/_function_base_impl.py:trim_zeros.
return function(lr)
  local function sequence(list)
    local n=#list
    local seen=0
    for key in pairs(list) do
      if math.type(key)~='integer' or key<1 or key>n then error('expected a dense sequence',3) end
      seen=seen+1
    end
    if seen~=n then error('expected a dense sequence',3) end
    return n
  end

  local function inspect(value,depth,state)
    if type(value)~='table' then
      if state.depth and state.depth~=depth then error('block lists must have equal depth',3) end
      local a=lr.asanyarray(value)
      state.depth=depth
      state.rank=math.max(state.rank,depth,a.ndim)
      state.size=math.min(524289,state.size+math.min(a.size,524289))
      return {array=a}
    end
    if depth==64 then error('block nesting exceeds maximum rank',3) end
    local n=sequence(value)
    if n==0 then error('block lists cannot be empty',3) end
    local children={}
    for i=1,n do children[i]=inspect(value[i],depth+1,state) end
    return {children=children,depth=depth}
  end

  local function promoted(node,rank)
    return lr.array(node.array,{copy=false,ndmin=rank})
  end

  local function concatenate(node,rank,depth)
    if node.array then return promoted(node,rank) end
    local blocks={}
    for i,child in ipairs(node.children) do blocks[i]=concatenate(child,rank,depth) end
    return lr.concatenate(blocks,rank-depth+node.depth+1)
  end

  local function layout(node,state)
    if node.array then
      local a=promoted(node,state.rank)
      node.array,node.shape=a,a.shape
      local dtype=lr.dtype(a.dtype)
      state.dtype=state.dtype and lr.result_type(state.dtype,dtype) or dtype
      state.fortran=state.fortran and a.flags.f_contiguous
      state.contiguous=state.contiguous and a.flags.c_contiguous
      return node.shape
    end
    local axis=state.rank-state.depth+node.depth+1
    local shape
    for _,child in ipairs(node.children) do
      local dims=layout(child,state)
      if not shape then
        shape={table.unpack(dims)}
      else
        for d,n in ipairs(dims) do
          if d==axis then
            if n>math.maxinteger-shape[d] then error('block axis is too large',3) end
            shape[d]=shape[d]+n
          elseif n~=shape[d] then
            error('block arrays must match on axes outside the join axis',3)
          end
        end
      end
    end
    node.axis,node.shape=axis,shape
    return shape
  end

  local function write_blocks(node,result,offset)
    if node.array then
      local indices={}
      for axis,n in ipairs(node.shape) do
        local start=offset[axis]
        indices[axis]=lr.s(start+1,start+n+1)
      end
      lr.copyto(result:get(table.unpack(indices)),node.array,'unsafe')
      return
    end
    local axis=node.axis
    local origin=offset[axis]
    for _,child in ipairs(node.children) do
      write_blocks(child,result,offset)
      offset[axis]=offset[axis]+child.shape[axis]
    end
    offset[axis]=origin
  end

  function lr.block(input)
    local state={rank=0,size=0,fortran=true,contiguous=true}
    local root=inspect(input,0,state)
    if state.depth==0 then return lr.copy(root.array,'C') end
    if state.size*state.depth<=524288 then
      return concatenate(root,state.rank,state.depth)
    end
    local shape=layout(root,state)
    local order=state.fortran and not state.contiguous and 'F' or 'C'
    local result=lr.empty(shape,{dtype=state.dtype,order=order})
    local offset={}
    for i=1,#shape do offset[i]=0 end
    if result.size>0 then write_blocks(root,result,offset) end
    return result
  end

  local function selected_axes(rank,axis)
    if axis==nil then
      local all={}
      for i=1,rank do all[i]=i end
      return all
    end
    local entries=type(axis)=='table' and axis or {axis}
    local result,used={},{}
    for i=1,sequence(entries) do
      local n=entries[i]
      if math.type(n)~='integer' then error('trim axis must be an integer',3) end
      n=n<0 and n+rank+1 or n
      if n<1 or n>rank or used[n] then error('invalid or repeated trim axis',3) end
      result[i],used[n]=n,true
    end
    return result
  end

  function lr.trim_zeros(input,trim,axis)
    if trim==nil then trim='fb' end
    if type(trim)~='string' then error('trim must be a string',2) end
    trim=trim:lower()
    if trim~='fb' and trim~='bf' and trim~='f' and trim~='b' then
      error('trim must be f, b or fb',2)
    end
    local a=lr.asanyarray(input)
    local axes=selected_axes(a.ndim,axis)
    if #axes==0 then return input end
    local front=trim~='b'
    local back=trim~='f'
    local indices={}
    for i=1,a.ndim do indices[i]=lr.s() end
    local shape=a.shape
    local start,stop
    for _,d in ipairs(axes) do
      local reduce={}
      for i=1,a.ndim do
        if i~=d then reduce[#reduce+1]=i end
      end
      local active=lr.flatnonzero(#reduce==0 and a or lr.any(a,{axis=reduce}))
      if active.size==0 then
        start,stop=1,1
      else
        start=front and active[1] or 1
        stop=back and active[active.size]+1 or shape[d]+1
      end
      indices[d]=lr.s(start,stop)
    end
    if type(input)=='table' and a.ndim==1 then
      local output={}
      for i=start,stop-1 do output[#output+1]=input[i] end
      return output
    end
    return a:get(table.unpack(indices))
  end
end
