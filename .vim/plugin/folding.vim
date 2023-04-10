"Here's a function to toggle the use of syntax-based folding for a c/c++/java file. It also handles folding markers.

function! <SID>OutlineToggle()
let OldLine = line(".")
let OldCol = virtcol(".")
if (! exists ("b:outline_mode"))
let b:outline_mode = 0
let b:OldMarker = &foldmarker
endif


if (b:outline_mode == 0)
let b:outline_mode = 1
set foldmethod=marker
set foldmarker={,}
silent! exec "%s/{{{/{<</"
silent! exec "%s/}}}/}>>/"
set foldcolumn=4
else
let b:outline_mode = 0
set foldmethod=marker
let &foldmarker=b:OldMarker
silent! exec "%s/{<</{{{/"
silent! exec "%s/}>>/{{{/"
set foldcolumn=0
endif

execute "normal! ".OldLine."G"
execute "normal! ".OldCol."|"
unlet OldLine
unlet OldCol
execute "normal! zv"
endfunction

"*****************************************************************
"* Commands
"*****************************************************************
:command! -nargs=0 FOLD call <SID>OutlineToggle()
" End of code 
