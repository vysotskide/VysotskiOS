cmds:
  db "ls",6 dup(0)
  dq c_ls
  db "new",5 dup(0)
  dq c_new
  db "put",5 dup(0)
  dq c_put
  db "add",5 dup(0)
  dq c_add
  db "get",5 dup(0)
  dq c_get
  db "rm",6 dup(0)
  dq c_rm
  db "mem",5 dup(0)
  dq c_mem
  db "save",4 dup(0)
  dq c_save
  db "off",5 dup(0)
  dq c_off
  db "info",4 dup(0)
  dq c_info
  db "ps",6 dup(0)
  dq c_ps
  db "run",5 dup(0)
  dq c_run
  db "cpus",4 dup(0)
  dq c_cpus
  db "bench",3 dup(0)
  dq c_bench
  db "cls",5 dup(0)
  dq c_cls
  db "reboot",2 dup(0)
  dq c_reboot
  dq 0,0
