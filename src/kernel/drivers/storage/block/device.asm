devop:
  cmp byte ptr [dkind],1
  je ide_op
  cmp byte ptr [dkind],2
  je ahci_op
  stc
  ret

bop:
  push r9
  push r12
bp0:
  cmp byte ptr [dbusy],0
  je bp1
  call yield
  jmp bp0
bp1:
  mov byte ptr [dbusy],1
  call devop
  mov byte ptr [dbusy],0
  pop r12
  pop r9
  ret
