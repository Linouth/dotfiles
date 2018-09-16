#!/usr/bin/env bash

# Colors
source "$HOME/.scripts/colors.sh"
# accent="%{F$highlights}"
accent="%{F$foreground}"
text="%{F$foreground}"

interface=$(ip link | grep -Po '2: \K(.*)(?=:)')


clock() {
    t=$(date "+%_H:%M")
    # echo -e "$accent\uf017$text $t"
    echo -e "$t"
}

cal() {
    d=$(date "+%a, %d %b")
    # echo -e "$accent\ue26a$text $d"
    echo -e "$d"
}

vol() {
    level=$(amixer get Master | grep -oP '[\d]+%')
    off=$(amixer get Master | grep 'off')

    if [ -z "$off" ]; then
        echo -e "\uf028 $level"
    else
        echo -e "\uf026 m"
    fi
}

mem() {
    mkb=$(cat /proc/meminfo | awk '/Active:/{print $2}')
    mmb=${mkb:0:-3}
    echo -e "\uf472 ${mmb}M"
}

song() {
    playing=$(playerctl status 2>/dev/null | grep -o 'Playing')
    artist=$(playerctl metadata artist 2>/dev/null)
    title=$(playerctl metadata title 2>/dev/null)

    if [ ! -z $playing ]; then
        echo -e "$accent\u25b6$text $artist - $title"
    else
        echo ''
    fi
}

i3() {
    ws=$(i3-msg -t get_workspaces)
    out="%{U$background}"

    for i in $1; do
        t=$(grep -o -P "\"num\":$i.*?(\"rect\")" <<< $ws)
        if [ ! -z $t ]; then
            # Workspace not empty
            v=$(grep -o '"visible":true' <<< $t)
            if [ ! -z $v ]; then
                # Workspace is visible
                # out="$out$accent%{!u} $i %{!u}$text"
                out="$out %{!u}\u25cf%{!u}"
            else
                # Workspace not visible
                # out="$out $i "
                out="$out \u25cf"
            fi
        else
            # Workspace empty
            out="$out \u25cb"
        fi
    done

    out="$out%{U-}"
    echo -e "$out$text"
}

wifi() {
    ssid=$(iw dev $interface link | grep -Po "SSID: \K.*$")

    if [ -z "$ssid" ]; then
        ssid="N/A"
    fi

    echo -e "\uf012 $ssid"
}

battery() {
    acpi=$(acpi)
    charging=$(grep 'Charging' <<< $acpi)
    perc=$(cut -d',' -f2 <<< $acpi | grep -oP '[\d]+')
    icons="\uf244 \uf243 \uf242 \uf241 \uf240"
    icount=$(wc -w <<< $icons)
    
    num=$(awk -v perc=$perc -v icount=$icount 'BEGIN {printf "%1.0f", perc/100*(icount-1)+1}')

    if [ ! -z "$charging" ]; then
        # Charging
        icon='\uf1e6'
    else
        # Discharging
        icon=$(cut -d' ' -f$num <<< $icons)
    fi
    echo -e "$icon $perc%"
}


while true; do
    i3l="$(i3 '1 2 3 4 5 6 7 8 9 0')"

    echo -e "%{l}%{R} $i3l  %{B-}%{F-}  $(song) %{c}$(cal), $(clock) %{r}$(wifi)  %{R}  %{A:mute:}$(vol)%{A}  $(mem)  $(battery)  %{B-}%{F-}"
    sleep 0.1
done
