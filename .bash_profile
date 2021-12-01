# ~/.bash_profile: executed by bash for login shells.
if [ -n "${SSH_TTY}" ]; then
	echo .bash_profile
fi	

if [ -n "${TMUX}" ]; then
	. ~/.bashrc	
else

echo "bash_profile"

# export ENV=dev
#export dash_dir=~/vcswork/dasht
#export PATH=${PATH}:${dash_dir}/bin
#export MANPATH=${MANPATH}:${dash_dir}/man


. ~/.bashrc

fi

[[ -s "/Users/s10479/.gvm/scripts/gvm" ]] && source "/Users/s10479/.gvm/scripts/gvm"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/s10479/Dropbox/My Mac (CACF-181)/Downloads/tmp/google-cloud-sdk/path.bash.inc' ]; then . '/Users/s10479/Dropbox/My Mac (CACF-181)/Downloads/tmp/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/s10479/Dropbox/My Mac (CACF-181)/Downloads/tmp/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/s10479/Dropbox/My Mac (CACF-181)/Downloads/tmp/google-cloud-sdk/completion.bash.inc'; fi
