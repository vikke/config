#!/usr/bin/bash
# urlunescapeする
echo
ruby -r uri -e "puts URI.unescape(\"$1\")"
