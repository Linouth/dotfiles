#!/usr/bin/env bash

source "$HOME/.scripts/colors.sh"

# Geometry
x_gap=12
xoff=$x_gap
yoff=5
width=$((2560-(2*x_gap)))
height=25

# Fonts
font1="-gohu-gohufont-medium-r-normal--11-80-100-100-c-60-iso10646-1"
font2="-wuncon-siji-medium-r-normal--10-100-75-75-c-80-iso10646-1"

sh $HOME/.config/lemonbar/new/topbar.sh | lemonbar -f $font1 -f $font2 -F $foreground -g "${width}x${height}+$xoff+$yoff" -o 1
