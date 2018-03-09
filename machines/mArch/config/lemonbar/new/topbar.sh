#!/usr/bin/env bash

# Colors
source "$HOME/.scripts/colors.sh"
accent="%{F$highlights}"
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
    mmb=${mkb:0:-3}
    echo -e "$accent\ue020$text ${mmb}M"
}

song() {
    songv=$(mpc current)
    playing=$(mpc status | grep -o 'playing')

    if [ ! -z $playing ]; then
        echo -e "|  $accent\ue05c$text $songv"
    else
        echo ''
    fi
}

i3() {
    ws=$(i3-msg -t get_workspaces)
    out="%{U$highlights}"

    for i in $1; do
        t=$(grep -o -P "\"num\":$i.*?(\"rect\")" <<< $ws)
        if [ ! -z $t ]; then
            # Workspace not empty
            v=$(grep -o '"visible":true' <<< $t)
            if [ ! -z $v ]; then
                # Workspace is visible
                out="$out$accent%{!u} \u2b24 %{!u}$text"
            else
                # Workspace not visible
                out="$out \u2b24 "
            fi
        else
            # Workspace empty
            out="$out \u2b55 "
        fi
    done

    out="$out%{U-}"
    echo -e "$out"
}


# Timeout function
t=0
timeout() {
    if [ $(($t+$1)) -lt $(date +%s) ]; then
        false
    else
        true
    fi
}

tickerloc="/tmp/"
default="ethereum"
ticker() {
    if [ ! -z $1 ]; then
        default="$1"
    fi
    tickerloc="${tickerloc}cmc.$default"

    usd=$(cat $tickerloc | jq -r '.[0].price_usd')
    btc=$(cat $tickerloc | jq -r '.[0].price_btc')
    sym=$(cat $tickerloc | jq -r '.[0].symbol')

    echo -e "${accent}$sym$text $btc"
}

updateticker() {
    if [ ! -z $1 ]; then
        default="$1"
    fi
    f="${tickerloc}cmc.$default"
    
    src="https://api.coinmarketcap.com/v1/ticker/$default/"
    res=$(curl -s $src > $f)
}

updatetickers() {
    if timeout 30; then
        echo "Updated" 1>&2
        t=$(date +%s)

        updateticker district0x
        updateticker basic-attention-token
    fi
}


tmp="%{U$highlights}%{F$highlights}%{!u} \u2b24 %{F-}%{!u} \u2b24  \u2b55  \u2b55  \u2b55 "
while true; do
    i3l="$(i3 '1 2 3 4 5')"
    i3r="$(i3 '6 7 8 9 0')"

    echo -e "%{l}    $i3l  |  %{A:mute:}$(vol)%{A}  $(song) %{c}$(clock) - $(cal) %{r}$(mem)  |  $i3r    "
    sleep 0.2
    t=$(date +%s)
done
