" $Id: .vimrc 602 2011-02-17 16:54:21Z vikke $
" $HeadURL: https://psb.vikke.mydns.jp/svn/vikke_env/.vimrc $
"


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
call dein#add('Shougo/denite.nvim')
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
call dein#add('junegunn/vim-easy-align')
call dein#add('kchmck/vim-coffee-script')
call dein#add('koron/chalice')
call dein#add('mbbill/undotree')
call dein#add('osyo-manga/vim-monster')
call dein#add('easymotion/vim-easymotion')
call dein#add('wakatime/vim-wakatime')

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
set bri
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

" {{{ = deoplete ==================================
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#auto_completion_start_length = 2
let g:deoplete#lock_buffer_name_pattern = '\*ku\*'
let g:deoplete#sources#tags#cache_limit_size = 8000000
" }}}

" {{{ vim-monster
" Set async completion.
let g:monster#completion#rcodetools#backend = "async_rct_complete"
"}}}

" = denite.vim ==========================
"{{{
call denite#custom#var('file_rec', 'command', ['denite_file_list.sh'])
call denite#custom#source('file_rec', 'matchers', ['matcher_fuzzy', 'matcher_project_files'])

" call denite#custom#var('grep', 'command', ['denite_grep.sh'])
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'final_opts', [])
call denite#custom#var('grep', 'separator', [])
call denite#custom#var('grep', 'default_opts',
    \ ['--nopager', '--nocolor', '--nogroup', '--column'])

nnoremap <silent> fs :Denite buffer<CR>
nnoremap <silent> ff :Denite file_rec<CR>
nnoremap <silent> fm :Denite file_mru<CR>
nnoremap <silent> FF :DeniteBufferDir file_rec<CR>
nnoremap <silent> FG :Denite grep<CR>
nnoremap <silent> fg :Denite grep<CR><C-R><C-W><CR>
nnoremap <silent> fj :Denite grep<cr>'\b<C-R><C-W>\b'<CR>
nnoremap <silent> fr :Denite -resume<CR>
nnoremap <silent> fo :Denite unite:outline<CR>

" くそ重い
" call denite#custom#option('default', 'auto_preview', 1)

call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-k>', '<denite:do_action:split>', 'noremap')
call denite#custom#map('insert', '<C-o>', '<denite:do_action:vsplit>')

"" = unite-outline =====================
""{{{
""}}}
"

" = php debugger =====================
" {{{
let g:vdebug_options={
\    'timeout': 30
\}
" }}}


" = unite-tag =========================
"{{{
nnoremap <buffer> <C-]> :<C-u>:Denite unite:tag<CR>
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

"{{{ vim-easy-align
vmap <Enter> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
"}}}
