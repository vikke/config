#!/usr/bin/env bash

#############################################
# Hyper Estraierのindexのoptimize
#############################################

MAILS_ROOT_DIR=${HOME}/Mail

for d in ${MAILS_ROOT_DIR}/*;do
	account=${d##*/}
	casket=${HOME}/.mutt/accounts/${account}/casket
	estcmd optimize ${casket}
done
