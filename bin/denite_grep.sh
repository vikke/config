#!/bin/bash
if [ ${#} -ne 1 ]; then
	exit 2
fi
search_word=${1}
ag  --nopager --nocolor --nogroup "${search_word}"| sort -d
