ide_op:
  mov eax,r11d
  add eax,ebx
  jc idm_e
  cmp eax,10000000h
  ja idm_e
  cmp word ptr [idebm],0
  jne ide_dma
  push rbx
  push r11
  push rdi
  mov edi,BOUNCE
iop1:
  call ata_io
  jc iope
  inc r11d
  dec ebx
  jnz iop1
  clc
iope:
  pop rdi
  pop r11
  pop rbx
  ret
