# customizations of the zsh prompt

# colors and prompt
autoload -U colors && colors
PS1="%B%{$fg[blue]%}%~%{$reset_color%}%(!.#.$)%b "

# history
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.cache/zsh/history
HISTORY_IGNORE='fg'
setopt HIST_IGNORE_SPACE

# tab complete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# vi-like keybindings
bindkey -v
# allow deleting to work for stuff I have inputted previously
bindkey -v '^H' backward-delete-char
bindkey -v '^?' backward-delete-char
bindkey -v '^W' backward-kill-word
bindkey -v '^U' kill-line
export KEYTIMEOUT=1

# st-exclusive stuff
if [ $TERM = 'st-256color' ]
then
	# change cursor shape for different vi modes

	function zle-keymap-select() {
		if [[ $KEYMAP == vicmd ]] || [[ $1 = 'block' ]]
		then
			echo -n "\e[1 q"
		elif [[ $KEYMAP == main ]] || [[ $KEYMAP == viins ]] || [[ $KEYMAP = '' ]] || [[ $1 = 'beam' ]]
		then
			echo -n "\e[5 q"
		fi
	}
	zle -N zle-keymap-select
	function zle-line-init() {
		zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
		echo -ne "\e[5 q"
	}
	zle -N zle-line-init
	echo -n "\e[5 q" # use beam shape cursor on startup.
	function preexec() {
		# use beam shape cursor for each new prompt
		echo -n "\e[5 q"

		# set title
		echo -n "\e]0;st: $1\a"
	}
	function precmd() {
		# set terminal title
		printf "\e]0;st: zsh: ${PWD##*/}\a"
	}
fi

# ctrl+e to edit command in nvim
autoload edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line

# make shift+space and alt+space _not_ clear the line
bindkey -s "^[[32;2u" " "
bindkey -s "^[[32;3u" " "

# syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
