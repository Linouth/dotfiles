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
    mmb=${mkb:0:-3}
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

t=0
updatetickers() {
    timeout=30

    if [ $(($t+$timeout)) -lt $(date +%s) ]; then
        echo "Updated" 1>&2
        t=$(date +%s)

        updateticker district0x
        updateticker basic-attention-token
    fi
}


while true; do
    # updatetickers
    # echo "%{l}  $(clock)   $(cal) %{r}$(song)   $(vol)   $(mem)   $(ticker basic-attention-token) $(ticker district0x)  "
    echo "%{l}%{B$background}   1  %{R} $(hostname) %{R}  $(mem)    $(vol)    %{B-} %{c}%{B$background}%{B-} %{r}%{B$background}   $(clock)    $(cal)   %{B-}"
    sleep 0.2
done
