" refe2$B$,;H$&$N$G(Bcommentout$B!#(B
nnoremap <buffer> <silent> K :Refe <cword><CR>
nnoremap <buffer> <silent> <C-K> :Refe<CR>

" errormaker.vim$BBP1~(B
compiler ruby
" au BufWritePost * silent make %

setlocal dictionary+=~/vimfiles/dict/ruby.dict
" setlocal tags+=~/tags/ruby/gem-tags

set tabstop=2
set expandtab
set shiftwidth=2
set autoindent
set softtabstop=2
