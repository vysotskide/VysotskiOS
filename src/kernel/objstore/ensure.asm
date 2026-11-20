oa_ensure:
  push rbx
  push r12
  push r13
  mov r12,rax
  mov rax,[rbp+32]
  cmp r12,rax
  jbe oe_ok
  cmp r12,40000000h
  ja oe_fail
  lea rbx,[rax+4095]
  shr rbx,12
  lea r13,[r12+4095]
  shr r13,12
  mov eax,ebx
  call oa_lvl
  mov r8d,eax
  mov eax,r13d
  call oa_lvl
  mov r9d,eax
  test r8d,r8d
  jz oe_alloc
oe_pr:
  cmp r8d,r9d
  jae oe_alloc
  push r8
  push r9
  call palloc
  pop r9
  pop r8
  test rax,rax
  jz oe_fail
  mov rdx,[rbp+40]
  mov [rax],rdx
  mov [rbp+40],rax
  inc r8d
  jmp oe_pr
oe_alloc:
oe_pl:
  cmp rbx,r13
  jae oe_done
  push r9
  call palloc
  pop r9
  test rax,rax
  jz oe_fail
  mov r10,rax
  mov ecx,r9d
  mov edx,ebx
  push r9
  push r10
  call oa_slot
  pop r10
  pop r9
  test rax,rax
  jz oe_fp
  mov [rax],r10
  lea rax,[rbx+1]
  shl rax,12
  cmp rax,r12
  jbe oe_s
  mov rax,r12
oe_s:
  mov [rbp+32],rax
  inc rbx
  jmp oe_pl
oe_fp:
  mov rax,r10
  call pfree
  jmp oe_fail
oe_done:
  mov [rbp+32],r12
oe_ok:
  clc
  pop r13
  pop r12
  pop rbx
  ret
oe_fail:
  stc
  pop r13
  pop r12
  pop rbx
  ret
