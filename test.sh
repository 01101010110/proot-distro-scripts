#!/bin/bash

# Set Username
read -r -p "Select a username: " username </dev/tty

termux-setup-storage
termux-change-repo

# Update and install required packages
yes | pkg install x11-repo
yes | pkg update
yes | pkg uninstall dbus
yes | pkg install wget dbus proot-distro pulseaudio virglrenderer-android
yes | pkg install pavucontrol-qt firefox xwayland xfce4
yes | proot-distro install debian

# Setup proot
yes | proot-distro login debian --shared-tmp -- env DISPLAY=:1 apt update
yes | proot-distro login debian --shared-tmp -- env DISPLAY=:1.0 apt upgrade

# Create user
proot-distro login debian --shared-tmp -- env DISPLAY=:1 groupadd storage
proot-distro login debian --shared-tmp -- env DISPLAY=:1 groupadd wheel
proot-distro login debian --shared-tmp -- env DISPLAY=:1 useradd -m -g users -G wheel,audio,video,storage -s /bin/bash "$username"

# Add user to sudoers
chmod u+rw $HOME/../usr/var/lib/proot-distro/installed-rootfs/debian/etc/sudoers
echo "$username ALL=(ALL) NOPASSWD:ALL" | tee -a $HOME/../usr/var/lib/proot-distro/installed-rootfs/debian/etc/sudoers > /dev/null
chmod u-w $HOME/../usr/var/lib/proot-distro/installed-rootfs/debian/etc/sudoers

# Enable Sound
echo "
pulseaudio --start --exit-idle-time=-1
pacmd load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1
" > $HOME/.sound

echo "
source .sound" >> .bashrc

# Put Firefox icon on Desktop
cp $HOME/../usr/share/applications/firefox.desktop $HOME/Desktop 
chmod +x $HOME/Desktop/firefox.desktop

# Kill open X11 processes
kill -9 $(pgrep -f "termux.x11") 2>/dev/null

# Setup x11 app
wget https://github.com/01101010110/proot-distro-scripts/raw/main/termux-x11.deb
dpkg -i --force-depends termux-x11.deb
echo "allow-external-apps = true" >> ~/.termux/termux.properties

# Launch Termux X11 main activity
am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity > /dev/null 2>&1
sleep 1

proot-distro login debian --shared-tmp -- /bin/bash -c  'export PULSE_SERVER=127.0.0.1 && export XDG_RUNTIME_DIR=${TMPDIR} && -c "env DISPLAY=:0 startxfce4"'

