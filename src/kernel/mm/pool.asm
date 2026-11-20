poolpage:
  mov rax,[poolnext]
  cmp rax,[poolend]
  jae pp_f
  push rcx
  push rdi
  lea rcx,[rax+4096]
  mov [poolnext],rcx
  mov rdi,rax
  mov ecx,512
  push rax
  xor eax,eax
  rep stosq
  pop rax
  pop rdi
  pop rcx
  ret
pp_f:
  xor eax,eax
  ret
