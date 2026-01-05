How to build Linux image for x86 grub with f2fs filesystem
## Features
f2fs is enabled in Linux kernel. f2fs is enabled in GNU GRUB (BR2_TARGET_GRUB2_BUILTIN_MODULES_PC now contains f2fs). grub's timeout is 0 so you willn't see [him](https://upload.wikimedia.org/wikipedia/commons/thumb/8/81/Grub_logo_large.png/240px-Grub_logo_large.png).

## Clone
```
git clone --remote-submodules --recurse-submodules -j8 https://github.com/AndreiCherniaev/buildroot_BIOS_f2fs_x86.git
cd buildroot_BIOS_f2fs_x86
```
## Make image
```
make clean -C buildroot
make BR2_EXTERNAL=$PWD/my_external_tree -C $PWD/buildroot f2fs_qemu_x86_defconfig
make -C buildroot
```
## Save non-default buildroot .config
To save non-default buildroot's buildroot/.config to $PWD/my_external_tree/configs/f2fs_qemu_x86_defconfig
```
make -C $PWD/buildroot savedefconfig BR2_DEFCONFIG=$PWD/my_external_tree/configs/f2fs_qemu_x86_defconfig
```
## Tune and rebuild Kernel
Tune Linux kernel
```
make linux-menuconfig -C buildroot
```
## Save non-default Linux .config
In case of Buildroot to save non-default Linux's .config to my_external_tree/board/my_company/my_board/linux_f2fs.config
```
make -C $PWD/buildroot/ linux-update-defconfig BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE=$PWD/my_external_tree/board/my_company/my_board/linux_f2fs.config
```
## Rebuild kernel
```
make linux-dirclean -C buildroot && make linux-rebuild -C buildroot && make -C buildroot
```
## Start in QEMU
This code is based on emulation [script1](https://github.com/buildroot/buildroot/blob/02540771bccf7b10c7daecce5f0e1e41a73c1e07/boot/grub2/readme.txt#L4) and [script2](https://github.com/buildroot/buildroot/blob/9e3d572ff532df945fbc282fed22d10098e5718b/board/pc/readme.txt). To booting in BIOS mode, run the emulation with:
```
qemu-system-i386 -M pc -drive file=../Buildroot.img,if=virtio,format=raw -net nic,model=virtio -net user
```
Note: image file `Buildroot.img` is located outside of repo folder so we use `../`. Optionally add `-nographic` to see output not in extra screen but in console terminal. Or `-display curses` to pseudographic.

## Problems
In BIOS terminal `ls` gives empty result. After `insmod f2fs` same situation. To fix it, f2fs and biosdisk grub2 modules should be used together.
