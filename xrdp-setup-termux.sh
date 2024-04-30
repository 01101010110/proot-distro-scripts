# Install xRDP
pkg install xrdp -y

# Configure xRDP
sed -i 's/port=-1/port=5901/' ../usr/etc/xrdp/xrdp.ini &&

# Create an Alias called 'stopxrdp' to stop the xRDP server and load the alias when completed
alias stopxrdp='xrdp -k && vncserver -kill :1'

# Create an Alias called 'startxrdp' to start the xRDP server quickly and load the alias when completed
alias startxrdp='stopxrdp && xrdp && vncserver -xstartup /usr/bin/startxfce4 -listen tcp :1 && ifconfig'

# Clear the screen
clear

# Start the xrdp server and display local ip address
xrdp && vncserver -xstartup /usr/bin/startxfce4 -listen tcp :1 && ifconfig
