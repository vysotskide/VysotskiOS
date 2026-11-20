hk:
  call pwrinit
  mov edi,0B8000h+124
  lea rsi,[mtick]
hk1:
  lodsb
  test al,al
  jz hk2
  mov ah,70h
  stosw
  jmp hk1
hk2:
  lea rbx,[hexd]
hk3:
  mov rax,[ticks]
  cmp rax,[hkt]
  je hk9
  mov [hkt],rax
  call drain
  xor r12d,r12d
  cmp qword ptr [pm1as_a],0
  je hk4
  lea rdi,[pm1as]
  call rr16
  or r12d,eax
hk4:
  cmp qword ptr [pm1bs_a],0
  je hk5
  lea rdi,[pm1bs]
  call rr16
  or r12d,eax
hk5:
  test r12d,100h
  jz hk6
  cmp qword ptr [pm1as_a],0
  je hk5a
  lea rdi,[pm1as]
  mov ax,100h
  call rw16
hk5a:
  cmp qword ptr [pm1bs_a],0
  je hk5b
  lea rdi,[pm1bs]
  mov ax,100h
  call rw16
hk5b:
  call poweroff
hk6:
  mov eax,dword ptr [hkt]
  test eax,63
  jnz hk9
  mov edi,0B8000h+140
  mov ecx,8
hk7:
  rol eax,4
  mov edx,eax
  and edx,15
  mov dl,[rbx+rdx]
  mov dh,70h
  mov [rdi],dx
  add rdi,2
  loop hk7
hk9:
  call yield
  jmp hk3
