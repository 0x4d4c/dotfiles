dbus-update-activation-environment --systemd DISPLAY
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

xrdb -load "${HOME}/.Xresources"

xrandr --auto

exec i3 -V > ${HOME}/i3.log 2>&1; logout

