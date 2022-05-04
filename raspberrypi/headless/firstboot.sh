#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Hostname

# Ask for new hostname
hostname="kentavros"

# Change hostname
echo "${hostname}" > /etc/hostname
sed -i "s/raspberrypi/${hostname}/g" /etc/hosts
hostname "${hostname}"

# Trigger mdns
# This will enable <hostname>.local to discovered in the LAN
systemctl restart avahi-daemon

# -----------------------------------------------------------------------------
# User management

# Ask for new username
username="tedi"
usermod -a -G adm,dialout,cdrom,sudo,audio,video,plugdev,games,users,input,netdev,gpio,i2c,spi "${username}"
# passwd -d "${username}"

# Fetch skel
rsync -avr /etc/skel/ /home/"${username}"
chown -R "${username}":"${username}" /home/"${username}"

# Remove pi user
#if id pi &>/dev/null; then
#	pkill -u pi
#	passwd --lock pi
#	deluser --remove-home pi
#fi

# Add new user
#if ! id "${username}" &>/dev/null; then
#	adduser --disabled-password --gecos=",,,," "${username}"
#	passwd -d "${username}"
#	usermod -a -G adm,dialout,cdrom,sudo,audio,video,plugdev,games,users,input,netdev,gpio,i2c,spi "${username}"
#fi

# -----------------------------------------------------------------------------
# Security

# Ssh public key
mkdir -p /home/"${username}"/.ssh/
cp /boot/firstboot/id_rsa_init.pub /home/"${username}"/.ssh/ || exit 1
chown "${username}":"${username}" /home/"${username}"/.ssh/
chmod 700 /home/"${username}"/.ssh/
chown "${username}":"${username}" /home/"${username}"/.ssh/id_rsa_init.pub
chmod 600 /home/"${username}"/.ssh/id_rsa_init.pub

# Create the authorized_keys ssh file
cat /home/"${username}"/.ssh/id_rsa_init.pub > /home/"${username}"/.ssh/authorized_keys
chown "${username}":"${username}" /home/"${username}"/.ssh/authorized_keys
chmod 600 /home/"${username}"/.ssh/authorized_keys

# -----------------------------------------------------------------------------
# Packages

# Update apt cache, ingore "Release file... is not valid yet." error
apt-get update -o Acquire::Check-Valid-Until=false -o Acquire::Check-Date=false

# Install packages
apt-get install -y ufw

# -----------------------------------------------------------------------------
# Firewall

command -v ufw > /dev/null 2>&1 &&
	{
		# Deny everything except ssh
		ufw default deny incoming
		# ufw default deny outgoing
		# ufw allow proto tcp from any to any port 80,443
		ufw allow 22/tcp
		ufw --force enable
	} || exit 1
