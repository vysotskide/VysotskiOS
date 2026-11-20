c_cpus:
  mov eax,[ncpu]
  call putdec
  mov al,20h
  call putc
  mov r10d,1
  mov r9d,1
  mov edx,APRDY
cp1:
  cmp r9d,[ncpu]
  jae cp2
  movzx eax,byte ptr [rdx+r9]
  add r10d,eax
  inc r9d
  jmp cp1
cp2:
  mov eax,r10d
  call putdec
  mov al,13
  jmp putc
