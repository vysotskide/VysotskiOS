lspawn:
  mov ecx,1
ls1:
  mov esi,ecx
  shl esi,5
  cmp dword ptr [rdx+rsi+144],0
  je tinit
  inc ecx
  cmp ecx,FPC
  jb ls1
  ret

tinit:
  mov esi,ecx
  shl esi,5
  lea rsi,[rdx+rsi+128]
  mov [rsi+8],rax
  mov [rsi+16],r9d
  mov edi,[rdx+8]
  shl edi,3
  add edi,ecx
  shl edi,13
  add rdi,[stkbase]
  add rdi,2000h
  lea r8,[fexit]
  mov [rdi-8],r8
  mov [rdi-16],rax
  lea rdi,[rdi-136]
  mov [rsi],rdi
  mov ecx,15
  xor eax,eax
  rep stosq
  ret
