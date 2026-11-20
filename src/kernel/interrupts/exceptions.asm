align 8
stubs:
vec = 0
rept 32
  push vec
  jmp fault
  align 8
  vec = vec + 1
endm

fault:
  pop rbx
  cld
  lea rsi,[mflt]
  call puts
  mov eax,ebx
  call putdec
  mov al,'@'
  call putc
  mov eax,dword ptr gs:[8]
  call putdec
  mov al,13
  call putc
  cmp byte ptr [sched_on],0
  jne fkill
fg0:
  cli
  hlt
  jmp fg0
