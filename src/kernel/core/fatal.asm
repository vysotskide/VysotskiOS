fatalmem:
  lea rsi,[mnomem]
  call puts
fm0:
  cli
  hlt
  jmp fm0
