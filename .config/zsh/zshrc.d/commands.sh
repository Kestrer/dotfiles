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
	alias pupdate="sudo xbps-install -u xbps; sudo xbps-install -Su"
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
		CFLAGS::=-Weverything -Werror -Wno-padded -Wno-disabled-macro-expansion -Wno-cast-qual -g -Og
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
	set -o pipefail
	case $# in
		0)
			echo "Prints the first page of a command's output."
			return;;
	esac
	sclear
	$* 2>&1 |
		fnew -w "$(stty size | awk ' { print $2 }')" |
		head -n $(( $(stty size | awk '{ print $1 }') - 1 ))
}

function firstpagec() {
	case $# in
		0)
			echo "Like firstpage, but appends --color=always to the command."
			return;;
	esac
	firstpage $* --color=always
}
