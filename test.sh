termux-setup-storage
yes | pkg install x11-repo
yes | pkg update
yes | pkg install xwayland
wget https://github.com/01101010110/proot-distro-scripts/raw/main/termux-x11.deb
dpkg -i --force-depends termux-x11.deb
echo "allow-external-apps = true" >> ~/.termux/termux.properties
termux-x11 :1
proot-distro login ubuntu --shared-tmp 
export DISPLAY=:1 
xfce4-session
