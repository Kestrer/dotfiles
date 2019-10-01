# startx if on display one
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
	mkdir -p /tmp/downloads
	exec startx
fi

source $ZDOTDIR/.zshrc
