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

