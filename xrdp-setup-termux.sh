#!/bin/bash

pkg install x11-repo -y
pkg update -y
pkg install xfce4 xfce4-goodies tigervnc xrdp -y

cat > ../usr/etc/xrdp/xrdp.ini << 'EOF'
[Globals]
ini_version=1
fork=true
port=3389

[xrdp1]
name=VNC-Session
lib=libvnc.so
username=ask
password=ask
ip=127.0.0.1
port=5901
EOF

mkdir -p ~/.vnc
echo "#!/data/data/com.termux/files/usr/bin/sh" > ~/.vnc/xstartup
echo "startxfce4 &" >> ~/.vnc/xstartup
chmod +x ~/.vnc/xstartup

echo "startxfce4" > ~/.xsession
chmod +x ~/.xsession

pkill -9 xrdp
pkill -9 sesman
pkill -f Xtigervnc
vncserver -kill :1 > /dev/null 2>&1

rm -f ~/.vnc/*:1.pid
rm -f /data/data/com.termux/files/usr/tmp/.X1-lock
rm -f /data/data/com.termux/files/usr/tmp/.X11-unix/X1

sleep 2

vncserver -geometry 1280x720 :1
xrdp
