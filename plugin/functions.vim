" --------------------------------------------------------------
" PRIVATE FUNCTIONS
" --------------------------------------------------------------
function s:ErrorMsgHeader()
    " Do not use echoerr("message") because this actually throws an error
    echohl ErrorMsg
    echo "Invalid syntax!"
    echohl None
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

function s:LineError()
    call s:ErrorMsgHeader()
    echo "The <start-line> value must not exceed the <end-line> value."
endfunction

" --------------------------------------------------------------
" PUBLIC FUNCTIONS
" --------------------------------------------------------------
function ReplaceInAllFiles(input, output, scope)
    if a:scope == '*'
        arg *                " add all files in current directory
        argdo execute '%s/' . a:input . '/' . a:output. '/ge' | update
    elseif a:scope == '**'   " add all files in current and sub directories
        arg **
        argdo execute '%s/' . a:input . '/' . a:output. '/ge' | update
    else
        call s:ReplaceInAllFilesHelp()
    endif
endfunction

function Insert(character, ...)
    if a:0 == 0
        execute '%s/^/' . a:character. '/g'
    elseif a:0 == 1
        call s:InsertHelp()
    elseif a:0 == 2
        let start_line = str2nr(a:1)
        let end_line = str2nr(a:2)
        if start_line <= end_line
            execute start_line . ',' . end_line . 's/^/' . a:character . '/g'
        else
            call s:LineError()
        endif
    endif
endfunction

function Delete(start_line, end_line)
    let start_line = str2nr(a:start_line)
    let end_line = str2nr(a:end_line)

    if start_line <= end_line
        execute start_line . ',' . end_line . 'd'
    else
        call s:LineError()
    endif
endfunction

function Indent(start_line, end_line)
    let start_line = str2nr(a:start_line)
    let end_line = str2nr(a:end_line)

    if start_line <= end_line
        execute start_line . ',' . end_line . 's/^/    /g'
    else
        call s:LineError()
    endif
endfunction

function Copy(start_line, end_line, position)
    let start_line = str2nr(a:start_line)
    let end_line = str2nr(a:end_line)
    let position = str2nr(a:position)

    if start_line <= end_line
        execute start_line . ',' . end_line . 't' . position
    else
        call s:LineError()
    endif
endfunction

function RemoveWhiteSpace()
    execute '%s/\s\+$//g'
endfunction

function RemoveWhiteSpaceBeforeLine(start_line, end_line)
    let start_line = str2nr(a:start_line)
    let end_line = str2nr(a:end_line)

    if start_line <= end_line
        execute start_line . ',' . end_line . 's/^\s\+//g'
    else
        call s:LineError()
    endif
endfunction

function Move(start_line, end_line, position)
    let start_line = str2nr(a:start_line)
    let end_line = str2nr(a:end_line)
    let position = str2nr(a:position)

    if start_line <= end_line
        execute start_line . ',' . end_line . 'm' . position
    else
        call s:LineError()
    endif
endfunction

function Paste()
    normal! "+p
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

function Block(input_filename, start_line, end_line)
    let start_line = str2nr(a:start_line)
    let end_line = str2nr(a:end_line)

    if start_line < 0 || end_line < 0
        echohl ErrorMsg
        echo "Start and end lines must be greater than 0"
        echohl None
        return
    endif

    if start_line > end_line
        echohl ErrorMsg
        echo "Start line cannot be greater than end line"
        echohl None
        return
    endif

    if !filereadable(a:input_filename)
        echohl ErrorMsg
        echo "File " . a:input_filename . " does not exist!"
        echohl None
        return
    endif

    let line_count = str2nr(system("wc -l " . a:input_filename . " | awk '{print $1}'"))
    if end_line > line_count
        echohl ErrorMsg
        echo "End line exceeds file line count!"
        echohl None
        return
    endif

    " Note that vimscript automatically coerces str to int
    let offset = end_line - start_line + 1
    let block = "head -n " . a:end_line . " " . a:input_filename . " | tail -n " . offset

    echo "Running command: " . block
    let stdout = split(system(block), "\n")
    call add(stdout, "")
    call append('.', stdout)
endfunction

function Help()
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
    echo ":Block  -> Insert a block of text from another file"
    echo "=========================================================="
endfunction
