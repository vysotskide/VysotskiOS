slpwrite:
  cmp qword ptr [rdi+8],0
  je slw9
  call rr16
  and eax,0C3FFh
  mov ecx,ebx
  and ecx,7
  shl ecx,10
  or eax,ecx
  call rw16
  or eax,2000h
  call rw16
slw9:
  ret

acpioff:
  cmp byte ptr [s5ok],0
  je ao9
  test dword ptr [fflags],100000h
  jz ao_leg
  cmp qword ptr [slpc_a],0
  je ao_leg
  movzx eax,byte ptr [slptypa]
  shl eax,2
  or eax,20h
  lea rdi,[slpc]
  call rw8
  jmp ao_wait
ao_leg:
  lea rdi,[pm1ac]
  movzx ebx,byte ptr [slptypa]
  call slpwrite
  lea rdi,[pm1bc]
  movzx ebx,byte ptr [slptypb]
  call slpwrite
ao_wait:
  mov rbx,[ticks]
  add rbx,3000
ao_w:
  cmp [ticks],rbx
  jae ao9
  call yield
  jmp ao_w
ao9:
  ret
