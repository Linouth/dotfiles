#!/usr/bin/env bash

source "$HOME/.scripts/colors.sh"

# Geometry
width=2560
height=25
xoff=0
yoff=0

# Fonts
font1="-gohu-gohufont-medium-r-normal--11-80-100-100-c-60-iso10646-1"
font2="-wuncon-siji-medium-r-normal--10-100-75-75-c-80-iso10646-1"

sh $HOME/.config/lemonbar/topbar.sh | lemonbar -f $font1 -f $font2 -F $foreground -g "${width}x${height}+$xoff+$yoff" -p -o 5
