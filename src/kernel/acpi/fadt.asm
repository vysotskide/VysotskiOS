fadt:
  mov r8d,[rsi+4]
  mov eax,[rsi+40]
  cmp r8d,148
  jb fd1
  mov rcx,[rsi+140]
  test rcx,rcx
  jz fd1
  mov rax,rcx
fd1:
  mov [dsdt],rax
  mov eax,[rsi+48]
  mov [smicmd],eax
  movzx eax,byte ptr [rsi+52]
  mov [acpien],al
  movzx eax,byte ptr [rsi+88]
  mov [evtlen],al
  xor eax,eax
  cmp r8d,116
  jb fd2
  mov eax,[rsi+112]
fd2:
  mov [fflags],eax
  cmp r8d,129
  jb fd3
  mov al,[rsi+128]
  mov [rstv],al
fd3:
  lea rdi,[pm1as]
  mov ecx,[rsi+56]
  mov edx,148
  call loadgas
  lea rdi,[pm1bs]
  mov ecx,[rsi+60]
  mov edx,160
  call loadgas
  lea rdi,[pm1ac]
  mov ecx,[rsi+64]
  mov edx,172
  call loadgas
  lea rdi,[pm1bc]
  mov ecx,[rsi+68]
  mov edx,184
  call loadgas
  lea rdi,[slpc]
  xor ecx,ecx
  mov edx,244
  call loadgas
  lea rdi,[slps]
  xor ecx,ecx
  mov edx,256
  call loadgas
  lea rdi,[rstr]
  xor ecx,ecx
  mov edx,116
  call loadgas
  movzx ecx,byte ptr [evtlen]
  shr ecx,1
  lea rsi,[pm1as]
  lea rdi,[pm1ae]
  call mkens
  lea rsi,[pm1bs]
  lea rdi,[pm1be]
  jmp mkens

mkens:
  mov eax,[rsi]
  mov [rdi],eax
  mov rax,[rsi+8]
  test rax,rax
  jz mk1
  add rax,rcx
mk1:
  mov [rdi+8],rax
  ret
