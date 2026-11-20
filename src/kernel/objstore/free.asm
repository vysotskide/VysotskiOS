of_idx:
  mov r13,rax
  xor ecx,ecx
ofi1:
  mov rax,[r13+rcx*8]
  test rax,rax
  jz ofi2
  call pfree
ofi2:
  inc ecx
  cmp ecx,512
  jb ofi1
  mov rax,r13
  jmp pfree

oa_free:
  push rbx
  push r12
  push r13
  mov rax,[rbp+32]
  add rax,4095
  shr rax,12
  call oa_lvl
  mov rbx,[rbp+40]
  test rbx,rbx
  jz of9
  cmp eax,1
  jne of2
  mov rax,rbx
  call pfree
  jmp of9
of2:
  cmp eax,2
  jne of3
  mov rax,rbx
  call of_idx
  jmp of9
of3:
  xor r12d,r12d
of3l:
  mov rax,[rbx+r12*8]
  test rax,rax
  jz of3n
  call of_idx
of3n:
  inc r12d
  cmp r12d,512
  jb of3l
  mov rax,rbx
  call pfree
of9:
  mov qword ptr [rbp+32],0
  mov qword ptr [rbp+40],0
  pop r13
  pop r12
  pop rbx
  ret
