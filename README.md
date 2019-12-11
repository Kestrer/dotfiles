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
chmod 755 /usr/local/bin/dmenu
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
```
cd ~/.local/src
git clone https://github.com/icymind/NeoSolarized
ln -s ~/.local/src/NeoSolarized/colors/NeoSolarized.vim ~/.config/nvim/colors/
```
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
```
cd ~/.local/src
git clone https://git.suckless.org/st
cd st
curl https://st.suckless.org/patches/desktopentry/st-desktopentry-0.8.2.diff -o st-desktopentry-0.8.2.diff
curl https://st.suckless.org/patches/newterm/st-newterm-0.8.2.diff -o st-newterm-0.8.2.diff
curl https://st.suckless.org/patches/scrollback/st-scrollback-20190331-21367a0.diff -o st-scrollback-20190331-21367a0.diff
git apply st-desktopenty-0.8.2.diff st-newterm-0.8.2.diff
```
The newterm and scrollback patches conflict with each other. To resolve this, edit `st-scrollback-20190331-21367a0.diff` and do the following:
- Put ` 	{ TERMMOD,              XK_Return,      newterm,        {.i =  0} },` (line 189 of `config.def.h`) between lines 8 and 9 of the patch.
- Put ` void newterm(const Arg *);` (line 84 of `st.h`) between lines 333 and 334 of the patch.
```
git apply st-scrollback-20190331-21367a0.diff
rm config.mk
```
Once you've stow'd the files...
```
cd ~/.local/src/st
make install
```
- stow
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

You also need to run `visudo` and add the line `Defaults env_keep += "HOME"` to make sudo not change the $HOME env variable.

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
