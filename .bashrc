#!/usr/bin/env bash

# $Id: .bashrc 582 2011-02-15 23:27:26Z vikke $
# $HeadURL: https://psb.vikke.mydns.jp/svn/vikke_env/.bashrc $

if [ -z "${PS1}" ]; then
	return
fi

if [ -n "${SSH_TTY}" ]; then
	echo .bashrc
fi

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

PATH=${HOME}/bin:${HOME}/local/bin:/usr/local/bin:/usr/bin:/usr/sbin:/bin:/sbin:/usr/X11R6/bin:/usr/games
if [ -n $PERL_MM_OPT ]; then
	unset PERL_LOCAL_LIB_ROOT
	unset PERL_MM_OPT
	unset PERL_MB_OPT
	unset PERL5LIB
fi

declare -r vcsroot=~/vcswork

case $OSTYPE in
	darwin*)
		# macports installer addition on 2009-09-20_at_00:46:05: adding an appropriate path variable for use with macports.
		# こっちオリジナルだけど、pathが小文字なんでちょっと修正
		# export path=/opt/local/bin:/opt/local/sbin:$path
		export PATH=/opt/local/bin:/opt/local/sbin:$PATH:/Library/Frameworks/UIM.framework/Versions/1.6.0/bin
		# finished adapting your path environment variable for use with macports.
		export cocot="cocot"
		export LANG=ja_JP.utf-8
		alias mysql=mysql5
#		alias urxvt="urxvt -e \'/Library/Frameworks/UIM.framework/Versions/1.6.0/bin/uim-fep\'"
		export VIMPATH=vim

		export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/HOME
		export _JAVA_OPTIONS=-Dfile.encoding=UTF-8
		export MAVEN_HOME=/opt/local/share/java/maven2
		MYSQL_BASE=/opt/local


		;;

	[cC][yY][gG][wW][iI][nN])
		export LANG=ja_JP.UTF-8

		# lsの日本語表示
		alias ls='ls --show-control-chars -F'

		# lessの日本語表示
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

#		export VIMPATH="vim"
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
#		export JAVA_OS=native
#		export JAVA_VENDOR=freebsd
#		export JAVA_VERSION=1.5+
		export ECLIPSE_HOME=${HOME}/win32/eclipse3
		cocot="cocot -t UTF-8"
		export TMP=/tmp
		export PATH=/usr/local/sbin:${PATH}
		MYSQL_BASE=/usr/local/mysql
		;;

	linux*)
		alias ls='ls --color=auto -F'
		export VIMPATH=vim
		export JDK_DIR=/usr/lib/jvm
		export PAGER="lv -c"

		export TMP=~/tmpfs
		PATH=/usr/local/mysql/bin:${PATH}
		export MAVEN_HOME=${HOME}/dev-tools/apache-maven-3.0.3
		;;

	*)
		;;
esac


ulimit -c unlimited

export XMODIFIERS="@im=uim"
ps auxww|grep -v "grep "|grep "uim-xim" -q
if [ $? -ne 0 ];then
	uim-xim &>/dev/null &
fi

#alias tmux='tmux -2 -S /tmp/tmux.session a'
alias tmux='tmux -2 a'

if [ ! -e ~/tmpfs/header_cache ]; then
	cp -r ~/.mutt/header_cache ~/tmpfs
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

#if [ "${TERM}" == "cygwin" ]; then
#	export TERM=vt100
#fi
#if [ -z "${TERM}" ]; then
	#export TERM=rxvt-256color
#fi

#export TERM=xterm-256color

# http://forums.freebsd.org/showthread.php?t=13345 によると、環境変数TERMCAPに値を設定するようにと書いてあるが、不要？
#if [ -e "${HOME}/.termcap" ];then
#	TERMCAP=$(< ${HOME}/.termcap)
#	export TERMCAP
#fi

if [ -n "${SSH_TTY}" ]; then

	# xtermのwindow titleにhost名を出力する設定。
	export xterm_title="\033]2; ${HOSTNAME}\007"
	echo -e ${xterm_title}

fi

# ctrl-sでterminalがlockしないようにする。
stty -ixon

# command履歴共有
export HISTSIZE=9999
function share_history {
    history -a
    history -c
    history -r
}
PROMPT_COMMAND='share_history'
shopt -u histappend
shopt -s globstar

# 履歴で、空行の場合と、同じコマンドが続けて2回目の場合は履歴に入れないようにする。
HISTCONTROL=ignoreboth

#export RUBYLIB=/usr/lib/ruby/gems/1.8/gems/tidy-1.1.2/lib
#export RUBYOPT=rubygems
export TAGDIR=${HOME}/tags

#export PS1='\n\u@\h:\w\n$(branch=$(git branch -a 2>/dev/null | grep "^*" | tr -d "\\* "); if [ "${branch}" != "" ];then echo "[\[\033[0;31m\]${branch}\[\033[0;00m\]] "; fi)\$ '
#export PS1='\n\u@\h:\w\n$(branch=$(git branch -a 2>/dev/null | grep "^*" | tr -d "\\* "); if [ "${branch}" != "" ];then echo "[\e[0;31m\]${branch}\e[m]"; fi)\$ '
export PS1='\n\u@\h:\w\n$(branch=$(git branch -a 2>/dev/null | grep "^*" | tr -d "\\* "); if [ "${branch}" != "" ];then echo "[${branch}]"; fi)\$ '

export RSYNC_RSH=ssh
#export JAVA_HOME=${JDK_DIR}/j2sdk1.4.1_07
#export JAVA_HOME=${JDK_DIR}/j2sdk1.4.2_08
#export JAVA_HOME=${JDK_DIR}/j2sdk1.4.2_10
#export JAVA_HOME=${JDK_DIR}/java-6-sun
#export JAVA_HOME=${JDK_DIR}/java-1.5.0-sun
#export JAVA_HOME=${JDK_DIR}/jdk1.5.0_06
export J2EE_HOME=${JDK_DIR}/j2sdkee1.3.1
export JAVADOC_HOME=${HOME}/doc/javadoc/1.4

export CATALINA_OPTS="-Xms32m -Xmx128m"
export CATALINA_PID=/var/run/catalina.pid
export TOMCAT_OPTS="-Xms32m -Xmx128m"
export ANT_HOME=${HOME}/dev-tools/apache-ant-1.6.5
export ANT_OPTS="-Xmx500m -Xms128m"
#export MAVEN_HOME=${HOME}/dev-tools/apache-maven-2.1.0
export M2_HOME=${MAVEN_HOME}
export MAVEN_OPTS="-Xmx500m -Xms128m -Dfile.encoding=UTF-8"
export EDITOR=${VIMPATH}
export CVSEDITOR=${EDITOR}
export SVN_EDITOR=${EDITOR}
export TEMP=${TMP}
export SCHEME_LIBRARY_PATH="/usr/local/lib/slib/"

export XDEBUG_CONFIG="idekey=DBGP"
export XDEBUG_SESSION_START=DBGP

#PATH=/usr/bin:/usr/sbin:/bin:/sbin:/usr/X11R6/bin:${HOME}/bin:/usr/local/bin
PATH=${PATH}:${HOME}/cvswork/refeng/tools
PATH=${PATH}:${HOME}/bin/vim
PATH=${PATH}:${JAVA_HOME}/bin:${J2EE_HOME}/bin
PATH=${PATH}:${CATALINA_HOME}/bin
PATH=${PATH}:${ANT_HOME}/bin
PATH=${PATH}:${M2_HOME}/bin
PATH=${PATH}:${MYSQL_BASE}/bin

if [ -n "${WINPATH}" ]; then
	PATH=${PATH}:${WINPATH}
fi
export PATH

# PERL5 local::lib対応。
if [ -e ~/perl5/lib/perl5/local/lib.pm ]; then
	eval $(perl -I ~/perl5/lib/perl5 -Mlocal::lib)
fi

CLASSPATH=".:./build/classes"
CLASSPATH="$CLASSPATH:$JAVA_HOME/lib/tools.jar"
CLASSPATH="$CLASSPATH:$CATALINA_HOME/common/lib/servlet.jar"
CLASSPATH="$CLASSPATH:$CATALINA_HOME/webapps/orgmgr/WEB-INF/classes"
# javaLib直下のファイル群へclasspathを通す
for f in ${HOME}/javaLib/*
do
	CLASSPATH="${CLASSPATH}:$f"
done

# cvswork配下の全プロジェクトのbinに対してclasspathをきる。
for f in ${HOME}/cvswork/*
do
	CLASSPATH="${CLASSPATH}:$f/bin"
done

# eclipse compilerへのclasspath作成
for f in ${ECLIPSE_HOME}/plugins/org.eclipse.jdt.core_*/*.jar;do
	CLASSPATH="${CLASSPATH}:$f"
done

for f in ${ECLIPSE_HOME}/plugins/org.eclipse.core.runtime_*/*.jar;do
	CLASSPATH="${CLASSPATH}:$f"
done

for f in ${ECLIPSE_HOME}/plugins/org.eclipse.core.resources_*/*.jar;do
	CLASSPATH="${CLASSPATH}:$f"
done

# java runtimeへclasspathを通す
CLASSPATH=${CLASSPATH}:${JAVA_HOME}/jre/lib/rt.jar
export CLASSPATH
unset f

export ANGBAND_X11_FONT_0="-*-ipamonagothic-medium-r-normal-*-14-*-*-*-*-*-jisx0208.1983-*"

export PYTHONPATH=.

if [ -e ${vcsroot}/nvm/nvm.sh ]; then
	. ${vcsroot}/nvm/nvm.sh
	nvm use v0.7.8 > /dev/null
	export NODE_PATH=${NVM_PATH}_modules
fi

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



# SSHのagent周りの設定
if ssh-add -l >/dev/null 2>&1
then
	:
elif [ 2 == "$?" ]
then
	export SSH_AUTH_SOCK=${HOME}/.ssh/sock.`hostname`
	if ssh-add -l > /dev/null 2>&1
	then
		:
	elif [ 2 == "$?" -a ! "$SSH_CLIENT" ]
	then
		rm -f ${SSH_AUTH_SOCK}
		eval `ssh-agent -a ${SSH_AUTH_SOCK}`
	fi
fi

# ssh-agentへkeyを追加
function keyadd {
	ssh-add -l | grep "mars" > /dev/null
	if [ 1 == "$?" ]
	then
		echo "ssh key add"
		ssh-add -t 180m ~/.ssh/id_dsa_mars
	fi
}

export keyadd

# 各hostへの接続設定。
# tunnelingとか。
function mars {
	keyadd
	eval ${cocot} -p UTF-8 -- ssh -AY -D 10080 -C -L 8143:localhost:143 -L 8025:localhost:25 vikke@www.mars95.to
	echo -e ${xterm_title}
}

function psb {
	keyadd
	eval ${cocot} -p EUC-JP -- ssh -X -C -L 8389:192.168.1.201:3389 -L 1100:192.168.1.1:80 -L 5880:192.168.1.13:5900 vikke@psb.vikke.mydns.jp
	echo -e ${xterm_title}
}

function mnt-eijudo {
	smbmount //192.168.1.13/f ~/mnt-smb/office1-f/ -o iocharset=utf8,password=
	smbmount //192.168.1.201/e ~/mnt-smb/nin-e/ -o iocharset=utf8,user=vikke
	smbmount //psb/export ~/mnt-smb/psb/ -o iocharset=utf8,user=vikke,password=

}

function mnt-freebsddev {
#	smbmount //freebsddev/vikke ~/mnt-smb/freebsddev/ -o iocharset=euc-jp,password=
	sshfs -o idmap=user -o allow_other -o uid=1000 -o gid=1000 -o workaround=rename -o follow_symlinks vikke@freebsddev:/home/vikke ~/mnt-ssh/freebsddev
}

function umnt-eijudo {
	smbumount ~/mnt-smb/office1-f
	smbumount ~/mnt-smb/nin-e

}

function snow {
	keyadd
	# 13306: sonic platform
	# 13308: sonic misc
	# 23306: alex platform(replication)
	# 23308: alex staging
	eval ${cocot} -p UTF-8 -- ssh -g -A -L 13306:sonic.fsx.speee.jp:3306 -L 13308:sonic.fsx.speee.jp:3308 -L 23306:alex.fsx.speee.jp:3306 -L 23308:alex.fsx.speee.jp:3308 snow.fsx.speee.jp

}

function pusher {
	keyadd
	eval ${cocot} -p UTF-8 -- ssh -AY pusher.vikke.name
}
function u-ziq {
	keyadd
	eval ${cocot} -p UTF-8 -- ssh -AY vikke@u-ziq.vikke.name -p 10022
}

function cipher {
	keyadd
	eval ${cocot} -p UTF-8 -- ssh -AY vikke@cipher.vikke.name
}
function mnt-cipher {
	keyadd
	sshfs vikke@cipher.vikke.name:/home/vikke ~/mnt/cipher
}

function kt {
	keyadd
	eval ${cocot} -p UTF-8 -- ssh -AY vikke@kt.vikke.name
}
function mnt-kt {
	sshfs 	vikke@kt.vikke.name:/home/vikke ~/mnt/kt
}
function umnt-kt {
	umount ~/mnt/kt
}


alias rcoverage='if [ -d coverage ]; then rm -rf coverage; fi; COVERAGE=boo bundle exec rspec --no-drb'
alias rspec='bundle exec rspec'
alias rake='bundle exec rake'
alias rails='bundle exec rails'
alias ssh_copy_id='ssh-copy-id -i ~/.ssh/id_rsa_livesense.pub '

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

