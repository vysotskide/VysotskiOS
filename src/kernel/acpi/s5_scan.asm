s5find:
  mov rsi,[dsdt]
  test rsi,rsi
  jz s5s
  cmp rsi,[ptop]
  jae s5s
  mov rax,rsi
  call tblok
  jnz s5s
  mov ecx,[rsi+4]
  call s5scan
  jnc s5d
s5s:
  xor ebx,ebx
s5l:
  cmp ebx,[nssdt]
  jae s5d
  lea rdx,[ssdtl]
  mov rsi,[rdx+rbx*8]
  mov ecx,[rsi+4]
  call s5scan
  jnc s5d
  inc ebx
  jmp s5l
s5d:
  ret

s5scan:
  cmp ecx,48
  jb s5no
  lea rdi,[rsi+38]
  lea r9,[rsi+rcx-16]
s5q:
  cmp rdi,r9
  jae s5no
  cmp dword ptr [rdi],5F35535Fh
  jne s5n
  cmp byte ptr [rdi-1],08h
  je s5c
  cmp byte ptr [rdi-1],5Ch
  jne s5n
  cmp byte ptr [rdi-2],08h
  jne s5n
s5c:
  cmp byte ptr [rdi+4],12h
  jne s5n
  movzx eax,byte ptr [rdi+5]
  shr eax,6
  inc eax
  lea r10,[rdi+rax+5]
  movzx eax,byte ptr [r10]
  cmp eax,2
  jb s5n
  inc r10
  call aml_int
  jc s5n
  mov r11d,eax
  call aml_int
  jc s5n
  and r11d,7
  and eax,7
  mov [slptypa],r11b
  mov [slptypb],al
  mov byte ptr [s5ok],1
  clc
  ret
s5n:
  inc rdi
  jmp s5q
s5no:
  stc
  ret
