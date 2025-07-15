#!/bin/bash

# Install required packages
pkg install x11-repo -y
pkg update -y
pkg install xfce4 xfce4-goodies tigervnc xrdp -y

# Fix port in xrdp.ini
sed -i 's/port=-1/port=5901/' ../usr/etc/xrdp/xrdp.ini

# Create VNC startup files
mkdir -p ~/.vnc
echo "#!/data/data/com.termux/files/usr/bin/sh" > ~/.vnc/xstartup
echo "startxfce4 &" >> ~/.vnc/xstartup
chmod +x ~/.vnc/xstartup

# Create .xsession for XRDP
echo "startxfce4" > ~/.xsession
chmod +x ~/.xsession

# Start services
vncserver -geometry 1280x720 :1
xrdp
