delay:
  add rax,[ticks]
dly1:
  cmp [ticks],rax
  jae dly2
  hlt
  jmp dly1
dly2:
  ret
