#!/bin/bash

# Install xRDP
pkg install xrdp -y

# Configure xRDP
sed -i 's/port=-1/port=5901/' $PREFIX/etc/xrdp/xrdp.ini

# Write aliases to the shell configuration file
#echo "alias stopxrdp='xrdp -k && vncserver -kill :1'" >> ~/.bashrc
#echo "alias startxrdp='stopxrdp && xrdp && vncserver -xstartup /usr/bin/startxfce4 -listen tcp :1 && ifconfig'" >> ~/.bashrc

#Test
echo "alias stopxrdp='xrdp -k && pgrep Xtightvnc | xargs kill -9'" >> ~/.bashrc
echo "alias startxrdp='stopxrdp && xrdp && vncserver -xstartup /usr/bin/startxfce4 -listen tcp :1 && ifconfig'" >> ~/.bashrc

# Load the aliases for the current session
source ~/.bashrc

# Setup the vnc server and password
xrdp && vncserver -xstartup /usr/bin/startxfce4 -listen tcp :1 

# Let user know installation is complete
clear && echo "XRDP is installed. To use, type startxrdp and connect to the WLAN0 local IP with your PC. You can close xrdp by typing stopxrdp."
