dmem:
  xor ebx,ebx
  xor esi,esi
dm1:
  call palloc
  test rax,rax
  jz dm2
  mov [rax],rbx
  mov rbx,rax
  inc esi
  cmp esi,1024
  jb dm1
dm2:
  mov edx,dword ptr gs:[8]
  shl edx,12
  or edx,esi
  call bar
  mov eax,2000
  call sleep
dm3:
  test rbx,rbx
  jz dm4
  mov rdx,[rbx]
  mov rax,rbx
  call pfree
  mov rbx,rdx
  jmp dm3
dm4:
  ret
