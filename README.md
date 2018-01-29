# Install
```
git clone ... pxe-root
cd pxe-root
export BOOT_URL='http://192.168.1.1/'
sed "s@%BOOT_URL%@${BOOT_URL}@" boot.ipxe.cfg.example > boot.ipxe.cfg
mkdir boot
touch boot/.bootdir
./install.sh boot
```

# Original _INSTALL.md
Add the following chunk to your existing ISC `dhcpd.conf` file.

    if exists user-class and ( option user-class = "iPXE" ) {
        filename "http://boot.smidsrod.lan/boot.ipxe";
    }
    else {
        filename "undionly.kpxe";
    }

(or see https://gist.github.com/4008017 for a more elaborate setup
that chainloads a more featureful version of iPXE from a stripped-down
version burned in ROM)

Put `undionly.kpxe` (or `ipxe.pxe`) at the root of your TFTP server.

Change __boot-url__ (and __sanboot-url__ and other values) in `boot.ipxe.cfg` to match your setup.

Put the following files in your web root:

* boot.ipxe
* boot.ipxe.cfg
* menu.ipxe

Add a folder named `boot` in your web root and put any of these files there:

* hostname-testvm.ipxe
* mac-0050dadd426f.ipxe
* uuid-f84a339b-9e36-456e-8ccf-4c51ea6cb42d.ipxe
* pci-8086100e.ipxe

If you want more features you might want these files in your web root too:

* wimboot
* memdisk
* memtest.0
* memtest86plus-4.20.elf.img
* memtest-report.cgi (if you want a place to send your memtest reports)

UPDATE: See https://gist.github.com/robinsmidsrod/1c7bbd4a058f0e6892df for a better menu item for SystemRescueCD than the one included below.

