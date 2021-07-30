INSTALL=pacman -S
REPOS=${HOME}/repos

all: user-dirs essentials misc audio xorg scripts repos dwm t fonts

essentials:
	sudo ${INSTALL} qutebrowser dmenu zathura zathura-pdf-mupdf make \
		rsync sxhkd udevil wget

user-dirs:
	mkdir -p ${HOME}/docs ${HOME}/media/pics/wallpapers ${HOME}/media/video ${HOME}/dl || exit 0

misc:
	sudo ${INSTALL} stow fzf bat acpi redshift unrar unzip dunst libnotify

audio:
	sudo ${INSTALL} pulseaudio pulsemixer pulseaudio-alsa alsa-firmware alsa-utils

xorg:
	sudo ${INSTALL} xorg xorg-fonts xorg-server xorg-apps xclip xdg-user-dirs \
		xf86-input-libinput xorg-xinit

scripts:
	[ ! -d ${HOME}/.local/scripts ] && mkdir -p ${HOME}/.local/scripts && git clone https://github.com/gianzav/scripts ${HOME}/.local/scripts \
		|| exit 0

repos:
	[ ! -d ${HOME}/repos] && mkdir ${REPOS} || exit 0

dwm: repos
	[ ! -d ${REPOS}/dwm ] && git clone https://github.com/gianzav/dwm ${REPOS}/dwm || exit 0

t: repos
	[ ! -d ${REPOS}/t ] && git clone https://github.com/sjl/t.git ${REPOS}/t || exit 0

nvim-plugins: repos
	[ ! -d ${REPOS}/lua-language-server ] && git clone https://github.com/sumneko/lua-language-server ${REPOS}/lua-language-server || exit 0

dev:
	sudo ${INSTALL} ctags jdb jdk-openjdk jre-openjdk-headless python3

fonts: essentials
	# noto-fonts noto
	wget https://dl.dafont.com/dl/?f=code_new_roman

wallpapers: essentials user-dirs
	wget https://wallpapers.com/images/file/aesthetic-skyway-bridge-8j7aqjd01ip3apsz.jpg media/pics/wallpapers/skyway_bridge.jpg
	
