#!/bin/bash

# Install xRDP
pkg install xrdp -y
pkg install -y xrdp tigervnc xfce4

# Create VNC startup file
mkdir -p ~/.vnc
echo "startxfce4 &" > ~/.vnc/xstartup
chmod +x ~/.vnc/xstartup

# Configure stopxrdp alias to clean up all processes and locks
sed -i '/alias stopxrdp/d' ~/.bashrc
echo 'alias stopxrdp="pkill -9 xrdp; pkill -9 sesman; pkill -9 Xtightvnc; pkill -9 Xvnc; pkill -9 Xorg; pkill -9 vncserver; rm -f ~/.vnc/*:1.pid /data/data/com.termux/files/usr/tmp/.X1-lock /data/data/com.termux/files/usr/tmp/.X11-unix/X1"' >> ~/.bashrc

# Configure startxrdp alias to clean and launch fresh
sed -i '/alias startxrdp/d' ~/.bashrc
echo 'alias startxrdp="stopxrdp; sleep 1; vncserver :1 -geometry 1280x720 -localhost no && xrdp"' >> ~/.bashrc

# Reload aliases
source ~/.bashrc

# Let user know installation is complete
clear && echo "XRDP is installed. To use, type startxrdp to start server. Type, ifconfig and connect to the WLAN0 local IP with your PC. You can close xrdp by typing stopxrdp."
