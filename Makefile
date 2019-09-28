all:

install: all
	mkdir -p ${HOME}/.config/dunst
	mkdir -p ${HOME}/.config/i3
	mkdir -p ${HOME}/.config/i3status
	mkdir -p ${HOME}/.config/nvim
	mkdir -p ${HOME}/.config/qutebrowser
	mkdir -p ${HOME}/.config/rofi
	mkdir -p ${HOME}/.config/Xmodmap
	mkdir -p ${HOME}/.config/zsh
	
	-ln -s ${PWD}/dunstrc         ${HOME}/.config/dunst/dunstrc
	-ln -s ${PWD}/i3              ${HOME}/.config/i3/config
	-ln -s ${PWD}/i3status        ${HOME}/.config/i3status/config
	-ln -s ${PWD}/init.vim        ${HOME}/.config/nvim/init.vim
	-ln -s ${PWD}/quickmarks      ${HOME}/.config/qutebrowser/quickmarks
	-ln -s ${PWD}/qutebrowser.yml ${HOME}/.config/qutebrowser/autoconfig.yml
	-ln -s ${PWD}/rofi            ${HOME}/.config/rofi/config
	-ln -s ${PWD}/xinitrc         ${HOME}/.xinitrc
	-ln -s ${PWD}/Xmodmap         ${HOME}/.config/Xmodmap/Xmodmap
	-ln -s ${PWD}/zprofile        ${HOME}/.config/zsh/.zprofile
	-ln -s ${PWD}/zshenv          ${HOME}/.config/zsh/.zshenv
	-ln -s ${PWD}/zshrc           ${HOME}/.config/zsh/.zshrc
	
	-ln -s ${HOME}/.config/zsh/.zprofile ${HOME}/.zprofile

uninstall:
	rm ${HOME}/.config/dunst/dunstrc
	rm ${HOME}/.config/i3/config
	rm ${HOME}/.config/i3status/config
	rm ${HOME}/.config/nvim/init.vim
	rm ${HOME}/.config/qutebrowser/quickmarks
	rm ${HOME}/.config/qutebrowser/autoconfig.yml
	rm ${HOME}/.config/rofi/config
	rm ${HOME}/.xinitrc
	rm ${HOME}/.config/Xmodmap/Xmodmap
	rm ${HOME}/.config/zsh/.zprofile
	rm ${HOME}/.config/zsh/.zshenv
	rm ${HOME}/.config/zsh/.zshrc
	rm ${HOME}/.zprofile
