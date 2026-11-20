mapuc:
  push rbx
  mov rbx,rax
  mov rsi,rax
  shr rsi,39
  and esi,511
  mov edx,BOOT_PML4
  lea rdx,[rdx+rsi*8]
  mov rax,[rdx]
  test al,1
  jnz mu1
  call poolpage
  test rax,rax
  jz mu9
  mov rcx,rax
  or rcx,3
  mov [rdx],rcx
  jmp mu2
mu1:
  and rax,-4096
mu2:
  mov rsi,rbx
  shr rsi,30
  and esi,511
  lea rdx,[rax+rsi*8]
  mov rax,[rdx]
  test al,1
  jnz mu3
  call poolpage
  test rax,rax
  jz mu9
  mov rcx,rax
  or rcx,3
  mov [rdx],rcx
  jmp mu4
mu3:
  and rax,-4096
mu4:
  mov rsi,rbx
  shr rsi,21
  and esi,511
  mov rcx,rbx
  and rcx,-200000h
  or rcx,9Bh
  mov [rax+rsi*8],rcx
  mov rax,cr3
  mov cr3,rax
mu9:
  pop rbx
  ret
