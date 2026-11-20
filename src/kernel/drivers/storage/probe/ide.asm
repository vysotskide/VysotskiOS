probe_ide:
  mov eax,r12d
  shr eax,8
  mov [pprog],al
  call pcibdf
  mov ecx,4
  call pcir
  or eax,5
  movzx eax,ax
  call pciw
  mov ecx,20h
  call pcir
  and eax,0FFFCh
  mov [pbmb],eax
  mov byte ptr [pchan],0
pi_ch:
  call pcibdf
  cmp byte ptr [pchan],0
  jne pi_sec
  test byte ptr [pprog],1
  jz pi_pc
  mov ecx,10h
  call pcir
  and eax,0FFFCh
  mov [idecmd],ax
  mov ecx,14h
  call pcir
  and eax,0FFFCh
  add eax,2
  mov [idectl],ax
  jmp pi_bm
pi_pc:
  mov word ptr [idecmd],1F0h
  mov word ptr [idectl],3F6h
  jmp pi_bm
pi_sec:
  test byte ptr [pprog],4
  jz pi_sc
  mov ecx,18h
  call pcir
  and eax,0FFFCh
  mov [idecmd],ax
  mov ecx,1Ch
  call pcir
  and eax,0FFFCh
  add eax,2
  mov [idectl],ax
  jmp pi_bm
pi_sc:
  mov word ptr [idecmd],170h
  mov word ptr [idectl],376h
pi_bm:
  xor eax,eax
  test byte ptr [pprog],80h
  jz pi_b0
  mov eax,[pbmb]
  test eax,eax
  jz pi_b0
  cmp byte ptr [pchan],0
  je pi_b0
  add eax,8
pi_b0:
  mov [idebm],ax
  mov dx,[idectl]
  mov al,2
  out dx,al
  mov byte ptr [idedev],0
  call ide_try
  cmp byte ptr [dkind],0
  jne pi_done
  mov byte ptr [idedev],10h
  call ide_try
  cmp byte ptr [dkind],0
  jne pi_done
  inc byte ptr [pchan]
  cmp byte ptr [pchan],2
  jb pi_ch
pi_done:
  ret

ide_try:
  call ide_ident
  jc it9
  mov byte ptr [dkind],1
  xor r11d,r11d
  mov ebx,1
  xor r10d,r10d
  call bop
  jc it_no
  mov esi,BOUNCE
  mov edi,BOOT_SECTOR
  mov ecx,64
  repe cmpsq
  jne it_no
  mov rax,[dcap]
  mov rcx,10000000h
  cmp rax,rcx
  jbe it1
  mov rax,rcx
it1:
  mov [dlimit],rax
  ret
it_no:
  mov byte ptr [dkind],0
it9:
  ret
