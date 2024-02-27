#!/bin/bash

# Ensure non-interactive frontend for apt-get
export DEBIAN_FRONTEND=noninteractive

sleep 3


# Preconfigure tzdata
proot-distro login ubuntu --shared-tmp -- env DISPLAY=:1 /bin/bash -c "
echo 'Etc/UTC' > /etc/timezone
ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime
apt-get update
apt-get install -y tzdata
dpkg-reconfigure --frontend noninteractive tzdata
"
sleep 3


# Install xRDP
yes | proot-distro login ubuntu --shared-tmp -- env DISPLAY=:1 apt install xrdp

# Configure xRDP
proot-distro login ubuntu --shared-tmp -- env DISPLAY=:1 echo "xfce4-session" > /home/$USERNAME/.xsession

# Stop xRDP service
proot-distro login ubuntu --shared-tmp -- env DISPLAY=:1 service xrdp stop
proot-distro login ubuntu --shared-tmp -- env DISPLAY=:1 service xrdp start
