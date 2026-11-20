oa_lvl:
  test eax,eax
  jz ol0
  cmp eax,1
  jbe ol1
  cmp eax,512
  jbe ol2
  mov eax,3
  ret
ol2:
  mov eax,2
  ret
ol1:
  mov eax,1
ol0:
  ret
