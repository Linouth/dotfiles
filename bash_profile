#
# ~/.bash_profile
#

export PATH=$PATH:$HOME/.bin
export XDG_CONFIG_HOME="$HOME/.config"

[[ -f ~/.bashrc ]] && . ~/.bashrc
#[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
