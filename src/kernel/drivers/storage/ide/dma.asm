ide_dma:
  mov eax,ebx
  shl eax,9
  and eax,0FFFFh
  or eax,80000000h
  mov esi,PRDT
  mov dword ptr [rsi],BOUNCE
  mov [rsi+4],eax
  movzx edx,word ptr [idebm]
  add edx,4
  mov eax,PRDT
  out dx,eax
  sub edx,2
  mov al,6
  out dx,al
  call ata_wait
  jc idm_e
  mov ecx,ebx
  call ata_setup
  mov al,0C8h
  test r10b,r10b
  jz idm_c
  mov al,0CAh
idm_c:
  mov dx,[idecmd]
  add dx,7
  out dx,al
  movzx edx,word ptr [idebm]
  mov al,9
  test r10b,r10b
  jz idm_g
  mov al,1
idm_g:
  out dx,al
  mov r9,[ticks]
  add r9,2000
idm_p:
  movzx edx,word ptr [idebm]
  add edx,2
  in al,dx
  test al,1
  jnz idm_w
  mov dx,[idectl]
  in al,dx
  test al,80h
  jz idm_d
idm_w:
  cmp [ticks],r9
  jae idm_s
  call yield
  jmp idm_p
idm_d:
  movzx edx,word ptr [idebm]
  add edx,2
  in al,dx
  mov cl,al
  mov al,6
  out dx,al
  sub edx,2
  xor eax,eax
  out dx,al
  mov dx,[idecmd]
  add dx,7
  in al,dx
  test cl,2
  jnz idm_e
  test al,21h
  jnz idm_e
  clc
  ret
idm_s:
  movzx edx,word ptr [idebm]
  xor eax,eax
  out dx,al
idm_e:
  stc
  ret
