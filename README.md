
# Proot-Distro Scripts

This repository contains scripts that are able to be executed using one line of code, and without having to preinstall anything other than the Termux app and Termux-x11 viewing app. Additional scripts are provided in the Miscellanious section below to add xRDP or VNC support to your environment, so you can connect to your environment remotely with a computer. 

### Features

* Minimalist build with nothing extra added
* Load the environment by typing one word, 'ubuntu', 'debian', or 'termux'.
* Hardware acceleration is embedded into the alias 
* User is able to select their own username and password
* Automatically adds the new user to the sudoer's file
* Shared-tmp is enabled, allowing use of termux installed packages
* Sound is working

### Dependencies

* Termux needs to be installed. (Can be a fresh install) [Termux direct download link](https://f-droid.org/repo/com.termux_118.apk)
* Termux's x11 apk needs to be installed, choose the correct version for your device.  
* [Arm64 x11 Apk](https://github.com/termux/termux-x11/releases/download/nightly/app-arm64-v8a-debug.apk) - For android devices running arm64. Most modern devices will run this.
* [Armeabi-v7a x11 Apk](https://github.com/termux/termux-x11/releases/download/nightly/app-armeabi-v7a-debug.apk) - For devices running armeabi-v7a. Older devices usually.
* [Universal x11 Apk](https://github.com/termux/termux-x11/releases/download/nightly/app-universal-debug.apk) - When in doubt!

## Ubuntu Environment Scripts

**Ubuntu xfce4 environment for the Termux x11 App:**
```
curl -sL https://raw.githubusercontent.com/01101010110/proot-distro-scripts/main/ubuntu-x11-app.sh -o ubuntu-x11-app.sh && chmod +x ubuntu-x11-app.sh && ./ubuntu-x11-app.sh
```


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
Builds a pure Termux environment with an xfce4 provided GUI, and no proot-distro. 

## Miscellanious Scripts

**Script to add xRDP Support:**
```
curl -sL https://raw.githubusercontent.com/01101010110/proot-distro-scripts/main/setup-xrdp.sh -o setup-xrdp.sh && chmod +x setup-xrdp.sh && source setup-xrdp.sh
```
The xRDP Support script isn't ready yet. I keep breaking it.. 
