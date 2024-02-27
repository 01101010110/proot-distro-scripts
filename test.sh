#!/bin/bash

# Set non-interactive frontend
export DEBIAN_FRONTEND=noninteractive

# Ask user for their timezone
echo "Please enter your geographical area (e.g., Europe, America, Asia):"
read AREA
echo "Please enter your city or closest major city (e.g., Berlin, New_York, Tokyo):"
read CITY
echo "tzdata tzdata/Areas select $AREA" | debconf-set-selections
echo "tzdata tzdata/Zones/$AREA select $CITY" | debconf-set-selections

# Install xRDP
yes | proot-distro login ubuntu --shared-tmp -- env DISPLAY=:1 apt install xrdp

# Configure xRDP
proot-distro login ubuntu --shared-tmp -- env DISPLAY=:1 echo "xfce4-session" > /home/$USERNAME/.xsession

# Stop xRDP service
proot-distro login ubuntu --shared-tmp -- env DISPLAY=:1 service xrdp stop
proot-distro login ubuntu --shared-tmp -- env DISPLAY=:1 service xrdp start
