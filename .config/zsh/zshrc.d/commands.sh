# useful aliases and functions

alias ll='ls -aFlh'
alias l='ls -aFlh'
CFDIR=$(dirname $(dirname $(dirname $(dirname $(readlink -f ${(%):-%N})))))
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
	alias preinstall="sudo xbps-install -Sf "
	alias plist="xbps-query -m"
	alias plistd="xbps-query -l"
	alias psearch="xbps-query -s "
	alias psearchg="xbps-query -Rs "
	alias pinfo="xbps-query -R "
	alias pupdate="sudo xbps-install -Su xbps; sudo xbps-install -u"
	alias premove="sudo xbps-remove -R "
	alias pclean="sudo xbps-remove -Oo"
fi

# Add an "alert" alias for long running commands. Use like so:
# $ sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# get public IP address
function pubip() {
	curl $@ 'https://ipinfo.io/ip'
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

# display manpage in web browser
function wman() {
	man -cThtml $@ > /tmp/manpage.html
	$BROWSER /tmp/manpage.html
}

# clear the screen completely
function sclear() {
	for ((i=0; i<500; i++))
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
		CFLAGS::=-Weverything -Wno-padded -Wno-disabled-macro-expansion -Wno-cast-qual -g -Og
		CXXFLAGS::=-std=c++2a -Wno-c++98-compat -Wno-c++11-compat -Wno-c++17-compat -Wno-global-constructors
		LIBS::=
		LDFLAGS::=-rdynamic -Wl,-rpath=/usr/local/lib -L/usr/local/lib
		PREFIX::=/usr/local
		EOF
	fi
}

function qutehist() {
	pushd ~/.local/share/qutebrowser

	sqlite3 'history.sqlite' .dump > 'history.dump'
	$VISUAL 'history.dump'
	rm 'history.sqlite'
	sqlite3 'history.sqlite' < 'history.dump'
	rm 'history.dump'

	popd
}

function md2html() {
	markdown -S $1 | perl -0777 -pe 's/^<code>$(.*?)^<\/code>/<code><pre>$1<\/pre><\/code>/gms'
}

function md2pdf() {
	md2html $1 | wkhtmltopdf -s A4 - -
}

function firstpage() {
	if [ $# = 0 ]
	then
		echo "Prints the first page of a command's output."
		return 0
	fi

	set -o pipefail
	sclear
	$SHELL -c "$*" 2>&1 |
		fnew -w "$(tput cols)" |
		head -n $(( $(tput lines) - 1 ))
	set +o pipefail
}

# `crab`, but the first argument provides extra flags to pass to Cargo
function crab-args() {
	if [[ $# = 1 || $2 = \-* ]]
	then
		firstpage "cargo clippy --color=always $1 ${@:2}"
	elif [[ $2 = \+* ]]
	then
		if [[ $# = 2 || $3 = \-* ]]
		then
			firstpage "cargo $2 clippy --color=always $1 ${@:3}"
		else
			firstpage "cargo $2 $3 --color=always $1 ${@:4}"
		fi
	else
		firstpage "cargo $2 --color=always $1 ${@:3}"
	fi
}

# Improved cargo
function crab() {
	crab-args --all-targets $*
}
function crab-st() {
	crab-args '' $*
}
