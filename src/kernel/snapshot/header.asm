hdrload:
  mov edi,HDRB
  lea r11d,[rcx+127]
  mov r8d,1
  xor r10d,r10d
  push rcx
  call dio
  pop rcx
  jc hl_bad
  mov esi,HDRB
  mov rax,494B53544F535956h
  cmp [rsi],rax
  jne hl_bad
  cmp dword ptr [rsi+48],1
  jne hl_bad
  push rcx
  mov ecx,52
  mov edx,0FFFFFFFFh
  call crc32f
  not edx
  pop rcx
  mov esi,HDRB
  cmp edx,[rsi+52]
  jne hl_bad
  mov rax,[rsi+16]
  cmp rax,SNAP0
  jb hl_bad
  mov rax,[rsi+24]
  cmp rax,TS+1
  jb hl_bad
  mov edi,ecx
  dec edi
  shl edi,6
  lea rax,[hdrs]
  add rdi,rax
  mov ecx,8
  rep movsq
  clc
  ret
hl_bad:
  stc
  ret
