mkarena:
  mov rax,[stkbase]
  mov ecx,[ncpu]
  shl ecx,16
  add rax,rcx
  add rax,4095
  and rax,-4096
  mov [heapstart],rax
  mov rdx,rax
  mov eax,100000h
  call rcontain
  jnz fatalmem
  xor eax,eax
  mov rdx,[heapstart]
  call rsub
  jmp distribute

distribute:
  mov ecx,[rngn]
  mov esi,RNG
  xor r8d,r8d
dt1:
  test ecx,ecx
  jz dt2
  mov rax,[rsi+8]
  sub rax,[rsi]
  shr rax,12
  add r8,rax
  add rsi,16
  dec ecx
  jmp dt1
dt2:
  mov rax,r8
  xor edx,edx
  mov ecx,[ncpu]
  div rcx
  test rax,rax
  jnz dt3
  inc rax
dt3:
  mov r9,rax
  xor ebx,ebx
  call dq_setq
  mov esi,RNG
  mov ecx,[rngn]
dt4:
  test ecx,ecx
  jz dt9
  mov r11,[rsi]
  mov r12,[rsi+8]
dt5:
  cmp r11,r12
  jae dt8
  mov rax,r12
  sub rax,r11
  shr rax,12
  cmp rax,r10
  jbe dt6
  mov rax,r10
dt6:
  mov rdx,rax
  shl rdx,12
  add rdx,r11
  call addpiece
  sub r10,rax
  mov r11,rdx
  test r10,r10
  jnz dt5
  lea eax,[rbx+1]
  cmp eax,[ncpu]
  jae dt7
  mov ebx,eax
dt7:
  call dq_setq
  jmp dt5
dt8:
  add rsi,16
  dec ecx
  jmp dt4
dt9:
  ret

dq_setq:
  lea eax,[rbx+1]
  cmp eax,[ncpu]
  jb dq1
  mov r10,7FFFFFFFFFFFFFFFh
  ret
dq1:
  mov r10,r9
  ret
