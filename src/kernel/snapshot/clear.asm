snapclear:
  mov ebp,OTAB
  mov r9d,NOBJ
scl1:
  cmp byte ptr [rbp],0
  je scl2
  cmp qword ptr [rbp+40],0
  je scl2
  call oa_free
scl2:
  add rbp,OE
  dec r9d
  jnz scl1
  mov edi,OTAB
  mov ecx,NOBJ*OE/8
  xor eax,eax
  rep stosq
  ret
