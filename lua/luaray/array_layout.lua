-- NumPy 2.5.5 aliases and small layout compositions.
return function(lr)
  lr.concat=lr.concatenate

  function lr.permute_dims(input,axes)
    return lr.transpose(lr.asanyarray(input),axes)
  end

  function lr.matrix_transpose(input)
    local array=lr.asanyarray(input)
    if array.ndim<2 then error('matrix_transpose requires at least two dimensions',2) end
    return lr.swapaxes(array,-1,-2)
  end

  function lr.unstack(input,axis)
    local array=lr.asanyarray(input)
    if array.ndim==0 then error('unstack requires at least one dimension',2) end
    if axis==nil then axis=1 end
    local moved=lr.moveaxis(array,axis,1)
    local pieces={}
    for i=1,moved.shape[1] do
      pieces[i]=moved:get(i)
    end
    return pieces
  end
  local lexsort=lr.lexsort
  function lr.lexsort(keys,axis)
    if type(keys)=='userdata' then keys=lr.unstack(keys) end
    return lexsort(keys,axis)
  end
end
