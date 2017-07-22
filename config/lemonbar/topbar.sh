#!/usr/bin/env bash

# Colors
source "$HOME/.scripts/colors.sh"
accent="%{F$color12}"
text="%{F$foreground}"


clock() {
    t=$(date "+%_H:%M")
    echo -e "$accent\ue017$text $t"
}

cal() {
    d=$(date "+%a, %d %b")
    echo -e "$accent\ue26a$text $d"
}

vol() {
    level=$(amixer get Master | awk '/Front Left:/{gsub(/[\[\]]/, "", $5); print $5}')
    on=$(amixer get Master | awk '/Front Left:/{gsub(/[\[\]]/, "", $7); print $7}')
    fp=$(amixer get 'Front Panel' | awk '/Mono:/{gsub(/[\[\]]/, "", $3); print $3}')

    echo -n $accent
    if [ $fp == 'on' ]; then
        echo -n -e '\ue04d'
    else
        echo -n -e '\ue05d'
    fi

    echo -n "$text "
    if [ $on == 'on' ]; then
        echo $level
    else
        echo 'm'
    fi
}

mem() {
    mkb=$(cat /proc/meminfo | awk '/Active:/{print $2}')
    mmb=${mkb:0:4}
    echo -e "$accent\ue020$text ${mmb}M"
}

song() {
    songv=$(mpc current)
    playing=$(mpc status | grep -o 'playing')

    if [ ! -z $playing ]; then
        echo -e "$accent\ue05c$text $songv"
    else
        echo ''
    fi
}


while true; do
    echo "%{l}  $(clock)   $(cal) %{r}$(song)   $(vol)   $(mem)  "
    sleep 0.2
done
