" --------------------------------------------------------------
" SETTINGS
" --------------------------------------------------------------
syntax on

" set command bar height
set cmdheight=1

" show status line
" set ls=2

" set colorscheme
colorscheme desert

" tabbing
set tabstop=4
set softtabstop=4
set expandtab

" set line numbers and set the number color
set number
set relativenumber
set numberwidth=2
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
highlight Comment ctermfg=darkgrey


" --------------------------------------------------------------
" HELP FUNCTIONS
" --------------------------------------------------------------
function ReplaceHelp()
echohl ErrorMsg
echom "Invalid syntax!"
echohl None
echom "Usage:"
echom "  1. Search for <foo> using Shift + 3 or /"
echom "  2. Type :S <bar>"
echom "This will replace all occurrences of <foo> with <bar>"
echom "A range of lines can also be specified:"
echom "  1. Search for <foo> using Shift + 3 or /"
echom "  2. Type :S <bar> <start-line> <end-line>"
echom "This will replace all occurrences of <foo> with <bar> between <start-line> and <end-line>"
endfunction

function ReplaceInAllFilesHelp()
echohl ErrorMsg
echom "Invalid syntax!"
echohl None
echom "Valid syntax follows:"
echom ":SubAll <foo> <bar> <*|**>"
endfunction

function InsertHelp()
echohl ErrorMsg
echom "Invalid syntax!"
echohl None
echom "Valid syntax follows:"
echom ":Ins <foo>"
echom ":Ins <foo> <start-line> <end-line>"
endfunction

function DeleteHelp()
echohl ErrorMsg
echom "Invalid syntax!"
echohl None
echom "Valid syntax follows:"
echom ":Del <start-line> <end-line>"
endfunction

function IndentHelp()
echohl ErrorMsg
echom "Invalid syntax!"
echohl None
echom "Valid syntax follows:"
echom ":Ind <start-line> <end-line>"
endfunction

function CopyHelp()
echohl ErrorMsg
echom "Invalid syntax!"
echohl None
echom "Valid syntax follows:"
echom ":Cp <start-line> <end-line> <destination-line>"
endfunction

function RemoveWhiteSpaceHelp()
echohl ErrorMsg
echom "Invalid syntax!"
echohl None
echom "Function takes no arguments."
endfunction

function RemoveWhiteSpaceBeforeLineHelp()
echohl ErrorMsg
echom "Invalid syntax!"
echohl None
echom "Valid syntax follows:"
echom ":Wl <start-line> <end-line>"
endfunction

function MoveHelp()
echohl ErrorMsg
echom "Invalid syntax!"
echohl None
echom "Valid syntax follows:"
echom ":Mv <start-line> <end-line> <destination-line>"
endfunction

function PasteHelp()
echohl ErrorMsg
echom "Invalid syntax!"
echohl None
echom "Function takes no arguments."
endfunction

function HelpHelp()
echohl ErrorMsg
echom "Invalid syntax!"
echohl None
echom "Function takes no arguments."
endfunction

function HeaderHelp()
echohl ErrorMsg
echom "Invalid syntax!"
echohl None
echom "Valid syntax follows:"
echom ":Header <my-header-text>"
echom ":Header <my-header-text> <padding>"
endfunction

function LineError()
echohl ErrorMsg
echom "Invalid syntax!"
echohl None
echom "The <start-line> value must not exceed the <end-line> value."
endfunction


" --------------------------------------------------------------
" CUSTOM FUNCTIONS
" --------------------------------------------------------------
function Replace(output, ...)
if a:0 == 0                  " a:0 = number of unspecified arguments (...)
    execute '%s/' . escape(getreg('/'), '/') . '/' . a:output . '/g'
elseif a:0 == 1              " a:0 = 1 if only the start argument passed
    call ReplaceHelp()
elseif a:0 == 2              " a:0 = 2 if start and end line numbers are passed
    let start = str2nr(a:1)  " a:1 = the first optional value
    let end = str2nr(a:2)    " a:2 = the second optional value
    if start <= end
        execute start . ',' . end . 's/' . escape(getreg('/'), '/') . '/' . a:output . '/g'
    else
        call LineError()
    endif
elseif a:0 > 2               " a:0 > 2 if only the start, end and some other arg passed
    call ReplaceHelp()
endif
endfunction

function ReplaceInAllFiles(input, output, scope, ...)
if a:0 == 0
    if a:scope == '*'
        arg *                " add all files in current directory
        argdo execute '%s/' . a:input . '/' . a:output. '/ge' | update
    elseif a:scope == '**'   " add all files in current and sub directories
        arg **
        argdo execute '%s/' . a:input . '/' . a:output. '/ge' | update
    else
        call ReplaceInAllFilesHelp()
    endif
else
    call ReplaceInAllFilesHelp()
endif
endfunction

function Insert(char, ...)
if a:0 == 0
    execute '%s/^/' . a:char. '/g'
elseif a:0 == 1
    call InsertHelp()
elseif a:0 == 2
    let start = str2nr(a:1)
    let end = str2nr(a:2)
    if start <= end
        execute start . ',' . end . 's/^/' . a:char . '/g'
    else
        call LineError()
    endif
elseif a:0 > 2
    call InsertHelp()
endif
endfunction

function Delete(...)
if a:0 == 2
    let start = str2nr(a:1)
    let end = str2nr(a:2)
    if start <= end
        execute start . ',' . end . 'd'
    else
        call LineError()
    endif
else
    call DeleteHelp()
endif
endfunction

function Indent(...)
if a:0 == 2
    let start = str2nr(a:1)
    let end = str2nr(a:2)
    if start <= end
        execute start . ',' . end . 's/^/    /g'
    else
        call LineError()
    endif
else
    call IndentHelp()
endif
endfunction

function Copy(...)
if a:0 == 3
    let start = str2nr(a:1)
    let end = str2nr(a:2)
    let pos = str2nr(a:3)
    if start <= end
        execute start . ',' . end . 't' . pos
    else
        call LineError()
    endif
else
    call CopyHelp()
endif
endfunction

function RemoveWhiteSpace(...)
if a:0 > 0
    call RemoveWhiteSpaceHelp()
else
    execute '%s/\s\+$//g'
endif
endfunction

function RemoveWhiteSpaceBeforeLine(...)
if a:0 == 2
    let start = str2nr(a:1)
    let end = str2nr(a:2)
    if start <= end
        execute start . ',' . end . 's/^\s\+//g'
    else
        call LineError()
    endif
else
    call RemoveWhiteSpaceBeforeLineHelp()
endif
endfunction

function Move(...)
if a:0 == 3
    let start = str2nr(a:1)
    let end = str2nr(a:2)
    let pos = str2nr(a:3)
    if start <= end
        execute start . ',' . end . 'm' . pos
    else
        call LineError()
    endif
else
    call MoveHelp()
endif
endfunction

function Paste(...)
if a:0 > 0
    call PasteHelp()
else
    normal! "+p
endif
endfunction

function Header(...)
if a:0 == 1
    let padding = 5
elseif a:0 == 2
    let padding = str2nr(a:2)
else  " unreachable because blocked by -nargs=+ in COMMANDS section
    call HeaderHelp()
    return
endif
let strsize = strlen(a:1)
let hline = repeat('=', strsize + 2 * padding + 2)
let mid = repeat('=', padding)
let row = mid . ' ' . a:1 . ' ' . mid
call setline('.', [hline, row, hline, ''])
+3
endfunction

function NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber
    else
        set relativenumber
    endif
endfunction

function Help(...)
if a:0 > 0
    call HelpHelp()
else
    echom "List of commands:"
    echom "=========================================================="
    echom ":Cls    -> Clear a search"
    echom ":Ws     -> Remove all whitespace"
    echom ":Wl     -> Remove all whitespace before a set of lines"
    echom ":Cp     -> Copy a block of lines"
    echom ":Ind    -> Indent by 4 spaces"
    echom ":Del    -> Delete between a range of lines"
    echom ":Ins    -> Insert a delimiter at beginning of lines"
    echom ":S      -> Replace a string in current file"
    echom ":SubAll -> Replace a string in many files"
    echom ":Mv     -> Move a block of text"
    echom ":Paste  -> Paste a block of text from system clipboard"
    echom ":Header -> Create a header"
    echom "=========================================================="
endif
endfunction


" --------------------------------------------------------------
" COMMANDS
" --------------------------------------------------------------
command Cls :noh                                                   " Clear a search
command -nargs=? Ws     :call RemoveWhiteSpace(<f-args>)           " Remove all whitespace
command -nargs=+ Wl     :call RemoveWhiteSpaceBeforeLine(<f-args>) " Remove all whitespace before lines
command -nargs=+ Cp     :call Copy(<f-args>)                       " Copy a block of lines
command -nargs=+ Ind    :call Indent(<f-args>)                     " Indent by 4 spaces
command -nargs=+ Del    :call Delete(<f-args>)                     " Delete between a range of lines
command -nargs=+ Ins    :call Insert(<f-args>)                     " Insert a delimiter at beginning of lines
command -nargs=+ S      :call Replace(<f-args>)                    " Replace a string in current file
command -nargs=+ SubAll :call ReplaceInAllFiles(<f-args>)          " Replace a string in all files in working dir
command -nargs=+ Mv     :call Move(<f-args>)                       " Move a block of text
command -nargs=? Paste  :call Paste(<f-args>)                      " Paste text from system clipboard
command -nargs=+ Header :call Header(<f-args>)                     " Create some header text
command -nargs=? Help   :call Help(<f-args>)                       " Print a list of the preceding commands


" --------------------------------------------------------------
" MAPPINGS
" --------------------------------------------------------------
" Commands                        Mode
" --------                        ----
" nmap, nnoremap, nunmap          Normal mode
" imap, inoremap, iunmap          Insert and Replace mode
" vmap, vnoremap, vunmap          Visual and Select mode
" xmap, xnoremap, xunmap          Visual mode
" smap, snoremap, sunmap          Select mode
" cmap, cnoremap, cunmap          Command-line mode
" omap, onoremap, ounmap          Operator pending mode

" Automatically close braces
imap {<CR> {<CR>}<Esc>ko<tab>
" Automatically close brackets
imap [<CR> [<CR>]<Esc>ko<tab>
" Automatically close parentheses
imap (<CR> (<CR>)<Esc>ko<tab>
" Use jj to esc
imap jj <Esc>
" Use a to jump to end of word and insert
nmap a f<Space>i
" Use nt to toggle between absolute and relative numbering
nmap nt :call NumberToggle()<CR>


" --------------------------------------------------------------
" NOTES
" --------------------------------------------------------------
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
