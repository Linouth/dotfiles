#!/bin/zsh

# Bulk of the code by 'logicnotlogical'

# Server to ping
pingserver=217.21.198.152

# Color Directory
CD="$HOME/.Xresources"

# Fetch the colors
BG=$(cat ${CD} | grep -i background | tail -c 8)
#BG="#00000000"
#BG="#18181800"
#FG=$(cat ${CD} | grep -i foreground | tail -c 8)
FG=#d8d8d8

BLACK=$(cat ${CD} | grep -i color8 | tail -c 8)
RED=$(cat ${CD} | grep -i color9 | tail -c 8)
GREEN=$(cat ${CD} | grep -i color10 | tail -c 8)
YELLOW=$(cat ${CD} | grep -i color11 | tail -c 8)
BLUE=$(cat ${CD} | grep -i color12 | tail -c 8)
MAGENTA=$(cat ${CD} | grep -i color13 | tail -c 8)
CYAN=$(cat ${CD} | grep -i color14 | tail -c 8)
WHITE=$(cat ${CD} | grep -i color15 | tail -c 8)

# Fonts
FONT1="-wuncon-siji-medium-r-normal--10-100-75-75-c-80-iso10646-1"
FONT2="-gohu-gohufont-medium-r-normal--11-80-100-100-c-60-iso10646-1"

# Panel size
PW=1920
PH=20
PX=0
PY=0


# Actions
VOLT="amixer sset Master toggle"
VOLU="amixer sset Master 2+"
VOLD="amixer sset Master 2-"
TMUS="mpc toggle"
NMUS="mpc next"



# Functions

ws1() {
	ws1=$(i3-msg -t get_outputs | sed 's/.*1080},"current_workspace":"\([^"]*\)".*/\1/')
	echo "%{F${BLUE}}${ws1}"
}
ws2() {
	ws2=$(i3-msg -t get_outputs | sed 's/.*768},"current_workspace":"\([^"]*\)".*/\1/')
	echo "%{F${BLUE}}${ws2}"
}

music() {
	# music=$(n=$(mpc current); if [ -z "$n" ] ; then echo; else echo -e "\ue05c $n    "; fi)
    q=$(shuf -n 1 ~/Documents/quotes.txt)
    quote=$(while [ $(echo $q | head -c 1) == '#' ] ; do echo; done; echo $q)


    if [ ! -z "$music" ]; then
        echo "%{F${CYAN}}${music}"
    else
        echo "%{F${CYAN}}${quote}    "
    fi
}

mem() {
	mem=$(free -m | awk '(NR>1)&&(NR<3) {print $3}')
	echo -e "%{F${RED}}\ue028 ${mem}M"
}

ip() {
	#ipaddr=$(ip=$(ip addr | grep enp3s0 | grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])' | awk '(NR<2)'); if [ ! -z "$ip" ]; then echo "$ip"; else echo "No Connection";fi)
    ipaddr=''
	ping=$(pn=$(timeout .8 ping ${pingserver} -c 1 -s 24 | sed '2!d;s/.*time=\([0-9]*\).*/\1/'); if [ -z $pn ] ; then echo "No Connection"; else echo "${pn}ms"; fi)
	echo -e "%{F${CYAN}}\ue09f ${ipaddr}  \ue048 ${ping}"
}

clock() {
	clock=$(date "+%d %b %Y  %H:%M")
	echo "%{F${YELLOW}}${clock}"
}

vol() {
	vol=$(amixer get 'Master' | grep 'Front Left:' | sed 's/ *Front Left: .* \[\([^ ]*\)\] \[[^ ]*\] \[\([^ ]*\)\]/\1 \2/;s/.*off/off/;s/\([^ ]*\).*/\1/')
	echo -e "%{F${RED}}\ue05d ${vol}"
}



while :; do
	echo "  $(ws1)      %{A1:$TMUS:}%{A3:$NMUS:}$(music)%{A}%{A}%{A1:$VOLT:}%{A4:$VOLU:}%{A5:$VOLD:}$(vol) %{A}%{A}%{A} %{c}$(clock)      %{r}$(mem)    $(ip)      $(ws2)  "
	sleep .5
done | lemonbar -g ${PW}x${PH}+${PX}+${PY} -f "$FONT2" -f "$FONT1" -B "$BG" -F "$FG" -p | while :; do read line; eval $line; done &
