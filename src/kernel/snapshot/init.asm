snapinit:
  mov rax,[dlimit]
  sub rax,SNAP0
  jbe sni0
  shr rax,1
  mov [areasz],rax
  ret
sni0:
  mov qword ptr [areasz],0
  ret
