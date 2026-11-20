rsdscan:
  mov rdx,2052545020445352h
rs1:
  cmp [rsi],rdx
  jne rs3
  call rsck
  jz rsf
rs3:
  add esi,16
  dec ecx
  jnz rs1
  xor esi,esi
rsf:
  ret

rsck:
  xor eax,eax
  mov r8d,20
  mov rdi,rsi
rk1:
  add al,[rdi]
  inc rdi
  dec r8d
  jnz rk1
  test al,al
  jnz rk9
  cmp byte ptr [rsi+15],2
  jb rk8
  mov r8d,[rsi+20]
  cmp r8d,36
  jb rk7
  cmp r8d,1024
  ja rk7
  xor eax,eax
  mov rdi,rsi
rk2:
  add al,[rdi]
  inc rdi
  dec r8d
  jnz rk2
  test al,al
  ret
rk7:
  or eax,1
  ret
rk8:
  xor eax,eax
rk9:
  ret
