c_rm:
  call getobj
  test rax,rax
  jz bad
  mov rbp,rax
  call oa_free
  xor eax,eax
  mov [rbp],rax
  mov [rbp+8],rax
  mov [rbp+16],rax
  mov [rbp+24],rax
  ret
