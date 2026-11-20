palloc:
  push rcx
  push rdi
  mov rax,qword ptr gs:[16]
  test rax,rax
  jz pbmp
  mov rcx,[rax]
  mov qword ptr gs:[16],rcx
  dec qword ptr gs:[72]
  jmp pzero
pbmp:
  mov rax,qword ptr gs:[24]
  lea rcx,[rax+4096]
  cmp rcx,qword ptr gs:[32]
  ja pnext
  mov qword ptr gs:[24],rcx
pzero:
  mov rdi,rax
  mov ecx,512
  push rax
  xor eax,eax
  rep stosq
  pop rax
  pop rdi
  pop rcx
  ret
pnext:
  mov ecx,dword ptr gs:[88]
  inc ecx
  cmp ecx,dword ptr gs:[80]
  jae pnone
  mov dword ptr gs:[88],ecx
  shl ecx,4
  mov rdi,qword ptr gs:[0]
  mov rax,[rdi+rcx+384]
  mov rcx,[rdi+rcx+392]
  mov qword ptr gs:[24],rax
  mov qword ptr gs:[32],rcx
  jmp pbmp
pnone:
  xor eax,eax
  pop rdi
  pop rcx
  ret

pfree:
  push rcx
  mov rcx,qword ptr gs:[16]
  mov [rax],rcx
  mov qword ptr gs:[16],rax
  inc qword ptr gs:[72]
  pop rcx
  ret
