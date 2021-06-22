INSTALL=pacman -S
REPOS=${HOME}/repos

all: essentials misc audio xorg scripts repos dwm t

essentials:
	sudo ${INSTALL} qutebrowser neovim dmenu urxvt zathura zathura-pdf-mupdf make \
		rsync sxhkd udevil

misc:
	sudo ${INSTALL} stow fzf bat acpi redshift unrar unzip

audio:
	sudo ${INSTALL} pulseaudio pulsemixer

xorg:
	sudo ${INSTALL} xorg xorg-fonts xorg-server xorg-apps xorg-drivers xclip xdg-user-dirs

scripts:
	[ -d ${HOME}/.local/bin] || mkdir ${HOME}
	git clone git@github.com:gianzav/scripts ${HOME}/.local/bin

repos:
	[ -d ${HOME}/repos] || mkdir ${REPOS}

dwm: repos
	git clone git@github.com:gianzav/dwm ${REPOS}

t: repos
	git clone git@github.com:sjl/t.git ${REPOS}

nvim-plugins: repos
	git clone git@github.com:sumneko/lua-language-server ${REPOS}

dev:
	sudo ${INSTALL} ctags jdb jdk-openjdk jre-openjdk-headless python3

fonts:
	noto-fonts noto
