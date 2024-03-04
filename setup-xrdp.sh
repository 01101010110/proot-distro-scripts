#!/bin/bash

# Clear the screen
clear

# Ask the user about the environment
echo "Is the xrdp installation for a Termux environment? Say no if you are installing xrdp for Linux environments like, Ubuntu, Debian, etc. (yes/no)"
read IS_TERMUX

if [ "$IS_TERMUX" = "yes" ]; then
    # Termux environment setup
    echo "Setting up xRDP for Termux..."

    # Install xRDP
    pkg install xrdp -y

    # Configure xRDP
    sed -i 's/port=-1/port=5901/' ../usr/etc/xrdp/xrdp.ini

    # Create an Alias to startxrdp
    echo "alias startxrdp='xrdp ; vncserver -xstartup /usr/bin/startxfce4 -listen tcp :1'" >> ~/.bashrc

    # Create an Alias to stop xrdp
    echo "alias stopxrdp='xrdp -k ; vncserver -kill :1'" >> ~/.bashrc

    # Load the aliases
    source ~/.bashrc
    
    # Start the xrdp server
    xrdp ; vncserver -xstartup /usr/bin/startxfce4 -listen tcp :1

else
    # Linux environment setup
    echo "Setting up xRDP for Linux..."

    # Install xRDP
    sudo apt install xrdp -y

    # Configure xRDP
    sed -i 's|test -x /etc/X11/Xsession && exec /etc/X11/Xsession|exec startxfce4|' /etc/xrdp/startwm.sh
    sed -i '/exec \/bin\/sh \/etc\/X11\/Xsession/d' /etc/xrdp/startwm.sh
    
    # Create an alias to display local IP address
    alias inet="ifconfig | grep 'inet ' | awk '{print \$2}'"

    # Create an alias to restart the xrdp server in the future by typing 'xrdpstart', this is inverse to the termux alias as to not cause conflicts
    echo "alias xrdpstart='sudo service xrdp stop && sudo service xrdp start && inet'" >> ~/.bashrc
  

    # Create an alias to stop the xrdp server by typing xrdpstop   
    echo "alias xrdpstop='sudo service xrdp stop'" >> ~/.bashrc

    # Load the aliases
    source ~/.bashrc

    # Start the xrdp server
    sudo service xrdp stop 
    sudo service xrdp start
fi

# Clear the screen
#clear

# Display local IP address
ifconfig | grep 'inet ' | awk '{print \$2}

# Show user completion message
echo "====================="
echo "Installation complete"
echo "====================="
echo "Use your local IP address provided above (usually begins with '192.168') to connect remotely."
