#!/bin/bash
set -e

for dist in bionic; do
	for arch in amd64 i386; do
		BASE_INSTALL="ubuntu-$dist-server-$arch"
		DEST_INSTALL="$BASE_INSTALL/install/netboot/"
		NETBOOT_INSTALLER="$DEST_INSTALL/netboot.tar.gz"
		NETBOOT_SRC="http://archive.ubuntu.com/ubuntu/dists/$dist-updates/main/installer-$arch/current/images/netboot/netboot.tar.gz"
		NETBOOT_INFO="$DEST_INSTALL/version.info"
		if [ ! -d $BASE_INSTALL ]; then
			mkdir -p $DEST_INSTALL
		fi
		if [ ! -f $NETBOOT_INSTALLER ]; then
			wget -O $NETBOOT_INSTALLER $NETBOOT_SRC
		fi
		if [ ! -f $NETBOOT_INFO ]; then
			tar xvzf $NETBOOT_INSTALLER -C $DEST_INSTALL
		fi
	done
done
