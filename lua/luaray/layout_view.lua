-- Give an empty reshape view's C-order axes their logical byte strides.
return function(lr,buffer,shape)
  local strides={}
  local step=buffer.itemsize
  for i=#shape,1,-1 do
    strides[i]=step
    local extent=math.max(shape[i],1)
    if step>math.maxinteger//extent then error('layout exceeds native range',3) end
    step=step*extent
  end
  return lr.ndarray(shape,{dtype=buffer.dtype,buffer=buffer,strides=strides})
end
