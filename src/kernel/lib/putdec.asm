putdec:
  mov ecx,10
  xor r8d,r8d
pdd:
  xor edx,edx
  div ecx
  push rdx
  inc r8d
  test eax,eax
  jnz pdd
pdp:
  pop rax
  add al,'0'
  call putc
  dec r8d
  jnz pdp
  ret
