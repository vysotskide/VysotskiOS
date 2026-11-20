getc:
gc1:
  mov rax,[ticks]
  cmp rax,[kbt]
  jne gc0
  call yield
  jmp gc1
gc0:
  mov [kbt],rax
gc2:
  in al,64h
  cmp al,0FFh
  je gc1
  test al,1
  jz gc1
  test al,20h
  jz gc3
  in al,60h
  jmp gc2
gc3:
  in al,60h
  cmp al,0E0h
  jne gc4
  mov byte ptr [kext],1
  jmp gc2
gc4:
  cmp byte ptr [kext],0
  je gc5
  mov byte ptr [kext],0
  jmp gc2
gc5:
  cmp al,2Ah
  je gson
  cmp al,36h
  jne gc6
gson:
  mov byte ptr [kshift],1
  jmp gc2
gc6:
  cmp al,0AAh
  je gsoff
  cmp al,0B6h
  jne gc7
gsoff:
  mov byte ptr [kshift],0
  jmp gc2
gc7:
  cmp al,58
  jae gc2
  movzx eax,al
  lea rcx,[ktab]
  cmp byte ptr [kshift],0
  je gc8
  add rcx,58
gc8:
  mov al,[rcx+rax]
  test al,al
  jz gc2
  ret
