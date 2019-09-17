# If not running interactively, don't do anything
case $- in
	*i*) ;;
	  *) return;;
esac

HISTCONTROL=ignoreboth # don't put duplicate lines or lines starting with space in the history.
HISTIGNORE=fg:clear # ignore these commands
shopt -s histappend # append to the history file, don't overwrite it

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s checkwinsize # check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
shopt -s globstar # "**" matches ligerally everything
shopt -s cdspell # i cant spel

# set prompt message (blue path name followed by regular $)
PS1='\[\033[01;34m\]\w\[\033[m\]\$ '

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -aFlh'
alias l='ls -aFlh'

# Add an "alert" alias for long running commands. Use like so:
# $ sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable this if it's already enabled in /etc/bash.bashrc and /etc/profile sources /etc/bash.bashrc).
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

ase-export() {
	aseprite -b --split-layers --all-layers aseprite/$1.aseprite --sheet $1.png > /dev/null
}

pretex () {
	pdflatex -halt-on-error *.tex | grep '^!.*' -A200 --color=always
	pdflatex -halt-on-error *.tex | grep '^!.*' -A200 --color=always
	zathura *.pdf
}

premd() {
	pandoc $1 > /tmp/premd.html
	$BROWSER /tmp/premd.html
}

wman () {
	name="$(man -w $1)"
	if [[ $name == *.gz ]]; then
		page="$(zcat $name)"
	else
		page="$(cat $name)"
	fi
	echo "$page" | groff -mandoc -Thtml > /tmp/manpage.html
	$BROWSER /tmp/manpage.html &
}

cf () {
	$EDITOR ~/code/dotfiles
}

pubip () {
	curl https://ipinfo.io/ip
}

mkdir () { # "mkdir -c" mkdirs and cds
	case $1 in
		(-c) command mkdir -p "$2" && cd "$2";;
		 (*) command mkdir "$@";;
	esac
}

alias ..='cd ..'
alias ,,='cd -'

alias se="sudo $EDITOR"
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

sclear () {
	for ((i=1;i<=500;i++))
	do
		echo ----------------
	done
	clear
}

set -o vi

