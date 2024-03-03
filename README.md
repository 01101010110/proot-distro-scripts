
# Proot-Distro Scripts

This repository contains scripts that are able to be executed using one line of code, and without having to preinstall anything other than your Termux app and viewing app. 

Note that this repository is not ready! I am live testing it now and building as I go so please wait for an update on the XDA Thread before running any of the curl commands.


## Ubuntu Scripts

**Ubuntu for the Termux x11 App:**
```
curl -sL https://raw.githubusercontent.com/01101010110/proot-distro-scripts/main/ubuntu-x11-app.bash -o ubuntu-x11-app.bash && chmod +x ubuntu-x11-app.bash && ./ubuntu-x11-app.bash
```

## Debian Scripts

**Debian for the Termux x11 App:**
```
curl -sL https://raw.githubusercontent.com/01101010110/proot-distro-scripts/main/debian-x11-app.bash -o debian-x11-app.bash && chmod +x debian-x11-app.bash && ./debian-x11-app.bash
```

## Miscellanious Scripts

**Script to add xRDP Support:**
```
curl -sL https://raw.githubusercontent.com/01101010110/proot-distro-scripts/main/setup-xrdp.sh -o setup-xrdp.sh && chmod +x setup-xrdp.sh && ./setup-xrdp.sh
```
