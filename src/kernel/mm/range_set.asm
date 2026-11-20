rput:
  cmp r12,r13
  jae rp9
  cmp r9d,256
  jae rp9
  mov r14d,r9d
  shl r14d,4
  mov [rdi+r14],r12
  mov [rdi+r14+8],r13
  inc r9d
rp9:
  ret

rsub:
  push rsi
  push r8
  mov ecx,[rngn]
  mov esi,RNG
  mov edi,RNG2
  xor r9d,r9d
rs_l:
  test ecx,ecx
  jz rs_d
  mov r10,[rsi]
  mov r11,[rsi+8]
  cmp rdx,r10
  jbe rs_keep
  cmp rax,r11
  jae rs_keep
  cmp rax,r10
  jbe rs_nol
  mov r12,r10
  mov r13,rax
  call rput
rs_nol:
  cmp rdx,r11
  jae rs_nx
  mov r12,rdx
  mov r13,r11
  call rput
  jmp rs_nx
rs_keep:
  mov r12,r10
  mov r13,r11
  call rput
rs_nx:
  add rsi,16
  dec ecx
  jmp rs_l
rs_d:
  mov [rngn],r9d
  mov ecx,r9d
  shl ecx,1
  mov esi,RNG2
  mov edi,RNG
  rep movsq
  pop r8
  pop rsi
  ret

rcontain:
  mov ecx,[rngn]
  mov esi,RNG
rc1:
  test ecx,ecx
  jz rc_no
  cmp [rsi],rax
  ja rc_n
  cmp [rsi+8],rdx
  jb rc_n
  xor ecx,ecx
  ret
rc_n:
  add rsi,16
  dec ecx
  jmp rc1
rc_no:
  or ecx,1
  ret
