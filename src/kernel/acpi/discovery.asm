acpi:
  mov esi,40Eh
  movzx esi,word ptr [rsi]
  shl esi,4
  jz acp1
  mov ecx,64
  call rsdscan
  test esi,esi
  jnz acpf
acp1:
  mov esi,0E0000h
  mov ecx,8192
  call rsdscan
  test esi,esi
  jz acpx
acpf:
  movzx eax,byte ptr [rsi+15]
  mov r15d,4
  cmp eax,2
  jb acp_r
  mov rax,[rsi+24]
  test rax,rax
  jz acp_r
  cmp rax,[ptop]
  jae acp_r
  mov r15d,8
  jmp acp_t
acp_r:
  mov r15d,4
  mov eax,[rsi+16]
acp_t:
  mov r12,rax
  call tblok
  jnz acpx
  mov r13d,[r12+4]
  sub r13d,36
  jbe acpx
  cmp r15d,8
  jne acp_d4
  shr r13d,3
  jmp acp_d
acp_d4:
  shr r13d,2
acp_d:
  lea r14,[r12+36]
acp_l:
  test r13d,r13d
  jz acpd
  cmp r15d,8
  je acp_e8
  mov eax,[r14]
  jmp acp_e
acp_e8:
  mov rax,[r14]
acp_e:
  cmp rax,[ptop]
  jae acp_n
  call tblok
  jnz acp_n
  mov edx,[rax]
  cmp edx,43495041h
  jne acp_a
  mov rsi,rax
  call madt
  jmp acp_n
acp_a:
  cmp edx,50434146h
  jne acp_b
  mov rsi,rax
  call fadt
  jmp acp_n
acp_b:
  cmp edx,54445353h
  jne acp_n
  mov ecx,[nssdt]
  cmp ecx,64
  jae acp_n
  lea rdx,[ssdtl]
  mov [rdx+rcx*8],rax
  inc dword ptr [nssdt]
acp_n:
  add r14,r15
  dec r13d
  jmp acp_l
acpd:
  call s5find
acpx:
  ret
