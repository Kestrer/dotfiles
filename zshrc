# zshrc

# colors and prompt
autoload -U colors && colors
PS1="%B%{$fg[blue]%}%~%{$reset_color%}$%b "

# history
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.cache/zsh/history
HISTORY_IGNORE='fg'
setopt HIST_IGNORE_SPACE

# enable spelling correction
setopt correctall

# color support
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias pcre2grep='pcre2grep --color=auto'

# useful aliases
alias ll='ls -aFlh'
alias l='ls -aFlh'
CFDIR=$(dirname $(readlink -f ${(%):-%N}))
alias cf="cd $CFDIR; $VISUAL ."
alias pubip='curl https://ipinfo.io/ip'
alias ..='cd ..'
alias ,,='cd -'
alias se="sudo $VISUAL"
alias copy="xclip -selection clipboard"

# package manager commands
if [ -x "$(command -v xbps-install)" ]
then
	alias pinstall="sudo xbps-install -S "
	alias psearch="sudo xbps-query -Rs "
	alias pupdate="sudo xbps-install -Su"
	alias premove="sudo xbps-remove -R "
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

function ase-export() {
	aseprite -b --split-layers --all-layers aseprite/$1.aseprite --sheet $1.png > /dev/null
}

function pretex() {
	pdflatex -halt-on-error *.tex | grep '^!.*' -A200 --color=always
	pdflatex -halt-on-error *.tex | grep '^!.*' -A200 --color=always
	zathura *.pdf
}

function premd() {
	pandoc $1 > /tmp/premd.html
	$BROWSER /tmp/premd.html
}

function wman () {
	name="$(man -w $1)"
	if [[ $name == *.gz ]]; then
		page="$(zcat $name)"
	else
		page="$(cat $name)"
	fi
	echo "$page" | groff -mandoc -Thtml > /tmp/manpage.html
	$BROWSER /tmp/manpage.html &
}

function mkdir () { # "mkdir -c" mkdirs and cds
	case $1 in
		(-c) command mkdir -p "$2" && cd "$2";;
		 (*) command mkdir "$@";;
	esac
}

function sclear () {
	for ((i=1;i<=500;i++))
	do
		echo ----------------
	done
	clear
}

function cmk () {
	ln -f $CFDIR/c.mk Makefile

	BASENAME=$(basename $(pwd))
	cat > .gitignore <<- EOF
	.gitignore
	objects
	picobjects
	deps
	$BASENAME
	lib$BASENAME.a
	lib$BASENAME.so
	EOF

	if [[ ! -a config.mk ]]
	then
		cat > config.mk <<- EOF
		CC::=clang
		CXX::=clang++
		CFLAGS::=-Wall -Wextra -pedantic -Werror -g -Og
		CXXFLAGS::=-std=c++2a
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

# vi
bindkey -v
# allow deleting to work for stuff I have inputted previously
bindkey -v '^H' backward-delete-char
bindkey -v '^?' backward-delete-char
bindkey -v '^W' backward-kill-word
bindkey -v '^U' kill-line
export KEYTIMEOUT=1

# change cursor shape for different vi modes; doesn't work on Linux console
if [ $TERM = 'st-256color' ]
then
	function zle-keymap-select {
		if [[ ${KEYMAP} == vicmd ]] ||
			 [[ $1 = 'block' ]]; then
			echo -ne '\e[1 q'
		elif [[ ${KEYMAP} == main ]] ||
			 [[ ${KEYMAP} == viins ]] ||
			 [[ ${KEYMAP} = '' ]] ||
			 [[ $1 = 'beam' ]]; then
			echo -ne '\e[5 q'
		fi
	}
	zle -N zle-keymap-select
	zle-line-init() {
		zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
		echo -ne "\e[5 q"
	}
	zle -N zle-line-init
	echo -ne '\e[5 q' # Use beam shape cursor on startup.
	preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
fi

# ctrl+e to edit command in nvim
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
