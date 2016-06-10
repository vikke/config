#!/usr/local/bin/bash
# urlescapeする
tmp=$(ruby -r cgi -e "puts CGI.escape('$1')")
echo ${tmp}
