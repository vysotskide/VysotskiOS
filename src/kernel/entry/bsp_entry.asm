bsp:
  cli
  cld
  mov ax,16
  mov ds,ax
  mov es,ax
  mov ss,ax
  mov esp,BSPSTK
  mov edi,20000h
  mov ecx,12000h/8
  xor eax,eax
  rep stosq
  mov edi,CPUS
  mov ecx,64
  rep stosq
  mov eax,CPUS
  mov [rax],rax
  xor edx,edx
  mov ecx,0C0000101h
  wrmsr
  call clr
  lea rsi,[mhello]
  call puts
  call memmap
  mov edi,CPUS
  mov ecx,(1B0000h-100000h)/8
  xor eax,eax
  rep stosq
  mov eax,CPUS
  mov [rax],rax
  call crcinit
  mov eax,1
  cpuid
  bt ecx,31
  setc byte ptr [hv]
  bt ecx,21
  setc byte ptr [x2cap]
  mov ecx,1Bh
  rdmsr
  mov r8d,eax
  shl rdx,32
  or rax,rdx
  mov rcx,0FFFFFF000h
  and rax,rcx
  mov [lapicb],rax
  test r8d,400h
  jz nox2
  mov byte ptr [x2],1
nox2:
  mov rax,[lapicb]
  call mapuc
  call apicid
  mov [bspid],eax
  mov edx,AIDS
  mov [rdx],eax
  call acpi
  cmp byte ptr [needx2],0
  je nx2
  cmp byte ptr [x2],0
  jne nx2
  cmp byte ptr [x2cap],0
  je nx2
  mov ecx,1Bh
  rdmsr
  or eax,0C00h
  wrmsr
  mov byte ptr [x2],1
nx2:
  call mkarena
  mov edi,GDT
  mov qword ptr [rdi],0
  mov rax,00AF9A000000FFFFh
  mov [rdi+8],rax
  mov rax,00CF92000000FFFFh
  mov [rdi+16],rax
  xor ebx,ebx
tsl:
  cmp ebx,[ncpu]
  jae tsd
  mov r8d,ebx
  shl r8d,7
  add r8d,TSSB
  mov edi,ebx
  shl edi,4
  add edi,GDT+24
  mov rax,r8
  mov word ptr [rdi],103
  mov word ptr [rdi+2],ax
  shr rax,16
  mov byte ptr [rdi+4],al
  mov byte ptr [rdi+5],89h
  mov byte ptr [rdi+6],0
  mov byte ptr [rdi+7],ah
  mov dword ptr [rdi+8],0
  mov dword ptr [rdi+12],0
  lea ecx,[rbx+1]
  shl ecx,10
  add ecx,FSTK
  mov dword ptr [r8+36],ecx
  mov word ptr [r8+102],104
  inc ebx
  jmp tsl
tsd:
  lgdt tbyte ptr [gdtr]
  mov ax,16
  mov ds,ax
  mov es,ax
  mov ss,ax
  mov ax,18h
  ltr ax
  mov edi,IDT
  lea rbx,[stubs]
  mov ecx,32
  mov edx,8E01h
idl:
  mov rax,rbx
  call gate
  add rbx,8
  loop idl
  mov edx,8E00h
  lea rax,[irq0]
  call gate
  mov edi,IDT+0F0h*16
  lea rax,[ipitick]
  call gate
  mov edi,IDT+0FFh*16
  lea rax,[ispur]
  call gate
  lidt tbyte ptr [idtr]
  mov al,11h
  out 20h,al
  out 0A0h,al
  mov al,32
  out 21h,al
  mov al,40
  out 0A1h,al
  mov al,4
  out 21h,al
  mov al,2
  out 0A1h,al
  mov al,1
  out 21h,al
  out 0A1h,al
  mov al,0FEh
  out 21h,al
  mov al,0FFh
  out 0A1h,al
  mov al,34h
  out 43h,al
  mov ax,1193
  out 40h,al
  mov al,ah
  out 40h,al
  call kbinit
  mov ecx,0F0h
  mov eax,1FFh
  call lapw
  mov ecx,80h
  xor eax,eax
  call lapw
  mov ecx,350h
  mov eax,700h
  call lapw
  xor ebx,ebx
pc1:
  cmp ebx,[ncpu]
  jae pcd
  mov edx,ebx
  shl edx,9
  add edx,CPUS
  mov [rdx],rdx
  mov [rdx+8],ebx
  mov dword ptr [rdx+12],0
  lea ecx,[rbx+1]
  shl ecx,10
  add ecx,FSTK
  mov [rdx+64],rcx
  lea rax,[idle]
  xor ecx,ecx
  mov r9d,'I'*256+3
  call tinit
  inc ebx
  jmp pc1
pcd:
  mov edx,CPUS
  lea rax,[shellmain]
  mov r9d,'S'*256+3
  call lspawn
  lea rax,[hk]
  mov r9d,'H'*256+3
  call lspawn
  sti
  mov ebx,1
apl:
  cmp ebx,[ncpu]
  jae apd
  mov edx,AIDS
  mov edx,[rdx+rbx*4]
  mov eax,4500h
  call ipi_send
  mov eax,20
  call delay
  mov edx,AIDS
  mov edx,[rdx+rbx*4]
  mov eax,4608h
  call ipi_send
  mov eax,2
  call delay
  mov edx,AIDS
  mov edx,[rdx+rbx*4]
  mov eax,4608h
  call ipi_send
  mov ecx,200
apw2:
  mov edx,APRDY
  cmp byte ptr [rdx+rbx],0
  jne apok
  mov eax,1
  call delay
  dec ecx
  jnz apw2
apok:
  inc ebx
  jmp apl
apd:
  cli
  mov byte ptr [sched_on],1
  mov byte ptr [sched_go],1
  mov rdx,qword ptr gs:[0]
  jmp fnext
