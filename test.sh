#!/bin/bash

# Set non-interactive frontend
export DEBIAN_FRONTEND=noninteractive

# Set Username
read -r -p "Select a username: " username </dev/tty

# Set Password
read -r -s -p "Enter password for $username: " password </dev/tty
echo # move to a new line

# Set timezone
echo "Please enter your geographical area (e.g., Europe, America, Asia):"
read AREA
echo "Please enter your city or closest major city (e.g., Berlin, New_York, Tokyo):"
read CITY
echo "tzdata tzdata/Areas select $AREA" | debconf-set-selections
echo "tzdata tzdata/Zones/$AREA select $CITY" | debconf-set-selections

termux-change-repo

# Update and install required packages
yes | pkg install x11-repo
yes | pkg update
yes | pkg uninstall dbus
yes | pkg install wget dbus proot-distro pulseaudio virglrenderer-android
yes | pkg install pavucontrol-qt firefox xfce4
yes | proot-distro install ubuntu

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
sed -i "/^root ALL=(ALL:ALL) ALL/a$username ALL=(ALL) NOPASSWD:ALL" $HOME/../usr/var/lib/proot-distro/installed-rootfs/ubuntu/etc/sudoers

# Enable Sound
echo "
pulseaudio --start --exit-idle-time=-1
pacmd load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1
" > $HOME/.sound

echo "
source .sound" >> .bashrc

# Setup termux to allow x11 app
yes | pkg install termux-x11-nightly
echo "allow-external-apps = true" >> ~/.termux/termux.properties

# Kill open X11 processes
kill -9 $(pgrep -f "termux.x11") 2>/dev/null

# Enable PulseAudio over Network
pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1

# Prepare termux-x11 session
export XDG_RUNTIME_DIR=${TMPDIR}
termux-x11 :0 >/dev/null &

# Wait a bit until termux-x11 gets started.
sleep 3

# Launch Termux X11 main activity
am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity > /dev/null 2>&1
sleep 1

# Login in to Environment
proot-distro login ubuntu --shared-tmp -- /bin/bash -c  "export PULSE_SERVER=127.0.0.1 && export XDG_RUNTIME_DIR=\${TMPDIR} && su - $username -c \"env DISPLAY=:0 startxfce4\""

exit 0
