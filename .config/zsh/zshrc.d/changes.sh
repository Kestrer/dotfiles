# changes to commonly used commands

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

function man() {
	MANPAGES="$(find ${(s: :)MANPATH//:/ } -regextype egrep -iregex ".*man/man([0-9]p?)/$1.\\1")"
	if [[ -z "$MANPAGES" ]]
	then
		echo No Manpage Found.
		return
	fi
	mandoc ${(f)MANPAGES} | less
}
