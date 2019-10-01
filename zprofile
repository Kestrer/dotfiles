# ~/.zprofile: executed by the command interpreter for login shells.

source $HOME/.config/zsh/.zshenv

for script in $ZDOTDIR/scripts/*
do
	source $script
done
