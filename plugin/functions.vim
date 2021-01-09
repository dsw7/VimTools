" --------------------------------------------------------------
" PRIVATE FUNCTIONS
" --------------------------------------------------------------
function s:ErrorMsgHeader()
    " Do not use echoerr("message") because this actually throws an error
    echohl ErrorMsg
    echo "Invalid syntax!"
    echohl None
endfunction

function s:ReplaceHelp()
    call s:ErrorMsgHeader()
    echo "Usage:"
    echo "  1. Search for <foo> using Shift + 3 or /"
    echo "  2. Type :S <bar>"
    echo "This will replace all occurrences of <foo> with <bar>"
    echo "A range of lines can also be specified:"
    echo "  1. Search for <foo> using Shift + 3 or /"
    echo "  2. Type :S <bar> <start-line> <end-line>"
    echo "This will replace all occurrences of <foo> with <bar> between <start-line> and <end-line>"
endfunction

function s:ReplaceInAllFilesHelp()
    call s:ErrorMsgHeader()
    echo "Valid syntax follows:"
    echo ":SubAll <foo> <bar> <*|**>"
endfunction

function s:InsertHelp()
    call s:ErrorMsgHeader()
    echo "Valid syntax follows:"
    echo ":Ins <foo>"
    echo ":Ins <foo> <start-line> <end-line>"
endfunction

function s:DeleteHelp()
    call s:ErrorMsgHeader()
    echo "Valid syntax follows:"
    echo ":Del <start-line> <end-line>"
endfunction

function s:IndentHelp()
    call s:ErrorMsgHeader()
    echo "Valid syntax follows:"
    echo ":Ind <start-line> <end-line>"
endfunction

function s:CopyHelp()
    call s:ErrorMsgHeader()
    echo "Valid syntax follows:"
    echo ":Cp <start-line> <end-line> <destination-line>"
endfunction

function s:RemoveWhiteSpaceHelp()
    call s:ErrorMsgHeader()
    echo "Function takes no arguments."
endfunction

function s:RemoveWhiteSpaceBeforeLineHelp()
    call s:ErrorMsgHeader()
    echo "Valid syntax follows:"
    echo ":Wl <start-line> <end-line>"
endfunction

function s:MoveHelp()
    call s:ErrorMsgHeader()
    echo "Valid syntax follows:"
    echo ":Mv <start-line> <end-line> <destination-line>"
endfunction

function s:PasteHelp()
    call s:ErrorMsgHeader()
    echo "Function takes no arguments."
endfunction

function s:HelpHelp()
    call s:ErrorMsgHeader()
    echo "Function takes no arguments."
endfunction

function s:HeaderHelp()
    call s:ErrorMsgHeader()
    echo "Valid syntax follows:"
    echo ":Header <my-header-text>"
    echo ":Header <my-header-text> <padding>"
endfunction

function s:LineError()
    call s:ErrorMsgHeader()
    echo "The <start-line> value must not exceed the <end-line> value."
endfunction

" --------------------------------------------------------------
" PUBLIC FUNCTIONS
" --------------------------------------------------------------
function Replace(output, ...)
    if a:0 == 0                  " a:0 = number of unspecified arguments (...)
        execute '%s/' . escape(getreg('/'), '/') . '/' . a:output . '/g'
    elseif a:0 == 1              " a:0 = 1 if only the start argument passed
        call s:ReplaceHelp()     " s:Foobar() <- the s: indicates that Foobar is local to this file
    elseif a:0 == 2              " a:0 = 2 if start and end line numbers are passed
        let start = str2nr(a:1)  " a:1 = the first optional value
        let end = str2nr(a:2)    " a:2 = the second optional value
        if start <= end
            execute start . ',' . end . 's/' . escape(getreg('/'), '/') . '/' . a:output . '/g'
        else
            call s:LineError()
        endif
    elseif a:0 > 2               " a:0 > 2 if only the start, end and some other arg passed
        call s:ReplaceHelp()
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
            call s:ReplaceInAllFilesHelp()
        endif
    else
        call s:ReplaceInAllFilesHelp()
    endif
endfunction

function Insert(char, ...)
    if a:0 == 0
        execute '%s/^/' . a:char. '/g'
    elseif a:0 == 1
        call s:InsertHelp()
    elseif a:0 == 2
        let start = str2nr(a:1)
        let end = str2nr(a:2)
        if start <= end
            execute start . ',' . end . 's/^/' . a:char . '/g'
        else
            call s:LineError()
        endif
    elseif a:0 > 2
        call s:InsertHelp()
    endif
endfunction

function Delete(...)
    if a:0 == 2
        let start = str2nr(a:1)
        let end = str2nr(a:2)
        if start <= end
            execute start . ',' . end . 'd'
        else
            call s:LineError()
        endif
    else
        call s:DeleteHelp()
    endif
endfunction

function Indent(...)
    if a:0 == 2
        let start = str2nr(a:1)
        let end = str2nr(a:2)
        if start <= end
            execute start . ',' . end . 's/^/    /g'
        else
            call s:LineError()
        endif
    else
        call s:IndentHelp()
    endif
endfunction

function Copy(...)
    if a:0 == 3
        let start = str2nr(a:1)
        let end = str2nr(a:2)
        let position = str2nr(a:3)
        if start <= end
            execute start . ',' . end . 't' . position
        else
            call s:LineError()
        endif
    else
        call s:CopyHelp()
    endif
endfunction

function RemoveWhiteSpace(...)
    if a:0 > 0
        call s:RemoveWhiteSpaceHelp()
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
            call s:LineError()
        endif
    else
        call s:RemoveWhiteSpaceBeforeLineHelp()
    endif
endfunction

function Move(...)
    if a:0 == 3
        let start = str2nr(a:1)
        let end = str2nr(a:2)
        let position = str2nr(a:3)
        if start <= end
            execute start . ',' . end . 'm' . position
        else
            call s:LineError()
        endif
    else
        call s:MoveHelp()
    endif
endfunction

function Paste(...)
    if a:0 > 0
        call s:PasteHelp()
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
        call s:HeaderHelp()
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

function ColumnToggle()
    if(&cursorcolumn == 1)
        set nocursorcolumn
    else
        set cursorcolumn
    endif
endfunction

function Help(...)
    if a:0 > 0
        call s:HelpHelp()
    else
        echo "List of commands:"
        echo "=========================================================="
        echo ":Cls    -> Clear a search"
        echo ":Ws     -> Remove all whitespace"
        echo ":Wl     -> Remove all whitespace before a set of lines"
        echo ":Cp     -> Copy a block of lines"
        echo ":Ind    -> Indent by 4 spaces"
        echo ":Del    -> Delete between a range of lines"
        echo ":Ins    -> Insert a delimiter at beginning of lines"
        echo ":S      -> Replace a string in current file"
        echo ":SubAll -> Replace a string in many files"
        echo ":Mv     -> Move a block of text"
        echo ":Paste  -> Paste a block of text from system clipboard"
        echo ":Col    -> Toggle cursorcolumn"
        echo ":Header -> Create a header"
        echo "=========================================================="
    endif
endfunction