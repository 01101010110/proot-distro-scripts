# Update packages and install required components
pkg update -y && pkg install x11-repo -y && pkg install -y xfce4 xfce4-goodies xfce4-terminal xfce4-whiskermenu-plugin tigervnc xrdp dbus

# Create VNC startup script to launch XFCE
mkdir -p ~/.vnc
cat > ~/.vnc/xstartup <<EOF
#!/data/data/com.termux/files/usr/bin/sh
export DISPLAY=":1"
export XDG_RUNTIME_DIR="/data/data/com.termux/files/usr/tmp"
xrdb "\$HOME/.Xresources"
export XKL_XMODMAP_DISABLE=1
eval "\$(dbus-launch)"
export DBUS_SESSION_BUS_ADDRESS
exec startxfce4
EOF
chmod +x ~/.vnc/xstartup

# Neutralize .xsession to prevent XFCE from being launched twice
cat > ~/.xsession <<EOF
#!/data/data/com.termux/files/usr/bin/sh
exit 0
EOF
chmod +x ~/.xsession

# Clean up any stale XRDP or VNC processes and socket files
pkill -9 xrdp; pkill -9 sesman; pkill -9 Xtightvnc; pkill -9 Xvnc; pkill -9 Xorg; pkill -9 vncserver
rm -f ~/.vnc/*:1.pid
rm -f /data/data/com.termux/files/usr/tmp/.X1-lock
rm -f /data/data/com.termux/files/usr/tmp/.X11-unix/X1
rm -f /data/data/com.termux/files/usr/var/run/xrdp-sesman.pid

# Restart VNC server on display :1 with desired screen size
vncserver -kill :1 >/dev/null 2>&1
vncserver :1 -geometry 1280x720 -localhost no

# Write XRDP configuration file
cat > ../usr/etc/xrdp/xrdp.ini << 'EOF'
[Globals]
ini_version=1
fork=true
port=3389
tcp_nodelay=true
tcp_keepalive=true
security_layer=negotiate
crypt_level=high
certificate=
key_file=
ssl_protocols=TLSv1.2, TLSv1.3
autorun=
allow_channels=true
allow_multimon=true
bitmap_cache=true
bitmap_compression=true
bulk_compression=true
max_bpp=32
new_cursors=true
use_fastpath=both
grey=e1e1e1
dark_grey=b4b4b4
blue=0078d7
dark_blue=0078d7
ls_top_window_bg_color=003057
ls_width=350
ls_height=360
ls_bg_color=f0f0f0
ls_logo_filename=
ls_logo_transform=scale
ls_logo_width=250
ls_logo_height=110
ls_logo_x_pos=55
ls_logo_y_pos=35
ls_label_x_pos=30
ls_label_width=68
ls_input_x_pos=110
ls_input_width=210
ls_input_y_pos=158
ls_btn_ok_x_pos=142
ls_btn_ok_y_pos=308
ls_btn_ok_width=85
ls_btn_ok_height=30
ls_btn_cancel_x_pos=237
ls_btn_cancel_y_pos=308
ls_btn_cancel_width=85
ls_btn_cancel_height=30

[Logging]
LogFile=xrdp.log
LogLevel=DEBUG
EnableSyslog=false

[LoggingPerLogger]

[Channels]
rdpdr=true
rdpsnd=true
drdynvc=true
cliprdr=true
rail=true
xrdpvr=true

[Xvnc]
name=Xvnc
lib=libvnc.so
username=ask
password=ask
ip=127.0.0.1
port=5901
EOF

# Start XRDP services
xrdp-sesman
xrdp

# Create an alias to start xrdp easier in the future
echo 'alias startxrdp="pkill -9 xrdp; pkill -9 sesman; pkill -9 Xtightvnc; pkill -9 Xvnc; pkill -9 Xorg; pkill -9 vncserver; rm -f ~/.vnc/*:1.pid /data/data/com.termux/files/usr/tmp/.X1-lock /data/data/com.termux/files/usr/tmp/.X11-unix/X1 /data/data/com.termux/files/usr/var/run/xrdp-sesman.pid; vncserver -kill :1 >/dev/null 2>&1; vncserver :1 -geometry 1280x720 -localhost no; xrdp-sesman; xrdp"' >> ~/.bashrc

# Create an alias to quickly stop xrdp and cleanup locks / processes
echo 'alias stopxrdp="pkill -9 xrdp; pkill -9 sesman; pkill -9 Xtightvnc; pkill -9 Xvnc; pkill -9 Xorg; pkill -9 vncserver; rm -f ~/.vnc/*:1.pid /data/data/com.termux/files/usr/tmp/.X1-lock /data/data/com.termux/files/usr/tmp/.X11-unix/X1 /data/data/com.termux/files/usr/var/run/xrdp-sesman.pid"' >> ~/.bashrc

source ~/.bashrc

