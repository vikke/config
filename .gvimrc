set nohlsearch
if has("win32")
	set guifont=MS_Gothic:h10:cSHIFTJIS
	set printfont=MS_Gothic:h10:cSHIFTJIS
elseif has('osx')
    set guifont=Menlo\ Regular:h16 
elseif has("unix")
	set guifont=MaruGoR\-AA\ 8
endif
"set noimdisableactivate
winpos 0 0
set lines=64 columns=180
set cmdheight=2

" gvim用のcolorschemeを設定。vimには影響が出ない。
"colorscheme midnight2
"colorscheme oceandeep
"colorscheme midnight2
"colorscheme darkblue
