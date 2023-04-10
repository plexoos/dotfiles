" ---------------------------------------------------------------------
"  Load Once:
"if exists("g:loaded_codeFormat") || &cp
"  finish
"endif
let g:loaded_codeFormat = 1

" ---------------------------------------------------------------------
" Public Interface:
if !hasmapto('<Plug>ShowSpecialCharacters')
  map <unique> <Leader>cf <Plug>ShowSpecialCharacters
endif

map <script> <Plug>ShowSpecialCharacters :call <SID>ShowSpecialCharacters()<CR>
map <script> <Plug>DiffThis :call <SID>DiffThis()<CR>
map <script> <Plug>Reindent :call <SID>Reindent()<CR>

" ---------------------------------------------------------------------

" ShowSpecialCharacters: this function ...
function! <SID>ShowSpecialCharacters()
	if &list == 1
		set nolist
	else
		set list
	endif
endfunction

" DiffThis: this function ...
function! <SID>DiffThis()
	if &diff
		execute ":set noscrollbind"
		execute ":set nocursorbind"
		execute ":set foldcolumn=0"
		set nodiff
	else
		execute ":diffthis"
	endif
endfunction

" Reindent: this function ...
function! <SID>Reindent()
	let currentLine = line(".")
	"execute ":%s/^\([	]*\)[ ]\{4}/\1	/g"
	:%s/^\([	]*\)[ ]\{4}/\1	/
	"if &list == 1
	"	set nolist
	"else
	"	set list
	"endif
	execute ":".currentLine
endfunction

" TrimAndExpand: this function ...
function! TrimAndExpand()
	let currentLine = line(".")
	"echo line
	execute ":%s/[ 	]*$//g"
	execute ":set expandtab"
	execute ":retab"
	execute ":".currentLine
endfunction

