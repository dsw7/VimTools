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
nnoremap ss :call NumberToggle()<CR>

" ===========================================================================================================
" Functions
" ===========================================================================================================
function ColumnToggle()
  if (&cursorcolumn == 1)
    set nocursorcolumn
  else
    set cursorcolumn
  endif
endfunction

function Insert(char, ...)
  if a:0 == 2
    execute a:1 . ',' . a:2 . 's/^/' . a:char . '/g'
  else
    echoerr 'Function takes either 0 or 2 arguments'
  endif
endfunction

function NumberToggle()
  if (&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunction

function HandleNoWhiteSpaceError(exception)
  if stridx(a:exception, 'E486: Pattern not found') == -1
    echoerr a:exception
  else
    echo 'No whitespace found!'
  endif
endfunction

function RemoveWhiteSpace()
  try
    execute '%s/\s\+$//g'
  catch
    call HandleNoWhiteSpaceError(v:exception)
  endtry
endfunction

function RemoveWhiteSpaceBeforeLines(start_line, end_line)
  try
    execute a:start_line . ',' . a:end_line . 's/^\s\+//g'
  catch
    call HandleNoWhiteSpaceError(v:exception)
  endtry
endfunction

function OpenGPTifierResults()
  let l:results_file = expand('~') . '/.gptifier/completions.gpt'

  if filereadable(l:results_file)
    execute 'vs' . l:results_file
  else
    echoerr l:results_file . ' does not exist'
  endif
endfunction

function RunGPTifier(prompt)
  let l:command = 'gpt short --prompt="' . a:prompt . '"'
  let l:output = system(l:command)
  vnew

  setlocal buftype=nofile
  setlocal bufhidden=wipe
  setlocal noswapfile

  if (v:shell_error == 0)
    call setline(1, split(l:output, '\n'))
  else
    call setline(1, 'An error occurred when running GPTifier!')
    call setline(2, split(l:output, '\n'))
  endif

  normal! gg
endfunction

function! OpenGPTPrompt()
  vnew
  setlocal buftype=nofile
  setlocal bufhidden=wipe
  setlocal noswapfile

  call setline(1, '>>> GPTifier')
  call setline(2, '>>> Input a prompt on line 3 onwards:')
  call setline(3, 'What is 2 + 2?')

  normal! G
endfunction

function! ProcessGPTPrompt()
  normal! gg"ayG

  let l:full_text = split(@a, '\n')
  let l:header = l:full_text[0]

  if l:header !=# '>>> GPTifier'
    echoerr 'Not a GPT prompt. Cannot proceed!'
    return
  endif

  let l:prompt = join(l:full_text[2:], '\n')

  let l:command = 'gpt short --prompt="' . l:prompt . '"'
  let l:output = system(l:command)

  vnew
  setlocal buftype=nofile
  setlocal bufhidden=wipe
  setlocal noswapfile

  if (v:shell_error == 0)
    call setline(1, split(l:output, '\n'))
  else
    call setline(1, 'An error occurred when running GPTifier!')
    call setline(2, split(l:output, '\n'))
  endif

  normal! gg
endfunction

" ===========================================================================================================
" Commands
" ===========================================================================================================

" Clear highlighting
command Cls noh

" Toggle a cursor column
command Col call ColumnToggle()

" Remove all whitespace
command Ws call RemoveWhiteSpace()

" Insert a character at the beginning of line
command -nargs=+ Ins call Insert(<f-args>)

" Remove all whitespace before lines
command -nargs=+ Wl call RemoveWhiteSpaceBeforeLines(<f-args>)

" Open GPTifier results file
command G call OpenGPTifierResults()

" Run GPTifier
command -nargs=1 Gpt call RunGPTifier(<q-args>)

" Open a window (let's call it S) for inputting a GPTifier prompt
command S call OpenGPTPrompt()

" Open a window (let's call it P) for processing the prompt from window S
command P call ProcessGPTPrompt()
