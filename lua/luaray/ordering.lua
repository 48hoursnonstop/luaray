-- NumPy 2.5.5 lib/_function_base_impl.py:sort_complex.
return function(lr)
  function lr.sort_complex(input)
    local values=lr.sort(lr.asanyarray(input))
    local dtype=lr.dtype(values.dtype)
    if dtype.kind=='c' then return values end
    if dtype.char=='g' then return lr.astype(values,'complex256') end
    if dtype.char:match('^[bhBH]$') then return lr.astype(values,'complex64') end
    return lr.astype(values,'complex128')
  end
end
