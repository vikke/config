compiler gcc

"set fileencoding=utf8
setlocal tags+=~/.vim/dict/c-headers.tags
setlocal keywordprg=man\ -a\ -S\ 2:3
let g:ref_man_cmd = "man -P cat -S 2:3"
