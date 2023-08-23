" Turn on color syntax
syntax on

" Set command bar height
set cmdheight=1

" Set colorscheme
colorscheme desert

" Allow vim to identify specific file types
filetype plugin indent on

" Tabbing
set shiftwidth=2 " Otherwise vim will indent by one tab of 8 spaces
set tabstop=4
set softtabstop=4
set expandtab

" Set line numbers and set the number color
set number
set numberwidth=2
highlight LineNr ctermfg=lightgreen

" Always show command
set showcmd

" Set a cursor line
" Note that this can make vim slow
set cursorline

" Set default cursorcolumn highlighting in case user calls :Col
highlight CursorColumn ctermbg=234

" Enable autocompletion of vim commands
set wildmenu

" Do not redraw the screen when running a macro
set lazyredraw

" Enable parenthesis matching and customize colors
set showmatch
highlight MatchParen cterm=none ctermbg=darkgrey ctermfg=black

" Enable searching
set incsearch " highlight as soon as typing begins
set hlsearch " highlight the search results

" Set comment color
highlight Comment ctermfg=darkgrey

" Disable line wrapping
set nowrap

" Disable swap files
set noswapfile

" Split buffer on right when running :vsplit
set splitright

" Split buffer below when running :split
set splitbelow

" Set spellcheck (English by default)
" set spell

" Set a column for ensuring lines do not exceed some number of characters
set colorcolumn=110
highlight ColorColumn ctermbg=232

" Disable annoying mouse = a
set mouse=

" Uncomment this setting to prevent vim from starting in REPLACE mode
" See https://superuser.com/questions/1284561/why-is-vim-starting-in-replace-mode
" set t_u7=
