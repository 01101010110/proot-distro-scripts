#!/bin/bash

pkg install x11-repo -y
pkg update -y
pkg install xfce4 xfce4-goodies tigervnc xrdp -y

sed -i 's/port=-1/port=5901/' ../usr/etc/xrdp/xrdp.ini

xrdp
vncserver -xstartup ../usr/bin/startxfce4 -listen tcp :1
