" $Id: .vimrc 602 2011-02-17 16:54:21Z vikke $
" $HeadURL: https://psb.vikke.mydns.jp/svn/vikke_env/.vimrc $
"
"--------------------------------------------------------------------------------
" 全体設定 "--------------------------------------------------------------------------------
call pathogen#runtime_append_all_bundles()

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
set foldmethod=syntax
set foldlevel=3
set foldlevelstart=99
set history=2000
set updatetime=500
set notagbsearch
set list
set listchars=trail:_,tab:\ \  
filetype plugin indent on
syntax enable

"--------------------------------------------------------------------------------
" キーアサイン変更
"--------------------------------------------------------------------------------
" 上下移動を論理行単位では無く、物理行単位で動くように変更
nnoremap j gj
nnoremap k gk

"--------------------------------------------------------------------------------
" 縦分割時に狭い場合アクティブなwindowを自動で広くする。
"--------------------------------------------------------------------------------
"nnoremap <silent> <c-w>l <c-w>l:call <SID>good_width()<cr>
"nnoremap <silent> <c-w>h <c-w>h:call <SID>good_width()<cr>
"nnoremap <silent> <c-w><c-w> <c-w><c-w>:call <SID>good_width()<cr>
"nnoremap <silent> <c-w>w <c-w>w:call <SID>good_width()<cr>
"function! s:good_width()
"	let size = 90
"	if winwidth(0) < size
"		execute "vertical resize" size
"	endif
"endfunction

"
"
"
"nnoremap <silent> : q:


"--------------------------------------------------------------------------------
" cygwin連携
"--------------------------------------------------------------------------------
set shell=bash
set shellcmdflag=-c
"set shq=\\"
"set sxq=\\"
set shellslash

"--------------------------------------------------------------------------------
" 印刷設定
"--------------------------------------------------------------------------------
set printoptions=number:y
set printheader=%<%f%h%m%=Page\ %N
if has("win32")
	set printfont=MS_Gothic:h10:cSHIFTJIS
endif

"--------------------------------------------------------------------------------
" status行に[文字コード:改行コード][filetype]を表示
"--------------------------------------------------------------------------------
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
if winwidth(0) >= 120
	let &statusline='%<[%n]%m%r%h%w%{"[".(&fenc!=""?&fenc:&enc).":".&ff."]"}%y %F%=[%{GetB()}] %{cfi#format("[%s()]", "no function")} %l,%c%V%8P'
	"current-func-info.vim のテスト用
	"let &statusline='%{cfi#format("[%s()]", "no function")}'
else
	let &statusline='%<[%n]%m%r%h%w%{"[".(&fenc!=""?&fenc:&enc).":".&ff."]"}%y %-10.30f%=[%{GetB()}] %{cfi#format("[%s()]", "no function")} %l,%c%V%8P'
	"current-func-info.vim のテスト用
	"let &statusline='%{cfi#format("[%s()]", "no function")}'
endif

"--------------------------------------------------------------------------------
" /で検索した結果をquickfixで表示;
" 元ネタは http://subtech.g.hatena.ne.jp/secondlife/ 
"--------------------------------------------------------------------------------
nmap <unique> f/ :exec ':vimgrep /' . getreg('/') . '/j %\|cwin'<CR>

"--------------------------------------------------------------------------------
" file改行code関係
"--------------------------------------------------------------------------------
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


"--------------------------------------------------------------------------------
" 開発用の共通設定とか。
"--------------------------------------------------------------------------------
set tags=./tags,tags,../tags,../../tags,../../../tags,../../../../tags,../../../../../tags,../../../../../../tags

"set grepprg=grep\ -nH\ --exclude-dir=\".svn\"
set grepprg=ack\ -a\ --type-set\ tags=.tags\ --notags
"set grepprg=ack-grep\ -a\ --type-set\ tags=.tags\ --notags

"--------------------------------------------------------------------------------
" plugin関係
"--------------------------------------------------------------------------------

"--------------------------------------------------------------------------------
" buffer操作系
"--------------------------------------------------------------------------------
" = lookupfile.vim呼び出し ===============
" 他、lookupfileのbufferに入った後のキーに関して(C-Cでキャンセルとか)はvimfiles/ftplugin/lookupfile.vimで対応。
"let g:loaded_lookupfile = 0  lookupfileを無効化する。有効化する場合はcomment outする。

"if ! exists('g:loaded_lookupfile')
	"nnoremap <unique> <silent> <C-S> :LUBufs<CR>^.***<Left><Left><Left><DEL><DEL><DEL>*
"	let g:LookupFile_AlwaysAcceptFirst=1
"	let g:LookupFile_PreserveLastPattern=0
"	let g:LookupFile_AllowNewFiles=0
"	let g:LookupFile_Bufs_LikeBufCmd=""
"endif



" = neocomplcache =====================
let g:neocomplcache_enable_at_startup = 1
imap <silent><C-a> <Plug>(neocomplcache_snippets_expand)
smap <silent><C-a> <Plug>(neocomplcache_snippets_expand)


" = unite.vim ==========================
nnoremap <silent> fs :Unite -start-insert buffer<CR>
nnoremap <silent> ff :Unite -start-insert -buffer-name=files file<CR>
nnoremap <silent> FF :UniteWithBufferDir -start-insert -buffer-name=files file<CR>
nnoremap <silent> fm :Unite -start-insert file_mru<CR>
nnoremap <silent> fb :Unite -start-insert bookmark<cr>
nnoremap <silent> fc :UniteWithBufferDir -start-insert file<CR>
au FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
	nmap <buffer> <esc>     <Plug>(unite_exit)
    nnoremap <buffer> <expr> <c-k> unite#do_action('split')
    inoremap <buffer> <expr> <c-k> unite#do_action('split')
    nnoremap <buffer> <expr> <c-o> unite#do_action('vsplit')
    inoremap <buffer> <expr> <c-o> unite#do_action('vsplit')
endfunction

" = unite-outline =====================
nnoremap <silent> fo :Unite -start-insert outline<cr>

" = unite-tag =========================
"autocmd BufEnter *
"\   if empty(&buftype)
"\|      nnoremap <buffer> <C-]> :<C-u>UniteWithCursorWord -start-insert -immediately tag<CR>
"\|  endif


" = lingr-vim =========================
let g:lingr_vim_user="vikke.bsd@gmail.com"

" = vim-ref ===========================
if has("macunix")
	let g:home_dir = "/Users/vikke"
elseif has("unix")
	let g:home_dir="/home/vikke"
elseif has("win32")
	let g:home_dir="c:/Users/imatsunaga"
endif
let g:ref_phpmanual_path=g:home_dir . "/doc/php/manual/php-chunked-xhtml"

" = fuf ==========================
"set runtimepath+=~/vim-vcs/vim-fuzzyfinder
"nnoremap <silent> ff :FufFile<CR>
"nnoremap <silent> fs :FufBuffer<CR>
"nnoremap <silent> fm :FufMruFile<CR>
"nnoremap <silent> ft :FufTag<CR>
"nnoremap <silent> fc :FufRenewCache<CR>
"nnoremap <silent> <C-]> :FufTagWithCursorWord!<cr>
"
"let g:fuf_keyOpenSplit='<C-k>'
"let g:fuf_keyOpenVsplit='<C-l>'

" = fuzzyfinder ==========================
"if ! exists('loaded_fuzzyfinder')
"	let g:FuzzyFinderOptions = { 'Base':{}, 'Buffer':{}, 'File':{}, 'Dir':{}, 'MruFile':{}, 'MruCmd':{}, 'Bookmark':{}, 'Tag':{}, 'TaggedFile':{}}
"	
"	nnoremap <unique> <silent> fs :FuzzyFinderBuffer<CR>
"	map <unique> ff :FuzzyFinderFile<CR>
"	map <unique> fm :FuzzyFinderMruFile<CR>
"	map <unique> ft :FuzzyFinderTag<CR>
"	map <unique> fc :FuzzyFinderRenewCache<CR>
"
"	nnoremap <silent> <C-]>      :FuzzyFinderTag! <C-r>=expand('<cword>')<CR><CR>
"
"	"FileModeでリスト表示するのは入力した値にマッチするfileが600以下の場合。
"	let g:FuzzyFinderOptions.File.matching_limit = 598 
"	let g:FuzzyFinderOptions.MruFile.max_item = 200
"	
"	"該当内容でsplitして開く時のキーがC-jだとskkと重複するので変更。
"	let g:FuzzyFinderOptions.Base.key_open_split = '<C-k>'	
"	let g:FuzzyFinderOptions.Base.key_open_vsplit = '<C-l>'
"	"splitと重複するので、適当に逃がす。
"	let g:FuzzyFinderOptions.Base.key_next_mode = '<C-o>'	
"	"
"	let g:FuzzyFinderOptions.Buffer.mru_order = 1
"
"	" CTRやVIMとかを付けた場合、そのリストで定義されているdirectoryからの検索となる。
"	let g:FuzzyFinderOptions.Base.abbrev_map  = {
"	\	"^G" : [
"	\		"~/mnt-ssh/freebsddev/svnwork/gLink/src/php",
"	\	],
"	\	"^I" : [
"	\		"~/mnt-ssh/freebsddev/svnwork/ichiro",
"	\	],
"	\}
"endif

"=== taglist ===
let g:Tlist_WinWidth=40

"=== autocomplpop ================


"=== howm ================
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

" skk
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

"Calendar

"eblookの設定
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

" showmarksの設定
let g:showmarks_enable = 1
let g:showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

" DirDiff
let g:DirDiffExcludes = "CVS,*.class,*.exe,.*.swp,.svn"

" migemoの設定
if has('migemo')
	set migemo
endif

" format.vimの設定
let format_join_spaces = 2
let format_allow_over_tw = 0

" gdb
"set previewheight=12
"run macros/gdb_mappings.vim
"set asm=0
"set gdbprg=gdb

" yankringの設定
let g:yankring_history_file = 'tmpfs/yankring_history'

set t_Co=256

" ここでgui版じゃないcolorschemeを設定。.gvimrcで再定義しなければgvimでも使われる。
"colorscheme xterm16
"let xterm16_brightness = 'soft'

"colorscheme midnight2
colorscheme xterm16

"hi Normal ctermfg=248 ctermbg=none

vmap _ :w !pbcopy<CR><CR>
"vmap _ :w !nkf -Ws \|pbcopy<CR><CR>
"

" TODO: Hack #171(http://vim-users.jp/2010/09/hack171/): 編集している関数名を表示する

