all:

install:
	mkdir -p ${HOME}/.config/i3
	mkdir -p ${HOME}/.config/i3status
	mkdir -p ${HOME}/.config/nvim
	
	-ln -s ${PWD}/bashrc   ${HOME}/.bashrc
	-ln -s ${PWD}/i3       ${HOME}/.config/i3/config
	-ln -s ${PWD}/i3status ${HOME}/.config/i3status/config
	-ln -s ${PWD}/init.vim ${HOME}/.config/nvim/init.vim
	-ln -s ${PWD}/profile  ${HOME}/.profile
	-ln -s ${PWD}/xinitrc  ${HOME}/.xinitrc
