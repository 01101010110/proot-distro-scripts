#!/bin/bash

# Install xRDP
sudo apt install xrdp -y

# Configure xRDP
sed -i 's|test -x /etc/X11/Xsession && exec /etc/X11/Xsession|exec startxfce4|' /etc/xrdp/startwm.sh
sed -i '/exec \/bin\/sh \/etc\/X11\/Xsession/d' /etc/xrdp/startwm.sh

# Create an alias to restart the xrdp server in the future by typing the wword 'run' 
#echo "alias run='sudo service xrdp stop && sudo service xrdp start'" >> ~/.bashrc
echo "alias run='sudo service xrdp stop && sudo service xrdp start && ifconfig | grep 'inet''" >> ~/.bashrc
source ~/.bashrc

# Start the xrdp server
sudo service xrdp stop
sudo service xrdp start

# Clear the screen
clear

# Display local ip address 
ifconfig | grep 'inet' | cut -d' ' -f10

# Show user completion message
echo "====================="
echo "Installation complete
echo "====================="
echo
echo "Use your local ip address provided above (usually begins with '192.168') to connect remotely"
