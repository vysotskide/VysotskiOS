os_get:
  mov rax,[rsi]
  test rax,rax
  jnz osg
  push rsi
  push rdx
  call palloc
  pop rdx
  pop rsi
  test rax,rax
  jz osg
  mov [rsi],rax
osg:
  ret

oa_slot:
  cmp ecx,1
  jne os2
  lea rax,[rbp+40]
  ret
os2:
  lea rsi,[rbp+40]
  cmp ecx,2
  jne os3
  call os_get
  test rax,rax
  jz os9
  and edx,511
  lea rax,[rax+rdx*8]
  ret
os3:
  call os_get
  test rax,rax
  jz os9
  mov r8d,edx
  shr r8d,9
  lea rsi,[rax+r8*8]
  call os_get
  test rax,rax
  jz os9
  and edx,511
  lea rax,[rax+rdx*8]
  ret
os9:
  xor eax,eax
  ret
