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
echo "allow-external-apps = true" >> ~/.termux/termux.properties

# Kill open X11 processes
kill -9 $(pgrep -f "termux.x11") 2>/dev/null

# Enable PulseAudio over Network
pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1

# Prepare termux-x11 session
export XDG_RUNTIME_DIR=${TMPDIR}
termux-x11 :3 >/dev/null &

# Wait a bit until termux-x11 gets started.
sleep 3

# Launch Termux X11 main activity
am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity > /dev/null 2>&1
sleep 1

# Set an alias in Termux to login to proot-distro easier
echo "alias termux='am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity > /dev/null 2>&1 && sleep 1 && -- /bin/bash -c \"export PULSE_SERVER=127.0.0.1 && export XDG_RUNTIME_DIR=\\\\\${TMPDIR} && -c \\\"sh -c \\\\\\\"termux-x11 :3 -xstartup \\\\\\\\\\\\\\\"dbus-launch --exit-with-session xfce4-session\\\\\\\\\\\\\\\" && startxfce4\\\\\\\"\\\"\"'" >> $HOME/.bashrc
source ~/.bashrc

# Login to Environment
-- /bin/bash -c "export PULSE_SERVER=127.0.0.1 && export XDG_RUNTIME_DIR=\${TMPDIR} && -c \"termux-x11 :3 -xstartup \\\"dbus-launch --exit-with-session xfce4-session\\\" && startxfce4\""

exit 0
