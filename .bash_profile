# ~/.bash_profile: executed by bash for login shells.
if [ -n "${SSH_TTY}" ]; then
	echo .bash_profile
fi	

if [ -n "${TMUX}" ]; then
	. ~/.bashrc	
else

echo "bash_profile"

# export ENV=dev
export dash_dir=~/vcswork/dasht
export PATH=${PATH}:${dash_dir}/bin
export MANPATH=${MANPATH}:${dash_dir}/man

eval "$(direnv hook bash)"

export PYTHONPATH=.
eval "$(pyenv init -)"
eval "$(rbenv init -)"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
export PYENV_ROOT=~/.pyenv

# export NODEBREW_ROOT=/usr/local/var/nodebrew
export PATH=${PATH}:~/.nodenv/bin
eval "$(nodenv init -)"

if [ -d ~/.pyenv ]; then
	export PATH=${PATH}:~/.pyenv/bin
	eval "$(pyenv init -)" 
fi

export profile="yes"

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

. ~/.bashrc

fi
