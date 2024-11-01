#!/bin/sh

set -e

BOARD_DIR=$(dirname "$0")

# Detected boot strategy is BIOS
    cp -f "$BOARD_DIR/grub-bios.cfg" "$TARGET_DIR/boot/grub/grub.cfg"
    # Copy grub 1st stage to binaries, required for genimage
    cp -f "$TARGET_DIR/lib/grub/i386-pc/boot.img" "$BINARIES_DIR"

# if I set BR2_TARGET_GRUB2_BUILTIN_CONFIG_PC="/mnt/ramdisk/my_external_tree/board/my_company/my_board/grub-bios.cfg"
# in
# pc_x86_bios_defconfig
# I get error while loading grub2:
# no menuentry definition.
