#!/bin/bash
# pickaxe使う事案?
target=$1
for h in $(git log | grep commit | head -n 1000 | awk '{print $2}'); do
	if [ "${h}" == 'reverts' ]; then
		continue
	fi
	git --no-pager diff ${h}^..${h} | grep -q target > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo $h
	fi
done

