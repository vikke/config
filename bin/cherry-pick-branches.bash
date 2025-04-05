#!/bin/bash

COMMIT_HASH=${1}
BRANCHES=${@:2}
NOW_BRANCH=$(git branch | cat - | awk -e '/^\*/{print $2}')

for branch in ${BRANCHES[@]}; do
  echo "== ${branch} =="
  git checkout "${branch}"
  git pull
  if [ ${?} -ne 0 ]; then
	  exit
  fi

  git cherry-pick "${COMMIT_HASH}"
  if [ ${?} -ne 0 ]; then
	  exit
  else
	git push
  fi
done

# 最後に元のブランチに戻る（オプション）
git checkout ${NOW_BRANCH}
