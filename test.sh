#!/bin/bash

# Install xRDP
apt install xrdp -y

# Configure xRDP
echo "xfce4-session" > /home/$username/.xsession
sed -i 's|test -x /etc/X11/Xsession && exec /etc/X11/Xsession|exec startxfce4|' /etc/xrdp/startwm.sh
sed -i '/exec \/bin\/sh \/etc\/X11\/Xsession/d' /etc/xrdp/startwm.sh

service xrdp stop
service xrdp start
