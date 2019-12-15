# zshrc

# profile
source $ZDOTDIR/.zprofile

for script in $ZDOTDIR/zshrc.d/*
do
	source $script
done
