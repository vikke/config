" refe2$B$,;H$&$N$G(Bcommentout$B!#(B
nnoremap <buffer> <silent> K :Refe <cword><CR>
nnoremap <buffer> <silent> <C-K> :Refe<CR>

" errormaker.vim$BBP1~(B
compiler ruby
" au BufWritePost * silent make %

setlocal dictionary+=~/vimfiles/dict/ruby.dict
" setlocal tags+=~/tags/ruby/gem-tags

setlocal tabstop=2
setlocal expandtab
setlocal shiftwidth=2
setlocal autoindent
setlocal softtabstop=2

" matchit
" なんか動きが変なので、一旦comment。後でちゃんとマニュアル読む。
"let b:match_words = '\<\%(if\|unless\|case\|while\|until\|for\|do\|class\|module\|def\|begin\)\>=\@!:\<\%(else\|elsif\|ensure\|when\|rescue\|break\|redo\|next\|retry\)\>:\<end\>,{:},\[:\],(:),\<describe\|it\|context\>:\<end\>'

