snap_robj:
  push rbx
  push r13
  push r14
  push r15
  mov ebx,[rbp+52]
  mov r12,[rbp+56]
  xor r13d,r13d
  mov dword ptr [scrc],0FFFFFFFFh
rd1:
  test rbx,rbx
  jz rd9
  mov rax,rbx
  add rax,511
  shr rax,9
  cmp rax,128
  jbe rd1a
  mov eax,128
rd1a:
  mov r14d,eax
  mov r11d,r12d
  push rbx
  mov ebx,r14d
  xor r10d,r10d
  call bop
  pop rbx
  jc rdf
  mov esi,BOUNCE
  mov ecx,r14d
  shl ecx,9
  mov edx,[scrc]
  call crc32f
  mov [scrc],edx
  mov esi,BOUNCE
  mov r15d,r14d
  shl r15d,9
rd2:
  test r15d,r15d
  jz rd3
  mov edx,r13d
  push rsi
  call oa_page
  pop rsi
  test rax,rax
  jz rdf
  mov rdi,rax
  mov ecx,4096
  cmp r15d,ecx
  jae rd2a
  mov ecx,r15d
rd2a:
  sub r15d,ecx
  shr ecx,3
  rep movsq
  inc r13d
  jmp rd2
rd3:
  mov eax,r14d
  add r12,rax
  mov rax,r14
  shl rax,9
  cmp rbx,rax
  jbe rd4
  sub rbx,rax
  jmp rd1
rd4:
  xor ebx,ebx
rd9:
  mov eax,[scrc]
  not eax
  cmp eax,[rbp+48]
  jne rdf
  clc
  pop r15
  pop r14
  pop r13
  pop rbx
  ret
rdf:
  stc
  pop r15
  pop r14
  pop r13
  pop rbx
  ret
