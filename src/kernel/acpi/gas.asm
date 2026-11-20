loadgas:
  mov dword ptr [rdi],1
  mov [rdi+8],rcx
  test edx,edx
  jz lg9
  lea eax,[rdx+12]
  cmp eax,r8d
  ja lg9
  mov rax,[rsi+rdx+4]
  test rax,rax
  jz lg9
  movzx ecx,byte ptr [rsi+rdx]
  cmp ecx,1
  ja lg9
  mov [rdi],ecx
  mov [rdi+8],rax
lg9:
  cmp dword ptr [rdi],0
  jne lg10
  cmp qword ptr [rdi+8],0
  je lg10
  push rsi
  push rdi
  mov rax,[rdi+8]
  call mapuc
  pop rdi
  pop rsi
lg10:
  ret
