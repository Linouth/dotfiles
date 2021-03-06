#!/usr/bin/env bash

source "$HOME/.scripts/colors.sh"

# Geometry
xoff=0
yoff=0
width=$(xrandr | awk '{if ($3=="primary") print $4}' | awk 'BEGIN{FS="x"}{print $1}')
height=40

# Fonts
font1="Hack:size=10"
font2="Knack Nerd Font Mono:size=16"
#font1="Hack:size=9"
# font2="-wuncon-siji-medium-r-normal--10-100-75-75-c-80-iso10646-1"

sh $HOME/.config/lemonbar/topbar.sh | lemonbar -f "$font1" -o -8 -f "$font2" -o -1 -F $foreground -B $background -g "${width}x${height}+$xoff+$yoff" -o 1 -u 2 | while read action; do
    case "$action" in

    "mute")
        amixer -q -c 0 set Master toggle
        ;;
    esac
done
