gate:
  mov word ptr [rdi],ax
  mov word ptr [rdi+2],8
  mov word ptr [rdi+4],dx
  shr rax,16
  mov word ptr [rdi+6],ax
  shr rax,16
  mov [rdi+8],rax
  add rdi,16
  ret
