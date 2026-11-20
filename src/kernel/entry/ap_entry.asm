apstart:
  cli
  cld
  mov ax,16
  mov ds,ax
  mov es,ax
  mov ss,ax
  mov esp,APSTK
  lgdt tbyte ptr [gdtr]
  lidt tbyte ptr [idtr]
  mov ecx,1Bh
  rdmsr
  cmp byte ptr [x2],0
  jne apx2
  test ah,4
  jz apen
  and eax,0FFFFF3FFh
  wrmsr
apen:
  or eax,800h
  wrmsr
  jmp apmd
apx2:
  or eax,0C00h
  wrmsr
apmd:
  call getcpu
  mov ebx,eax
  shl eax,9
  add eax,CPUS
  xor edx,edx
  mov ecx,0C0000101h
  wrmsr
  mov ecx,0F0h
  mov eax,1FFh
  call lapw
  mov ecx,80h
  xor eax,eax
  call lapw
  mov eax,ebx
  shl eax,4
  add eax,18h
  ltr ax
  mov edx,APRDY
  mov byte ptr [rdx+rbx],1
apw:
  cmp byte ptr [sched_go],0
  jne apg
  pause
  jmp apw
apg:
  mov rdx,qword ptr gs:[0]
  jmp fnext
