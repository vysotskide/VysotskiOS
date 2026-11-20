bar:
  push rax
  push rcx
  push rdx
  push rsi
  push rdi
  mov eax,dword ptr gs:[8]
  and eax,7
  lea eax,[rax+rax*4]
  mov edi,0B8000h
  lea rdi,[rdi+rax*2]
  lea rsi,[hexd]
  mov ecx,4
bb1:
  rol dx,4
  movzx eax,dl
  and eax,15
  mov al,[rsi+rax]
  mov ah,70h
  mov [rdi],ax
  add rdi,2
  loop bb1
  pop rdi
  pop rsi
  pop rdx
  pop rcx
  pop rax
  ret
