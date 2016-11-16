#!/bin/bash
prj=${1}
branch=$(git branch | grep '^* '| awk -e '{ print $2; }')

branch=$(ruby -r 'cgi' -e "puts CGI.escape('${branch}')")
echo $branch
curl -X POST "http://hudson.dev.scaleout.jp/view/ichiro/job/${prj}/buildWithParameters?delay=0&branch=${branch}"
