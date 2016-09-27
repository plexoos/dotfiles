set t_Co=16 " number of colors

" pathogen.vim makes it super easy to install plugins and runtime files in their own private directories
execute pathogen#infect()

syntax enable
set background=dark
let g:solarized_termcolors= 16
let g:solarized_termtrans = 1
let g:solarized_contrast  = "high"
colorscheme solarized

map <C-k> I//<ESC>j
map ! ^xxj

"set paste               " good formatting when paste from a X window buffer with a mouse
set nocompatible        " Use Vim defaults (much better!)
set bs=2                " allow backspacing over everything in insert mode
set autoindent          " always set autoindenting on
set cindent
set smartindent
set viminfo='20,\"5000  " read/write a .viminfo file, don't store more than 5000 lines of registers
set history=500         " keep 500 lines of command line history
set ruler               " show the cursor position all the time
set autochdir           " follow current/selected file directory

" I don't like how the automatic indentation works in cmake files
autocmd BufRead,BufNewFile *.cmake,CMakeLists.txt,*.cmake.in set nocindent

" Turn swap files ON
if isdirectory($HOME."/.vim-swap") == 0
   :silent !mkdir -p ~/.vim-swap
endif
set swapfile
set directory=~/.vim-swap//

" Turn backup files ON
if isdirectory($HOME."/.vim-backup") == 0
   :silent !mkdir -p ~/.vim-backup
endif
set backup
set backupdir=~/.vim-backup//

" Turn undofiles ON
if isdirectory($HOME."/.vim-undo") == 0
   :silent !mkdir -p ~/.vim-undo
endif
set undofile
set undodir=~/.vim-undo//

set hlsearch
set mouse=a
set t_kD=[3~       " has something to do with the delete or backspace keys ?
set noexpandtab
set tabstop=3
set shiftwidth=3
set nosmarttab
set list listchars=eol:$,tab:\|\ ,trail:.,extends:&
set nolist
set sessionoptions+=globals,resize,winpos
set number
set ignorecase
set smartcase
set wildmode=list:longest
set textwidth=120
set formatoptions=tcroql12
set incsearch
set shortmess+=A
set foldmethod=syntax
set foldnestmax=1

map <F2> :ls<CR>:b
map <F3> a<C-R>=strftime("%d %b %Y")<CR><Esc>
map <F4> a<C-R>=strftime(" (%X) ")<CR><Esc>
map <F5> <Plug>ShowSpecialCharacters
map <F6> <Plug>Reindent
map <F7> <Plug>DiffThis
map <S-F7> :TagbarToggle<CR>

command! TrimAndExpand :call TrimAndExpand()

" DoxygenToolkit settings (http://www.vim.org/scripts/script.php?script_id=987)
let g:DoxygenToolkit_authorName="Dmitri Smirnov <d.s@plexoos.com>"

set statusline=%f\ %h%m%r%w\ b%n
set diffopt+=iwhite

" vim-airline settings
set laststatus=2
let g:airline_theme = 'sol'
let g:airline_section_c = '%F %h%m%r%w b%n'
" Prevent airline status line from being truncated when windows split vertically
let g:airline#extensions#default#section_truncate_width = {}
