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

4. Insert the SD in the raspberry and run it.

5. Secure the sshd

```sh
/boot/scripts/services/sshd/setup
```

6. Verify that firewall is enabled.

```sh
sudo ufw status
```

7. Optional: Set the external drive

```sh
sudo nano /etc/fstab
```

And add the following line

```
# External hard-drive
LABEL=HDD             /mnt/HDD        ext4     rw,relatime      0       1
```
