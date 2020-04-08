" $Id: .vimrc 602 2011-02-17 16:54:21Z vikke $
" $HeadURL: https://psb.vikke.mydns.jp/svn/vikke_env/.vimrc $ 
let g:python3_host_prog = '/home/vikke/.pyenv/shims/python3'
if has('python3')
  " Python 3 を使うためのおまじない
end


set ttimeoutlen=0

" {{{ dein
if &compatible
      set nocompatible
endif
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
    call dein#begin('~/.cache/dein')

    call dein#add('Shougo/denite.nvim')

    call dein#add('prabirshrestha/async.vim')
    call dein#add('prabirshrestha/asyncomplete.vim')
    call dein#add('prabirshrestha/asyncomplete-lsp.vim')
    call dein#add('prabirshrestha/vim-lsp')
    call dein#add('mattn/vim-lsp-settings', {'merged': 0})

    call dein#end()
    call dein#save_state()
endif
filetype plugin indent on
" }}}

"--------------------------------------------------------------------------------
" 全体設定
" {{{--------------------------------------------------------------------------------
let mapleader=","

set ai
set number
set ts=4
set nobackup
set nowritebackup
set incsearch
set noignorecase
set visualbell
"set cursorline
set shiftwidth=4
set nocompatible
set hidden
set backspace=indent,eol,start
set diffopt=filler,iwhite
set foldenable
set foldmethod=marker
set foldlevel=3
set foldlevelstart=99
set history=2000
set updatetime=500
"set notagbsearch
set list
set listchars=trail:\ ,tab:\ \ ,
filetype plugin indent on
syntax enable
set t_Co=256
set nohlsearch
set viminfo=:2000,'100,<50,s10,h
" set breakindent
"}}}--------------------------------------------------------------------------------


