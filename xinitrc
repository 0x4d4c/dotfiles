
xrdb -load "${HOME}/.Xresources"

xrandr --auto

exec i3 -V > ${HOME}/i3.log 2>&1; logout

