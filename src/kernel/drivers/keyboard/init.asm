kbinit:
  mov ecx,10000h
kb1:
  in al,64h
  test al,2
  jz kb2
  dec ecx
  jnz kb1
kb2:
  mov al,0AEh
  out 64h,al
  mov ecx,16
kb3:
  in al,64h
  test al,1
  jz kb4
  in al,60h
  dec ecx
  jnz kb3
kb4:
  ret
