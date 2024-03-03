
# Proot-Distro Scripts

This repository contains scripts that are able to be executed using one line of code, and without having to preinstall anything other than your Termux app and viewing app. 

Note that this repository is not ready! I am live testing it now and building as I go so please wait for an update on the XDA Thread before running any of the curl commands.


## Ubuntu Scripts

**Ubuntu for the Termux x11 App:**
```
curl -sL https://raw.githubusercontent.com/01101010110/proot-distro-scripts/main/ubuntu-x11-app.sh -o ubuntu-x11-app.sh && chmod +x ubuntu-x11-app.sh && ./ubuntu-x11-app.sh
```
This script is currently using xfce4 through Termux, I am working on fixing it so the xfce4 gui is setup in proot-distro instead. 
The changes will be tested in the Debian script first then ported over to Ubuntu.

## Debian Scripts

**Debian for the Termux x11 App:**
```
curl -sL https://raw.githubusercontent.com/01101010110/proot-distro-scripts/main/debian-x11-app.sh -o debian-x11-app.sh && chmod +x debian-x11-app.sh && ./debian-x11-app.sh
```

## Miscellanious Scripts

**Script to add xRDP Support:**
```
curl -sL https://raw.githubusercontent.com/01101010110/proot-distro-scripts/main/setup-xrdp.sh -o setup-xrdp.sh && chmod +x setup-xrdp.sh && ./setup-xrdp.sh
```
