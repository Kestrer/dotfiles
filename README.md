# my dotfiles

Just run `make install` to install to your system. Remember to delete your old configs first otherwise it won't install; to do this run `make uninstall`.

## Required Software:

- clipmenu (+ xsel + clipnotify, without dmenu)
- dbus
- dunst
- feh
- fontawesome
- i3status
- i3wm
- make
- neovim
- notify-send
- pcre2grep
- qutebrowser
- rofi
- rofi-calc
- scrot
- slock (with dpms patch)
- st (with scrollback patch)
- sxhkd
- TeX Live
- xbanish
- xclip
- xorg
- zathura
- zsh
- zsh-syntax-highlighting

## XBPS Command to install basic Void Linux system

	xbps-install ConsoleKit2 ImageMagick acpid avahi base-files btrfs-progs clipmenu clipnotify colord colord-gtk coreutils cups cups-filters cups-pdf curl dash diffutils dosfstools dunst e2fsprogs eudev f2fs-tools feh file findutils font-awesome gawk git glibc-locales grep grub gtklp gzip i3 i3status iana-etc iceauth iproute2 iputils iw jack kbd kmod less libressl linux make man-pages-devel mdocml mpv neovim noto-fonts-emoji openssh pandoc pciutils pkg-config pulseaudio qutebrowser rofi rofi-calc runit-void scron scrot sed sessreg shadow smproxy sudo sxhkd tar texlive-bin traceroute tzdata usbutils util-linux valgrind wget which wicd-gtk wifi-firmware xauth xbacklight xbanish xbps xclip xclipboard xcursorgen xdpyinfo xfsprogs xgamma xhost xinit xkbutils xmodmap xorg-fonts xorg-input-drivers xorg-server xorg-video-drivers xrandr xsel xset xxd youtube-dl zathura zathura-pdf-mupdf zsh zsh-syntax-highlighting
	# replace dmenu (used by clipmenu) with rofi
	cat > /usr/local/bin/dmenu << EOF
	#!/bin/sh
	exec rofi -dmenu $@
	EOF
	xbps-remove -F dmenu

### Extra Software

#### SFML

	xbps-install SFML-devel

#### cJSON

	xbps-install cJSON-devel

#### Pcre2

	xbps-install pcre2-devel

#### X

	xbps-install libX11-devel libXft-devel

#### Curl

	xbps-install libcurl-devel

#### LibreOffice Writer

	xbps-install libreoffice-writer libreoffice-i18n-en-GB

#### Musescore

	xbps-install musescore

#### Minecraft

	xbps-install openjdk-jre GConf
	mkdir -p /opt/bin
	curl 'https://launcher.mojang.com/download/Minecraft.tar.gz' > /opt
	tar xvzf /opt/Minecraft.tar.gz
	ln -s /opt/minecraft-launcher/minecraft-launcher /opt/bin/minecraft
