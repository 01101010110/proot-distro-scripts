#!/bin/bash

# Ask the user about the environment
echo "Is this installation for a Termux environment? (yes/no)"
read IS_TERMUX

if [ "$IS_TERMUX" = "yes" ]; then
    # Termux environment setup
    echo "Setting up xRDP for Termux..."

    # Install xRDP
    pkg install xrdp -y

    # Configure xRDP
    sed -i 's/port=-1/port=5909/' ../usr/etc/xrdp/xrdp.ini

    # Create an Alias

    # Start the xrdp server
    xrdp
    vncserver -xstartup ../usr/bin/startxfce4 -listen tcp :9

else
    # Linux environment setup
    echo "Setting up xRDP for Linux..."

    # Install xRDP
    sudo apt install xrdp -y

    # Configure xRDP
    sed -i 's|test -x /etc/X11/Xsession && exec /etc/X11/Xsession|exec startxfce4|' /etc/xrdp/startwm.sh
    sed -i '/exec \/bin\/sh \/etc\/X11\/Xsession/d' /etc/xrdp/startwm.sh

    # Create an alias to restart the xrdp server in the future by typing the word 'run'
    echo "alias run='sudo GALLIUM_DRIVER=virpipe MESA_GL_VERSION_OVERRIDE=4.0 service xrdp stop && service xrdp start && ifconfig | grep inet'" >> ~/.bashrc
    source ~/.bashrc

    # Start the xrdp server
    sudo service xrdp stop
    sudo service xrdp start
fi

# Clear the screen
clear

# Display local IP address
ifconfig | grep 'inet' | cut -d' ' -f10

# Show user completion message
echo "====================="
echo "Installation complete"
echo "====================="
echo "Use your local IP address provided above (usually begins with '192.168') to connect remotely."
