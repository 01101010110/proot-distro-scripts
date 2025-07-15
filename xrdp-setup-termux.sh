#!/bin/bash

pkg install x11-repo -y
pkg update -y
pkg install xfce4 xfce4-goodies tigervnc xrdp -y

echo "startxfce4" > ~/.xsession
chmod +x ~/.xsession

cat > ../usr/etc/xrdp/xrdp.ini << 'EOF'
[Globals]
ini_version=1
fork=true
port=3389

[Logging]
LogFile=xrdp.log
LogLevel=DEBUG
EnableSyslog=false

[Channels]
rdpdr=true
rdpsnd=true
drdynvc=true
cliprdr=true
rail=true
xrdpvr=true

[Xvnc]
name=Xvnc
lib=libvnc.so
username=remote
password=111111
ip=127.0.0.1
port=-1
EOF

pkill -9 xrdp
pkill -9 sesman
pkill -f Xtigervnc
vncserver -kill :1 > /dev/null 2>&1

rm -f ~/.vnc/*:1.pid
rm -f /data/data/com.termux/files/usr/tmp/.X1-lock
rm -f /data/data/com.termux/files/usr/tmp/.X11-unix/X1
rm -f /data/data/com.termux/files/usr/var/run/xrdp-sesman.pid

sleep 2

vncserver -geometry 1280x720 :1

xrdp-sesman
xrdp
