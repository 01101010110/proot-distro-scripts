#!/bin/bash

# Set Username
read -r -p "Select a username: " username </dev/tty



# Configure xRDP
proot-distro login ubuntu --shared-tmp -- env DISPLAY=:1 echo "xfce4-session" > /home/$username/.xsession

# Modify the xRDP start script
proot-distro login ubuntu --shared-tmp -- env DISPLAY=:1 sed -i 's|test -x /etc/X11/Xsession && exec /etc/X11/Xsession|exec startxfce4|' /etc/xrdp/startwm.sh
proot-distro login ubuntu --shared-tmp -- env DISPLAY=:1 sed -i '/exec \/bin\/sh \/etc\/X11\/Xsession/d' /etc/xrdp/startwm.sh


