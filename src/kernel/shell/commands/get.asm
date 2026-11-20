c_get:
  call getobj
  test rax,rax
  jz bad
  mov rbp,rax
  mov r15,[rbp+32]
  xor r13d,r13d
cg1:
  test r15,r15
  jz cg9
  mov edx,r13d
  call oa_page
  mov rsi,rax
  mov ecx,4096
  cmp r15,rcx
  jae cg2
  mov ecx,r15d
cg2:
  sub r15,rcx
cg3:
  lodsb
  call putc
  dec ecx
  jnz cg3
  inc r13d
  jmp cg1
cg9:
  mov al,13
  jmp putc
