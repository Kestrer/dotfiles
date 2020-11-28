# my dotfiles

Uses GNU Stow; to install, simply run `stow --no-folding .` (make sure **not** to run `stow .`
otherwise bad things will happen), and to uninstall run `stow -D .`.

## Required Software:

- alacritty
- clipmenu (+ xsel + clipnotify, using rofi instead of dmenu)

To use rofi instead of dmenu on Void:
```
> /usr/local/bin/dmenu << EOF
#!/bin/sh
exec rofi -dmenu $@
EOF
chmod 755 /usr/local/bin/dmenu
xbps-remove -F dmenu
```
- dbus
- discount (markdown)
- dunst
- feh
- fontawesome
- fnew (`cargo install fnew`)
- i3status
- i3wm
- jq
- make
- ncurses
- NeoSolarized
```
cd ~/.local/src
git clone https://github.com/icymind/NeoSolarized
ln -s ~/.local/src/NeoSolarized/colors/NeoSolarized.vim ~/.config/nvim/colors/
```
- neovim
- notify-send
- ntp
- pcre2grep
- perl
- qutebrowser
- rofi
- rofi-calc
- rust-analyzer (`cargo install --git https://github.com/rust-analyzer/rust-analyzer rust-analyzer`)
- rustup
- scrot
- slock (with dpms patch)
```
cd ~/.local/src
git clone https://git.suckless.org/slock
cd slock
curl -O https://tools.suckless.org/slock/patches/dpms/slock-dpms-1.4.diff
git apply slock-dpms-1.4.diff
rm config.mk
```
Then edit `slock.c` and remove lines 386 and 387. For some reason, the dpms patch doesn't like it
when you have 0 0 0 dpms timeouts, so I removed that feature lol.

Once you've stow'd the files...
```
cd ~/.local/src/slock
make
sudo make install
```
- stow
- sxhkd
- wkhtmltopdf
- TeX Live
- xbanish
- xclip
- xorg
- yj
- zathura
- zsh
- zsh-syntax-highlighting

## XBPS Command to install basic Void Linux system

	xbps-install GConf acpid alsa-utils avahi base-files btrfs-progs clipmenu clipnotify colord colord-gtk coreutils cups cups-filters cups-pdf curl dash dhcpcd diffutils discount dosfstools dunst e2fsprogs elogind ethtool eudev f2fs-tools feh file findutils font-awesome fontconfig-devel gawk gcc git glibc-locales grep gtklp gzip i3 i3status iana-etc iceauth iproute2 iputils iw jack jq kbd kmod less libX11-devel libXft-devel libXrandr-devel libatomic libgcc libressl linux make man-pages man-pages-devel mdocml mpv ncurses neofetch neovim noto-fonts-emoji ntp openssh pciutils pcre2 pkg-config procps-ng psmisc python-neovim python3-neovim qt5-graphicaleffects qutebrowser rofi rofi-calc runit-void rustup sane scron scrot sed sessreg shadow smproxy stow sudo sxhkd tar traceroute tzdata unzip usbutils util-linux void-repo-nonfree wget which wicd wicd-gtk wifi-firmware wkhtmltopdf wpa_supplicant xauth xbacklight xbanish xbps xclip xclipboard xcursorgen xdpyinfo xev xfsprogs xgamma xhost xinit xkbutils xmodmap xorg-fonts xorg-input-drivers xorg-server xorg-video-drivers xrandr xsane xsel xset xxd yj zathura zathura-pdf-mupdf zsh zsh-syntax-highlighting

You also need to run `visudo` and add the line `Defaults env_keep += "HOME"` to make sudo not change
the $HOME env variable.

## Scripts service

This `scripts` service makes the `/tmp/downloads` directory on boot.

```
cd /etc/sv
mkdir scripts
cd scripts
> run << EOF
#!/bin/sh
set -e

rm -rf /tmp/downloads
mkdir /tmp/downloads
chmod 777 /tmp/downloads
chmod +t /tmp/downloads

exec chpst -b scripts pause
EOF
chmod +x run
cd /var/service
ln -s /etc/sv/scripts .
```

## Extra Software

### Minecraft

```
pinstall openjdk-jre GConf
cd /opt
curl https://launcher.mojang.com/download/Minecraft.tar.gz | tar xvzf -
mkdir -p bin
ln -s minecraft-launcher/minecraft-launcher bin/minecraft
```
