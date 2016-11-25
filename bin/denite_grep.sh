#!/bin/bash
echo ${@}
ag  --nopager --nocolor --nogroup $( printf '%q' "${@}" ) | sort -d
