probe_ahci:
  call pcibdf
  mov ecx,4
  call pcir
  or eax,6
  movzx eax,ax
  call pciw
  mov ecx,24h
  call pcir
  test al,1
  jnz pa9
  and eax,-16
  jz pa9
  mov [ahcib],rax
  call mapuc
  mov rsi,[ahcib]
  mov eax,[rsi+4]
  or eax,80000000h
  mov [rsi+4],eax
  mov eax,[rsi+24h]
  test al,1
  jz pa1
  mov eax,[rsi+28h]
  test al,1
  jz pa1
  or eax,2
  mov [rsi+28h],eax
  mov r9,[ticks]
  add r9,2000
pa0:
  mov eax,[rsi+28h]
  test al,1
  jz pa1
  cmp [ticks],r9
  jae pa1
  call yield
  jmp pa0
pa1:
  mov eax,[rsi+0Ch]
  mov [pimpl],eax
  mov dword ptr [pport],0
pa_port:
  mov eax,[pimpl]
  mov ecx,[pport]
  bt eax,ecx
  jnc pa_next
  mov rdx,[ahcib]
  mov eax,ecx
  shl eax,7
  lea rdx,[rdx+rax+100h]
  mov [ahcip],rdx
  mov eax,[rdx+28h]
  and eax,0F0Fh
  cmp eax,103h
  jne pa_next
  cmp dword ptr [rdx+24h],101h
  jne pa_next
  call ahci_port_init
  jc pa_next
  mov byte ptr [dkind],2
  call ahci_ident
  jc pa_no
  xor r11d,r11d
  mov ebx,1
  xor r10d,r10d
  call bop
  jc pa_no
  mov esi,BOUNCE
  mov edi,BOOT_SECTOR
  mov ecx,64
  repe cmpsq
  jne pa_no
  mov rax,[dcap]
  mov rcx,0FFFFFFFFh
  cmp rax,rcx
  jbe pa2
  mov rax,rcx
pa2:
  mov [dlimit],rax
  ret
pa_no:
  mov byte ptr [dkind],0
  call ahci_stop
pa_next:
  inc dword ptr [pport]
  cmp dword ptr [pport],32
  jb pa_port
pa9:
  ret
