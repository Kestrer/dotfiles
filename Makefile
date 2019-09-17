all:

install:
	mkdir -p ${HOME}/.config/dunst
	mkdir -p ${HOME}/.config/i3
	mkdir -p ${HOME}/.config/i3status
	mkdir -p ${HOME}/.config/nvim
	mkdir -p ${HOME}/.config/qutebrowser
	mkdir -p ${HOME}/.config/rofi
	
	-ln -s ${PWD}/bashrc          ${HOME}/.bashrc
	-ln -s ${PWD}/dunstrc         ${HOME}/.config/dunst/dunstrc
	-ln -s ${PWD}/i3              ${HOME}/.config/i3/config
	-ln -s ${PWD}/i3status        ${HOME}/.config/i3status/config
	-ln -s ${PWD}/init.vim        ${HOME}/.config/nvim/init.vim
	-ln -s ${PWD}/profile         ${HOME}/.profile
	-ln -s ${PWD}/quickmarks      ${HOME}/.config/qutebrowser/quickmarks
	-ln -s ${PWD}/qutebrowser.yml ${HOME}/.config/qutebrowser/autoconfig.yml
	-ln -s ${PWD}/rofi            ${HOME}/.config/rofi/config
	-ln -s ${PWD}/xinitrc         ${HOME}/.xinitrc
	-ln -s ${PWD}/Xmodmap         ${HOME}/.Xmodmap
	-echo '. ~/.profile' > ${HOME}/.bash_profile
