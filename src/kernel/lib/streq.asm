streq:
sql:
  lodsb
  mov ah,[rdi]
  inc rdi
  cmp al,ah
  jne sqr
  test al,al
  jnz sql
sqr:
  ret
