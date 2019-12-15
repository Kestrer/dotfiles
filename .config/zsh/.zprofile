# ~/.zprofile: executed by the command interpreter for login shells.

for script in $ZDOTDIR/zprofile.d/*
do
	source $script
done
