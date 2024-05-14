#!/bin/bash

# Install xRDP
pkg install xrdp -y

# Configure xRDP
sed -i 's/port=-1/port=5901/' $PREFIX/etc/xrdp/xrdp.ini

# Create startxrdp script
echo -e "#!/bin/bash\nxrdp && vncserver -xstartup /usr/bin/startxfce4 -listen tcp :1 && ifconfig" > /data/data/com.termux/files/usr/bin/startxrdp
chmod +x /data/data/com.termux/files/usr/bin/startxrdp

# Write aliases to the shell configuration file

# Set an alias to load termux environment faster
echo 'alias stopxrdp="xrdp -k && vncserver -kill :1"' >> >> $HOME/.bashrc
echo 'alias startxrdp="xrdp && vncserver -xstartup /usr/bin/startxfce4 -listen tcp :1"' >> >> $HOME/.bashrc
source ~/.bashrc

# Setup the vnc server and password
xrdp && vncserver -xstartup /usr/bin/startxfce4 -listen tcp :1 && stopxrdp

# Let user know installation is complete
clear && echo "XRDP is installed. To use, type startxrdp and connect to the WLAN0 local IP with your PC. You can close xrdp by typing stopxrdp."
