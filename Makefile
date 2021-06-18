INSTALL=xbps-install -S

all: essentials misc audio xorg scripts repos dwm t

essentials:
	qutebrowser neovim dmenu urxvt

misc:
	sudo ${INSTALL} stow fzf bat 

audio:
	sudo ${INSTALL} pulseaudio pulsemixer

xorg:
	sudo ${INSTALL} xorg xorg-fonts xorg-server xorg-apps xorg-drivers xclip

scripts:
	[ -d ${HOME}/.local/bin] || mkdir ${HOME}
	git clone git@github.com:gianzav/scripts ${HOME}/.local/bin

repos:
	[ -d ${HOME}/repos] || mkdir ${HOME}/repos

dwm: repos
	git clone git@github.com:gianzav/dwm ${HOME}/repos

t: repos
	git clone git@github.com:sjl/t.git
