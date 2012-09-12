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
	echo $(LANG=C svn log -v --stop-on-copy ${branch} |gawk --re-interval '/^[[:space:]]{3}A .*\(from \/trunk.*$/{rev=$0;} END{print gensub(/^.*:([[:digit:]]+).*\).*$/, "\\1", "G", rev);}')
}

function svn_get_last_rev {
	local branch=$1
	if [ -z ${branch} ];then
		echo "branchが指定されていません" 1>&2
		exit 1
	fi
	echo $(LANG=C svn log -v --stop-on-copy ^/tags | gawk --re-interval '/^[[:space:]]{3}A .*\(from \/trunk.*$/{ print gensub(/^.*:([[:digit:]]+).*\).*$/, "\\1", "G"); exit;}')
}


# create svn merge command.
function svn_merge_from_trunk_command {
	local start_rev=$(svn_get_mk_branch_rev . )
	local head_rev=$(svn_head_rev)
	echo  "svn merge -r ${start_rev}:${head_rev} ^/trunk"
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
		exit 1
	fi

	shift
	local comment=$1
	if [ -n "${comment}" ];then
		comment=${comment}"\n\n"
	fi

	local head_rev=$(svn_head_rev)
	local commit_comment_file=$(mktemp)
	local svn_cp_command="svn cp -F ${commit_comment_file} ^/trunk@${head_rev} ^/branches/${branch}"

echo -e $(cat << EOS
create branch.\n\n${comment}${svn_cp_command}
EOS
) > ${commit_comment_file}
	
	eval ${svn_cp_command}

	rm ${commit_comment_file}
}

# create new tagging command.
# ちょっとめんどいんで、一旦枝番対応は後回し
function svn_tagging_command {
	prev_tag_rev=$(svn_get_last_rev ^/tags)
	prev_tag_rev=$((${prev_tag_rev} + 1))
	#prev_tag_rev=4667	
	
	trunk_rev=$(svn_get_last_rev ^/trunk)

	if [ ${trunk_rev} -lt ${prev_tag_rev} ];then
		echo "最終tagのrev.よりtrunkのrev.の方が若い。これはぁゃιぃ" 1>&2	
		exit 1
	fi

	comment_file=$(mktemp)	
	
	command="svn cp -F ${comment_file} ^/trunk@${trunk_rev} ^/tags/$(date +%Y%m)/$(date +%Y%m%d_01)"

	svn log -r ${prev_tag_rev}:${trunk_rev} ^/trunk > ${comment_file}
	echo -e "\n\n${command} " >> ${comment_file}

	eval ${EDITOR} ${comment_file}

	# eval ${command}
	echo ${command}
}

