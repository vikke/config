"nnoremap <buffer> <silent> K :Refe <cword><CR>
"nnoremap <buffer> <silent> <C-K> :Refe<CR>

" errormaker.vim
compiler ruby
" au BufWritePost * silent make %

"setlocal dictionary+=~/vimfiles/dict/ruby.dict
" setlocal tags+=~/tags/ruby/gem-tags

setlocal tabstop=2
setlocal expandtab
setlocal shiftwidth=2
setlocal autoindent
setlocal softtabstop=2
setlocal foldmethod=syntax

" matchit
" なんか動きが変なので、一旦comment。後でちゃんとマニュアル読む。
"let b:match_words = '\<\%(if\|unless\|case\|while\|until\|for\|do\|class\|module\|def\|begin\)\>=\@!:\<\%(else\|elsif\|ensure\|when\|rescue\|break\|redo\|next\|retry\)\>:\<end\>,{:},\[:\],(:),\<describe\|it\|context\>:\<end\>'

set foldenable
set foldmethod=syntax

" neocomplとかで超重くなる対策
" http://qiita.com/izumin5210/items/7e0ad2f86d0686d8b376
autocmd InsertEnter * if !exists('w:last_fdm')
            \| let w:last_fdm=&foldmethod
            \| setlocal foldmethod=manual
            \| endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm')
            \| let &l:foldmethod=w:last_fdm
            \| unlet w:last_fdm
            \| endif
