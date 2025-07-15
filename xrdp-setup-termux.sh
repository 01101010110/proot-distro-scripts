#!/bin/bash

pkg install x11-repo -y
pkg update -y
pkg install xfce4 xfce4-goodies tigervnc xrdp -y

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

xrdp-sesman
xrdp
