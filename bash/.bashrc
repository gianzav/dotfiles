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


# ENV VARIABLES

export PS1="[$green\W$nocolor]\n> "
export HISTFILE="$HOME/.cache/bash_history"
export PAGER="less"
export READER="zathura"
export JAVA_HOME="/usr/lib/jvm/java-14-openjdk"

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
export PATH="$PATH:$HOME/.local/bin:/usr/bin/node:/usr/bin/npm:$HOME/.emacs.d/bin/:"

# Default web browser
export BROWSER='qutebrowser'

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
alias sc="cd $HOME/.local/bin/"
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias dmesg='dmesg -He'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias md='mkdir'
alias update-grub='grub-mkconfig -o /boot/grub/grub.cfg'
# alias exmon='xrandr --auto && xrandr --output HDMI-A-0 --right-of eDP'
alias clang++='clang++ -std=c++11'
alias bt="bluetoothctl power on && bluetoothctl devices | dmenu | cut -d' ' -f2 | xargs bluetoothctl connect"

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

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"
