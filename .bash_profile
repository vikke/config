# ~/.bash_profile: executed by bash for login shells.

. ~/.bashrc

[[ -s "~/.gvm/scripts/gvm" ]] && source "~/.gvm/scripts/gvm"


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/vikke/bin/google-cloud-sdk/path.bash.inc' ]; then . '/Users/vikke/bin/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/vikke/bin/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/vikke/bin/google-cloud-sdk/completion.bash.inc'; fi


# uv
export PATH="/home/vikke/.local/bin:$PATH"


# Added by `rbenv init` on 2025年  7月 13日 日曜日 09:10:03 JST
eval "$(rbenv init - --no-rehash bash)"
