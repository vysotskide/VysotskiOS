puthex:
  push rcx
  push rdx
  mov ecx,8
ph1:
  rol eax,4
  mov edx,eax
  and edx,15
  push rax
  lea rax,[hexd]
  mov al,[rax+rdx]
  call putc
  pop rax
  dec ecx
  jnz ph1
  pop rdx
  pop rcx
  ret
