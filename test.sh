#!/bin/bash

# Install xRDP
sudo apt install xrdp -y

# Configure xRDP
sed -i 's|test -x /etc/X11/Xsession && exec /etc/X11/Xsession|exec startxfce4|' /etc/xrdp/startwm.sh
sed -i '/exec \/bin\/sh \/etc\/X11\/Xsession/d' /etc/xrdp/startwm.sh

# Create an alias to restart the xrdp server in the future by typing the wword 'run' 
echo "alias run='sudo service xrdp stop && sudo service xrdp start'" >> ~/.bashrc
source ~/.bashrc

# Start the xrdp server
sudo service xrdp stop
sudo service xrdp start
