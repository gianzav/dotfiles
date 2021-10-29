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
	wget https://dl.dafont.com/dl/?f=code_new_roman -O ~/dl/code_new_roman

winedeps:
	sudo pacman -S wine-staging giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls \
		mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error \
		lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo \
		sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama \
		ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gtk3 \
		lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader wine-gecko

# xfce:
# 	xfce4-session xfce4-panel xfdesktop xfwm4 xfce4-settings

rawsync:
	sudo ${INSTALL} abduco acpi alacritty alsa-firmware alsa-utils android-file-transfer \
	android-sdk-platform-tools android-tools anki archlinux-mirrorlist \
	artix-archlinux-support assimp audacity autoconf automake barrier base bat \
	binutils bison bluedevil brave-bin brother-dcp1510 brutal-doom chrony-runit \
	clang connman-runit cronie-runit ctags cups cups-runit dhcpcd discord \
	doomsday dunst efibootmgr elogind-runit esysusers ethtool etmpfiles \
	fakeroot fbida feh file filezilla findutils firefox firejail flex fzf gawk \
	gcc gdm-runit gettext gimp git gradle grep groff grub gzip htop intel-ucode \
	jdk-openjdk latte-dock lib32-giflib lib32-gnutls \
	lib32-gst-plugins-base-libs lib32-gtk3 lib32-libpulse lib32-libva \
	lib32-libxcomposite lib32-libxinerama lib32-libxslt lib32-mpg123 \
	lib32-nvidia-utils lib32-ocl-icd lib32-openal lib32-v4l-utils \
	libreoffice-fresh libtool linux linux-firmware lmms love lua luarocks \
	lutris m4 make man-db man-pages maven mpv neofetch neovim ninja \
	noto-fonts-emoji npm ntfs-3g nvidia nvidia-dkms nvidia-settings ocl-icd \
	openssh openssh-runit os-prober pacman pacman-contrib pandoc patch \
	pavucontrol pcmanfm picom pkgconf pop-gtk-theme pulseaudio pulseaudio-alsa \
	pulsemixer python-pip qmk qutebrowser redshift rsync runit samba \
	samba-runit scrcpy scrot sed shellcheck socklog steam stow sudo sxhkd sxiv \
	texinfo texlive-core texlive-latexextra tigervnc tmate ttf-dejavu \
	ttf-font-awesome typescript udevil ungoogled-chromium unrar unzip vim \
	virtualbox w3m wget which wine wine-gecko wine-mono winetricks wireshark-qt \
	wkhtmltopdf x11vnc xclip xdg-user-dirs xdotool xf86-video-vesa \
	xorg-bdftopcf xorg-docs xorg-font-util xorg-fonts-100dpi xorg-fonts-75dpi \
	xorg-iceauth xorg-mkfontscale xorg-server-devel xorg-server-xephyr \
	xorg-server-xnest xorg-server-xvfb xorg-sessreg xorg-smproxy xorg-x11perf \
	xorg-xauth xorg-xbacklight xorg-xcmsdb xorg-xcursorgen xorg-xdpyinfo \
	xorg-xdriinfo xorg-xev xorg-xgamma xorg-xhost xorg-xinit xorg-xinput \
	xorg-xkbevd xorg-xkbutils xorg-xkill xorg-xlsatoms xorg-xlsclients \
	xorg-xmodmap xorg-xpr xorg-xrandr xorg-xrdb xorg-xrefresh xorg-xsetroot \
	xorg-xvinfo xorg-xwayland xorg-xwd xorg-xwininfo xorg-xwud xterm yay \
	youtube-dl zathura zathura-pdf-mupdf
