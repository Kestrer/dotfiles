# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
	# include .bashrc if it exists
	if [ -f "$HOME/.bashrc" ]; then
		. "$HOME/.bashrc"
	fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
	PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
	PATH="$HOME/.local/bin:$PATH"
fi

# set path
export PATH=$PATH:/opt/bin:$HOME/.cargo/bin

# set XDG variables
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DATA_DIRS="/usr/local/share/:/usr/share/"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CONFIG_DIRS="/etc/xdg"
export XDG_CACHE_HOME="$HOME/.cache"

# set more env variables
export VISUAL='nvim'
export EDITOR="$VISUAL"
export BROWSER='qutebrowser'

# setup SSH
SSH_ENV="$HOME/.ssh/environment"
function start_agent {
	echo "Initialising new SSH agent..."
	/usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
	echo succeeded
	chmod 600 "${SSH_ENV}"
	. "${SSH_ENV}" > /dev/null
	/usr/bin/ssh-add ~/.ssh/github_rsa;
}
# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
	. "${SSH_ENV}" > /dev/null
	ps h ${SSH_AGENT_PID} > /dev/null || start_agent
else
	start_agent
fi

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
	mkdir /tmp/downloads
	exec startx
fi

