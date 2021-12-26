fun! Get_tokens(pattern)
  let pat = a:pattern
  let lp = stridx(pat, "[")
  let rp = stridx(pat, "]")
  if (lp == -1 && rp == -1) 
    return "'" . pat . "';"
  elseif lp == rp - 1
    return "'" . pat[0:lp-1] . "';"
  endif
  let ar = []
  let cur = pat[0:lp-1]
  let ar = add(ar, "'" . cur . "'")
  let i = lp+1
  while i < rp
    let ch = pat[i]
    let cur = cur . ch 
    let ar = add(ar, "'" . cur . "'")
    let i += 1
  endwhile
  return join(ar, " | ") . ";"
endfunction'