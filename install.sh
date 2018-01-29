#!/bin/bash
set -e
BOOT_DIR=${1}
if [ -f "${BOOT_DIR}/.bootdir" ]; then
	cd ${BOOT_DIR}
else
	echo "touch ${BOOT_DIR}/.bootdir"
	echo "If you think is right directory"
	exit 1
fi

MEMTEST86_VERSION=5.01
SYSLINUX_VERSION=5.10

### Symlinks
if [ ! -e menu.ipxe ]; then
	ln -s ../menu.ipxe menu.ipxe
fi

if [ ! -e chip-undionly.ipxe ]; then
	ln -s ../menu.ipxe chip-undionly.ipxe
fi

### Memtest 86+
if [ ! -f "memtest86+-${MEMTEST86_VERSION}.iso.zip" ]; then
	wget http://www.memtest.org/download/${MEMTEST86_VERSION}/memtest86+-${MEMTEST86_VERSION}.iso.zip
fi

if [ ! -f "memtest86plus-${MEMTEST86_VERSION}.iso" ]; then
	unzip "memtest86+-${MEMTEST86_VERSION}.iso.zip"
	mv "memtest86+-${MEMTEST86_VERSION}.iso" "memtest86plus-${MEMTEST86_VERSION}.iso"
fi

### Syslinux
if [ ! -f "syslinux-${SYSLINUX_VERSION}.zip" ]; then
	wget https://www.kernel.org/pub/linux/utils/boot/syslinux/syslinux-${SYSLINUX_VERSION}.zip
	if [ ! -f "memdisk/memdisk" ]; then
		rm memdisk/memdisk
	fi
fi

if [ ! -f "memdisk/memdisk" ]; then
	unzip syslinux-${SYSLINUX_VERSION}.zip memdisk/memdisk
fi
