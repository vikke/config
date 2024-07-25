#!/usr/bin/env bash 

# $Id: .bashrc 582 2011-02-15 23:27:26Z vikke $
# $HeadURL: https://psb.vikke.mydns.jp/svn/vikke_env/.bashrc $
echo .bashrc

# if [ -n "${SSH_TTY}" ]; then
#	echo .bashrc
# fi

## path周りの設定が、すべてunix styleで定義してあるので、
## classpath等が重要なjava,javac,javadocは、wrapper scrpitを
## 作成し、cygpathで変換すること。
## TOMCATのscript類も同じ。

#if [ -z $L ]
#then
	if [ -e /etc/profile ];then
		. /etc/profile
	fi
#	source ${HOME}/.bash_profile
#fi


if [ -e /etc/bash_completion ]; then
	. /etc/bash_completion
fi

# Windows用pathを退避
if [ -z "${WINPATH}" -a "$OSTYPE" == "cygwin" ]; then
	export WINPATH=${PATH}
fi

export PATH=${PATH}:${HOME}/bin:${HOME}/dbin:${HOME}/bin_local:${HOME}/local/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:/usr/X11R6/bin:/usr/games

if [ -n $PERL_MM_OPT ]; then
	unset PERL_LOCAL_LIB_ROOT
	unset PERL_MM_OPT
	unset PERL_MB_OPT
	unset PERL5LIB
fi

export TZ=Asia/Tokyo

case $OSTYPE in
	darwin*)
		# macports installer addition on 2009-09-20_at_00:46:05: adding an appropriate path variable for use with macports.
		# こっちオリジナルだけど、pathが小文字なんでちょっと修正
		# export path=/opt/local/bin:/opt/local/sbin:$path
		export PATH=${PATH}:/opt/local/bin:/opt/local/sbin:/opt/homebrew/bin
		# finished adapting your path environment variable for use with macports.
		export cocot="cocot"
		export LANG=ja_JP.utf-8
#		alias urxvt="urxvt -e \'/Library/Frameworks/UIM.framework/Versions/1.6.0/bin/uim-fep\'"

		# export JAVA_HOME=$(/usr/libexec/java_home -v 9)
		export _JAVA_OPTIONS="-Dfile.encoding=UTF-8"
#		export MAVEN_HOME=/opt/local/share/java/maven2
		MYSQL_BASE=/opt/local

		[[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && . "$(brew --prefix)/etc/profile.d/bash_completion.sh"

		export LSCOLORS=gxfxcxdxbxegedabagacad
		alias ls='ls -G'
		export HADOOP_HOME=/usr/local/Cellar/hadoop/2.7.3

		# brew
		export PATH=${PATH}:$(brew --prefix)/opt/redis@3.2/bin
		export PATH=${PATH}:/usr/local/opt/postgresql@12/bin
		export PATH="${PATH}:/usr/local/opt/gettext/bin"
		export PATH="${PATH}:/usr/local/opt/gpg-agent/bin"
		export PATH="${PATH}:/usr/local/opt/postgresql@9.5/bin"
		export LDFLAGS="-L/usr/local/opt/openssl/lib"
		export CPPFLAGS="-I/usr/local/opt/openssl/include"
		export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig"
		export HOMEBREW_NO_ANALYTICS=1
		export PATH="${PATH}:/usr/local/opt/mysql-client@5.7/bin"
		# node
		export PATH="${PATH}:/usr/local/opt/node@8/bin"
		export PATH="${PATH}:/opt/homebrew/bin"
		;;

	[cC][yY][gG][wW][iI][nN])
		export LANG=ja_JP.UTF-8

		# lsの日本語表示
		alias ls='ls --show-control-chars -F'

		# lessの日本語
		export PAGER="less"
		export LESSCHARSET=dos

		# cvsのeditor呼び出しを正常にできるように(cygwinはunix pathでtmp
		# fileを作ろうとする)tmp fileを明示的に指定
		alias cvs="cvs -qT \"`cygpath -w ${HOME}/tmp`\""
		alias vim="gvim"
		# cmd.exeのstartの代替
		alias st=cygstart

		# Windowsで設定しているTMP環境変数を退避
		export WTEMP=$TMP
		export JDK_DIR=/cygdrive/c/jdk
		export CATALINA_HOME=/cygdrive/c/svr/Tomcat5.5
		export TOMCAT_HOME=${CATALINA_HOME}
		export workspace=/cygdrive/c/workspace

		export VIMPATH="${HOME}/apl/vim73-kaoriya-win64/gvim"

		export ECLIPSE_HOME=${HOME}/win32/eclipse3
		cocot="cocot"

		PATH=${VIMPATH%/gvim}:${HOME}/bin/windows:${PATH}
		PATH=${PATH}:/cygdrive/c/Program\ Files/Microsoft\ Visual\ SourceSafe

		;;

	freebsd*)
		alias ls='ls -F'
		alias jman='env LC_CTYPE=ja_JP.eucJP jman'
#		export LANG=ja_JP.eucJP
		export LV='-Iej -Ou8'
		export LANG=ja_JP.UTF-8
		export PAGER="lv -c"

		export VIMPATH=vim
		export JDK_DIR=/usr/local/jdk1.5.0
		export ECLIPSE_HOME=${HOME}/win32/eclipse3
		cocot="cocot -t UTF-8"
		export TMP=/tmp
		export PATH=${PATH}:/usr/local/sbin
		MYSQL_BASE=/usr/local/mysql
		;;

	linux*)
		alias ls='ls --color=auto -F'
		export JDK_DIR=/usr/lib/jvm
		export PAGER="lv -c"

		export TMP=~/tmpfs
		PATH=${PATH}:/usr/local/mysql/bin
		export MAVEN_HOME=${HOME}/dev-tools/apache-maven-3.0.3
		export LANG=ja_JP.UTF-8

		export PATH="${PATH}:${HOME}/.linuxbrew/bin"
		export PATH=${PATH}:/usr/local/node-v4.6.0-linux-x64/bin
		export MANPATH="${HOME}/.linuxbrew/share/man:$MANPATH"
		export INFOPATH="${HOME}/.linuxbrew/share/info:$INFOPATH"

		export HADOOP_HOME=/usr/lib/hadoop

		export PATH=${PATH}:~/.rbenv/bin

		export PATH="${PATH}:${HOME}/.pyenv/bin"

		xrdb -load ~/.Xdefaults
		;;

	*)
		;;
esac

export EDITOR=nvim
alias vim=nvim
alias mysql=mycli

ulimit -c unlimited

if [ -e ~/vcswork/bash-wakatime/bash-wakatime.sh ]; then
	. ~/vcswork/bash-wakatime/bash-wakatime.sh
fi

if [ -n "${SSH_TTY}" ]; then

	# xtermのwindow titleにhost名を出力する設定。
	export xterm_title="\033]2; ${HOSTNAME}\007"
	echo -e ${xterm_title}

fi

# ctrl-sでterminalがlockしないようにする。
# stty -ixon
stty stop undef

# command履歴共有
export HISTFILE=~/.HISTFILE
export HISTSIZE=10000
function share_history {
    history -a
    history -c
    history -r
}
PROMPT_COMMAND='share_history'
shopt -u histappend
shopt -s globstar

# 履歴で、空行の場合と、同じコマンドが続けて2回目の場合は履歴に入れないようにする。
export HISTCONTROL=ignoredups

#export RUBYLIB=/usr/lib/ruby/gems/1.8/gems/tidy-1.1.2/lib
#export RUBYOPT=rubygems
export TAGDIR=${HOME}/tags

#export PS1='\n\u@\h:\w\n$(branch=$(git branch -a 2>/dev/null | grep "^*" | tr -d "\\* "); if [ "${branch}" != "" ];then echo "[\[\033[0;31m\]${branch}\[\033[0;00m\]] "; fi)\$ '
#export PS1='\n\u@\h:\w\n$(branch=$(git branch -a 2>/dev/null | grep "^*" | tr -d "\\* "); if [ "${branch}" != "" ];then echo "[\e[0;31m\]${branch}\e[m]"; fi)\$ '
export PS1='\n\u@\h:\w\n$(branch=$(git branch -a 2>/dev/null | grep "^*" | tr -d "\\* "); if [ "${branch}" != "" ];then echo "[${branch}]"; fi)\$ '

export RSYNC_RSH=ssh

export XDEBUG_CONFIG="idekey=DBGP"
export XDEBUG_SESSION_START=DBGP

export XDG_CONFIG_HOME=${HOME}/.config
export XDG_DATA_DIRS=${XDG_DATA_DIRS}:${HOME}/.local/share/flatpak/exports/share

PATH=${PATH}:~/bin-nongit
PATH=${PATH}:~/.embulk/bin
PATH=${PATH}:/nvim-linux64/bin

if [ -n "${WINPATH}" ]; then
	PATH=${PATH}:${WINPATH}
fi
export PATH

if [ -f ${HOME}/.gpg-agent-info ] && \
		ps axo 'pid' | grep -q `cut -d: -f 2 ${HOME}/.gpg-agent-info` ;then
	. ${HOME}/.gpg-agent-info
	export GPG_TTY=`tty`
	export GPG_AGENT_INFO
else
	eval `gpg-agent --default-cache-ttl 7200 --daemon --no-grab --write-env-file $HOME/.gpg-agent-info`
	export GPG_TTY=`tty`
	export GPG_AGENT_INFO
fi

if [ -n "${DESKTOP_SESSION}" ] && [ -n "${GNOME_KEYRING_PID}"  ]; then
	eval $(gnome-keyring-daemon --start --components=gpg,ssh)
	export SSH_AUTH_SOCK
fi

alias rcoverage='if [ -d coverage ]; then rm -rf coverage; fi; COVERAGE=boo bundle exec rspec --no-drb'
alias rspec='bundle exec rspec'
alias rake='bundle exec rake'
alias rails='bundle exec rails'
alias ssh_copy_id='ssh-copy-id -i ~/.ssh/id_rsa.pub '

if [ -e /usr/share/doc/tig-1.0/contrib/tig-completion.bash ]; then
	. /usr/share/doc/tig-1.0/contrib/tig-completion.bash
fi

ls ~/bash_misc_func/*.sh >/dev/null 2>&1
if [ $? -eq 0 ]; then
	for f in ~/bash_misc_func/*.sh;do
		. ${f}
	done
fi

ls ~/misc-env/*.sh >/dev/null 2>&1
if [ $? -eq 0 ]; then
	for f in ~/misc-env/*.sh;do
		. ${f}
	done
fi

### Added by the Heroku Toolbelt
export PATH="${PATH}:/usr/local/heroku/bin"

function se(){
	fs=$(ag "$1" ~/vcswork/dsp-wo-doc | fzf-tmux)
	vim ${fs%%:*}
}

# for fzf
# https://github.com/junegunn/fzf/issues/39
set -o vi

export PATH=${PATH}:~/.fzf/bin

# fzf ######################################################
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_OPTS='-m --color dark'

# file edit.
fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# fd - cd to selected directory. including hidden directories
fd() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf-tmux +m) && cd "$dir"
}

fdel() {
  local dirs
  dirs=$(find ${1:-.} -type d 2> /dev/null | fzf-tmux -m) && rm -rf ${dirs}
}

fdi() {
	local file
	local dir
	file=$(fzf-tmux +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

# fkill - kill process
fkill() {
  pid=$(ps -ef | sed 1d | fzf-tmux -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    kill -${1:-9} $pid
  fi
}

# fgbr - checkout git branch (including remote branches)
gbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

gdel() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -m -d $(( 2 + $(wc -l <<< "$branches") )) ) &&
  git branch -d $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

gdeldel() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -m -d $(( 2 + $(wc -l <<< "$branches") )) ) &&
  git branch -D $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fco - checkout git branch/tag
gco() {
  local tags branches target
  tags=$(
    git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(
    git branch --all | grep -v HEAD             |
    sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
    sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
    (echo "$tags"; echo "$branches") |
    fzf-tmux  -- --no-hscroll --ansi +m -d "\t" -n 2) || return
  git checkout $(echo "$target" | awk '{print $2}')
}

# fshow - git commit browser
gshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf-tmux --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

plist() {
	val=${1}
	ps auxww | grep -v 'grep' | grep -e "${val}"
}

pkill() {
	for pid in $(plist "$1" | awk  '{print $2}'); do
		kill ${pid}
	done
}

fkill() {
	ps aux | fzf | sed 's/  */ /g' | cut -d ' ' -f2 | xargs kill -KILL
}

# docker ###########################################
docker_del_all_container() {
	docker rm $(docker ps -a -q)	
}
docker_del_all_img() {
	docker rmi $(docker images -q)
}

sp_test() {
	docker compose exec web bin/rspec spec/services/mask_db/ spec/lib/utils/db_mask_util_spec.rb 
}
sp_reset_db() {
	docker compose exec web script/local_reset_test_dbs.sh

}
sp_bundle_install() {
	docker compose exec web bundle install
}
sp_rubocop_develop() {
	git diff --name-only develop | grep -E '.*\.rb'| xargs rubocop  -A
}

# dasht ############################################
# export PATH=$HOME/.nodebrew/current/bin:$PATH

export GO111MODULE=on
export GOPRIVATE="github.com/ca-crowdfunding/*,github.com/vikke/*"

eval "$(direnv hook bash)"

# export NODEBREW_ROOT=/usr/local/var/nodebrew
# export PATH=${PATH}:~/.nodenv/bin
# eval "$(nodenv init -)"


eval $(pyenv init --path)
eval "$(pyenv init -)" 
export PYENV_ROOT=$(pyenv root)

export profile="yes"

export AppData=${HOME}/AppData
export TEMP=/tmp

export PATH=${PATH}:$(brew --prefix)/opt/mysql-client/bin
export PATH=$(brew --prefix)/bin:${PATH}
eval "$(rbenv init -)"

if [ ${TERM} == 'xterm-256color' ]; then
	eval $(ssh-agent)
fi

[[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && . "$(brew --prefix)/etc/profile.d/bash_completion.sh"

source /Users/vikke/.docker/init-bash.sh || true # Added by Docker Desktop
source ~/google-cloud-sdk/completion.bash.inc

export PATH=${PATH}:~/google-cloud-sdk/bin
# asdf
. "/opt/homebrew/opt/asdf/libexec/asdf.sh"
. "/opt/homebrew/opt/asdf/etc/bash_completion.d/asdf.bash"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/vikke/google-cloud-sdk/path.bash.inc' ]; then . '/home/vikke/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/vikke/google-cloud-sdk/completion.bash.inc' ]; then . '/home/vikke/google-cloud-sdk/completion.bash.inc'; fi

export PATH=${PATH}:~/.tfenv/bin
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
