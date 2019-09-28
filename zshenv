# environment variables

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
	PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
	PATH="$HOME/.local/bin:$PATH"
fi

# set PATH so it includes optional bin if it exists
if [ -d "/opt/bin" ]; then
	PATH="/opt/bin:$PATH"
fi

# set XDG variables
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DATA_DIRS="/usr/local/share/:/usr/share/"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CONFIG_DIRS="/etc/xdg"
export XDG_CACHE_HOME="$HOME/.cache"

# set software
export VISUAL='nvim'
export EDITOR="$VISUAL"
export BROWSER='qutebrowser'
export TERMINAL='st'
export READER='zathura'
export SHELL='zsh'

# other
export ZDOTDIR="$HOME/.config/zsh"
