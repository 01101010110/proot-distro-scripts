#!/bin/bash

pkg install x11-repo -y
pkg update -y
pkg install xfce4 xfce4-goodies xrdp xorg-xrdp -y

cat > ../usr/etc/xrdp/xrdp.ini << 'EOF'
[Globals]
ini_version=1
fork=true
port=3389

[xrdp1]
name=Xorg-Session
lib=libxorgxrdp.so
username=ask
password=ask
ip=127.0.0.1
port=-1
EOF

echo "startxfce4" > ~/.xsession
chmod +x ~/.xsession

pkill -9 xrdp
pkill -9 sesman
rm -f /data/data/com.termux/files/usr/tmp/.X11-unix/X0
rm -f /data/data/com.termux/files/usr/tmp/.X0-lock

sleep 2

xrdp
