# environment variables

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
export SXHKD_SHELL='sh'
export PAGER='less'

# set dirs
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export HISTFILE="$XDG_DATA_HOME/bash/history"
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export MANPATH="$XDG_DATA_HOME/man:${XDG_DATA_DIRS//:/man:}man"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export XSERVERRC="$XDG_CONFIG_HOME/X11/xserverrc"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# path
export PATH="$HOME/.local/bin:$CARGO_HOME/bin:/opt/bin:$PATH"
