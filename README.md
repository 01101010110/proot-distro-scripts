# Proot-Distro Scripts

This repository contains scripts that are able to be executed using one line of code, and without having to preinstall anything other than the Termux app and Termux-x11 viewing app. Additional scripts are provided below to add xRDP or VNC support to your environment, so you can connect to your environment remotely with a computer. 

### Features

* Minimalist builds in 3 different flavors, with nothing extra added.
* All three environments are able to be installed, not just one.
* Load the environment by typing one word, 'ubuntu', 'debian', or 'termux'.
* Hardware acceleration is embedded into the alias.
* Users are able to select their own username and password.
* Automatically adds the new user to the sudoer's file.
* Shared-tmp is enabled, allowing use of termux installed packages.
* Working sound in all of the environments.

### Dependencies

* Termux needs to be installed. [Termux Apk direct download link](https://f-droid.org/repo/com.termux_118.apk)
* Termux's x11 apk needs to be installed, choose the correct version for your device.  
* [Arm64 x11 Apk](https://github.com/termux/termux-x11/releases/download/nightly/app-arm64-v8a-debug.apk) - For android devices running arm64. Most modern devices will run this.
* [Armeabi-v7a x11 Apk](https://github.com/termux/termux-x11/releases/download/nightly/app-armeabi-v7a-debug.apk) - For devices running armeabi-v7a. Older devices usually.
* [Universal x11 Apk](https://github.com/termux/termux-x11/releases/download/nightly/app-universal-debug.apk) - When in doubt!

### Installation

* Select an environment below, Ubuntu, Debian, or Termux, and copy it's code.
* Paste your code into Termux and press enter.
* You will be asked to select a repository, just press enter twice. (Prevents a repo bug)
* The script will install everything needed and prompt towards the end for language selection.
* When the script completes, it will open the x11 app for us. The app will freeze the first run.
<img src="https://github.com/01101010110/proot-distro-scripts/blob/main/Pictures/blackx11screen.png?raw=true" width="100" height="200">
* Force close Termux, then type in the alias of environment you installed, 'ubuntu', 'debian', or 'termux'.
* Now the app will run without any problems and have hardware acceleration enabled always.
<img src="https://github.com/01101010110/proot-distro-scripts/blob/main/Pictures/blackx11screen.png?raw=true" width="100" height="200"><img src="https://github.com/01101010110/proot-distro-scripts/blob/main/Pictures/termuxappinfo.png?raw=true" width="100" height="200"><img src="https://github.com/01101010110/proot-distro-scripts/blob/main/Pictures/forcestoptermux.png?raw=true" width="100" height="200">

#
## Ubuntu Environment 

Builds an Ubuntu Mantic Minotaur proot-distro environment with an xfce4 provided GUI.

**Copy and paste into Termux:**
```
curl -sL https://raw.githubusercontent.com/01101010110/proot-distro-scripts/main/ubuntu-x11-app.sh -o ubuntu-x11-app.sh && chmod +x ubuntu-x11-app.sh && ./ubuntu-x11-app.sh
```

#
## Debian Environment 

Builds a Debian Bookworm proot-distro environment with an xfce4 provided GUI.

**Copy and paste into Termux:**
```
curl -sL https://raw.githubusercontent.com/01101010110/proot-distro-scripts/main/debian-x11-app.sh -o debian-x11-app.sh && chmod +x debian-x11-app.sh && ./debian-x11-app.sh
```

#
## Termux Environment 

Builds a pure Termux environment with an xfce4 provided GUI, and no proot-distro. 

**Copy and paste into Termux:**
```
curl -sL https://raw.githubusercontent.com/01101010110/proot-distro-scripts/main/termux-x11-app.sh -o termux-x11-app.sh && chmod +x termux-x11-app.sh && ./termux-x11-app.sh
```

#
## Optional xRDP Support

Adds xRDP support, which allows you to connect to your environment remotely using a computer. (Works for all environments listed above) 

**Copy and paste inside of your environment:**
```
curl -sL https://raw.githubusercontent.com/01101010110/proot-distro-scripts/main/xrdp-setup.sh -o xrdp-setup.sh && chmod +x xrdp-setup.sh && source xrdp-setup.sh
```

#
## Optional VNC Support

Adds VNC support, which allows you to connect to your environment remotely using a computer. (Works for all environments listed above) 

**Copy and paste inside of your environment:**
```
This is a placeholder for now
```


