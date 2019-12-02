# my dotfiles

Uses GNU Stow; to install, simply run `stow .`, and to uninstall run `stow -D .`.

## Required Software:

- clipmenu (+ xsel + clipnotify, using rofi instead of dmenu)

To use rofi instead of dmenu on Void:
```
> /usr/local/bin/dmenu << EOF
#!/bin/sh
exec rofi -dmenu $@
EOF
xbps-remove -F dmenu
```
- dbus
- dunst
- feh
- fontawesome
- i3status
- i3wm
- make
- NeoSolarized
- neovim
- notify-send
- pcre2grep
- qutebrowser
- rofi
- rofi-calc
- scrot
- slock (with dpms patch)
```
cd ~/.local/src
git clone https://git.suckless.org/slock
cd slock
curl https://tools.suckless.org/slock/patches/dpms/slock-dpms-1.4.diff -o slock-dpms-1.4.diff
git apply slock-dpms-1.4.diff
rm config.mk
```
Then edit `slock.c` and remove lines 386 and 387. For some reason, the dpms patch doesn't like it when you have 0 0 0 dpms timeouts, so I removed that feature lol.

Once you've stow'd the files...
```
cd ~/.local/src/slock
make
sudo make install
```
- st (with scrollback + solarized patch)
- sxhkd
- TeX Live
- xbanish
- xclip
- xorg
- zathura
- zsh
- zsh-syntax-highlighting

## XBPS Command to install basic Void Linux system

	xbps-install ConsoleKit2 ImageMagick acpid avahi base-files btrfs-progs clipmenu clipnotify colord colord-gtk coreutils cups cups-filters cups-pdf curl dash diffutils dosfstools dunst e2fsprogs eudev f2fs-tools feh file findutils font-awesome gawk git glibc-locales grep grub gtklp gzip i3 i3status iana-etc iceauth iproute2 iputils iw jack kbd kmod less libressl linux make man-pages-devel mdocml mpv ncurses neovim noto-fonts-emoji openssh pandoc pciutils pcre2 pkg-config pulseaudio qutebrowser rofi rofi-calc runit-void scron scrot sed sessreg shadow smproxy sudo sxhkd tar texlive-bin traceroute tzdata usbutils util-linux valgrind wget which wicd-gtk wifi-firmware xauth xbacklight xbanish xbps xclip xclipboard xcursorgen xdpyinfo xfsprogs xgamma xhost xinit xkbutils xmodmap xorg-fonts xorg-input-drivers xorg-server xorg-video-drivers xrandr xsel xset xxd youtube-dl zathura zathura-pdf-mupdf zsh zsh-syntax-highlighting

## Extra Software

### Minecraft

```
pinstall openjdk-jre GConf
cd /opt
curl https://launcher.mojang.com/download/Minecraft.tar.gz -o Minecraft.tar.gz
tar xvzf Minecraft.tar.gz
mkdir -p bin
ln -s minecraft-launcher/minecraft-launcher bin/minecraft
```
