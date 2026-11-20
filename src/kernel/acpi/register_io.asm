rr16:
  mov rdx,[rdi+8]
  cmp dword ptr [rdi],1
  jne rr1
  in ax,dx
  movzx eax,ax
  ret
rr1:
  movzx eax,word ptr [rdx]
  ret

rw16:
  mov rdx,[rdi+8]
  cmp dword ptr [rdi],1
  jne rw1
  out dx,ax
  ret
rw1:
  mov [rdx],ax
  ret

rw8:
  mov rdx,[rdi+8]
  cmp dword ptr [rdi],1
  jne rw81
  out dx,al
  ret
rw81:
  mov [rdx],al
  ret
