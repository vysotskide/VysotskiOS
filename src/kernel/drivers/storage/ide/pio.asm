ata_wait:
  mov dx,[idecmd]
  add dx,7
  mov ecx,100000h
awl:
  in al,dx
  test al,80h
  jz awo
  dec ecx
  jz awt
  test ecx,3FFh
  jnz awl
  call yield
  jmp awl
awt:
  stc
  ret
awo:
  clc
  ret

ata_drq:
  mov dx,[idecmd]
  add dx,7
  mov ecx,100000h
adq:
  in al,dx
  test al,80h
  jnz adn
  test al,21h
  jnz ade
  test al,8
  jnz ado
adn:
  dec ecx
  jz ade
  test ecx,3FFh
  jnz adq
  call yield
  jmp adq
ade:
  stc
  ret
ado:
  clc
  ret

ata_setup:
  mov eax,r11d
  shr eax,24
  and al,0Fh
  or al,0E0h
  or al,[idedev]
  mov dx,[idecmd]
  add dx,6
  out dx,al
  dec dx
  dec dx
  dec dx
  dec dx
  mov al,cl
  out dx,al
  mov eax,r11d
  inc dx
  out dx,al
  shr eax,8
  inc dx
  out dx,al
  shr eax,8
  inc dx
  out dx,al
  ret

ata_io:
  call ata_wait
  jc aret
  mov ecx,1
  call ata_setup
  mov al,20h
  test r10b,r10b
  jz aic
  mov al,30h
aic:
  mov dx,[idecmd]
  add dx,7
  out dx,al
  call ata_drq
  jc aret
  mov dx,[idecmd]
  mov ecx,256
  test r10b,r10b
  jnz awr
  rep insw
  clc
aret:
  ret
awr:
  mov rsi,rdi
  rep outsw
  mov rdi,rsi
  jmp ata_wait
