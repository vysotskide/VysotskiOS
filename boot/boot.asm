.586p
include common/layout.inc

_TEXT segment use16
assume ds:_TEXT
org BOOT_SECTOR
start:
include boot/sector/entry.asm
include boot/sector/a20.asm
include boot/sector/disk_load.asm
include boot/sector/e820.asm
include boot/sector/e801.asm
include boot/sector/paging.asm
include boot/sector/long_mode.asm
include boot/sector/disk_packets.asm
include boot/sector/gdt.asm
include boot/sector/signature.asm
_TEXT ends
end
