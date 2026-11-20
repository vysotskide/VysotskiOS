split:
spk:
  cmp byte ptr [rsi],20h
  jne spt
  inc rsi
  jmp spk
spt:
  mov rax,rsi
spw:
  mov dl,[rsi]
  cmp dl,20h
  jbe spe
  inc rsi
  jmp spw
spe:
  test dl,dl
  jz spr
  mov byte ptr [rsi],0
  inc rsi
spr:
  ret
