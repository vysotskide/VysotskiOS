tblok:
  push rcx
  mov ecx,[rax+4]
  cmp ecx,36
  jb tb_bad
  cmp ecx,1000000h
  ja tb_bad
  xor ecx,ecx
  pop rcx
  ret
tb_bad:
  or ecx,1
  pop rcx
  ret
