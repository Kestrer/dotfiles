# environment variables

# set XDG variables
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DATA_DIRS="/usr/local/share/:/usr/share/"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CONFIG_DIRS="/etc/xdg"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DOWNLOAD_DIR="/tmp/downloads"


# set dirs
export ASPELL_CONF="per-conf $XDG_CONFIG_HOME/aspell/aspell.conf; personal $XDG_CONFIG_HOME/aspell/en.pws; repl $XDG_CONFIG_HOME/aspell/en.prepl"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export HISTFILE="$XDG_DATA_HOME/bash/history"
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export MANPATH="$XDG_DATA_HOME/man:${XDG_DATA_DIRS//:/man:}man:$XDG_DATA_HOME/rustup/toolchains/stable-x86_64-unknown-linux-gnu/share/man:$XDG_DATA_HOME/npm/share/man"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/startup.py"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export TERMINFO="$XDG_DATA_HOME/terminfo"
export TERMINFO_DIRS="$TERMINFO:/usr/share/terminfo"
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export XSERVERRC="$XDG_CONFIG_HOME/X11/xserverrc"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# set software
export VISUAL='nvim'
export EDITOR="$VISUAL"
export BROWSER='qutebrowser'
export TERMINAL='st'
export READER='zathura'
export SHELL='zsh'
export SXHKD_SHELL='sh'
export PAGER='less'

# path
export PATH="$HOME/.local/bin:$CARGO_HOME/bin:$XDG_DATA_HOME/npm/bin:/opt/bin:$PATH"
export CPATH="/usr/lib/R/include/"
export C_INCLUDE_PATH="$CPATH"
export CPLUS_INCLUDE_PATH="$CPATH"
export GCC_INCLUDE_DIR="$CPATH"
