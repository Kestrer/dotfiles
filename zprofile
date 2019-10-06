# ~/.zprofile: executed by the command interpreter for login shells.

for script in $ZDOTDIR/scripts/*
do
	source $script
done
