# Install xRDP
proot-distro login debian --shared-tmp -- env DISPLAY=:1 sudo apt install xrdp -y

# Configure xRDP
proot-distro login debian --shared-tmp -- env DISPLAY=:1 sed -i 's|test -x /etc/X11/Xsession && exec /etc/X11/Xsession|exec startxfce4|' /etc/xrdp/startwm.sh
proot-distro login debian --shared-tmp -- env DISPLAY=:1 sed -i '/exec \/bin\/sh \/etc\/X11\/Xsession/d' /etc/xrdp/startwm.sh

# Create an alias to restart the xrdp server in the future by typing 'xrdpstart', this is inverse to the termux alias as to not cause conflicts
proot-distro login debian --shared-tmp -- env DISPLAY=:1 echo "alias xrdpstart='sudo service xrdp stop && sudo service xrdp start && ifconfig'" >> ~/.bashrc

# Create an alias to stop the xrdp server by typing xrdpstop   
proot-distro login debian --shared-tmp -- env DISPLAY=:1 echo "alias xrdpstop='sudo service xrdp stop'" >> ~/.bashrc && source ~/.bashrc





