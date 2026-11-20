snap_wobj:
  push rbx
  push r13
  push r14
  mov rbx,[rbp+32]
  xor r13d,r13d
  mov dword ptr [scrc],0FFFFFFFFh
sw1:
  test rbx,rbx
  jz sw9
  mov edi,BOUNCE
  xor r14d,r14d
sw2:
  test rbx,rbx
  jz sw3
  cmp r14d,10000h
  jae sw3
  mov edx,r13d
  push rdi
  call oa_page
  pop rdi
  mov rsi,rax
  mov ecx,4096
  cmp rbx,rcx
  jae sw4
  mov ecx,ebx
  add ecx,511
  and ecx,-512
sw4:
  mov eax,ecx
  shr ecx,3
  rep movsq
  add r14d,eax
  cmp rbx,4096
  jae sw5
  xor ebx,ebx
  jmp sw6
sw5:
  sub rbx,4096
sw6:
  inc r13d
  jmp sw2
sw3:
  mov esi,BOUNCE
  mov ecx,r14d
  mov edx,[scrc]
  call crc32f
  mov [scrc],edx
  mov r11d,r12d
  push rbx
  mov ebx,r14d
  shr ebx,9
  mov r10b,1
  call bop
  pop rbx
  jc swf
  mov eax,r14d
  shr eax,9
  add r12,rax
  jmp sw1
sw9:
  mov eax,[scrc]
  not eax
  mov [rbp+48],eax
  clc
  pop r14
  pop r13
  pop rbx
  ret
swf:
  stc
  pop r14
  pop r13
  pop rbx
  ret
