#!/bin/bash

# Set Username
read -r -p "Select a username: " username </dev/tty

termux-setup-storage
termux-change-repo

# Update and install required packages
yes | pkg install x11-repo
yes | pkg update
yes | pkg uninstall dbus
yes | pkg install wget dbus proot-distro pulseaudio git virglrenderer-android xfce4 xfce4-goodies pavucontrol-qt jq nala wmctrl firefox 
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

# Set proot DISPLAY
echo "export DISPLAY=:1" >> $HOME/../usr/var/lib/proot-distro/installed-rootfs/debian/home/$username/.bashrc

# Set proot aliases
echo "
alias virgl='GALLIUM_DRIVER=virpipe '
alias apt='sudo nala '
" >> $HOME/../usr/var/lib/proot-distro/installed-rootfs/debian/home/$username/.bashrc

# Create .bashrc
cp $HOME/../usr/var/lib/proot-distro/installed-rootfs/debian/etc/skel/.bashrc $HOME/.bashrc

# Set Termux aliases
echo "
alias debian='termux-x11 :1 && proot-distro login debian --shared-tmp && export DISPLAY=:1'
alias apt='pkg upgrade -y && nala \$@'
" >> $HOME/.bashrc

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

# Setup x11 app
wget https://github.com/01101010110/proot-distro-scripts/raw/main/termux-x11.deb
dpkg -i termux-x11.deb
echo "allow-external-apps = true" >> ~/.termux/termux.properties

# Apply changes
source ~/.bashrc

debian
