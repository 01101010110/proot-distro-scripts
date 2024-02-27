#!/bin/bash

# Set Username
read -r -p "Select a username: " username </dev/tty

# Set Password
read -r -s -p "Enter password for $username: " password </dev/tty
echo # move to a new line

# Ask user for their timezone
echo "Please enter your geographical area (e.g., Europe, America, Asia):"
read AREA
echo "Please enter your city or closest major city (e.g., Berlin, New_York, Tokyo):"
read CITY

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
proot-distro login ubuntu --shared-tmp -- env DISPLAY=:1 export DEBIAN_FRONTEND=noninteractive

# Enters user's selections to bypass manual entry
proot-distro login ubuntu --shared-tmp -- env DISPLAY=:1 echo "tzdata tzdata/Areas select $AREA" | debconf-set-selections
proot-distro login ubuntu --shared-tmp -- env DISPLAY=:1 echo "tzdata tzdata/Zones/$AREA select $CITY" | debconf-set-selections

# Install xRDP
proot-distro login ubuntu --shared-tmp -- env DISPLAY=:1 apt install xrdp -y

# Configure xRDP
proot-distro login ubuntu --shared-tmp -- env DISPLAY=:1 echo "xfce4-session" > /home/$username/.xsession

# Modify the xRDP start script
proot-distro login ubuntu --shared-tmp -- env DISPLAY=:1 sed -i 's|test -x /etc/X11/Xsession && exec /etc/X11/Xsession|exec startxfce4|' /etc/xrdp/startwm.sh
proot-distro login ubuntu --shared-tmp -- env DISPLAY=:1 sed -i '/exec \/bin\/sh \/etc\/X11\/Xsession/d' /etc/xrdp/startwm.sh

# Stop xRDP service
proot-distro login ubuntu --shared-tmp -- env DISPLAY=:1 service xrdp stop
proot-distro login ubuntu --shared-tmp -- env DISPLAY=:1 service xrdp start
