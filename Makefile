all:

install: all
	mkdir -p \
		${HOME}/.local/share \
		${HOME}/.config/dunst \
		${HOME}/.config/i3 \
		${HOME}/.config/i3status \
		${HOME}/.config/nvim \
		${HOME}/.config/qutebrowser \
		${HOME}/.config/rofi \
		${HOME}/.config/sxhkd \
		${HOME}/.config/X11 \
		${HOME}/.config/Xmodmap \
		${HOME}/.config/zsh
	
	-ln -s ${PWD}/applications    ${HOME}/.local/share/applications
	-ln -s ${PWD}/dunstrc         ${HOME}/.config/dunst/dunstrc
	-ln -s ${PWD}/i3              ${HOME}/.config/i3/config
	-ln -s ${PWD}/i3status        ${HOME}/.config/i3status/config
	-ln -s ${PWD}/init.vim        ${HOME}/.config/nvim/init.vim
	-ln -s ${PWD}/quickmarks      ${HOME}/.config/qutebrowser/quickmarks
	-ln -s ${PWD}/qutebrowser.yml ${HOME}/.config/qutebrowser/autoconfig.yml
	-ln -s ${PWD}/rofi            ${HOME}/.config/rofi/config
	-ln -s ${PWD}/scripts         ${HOME}/.config/zsh/scripts
	-ln -s ${PWD}/sxhkdrc         ${HOME}/.config/sxhkd/sxhkdrc
	-ln -s ${PWD}/xinitrc         ${HOME}/.config/X11/xinitrc
	-ln -s ${PWD}/xserverrc       ${HOME}/.config/X11/xserverrc
	-ln -s ${PWD}/Xmodmap         ${HOME}/.config/Xmodmap/Xmodmap
	-ln -s ${PWD}/zprofile        ${HOME}/.config/zsh/.zprofile
	-ln -s ${PWD}/zshenv          ${HOME}/.zshenv
	-ln -s ${PWD}/zshrc           ${HOME}/.config/zsh/.zshrc

uninstall:
	rm -r \
		${HOME}/.local/share/applications \
		${HOME}/.config/dunst/dunstrc \
		${HOME}/.config/i3/config \
		${HOME}/.config/i3status/config \
		${HOME}/.config/nvim/init.vim \
		${HOME}/.config/qutebrowser/quickmarks \
		${HOME}/.config/qutebrowser/autoconfig.yml \
		${HOME}/.config/rofi/config \
		${HOME}/.config/sxhkd/sxhkdrc \
		${HOME}/.config/zsh \
		${HOME}/.config/X11 \
		${HOME}/.config/Xmodmap \
		${HOME}/.zshenv
