ide_ident:
  mov dx,[idecmd]
  add dx,6
  mov al,[idedev]
  or al,0A0h
  out dx,al
  mov dx,[idectl]
  in al,dx
  in al,dx
  in al,dx
  in al,dx
  mov dx,[idecmd]
  add dx,7
  in al,dx
  cmp al,0FFh
  je iid_no
  test al,al
  jz iid_no
  mov dx,[idecmd]
  add dx,2
  xor eax,eax
  out dx,al
  inc dx
  out dx,al
  inc dx
  out dx,al
  inc dx
  out dx,al
  mov dx,[idecmd]
  add dx,7
  mov al,0ECh
  out dx,al
  in al,dx
  test al,al
  jz iid_no
  call ata_wait
  jc iid_no
  mov dx,[idecmd]
  add dx,4
  in al,dx
  mov ah,al
  inc dx
  in al,dx
  or al,ah
  jnz iid_no
  call ata_drq
  jc iid_no
  mov dx,[idecmd]
  mov ecx,256
  mov edi,BOUNCE
  rep insw
  mov esi,BOUNCE
  test word ptr [rsi+98],200h
  jz iid_no
  mov eax,[rsi+120]
  test word ptr [rsi+166],400h
  jz iid_c
  mov rax,[rsi+200]
iid_c:
  mov [dcap],rax
  clc
  ret
iid_no:
  stc
  ret
