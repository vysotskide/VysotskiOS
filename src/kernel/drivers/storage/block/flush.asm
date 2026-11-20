dflush:
  push r9
  push r12
  push rbx
dfl0:
  cmp byte ptr [dbusy],0
  je dfl1
  call yield
  jmp dfl0
dfl1:
  mov byte ptr [dbusy],1
  cmp byte ptr [dkind],2
  je dfl_a
  cmp byte ptr [dkind],1
  jne dfl9
  mov dx,[idecmd]
  add dx,7
  mov al,0E7h
  out dx,al
  mov rbx,[ticks]
  add rbx,500
dfl2:
  mov dx,[idectl]
  in al,dx
  test al,80h
  jz dfl9
  cmp [ticks],rbx
  jae dfl9
  call yield
  jmp dfl2
dfl_a:
  xor ebx,ebx
  xor r10d,r10d
  xor r11d,r11d
  mov r12d,0EAh
  call ahci_do
dfl9:
  mov byte ptr [dbusy],0
  pop rbx
  pop r12
  pop r9
  ret
