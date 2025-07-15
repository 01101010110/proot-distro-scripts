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
* Paste your code into Termux and press enter. Set a user name and password. (The username MUST start with a letter)
* You will then be asked to select a repository, just press enter twice. (Prevents a repo bug)
* The script will install everything needed and prompt towards the end for language selection.
* When the script completes, it will open the x11 app for us. The app will freeze the first run.
* Force close Termux, then type in the alias of environment you installed, 'ubuntu', 'debian', or 'termux'.
* Now the app will run without any problems and have hardware acceleration enabled always.

<img src="https://github.com/01101010110/proot-distro-scripts/blob/main/Pictures/installationscript.png?raw=true" width="100" height="200"><img src="https://github.com/01101010110/proot-distro-scripts/blob/main/Pictures/repo1.png?raw=true" width="100" height="200"><img src="https://github.com/01101010110/proot-distro-scripts/blob/main/Pictures/repo2.png?raw=true" width="100" height="200"><img src="https://github.com/01101010110/proot-distro-scripts/blob/main/Pictures/usersetup.png?raw=true" width="100" height="200"><img src="https://github.com/01101010110/proot-distro-scripts/blob/main/Pictures/frozenx11.png?raw=true" width="100" height="200"><img src="https://github.com/01101010110/proot-distro-scripts/blob/main/Pictures/termuxappinfo.png?raw=true" width="100" height="200"><img src="https://github.com/01101010110/proot-distro-scripts/blob/main/Pictures/forcestoptermux.png?raw=true" width="100" height="200">

#
## Ubuntu Environment 

<img src="https://github.com/01101010110/proot-distro-scripts/blob/main/Pictures/ubuntu.png?raw=true" width="100" height="200"> <img src="https://github.com/01101010110/proot-distro-scripts/blob/main/Pictures/ubuntu2.png?raw=true" width="100" height="200">

Builds an Ubuntu proot-distro environment with an xfce4 provided GUI. Installs in about 30 minutes to an hour.

**Copy and paste into Termux:**
```
curl -sL https://raw.githubusercontent.com/01101010110/proot-distro-scripts/main/ubuntu-x11-app.sh -o ubuntu-x11-app.sh && chmod +x ubuntu-x11-app.sh && ./ubuntu-x11-app.sh
```

#
## Debian Environment 

<img src="https://github.com/01101010110/proot-distro-scripts/blob/main/Pictures/debian.png?raw=true" width="100" height="200"> <img src="https://github.com/01101010110/proot-distro-scripts/blob/main/Pictures/debian2.png?raw=true" width="100" height="200">

Builds a Debian proot-distro environment with an xfce4 provided GUI. Installs in about 30 minutes to an hour.

**Copy and paste into Termux:**
```
curl -sL https://raw.githubusercontent.com/01101010110/proot-distro-scripts/main/debian-x11-app.sh -o debian-x11-app.sh && chmod +x debian-x11-app.sh && ./debian-x11-app.sh
```

#
## Termux Environment 

<img src="https://github.com/01101010110/proot-distro-scripts/blob/main/Pictures/termux.png?raw=true" width="100" height="200"> <img src="https://github.com/01101010110/proot-distro-scripts/blob/main/Pictures/termux2.png?raw=true" width="100" height="200">

Builds a pure Termux environment with an xfce4 provided GUI, and no proot-distro. Installs in about 5-10 minutes.

**Copy and paste into Termux:**
```
curl -sL https://raw.githubusercontent.com/01101010110/proot-distro-scripts/main/termux-x11-app.sh -o termux-x11-app.sh && chmod +x termux-x11-app.sh && ./termux-x11-app.sh
```

#
## Fix For Samsung users missing audio

Will fix missing audio problem for Samsung users, only need to run this code in Termux once, and it will fix the issue for all three environments at once (force close termux when done, then open the environment):

**Copy and paste inside of Termux and not inside your environment:**
```
echo -e 'LD_PRELOAD=/system/lib64/libskcodec.so\npulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1' | tee -a ../usr/etc/bash.bashrc
```
Then force close Termux and open your environment and the sound should be fixed. Thanks to zincro3 from the XDA Forums.

#
## Optional xRDP Support --- For Ubuntu and Debian Environments Only!

Adds xRDP support, which allows you to connect to your environment remotely using a computer. 

**Copy and paste inside of your environment:**
```
curl -sL https://raw.githubusercontent.com/01101010110/proot-distro-scripts/main/xrdp-setup.sh -o xrdp-setup.sh && chmod +x xrdp-setup.sh && source xrdp-setup.sh
```
Use the command xrdpstart to start the service, and grab your ip address for Windows Remote Desktop Connection

#
## Optional xRDP Support --- For Termux Only Environments!

Adds xRDP support, which allows you to connect to your environment remotely using a computer. 

**Copy and paste inside of Termux:**

Make sure you run this command in the Termux App, and Not in the Termux Environment. The Termux xrdp can't operate correctly if we are connected to the x11 app using our environments, so we need to just use the Termux app's shell.

```
curl -sL https://raw.githubusercontent.com/01101010110/proot-distro-scripts/main/xrdp-setup-termux.sh -o xrdp-setup-termux.sh && chmod +x xrdp-setup-termux.sh && source xrdp-setup-termux.sh
```
Use the command startxrdp to restart the service in the future, stopxrdp to stop it. 

#
## Process 9 error

You need to run this adb command to fix the process 9 error that will force close Termux
```
adb shell device_config put activity_manager max_phantom_processes 2147483647
```
If you want to run the code above in Termux, instead of using a PC, here is a video and written instructions:
[![YouTube Video](https://img.youtube.com/vi/Q8xbCkHXAq8/0.jpg)](https://www.youtube.com/watch?v=Q8xbCkHXAq8)

Install adb in Termux by running this code:
```
pkg install android-tools -y
```
Then open settings and enable developer's options by selecting "About phone" then hit "Build" 7 times.

Back out of this menu and go into developer's options and enable wireless debugging.

Put settings into split screen mode by pressing the square button on the bottom right of your phone, and hold the settings icon until the split screen icon shows up.

Then select Termux and in settings select pair with a code. In Termux type:
```
adb pair 
``` 
Then type your pairing info.

Note that if you need to see your pairing info again, do not press the back button or it will break the pairing process. Use the square button then click on termux and when the window readjusts, you will be able to see the pairing info again.

After you have completed this process you can type adb connect and connect to your phone with the ip and port provided in the wireless debugging menu. You can then paste the Process 9 fix code.

## See the XDA thread for more nuanced details
https://xdaforums.com/t/guide-no-root-how-to-install-debian-or-ubuntu-environments-on-android-in-termux-using-proot-distro.4570275/
