.586p
include common/layout.inc

_TEXT segment use16
assume ds:_TEXT
org AP_TRAMPOLINE
include boot/ap/real_mode.asm
include boot/ap/long_mode.asm
include boot/ap/gdt.asm
_TEXT ends
end
