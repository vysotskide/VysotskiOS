oa_append:
  push rbx
  push r12
  push r13
  mov r12,rsi
  mov r13d,ecx
  mov rbx,[rbp+32]
  mov rax,rbx
  add rax,r13
  call oa_ensure
  jc oap_f
oap_l:
  test r13d,r13d
  jz oap_ok
  mov rdx,rbx
  shr rdx,12
  call oa_page
  mov ecx,ebx
  and ecx,4095
  add rax,rcx
  mov rdi,rax
  mov eax,4096
  sub eax,ecx
  cmp eax,r13d
  jbe oap_1
  mov eax,r13d
oap_1:
  mov ecx,eax
  mov rsi,r12
  rep movsb
  mov r12,rsi
  add rbx,rax
  sub r13d,eax
  jmp oap_l
oap_ok:
  clc
  pop r13
  pop r12
  pop rbx
  ret
oap_f:
  stc
  pop r13
  pop r12
  pop rbx
  ret
