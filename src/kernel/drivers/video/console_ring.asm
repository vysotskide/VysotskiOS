pring:
  push rcx
  push rdx
  movzx ecx,byte ptr gs:[56]
  lea edx,[rcx+1]
  cmp dl,byte ptr gs:[57]
  je prx
  mov edx,dword ptr gs:[8]
  shl edx,8
  add edx,CRING
  mov [rdx+rcx],al
  inc cl
  mov byte ptr gs:[56],cl
prx:
  pop rdx
  pop rcx
  ret

drain:
  mov r9d,1
dn1:
  cmp r9d,[ncpu]
  jae dr9
  mov edx,r9d
  shl edx,9
  add edx,CPUS
  mov r8d,r9d
  shl r8d,8
  add r8d,CRING
dn2:
  movzx ecx,byte ptr [rdx+57]
  cmp cl,byte ptr [rdx+56]
  je dn3
  mov al,[r8+rcx]
  call vputc
  inc cl
  mov [rdx+57],cl
  jmp dn2
dn3:
  inc r9d
  jmp dn1
dr9:
  ret
