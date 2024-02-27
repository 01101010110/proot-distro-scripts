#!/bin/bash

# Set Username
read -r -p "Select a username: " username </dev/tty

# Set Password
read -r -s -p "Enter password for $username: " password </dev/tty
echo # move to a new line

# Avoids a repo bug
termux-change-repo

# Update and install required packages
yes | pkg install x11-repo
yes | pkg update
yes | pkg uninstall dbus
yes | pkg install proot-distro
yes | proot-distro install ubuntu
yes | pkg install wget dbus pulseaudio virglrenderer-android
yes | pkg install firefox xfce4 

# Setup proot
yes | proot-distro login ubuntu --shared-tmp -- env DISPLAY=:1 apt update
yes | proot-distro login ubuntu --shared-tmp -- env DISPLAY=:1 apt upgrade
yes | proot-distro login ubuntu --shared-tmp -- env DISPLAY=:1 apt install sudo

# Create user
proot-distro login ubuntu --shared-tmp -- env DISPLAY=:1 groupadd storage
proot-distro login ubuntu --shared-tmp -- env DISPLAY=:1 groupadd wheel
proot-distro login ubuntu --shared-tmp -- env DISPLAY=:1 useradd -m -g users -G wheel,audio,video,storage -s /bin/bash "$username"

# Set user password
echo "$username:$password" | proot-distro login ubuntu --shared-tmp -- chpasswd

# Add user to sudoers
chmod u+rw $HOME/../usr/var/lib/proot-distro/installed-rootfs/ubuntu/etc/sudoers
echo "$username ALL=(ALL) ALL" | tee -a $HOME/../usr/var/lib/proot-distro/installed-rootfs/ubuntu/etc/sudoers > /dev/null
chmod u-w $HOME/../usr/var/lib/proot-distro/installed-rootfs/ubuntu/etc/sudoers

# Enable Sound
echo "
pulseaudio --start --exit-idle-time=-1
pacmd load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1
" > $HOME/.sound

echo "
source .sound" >> .bashrc

# Enable PulseAudio over Network
pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1

# Ensure non-interactive frontend for apt-get
export DEBIAN_FRONTEND=noninteractive

# Preconfigure tzdata
proot-distro login ubuntu --shared-tmp -- env DISPLAY=:1 /bin/bash -c "
echo 'Etc/UTC' > /etc/timezone
ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime
apt-get update
apt-get install -y tzdata
dpkg-reconfigure --frontend noninteractive tzdata
"

# Install xrdp
yes | proot-distro login ubuntu --shared-tmp -- env DISPLAY=:1 sudo apt install xrdp

# Configure xRDP
proot-distro login ubuntu --shared-tmp -- env DISPLAY=:1 echo "xfce4-session" > /home/$USERNAME/.xsession

# Stop xRDP service
proot-distro login ubuntu --shared-tmp -- env DISPLAY=:1 service xrdp stop
proot-distro login ubuntu --shared-tmp -- env DISPLAY=:1 service xrdp start
