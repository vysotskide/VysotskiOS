oa_page:
  mov rax,[rbp+32]
  add rax,4095
  shr rax,12
  push rdx
  call oa_lvl
  pop rdx
  cmp eax,1
  jb op0
  jne op2
  mov rax,[rbp+40]
  ret
op2:
  mov rsi,[rbp+40]
  cmp eax,2
  jne op3
  mov rax,[rsi+rdx*8]
  ret
op3:
  mov r8d,edx
  shr r8d,9
  mov rsi,[rsi+r8*8]
  test rsi,rsi
  jz op0
  and edx,511
  mov rax,[rsi+rdx*8]
  ret
op0:
  xor eax,eax
  ret
