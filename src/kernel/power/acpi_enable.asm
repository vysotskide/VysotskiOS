pwrinit:
  test dword ptr [fflags],100000h
  jnz pw_en
  cmp qword ptr [pm1ac_a],0
  je pwx
  lea rdi,[pm1ac]
  call rr16
  test al,1
  jnz pw_en
  mov edx,[smicmd]
  test edx,edx
  jz pw_en
  movzx eax,byte ptr [acpien]
  test eax,eax
  jz pw_en
  out dx,al
  mov rbx,[ticks]
  add rbx,3000
pw0:
  lea rdi,[pm1ac]
  call rr16
  test al,1
  jnz pw_en
  cmp [ticks],rbx
  jae pw_en
  call yield
  jmp pw0
pw_en:
  cmp qword ptr [pm1ae_a],0
  je pw2
  lea rdi,[pm1as]
  mov ax,100h
  call rw16
  lea rdi,[pm1ae]
  call rr16
  or ax,100h
  call rw16
pw2:
  cmp qword ptr [pm1be_a],0
  je pwx
  lea rdi,[pm1bs]
  mov ax,100h
  call rw16
  lea rdi,[pm1be]
  call rr16
  or ax,100h
  call rw16
pwx:
  ret
