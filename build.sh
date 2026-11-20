#!/bin/sh
set -eu

ROOT=$(cd "$(dirname "$0")" && pwd)
SRC=$ROOT/src
BUILD=$ROOT/build
IMAGE=$BUILD/os.img
LAYOUT=$SRC/common/layout.inc

UASM=${UASM:-uasm}
QEMU=${QEMU:-qemu-system-x86_64}
SMP=${SMP:-4}
MEM=${MEM:-512}

SECTOR_SIZE=512
IMAGE_SIZE_MB=64

die() {
  echo "error: $*" >&2
  exit 1
}

usage() {
  echo "usage: $0 [build|run|nogui|clean]" >&2
  exit 2
}

layout_value() {
  value=$(awk -v key="$1" '$1 == key && $2 == "equ" { print $3 }' "$LAYOUT")
  [ -n "$value" ] || die "$1 is not defined in $LAYOUT"
  echo "$value"
}

file_size() {
  wc -c < "$1" | tr -d ' '
}

require_tool() {
  command -v "$1" > /dev/null 2>&1 || die "$1 not found"
}

assemble() {
  name=$1
  "$UASM" -bin -I"$SRC" -Fo "$BUILD/$name.bin" "$SRC/${2}"
  [ -f "$BUILD/$name.bin" ] || die "$name.bin was not produced"
}

check_size() {
  name=$1
  limit=$2
  exact=${3:-}
  size=$(file_size "$BUILD/$name.bin")
  if [ -n "$exact" ]; then
    [ "$size" -eq "$limit" ] || die "$name.bin is $size bytes, expected exactly $limit"
  else
    [ "$size" -le "$limit" ] || die "$name.bin is $size bytes, limit is $limit"
  fi
}

place() {
  dd if="$BUILD/$1.bin" of="$IMAGE" bs="$SECTOR_SIZE" seek="$2" conv=notrunc 2> /dev/null
}

build() {
  require_tool "$UASM"
  kernel_lba=$(layout_value KERNEL_LBA)
  kernel_sectors=$(layout_value KERNEL_SECTORS)
  ap_lba=$(layout_value AP_LBA)

  mkdir -p "$BUILD"
  assemble boot boot/boot.asm
  assemble ap boot/ap.asm
  assemble kernel kernel/kernel.asm

  check_size boot "$SECTOR_SIZE" exact
  check_size ap "$SECTOR_SIZE"
  check_size kernel $((kernel_sectors * SECTOR_SIZE))

  dd if=/dev/zero of="$IMAGE" bs=1M count="$IMAGE_SIZE_MB" 2> /dev/null
  place boot 0
  place kernel "$kernel_lba"
  place ap "$ap_lba"
}

run() {
  require_tool "$QEMU"
  if [ "${1:-}" = nogui ]; then
    exec "$QEMU" -machine pc -smp "$SMP" -m "$MEM" -drive "file=$IMAGE,format=raw" -display none -monitor stdio
  fi
  exec "$QEMU" -machine pc -smp "$SMP" -m "$MEM" -drive "file=$IMAGE,format=raw"
}

case "${1:-run}" in
  build)
    build
    ;;
  run)
    build
    run gui
    ;;
  nogui)
    build
    run nogui
    ;;
  clean)
    rm -rf "$BUILD"
    ;;
  *)
    usage
    ;;
esac
