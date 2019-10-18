# zshrc

# colors and prompt
autoload -U colors && colors
PS1="%B%{$fg[blue]%}%~%{$reset_color%}%(!.#.$)%b "

# history
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.cache/zsh/history
HISTORY_IGNORE='fg'
setopt HIST_IGNORE_SPACE

# enable spelling correction
setopt correctall

# command variations
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias pcre2grep='pcre2grep --color=auto'
alias xclip="xclip -selection clipboard"
# "mkdir -c" mkdirs and cds
function mkdir() {
	case $1 in
		(-c) command mkdir -p "$2" && cd "$2";;
		 (*) command mkdir "$@";;
	esac
}

# useful aliases
alias ll='ls -aFlh'
alias l='ls -aFlh'
CFDIR=$(dirname $(readlink -f ${(%):-%N}))
alias cf="cd $CFDIR; $VISUAL ."
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ,,='cd -'
alias se="sudo $VISUAL"

# package manager commands
if [ -x "$(command -v xbps-install)" ]
then
	alias pinstall="sudo xbps-install -S "
	alias plist="xbps-query -l"
	alias psearch="xbps-query -s "
	alias psearchg="xbps-query -Rs "
	alias pinfo="xbps-query -R "
	alias pupdate="sudo xbps-install -Su"
	alias premove="sudo xbps-remove -R "
	alias pclean="sudo xbps-remove -Oo"
elif [ -x "$(command -v apt)" ]
then
	alias pinstall="sudo apt install "
	alias psearch="sudo apt search "
	alias pupdate="sudo apt update && sudo apt upgrade"
	alias premove="sudo apt remove "
elif [ -x "$(command -v pacman)" ]
then
	alias pinstall="sudo pacman -S "
	alias psearch="sudo pacman -Ss "
	alias pupdate="sudo pacman -Syu"
	alias premove="sudo pacman -Rs "
fi

# Add an "alert" alias for long running commands. Use like so:
# $ sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# get public IP address
function pubip() {
	curl 'https://ipinfo.io/ip'
}

# export aseprite
function ase-export() {
	aseprite -b --split-layers --all-layers aseprite/$1.aseprite --sheet $1.png > /dev/null
}

# convert tex to pdf
function pretex() {
	pdflatex -halt-on-error *.tex | grep '^!.*' -A200 --color=always
	pdflatex -halt-on-error *.tex | grep '^!.*' -A200 --color=always
	$READER *.pdf
}

# display markdown
function premd() {
	pandoc $1 > /tmp/premd.html
	$BROWSER /tmp/premd.html
}

# fine: more useful find
function fine() {
	find . -mount -name $@ 2>/dev/null
}

# display manpage in web browser
function wman() {
	man -cThtml $@ > /tmp/manpage.html
	$BROWSER /tmp/manpage.html
}

# clear the screen completely
function sclear() {
	for ((i=0; i<200; i++))
	do
		echo
	done
	echoti clear
}

function cmk() {
	# hardlink so that git commits correctly
	ln -f $CFDIR/c.mk Makefile

	BASENAME=$(basename $(pwd))
	> .gitignore <<- EOF
	.gitignore
	build
	$BASENAME
	lib$BASENAME.a
	lib$BASENAME.so
	EOF

	if [[ ! -a config.mk ]]
	then
		> config.mk <<- EOF
		CC::=clang
		CXX::=clang++
		CFLAGS::=-Weverything -Werror -Wno-padded -Wno-disabled-macro-expansion -Wno-cast-qual -g -Og
		CXXFLAGS::=-std=c++2a -Wno-c++98-compat -Wno-c++11-compat -Wno-c++17-compat -Wno-global-constructors
		LIBS::=
		LDFLAGS::=-rdynamic -Wl,-rpath=/usr/local/lib -L/usr/local/lib

		PREFIX::=/usr/local
		EOF
	fi
}

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

# syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
