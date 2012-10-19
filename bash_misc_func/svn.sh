# get now head revision.
function svn_head_rev {
	local head_rev=$(LANG=C svn update | grep 'At'| cut -d\  -f 3 | sed -e 's/\.//g')
	echo $head_rev
}

# get rev.no when this branch was built.
# arg: branch. ex. ^/branches/vikke/bar
#      if not set, it set '.'.
function svn_get_mk_branch_rev {
	local branch=$1
	if [ -z "${branch}" ];then
		branch=.
	fi
	echo $(LANG=C svn log -v --stop-on-copy ${branch} |gawk --re-interval '/^[[:space:]]{3}A .*\(from .*:[[:digit:]]+\)$/{rev=$0;} END{print gensub(/^.*:([[:digit:]]+).*\).*$/, "\\1", "G", rev);}')
}

function svn_get_parent_branch_path {
echo $(LANG=C svn log -v --stop-on-copy ${branch} |gawk --re-interval '/^[[:space:]]{3}A .*\(from .*:[[:digit:]]+\)$/{m=$0;} END{print gensub(/.*\(from (.+):.*$/, "\\1", "G", m);}')
}

function svn_get_last_tag_rev {
	echo $(LANG=C svn log -v --stop-on-copy ^/tags | gawk --re-interval '/^[[:space:]]{3}A .*\(from \/trunk.*$/{ print gensub(/^.*:([[:digit:]]+).*\).*$/, "\\1", "G"); exit;}')
}

function svn_get_last_trunk_rev {
	echo $(LANG=C svn log -v -l 1 ^/trunk|awk '/^r[[:digit:]]+/ { print gensub("r", "", "G", $1);}')
}


# create svn merge command.
function svn_merge_from_parent_command {
	local start_rev=$(svn_get_mk_branch_rev . )
	local head_rev=$(svn_head_rev)
	local parent_path=$(svn_get_parent_branch_path)
	echo  "svn merge -r ${start_rev}:${head_rev} ^/${parent_path}"
}

# make svn's branch under ^/branches/
#
# usage: svn_mk_branch BRANCH_PATH [additional-comment]
#   ex.: svn_mk_branch ichiro/TEST_TEST "なんたらかんたら用branch作成"
#
# 	BRANCH_PATH: 
#		create branch path under ^/branches/
function svn_mk_branch {
	local branch=$1
	if [ -z "${branch}" ];then
		echo "引数にbranch名を与えて下さい" 1>&2
		return 1
	fi

	shift
	local comment=$1
	if [ -n "${comment}" ];then
		comment=${comment}'

'
	fi

	local head_rev=$(svn_head_rev)
	local commit_comment_file=$(mktemp)
	local svn_cp_command="svn cp -F ${commit_comment_file} ^/trunk@${head_rev} ^/branches/${branch}"

	echo "$(cat << EOS
create branch.

${comment}${svn_cp_command}
EOS
)" > ${commit_comment_file}
	
	eval ${svn_cp_command}

	rm ${commit_comment_file}
}

# create new tagging command.
# ちょっとめんどいんで、一旦枝番対応は後回し
function svn_tagging_command {
	local prev_tag_rev=$(svn_get_last_tag_rev)
	local prev_tag_rev=$((${prev_tag_rev} + 1))
	#prev_tag_rev=4667	
	
	local trunk_rev=$(svn_get_last_trunk_rev)

	echo "trunk_rev: ${trunk_rev}"
	echo "prev_tag_rev: ${prev_tag_rev}"
	if [ ${trunk_rev} -lt ${prev_tag_rev} ];then
		echo "最終tagのrev.よりtrunkのrev.の方が若い。これはぁゃιぃ" 1>&2	
		return 1
	fi

	comment_file=$(mktemp)	
	
	command="svn cp -F ${comment_file} ^/trunk@${trunk_rev} ^/tags/$(date +%Y%m)/$(date +%Y%m%d_01)"

	svn log -r ${prev_tag_rev}:${trunk_rev} ^/trunk > ${comment_file}
	echo -e "\n\n${command} " >> ${comment_file}

	eval ${EDITOR} ${comment_file}

	# eval ${command}
	echo ${command}
}


# get rev.no that contains the word.
function svn_get_rev_contain_word {
	local target_word=${1}
	if [ -z "${target_word}" ];then
		echo "検索語を渡して下さい" 1>&2
		return 1
	fi
	
	svn log | gawk "/^r[0-9]+/{ var=\$0; } /${target_word}\>/{ print var \"\n\" \$0 \"\n\";}"
}

