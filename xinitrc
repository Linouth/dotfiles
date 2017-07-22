#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# resourcestheme=$HOME/ricing/Xresources/.active

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -I$HOME/.dotfiles/Xresources -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# if [ -f "$resourcestheme" ]; then
#     xrdb -merge "$resourcestheme"
# fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

#xrandr --output DVI-I-1 --mode 1024x768 --pos 1920x150 --output DVI-D-1 --mode 1920x1080 --pos 0x0 --primary --output HDMI-1 --off &
xrandr --output DP-1.8 --mode 2560x1440 --primary --output DVI-D-0 --mode 1920x1080 --pos 2560x180 --output HDMI-1 --off &
mopidy &

xinput --set-prop 18 'libinput Accel Speed' -0.9 &
xkbcomp -w 0 ~/.config/xkbmap $DISPLAY
exec i3 
