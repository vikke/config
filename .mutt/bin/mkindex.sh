#!/usr/bin/env bash

#############################################
# Hyper Estraierでmail用のindexを作成する。
#############################################


ps axww|grep 'estcmd'|grep -v 'grep' &> /dev/null
if [ $? -eq 0 ];then
	exit
fi

MAILS_ROOT_DIR=${HOME}/Mail

for d in ${MAILS_ROOT_DIR}/*;do

	account=${d##*/}
	casket_work=${HOME}/.mutt/accounts/${account}/casket_work 
	casket_tmp=${HOME}/.mutt/accounts/${account}/casket_tmp
	casket=${HOME}/.mutt/accounts/${account}/casket

	if [ ! -e ${casket} ]; then
		mkdir -p ${casket}
	fi
	find ${d} -type f | estcmd gather -il ja -sd -fm -cm -cl ${casket} -

	# indexをlockしないようにするパターン。最後のcopyが重い。。。
#	find ${d} -type f | estcmd gather -il ja -sd -fm -cm -cl ${casket_work} -
#
#	if [ -e ${casket_tmp} ];then
#		rm -rf ${casket_tmp}
#	fi
#	cp -r ${casket_work} ${casket_tmp}
#
#	if [ -e ${casket} ];then
#		rm -rf ${casket}
#	fi
#	mv ${casket_tmp} ${casket}

done

