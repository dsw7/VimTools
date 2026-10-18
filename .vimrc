" ===========================================================================================================
" David Weber
" See https://github.com/dsw7/VimTools for more information
" ===========================================================================================================

" ===========================================================================================================
" Settings
" ===========================================================================================================

" Turn on color syntax
syntax on

" Set command bar height
set cmdheight=1

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
highlight CursorLine cterm=NONE ctermbg=233

" Set default cursorcolumn highlighting in case user calls :Col
highlight CursorColumn ctermbg=234

" Enable tab completion of paths / filenames
set wildmode=longest,list,full

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

" Set relative line numbers by default
set relativenumber

" Uncomment this setting to prevent vim from starting in REPLACE mode
" See https://superuser.com/questions/1284561/why-is-vim-starting-in-replace-mode
" set t_u7=

" ===========================================================================================================
" Mappings
" ===========================================================================================================

" Automatically close braces
inoremap {<CR> {<CR>}<Esc>ko<tab>

" Automatically close brackets
inoremap [<CR> [<CR>]<Esc>ko<tab>

" Automatically close parentheses
inoremap (<CR> (<CR>)<Esc>ko<tab>

" Use jj to esc
inoremap jj <Esc>l

" Use a to jump to end of word and insert
nnoremap a f<Space>i

" Use C-{hjkl} to move around while in insert mode
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

" Jump to beginning of line
" Note that you can also just use _
nnoremap ff 0w

" Remap PGUP and PGDN to slide viewport
nnoremap <PageDown> <C-d>
nnoremap <PageUp> <C-u>

" Jump between :vsplit (:vs) or :split (:sp) splits
nnoremap tt <C-w>w

" Toggle between absolute and relative line numbering
nnoremap ss :call g:NumberToggle()<CR>

" ===========================================================================================================
" Functions
" ===========================================================================================================
function s:ColumnToggle()
  if &cursorcolumn == 1
    set nocursorcolumn
  else
    set cursorcolumn
  endif
endfunction

function g:NumberToggle()
  if &relativenumber == 1
    set norelativenumber
  else
    set relativenumber
  endif
endfunction

function s:HandleNoWhiteSpaceError(exception)
  if stridx(a:exception, 'E486: Pattern not found') == -1
    echoerr a:exception
  else
    echo 'No whitespace found!'
  endif
endfunction

function s:RemoveWhiteSpace()
  try
    execute '%s/\s\+$//g'
  catch
    call s:HandleNoWhiteSpaceError(v:exception)
  endtry
endfunction

function s:OpenGPTifierResults()
  let l:results_file = expand('~') . '/.gptifier/completions.gpt'

  if filereadable(l:results_file)
    execute 'vs' . l:results_file
  else
    echoerr l:results_file . ' does not exist'
  endif
endfunction

let s:comment_delimiters = {
  \ 'py': '#',
  \ 'rs': '//',
  \ 'js': '//',
  \ 'ts': '//',
  \ 'jsx': '//',
  \ 'tsx': '//',
  \ 'c': '//',
  \ 'cpp': '//',
  \ 'cc': '//',
  \ 'h': '//',
  \ 'hpp': '//',
  \ 'java': '//',
  \ 'go': '//',
  \ 'rb': '#',
  \ 'sh': '#',
  \ 'bash': '#',
  \ 'zsh': '#',
  \ 'vim': '"',
  \ 'lua': '--',
  \ 'sql': '--',
  \ 'php': '//',
  \ 'swift': '//',
  \ 'kt': '//',
  \ 'scala': '//',
  \ 'r': '#',
  \ }

function g:CommentOutLines() range
  let l:extension = expand('%:e')
  let l:delimiter = get(s:comment_delimiters, l:extension, '//')

  let l:start_line = a:firstline
  let l:end_line = a:lastline

  for l:line_num in range(l:start_line, l:end_line)
    let l:line_content = getline(l:line_num)
    call setline(l:line_num, l:delimiter . ' ' . l:line_content)
  endfor
endfunction

function! g:UncommentLines() range
  let l:extension = expand('%:e')
  let l:delimiter = get(s:comment_delimiters, l:extension, '//')

  let l:start_line = a:firstline
  let l:end_line = a:lastline
  let l:escaped_delimiter = escape(l:delimiter, '*/\^$.~[]')

  for l:line_num in range(l:start_line, l:end_line)
    let l:line_content = getline(l:line_num)
    let l:uncommented = substitute(l:line_content, '\v^\s*' . l:escaped_delimiter . ' ?', '', '')
    call setline(l:line_num, l:uncommented)
  endfor
endfunction

" ===========================================================================================================
" Commands
" ===========================================================================================================

" Clear highlighting
command Cls noh

" Toggle a cursor column
command Col call s:ColumnToggle()

" Remove all whitespace
command Ws call s:RemoveWhiteSpace()

" Open GPTifier results file
command G call s:OpenGPTifierResults()

" Comment lines in and out
command -range C <line1>,<line2>call g:CommentOutLines()
command -range U <line1>,<line2>call g:UncommentLines()
