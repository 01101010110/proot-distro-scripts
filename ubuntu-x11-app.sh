#!/bin/bash

# Set Username
read -r -p "Select a username: " username </dev/tty

# Set Password
read -r -s -p "Enter password for $username: " password </dev/tty
echo # move to a new line

# To avoid a repo bug
termux-change-repo

# Install the x11-repo and update all packages
yes | pkg install x11-repo
yes | pkg update

# Grant storage access - (cannot be ran prior to installing x11-repo)
termux-setup-storage

# Install hardware acceleration, proot-distro, sound, and firefox
pkg install dbus proot-distro pulseaudio virglrenderer-android -y
pkg install pavucontrol-qt firefox -y

# Install ubuntu in proot-distro
yes | proot-distro install ubuntu

# Update proot-distro
yes | proot-distro login ubuntu --shared-tmp -- env DISPLAY=:1 apt update
yes | proot-distro login ubuntu --shared-tmp -- env DISPLAY=:1 apt upgrade

# Set timezone to phone / tablet's tz
timezone=$(getprop persist.sys.timezone); proot-distro login ubuntu --shared-tmp -- env DISPLAY=:1.0 rm /etc/localtime; proot-distro login ubuntu --shared-tmp -- env DISPLAY=:1.0 cp /usr/share/zoneinfo/$timezone /etc/localtime

#Install proot-distro packages (sudo, gui, terminal)
proot-distro login ubuntu --shared-tmp -- env DISPLAY=:1 apt install sudo xfce4 xfce4-terminal dbus-x11 -y

# Removes glitchy xterminal
proot-distro login ubuntu --shared-tmp -- env DISPLAY=:1 apt remove xterm -y

# Set xfce4-terminal as the default terminal
proot-distro login ubuntu --shared-tmp -- env DISPLAY=:1 update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/xfce4-terminal 50
proot-distro login ubuntu --shared-tmp -- env DISPLAY=:1 update-alternatives --set x-terminal-emulator /usr/bin/xfce4-terminal

# Removes ubuntu Sensible Web Browser
proot-distro login ubuntu --shared-tmp -- env DISPLAY=:1 apt remove sensible-utils -y

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

# Setup termux to allow x11 app
yes | pkg install termux-x11-nightly
echo "allow-external-apps = true" >> ~/.termux/termux.properties

# Kill open X11 processes
kill -9 $(pgrep -f "termux.x11") 2>/dev/null

# Enable PulseAudio over Network
pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1

# Prepare termux-x11 session
export XDG_RUNTIME_DIR=${TMPDIR}

# Set Display to :1 since Ubuntu runs on :0
termux-x11 :1 >/dev/null &

# Wait a bit until termux-x11 gets started.
sleep 3

# Launch Termux X11 main activity
am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity > /dev/null 2>&1
sleep 1

# Set an alias in Termux to login to proot-distro easier
echo "alias ubuntu='am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity > /dev/null 2>&1 && sleep 1 && GALLIUM_DRIVER=virpipe MESA_GL_VERSION_OVERRIDE=4.0 proot-distro login ubuntu --shared-tmp -- /bin/bash -c \"export PULSE_SERVER=127.0.0.1 && export XDG_RUNTIME_DIR=\\\\\${TMPDIR} && su - $username -c \\\"sh -c \\\\\\\"termux-x11 :1 -xstartup \\\\\\\\\\\\\\\"dbus-launch --exit-with-session xfce4-session\\\\\\\\\\\\\\\" && env DISPLAY=:1 startxfce4\\\\\\\"\\\"\"'" >> $HOME/.bashrc
source ~/.bashrc

# Login to Environment
GALLIUM_DRIVER=virpipe MESA_GL_VERSION_OVERRIDE=4.0 proot-distro login ubuntu --shared-tmp -- /bin/bash -c "export PULSE_SERVER=127.0.0.1 && export XDG_RUNTIME_DIR=\${TMPDIR} && su - $username -c \"termux-x11 :1 -xstartup \\\"dbus-launch --exit-with-session xfce4-session\\\" && env DISPLAY=:1 startxfce4\""

exit 0
