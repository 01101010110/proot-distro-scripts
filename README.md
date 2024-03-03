
# Proot-Distro Scripts

This repository contains scripts that are able to be executed using one line of code, and without having to preinstall anything other than your Termux app and viewing app. 

### Features

* Load the environment by typing one word, 'ubuntu' or 'debian'.
* Hardware acceleration is embedded into the alias 
* Minimalist build with nothing extra added


## Ubuntu Environment Scripts

**Ubuntu xfce4 environment for the Termux x11 App:**
```
curl -sL https://raw.githubusercontent.com/01101010110/proot-distro-scripts/main/ubuntu-x11-app.sh -o ubuntu-x11-app.sh && chmod +x ubuntu-x11-app.sh && ./ubuntu-x11-app.sh
```
This script is currently using xfce4 through Termux, I am working on fixing it so the xfce4 gui is setup in proot-distro instead. 
The changes will be tested in the Debian script first then ported over to Ubuntu.


## Debian Environment Scripts

**Debian xfce4 environment for the Termux x11 App:**
```
curl -sL https://raw.githubusercontent.com/01101010110/proot-distro-scripts/main/debian-x11-app.sh -o debian-x11-app.sh && chmod +x debian-x11-app.sh && ./debian-x11-app.sh
```


## Termux Environment Scripts

**Termux xfce4 environment for the Termux x11 App:**
```
curl -sL https://raw.githubusercontent.com/01101010110/proot-distro-scripts/main/termux-x11-app.sh -o termux-x11-app.sh && chmod +x termux-x11-app.sh && ./termux-x11-app.sh
```


## Miscellanious Scripts

**Script to add xRDP Support:**
```
curl -sL https://raw.githubusercontent.com/01101010110/proot-distro-scripts/main/setup-xrdp.sh -o setup-xrdp.sh && chmod +x setup-xrdp.sh && ./setup-xrdp.sh
```
