#!/bin/bash

# Set Username
read -r -p "Select a username: " username </dev/tty



# Configure xRDP
echo "xfce4-session" > /home/$username/.xsession

# Modify the xRDP start script
sed -i 's|test -x /etc/X11/Xsession && exec /etc/X11/Xsession|exec startxfce4|' /etc/xrdp/startwm.sh
sed -i '/exec \/bin\/sh \/etc\/X11\/Xsession/d' /etc/xrdp/startwm.sh


