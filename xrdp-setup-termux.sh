pkg update -y && pkg install x11-repo -y && pkg install -y xfce4 xfce4-goodies xfce4-terminal xfce4-whiskermenu-plugin xrdp dbus

mkdir -p ~/.vnc

cat > ~/.vnc/xstartup <<EOF
#!/data/data/com.termux/files/usr/bin/sh
exit 0
EOF
chmod +x ~/.vnc/xstartup

cat > ~/.xsession <<EOF
#!/data/data/com.termux/files/usr/bin/sh
export DISPLAY=:0
export XDG_RUNTIME_DIR="/data/data/com.termux/files/usr/tmp"
eval "\$(dbus-launch --exit-with-session --print-address)"
export DBUS_SESSION_BUS_ADDRESS
exec startxfce4
EOF
chmod +x ~/.xsession

pkill -9 xrdp; pkill -9 sesman; pkill -9 Xtightvnc; pkill -9 Xvnc; pkill -9 Xorg; pkill -9 vncserver
rm -f ~/.vnc/*:1.pid
rm -f /data/data/com.termux/files/usr/tmp/.X1-lock
rm -f /data/data/com.termux/files/usr/tmp/.X11-unix/X1
rm -f /data/data/com.termux/files/usr/var/run/xrdp-sesman.pid

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

[Xorg]
name=Xorg
lib=libxorgxrdp.so
username=ask
password=ask
ip=127.0.0.1
port=-1
code=20
EOF

xrdp-sesman
xrdp
