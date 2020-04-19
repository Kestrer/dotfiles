# startx if on display one
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
	exec xinit -- :1
fi
