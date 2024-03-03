#!/bin/bash

# To avoid a repo bug
termux-change-repo

# Install the x11-repo and update all packages
yes | pkg install x11-repo
yes | pkg update

# Grant storage access - (cannot be ran prior to installing x11-repo)
termux-setup-storage

# Install hardware acceleration, xfce4 gui, sound, and firefox
pkg install dbus pulseaudio virglrenderer-android -y
pkg install pavucontrol-qt firefox xfce4 -y

# Enable Sound
echo "
pulseaudio --start --exit-idle-time=-1
pacmd load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1
" > $HOME/.sound

echo "
source .sound" >> .bashrc

# Setup termux to allow x11 app
pkg install termux-x11-nightly -y
sleep 3
echo "allow-external-apps = true" >> ~/.termux/termux.properties 

# Enable PulseAudio over Network
pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1

# Prepare termux-x11 session
export XDG_RUNTIME_DIR=${TMPDIR}

# Set Display to :2 since Ubuntu runs on :0 and Debian runs on :1
termux-x11 :2 >/dev/null &

# Wait a bit until termux-x11 gets started.
sleep 3

# Set an alias to load termux environment faster
echo 'alias termux="am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity >/dev/null 2>&1 && sleep 1 && termux-x11 :3 -xstartup '\''dbus-launch --exit-with-session xfce4-session'\'' && startxfce4"' >> $HOME/.bashrc
source ~/.bashrc

# Login to Environment
am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity > /dev/null 2>&1 && sleep 1 && termux-x11 :3 -xstartup "dbus-launch --exit-with-session xfce4-session" && startxfce4

exit 0
