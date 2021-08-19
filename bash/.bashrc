# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


nocolor='\[\e[00m\]'
green='\[\e[32m\]'
red='\[\e[31m\]'
blue='\[\e[1;34m\]' # 1 before color means bold


# enable vi-like editing
set -o vi


# JAVA VARIABLES
# export JAR="$HOME/repos/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_*.jar"
# export GRADLE_HOME=$HOME/.gradle
export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:/bin/java::")
# export JDTLS_CONFIG="$HOME/repos/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/config_linux"
# export WORKSPACE=$HOME/dev/workspace

# ENV VARIABLES

export PS1="[$green\W$nocolor]\n> "
export HISTFILE="$HOME/.cache/bash_history"
export PAGER="less"
export READER="zathura"
export TRASH="$HOME/.trash"

# colored man pages (less variables)
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Path to local script in home, to use pywal (color schemes generator)
export PATH="$PATH:$HOME/.local/bin:/usr/bin/node:/usr/bin/npm:$HOME/.local/scripts"

# Default web browser
export BROWSER='brave'
 
# Default terminal
export TERMINAL='alacritty'

# Wallpapers dir
export WALLPAPERS="/home/gianluca/media/pics/wallpapers/"

# setting an alias to use "config" as command to commit dotfiles changes
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

# moving rapidly to university stuff
alias uni="cd $HOME/docs/Uni/classnotes"


# update grub.cfg, root credentials required
alias update-grub="grub-mkconfig -o /boot/grub/grub.cfg"

# alias to fix tlmgr (latex updating script). See [https://wiki.archlinux.org/index.php/TeX_Live]
alias tlmgr='TEXMFDIST/scripts/texlive/tlmgr.pl --usermode'

# other aliases
alias ls="ls --color=auto"
alias zathura="zathura --fork"
alias sc="cd $HOME/.local/scripts/"
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias dmesg='dmesg -He'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias md='mkdir'
alias update-grub='grub-mkconfig -o /boot/grub/grub.cfg'
# alias exmon='xrandr --auto && xrandr --output HDMI-A-0 --right-of eDP'
alias clang++='clang++ -std=c++11'
alias bt="bluetoothctl power on && bluetoothctl devices | dmenu | cut -d' ' -f2 | xargs bluetoothctl connect"
alias e="nvim"

# trash can config
function trashp() {
    mv -v "$@" "$TRASH"
}

function trashc() {
    echo "Do you want to clean the trash can? (y/N)"
    read choice
    [ $choice = "y" || $choice = "yes" ] && rm -rf $TRASH/* || exit 0
}

alias trashl="ls -lah $TRASH"


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='nvim'
fi

# shows the current branch in prompt if in a git repo
function cd() {
    builtin cd $1
    export PS1="[$green\w$nocolor]$red`gitbranch`$nocolor\n> "
}

function cf() {
    cd $(find $HOME/* -type d | fzf --preview="ls --color=always {}")
}

function gmv() {
    mv $@ $(find $HOME/* -type d | fzf)
}

function gr() {
    setsid $READER $@ $(find $HOME/* -name *.pdf | fzf)
}

function gcp() {
    cp $@ $(find $HOME/* -type d | fzf)
}

function finde() {
    $EDITOR $(find ./* -name "*.{md,txt}" | xargs grep -i $1 | cut -d: -f1 | uniq)
}

# qt for 'quick text', find a piece of text quickly and open a vim buffer with it
function qt() {
    f=$(find * -type f | xargs grep -n . | fzf | cut -d : -f 1,2)

    filename=${f%%:*}
    line=${f##*:}

    nvim -c $line $filename
}

# choose interactively the background (mark in sxiv with 'm', only the first
# mark is taken into account)
function bg() {
    wallpaper=$(sxiv -o $WALLPAPERS | head -n 1)
    feh --bg-fill --no-fehbg $wallpaper

    # different separator for sed because wallpaper contains '/'
    sed -i "s|\(feh --no-fehbg --bg-fill\).*|\1 $wallpaper|" $XDG_CONFIG_HOME/X11/xinitrc
}

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

alias luamake=/home/gianluca/repos/lua-language-server/3rd/luamake/luamake
