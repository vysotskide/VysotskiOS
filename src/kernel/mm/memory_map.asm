memmap:
  mov r8d,[BOOT_E820_COUNT]
  test r8d,r8d
  jz fatalmem
  mov esi,BOOT_E820_MAP
  mov edi,RNG
  xor r9d,r9d
mb1:
  test r8d,r8d
  jz mb9
  cmp dword ptr [rsi+16],1
  jne mb2
  mov rax,[rsi]
  mov rdx,[rsi+8]
  add rdx,rax
  add rax,4095
  and rax,-4096
  and rdx,-4096
  cmp rdx,rax
  jbe mb2
  cmp r9d,256
  jae mb2
  mov r10d,r9d
  shl r10d,4
  mov [rdi+r10],rax
  mov [rdi+r10+8],rdx
  inc r9d
mb2:
  add rsi,24
  dec r8d
  jmp mb1
mb9:
  mov [rngn],r9d
  mov r8d,[BOOT_E820_COUNT]
  mov esi,BOOT_E820_MAP
mc1:
  test r8d,r8d
  jz mc9
  cmp dword ptr [rsi+16],1
  je mc2
  mov rdx,[rsi+8]
  test rdx,rdx
  jz mc2
  mov rax,[rsi]
  add rdx,rax
  and rax,-4096
  add rdx,4095
  and rdx,-4096
  call rsub
mc2:
  add rsi,24
  dec r8d
  jmp mc1
mc9:
  mov ecx,[rngn]
  cmp ecx,2
  jb ms9
  mov esi,RNG
  mov ebx,1
ms1:
  mov eax,ebx
  shl eax,4
  mov rdx,[rsi+rax]
  mov r11,[rsi+rax+8]
  mov r8d,ebx
ms2:
  test r8d,r8d
  jz ms3
  lea r9d,[r8-1]
  shl r9d,4
  mov r10,[rsi+r9]
  cmp r10,rdx
  jbe ms3
  mov r12,[rsi+r9+8]
  mov r13d,r8d
  shl r13d,4
  mov [rsi+r13],r10
  mov [rsi+r13+8],r12
  dec r8d
  jmp ms2
ms3:
  mov r13d,r8d
  shl r13d,4
  mov [rsi+r13],rdx
  mov [rsi+r13+8],r11
  inc ebx
  cmp ebx,[rngn]
  jb ms1
ms9:
  mov ecx,[rngn]
  test ecx,ecx
  jz mm9
  mov esi,RNG
  xor r8d,r8d
  mov r10,[rsi]
  mov r11,[rsi+8]
  mov r9d,1
mg1:
  cmp r9d,ecx
  jae mg2
  mov eax,r9d
  shl eax,4
  mov rdx,[rsi+rax]
  mov r12,[rsi+rax+8]
  cmp rdx,r11
  ja mg3
  cmp r12,r11
  jbe mg4
  mov r11,r12
mg4:
  inc r9d
  jmp mg1
mg3:
  mov eax,r8d
  shl eax,4
  mov [rsi+rax],r10
  mov [rsi+rax+8],r11
  inc r8d
  mov r10,rdx
  mov r11,r12
  inc r9d
  jmp mg1
mg2:
  mov eax,r8d
  shl eax,4
  mov [rsi+rax],r10
  mov [rsi+rax+8],r11
  inc r8d
  mov [rngn],r8d
mm9:
  mov r8d,[BOOT_E820_COUNT]
  mov esi,BOOT_E820_MAP
  xor r10d,r10d
mt1:
  test r8d,r8d
  jz mt9
  mov eax,[rsi+16]
  cmp eax,1
  je mt2
  cmp eax,3
  je mt2
  cmp eax,4
  jne mt3
mt2:
  mov rax,[rsi]
  add rax,[rsi+8]
  cmp rax,r10
  jbe mt3
  mov r10,rax
mt3:
  add rsi,24
  dec r8d
  jmp mt1
mt9:
  mov rax,100000000h
  cmp r10,rax
  jae mt4
  mov r10,rax
mt4:
  mov rax,40000000000h
  cmp r10,rax
  jbe mt5
  mov r10,rax
mt5:
  add r10,3FFFFFFFh
  and r10,-40000000h
  mov [ptop],r10
  mov r11,r10
  shr r11,30
  mov rax,r11
  sub rax,4
  lea rcx,[r11-1]
  shr rcx,9
  add rax,rcx
  add rax,16
  shl rax,12
  add rax,POOL
  mov [poolend],rax
  mov qword ptr [poolnext],POOL
  mov rdx,rax
  mov eax,100000h
  call rcontain
  jnz fatalmem
  mov r8d,4
mp1:
  cmp r8,r11
  jae mp9
  mov eax,r8d
  shr eax,9
  mov edx,BOOT_PML4
  lea rdx,[rdx+rax*8]
  mov rcx,[rdx]
  test cl,1
  jnz mp2
  call poolpage
  mov rcx,rax
  or rcx,3
  mov [rdx],rcx
mp2:
  and rcx,-4096
  mov eax,r8d
  and eax,511
  lea rbx,[rcx+rax*8]
  call poolpage
  mov rdi,rax
  mov rcx,rax
  or rcx,3
  mov [rbx],rcx
  mov rax,r8
  shl rax,30
  or rax,83h
  mov ecx,512
mp3:
  mov [rdi],rax
  add rdi,8
  add rax,200000h
  dec ecx
  jnz mp3
  inc r8d
  jmp mp1
mp9:
  mov rax,cr3
  mov cr3,rax
  mov rax,[poolend]
  mov [stkbase],rax
  ret
