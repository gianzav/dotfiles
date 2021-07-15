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
	exec startx "$XDG_CONFIG_HOME/X11/xinitrc" "dwm" -- "$XDG_CONFIG_HOME/X11/xserverrc" vt1
fi

