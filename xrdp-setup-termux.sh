#!/data/data/com.termux/files/usr/bin/sh
pkg update -y && pkg install x11-repo -y && pkg install -y xfce4 xfce4-goodies xfce4-terminal xfce4-whiskermenu-plugin tigervnc xrdp
vncpasswd
mkdir -p ~/.vnc
cat > ~/.vnc/xstartup << 'EOF'
#!/data/data/com.termux/files/usr/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
export XDG_RUNTIME_DIR="$HOME/.cache"
exec startxfce4
EOF
chmod +x ~/.vnc/xstartup
cat > ~/.xsession << 'EOF'
#!/data/data/com.termux/files/usr/bin/sh
exec startxfce4
EOF
chmod +x ~/.xsession
pkill -9 xrdp sesman Xtightvnc Xvnc Xorg vncserver 2>/dev/null
rm -f ~/.vnc/*:1.pid /data/data/com.termux/files/usr/tmp/.X1-lock /data/data/com.termux/files/usr/tmp/.X11-unix/X1 /data/data/com.termux/files/usr/var/run/xrdp-sesman.pid
vncserver -geometry 1280x720 :1
cat > /data/data/com.termux/files/usr/etc/xrdp/xrdp.ini << 'EOF'
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

[Logging]
LogFile=xrdp.log
LogLevel=INFO
EnableSyslog=false

[Channels]
rdpdr=true
rdpsnd=true
drdynvc=true
cliprdr=true
rail=true
xrdpvr=true

[Xvnc]
name=VNC-Passthrough
lib=libvnc.so
username=
password=
ip=127.0.0.1
port=5901
EOF
xrdp-sesman
xrdp
