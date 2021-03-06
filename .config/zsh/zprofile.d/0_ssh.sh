# start ssh agent
OLDAGENT="$HOME/.ssh/oldagent"

function startssh() {
	ssh-agent > $OLDAGENT
	source $OLDAGENT
	ssh-add $HOME/.ssh/*_id
}

if [ -f $OLDAGENT ]
then
	source "$OLDAGENT" > /dev/null
	ps $SSH_AGENT_PID > /dev/null || startssh
else
	startssh
fi
