# setup SSH
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
	echo "Initialising new SSH agent..."
	/usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
	echo succeeded
	chmod 600 "${SSH_ENV}"
	source "${SSH_ENV}" > /dev/null
	/usr/bin/ssh-add ~/.ssh/github_rsa;
}

# source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
	source "${SSH_ENV}" > /dev/null
	ps h ${SSH_AGENT_PID} > /dev/null || start_agent
else
	start_agent
fi
