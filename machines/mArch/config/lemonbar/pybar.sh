#!/bin/zsh

# Script location
SCRIPT="~/src/Python/LemonBar/bar.py"

# Panel size
PW=2560
PH=20
PX=0
PY=0

# Fonts
FONT1="-wuncon-siji-medium-r-normal--10-100-75-75-c-80-iso10646-1"
FONT2="-gohu-gohufont-medium-r-normal--11-80-100-100-c-60-iso10646-1"

# Colors
BG="#181818"


# python "$(SCRIPT)" | lemonbar -g ${PW}x${PH}+${PX}+${PY} -f "$FONT2" -f "$FONT1" -B "$BG" -p
python ~/src/Python/LemonBar/bar.py | lemonbar -g ${PW}x${PH}+${PX}+${PY} -f "$FONT2" -f "$FONT1" -B "$BG" -p
