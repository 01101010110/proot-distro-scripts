#!/bin/bash

# Install vnc package
pkg install tigervnc -y

# Runs vnc for first time so user can set a password
vncserver && vncserver -kill :1

# Setup an alias to run the server in the future using 'startvnc' and ensure it always starts on port 1
echo 'alias startvnc="vncserver -xstartup ../usr/bin/startxfce4 -listen tcp :1 && rm -r /data/data/com.termux/files/usr/tmp && mkdir /data/data/com.termux/files/usr/tmp"' >> $HOME/.bashrc

# Setup an alias to stop the vnc server using 'stopvnc'
echo 'alias stopvnc="vncserver -kill :1"' >> $HOME/.bashrc

# Source the .bashrc to make the alias available in the current session
source ~/.bashrc
