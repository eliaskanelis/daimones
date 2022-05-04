# Daimones

## Description

> Server on a raspberry pi.

## Instructions

1. Download [Raspberry Pi OS 64bit](https://www.raspberrypi.com/software/operating-systems/#raspberry-pi-os-64-bit)
unzip it and flash it to an SD card.

```sh
writeSDcard <image.img>
```

2. Make sure the boot and rootfs partitions are mounted.

3. Run the script

```sh
./raspberrypi/headless/install
```

4. Answer all question the script will as you.





------------------------------------------------------

Linux kentavros 5.15.32-v7+ #1538 SMP Thu Mar 31 19:38:48 BST 2022 armv7l GNU/Linu

/etc/fstab

# External hard-drive
LABEL=HDD             /mnt/HDD        ext4     rw,relatime      0       1


2. Get inside the boot partition of the SD card

```sh
cd /media/${USER}/boot
```
