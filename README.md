
# Proot-Distro Scripts

This repository contains scripts that are able to be executed using one line of code, and without having to preinstall anything other than your Termux app and viewing app. 

Note that this repository is not ready! I am live testing it now and building as I go so please wait for an update on the XDA Thread before running any of the curl commands.





## Ubuntu Scripts

**Ubuntu for the Termux x11 App:**
```
curl -sL https://raw.githubusercontent.com/01101010110/proot-distro-scripts/main/ubuntu-x11-app.bash -o ubuntu-x11-app.bash && chmod +x ubuntu-x11-app.bash && ./ubuntu-x11-app.bash
```

**Current Tester For Ubuntu With xRDP Support:**
```
curl -sL https://raw.githubusercontent.com/01101010110/proot-distro-scripts/main/test.sh -o test.sh && chmod +x test.sh && ./test.sh
```
**Current Tester for the Termux x11 App (fixed the display server in the main x11 app script above, working on adding feature to alias to popout x11 app each time ubuntu is ran. then hardware acceleration**
```
curl -sL https://raw.githubusercontent.com/01101010110/proot-distro-scripts/main/ubuntu-x11-app-test.bash -o ubuntu-x11-app.bash && chmod +x ubuntu-x11-app.bash && ./ubuntu-x11-app.bash
```
