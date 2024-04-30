# Install xRDP
sudo apt install xrdp -y

# Configure xRDP
sed -i 's|test -x /etc/X11/Xsession && exec /etc/X11/Xsession|exec startxfce4|' /etc/xrdp/startwm.sh
sed -i '/exec \/bin\/sh \/etc\/X11\/Xsession/d' /etc/xrdp/startwm.sh

# Create an alias to restart the xrdp server in the future by typing 'xrdpstart', this is inverse to the termux alias as to not cause conflicts
echo "alias xrdpstart='sudo service xrdp stop && sudo service xrdp start && ifconfig'" >> ~/.bashrc

# Create an alias to stop the xrdp server by typing xrdpstop   
echo "alias xrdpstop='sudo service xrdp stop'" >> ~/.bashrc && source ~/.bashrc

# Let user know installation is complete
clear && echo "Xrdp is installed. To use, type xrdpstart and connect to the WLAN0 local IP with your PC."


