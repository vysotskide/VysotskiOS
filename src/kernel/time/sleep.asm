sleep:
  mov ecx,eax
  add rcx,[ticks]
sl1:
  cmp [ticks],rcx
  jae sl2
  call yield
  jmp sl1
sl2:
  ret
