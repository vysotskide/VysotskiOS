madt:
  mov ecx,[rsi+4]
  lea rdi,[rsi+44]
  add rsi,rcx
mdl:
  cmp rdi,rsi
  jae mdx
  movzx eax,byte ptr [rdi]
  movzx r8d,byte ptr [rdi+1]
  cmp r8d,2
  jb mdx
  test eax,eax
  jnz md9
  test byte ptr [rdi+4],3
  jz mdn
  movzx eax,byte ptr [rdi+3]
  call addcpu
  jmp mdn
md9:
  cmp eax,9
  jne mdn
  test byte ptr [rdi+8],3
  jz mdn
  mov eax,[rdi+4]
  cmp eax,0FFh
  jb mdy
  mov byte ptr [needx2],1
mdy:
  call addcpu
mdn:
  add rdi,r8
  jmp mdl
mdx:
  ret

addcpu:
  mov ecx,[ncpu]
  cmp ecx,MAXCPU
  jae adcdone
  mov edx,AIDS
  xor r9d,r9d
adc1:
  cmp r9d,ecx
  jae adc2
  cmp [rdx+r9*4],eax
  je adcdone
  inc r9d
  jmp adc1
adc2:
  mov [rdx+rcx*4],eax
  inc dword ptr [ncpu]
adcdone:
  ret
