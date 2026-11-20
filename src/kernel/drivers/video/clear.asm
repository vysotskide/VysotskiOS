clr:
  push rax
  push rcx
  push rdi
  mov edi,0B8000h
  mov rax,7020702070207020h
  mov ecx,20
  rep stosq
  mov rax,0720072007200720h
  mov ecx,480
  rep stosq
  mov dword ptr [cpos],80
  pop rdi
  pop rcx
  pop rax
  ret
