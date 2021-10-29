#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && source ~/.bashrc
sh -c 'source /etc/profile'

# User directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# System directories
export XDG_DATA_DIRS="/usr/local/share:/usr/share"
export XDG_CONFIG_DIRS="/etc/xdg"

# Xserver-related init files
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export XSERVERRC="$XDG_CONFIG_HOME/X11/xserverrc"

# alias to move quickly to university notes
alias uni="cd /home/gianluca/Documents/Uni/classnotes/"

# Start Xserver on startup looking in the XDG compliant directories
if [[ $(tty) = "/dev/tty1" ]]; then

    [[ -x /usr/bin/gnome-session || -x /usr/local/bin/gnome-session ]] && has_gnome=0 || has_gnome=1
    [[ -x /usr/local/bin/dwm || -x /usr/bin/dwm ]] && has_dwm=0 || has_dwm=1
    [[ -x /usr/bin/xfce4-session || -x /usr/local/bin/xfce4-session ]] && has_xfce=0 || has_xfce=1
    [[ -x /usr/bin/plasmashell || -x /usr/local/bin/plasmashell ]] && has_kde=0 || has_kde=1

    echo "Choose an option:"
    [[ $has_gnome -eq 0 ]] && echo "1) gnome"
    [[ $has_dwm -eq 0 ]] && echo "2) dwm"
    [[ $has_xfce -eq 0 ]] && echo "3) xfce4"
    [[ $has_kde -eq 0 ]] && echo "4) kde"

    read choice
    if [[ $choice -eq 1 ]]; then
        choice="gnome"
    elif [[ $choice -eq 2 ]]; then
        choice="dwm"
    elif [[ $choice -eq 3 ]]; then
        choice="xfce"
    elif [[ $choice -eq 4 ]]; then
        choice="plasma"
    else
        choice="dwm"
    fi
    
	exec startx "$XDG_CONFIG_HOME/X11/xinitrc" "$choice" -- "$XDG_CONFIG_HOME/X11/xserverrc" vt1
fi
