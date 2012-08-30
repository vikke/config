" refe2が使うのでcommentout。
nnoremap <buffer> <silent> K :Refe <cword><CR>
nnoremap <buffer> <silent> <C-K> :Refe<CR>

" errormaker.vim対応
compiler ruby
" au BufWritePost * silent make %

setlocal dictionary+=~/vimfiles/dict/ruby.dict
" setlocal tags+=~/tags/ruby/gem-tags

set tabstop=2
set expandtab
set shiftwidth=2
set autoindent
set softtabstop=2
