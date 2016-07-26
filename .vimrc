" $Id: .vimrc 602 2011-02-17 16:54:21Z vikke $
" $HeadURL: https://psb.vikke.mydns.jp/svn/vikke_env/.vimrc $
"

" "{{{ neobundle --------------------------------------------------------------------------------
" if has('vim_starting')
"     set nocompatible               " Be iMproved
"     set runtimepath+=~/.vim/bundle/neobundle.vim/
" endif
" call neobundle#begin(expand('~/.vim/bundle/'))
" NeoBundleFetch 'Shougo/neobundle.vim'
"
" NeoBundle 'Shougo/unite.vim'
" NeoBundle 'Shougo/neosnippet.vim'
" NeoBundle 'Shougo/neosnippet-snippets'
" NeoBundle 'Shougo/neocomplete'
" NeoBundle 'Shougo/neomru.vim'
" NeoBundle 'Shougo/vinarise'
" NeoBundle 'Shougo/unite-outline'
" NeoBundle 'tyru/current-func-info.vim'
" NeoBundle 'vim-scripts/info.vim'
" NeoBundle 'tsukkee/lingr-vim'
" NeoBundle 'tsukkee/unite-tag'
" NeoBundle 'vim-scripts/matchit.zip'
" NeoBundle 'ujihisa/quickrun'
" NeoBundle 'ujihisa/unite-colorscheme'
" NeoBundle 'tpope/vim-fugitive'
" NeoBundle 'tpope/vim-rails'
" NeoBundle 'thinca/vim-ref'
" NeoBundle 'kmnk/vim-unite-svn'
" NeoBundle 'vim-jp/vimdoc-ja'
" NeoBundle 'mattn/webapi-vim'
" NeoBundle 'mattn/mkdpreview-vim'
" NeoBundle 'vimscript/taglist'
" NeoBundle 'joonty/vdebug'
" NeoBundle 'Shougo/vimproc.vim', {
" \   'build': {
" \       'linux': 'make',
" \       'mac': 'make -f make_mac.mak',
" \   }
" \}
" NeoBundle 'mrk21/yaml-vim'
"
" call neobundle#end()
"
" filetype plugin indent on
" NeoBundleCheck
" "}}}--------------------------------------------------------------------------------

" {{{ dein
if &compatible
      set nocompatible
endif
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.vim/dein'))
call dein#add('Shougo/dein.vim')

call dein#add('Shougo/deoplete.nvim')

call dein#add('Shougo/vimproc.vim', {'build': 'make'})

call dein#add('Shougo/unite.vim')
call dein#add('Shougo/neomru.vim')
call dein#add('Shougo/neosnippet')
call dein#add('Shougo/unite-outline')
call dein#add('Shougo/neosnippet')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/neocomplete.vim')

call dein#add('tsukkee/unite-tag')
call dein#add('tyru/current-func-info.vim')
call dein#add('vim-scripts/matchit.zip')
call dein#add('ujihisa/quickrun')
call dein#add('vim-jp/vimdoc-ja')
call dein#add('tpope/vim-rails')
call dein#add('tpope/vim-fugitive')
call dein#add('tmhedberg/matchit')
call dein#add('tyru/restart.vim')
call dein#add('scrooloose/nerdtree')
call dein#add('vim-scripts/taglist.vim')

call dein#add('kchmck/vim-coffee-script')

call dein#end()
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
"}}}--------------------------------------------------------------------------------

"--------------------------------------------------------------------------
" color scheme
"{{{--------------------------------------------------------------------------
"
"ここでgui版じゃないcolorschemeを設定。.gvimrcで再定義しなければgvimでも使われる。
"colorscheme xterm16
"let xterm16_brightness = 'soft'
"colorscheme midnight2
" colorscheme xterm16
colorscheme jellybeans

"colorscheme gentooish
"
"hi Normal ctermfg=248 ctermbg=none

"" %s///c とかのときに、マッチした場所を別の色で表示
highlight IncSearch term=bold ctermbg=54 guibg=LightMagenta

"}}}--------------------------------------------------------------------------------


"--------------------------------------------------------------------------------
" キーアサイン変更
"{{{--------------------------------------------------------------------------------
" 上下移動を論理行単位では無く、物理行単位で動くように変更
nnoremap j gj
nnoremap k gk

" clipboard
"if has('macunix')
"    vmap _ :w !pbcopy<CR><CR>
"    "vmap _ :w !nkf -Ws \|pbcopy<CR><CR>
"endif
set clipboard+=unnamedplus
"}}}--------------------------------------------------------------------------------

"--------------------------------------------------------------------------------
" 縦分割時に狭い場合アクティブなwindowを自動で広くする。
"{{{--------------------------------------------------------------------------------
"nnoremap <silent> <c-w>l <c-w>l:call <SID>good_width()<cr>
"nnoremap <silent> <c-w>h <c-w>h:call <SID>good_width()<cr>
"nnoremap <silent> <c-w><c-w> <c-w><c-w>:call <SID>good_width()<cr>
"nnoremap <silent> <c-w>w <c-w>w:call <SID>good_width()<cr>
"function! s:good_width()
"    let size = 90
"    if winwidth(0) < size
"        execute "vertical resize" size
"    endif
"endfunction
"}}}--------------------------------------------------------------------------------


"--------------------------------------------------------------------------------
" cygwin連携
"{{{--------------------------------------------------------------------------------
if has("win32unix")
    set shell=bash
    set shellcmdflag=-c
    "set shq=\\"
    "set sxq=\\"
    set shellslash
endif
"}}}--------------------------------------------------------------------------------

"--------------------------------------------------------------------------------
" 印刷設定
"{{{--------------------------------------------------------------------------------
set printoptions=number:y
set printheader=%<%f%h%m%=Page\ %N
if has("win32")
    set printfont=MS_Gothic:h10:cSHIFTJIS
endif
"}}}--------------------------------------------------------------------------------

"--------------------------------------------------------------------------------
" status行に[文字コード:改行コード][filetype]を表示
"{{{--------------------------------------------------------------------------------
set laststatus=2
function! GetB()
    let c = matchstr(getline('.'), '.', col('.') - 1)
    let c = iconv(c, &enc, &fenc)
    return String2Hex(c)
endfunction
" :help eval-examples
" The function Nr2Hex() returns the Hex string of a number.
func! Nr2Hex(nr)
    let n = a:nr
    let r = ""
    while n
        let r = '0123456789ABCDEF'[n % 16] . r
        let n = n / 16
    endwhile
    return r
endfunc
" The function String2Hex() converts each character in a string to a two
" character Hex string.
func! String2Hex(str)
    let out = ''
    let ix = 0
    while ix < strlen(a:str)
        let out = out . Nr2Hex(char2nr(a:str[ix]))
        let ix = ix + 1
    endwhile
    return out
endfunc

if winwidth(0) >= 80
    let &statusline='%<[%n]%m%r%h%w%{"[".(&fenc!=""?&fenc:&enc).":".&ff."]"}%y %F%=[%{GetB()}] %{cfi#format("[%s()]", "no function")} %l,%c%V%8P'
    " TODO: Hack #171(http://vim-users.jp/2010/09/hack171/): 編集している関数名を表示する
    "current-func-info.vim のテスト用
    "let &statusline='%{cfi#format("[%s()]", "no function")}'
else
    let &statusline='%<[%n]%m%r%h%w%{"[".(&fenc!=""?&fenc:&enc).":".&ff."]"}%y %10.40f%=[%{GetB()}] %{cfi#format("[%s()]", "no function")} %l,%c%V%8P'
    "current-func-info.vim のテスト用
    "let &statusline='%{cfi#format("[%s()]", "no function")}'
endif

"}}}--------------------------------------------------------------------------------

"--------------------------------------------------------------------------------
" /で検索した結果をquickfixで表示;
" 元ネタは http://subtech.g.hatena.ne.jp/secondlife/
"{{{--------------------------------------------------------------------------------
nmap <unique> f/ :exec ':vimgrep /' . getreg('/') . '/j %\|cwin'<CR>
"}}}--------------------------------------------------------------------------------

"{{{ C-I, C-O入れ替え --------------------------------------------------------------------------------
nnoremap <C-I> <C-O>
nnoremap <C-O> <C-I>

"}}}--------------------------------------------------------------------------------

"--------------------------------------------------------------------------------
" file改行code関係
"{{{--------------------------------------------------------------------------------
"set fileformats=unix,dos,mac
"set fileformat=unix

" file文字code関係
"set enc=utf-8
"set fileencoding=utf-8
"set fileencodings=utf-8,cp932,euc-jp,iso-2022-jp


set encoding=utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp,sjis,cp932,euc-jp

" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif
"}}}--------------------------------------------------------------------------------


"--------------------------------------------------------------------------------
" 開発用の共通設定とか。
"{{{--------------------------------------------------------------------------------
set tags=tags

set grepprg=ag\ -i

"}}}--------------------------------------------------------------------------------

"--------------------------------------------------------------------------------
" plugin関係
"{{{--------------------------------------------------------------------------------

"--------------------------------------------------------------------------------
" buffer操作系
"--------------------------------------------------------------------------------

" " = neocomplete ========================
" "{{{
" let g:neocomplete#enable_at_startup = 1
" let g:neocomplete#enable_ignore_case = 1
" let g:neocomplete#enable_smart_case = 1
" let g:neocomplete#auto_completion_start_length = 3
" let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" let g:neocomplete#sources#tags#cache_limit_size = 8000000
" let g:unite_data_directory = '~/.cache/unite'
"
" if !exists('g:neocomplete#keyword_patterns')
"     let g:neocomplete#keyword_patterns = {}
" endif
" let g:neocomplete#keyword_patterns._ = '\h\w*'
"
" " omnifunc
" autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
" autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
" autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
" autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" "}}}

" {{{ = deoplete ==================================
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#auto_completion_start_length = 3
let g:deoplete#lock_buffer_name_pattern = '\*ku\*'
let g:deoplete#sources#tags#cache_limit_size = 8000000
" }}}

" = unite.vim ==========================
"{{{
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1
" let g:unite_data_directory = '~/.cache/unite'


let g:unite_source_file_mru_limit=1000
let g:unite_source_rec_max_cache_files=100000
let g:unite_source_rec_async_command=['ag', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', '']

function! DispatchUniteFileRecAsyncOrGit()
    if isdirectory(getcwd()."/.git")
        Unite -start-insert -buffer-name=files file file_rec/git
    else
        Unite -start-insert -buffer-name=files file file/new
    endif
endfunction

nnoremap <silent> fs :Unite -start-insert buffer<CR>
"nnoremap <silent> ff :Unite -start-insert -buffer-name=files file file_rec/neovim<CR>
"nnoremap <silent> ff :Unite -start-insert -buffer-name=files file file_rec/git<CR>
nnoremap <silent> ff :<C-u>call DispatchUniteFileRecAsyncOrGit()<CR>
nnoremap <silent> FF :UniteWithBufferDir -start-insert -buffer-name=files file file/new<CR>
nnoremap <silent> fm :Unite -start-insert file_mru<CR>
nnoremap fc <Plug>(unite_redraw)

nnoremap <silent> FG :Unite grep:. -start-insert -buffer-name=search-buffer<CR>
nnoremap <silent> fg :Unite grep:. -start-insert -buffer-name=search-buffer<CR><C-R><C-W><CR>
nnoremap <silent> fb :Unite grep:. -start-insert -buffer-name=search-buffer<cr>\b<C-R><C-W>\b<CR>
nnoremap <silent> fr  :<C-u>UniteResume search-buffer<CR>

au FileType unite call s:unite_my_settings()

function! s:unite_my_settings()
    nmap <buffer> <ESC> <Plug>(unite_exit)
    inoremap <buffer> <expr> <C-k> unite#do_action('split')
    nnoremap <buffer> <expr> <C-o> unite#do_action('vsplit')
    inoremap <buffer> <expr> <c-o> unite#do_action('vsplit')
    imap <buffer> <C-g>        <Plug>(unite_delete_backward_path)
"    imap <buffer> <C-h>        <Plug>(unite_delete_backward_path)
    imap <buffer> <TAB>   <Plug>(unite_select_next_line)
endfunction

if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
    let g:unite_source_grep_recursive_opt = ''
endif

"}}}

" = unite-outline =====================
"{{{
nnoremap <silent> fo :Unite -start-insert outline<cr>
"}}}


" = php debugger =====================
" {{{
let g:vdebug_options={
\    'timeout': 30
\}
" }}}


" = unite-tag =========================
"{{{
let g:unite_source_tag_max_fname_length=70
let g:unite_source_tag_max_name_length=35
autocmd BufEnter *
\   if empty(&buftype)
\|      nnoremap <buffer> <C-]> :<C-u>UniteWithCursorWord -start-insert tag<CR>
\|  endif
"}}}

" = lingr-vim =========================
"{{{
let g:lingr_vim_user="vikke.bsd@gmail.com"
let g:lingr_vim_command_to_open_url="xdg-open "
"}}}

" = vim-ref ===========================
"{{{
let g:ref_phpmanual_path=$HOME . "/.vim/dict/manual/php-chunked-xhtml"
let g:ref_use_vimproc = 0
"}}}

"=== taglist ===
"{{{
let g:Tlist_WinWidth=30
let g:Tlist_php_settings = 'php;c:class;d:constant;f:function'
let g:Tlist_Show_One_File = 1
let g:Tlist_Exit_OnlyWindow = 1
let g:Tlist_Auto_Update = 1
let g:Tlist_Auto_Open = 1

nnoremap <Leader>t :Tlist<CR>

"}}}


"=== vcscommand ===
let g:VCSCommandDiffSplit="w"

"=== howm ================
"{{{
" howm_vimの設定
let g:howm_dir="~/howm"
let g:howm_grepprg="grep"
let g:howm_findprg="find"
let g:howm_removeEmpty=1
let g:howm_fileencoding="euc-jisx0213"
let g:howm_debug=1

let QFixHowm_Key=','
let howm_dir="~/howm"
let howm_filename= '%Y/%m/%Y-%m-%d-%H%M%S.howm'
let howm_fileencoding='euc-jisx0213'
let howm_fileformat= 'unix'
let mygrepprg="internal"
let MyGrep_ShellEncoding="utf-8"
let MyGrep_ExcludeReg = '[/\\]\.svn[/\\]|tags'

if has("win32")
    let g:howm_openurlcmd="C:/Program\\ Files/Mozilla\\ Firefox/firefox %s"
endif
if has("unix")
    let g:howm_openurlcmd="firefox %s"
endif
let g:howm_title_pattern="="
"}}}

" skk
"{{{
" FreeBSDの時は、uim-skk使うので、skkをloadingしないようにする。
"let plugin_skk_disable = 1
if has('win32unix') || has('win32')
    let plugin_skk_disable = 1
elseif has('unix')
    let plugin_skk_disable = 1
endif

if has("win32unix")
    let skk_jisyo = "~/skk-dic/skk-uim-jisyo"
    let skk_large_jisyo = "~/skk-dic/all.dic"
elseif has("unix")
    let skk_jisyo = "~/skkdict/skkvim.dic"
    let skk_large_jisyo = "~/skkdict/all.dic"
elseif has("win32")
    let skk_jisyo = "c:/Users/imatsunaga/skk-dic/skkvim.dic"
    let skk_large_jisyo = "c:/Users/imatsunaga/skk-dic/SKK-JISYO.L.UTF-8"
endif

let skk_keep_state = 1
let skk_egg_like_newline = 1
let skk_auto_save_jisyo = 1
"}}}

"eblookの設定
"{{{
let g:eblook_dict1_book="/home/vikke/dictionary/genius2005"
let g:eblook_dict1_name="genius"
let g:eblook_dict1_title='genius'
let g:eblook_dict1_gaiji='/home/vikke/dictionary/genius-gaiji'
"let g:eblook_dict2_book="/home/vikke/dictionary/koujien"
"let g:eblook_dict2_name="koujien"
"let g:eblook_dict2_title='koujien'
"let g:eblook_dict2_gaiji='/home/vikke/dictionary/koujien-gaiji'
"let eblookenc="euc-jp
let eblookenc="utf-8"

"}}}

" DirDiff
"{{{
let g:DirDiffExcludes = "CVS,*.class,*.exe,.*.swp,.svn"
"}}}

" migemoの設定
"{{{
if has('migemo')
    set migemo
endif
"}}}

" yankringの設定
"{{{
let g:yankring_history_file = 'tmpfs/yankring_history'
"}}}

"}}}--------------------------------------------------------------------------------

" quickrun
"{{{
let g:quickrun_config = {}
"}}}

"{{{ jq http://qiita.com/tekkoc/items/324d736f68b0f27680b8
command! -nargs=? Jq call s:Jq(<f-args>)
function! s:Jq(...)
    if 0 == a:0
        let l:arg = "."
    else
        let l:arg = a:1
    endif
    execute "%! jq ~/tmp/tmp.json" . l:arg . "~/tmp/tmp.json"
endfunction
"}}}

"--------------------------------------------------------------------------------
" au関係
"{{{--------------------------------------------------------------------------------

" _spec.rbのquickrun設定
augroup AddFileType
    au!
    au BufWinEnter,BufNewFile, *_spec.rb set filetype=ruby.rspec
augroup END
"let g:quickrun_config['ruby.rspec'] = { 'command': 'bundle exec rspec', 'cmdopt': '-cfs', 'exec': '%c %s %a' }
let g:quickrun_config['ruby.rspec'] = { 'command': 'bundle exec rspec -cfs', 'exec': '%c %s %a' }

" 保存時に行末スペース削除
function! Rtrim()
    let s:now = getpos(".")
    %s/\s\+$//e
    call setpos(".", s:now)
endfunction

autocmd BufWritePre * call Rtrim()

"}}}--------------------------------------------------------------------------------

"http://d.hatena.ne.jp/hirafoo/20120223/1329926505
" let g:ruby_path = ""

