" --------------------------------------------------------------
" SETTINGS
" --------------------------------------------------------------
syntax on

" set colorscheme
colorscheme desert 

" tabbing
set tabstop=4
set softtabstop=4
set expandtab

" set line numbers and set the number color
set number
hi LineNr ctermfg=lightgreen 

" always show command
set showcmd

" set a cursor line
set cursorline

" set a cursor column
" set cursorcolumn

" allow vim to identify specific file types
filetype indent on

" enable autocompletion of vim commands
set wildmenu

" do not redraw the screen when running a macro
set lazyredraw

" enable parenthesis matching and customize colors
set showmatch
hi MatchParen cterm=none ctermbg=darkgrey ctermfg=black

" or disable parenthesis matching
" let g:loaded_matchparen=1

" enable searching
set incsearch " highlight as soon as typing begins
set hlsearch " highlight the search results

" set comment color
hi Comment ctermfg=darkgrey

" automatically close braces
inoremap {<CR> {<CR>}<Esc>ko<tab>
inoremap [<CR> [<CR>]<Esc>ko<tab>
inoremap (<CR> (<CR>)<Esc>ko<tab>


" --------------------------------------------------------------
" CUSTOM COMMANDS
" --------------------------------------------------------------
" Some notes:
" :command -nargs=* Foo :echo "<args>"
" 1        2        3   4
"
" 1: always need to specify :command
" 2: specify number of arguments
"   -nargs=0    No arguments
"   -nargs=1    One argument
"   -nargs=*    Any number of arguments
"   -nargs=?    Zero or one argument
"   -nargs=+    One or more arguments
" 3: command name (needs to be capitalized)
" 4: the actual command to run


" Function for replacing text either throughout the file or
" between a range of lines
:function ReplaceHelp()
:echohl WarningMsg
:echom "-- Invalid syntax!"
:echohl None
:echom "Valid syntax follows:"
:echom ":Sub <foo> <bar>"
:echom ":Sub <foo> <bar> <start-line> <end-line>"
:echom "To replace strings with spaces like: 'foo bar' -> 'cat dog':"
:echom ":Sub foo\\ bar cat\\ dog"
:endfunction

:function Replace(input, output, ...)
:if a:0 == 0                  " a:0 = number of unspecified arguments (...)
:   execute '%s/' . a:input . '/' . a:output . '/g'
:elseif a:0 == 1              " a:0 = 1 if only the start argument passed
:   call ReplaceHelp()
:elseif a:0 == 2              " a:0 = 2 if start and end line numbers are passed
:   let start = a:1           " a:1 = the first optional value
:   let end = a:2             " a:2 = the second optional value
:   execute start . ',' . end . 's/' . a:input . '/' . a:output . '/g'
:elseif a:0 > 2               " a:0 > 2 if only the start, end and some other arg passed
:   call ReplaceHelp()
:endif
:endfunction

:command -nargs=+ Sub :call Replace(<f-args>)


" Function for adding some character at the beginning of every
" line between some range or in entire file
:function InsertHelp()
:echohl WarningMsg
:echom "-- Invalid syntax!"
:echohl None
:echom "Valid syntax follows:"
:echom ":Ins <foo>"
:echom ":Ins <foo> <start-line> <end-line>"
:endfunction

:function Insert(char, ...)
:if a:0 == 0
:   execute '%s/^/' . a:char. '/g'
:elseif a:0 == 1
:   call InsertHelp()
:elseif a:0 == 2
:   let start = a:1
:   let end = a:2
:   execute start . ',' . end . 's/^/' . a:char . '/g'
:elseif a:0 > 2
:   call InsertHelp()
:endif
:endfunction

:command -nargs=+ Ins :call Insert(<f-args>)


" Function for deleting numerous lines
:function DeleteHelp()
:echohl WarningMsg
:echom "-- Invalid syntax!"
:echohl None
:echom "Valid syntax follows:"
:echom ":Del <start-line> <end-line>"
:endfunction

:function Delete(...)
:if a:0 == 2
:   let start = a:1
:   let end = a:2
:   execute start . ',' . end . 'd'
:else
:   call DeleteHelp()
:endif
:endfunction

:command -nargs=+ Del :call Delete(<f-args>)


" Function for indenting code 4 spaces
:function IndentHelp()
:echohl WarningMsg
:echom "-- Invalid syntax!"
:echohl None
:echom "Valid syntax follows:"
:echom ":Ind <start-line> <end-line>"
:endfunction

:function Indent(...)
:if a:0 == 2
:   let start = a:1
:   let end = a:2
:   execute start . ',' . end . 's/^/    /g'
:else
:   call IndentHelp()
:endif
:endfunction

:command -nargs=+ Ind :call Indent(<f-args>)


" Function for copying blocks of text
:function CopyHelp()
:echohl WarningMsg
:echom "-- Invalid syntax!"
:echohl None
:echom "Valid syntax follows:"
:echom ":Cp <start-line> <end-line> <destination-line>"
:endfunction

:function Copy(...)
:if a:0 == 3 
:   let start = a:1
:   let end = a:2
:   let pos = a:3
:   execute start . ',' . end . 't' . pos
:else
:   call CopyHelp()
:endif
:endfunction

:command -nargs=+ Cp :call Copy(<f-args>)


" clear a search
:command Cls :noh
