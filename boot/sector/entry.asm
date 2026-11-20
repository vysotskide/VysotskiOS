  cli
  xor ax,ax
  mov ds,ax
  mov es,ax
  mov ss,ax
  mov sp,BOOT_SECTOR
  mov byte ptr ds:[BOOT_DRIVE],dl
